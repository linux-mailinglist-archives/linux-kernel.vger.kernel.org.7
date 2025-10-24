Return-Path: <linux-kernel+bounces-869095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF21BC06F4E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC523A66CD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F33326D69;
	Fri, 24 Oct 2025 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="FNQTPvIV"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF44231B818;
	Fri, 24 Oct 2025 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319328; cv=none; b=OyD2JotagjKoXW7ELmpdnLnWVjbzsuUHhA1QOsqySdxLFzzZ1hIjgm9GlrDvAthkZw+l3za4N1vbH0EnyxwHn08ddwb5R+95epScHjuzKWgnQNl9+2YX3rFhb7go/w5k7g9gmCT/gb65lXLOqD65QqJN5GsQyZWdvMt69alpNFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319328; c=relaxed/simple;
	bh=J97O0gy19THHX1kF4l0gMAqLSqGTQ6dQhuo6uTfdNg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atbxk1LkLxrCkAUank9lUkg/jAO4i1gnDhJXMk9xYjc5sS7RplzKT05qAq05BLFrgJbBBneCoLuuRohi2xsAyprdPuUMOA7xXBG+69caTGR3d/2a3ANg4j6+qToxVAucX6W2w++LuW9UCqTzNlemP6ODU+uC1pNQVP6c1jAqEjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=FNQTPvIV; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 56CE0C5A95;
	Fri, 24 Oct 2025 18:21:57 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 65618C5A82;
	Fri, 24 Oct 2025 18:21:56 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 8D3611FF3B7;
	Fri, 24 Oct 2025 18:21:55 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761319316;
	bh=JJVdLpuuoN7Ey2TA0jAHTDArPbpsi9mkPVCpVyaJYxg=; h=From:To:Subject;
	b=FNQTPvIVl03tN72nA4lHiskt0NYbdvgW5jc83ZsRUimydXbL5uJ943lFMPuNgxEjH
	 BsvHh1DyOmPD18wy12Qkaw/LCyFHILK6s+Z4AV7mFLAQM0/BfIbql13QdeKwO0qx2R
	 jwkc7Dh72dNowt46Tjt3lxIPrxPabUGm4UuoNBa5vLyq7rTgHO0iPnS7JTopsZ+FeO
	 +4NWYjn4MSuVsINaIz+x4k9SjR7F9w5kI3yzSFnWL93MxXmRge9mZrNQ3FPROMNR2K
	 8iyTq38qMwVzlv9NdEvYJnUlxJ5DgbnDEQEUwny9mCsm0l4Wz3d4Q7xSX3jRRh7Ssi
	 5sw08qls4qjXA==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:8d8a:5967:d692:ea4e) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: Alex Deucher <alexander.deucher@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v1 1/3] platform/x86/amd/pmc: Add support for Van Gogh SoC
Date: Fri, 24 Oct 2025 17:21:50 +0200
Message-ID: <20251024152152.3981721-2-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024152152.3981721-1-lkml@antheas.dev>
References: <20251024152152.3981721-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176131931608.2356044.2892426762375888799@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

The ROG Xbox Ally (non-X) SoC features a similar architecture to the
Steam Deck. While the Steam Deck supports S3 (s2idle causes a crash),
this support was dropped by the Xbox Ally which only S0ix suspend.

Since the handler is missing here, this causes the device to not suspend
and the AMD GPU driver to crash while trying to resume afterwards due to
a power hang.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4659
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/amd/pmc/pmc.c | 3 +++
 drivers/platform/x86/amd/pmc/pmc.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index bd318fd02ccf..cae3fcafd4d7 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -106,6 +106,7 @@ static void amd_pmc_get_ip_info(struct amd_pmc_dev *dev)
 	switch (dev->cpu_id) {
 	case AMD_CPU_ID_PCO:
 	case AMD_CPU_ID_RN:
+	case AMD_CPU_ID_VG:
 	case AMD_CPU_ID_YC:
 	case AMD_CPU_ID_CB:
 		dev->num_ips = 12;
@@ -517,6 +518,7 @@ static int amd_pmc_get_os_hint(struct amd_pmc_dev *dev)
 	case AMD_CPU_ID_PCO:
 		return MSG_OS_HINT_PCO;
 	case AMD_CPU_ID_RN:
+	case AMD_CPU_ID_VG:
 	case AMD_CPU_ID_YC:
 	case AMD_CPU_ID_CB:
 	case AMD_CPU_ID_PS:
@@ -717,6 +719,7 @@ static const struct pci_device_id pmc_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_RV) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_SP) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_SHP) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_VG) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_ROOT) },
 	{ }
diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/platform/x86/amd/pmc/pmc.h
index 62f3e51020fd..fe3f53eb5955 100644
--- a/drivers/platform/x86/amd/pmc/pmc.h
+++ b/drivers/platform/x86/amd/pmc/pmc.h
@@ -156,6 +156,7 @@ void amd_mp2_stb_deinit(struct amd_pmc_dev *dev);
 #define AMD_CPU_ID_RN			0x1630
 #define AMD_CPU_ID_PCO			AMD_CPU_ID_RV
 #define AMD_CPU_ID_CZN			AMD_CPU_ID_RN
+#define AMD_CPU_ID_VG			0x1645
 #define AMD_CPU_ID_YC			0x14B5
 #define AMD_CPU_ID_CB			0x14D8
 #define AMD_CPU_ID_PS			0x14E8
-- 
2.51.0



