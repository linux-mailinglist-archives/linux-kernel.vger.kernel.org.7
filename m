Return-Path: <linux-kernel+bounces-849493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B33BD042A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 16:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A96F3A5B15
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 14:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572812877CB;
	Sun, 12 Oct 2025 14:42:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE13279918
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760280125; cv=none; b=kiFb0emcxAjDqrvZksLHR/U9Jc0ahrwrqNsljDj2sxFV1cp1w6Jet07HCWclQsY9ZJPpijlL7K1JryeLJ0wkqfaIFLMVwZuajSqrjWg8lVWDFRUoHs9EEH9s28dV/B0XyPaKJegvH4K2m/lJ4G+KjRmwDiBmbWH+tyne3zQkWEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760280125; c=relaxed/simple;
	bh=5FKwHJS6myM1RrvPV4CJRH9CCCNggAcNjjLCeLWAxgY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=V5xZQtAfIQ/U3eSfkYSOSBReGgWz8PgtypvJ+P7R3KmgSvsErOOYnzE6+zl3RpT3vWlt2FhvWtURVJs3t4QKpznHNZj/aqxHU87mi7QPt5LiIX5ovb12fCtjpJE6YTSmNwjOByo3tu0m9efjlv02RBntLKEWI/vqKr611ZzlQdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-91b3cc5aa6aso2110139239f.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 07:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760280122; x=1760884922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHCAw8jL278fZzz1pADJfk5MuUXk9m7inbwe4Grfrmw=;
        b=UqhYimhJysxvkdkdfE9MwV9WqSvzzusa+skOqRoRGtvj0mfpHSRM5B6c6awTjGG0OT
         BHPqBH8xpkKA4YrKeMRdL9CpOs9xLAWMgxyeTbPA0Z8VtRyLNd2fZe9ULOu/7FZS8PTm
         1H24m2+d9H++SFY18jIhsgRy/TzojDQgUkJzxP5oLMzmrGXZxJv7jlK0j4yKvf+AIxut
         9ai6aM4Jo8fzNz/pFeUBTUHFhkFqiQ4q7FkvV6lw0Y76WbkR0hcnC5jEWJpiZtctZol3
         parXC1YuQT7UaFMko9ODtGh7cYSjeRzHDM0YI3o4OzH1pGSmEnHsUDd09jII1c9r28o7
         3Hkg==
X-Forwarded-Encrypted: i=1; AJvYcCXk4JKhWyogb6YFY2F2rlLEX1N7Jbh9VPX0rKEd258TVic39KTlIGafBwxWTMw7Tprk5tKbqktqBoitBSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP8awxJhf5zDs+A7Y+AwUHMyvpyEiobt5V/B3HTswVqAyQuo6C
	z7hla1jM/JH3xkV5rlrDH/YXbgk3120OxrVEEZvBShPfEZhKb4p71RCQpE262VfjW1YnxyggHhF
	AIjZxarzCayDpmFl6kcADLa+VcIxk8/9Ajc8Vf7IVdxM9OS38sCwPAqjJVsY=
X-Google-Smtp-Source: AGHT+IGegfJiu7krZthcS32gPhcEz3dB58Obw7t1kqbgjHOBccxyTpMxdezbLV8LJqSZbFShe1MpO23sfHjUay1H0vdXfHJpQKNd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4815:b0:8e0:cc1b:f680 with SMTP id
 ca18e2360f4ac-93bd1989d2amr2394244639f.13.1760280122757; Sun, 12 Oct 2025
 07:42:02 -0700 (PDT)
Date: Sun, 12 Oct 2025 07:42:02 -0700
In-Reply-To: <20251012143104.66463-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ebbe3a.050a0220.ac43.000c.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-out-of-bounds Write in __bpf_get_stackid
From: syzbot <syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com>
To: contact@arnaud-lcm.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git@github.com:ArnaudLcm/linux.git/bpf-slab-fix: failed to run ["git" "fetch" "--force" "ba1896969eb5f998e94092c59b6927ec7a6f3b5f" "bpf-slab-fix"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       git@github.com:ArnaudLcm/linux.git bpf-slab-fix
kernel config:  https://syzkaller.appspot.com/x/.config?x=412ee2f8b704a5e6
dashboard link: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
compiler:       

Note: no patches were applied.

