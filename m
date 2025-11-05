Return-Path: <linux-kernel+bounces-887039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 971D4C371E3
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F9BF503521
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA3C31577E;
	Wed,  5 Nov 2025 17:24:12 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C875331A4B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363452; cv=none; b=KLv1DmWwnI0/U5434SkmKgUq0zvGX/JYSjMysdnIUNxuc7r0SO8ZPMBz5Sk3KExrG0stqpZz4M9M3mYmd9DUwPP/SLJeS/4Umkf3qa2AQwrjnmDiNdoWSsCvlOOesLx2GtKqyqwc3Y6Y05VaJFTYkLreHa6aMEyG6QTedzz6UTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363452; c=relaxed/simple;
	bh=Ieq1ck0qvm3ZmRsGLSRgTwo5ZTOdLuFi0WGVB/YIMwQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WL6r+Vrv/lnFNa5RwF9D3AASRDnDaR4WerQdjpuRewz4O2MWYN9vWwok6hFtIFQ4g55eFv6QB8ufs7SxrQQoPhs72Ug8k1O/dSDcQRZggrV5Edygirf8BIA2C0FTo7O8GkNOZ5FduIb9EYFlNGfRod1DIxN4erlDMn83L0oM0+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43327c30cb1so79445ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:24:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762363450; x=1762968250;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OV9FnEIMn3tAb3e2Fleb7GR+066UTYm6BepX40jlcc8=;
        b=ojTtcqgTdFdzMHp5J4JaIlOCAtDe97abNLNcCNnrPYJIftk/numDOOIyXLOHOJrETU
         kDii98BLC91qWPAGpi05YN8Vc6uS/wSNXl6j+MY+zeykp/Hn29c3ejqe9rRlyPeOThsO
         DP2CykuHuoTpw+KsdE8BRwyaC2W83EsLw0AA0yFGCN/64FQZAptTkgmx0LWOV8GPrJra
         b+0px4eMZxSwXGzEH49Qyacs/socPCB3wJbhVREBBZqH5PY5aJeWH+KzsTuucvaeMcp8
         QvWazk17ZMOHX6W/yFbvUuLc8MLDVCHKAw202kCkVKhBFfwe3rOmQ0Wjle6KoqQGYqui
         k4Vw==
X-Gm-Message-State: AOJu0YxQbtago71gfFzbw00pjFB9dBQ1VDzAlaOl2OPlGju2Jvk/K92Z
	mw6iU0Bxa+t+swctTdUiLP3OS68/sGiZW/vdd68h6UojTw+xz5/Nqi1yZfa22vRpg6RmexaCZXc
	8stbKn+5EZi8x5oFldVkQvSHf0RjKzFeLp28IRXPUGo7ZiTHuCCC1gF7+cDk=
X-Google-Smtp-Source: AGHT+IHbAUiGmf5WPycpZxCF1KkQt/SlRlRWOG6dVueu9Z+H3pNoq00AmbjsEg9ZGnRC+LIC1tX3KOWtaMHwyJLR2gsayUut3Nz9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe9:b0:430:af13:accc with SMTP id
 e9e14a558f8ab-433407600cemr53429315ab.7.1762363450212; Wed, 05 Nov 2025
 09:24:10 -0800 (PST)
Date: Wed, 05 Nov 2025 09:24:10 -0800
In-Reply-To: <68232e7b.050a0220.f2294.09f6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690b883a.050a0220.3d0d33.0075.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
Author: yanjun.zhu@linux.dev

#syz test: https://github.com/zhuyj/linux.git 
v6.17_fix_gid_table_release_one

