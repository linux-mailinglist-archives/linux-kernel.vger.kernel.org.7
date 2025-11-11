Return-Path: <linux-kernel+bounces-895713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CB3C4EC1F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DD944F7683
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B29361DBF;
	Tue, 11 Nov 2025 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USDeWMwq"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D5B361DBE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874038; cv=none; b=AbA+3VUSe2+5bJFKifDqBHAna4y/ssNMpdQ6TPVG0SPimtrlUcltDNHdW+JsVESSXHlWcCdlDgZw/Jb4DYl9/t5Vnx1BPLRL9wGDe/7FTR2otaNarzFUHR+Wl95TL/SNF0qeAsK2EoRUMZo6IsKMtUKtTbmsu66TGsqUEwrSub4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874038; c=relaxed/simple;
	bh=Ti+2vmguY1SICm2DICsmJgXZnQbOhyPSNbyWwHe3uSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDwbMEBTYVVuLv+ylrilzuL8pbM97ozeuYKqzM3lFV2fzFu0HByZ+yYN+vkRXE2d/PoTlNiAagOFlO1u7d6Rg91ApgZplWqBHFGeuPCnC+7EJ0tcFumRPywdl9PBOytRuhlJh09PZyeNhNbAxBm22xxefPG2PNMcE837n8jcqT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USDeWMwq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297ef378069so29338085ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762874036; x=1763478836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xk+ab9S/Fktn/kpjYuwQB6Q1o5rzNPQu+5xg+VUfK/k=;
        b=USDeWMwq9RNOwtArJfjknC7g15K7BXPnofq43hHp0KUJ6f3zAEUeLnKdysbm2ypFmE
         QhoMRxvmh69O5A/JDefYm2F+p2Kl6w2lzi2MrY0PyF0/4R6sDcsKrjXX67jRXq1mV6LS
         DVMAuPe3h9pCZ+jYhx6n5+qpc8dvR6gWcQj7LPI2VN2v+3WEdl3HIQz8Q3QuaqCAMKhv
         pPN88RjADCx+yehi/HTGO8UpGmS5DEGa00Vf//KSTyCEGXmjZZ2HertwVkN4LCar+IEp
         EcS83GKU9mul5xemJDVzvpWoTMC8hU5oZoWG8SxhcGHg9Q6z2IA5u4eg4UKp1/jN5+sm
         cyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762874036; x=1763478836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xk+ab9S/Fktn/kpjYuwQB6Q1o5rzNPQu+5xg+VUfK/k=;
        b=lVhzdNfdFxyzGDDPMrI8ZxodDqCOoWk5VfnptsizoKgy+AbWN0u7lBlaJ43vLeCvi1
         BJtl0iUXsdHDuTE/sf0Pof/MdtVwx/+NJJ1ksKGTy5IFmpdiJMlfmwvXUXUI6mNW2Wt6
         fMO+4FzVLW1P43K3nIWz5LbIPKLRAibVIc9d8ZkdD6zCq+GagkgAot1fvKvA91/X2+1u
         0i/KzWxlqJttGk5Wb3fgeZ6Hj+Eq9o/NB6h4sKfPUwFAhXCKmisv2rVUSxXXIA884di1
         fEzCcuWISScEAYxiXw949yFjDJ34qiTQ0mHqCywNWpPsK39n1UQ+jXQu/FEUGQEImJVV
         uH4A==
X-Forwarded-Encrypted: i=1; AJvYcCUYNTVlYD903yUEEggEEHyia0yz9HVp/I0N6QGfyf8s1mPkppzVSOmFGSEeEfroYTn7n7iWfTpth0MMOp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoea9ZtAKhENKlb+5VCAxKt0PjBIYLM/OgWqmViAa1zXnirSsP
	8AG7sfxP3A0doBFVXX4AAhELDutsobEy69/ihdOwQrfAp/MFChJ6pSAL
X-Gm-Gg: ASbGncvy4MKCn0qebHSAaLsBJHW9CudqFK7nkrKWrjLYXQMj5QM4SaJRKHndc6dbjgx
	ivz4WKMKQtb0S/3Z6WFk8CD77VXU1Y4yTj0P2AfXOzL4hXj8vAKc3lrniekhISRqtzDIUqLmm4s
	Mzy+oQaa8ugKM022PrMg8eYVGGZL/h0ybvKi2iRD2FIJmC/fjJdEhgURYW4dOeudwCtcDvca2lF
	jP6bTp6/DQJQLgdtMe4mtWyPTX0ExRa4mh9N1dREZ8kfD0HmC19rskzP+34Q8d0U4f6cYMqoC5/
	SLnJ7O03zi1bO9vCandWMogsExguZ8XJo8y95acsrp7sSu1D1Y+kJ/7xK4EtH7GcQZZhCey2KR/
	o1JTftrSl+TPL4FBiEcEsMMEqWZTdWYemTr/Yxe+wgoQatpTBnJC71HNGr+0rD5LFBubKtkU2Ff
	gW5VwCfnowOR97aNEJz+VfAyrS
X-Google-Smtp-Source: AGHT+IEblO7gaYyU/lmwayxhc2EstFsO1L99ch3o95EXeiAoO1u/jE9w5yzV57nNPGWEwlAqpZ+oTA==
X-Received: by 2002:a17:903:240b:b0:298:970:b24a with SMTP id d9443c01a7336-2980970b609mr110598135ad.58.1762874036156;
        Tue, 11 Nov 2025 07:13:56 -0800 (PST)
Received: from clint-ThinkPad-L14-Gen-2.. ([110.226.177.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dcd050asm43325ad.81.2025.11.11.07.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:13:55 -0800 (PST)
From: Clint George <clintbgeorge@gmail.com>
To: gregkh@linuxfoundation.org
Cc: arnd@arndb.de,
	clintbgeorge@gmail.com,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v2 2/3] hangcheck-timer: Replace %Ld with %lld
Date: Tue, 11 Nov 2025 20:43:39 +0530
Message-ID: <20251111151340.9162-3-clintbgeorge@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111151340.9162-1-clintbgeorge@gmail.com>
References: <2025110649-elves-steadying-a4d0@gregkh>
 <20251111151340.9162-1-clintbgeorge@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace non-standard %Ld with %lld to ensure compliance with the kernel
coding style and potential formatting issues.

Signed-off-by: Clint George <clintbgeorge@gmail.com>
---
 drivers/char/hangcheck-timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hangcheck-timer.c b/drivers/char/hangcheck-timer.c
index 21ef8a6a0..ff141fdb4 100644
--- a/drivers/char/hangcheck-timer.c
+++ b/drivers/char/hangcheck-timer.c
@@ -142,7 +142,7 @@ static void hangcheck_fire(struct timer_list *unused)
 	/*
 	 * Enable to investigate delays in detail
 	 */
-	pr_debug("Hangcheck: called %Ld ns since last time (%Ld ns overshoot)\n",
+	pr_debug("Hangcheck: called %lld ns since last time (%lld ns overshoot)\n",
 			tsc_diff, tsc_diff - hangcheck_tick*TIMER_FREQ);
 #endif
 	mod_timer(&hangcheck_ticktock, jiffies + (hangcheck_tick*HZ));
-- 
2.43.0


