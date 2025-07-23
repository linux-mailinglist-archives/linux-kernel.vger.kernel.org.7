Return-Path: <linux-kernel+bounces-742667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 334ACB0F51B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46EB1CC1A12
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0E42E7F22;
	Wed, 23 Jul 2025 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="bpVBvXyA"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E5C2E8DEE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753280465; cv=none; b=OtkAPywlgo9P5eajwubw8mzt1pWw3/B/Q4v3xngH7a4e1f9amIZ+VyXIUakjq6IlmZWWPxcyUobGK1ccSheA6SfAf5r4Mca620ulR8JicsoXCD1NTIcV2RTIN1lpHHUUq9HKTS+YmzO0R06Uso6b3dbPt/oWS3PanIgpy1oASZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753280465; c=relaxed/simple;
	bh=uxR8hSIGVZMlUqZvWAGaCEqh6juFlUpBiECC7T1VfZc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Jz7Vxh0CWX59oet/ylmMfV6j6MwPEhkv3HiJ7vo03rGZJsHQ32diwabhejHF1+2GMewHb7onBKDeAi/F6KnQw19R6Zszh+IFpawwp4bTCq9uzX3WhPhXBMpcxAMN24PiDCTc+oY4QbD9MMUuJkVWsPv4Zen4PKGJ0mwQuuD00TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=bpVBvXyA; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so12984849a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1753280462; x=1753885262; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jS0lxrQf1ZOnWA8XFa3rp3xfTwC/QvmIwsGzD/b2reI=;
        b=bpVBvXyAJ/FUbp2XY4I5zybksfCxBrlnLrdhUiBqXd+oM1A0Iq1tS0fi5XSHFvkAMI
         0xnwgW5lbnFkeBOIJnL2eqA6+Aofd9h8H+pjARPRlHzetj8isHUtS1Wtq9bkMhqjhYgd
         Y6zxtCAMoOA90L4klMZjeFieYcUP6UfbNalMAtgvGCrDfsHTEVD3F/ltWCl26wNsvWYz
         7T5+m/KDeO/dPUskWb0IRWgY4MDw2+wyRHXOX+bjvZ54NcOtY/fccjTl9N+/V/xQsajM
         1YgwoDEUzJN0FoIohq7xFmCBqlZYYqF0edX84yaC4qod8NWOxHVJ6LMuw9D8LXulYuPg
         M4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753280462; x=1753885262;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jS0lxrQf1ZOnWA8XFa3rp3xfTwC/QvmIwsGzD/b2reI=;
        b=rykgdhG9YTjXdB5/dw8D3n+iYrwGneKfu1xmWHD/CJL1AcaPHCp2ahzH3y1bTlRKlf
         x9hwqkzv0p5l9pe7Q3ttqM6dCa1m8CA+YG0+R6vrEsBZXQLF7g0QXbr45sBrTiv6RIV9
         Ilg/nV5uzRnjke+xlYog3gewbQrVR+vAcJqlJ5EJsU1j1tiMP+aJPy2uzrh4g23oYpTR
         LBcA/PXWz9DuDufyODZ2mvJkbjmZG9OLyhl4d4fekXvNU5jXkVh0E5VmO2cd94ZmDTBT
         QLlWUhVbLCHS6IO3hFRbkNTjkBKT3wZuRwQuFUSpRa/iULJpcpffj1TU4Sc9KSZz74b/
         I8Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXA4VsZ2ORlfrm0y6hyMhgS7W6IVSOBtWsFElVFMGDfe+0fk+XvB3h7Ya08mFp3a0Y+0XC6fGZJX7zjzps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcOm7T0a2nEwDPYROdxEuFxn4DGMaJJ4r8rlCEKW528WhpF8zt
	bxh3+IcQ8IuZ4JHT/EyeZyunO9eoeGiCSG2X+vMHx+x+ytYa8i+V98c3icb34Ar+gy8=
