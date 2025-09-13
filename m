Return-Path: <linux-kernel+bounces-815347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C884B56320
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0DDE566872
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CAA281355;
	Sat, 13 Sep 2025 21:17:21 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DC7280A5A
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757798241; cv=none; b=ocEVZ042Piysb8qeUazm63wZ6DNRR0WbypW1ivsoLGjC2APWkRWH6ex87eF/Iy3MIuMdh/5WaF+f70gyZHNqosdDi+RNiyp+G2IOYXU1Q9ApyJoZ5sQf3mcBAqVjHPeC5COul95VjbMaWtXX1MA1IaNHyoD/JHLRfcuJmZIhr/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757798241; c=relaxed/simple;
	bh=ArE8SLQnbAh9i8ybv9znn3trN6kT9con9otPo9jlo2c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NjIL/7UFYRVg/x0PeFXFkr9LHRT3Q3aCEPmTDVjFTWkoNdG0r8UMf4vJW4qBufIS0YBE3f1j5ipvGlzbnGC56gkJBXn0DnMqxBVFogHLcJuKuUs9PZCKLJ9zheASn98cXfmAId4YgaGzpkszVKP/GXMFRN82cCGLnfLKY9tzQd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-424019a3dfaso18495ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 14:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757798238; x=1758403038;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ArE8SLQnbAh9i8ybv9znn3trN6kT9con9otPo9jlo2c=;
        b=rpZV2o5qnJlSWf6eQMPHwFSqyKWNl/Barr4VGRhWqkV5cVB8le3u/S++rVglght0OU
         v98lYDSWvlTlilWzJ0158dUwWTgqa9WYjzhrJmKu7fDNPKwcYprs8MR2VqnzwV4bwKeq
         0lNkQ6XRKfhs93/LilVPCUnY8Yyjfn36L+I9CVoM1+LJZBONr2pRig8ivOnFyo6CHuxJ
         rcBkRnDVu92AdePX/pp6BGJ9j2j3HfqRzkyrEWnJjihgZGJLUlJxkIv508Z41qldLj/y
         k0iUF+6eEmSoZGeB+0fnUvNIxmHIsEW77AZ85TRgx3l1kXnSNkA5wHsO2cBB55xY2diH
         q88g==
X-Gm-Message-State: AOJu0YxK98RI2Jx6cDvWZlOojfpG6KgzepC9finauU+n5sc+KoCm6ElC
	b4RP3Mx4sn+PpkWNGsJaIl+XekX01Vl4PJkLH4ZLKcBbvYfnI6hmhPXggpYr3atKYR5xgQUvXVP
	9q5zLq1AZ5ViRyJsHbQJSe5SozSeW5YfaBmiBOyfSP9+uwR9VEqD1mEI/Zlc=
X-Google-Smtp-Source: AGHT+IHIaAXuqmzH217tESCeoFHcljmjq7uNhzxJrP8n25UN+/TcNWk5CiYOZuv7sGmRRYsNWxJMwONG64JCnSeo8W1fZcZoA8WK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148e:b0:410:cae9:a07c with SMTP id
 e9e14a558f8ab-4209d225fdemr79354845ab.5.1757798238683; Sat, 13 Sep 2025
 14:17:18 -0700 (PDT)
Date: Sat, 13 Sep 2025 14:17:18 -0700
In-Reply-To: <68bacb3e.050a0220.192772.018d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c5df5e.050a0220.2ff435.037b.GAE@google.com>
Subject: Forwarded: [PATCH] WARNING in reg_bounds_sanity_check (2)
From: syzbot <syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] WARNING in reg_bounds_sanity_check (2)
Author: kriish.sharma2006@gmail.com

#syz test

