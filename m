Return-Path: <linux-kernel+bounces-849880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E94BD128B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 04:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4653BD729
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 02:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C099027FD7C;
	Mon, 13 Oct 2025 02:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yg7ZZgfH"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5557271A71
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760320905; cv=none; b=iDnuaTmhpq8DXnMjcmziHrFLMGMtJoZ/EjfT5xKFlWK0TrRSaymzlJfvfm/6bsF0u43b7zClMbDyBCO7Ee0wW3oyGxupDtMp+KgGVqrEIHLPGYoxKYah0WlRMjSEQtfX5yFwZ6+u/GdD5JYISJp6HVMYsts2lJcLh9UPPqsir24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760320905; c=relaxed/simple;
	bh=W1ZqjHMGkcPhS96Nn90N/uD9fXd06oRK0TD8pV2UjtE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y4J688ClO9O6bzk/73nwUZULVaPsEB79w2336ekH2KhabKmlxTekENfYLxAFFlVsoLnktZ1+A7x4ixnDwABInyOELxVDJz8xTTuHfyfzZyQj6s1f/D5lMvvvw+jX3DT++Vr8z1m5UIHHw4/iuM7FgpUrAIr6Ik0cHzAXGBogsu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yg7ZZgfH; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-339d5dbf58aso17618673a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760320903; x=1760925703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AZ1i8QSg+r+2r4eoIxO5kfRXFS/eP5RBlsPS/OSnjmM=;
        b=yg7ZZgfH561D5d7rM6f4vzzH5yxyugBTWTGzm6moAWLWz8m7C23eBiJ+gR2ZuXAlsr
         Ov1sV04R1oMSJF5E3H8fuToVBfr+v8kzG5ujQPssa/PiQ550FoLlwitk9NrDCYatNDiX
         w2xmF8tzhTSSoTJKAzWlviofRiYKG3jRwSkAxAFL875ZOePn4R+LZ4IK0Mi7lthpP5e3
         sbtiqdvMJZPaKHPer8+qCAxE66L97Ku8juTVM8VCoWr6cjORJY7V1z37pR7l4jwKhA33
         sKi6FmFSZGEnbxmN1OyUIYCjT21PVBwqU3HE1sy0IPKIvZVzKu5Z3TVwW8aRwcQmkFLu
         BoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760320903; x=1760925703;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZ1i8QSg+r+2r4eoIxO5kfRXFS/eP5RBlsPS/OSnjmM=;
        b=FXB4DA7MbN/HSKWV8424dHLymGUVGqFO28gKd0Q7eZuQMZohcZX2V/QbDazfcsR/qq
         mvMkwSHN90aDKyj8etiyhUDe4OeRMAArH08cgijG/VhhSQIiNM84zSrfSMeeZzYPj/oU
         4d+sf4910+QM1vloYWre+rcm+YcKitj2YIgbUk71BcO50oJz6by8L+63MMnGDPs2sUR9
         7BBHPUDLuDUHgEq2kVqIa/GnPOKH2HJBRxvCmxQzTelF3YuTiqbXU1ZMW/SlJm1KHMGW
         UMeN2ZSIQgYGvmhFArEl3dOcNjD/0IiFDntlxBaBHQJRtCBwJm+qMNQ3OEQTaQ3NnV1N
         zCmA==
X-Forwarded-Encrypted: i=1; AJvYcCViX37Pao+m0Oql70FWhY4ijv1+kaeJyKuQ9D64bpx+3nQ1qkqKuYXcdlWo5W+f84Oi25r7SCHYNW/H/4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw49+JsaVbthODCC0qKynMSBoJxrKEPWTZB1pnFKMm8ZYRxJ2bM
	uq5rhxneUi4UlZwaFyX7Ina8rsd7xB8Xw2MmoIB5Fuis+n/a2jTSm4HwgCK4AmljaOwUm7gmA2t
	gqLMaUg==
X-Google-Smtp-Source: AGHT+IGkr8UAfp8910PuFH8e/qEzAisukJhG++h2a5IVreybtqueuR45Jc5ifmR2fC/4KhF1YX6HdXl7BV8=
X-Received: from pjbsn4.prod.google.com ([2002:a17:90b:2e84:b0:330:88c4:627])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:38cc:b0:32e:73fd:81a3
 with SMTP id 98e67ed59e1d1-33b513eb0femr29690215a91.33.1760320903029; Sun, 12
 Oct 2025 19:01:43 -0700 (PDT)
Date: Mon, 13 Oct 2025 10:01:22 +0800
In-Reply-To: <20251013-usbcore-tracing-v1-0-b885a3121b09@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013-usbcore-tracing-v1-0-b885a3121b09@google.com>
X-Developer-Key: i=khtsai@google.com; a=ed25519; pk=abA4Pw6dY2ZufSbSXW9mtp7xiv1AVPtgRhCFWJSEqLE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760320897; l=2427;
 i=khtsai@google.com; s=20250916; h=from:subject:message-id;
 bh=W1ZqjHMGkcPhS96Nn90N/uD9fXd06oRK0TD8pV2UjtE=; b=YbB7vEuy7St/zF23D/kZ6foaQL+87G2fS0eKhALJBnNRa8Wn1LTjy6hJZ9kK3q0YgkIvEuY2d
 O+dRkkL4FcVAH90lo9fEVWYOOj/Fl6KvUMnum8BnZfjHFLLfFKaLeQt
X-Mailer: b4 0.14.2
Message-ID: <20251013-usbcore-tracing-v1-1-b885a3121b09@google.com>
Subject: [PATCH 1/2] usb: core: Centralize device state update logic
From: Kuen-Han Tsai <khtsai@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Mathias Nyman <mathias.nyman@linux.intel.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kuen-Han Tsai <khtsai@google.com>
Content-Type: text/plain; charset="utf-8"

Introduce a new static inline function, update_usb_device_state(), to
centralize the process of changing a device's state, including the
management of active_duration during suspend/resume transitions.

This change prepares for adding tracepoints, allowing tracing logic to
be added in a single, central location within the new helper function.

Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
 drivers/usb/core/hub.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 256fe8c86828d51c33442345acdb7f3fe80a98ce..ce3d94c960470e9be7979b1021551eab5fd03517 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2147,6 +2147,20 @@ static void update_port_device_state(struct usb_device *udev)
 	}
 }
 
+static inline void update_usb_device_state(struct usb_device *udev,
+					   enum usb_device_state new_state)
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
2.51.0.740.g6adb054d12-goog


