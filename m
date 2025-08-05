Return-Path: <linux-kernel+bounces-756687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2D6B1B7C2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 610D07B0818
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAAA289814;
	Tue,  5 Aug 2025 15:46:31 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1823255E20
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408791; cv=none; b=WkTRL0Vp4LthDfy5PZiRqxwoshj4FPmQKEu0QvdMLo2YNHw6iCM/A5K38/Kld6QDUsbn+mxJ2UF8hBSqunJVR30iMsvQURD18HISVXnZkran8AOCyTtolnnMcvxREiqN3SlgtSisJUzIe7PLaJRgSxBrZSiE4cClfIvu8g9JeMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408791; c=relaxed/simple;
	bh=Mi9XNzq0dQ7qt3uwL1tiv05MOwgFk8kPl4HTnztVZmI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nc4xq/mNMu+79PSgddwEg1irXp7lqEQ5nZBitNG2D9bAZ3BKerINl9rvRcn9yAh4UDWyGQourqrUoU6hvw1Wk0Efx8B0Y7Iou75b/XyCKbWBqT26sEbMduVzgf2TPGvUXEIjV6cV/9OHPnbCneUXdBX9hljLHz7fdwbvgXrKh4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87b2a58a4c0so407175839f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 08:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754408789; x=1755013589;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mi9XNzq0dQ7qt3uwL1tiv05MOwgFk8kPl4HTnztVZmI=;
        b=bnX7a4CMMDsQgZO4ja1RISbwardkkmTqQ5JzyydvqZ+17n3FV5HklXeP3Y6ntz51hh
         dokObrhPhWzVx9CvSjyYCNvyXCezGzhhlRHCA7i8S3QPz8hEdTwDZSkbHPU8YmB50jK2
         iVM/iGdLSgr1jk+hz4b82siXL/32dY6vbfwvrmp+pwI/jE0UW+MY94HKnLRxsxxarxUT
         Ro3Ly5e1pDRsidzZb6ZO/ZtUuKi8Os9NhXMIjRArLgDhQCFwZsRYX+vvKBgduyRVXJgE
         qHgh5xzxyEW6jN3UBjCLWS2rHE1MNR6037CipXUwQm3BAeEjVRMS0v3cedvORgKViYrS
         jQeA==
X-Gm-Message-State: AOJu0YyddfPKnbuahzRze2GsDPzJn7tFhjpjrdXYeI5FmaqU1lCr0xe7
	9XPE4S3vC5b4kbR64ty6plg+HkWa103hpwvCYSlJjZEcaKL9PabRf0s/lHPmmP4P8+jzCHnxaJR
	0zS+hawRzNQfn9W9MALVz+m1MBYDXCzrw2bJcLx03Q4BKfuIMva01grb4eg0=
X-Google-Smtp-Source: AGHT+IFwfiolaOvRe5Cz6pEgsRYkxQzQtjoNayarh7xuDKLjPIUnvFoHitpkRLiPFe4IWw+LKRes3+ZhITsOm1PNp/nwp0+s388j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:608d:b0:881:962e:3181 with SMTP id
 ca18e2360f4ac-881962e3566mr506648539f.2.1754408788920; Tue, 05 Aug 2025
 08:46:28 -0700 (PDT)
Date: Tue, 05 Aug 2025 08:46:28 -0700
In-Reply-To: <67e8f0f1.050a0220.1547ec.0092.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68922754.050a0220.7f033.0029.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 7e161a991ea71e6ec526abc8f40c6852ebe3d946
From: syzbot <syzbot+db4326df1b9af04f68fc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 7e161a991ea71e6ec526abc8f40c6852ebe3d946
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 7e161a991ea71e6ec526abc8f40c6852ebe3d946

