Return-Path: <linux-kernel+bounces-873167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F11CCC13496
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80CF14F8D69
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955681EA65;
	Tue, 28 Oct 2025 07:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+mWph9L"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974B82C027C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761636494; cv=none; b=VTQoXXv6LEGg2YxSOcjlgMNfl3+pg2N4zzFN9gEBqYt891sCUjMyywGNe1HC96+vC0my7KPOrbgPw0JzpHGIMj4kQsQkrNRhfULOhAW4DVnYBtbzC1iaU3DHxQ6s8lq0CTWA3mPHR1N+pwH0VY1+S3doiR+RHcJOqdtNipo/FSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761636494; c=relaxed/simple;
	bh=5jvvcHxUgGRqbIUWaLiz/WJRrwTzEZ0ZYpj0wMUTbX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwwvwLffcAhauKbp9w8sPCxkC9ZqUTslE/4LJRyDP0v0O2fUIj/CMqxx9H+64IRfp55HrcIHJxBsGjvcrGvc0lFii/4Vfrnssi12Ei0KJH4b+5Oc/w6seRcWlgQJ1eS5RNMwhzTdM4jbJnmLsqdYHp7NOpdXONC0kRV26UIpihc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+mWph9L; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-269639879c3so48475035ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761636492; x=1762241292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nktWl2QE6KyxknjQKQbtrA/rvCmzEXqRlRqq7ZLB0co=;
        b=k+mWph9LAkWqsZBmexAZ96zKggPU0iINXK80GFSGT65DZ6KoFVQtlIA6JfVvModYxV
         mqpjTWIOj1XLh+L3FHcOwwmytBsawFyyijRm4WdOKQxp1GdM8SB5PswxPkyPhVsHdQLC
         Va++92N3s9wJX8UTSl9l+iDbzbeCiznad3oW1o3/MS7hC8fKSC3CMEcihtEyhBuGQCt4
         nEEYC3FE0J9PBJgZgEUMn6xiOftO6CoAnHX6eYCiXeDTEHj7C5yGxpI/IK2hxD7/aC0s
         qWLZ+1yVjz0W7AN2pxcXKqbExNWDoz3Wd84PBookNjcSC/HVxCq1H7Zi1LdE5aApJwWf
         qvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761636492; x=1762241292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nktWl2QE6KyxknjQKQbtrA/rvCmzEXqRlRqq7ZLB0co=;
        b=MqbfrRtIjN0JfcQEOrjtF08X2wCbbxqAVT3rILYlIu7cjj7RLiWpCI6f5uhfHFATdN
         p9JqlZbO3ZM2Qe5cY3SmhuRkCdOqD+NdCMv50tCVrs1TSSYVcEm/tmhWHcLW9EfZTX4D
         UkbOcVEQYS55BGXuzkJ0hyRGIqvk5b+Bh4eGgdkYCueXEDVNz5LFzDk1+JRxVGV8r6yh
         Du1J/8DpoXDbmnboYaZZjwo048Uh3jSCpxtrap4KsD2Doad6geMVAoUCel+S9iPC85QL
         sCGRTxmCUHs+95CVadBce7dr3F3fjGGc8g/6Xae9+H8t0EcmKE5NfzuqSLM9ccD7l2uM
         Padg==
X-Forwarded-Encrypted: i=1; AJvYcCX4OkkadPgmzAq8R6cxNlXJnB/uLB8Gt2yfxKPIyd40YOlP9kh7a3xMyYc/DdudMZtUqOf0akDywoccsKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd2WG75PktbKiB76s2iU2XXyw5+eWVXvdZBrGYd6Zsji3MD4e5
	G1qItH6ZxYEMjOV8wUQxwh4qL7wlSyolV0nK35bkeliHOiQN362vcCX3
X-Gm-Gg: ASbGncvciQxxfYb+j4fyCCSEWGMqv7TaMV9mkOu2UMDDmF8S9aqmRqmwTbjcy5pMjAN
	pjYF/bLmkcycwMZ9QHDZbZ7c61ELJQgvt/C47YJDxplT62VfbV+PHhwjSSxunO1/Y//TxLETLPj
	LDC4lIjD0CTTaSk+DmGEyWlbn+dyQM/AtNzhoecoTIYcWtP+Vxr4Yik61BinrAWehUA+6SlhIDO
	ipRWJWdl0T2ni7AvymAFw65Fz9V33JoQ4pbYd2AABeSd8mD6ZbIoE7KAfnaBMjSf16AKJ17BpBo
	07K3HCTi6Fcieh/Diwe5evjScU2sPBclRcp3/yTrYqniYQW6g/w2cc58h059mkWNV7v3QQssF1O
	ZPtKZRrE8Xusk05DlMQDUg62mwMCELHm+9GddLKhOj1vl+IAH1IIBHhZ2tOio+ws4KaiOF8O3FT
	wAxwlqAqZV3lwXxw==
X-Google-Smtp-Source: AGHT+IEKTiLgH0R/bRPXbcPiopPoUMdKq0Is+SUv85mcT1iNGvD0tY2fXA7nq6m7Ri3Uue3XCkC79Q==
X-Received: by 2002:a17:902:dac2:b0:27e:ed0d:f4ef with SMTP id d9443c01a7336-294cb51ac17mr34713495ad.41.1761636491819;
        Tue, 28 Oct 2025 00:28:11 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:7224:bdaa:f2c:3fc8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7128e41c01sm9400361a12.23.2025.10.28.00.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 00:28:11 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: akinobu.mita@gmail.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	hannes@cmpxchg.org,
	david@redhat.com,
	mhocko@kernel.org,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com
Subject: Re: oom-killer not invoked on systems with multiple memory-tiers
Date: Tue, 28 Oct 2025 16:27:36 +0900
Message-ID: <20251028072736.10455-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022135735.246203-1-akinobu.mita@gmail.com>
References: <20251022135735.246203-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lru_gen_age_node() checks the reclaimability of a node using
lruvec_is_reclaimable() when min_ttl_ms is non-zero, but if min_ttl_ms
is zero, it unconditionally determines that the node is reclaimable.

I think we should still call lruvec_is_reclaimable() to check
reclaimability even if min_ttl_ms is zero.
Otherwise, we'll miss the opportunity to trigger an OOM kill in
lru_gen_age_node(), which will cause the problem I reported.

https://lore.kernel.org/linux-mm/20251022135735.246203-1-akinobu.mita@gmail.com/

The attached patch made the changes mentioned above and worked around
the problem.

---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c922bad2b8fd..e1a88ed4e0b0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4148,7 +4148,7 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 {
 	struct mem_cgroup *memcg;
 	unsigned long min_ttl = READ_ONCE(lru_gen_min_ttl);
-	bool reclaimable = !min_ttl;
+	bool reclaimable = false;
 
 	VM_WARN_ON_ONCE(!current_is_kswapd());
 
-- 
2.43.0


