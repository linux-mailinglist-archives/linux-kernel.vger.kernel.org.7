Return-Path: <linux-kernel+bounces-838348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DABBBAF014
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A24E1C8890
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5465C283FE8;
	Wed,  1 Oct 2025 02:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="NwkfWIAi"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1B9279DB5
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759285325; cv=pass; b=omEQ+K+V5Rhi00/CddBnDgYRNFnMDp+eADMqHaNMJ5A0hz/dKNcGQ+1kLe3zPb6BBog0yAL6QEk+Cha2kEaMoxTVvWn61XYoSUFAe67YG8H7XutFSaP/CK0Tzp1L9lHXjZ5JmLnaIiD4qUov1lO3laPfHDWTq4ISobfHsflCBPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759285325; c=relaxed/simple;
	bh=uhW78c9WYmd7qmGnyc5byd9/WeK8N8eGipEG9Me9lJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gR2VdkTUnu5qnVTPZJX3BJDqn5K5HiCd1N/at71EFaXeILAXs3zS+sQ5qzrIHFxNP3SRjAZ523CaCiNBDTy4z7XkZ85xhaKC4QROfwVUDZ2QeO/EdiCjzbTOlXtxV6Gj/bt+/ae12lGCybm6TPh3PZML6mW1dPB4EL0aC2cR0BU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=NwkfWIAi; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759285302; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JhTERvBUTXjmkjH2n9keKzfz5zRtZyxf9hFJhi+09ywQuIsWi0PdqwjPNcyyVC3/Vtk2pEVR/MnskAz3VkjWcT4fyXSOVLxeZ7Ba08dV7RhswcBN08y6ekrudH44cqeVugdhoL706Xs81FRU8qz/i4LWyDesFLKWAMHpxMhDRoY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759285302; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/DuCVIo25xMaaA0q76PJtVL+EmE9+q7pgG4XQRIF+dw=; 
	b=PURW5+NKmnqM/sN22m8mXJcoX4dgjUf76ZhX4tG9sINKPsIuY3f3gNEoSHhHFsVCW0NAq3TXHUkKdplX87/5vvdqI5yx8h6E3bSTL5k7rV+Lfb9sA2LEfUkllL8cSSgtGehyYraWDqqKawSprchPQMCzqpnR9LkYDjjYjRXnDPg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759285302;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/DuCVIo25xMaaA0q76PJtVL+EmE9+q7pgG4XQRIF+dw=;
	b=NwkfWIAiJYJgeDwy+x64GlMFsVoVBfB2TYxf7SrSCSn/ZlEoBc0LZ4q5xf9exUbJ
	y+bKEZnnLvkl96QPfnji8GMnMUOM468c52tw2MfBbpPiZGCZL5CAcaRJgNJJFHGZgK3
	Ee8yKHabhPWXySCpi4GS5EWGyAPVa3NSwL+bSeHw=
Received: by mx.zohomail.com with SMTPS id 1759285300196913.1802621807027;
	Tue, 30 Sep 2025 19:21:40 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	llvm@lists.linux.dev
Subject: [PATCH v4 08/10] drm/panfrost: Add forward declaration and types header
Date: Wed,  1 Oct 2025 03:20:29 +0100
Message-ID: <20251001022039.1215976-9-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001022039.1215976-1-adrian.larumbe@collabora.com>
References: <20251001022039.1215976-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is to make LLVM syntactic analysers happy.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.h b/drivers/gpu/drm/panfrost/panfrost_mmu.h
index e6e6966a0cca..27c3c65ed074 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.h
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.h
@@ -4,6 +4,7 @@
 #ifndef __PANFROST_MMU_H__
 #define __PANFROST_MMU_H__
 
+struct panfrost_device;
 struct panfrost_gem_mapping;
 struct panfrost_file_priv;
 struct panfrost_mmu;
-- 
2.51.0


