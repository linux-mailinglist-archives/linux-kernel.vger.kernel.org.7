Return-Path: <linux-kernel+bounces-853734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81800BDC760
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06DB3E089C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927372F7459;
	Wed, 15 Oct 2025 04:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qyr8CwjN"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EBE2F3C31
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760502530; cv=none; b=FOBmdtnEgAcltklIZi46yk/ECnD8Dtz/MubJ21TVZ5yROCuKhEFaLkrB3Y/am3VoLtAQD2X8h9MYKQ2Qa6fEbU76xL9Sd4b1jH/5FOn1EoL1svPN+Q6zbNvl/XBuJQGek/B7oZJASQQFGf50NBlOjmm1xK4QkbcwQiUoVcx4Bkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760502530; c=relaxed/simple;
	bh=7wfAMnESvRVrcUxGm70UpqypFTY1iKeOAV6XurtA0Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OWiBPjATGUm/6cRU/uYnkMZM990d1rQy7EbmhHtQ9OwK1hr8dQpG1KeLUUUtgbi59opWN9OvmXDQD50kmA4E13AGgfdoY0bLZKjz8UdI0mSGpx0a4PdYcWX/f96Rrn4itWTEoeL7M8DGUrZqd/R0hWAKIE/IJ5SgQu50OCVhR8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qyr8CwjN; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-330a4d4359bso4986763a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760502528; x=1761107328; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlH0cGjIB/p6Xp9aiuKUvkG4AK7l2RitPxC5XPops8s=;
        b=Qyr8CwjN3MWAP2TbGkPi/kxVritlsj2ORvjmauQFX2nWZrncOY2n+PWiSTaHaWWTUU
         98SLlvMwLMWe4Yvh0gQ8RHyYSKIiiPtwz4MdSZJohRSBEVFkAsOOyhIyR+R6enXTFxJk
         vCg5cZdwJpIjLeS/BDn+VfiXs613a5qqaLckCfajcrQN7s54t6tEWM1ZIHj1gocIbjy5
         4fitLYBKIP8fY+YgBr7B3jiShHe9xuColP+9+wN64eXWacS+HXV4BogEsbf+5gimtsVV
         7vuzKeK5c2HvEGeGfpDztTpkFPrGPRTecP6t1uDt3pDw80zohq4RScPVd/VWzQBnD7xi
         2wHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760502528; x=1761107328;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlH0cGjIB/p6Xp9aiuKUvkG4AK7l2RitPxC5XPops8s=;
        b=ZkePEpGVLuJ4cKWsupgt9A4YAfaFw/+XZ1tUpt+Y9elMmSLR5My3cFsrpu0u3ku964
         P/PcWFQETZJcH8sXnGjYEKxZVCrLzY0urowsD9dYruRH2yxmMO+IKAdfebWh+6TvLWNu
         4f/m7F6GQIu6kvO1ZvZG7Z8Dar1fq/UQPnYuLWTb/CV49mG+zTHBV0leYG9zx+MdH+uC
         NVyDdj4/6TvmPiWoby1PYbFFZlcajoAC6XEggHOy8XRZIiHfOVI64rmGRPUQDecSTHzs
         i57tBkTc5yDpYHiE8b+Ce7YJ0h/LFiaMhcBbrnx61L1PUa8ceWayDh/CIg/9JOrYQApM
         o58g==
X-Forwarded-Encrypted: i=1; AJvYcCVZmBu09ZCMN7W2TRQEWPpPurJOysJ37mBFACKgaBgR4IHSFLQmPyqoMoEVQfCu1GggbAasOfpKY9y53x0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0fslF2X2q23ixmGds6Lps2qJc4Cbl6zozPXmG1tu4vVrvXF9i
	WdaJb45QP7YZk6u139C3B4hVMkKI5U4MvEMmoG/unKZSnr6gXzTge3e/
X-Gm-Gg: ASbGncvkQQ5kYvYkLutRupW86SygxwxHQVRsX/96O5S0oPyaAv1BhFvQ3LDCzpRXV0e
	ZH6yQlZn8Ny8ep3JszrSe61EHVOFqu0IImQaVjCvml7nhnsXDHe1WMlduvYjhJLtGX29c0CAHuP
	tSfHoLTp5koGvFuqi2hgedGqoqBjWtesmcnUpB3CJZHKQPSxCAdmlLQ15Fzn3QJb7iR3/GbMU1M
	5eWS0XxRIkYHzFuSywCMil8HArm2LZAp7u99IkGFCvoxogjup73AFrUZ0W5i2IohNSRmk5n9oGQ
	Nhna4TI9th/5zUEWOMsTurD2pD2mGQQaej6Jw0VL7WL9gVGm93Mb9Cm9gNW1uE1zfAcNQcUmm2p
	8vz60NDazj7VHORok+lyMwCdR0J1kkxQMa7z/ykV8Na2rIKts4RWdAYFWEbVemJf/GutNau83dA
	Y7ueWJwg==
X-Google-Smtp-Source: AGHT+IE+Deb2FV+DtdpOThkIj5o2+mjtlGjIWhQkTWNRouhVEAGo+cWfvB8mD05/8Zm7cLUB7Rvd4Q==
X-Received: by 2002:a17:90b:4ac9:b0:32b:9774:d340 with SMTP id 98e67ed59e1d1-33b513ea07emr39765138a91.33.1760502527651;
        Tue, 14 Oct 2025 21:28:47 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:729e:7380:f286:50df])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9786f659sm680988a91.13.2025.10.14.21.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:28:47 -0700 (PDT)
Date: Tue, 14 Oct 2025 21:28:44 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>
Cc: =?utf-8?B?5Y2i5Zu95a6P?= <luguohong@xiaomi.com>, kenalba@google.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: hid-input: only ignore 0 battery events for
 digitizers
Message-ID: <c5b52grvciabpcgavhjqximqqq6fczowgvmckke6aflq72mzyv@gzzkyt25xygc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Commit 581c4484769e ("HID: input: map digitizer battery usage") added
handling of battery events for digitizers (typically for batteries
presented in stylii). Digitizers typically report correct battery levels
only when stylus is actively touching the surface, and in other cases
they may report battery level of 0. To avoid confusing consumers of the
battery information the code was added to filer out reports with 0
battery levels.

However there exist other kinds of devices that may legitimately report
0 battery levels. Fix this by filtering out 0-level reports only for
digitizer usages, and continue reporting them for other kinds of devices
(Smart Batteries, etc).

Reported-by: 卢国宏 <luguohong@xiaomi.com>
Fixes: 581c4484769e ("HID: input: map digitizer battery usage")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2: rebased on top of linux-next, dropped Tested-by: tag

 drivers/hid/hid-input.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 5d7532d79d21..e56e7de53279 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -635,7 +635,10 @@ static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
 		return;
 	}
 
-	if (value == 0 || value < dev->battery_min || value > dev->battery_max)
+	if ((usage & HID_USAGE_PAGE) == HID_UP_DIGITIZER && value == 0)
+		return;
+
+	if (value < dev->battery_min || value > dev->battery_max)
 		return;
 
 	capacity = hidinput_scale_battery_capacity(dev, value);
-- 
2.51.0.858.gf9c4a03a3a-goog


-- 
Dmitry

