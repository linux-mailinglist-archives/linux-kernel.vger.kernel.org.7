Return-Path: <linux-kernel+bounces-823977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB3EB87D87
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 06:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5310567A1E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E43B266582;
	Fri, 19 Sep 2025 04:01:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0EC19D083
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 04:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758254464; cv=none; b=LQexdlHH4cSLf1/2fSryra826hZ6hIOrsjrVd15D1ihXTDEC5KYeap88E3wCxwDGJRIR+gD8Wfx4j3BAPckye/Cm8XCGqczdjpjZDehGwS4hfm3cxlnpgYU0ZiOITug7clf063aO9vVW3G3DNYdsSFkJYg6L5PibYgJSKkEO2ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758254464; c=relaxed/simple;
	bh=ouvabztvBePsJ3eaH5/w487SdXuqBTErwzdVgnyu3ZU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=V3n+35iM09vyDqh69f/GFxMAg0hR9DvcFB/eGU6ngrwz7rC4EUtltnYSzl5lQ4GbDxO/1Ltsk1DyyNih3ZoBHfNKxyt/09v+gM+jL2hvI6MVOqkeq/49F27Y9GANne89kb7Xdyhq4xL9HCawdLCDlFNAKLraLvd6p+hVHCMGDgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8870219dce3so183187939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 21:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758254462; x=1758859262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IulN+igi3cpw905djkzcEMAptMFKIjnsWKZB5c5SZ2E=;
        b=t0ngofcwHAW4j+ouI6lSsh75om3BFI/dF67QdWtfDKt7zWPcZSBlxdVJvR3PQ2PmCq
         yGKNszwdxc8dbymOnjkSX+kj3swros6r58WAMGwKU6lKkPsmEkitT9Nm2uYtdoos5uSV
         AUVH0qe/imxpajEskjagOAYQMF4iNnewWVfIr4hi0U/upMbvNouj+O9jYzQnJqth43r5
         x/sqEHgYAv8sML+tgkNKZt3aw2iR7rXZXqODsayVKaUQA3aotuheN3AFlweNxwOvFMjg
         8V9gZDPQrhchnw7fikqHMjDbFwIO39Ssm899UyHtOviOtpfnKDkjHxBtMIWDzndte+F3
         xQmg==
X-Forwarded-Encrypted: i=1; AJvYcCWkF5/UbrqUlNwYgttkIzKVS+z9KTDk+AHPhvTnYplYTz/oEPI6vChbPlxMzFKb9uABCLYI+/70LFi9Zfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw73k/5oaprvt1E9pe8Zw2FOUPNOxObVkYp4f7EzIBnR79le/nb
	BJcOk5Ev+jmIbMvRShEGuDHM4d9NDqzwQA7ZmJDlAzGSFsWEX3Kv9jXM9xsIqBikQOk+6G1LBB+
	UBr9X+mp8AC6tvg8REf+kzIPlR56FvRirG4w0CXmjbD6+OV7MAGalMpsV26w=
X-Google-Smtp-Source: AGHT+IHm+W8tdy68zb31OkCXSByh73N7mrHV77cGbyN2ywRb3nvvaxdLIN0Ne7mxO8w4bZQz4Zp5leyCBiPf2MBrJnKAl9rcZsLE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4606:b0:424:8598:59c4 with SMTP id
 e9e14a558f8ab-42485985d46mr4379665ab.18.1758254462605; Thu, 18 Sep 2025
 21:01:02 -0700 (PDT)
Date: Thu, 18 Sep 2025 21:01:02 -0700
In-Reply-To: <000000000000c7e54f0621e8a14f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ccd57e.050a0220.28a605.0019.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: slab-use-after-free Read in ocfs2_fault
From: syzbot <syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, masahiroy@kernel.org, 
	ocfs2-devel@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f79dc03fe68c79d388908182e68d702f7f1786bc
Author: Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue Jun 18 10:35:21 2024 +0000

    kconfig: refactor choice value calculation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1154ee42580000
start commit:   8b789f2b7602 Merge tag 'mm-hotfixes-stable-2025-09-17-21-1..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1354ee42580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1554ee42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=a49010a0e8fcdeea075f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179f40e2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109acf62580000

Reported-by: syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com
Fixes: f79dc03fe68c ("kconfig: refactor choice value calculation")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

