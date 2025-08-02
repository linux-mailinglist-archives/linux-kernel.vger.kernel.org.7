Return-Path: <linux-kernel+bounces-754167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C02B18F34
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 17:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 612D87A97B6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 15:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CE02472B7;
	Sat,  2 Aug 2025 15:25:59 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3034C8F
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754148359; cv=none; b=sme+nwibbeiAkA21dO0QJaQoCSQtgSbZHwsVg35g+8fL2qtTYNjIjiV30y+SgHpfcfgWlD0kpcjjo7wsMKNAxcNNkq5sKblr28mxkL+JRzAKtTS3IAuCSCBD/FY8RG7tyq35+tQ7NFYnwOxamVmz0NhjsxlCSuQiJ39N87hosDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754148359; c=relaxed/simple;
	bh=seZIdjhEqK761PCns8qafAjkaYmK058tk1d0tISUzi4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iBvCwohI/FT5OSO+1Dz5TityYP1DZPg9duTuOIl+3YkRwsjjvdkMDTAE82qCbpL+Kffv9MUWITgxeLKDQAEaViTQf4r7IIsjQkEIXfR0SajI5YaCqNXhyxMvxOCKHSiTRfrcoCemv7DAVB/jSb2SKyzRzZeF9WLUmihYQzU00ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-87c583fcf77so212153839f.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 08:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754148356; x=1754753156;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=seZIdjhEqK761PCns8qafAjkaYmK058tk1d0tISUzi4=;
        b=DJ5Pj/XkwLxM09rmtSATbQvD7hcxkSqK9XWUShtQPLBCy3W9nPMGTLRftNXC73bHsL
         xjPyIGj1ontMPTHVlIkN4kEfQSzDomBZqxgtfMnov2zHOJfVo7yG66vtZVUPW9xHa2p8
         r2598JmoqDQQevxwYVEkgQ+0w48poe1sVWmJDl4x8qtkEbp55ZuJR2dtXZem3uQ31Wgg
         Sm01atcxo7NwayiXoUPenC//LRzrIVpsa+DQ3+jM0rkzgENqQO9QsXrxI3PImPfn5WnL
         PGR5k5QJRI5KGdal4bOVXV74ppfSBfTeaih9N7xkrYbZagkPrE3sCcrq9ArqBm44//40
         6SoA==
X-Gm-Message-State: AOJu0Yzc2T4MhMYPApoAj6jVoof4Jiq9akc6+IuqsXYbMi8wn7G/Mn4Z
	V7UN2dxSPDGLT/TiYDe6dXXh/5vmLiU5dfVN41M2usqhDTyt5zR4qCgzw5wEw7l9gNIYz8GwK/3
	4Dq4pEANK5bKnYj5FEEatXz9MeHOMv3DFA/A7MBWF3SZy6+/qieur2XyXh+0=
X-Google-Smtp-Source: AGHT+IFu+TTkIFsikRQ22rHDOU5ydKmEThR2n8RoBVJdZRvOfq03ym47jxqMOce7kxm6Rx/gbajYZoxnO3W5dbPK4KcLyxTaU8yf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6306:b0:876:8cb1:a010 with SMTP id
 ca18e2360f4ac-8816836228dmr592180839f.7.1754148356601; Sat, 02 Aug 2025
 08:25:56 -0700 (PDT)
Date: Sat, 02 Aug 2025 08:25:56 -0700
In-Reply-To: <6834671a.a70a0220.253bc2.0098.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688e2e04.050a0220.81582.0001.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [block?] possible deadlock in __del_gendisk
From: syzbot <syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [block?] possible deadlock in __del_gendisk
Author: ujwal.kundur@gmail.com

#syz test

