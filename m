Return-Path: <linux-kernel+bounces-817828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E01B58728
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9C24C2C81
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819912C0260;
	Mon, 15 Sep 2025 22:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBn+KD30"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526C028E5F3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757974028; cv=none; b=X48rJs0eG+KKE0drmGLpVmJlGm6s2qZm9sljbpKi0ENOK+P7888+xbWmDDv6joTtTX385vh9aa+5Y4aKrP2lGvJaz8hUnh7fxjajhWl1OorE31KPtF+RwhtnpfXSzmZmBNmqiyF16deElhdSNukJdBthzbHAgitBXAuF1xIKkF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757974028; c=relaxed/simple;
	bh=8Erp0FSOgmp8Qh6v7i8vIf09HFje3C/hg4JsqGtXnUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kpS3CvoevoT4h7jzj5tpyXGr0d7Mb6HCQ4ObzWB4N0vMGP6nbevDOB8WlXIqVGE8oy3KLZpMpVDJJu/Cj+DZ0L5ZSoIF6h/sF3ANZdX8Tb3Zv5JX6bpvH/QSIV43oIFGhKwWyxy2uvncxZmI1Xkqvkp1NOqz6LkDU3i6mZa/azM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBn+KD30; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62f28da25b9so2658693a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757974026; x=1758578826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mWq9K4N62YrjUgnvfrpfBO/XZHgq78ADcqLRBLBYlQc=;
        b=eBn+KD30qPbEUuOeroUOVcN2pA6lww4B7epE5+sWo8W9+VCD1JOyi3mGUQpnJKI8Th
         hbEHVmfNxCmBbahFO0qj3ieJRwvWsFex4iNfXWEy5y1RyuLZu1Vj3xq4o9X9jYAjOKll
         v4G/1QbY9fDukDLmHiukAfW1qBpRnRPmwSVRWNUENxo2yDjvVz/1cVy3wz2JBmrwAdtp
         xF6SMyZ5By8rohiaN6rH14YoZdZobTzq9Ho3fk53eMMfWTZK++dgp99K3MzQge/e7ikg
         +KyzUFqR3rb047QgFlu8WjWtgF7OryhhSpkmRWp9c0MZJ/7MWV3JIjUJdlVK/24YCeSN
         LILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757974026; x=1758578826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWq9K4N62YrjUgnvfrpfBO/XZHgq78ADcqLRBLBYlQc=;
        b=NbOx03RP/pVF62wwvRySEt0VlDZZmmYQQ5M7d6lfSVoKTJfIhgj1dSBbiInRlWMAVl
         /PhJf1e2cfr1MMP+t6UpFghVLHQ1E6OBoqV7ApjJOqE8Ix1+EnlyL2rYhp/tlzG8KchA
         AxKwc/nbb1vFH287K8YVCV9GBn/XwyparbJqpa41aIJShZyXKqiDM9bbwfhYP2JJxjYv
         dqn31BuKArMltKOACjAxEPqamZk9rMLe5pAodyXFeDllsZraP1pHjRSAutLRWjwUcOXi
         Pyr2c0VF53EbeWZLzgla6P24GNc0GqnwoW/qMEN/RVqpMfJTwZW6xkEQbe7LtuGwoSnu
         1IIw==
X-Forwarded-Encrypted: i=1; AJvYcCWFB8cVUpOgXypXmENT2LOjGg2mfQOWEnUW3JokbBYaYHxi2GnQqMv2wYYMHYty3TyF/3veRAvWp57U8Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6o82jdF4rkR6MhOHWuZS0QR8b4YrwEZI/1zctZkOMzsTcFfW5
	4i5SZteL56529D1UXXUndpC0n4rjM8Sw1MoyM520oabrPbi9oAAR9i0=
X-Gm-Gg: ASbGncsxK7anhHTpBl0Nwa5PJUOvtvBYlDJqfPKTbay6he2TC+7z+R4TbdXIKwzVQN/
	pgFAa6ono0I72KVL4nQYx+VXGGLPirRMIg0AsWlkJFgePYmDs1DjjcfTBwGxGtbqhw2GnSjImDF
	XTkI2qOPRWF1GtKasUZ3yuJ8d6AfXvS+It5dQnKVdOAYa+LnUvqcS4Qb6Svq62znu28rLR18Oao
	dVXsR6a+7SZvcJX9sOlGxNPGgJoGBvHEosZBKJ/VsLhr2WT/r1gvGRG11PG7QwThGRfBhi1zgTq
	KVqQqPX1OBq5uPtwz1IFR8LK3n3K3wYe0a4Jac8qM49EVeXJdHUQ/uwIF9sx7qeewB6nI9GG32t
	XqVIO1Mwdzcogtkvi/nnqkrelvYzyttDAUxN/lbm/COzG1dH4FrC1jA==
X-Google-Smtp-Source: AGHT+IF7dPa8OCPxYg/A8yjmk5DCk3dELMYC35KzC0feKlYcosBohkoTLl09lrT68/wEHUmsB2ldVQ==
X-Received: by 2002:a17:907:3e1f:b0:b04:6047:d4b5 with SMTP id a640c23a62f3a-b07c382989cmr1253021866b.44.1757974025443;
        Mon, 15 Sep 2025 15:07:05 -0700 (PDT)
Received: from localhost.localdomain ([78.243.111.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd6f3sm1011464166b.67.2025.09.15.15.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:07:04 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	kernel@pengutronix.de,
	festevam@gmail.com,
	l.stach@pengutronix.de,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH] ARM: dts: imx51-zii-rdu1: Fix audmux node names
Date: Tue, 16 Sep 2025 00:06:55 +0200
Message-Id: <20250915220655.143861-1-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the 'ssi2' and 'aud3' nodes to 'mux-ssi2' and 'mux-aud3' in the
audmux configuration of imx51-zii-rdu1.dts to comply with the naming
convention in imx-audmux.yaml.

This fixes the following dt-schema warning:

  imx51-zii-rdu1.dtb: audmux@83fd0000 (fsl,imx51-audmux): 'aud3', 'ssi2'
  do not match any of the regexes: '^mux-[0-9a-z]*$', '^pinctrl-[0-9]+$'

Fixes: ceef0396f367f ("ARM: dts: imx: add ZII RDU1 board")
Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 arch/arm/boot/dts/nxp/imx/imx51-zii-rdu1.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx51-zii-rdu1.dts b/arch/arm/boot/dts/nxp/imx/imx51-zii-rdu1.dts
index 06545a6052f..43ff5eafb2b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx51-zii-rdu1.dts
@@ -259,7 +259,7 @@ &audmux {
 	pinctrl-0 = <&pinctrl_audmux>;
 	status = "okay";
 
-	ssi2 {
+	mux-ssi2 {
 		fsl,audmux-port = <1>;
 		fsl,port-config = <
 			(IMX_AUDMUX_V2_PTCR_SYN |
@@ -271,7 +271,7 @@ IMX_AUDMUX_V2_PDCR_RXDSEL(2)
 		>;
 	};
 
-	aud3 {
+	mux-aud3 {
 		fsl,audmux-port = <2>;
 		fsl,port-config = <
 			IMX_AUDMUX_V2_PTCR_SYN
-- 
2.39.5


