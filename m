Return-Path: <linux-kernel+bounces-870367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1001C0A872
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 14:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D4E3A6F67
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09C6226D1D;
	Sun, 26 Oct 2025 13:13:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A3A1FC3
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761484384; cv=none; b=e1SIxupB7uuv+YC3dvQwf4BMU6/YO07ggYkihAxgqkjiTJfYfiPVk86naAh+XBmNPZVDYAIFBn3UpsU0X7riCKLiKYYM0k8njRBGA3s38zef0h8lBSYR+SrvFBN+YIXM6JBLToZz7ijsZ+BVMchIxxqFv/P8FdHC4cc75/82S7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761484384; c=relaxed/simple;
	bh=0PiqYaF7SNVM+qtSxPltaQqfEjZdxUtAiaOPvzwem9E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T0nzPOL/P1+rPq5emikR+9QJY7iegOwzECjQKcyjyg8cBKpuygwX4pwN+7h6oJ4mglIahP2S2qPrsni/FADW06gKxPeTDlCj9bPK1sTam0xlaQ4fQL7SaItxrlkK1rCpf24dAyWMDaczBrpIYrDKv0WauhBux+4SDNxWdl19gOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-94389ae547cso102977639f.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 06:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761484382; x=1762089182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zXREvUJxd4Ck4+LNIQhFBKrJT8jvN/aT5g/VIZdfXQ4=;
        b=R46LPcNGmVxIh/afL4PhWdhpiFXJUe4hE8dWk0HN8Ng6y4H4iROq04+9xsLWc6qhcD
         vMIg8qUBGu9RPuX5CfOIcKrRwIKCKvXVPaBXAiqIc8h1ywkktsHKXpT6LcYJqBYs3x2I
         Pv7vfr0u3Vbn+YyTvSzAp95TDeTmfua0tojw8bAP/QcZpeyky9hkWSRGQ+/ONmIITOG/
         m1ZNffxHiISfwVv7grupcCYu2qM78T4e4UFEwKa6Qrb8/Uk+j8nC7quQS0pM++zOUq/L
         OL46AlXROxLNL1a57SZOZT5jIDFjwLtCBaQ22ceUerE4w5NYGouFDGroKxh6ukFFRMPK
         1eGw==
X-Forwarded-Encrypted: i=1; AJvYcCVOGJm+TMeWjYSHpGJvsxdSttYmPDSxTX8RBRh8epkdYlzKMxN/ximWGfxxYlRgmZ2DuMFpH2/lW0d7fLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW7XKSyzlqgK0ScgpMkYtaCmN62L/+wPvoufF+b9ckzvACfSRn
	cJ0pStFBw9+UQR1p+Apvy1oy8CwxWcVaTJMJHMaMLzPmYuOB2zsQfTYEWX7cUXnGJxFw5cUP3K9
	ZiycudyD2Zj+UY1EjTj8Sknmfse+HS4ed7RcfH5gQ3yOReviHR7KntNGfS+E=
X-Google-Smtp-Source: AGHT+IFzTunlj+VF+YzVGGj8/jRIfqa89jSrftb97YshXyyQG1y9FTq0lPBt4TE5h3dBEMahKpVV03pF5IFgXdpHCO9eAJ2Oi4Hy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156c:b0:430:b994:3bd1 with SMTP id
 e9e14a558f8ab-430c52460ecmr496906635ab.1.1761484382189; Sun, 26 Oct 2025
 06:13:02 -0700 (PDT)
Date: Sun, 26 Oct 2025 06:13:02 -0700
In-Reply-To: <20251026125108.11538-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fe1e5e.050a0220.32483.000c.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] divide error in ocfs2_block_group_fill (3)
From: syzbot <syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com
Tested-by: syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com

Tested on:

commit:         72761a7e Merge tag 'driver-core-6.18-rc3' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13fa5614580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25811b07889c90db
dashboard link: https://syzkaller.appspot.com/bug?extid=fd8af97c7227fe605d95
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17d82c92580000

Note: testing is done by a robot and is best-effort only.

