Return-Path: <linux-kernel+bounces-837584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E2BBACABE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3AF63ABE27
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28812F3C3D;
	Tue, 30 Sep 2025 11:22:09 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED2E23D7EC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759231329; cv=none; b=fgi74hnibdrUkQgYjGu0z4DecrUYlkl8OiuX8Kiy2PKaIz9jTsStV9zDO+gnl70gZxhpTKHrEw9Cf804qvzFTp5Q1KxAp79RVQegfJ2fc4K0MwC9ePosL0Hkuvzn/WSObe4HVUDQ4O3YXtn6ct52n+5hXFqhw6fVvPkX7cvwldk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759231329; c=relaxed/simple;
	bh=aBKxEKYjVR+gyV0yoce485bpHJaYvlBdRskqv6A/Va8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fVdXoVUFU7wmzxybG+53+KZj7m0HYJmNfQ+8QPWu13jiz9gM2Et0V6QuhYsU2LTf5NQqov5XE1bsm/pAbDy//DvulWByKi8xCtTD1UFmU5ti1V8bPUYvhl8kT0tMWKMLJue6wqs4LZIqZv1Wkgq3a0XJSVjSBcOUoErKZXqnot8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4257567fb7cso62265195ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 04:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759231325; x=1759836125;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hL+NTM/ltwmoLaP9DQRIxbQ6zZBN48xCWqT6c+vkOq4=;
        b=HfpNy6WgbNJN0DaG8tBr90cgJ8/MSzG6JCTYZaxBbGUNg292wETtQXndmeIUMn6Rt5
         hE1y7eBDOY7kMtWw6Gz3xKfVhjS/F0B0N4/QSPpTZK8D5NK6DHoPVq8jtdgP3YDTIbCy
         6Wr9AJ3s1y+u3meJvb4nET7PHR+3lhrgpzOM9J5/KLlD147pVGk9X7NG9KdXUHN3KI9j
         V8VBa+VpceVPIQixlaReiOSFyBg8jNCBvPYcq1y15W50eCeul1DBMlbRs0lPJFXBNsj3
         f4COf624ttfHxspBsz4KuUlQyI8JgDq6x3ZxDrA7hYsTZhBwyP39KYi/9JKeSVkX6Ph1
         cEuA==
X-Forwarded-Encrypted: i=1; AJvYcCXbZe45WA0AZtr2tzzXT8eUa+ZYFcikwf4Mq0RGHEsRT0CSsDsF486uDgDrDV8kqZJ96FMvja9Puklvd0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytbdpbv8lYXNHgDFGdRBMDZ6QbMFZio4Nu9/HTNyFMVvyHxdCx
	YtV0fq3AyKu1I/RbYUBrJLdF6NhB/qtMSORlRA75yaNVVdFgJ5GvtwABU98V0KLf8vEX8gjFq3m
	RzzfGbabEaQO3/j54wSTnI/eDU/nBqCjiswicw1+Kw/5A9W2VI8x3n8eRKBQ=
X-Google-Smtp-Source: AGHT+IF4V1wgWBNohhBNuDDTBSPvIVbuPcL58oAar221zouXR4SWCALMHbg0xEkKwg1n9NO6/yGI3j5EeC/WKvzVwc0qdsi1DYx2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18ce:b0:426:9b42:24c6 with SMTP id
 e9e14a558f8ab-4269b422717mr293094575ab.10.1759231325390; Tue, 30 Sep 2025
 04:22:05 -0700 (PDT)
Date: Tue, 30 Sep 2025 04:22:05 -0700
In-Reply-To: <20250930104454.313735-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dbbd5d.a70a0220.10c4b.0155.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_es_cache_extent (3)
From: syzbot <syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com
Tested-by: syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com

Tested on:

commit:         30d4efb2 Merge tag 'for-linus-6.18-rc1-tag' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=155b05cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=607d55e4510cba63
dashboard link: https://syzkaller.appspot.com/bug?extid=038b7bf43423e132b308
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14bbf27c580000

Note: testing is done by a robot and is best-effort only.

