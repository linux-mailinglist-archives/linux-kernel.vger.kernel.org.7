Return-Path: <linux-kernel+bounces-747310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EDEB13247
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 00:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26014176AB6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 22:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B54F253F1B;
	Sun, 27 Jul 2025 22:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TGP3JFr8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fe+mArZE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73E32522B1
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 22:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753655883; cv=none; b=kWUF4ZBJc+zr1R+spS0cSn0dQnRRk8qIWVi2ePxYx6pXbwyZrHrP/fjDgoMPZckf9QNLjIUW2oQgXUK9CIv8+T2YOHgc0ZQh5ZECh+aXvm8QQftybbLDYxTA5pfYwFREQbToNeXDSylf0fB9uXMtjYZcfM3VQPyGQh0XDFWduh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753655883; c=relaxed/simple;
	bh=N+4iKDE6r5OcwozN7f9Z4vTy0BVJW4qauquTBAiT7Ls=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=ixarR+LRDbJHuExg9Wnr25WCcGg/SBcf8VKwFGChkJy/qIraH9YLn9SE7Ti+ULqcIzyYIXEyaChKn/e59vzCtifrjOZ9BQHeo4w2bpa8twUv3UIWoPusSO69AM8zh69zqiFcf2edoUp/WYsIxGinnId0k4AkFBi3iwMzui+5sb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TGP3JFr8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fe+mArZE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753655879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=YvmaDPLamtdgKZEvLFXA5xGOluQmvnkazO/mqCoHT2Q=;
	b=TGP3JFr8fv13KU3CusZTHRGaz7grvJE4zlWPOQ1vF+gGmkc+ln/buUv1sqzzQ9vmUzW+Hn
	GyKorIQkPoX59ZHn/qV2YYfb2pN067AFGmjFOMP/e2r3SIqGvCw8EI60Ah0nixJL0cE6hr
	6zWgksB//rgC/iDx8i8LdBTd1tr2G0MaQEGCTIoQYMQL0pprnN9mvEXZD8byP+xJRuLMgE
	jTkTBKob7s8GQAePYSKh9FZcNkVAwqdLkCLv0fztxYG2+avriqxDU1FdajukQ672QtH8XH
	7fktZilTRI13JwKOIOzY3bFHGwYINhQfOr7B60LqltnMLLS+HUpBIWy0BdQ4Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753655879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=YvmaDPLamtdgKZEvLFXA5xGOluQmvnkazO/mqCoHT2Q=;
	b=fe+mArZE/Pl8mgLqStVEd36xwrNLjxu8OVaAjfg+6I627XIwwN7N2U7mgBMcQMgQhQZGHH
	snHTCal8YV9FMGCQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/cleanups for v6.17-rc1
References: <175365567943.581055.6806236199247802443.tglx@xen13>
Message-ID: <175365568651.581055.9100195148414545609.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Jul 2025 00:37:58 +0200 (CEST)

Linus,

please pull the latest timers/cleanups branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-cleanups-=
2025-07-27

up to:  e78f70bad29c: time/timecounter: Fix the lie that struct cyclecounter =
is const


A treewide cleanup of struct cycle_counter const annotations:

 The initial idea of making them const was correct as they were seperate
 instances. When they got embedded into larger data structures, which are
 even modified by the callback this got moot. The only reason why this went
 unnoticed is that the required container_of() casts the const attribute
 forcefully away.

 Stop pretending that it is const.

Note: There was a trivial conflict reported against this vs. net-next, so
whatever you pull second will need a trivial fixup.

Thanks,

	tglx

