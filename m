Return-Path: <linux-kernel+bounces-862701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F326BBF5F01
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DED2501A77
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0AD2ED86F;
	Tue, 21 Oct 2025 11:01:10 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298CB23E340
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044469; cv=none; b=qi54V640/A6Rpw19ZR0AobbmRGXAhVFFfck9UXOVH4brLBR7RXBszNJIkVPqgga2DL+zuouINx+ImVYINo2SCva97t2t0Hg9JMJNGQP3w5r/XNv9meM1TZRjStRdrAY9mTdF/EvGXkzHhapBfrQmQdfmewUXkxwujyXf7Dm3mWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044469; c=relaxed/simple;
	bh=boaW3BsIFYLo4ZNWQVNEMFXOlgPefgDpFSHcFzSNYtQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Oaxm+oUo+jd5z1Hc7N2/HXTA4h+byjlSRKsj+Rmj/9aFNhmpS9dKKHVQD7Hl6Z1XYFLGJ2EVecbN34rnhrIaMqFN9rXT5Dk0jZZvGCmNSJ7zTfjcievLTRuPxgIInuF/yKrfuPXGr5cDT1x6LcXOP41+v188m5Pl88RelSXuFeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430bee303f7so173088475ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 04:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761044466; x=1761649266;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xqECeflw3i2zVSpUQV8RnVKS2ggV03DQT8rqmCJtiqM=;
        b=qZEMvo5Nq3cKiFnuPdHvrljjt9Rh8+PlLt8PKoFTh82a+3meadgKdWVvRNe4+SMtJS
         IdTvGOFAeD9Lkt1E+mhKcDm3kWH2fYfJwFZVTyZbuQAbItI4WTiGOBCxTMxyYMWG8l88
         c79WyWemeByr4zjVpbVyOpY4eGNWm9WeVHsBHJCdY0VORfxVUXnIMKHXkGP4V6rn/r2H
         tJFBKvk3wkeyC3cqC9O5wJEXxDKSGKMQzDRR6S5qq5NvUzZ8RQTC0dvAkyeR40KGTMQx
         htvgKkXKkSm3rz3kYe4hqVIgSK7WWRmIhvMiF1Nx+KLjnABALmLkLDM3wgckl9Xq4VJY
         dVSQ==
X-Gm-Message-State: AOJu0YwfuFWKYBaY4d57RKgBQP2x0Pqkk7vG/ukW/u248uCNCzkQtt0s
	lHYfJ4pKiNUgx9j4Itz9N6i1rW4KDXCKV2fpYiLUqRJFyRUolwXdXHnXwn6I14MAIV/Ig3RUYCV
	RWmWOuyz6mS2f0/UKHFOUP+rFG5udu79qrOVygbHO+lu7J15hON5i7tv2F6c=
X-Google-Smtp-Source: AGHT+IG9ZLle7zD+zrOTFrwzZtCxPMd/BTArvTXaDrUFGsxiuK1q46vLts3RolXuGQ5HWrSCodvlS5aMcaJWWf2uKEcFbL2LE/gW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148a:b0:430:a183:7b with SMTP id
 e9e14a558f8ab-430c5208006mr58553525ab.3.1761044466175; Tue, 21 Oct 2025
 04:01:06 -0700 (PDT)
Date: Tue, 21 Oct 2025 04:01:06 -0700
In-Reply-To: <8950a6e1-287c-43c7-b36a-cc42ca7e267c@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f767f2.050a0220.346f24.0013.GAE@google.com>
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

commit:         6548d364 Merge tag 'cgroup-for-6.18-rc2-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16b35734580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=568e69ca0c2fa75
dashboard link: https://syzkaller.appspot.com/bug?extid=6e493c165d26d6fcbf72
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1644c3cd980000

Note: testing is done by a robot and is best-effort only.

