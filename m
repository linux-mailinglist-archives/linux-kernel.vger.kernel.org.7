Return-Path: <linux-kernel+bounces-812236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0644B534D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E023E1C213BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ADC335BC7;
	Thu, 11 Sep 2025 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0OeAeiu"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C709129B8F8;
	Thu, 11 Sep 2025 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599657; cv=none; b=Zy+uN1CV+mwtiFmjyhYDW3qpH1a4y4ISwdsO75pVIgQHMLs28JlwT0rIPZ+c+BwffSk7VS6EMwVeOLcaXPRxKOtImQ1sO57d2Yfyu9GwfYBEvOluHcWIGP3c3a4kMWx9rkt8XIrLX4lYRT8y5sY50VlL0lG1XD8QIffzzjkv9uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599657; c=relaxed/simple;
	bh=AeDu1CaxVTDYh4Mj66HpOGBzQ8r3uynQZo5ononj6MM=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YE+DEHx6QosoH40R+2Nplm1iDmboLH2L2L42jDkO76RgoRn2yE6jNqonBgmsPvAndhUZ/lImUIDiGUwpZlwFupGDS1NvnHoOkVkcY/8UTn626hlMfH8KedzSRwQYbAGxPWfiKELlU3zXfwGCezJvonplMd8Q92LwRrSUdyNj1c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0OeAeiu; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-56afe77bc1eso860276e87.0;
        Thu, 11 Sep 2025 07:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757599654; x=1758204454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWdoAQyPoyWoa/AF8wZgmr5DlRUGvc+N3yrK4JDeCfk=;
        b=L0OeAeiuqAJ81SoMbtf06J166v4+Ar9jv3kaxncxDS6MJNIRUgw9XZCH4hIeYszP2C
         T0m7v6sSGDIneBZF/pUVgPCoMHydWwARk/ohjqqas4f0avY8aDEOBnOIPNRZUUrdfILW
         TAmEZ3yrlpGlfaNBmqG014/g59sJrYHcxz7ZXYGhAVGsUEqfyBQ2ubRFD4XhkYSA06v+
         ZFAUrJUdIg+Y/mdKHGLRtuDt2K7PEgnxvvryNo9oNJlApHfKgrc99v0bYnkCpXJg76Zw
         MMkV6EDPktBaJjT+RJgcX2L4K1WJ+p/9dVvQoPZeBO0RVf7AhE6XLYsXww7qUgGZP90U
         fr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757599654; x=1758204454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWdoAQyPoyWoa/AF8wZgmr5DlRUGvc+N3yrK4JDeCfk=;
        b=eiArzhTbCNCGLHFQg7ZHsv53haq1G5ZRC5rU1YUQgtUCKk6/F3fFyDs1W5uvuvuMvJ
         qrc9vgzTbohsGjwJEaCgdFB0E8Q4pzq4s56zp4m/kw5Y7LPSJuOaRf1OQ6CyMTsga48n
         1Q5XkAcxvlgPP9KxU/8uD9V5r/20o3kn8CKMTRe1I9GS1ou6yJQd2d65JeZwOFpeUJQj
         IlnuBFWx31I+Rjo88YBV8+BKhsntk2v4/Yi/a820fdkKH9+UkvTfA8zmBZnnqC4iL+QY
         Dm7h0J3B3gb2gsTgSkHCAWwS5l15vepJUlSp2NSSAqc49pcVD4Oje4O4Z16ut6/4Ht1C
         NbCg==
X-Forwarded-Encrypted: i=1; AJvYcCWBN0lp45xeKJDe4yG6xRl8WUznBJ8BPfDELlFdJfKbKoiXOWTfk/bzgoz9gXYUpUVynblu91cUqrCj@vger.kernel.org, AJvYcCWEIx3X6VlPJd9kRfOTkbOAaRFgDkwj9RlMuGZzwEIMOTbIeDUU4QnRvpsXHTTOj0y0wz22Pr1g+QI1O8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUYWJ/929AUaym+mRMIZ0lQL6TL70rjoOqxJskb0rlahe+6e+W
	56E/f1OhZxyzBilh+gkmObo8CGImticTds3PWiZHP6K0Ozaw21EsHxTo2sgFVA==
X-Gm-Gg: ASbGncs6mwai+DWIh81OXj23R0c/o0Fk7lhSDgKofHoepCmhdd2E5pnMGTZqG34teDw
	7w8TwUFUjGMoTXAoe6ctLN9KlmMUwXDidOG0in2G1l6C6H7iZabyQ5RxxKh3Dajq+l21y7+bRKm
	lYcWk5Vp3xeQQikt9E8V+SuNAdP5mGFxJfM36Si+gTW+8fJf09ZP1PoMjSsPewfnXHh70QGjXZm
	j26P007USWFtvU528R8dehDYqA3y+ci9cTzIpeDuoeLjjnRjX8z+3kV9hhutBQw8wG12UMv9fWC
	HbcVUT2JYwKyNsISZ9tc0ry2uofuD4Gqi7WuYyyRCqggFblqUbBwgfWoLrpOS0uZky1FKmvLIXS
	JkWfo8MTwdd3G5KSQ5UYngS5aXh+STNwQZp0=
X-Google-Smtp-Source: AGHT+IEVVc/yX1meJqG+W1c8MfFiXyru8ek+D0e4SEFl5rxe+yJxt96wq0iK1eguGRJwQVawiISfQg==
X-Received: by 2002:a05:6512:b91:b0:55b:92f9:c625 with SMTP id 2adb3069b0e04-56260e41a41mr6522124e87.20.1757599653661;
        Thu, 11 Sep 2025 07:07:33 -0700 (PDT)
Received: from foxbook (bfg216.neoplus.adsl.tpnet.pl. [83.28.44.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5cf2f467sm447096e87.43.2025.09.11.07.07.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 Sep 2025 07:07:33 -0700 (PDT)
Date: Thu, 11 Sep 2025 16:07:30 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] usb: xhci: Don't change status on length mismatch
Message-ID: <20250911160730.1ad437e4.michal.pecio@gmail.com>
In-Reply-To: <20250911160632.46245dc4.michal.pecio@gmail.com>
References: <20250911160632.46245dc4.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

It seems unwise to hide errors simply because the driver lost track
of how much data was actually transferred.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index fe60b2ae9f1d..5233ed3e4ed6 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -890,7 +890,6 @@ static void xhci_td_cleanup(struct xhci_hcd *xhci, struct xhci_td *td,
 		xhci_warn(xhci, "URB req %u and actual %u transfer length mismatch\n",
 			  urb->transfer_buffer_length, urb->actual_length);
 		urb->actual_length = 0;
-		status = 0;
 	}
 	/* TD might be removed from td_list if we are giving back a cancelled URB */
 	if (!list_empty(&td->td_list))
-- 
2.48.1

