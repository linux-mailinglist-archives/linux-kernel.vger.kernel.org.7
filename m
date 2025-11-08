Return-Path: <linux-kernel+bounces-891408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30851C42988
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 09:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7FD6188B032
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 08:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060402E8E0C;
	Sat,  8 Nov 2025 08:36:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA2428980E
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 08:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762590965; cv=none; b=gPBY3HTPRGr5AYqCaHoNJy26OAl9/4LtxrotsqoHvo272GH/mkFfiYH2fxEn1yRXyx32jDf9qHozjNkvXb0tQcf85OdWL3T3PN1khMpAAswesSzLiWT5s7d6rUbZ2u4qbNhSfyFddUq+i/3QGAwXgqIUc4YgOXqsdH+dV3ZYXPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762590965; c=relaxed/simple;
	bh=2lFkvML8NpYHKITe8/6n30B9LFLUYjCZNzJ2UJERqMs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mWb0apiGfpZ1w1yEaNBSH0X2dG4LaN7TqyAQoW+xhEZREJZjPcFVh82KJirqx0ZzVRivVN9BXaYAfH/cdaAZJ1ZNyUc3A4ts+4VpdZ5Mh7jH41iUMn38hHXII9MlQmWX6AyoXT+CUfX/iaK1pnEY5COc3xARMSMpNvZNeUHQ1QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9486c2da7f6so146843339f.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 00:36:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762590962; x=1763195762;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=szqNooYML2fVTifbbPVcVVeKU5EKq+5MA4/QhARf/Gc=;
        b=YA2f963KgpBBqWWNwztB9Zbsi8JLUnPqAHZLUuDWv/156xK23kPhCbjDlm5ThzgRlq
         vicnzPwbwny3vuojD56xNrtPoNm/DS/1GX4Ss1Hef38j2oerBB2G9XVOa+5mSCwsGJuv
         6hmsX2/XsaZtv65SKnB1VLbSB2RDOPh2BLn2z3P7wdEjRgjysm3sg1nWThpAgjvPnDZh
         M/MZ6m3+6RjlCEp6JTXgb7HamD24D+UqdRqpGqqv4F+mzduIl0Mg59MW28U455LLf+PV
         SBpAeEiMq/0DY/TlJEKAoMEHTlOFYIz5SX4RvD/gOPXRGq+mrDNYLTe7xKvZoIvLOV8C
         XnGQ==
X-Gm-Message-State: AOJu0Yw4H3q/DQY5Ow07XVq2XCSkEC2k/FT5yRIWWjl0O+ArGcypWhIE
	XecuKg6ijdAEFM6MSH56tpx87tyZ1FDr47zdiUtAZXXT4X9d/bkTjpdvuNR5Vrssghhz+R1nESN
	TTpNxakCAuWNjH2zkKPZSsPzmHxwyHOOwib+2CH40zg/7O2qMVhRsynVhawE=
X-Google-Smtp-Source: AGHT+IGsN54bqht7xSDLUSlwQf3VbaeH9leyyycd8wkd0D6K90ce/lCgFp1JsDR+DvGT0uUblASIytcF2QpOZfX+N35CC+cH18vi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1644:b0:945:ae17:9ae4 with SMTP id
 ca18e2360f4ac-94895f835d5mr325869439f.1.1762590962421; Sat, 08 Nov 2025
 00:36:02 -0800 (PST)
Date: Sat, 08 Nov 2025 00:36:02 -0800
In-Reply-To: <e7ea1bff-0b4e-4490-b5a7-e8e366944842@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690f00f2.a70a0220.22f260.007a.GAE@google.com>
Subject: Re: [syzbot] [jfs?] general protection fault in txCommit (2)
From: syzbot <syzbot+9489c9f9f3d437221ea2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yun.zhou@windriver.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/jfs/jfs_txnmgr.c
Hunk #1 FAILED at 1073.
1 out of 1 hunk FAILED



Tested on:

commit:         e811c33b Merge tag 'drm-fixes-2025-11-08' of https://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=9489c9f9f3d437221ea2
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=177f4412580000


