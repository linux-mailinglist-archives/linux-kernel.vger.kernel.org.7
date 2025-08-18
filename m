Return-Path: <linux-kernel+bounces-773162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A86B29C27
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C13C3B31AE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C377E3009F0;
	Mon, 18 Aug 2025 08:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2x0TEBro"
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C05822F01
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505651; cv=none; b=dl9ISp5PtL5Y7YPhuMjRBVh7DYIxLu+wgExoHlBewwakWRFzsg43OHlblU2iLqKSsoE/Nr5dVwAxzU1kEwHLe8VrU37/+iybE9Rh4bDUaHXfJztOP4Iop4eZ+LALWt/HRMstSdDyRmhOZu/U2GdE84CNDkc+eINd2n6ZBWzYZ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505651; c=relaxed/simple;
	bh=Q2rUv28LZiksZj3z/7RVMGWGxPcbEI8ZlUPHEnN95NA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FCAZc9ZyjJkq8+uqBVB0BdD39yHIPBMromkGsJVQdE2nHB47NGqN0e7jnB9gJ338Wu392GkG67Mn+dFH/+FRD5oDVK1yp40Cr4D2dGWq+IDDDxRlBfveHYQ7cGNV5E6Mr3ni2P/JszxYz2sTS50hqyaWs/T3HdZP/z66u0Vp1Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2x0TEBro; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-333f8f1d00aso15493141fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 01:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755505648; x=1756110448; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=woHVZ9xaLvn0f5ipMTuZWdrUXSwzm8lint/HyOAjQ/U=;
        b=2x0TEBroBrkyTZB6so7ZBaHEiA4KIVe57aqAvA2XJocsHOiMLenMwpTL/pz3RifiyB
         JGUqQI98qzXGo4fZoyAiSu4NOYBByjbea4n+FQ6nvVmD5BOFeDdC7Atl5Bx/AgiAavOm
         tsjbcaBLBm3pxbjr9/Z8MioijY6/8UjpPl3hLYAhYHJ0gokYWoNA/v/EnJEI1o3Di4Hh
         CMqdQn54CQwzNt1djpTbPBK6sTKjq3viDsIuJd1+C4owi2vaxJWTOZqhuGx43PlCrAQ+
         6TRnN+pIynRNO+v6ZdJBLqzZIbwg5f1aFNmHlnDkLzAb/tX3BVoeoi9MPoEHHVj9F4GL
         wS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755505648; x=1756110448;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=woHVZ9xaLvn0f5ipMTuZWdrUXSwzm8lint/HyOAjQ/U=;
        b=u7sd/oZZaLu6JV0XbUDU0QfnlN5yYMLpLJJff/vb5HEX0jArR6S5BNdYGECoq4IdQR
         bt7ZVvzKYhWR/D+Sesc05KEYmOXgmuCTuESX9EeMJ6zl6QATnEEkmay8ta3gbvImruae
         Q8jWIFcrb+yCs7UR6EZmDSvhkuhG5AENzIEsWl7jZRpi+H1K9EK16tjj9+0a2DTIB4L4
         5zeYP8w03NM4aCAxablTk50CuOuMNtpgw8ZulPGgtiGi9Lk7pn5SH9AOsLZr81FA8O8H
         JBqK+krw+kiyGxyKsUA2zgG+oclQdoj+8aEDJ5UrpjQxb3qhVezh9hgj1rrVslnhDFGh
         C2KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjHZxeuuh0BY8JtRsBNKV4SRFzAsNhhOr+1xyvgujVGQpMuVdwp92tOzWljzLKw4Qpp1MSEB9MinKLJ3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLP/l2wB4RSpj/AmM//pnIgIqtCF+4PBMkdZJlLIK/0RuBsqyD
	6rjXFYc7fS+UypeW8v0UdpBgL5QnJJmATR54c+29P26Ayuw4BeAUv1GytiWmTbVnml4c7vqUPBL
	omODTuQ==
X-Google-Smtp-Source: AGHT+IGrqcNd0p4GZP+SI/t90GUT0YAuHX6l0SKKrbFiWaZXPaDZJSorGQPaPiCRKA/+pAm6tSd5JldymVo=
X-Received: from ljdt15.prod.google.com ([2002:a05:651c:31cf:b0:334:474:b29c])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a2e:be28:0:b0:334:14f:e9c0
 with SMTP id 38308e7fff4ca-33409953eb8mr30417611fa.32.1755505647563; Mon, 18
 Aug 2025 01:27:27 -0700 (PDT)
Date: Mon, 18 Aug 2025 16:27:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250818082722.2952867-1-khtsai@google.com>
Subject: [PATCH] usb: udc: Add trace event for usb_gadget_set_state
From: Kuen-Han Tsai <khtsai@google.com>
To: gregkh@linuxfoundation.org, royluo@google.com, jkeeping@inmusicbrands.com, 
	stern@rowland.harvard.edu
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kuen-Han Tsai <khtsai@google.com>
Content-Type: text/plain; charset="UTF-8"

While the userspace program can be notified of gadget state changes,
timing issue can lead to missed transitions when reading the state
value.

Introduce a trace event for usb_gadget_set_state to reliably track state
transitions.

Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
 drivers/usb/gadget/udc/core.c  | 1 +
 drivers/usb/gadget/udc/trace.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index d709e24c1fd4..e28fea614496 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1125,6 +1125,7 @@ void usb_gadget_set_state(struct usb_gadget *gadget,
 {
 	gadget->state = state;
 	schedule_work(&gadget->work);
+	trace_usb_gadget_set_state(gadget, 0);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_set_state);
 
diff --git a/drivers/usb/gadget/udc/trace.h b/drivers/usb/gadget/udc/trace.h
index 4e334298b0e8..fa3e6ddf0a12 100644
--- a/drivers/usb/gadget/udc/trace.h
+++ b/drivers/usb/gadget/udc/trace.h
@@ -81,6 +81,11 @@ DECLARE_EVENT_CLASS(udc_log_gadget,
 		__entry->ret)
 );
 
+DEFINE_EVENT(udc_log_gadget, usb_gadget_set_state,
+	TP_PROTO(struct usb_gadget *g, int ret),
+	TP_ARGS(g, ret)
+);
+
 DEFINE_EVENT(udc_log_gadget, usb_gadget_frame_number,
 	TP_PROTO(struct usb_gadget *g, int ret),
 	TP_ARGS(g, ret)
-- 
2.51.0.rc1.163.g2494970778-goog


