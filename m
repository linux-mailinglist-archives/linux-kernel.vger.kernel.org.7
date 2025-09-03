Return-Path: <linux-kernel+bounces-798931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763C1B424D9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1036567AA4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01FB223DDA;
	Wed,  3 Sep 2025 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLpLEO/G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCBE225A23
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912533; cv=none; b=MB6vePsdF/njyIHCES0/ouTi54pOoAMMYhWF1dopO2um/OBgb+6nd/49QX9/kDB9GIvBGiB9+2atNuQwXp+PtYsmw6OoA5FNPeQ0OYYGCt/FHHlic9GsEq92zmZfJ5wOLcectpWLWTQPH9T3RzYG/uBO7pHDPjv+8OhhuSwEHgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912533; c=relaxed/simple;
	bh=P/K1i7FofzljhrSueDv/pWynCeqTvU5xHXstL0F7owk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bduvbw/PcH4wTZRIusNEHeduqTnRc2W/2SL6K9Lld99DNRiTHV42upkp61yBFm1NHN5jauTYDHgweDDTFwKQpdqDO5gSMclMfY9uwh80Fwln6QcRnmMjFD3lOvKNDVVkgucGumSdaVzCZmXZp1qoGQzXtMcwSKHQW9SpjzycoYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLpLEO/G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756912530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8cne1IA1KPb6ZTLi6iYFaT1l8FItUau4GOBy9fEXnFU=;
	b=aLpLEO/Gpm6n36oZOlZGrCssSH7k9ShawforViBXMJwTQETcIFb+QeVJBOOKYyFJrGeklL
	CUBSuEGjTNYzRljDwqDQN6wOcbOXsNcXIqHAbmE6/s/QAI3GSFJ0cgltiDbuWKhwgZDXUE
	KYyU7WT2Pm8kshQin0rffNStO5gEKGE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-hd5bHrujNpidFmeLvay-nQ-1; Wed, 03 Sep 2025 11:15:29 -0400
X-MC-Unique: hd5bHrujNpidFmeLvay-nQ-1
X-Mimecast-MFC-AGG-ID: hd5bHrujNpidFmeLvay-nQ_1756912529
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70fa9206690so17766906d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912529; x=1757517329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cne1IA1KPb6ZTLi6iYFaT1l8FItUau4GOBy9fEXnFU=;
        b=XaD4Beq/l7JyEZNSiBXNPYIJ1A6bzlfphq66P1OWDQOAPPJpoqlEVqz7heYi1JovFH
         bltqZwX5UgTKkprJIOOCn8AE+ISaXDD94FajgYfaTCQyecJRNFiaNrMogzdtSVDz5ynb
         kveXf2n5OeidvWlbthoSZAtFtuYh0FT7VSCiWkgvXbaNUPELkw4SrZlNgNnVRTtQXixs
         MUfq/0q2i6SMiI2c7GltAUihPWtIQqqNaNgztVhl5XTd2ric47koCpotDaCUtZk5ayuF
         GKlZQpt6wwrjX7gVmDyrjweBFiK/BWVY2+q5I8BJN04RtFuD3lQem6id3IuSbXkWgeGp
         AApA==
X-Forwarded-Encrypted: i=1; AJvYcCWYTK+ypT+ztModrYbhfgQ6rDoGAWBoif47y2lUqYsWGTJ5AH4X5T7jrW+F7KJwxs9iNPtA1GjULGM+9ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIytJdBhb2AHjzZrsbJikyEnScTn7IbDbhg0qhRHh1cXjgDPbg
	TX3SbHs4aL5Jwunj0MlkMbpH6Y+WRlaO0rGkbLyvAkOtNh+3X/bCAOjs/rIBgJ7WkStS1lC2GHd
	DxbFm4fNzNnz76k7smYAWp6QEUCP6XrMCghPfJGq4LtbhVZ3yPoQwN+ORM80ryNpOSg==
