Return-Path: <linux-kernel+bounces-845825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FE8BC63AE
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 20:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003341891F89
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 18:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1BD2BEC42;
	Wed,  8 Oct 2025 18:01:12 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D601E47B7
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759946472; cv=none; b=UIgR6N+/Fpv8adFClwEAObHYf8Gp6767+aKT2/M4zORCfsgADnu8JGSRnzFMQu/OJRE26P7ixolDTEb4zBNp2etMuxhqpgOaUebetlNgSaCCZQ5unv0mAUwNnI/l29l35l+epEY4Z2h9gqaQHW4UG70zmbYwMW43YZ67GFjQ6Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759946472; c=relaxed/simple;
	bh=pI7fLehoY1CfaaZE3iQ9xpUMxcFN2Y9BBaLyAUo4M0Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gB1tM8c0JyTAAgCsbxH3xTkfjd51zJLfq0B1MevlM/tzlIDv92Prpa1PUB3vnsqA5EpMp01xHqD73EADY9g24he5FxwIgDU6IpMBMGiFkULiiLqKozYtUdytR+d9CxEITTebElf/JkfADdhEUF516m4EqGA8nz+cu4dwEa+pXeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42f911a1984so1826435ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759946470; x=1760551270;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pI7fLehoY1CfaaZE3iQ9xpUMxcFN2Y9BBaLyAUo4M0Y=;
        b=TcLdybSS02nXEykDwMrLt1WJCwVhZhK3CPa9Y9AN0A/VO47LzhgZZAq5smaO48/WD+
         DCgO5KzxrT3KGPMyny75Bo+xkjC0eLsvigSBM3F6I3bhc1rWb8X+mtnC+bZJSfnGjTQl
         MmHqbMAn3Io6oLU0zWw2mmvcQeHuud4Dl2Vsq76fEObhl7IT8B5qszupZOMfNDrRfLKh
         Ulu45LYb4kTwjpcmdoOzysgGNiox7TRDxENj2hOBqzr0GP4B/5YYa1Wc+auImeaH2A5U
         CqfazTNfZvGvWqcCmvkKMtEmsPCH2E0LID3K8lRIp5mQpJxBOBHmj85kF/AR+KOOtApz
         7tVg==
X-Gm-Message-State: AOJu0YzJjINwlVRowCoqoFxvIc77+L8624ssuDlt47NweSVdcsYTbzrr
	8HQCzgVqxxhguWRDI5yOaKAxHzrAYRIQfe75mMo0Fp52S3iV10fxa/0gSAUBgb5g/b0b6wAAERF
	E36smoOJHvTDrqOAYRrd1DyngWz3BEeyqO4MxwfI9Iu4KjWemlebN1+rR6x4=
X-Google-Smtp-Source: AGHT+IHkMUqLGXkucdctA+OHMCJlQs5GkN1m4I51J3a5VFMgjL9vZlhWkkYONieQK5qfuI6zfTk9MExxabyfdwmPpLLTiSnSrHlh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda6:0:b0:427:c8d1:bea5 with SMTP id
 e9e14a558f8ab-42f873bed54mr37865345ab.21.1759946469862; Wed, 08 Oct 2025
 11:01:09 -0700 (PDT)
Date: Wed, 08 Oct 2025 11:01:09 -0700
In-Reply-To: <66f6bfa7.050a0220.38ace9.001a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e6a6e5.050a0220.256323.00d6.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 0d97f2067c166eb495771fede9f7b73999c67f66
From: syzbot <syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 0d97f2067c166eb495771fede9f7b73999c67f66
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 0d97f2067c166eb495771fede9f7b73999c67f66

