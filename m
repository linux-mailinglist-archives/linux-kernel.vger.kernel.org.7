Return-Path: <linux-kernel+bounces-849722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D439DBD0BB7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CA518953CE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF43A21D011;
	Sun, 12 Oct 2025 19:36:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AB934BA53
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297764; cv=none; b=AZpcrI/rpoJjLnYrrTRX4iK3qRLdnzoD6MIMOnaUvtcdrq2I0O3aJuAlRhlzQ2/feGbvsEwFJy+f4M6k2rkXWdCQEGPuifZK5SJwrUU6RyZYW3dguVXFjqpMF7mvWO/bddmD3M8/dDvA2WXa/ohl0R7GYMpm1ADy/H9+Td6zTgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297764; c=relaxed/simple;
	bh=bbAz+UnQBwKB/SkhKhtDHWDEOr6GM+CrsQODJwSlmyM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=E645VP5c8K5RuCXUQT5XDvNK2GBHGm3zmcotAlwt/lQ/OGOljdXi7oWsFRM9m64vRJ/lFhp7FhqGxv1ad1HQkqLF/1nnNFivRp9+sZJayYvk+dY4w7VY87uS/1px4Xuy2c6zzSra1aqmI/Zqh9ysHeg42f+FAWXlHbblHelibZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8ea63b6f262so2248677439f.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297762; x=1760902562;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+tWU7hca7Qia6AgYbQxTwRtnfqa7PHkj7qA5UkWnjxk=;
        b=SrSVpNI09uxPQYlEadT1AsgnM5Fh5qk1Xh9UfqC07T1g6Qqu+Uym3lBqedQvlJLjxP
         4YhU9K852seHuXf5tUa9eupHWvFVE/0e54mC7Q19zNadBYzl/qrhKGYNtcA82fl3zKLI
         i6g+/CisIZs9621xVDRer8SUpVF5DjMwSOtHh0i0gPFkVUA0e8IH1q/7IMMGIP6ZJSI7
         2fG3Jqwcvl3qQO/DRdezkU9WBsZvFxmJVrbTmAYvtbsrlKox5zqsS0fzD/y77lum4YLV
         EglNZi2qrG+jRn1XzsS/4duNqhFS9djSmLFsnVuZ4UTcDlYPhYflnXa/fz+60ibjNkSF
         vekA==
X-Gm-Message-State: AOJu0Yw2rCvn65Es5x73lCAbgvAgQXKxOgS9+aFcjhaHHU483QaGftbN
	q1pCyHiIgJoaV+w+fVFvCaBScrWzT7xDpLl+D3HqK22Hw+E8zU/qQtZmZ5NI4OasoGeFwd3GM7I
	x2LZN6lwk0VIi3P6tw8NtGJCS0FiNpakSSDY51PcogrvZHI1ueI99C5KeDpo=
X-Google-Smtp-Source: AGHT+IEyA3DhTXKkuqx/S4GaptQv/zkHdAqOL8NcA7Z7fEAH1uw8tas50plAQOJeFQ5vUWlWsvvRhXq412V3G9z6OL006qyH44FU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f8f:b0:91e:c3a4:5378 with SMTP id
 ca18e2360f4ac-93bd186b08cmr2432819439f.6.1760297762110; Sun, 12 Oct 2025
 12:36:02 -0700 (PDT)
Date: Sun, 12 Oct 2025 12:36:02 -0700
In-Reply-To: <aOv1RisRR1z1JJ1M@rpthibeault-XPS-13-9305>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ec0322.050a0220.91a22.01df.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] KMSAN: uninit-value in ntfs_read_bh
From: syzbot <syzbot+7a2ba6b7b66340cff225@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, rpthibeault@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7a2ba6b7b66340cff225@syzkaller.appspotmail.com
Tested-by: syzbot+7a2ba6b7b66340cff225@syzkaller.appspotmail.com

Tested on:

commit:         8765f467 Merge tag 'irq_urgent_for_v6.18_rc1' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11cd067c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=39fff07f4c8dbdba
dashboard link: https://syzkaller.appspot.com/bug?extid=7a2ba6b7b66340cff225
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12535b34580000

Note: testing is done by a robot and is best-effort only.

