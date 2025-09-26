Return-Path: <linux-kernel+bounces-834188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1B1BA4241
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479213BA347
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A8F2FB094;
	Fri, 26 Sep 2025 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ci+mrXur"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986A62FB974
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896372; cv=none; b=H1dd9VgYeM3A/f3py1fbAxcJFtw+SxAo9USoWKr3jQLGgmN3RWgS44oJ3NaiHed/mP1gDmYcIMAwb+RzhRDrur1kjuROt34TlmnAuAEmj2uhv0uB9gOdhGbR+93PcSemDbC2oErOHtDQ9JLqV7Fd5S1N16SyvZTvZIYdAFKMCCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896372; c=relaxed/simple;
	bh=7J0+HkTXYWDcEOw7KvlwDqgDhLnyM0IzRRcaqPCzpkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0gSGk7e0lHaroCcb4WrtZLsZAfhHaeBPITkKHzQigD7CHWOwwVo5n2mgaWvPm7lnSYZJ3Wr8R+whJBkZLw8G3iFtY1zZnIfw3stC2Oc1sfzEzf2hkx4I3kSi78Z/+ayMWK/w3v6hdyJAYKwEGcCJYCrMkqoJ3rBPgniLB05DRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ci+mrXur; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3612c38b902so19058631fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758896367; x=1759501167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fpb7zplNlEXOl8DahnPV19OFE+HVfaJi7nHJwxF/NI=;
        b=Ci+mrXurbmHDVn1DYV53syRmTofJksTN8U/kU0DbuxU01SS58g4hVa6fWI7yzD39UW
         RUHcD31S9HtZk+3eo/POq0nqLPdA1FoQ85zbSpXgdJ6JszGnu6fsNK0B0yq0l66BfZpc
         Cgsf2NjHK9vRSWWaE8KlKLxD1mKjOK9OSV6mIaraAbM5F6AnQRfXWj8uRDngRXqWhxH6
         Kquz/4AuksZff8z8L6yPUsUyXN3MO9aYbQNFdfLoRvdWiqm/KG85XHPGbyCKC+QnLnGK
         tFCUYXc/Dal5GMTeIeBcJE1kitCPpAjlWtQHx0UzZi5bCZPvyvHBpVJgTLc//C0DDSVn
         BzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758896367; x=1759501167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fpb7zplNlEXOl8DahnPV19OFE+HVfaJi7nHJwxF/NI=;
        b=X3e7NbHT5XLTEweaC6YynxHO+3RIvGlgwpFAryA4YJ6H/ZdGNu/ZuIdenos1fbdgOS
         zU9ETrv7p90O8tYJEq5Xjg+/DWkFNFN3uj+QPkXXWSH3hPeJdqrlDvdASCaHfgSyEtMP
         PJ8hV+7SsoFZjfeKmWTy+EYhu8dtmtLy0oWwkhlhYy6mhkWW+hD68MupszDp+OIT8P1t
         bqfwOR2iruZkTlasgU07MYg5nh8Y7Qry5SvtzcQMLYnTseodAF3Eb+grciT5CHUuUpEm
         6rlfw3VJFOZZ32hsruRyJ8iHjNZuA0qGx1giuZbbZewFCBGHnojtbz5cx9q8crYa+xfW
         oL/A==
X-Forwarded-Encrypted: i=1; AJvYcCXHC7BeNBfVlcAyao/NX8+CgB5A3vUHQovJr9CWIEslRQG9jZRA/DnKbc3MyprRQONpMbVzx+FBbPhDMNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVktMnDU7iak/z7Nv9/KK/yoIdGwemXWpNVIOMCsvRaM0HvwKV
	HjAFACFgOcQDUewRh9L2L6C7PbAVGgihJHdJry7me1tKVoyW8xMs3F7+T0IGuLNRtlq5hWmr0MI
	SLrbguCnUn9m+Ua66ji1arG/vuEjxZjdCQ/3cFxgJHA==
X-Gm-Gg: ASbGncu6CvahhTnHTBaR7MHAzJZyn23eWQu8LDqpieXRoA9zfM5yoIaDAnKiRrGFBQc
	wEnQpIDgJ9bgQXj+EHIZj+dBz50yP0+GnZxFgVXSyhSMcB573Talf3mYkr4nohG2S7k/skVVri1
	m/qmA05egxXAic3eoR+jDrCdd2IxE3CzFYU33Gelt72r6nqNzOCWI2YJ5YXgPfQ7IW/d551HnfF
	J2PAloaO9/bBrc/3PHbwyNMyDImSh3XTG927SFzu7/W/rDiLLs=
