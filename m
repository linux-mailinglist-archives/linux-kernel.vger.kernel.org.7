Return-Path: <linux-kernel+bounces-841987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 958F2BB8B89
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 11:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E6814E2DAD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 09:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B45423BD13;
	Sat,  4 Oct 2025 09:17:30 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820411C84BD
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759569450; cv=none; b=A3s9vEA4P8s1X9h2r9io9/wtBOThB75j2TN67F7ktnj0DuZLmIizZGaviytyLt9wTDnw+Y3JIwPzMmJ60VsYHswIeorm3PsnTQDLs6YEwb/th/oWVh1qCskUS4dDoU2gagJFiI7a8dtL/IxaDTG5XI+hWSTYw8dLxpK+Ij3EA1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759569450; c=relaxed/simple;
	bh=h55S7+UKs6SEE8xfVRiy/8Pruq0+NinfBkohqQ3QxEA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Z9WGDizE6yGeCKxrD0mhKPWOe0zAFYOTtZOHzx2OwEFYB+U6Lw6ua3PcwObmAOGeGXTbOkeDd3FCs6NUsN9Zps/5oK9I/XhXdn7WRSjk0y5kW/mg1VOe800TqdR/dtCgqSaHEh9ltodvSWHGd7TXZA9+Vye37TLeknvyNDV2MuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42d8b990b00so82062515ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 02:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759569447; x=1760174247;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BIG6oZNTDpYclLfV7No+nENFcYt4Th02KE4t59yzIOI=;
        b=nFB6a+SI/qMZlNhM78idPmxSuAxdxFXvhidRfMNFCh13Ck5646nKUefVAUigekMBnE
         tM9xwoaesuixCbIV/OnDguc3TmQYAzOlsFQMKbGk3QbajWTJxuZL1SdoHD26KwGDb91/
         htUtCX5lL5wPMB9DaHUJnTwv9ai53qf8o9xp8zQSWBUboXFN9DhB4p4wHcrmFlg1Aks2
         gaf+juvAyhLjlKKkd6s2pSAw58OnUZYvWxCtuX7hWn5bNW8NgG7f5FtvTFznME63iRNM
         skVSLTr/ffllbmCm4pBNwqiTBz8nkLpWd/uEyZ2Iz9kCHlFjzRELzICCErHWhS7aY1r0
         +38Q==
X-Forwarded-Encrypted: i=1; AJvYcCUk2L+tfy8cdIfVUpLQTM0nMc2/QJcRyQkrTl7bD5FF62oD8N91N3w+/P31b3TtgKSblEcieay95J2jDTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YztNZDiuSDALVnJ+2VI7btvpS5l4S+7DCQyWrs9cobhfSJAtV1f
	HNP746Wo7L7yf5enhlOMdCFk+reI71PPbEICBJPvZxHujKc3yG9/2wsMugL5YSXQAFIq3psFuHi
	3QlSQGCcTAjXn0BQgldM3q9c9lOKsDf3RmXd41JoZR3bumAekI1bTzM233cQ=
X-Google-Smtp-Source: AGHT+IG+svriUzw2DiMwSyLn1M5GTJ/87nULoyQvu6EYW2Pfe/unhigyNbS1LMDqpSUTCx7ZhfVPJhDz/E4xBvM+Rf/eBz5e+CSh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e04:b0:427:be36:2974 with SMTP id
 e9e14a558f8ab-42e7acfca92mr74974265ab.5.1759569447693; Sat, 04 Oct 2025
 02:17:27 -0700 (PDT)
Date: Sat, 04 Oct 2025 02:17:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e0e627.a00a0220.102ee.011c.GAE@google.com>
Subject: [syzbot] Monthly nilfs report (Oct 2025)
From: syzbot <syzbot+list7fdc58f8e19ec0678b0e@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nilfs maintainers/developers,

This is a 31-day syzbot report for the nilfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nilfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 63 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 6       Yes   WARNING in nilfs_btree_assign (3)
                  https://syzkaller.appspot.com/bug?extid=158be45e4d99232e1900
<2> 3       No    WARNING in nilfs_rename (2)
                  https://syzkaller.appspot.com/bug?extid=f6c7e1f1809f235eeb90
<3> 2       Yes   INFO: task hung in mISDN_ioctl
                  https://syzkaller.appspot.com/bug?extid=5d83cecd003a369a9965

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

