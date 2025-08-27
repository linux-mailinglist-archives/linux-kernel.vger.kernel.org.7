Return-Path: <linux-kernel+bounces-787623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC65AB378CB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A171B67212
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C512E30DD1A;
	Wed, 27 Aug 2025 03:46:51 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59EE2594B4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266411; cv=none; b=CC3ZNJy7Ygb867bpGjdyA71i2RqDAXKb6+E+2eSSaJ8ZUBkjBVWswMt6H64zSukyZ0SccLMlGv5Gkap0Sh8Q5pH//RoZQoRPSvmZIfyfbt4aW9C/0jIOWGQ+/msz8n3H0/gpumPc39C64QcPvT5IUEQxXM1IJbFM35fCZRhGcR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266411; c=relaxed/simple;
	bh=MPUCB0Z1uQ24Cnjkt5KOkq+bdA4fSv0sziSIivOPSIk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LQnqTIPD4JlsNz3KSe/hFRjeevjgVzTKdjxeZRZ9PXPzHHh/BgwHPAo5sFmxe7HUvVTo9kWXngB+lzkDJMlMjb/3PVJgPpaJS5DRODHrElbWKA4QEfdmcggQR5A8MmKoK8SfCp2vO93LXGkCTDwOYW4myTENMaBDDnWlTjoBGj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz7t1756266320t257cfaed
X-QQ-Originating-IP: H/22sNSqc05HKbCq6u90qkTPzIcWcNVtfEphTK1YxHs=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 27 Aug 2025 11:45:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9214274692704587650
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
Subject: [PATCH net-next v8 0/5] Add driver for 1Gbe network chips from MUCSE
Date: Wed, 27 Aug 2025 11:45:04 +0800
Message-Id: <20250827034509.501980-1-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MpIhqPjJBjOX29reoJShsmgqsQd2F7+3j+IoCtNRhb4w0d7aMedf2LEP
	focUg4R1fzwIbVKFUtqFMcs1gHTtIKP4yzG9nsgNtDLW5GNr7j+6YLfkgckDwOvfoV9Zw4X
	hdv4UJPYyOXJP5W4LEcDufvHHdvr2ieF2MU/Zec0O8RBX927vUzOUFneB++QjRE2dHJ1M+G
	H6S+Av+YlJg4ntfiK3fP2fU2Hi1WSXs63nGOxwgizygq6sE7LxtPkG8ckUJE5iChJq8gqTl
	/683Cu2uxBDSU6hGBgyvgu5ZiHnoO7/z9/xNl8bKVv28oA6LHf+QwjznqysYOC/Nb3yJasQ
	WzJyRnankQ5LGHOSUjn3OjIvOM1g2quN8pb5H1srrVhVeNkgqBVWDHaVBNJy6sb74VRE44i
	S0390a2hOi1dTalwKydedEzOOxnRU9hL9N9CNPJuAmaYlZGHH8lLSUQZ8LWOH9DtvKQGZ8n
	/QsdUjNQAmVRx+dyl2NRNxPSLvbiKBZ8IdD3h27zV5Psoba9zTJuPdlL5wOHnHk4GYeEbgv
	baTb9ofpssb9S067ZRbPp5ZA+uBHqKqNXj+AyoMZJZu5B6SuNuxeoAmZWHxURqooWNqtJ5a
	KA2azKmR3Xc0Km8lioEnbgiCa3V9qASewCDujSU4SkivNH85q0iespwdMv/wtWdetnfALeg
	YoHW+9rYU/1SPJ0/dUrM+jeTIsCP0irsv05swZfXVAWozs4D/ttQ5olxpKaD+W1u4sebIll
	ovw/lKPbuI3o2Z0eDoXwa1GKzLl5azZpzEibl5ka5vAJL0jEqcUPQSAdcdd7J5OEWFeexWR
	CToemZSQO2LDgDax9BABw8FEmGg8FHbveo5U5FFcwxPyMaKA9X0S6mJCIXMqx2q5fM1P7+Y
	50c01O8pFmmVyrX+v78N6S0CW7A6JpO2W81V5d6qF54sPP3YUSERo/rctpl3oLNPR8HkYJp
	y8j0yyLymTnqkxk0ZxkpNfPRsOFcKwpCd4H3Qg6DTJQTGvuwyRuuNorAz9eD5PDbCkQKi6R
	iDwpt3L+6fSVU3PIP2nLUvgpVzjymWbcTJ7iQpQ14/NeRcuQUKJ9l/eKs7kO9feP8F8duxF
	htbQirwJUPeUrfgH0guIGhxhv5MoJnetzNnWtipdllyS5T3FelgIEAAhDgk1CDbig==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Hi maintainers,

This patch series is v8 to introduce support for MUCSE N500/N210 1Gbps
Ethernet controllers. I divide codes into multiple series, this is the
first one which only register netdev without true tx/rx functions.

Changelog:
v7 -> v8:
  [patch 1/5]:
  1. Add check pci_save_state return in 'rnpgbe_probe'.
  2. Rename jump label 'err_dma' to 'err_disable_dev'.
  3. Rename jump label 'err_regions' to 'err_free_regions'.
  [patch 3/5]:
  1. Update 'mucse_check_for_msg_pf'.
  [patch 4/5]:
  1. Rename status to is_insmod in 'build_ifinsmod' and 'mucse_mbx_ifinsmod'.
  2. Update 'mucse_mbx_fw_post_req'.
  3. Remove code relative with cookie(relative with irq, to be added later).
  4. Update 'mucse_mbx_get_capability'.

links:
v7: https://lore.kernel.org/netdev/20250822023453.1910972-1-dong100@mucse.com
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
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  98 +++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 153 +++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  18 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 286 +++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 395 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  25 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 253 +++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 126 ++++++
 16 files changed, 1438 insertions(+)
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


