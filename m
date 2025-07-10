Return-Path: <linux-kernel+bounces-724824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0BDAFF74B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E5E5A542C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09713280A58;
	Thu, 10 Jul 2025 03:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtrbzE89"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B4D283FE5;
	Thu, 10 Jul 2025 03:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752116639; cv=none; b=nEsslaqZ+uBt4MfSZN675gQ2J9XDHNbkaigfoG2r8cGd8RfvXrjX2CAca9hdMhIX/HH9b28ggeMwvK4njCPsShyLhAWm1pB+yRl+PiKHdhH+IXhqrOD/3VkEoeFB6VwwkTMs5JhR6UfisEOE16kdzSnr/JwURc5wgxgMF6Zy/10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752116639; c=relaxed/simple;
	bh=PFA+oHZQpzOnGYRE6dsJRrBUdbqwbvmreuJ/bqsngw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mh1+sOb4sAQ+iL9KrdhwrmCoeqe/6sgjBTlf1oIDyen4XiYy8O5b9Kr6whHfuCQVZW50MUwwta6fxto7ejXAlXrqirYulT8RvBXD6qJ83iqPFF+mJ4txwFvCmNqZE83lIolqijBcfTfAx0hQyp3FJ4jwU2HCuoAGneDXIW+b6gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtrbzE89; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2366e5e4dbaso13740695ad.1;
        Wed, 09 Jul 2025 20:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752116637; x=1752721437; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qzbm7XHfXh5ZmWOnzS98wjSUhwQBx3n0KIGDo+6oRk=;
        b=AtrbzE89bI9X8pGTniXXEMrkZz05dBN4nCdvIjUr/7WIXTvOulYE8qBA+WYeifZHdm
         TFOQCCpHFfLYyK8x9RYRtcWIekg4VUFzwdd03ccVqlCVY2dXsx5dk6zG77rkIZQLKTWh
         Y1RbZY4jCeilT+/XFMbmHx13SSpQe+MuDKqpddEv/Only0SnD2ah2NcDpq1/9oAFYs0U
         qW7b8K5wllrcF27oMZ2+AdgItlsKMdXYMvL7K8Yk6yOPUC4u4mINPiNyOiiou0adh2fL
         aZc+hObHejhawFW5CoszD5hTp20Gc51egBFHvDa5zuuBZQ2pKWPCYe0ysVmSCi0rMahI
         TMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752116637; x=1752721437;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qzbm7XHfXh5ZmWOnzS98wjSUhwQBx3n0KIGDo+6oRk=;
        b=MwTdELl6M0lItqfpYEpp5RaJN45LnH4TCKF4aOfsq24AOQBDZfgok2ec5LqGH1MExg
         ayV6o5lRxrz73kRtuxm/4ioq0EzqZnhJSh1/uMDAplDIarEA3lXIFXIhBe6dcf5wAg9U
         MCRgh/1GGRTvOP3t29C9Q3Ik0i0hcNcneAffdCrQLRRuBSXDn5GzuraNfk9IKuMaGzn9
         gnHONCGpHuDRY2GGKR5weAcodPkf+MeL5nTnH/IblVDrpAPDVy71PLhoPz+czoc4D1VA
         okb/rz9miIe2LdRH7+bcIv9eGVl68LpY5w3HHjC0CYNIoJwjCn/HUvuBeD6RiGVqv/oS
         b0pA==
X-Forwarded-Encrypted: i=1; AJvYcCVCzfYlryGm5+J6LazZCyJ5T6Y9iO5WvcRXplm3oX5ZtWwUmy+80wRsGjnrpav+6OHB7pYcyILN8K24qvz/HjAf8x1QOg==@vger.kernel.org, AJvYcCVYu746K0QltqHjOyXIw5QXygQlwt3wvbPlndDb3c9SN6tl0pr8hjXbT56pvBAe90S305SqmgfIF9XU7nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjsfjCZNRv02zXxNNnwxgPJ0M2PrlR5W1wk5XWUMSObqV55Sza
	g0b5Bh+JUv0HtsAwHfB0px0UU0oPRI40VqDE2wUnJYdjU0gfWnabIg0h
