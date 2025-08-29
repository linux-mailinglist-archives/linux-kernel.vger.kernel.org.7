Return-Path: <linux-kernel+bounces-791764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E308B3BB9D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05CB51C87DD3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA56F31AF0C;
	Fri, 29 Aug 2025 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pvr6Do8M"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E07314B67
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756471732; cv=none; b=D1TPQA4EW9LUdJLLqL89B5tPbNAOZXk85wFUkHT15E8COm3HrbhG5Cf1Y6C1Ww52v6DmGyoFGLiGL8aL+3ijC3W1FmDw8LbWJovIJWH36SLB4zcQx+XVlpAjHdYPu6QOHXs9wpHpTMQylpDIK/CBUCaOLjhpDC7SmNWN6jc+9Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756471732; c=relaxed/simple;
	bh=BMZ/MNijEEIk/FpGTtfiEwpO4Kns+lZU+ojwgvMo0qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgDOwXyS0KP2Z3E7SFrOSrT91+jGs5mzOaOGYliybjC4TVknX85SvhlP5euMmctfWS0LH+4g7YZAIwYKoRq+HFkE0eDGlBbz/jKU3el4YXCGcAZpjYIdgG4LvbVWlNj30b6F3y8UI3pUEYuIZmjhvgylviaPmsi0ZvnGRgJXYUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pvr6Do8M; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3cf48bde952so759502f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 05:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756471729; x=1757076529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ck+n5rGbWRlsQRXehQxg/mLWI6V1ptp52cr6SEHZ1hA=;
        b=Pvr6Do8MxThFjz3Msj3YrYmGCKwv87cKqrIAfKw2jyaHQGnZ4NwgOQ/fv64hdyt3Li
         1ktd6kMZKi3Ie7FAXpWMHk8nke79VkK/t3zgHVR10k2QMhBgIhjjde5F6PDmNpzE6rta
         7NSyrLZewkJQIlNYvW807Y1/WNbcvHCAkdCQCMhCFVlni/GLHKT8YX4GtXUFEFdtTYIK
         q1kEortTHe6wgsDahDgM13uDT6I+KORAYrPg4x0jLgegJz7R9D6/cIygR/vAbD8mkiqI
         dB83wonzOhA/gvhWcz7GCCivDJU9z755wWOQ+1wBv0HMglcZHHHMIRrSoVancdbsZshB
         GiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756471729; x=1757076529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ck+n5rGbWRlsQRXehQxg/mLWI6V1ptp52cr6SEHZ1hA=;
        b=ZoMF/TltrfN3hCNNJIOPAuzLKmkYNqFXVjitFb5wQWk7MWdazA3mJyowPoPmQ1l+fB
         WjMvMHBqCJlgifF4qSXdV3tJLhavaa64Eeb+b4AkNU/8pNIdx0p5QoEYwFDk5FqJr4l8
         AlmZWuQKxaay0LW6I9rqY6RLv92MO0neTf5sn6bbkJe4O2N1TgK+10mtuAyTN0dUva/Q
         gFIx6wBlaT85kdutEndcNU+KInLuTUsbfIBcwBiYGcUzW8arBOOR/SDtR5ZRhQijvJWH
         fqk7htFG2Rfr7+TjrS22nHmvpevSJrCGRPTQ8lwKE3GX+DrayQ1DoP+VJaBvEVR1gdTM
         CACw==
X-Forwarded-Encrypted: i=1; AJvYcCWp3nP6kAroCvFmWrV1JeyGHMnKRkxrcMFb5hGmCzzO6yKKqqkd80CsnEPOiu0oWAErPdd94XE+ZT7yaEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzU91/0V8r+DtaxV5e7e2WCv6qyxEQ67pWO1/CL4Nh7qlOMDKY
	UR3NcyrA633/djJ8vCd2eEC5WdGmDyemyAYPTgN7NrYS3BP0tQupmDsLZZEHXJ+369s=
X-Gm-Gg: ASbGnctyFFDWYmdJfNdaTdCrJ18+1kCXixQ5Deiarbmss3Wkk2cydBB8DrSeMElFlou
	YN3EagdbWrcpoj5PaWVUNTh1sXtcssrDkZL+oYFGCcFLD4bgln1hjSEj9R1SW2ZB7bubtek7bLL
	Kl52b5UcJ9/xa/O8cAbobRuKw/jTMg6sM+0g5FcbdYBtSrg8szqZmxdl3lWrxy5wN/ZBsdg48XS
	gfqKlDzapHgnKbPvmfAdaqYnYOhb19hU0y0AdsPl1E7Wh1OvymFb/7yAGs1U0BDfAiHe/scYzMw
	O0BsGkYw+bNSIU7N8ySSszuH4U2qCfeoCYMS04y68kl0s+1NGm7UKzv7d7ZHEUk23Vgm/mkyyHn
	e/AOjt87P7ZB9jRal6v3b5saWrtZwHC2R3cnMyg==
X-Google-Smtp-Source: AGHT+IHqAL/pnUSG2018CghKhwcQSgL0BqvunVzn+qXjZWNrgfogLc1879jtNukYRptPvZIatFaBWg==
X-Received: by 2002:a05:6000:24c1:b0:3c8:4d98:7402 with SMTP id ffacd0b85a97d-3c84d987994mr18396631f8f.39.1756471728612;
        Fri, 29 Aug 2025 05:48:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf8a64fce8sm3029385f8f.34.2025.08.29.05.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 05:48:48 -0700 (PDT)
Date: Fri, 29 Aug 2025 15:48:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marc Bornand <dev.mbornand@systemb.ch>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] wifi: cfg80211: sme: capp SSID length in
 __cfg80211_connect_result()
Message-ID: <0aaaae4a3ed37c6252363c34ae4904b1604e8e32.1756456951.git.dan.carpenter@linaro.org>
References: <cover.1756456951.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756456951.git.dan.carpenter@linaro.org>

If the ssid->datalen is more than IEEE80211_MAX_SSID_LEN (32) it would
lead to memory corruption so add some bounds checking.

Fixes: c38c70185101 ("wifi: cfg80211: Set SSID if it is not already set")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/wireless/sme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 826ec0a6355f..3a028ff287fb 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -900,13 +900,16 @@ void __cfg80211_connect_result(struct net_device *dev,
 	if (!wdev->u.client.ssid_len) {
 		rcu_read_lock();
 		for_each_valid_link(cr, link) {
+			u32 ssid_len;
+
 			ssid = ieee80211_bss_get_elem(cr->links[link].bss,
 						      WLAN_EID_SSID);
 
 			if (!ssid || !ssid->datalen)
 				continue;
 
-			memcpy(wdev->u.client.ssid, ssid->data, ssid->datalen);
+			ssid_len = min(ssid->datalen, IEEE80211_MAX_SSID_LEN);
+			memcpy(wdev->u.client.ssid, ssid->data, ssid_len);
 			wdev->u.client.ssid_len = ssid->datalen;
 			break;
 		}
-- 
2.47.2


