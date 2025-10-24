Return-Path: <linux-kernel+bounces-869436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9015C07E17
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3353BA7DA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509FB28852E;
	Fri, 24 Oct 2025 19:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ATL8AD9N"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DF4248F51
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333368; cv=none; b=jsdC0tgU4pUtxCvLrFLK0FBQ7ZHdAhwK3QI4HmhwO8vZ2cuQx29P8hIMdhty8OKJh/2YR0VgVgmyURz8psGpol8uJGlpyPefI0gilmo6Idkoy+su0b3UHa1euk4qKO0IRvnaJqy8TF/QA6uW9TvjnkLGi0CFQ1z3+zc8ljvC9mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333368; c=relaxed/simple;
	bh=lKSmjSpemcxjKYDJlIwBcL2l1NdfmU8yXIU0N414Hzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyI06pPSeyQZ+2GHdlw/ahLhy4523+Kgp3K4/K0NwZ4D8pvKKsGfN+eaEYs+gHnMS/1rFt6khIy/qVaAtOzqnCQ+OXqG83+dPCLUJIIpnb/VZLPuCFE9LCsc6J+YqfDYhclHHEF51Vdye5SAi5F1gf0pmqjemhH9s4bK+7CrU9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ATL8AD9N; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-430ca4647c7so11745795ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761333366; x=1761938166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqAg+X5UevD0Vc5aVJRCRg1w9Ar1312tYZnooFCReg4=;
        b=ATL8AD9NDkiBubNDORmo8uhysCvW0LCZwmS+6rqUUQPYm+3Rbp0FUHjejQvDmlk1Te
         1uOb3Zjy/H9hxJmyPKjBUfXtyTA4Hc3cn00umAyZgrjZgqq4Ma397m/AeiM6fxiN/IMw
         p99UNe6xhUOKtyA0iD7rl8d2YuyhDtrYLyJPkSV8fN9tlyZ7u/V9a9oeSvAUOb4XBo3p
         NGN2IVSx2OtjaC06oNEQIKlAo9Jj2AF3yEDzdkCV6u81P5I2mJaS52Bl4rzhEbusUlMp
         GSggn+Zte47nYs9h+uINzNNZbWtVU49194ZgrfT9T9Ngz+VAqHQTIijTlR+Vto5l6GvN
         P5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333366; x=1761938166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqAg+X5UevD0Vc5aVJRCRg1w9Ar1312tYZnooFCReg4=;
        b=WtbmDqhOKqMhwgchfFxteblYLxlFsHj2NuubmrQ2WQgUAVMv/D3wc9rLOPMN6T4ax8
         fTSecwgxQjKn5An49ka8XMZG51AQfvKaPNi55ghMl1KpkEzTJjJMqilwwI3sjL75j4pP
         YUKCf5WGqKG/acKdj031pQrWMifTfaZ8bMeT67/YcvINaxz7Wjx5Kjqj0vAOYugNn3aV
         iXFdUNFzjWrOSiD4HmgEO/FhcgKeDRD8K0H76inK0jSoStm8GbhtAHc6SkYbQM8snShW
         +UEzJ/ZX5CsOMJrpK9zGNHab1rgkB6MlOepOHn7+EoRpu08cqtx2wskcgTpV/wUbuZ8o
         zmwg==
X-Forwarded-Encrypted: i=1; AJvYcCULoelChwKBwDJEzpViRV0LXxNDrsXyc10rZHiW/y/nmqQm5HXB/hpOv3jma3V1YI2nHnb+YNfc/2rWKhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf+RNxELhuvGM+7d9T7/k6cE2Sm+nc5OKRPIFlW5VVGNHEklPD
	EIrdHnLAib0l7436ln//52eauKc4bFSmJoU6IY+7IB7jVC4GgXCWWCa+qu15K9rekcQ=
X-Gm-Gg: ASbGncsMePley+TDxrdsnPtXfj9pvUWUFKf5ey/LCH3nZWA0po+hwnfFP9TdQMIg24X
	JM+Rfjc8Mu1v97OWY2QXwRjm9S9bp3GzlTZMdeKVwv6z2JK9xmUIaDib7S3YvFP6YtGE84MW1AN
	M804H1jO0yKlmoIPXl4Ri/7R4vWrMqeuaMsh/63Xj4SF5qJC9ThA+q0osiKySKTE1oMychiYdga
	TSPCPijHnRrW83g6xbcG1P3DdBretNZKnP+n0UWhHc9V0G8t3ibVTP2AFnFgUfYE8r42lGI0L0D
	UmfWOlRmkpT0YkdxvPQ06sUsBEAiXgjABONFA1IWRWaL+39v7QZeUYfSBjfXH5G7lr2DdAGPIxj
	gnNW3je/W/mZ25zhc1cU5TvsYPaAlxUua1G7foSanAhrovRLvoIIkBNYHxH3hLfzv6U1qYLccXa
	5SjXjuWwLJkDxo1yHfbJ0xFtMTjITEERlDjaXlAOaMWaQ=
X-Google-Smtp-Source: AGHT+IH0HEa/fKZomSiQ3WIIsMrU8mAuEWxrS7c1HtLkD8Jfco189Px8SbGm7/QbmcudIijpZWQVBA==
X-Received: by 2002:a05:6e02:3e06:b0:430:b147:3b70 with SMTP id e9e14a558f8ab-430c524ce8amr390406425ab.6.1761333365763;
        Fri, 24 Oct 2025 12:16:05 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5abb7fdb7c7sm2427824173.44.2025.10.24.12.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:16:04 -0700 (PDT)
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
Subject: [PATCH v3 9/9] riscv: defconfig: enable SPI_FSL_QUADSPI as a module
Date: Fri, 24 Oct 2025 14:15:49 -0500
Message-ID: <20251024191550.194946-10-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251024191550.194946-1-elder@riscstar.com>
References: <20251024191550.194946-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SpacemiT K1 SoC QSPI IP uses the Freescale driver.  Enable it as a
module in the default kernel configuration for RISC-V.

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


