Return-Path: <linux-kernel+bounces-857075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 62281BE5D91
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 02:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DFCD4EFF7F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 00:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E68A945;
	Fri, 17 Oct 2025 00:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QuRknbAs"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7A0C120
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760659277; cv=none; b=TLy6YCTd1IgoFElC7b5apFJxbEroWOpqT7Nw18kE/alHcelZvAVrpoRSFspYx7eYWNgfdaumeA5+4v02y0BoDVog3pC378o4HN3Beu/hd2ofTQq9o7MGxAeyuY1EJmVtMbInaNXSFGOLIIbr2hRhhjdFBDR7q69ZvCuAp+5cvAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760659277; c=relaxed/simple;
	bh=d3vMgGjtDBOyl9OMQildPrcV91xSXzk0ehLUQ/v8Xv0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BLe1nD+jGqXfgbNWj9VH/ElWAiBRnxb7vcLdPICYikY8nvE7X5UdPxYcM5EJFZiUYrbzk7GuZflE4TBrMzoDH4eyxdhxjIacnd6dW9Stw6P8v8BZmGC2IXEGcF/f8n3ndsXPyTgiIi3zhE5azt/nrnA452ywrEwMJd9RTA+7Zmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QuRknbAs; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7246755a21cso18969207b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760659273; x=1761264073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A78b5qm3ewGLH/hUPVAkK/xpFE0iF757uAxcChhA++c=;
        b=QuRknbAsGyKsxrzZ5JEAbo3dZPm2D83FQXEkDMLZGUW9IXCm6tm52h0apq7XphmU+f
         gcx49zQ1+1IaCIgRBFTmu1dtGFU+x2lCBzih1DsZrM6D/jrdZCmEwLONc5z2NtfYfavV
         9ZBYSLfnT7fdfo6qHPhLY54+VEWptUZ+iaPq7i0XAZR98tguDZWBS575xDAmAeG7XzP4
         g1U2mlP63v418SsrADoJViIykwlp4hn1HL8P7BB4Z1ULv4FR5WYxU+xsI7UnItHPa68q
         0UftWxKEHtGoZi12H2KSK8elHJOqMyTxuzjVLsi9GlhTyrKBafvVKvT9a7elEUpc5J2s
         Rd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760659273; x=1761264073;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A78b5qm3ewGLH/hUPVAkK/xpFE0iF757uAxcChhA++c=;
        b=UX9ECK7KmpkXbh85sWnNPIYTLDbYqh8DJu+9EOhQhGOXevR66NuEo4ncbAgPjhvqaO
         vvJDT44Y+5LG1oUhOjyJUkVK2KYYUDe9NvXB54OtpKBrWlJzKloLL7nuWwfKfZJo/IbV
         kK1Gp4+YZKxzxFfmpzoKwk3eBUBR/b6yBJuovP77QDPXiUQPlwcsZlM7z5vA7O1XFAk8
         c1ER2rPAikP6tzv0yL18OHOYfBex/GNgH3sbi67vmIDtONDfs0RGTO8gxVhsMtbYWCiQ
         lubPvSS+TATu2DpWkFiLLs/I0t9NXEok4Pg2lTlSA7U5SevgsBR9ghgDt5yZ7w2RZSAV
         1cig==
X-Forwarded-Encrypted: i=1; AJvYcCWPPeFcuY6YIBM1b96W7ZomjkhmyyZMYg0LoppKIJbWwAHQzYoRVWbr+eXJaKR/2B4+/u8poDnakNv2nR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/HTr9rf9I2xiJtcFP+5UzGW5XPWjOoon+3VCeZCXvEJAogIRl
	gOG1yYbdagVi7fBRx/K+KIAe8J0yK4TTUYr+NtndNS4VKMvoqHiXRNDvykJw7xG54fu1MMKc8UW
	/gs7kdQ==
X-Google-Smtp-Source: AGHT+IFylybvNrf3hXc+GFgB8oGAf1c3GA993gedEMW8xHo1GeQ+Z1gBgex+rl8Insn441vHeB3Esg0x1As=
X-Received: from ywbik3.prod.google.com ([2002:a05:690c:4a03:b0:783:2d0e:3443])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:7089:b0:781:64f:2b63
 with SMTP id 00721157ae682-7836d3a2c7bmr19754167b3.63.1760659273157; Thu, 16
 Oct 2025 17:01:13 -0700 (PDT)
Date: Fri, 17 Oct 2025 00:00:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251017000051.2094101-1-jthies@google.com>
Subject: [PATCH] usb: typec: ucsi: psy: Set max current to zero when disconnected
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org, 
	gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com, kenny@panix.com, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org, 
	Jameson Thies <jthies@google.com>
Content-Type: text/plain; charset="UTF-8"

The ucsi_psy_get_current_max function defaults to 0.1A when it is not
clear how much current the partner device can support. But this does
not check the port is connected, and will report 0.1A max current when
nothing is connected. Update ucsi_psy_get_current_max to report 0A when
there is no connection.

Fixes: af833e7f7db3 ("usb: typec: ucsi: psy: Set current max to 100mA for BC 1.2 and Default")
Signed-off-by: Jameson Thies <jthies@google.com>
Reviewed-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/psy.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
index 62a9d68bb66d..8ae900c8c132 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -145,6 +145,11 @@ static int ucsi_psy_get_current_max(struct ucsi_connector *con,
 {
 	u32 pdo;
 
+	if (!UCSI_CONSTAT(con, CONNECTED)) {
+		val->intval = 0;
+		return 0;
+	}
+
 	switch (UCSI_CONSTAT(con, PWR_OPMODE)) {
 	case UCSI_CONSTAT_PWR_OPMODE_PD:
 		if (con->num_pdos > 0) {

base-commit: e40b984b6c4ce3f80814f39f86f87b2a48f2e662
-- 
2.51.0.858.gf9c4a03a3a-goog


