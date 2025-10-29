Return-Path: <linux-kernel+bounces-875561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F7AC1946E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D6C1A22D74
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0971031E0EB;
	Wed, 29 Oct 2025 08:59:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368F3314D12
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761728347; cv=none; b=CPoIilPYRtBpB3zDxvUAcXWtJGIHh95vILp/WO6IKRHz0QF8TUPYVZ5WomTQiHwF9EGagEDhUhvg9Mt0H/W28EvVavU5+0H4bx46shCoSXD0j6BLq6fnSoEckGOg3iuGTkklTM5xJ3KJxt5VGHyVgHWcveNaGeQq2NT9bQM68FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761728347; c=relaxed/simple;
	bh=nXE8amQUtE35BjRIkaNBmaeRFx7Xt4yCQePP+93QDE0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Mkowhd+bOLar/QR5LlNDP80HzSahsIe2xFR19fR19Hjg1o0T3LVZuwiKbrvY91dl11KqKdtwskXaiH/XAoOgEpJqFNK1swURO7eEPXhu68Ki8oQ8JGyhZZPFDkgVHkttxJU2kb6sCLIbZMnjX6esV/6X/jHn3TIZcXOIuDoDu+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430c3232caeso87385495ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761728344; x=1762333144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lk5/8EJn8R26du3rBcwO3FVObnk6mc2SIWGYsmB1lQE=;
        b=RW+8DdlJn9sDtrhnTn63CAQqsOMwANeWIGH+n9rY8s4iBljCB69ibf/El1K+zm7qeO
         VYOUoL9/itsAU7LEWx8enVNL+MHK992S6pU99pUxA7ctXhWa1CK31hroSZlHZUea6Jwy
         AdrEpJ4jHooUudl1tRyf9mOrXzp4zldbseZit+d/Xd9+UD7ZZrx9Y+6+MpnZ78xVgMCk
         imU2M2YhvAtuK41vMjMUD3YZ9kvJtsHoSPCUGoV6KRElCnyjqicXji04my3WKH8DnULu
         PS6sFtS4p+NPhI5rpDL60MtqjtJ7W6bhXm+KBrLcX41BA4NuScu9ekpajJbWLUGQN04N
         Eykw==
X-Forwarded-Encrypted: i=1; AJvYcCWAXigwsa0sdiFXN3ST/G8N+mCWN3NseEa1pJC6nR5hefHliqhgPnFoZV9LTwdnXASDKTaKGMI2G1EMyWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ULyG64QzhtClg0/eUAxJDSVffATfVvj+2W7OtFmUEDFfgKoq
	xWxZ1vbPFOnnIAVVXnPKLyBGayyq1k71IMuh3fZ/ch9NXWHLZDi8LMwQIwURF+wLTVC5Yb5VMBF
	5qCaKLx0HpftPYEOPqLWkXdGyXpAb4UD+vQRRPZ51R80d1sEqX6sYWEt6ZNg=
X-Google-Smtp-Source: AGHT+IE3oaK6/WHZ/xF3PiqKd4CXLzH2N5lAt23Cp1laCb32fJU3Ca1j0iNZjTLQIgnlRfg2Zm75JXnFJbRzzLOaKZw+PdaTNBeI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2283:b0:430:aedb:3719 with SMTP id
 e9e14a558f8ab-432f8f80fb3mr28385005ab.4.1761728344291; Wed, 29 Oct 2025
 01:59:04 -0700 (PDT)
Date: Wed, 29 Oct 2025 01:59:04 -0700
In-Reply-To: <20251029062739.-2Z1X%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901d758.050a0220.3344a1.041b.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dx_dir_lookup_rec
From: syzbot <syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com
Tested-by: syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com

Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=17ef6fe2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae55ec3582be8d28
dashboard link: https://syzkaller.appspot.com/bug?extid=30b53487d00b4f7f0922
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11e3dfe2580000

Note: testing is done by a robot and is best-effort only.

