Return-Path: <linux-kernel+bounces-764915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4611CB228BD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6B01B64DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C9A2857EF;
	Tue, 12 Aug 2025 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILUcj/a9"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0047C284B39;
	Tue, 12 Aug 2025 13:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005362; cv=none; b=aPazHCC/XQCbslFCbKf29Esax0Sikh1KoVdoVzYESBbS3ZPb0uyFy67lR3hvuc2sQhem1FdPQsvJpXaU/kzTcJNx6Rwql8bq1sqES8uF9SPEvVlaOcD/oSfacNtCr9oHVNPivKbt++MRuM0TYu3RUQwBXAJA4hrVMfzs0axutgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005362; c=relaxed/simple;
	bh=IEeHt29EbAGwAmdrm+Bkmgts0MfalXN7j7gGaBeDylM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kfbBIM1SfP29PjoYrp4xOtF61fO/6tvVxYtQbRwOA+HdKgEtmBUaC/4hSiCKVeiiyFvjXH52YcAFyjNU3HdUmTfBsbYYQHb0fMQftbb7/QJOp2JiOXn6RpuW9fOl1t+Ijb2+2ZGFDWIvDXllqon3Fix9qFyXEesEEJQOTo8GmwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILUcj/a9; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b7848df30cso3660363f8f.0;
        Tue, 12 Aug 2025 06:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755005358; x=1755610158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1sFms8DfYlZzU9dKa8CQCWgZb50bkFnu2RQfAfYZeVs=;
        b=ILUcj/a9e0WlLDYUz/WthXD33FglbqlRJLYQ1k3dZQyfaPMlpvuAk6qLYEoqbcABHa
         4Ba5O72EKGDpNgEHCZolMbLZi3eekXNBW4R87+J6jnTCst9JwNbM3SyEk8kcaBdm76Ct
         QL4uSNKyboWezCPUE0kK8xIQ1EjEtp62idug0a7B2N9kHAqmNc+UFx06qL1plm2Mtjc5
         Ue3Q4/UCmZyW4mh8QTZ51GNbVNpww/w1DsuNbTfxlrqIeJKsDooQy9UwKbnbkzZCiaSn
         GHH4anIXxYzrPodqLthhutcQK0JUoMkM/9zI+eDmgMtzRCDmQr8LN+JMjsz9hp9CMBOD
         DKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755005358; x=1755610158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1sFms8DfYlZzU9dKa8CQCWgZb50bkFnu2RQfAfYZeVs=;
        b=vCcLx64lrjUJcDGgvDYpaO0xGUcqJLwITpKl0kj7GQYnCWRDrwBNen6zZVFhbbF/Hf
         bx9oKpUMeZIrx0ymeaJkgXvWgQd+7V/brDoWuEhna0xXL/V1Vszf/8b689NAY5U4Ewra
         xezaWTJFOPNHk5INQ+sSb+80yycOEotX/GSkFMkAOZjjZJv5emDAgVVJevCq62oefE9V
         L4JXV+8S7M7f7fZhn6tq61DOCsHzbzWYteeQFSA+s6tO2SlCWP88CbZoTpJyxEkNKo0u
         xQcsCjq8eBj8aMSW1cYfI2JUEAsVUM8Yh7cmYJ3ZunH40DbFSAFQmQ7fgDvYjDlJijzS
         rU1w==
X-Forwarded-Encrypted: i=1; AJvYcCUzOb35iOvDEoNX9K/8nY9lAr28jKMsZqPWktV6BiTiBNcsf0tWkKmc0sEtJLyLSG3lnwAUCDSHXWZ1HvE=@vger.kernel.org, AJvYcCXZh6vxqeTgxlyKN08DKqB/soKZ2T9NFTYf5Ko/GF6bABm5I1WNZ+y+rolCw7z2CnF6cEez7TtHc2OkehpU9lE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3JeoAxaS3PZsgVFy1+hOupaKg2OJ4Ave4mqnOJfWC5XynRTug
	JhwRqysgRB81WkFRVhyOf4qnSQLkY6OlyCL5JGFm9iqW/2GfLtBxAg3y
X-Gm-Gg: ASbGncvHT9zV9pIzIKddF03mdZQWC+XkWjX0sEEIDc9meiR3Ym8XrDtxCjwlc86XzAN
	NbVTnkeE6cIv0eEAHUQk5oaYzQqZdvnVOesqGcnh3/GE20uM53dk2XdlUdXK2AvjqR5tb7zCbpC
	IOipX2eAnjdpofSy8dQGICGrGtqj+Jr3ZiWFzE4tLR7Hpxfu/iUgRZtf6XacLe1leZuesGfG/Lq
	FQMADeilCEwSVvweWgef7E9Gp8W9NOPe8mgDcJeGx23TyaCuyeVJBVrJNG/rMIJjMixekrAfi7p
	hLCaXL6WEvt9oQfhowbZH0DwVTYbO0veLpWc50i2Qsxm/KQtgjkezkOm5JKIULadZeZ9Bl8+OB7
	o/00V4vkJiX4xxjcJIUCvBPUDpoIsUCzqzqq1ueM1m2Ic
X-Google-Smtp-Source: AGHT+IGYEv1UKXbeigwHa2TP8gKJ65pVI0sFh0NThS1xGWQn0fvli/9NFZm7AX5K1g9q3yR/X2RpyQ==
X-Received: by 2002:a05:6000:250d:b0:3a5:8934:4959 with SMTP id ffacd0b85a97d-3b9111f4b67mr2712178f8f.27.1755005358067;
        Tue, 12 Aug 2025 06:29:18 -0700 (PDT)
Received: from blepers-Latitude-5420.. ([213.55.220.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458b8aab8c0sm433003905e9.19.2025.08.12.06.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:29:17 -0700 (PDT)
From: Baptiste Lepers <baptiste.lepers@gmail.com>
To: 
Cc: Baptiste Lepers <baptiste.lepers@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: mm: Mark VmaNew as transparent
Date: Tue, 12 Aug 2025 15:26:56 +0200
Message-ID: <20250812132712.61007-1-baptiste.lepers@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unsafe code in VmaNew's methods assumes that the type has the same
layout as the inner `bindings::vm_area_struct`. This is not guaranteed by
the default struct representation in Rust, but requires specifying the
`transparent` representation.

Fixes: dcb81aeab406e ("mm: rust: add VmaNew for f_ops->mmap()")
Signed-off-by: Baptiste Lepers <baptiste.lepers@gmail.com>
---
 rust/kernel/mm/virt.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
index 6086ca981b06..a1bfa4e19293 100644
--- a/rust/kernel/mm/virt.rs
+++ b/rust/kernel/mm/virt.rs
@@ -209,6 +209,7 @@ pub fn vm_insert_page(&self, address: usize, page: &Page) -> Result {
 ///
 /// For the duration of 'a, the referenced vma must be undergoing initialization in an
 /// `f_ops->mmap()` hook.
+#[repr(transparent)]
 pub struct VmaNew {
     vma: VmaRef,
 }
-- 
2.43.0


