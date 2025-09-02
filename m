Return-Path: <linux-kernel+bounces-796639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA4DB404F8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4D91891CFB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B322430FF37;
	Tue,  2 Sep 2025 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeYAqq1F"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23D630F533
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820380; cv=none; b=ubbpozqX/YKWFufzKxNv373mzDl3LabvoijRPNsBwnj9J4V9dng2y1o75zafU3frXtprOMNeYX80S3HvNuOovcMIaJ1aRYffPdW0w/DQMpl8Hbxm529FhNcLBhIz0AzFX6bkrR6c4wCt7BxABGfjB0F/B051eXWWpanWP10a7NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820380; c=relaxed/simple;
	bh=K/IIRX6cZqHveyVdK0XoeTwBR6D1RLXmC/fK5i3cAlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iecDcbsn738SaKWt0xMvZ1j/GhzWeMaHy622DaDYGFzk8QXVKBwoH0tCA0YZBgi6LRjFNi8k2EqQA5ylh0X9jF5nF4KUDGWigNCqISisH2J0/mZcWTvGu5ZUNFHy7ht5xlcoKKS+YF7fYbKlwx2k/MYU/8ZMklXW2eAZQFDxa00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeYAqq1F; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso4707765b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 06:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756820378; x=1757425178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/IIRX6cZqHveyVdK0XoeTwBR6D1RLXmC/fK5i3cAlQ=;
        b=VeYAqq1FdYTkC4pKhOhfjoy8pcNczBdKvqs5ust4wTyQ50lKcB82hB7bSgVFC/jIjW
         B9rHhsZisUu86MwymkfGZMF1JDCdPpvnD1fA3nKYzeDzDdi3Uo1W2bFIng17TBfXVejO
         nfQUhWqLbwh8PKvJjhqtBr+yEXMlYmFU4xNw5jYYUQ6iErOEV8YN80H1AOy39YDCx2p3
         Mg9hASfkkvyKrg/7dStBkij7RdMjz9URXItOwbE8L1V9MquLiABFjt4lGvk79GKqnx0W
         INH8mPgUJE+YgQMPWRq8LFXbj1sjj64NlZi03VTzajlhm6GSIN3aY41sH816rdTDJPzr
         utSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756820378; x=1757425178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/IIRX6cZqHveyVdK0XoeTwBR6D1RLXmC/fK5i3cAlQ=;
        b=SgYgN2IzayRLRQEhohsjtZxHm2AuyZu2JMhYgSzhyWLskJ8YYYltC0B8NxF7UdsDbW
         75Rg7gKJbZdPgARxWcycm+H0Sq/Cal2YbWkBYvpY0tttiWeDtAyvECbv0bNYxtDig/KU
         3PM4I8PLtnztMimJBvOUUYcjQbARCmdi0HylpVXCw9REiQXUNy3ss/ZXY6rup5+1XRTO
         cJQ/rp3aQo+3+pw8Ci5UCT9kEbIJzU/eBN7I4kVBOSk8DOfIP4i2QUiVzUcR/Hv/eopn
         YZpegJ3ne8Iygregdg0ISO7Hg+5A1Jr3pllcoVYXtBJrCuyivGmbm2D4C9WKecpzCHY1
         HViQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbm6JuNY15yqlSb8hD10NbSFtyqcefgZX49iYgKyYscg8MZgsS0vasdYuS3O/4ilEfdp1N5+xQB8pJZ4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1q5XPvBAalbwm4AopklLm89owc5uLc2Cx1Ejy+lp65M2hYMKb
	KzMWayZAXu3bV0gTw1qGfay08GVTXXB53htUVAXUkv5FpPnpC253Obcg
X-Gm-Gg: ASbGnctRllm10ApZp9V7BMhZqGacMvnE2UFMxPR3DLAL9Nq2fv3H1BFbDRSzSU51iaq
	+wLbY1buLfiuERDC84BPky/EkBux7JczV3gTsEffSyd7WdBKRNrBtWZwF/Vyj0p0KexImhLvGIX
	F4tFby3wERgt8S3g9klg9RXqFNiIcM7u/CHr8WkrKz4U7JYLBvyI0plK2r6+S1BF1vwxdYPkWUn
	7Kj8V3DJjfVPKI6k10uepftXrQzX/4SbOxafv7BAYGy5KqpIxqTdq7PYFPxWDUxhxX5DGNrkyo4
	uXpCjBjIgw3JQMva/O3sZ8tgO0I9nBYZaMcK89BI4y6+qKdnMrcAui4YaJxaWFzCUSpx+FA791a
	K7g5XkO51I3y0FabtY0rTCqBgeevHxZ5ZowYGFWvJlLZQCaTRXA1AI/SU39YJbbaMbWkIPFFpMO
	0=
X-Google-Smtp-Source: AGHT+IHGByeGR+KKpc9TABQ8v/iqUMkl7uHkPzP2VMOjxHn4SHTGndfvld/gXSzjgYNEmT1WtaMBIg==
X-Received: by 2002:a17:903:384b:b0:245:f7f3:6760 with SMTP id d9443c01a7336-24944b20cbdmr139026075ad.55.1756820377704;
        Tue, 02 Sep 2025 06:39:37 -0700 (PDT)
Received: from kaiwan-dell-7550.. ([205.254.163.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24afcbf0268sm33957805ad.8.2025.09.02.06.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 06:39:36 -0700 (PDT)
From: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
To: tglx@linutronix.de
Cc: Llillian@star-ark.net,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alexander.shishkin@linux.intel.com,
	anna-maria@linutronix.de,
	bigeasy@linutronix.de,
	catalin.marinas@arm.com,
	chenhuacai@kernel.org,
	francesco@valla.it,
	frederic@kernel.org,
	guoweikang.kernel@gmail.com,
	jstultz@google.com,
	kpsingh@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	mingo@kernel.org,
	pmladek@suse.com,
	rrangel@chromium.org,
	sboyd@kernel.org,
	urezki@gmail.com,
	v-singh1@ti.com,
	will@kernel.org,
	peterz@infradead.org,
	elver@google.com,
	namcao@linutronix.de
Subject: Re: [RFC PATCH] time: introduce BOOT_TIME_TRACKER and minimal boot timestamp
Date: Tue,  2 Sep 2025 19:09:08 +0530
Message-ID: <20250902133920.973210-1-kaiwan.billimoria@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <871pp14pkr.ffs@tglx>
References: <871pp14pkr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: Re: [RFC PATCH] time: introduce BOOT_TIME_TRACKER and minimal boot timestamp
> Under the assumption that nothing on the way resets the counter.
Ah. Is there any known component - within ROM/BL stages/kernel code - that does
this?
Forgive my asking, but if fine, will this (above-mentioned) patch be taken? So,
knowing that, we can proceed forward..

Thanks,
Kaiwan.

