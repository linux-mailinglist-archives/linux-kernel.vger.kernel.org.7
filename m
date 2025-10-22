Return-Path: <linux-kernel+bounces-864719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DDFBFB673
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D3484E4CDE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A741E318136;
	Wed, 22 Oct 2025 10:28:09 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93D42F2603
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128889; cv=none; b=SXAaJEBeZ9ebKadY4HudhFntIzYcjriPMX3fejElnDCBCBbQOWd6mVe2BEtb9+IIcboFvlsqawv3GGmPlTjtMUVoWvBgO5+U/xISJ1x/V2nbfvVCg14Wb8kWasRmr66ohVn5NwX+zCzSbPqb4lTXQoVjLYgXzTxtSL3+UCgidxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128889; c=relaxed/simple;
	bh=kdSRc2n+zbf34pa4XAwNzC2gPjF4Pjl/j6NHxK3mEDw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Iuxg6+0aO84JW3wn6QZ7M3ckO7aZwgQS+zbkr8rWpf22XM2FAbGyrOoUNHcCMPDse1D80CFiTE1Surirh81iqjNELydEKulUKI48BKQsV+mY/fSHT2Bx/9q3DAldZnBushQRYtYHbZ3K3WEs1gfu7xdsbERIfjQVKL2wAwLnnec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430bee303f7so208555505ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761128884; x=1761733684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kdSRc2n+zbf34pa4XAwNzC2gPjF4Pjl/j6NHxK3mEDw=;
        b=CF95vKDhrFRR7BW6qPN5hkCYoSg+8CRwuReVxYEfERhkaXb7f2lG464vt+JDiAXWG3
         YBDm6+GyTR5KiAB1VmuaXwimu78TfvnZLdT3FX7gV6OZKs+JBkZR+YohlU+PbscGNLVy
         DLGB99xm8owROHK8Ia0n4eF93APiAgSu6PN4pwIMT6hVLdQYhBC+W/01scOPcogZD0Vu
         S5ZVnMuHDvOOMjsUx6fZV9bM48mTmbSf8gC/9ucfXw7rrNy/+mojT38Gt2V00+5sMHN6
         gdHRORNRUH4pgJobPaaWuYZGeAhqOp2IxSjYQ6r2lYZTkS2X8+XyRPRH3g7Ka4O9jCTM
         Gagw==
X-Gm-Message-State: AOJu0YyhTpT/6MFVZQK+rJkw9lHUcOz3jaKiPu7x3szPcui1B1iJaZJl
	XjE4FboN4ari5fBCWaKc0UHqvKalGdRnAig1TIltRRWp0tc0zjUUNIA1M83Zh0XsTGxXVgcW0Zd
	vswJAxOXMYl+Qq+sMYeY7PcWmUmwewn51mMPw96UJKf7e2Lni+1oUJBjHDhU=
X-Google-Smtp-Source: AGHT+IHGf11YJHWG/Jb4GKBDhYF+1KZCtz0Ocqh5z/wnUrveQaw1WbaBPK3C/OL+88nlFiLm6QGrv6rcDPIsvV8qeE6OpOaruQua
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a66:b0:42d:8acf:a6e2 with SMTP id
 e9e14a558f8ab-430c5269283mr324677925ab.15.1761128884672; Wed, 22 Oct 2025
 03:28:04 -0700 (PDT)
Date: Wed, 22 Oct 2025 03:28:04 -0700
In-Reply-To: <66f86aaa.050a0220.4a974.000e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f8b1b4.050a0220.346f24.003e.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 552c50713f273b494ac6c77052032a49bc9255e2
From: syzbot <syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 552c50713f273b494ac6c77052032a49bc9255e2
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 552c50713f273b494ac6c77052032a49bc9255e2

