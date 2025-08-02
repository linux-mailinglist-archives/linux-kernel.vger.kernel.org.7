Return-Path: <linux-kernel+bounces-754231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0A1B19026
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 23:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5A01899B5D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 21:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDAB204592;
	Sat,  2 Aug 2025 21:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="S8Vk37lP";
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="OROrwOFS"
Received: from e3i331.smtp2go.com (e3i331.smtp2go.com [158.120.85.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51A71E89C
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 21:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754170577; cv=none; b=C6D4noEDcHZtzrELk9kgwJhodaK7WfGy/4whAO8QxXjxjEPYce2swNOrUaLVjjnramGxFueUZ5UPDKKgiMu0EszpQgxIB+yhh4vfgGHIi3FnzWxO9U4ADwlm3bP7QnHb17OHO+pwSQ8jBZ08K2gjfnwgSBLNnB/7Ejp1ZVphi+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754170577; c=relaxed/simple;
	bh=ruZHURDoAu3h4nORUNospI+cvl4F+mopDOISY7VdiZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBU8mJNZo7jSdDAKFbzCJRidwm3WaShFDSqnxpqEi9FOjy7ZTT8rwzEEN24xHV4ozqB5G5/PTB6y1P3F1pKEKZgAI6Sfz1wRf5RYvXecGBxPfOtVbqVFgeQz2dtjzjxwzliQe7zmQARW649qhyN5DxaS8EOWR94H1yP9YaV0SiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=S8Vk37lP; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=OROrwOFS; arc=none smtp.client-ip=158.120.85.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1754170572; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=CrWDOxBfWPwUrRtBxLQMODWaqfDXlu9Eg0Hy+KaDs0U=;
 b=S8Vk37lPF7QN6y8KUqBPZK0j1mPNzODUtuYGWyuiRDv+SQZs4zVMiu3B+xVCEeQ6vwrBj
 rE9aQT4qJelDIM4m1ebF7ipMDmttjsOTJdvJ7gxEb8nHnCCzpcMe19QhHqmv1UFOTQRcPch
 hdw1e97GWzql957WWOGIDHVSLkBu7VUb0dYcT5yFcUHQDyTkmtyExuXk+7ZpAyD51/5Xdpe
 H72fDBEXLWdPYr6hpyA9HaQmJfYX2om3D/hcOdf5pN3obR+1mvZhYw3WqceZ/UUGWW7mSMJ
 fB6jpVvvHN6GCw4+E3RsAaJlzlxdxNi5HXyPYVdwkKKOz7rPJ3NER57jdPPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1754170572; h=from : subject :
 to : message-id : date;
 bh=CrWDOxBfWPwUrRtBxLQMODWaqfDXlu9Eg0Hy+KaDs0U=;
 b=OROrwOFSO/l9qnXrhS/wxnSmmPZi4Ol6lgFctZkHq5isoUPxgj7qvuB/QMdJkiAJ7MCTJ
 PZ/rYiKueFrRUDlrLatZ4S074rQe6986vJTj8QFgQH1Br2UdbLc7RJI4KZv8lTo8SFRfpaf
 KRJM8finCIBqdRGDwOuGIX5iamzvOtW3z4Vjw3pYIpw0YfPFczwg1hXe9KRwxe2Uyo1vnk4
 /XOmzvh+Rm78HOE7RJ7UR4zTz7wyF6VZ1B3+clAvfdLO/5LROUpyC3tnbXgL2LGctOdTqZ7
 EWfdiYPfcZr+b+I6uKn13z1q7QtHGtntUZ8tuFiVviW0h3L7Jtx4vvP7HBFg==
Received: from [10.152.250.198] (helo=vilez)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1uiJtd-FnQW0hPrQm0-HolR;
	Sat, 02 Aug 2025 21:36:05 +0000
From: edip@medip.dev
To: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org,
	kuba@kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edip Hazuri <edip@medip.dev>
Subject: [PATCH 2/2] platform/x86: hp-wmi: Add support for Fn+P hotkey
Date: Sun,  3 Aug 2025 00:35:42 +0300
Message-ID: <20250802213541.18791-2-edip@medip.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250802212149.16707-2-edip@medip.dev>
References: <20250802212149.16707-2-edip@medip.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1255854m:1255854ay30w_v:1255854s79-ZDZDmr
X-smtpcorp-track: FDKWJH_wraI9.sSHmQE1dwzv6.TXQq5wuea2C

From: Edip Hazuri <edip@medip.dev>

Newer Hp Victus (And probably newer omen) e.g. Victus 16-s1011nt that i
own have a Fn+P shortcut intended to use with omen gaming hub for
changing the performance profile. see [1]

> hp_wmi: Unknown event_id - 27 - 0x7
Based on the dmesg warning. I found that the key have 27 as event_id and
0x7 as event_data (keycode). I implemented it in the driver and now
libinput can capture the event.

Tested On Victus 16-s1011nt (9Z791EA) with MB 8C9C

[1]: https://jpcdn.it/img/adadf6c927ffeb75afd8038f95db400a.png

Signed-off-by: Edip Hazuri <edip@medip.dev>
---
 drivers/platform/x86/hp/hp-wmi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index db5fdee2109..6467ca27db7 100644
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
@@ -280,6 +281,7 @@ struct bios_rfkill2_state {
 static const struct key_entry hp_wmi_keymap[] = {
 	{ KE_KEY, 0x02,    { KEY_BRIGHTNESSUP } },
 	{ KE_KEY, 0x03,    { KEY_BRIGHTNESSDOWN } },
+	{ KE_KEY, 0x07,    { KEY_FN_P } },
 	{ KE_KEY, 0x270,   { KEY_MICMUTE } },
 	{ KE_KEY, 0x20e6,  { KEY_PROG1 } },
 	{ KE_KEY, 0x20e8,  { KEY_MEDIA } },
@@ -981,6 +983,15 @@ static void hp_wmi_notify(union acpi_object *obj, void *context)
 						key_code, 1, true))
 			pr_info("Unknown key code - 0x%x\n", key_code);
 		break;
+	case HPWMI_FN_P_HOTKEY:
+		key_code = hp_wmi_read_int(HPWMI_HOTKEY_QUERY);
+		if (key_code < 0)
+			break;
+
+		if (!sparse_keymap_report_event(hp_wmi_input_dev,
+			key_code, 1, true))
+			pr_info("Unknown key code - 0x%x\n", key_code);
+		break;
 	case HPWMI_OMEN_KEY:
 		if (event_data) /* Only should be true for HP Omen */
 			key_code = event_data;
-- 
2.50.1


