Return-Path: <linux-kernel+bounces-670985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F734ACBB8B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 21:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C300F189456F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 19:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D1B22A7E0;
	Mon,  2 Jun 2025 19:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XbbImGHM"
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1F4225779
	for <linux-kernel@vger.kernel.org>; Mon,  2 Jun 2025 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748892542; cv=none; b=uqdHYlblE6B/2W6vi0unBenW+Hjby6n95PxNPd+XezZgWZUlkm/hlGGWt7V/7c+7dJuovCJIB8FPjIElDMGHXNP/+Wdm2IE9e4Ptb+soflpecUIQPvWINUyiLsLhFrFIftozDp0Ws92uh1CHqsuRv0AVuB8YdOGLR9PNHd+AMwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748892542; c=relaxed/simple;
	bh=EE8lwX3DPSHd479fj6h8oG+WY564CeOYM752jwwfbIY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bjNXsXPVlIOnCkVhJpDIYb3c/4nb3MgDFHD3c8d48cxcQ99uB9/gQ/AIwQXzvtHduxXlNGXw5c9sOaQMtJR8v6kpEkt0GGFP2o687aWa6tnzF9VZ24bIZfwdJLVwEpqpQOWPDQxPC4SIis6e9jfZmxtfyPkCFYCGnzLfXP/Yy1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XbbImGHM; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3ddb4a92e80so7582965ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jun 2025 12:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748892539; x=1749497339; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ob4i5lx3NjoopJMkPn2Gu2SflaQcZ8+s5uU/xFdQFYQ=;
        b=XbbImGHMT5YKWxUxFNXKd4+Fc5Z7rljkAz4a2j4ZrW2ZT17Q2jzUOjBMaRGlaH+Vid
         lpbeulD4SNnMJUNkuOPNpZGGSqNcG6rgRwmTlTiOt7msbwV374B048BW1wMhXW3ehjUo
         NpEI9q1tGFpPC9ifMmECKkhDQRgZ/ANpUfZoMaIzHL9NgdTlxGzperO28lLJDdM3mdrA
         7yr9apdzZmPOogxNLPSCEwMW0IZayhfvdE/Fzm+/Us8m/EWwd4sX/sSTCgwtshFGJc5B
         LnxxVUX3XwL6GH00S8FHm5j7azb6kV1hLhvUGvlCUkKo7ZitVhRw98xa/H8kN8UQ2gxl
         VkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748892539; x=1749497339;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ob4i5lx3NjoopJMkPn2Gu2SflaQcZ8+s5uU/xFdQFYQ=;
        b=fTXWY9jiopNMNKP+xKMLxTe6Yfa35yuDjT3MafRVCq5svxqJd/rxqp+eCx4hpCrFOT
         9MbxtSJaVV1rrRAEaZcmkzQDOqu4Jd60w3ZKXafUhznj16ALitJQgL8QU60r5L/4G4Bc
         6XrzcuIcOhN/TdQjKr+u0Df7BCyJYH6S6g0/jm/9mSm0UKwkV5Rai26uplg3Whq4Cmay
         SfI15RtkSkyEs7Bwk75P6YuiU/HMLS+kqicU8hQyOy6sMTxST+QLEjlxbxuBgZiokacs
         +u4RoQUhuuBK4L+WdGXGUzEf7HR52zdDQx4z/XFYfFLnOwSaYMbF92MNOpN2Jpsw+krF
         pKFA==
X-Forwarded-Encrypted: i=1; AJvYcCWm7XN36ry+kaqbwyE0exByNWgwAiCj7rnHXgI3HmXNJl/a3L7vgXUUV5PoeHPtnO2khxqTG3SfNgcknqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ12kPL3gI114Uo/LwXGnzYYvyf5YVoL/wE+9xHJs8h7QA9IqZ
	ccSMaG57soXEdGcHrdpZwWgrmVDTvqFUu0csFDok8222XNC9OId+IXqWJq7fABjwHvu3LjzaBqU
	O+ET92sHU3P2/jFlixoU++KwZBQ==
X-Google-Smtp-Source: AGHT+IG9118tOdExJjBuer/f/VBDO3HNWaiwxBHIeaEYz6xcDfDEYQh0uxIwgejlm2yfIrTUPAC6q6L4NmScHLSSog==
X-Received: from ilbbp25.prod.google.com ([2002:a05:6e02:3499:b0:3dc:756a:e520])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:1aa6:b0:3dc:8e8b:42a8 with SMTP id e9e14a558f8ab-3dd99c28963mr156701455ab.16.1748892539395;
 Mon, 02 Jun 2025 12:28:59 -0700 (PDT)
Date: Mon,  2 Jun 2025 19:26:47 +0000
In-Reply-To: <20250602192702.2125115-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250602192702.2125115-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250602192702.2125115-3-coltonlewis@google.com>
Subject: [PATCH 02/17] arm64: Generate sign macro for sysreg Enums
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

There's no reason Enums shouldn't be equivalent to UnsignedEnums and
explicitly specify they are unsigned. This will avoid the annoyance I
had with HPMN0.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/tools/gen-sysreg.awk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/tools/gen-sysreg.awk b/arch/arm64/tools/gen-sysreg.awk
index f2a1732cb1f6..fa21a632d9b7 100755
--- a/arch/arm64/tools/gen-sysreg.awk
+++ b/arch/arm64/tools/gen-sysreg.awk
@@ -308,6 +308,7 @@ $1 == "Enum" && (block_current() == "Sysreg" || block_current() == "SysregFields
 	parse_bitdef(reg, field, $2)
 
 	define_field(reg, field, msb, lsb)
+	define_field_sign(reg, field, "false")
 
 	next
 }
-- 
2.49.0.1204.g71687c7c1d-goog


