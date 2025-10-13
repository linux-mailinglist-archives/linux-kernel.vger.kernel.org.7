Return-Path: <linux-kernel+bounces-850223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C69BD248E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E764349692
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E172FD7C3;
	Mon, 13 Oct 2025 09:26:32 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34132F28EF
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347592; cv=none; b=DT4iUi3Ct2aQU2TjhIIhYls6hFDKFQ26UOwe4IdMyxMdmgENmwQYr20lk2sQqtR/N7vwwHpP3XrWC2uO1BybJ8QOxTMPvbrdqOJASphYC63mkWgGFFpMHURABNBhzrJljXKpF4EqXSqZBg7JOo/DTyv5bBOcLaB9mumcOEb3xbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347592; c=relaxed/simple;
	bh=ZPtHdOBvu91Pl7+wZjTzlKJfrZ6o8e9LRZ0VlduUjUg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JWEt8lya1byGsVvv/vqfnvvxlAonoaj+v0WmimpFBmYRVL2KAxZ6TtK9hWwMWMmU8qTBfxNo09E33jOOH68kJNFxuDxSuzQM12W+kQSFjEJqGwS9xLdAc0Eg79ryedshKRmA321tzorSQHuweKqzcMq758P0gBdsx/jcDiPvFEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-886e347d2afso1211792639f.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:26:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760347590; x=1760952390;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPtHdOBvu91Pl7+wZjTzlKJfrZ6o8e9LRZ0VlduUjUg=;
        b=MCPfIl4TdPnk7bPfFpv0iB3vUe867SRQXz5Dqtdr//YVYywQCMy/f/2OCG4+s+ZB4t
         uZO5DcMxYQAfz78J3ooP+vvhjzYAjxYEW6s5+XTzo3HA3+Cf+7i1io9xJvDSJd38gO88
         SMBa022ExxiDYNlkus4DFKGDraf0WBr4Zy5EIBzOdA+8hKFNBupQF6/lvkxixY60K0ho
         G50eQAtSPFyQsjWV70CNI0V1qgXOqmA01aeU5eRfNRdAcvGdAiCrug4QeXMCJomRsv0q
         TZlyN8HCW07/OfJIuJsUqEygLl/EEpMDsJMqrqEOosA6qE8nigqahbinA/J3q4PKMsde
         Dnsw==
X-Gm-Message-State: AOJu0Ywr+igGs8WoBbsDOfrMjhkiyeoNLOsnvPvbFNhj04e56U9lnvYe
	691THdLxx/jYt88J9EzWopVULhqbcJBbFOnFpK56lwY5ZSMmQYwrW2yw9AOxVpgP63tcuKZ+jcm
	PRTS8TLLuAqIqa7hDLDjbVqVI4nl10R45NmMnFTpoQSmRwcVrVfXKxJdtf20=
X-Google-Smtp-Source: AGHT+IGaoJph7mYKceQYzgbCungKiFtL+PDd5901ILB3gSL0B3gElZEGlFLS80LzR2Yh7K/yD855ipAkZCKbPYU/9Uha2Y4Y2ZKk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3425:b0:92f:575a:6df0 with SMTP id
 ca18e2360f4ac-93bd19c3befmr2734615539f.19.1760347590072; Mon, 13 Oct 2025
 02:26:30 -0700 (PDT)
Date: Mon, 13 Oct 2025 02:26:30 -0700
In-Reply-To: <6847046a.050a0220.33aa0e.02ad.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ecc5c6.050a0220.91a22.01e2.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 3a8660878839faadb4f1a6dd72c3179c1df56787
From: syzbot <syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3a8660878839faadb4f1a6dd72c3179c1df56787
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3a8660878839faadb4f1a6dd72c3179c1df56787

