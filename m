Return-Path: <linux-kernel+bounces-871687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B523C0E161
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423693AC7DF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFD530506D;
	Mon, 27 Oct 2025 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="dXdfIu8E"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87701E832A
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571832; cv=none; b=kITjIZ1/U3yG0dsiRuTxf4WAKfBc+ChT80szhxa8qggQIrC+9IqBBGME6MFn2hMUmKSeJGkBgG5GPvfik1meqeWAgaLifX0cqVANsHZLunGknygRZ2S1i6m9PT24KY0aHR1mkRq8HQns/keg7fOPtYC4rpdXBEyzIqPlFEdlqEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571832; c=relaxed/simple;
	bh=KjHPW4Jl8rerw+k8gIt95lEa+TqboQQRPSrP944ua6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERMzo9JyvgVE+/ZvxZqRIouHZlS/d9OAGgTMjyTFyP9oCsLZ6fNeQ/V/4fTyzioTrXzuqdCNrvcS8E/LVqOYogcCRAnJ1I3hNEQZVonG2kzHGFO2CDKT/joJRQW4tPE+s2ZiAZ4g3PY3yv04TuoH9IPrLv+tILbJ1YU4vOF6ZDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=dXdfIu8E; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-430e6ac6bccso29809095ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761571830; x=1762176630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rM+v0dmpFWaYbb7BtTqQgtL0zt31yeqvCe7/rJYcYhc=;
        b=dXdfIu8EAfEN+kk8l8xK9YEWFrCfPt/VxJuVcauH6ZWugaQUPfd8yWp7A4XSZCYoKv
         MDDVOLkmyaw9VWUFR63AyhsYFDwAW6iEXeS3nvHLBD4eyR8S2DCbm1DB47qXPF6h63wc
         hLlkgqe4KRcYvLpXQSx37vLA1G3MgMEjXS+IyILiCm59AyTo0HO1VRcvk1zxBaaHo/0y
         RGX57ktjcY+gQMAIfUl/VYlxZTurssXpgMW1WZ2GyxnRa26DQQPjCDPXajYystzWLlpe
         AhbqEBeIuZ4OVr1oHUBCJ+qeEJ7BTro29Yyk/WLb5H4OfZ7V5Md7II+Ao6vJbeU7PSH9
         CbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571830; x=1762176630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rM+v0dmpFWaYbb7BtTqQgtL0zt31yeqvCe7/rJYcYhc=;
        b=Roncts2leeIzeZB+p8UTuy219M4XD+LLHNzC5JYVVXgHGFWlQJKF3Rh6WkYiB0z7h0
         M97JvaXNKOS0hIsz6kPNNcrsp7HCYxFxL0VoomAyuCKu2ORtdf85lLnVP4+Sv3U/xBcs
         diriVMkvXr4hi0LryL0YRmrHhyPl0dM1xN7+PWttpHiiFBHiCfyxXXYgeNsX/EX9U+f6
         6xZI//Ugsz42PuNwdA1WpOzUJGtZTT5G7DIziGcr27MVoZUtjJNGNeoZhGzcF4nU3iiR
         cKBuIFyMsUDeTV1G8Dkzsp41ECzL7pKz1jzedIJRSM96GWg46nOxPGiD0y+1IJY4LgKX
         o70A==
X-Forwarded-Encrypted: i=1; AJvYcCUUnDTLFzWd4C9S8xX9tcWt0psBl12s7d1E6ocLjw0lmtfEmX6cjPnzfddI5cEy/pH61WA09Kbcd4RuQ3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOxdvFfZYA/SE1/WGBZRRd91o/j2FVMXZanrBQ/AqZipmKtC2a
	mCQSlatTNttaKDSpKRrV6pTEzDltj7Tc44UM5gZ8lY8Gcc3UsGraSYZn3du1F0BAbZo=
X-Gm-Gg: ASbGnctOWna6LYIssZzof0SyZ1GrLgeGFGDiZjPj8iy6mPUmppIEN23H9e/3uby4p9E
	kwcWlIbZE6g5LWQfrsC5cfBd9zBgwg4yQICnNuYQ2qfEiC39jq/frdKCFasuizAvcxKIet4EWg4
	a3DBA95/ggkpVX06c/HmGBSjX79nbv/c7Qmvc8jNSVsHvE5mayJ8e5DNR7tD5MKW5yuJ6AJ2s/Z
	kxvJiS2QsDx0fCUiaMnrbB224A42H8D6h9yKozBBrkj961hSZmlnPDsAOvAYFrgAPPSE1KvEfaa
	sku6bhW/saPSzATfaq+kXNzIe3VQiF4CaI2TNEyuj9aDwKD3Qvn3UIALYBTTUlj+Mqj8Fq73FHP
	VUhuy6FvEWdDkvz6U4HxeaDGZE4nTfnN20waYU440ANx7IYDlbNz+FICYHZURKmGNsfi1oai0fI
	Y4ialx+bsbLBPQAivcxklHZ0Q73dXvbN16ewaopKhMlloiyTldsWB1OQ==
X-Google-Smtp-Source: AGHT+IEI0FEaFBYedF5aHL03pfHWLVmNoFWC+ao4vByuZRBexVAwImaGLjB2RwJa8efRgO5ykDumOw==
X-Received: by 2002:a05:6e02:260f:b0:430:cafc:df6a with SMTP id e9e14a558f8ab-431eb6a12e8mr145266905ab.15.1761571829935;
        Mon, 27 Oct 2025 06:30:29 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea78e2fd4sm3093057173.26.2025.10.27.06.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:30:29 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	conor.dooley@microchip.com,
	dlan@gentoo.org
Cc: Frank.li@nxp.com,
	guodong@riscstar.com,
	fustini@kernel.org,
	geert+renesas@glider.be,
	cyy@cyyself.name,
	heylenay@4d2.org,
	apatel@ventanamicro.com,
	joel@jms.id.au,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 9/9] riscv: defconfig: enable SPI_FSL_QUADSPI as a module
Date: Mon, 27 Oct 2025 08:30:07 -0500
Message-ID: <20251027133008.360237-10-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251027133008.360237-1-elder@riscstar.com>
References: <20251027133008.360237-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SpacemiT K1 SoC QSPI IP uses the Freescale driver.  Enable it as a
module in the default kernel configuration for RISC-V.

Acked-by: Paul Walmsley <pjw@kernel.org>  # for arch/riscv
Signed-off-by: Alex Elder <elder@riscstar.com>
---
v4: - Added Paul Walmsley's Acked-by on patch 9

 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index fc2725cbca187..48afe30d42e88 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -158,6 +158,7 @@ CONFIG_I2C_DESIGNWARE_CORE=y
 CONFIG_I2C_MV64XXX=m
 CONFIG_SPI=y
 CONFIG_SPI_CADENCE_QUADSPI=m
+CONFIG_SPI_FSL_QUADSPI=m
 CONFIG_SPI_PL022=m
 CONFIG_SPI_SIFIVE=y
 CONFIG_SPI_SUN6I=y
-- 
2.48.1


