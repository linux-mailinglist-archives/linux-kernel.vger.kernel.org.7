Return-Path: <linux-kernel+bounces-897701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD040C535F1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D387135502E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F69342525;
	Wed, 12 Nov 2025 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/+OniD4"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED2527E7EC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963576; cv=none; b=uL00sVBv8zRIcbrhRMkoMzfIMlXkc0pn2Y9x0F/idug7EKg1/329WFY52fW9eG+T7Agt5t9IPKt9JX9UNbpeXDt72K4h4j/HJv0kgl1/uDWHiZdxVwlcwhTMFQGLjJZfDhCWsIPhWUBJlHniSnwqM8Pz+v0BNIVRlX7JMLcM8wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963576; c=relaxed/simple;
	bh=Tb8QWBachEzK293/rkkaGX5QoR2WIIDvyetwzLPF/dU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KlAjJtoXEqnyM6h5IOI0cLV0EW+rghFW3jTcIBqW5U97JE0xDiQyINV1NP9In3nBkpztFQidFDx8NNa9h2YmneJZKCipdvgX07kVWdkrXyqIRzP+CeqOt7IBlZTHmBXt/Hr6DZAkAldxxFp75JcbqtvrVBAHAEv6zD9ay8Z7VYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P/+OniD4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4777707a7c2so8125735e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762963570; x=1763568370; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eSaK7KjpsRpJPsoshb/MU55TLjeahDB1ks0unKYBn4A=;
        b=P/+OniD4oFPwK95EkkNwCjQ1gQLRbks1cLJYHWlMk+/oQamHe9jUPc+58MMhaS56gt
         XtymMPz1wdweGsTUS3w2+YzyPgjyBH8K0sZGFIe36AeFCMJOUL+GySQfs4Kd/S21A7uo
         UrzPBnKHilAqnsDb4lbNduIGrcMGxfncGplQGAiDsN6AuwC9UNxgcI31KzzmvFhd/EyS
         /VUQNU69S8zmM7yXIF9zkEXlXdOpzOr7Qoexf4osZN7UPznXuWf6y1vHKy1LAUaLBhLK
         henFRXpVN5BVFcwJ1ALl3qVoCGegF1Lk2IxaumIZJqNStSoZmahTIA9yonas/5N8bzK2
         LW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762963570; x=1763568370;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSaK7KjpsRpJPsoshb/MU55TLjeahDB1ks0unKYBn4A=;
        b=aPSPByVxJN7HYbDi7pZmlmg0AsmwZvnEsvIKzlGTU1xZQHM7Bqp1swH+kmsd6wVyQe
         q1TQekS6y/8KJEb5naUjBIt8rxdvjUlpaTww00BVQWLTdZnSfDjCUBfsBtXGJMcO49Un
         I23+uROVYlqu9IH+oCImW25jhkfVslhsCg7TQjrbOy33VAJURQhrgiOV11GP7nqj0mwV
         2VmLIc9i6K5udidaChXtRrrhpD9ahYqXtpMOv/sTRgz7ziFNAolYEVaEy/SuzadKjWtS
         IbyeKnBsvzaE2tT4OQp1ZHnKhcKurJw5lCC5En+uvPC7sjs6n2nhULCMJlW5ecm1pdTT
         8+Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWg6yFQONVrcxbS1W8lAOOqOY0q5MXy6rtHBsD1nYkXPIo4YTV7MU0qpslrzU2LUqQeB6EX+mvWDLiHO0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAkWHBY0Aa48XibYWxzECMSdMP9Pg9g4w/xMlAwrEvhJNwex9D
	IFFIN5N6BnP2h76BX/OOSSpzuuNrxXEpo6ZYkU5KkiWxCGTT3awuQlJ4dAiNGSomQIc=
X-Gm-Gg: ASbGncucLM74iDxuNxK8Blrew6BUbFH1HznR9jTZTPYA4osJupgj+nw49ZNXWo+5lYk
	3Iljv8x8kCvK4JfyIUSSuHto6DUgvj4hrCuvtZndVCIY/ws8ITxOEySuPHciZHnnLkBdXfekonW
	sMVKe0FmRz+PNvYa2vBbkaqIinBNolTE3JwdCgE8PxlaO4jCuMEX+VSB4Gi2Cp+di0C1mwtb3uy
	37AEXJxEe76obQn+Ef5G458pL9YFDxHU2xkBtNZ1zmTzHh+37gbTzZ5n25jzXXudzGLiUvpzBkP
	AVb0QlxWA5yMtEANtWeO9aEIze2IClgdHaAoz9vth3N+Xoc1YpDvLz7dnHQ2fT3naotVxd9Tpd0
	svenWae1JxYU9Cg9dV5tVpg63je7QQ283Za5UT+QZog0r83nnJo5bsqlu3gbC/5CoFMR4vFdaCe
	UHdH6sCY9NsZDBwEUV7THZc6ChjUlEoKs=
X-Google-Smtp-Source: AGHT+IG6rFzEcxKdldL8ZJSA90DQKBh2V/CJToGQI/q5NdQAalijEOc2BYKjbz+pmbmuHRK+JHR6rQ==
X-Received: by 2002:a05:600c:5247:b0:477:7f4a:44bd with SMTP id 5b1f17b1804b1-47787224955mr29777585e9.0.1762963570392;
        Wed, 12 Nov 2025 08:06:10 -0800 (PST)
