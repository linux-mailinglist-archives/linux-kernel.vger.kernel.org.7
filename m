Return-Path: <linux-kernel+bounces-845328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D492DBC4744
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A96364EB931
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6DC2F6178;
	Wed,  8 Oct 2025 10:52:17 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF242EB86B
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759920737; cv=none; b=jBONGwTM/2aBgwer/bEbNpkQ+37OgqvsxijZdi+/+mazx/W9H6KD1D49P2kQOtDEWWe+eM9C0nReQjg267PADxRGxJqn6vT20zVJp6Ft4UiwyVbd9v6tEuEPHfgMb+ZIW0epqsHulKUrWR54cufEuHuUdacr5sDSoQBw8dGaEic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759920737; c=relaxed/simple;
	bh=pI7fLehoY1CfaaZE3iQ9xpUMxcFN2Y9BBaLyAUo4M0Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=avCpOVTznGwdSGIc7iPVM8FyPN7/SVZ1vyiYoWiBBMUT5zlThr/tzJyrJVz4RxyniQi4DWHw8VCRl6Kmu7lC18gX9SYwPgWL84h5oWM++/8/XLmrzePxZLqPmSTf/f5jEPS0rtKL1rgMcOjtvfdhfUXC1dFPctBLtQNcqC0xwC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-930db3a16c9so741930739f.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 03:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759920735; x=1760525535;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pI7fLehoY1CfaaZE3iQ9xpUMxcFN2Y9BBaLyAUo4M0Y=;
        b=FL57TaiRVKQXC2SpRxuiR15hrLFOWZC3b2ToW7CbJXn/mlrXFet46jKOdLivRVvXB9
         Eqc775ws+LsnpmE6pT1ltP1zo6KPpUtF2aQ6PPTuzJZ9dSnBV8o8XnQbT5nEkbwKdoP7
         10cWPXo0pKbvdLmzhrE45T+LU+Sn/We1M8Ani347MNHwO/SIVvaaGEa54kVTbiFca5Rz
         zi1vEJzTENpf1u0WfTR4VsrHZ/C/nvGGq54qWs2Fccx/GWZ5th3Uxd6AdFbxN4eOYY0s
         jvEqHKGFG/lQ8cEC7WDb2WiEMXQpe4Ob/dt/kYqLng5SJOrRlCw7pPW9TWed/T4WUGIh
         7V3A==
X-Gm-Message-State: AOJu0YzChww04TTGbc9kfQXQFiiBo2vhXwnHa6klKDB9Ka1L9KTgRDzi
	QIyHJiOGH/1MP7e7IebhlUvtpOQDhNS4zq8c3pkz106LaATg1TNwQdus0Uf7WAgmDtfFyEpeEBd
	rTO8BRyMTP0f/kLKlYrRgfWNxFlsSLKhiZs5SIgww0FokBGB+mr04etHhpxs=
X-Google-Smtp-Source: AGHT+IGNFnJ/7Dm5kyX5cW//nOOmPcgldelSs4uMR2kquhb1zfIJUHkIcb4XCE9slUlAuoe0Hf7n+1LBxw9H/9jTHImFB8PDRixj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8d:b0:42d:878b:6e40 with SMTP id
 e9e14a558f8ab-42f8737f064mr24808655ab.13.1759920734892; Wed, 08 Oct 2025
 03:52:14 -0700 (PDT)
Date: Wed, 08 Oct 2025 03:52:14 -0700
In-Reply-To: <68e48f33.a00a0220.298cc0.046e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e6425e.050a0220.256323.0038.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 0d97f2067c166eb495771fede9f7b73999c67f66
From: syzbot <syzbot+727d161855d11d81e411@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 0d97f2067c166eb495771fede9f7b73999c67f66
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 0d97f2067c166eb495771fede9f7b73999c67f66

