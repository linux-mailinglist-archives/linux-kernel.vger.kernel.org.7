Return-Path: <linux-kernel+bounces-758846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3E4B1D48F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D59718A0A2A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E783525F78F;
	Thu,  7 Aug 2025 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GsnRebEp"
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3C381741
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754557645; cv=none; b=cavFNrmjr8N+J9uOoev+je9xldl10QKcsy8k6h9UE7eTR2Px/QYK0rqgAF8SFMj67c6teCu1MNKnApJ9okUB4IPu586E59feGgY9OWno/gddSd77zJSR5yUlI1MrjV8ZNTelQyXYTpINFdiCGvnn/nzZHHEBijhcevhi7T31KmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754557645; c=relaxed/simple;
	bh=gWOqssh/B0zhOWj/hgJV7uLzIgiEe8s9kBaCELWoyKk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XnF42fCBeIrNjo+4WDvreaWy7FL+noySeb8f5UDm7pMunP6ye7XFXQ5cV8YvAjqscRKS7M3Lswb0ksUv+hDBYQbxt6TTk103QdHME0DU/he8kW17Iah75XLRSRSgE7f6mqCNlZOlYjasmbWcyP0Sjdjw+lzmSedy3TTj9M8/Iss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GsnRebEp; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-332355d808bso3174491fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 02:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754557642; x=1755162442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7857YzQoqmpmB028bo2TGbiPP5wF9E/++uq/WGiIKkw=;
        b=GsnRebEp/k2t6992PQYbJpruGBzpSyKFcgJflyamRqM1fC/OlpeqXWLLhVZUGpI0A0
         K0RmumCw3iizF1fcEs0PupHBGPnP2de1anG1nn3E7IyaEXaoSGh1f8XpsX8oVyI+JrEH
         saXlfLtUHdnn6uZkP7rmGs7TsHizBMjBDs0ovBzadQxmXApVCH3H441q7Ire2bKT7YnZ
         SM8uv7hwDYw+BsCdArLZMRuCGbW5t8FLDWtopPBI+xxEiTe1RyqHj2f7/1gaN/rz/Ca7
         HgHrcgqYBW4rU/655FXbIjZxY/scfP662MoNV/vbXmP5VLNajmr5lybwUCLf0u3L9NTS
         vSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754557642; x=1755162442;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7857YzQoqmpmB028bo2TGbiPP5wF9E/++uq/WGiIKkw=;
        b=IH+8ProuhpOPd4zVptYbMZpzLjH6ak20iSFYnJt0oCO5kcDZjdBc1b7qZxflDN+mv1
         R5utgHMcvmedahC0U26bXRteniGuyYssUJ4ayqNLUwcKabGNGtThVLqTWApMRKgt9Hjt
         J0YJb+Cf5M7uRYKRvGSBZM5BzVnpz7sHNHaRAce7hkxlgPNdPIIhm6n+bn4p7CTJNVli
         dt1Oxj4563rCudyS1bplSFox5W64EIlQIJxz3jmNBXlCF1eQznLBKW0jRwfhZw6nyYFK
         h5MrrETinUI6bKIy92OdJ6uq4OlCcM4PAAWOYlo0RaH/bcK9tJNx2aMra6vuzUAxe3dI
         sm7A==
X-Forwarded-Encrypted: i=1; AJvYcCWSHGdvHT/E4jeol2v1V6nx3sUa9MzxvxUkZWseBETjxe7nys6oFPUcqW6IhYkBME1CsnOVfbesbWwwFDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOfUZdiJsRRic05T9ksixg9X3NmG8UD/0HtGW/KFrJsLAByIj2
	Q/BWyDudmaBHxSAD8u+uvpeD2+sIX9YI5tce5tX/xdUSPNAb7pxRRNxEghV5iycCmOdUPxxkifU
	a9UKj+A==
