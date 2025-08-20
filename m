Return-Path: <linux-kernel+bounces-777879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A05EBB2DEC7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5B0171548
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BB3263F28;
	Wed, 20 Aug 2025 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jaa0EyC4"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F86262FE7;
	Wed, 20 Aug 2025 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698875; cv=none; b=L+5B26WKIaozLFpQrpj6nMUMtyafp54MtjeB51r5vygHCI1N1l6Qf5dwgS/IRapcEEJBmi9rsWx8FJ4MS81Y+3SVIaEugY7mFY4N6HTJOChbTm1GEpkQJVDzTAdYOjdOcKhUdSby/yVkBviUB1755BTsjMJaPldk9ZfomCVrq6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698875; c=relaxed/simple;
	bh=jHZPssfpSnHOkQxF/lA4aAePLLSqCiyC30mwcxtJ/V8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=IZMY3n0BvWxVRJCdLtV/awmsLyXvASTqpVsss3s4Mzy/pcT51guALqrlr+JKc+w5moVT1JLqJfTf02keH+gz4hx4IWyPjZJkLRHDGT7BvG/cCgdGurBDe+Bj38Uv5Pe4YrbIY+yxXSUoKT6UizPc7JTxa8+NaELLI/FBIKwQ+xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jaa0EyC4; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55ce52ab898so7680812e87.3;
        Wed, 20 Aug 2025 07:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755698872; x=1756303672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+jBaQdX4CtJ61ZDF7n57iwindu7YbGzD6BY9kNY9f38=;
        b=Jaa0EyC4+QbEvNbsROsHa7iW5+h2zZByzL+jp94fiXF9NHbDoywlcBn6RyQvUUloV0
         hot9dBiFlBmdrWJHIrvmNrQ0rAafG34oTLLmhe1Yq2+dxyq+16R36FlLnON08sRaiUsF
         bWmWwhQQ5A+ISuZV4C84JOV81USre7D2ME5yrgJwA0VgJH45yGNV0ZG/e3XPHbg5Vf0O
         bDcqVbo0FxK5/PPJ2drF5yBoD7ad5qfLEI70NzdDpJOAwVgKAd0X0xZrazPQx57LmO8o
         wTUD5lIuPm93Kr/RpX923Lf8/qORN3sjY6cbmQtnRrLkcR2DDq8zdJn/Yt4RzanLHkjk
         ysPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755698872; x=1756303672;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jBaQdX4CtJ61ZDF7n57iwindu7YbGzD6BY9kNY9f38=;
        b=eQxBMCs6ybOsg3FJM371gkXH5rBeB6IDTZ2hWDEmJaaTVGdRGAzF38uBpSJKBLJ58v
         Uisq04AN+h2NJzhcXS4hocYluwZiUkVsUYNgG3wwZ2meUcGF3JPKd3Ld/XHwYny31rb5
         5a0bs8/uXCIiXRhOeTr6fx2yuYf7DI2PlNV0Rjl/I4KaWSWivPZc3QyuIQZTlJtuxJIE
         kctuENUX4MUK4/tQTxZt3Ao7XATKts8t4BHxpc7ODET8ZZe2SxI3uoz9Zywgxxiy1lOY
         OxirY7jvAnynDNGiXZTI4NxJ+il8NOZDxLHsNOQSynzZsldhkN2RP0nGska5ojZlJkmD
         vZ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUiAH4DMAI7DZuoyTyHpMO+8jlnAX1dPa6aVr4wgowcaSMhkkVXcUEREkoQ/m5LkHD1Ya0GF8B0Y4pUBJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR8NjhRHNFo/7XJknWYGeOXouQ29xfhqCCX5qBv1Y4Rbnm9twk
	dn01MfIXl2YOb0Lj4u0B8R91IpGXKEfIpk+Izi/dbNoHUlYVqcvd/UgOB1Gk9g==
