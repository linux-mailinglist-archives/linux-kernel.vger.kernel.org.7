Return-Path: <linux-kernel+bounces-738244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF478B0B649
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 15:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351FD3BBF94
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 13:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70B61E0DD8;
	Sun, 20 Jul 2025 13:49:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBF778F24
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753019344; cv=none; b=i77V90qv5/Ocuq/l8NM0TNztYdLzFkP6KsMVnxuZR3JSBmTeokdYaWmEkhuujq5e5ZQexj/pZl7kaLWjL4MMJiWkx2zjiJnXEIrvqMy03E6ZdFDn4D96K+hdH2DpJByDJQ4RQuJ8kRrg5r/MPs5QQMLFeDF99gF3xa6+VG8xHsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753019344; c=relaxed/simple;
	bh=nKWpe+t71kQI8k8u7fq/7sEJ96tVgkJ5Ot/GCUuGCls=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f4dg5VdecUWFgRv8dp/JIuPP3o3qn/A/daeYMC9Yl1Ljr8Rl/vpxZ+0a0Uh44uF3EImbusYQWIjiixGF7mieghfn/sZ0b/pRlxETIPxrdqRStFmm+bazF6MfTdIPh01HXBwlAiqYBPfn+HAvtOI7taFfQ5NE+OKY0dvMt+osOf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86d126265baso377171239f.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 06:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753019342; x=1753624142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=744sKiwNzIm+qUXwSXTODPm7IkNbokG3A4uv1WCKTmE=;
        b=H3ExbvdCUvICjLl4ALnhp5TMr9GvTFgg3n78wsAPlayCeLandqMU/6RdsgdD4mjEsT
         2OaBp84dOVbJ94jh5aDupW050aqpUa7xf0D9dPCrSD9gisCcrrd1+UCsJLBw9YJtH0B1
         VQKmwYtEH5MnDZocyJWBf3IoGnC8koP23YWT3B8VkQliIQIrLumUyeWzBpWCsu7MHXyx
         D6cKOI4eK049M9EudsceYQd6ZrkjVp2Yz9Ej3ZsNLY4yNyHtS8QQ4kwCxiH0gh+cffc6
         8yG2pHDhE8samlLXI6jOH6OkUOVlbUveS1o5IJoM0fJrlkS/tbbVBZwlvxC3Tu5vRqWW
         B0gQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2md9xJC0s+lBi7pHuXV3iri+xZ9Q0iiSs/nIbsvhM8VD0dXSVyU+XEAmoQqzknxvHG0ZLlvHx8CSB2gc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8GcRuP7dH/zDD4ZoIXd/ZCTtdP45YO8m2ShLtLKhdXpYj5PiA
	EdC53E+z0qP4m/0SeB4lsaEE78SHizachgGGMW8JkhoRw6JSPAtyKVhV6t+7U1REe7OKIa/sdGT
	wAE8QcPfjRe7KrS0gmzo5qf1rh51dC43JPegB3f0Rwc2ZC9KgIbTEu4g52wk=
X-Google-Smtp-Source: AGHT+IGNRoIL3PgNk+2O0/TaNLz6Khz6fJC/BY8Zcdtb5oxpQJ64LIld/jmLGBzh6f4WnshldimWouTmynP/Z33DrDpR7tUZTJLE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:a00a:b0:87c:3129:f70d with SMTP id
 ca18e2360f4ac-87c3129fdb7mr263229939f.12.1753019342149; Sun, 20 Jul 2025
 06:49:02 -0700 (PDT)
Date: Sun, 20 Jul 2025 06:49:02 -0700
In-Reply-To: <20250720123426.132651-1-apokusinski01@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687cf3ce.a70a0220.693ce.00c4.GAE@google.com>
Subject: Re: [syzbot] [fs?] KASAN: use-after-free Read in hpfs_get_ea
From: syzbot <syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com>
To: apokusinski01@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
Tested-by: syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com

Tested on:

commit:         f4a40a42 Merge tag 'efi-fixes-for-v6.16-2' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12314b82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f09d04131ef56b22
dashboard link: https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17c0538c580000

Note: testing is done by a robot and is best-effort only.

