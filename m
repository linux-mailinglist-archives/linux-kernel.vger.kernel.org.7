Return-Path: <linux-kernel+bounces-869097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C1EC06F5A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7821E3A9685
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C03328616;
	Fri, 24 Oct 2025 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="AYLkTAHl"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0E1324B34;
	Fri, 24 Oct 2025 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319329; cv=none; b=Q6vEaMZm+hEWSDXOh2+AS1IqmPSnc8eDShAJlVpQE3+SHDFbHzrk1MgHBY1dW2PrmuhjcSelR3zPu16fO3HH0vP/USjoH8B2tw7qCbHbuIj0PzjlHJpwOxNubuZX5Cr0HIbCquVKVdgPAL5voAY8or4v3AedYFC39uObgfazzu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319329; c=relaxed/simple;
	bh=igXnLMGIRHRQSQecw9JgC1k/EuG7mF53Mh3ai/1f01A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uv0LDS8xAAPqMhbOlGe/6Egku1rGTW40ebPMEm8WK0vk7jAECv/BlGyUmxThLPSCsyGznZxJiWsKYOSJdqPm6RMQwWDTsm7gaXYFWbnML/OokAvhiWp9L4gRxOhS2fV+0xGRc42cPfwqeDJsqnlaQT7BlCZo7jFEiqLW8AwA1eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=AYLkTAHl; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id CA228C5A82;
	Fri, 24 Oct 2025 18:21:57 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 2A579C5A87;
	Fri, 24 Oct 2025 18:21:57 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 5953F1FEBB1;
	Fri, 24 Oct 2025 18:21:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761319316;
	bh=hLl9L6FmJ2+jw5uzij78J0TvSORsHyEja4HNdumtbcg=; h=From:To:Subject;
	b=AYLkTAHl2zEvVpnisOCJHBHE/KILffPOL9Du/FjcVB7tdAptyAqB4JLdWgRv62TbD
	 MKIYu1J0tG+TMxagKm3OXyjsaPoKG2s7fzG5q9CHiYKlhY0lXxwZl1oL8f5OCgBk9P
	 CJRJ7Vxj+CFHriKIg9r93G6x7JfyUh8U7jNoUGi6IVD2BrnLruJgTzfs44XKejtHIK
	 yJ53ZMVCqocXO8kLSoqYhVv+L5z5FEb8F2yG7P+XLz6BGrP4udFWIf8bJSN9o+B6Jh
	 ZHSfx4kK1IMn5OxcXpj/7mtQhl7Z3wLgbexBxBfEAyZNrs8eIxwPCczVVkoy1AXZ49
	 fLFDOCOhtrr/A==
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
Subject: [PATCH v1 2/3] platform/x86/amd/pmc: Add spurious_8042 to Xbox Ally
Date: Fri, 24 Oct 2025 17:21:51 +0200
Message-ID: <20251024152152.3981721-3-lkml@antheas.dev>
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
 <176131931683.2356082.7233897172878535812@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

The Xbox Ally features a Van Gogh SoC that has spurious interrupts
during resume. We get the following logs:

atkbd_receive_byte: 20 callbacks suppressed
atkbd serio0: Spurious ACK on isa0060/serio0. Some program might be trying to access hardware directly.

So, add the spurious_8042 quirk for it. It does not have a keyboard, so
this does not result in any functional loss.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4659
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/amd/pmc/pmc-quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
index d63aaad7ef59..eb641ce0e982 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -122,6 +122,14 @@ static const struct dmi_system_id fwbug_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21A1"),
 		}
 	},
+	{
+		.ident = "ROG Xbox Ally RC73YA",
+		.driver_data = &quirk_spurious_8042,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "RC73YA"),
+		}
+	},
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=218024 */
 	{
 		.ident = "V14 G4 AMN",
-- 
2.51.0



