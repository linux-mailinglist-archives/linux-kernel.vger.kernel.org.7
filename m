Return-Path: <linux-kernel+bounces-754225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67A8B19010
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 23:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71414AA00B8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 21:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C242561A8;
	Sat,  2 Aug 2025 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQOPwtb0"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F6173
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 21:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754169912; cv=none; b=m9X12SG+degP+Gq3JECiyxViX9E/VzuW5I8XqiwhIj6ifyEsfvkY5shNhM+kcCYJEAUgXtUOHElhR687LKiT1tuWEum97iRnBaqU9Y6VIUSaGKfgxDCeY1LLK+4OHpg0R0agTAaxVNNkQL938asdA+2FX94bPOerPAFGe/0f390=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754169912; c=relaxed/simple;
	bh=3gAMbXrlGsVjO/zWD+nHfXM5/lUAkZnFuWen+NXFj0U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r76lt6ji30Qy6KJ6Um+K3qSBd/q8hHku6KePiXRoTW3lSVbVRqbi5kp8AzQpegmNtVgVgUZXSG5xLTZRB1vM/KBb6tJeTtMakhJdsqhw1eJm6W5OeVJq1ynmK06W8l0cyocUPd/ohXxpPI3GjzjKi3V/SGVEnIgh4LfYsKfzc2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQOPwtb0; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-7074a74248dso30039426d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 14:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754169909; x=1754774709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cume3DFrFO7u3pL9Y1K1ypuZDFhhQLKijYnO66hZ+p0=;
        b=DQOPwtb0heQpqAlyBTwnDAwSoXY3lkPf0kCnnXIklOMdd3t9i/P1AI/yu6mIGwAj29
         S8ZZHgC9nVZNAz1QBrgG1vyZharlymo+LrxEfx0Y2uoGwJUf338H1CcUY8/pFnPMJBSJ
         XSXtoVIq6XcwgS7/nj2vNvgZ5CuPu9E6nwHXOfg9Bv3m4LJZrEvoNQ5oOaM1k3wuatX8
         FdGElkhcmgZN6gWIuYBcuPo6qtcnbdikYx/HSxrYCvoXVd930wa8UK4eaRCteIaXcqD3
         iOHacsFaEnmbqAaAx4I5fgVEHKCPf8rV0/Y3Kll9SDyYzDv3UnsyCkVT+rog9lg8/e/O
         Gwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754169909; x=1754774709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cume3DFrFO7u3pL9Y1K1ypuZDFhhQLKijYnO66hZ+p0=;
        b=LSDFcbp8cu7vfCek882NYeGQ2HtecSjeJSu6uCVApZn7oRXVD2qTLQqu7tkJKApavB
         0Mm/x6OZGHOIzu6FKPueaS0tQVyiEvIOGNk6n5UD1wczUsaU9/msJStUMBP0pMoO7iB7
         cRcODojANgaIDCM39XigrGzJu3hJ0dYQB2PdV0mjxvUwlojYe07EiV0h+bE2SMOFxY3T
         6AJ+kaPSRltkWd+5HSgqs7xAXPy87gLqqZyPIGPBoHR61xktY6U62rjqWZBlGbyWBM5H
         cn8GINrC0Md/xd7I4EIFxBu1PceBv9YptSoq01hGjDpoyNoNvc/WuPMUK3FoGcSB4zDp
         tk4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUptY/6kX88sqgpF1JBBFfeXtGD2d45cD0zxmpp54/rjsFIkchcrrSR2/+Ymy8rAtsFcxM3BFTe1rDwxdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ40k2l4f9mWey1AbIwbPbuGEbwuLsnmXc/59ajomY+6jNrJnX
	EKSIIJRBGbzEma9IzeszNsSsNRMQN945yRmp0uvyojtVvHUaPZ2wtB5F
X-Gm-Gg: ASbGncuU+t45TRlvkbNuWJGRuAX1VM7yOzKTA0my4203foo2p7+ZQi4lqTTGXR8Akzo
	2DzocqVolhKTcFLrKFZz0hpkAik3WKu30jfGgavRFGO1o+MorU1Wf5a3zZQJ0QD7d5ABlyEbskd
	kbjAeNQWOi71qmrYw1MtVrhMGIEFgni/R3VwHW9r+wIt1wmfyT1P/0cH5rF2HaBFpCWV7L55KmR
	w41Gvv9WSLfZEdLpoWHU7e8KjVPX67iuuMUoXH+Okj1fs2uo8Lv2twnohShaYDpMOuDHI8W3Mxd
	oFH4HyV6/pqv2qst4sjfvDBH0Oer9FqgD+EhzaH+luxuDeqcFq+MMRg6csbYkdImtGKI7kPCUiz
	F10YEgva+0yJUCmxyxN1EvlSTBpxl
X-Google-Smtp-Source: AGHT+IHa0klRSXCFoybBuOxSnH60N2w1w4ZPxIlHjK/RY58F32+CUo39TEE2TF8g+Okjk48Ak292RQ==
X-Received: by 2002:a05:6214:c49:b0:707:61a9:8bdf with SMTP id 6a1803df08f44-70935fb5a2amr67384806d6.22.1754169909270;
        Sat, 02 Aug 2025 14:25:09 -0700 (PDT)
Received: from localhost ([142.186.9.88])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7077c9da463sm39398046d6.9.2025.08.02.14.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 14:25:08 -0700 (PDT)
From: Seyediman Seyedarab <imandevel@gmail.com>
X-Google-Original-From: Seyediman Seyedarab <ImanDevel@gmail.com>
Date: Sat, 2 Aug 2025 17:24:53 -0400
To: lyude@redhat.com, dakr@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau: replace snprintf() with scnprintf() in
 nvkm_snprintbf()
Message-ID: <kbskd3rnp76mslqfxhy4fdnz3joce6ukzfq5au2c5p7vgmyhfe@f65dzwx7bd5j>
References: <20250724195913.60742-1-ImanDevel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724195913.60742-1-ImanDevel@gmail.com>

On 25/07/24 03:59PM, Seyediman Seyedarab wrote:
> snprintf() returns the number of characters that *would* have been
> written, which can overestimate how much you actually wrote to the
> buffer in case of truncation. That leads to 'data += this' advancing
> the pointer past the end of the buffer and size going negative.
> 
> Switching to scnprintf() prevents potential buffer overflows and ensures
> consistent behavior when building the output string.
> 
> Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/core/enum.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/core/enum.c b/drivers/gpu/drm/nouveau/nvkm/core/enum.c
> index b9581feb24cc..a23b40b27b81 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/core/enum.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/core/enum.c
> @@ -44,7 +44,7 @@ nvkm_snprintbf(char *data, int size, const struct nvkm_bitfield *bf, u32 value)
>  	bool space = false;
>  	while (size >= 1 && bf->name) {
>  		if (value & bf->mask) {
> -			int this = snprintf(data, size, "%s%s",
> +			int this = scnprintf(data, size, "%s%s",
>  					    space ? " " : "", bf->name);
>  			size -= this;
>  			data += this;
> -- 
> 2.50.1
> 

Hi there,

Just following up on this patch. Please let me know if there's any
feedback or if further changes are needed.

Regards,
Seyediman

