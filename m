Return-Path: <linux-kernel+bounces-868414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A83C052B7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C6CE56362A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B1C3081CB;
	Fri, 24 Oct 2025 08:39:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5D63064AE
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295147; cv=none; b=BKq0cIdeSJsC6Cr3lwClEHvKsxp3P/oagrhBTKKuIo8HCEVzlYs9CQafhlV19SIRTA/RGjOh7iRNWOi6DPxFFhPbjakKs8oSJS2VNCBU/UNU7CIp4nmGEewMgYgFVxSmlSfnAaXRo0sB6mc40eS4ZFWLDKlCAAismjWcvpeApRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295147; c=relaxed/simple;
	bh=c1DE5SEv+nYwXoWem78B7cAamAhqO42laA4vmCmQRj0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eq2J6lQp8mFaVWLbj+dBpKEe/x1ZT8J2gjJqcezlv6Kn7T+H3KzW514fmKCCkFRebvqn2+XF2Vg8sT0rz2w9QMTFbAIX2zb2/J87D5cCnGXX7TkRgz/QL7SaJSaHKf80erNmNnDDVs5Br7TrTdGf1TbtuE1XYbp5KKIM49in2YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93e7f4f7bb1so146256239f.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761295144; x=1761899944;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cFVIzwwtUriiIye9BhKbf8fKTbh3kwvsVK/aPGeC/jk=;
        b=B/vpj3BaR3+tOROtBi82J2+IJHukWlqdGox/S1TXyd6Y8iOcFAdUJ9Xh4i9mEPloX/
         4Tgfg9e4fwNmSzVWisOIH1M5Rco/cFEWvoWxMTKJ58FGR4++U6fxxoJbaUCZUOdC65OP
         GV4jZqv5rRy7QReQiZOWkGuRpIZkt93QQOhu9OLVOs8hN/rlmSAAqMLNcKjibSm+OJ3f
         XrTa4PfeFPwPtbmK+xmlzQpb2cY/yD4KMVCXpUvUWJiwTadGRS+xIpZ0pota2dkggep4
         fvqdIA3VYnwfet+j/a6AT42QOuhGsYAhgnlmMAiaz1tpbthVuPXSxqqPM5uhnpvgy8Ve
         bvRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/OR8tmNSH7Q+q0wBhHArK1b1IhyKIAdie70OAZcrFjY5HfxDz7bxGa+5xoo17qZHRj+aX3qR9Q/jUvJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvvkNJOPgdJK4olGpuqoeKnIAX2QkX04anR1Pr9C1qBlmJF+Nd
	iIaYv0OE3zqlpcyiCJ31JrHDZ8fXQO6SQYDkWPoVtfKgAPCZgDs14zK5L5AaPvqdUedEVKKLiUE
	rO9Y2mInML9Eb9ig2cT874edeV8OTR68wGeaGA2rplwy5xNmFUz4f4bUN4Wc=
X-Google-Smtp-Source: AGHT+IFbgP15d1KG3sTJARVfg/QRFaekcgt0cd08TpADIs+YBYQRwB2nAhV3L1e3cqNfuOes5gfvSXJM8+FZ1znw0TKZ+7X91D10
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:378e:b0:42f:95ab:2364 with SMTP id
 e9e14a558f8ab-430c52a03f3mr349333755ab.26.1761295144636; Fri, 24 Oct 2025
 01:39:04 -0700 (PDT)
Date: Fri, 24 Oct 2025 01:39:04 -0700
In-Reply-To: <20251024071520.3EwpH%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb3b28.050a0220.346f24.00b1.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in __ocfs2_move_extent
From: syzbot <syzbot+727d161855d11d81e411@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+727d161855d11d81e411@syzkaller.appspotmail.com
Tested-by: syzbot+727d161855d11d81e411@syzkaller.appspotmail.com

Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
console output: https://syzkaller.appspot.com/x/log.txt?x=17a1ae7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68b0957bf02e2346
dashboard link: https://syzkaller.appspot.com/bug?extid=727d161855d11d81e411
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=124eae7c580000

Note: testing is done by a robot and is best-effort only.

