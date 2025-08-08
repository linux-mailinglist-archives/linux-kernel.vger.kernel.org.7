Return-Path: <linux-kernel+bounces-760561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD99B1ECE0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3E457AA63E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBD2199939;
	Fri,  8 Aug 2025 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDfx4YEt"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C746F3D6F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754669741; cv=none; b=rxAXflXDQF/ov2/EUiibNnNXsa7vJE+iEcOeUoN3lhIanV6wILZDd41Ezi5ZJrxgZ5nr93t0tUaMGn0DJqfATIq5Aead/UTb3Rjd/mu/fVcY+MTipbrzBs9g6Yw30FdIQzZEaDjBsRpUhArrzZDug/bGBmt5Jzym1SfkF6h+0xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754669741; c=relaxed/simple;
	bh=Efagl/FW5AU15w6FXSOYlMJ3Uexa75IRc+y4z35h/lw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IJltt0R4OjTY3H/Owmkbu8IlTiWie3i3JfuNOZhvZCPY7F/psbUJkkRm+uX7KohlJXdLgB3zWySD/BFr5vRYK5qint7K4jtUvY2VaN4VY9q2ildY7Zfht2vLTrYMXC9dLCBzUH/m3bZx2DK9GuN9B+O5MP0G4NNutWhb+5okgkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDfx4YEt; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-43404e99955so1553287b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 09:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754669739; x=1755274539; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NEaDix6sRcJYV60mLIJzttVw+UOcvD2uRUGstNWoWWE=;
        b=SDfx4YEteLHIA/zLtjpAQ8lYLqKSyNQ4y3Sh4IKvxBdZcwxDx9O0lzJsf4kRatYRdW
         kFsgJurNPV3Fw2D4hVgkegZWQzd7kVVekXNJOo6qtUORpnEy8sBNKnuoea3I+H8HoyzR
         Sdj/A8SCz6CM08B9N9D1MMDuSImaCn05HFXwPxEdfsPGQ4un5h1k/hn9FN32rSbMQ5UW
         TV9TMJw0cRwIFOZtDYngM/avG+O7QsgiOlAkCW9XewbKckV1m/dRtQsfRQuja6T8hrxU
         Nk1RXuM6PyursaVdx+gZw9XoBMSqUm6LMDXjIkPgrcD/mmckMrSRIE5y5TdSBOA3cll+
         r59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754669739; x=1755274539;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NEaDix6sRcJYV60mLIJzttVw+UOcvD2uRUGstNWoWWE=;
        b=stfV7o1kVDapEGR/0O2DSWCymb5ZoQS0B1IfMMTvddhlbhx2FVpMXtrmr11eLDfA6+
         4Wkb1BjPmJr0bQ22XwOmfphjUTYis4XY1CnsfA3+a1Xd8nffnvPIvtOfWC6PNJGFxeAz
         EbcBbZLXr4BPLXVp+b7prbBsca2iVMgY2BkR+z0iMWpJzLCddaUTaBoAMtEmiPqcZNey
         i7uPq95Tmr/xlnzuR5QngnwaQLLRBspLc0pDCvOlWxh8aGBkNZAaF6TdD5TcaUoq0pg0
         17342eiWw/epVEVdy9gQEgzu28O9E12NwV7nZhCO0ewCuQPcwHV1eSLcEQJ2ghbxa5SQ
         5n9w==
X-Forwarded-Encrypted: i=1; AJvYcCUorWnNzTQP3hdvtx3SbSnIxyoV1aNYN49UK7RtVTCsmSSudUqS5fpbWIbKk2VWMNS1yzcVq+zFDUmiY4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGT+cOn7O3DshybQpYmnx+u9UqvRqn/Hm0Kv6a8ql4jOL84M5W
	F43yxKbQOC9AttXOQeoKhcYEBhlMklUzK1mlq8iLKb+AkDCHeKxtliMxlq7XPa8chy+yZLUJUnt
	qobmTZ7ysr+onbI0WFVvvY84r8RZRLrd0hSyB
X-Gm-Gg: ASbGncuiU3OkP/+dtNajKAw5yhILqlICNVFn/yzeN+8Lv8S7xdPXUsqEmNFer5lYnda
	De8Vrbo/8KfqzJMsPTnsWgWl2cM/hzFA3tbwF5kgUPKmzQjuSXdb/Dz/jpWDbqpkOJvy5CzzJS/
	4uktLGy2qbFqDnMh1vjxsWvsy08qRADNL1k2FC5dfUo8OqgjgSc1Zz5SdKhOq3ggGbNZokMy2VE
	KHlKTJw
