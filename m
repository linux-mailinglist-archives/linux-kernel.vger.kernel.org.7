Return-Path: <linux-kernel+bounces-882983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64051C2C143
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F94188DC70
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A7D26ED55;
	Mon,  3 Nov 2025 13:28:54 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F69526ED31
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176534; cv=none; b=sUisJS17Ndq8rN4vKO10gCzH0ZCTDCa1HU7mWVwyZevXx2F0D6M1moUQHw79F+Ij4WBUDxmSn9lmdPi6wSix/TGqbjIZTAnTfw2qcSRwZDAMzC9zCVErlRfzpQixAL9e90h8EGvObqdESX/1YcU0fNwEh3BfvDS2UzNQGGrWFGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176534; c=relaxed/simple;
	bh=LnZMhfY+0uIpcex2i2lY9N88V1Q5BkHGMTKzHJ3eiYI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Vz5NNL6IVdIUKHRZ2k72yX/2hRvgnS17sGQF5mrTwyn8HT94WIUw8guoEp899g+7/CWLN0+1YOBuZLOt+hjCAuszX9xE3i+XHlIS04w1+1llrgO5U+Yb30qsPDmYqg4j7nnbjKMwwaq/zefaT5nLOoVWi1uBrI8EwylSwcGjJHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-43321627eabso81014355ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 05:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762176531; x=1762781331;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r3hGHpeiS5WWBP6+gDcZYim2gEfRLOiKKxV7okEf0Ak=;
        b=jzqix8psqNQE1TihyUfNjpa224kAKSR3Rm8+BlnKKYebgq5ufENU6uE1Ue6H7kc6X8
         39lYHhnBdRpTJLueoG79tunkbiM4xp7CMLpEuJcp6V5+SQ+z/oGPAEo13Rec4pTI1/tx
         qhmGjXUfucObQaAfwSXU79N03DU0a8nXywGhIs7SSVAvHcSywSKw+xZpgCUr9Yui0twW
         LYT5s9OZTyIPwlJRLLxN2qXgC4pjlo8nFA2VMYEbPycrbENNU0FWPYU69c65sRuY/f9b
         VXfkP5FRp1Q+2PPjL5BWVLY7lkX1iKTVY+1N+fgU2A+UBh+hFesqkYRn6IH79ArcNUlV
         X4Fg==
X-Gm-Message-State: AOJu0Yzb01DqBj0bRYhBnCqKWzDpqD2AN33nn/2bZc8Yvfuy8m5kIPQJ
	1GGu1sW4XmVZho+Yre/SYtPvMLkF3sjVAKhI5vcdIW2CkIFPxSYiKk/M+AQkSKRvNpostQg9dOx
	NE7Wrttxm+C9H3t0jFfZlCvGul4THgLfvXA1IlY0kDelsOWWTuiBoCMTtUzE=
X-Google-Smtp-Source: AGHT+IH4+Wc8rkvLzqGV8wd2P9SZTY//kFu6AY9prsmaphGwakgJTkXF+Jm5odJI63bphqjNjtfqCFqDfRREQUrLv8yHQGDClvAd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:97:b0:430:cf18:e1e5 with SMTP id
 e9e14a558f8ab-4330d206074mr181000715ab.31.1762176531635; Mon, 03 Nov 2025
 05:28:51 -0800 (PST)
Date: Mon, 03 Nov 2025 05:28:51 -0800
In-Reply-To: <69015bf1.050a0220.3344a1.03f8.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6908ae13.050a0220.29fc44.004a.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+2e6c1eda2eff0745b028@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: jkoolstra@xs4all.nl

#syz dup: WARNING in ntfs_put_super

