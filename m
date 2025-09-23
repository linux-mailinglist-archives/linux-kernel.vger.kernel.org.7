Return-Path: <linux-kernel+bounces-828968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93FAB95F22
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CC387A6BAF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D792324B0B;
	Tue, 23 Sep 2025 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="AWtIMRkr"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021087.outbound.protection.outlook.com [40.107.130.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E3E305E33;
	Tue, 23 Sep 2025 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632967; cv=fail; b=QmJ9MScJTTuzugs/gIf3/9aNv2WeoVfv+ldyFkJGSnVGEXuj/0vppjzrcTNo1U4GHaUMH61fKmvmKWm3DbJ7BGIHYF8cHpBQH0QEAG70atc8081wa+hHyiwXnSQU1k26DlDpkum6c2UP7H1TRiVZFXLb1ndzFJvt0DyoDkIi7Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632967; c=relaxed/simple;
	bh=Xe7rRLImlEHXy9OBD++momjsMvnIGQ2LepmjZzJmIkY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=umFo+jDoFt7VfEsHNMqUJ6gs1X3Z26Nc+1SdbRfprPRPCpHXA45YgIVI4AzpNOWRBBn6MGbVcXGZ4aAX2WoPWdfpNzELIQTEOrwCGZrgKOYyD069maNI2IxV/t/Hg0cpetTEe7wypQMyDTeeKprde3ubAFsoPK9uLrQVkw/vDTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=AWtIMRkr; arc=fail smtp.client-ip=40.107.130.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfynBlx1BiSXYr1TTYJHrkZSSK1Crf7zTVLfH+xaw1NjBrxdd3qve+234Vpbu/J5ucD0Q5XnsTLEPM7V9D3lKoYzEwkliVECHfGb+JnVxxRroU1+Fzq/Z091p+y0kcTL160z9NypR5FoIWfU3IP7GGxZk0I6yVtERW7n4WzQQG1sxTwVrgrLV9r3IQ+Trf9dAZpEQjDJNA6qxtPajU4xS1+Hv983rT87tVYcDKhPRaZk4Qn7P0LzztJ0/K69oKsmGDb7KqegAkA0xolGBldq8kxaIIXc28jOhO/nyuuRtT3bYRocRVdQNMt5KJgiLtaOMF78WgdslkThPU3/Puadmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iT0ccmrBvK839yKyETy0F4gIEnKG9l6AY9bm4RE5yZg=;
 b=SB1tVhQzzyu7e4RioAnNLiTS6K6mFBVJ3BC0sQb0rwaZTbta+o6iGbhwYz9Qdqx961uzhoMDt8F+f7EQC9d/TGVZ+uZZhfLreIxNPxCAnZUmJDI5docXiwFYi/z0ArfCRC8Fqg2TzeTUjydYymcpee8Vn8t3vp0xE9mktVRjmyDt3FiiRRDWPAARNAHVygr47fGL9lMl/nrI0cUXBjkW240i3BK4/ZhdAnVW6Q8KCrmh8RhviO9I0ivT+BTJkY2CHsMzUsyW/CW8jRPBf0Jdpyb9f6q7TogDdy6bg4cyNdzdT9wVslKnYvuDgvMXh+c07CzKMRQp181fEvZIIP4Crw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ti.com smtp.mailfrom=phytec.de; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine header.from=phytec.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iT0ccmrBvK839yKyETy0F4gIEnKG9l6AY9bm4RE5yZg=;
 b=AWtIMRkrc3zy6HOrAGRdElWP6rardeDbWc4Cj1qjWLOuNdu5W7Lfec2TdGJ4YFrvDnBp6psxBcaG+vjq3sBuWUCa2WV5s0hwjO9qk4EnU+vbM6fGtUIbCkAgbHJGIHht6ah8r1CM4Fkr9nFmkdc0/O9SPwLRXl1aR4Nra2xJVx+gudh3HqPRAyLyJ3F14sSub3jYujAUaQ2HxCgtEc4q7oE/27mpS01ckVJmfvMad2XyNK5HQ5Towc0s27Xv0nJonoMD3CkYdMmtP+7aJrDtnR5F4nWyEgeJAxQ0xO3kWzHbM9gGGIyEcQWkvbn23P3rlJQl79CuClLt8IXBJiCfPQ==
Received: from DU6P191CA0012.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::12)
 by AS8P195MB1704.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:521::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 13:09:19 +0000
