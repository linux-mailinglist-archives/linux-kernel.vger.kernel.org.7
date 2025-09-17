Return-Path: <linux-kernel+bounces-819936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F04B7C4E2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A501D327A71
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 03:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B5C2FB995;
	Wed, 17 Sep 2025 03:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1I9eY7L"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1D42FB987
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758080336; cv=none; b=Uz/QlBDGZOCtuaAJZr5T2PLekiULgS3iu1IsPncxo5OICxLScsY9hhGsYmAWs85+LUHX29avpLeXYk50tvyHcJ7wLXk4LnFahyL8zpCxJlHg6+7glKNIzEr8nVq3wdAOcCpvr4YMo+nD+mJ373Eb8EAngz1vp7RKyC0ftWKru+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758080336; c=relaxed/simple;
	bh=7lmroYbXZ3jYHLQWLFzJWOCaxrUS0F0MWWUAjtp4xGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iHNi7P+PNBbcH4zrbEm84Deb3psmicQEBKLAKGDyNwFuGJGQnVsEFAKlS7edRj0CFH3dkkgfIZpRYa21GwxNeoMkFvqMXb/PDcoapx3OE2dWHqmB8PmpKxSvDJv82RKU4my9hYZoinjC/gzt/e2kVcBP5J2741K0xjZQ8aJWZ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1I9eY7L; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b5488c409d1so4097548a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758080334; x=1758685134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K+PEicOZlOrq/FatAZZFuiytqhYw1ERpH48QYBjUJ8E=;
        b=a1I9eY7L4WwuK83vH9xx08zVvSfHMhzZfA60/xQR2TFgGraN5TuVT+aNhVwFiWtXZw
         xF1SRExlqY7XRgq1pt071o+UC6SI5DbdET2t5agwdxu3J7yyi63MpGTM2KM4dMcm81EZ
         iGO67X5T7C4QhX6IWEQzYaZTQtgPgxnSOkZwI5Ro18UbFy387KROsGmwNr1nsiQL21VM
         B2gAnZ+dHVZVhp9oukxinEUZh1U/vjxslRZg+/WCY8Nq6Fe5nyEnsNrVvpm3tsD6TjCg
         QMPhhZFKbjmuCwafVrRoPPhgTyzZeEXN2hoNIOSZ0TgzojdRYiaW55bNigcG1onCdKbo
         XoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758080334; x=1758685134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+PEicOZlOrq/FatAZZFuiytqhYw1ERpH48QYBjUJ8E=;
        b=Wyq9XlvhEEdiH/kqWsWUynGZBHyVIHjG+Qo/v7+6H80MUQB7opBDi4D4zjCsgeqzp8
         vK/Fiw9xg4Ug1fOzYz0gjKgvgtOmCN+t0eXd6ltGbcQCYMvgwodermFIH/k9e9qBiVJl
         /XT9/F3r5/Kf1Z2tsBeEKGiME7HO+HvxtoshJmx9RRkI9l7P8bZSGYJJE5kViy9x97vf
         51DwRBsMVk+A/YVxqvB1aBNTeVqiEOzXZkLJB8a3mKREIfUjUt4QqgLUy/mS1dbGsYzB
         fP1BY+R6HUuw9NAJNkziBZpc4iNBLhttRhxoS6G34wj9fVdTiTCJ1fDQMuMvAwBguGZ7
         ZALw==
X-Gm-Message-State: AOJu0Yyfrqhq9K/Ldq8sxgWkVvNZ0UDIbsI5qgPcyopGONzADDAwRScC
	M09IgEPZ46etWjtPzGenRaKNdlsv4Oob4Dze2u7GO3AbN0fC+XXvSVEfFBLhQaoAqbsQFTLBUwk
	=
X-Gm-Gg: ASbGnct0I9UijITa+zLJ+V1XgZpXjdiNI8yeMNkLctMwktQLbcidwsIVsiusEwL6yrh
	oxf/3BsOMbyDyfK+J7pMGeIUS2bvcB/0ST9LAjpZ07BoXQbs4dBhAAhmbprY1gu4qMtX41kX4bY
	31SDKRmfhQgvKaRqik9a/hocidvzCgkLQX+6mwGd6733KW2/J5AmIDAnyRKEB4m9o4V+MeIcTdE
	sWuwoO3gBKigEsVGHI+k3TiESudZDu2hRN8y36N5HmxrtCvssqdrRI1C1mLfy/eyYE2zJzHhyDu
	hzsY52Pq68CANZjcHlhPPsVF/SJ0hxVLjE6JYlkOr7gtfCVs1cDMhLYVmFBXOoCEl4bn6UWFGXb
	pakxRd56bU+NMwgNx0AbHYmgkJAGSWzyJOsITqSM9
X-Google-Smtp-Source: AGHT+IHy+1k8k3fFOOqCUZ2yFSZz0O/pwBaT70fSXPSBqjZ3VXyi425K3IsoaOXB3a6ERrNNVccGLQ==
X-Received: by 2002:a17:903:2acd:b0:25d:d848:1cca with SMTP id d9443c01a7336-268136f9cccmr6032175ad.35.1758080334177;
        Tue, 16 Sep 2025 20:38:54 -0700 (PDT)
Received: from LAPTOP-1SG6V2T1 ([149.22.88.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26804b83afasm8002275ad.68.2025.09.16.20.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 20:38:53 -0700 (PDT)
From: djfkvcing117@gmail.com
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Onur <work@onurozkan.dev>,
	gregkh <gregkh@linuxfoundation.org>,
	lossin@kernel.org,
	gary@garyguo.net,
	Tong Li <djfkvcing117@gmail.com>
Subject: [PATCH] rust/fs: use intra-doc link for `EBADF` in `BadFdError` docs
Date: Wed, 17 Sep 2025 11:38:33 +0800
Message-ID: <20250917033838.8171-1-djfkvcing117@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tong Li <djfkvcing117@gmail.com>

In rust/kernel/fs/file.rs, replace plain-text `EBADF` in the doc comment for BadFdError with an intra-doc link [`EBADF`].

This improves the generated documentation (so the `EBADF` constant is linked), and helps tools such as rust-analyzer to resolve such references from the docs.

Suggested-by: Onur Özkan <work@onurozkan.dev>
Link: https://github.com/Rust-for-Linux/linux/issues/1186
Signed-off-by: Tong Li <djfkvcing117@gmail.com>
---
 rust/kernel/fs/file.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 67a3654f0fd3..f3153f4c8560 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -448,9 +448,9 @@ fn drop(&mut self) {
     }
 }
 
-/// Represents the `EBADF` error code.
+/// Represents the [`EBADF`] error code.
 ///
-/// Used for methods that can only fail with `EBADF`.
+/// Used for methods that can only fail with [`EBADF`].
 #[derive(Copy, Clone, Eq, PartialEq)]
 pub struct BadFdError;
 
-- 
2.34.1


