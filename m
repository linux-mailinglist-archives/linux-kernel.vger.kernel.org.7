Return-Path: <linux-kernel+bounces-730642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C6AB04786
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E4674A3677
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E365277036;
	Mon, 14 Jul 2025 18:50:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD58276056
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752519004; cv=none; b=XUWgxxmD5gr28ew64bkVqCiSiBNS+qJiwDnmmFJ0x1r9h114RxBGQR96EelZJ2xf1YqSpNnhqrg3J1AICQh+0clpRVgXHyHEu6Bcog8bFQWqRChkFiee8uGNxfsxzKhjgXKawdAH/Axp3Y9DNEcze/r/Ye/LwIVgBCOXjZ1fads=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752519004; c=relaxed/simple;
	bh=sL3Ty6zb90cdZAu3orpLPgO6y1Pv97CVNHZeDEtIJI0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YWAVnSFqP6Ht0SsAlkFhKob9t+IUlhW9uFTkv0CkZDlQ3xcr5QW5AFk48uMjX8KL9a7jsdNWZa6vcO/46QR6k9wBEsEXQLim5GhWa9yRHrzsaoGIcdxkFhGKX76JGNU/03q1dzD6Kc+eNYfEa13Z01wn6xUKMaKGSU0bOk3FJRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86cfff5669bso458434239f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752519002; x=1753123802;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aD+SVBl8w3djGHImI0ouoaCds+D4brGq+H/e+A2QQA8=;
        b=fHlOcUn3qPOtgrvBsl426AJbXCLycfwmNfg5oF4KdczXHbgsPHLlISee4BTpYV9ul8
         N3Dy/rsBD/XogHcu1ABXmq9tt8U6b4WV40vADGZ5Q7MH731y/yM+m1byBEfSYuqYFU2v
         54Gh2k5CgC3sUYJPYjB4g/3/OzeoAqVwC7HlH8/srqeKmAKOmenoPToCTeyBl445f0hZ
         geXLiWUdvzfqejoZ0I/EEaJ88QD3SYfkRwElGa3lhEAN6CN7PeNW9XLaIdiSmsNSMlgD
         RS5TPQEGyat1iULjKiYLfA0GmG+EfSJu8hrK4OjlYPa3Y+HWZl5/g7he6OtvepE0Sic2
         AcJA==
X-Forwarded-Encrypted: i=1; AJvYcCW7asqzAGAZS9UiD5ifim25e1fgDI9r4M2ccVbh4vGYg0Wa2yd6qZHl62RWemC9IihER1GlJSK4YuDeQpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVWzhXf8Yvuf98hfZuYxwFiy//DnydWO91CyYLsiTDPoEJrIgB
	D/w6kwIRhqWOpIADvqNjNwpiPrmoMu0ZF6ojuQRneRn+eXPpgFMFzBG/g8uIO07IHxPw9Y7bjfS
	nWnNRxzz0PBHjOYsoddG+Dw/fOd5tEJ0qliqPHmZbsQDvGKu/vjkVpsSOiPQ=
X-Google-Smtp-Source: AGHT+IFzNT+ecM3Iao421peKAwInDKwETKEbMkk8Yte5dfJG8bGYr6cgBOlEREmDlx69Fk8YtdQEjKR2+ZeBTJgp7PRDfp+n2UjI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2bf0:b0:876:737:85da with SMTP id
 ca18e2360f4ac-879aec80118mr86370039f.0.1752519002324; Mon, 14 Jul 2025
 11:50:02 -0700 (PDT)
Date: Mon, 14 Jul 2025 11:50:02 -0700
In-Reply-To: <f6e67c38-8d63-4536-827c-09757a8d5609@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6875515a.a70a0220.18f9d4.0006.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] UBSAN: shift-out-of-bounds in s32ton (2)
From: syzbot <syzbot+b63d677d63bcac06cf90@syzkaller.appspotmail.com>
To: bentiss@kernel.org, jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/hid.git on commit c2ca42f190b6: failed to run ["git" "fetch" "--force" "--tags" "0d6f9bdf969aa7d8637c9aa20dfc4a9cfc8f96cd"]: exit status 128
fatal: repository 'https://git.kernel.org/pub/scm/linux/kernel/git/hid.git/' not found



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/hid.git c2ca42f190b6
kernel config:  https://syzkaller.appspot.com/x/.config?x=28729dff5d03ad1
dashboard link: https://syzkaller.appspot.com/bug?extid=b63d677d63bcac06cf90
compiler:       

Note: no patches were applied.

