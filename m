Return-Path: <linux-kernel+bounces-868922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 673A9C067D5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A2AE35C8E6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD80E31D757;
	Fri, 24 Oct 2025 13:27:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33EF31D75E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312424; cv=none; b=M4L6Wjx8pIX0X4aKDL0xLMFKQbEPPAPKOSEAeZlAVGKuZI2RSvTi1BU3oThp5WCGcRqTC4mHexip4qvVGHVR0bVmLEdz791zHHvzJaXSkMjRKCaT4J6aIhB+VFqu++hZhwyTlcq17YbAoD7rZILy0hrKQhIzGSwaKyOtHzW4rrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312424; c=relaxed/simple;
	bh=eXYCvnsqNchHdINlSTtMsZ7uOiBOMMyrVt8uPgD74sY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jmRm+2Sh++5nFA2lDqpCfvmFKORggwgkxHqFQW0ZqJfP/FZPywj1uYGrC+52zCyYd56QP8SzSEc4NSceuP1HFy2epluhBj6++toFYv3KvHNxqdEpm7xRUv4yR5G4PZd+4LfMP+7rMQbUf3n706PXm8haJo6b/jAL31O3sqzBckY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430c684035eso36545325ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761312422; x=1761917222;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76wSCK+WJ5naaiaHH8l4qfTl3xGxqvZEh7ocsouKmD8=;
        b=srzIc4xp+jCgkUP+MZE8N6wPWxCyZrH+VHxY1eBKLU/h9jWRO2JU7StvrY8O34SzEt
         a7TFAOduOC2DDhIHLJxj7dRBTZpYz/jOuIBxtj65LEpTrqtlmIkcprTeILqAGa/zQ/AV
         +ZlYz+J6Bj634tfL7tsbDGgYEWBHvsKaK6c5QCxExJM+OoPRy855y8LMbX/MV4nWPNpU
         LVFATQPY6WuxvMXyonzgBh5Bv0u2dSkp6FpbPXM+7dLqKn1Srga+VJX3s9a4XRGvbFSU
         WHh9SGBuZyBe1sdHJTeeyanp1CUvBDD8urNAxMEN+TpfoROE5VqLB+21ZtvSfHPti9qd
         Fktw==
X-Forwarded-Encrypted: i=1; AJvYcCUjP5c/ZTiVwO2+sCAF9b6VyEGcc/X5nBRxFo5Rj20Vh8HudD1XdURxxHYfuG9UYrtEKRnqiJwPShA2/w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ8QXIOXO+jFxWYBOgeCe5YQ1CbUE/VrtXKakTETabShPvE3uP
	rrtHHmY90/O3p0fuje6sG4McObOtPEgJOkOHH67ZxjWui29XUOGkrQaaJ2sPFkkwXAuELOB3Nuf
	wB616eMBiw3PBlMNILFZyVs8kX9bMCquLi/2nG+ayGYaOUcOMcSpXpXooeY0=
X-Google-Smtp-Source: AGHT+IGKxu/IHmtDI5e2Jsf2fxO1pzhOc/ykaYOim6VbRYdt9T2FpxGVh3a4Lg8aSwqpMPOyekayV0HPb2nL79qS3fIuxygtwNoE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1786:b0:430:bf84:e94c with SMTP id
 e9e14a558f8ab-431eb67c444mr27414125ab.13.1761312422068; Fri, 24 Oct 2025
 06:27:02 -0700 (PDT)
Date: Fri, 24 Oct 2025 06:27:02 -0700
In-Reply-To: <20251024071524.sGwkk%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb7ea6.050a0220.346f24.00ec.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: slab-use-after-free Read in ocfs2_fault
From: syzbot <syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com
Tested-by: syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com

Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
console output: https://syzkaller.appspot.com/x/log.txt?x=10308be2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3fff88b67220f824
dashboard link: https://syzkaller.appspot.com/bug?extid=a49010a0e8fcdeea075f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=157a8c92580000

Note: testing is done by a robot and is best-effort only.

