Return-Path: <linux-kernel+bounces-849618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4FBBD0823
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14FA21896602
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 17:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B532EC547;
	Sun, 12 Oct 2025 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6M5COTO"
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429ED23E23C
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760288563; cv=none; b=mVmXa1WHVJKmvn/AHmfbgp5VjbN5szlvCfx7heZagdQiw+9Mraj+Nq7njqzJ+zxj3x+WmO8kWYZe6TGfgTnuf9VaIwTWtPjdouplkcMywA+wfK/wnKnt80Z6MZeZB/7qG87Cfrlf4SR9xWKaqyRcFDsQX/3OXYYaHyEcb2pWZxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760288563; c=relaxed/simple;
	bh=fzoINW0yQf7mFi6Ce0cd67Ul/S7imhSgcKeCXM8ejzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cl2ow2oW2r90qpQ1JnDhm+j8iKQs1GyHu+j4iZrlBBLE7bv4bkYWB6FGPJpp0598W2abk2wpjS/tn33OcYactUTT+7VvU4xFtDzk9UizyE70vMbygxRIFYDYhaN75N/Nqa7QcFMzb5Zh0eUNqO39CE68F4scAzoIUI1iDNzV3+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6M5COTO; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-63bbf5f77daso3483094d50.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 10:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760288561; x=1760893361; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4/knOw+O1ez/psbJ8n6qPMWfaibnPUlgK1U5bFjqZ0Y=;
        b=E6M5COTOOHik+2wE6Y3QwYZUCGctx2RtzbMpiTTUV/e613CHGefGqOA5+jCVhWtAHG
         zhTJKMUeZtwedaEdL23mcgqynoez2LNpOnbD0PN5+4ch2pAertYeDi93pCzqmZrNmPz8
         D96/cxjwNWVlKRcWn5Vv1ul8GRhw31WQcBFOmp9Dk6iZ2QrECJsTS/wrp4xB3pinAzqk
         F6jlfku+qXOrzi/FiPx3EtJph/juUiwLPbj8Hid6RqnnpXs3361tMkXckV/Y3et3KdBg
         0vtTM7L0UE8ToJuEg2vz4ApaBz8Rn4mr6ch43E+05bW59x2wrXUuc/P/ZGVy0BioAgkr
         Pk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760288561; x=1760893361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/knOw+O1ez/psbJ8n6qPMWfaibnPUlgK1U5bFjqZ0Y=;
        b=pMobGgd33O+23vkuYTd6g03bOEqKFGW1LJpn2ry7AMJ3uesXwwUNLC6ntpvhvwMp94
         +DjzbyzqYogx/YQMYEIZVTFLqyzt71tY2l0yo5HCbOzG6OHPssLASmvd2n4tg8U9G50h
         yREO+koQdjtRJGk/HrFVca+eSfq2+XW52P7Yod4/qiHA8DSNwDJC7rjk/lFCWNX4g3s9
         Q16DjJDweleW+TbV7mI087JETCgWQ5hKCB5vFiuY0WMyhE2MYltNdQONI1hfv8Eix7N6
         sYGiuRrcqeAMSCoYcgfig1IS0USDYajLz3rwmd24LIJKznnbeISYnyVIGzx3CB/rSors
         ZkNQ==
X-Gm-Message-State: AOJu0Yw0MzgBFvizlMs4N2Wdorx/uCGfvjKnPIr291IIKVoDHSqbDae/
	NGh6BRU0yQjs843VtbzQ91hwd9c+MZHxkFti20hafW9eRse0K3daZBd8DIZGscFBqqu4R4HMfL8
	GAFFYT/PTxedvPHapa8gF1g9ggt7N7GY=
X-Gm-Gg: ASbGncsM5UOAiC1hdVWccg9xjJWYPLnOX7D1+qN6ks3as+q2MpskK43dOOxOLeYGgaQ
	JuDEout6vAb4HmmVPRrvG27UgwxF89mClrFHAiSabnnmnOZwddPoI8Xh8XA7HJ49wf4Kq1cO7lk
	bQFaSK3rC/DfnMHhRPMMYKu89Spa4Jh6J0PVyj6fmX/QTuwpsFe/EqKxrN6jr1sPdCgoksgkRic
	7pu1IJVAQVmjgtbfB9ChXgn0GfFE12auZE=
