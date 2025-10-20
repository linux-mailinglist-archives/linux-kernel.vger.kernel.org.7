Return-Path: <linux-kernel+bounces-861326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E708DBF26E9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2C434E1CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BDE24DD13;
	Mon, 20 Oct 2025 16:30:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CBD2882C5
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977804; cv=none; b=lxWLs6C02d7DhbTLx6jYxHxndE06IBdw18nFrFq5544mW8ryvdUSzAhSCeN0VAImGFyXrD3a6lobzUrfrBtl+aCrsMsIDHeX9xVLmTeAlH6VkR0/h2tcC1C+71nrDqoBL37eBNYvuB3VC0XOaZFmjyEZkHIeXawGJScDFvjZvpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977804; c=relaxed/simple;
	bh=2ST/YmL/cQgqdwR48nk5UhB6HmSP1oC68Y8E0N2o+Og=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IOdP1y9hwli0ogEMco0j2U1XtyynJhqZOz8zjq9CYUiqbmSZPi9pMSAUdhvYxnCr+uUpt5SNryIu+/x3oEQl7pNtbB2q93P1Iw3D4LTcgGb1MR5KYaQGoXxyUX5yIcer4JfvZ0xiv2trLl6pFV8Hzw+V1lQrRoRhQVA3kJJ80EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430c3232caeso43831325ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760977802; x=1761582602;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dpqHNw/a6UNU2sMFqnVzN8SMlViJCslcUSHtvSGJ0VM=;
        b=Q2X+8ht/UMIxto+0GWlgGT2XIjuN2tq3EzrRWo2Y+FSjVQyyKSoEjw3igP7obFxreK
         wSKejUK05HOazTc3MH1ylXKZhnHqIMmF0e7s6bVksOCFKTZbNe7OQIQHqmi81Wp0fbgk
         MOVfl9gB61o1YhsZK4cQRgIr7I36Xnq7rBb/OukQVneEPZNrkXdomNuFt4RZ1I4jdEgu
         cI++SiX33/BtKS4n12AR7GFHSeA2BaGM+xYOhaFuJx8Byo4wPFDnsPqq2/1RgMdS10ZM
         dtxqE67AQjPLwqvyuHS+3EJbhMW/ltGJeCKBTT+3GWbFokodfMFUeKriT5N5MvvnXrFw
         rcrw==
X-Gm-Message-State: AOJu0YygxlS+k8afDSXemyXsHdEj/pyTOeaumPeG0GK1stA0KRiDKU85
	NEVZKOwgCrTpSJ30/a7c4fnTU6Hjjd9MsKyX0rPRmTeRhZev/4+de3GysV5f8YylCnlpeX7zcw6
	vtjguqUrYdr8D17+Rl7MQQqmXs0e5x43FtBSTo3MbY7mW2PmQajY2DjoxCHo=
X-Google-Smtp-Source: AGHT+IFKYp+g4XawnGanKc2Rsc4j3sPEVrJRJ942wbE1PzboCbv9eWqJL4zLMRXAACeRaQdGOATsgW/v1hey0amQn8qJvM0U0fj3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c8:b0:430:a0f7:a5b1 with SMTP id
 e9e14a558f8ab-430c527eb4emr185989665ab.24.1760977802009; Mon, 20 Oct 2025
 09:30:02 -0700 (PDT)
Date: Mon, 20 Oct 2025 09:30:01 -0700
In-Reply-To: <7b1f58cb-d42f-4357-816b-22d65792f041@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f66389.050a0220.1be48.000e.GAE@google.com>
Subject: Re: [syzbot] [ext4?] [ocfs2?] possible deadlock in dqget
From: syzbot <syzbot+6e493c165d26d6fcbf72@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6e493c165d26d6fcbf72@syzkaller.appspotmail.com
Tested-by: syzbot+6e493c165d26d6fcbf72@syzkaller.appspotmail.com

Tested on:

commit:         211ddde0 Linux 6.18-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154adde2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=568e69ca0c2fa75
dashboard link: https://syzkaller.appspot.com/bug?extid=6e493c165d26d6fcbf72
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b4dde2580000

Note: testing is done by a robot and is best-effort only.

