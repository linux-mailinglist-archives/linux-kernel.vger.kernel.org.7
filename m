Return-Path: <linux-kernel+bounces-853291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A51ABDB1FB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 191F44F8CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613C6302145;
	Tue, 14 Oct 2025 19:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tAxvt9dn"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FAD3002A6
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760471469; cv=none; b=XzWvSHYo0qhJQkjdcq7N7CJ0OuAr6U0sb23a1ZcMgvIPnsMPtBbPDmnSZ3QG0Lg+W7XvmdV7rkRDwu9p4obRnXVVHW4LebqS3Lau42lXJnOm5+oFzcaW2tOJXutCmmxp0Xr3LzNaQF8NhnYbPLjxlMPyJgt1FWa+gQZ4EDGcIWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760471469; c=relaxed/simple;
	bh=WSQ2iDb3hcVF5qM6lFll1BwCOEotVXw7mTOGjytvpYI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QGT1I5ovVV0+HjF9DP8MtA6oY2xHw894KUyKb7TKhtTLKXX75cHvMymoI4RPTnOfxKHdYRQOe7QQAyUUxER7+06Kj5hrVKDJWPrvW6XXw/OZgzZ1ut9iUi2eIzNku0YC9Z54QuW8NZBO/wmygJInYz61Kk8lx1g0FYd2PKi8JHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tAxvt9dn; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-28e538b5f23so104440605ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760471466; x=1761076266; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XCBRfoyK+7/WZIQpMdEvmVw8U/FORFk3NHfFvDCUVog=;
        b=tAxvt9dn4iGMnEuL3aOrOGxYPvos5OQPxXWRIBnNiYS1M8hmfDtN1desyYXoT8Wf2s
         Ro+2pOpWujH1+1LCoeBGIdpWMY4TUcuD8xm2OJottX1lr9m1flnlEiaWeN2Ev+HUCXX7
         WAOe03chf3hhrzmCcW+HGnBIM9WCFbwj8vo2hC9tPd54MtOsNh4NyTaPokh6AReiRmCO
         Lym8lrbpveJZmw58JCxhLSkuN4Fza2UfvgojXghq4OYj4uDrHQP5hkEdFaDl265vLmQw
         7XzX5sFdf3L1joSVuYqYIlzafCIIWbcn8kRaey6CvDBW9gTW13v+4qFcz6Rocz4TRBCg
         bC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760471466; x=1761076266;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCBRfoyK+7/WZIQpMdEvmVw8U/FORFk3NHfFvDCUVog=;
        b=FAlFK2jyhpvKv9unBBvrdT2UNVfCbkZqgyJlN2lbW2gHHEJWIRNdA3IyQBLxREDQKY
         5hisOeU23PNKurQE3W9xZg9XIhVJ1VQs7nPe1cSb7yNpeSLSCdUdSZlf5sKIwjv4Lq4Y
         S7hFQx8wtKIiGB0VM/c1fYBbdrtivVOZ+eWmuiVp8swCD3q5K/Hm+1IOwgeKUORO6uaI
         0lP3ckk9Nevmaq27YEHU+lnPdiopG2fxprKJVIMYoSklSFGeNUMRWfFrOBhDUPJ6dh4v
         SaUEiaVPDUCyBOc+aizEARlh/myMLy0zlbBvMvMhcXjNyq4KmMPmGoeNZCXL5r/kLNug
         fD2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkStxfQi6Hc4VyHoMEH5+TU+6vBZGQir+/vMEixFwUPWzmk/c7jQaakxx2G4+Xt7JEXMOdSf11TdelKeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+93a6UDlOFmkINUu2O8uPq2ev3YyP53ZryESoWAm/HbU40jWT
	Z7FVk+sQAd+Fsv6eawkBTo3r5+huheGpXNUUCRAqLyOwBI9T3TkkJWaz9OGPXMDAGJFgO1nzrHU
	nqFOarQ==
X-Google-Smtp-Source: AGHT+IH5MJ06QdI+Ng4/hwqPwFjt7iIt3Z6IEewPQcpQ5AzuiKgjC+/TeLeMSHNT+3ibJPUrYLOZeL5w0cA=
X-Received: from ploc11.prod.google.com ([2002:a17:902:848b:b0:234:c104:43f1])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:384f:b0:267:9aa5:f6a6
 with SMTP id d9443c01a7336-29027240de5mr317736905ad.19.1760471466202; Tue, 14
 Oct 2025 12:51:06 -0700 (PDT)
