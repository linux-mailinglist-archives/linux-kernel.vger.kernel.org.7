Return-Path: <linux-kernel+bounces-818868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAD7B5976F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00B616E5C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F7B30BF58;
	Tue, 16 Sep 2025 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsWH0cax"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353EF1D7E26
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028979; cv=none; b=MdMLXQTv/UIO6DrukSWV+7CPcUUXeRnytA+SkSqbSN0xHro1KPORmCOf+uIcYZJmWLV9VZGq7njhUOZ2tajlwxqsNCI2NF/Zx72JvPdA3VuJE7YZ+kaE4iG5meqTOZ2sh87W79IkdamzW379jJkhouniwNJuL3t5T15X66IEDLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028979; c=relaxed/simple;
	bh=CGgTSIYt63qsmZdwIds4EcFmwLudv2lGpTjjwlt+HoE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DEmea3COZl0Vn0rdaEi7GylnVeY7GGI+Rv0l4Duc5rR4jHSiPVOavrCdph65vfZowdQWr7kxfKCQqWyGmcKVECXFNVeKzapTCpHmZ2R0IG5JUCqLvFndiQFCOaxWvi7rKvapGgWuXsr65LD+hkpNyigM2A4OLANPPBjVK1wk9LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsWH0cax; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7723cf6e4b6so4220838b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758028977; x=1758633777; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zw7XcaE2r1FmXR6hLChylDYbe2XxfsRNzLzDm93R3xY=;
        b=QsWH0cax4TMKZdiLvUCIyzY4fqjKZt8EHxKpzPz/SUAiSJuQ6beaAf80LGZH4bsgtQ
         g1X+hJrqJLP5AtoC+poWv6JobY4IpqRKQzVWv2qZxVqABEbf3XbO1w22GqPe/N+AYQ4i
         fXErO0Gibuxks2rKXq0Ehi/jBbpKR+vCwKzCsnP7dprIIP/ucKrzR0/hV9GuuCzT7Ila
         EqwGXm1/RncIflHYEvu6LLyuPQu8Vd9RTBB2/71F6jYnig6yEREoQvaOv1R7BKxk6F+3
         Xs/eLXApa7Ni0/MKh5Ydpkskbi+2qGS/3raHIPkq2mnJlxNeBLvP+Ie1/l+DWYtnVNfs
         WbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758028977; x=1758633777;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zw7XcaE2r1FmXR6hLChylDYbe2XxfsRNzLzDm93R3xY=;
        b=MkBZJV3fnUpHo6EKizzFRaQHetlRwaPEmjlRwzDCg5ymnKdDZ1sroTWkLuisrvVDXH
         t7uYc+PRPdXZby+HMmEPVX7VXmGRWgmF0w7r5gF1Zxd+WJ+ortU+zRbCw6DnsOvDsGC7
         wJA1kxXDHUnexhfGt0FYq+1QW95TyGCf6t0ZwaDNsFe8RjYNuV/LycOGyMxes5G3lDfw
         1ry33008wQZ4yoRrPO7CJYRpEm0gfOlUYrsojFRfoTvuzGjMv0FJ6yH7dTszeTc1WSPQ
         vLIEirx9fEHbTn65YIBBdMHx2QdpdL7c3xiU9ink+qBW2Kl63q19JrOS+hKM5PjBpBSG
         Cc/w==
X-Forwarded-Encrypted: i=1; AJvYcCXWFpJZYjTb1EKoekiXVSRcDibrjq/8+f4qH+rdrA13rGjj4hxL1RhET3qqw1n1FsSVNYyVm/e5RKApAIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2fVVTl5znPcFBY5G7xHQUfWyyobzLB4Ypw2vB+AP5rbfROt0d
	D67XrceWmFB1R5+I0N0XWxQmvzvDQ++FaXY1WsovM0LVLc9c8ihzCLWq
X-Gm-Gg: ASbGncsRBa0SROQE3LsFKxCQ0hM9k0GBh3z2SLPBfUZrYHgU+mkQKoTNi44mqAqHlcm
	xMpVltmXm3ZHtfGqBDVcCU4qsZNoIoR9apPFx4Qfa98Q9Kor8pTHz49JcKmkAI4S8k+0qRY5yop
	kB6s1FnH8aMDVN3gDw2pec/FwkwKG2raI9Lj3m46YVti5yHPGGb9svbXmfdV8Oy/kl5q/FGDN1F
	uEqSm/bSBHfnnUY8Ly4KHciI+R/mK4j3SxHTvIZ0+3gAs5wzOZ6iDM0vAUQGquKtzReOaMrda8V
	IfUPeYfwqneJ4Sbzhi6F4rnFi7b8/14YR+cuzJTaQcBvgeIbUSB115bGLd8zkkMQnF4tu7Jd829
	4V2+3EZ3zlIncSWEAfsBN1mrWXQlpng==
X-Google-Smtp-Source: AGHT+IH8qtkp61xqbdRtMzYn6rP/97r4rWCE3eOFI0oW0kXWAEgQS9ZSayzpkellSCtSLE8uefRSpQ==
X-Received: by 2002:a05:6a00:8c6:b0:776:1804:6fe with SMTP id d2e1a72fcca58-776180409c5mr16008326b3a.7.1758028976698;
        Tue, 16 Sep 2025 06:22:56 -0700 (PDT)
Received: from [127.0.0.1] ([101.76.241.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7761562f25dsm13277310b3a.74.2025.09.16.06.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:22:56 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Subject: [PATCH v2 0/4] Add SPI NOR DTS node for SG2042 SoC and boards
 using it
Date: Tue, 16 Sep 2025 21:22:49 +0800
Message-Id: <20250916-sfg-spidts-v2-0-b5d9024fe1c8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKlkyWgC/23Myw6DIBCF4Vcxsy4NULXiqu/RuFAZcJJ6CWNIG
 8O7l7ru8j/J+Q5gDIQMbXFAwEhM65JDXwoYp37xKMjmBi11JRt1E+y84I3szgKxqmVZmto4hHz
 YAjp6n9izyz0R72v4nHZUv/UvE5WQwpjhjnrAxljz8HNPr+u4ztCllL5rQK5+pAAAAA==
X-Change-ID: 20250813-sfg-spidts-ee56044969fe
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
 Inochi Amaoto <inochiama@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Han Gao <rabenda.cn@gmail.com>, Longbin Li <looong.bin@gmail.com>, 
 Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758028972; l=1435;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=CGgTSIYt63qsmZdwIds4EcFmwLudv2lGpTjjwlt+HoE=;
 b=frGV+4xLcAYmFm8cXKHpsQaD0uBvclAaMVxAAhak1hE/IpCvgEap926nsl9BMP/TlwV0EZZ+P
 mFr1wUbMukKDMfYQpgs48Il27cqhMfYZvRtaGw2q/TNe6z0g4TVVak7
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

[PATCH 1/4] and [PATCH 2/4] are copied from patch set [1]
[PATCH v4 4/4] with content changes:

According to SG2042 Pioneer and SG2042_EVB_V1/V2 schematics, SPI-NOR Flash
cannot support QSPI due to hardware design.
Thus spi-(tx|rx)-bus-width must be set to 1.

Link: https://lore.kernel.org/linux-riscv/20250720-sfg-spifmc-v4-0-033188ad801e@gmail.com/ [1]

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
Changes in v2:
- Change value of spi-(tx|rx)-bus-width properties to 1 of all boards.
- Decrease spi-max-frequency to 50MHz.
- Link to v1: https://lore.kernel.org/r/20250813-sfg-spidts-v1-0-99b7e2be89d9@gmail.com

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


