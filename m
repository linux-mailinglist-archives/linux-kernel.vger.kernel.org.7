Return-Path: <linux-kernel+bounces-755738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB28B1AB15
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 00:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 854547AE558
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 22:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12044290BB0;
	Mon,  4 Aug 2025 22:56:29 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420DA23B0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 22:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754348188; cv=none; b=W3QOGUo7BAKk2TkGJvEyLxHio/1WpVqa8c57QeFyvZIVJEbEy+fMS07z0O24J0YHDSCXj5XjB2OCcojN/AlidO8A+b7oR9h2DioINtME3NIFN/JhB89/UMbTZU2xdNAvY9wTezb8a/pFqHBFyVlfqhyVpgDn/aMBA5haushmtN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754348188; c=relaxed/simple;
	bh=fP4q55K8aiHITkr0AmaZfBMh7pPlCPGJBcotxE/LuWM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=c4TibDNEMx0sX5MDWDZP78qKdVQ4OxXi/aHoDn2qFes+UC5UzB8GbQlTKzGGmPrz7/8+ngY05taT0tXpVXfd8n8wLrtLl5ZX4I1BihIBObMkoXzrmrW78CadAeSn5ZnJdtz7heOo3uy97ClBqBMom2B3HoVqqvf7TBT71HnxIuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-87c2bcfd156so371216939f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 15:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754348186; x=1754952986;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDBDmN4vvVC7ravAjhH/DrS8+jWRCHwx6LfGq7Y2VRM=;
        b=QZ6CzuyCKTNfg3qxrLpttIFR/a61mEXgkmAXXenyCTMvWnoLsTNzyXWQjUjka8UGAH
         EJSQO4YGtf1eVuMYBr6m2hL1PBiBRSTBTbROfnvo87lXL/ywAbtMGXpRjTOMOPKUvcZa
         /SOEFjx7EF5YSyvv0cvq3DgjGAFAg+O8dJpMQnoMJZ+b5MvsdDl3hZRufJMZJYDeVZbA
         zGfbYy6S5U19TiYTcn6lgeZIyCl2mgXv44VfB9QfgWEk8PTVkzuo1gX+2VxvgGJkWIr0
         IZwppCK4+lDLA8zU20QwQgc0MtFopDvS6PUDDjHnGe64xJXSNfm/eslkb5l93a+as6ej
         aCXw==
X-Gm-Message-State: AOJu0YxxO718l5jg8YwSYuo3rmmYCzZqiHaPDs41RYIlZJNB1Qcd8b5O
	hk3bkuNJbPi+mNKtOZboQcbWW0Kcki/KYJZz1XpEEHMIS8KdyV5sHdr4nSKO9ivZZgghluVszXL
	WZRpwM8NPttsV9z++ElTAQbdBFrqPQdZs/VxlMmzDblJP++O2vKYgrutw0po=
X-Google-Smtp-Source: AGHT+IH3ce4eBj7MeM23/p6RK7rMjTLlX3nQCaRMh1QcHzLwX9inJrpu324Y8BA4QBG6EkYJufFMBRJdI2amvLnhUMIUHPXxkPgl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1588:b0:881:8067:ba37 with SMTP id
 ca18e2360f4ac-88191b54257mr283918139f.4.1754348186417; Mon, 04 Aug 2025
 15:56:26 -0700 (PDT)
Date: Mon, 04 Aug 2025 15:56:26 -0700
In-Reply-To: <68905ecc.050a0220.7f033.0004.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68913a9a.050a0220.7f033.0014.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+cd063f869beedf5b9cd7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix:  bcachefs: Ignore accounting key type larger than BCH_DISK_ACCOUNTING_TYPE_NR

