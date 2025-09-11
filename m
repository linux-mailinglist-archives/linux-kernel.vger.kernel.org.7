Return-Path: <linux-kernel+bounces-812193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C59FB53452
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00FA61C23D12
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A02132A837;
	Thu, 11 Sep 2025 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECG4N7vw"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAC93314CC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598589; cv=none; b=rHcn1Hc0hNu+Yuy5caqXAJPTxEdZtRnlOZchJY6qIEZ+QKojC4n12n+NL6Aa2PlXLs1Nz8FIs7Jc6s2InYakOOD/rEtfVU8w1U1iz1N8fN60lMZo4M2Gxm0nR0ctLTInjXzjiGipypjWG+IMebRIy4+V0iRITh3+gBvztpUs7tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598589; c=relaxed/simple;
	bh=coVlvw6nAsqruPp9BB3WURmrEJc6EQqZ8wGP1yqmBOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GVisTqnsInhVPd+Chl4g4Gdh7Oe4Tt/T6SyOAwPx43c9/D//J2NiFEIoKOSJDFK04lbTAGb7fy+gHhz1+XcEa0YFsGNlBeA3nvRBU6lP2fiEERIfeDCyQ/B32yBcpXk8FqofObcwz2gHYxj45g1XkOS2M5O7mOKfUMnSCF9rEZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECG4N7vw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45cb5492350so5884725e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757598585; x=1758203385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QS0X9ggn6fxbGpDUqeyaduaSpB6sZdnskQczeYDZPM=;
        b=ECG4N7vwVdv1rIhMetFwojqGdO0xKMZZYQAmjCAwQCOnF5zIYlXQKPfD4H19ZNOfWL
         ogxeaiXK4e89DTx+fG0LISmonTg0HOXaAe6nmpnPNStwNzpZcVsxca/cFiK1T5FcZ417
         SW0m7cAdM1eDu8BBl/tK01Vy7Y8zEWBwXNDrfIXtoZhCm1KJscCcfumK7fttNfSGQDXi
         QgdHh2U6HTeE8Lg0TcPxQZW6Q79gu8Ypmx2JpUh3FK2/IwptgESwMu7efuqZVMoOvZvF
         oLwvySCgQA6pLPsuAOBsZufdtPWq/6mKm3gMi/unzEGGjGEU3aTfQuLx6gaBBuX/lMTY
         3cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598585; x=1758203385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QS0X9ggn6fxbGpDUqeyaduaSpB6sZdnskQczeYDZPM=;
        b=faj3ZGziIsWo2b9IxvFjkvRTU/wVbHXVrodTlcW5zvcPbDSm6F9k0rElxu7ZoiRHMz
         pFaEY5tzcp9smHrtOhXO8QDnSwkODsNiqbg8u5M/eUXfrQJ4NhlV4exK54oCgz8PlItY
         2+u4b5ccSIvzZIpF+zGb7psHGjZ+/CyOpQlQrDXnpoqnWfIR4FF3YOebsa36TgDxa2vi
         UBAum5fK7s/I6StIFJkWloufmh28w0R92MGklgsSW12670ylu6tV6abcUQ1ZoSOGP1vJ
         +WWkXA00VyQQAwKAbPR0tjCZYs5TDcdtsJUhX0odsZmoVnCdI9CVtOX+2bQLn2yJnZoy
         lgnw==
X-Forwarded-Encrypted: i=1; AJvYcCUSZAqNCyhosYRnLDYa0ZNZYs8mJRd4CZVEnj/hHVOFv+Y6Kfhl7bms2opjomkdFzsQ+tkpM2yhHeVzhzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6QwWLI+7Whr8QMoAtahuktgxmmNs7ClKKGpycMAmur6q7dR0M
	236KUWrPvQhsIopWft7Wzn3C638ov+HKV68P9rl3FsWA+0MI1QnY96pw
X-Gm-Gg: ASbGncu0krSQfQ8n+amTJu9hdWUpYQwknwVFegUDjmwqiYa6G8i3zVfSETu5JRDmNk8
	70PV3uzjqLtIkXDtx5U+bifFSpIkNNozJNpd7WPe7PP+Pq1g+TJ6mHf47YyTPdhEymEYcuhkTb6
	/KJoc1qiRe6pGGLItfIjViibCNSQUnijITd2/e6uzEJGswz+Ym8QCuEILBAutGeE9ofV6Y1OdkZ
	o8TF8CKQVuQs/18R3YC6GbvYbi/VKvqYxEVIPTffTtDmwARZweYrZnVw5KSVMoZr4RCkrROhL4N
	9wxAPq3rnenXsvQB/QkQE5HeWuJul0JdkqI1/Uao0pwXGzf2IbFtIBdlF0VJsLF/+2uauoJoB9C
	mqby7zZd4pcZGJdAompCmt7d84lOfcF8YJGXDxg21zIJHPh2fRY6gWdCVr1A+qWHs6OwLsVVz
