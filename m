Return-Path: <linux-kernel+bounces-764366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 521CBB22215
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254DC18C6A94
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3572E7629;
	Tue, 12 Aug 2025 08:49:21 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0312E62BF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988561; cv=none; b=dsIFr+bLiWfPn6eH0HjkwVZ7mSl5eKF5BUeF4VMCqLZAA5MWbnLXX6hR17jyIdSVX/vcR0dwewLKpecQ1vOaIr0SoxJFU+bxL02/SIUm59DoTqUCuUlb7TYTgm8R3WMPokEQBRHoPSgzKHP3DsLXZraHTrqQ2Q+4I/yGd+VKJ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988561; c=relaxed/simple;
	bh=joC4jihkaES7PJZp425YJBTOpFFfmNeVymxE+lkSVO8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=a4Vs81OXFdvjtsdFaIxJWxG74SMtNKDctDqPdRXnxu5w1vrXjYRRa+9b+s7HRv4rEfI30edOUpL2Lt6GtN2tG5PkzHWJEQtMyxPHYgoNx87mU7nbUTQFSCCp7S3wU5BMQ3l0FHHgqizAD8r7p7T8UxHuojHJsqdi50wblb1i40g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8840458c4acso511904539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754988557; x=1755593357;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=joC4jihkaES7PJZp425YJBTOpFFfmNeVymxE+lkSVO8=;
        b=SJifSrZkIv+3dRKprawDGO3KoDlK61WVSId4LdrrT8GdLOwaG03nbhBOVjXpM4kdGZ
         qhRw0Cyc49WxeuL8jEZhx09EEY/GkKfMHkJLUovUDCWvuKLxBdzF0OeZ3X1qVZqKooOL
         PdDoZuKbs+M/Q2bVUInbLrDTfaFSYrdtdf+RHSKht0E0TYkOjr9EZORZRUe4FMpRBHUE
         Wsnc6B5UPeoii7y0g7ZXSMiC0HtBoJALs6yLhz1+sAGJE+PRiK4wsIefCqj03eF9Quh9
         ERktJBoIGPCXy4FGrssebD2DiOWRBe2qsqMeQ3xgdiRPW6WfGJHToMGz1/GYiKNPmuI4
         ZzlQ==
X-Gm-Message-State: AOJu0YyAP/hr5ilUJpY6b8pzvosl6+Ib4UbbIlSIqaIsL73pq0V8RNsM
	kVsWKIYQvhEygcYIzQsFDdymr2ZMI6oAaAx/mv3SKNPFyjOknFBVynq0LC3Y6zjLm84Z7WgQSsT
	zhsemE4C3IU1lm0UcRM7Jb5ke7RrtU7lZMY9LgZLXZeRNetOWekS262BVMRE=
X-Google-Smtp-Source: AGHT+IFt8izzNPaHwjufX33OCUijTbsDyUd8YlncPYzpVi0DJ8C4piTfjA86Dk6jJu2NI9v/UpUjk+uK2HLwp1vgxG0EU5CPreza
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1492:b0:881:7837:6058 with SMTP id
 ca18e2360f4ac-883f10dcd58mr2820206239f.0.1754988557174; Tue, 12 Aug 2025
 01:49:17 -0700 (PDT)
Date: Tue, 12 Aug 2025 01:49:17 -0700
In-Reply-To: <689a3d93.050a0220.7f033.0100.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689b000d.050a0220.51d73.00a9.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 53e760d8949895390e256e723e7ee46618310361
From: syzbot <syzbot+30754ca335e6fb7e3092@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 53e760d8949895390e256e723e7ee46618310361
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 53e760d8949895390e256e723e7ee46618310361

