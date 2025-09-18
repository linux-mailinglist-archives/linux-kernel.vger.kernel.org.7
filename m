Return-Path: <linux-kernel+bounces-823409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16572B86581
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F99566845
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACB1284B20;
	Thu, 18 Sep 2025 17:59:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85FD2820B7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218345; cv=none; b=aMAJHqCDKichEEkPY61Qxwh1JczgPCHTGNGgnZ71YgPjEYXHWmoc8STmqtk7UyR73UlkfTJa2LwpM0M6KefY3CKXGO1tUnCKcOCVezl4VE05iIMLBcywGkZFe/NNiY2Nx38KhbWiDY0FzPV0P9V+iqLDPp7yNX3InzNGZSsA0CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218345; c=relaxed/simple;
	bh=voS1nFfSE4XYea812P6AI0O3XYn+YHAxLnCXHErAHNQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IcaIxya83GCzDM3FbILczhOtOmOYdCsz4Mb9udFbINSAkOc3PAr+8ku9MUompv5fJt8Bu8g0oK2lt1H1lkV3m6jxlu7x3is/mk7u52tW/sbWOksdmLf7uDIFpUSnmHUstoPt00MgBaZXIV4ki70n3AJSp2Oi9tXsVeZT17Chf1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-423fb9b0ceaso15845355ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758218343; x=1758823143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VE7HWM8piwidWDjnlxVLPTicbp3gjTvLxvgeKN3QPh8=;
        b=Dje8m9aF37paIxmDwi89OIpjAVgRe7vGsoAXup3zcanS6rgpvx8nfzc5Ecxw/sT+eB
         EoRaIW6euKxduazWI1QJYU+azzfyopw9Th4YgDuYMyfTUpDkGnik2PnS3NXwppxBJunq
         t6v+PoPn/WufW4DTopNzX9o24oAIvbJvy5SBs+ViF759cQmL41PVj6pH2pLWLrF0NCBq
         auh6Xe5cvCojxyUsHeiJyhydqnTmz6HODF32amPMAUlpTpvhYEXwiPjOeGeNQ2P0s7g4
         0PDAYtcVuCjMGJKk65jCz3UvroLTwkybgxV+IMwvm31/OJw7+5XTfm6iUw7aewd75k6L
         oQ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV16fqtN9lb8tvPx/n1h5SrVwhGIbc+aOKyG9O170TyxorouiglqRiiZzQZnBsKqeLwex1ttpOsOUkmfkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/sGmqZJ2OX1r4AWnYPlUq6jrsPmnf1EEX4gFhDZscMPXXBNlV
	aWMOEz4NW13/BYdtD6LvJ4WvpN5jA69KYrj6MVD8vIxPRI725D7ktB/SwItus9+qO+a3WpUhwCL
	Qt+UKTetSrcMdvwUP7FvkZQ1pUzMdt9yTVzFkEJWJew4w9MiULB12uKOxKF0=
X-Google-Smtp-Source: AGHT+IHWqVJGTwSrA4tX7Ku6lF+2/bMkUX6awfXRGXe/8pl4ont2g98RpEeBBLRQ0LWLpNsMLrjn+IMo/7lz9520J8R4wN7ZKS7C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18ce:b0:41b:6e7b:3e9f with SMTP id
 e9e14a558f8ab-42481999a44mr6353275ab.19.1758218342855; Thu, 18 Sep 2025
 10:59:02 -0700 (PDT)
Date: Thu, 18 Sep 2025 10:59:02 -0700
In-Reply-To: <CAC_ur0os0P5cA_=3LSkoffOtrTN84m9CNWtCH2NZXz642Oc2Bg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cc4866.050a0220.28a605.000a.GAE@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_dev_up (2)
From: syzbot <syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com>
To: deepak.takumi.120@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com
Tested-by: syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com

Tested on:

commit:         86cc796e Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d94712580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b093ccee5a9e08c
dashboard link: https://syzkaller.appspot.com/bug?extid=740e04c2a93467a0f8c8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=162bdf62580000

Note: testing is done by a robot and is best-effort only.

