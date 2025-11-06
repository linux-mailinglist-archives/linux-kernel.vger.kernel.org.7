Return-Path: <linux-kernel+bounces-889273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CECC3D20C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 20:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18D6E4E1E3A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 19:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AED8354AE0;
	Thu,  6 Nov 2025 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igzo+dvL"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E60350D4E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762455600; cv=none; b=t7OSEToekQRoCS+BCFJxz0OpQVZnP4uxxepZHdBvS+C33TuSf06Qww7IIXZTKEr/ulH7uxygO0i53dUprKpfFBsFdvP3tNOUTeaYGbsB7XASLfZORbq+M8nzV3y1+/+WrgfbMGMTrlPC9iFnop2+SQKAANnGCNt7dlS+MsFYRMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762455600; c=relaxed/simple;
	bh=cMn6KjmzT4TvlXfOcgI4FvDupMo6AkFL6UGvUtlsZls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHqmg4NF6kVngA2IdPxwHMbo5L2ka3nJSRu0bhvrR2teSP767NqxncShVPYDFnlfMwrCPysLTNux0g0095mUJtvRE2zjbchni6AfTdTqdP6m/puPip3T5JfoSkH2Gqpo13U5BGWJpEMafBS2XgF1KjXemDPdOxzjL8ztuuUf68I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igzo+dvL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b0246b27b2so853928b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 10:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762455598; x=1763060398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+FK0gOC1mhwN3V0gqoVshsVD11fIkYoJIfW9hejE3Q=;
        b=igzo+dvLRwAjAX7hhu3Q1B6xU6vznzc7WZLG3901QlcWtUEyHI1u+BwgsRSQB5vVRj
         bgNkrAJRV9mUV8aLoGE0ALVs00ONElmnXltMyGDSkLroPMDjAsY6OF2fuUs3/fT/mDov
         rcLQBV9Lqr++mfMWFzp06CHFL8r95bEuLCrb7lON4RBf/hxLfKrfILlAarHn8UeSTYgN
         vGtI1JDsB7hUkpqpOYBhf1EQbv+NOwOjnj1jJWQMe5H+FDvW77KPTAGGp88gYghao7CK
         Q2LhWYQ4u/IocWgj9eGsSofPm5hHzKpuv7xb2dy/anBnEl70EqWhf+Lqe+TNvbQBR6Bj
         xqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762455598; x=1763060398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p+FK0gOC1mhwN3V0gqoVshsVD11fIkYoJIfW9hejE3Q=;
        b=DRkkL2u589xOk9Ih5zquUC/0PZpTpbWOSXFoh9qPRkuCxQqf4fhIHf4ApLeKgnAiLl
         dzJSIDXuHX59vAmoa+2HfMZRZdJLwAq3E6zpd5odE4y9ZiXQTXee1XwFquVpw/laDDN1
         AVws/zgfPypFDLSAYLZnotwSEmnFzYyQItnDgwmGGXYxfNMNw2NHrJcuznMu/uRKPXUL
         dxL5FK2PmP2nl5UYqecIx5965TwxSceZi5GjoSAXjm+jEyVHAkqaeX0FuAnbyZtu+QWf
         1Qs8MBs1cKco6Zp42XQ72NqVWjOjC5kMNHh48u5bdPnwSDLUKXpcuSxCJ23CesfxyLy5
         oX8A==
X-Forwarded-Encrypted: i=1; AJvYcCXLcYpDpGVrrqAuN+lZFhGPUZCmak+3e+gYEji/alEvXDS9LfXiDQR3Fb2hNFuysDGjmm9n3Svs1nCuB+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY2NBxLGNux8NZHvOGHXcL+XySpOJSTPZQX3z4g7n7csNLu+si
	d7Mzm/X6cE3cvlng1abPM40ECGRE4cRRD3a1u0t3BM1utemTWlk7hnsw
X-Gm-Gg: ASbGncujySKJAgol+nAz41alb/X3vJcbWyQwtpzT18Fb+2Kr9qZPTyDJ1TU50E4BkXu
	OLxFau3do0yY5miEB4cIFoWrxFNCpyxl86CdWrWOvKw1tO1Hd+kd5SMwH+lPHAT0CaCUKRBwPhs
	BGT5ffSryQPd77nFKndwFVpld7GLELRVpMJOBi0WySiyhbGcnS78aPi8J3uT3JHS2V0jheef4PF
	Qe7/ZIIzld+LXlrYX9qDdYdACHIBcqyp8Vr+2e1Juq3AON4uCheDHJVsCXDbU12713T10Yzsj3C
	dck4F2h/okGAkQZ3TunE6Z6HZftGchMBXfN2C1bP1YyKAQQqGzrowOgDv/DkPtocealrg03GUVC
	SVaDGS7Wu/zKOP6ylvHdOPKrY8ZVlh49p2bZJl5iJ1iICqY+uiCcKYtgYvg==
X-Google-Smtp-Source: AGHT+IHagJSVNCT4R+KJ4Gcu1Y5auKiZ70Unu5mjvH9cLJ9bPgg5yTxEK4O18UgoksnzXKb2DtQKBA==
X-Received: by 2002:a17:902:e945:b0:27e:ec72:f6d with SMTP id d9443c01a7336-297c03a0676mr7775115ad.11.1762455598382;
        Thu, 06 Nov 2025 10:59:58 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c92cddsm36647815ad.83.2025.11.06.10.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:59:57 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-fpga@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] fpga: stratix10-soc: add COMPILE_TEST support
Date: Thu,  6 Nov 2025 10:59:38 -0800
Message-ID: <20251106185938.6419-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251106185938.6419-1-rosenp@gmail.com>
References: <20251106185938.6419-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the buildbots to find compilation issues.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/fpga/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 311313f3b282..f2e2776acdd5 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -60,7 +60,7 @@ config FPGA_MGR_ZYNQ_FPGA
 
 config FPGA_MGR_STRATIX10_SOC
 	tristate "Intel Stratix10 SoC FPGA Manager"
-	depends on (ARCH_INTEL_SOCFPGA && INTEL_STRATIX10_SERVICE)
+	depends on (ARCH_INTEL_SOCFPGA && INTEL_STRATIX10_SERVICE) || COMPILE_TEST
 	help
 	  FPGA manager driver support for the Intel Stratix10 SoC.
 
-- 
2.51.2


