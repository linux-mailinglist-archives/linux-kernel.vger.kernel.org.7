Return-Path: <linux-kernel+bounces-892218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5703C44A4D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 00:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2CC83AFD6F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 23:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4474B26ED4A;
	Sun,  9 Nov 2025 23:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkrcScgN"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1AB243376
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 23:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762731570; cv=none; b=I+I4Hwir7R1mWUIqOo3iSPl0Wt/paPAKRFUIkOeQaWr82b8VezCL0kMXRX0+dnDp2+unPgUNvR1/Cd5UomOP7A2+2BYV7uR5p6kXMEObypTI6fpPhAg1gFuhT3LscvzWC8cbrtuQ9itBaW6odqazlfGdMR+Ln3GMRQ1zE2+zomQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762731570; c=relaxed/simple;
	bh=XuTh1IgFrQYImvo9l5AWKwfidf2lOz9NOuVH4XPPcII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jQHGjqQ4JqSdcRjdZgXUOzMZ4PmXeQEj18SdSRfNE2sBD1YlJ7rX9kjPj+/p7k7rzE1FZzQoUQ4zm/wpGZLtdQq73cBlVf6Ku4JwQuZBNigQpoE74LL3g0tRSfPYtIJoJaOJdBqb6e9xvZHqxv7CNAL8vGBD/zkRKyllWxoIzzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkrcScgN; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47754e9cc7fso16218155e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 15:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762731567; x=1763336367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iCF/69UO28JAIuxTpEGkmXYFsep6EElMd2T/qBX5DOg=;
        b=RkrcScgN6GOFPhbNQF7lOSHUQ86afrgW4qv9tEDtJsT6pEIFbjm6La0BWUVJPNaAsw
         6DrvhzwbNxXlR8Zl5PuLB7ud0Nk2LONiimEnay4kKDdbmwlPqbc6BuoMPqniMd6a8Z9N
         VSfXJNsJ1bDy1n+jArnIAOt7QENvFhJR1TyWMZePiYewXzRN4kQEa4vTYU4TQfQfrlK9
         i4wdcroTJHgBY3bzfGTWJZa9FAunmuRYNjBr6Ab8n89ybdsudE/qrah08hjsiPAx+jQK
         A2aQhljGSbxHGug6HWalsBYlfSEfC/Qdf+ptEmiZnINkdqBM5cjkaONFTJ/VCQgkCrqm
         9Ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762731567; x=1763336367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCF/69UO28JAIuxTpEGkmXYFsep6EElMd2T/qBX5DOg=;
        b=CUrsj47tL/hTYtataUl63/76AI47gV51XsUoIUgluKka9rMw7QZfLfreezUiboD45E
         xbsZFg2X2/WgTTjHcG8eodNjzF6V7Jd0zblSd9vUSwhA98kD5MSgPF7sMHW5zffbH4Vw
         SJYPV9pLuwJ4c0cu67PwqAiNADqPxYHL6qgDDrby6G4j5t7aOm9hZxmz7pr2zH1OYVjc
         K+gvH85FeirUnnDdUPApd8zyHtWwGhY6QPLvNTCaGxzBrEhQHHbp2oN3I5ZD/WeWKJJO
         zpRPlUouCkNR8ROpR8ZxBhC69BF8T9RV5kEorGhraXuQc6+GFKs4vBQx7ZnCEHJYfmgR
         3RDQ==
X-Gm-Message-State: AOJu0YxXqYxFpuL3g5ZqeMoByFWH0pIdbklpf3Il+MUTaJ/jkWIaWd0w
	3DRkJhBE6QK5VqglLvlEusfipD5KvsJX8YtbOToIggTE2K+CsatSOqt9
