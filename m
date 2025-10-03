Return-Path: <linux-kernel+bounces-841741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F32BB81B2
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 22:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F3054EF419
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 20:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090C9228CBC;
	Fri,  3 Oct 2025 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YG0Tytop"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7164E22D780
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759523377; cv=none; b=OX1aVXBNFJNU09f/+YIRho9vB+HjREV+Av+7jQFAFh8Qye0uPzPO7vONhLQ7QzmRlfWeHmGF5O0khJx+9WCSNSU3fDowTQ2zSChdjfYeBC38dCYS7YqET5iNzRoSDh+cEnzFDC6SU/6sqmIyIT46a7xbMZO+KMcKVjsKtvqaQ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759523377; c=relaxed/simple;
	bh=SuOGf6ig6UThy/Cts9AqHIbtylVDtns8fl8RhAUSMZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOBBdA2CSXny/+JuARuaDD0CkECnTxAAaDBC9R2JGuxK49YG+kig8pyiOCSMfSbpdccAN8NLIix/lB2N4h2GwHi45R2PAr5/VLyu0RNtLBHk3HESUBCHf/R6VRhqmEDUHvBPao/LUBG+lN8OFLvadX23yZVM3oqH1nQRA2jCpdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YG0Tytop; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-421851bca51so1738205f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 13:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759523374; x=1760128174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8BGUE0v7XRga+qkgvLP86a6O/SLAuOYc4ngsK7oGTUk=;
        b=YG0TytopFtukvAc6AOCqkN3jFCZjSQbVbonbkUdFZoSdPfPsu2jM7D/2gWDcsdqMHZ
         nX85yigXidryzzuJG6j3KTheUMo/SFYQJ8sQdIvlrVexaQzcPAMQxPJiOHao+O4eQJMj
         V1sHz7egbxAZ+8rfcNLNuy+A6j3aDgPaX4ohfkI8+7pIAOQVmgVpAApaC/iU+wOQkpFF
         UWOlQVE2L8mN0BmeqTPao9HQ5BfbYbZmYoCKCjpUI8irZyMPPtmOwLlN7Vpqubzvto6F
         qVEo/L9Qe+Rks8M8ev/aEPEpB0XIJD216xqncq8iJgUpzzKe6fsf6EYgOX/PlUd20zJR
         Qx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759523374; x=1760128174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BGUE0v7XRga+qkgvLP86a6O/SLAuOYc4ngsK7oGTUk=;
        b=t1wh5cA/bSc0mON5js5ID0yfgPQnF6M3cvKG7TYl3M8Mky7AZqg+ruUAorr2dmhr+u
         0AJa30HElM+FVZFuFf8q/SC44XJhLy1LIlJgFRpk17jfMYOialyZsAUWtCfTPKIacZNh
         rXoFPmwMCvQgpkpkDr0zezOCLOYTVz1cIJNQ/jfF2ZqgQIjEPydzbV0EjFSCSlpaMo2h
         ZMdvHGGNNdMGvJeJumWi9nPwUlsFkRz8n/vdtM4KBNjiaKnqJBan8K6lT2F0sxNbFUe/
         njxa2DVj17Om+1AA6irZUJIeokwVTJYqfCjylzACh4m25iOOfh7JZiEvj+RLusZ1g2JS
         J9Bw==
X-Gm-Message-State: AOJu0Yx6SjxngIuSRG7qYSips+Q1M3OWXMzhiToL4ITgD/AqIi/a26ig
	JiWMd3dwSpKBtUzouLnfdnq72kWV6SP8fIuDqYDCippG61utQAEllBazFJ2Pg+qAZ8E=
X-Gm-Gg: ASbGncuuHtaImKuilcint/o10gwulrFLKU3WadNP1q4VxlU+6rJz0+k3Dk7samfP/c4
	Yu+3WeWfZIr/7M6hH7h4GqvrYJUVw4rS0wONEK/DVv5ugewF7oLOCuxwuaq2Ne2EB1HMD1UwXpC
	SDwchoEZDj1In3RFwEBKnJx7aZpd69iqh9IW/GWQTbmFV5bhSdl2ldvsWY5jY/Dl3gwULHCtCBV
	A84WoWcMXPIZ2XubmxlGm7ZOHXtq3AbOQs/hBy4dKHxL9jgD+5uve2E6z5qWCJBsAXlOlKnCzFh
	b8Z1iImf340MZfqG5yjdPYNAPWKRTvO/TLw86ZY1E7IkhJcl6APJpMmqhsEmOHJhM+NYAB/cz2s
	UDy4gtYkohA4rEbZmLracHKG56fy6cQxmCl8PKr2+WL0TN5E+G5atSV4WKiN6tdzgJXE=
X-Google-Smtp-Source: AGHT+IH/bgx1fSGeKfmK7NrfWKs/RA99sx3ypoK059B/EoGdkmTKRCEZWYZj6hui2YkbxqO7xxGCRw==
X-Received: by 2002:a5d:588e:0:b0:3cf:74e0:55b9 with SMTP id ffacd0b85a97d-425671c71bbmr2893944f8f.63.1759523373488;
        Fri, 03 Oct 2025 13:29:33 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4255d8e9890sm9409932f8f.32.2025.10.03.13.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 13:29:32 -0700 (PDT)
Date: Fri, 3 Oct 2025 23:29:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mary Strodl <mstrodl@csh.rit.edu>
Cc: linux-kernel@vger.kernel.org, tzungbi@kernel.org,
	linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 3/4] gpio: mpsse: add quirk support
Message-ID: <aOAyKI7hv36oLJkD@stanley.mountain>
References: <20251003195036.3935245-1-mstrodl@csh.rit.edu>
 <20251003195036.3935245-4-mstrodl@csh.rit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003195036.3935245-4-mstrodl@csh.rit.edu>

On Fri, Oct 03, 2025 at 03:50:35PM -0400, Mary Strodl wrote:
> Builds out a facility for specifying compatible lines directions and
> labels for MPSSE-based devices.
> 
> * dir_in/out are bitmask of lines that can go in/out. 1 means
>   compatible, 0 means incompatible.
> * names is an array of line names which will be exposed to userspace.
> 
> Also changes the chip label format to include some more useful
> information about the device to help identify it from userspace.
> 
> Signed-off-by: Mary Strodl <mstrodl@csh.rit.edu>
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


