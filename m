Return-Path: <linux-kernel+bounces-786111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BC2B35519
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652321B652CD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F618277819;
	Tue, 26 Aug 2025 07:15:28 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F88295DA6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192527; cv=none; b=MznsYy5SXtTTJoCGoPpIGpK9elortcN71ZVZz1Pjx23EByJmDeRcqfb3tqGCFQW4E2sctFgey2a4t3jXhRvR/ie6fc3ptUZdCXkMi6osrtN+zWXieXnUbJ21HnCFa4ZfZcl4qTJnuT1oW04fZh5rhGuIHCa5W4af/ccRhZXMVSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192527; c=relaxed/simple;
	bh=1sy5Tr3GAcIm6aw2fXVy5YDU8nQb1Qte2LmpTgca02E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YG5MQ3H6zkTqv3yzpdz1/m35cwD80uzkzCJLKEhGXUMhz0KqHZ+aV10ut2g/ZvGWLQ0L34WqlV6Np/wLnFbWPmhihulyOftVJZ54HPFwGBcASu2Eny7uvr1zSaZNLic+6TyL/aU4mYfbj7FPhL+8sBR36/pU4qFtHjzbt+sj68Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-88432d8ddb1so513568639f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192525; x=1756797325;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1sy5Tr3GAcIm6aw2fXVy5YDU8nQb1Qte2LmpTgca02E=;
        b=pokNJvlXF90kUdtDKRvmyOW/glOb+elySaK0zcXciwa8UwUyIIJv/IO5POmLEcHJ07
         bQ/TTqbkCOhZtUNg/y+A97bCJS0i1q3z7mgJEpOT8varCWPL8/Y72JdYzHI5VumRdkTa
         SHsAUzXmT41+VRg7Jr0ElcsyqxKnNXLhkaf3VICeVsLQMhDk3gch1pKt+wRMcQRgj8Pv
         pAqoFp0CdymFas0L/hj8EwgLSx+0Strf2eX7IO6QbPlym5AYR000Twcz1+r0i3TKFtGO
         biDHVql/Y0BHUKbxl9ot4lM8m6Krt42YfZvgM4P/5aHqR5JVGGt6eXsTZqMKxYTdi4Bu
         HRVw==
X-Gm-Message-State: AOJu0YxWT0xRyvdMFeV7TDJg3oVqOAMD4exKbBLa+4Yk7/lHrDr3CJdI
	fq6mmJjvysVIegty+onugoqpnAQVm/3uGWIz+PytHjt3DT8I9uyH9RKEju99mIylkFhx1VomzWn
	lnI3jslNwD6mLAny4p/iP206/mj8467G3mBM66ggfjzLGU7DD5vVcVFQZUaw=
X-Google-Smtp-Source: AGHT+IEGs6cJgpon47vn/TmQ8K/1SGg1m53oMC4gpgApWpsr/CxosYHzR5L3JrgcxOGYEXA/vuicJGy90qjKhrNhLG/9Jp7aN64N
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cc:b0:3e5:57f3:abfe with SMTP id
 e9e14a558f8ab-3e921770983mr231130645ab.12.1756192525402; Tue, 26 Aug 2025
 00:15:25 -0700 (PDT)
Date: Tue, 26 Aug 2025 00:15:25 -0700
In-Reply-To: <68ac2412.050a0220.37038e.0088.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ad5f0d.050a0220.37038e.00b3.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 fab1beda7597fac1cecc01707d55eadb6bbe773c
From: syzbot <syzbot+900962ac9bf1860033f2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fab1beda7597fac1cecc01707d55eadb6bbe773c
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fab1beda7597fac1cecc01707d55eadb6bbe773c