------------------>
Greg Kroah-Hartman (1):
      time/timecounter: Fix the lie that struct cyclecounter is const


 arch/microblaze/kernel/timer.c                        | 2 +-
 drivers/clocksource/arm_arch_timer.c                  | 2 +-
 drivers/net/can/rockchip/rockchip_canfd-timestamp.c   | 2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c   | 2 +-
 drivers/net/can/usb/gs_usb.c                          | 2 +-
 drivers/net/dsa/mv88e6xxx/chip.h                      | 2 +-
 drivers/net/dsa/mv88e6xxx/ptp.c                       | 6 +++---
 drivers/net/ethernet/amd/xgbe/xgbe-ptp.c              | 2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c      | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c         | 2 +-
 drivers/net/ethernet/cavium/common/cavium_ptp.c       | 2 +-
 drivers/net/ethernet/freescale/fec_ptp.c              | 2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c            | 2 +-
 drivers/net/ethernet/intel/igb/igb_ptp.c              | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c          | 4 ++--
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c | 2 +-
 drivers/net/ethernet/mellanox/mlx4/en_clock.c         | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c   | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c    | 2 +-
 drivers/net/ethernet/pensando/ionic/ionic_phc.c       | 2 +-
 drivers/net/ethernet/qlogic/qede/qede_ptp.c           | 2 +-
 drivers/net/ethernet/ti/cpts.c                        | 2 +-
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c           | 2 +-
 drivers/ptp/ptp_mock.c                                | 2 +-
 drivers/ptp/ptp_vclock.c                              | 2 +-
 include/linux/timecounter.h                           | 6 +++---
 kernel/time/timecounter.c                             | 2 +-
 sound/hda/hdac_stream.c                               | 2 +-
 28 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/timer.c
index ccb4b4b59bca..a2ab67b747a1 100644
--- a/arch/microblaze/kernel/timer.c
+++ b/arch/microblaze/kernel/timer.c
@@ -193,7 +193,7 @@ static struct timecounter xilinx_tc =3D {
 	.cc =3D NULL,
 };
=20
-static u64 xilinx_cc_read(const struct cyclecounter *cc)
+static u64 xilinx_cc_read(struct cyclecounter *cc)
 {
 	return xilinx_read(NULL);
 }
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_a=
rch_timer.c
index 981a578043a5..80ba6a54248c 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -243,7 +243,7 @@ static u64 arch_counter_read(struct clocksource *cs)
 	return arch_timer_read_counter();
 }
=20
-static u64 arch_counter_read_cc(const struct cyclecounter *cc)
+static u64 arch_counter_read_cc(struct cyclecounter *cc)
 {
 	return arch_timer_read_counter();
 }
diff --git a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c b/drivers/ne=
t/can/rockchip/rockchip_canfd-timestamp.c
index fa85a75be65a..72774cd2f94b 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
@@ -8,7 +8,7 @@
=20
 #include "rockchip_canfd.h"
