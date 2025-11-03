Return-Path: <linux-kernel+bounces-883572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 161AFC2DC82
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01A11895587
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD8F29992A;
	Mon,  3 Nov 2025 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Co0p0euN"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1491F4188
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196530; cv=none; b=Znl98Og25HECnKKquGgPkPoCoGgU8alfsmoMdappVOpjaFRYO8SqbqfMiu7N2HNTnbM/YzDFZ5of0QjjYR/zf83ZUGDlFMjpCRttvzIa6/fn9o7OmuX6Rdf14r+tNp5+2ELrGJCk+j/DFw3JiUog2O8LGeinva9VL5psLg0X7OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196530; c=relaxed/simple;
	bh=2PYqlko7F9XLCyNsZ3GQYTjIvz/k9vACFLo80BZqaiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CcdJNVBi0w/m8rrsiz6qGyaweOTxxt7ucpLD/IzInuLUGiWvzUKrOrVD+rR0DuY9z4R9rWNpJAyBOUNTMgDF4G+mHX2pRSKzHvvvhDGue0zvFv2S8J+HXzBXoEpGlBAJBblBHM4BTM3Mx/r8b4JxU/q+akWvSaJgB4elR7FqM5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Co0p0euN; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-934f0e9d4afso2161020241.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762196528; x=1762801328; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v27XtqtTE0vb8I6rwXwNjXmYzdX4QgpL8VtUmByehIQ=;
        b=Co0p0euNgrxcFihV7kDhbi0rUw+M9sjDIqsWtIIg4MtkeRczqZv2MKaDT4My8nDE6q
         ae0qNqbGl1DyYh6Jb7aNqB2etTQ9zlhGQog4NBmDCWJqnDqp0yQ2yY9zra85J7DePB/j
         peGJYWPyDsvNJpd4Ii5aJon4OO6AKYao2XUZwn+VxOeXWfzAa0WUNYppTX/E+M0QdyjS
         AWpreCmVcuFf7oaE/etTHvkNqP96qVyYgs8V/WdKNRR8MGpi+gjFNAHJqCVJZOKIB3mM
         eNh1O4dVH7DfFpn1QZudwGA64E1CqeuV8aVMipUHcVNFeQrBy0WsMeNPYHd9IHjziNlM
         M41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762196528; x=1762801328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v27XtqtTE0vb8I6rwXwNjXmYzdX4QgpL8VtUmByehIQ=;
        b=IhS5zNpxFjJeYxhMdTZzubKZltNZ4v2qiDJxBLcZ5KoF34xzKIVpZWcvKfEtQpmQj5
         Xh5t4KpMa7dAacdIFck2fHe8CGjbN9XynOstWLmH3hrbLifiNybb11Fe8mhXn2ECeraL
         VRpjV7OL7dn8S12ZACwU+o8ReG8CJqGIdMUYY1F+QfpqqgaIOfPNKQpBsCNLPyIV2FP4
         wYIHQpPlcUQ6EtXo4L7n1hrcGxEwQSYHpCoCeVLvIEY+olRIQQrOBnwW7uye0rXsIMYS
         3yUnOwu1op7lIs7aJSEY6vVoQaHrJKh36BKDPHJXJOiMQVlmbfeiYdbpM6B6EI/PyVQP
         2Pyg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ15Ewv/doySITV9yH0Mao1phGqe+d0FN/f/R3YmFuFKqFQyt6N/mg/+pmTuhPVyBYB43ZP0gntIszOGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YykWJnAz6tCnlyJKZ6qroNNFrop5yk5dsR4v7oU4bRmWuLvFJ4T
	yy05NssG/sqra5vy4QHYXJIRuhAvGXMicUpFZlELryiJS4pHIJkcHfGnhApveg==
X-Gm-Gg: ASbGnctq3vmq7OgS7ODwMWk0as9faY1ivZCI5OuNU5LhOrnEDbdNQSjmfB2mfi1xdEE
	AzHJ5oUU758AM8zf7hjqaqsq+oanQsMUDC1OG5Rlj9hX/jAmOQM9RrUN0KnAHTxl8vuqASH7GcC
	kIMWwAePJiLnRrgHdpAAE3hnQjwB9vb9xsJdzx6V4zxl/sDlHWYf3aHVylpIIH80aRonCcuQRKY
	Q6O2liJ1GsfBVUWTlQTs+r9JvkWcE66JIhlsYBGThEUjSUaMrlZ5srdU6kVu/ls90H8udaB8a2R
	LWWzIMuCjaVZ/k0k73+QzDCXK9xmw7D++GT/p4P72d3Dr7zrcT3iBlmjsPq7v5BfpWUTIVyEBSQ
	Lyph3K09L2Wdh7NG+aIIUtnLJZH5G/ST1quGQe5m71sL+z+U1pllVD8lB7+91TUVB0lNdrPxAoe
	QqiQ==
X-Google-Smtp-Source: AGHT+IG+IMvlrobuSL37Sfl+5yndql0M53CGtNlVs2eFmvgc5wXwNVF/JuqPRORQkst7hEsTgT2StA==
X-Received: by 2002:a05:6122:46aa:b0:559:6833:8d5 with SMTP id 71dfb90a1353d-55968330cb4mr1284865e0c.11.1762196525891;
        Mon, 03 Nov 2025 11:02:05 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55973c834e3sm358469e0c.11.2025.11.03.11.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:02:05 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Mon, 03 Nov 2025 14:01:45 -0500
Subject: [PATCH 2/5] platform/x86: alienware-wmi-wmax: Drop redundant DMI
 entries
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-family-supp-v1-2-a241075d1787@gmail.com>
References: <20251103-family-supp-v1-0-a241075d1787@gmail.com>
In-Reply-To: <20251103-family-supp-v1-0-a241075d1787@gmail.com>
To: Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=978; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=2PYqlko7F9XLCyNsZ3GQYTjIvz/k9vACFLo80BZqaiw=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkcf5SeFX7wL1h2R3zVSbNTM8Ku/Ci04vuwQInlg+y9e
 TxWb6e96ihlYRDjYpAVU2RpT1j07VFU3lu/A6H3YeawMoEMYeDiFICJZHEx/A/Zvt+NUWg9B1dD
 4yfriAorT8kJp36rqyxTmjen6N/RBS4M/2sOpn7h4pm5Zt+jveq74lfqvE7c1S+hefmqzbfYRVU
 GC1gA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

The awcc_dmi_table[] uses DMI_MATCH() for every entry. This macro
supports partial matches, which makes the Alienware Area-51m R2 entry
redundant.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 53f476604269..b911921575ad 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -97,14 +97,6 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		},
 		.driver_data = &generic_quirks,
 	},
-	{
-		.ident = "Alienware Area-51m R2",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware Area-51m R2"),
-		},
-		.driver_data = &generic_quirks,
-	},
 	{
 		.ident = "Alienware m15 R5",
 		.matches = {

-- 
2.51.2


