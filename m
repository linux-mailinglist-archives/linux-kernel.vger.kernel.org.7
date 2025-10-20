Return-Path: <linux-kernel+bounces-861367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 539F1BF2898
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F3A6F346DA6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E953321DB;
	Mon, 20 Oct 2025 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="CvyYMbEZ"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C093321A8
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979130; cv=none; b=jqB2BlcFyy0/tkyVwAbEwMRMRtDHvres9w0ejTQYO22iPUkq1tkicOax+ton/vw0bLIp37P+Hc9ZdBbNJfyQjiJ2Ntj6MGISeDkuLQktNZdUbKuq8ItN/7g9Yo4GMte1FJw6zrLgxSQZcl6krZtGkKRYspeBOisT2v0PCAyI8/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979130; c=relaxed/simple;
	bh=CUgs8UQHsU0y7NsqM2mOtZAFUD3SjpR8SKV+TPlaJpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/y4PLnNR8sfga90swI5AwZdRDZo/XoQt0oWt2rl2c7NQVlmsNw9XW7LXEp8lqSze/3uCAeOEWpz80EPzblBWJ7j4MN7uEeaPhXYzlusnSJb1BGG7veqictgDPJzaGBbsUXxlVtBkoOovaeQECt48eu9FVKwUoqXJYx+vpyyRtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=CvyYMbEZ; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-93e9b5bafa5so75045439f.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760979128; x=1761583928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTOagx7mvvjlab8+UNiNCbZ7xK3rTGi2vCmorF9bL6Q=;
        b=CvyYMbEZYtlWuQeKzJwv6h6QDFOjjym+Z/iB/0jQ6XfWdseIZtU50EWgK+Zb5+kvfp
         NFhFknx/YGJOAotOfOgEDCYyF7WGZHBJJJ4iYbeC+aD9YNjizo6F0/knpylAnFxt2Rd/
         jvHeBD272XLcZH6A+gAmvIV/nqqRlhsUhzsBz8dv5qSppUCMFBQ7mkCeP29zEYLu8vMy
         zUWO1Y4BbI1/lF6ewHjDCuf2wpbyuJo7ZZQ9cvn7PrDGwGuY3kseUyilvCOKw32zItQP
         T5yiOVE093loRDy9V3d7iLOkpKveD4XKfOzUBxHqga84luMpj8s2Z8+sTJT/cLmm7vbc
         XZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979128; x=1761583928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTOagx7mvvjlab8+UNiNCbZ7xK3rTGi2vCmorF9bL6Q=;
        b=WLWo4IkEabWi1t330Khe8SoUHj5GsQXu/1ZCLYj5Fo168AcG02CjXtX4tP2KN7Lo1I
         kOVz/qjNJiR9J/4wiN86nfcm3qELldxFqKo3KevixqZOUZpqNQDVhqi2S32m0yHpPCwy
         g1de15BaTs8ucFLFOP9kq0TyNSDGtnVszM8brZsJxCgfX03oi7/FG6zz9PuPAW9w4Nym
         T8+zw4aB/V286w+AfhpOokKD7svELuMiEltcQ4NKZZYN7bPXNdLZaJzEBAKmWCz+pPjS
         3EcCxWEZuYq16QDxbwxjYNv4jQRdLVdmcosrMQrdyHO33PBz79NuE+bBC4H6WPPppVMO
         PRHA==
X-Forwarded-Encrypted: i=1; AJvYcCXXwpsoggnjQ+V0HbLCCf2MydjOR0TtR9+uiQuHxO8oEAt32XndSW5XMV333HK4la7akhXG6Vi0QkkBe9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNQGz6r0NPqWttCEU/ozwDJhThJCDrbPna11yXQlYAvsvLBAqX
	fKcGSqJcHO4Qi8EpUTtdCaGmVffx+Q2DsYD4WrtatokFQlOuDr1h+hvMDLEVdcjzdC4=
X-Gm-Gg: ASbGncvXqrzWCwECsne5wtjpZ7H2LEhwwPWigojJSD3+wso4vt98byy2h5v4xIXIp3Y
	CdgKAsmOFPyZHikf1WieYDXsmQyUZeAOkONpxHZfGb7qTQbvc+raDyocr4bD+AGhPH9mMMpaPZw
	C36l6OhXqAUGdAL3fTbdjdMVG/tQpbGl1lzt5mCfHFWEoovhE1HpI3TK6IsPGm7qg/qpAswRtvT
	0jnF/0u3tqO621m7UI1A2z9GiJLhlsACVZ82q0AszKZ2F3AVJqr2SPwS2AObKcbTQTBUmg54BXL
	PYMitKO1+JwqxnX7zwof1YD5VASRdkj5d0/55FLE94Qh0Pr/diqvmVnNBk3MzsrCEo7E5f7c/1x
	Qxp0c4NaNyvPqJoVOrhZ1YzvZSSMXvqUOvvqryPw7jbOxoImJrVtCK9s5pxP/E9Sqe2t5gE/FMJ
	Ght5BxLgKmw93tPLIC2RsIvscsBzsxHFYLA2Z6iR6/cGC6htOpdsuJcA==
X-Google-Smtp-Source: AGHT+IHY1lIklOLT8YiqHf9RVDuR1yd+ypvubmcb+paaE3pfP/eJoAmmNPnDVT26Haw2R/FsMZwu/A==
X-Received: by 2002:a05:6e02:2301:b0:424:7ef5:aeb with SMTP id e9e14a558f8ab-430c526b27fmr218825965ab.17.1760979127806;
        Mon, 20 Oct 2025 09:52:07 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9799428sm3116783173.63.2025.10.20.09.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:52:07 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	dlan@gentoo.org
Cc: guodong@riscstar.com,
	emil.renner.berthing@canonical.com,
	geert+renesas@glider.be,
	fustini@kernel.org,
	ben717@andestech.com,
	apatel@ventanamicro.com,
	joel@jms.id.au,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] riscv: defconfig: enable SPI_FSL_QUADSPI as a module
Date: Mon, 20 Oct 2025 11:51:51 -0500
Message-ID: <20251020165152.666221-9-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251020165152.666221-1-elder@riscstar.com>
References: <20251020165152.666221-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SpacemiT K1 SoC QSPI IP uses the Freescale driver.  Enable it
as a module in the default kernel configuration for RISC-V.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
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


