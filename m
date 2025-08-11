Return-Path: <linux-kernel+bounces-762215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE79B20399
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10DA317D6AE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030772E091C;
	Mon, 11 Aug 2025 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f9RO666z"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5336B2E040B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904510; cv=none; b=hOjSvRpplRYmfHUOcBV0xzdo8UM1deiIlDZPsUaTZd6sJaeHXx/e6Kmvh1MErUAoRdYq8JSv3e8luD9M9S57/tjg5n8zzpGRdO4fEpeaQ0vH069tvck99yCNcmQmf+kJFcg6EZHGAGEvbe4eHDuQx51ASGjHa3p5ko6XhwdrCfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904510; c=relaxed/simple;
	bh=TxDsANSYkY/rtN7uqqxyADIxZrD3oTuk8v/DtW9VjTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HCvziVRpSUVNnN+Cz06GZJ6B7X8eZACzdUKFrDrd61H+cf62OPDfOaYUejA4o3XEWqn/cotpzCeOPq/Am/9epcFPBlH5d0mnjCrnggsRmqXjLtJLcGpHS2d7rzJKZq4OyGrgwtClu76X/S3e7TrryR6Uc0sfEDUvuocFY3iYx1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f9RO666z; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754904506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PElj3O+nt9JkRibcu8eYjPBnu7dzdN2l5hUggEeCVbs=;
	b=f9RO666z7SlP1Xsw4N01Pdmzbe9xXH7Lu63qZvxV6a48js4Dv6akRmXPYlbeb5dgoAmYOH
	xEfy6DwQoZV2sJdxNl0TlU3UEk9NmLuIMJnEIgCl5FR0fw5twrTZpgOSqQyx+UE9v3coNT
	p3r4GLhYyhaW+b9yhKkSMDsmn9SVRJY=
From: Youling Tang <youling.tang@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH 6/6] LoongArch: Enable CONFIG_KEXEC_FILE
Date: Mon, 11 Aug 2025 17:26:59 +0800
Message-Id: <20250811092659.14903-7-youling.tang@linux.dev>
In-Reply-To: <20250811092659.14903-1-youling.tang@linux.dev>
References: <20250811092659.14903-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

This patch enables config KEXEC_FILE by default in the
loongson3_defconfig, so that user-space tools like kexec-tools
can use the same as the default interface for kexec/kdump
on LoongArch.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 arch/loongarch/configs/loongson3_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index 34eaee0384c9..6cfea2f37cc0 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -45,6 +45,7 @@ CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PERF_EVENTS=y
 CONFIG_KEXEC=y
+CONFIG_KEXEC_FILE=y
 CONFIG_CRASH_DUMP=y
 CONFIG_LOONGARCH=y
 CONFIG_64BIT=y
-- 
2.34.1


