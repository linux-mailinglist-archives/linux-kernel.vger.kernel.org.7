Return-Path: <linux-kernel+bounces-845958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC9CBC692C
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 22:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2244B34C955
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 20:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BB0299ABF;
	Wed,  8 Oct 2025 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqls7gkJ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024272773E3
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759955052; cv=none; b=pdJI1vvmhPJFDnGK6RUQ86Zi6gG4zcPH1oRUNnOrZW5r7ov1ZmKjdG+5eyxCwNpct5dCobFgy9Ul1rFs8tnLIsSTXkjUV3cmvFF2qfht1+qdnm/jQlmCMspXkZsqOKC1Vg5HFLojCpfAjmG4mQhdFXHPas2EnFrWP0/JyJ5y/eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759955052; c=relaxed/simple;
	bh=6ivGlTEXwaY+On8oXDGk0Rb+EFeEYRF144eAFJFzJj4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bb/JXpd62gFzyXWgTUJ+mg15nhK59TxCSt2moDnzw7M8ifH/Ds23UbrBtKTaZ2mSmkLooooBdG9NwrRAFBLtQzF0Ml8YrE/2lUjq5Hw/Vd1p7s3BZNxmz2pNwlj3EQrlmsQsj9wu1icoq79wG+vkMB2HWwEWVHbqFIKGXhVN7v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqls7gkJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e29d65728so1488875e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 13:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759955049; x=1760559849; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6ivGlTEXwaY+On8oXDGk0Rb+EFeEYRF144eAFJFzJj4=;
        b=fqls7gkJXfTC7+DIef7F8DqYWxvGh03AZoZFivPS7NcQVe6llLpwKlLA5Gl84SUBh+
         eJRhhedmGQuL5fOtNUDTxW7yctJ6as1cvJ5dQcXiWDahrHbdIXdO0ok+ZQlJrbP9Wb0v
         UADQgVBJAJNbZoBywfO7gGbz4d9zoYWyPN7dudhu/G5LVZT+Imya4qf5Ssz6zachvgWW
         lyhrdlNRQci1x4RvsXMfNtRQiZ4+wHRgHpMRRg53G/7hWTgbflJEavHAt/JIK7ljXJDN
         XosEbzD6tX2uR8cs/OChYrEkUcnBbUyQ0LrjNq7jUoCVtqIIJiWnsnTWj2NbNwCWM9tG
         g5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759955049; x=1760559849;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ivGlTEXwaY+On8oXDGk0Rb+EFeEYRF144eAFJFzJj4=;
        b=MSMoohHLTo2sGtDg74v06wdj8av9TVAi+ikTv1ZLM6+6O1KqITD3VNHrlWPsa7iEYW
         ilmwOwkho1wmOlKCtkbzH04ac5bBZYMyFk9Neiev3+5j2AYK+A0R8Fd+omFPV094fjSZ
         e3at+2CUbvVcmeNzGfOhxg5KHkmgX9ng8vYpu7TDCj0nNfvEnk7ffwT+GeR308utF70i
         FXKSc+2h0PbsgBjFAytDg3h5nQC4eynFABH2//ifAVeH5p7X4SjGMV/AHyyveoMDB1vX
         qwpxkCvqgyWrojYmuSPDmlvXl6hSePE47azf8ds/C/yVAVaxLeg0JRtbz20UeUOgD/v2
         AHCA==
X-Forwarded-Encrypted: i=1; AJvYcCVM0F2HTnbhXRpj3fnqJ2IPeyOOu/cK4pIxJtb8AZsDqEormePlbwtS7mRvHT8+gX9W8Dt5YKfGJfx38Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLGjlVjNqFhEQMzjTe3fWgujKBZEAYzlpoIIkWEkbi447cm8JB
	GQvbwrlZX10Kx/BEnahNhVT8jwyiZBnu1JXp8D/v+kxkPqCK+5yW98fC
