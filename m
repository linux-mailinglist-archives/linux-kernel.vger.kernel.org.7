Return-Path: <linux-kernel+bounces-847563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B89B0BCB322
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2C204E03D4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 23:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFB1288C2A;
	Thu,  9 Oct 2025 23:29:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C5D2882C5
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 23:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760052545; cv=none; b=WilFfM4zw8/L/A6yJ36BzNJ2f0F0tLIXiNzn9R0Elo1m0KmiQtDvHJX0uDbgKA/qvCrgc6hL7CyAhwNJwb+FwWkB6HPKytCrUrFv5KmFTgIhpA1kuJt/hZTAcmWX/epg0QDZM0T0FzUX1+c7xEI6jUeDs4IbiOPAnMvIj3GP0pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760052545; c=relaxed/simple;
	bh=MR3mDLO8psciWX7aEFIWGIcpwIll6YdhBIvr6LmW3fk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RV9HJwxqP+83y+McEwv3vU/TJRcdR8d7CcI8NK1y6d9QPsi1UqNn2hepz/948I0+neGWF82nQoYi/iM+DNEG5HL4XfqdkJDDZ2QJHhjk3Fnck82sb6Vp5d6/4dJrFE1nNRRrX+zAY+Zv/fusbugvfXMQI/gJuDGLyx7LMevE7k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-930db3a16c1so637109239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 16:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760052542; x=1760657342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hS+rszJgaizocP5WWuliZ9dJ4ZavwuTgx73YaLzfsos=;
        b=fMxrwQ06AthdKluMLvVnG+gCh8POJVDhSdYB/YpV4GULMkFNvP3fU3nAP/aaJBgzJY
         EA7vLYyvMfmOYWxwE0Y+rL2KHm0bpGi3kFKWwX8tfoIif6aB99Yzyzt8IJZkEiC3mQkJ
         dlzOqSQezXaFvVV2mDc6m1pIwOJOho/o315Uuq18GUvSirDyAM1VoOl+G+3GP8WGs2fH
         LUWP2ls9oxW3gmNR5nIRnrqklsK52fy96AE0ADefxVcVfeYfWwCrXD2LWJdgErkP0anK
         Q1GKNZPkvxVkb/bxSCydI44H73oBbHfQb5J3vJjXX5QvOvhtSJr8bP/NbgfLpEWipFnf
         B8pw==
X-Forwarded-Encrypted: i=1; AJvYcCVPoh06EG3gVOPiQFn7OkpG6Yo55EBjcK8ZRXg6NMSEgWDDngZDZaTaVdsZlU9X74Iswl8XC1O3YpLcLpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVOh0/TeHZaYm94va6E5cNGnXvu8XK7iTzrGm6BpfBU2Xv/kNX
	j3sALPk3Wka/AYGmGi3BKUREMTyEOAmg1zkONhkAXPryDRjy8v++Y55lzHipBzA+y/3mM1AKavX
	piJG6/TjLfO8//bUJ6RF9zUHCJ40K8LxTZaggWLGd/alWBY02+Nz4fbhdfiI=
X-Google-Smtp-Source: AGHT+IEQ+Vn2+E2g5j5qm1lu78xJUMAaWaxx4GoM0B+s9KwrDea9URSH2Lq8DiunLGRzb3uPqilmwyJygHxa4YEPRpLf0ZbtCDZY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6406:b0:93e:259b:9412 with SMTP id
 ca18e2360f4ac-93e259b9561mr246304039f.19.1760052542595; Thu, 09 Oct 2025
 16:29:02 -0700 (PDT)
Date: Thu, 09 Oct 2025 16:29:02 -0700
In-Reply-To: <20251009222836.1433789-1-listout@listout.xyz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e8453e.050a0220.91a22.000f.GAE@google.com>
Subject: Re: [syzbot] [bpf?] [net?] BUG: sleeping function called from invalid
 context in sock_map_delete_elem
From: syzbot <syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com>
To: ast@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	listout@listout.xyz, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Tested-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com

Tested on:

commit:         5472d60c Merge tag 'trace-v6.18-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=159b91e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b842a78bbee09b1
dashboard link: https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11f50dcd980000

Note: testing is done by a robot and is best-effort only.

