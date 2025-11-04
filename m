Return-Path: <linux-kernel+bounces-885367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1EBC32B42
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E6C42524F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B01338599;
	Tue,  4 Nov 2025 18:48:01 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25721329366
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762282080; cv=none; b=eQfDR1CrnAhlZW4leYntnOc0VLmCYm3Xra9bKmUdjNSwu/F5xyxjX0vzxD5/Jd5eBQQ7P684mxNr3vAdn7tp/DPhEOxtUOvsVranyWve6sZcvpSnLwuLw1Xt6zG4cwfkb93wkR70BovOxVOKsqa6HuMyb7/WwBaOMJC8JYnvLjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762282080; c=relaxed/simple;
	bh=Ieq1ck0qvm3ZmRsGLSRgTwo5ZTOdLuFi0WGVB/YIMwQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X3Ng4lePVIs4EwDDG6jOt6HQVNt6QcUVMcCPBOTa2e5bzu8CQA1nqKpb9ooZYSMxLMTuYAGoFh/gTVPV151GpYjhxu1uBwEl4TNw6pmQk3eUhN1lbmDUMw7nC7dttUjr0p6mNiZcwuCWhhufcGWquytH4loIk+1M37LZWmRQq5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-93e8839f138so582701639f.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:47:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762282078; x=1762886878;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OV9FnEIMn3tAb3e2Fleb7GR+066UTYm6BepX40jlcc8=;
        b=CAn4buCZ6uvhKUtNvj4gkZDh+gWXfI+rCtROsmhaNMc+0a8mjEanFU+sUmhtYznJqb
         I0IRuWsBoA8H8EBw03cCQGGLR0m51+wj0TgSiPEDqTZqsKWQUDTs+kl4ZGI8HuUiS0H1
         urcPVl5pqMidrwygnkYN2hbJFp3uGpsdAJsLPzHA/GHYdjiKkmPtHtHW4fkGcU/aV+VQ
         afaf+9OB8HOaUOUYt5x8+Ee4EbPrh0/EvZPHYpqQxwQKZIuAMr4b3Kv7ZhKoGWH8Hiye
         obaTzUqapdud+Onc5tZjURZb5CBArAyHnYt7YtYdpOMiE/70Km1LWMEwUPe9dvK0Ps7A
         HGWw==
X-Gm-Message-State: AOJu0Yw0x/+k5pKjk9pUtAGi9Vf/ofk5CqLSiBNkyel4ALT8U0unVczr
	M/ZpAqquSddV7eDI3iVVdvh/U2ipju6cW5lZ5u3W5dwGbBSeObcMfVl1AQQDAdmWwNXMHqrsx18
	y5h+3LiZvBfmeo/yR3kYAGGig/+UsLfg3867DxDjfgMtLxs6IvNsKVYD9otg=
X-Google-Smtp-Source: AGHT+IG8Mys7ZQOLY+ka5uVMxk9rQSNFy/DH/GvkO5+Fd/zdVV1YZLrGQyqG+EPNoHaMPxUxzQnQo/RX1AgqFQlJ9H56MWwK0jZk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1606:b0:945:afe6:4bfe with SMTP id
 ca18e2360f4ac-94869cb7b69mr76628139f.4.1762282078188; Tue, 04 Nov 2025
 10:47:58 -0800 (PST)
Date: Tue, 04 Nov 2025 10:47:58 -0800
In-Reply-To: <68232e7b.050a0220.f2294.09f6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690a4a5e.050a0220.98a6.00b7.GAE@google.com>
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

