Return-Path: <linux-kernel+bounces-883570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA3CC2DC7F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E1804ED3EA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42F521A459;
	Mon,  3 Nov 2025 19:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7RcTaat"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5FC1AF0AF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196529; cv=none; b=ZeOWoTeUxzMJqNwLUnf/EiOh75X4Ts8/2fR8J/MAxbJFTH2liM7jPRNqubkeY3FwFMkGj7B3skSKDYFBQTDV5gXYz9I85o4NZgUXgTXmhHOYbaQ3R8yJ9niYLBzlU9j7Njw9GQx9JM4cLyOjDMzNMtv8SdZdCmVtlxuadB+xAoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196529; c=relaxed/simple;
	bh=DbFAwez0cjMr7osbfexuB3kDFZnSvUx7kQxtUW3PIsc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UviHe0WhIapVhf2/vrEGF/Vey0EI0SJvy+B4z93+i80iRWrwB7GVzgQ1Iolzhq/O9K5yeF1V9dndJdAF4GOsGTgVfcARuCUmNLBPbKvUaE7NSJkBmkw7W75CgyrRO0HKz5hlW9O3hTBal6pgVqAnInPo9ts5HD+pEcSmwDNQ2D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7RcTaat; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9351daa04b7so2102825241.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762196523; x=1762801323; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JCgyYYl17212afWq0WmdVNHdmhfE4WpVfwvlvWkdR/I=;
        b=N7RcTaat+sbzxC9Umtmn4+rvXHFsVIoj/FJ/zTHEKLmoLmxdoFeYS9RDheteD6khOX
         2KQChajtn9cnBzWKlrtajuIxjgJzeSa9NI52+nVuzgV5xbnRbX/g7/65F+39HreoF8IZ
         WKb2qF88Dl1Km3jspNDf5erwdt6ydN90mQdwndCkmgYohsJ5JUqunieSd6gxbxFUWnb6
         ZFhRCvISnHkXllWrcB0G1sc1/JR4JTJZbv2BmBlJ1R22wbKdrVVMeCEwIPHn7ULfARB1
         PS3o2bvu9RrpSA3qh+durUZvt9+2yif+pMrIW0peRatXwvPc//qo+nlvarnnGevj5KEo
         JkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762196523; x=1762801323;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCgyYYl17212afWq0WmdVNHdmhfE4WpVfwvlvWkdR/I=;
        b=kocYyZeQiuujflMeZ+XzTScyXgBSLjj9lvHQPBnpKZb/59DL/CxAfFMwfNsVrmnwEC
         1Uw5OvBTZpPaSbROxpNkHtSgob2wRctn2arAPwQ+h6YOEGUfH6lnaBOz3tm6pyC9W1HH
         xvjstH9jKRW/0m028dsUo9t+3IWUF52frgd/fv+tUtB4ibdi5CHs1bJ47NSuMtMAu0Z1
         zdvyvTuUR7Ng3wAgEyaE2cgQVvnM4j+pxu+Nw3Yg9UeovNrGTruxQqPgzSFNr7pluj45
         cC4Z+qVtoQF7SV3hQDFZ2Ptu5IRy2vHkR6BnYJMlgd+DDN/0IkEp65gl38B5DAm+E1iR
         3Xng==
X-Forwarded-Encrypted: i=1; AJvYcCXc6Y4sDlKirS5ZklL46vsU37HpDdWPZl4kH92Nyw6ZBMkieMqF+LaSYcqwcj2szixleR2hCRCwJZ5f/aw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Sl0JK3tFP+f7LB0Qb+28GsjaAOwJpjEHRg5Y7wTi56Ao6Ir6
	rhStSY3ZPmA6EddG5RiICopG09drpd8wQvqqYFewBbaYPc/pOeGfFGJqYfgLow==
X-Gm-Gg: ASbGncvqcFjROgv3e64eX6Ldj0Jh3CQumjSPIQ/nAbQQRNweeSwiyvKDzqPXu7qiBGP
	KZoxukf5ZVXG1mfJpbNF7aXGvKsIwSc9cgjEEucEZCPgOHscFat301KEAq9eIZl8+PjUCBUlC0R
	xAuyVfBwrCVmgaj5hFJnvSKAHShbrNn+bUGUwnkpdNpc+sKdXIfFicEU2ui9wtGUuGKCtwG4SmV
	UdJ51xpYKx3YxYpd9L+Gb4dV6OmMUDoeGT9Bci9RYydj5HWuYgnv8j6+1/zQdQlJnwV9RIN7Urg
	sp3Feql133Ptvsf84YTPIRXGeFD1tG4i0dwQx0wZxoNRaCIXzmdGT3DUsDYNVYy1wDuVKPgpUyI
	FYSj8mdafphhwFwTCvKlghvpB3UbLav8rUgB3/IihOHVNVIzJYRhtgKj4EbFvd3VusM+bs6z5cc
	gi4g==
X-Google-Smtp-Source: AGHT+IF6ZrnGeB7r0RyVBzECaRGawNu02DZMNOtb1XSlboch2JDalhSDF7ll1MdUkogMoDYfu5R1OA==
X-Received: by 2002:a05:6122:250d:b0:54a:992c:8164 with SMTP id 71dfb90a1353d-5593e404ef5mr4706586e0c.7.1762196521682;
        Mon, 03 Nov 2025 11:02:01 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55973c834e3sm358469e0c.11.2025.11.03.11.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:01:57 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH 0/5] platform/x86: alienware-wmi-wmax: Add AWCC support for
 most models
Date: Mon, 03 Nov 2025 14:01:43 -0500
Message-Id: <20251103-family-supp-v1-0-a241075d1787@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABf8CGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0Nj3bTE3MycSt3i0oIC3UTjxESLFOOkJCPzRCWgjoKi1LTMCrBp0bG
 1tQCitVuzXQAAAA==
X-Change-ID: 20251013-family-supp-a3aa8d3bb27a
To: Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>, 
 Cihan Ozakca <cozakca@outlook.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=DbFAwez0cjMr7osbfexuB3kDFZnSvUx7kQxtUW3PIsc=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkcf2QaPmz/etjZoiJ2e5P879lyZ5g6bLuqbQNPnTxsd
 GvixoTAjlIWBjEuBlkxRZb2hEXfHkXlvfU7EHofZg4rE8gQBi5OAZjI5DKGX0y5/8XlvLrZfqpn
 Wn4KD9fbGWHfIsP287keg9qReZe2+jMyHFXv8m3y3L3lRosPV12jKMuEOW8/HL5ac21rndztYzb
 CvAA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Hi all,

This patchset adds support for almost all models listed as supported by
the AWCC windows tool.

This is important because the "old" interface, which this driver
defaults, is supported by very few and old models, while most Dell
gaming laptops support the newer AWCC interface.

Thanks!

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Kurt Borja (5):
      platform/x86: alienware-wmi-wmax: Fix "Alienware m16 R1 AMD" quirk order
      platform/x86: alienware-wmi-wmax: Drop redundant DMI entries
      platform/x86: alienware-wmi-wmax: Add support for the whole "M" family
      platform/x86: alienware-wmi-wmax: Add support for the whole "X" family
      platform/x86: alienware-wmi-wmax: Add support for the whole "G" family

 drivers/platform/x86/dell/alienware-wmi-wmax.c | 104 +++++--------------------
 1 file changed, 20 insertions(+), 84 deletions(-)
---
base-commit: bd34bf518a5ffeb8eb7c8b9907ba97b606166f7b
change-id: 20251013-family-supp-a3aa8d3bb27a

-- 
 ~ Kurt


