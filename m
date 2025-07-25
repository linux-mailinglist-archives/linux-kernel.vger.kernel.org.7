Return-Path: <linux-kernel+bounces-745788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DDDB11ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C83CAC7BED
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BD72ECE9C;
	Fri, 25 Jul 2025 12:39:34 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8B82EBBB2
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447173; cv=none; b=FcyJVEh/a4VzMvI9e2s4phxk442/4V5iYjb81LaHheb+hr0fVPdW1XY/5xnXwXyvM1CZ2/l0+GH6KfrYC6yu+H6k+8C+K+zkwD/03T3BDDMTb4sp3gdnJpTnmj24dcBNKaaeUzFq/q5vMviQsVzGZR0oaAgMRQ5F2boOTdfHA84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447173; c=relaxed/simple;
	bh=pDbXLO9s1B26nuvXrdNGv7NEmVAQzgsCzx8/zI2EuY4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qIFyp6MZaMFQSQ/xVgc1ltNuejN1gqWgiz9wXURFiQJsuzQvsi37TfwrYeH4bqL22AcqWGs5S2A7EP7Fj0K+UjIOFar3/njI6JMscsENTJu4rWF94s31AN3Mu7qVo6Ssq8MEz7G5ch73Nz+22KEBPw89WNWZ9i5EkyUh10mcQH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-87b89891d5dso356943439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753447171; x=1754051971;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sa/HoxLzLJuDpA44YCodPaUbQNsjacjc1N01Ba02j7s=;
        b=cUD5GpVr49oYzYEJycU/ck1H0ybAWUevCJMl6WwcHxqmrM0St9w9NBnWhJemnFqewg
         hC54BJmwnf/Aligd7YCtNV8G9sRj75FHGxw87jkjxxFBwMIHPZBLxezJAWjIU+9lJGhn
         novhAYSTyrFH0I9qHXVNElU1B5AHbUxicd/NPLHHEd4nOXAqL0JJgHceMQCskaxLRwFW
         to4CjJM3OmGYE6CZzJTXPOahnSbMOuMYN21VrOM/uxDjtZTGDFVcidNeXwI7SSrMD4sy
         4eBgpmHc4iXGiXIiHIP6sBfBhL8jEfRBMxG0rGLxn1UTdwgu9b7asPeec1FQa8uStGOi
         7DaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2NS2+dIDv5wKKmxEYgoPIfPx3JGRJqZgLsPunAPnNSRoRydGkqWmv1CrDgC/vTDvpNWReV139DLvK/NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx6GkSqfdJ0qnhzvU+z69PfZkJVoB78TYNm2M+GUoQjfNQOFe8
	ZKaTzdTqhHp2kmI4UPHPPaarYH5sIUBOsDK7Fn4hYPLD4KGI8E+7VxOn/dt4kYfhJr38aBGBQyE
	r8mxuCmELu3kPhjma3OYIY4Lxkh4iUBxcUBP1J7h6QGJFvqK+R5GRcH0a8jA=
X-Google-Smtp-Source: AGHT+IHYEK4t6W6Z1UUdvddJPgXDuXoBZxCVRJOv06G6878vsmMs7JTE/MR5b5v7NlTxPz1DRqI2jJ4scAsJ96IQ/S5jqSH5+rqh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c06:b0:869:d4de:f7 with SMTP id
 ca18e2360f4ac-880388fedfbmr242259339f.12.1753447171304; Fri, 25 Jul 2025
 05:39:31 -0700 (PDT)
Date: Fri, 25 Jul 2025 05:39:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68837b03.a00a0220.2f88df.0050.GAE@google.com>
Subject: [syzbot] Monthly ntfs3 report (Jul 2025)
From: syzbot <syzbot+listcde0fbb18221df5bd95c@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ntfs3 maintainers/developers,

This is a 31-day syzbot report for the ntfs3 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs3

During the period, 1 new issues were detected and 0 were fixed.
In total, 36 issues are still open and 65 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  22703   Yes   kernel BUG in dnotify_free_mark
                   https://syzkaller.appspot.com/bug?extid=06cc05ddc896f12b7ec5
<2>  15421   Yes   KMSAN: uninit-value in longest_match_std (2)
                   https://syzkaller.appspot.com/bug?extid=08d8956768c96a2c52cf
<3>  6258    Yes   possible deadlock in run_unpack_ex
                   https://syzkaller.appspot.com/bug?extid=731b27ee9413ba859499
<4>  5558    Yes   possible deadlock in ntfs_read_folio
                   https://syzkaller.appspot.com/bug?extid=8ef76b0b1f86c382ad37
<5>  4823    Yes   KASAN: out-of-bounds Write in end_buffer_read_sync
                   https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
<6>  4651    Yes   possible deadlock in ntfs_fiemap
                   https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86
<7>  3603    Yes   possible deadlock in ntfs_file_mmap
                   https://syzkaller.appspot.com/bug?extid=c1751b6739d83d70bb75
<8>  2818    Yes   possible deadlock in mark_as_free_ex (2)
                   https://syzkaller.appspot.com/bug?extid=8df514c431bd240c5644
<9>  2524    Yes   possible deadlock in ntfs_look_for_free_space
                   https://syzkaller.appspot.com/bug?extid=d27edf9f96ae85939222
<10> 2522    Yes   possible deadlock in attr_data_get_block (2)
                   https://syzkaller.appspot.com/bug?extid=262a71e9d2faf8747085

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

