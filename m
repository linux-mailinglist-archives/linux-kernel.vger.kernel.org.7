Return-Path: <linux-kernel+bounces-846422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A72BC7F38
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BCDF3E750C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6390B2727FD;
	Thu,  9 Oct 2025 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bzohm/Qr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CFE26D4F8
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759997534; cv=none; b=BOMNbuox7VtY3ciLjgcoDUdmYP25g+jH5VLW8ZJG/btxueh/ehX/mXcPJPyLtjQIMlBsDqiVMYcYRmOa2795VFfTYY1MN1m5UJwQ/2Wkk7oe5mVJKbYHbt93p/MxUMdLMpQNWU1PsU6ZMYN2ZRStFMsqbVVh4RTLOC8GLK9IGco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759997534; c=relaxed/simple;
	bh=v6jHRj2p44dI50Gy8JTc+3TQXRkpYgFYA3CXdUteFZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRNdEVz4jscO3dVfoXh25t6GQBVGNpl4s9mvGG9TTdhDYFuvzxjtI2gTfpqEYJhLs8ibkTMQ+T0MMSTzJ37tzaijrFla4G/+7w2sHO+9p7SyDPJed/ATZA+MTpaR69lF95EuUpkCfhgJgrrjUfFxFfVXMCEsza/g/RZ/Hn6xREo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bzohm/Qr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759997532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h+js+P0Ye4BdT5VIhCxdEayvfzWoe+v2tZC4WwRKU3g=;
	b=Bzohm/Qrma6j05vB7O2+NyoW0TWalpxQVNQAxhrufaaIAjxxf1/Jgd9zrrwf6sQ2Jr9tUJ
	KXX6efFGI9pFSL9f3+s4Cvx3RyHxdK/0IslSfHFO+YnmR/6qwPTdweG/vLegmNV70Tgw54
	V3FHm78m/kkuPJ51ltT5J2B4Pwnb0O8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-CmHYUfIZPxeXijOR8Qt1jA-1; Thu,
 09 Oct 2025 04:12:05 -0400
X-MC-Unique: CmHYUfIZPxeXijOR8Qt1jA-1
X-Mimecast-MFC-AGG-ID: CmHYUfIZPxeXijOR8Qt1jA_1759997522
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5C7B195609D;
	Thu,  9 Oct 2025 08:12:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.54])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B64421954128;
	Thu,  9 Oct 2025 08:11:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org
Cc: Marc Zyngier <maz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-omap@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v3 1/2] arm: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Date: Thu,  9 Oct 2025 10:11:36 +0200
Message-ID: <20251009081137.117411-2-thuth@redhat.com>
In-Reply-To: <20251009081137.117411-1-thuth@redhat.com>
References: <20251009081137.117411-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Thomas Huth <thuth@redhat.com>

__ASSEMBLY__ is only defined by the Makefile of the kernel, so
this is not really useful for uapi headers (unless the userspace
Makefile defines it, too). Let's switch to __ASSEMBLER__ which
gets set automatically by the compiler when compiling assembly
code.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/arm/include/uapi/asm/ptrace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/uapi/asm/ptrace.h b/arch/arm/include/uapi/asm/ptrace.h
index 8896c23ccba78..fb829c96dc2ae 100644
--- a/arch/arm/include/uapi/asm/ptrace.h
+++ b/arch/arm/include/uapi/asm/ptrace.h
@@ -119,7 +119,7 @@
 #define PT_DATA_ADDR		0x10004
 #define PT_TEXT_END_ADDR	0x10008
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * This struct defines the way the registers are stored on the
@@ -158,6 +158,6 @@ struct pt_regs {
 #define ARM_VFPREGS_SIZE ( 32 * 8 /*fpregs*/ + 4 /*fpscr*/ )
 
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _UAPI__ASM_ARM_PTRACE_H */
-- 
2.51.0


