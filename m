Return-Path: <linux-kernel+bounces-892968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8DFC463C3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B2E1892B56
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFFD309EF7;
	Mon, 10 Nov 2025 11:24:24 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AD830EF86
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773864; cv=none; b=N2MbTec+1T8GSmxO4Slm8O/25CnGvyhcuMJQwPGAZDn63to2gCR5mzC7CZBZ+VuM/KDa886AAf8aUjClTg6ZkO6dREhHns+neamp6821MlpBvfylhKp+etOHPNAuGAevcoRFzISoo+QhCvQZqcpMTI2HMu2BkB6ZTyJkLgU1tsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773864; c=relaxed/simple;
	bh=hvgxU9WYOhjPOQBT6MnJZluumT/J40sc4Orhlp6AI6g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IuPrihENju8boLbFL0RRFNZBsgX88AfFdIKaBz5zKQ0Qf45cnoZz9artZ2ImTsgApmuJtXa33g7WDfX4OZmusLN9THWPeljTocJL+17IxtF1i/K3v1uEH8AHF7WU052SV5oYgCkqCmJj/q0ZIV3BPeqOC3M8xkXHsFr1qBOesII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-433795a26c5so13168285ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:24:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762773862; x=1763378662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvgxU9WYOhjPOQBT6MnJZluumT/J40sc4Orhlp6AI6g=;
        b=UnFfIQ9pbJlYBXscqE8FNxX4VKt16lRDDAr8KJvTE+4h0VwwaWLYkiaQOv+CTOhEHT
         1zKBXfBNOD/bAAwn1nfwr2C0gjQwK8qXvf1eGlHO/MMcyL14+vINMeGseutWcmjRkysn
         DkvWrUUs3emSVZ7Ray2dEMtBoUvr+Gq7xq8nYoQ3aMQYFEmY532vAMUZ8Iu3UCfqHMcI
         TX2Tl8BR5ZUA8Gmsw+TweaFAOf44uxxYXkq71cytYqU5lvFMmUvYrx2QSnQDW+pQnbcu
         b3BoXpv6u0arjZS6svEdXgMz7zGJO4tc1VDRbW1Hnob7rMgZzC3bNz9S1xyMB/yjm/OE
         lXlw==
X-Gm-Message-State: AOJu0YxyhYPDip9CoOMnQOwKVqUPl/eEfDlbjZ6bnY8G6+kaWh9pxoYP
	9mOJJQmB4uDpy/9qxcWYLz7dcI0qFbdKnLPltGkEcj+F+9tE9joqmZbQY3tyqo0R3Mx1HowJWw/
	uJMMKOmn6JbrmfG7atX0rXgyOD+HVZEkOSR2hGu/3SWzZ6HKVZ+jVHyvXdmI=
X-Google-Smtp-Source: AGHT+IHZIevIDm9UzQTzJQpytW1X2o2av7XuzzcdwOPDTJLOJeUIJ+KP0evzz2+qfZ/tarcsvCAA8xeOitODW+WvXlpdXqX21N13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:741:b0:433:2341:bc13 with SMTP id
 e9e14a558f8ab-43367dde525mr124849475ab.11.1762773861922; Mon, 10 Nov 2025
 03:24:21 -0800 (PST)
Date: Mon, 10 Nov 2025 03:24:21 -0800
In-Reply-To: <690d9fd3.a70a0220.22f260.0021.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6911cb65.a70a0220.22f260.00e4.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [jfs?] general protection fault in txCommit (2)
From: syzbot <syzbot+9489c9f9f3d437221ea2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [jfs?] general protection fault in txCommit (2)
Author: yun.zhou@windriver.com

#syz test

