Return-Path: <linux-kernel+bounces-890300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7F8C3FBD7
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27441891102
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B088D2D24BF;
	Fri,  7 Nov 2025 11:32:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD83621FF36
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515125; cv=none; b=WBm2905PP12SnaN+WO6x7FSXlpoB8gtKpjTuaPgH5lubDmY2/8B6amxFJj28paDWbLyvUhhiX1KkPjSE2hNeQ6LqbjkrKNGm881IoTK002sc2YlGIlyzLPn5WobBraTZ7fUTtN2/Fa1xOzeTRqMsdaQdnziE411mN3MfEecIfpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515125; c=relaxed/simple;
	bh=OFrH5GoIa+E6yJ6lWYHC0WMko9NUBwSOPgxi08PymMk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MSS6l+iiJGs296LgezXqiEUYTO/L2jD/lXULC4RWYCyr2rdpbiIHl4fyGuUfJDmc0PE/AeLleWT0r7dib+wVo3hWfyWYFsO7Fe+ss7YKlMZMOwgdA2K93F0YH5bJuNqLiCGwuke1YgNji+d2EzluXMjycZK3EAdBGFpy1zR58K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43335646758so5938805ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762515123; x=1763119923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fXOik/uPqSDQlxPompsQtKKI5ar+Ej2i4bOp8xi+Zls=;
        b=wVt2wuzSTQQgsLpdp492DRF/phlcM13e96uE64ZgZ3wky9/0V8Jp39b1q3M8awPXOl
         Kt2bGslRUHQoNQyg4BJ/y20C9L16ycZeGCfH/qrBfxJcHbUEfvuf87uQJpVVrMiYR7Z6
         vIPgSi2OwMxPbzETBdbBky+PTKzivqT9B6ogYa4ANtd04Ze9DqGkDCGfDtxBaBoG7UZ4
         WMDGSNjqQzvkzwLZnx3pA/r17wMUXjKKz6CfxooXaRJOz0noA0ewKXZWz3d6nOt7K61n
         8nUdrtbcZbDvulkHLW2UPOQN22rYyQgsq3tkBLLtKErIrmZLnvRHt2RlSg6KbaWfbwcg
         JumA==
X-Gm-Message-State: AOJu0YwluzEf9zes+j4qjTLbOdpVH1jLIGXDn7WrzFh+d8/7c0/zRPcY
	dzI1ZyCjwsvFtgeucJXzF+MsJFNoWWoZUvidv3XcVS0iWtvTzjpakLtEPChi5gv5kDUkUSU8+/X
	aIUeaGFKcmtb5+z77F0PMU/EF2XFExZcn/geRmD1KKe79ZlPJ3cX7M4dCz/M=
X-Google-Smtp-Source: AGHT+IGLUrtgQ+1M+9XxFZXtPTER/8ln9pHoySwAXZpXr4J0kVIyyGmV+cLzC5dlMkoV8PzVRXUBOcffB6AFx0pEV21gyU+G+IDN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3044:b0:433:258e:5a92 with SMTP id
 e9e14a558f8ab-4335f479c79mr45051355ab.32.1762515122990; Fri, 07 Nov 2025
 03:32:02 -0800 (PST)
Date: Fri, 07 Nov 2025 03:32:02 -0800
In-Reply-To: <198bc606-3470-45e2-9296-3c3115b43885@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690dd8b2.a70a0220.22f260.0042.GAE@google.com>
Subject: Re: [syzbot] [jfs?] BUG: unable to handle kernel paging request in diUpdatePMap
From: syzbot <syzbot+7fc112f7a4a0546731c5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yun.zhou@windriver.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/jfs/jfs_metapage.c
patch: **** malformed patch at line 6: diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c




Tested on:

commit:         dcb6fa37 Linux 6.18-rc3
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8b659f0cab27b22
dashboard link: https://syzkaller.appspot.com/bug?extid=7fc112f7a4a0546731c5
compiler:       
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15967012580000


