Return-Path: <linux-kernel+bounces-782877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36438B3264A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 03:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16CF91B6396B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 01:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DA91E7C38;
	Sat, 23 Aug 2025 01:53:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0934191F7E
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 01:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755913987; cv=none; b=rTQY8Tlte25VMQVDEQbpepKRz7dpRYKWuO4f1BHckpFmOp0jw4GFI3QyYPHXN4ha+esymY5YnbxEbKQrBAqEjPH+m/HHcCO6QHyqpf86Iea/RMLZOkqoV0pF9tgfqyDcMu0g9SM9CLxyCBa6luLX153ErjMIfJEo7BO4rRueyG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755913987; c=relaxed/simple;
	bh=U8a8iHWl7oEp8aQT1k+EAnHYrfohrMNJNkn7XIbCFbI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H8LZpe+dcXV/UMTY/d/m+W68sFnyML4H3FRKmPEUZv0V+Lx+fTMzabRW1voAVz05AOlAxf2wKElqjxyIoQtSFA3V01z5+sOwX1WG6xyKcY7aOagsDloFFsFBh9RQ/wRzHCWXaJNsUPN9klFzOFT0ynnzjFBLxJpv3g6QuvQU8f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-88432e1f068so325729239f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755913985; x=1756518785;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bo6fBTTBH/74yPTk1r5MKPyGC8iZmQewEtvlGYnbvMw=;
        b=Dac/1jb1UHGTSKXXmWBcXVRpK98hu1ffMcxqDUZrVGp8v8Wq5a/dnCAyb0OLwLBhFl
         5I7sXVRZb/t/7iihq8RoD4MQ8pZKmnUxPjsROTux0VrdJdGGD57EnR9y0vYsfU+YQe4I
         CHvTkdOfKvkMiUhlgDY63IMhUlhZ2Xx0Sn+G871frmC1qFgKVUDxFUDLYGMGb1Txd1os
         89U0Hm1U8rHFMedvHeSGgCGvuJPjl63CjU2V5RNRX88hqFQrJpDGMwpeGemgdIbYB/j4
         b1b0DV1Q4cPCYFuPW/7vUwF2RDV/uiplnwg1jenkYzp8fAXUya9b32LIzpMpV0RlJ03I
         kd1w==
X-Forwarded-Encrypted: i=1; AJvYcCWkYVib4DgObaSdEq+To3Zj6tn2a2Rdwc69VN6g9QmdF8AWMCa1Lryqi4MUFT+AVAg99m5o1JaLnSI+sHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD3kKkciuHzrLzfG5d91I2d1H+XbaTSGS+tUpM3KYxqgXjhkG4
	+j03+gGvg6wPdE1ZaZn3eXuq1ciNQ3y9BW8kBxuHemb4cEVsPfFhVxYg6U3oohfSaQTQep6el1y
	Bv74LhukWzeCMKqjUV4gWFEccUCpWEXtj35js8WhAbXTiv9B35laAzWmWpVA=
X-Google-Smtp-Source: AGHT+IFrYWpOy3D6uGcg14nMGafZNj7JrkP6exewwLB0iuCB4PeAGRWxvtTM2+pdG+2khWh+w0FRmBBR2cWclalXkfbRVQf6KWf9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4f:b0:3e9:e1fd:2f8 with SMTP id
 e9e14a558f8ab-3e9e1fd2174mr48590205ab.28.1755913985104; Fri, 22 Aug 2025
 18:53:05 -0700 (PDT)
Date: Fri, 22 Aug 2025 18:53:05 -0700
In-Reply-To: <tencent_2FB36AA36D497403B5E44E9764F76BA6DC05@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a91f01.a00a0220.3557d1.0016.GAE@google.com>
Subject: Re: [syzbot] [erofs?] KASAN: global-out-of-bounds Read in z_erofs_decompress_queue
From: syzbot <syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com
Tested-by: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com

Tested on:

commit:         6debb690 Merge tag 'drm-fixes-2025-08-23-1' of https:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f38062580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=5a398eb460ddaa6f242f
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10fe8c42580000

Note: testing is done by a robot and is best-effort only.