X-Gm-Gg: ASbGncuA8we+DxfV7ro6uT8J4fkg+/lDlWo1PrbAcBPbjaTaOnpqkI5g/yOWgIls+Zg
	YMsTAtPXoVQGXXN5pefhJJtYRnqDvImJblxOUCRlmFoLwJij7Y01hQj1KhCo95inw+HKiGXxvUf
	OyUyB8dlTgsqrjQj877BKq5WkKvcRQRGUO458IsoJbvawWwBFVukGKmV8uEa6sZiLvvv8+H//Z3
	ttwOrIBiURXAPiuIw2AcuLr3XijPas1W0CZNEuJ+uOP43shTFOjaTHv66C2i+cPnQOyWxks7nTH
	KCRztRLUw/X25SpP0dRyzC/EAIKnf58FgkR+xUXSZcJpJCBUvjf/Wbcox/I2cA==
X-Google-Smtp-Source: AGHT+IGr0Mdzk8hxY3NE9aPkmRinUI9rqTo0avnUKCQKUGwayLo5mL4EWLpZE4YqruovjO0FOJckkg==
X-Received: by 2002:a17:903:1a44:b0:234:b445:3f31 with SMTP id d9443c01a7336-23de2fe36b4mr26797485ad.17.1752116637312;
        Wed, 09 Jul 2025 20:03:57 -0700 (PDT)
Received: from [192.168.1.26] ([181.88.247.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de435b7e3sm6210445ad.224.2025.07.09.20.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 20:03:56 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 10 Jul 2025 00:03:21 -0300
Subject: [PATCH v6 6/6] MAINTAINERS: Add FIRMWARE ATTRIBUTES CLASS entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-fw-attrs-api-v6-6-9959ef759771@gmail.com>
References: <20250710-fw-attrs-api-v6-0-9959ef759771@gmail.com>
In-Reply-To: <20250710-fw-attrs-api-v6-0-9959ef759771@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Joshua Grisham <josh@joshuagrisham.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, Armin Wolf <W_Armin@gmx.de>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Hans de Goede <hansg@kernel.org>
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>, 
 Antheas Kapenekakis <lkml@antheas.dev>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Prasanth Ksr <prasanth.ksr@dell.com>, Jorge Lopez <jorge.lopez2@hp.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dell.Client.Kernel@dell.com, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=875; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=PFA+oHZQpzOnGYRE6dsJRrBUdbqwbvmreuJ/bqsngw8=;
 b=kA0DAAoWFmBDOPSf1GYByyZiAGhvLYGgelkyhgpfp+r9OlAsJtx0nxEvOyzusZmvB4WEuYmZW
 4h1BAAWCgAdFiEEh2Ci9uJabu1OwFXfFmBDOPSf1GYFAmhvLYEACgkQFmBDOPSf1GYMngEAucNy
 2nlSwdi6QsA3aSz+XYaA3ovkxmgbL6g8uxs+PUIA/jIdePpxGhGO1QTNRwV3cadm57PlHMSV03C
 Gy81K+y0A
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add entry for the FIRMWARE ATTRIBUTES CLASS.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a5309abba307992d4bf5b05ef8a65c839fb7606..9ef3dcadc2d6adfcdb6832026681691586c613ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9352,6 +9352,14 @@ F:	include/linux/firewire.h
 F:	include/uapi/linux/firewire*.h
 F:	tools/firewire/
 
+FIRMWARE ATTRIBUTES CLASS
+M:	Kurt Borja <kuurtb@gmail.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/firmware_attributes_class.c
+F:	include/linux/firmware_attributes_class.h
+K:	(devm_)?fwat_device_(un)?register
+
 FIRMWARE FRAMEWORK FOR ARMV8-A
 M:	Sudeep Holla <sudeep.holla@arm.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)

-- 
2.50.0


