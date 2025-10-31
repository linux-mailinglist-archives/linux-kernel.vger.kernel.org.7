Return-Path: <linux-kernel+bounces-880466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84260C25CEF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DAFB189B1AB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D531929B217;
	Fri, 31 Oct 2025 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUQI39Pu"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BB728D83E
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923899; cv=none; b=Q4OznIrFOifoC0tsuzWS5iy1sG51uO4huWtA1E7xitcDx85WNPdxd6vrIcX30qO7wj3POdGPHaUbPslbDI7pk0bwaKdLOjxyq38mAkGTN695X/aPc/oOCGVOjFu+QFK7COjpXJuXDMkCJfQIhDiwxpKRn5vhCa2hk6hE94NtD0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923899; c=relaxed/simple;
	bh=On3cALU8nBb0+4ieggXOsWPvMWQU83j2ni/F0KAU+8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AC80f9BUk4vg8N1U/YCmBiqvYpb6PpX1xjMiYAWLGkYTRajatkX7gdDQzYkdMjZ6GEafExlyM11LWluQmbffQr+1CW5tPnV4+oDJxe9sz+ZVn5BW6Z25jDj/4XTRhbD7r4PCjL8F4vo/doiVfDmsUoODRVzcYEqTbITPn4jMLwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUQI39Pu; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3737d0920e6so29161401fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761923895; x=1762528695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWTZKkOkYcn9N/iXeT7lTpb6wx5Kgm29lLrZZWz6S0Y=;
        b=NUQI39PutpnQtcrVBQp3FC3sNqrkkV7ZC8PAzdjeWSW8gfiVVE3+EiLjGsssBFCjws
         LXnO8PNgfkuqWzFGVKbeRJNYFT11TqWxdk0M8UG6MKeV7Og+6X2JYcSp8Bhx7WnCBBx7
         wV2gkxe7ZfAwsopmHY4JP34khkX8W38eFFIh1L/fBb95oV/WA6Lq7aNPZ7/RszRfh6Hb
         47pxXkqCistkPkkcAgZg+QVeL51px149xmU9DWYCm41+ZdAtUkfRtY047mv/hPgftfTd
         5qtZ1eUXuGPG1wQExkKtFega/oWWB9SDKmZlIdqY18RoNyRbufXpOnxfL+Srb0LjUEKF
         +lJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761923895; x=1762528695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWTZKkOkYcn9N/iXeT7lTpb6wx5Kgm29lLrZZWz6S0Y=;
        b=QFcgruGVc1p+iaI/cPsaC1ABIxPd3SbwfbvqyhbdSp0FpoWcvxwS5KlVI0q9sdz2/U
         CDgnsF2+AxBYAE9mpXftZoRcK8n52WJE1YdD/sW6jr8egopNoUYu3q7ppKKJBKMOV3n0
         rtYPz8knKgg9tc3Py8NfuglsTyuXYcd+YSl7DmBtUhE1EPqpJK9ALa3ixVwG5eOvcbWF
         O2x1st2cOmkRbRsg+vA3sd0hxhmPnD57IvR5t6sL82iMm/mlCvRmkwcX9b72vKL2BgST
         xfTKgjnU8Xc8fFmG6U/3eUFsrtrTCs0+gOzjhXjA4iaWjff6eai+9YjyBn8bIxYxNAQn
         COjg==
X-Forwarded-Encrypted: i=1; AJvYcCW93nIX4zp8cgKwqPsdkZ1Ku3n13Dzdmqde9Icmh2tyqCfHSdPv4yGMhktPiN5+1vgnxBc8RVi64UJBV0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsW7qrbNU0guj8+1/9EH1yuOITJQq23+sFvgcRsNHWkzFJPH+Z
	yeHSwKDb4+7vs8MACwZ9b4Yo4wKzmXljm2xXdcEWYzZ+VikUkNhLsgtr62wmVo+OUgREk3qVdNI
	HWsj1H1QUf19n3e8Ff5zjYEKPe1woc3g=
