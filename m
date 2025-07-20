Return-Path: <linux-kernel+bounces-738344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B762B0B745
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 19:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C361782FA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 17:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F7A21CC6D;
	Sun, 20 Jul 2025 17:30:57 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05140B661
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753032657; cv=none; b=R7CoW1K5TIrYSn548He5IHEyeJbvP2ZxXRr2I+89KfByq5XhTLAo77d6EHHhHgQI6pUnAbDUxQqZTzVGLUjPX+K5kdSClNyqjqG69Ddhs0dnuc/j3GwqiWwEBWu1bCyHNCicmoNZNmRgp/SIEv5OxVkoAfhiG0Aa/w3GfGNlyWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753032657; c=relaxed/simple;
	bh=x05E0qNAlSIwKton3oXuHKERkRpcg5BwWlnfPSrBMLo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=I3gyfYbWMF7aQBK/2YrCG74gVkaSjWif/2lg+Cje+p71bAOslx1fGPb5iP0a64edN3hbgjpfLm9U5jHimcUaQsYZCFJtDQhvEUAn8LwjSNton9UaiXwA2ymqDHtZIw90AuaVeXB331mkLdIKCjIMSHRcwb9XiCb4l9xiUat9S9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e29fa7a669so39402325ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 10:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753032654; x=1753637454;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=noem2y0IGMlFQezwnSmI6wy0bzvQETAW5KKgJraguFk=;
        b=fSPhURy87R6Vb9+xR7VbpRSPWf4fuIPlwWeZniYBzO+KzUxkrn8km5G0bijxl1ZoYG
         FKSvLQx0stiSfBa4Ia+EkSP3w2Nx3FBfkoYuJBDp+kb/vk5LQVugJEaAZbhlNjYsiW8i
         3Kf8f1yMhtxNIHbhPbSEk5FY+NaWxc1+iQ4In7BJGSfJRAaYAKR4P1BlX8vah1nTlGXM
         r3Fyh/L81BvrzfhT5caJumtua9C5ZUpA44OuNCl3OwOjRmuG4Hwcnrjpnw/Fkk69W6bB
         lYWtwpEYQFoKwN7bcZ9df+ahVRia8xxxxaLmhX564LNFiz6zhkuHE4YTPEIbszxY8PLX
         p+/g==
X-Gm-Message-State: AOJu0YyJnikTxyyoGNdqrgU8+MQQp5YFm1e1pmqNgHyAnH5+itXn7OiF
	8kVIH2hKWzB0FfJsmZQIeYnZb7iPH2bn5HrcbR7k3fRsLZ5V6GBoqTOg+qsqH8I4mNPiKYiiyVq
	l8AvDRpJL8dXlSurdQo4bjchDXqJv4x1Nle0XfBsMokuJUgColVqdOPQwge0=
X-Google-Smtp-Source: AGHT+IEU2mO7drjdFHntIdMiT1Rc4WoRlXLQjgfpwM1zd/8GTMIvvY5YGGtkNTyd7zvUn2QromYK9aFGx/cPiagjEq7Ne45ITL25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a01:b0:3e2:a586:3f2a with SMTP id
 e9e14a558f8ab-3e2a58640b4mr48700485ab.10.1753032654086; Sun, 20 Jul 2025
 10:30:54 -0700 (PDT)
Date: Sun, 20 Jul 2025 10:30:54 -0700
In-Reply-To: <683b4a53.a00a0220.d8eae.001c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687d27ce.a70a0220.693ce.00cf.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+527519da96e15b411c73@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Don't allow mounting with crazy numbers of dirty journal entries

