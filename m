Return-Path: <linux-kernel+bounces-828845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2788EB959CD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D19B04E1F9B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875103218DA;
	Tue, 23 Sep 2025 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i9wGKFr7"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB74286D70
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626422; cv=none; b=R7SZOxXo8raOWnqhbsOJS6t3P+ebB/zh28YoZo3+lUlr0HyEFVpTYAiIfmYfk8+k/BL1FVkC4Ugau8RnsohWfFaarq2QjM3iPrOW/OH6roVP+GerNS2SgJ7XC9DvdPs3x5OLCEQLSYkusafrCmNvPh8BYDYi4gVXll3FV6fGDzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626422; c=relaxed/simple;
	bh=B3fRnPBrL6bndjkV80Lqpltt+HotD1WV25scPuVekdg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ACgJkJbWGqYjiUbqdzwE5WcQTvZNb9GbJJWybMOSuAdEfMZMV1Nun9LJpAOtpSaEWmRdREl7JFAS4UimAOeGXdTThxrIBZ2/DxJxMrIPhyf0va10lBzPWYmYrToM/4HW+Wk8ULOd0e+gJn/eVmbE96kwkpAdv2Dl06pP7tye8i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i9wGKFr7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee12a63af1so2402293f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758626420; x=1759231220; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VE8TJpb+bgJUe79vS/3A1j4fTVnXxc+D4cm6eCdCSiM=;
        b=i9wGKFr73N2dpnTDqR9wl7Mt41sJLnKWB/19jvnsgxsw0sbDnRHDjb9jZl8xTNBqzL
         x3TIaMnHjMFQQQFTAyc7M/sHlm46TalPo3ChDHoDyqlgeBXSHRM+QOgnjsuM66Mi4CWy
         FQ2n36iX7uVW2bULH7g2idNd5B7WNUoC1qn6dqmc/SzdtltQ91bO8OvenQqWTcy6bufn
         UX3yLGMlmsWHTK4McIGcmRrNUtGpJfj8AVHbKFSmDkILr9Ur9eE9aB/QiaxpfZixxBGF
         si7jWMjtCkB41RA96YLkY9KRzv8IAIzjYupmAgc9DADqGItAIpTUlNlJ1/1cv3ii41wp
         FAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758626420; x=1759231220;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VE8TJpb+bgJUe79vS/3A1j4fTVnXxc+D4cm6eCdCSiM=;
        b=Z/6J2oKaG8RuEqq82osL7hBcZZox8K04qQ+SCsACQe+NipuU1tLNrmyHxLDf2p0ss5
         BsFrBZIUb5eaa5YIsyZiJ92+H8gd8UzgTrCD9p/iJ33Wo0AW7m1BbQE2OiM1O5TXGRe7
         TYXK8MUMgzmTJ9cioHtxWE2fAPLdmDi6a38h3/WsgFWgo75P3YPzAqAXUwcJy37OnZMx
         Qa2JMdBEH34+7ZuV6YwFoclKfDs608WtOOgHdZcg7ZoF5L14/kme2ATMwrqVFPp04byT
         kUcoQjntvGD6VdTENKejQ31sddvb6ej74Q6Ap1/BpxXSz/ivel3W90O4KYTo7BK8h6bO
         oWxw==
X-Forwarded-Encrypted: i=1; AJvYcCW070k43f3sGp3s3feX2LJnCpXHCk2HO7hvOn2JHvn3iiinu8x9ADAZCzwGDEshF2tRR5H0nhyt1CwF8Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2qzEmWDDfn4sNjjmwKaguH+4nfdqV4lDRXxlAfgEFVNz1O4r4
	z8+ZFIu/+gLqn2Adhq3NM0YD1s42bOVvjhenqKYaO18CoIeHbrZEPO+IYSCgItSnJ6E=
X-Gm-Gg: ASbGncuxW25/vwuuAA49P9yuf9Wl43JFHxDK97cFK7Eb4l7aaJMLGwMcxpeFTZcFFXE
	uDLI7lYO+cgpKRdRjfZlvIHK/TsstTWUCGhvmowtz9qFNMmVyFArQjMMgc05dcZh4+lDsdgcr76
	Jc+dCmt52cmtX8S2GwM4+qJEQUvytKseJ+W7Bmy3Xx195gLSldHfk3fTQr08oHJ5/itdLfXT5jE
	g1l8t1ZHbLV+WvCCDuqXCKP9k3W7Q7IWWChkRUhU819UHyVbPlLQa4Xpvb9jnMTl8LjuuZfpMlL
	KBaUv367TO4+AFeosm24IzqlKAt4/5iEZm043XpPQlenOdb2oIrDCGmJE4VMvZpPArDoqGZL0RA
	iIq3UWyWehjGc/aZMFqRdmc2UVI82
X-Google-Smtp-Source: AGHT+IH5ERjqItScX3GlaqMEPRqH6OH857XNBhEBSVVCeFpYjz1uRmIbad/KOH3nGEJlbG/jtig3mw==
X-Received: by 2002:a05:6000:186d:b0:3e7:46bf:f8bd with SMTP id ffacd0b85a97d-405c5ccd210mr1652472f8f.23.1758626419495;
        Tue, 23 Sep 2025 04:20:19 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-464f0d8a2bfsm249409455e9.2.2025.09.23.04.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:20:19 -0700 (PDT)
Date: Tue, 23 Sep 2025 14:20:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Avraham Stern <avraham.stern@intel.com>,
	Shaul Triebitz <shaul.triebitz@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: iwlwifi: fix potential use after free in
 iwl_mld_remove_link()
Message-ID: <aNKCcKlbSkkS4_gO@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code frees "link" by calling kfree_rcu(link, rcu_head) and then it
dereferences "link" to get the "link->fw_id".  Save the "link->fw_id"
first to avoid a potential use after free.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index 738f80fe0c50..60d814bf5779 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -501,6 +501,7 @@ void iwl_mld_remove_link(struct iwl_mld *mld,
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(bss_conf->vif);
 	struct iwl_mld_link *link = iwl_mld_link_from_mac80211(bss_conf);
 	bool is_deflink = link == &mld_vif->deflink;
+	u8 fw_id = link->fw_id;
 
 	if (WARN_ON(!link || link->active))
 		return;
@@ -513,10 +514,10 @@ void iwl_mld_remove_link(struct iwl_mld *mld,
 
 	RCU_INIT_POINTER(mld_vif->link[bss_conf->link_id], NULL);
 
-	if (WARN_ON(link->fw_id >= mld->fw->ucode_capa.num_links))
+	if (WARN_ON(fw_id >= mld->fw->ucode_capa.num_links))
 		return;
 
-	RCU_INIT_POINTER(mld->fw_id_to_bss_conf[link->fw_id], NULL);
+	RCU_INIT_POINTER(mld->fw_id_to_bss_conf[fw_id], NULL);
 }
 
 void iwl_mld_handle_missed_beacon_notif(struct iwl_mld *mld,
-- 
2.51.0