X-Google-Smtp-Source: AGHT+IGcYso9lswwa8L91nhsQT2KN51k8C00/kO55/cOHbQzKDJFXuLSSBDlGqgO/JEw4iEG5HMAZyjVZdk=
X-Received: from ljcq7-n2.prod.google.com ([2002:a05:651c:1107:20b0:332:7383:a5fd])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a2e:a00f:0:b0:32b:7811:d48d
 with SMTP id 38308e7fff4ca-33381231618mr11845571fa.4.1754557641541; Thu, 07
 Aug 2025 02:07:21 -0700 (PDT)
Date: Thu,  7 Aug 2025 17:06:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250807090700.2397190-1-khtsai@google.com>
Subject: [PATCH v2] usb: dwc3: Ignore late xferNotReady event to prevent halt timeout
From: Kuen-Han Tsai <khtsai@google.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kuen-Han Tsai <khtsai@google.com>, stable <stable@kernel.org>
Content-Type: text/plain; charset="UTF-8"

During a device-initiated disconnect, the End Transfer command resets
the event filter, allowing a new xferNotReady event to be generated
before the controller is fully halted. Processing this late event
incorrectly triggers a Start Transfer, which prevents the controller
from halting and results in a DSTS.DEVCTLHLT bit polling timeout.

Ignore the late xferNotReady event if the controller is already in a
disconnected state.

Fixes: 72246da40f37 ("usb: Introduce DesignWare USB3 DRD Driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
Tracing:

# Stop active transfers by sending End Transfer commands
dwc3_gadget_ep_cmd: ep1out: cmd 'End Transfer' [20d08] params 00000000 00000000 00000000 --> status: Successful
dwc3_gadget_ep_cmd: ep1in: cmd 'End Transfer' [40d08] params 00000000 00000000 00000000 --> status: Successful
 ...
# Recieve an xferNotReady event on an ISOC IN endpoint
dwc3_event: event (35d010c6): ep1in: Transfer Not Ready [000035d0] (Not Active)
dwc3_gadget_ep_cmd: ep1in: cmd 'Start Transfer' [35d60406] params 00000000 ffffb620 00000000 --> status: Successful
dwc3_gadget_ep_cmd: ep2in: cmd 'End Transfer' [30d08] params 00000000 00000000 00000000 --> status: Timed Out
 ...
# Start polling DSTS.DEVCTRLHLT
dwc3_gadget_run_stop: start polling DWC3_DSTS_DEVCTRLHLT
 ...
# HALT timeout and print out the endpoint status for debugging
dwc3_gadget_run_stop: finish polling DWC3_DSTS_DEVCTRLHLT, is_on=0, reg=0
dwc3_gadget_ep_status: ep1out: mps 1024/2765 streams 16 burst 5 ring 64/56 flags E:swbp:>
dwc3_gadget_ep_status: ep1in: mps 1024/1024 streams 16 burst 2 ring 21/64 flags E:swBp:<
dwc3_gadget_ep_status: ep2out: mps 1024/2765 streams 16 burst 5 ring 56/48 flags e:swbp:>

---
v1 -> v2: Updated the commit ID for the Fixes tag and added the missing !.

 drivers/usb/dwc3/gadget.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 25db36c63951..68fa2813e5f4 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3777,6 +3777,15 @@ static void dwc3_gadget_endpoint_transfer_complete(struct dwc3_ep *dep,
 static void dwc3_gadget_endpoint_transfer_not_ready(struct dwc3_ep *dep,
 		const struct dwc3_event_depevt *event)
 {
+	/*
+	 * During a device-initiated disconnect, a late xferNotReady event can
+	 * be generated after the End Transfer command resets the event filter,
+	 * but before the controller is halted. Ignore it to prevent a new
+	 * transfer from starting.
+	 */
+	if (!dep->dwc->connected)
+		return;
+
 	dwc3_gadget_endpoint_frame_from_event(dep, event);

 	/*
--
2.50.1.565.gc32cd1483b-goog


