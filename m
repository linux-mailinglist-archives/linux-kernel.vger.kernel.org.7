Return-Path: <linux-kernel+bounces-762766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C0AB20ABB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2DD317360B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778FF1E1C3F;
	Mon, 11 Aug 2025 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyvm2GyW"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8181A5B8F;
	Mon, 11 Aug 2025 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920281; cv=none; b=DSThNYcZdVcH1SV2QNHTCm6mZSae0sU6bn72BX/aJ+FLy+iWcQoVIf574J2vaDOvXnYm1uqEVxPvcGIrMPTqB3Y/TpvSP9FFo7jM8IEaziwOF9l970KB2hwLpVsQBz055TRnrnaYrzEca2x/k15cy7JbjxxaEqslrVNQqe3dP90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920281; c=relaxed/simple;
	bh=Oq5GQuC/JNsViijmu3PLBEoA7oCG3f8Cu1LxMk/jNbo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Fh6F2ltG+0b65hCeCGOZydin3s1gOQYRBrj+APABEVfnXw3/XE5hIp7TWqLVanySE64g5lUhK1cpFHuzo4BGbZbRcGTntTuadZbhAVw/WCMvFCvfxA/NQ57lr9/zLses+zNo2p7WyqlsdaTnzt9vLl5IJlWklVFw7a27opt5q1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyvm2GyW; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76bd9d723bfso3747724b3a.1;
        Mon, 11 Aug 2025 06:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920279; x=1755525079; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nklRgqEsHAGsTa1ZY+Tu1pfGAj2pLA2XYPvzJl54xAU=;
        b=jyvm2GyWgGJ/r+Wo9AwFJtuo7PvKgChZLf2mrIpmLM4Z3L3AfaKafgp/qWLUzxf9Hl
         mkNyT++6qFZe3oLfotqOtIco1qR+jzPhJm+2mmeHxGE2OK7yg9h1BXV5c4OV+ihpk4jd
         vRYasbKR8+aurOW8mbPF8pbErnTJZDL+sEgE6urFMJb4QNjRZb8SOYifaT/JYFLsbvl8
         EVizZ7/m+Y1OOWZopgptJS5rAnCPr98eoQ/LioIjWH4Pv0vkkKLNRUelIWHKh+xSqROK
         iLPeAG6GxbQxyauZke5a7RH3/6keCUY6r4SDnL2z+fw90aFzwVJ1mNDK0QbBgaRUWe+z
         RSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920279; x=1755525079;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nklRgqEsHAGsTa1ZY+Tu1pfGAj2pLA2XYPvzJl54xAU=;
        b=pwF8KjpbYUVHNWEFJLyV1ZLfHjiESZfg12u5divK3rpnSl5jr2GiP1BDda7h1HSX1i
         mmL7yd5hMq37bn0yCjjAV2hy3wiOAH8klBtQf5WsGhpOLbz9XEb4zamGm3meNG4gF7sm
         Dcv73qPRT5Y/vNXGTfT9OPFr14D5YeaXWTzB7TxhNnflHUkDmUR+5ezVYQDGRk1ov+ra
         2jmpDrXTV/FJ3NlNDa2wlo36SVlLTO9VSS5uGsksLNe5HkY0ys5g4rJypqUrmHng/5fX
         ksCBt2T+VcrRP7geXKVI18Kna6wtNrWERWqlYxkxtOtcgLTAFPC6CXe7ZhFLR2WdyQKv
         NGgA==
X-Forwarded-Encrypted: i=1; AJvYcCUYoLfztPzPaze/Vff0SlP82Sl9uaIk3FMRqn3c4YR5sll84D75Cdsn05KdpYks+KPNKvzFv58S+Z3G@vger.kernel.org, AJvYcCXlwBl+9GTvtcYRsAqNbxW0BfJt568Q4pY25G2gqIlxov3JBnDYhkVZh89tYBm3CkBR/DcWEsBgm21cK1lj@vger.kernel.org
X-Gm-Message-State: AOJu0YwD+b0V7eGlL1Hsq5qNIL2loh6XrYfXQbTLojYhezPqoMCTHPwy
	/QkIZIlrLz5VHOGLHMsXHDWLsQRXwcjR4w83ibKr+XPqXjcIxOGeZsZ5
