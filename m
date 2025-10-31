Return-Path: <linux-kernel+bounces-880927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8CBC26E26
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E66794F5E42
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 20:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97165328629;
	Fri, 31 Oct 2025 20:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrRWhDoe"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55288327205
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 20:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761941975; cv=none; b=cuTGmS/OntFTn51qOpnijijCbR8KUHGm05QeoB+ojFunZx1sS7OLDX2fGMnKt+ZqK/pz7N1YxR3sUhmv0P889TgbRnrF/UmyKOVwhcXdW/fuGcIDjTjd/KG5RlzSiba9YSDfTR7ggRfQhAYJYBTmtjHdNjqx6XyPzCJbdJpW6z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761941975; c=relaxed/simple;
	bh=uhtPyUARMh6iqTL6T+FkCm4KL2BKQJC1wSSAlBNThFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BqwwYgu6pa58PgT2SI4piGwnojrNFuxGN+k7tv+PbyXQVIlx/0Yd0eFy9dORrSTiiUPI7wNyee2Mx7PGTgrLh8lj7NAhk32ofAkIAsvOt9vBVsx0UDtLuWpQYKhyaUD7z1Hm08cHFC+RKpJ2vOaFWpwg1xMAETQaOIkpi2yr5P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrRWhDoe; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47114a40161so29888205e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761941971; x=1762546771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTXisoAd0Dg/UVvUO2lIGrX9MKyF/plfDMYlzBba5Os=;
        b=WrRWhDoeyhDHnRIXVxz9G8+vheiHkGEmibp4n0PBAPRmb+49ZrL6WsRiRZD0T8hEpe
         e+Dk21UghZjwc0M5reDZ+iF2cTDutncCepE0zrVm/A2YLvi/YU4h20LhNeuvYZa3bK9z
         wF98ehcGxaaSWhvrqJdfl1Db+fOGPw5H9W/Ko9xWjcwUoDTTib2YSzdcTcXl6U3eLx8v
         xJWG8HtJWhESQjgfjFFxTbiWawx8E38rQ47Zv3jB+YATafv70ps4aorlWQhWhl/d3iIB
         2h9AfQkaEbCaiimNO0s5Nme2rLv6AFuoN2urJnQEMpM4BVYpEdjnTq70iGqnAMvloqpy
         xV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761941971; x=1762546771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTXisoAd0Dg/UVvUO2lIGrX9MKyF/plfDMYlzBba5Os=;
        b=My3G1bWf6cKye9TigZencoVZKceMhMIF+VBR9W1vXBSWkPVyalRwPa4ZC9W2CD1aXH
         A5acoHBrqDIM3b1WnnWedqNNJE/ZH5rtpztGIEJsHrMPb2soVhQj4ouOPCjBWd26//77
         X0JzqsANEYnmK+lvTaCUkwokqkT5NJDGDNdZhXZ2QGHpK1Is+DpZRxpjZwghu3d4RyCi
         f5irxNNE/XdGNd7r2sDgWPZV3pLrQZmERHAS+ypUqKIPq5DAfsvJBqNu2+B0MrNTAODZ
         1wvvCqwTTnwKa6lKV9ctAJLnPDqVT4TNZIOIvvByQWjRODZTfLF848+J7C4GXpcbL1Tv
         u1xA==
X-Forwarded-Encrypted: i=1; AJvYcCUbDXyN/P0JuZO8b8wD3CW9BsQFFN5/5uDHbqD8fXTRlt3yLwiQfLIC4tFm2sSbkSrF0P7nmZfJ0Yc9bjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4imSJlepphX9/3I9ibwApsrpTgQIA6lnCuDUeusGP+k1+AfNn
	wNWmXJhlKyEP3FBYFMGti6qXra2Vin3ocZ+f7ZfuBLDxg71rt70xscd2
X-Gm-Gg: ASbGnctobupV+uRRhBBedTpfsaGC3xfSp/D0fQsbRtbTlZ/Z1uIL7iYGlnOjDxTMFAT
	Jfr6nEwQnpp8rgdXup1nduy/fMoCKxTQkhQ8JfnfmY9vFfwblijoj4fZAX9Zvzr0PJ3AOtNYidN
	T+6VrTGquqg38ygbkPA1DFjcsSioSRrOnQvJommesDBK2VqDTHUXwxYklHd8u1Bc1j6F4NQhS85
	6vHjBmnQ1MYti/CLKhAmQ8HB7vlO0UHqE4v+kTsbUux9dVOe9kzD4QdTK7rEy0lq+7BimjrVrB6
	dyGSLAZRqZoEw6RndgD2c35HHmcbw4PvXHH3zNPd4UDH+kmOwcXdIERhXqYm+twGe8Udygaexk9
	EXg4Kde5zX8K57iOwUwWaCqjgpD9JKW8nzto17qanEoUYvGsVuLDySbP6/At5mnziDZaiOXh6BU
	YPgIn36SkXmPQrvco7TYDgFhsy1Q==
X-Google-Smtp-Source: AGHT+IHjclgRnjfrDGQzSRybsOxGI4fC6nX630RldNdxkLC4PcHK1n/8rSaA7MFSbLuneEDWUGjtcA==
X-Received: by 2002:a05:6000:40ca:b0:405:3028:1be2 with SMTP id ffacd0b85a97d-429bd67c38bmr4338005f8f.11.1761941971429;
        Fri, 31 Oct 2025 13:19:31 -0700 (PDT)
Received: from localhost.localdomain ([78.212.20.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c54efcbasm1800360f8f.8.2025.10.31.13.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 13:19:31 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2 2/2] iio: ABI: document pressure event attributes
Date: Fri, 31 Oct 2025 21:18:23 +0100
Message-Id: <20251031201821.88374-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251031201821.88374-1-apokusinski01@gmail.com>
References: <20251031201821.88374-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sysfs pressure event attributes exposed by the mpl3115 driver. These
allow controlling the threshold value and the enable state.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 352ab7b8476c..5f87dcee78f7 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -898,6 +898,7 @@ What:		/sys/.../iio:deviceX/events/in_tempY_thresh_rising_en
 What:		/sys/.../iio:deviceX/events/in_tempY_thresh_falling_en
 What:		/sys/.../iio:deviceX/events/in_capacitanceY_thresh_rising_en
 What:		/sys/.../iio:deviceX/events/in_capacitanceY_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_pressure_thresh_rising_en
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1047,6 +1048,7 @@ What:		/sys/.../events/in_capacitanceY_thresh_rising_value
 What:		/sys/.../events/in_capacitanceY_thresh_falling_value
 What:		/sys/.../events/in_capacitanceY_thresh_adaptive_rising_value
 What:		/sys/.../events/in_capacitanceY_thresh_falling_rising_value
+What:		/sys/.../events/in_pressure_thresh_rising_value
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
2.25.1


