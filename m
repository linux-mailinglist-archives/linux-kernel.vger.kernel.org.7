Return-Path: <linux-kernel+bounces-780256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4BAB2FF90
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88BC4189194D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F14D2E1F1E;
	Thu, 21 Aug 2025 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbuG7NyA"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4012E1F1B;
	Thu, 21 Aug 2025 15:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791839; cv=none; b=fD8UWwWy64LM5WqVAF2IRuYs/cVeqiYNjWNm3dHqoZFdV7x6PJUvh1Ifs0pKw0Nn64BMiJs+uLbk3plemK8aDZMvD5aGNnH+QGsEj4U530vulBO7yxNF12bYNZsKXCe2AHt1S2M9e6j/s3B7lXOHxLnCNVYQmQJrKLLP5CIDg3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791839; c=relaxed/simple;
	bh=iUK4B/CmqL3+Q73zw9YIpvF6fPa74yfaI3WOfamJS8k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qR9GnOmUccb0zmj5EXQIiaUUnFvIGq+A720h2q8AYnRgFnkWP+yZOb+eo4fLfTniA9w4RIC6dyofwjqn+RJOzHqAmthiD2gidRFjXIa3IysdWafR6LX1kf6Ag+05bMBsU+EDwYq6pLIOouz+QFytAM2VOdo53h4t2OhuCTO4Z4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbuG7NyA; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32326e8005bso1344936a91.3;
        Thu, 21 Aug 2025 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791836; x=1756396636; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EqlRTlA4R1X2+J6LfIK/nlbcP+4L+ArUw8i4qlAeNpY=;
        b=SbuG7NyAGhPhxWgeK2bHC7ug7KlOJuuOigIuOnDiZYNNX1VNUVVaghCdfN6H5QVoua
         GjfYEfurNkU33Br6COuSRBvMdrll4i6jEC3g8WUf9dHzUGloFT8+8OU03f6dUegplysM
         y4GO44n39SGpwCrLbZ7i3F5E5ckgIaNXcr0tTaK8udQbC0w4+QhgsP6kW9qPRYlPS985
         6M68hIYPADE9ZXkeHo29YNVYi28PYA84BDTVzBqR+yTwkq5GLzyDjSw+g472b66m7fwu
         4AsbP/tOAIk95eT2iNtjUCUhHa6UWMG5YZtURPmj5lPNUZNMhzOI5tMXMOU+5lO52AfE
         AHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791836; x=1756396636;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EqlRTlA4R1X2+J6LfIK/nlbcP+4L+ArUw8i4qlAeNpY=;
        b=GwIsLSQm8QgsBQES//R2s4pI3lyDBWmLSYHgBFgn3/Cp6G/Ayfl3FMvhjbRe+Ew77V
         2VgnUjMEv8JiBkegvXbQKArP/+d6bqtyXsaXLAKpR8bPSAYkvZYEGunchqDX/QulEthn
         azkIndCKx393qPmlZyv8tfwW9lHOl1ta2pCPmeJB/fvCuZFIB8fvCCWYjD6B5pRkSHbk
         o4l3OFjuqxNbl5DAJUGEIEC9Z7YAfWCDQpn3A2jh6VaGbOthFfHbu8v7ZpwRU1qWP2cK
         Scz6RxN65kAgHb6AXC+MqI2PXwi3KpeGXmcsH6nzRfdFyC134BfGJm0Tw4QKo7F7MRdZ
         NZ1g==
X-Forwarded-Encrypted: i=1; AJvYcCUSQSAu1Vy62xRrfTgPDfmRHabRjjvQrLlZqDaIs1EFv1huonKwRIvkzlILH+l+pLSkUyQt4WEaJ06B@vger.kernel.org, AJvYcCUjQ/kpuqyNEmaGXwl2eSdC1gBUXwTmsBVZZE1+BnpmQpGOzgZdM1qx3hoW7iliV3Smynaq1MUQ/utWSkFh@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr/UA/EnPT9BVX5d7D/RW2VmGGMIt6u9yAKYe/mFw4teMFwMv+
	V1INZEWMO81mkJnnNuc2kkMBVjX7t4u93wr+NNmJLhmeQybPJ0U0KwQy
X-Gm-Gg: ASbGnctaygFEEqrj63lUg1JIHZxLqdCSFgEhlLEkPUQFh4UzWLIaydyDbJlM0/kIsrj
	yHf0X8Ny6zwjN5yfGASx8CSCzFhSzMRVB6mgRlNIyhP9NF4TffUYd869MlX4H7+qjafDkWpIDSe
	s0sLJfgpEq7xMWb6S8nB2XTQowIOz1VDmD7h8CpFrhCEc3s+vE1Dej49FDlmJ0o/LGQi2tUI4zh
	vsK7r5mJfEZCq1u4/s/FTPmLvlsLdYrU8tzTO/5aK9afoMQJxj+p7KiWyJ2xb15Iw9bDkMqRu8a
	NdYnOdksVok/lj6uxM5Zw+NLht/jZOxpjtiy6YoITGljmBG5zIi0VFVr731xId/UIA9EEZW4dLv
	haAafzNUv01mU2RABHvihLEK5ZtnzZ60arofbdkf30fFhqzc=
X-Google-Smtp-Source: AGHT+IGY/0LdDkG3WlHhoiU3i1jzAfuDrGRNnzLZsjyafdBsIPbZDEnKdNCzVy+LG9syFh6upBaBLA==
X-Received: by 2002:a17:90a:d404:b0:312:1d2d:18e2 with SMTP id 98e67ed59e1d1-32515ec1334mr26076a91.20.1755791836352;
        Thu, 21 Aug 2025 08:57:16 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:57:15 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v3 0/9] Add support ANS2 NVMe on Apple A11
