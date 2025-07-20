Return-Path: <linux-kernel+bounces-738080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50306B0B40E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 09:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5AA17C3C6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 07:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D10E1D619F;
	Sun, 20 Jul 2025 07:12:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BCBAD23
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752995525; cv=none; b=n/4/TseW9B6NRXP6hsJDY/W2kZsQbgqlc/X8nXElHW9GnH70a+borQn71MhyNhu2Pu7amULZ9LIv6ahSubv3M17GR410eXunat1uFKbRwxOJcHftVwZ3OUjv5TqD2NK7Bvr3IWC426PvGUFTwGL1UNvPQ2sTvtlIl7dWXGSTrkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752995525; c=relaxed/simple;
	bh=B7vcwDw15jm5v/OBk2RY7LtYnWARRBjhGh8wSvG/k7s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CcvhhzK/NX6Jy8b3P0Gvl32BIohbD+7/lIy5uRQV95cztPCSs7kJf8fgWk7QOOPqA+txk3nXAnmHBs9xtgaU69lxsxvXkPzZ1AtBUUtmQDUF3ulBikyPjQZISfmr/QLrZSLEVYh62sNP5D6LgJydS+GfNb3GrfY/US1kO/Pk/rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e29b48525bso18047685ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 00:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752995523; x=1753600323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r4uz7h9D8eWExTu3SquXQFAKVJC8Vi5HYalQ2f3+Rsg=;
        b=mUfpUjkeMz9+ZvvzJrKTC/jrFflm/2yz/MFUDZ9n5MzgVLLIoM0jMpydzg1MIAT2nL
         PxURaUWNNGHh+o0Lh6IkpXmurVQiG/LZWvNx5uo5CYW4u0RFtOvo4SmYg4uaj3plQjQM
         yLPbX81K+QSOWr6fiPINRGDWjSiTaNVrDQehIXUR2EhJVed6Hxt+QFgygYA7D6TucC36
         7/whbeYLIF87tkTnEYEmo1N2Fawo+UOoaHthwuKvgfImPQiUnvmYwUn1CPNOvPNhVNPz
         6aOqtRdPY3O/i+JVRRstvszROIcu5Lcx7FFmhVcLP01KfwKUN+Tb4WIR7Jx0rKYjlY1p
         4d9w==
X-Gm-Message-State: AOJu0YwI6Mth6l6RATJs/GMxnN9fENOb0tUsCIVUxO2QIcOX5Nca4+SU
	3xkdtn7nG2V1MEbWdK7ebYOtHKuoLNtOUqw9DHmGDIKGUawgty5MjA32BNGhamxy1+WAc+It5za
	jgvJw+v+7npdGl77H0/fh1L4PVonziyz4GS47feqQyxcsv5gKzcvOqTJXNd0=
X-Google-Smtp-Source: AGHT+IGePIJjLtUSxKV+eFWOgFd6q/fbWiu+UtsujVV0sWLb9PszSK4QUsLduKB5FhfWwdYtQe2HtRW+PZY7D1bGXrF1xV3ikdfn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160d:b0:3df:3926:88b7 with SMTP id
 e9e14a558f8ab-3e282d590f6mr176553805ab.5.1752995522799; Sun, 20 Jul 2025
 00:12:02 -0700 (PDT)
Date: Sun, 20 Jul 2025 00:12:02 -0700
In-Reply-To: <CAMp3bLXKFqL5nkRkTVBNOKv968bK61yAT=b1wkoz+SZqtk0yiQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687c96c2.a70a0220.693ce.00b4.GAE@google.com>
Subject: Re: [syzbot] [fs?] KASAN: use-after-free Read in hpfs_get_ea
From: syzbot <syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, purvayeshi550@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/hpfs/ea.c:139:54: error: no member named 'ea_off' in 'struct fnode'
fs/hpfs/ea.c:139:70: error: no member named 'ea_size' in 'struct fnode'
fs/hpfs/ea.c:140:41: error: no member named 'name_len' in 'struct extended_attribute'; did you mean 'namelen'?
fs/hpfs/ea.c:143:57: error: no member named 'ea_off' in 'struct fnode'
fs/hpfs/ea.c:143:73: error: no member named 'ea_size' in 'struct fnode'
fs/hpfs/ea.c:146:17: error: no member named 'name_len' in 'struct extended_attribute'; did you mean 'namelen'?
fs/hpfs/ea.c:149:56: error: no member named 'ea_off' in 'struct fnode'
fs/hpfs/ea.c:149:72: error: no member named 'ea_size' in 'struct fnode'
fs/hpfs/ea.c:152:11: error: no member named 'name_len' in 'struct extended_attribute'
fs/hpfs/ea.c:152:23: error: use of undeclared identifier 'aname'
fs/hpfs/ea.c:152:55: error: use of undeclared identifier 'aname'
fs/hpfs/ea.c:153:12: error: no member named 'type' in 'struct extended_attribute'
fs/hpfs/ea.c:154:27: error: no member named 'size' in 'struct extended_attribute'
fs/hpfs/ea.c:154:6: error: use of undeclared identifier 'buffer'
fs/hpfs/ea.c:155:11: error: use of undeclared identifier 'buffer'
fs/hpfs/ea.c:156:13: error: incompatible integer to pointer conversion returning 'int' from a function with result type 'char *' [-Wint-conversion]
fs/hpfs/ea.c:157:50: error: no member named 'size' in 'struct extended_attribute'


Tested on:

commit:         f4a40a42 Merge tag 'efi-fixes-for-v6.16-2' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f09d04131ef56b22
dashboard link: https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13b084f0580000


