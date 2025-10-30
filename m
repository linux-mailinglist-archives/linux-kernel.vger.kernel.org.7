Return-Path: <linux-kernel+bounces-878634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEBDC21241
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EEC63B82AF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB60366FB3;
	Thu, 30 Oct 2025 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XYH/8ZfE"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C3B366FC7
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841257; cv=none; b=OUimVRPY+TsRK6YIUmlnEMA1bQsSAfY9RNSm9RtcCVqQU7GPhcVk5CVN4TBX9RrWSIYJfIrc2wQ9wIoLsnPVoGDmxhCz5xTr7Qc5OO0lZ1VYAnnTYKPJifw4otCGgnbz9PbsV7Lv7eNDxFicsI8tl/YgjQWuYlN1OSbv8Qx9xyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841257; c=relaxed/simple;
	bh=DqxuCxEqpt0tUYNo6pQRu8flyrSjUpL5JZq0bQeakKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCxEivGPHV6dd4Nxtp2nbM47jn+odU1Ou61EBHuR8jf5X9CRnoaWmPR783KqzyzZy43pGIjRnUxIwTY9eLH6ZLBcJ5r4MRKO+7Ik+7peVCLEIaXM4TpkDIQwt4WBPGzvmVU6Yf39/AMprRXQuhfWBAl+vW2V6ZuTHRUIQUexazI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XYH/8ZfE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47112a73785so9985855e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761841254; x=1762446054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvhoZDKhlKXBJ8oco1eRo37f/o37YxZDGMLsPeNe3VU=;
        b=XYH/8ZfEmgz9hg8474Ffa/QeVcEXs6cvKFfglH2kKX4nGRmnRm9XTrEfvogbUul34b
         EysUpI2LSwSdhjDMInTe3ZM1useNsaHrsJT9TDEWhMg93n3LhpX2KSnVidfInL03Adki
         LG+N1UYs5uMf5WxzxRt4QCOFPtZE40smciuU70gI556xAbc8ReDppaLjbJxsD6dym0gH
         dfkooDSqGz+p4hjngmxkl9RUkVWZFZVPuBq2n0C7fw7oy7lz4Fp0Gs/T/ZWdeR/4CazM
         wIzoIZ0L0X1pogykWurJUiJpDJG31QHBXwZ+1Zh19RgKoB2nF43vby4UyXlmrV7flSPv
         iTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761841254; x=1762446054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvhoZDKhlKXBJ8oco1eRo37f/o37YxZDGMLsPeNe3VU=;
        b=o9Cb3eNV/+89VswKhoVBERT0eIv4NfpGmXtxZKgHEWtPTRa++2z+uUwOAmYBftXeps
         kLF+EbzZQU5c3FQUpIVjGNcTRSBoFmoUi+CwlBJxXbmh6+cMcmh9Pv/zlmIzOt02Fwy2
         kzKr6Q6v7MW5Lu6H1EzDeZho22KmaRfwlrxI+KGFA/C0Usw52ueJhVF6RLKGevfNRQGq
         YRhhGgXtatNpwjOph74Fvl1aarIdYGJtyrFlMHA8W/3Mj1moJBeuwKNCcjNPLQXxEcvy
         8oWM7w+gvkFwRxCH7LyU8e0vffRWUdhw8V8N+oMCRGTiJm2eZno5/PNvtkyx4tfrMGan
         i7OA==
X-Gm-Message-State: AOJu0YyL4SuTBl8Z29B8q8hdneoH8NkbtqTLg5P97HwGQ7C6BdAXZp8r
	6IonNRhH+nqw78pGAOIDI3Aw8bQ1WFGcL86IJbL33VBnCK+3yXotttlUcTf4g5kcDOhGoN7tgW9
	3dWCa
X-Gm-Gg: ASbGnctDYiax8AAoFzI/b61lXuwrPxCBOBlmlWi7Gz6WyG8Qt1fK64c1Rbi+pDoy5ZS
	yLCnVdOkXpQO1Jv7n9TsGxTDr8awJCat5gZnveYX+YM3H2cfXk3Ip851ChJlBYka1jwqGO5wkeM
	q/W4/xnuXWFG6jh8yBJxpQEjQ3ReQlbrKwF7K5vKiWpKLhyU4oxWGI5slacay5dNaqQa4+gON0i
	hzimh1zrYtc7fuDJAI7Cf4IiOOBwYcizvHuIou5GtUBHTJcVDGTUWHtsj6+D/QtD2TSxYhtiB/1
	/gD49aoaPZGC5/3z1nZtdbDrLcrTGX4Hu1SGcDa9ap9eiMixXyS5lihhFISLiBYFFz7jqlw0Ns2
	fSXCNHbtp6PaOREnrkAmo/tcJjo6gz1FVw9Ab2nH91tRQUNA/MTGYahWOLfxj4N0KM3mn5Nd2+w
	SPTO2UweGJS83Hoh8=
X-Google-Smtp-Source: AGHT+IEiv28lW9KdmmMYgI75WgkeZBBbz1nTgj9Te/yi69S/DrP4tP6IvUe22f7NgxzNcoh3q9LxsQ==
X-Received: by 2002:a05:6000:2507:b0:429:91ca:70eb with SMTP id ffacd0b85a97d-429bd6f0952mr131737f8f.61.1761841253788;
        Thu, 30 Oct 2025 09:20:53 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df473sm32758678f8f.42.2025.10.30.09.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:20:53 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 2/3] drm/probe-helper: replace use of system_wq with system_percpu_wq
Date: Thu, 30 Oct 2025 17:20:42 +0100
Message-ID: <20251030162043.292468-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030162043.292468-1-marco.crivellari@suse.com>
References: <20251030162043.292468-1-marco.crivellari@suse.com>
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

This lack of consistency cannot be addressed without refactoring the API.

system_wq should be the per-cpu workqueue, yet in this name nothing makes
that clear, so replace system_wq with system_percpu_wq.

The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/drm_probe_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 09b12c30df69..d4dc8cb45bce 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -626,7 +626,7 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
 		 */
 		dev->mode_config.delayed_event = true;
 		if (dev->mode_config.poll_enabled)
-			mod_delayed_work(system_wq,
+			mod_delayed_work(system_percpu_wq,
 					 &dev->mode_config.output_poll_work,
 					 0);
 	}
-- 
2.51.0


