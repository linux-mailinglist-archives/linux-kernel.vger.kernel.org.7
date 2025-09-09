Return-Path: <linux-kernel+bounces-808156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38811B4FAE8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0B427B5433
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A9F33CEB3;
	Tue,  9 Sep 2025 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cjHZZsc0"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9974321F39
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421054; cv=none; b=Yb2uy2SsOqQuMkxwOPUUPqUqXVohqxIh8NhLQNr+fOGIOKs6VESq+sRpz73QGFv/+jyoOpyquDcGrxBypdCMknbuBdJ4FCzMPs/uVOx46I75oC7ibfcsqFPBX3d6XXv/LsRLTmj/QWa9Zfe0xrXVfJXITbaYdykrvTpC11t0Yjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421054; c=relaxed/simple;
	bh=wo2Nci5KTZIZbP8CX9Xb4me0P/T5bVmP7HGaZVx1QBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUcThuCD0P9gu4dqxKJKNmCCmaMHtYruSAU8Z6KADDO5im5T3T9l5Rrd64zVbwClo/URphpNmqYVhvS4IAmRfo3Ymt+LJoEDX3+R4YZGGmmPe/42BbjcyVNhX22AcUwQEr1xL8wRt2gNZQEpQNQAOoa86eq66MLw/LVxWvOEXK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cjHZZsc0; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b0449b1b56eso812006066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 05:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757421051; x=1758025851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeRnafoqGXMQLsLwS7RKCqhJvzceHCqSnadqMFnp/Eo=;
        b=cjHZZsc0aiXrbjIPGEpyS1c6lM7q+OZbd1XR0FWseu0TzNa11rQLPKVwfoVMXfvbiO
         Fe4CkuxYLV/vlJHERotzpYub+dNEnn+qwXXhZAkoOgij84piiGky2w9p53487RyRKZSX
         47EzIugYwM39NUOsjKKlW1TavwTzMTkeT9TEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757421051; x=1758025851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yeRnafoqGXMQLsLwS7RKCqhJvzceHCqSnadqMFnp/Eo=;
        b=HWwp3ER1fpZIvr6mfP54OTcMUAlj3DXAZC/xD5XD7n8ii2yQUDtSciTSN3emf8W+rH
         eXKSRA6JXtOPxp1OOuoTS3zGVz3vfKvI79m1qA21YFIN2aFK9Wo7wkM2dEFmFuECGmmD
         Qk30/N7Y0a1oDKTHcpWYOcAXVd70DX5EOGPz5QaIxlZWP4jwy5Q4aeKVL+7iW858W41/
         moQcI6eBgUpKmktbdLz0wH7+EdV6f63tSpNNyXpFEhWltfg6cBL2t12aHhvSgLvKp3vc
         PBeDKOkNy/C6+bVUGcbF2HXCPBRqodhSiiZ00Dyvs8zGaI5W/IYNE0ZXcewD4lv0AAju
         bd/w==
X-Forwarded-Encrypted: i=1; AJvYcCWq6VufzBKtSkpUrQtZFkec3BAcxbDMmlp4AvfQqluqPd3ssqni6WbeyVwJcu05PoxpvNcORpD7zEEgLfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcmsLS5Aw8+0Sahte1042U0GsixgUfdohOH96SA6ZwCPc2+W35
	1q18YA3Sf6WNkrzLIcfRW+Y8reaePWyU4D0B5z7UM2YMpakUpuuzwrqv2JraN1Iywg==
X-Gm-Gg: ASbGncsFPb5xWBmyFToHgVkPbKhvxv1LfMHTyQzmGPONp0QJebaukzi0OJ6i980BGU1
	4JsKNB4jnsKTfNuKjW4ts/Nk3wQzW2DcLXOEO95lgerGLW/FUvy1fso8lZ95Yad2Q8QShSlB2bR
	JvaZgtKkVy55XZR0tWD4ShzvzZk6Y9HcBswLE9l9H8pKPQqdmOxCSc/Ovx4s6O47E6XFnNi5+bk
	cQQPCTNcw+4Uz2UBYKubwUTj9fGn8+7AlsS2M58JddC/6XWfZsT6/KbhGFfa9g+G6K+H82iBee1
	/oaZ1ISXRgxdwp8Ib5B2XmwU1VX7w0EcBm6bI4AY/60tS2ZpbkTbg7X7DmANYspOlhybTvJMh05
	sYPqxEjvUKP0Yhq7PaaxtfIDGG39bstkR76Kj+11siDd+Q2Vuft8/RQXaUbJ37sqD7gmq8sakBv
	4JR4SAM/YFE/uZ+8+kXHH14a+FQg==
X-Google-Smtp-Source: AGHT+IHum5WD472d7fS2rBLDEJ4/Qj+9NWbX7rnTe/jOnY7UY4cYm3PCK7sxMJpUkyS12VpRXD21hw==
X-Received: by 2002:a17:907:9410:b0:b04:f5a:8c13 with SMTP id a640c23a62f3a-b04b14b37c6mr1069077666b.15.1757421051199;
        Tue, 09 Sep 2025 05:30:51 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (240.225.32.34.bc.googleusercontent.com. [34.32.225.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01902d0e99sm2409702166b.12.2025.09.09.05.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 05:30:50 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: Guenter Roeck <groeck@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>
Subject: [PATCH RFC 4/5] usb: typec: ucsi: displayport: Propagate DP altmode entry result
Date: Tue,  9 Sep 2025 12:30:27 +0000
Message-ID: <20250909123028.2127449-5-akuchynski@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250909123028.2127449-1-akuchynski@chromium.org>
References: <20250909123028.2127449-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reporting the error code via VDM back to the Type-C mode selection logic
allows the detailed result to be propagated to user space.

Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
 drivers/usb/typec/ucsi/displayport.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index 8aae80b457d7..47c28646cfa9 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -234,14 +234,18 @@ static int ucsi_displayport_vdm(struct typec_altmode *alt,
 
 		switch (cmd) {
 		case DP_CMD_STATUS_UPDATE:
-			if (ucsi_displayport_status_update(dp))
+			dp->data.error = ucsi_displayport_status_update(dp);
+			if (dp->data.error) {
+				dp->vdo_data = &dp->data.error;
 				dp->header |= VDO_CMDT(CMDT_RSP_NAK);
-			else
+			} else
 				dp->header |= VDO_CMDT(CMDT_RSP_ACK);
 			break;
 		case DP_CMD_CONFIGURE:
 			dp->data.conf = *data;
-			if (ucsi_displayport_configure(dp)) {
+			dp->data.error = ucsi_displayport_configure(dp);
+			if (dp->data.error) {
+				dp->vdo_data = &dp->data.error;
 				dp->header |= VDO_CMDT(CMDT_RSP_NAK);
 			} else {
 				dp->header |= VDO_CMDT(CMDT_RSP_ACK);
-- 
2.51.0.384.g4c02a37b29-goog


