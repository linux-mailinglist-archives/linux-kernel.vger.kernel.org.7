Return-Path: <linux-kernel+bounces-884210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B9FC2FA0D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9185618869C3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C83C30749E;
	Tue,  4 Nov 2025 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="WqNjUp/2"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB931991CB;
	Tue,  4 Nov 2025 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241488; cv=fail; b=sIPepnLttgVNzVW3CQrJ6WJk7uOh3U/J/eY+cM2xgyvYa4X9qH/1Mg8Ta07ZVMuP7rSDCTfyZVUaotAJSFFKQJir4KxXYLUnDJwJfsIYyp9o/xJHWuTMvA1X5Gzn1N1K0Xg6C1VF3j9hfcmtgKcNLXYNpAu/rHo9iD1KfpSrV+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241488; c=relaxed/simple;
	bh=BaTAruVN1zCqLLWNayH829dwLMrkg+FkiVzPJ4vr+iE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OSKFQW9ZNuOKEb7TJRgS/cdCkyhFKJL6oEfAKBibShI4KmvgJtv3SAcjypKS1yLTszjngLRb48f1n3s+O79wHbFY2J+O0E6BXwXED76DEunbCYzx1lAgPwXtwZh2s12oW/47R2JrTMhQ4NMd1+v2NdPoWLBlrFy692CM2hIJx7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=WqNjUp/2; arc=fail smtp.client-ip=52.101.46.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXUDZdYAgfr3tFKeYLZcvvR9+yI8i61I4RsVZc6yz5A/227Fr8bVOqk+1VpftFVGw3ypoJ0NET2Ch8Uznhaf5tQ0iUM+6YloihaziHtz0jQIHPu4UyFrn0sF/Kg1MOKICDi9r9mStIcTOK+NlNN/Z3RqpJwyPQsYviTmbEj3AZfoJBKnwC77IK+nWMOXgpkgEHpOHDTqbBUOusxtDACqpDgeitWd0iKrf+OiS/JxSwot46M8uUoh0k022AoHpPWwLHCw5FMooSnApnHxf4SaWcCYjco/7Qz8Z2/8j4AdMKGoJR1lnQm8ws7fbPzQwulXI6MXW48jR91rM5xHyZzxlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6Bd3DDgKC4OLaycu7T7yi7+phiL+PuThB8G344zccE=;
 b=FV7eflrK67NkGWhEQdk1npuo893BWdC/1m6uqfAL4YivwTwBCCuy3a7F7tDNa4/qwXfGBlMAMtqvELvHZxho2/U756wlEkk/LhSmuKB9l/JHTBRxy+VzAJPn/e1kZqxjPRwH2w00utml17NWSkZItUG/+plmEPteY4Hr7JTKXHBOq1EJvODaGwNSB4L5ihwOp6wh9f1PQJ3XYIBKUFbKToO2hdcYJNSJuqxmBCxLHiG0FniEcxC8VUHuC2zmxZR3NZ0S7FbbU0RNoBecciamaNbATFmMMU/TlglejNFrvSx/Oo+F5yE+IGb180u4+j0yfC0tiC4KHYFj/QetGmSCjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6Bd3DDgKC4OLaycu7T7yi7+phiL+PuThB8G344zccE=;
 b=WqNjUp/2FzYB0hoPU0DaqIvEF5x7PqUDnFHhrCwyq0mcesAUVqBE1lxI7az7CiBCtto7JMKXOxBu0y7lIFkl+C++4oAc/lFTVw8s5FDIoD/2v4ljP71FIW1dFslJfjdXEKxaNMp29jtfhY+fMjEHaWuupIjagg91THmX7qxV5w+Yi7wl6mpKC3yl5j904U1NAas28SYzTP6YJlNgCKLLiQcJmlD1NWeD24IN53R3G6iIuygIjYZ434ZWwEzuGn5Wi3mkLDl5xIP5WCVJJyg8m3543TO1nSW4Z2rtIQHgszk/0kXlpjcvCQHmwheIdNmGz9LUpPiOJo0Mlat2kaxC2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 PH7PR03MB7509.namprd03.prod.outlook.com (2603:10b6:510:2f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 07:31:24 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 07:31:24 +0000
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
Subject: [PATCH v5 0/3] i3c: dw: Add Altera Agilex5 runtime PM disable quirk
Date: Tue,  4 Nov 2025 15:29:05 +0800
Message-ID: <cover.1762237922.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU2P306CA0016.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3b::14) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|PH7PR03MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 446399b8-4e56-45fd-7b1f-08de1b742857
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J10iI+lNlaf76nwbEcrpW9aAe6EDwpJ1qCOGsynNBP/w0WzRhFFf2W+Yr6ia?=
 =?us-ascii?Q?62HgE/XiQhmKZRSuTPr8hEhpAXYg1khH05TX7ANIhX/B60jAsSbYWeMABzO8?=
 =?us-ascii?Q?+3oY7HqIcIAi2oYJQLbkXa/r3s1MJtcVFQRN0tdi1OLITISz/2e+zjnBY1L6?=
 =?us-ascii?Q?MlH/qewfiFv2c3uNZw3KuuXabXD+ljGnRgpMMcqw8FHx9f/eBUcVEsoE6XJD?=
 =?us-ascii?Q?9es/sIJv5zG+HBvGKG+7rTSUQ/Guy9sPD9gkiYSbtOWgQx4WHBnYnqishXPj?=
 =?us-ascii?Q?Mm7fyJ+/3g3Vg/rtxkzE3XlLiaJTinxk9BZsRTEzqsWEMa+fNegszRyCEKAq?=
 =?us-ascii?Q?p2D/Y2FKE2d9skuRPFVclztWsMOYCUdF49efP+VNWb5N8Elb5VSsUrR/3wmf?=
 =?us-ascii?Q?kjotWPhoVS74XlDlAPnEsMtL80qkdN9wklL+zekKUICyeeN74Pw5lI8m9mcI?=
 =?us-ascii?Q?pVqEBERdBjKnyX5xiPtoH4O6oCSnxs6nZ9VvLnilVFlv4Rpd8TxHqkoWpWWt?=
 =?us-ascii?Q?LdczO46XtrIyHsA8VYuvU64+P270JSynq4cQwqdRYoDi1PlEihcOt7PJY/6m?=
 =?us-ascii?Q?T84J7wE0vECIOP47tPR2CsxEwNMgFzAM/NIRGxjZuSu68AHnhxb6Eqch7cRt?=
 =?us-ascii?Q?z7G9oajBh7ZirOergTehifaVNCbqalo62TurD33R1u2LxGN6rT5VhQNTj2F7?=
 =?us-ascii?Q?jGpJIzBbLyY3f9nvacQffeahg3e5eagGUMcyiIyZB04yA23O7QmMTlhZWRt7?=
 =?us-ascii?Q?h7ddw3TuXSjoZRstvs+1EH3PrYBsFbVDsqP25MT3cCKRirDwblnr7KM23J5M?=
 =?us-ascii?Q?YJ5lQoiLIYQ3fFc3EQRQPD3O7rJUstTJuavVdAlvztOB5/pRrDfHaU0YzoBz?=
 =?us-ascii?Q?nn8gdVaHxl+JOAHxijs13ATTKcwoEPBYjogVCjlIVDub5uBDoCMxKXD+Of+q?=
 =?us-ascii?Q?S8wLTnxhG7mi7t/eKlmcycj3S+PNWpZYqAPC36aW9jPFqxMWXuyo7pN3qtnd?=
 =?us-ascii?Q?zGVKL021qKgDeDN2ZBu6AJ5pD1Sy8DpqkIp1mwIZMdp8D2Wq7PdGdAFoEdfs?=
 =?us-ascii?Q?P1yuh2O2OWbC2My5YWfPYmqNECVfqBUJEmzRgJpGFPOqjVi3klhQ37RiWnAP?=
 =?us-ascii?Q?RyctYpM2OOsNrmWhtlDmVTFxykY531HkOYvVqGJydxkF1FSlQXIiNgZ4HdmU?=
 =?us-ascii?Q?LjshALEH2JbaQq02vsTvcbsHmcm2eNxbG+TKn0boFY+yotFbePI+Fb1dvkdL?=
 =?us-ascii?Q?0pPiJuzORpnNOWxzuhkjQz2coVVbcvgoT71khuVljQ5/NZebbJVAwbdhZBK8?=
 =?us-ascii?Q?DYYymePv07sxtkG42jeYKXUYBpwwSs5VywtMNVOG/sLY7NTIB/KouRtGv2sM?=
 =?us-ascii?Q?Yb5BL7P7kbdalztAZYMPOly1bBWRaVaNl+K3dLPngAk4kLygK23sgZ2MNoBo?=
 =?us-ascii?Q?e8G5WwfEbQatiCmf18yLHSiFdfZDqNFoiZYo15jmXMq7H9PFqGZEKJJHdtgp?=
 =?us-ascii?Q?qXZCeAExnHkESALG6r/U9VTMtg3YkXb1Ll3Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xWw0YEpi5CM8ruiXQJws+LB7pNAu6Fs33moUpQ2Blje9s1lIenSyFCeNiWZl?=
 =?us-ascii?Q?5VkiHPJa6va6BHmcaW5tORLyKbIn4VX2Yw0BfhdHgz0kXo2XQTHkHf2KbmME?=
 =?us-ascii?Q?lepwAkTvutSJxT7wTHmdENOwfg6kGAwA9vVLH5s2BgizNfklgUZmZ0I266eC?=
 =?us-ascii?Q?ik5gqS93k28wl/2MG1qc+9GqVKbXe3kj0yFVHRFNNdsTItPz0j6NqAB3RwqN?=
 =?us-ascii?Q?E4vx47CIWlupSzP4Z2VqKi0SZmLBZVjAsuq1Ys/9Scmd6+jTTUhuI1Nqy1Np?=
 =?us-ascii?Q?5w5e/iE9duKSud1OZPl/xXh3bqIcTZZ2afxYdhbVNJtQR9480ysJpRyskNQD?=
 =?us-ascii?Q?PRUg+tF1nGg1us2brtQHVZua/TP14O3//TcZ/9GVBV/2u5bP9eENQOzputEp?=
 =?us-ascii?Q?DYQQ3DzT8cgezprb+61GQp2/cUVLY8BB/2bfN3Bc8uPu0GeRiDApHqjfeTN3?=
 =?us-ascii?Q?KLpev6ajwQKlpMXSeflMY3GhPWXNtw2aKi+PmwnfRKUYLOzZ9CCCM/CALSrc?=
 =?us-ascii?Q?7jvWFCzwlZAc0L36qTM2gEu0y1VvkqHmz5JEfbfG3zAqSYGO90hYAwTnkIbO?=
 =?us-ascii?Q?hUzIIUS6J3Rzsv9rCp4ZmAYICAH+0+NxpXzFyrxZN/fhqtVNq0mXDxpGmguq?=
 =?us-ascii?Q?ARueD9T4I7+GxPSKEPpF6gQb8LR8uQsgxDLdLyyYXra+raJyBjXqdUD6/Qw1?=
 =?us-ascii?Q?WWNGQA5OZej+YCj4yhCdJASC7JdNvf4hJByb+tzLK5onI58aApdFTBvYLUW+?=
 =?us-ascii?Q?x51X3whHpQh+Xh9C90Ju/wosGII2hvC1Dvp0la2XaTQ0ADUJ/eSJPt2XWa8T?=
 =?us-ascii?Q?ZoiIDmt6PSSCjK2oUvN0IfmM20vGBM215L4Zn8w2Gt0ieMMKqoYZp+Zy++vH?=
 =?us-ascii?Q?zpfhscf1mxUNlBVrCOxjcz5rycgvSK9GHcTRQLPBbseXEhTDBdPY4lyFqiFs?=
 =?us-ascii?Q?3HvczWj8TC/Vjhy1+pcjtWwcZm9LHOImo909qBFu8KEUzdWENxV4SutR7qQw?=
 =?us-ascii?Q?5XPJ+y3t5iQh3cA9SX6DlRf8GodUx1kCzar+RtEbCpNYpCOzKdK6CUePsuqV?=
 =?us-ascii?Q?0As2GIASxkDAoZkChK6oBBWc9KqDGBFT2fMCm2nod/TSqkc1pUOlLZ/g2xvO?=
 =?us-ascii?Q?8ETbU0dZK5afmlcYiV0rce6VYVKG0AVT9cti8sq66yC+bHFxleUpgX1bvD6q?=
 =?us-ascii?Q?xSNAjUH9QrcJkRTqlxbJYmC+SDspow1YkiAApdKtuHXkKorcdG/+t9rNSNPd?=
 =?us-ascii?Q?1tTQEdSVCMZe7kaB9CykKyCI4x40outzjUK33039lTUMVQiUtr9cXnhE49/G?=
 =?us-ascii?Q?+0luY2qou7DW8TKuvWN/Qg8iH3EV7vD6mWbqS70P5ty2bQ05HU1DUExI1m83?=
 =?us-ascii?Q?tTyRmXB9fNcb3fs5vwTLihv2g7XeF9r921kYaKFrRXiR4wjt6sdDux3jc2yc?=
 =?us-ascii?Q?I3NLGpUgMbXm3rR1Q7QHDS71LflGayGM5WKxcdXQWTQIDbxfA7iciUln2QG+?=
 =?us-ascii?Q?xeY8u6JiUJjHQEVTmMgsTwnO9xeA2Wu+PahPa1EVyIZCXYTSxX81wI2IsrPL?=
 =?us-ascii?Q?ZoDolprFeZwk/pMcQIqDnjSTDQppRmQXFEXnAQ/L9TSUH1hMq3AogmcYaEYg?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446399b8-4e56-45fd-7b1f-08de1b742857
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 07:31:24.1863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Iut29fhuc17GKi9bGZFQTXZRa4uu9u3C1kN8oIrCzN0Uxcg5kR3TfOTDnP44ajpx8EjPS3YszJjLr3NtTJ871j8wWTiTGX7O4afARKiwrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7509

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

