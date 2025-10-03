Return-Path: <linux-kernel+bounces-841027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ED1BB5FC4
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 08:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB26B4868E5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 06:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F7B1F63FF;
	Fri,  3 Oct 2025 06:38:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE3718D636
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 06:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759473487; cv=none; b=dt127tHl99cxppsmFq2ci5VSwgDIxlR9Qj+YVBUUoY4zE/dcGsulf7BOz4Iz2REXcBhqtq6JyMx82kqpWMXjUpUj1sxqiD9w98XWrPh93MmabEYEDc77fwn+fSfZ6M1stZSmNYAOLXsbaq4sJCnNylRZa5vpcp3xdByB3Jkz5mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759473487; c=relaxed/simple;
	bh=zgSVt6ZnmXirRAVFaMA5rvOiYj33xiLFBPtpGsGBF2M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XaBjLJzh37T13ft/14OVgjACE/LFd96ggZdbggs2gh/8C2Eli94oBq3y2E3R/xkxtGiOZ7FVXR5HvJIOu+f8Jm1ak6S2cO8y+0mhJTD67wRuwhaG2/pyitcaQ49Gn/iB6zmzag+qeD8Sb4C9WAzQkjSStZaIXx8aBOQPOvPKHkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-426d38c1e8fso20011885ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 23:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759473483; x=1760078283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OpPWCf4j8jL7TIJS4QPQMyVj4tLUl/7qVDJ4qbHDamc=;
        b=I4b57dqgvfjgh/PzXcZuQdf60Lx2VS/4j/6MqfoP5ABUJVTSuUNae1L4EbO5iUAj+H
         0TCEW1VSDNmPzraPZ7oXncDkn8Gv6HL7HnDSmjFg8CKGUb8GbKYYwnvNYZfoECPwCtdi
         Jux3F1k1HKinVvE+K7107j3PYlZ1qJM+BbciYLMBMtDV5lSBT+owr3tOO6AvCcLwsloK
         E/PvOR1lHtTQEN7LH8NhHSzGWImoov5CdoSEFFtY1k9/AGBVDrS6BefCsiWyWUSkwxJ0
         u/44V9qA+0kfErvZTA5X9KgkGBrHDhYeM1Z4w/SBcjHZZ6/JhbRG8sxunupgqBM8BfTo
         LYOA==
X-Forwarded-Encrypted: i=1; AJvYcCXsS5OAzxYh276tpqfDf/5YwhEkd7nrB3mOsQxTkFR2y0i7d0BnqIgloAAyKfFtQnz/kgundXxQE5hzA+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGpSWmx0OTRABv0G26RzqAsKZhjh8okihLBXMueFVVhaS7KtA2
	tecxQFQR2X7nAHzvTwyRmOjax2itajCmfUcC5XTs37mytkIpk3sACdobJJnWnG3O+lwO1AKnuJz
	V7YwFs5v4cfrroo4uZbO2nU0KxWVA8CLDx56IZ7yS6AmI4XzjYxF9SRl2TXY=
X-Google-Smtp-Source: AGHT+IHyqaVprIuYZE4qqauJjROKeg4e9b3+GgCYol5iZu2OagJx3foqLTUX/bwOComvZvS1DB25sIY2qCWurdgAYeCF4j7QfGxW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178b:b0:42d:8a3f:ec8b with SMTP id
 e9e14a558f8ab-42e7ad01f91mr24528435ab.3.1759473482760; Thu, 02 Oct 2025
 23:38:02 -0700 (PDT)
Date: Thu, 02 Oct 2025 23:38:02 -0700
In-Reply-To: <20251003061658.2515919-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df6f4a.a00a0220.102ee.010f.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in ext4_search_dir
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Tested-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com

Tested on:

commit:         e406d57b Merge tag 'mm-nonmm-stable-2025-10-02-15-29' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=134ad942580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84e81c4d0c0e900a
dashboard link: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=100165cd980000

Note: testing is done by a robot and is best-effort only.

