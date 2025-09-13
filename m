Return-Path: <linux-kernel+bounces-814928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821E2B55A86
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 02:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA3A1D612C2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 00:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEE015D1;
	Sat, 13 Sep 2025 00:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYDwtJJW"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BDD3C01
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 00:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757722152; cv=none; b=dV7c5CSch3YDhWa2ARj8YV6iq+Ddrdzg/l76OXoQUrKadfN36GnUYPAach/kSd2IGlQQHShn4y5V5psRvIahe4wqZr/p6eNZlDmWjHOBgU3fjl8LfuXxlKCMYHVihbjhgnTaeANQMtOMF6c2uq6VOCMUEnxVBV3F+rBKerOlzmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757722152; c=relaxed/simple;
	bh=j+q+GO+Q0O/IS7HUHcXN3Z8o9a6auN63fPH6RucyCTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b6JQTQj8kW/g6cCdcpSt34a1ND5gvVAScznXWM3eJCOKl61BnHMJCRsM9uTOqE5AwYlPXMX65jyuIIgAPmWE8RaoU5uuFj7qxi4rUrS1AYMDLmjotqqTSp39bHd9IWdSEjGDwx3hqOmKWaZpnUennEIRLR9NfzQqRhp30fUQxEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYDwtJJW; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d71bcab6fso22459287b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 17:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757722149; x=1758326949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UO/7lH/N6ZDafNfSE6DEnroDEbW/MX1V/QAkUexnxuk=;
        b=eYDwtJJW1EO4zFVkMwe1Ho15t2hNdDCF7xbUTzw38S4NRQ2EYKPdr34GB6LCl8i3P1
         UYP0q9Q8f/kBvbIN7bUGddXNEk5RDFQx/yRY8FV0+Ymp+MEseqH1v0hdkeOAOgkwV20f
         DYKtp2fTar05AaTBwJ3bX/15DXTnkkdi0xhCc1rG9QD8coMnXP9biTb6Xu+iBy6fZ6/p
         fgS5xfzIHDBJ2PZ2QvTBsDYI4Qy7jvX79HpAzDCovGHnp9+7SzFMH13aBrgDDPtYpbYW
         A9xWandLOONubXcC17SaarW/XVBkcNqhbRTr2btkZ8W0ex7GveYdSz/oF5hiv8eTNGPI
         ChDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757722149; x=1758326949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UO/7lH/N6ZDafNfSE6DEnroDEbW/MX1V/QAkUexnxuk=;
        b=jahDmy4Ds3+ujqWiSJ34NszXx8WEl9b5fTFo/V8L8lVLyAQQPQtZal2Z1xGWwQwctq
         yPcoGKplhovKiqedAxGgArCi3q3joLKNCaFSuaIFFmVaeqWT7bxadvxNUf3S/+wQFWaU
         umES3h5uBfA1lUFzIB3facW/PXiakKGE6Vr6ZMI/OEpLnlThOuPjGfhwbRkMP0jxNZ4i
         AoidkIRHw9raRBhK/i3+UBGTZjlb8NCwxbaho40G0T1KjcigPboWBaojsPUwpfSj6Eps
         aDxwjFnFJNmRZzUfTcVEXA/WxWZfCroGNaAPw+IXIn8Ej+xF5Ea9Bbuj/hA6BayMN3kF
         ZsVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWobyAWfuXBxGy04dbnAtPay0KgxxQkqvj0uQcsuj7v4hYtoMbja/kSO13L5qDTqgE4BzqZvGszudlRUTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrwT1UlUcJ1AT6w48cyCDXB6OTXMWcRmIpPB+Dy9T0LQWM1zNx
	P6yt/UKFw8dZW3l2Mtd28WYzbK4NFlGw8awkcta5n8uAfnGfbeiLtX32
X-Gm-Gg: ASbGncvZMnA+NBi6lElzKIS+m49B5FiqEU96GqybN2M3XZp4smTz7HOqArSd5BALoQo
	wyMxfVep8ijdDLXBBgchVtIbi3YLb5ac4ETHlFS5cfiOAa4sCQ4PFFDc8C5j78YSsDmIdYjgBEr
	Ge4qxv46T4Wdr283dZr5+tUHo7sJrNokUALWK9lMtkZta8+ckv0kj7X1X552MbJDHgr72lk7zg2
	QxylBY4RMTWQoisbuAa7Vu/Sv4ZoBp0z7Ua/iR0MymtH+2AgN1KMH9ezNV9Nv0sw6ShkuTpBfqh
	FXkTakcCEh2xAlEZsz6js557krkwX6Cltkxs/zw50EkoGsyWj4KLRrAuuKhNOmxzdMTA1TkDOiN
	Ow8AmjUZOAFrXs5jGlTHGr/VILCLIwYYMgyv5ZURSL9L3QOlioB9pe0NzkLEX8jnsgrHWNaVbEa
	O362c=
X-Google-Smtp-Source: AGHT+IHZWd4EJg2gnZfEA4Hk6YneuFz1ZkOf66cLLfb+s1nr3lhcJwgBnTnK2mMOety0VlhoHn2A3A==
X-Received: by 2002:a05:690c:dc4:b0:723:b37b:f75f with SMTP id 00721157ae682-730652db8fbmr50959917b3.26.1757722149288;
        Fri, 12 Sep 2025 17:09:09 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f791a3fbfsm14663937b3.48.2025.09.12.17.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 17:09:08 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH] arm64/fpsimd: simplify sme_setup()
Date: Fri, 12 Sep 2025 20:09:05 -0400
Message-ID: <20250913000906.67086-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function checks info->vq_map for emptiness right before calling
find_last_bit().

We can use the find_last_bit() output and save on bitmap_empty() call,
which is O(N).

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 arch/arm64/kernel/fpsimd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index c37f02d7194e..e3f8f51748bc 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1265,6 +1265,8 @@ void __init sme_setup(void)
 	if (!system_supports_sme())
 		return;
 
+	min_bit = find_last_bit(info->vq_map, SVE_VQ_MAX);
+
 	/*
 	 * SME doesn't require any particular vector length be
 	 * supported but it does require at least one.  We should have
@@ -1272,9 +1274,8 @@ void __init sme_setup(void)
 	 * let's double check here.  The bitmap is SVE_VQ_MAP sized for
 	 * sharing with SVE.
 	 */
-	WARN_ON(bitmap_empty(info->vq_map, SVE_VQ_MAX));
+	WARN_ON(min_bit >= SVE_VQ_MAX);
 
-	min_bit = find_last_bit(info->vq_map, SVE_VQ_MAX);
 	info->min_vl = sve_vl_from_vq(__bit_to_vq(min_bit));
 
 	max_bit = find_first_bit(info->vq_map, SVE_VQ_MAX);
-- 
2.43.0


