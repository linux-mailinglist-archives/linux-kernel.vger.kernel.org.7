Return-Path: <linux-kernel+bounces-755296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DFAB1A440
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55D718A12A2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F50B274FD1;
	Mon,  4 Aug 2025 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ho/n3djK"
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A0C2749D7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754316692; cv=none; b=Thw8zcbP6SQycILeKb9pmUvViyYNvasJfA31jx+SZ1qeRoDBActaXh7jHG/98cGUjypbRbCIH61KA1WqWGxVJblszbTypi3HqvGScV7YrX2hKDL46gOwzNRc7+kpWS62vFc0+Ak297qle1H5/MHKfFysREwJsjjL1w8LeOebeL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754316692; c=relaxed/simple;
	bh=6aJ0IUU1tiFShlsFi/Km91IALlxM+CUT5l8lbTEFVkI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nEd1opTRAKpQMEd4CxIh37JMZGTPSB9DP12td1mIgw1zboZ0EC0WGuPcEkeOICCo9GQXvtKfWUnvLLnEuQOppM5QSjPbr2SDmrTMX/Jo4M5eeAtssh66ftK5nJodELAAv/rgqOmY3hMB3Z/HGKhRFcUFqHjkD5VRtkG30PrSqTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ho/n3djK; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-619083195d1so3438482eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 07:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754316688; x=1754921488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ek7nkTx7oQBr5pmhvnHkJbcjWINhcn0PApuRdg7tPwI=;
        b=Ho/n3djK/vOziCz6veotTl0aEjkAhlwcVGf6dNfvF9zXQik5iO6xiiBrkdLCEFApk4
         RIFUMfGPNJWGAZPyZROIkRTbuUcygeQWU6RnCSQolUdilBctaEfrb9uDipDSFHEhUqFh
         fZ0JtCDjFKX+yncnF5EhAHriRlDOGOIg0b6oImbBDqTqnBy9wtmdOl4yS52DJPQCOm0A
         mw7G9Z/vGt3ztODPBC7lWqG9LaxXZ/Px3JBPz9IkafHgOx8NC5iKGRxpLD7f0LgDtdc1
         0+l94PFKJQ82NR2OHkMbuXHQEyNZhfZ4oNHtRWIHPdnfYBCBkgm1gndUiokD1UbclRrJ
         1vNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754316688; x=1754921488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ek7nkTx7oQBr5pmhvnHkJbcjWINhcn0PApuRdg7tPwI=;
        b=qhcRf8+GpCGFVIthBVEyB2l+8RTk2/muoKIie5z0txG0CNOjv4DDiIgzymp0Zmg+Y3
         CVUpq+vX2M4O/zbazzAgi4KfvDEVgguCp05bl0D1sCau2+7rRXqilEEFhIJyJ8pC33Dy
         +SaOxGcWOWWPuZ8pHa3QzWhf4QGL0wKmbZd/jx0jL3dm2mg1JGXiSkdNCeSD1Mt8wVbG
         23GW3FUplPulgHo1JxvYNIYgi1FnML4k+EPZis1dn2O83u5W3iBZ5S8SX1fsgNsn/vJR
         nFivqtXwbHbbseWONFllex0b7zuMYGopTsro+6CbZMdICwtD1vvUcIByw7P9/uNrM55B
         j9Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWlFgP3CZuhqXdM6ETP/DUxd7SowkSumUgyGp61b5Iazk9LfLRDmxk/emaxYeXw1o3PgyYNkh97sRJQ/rY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEwk3H+JeVmX6EDgqzZR2lrRQgBY6vjVSD2Ll1KlUOUuhcFpoP
	EnhF3uqs56waXMSNZlohkMkgKHHpMOLx03mQCv7bQdOCNZUN+DHwFEym67v4Mxd7hDepBz6CwHR
	5Ghs0NVl+5g==
