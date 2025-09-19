Return-Path: <linux-kernel+bounces-824849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A08DCB8A4A6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A071BC4FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341593176FA;
	Fri, 19 Sep 2025 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eN9YkC58"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3548E31A04F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295822; cv=none; b=eOS/akUUDm16Umkf/4nOH5qU9dRL1IW+NaBWLBqsnSFmq8dTfjrCMM7NDPl3Ukplcd7KQFB7Yvp18GnmFh2YKqgUTL0VBtlosgmXk+ZTv84K+W514gwoq9cLbniKZXTtS6ZL2PhmAvxIemwmi+WH86IiU0ZEeqnbIWOMRW1BomY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295822; c=relaxed/simple;
	bh=GJ3i4+LsfKc9WpQ1wcBHCTr8SB3qVGwdJnEdU4cpqZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQI+EV3Zp7gFD2QWBY+a30wOPy5EzKUsYWkNfCf6hqaRqFF9MW6Gx1DfHXIgCYZdoNi/5xZihal7NgiuofIR6TLH3nzGaCN2QVwszLOv1Q78t3D+9QwW0ySXoqqa1Y+5S2qamvQJsnLgV192wOXe47TnwtwfE6wfmNwlK2Xp1lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eN9YkC58; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4687b41fb56so5318645e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758295818; x=1758900618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tO/IQPVYDqqtlB2rmmi4bluyAFwpFc08AwpJDhqIZj0=;
        b=eN9YkC589iYkhLd9+CqO7lKvM/xed9r0Gc8sYs7W0T68d7SdKtl0+7tDCvkw+kdf9j
         lTb0XSKeBluX3xlVi4mFVM/+mSvSfFR6bpQNlwoZjsCy6wUCYan0DKxnQPpEjooYm9VB
         X0AiC1kwerXJeAj8uBqkbCND8cU+WuhTXfgu4vqjAQXK3QZ6zHQKDklFM2iF4CT3I2p9
         kChM+DXnFr2FR/5Kof8Y7ODE9Tjz/U1yPS8LbKa3D7KKNAAJtQpDRHjsco3D/OOJFMOS
         KaChG95BWe7JGaCIWKu/D+j8RwNuxrjddAz7kxfrwDtigJL2SWplE+Iwk9HcOyPELe2p
         1cVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758295818; x=1758900618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tO/IQPVYDqqtlB2rmmi4bluyAFwpFc08AwpJDhqIZj0=;
        b=ZLNPwdmc+vElIDTfyeRNHHHQBKGD8XJtDN0KqIt1oaTbr+DueJXf34gVceLofjHdXU
         tML++8w/Qce6QHJD/R1jz4Snz7A541SpEm8ui0L8VYwv5H7zDFfXwswlRQCbsNGeb9Id
         J66Yp+ew15M5fRqBbKc4J09CGqc/g0HdPQR6qmuYwrJPb7ibf4OuGeP2cJy4yxumVI3A
         d+aaEE66hoXAtY3T/q3JPrqYMS/BBkL7aK8jn/svDTTOaKwxlCXQ94rJ3/aw/JH55PU8
         tFqeYJ64uG6cCp0dnAVyLFI8w72QQyVJOL+wIWlhLqyaVESs45GZ3xpAd4OWKptm8O9y
         EQlg==
X-Gm-Message-State: AOJu0Yxjsxhq4BENzaTioPsUlPNDVCIJOp8mNOv+DbRRCd6CDX9QhlSh
	RXFu5lDTGciev8pFcKGHRlOWTBYhL8pyGYVYSkfLMbsgxD3gFa6N/X/aYLb0iBmgX7j9UDvRNnV
	D0I5eacU=
X-Gm-Gg: ASbGncs0HQyQ0SAPq+iQf1ByGSO8lNRSZUWuopXkc0SBvig+U5CerUCwXIysiKop2EO
	2iw7N2CzRb82Ky3o3LxBGpzlxRjlvj//MRQ4wXKbl6iAsaaSQkwPRKy8XLp9hBq7tfzY93pej93
	NkcLn4PmvYs9p3SGYdEMz3RFNMP3z2eNMGTDYKlF7MMpQecipoQ7x53DbqvG6YveqOBqozCIVZy
	PnMJXLcTQnsicpW4SYro3qbKryM9oBNmGzKEN2MoosxHyYn8WMSNZYhtxJBlpAkuolcMBfnXuOE
	OGQXRb7UVpGFzjGPNXyVaiiAlk+jCT9InirkNaDzIUtn0uIbENVfiLD7WGFIPmCEpRHjIEbSilv
	ZlRF1LUnWU+QGk1Spkf1iDv8Jw8UT/8EcJHHQAXOnURfZaQ==
X-Google-Smtp-Source: AGHT+IHtwaXYVf8fILtIiK8C6Q78828xfzfcrquxMpn/rQtlsYUSo9WhEXFxmG3bJTL6e/1UkHJSUw==
X-Received: by 2002:a5d:5f87:0:b0:3ec:42f9:953e with SMTP id ffacd0b85a97d-3edd43b5c0dmr8087717f8f.7.1758295818149;
        Fri, 19 Sep 2025 08:30:18 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7284sm8619156f8f.33.2025.09.19.08.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:30:17 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH v2 1/1] PM: WQ_UNBOUND added to pm_wq workqueue
Date: Fri, 19 Sep 2025 17:30:08 +0200
Message-ID: <20250919153008.324338-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919153008.324338-1-marco.crivellari@suse.com>
References: <20250919153008.324338-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This change add the WQ_UNBOUND flag to pm_wq, to make explicit this
workqueue can be unbound and that it does not benefit from per-cpu work.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 kernel/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 3cf2d7e72567..33a47ed15994 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -1056,7 +1056,7 @@ EXPORT_SYMBOL_GPL(pm_wq);
 
 static int __init pm_start_workqueue(void)
 {
-	pm_wq = alloc_workqueue("pm", WQ_FREEZABLE, 0);
+	pm_wq = alloc_workqueue("pm", WQ_FREEZABLE | WQ_UNBOUND, 0);
 
 	return pm_wq ? 0 : -ENOMEM;
 }
-- 
2.51.0


