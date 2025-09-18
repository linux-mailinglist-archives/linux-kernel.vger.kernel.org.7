Return-Path: <linux-kernel+bounces-822360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE61EB839F2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D881C0555B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5153A2FFF90;
	Thu, 18 Sep 2025 08:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bIWaS4lO"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE06F2FFDC6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185739; cv=none; b=k8QHi1znrBAKZVmovbjCclFHJx0KniU1Uy5e7Rpu5ltKvkhcmRMGZoLGdWyR10lkBBSgwmjXWrYYmMX0KALkvkiVVkzf1+lbXoGF2FM31Q8CwffIy6ZtYlg0a4uiOBgMYoZAM9TTezTYtuNeKSuOxe87+R3VjQCTs0NPyhtWLsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185739; c=relaxed/simple;
	bh=mWt60YV6Gi1FK2N9eOFScB9N2fh8Io+egXHO3E8EBz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMacIN6XUFCLQErPwLNNS/er0RYlT48/QSugshFnGrWFlMAG6gOPwKMnwfu4m0oG7akIkgEUPFbAQ827Wq1xjwzBIFsqrJTXua6KFoq8kDVnt+sjtxnKbrrWoRYHmMryq+3YCiUd+pfMHj/Qszc0fJ+A0adHqBmN4dL4bJJqkDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bIWaS4lO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45f31adf368so4949555e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758185736; x=1758790536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LMDUzeCeiPfjqj5pBmFTbXJSloreEErrtdNyS4HqfY=;
        b=bIWaS4lOZsvbUe+AOqZWno4o4Vq6yUlI1AaE88tpDrEhmJD3rTkWG8/Zg1AExEs5Zx
         TvqVtEZx2lJN+WQB9yEkJ8gvT+aoAra9EKUtNv9AFsW726lbBqHPflmjQVCHX5RyWS9i
         NQLNbhYnICQxFPvNvaOXGDAqZkNl+ecTlqhlZstI1k1JOmcULSR4hF2Nb/6E/go++A72
         e3/6Xw4GoUajND2mexie7/RYPTFPDm06CJisfqmz6BsdPJEyv2mFkMWfE65pK9xuAguw
         YDeKFS3rj0iUEZ/PcOaB9uQ+QqPGMBK9eKF6sh4FNdmLL+mLjFCgGVCNvp5yn/Ik9SqO
         e07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758185736; x=1758790536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LMDUzeCeiPfjqj5pBmFTbXJSloreEErrtdNyS4HqfY=;
        b=Vu1rG1w8K1CY+QCbAxbtVoocnds4uWbIHYtCKpsp6gzZ8tbAk7O3oEK7FUWCSjobVv
         ZEYdtmN54JXILsQyuOPxwt5BUhu8gTg8gFsewLqnOIDfXVQm6T7jPtYZHuBpDg2AUFpe
         IVwQ+TmNKOWrEiF+kjtW+8M62ynX1OolOuCgnGfy/l9VF9XrrFNwt/7xXVbBYjt/R9PH
         avyR3mItQ3AHDrdmZ8GNrKJcC3QWC1S7+/5RnsNmbeS2qrZzcv0coQ+12zhGlff8/+vf
         a18hxVAq37DWN4Mq+lmdVuZDaShsx80zc+D9jnKY12ppdNpJsfJpbJvzbssCAimFjzIE
         ZzhQ==
X-Gm-Message-State: AOJu0YyFdQGKGF74iMvQM2HGsBkxk9amUWs6y+wJXJzbBhXiJUbKHyKw
	senDvAiwhnYk7b51P5GOB2XOenFjK0s69XEK41ItGEU/jqLlRFAyi6WMg4stElDOZzkCNbeBaS8
	CuviiHQE=
X-Gm-Gg: ASbGncvOfFp6V6st40P034JoRjSOpbiYpY4RziKhZhfMrKm1NaUq/FoclsbNPLoc6rp
	9CDAJUxWqZjvPjRBH+/MMaQYpMKE5Hz8sKrVM8F2ndKWLMPLVNV5hz6B9O/vib0u/YlWuOD/D5W
	vLG0PoLuO7dua/58d9c33wCpIvCrSyP3PRxNZFXdEoZrMB2bi7F3H4Au0eEChtXm50NiWgMglL1
	vIh/9WbINRPxUNilhnDiVoLpLHliEx0FKHlhWMDluv3U6LExTNkMBPDFHoQA6+/1eFiuutHuSoU
	zIsTDppLvQ1QpqjdcORjxReoWI9SBtFUoZ44okXnFU7YaiOwvcMPxtk/tgFcOMedOar0zyCmKqD
	5l3PeSwYKXC8OFEvu5R0nyNhUvJ2agox+qml6NJzi1QlkCelo95nZh8YKazc9DmT9+g==
X-Google-Smtp-Source: AGHT+IGzEZ8QGuJcHkSFhqZ600VMukViim1KFRCkH+NhEb6cwENjWrH6dpG6dADIvnF8xjKmkuYSDw==
X-Received: by 2002:a05:600c:1c90:b0:45d:e4ff:b642 with SMTP id 5b1f17b1804b1-46206655608mr52368905e9.25.1758185735776;
        Thu, 18 Sep 2025 01:55:35 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46139122a8fsm71491355e9.7.2025.09.18.01.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:55:35 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v2 1/1] module: replace use of system_wq with system_dfl_wq
Date: Thu, 18 Sep 2025 10:55:25 +0200
Message-ID: <20250918085525.122429-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918085525.122429-1-marco.crivellari@suse.com>
References: <20250918085525.122429-1-marco.crivellari@suse.com>
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

This specific patch replace system_wq with system_dfl_wq, the new unbound
workqueue, because the users does not benefit from a per-cpu wq.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 kernel/module/dups.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module/dups.c b/kernel/module/dups.c
index bd2149fbe117..0b633f2edda6 100644
--- a/kernel/module/dups.c
+++ b/kernel/module/dups.c
@@ -113,7 +113,7 @@ static void kmod_dup_request_complete(struct work_struct *work)
 	 * let this linger forever as this is just a boot optimization for
 	 * possible abuses of vmalloc() incurred by finit_module() thrashing.
 	 */
-	queue_delayed_work(system_wq, &kmod_req->delete_work, 60 * HZ);
+	queue_delayed_work(system_dfl_wq, &kmod_req->delete_work, 60 * HZ);
 }
 
 bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
@@ -240,7 +240,7 @@ void kmod_dup_request_announce(char *module_name, int ret)
 	 * There is no rush. But we also don't want to hold the
 	 * caller up forever or introduce any boot delays.
 	 */
-	queue_work(system_wq, &kmod_req->complete_work);
+	queue_work(system_dfl_wq, &kmod_req->complete_work);
 
 out:
 	mutex_unlock(&kmod_dup_mutex);
-- 
2.51.0