X-Gm-Gg: ASbGnctzRUxEMC+IOTp/IU6KVkePb/B5yMIOUMNAwaATeT16v2dq0NlqIumHucj527Y
	Ezlum6315if0+bap2jTTpJIV6uxgwdg7Kq3618XcXRPZ2P3ncozO9LFS2Mnnsfsj/e5hc5qKGPf
	wLdTaY37BieyMSBrJWVp8JbHYnWSew2A49OoR4hEuzReTrVKtOv0D+s3MWkmFLVzKcc/DbZSBVI
	vJuyKlLSv+qpn+R7OQ/bxGbGoUFN1We/xnHRpnFYFCuZHqjVGh/La65H02ZD1JjC7F+IFhBQQ81
	9FMd6wkW6NKuyBvUoZWTOj2Bq2z3lPhyYOI+s+o1serHOiTK+m9qBUNAGlFEnVZ6LRbw+cpRVrh
	GvXKSVV/Qg3Edy1KfPbkdHK+7qB6QOC1EcjormlDe0GEQQ5jIlivTDcslT+emtKg6eGo=
X-Google-Smtp-Source: AGHT+IFVifTAJZtaYHUfGrIgJKVup73904Jpxi3iJQtxs2jFFAnZeMblxxiGJ+7YSsPUQmauGBlE4Q==
X-Received: by 2002:a05:6402:2105:b0:60e:f46:326d with SMTP id 4fb4d7f45d1cf-6149b5a9c99mr2747658a12.33.1753280461684;
        Wed, 23 Jul 2025 07:21:01 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612f15f596dsm6803870a12.51.2025.07.23.07.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 07:21:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Jul 2025 16:21:01 +0200
Message-Id: <DBJI1WH6FF2U.DATWTQ5SP4JM@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Rob
 Clark" <robin.clark@oss.qualcomm.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>,
 <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: qcom: ubwc: Add missing UBWC config for SM7225
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250723-ubwc-sm7225-v1-1-d688caff70f1@fairphone.com>
In-Reply-To: <20250723-ubwc-sm7225-v1-1-d688caff70f1@fairphone.com>

On Wed Jul 23, 2025 at 4:19 PM CEST, Luca Weiss wrote:
> SM7225 is a variation of SM6350, and also needs an entry in the table.

And now a second after sending I checked sm7325 and that's also
missing...

>
> Fixes: 1924272b9ce1 ("soc: qcom: Add UBWC config provider")
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Note, due to other bugs on next-20250723 I couldn't fully test that
> DPU/GPU are working, but this seems to be required in any case...
> ---
>  drivers/soc/qcom/ubwc_config.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_confi=
g.c
> index bd0a98aad9f3b222abcf0a7af85a318caffa9841..9fdd169f87a78a486bea88230=
83bef08bc5b9521 100644
> --- a/drivers/soc/qcom/ubwc_config.c
> +++ b/drivers/soc/qcom/ubwc_config.c
> @@ -246,6 +246,7 @@ static const struct of_device_id qcom_ubwc_configs[] =
__maybe_unused =3D {
>  	{ .compatible =3D "qcom,sm6375", .data =3D &sm6350_data, },
>  	{ .compatible =3D "qcom,sm7125", .data =3D &sc7180_data },
>  	{ .compatible =3D "qcom,sm7150", .data =3D &sm7150_data, },
> +	{ .compatible =3D "qcom,sm7225", .data =3D &sm6350_data, },
>  	{ .compatible =3D "qcom,sm8150", .data =3D &sm8150_data, },
>  	{ .compatible =3D "qcom,sm8250", .data =3D &sm8250_data, },
>  	{ .compatible =3D "qcom,sm8350", .data =3D &sm8350_data, },
>
> ---
> base-commit: ac3f0fb04c50a909908fd375686c5ad6b27bee98
> change-id: 20250723-ubwc-sm7225-19be7c2e7bdd
>
> Best regards,