X-Google-Smtp-Source: AGHT+IFo+0lgBz6b0uIaeffB4CHFL5q8ijSM8dQ79T0H7f1iYlbW9aB9Z3CLXE5OXLEWTpzLM/gt7jwXbYkkxvwuesA=
X-Received: by 2002:a53:ac0b:0:b0:633:ac5d:2a03 with SMTP id
 956f58d0204a3-63ccb7fb237mr12767510d50.6.1760288560982; Sun, 12 Oct 2025
 10:02:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a5f67878-33ca-4433-9c05-f508f0ca5d0a@I-love.SAKURA.ne.jp>
 <CAK+_RL=ybNZz3z-Fqxhxg+0fnuA1iRd=MbTCZ=M3KbSjFzEnVg@mail.gmail.com>
 <CAK+_RLkaet_oCHAb1gCTStLyzA5oaiqKHHi=dCFLsM+vydN2FA@mail.gmail.com>
 <340c759f-d102-4d46-b1f2-a797958a89e4@I-love.SAKURA.ne.jp>
 <CAK+_RLmbaxE9Q-ORiOUV8emrB+M6e7YgUNZEb48VwD28EuqwhQ@mail.gmail.com> <ddd2cd94-683f-462b-a475-cc04462e9bdd@I-love.SAKURA.ne.jp>
In-Reply-To: <ddd2cd94-683f-462b-a475-cc04462e9bdd@I-love.SAKURA.ne.jp>
From: Tigran Aivazian <aivazian.tigran@gmail.com>
Date: Sun, 12 Oct 2025 18:02:30 +0100
X-Gm-Features: AS18NWAXMnlVYzjcH6651G1CLcNpAFUYTk5F0bL21vafeWU9e0ABz61d0SA3M2E
Message-ID: <CAK+_RLmwT5EHC6aajJxG0_ccPe7YhnWkd_wOPhhCz3mGo8Ub_g@mail.gmail.com>
Subject: Re: [PATCH] bfs: Verify inode mode when loading from disk
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 12 Oct 2025 at 08:35, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Well, I feel that we should choose "replace the 0x0000FFFF mask with
> 0x00000FFF" approach, for situation might be worse than HFS+ case.
> ...
> -       inode->i_mode = 0x0000FFFF & le32_to_cpu(di->i_mode);
> +       /*
> +        * https://martin.hinner.info/fs/bfs/bfs-structure.html explains that
> +        * BFS in SCO UnixWare environment used only lower 9 bits of di->i_mode
> +        * value. This means that, although bfs_write_inode() saves whole
> +        * inode->i_mode bits (which include S_IFMT bits and S_IS{UID,GID,VTX}
> +        * bits), middle 7 bits of di->i_mode value can be garbage when these
> +        * bits were not saved by bfs_write_inode().
> +        * Since we can't tell whether middle 7 bits are garbage, use only
> +        * lower 12 bits (i.e. tolerate S_IS{UID,GID,VTX} bits possibly being
> +        * garbage) and reconstruct S_IFMT bits for Linux environment from
> +        * di->i_vtype value.
> +        */
> +       inode->i_mode = 0x00000FFF & le32_to_cpu(di->i_mode);
>         if (le32_to_cpu(di->i_vtype) == BFS_VDIR) {
>                 inode->i_mode |= S_IFDIR;
>                 inode->i_op = &bfs_dir_inops;
> @@ -71,6 +83,11 @@ struct inode *bfs_iget(struct super_block *sb, unsigned long ino)
>                 inode->i_op = &bfs_file_inops;
>                 inode->i_fop = &bfs_file_operations;
>                 inode->i_mapping->a_ops = &bfs_aops;
> +       } else {
> +               brelse(bh);
> +               printf("Unknown vtype=%u %s:%08lx\n",
> +                      le32_to_cpu(di->i_vtype), inode->i_sb->s_id, ino);
> +               goto error;
>         }

Agreed -- given that historical BFS may leave those "middle 7 bits"
uninitialised, we shouldn't trust any S_IFMT coming off disk. Masking
to the lower 12 bits and reconstructing type from vtype is the right
thing to do.

Two optional tiny nits for readability:

  * use a symbolic mask for the 12 bits we keep:
        inode->i_mode = le32_to_cpu(di->i_mode) &
                (S_IRWXU | S_IRWXG | S_IRWXO | S_ISUID | S_ISGID | S_ISVTX);

  * cache the endianness conversions:
        u32 dmode = le32_to_cpu(di->i_mode);
        u32 dvtype = le32_to_cpu(di->i_vtype);
        inode->i_mode = dmode & (S_IRWXU | S_IRWXG | S_IRWXO |
                                 S_ISUID | S_ISGID | S_ISVTX);
        if (dvtype == BFS_VDIR) { ... } else if (dvtype == BFS_VREG) { ... }
        else {
                brelse(bh);
                printf("Unknown vtype=%u mode=0%07o %s:%08lx\n",
                       dvtype, dmode, inode->i_sb->s_id, ino);
                goto error;
        }

With or without those nits, your approach looks good to me.

Reviewed-by: Tigran Aivazian <aivazian.tigran@gmail.com>

