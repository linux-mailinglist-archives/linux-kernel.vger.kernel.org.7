Return-Path: <linux-kernel+bounces-837297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4273BABE5E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8405C17B471
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C71243968;
	Tue, 30 Sep 2025 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="qB4Ype2Q"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDDD1DF742
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218658; cv=none; b=bcnmZG2SfTKLoV58Y8AwF5UumzATIAOWR9wsym/NHDKNEnMo1V8F+jx/rn35/NkWk3MycF1DeA0oIP6qXtOkp76HNzm6RpsCtt/tnWrW+3o6xehUKY0u7lQob7aXmKtcZ8a06My7CvAjKpBr/8R7zo6RtKFF768L/JATyCd7VZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218658; c=relaxed/simple;
	bh=ZqUTZJxdJskdJMblbDO5abj9EGJDm9Q+viM3LofYUAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DIPgxHo49lZ027SqZzLCZQM9hXt3DIpq/cHmyaE1hJYTMuitrvq908t+djiataPQJHNLalHSfcZnimiPdexFblhsRnUhDLd+xOGKuPu4PKlkTiNHNRH1fRgfzxnuL/xxlFR21oqu4bV/HRvlGv81i+/bi03VyM6hsKRAyNttDmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=qB4Ype2Q; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-26d0fbe238bso43431755ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1759218656; x=1759823456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0RGErcP5iIWaAYOH1EdzfokXK7+mdWRIaYg5XseTui0=;
        b=qB4Ype2QmXXzWll4VVlYW/koznYU6OIXokjODwiqI0sPqeykrpp4zYGF7zhBepaMSg
         FlTcftZtT9ZEhPrvty2km3bg6NNzAOtHPu9hiphTQKYS9/3+9f8W1AZqvnds7RqGjhtp
         qBg4UivNyRrbXQCqhyLvvOFg6ci2DEA2BOrKVcA/T/693tizBP+bCY/k3iUcB/LmftOe
         zUfKk+avX3jhfpTJX5ZEYUXEi/eScB/ay+ZSwVumxWdkVuU7vOL9VqJm+BUrUOl9mj8Z
         TY7LdG98MtG/jxLN7cbw/qAg4rbGKmJ0u7HyYnmrVJa+nA0viQslXjMaN6kpWgEkUl4f
         7E2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759218656; x=1759823456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0RGErcP5iIWaAYOH1EdzfokXK7+mdWRIaYg5XseTui0=;
        b=Lmxg4YCsQBB1BIwErJT7RRSP17WKXdpDykOrphq2VN8EZNVuiWjFlNmOuNioh4E/RK
         h6po7tRRwchz6ug3OEVfDkToAL1wighYzI3t9eQ+zLPERvBi5zHvlE3/DQexI5Ti1RZm
         PxHw8+IRokAoP7yuQX/2oh6e+jazCIZUOe9XaLbABAT/i0WjWlKMDNmlpk5pBrOQ1sZL
         M3YmRiS7Km6ctl+CgoZLTYKP77047P21Z8g78D8hPPo+zEVnsdkdTes3g4qoUg3Fs6sx
         0DYH/ZNJcMa8v4WXaMCXKMn0i1Gix/F52x8+154nvao6DlWjMzAbbYdXimziBDLWB6b3
         BTTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcOHRsahkoyKhacjiklHeQ/eBwrUVGakUe19QRHRAUkzPxQrZJfIlcYgXMkfZo0zci3lshHK9sklKG0q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPDXD8Qn+H3lgsKKg0fy4ugJhTTAxJyfuG9Xy5zDBtciV2DRvB
	wpWWG9SHQOIZDk8csSvaYBiiCgcROdYjIxd7irerss8xMBin9lvwp37OMCWATZEqIvE=
X-Gm-Gg: ASbGncurpj/TRJT055xlDe5g09rVaIs8cZUnoLFU6E2yXcLVh6iavXCrMCQEBqEb/Qb
	hOsJwZl+EzzEBTUqUSGPwJyrumNT1Ln5qKuV346MX5Sp61rIy8H5hRdNX3GtGAx4zJ/KgFDRctw
	JyVUDxQV+YvjeGSzCkV+1fWnkGA59A+iBc48FgzCrVqu6iZY1tMEoud/SCd10eyUFDh3LfLFWqr
	ZItGw3qf1Z3it32Bi0PpPAcS9T+zLAKkZlD6zXY/cJ9htj74ljLDS49ZAsv51rxNazW7//E2pw8
	qC4YBgDtVfsdV2Wwivy4FTGycDrxWM+uvm+JG+CCajHXt2FkiNxg0P5IHWaRx7awfw/jCutN0kH
	mew/ICj1Ykk+Sk+XLjgxDXUZgOLZo7pjn7qEp+2hJJIpV6oT7nYTgoia6oXoFuF4hDWtuN2EukI
	JpIrNIngt9C5BuRPtp07nv8GZEpRY8
X-Google-Smtp-Source: AGHT+IHkjlHtYzmiPHDe8EY7GT2BmQZoEPe0VhhME3S6IElawm+J6e6S+KLLCXGrXpgMSliALMEWUg==
X-Received: by 2002:a17:902:ef44:b0:246:a543:199 with SMTP id d9443c01a7336-27ed596f868mr225436925ad.54.1759218655779;
        Tue, 30 Sep 2025 00:50:55 -0700 (PDT)
Received: from dgp100339560-01.huaqin.com ([103.117.77.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed688223dsm152313565ad.86.2025.09.30.00.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:50:55 -0700 (PDT)
From: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com,
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
Subject: [PATCH v1 0/2] Add support for Tianma TL121BVMS07-00 panel
Date: Tue, 30 Sep 2025 15:50:42 +0800
Message-Id: <20250930075044.1368134-1-yelangyan@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds device tree bindings and a DRM panel driver
for the Tianma TL121BVMS07-00 12.1" MIPI-DSI TFT LCD panel.

The panel requires multiple power supplies (AVDD, AVEE, and 1.8V
logic), an enable GPIO, and a backlight device. It is based on the
Ilitek IL79900A controller.

Tested on a MediaTek platform.

Langyan Ye (2):
  dt-bindings: display: panel: Add Tianma TL121BVMS07-00 panel
  drm/panel: Add driver for Tianma TL121BVMS07-00 panel

 .../display/panel/tianma,tl121bvms07-00.yaml  |  85 ++++
 .../drm/panel/panel-tianma-tl121bvms07-00.c   | 419 ++++++++++++++++++
 2 files changed, 504 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/tianma,tl121bvms07-00.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-tianma-tl121bvms07-00.c

-- 
2.34.1