X-Google-Smtp-Source: AGHT+IEjr5sJfjbBUQYWZhIZ4rOglGuDpQpVSXj939XY+s2kAy7ykktL0lHdO88lLNN48OXhn6sUKk4ZSq/C
X-Received: from ooak5.prod.google.com ([2002:a05:6820:c005:b0:619:c124:3048])
 (user=jdenose job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:f02:b0:619:81ef:2511
 with SMTP id 006d021491bc7-6198ef440a8mr5302900eaf.0.1754316688530; Mon, 04
 Aug 2025 07:11:28 -0700 (PDT)
Date: Mon, 04 Aug 2025 14:11:24 +0000
In-Reply-To: <20250804-support-forcepads-v2-0-138ca980261d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250804-support-forcepads-v2-0-138ca980261d@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250804-support-forcepads-v2-9-138ca980261d@google.com>
Subject: [PATCH v2 09/11] Input: MT - add INPUT_MT_TOTAL_FORCE flags
From: Jonathan Denose <jdenose@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Angela Czubak <aczubak@google.com>, 
	"Sean O'Brien" <seobrien@google.com>, Jonathan Denose <jdenose@google.com>
Content-Type: text/plain; charset="utf-8"

From: Angela Czubak <aczubak@google.com>

Add a flag to generate ABS_PRESSURE as sum of ABS_MT_PRESSURE across
all slots.
This flag should be set if one knows a device reports true force and would
like to report total force to the userspace.

Signed-off-by: Angela Czubak <aczubak@google.com>
Co-developed-by: Jonathan Denose <jdenose@google.com>
Signed-off-by: Jonathan Denose <jdenose@google.com>
---
 drivers/input/input-mt.c | 14 ++++++++++----
 include/linux/input/mt.h |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index 337006dd9dcf72ef2eeb8580e4dd83babf8100be..09f518897d4a71a4a7625367dc2c652ee6035d98 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -198,6 +198,7 @@ void input_mt_report_pointer_emulation(struct input_dev *dev, bool use_count)
 	struct input_mt *mt = dev->mt;
 	struct input_mt_slot *oldest;
 	int oldid, count, i;
+	int p, reported_p = 0;
 
 	if (!mt)
 		return;
@@ -216,6 +217,13 @@ void input_mt_report_pointer_emulation(struct input_dev *dev, bool use_count)
 			oldest = ps;
 			oldid = id;
 		}
+		if (test_bit(ABS_MT_PRESSURE, dev->absbit)) {
+			p = input_mt_get_value(ps, ABS_MT_PRESSURE);
+			if (mt->flags & INPUT_MT_TOTAL_FORCE)
+				reported_p += p;
+			else if (oldid == id)
+				reported_p = p;
+		}
 		count++;
 	}
 
@@ -245,10 +253,8 @@ void input_mt_report_pointer_emulation(struct input_dev *dev, bool use_count)
 		input_event(dev, EV_ABS, ABS_X, x);
 		input_event(dev, EV_ABS, ABS_Y, y);
 
-		if (test_bit(ABS_MT_PRESSURE, dev->absbit)) {
-			int p = input_mt_get_value(oldest, ABS_MT_PRESSURE);
-			input_event(dev, EV_ABS, ABS_PRESSURE, p);
-		}
+		if (test_bit(ABS_MT_PRESSURE, dev->absbit))
+			input_event(dev, EV_ABS, ABS_PRESSURE, reported_p);
 	} else {
 		if (test_bit(ABS_MT_PRESSURE, dev->absbit))
 			input_event(dev, EV_ABS, ABS_PRESSURE, 0);
diff --git a/include/linux/input/mt.h b/include/linux/input/mt.h
index 2cf89a538b18bbc7c99c8705c2d22bdc95065238..d30286298a00a356bc9db954ae362f034cdd359b 100644
--- a/include/linux/input/mt.h
+++ b/include/linux/input/mt.h
@@ -17,6 +17,7 @@
 #define INPUT_MT_DROP_UNUSED	0x0004	/* drop contacts not seen in frame */
 #define INPUT_MT_TRACK		0x0008	/* use in-kernel tracking */
 #define INPUT_MT_SEMI_MT	0x0010	/* semi-mt device, finger count handled manually */
+#define INPUT_MT_TOTAL_FORCE	0x0020	/* calculate total force from slots pressure */
 
 /**
  * struct input_mt_slot - represents the state of an input MT slot

-- 
2.50.1.565.gc32cd1483b-goog


