Return-Path: <linux-kernel+bounces-798936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E803EB424E5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D70585EA2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3D123C51D;
	Wed,  3 Sep 2025 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBGUPtwM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AFB23ABB6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912545; cv=none; b=SDPuMrQsWl4dzQfcN8bozmVkDDHji4YaaoAUBCbbnXS/J/UKCGzYTabmK6LiNPVp0rpNBpKklWNPgvOuijQSTe/27B5DfzQ25z37zOzGaxI30y28J3txF4tdsHDuUzVzWBKd7v+n/BAoFa6FKMJonujJwBlKYHNKjS1vkLcL9U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912545; c=relaxed/simple;
	bh=xHYSF20Z40O1IS/P13jD4/OabcPSIx9zs970N7AMeQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OVHDIGJ0/j9+kd6WvWAOd3Ug4/0ihE3z6f+t8lA7g3K9iobtZxt+/TkpBYKo4epBsVhD886iACjAjYW32gE1O0ImPHhxVheu2pg0RLjgp14aUzog8Yu12RP+oE52WM0ln6L6s7OUqzNSGzMUz8GaHw63YL9MsL9jg/R3h3qREQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RBGUPtwM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756912542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4DqnCcjwRpbK8o4p2iXe6lSoJojb6f7QiC9/BUgcCv0=;
	b=RBGUPtwMXXy/wflSHnDPCk3KKf11vWrDNKRTHN17zvUP9qJuw2xYJOMFIyXR7X2jGxV4Rq
	iiX6YFSnhzaeQtFCn3BFd9OnfvF7mZTsqoIh3O+UBGSijG9V8xxgIAYYqirPgOvdiducXL
	0K5R5S6aWkJf52RQEJ03qzf9S4qPfwQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-9egDOlKRM2mvYNwW1Sc35w-1; Wed, 03 Sep 2025 11:15:41 -0400
X-MC-Unique: 9egDOlKRM2mvYNwW1Sc35w-1
X-Mimecast-MFC-AGG-ID: 9egDOlKRM2mvYNwW1Sc35w_1756912540
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-72108a28f05so57533046d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912540; x=1757517340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DqnCcjwRpbK8o4p2iXe6lSoJojb6f7QiC9/BUgcCv0=;
        b=Ff6sqkINxN4gYAhxqTKMM1EBcz3hys2c9k5jjPu8oMFxoBbcsRbVgnxmrYKPkVejyl
         qNUkmt/KbjrWn3v9vwxrBiyvqiV3b5GQOVx3HvHwTRT+b4BQCv3eQBdzAXsH5yt5azBM
         W0q/D31l3Iv1YoSz0lZ8laLU7apVm9lIP5zJxZwH2k61BreC+ZBwmp3R/i6vO2tYEJlm
         /v9qKGtYhaZOjmb661V2nHiHHev/kw2K8uu2lVWGXJPduGYPDwPn1aFaBh8L1n8xlryd
         1Drqc0dnusZY1YUm1LNDNg8oDiZFhrJ/ZCcmKtZiC2r/OodUUyalqADPIJD/K9YuNhHA
         9NEA==
X-Forwarded-Encrypted: i=1; AJvYcCXC7xI323CBzoLXk/LtEdB0kt837VDlHOWXoegOpSS4Xck7JNwy9bpO+gl+TTUlS9biCLUA40cJ2Z4vAzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeM5XMYAoZLOuE7C6f76TomwXIg86qmBb9FrddJhtyVbRBG47E
	mAqklGCYkzENMXyG75Ax8Aj672UwakoX4l9qQp7RzD4cZKjMBZb2SBTIj6OirAdOE2yX1C3uMoR
	F1dtE405g13bgwfLPC618Vd+7nlj/x09jmB1nu+7ORAZrfVCLxWhF/NdUkE/ymUmTRw==
X-Gm-Gg: ASbGncudebBbKz/kqwN+7CeMYCwVOGePLrXkef+NzrclCSXjF8l9DP+s+YUMMOE4hEs
	d4tsCUDwVzH+xA47vHAXEIwX4YigRn4t46k7jkwOD16mfm28iMFN5JkkeABzTbIOFHDt0yVFwta
	eQVS3AukLHAp8JLm6KTVKbR6WmM1ENTBpTjKegJmDrD4vNuZusGNO7eJCqrsI5guRN5KNKkfz/L
	UddaTrYLLjw1ELLAhl8wpvKNwH8VhydOipbiAdQx5PErRyVWwSWYrBxYgrUEMDWr44hryzj8R1Q
	tzVkYHPIwWgUg6Wo82Zxrcc39ZRswVI/VAdT20Nr9XyzryRkXgSpGn8ULAOx+PASZr5QHxnhTPs
	=
X-Received: by 2002:a05:6214:501d:b0:712:e30b:ef1d with SMTP id 6a1803df08f44-712e30bf1f3mr165062176d6.63.1756912539933;
        Wed, 03 Sep 2025 08:15:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5I10I0WKxYKgKAEy94Wym7iHHUY6i406j/dnJpfUUA78DHHNcSjK7v+PoMe2ZX5mXlpF6Hg==
X-Received: by 2002:a05:6214:501d:b0:712:e30b:ef1d with SMTP id 6a1803df08f44-712e30bf1f3mr165060786d6.63.1756912538520;
        Wed, 03 Sep 2025 08:15:38 -0700 (PDT)
Received: from [10.12.114.224] ([2600:382:850c:786a:ff8e:13a:e47c:3472])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac16de16sm30827706d6.3.2025.09.03.08.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:15:38 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Wed, 03 Sep 2025 11:15:06 -0400
Subject: [PATCH v2 5/6] clk: tegra: super: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-clk-tegra-round-rate-v2-v2-5-3126d321d4e4@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756912523; l=1247;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=xHYSF20Z40O1IS/P13jD4/OabcPSIx9zs970N7AMeQ4=;
 b=N3/ppBwKIalyXCuBEW2R9w9ULDE/nReiU7B/SInxIldEMfFQK4/50ssw1KjHFQxbm//MjBL0r
 6WVAAeReogDDWplhQIpZ9kTvZzJ/B0C4NUYb/zmnGIQq4g+kbCW93kh
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate().

Note that this change also requires the same migration to
drivers/clk/tegra/clk-divider.c.

Link: https://lore.kernel.org/r/20250710-clk-tegra-round-rate-v1-5-e48ac3df4279@redhat.com
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/tegra/clk-super.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/clk/tegra/clk-super.c b/drivers/clk/tegra/clk-super.c
index 7ec47942720c5aa43f35107369b42804f4847b97..51fb356e770eeaea9d26ef48f298dbc00e164732 100644
--- a/drivers/clk/tegra/clk-super.c
+++ b/drivers/clk/tegra/clk-super.c
@@ -147,17 +147,10 @@ static int clk_super_determine_rate(struct clk_hw *hw,
 {
 	struct tegra_clk_super_mux *super = to_clk_super_mux(hw);
 	struct clk_hw *div_hw = &super->frac_div.hw;
-	unsigned long rate;
 
 	__clk_hw_set_clk(div_hw, hw);
 
-	rate = super->div_ops->round_rate(div_hw, req->rate,
-					  &req->best_parent_rate);
-	if (rate < 0)
-		return rate;
-
-	req->rate = rate;
-	return 0;
+	return super->div_ops->determine_rate(div_hw, req);
 }
 
 static unsigned long clk_super_recalc_rate(struct clk_hw *hw,

-- 
2.50.1


