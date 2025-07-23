Return-Path: <linux-kernel+bounces-742731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9702AB0F5DD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 178287B7380
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9362FC01D;
	Wed, 23 Jul 2025 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="YYcyprev"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D842FA645
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282036; cv=none; b=FarAb1K6b4WwMQnGkznao3B1jh+KgkEGheYUddvaXuJ4BP5HyeOeddNnb5FlWmOI+CHLV3w7c1adcnsQsZOdJWK01+/etENOT140htD3SOTbkRAH4BWYp3aTIvNSul9ja5qoIZSWCQI2BlZYAS57ZJZ2kzFwvA2dEdfyx47BqXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282036; c=relaxed/simple;
	bh=bjMsn0d+DdHq5tKORAnt+APd2ow312ZieXyXxxJ1EAQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjalcmRrCvqmRNst48kDbUQYfb79lB7H2ZBYCwZFNz5knuzNKWkYVenn7nWgNW+7aOQJIlAmT3afOky1at8ojs40YcjcXxMYDqqUZHSwa4nBTcxz6A1o7VJZyXU79jjg1jgn19+rMi+hsUtgd8sBHcNPbtkTNdKLjyY0rYY4xL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=YYcyprev; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70e23e9aeefso46936207b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282031; x=1753886831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrgbtdA3RdwzYLcpgmSOZtyyO0wlzXdBbkaeyV0ZrEA=;
        b=YYcyprevxnCTmOixqqXr0d0w+E5s0nacz+jBpdJYKq5vD8DBF+iD0jDNrxvUK4GBdj
         E9hFw2AL/N97+sHtKgmWbxH+I9LEXxcPRvqGJ/qBFUW9qJr1SgC6hep1fRvLNyPoWH4e
         q0HEm/CLU48eT6ECu2ZFjj30PQvcd5tBiuImceL7YnQ16Bwkpyo+nQ2uAHSt5lJKddKg
         XIJurFPyNr+LZOLswiqxm4/6KTEnXXHnjzPSJST94ihrIGjAolTTysgZDjDEIvXCDYC+
         ge5Ar/LhWdLH7dU7rBGZT8vlR5sce3mgZNeFB4GFr70I+c59+HPtI85u+gL6aPmJEd/a
         W3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282031; x=1753886831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrgbtdA3RdwzYLcpgmSOZtyyO0wlzXdBbkaeyV0ZrEA=;
        b=vmKjr4oxaX6EbUvghqWYPw7UB/jT7lShtwfwM0LkPYvJ/73b42rqAhMPOb+z/mi3tQ
         lErVPwMOTEzRJqj/x+X9JYQHq+a/5Ye8fazhwTKmFT0IF0ZkzGTuULKj8SXVkxeRjpuw
         Lnm/02reJ3BYNigngk2fvL1/95FFU8EeGJbkjUxqCQ/KPJprhrhsSYAuXCCABln97t4I
         gh8y9CjHusEmgmXkzP48hbTk6gDnhLpCLkLKGdsMq8ycfNueTMmyf7HbkWBeiz4WRCW8
         FScypKEKkR8Fesnp4CEsc3nzZOLZz+mW79VgBBJskLE+1temPAcB7Qq2BkN9NQwN62rj
         eKNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUhyZE/lr6zZQzjKaIryULAh78/SSWRD44QH+3CZA/S2FQIUCDf/ohjTeUBi2Mzwv7HH4kVivdyfO10tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMJMFM+AtjXIaqhrChrmU0+F3Atlw0wr/ABW0VPgDQuP9KEMZ7
	C0cnZRgx5ozVPmubHB+yNizvddwiEnNXE+D98T/DSlM2hzZ2pcW2YyGqkkTQejm5ukk=
X-Gm-Gg: ASbGnctFLdcI23lAUYZekgoxZPvGONMuIsQkRoFa+LwZmVwpX5DssuMayuLcTu5Wngw
	Tr4zVsoGXF/dn3wTN9e64qnekw7OPpddx/iUMFWY8fM0GXz3lpuuKOohHRaqOWtAal4+Ktd2IGw
	ev1OhBTf1fU3FAHW386NGPTh9va3sEZTfB2TENIw7DctT2Y/dVzNmb7S9DbJlOHbOQLObi6ESPl
	WKAKvqAXQPphIoFomtk4qMeR055+wdUq5MLp15BLvtjPyM66qfUQogisIUoBuE7NjXSIcm1rnnB
	yjtkOlv/v9gOR+AsQsA7ej/JeaULOJ2LY44G4i4Vii0tuiV8fToAcDEPdlLO5ogs9JbmKHHR7Dy
	0SkarQweqzo8NSe/7RVXgmPygTSXH1rR5Ff+07aGrjV+S8FUNnQK7Fpmb2Wbs0AbAUu/YglNyQ+
	u/c9aq5wKWxg0h1A==
X-Google-Smtp-Source: AGHT+IEtHo37LGPot/hXX3d5/RxjiZTetvWjVt3dWuTs4pORFq/5bZ2tCgRCgkPbneoKEGKAmSRK9g==
X-Received: by 2002:a05:690c:f8e:b0:718:3b9f:f1f0 with SMTP id 00721157ae682-719b42e0146mr44064387b3.26.1753282030545;
        Wed, 23 Jul 2025 07:47:10 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:47:09 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
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
	witu@nvidia.com
Subject: [PATCH v2 08/32] kho: don't unpreserve memory during abort
Date: Wed, 23 Jul 2025 14:46:21 +0000
Message-ID: <20250723144649.1696299-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KHO allows clients to preserve memory regions at any point before the
KHO state is finalized. The finalization process itself involves KHO
performing its own actions, such as serializing the overall
preserved memory map.

If this finalization process is aborted, the current implementation
destroys KHO's internal memory tracking structures
(`kho_out.ser.track.orders`). This behavior effectively unpreserves
all memory from KHO's perspective, regardless of whether those
preservations were made by clients before the finalization attempt
or by KHO itself during finalization.

This premature unpreservation is incorrect. An abort of the
finalization process should only undo actions taken by KHO as part of
that specific finalization attempt. Individual memory regions
preserved by clients prior to finalization should remain preserved,
as their lifecycle is managed by the clients themselves. These
clients might still need to call kho_unpreserve_folio() or
kho_unpreserve_phys() based on their own logic, even after a KHO
finalization attempt is aborted.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec_handover.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 26ad926912a7..7908886170f0 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -778,31 +778,12 @@ EXPORT_SYMBOL_GPL(kho_unpreserve_phys);
 
 static int __kho_abort(void)
 {
-	int err = 0;
-	unsigned long order;
-	struct kho_mem_phys *physxa;
-
-	xa_for_each(&kho_out.track.orders, order, physxa) {
-		struct kho_mem_phys_bits *bits;
-		unsigned long phys;
-
-		xa_for_each(&physxa->phys_bits, phys, bits)
-			kfree(bits);
-
-		xa_destroy(&physxa->phys_bits);
-		kfree(physxa);
-	}
-	xa_destroy(&kho_out.track.orders);
-
 	if (kho_out.preserved_mem_map) {
 		kho_mem_ser_free(kho_out.preserved_mem_map);
 		kho_out.preserved_mem_map = NULL;
 	}
 
-	if (err)
-		pr_err("Failed to abort KHO finalization: %d\n", err);
-
-	return err;
+	return 0;
 }
 
 int kho_abort(void)
-- 
2.50.0.727.gbf7dc18ff4-goog