Date: Thu, 21 Aug 2025 23:56:37 +0800
Message-Id: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALVBp2gC/1WOQQqDMBBFr1Jm3ZRJNBq76j1KFyEZdaBqSSS0i
 HdvlC7s8n14j79ApMAU4XpaIFDiyNOYoTifwPV27EiwzwwKlUaDRswGpRZjGkjUhS1b563S3kM
 WXoFafu+x+yNzz3GewmdvJ7mtv4yUx0ySAgW1jVOIVJe2vnWD5efFTQNsmaSO6t+DpLJa6ao0z
 kvTEB7VdV2/kjB/D98AAAA=
X-Change-ID: 20250808-t8015-nvme-73a4fcda25dd
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3117; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=iUK4B/CmqL3+Q73zw9YIpvF6fPa74yfaI3WOfamJS8k=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HOLQWhVWXbaGc0BzFZVP9f/db2mKxsmWbHT
 9Fs8JqKVcKJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdBzgAKCRABygi3psUI
 JEpREACw1A07RdsR5Kch8lz/TYoO2c2/cr6rKNdpFHUNRYoKSVzpHzJq/CcFTMSa2dygiXmFfqS
 Sj2mZgt8ht24uJwjnCb57ETwEovCfCDGovUQNM4AiLK3VPQIvWNNDwzPVd4kUUozSoDwNCJm1lv
 zLKjN+L0GUuMCSJDdybD3oKpeKJhW6xc7szELbdh/f4S2BtKI4NL5U8BKs4a3NDxJI9nt1dmj9o
 5pR6USYp/56avbgcDjzmxxpdMqjdSmvzLArJBdFn5JKIXLKfV+VVRkKVmq7oWTmPJJx67mN12Pl
 LZZTgJMtSxvEJAwLx33rXs+37v59BHH7ZA+FBW9T8h3tx2Yw0ml/nKcVHoH/7fUgNYh1lEHHENS
 LBghUUrpEKW2JnFzkT+oXQj0YWkaj8zoCOH+SbEy595B/274nXqoEflHWbaTibgJulEtHSBa4rX
 1aLaJqA0WcJmlKNt3+m0wd1zwOamCqhbe4Dbw0j+AwiGo9ok1aRQ+EXlPF0Edbc5HBhP3tKhGIt
 tzhn9rFqwuQTgHwapzdeZ6RYQ6NTaQIcDdFkROyd9g86X6EhWqJjcifwLYKquolcPqaQJnj7q3V
 iNs5ABIsDuxlumXhSAt5KknZurOdsAP4n4oIQc43f169Qk8bsJSQZNaR3CroHRlDlIV3ESd02zn
 khOxWVzrkMWUlkQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Apple A11 SoC comes with an NVMe controller that is similar to the
NVMe controller in M1, but less customized. Notably, it does not
have NVMMU or Linear SQ.

The controller is wired to an older variant of the SART address filter,
and uses an older variant of ASC mailbox, so add support for them too.

This variant of mailbox is also present on Apple T2 SoC.

This series has everything required to support NVMe on Apple A11 SoC.
However, due to RTKit protocol version support limitation, it will
only work when booted with at least iOS 14 iBoot.

Tested on A11 as well as M1 Pro (to make sure nothing broke).

Patch 1-2 adds support for the older mailbox
Patch 3-5 adds support for the older SART
Patch 6-7 adds support for the NVMe controller found in Apple A11 SoC
Patch 8-9 adds the required device tree nodes.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Changes in v3:
- Update comment about enabling NVMMU and Linear submission queues. It is
  required since T6000 and much of the comment has been removed as it was
  stating the T8015 (A11) code path as a possible alternative.
- Make sure all the code changes are within 80 columns
- Simplify apple_nvme_submit_cmd_t8015()
- Remove unnecessary cast of of_device_get_match_data()
- Use direct function calls for command submission
- Use existing enum in apple,sart binding when adding the "apple,t8015-sart"
  compatible.
- Link to v2: https://lore.kernel.org/r/20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com

Changes in v2:
- Remove bogus command_id decrement followed by increment in apple_nvme_handle_cqe()
- Split apple_nvme_submit_cmd() into two functions for t8015 and t8103 since these
  two code paths were not sharing much code.
- Link to v1: https://lore.kernel.org/r/20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com

---
Nick Chan (9):
      dt-bindings: mailbox: apple,mailbox: Add ASC mailboxes on Apple A11 and T2
      soc: apple: mailbox: Add Apple A11 and T2 mailbox support
      dt-bindings: iommu: apple,sart: Add Apple A11
      soc: apple: sart: Make allow flags SART version dependent
      soc: apple: sart: Add SARTv0 support
      dt-bindings: nvme: apple,nvme-ans: Add Apple A11
      nvme: apple: Add Apple A11 support
      arm64: dts: apple: t8015: Fix PCIE power domains dependencies
      arm64: dts: apple: t8015: Add NVMe nodes

 .../devicetree/bindings/iommu/apple,sart.yaml      |   1 +
 .../devicetree/bindings/mailbox/apple,mailbox.yaml |   7 +
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml   |  15 +-
 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi          |   1 +
 arch/arm64/boot/dts/apple/t8015.dtsi               |  34 ++++
 drivers/nvme/host/apple.c                          | 196 ++++++++++++++-------
 drivers/soc/apple/mailbox.c                        |  19 ++
 drivers/soc/apple/sart.c                           |  60 ++++++-
 8 files changed, 264 insertions(+), 69 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250808-t8015-nvme-73a4fcda25dd

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>


