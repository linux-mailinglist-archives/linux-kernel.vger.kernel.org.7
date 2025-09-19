Return-Path: <linux-kernel+bounces-825106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C157B8AF8C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0E81BC653E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC8726560D;
	Fri, 19 Sep 2025 18:45:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E442826159E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307504; cv=none; b=sp/JU+EMzmtG3NfhGnJy8/cWWe2nqPXaR7hYwN7NmdToaOVPNzSkJRMMCKTJlAQ5jU54O6xv7WvB1qjwX2L7dGMeu+NfzY//Qw02TPv7QgelhjhzeayVo4RGSfDcNi/ELYCKrG7jWXCk/7KrxfNlt7cYCGRmmYYpaxBx5CLSr2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307504; c=relaxed/simple;
	bh=f3+bU6QqG+2cSPiNoM6A037Jxhm4TpFE4U9gqLBz5HE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DuaMu2XQxKlJBV1WDdgN7B/+K05gox7cU6wpbpsxvxaJ7wyG9uXS87owDkTLeWKPODwmslA2wZuptNqBOTeDqTGPK/DwJnjdIGEFwXPkxLxTxz9DS4a5eGV+TANyBoDDSmX2jlpMOdU4KrL0On5ra7mGzkoeaDYm4vAeNudKk14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4247f4fda63so23280745ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758307502; x=1758912302;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVBmM1A43qXisIDPPpK3XXrY2GqSn0MT7+y50uuLj4M=;
        b=X1G1QFnj51dnaIpFRlsnW1pNSQYWEacy5KAmA7iGjU0uy/lqLsABL8aHHnvCfmeOG1
         HQq7IfQBF8fHb9cIKF5ijqQvz4y1fYvoOMQWG3XrJ7gWMel6prj3DAzot5eE3YNd9d3O
         hZDFS9V3AXp2Fv6CbT00aI8xBvOC3qUT0AchrJ6eKDEy0ztTVeuMmFsdxEg/tDPr3sko
         vmBaKfoUGpaafaaCUS6zmr349Xw86MJS23G8r7ITnMUk+E2QvddikdJCcaqcfOuorNdZ
         LbhgPWRVgGOuzqEZyiSzWF80+2BGhgYZM6DIwPDguvOyzIZY1OyDn0xpreOsPTQET0wG
         WW8w==
X-Gm-Message-State: AOJu0YwIG2isQWdv/88CV5/XTfEObQGWySyvGqkGpmn+EPgISK4nMXKC
	Mee/SvjBaz7ln3fA3eYA0PI4vWJGZzYPTR38oVfSXlYrgAPO4eSz601kCFuuLh9VIXkAFuKzwrn
	n0pGEA26k2Oc1WtrRgjSCzlWDWWyHWICUTRDakGp9tlD7fu7Qa+LN8jam91M=
X-Google-Smtp-Source: AGHT+IEHTZofYCgPxaPuPuEiVpLMALmzNhounMyn6Tyvm6nEIsnYi3uyNclu+4Zboh3dgbWGR4hxQQf0EAmHBIOxrRIPtCwPmXbc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184a:b0:424:7f50:4e9c with SMTP id
 e9e14a558f8ab-4248194188cmr72328155ab.11.1758307502131; Fri, 19 Sep 2025
 11:45:02 -0700 (PDT)
Date: Fri, 19 Sep 2025 11:45:02 -0700
In-Reply-To: <CAPrAcgNhZmR4Z323aHXC-Vfwk8LBHFe9=mtR-CKQ3iADO5uoJg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cda4ae.a00a0220.37dadf.001e.GAE@google.com>
Subject: Re: [syzbot] [net?] [usb?] WARNING in rtl8150_start_xmit/usb_submit_urb
From: syzbot <syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viswanathiyyappan@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Tested-by: syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com

Tested on:

commit:         846bd222 Add linux-next specific files for 20250919
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16361858580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=135377594f35b576
dashboard link: https://syzkaller.appspot.com/bug?extid=78cae3f37c62ad092caa
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=133320e2580000

Note: testing is done by a robot and is best-effort only.

