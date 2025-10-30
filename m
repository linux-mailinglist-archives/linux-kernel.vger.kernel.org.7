Return-Path: <linux-kernel+bounces-879202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC568C22835
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7AD5934E59B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9266338900;
	Thu, 30 Oct 2025 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYxijps6"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674EB3358A8
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761862093; cv=none; b=J/J7dcX1jS3K6j6i1tORuEuQpWx+DzPiIL+MZiVwD08kNg2+16kMUMEpcLi4gjMT1tv6WtLJYZPZamiMeRijPwhAWQ5ykz5T7W7gtkD5h6hrWlR5PveS6/7u8Yz0n3v58917cgkiO2pscjAkZYpntUGlTTLs/D/TDbOCBO7WQwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761862093; c=relaxed/simple;
	bh=7ru5F1kwzreOleQxP1/PtdtLEReJTNcVqATHU/+UTRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0TsrfRuWyNrhJYc+yDWh3gk6XGAEanlwN2alrneeNDDkKafBYxngBVVjQq3OfvbPdpWQcPX+ORZ739jn0tr8EDDXICqwxFuQ037BOLTVIqW3ymQU5rr/zD5HGqtY9EhoCZX8jHBOp+W5n7tPKPR4FuboLM1YcQI8fCoKsiDsI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYxijps6; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b6d4e44c54aso235483266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761862090; x=1762466890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LxObTOLLtZ8xxLgeHDO09rzfBk1nZUK8QTcdiGvecg=;
        b=KYxijps6ZrXHIMrZbZe/HM2yo7FAyNITZ7g/EszPD5J82HZ/WEqqN6xuXPrH/nX4A6
         1R67ZAkQUnQQdgkvzkau09uxxENFoBurBooesKKxkQFim4XwCXfjpX8fJstTVyqHP1ji
         RrBDFWhvmHfmvxC+2DEt8RknQZ4/4vEGXBawUsdxYZ6j01APRe+ICOo+8qCxGPad1rPK
         jYTQiD/LRGSEej2KYibNitri6bm6bI+u5BfpCVxFTtHitxLX9V2vcAX25IEq2U4ph+iS
         Cp0CAlWm2X6vI1X9UdEunGB52k4M3TbljQgxofp/FmI38mMG2yHRlSw6TYS35wYs02Oa
         Y0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761862090; x=1762466890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LxObTOLLtZ8xxLgeHDO09rzfBk1nZUK8QTcdiGvecg=;
        b=I7DmHozhWpQXmXpb3F8yB0mQ/EPGbWuXICdeDf6G03EqX+khCyPHIjti8Q3XKiZ2+/
         DwCT4HzBGOeWixC2+Iu5zwG+gBNvTTILbEnBBl1KNcPsVSyVPK7VNPE5JAunBA3+kF7N
         COf6AxI7RQr6Jbu9i0Uc8VD52lJKalHW6zGDezMc+LC18YrZn7ZSwVvt/d2gaNyz8hXK
         Y9BdVuOAa01+RnV7D/23jQXYsBLNwREii9tK1M3A8fvZi/95UXPKm2BNjzi6Z24Sk8WH
         HSAU9gLNmt4NDHQzCPau34TeY+4NF3MM4w7upt4dvwGczpexoiq5SUe1Czk8x9PdlS+S
         VHaw==
X-Forwarded-Encrypted: i=1; AJvYcCXUD4vp9cO6PbOFh1d1YPSLUo/x9vuV7rwOo6tE9O5BLzrb8N4TZ4tr6JCpRMuDcJ7nKR44BvZTM1ku7BM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgCmO4BvMNptBTnl6LCslW6STK30a/dzvpzFHvOPiXWzXmI/An
	WxutjCzfsr8wMSZNKIw8j0itTV3WwcPizuSTgYmv8TCCBqzEOXlxszj5bvKNxtoO15gIZhYu7nP
	30kQtyZqMUwupi6E1YFHoS6rimdzmit8=
X-Gm-Gg: ASbGncvBIDJ8iD+HAqZ5/w1AXIoxd6PbAS5cdpLuQHLrrnM7uwLDvymlyqOgupDcyFv
	dQTU9nnVo20tP7UGxVx60QFOMin8kU7+imEtV7+bvAv1TU6cAVft/QsspH+9VGA1Yt7Ow3uubNV
	09Im8WWuetZmARXAO++qSdUUvIHvwTcNMvwNyZCWpMFSDlNwi2lABV2bQe1yL1YW1umkPg0snh/
	CZVujMkRopp5tOGAFNT7xewZ0tZtGvZsmZQgwkFrWE5NE7GMjnuDKbDhQ6Si8NOaPxDOsGW1DQe
	n5hGLZoEXBzk07syxJjAJFOCbSQ=
X-Google-Smtp-Source: AGHT+IGR0wVutOFEKKEV5B5/riddaJS0BmFT14SEyFfKcUf47Pqu9r1kTsM350wF3kTvfvSWEdaPWWrc085FHNWrRC8=
X-Received: by 2002:a05:6402:3512:b0:63b:f05d:b985 with SMTP id
 4fb4d7f45d1cf-64077068b44mr856508a12.35.1761862089107; Thu, 30 Oct 2025
 15:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029225748.11361-2-eraykrdg1@gmail.com> <wzykonhpj76qowdn24inwtaji4zfclesmc3lqnnc7cn6jkyjl4@oauagnarupov>
