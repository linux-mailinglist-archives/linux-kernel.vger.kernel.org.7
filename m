Return-Path: <linux-kernel+bounces-723639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB1CAFE969
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B011A1748B8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773672D9EFE;
	Wed,  9 Jul 2025 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjgJ9No0"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CF427442
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752065469; cv=none; b=bGVcrsYjxpk2Un5I/H/BUnwWSai5Gq4SoGovjEmB7jQ21j0qCR+gx5/gEqqiSAiXcFADK7qvhrnd23Y0336EFR7D4k7Fq9Z7zxgRv214D2lbAx9U80szgLwIhNOULE21gxWly78TpjtnonlPT4OPwkCcYnSHoVE4TQKGNEyxTFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752065469; c=relaxed/simple;
	bh=bS30qzBKG0kk8EMi8ZpiEEOGC81mI51mpXsSY+KeUbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnT73GG8wwRKlhLXDimgYcX7LujYxuHNR8ZJmtDfq0wO9MYBf+XA/aaCK1XUE4d1e8aOSUjaK268DvwYMWMGQ64IlK2H5xKTONgIe45ZvOQtPAJ9zzVDj+KC9og57alPC7UYUy6DZRcGcOixpFMQhggIjY4bRc7SiaiIaRC/hIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjgJ9No0; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74b27c1481bso3349680b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 05:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752065468; x=1752670268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NyEhmSVIBICxuUIBvtGawGc4Iwp2NdQOe0bbugc22A=;
        b=VjgJ9No03D7AaeNdL8QQQxNTWwechJOqpk3pZJJhNMvqVLtKn/bwQkNmYc2hX0djWb
         mE0zxhdO541BQaYouEAPG2ODcsRgKSacsb2mZoOjhn09RfSGSlWbowiOi0uhDtRC69MZ
         ip0CgVCYb7FfwRCydZ7xHXDTcRxOpjqAHG/CQhKjiL3rGTqdcekyTwFqF+CRIJKXQMxV
         PjZPNJDZCQsqgRfktm7hlnunDfXM0+dKEZrFVwxzbzCXA8IP2BtvCpcZ8tTvghZYDUu1
         wZi7YZH2/IX15uL3hpKFcxaCZjiZEFzUVIAqFes0ZQmkDOrlPNE07/AKiLLrWlf7ArA2
         VgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752065468; x=1752670268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NyEhmSVIBICxuUIBvtGawGc4Iwp2NdQOe0bbugc22A=;
        b=uxuYhrmz9tTZ8ugw0If6BWqxKCQLNQFHocbkbbWjIwnCUIMyJag0t61bbRXfVME7of
         F2WiUUDNIUR9SrTKfx4JNZlgfoNVkhvY1yKWPFRWKaY26RzmV6ZjLgKgFTMZydBFQHOu
         nHKBkLGy3QZ9l9aFit17GGOerR+DFDkyN2xEnMz4CH5XfP+76Au1R46fL9qLwcgR1sES
         RXHVyoU/SAlij11STlb/xb6uNVjY2T7zVdXYwZZEl7Y7IiqomPr91GX8Ar+wGJEbe/K0
         fBaMkSXyBTbHr+1KRwhv+QlcBA1UeXWIVMrrFGjp3cQ2AdUF7fr94/lxNMC8Dq3488Wl
         aglA==
X-Forwarded-Encrypted: i=1; AJvYcCVYXTvMQhlvqv83ZlSVypf93dFGdqNVY/0YM26qezNsFF1ICub5Tb5/9dVOQdQ7SNulnndhY+7gBIZ9l8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDHsEV0dGDhC7pX3DRYrPPzPYo/O08WtYvZ4E8fW/5a7cJN6q1
	3MSfG0i8rpjn+Js4iLb5WFfF5Y8dGDnibFU0aar4iy8QhPBTCKNHfKTKaW37SVYKfu111T+6ixY
	Y9FYSbsdlja12QDpcWpkUBEESREBRV+SrlTut
X-Gm-Gg: ASbGncvAkYRrcx9ERwC21AOKJ37Yd3/YvWZl5/SfGrqvOTETCAMvqxwxcaLhe9AsV2K
	86PZ1M6RJS5g8uH/5XKRHYhYPaao5Rc0u1ofc9Wu5ZbGs9Jy75s05z0cF/SdbyvY6JhA7/tuJA1
	PsU7rIjPL6ME/XT6i/iYnzdglOs4NAyHXSzSffOpsk
X-Google-Smtp-Source: AGHT+IGH2nT6IZbDo+Ks/jODFk/vV/IDP2mO4EVK6jpwo5O0W2jmbx6OyQumL7TIFPqqenseGtE+uLTBc2Qz1uGxJ1U=
X-Received: by 2002:a17:90b:5247:b0:2fe:85f0:e115 with SMTP id
 98e67ed59e1d1-31c2fdd1716mr3642904a91.26.1752065467724; Wed, 09 Jul 2025
 05:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709122332.2874632-1-laurentiu.palcu@oss.nxp.com> <20250709122332.2874632-9-laurentiu.palcu@oss.nxp.com>
In-Reply-To: <20250709122332.2874632-9-laurentiu.palcu@oss.nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 9 Jul 2025 15:53:10 +0300
X-Gm-Features: Ac12FXzjfnR6C_2CM5IgN-GnBOUmsZy0yzBqb-TNLTHux0vSrVzkSRKBepnd5vs
Message-ID: <CAEnQRZDY6vKwUTVuGqV7_DdV43doq=NRij6+zqJp9h1M5HgBig@mail.gmail.com>
Subject: Re: [PATCH 8/8] MAINTAINERS: Add entry for i.MX94 DCIF driver
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: imx@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 3:26=E2=80=AFPM Laurentiu Palcu
<laurentiu.palcu@oss.nxp.com> wrote:
>
> The driver is part of DRM subsystem and is located in
> drivers/gpu/drm/imx/dcif.
>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8be3e0fbe72b8..fbec7e42e693b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18066,6 +18066,14 @@ S:     Maintained
>  F:     Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
>  F:     drivers/media/platform/nxp/imx-jpeg
>
> +NXP i.MX 94 DCIF DRIVER
> +M:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> +L:     dri-devel@lists.freedesktop.org

Please also add imx@lists.linux.dev

