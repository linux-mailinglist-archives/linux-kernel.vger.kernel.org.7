Return-Path: <linux-kernel+bounces-899749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 00859C58D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F25BC363E09
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B1430AAB3;
	Thu, 13 Nov 2025 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hFEfF5BG"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DF21E1A05
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049977; cv=none; b=Pg49YW8l0DkMm/3M/rRg2zIgjPgpnxQr2fGlOtFOOECXGBfzGznK0LfDUeSDUk8pPGxp+3ajEJoW4u5ELbCgqqn2BIkGzcanZcqYGPDTj4SYrkOmsT3TVadztcVxN0bPii0x0nIGMVbD6HLNNQeZnFgN3czIv+iCSR8SEp9PoLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049977; c=relaxed/simple;
	bh=K7xt323VJ1uJRwqxUQs4bzCVCzNHYNwFwbiulRpdL5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rX2NIISTBPg5iF71zZtiqf8nveJpqveHKFPitQow/WGaZBXlLEwoOpL3C4WMmV390E8Cku5YNDE44amprHqs89cVrv26RuGC9Fe1bCAjvxtllUf2wAo5IC/3OBHznhH60aCmfDIHo2fCtTAOX1COUpicA3u+WQDT2e4794L7wwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hFEfF5BG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so5159545e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763049974; x=1763654774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jih7gSI3dbyWiOmzQIAyW8PRU2Q1lIgEuIklK2h9qCU=;
        b=hFEfF5BGpfnMohemUnzclnr5rC19eZVo0/h+cbeTXZOQqvDtCCAsEKq4y5CluuQUqw
         gTGry9sngYbCBQF/b+rPRzOh+euMiFjIN118NTjySuhApK/gjvlRLsdWnw9VV52Q5zGa
         mMFWl0+VLXwquA1PWXmC2vDB0lbwoovOxTx7UE0vzo5okRcq+qVcXRbWFDk/9wdOic4P
         LrPx7bgN0tzUKoITf0sxEHi2/8y/bNxtn/glLI/t+FaCu0SX2+X3s/EacVl4E64xE9BG
         XBEFPlDeAsccwaYaVHMYMZ5RyLTjdIRuH1YjURe4cIirGvF+loKNQLs59o75UNs4moxa
         I3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763049974; x=1763654774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jih7gSI3dbyWiOmzQIAyW8PRU2Q1lIgEuIklK2h9qCU=;
        b=iXReFyOrLJ/ccmx6LJJZQcLIhRPTZp7Y3Q3XC8n+RkzntkdH3jY1TXOshMV3uIOMX+
         k8rI3i3eHohrhTnMKQNXMhgYVXiX9VExXKQj9I0KUEBY4UFvEg4dMonsPSlwjxXcPOYE
         b2nIvZXRQpaqNfXJfQuFg6vDPfjzHf9l90Z+qiPc/hFY68QmnAfZUpyB7mJGqYJ95t8X
         z43lJLeJ5EYgwZpQu4Eb8usRD/DkavkKim5x18c1VrK45q2c7M4EDDPnS2jaokEqa7TP
         bmePCKxU6h0S/FQl1A3KlgphYCm9aztx8foasmrD3kHRT89pG+C1yX2UfmI8QCqq0CsZ
         tfMg==
X-Gm-Message-State: AOJu0Yzs96Ln8pB5B+zPgt8AjYjomHfM5Oi1Zpiv6WYiSqTq+amgdHBA
	q2/8oXbt9NE5A9XTAJwHbP1YosGqFEFDuSMjCxfW9TIjfWiapLR1UqWxltHsoCENZOJ735X/N8l
	hWdwA
X-Gm-Gg: ASbGncvcnOP3KPx/YZ8OA9qsT41H0DuboK5ZYEQq0S7wMdk96n1GWESJLnE/lzs99C3
	a2QgBj6rjZq4uvOvavZ+5flLxOj8vPQF3YWf7b3d1f4BuDNqQzNwcar5n9cyGSozoa3Zg9zm8iW
	uFmimIYTC0RZQcDd3h6gBCrIFruOKYQRzBJGmz6BPWaNZnNrY9lb39m+SAjsmsRoIMXt0dxcnxx
	9aFwArIa3VG6UmAKnQDeRELHJ+fGnxZDuvVOZq2JfYppr2LFjzXOVetLfGmkAhucprIb6mD5bKn
	Ej8pEeTq21Rs1uxu2f7bsrAbh5TCcBGGjbldY4Y15HZxYUYizCMHTYO7MHdal2tV+WTSlUMFnBW
	WWKf5+pkIo0XBnG3l49rP7RNloFB4glCE99Kgp7Ej4xbf0IzygCYrC8l/SqZ2oC4vNp5lIMXPkq
	5fUGwzUnObZ1eHItw1qyxB2Map
X-Google-Smtp-Source: AGHT+IG/TUS56JtJew2HLvlhyV4PRkjY0fBbwkOSF9xrNpWgIoGxEVrZD8+bc1Az1z0UWDTcxn4JZg==
X-Received: by 2002:a05:600c:1f88:b0:477:be4:7a52 with SMTP id 5b1f17b1804b1-477870b62d3mr63554405e9.39.1763049973769;
        Thu, 13 Nov 2025 08:06:13 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c847c3bsm41595415e9.2.2025.11.13.08.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:06:13 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH 1/2] wifi: rtlwifi: add WQ_PERCPU to alloc_workqueue users
Date: Thu, 13 Nov 2025 17:06:04 +0100
Message-ID: <20251113160605.381777-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113160605.381777-1-marco.crivellari@suse.com>
References: <20251113160605.381777-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.
For more details see the Link tag below.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
---
 drivers/net/wireless/realtek/rtlwifi/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
index e26feb8de658..2786e4ee67eb 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -445,7 +445,7 @@ static int _rtl_init_deferred_work(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct workqueue_struct *wq;
 
-	wq = alloc_workqueue("%s", 0, 0, rtlpriv->cfg->name);
+	wq = alloc_workqueue("%s", WQ_PERCPU, 0, rtlpriv->cfg->name);
 	if (!wq)
 		return -ENOMEM;
 
-- 
2.51.1


