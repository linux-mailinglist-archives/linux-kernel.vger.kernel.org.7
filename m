Return-Path: <linux-kernel+bounces-774437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55753B2B231
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814E617FBBE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739FB275860;
	Mon, 18 Aug 2025 20:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MJwKW3nC"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37D422370A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755548144; cv=none; b=nQZzULMljUiTWVwGSCq82snjRA/ndNfGa1NleysTn+1iZ8fYPAJ8Olp2nRm7d/yEkidjuHCwLHPCSkQ3HOggYmK7XHSGzkV8PeKvduUkPlIzMw441sJ3k285/7boVhbj6Nvr6ETEe42+FJWcqAn0GodlJCLSs0BCVApklps1lpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755548144; c=relaxed/simple;
	bh=2p2FtkZ4Lnr9IlWB9wAFHpMJBW9ofPI2RfNGv3X02BE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XMtKJ9NGSHNr9vjaCeWYAH+pIbRoOEpITBikH6rh/Q5soLxgX1usEHzJWEMT9wjgLAIFWjtXgDjlsIprsYBF2mDwil0VdkViwib+vOxRep3M35Lc9YsH85pFBiUb4osbDHfp1qbKRbvdrtcu3AW6ty0n7XdbZ7aAVYlbDrdChTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MJwKW3nC; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55ce528a0f5so4591995e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755548141; x=1756152941; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DLzqZRdyOLv8EDpzaUnt0Q4MFdVvX6ZyIG6yl0VPoqc=;
        b=MJwKW3nC5WAQCeoA87IfFmIEnX1LOg7Un3ZpZuJ/K49fBFHJGf8S5DChYqONTSOnlY
         hDJTmPwfUpw3ACmF0ztuB+ExZ/RpWxj5bwrELwNwuar3O2awYAYPCQ0LI8lVOl3fHJf5
         5mQAQRdX1uo+hbCNP0mJa0FCeRSbxo8TaVoCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755548141; x=1756152941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLzqZRdyOLv8EDpzaUnt0Q4MFdVvX6ZyIG6yl0VPoqc=;
        b=h/YIDj355BDaLWhN+dm/cCjCr7gsxOppXRxo35twxbvSY6pes9PllHzIBSZxp4V/KD
         r7xYX6hn4XMjrUiUl6igPsX0EJSGnUGy0ZNCRF4zWs/T+ppItWUNgRK0+EXNHIE+BYNY
         mR9tH2kAFlyUefFFcEpfXOiWMpINvAWjURj2ggSSjSxHloiM8L0VI7YQA13gQf87CFlN
         N1J+PDecUCv5BIfxuDdJm2T56a2Q8tRHj+dSeHNvL4g6Q5GUGqNEcwtj7Ndx0uTRzm+w
         DAF9BYN1UKmc33bCjLRMVpx7MJsdlVFF5xsCoRXKDN4IxJsQcCMmlHpV5uk7+MB0cgb2
         MigA==
X-Forwarded-Encrypted: i=1; AJvYcCULajzMImNs7c8A/0BHaajr8VL0rLxgNpNHLXXSIYmLkR1yylzlVOssbFh/+N51tE7GxCbLzr6RMTzKo/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwES7+8GXq7ENU5Enu7l+MTbgvUFVpQrjjW3sq3z8ATLnNddDU1
	cQhUVIHatIOpoV9QBePRsoqxQ/EgVqEAREozvtsEzzz4Rux8+E7InP+mjpitxJXTbQ==
X-Gm-Gg: ASbGnctrIfQk9/q4u/+fBgjzO+Ip9HaI4cWTxp3HuHsoIo+Y3VpWeXFHEhkbyQ1jjxM
	NF9eZOniCSN36clsDqvPlhTyqyA7EUBjXoxciwKCWipgwTHqJLI0HiWa2Iwq06oq6g/5QiNreKK
	rgPWQcqjieSLO+if61gvhuCP8+gNHjg/JnT6uturw/Nl9bWHpv7ceS1MOJ5DpTqPm02M/woWSdy
	RuS2B/DKzgLnM5WF9qIIbpvKOdl1jMjh35+ZiRlVbNfr2OIHf3OCxcOfnJSRrFmYmd0Gih2q6Bd
	pkLatHaNe7mhPW7lq0CIhO5e1cx+WawEDZOHu79cn88b4oQNAKwWXMh4gaDcb34i6Bd+WYowl6P
	DSgk9SpBOV4fpgRHoFZD5AhZWfv80yj1UxEkDVluaPFkZbHZ5rBpevpacVyvM6zyJ/LZOOpzGnw
	w=
X-Google-Smtp-Source: AGHT+IHomcZrlLRv3tAqMDJkW/VO0hvBuw4jaQNof58elMwk6nl++cYJMU4IoI47742CxSR4XiYzsg==
X-Received: by 2002:a05:6512:2348:b0:55c:e752:e9c5 with SMTP id 2adb3069b0e04-55e007512d8mr55584e87.7.1755548141083;
        Mon, 18 Aug 2025 13:15:41 -0700 (PDT)
Received: from ribalda.c.googlers.com (237.65.88.34.bc.googleusercontent.com. [34.88.65.237])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3f3476sm1789268e87.107.2025.08.18.13.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 13:15:40 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 18 Aug 2025 20:15:38 +0000
Subject: [PATCH 3/4] media: uvcvideo: Run uvc_ctrl_init_ctrl for all
 controls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-uvc-iq-switch-v1-3-f7ea5e740ddd@chromium.org>
References: <20250818-uvc-iq-switch-v1-0-f7ea5e740ddd@chromium.org>
In-Reply-To: <20250818-uvc-iq-switch-v1-0-f7ea5e740ddd@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

The function uvc_ctrl_init_ctrl() is called for every control for every
entity, but it exits early if the entity is a extension unit. The comment
claims that this is done to avoid querying XU controls during probe.

We only query a control if its entity GUIDs and index matches the
uvc_ctrls list. There are only controls for the following GUIDs:
UVC_GUID_UVC_PROCESSING, UVC_GUID_UVC_CAMERA and
UVC_GUID_EXT_GPIO_CONTROLLER.

In other words, XU controls will not be queried even without this
condition.

In future patches we want to add ChromeOS XU controls that need to the
initialized. We will make sure that all cameras with ChromeOS XU can
be queried at probe time.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index efe609d7087752cb2ef516eef0fce12acd13e747..ff975f96e1325532e2299047c07de5d1b9cf09db 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -3181,15 +3181,6 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
 {
 	unsigned int i;
 
-	/*
-	 * XU controls initialization requires querying the device for control
-	 * information. As some buggy UVC devices will crash when queried
-	 * repeatedly in a tight loop, delay XU controls initialization until
-	 * first use.
-	 */
-	if (UVC_ENTITY_TYPE(ctrl->entity) == UVC_VC_EXTENSION_UNIT)
-		return;
-
 	for (i = 0; i < ARRAY_SIZE(uvc_ctrls); ++i) {
 		const struct uvc_control_info *info = &uvc_ctrls[i];
 

-- 
2.51.0.rc1.167.g924127e9c0-goog


