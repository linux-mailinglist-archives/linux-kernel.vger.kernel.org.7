Return-Path: <linux-kernel+bounces-883575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D49C2DC8E
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39DB1897AD4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE38E1FDE31;
	Mon,  3 Nov 2025 19:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5y/rDu1"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C519347DD
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196589; cv=none; b=K+rJrgerMHnA8UVgVoioYhofk/KNbQ5T4/jr6Pl3F1nFFzICC7Ee5Yq6c97tTvMTRMAWnBekCzfAWqvy89BRkdxHY/LhaNLEGay/c9uWH4AcEvO2aKAWmxtxotpzALJlRXBfHwRmDz5tLZU4JfXMooT0osz7+IvfDU4/V5hNvVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196589; c=relaxed/simple;
	bh=En0VkMeE1rhng04vLBUHmQuBemFFPSrfkQh+Rs4KkmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XJoNNyZ1NngaL94G9R3Sv5amjc/sv1kvq41eMAkuoTbeqQI95Y7cZgo7x9V1XGgaYdU+YzIO+BwxyqXxL3BUO3CLdQdTlr1mxBl/+JteAPVpdQsEpjmcR47+0VX/z1IzqUERPPgHyZS4Vfn/V6Nwfu8ptQjaBimlZWcZ0CwVJCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5y/rDu1; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-55965c96fd7so473303e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762196584; x=1762801384; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fPkWCp8swfwdbGWYqTdbJKnDJR2KGTgvfV0JdTw2mg=;
        b=c5y/rDu16souczz6G5t48zu2c3+emph3xz5YFJd+d/4FTAS57KTh9ykRk1STVeBGHR
         EC9FT6fDi7IJy0IA+EVkr4jcgYZs50wxtYZ2iLnEAw3S+mw89+Ul/zVa49pVcBTcQC5x
         J7LhgLxBtDCDWVpynrplUlFExcA+4PbkBsT8gJL7n4FzbkQJ2oGbAc3qh8zBFdWMM3kz
         ZkkH0Aoe1ZOsUwsER47UGqqO3j5xdwZnpCqRn+OjIbAFcKg+baHioBrdccafFQpgdd4Q
         jjLw2AtCViX9qBDrPF0yF3D5v60OO/YIEycbzX9c9yLbNfISexur3URiNw+aOOnYvMbC
         EbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762196584; x=1762801384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fPkWCp8swfwdbGWYqTdbJKnDJR2KGTgvfV0JdTw2mg=;
        b=U70/03uXbLD35eGz7L8oUbxD6y9jhwGvljwLpqjlQVhoT08bfnvBP7tLReGR9hjUTk
         J3oKMeS6Hqz5TUUP64niXEmntLFW7h+aCJlrsYhHQgSUW56zvrNFGCaxqb9k2jqwPM9M
         Cqz6q2WqiEz5vXDxvc65W3x7NCK/g4URSp9af2tDxfJs4RKQ6xfsJET0qH90lNz2dGEs
         JvGLPuyUp4/ZToCWT6H7WfbdMGe/4WJElYec/kopxLN/mPFccSELJU6S/cRYwsCUXWm8
         vxFCVZniGBfTBZBrReJXH+t4DUrAqIO3dcqXGKjegDD8/h2NHqRx+kYNXffR64hHT4fD
         e+lg==
X-Forwarded-Encrypted: i=1; AJvYcCU+RK3c2A6YFqKUKPeBcFqmBVZ8zTf2AXzM2rqio/6ZtwtclyFDGsMOZDOK2aDEZV/EWOgIEoFtriuCsEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjV7f+LkqqZQjkckJVsIkiJEYybs/AL4Qq3eNsb1Rio70HR2xZ
	aZfebsswi2iDlnJ/ZglTGuKem3pe1C4Y7xWGFsp/LzpkfmG1LeiWIa60vnmxtg==
X-Gm-Gg: ASbGnctgC+rt24/y+B01shwP0BkGrG6ps0m4XH7ueNPijJ6NTTOhIxhHser/D6hg4m4
	dMl53dswNXqpvEuRVgsRRvC8gvQQomSKRQfq29kjpYWU3Wh+bHFJO0lofU9g1sMb/hKXYd+dunM
	SWnZEVLxEakyKGC8vM2FBsGUsivyWn3XngPo9ackMeWgOInlfHxd485CPdcoddFlNFRiRTV0xfO
	mj807TwF7mspnwoGw20ChrzVa5XcPHXWkDIFuJ3t4hrT4qerFg7AlTeROlliKfDl4lrzrkpGX47
	80eUzxT8Vs9aB7cCFL3+l3wXmKGp9n8maAAAlkOME8gccQTU0N7QfUiMYMKVDluvRWTbiWbVF/p
	Xa+nNhJy3ZtDpgErAmqBQyXEncByShND6rPrKM7dkXcprXBghyhv3s8fxGQfi086rLwMeCIzlSV
	In9Q==
X-Google-Smtp-Source: AGHT+IGv0Ms552SbiF0xYh+qZjLVNlpg4qJjDFX+UdDbb0FzhrWHb1LMmGGXktjG/NSchg1Cn7WvNw==
X-Received: by 2002:a05:6122:3c48:b0:559:6723:628c with SMTP id 71dfb90a1353d-55967236824mr1385199e0c.16.1762196528942;
        Mon, 03 Nov 2025 11:02:08 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55973c834e3sm358469e0c.11.2025.11.03.11.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:02:08 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Mon, 03 Nov 2025 14:01:47 -0500
Subject: [PATCH 4/5] platform/x86: alienware-wmi-wmax: Add support for the
 whole "X" family
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-family-supp-v1-4-a241075d1787@gmail.com>
References: <20251103-family-supp-v1-0-a241075d1787@gmail.com>
In-Reply-To: <20251103-family-supp-v1-0-a241075d1787@gmail.com>
To: Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=En0VkMeE1rhng04vLBUHmQuBemFFPSrfkQh+Rs4KkmM=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkcf5TmVPTPaTpoEeaU/NO6Zw/DvPWhpmcb/aSEnNrla
 z9/0bvWUcrCIMbFICumyNKesOjbo6i8t34HQu/DzGFlAhnCwMUpABPRWcTI0KNpq/5E8tnJYoao
 A3vaCnOFo72Xz2y+KMIb9Ss9+h77dUaGrd2HMw/MdS1PZwj6U1aV8eXP3LJVXBtUIgKz9z2pcVb
 lBgA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add support for the whole "Alienware X" laptop family.

Cc: stable@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 53d09978efbd..c545eca9192f 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -146,26 +146,18 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		.driver_data = &generic_quirks,
 	},
 	{
-		.ident = "Alienware x15 R1",
+		.ident = "Alienware x15",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x15 R1"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x15"),
 		},
 		.driver_data = &generic_quirks,
 	},
 	{
-		.ident = "Alienware x15 R2",
+		.ident = "Alienware x17",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x15 R2"),
-		},
-		.driver_data = &generic_quirks,
-	},
-	{
-		.ident = "Alienware x17 R2",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x17 R2"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x17"),
 		},
 		.driver_data = &generic_quirks,
 	},

-- 
2.51.2


