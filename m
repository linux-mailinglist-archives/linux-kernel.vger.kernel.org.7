Return-Path: <linux-kernel+bounces-766258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E86F8B24464
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DD71AA45AB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867782EF654;
	Wed, 13 Aug 2025 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzdmfJOg"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B46C2D12EF;
	Wed, 13 Aug 2025 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074016; cv=none; b=A/7NzkG5eGEBQy/PyLFnFuv+xxZM8skNN5QQNQirKn99x+VBP5AiiuMmgPT3hkWjnHSv6ljf7kF7PtD2lxyQQ1q8iVAext80DQ8fP9tKZl6noGi7u0ui9JOz90/HnPnTVn6QlTokyt8Uz30XY8CHe5lOm9DNEGQ5QYW9sLlemLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074016; c=relaxed/simple;
	bh=r6Pn4FavBLGpo16RFcdQETEDvimR9cNcZh+43E6Wt98=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ICvhBMee4es8gMcOmJz5JJnEuQVUhefRqNYY0abC9tdWQqJzLa7f6qPpZ/d+zz1ijOy9/ufZusG3b5/xIFzYw56xmwzHbz8XHgeNyQtAcxQe4FDlAfOQ/Stqt3shMnNbyBiapiEGKdr+xd2krwesRIrfZgVgX/mFG0TtmU7TEVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzdmfJOg; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76bd6e84eddso7698378b3a.0;
        Wed, 13 Aug 2025 01:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755074015; x=1755678815; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JPDzkkyEE1PeddGvWneD5aTwEAedh3goCtrGQWQAwUQ=;
        b=PzdmfJOgTYDqgymP9ypX5GLmmQa4heEcq/dpYcLU3qP4jI9rDKvuU0u88oI33uZhIy
         2zgqUwJe43KrcTfEIBnam+JYaDjhbiv1YzfOQ5kQMfNjPfAFJ/XripKwKiE9MSoH9UPG
         T4ZBqnEsYulDA7P2SWDs1QmQBT98PRAZDnneSfDJnL6+U3B4bPVT5UGNOwaGFE1LAdU/
         ubcwr6E3rkiIiUAj9exjNa5jgDDzjgdN1RAfdIltIRXLNTNa0gYjzOMmEYl1rE/unal2
         lSPcI0AMISYpvBvsCMj9c1i0eRQIw02xzfsg7gYxQGH1KPW/dLdr4+EgvzUsB1H4MMJY
         TRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755074015; x=1755678815;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPDzkkyEE1PeddGvWneD5aTwEAedh3goCtrGQWQAwUQ=;
        b=Ww8vJNiInedD5q10O1unMLCIpCLy0h52ZnxgKEkKBz1iLSM300zfmKpVsgagKilJfN
         S3PFq3J0eW+VfnSpCc6s4UeA98eUPp3L/Zl6MBZHs5bJup9v5MdpY9WTFfj4V+SrBBE5
         RI/DAJMOPBKvzlafn3SE5KvWfDEkTLIq0RKiiWn/mk4Lf5Fy9XNvKSUWiWH8ETBc/k2O
         QrXSHjYmc5ZIgE4mFSWbVCSjqIGpGrgyJ6oo1VgAuUh6mnq7Kley1fw+m0IqJmWh0xva
         eyb7q/n2M8hpqbWOBUCBUw4ZD0ENUiRMO9u4xboIGT8Ud/p8//uSAYdsXR+oXXmKsVyD
         pY0w==
X-Forwarded-Encrypted: i=1; AJvYcCW8anUt4PrwlSzYmMMp6LKsHQiabn82R30E7E6NJpIv4R9H7Nr9asg2dWJD93VJR9Q9B7xzr1ilzAU59wY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+1MKZYSCRA9oua/BjId6BwAiqEm0UDSlbdoegpSEselrVWd4P
	/AhrOXBrZLSIL2hrmmtkG7sdXX030vumZvTWIA8a7hXqEZC+XKA7dy/g
