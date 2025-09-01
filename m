Return-Path: <linux-kernel+bounces-794969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7667B3EB61
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C461B2766F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9234C80C02;
	Mon,  1 Sep 2025 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="RmPRpUkd"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06C732F750
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756741239; cv=none; b=sgDtVlZac8Sba9E9nvQhsZ+VqFvcFyhqj8PEpdfh39EHRE5FQOXr2cxQabO6ilHjFLZwntCnvzuQacLjMC3ipI70WnTDK/J8CS/EvUu1OJmPry6QVSsXTLVJzr+hN11TwHKvxsIFmDsPA0McUNU9A7TUxpacshLHjt9+kFFU/Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756741239; c=relaxed/simple;
	bh=1SRuL8mEiWOZiFrqvbpRYdX5HsAfTsBaI3+RL97T9Tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PoVrl8hbxSbyXaIxevSqV1F7blByNjJzK2DNQWs2h0RM06IHC8YOfgjP5CILo0U6QEF8ZI3UVeXtGKVBhwRG2kEa04BmnWp44mA9J6c3Cz9Nyec8pD7XNJMdPuQFfYxDzrM1rCgaZXyEPX4JLtRJtY6ol3uDKQkfwM0zIClcBrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=RmPRpUkd; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e931c858dbbso3497262276.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 08:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1756741235; x=1757346035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=em/9vDUrj0pedA4nKRso3xCwe3GgZ+2y9mHvn6I2icE=;
        b=RmPRpUkdfR0Ac3N+TKACXmagsa09vpiELW+ljDIEsXuWdcpQ8JtvTtcPWYyOMuaxDu
         KvyIaijZJZylyk+/+F3noTXb25zuPJkjg+pJZBpcF6vDYj0cyGGZXUh2RobO5QEuRgLi
         KyZEgWOFuhUdqj+mMSZ63MVcQZ96jBcT9v9vCCpcECGIgRrvYMZDZZ+mFA8FGPwRaHxB
         yBSUtM/4InuxDzL8t84ISuLICnwZgJSPKF1O1E/TE8cA7WtOo3k+hv4WTY7IDQVenFGG
         U7GdcG1CHzzEeIICjG0Q+Wv6zSIArqABu+Cw9Yu1DSAhZrbr5Ix15/egzG0iqektg2dz
         q0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756741235; x=1757346035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=em/9vDUrj0pedA4nKRso3xCwe3GgZ+2y9mHvn6I2icE=;
        b=CQh11t2xpFWVe5X34h1bYFrmM7SK22GGjcIzCHjK+WsfGgFaPaYs2w0ojyYLg6rlK2
         JmBBJaLteGPDF8ANE6V+6ioVZX+sxraC8NZBDf6KFqTcOrnny1Y8DinpR+XnZucqurK8
         objKOLSoymTvJKHCZe90YnJrlB8TNG4VsiDBi8qcAyXV99FpEUq/1bcpMeGnRIpOc1U2
         AfjXXIl3wb/UdFduQGfZfkT4CSKbY0KVgYUmfD7TentKuwKk5ylkJSnJIfG6FCpUh4fw
         f2TOCNOP3Y29v53EUZ4VxqZ6WVIhN0uoak11gTCPZnmG7YoCd8GD0lGR5liXCVYWQ1Ar
         L6Vg==
X-Forwarded-Encrypted: i=1; AJvYcCU47O05pbJdnpWWS5u0tEvIuPdcWbU/MuIrBF1kzg0IQx5xLE1LbfqymX5s4aV+vWb1swjWC2lPI+2T7Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznejlps5ZX46cslTZw6seHMcqAH1j9gN551MsIBEil987t4qly
	jam0+js7dTHLkBl8r5bu+DiRSDhjligf/0OEod2IPIUlBncHgzk+glf/2D2V8Uwr/v0=
