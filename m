Return-Path: <linux-kernel+bounces-754480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C47B194CB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 20:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4375B174281
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 18:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E102D1ACECE;
	Sun,  3 Aug 2025 18:30:27 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311C946B5
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754245827; cv=none; b=hs0+jqes1ndGXxuZ2IE2Yzl2LTqnhV+IChY3IKdBo+IgdMVPoJATgWfOV6Ew9niBoixWDAxvWcWLKHEX9z9Mx3mjCASJDeSLGh50sobBdaDPVrw/OOEtdcrr771e0V1ibujo4BHNus23k0MqVe0BaRDXUJm9CQX7lOx0tzb7UY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754245827; c=relaxed/simple;
	bh=8j1dSPuKgblt3b8yHsDRBQzNUtBOlAzabEVba9yrofE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S8xuxPsMCpDW88tCI20r/M2eGIblt1pXe1iwETMBwicQ6+vUG/S0G0QEGhdR3DeQys82A7omt7VAPoIUOmkXqHvNfxJ0MLIi4lHGfSFqoHt0m/3baM9//onKk/49oOmFTliDiSfE6fuB+aVfUZMw+2TKLHn1EnJxoQhUDKgNN2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e3c9a3f22aso65928805ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 11:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754245825; x=1754850625;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w7PRdkaUP0vQN4vWEONyo41ykjYWoG+Do0IVGF/8tlw=;
        b=OGkpY2blF53pBJQp4OcCAACGmq8nGcl54LdY6RPmlmdOnfFpA008KcH5SwbOp3qnQ+
         ZLHnu6LEkh1OnZrCCdvuGCXRQ2loeqif++3PWbSaUDGucP2b+VrPcQWFH4Pv3gP9rlZE
         H8+F0/YRVcVHu8EHEvfNtgrBtqnTQODl0pqydN/B977rQpy8luIiznQMtSN7V8qJ8G4k
         pBzwFtB7uM2/mqj0ok/oHlIkfjThT87XS1VPHy3J61z5oTmpceT1r2xEUnerBnxuM2zR
         3/XxvjvY+1uEzRiYpGvNlYrdaSyPAYOSTxH2zcoLF+prKNtNc5tRGO0CC3Gcc8N/i3Tr
         6buA==
X-Gm-Message-State: AOJu0Yxiw8QOF40KVS+wJUhr3tE3CFRjEI6V0m/65GMdQt883a+i5+SI
	eXCxrnz4fXtC8YOHfMsi7W0Iem2SipqwRiStdmZZnjQRwMOc06HnZ2GLAMxkyKnySxdams46i2p
	wRfOS8Hsk8JHJHu4kJIbGqtd/VjrT7UeA7xjJZ+TbCIr3zB3+ZO9SoDx/oik=
X-Google-Smtp-Source: AGHT+IFQl/BXL3aZVeaNgbizbhu20QwePYTTEJgZKCbh/WRUP4MO6fyhmkW9T0l9TOsiM4zNE7G9+VMiTjw/aqbCci0T2MQ8XyOL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2219:b0:3e3:ff59:6906 with SMTP id
 e9e14a558f8ab-3e4161803admr109281565ab.11.1754245825344; Sun, 03 Aug 2025
 11:30:25 -0700 (PDT)
Date: Sun, 03 Aug 2025 11:30:25 -0700
In-Reply-To: <688a8cdf.a00a0220.26d0e1.002f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688faac1.050a0220.13f73d.0004.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+d3fa2fb715cfcc9d201d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Fix incorrect transaction handling

