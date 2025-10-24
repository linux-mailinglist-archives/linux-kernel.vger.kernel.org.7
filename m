Return-Path: <linux-kernel+bounces-867998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7367BC041C3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2307A4E673B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E272B21257A;
	Fri, 24 Oct 2025 02:26:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197594C85
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761272768; cv=none; b=ICLYITP+m32+pvlkvJclaEHH8EC5dA5O1KYq9afzjAkzY+OrgGFI+shQjYJMIKGGoXwf2AQI9Ai2ev6tTeJOcx3FwPOMw9WpTG/EqhewypaVpfiaYILEp9J9ThuAoxV034N5S3B3hZ88Gl3ujT/2bdVWfRPU5V+C4zw97E8/M5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761272768; c=relaxed/simple;
	bh=5s8VNWVz9uVdNe5Jkjg/g6tRI4HeHhPiP3/rv/ckn0Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JzuBr7oQSzxPLGCeikvSsFeztySrX4TbEjMuzBOJSusP0LqZdGYUCnF6z4PXEKVuueiSb2RZqNNJ4QO+4Ns4bfVP09xfuDp2nYR5AFynrV7Y1f/xzlW4JR4Tf7cze3fbzjQcBWsY0EXjvYRKg4ljPmXoGOjb5mF09kWTGq10Azc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430db6d358bso68985335ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 19:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761272764; x=1761877564;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nuvYHZXFcq1HN/ZvbZei9bEYMbptX1KclhCU10Q2TzY=;
        b=nQt4U/Ptt66JF6bHXdwgfyDy0RO9YCxDXjSYIWe2W58XtU0xVxKIfxls83lFEJCNYK
         srfY4Eiqv6xvptlo+DpTqbNoqB/wCUiiqBblCeQSM442NttR62+iAnvyRKQzasN7NsG/
         PdirZtcrX2rG/ZgmLmsCok/Q3qL+yBWwBjxpUpuTWL6lSyiWnohdcs7z1LTAzeondxWG
         /qN9C0Heac3xxxvN+ufQgWizBR+7KtLyy7EeWrrVMDpHAY25NVpqRIStVWNJ4BmzQIxW
         93oSsihpt9HiMOTVoM5wxZTE7ncIud3wjhjJ8kpq3/f42OlezcPK3osTPswGdeY1qpvB
         cuPg==
X-Forwarded-Encrypted: i=1; AJvYcCXn6WRye5mWoIvs1wcaH9DrLDYsAF8dCwCU5FHloQB8qsbYplb2Rs357xBv6WNoUQVtQTujiwsEmJRPgL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpJFwO45I1YD30DhCNfXxqENLqQYtCfQhUf/hEsPCxrS3rjV/W
	qHVsjTTtPL3FBgTRG9bqfz4+sGxtGYQCq3Xdia73ZjE3w1wUPj8qkKFftP2NMsU8afUDGs5Ujes
	pXuNtD1p70LUoDP999L3g4KuqbSBdjyJS8q1WUkYX2kX0O6YLP+CnnMRcKbQ=
X-Google-Smtp-Source: AGHT+IFpmLe9/pehpSvw62yma21VozoojdjtP5xCLJcpSUT9PKOcRLGXMW79hQfDvB+ASukNC+R/Lg2j6lN0dFHstlnlvKWk3+kY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2789:b0:430:9fde:33bd with SMTP id
 e9e14a558f8ab-431ebeb3efcmr10462165ab.1.1761272764267; Thu, 23 Oct 2025
 19:26:04 -0700 (PDT)
Date: Thu, 23 Oct 2025 19:26:04 -0700
In-Reply-To: <CAHxJ8O_3H5QQ+x4=kdaXr4ELfqO3PCxGO49Ds1yA7mAcBGBh2g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fae3bc.050a0220.346f24.008f.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] WARNING in ocfs2_unlink
From: syzbot <syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com>
To: eraykrdg1@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com
Tested-by: syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com

Tested on:

commit:         6fab32bb MAINTAINERS: add Mark Brown as a linux-next m..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b4ae7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1215729170d20fc
dashboard link: https://syzkaller.appspot.com/bug?extid=55c40ae8a0e5f3659f2b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16d1c614580000

Note: testing is done by a robot and is best-effort only.

