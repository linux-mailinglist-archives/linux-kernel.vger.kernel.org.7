Return-Path: <linux-kernel+bounces-874463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFC9C16643
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6DAD43556BB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EF1340A51;
	Tue, 28 Oct 2025 18:08:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84A7283C9E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674888; cv=none; b=NuV2jtIIjEutJ1hyVtDSuahhyNQVSCqKWFnMq0i5f/sSf/SZyCg1mcA8P4Rgt0hKxpqilSoSbA7M9YqE9o76Hk2QWykxj3rCRi4VkGG0ysD2cW6+Gu3i3HZepeficflH8jZh+NAgAY8KTihkh0+tJD3mR4i/3iz8n9OAZLAEKZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674888; c=relaxed/simple;
	bh=CPK76Rfwn0MvKdfH5cqVwLKkWMeXTBh3s1ts3/RoLKU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Axf04RLX/6ZuK3Rx38AtDtBpR/mj1gBt8K6YbfFqWEKlttFtoqlTlZZJiOWflrtFE71TD/EK2aorO4mku3VNv7x+o0KzlwSN01Oz3YPBU37NFsvIExUcDuwXuApo10Dka1oKWq+riQoQuk6cLA5w6ZoXQnVksm3eN11WRUPpEKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-432f8352633so5221035ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761674886; x=1762279686;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FD761kcKZYteL+v6ebkmghw+3kMMdDT42AMOz7DJjRM=;
        b=vq8+jzdY6euNESHgWF/K8BMnfUa8McZ+LEAf+UwHLviq+M+DKnheBiP3aRf1aJx1WY
         6cHIlkfmLTrGPB0/xW6WhVVP3W0kpIaOmPHVToZ86XwujVfdc9Vk4a6uIz/6d72OpzBc
         ndqvY7bsLc2gJ/iQ1cVkxtDuRZcdHKwC1iH+uTo7JbCG+7ooNOuQ/Ap0xmIMe1BC2VUt
         Pf3FFq7ZtS1smugy2m0GfYSvf0K9cyOfdLZf1ROSx63bJOV+F79dD8xGTFtewGYvR+9L
         QJxoGbnMadDmG/i1D0mrkEln88NvTu9tWANjvjuOLOSki3ObjfKjB6FyjCC8oBdBgPVI
         9ELw==
X-Forwarded-Encrypted: i=1; AJvYcCU9L7T0tIpgSGdY7GFD3J1d1qmlGF7FaKz7m2gJjpUIPnv+rPU4JN45vYUPIAbDJ+mz2mvzrUP6jHOCRcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3mQISVAfbswzOUj+wiQ1c0Vk8vVkNELx2A0HOOi9VVqRHzQP3
	DvmPTy9tn8KbZidDhHdVmGglJsDRW2DaeTunYK2V2UTG8usUCHuNFf/hdxNrBVgU9i6a4SRPxQl
	nstzdJG+L8acZ3UXNDdsmMMK1gQhxVGmcjQE3P8wqnEq0TYLNnsKo9h6VAl8=
X-Google-Smtp-Source: AGHT+IEBA3JT9TlH/wIL6huU3TgEM013iHLZPo4iU0F+Q7gpCPwg0NDs/3XlvS30UVkuRvIAktbba6Niysr37UKQYCO0HjoYoUTa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda3:0:b0:423:fcd6:5488 with SMTP id
 e9e14a558f8ab-432f8fad5a7mr2064185ab.12.1761674885708; Tue, 28 Oct 2025
 11:08:05 -0700 (PDT)
Date: Tue, 28 Oct 2025 11:08:05 -0700
In-Reply-To: <1241889656.2910669.1761672320057@kpc.webmail.kpnmail.nl>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69010685.050a0220.3344a1.03be.GAE@google.com>
Subject: Re: [syzbot] [jfs?] general protection fault in inode_set_ctime_current
From: syzbot <syzbot+cd7590567cc388f064f3@syzkaller.appspotmail.com>
To: jkoolstra@xs4all.nl, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+cd7590567cc388f064f3@syzkaller.appspotmail.com
Tested-by: syzbot+cd7590567cc388f064f3@syzkaller.appspotmail.com

Tested on:

commit:         fd575722 Merge tag 'sched_ext-for-6.18-rc3-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130c432f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=cd7590567cc388f064f3
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14b04704580000

Note: testing is done by a robot and is best-effort only.

