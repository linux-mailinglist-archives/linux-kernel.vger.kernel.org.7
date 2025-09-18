Return-Path: <linux-kernel+bounces-822789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0BAB84AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F43541CF7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B94D303C9F;
	Thu, 18 Sep 2025 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4qE3o8h"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBFD19047A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199973; cv=none; b=gwZ/6Fq+vu4hxBJt7mnJDn+cpbcNblT4uAdoIfN3lQ6l/a9lZfXrfuf2IKtG0QgPf7O0VUpvunFoGNPK8Ft1IgP+KosueNMrHMKmkiyFTnLGKipnFY28mvhJvJ2BOpjRI5b/jYLeOxY2WzdYtCJEQRtRY0W/tRH/z1J8Qm8e72k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199973; c=relaxed/simple;
	bh=l4jvn6aXx33cUflG4BWjr4dX1HYkZKhcsuT1j8BtDbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O+nqSxih7Pd6w7V0dfvghMtgsfUOgfCgotl/qGqZCsFTz7EBVda/cjuS1zjpbwZ8HjjTUrN4zrDOAH8B9PB36Ex8A1eaDJjmqeDMZ8kQgcQ/XTq9g+eapKbTo3BgcJ7x2DdYfB7G13KHn/rV4/zEgJYxrXmFDsV5AKzKT4QqnDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4qE3o8h; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77d24db67e0so594111b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758199971; x=1758804771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+soGoTKEKPCIsNMCnKS6u8d5Eq71cxzpukoczL5FpQ0=;
        b=G4qE3o8hpp+Hg1oJy9A26Jo+K9pYwhwA2tstfjpbU7LnO/U1fyIF7dkvWC31Hm4wiE
         9rhMAZXy8ReINFlkRIPb/EKRJU8TDXq1gh2lNNWgQCAKmAFGae1QG/yGFXA5mEbhpKR6
         DrypkorhvN9730KVp9RLvglXzmtC7pIdFdccE3HElReQ7ZivP+pufsdyvCY8DGDLSwXK
         QWKPPVDXNWDvCFp3uF3wyoe7/LqI79bamDw/b+HfTkX9F9DsQ87Nm9RF9ZzSgOznzCIM
         yE2NaIpli2XmcM33CThydG2I847J8PbKtXlt7XQujIgcdgxhrJwI19l3nuIsrPZ6rNqr
         btNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758199971; x=1758804771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+soGoTKEKPCIsNMCnKS6u8d5Eq71cxzpukoczL5FpQ0=;
        b=PIcA9OPZF1CsW0r6+TMk1lAFvf208e/LKXX6VvyWZMdpwvuZJa8NjLVNscnlFna+55
         7jsJZrzlE4/K45rnQKpD/iu4Ea/25d88gDlpWRWH8PUhSPWPZJBaBtyekK6Po+AMCEf+
         c6LS/Sd4Ego2oI8uJ9wpNmCyKZocO965x3NRMkfuS2g9OFjp2cHG7BlQDZKGgfa4+0ZU
         i5H0+5k/kh5ySuaK35pjLiHO1um/oDBC9ok2hwf07kqwWpiPGitHgiwnZTy2wKYTum2K
         ERCOjB17HO77a5v8DEyTVl+qe7tqDusSKNsS7aZ/oiSnDnsltdzoyAvGtUph+4A3d6Nq
         0JZg==
X-Forwarded-Encrypted: i=1; AJvYcCWICTdvp72QBWoc1Rab6S0sT53BLEq1mFa1gxzF7YX33MOQXp4F2f2xK55a3Md22uzGv/w7ouItNFPn0Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ6omWVSrnVcAownKW1je8ypaP0gF8OLOl7njtO8ZN/nvIxoX8
	OZjAkl0GSPNShTLQ6v3p0DbP4LTQIXD3SkyQkAN5x7CHXSeqQkF2OeVN6yASA7zi
X-Gm-Gg: ASbGnctg9+xQCPzz5Ica1Hc2dSIicEQEpag2fMySQ+Zxz9t0A/0ceOAEaijDFCu8ePf
	bELAzlF+D9bNfVTnwb1NiH8VslvMCVEsCDQSI6V6eN0uJBsGg82aIjFUuKmJCDfC2XqQE4N4Aqk
	uw7zq+CB3FeQGAnsyZdDaf93QomnOEzAs1GTZzGe63e57l7WVLEALFunKMu1JWA1/e0lyOmSInu
	3RIjJ4dgUt8GgNZpA7llfQP8Rhdo1dXobHsxyXxl3WFmgJhhk7Zz9uBTixyZUtVDEN5E8SLOPKp
	+sGsY5PjU0N1dT2VpS1iI+ROxhoHedFAY3kho+LeWJRTuwIBoCjv8yRZorRjWgvlk4S4X9a4kwD
	XOycDGfP7cDroXJZGD4Ccb/1MTkevsSMioirIn+zgLF985zKaauOeiI/ctKrpiLEvA4lwCwlX
