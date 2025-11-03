Return-Path: <linux-kernel+bounces-882897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BC2C2BC61
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EB64834B338
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C112430C355;
	Mon,  3 Nov 2025 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SpWMuhBu"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA382D979D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173765; cv=none; b=MK7kDu4pagQQqYHwkXzbZUZWgS16Yfi1UFJ9k0rtxqYx5ikbH3KaUB8VmuqaiLF2gKLj+t0xs9kSIZUVvbLba6vJSIoDUc+7Yvw3rUFqvTXsRcZ8Mo6+ON7SNP7EbTp03oIQAXkxn+8nB35bbmSbbhN1Qtjm9ndMG/9w3p78WNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173765; c=relaxed/simple;
	bh=tUy+XzWKsgLSae03b5aT8r2DQygS0809yUu4YJxMeqk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h5N0D4uzUKgTjnAs5RqJm5nGic0+WqGwzw/KXpvxbI/18+xE70Vcontb9UL8+8h3gZ816sn7Fn1/77DQFnCABlO+51IFmcGR51TM/+mbDnWovNFtSj8zEuii7Y8zJCf+rhPRW4jQUeDpr5dIqqsQwdxVqMZeiZlnr2RpxwnaGqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SpWMuhBu; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso7574993a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 04:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762173762; x=1762778562; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ySdZbsfQoA3Pydck58t1awyRQGkCymKZ+NC9Ymw8JnE=;
        b=SpWMuhBuYWXhjYZM7pCckqDnCd7JmKXIpKYGstV2ST1H/fIaizK9khaAU12acZgyTP
         2BS1qwpHTvkVTaT3cXTOeFuTNhysr8aNg4+FAIDLACG4F2rrL4SjTjkEcX1UWmhqGCjH
         qMsxCr2lUdYkhVHF/gIDnxFFOgEyRvgw8dKqmWjMho6EtywagYYSneqb+joRgAPTyWGT
         ZyOz6EqYKYQW864byZcwc5EoDtS8KI/PRBDNphyW5J3pvtdh77bIPh9sLjSWNZG35BMS
         uq9rsI+EhSlr2RsmGYsC/UFUvQ1xZ03s6XDyJ50NWEz2LCmFpvc3+IxHaV5f7sqAe3tR
         bFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762173762; x=1762778562;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ySdZbsfQoA3Pydck58t1awyRQGkCymKZ+NC9Ymw8JnE=;
        b=UMcs8D99miYkDo1MINegrm3HxYMC7gvKyNWciyuyFu5vcikq7xpRcYMWLQDXg3BFJK
         hD12QF+U9HT1P9kAox7WYCr7nhWaR6KjpzAXUvd1SiJYPSM6YpNwW4k2UpdQGse1R6uf
         qJx+o/FD9uW/ggieiEOGeUeTyvDuAjhVag0TyeuBZNchtu03sYckDGtKnMbeOXFG48Md
         XVxmmN4j5EHhdMrODf6nLTjKiOFF1OH6Qtfuo4Jfhr+FT7hD8mrr5BT8OKg/hQD2mlqx
         tab1bgc2BBwDZvbmW8MjA74dGn2/cWi+0Xc31AW71H8IJ6jMqRSXAPxm4qBVf6gE5mhJ
         0Zng==
X-Forwarded-Encrypted: i=1; AJvYcCU7PcNxIyQ8zEJF+OkIG8Jacbx1MxEhB264oHVQgXdquzbIgaYKgYbWI4LmyR34JkUQk5FiuIhF/2Ufj7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjVwXRyXSaFby0w/rXkUOYm4eEHFmRyXRfCj/CVJBb+eyaBAYJ
	YpBA4Tehaf1msqbpMxzTpuDlUZwGvH0wZHhO2yGOw0MRCUsDqQJboSepcsTmQ4j/0po=
X-Gm-Gg: ASbGncvPSdtj6Dcq6Uvsg3qhngVbvnzje3aYTw10kJ4+t26fcIxQXn7YRtArR4J3OFw
	cKOMq2OKzzXKK7NXajFvNkAXCTU8YUaQmvB8e17PbmhxVKz75xaUIIcriydLApU4vuwqSXro7eG
	hVqkCPXWd+/0wt6mDdKp+fRKO8InEHMl6QjF2GyKF1BSGVkbsu1LSOAmtG6B8zySP9UawS5deZy
	hdtGwdal2sLizFEdiZ5TpUBtXtRnoJ8rjgqxCyvN1JQ+iWjVW4ZuNe80syOXw1Yb4Ct5mDApUIO
	7uO2wYQLIBaQ0rEo5yJncrDkiuLr3yV9nTCYeQEd+vV8dlc8NtHJfzZV16Cw3hLg6vxAyc2EYVf
	w+Cc4rTYGXXImycaFPfbXxRi1Uh0UsqHtD/d5j/pBi+tKiosAX4JjWWROwHuesPjS0jjwE67+DX
	mduueFLQ==
