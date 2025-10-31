Return-Path: <linux-kernel+bounces-879899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E865C24572
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A6F21347139
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5C3314D24;
	Fri, 31 Oct 2025 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="yOKTV5Ta"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA08277013
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905098; cv=none; b=GRH2YnRFRtVrxafj0wnnmghtAwTIdWuIEARThlp6UD2NWcimEwQU8arBNnj9NHTIaeARsBKU9okfiW9pB+vdTxbjWlObVZQkMuIqjAXxtGUkT8Ifi/ILPvgXcOXlAjMQOYwGY0F6HZYpq69tJAcK/KckJ+Ot/M6YPoKELxx9pY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905098; c=relaxed/simple;
	bh=7yfxWcZDMX1WQop/hWs+CPPueDN4eEtRvZml8SfUAnI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=S2iRjKLdrJyuIy12UUnEKu5459+WDu/LGTu9DGIBVMEvbgDXkGC6g+CeU0b8vtQbX0luEYB1dXIjg0CK1hwiEUg4M1uWqIMgzFZBaR8nyu0qDxXQmrcmwPT3P3gmgJQgBYU5/5Ad5l6B4L7E68MGc/0XEs3TMk3T9WVgWkT9l9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=yOKTV5Ta; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-780fc3b181aso1539653b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1761905096; x=1762509896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UvssMcqLHNZRnyHGAkwUA5kNWfzI5bQpc+DN0zFiz7s=;
        b=yOKTV5Ta02t9FqvnaVHwWC3Su1VrqdJaCc4au1pwUPFc15TxOGaj+30Y4bo39unwx9
         xWfY21DpmWrAdjIeBaXUg8bjHvhtotwizhaU/aPPtQy7WHENDHj5nA8HG9GAsboQOrbY
         0E86fcTPSCjwHZE+0e5p6lkek2Wgd6NBi+/ZwXnhQAYTPtwyiZkSaduAauCma6//KLg6
         L8MlDxmqLmCieHrYBID35zsEpevf/vh5i5F6DoeOXjkch/SVz9CqE+r1kxsd0jPS5gDZ
         UBWtLRsAcTFBUK+1k7jL7rFFwTrDn+dv1xcxPICvEggU8Fx7Q42MMS3AHCG0N+GB0Hj6
         BniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761905096; x=1762509896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvssMcqLHNZRnyHGAkwUA5kNWfzI5bQpc+DN0zFiz7s=;
        b=GLnJzJ4Y/lvy/GUPhYN8dwru1LmRxeiySlfqYebNM6bdfOqRknE1FiLBqdF8q1ClLB
         jG/+yhQJHMitlMQ+DZ21hSDpcYdiPCET88/XaDyPhpuoItFSzCclLTvOzAALVXA6PtxV
         XOaxleIS2QslgKj1zuYw74lPhPAwNLvIFjhUISFI98TiFRIEHJ7FbsmezyRPPDwRAXfC
         sCWNtnqefMnhTYawGNfPFFUJiTFa+RZeD1jiw/HYGjTYeIWMZR0bzWNaBCiHRp4poAzJ
         mOyKES5HpTvposEswpjWif188kz3UNAqRMRaZI7/ja8rOh3Ga6inO2LXrExpsCgEXaJC
         lOHg==
X-Forwarded-Encrypted: i=1; AJvYcCWJdhfEJFgL53EkSP4JMs82in4uvemhlEIW3puYltm8qnUAmD7f/QhkFSt7viYr2+VUgHxX+UkinOG3djM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbPsezVdPGWwWH1BE0NnmGZjvZi1bF64aviXq33D0iNSD2NCmt
	T6qOGulQGv6pvjDcoyMz/YPWy9vHo7fOA0ha5AkzgbwXASx5j2h5tnMBsQlvy7yFgNg=
