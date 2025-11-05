Return-Path: <linux-kernel+bounces-886909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBB5C36F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB1F684C44
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C236D33557E;
	Wed,  5 Nov 2025 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XlmijOD3"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35214335BA8
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359639; cv=none; b=k0U6CqfiohLAkg+xbuzVMD77L8WuI1Y8sL3CoNdr2eOMupmX5jxJiKVhXxL0B+n5LT+gFHTKfEhRnm+GbaHHiRPaEfBW+9OKu2mKlzSHLCyJtEjKCtUZaw3d5MubgK+YVk9UuK5FlzhAThfXhkhcBjZEIEA5hrK8V+6RpL3m8cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359639; c=relaxed/simple;
	bh=YQWd0xhHDBW2hR61xBsnOIdRXEANTagArhpc+kMIgJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DMpIAtfna2FLK5qd64WBnTB7dyLpfWYDlQt1fcfygxyMwQRLyuowNQJR7gBBtn3ryZeAhLQfBpUFW6I/iJ2iAlZrSHY9tYqG7wODKkRonVqoKC8ZZLP48UZG1xDKTJxqiqZSD752V/io8wsQ4KvvrpMEs4E87TFRYAJqamAUhIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XlmijOD3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47721743fd0so36777355e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762359635; x=1762964435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t7qoL+lyFmguUrSnxi6lN//fLB0OQ96aE9NZls6Gkzc=;
        b=XlmijOD3zzFL8IVWQfb2amfj/e4aP966atpLMaZukhgCXzda1Q6sstd7Oc8lqOXWfr
         +e+XJhC1ethxBBNwhP4OH20TRb4BLLK30r1Ba2MSg2XZQm4w1iQPC2rr3xsQRKlo+xbj
         vIfz6N0+UEFTZdpJOCCzuTtzCmaep2jke4ya09AcprlePYEf66cgjOba8uxLDUqXdYHZ
         6XB+Vc7j2f50Xtsj/iQVi96XdYvA6C+akxVWV7QG1XGY9RqHPA2Nbkafpsw+cslGJEHu
         TVmkysQq7o+54h276wFmKN+/ZmRNoFoLNXcZvPc/sd9+MaXbLkLtXjAGtDyN6FxLwGpG
         FzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762359635; x=1762964435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7qoL+lyFmguUrSnxi6lN//fLB0OQ96aE9NZls6Gkzc=;
        b=hrr/+yVU68kCI9fHRNPsRc/EJY7vCJDKLXmwet5ZkLMg72ZHlk61LTnlHQmbp6UPBI
         oFLAJk8TjuixG0sBUxBvouulEei279TwXiKzwqXbAXwdBjo4DVGpUnLcjlJ4gpU8k/fz
         cJMtQg5BLwlHacDejEkL/hkvO9keawaVoYkYxNQjiNxZQYzsZG/TMDPuUxh6krhi5Pxd
         UOqj0QVg0L+icLSYj9Q30cPkpTMPKyn7/P672kIFtYaGqwFgbMY0OCdNx13PThIb00yx
         keISfi/JfWiYs2ioHDQz7sPVskREo3+ZvbeKlzUo7qyOsrEW4EIc0CLssfrF0n2nVVNm
         OVMQ==
X-Gm-Message-State: AOJu0Yz9tOB5LQZbHtFF2ZWvhVpZNYJg62EV1f0GR+PfMEAqf+xwf/ud
	ozdaeqqcB9tCMPjkX8tngnSZ8I8GjVEAYnEH+rpXBg1P00gaZoBtZIry6QXDw1ei8DmPLgtrqdm
	DDdCx
X-Gm-Gg: ASbGncvJ2zZ59EasDtUn07f3kqIbFt7y1fG+OJRnGo2WSK6aQ+cbjiJLp6h3Ve8ID9r
	0E4vHyfE76hTakjpSDRbc85t4qKzR1UL7/umBz4/Wruh92N3GzR7OWp/dxPX3NSl4qk+Z6Hxt1y
	kCKQXJvoVwt8VlSyVmlBPnky9r8UIx397yZoK8j4Y064BWIyHy3sIEi/WCpwD921lYGG+ZsmeYm
	o8/ZzcuNTqNvSAGfWcl9ghVt+J53cQPD3sXxsD2oVglK/gB9DoHim07A4H7p8/9WVTTisMUP+XS
	9kVMRcx8ICiN5Kp67hBs4Byadxvc+zTYB6pd3XQU44z4+oO6AnwqVMh1SRnQQvEox5EenGK+4ZW
	abTB4HMEvpfTfjcwOTzaSrafQb/K/X4DAb2ACmcD2Wj+ePRTh6zjucdCjW+9GogdVV5Hfw/torC
	GJATZJ8jqAE+mK9zCpEVfHNnI=
X-Google-Smtp-Source: AGHT+IGX/9EhIMsS6E+pNqcKMCLxIaNUMbOE5rzcaFCIbW2YLL+eGsWL0/RNanBTts3vMlHznZXhUg==
X-Received: by 2002:a05:600c:3112:b0:477:54cd:202f with SMTP id 5b1f17b1804b1-4775cdbd575mr35741605e9.3.1762359635026;
        Wed, 05 Nov 2025 08:20:35 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558d9cefsm48771905e9.1.2025.11.05.08.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:20:34 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: qcomm-labibb: replace use of system_wq with system_percpu_wq
Date: Wed,  5 Nov 2025 17:20:24 +0100
Message-ID: <20251105162024.314040-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Replace system_wq with system_percpu_wq, keeping the old behavior.
The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/regulator/qcom-labibb-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/qcom-labibb-regulator.c b/drivers/regulator/qcom-labibb-regulator.c
index ba3f9391565f..ad65d264cfe0 100644
--- a/drivers/regulator/qcom-labibb-regulator.c
+++ b/drivers/regulator/qcom-labibb-regulator.c
@@ -230,7 +230,7 @@ static void qcom_labibb_ocp_recovery_worker(struct work_struct *work)
 	return;
 
 reschedule:
-	mod_delayed_work(system_wq, &vreg->ocp_recovery_work,
+	mod_delayed_work(system_percpu_wq, &vreg->ocp_recovery_work,
 			 msecs_to_jiffies(OCP_RECOVERY_INTERVAL_MS));
 }
 
@@ -510,7 +510,7 @@ static void qcom_labibb_sc_recovery_worker(struct work_struct *work)
 	 * taking action is not truly urgent anymore.
 	 */
 	vreg->sc_count++;
-	mod_delayed_work(system_wq, &vreg->sc_recovery_work,
+	mod_delayed_work(system_percpu_wq, &vreg->sc_recovery_work,
 			 msecs_to_jiffies(SC_RECOVERY_INTERVAL_MS));
 }
 
-- 
2.51.1


