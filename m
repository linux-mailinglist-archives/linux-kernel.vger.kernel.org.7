Return-Path: <linux-kernel+bounces-889675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4190FC3E378
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 03:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA96D188B8B5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 02:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8092E8B62;
	Fri,  7 Nov 2025 02:11:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757C7299A8A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 02:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762481464; cv=none; b=pkscpz3LpMpLZNeslwDuLlVB+d7bOrJU+zgIzhy7JK5H1E1+QukzY/JbU062DtgkvCBOCRfI87iacNlPL+gHQhIYieaz+RPNuzoZJajNpdFZKneK42MN9UBWJsMuB+PQtEqWRxsUjzzClccMyOB2jlyH/b4zj01tmAhg5+x2xOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762481464; c=relaxed/simple;
	bh=0BFMlGiWoh3QyhnS4Dt+cKa9+NznTVPuXomrd9QfrSY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oOZ0wNUT4kvBnnP6HTE66lPxaatbg8p8FI/4gmHbgfIUk4lcoEHtbWFspkUZyZrhyVIKk4/B4z574YdiLdJRzXVW89iL8fiZ2+GlDPXdSxPKC938m3HtLNb6wzxSe7RMgNJ87tFKnwnrWmrgtbigUh0Qe6maHune9iiwV/4PNn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4334c9649d2so3378335ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 18:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762481462; x=1763086262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPLQI1ZFUweZp6JYNSCOE2sI4gLIkz+jc/DqHeHlzrQ=;
        b=NMOi8xoh2LB9NOc3dD0td2Rxkf3N98dmge5CYQ3WmaT11SFFT1t8yLjetqPhVRoaCu
         BNC512SVoLvtQs/elg5iCEtE/1QwZ3fCsZf8nZXTKOCSUOoJaMXmANX8xf6q1p91wRQ7
         xKkNOyuExlv9KYGpuMgCMkF75TefWabMWJHpaZaEb18yJ7JuXIvMcO7hQTqPqMHGQ6B3
         aelkf1rMDgrlBdyDQCEOANdjHgdFLhAcZEPYyGYAhjf19YuR8spnqt8cAd7FNkbqaQnf
         BbnVou+gKC/d4+BdPTl2O+NZGbTo/TxXbYHwHl3iRGFt9W08FtnU8YeAEclLb/bbgkJQ
         f1BA==
X-Forwarded-Encrypted: i=1; AJvYcCXbvRjeFZhok0vWiFjaHMIvdL/8x12dgFKB1Ag6CAznvqGR8dUgrncJq2zbEyIMKm85RlHjdWuVFHYI9Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YybBu3NojbRFo1KncidlGlTxxyejTCQTUcAKaySGkTLobnAPSNW
	I4PsKJaqzDoWJEAT9x4QouQXMIsCQFiaUcw+eoGf1P04EXSjnqj4/WbUxw7zxZonsoHM5/p/vKk
	FiklUegR/saPsKo+TWtA8iPsWXMmmMnDDFjJp3BKtvHGLxddqQBcwuAITzLo=
X-Google-Smtp-Source: AGHT+IF+w+hJfX8jXvlY4UKeCQXgcaWWKOeC1/0WyXIdfCGYWBOffj5pMQhcm06mnNzoZkRkjDPik3VH2wdkqhIYul5SyH0EM96q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160c:b0:433:4f43:231e with SMTP id
 e9e14a558f8ab-4335f3e1a4cmr24180625ab.4.1762481462642; Thu, 06 Nov 2025
 18:11:02 -0800 (PST)
Date: Thu, 06 Nov 2025 18:11:02 -0800
In-Reply-To: <20251107003518.8936-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690d5536.a70a0220.22f260.0016.GAE@google.com>
Subject: Re: [syzbot] [sctp?] BUG: corrupted list in sctp_destroy_sock
From: syzbot <syzbot+ba535cb417f106327741@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ba535cb417f106327741@syzkaller.appspotmail.com
Tested-by: syzbot+ba535cb417f106327741@syzkaller.appspotmail.com

Tested on:

commit:         25e63e55 netkit: Document fast vs slowpath members via..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10c92a58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c2e630e5d8a0109
dashboard link: https://syzkaller.appspot.com/bug?extid=ba535cb417f106327741
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a47812580000

Note: testing is done by a robot and is best-effort only.