X-Google-Smtp-Source: AGHT+IH7gnDUVPLdyweD2s8+ECeaCpX5murw+DO/g9xiCSZKO8V3qVwx15d1k0QmIznWlNpzSJCtaw==
X-Received: by 2002:a05:6402:5111:b0:63e:2d4d:5a60 with SMTP id 4fb4d7f45d1cf-64076f67066mr11004356a12.8.1762173761943;
        Mon, 03 Nov 2025 04:42:41 -0800 (PST)
Received: from localhost ([2001:4090:a247:830a:fe22:a8:f29a:a5c3])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-640d50199e1sm930448a12.35.2025.11.03.04.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 04:42:41 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH v10 0/3] firmware: ti_sci: Partial-IO support
Date: Mon, 03 Nov 2025 13:42:18 +0100
Message-Id: <20251103-topic-am62-partialio-v6-12-b4-v10-0-0557e858d747@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACqjCGkC/4XSTWrDMBAF4KsErasyo39l1XuULiRZbgRJ7MquS
 Qi5eycObUox9XIG5nsPoQsbci15YNvNhdU8laF0RxoQnjYs7cLxPfPS0IIJEAoBHB+7viQeDkb
 wPtSxhH3p+GQ4Ch4VT8LKNoaklLKMjL7mtpzmgNe3+1zzxyfljPcli2HIPHWHQxm3m2M+jZyiN
 ILw7HawK8PY1fNccJLzxb0K5f1fZZIceGuTuXXyxuFLDOd9iTU/U9yMT+oBCvRroCIQU3Q5xEa
 BzQug/gY1SDBroL419FLIRlqlglgAzQNUAtdAQ6CMOuU2RJTSL4D2Abr1N7QEhoTgjE6icXYBd
 D8g/Y/Vho5Aa4JVwoBGhAXQ/wIlrIGeQLCq1brxCU38A16v1y+Rty/n5QIAAA==
X-Change-ID: 20241008-topic-am62-partialio-v6-12-b4-c273fbac4447
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7486; i=msp@baylibre.com;
 h=from:subject:message-id; bh=tUy+XzWKsgLSae03b5aT8r2DQygS0809yUu4YJxMeqk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkyOxdqVAv/Lig/Hit+S21K5/d3ayoMJUq9X6Fb7fuN4c
 Gimk1VnRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAExk02yGfwafs+Xbz0Uc/uL7
 896SiIyj59XW7q44mvb36qrzN+Njn/9lZPg5SfC8d+qT092ragJvSf3V+GWt9K8mznOLg9eHO2Y
 fGJkA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Hi,

This series adds support for Partial-IO to the ti-sci driver,
implementing the firmware interface necessary to enter this low power
state. It processes the wakeup-source properties from the devicetree and
communicates with the system firmware to enter Partial-IO mode when
appropriate wakeup sources are enabled.

Partial-IO Overview
------------------
Partial-IO is a low power system state in which nearly everything is
turned off except the pins of the CANUART group (mcu_mcan0, mcu_mcan1,
wkup_uart0 and mcu_uart0). These devices can trigger a wakeup of the
system on pin activity. Note that this does not resume the system as the
DDR is off as well. So this state can be considered a power-off state
with wakeup capabilities.

A documentation can also be found in section 6.2.4 in the TRM:
  https://www.ti.com/lit/pdf/spruiv7

Implementation Details
----------------------
The complete Partial-IO feature requires three coordinated series, each
handling a different aspect of the implementation:

1. [MERGED] m_can driver series: Implements device-specific wakeup functionality
   for m_can devices, allowing them to be set as wakeup sources. This is
   now available in linux-next.
   https://lore.kernel.org/r/20251001-topic-mcan-wakeup-source-v6-12-v10-0-4ab508ac5d1e@baylibre.com

2. Devicetree series: Defines system states and wakeup sources in the
   devicetree for am62, am62a and am62p.
   https://gitlab.baylibre.com/msp8/linux/-/tree/topic/am62-dt-partialio/v6.18?ref_type=heads
   https://lore.kernel.org/r/20251103-topic-am62-dt-partialio-v6-15-v5-0-b8d9ff5f2742@baylibre.com

3. This series (TI-SCI firmware): Implements the firmware interface to
   enter Partial-IO mode when appropriate wakeup sources are enabled.

Testing
-------
A test branch is available here that includes all patches required to
test Partial-IO:

https://gitlab.baylibre.com/msp8/linux/-/tree/integration/am62-partialio/v6.18?ref_type=heads

After enabling Wake-on-LAN the system can be powered off and will enter
the Partial-IO state in which it can be woken up by activity on the
specific pins:
    ethtool -s can0 wol p
    ethtool -s can1 wol p
    poweroff

These patches are tested on am62-lp-sk.

Best,
Markus

