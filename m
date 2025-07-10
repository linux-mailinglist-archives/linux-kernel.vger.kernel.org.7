Return-Path: <linux-kernel+bounces-726520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB0FB00E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6643A7F1C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581012BE052;
	Thu, 10 Jul 2025 21:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbTcyh6R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C04C292B3E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 21:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183954; cv=none; b=op2I1PFtjNrjdrmlG+DGSY/AA284Wp4zSXwodB+jUymKlrBIw3iVumgIpywmXJv2omuUjuSYj8ujZI3O8v8nIq3rFX4ZDBA4EDeUJvPUwvBOpzYYQG8JYfTCags5IcqzQKI4a04usrUn/C9c8J9tKYHg4vBKf+Bu5cxljuhxI1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183954; c=relaxed/simple;
	bh=U/9ZXoZ5QghqF6gzuQvtojlHXus2tpFvDXjRDjYCM8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CW5dKyINDt8a0DUAMoMct5s+YqClQJ9PITKp10RIVePIs7F6JTBDbcpPL97kUBSEKJhp7SpSzIYaDADWif9PEten++4dcjPFNW5piTN+Na1uWWoqpEEGQHBHdJwCrPZje1twvdn3tQ5clRp967bsJ3nPdO1yq9n0LXJuymMPCJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SbTcyh6R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752183952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4/N9KdTRimopScX3z3DCCr/6evGNQY2mClyDYSaLspM=;
	b=SbTcyh6RCciirT8kGCaUlNME1StCDWhQnPlVkt9v9deo2bgiVM9502Ly7crtSl0TDUNXSS
	VFzx7LUtFjaqPSDEqkzONChUOoxrv3o+t4EzeGaQkE1zkEYvnhmhLfZox8fuji8nBfp+Ks
	mtBGl0JiCVQbmPvR3JA5VrcM0WvDIFQ=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-djFfbrSxMzS4yqb-3nF02Q-1; Thu, 10 Jul 2025 17:45:45 -0400
X-MC-Unique: djFfbrSxMzS4yqb-3nF02Q-1
X-Mimecast-MFC-AGG-ID: djFfbrSxMzS4yqb-3nF02Q_1752183945
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4139102c7f9so1139080b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752183944; x=1752788744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/N9KdTRimopScX3z3DCCr/6evGNQY2mClyDYSaLspM=;
        b=vE5+uRWCrC337FX0+LbtMwnzLFxZgfIimAMb/ha7UaikBDtmcmnH2OvbxgWw0p0BNb
         h2tSEM9Eh121TrDFFwlWye6qWOJ5XrHAiz60U5BmUI72MWNybb/hZfFwK0VEaafJXWgN
         8kLWPGjxpg/WbkVufXZiDn4fDttrB0HdTDG3ZDSejcx0OQkSQK3C0pH7PhZkBvKG5LFp
         TOmJzs6JgsTg500G/UgJUwE8o0h0ffnxwlqlmWK0wbKznxx8bv9cmTTXrvxrayg5dkY6
         yF1B9F2iDViLK4r+LM1kUkjwh9kF8xSe0Ah3DwEivDO0fErRKVxWM9JL2RGk4IA6h0lU
         BkrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDtXYeNI1kjBgwRwjkUPQyhnrJKk2E04ied/THRfMVWPu3Cmm/cr1s5ddM05w9AfR9db4n8rCRqjfaaTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJHH3S8v4QunY7vk25/+MMj05jf72TjjS+XNZuEzGVkwI/3Srw
	jpDuQgCYpsbg+wlwfE9rZoUcphNBjdtZ28V1lPcIgY1Dcl9RFFlfPm1PjXcvMmlb4/mFRvvCLC5
	/MclwiYVEJsGkl+GnmR86HkotiveJl55hBzVX/kKCsA4T25FiEEQuByI8cIO7V3Fu1N9NIvbPVs
	6NDsJlRA4q05iqj/Y6EguGR7IwAiQ+AWV7PpRlj4q8VgS+obqTKgM=
X-Gm-Gg: ASbGncsoyJBI5CERX3r9KwF84vNHTfNQf9uLoV5Cr0lBJs95e4LXPbm3tErPto6mwx3
	pLygixxnOPCNog5ZoNA+ynBzVSnN2iWY9iCTHrYX9RBSTwygOQQ+ePU+9ZxALptZT5wvhmwcybu
	iGxpFSU+bU7fcAnLUjLQSItyfmsGpNkvyb7ZmX7mx6T03D5ADKObZXjT08aqktIBcGB/drGU7qb
	HHdfFtnAEmJ6YmfeoSbaNoUZdrsk1cEaU1hkMRHjSu30Cr+yliPA/TW8sHS8KTJqYvnRymTHN85
	l8gUjWBFoEZp9Y9dlkRUdtAcqsSjqHjpv/X6HB613guX
X-Received: by 2002:a05:6808:23d1:b0:40b:4208:8038 with SMTP id 5614622812f47-41537183318mr413466b6e.4.1752183944281;
        Thu, 10 Jul 2025 14:45:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHehwimPSJesNgLHxM+siGqNnR+E/LIcmlGE7wN03bVYDMmX9HbSYx7vDjYGJE2IsVe+HtWEw==
X-Received: by 2002:a05:6808:23d1:b0:40b:4208:8038 with SMTP id 5614622812f47-41537183318mr413444b6e.4.1752183943975;
        Thu, 10 Jul 2025 14:45:43 -0700 (PDT)
Received: from [10.144.155.224] ([2600:382:8102:a87a:c1c4:9ad5:f0c:c0f7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41419baa00dsm345483b6e.22.2025.07.10.14.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:45:42 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 17:45:13 -0400
Subject: [PATCH 1/6] clk: tegra: audio-sync: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-clk-tegra-round-rate-v1-1-e48ac3df4279@redhat.com>
References: <20250710-clk-tegra-round-rate-v1-0-e48ac3df4279@redhat.com>
In-Reply-To: <20250710-clk-tegra-round-rate-v1-0-e48ac3df4279@redhat.com>
To: Peter De Schrijver <pdeschrijver@nvidia.com>, 
 Prashant Gaikwad <pgaikwad@nvidia.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752183937; l=1579;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=U/9ZXoZ5QghqF6gzuQvtojlHXus2tpFvDXjRDjYCM8Q=;
 b=rBm7wVa6iZ9fX/flsyK+3l+AwTVnI0spNGyrAFjfS7Q4BhOujMfuFO0y4LvuBCZyzgqmkdtEj
 bUdOK8DFj7xBqL6qsFu26AfPoxtD0R9jMWwDN+7JtXcu2dw13LIpoQg
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

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
2.50.0