X-Gm-Gg: ASbGncslZ5SfsJD+dEr2UFBavP0Xjy0j56tSdqgaKTiAaUEI8j+R8uPwMUp9r1/ddvj
	Ls6l1aL8tlMfKDWQiUgUYUykvaL9/R34q493jemLnuFToDQgp4ez4WyATir9u2Nw9dlObDOhGEe
	ksq8oVUsYYMG3fK+FCtOGv5rp+sI3ORXeHxpuFTpDjP/+YBnsEYK75GMxiFrF3ECXgcFbQ3akBF
	9Nu5nVCAR/GbG5gZ9q7Vf4sEKgblNX7gqSHvoaee0CGfkxfJf1Db0n0VmObV0VYesk7N139AH5T
	/RyG6TZF56Tq7f/bwfKHe9VpsmN5GFz4JqChkuGbIZcamWRakEc05WF3st8Kapd8HktzD20Ke/t
	Ebpf2YsgyT3mxoAow2PrupA==
X-Google-Smtp-Source: AGHT+IGMVj5qQgOEZF3d8kkN+1z3WSDn/Ir88GWROkr8GIB4WMLaFMX45LhxQA3lGXmOJzy4c16XnA==
X-Received: by 2002:a05:6a20:42a3:b0:240:1ae7:d918 with SMTP id adf61e73a8af0-240a8b8f9bbmr3831126637.45.1755074014305;
        Wed, 13 Aug 2025 01:33:34 -0700 (PDT)
Received: from [127.0.0.1] ([36.255.193.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfe50c8sm31307814b3a.120.2025.08.13.01.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 01:33:33 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Subject: [PATCH 0/4] Add SPI NOR DTS node for SG2042 SoC and boards using
 it
Date: Wed, 13 Aug 2025 16:33:16 +0800
Message-Id: <20250813-sfg-spidts-v1-0-99b7e2be89d9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMxNnGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0Nj3eK0dN3igsyUkmLd1FRTMwMTE0szy7RUJaCGgqLUtMwKsGHRsbW
 1AFUvfmFcAAAA
X-Change-ID: 20250813-sfg-spidts-ee56044969fe
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
 Inochi Amaoto <inochiama@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Han Gao <rabenda.cn@gmail.com>, Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755074006; l=1045;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=r6Pn4FavBLGpo16RFcdQETEDvimR9cNcZh+43E6Wt98=;
 b=+JRymJXHHVyT36A7Tp9FTHfgaMJLxh95vFfkRmpMEHXieKVf0ypJ3KaezY3uVpY51/Y6yJoFM
 N+tGbq15BpaBwiN75DAzUoL6wMYpQiBkPLEyWXLwhJcsugfSnzY6WNR
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

[PATCH 1/4] and [PATCH 2/4] are copied from patch set [1]
[PATCH v4 4/4] without content changes.

Link: https://lore.kernel.org/linux-riscv/20250720-sfg-spifmc-v4-0-033188ad801e@gmail.com/ [1]

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
Zixian Zeng (4):
      riscv: dts: sophgo: Add SPI NOR node for SG2042
      riscv: dts: sophgo: Enable SPI NOR node for PioneerBox
      riscv: dts: sophgo: Enable SPI NOR node for SG2042_EVB_V1
      riscv: dts: sophgo: Enable SPI NOR node for SG2042_EVB_V2

 arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts       | 24 ++++++++++++++++++++++
 arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts       | 12 +++++++++++
 .../riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts | 24 ++++++++++++++++++++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi             | 24 ++++++++++++++++++++++
 4 files changed, 84 insertions(+)
---
base-commit: 8a4fdd09c96f6713e6cb47d36e9f9dd6f6694215
change-id: 20250813-sfg-spidts-ee56044969fe

Best regards,
-- 
Zixian Zeng <sycamoremoon376@gmail.com>


