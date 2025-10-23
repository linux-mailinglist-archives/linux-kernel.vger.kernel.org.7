Return-Path: <linux-kernel+bounces-866891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E900BC00F5F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BB6B504DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7DF30F54C;
	Thu, 23 Oct 2025 12:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0ltZMR2"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D2B30F817
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220898; cv=none; b=orkEXW56JcKnHm7c8xFcGrwYjB+meQPJVqta+QFjOLTCt/RpJ9Gz4CxbqOKRd1j6MfdPypz8/sGi42AuVB+Fyn3bSiayDRIgPYb0068to1newYWFt3ru9BrBcpey3buVTfHBGtXlPvr5Kidgo4o96DP8dXJvw3UnUW6Ci1O4+fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220898; c=relaxed/simple;
	bh=Hdwf5nQCFwa6NbjTDktqoYUsxZftXJnY8OpPZhssiSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1thnucGPSkFi0dKiPY3EkrNOKcD+QVGkkH61mKOjzmusekq9nvMlZXuvyQj4D9pt6JqzcqiNCJLcsp14rGqAFfoY+TSfyWbx5DtUDayRgBi4WCOfkRsCyttNH40bFFxr2SNwcqhhhedmNXUeyfV2pfC+W/P/jpieHF/f52T8x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0ltZMR2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so5922395e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761220895; x=1761825695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ka8LuyVbxmvdjfQ39lYGy0JYIobf30uy8uBFzC3JcW8=;
        b=U0ltZMR2cjAc+XRdvyXvKBoTikaCZHmL1SibNWGYe49B+JqQKleZArWIHjenqrIxjh
         OFAHJJU1K8D5DsAN3yRUamzLz5C8IJT7lQclVFc/mH33q2ENuWrcR6z8tpHm8tkF9FGl
         HfoDXLpMDrxCsidP7BHPix97600/QfZHpAE87ssGskVlfwFmTYhAAa6kUfhXzboGscrr
         PXlOcPOsnCbk3MjibvITRMIZyYYogHurggVAR42bFLPm7JTf4eqKQhPFOhzDrJn0Klrc
         iIDFzdbQ7HHdFXEmlYqUk69AKoAG7jImzG2dObwEVupAvC25Z6IqsTgefrhZWO+EmPc2
         lDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761220895; x=1761825695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ka8LuyVbxmvdjfQ39lYGy0JYIobf30uy8uBFzC3JcW8=;
        b=aCSkejRc8O+S+xn0ycdtQDbvikFahqU7q9121ww57Nb0uYrECK+OKEtr77IMmzEKET
         xRc+mMVoq+38STbgDqAd/gg+H+lZw3VFzXk3Q+/oAqwQKtTYch+hbv9ORPtM9b/vFZ/S
         WBscJYYHBSrLlkNlMtZ9wK//QOTPaZNVwBrkm2RmZA3+GRgFThNAvUB/CqWEJqbCDlpN
         jLAO5K+WZM47EQk4L3HMKrzUXxDzE0jmkgRNwO8vi8fh5HTyBGvtn9N6RDjqv6BqgXzn
         7FBpLyDrCR9QqZD0x34s6N1IWZJg3KqYh607t3ZoDXppe1oxd5VM741262E2MJ5gKJFF
         nnew==
X-Forwarded-Encrypted: i=1; AJvYcCU3MCedskJ4K6IpY+1nYWEGObs/QvJZUERj76pRRwKWDULs+Xi3lcNG1HKyDTBcAz+UFv7kuIO7grJmjo8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5PmIhxz1H/pzFKmTE+d2P3SPwAM/3QqIUHDhLCIgo8v1pMamh
	GIpx9jA/v6o/BP+HXWao2v++r35a8AjuL5vVAdMJgMUGOE79fj5/euwh
X-Gm-Gg: ASbGncuUplZ1cL6qvmLS2rHcPCJJD1eaxqOXhQqhWkiELTN+RAcczpsLABjC2lKR59P
	KSAKyahrFz1Fo0gRfH5huaMlMlqS2/qBcfhq4mKhX04/DiX8gznYur7APfYygTkoqkSnwMKABer
	fL7J0nMWkzwHIUa1+gesqM2ybma3yh0RE6hlqBFsUWElzlNKMy/6qv5ahXrHx/jZudXsnjLZtia
	/Kbo/tv5jeLasUKivzBVAcFbpOQ+N8+r7q/9iJ0QMhKXeb353QVSUrZvBOnIHQnXA7JXraTAaeO
	IpzrR3DyQx499bE1v7WFgb9pBnRKkGbQPO0iW6L6IKiHjjVAx6ox9lfFh17tDrC56b/Ej/in03P
	VBnIzQbsRkHH3ZzCYuSA93CIe8XhZeQj4/jfEiwz8LL3c2XmBgXIqxCIZ8EwNuFWBHWuUQurn/K
	ARGGAhH89YJCkFrzo=
X-Google-Smtp-Source: AGHT+IF/VlDy2onoinLTolj4AwSpklB05rGEyaSDFcCw815nAxpPqfpay/K624RSenyLYEMU7ucAOg==
X-Received: by 2002:a05:600c:5287:b0:471:7a:7922 with SMTP id 5b1f17b1804b1-47117874a26mr205426385e9.6.1761220894586;
        Thu, 23 Oct 2025 05:01:34 -0700 (PDT)
Received: from shift.. ([86.124.201.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c43900e1sm109604435e9.17.2025.10.23.05.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:01:34 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: andi.shyti@kernel.org,
	wsa+renesas@sang-engineering.com
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>
Subject: [PATCH v9 3/3] i2c: pcf8584: Change pcf_doAdress() to pcf_send_address()
Date: Thu, 23 Oct 2025 15:00:43 +0300
Message-ID: <20251023120043.8661-4-chiru.cezar.89@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023120043.8661-1-chiru.cezar.89@gmail.com>
References: <20251023120043.8661-1-chiru.cezar.89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change name of pcf_doAddress() function to pcf_send_address() to be
more in line with the kernel functions naming.

Signed-off-by: Cezar Chiru <chiru.cezar.89@gmail.com>
Suggested-by: Andi Shyti <andi.shyti@kernel.org>
---
 drivers/i2c/algos/i2c-algo-pcf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index 6352314e48ed..a87ecea7f510 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -253,7 +253,7 @@ static int pcf_readbytes(struct i2c_adapter *i2c_adap, char *buf,
 }


-static void pcf_doAddress(struct i2c_algo_pcf_data *adap,
+static void pcf_send_address(struct i2c_algo_pcf_data *adap,
 			 struct i2c_msg *msg)
 {
 	unsigned char addr = i2c_8bit_addr_from_msg(msg);
@@ -286,7 +286,7 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 		int ret;

 		pmsg = &msgs[i];
-		pcf_doAddress(adap, pmsg);
+		pcf_send_address(adap, pmsg);

 		/* Send START */
 		if (i == 0)
--
2.43.0