X-Google-Smtp-Source: AGHT+IESQJcBetHwGqWeWnfiLA0N9lJ/u4rM5jArsuldA1nsqCJOm5/erhH2PKpvmc6TYrRuKdn0Nw==
X-Received: by 2002:a05:6a20:2591:b0:245:fdeb:d261 with SMTP id adf61e73a8af0-27aac4ce90amr9585400637.54.1758199971435;
        Thu, 18 Sep 2025 05:52:51 -0700 (PDT)
Received: from zojnhg-virtual-machine.. ([112.3.192.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cff22ba98sm2333201b3a.91.2025.09.18.05.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 05:52:51 -0700 (PDT)
From: Jinghao Zhou <zhoujinghao24b@gmail.com>
To: linux-pm@vger.kernel.org
Cc: rafael@kernel.org,
	viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org,
	zouyipeng@huawei.com,
	Jinghao Zhou <zhoujinghao24b@gmail.com>
Subject: [PATCH] cpufreq: ext: fix NULL deref in ext_gov_update()
Date: Thu, 18 Sep 2025 20:52:41 +0800
Message-Id: <20250918125241.80968-1-zhoujinghao24b@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927101342.3240263-1-zouyipeng@huawei.com>
References: <20240927101342.3240263-1-zouyipeng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switching to the 'ext' governor can trigger a NULL pointer dereference
in ext_gov_update().

Two problems were present in this function:
  1) policy_dbs was derived via container_of(policy, ...), which is not
     a valid way to obtain CPUFreq dbs-governor per-policy state. Use
     policy->governor_data instead.
  2) When the BPF hook returns 0 for get_sampling_rate, the code fell
     back to gov->gdbs_data->sampling_rate, which may be NULL or stale
     depending on initialization/teardown ordering. The robust pattern
     is to fetch the per-policy sampling rate from policy_dbs->dbs_data.

This patch switches ext_gov_update() to the per-policy path
(policy->governor_data -> policy_dbs->dbs_data) and adds minimal NULL
checks. After this change, switching to the 'ext' governor no longer
panics in testing.

Observed on: Pixel 6 (oriole, arm64), Android kernel
  6.12.0-mainline-g0a53f54ba5c5 (Jun 11, 2025), after applying the
  cpufreq_ext RFC series. Also revalidated on a PC build.

Reproducer:
  for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
      echo ext > "$cpu"
  done

Link: https://lore.kernel.org/linux-pm/20240927101342.3240263-1-zouyipeng@huawei.com/
Signed-off-by: Jinghao Zhou <zhoujinghao24b@gmail.com>
---
 drivers/cpufreq/cpufreq_ext.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ext.c b/drivers/cpufreq/cpufreq_ext.c
index 310f13aca70a..c79068e86c27 100644
--- a/drivers/cpufreq/cpufreq_ext.c
+++ b/drivers/cpufreq/cpufreq_ext.c
@@ -409,11 +409,18 @@ static unsigned int ext_gov_update(struct cpufreq_policy *policy)
 {
 	struct ext_policy *ext;
 	struct policy_dbs_info *policy_dbs;
+	struct dbs_data *dbs_data;
 	unsigned int update_sampling_rate = 0;
-	struct dbs_governor *gov = dbs_governor_of(policy);
 
-	/* Only need to update current policy freq */
-	policy_dbs = container_of((void *)policy, struct policy_dbs_info, policy);
+	/* Get policy_dbs_info from policy's governor_data */
+	policy_dbs = policy->governor_data;
+	if (!policy_dbs)
+		return 0;
+
+	/* Get dbs_data directly from policy_dbs for better stability */
+	dbs_data = policy_dbs->dbs_data;
+	if (!dbs_data)
+		return 0;
 
 	ext = to_ext_policy(policy_dbs);
 
@@ -431,7 +438,7 @@ static unsigned int ext_gov_update(struct cpufreq_policy *policy)
 		update_sampling_rate = ext_ops_global.get_sampling_rate(policy);
 
 	/* If get_sampling_rate return 0, means we don't modify sampling_rate any more. */
-	return update_sampling_rate == 0 ? gov->gdbs_data->sampling_rate : update_sampling_rate;
+	return update_sampling_rate == 0 ? dbs_data->sampling_rate : update_sampling_rate;
 }
 
 static struct policy_dbs_info *ext_gov_alloc(void)
-- 
2.34.1


