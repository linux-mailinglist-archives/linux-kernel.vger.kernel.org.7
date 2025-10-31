Return-Path: <linux-kernel+bounces-879881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8B8C24518
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8DC1889AF8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A780334C26;
	Fri, 31 Oct 2025 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V3mRccOv"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E5733373A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904616; cv=none; b=Dk/SEftqSvnXevdkxvyveDEOePT4qefZbYmqVUvr/C2EkX8DT1PA9x9/i4WZz56jqzs2s2gscGm3tfQb6xB600yJ5cdxNSjPHBt3KSDthdZY+8U5GJ1j7mh9XynPOlywdeBmkg/JvMW7kLw5uyMJULgC7CSS+23CwnQVuKv/FfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904616; c=relaxed/simple;
	bh=iLz+raYpmV/FRkHcddplK9Xz7NwdeSLevio/ryv7bAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibdvDa7lMy4SuFKW3iunxAmBZAYSXtfp7lSvT2MaTNWqWrrAK8j/ZSpVmdLBuqqho2T+0gee902uoTNtZeLla9q60cwpVphplKcHdkjNFm+o/8MfxU+W7Ziiw181eZutJjEnX3j9V3gnMF3gMS4MfLJ/is8I+a9VNbEjlyBs4f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V3mRccOv; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-474975af41dso14601665e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761904613; x=1762509413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j12YdcbQpfT8Ri5Sjm8HpC33Bil9gxYaV08r43TG4D0=;
        b=V3mRccOv6aym7YTtt9V/2lNEh9Ff0n/0sZ46AecSX451etzHFGgbJDbBVBy2bPUw63
         ZpvLKIiRH11FnBwZxnfTkfzbKcxAROTqV3g+gRv8aC76P4FzoxcRAaOdLyjlh/akbwbq
         8TESX0sh8uN06bg3AY4gq2/qIfIZjki7twl4N3ik+S4SwBft8r4ywBFKvqn0jf9sQovc
         aIWGylbufp/pxoCjrmvtUwYbduZIsEdnRFcPDwm9Ebk1r0GXMtIRXTuSXc6mxm4UflSW
         j6tX0dwkQkl5t27NkaqdYBfO7CYTLuD3DRuxLQKx/PiASaFQBbNxyCJqTO7aE6Xr+Vqk
         Nwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761904613; x=1762509413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j12YdcbQpfT8Ri5Sjm8HpC33Bil9gxYaV08r43TG4D0=;
        b=cAKE/pVjVUtB+W5ABaOHuDYQXxG31LzsZ3cVHUHU/W8M4/L4w+12eCm8fT+vMyhq3r
         I/3b0aegAg01E5Aq4ILmZXMws9VDzwEp7qYGkeCCSYOUR2umeHFtX/VwNduzOJ7hKX/U
         S204jqEEqOe7bMCofMeneYkUUfIL+bkJJSoyhP3IPZrHMG4EdqvtBhvOK2K5FzaeJA1I
         f24dJMIgwkMumpvhvzzyGhjVKxmEr/Xx776N5th/wXZbA5ax7sAjXbVGKzA719Z1A/7u
         m5eaIszzol14NRGC1wS8XpzvEiHC+wvRJs4VtTaKgiphd7Fz+zxZZhEPZIV4A5VO++2o
         YGzQ==
X-Gm-Message-State: AOJu0YxJLmE+hWOlEsI/dRNhNZzqsSGRiLEeN36vhDWlOR715uggqbhH
	bEmaOhAUjA5VAp+hOTXqTNWqo2+EwGBG8pgAbB0aRlnEtapAeC7Jm1FvvTalcHaUTGGKBhWR2pY
	b6HU+
X-Gm-Gg: ASbGncuSHxqc2d3dfbYSWNSBFWa/F3Rk0zQMOFQZqcj02zqIZW5FSFjKiev3SQQ1f6F
	W0raJs65Aa1uxkgI/v6dGT49Ueo+dSl3V1xI1RHQ+Ux0l957iAG/aXAFB9GP1oSiGOjOFxIKdg8
	KmtGctLoKxA//49hOvSdTIj2CGyG5xPuIetNnO7LzI2bgpFZvWAEwaMH6SbFqF2q09RSVDPVPZu
	mf4Pe3BElpoXfuJCCeIYJr09gjAAv7HJD8scBE4W/6oroPcFS1R+JsTFl0O7I9DqNbM169QZ1Vw
	xchYWuM97498fOB49RHbHVn5rmxETXmV9+07r0FRCzvO+I7kG35fOq0OmKg17yTYiLhW7EmyeXl
	FteieYEVytBiGJfgfyayLac7t9z3LbrZCEUL0SZ7Ypel6fkaa2e2CDyTv1/jrCjM7hCHTeX/4D/
	CBxXoSIuvRbRsxOTFXsUIM9Pj6nAwonve+7VeUsp5beRAmbQ==
X-Google-Smtp-Source: AGHT+IHIxYUB7ucqmBG4m5QaDjIg9L1VP2kIebkbFH+exLigBCCQXvz5AOOKdVL9nqzemP99+DYyqA==
X-Received: by 2002:a05:600c:a010:b0:477:28c1:26ce with SMTP id 5b1f17b1804b1-47730794423mr28108185e9.7.1761904612811;
        Fri, 31 Oct 2025 02:56:52 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772899fdfbsm81572335e9.4.2025.10.31.02.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:56:52 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 3/4] scsi: scsi_dh_alua: WQ_PERCPU added to alloc_workqueue users
Date: Fri, 31 Oct 2025 10:56:42 +0100
Message-ID: <20251031095643.74246-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031095643.74246-1-marco.crivellari@suse.com>
References: <20251031095643.74246-1-marco.crivellari@suse.com>
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

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/scsi/device_handler/scsi_dh_alua.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index 1bf5948d1188..6fd89ae33059 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -1300,7 +1300,7 @@ static int __init alua_init(void)
 {
 	int r;
 
-	kaluad_wq = alloc_workqueue("kaluad", WQ_MEM_RECLAIM, 0);
+	kaluad_wq = alloc_workqueue("kaluad", WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!kaluad_wq)
 		return -ENOMEM;
 
-- 
2.51.0


