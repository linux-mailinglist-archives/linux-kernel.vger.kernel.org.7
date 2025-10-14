Return-Path: <linux-kernel+bounces-852761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C4ABD9D40
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6978818A41E6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A92531353C;
	Tue, 14 Oct 2025 13:57:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F25313E1A
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450225; cv=none; b=Ff/ozav/Avsbo5w4pyU34I3DoV2PlQEzyFviyOOSuk8/sRx5WOhlMKsYTW/H+1Xdo5TgCZHjMIwEMPzyrJPvkfTUPLiBQKLGy+Wskyxa2L6WjwOMtIybDFTCBEd4wXqn0eqcUjy6OQPhqKSoqp0qLMpmjY0K9x6N3YBJvIdyTZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450225; c=relaxed/simple;
	bh=5YzqR6FO35MStpZhsgsJ1AFVYtReqhpA/fgeEqiVF3g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Gm9gLUViwPqb6+uill5J5IlOOZMZDfj0WRD/F5VqV+N6H5QPq0oKHXirhwGqUH62slIaIYqBTD1ssCUz4Du7isWWLLKZepndAnxgeCAikWLSz3S+nfh7xFJQFKIgo2AQxfICANVSFU/flw12aYaqzn4cVL4U1qpnSn2WPuDj/iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42f67904af6so337883465ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760450223; x=1761055023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zOd+QAyfKKv22fuf+dORkpAdSTzN0DulbD16Tp0tVeM=;
        b=matA/FRpGKG0pLghHHSwOAbrIlsNC28WojifrBa7F/DE3PfAYzkeb9bx1ptDjSgTbx
         S58X3MeXr/ws8Kttkjlaljr09ADA+VkEjcx9UdHCvBG8NNDX+9ly/fRyBjZdXfpavC19
         itj+6TJS7x6B18bZ/8k/T1d/VqBVMrHBA6VfmYNA8IqRrsf7xkOZeb+DrHTOm2yY6Rkz
         1brBSs6zhLO6/+4aRdMcUVrymitRTqCkoUnuoqNTdndCp75QhkY8uTRgNPAFxo21T9Ar
         +nFR7hN4P0iiy+FXIBqjhkK2GweLpd8JbyCTB8kzEAdb4veEoKDFE7QxmFXFzvSdLLy2
         jDOw==
X-Forwarded-Encrypted: i=1; AJvYcCWYT2stFrkT7P0HZWT9sK05wtuQ+wdkR1t2Vx9TMA6H96Ys7buCIbrUEbIOheB9SGANsuBKvExSM6vQMxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEtvhKU5JvGdwhWTqz4jyQ5R91qGVAWo9PPBAKjSCdh9zTrS6p
	9MjD/QLT7pwz+4DKVDotWh5Pl9UAFYh6TkMsY0dUy67zX3N48amu+TPn7fDzoZsqWpEqqMDw1Wb
	N3hIHSv9eR99VzZan/kGL6PLN6lSDVzYNaHy/Qi8lTtP2wq16KpSY0R58mg8=
X-Google-Smtp-Source: AGHT+IHtYQxClrjPaG2+Z+jLZxmaceP2CARPiONlCBxHQ+ILxgdIPymrh61D8igQSdTqpgRo+h8Mqr9CNjdN9FjJnfRerDovowPy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:250c:b0:42d:8b1c:570c with SMTP id
 e9e14a558f8ab-42f87352e96mr237129675ab.5.1760450223386; Tue, 14 Oct 2025
 06:57:03 -0700 (PDT)
Date: Tue, 14 Oct 2025 06:57:03 -0700
In-Reply-To: <20251014132504.642005-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ee56af.a00a0220.361615.0000.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: trying to register non-static key in ntfs_setattr
From: syzbot <syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com
Tested-by: syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com

Tested on:

commit:         3a866087 Linux 6.18-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11cb05e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af9170887d81dea1
dashboard link: https://syzkaller.appspot.com/bug?extid=3e58a7dc1a8c00243999
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=164f467c580000

Note: testing is done by a robot and is best-effort only.

