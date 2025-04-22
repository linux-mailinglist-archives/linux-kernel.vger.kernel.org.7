Return-Path: <linux-kernel+bounces-613850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93709A96311
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 10:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC5C44160D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 08:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E1625B66C;
	Tue, 22 Apr 2025 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dEH6Y9vf"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DA025D52B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311335; cv=none; b=hwSenM5V7Qe5xwfLBUvehnkJ5wvCyoLEfIBX3OFMHQ3qTtRa7oyyvg3U17QSky8R/vSKsoeDfENxo5a4Vhy6MXjB2au5jaXAOhde14ewGYoJKT9SLSMMvGoNKr/VhWQ9atOF/ZWfP0qT6zUOdd+HRALDdgpn4ahhlpuoVt5tkxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311335; c=relaxed/simple;
	bh=glrL9frKUynd0eooWslKXIli7Wwl1Of8mWNqeP69AkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=refbxzhvoXI0rlWpcQGzb/Rh5cJa9iIwB7l1NrTPEJJiSaiW8bCaWnnNHBdYG8QgnVCHysf/TSnXlQJqP/clSH1THa9e+e9IqDrLTnI0WSWXe1zCc30hctNnEYKUMdleieMEv1KizvaVlnxZnypWubajVRY6ChgJwOmLtG83kfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=dEH6Y9vf; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736e52948ebso5500023b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 01:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1745311333; x=1745916133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Cqj4QIom4PNiBzVEbYX0WUBXZ7DUraiDzK4MrzGYzY=;
        b=dEH6Y9vf6HnNx7Vxqb6i5y/DQP5YikqJpx0Zkc7VUzwlTEFvdtE09Gc+iHBGGVg4ws
         5GMImkG0puJCtJN2dMqHKy9ZxY4O5OLrK6xGvSjuE9KZPi2dBLn6ZsGQ+gBL2Tj39/tv
         nPdzUgcg9Ys5L7jOgEcGwTmY31X4aSSUGJI6wM6F937aulAxzYvViWzLESqeJSZoCm99
         y7ybHNlvWFku/nqvPNhibz2ADYSXGFxyiNJfZq9QQFonaROYmcV+0t3PuPCC+M5M8Bkv
         g9WaHL0DaUgO23TyCxG7R4s1QR2p+dD5TkgYggoRbfeDEaXzM/EVCuuFMp0ATKc8ragA
         RxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745311333; x=1745916133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Cqj4QIom4PNiBzVEbYX0WUBXZ7DUraiDzK4MrzGYzY=;
        b=kbF1MSv8m2jBe6KtNRRcF2I+L4Y9guo72RLMOEvDamuE6SciHwMZfeyNMbptjT+wet
         dTHrCEjjyXS3aMG/i57E0vwhxoMoM7cW0gkfA00Ozp8HfRnqZocUm6o4+8opDvOEeVTM
         z/wAeFDNbJ9IkHVAhPnv/lxIC8IPKMyTfeTJK1HTCUR59cbiVEg/XYUhM2lly1oMnIuQ
         Rzdd52ywMzUvSkPYWxix2rSkljpuz+27BCgwJpztzivQkaJWWnhBpGAYu4pnXHge/V6A
         +xPqzcnrRTXuxms6y6RJhcN3xUUWTVdGz/DgYJnb8kCUG8Flnx3rMhhvK5FdPepXswfY
         /8yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnn8QsWzlzaFC6UO4Bfb/5cg9hNFRW82v9eZBhna4NSHDcIyRxvwhCNiXL3Jsu1BBtQvRAtA0NsEtJ3Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfinnH2Nn52YNPNzWeikpboVr49DC2+pxmA1/vhXLAXN7NYr6w
	Zc9Kdv9saUB8cEYiFikAJZbQIQlmA72cDpXJXTA6RqJ4BBpC76sBN2G/Wnhfqb0=
X-Gm-Gg: ASbGncu5YBdIfNbSi9LCGUSlB95AGNDcJSKxMo+fqs2cpWab0lwncuKWOfe5nxFmecu
	eH4Qvk7yTgD1Wniv+IveEF1hiliNJ4B7WMCVIF6ajmtrewhktAlE1gL01MpOQNnTr2Sct58x+nB
	sidmF2Xy0HkxqnETiCejb99atF/HC9li7iL23qVt4WLTkbmnoWnjRCIAeI4gBQjUFMUUryZKGnl
	uEGe29gzEHIQaq1kUx+5gxQf79H+KwZwrqWIkJTnA5TNMN7Mz1s4yLmaEjEJFVQh/MutuV1S9gd
	+jUm3TrUisq3XN15pgHuEPHqpwqX9VpFwAbICco8U/6w+aAt0lwr7rt4WCUVXPh3E8Kj5nQCBJM
	oHA==
X-Google-Smtp-Source: AGHT+IGh7II8uR39w+HecQJFOJfohPA9oxXMODo1KcS7MJ5fXvWrxBC4PwiVN5H5gCjQglmL+IpLdQ==
X-Received: by 2002:a05:6a20:d48b:b0:1f5:931d:ca6d with SMTP id adf61e73a8af0-203cbc28a3emr23885458637.1.1745311333416;
        Tue, 22 Apr 2025 01:42:13 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf90d7f7sm8038343b3a.82.2025.04.22.01.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 01:42:13 -0700 (PDT)
From: Nylon Chen <nylon.chen@sifive.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Nylon Chen <nylon.chen@sifive.com>,
	Zong Li <zong.li@sifive.com>
Subject: [PATCH v12 3/5] pwm: sifive: Fix the error in the idempotent test within the pwm_apply_state_debug function
Date: Tue, 22 Apr 2025 16:53:10 +0800
Message-Id: <20250422085312.812877-4-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422085312.812877-1-nylon.chen@sifive.com>
References: <20250422085312.812877-1-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Round the result to the nearest whole number. This ensures that real_period
is always a reasonable integer that is not lower than the actual value.

e.g.
$ echo 110 > /sys/devices/platform/led-controller-1/leds/d12/brightness
$ .apply is not idempotent (ena=1 pol=0 1739692/4032985) -> (ena=1 pol=0
1739630/4032985)

Co-developed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 drivers/pwm/pwm-sifive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index bb9146267bc5..6259f8500f71 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -101,7 +101,7 @@ static void pwm_sifive_update_clock(struct pwm_sifive_ddata *ddata,
 
 	/* As scale <= 15 the shift operation cannot overflow. */
 	num = (unsigned long long)NSEC_PER_SEC << (PWM_SIFIVE_CMPWIDTH + scale);
-	ddata->real_period = div64_ul(num, rate);
+	ddata->real_period = DIV_ROUND_UP_ULL(num, rate);
 	dev_dbg(ddata->parent,
 		"New real_period = %u ns\n", ddata->real_period);
 }
-- 
2.34.1


