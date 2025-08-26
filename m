Return-Path: <linux-kernel+bounces-786107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D87B3550F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA3417769B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6A62F657E;
	Tue, 26 Aug 2025 07:14:34 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1345019FA8D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192474; cv=none; b=HZHG1aUAuFbyAzzfhw8BHGrbdGvS8J5dvLTKCX3+I3RttAie9gDLjs9jsqm921DsH73wanlOgzqxctki97aiBphk2C9O/F1MNzu1zbqIZtjp3dT2mhOFNbQ6aFKMNACmA2QtpaA0BCrpUaluzgEzkw2S6+jV1e3IAMV2YHAQcYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192474; c=relaxed/simple;
	bh=c119skgSM6HGik+wFvHBiwUqdTIg4OpL/5xZ983/l9U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y4QrCdEuhNplCr/LUOzrG3iRMbgBzJEzB6BwHPORn5azj56NHKxGKd/GbqcTdEZqMf6+7QRB2IrKbDBhEnXFwsejX8iWO98LfEFKWKLqL2dcocftKFuaVYXFLJbbOocK5h+mYHTFhkOJMoAqb9p3XDm9ZR2DJBHeot3pkLB2r/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88432e1eaa5so1306558939f.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192472; x=1756797272;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mzuemg9lA17JRDU0q2qVaghTZtJ3Jd1gRlqQVTONt/k=;
        b=qn7A6W4vSOHXoQxe/ISDLAprvIwMgogF+u0R6lDBqUSu+ijGAiVrekUBR+MID2bZuF
         PGzdmouRPuvgAoRDoqUF4jxZWVV81imQmkLWjvvL39joPMaAdqlgTZdgBNfGZfTpCC54
         zlkX/KuSfLvt2cubiGoyp8B589hYwlR/+stl4wMndzN6x/4LoCUa8D9SN/DpzAbFuJi9
         aOp98VU/stqTV5cq6LZuC/xD1IXqCb7trh5dNEWP5cAs5m7vTlRYVLHzQU0tGaZdVgGu
         /EcGsunpWEw11FFDntXzZBXCNs0jkVhQsKLaUksXfPeV6TiYBFOUrhPJ/RcAO+CouuTT
         8l4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXv6vPAjYwEyy/wZlU0cMAv2hybOzyCCki3Z36Hajv9zi4jkiiEnzkCLSryC9IAwAjXkGEULJM+wY5nIRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr3gb46H6wGpMJXQA25ogScV7H9jewOAg2uJwOIVDz3951atyi
	lXw2xWwagjYlwuFb1QW9awVNk5IfUAP9REn9AAoR6TWuzhvNAc5njQxaSHc3ZYH4OzVali/+NNA
	T0V0Rzu3c/QY3p9xUWAzJjsMe9YD2OHSZbOToynGsoPNDB4omU+DEwjlUdGc=
X-Google-Smtp-Source: AGHT+IFF+gKMytGGL8/Q++mVXF+zFwEI6PLlA/BbKnZtFj7NdYEhbHt+nHSRyqCbm6tlWxto7dejgGAH3LQjGzWwRt5/CzXTu23/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaf:b0:3ec:ab8:9b43 with SMTP id
 e9e14a558f8ab-3ec0ab89d8cmr87827295ab.7.1756192472347; Tue, 26 Aug 2025
 00:14:32 -0700 (PDT)
Date: Tue, 26 Aug 2025 00:14:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ad5ed8.050a0220.37038e.00b0.GAE@google.com>
Subject: [syzbot] Monthly exfat report (Aug 2025)
From: syzbot <syzbot+list9ef902aa1d4a209e3050@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello exfat maintainers/developers,

This is a 31-day syzbot report for the exfat subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/exfat

During the period, 2 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 36 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 445     Yes   WARNING in rcu_sync_dtor (2)
                  https://syzkaller.appspot.com/bug?extid=823cd0d24881f21ab9f1
<2> 63      Yes   INFO: task hung in vfs_unlink (5)
                  https://syzkaller.appspot.com/bug?extid=6983c03a6a28616e362f
<3> 44      Yes   kernel BUG in folio_set_bh
                  https://syzkaller.appspot.com/bug?extid=f4f84b57a01d6b8364ad

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

