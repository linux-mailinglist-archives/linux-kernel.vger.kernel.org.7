Return-Path: <linux-kernel+bounces-881349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA89EC280F3
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 15:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5AC3B5EC1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 14:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E212F6924;
	Sat,  1 Nov 2025 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bFlitAdO"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F2E2F9DBC
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762007026; cv=none; b=sNyXFUlAb0eAvMwWKSgKGHBpWPAUtablrNbSSdcv7ut7360kwsLNVRGmtPpRwaUD2JGpWluv/T6KrYhxknLZgfOVC3FDuo+yGPY0wc0xHRg+7oMoJ29+e05eK8f4bJfNmpGP7i705mtJTqpjSJLv0ZJ+VQBMQvM2y5DiFQi68nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762007026; c=relaxed/simple;
	bh=+LuQqkGCe84RIp2fAEq/d3OCjgqkDPmWEUoXD9tp6JQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmvtAMD365Be7dsvClOlurcXZYAV5xgwdbai2K9C46DdhWIOolbcmMVTlu2I/ZANusnhA5A7rrDM8cfjfcxo5e3Sp5742CFb+maY7blb6+ZxzvEEpG21rB1/6/Poy3nJpMNDqxGhnN/hTb3hLo7eg0S/T+dJxo9PohztmLSsBqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=bFlitAdO; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5d967b67003so4059682137.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 07:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762007023; x=1762611823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3sZsODYdE+lXQW6sSfXvI4QX3oinLZLnJVK+OowB7E=;
        b=bFlitAdOMFOlBGqOhB/WtEoPPxWEoQnpku9XX5BdVj4stcmqVMraZiyeck1o8S6Hmc
         ihe9wpxvUT/YnAwr1SUOMoWbe45W5NBVIgepJ9YLjhrFHogtoJIPnm31qlnwf5e1jzzU
         /3/EH3VOnaoWdhkvNoMTGzlF5OdmWFhlEIsJkeItHKWL/W8KTqmyRjGbtzAPZnGzEARg
         s/1x0SRDsyR/VjRHVvopZpXoTUTBhDp9kmYGm446N1CqUm+JjpyU5VRkxbtxLa7n5dyv
         77Sz9h91Ca0i2Xx5wkoUP0Ib3YNaSP6KEMQ8P8tm8yybQ8moKDHUfM0gpTlykavElUOi
         KFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762007023; x=1762611823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3sZsODYdE+lXQW6sSfXvI4QX3oinLZLnJVK+OowB7E=;
        b=wSwKokdzyX21ClP0iGRRc0QrRt6rFB6oI1bdGWL731XZSWb/SHyS0+n3YfX1YZtwk2
         7ijagk9Il83aZpCyv7Vwb8YKSyCEGYowz7oLk0gOivJIISd1G+mk/f0wv4WcgWClqgYD
         5y79pNOND4NTgY3Cbv94grA/AWxe5jX53UoDNdpFTSrryDfdLmxtfSqn3YdxY2dNFtJJ
         XwvcglwDRR9s+9EhLntKddzLGt5jSvN+eP3QGS7A5FkaKjDBwA47Cif9agBqF+v3C6HH
         xJxiznZDGaSGTRfkqrHv3/lQgKt+89BmdkQhsdD19IlwKXGt9sxmcZH8/bZpRpNaClvM
         7s6g==
X-Forwarded-Encrypted: i=1; AJvYcCWIi6urAv00v4LmAFH3HMgSA4MXw/qo3xw1WrIp+T6VP2spKXX/NpvAzcmCIM6criKSrB/NIc6ENbD/XzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YznkdSIflATMlB18NY6+2DYARPG2vrzC4GiBRY3556QjLAOz9y0
	ERybSHvkuPtwDuNoSrMOIr0pN15MOdP9NAHqg+iQ8Cb2hscnqJFGD4+maNG7hLf+2XA=
X-Gm-Gg: ASbGncucos0Dk8HhnEuxIPYwTigfnk8XInMRh5AoBiQK3jecrlhGPpaicX/Qs94hawS
	26BFeIQm6aIuOv7SOTgy+cWC8Kqj9Qkh9tQ4k4escl5wejdGGeQav6/mg2oKVZN7lgGy66OKbfY
	ZZV8eXSPmJjFEJx0Qz00u0km+89O52dhRoLRDwmZ+AgBXXjO3JVZgcRRlf6fTOF9LNiiIbhav6Y
	cc19uOKyK2KdfUKRQGPi2mAVOxma19if3jYdA6Ryonb/8+gco1fyFLe99Uvj13s53366ejg3t4c
	ATMnMAwrIlmbb2wcErFUJL+hlrHe6ZmUgNx+8asL8G05Of7SPd5azwygvaiqWParRY8czA0QSk9
	372FJT0JrHgLB+AnbNeLuBaDOFu2LYPREwk3GsOWZMd6n9OTLYtMV7SD1ZcdvuSfLlf2UD8wWnJ
	7QwpBqQESvk6IWjV31nwBlrRfSk1VxZwKfnx8WnU7uKZ6lKG4pvCqAcgRGiU59mKVbip9n/Xg=
X-Google-Smtp-Source: AGHT+IEW1fTK12XGUTtqXJsef8/76poVKTgBxu4YxD9HHtSEN7ne/NH+yy5cGEPUcuJdr6fOnT+fYw==
X-Received: by 2002:a05:6102:8349:20b0:59f:4f48:4e31 with SMTP id ada2fe7eead31-5dbb11f91c3mr1950860137.1.1762007023601;
        Sat, 01 Nov 2025 07:23:43 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-559449647e0sm1776242e0c.3.2025.11.01.07.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 07:23:42 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org,
	yanjun.zhu@linux.dev
Subject: [PATCH v9 6/9] kho: don't unpreserve memory during abort
Date: Sat,  1 Nov 2025 10:23:22 -0400
Message-ID: <20251101142325.1326536-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
In-Reply-To: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
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
index c514b300ebe6..3adf86c7c2db 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -1118,31 +1118,12 @@ EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
 
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
2.51.1.930.gacf6e81ea2-goog


