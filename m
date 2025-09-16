Return-Path: <linux-kernel+bounces-817968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980A1B58A86
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BBAF163909
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6101D63CD;
	Tue, 16 Sep 2025 01:02:30 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7031A1C84B8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984549; cv=none; b=Q1K7nrYt+KdhRPyTrEQ4MJMRw8tUpv0kiJFdgYa7itUf7tpfTGTDVNx3NSb39flIwlzXlpBAYN12XpGRGgsHBNM3ITSiS0Ul3Eb7Sbu3ZG407+88/pFxW27glF3Ud6kTg5gVNaQGtmjRIfoCa+shzlZrBLixgk7n2MB1ueXyYpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984549; c=relaxed/simple;
	bh=Ieq1ck0qvm3ZmRsGLSRgTwo5ZTOdLuFi0WGVB/YIMwQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gIdOJMkFW0P5qQ/vqenTIeFDxVw4bFPcPj0KYVru2r+MOmu863Zbydjj+imQ6CE6GSv8X4n9wkKjrqdkZApIIJShJRwXE/kNe8CRsGEVMVjZfGLnNpA+T0zXqHzQt+SAl+du9KhoenezQalr28WYGnNMhGjtnOwMcGPOxQ4wEOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-89395ddf099so159476839f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757984547; x=1758589347;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OV9FnEIMn3tAb3e2Fleb7GR+066UTYm6BepX40jlcc8=;
        b=M+7taZHYatAf2vo1U+BChlSsBtUkeGbH6ra24pS+2zXwAj706aAGUodVzo4ImICeda
         wu3PVplqdrchALcf2Hc5X2400qdocKYL0S2E28h5VLe8NjN0vWr5DxQshrZMkMjCoIK0
         ZZ6JuzmLHeD9DNiKXEKGDPr0drWD23DvHY8tyArayIRjmW04nZXv6xwRjpYh8929Ghq+
         cHsHFWWGcT3eeA7txiNbj5IKc9qk1LunV3166xIJ9nLncIIdZynStcbwzWoa5CWswhP7
         rs5O4tjCTBCW/Fyjn7Er8BND4yV9RXLMaZXDUUwwkK0DY0vzKaqbjDtKRnMLppaGlTBz
         wkMA==
X-Gm-Message-State: AOJu0Yykxbk2eyOZXZmNDKZisg9CGIncq+ShpTmc3jrnY+by4EL5p7KR
	1SpF60lZETDKZsSXZCdtKSrRUnb87eLRhVQlXn/vZRwKv+j0f4oa/MyPue/gJG6eMT8JeucBv96
	2CnH3bvqONct9ckbiaNO1eoe+0MVdzuqTXSZlTrSJ/8COfHX1l9Er/Y2jOsc=
X-Google-Smtp-Source: AGHT+IE5jyO7cRI+PEA8iMmRE6mFuaN2OjijGijF/8yQicCXXpVTG1Ww4+XtZNzZGzCy0rQc3II15CeHgvX4i6yw/WyOxgLjDtsa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6189:b0:887:5693:3204 with SMTP id
 ca18e2360f4ac-8903539e4a1mr1491406339f.16.1757984547589; Mon, 15 Sep 2025
 18:02:27 -0700 (PDT)
Date: Mon, 15 Sep 2025 18:02:27 -0700
In-Reply-To: <68232e7b.050a0220.f2294.09f6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c8b723.050a0220.3c6139.0d25.GAE@google.com>
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