X-Gm-Gg: ASbGncu42oFGNtNOH5WnhHUaH0yQafTVUYHUM2fvnJhItyrzLWNIyMOeYJbz5KYOW4N
	bMbjiz/D98aDfxd27f5JYCejVfC++apfdE1TZevikOBCUOtJZ4y3XsIHIB/mctBY/tATSM8hGYv
	ds1iZNUNJ7Rxp2VoVWcULKYsIuoJnZmYFkbRtA9UMyzcVoQSoN/dekfUg35IfnFmJo87cayuAO+
	5aKXvkzzcQE94Wh1v9f8IOjKhh/ME/kYmG4Pbvt00gt48GBd5/TmyjorbPEnXPJjiTbhzH3kua0
	45tXXlOFFF/rF1+I/9Hl5jgNTHOKN2JesSaJSDFT5TcUGYYFQ9nVymLElBu4Q5Jvh0IAjBRB04A
	XRcSTvN/KttXI/CVIbXymbYrlDZDFMx7vk4lpFUnlUHWOjHl37NDDRLw6iMTJvTPb7WmZRgKMC/
	373m+knXD36/2JNs9Z+1uibCzg0UunFSPVwzY+YbUUhda1JP+spA4ZJJ83IRHs6xx4yBZzFrNFL
	oS0/f88bdX35A==
X-Google-Smtp-Source: AGHT+IG9nGb6RXJLy3R4KjeILRXXS6qOt+CwXB2ms/ya9AhoxApYV2AlS4ZiC1m4PiBSXPNIfMjxCw==
X-Received: by 2002:a05:600c:19ce:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-46fa9a96a48mr36550135e9.13.1759955049196;
        Wed, 08 Oct 2025 13:24:09 -0700 (PDT)
Received: from p200300c58741558db6dd2a4a25ba8f94.dip0.t-ipconnect.de (p200300c58741558db6dd2a4a25ba8f94.dip0.t-ipconnect.de. [2003:c5:8741:558d:b6dd:2a4a:25ba:8f94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9d4c919sm51035585e9.10.2025.10.08.13.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 13:24:08 -0700 (PDT)
Message-ID: <ebd28e82ff6825507a072c4883e156c45b7746dd.camel@gmail.com>
Subject: Re: [PATCH v3 1/3] scsi: ufs: core: Remove duplicate macro
 definitions
From: Bean Huo <huobean@gmail.com>
To: Bart Van Assche <bvanassche@acm.org>, avri.altman@wdc.com, 
 avri.altman@sandisk.com, alim.akhtar@samsung.com, jejb@linux.ibm.com, 
 martin.petersen@oracle.com, can.guo@oss.qualcomm.com,
 ulf.hansson@linaro.org,  beanhuo@micron.com, jens.wiklander@linaro.org
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 08 Oct 2025 22:24:07 +0200
In-Reply-To: <3fb0bc7b-bcde-417a-96ef-239af94cff54@acm.org>
References: <20251008145854.68510-1-beanhuo@iokpp.de>
	 <20251008145854.68510-2-beanhuo@iokpp.de>
	 <3fb0bc7b-bcde-417a-96ef-239af94cff54@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Bart,

improved in v4, thanks for reviewing!


Kind regards,=C2=A0
Bean

On Wed, 2025-10-08 at 09:03 -0700, Bart Van Assche wrote:
> On 10/8/25 7:58 AM, Bean Huo wrote:
> > Remove duplicate definitions of SD_ASCII_STD and SD_RAW macros from
> > ufshcd-priv.h as they are already defined in include/ufs/ufshcd.h.
> >=20
> > Suggested-by: Avri Altman <Avri.Altman@sandisk.com>
> > Signed-off-by: Bean Huo <beanhuo@micron.com>
> > ---
> > =C2=A0 drivers/ufs/core/ufshcd-priv.h | 3 ---
> > =C2=A0 1 file changed, 3 deletions(-)
> >=20
> > diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-p=
riv.h
> > index d0a2c963a27d..cadee685eb5e 100644
> > --- a/drivers/ufs/core/ufshcd-priv.h
> > +++ b/drivers/ufs/core/ufshcd-priv.h
> > @@ -77,9 +77,6 @@ int ufshcd_mcq_abort(struct scsi_cmnd *cmd);
> > =C2=A0 int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag);
> > =C2=A0 void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct ufshcd_lrb *lrbp);
> > -
> > -#define SD_ASCII_STD true
> > -#define SD_RAW false
> > =C2=A0 int ufshcd_read_string_desc(struct ufs_hba *hba, u8 desc_index,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 u8 **buf, bool ascii);
> > =C2=A0=20
>=20
> Please improve this patch as follows:
> - Remove the ufshcd_read_string_desc() declaration from
> =C2=A0=C2=A0 include/ufs/ufshcd.h because this function has not been expo=
rted.
> - Change the type of the 'ascii' argument into an enumeration type.
> =C2=A0=C2=A0 Code readability improves significantly if boolean arguments=
 are
