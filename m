Return-Path: <linux-kernel+bounces-879195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C01C227F9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A418350B70
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85673332EDC;
	Thu, 30 Oct 2025 22:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="aN4EaZGL"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FA0339710
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761861797; cv=none; b=Fgocd6FtLJf8cliJgd9nsgnChXERnha004zavq5megKyWnTBqpsdIs6x9zexZjWor1yoiFQJGTH0buzSVj4T9xTRgSLDI3grIYg1mwIuTjVgOJSrSmxeqETMHcsTlJ8PhefNsVbNL31mxsVSlp7g7+3qf9U+tAS6jmAWOiFJay0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761861797; c=relaxed/simple;
	bh=QBekHRPzqKsUbKsby283fcZkrUPlP9R23yy3sAWgrIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJ9mP6gE2dhz/SxFVSyBn/BRBVyweSM7HGB3yQdWbrtaOyCPz1BCw7ORlQIacvdJNffXil0UjJINzYiF4zXjLpF0QmHxw/O96//i2UbO6PPK1zB0OGBWGrmZOfkcFz+vx1YDlJcJ4tF2xr9z1RVauaIA9Bd3QHiCYQPrSCY6YcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=aN4EaZGL; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-92790f12293so68910039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761861795; x=1762466595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIkVe+mugmsixDMdOtfVXmcZx3cul0N4BhQxpoGzDAo=;
        b=aN4EaZGLCOP0FcCl1Wn08SK8+zgemiVtVgNaepx/BVJcITcMIiuWAgwyxHq7nbJLb8
         St3676w980zx/czm9P3bh6ksEC0+JpsnDGZexUHrYoKTbHhkHTRtafynXbapMO3JuvOK
         j1Xd5F288MxKUZxLdg4BMSGXj6OYsT0NLI3w2uDsiHp5x6gJmm6NK+BqD2NCjz9mlA9t
         DMDDBtPsLQ9HYOIRzzlnD9R/rHMh4lqmMRI4cQfhi17M7ZLlPJTAK4C4m69jtPKtNEiF
         NtYG/VU1Cw+RcK4XRrG6xjjNDRktMEY7obCurf7Hrr7Hc/aLbllIDBucKs936dsiWWsz
         Pdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761861795; x=1762466595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIkVe+mugmsixDMdOtfVXmcZx3cul0N4BhQxpoGzDAo=;
        b=aV3TUvfzRxTsV2dQ6InGiaJmkbHMOKXirV2jAFdNFiPo3eyEngITTZIpoNINuO8ZAA
         LrQ/oayKYWy/nQIvKpL+LoqeO3Pwtw84kwNpXrVH6vLLzQgj4CNAKYs24HSSzUFaGAvr
         u5JXIQggBMEn1uX5DrkjFOqZH/HnBh1MDP6D7BgIeUbwaKQLVwDl3t6Ol5SO5xcBvEHr
         rrvEU+TH/9EifobBTbnekxT0J13fXR5dO6Rg2zOzOuILxdmd1H89FMeCVmsrKtXmdfoT
         yizO7Kvu//ItROVPbJWy5wPAarvKGQL+ovB+490NEvTMvKIxoO4qCUzVoghpv/c/swkX
         mQng==
X-Forwarded-Encrypted: i=1; AJvYcCXTq0W2zfij1MgiTNKnSCMz9ymhPMtgtSnGnp0s+pjYzoaWETvobrYOoHz6MAzfxjtPygLc9BKsn4YORbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqZwzogZaUQIa+3cGyQIxlaPoyouKFWtTNcXTpitxzAwZR9ofI
	53Pcq8tCXsptvNOCuExs+sMrlDk6ignhgsa242Gr+1lB0v2DllxIjbYps5LkmwX7ThI=
X-Gm-Gg: ASbGncvf4PrNHuGAkGn0/4yV0cXnAEptGk6yfiI+Mha4hKwagdMv+nB2Hw3Az/QhyQl
	UWZ7dstdCz9jAptOB749gtqo7Qo+K1caQgEqHIO4le5YUs4/5yT7Rhf8f86hCXWdZdAiZTaaUf4
	twQMu6ebtbPIcT677Z1jOMwoMCmebxmlDPpWksRK+v0+cEorRkNkj5SgMZ5YQoDVrYwque1QUn4
	iX8yxG3zzRrsPBDnmsYyPZfvJVTZGa095y4W2BX9TrxNWEkEL5U8ziXEZ87pcLYad7qFImWKhWk
	22/3oZbMvr9qC3zu/kmRz8pPPRguFI2bjcy9J8Bpcnm1ABKO0OfhZ0EJsY1hsTHnbuANgc1UhVO
	LF0Jh9M83hkkzWo8RcwN7ZNObMAo9sp0bNn+abdzp3Y2SGHzDXTlPvI4BMXtjWJaoVAQPqZkBK/
	01YqbTLNON+oxQi4mnoiXu8EqeKE4GFLOCkMoEFgk7hnLzaNoyYZcs9A==
X-Google-Smtp-Source: AGHT+IEzkYNTEpto3uIRSZZUgywIjzKs10kSZ3Mcmn0s8szOm71bDrPz0GaeszZYMuu8RaE0By5r4Q==
X-Received: by 2002:a05:6602:2c01:b0:940:d7cb:139a with SMTP id ca18e2360f4ac-948228fff16mr274845939f.7.1761861795055;
        Thu, 30 Oct 2025 15:03:15 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94359efe149sm604118039f.13.2025.10.30.15.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 15:03:14 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: dlan@gentoo.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/7] riscv: dts: spacemit: add a PCIe regulator
Date: Thu, 30 Oct 2025 17:02:57 -0500
Message-ID: <20251030220259.1063792-7-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251030220259.1063792-1-elder@riscstar.com>
References: <20251030220259.1063792-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a 3.3v fixed voltage regulator to be used by PCIe on the
Banana Pi BPI-F3.  On this platform, this regulator is always on.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 33ca816bfd4b3..a269c2cca3ac9 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -33,6 +33,14 @@ led1 {
 		};
 	};
 
+	pcie_vcc_3v3: pcie-vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "PCIE_VCC3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
 	reg_dc_in: dc-in-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_in_12v";
-- 
2.48.1


