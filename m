Return-Path: <linux-kernel+bounces-819134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B532B59BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F3B48679E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A6C313267;
	Tue, 16 Sep 2025 15:21:31 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FA425FA05
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036091; cv=none; b=lMpWmXG6H9kqQi79ur91pwyvh29xLV4YRQWsS1iyPv8AnOPIiPI25qEBt0qnpktsKPbIL3UVJdvhsW6tEegpNlF1W+FfCoaLyIeCoqasmuEdUBzwTYT3ix7MAqFbdDljU//jV7ltPF/JP4USlrWBXnkx4szNWSU7ISpFFOcf4Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036091; c=relaxed/simple;
	bh=Ieq1ck0qvm3ZmRsGLSRgTwo5ZTOdLuFi0WGVB/YIMwQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nwWqQITAHRmDfSa7MM2I5bEdUeNuXaPj9zpHoaMiZ4AOFaWgzCo7POUWXtTX+ARNldEp6DI1DnZk/ESaaTgPiow1SHBdIOVAXp6CqusU3N5LcPcwAEzJWqYpsaUczTjlkKr4U4iE/hVcmlcxRJPttynqTO3mo9O71085vOqZxrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42404e7bc94so63560635ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758036088; x=1758640888;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OV9FnEIMn3tAb3e2Fleb7GR+066UTYm6BepX40jlcc8=;
        b=sH+EH2Yak5iS/UCXhlO1KrgPYUicSMiW3aodi0ILEgHiBqyEwhxX8G+p08IbOIoG4G
         hoT3NJ3SJ/2hEGgicPgrwVTR3vGL4t6zJmDYMExtw6i+qYCLYvko3diZP9CDOBNODRrQ
         nYzqw4++xPJds/uC1pI0Tr8iXBBh8ov7VWcpfXkw5fEcp0tafi/ttQizvHIwdNMhwnMc
         GJayIRdP9zxL3qNN6AKAQ5+xAWtXez2/RBKTaMGDWvGh/GCWpVPb+UUKTI18vyCfZfNF
         yCEhKmlvOB5y1BhP6Q98Ca8J/0H5TT2YzdOyz5TuNz9MjXh7keOiXv5y8mhbkhYkFWYN
         lBmw==
X-Gm-Message-State: AOJu0YxsSbJZypMTXMn7z0ZAmo50mPlEHf4ow5gmjjDd65A95/bay8HE
	rMUeSSAIpm1xwn2UhoAPFAvFv7rFmhsfUQsskv4WH0zjJTIRM2fPfwLLexfNGJcQTjeSxkpApBu
	li51f+4e1yavioVaUJsLrTzBQnBna/xKfhYdXygrE1IIXJPhLOY4sIlEwQEQ=
X-Google-Smtp-Source: AGHT+IHnXBew1WmC6iW6ZnlNylo+Mlowg3vj9IuRkBkW0ZJV8fWbvzOeUjpJquQPOzeErmaq2zG67w2KiX9I9zWfSTsgL72G6KuR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148a:b0:423:fb29:5b8c with SMTP id
 e9e14a558f8ab-423fb295d06mr93315715ab.20.1758036087903; Tue, 16 Sep 2025
 08:21:27 -0700 (PDT)
Date: Tue, 16 Sep 2025 08:21:27 -0700
In-Reply-To: <68232e7b.050a0220.f2294.09f6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c98077.050a0220.2ff435.03e4.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
Author: yanjun.zhu@linux.dev

#syz test: https://github.com/zhuyj/linux.git 
v6.17_fix_gid_table_release_one

