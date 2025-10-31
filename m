Return-Path: <linux-kernel+bounces-879719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF145C23D32
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FCD94F1D54
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA6530DD2A;
	Fri, 31 Oct 2025 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ArIwWQso"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011003.outbound.protection.outlook.com [40.93.194.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47860303A06;
	Fri, 31 Oct 2025 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899395; cv=fail; b=iyVtsebnat8s3Ow+gnIMHSbDZ76VrV+nTtTI1W+Czmg2/9y3Th+tANlio4hqPf5tAyi57rH8jNxJn0s+OmKyotWVBd4gaXei7eUYHreOvb972Gyku82eb1g+qciby51QhhghexS9umUC0GS45Zit8xQlv94lHOR5hWYgywBiWDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899395; c=relaxed/simple;
	bh=4s9vIEXaUl6Otjjp9DSkdE0OSKZMGrfrWFRtg+muZAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aGK54wXGkCHUOrK3Ni3k79eB6uSyeImi/x/GLgZteYYTadX+2s4koV1HvOBGXAkPbFAlw6W0XkYujKTif45zzJcyICXIGgmihEahApH/Q4oFYUvVjNt8WkKIzxlrnrHu1/iqsClXak5DDknMWlrnN7IgtR+HNSLYZsvyvSzf5kE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ArIwWQso; arc=fail smtp.client-ip=40.93.194.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tyfaap3FLVxe+uZiCdFYP6Uqt5hzNx1SyT5AoVlAzi1ty3lVYeMCbM+XJGsWBKj6rmZ2EBDow7P3XrU6AoUaPn1gzH7ZcllAW0Jc1DkN+qBLOk4GJI2flkk5bnqfYpVwqoE62BZPHMfqTEFj2vCSOBDxtOi6tB+8vCzDrYtSol8NaRq56MGgwMUl/W7j8KjTirepRw/XB8axSABk8lE9ZwXGNmu46Kxw1yI6wOyHKjE3DM31RUhcVtyLPPeGtc1C6/QImTKETBVQxyvg1PSAm1+SEI8vLvtRmgM77Loum+Je6v+sv17g/OK3aJyiGkccGM/WV1uwzfTXQfLdRPWirw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DmfJMPkNzLFJsVBbzXjpqNzvIDYb97RR9EEiOHS1g4=;
 b=q4GslJKGJ4DnN7qwHJlpZK87iojAKUCfSjWjwyN8uLj4cPWF6pB2BMBDM2OMvcoZskfVh24mAdUnzxl87ceHZshwnywHEqGWzK7yWPfCTtP6xMRHkzkmI80dtarVfEXeT/Hqx9WC9LsMUzhnj/LWnucIMJU/qXdNPiAKkHvpAaUdvJnVFw8kj4rEOoVDUTAElB4ErWJsLtBhKeX4uM2Lx52QWk6vfbpNu/kGm827R403Ji967mxGBrllqNN5kvlmEyAS3dwZk9bkLX12ZJZulHZsoLf4HnfItEB/3Th8OtzJxHsJGS2a/GktcoDle2ADb7e0o/TJtisoh8O9aMCm6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DmfJMPkNzLFJsVBbzXjpqNzvIDYb97RR9EEiOHS1g4=;
 b=ArIwWQsoAOpRMQtZAgK+UTCuONl9jK7ClYEm9k1RXGH0ryX1kDbTiTPXjHw3FF51iJ1HTDqFaMvHCu2Mq6pGX9YP3ZZI3khrctG4p8AcQPbxUk3sduznrCw9MUT9siL0ZqKLWaWZr4dG5H6AZ4s2nI34FKAKwrsMN24UPpB1UU7JWeNEW//LqY2oV1HLS928heCov8b8qQ0SriJGvLpeuBrtiWHaydefd1arF7Qq+SlrZWCqiDPLvil2+896sqH/xLsQQT2JjTRI2qPgAjU64PeB7oY/7eb9b1C7sfKYRGiZyGXXDeKaoCeaVvsCyStg0Y+vFnAXk3du34O8BAsNhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 PH0PR03MB5862.namprd03.prod.outlook.com (2603:10b6:510:42::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.12; Fri, 31 Oct 2025 08:29:52 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 08:29:52 +0000