X-Gm-Gg: ASbGnctJuFA9fZ8yXuxgkm1ETNse4CQEG/zwLCQaeX8IvG3z4oCNOovrTTROCYQbezb
	BmsgUQAce7TqPMLrSJjWjZT+JopO1I8osbPoRhMc0yIL3BA/2iy2AI+TPVc+/vxzO/VWvpyoiUa
	/mKFhkreBCGbNnCkzETAig5bwSxEM6aIabpO8YC4kSUgZ0I/LAzeGchKDxQd+8betovZhCCT21R
	GIyYfXq4Oal7OJpZ1B6rFe+bXDVTP2RlcTFFbu8We2lVoLK13wfR6rHyAPuE0nMwU2D8A==
X-Google-Smtp-Source: AGHT+IHhCyX5WgD/BnEfxs9+rDfxqdatiMXwvRpqYTj0+QM5LEWR/Zg4MlR9SQpm0sfZglZhrIAAIz4nl5FkspVBkEw=
X-Received: by 2002:a05:651c:2209:b0:336:9232:fb91 with SMTP id
 38308e7fff4ca-37a18d84e13mr14682981fa.4.1761923894307; Fri, 31 Oct 2025
 08:18:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029022955.827475-1-quic_shuaz@quicinc.com> <20251029022955.827475-2-quic_shuaz@quicinc.com>
In-Reply-To: <20251029022955.827475-2-quic_shuaz@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 31 Oct 2025 11:18:02 -0400
X-Gm-Features: AWmQ_bnmEoXSHQbwofIVHDVHm8UazbPDGWMN_lWJ04lJ7qFjiRa0BctPyX2rqPk
Message-ID: <CABBYNZKh5_Ed0Jm-rjpPZKEf26zo3Lz-ZZrEKAJJWkZWQy3o7Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Bluetooth: btusb: add default nvm file
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: dmitry.baryshkov@oss.qualcomm.com, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, stable@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_chejiang@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 28, 2025 at 10:30=E2=80=AFPM Shuai Zhang <quic_shuaz@quicinc.co=
m> wrote:
>
> If no NVM file matches the board_id, load the default NVM file.
>
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/bluetooth/btusb.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index dcbff7641..6903606d3 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3482,15 +3482,14 @@ static int btusb_setup_qca_load_rampatch(struct h=
ci_dev *hdev,
>  }
>
>  static void btusb_generate_qca_nvm_name(char *fwname, size_t max_size,
> -                                       const struct qca_version *ver)
> +                                       const struct qca_version *ver,
> +                                       u16 board_id)
>  {
>         u32 rom_version =3D le32_to_cpu(ver->rom_version);
>         const char *variant, *fw_subdir;
>         int len;
> -       u16 board_id;
>
>         fw_subdir =3D qca_get_fw_subdirectory(ver);
> -       board_id =3D qca_extract_board_id(ver);
>
>         switch (le32_to_cpu(ver->ram_version)) {
>         case WCN6855_2_0_RAM_VERSION_GF:
> @@ -3522,14 +3521,28 @@ static int btusb_setup_qca_load_nvm(struct hci_de=
v *hdev,
>         const struct firmware *fw;
>         char fwname[80];
>         int err;
> +       u16 board_id =3D 0;
>
> -       btusb_generate_qca_nvm_name(fwname, sizeof(fwname), ver);
> +       board_id =3D qca_extract_board_id(ver);
>
> +retry:
> +       btusb_generate_qca_nvm_name(fwname, sizeof(fwname), ver, board_id=
);
>         err =3D request_firmware(&fw, fwname, &hdev->dev);
>         if (err) {
> +               if (err =3D=3D -EINVAL) {
> +                       bt_dev_err(hdev, "QCOM BT firmware file request f=
ailed (%d)", err);
> +                       return err;
> +               }
> +
>                 bt_dev_err(hdev, "failed to request NVM file: %s (%d)",
>                            fwname, err);
> -               return err;
> +               if (err =3D=3D -ENOENT && board_id !=3D 0) {
> +                       board_id =3D 0;
> +                       goto retry;

goto backwards is asking for trouble, just split the required code
into its own function and then call it again with board set to 0.

> +               } else {
> +                       bt_dev_err(hdev, "QCOM BT firmware file request f=
ailed (%d)", err);
> +                       return err;
> +               }
>         }
>
>         bt_dev_info(hdev, "using NVM file: %s", fwname);
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz

