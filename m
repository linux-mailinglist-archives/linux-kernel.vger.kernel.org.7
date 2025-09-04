Return-Path: <linux-kernel+bounces-801615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9355AB447A0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88BD01890790
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A247C285C87;
	Thu,  4 Sep 2025 20:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAbg8AFD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB72C283FE7;
	Thu,  4 Sep 2025 20:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757018682; cv=none; b=bsSJ4Et+ImAgjQYkJJkLbIGRQweGLOUccZwrvQm2o+jLbmRFNS01HzA7O3wJYqHUc4Ohl53JAl7reVKy5CQMMJAzyVkIwl3gEQgQm/CSclGfVKbq/3kVb0QtGcj8XWRXyudmWkzedmYr4dEQJOAueIN72PY7cvSKDgmWvUZi6Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757018682; c=relaxed/simple;
	bh=Dsw9PRMirZoaLF17M2hBwYns127wF4Tr8AJAlcOjpz0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kT9RKr30mBJFd8TpKbLECwnVZ1L0Q6hMr2FRqxM3ZyXtGh9x8ZPltBcK1iDBSBwJU0XX4xDXDAqcYQu4PG4pfEv/VMzU0uXHIKJZcMFCz+eQGHO2ZzU3SABg59gaCmU1duBcqvO37ux89hDmf30isGxfIa+p7/3F4SdOeO529UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAbg8AFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B4EBC4CEF0;
	Thu,  4 Sep 2025 20:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757018681;
	bh=Dsw9PRMirZoaLF17M2hBwYns127wF4Tr8AJAlcOjpz0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=aAbg8AFDMBMxLN8eMXPAf1G8zV4tUYLUCT/wQUnq/EBDKgHPmWsBWMPs4sxXkuh67
	 kEfQeLUmD/Z6h497s15j8gnpWXyV0Tc7jXprOOTKhV8ubX6S7p2S0Gkt/HNOQH/Kdw
	 DL26PTdC91zxzzBy7ZO0Gi3pJYvV3D4AoekaIc40EVFMtKlNkCPAoAXiPAF09XBuPg
	 Hc5GkWg349tcoPtxifizhMF5DpDKZFx9n5QlrMUoeU/GsDE/aqKEDtlhrG46TDpuFk
	 xhMiyyq+2RAVsK2urziwW0WeSxM455zc67P3P3i23YRQYdNQ0URK5O0ZEuGgq+h47J
	 3u8sNJqDBFvog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586DCCA1013;
	Thu,  4 Sep 2025 20:44:41 +0000 (UTC)
From: Woodrow Douglass via B4 Relay <devnull+wdouglass.carnegierobotics.com@kernel.org>
Subject: [PATCH v6 0/2] regulator: pf530x: NXP PF530x regulator driver
Date: Thu, 04 Sep 2025 16:44:34 -0400
Message-Id: <20250902-pf530x-v6-0-ae5efea2198d@carnegierobotics.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADL6uWgC/32QwW7DIBBEfyXi3I3wwhq7p/xH1QPgJUZtTASWl
 Sryvxf7VLVJj6PdeTO7d1E4Ry7i9XAXmZdYYpqqaF8Owo92OjPEoWqBEkn2EuEaSMkbtIMzrse
 mQelFXXa2MLhsJz9u6xdbZs7b4Jo5xNue8PZedcjpAvOY2e5ccr2higYiHUCbjqDvkCBwrxrVB
 Tuo5vTBeeLPY8rnjTjGMqf8tVdecOMKS2hYIoIhO4DukcEqVkCm99YPZlCof1K2Iovarb8PWxA
 khEYSO2mUd83J2+o7R87JpTn6cvTpsvX441TVqVEjm7Yzpn3i3LP142y9EQyaUP9aSfwPgR4Tq
 BJa6ryWitv6lieEdV2/AQ6a1Kv7AQAA
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Woodrow Douglass <wdouglass@carnegierobotics.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2194;
 i=wdouglass@carnegierobotics.com; h=from:subject:message-id;
 bh=Dsw9PRMirZoaLF17M2hBwYns127wF4Tr8AJAlcOjpz0=;
 b=owEBbQGS/pANAwAKAewLuLlPNh4UAcsmYgBoufo4eWMArFN4MqhM2GX2eWEiAKrsbl5Mzystj
 NDq3Un6lIOJATMEAAEKAB0WIQSIUqjrbDLQw0mgxHLsC7i5TzYeFAUCaLn6OAAKCRDsC7i5TzYe
 FAm2CACPxjHcf2RqLaEYzr8FjjWvTcCwTTlak4kVaAXhERlo6zC7nMi7KxzyIa+QSe9jsPdSKyf
 o/k8cMjRACbUdOBbuF5cJKkqaQjRlWWcvT8nPT4eCtxZhqrk/1czceZ2NOz+EsFG59Wyk/rT2zl
 5DJ5qjPtG9Q+Otg5pS3Uw+e5yC8eVv+zsv2Kch4yVTs82Nkq0GW3d9xI5jkQTjRW5t1lifjrtfr
 Lj2cIEk41PfgJt6x0n4xIsgEsyMko0whEGQ9o+ntjMkyn0TZqLNRJwA/5ypSaBwFVHN3Uef22w1
 z4+fDm/jspl5K1Vy/VAHsOk/5Py0cxjNtj3o/32TcXaeMwzp
