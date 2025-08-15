Return-Path: <linux-kernel+bounces-770151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B04B277B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0192F7BFF72
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DDA232785;
	Fri, 15 Aug 2025 04:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXN5d+Jh"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112DD22FAFD;
	Fri, 15 Aug 2025 04:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755231703; cv=none; b=tCqveewIAbWzW+mfAtE/WJa/uxpdTX8v1HRwTiaVXii1G0q1S6RU57E5y8cRhoZxRjYmZh0A/l1bJQUTPyDQHCRq+aDbAwPzOP90BeKBPYeE0N0MQ41f4crFUhx2M5RiJe5mLHJIt8PJtOrX35gubWi4l/UD8FsMkykcPwoTESc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755231703; c=relaxed/simple;
	bh=IkJp91E/55DupmuvLpEkYBgYYD4Won+UDcbvNLHgmfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dK2GHiOqYib8r++BoVNdu94ll0057FtfKUXek2hmXDADQc1Ms9ZRGWeOx0Tw9TIEbsuU5xa/geL0ZIhld/wOOo7WQlkFR8XTN9/vsnMf/suyZtYjd1rPr2T+Ob/Y2jE+aAzc4wseUTHyVDImwb3nh9RUFqjMb6Mt70xtEPm+8KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXN5d+Jh; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-88432cc7058so47101239f.0;
        Thu, 14 Aug 2025 21:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755231701; x=1755836501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlEaJjXuqoZ1HAzBjMXk8fek5DSH2Rnu+HHF/ZX6DPI=;
        b=WXN5d+JheLVhDp9T/J/TF1n2WSRWotw7tBF++Gfqm2jqUIpkP53CIxZq7eTHWGSUSX
         6xycTqkhS4XPvUixtTk51AdSbYmZaq5et9S3u/Wh24F5ARU56SGNrnSe6/Y7sI3TRbFX
         oHOlTgBBCrdCz0MgvwYO4gSnjQR0OcvP617ywTRjWUTWDJ8vRp9anaN6QZvfMr+Ec4DY
         IO/mPKUuMIg0IUws02og4kPS86ww902jPVRRNKLl/nCbVvVKvnFzzbWL5sIV76vW+Qdj
         W6p8Gq/rJltapLgRDglCK1K1er7N7LIfPB0o/Ybeta0Orxh4W8+4loqPGWg7pkHakdvG
         itvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755231701; x=1755836501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlEaJjXuqoZ1HAzBjMXk8fek5DSH2Rnu+HHF/ZX6DPI=;
        b=Xzt3ksGez3smlYljBrGXs+V5LfyurcA4ASKinfn/horhrasmmMktpciklj6HHsvnah
         38607Zp6mzQRo84gn0412FNDy5+T+2N4WkRMIvs4NS3wrcrTEMzxXWMfL7EsyYSQ55i7
         MVsw0WVCl7F6fiw7y/502s9w4YL+Gd4gA2NDSBBfhn1V/OEtuZjvofrlct5UYzcsMKUk
         4VGry3pXUEZMDSEiwHOyXmpsvuIWrhvBulLxBx+xmH1lhbd5vDtv6QReErb5IldRYNqa
         mUCqzLlD57IUIR9jEeC27RSX5OjboARuCB1HyfKhmuGbD4YEQV9+rw1LBBrH+3jBH3jy
         bKXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS1q6DF9L3w9hC4tCGw6rDkyoEFSUp1HgIb6YxHN2OoTHFmBHWAvLvILmLYz9v6yrSyt22d3lMs69h1Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2cHnPHFjKnReg303Y6Ck/nXaLWc4RaJCpKcAFamOcTiOWb5IP
	VJ9rIWRBz+5sh5YSAOfUdFLNIxLawKpRC62w9QZDNzY0+uMoYNu7Kh6x
X-Gm-Gg: ASbGncu0SgI7ghyhl2i5M8cJfuPSdbR0lxLs/0Szkzcc0Tlyg+DgQg19sFdN6AaBIK0
	ovxmmJzdmGRCGlRmb09jnAQUqcxhhMgy95wCX3UYQL8aZoay1kXomS0o/pJlkffPFeY7J5N8joj
	urcex4OOhQJEhFXwThkD5HfEC+gU5XN3opmfRvyOPRpWh/Q/dxpxZI75SxwaXqkFo1q++Zg/cO1
	cAi8z0b9ZLthf0bDhioNRSxoxAimgyvdSHtloSwpD72l/Q0kdgFRzDHj/2x3BOAQACX/yKvilTC
	r4M4ZxOJRihFScA5xAbolhzTAH3J27Hty4F4WYfhfJsXXhy68NeFn+as/pjelzXtGym4tTVr+IW
	+gFq/apRFMN22bV0gSvemog810DE1J7VDo6rS6JA66MWjgfpGn4K/9edvANHIfxUTHhs=
X-Google-Smtp-Source: AGHT+IEIJY5yuuiRjS3rmxW+Q4bh6AhCH/5DK0O/b/9BcnO1EB5P9I1mqCzp66//AjqmuCTsfBOb3A==
X-Received: by 2002:a92:ca4f:0:b0:3e5:6882:6604 with SMTP id e9e14a558f8ab-3e57e8a7acfmr12847365ab.15.1755231701056;
        Thu, 14 Aug 2025 21:21:41 -0700 (PDT)
Received: from localhost.localdomain (65-128-248-47.mpls.qwest.net. [65.128.248.47])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e57e5a585esm1689365ab.16.2025.08.14.21.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 21:21:40 -0700 (PDT)
From: Shimrra Shai <shimrrashai@gmail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	shimrrashai@gmail.com
Subject: [PATCH 1/3] ASoC: es8323: remove DAC enablement write from es8323_probe
Date: Thu, 14 Aug 2025 23:20:21 -0500
Message-ID: <20250815042023.115485-2-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250815042023.115485-1-shimrrashai@gmail.com>
References: <20250815042023.115485-1-shimrrashai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove initialization of the DAC and mixer enablement bits from the
es8323_probe routine. This really should be handled by the DAPM
subsystem.

Signed-off-by: Shimrra Shai <shimrrashai@gmail.com>
---
 sound/soc/codecs/es8323.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/es8323.c b/sound/soc/codecs/es8323.c
index a98229981..194720e4d 100644
--- a/sound/soc/codecs/es8323.c
+++ b/sound/soc/codecs/es8323.c
@@ -632,7 +632,6 @@ static int es8323_probe(struct snd_soc_component *component)
 
 	snd_soc_component_write(component, ES8323_CONTROL2, 0x60);
 	snd_soc_component_write(component, ES8323_CHIPPOWER, 0x00);
-	snd_soc_component_write(component, ES8323_DACCONTROL17, 0xB8);
 
 	return 0;
 }
-- 
2.48.1


