Return-Path: <linux-kernel+bounces-780976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8B3B30BE6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD821D02D1D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 02:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757CA198A11;
	Fri, 22 Aug 2025 02:36:33 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCDC72617
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755830193; cv=none; b=oNjS3Flv5nNHE66BmOnPZtFQgbyW7c9s5cudyDDCPVDbc7+y9EDLSgwA5V3jqFd0RvZlOUl2lPgHZIQKWHyZbOi6mpLf5HnYKCLpBMQ7g/xhMwxp8Silgg5NUOSFvqHKFfGwb5QitN7ooAcGMnXlCasysFvguCReokv/hAaFX7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755830193; c=relaxed/simple;
	bh=wwGyWdIK50SWbagIxSxLZMJ6FDsAB7Iq2+T8A8L/TJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ESj16ke6bmyF0VW2m1I+eQ7LzrtEe6rIFc/82zMZ79HXsXi6iYhVIJ2nqetfVgfGTjjGIP3K2yFUH79rPG+homEHoAE04mQF8JnHgO6cxp2+JSkhqWTzj5DdbW1uCDg+LZQM5BrNQKknSPaNKSLH6YqWGyPunkAvgjOlSO/YbHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz14t1755830103t98a9c31d
X-QQ-Originating-IP: m9IEAcTsEl58MHXimhfd+ED7bwkpmxqoK/WkVKrg1q8=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 22 Aug 2025 10:35:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15671151008578251327
EX-QQ-RecipientCnt: 26
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	gur.stavi@huawei.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	danishanwar@ti.com,
	lee@trager.us,
	gongfan1@huawei.com,
	lorenzo@kernel.org,
	geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com,
	richardcochran@gmail.com,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v7 0/5] Add driver for 1Gbe network chips from MUCSE
Date: Fri, 22 Aug 2025 10:34:48 +0800
Message-Id: <20250822023453.1910972-1-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NKPaDPyQQodoqePbJ68CqBZnqULCSMM5rRX1LeAAqwmmaucT1Nlkwp69
	7xkwhJXeNWOtzYpHi9NFZsi4OVtlylPHFdxSSR5Su/b0SUN3bBrN/PZ2z4m4+aDuv8EtP/Z
	xrZnGmG5vCUsd9BoNOWPfMjpRPV0OHSPzmQl1Am8aqxisnHxl0PrtIh7vB3z86pQOhMnz77
	bhwV0xpUOp2jaD2krdqqE7ERIgGQrRGV2bUShAPZMRDSuBP3XOo6B/s7XxzMkgMg/+/gpoT
	ZtrR8uHephnqTmvqSAZgvJrINNcYYYQvgq+r+N9sVquU5tU3v9+JFowk2rtra4rnFbPOCif
	jm2P5Q+u5/pzqhANsSbMSh6wPrGO3LzTFam6lGJf4S4waWVSW868r00+Xp1F/Z/NsxwwDf+
	IgxFKezEpivOaq31+b+RuF20rsVwVpLjz7hYizE1DXlFvqhh44RW100JY/lhHSaukQTGCJA
	9LuOltnw+D9B4sUj0Xbrk1Svsf1pOnm7zOj4VOCjpHbmjko+bsUusEipaNZV2Exu6wkeuKv
	vl0ojlPfTE79JGGG5GOTMGzNca/SQmig1bh7SVDne/6JwWw1XPgOu4l5sRTPCB7X1NO1AbI
	U5id3tSwrh5CYe+uU+fYrLMWMzRq6ysb47fmJEwCYasfZatia4XjSOW7t73pkNPzBE9Yz5R
	6LJYtQhxu8GJwjLavfJFI3OcXrvmfNV1liS+fcb/9H49EvKegUt6coMMvFiicwbtVvOO9SE
	6pQ0eFA/odtzF7TDKEyqCewVVyWPjET1c22QdlZALxDT6M8KabuV6OhE3pTmfHiHpNMUJ/y
	/HDlDuc9eCJ2qKm9A1y2mb0Dcjiclfg21qBAKXRzrCOiPKeGPhZSGWXn4tzVrVUB1NR6NWn
	OPuKe5kIqHrbRtt5XHY2YL/BQvK6FZUx572KF5m7/QqEZKV08N5D1DTWi51k7Jft3WZeLto
	6vpDj9mvUET2i12Hxw77APfZeCE6uFWBAXM7MYIcPXz0Doa8EtCRVjtdjEfoLvcG1eanGES
	ka0r+j6F8vPsExzi2e5LMPjjPYrX4CS5P1KmjJk21dLAGRzuXobHLO5tarjFGg84ZWr8LgP
	LpxKUpocugGpalsD1NS8MCgaLOi7Ac6tg==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Hi maintainers,

This patch series is v7 to introduce support for MUCSE N500/N210 1Gbps
Ethernet controllers. I divide codes into multiple series, this is the
first one which only register netdev without true tx/rx functions.

Changelog:
v6 -> v7:
  [patch 1/5]:
  1. Use module_pci_driver instead 'module_init' and 'module_exit'.
  [patch 2/5]:
  1. Remove total_queue_pair_cnts in struct rnpgbe_info.
  2. Remove no-used functions in this patch series.
  [patch 3/5]:
  1. Move 'MBX_FW2PF_COUNTER' to 'mucse_mbx_get_ack'.
  2. Call 'mucse_write_mbx_pf' directly.
  [patch 4/5]:
  1. Add comment for 'wait_event_timeout'.
  [patch 5/5]:
  1. Rewrite function 'rnpgbe_get_permanent_mac'.

links:
v6: https://lore.kernel.org/netdev/20250820092154.1643120-1-dong100@mucse.com/
v5: https://lore.kernel.org/netdev/20250818112856.1446278-1-dong100@mucse.com/
v4: https://lore.kernel.org/netdev/20250814073855.1060601-1-dong100@mucse.com/
v3: https://lore.kernel.org/netdev/20250812093937.882045-1-dong100@mucse.com/
v2: https://lore.kernel.org/netdev/20250721113238.18615-1-dong100@mucse.com/
v1: https://lore.kernel.org/netdev/20250703014859.210110-1-dong100@mucse.com/

Dong Yibo (5):
  net: rnpgbe: Add build support for rnpgbe
  net: rnpgbe: Add n500/n210 chip support
  net: rnpgbe: Add basic mbx ops support
  net: rnpgbe: Add basic mbx_fw support
  net: rnpgbe: Add register_netdev

 .../device_drivers/ethernet/index.rst         |   1 +
 .../device_drivers/ethernet/mucse/rnpgbe.rst  |  21 +
 MAINTAINERS                                   |   8 +
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/mucse/Kconfig            |  34 ++
 drivers/net/ethernet/mucse/Makefile           |   7 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |  11 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  99 +++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 153 +++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  18 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 282 +++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 395 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  25 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 333 +++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 152 +++++++
 16 files changed, 1541 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
 create mode 100644 drivers/net/ethernet/mucse/Kconfig
 create mode 100644 drivers/net/ethernet/mucse/Makefile
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/Makefile
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h

-- 
2.25.1


