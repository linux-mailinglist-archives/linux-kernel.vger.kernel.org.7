Return-Path: <linux-kernel+bounces-863151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2591BF71E9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 184494F17CF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B593F33C516;
	Tue, 21 Oct 2025 14:41:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02CF338930
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057666; cv=none; b=B3RgENVOENcLBiv1do83OvqnKJet0NHQKvzTsUI+t5DdKNPCwPRNJVJRPdHnw6Nhm3FxdSPRwqq2aj9EHiRgv5/Yr23z9T8ZVq2UtLvy/NaUynjHdh9l2lXpmUEWdpIHILRxcoAnNOeQQ0sLfwjHsV709uW5eKSj4KELw0KuX6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057666; c=relaxed/simple;
	bh=AEszlFCxMR5uhRk6+120zl9Te2bpwTwFlfYsrq16lRA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=au/6f4wni+LM40F3mcygz/dOGBjS3mq1LuhdwJJF++CyDtAYqrbapx/7yx5yDirCrvqIMCCaTQBd4AkFrpRy84ZwyBK/gDXYi5fkOkh1DrGNFMEvIEWlClTBiOkFAKHpBLbs39V7v6kE8/sUMSqaCHLgOQIcmp0rxm2MhWE1HZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430cafce20bso154050165ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761057663; x=1761662463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCh8ldexXBFVKCv+pScotiyBcxFC4clXu3jzr4tyGgk=;
        b=r6mjKblMvgfm8leBrGttSgdSa84DRaIaZPw+0qqf1CwW2YmRUKLGj4NKc7zPztgSPU
         uzqGKHh2Uy21klSEd61/s69hW4nn5gOpie+h50fEciYE2tdDL6sS7Xv3iwF64ujmT+K9
         XGXi4ycYMbGZQtmXSccA/iLo/jvAI6GIL+dhbc1JevGxQ5JKz4r7kbFCVRA1PZhfinUQ
         Lb78UXDqOfG9fW1lTYRgUsqrYSKJfJkJjvX5fuPaG07v3Nm+Y/DcJKXYys3p3tvt3K0X
         2q+5X+9oKV9/JFEjiDPbjrnCGWk2lcJfDN9MHtT4T10uK+gjhzVFek/zE5j40DGDn7V1
         qZHA==
X-Gm-Message-State: AOJu0Yx/W0JNtPkHHpGSE7ETtAoIqnWJ7fiBL/WPWKQqgStPBlVwEkB5
	3eCVckISzAE5lWJ619NQLmEohtP3zEOKsqnIx6RZ0sTSf4MvYkPttn9w2Rr75y1M1iSmIA26cKn
	kv/gZMsG8o6lQ3JIJp2IPLEyAyEbU1QMUnYO/20GsU0kq5t7RXpdqxBRLJLM=
X-Google-Smtp-Source: AGHT+IGF0p6J9sp5Ud+8OmyvSs+uq2ma1QuMc6bXSwXonO3WfyhMTEk7y7/0W/JAjdOFn5qQY6aD+ImYUSAVsjOzc9MxJ0PaFjeD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e04:b0:430:b999:49e7 with SMTP id
 e9e14a558f8ab-430c5291223mr249349255ab.27.1761057662910; Tue, 21 Oct 2025
 07:41:02 -0700 (PDT)
Date: Tue, 21 Oct 2025 07:41:02 -0700
In-Reply-To: <20251021122436.160398-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f79b7e.a70a0220.3bf6c6.0007.GAE@google.com>
Subject: Re: [syzbot] [comedi?] INFO: task hung in comedi_open
From: syzbot <syzbot+7811bb68a317954a0347@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7811bb68a317954a0347@syzkaller.appspotmail.com
Tested-by: syzbot+7811bb68a317954a0347@syzkaller.appspotmail.com

Tested on:

commit:         fe45352c Add linux-next specific files for 20251021
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11e30d2f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=122d1f1adc0d9241
dashboard link: https://syzkaller.appspot.com/bug?extid=7811bb68a317954a0347
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17b21b04580000

Note: testing is done by a robot and is best-effort only.

