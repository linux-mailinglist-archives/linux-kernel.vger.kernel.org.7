Return-Path: <linux-kernel+bounces-814636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD61B556C7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6523AFF84
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 19:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86453375B3;
	Fri, 12 Sep 2025 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TFztMfcx"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58CE329F00
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757704213; cv=none; b=BGuH5FguCXFQm6zQzxevv8seJ6Pm7LpFg37cLKeyK+NfIKJ7W1hlEVTz7urcTL1tDY/gHmtC/xgPq3e2HTxNigMKHT9+sRzGWCo71UUZYXqVQDkBIPyHGMQOB/1xnDt3WS4/k/S3CTswoiNAYtrG7lRkndOPAlWni+z2v6rX0qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757704213; c=relaxed/simple;
	bh=CmGNPT7V0rEIUqkAzuwHl5Kwajs65zc9bdwAeyLTTiQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bPk9Hy6kkyp+e3k8O+T4MDHScvlkBlzaL1BwTKh4XkJp4yhQ1KnrlF3gyYzqLwl9zJ0+qx5qIUUBfNASR7LA2dPIg2sYXTkSZeeqA9yBbglP/kq42TdLqBqjUc6CQrfPuxiknq4T6Ldic+uRLrhZowHtEUWsWgs8eN5Nm5qTCPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TFztMfcx; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-750c5378b96so1038919a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757704209; x=1758309009; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s8R1a3qEofL18lptDLnDu4OuMHJMIZ0T0Us4caydh/4=;
        b=TFztMfcxmVmPvq9uHdQut+p9Y8iNBy50UlrBp7GrgFJteUD0Uv0XEXyqO3EB2mMECf
         RiX+qu8w9UQCOCjRnLUmgzbUMlNARQRsuj/WfZBHQNsK9y/eXJhHrmqO5e9shnFOvbaB
         efXrFPRUIcLBmak91LcrU2buMiEBaiS6pc5Djlaj4bPyjhQUEX9vFOCpTJo4YCHhlR6s
         m8depyu7kXSGMqEPx5ybXT4FnbbJUOOgmVXeKPDWZIRD5SGyf+4IqeyV0G3yXc+6Oqq/
         E76tlgcOyid0l4I0WYLv+UjgLw5lz1QPNdLM8ZMYs6mFbAqxUCIDul4GIO8R496KtXwo
         bzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757704209; x=1758309009;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s8R1a3qEofL18lptDLnDu4OuMHJMIZ0T0Us4caydh/4=;
        b=gNIxwyc28DehJTJg9UmUOmaWHtRQ5x5sO1iLz3aTbhl3WUkDstdB6uQ2/8N2nSj4b5
         5Q4sXCPmOzx7QflZxQ9BhBYekXNry46fWEpOHUfV3sc7YgJ2rPoRFwRoj9mEFI7N8G8h
         b9YKQtd/W4zfieHfF96hscDmdZopl8BiubACWhLTDx1bAzp3CCr66q7yprZjvbE+k3IV
         4V8yN9aSW9JCabqTuRI19O3QjzMyBM/ldkae1gwmJUNIjAcFJbmIHOEvdpXDTxKYhgcX
         YiyrvtgLjdFsGQd/5nXu1/I3lFeDTVcywPEWBSOxh9S3cmOKAyS+ZoQXEicmIsOkjG0k
         HeCw==
X-Forwarded-Encrypted: i=1; AJvYcCXfmpRVJwpvVH/bBOfLzpZSOPwhVAW2+FlSu0nbUYqJS6jVcCVBjZ5vJlkOTYHX1BcrAIWr+k1QUNABcCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YybF1GdTX1nY8a8jWBEffqIggOJukdEBEjebc63lonxQItzDp6a
	WpFYsT1M0oW6Yr4cOSt+EXeKHRNmynb7s10I0H6x6Uvjfz97h/d6FYiMDWm2t7CkPww=
X-Gm-Gg: ASbGncvqA9jsyE+65+jSz7yUj/t1ftkrU/cgDMC63NeBbuq91G1w8TQGJ1dAD9fOcYs
	HAlQP8jrcuNXTgoamuG1upZI0n1ZGYU7+tvQs1+eWYBOO+p3yr8Kzw1i+2FpiFh8yTliA1QdXmU
	vBRdxldEFvN9K5rg1F0YjFc07bCOwih860E0mLGX6mbsh52wHUzmTw9cgJOeKE81Tvm1o1x/Rmw
	yTA+RvnhTSAztQBUpzu4vdmVwyF5Yv7Ucmu6VLAiINNAb2pLG+I0gHRKsQ8/A0QB1PR4Cix3U7c
	u9Or6mFarQBenUmDO0FgpRdaj3X0Lgk+nUJpX7PdYNqig5d2htugcEtec4D/Z7STPU658IQU+GU
	Liu+/cEWrTrFL2CgwdtkowlJ4jTx21AlNBHv8804=
