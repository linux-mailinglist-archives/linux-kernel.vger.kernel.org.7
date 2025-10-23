Return-Path: <linux-kernel+bounces-867512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28468C02D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2511A67C08
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D343334B19C;
	Thu, 23 Oct 2025 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="RDd69FSh"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6613934B196
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242370; cv=none; b=aFA+48hxy5HSmThomGKFZaYkqsQqjeu+KBDMHbwkYKQS7bVRYKRnL/ARcvxyK9EwvJmaNBWJrFC/LQSUAkyKl5K+CRBloRBzLbGDF/28ngz0kOCKK5mJ/sedLZO2Vaaf7lttsr/jkr/O8BKjVOEdOP9dymkmivfYe7OQOgfFpB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242370; c=relaxed/simple;
	bh=a/X1Acv0a0Io7YPwnyOgCxxAkklMU8dT+67o6Oa6kn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKQxFn5wHI00S5VmdF8gdqiPuvBdtwAggY7rONVv/Kko9srk0256qv+L+YQakd3A+CGpnXz+mbPqfWPsGmvl0Au0gelHZNJzPXObrFE/Uc6zxxdK8oduQL9X3lHv6BLSLT31Ff9WMv+dfuy2bOA1RlYWZ/DPDEYprjOIL+cB+RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=RDd69FSh; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-780fc3b181aso788340b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761242367; x=1761847167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfBpxcQetznup7hF07KUJDBVrurA0aaR62AdWj47guE=;
        b=RDd69FSh4HYck4WE9ZLnqBevWz9FwNRjAk6eh71USfTzfXGiyLz0Q9onBpU3W103tV
         BlV6pp424JLmMkoQhtYF74nEKvoTv+ZDMJd4BZY57Xs1Fzko32nxn7xBSxYPVKfP82+R
         n/boSC07SjkJw0pKxAUbBObGoijhaxYP1X+CBf3ZuyIjP0dqaKISLviIVouO0CrMfGcC
         kKZOr0VxYFT7S6/Z8fLt6uyzQJNOSlLkTB28kQuWAuxqHihCSKLShTsHDKFswSdRyO8F
         2ZatKHhLQZ+EhVSGbcC0SckqxceYOVnKoIpCpQ3PDmet2atmg97CMPv/mgVSzQvVCQmQ
         gvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242367; x=1761847167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfBpxcQetznup7hF07KUJDBVrurA0aaR62AdWj47guE=;
        b=YOosQMIrdfJiOeer256WWtribZjRnMDHJpIQ09pCpxt/vZ+rIi0IM9gQ2xrR0FoySD
         itaHNHXVUhhAT5PaeKlEa8YdFA/aNW6hyYpOvGmJaeECg2biXvc3g5EAKknJBBbd4aFe
         QoUGxCZl8ZydaYdDK9NAEeUeeCdBItxjdixqKZqZNzlqpvwmZK+E+wjeXWnCxx6IuddX
         ExF1MgM3HYLoDx4i6KsMQ7NBpF/tSRtg1NeNWei5c0nNk0+4EupKaWbDnPQSs3lFwKAW
         781d85r1RsKXtJmoFLy0uiR3lR8OvN0azexGIcKH+I0XcikS4n7M5fqN77rBS0o2ak/r
         01pg==
X-Forwarded-Encrypted: i=1; AJvYcCUHnnfAmrV+pFeMO631lAEoXnHEehzZ/puQVh6NOa7jWvg9OLnixDvnNRVvd6bIyFtazh470oT/SS0lXoc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn+p1QeWb5E7oiduV9IinY/zrhruU2islGePqc8mGCg6wKU5GD
	8uybPTJTtU5uUkU8p4YPCMg5xFSCW7e5tHRt3eUBrFJPtMYaliU7KKYh+UGGpisvIsH+N0y7URM
	6rV+i1rQ=
X-Gm-Gg: ASbGnctJgoocjPuIFWZVXJV4S9LP2o0ASmrM+ZHJtIzPXip0lVUARfrCgFcpdHnl9fG
	9NuPPIZ1J/QHg48fa1U9ziUCu/68XiQL4Rluh8RU2LZ2kzmKNpUDbfOyaiJQdjya+EfVI6b/jmq
	4Cil5fndCXR89OEtON+U2Iqs9rHR8OiYw6mQsyuN+0YVAkb+1jfVC9jh2K+jGqnTwMFavrLw9wu
	9j6sR+UfJ1j5Sa0BYPuE3KQcrz1xFfeV6jFqZoRNbb7A+z6C6xq3HdvacluHDAdcbiA3Su/j7wT
	j1+kL7AXLPh1ZhcpGaWa3F6SgXJBHyfHGEX9W9ZrALdH4AxPaRifTJDhCf2ur20Jb030J8J+aiW
	j6F2PszRN4TBJPcUxng5qVKGD+ev4QSEQ5UIudGfkfVQnPHaDzcJO4DNtCS1iSXDQE2aGVlN0nX
	iDUL1OMsxc0k9LzWOgzLLT5Vlb+KA8nlV5DA==
X-Google-Smtp-Source: AGHT+IEiskDsftPBzROd2WKzvcPRxdNUDdrslLqgJ10XkgDdwMsWJwp/kE4fHkTeBllQGtyODL0OHQ==
X-Received: by 2002:a17:90b:4a47:b0:339:9a71:efd8 with SMTP id 98e67ed59e1d1-33fafc8fd43mr4507074a91.37.1761242366629;
        Thu, 23 Oct 2025 10:59:26 -0700 (PDT)
Received: from zoltan.localdomain ([208.115.86.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223d1265sm6447431a91.3.2025.10.23.10.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:59:26 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	han.xu@nxp.com,
	broonie@kernel.org
Cc: dlan@gentoo.org,
	Frank.li@nxp.com,
	guodong@riscstar.com,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] dt-bindings: spi: fsl-qspi: support SpacemiT K1
Date: Thu, 23 Oct 2025 12:59:13 -0500
Message-ID: <20251023175922.528868-2-elder@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023175922.528868-1-elder@riscstar.com>
References: <20251023175922.528868-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the SpacemiT K1 SoC QSPI IP to the list of supported hardware.  This
is the first non-Freescale device represented here.  It has a nearly
identidal register set, and this binding correctly describes the hardware.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v2: - Point out that this is the first non-Freescale device used here

 Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
index f2dd20370dbb3..5e6aff1bc2ed3 100644
--- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
@@ -22,6 +22,7 @@ properties:
           - fsl,imx6ul-qspi
           - fsl,ls1021a-qspi
           - fsl,ls2080a-qspi
+          - spacemit,k1-qspi
       - items:
           - enum:
               - fsl,ls1043a-qspi
-- 
2.43.0