> =C2=A0=C2=A0 replaced with enumeration type arguments.
>=20
> Below there is an untested patch that illustrates the above.
>=20
> Thanks,
>=20
> Bart.
>=20
>=20
> diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-pri=
v.h
> index 1f0d38aa37f9..85d3d9e64bd7 100644
> --- a/drivers/ufs/core/ufshcd-priv.h
> +++ b/drivers/ufs/core/ufshcd-priv.h
> @@ -80,10 +80,12 @@ int ufshcd_try_to_abort_task(struct ufs_hba *hba,=20
> int tag);
> =C2=A0 void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct ufshcd_lrb *lrbp);
>=20
> -#define SD_ASCII_STD true
> -#define SD_RAW false
> -int ufshcd_read_string_desc(struct ufs_hba *hba, u8 desc_index,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 u8 **buf, bool ascii);
> +enum ufs_descr_fmt {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SD_RAW =3D 0,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SD_ASCII_STD =3D 1,
> +};
> +int ufshcd_read_string_desc(struct ufs_hba *hba, u8 desc_index, u8 **buf=
,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 enum ufs_descr_fmt fmt);
>=20
> =C2=A0 int ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *u=
ic_cmd);
> =C2=A0 int ufshcd_send_bsg_uic_cmd(struct ufs_hba *hba, struct uic_comman=
d=20
> *uic_cmd);
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index be4bf435da09..b10de1ade23b 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -3759,16 +3759,15 @@ static inline char=20
> ufshcd_remove_non_printable(u8 ch)
> =C2=A0=C2=A0 * @desc_index: descriptor index
> =C2=A0=C2=A0 * @buf: pointer to buffer where descriptor would be read,
> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the caller should free=
 the memory.
> - * @ascii: if true convert from unicode to ascii characters
> - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 null terminated strin=
g.
> + * @ufs_descr_fmt: if %SD_ASCII_STD, convert from UTF-16 to ASCII
> =C2=A0=C2=A0 *
> =C2=A0=C2=A0 * Return:
> =C2=A0=C2=A0 * *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 string size on success.
> =C2=A0=C2=A0 * *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -ENOMEM: on allocation fai=
lure
> =C2=A0=C2=A0 * *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -EINVAL: on a wrong parame=
ter
> =C2=A0=C2=A0 */
> -int ufshcd_read_string_desc(struct ufs_hba *hba, u8 desc_index,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 u8 **buf, bool ascii)
> +int ufshcd_read_string_desc(struct ufs_hba *hba, u8 desc_index, u8 **buf=
,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 enum ufs_descr_fmt fmt)
> =C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct uc_string_id *uc_s=
tr;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 *str;
> @@ -3797,7 +3796,7 @@ int ufshcd_read_string_desc(struct ufs_hba *hba,=
=20
> u8 desc_index,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto out;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ascii) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (fmt =3D=3D SD_ASCII_STD) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0ssize_t ascii_len;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0int i;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0/* remove header and divide by 2 to move from UTF16=
 to UTF8 */
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index 8a5649933715..f030e9a062a3 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -1428,10 +1428,6 @@ static inline int=20
> ufshcd_disable_host_tx_lcc(struct ufs_hba *hba)
> =C2=A0 void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit);
> =C2=A0 void ufshcd_fixup_dev_quirks(struct ufs_hba *hba,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 const struct ufs_dev_quirk *fixups);
> -#define SD_ASCII_STD true
> -#define SD_RAW false
> -int ufshcd_read_string_desc(struct ufs_hba *hba, u8 desc_index,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 u8 **buf, bool ascii);
>=20
> =C2=A0 void ufshcd_hold(struct ufs_hba *hba);
> =C2=A0 void ufshcd_release(struct ufs_hba *hba);
>=20