X-Developer-Key: i=wdouglass@carnegierobotics.com; a=openpgp;
 fpr=8852A8EB6C32D0C349A0C472EC0BB8B94F361E14
X-Endpoint-Received: by B4 Relay for wdouglass@carnegierobotics.com/default
 with auth_id=514
X-Original-From: Woodrow Douglass <wdouglass@carnegierobotics.com>
Reply-To: wdouglass@carnegierobotics.com

I wrote this driver to read settings and state from the nxp pf530x
regulator. Please consider it for inclusion, any criticism is welcome.

Upon re-reviewing the dt binding, I realized I should have referenced
regulator.yaml, so here's v6.

Thanks,
Woodrow Douglass

--
2.39.5

---
Changes in v6:
- Make sure that the device tree binding properly references regulator.yaml
- Link to v5: https://lore.kernel.org/r/20250902-pf530x-v5-0-658c403e6a52@carnegierobotics.com

Changes in v5:
- Fixed compatibility match to properly fall back to pf5300
- Reordered patches so that devicetree schema comes before the driver itself
- Modified nxp,pf5300 schema to pass `make dt_binding_check`
- Link to v4: https://lore.kernel.org/r/20250902-pf530x-v4-0-4727f112424e@carnegierobotics.com

Changes in v4:
- Added REGULATOR_ERROR_OVER_TEMP_WARN to pf530x_get_error_flags
- Added EMREV to the info print
- Link to v3: https://lore.kernel.org/r/20250902-pf530x-v3-0-4242e7687761@carnegierobotics.com

Changes in v3:
- Replaced REGCACHE_RBTREE with REGCACHE_MAPLE
- Replaced pf530x_is_enabled function with regulator_is_enabled_regmap
- Added status bits from INT_SENSE1 to pf530x_get_status function
- Added extra context to info print upon chip identification
- Reworked devtree to not require nested "regulators" subnode
- Some minor reformatting of comment style and long lines
- Link to v2: https://lore.kernel.org/r/20250902-pf530x-v2-0-f105eb073cb1@carnegierobotics.com

---
Woodrow Douglass (2):
      regulator: pf530x: dt-bindings: nxp,pf530x-regulator
      regulator: pf530x: Add a driver for the NXP PF5300 Regulator

 .../devicetree/bindings/regulator/nxp,pf5300.yaml  |  54 +++
 MAINTAINERS                                        |   6 +
 drivers/regulator/Kconfig                          |  12 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/pf530x-regulator.c               | 378 +++++++++++++++++++++
 5 files changed, 451 insertions(+)
---
base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
change-id: 20250902-pf530x-6db7b921120c

Best regards,
-- 
Woodrow Douglass <wdouglass@carnegierobotics.com>