From: adrianhoyin.ng@altera.com
To: alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	wsa+renesas@sang-engineering.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrianhoyin.ng@altera.com
Subject: [RFC PATCH-v2 2/3] arm64: dts: intel: agilex5: Add Altera compatible for I3C controllers
Date: Fri, 31 Oct 2025 16:27:30 +0800
Message-ID: <e6ae69155785f160ea43b5e8be23c358cc8e1653.1761893824.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1761893824.git.adrianhoyin.ng@altera.com>
References: <cover.1761893824.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0053.namprd07.prod.outlook.com
 (2603:10b6:a03:60::30) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|PH0PR03MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 928e0a8e-5b49-4074-8658-08de1857a9a2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kbxsFwQ0xqutIKLOow3cWeonvbGueuh4PDj6gw2kC5XBmcU1II4q2QWyL7Kz?=
 =?us-ascii?Q?2vK0UGo2+fsfiSUF6VvOF5gCGm3rZC3KWX1J+3QMw2hVtkwjmal3nQghIj1m?=
 =?us-ascii?Q?J99u9XmCliuLF+W1bIcZxTYRuj2k+aofj8b7z8jsziTQalne583/x0/lPML5?=
 =?us-ascii?Q?+6dJqT2kmb4g7s+HbJiReo5veAa+4ICMkdj5Hni+UGxTGndk0AiNb8qG5J+P?=
 =?us-ascii?Q?bqG0Sdf3c6Fb1SOoujVg5DbV3Zskmdf5HOEMVpUAGea0UcF30QaHinvKHqDQ?=
 =?us-ascii?Q?uI1UJPHdwnrd+8aj6hlOJH/4EtkTwjqG7a2C0uzrVWPWR2NrWzOtAAUAoAZO?=
 =?us-ascii?Q?nnD23W/52EqL7gbIMxZ2quWFngTVWhBT4RxXuhHXZOD4ohDN8qYeUWJ4M+w3?=
 =?us-ascii?Q?9bcCmhjf2u5f0gyzeCcMA7wgwGtrsp55wK6aTl8Qa+ZOjjUgMMT+hH65ZzBl?=
 =?us-ascii?Q?0HY+yqSb26FrX93ucJr95ooAS9y6hPoRE7aJMcHGnzHQQo59WCkbPnW8383f?=
 =?us-ascii?Q?tak6Q6JmWk8/+Pga4s6gb6WYaLEVhNOIG3E8RUi0b8gIhBm9Gn4DtBzypxn+?=
 =?us-ascii?Q?JT4arX2yRvq2S2TLO2iM+Do58giNv1LUScSbgCBYlKXiCUwQ9NkYUt2sQkI2?=
 =?us-ascii?Q?6zU6G+wa+o/rTJxH9mFOQgzZXuI8oDhhyUPQ1GsTqNcLlCDgfIm/Wtpu+P8L?=
 =?us-ascii?Q?PqjYgGzft3LZm+HislHPALWY0KiZUiwKNxR7kvQkrYqpcwZFARYV6rem8y64?=
 =?us-ascii?Q?NP/MtyOMaB1tG+B5fOutnlwPv5yGZw1lYwAimPD31pTA7wlP9KQ1g0kNSzAz?=
 =?us-ascii?Q?ckBfPJ9IeEuNbGssgjwdjw4LzDH4Gm9hDUG1WHaXU3WekQxkLzNlxeNrA/am?=
 =?us-ascii?Q?fOTV8TR7GNQx7EkxZQdteOXz8Vm+e6MS1h3L5xQSFe6Ktg1QXjPPkk9LMnsO?=
 =?us-ascii?Q?6s/HWjaGqueKeiz05YQtgDSWJt/E6gCBh+UyFCzcDCmChu2+PlDP+kRGOvKI?=
 =?us-ascii?Q?l0rLrib+FtoXud0cLjRFUm4qCh58QGRKHnzSHL5StXLUZHXXwU0VjPFRMMHC?=
 =?us-ascii?Q?NYhHb8SfDVdN7//cKseP0g3Kvvdj7kt8vEUndo/HGs/qPGADSRfv2AtLj9V5?=
 =?us-ascii?Q?qtd/jpX6eTkeov+z1ofbWTccVHQqVCDtMbYF1IgF7SWGldhTe0MSr+0vqWli?=
 =?us-ascii?Q?LB7fFhBOYOWxHMRojD/uNJdh8bUAmUNw1Tt7XMKrEDBns+ITO4uDqHpkHLvg?=
 =?us-ascii?Q?mvOJg63/ssVmxSEnmq9vUalFItpkV6OrONau2New1wMxHLseq34ZJ7wqNgNU?=
 =?us-ascii?Q?GjF18ys5gDu7Mkry1FJVmeMgfdwtMhIMEzkvAoT/ZaG1JbLDdAH0y00JTJUF?=
 =?us-ascii?Q?NIxF8DN1kG6xgA4AAGJ75f0Sg24GWOZAAdF6FUMBO/gWNVQMkcSXoQMKtg43?=
 =?us-ascii?Q?zAW5bYZrmuoXxxtG49PbiGK+dOtcXns1Km66tmHruEU7V06Ykv7ExccWRptA?=
 =?us-ascii?Q?PspuoaeoYslr+ew=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0mI6JCMZNr/bM2AC62MKL7EqDXvcIJc501Cv55Psf8GEaFnARa3tIspc70dS?=
 =?us-ascii?Q?4R00P7dfldSYiA6+TOg3BCu4DI+Ungl07k9VM3s1hv/Tge8VgmvA0NL+5maV?=
 =?us-ascii?Q?sTh1J4Q48zFTtS7Q9KPvnBfkBqBg2WGUvX5PDZxOwbx9P1VpwB5cGTy/ZXTf?=
 =?us-ascii?Q?EiH5sq3eV0/5/jRuvFf1qYlNubc8lKutnxDueJSMumFgwZPGgpor+B0ygSa1?=
 =?us-ascii?Q?W7peywHHZRxAOxOUj3tuterevi2IACblfbX8k2ypOyQNBHv1GDzaSeiNepdF?=
 =?us-ascii?Q?R1/d1OmhqfowTbCTBk3Y/KJ4Ankr/WFdGIyy3yQCwevNNVDfB4R6e1MJifr1?=
 =?us-ascii?Q?Y9U6bbcWQKeMI/2KOrIrX1fhKWwpOk1O5UZvkq3d5PSrPqX3LiPIHtlb6bAe?=
 =?us-ascii?Q?RZpK2BlaTMB6v3LLPG6JhAxY6gXCP/2QS2Io84RxEBmpIt+3RV7tAZAnm/Cm?=
 =?us-ascii?Q?8uVTWFwvcYHsJtBaJRxUS3Mzc4blONgzDZD7NuC7ExWoK2RbXUXPUbnJyZ1x?=
 =?us-ascii?Q?gHhcnqnk7BirR6q9bu4KD7ZUEsTL0BCeMU58FBOqrvsJq5xSNPDdVwxVDFwk?=
 =?us-ascii?Q?oe6DRQGIFW09ck47wBVX1baLaqexuTCCLLIfmeRKzw+whbX3Uzvl7OjoJPRF?=
 =?us-ascii?Q?H/I6KZIWE4UxunDaOc520EUaCakHYiPs6pWna4ubsHSrE/PyQsEP+qRsyPtV?=
 =?us-ascii?Q?W2ALPR2ggXeehO68/7+rNMF5uwk3+IPrFE2b6qQXn3CEjvT1s6lgxiJ0uf1c?=
 =?us-ascii?Q?WpLeAzchw4UcUABA/jZlFw7GkeBJhi7U3+qNr11mCYaOd6idIoKyUqEccckg?=
 =?us-ascii?Q?PCNk4v/3hhPRXUZfiiS4ZZIvtrOjT+ovE6GWu82L10+dDsFMxK5TE1zmelb9?=
 =?us-ascii?Q?0pUvMmwVZC+qPMuQFs6R7NghORNgDQQUntxWJRg4Ii/JU5m/kLmOnMXJQjJM?=
 =?us-ascii?Q?mofDwQ8zwuDhi0knGtzHFVrgkcm4TBiTTJLBQ7PdHhZdUY6MQEj10DWJ59ee?=
 =?us-ascii?Q?OcRSgDSgNmz8m0j7MNr1nCoOChtgQvaqXXNe2iTbVOp0p8IJFqB8P/LdHUAM?=
 =?us-ascii?Q?BliyEtN/9rDaPV+1oherkQsWzDGiezi+d0JSz4NfsgD41uWWkn6iGzqndM2a?=
 =?us-ascii?Q?kKCoXHQXfFuofsD1lSho7lKC4xHk35hVoEGMUIOoJK6TmUsdp85t7l7ARIbH?=
 =?us-ascii?Q?GzVaylAsY8onW+HRjrWPeTwTEMoGtp4HflGxUK6uM9BAcO4MZpv0i3SNFFdS?=
 =?us-ascii?Q?K33Nw7XVxhVorRbCd4hsgqBPI6ImDvY/YRBCWcEEGHyzeCT0B/5bU4vHh3tj?=
 =?us-ascii?Q?XB/LKfAUoXUfrY0UZ4Lqw2dIG50JcMvNs+tDJTp5AD1WyhrEzAIUsLrgsy1S?=
 =?us-ascii?Q?/amczPadw1YvAGVNkUjEeEUw5DVuUOkVH7DJMTyIfeOPuGHn8QwIPgHHRMyg?=
 =?us-ascii?Q?Ij9P/bKDXx6DY4mSxSNZ3Jq5XkOAAHUmhF472cMgodLymOo0n8RFREv+N3GH?=
 =?us-ascii?Q?3pNmNRfYLpt0gWxfIL8SuKGks0cLZcSdvMRhf8Aa3lAIOQ+7zyHN8IzR3/cu?=
 =?us-ascii?Q?2W1UhI0Hh0VHMkC2Nf3dcLMgjAJba3VACbDtGfwLcn2PtQoECw0L7UcZT+VN?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 928e0a8e-5b49-4074-8658-08de1857a9a2
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 08:29:52.3399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+Dg5D6XQCOexswI4CYMfDyjxrij8nAuO8hlO47TmF0uU32a2xks2zsb7E7Z8Y3UKlZ3aVafplUvdIpBCtoxmV+mXYK9Q9uEhglnELrbcis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5862

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Add the "altr,socfpga-dw-i3c-master" compatible string to the
I3C controller nodes on the Agilex5 SoCFPGA platform. This allows
the platform to use the generic Synopsys DW I3C master driver while
enabling platform-specific quirks or configurations associated with
Altera SoCFPGA devices.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 04e99cd7e74b..0e9332107ddb 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -203,7 +203,8 @@ i2c4: i2c@10c02c00 {
 		};
 
 		i3c0: i3c@10da0000 {
-			compatible = "snps,dw-i3c-master-1.00a";
+			compatible = "altr,socfpga-dw-i3c-master",
+						"snps,dw-i3c-master-1.00a";
 			reg = <0x10da0000 0x1000>;
 			#address-cells = <3>;
 			#size-cells = <0>;
@@ -213,7 +214,8 @@ i3c0: i3c@10da0000 {
 		};
 
 		i3c1: i3c@10da1000 {
-			compatible = "snps,dw-i3c-master-1.00a";
+			compatible = "altr,socfpga-dw-i3c-master",
+						"snps,dw-i3c-master-1.00a";
 			reg = <0x10da1000 0x1000>;
 			#address-cells = <3>;
 			#size-cells = <0>;
-- 
2.49.GIT


