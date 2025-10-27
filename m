Return-Path: <linux-kernel+bounces-871678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678BBC0E0E3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D78CD4071DE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F771E832A;
	Mon, 27 Oct 2025 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="s0V4aX5f"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FDB1F3B8A
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571818; cv=none; b=pl2SlkJob8ye8CCOFuetmssJMJILkbySA1oIAMbWzaObTJg/lW2kY7/ma/Lf1LCX/xW4wnYA00dKcWTUvRnrvIYM4v5J5w12hVhZo7jwDB1v1TeFRycqy5p9p/BMkp5NY1pZCXYTrDQSxkbEBmdQlLE5ONMl/ZQ81gaf90yz+5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571818; c=relaxed/simple;
	bh=r/29WdZEJajnpJ//0j5XUaaOQFUOGpajFSIL6DbCOUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9ZS33j2snU9tbYRdK4U81pS/chnF0ZpEBpx5NK62LTMgI5JL4mnxUpgCCG3MK5/wCpQ3hQn3y/4hy+eiqau3r3UwQrB4odlaFfAWhEaB5XwlcKbv9lbjlMsOq0Lvxy3zdSjn7//q72enG9ZitW3nvH6EKhn7zDIRLKS7tbKwvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=s0V4aX5f; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-430c151ca28so20593525ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761571815; x=1762176615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtUb4xhiKPpq0C8FtRKPFcwQ9IWnX8JOlp4x+Bp+m94=;
        b=s0V4aX5fK+TDl2n+8a8GRZLtIyZ+SxocDjtLOpOlkurci/Q5a70MXlfVBoQi7YJgWd
         NQbv/PJfcHUg3/ecOPIHSOkyPSRaS2FTxpe4hV76rkVJ4deMsOsE3Ki7ZCE3Pa8dGJfH
         j/vNBwxLyIKhusGlClQGMiXp4xINISedXrOgSRGT957ECWagi2/2tW+5LKdton9urrVv
         fqESnTVLBwhlcFxJeLYehdjWRpZMQ6rhtyY8aC9W3KgmfJvoW+Ff81hJ/4Hf8gAt/yp0
         jiWWqldWts6c13/aS+ndM/PryAmwtHHQsE+P7PV5fWNZ5t2VNCJMN0ssxY0LGGjna23g
         rXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571815; x=1762176615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtUb4xhiKPpq0C8FtRKPFcwQ9IWnX8JOlp4x+Bp+m94=;
        b=vBQwL45Hogzq66hM7lZwMApv+oDq88UNdiLTBirs8e2YbrnZndyXALSFZh5ldxV3Qx
         2hkvjG2E5bS1KI+KI7G+y4lIYqVJVjzsxVc3GHy8RkR3rGAtck78HmpQ5elLOmlafAKN
         CyVWh3trYPChDtsMlHpQm2AsJXsLxswphlkNlppryn407W7dxvxc52he7rLau1ck4UO4
         Ldpapx+2Xv5ROnIJnT/20t66MjtzQr200NZ9HDyYbo9p31CxbiJ7HBRn3L5gmIRoslAn
         /KQWYT7KZke/vUkF7KX5dQrMMCcPArzSel0tc7JP1ARkmIlF7c+bfTFHECqCn1RKiSpb
         2XwA==
X-Forwarded-Encrypted: i=1; AJvYcCUqhRn/AfJfF9Df0GQ2dXT9VvzF7lsER74aqRaRWdKLi7Qf1EITvnaO0qGtvgCjfJcFAjNltY2PapEWChY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhdfyGnotLJmIaUCnBmbLH1Fa7i8tpiSkrDJveiIIrv6o84giN
	6AIEfKBs2TD6nyUh0ojskuDJaPoeHPjBntGZIK2hWEQwrwAnm7Frh3ttHl7QZEo5BWQ=
X-Gm-Gg: ASbGncsLnjCXylMRsK1CU8IfzV7AN4S/qA7CNg4EoAei/O0kyoPoXnIK/VpOQKFlWs0
	QG7BKWy/bgVCLX/5ZeXK1aG2v/0Md/CCv5F/M/MXWEbfZW/bs4akCcjJalJZjyznFiESZmj5hAo
	ZDk6vd3AWoJ2x0JrTdlU6XvuMOHYuQsfAmRhglRTTl2k9JnnHkfj+kTMXku9/AemN000mf1ymAy
	75+ePnaijNOsEGq6OFEJGtae1fhuwtdYAB3CX9zGAQ7if750DvbwcA+6CFp6FZzd9qJH0Ba0HDS
	MU+H7cTv9qD4HSyd/MeLk41Q1kzSbR7JKf+06cDt16x+3eUOKrPFIye2VWgghsm1by7+q6oAr13
	dp+BqpASntUqSIRRq7LPMBFZw9F5ltJlSSNFlbkpIh33qjoYCBuQevRvsQjVYSn4XumD7FqVjXh
	pNtKNDVVJeqUoE9EUBrfatU21xRJ6ZIYsSRAx4r1Mzivg96pCouqqJHA==
X-Google-Smtp-Source: AGHT+IGIaa9c6711RS9OGQdRfQ7Rb3CKIGdpN5d0nvSIOXYlsYNxZJWsYmkF9NyaMUyPnxGqZ/xfcg==
X-Received: by 2002:a92:cd8d:0:b0:430:cfe4:6e61 with SMTP id e9e14a558f8ab-4320f7dcd73mr1143985ab.14.1761571815189;
        Mon, 27 Oct 2025 06:30:15 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea78e2fd4sm3093057173.26.2025.10.27.06.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:30:14 -0700 (PDT)
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
Subject: [PATCH v4 1/9] dt-bindings: spi: fsl-qspi: support SpacemiT K1
Date: Mon, 27 Oct 2025 08:29:59 -0500
Message-ID: <20251027133008.360237-2-elder@riscstar.com>
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

Add the SpacemiT K1 SoC QSPI IP to the list of supported hardware.  This
is the first non-Freescale device represented here.  It has a nearly
identidal register set, and this binding correctly describes the hardware.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
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


