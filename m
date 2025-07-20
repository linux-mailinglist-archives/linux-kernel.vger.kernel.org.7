Return-Path: <linux-kernel+bounces-738264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC55B0B67F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BABA1745BC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF97421A43B;
	Sun, 20 Jul 2025 14:44:27 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109743C463
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753022667; cv=none; b=tjgx4Z1o5rmHVWC8510sgorpx7lfDVBsvLZuAc8v9L5ZROEzCLjO0avam6tsx32ChAVRXS1E8uhx6UksiLGU90Z7pelJ5KmaktDQ5a7sNS8N7NAcYBBHPC57l7klKteD8ZP+hulaIhssEvyME+5hbZO/Q91rcYgnl+u/toUsP9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753022667; c=relaxed/simple;
	bh=zL2X1Xx08gw3kr08an3mVEUPh6egKhuv5GfedIgtvMs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=so0p/YD5i8LdbIddczwEnpxrKDS1Wt2dBHjj2RG3L9pi7spaqkwmAdCXxdCGf2wTPK7LRIyw1kNIGiUrVEMq91LJvXmPwF5Lld68xSwhXSiSql/KXV+XzA2Q03eBXSXgLL1qwJO+CqZHlkhhYD3lYld+lGPGphYPevd21aCs4QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e28de4c75eso59177555ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 07:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753022665; x=1753627465;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ME5ZZiY1iYfo91hBNojm558Lfr4os6aNRzX6S/KJYf0=;
        b=A3LdjrQRlS0mO1INraZ5bAIIXv3pS0Wsxmovuy3zhxAD6yHQZAjBt7WCc2JLn9B4Ei
         mLHAHZh7x8bE5BDbY3oOQB+gAoBTmrQTZ0qQXUlql8DD65ddDCwVyJW5rr1ypHCE8f3B
         CtT90+IM8bHbmgPsIJrDEEYSmYrFkUYTRVVTUElXpAC2ggGvnHX3ADK9tg1UZI/ktnx/
         nvarNtsJmOdaW2z30vVBM31f/TIZ37vouDEtoidEQzxin8Z+eEkZe2Dw2rBtWyd+uhyZ
         UKkLhn2u6tTjRnGXcyXuocs9U7bPQ/opSaJ4/Q7IEF+ZYwkqzkcgEr8skmxECwMxAM5w
         raHg==
X-Gm-Message-State: AOJu0YxZQKHQKy69jIFzr4FUlOfCSh1dWaSAni16sUOneCs5UdzHLCLN
	mtl6McBpR4cwJXpcVUeHGVVYO4Dug7pDHKbcN6RmIcXDO79CJqcGMqsgpy/By7zed9iz3p+zcU6
	Lg9CWY90OKRK0nmD4Nm8/3RjOS/+7ueEl5d4WU76G2oqyju8zuYjnBeCnY2U=
X-Google-Smtp-Source: AGHT+IF0SEhslR8mVZV26J+spWOOcQ1MWNpuKj1pTb+R5+2IwaXK8LO6mxyzN+XvaB03jrS0TQMpgkObFqwC/bpQHfA6EZImUVMc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc7:b0:3e2:a8e9:89cd with SMTP id
 e9e14a558f8ab-3e2a8e98ba8mr32365265ab.13.1753022665256; Sun, 20 Jul 2025
 07:44:25 -0700 (PDT)
Date: Sun, 20 Jul 2025 07:44:25 -0700
In-Reply-To: <6831265e.a70a0220.29d4a0.07f0.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687d00c9.a70a0220.693ce.00c9.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+a8f903ba15921696861d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz set subsystems: block

