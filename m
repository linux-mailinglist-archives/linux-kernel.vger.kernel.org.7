Return-Path: <linux-kernel+bounces-781921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDF0B318BA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF4F3A352F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B39D302CB0;
	Fri, 22 Aug 2025 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="QAuNGGSP"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D83030149D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867399; cv=none; b=FwS9/7Cb8hqzHKT30XljgODunrCJK2b4VI52JypUiEVH6iJWxo8tqLBugyvrvuV5RPDR+cFt/I6Tiy7QpNkfp6+ZxS3YAqZMs6eOmSfDswj+gLS/lmn9kuzAXolks4IE2HMk1KR84abCbQbO3niumBUkwEqo1ivvdP8Lk5IWZIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867399; c=relaxed/simple;
	bh=2p8LG69KmCVA8ZLTUV6rgT5Wy5/pv1AhMG9wpLxMJIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paMuQboToiCTehdtkx32ow8/5QVjPQys91X4pMyY88ZkjNNKC0jD14oqckT+B8cg23aOUlV/CXfczQn62NmRkBO30flhFfKI+/eQkb8whLp+UhGHpRou0owZhl0rNjpefHLkD9wXs1XTQ8e5gbXezYEwPNV48QRz0Stx6X8q7Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=QAuNGGSP; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e6cbb9956so1672269b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1755867398; x=1756472198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8fwNJeHNHWIWunBevE6xxfqz+V4AStymQDWUp+Nzso=;
        b=QAuNGGSP0ojjaY4qas+ib2P3xKaP0KlZxo0Mkc7/aOaHvUbtVAKBQTEKEYP6WUZf2U
         5zE61e8nwoVb6zR9o2wvyoaWdvf0vnzk6Wl+EXSsbV7+y207FcKbqAXhMcx2jXURHEMy
         3dDiFoAFGabwz9w8srf+x7zObFXNYgcQwfIWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755867398; x=1756472198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8fwNJeHNHWIWunBevE6xxfqz+V4AStymQDWUp+Nzso=;
        b=b/rl06RiXna8vJpkCaMB1DEyYmhBQ1FjNzXzECb9ixmTKZeSr2e1ubxgAO7SqGUqxP
         TCUSfS/XpgiEEtXB0KlTVtjZyWGtHjG1aVpuWqy9Xk0ohiCDTabry6tHHwVoNrx7SKbO
         9fJj/0ueQuGvZ1E3e3J3hB3AhG3RnqdwYj4R86XRbiRVQ+8AUfbI2ltY0QVLJSx1Wnuh
         YZY5YOvmyaWx1L9jc+e7sgrhYQ6m69iRXV4RJ5Vk89A41KT7BDraC4ZsfPOm5CmpcaG2
         f2/03eh4BUF/qUFgbtlABB49KyetS9bOC2eXGlCzfqW4St6TL6ee2OdeYC0tzhQxr/cA
         sIdg==
X-Forwarded-Encrypted: i=1; AJvYcCWKrcnfES1IVrOyCveYIcygqh4EDARN/YcNKetckhmW/dY7Nrd2Gg8MsEAvzEJd+pbByIP8eNOJYE0gFuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa5lb/twqNcsI+OIlDYJdgJ7goxwD622cVjKwRNlQDyyc5Q6M4
	I0Ih5EunLibPy+79fAKR/I5OOwQotDrgr0W69ya3qI7YBGMmTCrlfp89FpzYrU6SilA=
X-Gm-Gg: ASbGncsLKW/CkRjXuvbJRpolkoJJA2gY3JPQ+SWF6sgGuO8ITR+2GSaKKKVap20ARdA
	dbMLcE930A0IGYN8Vsrgv7SzYfVf12twzOdD16UWQyhbl0LRHQ8n+vxNu3Qd2hgalcfUzeNwA2+
	24cwwonUQOyKSdysXbUCPICp790JkX489YEFCVzpOOEUdD6c3yuFf39egDnUIGeFarGSkkMkMLJ
	aFn3X3Dzy1UyK7tj6W1ViqolY53+yfyP0iy47Jkj4H3DKuoA2CkZJ7L2oWYh/We5E80arAP34DV
	zw1GoTtgCwS0YZJuoVeJjbB8v2bLDJzmMP+qIuQsxHJl3E8ca1I5ebEOTCHmCumGI6Y7l8xXHx7
	tELx9YIvP9+WjzjIXH+KW30KVE7A8659wb64K5dwh2S6x/sVVaUxJ7YOiqxKEhNDCs/N967FU
X-Google-Smtp-Source: AGHT+IHDhJuu9+cO4uxsw6AoUa51QjPpNUdCs5GI2HWZsOmJ82BW0DSG2NIaLQoRPu3I8EhQjTg/gQ==
X-Received: by 2002:a05:6a20:430d:b0:23d:9cca:e710 with SMTP id adf61e73a8af0-24340de334bmr4095404637.44.1755867397819;
        Fri, 22 Aug 2025 05:56:37 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4764003537sm7194544a12.25.2025.08.22.05.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:56:37 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Jens Axboe <axboe@kernel.dk>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v3 1/5] rust: bindings: add io_uring headers in bindings_helper.h
Date: Fri, 22 Aug 2025 12:55:51 +0000
Message-ID: <20250822125555.8620-2-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822125555.8620-1-sidong.yang@furiosa.ai>
References: <20250822125555.8620-1-sidong.yang@furiosa.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds two headers io_uring.h io_uring/cmd.h in bindings_helper
for implementing rust io_uring abstraction.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 rust/bindings/bindings_helper.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 84d60635e8a9..96beaea73755 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -75,6 +75,8 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/xarray.h>
+#include <linux/io_uring.h>
+#include <linux/io_uring/cmd.h>
 #include <trace/events/rust_sample.h>
 
 #if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
-- 
2.43.0