X-Google-Smtp-Source: AGHT+IEg0+1QXoqdETbA8SDUMeNvDmPKly4QwcMuj46HgcIsQ+bdLFCRP4n9mvzwGVi+rGsRhftydsEC9n815inQwuc=
X-Received: by 2002:a05:651c:549:b0:337:e0e1:d11e with SMTP id
 38308e7fff4ca-36f7d9b746cmr22623801fa.18.1758896366780; Fri, 26 Sep 2025
 07:19:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926140729.267766-1-deepak.sharma.472935@gmail.com>
In-Reply-To: <20250926140729.267766-1-deepak.sharma.472935@gmail.com>
From: Deepak Sharma <deepak.sharma.472935@gmail.com>
Date: Fri, 26 Sep 2025 19:47:17 +0530
X-Gm-Features: AS18NWD-8e8l1x8r5L3ZN8abjE-3HFmgFfenVF2L-34K18DJt4SNcxgE42HfByQ
Message-ID: <CABbzaOUQ04seRWn3ik2fnoMddc5uNfzNVfOuNcC+i+dT43isYg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] HID: cp2112: Add parameter validation to data length
To: jikos@kernel.org, bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, 
	syzbot+7617e19c8a59edfbd879@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please ignore this patch. I did this patch quite a while ago and put
the change log mistakenly into the commit message. Will send a v3
fixing it. Sorry for being clumsy with that

Thanks,
Deepak Sharma

On Fri, Sep 26, 2025 at 7:39=E2=80=AFPM Deepak Sharma
<deepak.sharma.472935@gmail.com> wrote:
>
> This is v2 for the earlier patch, where a few bounds check were
> unnecessarily strict. This patch also removes the use of magic numbers
>
> Syzkaller reported a stack OOB access in cp2112_write_req caused by lack
> of parameter validation for the user input in I2C SMBUS ioctl codeflow
> in the report
>
> I2C device drivers are "responsible for checking all the parameters that
> come from user-space for validity" as specified at Documentation/i2c/dev-=
interface
>
> Add the parameter validation for the data->block[0] to be bounded by
> I2C_SMBUS_BLOCK_MAX + the additional compatibility padding
>
> Reported-by: syzbot+7617e19c8a59edfbd879@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D7617e19c8a59edfbd879
> Tested-by: syzbot+7617e19c8a59edfbd879@syzkaller.appspotmail.com
> Signed-off-by: Deepak Sharma <deepak.sharma.472935@gmail.com>
> ---
>  drivers/hid/hid-cp2112.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> index 482f62a78c41..13dcd2470d92 100644
> --- a/drivers/hid/hid-cp2112.c
> +++ b/drivers/hid/hid-cp2112.c
> @@ -689,7 +689,14 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16=
 addr,
>                         count =3D cp2112_write_read_req(buf, addr, read_l=
ength,
>                                                       command, NULL, 0);
>                 } else {
> -                       count =3D cp2112_write_req(buf, addr, command,
> +                       /* Copy starts from data->block[1] so the length =
can
> +                        * be at max I2C_SMBUS_CLOCK_MAX + 1
> +                        */
> +
> +                       if (data->block[0] > I2C_SMBUS_BLOCK_MAX + 1)
> +                               count =3D -EINVAL;
> +                       else
> +                               count =3D cp2112_write_req(buf, addr, com=
mand,
>                                                  data->block + 1,
>                                                  data->block[0]);
>                 }
> @@ -700,7 +707,14 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16=
 addr,
>                                                       I2C_SMBUS_BLOCK_MAX=
,
>                                                       command, NULL, 0);
>                 } else {
> -                       count =3D cp2112_write_req(buf, addr, command,
> +                       /* data_length here is data->block[0] + 1
> +                        * so make sure that the data->block[0] is
> +                        * less than or equals I2C_SMBUS_BLOCK_MAX + 1
> +                       */
> +                       if (data->block[0] > I2C_SMBUS_BLOCK_MAX + 1)
> +                               count =3D -EINVAL;
> +                       else
> +                               count =3D cp2112_write_req(buf, addr, com=
mand,
>                                                  data->block,
>                                                  data->block[0] + 1);
>                 }
> @@ -709,7 +723,14 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16=
 addr,
>                 size =3D I2C_SMBUS_BLOCK_DATA;
>                 read_write =3D I2C_SMBUS_READ;
>
> -               count =3D cp2112_write_read_req(buf, addr, I2C_SMBUS_BLOC=
K_MAX,
> +               /* data_length is data->block[0] + 1, so
> +                * so data->block[0] should be less than or
> +                * equal to the I2C_SMBUS_BLOCK_MAX + 1
> +               */
> +               if (data->block[0] > I2C_SMBUS_BLOCK_MAX + 1)
> +                       count =3D -EINVAL;
> +               else
> +                       count =3D cp2112_write_read_req(buf, addr, I2C_SM=
BUS_BLOCK_MAX,
>                                               command, data->block,
>                                               data->block[0] + 1);
>                 break;
> --
> 2.51.0
>

