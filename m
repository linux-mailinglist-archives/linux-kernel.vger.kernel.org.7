Return-Path: <linux-kernel+bounces-797496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D3EB4111C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB41700195
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B254328F4;
	Wed,  3 Sep 2025 00:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHkRBAgu"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5191FA920
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 00:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756857878; cv=none; b=WWPPLDWDr2Jj2PFVOwoFY/m0eIGP4wDs1Csy3TmHvfxErMSoYumwPjT2dU/Ym2mkV9IZ3hi2ggdGGfk9FpxCbx9wopCf7vS4jm90l9eGGHT4ZIF1B9P91vTmimCJvvDjf4UUV+zByLBDxP6hZK0cz957JmT8FlTcW8oqrUMt/HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756857878; c=relaxed/simple;
	bh=brr/7DSbi6pWx34v66C8NSrs4r2nAiD7tWV0nLbNTZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLz16CZ2YPvJCACy/8ISeGj9tlZZ3nV4ARfYzkDd1iFxrZI20+ImeF8EXaf61qK1d5eTZoH6wwMjzyEMiNG42Y0MyeXhylMbMhmyEfUdnrDOw/F5cfmdeEWOz6wt2xWeng1G4/5ZQOXdvq8GwuMDcjRNfpQcuZJxjZGMeVwUs3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHkRBAgu; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3cd44b9496fso766470f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 17:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756857875; x=1757462675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFT0993H0f3lSRwLyOXZyKYupjb06de0ECwWb05sIzE=;
        b=gHkRBAgu+CnI2JEYpvtCLP9Ar1r9sFna5zjBzTqMJ36eshaudlGBigIH9BGNLVPENZ
         1bcZA5eC8CqkehkERYnq77dkWnWVdabPWV+buFHsEes5Lln1P6h2NgixTPjc9fcTpN6U
         q2ggpIPt/w2STRBW4p9ldi84VeLn2/V1sv4UUib0vddOztXtCvopkuiH6sJe6xvDancH
         nMM5kj0Mb3ju2aP9P7sF1c75uF0CC7SLEGHrcynoQvOIpwrhwNRuF+JG5DYqZhyCrSpz
         TlgmUkjMXA8/Zwr+PjagbTeUbeVIuKT9F3BUpi5vgKD4OsUWzGHeSo2RnPkUrjTDpWMG
         GZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756857875; x=1757462675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFT0993H0f3lSRwLyOXZyKYupjb06de0ECwWb05sIzE=;
        b=VrxFrDFRztJUIEA2wrwHOLKrrAz77ez8+rqQpFuT6WJ+nXSAg+bKNq8jut124hBiNP
         hfkyMCc1wJZrIKLkOGMX0fKe00vuvvzklM1ysfhQCauY69tziqBFgPOj/X3GQSWPTFo4
         EnKwG0M3N9RCKfYo2MGVwGJlCAKSHCkjT/PXi9X+vjmIIgbY6+CdJV5COP61XHR6fLMR
         HEMeM5cpIADdVoIs7KFnB3uqhSbcpzHo317QHrIYnxP8SnZ45W5iCLH34TiGDXNFbioh
         fJ/bfxFdBmoNhSS1aYcvsjrPtIVWtn09XRCCiV7sxaSpyec1yBsiVqrqQ8FZHKgSd3QV
         vz4g==
X-Forwarded-Encrypted: i=1; AJvYcCUKgHCqUedSymgR0LLyNznlNwbGpwAW5yUv1ZHXWm+iHRBj0myJCqI8T5DokEDJvLVyBC8H7Vwi9keSits=@vger.kernel.org
X-Gm-Message-State: AOJu0YxokatnycojhzSNk805AoJkgsdDTb6Vz6yFYFacJ/ABLq9Zx84w
	gcgVhg9itEKyZeYoRLUKfqRlbmaBru6M+iGTyzbGIL/rgnddaib0cdzLpPodrDmfIOGCROzSnZ7
	Bhwzz33isfKOORmBXWNy+scQOWbmEDCrGbJWa
X-Gm-Gg: ASbGncukYDCwBEmtTWHZLeyyxCEAEvFRU8BfOj114+LQiZb8J10evZgy/gPWfM49NvD
	035du2dg+nB06WHVhzg1E4IDzMK4et5XQb5cn6ewxI8UUyq3tdKDqOvBZY4Tt8oFuZWUaY2dWNx
	dWkMo0ScJb00HC/v3tfLdQ/e28qZSY0uEVv13oGglza1/Tawap86va2Lzoee+fSHeBFaO3Gc+fY
	Ep+1TM6
X-Google-Smtp-Source: AGHT+IGqW35H5UgfmfxDfBL9yusOur8P4EnLb/epAceWy5YZVyLSodTUjHQMG3MHtkX0sWJEhvbg18RydhRPS0Eotg8=
X-Received: by 2002:a05:6000:2482:b0:3ce:f0a5:d576 with SMTP id
 ffacd0b85a97d-3d0fb7e9163mr6244228f8f.7.1756857874400; Tue, 02 Sep 2025
 17:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901020416.2172182-1-chao@kernel.org>
In-Reply-To: <20250901020416.2172182-1-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 3 Sep 2025 08:04:22 +0800
X-Gm-Features: Ac12FXygM-8n9olifRKUqf3wFjXBZ84sBgxB75imDizF56WMYg93MrmCvQJ8zxo
Message-ID: <CAHJ8P3+NJfE+F-Tsbw4Rz6PyT9o2F74kyrJncLqyQv+YeOSvgA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid migrating empty section
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
=E4=BA=8E2025=E5=B9=B49=E6=9C=881=E6=97=A5=E5=91=A8=E4=B8=80 10:08=E5=86=99=
=E9=81=93=EF=BC=9A
>
> It reports a bug from device w/ zufs:
>
> F2FS-fs (dm-64): Inconsistent segment (173822) type [1, 0] in SSA and SIT
> F2FS-fs (dm-64): Stopped filesystem due to reason: 4
>
> Thread A                                Thread B
> - f2fs_expand_inode_data
>  - f2fs_allocate_pinning_section
>   - f2fs_gc_range
>    - do_garbage_collect w/ segno #x
>                                         - writepage
>                                          - f2fs_allocate_data_block
>                                           - new_curseg
>                                            - allocate segno #x
>
> The root cause is: fallocate on pinning file may race w/ block allocation
> as above, result in do_garbage_collect() from fallocate() may migrate
> segment which is just allocated by a log, the log will update segment typ=
e
> in its in-memory structure, however GC will get segment type from on-disk
> SSA block, once segment type changes by log, we can detect such
> inconsistency, then shutdown filesystem.
>
> In this case, on-disk SSA shows type of segno #173822 is 1 (SUM_TYPE_NODE=
),
> however segno #173822 was just allocated as data type segment, so in-memo=
ry
> SIT shows type of segno #173822 is 0 (SUM_TYPE_DATA).
>
> Change as below to fix this issue:
> - check whether current section is empty before gc
> - add sanity checks on do_garbage_collect() to avoid any race case, resul=
t
> in migrating segment used by log.
> - btw, it fixes misc issue in printed logs: "SSA and SIT" -> "SIT and SSA=
".
>
> Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
> Cc: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/gc.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index ed3acbfc83ca..a7708cf80c04 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1794,6 +1794,13 @@ static int do_garbage_collect(struct f2fs_sb_info =
*sbi,
>                 struct folio *sum_folio =3D filemap_get_folio(META_MAPPIN=
G(sbi),
>                                         GET_SUM_BLOCK(sbi, segno));
>
> +               if (is_cursec(sbi, GET_SEC_FROM_SEG(sbi, segno))) {
> +                       f2fs_err(sbi, "%s: segment %u is used by log",
> +                                                       __func__, segno);
> +                       f2fs_bug_on(sbi, 1);
Hi Chao,
Do we need f2fs_bug_on here?  or it is enough to skip current segno
and let gc continue?
Thanks!
> +                       goto skip;
> +               }
> +
>                 if (get_valid_blocks(sbi, segno, false) =3D=3D 0)
>                         goto freed;
>                 if (gc_type =3D=3D BG_GC && __is_large_section(sbi) &&
> @@ -1805,7 +1812,7 @@ static int do_garbage_collect(struct f2fs_sb_info *=
sbi,
>
>                 sum =3D folio_address(sum_folio);
>                 if (type !=3D GET_SUM_TYPE((&sum->footer))) {
> -                       f2fs_err(sbi, "Inconsistent segment (%u) type [%d=
, %d] in SSA and SIT",
> +                       f2fs_err(sbi, "Inconsistent segment (%u) type [%d=
, %d] in SIT and SSA",
>                                  segno, type, GET_SUM_TYPE((&sum->footer)=
));
>                         f2fs_stop_checkpoint(sbi, false,
>                                 STOP_CP_REASON_CORRUPTED_SUMMARY);
> @@ -2068,6 +2075,13 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
>                         .iroot =3D RADIX_TREE_INIT(gc_list.iroot, GFP_NOF=
S),
>                 };
>
> +               /*
> +                * avoid migrating empty section, as it can be allocated =
by
> +                * log in parallel.
> +                */
> +               if (!get_valid_blocks(sbi, segno, true))
> +                       continue;
> +
>                 if (is_cursec(sbi, GET_SEC_FROM_SEG(sbi, segno)))
>                         continue;
>
> --
> 2.49.0
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

