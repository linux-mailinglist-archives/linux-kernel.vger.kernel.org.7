Return-Path: <linux-kernel+bounces-869173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA454C07375
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1308B5813F0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EF9337B97;
	Fri, 24 Oct 2025 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="i8TI6USH"
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1E43376B9
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322214; cv=none; b=Cf3Q6KOX8VgdtKAwnLO36RFad8HX8Z3q0BfgGBO0IISWkbXVfadpjGcPHvLRF+7h/5ZrkRnfz8VfEPPUxXpR2ZOv/Uvwa0pqqAn71jbOcc2srQa27GasTxdV5vsFwy+GwTnJBrr2t1Ys1oUYjQ063o+ifX5ZY9hJw1+UurNCSOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322214; c=relaxed/simple;
	bh=Qk9S6IHmnrfw6wGq0UeG8nzAs7ZVD29vG6VZbpdt4P4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoaDqiBEgcXMEdRtIX3SAxms7bNjR4pQmpbTFDb2uSQXxi/Lx9C+cSCXCpIc2q2MDdBK7xgn4dzl/Rj4BUa7Iwehq2aKbWcnc0b6+7t071oGovwyAaVPGm9t9j5RtcMKd9NekNL9z717q7NTr0UE77orO8eCaE1O/q1DWF46eRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=i8TI6USH; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63e1e1bf882so2168840d50.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761322211; x=1761927011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tqVXyF+IsYXkvSZaiTZ7JkU0PjsMFTNFd+jvNj7uHBc=;
        b=i8TI6USH3ovpUOvOqT7ES6/CEvz+kW1mdR/tOkbCef1KYO1Ff6QgleqdhlUOEcCBD9
         j0LL/Ir4RyOT81WiLI2jx5dXHieXzlYwfYYWiqbFKn+CcKPgAg1rJUKFkRpjsNksawQc
         gBU54fw24tRt3r3/7IJ4MWPzBj3T0edqKPIszJfTt3Ok8Im3IhvW0TH9HtvIqF1AL4rb
         0ChP1HWn6zETm5al/KiNgYE640m+17VmjkxYfv066qEJZree67E1oYk0Dxg77TAEJVlw
         GQ1RMsiaKqzK+YyoMDPpC7JiirTvQ3+3cRFaYvAOUs1obbAJKitVlhfV6Am4x54Jt9HP
         0mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761322211; x=1761927011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqVXyF+IsYXkvSZaiTZ7JkU0PjsMFTNFd+jvNj7uHBc=;
        b=sqIiNbGUUxzM063pX5iDOJMa4lnyH5Ag8jHmZED82MlS/CyWA21xq92zvJYmuu5D7T
         YxSGIvQ1uo5qOg9cqhxlf15TkID/q56ufjolIUxomq32CjwXUWiYwko5KhgOS5x9FGHH
         ngIfRdB6bYQfOYBFhpHWzTbK7u3xGx2H/XQBP8rqZkGovc9KwyB8IQR2WAtcybOw9JUY
         yNPwa0n00sbfbIrDIPJoEwq9Me3B1r+8Fl7b+LlcstbjglP/eNTizcuBouRax+dV++xW
         TbBOmYmpH8lGB9qif9B40Sx4CIezRP8CSzSD3XeHS6uSUVAwkDFeHZEXHnO3nRp8m5Fl
         W3Hg==
X-Forwarded-Encrypted: i=1; AJvYcCW3Gym0pQCpyftacWaLCMkx2aaFK74RkYplTPiQRznvpDo+tkTpzG9vljZOwa//Dcxsl5GPL7deT2UCDl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygdips8fYQhBpTTZ9Zje9/mwgW1gJ7AYpNy0C7rOTOT+C/LPu0
	1CYaRyv3Yw2aIX0/5uV6bFT1WyBRPbqfp1V0VW1cGCPIrjMsNUgfBMcBxhv2/3jcMpA=
X-Gm-Gg: ASbGnctNoWX5NkigprG79LBvvKn85qXeVOi5gnYTCave2g48iiLYk2t9iLycbfANRmv
	iZNz39bkAcWj9YkCcaqK6bjz2sgfXP2yX84GsRtZfxAejGCUTkX+FPa9/MKjMTwBqasDYHesm/q
	Hg/R4a77wGf0cqqCMDkEE6X9tzDC8HK9o5FQpuc2NoDkvxhDcdfbFWMmM36GCMIK9/eNXfe5Lf2
	h/FgD8wrTau+0y9zqf3mAclLg4bHggi8fXfzZJHaFHAaZMyLT7mXlefImM02N9DJWVgXCFanDCY
	54UtOfyPBIgeI7AytJaTFo5ns0OPe4iLAGuGSs8G6HNod7+9Gfu+WyJDV4fnVLoZfJRwyUCEw7M
	DWjHU/XCqN63kUyyj/04pat0GxxkzjYVrvustpoiA4QT2CQqY5DYmBlQt5eogEyOKwoGaMrUfwt
	yu3kTD0V2x312IlK2xPgiwsF0M/PKE/UC6u69iC3G7kdPLBlvBGLmqbkiBi72TDecZoWYJIEPSY
	vMMBwFIr7dC4Uu2CKXQZsLy45wvPckIRQ==
X-Google-Smtp-Source: AGHT+IE1Y1ssC3vDPwXKD9Vohv1X1EAngxcUz/MZcTAaLZ2Xt65ito/oPm7FTBXTLQh5v9nY6sOF/g==
X-Received: by 2002:a05:690c:4991:b0:784:8994:298c with SMTP id 00721157ae682-78489942dc2mr350965587b3.28.1761322209785;
        Fri, 24 Oct 2025 09:10:09 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785cd6edd87sm14099197b3.51.2025.10.24.09.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 09:10:09 -0700 (PDT)
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
	tj@kernel.org
Subject: [PATCH v8 5/8] kho: don't unpreserve memory during abort
Date: Fri, 24 Oct 2025 12:09:59 -0400
Message-ID: <20251024161002.747372-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
In-Reply-To: <20251024161002.747372-1-pasha.tatashin@soleen.com>
References: <20251024161002.747372-1-pasha.tatashin@soleen.com>
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
index 994ee0b70757..6aa25d304bad 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -1098,31 +1098,12 @@ EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
 
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
2.51.1.821.gb6fe4d2222-goog


