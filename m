Return-Path: <linux-kernel+bounces-730219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34F2B0416F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9C716FA19
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CC92594B7;
	Mon, 14 Jul 2025 14:21:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3F7254848
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502864; cv=none; b=NoKD/wC4VH7RF5LD54B3eLTTC0SkzhoTvWKaTibp+c4FuCPrQWdtH/nzYfL2DX37PEaRWtZRndAckS5IuAMSP7pcAErqBHJHip/6ChmnzrSbheLI8duN3WIZJoWX+0UEUA0pMaeQH8HjQW4BhFVN+DT95fICf4V66Yt2MEok/yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502864; c=relaxed/simple;
	bh=BVOInpbtk0Qig8X2holu5imSR0FItlopCBIjw1I628o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eapW1ffLHipPYN8l+iYjH3VFCR6KS+tHKxkZTy+p7TyLtG+yPBf7dUqRWiEGU4/ja9n+HK1HijsIq0Le7jgueqwA8BqSCnNTlhp4HH4xqeWwSurFo83uHp9petBPH1J03AY4C5bHPhcUdNH85pYKr+B5wErlaSyfG/1FxcGtYOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-876a88d14baso882974639f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752502862; x=1753107662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Qqgiq8JxyEcAgDrZLb+6D8UwLrwRRPLE/xGlnoIsFU=;
        b=S/WQN69KCKhDyq1Limz8NDYbS5JZ97DYf2r3FFLzmDapo8VXr4fL4bX7GoZ/UOj+UN
         7Ky/wz4Mk8Z1qgxK7fB5DS5g8Ud55jsQ+yQIUnZE1wzPmkJDSAiT1B7ciGNWkHOH1ako
         Q/7hkxG1s1/XaPIY9WoXEaK/zL7O3Rm81QxLxFzgEuOa3rnpWrQadOYzdzynX0s2vM+X
         6lr0r9zviHD2a1H6G8jvAZ7I+fG8rrISAwKNQUY6sj9/C+g5QKyI5N3SPCsOdp1e9Hbt
         SVxvQb/7Hwzqs+Wzd4HE5pgKisT9G+9eFF8OfclTWR+GVMQ+4RKpFvNjO+FwoGDros3q
         OxwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXo+hPRn4+L8sSpuGfCer8kUmUlsIUL6AXasLsyWcx0NwAgMuvHTHbYKJXbc2G47FYmsUJgnc2DIKWzkmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVAt8wvTN4DzhAXBCRFxJ8ge/jSL35YLneFPyYhmmuaNw/WPnP
	iOD9+P8IqzUtVqVg5rxN62nEMpnhz10lA68wPpGCpmd8Mu8GybUOPRQHIJgDf+WiOGqNL4P0oL0
	tYika8alufd7btXPCc5R7nnkYA5DszseC/VfrBtbaOmGI1VJQ/y/+iip0Ggs=
X-Google-Smtp-Source: AGHT+IGSjX8dQuyeF+nrdRxt2lvfKv070vfD+xMFqoSuPZlV/8eE5ffgfNQmsMmBill3U8kjHbWGi/Yiq1YgCqNWyw/IWLC2bkZV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6808:b0:875:d589:5b0b with SMTP id
 ca18e2360f4ac-8797aa2f686mr1289387039f.11.1752502862398; Mon, 14 Jul 2025
 07:21:02 -0700 (PDT)
Date: Mon, 14 Jul 2025 07:21:02 -0700
In-Reply-To: <861pqiaojt.wl-maz@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6875124e.a70a0220.2b0948.0001.GAE@google.com>
Subject: Re: [syzbot] [kvmarm?] WARNING in pend_sync_exception
From: syzbot <syzbot+4e09b1432de3774b86ae@syzkaller.appspotmail.com>
To: catalin.marinas@arm.com, joey.gouly@arm.com, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	maz@kernel.org, oliver.upton@linux.dev, suzuki.poulose@arm.com, 
	syzkaller-bugs@googlegroups.com, will@kernel.org, yuzenghui@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4e09b1432de3774b86ae@syzkaller.appspotmail.com
Tested-by: syzbot+4e09b1432de3774b86ae@syzkaller.appspotmail.com

Tested on:

commit:         e62014ac KVM: arm64: Clear pending exception state bef..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/df-2-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=17d1918c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4b46866d7105151
dashboard link: https://syzkaller.appspot.com/bug?extid=4e09b1432de3774b86ae
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

