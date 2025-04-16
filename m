Return-Path: <linux-kernel+bounces-604906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BC9A89A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 12:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1E4188E2FB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 10:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC7928BA9E;
	Tue, 15 Apr 2025 10:40:24 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B264217C98
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744713624; cv=none; b=BGoHPJ7B95sVjKHXXrPP6fgnV8IY4NJ/GFvXCPMqHutnN9221Bran+0eqAltP9qcBfdKqO6VG0QnDz5c4lV3IpF3caYjowBVnfKKUJBpgjwE5Uxhgar6I455I9b33P9i9pg4HPDWckwFuNpD23g6GrmhoKi5UGHs9ylQVyKCrRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744713624; c=relaxed/simple;
	bh=AgOaXgjLwCqnjPYXHap1rE1GdF6NmnxUolRQOeY/cVw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eZ3vLJ7AZvdFfR/QwDDUOcoapkEctNJpzGxqf5111AnD2HYcOE6y8fsiRzFkZIpBbE0K7v2do/mPhACL6ZZUyRultVAxvBOrsy98hc48SlOomsxBHBeRozyv8TUQw18CiyQlATzZoN7H4A20IH4hWWC2mpwM3A2WR/DjFnF1/ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d43d333855so42318725ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 03:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744713622; x=1745318422;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eP7Hz/J1y4fMiyeT9H2f5gML4RT7x+IK4QqchZbfjmI=;
        b=QWTmvgISb0cjixcZ84Mz+cT8Bqh7cq81dXCSlgnMd1SSrM1bhyyt9+x2WmfWMonuoJ
         O/lhpC0uAscg2xxSSxyJt4vUF6nwQ3JqHzqGD6Qh+r/vSbmkFFlAhiSYeZBDaXTQR0x5
         WtfEo/SSdBqeZaihftxdQBwE39Nx94xzgkxST/7F8pbyhSrrKgojP7tqFNWJc4Iu9SuN
         xnb3lHt60WZBPDGwAWZRKFGwcsKElIOK5b8e9chup4+wD1JGZMPwahENfzw56qp4TAK1
         CadrUf9aVAwKedYJuoGoeLTNLQvaxcRtsNaOQRQxgFr+Cbg4Ftz1apCSEnbBQ39F/g6o
         CRnw==
X-Forwarded-Encrypted: i=1; AJvYcCU2R79htPh6Ye/O/2QrIFM0vYjBCIUT9EORZGsm/WQYK0pypLl1aq3ruRwnYhA79YkHfByFOyI8dQmFDCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSQkX0kOaSUS3s6w0iFH4OTk1Y1Ci9Qk89v1S2UttQmpTxrrW+
	F2vYpzdcHITq4Vap/ToqrLyrKuK3NCe/SFvLfRky7B6enR1Ic9gCqs1g5mGApVpi0hkyzc5Fb02
	cADChYClaOOdkOi7C0DJMRde7cqZFzTQn0nJaNwTb5OKaoFuFfySWkys=
X-Google-Smtp-Source: AGHT+IEHG4vd+gOPU+P1DxtVlQAKloyX2pka4ZAGczUOG5c6TwkAdjBAVMq6yK/FEroFMMSUuWTk4+Z5aiy2vMMA/jERtu91CWuz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2161:b0:3d0:443d:a5c3 with SMTP id
 e9e14a558f8ab-3d7ec1d9a8amr136253415ab.3.1744713621887; Tue, 15 Apr 2025
 03:40:21 -0700 (PDT)
Date: Tue, 15 Apr 2025 03:40:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67fe3795.050a0220.3483fc.004f.GAE@google.com>
Subject: [syzbot] Monthly smc report (Apr 2025)
From: syzbot <syzbot+list9b3d6b0c7970945b664e@syzkaller.appspotmail.com>
To: jaka@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello smc maintainers/developers,

This is a 31-day syzbot report for the smc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/smc

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2917    Yes   possible deadlock in smc_vlan_by_tcpsk
                  https://syzkaller.appspot.com/bug?extid=c75d1de73d3b8b76272f
<2> 76      Yes   possible deadlock in smc_release
                  https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
<3> 5       Yes   possible deadlock in smc_pnet_find_ism_resource
                  https://syzkaller.appspot.com/bug?extid=f160105b2817964a0886

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

