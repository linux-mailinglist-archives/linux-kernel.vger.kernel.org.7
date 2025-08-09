Return-Path: <linux-kernel+bounces-761063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA0DB1F3DD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 11:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4499A18C80D6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B8325394B;
	Sat,  9 Aug 2025 09:52:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A45B1F949
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754733125; cv=none; b=h6trJFLqvBZLUVrJboFtZlhxGLXGSL7rW35KQLYEKQvg4NHZiZQye4DZqPRFq7aOWN6C+TsebvdK7J4YKEhMlWi5FzRGEFRkH74hWLFyDqnfK5UnyfWLo0I6vhJXq3pPmQcLP50sJ23Ty6u+rMIBykmbOJd1yr7QDQtE7656PTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754733125; c=relaxed/simple;
	bh=+xCvOpAlO6IPKKqo+NaWneN8myhTy1QszLnc3l4oDpY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gBYn3Qyb2cwiboU8WthALzJZEF/4st3rHCYzyaRZYf4nQqNRkuUqKqo3+tftY4HtLh0fd92QcprMDPJM2lFCSQgLI0VDZKAwhpGFZcqdI8sOY4KqOww2U4Nov98qVAbaBsjfevSWuvU7ay+v+BdW5oxPRxT6AE5U0KWRgdwCkPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-881878af906so540428539f.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 02:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754733123; x=1755337923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0XvR5F55BYEBTELRK95B2GVU6la2n766p0Dulo3fTA=;
        b=YST7aDHGFUNcqXdj7IWoCUPqitfXuitAzLY6qxQ95dniYF+HzUpsNEEDLYIwbe19qa
         rDCcgb5Kx1xM5U3aXRdzzYE/rvFyI7bd1QUG+s4k/0XjheKRvNfCDCbGEV6yQZ6bhPIZ
         zEImrAQ0bBIu1Sssi75mREfrObTjoM39GRIOGTWMk+cn0VXR5sqcszuLlty/b6GK+W7s
         9H5mMBBsdEFzkblAi4mifsf8dTinbq0TtFgigKQ0Pzl1hjqKZIi8diM3TWRo1F4T573v
         kFy77JuDkorMJZ9Q162XNmNbYFeVM/iJqIk3z3gAozaEApOyEBN8QBgYHjqt3UaV9kdL
         jc9g==
X-Forwarded-Encrypted: i=1; AJvYcCW3XylZbCCPKkrq1EZuvx8N7b4vl8K0rKL7P9TIc25WdazB5yiNAhxx33S2fUuTw3vcXXRgTb+raN26kN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz21OVAzUAf8EYsu4ETqSgU+tx4C2K7AOmsh3hsuTFHWJlE35j8
	fKeoTnPUyrh9SoPrNfCFrWGIA/tdkadMUXqtn1wOTbI60yebEdxGRFmrYQyZbpczHF8d9GUAMwq
	GHTvYlKIbvXPdMtLxHsLTpWjiJJ08GCA9BPqo1155eKPOVNVoIUUNWlFWCYg=
X-Google-Smtp-Source: AGHT+IHcU9df4n72b++dkNsTmAe5wn9/QOWGU4UXtp1yGO65Ifzdm/Pp1ITBcha9mTZfbO0ye2OxhXdufWJSlpEnd3TSCXDt0Voj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dcd:b0:881:7e0c:7a79 with SMTP id
 ca18e2360f4ac-883f11b58b4mr1229403439f.2.1754733123177; Sat, 09 Aug 2025
 02:52:03 -0700 (PDT)
Date: Sat, 09 Aug 2025 02:52:03 -0700
In-Reply-To: <tencent_941BCB257DBA68BBC933969E511B584B9408@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68971a43.050a0220.7f033.00a7.GAE@google.com>
Subject: Re: [syzbot] [crypto?] KMSAN: kernel-infoleak in rng_recvmsg
From: syzbot <syzbot+e8bcd7ee3db6cb5cb875@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e8bcd7ee3db6cb5cb875@syzkaller.appspotmail.com
Tested-by: syzbot+e8bcd7ee3db6cb5cb875@syzkaller.appspotmail.com

Tested on:

commit:         c30a1353 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14edb2f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ee158fa735566e2
dashboard link: https://syzkaller.appspot.com/bug?extid=e8bcd7ee3db6cb5cb875
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a421a2580000

Note: testing is done by a robot and is best-effort only.

