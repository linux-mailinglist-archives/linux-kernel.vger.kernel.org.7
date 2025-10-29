Return-Path: <linux-kernel+bounces-875660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F17E5C19874
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CDDB188FD77
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6FE2BE647;
	Wed, 29 Oct 2025 09:58:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B035F2F6596
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731888; cv=none; b=ebnU6SrBylDxeqAukWCPiNSHYHM9aMJlGgMqQTUSBz3CFDjfYihrFZzpyk4tDddYOIGnp+L9xF1EN7mLMGj1Jb9LARJihdFUakcf3qGzfDP0LUD73KKEglPivdNsz6CijCUbJIoJ+ejFQO3IGEus/jW279WVfwXhvgnK0oW7zwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731888; c=relaxed/simple;
	bh=r4qFEAq7J5YHvhmOpm4fd1y5yaGFHbVbNRz7uHq8kzQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rivtqDpiw5GLI1HFH66r/+u6tpf4mOomM5Bb7vpclrjfmKosxIElyImAZdINpSxLY5Oq5O4gdNDsL7/h8lJSM+pJdeNz1fNuYS5sWYy2XrOgrAVoZBKXUuBs/w8dmxLfoPz4EMglPbQeRQiQYXHfs+A3IJsJPH1gqa9MMnXmhpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-432f8352633so33804455ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761731886; x=1762336686;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRHOvailpAA6/Md5eJL8pCM3F84vwiR40q6xUc0fzcs=;
        b=q7qp8kKGl3k0+8rJ42qlaH8819FACLnIre56jNwyzCVMDkSR45chf3PRqkX9TkAA6a
         FD7Uq2vwSz/2avySbtt+bJOFR3Orllb6pXRPmJoNMWTOBR0Bmy5y0PqDHsLbn4fpMTBY
         AnpOTcOMGz55o6QOdBvDglVtM4MrmXGxh3y84bJ0dKb6gpKwqOxqXq3f86uIlj8r56NK
         7zPM3bgRhryhYbLug2HN3UEl1FL4ymv4/RaoO8BZsNra3U58q8ClmO+aB0J7+FN6rCCs
         CU5wgV9m/zoN6d8zCZUqQBD8MzQMiDfmyONrpsS9XLJ48s1UiN9776WkdNQzaDiIgtVQ
         MUbg==
X-Forwarded-Encrypted: i=1; AJvYcCUIpH9CtKnEhXfQ8AUSUasHWPUfgkljpnvL3XaGrfAhcdGN4YwFj3pSpcaj13SgIjmX6bPiVU2O/cnnn+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNRgO97xAgcm7JwL+bRRHdUdCcLXNRkGdGn/M61jBjx9ZhjUjo
	ujs/XXrQVkXK9xuvV1HQFoTT1baR1CiqlP+qEXRdcVUj0sCJJHH2akBahEelvG9RXq9gpXLQZpt
	1c4C3IbNNWSysFpOuu8HjUBRCCfoUEhW3XDN9mHTWhoOVrm7UXiwQSUZbNgU=
X-Google-Smtp-Source: AGHT+IEHzK3+YsZzY2zd2EIBuBkqe3V4/NOFULMeeE7wE6joJ9evstGilQAl9aRm2EA4UvmW+2mHn7+SP9hiPYIykHV9wbiFI6o0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2162:b0:431:d83a:9ba with SMTP id
 e9e14a558f8ab-432f9045398mr28264185ab.26.1761731885941; Wed, 29 Oct 2025
 02:58:05 -0700 (PDT)
Date: Wed, 29 Oct 2025 02:58:05 -0700
In-Reply-To: <20251029062743.MHMWb%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901e52d.a70a0220.5b2ed.0012.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] general protection fault in ocfs2_prepare_dir_for_insert
 (2)
From: syzbot <syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com
Tested-by: syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com

Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=16a44bcd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7ee22a53c27b385
dashboard link: https://syzkaller.appspot.com/bug?extid=ded9116588a7b73c34bc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1394bd42580000

Note: testing is done by a robot and is best-effort only.

