Return-Path: <linux-kernel+bounces-834797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F6CBA58B7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 05:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1F0C2A3D9B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 03:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2419B20F079;
	Sat, 27 Sep 2025 03:59:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4538F1F63D9
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 03:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758945547; cv=none; b=t5u9sdmpmAEkLSI9EQ+4xpeDu9VMA+Fmy6OgPh+XqmEehZLaSXPCikXfcKnMMvwxQuuA3DHUjm2w8Q25M/ts7cxQ64/+sJ3ZzuIjsSdstqGEXV7O2RURa2zAmLIv+ROxPcjwgPx1ETYbMDIkwwy0HUP/appdt/wDU6847k90rE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758945547; c=relaxed/simple;
	bh=69ZLIFmXsqT820JoP+a/1IWYhRP/ZR/3AovsFPtcDvs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rklu4UcQ1CrrDrIofiUq+6s3v+ksOCEvuduWxu8TouKfKTkwJPTM03ReZvTzA1CGA7iOdGct3DMfFSGTis46w2peET8+6XV9GwZyDstjRuuwH6Rq6cQ7WNoG891CmKkHcrGFrSayWYH0U2rQ8Au1UyoXr44pkPefbgnpParXqSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-427621906beso38143965ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 20:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758945545; x=1759550345;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUuZCekw9pDGinJ7iP+1nN+3hTiI/HmaWRqDdrjp+YA=;
        b=xLKnq6555W/D3RetxcFDCdApLPbWuqHkYyqfMq1goaVef+DeT2o7ZT/IjJEg/xQ41L
         6WSWAvSi1Yjrj+2IjJz3xE/dWOhnXPxJ1bAAJ52zbHDKxWjpQquMHwhwKCsLg2G954AQ
         BF8TbrB84CbvZtkgaVOF9/RQtpMwt/TzZoWNhcjWiCss+WJ6dzkTk4lbp+8IWpKo9eG6
         zQP1+YxHUmm+77hrS/5DTaSi0S73Y49oF7ZRngnYJRnpG3nIz1olkK3K1it36BSis+Uq
         dDjgV/HnzvSlWA2QN2qOAXt1m0m+7ishlphhUmyXLjifXF+ToKlaxqNcZqxRYFr/yVwr
         nuAg==
X-Forwarded-Encrypted: i=1; AJvYcCWi/VtI/QSaIBJxjsEAF+aBjkxeXwJD+m5KSgI+KYzrqpgGJlNdAIBDYQrx/qHYN1qL2MNou8+zByXzxxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznms/s3PJlvSViMFl67CuusNkA8kzaIsPK5KQQ8RHLg05DOMHr
	vJjbldPgGY7gOYo29NNDxW/29f//Cey7UpMgic+MD67imKEewYuN6PEpO+2H0O70fwB/4SBNWzz
	weunZMMqwFoLQh9jhil/xpEqmUVTVv6LkyyvLY53xqBwC9chAsnbhVM6vLzA=
X-Google-Smtp-Source: AGHT+IGCRWYE7XfplQkUXYIdOdL42DYojH4z55PmebJU2wCp0G7ESywNHxP2PdF7CeshmjT6GfEv1yCAXh2O/DFFeLToSwRbu16u
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190f:b0:426:c783:a400 with SMTP id
 e9e14a558f8ab-426c783a65cmr86875145ab.10.1758945545400; Fri, 26 Sep 2025
 20:59:05 -0700 (PDT)
Date: Fri, 26 Sep 2025 20:59:05 -0700
In-Reply-To: <CADfthj35b15UzKe5wz4QDPUfEobf1ddU3T6XDyDHGSJySBg5jw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d76109.a70a0220.10c4b.0008.GAE@google.com>
Subject: Re: [syzbot] [fbdev?] KASAN: vmalloc-out-of-bounds Write in imageblit (5)
From: syzbot <syzbot+48b0652a95834717f190@syzkaller.appspotmail.com>
To: albinbabuvarghese20@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com
Tested-by: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com

Tested on:

commit:         fec734e8 Merge tag 'riscv-for-linus-v6.17-rc8' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15aee2e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=48b0652a95834717f190
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=134802e2580000

Note: testing is done by a robot and is best-effort only.

