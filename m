Return-Path: <linux-kernel+bounces-853782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F70BDC968
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7453D3C7875
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E732302CA0;
	Wed, 15 Oct 2025 05:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF4nzEMc"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59839302CAA
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760505419; cv=none; b=daCXcjy05vYPmA6p+FbFfIB4QuucBq1EK4LEIcL+Op8UI/ognPtki8c+njLJ+WyG4XY55wgM9W/ObSyS7nuf3uXZtfCyozWloI5QQv1ViynqOyPfhbkMLLwfd2bAHDzDw8bYfUPW+heuFmFHvV6SxsHlLXOP4SKnJa6tHg6hIvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760505419; c=relaxed/simple;
	bh=+C4H+zroDethd7br3mfINtGxJHy7JmMXn0wIBxbB1Qs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ljftIae4FDibfk4jKDbgRqdv9KXWeOE7TMWSq1NG5VPzjma8q4WAB1HLlnOBvQljPy1dRUYcaHArZN00agDj/9Nw775WEzPdmqYSDaTEtMnfnvaTcn2wg2dRX6JOlFsPkFHspxWlXteBwYO+/WTRK+QAOe3CZw76tUhs4vso8QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kF4nzEMc; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-78125ed4052so7099046b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760505417; x=1761110217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJNUOJGibzoLiszJdXC8Yo14nanYYKcUy9zsuhUUDYc=;
        b=kF4nzEMcgf8hvFxIFautPip1iQI594McodQIMfWs/LrDd6rC2bG5v6rXNwovbfurQm
         Keh9KVi/O10yyd8KU3tj9bkv77UaOwF6IS+HuuU84lx/98nNTPRm8+d0BWs6VPxpSZ73
         v+HNq5A03+QSDPcTT4Xb4Gcl7P8qyd+fsV/WpWLfxlglvafSfYVha2lhaBcLBU3BNbZP
         sPL8e2s2G1JvHkp2hdfFrxEDhILbPm67znd5VSw1j6TbpzAozLitYI6ThAgZ1++ShDzM
         eA74NyBrb7UW8c9tSSPpx+kHfGNb4bepP4o1sJrhcJfqsfvQFIuIpTHc9x3KcEu3E8mc
         Si2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760505417; x=1761110217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJNUOJGibzoLiszJdXC8Yo14nanYYKcUy9zsuhUUDYc=;
        b=djAX/vlrs0ruSXyhoR6dYYK5+f74rUDyQmvw3HFn5OFrSBVxxWCCHus5KWwsNypNHl
         YOKcz4fjg7o4sf88Sh3L2WeyxHs4lR6IkZFnuqV3pL9l7X1E+CBmAnUYIL+YfxxnX1P0
         RtSHzYr4yAe8jW3LBuj4oXm3q5KiI84lCIuLUsbI4MVirQdI0wKRgg9RfEr8toGziBbs
         3z/YV5tGFeRtcPIJr9/5/V9oZ8m2NZB7EHTed+ewfrWpVA+mwLHn1hWnWdcw5ykUFani
         DC4R02tlS+O7h6fD5+YxTqkc3691kjT2tnk/tAzGx4YuWNr+qHnsf50PdfTJ3eyAV4xc
         hosQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZch1CaC0hRfW/0rCIaW8ulNyALxAOITgWFBi86pocPzb3MFAhOho8gNYQhLppQSCsr0GF1Wv7T6gVRpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcmcwLpPzcrvT1XiFcrqEETIFNWoms1ciYercgbWt18cXY4WKX
	LPJBbpLXsyu2T7wsu18rq0vyxrOLem+o0fQQ/Y3BgAwXrCFFM4c/2V97
X-Gm-Gg: ASbGncsT7wDoQHBxLLAqKA5GvhRhKioEFR6aRDTMsgmUrMaVOSoaCThMk0SzmnAULjx
	kJOYuF0sFKXelhVGlpNDzdq3i01TbpQcEbcL7F1FfBNfLTbG+3mj5n9c6PEMBFbhXxdjxDosue+
	xffQqT87W/pgO476lfD1MPbMeLvvhNCgwni+b90kWjlpi44jwNwIoSYS5zcELDU4QpzJVapBAi7
	/TTXnpCo3QwuNbDHHsvKI4WFdR2HcpP7vCsDgeCAhrk7WM65T/JFx1hI0WC4FGJN9D4cZ4hoXrR
	njHTzFIGN0FxSQsFfIFrvWSIbOXwf5YTQV0XFfCcGMwpjD4Qh8W8nO1eeThctBmvXYFonVXPR9E
	Vb8DrTW1i1BptUo2MAAQ6bVDuByX/ZGzbDN30pcs3tLXtB0QzdRET
X-Google-Smtp-Source: AGHT+IGaYSaDctN1UDXrQ/b1IBYPl2mNpwc/vOVwXDn/8RGkSFgqDvehEDR5ZrCFJsldV8ETtDC8WA==
X-Received: by 2002:a05:6300:218e:b0:32b:810c:2ba5 with SMTP id adf61e73a8af0-32da84ed640mr38525100637.59.1760505417000;
        Tue, 14 Oct 2025 22:16:57 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b060a38sm17320137b3a.5.2025.10.14.22.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 22:16:56 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: tiwai@suse.de,
	gregkh@linuxfoundation.org
Cc: broonie@kernel.org,
	cryolitia@uniontech.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	pierre-louis.bossart@linux.dev,
	quic_wcheng@quicinc.com,
	r772577952@gmail.com,
	syzkaller@googlegroups.com,
	tiwai@suse.com
Subject: [PATCH v2 1/1] ALSA: usb-audio: Fix NULL pointer deference in try_to_register_card
Date: Wed, 15 Oct 2025 13:16:45 +0800
Message-Id: <20251015051645.519470-2-r772577952@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251015051645.519470-1-r772577952@gmail.com>
References: <877bwy81wi.wl-tiwai@suse.de>
 <20251015051645.519470-1-r772577952@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In try_to_register_card(), the return value of usb_ifnum_to_if() is
passed directly to usb_interface_claimed() without a NULL check, which
will lead to a NULL pointer dereference when creating an invalid
USB audio device. Fix this by adding a check to ensure the interface
pointer is valid before passing it to usb_interface_claimed().

Fixes: 39efc9c ("ALSA: usb-audio: Fix last interface check for registration")
Closes: https://lore.kernel.org/all/CANypQFYtQxHL5ghREs-BujZG413RPJGnO5TH=xjFBKpPts33tA@mail.gmail.com/
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
---
 sound/usb/card.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 1d5a65eac933..270dad84d825 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -891,10 +891,16 @@ get_alias_quirk(struct usb_device *dev, unsigned int id)
  */
 static int try_to_register_card(struct snd_usb_audio *chip, int ifnum)
 {
+	struct usb_interface *iface;
+
 	if (check_delayed_register_option(chip) == ifnum ||
-	    chip->last_iface == ifnum ||
-	    usb_interface_claimed(usb_ifnum_to_if(chip->dev, chip->last_iface)))
+	    chip->last_iface == ifnum)
+		return snd_card_register(chip->card);
+
+	iface = usb_ifnum_to_if(chip->dev, chip->last_iface);
+	if (iface && usb_interface_claimed(iface))
 		return snd_card_register(chip->card);
+
 	return 0;
 }
 
-- 
2.34.1


