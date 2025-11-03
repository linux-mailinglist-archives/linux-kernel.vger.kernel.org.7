Return-Path: <linux-kernel+bounces-882293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73434C2A157
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 06:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D19188E4B7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 05:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BF1271451;
	Mon,  3 Nov 2025 05:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izbE0bq0"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC77223DDA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 05:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762148058; cv=none; b=cnTmIQ18MzeyIskaznEegJUKslf5fXnYkUtzxZnHHki60fX+qPR6nG8b4ofcuPt+dPSijxdhKrTpUJbCS/JrNoLqZ+lr+vCiMfZjo9KrpoimVCAfalO3BuRavCHuWp99BH9oDK4pIYVjCPf95BrMW1bD3yFm+CufZp3yRZRvYQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762148058; c=relaxed/simple;
	bh=x51ftD9cgTSJ9bj5deAIyMpSaj9sOpommUnV232gOfA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=W0K+XaAcRqIJapKX+UjkyHV4OEuseoepL2qcplEZocZEJdb2x5a9nPzuPYQn/9TjS22Ye0O5InPiQedkC2uf7DvUIn8+HWPlnJACWmT/sykkO1Fmstxyz8kcNkQ0ZixvyA1fRlOLCBkRrtMHuRQl6OSwAN498ynxxuzHuvbSqPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izbE0bq0; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a9c64dfa6eso696846b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 21:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762148056; x=1762752856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tl+1ME660P0RrPzwjGoxlP43t1wlN8lONhAe7XdLRx4=;
        b=izbE0bq02mdzxgyITUfGHNzdBsAiiVE8Bg2nNBfOK+D8OTAdeCm7LzdkTrAVbQLdVZ
         kGmcdJZD/KMjZXSsHxWPiqVKEEyTXgomypdxVRayrIrTXE5fx3e/go803oZidS45PJ64
         Tch33bXFwhCmtFdtZHVrxVSNK8vxe9CskaOnzNTBmY9BPJedysi5j759HJM7g3eFHN23
         jvxiNVo1T4ODJ+iHK/IX9mMphi6JJrEzpkHaCBeEMnZJwuuPglOnSCPYEBoroo3bnGrb
         WJPQ632PEaYp+dwFwi+oyuXW27gGbn99F2cnIjbC1ZlDcfZk1wrunA1xARtboLNhhdY/
         2VVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762148056; x=1762752856;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tl+1ME660P0RrPzwjGoxlP43t1wlN8lONhAe7XdLRx4=;
        b=w0oL0zrcZjSA5Kk2w5WtnkVtTUJBc7FHgh4CKB+iOnyG5KlI2ruAij95k/bwB99Wk3
         0hwI34fS/q8Z/051XRndyitOgAyHdoTOg0DVmVZtrirmK4/NHUVKK9KbzsyJ9f4sm8bC
         Rlkp7nEctpv0EvCGMMTJyxuDZ8B5mjmSGq+wFeEEYKHgC/KWDuh/3LujFasL2qK4IbBZ
         z6+5umkp7+cQG9jO3w+kzbGrddUNOtFM9qmlf6eI+nsjwJvQxO7NWG8Jf0bt2sLjszFZ
         0u5uwAnqLrDiBRAFrxHJwtTFn0m/hFV25cY5cdXqVFzA6fHTCxC0o/vfY9B/BXrzER79
         +agA==
X-Forwarded-Encrypted: i=1; AJvYcCWG9TupK2ttP07Gs41qvGTZ/xTzp8z8w3iq8+9P9Iu+6a99ACQOokCvKmE/arAIR87NtxITUodDVIQLopY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye88eNGdakZC60kKuMV+eF4jem08SqGofPD8RbV579Z03IkCdV
	jraiXUP1zN3xuDBjNGW8QTsUUOXTTNZVfqggu/9UvrH8roVA8PztLwLp
X-Gm-Gg: ASbGnctvDpmzjr4VKuErgm8qGcdaD5PlsNFEnrKPznqQYq13DVkGXmWT11ERRo17tkz
	KIj+uHnmRGW9tCcwgADxxBhFQTL+bZPVXHKOL0B2U4CZA8fWeRnVxfM3yN3/C+T/qz09da7shrL
	HBTegsW7cjsacclScvji2kHzNkw8qe2qVKpdzjbId9pn89F0di4dxJ530okIYvJ4lVOw1OoRKif
	FAGN5nzXXNZa8WegzMvi+AIXpxBAWzELEmP7HHDJEKYtN3NzAmvAQ7qvjoECitf3/kZ5DLz+LVX
	2jaPwf67vHnl/fyLxcXITkOcSgPQfcGB/8dchAIYOEvJkGrYEQq7uF/E8qofqJmc+0K4T0KW+6C
	sfYMOfN5JTBKCq9sC/kdVnsZBLybYMUmBiVyKDHqVQMKRqk+7aeeXUlaNHNCjDg==
X-Google-Smtp-Source: AGHT+IHD2dAZfADdDFXllu/HFA49Sven+QJ7TUxa4MZZ4UV56hgv8yVqQeRNFjhgd9N3dIxrk8DDxA==
X-Received: by 2002:a05:6a20:6a09:b0:33f:df99:11d5 with SMTP id adf61e73a8af0-348ca463b62mr15746310637.13.1762148055244;
        Sun, 02 Nov 2025 21:34:15 -0800 (PST)
Received: from ehlo.thunderbird.net ([2001:df0:a640:1::14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93b8aa3ef0sm8969044a12.11.2025.11.02.21.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 21:34:14 -0800 (PST)
Date: Mon, 03 Nov 2025 13:34:13 +0800
From: Tianling Shen <cnsztl@gmail.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
CC: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spinand: fmsh: remove QE bit for FM25S01A flash
User-Agent: Thunderbird for Android
In-Reply-To: <20251103010148.3855648-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251103010148.3855648-1-mikhail.kshevetskiy@iopsys.eu>
Message-ID: <4A71A9B2-6886-4250-A285-EDCA81242836@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Mikhail,

On November 3, 2025 9:01:48 AM GMT+08:00, Mikhail Kshevetskiy <mikhail=2Ek=
shevetskiy@iopsys=2Eeu> wrote:
>According to datasheet (http://eng=2Efmsh=2Ecom/nvm/FM25S01A_ds_eng=2Epdf=
)
>there is no QE (Quad Enable) bit for FM25S01A flash, so remove it=2E

Thank you so much for the fix!

>
>Fixes: 5f284dc15ca86 ("mtd: spinand: add support for FudanMicro FM25S01A"=
)
>Signed-off-by: Mikhail Kshevetskiy <mikhail=2Ekshevetskiy@iopsys=2Eeu>

Tested-by: Tianling Shen <cnsztl@gmail=2Ecom>

Thanks,
Tianling=2E

>---
> drivers/mtd/nand/spi/fmsh=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/mtd/nand/spi/fmsh=2Ec b/drivers/mtd/nand/spi/fmsh=2E=
c
>index 8b2097bfc771=2E=2Ec2b9a8c113cb 100644
>--- a/drivers/mtd/nand/spi/fmsh=2Ec
>+++ b/drivers/mtd/nand/spi/fmsh=2Ec
>@@ -58,7 +58,7 @@ static const struct spinand_info fmsh_spinand_table[] =
=3D {
> 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> 					      &write_cache_variants,
> 					      &update_cache_variants),
>-		     SPINAND_HAS_QE_BIT,
>+		     0,
> 		     SPINAND_ECCINFO(&fm25s01a_ooblayout, NULL)),
> };
>=20
>--=20
>2=2E51=2E0
>

