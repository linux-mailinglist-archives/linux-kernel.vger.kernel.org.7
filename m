Return-Path: <linux-kernel+bounces-737342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12211B0AB24
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9EF3B46A6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6D421170D;
	Fri, 18 Jul 2025 20:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hj6PGs2O"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4181DED70
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 20:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752870743; cv=none; b=fkrS4CYE6xhrTCVuFixM+7V2CoZHHvR59qvqIaJF845B4mUdP2UNxr2pej7ZHEgB1BSPiDLxxhVHNL833KnCKkHqQTL4+KsKHwh1YdHXzD9kD9iFBVOveSMjgdWzEfANXUTS3Dwlqi3sTOVJ5UyzOhgB/lzE/RysZnQ2JmYSA9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752870743; c=relaxed/simple;
	bh=4Tw9BC7cQxs05B9tUg+PvNdlupf5tPIdaQ9IfTgq4DI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LYw0CtjMExfoBNYfwD692u5QuhQNt04bPlXISboAgVg5/n6MH2teAR1HNfHJuYiwbfCB4/BaP6+B59p0AXedhcvsZ9whNByFGGyiqGlrdnPweJ+SNtqx3ic2gnB6eMkhcaapzvF5ei1OAAMp/YsaIQL/eIN/57GxRq556hF2Tmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hj6PGs2O; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2fef7f6d776so801392fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 13:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752870741; x=1753475541; darn=vger.kernel.org;
        h=user-agent:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VsTMl5ayNgd8StI3u0W+gqGFg6Ns2EA4dxNGyic4NMU=;
        b=Hj6PGs2OiYsxqWijydW1IDabHKsKSMJsZX+RuE/JRRAvVgDjE2hyhYCSqKFYK1dG8z
         x7WiUpblnKg+hs1TWBs72qcycZ2mgge4g5VT+VMuf1Lma1iKhDl2fdkgrxwWtdhp7Z3M
         wXZbqTaC6dX3eTDZjJy+K77NNFombk/aHxqF6dx8LM5w1VlX7WAuHOc+LmhFN/Pjp4An
         8qufjMN0VxMoQij8PxWcc2qnJqS0Mme6R1bZODwqebP6Qi8zmFECoKNwzANJ5jDNQ3/P
         T225zZ3A5+GLrVQq9YHe7C3oDIX5sZFGkD0ofiQENycl2/ALMP5o4jsd5/BdXxPrJ0oy
         4hYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752870741; x=1753475541;
        h=user-agent:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VsTMl5ayNgd8StI3u0W+gqGFg6Ns2EA4dxNGyic4NMU=;
        b=qY0fg+hL99xaE8eFWNTgFeT2eG1aSkjNw1jazIzK9fDlL4sHXI1kxQm9fdnXwffZFn
         uMlMFYvuEn+87UGMbe68fqLZKnFeMze7daZtkx4Zev3I31d0fK6ZUMgsgnB8slcDnBOn
         TD0n+eAIwNi/WRn4JBHwgs9szwMqBr65ks4VmV2hfMr3HK5mFX/KDBKgUd+av8WlAjLP
         ATIjLrBGy2xWP0bB+7HBiXOfIhbcKNd8OOeU2x7j1x+XBgZFExguvy1sha0NzDR8YWJc
         doNuECqQtAtjm0P9ecPUqYNn2e1xmod2vWFfmoWKAU3JCgJKbmYHbrSXfiw80JArt2qx
         yo4w==
X-Forwarded-Encrypted: i=1; AJvYcCVdMC3/W1PJ+jSrrHAO5Fd87ZtuPqapBzX0nssnwuSy1x9oFejohy1TfNKrH1wtt722FrBocK6IJwXF5Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc3l37SlCCR1MmVEiNyysY+CApSJm3NQJSVzGYC9FdHOYtJhO5
	Q7G5jZrmr+sdLpRLk9ABkhwFRwehYQtKJtua1M4+F7MvqdmfyHNvP/P++CFthBCd
X-Gm-Gg: ASbGncuBxhSuWWzPGeakWW+bTc3wrk8AdteWCWwCeO2XizKbtnAmH4T8BWGZ90GAiRx
	WP6rFws7vaBtTzt+4K6ItzG8MsFgmaF/HLQKxNahpXd2hDiLExy3KzQbFM/qkuD88rpkvoLSVIC
	DavBTbe78rNhQoICUJUqXE0T9TBhJzGtqQItBCtj6siFh2dO2mG3AhvYBrzvXwRoxz9lVMVeyiL
	GZsizd8UWQLCkW/Qbx6JuxF8rtXWlvVubkpl50KfjXjaIYUZ5vTFPoJTx7b/P6I92BaEkc+sCvI
	zKwHrDQPPJd84bbLq5YXTumbJIvjHGDHyFm2ZAOhUDPUeNc9uM99IEKUbwasBQ1eaoQluPyWkYC
	yv/vUl+7w6HeqmmnRVCl5zUp6sVH+5F5YlqOh9rk6hsaVcUl6r+ayfn0xoeRK4g==
X-Google-Smtp-Source: AGHT+IGXpIp1fjCASD0DU5rL5C2avlfFVXZ0tAQWGosKnkzFmyhma1UEPPGPttyumt8CkMZPNplhnA==
X-Received: by 2002:a05:6871:3685:b0:2ff:a814:dfdf with SMTP id 586e51a60fabf-300e9dcc04dmr3148383fac.20.1752870740749;
        Fri, 18 Jul 2025 13:32:20 -0700 (PDT)
Received: from MacBook-Pro-de-Ignacio.local ([181.161.11.224])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e8354df9csm885664a34.12.2025.07.18.13.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 13:32:20 -0700 (PDT)
Date: Fri, 18 Jul 2025 16:32:18 -0400
From: Ignacio =?utf-8?B?UGXDsWE=?= <ignacio.pena87@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: sm750fb: make fixId array static const char *
 const
Message-ID: <aHqvUrXtxwf_k9sI@MacBook-Pro-de-Ignacio.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.x.x (Linux)

Fix checkpatch warning for the fixId array only:
"WARNING: static const char * array should probably be
 static const char * const"

The g_fbmode array cannot be made const as it is modified at runtime
in lynxfb_setup() and lynx_alloc().

Signed-off-by: Ignacio Peña <ignacio.pena87@gmail.com>
---
v2: Only change fixId array. The g_fbmode array is modified at
    runtime (lines 786, 788, 949, 953) and cannot be const.

 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 039e6875c894..c237a8f8eb59 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -730,7 +730,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		"kernel HELPERS prepared vesa_modes",
 	};
 
-	static const char *fixId[2] = {
+	static const char * const fixId[2] = {
 		"sm750_fb1", "sm750_fb2",
 	};
 
-- 
2.39.5 (Apple Git-154)

