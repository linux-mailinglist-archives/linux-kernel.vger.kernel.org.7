Return-Path: <linux-kernel+bounces-747924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67301B13A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48573BD1CB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FEB2580E4;
	Mon, 28 Jul 2025 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="vf7Dtxfb";
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="BUIaphWQ"
Received: from e3i331.smtp2go.com (e3i331.smtp2go.com [158.120.85.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834F44A11
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 12:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753704994; cv=none; b=G9px3Etg8zY8BujO2P7z5zsiq5npnQuuqoPK1BcvxaMYVoVq78IAnvyk0/PlDZ5+HYd/yRXUcnWklTYaI3TxBIKLsa58L4LOWgOOd2W2oFfBAuq56158w3ltAkwx0viR9sRWYoQ1pWiIsHVYgTWbvvPvRsyA1DA/VJt5Z0lFcTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753704994; c=relaxed/simple;
	bh=tR+gAlw+VJAUzlovBMweuxJ79ao2tYMAXcwuJPh6fPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N7bxJos+h8DTkgRN2zMuSySRLVPfRnspHJam3KNX3xfrBgiZmzWAAgldZyTbWZ9YzoYbsrhWj3ON2LFLv5vnUV/kDD0gFChpdFBlS84bUXs7eBKEvU52HSr5mk2EyLHGgVk07sfPIaMd/uem5jMotXrD3oUvf29fzsFSK7QDCEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=vf7Dtxfb; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=BUIaphWQ; arc=none smtp.client-ip=158.120.85.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1753704082; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=HNCycqxR4SKAW4zRi3B5y0ggYK/ajf+aV8k0WOQ1SAA=;
 b=vf7DtxfbKH6Lin2poXFZC7VKUrNl+1iPlNnuepcgHm5k4WILcH89HEsWGLm9ZyeUNCD9h
 obZEJE4bAg1OyH+O+ZmOxugdq6Ar8jw1TuQPzLoocabwZJkQ73oYY7pSLJe4DQhij2Mrgkv
 rnjsr5ShxL8Q2H/zJVdiGAW+wgfJXvCGDmPlfyF06Rlxu9ZGYLYG7btApkvsmwR6NzT0s9Y
 MafiXcTA3USFDShGfxh7u+3u+OexzF2Ph4ZFDW7yCUaBeYbTAM8X5IDAmDl8rkOctkxBhr1
 QNpScC1nFtR2eI3WVQK6rCPUiqC+Jmb1iykFJq7ENB0WUZ0lW08gstrU8isw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1753704082; h=from : subject :
 to : message-id : date;
 bh=HNCycqxR4SKAW4zRi3B5y0ggYK/ajf+aV8k0WOQ1SAA=;
 b=BUIaphWQTbz3KN3n6YeOMidQNAQk9NqDUZ97SE7EnLNYOUzlxt6KwHnBxfJpNAVdM3vAR
 FpntDymXQDqLBr9D7o39tN2A2h2Oe4f/5qrJPlRd1t3uDn1bC+qDQAnoE10s3qoFRB0xzIp
 NAeXH7PNmdGSNpfc7OAxwCqhax/V52dkZp6BxMfRtQdSw2GXuflaCsBfh+TuaS6lAkcIXSo
 T5OFwYU9/llZfr5IBJ+rQufgpu9LWysno+/if/x0eTiKKQAzLyu6b4ktU8QAJUKnmUPgTFX
 bnsYIFfyLQOs12edur6gfwg3Tiv5nSOBHevFgPgFQjSpGl7VulOsxlkwUM3g==
Received: from [10.152.250.198] (helo=vilez)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1ugMXd-4o5NDgru1PL-gCdw;
	Mon, 28 Jul 2025 12:01:17 +0000
From: edip@medip.dev
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edip Hazuri <edip@medip.dev>
Subject: [PATCH] platform/x86: hp-wmi: mark Victus 16-r1xxx for victus_s fan and thermal profile support
Date: Mon, 28 Jul 2025 14:58:06 +0300
Message-ID: <20250728115805.20954-2-edip@medip.dev>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1255854m:1255854ay30w_v:1255854splFv8-g8x
X-smtpcorp-track: L1tqJounXWpU.Xzu-14QvwanV.xlkqbArE98M

From: Edip Hazuri <edip@medip.dev>

This patch adds Victus 16-r1xxx laptop DMI board name into existing
list.
Tested on 16-r1077nt and works without any problem.

Signed-off-by: Edip Hazuri <edip@medip.dev>
---
 drivers/platform/x86/hp/hp-wmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index db5fdee21..60c8ac8d9 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -92,9 +92,9 @@ static const char * const victus_thermal_profile_boards[] = {
 	"8A25"
 };
 
-/* DMI Board names of Victus 16-s1000 laptops */
+/* DMI Board names of Victus 16-r1000 and Victus 16-s1000 laptops */
 static const char * const victus_s_thermal_profile_boards[] = {
-	"8C9C"
+	"8C99", "8C9C"
 };
 
 enum hp_wmi_radio {
-- 
2.50.1


