Return-Path: <linux-kernel+bounces-680936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CA0AD4BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 08:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200A217A3B5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 06:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0B3227E84;
	Wed, 11 Jun 2025 06:47:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731C6C133
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 06:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749624423; cv=none; b=DJGmMSYPKcLPeZCbijn7FbhU4lh+nfccY/0rtWpQQ4pyOK3gFh8SGjbTyZsDxycxiuH2hB509dnPS8FvHs7RU2q+XU2eycom+IMyhwDHXpF5W1InU0gofeF7hXM09me1lf7O6a0vHNb2Mv26FBMGqh9WuRx9Z95KdMd90s+oSVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749624423; c=relaxed/simple;
	bh=PwJ8H9eZhuNLJmD0SmVtkG+wVoyXdS2gv+ziwXoJL+4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mJQ1tm2UpMnvw08UC6XGmhK0Y8tk5jjmbXVWXZt07NQwaSX41HDXhEguC3Hx4k2PdAY/DZ579MG0+F7DtHaEZJoPaJZFKc3asgpW+dWxLEYiPqkKLqKEKOTtAUb2eJgLtD4JXQHqZ42aWGYfcsuAv0AD2DL4pUPpeDgmjsmVqEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddc65f95b8so137670175ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 23:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749624421; x=1750229221;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MewqcPGn/QokpfcEkkNeQEgd0jbUGHA58K19z6AhSKM=;
        b=vBzOV8OXrGcj3b5UxDy04oJQnCV+VEK1H+/0sAp+ckR3P2Llxh/PLpHJmY34gsG53z
         DaTQ4TlW3wnAno0OoltnfJWMxs7IZiPno+3T5CMa/TarisYuD9X8dJ69dU6Su5eusKMJ
         FRuYaubc6sTHeVytAl5wHmQ0rczpQgzlw39GaloQ4opH5WDLIfnffzyBcPT5NPk36H1V
         b39dGkZ9SGJcr+omrB91QagREYTyb15JDzgs6Qyoqt+q5YWN8+wQH8wmuaS/eNmk9Jde
         SUpgn2YKkUDL5uDwsnVOarXY5dgve6zNYzRpQFwtY1VpGHQS+m9g9GPhmZFKOaWyUAom
         UrKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1lLVRaHMzM/9gYlnvz25Z4OuAcM12qQBjID+easNZCHWzdZXiFF2Jx9d1OqY4VoALKa1WVB4PdVW6jBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwspvWmBFdAeodqTYJl/iD9e76FCOIPnHEuFbW+pRbOUEBjVYJc
	Y8RArAKQs5301yWrszET9p4yu2ptBTdY7D9S/3lPG1kilMsnK4wTCKRGuGi1skMxnH76ceYgkbH
	JGEHvlwUGIPW8trkP87NLVy2JF4ashVo9Wfc0QCcKYogfHTSueimICxBcoj0=
X-Google-Smtp-Source: AGHT+IEU0X6hgxJuMlbG52LfRb7xkLAfxhgoWO2FaYvbH2006dQ0XfZLHXNKlTM6m7pa1LMgOPpaWC0xHZvEdX/HposVl04bZF/P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1807:b0:3dd:cdea:8f85 with SMTP id
 e9e14a558f8ab-3ddf4300c5cmr22610735ab.20.1749624421733; Tue, 10 Jun 2025
 23:47:01 -0700 (PDT)
Date: Tue, 10 Jun 2025 23:47:01 -0700
In-Reply-To: <68488453.a70a0220.27c366.0068.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68492665.050a0220.33aa0e.0366.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] divide error in bch2_sb_members_v2_to_text
From: syzbot <syzbot+7c8101d4d0ba2eb511d7@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit c5ae261c8095a37174e17eb13c5485cbd1b3bb20
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sun Jun 8 15:31:23 2025 +0000

    bcachefs: Don't trust sb->nr_devices in members_to_text()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10c319d4580000
start commit:   b27cc623e01b Add linux-next specific files for 20250610
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12c319d4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14c319d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=846e731334efc0f8
dashboard link: https://syzkaller.appspot.com/bug?extid=7c8101d4d0ba2eb511d7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175a260c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1129e9d4580000

Reported-by: syzbot+7c8101d4d0ba2eb511d7@syzkaller.appspotmail.com
Fixes: c5ae261c8095 ("bcachefs: Don't trust sb->nr_devices in members_to_text()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

