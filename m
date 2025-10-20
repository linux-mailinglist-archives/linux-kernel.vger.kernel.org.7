Return-Path: <linux-kernel+bounces-861636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5099BF33C4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C6B18C2FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B0C2DE70B;
	Mon, 20 Oct 2025 19:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSK81WXg"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD592D7DE8
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760988970; cv=none; b=FsrIKbUNpkXY1N01Dnki6ZOm0oX9LrJ4Jz3eEjjW+RSOtmpawxYtUgmu2Ey/e8OEVsrsiSfWkYBCKJDQKX/esGPq6CeBY+A2dZ0cKK2lV+au3aZZSGX3Kn5lHaKLtJ2yKAJkie8Jr5vYtaE4w9/B/EEN8gJNy9qZWZMXv4c68do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760988970; c=relaxed/simple;
	bh=1badgIiNTAPNpkcfawu2PFSrOUn1RLnP9k+lZMeoVE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfBTi0GSrIdPkAMthZZLUearE2Qw5kjLd0ULx9+qk0Glw2FQ/+UrM+VeExJ6TuSa2Y98f4xykXGilb3sZkXlxFkIXECF8yIOiK7AZL8kPs9SOd1bnaMiZe4FN+rxYEwBP9UJSYSfiNLeyhJEQIg4AXpG0zqDR1rB1SGwqoiYjIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSK81WXg; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57f1b88354eso5355313e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760988966; x=1761593766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EQCZF24uyYd+K66ud5iMJvTJa8EJgzNd81qWfpbtzM=;
        b=WSK81WXgktshiOyYie0L2ydU9rH/CPH8uS6owYfRq+C11GxEnbl0E1xlnqDYCPf4wo
         de3RB9HIwnay+QRTrVoGCZn8S4QgLLZ6bsOHVyUgq7exSAcBGGDomC27GgnRCrks51uj
         VaAqZ1ikuYKYUro8o4b+/4RBUdR0Sjsveq8CjWrMrHg6kEr/30mkBZGDaEUHERB5gmlg
         D3Z/KuW1YSjA98CVchCW5wYcE4ZlGPTpUy1lNOlVYfDsPj54ccHQV209/vXll/BtG4mQ
         zwyWrkIDMgt6IMaal2oEj5avaA8ReU7z5eIyS27zW/8GNCctkepd1KSwFL5pBauRo3Ud
         15hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760988966; x=1761593766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EQCZF24uyYd+K66ud5iMJvTJa8EJgzNd81qWfpbtzM=;
        b=ERnG9WYpStsbvI4dHbdyNeXAWCDHN8NSG00RkGbZSZ4XrvRWJ3f4MbKL4mWKxHxbbA
         UWgNPK2GD7W29S/xuDkwRcc3bC4GNs/6weNJSyLlFF+QAAhszgeeOxS4nfiaWYWQmQmU
         2O36d6lBCcoGbxPAeY7/m0EwneHMrwjXkjjXJtM8K479N7ol3WwzsDWVRCnTTmPRYMC0
         UtDrmAJnaBWUTJ67vWYlFKLVmVb+z3OslQzqyzps0b9WPpFSZ5ctqxwuBUVwS3xFsH0F
         DX8nosqQjrX529tD2luXU5B+d64/zvKZDnSSiCVl73lPXvymIH8AxC2D+h5WML4XSL/d
         a5cw==
X-Forwarded-Encrypted: i=1; AJvYcCXKntsU7k0IvwItSHYo2okzabjDGa/mScZ7oLAQWdvXuPcpaiMfdRbXQ502k32CTxGRom57ixENoknlGpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2HUoUuWztnwSJHhvkUTzn5ShiSYfuxdUrAnNhvEBe1e5xzrTd
	2BrZSPYaUJndLN0zPiJYP9D7F2T7Vy0QLLfsyQCK3FmpGjyxjoNsTw+n6tfW2GaE6vFR4OV6iIk
	69/3vuzA3BeGDSxaIESWtlJF/MNNnGYY=
X-Gm-Gg: ASbGncvgOzkLxi8s2qfF15wJZZgu96zWZn4yv5g7bmYVvok8CfTqxq60zPn5otAToFU
	cMl1DgJ7lQzhgmu/EiaKH68CvJmO0aXKy+j/3nwtUVemePAdb5kyXZn1yhvKsDZCVhIV9rB+EL/
	UpHlE0kiZu4WhgGOJMbkHeT4ynzeVH9V3LXQAhN+r0Yh0q560grdlT1+qsFkKOLLAtpkr2r1m63
	+o6b7xSiQV/S3Sxg59QEeZy9q9W6zfhNm4DG01XzacwO7jFuu+5ju9mU1D9TAusEBb0uLCd/gTM
	X9r9Mjrh5bZkKnmCQA==
