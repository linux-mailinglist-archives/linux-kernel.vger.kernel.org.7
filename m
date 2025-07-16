Return-Path: <linux-kernel+bounces-732704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89E1B06AFC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7BC07A9F62
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD6414E2F2;
	Wed, 16 Jul 2025 01:11:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0983C219E8
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752628265; cv=none; b=Jf/S6/ax3Qk5OuZRgm5LpaVYb1ox0G2ES+cJFtpz/p3jabgajV9FECcbKuxsLK8mvh3ZYFhYlYe+cu71IoBxjlX5EbQpWjU1iGRSG/dFcSZoWC+DPutmqZEYOPoxIGVOrCuT2npR45Dru4qX2dUGp5LdtusgO83JKRPvxLRgu94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752628265; c=relaxed/simple;
	bh=p2w6e11vuFzDBVJIs0ta+heNrHqV77es3vq2iu7lbNM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=a6iSbJGwSbUXcnXTNOnduLBE7S/1I/S9eyWJjO+Cz8bPS2ElFKnyCcYAfx/IgxkK2PT2mRDPjZi+3oCh7tcfi6XKskijC2Om60l5HNANiGKrYieK715oAoyr7vTYDtQTH/cHb9GVrYfxijELZyAISaZSWrVtlab3wgd0j1MTUI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-869e9667f58so1359997339f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 18:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752628263; x=1753233063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHhBqwp0FvkYcppHVjGqPCuyNql3PpVDR1h1KBjfDJ0=;
        b=NWGhM2tuvD8pm9r3ddt7WyJfwarqlJcf74ss/BamcObGm3M+xk2a1jMItslmioevzu
         y4ZnAolFme+1orM0UwJbXpx4kKZ61f/t9hZ97LLQjqRPVViVIBdRVzFPe1aiPVTzZ23j
         k/RhbT2Pf699ae3qAoM3eIC2smTRnxfA5CHv3BM+aRg0Z+nCqhlgC78JbVTRB54Nyode
         n0lAOL+DrFM8vgm30YM6nGyb7FUBPB695HXqt2ZvDfFbIuUfnNMaZ4ML3pRfvmkywOIb
         O3p7rR8KZGooletR2/Ixyulx33jgQYgDo6BGjQhvJ/v05vmh03FKlQ0fcmyFU+nKrjZH
         pesg==
X-Forwarded-Encrypted: i=1; AJvYcCVmlUTzoRW8ybK1KI1WGkCF5U12xv2FvFIkcjiCCZOJRfCLkhV0qMbHgyyGLr0fNaplBWVopx/OQoTlCv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+8ZXdmdE8FiSauI6U5oeZcpXgpM1YfyqiV+z5ZtDMpPdLLl7q
	qFX5SS28clnCMdIwBvxu4tL5MAd4ZbbIFhKX3cdR7UEJLyhjnEaymy4nuQaLQPc/28c9GeYIQOg
	36QxpzheblZQXNgnGz2VscKd196diJ+V18/4yfxCQHg3oPjp9HdB8gjT0o10=
X-Google-Smtp-Source: AGHT+IGZx4nBjiQA+stbdz+a2sZdT271k8iWiIUGEPOL3tVGGBkXrfF5xJfhtAQ4wngm768/gT4IClucJUrAZR3t59aLBWFvT4E6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:65ce:b0:85b:3c49:8811 with SMTP id
 ca18e2360f4ac-879c2855447mr73433939f.4.1752628263179; Tue, 15 Jul 2025
 18:11:03 -0700 (PDT)
Date: Tue, 15 Jul 2025 18:11:03 -0700
In-Reply-To: <20250716004459.2148-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6876fc27.a70a0220.693ce.001b.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in tcp_prune_ofo_queue
From: syzbot <syzbot+9d2a6ef56c3805144bf0@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9d2a6ef56c3805144bf0@syzkaller.appspotmail.com
Tested-by: syzbot+9d2a6ef56c3805144bf0@syzkaller.appspotmail.com

Tested on:

commit:         c3886cca Merge branch 'net-hns3-use-seq_file-for-debug..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1221c382580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8235fb7e74dd7f6
dashboard link: https://syzkaller.appspot.com/bug?extid=9d2a6ef56c3805144bf0
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1798198c580000

Note: testing is done by a robot and is best-effort only.

