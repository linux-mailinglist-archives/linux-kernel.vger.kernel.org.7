Return-Path: <linux-kernel+bounces-846437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF93BC804F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8DF442225E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B132729ACD8;
	Thu,  9 Oct 2025 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="be4/9rcN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A268A289824
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759998077; cv=none; b=KtcNC/EXh/PDQaIXG+0yd9UoXz+1NLPVlibV99aE7BgTyE2jb52lSaF7hKS5+Jcn43CcJ/YAUQqL3dDkxMh3cOxrYflKduJIVUAKoAdJkeBgO3mE8xRMkf51jKW7c0oSs9/oHnKGZas5Sd9qoYzCgTuG2s8Wd2+AyUmaKk3CzxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759998077; c=relaxed/simple;
	bh=snoFO8G+uXqlWN8+HoOWz781yCyHMMZV9qYqnC1ulwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rHtySqW38B4fR9PM/bCPaF6KriUZdrOB/s6zeI7yZyqS4vE6/e4v9Jqye8EB5j67qJoE/Z3/1+NxGELLrNOkALkhrujczO7n9P9JHCLNhUh58b/m7Z2v6TLxG6DZDaNGLb8SALTUfUOwNXPzmmNj200VnVnzwO+bP9MHOEuRRF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=be4/9rcN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759998074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uAS+qkMsvlrGMvDE3IZzNp7+IP/1UAMbFrv7U9a54xQ=;
	b=be4/9rcNpYJTgC5YAFzpVwEkcdVngLIKNFSJYEdbTJcorDyQ8nU4GFK852H+wLkDzLQgAd
	E2HrusazEV9tpZpg/74Zn1Tv8KCmydV312lWtkmj2XISiPw0sSebYUXTrUTWCkI2FOaZ4E
	AGLdyD07/TebpsJiZenUCg9r8OLjPTM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-PXMCXne5NoqbTQL7CyURjQ-1; Thu, 09 Oct 2025 04:21:13 -0400
X-MC-Unique: PXMCXne5NoqbTQL7CyURjQ-1
X-Mimecast-MFC-AGG-ID: PXMCXne5NoqbTQL7CyURjQ_1759998072
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b2d1072a9c4so51416666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 01:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759998072; x=1760602872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAS+qkMsvlrGMvDE3IZzNp7+IP/1UAMbFrv7U9a54xQ=;
        b=HxWMGeFKEIIeQylOSUIfbM+9mZRLKCtPMX1aP6849hnKQ33y66jkI0xmN2PTcrkhOx
         u+p/B3q1NYF3OLGtWaRWd+yHN+duf7xW79rDQJcIDz9OvCoj1Y4MdL6ZjS0xKgyW/GMg
         /znze7vz4M8ZBLB0/2euKa+O4sS2/KGu5QaU7jPgQEdFISUkjWpW0NBXecSasbH0fauy
         EfWqOq/ALQOEtT6dqabgqK79MEGamg21foImcSJ91QosqgRuS7YPT7VkUOJ8JxNPqAYU
         EedtyNmlH2xKkwKNXBIWtJfS91bVe+F9P6oC/K24mGgJLBcEZodSvfx72Ou02JHHa5Ca
         Xu/Q==
X-Gm-Message-State: AOJu0YwRLx5au1vsHozkyhqWWDb57jbFqzmD4TNQqhye7r0V8gydPRko
	z7aNS/7/fNHjeWnCBtzHxx9dOAUWWiocR7+jkioYsbmmg93h/lLyTN89soDTrkRbxpCBlagGp65
	7gDXVL0SuFttAe3etjEFmhDyqiJllWUNDihDSiuz0VEu+vlVDCWuwE0u7qQG+kadU0+Z6U0gqFD
	Kvys8yLMQkqCoMux5r1hjrhgigfYm0FotOSd0wisKzGwpEQZQFANV3
X-Gm-Gg: ASbGncv3z6XsbiGFy0CrIDXN+EaEpWgan7UQdAqaO04cVTxmW4m6NhteY1v1IEpnKDZ
	i0n1FDa7AxpkTbNbIt9CDzrYtaQMpDAOvFbjPVlCdIyqj6zq0uomBOYMXhn6pGDMWDyQlAjC2xC
	eAnE1dM8zwA28zyDlJXUCIyR5numVE3nQn+N3qMwUtRJ0tlTn0uek4D6wYfPJDd/buVS9/eshPZ
	E3Z5DWLePxIcchzUeoQWsktcSQ+O9kCnC08GlxwFeh+MdWFVyYSEJ+9De0RoYitYCacyJVvPWdD
	NeeVzCZIFQEe5KC8EdCbqTFh8RREVKy4FTpGBi7mJZTCNk37+6rN
X-Received: by 2002:a17:907:961b:b0:b0e:d477:4972 with SMTP id a640c23a62f3a-b50aa7a086amr745876766b.25.1759998071633;
        Thu, 09 Oct 2025 01:21:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2yb0GW1Dmb4of5uiYM3V2RwnL7r4BajO4YJiE5GftpOYhzsHAtgMNkDAR7AnfSfgfWS6gIw==
X-Received: by 2002:a17:907:961b:b0:b0e:d477:4972 with SMTP id a640c23a62f3a-b50aa7a086amr745872566b.25.1759998071078;
        Thu, 09 Oct 2025 01:21:11 -0700 (PDT)
Received: from holism.redhat.com ([148.252.9.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b4e27dsm1832988266b.70.2025.10.09.01.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 01:21:10 -0700 (PDT)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Lucas Zampieri <lzampier@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 0/3] Add UltraRISC DP1000 PLIC support
Date: Thu,  9 Oct 2025 09:20:10 +0100
Message-ID: <20251009082013.1331361-1-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the PLIC implementation in the UltraRISC
DP1000 SoC. The DP1000 PLIC claim register has a hardware bug where
reading it while multiple interrupts are pending can return the wrong
interrupt ID. The workaround temporarily disables all interrupts except
the first pending one before reading the claim register, then restores
the previous state. This is implemented as PLIC_QUIRK_CLAIM_REGISTER,
activated only for "ultrarisc,dp1000-plic" compatible strings.

Charles Mirabile (2):
  dt-bindings: interrupt-controller: add UltraRISC DP1000 PLIC
  irqchip/plic: add support for UltraRISC DP1000 PLIC

Lucas Zampieri (1):
  dt-bindings: vendor-prefixes: add UltraRISC

 .../devicetree/bindings/vendor-prefixes.yaml      |  2 +
 .../interrupt-controller/sifive,plic-1.0.0.yaml    |  2 +
 drivers/irqchip/irq-sifive-plic.c                  | 83 ++++++++++++++++++-
 3 files changed, 86 insertions(+), 1 deletion(-)

--
2.51.0


