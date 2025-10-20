Return-Path: <linux-kernel+bounces-860710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A85A9BF0BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C595189F6CE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1892F83C2;
	Mon, 20 Oct 2025 11:11:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEE925393C
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958664; cv=none; b=ccd5f1fZlMprQ9L7ZpH0f3WWuDZl20zjBm6AyI3bGchrClPnoUGNR8vqIcaQiPCh9JYyCAuWxlmEaJb+jr2qsuvQq8VsCSOHjOWMQh7P6yUaWVZOxwqG1+jqNSeJeKPcfXiJKCKk9nRpCWHco54lzSzMOc/1snm5G2NXIL0YdU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958664; c=relaxed/simple;
	bh=CH2xljU6c9gBVw3DBYilV6b30fXLwpU/kbNwbZ6SgBU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dbcioubqQA+S0uzas+PKOmfWEJeB/NEmSkR92kLk/2dlFrWEDD3rmL0rUOUH/KgQAmp0WDSJko8xkOyt9ieyvIOhz+jFSnBMmgEO6kMuPwuMeMIndSWoK8GghS8u3YWo/RvuDsT4qnmMCKXrloR90/ujnYzm6j05Zxg6Bqz5N/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430afaea1beso49804945ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760958662; x=1761563462;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uliS5KAsmEXDUool2RAPHcmNHkNEm5clWmYl07NQfQU=;
        b=cYVSTjaakP9S8z7m/f0YUJAlixuVUkO3LODRgY49fTdyCLsQS4pZGmO8dZtGYTN7eH
         TY+rSTJhT9e+eY20SL0/TMncMpjZN/kb2nyXT/Ss7CTuKAZayH4nZ4NxrAAWSK0CZjYh
         iSZb3Z9Wjrmei5UY6iLt70QqUCuR22TCzsCLMBlfxuUNGlXLAkxRKqC4LiMXu1NQZmZe
         pePbcTedZovkJktRzuWZApn9mE9Rlpx11Gn18kl+Fio+okGlcEbPrcVsLCG6Rcn4/0x2
         5Tg8I0OxTE1GDfb+gmARP73tkk0F/jbKIA+o0TlmJK6P6LnFUUW1knzab71XbXj3Ofh6
         COBg==
X-Forwarded-Encrypted: i=1; AJvYcCVEaqtRx1C9YHfpSy5u6Z6+MbkUsFKZe3tanI6CIbAu1u8YZuCxBzw2FFteCp+gz3/aEHj2+bnHjowOqEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxati7osDYA1u/FGnxvgJNNINsimjscVLWNqN3fFdEjIEsFzCqA
	829OGMeGZHxpBVHgjIo5kcu4eeygskgChqbbIkCmD+Hvesv5VgBhIlOKJrsDqvZRFmvnRMaS7CY
	vB61MkWhRXsRwPfv9v5Ti48ONRJxfqCFNbUX8nDfNreOyA74FH6X//HT0dTU=
X-Google-Smtp-Source: AGHT+IE/ROpo6LHEeOcBWN0ivTLEMcXq4KFme42u6PZTPiM2Pberirt38qlSz+Z+A++Pk+xFObHIl7Dr24KBozJR4mzaq3Y+ny6Z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144d:b0:42f:8eeb:49a1 with SMTP id
 e9e14a558f8ab-430c523d6fdmr205757645ab.13.1760958662386; Mon, 20 Oct 2025
 04:11:02 -0700 (PDT)
Date: Mon, 20 Oct 2025 04:11:02 -0700
In-Reply-To: <a9cfa569-b234-4ad0-b2e5-1a227e7ea9ac@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f618c6.a70a0220.205af.002e.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in __ocfs2_flush_truncate_log
From: syzbot <syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com
Tested-by: syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com

Tested on:

commit:         211ddde0 Linux 6.18-rc2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=153c9492580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c601ba0b0d071c6
dashboard link: https://syzkaller.appspot.com/bug?extid=4d55dad3a9e8e9f7d2b5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15059734580000

Note: testing is done by a robot and is best-effort only.

