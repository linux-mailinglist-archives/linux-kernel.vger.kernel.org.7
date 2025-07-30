Return-Path: <linux-kernel+bounces-750998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B7DB163E4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB7C57AE679
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD4C2DBF7C;
	Wed, 30 Jul 2025 15:50:25 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC652D836D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753890625; cv=none; b=mUwvmydxS1kP0uC5yKpjWZhcb7ymsRNixjgNnbrLMCL7GghyP2aAUBFYSqFB8bJDfpUf+1r5JFlM2Bbffb1jNjP4ENhLOmqDSG2ISGGFFO6rI2UTDx/JJNyJwpqWVi/eu06BiF33cT2RdhdKSgxmIpl0PImDlDA1GkkAFOhAYh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753890625; c=relaxed/simple;
	bh=Ph9eDgrKF3BRN1VvcsaBjSNta08Om5E00ZGUglEh8/I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ep/bYy5CzIcF5bFcw1ltNFekKUj6i50sxF1hDZkDevNmwwFpO9ldtensxS1iuTsVuuNRc76zk+4QIWXvLfN1JtVMzPCDlrkzpiqn/zAps2gON8K7ChwmjG2KKvhoMLrpTVaeXMxhGLeE8Are/XHbp3zocF7MJxiDIG82KDTMviM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e3c78b5192so19403475ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753890623; x=1754495423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ph9eDgrKF3BRN1VvcsaBjSNta08Om5E00ZGUglEh8/I=;
        b=CDA0dLxefI+h42o84Wmq84NhNk9m1Lb7AoTXuPoaHdNhf4GEuOzaeNVde/QrTdvRs4
         aMcJP3wjYXRbCNpFHBzaAiuJtNCyX62YLRmVlkAS7z6O/whYcdYcu6DRadcXSVyuT0GH
         /PcJwKedaEXIx0MI0IggHDxbJKQF9FC2hOYNvCLCbIBajqI8aHEa81KIZ21+DrVJh8qP
         /ra5KBM2FGkauUJb7qcZS8xUXOPy7hawMVb6WbQA465AaTneDvJ+rt/eqW9c3pNTbaUw
         fS1xnOjHthH5gNDPrL62vO5lhlB/77KkqJfyidX/0K36rFjvsXBS81SiRzSXGSXFJVwX
         L0TA==
X-Gm-Message-State: AOJu0YxE+dWqbJ2db4sGuh97WGh/9GaydkxeStXwRDj5p4DnIfyt9vaK
	zkrmB5PYAERM6nq0qKkQYITPEswRbnleOKfzcHJYYnMjCAEjmsYj4oVxNOz97zwUEj8BHaz3Hag
	45S3FHZR+WcRfzv+6OU1oB2CvMUBPT13asnRfK3Y9l81l+CIxcM/fC4bwQ3s=
X-Google-Smtp-Source: AGHT+IF/DMvTBk/lejAMoKl2/fx7gIY64IIyl3EYN1Q18wRNRBLtTJ2wLWZlzYPxae2/Q1szYS1xZs37ksFVSN1YUrQxTQpPzprK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:330a:b0:3e3:fd25:f6a with SMTP id
 e9e14a558f8ab-3e3fd2511b6mr29608965ab.11.1753890623225; Wed, 30 Jul 2025
 08:50:23 -0700 (PDT)
Date: Wed, 30 Jul 2025 08:50:23 -0700
In-Reply-To: <686d5a9f.050a0220.1ffab7.0016.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688a3f3f.a00a0220.26d0e1.0027.GAE@google.com>
Subject: Forwarded: [syzbot] [mm?] WARNING in move_to_new_folio (2)
From: syzbot <syzbot+3a24467a5470194c4175@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [syzbot] [mm?] WARNING in move_to_new_folio (2)
Author: anprice@redhat.com

#syz fix: gfs2: Set .migrate_folio in gfs2_{rgrp,meta}_aops


