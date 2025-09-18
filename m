Return-Path: <linux-kernel+bounces-823128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC03B85909
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8201613DE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA42430F80F;
	Thu, 18 Sep 2025 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fEHCzXBX"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684A124467A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209170; cv=none; b=U9qP+pUX/FNZmHJiX9I+SAfH+2VI0JLGEzPNx4eXKx21a0HwZHLpo9coj3b0a/6ix/rfH+ukHV5ca06oZVyEbbUyWxdzGjzjpeA3wyqASWWJvZZ6b6bX/IVTg/KgkTNj6rRPPzA3JagWrfMT8OCQNHJKBmrsLWAL8u1W/fwzN60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209170; c=relaxed/simple;
	bh=T/mWFe8NzS54YpnNNIjgGNosJ7quWk5Bo4FQETSjfQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGd9fxYfRNBL5/icWu0kBglB9rilu5Q8qUBjKktxIGwbwgyn+eMr45bvBnF2UqwEGSSSN7O2tX4G7RrGJv7UVOOTX8d8g90yAbKaVHTNznpGNvbIhTOTXCG+JTcTvWk2fgXYVq5TKF3Lp5kGF9O2lm70Wr94RKpBPLWWvrPHUtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fEHCzXBX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45f2f7ae386so8155885e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758209166; x=1758813966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPabrgJ3flhzfh3xzBI0TJyAcLG6lM4hGPw3JCTS0NM=;
        b=fEHCzXBXDkYgV0HUjs24QqnAKGz2D7Iiys8h5rhQXH68nzY3xNqkxStYdGMbdmk9OM
         suYRQpr6IWS7V/Buhfp8sUaWdjqyFGJqP+p47ricuZhW9mI8SBWif2fuRmCWCEd4IEjW
         kDBTEbVqGdA/QyPgQWzipnNOWfwfF025xKUdSNtkykK0kK/ykjOY4Rhk3Kj/YSY6nS+6
         C6Q4QHi5W1Sa2d5oywrW0hKvEqKYIyPdpR5BbFOdimj9JuTiEoNAff+wABw2R6j/gwBb
         eTlZ/4den5MF1LDtQMegEJzKLg0i6sGopw/umRZ0aurYD+HyEzYyDtxQ6lTSsYarczJj
         k1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758209166; x=1758813966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPabrgJ3flhzfh3xzBI0TJyAcLG6lM4hGPw3JCTS0NM=;
        b=v++vT2E+M8s9zl4euoboThroQ0i1cPVHYkhEnN+aaFWV4FGxQDRBWkpOGwR8bNXU6P
         7D8gV64GWXUEbNOQzGwF4WBSdFiTmOEasgl+Peio0++OAkbhK2d1I0s9R0VbDldclSyr
         IUPVFsMdD9CeiI//6voDPBCe2DVHFyz3wLyjlmVElF8vNse0HeRlb8gLbRgPbw9kfW5T
         PsRwziuMeWWqK6o4XWwid0btYyndsQ3u4IgLTf3+ki/RYy/E89rQ7qv1pK9MwKBHTLoD
         HsoWdCidehJs/1my472JhwSOIbcUGhzINLBAVVn6e7+5teOAftmJilISBYaIiruVyS8N
         RuNw==
X-Gm-Message-State: AOJu0YxMThvnOHKjGtR7HWPTmgs0YAvvtN+OXcfUwCiF2HkpPpfBqSYo
	YXRyJ9fPQ7pcj/MMeEWUI1/jZHZj06Nkv5F8zfo/C9aM48N4byTXtZQoP92BdEwU5M0OD9EyMs9
	rtTj3Gos=
X-Gm-Gg: ASbGncuYUcSjCojnTkeOynjEFPLLYp1TOzrQJ2Cj2fmrZ+NS1IyDzvpMprEaI24FWtm
	CEjifpufbqo66ODRLo7WJss5U/vpb4NWYu1IkE2jdpgR94BuTY9SVhWnaAs6K4WnYd6+KFfabsp
	EkxOAZ3k9U9jAOFtDDi2UJeb0pm2RQ1/F7D6GRdElNwWxFMP4fR4zXD0z5+b5IeWIG2zkbxnGlM
	7cwPxEQpxdc77uzboKZ0fRLZZNjPwnyp5ideBe+0k/n/3uh89/WyTdBktWnaculFq6+eKp1cm2d
	XrHEEcXcr+8zk/ZVZXkse1KA9N2r/RnBno9xlHe5MUa/LUDSWbTCpEmMlkNekhZ7sHV4xG0z3WN
	THQWpX8rfebbn7PRi5mCroyQJEDwDUpQdiB4CCNqyAxsN5NlZVkVKo40gv4e56ANY
