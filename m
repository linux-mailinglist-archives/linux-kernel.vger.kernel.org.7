Return-Path: <linux-kernel+bounces-752855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3667DB17BB5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 06:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C6F176BED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 04:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FCE199920;
	Fri,  1 Aug 2025 04:11:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646A616A395
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 04:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754021465; cv=none; b=AxbAKP5a+MIUbZR+7nGvhTjEpMMflJidGLBAJx8lfAoe6dosPgbG/OLgGUX96pgQwj9SgJrlcuD4YsetSqLOd/WnEhwDNa+GEOii2Qd5lXcykMymwNPfPTKT9FXjMgk98fzPNeVyIldO0fXV7mgL+l1sEuQ+tZRMszNzg/dfv/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754021465; c=relaxed/simple;
	bh=7hZKqPjxCfoTjAB9YO/o1DnS/49zx1PrSM6DMapDltM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eVDA5gkGjUKvthSKyABudUAQJnDc5H4b+ShUGjafKpC/fLNQZWJhgAABlhwILJdzr/1f8HTRdYpcAltMX8YBhHTF0YVser/9HGwmmfRbVSVqFZL+JMKilIkFSqT1UeejwO6OEhQUZeev3cX+dbcSWbnTWbYQsO1Z0c27VOnkAtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e3d462b81cso11401615ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 21:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754021463; x=1754626263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYq8imgvJej5FO1a7OjGO77bzk3zixaR3hHdqDtdD+o=;
        b=M+NWCURKLZZFooZ7qI3V2pZ72Nm2/z3UzAOG8huvoIOJOLvAkkRcdUq4EH0xwqjYI6
         5CHgV7ZD90fLYTOtsLe0zrrT0GwIb9XchBgCB6Y8s/EQC0FDOVl/2WOI7iyKUm6YE+XM
         Yo0bLk16svnDezAYQ4AK9rn2rKu4EEccxgKPHAjBtKkRsG52FI0Orw1/beghIfCNyrSQ
         LnkHCBHA4U7ZltgRuGdG5tBYjck5EZB1ri3vtsYKL0kKXxo85EoVEN1AqT2WJii1HZdt
         y2pBEtMZRqVbKHSqxUgp9OWj3cuP0FpqE637mdaeBHIXb9R+eF76I6CH/oCrX1JwYtr4
         WlHQ==
X-Gm-Message-State: AOJu0YyinApjA+78ESbWenizGiRROnWgxiN5oLQx7+AOMB+udKFDs43j
	v/FKzBCyzSqfjCK9DKpI9fkJwkmfeZjOd05QpscHlLh1jKLRCZ3E8ve97ZSgVZ/7VThG0VHw8kQ
	IC4brPOycrHLAwHzMxLk0fgfA/wSbejFL83g8BwHw27ThvsVBPCXD9Pw5fFw=
X-Google-Smtp-Source: AGHT+IEHAFLpLQqr7jXOW07hPmtCajcFEdZBxzQBWo0AAdGgf7cEF0UQAMEEQRg0QGS1bD/TIQ2jHzw0z9DGZTr+v6qF4Yu/54jZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd85:0:b0:3e3:ceab:9001 with SMTP id
 e9e14a558f8ab-3e3f62a7da3mr176273795ab.21.1754021463451; Thu, 31 Jul 2025
 21:11:03 -0700 (PDT)
Date: Thu, 31 Jul 2025 21:11:03 -0700
In-Reply-To: <20250801034837.2742925-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688c3e57.a00a0220.26d0e1.005c.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] KASAN: null-ptr-deref Write in gfs2_trans_add_revoke
From: syzbot <syzbot+f2b9fe431c853e793948@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f2b9fe431c853e793948@syzkaller.appspotmail.com
Tested-by: syzbot+f2b9fe431c853e793948@syzkaller.appspotmail.com

Tested on:

commit:         f2d282e1 Merge tag 'bitmap-for-6.17' of https://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=171d82a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f288fd07ab21a0fb
dashboard link: https://syzkaller.appspot.com/bug?extid=f2b9fe431c853e793948
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14b162a2580000

Note: testing is done by a robot and is best-effort only.

