Return-Path: <linux-kernel+bounces-841103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33344BB6451
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 10:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDCC319C2E22
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 08:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2832765CF;
	Fri,  3 Oct 2025 08:57:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9F41A38F9
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759481827; cv=none; b=lt8RrktNZL5GvpMBIjHKRaYBuXYyTu7F9ZjcYABUi5hreJ5WVqZFOmlStrUaESojTcT6iGoHxcpNJp+oNrnFs6MfwKbvkLqFDyMm2xaMEGtCUqNHoDQ53TzcqKhBM8Vkaxboo821Y9mMO8cawnmunEdm1Fim6EcT8VYsX8tAay8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759481827; c=relaxed/simple;
	bh=FyoCpqNirqUhA3FAFwGYHQ7EB/a6vGQtWV6CnR3JkQk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VjUWTdLtRImZNnA/0i/ba3F2lT4ZzxDzTBB12XDQ5+xrFgbtRP/PzQHdRnmMIJLvvcw2IjDk0s6gwLf6AR84Wo0iXZL/J/QmYlgJG+QJvl/TYPK2PFonTdlKo/IgLX8iuSfTNX0pV3zVsnLZZPJFxPfVTxDcWZhDycq/c+3ONR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-91e1d4d0976so525266339f.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 01:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759481824; x=1760086624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pTFryVpRekqtf/vbsQjg3j4K9niH8Uf5RtoMB5MIwg0=;
        b=ost3P6mBdmBQqrqYcSbW7wMRv/c4ySrO7aVK05C5jBWohWjqEuqhdVKA6xJoHdg7SG
         d9u7ETR3fMah6qihqvu84y3u4Q7Px4836lSRvkRlfCLCxYk8B3msjMqJfIdtOS6WdzmB
         y3hrUImvHjAYod/u0JlPAkhSUluYee8u6lpiOCqTx7TueY5RWQtfEeiqSj1ooQ1jmL15
         nIywkNF0FkScuFdW9MOxBufDby1ALqNoCowEVVrvqFxCSMyqDvKNN0SEnrlvZw1RSnhv
         qCQm23I4FczUycqx80A/NobC7B8fwcWEVb46oEQftsJkjHKbRMmJHBXRQgFgnHQgwIgw
         ZRsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSR+xR2ILTfzkmsGKTzBAOG/0AvCNIwp2AxcCJjBe0cvn1eQEAdZ/EKhtqMbjwfz3kuqm5jw6mM/vA84Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUyZl25ZUWi0lG5Tr+rTeDFtuCN/1BZ22BBHCaQqPgTENnTNg4
	4kSZFPUgTGYVYCiCLdp6/Ai/vsbp6FlPSdbixrSBmQItD6wLwOHo3gHxvNOBTJ22xMQYEkL2cHG
	9kgEKj4WdOon1LDTPRMMwqnCMwe0va2yyo8f5QbqiSd1mU5BSeRdvaGoy1WY=
X-Google-Smtp-Source: AGHT+IE8rpyJ5Kc59KlPU1Epp+otWJ5wqtwPJvIMK8oOS6DvKWiypLjiGmteAyuLOtZUBq4SscVabQjtQkcx0ftb68BwoagdgiUk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6011:b0:87c:34e3:1790 with SMTP id
 ca18e2360f4ac-93b9695da22mr267477839f.1.1759481824032; Fri, 03 Oct 2025
 01:57:04 -0700 (PDT)
Date: Fri, 03 Oct 2025 01:57:04 -0700
In-Reply-To: <20251003083604.2556017-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df8fe0.050a0220.2c17c1.001f.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in ext4_search_dir
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Tested-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com

Tested on:

commit:         e406d57b Merge tag 'mm-nonmm-stable-2025-10-02-15-29' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1047c92f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84e81c4d0c0e900a
dashboard link: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=139576e2580000

Note: testing is done by a robot and is best-effort only.

