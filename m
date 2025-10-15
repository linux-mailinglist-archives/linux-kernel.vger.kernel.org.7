Return-Path: <linux-kernel+bounces-853779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 150D6BDC958
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2C518A67A0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76CD3009C8;
	Wed, 15 Oct 2025 05:15:14 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5352FF664
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760505313; cv=none; b=ueaT3bkgZ5N7frNa+xFST85bohEZtAjMVfvhmwW/chxX6WW90Ztb75DI7ocqmYXP8bHNfvt00mcBU2Fg1WiUYA3/lybQZBNH4ghhAAXi7gr/JPyOJCcZ0sMWLK9KAxw5w1Ucg4v53TPhOmEDgqqYy6GgECbq8nMSxFs3PT6hHSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760505313; c=relaxed/simple;
	bh=bpOptZxwtBLsuwhQhUObx0ayGRyT8Ow4gBAaDLEGUMc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BQJi7Rz9T4qrVjJ7FUqnIGdjAoP+9OUYqTIR3sWG348Rz/QXkWfUBcUxHKCOM2XGxjMFCjFjuLZF0BCWS5PyZsHQXrH5htSizCmMHjSfytDamdrFsYcdF9TadNylZe8q12yM3lo7dc//COZSy/XvClig5PFt3Ptvuh12RHX+fLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-927f4207211so1751379539f.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760505304; x=1761110104;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KcDokxHq+ry0kiEaB6ip5WGwa5ukwm71Hip72n257fU=;
        b=CUHwc5MBQ0/ynC7N3Dr5pymZW1w3xwZV7JcPid55JbIdIlSygeVqcSOUs+t8DFmGhJ
         hT2MzIe3ABlX6lLdEEM+9WSCAe5PdoLRnQfrkgszIjZwHIGDewDGVLVpKW+33g8ncH+X
         5T4M2AZ26cSoL+WGIapJpJxOsRLCVRYOBCmJpcNbCRDiyrbF36NfA3Aq1kBL+NCwZt+5
         cFJhTDPf7Kps4D/IiwGRqlw7bbmCiJrORrNyS54w1ZGlefsCtqP7ry4vNa3EmivOuIa1
         35VsAKeQ1gwE3d5sKXv38qu4ogPyGF8yXxpqnPkBa/vaEusuZTMHsNgA8JXXIg1L5IxW
         EdIg==
X-Forwarded-Encrypted: i=1; AJvYcCVRVuBzqoQuY/QalL/D5xhbl8t0bkZdXainuTAITpvfqWGWNRgsWy3St4qnqyZQzKo5tv7j1eVBaVnD8so=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD/z8mNpIHSIv9SAXqm0A4ZhFrSNyb3wdy82IXQMSYq+XZkja8
	kn+t/rqFIJ1hGyjfa3/j1xh/HPRWLPj2wfFBiS1cjSszR2tW/dDbZB+QoLIHunyIiJqQnnNeS6c
	oPf15LPzPsyy8WYymV3zNzW3J1xTHLAjmsfGrbasgqwzkWhP/v4NYbJbBUAc=
X-Google-Smtp-Source: AGHT+IHDFDJ/DGYMi/VBF/eUBMAfrneF7lTSVrMGo2E4wVjyyRjgz/e+QUN6kdMk5CnlwhtA/OFQ5fVfhosCy5P1E7pzCZYSxCdI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:481b:b0:42f:a60a:8538 with SMTP id
 e9e14a558f8ab-42fa60a8b0dmr174656055ab.16.1760505304523; Tue, 14 Oct 2025
 22:15:04 -0700 (PDT)
Date: Tue, 14 Oct 2025 22:15:04 -0700
In-Reply-To: <20251015044637.4721-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ef2dd8.050a0220.1186a4.00a6.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] UBSAN: array-index-out-of-bounds in ocfs2_block_group_fill
From: syzbot <syzbot+77026564530dbc29b854@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+77026564530dbc29b854@syzkaller.appspotmail.com
Tested-by: syzbot+77026564530dbc29b854@syzkaller.appspotmail.com

Tested on:

commit:         13863a59 Add linux-next specific files for 20251014
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11fc7b34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76790fe131481879
dashboard link: https://syzkaller.appspot.com/bug?extid=77026564530dbc29b854
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=167985e2580000

Note: testing is done by a robot and is best-effort only.

