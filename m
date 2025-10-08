Return-Path: <linux-kernel+bounces-845789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89672BC61BA
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 19:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13EE04EEE00
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488F92E8DEB;
	Wed,  8 Oct 2025 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eT2VyTtr"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C10F296BB2
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759942751; cv=none; b=C48w4V+OypvPG2w1vuRNciwhjfk6yqtyCe/YKsoxTo5tOFtB5ilp/YcmGe4cYVhnpAlnT32FNtavXEzu2hHyKCN8d2qNhuOEk4VIm47WGbAq3RvvHDPv32Mz94eFUJ2b3nZ2zdzzKb+t9QJOnxYcNuWjppjzOkxa1YAYRimDiF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759942751; c=relaxed/simple;
	bh=EDWxqw5QNYzHrwx45orjrTUijA2yUz1/7tchnihFHRk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=a3crN0pOG+nMLw6G1zCWms4HFj7Sv+sEjwbPGhskgiiuL1Gvx6Li3znYVQCC5ttOYgz9pIKc9ShOHQxkHVRfGq7hFGBu0itNMoUs9l5eihBoEzuUgl/aeAnOYMGrjI/QShkRm0V9/30cL1rGjscJyIYO0Qz43SiSJ/fUSPFY4cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eT2VyTtr; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3b3ce7277b3so53047fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759942749; x=1760547549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MLcuhnYdeS//vkM0RdYjN2OKyaFw6ciE1LlE+RBNKiI=;
        b=eT2VyTtro+fiTDqSFrAm7xqVqRqT6Wfdez1s0W7GLULUsxn4snpKPkA8AavTMkfm5K
         IJ6gCPLIH47qJUeICBZcVGMCIHG2GKVVukXJT2TBzoYKUfLQQQZQlLsKPnUCW+YjofGv
         Q8DPvjMbOkn2wYM9DcUJFu/CucD5pPKTbTQsLszuDhAWxV3j6unybA4RPzNkkutcziYb
         2UNG0GN+QdoApZ1VFPXnWDYcgTLmEUExjfuR0WOzoGIN9bJWxSn+MgBFirQr1muQYvRP
         GTGYcv/bvg7SKmwNH8Vl/uGd7ri3tZnpcjRPtJYiEW9RvzgrZVvcS1nRnyMDNLzKzCq2
         GN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759942749; x=1760547549;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MLcuhnYdeS//vkM0RdYjN2OKyaFw6ciE1LlE+RBNKiI=;
        b=VwNwV+12VeGkO1fxP6zfKo4syjXc0wGKJoq5jNllriA4gTu3BoeQneYFf7YxoioPS/
         puf49SqVs7JqY1x3r2Xz3wiQqOa5jPt9vRiygFr3v2ZrT3FeD6mjbf3NC48IuxZkNxkU
         vqg4XvWk8hv9uKfS/aHlc3stdnFxKb3BgHQYu0gYhZkyIHWJoqWivIQGIG+mH1pBT4dS
         hTXu6k4zWLS5L/a3jkEpMNPo0d0jB7dc0Lm5X/Z7gqnoUu0QRtdQ6DOuxn3rjG2PSE1+
         Bni/To2IQ7i279x9rfyhh8H5Bkb06IqLMfZzvevKj7eWmUcgTjNKY1LdfJQrON5ABPsZ
         EZjQ==
X-Gm-Message-State: AOJu0YzX9r8lLf21C0JIssdUoelfy/ARHKksJIDv8c3+JUMVzvTMzPOI
	1SALkPqW0A3qdxu1b+Ob5DYC3bEzWtkEwejlR90iAt7IIYxDIV/r+jsOZcnmdYPSmuJVXsHrw4/
	TbSWCCl10uffodylraPZ2ACsKr1+8bLSIDcY3
X-Gm-Gg: ASbGncvrV45RtSXqbYeP0dPdOZEuuAeR/VtMGlm47VXDj4F18Og3GdBTAV2wPoemgOt
	wjtQem1u4nLqSjYiXSLXTGb2ZXI8bFMQoy7FXFxESO+pO40UpYitJKZpuRpfdF2TEgsdTenAhGi
	b3r7cKk7lAusBBGuPAfNmseVMfTbJCEUfRdrRtwMwmvPSU7Mha69sVZruJE8d/1mJsXN40nCDh3
	LHIo1asablk/j0v+AkWpl96pGc7e+Vg
