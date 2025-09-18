Return-Path: <linux-kernel+bounces-823127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C100B85978
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA7A3B3455
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6843830CDAE;
	Thu, 18 Sep 2025 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N2dtHXrd"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5939330CDB0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209169; cv=none; b=P0L4YlzLWfS05itBstsgVe6ScZh1QvF0ZnU17YhMPZv3zh3KIP6u8KZokvVGDwEQi8li9v1YXKVXdxHzBxwFY7N9xhcuhyM9Y/V/N0S43bN3nQ8cOpUo7u/treexHuUNpb1MiMlruAD6rS56NezwYhn9Lpatuxe6OqRE7PTKYao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209169; c=relaxed/simple;
	bh=BgrkpQFFo5N6imSMfutDKuvd+pZs7IwFD2JEqY9Yim8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpn8bgrJSyrwT7BaXyyVp3nustHTEGUf8bhkBSQxbAnl1HGtOX5cItjK1AZqngMfTnTG61U8BAOeKHrQSmibBrA1hNP7l503YwS59r1nM+jm93nhoTR4GzsXOifrE9hsUID7ec0yZRo/vPa/Elfw8MJaBb4ljvcl1sCy7CdJFPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N2dtHXrd; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso118748f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758209165; x=1758813965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tArcWhUAVfKI1IR+L4EJJlA6CZw4Wq2C6U9y07jPVV4=;
        b=N2dtHXrdUVvchRyDVFLaU1XPGW3iFN/G/2fo/vXUfOCMePH4bpsXPQ+iHujGkN10dI
         WFKRijC218hZ88OOTJbSgZJcbtnegjIBCRimBQJle39Ba2V4J6MXoWRakDIPYFZGBCB1
         6Ts+uEQ464nJfZXOf9LwTm6xB5kj2egktkov8FtujjjI1pLYaKNvL0d4tc/fPFMvjwyq
         5UjoneqarkB/nAZT8VNyXNq1vllbej5yLUzkV7XjMFVLAveT4XryERmko1G3Wi3WvGqo
         ZkEG+xQRJthllYHSOnNSfPMqP2URBbHD/gH3RitMfSX+vhJxYafcEqkxJRBSzpr4KDa1
         IWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758209165; x=1758813965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tArcWhUAVfKI1IR+L4EJJlA6CZw4Wq2C6U9y07jPVV4=;
        b=IfjH5WQgMT+pYe8wf4uT54lWqhpQNWVkqle/ZqP9QlTb1rGhSWr0Qbl9CKgy5hlCL/
         74CtzZflFuQw1SemZO5HqCrBsxnogAgK+xfz+FGCpuGXU3Y3FABn+iu8AejF328IMQxZ
         25TXD6qaIpSlLgHAqEfeBeoy+WNqRVFNwiEHj5gcJ3s8WhobjSR+e3ujrTe793uV1ZhY
         abWmteLHOX7rhKnkMNkyU+lLO6njyYxjnDYpFLhQusXQD5ruMZ4XEYY0vL+P7nqX7Swp
         kgmgRc3Xt2RGu9BwggW1rQsWNDGh6tqb1JBcVfdGnGk+8jUa8LcuEUaY2GL4v6TABMko
         muxg==
X-Gm-Message-State: AOJu0YzeP8+zm6Us9Ko7I6v6MqZHz2IQqV2/CVdHvIBxDTBpykFbhiAr
	P5bqeHjhC0ScYLxpi4tPEWPmLUICvjE23XM29k4r/3tIHDmFP1DrlGM98CnksqsuEQrSkLQdtbx
	QgCepcio=
X-Gm-Gg: ASbGnctT1tBX6omf1Jdeb5wxYDRAn3GgdMoQv3XCKVuGeU+61kmzm3fKaUeWomILFkE
	Y66GdULQw5SEIEqNAbVVNDcVG17zz0MOvxxrVP/YKsc8GF+PxqRs+pqe7tT0V5xGI+eJId9VorZ
	HutYxTLLGpA7UsYMkddXqnOKTXkjJrB0HjO4/Re1YxlpvvvOJhfODamsdZkmwwbNshQx8/yyTWW
	UeYEh41pccg7eRaxPOnpsPWz0Rp7S/rk0Q/s6N5MxaUQHlVqKQSAaISAsFNUF+BV/N4ouz3O9D4
	QOTlONxnsj0zU9ZsvYEPw5/5ml4bHj+xTGxJgJFxGAeLz3dquu4IQKaFJRUr/DdB6MFO22kPtMr
	lnDUdlKr4AVymm4kEFOReyUNTk/yXeE7YVpLx+4LJF2klUHJi7Wg79KlAwkVXyrBr
X-Google-Smtp-Source: AGHT+IGvOFPQ1piai96hvU2hEjSeyPGIASHKtCRp0rLWzyrq8u4fJZ9ExADLpppLLF4E28tCe03f3g==
X-Received: by 2002:a05:6000:1845:b0:3e7:4fda:fe0c with SMTP id ffacd0b85a97d-3ecdf9bfd16mr5945312f8f.15.1758209165310;
        Thu, 18 Sep 2025 08:26:05 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f3d73sm4069815f8f.8.2025.09.18.08.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:26:05 -0700 (PDT)
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
Subject: [PATCH 1/2] wifi: iwlwifi: replace use of system_unbound_wq with system_dfl_wq
Date: Thu, 18 Sep 2025 17:25:16 +0200
Message-ID: <20250918152517.361773-2-marco.crivellari@suse.com>
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

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c    | 4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 2ce55859641c..e5f31b82339a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2933,7 +2933,7 @@ int iwl_fw_dbg_collect_desc(struct iwl_fw_runtime *fwrt,
 	IWL_WARN(fwrt, "Collecting data: trigger %d fired.\n",
 		 le32_to_cpu(desc->trig_desc.type));
 
-	queue_delayed_work(system_unbound_wq, &wk_data->wk,
+	queue_delayed_work(system_dfl_wq, &wk_data->wk,
 			   usecs_to_jiffies(delay));
 
 	return 0;
@@ -3237,7 +3237,7 @@ int iwl_fw_dbg_ini_collect(struct iwl_fw_runtime *fwrt,
 	if (sync)
 		iwl_fw_dbg_collect_sync(fwrt, idx);
 	else
-		queue_delayed_work(system_unbound_wq,
+		queue_delayed_work(system_dfl_wq,
 				   &fwrt->dump.wks[idx].wk,
 				   usecs_to_jiffies(delay));
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index a552669db6e2..2f24b639c133 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1092,7 +1092,7 @@ static inline void iwl_trans_schedule_reset(struct iwl_trans *trans,
 	 */
 	trans->restart.during_reset = test_bit(STATUS_IN_SW_RESET,
 					       &trans->status);
-	queue_delayed_work(system_unbound_wq, &trans->restart.wk, 0);
+	queue_delayed_work(system_dfl_wq, &trans->restart.wk, 0);
 }
 
 static inline void iwl_trans_fw_error(struct iwl_trans *trans,
-- 
2.51.0


