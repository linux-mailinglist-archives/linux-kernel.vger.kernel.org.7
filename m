Return-Path: <linux-kernel+bounces-762470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D644B2070C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895042A2C10
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3752BE7D4;
	Mon, 11 Aug 2025 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="MpeiegV4"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AA32BE7B3
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910822; cv=none; b=G/H2QQXgRtYnMp+taz9AcG5EcQg7JbrC6F7+0U8V+Ai0AD3cYVQ+FhWw2zpu+uqvY6Dsx4lbljqJzaiLavafOxn5e2p4o9yKD+s/VkBTfY3Hsxo2Wm+ud+epwTrR2VlEdAZ0wO/85EtF/JUQxifxV96rai6bippjJtqoMJ1G6JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910822; c=relaxed/simple;
	bh=IteUFERyC3LLjXnKcbASB0b5pTZCcipeXnGOb9hHHf0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kxTcLNZfVmoImMgNo+bz6JtxO2C/NQobVjm7pHk2THIduTjabEjwFcDYJLnp2QEQJ0gelqXbdB9zPxWvs+Oil0GeTo6VjguXiJjakHlXoNXzbaKsBRUZ5Xg2gfmiecufugcGu8Y/3Tnncbhoz/oIm0fKwkL8lzEFrOAD62xv3n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=MpeiegV4; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6157ed5dc51so6447685a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 04:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1754910819; x=1755515619; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rI8qy4HURu1XEpiDm68Dqm4qhGh4Hz+ANesFdAjnAZ8=;
        b=MpeiegV4mabzOg7/9Svr9gGxq0YgL/3CBthUQ315+FmyD/EU07Ttg6hFqHVaXQ87G0
         yVgZzYCmdlMtgITJ3cf+qJdlPp4MwEbhLBN4V50/gZEV8w6R106oaldCF5cxHgEPQI/U
         hozS9NnJ2l7XME3Md4pawb3q+GCGilMpwSSW4FcXHev8AGpG+2tsIw0FeQ9iuxZdLwBv
         Z6Bh41c+Rfdj8ncppLMkqOwzAYpUuci656KoeXQ5Yq2nr3B/A+7g5Aci4rQXGimCQTDo
         k8Vx/P3q78XtnOy8COZhxTogB7uvZThUzmKo+/M2hbqRIhjVZh9p0jtkSfd513LOVqTw
         N1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754910819; x=1755515619;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rI8qy4HURu1XEpiDm68Dqm4qhGh4Hz+ANesFdAjnAZ8=;
        b=hdSX+cyGlqaId203sU+zUwTC4roZbAik85xzPXIFx1yR1R9usObOIiGYnDU86W4TNj
         hNorIbVXDmdvyeb9z1zMYIqBY4nCmK3rgbxNadu89EujeYgickRU/C7QVxKDYq9FG5ns
         H0zey2EfJLLyeqK5RiPrBz9D/iIE0moMWCkulZtR30s1dmvqg3cYjscfPgQcITX2pIJS
         AoHMJjBEFquF2iePP2BcczOHw/QEoYCbySDx/zF3/pQTdqe28kEi51cSjwZYnaVmhC/f
         8DLH/lcORfnKJHsqyS1/QHtd9LI1qFdpp/FOqISwx0jtpqTXYnckVtN4u5dzNMAFtyVS
         GQ5w==
X-Forwarded-Encrypted: i=1; AJvYcCV8d0Sr6zacmnWgOQ2FaYElVuLZvXfzFHVdRenQIadYl0yTCbRg+JURdCOsWSShOYdwR0XriGK7Ss4MlAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdC+efFMkfSrWOf4MYQsb3iVLe0CzRbFyCmbxjdQ3IS756Ap2X
	1mfrbFzmIMc8zKX8cwWYWzBsp+WMq7OTrMEkevE7wm5YpEyTAGVzdudPzj+q2M3k3/4=
