Return-Path: <linux-kernel+bounces-885532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 768ACC333D1
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 23:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F0FD034C073
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 22:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F084B1C6FE8;
	Tue,  4 Nov 2025 22:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI4Z3F/w"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AE91EB1A4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 22:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295478; cv=none; b=hhZo/fg5oteREu4w+2NA6fOuxb/GqS9MrSDEf5QNN7ZgfpiBKm686iCnv5g/KGd1+bx9GEfZm5Ly5E2FtQx7t2srYKkGtAt+YwfiUrijVwwZQdTKJ8lARU6s9233e/hkj1XaHQyvHyLdqOl2x0frBghRVkxKFN0V+yeTDC2VBtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295478; c=relaxed/simple;
	bh=qlbJi6CQT+n1/uVC5NZZQC6Ch1uElRomX6k6JiAkjB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOlrHqqN0dv5/At1lQuTC28Bqj9YylYVb1ltUQPc/0iIOy554KZE6kiAL/BgcY123BeGOu5stR+lR2KUhuKmFuyuxsBwJfBag2oxUsO4TiUhR5LzXGexWPMvr746nvBBqV9hjZ2EhBXtdHdrqB6FmEaZY+nwe3FqoAlXMvIWA7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BI4Z3F/w; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640f8a7aba2so1169669a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 14:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295473; x=1762900273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9C5WZt85rCvQ7iKyht7ngDQOKVzbs+0o0ZE9snmn2Ws=;
        b=BI4Z3F/wEzkD+Wd5UbvIPoAVL5cgIg/BvceOGmhPTsMfWsp4lPZ8MKHssvxUoyPvvg
         XImT4wZySW4Gz9q14/7Wdi3vfbj/n12zaCa+vhweMu8JL/s5uVKrayYTStSLTY0a1wl/
         NhX7+26fQ6wUQx4mlrZbH4rH4aS0fK9CT6NB5uQfh8Vv8c9bs6R9mDaVLc5J2YPrElqV
         Adnpt7cQHoYAaJFLUp80WPIfX/klmw64zLNBdsi0KCRTaii7HabsJKWRk1840U8HsMgV
         YML8q0gSdIqNoDHucdzCCSwxCvjYF/oH4h4tE9igwOuTUSFMFrwEZgUqcAYAMQabUttU
         EqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295473; x=1762900273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9C5WZt85rCvQ7iKyht7ngDQOKVzbs+0o0ZE9snmn2Ws=;
        b=hT4A/eisLxskX0H3IAQS/scGf9UlkwV7WxMGSMQWFb0z3CwnP3WoUfq3V9v78PCvE5
         4UD8GWM2fHYlRu1yKNDMs+e6db1dA8k5i07moDJvPJf3LCg7NFbye5CuxoiNMdY3o+vl
         FIJYI5JC0f3x81jsOKY5d3/9/Bhi/rmJ5Wd6iJttrI+Q+boLNgU25t3LEeprUl51lsfa
         VJwv67jUC+cY8jYquKc95zygQ0sqzw2TuU4FHQ7JWaswBhEKxw1iGdP6NzzN76ZJmW0B
         ig79qYWIw4TVokzNK8wtvaOEOhSdqeGn0M9DaBCBGGyX/ctwTyp7DpAonH5g7q7JKaDA
         MTKw==
X-Forwarded-Encrypted: i=1; AJvYcCVAjfavRpVFddGWBeoBlPjtDcQXrnBU0CgfxQd80PDXRvcVPwpmmmVx3kWBmOpV/1XQF+/Vg0RvRVwIg5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4csO6n080CeYdAvf5hw/dZvxuoRR/kPehIA/2upj5oXZ+KXHB
	uySxTFGVBCvVdOFIEMsEJ/9EJvuWU+9YGdFIB2Oj43k16ojN2rO1tQoytO3hnsZbiLbf3WA5k4E
	qboJexbk4GwZ/NagTuY3KKcrea8pG1xc=
X-Gm-Gg: ASbGncs+iTuLZlE0WjPBHWAC4lHDAXeffrQS6XVz/lPOID0eH8SS5790sFd8LUxVrUP
	YcrDdrLR4y/AHwbvf3GIF137GfAf/fjY7JMjMe4i8KtF8CnDsQIIsOgMFW7SRKC0SiInnNch5ks
	e5F9OGHH+w75HO4fJaRd1B8zdKMOeWH4oKFB/ckbT7G6cBikOGvTZbs4F+X6C10F8zB9EbC9r9j
	+raTPbhy9SgHY8dW1cdAYNjRyFPR+8vQdXJkOya603rvuI2jZKXQIK8TUezP5PDt6E52pQ9Z9w9
	b+jg2FcYfVTaxJqjfYDMuXqoKsI=
