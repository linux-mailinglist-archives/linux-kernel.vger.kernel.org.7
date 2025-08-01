Return-Path: <linux-kernel+bounces-753874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EB6B18949
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 01:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B261C83B69
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C542229B1F;
	Fri,  1 Aug 2025 23:03:26 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A6A1FBEB9
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 23:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754089406; cv=none; b=dvWiBGuY714tECzxcB9i0I5yg88DkDpF7qimug6O+DPz6CRANmDuuhBjU0PKvN/nxsWQw4nAZrkkCduPEj8hhqagKinKGKtImXEbOpTDJB0wjydFNEUiS/y60IuowiAMW0gVQ+xQDZygbU4KyajuQZ8JcI54VClgMPhRyc6zyyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754089406; c=relaxed/simple;
	bh=q1MQoUZ2fw4i7FE4h2aTuz6EYy0Rva2lVL6CkEpBH2I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=B+PNYK9D98OwwxBB47QU8QQedP2DITqM41Mie8uokiLXhPfdPtYwzyNSvPWUTDJfacU8H0o6Hpv2zY97GYm0rOA0ZN3hGz6OVU/jvoKIdFxTR+ThMXMNSYPXQBtUZENMCiXR4ymd4XQDJSfe2vUFJKO6cFBe13mA2gmQQ1rNh00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e3e69b2951so23915745ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 16:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754089404; x=1754694204;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGHnJhSMxDUHdLQIm23RXv43fzesIQbII67l5jsl2wM=;
        b=XnG/82kiorHgiDeh75NNQexBY9yzBhZW54Ex8MAdBFR6T6J0/O6BmZU/f9ouKD9f6j
         5HZIxq0mWZv2RKihBlZah+4hISV77XlVzDq/ZYsAc3SI+JHGI/HzCrCtPIANH1iEBl/K
         uuRiuQxFJKv+jj7qQKajGcvDIeT6pcIvCY1c6yT61mcV87h21TC3hjcX7ma4VCxIshMK
         wYZiBBB8jFhaHogQ0auMDUa12EytqwOhyYCyOydnwSOgV7OPGqBMIky1PTPNssFSkAmX
         MRJzAZJ1rMbBOf7aUnB7BZ+0Qz3pMGalzdJNTiOQoR0/v8ZJy/GOO7nAsOkay1B87/Sd
         JAlQ==
X-Gm-Message-State: AOJu0YyIBMBwh/US55rVXcW4Sy3+In5bTMt3TVmIpMdt4+V3qapdtoa8
	6siK3TYrRVnNDaorcsE/E6erpvFc/8TumCPlvvxrIj906AIHXPVnJAcNNRX/2za2pSblsEEilmH
	iwSKd2BRIQSv8G4DmtfDwb/Nnb6MKVZpreZ6HHepRZD4UrFKDbO9TJIhtnyI=
X-Google-Smtp-Source: AGHT+IF/fYdhSAy0D+e3B7xmmtdkryYUBdz1OsTnffevEbV+b0IMA2bfsgxxEW6RoT4AOnu+GHtt8xZEidLsX98u72RmNFn2yxF3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:351e:b0:3e3:fff9:eb1f with SMTP id
 e9e14a558f8ab-3e415d750femr30442235ab.2.1754089403952; Fri, 01 Aug 2025
 16:03:23 -0700 (PDT)
Date: Fri, 01 Aug 2025 16:03:23 -0700
In-Reply-To: <688b3341.a00a0220.26d0e1.003b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688d47bb.a00a0220.26d0e1.007a.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+9eb4c69fd4d4a1934f3a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: btree_check_root_boundaries()

