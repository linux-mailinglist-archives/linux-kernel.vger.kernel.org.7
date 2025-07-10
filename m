Return-Path: <linux-kernel+bounces-725694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E60B00280
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5E53A6FC1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE59262FF3;
	Thu, 10 Jul 2025 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JMBBi2N7"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38CF25DB0B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151988; cv=none; b=Vd823AZex8gJlLdxH886891IWkBm1EGKbZoDCYIFyX8BiEOkl4fYX+klcmX2ylB2S07ZdnWAoS+bXMhRWNltCyE9+mjT1cBLhodwdYMxI9lKyLWWd/J9iETc2Ak/7TjiXreorNsM+nUyRdzsB8Zq7SVFbnY2Gilacts19sm73Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151988; c=relaxed/simple;
	bh=fFsYrVXbwwe22MipMGVl9jJ+UEacaN5R6LBneJBMTkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hf9nRA2WdL5pb/uZq+RA/QLg7M7OnhC3q4LWUn8piIh3vcPlgkeZ2Kv+o6DA/ilELckeUJ84gyohvRrudzZ1jII+aYrJMiyneLAcKmDUEC44GKy66EXku++MyFQcFZzR5FarkPWVGS7+UcPwDsWgn9W9lo6VibcrFqoFt/H9lVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JMBBi2N7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23649faf69fso7802875ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752151986; x=1752756786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FODh5LEn2POoazeC0llsDNSZPOaGEqIA3oG6I9SOPao=;
        b=JMBBi2N78CRjrGwkGDsbaUqjg73Gv0AyLMmEgQgtEhrf+gwWST/+RaPFPd/GI6Y2GQ
         bl0KSDFCg5rEaI+G5YRBeAnRcDqXJmkr+lL2969NkYDjs8U/fDB6GQSMprYdYZ6dUGHl
         6DpLZcdRYAsl6z5ThlR6PrdRuWngrMMqIwW03gVflH0XlFoUHIm5pf5u2/CmXzbGKtVI
         KOxPAfciFs2mpXgNxyXmyM5zOeSKjepAV0fuqKZqvGBPPT6i7p9M+V0Go5wsFiEEhNZR
         JC+gjNgetrbBuzzXKUmowA34BW7z61pSxSekYQgX0GGSlhn/1PEK6eCfwDGzB+DzcXh9
         NPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752151986; x=1752756786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FODh5LEn2POoazeC0llsDNSZPOaGEqIA3oG6I9SOPao=;
        b=AlEPlYVMZ92u8ECjxmgRPOKAfomtUCbn7BBrDKzS+ryfzPRT6OpQMbG98kSdqVnCoF
         Y+U+xUBsx5mwxZjDYw+GcHHMxTFyybrmpZD8yJ29r5/76KPZhd3aYcz22zs9Mu2KTonq
         3rGmzsRIyJnullA+saSwOaJ4RJIX51lHWlCKSSSwtePL2Hv8ekjzSRenoG5Vw+DaIgWz
         BDI3vXtgnPJGt9DHg64NItVz4+Y/D9FPXL8j5jnkzoWMiayN8uAkP2OUszU2nwc3GjKs
         astvqlUePa7/t4yDSaI8fHXBuY7tA/PYspWkUZK07BbloA/TS//o0CXwRu7Erj9mYBVd
         6i8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6FQL7QtYPbyuH1FpQFQwP2Y4zaKBzMt4z8CNuesNwaSF/CPKLXCABRc2vv/lN8GXnv1Y1MBYvJlzOi90=@vger.kernel.org
X-Gm-Message-State: AOJu0YwElXKCIV9GHLIckIc2zm0MmELNuoh48AVts7uEEBHTz9LSIpdF
	qov9T2K3MaHflzisL7O4v5RQV+VKJ8QS0qxap/9ZZAHH/XAS11ENW6xcUnMEMnGiehY=
X-Gm-Gg: ASbGncub+TfGiUOaXutEnOcP8WD9pEAXVGyzOy70ieo6dv3xfrcDXbhwiAICkHTJk5B
	80sTeG91QEQuNqIFt4gxxqVayKuKfKD6OhI8EIvBjjPA1Sd9qsT0b7xAnG4aLc6VbyEsePezs4G
	75H/D2p2ISPhIngIFpKIL9VEGJUuC01dSZ0x3W2nWec1YIkoFDOlElvIy1KNMIJcZ0Yp4eCja+r
	zgJbSaVBOvrII+YU4NBQ01PXXR1AGx1dmITwEMtC+oxRFULUbsQANjWh06I/7nQ83GO4Ym9Jlzf
	DliqwzqyT/79ib3MAR/Wm0DLiat7hr5aDeD7+oJ2UV/efIibokiqzNijrOiEgRLxsM7Ri0zOPHz
	Vd3XncYhdRodl6rZ4qXTIqSs=
X-Google-Smtp-Source: AGHT+IFK15bpyfOg1Dywk9BgVb8ZqGEGvpGQYgyG2hJu1g8/wtPz0YTQM4PXUYaqFOy2dAQIXo1d1Q==
X-Received: by 2002:a17:903:1103:b0:236:9d66:ff24 with SMTP id d9443c01a7336-23de480adf5mr36705025ad.8.1752151985837;
        Thu, 10 Jul 2025 05:53:05 -0700 (PDT)
Received: from ventana-bhyve.dc1.ventanamicro.com ([49.37.251.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4359c68sm19230715ad.213.2025.07.10.05.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 05:53:05 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [PATCH v1 1/2] riscv: Add SBI debug trigger extension and function ids
Date: Thu, 10 Jul 2025 18:22:30 +0530
Message-ID: <20250710125231.653967-2-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250710125231.653967-1-hchauhan@ventanamicro.com>
References: <20250710125231.653967-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Debug trigger extension is an SBI extension to support native debugging
in S-mode and VS-mode. This patch adds the extension and the function
IDs defined by the extension.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/include/asm/sbi.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 341e74238aa0..d1d906bc5365 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -36,6 +36,7 @@ enum sbi_ext_id {
 	SBI_EXT_STA = 0x535441,
 	SBI_EXT_NACL = 0x4E41434C,
 	SBI_EXT_FWFT = 0x46574654,
+	SBI_EXT_DBTR = 0x44425452,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -430,6 +431,34 @@ enum sbi_fwft_feature_t {
 
 #define SBI_FWFT_SET_FLAG_LOCK			BIT(0)
 
+/* SBI debug triggers function IDs */
+enum sbi_ext_dbtr_fid {
+	SBI_EXT_DBTR_NUM_TRIGGERS = 0,
+	SBI_EXT_DBTR_SETUP_SHMEM,
+	SBI_EXT_DBTR_TRIG_READ,
+	SBI_EXT_DBTR_TRIG_INSTALL,
+	SBI_EXT_DBTR_TRIG_UPDATE,
+	SBI_EXT_DBTR_TRIG_UNINSTALL,
+	SBI_EXT_DBTR_TRIG_ENABLE,
+	SBI_EXT_DBTR_TRIG_DISABLE,
+};
+
+struct sbi_dbtr_data_msg {
+	unsigned long tstate;
+	unsigned long tdata1;
+	unsigned long tdata2;
+	unsigned long tdata3;
+};
+
+struct sbi_dbtr_id_msg {
+	unsigned long idx;
+};
+
+union sbi_dbtr_shmem_entry {
+	struct sbi_dbtr_data_msg data;
+	struct sbi_dbtr_id_msg id;
+};
+
 /* SBI spec version fields */
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
-- 
2.45.2


