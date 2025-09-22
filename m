Return-Path: <linux-kernel+bounces-827475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBBCB91DBE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664322A597A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C70A26E711;
	Mon, 22 Sep 2025 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYVJ7PfF"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BF328153A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758553847; cv=none; b=HjvMB95/1yCKaH6yEz72vjaqfgMleYSC+mb0CE8Rb1iRAVJkGVZA/di2Eaqy7rMUUJ1YnZKM0pAPBv0WG14sC+W2azLWGiQlZlmxXdOYxoniftAD7qVrrV8OMYyyVcveuNHBgZP7Fon+SUw5baHYS5Fz+UkLPAEkCj6pV9kOvK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758553847; c=relaxed/simple;
	bh=shbNuIMNTIvGPcWi4JkSEiRj/eJEUs+EDGP+qunsASU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GzeKs7DLwLao+hcTpeBJOdgFHPHhQLxsB8+nyHbmknWoT9Fh3CRaPuJa+jydahoKR9COI3tBZQfibjwUhCaEud3v6PuzjBlsk6jh2kNxaYJjZ5gly6vyVrLPgMK9xOImtpM2FVjv39UH3hsIyv76ZrIN+W9Hlc2s7S7la4sEllA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYVJ7PfF; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2698e4795ebso44902985ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758553844; x=1759158644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QeKEMoq0INFY9SFzoLjx1GtUOLFalE390u+VhOEOs1M=;
        b=EYVJ7PfFjSfLOKau/jKasLl7nQJdViXiZ5n/VZ2TTlF0tjghV0yAl1gFJvKVYEjs+Z
         xpvlS5OLmCQndRquF8TxUHSKIody51f5UU9ihusrb+KPTbE0gMdOrPLLNxR3i20JSUfJ
         iG/qLpM9ZpnUkgcjEf3tw287BN8r+wo9lHH0tbSrDtyfT2x9hWa1m4z3UtWE5vgkwXhn
         cFhQH45TD/X7pa7N6dVGqoW9z+cmdBODc3T61sm4tGZQNiIV24KhkDJ5jtNvWxZt/MOL
         Ec6ODpiWyUbbG02MqvM78mPedCFcQo2Zlk90V51qjUD2AKW5iQX6xwYyiDLxmhhuk+fM
         WZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758553844; x=1759158644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeKEMoq0INFY9SFzoLjx1GtUOLFalE390u+VhOEOs1M=;
        b=bP0ktWbwhEoH+gA+8o7CDNqDUIiptsilOBqLR3eyfcvW32g+7sMGGleQiOqfTrOH5v
         M3WDM7vKkU8DLHu2GqydhLyGBXp2+3oC/lkmAw6qU01SlELs1HYhaiviFpW6xFQ/TI4q
         RQudmEr0V6vC9JrqEH0o5uYqXfJ7BXhXxXs8ZtEMPIdXiQdbBmRLujAOPv8wI7Rmbn1y
         cOIbU+8YWIPAJx0mEs2VgWv/fVBJH81dFG6mqlhrqh1iadGoXbtzdoM/xwoKN3QBGNZq
         JMmm39hROGbDuI6QqepUOa+oUlA7ibPOu3ISLH2GNIlAPZgcHrMW45UJuTa9iCxRwHY/
         ObWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWC3UGp8NbN0P3t9pc8dS5G5gwJWnNfUIFMMwBshauuQulgCP+1vhlikUxtxlNRsn76u5yXjdfD4Zopf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxevp8n+OUuh0yIgg2CMo+OBZl/6jcp5Vk13UMD3u0bHFDc8Mxm
	xyWYiKEwFAIIvBptwosL8reLjjoy1IJto7Xnhnu8ShkyFq0B+VG5fCee
X-Gm-Gg: ASbGnctEdo5kERAoHdyTjMZifq+sX3sUugHc7ZqV8HlRk9Um5pZYr50qSzF5/U+XxaS
	JssOEeksZddpx+IlaUwiAkEmhRAh/SpxR/T4zFAUfRrqk7z1xpjE85dtzQ0ld5Ki2n66bLjkCW9
	AIccksOXQBC+ecnoeHBcMbmX43btwxiVNiflrpLI0YTm7z+qRCSzDQUBwc1LlPxav5VyOVDKbMM
	Ma3l1pepK3170kh8RBQdlEwRaVWiPnCK/4y9xQAcOVLQDgc9He26IcWB3wilPIqz3RywkzFerA6
	W6ZmJZOLhpNJhrtc5jigXWP7o96jGqEN4V6ETPHg7bgo19hA+KPP9s8/ZdT5uGjl4hyRz+lj3Ks
	f1gZBoRyilqI76vmX64bqK4Oc
X-Google-Smtp-Source: AGHT+IEvD9hsVBCMMBEEbvP8hFwp/v5gBhfqce58IDIzHbs1uD6mT1IGXhLlfqK/ToCU+antLZSz6Q==
X-Received: by 2002:a17:902:db0e:b0:267:cdc8:b30b with SMTP id d9443c01a7336-269ba554c27mr147031635ad.53.1758553844543;
        Mon, 22 Sep 2025 08:10:44 -0700 (PDT)
Received: from lgs.. ([2408:8418:1100:9530:3d9f:679e:4ddb:a104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980180bdesm134733995ad.56.2025.09.22.08.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 08:10:44 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	"Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] powerpc/smp: Add check for kcalloc() failure in parse_thread_groups()
Date: Mon, 22 Sep 2025 23:10:25 +0800
Message-ID: <20250922151025.1821411-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As kcalloc() may fail, check its return value to avoid a NULL pointer
dereference when passing it to of_property_read_u32_array().

Fixes: 790a1662d3a26 ("powerpc/smp: Parse ibm,thread-groups with multiple properties")
Cc: stable@vger.kernel.org
---
changelog:
v2:
- Return -ENOMEM directly on allocation failure.

Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 arch/powerpc/kernel/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5ac7084eebc0..cfccb9389760 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -822,6 +822,8 @@ static int parse_thread_groups(struct device_node *dn,
 
 	count = of_property_count_u32_elems(dn, "ibm,thread-groups");
 	thread_group_array = kcalloc(count, sizeof(u32), GFP_KERNEL);
+	if (!thread_group_array)
+		return -ENOMEM;
 	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
 					 thread_group_array, count);
 	if (ret)
-- 
2.43.0


