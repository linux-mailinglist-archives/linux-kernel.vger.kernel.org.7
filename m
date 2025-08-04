Return-Path: <linux-kernel+bounces-755260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D16B1A3C2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905593AEDC1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E56E1EE7D5;
	Mon,  4 Aug 2025 13:47:12 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615F779F2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 13:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754315231; cv=none; b=D+3c0MNNhedjTrHlDrUJSluYm/p6lsyoRMkgnkIN5LQcAPPAcQBczH9JPJ3o5rKbR9TNCG91IJOAxI9fAbPTWcCpBnHmhjuaosD+K04JSNRAjougmU5mq93fN0gWLJrjrABTwkR8vVNcXq2DLi14FsTraojMq9ue5n1a12jVMP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754315231; c=relaxed/simple;
	bh=gGXT7p43qslPE5HhI7rxNfOZsm9uSl2zSqgk5zkOIUs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u2uqQ1xOGs5kGjkriWzqxXuhQhskkxJadsevEr9Xu9bJnviA6Wuca0ERJ5ao5hEk0ptYEy3PjKdDsjnC+SwiqjIaDK9XkjX1KRHAsyk+74z0Vp1WCIFfmIZ8rslk+mGqzpCPp0ZK211IjjZrEw3QEdr8LqgCox0gpVYmRC2ApTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e3f0287933so90022485ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 06:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754315229; x=1754920029;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGXT7p43qslPE5HhI7rxNfOZsm9uSl2zSqgk5zkOIUs=;
        b=Xz2Yq15zFruW/GPyndA1Ue6O3xwNI3XmobMq9DHM3VUVVbX4zzpKWTk4USiiajlGqg
         WpYo9MVIL9nJbS9dnJnw053pSPLUYaqcF75HOpWCOPWGBODrk3JMEhDQJz2MoZsn2ilE
         K8vw8TS0gILXUBoyMzfGl1b1r6v5jCfWnblY88R5uK9g1KqGRn8LVTKWBUtB3JNjj8F8
         HMn/piq5GqjGYpi2dE+FeM52+QnEDR9OWkWLpS3UblEV7zWxZA2pVBNzZ5IpTZ2DI3qw
         onyvKENY064cY6QiWkqsW1G3uzH/k6TWRi6NOu+ipLanRMFuZhW1iLXC8/4Yaom7/N31
         VsBw==
X-Gm-Message-State: AOJu0YxcCuVWz32TJnZAdXksMFEvZL4lOZoWzu4aIev518TGiZBrJYVX
	XKNlO9sLwiUIzU25IPAy8JgLjVgWaSV6+jf8zFh88tijiiodByHetEaTS+6nPHIJjXpOj5bPgSP
	pmbJXWUpwnM/a0oOkHsmKF5chvVdr2AGmMlAvCGde1JA0SBMN+wfbvcIZJjI=
X-Google-Smtp-Source: AGHT+IH03vlLirPemL1KypoTdt4yST25pOSe7F7e66JwFsTHhkuxPeH6MpLVLNrIM/VB2jYsFpZ+H61SzZAEgPeEdtUcwvhqyW2z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f12:b0:3e3:ef1c:ef16 with SMTP id
 e9e14a558f8ab-3e41611c103mr194622455ab.7.1754315229572; Mon, 04 Aug 2025
 06:47:09 -0700 (PDT)
Date: Mon, 04 Aug 2025 06:47:09 -0700
In-Reply-To: <67bd6bef.050a0220.bbfd1.009d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6890b9dd.050a0220.1fc43d.000b.GAE@google.com>
Subject: Forwarded: KASAN: slab-out-of-bounds Read in fbcon_prepare_logo
From: syzbot <syzbot+0c815b25cdb3678e7083@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KASAN: slab-out-of-bounds Read in fbcon_prepare_logo
Author: sravankumarlpu@gmail.com

#syz test:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
4b290aae788e06561754b28c6842e4080957d3f7

