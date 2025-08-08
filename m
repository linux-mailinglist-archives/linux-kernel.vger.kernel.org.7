Return-Path: <linux-kernel+bounces-760246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 131E5B1E874
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31C5A0642D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138FE27932D;
	Fri,  8 Aug 2025 12:35:34 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588402609D9
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754656533; cv=none; b=lpBdY/jabMyuX890y/MrCJaVNnH9Npd/ywVrpBmX5MFWBI8tyua4Uorm08qTjAtBLRB82/ZGHIjz5eP8gI9MACqaaRZaLNcVdq5vfhWBC5pDSzkWDWMrlcK5r60yKzHC2oWwHMGSYwdjuDhCRJ0rlOMIED9WSp8YHGeZHGy+Xz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754656533; c=relaxed/simple;
	bh=mLWT6GfB0u+D2py9bwCzhfGMwpw5oNOEPQ2NU0v4Y0E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SFrYsyaEFAjDwm17mlPg4Vdr3HrBIuSnRJ85T9ZVI6KFAYOVcIzXuZp7VZcckFILVEYE7/smWPuvFukcVBDXulor9+ipuLyo/KJUYmqPqAXGVBIluidqqaRgBc8JtfdLxiaBZvyyIhu0TbgEkwl6iL+D+LzP31PNtfz6TiwdVIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-881b5e2172bso168800439f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 05:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754656531; x=1755261331;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IkINT0Y9c0Hnv3yIkXo95dp5zJJHuDi6r/Kkwyne1Uc=;
        b=EZV9HVwdJIxHKkIzNFjAN56iwU+cICdWgDRWoujxlF1nJsVdt56Fs/s2wg0mu25GQ8
         TT+r0PZnlYw8XFIkTwpQY7Z4TkZRfnyS7CFRRa9/Li+c5WjquqP9PJDbQk6UZsw8N87q
         hPFQwC+RF0yymcalyNHRH6mrJUNXEidF6ZDjUKTFg6c8Jbzo+3GrNGGL4arq1cRuyLMG
         XOu+g8G6yCk7qALmVsdPQzVqW/1mHbCJ2mZQZ9ANkD73NTE9TwZMYQlVg55QMmtBqMSP
         ob3V7cVc5W1OA1edCbXvyIqa+xWeasr0pUUym5KT4xsOqoNFLTBT+aZZLJtAsIQUK3rw
         RgbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdyFU2wFD/G2y5iTe6NWPqHUK6k36CX7M+jFhdWd2bN5V6bm5in2u53m7hjg0suQpZJm59bILBWL2L1VU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVckYRLencMBX1QXoOUBnp1J3UtbMaIV9fzCZ5Dr0JQcyPl4rP
	ji89/JtRg/eQrlQbKeMELdieXOakuNxYeFqChegSBhRaq0NeRSGOd4ZPrHDQtD2yae12JgY7Lz2
	zLx5w2/4jkaoe/QpZ6vcYyzdTcy08QcK7Z1TMCj/ANDft6+/3NM5UYMir1iY=
X-Google-Smtp-Source: AGHT+IGUZ8Ht884aEeUTYVeEe2MqsVO/6u1dp8PISpfM1R+i6QN16MXQTuLiaSEKQ77YDUKMvDvv3vrYkrpfc+9ygLbwyBGFmQVC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1686:b0:87c:2f66:70f9 with SMTP id
 ca18e2360f4ac-883f10e2396mr586699739f.0.1754656531574; Fri, 08 Aug 2025
 05:35:31 -0700 (PDT)
Date: Fri, 08 Aug 2025 05:35:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6895ef13.050a0220.7f033.0062.GAE@google.com>
Subject: [syzbot] Monthly nfc report (Aug 2025)
From: syzbot <syzbot+listbabfe0cb0f5b4dc95616@syzkaller.appspotmail.com>
To: krzk@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfc maintainers/developers,

This is a 31-day syzbot report for the nfc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfc

During the period, 1 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 27 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 489     Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<2> 333     Yes   INFO: task hung in rfkill_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d
<3> 83      Yes   KMSAN: uninit-value in nci_ntf_packet (3)
                  https://syzkaller.appspot.com/bug?extid=3f8fa0edaa75710cd66e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