X-Google-Smtp-Source: AGHT+IEpdSO5Kx2EqRZYU9Is6GMWXSSVjk1EzXFYF/z2X5WoUebXHk2UFL+J3lsvf5aGWoJdYiR8Xg==
X-Received: by 2002:a05:6000:26c6:b0:3dc:eb5:51f6 with SMTP id ffacd0b85a97d-3ecdfa07bc5mr5332196f8f.39.1758209166322;
        Thu, 18 Sep 2025 08:26:06 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f3d73sm4069815f8f.8.2025.09.18.08.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:26:06 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH 2/2] wifi: replace use of system_wq with system_percpu_wq
Date: Thu, 18 Sep 2025 17:25:17 +0200
Message-ID: <20250918152517.361773-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918152517.361773-1-marco.crivellari@suse.com>
References: <20250918152517.361773-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_wq is a per-cpu workqueue, but its name is not clear. Because of
that has been renamed in system_percpu_wq.

The old system_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/wireless/intel/ipw2x00/ipw2100.c  | 6 +++---
 drivers/net/wireless/intel/ipw2x00/ipw2200.c  | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2100.c b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
index 215814861cbd..c7c5bc0f1650 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
@@ -2143,7 +2143,7 @@ static void isr_indicate_rf_kill(struct ipw2100_priv *priv, u32 status)
 
 	/* Make sure the RF Kill check timer is running */
 	priv->stop_rf_kill = 0;
-	mod_delayed_work(system_wq, &priv->rf_kill, round_jiffies_relative(HZ));
+	mod_delayed_work(system_percpu_wq, &priv->rf_kill, round_jiffies_relative(HZ));
 }
 
 static void ipw2100_scan_event(struct work_struct *work)
@@ -2170,7 +2170,7 @@ static void isr_scan_complete(struct ipw2100_priv *priv, u32 status)
 				      round_jiffies_relative(msecs_to_jiffies(4000)));
 	} else {
 		priv->user_requested_scan = 0;
-		mod_delayed_work(system_wq, &priv->scan_event, 0);
+		mod_delayed_work(system_percpu_wq, &priv->scan_event, 0);
 	}
 }
 
@@ -4252,7 +4252,7 @@ static int ipw_radio_kill_sw(struct ipw2100_priv *priv, int disable_radio)
 					  "disabled by HW switch\n");
 			/* Make sure the RF_KILL check timer is running */
 			priv->stop_rf_kill = 0;
-			mod_delayed_work(system_wq, &priv->rf_kill,
+			mod_delayed_work(system_percpu_wq, &priv->rf_kill,
 					 round_jiffies_relative(HZ));
 		} else
 			schedule_reset(priv);
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index 24a5624ef207..09035a77e775 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -4415,7 +4415,7 @@ static void handle_scan_event(struct ipw_priv *priv)
 				      round_jiffies_relative(msecs_to_jiffies(4000)));
 	} else {
 		priv->user_requested_scan = 0;
-		mod_delayed_work(system_wq, &priv->scan_event, 0);
+		mod_delayed_work(system_percpu_wq, &priv->scan_event, 0);
 	}
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
index 36379b738de1..0df31639fa5e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
@@ -234,7 +234,7 @@ void iwl_mvm_rx_tdls_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 	 * Also convert TU to msec.
 	 */
 	delay = TU_TO_MS(vif->bss_conf.dtim_period * vif->bss_conf.beacon_int);
-	mod_delayed_work(system_wq, &mvm->tdls_cs.dwork,
+	mod_delayed_work(system_percpu_wq, &mvm->tdls_cs.dwork,
 			 msecs_to_jiffies(delay));
 
 	iwl_mvm_tdls_update_cs_state(mvm, IWL_MVM_TDLS_SW_ACTIVE);
@@ -548,7 +548,7 @@ iwl_mvm_tdls_channel_switch(struct ieee80211_hw *hw,
 	 */
 	delay = 2 * TU_TO_MS(vif->bss_conf.dtim_period *
 			     vif->bss_conf.beacon_int);
-	mod_delayed_work(system_wq, &mvm->tdls_cs.dwork,
+	mod_delayed_work(system_percpu_wq, &mvm->tdls_cs.dwork,
 			 msecs_to_jiffies(delay));
 	return 0;
 }
@@ -659,6 +659,6 @@ iwl_mvm_tdls_recv_channel_switch(struct ieee80211_hw *hw,
 	/* register a timeout in case we don't succeed in switching */
 	delay = vif->bss_conf.dtim_period * vif->bss_conf.beacon_int *
 		1024 / 1000;
-	mod_delayed_work(system_wq, &mvm->tdls_cs.dwork,
+	mod_delayed_work(system_percpu_wq, &mvm->tdls_cs.dwork,
 			 msecs_to_jiffies(delay));
 }
-- 
2.51.0