X-Gm-Gg: ASbGnctYIguuL++QUeUhF9jgfrZYmFr93r4X5W4UfnY19HBuLLXbBNXn7ZrdeZQZsbp
	jVJ5d6VjSLJ00xB3yMwxM1MO0ze+Qq703zRoT3h8TbC51dteXTnKwjana2YbibdeaVTNM0dEmvw
	+3fdwzVurLZEDxBA2FLroL9RPZFbWNDi88ixAf6Fr5596GUQJKquUmuGMSdMi4jeFjBdHUjRfMD
	ozAGbzJFQ+at3PBtAC4sk5QSp2WxV9rdgv1+fzVR3vp84/o8Zybb92VubusrSbWMPj2USy/87We
	xDtfx/LNQ4axvg9cAszxCpnLgKJ0uf2pow+rFZUSvy/iHuJkApWXyeOmS9jRWQHv083lsPwsCba
	GCwDSd6y7wXRkZtWTSM+ltBCc89DQoFVcRCU1a9ZaQPnzl2LtwvLurlU3cou2K904qQ==
X-Google-Smtp-Source: AGHT+IHg6PPcws+9uHngnWNsxJEybIzIwI2xhsyn0XPIKrzZ2EEIlWcoyB0PwvJ8szF8OF6qadhjOg==
X-Received: by 2002:a05:6902:100f:b0:e95:3397:c010 with SMTP id 3f1490d57ef6-e98a567faefmr8702382276.0.1756741235262;
        Mon, 01 Sep 2025 08:40:35 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e98ac57c06dsm2052847276.26.2025.09.01.08.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 08:40:35 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e96e1c82b01so3220597276.1;
        Mon, 01 Sep 2025 08:40:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTb5c2y/sBcmVNP/sDVztCYJe0Q8cyZtyTwftqAh+Lke1Igy2ZOnMcRXjKGuNQsVSHB0du2zfkkCC0rJJX@vger.kernel.org, AJvYcCXNIllNgD7peZ+DckZnddurMS5pT5hiP6e7Y/2KLMQVFbL1VX02Tjm3VXyeeTSpnLVkrfJwEnMNl1Uxr3TQBfQ=@vger.kernel.org
X-Received: by 2002:a05:690c:4c11:b0:721:5b31:54bb with SMTP id
 00721157ae682-72276408c56mr100755167b3.23.1756741234330; Mon, 01 Sep 2025
 08:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826063248.32153-1-lukas.bulwahn@redhat.com>
In-Reply-To: <20250826063248.32153-1-lukas.bulwahn@redhat.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Mon, 1 Sep 2025 17:40:23 +0200
X-Gmail-Original-Message-ID: <CAAObsKDxqhZ5McrDXD0koa_vZc8NnPHTMbKdNrsPNb9qrKfSCQ@mail.gmail.com>
X-Gm-Features: Ac12FXzuk1Gcnj96u5r1uDpZiwfQREbRtmbKct0ZTYs0gxuteSNfDWyua5Sgwls
Message-ID: <CAAObsKDxqhZ5McrDXD0koa_vZc8NnPHTMbKdNrsPNb9qrKfSCQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in DRM ACCEL DRIVER FOR
 ROCKCHIP NPU
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Lukas, I have applied it to drm-misc-next.

Regards,

Tomeu

On Tue, Aug 26, 2025 at 8:32=E2=80=AFAM Lukas Bulwahn <lbulwahn@redhat.com>=
 wrote:
>
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>
> Commit a7352c849492 ("dt-bindings: npu: rockchip,rknn: Add bindings") add=
s
> the device-tree binding rockchip,rk3588-rknn-core.yaml, whereas the commi=
t
> ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU") adds t=
he
> section DRM ACCEL DRIVER FOR ROCKCHIP NPU in MAINTAINERS with a file entr=
y
> referring to rockchip,rknn-core.yaml. Note that the file entry is missing
> the part rk3588, compared to the added file above, which it intends to
> refer to.
>
> Adjust the file entry to the intended file name.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d4bddc462c07..a569828c9f3d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7542,7 +7542,7 @@ L:        dri-devel@lists.freedesktop.org
>  S:     Supported
>  T:     git https://gitlab.freedesktop.org/drm/misc/kernel.git
>  F:     Documentation/accel/rocket/
> -F:     Documentation/devicetree/bindings/npu/rockchip,rknn-core.yaml
> +F:     Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.y=
aml
>  F:     drivers/accel/rocket/
>  F:     include/uapi/drm/rocket_accel.h
>
> --
> 2.50.1
>

