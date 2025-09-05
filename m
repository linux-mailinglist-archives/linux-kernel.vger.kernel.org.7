Return-Path: <linux-kernel+bounces-802538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4036AB45382
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E651B2267F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090C7278751;
	Fri,  5 Sep 2025 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b="aaN+h4wA"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BAB277C96
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065138; cv=none; b=R9LEFavr/qPn2S6gY+AWBFiRIK8zn8xUXbOiHQTpkCanUlVigTTAGZQKh+37qFBK+mFlVQMMXYNesYmgoA895meWA7uWDmAWeRVpjAoZNfpx1E3wcXeg8F0ptZRnZ9cWlLSQ5FpKPM/NmJ6ESWNPcNwwWwzhvwXT4kdjWg6aauQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065138; c=relaxed/simple;
	bh=DQzqJSkZtdf2m9T83N17crffKyn7mU69jfmQVqs9XxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tU4CfDd5MSRerGeMbjH9+9b69EYPNRNTYCOH7XbRJiPw9rZ9uIS9NdMTTzdWbaGJmjUHL1Q8FpI+b1gb1ACHYCSj0S5AUon3fQ5Pj1oyS3x8liwRHg1iAwVAHcwRs429VQ9XuCIflb62GtS68tLd1Llil6xmvYdXkJUiPQNP1sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com; spf=pass smtp.mailfrom=aisle.com; dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b=aaN+h4wA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisle.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b00a9989633so352095466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aisle.com; s=google; t=1757065135; x=1757669935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8Lga1GkOl1oDiE+1dVHrqOvB9vstlkU/NOIqsz7Q7A=;
        b=aaN+h4wA3465qC28QM+eRTSaoFHeaqr5J2+wDrPvQWbMFgiVrQ4j2Xl3NNrJir6jdo
         uzn2pUdfqyTKKRAaC0vtJfR7ryLmwkNYJf+cHFLSvRG8+Dq9MCpdfN2wGAK5BoQAbjDI
         hjAlZ6TaqFDbJRC+Xi/titBmvO1CFV3b1PS9HiuOawloLfQJcwlCOKRNrra7LqWwWokb
         sIWPmfUkJCO8/Z9kW0zD/KtkZBv9d20Mx1SGfMEQFoQJqzbsTzXPwa7oL/W5WAOVHmL5
         W3vXMZszXAgjKY7f7FCzvjZLGcR+6nGsWIJH/vekLIJBHnGInswjV+rmkryCdFzMMdx1
         KIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757065135; x=1757669935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8Lga1GkOl1oDiE+1dVHrqOvB9vstlkU/NOIqsz7Q7A=;
        b=ahE7atKeKJcIX0XDAg85v3JNML2EIcRhqZENlJ+oh8pOYxk4n9yITvPCNT5lvv4Pe0
         /xlNvkCSFyfxEA89Fs1cahZi2khW5jbl86lHRT+qQpcY7XWZ7OtqNBfZq71cGTpt5uFo
         BunT03yF/G6e/cixqXn1fBcaAvu5vKJoa8w1MBV0UAEda9mwRxYEup7c+tW55H95tgZC
         hB46qhKIHzPtprGlPlI4T2rY2eBuf0RhQrTeYfrRSa5FiPZPki3OqN/Hjv2qZi/6FCNT
         GgjTMtWXtFtlh+3zWC+x3ax8mCMMpcz6ZtRU5R75bYOavjWybHGB+cso1eXeHOQ13ogZ
         7xjg==
X-Forwarded-Encrypted: i=1; AJvYcCXaqQONmWAQRFVQ7vR2835LDhGzpgakHvY3RFWSsAOJQuC1zSg8hXqsmJhRiYo1bMNIgZ5DQNltUV6WKlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4VdsAUVKRgnvOdPv5ZPehIui1wN5lwtu0KRxpSfoHZhDRdJO6
	nAfwZPN6p75OXoMeRhd+MPW28RM6ib79IkSGWkiloiEvGGyLzDMSxQTWMORueFzKxIM=
