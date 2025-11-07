Return-Path: <linux-kernel+bounces-891041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED4EC41AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 22:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26A14231DB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 21:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE99332ABF3;
	Fri,  7 Nov 2025 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bN97aslA"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2D03101DA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549540; cv=none; b=IIMNMlulE0OF7fXiWLRo13irf2QHNwIaBHrn1/j661w0qV5Rsk76iqwamkeF8rUE0UMGTb+s0oBn+DVNEIy53uILUE5RgDvkcbCpqgtFr4r9mhTZ/YqKG5HUWKLe6bripsckzdQuNk57UqfjJVfuO+7ZbsnU9W/6n4cNbWr+zZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549540; c=relaxed/simple;
	bh=frmW4uur/JiJP0+axQ4M0kbVoUhK8VyFB7s+YzrbZmA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jh2eoBuPCYa/ARu6tCnMlIGjhTntYOxO9laeiOyIdGU726V6Vy2DfpxBi0NhpJR8Zl4r1+Kj6tKmElkum4yufFy5Eii6MHbw6CkAtcu0SxJ6R09VqzBHqYPS731Tg7ImKD36PCtMP4M9XYVQ5RyUqGBX/Kvwo5+Wjzonb/maFvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=bN97aslA; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-787cc9de986so8595117b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 13:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762549538; x=1763154338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LAfmXKExFsP/wCpt9jvB5iXqu6nwsrz4tNI+tUSnwDI=;
        b=bN97aslAgDHF9EpIrRRoahib39FwTlRaylf7ZUHm3nMtLWNtDm0fHBnz+9skzMLgoE
         q/YLCa6wI4G8G9pFzO5+mPiBGlK6yZpsAm4gF5s/FGBdLOEYWGQytYNw4aNHN5/0CZus
         znKxXV4D/NC+3IlLnVBBTgIMnyyqiyVzmwd7hG8xPEgos8oo51nFd/yJdrroy35XcJmg
         TX3e/r+hAP2rLJWc78b+k5LWRuA6ZBC3uTuS+WGLEB8DHQlbpJxj3y0llXa7mR215Gbz
         PKWTow9F/zRCRED9CrUDQdcYpuLlEUVnpBrYB5esWwmM+DtrwLqRVysmKc9WG8IeZ3Vb
         QgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762549538; x=1763154338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LAfmXKExFsP/wCpt9jvB5iXqu6nwsrz4tNI+tUSnwDI=;
        b=OPTq/8S09dZcWoioCQlejYaT+F3ei2tkv46ZsZyFZ84JzLyr8Hu7hhO6+4Du+0m14Q
         jHiw94xi/JVMRki4D/eOtuimhe6bENIbxI4q9bnPieXjUwrHpZq3JHvKiJce88z37s2b
         upfVrG0QpmsEwKaZnQamuBw8i/Ib9V5DHTZmlOCCrA4OFkaKfbh+9r550NTV8rDOnJfU
         6GW5iohja9KnToB+8nQc5FXrDmkoU3Bez/84hvdCHfhfLPraZ5ixs+iZ+E8GBzxpZJuq
         lD3ZrnrWLspnz4O15UuHyzTNmv8opwazEmaNUSJds3sMy/l8VF/cUP/cvrfPjMmBf/yx
         sWvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHsCapAfOuLDehMtVIiEuBYQcVNl/Bn7QvJa3rVYLR7IBsOdEMhEHpk2X9IgXhW3jQxd1y4d0f6biTA0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO+r9P/1VN/5ww65RCQDjXLu6jrHNALpVH38uoDkrS3oiSegUj
	N2qww0pg3NLboxaLkLhxL4lag2unX5aOLHrWAgtlt3aH347I125npiHSSoWJ4slSU+U=
X-Gm-Gg: ASbGncsRjmf4NSVL28VGz/Z5UhXpkhGByosjro66eFo1nWh1bH0yHWgLpap9m3hNvMM
	pzjEqluM0QH2pLvZymt29QpkWWjkEdaV9HgKDgFsUoBh/org6JqsyDULMLGRwSL4NDfjYK0NXmG
	C50C82JzH6UaIIWbrC97f3t1C9kqYz3IwTZBugs1HSGBJngusbPkt/8T/AB68EcozCjOsTm+/sn
	aE6cpMbDgSRA5jpFOXotGwaBZ/BUEsUbX7UNDW92MmApJt5g7UudURlpFcsqBvdPMPyNUR35VFk
	tetBNOcpzSGDCdZbUk5BdYiSC3y/37wQv8uzA3X/SivTakZiy3EfPeAt5zFiiZRqOe78vpYPRMp
	OO4ZNptTvA69E424LOn18O3kDCykoUSzGNKHTM1nLMeleL8j/q8x9uPfj4YLa2eMWiOzhgbpUln
	k/xBvTcX+QICNPmOEreWCS5QbqTWWAh+/2mvcNpKhIVvZ1LoRaapRgFiQaJrSqGgRYH3Jr5zfvT
	A==
X-Google-Smtp-Source: AGHT+IHP3QoDDPe69Dq6qZNTn006B72sZIHWCNrPLWZh2Sy97b00SWoXLarWg9cKIVLBa+/0WbjfEw==
X-Received: by 2002:a05:690c:a003:b0:785:e76e:59bf with SMTP id 00721157ae682-787d542919dmr6289787b3.50.1762549537853;
        Fri, 07 Nov 2025 13:05:37 -0800 (PST)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d68754d3sm990817b3.26.2025.11.07.13.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:05:37 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org
Subject: [PATCH v5 03/22] reboot: call liveupdate_reboot() before kexec
Date: Fri,  7 Nov 2025 16:03:01 -0500
Message-ID: <20251107210526.257742-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251107210526.257742-1-pasha.tatashin@soleen.com>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the reboot() syscall handler in kernel/reboot.c to call
liveupdate_reboot() when processing the LINUX_REBOOT_CMD_KEXEC
command.

This ensures that the Live Update Orchestrator is notified just
before the kernel executes the kexec jump. The liveupdate_reboot()
function triggers the final freeze event, allowing participating
FDs perform last-minute check or state saving within the blackout
window.

The call is placed immediately before kernel_kexec() to ensure LUO
finalization happens at the latest possible moment before the kernel
transition.

If liveupdate_reboot() returns an error (indicating a failure during
LUO finalization), the kexec operation is aborted to prevent proceeding
with an inconsistent state.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/reboot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index ec087827c85c..bdeb04a773db 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -13,6 +13,7 @@
 #include <linux/kexec.h>
 #include <linux/kmod.h>
 #include <linux/kmsg_dump.h>
+#include <linux/liveupdate.h>
 #include <linux/reboot.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
@@ -797,6 +798,9 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 
 #ifdef CONFIG_KEXEC_CORE
 	case LINUX_REBOOT_CMD_KEXEC:
+		ret = liveupdate_reboot();
+		if (ret)
+			break;
 		ret = kernel_kexec();
 		break;
 #endif
-- 
2.51.2.1041.gc1ab5b90ca-goog


