Return-Path: <linux-kernel+bounces-741970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F805B0EB81
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED601C81F69
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D736272815;
	Wed, 23 Jul 2025 07:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0gl4xfQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEC327146E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753254741; cv=none; b=JL2ezgF+y7jq5/ztDC2qm24mPI+ICX4TEVgaGWvX21qRMN3NiP6CXx5mX/p8E9F/ewFTaCciZ9Y+qpxTB1vcGPKkBhh5X9lQHcMzDZO/67cCVId/JXC7L4lSH2C5QX5h/HqJiheV6k+QzZP/b94AZNj8drIy9pr+2ct2KCTQ2ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753254741; c=relaxed/simple;
	bh=FwnLzYB260LPBBLyO6QPG8c/64H6Crnq1RaI4UHgsKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZY9oMXy/dyRpkoeHdzVAFXzCLKKnLYpMxeBbFyeFQbvQ3gQh0AFX1MiCrJGUJfHEQU/nHWTsBuxyVT6HIJlxXP0J+9SwyB79Y2L4gqcfMY2D/WEk9EKe23UOkW5gzYFsqxoEbTc/z0KTVM2RmFyOGcKj1qK+xSBfI0thfUiBCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T0gl4xfQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753254737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=svJ9vKg5v2xhgonVVA8jklvWB8f0wsV6uQlirW6mTLA=;
	b=T0gl4xfQNe+weoXhUlAnf/l1GdVp5YbWSCKOR0Pt4rQVem0R8LRjXHXqzMH5nyuOEyCQsx
	cJS4F/U7G5ws2Cd8We9YwMkMLnOHkN1TO9JQKEqMT63Q5UMJen5vf/hAFwwX9x/7b/y1vj
	PaZdg9A8HTxfxaUHuvAnoTyhWlADBis=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-sgaakkDeM82b-jUnpyICkQ-1; Wed, 23 Jul 2025 03:12:16 -0400
X-MC-Unique: sgaakkDeM82b-jUnpyICkQ-1
X-Mimecast-MFC-AGG-ID: sgaakkDeM82b-jUnpyICkQ_1753254735
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6090274dd37so5952413a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 00:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753254735; x=1753859535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=svJ9vKg5v2xhgonVVA8jklvWB8f0wsV6uQlirW6mTLA=;
        b=rjJTLj0y/DJ9UKfUNpmfi258npehWKkDY6e9mw0O0SysJdkuy8DMxClCVBw+/JlOql
         Hb9izKPgYKVkajBZzg13oq5BsqmoC0B+hqGRxxj7OMxW0ouUlyzyW6C/6t2TBR7YSO4Z
         tlL115MdTnAY8Q/h2ZdBN1xhb5LtagVTRa+rQXeXOZMnxHl/wdTSUNmPIQ4GeTo8psdp
         7FcCUF31Y0eTB5Sf2U9VAZdckThhNIQwyasOAozECue6XXHueAOvpRy5IVsU6Zcj2r48
         WO21JO8JT+LQfi0BKqMpYs5jHIIZn6K3C6EQvT2QvNtTWeXr9ftHEIiUUx8eb6mo7TXy
         3zMg==
X-Forwarded-Encrypted: i=1; AJvYcCXxJx3lD5PvamDTHr+FgyeyFu7sAHMQUpQPxBW3ul2qmhoUtpfkh+XZk8zeLyH7tiqdWZQf7cKzDf4qkik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW31MpClsFYCkfgcuiCZS3CLdwuIy6Xnepc2SZc76xmB6HUzIs
	zAofY5VdhVjitfu7vyx3RuO37JIETZsf7g4+wIZnC5ycg4S23UhZUfFDwNb8YtV7uMbq9ZFGvr3
	RIiZOBgL+T0pTZVMMnu5URM4+0bQ9DEICglFcOofLBBhTQM8V3ihxTxOnIM8weWR1CHdHV3IhbQ
	==
X-Gm-Gg: ASbGnctO69NkApYY9IkZ2F6TgEb3SjdpCOLVkZz/770vC7G/Qj/vlIAT6IIzqUlkaR9
	W6YkEvXvuJcRPnnXybJisiXt0A86JalXKgPM8FrIfvSqDBJlcXlmv0A+i9TmP4eddGgFS0pIkoZ
	RiPl6VgcWMa2H8XPObd4rrhSjHuVVejtbGt/RjAexTtPXlWwKxW8+ywGd25mgzliOC4HmS1ia+Y
	Vhh1fMjwP/IgkTWK2I5N5AyFeMAcG053+Vv1ZC4IUrQjogenlpvqt7DfqlRVljES0RSnzjIJ2mA
	qn0RZQZ0pAB4wdW9CGbo7HBQTtEqD8ikeb9Sd8cFsyB7HSx1CrrKbXWm3od/Mo4shCMXeKZ7cM/
	u2KYo7EcymA==
X-Received: by 2002:a17:907:9816:b0:ade:316e:bfc with SMTP id a640c23a62f3a-af2f6c0ab4amr179168166b.21.1753254734905;
        Wed, 23 Jul 2025 00:12:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGri0DF7TftUzJZLGAOyHGORDLnO7b2pDFWy2dCBLl64IhL44y4nfzSRlFJb2/VuGJ7H/2qMA==
X-Received: by 2002:a17:907:9816:b0:ade:316e:bfc with SMTP id a640c23a62f3a-af2f6c0ab4amr179165166b.21.1753254734451;
        Wed, 23 Jul 2025 00:12:14 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e01:ef00:b52:2ad9:f357:f709])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca7d33csm997361466b.112.2025.07.23.00.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 00:12:13 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] x86: Drop unused and needless config X86_64_SMP
Date: Wed, 23 Jul 2025 09:12:11 +0200
Message-ID: <20250723071211.622802-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

As part of the commit 38a4968b3190 ("x86/percpu/64: Remove INIT_PER_CPU
macros"), the only use of the config option X86_64_SMP in the kernel tree
is removed. As this config option X86_64_SMP is just equivalent to
X86_64 && SMP, the source code in the tree just uses that expression in the
few places where needed. Note further that this option cannot be explicitly
enabled or disabled when configuring the kernel build configuration.

Drop this needless and unused config option. No functional change.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 arch/x86/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 66115134b596..afa4077e423f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -411,10 +411,6 @@ config HAVE_INTEL_TXT
 	def_bool y
 	depends on INTEL_IOMMU && ACPI
 
-config X86_64_SMP
-	def_bool y
-	depends on X86_64 && SMP
-
 config ARCH_SUPPORTS_UPROBES
 	def_bool y
 
-- 
2.50.1


