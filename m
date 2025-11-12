Return-Path: <linux-kernel+bounces-898116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E044CC54673
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B163A3A7A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5F32C08AD;
	Wed, 12 Nov 2025 20:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rt6rMFQ0"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27666258ECC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978548; cv=none; b=oLsK0KQ+vDmjwYpUHAd7CSd3p3QDOBLI7f/VDC1VcIF+U6bkp7BewsciumLC3S0s2O/os+XdVPPkjjuZCkEazSunxWmqpwi6LQfnGbEpwyJfv0GNytVyXezb7QBvmRL+zzQ/z6hWFeixG25j65p8hAqNb6B3jsPXjemOgz3qNFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978548; c=relaxed/simple;
	bh=b/+LHgWOgIQuiKCi0TXH65NYrcTwmWDQVaMJ5xM6n4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuKiLDVfChVOwYC0//OyYrJb4iLNjC2og8aGy4fKIoCc9YtqhabCmfv0vYpJQOwe0AxH9bQmsPkruM1NV3YJ/yJeNbqM46netPPLa7hV/9sSQaaOgsQT9qqIAQ1UxNPao6MJ4fS+XpT+tK/k3hTUl90vLBWW8wuzYFQuK+9Z3AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rt6rMFQ0; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b6dd81e2d4so31766b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762978546; x=1763583346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LcOVe8CCkbVixId45FxTIMUeNaTNkX9tAL+H6oibRkA=;
        b=Rt6rMFQ09e6xwbIKCgBzN0xTzITBTisQz2sKFFpVixcFnuEqWsHpnAtkIZKYFssxIo
         aNPWy6JxRprGK8+WK2UzNPUASXk28GVy7mB116P1fPaik/Hu1vtkN6NDx6p1hmQ4LM5t
         vxKWNvsjK/0LTfC+kn3ULGIWhvzyFXrfXQD72ZO1rCpOmJRQebQMTezvYnNnbUA4m9W6
         ZeIDKs82GAN6Sn9iKxhrPaZr6JulfVusiaKRRvXEEPJTYTddpiWXYXZClxLAvradroOi
         tRiEemIiOKFIDEO5Ffpz8t6/kU6dpAPEaO5nB0M+vx/KmFxTqpxFtAehXoTSFDSD6+QR
         nJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762978546; x=1763583346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LcOVe8CCkbVixId45FxTIMUeNaTNkX9tAL+H6oibRkA=;
        b=edQ7upToFaWhGIfUGboDQHhmoOQRnno3Aq2hRPXqKSVm2H5XmB6ZVOcnctJ+e3w4Dx
         VTLWT2Wo1w+GwcY5nbq/aOluNpTMAOpl+ZZpFbX26iAAR9oXwuA8kcTU4k3qM3k/XlIx
         phQ1Tm6SR6Clf4blXv1aWmx3ZHo94/aCDvnw5fmVLOHwgHZQD3qkv9fKzhkNVoH6XbHZ
         RNwjkge9s1bAfS9NcmuJ1fR4nY9KfFGdpBRVbVQdbEeydUeUupOmpAbIoavF/wHcgip1
         czXA2iMi5lQ7ZnxKFx9PND3Z5iBWOwUJP33kCGQlYw5g+UYndEYllSVUsDvQJAhltcEK
         Jh7g==
X-Forwarded-Encrypted: i=1; AJvYcCWzdrd4cgnMYgEfEv0u0bRcjMQf2cas3kAA6Xowpuc9zAlurExDL0Clo02/jyjAk8Ov3aw0P9BoZv6sgec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz38exntSEXdtohqk7viGNg2Z2D8WMthKYPKaKfFwGaPw3r8zw7
	Q3irwb+ud9VNCGWyOx4zYGgIEyIk7wyKj/CAIR/Mo1ZIEa9E/k7uv86w
X-Gm-Gg: ASbGncvahXbVlUiHFAtotuUu8zFALqSN4vbOQaAFiHDSwbUfkvlOpNK7cJ6dD7xZkbK
	dopeuD9W1trKNwsPTtiYpesv7bw9Y1mySKWxeYjQvv72lFbknOzGl1eHWcSOiELsLusyAmlPRGu
	iPcE/fDLMjja7Hn8Yvu8/n1jNQiTTP6RHUS5SL/6IAgO9g9c/S2mL3ILbvKoyk5lmxQ03kA/hAH
	eyCJEyjN2uAegtUDICocTjPrxdy7JRBfM8clr1VG//sBME+EcnOvs73CjOBL7Ronzf5iuVvo35g
	oDohWRuOrXxPsH2iZGndSodZHp9bYZNADyARqrgZOM+8+ZBbszChLxMloutxpFPDk4HjmcXA76B
	s4raiuC2+pWAcwEBZIyRhCL9/eUzPqwtaLIFDDHSGVLMbcTbPYy0VNFAGq74vjqQQjCY1hC0J5P
	2+J74Z+bbm+Qiw
X-Google-Smtp-Source: AGHT+IGDpmW2OFyTt0AExJhOr1pXz3yB3vqqvORgvHoBU6m6jddfpCeyCIdnOiAefOTQXrtnwy6leA==
X-Received: by 2002:a05:6a00:2d8b:b0:77c:6621:6168 with SMTP id d2e1a72fcca58-7b7a4fdc2ebmr4559665b3a.30.1762978546426;
        Wed, 12 Nov 2025 12:15:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b841192ef0sm2426539b3a.29.2025.11.12.12.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 12:15:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 12 Nov 2025 12:15:45 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Bruno Thomsen <bruno.thomsen@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: tmp421: remove duplicate return in switch-case
Message-ID: <1fbef22b-c9cd-46e8-8f45-fecef37dae70@roeck-us.net>
References: <20251111144406.7489-1-bruno.thomsen@gmail.com>
 <20251111144406.7489-2-bruno.thomsen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111144406.7489-2-bruno.thomsen@gmail.com>

On Tue, Nov 11, 2025 at 03:44:06PM +0100, Bruno Thomsen wrote:
> Use single read permission return in switch-case that handles
> attributes in tmp421_is_visible().
> 
> Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>

Applied.

Thanks,
Guenter

