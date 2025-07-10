Return-Path: <linux-kernel+bounces-725990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B010B00661
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A1F189C5E6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B882750E2;
	Thu, 10 Jul 2025 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CcCZZjRz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09982274FFD
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160867; cv=none; b=Db3ae1DNKR0K8WvcDFe8Uzx8CIThp6oFpAjNtv9wtOmpVmL3kb/Br5REwxJ3+qltRkeY3nEhIEpUP/3V5PzNsM+XPfbHyYR5dZPLX7UKF5bywytnwbh+PDO58x6NqxL/OzCQ2rAkmxBDzCMCXPSSbaYDjcCOV/f4MfU7OhBcVjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160867; c=relaxed/simple;
	bh=5dhSXbabSOIot1EwSUx0tN+/kwz+r3qTKvgei/0M1C0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lKBIIGhPL8Wq0Kh2fr5Xvuw/6tb0yglh++LfNjCDR1rhgSu1AEyht84XsvtsAphJNZxAA+2AX3A4O/gA+IKx8fougeiQA6oqymS+80QRXsHxrShbTsnKbvmhCg7jCjmMKQNUmF2dw4UD6Kj6PSbFtHiAz1xYksM4BPXyvqG41Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CcCZZjRz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752160863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfAZifEVmiDYokEi8qaAJcFUVRfsukjdAyRsQDueIBE=;
	b=CcCZZjRzCK7jZi7XZgF79U8+E1b779OfqFWbx+wQtbYGgQkMo4BmeSjZOD+Db/UdvUwWUA
	J6ohY+pD/xZmHoEAHRR7Eq7mXaEisE4SgzqtEXiEUji+ybFrlDGTZXzNF11z+VUCmgTFx3
	6bO94LQ+D+aVJiVNE9gpf9y56v6vq34=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-ixN1GAG_MJCgLi_Z5UNURw-1; Thu, 10 Jul 2025 11:21:01 -0400
X-MC-Unique: ixN1GAG_MJCgLi_Z5UNURw-1
X-Mimecast-MFC-AGG-ID: ixN1GAG_MJCgLi_Z5UNURw_1752160861
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a9cce09a9aso23565231cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752160861; x=1752765661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfAZifEVmiDYokEi8qaAJcFUVRfsukjdAyRsQDueIBE=;
        b=l6IdtDReA4XOudTpjRpIM1o2CBP8ksinS4qwoOvo+wzF5kOADy217XBpokLR7o4AKE
         8rXx7w+k0HViyp/dSbd5gZyq4MKXWiZk9c9DeCAuQAPKJb8T4twANXdoEvBmSbdLEvKt
         UF53QnSunckGqGiujsfe2qfmMDZlta569YzpJD76OTJabqU6uI/52A104yQsDKBEOZob
         7kK+p/5OsFe1Iscn3QkymaULYJ2Q9IrbPhUDhr+tYxCRxIMap4EGiG1B7dJUBlybWj1I
         5JW28c1eTJWRcofZaWqODLvH1aNH/32EjjMwFYXgQL+rsFO6SBPsdnPOfWK3ZmDut6fW
         7FAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrQBoAV0r5ES1IESDEO5vBvwKPSeAAVOfJQ4Hi/ZjD+pyj4KLGCW7R5aj59oB+7dW+3VoQTHo9nEMqIlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaHRPj2JQ3+xFf3JFEBv9lyZOGQJSr5K4ADDWSnTy/oBB2vtfX
	WYPtRdO7QDrkCeCrsOH98FltIRbWnfDBE75io+vvWKGexMpmDgwyo6dZgh85bWGzsGAW+zHweH/
	22OBygs5J0V9XtpbzTMsBbuK8YRUeMA01AAu1C0awPJ62TR+XfG4v4c5XJXUWI7OQDA==