X-Google-Smtp-Source: AGHT+IEHNRpSIdo7vOAC5/CTCNxm9nwcjfLs1uz4t0emqHl8PeXBHERT2XRgnY9iwJQAHShegF2ijykyeAMCKzmSmqw=
X-Received: by 2002:a05:6870:d38d:b0:396:697a:bebf with SMTP id
 586e51a60fabf-3c0f8ec3786mr2343860fac.40.1759942748948; Wed, 08 Oct 2025
 09:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Wed, 8 Oct 2025 11:58:57 -0500
X-Gm-Features: AS18NWBk5ITjlA51eJhw0UMV87d_tCnM9lWgm5SubtDSASZXlRaLJEmvLcAhNsg
Message-ID: <CABb+yY3nxSwcHs5YwWkmFq=DXoAwqGXdud7673kM32V2+Le1+w@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v6.18
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,
The following changes since commit 07e27ad16399afcd693be20211b0dfae63e0615f:

  Linux 6.17-rc7 (2025-09-21 15:08:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git
tags/mailbox-v6.18

for you to fetch changes up to 3f39f56520374cf56872644acf9afcc618a4b674:

  mailbox: mtk-cmdq: Remove pm_runtime APIs from cmdq_mbox_send_data()
(2025-10-07 10:29:15 -0500)

----------------------------------------------------------------
qcom: add Glymur CPUCP mailbox binding
zynqmp-ipi: misc cleanup
mtk: add new GPUEB mailbox driver
     cmdq - remove pm_runtime calls from send_data
     gce - make clock-names optional
misc: change mailbox-altera maintainer
      remove redundant 'fast_io' in regmap_config
      mhuv3 - Remove no_free_ptr

----------------------------------------------------------------
Ang Tien Sung (1):
      MAINTAINERS: Change mailbox-altera maintainer

AngeloGioacchino Del Regno (1):
      dt-bindings: mailbox: mediatek,gce-mailbox: Make clock-names optional

Harini T (4):
      mailbox: zynqmp-ipi: Remove redundant mbox_controller_unregister() call
      mailbox: zynqmp-ipi: Remove dev.parent check in zynqmp_ipi_free_mboxes
      mailbox: zynqmp-ipi: Fix out-of-bounds access in mailbox cleanup loop
      mailbox: zynqmp-ipi: Fix SGI cleanup on unbind

Jason-JH Lin (1):
      mailbox: mtk-cmdq: Remove pm_runtime APIs from cmdq_mbox_send_data()

Liao Yuanhong (1):
      mailbox: arm_mhuv3: Remove no_free_ptr() to maintain the
original form of the pointer

Nicolas Frattaroli (2):
      dt-bindings: mailbox: Add MT8196 GPUEB Mailbox
      mailbox: add MediaTek GPUEB IPI mailbox

Sibi Sankar (1):
      dt-bindings: mailbox: qcom: Document Glymur CPUCP mailbox
controller binding

Wolfram Sang (1):
      mailbox: remove unneeded 'fast_io' parameter in regmap_config

 .../bindings/mailbox/mediatek,gce-mailbox.yaml     |  11 -
 .../mailbox/mediatek,mt8196-gpueb-mbox.yaml        |  64 +++++
 .../bindings/mailbox/qcom,cpucp-mbox.yaml          |   9 +-
 MAINTAINERS                                        |   2 +-
 drivers/mailbox/Kconfig                            |  10 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/arm_mhuv3.c                        |   2 +-
 drivers/mailbox/mtk-cmdq-mailbox.c                 |  12 +-
 drivers/mailbox/mtk-gpueb-mailbox.c                | 319 +++++++++++++++++++++
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            |   1 -
 drivers/mailbox/zynqmp-ipi-mailbox.c               |  24 +-
 11 files changed, 418 insertions(+), 38 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/mailbox/mediatek,mt8196-gpueb-mbox.yaml
 create mode 100644 drivers/mailbox/mtk-gpueb-mailbox.c

