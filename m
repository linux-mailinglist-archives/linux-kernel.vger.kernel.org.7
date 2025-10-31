Return-Path: <linux-kernel+bounces-879731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C83C23DC8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 392414F2A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC5E2D320E;
	Fri, 31 Oct 2025 08:35:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA31C8605
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899704; cv=none; b=Gth/rIDw7b/Q4uydpqS0mCZsEZzG4OyEw9gmsrg7IJyk3Rpidisy09q5cR6GKjgX/yDp4jFTVkYbmpPJLl1BtJ/3NzURm9VWFeHAxOWOdw5JmAD7ah2Tx0YMKtrEqu4Vt2NcfossEhdRjIHCJzAQH8U6DSbn5Z+RWrCz7mXfaEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899704; c=relaxed/simple;
	bh=og29u19LvCCtoIvsFzn/6fyhN/rublKiC4s+JjQHFkY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=e8S1bzlUQbaNqmB5snLGbHiumr2k4DTNzXlj0/OHrGhSbwkYP67JF57amEqLCpCWc305w4yDu5AnYKvpkaBwA4JPND4oGM+w04lzR9dVWCT6KDpkzbGYMSmrs+UBUTNi9IvjHOsgHLeDoeJRv5pRGG79ZEbA1/l8M9qESHwKeNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-433103f5a25so11105235ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761899702; x=1762504502;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OH1UGt0ARIywstYtQuG/fxtI/hQLFRasxg3N7CcTx4g=;
        b=nXVxetyLVqRLbE0pAl50s0JKsYrfo09rG4efdg7VqLgpXUZ9UjK1yeYuDb+FrEvTGp
         7ynhs9Zpsq3YOXBV2Gmc1qsXLuOAYI1njO2jily5WZf4VUnHHRv6gJGwGLQ489jImxQj
         qMmnW5QzsxBvJWE9im5YRw0yUMOPPJCyqZbTkBi1oWzvMGMHQQVWCVnpiGvsWw5rM0/p
         lysn5SivwzFAJlPcKd2YcSQ2dJ3KmbHwd2fvBRoadgE6QKqQLAqnzX/++3Rm1XJimGbW
         0fnMp+C8Yy2TkR+6wHalOoepgCddoGJ3ku/0LA/ZnIt0CTdNLQnZCNMTU18P4V4e7m1u
         Z8gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGrMXNowtUowlrh4sov4i4UGIQGUs9Au6m8YPSKafHpOMhpX+7l0RKujlakUc6xSuYD8AqygQRpfVbSZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBiP9ZRoxNCw/h8Qt/n9qMX40NeoowLRTqx7UwYKaRzoRP3M8C
	IXIMJ4jt1XL+y8hattESUepcPmhVVrModlj+p9JTYgHKB95YRMSldG+q3aOzH2zbFOwSJMHmHZE
	JWdpTGh6CKBZEdypoHK35F0YGrl9cGBkZv1RNopEWWL1nYwq+b9ceC704XlA=
X-Google-Smtp-Source: AGHT+IGLRzEMbhkDJODYTGOH60tTOuObd9AhRsHiwb6jetGayA07Tg9XrHcmZLFuV+7cGvhkGvLvtGXMRhDvZsqpfolQeje5xnbJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2783:b0:430:a538:25e7 with SMTP id
 e9e14a558f8ab-4330d1fd720mr44911255ab.29.1761899701962; Fri, 31 Oct 2025
 01:35:01 -0700 (PDT)
Date: Fri, 31 Oct 2025 01:35:01 -0700
In-Reply-To: <20251031064453.485823-1-hsukrut3@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690474b5.050a0220.e9cb8.0002.GAE@google.com>
Subject: Re: [syzbot] [net?] general protection fault in sigd_send
From: syzbot <syzbot+1f22cb1769f249df9fa0@syzkaller.appspotmail.com>
To: hsukrut3@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1f22cb1769f249df9fa0@syzkaller.appspotmail.com
Tested-by: syzbot+1f22cb1769f249df9fa0@syzkaller.appspotmail.com

Tested on:

commit:         51e5ad54 net: sctp: fix KMSAN uninit-value in sctp_inq..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=14bc7e7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b63a24f3c26fca
dashboard link: https://syzkaller.appspot.com/bug?extid=1f22cb1769f249df9fa0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13cd7c92580000

Note: testing is done by a robot and is best-effort only.