Previous versions "firmware: ti_sci: Partial-IO support":
 v1: https://lore.kernel.org/lkml/20240523080225.1288617-1-msp@baylibre.com/
 v2: https://lore.kernel.org/lkml/20240729080101.3859701-1-msp@baylibre.com/
 v3: https://lore.kernel.org/r/20241012-topic-am62-partialio-v6-13-b4-v3-0-f7c6c2739681@baylibre.com
 v4: https://lore.kernel.org/r/20241219-topic-am62-partialio-v6-12-b4-v4-0-1cb8eabd407e@baylibre.com
 v5: https://lore.kernel.org/r/20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com
 v6: https://lore.kernel.org/r/20250421-topic-am62-partialio-v6-12-b4-v6-0-3b5cefab1339@baylibre.com
 v7: https://lore.kernel.org/r/20250812-topic-am62-partialio-v6-12-b4-v7-0-ac10865c2d87@baylibre.com
 v8: https://lore.kernel.org/r/20251001-topic-am62-partialio-v6-12-b4-v8-0-76a742605110@baylibre.com
 v9: https://lore.kernel.org/r/20251030-topic-am62-partialio-v6-12-b4-v9-0-074f55d9c16b@baylibre.com

Previous versions "can: m_can: Add am62 wakeup support":
 v1: https://lore.kernel.org/lkml/20240523075347.1282395-1-msp@baylibre.com/
 v2: https://lore.kernel.org/lkml/20240729074135.3850634-1-msp@baylibre.com/
 v3: https://lore.kernel.org/lkml/20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com
 v4: https://lore.kernel.org/r/20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com
 v5: https://lore.kernel.org/r/20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com
 v6: https://lore.kernel.org/r/20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com

Changes in v10:
 - Remove unnecessary empty line
 - Make ti_sci_cmd_prepare_sleep aware of PARTIAL_IO mode and the
   not-expected response, because both Kendall and Andrew seem to
   prefer this.
 - Moved the removal of the ctx_lo, ctx_hi and debug_flags to the end of
   the series so merging is optional.

Changes in v9:
 - Rebased to next-20251029

Changes in v8:
 - Add a patch to remove constant 0 argument passing to
   ti_sci_cmd_prepare_sleep
 - Move partial-io functions further up in the file before the first
   static const initializations

Changes in v7:
 - Rebase to v6.17-rc1
 - Update the idle-state-name used to off-wake as introduced in
   dt-schema

Changes in v6:
 - Narrowed down the wakeup-source binding to phandle lists
 - Split off the mcan and DT changes into separate series

Changes in v5:
 - Rebased to v6.14-rc1
 - Merged m_can and ti_sci series to avoid conflicts and show
   dependencies more easily
 - Added definitions of system-states for am62/am62a/am62p
 - Moved wakeup-source definitions into board dts files as they require
   a bit of support on the board.
 - Updated ti_sci support to walk through the wakeup-source phandle
   lists
 - Added pinctrl settings for mcu_mcan0/1 on all boards
 - Minor style updates for ti_sci support for transfers without response
 - Update and move the dt-binding for wakeup-source from the m_can
   binding to the dt-schema repository

Changes in v4:
 - Rebased to v6.13-rc1
 - Removed all regulator related structures from patches and implemented
   the wakeup-source property use instead.

Changes in v3:
 - Remove other modes declared for PREPARE_SLEEP as they probably won't
   ever be used in upstream.
 - Replace the wait loop after sending PREPARE_SLEEP with msleep and do
   an emergency_restart if it exits
 - Remove uarts from DT wakeup sources
 - Split no response handling in ti_sci_do_xfer() into a separate patch
   and use goto instead of if ()
 - Remove DT binding parital-io-wakeup-sources. Instead I am modeling
   the devices that are in the relevant group that are powered during
   Partial-IO with the power supplies that are externally provided to
   the SoC. In this case they are provided through 'vddshv_canuart'. All
   devices using this regulator can be considered a potential wakeup
   source if they are wakeup capable and wakeup enabled.
 - Added devicetree patches adding vcc_3v3_sys regulator and
   vddshv_canuart for am62-lp-sk
 - Add pinctrl entries for am62-lp-sk to add WKUP_EN for mcu_mcan0 and
   mcu_mcan1

Changes in v2:
 - Rebase to v6.11-rc1
 - dt-binding:
    - Update commit message
    - Add more verbose description of the new binding for a better
      explanation.
 - ti_sci driver:
    - Combine ti_sci_do_send() into ti_sci_do_xfer and only wait on a
      response if a flag is set.
    - On failure to enter Partial-IO, do emergency_restart()
    - Add comments
    - Fix small things

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
Markus Schneider-Pargmann (TI.com) (3):
      firmware: ti_sci: Support transfers without response
      firmware: ti_sci: Partial-IO support
      firmware: ti_sci: Remove constant 0 function arguments

 drivers/firmware/ti_sci.c | 131 +++++++++++++++++++++++++++++++++++++++-------
 drivers/firmware/ti_sci.h |   5 ++
 2 files changed, 117 insertions(+), 19 deletions(-)
---
base-commit: c9a389ffad27e7847c69f4d2b67ba56b77190209
change-id: 20241008-topic-am62-partialio-v6-12-b4-c273fbac4447

Best regards,
-- 
Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>


