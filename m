Return-Path: <linux-kernel+bounces-894177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E3495C496BB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C37534EF500
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE9732E136;
	Mon, 10 Nov 2025 21:34:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CA632D0C4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762810445; cv=none; b=hr910nCEsz1WEHipl9yv5n2HWiPk93sQrV+ApTL3xwbf7O6wsNor7AuSExl93g0gJW//4o0YfhBHTLPEM5B4DhuvPul6nMWhpx1LGHiU/CdakV0wU2GXQAfowgOeuRgvmrj3Dv0aZTa/S1zAuNayIuVUQD1gIYt7zOxgAIo8MgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762810445; c=relaxed/simple;
	bh=pBNdpwY1NZ4sgEZqbeco8JgSOOBm1JVmlJ/r3fgn+/4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KrqbF0QCYNf/kfrkleuYfIOZqe60hvjWZrelu/8cGpmTAJk3mHClZRSw3qIyN/mQjDw8ZyUc/Pmau6edqw2xQWEiWnZ5vNJ9JIrOKepFfrmUx5epAQ+CC833ZJcliOXZ3aYSm1pK3qY+E0gxRlsbS/6zYweSRryt4OHR092cXVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43331ea8ed8so34008055ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762810442; x=1763415242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jycbR9egbhzWKosqksmUXDcQKX15OLyfwW5YBqURMws=;
        b=c89u3N47V9p3FqiHHMLnPe8u4kOpQ8op7f8R8YHej6kofXsO3aR06JuIAaLjf6buUR
         Jk7u5gG9aKRA+ik2sWN3jIdVXZep6nvKrOCFZlqKqAoOP+JBXSwe8n2uaIpCBptAp3Eu
         EZ2cDmDFK9CkbbzKaXw4tOy0lRPm2IguRNW8xW1tOx/8gn59wB+acuVYRpNsTXXL3uIy
         DvCKus0C8e9OfinRnXl8/UZgs0GZHdIhvCyWA68P6HsGez+OGDiIQanpqSymsemzX8WV
         1XSmQUcv4z2u7z+gLf6iD78SYi2DwwOOHlj9gIx2arcke7FhaxeRnvMp8Bp+N+oUkPZn
         5/Ew==
X-Gm-Message-State: AOJu0YzprAE8uG6F1HjHUV517DZ8v53fqqXX6hhs1JTWJLdhzK6XFexx
	ewERU/Y4m5ed3AxUC0Eh6Fd3iYnduDPkw5fcTCLDongfVhyFC9qeJ9LVZWys+kTOPDFndpChMDL
	+MIqGGu2t3Km2QgutiVggN7NuQCHtN1KZ6eUcGN/1NPDzjRIKSfww9bgW/Ts=
X-Google-Smtp-Source: AGHT+IGrsuhFyniV3he30FSIzmAB2FYruMK0un966Yk5HYfic1IQucUZrcwMIfk3InaMjPYIkUv3FOYrfJGkJmPS16Z+0/mOXSCH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e91:b0:433:7a5f:9437 with SMTP id
 e9e14a558f8ab-4337a5f94bemr80537235ab.1.1762810442577; Mon, 10 Nov 2025
 13:34:02 -0800 (PST)
Date: Mon, 10 Nov 2025 13:34:02 -0800
In-Reply-To: <iattottzq4koautrgwq74vaxrohcqpfcxarygoyroaimoorggg@g6lxrp34lajg>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69125a4a.a70a0220.22f260.010c.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: stack-out-of-bounds Write in __bpf_get_stack
From: syzbot <syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, listout@listout.xyz, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
Tested-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com

Tested on:

commit:         f8c67d85 bpf: Use kmalloc_nolock() in range tree
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17828c12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e46b8a1c645465a9
dashboard link: https://syzkaller.appspot.com/bug?extid=d1b7fa1092def3628bd7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10616412580000

Note: testing is done by a robot and is best-effort only.

