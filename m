Return-Path: <linux-kernel+bounces-739685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2699EB0C9B3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9CC3B527B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFE02E175E;
	Mon, 21 Jul 2025 17:30:15 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34622DFA29
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119015; cv=none; b=MHEApkdFm7HtdqEUbDqEAyVWRTkPGqmkRmbRoex8yl29w+xnggQfguj7qWlh9uzXVq2Z3lApjUZVQbIPudlpABWzW4ZSHj3DaBvUXYBF8e6WMvNHqZAsampcXQqcqUDxd9/05Hul+4Xq6v3fT0rsCbDCvtypNlkixFRqyFIzI40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119015; c=relaxed/simple;
	bh=lDpA66QPta5MWpQC/gyVvcQrDXqqH3icMw7MdOStpl8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=koseSHhbINBdDtBs0MrA7EwHm5V9yaXDgmb8VyxDAOPybQ+fxzQB1sP49QacAgHDPYxnucXpaoCoCS+Mfb9Jc86tZmEph5E/CpNPpEK1Ei5v/3jd6scogJQ9HidDndVEK5IWdsuNXvmxb/PiB5eHNfmJYMLcZHjr2hrEfCidUdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ddd03db21cso77045545ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753119013; x=1753723813;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/nGztHDhBokWB05i7Jsofkj/kAQ7/NgRSseHabnnew=;
        b=Y02dMdbj/Zxahdgu7lYgs37Qq0ga/WOpVZrmALY91uM+SE8DTfHLu++UF6hG0fx0Dd
         2/C3ygvziOmfp8Hi4oOiOegq/JJeK7epxEjwWOLZArpGbjPoukOQ/94OwwnUMV11p1Jz
         7ppWloushR3B5f2DdQs2UOqSon4FdIbv39DKL6gAD1fPIfoAMVMdMLK2YD1qjxa5qUeP
         +sqg9fpkx4PRR+Q51LPFev+dcyLYymFR1VoYV1itfKKazPWQsqvkixu77uoc+u2kXK5Q
         rjAramtiMRHecwGtwweiFo8Pz7PhLYY1zNWqTbGYEpgVFY7+qICVFOmv2GyrbZ3ELOCL
         Bf4A==
X-Gm-Message-State: AOJu0YwGROhAIa9HpG8ePLGx/uKO73MDWDh1bhOP+u1i6TZoMJihrgKF
	IlUQZzJ8z0yYNKh9KKtcBEvCBPMCSb4F4HvZOfVGPUVwdbvNMIkSpktjdK4fI4egZm1CwFngvYE
	Q2pxO2b2jCL0Zvd6ZHODFk1bT9ZY34xYQeo/+BMbc1BfQXqfctmd0A60s+uA=
X-Google-Smtp-Source: AGHT+IEtVp9H9AV45BHrMV4XiPfTVZvvahqm1ls3A+uBRdCaOUrBRsd81JpdsALsgM5Cga0h3hQWh7IDPgnlA02t1IGvxo3ZXITV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cb:b0:3dd:be49:9278 with SMTP id
 e9e14a558f8ab-3e2821ddae3mr237645315ab.0.1753119011463; Mon, 21 Jul 2025
 10:30:11 -0700 (PDT)
Date: Mon, 21 Jul 2025 10:30:11 -0700
In-Reply-To: <00000000000025321f061d7b62ff@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687e7923.a70a0220.693ce.00f1.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+1a11884d9c9f1353942d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Add missing validation for superblock section clean

