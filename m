Return-Path: <linux-kernel+bounces-879171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3E0C22700
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6611A2197F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB721307AFB;
	Thu, 30 Oct 2025 21:38:29 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E874034D3B6
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860309; cv=none; b=if9cNzCAeoStQMHApz+yjrUD32iSi4M1ZqMY0IvujwmcMa1okWOC/N+fTj++xQLcW5FlDXoarAEKpp4oNBotuJbdGCRqa4s2oPArr47VFOVr1tLu/2Nu24e/qB/zMt0g/T2j9YD0BVkSFjRXafdcbTDIIajZxmcr57Gwge6IKlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860309; c=relaxed/simple;
	bh=pE8wmq8bULXpVfXNeVtqtkI05jrh4XrKSUyVstTlMKI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HprVwwjoOnaD2LL8l0WIyRjceDcOrj+V8PfqaLQYL/OOa54CxfNykzeKx4o7FOb0KTBmfDwJjGS7dTgHWr3s7x+kXEN9QcQcE2wxiJdtRTDSvxMIIcf1sW4zWzYM4Pb/RFaYmxu83+j+K6crVX5FURV+kd2EFLy6DnnE+RRm1Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430d83d262fso52128195ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761860307; x=1762465107;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pE8wmq8bULXpVfXNeVtqtkI05jrh4XrKSUyVstTlMKI=;
        b=G5QV+IVI3w2O/0b+hGxdED3aDKhA2QcW8BliNyLReaKbnnRI5qf/toQzAFzvlyu8DY
         lPWQa+OPoEMqrg/zQvaKarpMgx0IHexccu+e+91mvmqFg0r3lJPXbOQIuulpDZDSvtzy
         1+9bBpuFBDrkCw5BXaljWO59eO4uhIAnKU+3oaPdl+lLuTfUOo5afuwtkefwLyDXphU8
         3G6PiRJdA/q8SR3RW14m2DZ0T2Qx+sOw6pCpLpR2UlIqsAZLIbKjM6S7GfnLRvZpYVSN
         rLlfuR0VtEuZPXERvCrCgrlGrOhuuqXn+TAFWpIWC1k3tzwhkHGB8S4HfLf1w5Dvl+FS
         FsVg==
X-Gm-Message-State: AOJu0YzxpqaI0PKzQXiaY0WOrTQnXn21+7D/2kxwEB2aGluhktuGxAli
	Zn/xikg/i+cadHnVeud135nvexQ7xYJnEREKjRNMltuBZ5pN16lxfPRBFi1XiYejOgcRNCLeWCM
	Uf8kTO6ldt4sh1cET9cMp7WHNtKyXXXtwJU+AvO13yT6fNB2eJkXCSCPtvls=
X-Google-Smtp-Source: AGHT+IGFvy2pUHe2AncQQOB7O9BLD7nc17ZoJmbNYeGM6J4QINaZfMZJGlmtYmaPyLMaNTIl8/Kk+6e0eNW4g3Nu2x+vx9ElQ8gh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:330a:b0:430:aec5:9be4 with SMTP id
 e9e14a558f8ab-4330d1199efmr21664525ab.7.1761860307160; Thu, 30 Oct 2025
 14:38:27 -0700 (PDT)
Date: Thu, 30 Oct 2025 14:38:27 -0700
In-Reply-To: <68cb3c25.050a0220.50883.002a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6903dad3.050a0220.3344a1.0449.GAE@google.com>
Subject: Forwarded: INFO: task hung in bfs_lookup (6)
From: syzbot <syzbot+e7be6bf3e45b7b463bfa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: INFO: task hung in bfs_lookup (6)
Author: zlatistiv@gmail.com

#syz test

