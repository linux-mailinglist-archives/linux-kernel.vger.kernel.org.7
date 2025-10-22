Return-Path: <linux-kernel+bounces-864335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 02317BFA8A3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 708EC343C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A842F7AAB;
	Wed, 22 Oct 2025 07:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="Xo1xBmBM"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832DA2F693E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118088; cv=none; b=bnOpA6Mw0GHQLlKtEoZ0AEaYvE4jCeyaLFZWssuVvhIc6bRY2eQrzMqIXmigck5vW4Pk3Xj9WEzZQr2r2ug0fiBR5R3WEI6aLjR896C6vBEHqYc7AHZOgvUzGgYzOYH3myWf/M8Gz9i2Vikm8t1fUBQZCBfdbTDbPvTCFK/5dHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118088; c=relaxed/simple;
	bh=WNyfnE70judBVS87NToHhBjaPBAnu/cg9W5gM0SBY7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Hao5ZLwypBZwYx0TZHfU0uWeLcFwZ+XqJtj5KyfEBrkDu8Ll/X6Pa1aIcSnuPJv8YkS9WcQLMLZVw7iKz5veuCMUVd1oCDvGzvKs4uPaSdqiX0CM1A5Z/5s69X1ujz2Zsd0s+Bn2hxaT9DiYgSrYyD8V+uY6tA83zdmmfmPv6Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=Xo1xBmBM; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33d962c0e9aso558832a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1761118086; x=1761722886; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vO9KHRnLBvKhkpXd/9jn5kuuFi+mv6wMYt7ZZXt91UI=;
        b=Xo1xBmBMGyp08mgR3wx7wEnLvo815xgjFa0e9gLyJtTdPIxz+517RUBkYNJBv7D5YT
         HJxrjZgeVaGdx4qA/qJyAvCHqeIpz6a1KpOEuOsyLSDLmaW5R9zPfB7QwkXpqYA4EOvq
         ojnsHcfTdObV4Au/7r/jhh8axRdTcfZbP/E7efnyE7kgh7GNXlqCysL7rMjUivKRS12+
         RUY5Hd53Klq95M+3BRSkm0A3w736D/y4LQbLYHqFODwKCxvByZN6Uvq93JAhMlRKpbRP
         4D828iXg+cZJfWfgxZ8wBvFTRDngfP/YbH5Ip/8RZhl4Uvk73suKl5ohPoVN5Duh2RPW
         tdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761118086; x=1761722886;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vO9KHRnLBvKhkpXd/9jn5kuuFi+mv6wMYt7ZZXt91UI=;
        b=J+hWDAq9A1o43vFMxnI85F3g7QOfxYWirAk8LzdhZdzPZ7fYIjuHam0+rHID7ta8K+
         cMuZEJ47tDWrszNxclAvQoP2FczFhSDqENNuVPWaKupw7NV15QvO+nj4TXk8oukGatF+
         tw64MOcylHdKnlYh6wJIRc88UyJEs1HWUmdWBuWiSTrzBW44rDBPYjiusn48lFh9UOrQ
         6DecXOCsV5t+JZ/sJo1VT/98AdHpAWWTnqW2vr7OQh+LhKjZD2UFxO5IwcOdZ5Eja1+E
         q1gKsX0m/40TNBcMFEPxt6N9uiohRO9MzLqzz3aTlVHWTGJ/gQQm2WxjKQU3uZ8ELZrW
         AQ/w==
X-Forwarded-Encrypted: i=1; AJvYcCWKbEalF6JZIy7+cev/6ft27hk/n8/WE9+u+uowDODSJ2tUWTQOiT1rRBWiqFraMVK5zYvMgs4StsgTmjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7kxUTWAQoc/nId9MAhWTbozM3CN44TrYhWNxDiAPaWG4Abmtd
	McE4PDEfYdwmviuT4vOYw5g3nJ+je3as9Uy7KafqAuQZHYVyANtW6Xm32Y0CXk83AngLGSepVBp
	WXE4=
X-Gm-Gg: ASbGncvTB/aarX4zBmjA7qkv43wxQqmRxEoVUBAUMRda/0HiVNIh31LTtZiFOkyywe1
	6M6eJUFdEhv5awK99GPvsDR4mX/d6kMKW+O9lM6IJgJDvUTo5DobvvH6r3TlcXclE/y3rFMoqpc
	nbn1ocDHdfa1Ni116BbixTUQ5RYWhKjBuy5dNb1xf2wgaWDQVf0oeckF+7pBi2hkr9KxhaJ9wlR
	xUkDrZeGGFGz2TorLWfbcGYLlrmYs5s6qpOOEBlN1nexoIvXMAbmJHWg/aVf9Urngqgl7ORsXQ5
	x0ZWFOCTvL9sn2XMzDl3+oPBoqH8owjRsRnyq848x8RyUI5p7MBBzwebTwXsi50EZxGkXT4QpyJ
	9zVdQtuIVguzfqaeKhLFplEKWGPLxYXKMlbuPVwLi+/ff5Lw9pcB8NAcm6lmTRjOO3NsYfiAYWf
	syGXfzMm780cI=
