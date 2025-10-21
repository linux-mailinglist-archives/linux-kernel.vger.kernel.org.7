Return-Path: <linux-kernel+bounces-862377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAADBF51FD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 720CD4F72E0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7657E280A5A;
	Tue, 21 Oct 2025 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UVSOD8EJ"
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B806E29405
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761033450; cv=none; b=fnqT0Ebjw20Z9iGdZCciCDb5h39LF6j0CbFdbZQi3GbB/JlLaPRHuPv4YY8mYpBsCGSAWfOytv6fZ9QjGkm3EbAhkCWyZR0rM37TkYRVQhyqHuqoSRylcOdAMII5xo9SHukXn0lflWOl/q2CxYtX16S/jM2dFaJ94hnZnuX2hi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761033450; c=relaxed/simple;
	bh=vR8Sg8f9DgI5ghBZTFKtP/Zk/FTSk2p996vJs7NdI4k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=umcJNOrG4g18B1HxPjedq6WfhcPpafpmlngfuQkWJTMi03SKq3lGdAToeflIBovw2SDDF0DFXhKEfzMtsKuoJms2AFp36ubmxExkTMBJB7X8T/yScdvSG7zN9w3f3k2GYsH1bnblY1uwLCI9TlkVHP7iCml0cOizQmQsEWPSTEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UVSOD8EJ; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b67684e2904so3731127a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761033447; x=1761638247; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxKmkMUC7SLSSXycoYWmPuuYk4wsq74U2h9gzpD2Te0=;
        b=UVSOD8EJJH5KzRHaKD6Az4bIebt9VBR7gVTTPLpMQDiWdPZxVaLMo1C2P/BOsxpCrQ
         ogbFCkmDCMT+OKdD672su6bEcRDArfKisumt2Jl935R0MIRFF5JeJQOHp6FGB6znH9z1
         isWGBg8zo5qw+yKHpxWlJtDFZ6iwFq5K84JJ61AKY1Ehk5I8V9igx73aM0Ft+Tp8/fvn
         /58E4C8jLbM494jXw4wbGC3u9KxniISf7jhXYnt1ee/4uO9CSu6C1k48tqcea5lhw1fW
         K1ZNmAdzkxGfZTjWVhBeR8i7nDj/6E0yqAKEdjkgRTknyJ9kbwKfMuTq26OJzkZucu+/
         vcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761033447; x=1761638247;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxKmkMUC7SLSSXycoYWmPuuYk4wsq74U2h9gzpD2Te0=;
        b=lSNBjspB4MC8ZbOIT56oTOUtSfhkVCZtBrBe+KpaGsV8XeMygRESRRDjAMyr+wpxtm
         6cH6VBOo02Xr+82fiKbh9+NZ85MPxda92CbbOr+DneiDXwZQrX1O98UblOzmIjlDLg5i
         HnxbEMcipQ0EgYVvlmu5ebbcq5l6woj0f3BSPgR7DV9qfZoWEWwMq5gBKoonT/5btxwe
         m15i3vZbgZ0xmUASWaYFkEEsLt2AUcS2mGZxOMjsg1+IzPueCTxiIsto/X2DZW/GXf5B
         sPPoczN1NsOQykdKELXkKU8oHUtkO7pRTUS+ys7h/W1Htuu9YzXmurbMquoJ++h0I9oO
         qYkw==
X-Forwarded-Encrypted: i=1; AJvYcCW1at0oVMbOvzpg+EbBjSCHdxfKfhBn/+ZyfAxphqg3KkyNod+8HUAcqTFJWwpPhzTPk/I4vQTBgWHe9Jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcFQUXx9+VOKElqeAb+Pjx7QA6xnWuwgHQ0QtKnAiurv8qClqk
	PpwOLqABjJvj7u7E1l3zghZywCuvQF73YhD3UDHjQze77skXBFogDf5STF5xqBNglFQ=
X-Gm-Gg: ASbGncsL2bOZ7x2jUsizhVUl23W1FxUHjaTKF5Jy3AJrdm9FcY2q5zJPxubBinf2XOc
	shTJOHPnRzPSCZcwd3pQ9Sdvyi5qkwRyKiiO2n6OiOneKgbYeu0ue9QJd31owFlkn8Tzlun4gEI
	lxt53q6Vi/FeuGBvFPNpaFHbQv/HpUL0LZs2fmUyw63mLcANvggAyDYYGvsuz+FFSvKVNsJWeIG
	HgBbfgrPHMCSBkoAnyCsIs7ACbITAN1P6HWN3P6DD2GCsyCEJVzfsE4fjVGa9yUgnUz9Ed6/cHj
	hS7rYH3o/+RFjWwb/1QcLrlP17gTnjsVRSQMKELCpjyfVBRYEdq6T7mCERisd7VOOwopfCAn0Ic
	j9EC2G1yheIyU5jB5bviJMpCpfyidyVyuipf3iZJjqwX9M9PxuSUi1sX0FifATq53La3FW/54gn
	I5V5NCTyfdA1oeY6uM0azECxPGCKAqM/7H
X-Google-Smtp-Source: AGHT+IE1Zrj+jGbHeZnz4HX2VMGus/Y7tQa5nFM5l7VqdiC9z6XL6budsIJb6zyS3HuL2F7Tfksndg==
X-Received: by 2002:a17:902:e544:b0:26b:5346:5857 with SMTP id d9443c01a7336-290c9cd4b82mr189585185ad.24.1761033446959;
        Tue, 21 Oct 2025 00:57:26 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([203.208.189.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d7e41sm102083085ad.57.2025.10.21.00.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 00:57:26 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	jsd@semihalf.com,
	andi.shyti@kernel.org
Cc: guojinhui.liam@bytedance.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] i2c: designware: Fix SMBUS Master interrupts storms
Date: Tue, 21 Oct 2025 15:57:13 +0800
Message-Id: <20251021075714.3712-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi all,

We hit interrupt storms on the SMBus master extend-clock timeout IRQ
and SMBUS Slave Clock Extend Timeout IRQ because broken firmware left
IC_SMBUS=1 while the driver IRQ handler never services SMBus events.

Since we cannot disable IC_SMBUS directly, mask its interrupts to
prevent floods and make the driver more robust.

Thanks,
Jinhui

---
v1: https://lore.kernel.org/all/20251011073057.2959-1-guojinhui.liam@bytedance.com/
v2: https://lore.kernel.org/all/20251021072431.3427-1-guojinhui.liam@bytedance.com/

Changelog in v1 -> v2 (suggested by Mika and Andy Shevchenko)
 - Drop the stand-alone i2c_dw_disable_smbus_intr() wrapper and mask
   the SMBus interrupt directly in i2c_dw_init_master() after the
   adapter is disabled. [Tested]
 - Align the DW_IC_SMBUS_INTR_MASK macro definition to three TABs so
   that it matches the surrounding macro indentation style.
Changelog in v2 -> v3
 - Add Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Jinhui Guo (1):
  i2c: designware: Disable SMBus interrupts to prevent storms from
    mis-configured firmware

 drivers/i2c/busses/i2c-designware-core.h   | 1 +
 drivers/i2c/busses/i2c-designware-master.c | 7 +++++++
 2 files changed, 8 insertions(+)

-- 
2.20.1


