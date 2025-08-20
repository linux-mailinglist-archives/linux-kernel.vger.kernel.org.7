Return-Path: <linux-kernel+bounces-777885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA452B2DEBA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 984D44E4052
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2A627280B;
	Wed, 20 Aug 2025 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCbEuau3"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90F5263F30;
	Wed, 20 Aug 2025 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698944; cv=none; b=TeXo19/6Nf9BsHgZjzTG0gMT4CQa8VBU1DjlY4eVnk5Yv4eevQ/4H74VdC6wu873JhvZpp+1iIUZoCIeQPqNoOYShheGpnbuyUi6wxW6H58hMezpCJI8RJcwfCXc8LxlEbg/W4tp2JRUepqMNDB8+H7FlRJZwXJMeGQJ8rOSf1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698944; c=relaxed/simple;
	bh=fVT3hvTcuyKwrwDs25V+5wgDjlHlTQg89khRdY1OiJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPMG5K3IbBRXA4DddecXFc3Ve12BY9Zs/BH98/MeOjZGk2mVKNYYv+6auqwdYYoSs5XZnxFigA8XR3cVdCpa+X+iBuNKJjcfBmEuvk0raVb11z8PsknGAYN1ld1aADW1kAUeZJjBStr2g5QZy54GmQs1whmMP8sGh92OhujzMso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCbEuau3; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-333f8d1ecffso50755341fa.0;
        Wed, 20 Aug 2025 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755698941; x=1756303741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3C1wPK3Uq/tkWRWxQsaA1tp31CDtvCsNsNMjY0U9BDY=;
        b=cCbEuau3sxElDi+fsvI2hwEZjo6OtxKrgzruHJfcUfrTPVIcFnXgdA+ETJ+FZFJ4Nf
         4HOIcwbLPp2Yx6dmxhE6u341s7tTn3fQnGfr1wudJdWUK6XizfHRkSvwYp68/WYOfgWH
         swS4hhDS0WPeaEOPpSZfBn3h6aYgBniQYh3Pno0qBXgIV/IqLC2Lbnoc8VDWIByHy4uy
         OYMqGSPYPlp4+HyH/Od/qfey9o87TQtAfvuC22iKbhsSm6OmrPUiA9UlvTcCNqBJchaq
         Pmu7WJ3ImabeYnMNtOd7jj9iXjYxKUNXT2QG2UrIFlEReKIIs6IxmYpsPusRgNrZz06l
         aTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755698941; x=1756303741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3C1wPK3Uq/tkWRWxQsaA1tp31CDtvCsNsNMjY0U9BDY=;
        b=suwZmU0VA2V0UrgjvN0ode2xKwecuPrl61V9wMABUdWx4pMDiVQMre4LCM3ozHGyLF
         XlHd5qe8lnrLEzNk0NMs+rRcivkzby6TjPiTdPqDa4vXKgi6qR8YeRfgxFydPSXqvp7v
         K/CNV+3NZUpUNWfIpCY8Q8RLd6LCqGUiI6z8J3wR8ty9/4VwcCiUWLlzgO0TQpVptiaB
         IYUbXLbGADjHtFKGRy3eqI5g3ic7c22kkOquBywZSTc6xF4jIdSywzyqT9LG68FpSC4m
         ZEMsgn197f1jUOzAa1JIqN09MtbNFiBC2gXsEvNR5LwfdwAo7FBcXBVg2auKjT0ifz1q
         Qhdw==
X-Forwarded-Encrypted: i=1; AJvYcCVoSar7Su73UB3g5Iq+mSiR5ZAHfRFomCJt/yqm2kvVdXuESIIXv3QbwW29b8uw9H6/igbEyQzRNG3q3Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYIOeV+WMRMFOaU8HIjkIMHUNbcF0JXoHRuJcPZJY6J+Wn/sZw
	8sCsp9kNunwUmJRgtNODU2SUcZadLY1vdoJxjKZUSaqgVPt+eekmnK36D207OA==
X-Gm-Gg: ASbGncssDwqfXi9guNb5p6TYQhU+hAmxuC5XtapQSfbqvXMorJG3weW363x94Od0B3M
	unyFkvKAedJOXRYjrRJVArZNEGQNZRnyEzhL8z6GI94VjemnZHjxwVUlRQZt054XzEstRqwZp6g
	mSVLG1RFXZU7kj5sGDMhnI5eqr/k+g7jluq2zQBqOFzxJJ24N5sjrlobK14TX5Jv425PIOC5VRn
	TWtzFbaiFCUA9k6sMcNws7LHnm3DMWJLJQMm/FoBUCvAzyC/OGicULZ5vrtSympiu2Uw1EENpi9
	Za3QRd7eLUUlvWN9s7NP6RLEva9gx9kojdvdBTXhT3KAA73qchl/IQcs9psSW3n4PZsRB+pNUXV
	GyNMpUk2LyuooLEQBl6u5zJLPKHMzmrcyxAo=
X-Google-Smtp-Source: AGHT+IHXF5TPRFibj+zC+2Ytx99wQ1/wnsCLHNlowgbo6omQJb1wT/R8DZm5sJobvDZgOTAVlwWLIw==
X-Received: by 2002:a05:651c:1544:b0:332:54fc:ef77 with SMTP id 38308e7fff4ca-3353bd91bd0mr9592881fa.32.1755698940274;
        Wed, 20 Aug 2025 07:09:00 -0700 (PDT)
Received: from foxbook (bfd208.neoplus.adsl.tpnet.pl. [83.28.41.208])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a632e1csm27200141fa.63.2025.08.20.07.08.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 20 Aug 2025 07:08:59 -0700 (PDT)
Date: Wed, 20 Aug 2025 16:08:55 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] usb: xhci: Update a comment about Stop Endpoint retries
Message-ID: <20250820160855.06ad74aa@foxbook>
In-Reply-To: <20250820160746.74276b40@foxbook>
References: <20250820160746.74276b40@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Retries are no longer gated by a quirk, so remove that part.
Add a brief explanation of the timeout.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 3fef6454f3be..9389645a1dd5 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1262,8 +1262,9 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 			 * Stopped state, but it will soon change to Running.
 			 *
 			 * Assume this bug on unexpected Stop Endpoint failures.
-			 * Keep retrying until the EP starts and stops again, on
-			 * chips where this is known to help. Wait for 100ms.
+			 * Keep retrying until the EP starts and stops again or
+			 * up to a timeout (a defective HC may never start, or a
+			 * driver bug may cause stopping an already stopped EP).
 			 */
 			if (time_is_before_jiffies(ep->stop_time + msecs_to_jiffies(100)))
 				break;
-- 
2.48.1


