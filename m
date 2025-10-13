Return-Path: <linux-kernel+bounces-851087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A25BD578C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AFD14E4E09
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE19B2E1EE0;
	Mon, 13 Oct 2025 17:22:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F197E2BE646
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760376124; cv=none; b=uXWdM+vC/4BRHRlKIzPwT61B9oHLchev7Y9lzB0uKFcEN18MV9f7RoDwwsPLrS138970gS0N/xsGqGBlxG42KvRSzADR/hR5cS6WrWkxDUeG4GiDrM7ZfQbevtB18Jf9XRtbHf6S7GYgdOdcuZlVgX3Bezj6+xH0xRyKaMPOocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760376124; c=relaxed/simple;
	bh=nsGyivXBri6OSLxxjOWh4WGz6wp5udKFYCtPrJccLx0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WSojGfOORBOieRkOQGPdypyLdDkm4o/NaehR55YYUc95v3TdIE28gEDV/T8iqKBu/ZateXUvC4O+z/O8HZKwK9wTQAAkJK0JShKlGpdRMPCXqdjGLE1VlVqaQlKrdpL0YuWb5QeJrkssVKvNsDaqACQaPC6/ggQiEnGavNq+W/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-9201572ebfbso2187598039f.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760376122; x=1760980922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IcTIroVdj0btffajsp6gtGNFiSwIhJCy9rGpAqsEW7U=;
        b=rrA73dZ8OT+b+NOIxYoCPLSiqi0KyIefK9cHcitweM6DTbIWlQ1YOcuVAj8A4f7WJv
         +OJMCO8yLGNn2AlwYbx01eWR7yMVKGT4GgAXvEvaMiZYH8R47k+qdVUsfwiSKXUSs4+R
         UrfcLLxZaXgIP/1zB5S2OwJ068HJM7ABQ58D3ZHrXD0pfPE9hUxbAaz80lIEvPvT+XIi
         rtUAFlEGmoZRFuIvtpdc98oelyp8BvFnAjpRdnUVJ3Ul5qR/X8v2oUU4x8uYbN4OJtUy
         SLLzB7JunQOxx/BHHjfdVCd9qvmBh2zyhtMq3OlXOEWXU3Mqhr0jalPXXNNd/jycYNVj
         61ew==
X-Forwarded-Encrypted: i=1; AJvYcCU3wMtLiESBoQL24zouRi9O529ehrl6RSDLH8p/GVQanbyb56mAZCrX6IN50vEKd79dvTt3jxNWuul5TmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrfGi3uCviQEOeSK8rL6Dhj4wZqO0zueslWCqzFjS+dzFrHnZJ
	P7qtNRm9vdKvqbdQZceE3eR3vynoWhADqN3r9cYbUrIZcFeth6MTE9XnIh5NXSqnY/DVjO8m5Ai
	YtTNFJOjqbnHtPlklFOCEtZ/sZI3lr2EJ+gsYNBnkD/fOi4XhGoL0oTgxAos=
X-Google-Smtp-Source: AGHT+IEZjRcbR2oTuA8IpjN+806A9p5IOVdRGzGHPrW6anLmhQbTzqyftrRkrZNyyXGONz8Vv4mpSMargfmhISDHou3gvOKCyfV4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:a01a:b0:893:d33f:e5ad with SMTP id
 ca18e2360f4ac-93bd198c5d7mr2225638539f.18.1760376122164; Mon, 13 Oct 2025
 10:22:02 -0700 (PDT)
Date: Mon, 13 Oct 2025 10:22:02 -0700
In-Reply-To: <0000000000004d1b5605e3573f8e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ed353a.050a0220.ac43.003c.GAE@google.com>
Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in dummy_timer (4)
From: syzbot <syzbot+879882be5b42e60d4d98@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, fweisbec@gmail.com, 
	hdanton@sina.com, hpa@zytor.com, hverkuil+cisco@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	mingo@kernel.org, mingo@redhat.com, pbonzini@redhat.com, 
	penguin-kernel@I-love.SAKURA.ne.jp, penguin-kernel@i-love.sakura.ne.jp, 
	sean@mess.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit eecd203ada43a4693ce6fdd3a58ae10c7819252c
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Thu Jul 17 14:21:55 2025 +0000

    media: imon: make send_packet() more robust

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15729dcd980000
start commit:   200e340f2196 Merge tag 'pull-work.dcache' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2886ebe3c7b3459
dashboard link: https://syzkaller.appspot.com/bug?extid=879882be5b42e60d4d98
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156ff9f2080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178a89f2080000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: media: imon: make send_packet() more robust

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

