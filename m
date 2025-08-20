Return-Path: <linux-kernel+bounces-777341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A871DB2D83E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F9B3A4E43
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6A22E2DF2;
	Wed, 20 Aug 2025 09:23:40 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02D32D8388
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681820; cv=none; b=SvTf3gK6Hwx0AmIIpcu8XeOpv3OSzwGWKkWVKM+jA3iw7g93H+EgkXddvzGGZd80WFxvIgewTcTN2mIV4frBl0V7XAmFnQzKPWfZhjq2aRw+d+sS2Dv4a/SuzJSTgWjF7Uex+D9W/Ro5YpL0Cdx5HZuNi8eBwb2lUHM6V23jjW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681820; c=relaxed/simple;
	bh=ydSrj/nL0FBHtk7T7/wA6TN99t+B7MjLZwhk7LqyWOM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GS4QoRSrBu5w8Kx6ILsoA0EpwT61x8PeRfjLpqM2U9z/hSgZzkTPkE2HaYvb2/08IjmabrnvZnZnnU1JRWFhfiu6Pf6Wg14ERRUhckJMg+4GDQjm/bD9dvoLDcmpoSDsx2xpXIFt+akoHBU8euvp/wt8i+uQqFQUWQLqJHLMZNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz10t1755681728teda31363
X-QQ-Originating-IP: h+wSIsByCFLm9TreXoJ8BicfeWc3XlU3z5Zjs8MYZOU=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 20 Aug 2025 17:22:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2554484086682756889
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
Subject: [PATCH net-next v6 0/5] Add driver for 1Gbe network chips from MUCSE
Date: Wed, 20 Aug 2025 17:21:49 +0800
Message-Id: <20250820092154.1643120-1-dong100@mucse.com>
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
X-QQ-XMAILINFO: NUuNC/YWhe9rIhAzzH/We8+y8rZHK66anOyDPBde8ga4K3jctmMlH3zF
	tCG1PXtv9oharbz24pgJoVmepqmhKWHpTCCtgugq2OrvSeG/7PtfhIDnMHgBJwGMVLpqHhb
	dowUjWsCtgeVFOjt+CqWc19+3HJpbdPB4OBaQg15zBsw+cFPbyegp2zfTPprnZYXdQ0UbG9
	Xt4ZtbMdhgbiH29Y5KZZMFfTPQ51KyB8HZsFmI9u2hV0Mj6trde+szgPT1RKODTCTx/eCaH
	k4YDNITuz2tdWN8oGWRDfCjfvboaEGmeo7VcOl+cxHLvr0SnDJtfhu9vPpyKs8X9NNvWvkU
	4DYYlUXYglEt3JwJn4pK7sOMXEFwMze2dH9WytE/yMaU1Ve2Djo2ezPKWYg9m283kG+j1IN
	5TTZsuBjnMOgTRzhl5bP9EZIOOmZN3kcncv3gWC2WdEYfTe3Ttr0sF2PmxH7h3p2Nw9j8x/
	9dOf4W/2LGYWA0KGmEJkj7HShd46azNQhzwoX68YTCpruITzKxB9fX80/XCzo002IU0LkPe
	EgyDnyon6NF2Dc3cAlV+v4bT9leRiTr6ZFw1UPJfRTVC7+dSDhyaK4DcU8cYmLtNDlPFpRv
	yrervhkjXcwv6f2NpFdHM6ecx97MM7lkXCqPTQwe2y8u8MM5nxBYjoUU6hseqIIn2aGnkcr
	s65mXMuo6TlK4gEFazbIWG0xx/iEMA+1MiRjAdnZ3PWXtYOMSlJsjWrHtVQ+DSzCDNlrvfo
	txP7kApy46vs3pgGXs8UCFerln7jkOwPnkGLrM8CvC7XcE+zMe1s5GaFZbe3zAjEUyKhCDQ
	daFrJNqxsn/2KBFkGUZN3Br8cxlxYNNfkDXAq67ocOYOoz7teejTOyJ3Ikg/oD0VVu4I5SW
	uWHaCryd7I4xXTuKPk0EkpduXwTcunRO/y/dxAhuQmImkXrl5jtMThKu+KOU3FYJG867afv
	13jvTx3wTTMvHhdcE9x/2MKktxMKjjGXb/b8Mbb1DKk/ZdExkXw99vI/JnsfBEDQutL04ed
	J3nQ7bmNdpt3J0ZphOpGAv4RWIU8IhESLic9ASUlQ657xKqz3gqyimZbxekz+EsqxlL8hOW
	twGEDDC+dcbfFl4JiHNBYn2+yPGdju+Lg==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Hi maintainers,

This patch series is v6 to introduce support for MUCSE N500/N210 1Gbps
Ethernet controllers. I divide codes into multiple series, this is the
first one which only register netdev without true tx/rx functions.

Changelog:
v5 -> v6:
  [patch 2/5]:
  1. Remove no-used define 'usecstocount/eth/mac' in struct mucse_hw.
  [patch 3/5]:
  1. Remove no-used define 'rsts' in struct mucse_mbx_stats.
  [patch 4/5]:
  1. Remove no-used define 'fw_version, bd_uid' in struct mucse_hw.

links:
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
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 100 ++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 150 ++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  18 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 307 +++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 479 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  31 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 330 ++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 152 ++++++
 16 files changed, 1651 insertions(+)
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


