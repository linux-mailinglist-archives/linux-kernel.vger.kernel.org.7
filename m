Return-Path: <linux-kernel+bounces-781193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B566B30ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3182F17BB00
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20482E339D;
	Fri, 22 Aug 2025 06:23:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1AF189513
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755843785; cv=none; b=SDm4qYCVeruXKEYSpGYr8fni9p7HomwMvtgdyhj5EqoQ+4cxRL6lk+dfb7HS1nRKQSVghNJWfuVbyFZGnET3J/VYWxZ/zylhymkfx/y2usqTfU2tvYyxfZnM10pyvv5dJfK7oGYRp1zmKjC8FTLj+m72fl3DqeR7Z/Mo1WipE8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755843785; c=relaxed/simple;
	bh=Dylnn9STzEcHPnDmLLGOARyMDLmFTrv1yovTraQ+Bis=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SmA1diWFqz8TXPeY/VXUrX+pVb9iGtQMzxDhRALFz+8uq2nHurUaXFdyTf2iO/egNKODMBd/Pbf67hzvVA/gIhOiqSNngNzzz+gHdP0WXG4jWdexHkQkYajH70feaMAd5hKKQqdeGBpPk4pD2uYxCQhjx5Ll7NEmZ2mlSPOlnqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-88432ccc4f9so380122039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 23:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755843783; x=1756448583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZHetISihCQ31cAwVL3d64sT4gcaGxsiZd2b+58jwQ0=;
        b=GhV2oeBJeXIIPJzc1C+kV3jD/68wpXr+w074M4D0AWlRrzKcA8c4ziMYhSHEPM6cBN
         S5M9W4p+Yhr2Vg12Qtiv5MXjcksrqIBZ+tK5iSgvICbGqzEHbOfYpLBzzFSihMjugyej
         apmNqsKYGV4O9DEcnhw4ecpZLvhSi9Q/Vpz+ovjcoiPv3lzy3bghDAkGQFNWytH9x9dC
         cg8ZND0bkxNMEM4fic0mlcqSJI2vHhHTmDVff+1eP615ebKAxDtSw9y5riVYQsrJJTbw
         E7nEmFfE+Aqs95mo7EzE6WWgAPRnPwsmcU6jy7MRNLAGLHURh8LJVRnUvhpZOW4SMxpe
         VTNw==
X-Forwarded-Encrypted: i=1; AJvYcCWg432AbENJ39UrYourGKsAe7x34ePkyk10CyBCW/Usa9aTnwOM9iKb6Ai66prvtuqiyU5v9lxCl67lj+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3bGNnV6m2O+89y1wPD0hDUW/3JFxlPM2UdmB7h2HmbX4sSXwa
	5T2KdJnSzPRMlJ7PmCLJG2OUVtZTyj7TKtyNgRWQD+czl0lgJQ3MqvVPnTwUgz+VP/2JxDlSIXv
	z18yX3gfEckMnb2GERGY9zWeh6dD2wGc6F6oAft5NHHHfdiLMGkRSEk4vvl8=
X-Google-Smtp-Source: AGHT+IGfiTLDD+d7klCLoJzYIf8E+KS4WHtq3xDTk/LZWiWog1RDc4Ab+uSsBgOp1NXv34WmMyQ0E8qXJWMxaPzwl+nkO6k3bol3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cc:b0:3e5:8249:e973 with SMTP id
 e9e14a558f8ab-3e921a601e6mr33646425ab.16.1755843782954; Thu, 21 Aug 2025
 23:23:02 -0700 (PDT)
Date: Thu, 21 Aug 2025 23:23:02 -0700
In-Reply-To: <02587840-3222-4dc5-b039-9084d8a5f37d@arm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a80cc6.050a0220.3809a8.0002.GAE@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in page_table_check_set
From: syzbot <syzbot+49a796ed2c9709652f1e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, dev.jain@arm.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, pasha.tatashin@soleen.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+49a796ed2c9709652f1e@syzkaller.appspotmail.com
Tested-by: syzbot+49a796ed2c9709652f1e@syzkaller.appspotmail.com

Tested on:

commit:         cf1b80dc mm: pass page directly instead of using folio..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=116576f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd02560acf543b19
dashboard link: https://syzkaller.appspot.com/bug?extid=49a796ed2c9709652f1e
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

