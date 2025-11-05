Return-Path: <linux-kernel+bounces-887136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA41C37568
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014431A21D2F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C08290D81;
	Wed,  5 Nov 2025 18:33:20 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E93527B4FB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367599; cv=none; b=Ep40S7vy5mXad5wqZ76S5hYUypqy6gcyt2E65WO6Nen6usWbEicUSyyIIkyvvnLaVLyUmG8qnqI0OZDcyCf5qfCjb5XF+aYr6AoLBRTOqflQByLugpQhwhrudj9G/dUIrn48tVLheLxpbe/zfDioAPARmiXoqT3ZegTEu0vIal8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367599; c=relaxed/simple;
	bh=Ieq1ck0qvm3ZmRsGLSRgTwo5ZTOdLuFi0WGVB/YIMwQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oLNVDY6DcztKPern5HzEL8p3updova9yeZgr/wWDF71gXH+OcsqzFI6oBxsvPRILoN+QXbkPg/Iimd2FZmjUqGAB9p+Pai3NoA6/a2pBsQNa5oG4CojOZZWbH9ODH3JpjjQLOhbDO+7J52kpolnhjskTHYJAfw1oo3aj2nFk4VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-43324a2096fso1042285ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 10:33:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762367597; x=1762972397;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OV9FnEIMn3tAb3e2Fleb7GR+066UTYm6BepX40jlcc8=;
        b=HvBU8KJx6aKM2BRXVcfg1bcDA/X7WogAuJNe/hciGlTvDi8NYnRVEfB63gARmFry4z
         U2h42PuNneZ3cbxXj9pXs5wkNg7Wn+iVMtf6BqA64S9LnPtWg/wTeroLUZLwE4i2lD00
         6D9y8Rv+eqz1aCGDdRPumzETzAzWjBWXY32W1IIEMXKBzu4FaDJ8fWMC81FnmzjiD8ur
         xSQ8Ke1m7jwGC9Jm+9TFvSHu25Yxy78Tf3VOHWttro7hPEI8PtwIoTpRUjs8L/DDUkoc
         UE9IYi93d9j6Nh5TujPgix++9RvMrQw9ggmCZLSt9mu61t2cLDEToKB6SOasl+YS3X7s
         6XxA==
X-Gm-Message-State: AOJu0YwyxmlYYE8CrKNOYI1spZGRPo2xTx5V5aJ50cbliIVcv2kLt2b/
	I5l4/+cHTVEOtObphGzZu6RACHOLvrkMSvn6Clz4FEQtvBFRNmWGJaWJ+kmHez2axDua2ICvSOa
	Rn5gEf3HKm4Fhy5GAB0wjZ+SpQ2SftA3EEmcSOZToEAcrsmZ1grYXjpRd68E=
X-Google-Smtp-Source: AGHT+IEYG2huvkXi45VYaVn40P4PGiBup63ZqfmOfPMhg4CNWPVkQXbqP7fKXdXLSBFWL0EajNaPMYe0FC1nMkgOWKWr4nfyD2Ot
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2283:b0:432:ffc4:b3f9 with SMTP id
 e9e14a558f8ab-433407c9db3mr58225935ab.23.1762367597314; Wed, 05 Nov 2025
 10:33:17 -0800 (PST)
Date: Wed, 05 Nov 2025 10:33:17 -0800
In-Reply-To: <68232e7b.050a0220.f2294.09f6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690b986d.050a0220.3d0d33.0080.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
Author: yanjun.zhu@linux.dev

#syz test: https://github.com/zhuyj/linux.git 
v6.17_fix_gid_table_release_one


