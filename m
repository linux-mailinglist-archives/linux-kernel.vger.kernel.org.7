Return-Path: <linux-kernel+bounces-839365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8A3BB17C7
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 20:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B28E7AB5DF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 18:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB042D46A2;
	Wed,  1 Oct 2025 18:26:25 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAD519E81F
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 18:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759343185; cv=none; b=n1yvkYRw9wkqigx0Q5mzOW70wnvwOuyTAIpJQxyoQ5EEcE4+9p0LuXXZRKercvt/DFtR/GTPrNcD1YoO23P6FBMfR3M9kx6bse6Mj0Z7SaZ6ssR7c4c9xOiGWWQWJAUcD5ADJfrFsIntpi9WKvTbBXL0e9HbrnowfvuV4NNg1uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759343185; c=relaxed/simple;
	bh=YnKUJgTw4hnjkX3zaaPIOzyCbJiKYIB8El+RVKV7c8o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Km1G694fZPB8/K/ou2FLpTv4LPrsDB1W0EcDOFQnfLViS9uN/9L0zBivPCABkY6usFbLskScmb6ksDQ69uJ6xo8s57wTuw9/naFpm186Lp957EVnOIQrfRRAtAFns9wcTec41Hx0El+1En1dgFx8oPf7UVYA+hVz4wGILXbTGo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9286199b46fso15555139f.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 11:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759343183; x=1759947983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J+5koFq4SwbJwUz7NkiUwAeOuUkwT4XrN8sUB8Uf/5k=;
        b=j3rDxKvOgSxvPqyjnQRzW5GgtOSlYjc3Lt7n4/bGro5hbZFcVlcTU8tyEP1YHV0We3
         GtlWJmC8kRcCX6YDEEe3pKInp2SPil2NEgzJgyssz3STn8HiV3jOYVtj9Qj3+kZYTMHa
         e8SFklwgTfC3K7VMfY3m1QsnGqiujxFAnsORqCIJyAiyzB38i/T1XsvYglphGFz1sIxl
         WDnguK55ScySMapZD3RY9UBKjsptdQd1Tkxe4ID7KxyOWroWZ2AxeZaJeeszXxVhXRO+
         6m3O74za1S2w7LdFSgWB28XFue7OEJ8NvLGub97xivjxxftr9FP2W8yvA5lHX86OGQbX
         Egig==
X-Gm-Message-State: AOJu0YwvQ2cwadXdn9dqaTrMbzg80BD0uAkg8DRNJdli2dge9YdpeuSR
	FWeUuWlVxK0n/8D8TsWF/S+i/9FG0XNf/o/gs5+976J75SFUXed8xCaWFj96NDoXsJtENlH6OaN
	2AtiSNlkyCtMm/vEeMpKoYWI9a9bXQvEmjXBpsE6dZ86MwcU1RKFt4hXgTUg=
X-Google-Smtp-Source: AGHT+IEWb5Q6v1eAUX584j9JIt8LUNVU/bo0UXpMfIlPuW88V3DqNyZH3tVfkC/D+YkO0tbPSvy3h7VefJ3cgl7rhrQVQG4SDe6T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b21:b0:42d:7e2c:78b8 with SMTP id
 e9e14a558f8ab-42d815abbfdmr60849585ab.2.1759343182832; Wed, 01 Oct 2025
 11:26:22 -0700 (PDT)
Date: Wed, 01 Oct 2025 11:26:22 -0700
In-Reply-To: <68af9b2b.a00a0220.2929dc.0008.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dd724e.a00a0220.102ee.0060.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [bpf?] [net?] BUG: sleeping function called
 from invalid context in sock_map_delete_elem
From: syzbot <syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bpf?] [net?] BUG: sleeping function called from invalid context in sock_map_delete_elem
Author: chandna.linuxkernel@gmail.com

#syz test
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1368,7 +1368,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
                                     const union bpf_attr *kattr,
                                     union bpf_attr __user *uattr)
 {
-       struct bpf_test_timer t = { NO_PREEMPT };
+       struct bpf_test_timer t = { NO_MIGRATE };
        u32 size = kattr->test.data_size_in;
        struct bpf_flow_dissector ctx = {};
        u32 repeat = kattr->test.repeat;
--

