Return-Path: <linux-kernel+bounces-743471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DACC2B0FF12
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 05:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D7CAA5A55
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 03:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9381D5ADE;
	Thu, 24 Jul 2025 03:11:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA01BF58
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 03:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753326666; cv=none; b=nSpGPvYfb+R7O/tfAaACy9L2YHOIqWitzkhNtJjFmD0S3fSlodOZcjp9AosJ+3QP9CkJ8gsE0MhH6GZcrq1FDZ3067kqfJkDDnGnDKiRBNRaRJ7iUSRj1y+Y/tvS4wf82lzgmQxLxcWFR6uAzlhYLqF2AQN4PbEi/YvNiK9MB0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753326666; c=relaxed/simple;
	bh=ppkZauOnIMMhCt92cbaCJ2V9NqxRyAGbfYRw230lgDI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oW4Q/0+NAezWQiPoFTnRl1nLfVZlyYaFTLkcA6nuiwd12m9eizRgCslViD4Bh8UyDnFRI0tqoD/qQI+Idr0wjO2VUxccitXt61QFfrFdVF+8CoFUvb0IHpF2i1wK4WooQsOYu+uCfH1eqGALAoq6JUtvhVCC0EdD4qpbs6e2rkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-87c43c2af72so60863039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753326664; x=1753931464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2g0g4o9qAgNnn88eBiY/4X8zENzwThbJ1qetXt33sQY=;
        b=bpKYnCyjC0ZYpmywoFg4eF839eJiSOJ5X0bdH5ZnoGQWnKr+vOGGrHQJ8MuNoXkVbD
         Rvs3iXwaWkDN7EValRQAIMVnuKBwCd30A+7ZkJRzGzunhCZUjUs1uHc8NZZXyUE3APHu
         as9107f6R1FP4IdQgQSczWzq5Z1RwDnNKLR4NPXVZJyDq45AJ+458k5rDODqtRLVPeh7
         FCZxvzc0HrKA2yUqytSscZ0AI823z0Dn92pz0Kc3/mjv18hVVPtjVIAbSQ17VoXHP8vP
         AaYdIAjYWt6AuA4JvKa4ZQrcqiPcCoz8oNxZPpNUlJYb0g/c9C/JQHIXpt6TZfnhxY3X
         Fwkg==
X-Gm-Message-State: AOJu0Yzb1LWKUzc7QWQpPUFahfi3R/Nnsw5uzJA//9X0Ubne3dnlgPeB
	F11tG3iiowZnqWbfomF6X1oLAwALwnIo7DoAtaXmITba+T7F9jabYuxLMkzyCb5fDIyBubQZdOK
	cyau7E61Xb760gkesqKbjJJgmlHf3HDkPEOTku/Guwf0FgTJswQ2R7RY4Sbs=
X-Google-Smtp-Source: AGHT+IGTLEzRUfqLbo9YAniZLfHbfL5HFZhoxDeBigOVp3oH7zPEKxgR0TPIvcYykIWyVI33fSpQwlfMa3j2g96OueRjdwd+/8jH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0e:0:b0:3e2:93c5:95eb with SMTP id
 e9e14a558f8ab-3e335502d68mr100703495ab.21.1753326664403; Wed, 23 Jul 2025
 20:11:04 -0700 (PDT)
Date: Wed, 23 Jul 2025 20:11:04 -0700
In-Reply-To: <20250724015303.3332384-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6881a448.a00a0220.2f88df.0009.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KASAN: out-of-bounds Read in hfs_bnode_move
From: syzbot <syzbot+41ba9c82bce8d7101765@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+41ba9c82bce8d7101765@syzkaller.appspotmail.com
Tested-by: syzbot+41ba9c82bce8d7101765@syzkaller.appspotmail.com

Tested on:

commit:         25fae0b9 Merge tag 'drm-fixes-2025-07-24' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ae40a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=859f36d9ccbeaa3e
dashboard link: https://syzkaller.appspot.com/bug?extid=41ba9c82bce8d7101765
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=150160a2580000

Note: testing is done by a robot and is best-effort only.

