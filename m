Return-Path: <linux-kernel+bounces-773682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F4CB2A579
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372E4682372
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3216322764;
	Mon, 18 Aug 2025 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="R405kdNE"
Received: from r3-19.sinamail.sina.com.cn (r3-19.sinamail.sina.com.cn [202.108.3.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD18232254E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523169; cv=none; b=V7B9BQbPC2yA7bVSSK6mdDwMFQeJAqG+9zO4hdtFElzOnXVZx+UeTSaJJnv6uK3IUbbraHKxzCT8n8B2a6WczVMew7ZK5SQJE9KoHF/0Wuso7TkajlHfB6GaRCGA68UNdXUqq0RZMlPLgP5BgOwx+KOnZT+uDKr3ZyOwYT7WogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523169; c=relaxed/simple;
	bh=cw+mFsva0r0rc/UPsp/Qzfc9H7ufTAw/PJtVdJ3cyas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hV/XMCg3m8VNeRDU/Fjd9+axPieSabeUXri3vNZE6r0iGplMVnh3KZws40aVHdhPDZtxmnDmSDweJK2SpGVt3WsSLDlGpbqx19/Cxg2ozj0HmULeXzxROznClsNpLUoTlPKHwayNYPOnaVoqH9L4HCUYj4DADfx8dJY1l1mxKb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=R405kdNE; arc=none smtp.client-ip=202.108.3.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755523165;
	bh=Z+NQlY7Vlux31r/I28AKJlUnAgDcb7zO0DrD8QqSU+M=;
	h=From:Subject:Date:Message-ID;
	b=R405kdNEYJtGYrJaZbrPralXt/IBStWdlocUQHTzvqONhuiHEOAnoqE4p7U2x64OD
	 mfMHY9E//MUPMKZmtqAV4UUKSe16rA9McqDC42b9GngF8zghWktB6HdhqdC0LxjmHS
	 AlqjATrTRoVmo7CZBWSOAWGeIchSpD2veBVUx13Y=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68A32850000034CD; Mon, 18 Aug 2025 21:19:14 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1287384456884
X-SMAIL-UIID: 4F42D666B24B4A1CADBC65E4A11CE4CA-20250818-211914-1
From: Hillf Danton <hdanton@sina.com>
To: Breno Leitao <leitao@debian.org>
Cc: syzbot <syzbot+f65a2014305525a9f816@syzkaller.appspotmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid context in vfree (2)
Date: Mon, 18 Aug 2025 21:19:01 +0800
Message-ID: <20250818131902.5039-1-hdanton@sina.com>
In-Reply-To: <4tu4bjs72dqx2pbamu7mc72dg5fxmrbaklbljyppxllr2hccmf@ig75eaoswryd>
References: <68a2decd.050a0220.e29e5.009a.GAE@google.com> <20250818100758.5020-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 18 Aug 2025 05:40:58 -0700 Breno Leitao wrote:
> On Mon, Aug 18, 2025 at 06:07:57PM +0800, Hillf Danton wrote:
> > > Date: Mon, 18 Aug 2025 01:05:33 -0700	[thread overview]
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
> > > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=15232442580000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=f65a2014305525a9f816
> > > userspace arch: arm64
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14cbaba2580000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1157faf0580000
> > 
> > #syz test upstream master
> 
> I was hitting this issue and I've tested it and the BUG is not there any
> more.
> 
> Do you know which commit caused this "regression" ?
> 
Looks like the tglx dude's work [1]

[1] Subject: [tip: locking/urgent] futex: Move futex cleanup to __mmdrop()
https://lore.kernel.org/lkml/175414093081.1420.8088049602488588887.tip-bot2@tip-bot2/

> > --- x/include/linux/mm_types.h
> > +++ y/include/linux/mm_types.h
> >
> > @@ -689,9 +697,8 @@ void __mmdrop(struct mm_struct *mm)
> >  	mm_pasid_drop(mm);
> >  	mm_destroy_cid(mm);
> >  	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
> > -	futex_hash_free(mm);
> > -
> > -	free_mm(mm);
> > +	INIT_WORK(&mm->drop_work, mmdrop_workfn);
> 
> should INIT_WORK() be called at setup phase other than at any 
> __mmdrop()?
> 
> Also, is the scheduling overhead a concern here?
> 
Feel free to forget/ignore the tecknique details like your concerns
here because the diff is only to cut the added vfree in atomic context
from a square skull.

