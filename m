Return-Path: <linux-kernel+bounces-869891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D988C08F09
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 12:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B43B534F3F1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 10:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E40F2EB86F;
	Sat, 25 Oct 2025 10:25:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC73D531
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 10:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761387907; cv=none; b=mfYp1+8lyLbcPz0lxcPv+1jKxK3+qUXziU1nSDJETCrFxGmS7+hgz3Mxz5eRNOiihPD6/TWb4S/S+MR5vHnKLQPBhJr93ehNJdaNu2z0gl83tDxLBOZPSbfmzYQgq4/nH6Rie70ZkpNqZQb1gY3nvRzO9vinxRLEMDqVmU1SdJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761387907; c=relaxed/simple;
	bh=Oj8JLfp9RHAIno95f1phY5gpdmi5HCv1YikjotgMaX4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FmEFmFEw9xK2agKdsoMWoTO0Wpi8aElOEVlC4F/tOLkVP3MhUBJCRKaP45ts0JlbWNXem9OqmZFoA7NHOr4rIrFl1FHtiHXCJa97+kK9+9q+djoAG2dnAS9x3BavflHgtR3A+shZUDl/veYENm24uVhNMy3pIPZHKm5Q5WisK8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430cf6c6e20so36310115ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 03:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761387905; x=1761992705;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nl8a1J72AG7zM7SUSNXLORvo2oDk1kEO1fKLciPWKe4=;
        b=RtXRQeJAnRoKKAVgUBvknAuwAR9UjOZGfm72ZfnLbkFVk6AWZX6YlMT6FK6Qx8m519
         DkS3q230i+zw5MnwD99qOClPIqlWMap6t4JeMkFv1X46E75y5SykiIn3TEwADZ5gaWhH
         uFoy/3cR+stD7wukB68ba17A2tTQj79J4Taroe4mLizXEXii9GXhE2v2lWwYqXIvfVAW
         V8FNMNhIIuEavP+RKuudQ7Z7iPKs661Ao6VA4WZUuKxpHz72x4CUKFL7Bk2YSNPUMbw6
         sXuGYsZm14t76Yy12iMD46xdO44JhAUSl3PBZWUsspzdmektdQB4vWq1X7GMdjvecglJ
         695Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6Xu2zbvMXEz0vaeJRa7RY0V4J+FCaMZhBVDp4zgqQX+A+4htduZyrtdgQw2XAfEMyYv2s9iZhC6/JKHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5fasDPbv9z/bOKbdwQ7ZRd857dTKiG/TD87xZkeslkYKEK3mc
	V/8byQN7tXfp/ZjYUcxWEoozTPGpAZrP7B8w0ex9x3pIkrJC2APIAAwpRqV5L7PGDiKlyRsEadu
	DBLloH2o99GaccR4idhNIcthpiS18PWu5Z4hlYusPG7LbHMXtgNoy5NiDWjs=
X-Google-Smtp-Source: AGHT+IGDk2wO2iwRRHP1v8mBXNK6zhyVZ7g0+egqwyL3QpsaqGQXCdh9ghikPo44h1jt7+B6NN48A8ZD1fq2YaU1xMVIaGXcX/o1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e9:b0:430:9104:3894 with SMTP id
 e9e14a558f8ab-430c5318de7mr404688785ab.30.1761387905357; Sat, 25 Oct 2025
 03:25:05 -0700 (PDT)
Date: Sat, 25 Oct 2025 03:25:05 -0700
In-Reply-To: <rdrijfoz5apghwj4zpymigdelzza4l3r5yzrwrpggd3nij3x7y@du4lgss3gexp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fca581.a00a0220.1c5a1.0000.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in raw_ioctl
From: syzbot <syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com, 
	david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com, 
	krishnagopi487@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	matthew.brost@intel.com, rakie.kim@sk.com, syzkaller-bugs@googlegroups.com, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com
Tested-by: syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com

Tested on:

commit:         72fb0170 Add linux-next specific files for 20251024
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=125cc258580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e812d103f45aa955
dashboard link: https://syzkaller.appspot.com/bug?extid=d8fd35fa6177afa8c92b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13036e7c580000

Note: testing is done by a robot and is best-effort only.

