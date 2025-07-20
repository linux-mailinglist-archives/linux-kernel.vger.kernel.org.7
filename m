Return-Path: <linux-kernel+bounces-738416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D375B0B808
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 21:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45484177DBC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 19:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5291D207E1D;
	Sun, 20 Jul 2025 19:46:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9611C6FF4
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753040767; cv=none; b=scY96R6+Er2liqqSMNXW+msOxA52Xsf8BZ1fLuIdv25IOvEBrPwZ67nqDOZHowbz5vtcToKak6V3EDRI6BFsILIXoh3mScGiCqQl+OgP6Xw3DhuZxAlHdDF6XCORPfphiOtvnLTzl0aPxy4KSQw3m5TI5G5fnRw0R0Q48s0NqFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753040767; c=relaxed/simple;
	bh=3DLh/FyJSrYvXto24Li5wfed2wh8xq/eBr+Vf2H0Gik=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KNuN/EAzAKMpkZFO31mg98UkhJc3qekbOuS1SWHQRI7B4QSGUUeQ6cZu72H1nrconvfQXinxzyCGY20zCF2usWkL4R87PuSRdH02kZ18XQeifyVMKrtGLKGNiu8cs++XZrn9NejWQgt61Q/08zVv03juW12Ks1HErptnDCPhboA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-87c1c2a4f9dso393192839f.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753040764; x=1753645564;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5KgLtWZ0CwCP/TuPKdCYqy0Rv2T1YL0QiD6XpuECCus=;
        b=NytvF95IocIRevS+pgrx2dZuM0hqD4Xvqq7SMUQ3gOVyIjuHOBtRNvu853M2QSkreR
         dIn/yKx4jA5AmReUttg1G5bDIvZqI7jBHe9e/X4xCNh+Y91jLX7q0umhWHM1REBQ/lxO
         oDsbG/P0DpkltP4hH4az2lUkRke08X8jikQ484PA1rAqjZu2z8XHDTRFzD4mRFGi/JzN
         Opwp0hkWxC6PV+m+cIMBVWg6ilKZpeeBZoW6wTtAYeYRVcSihcR0SeAPxY4NyLf0HNLr
         NSQ9HhAp8zCO/PZkMlMTZxQcU8mxfkenKPCR8TGkuGFjFYtNIr73IqnHTaYSaW04KPzU
         2qHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPC5Y9ZXhg7DHBZU/kfCILkWehzER35DMcLOrtU1+pm7sy5pB0Z0h2SPURIUXVJJWyzhmvV8Po64WhzqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzunrLmdAD5/Vbi34JgnZp+uJuUTqE30GwOQJ3UmPu0r4OXL+Yr
	O4bB4Jdt2DMasDV4igyDzdJQP7HPlkBSAoWgSmk1AIX3cSI24w4bJoRqeb1cHvnHL9B2Teh6Quj
	SwSe/pR3I4XMtED5yoHRqEIJn7rFMo3i9QtBvQvlRRTURoemmEq6fizVL1N0=
X-Google-Smtp-Source: AGHT+IEcOwPzdzdo5/NOs6BWhUSJM14UQYHEyzZ+lIWo2Sg5sozxClMXS1egNJOFDt+E/cWfMv0xQNxoXK9jrRZDLzph2qG9CogY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9d:b0:3e2:8ddd:b406 with SMTP id
 e9e14a558f8ab-3e28dddb51amr128757635ab.17.1753040764679; Sun, 20 Jul 2025
 12:46:04 -0700 (PDT)
Date: Sun, 20 Jul 2025 12:46:04 -0700
In-Reply-To: <20250720191642.14512-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687d477c.a70a0220.693ce.00d6.GAE@google.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in mon_bin_event
From: syzbot <syzbot+86b6d7c8bcc66747c505@syzkaller.appspotmail.com>
To: contact@arnaud-lcm.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+86b6d7c8bcc66747c505@syzkaller.appspotmail.com
Tested-by: syzbot+86b6d7c8bcc66747c505@syzkaller.appspotmail.com

Tested on:

commit:         d086c886 Add linux-next specific files for 20250718
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=118af7d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a6aa2cafcc62853
dashboard link: https://syzkaller.appspot.com/bug?extid=86b6d7c8bcc66747c505
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15fa638c580000

Note: testing is done by a robot and is best-effort only.