X-Gm-Gg: ASbGncsGruugPPsnXaASZbWltgygd1tTIUzf6CuWtZdtZLOXdGe6cwzkzPdsvHtmA3r
	19r/1c0YaFbDS5+dASu93H68oMs1/j+LtnVP2+xFX+IrNbcQVAO2oUZMu7DnZudpFqC1v5g4HwK
	swTN+Njm4dNvC2KzJQuDtuzFKU87Bo0tpbJeQgNLgHwQvrjnqHdhqZVYAnMcc9229B3FzyVPksI
	ZOm5UZFchJpFT6KdB1nzFmyuL5CXHQVTLqfh4W6su6P8XnL5fIGOHpeWNBFKtWR20YUboK71qvP
	j4cjFo+8TzUxqVUwCnvkgiBLXvurKlGuJTxWtufh88UYCFPUCB0etKhiKksNcys5BA6LT5wugg9
	dFET6bU3OUhc0AOfEFRLWhShaFmyZalXsUJolVFD370/6VxI=
X-Google-Smtp-Source: AGHT+IGybuK6K/kujLTwnL+Fz49sav06Z8CCw7Z9351OYmVQ4LWXK44fzX23p7+KrdEaFzCMcOmACA==
X-Received: by 2002:a17:906:b24e:b0:afd:eb4f:d5d2 with SMTP id a640c23a62f3a-b04931b6715mr240740366b.31.1757065134805;
        Fri, 05 Sep 2025 02:38:54 -0700 (PDT)
Received: from localhost ([149.102.246.23])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b046df9a44dsm561055366b.70.2025.09.05.02.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:38:54 -0700 (PDT)
From: Stanislav Fort <stanislav.fort@aisle.com>
X-Google-Original-From: Stanislav Fort <disclosure@aisle.com>
To: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	stable@vger.kernel.org,
	Stanislav Fort <disclosure@aisle.com>
Subject: [PATCH] mm/memcg: v1: account event registrations and drop world-writable cgroup.event_control
Date: Fri,  5 Sep 2025 12:38:51 +0300
Message-Id: <20250905093851.80596-1-disclosure@aisle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250904181248.5527-1-disclosure@aisle.com>
References: <20250904181248.5527-1-disclosure@aisle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch __GFP_ACCOUNT to GFP_KERNEL_ACCOUNT as suggested by Roman.

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Stanislav Fort <disclosure@aisle.com>
---
 mm/memcontrol-v1.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 4b94731305b9..6eed14bff742 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -761,7 +761,7 @@ static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
 	size = thresholds->primary ? thresholds->primary->size + 1 : 1;
 
 	/* Allocate memory for new array of thresholds */
-	new = kmalloc(struct_size(new, entries, size), GFP_KERNEL);
+	new = kmalloc(struct_size(new, entries, size), GFP_KERNEL_ACCOUNT);
 	if (!new) {
 		ret = -ENOMEM;
 		goto unlock;
@@ -924,7 +924,7 @@ static int mem_cgroup_oom_register_event(struct mem_cgroup *memcg,
 {
 	struct mem_cgroup_eventfd_list *event;
 
-	event = kmalloc(sizeof(*event),	GFP_KERNEL);
+	event = kmalloc(sizeof(*event),	GFP_KERNEL_ACCOUNT);
 	if (!event)
 		return -ENOMEM;
 
@@ -1087,7 +1087,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 
 	CLASS(fd, cfile)(cfd);
 
-	event = kzalloc(sizeof(*event), GFP_KERNEL);
+	event = kzalloc(sizeof(*event), GFP_KERNEL_ACCOUNT);
 	if (!event)
 		return -ENOMEM;
 
@@ -2053,7 +2053,7 @@ struct cftype mem_cgroup_legacy_files[] = {
 	{
 		.name = "cgroup.event_control",		/* XXX: for compat */
 		.write = memcg_write_event_control,
-		.flags = CFTYPE_NO_PREFIX | CFTYPE_WORLD_WRITABLE,
+		.flags = CFTYPE_NO_PREFIX,
 	},
 	{
 		.name = "swappiness",
-- 
2.39.3 (Apple Git-146)


