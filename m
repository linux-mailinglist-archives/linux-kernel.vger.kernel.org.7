Return-Path: <linux-kernel+bounces-845130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB996BC3A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 09:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF9764F88D7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 07:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5F32F7ACA;
	Wed,  8 Oct 2025 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnepocsP"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8532F6189
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759908698; cv=none; b=bjndiVmBboDogA5kZFEczgIqdVVsjRx5iuECSBB7IDWGVD2iXyqbygW9Ei1WmvLhaZiPu44qdQbj2nkyNNawGULpFA53ZJ/u6V3hzpc6RAlCuAnap7o9UQE9zGdZzPZr9b3AhUl7VJX8uZNYfwK4Ms4gIl6IrVNc4HJqwsHT5ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759908698; c=relaxed/simple;
	bh=1E4pIC1QsHHkQt4ekahhKEIh+y+kem4KLZqEezDk7/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8hE6nyHcakavzMPuxmdeD4m7E7HIbwe8Elju2pMm2uRS3D60SN6wX2Bk1dm9p3CY8u52zp7AKNXVlMazpML1vJ7mliMOw/QnQLhKva2H0IxWUAvfaH/2RA6B3zIi9Bw4L2VBXhCKQd6HXRMFbnToayFzWMqzbdI+n4LVAgc1NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnepocsP; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-58afb2f42e3so8513128e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 00:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759908692; x=1760513492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+J0PH9dJMfz5boSq++S0Cav+gbesPYUNWBRR+flsya0=;
        b=WnepocsPt8VyJCuWn2hFHE02Mohn/IgFbO0gW4nKF5DBISyk4/N6lDchGbyjXkuZhQ
         wWQmw3zdjqrF1BmRMfz0skbK/oFx5+OQTss4XVEroJ9mMMc3w0qzWrtBYI43pd0CJrWW
         awrs9FKtXFeJoI++CkOUONGJ8Cv5EvHlMtJTEHUBE3JsnGeN1sYI1fXaPkN9JjFWN5yG
         i54aWFk+nWzzWH3M/JNZc4rOdVpi0fCZKDrHIDP7vb0gFFnPccxWfM6m3j4baKqGzk1B
         w7IFoezNsH+dGxouwj54xcDlzzh8y2/n9QUbF/hgyfUBOIiCoSS0wSVqx7X3rCUQ+jbH
         H18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759908692; x=1760513492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+J0PH9dJMfz5boSq++S0Cav+gbesPYUNWBRR+flsya0=;
        b=dNfKUXCHb+l4tvMiMSczFMSAcR0BfDK3Dv6KbF9co2j9DN2ikLj3FxPrRtXuDKzsM+
         Yovql/KivgBqbZgsnlXIA870Pkh2RzV8BIz19RUTT49NgW6v+9dg/L2WibdmhRfdcA6Q
         8pHrn2lLWAdiUjCb2rQVk0udvjabmdE2lTg4VJgkTsyohKxLTTNbjUcx3nfdvWTvAoYW
         uS5NXdRFAIoRsuVrwCYkHv8fv0xbXwKGtKgegclYRLs+yb5TZanZNQFOzG+Olzmom5SC
         +2KSEmgIfiRMPebngIsiImaosVyowGY4hGerPRvAoQaHTi8DgC2g5f7UN+dOM9fuGPb6
         Es2g==
X-Forwarded-Encrypted: i=1; AJvYcCXb4wUc0VY9pGDfPldyEovJpThl3mngJM7lAuQ/LaidIHo23ZLO3IynGjZtkFcabiu19DBWWLPaqCAYNZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZnqf/mRdOhW23UG5NkGt6QFgI4nLG1qbVfMYn8UCuo+NKXp+k
	i/32iFikGYIxh7vOINXfGxC/VijP5OmhqiF323rprgfg43hpoey5eHuc
X-Gm-Gg: ASbGnctxVYqSBsvvl03ivDxYpBVRxS6Kf7YXwicDNF5tMMQMvKuTc+nSNFsveysMhDA
	NMfk4LcNIIRYc8Ri3FmOKa0B8sMFtdDz/nlvtRhlGpVuqc+ZTk1oLWlHbTI2a3PA5BMgA0ATlB0
	hbKk5oRIvcCVP8fMbUfhQp/RRLhriofX3B48FnwljkF87Ku/QKtaVmLFAIC3RtM1JkUl13aI7ZB
	ERLtZOW5Zsr9PjtL9nJq5PYgLGQGbM4VtSOrkggCsOOg71TdDgoj4sjN0aP6x/o8eJdadOkbC8F
	t1arSd7taUK1mIZKt+2b4sbkVCsUwoD8Q91WIGz+QPdhqxtoOShj2XIE4wPw33lYdfpAxZtkPVP
	KRmeOu8HjqdvxvawIcH4Fgt4I2aA5+bN0U8IwEA==
X-Google-Smtp-Source: AGHT+IGohM+FjzJZWI2mxJtv1ojEP0dXBrfZwMch9BdyXmNUeB5wEHKzwj5zcjMl3VMz4m5oNM6M4Q==
X-Received: by 2002:a05:6512:3b8f:b0:590:651b:10e4 with SMTP id 2adb3069b0e04-5906dd54146mr641087e87.37.1759908692226;
        Wed, 08 Oct 2025 00:31:32 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0118d22bsm6911016e87.85.2025.10.08.00.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 00:31:31 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
	Dmitry Osipenko <digetx@gmail.com>,
	Charan Pedumuru <charan.pedumuru@gmail.com>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Aaron Kling <webgeek1234@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v4 11/24] dt-bindings: display: tegra: document Tegra132 MIPI calibration device
Date: Wed,  8 Oct 2025 10:30:33 +0300
Message-ID: <20251008073046.23231-12-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251008073046.23231-1-clamor95@gmail.com>
References: <20251008073046.23231-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document MIPI calibration device found in Tegra132.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../devicetree/bindings/display/tegra/nvidia,tegra114-mipi.yaml  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-mipi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-mipi.yaml
index 193ddb105283..9a500f52f01d 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-mipi.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-mipi.yaml
@@ -18,6 +18,7 @@ properties:
     enum:
       - nvidia,tegra114-mipi
       - nvidia,tegra124-mipi
+      - nvidia,tegra132-mipi
       - nvidia,tegra210-mipi
       - nvidia,tegra186-mipi
 
-- 
2.48.1


