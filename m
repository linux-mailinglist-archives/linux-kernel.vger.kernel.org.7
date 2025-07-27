Return-Path: <linux-kernel+bounces-747122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F1EB13002
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 17:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45915189333A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 15:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1032E21C18A;
	Sun, 27 Jul 2025 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="C+w1gprh"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB0321B91D
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753628667; cv=none; b=b/zdK4vPOc0Kav95XF6mSNRDyYLXsEovvIcXhDDwRwQlx/4CePksngPyDY2YiUPfxYo7/oZvLwvXesPRFi0vQHqxXfG07glkGqHE7mD3mP1d1rG3TSenHmLGAouF5DN1xVWLEbfKI3cGufq5LFqLP2nFvlDKgNk6KaetOiewFAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753628667; c=relaxed/simple;
	bh=H4aHIJOV1TJAq6ZuusFg9Zqr2Br14ng8uZtfr3ysksQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTU9JQSceKixD2DIuBvkXdprPAXhdFJ2QyC7wEmC6Oiz9BkCQ7oU7hVfGeAoGwyoDFLNPk8K3pCxzBg05TFWnRNa1/VdnLxDlBnD4oUodu3DSz0bMIHJxOKzq6JfBj1PdU5ImpOyaw7k3EjdVGq/S64qDgSjMfDPNvVvdviOKHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=C+w1gprh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2402774851fso1522585ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 08:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1753628665; x=1754233465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkIl0Ng87tj2Fj8IQfRrJkmK5nZP9FIei480gavcNNA=;
        b=C+w1gprhE1LSZUr3AKY+NKfeXsbGRczUf3vBzxMHuzhfEgcoMyLlOpvVz6bg3VUJvR
         T070zJP8V33fQDhZLl/585EIYF8b/UIYhXfMoN0RnOTc0yJt4OA8tZ+9lMizxJPAazPY
         AO1taE7AGjFBN9DwXCqPOP34ZnMYaEUl9raJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753628665; x=1754233465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkIl0Ng87tj2Fj8IQfRrJkmK5nZP9FIei480gavcNNA=;
        b=gHu3nxWuIji5EG+0PUVcfCmVCH7U7Te/PTYY1JrcdndVzRPzAlnKWMTTzE4ZpTaA2D
         x+GtKD5bwGNKdUhzDTBzsSlR3O2j+huIivmgyoJeWTUKtISC6/tQC0fXOiU7RSRUN4nK
         d54F07StKuv03k5uVLOPbvfz5yEyD7F5Iap5e+xV5KofPE74hq6049FoRPFPkynZnycZ
         WwvO5buPee00Hobjm6CTaPlrqAPg0HzKXGtOuTRTSFd4hyGHDnLPoGe4MaJ1hGCflwHP
         I+/Df2BGeOUBPBAIxCdnO02vmmdyK8+NU9NTGLYLzndQ6CdeadZixZdlNyrCN1MmRsk1
         PR6g==
X-Forwarded-Encrypted: i=1; AJvYcCUqfGb8zh3rf5nQAgr+++fObG0c9zBDHPPXboAMPljL9AMt063zOdBtfXYNtuOKZ8YjMgHUHZ2ndpGFDhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJr9+omye4VFWFCvpDUmeU8w5Lulf8SjaX0pUAGuYJaD7EhIZp
	tAcun9Oc2ETrd8hEbHnjjQfgP/dgC/Rv5UTqGY2snm6nyFbZALtkH22/jjnHbx200MA=
X-Gm-Gg: ASbGncuKx577l3ldvkesROcLxsgAU926HLMhX7fckeBc5/N2QlsmWDo9ktZaoDrlG2l
	9zR+OtPAV4fpAg9r0s+B1Njilb4xAXAjVUUuHCcw7EQci2zaRvXG0esoP/DTW68dtTh56CdpHMv
	jHsuoQuBGp1eiqoNo+Q1v4WRQO6hGAjox3MSlIY0ApFVaUw+lpT4wC+Yf+c9rPrl6qCR9zYVfK5
	t3YVq6xT49tiJswsv2W2UPF5DnJhcmQSl2Ixwdg7T8h/XfX5LJAtlCibNjgFdkvo5hryuM3XUW+
	cIHC2mghm2UsOYlePneros2FMddmdfsUzQDcgs+Md0+EiJRPPa2pNV/io5KrvPQXFwL7McG6N7o
	u+FP4kxSq+30rpfYrF/dRJLDS3oz83g+LH1q6dxPv3kssf2FfucRQWmmuX8uvWA==
X-Google-Smtp-Source: AGHT+IH3T9NAHqsD3owCYZXUMl0VQjeiye3RBk2SMd/XJ4g10HNgS5Tm3Wd75o21SRnae8bador9kg==
X-Received: by 2002:a17:903:ace:b0:240:1953:f9a with SMTP id d9443c01a7336-24019531719mr20105335ad.2.1753628665479;
        Sun, 27 Jul 2025 08:04:25 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ffdec96aesm15381965ad.165.2025.07.27.08.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 08:04:25 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Caleb Sander Mateos <csander@purestorage.com>,
	Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v2 1/4] rust: bindings: add io_uring headers in bindings_helper.h
Date: Sun, 27 Jul 2025 15:03:26 +0000
Message-ID: <20250727150329.27433-2-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727150329.27433-1-sidong.yang@furiosa.ai>
References: <20250727150329.27433-1-sidong.yang@furiosa.ai>
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
index 8cbb660e2ec2..a41205e2b8b8 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -72,6 +72,8 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/xarray.h>
+#include <linux/io_uring.h>
+#include <linux/io_uring/cmd.h>
 #include <trace/events/rust_sample.h>
 
 #if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
-- 
2.43.0


