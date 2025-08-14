Return-Path: <linux-kernel+bounces-769572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C551B2707A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0325E0D4A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FCB2741DA;
	Thu, 14 Aug 2025 20:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="T7RFPNCs";
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="AT0IcAYB"
Received: from e3i331.smtp2go.com (e3i331.smtp2go.com [158.120.85.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CF4273D8B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 20:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755205123; cv=none; b=ObvMnilqxvhYiEk0+FLFDnXkyAUiaLQoI7K/Injrwk3LPH13nGnr0IxYx/zDOyUitPbotC7bLNOGQfgFcQArkDmcYh6BcNVXdS+KAZXp9PZOAyQILxCV7awPI2lZqNPndwP9GVr54u0/HD3YRb6cu0eZpk8giFsAqos/y9l2G10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755205123; c=relaxed/simple;
	bh=j4AA4nQmJFlRP0/NnrzhPFhnYH+laj8mwQr9FuaC+Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EwXOOYACbZQgmCItNU8ebECfQG2BqZRJGC2vk6nSxzdqVH4Te+/wZLutifcD0c7tRvkCrzcDmV9vB2SVYcfjBq54Io9LSthaEor1DUALpWxdBg6uzm9kk2h+P42KYAK1PDEq6npHeEA0BpENLeTzXHPqZko/tdtIqavDt4a+7nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=T7RFPNCs; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=AT0IcAYB; arc=none smtp.client-ip=158.120.85.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1755205112; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=OKTSY4z8mDWV1jZSFIOngnqYhOU+OVtxrQywDa1UHlk=;
 b=T7RFPNCswxfG+Px0wUfRTkTnDWTYTV4SIN07Sxmuc8oX86DzbFj/5VMqeQ2nS06inrBXN
 Yg0mORuaXHQHeW2IykJZwh3WjQfLYf3DSCPpaMSvn1IXhdNgj0XFi3o5cjNUz0coDDLyhnK
 CxL70Tq1Cu6apCtL9T5noiyE/neShR7TzDw4xP5thBOaedAH9tjof0TCsfXwr9YEeIhtMI+
 DCQBb3zwMNbeS3iX2SIIlXhkNThGQ9p7QQ/UEmkpU6kLnmRGPef80H30so0t0qctQSpOPOD
 Y5ecFT30UiWSVL9DUt3fCr7HSs9aiIyoTJO3PcOzzgSlmSgd5hR9KEP4lMrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1755205112; h=from : subject :
 to : message-id : date;
 bh=OKTSY4z8mDWV1jZSFIOngnqYhOU+OVtxrQywDa1UHlk=;
 b=AT0IcAYBasWRGX4kqriR/wjje3eaPse40u3ghLr5fgS8UvpL6xCwQomC6W7o6iZVNzMrL
 qRQfJvkrlQdooyA8ijUReGGKj4tnW1h4vpfDw9LgqShyzEtTyO19Zr3q9l7fmZsjDls+3le
 MOLetYCjF3iycYCNQYNthGznCTpFjLH1qHBpxVfiOnSMOpAx05KzobIaPn8vFxNYA4/PB/I
 8xGo2wP1Yrjh9aXTuGgrmrWgF7s0OiOGorQBLUbKN66PpaHZDbxP6K/Yj9F3Sr1JzDCkNZM
 TGWteDlTULZrMF6Z6IRK5P3jITS1qIFjs7+7+fdHQ0DRGwltrD8Rmpzm3++w==
Received: from [10.152.250.198] (helo=vilez)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1umf1i-FnQW0hPzmup-Oj4z;
	Thu, 14 Aug 2025 20:58:23 +0000
From: edip@medip.dev
To: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org,
	kuba@kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edip Hazuri <edip@medip.dev>
Subject: [PATCH v2] platform/x86: hp-wmi: Add support for Fn+P hotkey
Date: Thu, 14 Aug 2025 23:45:32 +0300
Message-ID: <20250814204529.18467-4-edip@medip.dev>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1255854m:1255854ay30w_v:1255854sCbqN4Q8xq
X-smtpcorp-track: XvbZjI3C9xIN.PbFzad5z-c1n.nMFIQACT6yN

From: Edip Hazuri <edip@medip.dev>

Add support for the Fn+P hotkey found on newer HP Victus (and probably
newer Omen) laptops. This hotkey is intended for use with Omen Gaming Hub
to change the performance profile (see [1]).

Pressing Fn+P under linux produced the following warning in dmesg:

> hp_wmi: Unknown event_id - 27 - 0x7

Implemented a handling for this event so that the hotkey cycles between the
platform profiles when triggered.

Tested on Victus 16-s1011nt (9Z791EA, MB 8C9C).

Changes in v2:
- Make the key just switches between platform profiles instead of
  assigning a key event code. 
- v1: https://lore.kernel.org/all/20250802213541.18791-2-edip@medip.dev/

[1]: https://jpcdn.it/img/adadf6c927ffeb75afd8038f95db400a.png

Signed-off-by: Edip Hazuri <edip@medip.dev>
---
 drivers/platform/x86/hp/hp-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index db5fdee2109..c712d5bdaa1 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -122,6 +122,7 @@ enum hp_wmi_event_ids {
 	HPWMI_BATTERY_CHARGE_PERIOD	= 0x10,
 	HPWMI_SANITIZATION_MODE		= 0x17,
 	HPWMI_CAMERA_TOGGLE		= 0x1A,
+	HPWMI_FN_P_HOTKEY		= 0x1B,
 	HPWMI_OMEN_KEY			= 0x1D,
 	HPWMI_SMART_EXPERIENCE_APP	= 0x21,
 };
@@ -981,6 +982,9 @@ static void hp_wmi_notify(union acpi_object *obj, void *context)
 						key_code, 1, true))
 			pr_info("Unknown key code - 0x%x\n", key_code);
 		break;
+	case HPWMI_FN_P_HOTKEY:
+		platform_profile_cycle();
+		break;
 	case HPWMI_OMEN_KEY:
 		if (event_data) /* Only should be true for HP Omen */
 			key_code = event_data;
-- 
2.50.1


