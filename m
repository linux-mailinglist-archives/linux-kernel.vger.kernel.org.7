Return-Path: <linux-kernel+bounces-754906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DCDB19E40
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAAFF189A989
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400C024E4C3;
	Mon,  4 Aug 2025 09:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KnM0i9+I"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E2724EA85
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298282; cv=none; b=qIaUFRWSYDSc1/azIKdJQ+s/do05FnAS7f/psA2UvN5z6EXoMxO7lc29+7DGDgsDHSGGD4q0557I3CYntssDbR769es4cOyTD6RrBOTKwFbbPXyETIN8NAIjDBk9nsFwYL/aFHw1Vt9mMzeVNAsRr6ifJroF1MpG/w48O3F37G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298282; c=relaxed/simple;
	bh=lGxWrmyJi7QQe0IzSfeCLytqae6M3U2caSjouup0SQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlD0aAAwWYMXosb/moXCPP/Vt4L/8HrqSxkGehhChix8O/KBiDeTmgYIuswlXhpoeXzYpFYirbX0rTtTtuPBKI8Yfyz0lqpU4zSPR/7Ln7VTDDbfbgvOLyQ9myLEWCjpaQa6yBBppTQa0SJ7Bbq+KR6GBOv10BYwoblzDaPQi18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KnM0i9+I; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-af968aa2de4so117526366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 02:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754298279; x=1754903079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwNnM2nFXT5vCpq6GQAtc8w4BljRfhoqKtZx8NfXTfY=;
        b=KnM0i9+IYqWS7cCwt0nKUZ9IR3Fjrd5yFGTtHygPlWnL27Y0BSSu0wBBCS4LZXiqvV
         AuuCZr+w2en7snRfIcsmPb6473CtbzNbwVy3JS8N+oLIvDMBXB5tBpz+HXrzkkKapZJQ
         Gn6e5hVBhTkm0EwZKtpAqUFrAn/vnsri+snBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754298279; x=1754903079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwNnM2nFXT5vCpq6GQAtc8w4BljRfhoqKtZx8NfXTfY=;
        b=KwyJBLF4NRhdeO9dGX1y3n2RNJqCX9ppZkXL+Cigf9xPxuVMEZRDrWhNlvodKg3LoA
         6TunAYQpk31HqopO71tZ4And9w3NRvO0XRh0HRQyMPD/MeqoewAq4LngnK4zJ2KoWRfP
         Hhi7fS2aJeM1v/GNTGvZd8Ndp5OHvdfumqSCNoRfs/NCDeZCTf/aE0zxDyCLWMzjwrLz
         K9r6stdtvc76nLZloswYGd2gAPW7gho1ZFKTQZlGkKxTGxENlITI4sKk9ODZ+PeFcIHj
         oQk1vrT9t/B3s3i0I8ka0hQBJ+XD33mKZyNWIlyCKC9+onfciG6jpROpXmJq8OLUH1wi
         AR4w==
X-Forwarded-Encrypted: i=1; AJvYcCWSRdKny6KhqPJe+DDK6BQ6p46wl6p+7oootVC92fAOSQDvH+ZZJRE2+ezixKoilaubIkV0hPtWtv2vuz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpdniWrNCCTGSGfUEuzd/x/GCMk7tN44jAzGWqwXi4D3j1a2Eu
	SbOrjj8yLlfyPngfP1Q6V+oUUgGoPKK8wWH3uEzccFVDD/Jw2DNpqJKjJ1ApWrLOiw==
X-Gm-Gg: ASbGncuctjjlJCniQikQe+KslEiqY6DNYXTwCcUZVMMgj5A9j02y4/np5abgEBFfv3o
	ikusfj5Pzwp71uB5P9ztdeeV5cXYMOmSvQ4OhlGIgAlk+EBSt46U/3vjMEbvpVhV75JiOxl/7KM
	y4mQbW1pqBc2zXUv+InxLtVNkd8D6uwd3zuRIaf47FpKFKS5/VMX6ThppM6UNkVOix4LuT1H6K9
	9Oa3D3kAxz4DyY+sKrVM3XUborpWR2hZ/jh2+Cgif6bXs6vKTgSgbkn0K85MAx8bOifvLecKUVx
	IroPyWnZkCoj0QVQ/TC3z9R3QrTrdcRA8jVwMBIgLtnHsCjFMsxi6U/aEhpqJ0DG3gVuGOYh9Ji
	3rILYEvyc6QEmu2A+y0ElbtJ8ENdVnuL77I6gh2VGU5/kYYGMg3OOEcF0AOMMY/4URqrilXJlnx
	WOOJirTcBksNTNuXI=
X-Google-Smtp-Source: AGHT+IFDY6Eti/U0HvJUllLufsYb1TLIXF6CEqk3Nsb18AYq8jRe68qPhRYRsXxRYg9IeMMo3fetyA==
X-Received: by 2002:a17:907:7f0f:b0:ae0:ded9:7f31 with SMTP id a640c23a62f3a-af94001f8dbmr979021766b.20.1754298279104;
        Mon, 04 Aug 2025 02:04:39 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (150.230.32.34.bc.googleusercontent.com. [34.32.230.150])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe7995sm6412790a12.36.2025.08.04.02.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 02:04:38 -0700 (PDT)
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
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>
Subject: [PATCH v3 07/10] usb: typec: ucsi: displayport: Propagate DP altmode entry result
Date: Mon,  4 Aug 2025 09:03:36 +0000
Message-ID: <20250804090340.3062182-8-akuchynski@chromium.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250804090340.3062182-1-akuchynski@chromium.org>
References: <20250804090340.3062182-1-akuchynski@chromium.org>
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
2.50.1.565.gc32cd1483b-goog


