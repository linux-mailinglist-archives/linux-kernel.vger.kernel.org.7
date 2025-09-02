Return-Path: <linux-kernel+bounces-795511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ED6B3F3AD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A3D3B5BBF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 04:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CAF2E11B6;
	Tue,  2 Sep 2025 04:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PWfUFMf+"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA4D2E040E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 04:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756787090; cv=none; b=T90CgrRh03p0q8W1srphethGw4DfwW1xVQ66Fc9H7tuqJewUx4KvY+OpBjhptN1HUDnXEBlb/r40nvFMl5OSgCKrZfN6qCNjg4Mro39wPe6ZJhOGD3q6M4ESbiJ+gVM0CKsqzMT3PpTZ1F0gmVa7qNXi/FdxTJZapGDTxq99fI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756787090; c=relaxed/simple;
	bh=AHBUSWC6NQwt5gipootBG6lu9YU2EyCEcBy5+RZx010=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EDUe9OcKUSrG5N9XAfGPKRFuJlqYzoeNh8GPOsh6nQ/RGxvSJqpkbbi+6sGeTDl+SaC3osoQAiotwpGRJfFKxW7FJv9Rx4y9jZIntanodeD5E0UlCeZ0OeVGXmvV0oWnmuZ940HHRNqgV5rQWzrx8IkES6x6GTxpsSWjsgP5gYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PWfUFMf+; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3298961169bso1700173a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 21:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756787088; x=1757391888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4l4TBk/LGXRpjovIOSrhrLfanQNTxjIirl6+Uo+sE8=;
        b=PWfUFMf+/96vX/Bp+WAl3sj5Xol4cbLG1I0IwapwdW7wh2laaHbtfp4v8hYmlQPBLP
         tW1Q8pXX/51Z/YE99wmgxDpiDEm8mvRRIdXgNHt5nPYUiI5/fHEqvGqM88Xr+0aoAAwt
         WDBsWhqnfrhauC5ZagKZmJmBlqgD3wmb6cpVRJqFioXMfxTh/qYkOAofQWkMR0XwIDRa
         Z3U3qyFUIBrKCn6f4xS1NItPoHd5agwKImLj9mkrDJibJWVNxXKhl6Gr9QUBR2Z6wH5c
         4Pbp9nokVgZgW0LaYRc423zuybMrQcFErltDEz62Mnts4VcjGFwCC0y9ToYDxJ6febod
         6ByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756787088; x=1757391888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4l4TBk/LGXRpjovIOSrhrLfanQNTxjIirl6+Uo+sE8=;
        b=js4dgZ8JXSH+dm6eMUPVi9zn4XKKFy7bpH5hT5LckwvyhMvGiZEsvv3ZXkSz7Y6Ms7
         lu2OXyGmgqbSSYZ+FoEh08NslN7glrHJNttbZT2jHW0SGWXWmPeNNaskJw8ydNGSqw5w
         1v/Fej+piK81p2UgrxZBEyy0ajRSv9qaDDOEspBGjQXN+DwKikKX6sMHIbs/Fdtryh4C
         W1qsG93WFpBWSCuByyDKK9xYmf85MT+o2gDMnyHQ+iU+7/C+eIT6oEn7JeOtXNMqo+yv
         TvndblmENvLU1SMP60dlVo0xHjzSgdN1Qr0efJ3q5kwPbHq7tWhF6bzlNA6GzGxJJBnj
         dcaw==
X-Forwarded-Encrypted: i=1; AJvYcCWOh1HbsYNDgth74fw2A/q7yFUt49agqNSSTQArYxfQSg9/1dINOa1XG3kQtVcWlif9FED1EVXZqs60nC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFhM9nPwZVD/2DzrGe4FBvfG+HEPHuxAitZL7bQaFcDhe+GDKx
	/scdS8jhCcpoyfrkehn3+yHqLuSySK/WOL+GmOd5oyFttUY5OJ+JHIIFBXzC9+9RfLY=
X-Gm-Gg: ASbGnctOnXDl3IZ5OeKoQrAvbURoH6k6YGR1Lo0vcf+6a/wA+jK3ad3m3okemdGU6Hh
	xEho8edu97y2P7fs9Zbnq3toOXW8PD9q0knJpgNPCxmbtf7NzjC0rPPDZY0GVb0y2CIXjMcKyzI
	lXCzaDSLImfOlpk+bTcC/GV+CVQxwWhdkmA213Kl5XqZ5LVWGrcmVSJdvOGl7y/k7vFILf5oDGm
	NqGpAOZPkCO8/IZuCJdf2EEX7tYuxM6vAcuf3+EjZgxvZhslIt93Mx9M7AGBLI+XjpuEV/JNjvb
	nqoZQtFBChnTlFY83U3DhBAgnlZh5pIaNOW3mo3z3Y2mu6cYtPbbsSMoW0yMiA0Q6B7ZFq1qZSY
	Vjyy161rZ3aw0/x06soLAS0g3AYa1fe6zLPGyx9JM2pr7VEi9UXctJnEkMBz4+72H5yk6bg6rgP
	Uuflvw8GPpQ6xB1xfcbJUQBsQPall1Z7ukLN3XKmrPKnJ/b9S9/8i99A==
X-Google-Smtp-Source: AGHT+IF/UIFHSTUTfHrNH3bDDX+6KD5zm8JCKYYhXajmMDgvuIFurnNObTwTgyDtBVvv4P6nH93RqA==
X-Received: by 2002:a17:90b:3d48:b0:321:cf49:2c04 with SMTP id 98e67ed59e1d1-32815433803mr13646315a91.9.1756787088100;
        Mon, 01 Sep 2025 21:24:48 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327e21d14a8sm12216706a91.2.2025.09.01.21.24.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Sep 2025 21:24:47 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	ajones@ventanamicro.com,
	brs@rivosinc.com
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v2 1/4] riscv: add ISA extension parsing for Zalasr
Date: Tue,  2 Sep 2025 12:24:29 +0800
Message-Id: <20250902042432.78960-2-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250902042432.78960-1-luxu.kernel@bytedance.com>
References: <20250902042432.78960-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add parsing for Zalasr ISA extension.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index affd63e11b0a3..ae3852c4f2ca2 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -106,6 +106,7 @@
 #define RISCV_ISA_EXT_ZAAMO		97
 #define RISCV_ISA_EXT_ZALRSC		98
 #define RISCV_ISA_EXT_ZICBOP		99
+#define RISCV_ISA_EXT_ZALASR		100
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 743d53415572e..bf9d3d92bf372 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -472,6 +472,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zaamo, RISCV_ISA_EXT_ZAAMO),
 	__RISCV_ISA_EXT_DATA(zabha, RISCV_ISA_EXT_ZABHA),
 	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
+	__RISCV_ISA_EXT_DATA(zalasr, RISCV_ISA_EXT_ZALASR),
 	__RISCV_ISA_EXT_DATA(zalrsc, RISCV_ISA_EXT_ZALRSC),
 	__RISCV_ISA_EXT_DATA(zawrs, RISCV_ISA_EXT_ZAWRS),
 	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
-- 
2.20.1


