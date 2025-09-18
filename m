Return-Path: <linux-kernel+bounces-823594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F0BB86F06
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2801C88590
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1944C2F39C3;
	Thu, 18 Sep 2025 20:44:32 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE562F28EC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758228271; cv=none; b=Lgf3DpUE0b2rGCT+KNLYJrK8acX7JrJk4PvQwt8xQJxu8W8xznJM84BOAhELnOo2WZ/1RZfbv3DeYxqZDlu2gen+yxSs9y+tuB0Kntf8OYn3iUifs1MK15fsH+QGGm6RL4swfVPv/jj0Cj+6KcPDpxqFyNZ54/vSKajmi6CSuYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758228271; c=relaxed/simple;
	bh=NfiIJR6kIHevsUQujY5aQQ/4j2GVgOuNSAyAHQIKxjE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mS0AeQVDxl2foFiOTRxZZJt76w/yoEhWTV25sbRu7FgZybkI1/YciBzFF/nBCdsa1n/8jIGQB4z/itY9sf4oaG9avh1NR+R8h86vIJOgiUKhOwyV6Ytm3BWf1yyM/f8IcfTRNFlch1KnJpyQUkU8urwy2w1ivMB4h7lUVCJmgDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-40f7be8ecf2so34419785ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758228269; x=1758833069;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jy95kM/qgX/gO/SpA4ej+P7GNTHFDJ+aCcX1GcgB2yk=;
        b=iFOL7w+VuWj95XVpYkMBXFi4tu4wKP8MczoPkowMPeIHuowmI68/tW1ptap1n9B1kR
         BVmjGnsfyflNBrq5Z8VXW0VLt07gxXtQcJnldktfxpqAIy6gG/9b5wIJTBRzxCQSxtkE
         AqICBnzDZMYo+UkNfhZ44tb93miOj85oPXndQZyzxD7JgIzQf3ZtWT8Igigl0IK+gLO4
         wUSLipOc0CgVSJf8bEtUnssqlBOXZHrsFfynvD14qBH6nNbnksuw/Umvp+2Mx9+3332g
         1xf2hCpPGt5YPhwVUFlKkOHhRyyqrc+nkWIYgmT/pLBJFwSLz3YtG6qx+H1AVBCJq7oT
         3cSg==
X-Forwarded-Encrypted: i=1; AJvYcCWhGb+/SGIc9KPoc/BwbMUEr7cEx7c5DR9o0sYBqk3WIuYKyS+m17H3D0G2NLqJSQlq6XdRW/QULZSBHzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyidG3Np/929uFhFib9u087npE8Lf5AmjQf2HUR2HSE8Cb7Ogpz
	E1PxGCsuzgGRue8Nj1TP4z+uSQASNZCpxusI3E0jGMVKyTGSRDmZ9fFFRF4Jnk3rUTt4ozvp7jo
	CLV3T3iKdvyUKC4rBkolLfKrihoX3RvFKJFunLWEkebTe53tAilx+BbA8tps=
X-Google-Smtp-Source: AGHT+IFu1MADOFwiTOdU5yaJk1ZgNZavxLZ2jQpFx0eMPLtJmGm9swFNp0+N1yEJNO6C9z/DFUwMwah6rUU7Dl2Hk1mJlu3m/iVX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdad:0:b0:424:8160:46de with SMTP id
 e9e14a558f8ab-424819bcc22mr16145105ab.28.1758228269425; Thu, 18 Sep 2025
 13:44:29 -0700 (PDT)
Date: Thu, 18 Sep 2025 13:44:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cc6f2d.a00a0220.37dadf.000a.GAE@google.com>
Subject: [syzbot] Monthly smc report (Sep 2025)
From: syzbot <syzbot+list16381c3f7f9f0890654e@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, netdev@vger.kernel.org, sidraya@linux.ibm.com, 
	syzkaller-bugs@googlegroups.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello smc maintainers/developers,

This is a 31-day syzbot report for the smc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/smc

During the period, 1 new issues were detected and 1 were fixed.
In total, 6 issues are still open and 46 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 484     Yes   general protection fault in smc_diag_dump_proto
                  https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
<2> 128     Yes   possible deadlock in smc_release
                  https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
<3> 5       Yes   general protection fault in __smc_diag_dump (4)
                  https://syzkaller.appspot.com/bug?extid=f775be4458668f7d220e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

