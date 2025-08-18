Return-Path: <linux-kernel+bounces-772947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E585B299A9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5686C3BFB46
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EE3274B3E;
	Mon, 18 Aug 2025 06:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R3J54Pw7"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF40274B30
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755498580; cv=none; b=L1yljTrIRuzM2Bu/fMVEZGUNSftzu2n2wvgffgE+yZeJjctoRh2MiyjD1VnDjtTuDgoWyIv8Vgyn6YJHvNV5E1SRS+OmkrjwTkuTw1qzKCw106a516gYAOcDNJNzQiAZ6dPqUBUjng4SN2gpWGQg+T9BPY1qa9apyVq9vtGaexg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755498580; c=relaxed/simple;
	bh=5g0wbn6Ph17xvgAq5KvhX1KEiqUBS3GvRDxnv2BGP5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9yGcU6uDgFhJg1JhqGFxY7Z8sOo2hyh+illwXdq9kv6+aJNwk+TYFwulUSofAvrRTT/YMVRbR9JZywn64+DcgD6yHdS6cZVW9Fp7k54ontmxoihFxD0/NOkPPPEbV9wOn14no43xf5II/7mk0jeXuUSWMMmytUV4D8NqslvERs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R3J54Pw7; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3bb30c72433so1024248f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 23:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755498577; x=1756103377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+3tkiOT20kGsUTSkgr+xHio85hrWrVQxIwikWx+eXEg=;
        b=R3J54Pw7HrnCY/NY9e6PD7naRXa0JR+V4Uel8So/kGUyRoSq/Jx+YFBNBzhusO555d
         e3bSJYtB71XIIwHCX0bVHpmD2gsnEFRwB2UYoIHOj0vDkiAnrt5NIPXQycxp/4RY2XgI
         FwvPpmPupamcLpzNL1p6Che5pJVhWbNlVzUCCP9EaTuzNtB9zrgxEigAwVp3OVVTCJEw
         GeBpmjEyVLsXNJvsA4HUQfNTUW9fNMcsAkBPU80h5aZDka5qg23E9xXLf1ZcWdgiSdlb
         /OOIE2LlGc2ETR1HcVrfejReMAuYw0fg0jBc2h57/t9qAM3Fdfxw/fUNtU4pDwtGd7A8
         OYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755498577; x=1756103377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3tkiOT20kGsUTSkgr+xHio85hrWrVQxIwikWx+eXEg=;
        b=fwwNQHozzPyBMNbVFUdwC4HcncRhKdk/inme+v0F6krDUD9/oagFW5IWBIBTZCjXRv
         y89iBPUOgqMM0aBWKhsgIPKIe3WFhZ5DKF9Xv3LWZNBsEL4X/er6ob5EUzB71pKhErsl
         fM4bt/DFn+ZqSTJqxHrvsZi4M1bT1gsx9VhioVSTLYikzNxqxHOKvooBxoGSGy1Ppj+S
         OIq28BuK7IqAQiCP6Uoca7Doa8ii2ekGZ4XSOlfzJY8J9gdMNSXmyg/rYqHaVW5Zl8Sf
         S7Gx5sFSWw9OfrofkPAUTzQPc4vIrSJvZVQL3vYTebWDnszK+O8g7Tp0caVLW8hseM/U
         IzaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXqL/yt1x5UlfsZwiSoPRUrfs+0wo4wX5FsxV3SQ+FbwP5RJRXalGW+R+lGyUr4L4AAXJiGjCSf9X53jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOVe/ECZLhsuqcly2S6nXWOy7ZtE/BovWLbjeYTYgNq9SgSeQy
	8SMFdPzW08H8wFOQYOa/0t/gcPE6z9OyHTWOz0m3daIbAQCY5Jc1ITGxhOg5BmiY9+c=
X-Gm-Gg: ASbGncvGlKIQJBqyvq1vxMFZXPU/iNeU7WmCwx/4s4oL9qP1Qm8GMAmu7E4d+GYjLeM
	ZtTJOGFltwTNc353jULw0h+Nysdz/QugcHxHMLKKBpiZUJZxyuzdtRASbIrwhvTTxcRGAdDJ/hk
	2Ule6KbPOf3hkTDgNzsLJqxhmmRgH0ezih+CjwYLaqfsjVb9KmWVHGjH9BLKUR0yGSIj7RsZ/uS
	qTnmD9Le+X02pQ3RYrIcFYj+iJIo89D6jfJ9GXn139BLtgbMjzYiIqNmuK1DnbPIIDU3lE9dL7G
	5gZud90D/2grzFiXtmvUc6Va8ZaZDBQyJrhxS9k7gHkQ9ZqTFk/dX0IFdFcILG4oyJxye0hkevp
	qQ8txwSdW5vi4FYHK4owRUReSCRLuNrSwFIZqVQ==
X-Google-Smtp-Source: AGHT+IHndy6oVv4OJ+/MsKM5qa8MXzOeKQJV79th477YwHEuET0jW0JUWVhK0OGjN+EbNCIL5zw9Vg==
X-Received: by 2002:a5d:5f8f:0:b0:3b9:6e:5242 with SMTP id ffacd0b85a97d-3bb66567d13mr7922421f8f.4.1755498576770;
        Sun, 17 Aug 2025 23:29:36 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a223292d2sm123065385e9.21.2025.08.17.23.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 23:29:36 -0700 (PDT)
Date: Mon, 18 Aug 2025 09:29:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mohammed Guermoud <mohammed.guermoud@gmail.com>
Cc: marvin24@gmx.de, gregkh@linuxfoundation.org, ac100@lists.launchpad.net,
	linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: nvec: Silence unused argument warning in
 NVEC_PHD macro
Message-ID: <aKLITYYTOkMpNkQy@stanley.mountain>
References: <20250817192425.12983-1-mohammed.guermoud@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250817192425.12983-1-mohammed.guermoud@gmail.com>

On Sun, Aug 17, 2025 at 08:24:25PM +0100, Mohammed Guermoud wrote:
> The NVEC_PHD macro was defined with three arguments (str, buf, len)
> that were not used in its empty body, causing a compiler warning.
> 
> This patch silences the warning by explicitly casting the unused
> arguments to (void), making the intent clear without changing
> functionality.
> 
> Signed-off-by: Mohammed Guermoud <mohammed.guermoud@gmail.com>

What's the warning.  Does it break the build since we're using -Werror?

I feel like in the end, I'm going to say just ignore the compiler warning
since this is not a bug in the code but obviously if it breaks the build
then that's a different story.

regards,
dan carpenter


