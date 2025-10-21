Return-Path: <linux-kernel+bounces-862234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D85A7BF4BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E68E189C4AA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 06:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F158825BF1B;
	Tue, 21 Oct 2025 06:49:16 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353F920102B
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761029356; cv=none; b=iJR0Ugb1AmKolWcnhCiz86uB0V440QSSDnvO+iv9wW2DCoiIW4tDn7+CwjKkoZ3ap+IidkTtB4IzviWr0Rh2Rdlg/mGF49bk0EmvFdIk5t1c7BtD0etH6T1tv7WRU/l8xhx1wBy7KZt/CgPSVoJBJ3K7ViQ8aPsRSRjolJGiIKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761029356; c=relaxed/simple;
	bh=n4EMDB/ZMPHENqLOwGAWF2w+rg3IcAIiCaSmBurHBwM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qKSNjlgidNdjMM25j3z+WxVGSiffMXs0fbY/W34z6yHjaNTZ6AebYP6wuiaoieiRkOhfc0Ssyf7mcj0ZdvfJIjGN//NXiLQ9Cm4AR3HQFeVg6F8r785aSXE3hpz/srb90tz/zi/eSh6XqbZpdxdS3HOrQn84ZlspsGYoyWYUPaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-93bc56ebb0aso1583305039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 23:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761029354; x=1761634154;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9EsOh/KYs4jKZxXX9INmX/PRKRyrcZRvP6vH0nm224U=;
        b=Z8pg/duqPaYES6PxdBZToopI+7NVcnddEB6gFbKi1dIYQSPuzaft9gJjL0GvZQKh6M
         ufnX5exLEYaaJnR/UMdMjHfSei7LIf+kQu5mAsPSbpvsCKjUh9PwZ8e/bEvRNL6XP+qQ
         ShIlOWraIxn84pp8GGgqC5+VYQxMk+uPLgixC9doWyWULIXHrrKEkLHQcGM8xLAP5uEa
         JcFdyTHMmj0c1yFB/wbUQsBJBmseiKExOd9h4jn7MNJXBYbt4AqQ1m+s1TIT68EKQOwK
         6L7afKWHFQgZECR/L5Mr1Ll+SHmsmqHodGYusseaI+i3J853o5SAx54qnWKq91Wo0XZI
         Q4vg==
X-Gm-Message-State: AOJu0Yzmev6S679hnYz4RM4KaYEMwRlUfGbRa6HqJVE3guHfyC3SEjBR
	HrCbmTc8ibakgxMA2CmWQgJowAjca1Bjvx298E2p5C5Rnp1oJFDEs0DaKMrymAmdzs+fpVUyQNz
	/XULjlKXPF1BSAOhhivCe5kMwQ3cuvgxahIY5yCSKvEJuLmmFW7DWM6KjF9U=
X-Google-Smtp-Source: AGHT+IFCcLriG6nBGNiOctq7QBB/lexaDmYuXS1dMmkArYmvu9FDWrkcakj7EnOiChj8K4iGG1uO0D3KlZshXIvjUme8rnnX0gyy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4899:b0:887:26b5:a581 with SMTP id
 ca18e2360f4ac-93e76407480mr2497532539f.12.1761029354471; Mon, 20 Oct 2025
 23:49:14 -0700 (PDT)
Date: Mon, 20 Oct 2025 23:49:14 -0700
In-Reply-To: <68f6a4c8.050a0220.1be48.0011.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f72cea.a70a0220.3bf6c6.0001.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [bpf?] WARNING in bpf_bprintf_prepare (3)
From: syzbot <syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bpf?] WARNING in bpf_bprintf_prepare (3)
Author: chandna.sahil@gmail.com

#syz test
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1021,7 +1021,9 @@ u32 bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
                      (int)FLOW_DISSECTOR_F_STOP_AT_ENCAP);
         flow_keys->flags = flags;

+       preempt_disable();
         result = bpf_prog_run_pin_on_cpu(prog, ctx);
+       preempt_enable();

         flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff, nhoff, hlen);
         flow_keys->thoff = clamp_t(u16, flow_keys->thoff,
--
2.50.1