X-Gm-Gg: ASbGncttEYE5ekeimvebNB+Z9DrzAH5HM1V6kihJzPG4NWWbTyghsckqE/OwiOX8gB8
	NFjJyjPE0q6H5YngiGy14DEfRbTyDWGy90RY1Xhd01JCMf5QsSEff+e7lEWTdhVxkfKVB7wyf/A
	lZI89cQo+laoqtmWGITBkffhtNy5b8iv0MyJnXp6TQG4+PNayx2SmcXhu+PcfOjhEFy/O1a3awU
	MEE4AQWYeRjkHeJppH1hthSORcynfd37PuoWLKmxh+pnQl6SCreFVl6WMA7WRZWhrH5mVfsTKvV
	UuAWdUfFBR7sBEvCPDsOGaQakyb8HA8dgEu5fArd3o1swxjmBlihltOwr8Ig
X-Received: by 2002:a05:622a:2a0f:b0:4a8:2d24:72b3 with SMTP id d75a77b69052e-4a9ec8152c0mr54126751cf.39.1752160860868;
        Thu, 10 Jul 2025 08:21:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZg7tT2TKkLa812dOO0cuVbNuTqTsuTm9YCrDOkt67pP9zNi/06aVHc55G542WY91jCJtYaQ==
X-Received: by 2002:a05:622a:2a0f:b0:4a8:2d24:72b3 with SMTP id d75a77b69052e-4a9ec8152c0mr54125881cf.39.1752160860286;
        Thu, 10 Jul 2025 08:21:00 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edeee2c2sm9654471cf.74.2025.07.10.08.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:20:59 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 11:20:23 -0400
Subject: [PATCH 03/15] rtc: nct3018y: fix incorrect maximum clock rate
 handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-rtc-clk-round-rate-v1-3-33140bb2278e@redhat.com>
References: <20250710-rtc-clk-round-rate-v1-0-33140bb2278e@redhat.com>
In-Reply-To: <20250710-rtc-clk-round-rate-v1-0-33140bb2278e@redhat.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Akinobu Mita <akinobu.mita@gmail.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Heiko Stuebner <heiko@sntech.de>, Andrew Morton <akpm@linux-foundation.org>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
 Mia Lin <mimi05633@gmail.com>, 
 Michael McCormick <michael.mccormick@enatel.net>, 
 Heiko Schocher <hs@denx.de>, Parthiban Nallathambi <pn@denx.de>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752160847; l=1069;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=5dhSXbabSOIot1EwSUx0tN+/kwz+r3qTKvgei/0M1C0=;
 b=Z+eHnE3yFv9Mc/2pw97GUAxK2h0eRAwimIQZHOw0PqyzYENQDmyX8/9qqzMvrvfVYCneaOqS6
 wbDceofTElTBQ1umKhp9Jwiwd5C7UTuyCYdg3bAtiY4LJ8MkwhDIFRV
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

When nct3018y_clkout_round_rate() is called with a requested rate higher
than the highest supported rate, it currently returns 0, which disables
the clock. According to the clk API, round_rate() should instead return
the highest supported rate. Update the function to return the maximum
supported rate in this case.

Fixes: 5adbaed16cc63 ("rtc: Add NCT3018Y real time clock driver")
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/rtc/rtc-nct3018y.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-nct3018y.c b/drivers/rtc/rtc-nct3018y.c
index 76c5f464b2daeb59fa8367bff3ad261ed75dd937..cea05fca0bccddc6384c462cf1ebdc59b377a24d 100644
--- a/drivers/rtc/rtc-nct3018y.c
+++ b/drivers/rtc/rtc-nct3018y.c
@@ -376,7 +376,7 @@ static long nct3018y_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
 		if (clkout_rates[i] <= rate)
 			return clkout_rates[i];
 
-	return 0;
+	return clkout_rates[0];
 }
 
 static int nct3018y_clkout_set_rate(struct clk_hw *hw, unsigned long rate,

-- 
2.50.0


