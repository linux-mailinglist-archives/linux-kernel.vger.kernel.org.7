Return-Path: <linux-kernel+bounces-834795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5866BBA58A8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 05:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E56D2A64D3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 03:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884BA1C84DE;
	Sat, 27 Sep 2025 03:39:54 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECDF72608
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 03:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758944394; cv=none; b=OMoMy1b/0yeml1pZxo6Vx9O4sEnyMVaox9dCJMAmGJUbT07paGX2E2iOJcfIFqz96yLYCUEzJ2k4dRKe84cpPg/nGCVD2ZYfYN5x1BZErcNzadN9S53ffJmsFDW6DBbek/g5nFX86WDC3pmoMk2daZcc++zgz6m9yX72URoASyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758944394; c=relaxed/simple;
	bh=dUXPBb8UoePfMeduek6i4pY3kcJw5egFRNTRJmZTbyk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ba7nQTdLVyqd4SvVqDOFa+Y9lvJgns68Tx/TOtlYNzyjvn5LKZT+oMPkorbB7zoUy6kFMWCY8Sc93MKUbgwLMjqwQgJm43rYj8QJ/xokW5f1srgttosyKLzsBjhU3KlfeNx8sMV49c4xSLRl2APw0NXkLM6vfMfQbdIuWUS0pOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42594b7f324so52472295ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 20:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758944392; x=1759549192;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUXPBb8UoePfMeduek6i4pY3kcJw5egFRNTRJmZTbyk=;
        b=cexTDW8i9ph19U3wMgS0dRixMtd7d+hai0Yq5VImjHU33kmrvgVD6IzDwYDYPMdhfw
         Fig2/rk+GrSVVJJers8kUP0Wof61OYOgi35iU7KBV801mHCOxbbBfoEUmIGO99clc2Vd
         k54x12rzPuo+MrB2s5+htUbVfsObkunJwpwedxExSqHVsfD2dwd1WdpOd5rDN++JCOdZ
         SeSFkUpYynJuFizarBa2YXKUIu0LSk3ZZpijhiTgDJ4C7q7h+PLTvpKugSMX7St6/Ewl
         0E0CGf8KKZCVi3fzxYpriSu267yKlq4A8jqCdW6VmO6CnDg34NbJuCFRTKPXXWf01Wyb
         Iuwg==
X-Gm-Message-State: AOJu0YyWFaayUXZFOtZNNvtDDQDQejxkk/+Gwab69ScMB4GaLGrmmtt4
	v+Fzikp/HxIKDjhC9eS6vDMHa7xcEkzvdUGPj79m0nvDlHfPmlXmltl1s1eQ1k7J0zisva1Kc6A
	K0n9gsvDuYr0oQEa4auY9wi1R+zw2yGrvDXaNGw5JV3WcassFZXRMj3h2ans=
X-Google-Smtp-Source: AGHT+IESHH2nkLi/fOtiNgMzz6i+OpZAXf7zno8a+5ezNJa3Mrx32XlVgZakJTydrWdYdU2aJaGUBxa/54MgXHaXYJleAiuiqmUb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2782:b0:425:86d9:91ea with SMTP id
 e9e14a558f8ab-428752af975mr27235835ab.11.1758944391850; Fri, 26 Sep 2025
 20:39:51 -0700 (PDT)
Date: Fri, 26 Sep 2025 20:39:51 -0700
In-Reply-To: <68bf2c3f.050a0220.192772.0884.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d75c87.050a0220.25d7ab.0222.GAE@google.com>
Subject: Forwarded: KASAN: vmalloc-out-of-bounds Write in imageblit (5)
From: syzbot <syzbot+48b0652a95834717f190@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KASAN: vmalloc-out-of-bounds Write in imageblit (5)
Author: albinbabuvarghese20@gmail.com

#syz test

