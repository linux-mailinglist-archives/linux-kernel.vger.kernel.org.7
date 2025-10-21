Return-Path: <linux-kernel+bounces-863692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A07FBF8D88
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5BB04F0A66
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278CB283CB0;
	Tue, 21 Oct 2025 20:58:21 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4125F350A33
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080300; cv=none; b=c+qoF3W9GJ0P4gUBua+wUfcPxcooZNEM0E06Zf7Ji9VIshtLb6KrCrkR2AIq6z7uCCY0HJBjT7r79rCnsMk5ZRV7c4fxL9SQfCYfT6OTsBB4uCLUj0qY5rdGuF/06bf0WzdvowxexHrbBaN/cmfYiSYIRUsYg9rsOlgP4ZX+m4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080300; c=relaxed/simple;
	bh=QtRLj3vOoZMDeu5ioxtwz0mA9axsP99tGxCDQ49INNY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NSqXv0/1joAlKmKrDOBpGRgC0OhbA3CI/82pE3XIFUUIZnpu/aw8vt4Hl1zbFECk00upfawC+0W4QYEdziIIbD8kWATDY5sd1pK/ILvsUU3vX+B/TDgruW0XGcTftVzpynZ6N4zK7RQM5T+UxmBx5cjNSF0u3zlFIzsvnqVmv6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93e8d8d2617so52899639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761080298; x=1761685098;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtRLj3vOoZMDeu5ioxtwz0mA9axsP99tGxCDQ49INNY=;
        b=FolRB38Dbn5RMNW5AnCy56n08Edvuew4oZgAPdAke14GfxxPmp+Ra0tsrLkZ3bSaE4
         sTY9ujT+r/A1JQx7BzOKk3XcweKOjXi5d9iVpaYKiZ6sB4hEcaa36RttF3fsh5a8B4uG
         Pym4P8d02AfPi1PcD3am3FFtMYhM25WIOwUVmPUMaFVfnn90hJ/cJTJ/nwCDo2gjWYm2
         kZebissdlwv1KqeZlDncOQQYd+wpcEM5tYQRrilRFh0LB3YiyF9iIfMUxtBtwYu57THT
         /qtH59GosBq8+Y17Lq6ptvFqwMMgVF26p5hfpE2smZbkqwkAL7ltiqjtdAPgAmNpt/OM
         cexg==
X-Gm-Message-State: AOJu0Yz2edDXA2EEHeumV7RXLDVzMwdwqs1TuAQ+Ptyr2GG5QLQRvI/7
	FJH2Bqn5yDHOj5/e5P9Ga5fwp/UCUqq3Tub+MNV5slsWWxNqUdJnYVxQOKzpXTBrRg8eUSSFZU3
	1F1nHTLne7cL6Fw6aAxVTpUQJVnEsRP2DIGkZswLac8Tfc6w2olreBr4qhhg=
X-Google-Smtp-Source: AGHT+IEPA2jEDcQ4vvTVPT9iHIFHV5R4NP/C8not92F6kV7AjkjYPUMmQNihV3Upe2g+JBSicbghwxuISUz4KBD7pE/KhwdhTcaI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1344:b0:940:36e0:ad2f with SMTP id
 ca18e2360f4ac-940f448c848mr178323639f.7.1761080298331; Tue, 21 Oct 2025
 13:58:18 -0700 (PDT)
Date: Tue, 21 Oct 2025 13:58:18 -0700
In-Reply-To: <68f6a48f.050a0220.91a22.0451.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f7f3ea.050a0220.346f24.0027.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [gfs2?] WARNING: ODEBUG bug in gfs2_fill_super
From: syzbot <syzbot+19e0be39cc25dfcb0858@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [gfs2?] WARNING: ODEBUG bug in gfs2_fill_super
Author: nirbhay.lkd@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
master

