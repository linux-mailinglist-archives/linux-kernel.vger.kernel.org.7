Return-Path: <linux-kernel+bounces-869427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1BDC07DCB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402723B411A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67F136B960;
	Fri, 24 Oct 2025 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="l57nNXDl"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2200A36A606
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333358; cv=none; b=j83VZReDYH12l4AmqQIaCCd807do2lnMjASC+QQSv05PNbZHHCydsmsR6C2WV8UNyOM/uoNXwGzEizRbzLNVxUJEEQDDWep396qwEQU4YO2NzuaNBpduff2zBha+j1Oq40EH4Qy7T+TCTGpXjd4F8CbqZcF0VyAO4Bc50Hkqd4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333358; c=relaxed/simple;
	bh=nMCY7tqu98IJzjclxpQyavU8U1FNBOGWdu3yx7Z5f6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=daGm/QjPn7ujFguIbC91CQgB5nrLgbvl8zXCTA0mWxehluKorlzlKGoI9gipRNaqZvCHpFO/xgXIv/aGpj4XJ54FK9EwgQy4JeI/EIWrhYZR/f67f7EY5upU6OZ6NvuXf2p4ph+fLIH3acceOH5yO8TCTSO+z61jEl23H8GdnPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=l57nNXDl; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-430b45ba0e4so12346035ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761333356; x=1761938156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOGEEJh/33D603wteGhrxPA31YJMUwUVVAtQyDoqnvQ=;
        b=l57nNXDl7bnjlngt9goGzF6apwW/CBG/7s5RfSvAHyIXvPXyrwxoiXJ8uH+Se+euWK
         lXt9P6YZD2ADrBcur1gr9Kudqy5NidCj8CnRsJJMQiX5lT/azUiupbWk/8UBwXMhymsb
         G4VPa0xk6dQSiBd7BcUaTvacaWNnxItESfbf7J8ndoBX8HNzh7xu+U2oAycAN8J3in7C
         70lZOddK06LrdJDWhwFhSJG25ynAgARhgN0z6XOWmvfYzNX1K4iFfIP3pNHgkYnvgx5W
         j57LBK/YhJEqqOlnYCSt4PkMDXVP8+3veJT9UtwmTHqOmjmEekh2ZfQ7Z8H0PQ882iCF
         KPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333356; x=1761938156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOGEEJh/33D603wteGhrxPA31YJMUwUVVAtQyDoqnvQ=;
        b=hVH5bfMdyFLFr34Hpr51jVR+eZZi4JhFOGsQSgusROsBNqZMPU2GVWAvxGkGfbG5cx
         u7NNqvse4//jq7mhhBfaQhOShrSOQJwY3zLPsO5AvhnsfKLFqheN12qijzzQBAiXsP6Q
         5KtD7GTlTw9QVrPWv+9CeVq9R5L2Dnv0s3fAImBWxVOYpSE6dBncgqYfrW4UbaSjRKdX
         WmoxrHscmZnhJNmwB17eJHdWdWLYywMAVhn+TMJp9Np1qQr8CaOjjRCncTcGFK2ZQTzy
         C0kLv68pyx5dg0F5eDSqEbSZxV4dKPN3TMU0agzh7yAACmXQdglcI3Fh4I7TTernETKl
         /CHA==
X-Forwarded-Encrypted: i=1; AJvYcCVZyMmpKVwrE68RADUIV7ihcnDjG557q8Iom9+m4gglg805O9SNP+MMf7x8gftrLPLqFr6yI/9yWrTK0Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTg3qLzX2CF+Eg4wtJTPscC9kAkyMVYgniXRrHBypufbR33jIh
	CnchIu8sBenoD5gJLuHJDfQVDwWKrJb0kFam/cttAKVHQsRSN3FdlH1AtPrYOcYOVYM=
X-Gm-Gg: ASbGnctscnnnLdPYHuz0HXOy3E9fQoTf4uJgOczaRfuO2/KcckSZld+o4PGY2e6wKtk
	pf/ae4EyymxmwafVR1lW2htgqOjzOZ43scuQ31YVDxqpRSibPm7pCSHfFU1qs9S+n2rk6ydeX0c
	GuFel+mdp5tQX1qVzQ6mFKoK05B2hmtKooz68WHZN0gH+CqCKwvMBNNpTTSFI4o3uaoX1x8IM4P
	IxsCFI5r48WWjZCRgOBAxt0POs/qX60u7mHcaTUIQhfAwnKQl3tLWQObrRUNH8V44791xM8Qc4B
	Z8kTtCuCYji0UqNQMJkC8zN3Ox99+vjQTuOKaua9RVK6LTwuau8aOjwoY2iXUhJrj7jMcfcAYVV
	J8xE2+lc4wuXHZf0zL2xNdx+qRwWPgjPkwuDWKdIDfMC7B2KOdc4FN1t6Tx0vCOfOPgG5k3FJ1B
	GpHeCrGmj7kwbPBH4hEcCuuwA231cWxveKwQr+klBQekFge6NWA/b3Gg==
X-Google-Smtp-Source: AGHT+IFDogyL6cWcfQwc3FAklbFwL0iLqDuDqQppxCvEgv6jdMEMsj7R+FgIMqftII9RxRpxH7qsMg==
X-Received: by 2002:a05:6e02:3f04:b0:430:c49d:750c with SMTP id e9e14a558f8ab-431ebed79admr44368525ab.27.1761333356161;
        Fri, 24 Oct 2025 12:15:56 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5abb7fdb7c7sm2427824173.44.2025.10.24.12.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:15:55 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 1/9] dt-bindings: spi: fsl-qspi: support SpacemiT K1
Date: Fri, 24 Oct 2025 14:15:41 -0500
Message-ID: <20251024191550.194946-2-elder@riscstar.com>
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

Add the SpacemiT K1 SoC QSPI IP to the list of supported hardware.  This
is the first non-Freescale device represented here.  It has a nearly
identidal register set, and this binding correctly describes the hardware.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
v3: - Added Acked-by from Conor Dooley
    - Added Reviewed-by from Frank Li

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
2.48.1


