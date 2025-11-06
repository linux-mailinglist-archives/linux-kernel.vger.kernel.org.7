Return-Path: <linux-kernel+bounces-889268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9E7C3D1E9
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 19:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044EB188D10D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 18:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2743B34F481;
	Thu,  6 Nov 2025 18:58:00 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CC922A817
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762455479; cv=none; b=H2L0NviwB/Ae9m6+yl97k74N0Yn2cjW1F88s3xczr8EYeCuHpT1Y/HTMlqADdQdcI3D+4c2YzMB39ndH1JUY0BCHgC7l2+vdl241rqtb/cIC4v99sGLb1rwLucIRez+hi87dEwzmGVfWIfWPP9AXhSM/x3IyfuIApX395FmBukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762455479; c=relaxed/simple;
	bh=Ieq1ck0qvm3ZmRsGLSRgTwo5ZTOdLuFi0WGVB/YIMwQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hX9w5vc4uKSr8Rom9pUuJmhgAXJim4WR8W7uqveBywidKuVLbt/kbK0W3gnFHUeESGedNv7jr9EBOGUjzH7UHmrJOpXEAbXf8uTJ/wMRtRr/ftFysb/rh73KV4x7lEbGWPyxDMx/6Eqh5xPnpFx3ny3v+ldU8IZwubthcpAZ/kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9486e1db3d9so21640039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 10:57:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762455477; x=1763060277;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OV9FnEIMn3tAb3e2Fleb7GR+066UTYm6BepX40jlcc8=;
        b=aJOCNlwnNNvzV4I9xvNEEwxS8osLlSbviagvOnE1/KBrJSMMIKdH0B4y8a8pxbk2iB
         8ID84hrUql88AoqQ+iIdCxiMeCXW6a4BDrDcI1GPq0viJ7x13+CYPR6NSB/i+M1My8y3
         lzYyA3HOTkrBizI8/4mnZHeIw8EiX4R9FYisw5b9KSw4uBqxkd0MlwIyCyhgVnDfSalu
         5USHdlh6eUuTQsQNLJtZ/cCdNktgPlDcMgFIwY7JMuyEY3XH/9bX45E+O6uSEwyVJ/XP
         cSAFPdUH2xeBD+lMKox1X9Lv9z2yD3nb5sYNxr1MDNBb5L8mClWD5ijMxw92J46+7H7e
         Qw6Q==
X-Gm-Message-State: AOJu0YzS4XgauubCRcV2VAJ76TBtZSSQyF6KxNxfyMl8tHmdNb7fY6Sx
	CDFxiqSx2UL0ftUGQo/3m/+px1vbM/Lv4tYvqLVwt9Q7MMMvPQPaSc0jIMujDD7vQz2PTJJLnEW
	7WmnmWLxar4+DT/qxDl5oeU46kA8ddhxC1NzMGISOCEWmZg8eI+2ASC85LIs=
X-Google-Smtp-Source: AGHT+IHYvm+IA9B8uJb2848rdlYpmmi9HgguAl02D2vOmcAOoAj1r+1nGXvKspg549CZw7vc0LjMxjR3W+bATIf4lUb8xLsFNvuA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3420:b0:941:a80:7ae1 with SMTP id
 ca18e2360f4ac-94889087ce3mr74445939f.14.1762455477465; Thu, 06 Nov 2025
 10:57:57 -0800 (PST)
Date: Thu, 06 Nov 2025 10:57:57 -0800
In-Reply-To: <68232e7b.050a0220.f2294.09f6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690cefb5.a70a0220.22f260.0004.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
Author: yanjun.zhu@linux.dev

#syz test: https://github.com/zhuyj/linux.git 
v6.17_fix_gid_table_release_one

