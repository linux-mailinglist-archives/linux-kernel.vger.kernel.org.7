Return-Path: <linux-kernel+bounces-763945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AE5B21BE1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382D4628201
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064CA2DCF44;
	Tue, 12 Aug 2025 03:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AB5ZRNRq"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ACA1DF27F;
	Tue, 12 Aug 2025 03:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754970976; cv=none; b=CA0Qhfv1N9DtZoOdrv4FJXEW6tnJ7wqH4A1TKK0lx0mcBeMWAzjmmLO5vMT9Hc9PEUdDxZvTete/quFE0HlBTNOE7wR44a7uAMw+iQ53PZBuEPMhlf+qeAvxaWl7VarRIi6d+ATqNb4adhN9QSYmdhqWnSh7Ke1ve5ijxqc9Dgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754970976; c=relaxed/simple;
	bh=Hfj2sgN9ynnRL3Tt740pcoUcq8NlQ3MQTSBQYKjQ4R0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j/RuPMUyX2LhLj8uS/+1mDcvZt0aquEKUvQsVmondSAVstQVIIB9CxqkprJdApeTpqO5sNbU6WaFkgHUHCNAnx93oNvv8eD4LPkYqhDigR4CE+YXGV2bgPLbxCyZJ4n9w7sOggihJsOnnCagqD1EDwDGcEzhrwj10rcghqQqd/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AB5ZRNRq; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31f255eb191so5198418a91.0;
        Mon, 11 Aug 2025 20:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754970974; x=1755575774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P1AHZUp9pdweMFljzh9CflHd6v78erNi8tFB6myumGo=;
        b=AB5ZRNRqSc49PjoXzm/B1tuca5xPqw/fLmMWoJFASW6BLd97ToJCqPX1JxlbuBWMJE
         WhqeyqRJL0iJUGm1OostFgTv+LyaRqbQucg4KZD+VtLFZzyvq4gIUY4ws7CgJ7dnEFeF
         2AvZGoMd06u0PcyXoyj5Apwkx9+TAD6UyHWWZ7ETAMCDmMntyWRQcKn5TZgxmEnetp+5
         IUfn6f+ZZ+M0lDC1LZ6fnDnpEMq6idyQksfEpEACKVQIP7opdf7NDtnK756Pfi4mOS9v
         uW1QQlqRiqYCsqKORxE/PYtrV/7MEc/i716dXCV2RzzXhqqbIJ7f3keGxs+flZWFQNTt
         YqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754970974; x=1755575774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1AHZUp9pdweMFljzh9CflHd6v78erNi8tFB6myumGo=;
        b=xQBY8gjWZ5Mb/Ybz0P+rZ9Q1FuvO2tOc1Rh59mFq3LBkjyHhgrWqrW6UotJqmwJR+N
         k63TGVVnIo4Q/en/E/eNejgSYWIZioMMPMxlpj1e5C45FmdCW+zDlUxpZTOfpn15Luqh
         y9me1Z3wwhh+Zfr1UXv5AweqlhvqrgkIhH3jcOxbNAtQDogP+DIpPxxr4ZQ3J1HefoCn
         2wYStxLgyT7ozWsYQdRFIB3OQ3eQuTTlk75alPolFLXyYxXJvYwsHBsUMY5QedzChIqZ
         wMs0fack/2hjPRRbCoRmWfSNZ4y0BZwLo3u+zqvHs1qY74dh7VBcEwpd9U9/fwYrgoQY
         XBRA==
X-Forwarded-Encrypted: i=1; AJvYcCXhrKQOUtHAKEpgv1L1mzTjVpT9xoqnBSW3XYbCgs+Cj3EoU3H8+3aKfeWqThmJ5dSOM5KYqEIWyqj2Ai8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNahNtQFH+WJgiQYjQcQ5fOkC1GxgTyf6EGNI3gYbrmAlPDt+J
	wkLdmbuWuctuUCc+2ovWJwBVabAuNycv/UnAwG4IZlWCC4oaY0PIAGuf
X-Gm-Gg: ASbGncvpnEczEbRHKREcpsdrJ3xnED92o5KoAdPVphSjSb9WghH2+OnSSL+RKarTcou
	4VZvvMMf9q6p5+OcOYiz+DBbqpnvvBMWSaDqIYJAn72lrBr2pInMKH1/M7UyRn+Lg5tVL1+n8p3
	yMtwSrt7nhWKJ6SLTLvQsOKbNawhBfjQ337JawZme2WXbw2BvYPkKQ4C6BwdE1ZQ06ytnY0xnEx
	WCKs+EUze0utmzn+Nt85zB/f7ehD9U+zzjJ8Dppg8SQtxp9jzp9MljDPUA7KviLj4QLPjRgh1Aj
	L/4biGjKrP+C4gMPsqLzA+2j3AI8S6+EAtdK1RLQFg05WGcPsH2+pmD65eTYTacdBwU7ryy13wI
	ttFEEx/E2kwX3EwrNyknzHwg7
X-Google-Smtp-Source: AGHT+IHeIPfjvL8TtbndHMUmZ0GjPyf+B79LiQjDv9TSogMydW2zMvFxQz5A02QbYdkeXMtcLUbFbQ==
X-Received: by 2002:a17:90b:53ce:b0:2f8:34df:5652 with SMTP id 98e67ed59e1d1-321c0a869eamr2725393a91.21.1754970974410;
        Mon, 11 Aug 2025 20:56:14 -0700 (PDT)
Received: from pop-os.. ([2401:4900:91d5:9edd:11bb:d389:5e47:9179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321611dd694sm16041897a91.1.2025.08.11.20.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 20:56:13 -0700 (PDT)
From: herculoxz <abhinav.ogl@gmail.com>
To: gregkh@linuxfoundation.org,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abhinav Ananthu <abhinav.ogl@gmail.com>
Subject: [PATCH] rust: auxiliary: Use `c_` types from prelude instead of
Date: Tue, 12 Aug 2025 09:24:21 +0530
Message-Id: <20250812035420.8123-1-abhinav.ogl@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abhinav Ananthu <abhinav.ogl@gmail.com>

 Update auxiliary FFI callback signatures to reference the `c_` types
 provided by the kernel prelude, rather than accessing them via
 `kernel::ffi::`.

Signed-off-by: Abhinav Ananthu <abhinav.ogl@gmail.com>
---
 rust/kernel/auxiliary.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index d2cfe1eeefb6..030e31333689 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -56,7 +56,7 @@ impl<T: Driver + 'static> Adapter<T> {
     extern "C" fn probe_callback(
         adev: *mut bindings::auxiliary_device,
         id: *const bindings::auxiliary_device_id,
-    ) -> kernel::ffi::c_int {
+    ) -> c_int {
         // SAFETY: The auxiliary bus only ever calls the probe callback with a valid pointer to a
         // `struct auxiliary_device`.
         //
-- 
2.34.1