Received: from DB1PEPF000509EB.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::2f) by DU6P191CA0012.outlook.office365.com
 (2603:10a6:10:540::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Tue,
 23 Sep 2025 13:09:19 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509EB.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 13:09:18 +0000
Received: from ls-radium.phytec (172.25.39.17) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 15:09:15 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 1/2] arm64: dts: ti: k3-am62-wakeup: Enable cpsw_mac_syscon in U-Boot
Date: Tue, 23 Sep 2025 06:09:00 -0700
Message-ID: <20250923130901.4110013-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EB:EE_|AS8P195MB1704:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc267bb-ede7-48ba-b2f9-08ddfaa26787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TvpNP6EFYy9zSzjN3DyTP5b4JryDzHdaVLE6ltJLHh3BVBDFzHNTixVJ5fpX?=
 =?us-ascii?Q?gvK2yEiYFUAyDJJH6llL8M2m7j4rshucW1i0EnDl07hN4EfUDAwa84kKKihL?=
 =?us-ascii?Q?Juy4AbnYtBAcxoyyOtsl5To9jHI4MgTmJLo0HzV0jJYVsceGN60/0rA7GEoA?=
 =?us-ascii?Q?L39xDTiKkxmIo2gQvCa+ad8HVEuJMdfLf6aaf/JlC1Ma4tmgFyzXPzE9DySa?=
 =?us-ascii?Q?S6ub6q2/u2YMFufsdsfGugAouLXWUmu++kH/1GqRGCR4HEaOjSkRhExcQ7Jd?=
 =?us-ascii?Q?evNVO+27nwFGurkUsfyjRd83yzsmTe00DeOJQCfbXjFo4RnBcKkehGVbTwpO?=
 =?us-ascii?Q?Hrd64jHXYNLwdtVzAGPK4ARE7e/3r4Z0Blw6nDiuJUmxOqmRWx1mRmy8otvI?=
 =?us-ascii?Q?AB9TWM7YShLAK0QBsT7/t+nm2etlYzFZpomWXKgg+lBcBEc3TVENlJ4ZmKp4?=
 =?us-ascii?Q?6IXFKhCT1I0TFp0ccsH+9WjfxpQSo2moStfuO7wLJsR6Z/Tr5sdUbai9Tc5q?=
 =?us-ascii?Q?gNg2iXkFzJvxBpqGifqDa8wd5PTPWgSuoByLRCJSKW+npFfWHOcc0sENeC4h?=
 =?us-ascii?Q?SZlioN2dXP6KqYq+jDWmfiuwOVeFfWz9eaL8Biuna27MSUHyfMt5sAedfQkz?=
 =?us-ascii?Q?ad6lN2TkMD+xV5So2PvGm5i3ttJRD5d/iwpDt8UO2WJpNFNko4tfrPzGWPbV?=
 =?us-ascii?Q?idkWiOsszBBUNU2gRqiMe3vTu0/2uhAwT3jGkomW8U3lhOsLlW9onjNDCYFs?=
 =?us-ascii?Q?G5TZDwY0CYvXSs0gSKHdQT4rl7yQy/Xaq9vOS36fL0/buxwhldWP6Lvl5enp?=
 =?us-ascii?Q?A5Tdapwn+t34DhowjYOvNNDaICRd1CVQlH4WGKwEs8wF95+K7RayKq1bBMyo?=
 =?us-ascii?Q?dChQWbxtdhuHvABmVCTs3ylPDHTE6wjtS0MhvtLcR+JtHFEZ2DdwK2t4Tb5f?=
 =?us-ascii?Q?pXjL/e5lVDVatSwVFrzcCjA9F2ylWd5rW55YVO6ZsvgsDdyRaLTt2zaU/RMf?=
 =?us-ascii?Q?COG/3Bo0p0B3ce7qLERCNxFHA/ZPphtoe7aAuk04LLe944lcfG/8Q8OaT0eI?=
 =?us-ascii?Q?I04eqgFZiR+jvuaTaecjM8P1O1NVryo+oiDHKKnNLIM5ngRvT9JHotnJoDYz?=
 =?us-ascii?Q?6eN8guGKMwbNQ/zM/PkLsRT8OA5jHzD13okFY05uSPN9DcSgSIku77lCe7R4?=
 =?us-ascii?Q?Sucr74rRIaY8ZPz4ZuGRlYs2711W6XVgXME4/0dYXd/UTToonboHKK6oxO8t?=
 =?us-ascii?Q?i+Trkebu00iepd1usx0QvKI9d9WW8TNeu7ZTILXawPXGaRI57e2DtlgbycUx?=
 =?us-ascii?Q?3gZzX15L/OR1l1ROHIQS6omGgxV9IprO917XefwrJkIuFGusDw0z/0hvOoyc?=
 =?us-ascii?Q?aRolBvKxbiXPVPih4ca2SkbA3zhUUbfjB1hCJFmFsi/aQbh6C+jW50bob+tq?=
 =?us-ascii?Q?u/+liiQqYI7/5DnlaEj1vhNTReoTRNW1Q2JaJvP9n9dcKo1XcFhBWQjDqfW6?=
 =?us-ascii?Q?OeplVb+YjE8uaRUv1A2QD3rl2+edKEo9CnZB?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:09:18.4355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc267bb-ede7-48ba-b2f9-08ddfaa26787
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1704

Add the "bootph-all" property to cpsw_mac_syscon.

This fuse region contains the internal MAC address. Without this
syscon node enabled, this interface will get a random MAC during
network boot. This is problematic because the AM62x network
boot is using BOOTP protocol for some binaries and this protocol
does not support dynamic lease expiration. Therefore, the DHCP
server can run out of free IP addresses.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
index 6549b7efa656..41ac17e809be 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -30,6 +30,7 @@ opp_efuse_table: syscon@18 {
 		cpsw_mac_syscon: ethernet-mac-syscon@200 {
 			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
 			reg = <0x200 0x8>;
+			bootph-all;
 		};
 
 		usb0_phy_ctrl: syscon@4008 {
-- 
2.25.1


