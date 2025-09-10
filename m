Return-Path: <linux-kernel+bounces-811040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B78B5234F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0635E3AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022433081C6;
	Wed, 10 Sep 2025 21:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIhGeXQD"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB06307AE1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757538535; cv=none; b=dP4NaVHEJeg9MQdIq65kmvDTOLqmTo7Db+qTvHUaIUy5qkpqALc5ai2AMK9BJGs1GccubN2FjZbgWRiK26B/w1wJDgH0rcknY6EN2/5vARB7Tp7Zb9hCEwoMJ3nuzzgzWtpWY9Sd6QzTM+xo38PJoqJw2JgApIWfS/C4XendOyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757538535; c=relaxed/simple;
	bh=HXDs2ZmEGtfjB9bhbdMly1UG9ffTaDrci3CJDogiM7w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NmlXH3Y71jMiaJauegIB8+z9ILkwdJmbTX5o0DyuyGYWI3AflYuTevJXy1X6Lt7iy/qstq8QiTtS/Blzc2cLKeo5iGEypeCUnmKhJna2bqzGFPeJ4GCpnKNeSZ/swtwi2MH96fJkGp9jXuK/84Gm5Kz6ZR1tf7t2xARAlGb9gIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIhGeXQD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24eb713b2dfso71555ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757538533; x=1758143333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QnMDY1+gMmWBTwXGNJMQA+nuCcZBFftiOYpBYfQgQnU=;
        b=fIhGeXQD/FJbWBUxtY3r0pe1t+96+To6+4paJZgnQnPVWNFF76uiQTFfLmgxKHFYfQ
         Oi2qMprKvVdbS1vEvVwiQUiIB08lHHQ6mBQjob890CPH7z4AVfEVMmRV3E45Z8jyVhac
         Z7DInY0ZncZ5smx38vnxoGzuviK4vkoypoWCiHLnceFuAqrOKPw5SuU5gCITC6e4YIaW
         IlevNnMbkGWz+5ZW8dtP15XK9Vg1guDI4QO+oYBorCwYzZAn1i1Rl7Y9iMRfjr03jLoS
         NKlpQ+PNWkTLknfWmSYRE4UgsQdGSxA9kgPNDlLYVe26u3DroNVMHFFeuhYX+ffFQvc2
         rdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757538533; x=1758143333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QnMDY1+gMmWBTwXGNJMQA+nuCcZBFftiOYpBYfQgQnU=;
        b=Jf1DQTqgVSpmGXXvtVtq6tHdNcthxeleu1YGzhWWGCVaL4vvBje55n6hLtKDjl97tx
         zs4GTNWq+f5xfyLGa5lhSi94aoaCEBOQ2Ins/k5x2QL2WcyU0OPXzm2Z10shUqX+SW83
         GMznilIbR2/CYUGVFi1VS5gFg+N4zM4UzP3wSkK2ExNoI1fa/0R3EJ9VUD9EOhpXLY7+
         4VA/rS0JK35DWen/f1GdwRhDxQY9dWRZTKT7e0evio+8kZ2GYlDFkw7Y6eNub9wHYrcc
         HNEFPX7ZxxPv2xJu3mSWsT7i3e358cNJCQ4aOV5TcAXzG4eAbWcMItcE5PvbC1ZcEZcX
         A/Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXekbBuK6+pcSvWE8DtE7KArHQSzLSPUOpwN/4BFb6aq8CfnYhPrA4gY6lJxXPlu3KpQtVF7eX3aRmJOBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz77acnbNN/sMgsxnDJU4r3m2qVDvPAKEeVATsZNGZEyn8W9bZe
	HYTS7EY8pJzPP4AAKY66wK5Xu8YRPgUDHEpQAduqZDJnUvN7x+5e7sLQ
X-Gm-Gg: ASbGncu2SGA9aX0FHTQzcVfjQ2WDQbaQyw7wj21O94AdnisH5c2oqfacU+jfx8ZIieA
	7yGQ5T75bpV94ICJZOzT/+WSBVJ/LxQYfXemm+O9umEfnoLZNau8p0+p0AMqCqYGi4WyAl2r75E
	4Ri2o/Ddevp6QpbLQNXPW/Q5/YDKBPpvkb+MSnT79MDtxmgfoM6U1HfCVoeLqve88tiKQ88mtKZ
	fbcvy/74HJYIuN9/PZCtyURPF/styq0x87JARMPRRlHYM9QrsyYiFMNk/q6hG//el/2QPOnhcnP
	tCrZas1rd386DHZbpWxgeeECD2qovT9XPS7GDicdoxZZp+QPUA8iwOLYvcH4+2O2zNLnd/6+7aR
	R1nkj19ISrnICtzMxg9A6Lz0yEUj8xKGI
X-Google-Smtp-Source: AGHT+IHM1mzLbJa3eKzoNYPvLuyOVESafeLZgKkAzVvLBzsxzinvh5gooIV34zsvlDI0/suWn8/WTg==
X-Received: by 2002:a17:902:e88d:b0:248:a4e2:e6d6 with SMTP id d9443c01a7336-251715f287bmr225864935ad.39.1757538533169;
        Wed, 10 Sep 2025 14:08:53 -0700 (PDT)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2b0e6c15sm36957585ad.146.2025.09.10.14.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 14:08:52 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] improve group_cpus initialization routines
Date: Wed, 10 Sep 2025 17:08:45 -0400
Message-ID: <20250910210850.404834-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Add missing core API and improve cpumasks usage in the initialization
code.

Yury Norov (NVIDIA) (3):
  bitmap: cpumask: introduce and_andnot search helper and iterator
  group_cpus: don't call cpumask_weight() prematurely
  group_cpus: simplify inner loop in grp_spread_init_one()

 include/linux/cpumask.h | 22 +++++++++++++++++++++
 include/linux/find.h    | 38 +++++++++++++++++++++++++++++++++++++
 lib/find_bit.c          |  9 +++++++++
 lib/group_cpus.c        | 42 ++++++++++++-----------------------------
 4 files changed, 81 insertions(+), 30 deletions(-)

-- 
2.43.0


