Return-Path: <linux-kernel+bounces-774822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 782ECB2B7F3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7503BDAE8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C02623741;
	Tue, 19 Aug 2025 03:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="p/2/oupY"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA7B28399
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755575342; cv=none; b=ex0lWO8OqMqJji9uLSJZWxl8eujI7Kg9cO0223oI6Wdqd2aOADCLAFsYtxCIQa/vV/Rte1RvER1dAdXB+TsXbBA5apanwC8OyeS+9uQM7rwz2z1iuKjGi7cvMubIru33kY5B+7+fv8fWiTi9PAvCM6XW14hvvz0KIdYqfle9j4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755575342; c=relaxed/simple;
	bh=8FnOYuWo4zwOJJ2ymhCQnmNiIKdiE5CGcKxO2n9jJWg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M8al+OIIMBzgJxFDooyUZKgd1SPvvjbRcXNzAM/pDASvRvN4jH7r8fmlAigMNriqKq7/WwtzrmPWDR/j4M2aNq1XTnzbuS8Wepn+XQ5RqSo30JbhHIwZeRmj7UXhst2fB7HI8Gkeczg9n9cNLdD6AsCIdNNxPI3KczD8TD8EoL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=p/2/oupY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2445806d44fso39701635ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1755575340; x=1756180140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m99B4/x3UNc5MFwNLlspJmHpOFFED0oZaOIoZ59+rpo=;
        b=p/2/oupYKqhH/Lom3SJSOA+GCA6FLlohNoEmi1mRT6gLic+m0LZgulZTb//+I0A3Sa
         WZd/wB9FLyoGadeI1WPFS3nXl9/fW9lhIUIndnEu36MIeayicTIJsaiP30Jk7e7l1KoP
         BvMOEJ+l/l/YfdWCnTkJHMblfxS1aV1UbcyiDZ+XRsa0qNIIKOpE6LjsKaXSpFVIMk6U
         ZgvO7EqvPnD9JKu7sEnWQ0mofRwByspG9/iyb39ftIu749AEzFNvu+qGjFqIQMPT46WP
         yzGb9DFrSysmOPyZuuPIslrICw3UkurZL7eyf5cFd1K5bPPt6zbPXhhWOWseSuMBMnof
         GbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755575340; x=1756180140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m99B4/x3UNc5MFwNLlspJmHpOFFED0oZaOIoZ59+rpo=;
        b=jvPZa9C57m0BQXNAVZc5lT62Wm7CJnmo1ykGM1DydRaUtmNgIdrt1MQczvgZ4WKQ4Z
         MHOaCW1FfuhTkH/TzVk4DKgUbD6eecj7cVaYDxpD7FNtqfnzExBUy3RCPnmqqPV3ABDD
         bEGJYGFWw5JPWfJ/0RIn/WDf90Rzpnd6Dr2V64bbffqon5H/l0QOWRRxUERtK5w1Ynzi
         ucVSCq7hGW5vb8MtGx/c0R3yxleOumdFb69hU99fgtK248LUYJFxI32pTmwbY/nOSZ/N
         mE1JQOlWSp/f8TvDYy2hGZ5YzpBdTwTEvS9Ne81ASDRUufMQUpGCHvJgIiMJ6Kc0hqeY
         Eraw==
X-Forwarded-Encrypted: i=1; AJvYcCWfn+Z4daKqrfihGjDp1hfumKKpzdGYLw1KTKMn2welTuS9wPqUwkegSw+TqAeDXeXSmKbAnI/8RDvE01c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq2eME+lVRCFuy07Q9Opr9NPAmUF5+MqksIkN1ZVD6uUICobMT
	yBNLz4jr4xHDo1J6/ENFD26KZyvJF5BXJBNPd4kKIFjbEClLW6Jnkm3yuKCuIpHVb/M=
X-Gm-Gg: ASbGnctiRfPZBIia1ighSdemf3W37hcdjHnGZ1jGPeWBkdfnSyxT9IO0sbGcVpaQmhr
	uRKaLyC4Hg5vWGZab36IJJeENyeWqf4prfH9bO6lLbKbLpOuKqt4HVk2hlXpCRzHRiZ7JA59w6u
	T1jOVJz1t5+xbg6r7g9GgVukfhnSYk5o6MaLKA6dz49M6fHxWwbEoXynJgI4dKsyKA1BV8HgVEf
	22dptwtgB24WGOfcWXEpS1WyTDD3EhGrnL70LtbWUsTsyU3h3eEP+UbrNKuk2HlFRG3aLTYRJFY
	jwRRF5B4b6xpBmH2fLm8coIHO6Lm/aoO4lPE6BgHcMtA5LS6docixNvyOxjHAsHi7I8z2E0J5Ji
	P5SiV52AydPaPXpCVvGHcanXAdpW5Xsg6odqmnvG0MtZZkG9VE12lQvkkDVAAdjiKQq95MQ==
X-Google-Smtp-Source: AGHT+IHZ0BKarqhdIizpMXa33BX24iqTbJokLmzpYC7AQBg5PBlvDQtffrIJRov5JPbVQzOBWH/evA==
X-Received: by 2002:a17:903:290:b0:243:38d:b3c5 with SMTP id d9443c01a7336-245e04ca7bfmr15557635ad.47.1755575340403;
        Mon, 18 Aug 2025 20:49:00 -0700 (PDT)
Received: from dgp100339560-01.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e8538edb8sm28953b3a.67.2025.08.18.20.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 20:48:59 -0700 (PDT)
From: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	dianders@chromium.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Subject: [PATCH v1 0/2] Add tc3408 bindings and timing
Date: Tue, 19 Aug 2025 11:48:50 +0800
Message-Id: <20250819034852.1230264-1-yelangyan@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tc3408 touch screen chip same as Elan eKTH6915 controller
has a reset gpio. The difference is that they have different
post_power_delay_ms.

According to the Parade TC3408 datasheet, the reset pin requires a
pull-down duration longer than 10 ms, therefore post_power_delay_ms
is set to 10. In addition, the chipset requires an initialization
time greater than 300 ms after reset, so post_gpio_reset_on_delay_ms
is configured as 300.

Langyan Ye (2):
  dt-bindings: HID: i2c-hid: parade: Introduce bindings for Parade
    tc3408
  HID: i2c-hid: elan: Add parade-tc3408 timing

 .../bindings/input/parade,tc3408.yaml         | 72 +++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid-of-elan.c         |  8 +++
 2 files changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/parade,tc3408.yaml

-- 
2.34.1