X-Google-Smtp-Source: AGHT+IFNNNmoDMaiLwtDUu3F/l93u30ohFmaZcpwi8LsB2GCj8jLScee70K+1o9ZTJ5T9w+mmGeR0g==
X-Received: by 2002:a05:600c:4709:b0:45b:8477:de1a with SMTP id 5b1f17b1804b1-45dddea648emr170375255e9.7.1757598584916;
        Thu, 11 Sep 2025 06:49:44 -0700 (PDT)
Received: from f4d4888f22f2.ant.amazon.com.com ([15.248.2.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760778915sm2608361f8f.12.2025.09.11.06.49.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Sep 2025 06:49:44 -0700 (PDT)
From: Jack Thomson <jackabt.amazon@gmail.com>
To: maz@kernel.org,
	oliver.upton@linux.dev,
	pbonzini@redhat.com
Cc: joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	isaku.yamahata@intel.com,
	roypat@amazon.co.uk,
	kalyazin@amazon.co.uk,
	jackabt@amazon.com
Subject: [PATCH 2/6] KVM: arm64: Add KVM_PGTABLE_WALK_PRE_FAULT walk flag
Date: Thu, 11 Sep 2025 14:46:44 +0100
Message-Id: <20250911134648.58945-3-jackabt.amazon@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250911134648.58945-1-jackabt.amazon@gmail.com>
References: <20250911134648.58945-1-jackabt.amazon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Thomson <jackabt@amazon.com>

Don't return -EAGAIN from stage2_map_walker_try_leaf during
KVM_PRE_FAULT_MEMORY.

During pre-faults, user_abort() is retried upon returning -EAGAIN,
meaning the ioctl would get stuck in an infinite loop if userspace
tries to pre-fault already existing mappings

Signed-off-by: Jack Thomson <jackabt@amazon.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 3 +++
 arch/arm64/kvm/hyp/pgtable.c         | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 2888b5d03757..0789671d1c4f 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -296,6 +296,8 @@ typedef bool (*kvm_pgtable_force_pte_cb_t)(u64 addr, u64 end,
  * @KVM_PGTABLE_WALK_SKIP_CMO:		Visit and update table entries
  *					without Cache maintenance
  *					operations required.
+ * @KVM_PGTABLE_WALK_PRE_FAULT		Indicates the page-table walk was
+ *					invoked from a pre-fault request.
  */
 enum kvm_pgtable_walk_flags {
 	KVM_PGTABLE_WALK_LEAF			= BIT(0),
@@ -305,6 +307,7 @@ enum kvm_pgtable_walk_flags {
 	KVM_PGTABLE_WALK_HANDLE_FAULT		= BIT(4),
 	KVM_PGTABLE_WALK_SKIP_BBM_TLBI		= BIT(5),
 	KVM_PGTABLE_WALK_SKIP_CMO		= BIT(6),
+	KVM_PGTABLE_WALK_PRE_FAULT		= BIT(7),
 };
 
 struct kvm_pgtable_visit_ctx {
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index c351b4abd5db..140dccec2c5b 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -914,9 +914,13 @@ static int stage2_map_walker_try_leaf(const struct kvm_pgtable_visit_ctx *ctx,
 	 * same mapping or only change the access permissions. Instead,
 	 * the vCPU will exit one more time from guest if still needed
 	 * and then go through the path of relaxing permissions.
+	 *
+	 * When walking in the context of a pre-fault request, if the
+	 * mapping already exists we can return 0, as there's nothing
+	 * to do.
 	 */
 	if (!stage2_pte_needs_update(ctx->old, new))
-		return -EAGAIN;
+		return (ctx->flags & KVM_PGTABLE_WALK_PRE_FAULT) ? 0 : -EAGAIN;
 
 	/* If we're only changing software bits, then store them and go! */
 	if (!kvm_pgtable_walk_shared(ctx) &&
-- 
2.43.0