This patchset adds support for an Altera SoCFPGA-specific quirk
in the Synopsys DesignWare I3C master driver.

While running the I3C compliance test suite on the Altera Agilex5 SoCFPGA,
the I3C bus was observed to hang when a slave device issued an IBI after
the Dynamic Address Assignment (DAA) process completed.

This issue occurs because the controller enters a suspended state after
DAA due to runtime PM being enabled. When suspended, the controller stops
driving the SCL line. As a result, an IBI transfer cannot complete, leaving
the SDA line stuck low and the bus in a hung state.

To address this issue, a new compatible string,
"altr,agilex5-dw-i3c-master", is introduced to identify the
SoC variant. When this compatible string is matched, a new
quirk (DW_I3C_DISABLE_RUNTIME_PM_QUIRK) is applied to keep the
controller enabled by incrementing the runtime PM reference counter
during probe. This ensures the controller remains active to reliably
handle IBI transactions without requiring runtime PM checks throughout
the driver.

---
changelog:
v4->v5:
*Update commit message for better clarity.
*Update implementation to use const struct for better extensibility.
*Add ACPI and Device Tree match handling separation for quirks to maintain
existing behavior consistency.
v3->v4:
*Add reviewed by tag for dt binding.
*Aligned compatible string in dtsi with previous line.
*Update commit message for better clarity.
*Updated implementation to increment the PM reference counter during
probe instead of conditionally bypassing runtime PM APIs. This simplifies
the logic and ensures consistent behavior when the disable-runtime-PM
quirk is applied.
v2->v3:
*Dropped RFC tag.
*Update compatible string to "altr,agilex5-dw-i3c-master" to match actual SoC.
*Update commit message to describe changes correctly.
v1->v2:
*Add new compatible string in dw i3c dt binding to validate against
newly added compatible string.
*Added new compatible string for altr socfpga platform.
*Remove Kconfig that disables runtime PM added in v1.
*Update implementation to disable runtime PM via compatible string
match so that the implementation can be tied to a specific compatible
string so that it does impact the existing behavior for other users.

See previous patch series at:
https://lore.kernel.org/all/22286d459959f2a153ac59d7da46794c0f495c77.1760579799.git.adrianhoyin.ng@altera.com/ 
---

Adrian Ng Ho Yin (3):
  dt-bindings: i3c: snps: Add Altera SoCFPGA compatible
  arm64: dts: intel: agilex5: Add Altera compatible for I3C controllers
  i3c: dw: Disable runtime PM on Agilex5 to avoid bus hang on IBI

 .../bindings/i3c/snps,dw-i3c-master.yaml      |  6 +++-
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi |  6 ++--
 drivers/i3c/master/dw-i3c-master.c            | 31 ++++++++++++++++++-
 3 files changed, 39 insertions(+), 4 deletions(-)

-- 
2.49.GIT


