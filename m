Return-Path: <linux-kernel+bounces-814350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE45B552C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FD80B62C01
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651223115A0;
	Fri, 12 Sep 2025 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VRvJd4NC"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CF931A554
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689816; cv=none; b=tBf30CmeHLpVKA2Df20YpE74t0PpshZUWMSqTe8qClOcv/QuP3B1WK30uvO+/tJOtPlyS4XzvvtSEY6ZZr53vvLMYxPo1Hb0HLl1g6vhrL/A8N5lWP3sGXN6mWIU/0D8eaL3djtKRSBmdIoDU6eBWYUgiKEG2JsLwre8DuiVQ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689816; c=relaxed/simple;
	bh=GVNCGH9tQf5YYe+DYh6Siqxk4Q3JqHAijX/d/+i2q6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIkxpC60j6QC5ZQ+3xXfZR1dtCmky3TltAFxi/ixQD8PfOkIRpFbceVecplclC/k8ZZd+xVHYh9TyCtsnwCaJQgekz/vsz4pIKrXvjqIn1zLAsm00Xlt4y3XkI9M/awmu4p9xWMFP0Qv1Ic0/Hu0ZTKlhMm3/iapXLLfP2nJVfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VRvJd4NC; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d603b60cbso18634667b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757689814; x=1758294614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYpcsE3JJVoPh3yiGg+2u2fE9IOmYvM0Rb6jQc+GT84=;
        b=VRvJd4NC+YHhBbcWu/+E+2UN/RPZLIywCS7nFWk4cNrh7/aNzQOyqE0XVbnOT7m6oz
         4p1lgLalhIWQ8Ysj5/pKJKxsK8js/C8JQmUDxU6ZC7jRp09BAI6OisRvZxPiEfBOa8II
         DbOz2+CJFrIZQKYrHYByVmF4eKfvnR8sPz3nkwfV6Fppvh7xObmTh2/oZzrt7LqimY7N
         RLMUmJ6BRL8fiBRxXTAxIsIgN4c91NAY0K8Ah9P9wdHs3j6Uy2n1CAzJvfV+7fIiSUEM
         RwRc/0FluPslIgBW27+O2M1w3JQwtTtm/jBsvU5ELMqIeFFLreoIakdXDnNuObQCATvb
         u7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689814; x=1758294614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYpcsE3JJVoPh3yiGg+2u2fE9IOmYvM0Rb6jQc+GT84=;
        b=XXYFHDGv6tsOEulE8CYTWamZYCjhpcWv8nQ6aiEMq9xiifZrPgC594vU0sxy/FiNiQ
         cMsf4gK58IlpeFHMIJmlDRhmDShJGgE/d4+E/WUgUFOmvuazNjuCtTpjUesozdRLIUv5
         HkwkVL/NKvOm+ZX0HcFY8oFVnu6FkuIBmYms21JjqVvNzzkpjUo4Msk1KZ7evb4WGuLT
         RIucVr8EMVLCXoCse1U1Q/54Pohfrihe6B07OerbBasFchyU4aA0sumS6/LqVxMmjOKj
         F2iWCD6R1EgDojG/RojBYQ9hKwjguIZJoGH0Kx9TUtaY2ob+qFA7L6JnNUjh3HqCLHYY
         6PDA==
X-Forwarded-Encrypted: i=1; AJvYcCXWb1NP0NOSkhLgiUX+5t817mG3OjKrFQm65HIutfmtucWzCjHXGCBuZaG6MHCW0u7T42TtEZNWDBwymAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9g1q9FTQ4M9kQzAFVP1I2K79Bh9pKaHFUn6+pR54XznbVwojm
	m4Vqd1kP/0t5AnHc0WY/mMnWLAlDxB7gbAFobgPjbZ7E/zlzoCgY/wXihs8/LDgsb/U=
X-Gm-Gg: ASbGnctVonz8Q4j6lOpkoJftCVSFQj1YkDKEkl1U+dkDmVoDVseqmWwVLwF6uDlbZ9/
	VM+2AYdVUYy8BtHWRSHOwEV1LqI3S/ivgHSIr0Rs78wJ1p7nR8IyRbkKO+CK9STZ/osKyZXeqIN
	gTE7whKQHV/iHHs1/YiYWQKXuVn3JUABAB3KBS0MCKFSz89jFF+jvrfqSjY31TCitXYZLquXiI8
	eOHf/2dZfjG6QZ03SLPiOq9IaNSx4dUNZnTDUkb32RNYtx2OlGyNO2yDfFPxOqAO3Iol26Y/sP1
	onelZ74OIDVZtuqNWe7bWKtxoz7Vu+k1wbdfdcGPYbOa02h04Ics1yk4RSVrS7fTZoBXGffG5T8
	xI85hNpwNGhkeQnETPclKGxgHYl/xRKcmXhUgKs4NOheZ
X-Google-Smtp-Source: AGHT+IE2B/J5wRLXOu5lnuN+Axv8riYyigPru1eeeYCbQIMixSd8q/6Ui1Mo233PH+t3U62U0f7UQg==
X-Received: by 2002:a05:690c:10c:b0:71f:c7ae:fb73 with SMTP id 00721157ae682-730659befadmr31464037b3.42.1757689810056;
        Fri, 12 Sep 2025 08:10:10 -0700 (PDT)
Received: from eugen-station.. ([145.224.119.89])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-624841586c1sm1302244d50.6.2025.09.12.08.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:10:09 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH v3 04/16] Documentation: kmemdump: Add section for coreimage ELF
Date: Fri, 12 Sep 2025 18:08:43 +0300
Message-ID: <20250912150855.2901211-5-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912150855.2901211-1-eugen.hristev@linaro.org>
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add section describing the utility of coreimage ELF generation for
kmemdump.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 Documentation/dev-tools/kmemdump.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/dev-tools/kmemdump.rst b/Documentation/dev-tools/kmemdump.rst
index 504321de951a..5616843e0407 100644
--- a/Documentation/dev-tools/kmemdump.rst
+++ b/Documentation/dev-tools/kmemdump.rst
@@ -27,6 +27,14 @@ are limited.
 Although the kernel has multiple debugging mechanisms, kmemdump fits
 a particular model which is not covered by the others.
 
+kmemdump can also prepare specific regions of the kernel that can be
+put together to form a minimal core image file. To achieve this, the first
+region is an ELF header with program headers for each region, and another
+region contains specific ELF NOTE section with vmcoreinfo.
+There are also multiple regions registered with basic kernel information
+that will allow debugging tools like 'crash' to load the image.
+To enable this feature, use CONFIG_KMEMDUMP_COREIMAGE.
+
 kmemdump Internals
 ==================
 
-- 
2.43.0


