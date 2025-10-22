Return-Path: <linux-kernel+bounces-864195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B078CBFA254
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4031888158
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784B02D5954;
	Wed, 22 Oct 2025 06:01:36 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E622512FF
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761112896; cv=none; b=uxG/ky3Mae3DSH5A4Y2kdvjOFSWfn7ecFoH8gCcUt+dn1GzBAKInqQ4IQ95ToUL8NW4WdeQ2DtO2IzJU7kcZtex1OqQA9IOKrexRXBRCWa4m5imyA6uXjkt8EjPcMtXMqiAWzqClDYiKloTgD8isaYqajaftI0wRniy5oqF3LNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761112896; c=relaxed/simple;
	bh=Xz+xA4iWmuzbetXgjKWkR0I7OqLt/VHd7+0OLb9nFzA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mVx21B+TajCFN1/h6TR5OxON5vAe0oDCoxKupMr+IzoygIDLygpmqbPiPphXyxtMb+kgkiAFKYxZojtQf2mUNYtKICiiK5Yw2UNKHwPKHALaEoUbZdzabeVXjViRKPItxw7lpcVxpex4UyXN2lkJkCGKM//GkLPdhtVjSCZLiAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430da49fb0aso86107935ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761112893; x=1761717693;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAU5nSOSFOEDQ7Ip9vyv0R+/EJBKN0eeOwZiRs0KSA4=;
        b=sTJG0gEcZY8b6ifCxMml0ef8NMEC2iQ58JasQIxcPHIk3Y2O1NVIE8vUeD4kZuNCXI
         3UVGqshYgW6D+23myeFUlN+N3Pk0J643RT9yEb3uC2P5hZ10qWq2eb8iWTCf9THxNRFe
         vtyTdqlty0gZbCTOLBozFHBAuHwdZF8fK58nrVEkv1LlhplX5HwuR1rz/MLQw3yIVQVW
         4W1QWvr50jLwoderWqyItnPbYfTNNE/KBfb5fdlZDUvn2Viz0DdUH1gKQtV79I6S3a9I
         NXsx/ChX/uVSqUTCpjws4o2+hVmFbzl5A5DCmCVdax9t4GrQdjLj714YE1hq665NFy0b
         TYRQ==
X-Gm-Message-State: AOJu0Yxrm5c3gVQnE1pLFe6OLuQzABE35+12vXt8x5bRSBCBQjQNIRhL
	/bK9UUleIdSVeSpti+jINxzQg57r9chR+7Uc0KMv51ULBsT87mVqHUbP6x6ul4mlg8VOL7YAbub
	js9z6TPdT8JVFEeNJ6x+LRftsLUi6trWRh/a4y1zM3DrVd2g2V4+Wh8YF6DY=
X-Google-Smtp-Source: AGHT+IF08d7r4UTCIPHS7Wi5idcSCTuucx204yQX5zireJZJ5UHssxALo5+Xg2e0Ay3Ob68GZUNgG81RuFpQjjS0ik09Nes63jgD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9d:b0:430:ab98:7b1f with SMTP id
 e9e14a558f8ab-430c52beddbmr295913155ab.18.1761112893716; Tue, 21 Oct 2025
 23:01:33 -0700 (PDT)
Date: Tue, 21 Oct 2025 23:01:33 -0700
In-Reply-To: <68c9c3bd.050a0220.3c6139.0e65.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f8733d.050a0220.346f24.0037.GAE@google.com>
Subject: Forwarded: [PATCH] testing
From: syzbot <syzbot+fc241a3fa60015afb3d1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] testing
Author: ankitkhushwaha.linux@gmail.com

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---

#syz test

---
 arch/x86/kernel/kvmclock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index ca0a49eeac4a..7d1c98efa6a4 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -74,7 +74,7 @@ static int kvm_set_wallclock(const struct timespec64 *now)
 static u64 kvm_clock_read(void)
 {
 	u64 ret;
-
+	// 
 	preempt_disable_notrace();
 	ret = pvclock_clocksource_read_nowd(this_cpu_pvti());
 	preempt_enable_notrace();
-- 
2.51.0


