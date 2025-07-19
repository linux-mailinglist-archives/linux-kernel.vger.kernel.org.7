Return-Path: <linux-kernel+bounces-737478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC6AB0AD39
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 03:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE532582B76
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 01:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EB186342;
	Sat, 19 Jul 2025 01:19:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E748AD23
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 01:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752887944; cv=none; b=bYAtc4kSMTasHNpDZfjU/brtbY7Bbr/rHuTCSqaDOGiA894yKEmqtv91hE8WScuOfWjHJMX2abwVr29KkE7u0gamsxasCkcEC9C5Tp/C9/qMnV077hJM1TqLhfgtrxmbMtZ6XsV1ToxpsGI3xDWwK9WNnP/xRHmTJ6viF/1IxmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752887944; c=relaxed/simple;
	bh=aJCF0ddyOXuF5gjXcwXOGYNzipJTNJaKbHCa4KbjIRQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qhkyDnXUP6NzevbItddrLTqfXl3KUgVjysb/Bdapv72mtwcsnH3UR3IiMOJ757589BTSFrSj1XX70D8x/KaSBQg1dSjpU2uRiuOFlJbU3KHB0LGX1Sw96CbVEC+oZ9kqN3CR90bLTRCAukhrOPB5wvFMrWV5dtEOnTvrv5EFeQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-87c0e531fc4so272614539f.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752887942; x=1753492742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZl0/D780um6dbWcTsTxWLS1FuHbnhc7kOw2oVZ1k5Y=;
        b=m+e/1ynVHAhO0K7SLpumK8j9wi0DeOw2QoKYCTOJd2BEm1lYHSiXRa1FPtl8/xvOR0
         eqn0xSAPPJM2Bjtz4ze1LJTt3TLDlPjGUB6npBQpDL/KcB2DAv5g7ME8JScJF5f/dkOL
         8zUIrjuSKvRL/gCtggJyvfoqpnHcUKAcmIbpzXvxJ4zuUmkDARF9gHhCQaiE+gIvUu9g
         sgpGOdtl9vK2S/ktv6uTfRLlWvZtwB24BRRniUkYx2JZ55JfrAXVvuq5Ly9gjdOW+UjT
         D9Fcsud9ligcu7WCjrHeCLS+4FsiX5mEUge3WiY6zqNF0Nk+SJSIiCmSeA4lupiNMQSH
         tW5g==
X-Forwarded-Encrypted: i=1; AJvYcCUjcc2mgahK0V1gk6SdJDMKXwHkCxF+gMMK2/kAYlLG6L4Iwn3vFaa09krwU7fjZSgenXdSZHHYMPubPuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/oD374y7DY3HavIJQQ2ywFzO98CGhxW3MQubKyuGDJFh6j6UA
	ImJ6wDxDx1LFBozX83ilmkXY843j+57fmInujHkvJyf57m0coTCYBmOXolw5Hc2lJi6UMW5eVoD
	X6AznmdQWAXc/uyP+8/1acheh4bMqtmkIdaQz9nTKL3j4wQtuWOxKHedfHt8=
X-Google-Smtp-Source: AGHT+IEz7v0ZnTkAXOeS5QfX2R8CDG5BXTGoxHEoQOMpKNawU5nmdncLP7FeZtqmvJDLpReKxyl046ognEV3rW/tnq6sb2EKrx2E
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4c0c:b0:879:c9db:cbf0 with SMTP id
 ca18e2360f4ac-879c9dbcd6emr1226466939f.2.1752887942234; Fri, 18 Jul 2025
 18:19:02 -0700 (PDT)
Date: Fri, 18 Jul 2025 18:19:02 -0700
In-Reply-To: <8b62af1c-64f0-4742-a96b-34d23635c089n@googlegroups.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687af286.a00a0220.3af5df.0033.GAE@google.com>
Subject: Re: [syzbot] [fs?] KASAN: use-after-free Read in hpfs_get_ea
From: syzbot <syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com>
To: kapoorarnav43@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/hpfs/ea.c
Hunk #1 succeeded at 135 with fuzz 1.
patch: **** malformed patch at line 61: + }




Tested on:

commit:         414aaef1 Merge tag 'riscv-for-linus-6.16-rc7' of git:/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f09d04131ef56b22
dashboard link: https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1165038c580000