X-Gm-Gg: ASbGncvRUXdw/38Ds9au+OsgIErxAoT2+tNl8wXSX9Jwjx+3/eyJhdLvcK34oFuj+SP
	GprQQ4j/jREFLuxBvtTmz4OHY1B4ZOeSqIjcKzKGYl2Mm83vFaSxu9y8h+6LDRmxPoar7nUwcKv
	x931FQkVjShDko6/078Y1suTPLpbQy+Zzkkg8Va7ywgwpS9P+h2+cSIIeN4w1217T7o8KppB6Dp
	I0wnYODA7onVcbHT0ckJZn2/SFpo8zyepeMLAA6Dy3p/6jJhHuabcaQT5oy+Cp/FaKNsrkLZ80K
	BDUsW1k1jJS3ZFmaqYhg/EhHhS31ru2ulH8RjvCgqLJqBbkCH3KmfqQLyyITowa0Q+v0tYX909V
	ICZAtM4NuTGPo6vQrT0PBgdjRkjwHzPgi6jA=
X-Google-Smtp-Source: AGHT+IGXsYhlAJ+Cw1NAVWej17Jy3z/ZHh8MchwNrwtSO59Qr0J2jyPdt0yE/xDSSUT+tarUVOfw2w==
X-Received: by 2002:a05:6512:340b:b0:553:2f72:9ce0 with SMTP id 2adb3069b0e04-55e06bcc2aamr834216e87.52.1755698871360;
        Wed, 20 Aug 2025 07:07:51 -0700 (PDT)
Received: from foxbook (bfd208.neoplus.adsl.tpnet.pl. [83.28.41.208])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3cc9f5sm2686497e87.75.2025.08.20.07.07.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 20 Aug 2025 07:07:50 -0700 (PDT)
Date: Wed, 20 Aug 2025 16:07:46 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Revert "usb: xhci: Avoid Stop Endpoint retry loop if
 the endpoint seems Running"
Message-ID: <20250820160746.74276b40@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This reverts commit 28a76fcc4c85dd39633fb96edb643c91820133e3.

No actual HW bugs are known where Endpoint Context shows Running state
but Stop Endpoint fails repeatedly with Context State Error and leaves
the endpoint state unchanged. Stop Endpoint retries on Running EPs have
been performed since early 2021 with no such issues reported so far.

Trying to handle this hypothetical case brings a more realistic danger:
if Stop Endpoint fails on an endpoint which hasn't yet started after a
doorbell ring and enough latency occurs before this completion event is
handled, the driver may time out and begin removing cancelled TDs from
a running endpoint, even though one more retry would stop it reliably.

Such high latency is rare but not impossible, and removing TDs from a
running endpoint can cause more damage than not giving back a cancelled
URB (which wasn't happening anyway). So err on the side of caution and
revert to the old policy of always retrying if the EP appears running.

Fixes: 28a76fcc4c85d ("usb: xhci: Avoid Stop Endpoint retry loop if the endpoint seems Running")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 85b4791ccde5..3fef6454f3be 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1262,19 +1262,16 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 			 * Stopped state, but it will soon change to Running.
 			 *
 			 * Assume this bug on unexpected Stop Endpoint failures.
-			 * Keep retrying until the EP starts and stops again.
+			 * Keep retrying until the EP starts and stops again, on
+			 * chips where this is known to help. Wait for 100ms.
 			 */
+			if (time_is_before_jiffies(ep->stop_time + msecs_to_jiffies(100)))
+				break;
 			fallthrough;
 		case EP_STATE_RUNNING:
 			/* Race, HW handled stop ep cmd before ep was running */
 			xhci_dbg(xhci, "Stop ep completion ctx error, ctx_state %d\n",
 					GET_EP_CTX_STATE(ep_ctx));
-			/*
-			 * Don't retry forever if we guessed wrong or a defective HC never starts
-			 * the EP or says 'Running' but fails the command. We must give back TDs.
-			 */
-			if (time_is_before_jiffies(ep->stop_time + msecs_to_jiffies(100)))
-				break;
 
 			command = xhci_alloc_command(xhci, false, GFP_ATOMIC);
 			if (!command) {
-- 
2.48.1