Received: from gpeter-l.roam.corp.google.com ([145.224.66.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e95327sm41226855e9.12.2025.11.12.08.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 08:06:09 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v4 0/2] Add new phy_notify_state() api
Date: Wed, 12 Nov 2025 16:05:57 +0000
Message-Id: <20251112-phy-notify-pmstate-v4-0-717d78009d15@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGWwFGkC/3XOQWrDMBAF0KsErSszmvEkdla9R8lCiSV7oJWMJ
 ExM8N0rB0opbZd/4L8/D5VdEpfV+fBQyS2SJYYa2peDuk02jE7LULNCQIYTkJ6nVYdYxK96/sj
 FFqc94NUyd+iPrGpxTs7L/Ym+XWqeJJeY1ufGYvbrzrUGABEMMzdEhIY6jXp2xaVmTOK9hNd3C
 TbFJqZR7dCCX+V/f1lQg/Y3c+yhpd6Y0y+Dvo3O/G1QNeg6WO6BeRjoh7Ft2ydU4cJ1NgEAAA=
 =
X-Change-ID: 20250703-phy-notify-pmstate-f02ba5582f65
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 kernel-team@android.com, William Mcvicker <willmcvicker@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, neil.armstrong@linaro.org, 
 Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1976;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=Tb8QWBachEzK293/rkkaGX5QoR2WIIDvyetwzLPF/dU=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBpFLBvBMKx+UST6zAYRGgV+Ns9aJTxOwnsxasX4
 V/1V6CwXvyJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaRSwbwAKCRDO6LjWAjRy
 uqy0D/9yeYWXP6i5RIKwe6GIAI0BWoqhXoXkNenwExXcitTNpZk414r9TMsa1jqI0fj3A1TSesq
 KQSB+5+FFomF7mRj4i1z4ToYS8GlrBPBwm9JufqwjzQ7MTcN71JzReyMtUSEj9EkVFto7Pz891G
 YWK6nTx+MqgDJcSZt2+DnKYJheWutFMpQVD4R5jHWncVFYj6Qpvlh9BOq5upOiWrIuvmzX5rV5f
 ISp9AMu2FnLKjQhM+S7qEO5pPVD5zVPiRcAm6kcNTeX04ZFrm4fXiAouRy2YL01IbQx+NDtj+zE
 RjELefMhdU9ZCALKPu7TAA2AFGq+N/0jamQ2epi8DV2vXIB5hHtZ0ie166LLLjAwScov+pSQs14
 nmRel0AunzcRbXG0lCkKaMDKIptSLVygvTa2RpycBbGMuil7h1FSRO97whzFuM1d4h+pvArvwJr
 Bcg2TqI8pzc9pHTKv2TJbcoe0PzR4J8V5h1GOzkkFd9N2EbVvLi/TjZZmCNaoejmCnstvGYcCmy
 XjmZjy3wf7f+g3i2Zvdz/V4wY2R4C1p0u27OvTi97lSSMe7Tdx7Mmnwc0R7kCiVtm+nEjVcEeUj
 /pjAW2PupbeOjVQ80H+NZJ+snaJN+X6fmmhqg3wuTwUne/3+7LEeEOEBe/OI3/lFidz3Ep710z4
 dRvM7VGm26TWWMw==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

This series adds a new phy_notify_state() API to the phy subsystem. It is
designed to be used when some specific runtime configuration parameters
need to be changed when transitioning to the desired state which can't be
handled by phy_calibrate()or phy_power_{on|off}().

The first user of the new API is phy-samsung-ufs and phy-gs101-ufs which
need to issue some register writes when entering and exiting the hibern8
link state.

A separate patch will be sent for ufs-exynos driver to make use of this new
API in the hibern8 callbacks.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
Changes in v4:
- Add missing 'used' word in commit description (Vinod)
- Fix 0-day compiler warning
- Link to v3: https://lore.kernel.org/r/20250813-phy-notify-pmstate-v3-0-3bda59055dd3@linaro.org

Changes in v3:
- Rename API to phy_notify_state(). (Mani/Neil)
- Remove inline kerneldoc comment (Mani)
- s/phy/PHY (Mani)
- peripheral specific enums in phy.h (Vinod)

- Link to v2: https://lore.kernel.org/r/20250703-phy-notify-pmstate-v2-0-fc1690439117@linaro.org

Changes in v2:
- Add new phy_notify_pmstate API() instead of using phy_set_mode() (Vinod)
- Link to v1: https://lore.kernel.org/r/20241002201555.3332138-1-peter.griffin@linaro.org

---
Peter Griffin (2):
      phy: add new phy_notify_state() api
      phy: samsung: gs101-ufs: Add .notify_phystate() & hibern8 enter/exit values

 drivers/phy/phy-core.c                | 25 ++++++++++++++++++++++
 drivers/phy/samsung/phy-gs101-ufs.c   | 28 ++++++++++++++++++++++++
 drivers/phy/samsung/phy-samsung-ufs.c | 40 +++++++++++++++++++++++++++++++++++
 drivers/phy/samsung/phy-samsung-ufs.h |  7 ++++++
 include/linux/phy/phy.h               | 19 +++++++++++++++++
 5 files changed, 119 insertions(+)
---
base-commit: b179ce312bafcb8c68dc718e015aee79b7939ff0
change-id: 20250703-phy-notify-pmstate-f02ba5582f65

Best regards,
-- 
Peter Griffin <peter.griffin@linaro.org>


