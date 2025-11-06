Return-Path: <linux-kernel+bounces-888846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 106FDC3C0A6
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5E464E3857
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EAC29A9FA;
	Thu,  6 Nov 2025 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EA68087N"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B349296BBC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442854; cv=none; b=SiWL5o8uM1xUWRAVauGFmZ9dJTIvubjGyU0pwcOoj0pkiPF8Si8Mk1tq5onmo9ygyXZCtz//+9qRRIZtGlyOBkzEp4JHJx261v4vUUq5cJCA1bW0s1QniTR4WJT7iW8DFy0gIyLFHSWVRtLIMUs8wYAqCMM9J+L/2zFGfv0ivoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442854; c=relaxed/simple;
	bh=uOY29gfQ9pYvhsdHgOJqKN4kwupJHd/9xjGIv3Qc89I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJsW8Gt+beT3pqCHv228VZdn8BK8ri09Y6cLBdtQaz4U4DComig0IQ9kF1VzJ/KNi3WVF7toygojfOv3Wt0g21gxTFUT5Ev+Rn3TNDP947BuH3MuGM7syA469W2hFk5Pnq/+gDdRw0ko4PlFEJQxaGJjzpyrFYeYJVTKspEG3uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EA68087N; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4711810948aso8045115e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762442850; x=1763047650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OQVBmc/h6wETq5SdNeJOCY5mDPOnuTaKFlnCCqogTDE=;
        b=EA68087NrMPv15v5nYyQaVpb8poiLgFUHhrtVxE5zvyBh+PhgMMcZjBp8cGkAL30Mb
         FgqeuHqsonwT0cgCo2CQYAvKFuuvY5aONXaQ7EmM8suKmQa/v+yL3UZvUuLZ+sANHYny
         /HulVEbX1lCJp6EQbrHinDEa/1mFWwev3+C3GglfGHfJyISgFv4iDz/5V+yzJ7qSN3YR
         x8kyzeSXroMbQapi6ckOT0JivlEmfLyRQgk0vgQo0iSGId2nlovEJfBlesBYryyHebDv
         j9DCNtzNLS3Ac4mVAYqmnXgdj9tTU2JGyvYvX5TRzd5pQk0qnhow2r1qBgGQnddx9gVO
         5jIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762442850; x=1763047650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQVBmc/h6wETq5SdNeJOCY5mDPOnuTaKFlnCCqogTDE=;
        b=CeTsE3+6oGRYZBMxY55oqSwEBppA1BaZGM5gHq4QMedZMyBURlRVMJvCrZERoIlxpN
         4JDX68sLbRPsH11Lb7Jp7HQ7D+uUh4sLAiKxeZTjz4STnb5wSwBSADF+4xc+Shq98ric
         wTFJY3NbdLmVeRxV+GlPfGD1/+McCKRDgEpcpk4wdBXv70moXRmC3HJvVBQpAG37nRM/
         4aQ+lms0sTiTZlTrhftvRIeDfbvV3a5y5cx8WUrE3u15JJYgPJtAOmPeCJ0A0+Ra3BIY
         Ks+p2SlcP8U5TWue15qcR+nbgqjYWsBVTNVuqGyzmaTAk3oMQTdCzRUhMBYvCMorjkWC
         muZw==
X-Gm-Message-State: AOJu0YxLmcfkYZDj2YdwUCIfR17HfFKcNhmXSVJ9wBKnuz6reB6w2/DJ
	Y6JquDOTWTzXU2XcFYkDjM5fYZL1tLfw0lTUs/Sk5UlFX85Y6GvhjzksqbTHktD8BeBXpoeFyO4
	s2/Ar
X-Gm-Gg: ASbGncsR4Lte2xKjVBAnj+u0IvTw2Le9JPW9+Kj/b0cWkA6yddfV3ImZ45NPWi7Ywc0
	WDRAAIVqZJTXZNU5DcA2hVrsuFarkoKXCdvWh69baGrTJV/eXEfVuF7/zvDLV9S9Ez1Z3pIT1a6
	LJSXbhnwCYv6UE5S2TY55bEtOFzfhwAhi2s0IOAjURWD5MSlFjn/imPhmmcQ1cS5RZu316STEpG
	D/WmCY8KzDzmJRvlO42fHOEdi5ALD6dejRhHh2tziM3iwn7wCDBcbAOaNtwCixoxgGFmNrNnSOx
	VeGIfbwTweC4FcMCccDkkHus9Llc2XkGrGsapNU+/+G+ahNMhDzrAio9BltEt7c5iQjr9VKDYeZ
	hvac9WOD3ry5I3kHTI0PydyBVP4G/UaqlAC4beibKclm+cuD02rfbRinVVXdjgI2AVmzhJEek0a
	QogFDr0x8FEaWeRwWMK8/XbBs=
X-Google-Smtp-Source: AGHT+IGOOl9Y37iFUVKIyQvTyVMO2oHC1gnlssxt4NpSnOygjrgvibLrD6QaP23vvHm6Chd4zm+I7A==
X-Received: by 2002:a05:600c:468d:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-4775ce15bbamr92196725e9.32.1762442850469;
        Thu, 06 Nov 2025 07:27:30 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb403849sm6020368f8f.1.2025.11.06.07.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:27:30 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] usb: dwc3: replace use of system_wq with system_percpu_wq
Date: Thu,  6 Nov 2025 16:27:12 +0100
Message-ID: <20251106152712.279042-1-marco.crivellari@suse.com>
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

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Switch to using system_percpu_wq because system_wq is going away as part of
a workqueue restructuring.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/usb/dwc3/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 6f18b4840a25..81307a7b383b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3872,7 +3872,7 @@ static void dwc3_gadget_endpoint_stream_event(struct dwc3_ep *dep,
 	case DEPEVT_STREAM_NOSTREAM:
 		dep->flags &= ~DWC3_EP_STREAM_PRIMED;
 		if (dep->flags & DWC3_EP_FORCE_RESTART_STREAM)
-			queue_delayed_work(system_wq, &dep->nostream_work,
+			queue_delayed_work(system_percpu_wq, &dep->nostream_work,
 					   msecs_to_jiffies(100));
 		break;
 	}
-- 
2.51.1


