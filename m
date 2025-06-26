Return-Path: <linux-kernel+bounces-705289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66118AEA7C0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 22:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A521172EA1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 20:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2E12F3621;
	Thu, 26 Jun 2025 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x4CA2EDb"
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB282F2346
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 20:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968357; cv=none; b=S0jcgnk+MX9/E5kj4HAh3wn2L9LIc2bzDT/pSBAuNH1/dqGAsmugLurWwFvU8L47oQp2KvQH7ZBTERF4kwHxpVzZIZDJW4iKmoz2Ezl+Tp+65Nh8hJFlQENyOLdxuPwIiGGEuEDISlZ2VE8bbr9+//hZm5HsFZ59T5gIh5eufsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968357; c=relaxed/simple;
	bh=bO4sw7/hINJdmJB2o7i6RovRyFWviPuCwq5wxaiI8Bs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lpDQCPiXzQxIk5wiMWKi9/gxymSLOM46eoVRKCnakGRS6R5Xzm3flvZxpqT51Tie75ko78IIvg9XUR4Ewa9A4OGt/km/VnA72SxMCBSpgNfmSdMCyFmNdyIvaUt5Y/aYnHsiceV2kKVie93ftUbfXsCOnQUSfJoKHQ2YSOr9X+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x4CA2EDb; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2ef38fe89d9so863246fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 13:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750968354; x=1751573154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zPJCCS28P/ht0GkmQnG+3GK0DAvT59T6hS3LwMCctEw=;
        b=x4CA2EDbEizTS4SuUHPzydjNoZurxTQT4UJ75wifRxZKdNfo/bZSyJz6/1ck+TPUKq
         XN2yyz7jpUbd04MU0+4gQFGNlzn0u0+sv5wiUO0FfoJbCQxNEDEjATLEXzGZVEh0jDVG
         ZX9G7CEcqbH0dCOCRXlBsOBEnqT0/ze3Lekaax/pEjsnRjqjGAZqwgdFreZ7ZoU8/gv1
         0yE1eII/CfrZ9cMQgDmRDe3s0pBHwKfOiVwY/RN6m3cNwblLmE6OpTa9+NG4vKZG5jYL
         AdYUxeArtZORepDKNrrV4YW6j4alCORUiZ1mMz8jhGfI8MbqlGi92lHo6zHX25wFq/Wi
         oWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750968354; x=1751573154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPJCCS28P/ht0GkmQnG+3GK0DAvT59T6hS3LwMCctEw=;
        b=rdOD9xK5mY7Cp1knQuvopTpMJ2Y8MpWnwQEaLiWpAfNIZ/uKj0X2ZbkNpVgNADWHLA
         W8ucuLji/uTV69gYVv5dIxCut7O+crAwfU08IowoD2AV1Bs40VCedadL1dPIvwQ+Yjme
         /YHSkaKdRRmewHVgT1PovKaWBAom4YfENs/7lB9m1J4ZFhq81nkTKwHGLbJpqCzJMnEg
         35RN9jUge3Dfb0eLCoEY5s9fHdyoQNp4R4U9Os69rldO66+dCm09RQqBBoLg1YPlnyIC
         JgndiKK9jPAddY/etRYG8yxh2GANW9iQnzSf8gVarG7+/sPF/OC60ZmEy2e4q3k0+W1S
         ZmpA==
X-Forwarded-Encrypted: i=1; AJvYcCVnn4akJmPh+2YvWDb2B1TTpKc3mykSjsdXHyQLLjwvzhD3NhgSysCj7mVx5kCbtFAyCQ7orUzMqskcCj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNx6EwtL7Okm6NPM3CvhY1gA5tkruLGvVxQNoL3AWHGLSiOHZR
	2fZS0spr2D4sy5uRLgEqbOksfb2oQW74NsgUmFa7Tx4UBC6YgD1PWddss+8o3fDhyajk9HVNmCC
	NhRgv/hCq0EiVJKz+Gif/iP623w==
X-Google-Smtp-Source: AGHT+IEAValjLvIQUTTrl0WGiv7qDA/VK+W0m1ZQUDRoDH/VSaq0CR37ZF/2z6Fxf5GRvTFbBupf/JJhqDdR5wa1WQ==
X-Received: from oabxc6.prod.google.com ([2002:a05:6870:ce06:b0:2e8:ed52:15c9])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:7050:10b0:2ef:eddd:690d with SMTP id 586e51a60fabf-2efeddd6bf1mr119143fac.24.1750968354720;
 Thu, 26 Jun 2025 13:05:54 -0700 (PDT)
Date: Thu, 26 Jun 2025 20:04:39 +0000
In-Reply-To: <20250626200459.1153955-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250626200459.1153955-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626200459.1153955-4-coltonlewis@google.com>
Subject: [PATCH v3 03/22] KVM: arm64: Define PMI{CNTR,FILTR}_EL0 as undef_access
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Because KVM isn't fully prepared to support these yet even though the
host PMUv3 driver does, define them as undef_access for now.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/sys_regs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 76c2f0da821f..99fdbe174202 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -3092,6 +3092,9 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_SVCR), undef_access, reset_val, SVCR, 0, .visibility = sme_visibility  },
 	{ SYS_DESC(SYS_FPMR), undef_access, reset_val, FPMR, 0, .visibility = fp8_visibility },
 
+	{ SYS_DESC(SYS_PMICNTR_EL0), undef_access },
+	{ SYS_DESC(SYS_PMICFILTR_EL0), undef_access },
+
 	{ PMU_SYS_REG(PMCR_EL0), .access = access_pmcr, .reset = reset_pmcr,
 	  .reg = PMCR_EL0, .get_user = get_pmcr, .set_user = set_pmcr },
 	{ PMU_SYS_REG(PMCNTENSET_EL0),
-- 
2.50.0.727.gbf7dc18ff4-goog


