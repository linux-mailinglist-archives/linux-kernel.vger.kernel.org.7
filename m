Return-Path: <linux-kernel+bounces-737924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9B4B0B1F7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 23:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DDF4AA496F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 21:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6FB222566;
	Sat, 19 Jul 2025 21:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiagtwe5"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AD71D63DD
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 21:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752960869; cv=none; b=mA5mNsfNWQf9WEjfwx2ehcIo+j1R93bPFrCXCVptVcZJuWmCvEQsnKHvh7oXlCTutNX1rcJB2n3hlhXxwAdIiguZJDrIspIhY9aN2xYTGIBwjIMMwndN+clIFRECumFanM0jfC6upmvRLWji1qsQ5QepsuFklaB7tgqVY5qy7XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752960869; c=relaxed/simple;
	bh=1jVQPcZUaDrSz3SIjSW9s/ndZFlY73xv0k8OR9kANGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gsZ84eCvpc4TXbzZwHwii0grJ4Jyq2RzQof5X3WMrspdbTEI1RheQxwoB3zIcf9ilKDcquyy7WCtVwW53vAQNJrtuEkn4t+Z3nZ6rerICbw4DG9Eyi5ceU9fLtsVub8g4Rp+Wavn25N1v1TzfLDJTISchCFiwbg1zNZchOb3vYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiagtwe5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235f9ea8d08so26088135ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 14:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752960868; x=1753565668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RmLGUZG1SFofD7aLds62twbH2Sqn20p333YxpHUm6vI=;
        b=aiagtwe5mzNP0VDp+xH708qOedIrGup27wkh354Nyxv1SLaatWr7x/GqLhRG/ePJZN
         6FHQuxN2EqhZWjUexgqch1Oqsgh5k5clv54volw9c65UR4YObj/R+1V4+dfz2PSDQCLb
         YoBMGD7BXsRS98PXqHeCyXlGm1XS0r37yTrB4KOxokGvQ9EoZtG8vvdN/iyF0pXJf4pw
         2TzYtDer8VulxkrscsgKS0FbRT8NSDIui1PE3Bxrc2N8yeRxODQkGvjP/j1PS+LDYTWj
         A6MPfKvJxIm7jFJkkbDjypb9cJP1np71RzNqoiaUA/D4xOT4m5fhqIPPbFAg2rQugONO
         dKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752960868; x=1753565668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RmLGUZG1SFofD7aLds62twbH2Sqn20p333YxpHUm6vI=;
        b=uXDHadTISojVwcXFC+rUv4CyGisSUc8DZK790fMx7DKu0tZqj1W8coLLuFu0h86exI
         X1bTtYE9a87HFYPKOnIGu/WCrfnAtx/dH1AKvNb7kKR2X/pjRuPuMbdQD8F1FoounPWq
         SpHM9KsI4L7+QdZKOx7FfBfBPQuutJDLwO/DFTaPINbMB6CcsDTdsB+5yoA/+FfKRxQT
         BK+y2jDR7ypiBchx0wOhyNKEhNLcF+aONtvd1UPUG7KIPnzvcgc14bhbm0vH64HQb5vz
         XE//mpuM/YPoyra4Gy+PARX47VoGV+a4fZ4ScCz0ziCWdAchkvsxt8s4RELe+VIZj1Sj
         Idzw==
X-Forwarded-Encrypted: i=1; AJvYcCU54vqlCWnatt70KHgFhqQxwp+Bb9dg0VvayGKdA6iPZ5iAztl9OjZHpumnxfbMZEh7LDrMeK27gr+0Hq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIZ/Kl0Wj9rFkYtw4PJI2vbLUMI1VxP5983MFvm6RXzjGAT1jo
	tX+FR0IOOJm19/AacjnMuZaa1JlRlHN0uabABJyj+Gl/25zHG3jBZ2Zj
X-Gm-Gg: ASbGnctfriP8hizFaaXP6HRd15+vN2nmn9W93G4zr90Cq+yx/jlJjZLjiJEFgSaLjsp
	oJNEtieUFljh9nkT9LMuaavwmebBSOsCR0AJlRvMKicGsInjk0cLKRgqgcBn7aO3Hb/0qOHGNtk
	yoTCHxbDsdU87UUjEBHxoUthcemnbrHBJqk54ZL3cUF+wOtg/tHRIhFY2acTj+k3E8Z/GcYNuLt
	252fVCjCuTyQ45sMZpmtPCas4yql1x1+EaoEO+YPojYxZTE2hiSmbsaTh00cSamNrBGSfQU9VhR
	NaecCNv+ajdsMB9/X1ye348T8haTmUAeIV7Q03FMCL/yMbfBEJO2Y+SLGXjPn3d+tglPRPTd6HG
	bR2L8H74N9KDb9ANkP2rs6Bm99eSx/B9/
X-Google-Smtp-Source: AGHT+IHCLK40B5N2+SVa9Owe7vuPcaRxputEr52wKn+7nmyJWztktAiRmFzlK46bSh5kvb7gHY8PUw==
X-Received: by 2002:a17:902:d503:b0:234:e8db:431d with SMTP id d9443c01a7336-23e24edda6dmr204417035ad.20.1752960867525;
        Sat, 19 Jul 2025 14:34:27 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e2de8sm33136895ad.11.2025.07.19.14.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 14:34:26 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] fs/resctl: use for_each_bit_from() in __check_limbo()
Date: Sat, 19 Jul 2025 17:34:23 -0400
Message-ID: <20250719213424.403632-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov (NVIDIA) <yury.norov@gmail.com>

The function opencodes for_each_set_bit_from(). Switch to the dedicated
macro, and drop some housekeeping code.

While there, switch to non-atomic __clear_bit(), because atomicity is
not possible in this context, and that may confuse readers.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 fs/resctrl/monitor.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index f5637855c3ac..3e1c14214ea8 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -135,7 +135,7 @@ void __check_limbo(struct rdt_mon_domain *d, bool force_free)
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	struct rmid_entry *entry;
-	u32 idx, cur_idx = 1;
+	u32 idx = 1;
 	void *arch_mon_ctx;
 	bool rmid_dirty;
 	u64 val = 0;
@@ -153,11 +153,7 @@ void __check_limbo(struct rdt_mon_domain *d, bool force_free)
 	 * is less than the threshold decrement the busy counter of the
 	 * RMID and move it to the free list when the counter reaches 0.
 	 */
-	for (;;) {
-		idx = find_next_bit(d->rmid_busy_llc, idx_limit, cur_idx);
-		if (idx >= idx_limit)
-			break;
-
+	for_each_set_bit_from(idx, d->rmid_busy_llc, idx_limit) {
 		entry = __rmid_entry(idx);
 		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
 					   QOS_L3_OCCUP_EVENT_ID, &val,
@@ -178,11 +174,10 @@ void __check_limbo(struct rdt_mon_domain *d, bool force_free)
 		}
 
 		if (force_free || !rmid_dirty) {
-			clear_bit(idx, d->rmid_busy_llc);
+			__clear_bit(idx, d->rmid_busy_llc);
 			if (!--entry->busy)
 				limbo_release_entry(entry);
 		}
-		cur_idx = idx + 1;
 	}
 
 	resctrl_arch_mon_ctx_free(r, QOS_L3_OCCUP_EVENT_ID, arch_mon_ctx);
-- 
2.43.0