X-Google-Smtp-Source: AGHT+IGkfz+qjDL3k+h5Laf2ETyxJ3mO3I0sjY2eJBKDI86RPmEM4cuOT83qYE1w0rrQkzVZmnhlgLzsRzWS+8AcLAc=
X-Received: by 2002:a05:6402:280c:b0:637:e94a:fb56 with SMTP id
 4fb4d7f45d1cf-64105b7a5famr781421a12.35.1762295473353; Tue, 04 Nov 2025
 14:31:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029225748.11361-2-eraykrdg1@gmail.com> <wzykonhpj76qowdn24inwtaji4zfclesmc3lqnnc7cn6jkyjl4@oauagnarupov>
 <CAHxJ8O_7-PfJRyGp9-1KOkwmYJWQDzCvvo_P-jxzbzHoqXyH9Q@mail.gmail.com>
 <qfizhbe5rwzddwnoekr6xjy3gozbqbtl64c5xmfeuudxvficmv@onazesxv4ur6>
 <aQQ0DLqL0iVN7D15@arch-box> <leys5guzkcvlilaccjmsw7cvncm6o2vqo2wwezhuz7r6lcfjnk@va3cnphl4zf3>
 <aQS_oUDXGt_nF__d@arch-box> <stmj7kbqis2idlscf5iwch23ft2azuyyr7q2kmelavjk5lnug4@66in667d6bym>
 <aQTGFvVX22RmDhb0@arch-box>
In-Reply-To: <aQTGFvVX22RmDhb0@arch-box>
From: Ahmet Eray Karadag <eraykrdg1@gmail.com>
Date: Wed, 5 Nov 2025 01:31:01 +0300
X-Gm-Features: AWmQ_blkF6ejm-czi2Y2XOMbxdhh-bOt3sr0JARj8POY-hJwKrtKgmSpVDXLl_E
Message-ID: <CAHxJ8O9Yci6QzGckrsWhuoDHatYyOOok++ySmYc43WbEhFy3xg@mail.gmail.com>
Subject: Re: [RFC RFT PATCH] ocfs2: Mark inode bad upon validation failure
 during read
To: ocfs2-devel@lists.linux.dev
Cc: Albin Babu Varghese <albinbabuvarghese20@gmail.com>, mark@fasheh.com, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	Heming Zhao <heming.zhao@suse.com>, david.hunter.linux@gmail.com, 
	skhan@linuxfoundation.org, 
	syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi folks,

I'm having some trouble getting xfstests-dev set up to test some ocfs2
changes. I can't seem to get the configuration working correctly to run
the ocfs2 test group.

Could anyone share some insights or pointers on the proper setup? Any
help would be much appreciated.

Cheers,
Ahmet Eray

Albin Babu Varghese <albinbabuvarghese20@gmail.com>, 31 Eki 2025 Cum,
17:22 tarihinde =C5=9Funu yazd=C4=B1:
>
> > > > I support adding make_bad_inode() in ocfs2_read_inode_block_full().
> > > > ocfs2_read_locked_inode() calls ocfs2_read_inode_block[_full] to re=
ad the inode
> > > > from disk. However, ocfs2_read_inode_block[_full] have many callers=
, and in
> > > > current code, only ocfs2_read_locked_inode() marks the inode as bad=
. All others
> > > > forget to set the bad_inode.
> > > >
> > > > The 'forbid' write operations when read-only mode is worth another =
patch, and
> > > > I plan to create this patch. This patch adds a similar ext4_emergen=
cy_state()
> > > > function for ocfs2.
> > >
> > > We're working on this as part of the Linux Kernel Mentorship Program,=
 and we'd
> > > love to take on implementing the read-only check if it's not overly
> > > complicated. We're just beginners, but we thought it would be a great=
 learning
> > > experience to work on this following the ext4 pattern you mentioned -=
 if you
> > > haven't already started working on it by the time you see this reply.
> >
> > I haven't started the patch job, you are welcome to take it.
>
> Thank you! We'll work on it and send the patch for review.
>
> Cheers,
>         Albin

