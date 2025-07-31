Return-Path: <linux-kernel+bounces-752638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D93B1788F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C0C37B5DA5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 21:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C955926A0FD;
	Thu, 31 Jul 2025 21:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3KaeFtJ"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F4C246BA1;
	Thu, 31 Jul 2025 21:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999001; cv=none; b=TnrQMoWYeUt7GwwWj8JU+zduzB+loQKTpN9Ev3IpaCWpY9m8avDl+hfJTGRzFNrnYEveOqdpMbY8Ulgw/DCe4XUj5JTEexgzPed0auVYQGs5IGkaV+eZVcsx8ijoZbWrs1pCiYXFp0hmYrZCYsvUXfT7L7vKCOfTqU1x8ZAb+KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999001; c=relaxed/simple;
	bh=xhnZUWW+kJ8YWKPwAKiLluhft0pFlwKW0O+f7KMaVzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ASfGc/xiMXpWyLcJKKUXaDwduqASsZc1O7Iy3O2xZaSVlSTuE2Fk5xT1LDAFuB5dZrdnroLZH3Uz3ED0jMnJOqkrJcGJK8G5vR4iFeAm8yLfK8ie8isDtbJbt3tidsLRaT/0NDc5bpSL18xACdItMyInSsQYFI0YDVww/I1v4sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3KaeFtJ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b7961cf660so151079f8f.1;
        Thu, 31 Jul 2025 14:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753998998; x=1754603798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y2nFxX91zPm+pyMYKRygXODZT3df13yCxq2wpuLKy/o=;
        b=E3KaeFtJ1dqWVoDC2zXg0upT3sD6hhLAplFreX7OvFvySRisAnVwMb1yvwXITTdDXL
         adjngS25Sz6OqObOMrkTQ3n55BFjptC25rHi3tbYlxHpb/QAPkXAMHjQufOg98ZPtsdP
         ZmJWL55/y/X/GPQTVPC8ftxbTtzGkXOH/mXSzvSViETS0rIPTEiTakGICls9/qwQcTYt
         5lZ7ioKJr0iEdBsI416mHuVj01XkBeE+joI9LqhZaRlPVf1HmXgnEgno7yacinLbZ24j
         QozKYT6fnZiSuigBgXDMqLwm17cT+kGcm2MqFPwsu4Ii24nQbcNFQldg2SMKqI3QUHix
         Qzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753998998; x=1754603798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2nFxX91zPm+pyMYKRygXODZT3df13yCxq2wpuLKy/o=;
        b=Z56ubo+onGumOhfDbN+lB8xQl4kL7ulhtgdv4FKsHtLWYLFKnRVSFioFLVXhzKQt+7
         T3qpyLGhcreEGf0lJLIzXoQoQrajF4G3Zznyg71LaoGujwAoaCEZ+ev6WAL+5At4xxwD
         OrGDuFOmjQPeJfOA5EWuflKc+qsOnK27ZQI08oty+FavfvFnrKhAyYwQ9r7kMipzLRRm
         drJbvFniDsmfBZsdmdeh6IsJK6qTSNiBt8GiZq/HW1WSPL9NwCF6+zRi4qq+5tgorspT
         QqnDIPwtdFhkC98MUjoUiZTrnRF9eADOXnKBkRZeYokvoPhBHptKPjBdXS5p3gnoI9m1
         U2fA==
X-Forwarded-Encrypted: i=1; AJvYcCURnsBMoo74ozdzuYO8D9T9MXpK/sgxOKTclwZY+SVfpBE1CLBqWjhEp8Fi70XuqudympqtsI5jnRe0bgRS@vger.kernel.org, AJvYcCWjizAqSbe+RoSlirv77EfD1P9nPQkdOiwhgk27RIGJ8gpSj+73FLS21JOf9R5aZSWFddz3e82HOIXv@vger.kernel.org
X-Gm-Message-State: AOJu0YwChDsKXjj40b8Kp+kF9ZvXftLHL94boeBpvCfOBcxaCSkezcD+
	hJyDvREzTbWCaGBxIcsyxsogA+OuDwicZKQF1XP4xb0aZiDaHxnQ0wA=
X-Gm-Gg: ASbGnct0jVqCQICGHgFCFZcZEAHV0mCbfQQffn8gZmIui4eWhkinzqeJ2OuXaTzt6wm
	XLbxZPE2naRgqtT1HSvWxYS2d9gIE+b+qBn7juUZy/0Ypcbd4/qt9tGCJIgBM3fcrdUstabNNyB
	ACfezKBaTkQadGBMioKLCfx7N+xiWz12omQlLnTsDEyWYiHcEdiVHQheflfoMz2ZMOZIP00G7um
	HRzW+wALvIqxMqV+W07n69MKWDfxWrn0NtIbpSNY5VMAPuXvhOa9Bv3hLN/fYHMiUh4+3q9JIzT
	BMZO39iYWPG0f0Fal0st6zonR5DYUz0s2Z9yN3IqeBV9tE67yoC2w2JEJzQ6zcTqkMvKPV10oqW
	8KUaomS5xV3qQr1fhpcNW10yX4VP3THaiIb33dbZrt744Gt0GHas=
X-Google-Smtp-Source: AGHT+IGzX97L8ONWR8JwjiyIoXPw0KHB86wdgLoeHVWlbEMKLBZnEGpEo72inz6zGbfouJxZ1dZaoQ==
X-Received: by 2002:a5d:64ce:0:b0:3a4:cb4f:ac2a with SMTP id ffacd0b85a97d-3b794fdd134mr7035548f8f.21.1753998997661;
        Thu, 31 Jul 2025 14:56:37 -0700 (PDT)
Received: from alex-x1e.localdomain ([84.226.118.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589536abb1sm86622565e9.4.2025.07.31.14.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 14:56:37 -0700 (PDT)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: Douglas Anderson <dianders@chromium.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Subject: [PATCH v2 0/3] Add panels used by Asus Zenbook A14
Date: Thu, 31 Jul 2025 23:55:07 +0200
Message-ID: <20250731215635.206702-1-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add x3 panels used by the abovementined device. The laptop comes in
two variants

* UX3407RA, higher end, FHD+ OLED or WOXGA+ OLED panels
* UX3407QA, lower end, FHD+ OLED or FHD+ LCD panels

At last all three variants were succeffully tested. Device-tree change
to take advantage of Samsung driver for OLED panels [1] will come later
via separate series once this one lands to linux-next.


[1] https://github.com/alexVinarskis/linux-x1e80100-zenbook-a14/blob/master/0007-arm64-dts-qcom-Rework-X1-based-Asus-Zenbook-A14-s-di.patch


Changes in v2:
* Replaced guesstimate of delay_200_500_e50_p2e80 with more
  conservative delay_200_500_e200 as per Doug
* Picked Ack-by from Krzysztof
Link to v1: https://lore.kernel.org/all/20250727165846.38186-1-alex.vinarskis@gmail.com/

Aleksandrs Vinarskis (3):
  dt-bindings: display: panel: samsung,atna40cu11: document ATNA40CU11
  dt-bindings: display: panel: samsung,atna40ct06: document ATNA40CT06
  drm/panel-edp: Add BOE NV140WUM-N64

 .../devicetree/bindings/display/panel/samsung,atna33xc20.yaml | 4 ++++
 drivers/gpu/drm/panel/panel-edp.c                             | 1 +
 2 files changed, 5 insertions(+)

-- 
2.48.1