X-Gm-Gg: ASbGncuTlgKxaVhCne8titzu+DDYWCUlSa/GRsq4vyY86a4yrfgdh8k1iUtS3INUR8f
	yI88/mL3Lof5WN2QzH9rI3L01lUXMWs5391eWV91dNGMDub6kWv1kM1NbH6/0Y9XJLKm9BWfAkO
	CswGU4XqGXmBPG9lghiWUJM/1b7JIhh5JYOHNd9g4VAHHEfjIb0JuXghm+pcfdet2IM3qd50Et8
	/TfM3l4NfFxhoU0Pc3NTiC7d2KKrwK+oSn2JqoYlCFjovgfbZlMdDeEqmAa4B+kxsIix9/s2PHe
	mCKYjBYRJD3X88qoMGBaULg4/8CL89M7l7cHL5L+aaUdlP6inmvEtJNL2spliEP6Vuw5KIJUGfX
	kWnkCDbKJQYIJaoaq80RjY7c69vBeOYld4+HRIYyEI8RoGWc=
X-Google-Smtp-Source: AGHT+IGq94mROq1kQp74KcNsr2aCVZFxAFsqWWVl9F1p61/0vbOTUbqwhFkFA/aTivlG4DM2EdN36w==
X-Received: by 2002:a05:6a20:729b:b0:240:1b99:1595 with SMTP id adf61e73a8af0-2405503b294mr22135196637.17.1754920279511;
        Mon, 11 Aug 2025 06:51:19 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm23504993a12.15.2025.08.11.06.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:51:19 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 0/9] Add support ANS2 NVMe on Apple A11
Date: Mon, 11 Aug 2025 21:50:52 +0800
Message-Id: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADz1mWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCwML3RILA0NT3byy3FRdc+NEk7TklEQj05QUJaCGgqLUtMwKsGHRsbW
 1ANwFyztcAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2166; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=Oq5GQuC/JNsViijmu3PLBEoA7oCG3f8Cu1LxMk/jNbo=;
 b=kA0DAAoBAcoIt6bFCCQByyZiAGiZ9UygSJFejRzKvKje7erg2v7F8u8vJytX6bwLURWcvnxWf
 IkCMwQAAQoAHRYhBEtSeHhcl6z3nDxogwHKCLemxQgkBQJomfVMAAoJEAHKCLemxQgk5wUP/3Z+
 IKj6xYJEcai6WXIyhJi7FDyM77bltJK3+PIULBiRtdPo3V8TS7z2nCxFh2D/Om27QtBouxTNhfo
 LZ3JI385XvxrLVy+yrTGJkatN1VQU9Oom7RLzD/pip0MwP98eDlQboPFagc9tg1dHlUt7IuON9/
 /C4vjiAs+1yI+nTTt2p+tbxRE+MSvzjSvJm74RIuHWqYMf9KLb+QFJ56kiwL7P5N1ZpwNyBDoNP
 aYftDDeATWxKvtrhDjTtu86GMny/seIBA7dPAYL2zKcJvIQtm6OmPk9xD/NZylp2zh0SmjpNANA
 TaypNVSb8nihVS+e/c8KKgP9IWkmZOOU3aLXjmANOZtHuMZDH8cFqhMH8Zrh/BcobyKU9YbWqu+
 PlhglO1RC8nNDewJgtl+SHi3l3Rcapf2F1BIDui0QHtuTdEyBCGYscMTU5cuRHmIizl1xvsoj3r
 +qa/SRVfFLyAkJMR1nKzj7esueepkFlFrBy18zYroSKP2npoJuj82i1Xe+4gUpt/3WWdzZ7uG5z
 vjgqILbva16rbaTo/oT4cF1tGc8zlmkhD8KBYVsZVkYhx1ngmh2wgBET6fFTwnG0wTb2B6plO7R
 9TJ9wp4oDLPvERdEW6ohG0GwDfJFpra9woRWnUeQOj4uzZEBknwQVy4KFitG887WtsOBScs3gw+
 OKeg6
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
 arch/arm64/boot/dts/apple/t8015.dtsi               |  34 +++
 drivers/nvme/host/apple.c                          | 228 ++++++++++++++-------
 drivers/soc/apple/mailbox.c                        |  19 ++
 drivers/soc/apple/sart.c                           |  60 +++++-
 8 files changed, 282 insertions(+), 83 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250808-t8015-nvme-73a4fcda25dd

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>


