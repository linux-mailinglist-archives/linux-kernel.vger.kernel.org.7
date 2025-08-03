Return-Path: <linux-kernel+bounces-754540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC37B196B2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 00:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 199A7170A28
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 22:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B741FCF7C;
	Sun,  3 Aug 2025 22:24:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C9E1CF96
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 22:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754259845; cv=none; b=aaXNOvsvwwQ9KbDL2mdBDm356YXTKwLVdwxP7vB3lrORWTSARAepxTyza6hRgf64kH2MRvsZ/mOQVTabvIysSM9bNIBR0Tjmfy1nHZ1fPnwQJ2pe9+Ag0RV5hB628r0HjZ1AV1iRGp79zTWdm+0N34ztOBIPeGGmX9XMQhnWIdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754259845; c=relaxed/simple;
	bh=vcQkASvZnFMoJc5zxxoo6Lc0Jk8270yPDWlCs5QFuak=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OgganUeV4FGG6YuGW4XuYdYJedJ/nYWLxHDLa9BkvSJkshuFxHyRuglTREgtBZJ47BCQM+j9RNAqfTjV3tU23EOvk/OJtUl0wUrMhpw+qJ4TiJfxbpheL/LgMNykKmBwXo3Dv8VIaax77JQqrlgMpuVwKvXhOYozkpi5EYRvxVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86a5def8869so839938139f.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 15:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754259843; x=1754864643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vcQkASvZnFMoJc5zxxoo6Lc0Jk8270yPDWlCs5QFuak=;
        b=fiCBaL1HUYYn6qIfB7fl9kjGM15B3Cbl7ZpifOZAaCjoTpYJuNzpi1x884whccN6r8
         ouNZ7cJ31lL5vUbtNwBFNmoYU7+i8ygED2y4VKRGtF9IFEkfOqGpDo5eCxCpH7+NhlQc
         QXlO8yfprMoJ3jOu/XqFOydnepwKLBap0U+Ho/llSsm5f8TgyG4xmWkKut/doOvYtJIU
         a60rMn0YCNCD/sKtME2zlAUyrVqxJHuU/5y9X8HmMDXr/8FOZC2p/Wl2rdSbrlJjXCXh
         KSnu0lJF2dWCfi728ql9Rz3jtu6rdflhMxHT6i3i3pEUuPJwVeTFMXX04sRoMgUKPfLt
         +NdA==
X-Gm-Message-State: AOJu0YxlsKIKwMx1ERSY6AE+ENI1fRyyqLjhTKGF+PgLeXAIoGwCg7no
	Ie4gtS+lGEBHDKj4gntfJz2ty1eRgmDdG7S/gWoVaZpMZmdAULBVIZdzV+tUfIoosezeg1Dz0Uq
	1yPJAPRMkuNznnMTIskMbOG+Csw+HmSnGOtOAzlOnJtb/325QQRsNqH8YwRA=
X-Google-Smtp-Source: AGHT+IE016/WCrq3H/dUGJLm3Pl5uloQUwW6hsi235zWPODX4m7Lcp6FrqjDiaK3CzAAUDqk/MEYuv1yWe0FfS1dtuZSG2TJNbnZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:9305:0:b0:879:c608:d1d5 with SMTP id
 ca18e2360f4ac-881683d6f7cmr1227210439f.14.1754259843397; Sun, 03 Aug 2025
 15:24:03 -0700 (PDT)
Date: Sun, 03 Aug 2025 15:24:03 -0700
In-Reply-To: <67bd6bef.050a0220.bbfd1.009d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688fe183.050a0220.1fc43d.0007.GAE@google.com>
Subject: Forwarded: KASAN: slab-out-of-bounds Read in fbcon_prepare_logo
From: syzbot <syzbot+0c815b25cdb3678e7083@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KASAN: slab-out-of-bounds Read in fbcon_prepare_logo
Author: sravankumarlpu@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
4b290aae788e06561754b28c6842e4080957d3f7

