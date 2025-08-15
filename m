Return-Path: <linux-kernel+bounces-771158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8616B283A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2171BC036D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C591B309DA9;
	Fri, 15 Aug 2025 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YauduTjs"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77C3308F19
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755274464; cv=none; b=kp4eqMcXNKP/Jyk85gZ5EV7lkzZeCQzBLXjQvI7EVeNSqfL4X48eJ1cSRSsJqeOt7o/9U7xjJ+Iw1P9uwWlL1WQAyxj97oM9cNbYTa4jmXqa1zc0CRDahPZbLUmslOhe9cJbGWX8ix1qPq+iN2rdm5DWjXELGQ9uPMp4/b3BJhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755274464; c=relaxed/simple;
	bh=fmplqdUGwRhCU6HwPvTap8Scho2rClFy/lrVQmWUIAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQOAzomFE3QXOHjNa70ecEhiAMDXgq7N1GSvuJL97MI+J0ORMiTX8T5GQ4GMSe2kTGksl8Is3n4BwBT+OsvwjFDE1pZ0l/fJFysVsYYshH7Eyc+zjDSaAgu58Y4u1NzIQ+zL7LZou7YoSO8LPR9QkeNSf6qLUxvQ9g0XThl6twI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=YauduTjs; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b472f0106feso451124a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755274462; x=1755879262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOTbtPDm0qsjMzwi16WVYcaH7+7/qMVJUy8rQwaf7Ps=;
        b=YauduTjsb5rQ9ZqQ+g8kVQAHIpNNR+Q1io4qEGxQaKFVXDJxlCfaVRER3uNDwKMWnp
         xK8Xlr4y73MCcz0Xuz6mUQ1ixrzAuuajOrnnwWP9x3wKb6KcApPc7lvB17sWfQmBPycQ
         C3QmDl1gly72PYb38PbkyPjEfTtAgwEk2arm1FMVKIphRsU52evSUHioCjM3ujdKz26L
         A+dz9ijEW3oiV1Xnb8c5+aR8IXndLdF3Z5CPeOOYeGD1PXWcsklDXA7JatlSu7Wl0rl8
         7pUTFTcXzyEdqT3rkNbQKYx/Hs/SXySk3rX8oI3UDG/L46R6/Yg6gsKO124oi4vcczSb
         CcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755274462; x=1755879262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOTbtPDm0qsjMzwi16WVYcaH7+7/qMVJUy8rQwaf7Ps=;
        b=RTIAU37YaBwNgOopvWVOOlafGelqaDTZd6KYmUSiSRuneJHh9gMAToJqPdbPnLsS0e
         CQoBA8aFqNGfZORfbaDP7rhjqHXbaTRM7KTj0iY2JCWnJabEokvsWbUPl/pHQTG7nXIn
         jRIeUAMFvWsOGiXhOqAmkea7qxrYJlJVJQy4Zj0lFY/8HQqRClzR0B6T5a0FM6Oubghj
         BvBDhavCqq7jaUAtKDKKiZ/JQ4lJepx9bQwlfjNUm9WBlmcEAXc63lAqeVtcUqfwAThZ
         2QNwvC2rK/amNT/Pjc7XjAQnD1Rwut/mbBVyk9NDKNanyNDaaoLBBWI89/26q8/wFro+
         CojA==
X-Forwarded-Encrypted: i=1; AJvYcCWYhiNBiepGbJW0tiuc1pio3n1WZg0JuytWS+9ELQV3Me+K95OBdX8XbGS1Wcb3W5yeQy0L1UwcZQ1+0SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD+HDocNEe6Ug3t35/FqLHQKlUNkqZAGknQ3XcBkiUHkWoX9Di
	Bs6eevmUcr6PFOSIkiDiuM+EOVLv6uke18+fZn/nk8P9pR8HQ2CTe/GrpLL+A4OXoUQ=
X-Gm-Gg: ASbGnct80Fbw6MbtIc6zCN/iN40UlrmMOGi6QWBcrVIncblL5gW4chiNYkct3j99J/7
	WxDAyIa6B1rLiMz5m7b7phQPEsE0a0RWJl7xwcTrpkRG5XHBFvLDt/kpreF1RakseoJP8CYDCeE
	t48qcpcEl1NF0RzO1sEVA13RkZS86yRT0bJ5ttzSwkOXM3diEsxf6FsOSis+mPumBfqB0cO79nZ
	XHOtEIKm9bavmats/HPuAGvrtwoLMrJ3HEds8XxgsglJ0eE/sFd6081EwWSfytPuxg2FpOiyiny
	xEB5hjKDyzHmM9NhfYlOHgqPQd0MuuPaEVqz8Ahr7+2Cxq/PsTpGn6xyZ261mOU0wfutWOeC34p
	C6na80msNdGcQ4VmxsmO6LJsNTdYySyklYAB3YCDcPqtsNmixMOzxk4o=
X-Google-Smtp-Source: AGHT+IHFvFTmbcxXmRN3DXHTp35ctiVVaiF6Z8YM+uVIV53DcXSsUv4K9ZPJVyFNnw7pfMwftn7IEw==
X-Received: by 2002:a17:90b:3f08:b0:31f:22f:a23e with SMTP id 98e67ed59e1d1-32342161425mr4018316a91.27.1755274461963;
        Fri, 15 Aug 2025 09:14:21 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32331123409sm4645605a91.20.2025.08.15.09.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 09:14:21 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Len Brown <lenb@kernel.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 1/2] ACPI: RISC-V: Fix FFH_CPPC_CSR error handling
Date: Fri, 15 Aug 2025 21:44:05 +0530
Message-ID: <20250815161406.76370-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250815161406.76370-1-apatel@ventanamicro.com>
References: <20250815161406.76370-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cppc_ffh_csr_read() and cppc_ffh_csr_write() returns Linux error
code in "data->ret.error" so cpc_read_ffh() and cpc_write_ffh() must
not use sbi_err_map_linux_errno() for FFH_CPPC_CSR.

Fixes: 30f3ffbee86b ("ACPI: RISC-V: Add CPPC driver")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/acpi/riscv/cppc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
index 440cf9fb91aa..42c1a9052470 100644
--- a/drivers/acpi/riscv/cppc.c
+++ b/drivers/acpi/riscv/cppc.c
@@ -119,7 +119,7 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
 
 		*val = data.ret.value;
 
-		return (data.ret.error) ? sbi_err_map_linux_errno(data.ret.error) : 0;
+		return data.ret.error;
 	}
 
 	return -EINVAL;
@@ -148,7 +148,7 @@ int cpc_write_ffh(int cpu, struct cpc_reg *reg, u64 val)
 
 		smp_call_function_single(cpu, cppc_ffh_csr_write, &data, 1);
 
-		return (data.ret.error) ? sbi_err_map_linux_errno(data.ret.error) : 0;
+		return data.ret.error;
 	}
 
 	return -EINVAL;
-- 
2.43.0


