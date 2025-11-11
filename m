Return-Path: <linux-kernel+bounces-895353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B374DC4D968
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44C604F79EB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FCD358D15;
	Tue, 11 Nov 2025 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caQSIXyW"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC723587CD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862469; cv=none; b=E065oUBCCJM5GtR7uHa4D50E9NJs9hsIGwqIrEAGVy2N4BL79c1VU+sEFtJ8EjJA9nDqLCGVqdP3kCkbKShsHY+FMaTrTvjkot6X1lR9L6oCiKZNc5A1EP8HAlMi5Ie6CvJVJdgsX7oltd1B8zO7nBuP+XrUUEGNnLbu7nCuLl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862469; c=relaxed/simple;
	bh=8bivci5cWWAxauLG2MtkB8Tbb/thrZEnVxK7tXLKEU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jiq7o9vMfh/zJQfY+AV9RZVpomPVDEBC3tGdOQ3invwl21uEW21XzAxDfAJoZPvr6z0udRNAgXruKgHIW9VI7dDD+oozhHs6UtYwGfczX3OarSIFm1gWfAaoQFpp01dC54gkBPn/X+t9Nznf6lDcSh42ERMsCE+XcKAoJ2FfzeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caQSIXyW; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b72dc0c15abso578157366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 04:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762862466; x=1763467266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJg//KOLtGKSYp8Owm6BTGh3ScE+qyb41BzG67dVSA8=;
        b=caQSIXyWZOHbNPEOlf5Gymx+yTUT1uBcpC/uONfM0Hecj3Ln2o/8vUZVogQ9nJPdf+
         +9wajZi0MgPMqusClcSFIYuamzY85WGi/jjlyxhXW8Z4uQOBE6Sag6IEnYG5tsD3QZdQ
         decrOM0jc1YheAADRaA7dgJKgCIVILva3I/5tO6iD3YZrCW+6JLjq0bsg71arNt0Nv3o
         VJxf3I6mNAk51lqzqxWc8sbJFD0GJ4TqT35DUbyLTDrmPdCNc8nzG6jvq6r+2S45TJtZ
         0M92QMuzqzgmKmUmmxI6ede4FO1vgv/T7CGK+QU05cEoWQ/u9+O6wu1+VQAd1ylazxfT
         SRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762862466; x=1763467266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kJg//KOLtGKSYp8Owm6BTGh3ScE+qyb41BzG67dVSA8=;
        b=Xj8301trNbvqmOVf6MenVJI0/Nslz3zos7/S+x2kIUKRYEP+wXQBazBXiJBXhuXi5a
         G5P7CMiVc+PLzOQ5DrigkGC1bc+xH8e56zxzzkIuXK5Nakpc3gG+jsIRTyab2d1PkUpU
         1Zj3a/WcDAFBQksy1nyKYnSQiOlPQv4BlOo53nW+8pdj7f3zG9PUbmnHIi6/Xl7snaI6
         Wh3Axs2HHisbxOP9G80/WDMvmR8yAcDtd2d5tOqWN0iFWSUseEG9s+tF/EDbwKzSkA5q
         KFgZ5Jrr6iR/XyEKJbNiRrtFU0myWyLihMGcn0K3zItxlwYlNYyGzn063u5umS6faP8c
         9tCA==
X-Forwarded-Encrypted: i=1; AJvYcCVVKLR1TvQ02aBstSd3RZyPowE97/UKUGXY9FN4XE94GaMkekwHd2xl7HDQUFejAr8FUu8S13x8eLzU9n0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFFrfvFInkWoLgiJYCZq16KVowic0ORW9cu/FKgOI0KaRApyEK
	i7SMeCuUBnj6gq+VzmfaoFtxDjA89ehA9Azhm2HwvTivGqf1nt1C4Dja
X-Gm-Gg: ASbGncsenCgDDPPnI/S/o7/1snBHmiaX5Gb9HWBkv1Udvl4QahqtttU/qXRBUxQj/iW
	4cS1ORMuO6agF4KxApnW2T+DAP1I9EZRcxPw7vb8ASIlpZQ8yI1UKBJieSLz6wazTaxztth1gGQ
	m4F1NUmw3HA8/RHRSwnDFOfTuToRudpuYIWAYgOBcNZDn2DuFQhQA/xBZ7e4vhDcABXTgrNeYoj
	mCX4PY8W32vH8m4vKGNPmt9ZVaXcGzgMLeqHOpMxfOzpHuXco7ST5W5NofORMvAIq9dOj8UTK4l
	pk9tHzTAOv5O9kF14gAxWQEBzkSvEiZRBDcKIcGR5C4NlBrzS2scGcVcGEEzE0962LmYAWf7jBU
	VhX18wKx/vZOua8ACRt/bkSzaPKI/s25B4LNSnmiRKiUBIl4nAuYoLqqrUOKsVW9ZhySGoQp0h0
	eSllEDxy97M/P3eGSEeQYllLiYPDdxT1K7xSc/
X-Google-Smtp-Source: AGHT+IHZrqQ5DqfZ16gBI98cMnB7rLak+VC5QAZuKSWIn9VXdVUS6Hea1R/TrTtXcwZYS6rRHIjonA==
X-Received: by 2002:a17:907:96a4:b0:b04:aadd:b8d7 with SMTP id a640c23a62f3a-b72e0285d38mr1111681266b.13.1762862465664;
        Tue, 11 Nov 2025 04:01:05 -0800 (PST)
Received: from SMW024614.wbi.nxp.com ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf407a01sm1340707466b.22.2025.11.11.04.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 04:01:05 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
Date: Tue, 11 Nov 2025 04:00:21 -0800
Message-ID: <20251111120022.696-3-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111120022.696-1-laurentiumihalcea111@gmail.com>
References: <20251111120022.696-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Change the programming model of the "aips5" node to allow configuring
the security-related registers exposed by the AIPSTZ5 bridge. Without
this, masters such as the HIFI4 DSP will have their access to the
peripherals connected to the bridge denied after power cycling the
AUDIOMIX domain.

Co-developed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 7ab321af9e15..426c11853d84 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1428,12 +1428,14 @@ eqos: ethernet@30bf0000 {
 			};
 		};
 
-		aips5: bus@30c00000 {
-			compatible = "fsl,aips-bus", "simple-bus";
-			reg = <0x30c00000 0x400000>;
+		aips5: bus@30df0000 {
+			compatible = "fsl,imx8mp-aipstz";
+			reg = <0x30df0000 0x10000>;
+			power-domains = <&pgc_audio>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges;
+			#access-controller-cells = <3>;
+			ranges = <0x30c00000 0x30c00000 0x400000>;
 
 			spba-bus@30c00000 {
 				compatible = "fsl,spba-bus", "simple-bus";
-- 
2.43.0