X-Gm-Gg: ASbGncvIMBlG2ZZLeefTZwOiCuEA/g6n60tc7De+enyvqE3ajZrDjWW220+BNGx5MRA
	eieJvuEFvYEPcd8ENmHJCUaX3envlxXf8zy5DiSmD9PQi4oEo4TWnlwxk8TxS9OSTWNTfO44rAZ
	4THGISLDoadRcsjgP3Zfu4y2ZOYsIlBZrNZesLe29CrWBa9Z9OG5bbaBqKPnMDwJ7X63Ra2Z7KT
	pkZwBIR+uhKlMILeQHIOWstC8Gzr4hBmLtmvS4PrB35xH1M+Otk7rJlCpxlQ4EP4ltb5vakZYxU
	B3W//81Q7nY1Ufc3dFFudAlMavefFdaK3JTFTYMGBDJonGg/f6DrBykhkcDurkcC4XxBc0EhEvK
	p5XeOgHGcY/1Zruzk7oBi5WHHXi2TIBP21EzjAZsmdlgDyVI9/+m6MYxBt9B57UJwk1kSb+DAvK
	FYLk4=
X-Google-Smtp-Source: AGHT+IHMzaTMnoUFzm5ThvX3ZvXKmvvaip5im3KIpPyg4ny2jDuQ5DuInzjyOZyPMHnj8nvtXlES+w==
X-Received: by 2002:a05:6402:440b:b0:618:1606:92ba with SMTP id 4fb4d7f45d1cf-6181606c255mr6469667a12.28.1754910818923;
        Mon, 11 Aug 2025 04:13:38 -0700 (PDT)
Received: from [172.16.220.71] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61821e562c0sm2467278a12.30.2025.08.11.04.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 04:13:38 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Subject: [PATCH v2 0/3] Add support for Awinic AW86927 haptic driver
Date: Mon, 11 Aug 2025 13:12:00 +0200
Message-Id: <20250811-aw86927-v2-0-64be8f3da560@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAADQmWgC/3XOTW6DMBAF4KtEXteVPR4MdNV7RFkM43HxohCZi
 iaKuHtNVKnkp8s38veeL2qSnGRSb7uLyjKnKY1DCfCyU9zT8CE6hZIVGKhMY1DTd+NbqHUbQmA
 HkUlYldfHLDGdrk37Q8l9mr7GfL4Wz3a9PnbMVhvtgaywrWMkfI+U8rEfB3nl8XOt/TX+1oALD
 flgInRwZ9btGbZ71Z+Fda/2sXzCG+z4mXVbu9l1xSIiU4d1ofTM4j8Wi+XKGAdtQ87KvV2W5Qc
 dB4wTigEAAA==
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754910818; l=1519;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=IteUFERyC3LLjXnKcbASB0b5pTZCcipeXnGOb9hHHf0=;
 b=h/pHLl/o0HQGmPU+OV1yzwhLQnkVAznMNOs2rizQYz3UOp/uhETtHaMDmKk+EujayGBN2/tL4
 N7gIheldA0rB1UWVVil7coMepCSC9l03hZmOQEhAMFuxS5yb0Lof7ue
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add devicetree bindings and a driver for the AW86927 haptic driver, and
add it to the devicetree for the Fairphone 5 smartphone.

This driver does not enable all capabilities of the AW86927, features
such as f0 detection, rtp mode, and cont mode are not included.

Note: This is my first driver I have ever worked on so if there is
anything I can do to improve it please let me know!

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
Changes in v2:
- Changed title and fixed license of devicetree binding
- Fixed typo where the 'm' in 'ms' was excluded
- Changed error handling return values in driver probe function
- Link to v1: https://lore.kernel.org/r/20250806-aw86927-v1-0-23d8a6d0f2b2@fairphone.com

---
Griffin Kroah-Hartman (3):
      dt-bindings: input: Add bindings for Awinic AW86927
      Input: aw86927 - add driver for Awinic AW86927
      arm64: dts: qcom: qcm6490-fairphone-fp5: Add vibrator support

 .../devicetree/bindings/input/awinic,aw86927.yaml  |  48 ++
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts |  18 +-
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/aw86927.c                       | 841 +++++++++++++++++++++
 5 files changed, 918 insertions(+), 1 deletion(-)
---
base-commit: 3624e9a34b36d64a7037946eda28ae9599363a3b
change-id: 20250804-aw86927-9dddc32fcaec

Best regards,
-- 
Griffin Kroah-Hartman <griffin.kroah@fairphone.com>


