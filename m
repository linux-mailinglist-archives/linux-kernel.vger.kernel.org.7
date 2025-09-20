Return-Path: <linux-kernel+bounces-825905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A76A2B8D134
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 22:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E691B2737D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 20:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671BD2E8E0D;
	Sat, 20 Sep 2025 20:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OtNloihb"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E487E2E7BA9
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 20:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400757; cv=none; b=ehhbcVjaMy5IBSWJTUTjLDhXF2K3p1JD5/zx5gq0Y2Jqb8dCQYVLBWDyHFE36ZSx8Tm/qo3Xj8DLH6jBKeJbbjraBs4YiiYHsPZBYMGq7ohhStt6R1WOgNfd8gu9bUBpkH7iOc6YEMkq5TtMZ8BbxtAHwlubr64k5j1reRlkRt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400757; c=relaxed/simple;
	bh=E+sSPT+kUSejcvl41Q1TeDzQ8VYDhNgMKLADnh8bTf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ai+0G2i+aiNQRK0oLe8ovZt883eFa9dTfYMpD4SvqS1lbevxAFcd8qe1BVwjLRZIK6dGDVE1JSj7gHuKW6cWsobk4ixAyJgFB9ZbLjw3Rx9VZ0mZtz9usNDBmtQfsUYapFUw56dTUdynySnxjWaGWR0Jan81s27yifciFiPvJxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OtNloihb; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-89336854730so112505939f.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 13:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400755; x=1759005555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhgo805sVSiR0SJlmhLHBR/NhPzSwBuZgQ2sQCeXYLE=;
        b=OtNloihbqXsX22NyniNkWSaq26qpE4C4ptOgb9jMqrBTcAnhvNDZdy7O91fL6mVBaI
         wSp7sXRihmaLyA+N8p0hriJ3C0k7rfQbxmM75Be3pdrKlGMaqQk+vuFSjqjAArmWBJgR
         Ix2yVHVrIVtvFOc3HlcMQY0HbH5Y+XAv8mJaJCnrOCoZ5UhDL3laSs+Q8n1SRDIhlbiv
         ruzTOHP4sSQkSVa9RD6VOkRVnoSE0d+Sg7I3VUR/3sMPTfWxGH6H+hUIlJ2N0F+lOZ2L
         upruHfLSn1CjNYbqyC690BKiQ4K8FhmabgyFPvfDNZvxH3DuBNZd1bwVDQ0NPgGE0zGP
         4aDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400755; x=1759005555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhgo805sVSiR0SJlmhLHBR/NhPzSwBuZgQ2sQCeXYLE=;
        b=LIy7wEkWmdIIp6joQGNzphDvJ4QSjoY5TmJMuCDdy9j7r3StvxP0E4myqLkJKeJ67D
         3fQLzLMdmMu8W18a6vpCl6F9v3CmOD2kpOIjCHTWetZlL82LyQkn2XV4p3ONkNK59Md7
         GiK57Vi5FTB+A5gyCA9lq2/gEpuyoHMoUzm8q2ABMm5NE+mVEscsgreUgPrcUwjwZjN8
         ttOpqZZbWdapigSjFKXrxXqXw4IQV+zwDTvO7T/+0fzMExWXiaFeqC/IktR9XiiXGMC7
         mKN22OjvGQ7tl4ZlIbQ2p6qmcLzJAXTxr1LcWLfXMXKyU4BSZY3SPDvueUodpAvgr+kK
         97vg==
X-Forwarded-Encrypted: i=1; AJvYcCVYPnDcrfMyH25aY5rIa6flpgHiOSpOBEBvbG23+u/T0B+6FFKxbEkvurtnrmdb76rmceLbrEdpytdzkuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrQpvrvvH9RAe/xCwnrDAa/AIoLO7ZxY4ryRl71zjiHOBx5QWU
	bP1r3ThOZj5vrrrYf9Z5psEiD/3fHqdVfIupkIDdu1CbPKJldDDWZZ/jJGnU0SKuTh48N0GZSnv
	PmQIt1dY=
X-Gm-Gg: ASbGncvDJi+0iGggt80qjkM5eKjitqyNFf8JLqKiqMPoxdOqkRHjHyeVcH7McNASKkN
	3QfUJ47ZuMfOBzDF76fkeecqN54lS/vDR7y++Jc8OKow3FvKGp63ovM/8wnP1Fwg3PvRgOq2bmx
	zA0cXY0zQ9nhrVIBkMEE2MkBXixgHczdRd0Z2JnWMgmkIMEI3T3bkfonm8VO2JHCgSzCAkBBJSV
	KBaTvb1dUKbRtSDTumRCvKIhiz0TTexBPFNOhphSaYiOSjZNchUjDfJJmvhe4Uw04a9zAsnya/v
	yDZv+0VIq3gIr+4HzSJ9m4jRAgqslEfxhl1RuSSkYRog//uQoOAL5PLHK7tekxv+KpE8eX3X/Jl
	gHiMZE0CCmZm3JnNbw35rzcTUyOY6HgxS0Nk=
X-Google-Smtp-Source: AGHT+IFpmX9UAkdlqyKeAFy3AzOo21LtEJum96Rzv+8iJlkbfeuTwtEuWDKpDYd555ixOqfVlv44jw==
X-Received: by 2002:a5d:8791:0:b0:886:c53c:9175 with SMTP id ca18e2360f4ac-8ade08247f9mr1118249839f.16.1758400754919;
        Sat, 20 Sep 2025 13:39:14 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-54cfd9b688esm2100997173.84.2025.09.20.13.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:39:14 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: jgg@nvidia.com,
	zong.li@sifive.com,
	tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alex@ghiti.fr
Subject: [RFC PATCH v2 17/18] RISC-V: defconfig: Add VFIO modules
Date: Sat, 20 Sep 2025 15:39:07 -0500
Message-ID: <20250920203851.2205115-37-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250920203851.2205115-20-ajones@ventanamicro.com>
References: <20250920203851.2205115-20-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the VFIO modules to the defconfig to complement KVM now
that there is IOMMU support.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 7b5eed17611a..633aed46064f 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -242,6 +242,8 @@ CONFIG_DMADEVICES=y
 CONFIG_DMA_SUN6I=m
 CONFIG_DW_AXI_DMAC=y
 CONFIG_DWMAC_THEAD=m
+CONFIG_VFIO=m
+CONFIG_VFIO_PCI=m
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y
-- 
2.49.0


