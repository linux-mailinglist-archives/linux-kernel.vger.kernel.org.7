Return-Path: <linux-kernel+bounces-791761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 502CAB3BB96
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772761C87C4A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D391D61BB;
	Fri, 29 Aug 2025 12:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mT0Qxt13"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD3BEEDE
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 12:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756471709; cv=none; b=hoal1PE1M7kYhdJrTNRhkpJFaIaEC4x7Z8oak06N7Ns36oKo83+JFKmtV1KlZoVG7gi1cY66Cn3jMw2/EFJNPi4ghv6oHoZbOG+Wp1uqj7l9uxvq9G2C29CFntPj1pgJibrVGVbPcnONbI9QXrDDbI1MBUl+8HqFZ/yl0viKGP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756471709; c=relaxed/simple;
	bh=s0Y1Z5NRmIswO1bXuLmTtrvgrV4SkjVpWswCBrXNYuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QMKnMOu/R/TrMIkazRi3nRDVQzoB72VZDctQRW2S1ZKAhJKbyY93CGMKCCiN8i1xxywMEf1dU04wgidNa69RZ/wB0QhS//fPYeoKWTimO6aFCJugIaxaFkSVm4MIGNCu3CG0oVIrN+P3wUqhbNkdZDuYa9o9ilraqM+Mb4qbmBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mT0Qxt13; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b83ae1734so679325e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 05:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756471706; x=1757076506; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y1TiY7ysjOZKRPS0v/GfCN7RvRXXI4uCIgolqPESgxk=;
        b=mT0Qxt13CfTHbqi/4KcL3oGnvLvJFHPnFiqtzAueflzKko/BozHXlp1ZkYvdRGCqhR
         qwuwgLgo0DDjgy3X33jKvDhekv6LnAJjbwgqYxwkDCeJdo3JzKkJSLQsNxi981T5Xlgk
         xlfme0zuxdHzr54ojBcLXD4qlL0fkA1ALINuJWqY2q2BeEaAe6uZtqAV3Whyhywx95/T
         6NoGirhRpA/k9cFwyjYh2hYHv7CznihRzdNK7O59JSSRpuZvuHa+FQUUcFFr/4C5COSr
         gm9xd23r020aLKyXodwbtaZihGGeJznkZ4GT69UpvrimmpK+kkGhXzRYQVQbJAOq4bKb
         0xQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756471706; x=1757076506;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1TiY7ysjOZKRPS0v/GfCN7RvRXXI4uCIgolqPESgxk=;
        b=L7OOSsIeLcKngEMmSfzFNz/V3QCytG4KNqbScCagEZ/h7dUvCLO9I8WbXCDaAJPCcS
         Y9SHraFFb/7yPr9yByTeuQXdQFFYCV9C43553rdv5xkaBDUuOLLrATxcy3OFmL2oVPxN
         wTvVIJs/xaPTQ7oCgzQipPrbgBMXNxQCU5Huhi4/sXaTvGxannBMV4Fz1Mm1yggi27yX
         vYxNjKZyYCQlcLt8+moMDMY3Lg7SqkdbJmEtIGkAXpr8QlUD8c8ScCVqMxoWxxxcyR/y
         TbRhzTv5I3SOeB2ZkpaXWTpKAt9qJVDQqc3nXkmvu9gziawwSqJ0nU/917rdhFgsdS5G
         AoKg==
X-Forwarded-Encrypted: i=1; AJvYcCVOHV0cnvrKS58Et44+x2fCyVaKA3Dfie4+/EtyLlAyIlDehiXtZQ5S6Y5kzZoHZruAJqzvdckhyB+9pGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpZ3/kAmCmqOs5fUAybYDXaQjTFbyGbR08OKKjEb7jiFZJMlBO
	x/874prt9nr5T6dvsww8OhvHdibNnvOlUJ0KtlZR0z+hLOha/3cRoV2JKZx6Ee0jemY=
X-Gm-Gg: ASbGncsxHOJl5Ytgpd/bzlTZ2GQc++7keBbeTol6inJcXKqC8b+m9hUnirNbPP4LSC4
	yLNHM9ZrcskL55q+eWxnYLsc0WAGf3hVEJXrqX8UcCMxZdZRranY2k/CVknoN+xx050qVBdUHvW
	7k19zxPEwCEad437vKwxD6W8NwKIE2f//YF2vd6vbX913s14WaRkOiBBGnRTTrYU6Dbe/UF3NBi
	MTP6dtpLCeJIJpyDVv6zeazCLcI4g+ZY4nuqfWCu/sLIeHJQ/l0fnsjwyQ/q31n88lHSQsj8laD
	k6tWMZeJaYl6LUl/rO/65a//5cBnXN19AmJ0wPN8ae82oHOXBxcNDWaQr/dseSZoYQbMmYMj72U
	g/VE0BkVsxz5Q7UYZ2AJVBv5Q2G+czxCff9sF6Q==
X-Google-Smtp-Source: AGHT+IG5ZyAiHuK1O/1CVyBhFH7yFbM7hahLKw5Q/RCW2h1UrGvO45lEpWadjzIhQtCVo+X7CY44ZQ==
X-Received: by 2002:a05:600c:2ad3:b0:45b:79fd:cb45 with SMTP id 5b1f17b1804b1-45b79fdcc32mr37397295e9.29.1756471706168;
        Fri, 29 Aug 2025 05:48:26 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b6f4aa8a0sm118810715e9.12.2025.08.29.05.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 05:48:25 -0700 (PDT)
Date: Fri, 29 Aug 2025 15:48:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marc Bornand <dev.mbornand@systemb.ch>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Felix Fietkau <nbd@nbd.name>,
	Johannes Berg <johannes.berg@intel.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"John W. Linville" <linville@tuxdriver.com>,
	libertas-dev@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	Solomon Peachy <pizza@shaftnet.org>
Subject: [PATCH 0/3] wifi: cap a few SSID lengths
Message-ID: <cover.1756456951.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

These patches are based on static analysis and review.  The other places
which get the ssid from ieee80211_bss_get_ie() do bounds checking to
ensure that the ssid length isn't more than IEEE80211_MAX_SSID_LEN (32).

Dan Carpenter (3):
  wifi: cw1200: cap SSID length in cw1200_do_join()
  wifi: libertas: cap SSID len in lbs_associate()
  wifi: cfg80211: sme: capp SSID length in __cfg80211_connect_result()

 drivers/net/wireless/marvell/libertas/cfg.c | 9 ++++++---
 drivers/net/wireless/st/cw1200/sta.c        | 2 +-
 net/wireless/sme.c                          | 5 ++++-
 3 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.47.2


