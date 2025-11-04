Return-Path: <linux-kernel+bounces-885576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E1EC335E5
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85261899A87
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6D42DCF7C;
	Tue,  4 Nov 2025 23:22:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080272C326F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 23:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298525; cv=none; b=peNEl5sOOBMLdVtRVrz4G+8LWxqIyKR11KptWGBj9deXSZZIacAkSgU+VTCQtPt6k18THDNh8CFoThsk7oAZ/4LBXW2DkNHyO17x861gF9ZmnF5AU9g6++w3VBs2eBQqaE5RYoOk6zyeIHtvRfGP1LnHHnBq1mztfHisYf6nKY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298525; c=relaxed/simple;
	bh=1Zkpb+Fx53YvTLGRwut0stXpAR0/W6gNCob3bFl444s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=t6nqbWN9Nk6uWDqAJXqe1+ybdABga14Y9JE2VE1DWVdmwGv0eUaoj2NjaUrYY+Vz4c0DLyvqha+CzOCa3TkEG1cTirQkIlbWzUXRE+HBhbgDcHFst7u1IxtfMiYuHnc3y6J5hCfY/PXac8wa+OqazWxL6dxlrI2S148AGR5uRdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43329b607e0so78253975ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 15:22:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762298522; x=1762903322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WQFVeOB4QfJAy8cMCAspQQY/XxVgjDp906dgGhtTX1w=;
        b=wTh850PzaG8cSJ7H7fzmDI/jYAoiyAehoTVLrIDBzGKHriPiu5Kq2ZYedZc6yiZ5Zx
         BstOxwX/XXGB+QHIHoZfqytyrg712hTBBU9JV4FWLW+1OnYtAHuw9lA3DgwhETbrKcVA
         3NtV/ATZ8jPKgprVvDwdRPEEbOTiBU6ajw0uVw5kPOrO/gQgDSU2FuSaJK9IHQsMvaKW
         7TnCPQLkNN7lIGFTL83JszB3qiFfZyzpuaIqbhj32UEjXyS56MSvAIDqs2SqIjJwaruq
         hPT//Pg3to1G50r0rPThR+Pdn/VNt1t8uCVqWAsD1h1nLo6v444W9qv4w60hvjEWVm5v
         VW8A==
X-Forwarded-Encrypted: i=1; AJvYcCWX/Gv33y4qdyJnkzPdaEV6EQcbiT/FbISbJxfNZuUW+d9LS1m11jTxlsGDBJGq5/hXP6dTSfTo9cv71Rk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpvs6+3CcfY1I6OILBmEmkD66eF0emaaJCB8n51TGnZ0ZorpXI
	+lwNM+M/pFmy+mYjc90RblO+ekXkOL3Vg+i91HAiLFepjbsirGjWP3GKH8ESYFUe/aktP2mHb75
	3qPGUmIvX81O75tt6RWtzrZNy96OKnEXmNkhXI7R/wreJwGJl9QRzgE85ZiA=
X-Google-Smtp-Source: AGHT+IGlDvkPxRkMdadEZudxvoUlxuA2dVKE7ENN+gpT2h9Q3dc0Jhid/w6pfRNBkS4X8KobyX/eJwg1W50PtkaClaOs6Cv+wc8c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1606:b0:433:34b5:37bc with SMTP id
 e9e14a558f8ab-433407d4e88mr17182405ab.30.1762298522198; Tue, 04 Nov 2025
 15:22:02 -0800 (PST)
Date: Tue, 04 Nov 2025 15:22:02 -0800
In-Reply-To: <f5a387d4-eae3-4932-b170-37ff38ebe78d@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690a8a9a.050a0220.baf87.0001.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
Tested-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com

Tested on:

commit:         dd6adb14 RDMA/core: Fix WARNING in gid_table_release_one
git tree:       https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
console output: https://syzkaller.appspot.com/x/log.txt?x=16d81342580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c614fa9e6f5bdc1
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

