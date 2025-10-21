Return-Path: <linux-kernel+bounces-862302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F02C1BF4F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 762F14F7210
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E3827B331;
	Tue, 21 Oct 2025 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="L8LwHCG6"
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4B227B32C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761031501; cv=none; b=cM9w7cdcIZd0793mnZu3BZMEm14D5Jo6CeOFe0FB8w865pWAGlSy5JGBbYtFr5iTYSpGfQ4M8BplADIkEF4k11mOwAo2zqji2PgTRmHoihm2WxzDpjbyh6Z2KjSs+yKWDCjZHzYeL5fiOrLF9SCvAAACPvWGiZn1wZ4JozngoYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761031501; c=relaxed/simple;
	bh=T6QU9qfWd8XxEqHaPu2yKIrWr4Eupu0qKSG3FOUJNvE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=aBudHGelG4dPQvh7WhmiI1W2nkPeeUwkNT3iP2QhEQACFe9pZr6tGp91xsrpkJ1ktQKoNDucYnBUy23y4pjYaUzIDJIYsHr6dKEgCrNAQcBIzMHA0ob8yG74d1hcpkQ6IbiSfxa3CATLoKhw5PYfY7FYIU4+PYX6stiswS4mhL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=L8LwHCG6; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b5526b7c54eso3401494a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761031499; x=1761636299; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcjwoMNg8xapeElJXeStXRuTW96curqBa1UPKQuiCy4=;
        b=L8LwHCG6fe1oPmzjD0ed5340+QGbl6rlw8Ac19uSjE2MDNBlDUjncfIcmt62UwSKWA
         XStq1Cq4WyQzAxi08T8KvJfvNh7BVyMfy+ZiNP6Y/s4jRWPb/RZ8pQcVqKfsY8T8zu/r
         Ae3Qhr5suz7N7XXmQMH4etEalpOqoBuAQ15atNDbX0JJ/F65SzQq2z/f8gB5tnpeYXxM
         ZolzS9WtpX6FzHhnt13TmardSP72LA4oPvqH80mQtu6p67++tq58hbJkT/iHMOxg/XZI
         fAD/VgByvSfyYUle0m8s8VJRSz+k5uNsans5jA0+1UyWWyw0N0YOgWUyElci2u8p+Idn
         OFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761031499; x=1761636299;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcjwoMNg8xapeElJXeStXRuTW96curqBa1UPKQuiCy4=;
        b=CfsYV0iECFwEntNMzL2XDoaSjMqIdJyLIhBT1Ku5U7pOurBTNRCwSDmYVtVpB+3w6e
         jW+ZDaeDiyb56oV/H3NGELAj90vMM9p/WTNujpuDSrG/CmFjhOWb6316vCNGA0tvbuq7
         u0aPW3Dcxhr5C4XBo7TKc00xngBQaGDKALxz5x+VKdb9ZbV6jA2oTtARSfEQgoUdgas7
         w6NPOtS8gt9hQvU8a36mRcZaV69mqlJKIK06lfM4dZfyN26+OI9Z68rFQcneJXm8Af3t
         IswvgucgaLW2i3gKb7MnsAzLoGbL4++AyZyo0eVkbRbCyCxtaX7O+JHOg95jiCdArqvt
         6osw==
X-Forwarded-Encrypted: i=1; AJvYcCXwyiJOEgdpCGZiFB/cGRvoPTVmuFGBsti/CbJ6g70x2bJnn8b+rRrOq0IX2dBR4cQtpqoy8FkpMuWYgu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAEMxEIL8dOs0lQhDeP6GHiLjKEg31dkfZQSvsALi4lmokOp5O
	ZI6gkdOnNo11HTt29AOumHWdqqhqN1XvsZ0dhuHjkU4vpz7i1caAksooqMZPrBk/cCU=
X-Gm-Gg: ASbGnct1/0e9rB4jYVjuwB41DISQ9QpuyYA9rn5EYxD3KO6kLI7zqHw9Pp0mVj1vfmd
	6tB0VO+Cf3prOF/lMouK37zlYhZbMOgzVHGuEbBgsvEMpyHTpGzxz51X58EA9Biq0UWOXde6hr2
	1b7fY2ObQ3X1EVptuqDVIRYv/u+yPQziyUbTdv5pVyDKIC+vmJmOhOT+VqxPVzdB4RzV2IJjmWX
	PSSgpc14njBOzgcjKgmpfhxwabkW8Bso8/JSA6TLxrDmx7L7g6EXM36IhRe+MDfnM0TI0V7bu0f
	F5XEkDD7eJTfUvrT8J9/BxoL4f9bMcVSP4/Gt2OQ+RHjOdtYH6M/duBbaC1wHsw00fndQNME+5G
	sjYgzalHxLoK2Qz8Mky7C+PVNug3spUdI0jgNx6CIyN4bDpvF7XuV94UeNDzUA7e4Ir0/VS1LD7
	dvN/A03vTdhmMAAxcKLd8KlTlnAzLB1uIETg==
X-Google-Smtp-Source: AGHT+IFzWgrQVZzVX7nEOgExqLtglKwMQ47s3V8pusPPGP8s1DH1p6CnhaKMiVW+v7YKyJQGnw64Hg==
X-Received: by 2002:a17:902:f548:b0:276:76e1:2e84 with SMTP id d9443c01a7336-290c9c8941dmr195197375ad.3.1761031498734;
        Tue, 21 Oct 2025 00:24:58 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([203.208.189.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fdbe35sm100207415ad.46.2025.10.21.00.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 00:24:58 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	jsd@semihalf.com,
	andi.shyti@kernel.org
Cc: guojinhui.liam@bytedance.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] i2c: designware: Fix SMBUS Master interrupts storms
Date: Tue, 21 Oct 2025 15:24:30 +0800
Message-Id: <20251021072431.3427-1-guojinhui.liam@bytedance.com>
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

Changelog in v1 -> v2 (suggested by Mika and Andy Shevchenko)
 - Drop the stand-alone i2c_dw_disable_smbus_intr() wrapper and mask
   the SMBus interrupt directly in i2c_dw_init_master() after the
   adapter is disabled. [Tested]
 - Align the DW_IC_SMBUS_INTR_MASK macro definition to three TABs so
   that it matches the surrounding macro indentation style.

Jinhui Guo (1):
  i2c: designware: Disable SMBus interrupts to prevent storms from
    mis-configured firmware

 drivers/i2c/busses/i2c-designware-core.h   | 1 +
 drivers/i2c/busses/i2c-designware-master.c | 7 +++++++
 2 files changed, 8 insertions(+)

-- 
2.20.1