=20
-static u64 rkcanfd_timestamp_read(const struct cyclecounter *cc)
+static u64 rkcanfd_timestamp_read(struct cyclecounter *cc)
 {
 	const struct rkcanfd_priv *priv =3D container_of(cc, struct rkcanfd_priv, c=
c);
=20
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c b/drivers/ne=
t/can/spi/mcp251xfd/mcp251xfd-timestamp.c
index 202ca0d24d03..413a5cb75c13 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
@@ -11,7 +11,7 @@
=20
 #include "mcp251xfd.h"
=20
-static u64 mcp251xfd_timestamp_raw_read(const struct cyclecounter *cc)
+static u64 mcp251xfd_timestamp_raw_read(struct cyclecounter *cc)
 {
 	const struct mcp251xfd_priv *priv;
 	u32 ts_raw =3D 0;
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index bb6335278e46..c9482d6e947b 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -420,7 +420,7 @@ static inline int gs_usb_get_timestamp(const struct gs_us=
b *parent,
 	return 0;
 }
=20
-static u64 gs_usb_timestamp_read(const struct cyclecounter *cc) __must_hold(=
&dev->tc_lock)
+static u64 gs_usb_timestamp_read(struct cyclecounter *cc) __must_hold(&dev->=
tc_lock)
 {
 	struct gs_usb *parent =3D container_of(cc, struct gs_usb, cc);
 	u32 timestamp =3D 0;
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chi=
p.h
index 7d00482f53a3..feddf505c918 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -732,7 +732,7 @@ struct mv88e6xxx_avb_ops {
 };
=20
 struct mv88e6xxx_ptp_ops {
-	u64 (*clock_read)(const struct cyclecounter *cc);
+	u64 (*clock_read)(struct cyclecounter *cc);
 	int (*ptp_enable)(struct ptp_clock_info *ptp,
 			  struct ptp_clock_request *rq, int on);
 	int (*ptp_verify)(struct ptp_clock_info *ptp, unsigned int pin,
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index 1d3b2c94c53e..e8c9207e932e 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -138,7 +138,7 @@ mv88e6xxx_cc_coeff_get(struct mv88e6xxx_chip *chip)
 	}
 }
=20
-static u64 mv88e6352_ptp_clock_read(const struct cyclecounter *cc)
+static u64 mv88e6352_ptp_clock_read(struct cyclecounter *cc)
 {
 	struct mv88e6xxx_chip *chip =3D cc_to_chip(cc);
 	u16 phc_time[2];
@@ -152,7 +152,7 @@ static u64 mv88e6352_ptp_clock_read(const struct cyclecou=
nter *cc)
 		return ((u32)phc_time[1] << 16) | phc_time[0];
 }
=20
-static u64 mv88e6165_ptp_clock_read(const struct cyclecounter *cc)
+static u64 mv88e6165_ptp_clock_read(struct cyclecounter *cc)
 {
 	struct mv88e6xxx_chip *chip =3D cc_to_chip(cc);
 	u16 phc_time[2];
@@ -483,7 +483,7 @@ const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops =3D {
 		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ),
 };
=20
-static u64 mv88e6xxx_ptp_clock_read(const struct cyclecounter *cc)
+static u64 mv88e6xxx_ptp_clock_read(struct cyclecounter *cc)
 {
 	struct mv88e6xxx_chip *chip =3D cc_to_chip(cc);
=20
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c b/drivers/net/ethernet/=
amd/xgbe/xgbe-ptp.c
index 978c4dd01fa0..e8d5c05de77a 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
@@ -13,7 +13,7 @@
 #include "xgbe.h"
 #include "xgbe-common.h"
=20
-static u64 xgbe_cc_read(const struct cyclecounter *cc)
+static u64 xgbe_cc_read(struct cyclecounter *cc)
 {
 	struct xgbe_prv_data *pdata =3D container_of(cc,
 						   struct xgbe_prv_data,
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/e=
thernet/broadcom/bnx2x/bnx2x_main.c
index c9a1a1d504c0..48ad2d6e125b 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -15176,7 +15176,7 @@ void bnx2x_set_rx_ts(struct bnx2x *bp, struct sk_buff=
 *skb)
 }
=20
 /* Read the PHC */
-static u64 bnx2x_cyclecounter_read(const struct cyclecounter *cc)
+static u64 bnx2x_cyclecounter_read(struct cyclecounter *cc)
 {
 	struct bnx2x *bp =3D container_of(cc, struct bnx2x, cyclecounter);
 	int port =3D BP_PORT(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt_ptp.c
index 0669d43472f5..7542b6d2568b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -702,7 +702,7 @@ static void bnxt_unmap_ptp_regs(struct bnxt *bp)
 		  (BNXT_PTP_GRC_WIN - 1) * 4);
 }
=20
-static u64 bnxt_cc_read(const struct cyclecounter *cc)
+static u64 bnxt_cc_read(struct cyclecounter *cc)
 {
 	struct bnxt_ptp_cfg *ptp =3D container_of(cc, struct bnxt_ptp_cfg, cc);
 	u64 ns =3D 0;
diff --git a/drivers/net/ethernet/cavium/common/cavium_ptp.c b/drivers/net/et=
hernet/cavium/common/cavium_ptp.c
index 984f0dd7b62e..61e261657073 100644
--- a/drivers/net/ethernet/cavium/common/cavium_ptp.c
+++ b/drivers/net/ethernet/cavium/common/cavium_ptp.c
@@ -209,7 +209,7 @@ static int cavium_ptp_enable(struct ptp_clock_info *ptp_i=
nfo,
 	return -EOPNOTSUPP;
 }
=20
-static u64 cavium_ptp_cc_read(const struct cyclecounter *cc)
+static u64 cavium_ptp_cc_read(struct cyclecounter *cc)
 {
 	struct cavium_ptp *clock =3D
 		container_of(cc, struct cavium_ptp, cycle_counter);
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/=
freescale/fec_ptp.c
index 876d90832596..c28ca17a81fd 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -96,7 +96,7 @@
  * cyclecounter structure used to construct a ns counter from the
  * arbitrary fixed point registers
  */
-static u64 fec_ptp_read(const struct cyclecounter *cc)
+static u64 fec_ptp_read(struct cyclecounter *cc)
 {
 	struct fec_enet_private *fep =3D
 		container_of(cc, struct fec_enet_private, cc);
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/etherne=
t/intel/e1000e/netdev.c
index 7719e15813ee..b27a61fab371 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -4436,7 +4436,7 @@ u64 e1000e_read_systim(struct e1000_adapter *adapter,
  * e1000e_cyclecounter_read - read raw cycle counter (used by time counter)
  * @cc: cyclecounter structure
  **/
-static u64 e1000e_cyclecounter_read(const struct cyclecounter *cc)
+static u64 e1000e_cyclecounter_read(struct cyclecounter *cc)
 {
 	struct e1000_adapter *adapter =3D container_of(cc, struct e1000_adapter,
 						     cc);
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/=
intel/igb/igb_ptp.c
index 793c96016288..2f1fae2bcdd2 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -73,7 +73,7 @@ static void igb_ptp_tx_hwtstamp(struct igb_adapter *adapter=
);
 static void igb_ptp_sdp_init(struct igb_adapter *adapter);
=20
 /* SYSTIM read access for the 82576 */
-static u64 igb_ptp_read_82576(const struct cyclecounter *cc)
+static u64 igb_ptp_read_82576(struct cyclecounter *cc)
 {
 	struct igb_adapter *igb =3D container_of(cc, struct igb_adapter, cc);
 	struct e1000_hw *hw =3D &igb->hw;
@@ -90,7 +90,7 @@ static u64 igb_ptp_read_82576(const struct cyclecounter *cc)
 }
=20
 /* SYSTIM read access for the 82580 */
-static u64 igb_ptp_read_82580(const struct cyclecounter *cc)
+static u64 igb_ptp_read_82580(struct cyclecounter *cc)
 {
 	struct igb_adapter *igb =3D container_of(cc, struct igb_adapter, cc);
 	struct e1000_hw *hw =3D &igb->hw;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ether=
net/intel/ixgbe/ixgbe_ptp.c
index eef25e11d938..eafb61415bd1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -327,7 +327,7 @@ static void ixgbe_ptp_setup_sdp_X550(struct ixgbe_adapter=
 *adapter)
  * result of SYSTIME is 32bits of "billions of cycles" and 32 bits of
  * "cycles", rather than seconds and nanoseconds.
  */
-static u64 ixgbe_ptp_read_X550(const struct cyclecounter *cc)
+static u64 ixgbe_ptp_read_X550(struct cyclecounter *cc)
 {
 	struct ixgbe_adapter *adapter =3D
 		container_of(cc, struct ixgbe_adapter, hw_cc);
@@ -364,7 +364,7 @@ static u64 ixgbe_ptp_read_X550(const struct cyclecounter =
*cc)
  * cyclecounter structure used to construct a ns counter from the
  * arbitrary fixed point registers
  */
-static u64 ixgbe_ptp_read_82599(const struct cyclecounter *cc)
+static u64 ixgbe_ptp_read_82599(struct cyclecounter *cc)
 {
 	struct ixgbe_adapter *adapter =3D
 		container_of(cc, struct ixgbe_adapter, hw_cc);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c b/drivers/=
net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
index 63130ba37e9d..e52cc6b1a26c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
@@ -193,7 +193,7 @@ static int ptp_pps_on(struct otx2_ptp *ptp, int on, u64 p=
eriod)
 	return otx2_sync_mbox_msg(&ptp->nic->mbox);
 }
=20
-static u64 ptp_cc_read(const struct cyclecounter *cc)
+static u64 ptp_cc_read(struct cyclecounter *cc)
 {
 	struct otx2_ptp *ptp =3D container_of(cc, struct otx2_ptp, cycle_counter);
=20
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_clock.c b/drivers/net/ethe=
rnet/mellanox/mlx4/en_clock.c
index d73a2044dc26..2aeaafcfb993 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_clock.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
@@ -38,7 +38,7 @@
=20
 /* mlx4_en_read_clock - read raw cycle counter (to be used by time counter)
  */
-static u64 mlx4_en_read_clock(const struct cyclecounter *tc)
+static u64 mlx4_en_read_clock(struct cyclecounter *tc)
 {
 	struct mlx4_en_dev *mdev =3D
 		container_of(tc, struct mlx4_en_dev, cycles);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/ne=
t/ethernet/mellanox/mlx5/core/lib/clock.c
index cec18efadc73..214d732d18e9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -343,7 +343,7 @@ static u64 mlx5_read_time(struct mlx5_core_dev *dev,
 			   (u64)timer_l | (u64)timer_h1 << 32;
 }
=20
-static u64 read_internal_timer(const struct cyclecounter *cc)
+static u64 read_internal_timer(struct cyclecounter *cc)
 {
 	struct mlx5_timer *timer =3D container_of(cc, struct mlx5_timer, cycles);
 	struct mlx5_clock *clock =3D container_of(timer, struct mlx5_clock, timer);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c b/drivers/net=
/ethernet/mellanox/mlxsw/spectrum_ptp.c
index e8182dd76c7d..5b9f0844b8f6 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
@@ -131,7 +131,7 @@ static u64 __mlxsw_sp1_ptp_read_frc(struct mlxsw_sp1_ptp_=
clock *clock,
 	return (u64) frc_l | (u64) frc_h2 << 32;
 }
=20
-static u64 mlxsw_sp1_ptp_read_frc(const struct cyclecounter *cc)
+static u64 mlxsw_sp1_ptp_read_frc(struct cyclecounter *cc)
 {
 	struct mlxsw_sp1_ptp_clock *clock =3D
 		container_of(cc, struct mlxsw_sp1_ptp_clock, cycles);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_phc.c b/drivers/net/et=
hernet/pensando/ionic/ionic_phc.c
index 7505efdff8e9..9f5c81d44f99 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_phc.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_phc.c
@@ -290,7 +290,7 @@ static u64 ionic_hwstamp_read(struct ionic *ionic,
 	return (u64)tick_low | ((u64)tick_high << 32);
 }
=20
-static u64 ionic_cc_read(const struct cyclecounter *cc)
+static u64 ionic_cc_read(struct cyclecounter *cc)
 {
 	struct ionic_phc *phc =3D container_of(cc, struct ionic_phc, cc);
 	struct ionic *ionic =3D phc->lif->ionic;
diff --git a/drivers/net/ethernet/qlogic/qede/qede_ptp.c b/drivers/net/ethern=
et/qlogic/qede/qede_ptp.c
index 9d6399a5c780..a38f1e72c62b 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ptp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ptp.c
@@ -181,7 +181,7 @@ static void qede_ptp_task(struct work_struct *work)
 }
=20
 /* Read the PHC. This API is invoked with ptp_lock held. */
-static u64 qede_ptp_read_cc(const struct cyclecounter *cc)
+static u64 qede_ptp_read_cc(struct cyclecounter *cc)
 {
 	struct qede_dev *edev;
 	struct qede_ptp *ptp;
diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index dbbea9146040..2ba4c8795d60 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -181,7 +181,7 @@ void cpts_misc_interrupt(struct cpts *cpts)
 }
 EXPORT_SYMBOL_GPL(cpts_misc_interrupt);
=20
-static u64 cpts_systim_read(const struct cyclecounter *cc)
+static u64 cpts_systim_read(struct cyclecounter *cc)
 {
 	struct cpts *cpts =3D container_of(cc, struct cpts, cc);
=20
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethern=
et/wangxun/libwx/wx_ptp.c
index 2c39b879f977..44f3e6505246 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
@@ -652,7 +652,7 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
 	return 0;
 }
=20
-static u64 wx_ptp_read(const struct cyclecounter *hw_cc)
+static u64 wx_ptp_read(struct cyclecounter *hw_cc)
 {
 	struct wx *wx =3D container_of(hw_cc, struct wx, hw_cc);
=20
diff --git a/drivers/ptp/ptp_mock.c b/drivers/ptp/ptp_mock.c
index e7b459c846a2..bbd14ce24b34 100644
--- a/drivers/ptp/ptp_mock.c
+++ b/drivers/ptp/ptp_mock.c
@@ -41,7 +41,7 @@ struct mock_phc {
 	spinlock_t lock;
 };
=20
-static u64 mock_phc_cc_read(const struct cyclecounter *cc)
+static u64 mock_phc_cc_read(struct cyclecounter *cc)
 {
 	return ktime_get_raw_ns();
 }
diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
index 7febfdcbde8b..2fdeedd60e21 100644
--- a/drivers/ptp/ptp_vclock.c
+++ b/drivers/ptp/ptp_vclock.c
@@ -164,7 +164,7 @@ static const struct ptp_clock_info ptp_vclock_info =3D {
 	.do_aux_work	=3D ptp_vclock_refresh,
 };
=20
-static u64 ptp_vclock_read(const struct cyclecounter *cc)
+static u64 ptp_vclock_read(struct cyclecounter *cc)
 {
 	struct ptp_vclock *vclock =3D cc_to_vclock(cc);
 	struct ptp_clock *ptp =3D vclock->pclock;
diff --git a/include/linux/timecounter.h b/include/linux/timecounter.h
index 0982d1d52b24..dce03a5cafb7 100644
--- a/include/linux/timecounter.h
+++ b/include/linux/timecounter.h
@@ -28,7 +28,7 @@
  * @shift:		cycle to nanosecond divisor (power of two)
  */
 struct cyclecounter {
-	u64 (*read)(const struct cyclecounter *cc);
+	u64 (*read)(struct cyclecounter *cc);
 	u64 mask;
 	u32 mult;
 	u32 shift;
@@ -53,7 +53,7 @@ struct cyclecounter {
  * @frac:		accumulated fractional nanoseconds
  */
 struct timecounter {
-	const struct cyclecounter *cc;
+	struct cyclecounter *cc;
 	u64 cycle_last;
 	u64 nsec;
 	u64 mask;
@@ -100,7 +100,7 @@ static inline void timecounter_adjtime(struct timecounter=
 *tc, s64 delta)
  * the time stamp counter by the number of elapsed nanoseconds.
  */
 extern void timecounter_init(struct timecounter *tc,
-			     const struct cyclecounter *cc,
+			     struct cyclecounter *cc,
 			     u64 start_tstamp);
=20
 /**
diff --git a/kernel/time/timecounter.c b/kernel/time/timecounter.c
index e6285288d765..3d2a354cfe1c 100644
--- a/kernel/time/timecounter.c
+++ b/kernel/time/timecounter.c
@@ -6,7 +6,7 @@
 #include <linux/timecounter.h>
=20
 void timecounter_init(struct timecounter *tc,
-		      const struct cyclecounter *cc,
+		      struct cyclecounter *cc,
 		      u64 start_tstamp)
 {
 	tc->cc =3D cc;
diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index e7f6208af5b0..4a87bef8834f 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -634,7 +634,7 @@ int snd_hdac_stream_set_params(struct hdac_stream *azx_de=
v,
 }
 EXPORT_SYMBOL_GPL(snd_hdac_stream_set_params);
=20
-static u64 azx_cc_read(const struct cyclecounter *cc)
+static u64 azx_cc_read(struct cyclecounter *cc)
 {
 	struct hdac_stream *azx_dev =3D container_of(cc, struct hdac_stream, cc);
=20