X-Google-Smtp-Source: AGHT+IHqEFcrb3l5R0Gxazy+o/Dw6s3aigM3xBJ1uGXI1FLC5+KCNmme5tRtbrm7v0tjBv8c2Rtoog==
X-Received: by 2002:a9d:73d8:0:b0:745:9cef:fa1d with SMTP id 46e09a7af769-751e0cbb003mr3347474a34.16.1757704209254;
        Fri, 12 Sep 2025 12:10:09 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524986c872sm1172564a34.15.2025.09.12.12.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:10:08 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/4] iio: adc: ad7173: add filter support
Date: Fri, 12 Sep 2025 14:09:29 -0500
Message-Id: <20250912-iio-adc-ad7137-add-filter-support-v2-0-bd32dfa3d761@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOlvxGgC/5WPQW7DIBBFr2KxLjVgNwSveo8qizEM8UixcYBYj
 aLcvRPnBF2Mvt4s/pt5iIKZsIiheYiMGxVKC4P5aISfYDmjpMAsjDJfymoliZKE4Hms7ixHkJE
 uFbMst3VNucqgYgRwBqJ3gnvWjJF+d8fP6c0ZrzdW1fdSrFD9xKKhCcoo6xwc0UbvlTMHRtNFZ
 +14ML1T/thFrcOrd4SC0qd5pjo07ChtxjlxZ8s3tpyVlrN4GScqNeX7/uSmd+U//tm0VBJ8jNg
 r7ftgvke4X2jM+Ml2cXo+n38DQXlqRwEAAA==
X-Change-ID: 20250710-iio-adc-ad7137-add-filter-support-d0ffaa92afc9
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1553; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=CmGNPT7V0rEIUqkAzuwHl5Kwajs65zc9bdwAeyLTTiQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoxG/uMzNVM2m9yvnqnCJOVjFcB/cYsXzuQ8D9m
 oQvwVvw8L+JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMRv7gAKCRDCzCAB/wGP
 wGZgB/wJejTI+jW7cskvSkJzpg1qP7jiSbtlBAhse9KdQMPgAcr9md44LrCSHmnAk1VKi6v7ZhR
 UEpYb4fmVa0Qqnyg0dlYqNmu29OnmFKlNexvNaCTdAYppKrXw80iHcBg+eGjltew0DmxpYD3VZa
 N1H7XXnKYO4QLxLiLYsr6CJvcMO3zjkZCwdnb9p2crAPmDVTjGG06EVFaC4G9iiSze6mR9I2vup
 3BcR5h70tKkYaLyxAdYRfceXSsnG8w37oJ6IN3SBchlXIZ4jXXoEV+tbeXs+cLZACK+sY/v9XhC
 tkLK+jZlP/oIkvryl9+2oeWw58aloxuIwrVTkIDYS+JE/wgA
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Adding yet another feature to the ad7173 driver, this time,
filter support.

There are a couple of leading patches to rename some stuff to minimize
the diff in the main patch where filter support is actually added.

This was tested on the EVAL-AD7173-8ARDZ evaluation board.

There is still one fix sitting on iio-fixes-for-6.17a that needs to be
merged back into testing/togreg before this can be applied.

---
Changes in v2:
- Dropped filter ABI alphabetization patch that was already applied.
- Fixed ord/odr typo.
- Fixed typo in cover letter subject.
- Picked up Nuno's review tags (I didn't do anything about the race
  condition since I don't think adding locking to the filter_type
  attribute read would actually change anything in practice).
- Link to v1: https://lore.kernel.org/r/20250710-iio-adc-ad7137-add-filter-support-v1-0-acffe401c4d2@baylibre.com

---
David Lechner (4):
      iio: adc: ad7173: rename ad7173_chan_spec_ext_info
      iio: adc: ad7173: rename odr field
      iio: adc: ad7173: support changing filter type
      iio: ABI: add filter types for ad7173

 Documentation/ABI/testing/sysfs-bus-iio |   5 +
 drivers/iio/adc/ad7173.c                | 204 +++++++++++++++++++++++++++++---
 2 files changed, 195 insertions(+), 14 deletions(-)
---
base-commit: b8902d55155cec7bd743dc1129e0b32e70b1751f
change-id: 20250710-iio-adc-ad7137-add-filter-support-d0ffaa92afc9
prerequisite-patch-id: d020799a8e7fcc092607923f977b62490c83f11d

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