X-Google-Smtp-Source: AGHT+IGAf6NlWhniXbzEbMshI0yuckGCe6+ALslH3kX5FSyONxwwwXzKSDgVl4Qzic4CM7x7HMcdLe1z47UBtkDDdLI=
X-Received: by 2002:a05:6808:3084:b0:435:6d0b:82c4 with SMTP id
 5614622812f47-435980222dfmr1778053b6e.36.1754669738848; Fri, 08 Aug 2025
 09:15:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Fri, 8 Aug 2025 11:15:26 -0500
X-Gm-Features: Ac12FXxwrGojS8v0wQNI0vM24r2jg3NrSRyNjV7YrSnlqxupgJhtX96rAGR2OuI
Message-ID: <CABb+yY0+oTn999iv=vy1npF1Bi9=GVqWXBh=iOocVoa2MwW5Vg@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v6.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

The following changes since commit 4df9c0a2465a523e399e46a8d3b5866c769b381b:

  Merge tag 'soc-newsoc-6.17' of
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc (2025-07-29
11:17:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git
tags/mailbox-v6.17

for you to fetch changes up to 5378bdf6a611a32500fccf13d14156f219bb0c85:

  mailbox/pcc: support mailbox management of the shared buffer
(2025-08-07 23:49:56 -0500)

----------------------------------------------------------------
aspeed: add driver and bindings for ast2700
broadcom: add driver and bindings for bcm74110
mediatek: fix RPM api usage
qcom: use dev_fwnode
pcc: support shared buffer
misc: dt-bindings cleanup

----------------------------------------------------------------
Adam Young (1):
      mailbox/pcc: support mailbox management of the shared buffer

Colin Ian King (1):
      mailbox: bcm74110: Fix spelling mistake

Jammy Huang (2):
      dt-bindings: mailbox: Add ASPEED AST2700 series SoC
      mailbox: aspeed: add mailbox driver for AST27XX series SoC

Jiapeng Chong (1):
      mailbox: bcm74110: remove unneeded semicolon

Jiri Slaby (SUSE) (1):
      mailbox: Use dev_fwnode()

Justin Chen (2):
      dt-bindings: mailbox: Add support for bcm74110
      mailbox: Add support for bcm74110

Krzysztof Kozlowski (5):
      dt-bindings: mailbox: amlogic,meson-gxbb-mhu: Add missing
interrupts maxItems
      dt-bindings: mailbox: ti,secure-proxy: Add missing reg maxItems
      dt-bindings: mailbox: Correct example indentation
      dt-bindings: mailbox: nvidia,tegra186-hsp: Use generic node name
      dt-bindings: mailbox: Drop consumers example DTS

Luca Weiss (1):
      dt-bindings: mailbox: qcom-ipcc: document the Milos
Inter-Processor Communication Controller

Sakari Ailus (1):
      mailbox: mtk-cmdq: Switch to pm_runtime_put_autosuspend()

 .../mailbox/allwinner,sun6i-a31-msgbox.yaml        |  14 +-
 .../bindings/mailbox/amlogic,meson-gxbb-mhu.yaml   |  10 +-
 .../devicetree/bindings/mailbox/apple,mailbox.yaml |  16 +-
 .../bindings/mailbox/aspeed,ast2700-mailbox.yaml   |  68 +++
 .../bindings/mailbox/brcm,bcm74110-mbox.yaml       |  64 ++
 .../bindings/mailbox/nvidia,tegra186-hsp.yaml      |   9 +-
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    |   9 +-
 .../devicetree/bindings/mailbox/qcom-ipcc.yaml     |   1 +
 .../bindings/mailbox/ti,omap-mailbox.yaml          |  10 +-
 .../bindings/mailbox/ti,secure-proxy.yaml          |  18 +-
 drivers/mailbox/Kconfig                            |  19 +
 drivers/mailbox/Makefile                           |   4 +
 drivers/mailbox/ast2700-mailbox.c                  | 235 ++++++++
 drivers/mailbox/bcm74110-mailbox.c                 | 656 +++++++++++++++++++++
 drivers/mailbox/mtk-cmdq-mailbox.c                 |  10 +-
 drivers/mailbox/pcc.c                              | 102 +++-
 drivers/mailbox/qcom-ipcc.c                        |   3 +-
 include/acpi/pcc.h                                 |  29 +
 18 files changed, 1214 insertions(+), 63 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.yaml
 create mode 100644
Documentation/devicetree/bindings/mailbox/brcm,bcm74110-mbox.yaml
 create mode 100644 drivers/mailbox/ast2700-mailbox.c
 create mode 100644 drivers/mailbox/bcm74110-mailbox.c

