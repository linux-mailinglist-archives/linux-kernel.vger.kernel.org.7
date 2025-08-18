Return-Path: <linux-kernel+bounces-772808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844ABB297B8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210D420357C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8CD218E97;
	Mon, 18 Aug 2025 04:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CE4akxDe"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6327825DAEA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490233; cv=none; b=YrGCRkByTRd+6AsKcasIn/SbEWmDG9wzk8YmHvsFh5I5fzEoVFnIDnIkasTegpLXQXKd0Py8rXodqcPkETpKaEdYxtpLaJIdsDn3r0+hlU3exptbZATcASYKkKYij/Gih7lxkf6U0O/kxsaD1iPxV1pHAv+TTrFGScrhU96SulM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490233; c=relaxed/simple;
	bh=JzH3yhqwYOudTCMAKRwj0oa4K99Zc+6yOM1JzEGNxmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHpNnR6CjOzmOnT3yaUfrUySzNOQGnU8McHU+PnqpY1K21TjS/dF7Dg6nvhoi1IllnXUhDUPhMIeWP0QD0i1eHvPkv+BPlHDHXFTX/bFGeysWtDwcUQEI1z0hHx4mGwUO2ePWPhGFi6L3OdIXepD2CQ7O7QaAqcEYQPbzLLp2lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CE4akxDe; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32326e69f1dso3854203a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 21:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490232; x=1756095032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPHcLL2SG/7gEz7cPa5IwB1kBN+rHxLpWke4w+6lxok=;
        b=CE4akxDeqOem6d46ePEyqAupaBofCeegggCdJS5x8WF0ZTSGJolGt2GULq31ZQmP5r
         L+d8T9US0UE4vNKPGKsN+Ucrk8S1j0F1HIFczzpqvnwbzGVNxpJdqfqwwddWnUuBSvL8
         L5PBf/CGHY4YthJwMpae2FFBXWGmks/Q3LeW80WM3uNm6/IExiNR6q/sZ8ZQL+uCP4Hj
         JHM6brEEG5Chew8SsMKrDOoB5jOJekirDiP4OG0Sx2HuDPra6FTRccHbGffZz0y8CLF4
         KutSYj02ADY6qgh9huiUVw1NhLRGIwqEuWh18neqBBpUz04TKhGTLlX4k6l4DGlkkh3b
         6kFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490232; x=1756095032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPHcLL2SG/7gEz7cPa5IwB1kBN+rHxLpWke4w+6lxok=;
        b=LJaaQdgTBHHvRno74T48kXqfP2CkxS4jlAxsrTbM8vmtPg9TN9d0A9r8cH7fzdAZRE
         Rezm9FxvgGfxMOJfzckstqzM1I036/zFXPpgmsF36fQneHPhqu0Vqjr7WfoLrtnoBeYR
         Fm28DsZKc90+efmyRY4O7Gywx31ObpUhWFGyNyzBjnwx5089BEE/MunzYYlZDSRXUgLQ
         vBvwTdU4qE3ijwamZ8nZtx31j8GXx7SqFWIMfxJ/cNWgNlvp8Ga1iojyaj9vSV6/I9ZL
         acVgBut7xTf/ciVv73UXwn6lHabvk/69+Oh63bE7ahW1VmICAT6ycboZjB4sUgzaohZJ
         MU8A==
X-Forwarded-Encrypted: i=1; AJvYcCVewR0qEQT9KW+pgVPqIlALwFzL0RkrfdNe+xyune+tVK43cffWdpQTi8NnrJ7ZvIvZmSO2tJn01pH9gT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAEEp8bt/RxbH+G6qR59e6HiieYdgoTss6GckbwMF8n3QmrZHZ
	XtF3r8AWWnl/4QZbsvdkLrAVNnh2yIKWrfGl0IRzE3UHfgm1k5Q4UoKN7wgmK02ikQg=
X-Gm-Gg: ASbGncv4r+e0e0q2UlRbzQIisDfGyPkDKbUxFsDaaWL3KcULOUCypZGAlFq4I/GEG9L
	tHOfO39hBhjxtXNf7nKxIhcLQwBgOIN6/3I4WD0rYK09U6IH1lruxi4IIlVbrwF1B5bptFCVCmv
	KFwtDFHohhl90LggGDQtCyNk9Syf2GBzAUEMTTacJCHh+4lmLUgkojzqWzGx6LS1mjVHrKGJx1i
	2AtjmGz99zDPerecc29lX11Ff4rg/fNqHfe0C2pwQ/FGgCr770Uu4v7KB6ny2cafngvOdHRAy0x
	8NTkCFXAuEozrxZSnZzM4DBe726lgKb4f/lFCXFyM6mYo8fO3QtBvPf5vSlYfA+PVRGTB5IUiPX
	EY2ajExKL1wAn0l/sVangcKBTAfr1HbxU+wIDdOyuC3qYPuEkcItAIA==
X-Google-Smtp-Source: AGHT+IG2Lm+Y52n6XKyIXBlc4RYKAT1nFaGLczgz8usKKmMpO2sTLSC8znXmp2nRau7FtQyr+2X6Qg==
X-Received: by 2002:a17:90b:1e0e:b0:313:62ee:45a with SMTP id 98e67ed59e1d1-32341ed21famr13448415a91.13.1755490231451;
        Sun, 17 Aug 2025 21:10:31 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:10:30 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v10 03/24] RISC-V: Add defines for the SBI message proxy extension
