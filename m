Return-Path: <linux-kernel+bounces-853828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD3ABDCB1F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99BE11891EED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBDD30FC01;
	Wed, 15 Oct 2025 06:21:17 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398B630F954
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509274; cv=none; b=Kx+SJc7CRyB/2Av9rufpqBK0nIyDqpZRjyegEQnj84w6dvNW1fNpzLKayHlcYGnvBYcxHC6+Qdc7SuvjIX01HNqCvNH/rCjjfC0LWvNeNdtrYAQGxJoUNK4HVXq+U9fGdWFbBzRpEw7zPUnNV+xYDiBGBLU3sURK1N/3y+KmzNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509274; c=relaxed/simple;
	bh=WiPc2gPeCXPdFmn+cFIiMCzPa5COfTwkUbjfQDDgDoU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bCPWYG231aRDxMsFYz0BYu2tWnwmeQ5LbEsT+hDPG3EFwQUC8r7uKtTleC8nB47CzFCtwzf9AQ4oUEiVKTi1nsv8RVhI4Z0QvqPUDzCEA1zKOOSOF9Dz0hXyIL4L8WUkKDKeRUR5oTG99awHSDDwFlq5mXLEcyrLpcicHgn2jCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430afceae09so416745ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760509266; x=1761114066;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hIuA3jNEzmgIK/9ByJPWv7YVQALs/uR/+CmaD+VkEl8=;
        b=KfJL8Le6YN6rcF6iotomsGhRgbc2gq2lMJ7Y7rrlMBEWVo9zvmg0RH/QcxdB+eYoIz
         E+K0Q24EVs3VU/d+nrkO8tM6PxrqB32GYJxBE8UDQ3/ZwJxnAATTN4qK0V4IhdzmVYwn
         1V2hbaWD2FrpFS6CALpD0pqazk7RbtdZRR5l6m8cBiyqwtiaoUE5+GY/x+/68mN1XqRG
         RGPdR6CfwysXCf2Voi5w8VA7r9gaNWrGktafQvwsMFI924th7k4AogLQjJx/1lEhda2R
         dAia+WLmaoon404fYG/EAHNoxu+Uc7pIRB/0IFc3pNBzt71fATNRXBGmBEH+X5MBbh85
         vWGw==
X-Forwarded-Encrypted: i=1; AJvYcCWCJNG44h5zGt1lzInUWAt5gcz0YTYeGSA9ckMdYZm62RnlI1xGpf2Hfg5MWsexBqni2OqpveWN3qzS8Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEzb6ujeYj2SB7pSOrgKJtD33L9fG+h7b43r5sLE6ZGqUBs4VH
	d271m7sl0X6l7fRwMZN7/mb1ISLhTeN13N/Kg74n3F0AJG8FxJfu/I2eqcchnKCCKUJ+LcN6GAz
	Yy2eItVQokrFWelJj1TfSCvfrftBbV6gwNiMfXQcT8qNFK0r7hu2XSakjhe8=
X-Google-Smtp-Source: AGHT+IGjppDH94P7Zy2xDjnXF6uKeEAXGb3T0QamCL/YxqN09H4uMRpH7qJX1tTj9e0sBMnwSyEoY8wU8KW9b8w+xSEiOLdcHSh8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c242:0:b0:430:aca2:53d5 with SMTP id
 e9e14a558f8ab-430aca2548cmr15345785ab.1.1760509266635; Tue, 14 Oct 2025
 23:21:06 -0700 (PDT)
Date: Tue, 14 Oct 2025 23:21:06 -0700
In-Reply-To: <d8a13302-3be4-4ad7-a1f0-263bb9dc1ba4@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ef3d52.050a0220.91a22.0230.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] UBSAN: array-index-out-of-bounds in ocfs2_block_group_fill
From: syzbot <syzbot+77026564530dbc29b854@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+77026564530dbc29b854@syzkaller.appspotmail.com
Tested-by: syzbot+77026564530dbc29b854@syzkaller.appspotmail.com

Tested on:

commit:         13863a59 Add linux-next specific files for 20251014
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=151d85e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76790fe131481879
dashboard link: https://syzkaller.appspot.com/bug?extid=77026564530dbc29b854
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1304d542580000

Note: testing is done by a robot and is best-effort only.

