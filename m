Return-Path: <linux-kernel+bounces-805588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9555BB48A8A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505CC3A9E80
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6D021C16D;
	Mon,  8 Sep 2025 10:49:23 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA0E1E522
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 10:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757328562; cv=none; b=uHVK7XuHPMt+jQdWummwhb4txk+fNrSQ3L7pmXWltMitFYJ2AJT1y1npnu/JZk11hB/TIq5153dcyC2GeV6o+pJBe0nSdmZe7jZLkK9lVNFV+dj5n1nLUiR1qwOV1mxY5Qi86hKAWAyGKvs0rhIai+3xcHZaG30rP9TXiaLiU9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757328562; c=relaxed/simple;
	bh=/dSo/CYD5yJ+0cjN5qKw6paUBhrZChGJ1WbP/s+cBds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gHvYwNZ3+KIfy9noHuRMwKHMz6YGCJdyheYHdK6a5WDywSpmYbwWaLaAzcX/UNChJLkqkHhe78QWVzgp7BwTSwLIJ1t9n/3vWyE6fPgpt2RiypWxr91tG3AaTaqM8iQNyyYLnxo22rp7VulLr7g1iIwxq3QlgzRvDRfZWHJce+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dde353b47so6873605e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 03:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757328559; x=1757933359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Keak+90tEhiacep/ep64oaIwmjHIdVQjUONDEIU0lg=;
        b=RyZ3Mc4YfgEW1bWI9X2Rmzwx9xm3HoDJQMsNET0UbTSOS++2Hq3JpJa9M60K+17K81
         ZlRY8dMl5X1vpIgvgBFYYkCe3SpQzXn8L7S6pWOznxg3WYH/+fsekMhWc1kGjwVJROS+
         S4GbDmPKAuNd8cVVlKLoRPVkWvaaErvokvyBMgyRtFXsUCosoGsIT19orE9T6lwsejs5
         WyhYhuNlXM8sLeLf8JluRlDJ6+sBGWW07F5hP30OqTbuyyY1vYHu1HyfvjSP9Ie43tCW
         gDQL7iPxz4dL7/x09onPZb+Vf+eX/p2T4Ba4PGEqJeEmEruED19rF11LGoU26Ty2754r
         CbCg==
X-Gm-Message-State: AOJu0YwVIK/vkXn4Kj86cQOsKOVo3JH74MRfJQaESPGaNhA2psFS9z1O
	kZxhUbZBjUqZUymUtI89WROJzXtVuRiOg0Brr6ljGqpMgWsyWdxJB5RN
X-Gm-Gg: ASbGncs2+Skv3avn3WKlidVi7frblyr2lcQCWGNWi7F4CuI3QNuC0twRBvkJN6z6Jwq
	YdPIzf/jAb5OC/Az92U9Jukhm38UtUuhLk9hh4uD4DP+uIBmIcRwc0YQBj2nngT7dgT91aqiB34
	8RaglzDXbFiRHH/Z1RJxRKmEVqkWD4mMyyM8XhaWNhLfte4WiTnzVDSVJ0yh5cmLq58GxDLL9Sl
	HQ7ybWIM6ix8eKTY7mKnWjPgOOD7V2FkxdJMG7OvZ1bkRZIAOptRRcFWst6F7PLV7OEKKm+ySKR
	Wj1GwQJl/4emciGjIyqLTy9WtRXG06tRfaG9at46EbNTcRfN0DPDujbPKTtdT+86TDlyQv4XuGH
	8D8EHsak5IjdD5U+B77Ofv4uEA6U=
X-Google-Smtp-Source: AGHT+IE+mCtXoFLvXyUkJ6eZPH/dI/HGOed+wYphRuAZoktW2IPd9t0E+szoZlTIDfehTWk+w7azeQ==
X-Received: by 2002:a05:600c:3113:b0:45b:9a3b:34aa with SMTP id 5b1f17b1804b1-45dddea2e63mr77643585e9.16.1757328559111;
        Mon, 08 Sep 2025 03:49:19 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a04:6f00:1::ee:b:1086])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd3aadbcesm164823035e9.17.2025.09.08.03.49.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Sep 2025 03:49:18 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH 1/1] MAINTAINERS: add Lance Yang as a THP reviewer
Date: Mon,  8 Sep 2025 18:48:57 +0800
Message-ID: <20250908104857.35397-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

I've been actively digging into the MM/THP subsystem for over a year now,
and there's a real interest in contributing more and getting further
involved.

Well, missing out on any more cool THP things is really a pain ;)

Cc: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Barry Song <baohua@kernel.org>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dcfbd11efef..34c5cc3b05cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16238,6 +16238,7 @@ R:	Nico Pache <npache@redhat.com>
 R:	Ryan Roberts <ryan.roberts@arm.com>
 R:	Dev Jain <dev.jain@arm.com>
 R:	Barry Song <baohua@kernel.org>
+R:	Lance Yang <lance.yang@linux.dev>
 L:	linux-mm@kvack.org
 S:	Maintained
 W:	http://www.linux-mm.org
-- 
2.49.0


