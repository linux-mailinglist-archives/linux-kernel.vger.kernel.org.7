Return-Path: <linux-kernel+bounces-817871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 459B9B587DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0862F168368
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1522D1F6B;
	Mon, 15 Sep 2025 22:49:47 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF83523957D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976587; cv=none; b=JwzKMEAvgjltUB/XGowr4b+reD7W7dkXt2K/r/Js8Vqx/wCuGqf9Ru2WDWoZaisjHclJmDr+IC4W+Sy9+XMNstgbNfvifX9kBxITz2/TnXRi42bxwFUcmu2OpGtAvv+Ql9pnIcvBq/t6QrTbwnxfxPuE7T6REyJqS+vOWCWz+rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976587; c=relaxed/simple;
	bh=Ieq1ck0qvm3ZmRsGLSRgTwo5ZTOdLuFi0WGVB/YIMwQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PCyGTMTVfVyhwIWaPHViwgAicN4OWQjuPNkrcstx7MpxwVFx1s2Wu2XPwrHWlm3+uCxK8Dmq79Sjdq750brGhjDL8IyTLe73DkJi9pRZ55Jc0y/4MGLIN9Hu2vLWE0p8WINs0gbTBl5gfc2sBulNV81QOIvaa5h1kUeEXcsY9M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-424090abf73so16658265ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757976585; x=1758581385;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OV9FnEIMn3tAb3e2Fleb7GR+066UTYm6BepX40jlcc8=;
        b=Kvuk7T0WEzVG6pAidsEEnWTn0noIrgVpDEIxyEjdVzsai737+AAH4gT33CRpw9YCIq
         Skh26ntSAcGZMpA7UHehA/8iH8JMoVv0ERhhDcNSP8j3wCQrVijMjVZgdbv/l2q+/8iA
         6U4LmcJOYwIj3pJzfVRybvBey+FBuqXzY7V197Smke/SxnpMJZGooezQ9TUq0z9Tubfs
         IDe+8tmSAGQ3hzhqG38ym9xwYYkK4QVqbTiq7YffLQqfrcpUjWnVwxEeBoVE/A9PL6NA
         +84hFDmuJFQJdS1Uumeq3l4MrAqMGjtZTgA97qmYNQ1uRoK/W2RYxTw2M2gBEo1uzuBi
         augQ==
X-Gm-Message-State: AOJu0YxhPphCdaJuqPJ44CovfBXQ/WU92bf/t+DGIJ0vPvSj+oB/buo8
	Jj2xHyDQS0TsqjT260eO+tTjY3asQpcl3IB6F10jUs7gUfyNnE1ZprrAXJZAtGyVOgrcMWdN5tl
	R7AfDHo/+Dhpf5z73uTYmeONBWIw69k+a1bik4f5hv115lfNf9HK3AseyIcI=
X-Google-Smtp-Source: AGHT+IGUM/TAQbxnzhNY6EzRj9OTQ/M0Q/KEO7EXN6kvETFaUWruqZhFjgWrd1bVBhoNGxyg83xU5qKLeXCA++tNsXFbs5lOvOOS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:441a:10b0:423:84d0:7f7e with SMTP id
 e9e14a558f8ab-42384d08142mr92100845ab.6.1757976584894; Mon, 15 Sep 2025
 15:49:44 -0700 (PDT)
Date: Mon, 15 Sep 2025 15:49:44 -0700
In-Reply-To: <68232e7b.050a0220.f2294.09f6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c89808.050a0220.3c6139.0d22.GAE@google.com>
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