X-Gm-Gg: ASbGncuyHOxa7iBU7z25dz9JV7oqgrmxSIgnnTffbJEp9MvWjSkGjxIGZag7UqGL1aP
	bETmg+9L3ek1NEgmE54b5cZn1BCWJA5KuIRnvgsZ5y/Uo0Dsp47eSJcy0MQWbaGGiFxBf/8r8Ac
	y5pV2b2L4erU7NLtXW+U5rY5eX5oDhvIA0Av5yAq4L9469caBWFv7dZBr5nEsZ6lEi6Rzxh2Ufn
	8Ozyt+zptSqRy8a0c/7m8toCdlDbGLeBbawllcc5pzrS5s7EiR+qVWTK1/JV9pabpM6USGXTmPz
	+6LZ6H/yw5Tsx7knL2vqTpMdeXyDwKiUqluuI2e/WluLjcpr039JqOj5Dmr+VCrxCtZq+Rg7q7+
	xm5TK2QPHoQYkUyyhodjSoJwfL0rsuMs6/vgn5GOy2827pEac7CWlATFfiUipdZbSyeTO6x+M1F
	0AbKE24G2EuSXmAVk4FOSainyjYerB1eWge3/bGoKF5QGuxFGw6jOTr1s2FMQ3sA==
X-Google-Smtp-Source: AGHT+IFBy2xEZD2lLPvpla6AioQ/QiXqiEKzPxRtQorAJRobkTwVf4XlbVouu7QfhjKSCcwM2f//gA==
X-Received: by 2002:a05:600c:1f90:b0:471:989:9d7b with SMTP id 5b1f17b1804b1-47773271adfmr67587065e9.21.1762731567164;
        Sun, 09 Nov 2025 15:39:27 -0800 (PST)
Received: from localhost.localdomain (178-119-182-195.access.telenet.be. [178.119.182.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63ba87sm19761830f8f.14.2025.11.09.15.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 15:39:26 -0800 (PST)
From: Kiril Maler <oss.kiril.maler@gmail.com>
To: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	broonie@kernel.org,
	Kiril Maler <oss.kiril.maler@gmail.com>
Subject: Fixes: 833026ad56f76d1a1035d6511 ("spi: spidev: prevent spidev->speed_hz from being zero")
Date: Mon, 10 Nov 2025 00:39:05 +0100
Message-ID: <20251109233905.8311-1-oss.kiril.maler@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[PATCH] Revert spi->max_speed_hz only when 0 in ioctl SPI_IOC_WR_MAX_SPEED_HZ

Some drivers (at least drivers/spi/spi-fsl-dspi.c) use spi->max_speed_hz to keep the value
set with last ioctl SPI_IOC_WR_MAX_SPEED_HZ.

But at the end of case SPI_IOC_WR_MAX_SPEED_HZ the value is set back unconditionally to default, highest possible clock.

This results in erratic SPI transfers with highest clock, in my case instead of 6MHz was measured 37,5MHz.

Probably also spidev->speed_hz must be adjusted, because it is used for ioctl SPI_IOC_RD_MAX_SPEED_HZ.


How it was discovered:

My board has SPI Flash and EEPROM chips behind slow FPGA spi-mux logic. Max clock is around 8MHz.

The config sequence in /usr/sbin/flashrom -> linux_spi.c -> linux_spi_init(...) is
	SPI_IOC_WR_MAX_SPEED_HZ
	SPI_IOC_WR_MODE
	SPI_IOC_WR_BITS_PER_WORD

The RDID command to SPI target Flash chips resulted in incorrect Vendor/chipID, or ff ff ff

After adding second SPI_IOC_WR_MAX_SPEED_HZ at the end of config sequence, correct clock
was measured, programming all boards succeeded using flashrom or spi-pipe.


Signed-off-by: Kiril Maler <oss.kiril.maler@gmail.com>

index 5300c942a..4ad11381f 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -489,7 +489,7 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			dev_dbg(&spi->dev, "%d Hz (max)\n", spidev->speed_hz);
 		}
 
-		spi->max_speed_hz = save;
+		spi->max_speed_hz = spi->max_speed_hz ? : save;
 		break;
 	}
 	default:

