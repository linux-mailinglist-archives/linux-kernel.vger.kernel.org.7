Return-Path: <linux-kernel+bounces-754443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D8CB19456
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 17:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E4F189133D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 15:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97543148830;
	Sun,  3 Aug 2025 15:20:22 +0000 (UTC)
Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11022081.outbound.protection.outlook.com [40.107.149.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862542AD25;
	Sun,  3 Aug 2025 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754234422; cv=fail; b=FwihIfHfcB1EsMKKDbMAZqNQDHPmlORPZG21ZY4dDTZLOmyCfFdk+9Y40agkKwHj/g/m3YEAF2DyZgbEjEHmSVatjrFJDSMaD6yiyH3b22e7wBwfvfO5fsPzqb4Xn7kGImJVBp/iANH23S81Z37jNWoNnx20uBVYF2HllHgMLGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754234422; c=relaxed/simple;
	bh=FbfBGuQG3fm6ZbhTlSXofs5PWNr6lfr3USnCAO2//5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cgmv+WZw75b14aLYMMCzPnpHbNRcvNyy/7fSRDR/Vdxoh1jsHvY2ZDpD7t/OrqHcVPSVyuUUaxzOTxx8TquOgMhwiyNkqr28WVmvvZEHdMPFOQt4lO1A2aW61AOH9zw5H5VZheRFOcSKpUxqK5RxlI5RBwTG6eCFYPG2zscfodg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siewert.io; spf=pass smtp.mailfrom=siewert.io; arc=fail smtp.client-ip=40.107.149.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siewert.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siewert.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=so0DgWGSNdxbUXZ7KFtDNVoV3Oa/g8i7TNUEJxt4XSKsP3okPx9ZkXsa+oIqIWU3n5y9WruD2XYHClGVgU9cWCUlHWd2uruQfMcPDvOOAyLCi2rS8O59km7E9CBoZfKcD7kicjXtCdizUlPce++KllNdoQgb6rR9ENtj9tIKbMBU8uiuI57xYtnlwJXUCPZtF12VsW8RMIUxuo9whVdgOm8SBwncG6rToT/kPqefForZwThawsUba0rm6uSnOvJWrOR+VpC7P5SDUx2syhBuZ3PiiEp+aRC0IcAU+0GBP73bMsFbjplmNqtQ5mf3CLoWTuOS2nLM92Z8Ll2FMNUxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6r4nP2jvygYQMmccG/+HCFpi0hFhndAtAQDo8xAhfQ=;
 b=ZZwyz46+ua/YmSFA3WbIGyGWeYvTxpBu7BeZ/twJavBcs4kxKlB+LPk5yRw30kF0sv0bwEE3oRnMIhhry4qK3lfuVyJORkfWsBFUnj/U44TGbWy6xfH6Amj4LnoQGSewD2lUW6jZvrVSChE5ingby1t2AkSnf23MoiG6CI1vnknJycMu86QHurgghtmqnbIjwsBW1A87wLr+tiviQPlXXHVNVvPOUNUPTMysHQL1uV6xHKb81S/N7Kt4ksFwvhIgBgP8SfieiQIxk5/SAGRV9nh6Mdg6qz5c1r7YN6xdKSZ/rrEdeushwbiuw8AQUfvWDkV9mnpttSXaSFSBu8+Cmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::182)
 by FRYP281MB1898.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:45::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Sun, 3 Aug
 2025 15:20:16 +0000
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::32fc:c799:7f09:62b5]) by FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::32fc:c799:7f09:62b5%7]) with mapi id 15.20.8989.017; Sun, 3 Aug 2025
 15:20:16 +0000
From: Tan Siewert <tan@siewert.io>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Tan Siewert <tan@siewert.io>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ARM: dts: aspeed: e3c246d4i: convert NVMEM content to layout syntax
Date: Sun,  3 Aug 2025 17:19:37 +0200
Message-ID: <20250803151949.68618-1-tan@siewert.io>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250803151822.68080-1-tan@siewert.io>
References: <20250803151822.68080-1-tan@siewert.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0298.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::7) To FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d18:2::182)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR3PPFB3D0CF1D2:EE_|FRYP281MB1898:EE_
X-MS-Office365-Filtering-Correlation-Id: 10658f85-3cdf-4f23-6e25-08ddd2a13ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IxHCyKVWGjAzkzoNDOGpM9yLFFgcqNSGj2besHdqxNUe/Wc8Fhu0IwBvgkCx?=
 =?us-ascii?Q?bCqw7kJ3D/MV9nh/prNmzqEl0ydr4Z2ibQWmN5xhkO3jDZGWulfSCOSGtBrw?=
 =?us-ascii?Q?omFd5BJpAP4bo/8GEx+yAULx42ccHwMbhRNYv9kk4PqU9S8230yHDShSiWNG?=
 =?us-ascii?Q?ifFUuwL+AUdiY+6fCe/LHfZ01s5F2RMIQH6xBKQwgYtyBJxQuzeTWiSwmBNS?=
 =?us-ascii?Q?6L6NHdWSaqLBiAZSSZXqdqiWYwPnaHNgrcRpUcXUB526VQeKxne4wOzo8rrk?=
 =?us-ascii?Q?4AoZh0oFwGded6k4+U1IngFOiRlxz4mPFG6Urh8ShiNFiJzUg4APWEKWKVKd?=
 =?us-ascii?Q?UL8N8MK3hk4QuCJOPOIANmqV+hhE+rcBs+q0Zim+1A5jN+HgSprS1poIiD8Y?=
 =?us-ascii?Q?I0+A7wuMz/BmQ3k1uE55qfa4N/F/64fmagZXRu2gTNjrcoMTm/HXKRTvWopY?=
 =?us-ascii?Q?wrGKoZr+WWUm/y+ro0N7ocMkg/NL+PlJTGui8lk819HpN8He5ckEVqPBR/c2?=
 =?us-ascii?Q?qKu5FdAz0wEszTgjnsf/O4Fg1EXpeNEy9qicduoqLIFHmUYMIJ3pcBYfNHur?=
 =?us-ascii?Q?+vE2JrjL39FbM8sfMNAJxeLrDGbKOilvA6nxSHQthBM2HSUnC/Z5B74wgSBk?=
 =?us-ascii?Q?pUnx2Zn2WfmZ17AgIlCLWU+wuqQRgJrx5dZtU4EGeTC0RUahxOz7o5Jo5kcR?=
 =?us-ascii?Q?zmq+q67Lddbd8BwLJ0rQjCd+g+nNDQM5VceSpnRMN1dpQS5BJ509OfNVmTNy?=
 =?us-ascii?Q?HCIZoMX7V5oEcAolLiu7IcRS8aZMeYMBchbWUCyJ8oqH4sv3PqSzv0PjNfE6?=
 =?us-ascii?Q?+Qbld4zwSOgMhEjPQf17nuPMMV205rsFvzwg3uSY1cAm8d+P9uPqSWhGAOT4?=
 =?us-ascii?Q?6Z4CCVUPfYHJ3eCtuJP/ZO5F6vkUlqq5IC56ADJ93SuI9ua69f+FwMdHtyCE?=
 =?us-ascii?Q?gEVgyRHMEe5uiYOqFsT9yFjD0bkF0Gg+2m1nBsLpv02kD4ZCrk/cxUEaBt2j?=
 =?us-ascii?Q?iMxE5uZDsJjAFHAfqVGOE/UwzAIAGn1fPmWh8vuqCjkRIHIQaRGysWhWOPAk?=
 =?us-ascii?Q?mhgHFbMUOMlq6rllRLueabxEoOEhp1vZOQW0pEBpSP+3YgbjVBC6+mcZhll5?=
 =?us-ascii?Q?/BCw7ZCEbd56SxP6njLm0QE+IIhjvGpDlCqUQ235MNPd4dXjpfWxh5O//P5Q?=
 =?us-ascii?Q?OuLa2z9VXrWdQpXK0nJYPskCZymYq0+tTlXgE+PhZtsQ7wOIZL0NFbhNQ7rT?=
 =?us-ascii?Q?NwKTBskqwd0fwtAbFE0a9gBCf08izv193oBP3374aenHkklkzFWj4IIHmJYH?=
 =?us-ascii?Q?6jM4J7ejVZqiDbnuyRf1fRUvXLiDel31LpDKrRX+APezr0GK6DNBkZtZoT9Z?=
 =?us-ascii?Q?99BzX2bIIbe1PI19lnChfdaDYW+NWq7cq8Mi1qJsS+du2byazpbp8i2Q9kQz?=
 =?us-ascii?Q?JP+cqKG2/2Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(52116014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MIKDOHqkRS8O2tN7UUK1x3Kigayvqmk2Zj9/mHQGV6B3n3tf7BE/nbIEBPFU?=
 =?us-ascii?Q?ZTtmASjwST0orRNdM5Y8rYmqOsBMU+mLD1SyRbTBeHtrFI7a7uNvAT8k/3ei?=
 =?us-ascii?Q?40Z1PkAQrExp4FLIyLzGu9mCtF8AyfAwWukZ7zAG/BfIa1q+5qjpfs3HTXGD?=
 =?us-ascii?Q?zjhp9ivWiS5+mPg6SWEDpAg2jTQBN4qT5QTVIx4gJSoA7TpHFho1dMrFJkqt?=
 =?us-ascii?Q?I9VCxt8MNzIsdg30Go2cXhI6sE7lXqE8/xhb5ZZoFcOTjyoCZbCd4PjlewdJ?=
 =?us-ascii?Q?b8m7O3tr/rD+0+cy3qJsdQ98kWDJcQkHz0Pv0E2M8Eyt1nThnuQ2kJKvG9xu?=
 =?us-ascii?Q?5dNaHiVwc8xCDYFS8c4lvWmGsn7YgbOvPQmPFqoEBKhxN9hZmmKVUFKbVn2A?=
 =?us-ascii?Q?sgc+G1EqMqtFFYbomzRjL0sLWe8S6WA/EuMd+vBojrUHYyzb4ELhl2J7sGgZ?=
 =?us-ascii?Q?CdXJNq/8Z7L5HhgS7J4j8TJ23AMU79KFlQVaqwwrLWsXmT9V0dCNuaz20ZOF?=
 =?us-ascii?Q?SsJbVAmzkqlyoaE/7fjFKeMgNjghaNmpZZr3jJPknOPTS2jznEbFO8sgQZ/v?=
 =?us-ascii?Q?39glB1KBAYW8QAjgh1xW/IkoeN5oZHHlpwSe7TUmP5uvUG9vAJmVn6R7vcpN?=
 =?us-ascii?Q?V07rrp82eGzykAzBh/GbVeNBcrkl8k8crTGEHyNNi0W7B7pSzP57nTSgrE9r?=
 =?us-ascii?Q?7midqHOteZk2oeXHyZlX0ECT97ccFu8u2V611FZK6KK//bcmw8eoHqt+Toxq?=
 =?us-ascii?Q?pXXyxYb6BLzLkLo3sfiF/vW5AHMZ54a0jW3gB6ORTtXdzEdRBE5su5VJZ2sM?=
 =?us-ascii?Q?zMY6CRXGoSdeXY8ZwxIL8pC2GzWxwFRJ9TK+AmWo0izN/n46AGPPhNviaZu/?=
 =?us-ascii?Q?xm0r3dzutzqvXt2d1PSKsuDt06QyAioCjhXU47+DA/Bv/QGya7F076HT62U4?=
 =?us-ascii?Q?XaVMuqAzmHnt9TcWgNWHFRx2ZhNebzUXG+wSv6Obd22BXHWyquT3xgvUOFb6?=
 =?us-ascii?Q?AE9Ds+cyeRXYFw/2MYBwLaTq8j7yneqpIMgh+dt6GTQxTdpV5GJhpyFwSKn8?=
 =?us-ascii?Q?7UaqbXK7TD2HtJqDcVRR2uta3DOxb9E6MFJi+2Ljejz877+T4X9fya10+Uj/?=
 =?us-ascii?Q?Q5VWIKCq0JliQccFpcfh7eH9T6VPK0hsFnZbjUnqgt2x4M8fGn8WWO6SOB68?=
 =?us-ascii?Q?mOXZr/4kSdXqYKvhlZgPCo5agJDrm2HcysQeRgQ9fU/z65sWZJmAvhXRc4iU?=
 =?us-ascii?Q?byxhdmz8GfB9LeLM3LNWw+K1/ols4sy+c+Dp1s5IPBq9j9tNfUaIucoCiAp3?=
 =?us-ascii?Q?njLViXKaEX4mBT3uRMYBLNsAHhZNVfO8JK/5RoDSIQwRRkT8uYH0jnVQ2E1X?=
 =?us-ascii?Q?yL412mR80iy4Q7CcGRFnKPkJ3kUxDAsa3O/kAfHaABN3lhEXsVSoobC9QrJT?=
 =?us-ascii?Q?LQJeyMgiPGV81vy0HHdhxEJWgaPnfHd+HqEiT7Y0XUiwNA5nKDd0JWVUReyf?=
 =?us-ascii?Q?K8P/US0Ph6Dbv8EqfM9E5Dw2K/fQHxXw25/e91hPDvRFV/iZXkGl8hgEY9jB?=
 =?us-ascii?Q?FzmioCcDDLj7FDwdkIlpEvJIWpfw9isbDPktmUXfgG6Ve13GKTZY29PJO7nJ?=
 =?us-ascii?Q?XDhgvsEVMcP3e8WvSMsxzto=3D?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 10658f85-3cdf-4f23-6e25-08ddd2a13ffe
X-MS-Exchange-CrossTenant-AuthSource: FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2025 15:20:16.2882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogwljQEVnUB5l0cKC111fjvzt3bGaU6wnuemvVx9905Yvy6wfZXD3WoAVrk9NlXw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB1898

The used bindings syntax has been deprecated and doesn't work properly
anymore.

Use the newer (and non-deprecated) fixed-layout approach. See commit
bd912c991d2e ("dt-bindings: nvmem: layouts: add fixed-layout") for
details.

Signed-off-by: Tan Siewert <tan@siewert.io>
---
 .../boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts  | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts
index 93190f4e696c..3ebd80db06f9 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts
@@ -106,11 +106,15 @@ eeprom@57 {
 		compatible = "st,24c128", "atmel,24c128";
 		reg = <0x57>;
 		pagesize = <16>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 
-		eth0_macaddress: macaddress@3f80 {
-			reg = <0x3f80 6>;
+		nvmem-layout {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			eth0_macaddress: macaddress@3f80 {
+				reg = <0x3f80 6>;
+			};
 		};
 	};
 };
-- 
2.43.0