X-Gm-Gg: ASbGncvyam8/pQI+PRehGUAbKi339AS4QA7DGXAyQ0NW5RI8jG0EcaS2XXuvkdPcLw8
	GcEEQa9pJnZJytoNr9hlmsCYlqL9LYi7jHVSXKSvcOCQ8X12dCJxcepATjb1fo9Lnylx6Vr7Nnk
	CjXoF3v0qbBzQcbjBjwc/9UC9pizQcEfwDGRzs+X/ERX47VZnuaoW3TUc8OLxXA4/SGUPuxw3eE
	p9N9w90a4wugvBgl7DA9vVsCkun6U+pr5GNBymZAlGrdlLRDrnwGZl3fZqq4c14spZgzWRIlFzO
	E2yCA0a0qGDr4zqMZox7LJKF9fQsQBEGxeHtIqDv8mHNijJ+ho4Bg2UnWGLij40aR4T+gCfh+NI
	=
X-Received: by 2002:ad4:5bab:0:b0:714:36b2:a260 with SMTP id 6a1803df08f44-71436b2aa69mr119383886d6.0.1756912528519;
        Wed, 03 Sep 2025 08:15:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKzf82nm21b07pPChbmaSLNG0cWMiPFqfO23yrmL4+PQzlGJM4jozMFEYUd/hUiknVHZDi9g==
X-Received: by 2002:ad4:5bab:0:b0:714:36b2:a260 with SMTP id 6a1803df08f44-71436b2aa69mr119383076d6.0.1756912527470;
        Wed, 03 Sep 2025 08:15:27 -0700 (PDT)
Received: from [10.12.114.224] ([2600:382:850c:786a:ff8e:13a:e47c:3472])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac16de16sm30827706d6.3.2025.09.03.08.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:15:26 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Wed, 03 Sep 2025 11:15:02 -0400
Subject: [PATCH v2 1/6] clk: tegra: audio-sync: convert from round_rate()
 to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-clk-tegra-round-rate-v2-v2-1-3126d321d4e4@redhat.com>
References: <20250903-clk-tegra-round-rate-v2-v2-0-3126d321d4e4@redhat.com>
In-Reply-To: <20250903-clk-tegra-round-rate-v2-v2-0-3126d321d4e4@redhat.com>
To: Peter De Schrijver <pdeschrijver@nvidia.com>, 
 Prashant Gaikwad <pgaikwad@nvidia.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756912523; l=1671;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=P/K1i7FofzljhrSueDv/pWynCeqTvU5xHXstL0F7owk=;
 b=WIU9TP1V3lwK1E6Bzl3annZF1C3X/dJCzNEowbNKKUGh/2qhcuD2XUgjQlh59rAwf72D6j2EZ
 zPdaX3KzhjGCwHySbROqsYWV6u1zxKdS6xuPBft/N1d2s+VikDW4r19
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Link: https://lore.kernel.org/r/20250710-clk-tegra-round-rate-v1-1-e48ac3df4279@redhat.com
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/tegra/clk-audio-sync.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/tegra/clk-audio-sync.c b/drivers/clk/tegra/clk-audio-sync.c
index 2c4bb96eae16e2d4da8740d4596cdb562fd65e73..468a4403f147a2bfbff65b34df8b80a0095eed15 100644
--- a/drivers/clk/tegra/clk-audio-sync.c
+++ b/drivers/clk/tegra/clk-audio-sync.c
@@ -17,15 +17,15 @@ static unsigned long clk_sync_source_recalc_rate(struct clk_hw *hw,
 	return sync->rate;
 }
 
-static long clk_sync_source_round_rate(struct clk_hw *hw, unsigned long rate,
-				       unsigned long *prate)
+static int clk_sync_source_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
 {
 	struct tegra_clk_sync_source *sync = to_clk_sync_source(hw);
 
-	if (rate > sync->max_rate)
+	if (req->rate > sync->max_rate)
 		return -EINVAL;
 	else
-		return rate;
+		return 0;
 }
 
 static int clk_sync_source_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -38,7 +38,7 @@ static int clk_sync_source_set_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 const struct clk_ops tegra_clk_sync_source_ops = {
-	.round_rate = clk_sync_source_round_rate,
+	.determine_rate = clk_sync_source_determine_rate,
 	.set_rate = clk_sync_source_set_rate,
 	.recalc_rate = clk_sync_source_recalc_rate,
 };

-- 
2.50.1


