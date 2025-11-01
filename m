Return-Path: <linux-kernel+bounces-881302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B0CC27F37
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 14:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 895884E8481
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 13:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8F62F4A0A;
	Sat,  1 Nov 2025 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mXkxOZQL"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5EB153BE9
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003610; cv=none; b=A8D3Udmdrha5RajbJ7wQPcr51NUaxR2NH3DPQPQu63NOj/MUlkDsVXa2Aym6OcXO8F5Bgfjqz1Gbwo6N2VNUnT0H90Hzg9o239ryD0B5fN7k3ve4pusRE3rfOvA0/iAvdVBtDUYK4qYZtpSYGNrkB+vgmXxxXORxGAiY4swXNVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003610; c=relaxed/simple;
	bh=Mgp89QAtrTjRgM6jWQFTc0jn1YY1UmGe8KsPam+6Ssk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MioDCKfwaD2mUmmxnxcaIorn1XQy+mJVnpNZn903zv5BUt2jsAgmabdN6dS2WsdHnnHUDPFzRnpBtlpK2G4O/UahUKO7qn6KcCtm9KW8HNr6KOZ/aetZnu38IEFJpnaq1P0oljZSE0mkFmUrGXg8q3oAsUPIfcLG+m39TPwTo2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mXkxOZQL; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429b72691b4so2852310f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 06:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762003607; x=1762608407; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eg53ujn5W1DedX1Vyep0yhtifcPEiIbNUDg4dfuJiow=;
        b=mXkxOZQLOo/7v+JkoergXHoljqy4zc1MzpCWRuTLPEdmhjfiTLmQPKSUbxOZA+LCI3
         Lijpx/r4nzNmIBuLh6ZtW17pykbV9+EZ1rR2r5X/OGbpiq0tYgpdTUNb9+p3tyaHmDQj
         zeZ3RyvnM+2ek/MHXY6aQVkwPXdlGB12Lbv+BjJyAkeHWU/NqicXcn/vpYHSSKSDS15N
         DWYG571c8l2HiMiXlzFU0P5FmtO6lFhn3EcRLOI0XJZJaYk83w/vljsx9Mnb/qhkCq30
         dwVDf+gxSikJiNxKpSwAu3pGRtnuK4HCWv8Af6oCjBVpJEYdA5rfh1H+1Zw/MbiuNs5O
         sY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762003607; x=1762608407;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eg53ujn5W1DedX1Vyep0yhtifcPEiIbNUDg4dfuJiow=;
        b=BGCWE+ng10Dq6JOdpPPx18YRMl6Sul+0nADZcYYXu1vmS/SkFAsoryeIpVSAhsa1Hl
         0nv1guTlnH71iqs8yJHD2XhcutXBMFtI5z1oCPg1kDPBH/a3itQeed7BeY5Pph6fCl6o
         xNk3MCCL/gJD1JbLcKUXrbk47tgELFr//DKVqI2GTpRyisrKofSQFgr7/mSW3UntoIgF
         PPpDAgVw9VSPw0A7u0mLgvN9yaOMwfpAQju+F9sQoZ5t04A77Ua6NBFP8E4C+38I7JaV
         sVMesKpdsAgLsEqqsFxMJiWpK4YxS6RtLm1X9lBBdSlEh3fggqoOGUcAaPxoMVAyl1jZ
         JahA==
X-Forwarded-Encrypted: i=1; AJvYcCUvTSWgpmy3WLIX4oC6SVYcMXBIl7vREYQf2QeKnnPpAQLx7ZiNlpLXWn/eHdOkBiCfS5J421JWcnGTNAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZeqM4DCdy7KJxXXsLXGgwT/8tT6qiCoJuPAHEVFyP7SnSZNhi
	jKZOkDpuCraT1jqgOv7WRQaGwOoJSbJDg/XG3EjuCz5Pk+5APMaDMKOdT+tPXxAjcHo=
X-Gm-Gg: ASbGnctsZl4491HBjV1wqftT5QcWjQAhDnHMXk7KHAhadeHupyKeVVITJ+i5qYnIqAW
	6Z/UXGSReNzQLCQyU63pV6taZZn+ytIJbHpht3tnzwVR5aHx5ivPOqNu0Lk0Vj5e76QLdcqTOZJ
	WoWaLbsGpLGD0vvGyTfKGijE1r4zm7WFn3I+mb0LkPOlIFXJ8tDPXqzFEgGta0wEY12S5DLMYX7
	83PHtSDWvBAioYM7K+X+Dx2tWTR5qrfS1+lX4QOw5F75en+BI35g14wOSQYZJfUiuPAcmi/Utxo
	8RM8bYGTAFnnLW1EgQmCO3sd+ASAI8VpTS4witYmEisB9dEg4SzEUd6ElzHSfGrtz/R+pDpn+WL
	jFU9kd6CKzqzoUxZkByPmPI/Qz8wCc58AfpRlQSWrPpKZoqNhVLgs08USlCDfk/a6SkYww/Y3T0
	/cGWUgYXlih4+n454W
X-Google-Smtp-Source: AGHT+IHWklOzm9hRp2MshFHHpjAPX4YwiYbf/S/L+tv28vs/jH3gOqeBv6O9b8sMd6VBVbyb1K/+5A==
X-Received: by 2002:a5d:5888:0:b0:425:7c2f:8f98 with SMTP id ffacd0b85a97d-429bd675fc0mr5343738f8f.1.1762003606366;
        Sat, 01 Nov 2025 06:26:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429c54498dfsm5711594f8f.34.2025.11.01.06.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 06:26:45 -0700 (PDT)
Date: Sat, 1 Nov 2025 16:26:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] octeontx2-pf: Fix devm_kcalloc() error checking
Message-ID: <aQYKkrGA12REb2sj@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_kcalloc() function never return error pointers, it returns NULL
on failure.  Also delete the netdev_err() printk.  These allocation
functions already have debug output built-in some the extra error message
is not required.

Fixes: efabce290151 ("octeontx2-pf: AF_XDP zero copy receive support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 3378be87a473..75ebb17419c4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1530,10 +1530,8 @@ int otx2_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
 		pool->xdp_cnt = numptrs;
 		pool->xdp = devm_kcalloc(pfvf->dev,
 					 numptrs, sizeof(struct xdp_buff *), GFP_KERNEL);
-		if (IS_ERR(pool->xdp)) {
-			netdev_err(pfvf->netdev, "Creation of xsk pool failed\n");
-			return PTR_ERR(pool->xdp);
-		}
+		if (!pool->xdp)
+			return -ENOMEM;
 	}
 
 	return 0;
-- 
2.51.0