X-Google-Smtp-Source: AGHT+IGJf1d7OGOI2bEsOsRKUAzUwqlW11kyu2gHkb5eSm8a2k5NOCXXslI+k5uFUiRwdMzagVbTM2EzHHMJP+MrdtU=
X-Received: by 2002:a05:6512:3b0c:b0:57a:310:66a8 with SMTP id
 2adb3069b0e04-591d85773ffmr4241105e87.55.1760988965463; Mon, 20 Oct 2025
 12:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816-tegra210-media-enable-v1-1-bdb1c2554f0d@gmail.com>
In-Reply-To: <20250816-tegra210-media-enable-v1-1-bdb1c2554f0d@gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 20 Oct 2025 14:35:54 -0500
X-Gm-Features: AS18NWDrjImObZLOKx397rQyb3hlXNjedT2Ykb-TqO4MVmOUlln0IpbJiO75nUI
Message-ID: <CALHNRZ_KcJmoUp68a1NZau_KAMRczNbtiQ3cbXi7ET-vO=9uhw@mail.gmail.com>
Subject: Re: [PATCH] arm64: tegra: Enable NVDEC and NVENC on Tegra210
To: webgeek1234@gmail.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 1:03=E2=80=AFAM Aaron Kling via B4 Relay
<devnull+webgeek1234.gmail.com@kernel.org> wrote:
>
> From: Aaron Kling <webgeek1234@gmail.com>
>
> The other engines are already enabled, finish filling out the media
> engine nodes and power domains.
>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 28 ++++++++++++++++++++++++++=
--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra210.dtsi
> index 402b0ede1472af625d9d9e811f5af306d436cc98..80d7571d0350205b080bcf48b=
8b8e2c1b93227f2 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> @@ -277,13 +277,25 @@ dsib: dsi@54400000 {
>                 nvdec@54480000 {
>                         compatible =3D "nvidia,tegra210-nvdec";
>                         reg =3D <0x0 0x54480000 0x0 0x00040000>;
> -                       status =3D "disabled";
> +                       clocks =3D <&tegra_car TEGRA210_CLK_NVDEC>;
> +                       clock-names =3D "nvdec";
> +                       resets =3D <&tegra_car 194>;
> +                       reset-names =3D "nvdec";
> +
> +                       iommus =3D <&mc TEGRA_SWGROUP_NVDEC>;
> +                       power-domains =3D <&pd_nvdec>;
>                 };
>
>                 nvenc@544c0000 {
>                         compatible =3D "nvidia,tegra210-nvenc";
>                         reg =3D <0x0 0x544c0000 0x0 0x00040000>;
> -                       status =3D "disabled";
> +                       clocks =3D <&tegra_car TEGRA210_CLK_NVENC>;
> +                       clock-names =3D "nvenc";
> +                       resets =3D <&tegra_car 219>;
> +                       reset-names =3D "nvenc";
> +
> +                       iommus =3D <&mc TEGRA_SWGROUP_NVENC>;
> +                       power-domains =3D <&pd_nvenc>;
>                 };
>
>                 tsec@54500000 {
> @@ -894,6 +906,18 @@ pd_audio: aud {
>                                 #power-domain-cells =3D <0>;
>                         };
>
> +                       pd_nvenc: mpe {
> +                               clocks =3D <&tegra_car TEGRA210_CLK_NVENC=
>;
> +                               resets =3D <&tegra_car 219>;
> +                               #power-domain-cells =3D <0>;
> +                       };
> +
> +                       pd_nvdec: nvdec {
> +                               clocks =3D <&tegra_car TEGRA210_CLK_NVDEC=
>;
> +                               resets =3D <&tegra_car 194>;
> +                               #power-domain-cells =3D <0>;
> +                       };
> +
>                         pd_sor: sor {
>                                 clocks =3D <&tegra_car TEGRA210_CLK_SOR0>=
,
>                                          <&tegra_car TEGRA210_CLK_SOR1>,
>
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250814-tegra210-media-enable-576bb6a34b5c
>
> Best regards,
> --
> Aaron Kling <webgeek1234@gmail.com>

Reminder to review or pick up this patch.

Aaron

