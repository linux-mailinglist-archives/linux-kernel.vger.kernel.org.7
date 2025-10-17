Return-Path: <linux-kernel+bounces-857949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B07BE8514
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F39418840C8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771943451A0;
	Fri, 17 Oct 2025 11:26:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84678343D8F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700365; cv=none; b=brLFg7yHWeHUcluud4d6DMOQnL7ZxBBHDxyOQ6coLmSl7nqc4J/0bBmoTQ+iZtAIMdmL0dIMvpoyQemqRBpAIgNQFtRPrAwsK8zkaHPxIVykwyMdsooa0AM9WeN5+JlZ7e1KAdMj9NBjkixc1IFcb0ROPWhQUM5MNgUwIHyDNSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700365; c=relaxed/simple;
	bh=1MThs79OKYHqj9DZO2UpepV+2jm7L4LOJ4PO826Wapk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s0HGf1/0a58HPNY/tS6exkS8FAwcxFHDpFp3I4zIZtpnotPvVAjp2ekhuN6fBmz+xP7EP6gw6e/IKFHcrjAlNxtCC+VEw7r1Y67d20OP/hINJ7/lsHooptXFx46HsZC4i/gBZj1QZeeebzmX/lGGgDHkB+BGaF0Rtn7FWGnWLi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-93e7b032f1aso47856439f.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760700362; x=1761305162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MY72UhKs0CgDuuzl0+uYHVQxX1MwW1PLrShehamj9k=;
        b=dUid4BqCWoUojILYm1nS1XjcufwnkJ5hvgMZa4aQuzQJO25PoQOH5xCYpx7z1/heVd
         QnLspWJBUXqxMYoo4E+gi7PCdEe7Joz1bP/PyDod75CEoGF4pIQe0Z8GAPV0Ihto6L+G
         zf6U5Xe+QYIL625xf6kjbZNF5YMlbgzDo/+GWXmKw8E+q+B7+gV9hacsjN5DgzpvX1Wk
         tnL8nnQW0vvRHnXxvnSJhlUwu5tsd6qGB6lh0erFPM0B22HFHuKXz7aEFrFv4Bqau/xV
         rURR/8LEM9hssGip/R/EhRJuh+60eVLe2WyE/vbwrzOKfSiTOSAtvjpx6WFpVs3ayWWl
         AWFw==
X-Forwarded-Encrypted: i=1; AJvYcCVqwD5uVUWxx2zKiTmp1NW0AlAh4loWUVagYSNNNXho1zsl8cs1uS6AklY9kfpXjDfab72DuxlvyWeXqB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Se9QiY3WPC+AlHvjfPiXvreYxM2BHykQw95ygrqV9xqdNNTW
	2nYKw117V9KUcMV2sqzHjg4lGzqhysZ8Rds4NCUh0zvNi2G8ipCbOArRPgF1zanLCzEmtnOUGz/
	nTLuS6WAW8ATTDEWJfcyfX2sZJ/MHxflSaqtKdbFfCvzDKyuwjbQI/xLwVSE=
X-Google-Smtp-Source: AGHT+IHAfen7ewgxq7v8VDJAdjXprtkrHIbsOFTJO8nWMMsHNOrIU20Yc2LQVjnx8fadlcC4JgR/1UmJG8KH25Cst5GGrB7dN9UR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3810:b0:430:ae84:d126 with SMTP id
 e9e14a558f8ab-430c524613cmr45975785ab.4.1760700362601; Fri, 17 Oct 2025
 04:26:02 -0700 (PDT)
Date: Fri, 17 Oct 2025 04:26:02 -0700
In-Reply-To: <28b06392-394e-4c77-a4db-5174cb605834@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f227ca.050a0220.91a22.041d.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] UBSAN: array-index-out-of-bounds in ocfs2_block_group_fill
From: syzbot <syzbot+77026564530dbc29b854@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+77026564530dbc29b854@syzkaller.appspotmail.com
Tested-by: syzbot+77026564530dbc29b854@syzkaller.appspotmail.com

Tested on:

commit:         2433b847 Add linux-next specific files for 20251016
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=106275e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76790fe131481879
dashboard link: https://syzkaller.appspot.com/bug?extid=77026564530dbc29b854
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=137d9c58580000

Note: testing is done by a robot and is best-effort only.