Date: Wed, 15 Oct 2025 03:50:51 +0800
In-Reply-To: <20251015-usbcore-tracing-v2-0-5a14b5b9d4e0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015-usbcore-tracing-v2-0-5a14b5b9d4e0@google.com>
X-Developer-Key: i=khtsai@google.com; a=ed25519; pk=abA4Pw6dY2ZufSbSXW9mtp7xiv1AVPtgRhCFWJSEqLE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760471462; l=2413;
 i=khtsai@google.com; s=20250916; h=from:subject:message-id;
 bh=WSQ2iDb3hcVF5qM6lFll1BwCOEotVXw7mTOGjytvpYI=; b=QeUijzXDYah3+0A9xhvIofiGWjY2t2SKbudvyxbRJMSbEedIeNabiFl1TCbWyvanvPlWAgsgH
 LmEc48ggregB/ZcXtercwCO1c1wLuH9fLKSlBAr06/LR7rlzbT2aRvo
X-Mailer: b4 0.14.2
Message-ID: <20251015-usbcore-tracing-v2-1-5a14b5b9d4e0@google.com>
Subject: [PATCH v2 1/2] usb: core: Centralize device state update logic
From: Kuen-Han Tsai <khtsai@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Mathias Nyman <mathias.nyman@linux.intel.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kuen-Han Tsai <khtsai@google.com>
Content-Type: text/plain; charset="utf-8"

Introduce a new static function, update_usb_device_state(), to
centralize the process of changing a device's state, including the
management of active_duration during suspend/resume transitions.

This change prepares for adding tracepoints, allowing tracing logic to
be added in a single, central location within the new helper function.

Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
 drivers/usb/core/hub.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 256fe8c86828d51c33442345acdb7f3fe80a98ce..d0f5342976a9196e8c92e7bdb0a909207f69ebb5 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2147,6 +2147,20 @@ static void update_port_device_state(struct usb_device *udev)
 	}
 }
 
+static void update_usb_device_state(struct usb_device *udev,
+				    enum usb_device_state new_state)
+{
+	if (udev->state == USB_STATE_SUSPENDED &&
+	    new_state != USB_STATE_SUSPENDED)
+		udev->active_duration -= jiffies;
+	else if (new_state == USB_STATE_SUSPENDED &&
+		 udev->state != USB_STATE_SUSPENDED)
+		udev->active_duration += jiffies;
+
+	udev->state = new_state;
+	update_port_device_state(udev);
+}
+
 static void recursively_mark_NOTATTACHED(struct usb_device *udev)
 {
 	struct usb_hub *hub = usb_hub_to_struct_hub(udev);
@@ -2156,10 +2170,7 @@ static void recursively_mark_NOTATTACHED(struct usb_device *udev)
 		if (hub->ports[i]->child)
 			recursively_mark_NOTATTACHED(hub->ports[i]->child);
 	}
-	if (udev->state == USB_STATE_SUSPENDED)
-		udev->active_duration -= jiffies;
-	udev->state = USB_STATE_NOTATTACHED;
-	update_port_device_state(udev);
+	update_usb_device_state(udev, USB_STATE_NOTATTACHED);
 }
 
 /**
@@ -2209,14 +2220,7 @@ void usb_set_device_state(struct usb_device *udev,
 			else
 				wakeup = 0;
 		}
-		if (udev->state == USB_STATE_SUSPENDED &&
-			new_state != USB_STATE_SUSPENDED)
-			udev->active_duration -= jiffies;
-		else if (new_state == USB_STATE_SUSPENDED &&
-				udev->state != USB_STATE_SUSPENDED)
-			udev->active_duration += jiffies;
-		udev->state = new_state;
-		update_port_device_state(udev);
+		update_usb_device_state(udev, new_state);
 	} else
 		recursively_mark_NOTATTACHED(udev);
 	spin_unlock_irqrestore(&device_state_lock, flags);

-- 
2.51.0.788.g6d19910ace-goog


