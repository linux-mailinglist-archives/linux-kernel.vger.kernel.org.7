Return-Path: <linux-kernel+bounces-770644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DD4B27D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF615E3E81
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8D52FC89E;
	Fri, 15 Aug 2025 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YlDuuQwY"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31DF272E5E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251132; cv=none; b=DZhJN7RzCFHKOl++mkkhZPlmHiATHD4+WuDLfA/harRFRnPpo0TuZUZvUs+RN6OJNWjk7HHSukEHCENdWHzy/ibehiyV60EULb5vkwI7PJKfdwQFF2lWte5GpMzHydk4g50QVgqUfSg3LGO0/YzZniwXNw/U8DYaNwYwN33dohI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251132; c=relaxed/simple;
	bh=zhC7O3ETIu4N/4Xs63PaxH6/C3pmoOa+41VBz4XfTAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdC8H/+m6y6kMfQFYu3GwK9ZozhzM4/9CzTvlol5HfbJulU6NZfXKUKP67JbUM+9Zmmf8Kz4Xaw0CNjd1YIunWvBUc08PSP+kE73sU/wmkywcSQ9t3s+hjLwE/+Buj/eeP5aAIwcMEw7v0S2owf97y24pveDMkPC5CUh9tlN298=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YlDuuQwY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a15fd04d9so18484125e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755251129; x=1755855929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/SuQXvlX5ZWnzROQaWwGQSibOi+ZV2YU9dbORJY9P8=;
        b=YlDuuQwY4vbiYlyGYyUebE6kWQpoELp/uiVKQio9JytKYJyGOMCVusWBGAhQb90eCT
         oDMFjVigF2wmNiPNT4vUKtEZaJpt0JrE2bNZv78BhFWEBjf1ykRxUBdRZ3w7vMo+3ASO
         /0wor4HH7IvjceIHUTL7LsaMr/wlK9WEDucs7AFg1SZwSPtEhpZ6fbr/VJLBNvU4bjPV
         gpDpu6xT1zbptfquemgdBTlGz7pQmkaQowQNTdUZPyzelpv6r04fPR2UtymN2ZDYDM6I
         JkmzBMaKWVTyy1nRoi/CGr1SaP4Z1vZE2YJiljbFwfsRSKcTDPxbOMeZawF3wqcRTY6N
         u7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755251129; x=1755855929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/SuQXvlX5ZWnzROQaWwGQSibOi+ZV2YU9dbORJY9P8=;
        b=Ok+D1t34tlcBlSxRGj2rm9aLfd0lZm1pfW9WwzsPulbozpbVqUb84sbT/ceKA+qKp5
         p3asbd40YUvHqPbg7Ivuhe3s6TgP0uPcnseJsRzGzpiY2cl8HT+cjXlEzu0qj2T+1p8k
         XZtEDWUoVY1RESUhgAkITRjPoIQampVm4hQD7W+RnLoD1QtZwTYORwPm1dh0ggRPxilj
         iBTxUF5lJIByee93qrPrZMaJA7VxlnzlFzP1btf9JmrfwcKYOGxtQZCawLG1wpzLdFj3
         yDR77l4OvCSEZCjz/8m+jHm/3Aphi+Y9tWGxIEAoDC3kPkyQeSYsHdwc6+RX8vegZyl4
         rSVg==
X-Gm-Message-State: AOJu0YwJOTOwq6or2HkC19+zNeA5BXy5iMH9LCb26S07noenWw5cAt7e
	ztltvfChrReYCGJFi6n7ZODrZ7Ex7azWzT5SlQaEK7yr4z3NMcMF1krPLRZLyBRbFPbGRXulPAT
	os+dw
X-Gm-Gg: ASbGncv7c5opMvpxxEI4KAMqs2JvikQn6CzoS1U29uu8iP+bWJXIl+T5y+vVgx0fEyq
	VnHnaWt8Wa0gpyfpxs1qHOngVSJA53uFpuWIjjR3QLtvEAI4i4DlpQCV7+PjmCE6qitRdqSUhaz
	U2jOjY1AheyRrDqZgkcf6Hp52q1tfYXqPnxExXbfahhYkqnW7CNO7cjs6pIvijq7hKf4f7bPpAb
	u5zn9AMadoSZooUw3QBHCqBGNjOqmS6hrCKiFbSEFzlpfI2AP6jt/XCc2sr3TFlezbQPUFlI+tv
	4p7VuWRlF+jhh5QvSTl02uZ3vhMmfUSHweoFBd5zN8WjqilO1m4Yl+tUWQ0h2J9JIhyfxwd8R6f
	QxAZSEoKoSGIXFRBSYcFJA2S0Gq1tQv2t3Cl5i9gqVSIgHw==
X-Google-Smtp-Source: AGHT+IEMYi1KN0n6BqZYvMOm1ISSdw2RuSjMFw2lsSrJ89rukmN4GMnO5CZmABdZy3gJEXi7ccfxzw==
X-Received: by 2002:a05:600c:4687:b0:458:bade:72c5 with SMTP id 5b1f17b1804b1-45a21809208mr12172805e9.8.1755251128890;
        Fri, 15 Aug 2025 02:45:28 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c78b410sm54525985e9.24.2025.08.15.02.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 02:45:28 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH 4/4] [Doc] Workqueue: WQ_UNBOUND doc upgraded
Date: Fri, 15 Aug 2025 11:45:10 +0200
Message-ID: <20250815094510.52360-5-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815094510.52360-1-marco.crivellari@suse.com>
References: <20250815094510.52360-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Doc upgraded to mention future removal of WQ_UNBOUND.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 Documentation/core-api/workqueue.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index 165ca73e8351..c8ece1c38808 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -206,6 +206,10 @@ resources, scheduled and executed.
   * Long running CPU intensive workloads which can be better
     managed by the system scheduler.
 
+  **Note:** This flag will be removed in the future and all the work
+  items that don't need to be bound to a specific CPU, should not
+  use this flag.
+
 ``WQ_FREEZABLE``
   A freezable wq participates in the freeze phase of the system
   suspend operations.  Work items on the wq are drained and no
-- 
2.50.1


