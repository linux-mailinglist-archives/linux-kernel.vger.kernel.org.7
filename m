Return-Path: <linux-kernel+bounces-798148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B28F9B41A04
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E07B1BA3C0A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798D62F49FC;
	Wed,  3 Sep 2025 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iqt03kzI"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382322F3C21
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756891698; cv=none; b=PbsntpO/0UWaukO5UULTsC14wtrLI3vqgrkoTGoEyzaYJlTCIiIjvwkyjwL3y8XaGtEn7AKf841iQgtxbXH9ODe2oQ6UGVw4xMYNWcW7d6P5OspQ2Pp+mVMzu9r5cDE89sgaElo8pvcw3MppoAe7fkR9YqE3BBtEGdBzf+SgCR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756891698; c=relaxed/simple;
	bh=qKKSA6BQE9yHosLS//5MBxPP+lVnakPngtoSP4h66Nc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L1aKwOESshn9z5G6JxTSfH/zTiDNgGjwzB0wqg/QXvv/PaEuUmxdEQhmWsscfHcxPC0qzw2TQDRYGt2/l7NSDH377M978ii8EVPigqI3JSaHgs7K1yqW3NTykTLFeKQz9RZ2StMs2MqIVA/PbErZPpgdJfphiPdrj5yJ5gtx7Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iqt03kzI; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b869d3572so16766335e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 02:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756891695; x=1757496495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZNErLUB5OL/PMLhd6A1jzaNLQ2AEV0NouRMBCYTl2M=;
        b=Iqt03kzIz1HnU+tg2L19yWn3CPVHCUy1plR7C62YPyqFBoqNSFv7e0Wn9ZXPfsrMbi
         BdfOX280N3LcyvziwpiXcc/aMnn3O0+oKBctjcGVn6TzXCSkVWfu6Ey4lQuGENMLWQ2Z
         6TLp3mQfCPJ+dTzZVWwpLrFrNO1K7ZiKyUXxUkdoRbvo/Uim1s7bTnclg660WPlbfA2B
         s5t4ji+IFt03UpXm8I+pdXKWm5JR1bogAHyeGGvxXKVoesE07yNiurCr0mndRPcKcfqh
         eLxe/xSiJ+qLIMl3Gs822l0TQ2ob/ItEXxdk0f9ZLKORw5frxDcmGw9HqBExq2pXXG56
         nkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756891695; x=1757496495;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OZNErLUB5OL/PMLhd6A1jzaNLQ2AEV0NouRMBCYTl2M=;
        b=o4AmcqnTOzuH8LFYNMY6JywjyWWBVPAJYi00tRD8aIOiGL/vLXrJ4PLsooluukUw9n
         TuDZTuudxn/Ud377aghUMgVu5j2P/NMbMtdvrojkB6w0bH5ynmjQagdBjVjslHpoxr6U
         qKhcGua77M4TXEJL/CWTZM5KhMmWfmQAVcFe/cc4x7EugOLwiknodIdGhbgfKFu58Vsb
         aNdBM+BnOsbBxyO7yfQfNwTWzIWOHaEtslTV6El+FyPH3s3v7bLa5TXLbIcYareawvix
         2ZmFQd91p/CdkyyRVgBaq4CVgApYuLoISSwadQoAmL4BPIlan7+NCL0DTMYoB5YCosyW
         o0iw==
X-Forwarded-Encrypted: i=1; AJvYcCWt4oZC8RxncKFNiRif9PjVitKsHI5p3Fom9966EQOWlk3kS670D9XvmZF/0JaPbozLHCz5flewlgTZfNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw6XAQ9a/vjFc6N0cVC5Pa+1QP8bMCYNFvNLOYcvy96005sybr
	mx6ksFmzfOltJMN7JCiuNaaRxd0PVnI7SB++hjQ/UrB1SKwvOX0kRdG/2aTsmjrw5DIYlfUC31s
	7e6kgTAREyw==
X-Google-Smtp-Source: AGHT+IFnWh841cOnAh3nRAM8eplxLxhfI2ZySq8PueqPfpVd5Li2djuTOGDmJgDPyjn9FbOfO4yL0Zt772wk
X-Received: from wmsr6.prod.google.com ([2002:a05:600c:8b06:b0:45b:7a6f:5dc0])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8b41:b0:45b:7be1:be1f
 with SMTP id 5b1f17b1804b1-45b8557d72amr108441325e9.32.1756891694453; Wed, 03
 Sep 2025 02:28:14 -0700 (PDT)
Date: Wed,  3 Sep 2025 09:27:54 +0000
In-Reply-To: <20250903092754.2751556-1-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250903092754.2751556-1-abarnas@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250903092754.2751556-3-abarnas@google.com>
Subject: [RFC PATCH v2 2/2] staging: media: atomisp: Simplify logic in vmem.c
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev
Cc: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add inline helper and simplify logic for subword operations in
pci/hive_isp_css_common/host/vmem.c.

Signed-off-by: Adrian Barna=C5=9B <abarnas@google.com>
---
 .../media/atomisp/pci/hive_isp_css_common/host/vmem.c    | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/vme=
m.c b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/vmem.c
index a3fe03216389..f11b0448ed83 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/vmem.c
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/vmem.c
@@ -15,18 +15,23 @@
=20
 /* Copied from SDK: sim_semantics.c */
=20
+static inline unsigned long long subword_bitmask(unsigned int start, unsig=
ned int end)
+{
+	return GENMASK_ULL(end - 1, 0) & ~(GENMASK_ULL(start, 0) >> 1);
+}
+
 /* subword bits move like this:         MSB[____xxxx____]LSB -> MSB[000000=
00xxxx]LSB */
 static inline unsigned long long
 subword(unsigned long long w, unsigned int start, unsigned int end)
 {
-	return (w & (((1ULL << (end - 1)) - 1) << 1 | 1)) >> start;
+	return (w & GENMASK_ULL(end - 1, 0)) >> start;
 }
=20
 /* clears subword bits like this: MSB[xxxx____xxxx]LSB -> MSB[xxxx0000xxxx=
]LSB */
 static inline unsigned long long
 clear_subword(unsigned long long w, unsigned int start, unsigned int end)
 {
-	return w & (~(((1ULL << (end - 1)) - 1) << 1 | 1) | ((1ULL << start) - 1)=
);
+	return w & ~subword_bitmask(start, end);
 }
=20
 #define uedge_bits (8 * sizeof(unsigned long long))
--=20
2.51.0.355.g5224444f11-goog


