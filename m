Return-Path: <linux-kernel+bounces-734632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B7DB0842A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D244A43006
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 04:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855631F1518;
	Thu, 17 Jul 2025 04:56:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C855ABE5E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 04:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752728164; cv=none; b=XEeKqCPejFfrT3YB9a3YP7vGplrgEO2jZDwluOLnY/2lJXUmbXv69GUe72Bo1I2UD3hqgAdE//bGuAzuq0RtHKzUg8GUpAZSeIm2Z0vwX+49udBMq0n8YLdkzxkxGzGHnscgDOd/DbD/LBhoVPMHpch84ZVoJNvooDdnuepH7TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752728164; c=relaxed/simple;
	bh=DoUQx2vhcUN85Xl80wzbysCOIkPrdD8+hhrl5e5dGTo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=n8eFXve68o8jL5s0EFJCZpt76LlLRm6qOAeIFywDxp3T834YX0C05SHotzsInyr6C/wzQRW6DGf148fQk6/4m+8b3D2et8Pk0Sw+BcDFfOQHVTmqlhlScsOZzbWGbqeIZkMmYxEpZEVNkQCyT3uRcgD8fq0NU5sHfy/VbPQL5Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3df6030ea24so4862725ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 21:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752728162; x=1753332962;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGL9AxfQx8QhC7YCMVTtwYJNq4RjiaB0PWUVwDrYvAg=;
        b=ah9wyoKxMp0c5VPVcTnbGzM4FrQDSjzGub6dlZf3Tomro7oiqajGu+fO9maMkNIxLx
         Rgp6+w+mLOQSGrbugsFSRtB8xcMfGjbH7K7R2rihJ6kIiVHPi60TUeHRwJpDsMEQpP2D
         Jumn9N4Rcn1vRGVDEVGIOEqfaD7DuToz+6q5v3WQ43kFNPQq6hqSC6WHVst6Tu+pufMZ
         4qvyyCOdWdDdpJMIBAvkxxhFQA9HHkno5EzYIgmwBftQShOUiUb+H6cIrWRf1Xn0icAh
         eJFdcGoBPRP1HqoMnyRtiyg2r3Vfo37yxIVtmIVBirlZf0pXTHHkwHWNkoplwJQU1C8D
         UY4g==
X-Forwarded-Encrypted: i=1; AJvYcCXriJMAAr5YPWxVALBpV7BEf5ocfQzvuialgb1z47CeE59cgpET37ayUgoDKEgnlzB5gKlE/dbT5M6290c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx9GpuAIP5pYITHMnDrlLlP9fKMUHhrC5+m/1+sQzOMG3wCqZs
	/yHvTzS5PIFdRs+GCb/k936TiKABEYeB88L88z+bq3Uo9OQjxCmKJwpd0RLHkmRxMKVHNNGaftm
	OZ44PfogHAGpRAYlgz+NoyGftk/I2s8BJJOfKbD2D1fWxPFwWUpq1qJ2aeGQ=
X-Google-Smtp-Source: AGHT+IHTiHaf3C3Ox2evep1eETGadAR1R6osMNjc+B14tXzDp70nM+a8/XflrhMtyxUPyWcfS0RsyII5vvNO/L3tt/KjYM91klUI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13:b0:3dc:8b57:b76c with SMTP id
 e9e14a558f8ab-3e28d3e7aa6mr13274945ab.9.1752728161841; Wed, 16 Jul 2025
 21:56:01 -0700 (PDT)
Date: Wed, 16 Jul 2025 21:56:01 -0700
In-Reply-To: <gkct6i53onzjuzugsor6pnrhjfef7trwhgbjrgfie25xirebhp@dpqxvkguqdnf>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68788261.a70a0220.693ce.0039.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: vmalloc-out-of-bounds Read in hci_devcd_dump
From: syzbot <syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com>
To: ipravdin.official@gmail.com, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
Tested-by: syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com

Tested on:

commit:         e2291551 Merge tag 'probes-fixes-v6.16-rc6' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=103bc58c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=693e2f5eea496864
dashboard link: https://syzkaller.appspot.com/bug?extid=ac3c79181f6aecc5120c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1672e382580000

Note: testing is done by a robot and is best-effort only.