Date: Mon, 18 Aug 2025 09:38:59 +0530
Message-ID: <20250818040920.272664-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818040920.272664-1-apatel@ventanamicro.com>
References: <20250818040920.272664-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add defines for the new SBI message proxy extension which is part
of the SBI v3.0 specification.

Reviewed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Co-developed-by: Rahul Pathak <rpathak@ventanamicro.com>
Signed-off-by: Rahul Pathak <rpathak@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/sbi.h | 62 ++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 341e74238aa0..c19e5c7383a6 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -36,6 +36,7 @@ enum sbi_ext_id {
 	SBI_EXT_STA = 0x535441,
 	SBI_EXT_NACL = 0x4E41434C,
 	SBI_EXT_FWFT = 0x46574654,
+	SBI_EXT_MPXY = 0x4D505859,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -430,6 +431,67 @@ enum sbi_fwft_feature_t {
 
 #define SBI_FWFT_SET_FLAG_LOCK			BIT(0)
 
+enum sbi_ext_mpxy_fid {
+	SBI_EXT_MPXY_GET_SHMEM_SIZE,
+	SBI_EXT_MPXY_SET_SHMEM,
+	SBI_EXT_MPXY_GET_CHANNEL_IDS,
+	SBI_EXT_MPXY_READ_ATTRS,
+	SBI_EXT_MPXY_WRITE_ATTRS,
+	SBI_EXT_MPXY_SEND_MSG_WITH_RESP,
+	SBI_EXT_MPXY_SEND_MSG_WITHOUT_RESP,
+	SBI_EXT_MPXY_GET_NOTIFICATION_EVENTS,
+};
+
+enum sbi_mpxy_attribute_id {
+	/* Standard channel attributes managed by MPXY framework */
+	SBI_MPXY_ATTR_MSG_PROT_ID		= 0x00000000,
+	SBI_MPXY_ATTR_MSG_PROT_VER		= 0x00000001,
+	SBI_MPXY_ATTR_MSG_MAX_LEN		= 0x00000002,
+	SBI_MPXY_ATTR_MSG_SEND_TIMEOUT		= 0x00000003,
+	SBI_MPXY_ATTR_MSG_COMPLETION_TIMEOUT	= 0x00000004,
+	SBI_MPXY_ATTR_CHANNEL_CAPABILITY	= 0x00000005,
+	SBI_MPXY_ATTR_SSE_EVENT_ID		= 0x00000006,
+	SBI_MPXY_ATTR_MSI_CONTROL		= 0x00000007,
+	SBI_MPXY_ATTR_MSI_ADDR_LO		= 0x00000008,
+	SBI_MPXY_ATTR_MSI_ADDR_HI		= 0x00000009,
+	SBI_MPXY_ATTR_MSI_DATA			= 0x0000000A,
+	SBI_MPXY_ATTR_EVENTS_STATE_CONTROL	= 0x0000000B,
+	SBI_MPXY_ATTR_STD_ATTR_MAX_IDX,
+	/*
+	 * Message protocol specific attributes, managed by
+	 * the message protocol specification.
+	 */
+	SBI_MPXY_ATTR_MSGPROTO_ATTR_START	= 0x80000000,
+	SBI_MPXY_ATTR_MSGPROTO_ATTR_END		= 0xffffffff
+};
+
+/* Possible values of MSG_PROT_ID attribute as-per SBI v3.0 (or higher) */
+enum sbi_mpxy_msgproto_id {
+	SBI_MPXY_MSGPROTO_RPMI_ID = 0x0,
+};
+
+/* RPMI message protocol specific MPXY attributes */
+enum sbi_mpxy_rpmi_attribute_id {
+	SBI_MPXY_RPMI_ATTR_SERVICEGROUP_ID = SBI_MPXY_ATTR_MSGPROTO_ATTR_START,
+	SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION,
+	SBI_MPXY_RPMI_ATTR_IMPL_ID,
+	SBI_MPXY_RPMI_ATTR_IMPL_VERSION,
+	SBI_MPXY_RPMI_ATTR_MAX_ID
+};
+
+/* Encoding of MSG_PROT_VER attribute */
+#define SBI_MPXY_MSG_PROT_VER_MAJOR(__ver)	upper_16_bits(__ver)
+#define SBI_MPXY_MSG_PROT_VER_MINOR(__ver)	lower_16_bits(__ver)
+#define SBI_MPXY_MSG_PROT_MKVER(__maj, __min)	(((u32)(__maj) << 16) | (u16)(__min))
+
+/* Capabilities available through CHANNEL_CAPABILITY attribute */
+#define SBI_MPXY_CHAN_CAP_MSI			BIT(0)
+#define SBI_MPXY_CHAN_CAP_SSE			BIT(1)
+#define SBI_MPXY_CHAN_CAP_EVENTS_STATE		BIT(2)
+#define SBI_MPXY_CHAN_CAP_SEND_WITH_RESP	BIT(3)
+#define SBI_MPXY_CHAN_CAP_SEND_WITHOUT_RESP	BIT(4)
+#define SBI_MPXY_CHAN_CAP_GET_NOTIFICATIONS	BIT(5)
+
 /* SBI spec version fields */
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
-- 
2.43.0