In-Reply-To: <wzykonhpj76qowdn24inwtaji4zfclesmc3lqnnc7cn6jkyjl4@oauagnarupov>
From: Ahmet Eray Karadag <eraykrdg1@gmail.com>
Date: Fri, 31 Oct 2025 01:07:56 +0300
X-Gm-Features: AWmQ_bl6GSQvlP8PEpYdfCdNwc9EbQga3YjgmFaSDoIhjzzpIF-Mu3RGnsKkrYM
Message-ID: <CAHxJ8O_7-PfJRyGp9-1KOkwmYJWQDzCvvo_P-jxzbzHoqXyH9Q@mail.gmail.com>
Subject: Re: [RFC RFT PATCH] ocfs2: Mark inode bad upon validation failure
 during read
To: Heming Zhao <heming.zhao@suse.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	david.hunter.linux@gmail.com, skhan@linuxfoundation.org, 
	syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com, 
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heming,

Thanks a lot for the review and comments.

Regarding the placement of make_bad_inode(), our patch places it in
ocfs2_read_inode_block_full() because
ocfs2_validate_inode_block() itself doesn't have access
to the inode object. I believe this (in the caller) is the
correct layer, as it seems to match other patterns in OCFS2
where the caller handles the make_bad_inode upon validation
failure.

I had one question about your proposal to combine this patch with
Albin's [1]. When you mentioned, "We should forbid any write
operations," were you referring to Albin's read-only check in
ocfs2_setattr as the mechanism to "forbid" the operation? Or
were you suggesting we should use the inode size sanity check
itself (e.g., by converting the BUG_ON to an -EIO return)
as that mechanism?

Thanks,
Eray

Heming Zhao <heming.zhao@suse.com>, 30 Eki 2025 Per, 10:59 tarihinde =C5=9F=
unu yazd=C4=B1:
>
> Hi,
>
> In my view, combining this patch and another patch [1] is a complete
> solution for this bug.
>
> According to the oops stack, the FS is already in read-only mode.
> We should forbid any write operations and then perform the inode
> sanity check.
>
> And I think ocfs2_validate_inode_block is a good place for make_bad_inode=
().
>
> [1]:
> https://syzkaller.appspot.com/text?tag=3DPatch&x=3D1287f614580000
> - by albinbabuvarghese20@gmail.com from:
>   https://syzkaller.appspot.com/bug?extid=3Db93b65ee321c97861072
>
> Thanks,
> Heming
>
> On Thu, Oct 30, 2025 at 01:57:49AM +0300, Ahmet Eray Karadag wrote:
> > Potentially triggered by sequences like buffered writes followed by
> > open(O_DIRECT), can result in an invalid on-disk inode block
> > (e.g., bad signature). OCFS2 detects this corruption when reading the
> > inode block via ocfs2_validate_inode_block(), logs "Invalid dinode",
> > and often switches the filesystem to read-only mode.
> >
> > Currently, the function reading the inode block (ocfs2_read_inode_block=
_full())
> > fails to call make_bad_inode() upon detecting the validation error.
> > Because the in-memory inode is not marked bad, subsequent operations
> > (like ftruncate) proceed erroneously. They eventually reach code
> > (e.g., ocfs2_truncate_file()) that compares the inconsistent
> > in-memory size (38639) against the invalid/stale on-disk size (0), lead=
ing
> > to kernel crashes via BUG_ON.
> >
> > Fix this by calling make_bad_inode(inode) within the error handling pat=
h of
> > ocfs2_read_inode_block_full() immediately after a block read or validat=
ion
> > error occurs. This ensures VFS is properly notified about the
> > corrupt inode at the point of detection. Marking the inode bad  allows =
VFS
> > to correctly fail subsequent operations targeting this inode early,
> > preventing kernel panics caused by operating on known inconsistent inod=
e states.
> >
> > [RFC]: While this patch prevents the kernel crash triggered by the repr=
oducer,
> > feedback is requested on whether ocfs2_read_inode_block_full() is the m=
ost
> > appropriate layer to call make_bad_inode(). Should this check perhaps r=
eside
> > within the caller or should the error propagation be handled differentl=
y?:
> > Input on the best practice for handling this specific VFS inconsistency
> > within OCFS2 would be appreciated.
> >
> > Reported-by: syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com
> > Link: https://syzkaller.appspot.com/bug?extid=3Db93b65ee321c97861072
> > Co-developed-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
> > Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
> > Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
> > ---
> >  fs/ocfs2/inode.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> > index fcc89856ab95..415ad29ec758 100644
> > --- a/fs/ocfs2/inode.c
> > +++ b/fs/ocfs2/inode.c
> > @@ -1690,6 +1690,8 @@ int ocfs2_read_inode_block_full(struct inode *ino=
de, struct buffer_head **bh,
> >       rc =3D ocfs2_read_blocks(INODE_CACHE(inode), OCFS2_I(inode)->ip_b=
lkno,
> >                              1, &tmp, flags, ocfs2_validate_inode_block=
);
> >
> > +     if (rc < 0)
> > +             make_bad_inode(inode);
> >       /* If ocfs2_read_blocks() got us a new bh, pass it up. */
> >       if (!rc && !*bh)
> >               *bh =3D tmp;
> > --
> > 2.43.0
> >
> >

