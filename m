Return-Path: <linux-kernel+bounces-828640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF47B95122
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5FF72E0217
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0D031DD91;
	Tue, 23 Sep 2025 08:51:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698A135962
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617467; cv=none; b=gMUzLCHpXTWcN8NjEYShdM3BbdERv7Vn0xy+aSR+DwJuAoOBSXOlFVZfuZFvxahPH4otEDNXrA/JTirP/cr3Y4qM80fxOsLTvWVQUpDkSsvJGUXlRB45bVbupeFLo+lgSbcFy+PPCHvjJnz+63syIkJeAqi7IuqJ04IGTPEfnT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617467; c=relaxed/simple;
	bh=No64dQkPaQdqr7qQZmAP4u3KflLVMu1kTQqIzPuVsy4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lbWdQszcwYkQgBA/Vze2ggCiWY7RB3dnAqGmnWfxOXQXBHUBbrXJk3sZn5S61pTFLAW849TE/DdQo6uspuXeLl/eDkdlP3nqSd288ZaFmd/YE/Bf71bzcujFkAvd+7ELviLjH3Cfb2773cUiV9Zg3fQ3xuZ7/WgaVpsbNqatjxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4241c41110eso135026955ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758617464; x=1759222264;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opT3H3hhg6Ve+2KNkaEuZvkJzf/jXi0+XOraRTD90V0=;
        b=cWezoxK/nuwGpXQiXoBbOwOS0MjP/xGeOLE6y4vzM3clsjKbYKs4IGHrES8aYI+gw+
         Qwcp05fH+VbDxwCEhqAhpPS/eEhEmM6swy3ZgpUZQ+Eroer33Pafoli6BezED/gOt++J
         usEnwWsO8h3RC8jjLniYoAUZwgJsHw+mkMyZfQNo0FReOpOjB3zqnTFc0hfHHWDDSW5w
         dL5Em0f4cmd9AhfHXMEilYXxO/MzH71aJfILLMCgxfDA+CEsnW5FMJhJRWeONG898KY/
         wd6g9Do9fSW6oZEte80MCQa0BIwl/NlZ3lLSoi+GZQ0auRvR9HU/+chNdSd6GZ5SI8fj
         qlbw==
X-Forwarded-Encrypted: i=1; AJvYcCV+OMNoIsVpA3bpwFvVzoZe0UVMcDR4kbACPC2k3r+Ebbx+Fj1eHby4T7kl2YN0HO8qsEGH5ILkOOBilKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypxj3FQ1Xhnasy0nJOhRJewsfmqED4wvm9khugJSlQk84BCnP1
	FecwCL5bJdFrix1rfPNMq/LkSnTCN/c8ytPPn53p0Z/YZ3VisH9KDNdFwLi/BqRHvxa1Nk+BCsQ
	8nPDbJsXwx9lAZAB2LEGKPd7l4p/gbUL13DmPRlyWU2IY0R0TcmdvTpRP7Dc=
X-Google-Smtp-Source: AGHT+IGA8ATJtQY4uDJruaU2yA7xyenta93fulgvcAsc+Fmn8n5PL+fHXgn8pUBj4uT7Q68bU6t8hOnkcfrh8y0VGvxlyM164/aL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a26:b0:424:7633:9e72 with SMTP id
 e9e14a558f8ab-42581eb0215mr27094765ab.30.1758617464461; Tue, 23 Sep 2025
 01:51:04 -0700 (PDT)
Date: Tue, 23 Sep 2025 01:51:04 -0700
In-Reply-To: <20250923072139.7466-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d25f78.a70a0220.1b52b.02a3.GAE@google.com>
Subject: Re: [syzbot] [block?] general protection fault in blk_mq_free_tags_callback
From: syzbot <syzbot+5c5d41e80248d610221f@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5c5d41e80248d610221f@syzkaller.appspotmail.com
Tested-by: syzbot+5c5d41e80248d610221f@syzkaller.appspotmail.com

Tested on:

commit:         bf2602a3 Add linux-next specific files for 20250922
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14b8627c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6707f92bf75f45f3
dashboard link: https://syzkaller.appspot.com/bug?extid=5c5d41e80248d610221f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12534142580000

Note: testing is done by a robot and is best-effort only.