X-Google-Smtp-Source: AGHT+IHFgcS37MSkxyU6h/6VU4QujwEp9l9tioYqbxhwqXHsDJs1YDVW+aLoiaG4Ar2Az1m+PVPn7Q==
X-Received: by 2002:a17:90b:2dc8:b0:32b:94a2:b0c4 with SMTP id 98e67ed59e1d1-33e9120647emr654212a91.16.1761118085605;
        Wed, 22 Oct 2025 00:28:05 -0700 (PDT)
Received: from [192.168.1.10] ([2401:4900:8898:a21f:edff:5244:379d:6d28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e224ca168sm1639039a91.22.2025.10.22.00.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:28:04 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Wed, 22 Oct 2025 12:57:57 +0530
Subject: [PATCH] staging: greybus: fw-download: Fix find firmware req
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-gb-fw-v1-1-183b18500cd5@beagleboard.org>
X-B4-Tracking: v=1; b=H4sIAHyH+GgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyMj3fQk3bRy3UTTlCQzCzNLoyTTFCWg2oKi1LTMCrA50bG1tQAuTV4
 NVwAAAA==
X-Change-ID: 20251022-gb-fw-a5db68692b5d
To: Jason Kridner <jkridner@beagleboard.org>, 
 Deepak Khatri <lorforlinux@beagleboard.org>, 
 Robert Nelson <robertcnelson@beagleboard.org>, Dhruva Gole <d-gole@ti.com>, 
 Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Alex Elder <elder@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5140; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=WNyfnE70judBVS87NToHhBjaPBAnu/cg9W5gM0SBY7Y=;
 b=owEBbQKS/ZANAwAKAQXO9ceJ5Vp0AcsmYgBo+IeAIjBqRHYyxWZfRp+nYQxBKIADZP2+vUCUQ
 J0yrc8WX3WJAjMEAAEKAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCaPiHgAAKCRAFzvXHieVa
 dBAQEADj1kutjPIAv3IJLOLqL8oGJfxa9Y3lOJTkHRYeEOvmvwR4Fm3f4SaSx3ivJxh/U19ZES5
 YSvlce7lmCis7bXLNc3LRQWbjcvEK/+WNZhfpZBcHF9zI4SI9CpzPtsX4tWFGg1cy1EzXG7xvwe
 tT2XGd5giCYm0jEVudTnkTx8cH8H3LSwePnSTHcDpkOI8e1s3A2FHRcH11OKs6aVBN3niJlEyeW
 iB3EZe372Qg5pcOJgiYsUUuxYKrysak4Uv3IXpCOmeYLESpRE2II1keXEiAeMBShoF1WJbxm3WY
 rxu4C8Hv3LsmH2E/VrQ3tgX7ETRhjmI4k+XhsowcpKwOiy4p+Z9CZyacQIez2vj4Y1qxfSkcRD/
 ZVgR1sQaSqce8ET3pc8fFhrEOZ34Gdxm7p8ocw6sBSOmLipJ47UxDgttbCickxUXXDFXodTakTd
 l4/ygTprza+uAMvGxSyWI6y2rZhcpI+yS+7u1NWeLgjq+yx3YTsv71E1oLr82rRrkTFBv3wDjko
 Pa5WH8/XW0nD+yqIK9FEn5AwHzDFic5fQSWc0jHO4ZDu1VLbtJh4i9n4e8yqRTrsiYI9ckWLlic
 VUvdISayc87bvT9Uk6/9wMQHsvv955qy11SliSB0EdcjUdrDN0YPoR7Ue5B9x684ew2BcP2bT+T
 Vp+JFekV7RMNN/Q==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

According to the Greybus Spec published here [0], the Greybus firmware
download find firmware request should have both tag and format as
request arguments. However, currently, the linux kernel seems to have
defined this request incorrectly since format is missing.

The patch adds format to request and am using it as the file extension of
the firmware.

[0]: https://github.com/projectara/greybus-spec/blob/ac47bc32dce1256489a82ff1f463fb979e9684ee/source/device_class/firmware.rst?plain=1#L152

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
According to the Greybus Spec published here [0], the Greybus firmware
download find firmware request should have both tag and format as
request arguments. However, currently, the linux kernel seems to have
defined this request incorrectly since format is missing.

The patch adds format to request and am using it as the file extension of
the firmware.

I came across the bug while working on greybus-for-zephyr [1], to get it
ready for upstreaming as zephyr module.

Open Questions
***************

1. Handle empty format

Not sure what to do in case format is just NULL. Should the request
fail? There is no reason to not support firmware without extension. So
personally, I don't think it should be treated as error.

[0]: https://github.com/projectara/greybus-spec/blob/ac47bc32dce1256489a82ff1f463fb979e9684ee/source/device_class/firmware.rst?plain=1#L152
[1]: https://github.com/Ayush1325/greybus-for-zephyr
---
 drivers/staging/greybus/fw-download.c     | 31 ++++++++++++++++++++++++-------
 include/linux/greybus/greybus_protocols.h |  2 ++
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/greybus/fw-download.c b/drivers/staging/greybus/fw-download.c
index 9a09bd3af79ba0dcf7efa683f4e86246bcd473a5..06f1be8f3121e29551ea8416d5ee2666339b2fe3 100644
--- a/drivers/staging/greybus/fw-download.c
+++ b/drivers/staging/greybus/fw-download.c
@@ -159,7 +159,7 @@ static int exceeds_release_timeout(struct fw_request *fw_req)
 
 /* This returns path of the firmware blob on the disk */
 static struct fw_request *find_firmware(struct fw_download *fw_download,
-					const char *tag)
+					const char *tag, const char *format)
 {
 	struct gb_interface *intf = fw_download->connection->bundle->intf;
 	struct fw_request *fw_req;
@@ -178,10 +178,17 @@ static struct fw_request *find_firmware(struct fw_download *fw_download,
 	}
 	fw_req->firmware_id = ret;
 
-	snprintf(fw_req->name, sizeof(fw_req->name),
-		 FW_NAME_PREFIX "%08x_%08x_%08x_%08x_%s.tftf",
-		 intf->ddbl1_manufacturer_id, intf->ddbl1_product_id,
-		 intf->vendor_id, intf->product_id, tag);
+	if (strnlen(format, GB_FIRMWARE_FORMAT_MAX_SIZE) == 0) {
+		snprintf(fw_req->name, sizeof(fw_req->name),
+			 FW_NAME_PREFIX "%08x_%08x_%08x_%08x_%s",
+			 intf->ddbl1_manufacturer_id, intf->ddbl1_product_id,
+			 intf->vendor_id, intf->product_id, tag);
+	} else {
+		snprintf(fw_req->name, sizeof(fw_req->name),
+			 FW_NAME_PREFIX "%08x_%08x_%08x_%08x_%s.%s",
+			 intf->ddbl1_manufacturer_id, intf->ddbl1_product_id,
+			 intf->vendor_id, intf->product_id, tag, format);
+	}
 
 	dev_info(fw_download->parent, "Requested firmware package '%s'\n",
 		 fw_req->name);
@@ -225,7 +232,7 @@ static int fw_download_find_firmware(struct gb_operation *op)
 	struct gb_fw_download_find_firmware_request *request;
 	struct gb_fw_download_find_firmware_response *response;
 	struct fw_request *fw_req;
-	const char *tag;
+	const char *tag, *format;
 
 	if (op->request->payload_size != sizeof(*request)) {
 		dev_err(fw_download->parent,
@@ -245,7 +252,17 @@ static int fw_download_find_firmware(struct gb_operation *op)
 		return -EINVAL;
 	}
 
-	fw_req = find_firmware(fw_download, tag);
+	format = (const char *)request->format;
+
+	/* firmware_format must be null-terminated */
+	if (strnlen(format, GB_FIRMWARE_FORMAT_MAX_SIZE) ==
+	    GB_FIRMWARE_FORMAT_MAX_SIZE) {
+		dev_err(fw_download->parent,
+			"firmware-format is not null-terminated\n");
+		return -EINVAL;
+	}
+
+	fw_req = find_firmware(fw_download, tag, format);
 	if (IS_ERR(fw_req))
 		return PTR_ERR(fw_req);
 
diff --git a/include/linux/greybus/greybus_protocols.h b/include/linux/greybus/greybus_protocols.h
index 820134b0105c2caf8cea3ff0985c92d48d3a2d4c..48d91154847dbc7d3c01081eadc69f96dbe41a9f 100644
--- a/include/linux/greybus/greybus_protocols.h
+++ b/include/linux/greybus/greybus_protocols.h
@@ -214,10 +214,12 @@ struct gb_apb_request_cport_flags {
 #define GB_FW_DOWNLOAD_TYPE_RELEASE_FIRMWARE	0x03
 
 #define GB_FIRMWARE_TAG_MAX_SIZE		10
+#define GB_FIRMWARE_FORMAT_MAX_SIZE		10
 
 /* firmware download find firmware request/response */
 struct gb_fw_download_find_firmware_request {
 	__u8			firmware_tag[GB_FIRMWARE_TAG_MAX_SIZE];
+	__u8			format[GB_FIRMWARE_FORMAT_MAX_SIZE];
 } __packed;
 
 struct gb_fw_download_find_firmware_response {

---
base-commit: aaa9c3550b60d6259d6ea8b1175ade8d1242444e
change-id: 20251022-gb-fw-a5db68692b5d

Best regards,
-- 
Ayush Singh <ayush@beagleboard.org>


