Return-Path: <linux-kernel+bounces-808815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19800B50511
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98E24E8444
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC55A23506A;
	Tue,  9 Sep 2025 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SJx+rwUX"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CA0241CB2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757441741; cv=none; b=CbzByGOi+3slcIeqfwS+vqED9PbsjA7ohvV42HJ+cy9CW205I0TE/8l8ACZMz0FmSV7hjhctP3SmN2UOFs07gAZZNuQeWu6ibgcUvsu87VVpTpc59HSxsxlCWQBU2V/In8ezQlbyUXcVdIJePB/aDCo8Vp6HdmW0lXLwFy+LUnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757441741; c=relaxed/simple;
	bh=exedlLvITN9/vJuP/FdvPQYmK+plc+a+7q/mF8fe0Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VGeRDLZwQFLL1URVWmTZK2kbTGDwE6BuggWdal6AL9XBfXirSYNMIkFPyTScUdFxMp1R8Aib1O2Yxr00tYWFzFXdFb9MQXk62pFahthbS+XKGmIiwetTBY+R3qH0noG70FN8NSKQBxqDFv62+9dI+Sgh9fAcEK5spoFHEfZxS2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SJx+rwUX; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-629f06935e6so479384a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 11:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757441738; x=1758046538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PBCxs/7M6xfLd9qlHkD5LH9iyxl1Swq15DboEeeZsxw=;
        b=SJx+rwUX9yfiFAj1KvSatqaHGWybiVxCPqPIKejl2InOLkeZ9kZveXI2eHfGQI4xEL
         pOPndjqweUopNU6dDpQZN6fx3l/A4cDTnBp/6JWgQ0yWlWMiQNzhJEdhaQQbHHgUOheY
         qH9jriAEFsZge3tn2c3N4aJB2moWhbYKCuQJcYd4v8j9xYbyEmVNPMX0prCmN+vexkRR
         7jdjrqqCeg0c+D5M5nF4Qun5VsShKE3k+Dk7fc3fbkDJqnfcoC3VCXy2no745HtGDzbJ
         yblSmUStSmeMP6rO/u6ZzewdLdxrw/7HCgE/pZV3AQucIQ2I1I8qxpMvX63Gfv4UVm5I
         I2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757441738; x=1758046538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBCxs/7M6xfLd9qlHkD5LH9iyxl1Swq15DboEeeZsxw=;
        b=m8GJ0h9cTeok873od/DGSZSAstrcQWT/Y4lMsW+iC9CTSAOHiOyWRz6OfB3p7QvPmb
         3sLiKaMHVkVG+8ckC1kL1v/7Mxwhjat5d8/KPww/07GKCgRTS93ZUrsuVsdUmwaQW8qn
         pYm1ewvOf0llFA0NIhb/KTRmfhVS2us4GBorAXBux9/29OapTVIeNeIAwpd2HNO6FEF6
         VgTrszKg0biYMCEeppgB1wh7L+/BKXmMbTgNQeDMAx62Sf5kTKx/fVB/B0zTf1MZNN+D
         FL/Fdb4EkTybUfi8TrTrj0woldwWeSBDJhyFdxYiHhTv3i8GhXgaHJxYUCG0vbIKC1sm
         YeDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM/s3w447VeBUX6gfgoxCjY9D3UtuUJzsSqZntxLpI9PSn59PTSOsk/16ythI9udvTkvkwUiFGOxqKU58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3lJXSRxbHnZG65BxxvLMPnGLveBM93EAxZAmoQ5mj32XTa6/0
	oc/UqdlGZtDi14bMBXP/d8Do1PorWa87ipec3bCPd+wVs3Ta7vG8N3u5BA7AU/ngv/g=
X-Gm-Gg: ASbGncurLc8+dcFHGX6/bkxEUysZiXnERtIJwlDXacJknOv4lhHivgE/f/I5gzmbdv0
	g3nV1gyb8VpAAiSCnA1lxSe/9b5mTfJ4OeVCQvBiEQhpleZpZEVcOSh8jgaomhLxSjgVdccNtSz
	Qb4JdUniwXjJra/OCKQlRoSzz3Dy5TfdLXEoS8t+bNgK7g0G677x3Lat3roVdUTbXapQJieZyvQ
	knSkeoGPHli80gSKoHfPcxuxyhSyT5mcXdvizD4UAyHFfj1Vefud/GurCEB6hzcMZR0Lp1QiEMV
	LThLAT2l0hlUE0pcfRLg+8sk22ZkGBTia3LSfXks0hcLPS17eB65lHQ3u93GWWQHYiJRcU31v5L
	64/6DeevoJTQTgB37Eezg60uHc8zn3TD8oQ==