X-Gm-Gg: ASbGncuQmQzKNjblFuW3y4ZolU9VW9aov5q7p9rxfUA43pw2zhlMFCg3BxWIEs46Nyv
	kBHOhwZZFHkVgcxYFO2PpoSVD5Pjb9RgqkBshJK5rKsu3H72cHbf9XIO4T8MQe+SAuE26+C6TF0
	U799MLzeqcU5g02SkB5b8vIjCtuXv7YlR+D8+/+8JiKrmwFhitV+heojpUmYKdJPPWTJSLCXSPX
	cHDzYPB/sWhd1ACTnJaTFCw8E7EWStXrjXdqMCJ6rpzCpKGtQyVP1lTWrE03Ab1glyFGhJQSbD4
	poVgB1FlwirI9I+CCQJkHvsI0plmaledQXM8Io+sO56z2zrSBOhri3qIV1MqqY20JmfvQpsuVev
	IYZS8fPe8qdN1AXvx35gPlUxsiVdn79EJIav3IVxVmZcS0l4sbitx9r5VzZg77gNd9jgQskWvqM
	1TLH3EDdgjtyDky0WDN6GygEK087jOY6e+YX/LROy/cglkASsd2dAbuMYkew==
X-Google-Smtp-Source: AGHT+IE76fjQ4yD5hDeKMEFGATyM20a1IgpN+btK/m7ndkZxEYOWPa8WOPUvju+PU35yBX2pyjsaHA==
X-Received: by 2002:a05:6a00:148d:b0:792:f084:404f with SMTP id d2e1a72fcca58-7a7748476femr3809021b3a.0.1761905095714;
        Fri, 31 Oct 2025 03:04:55 -0700 (PDT)
Received: from dgp100339560-01.huaqin.com ([103.117.77.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8982117sm1644352b3a.15.2025.10.31.03.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:04:55 -0700 (PDT)
From: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dianders@chromium.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Subject: [PATCH v5 0/2] drm/panel: ilitek-ili9882t: Add support for Ilitek IL79900A-based panels
Date: Fri, 31 Oct 2025 18:04:45 +0800
Message-Id: <20251031100447.253164-1-yelangyan@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds support for the Tianma TL121BVMS07-00 panel, which uses
the Ilitek IL79900A display controller.

Following review feedback from Neil Armstrong, the IL79900A support has
been merged into the existing `panel-ilitek-ili9882t.c` driver instead of
creating a new one, since both controllers share similar command sequences
and initialization behavior.

Changes in v5:
- PATCH 1/2: No changes (already reviewed-by Conor Dooley)
- PATCH 2/2: Merge IL79900A support into existing panel-ilitek-ili9882t.c driver.
- Link to v4: https://lore.kernel.org/all/20251022124628.311544-1-yelangyan@huaqin.corp-partner.google.com/

Changes in v4:
- PATCH 1/2: Rename compatible to "tianma,tl121bvms07-00" and update example accordingly.
- PATCH 2/2: Update driver to use new compatible and rename related data structure.
- Link to v3: https://lore.kernel.org/all/20251016095043.1694736-1-yelangyan@huaqin.corp-partner.google.com/

Changes in v3:
- PATCH 1/2: Fix DT schema error for `backlight` property.
- PATCH 2/2: Address review feedback (use mipi_dsi_msleep/_multi, move init sequence to mode, minor cleanups).
- Link to v2: https://lore.kernel.org/all/20251010093751.2793492-1-yelangyan@huaqin.corp-partner.google.com/

Changes in v2:
- PATCH 1/2: Address Rob Herring’s review comments and align with panel-common.yaml conventions.
- PATCH 2/2: Rename driver to panel-ilitek-il79900a and align naming and structure with existing Ilitek panel drivers.
- Link to v1: https://lore.kernel.org/all/20250930075044.1368134-1-yelangyan@huaqin.corp-partner.google.com/

Langyan Ye (2):
  dt-bindings: display: panel: Add Tianma TL121BVMS07-00 panel
  drm/panel: ilitek-ili9882t: Add support for Ilitek IL79900A-based
    panels

 .../display/panel/ilitek,il79900a.yaml        | 68 ++++++++++++++++++
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 69 +++++++++++++++++++
 2 files changed, 137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,il79900a.yaml

-- 
2.34.1