X-Google-Smtp-Source: AGHT+IEQ2F6W6lJU+eKVYT6fItRYtyC7QmFyKhp/cnqaIUUNWUC2CzeosjFeorX5cB5p9TcCDGLQEQ==
X-Received: by 2002:a05:6402:27d1:b0:620:1c6d:e6dd with SMTP id 4fb4d7f45d1cf-62374d5900dmr5618009a12.0.1757441737628;
        Tue, 09 Sep 2025 11:15:37 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c018f90cesm1602669a12.44.2025.09.09.11.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:15:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] w1: drivers for v6.18
Date: Tue,  9 Sep 2025 20:15:34 +0200
Message-ID: <20250909181534.101604-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=exedlLvITN9/vJuP/FdvPQYmK+plc+a+7q/mF8fe0Yc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowG7GyliUoVu7vT1sEz7Pbhge0UD/+CD7MDP9h
 1aH0PHxCaOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMBuxgAKCRDBN2bmhouD
 1wKXD/4k6lD7uuTvL0XA+u61RPpFFKgJlplhs8SIN7DsZvU9gmMVkb45MfMMgDt9OKH79d0gMFZ
 EX9AMtBNfObZOvGEA3Muv8QPwXll0qTgFAhQMFkYAMFrFtgHAe591RdTjxNUCqOvxzscvAh+AYN
 NVjayZ1kNrXcjuI7DlHCBMQnxvOMfXuWhOPKTgjIyDE6sRbt5W0rO7CHL4o3JklG+e7Hkq0iMBY
 kciAWxqZqoIP2m+cZqcfP+Xni1pQEpJ/QObQHC8vpxXZ3eGiBW/maYqM4YPOdwK6jbLX/gv8Z1j
 TGvwjowCzTx924c/X3YbR42kXZXp0/UhhRHUs78JCtxw1Ayuil5O7DVev+1xiJAjzQZZGcpkz6Y
 rJ7MSre18eBE3NfO/hD0oADXQxkEJXNJcEUsqpaIyq2vm6HU+B61A1IP0siYz4unQ8tlefaHDEB
 gzJ3TjkBqgWlMaap+3d0EMMnGTR++Y5+dprK8iWp9iECorqoRX+ftALByLZbZ+aVU+6tBqyKTsd
 23Y0YxM+wt47hqUAZg3UllJSTZGcOcDSCEXVb6VgNZ11SaCUiqJQlqk8y1IMlupbgXYm1ZMz/5V
 FraZxTWbEy6qQVttswpQ3hNhz+jeX5+LQ6E+NUV5OuNLD5vkwn4iQ0kw37xMNGR1WIhX7+ywVq1 T6gvSItv3UUpxMA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Hi Greg,

Just two minor improvements.

Best regards,
Krzysztof


The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1.git tags/w1-drv-6.18

for you to fetch changes up to 25fb0ea986dc10e05f3f4b43cabde4d1853a1fd7:

  w1: matrox: Remove some deadcode in matrox_w1_remove() (2025-08-31 14:14:07 +0200)

----------------------------------------------------------------
1-Wire bus drivers for v6.18

1. Correct missing interrupts in IMX 1-Wire Devicetree bindings.

2. Drop old, dead code from Matrox driver.

----------------------------------------------------------------
Christophe JAILLET (1):
      w1: matrox: Remove some deadcode in matrox_w1_remove()

Fabio Estevam (1):
      dt-bindings: w1: imx: Add an entry for the interrupts property

 Documentation/devicetree/bindings/w1/fsl-imx-owire.yaml |  4 ++++
 drivers/w1/masters/matrox_w1.c                          | 10 +++-------
 2 files changed, 7 insertions(+), 7 deletions(-)

