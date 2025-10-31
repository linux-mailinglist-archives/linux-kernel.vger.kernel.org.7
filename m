Return-Path: <linux-kernel+bounces-879955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D76D5C24793
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D05CC4EC656
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30305311C24;
	Fri, 31 Oct 2025 10:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ZGgMumiB"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010051.outbound.protection.outlook.com [52.101.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95522334372;
	Fri, 31 Oct 2025 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906823; cv=fail; b=OiCTCP3IObpk70fv4oFzEE2NnSZOQO7SiYX9+F8nHzumgcUxCbFcjG/qGrlY0U9nHtp2sveNUGzg1UiIUkrRMPH9R+CZvouUOXydGYOiTdWUVtBONM1k+8Pg/JW9NFItOxkgaNBLXVIXIqsyMtIVwxTj2dE8bwABQLUHH+OR0H8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906823; c=relaxed/simple;
	bh=LUj/Ktd1Ovk+O+vIFmbIArvhWcOMaI4lIsOyLOPLGbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E7s5Nm8AZfgqEgoE+oVtbxTdKmIBtbEfTU6oAPE1F66gfl4mF2cNz/0hiKV8qnREZFy1As95cn+M9LmgN6U3JwGURucfL1EV6u1FN4KwmgWHEAJ3z+cGhFcJCcw7LnLDt0n6UjcgXXIDzqnlAPuEW3eF1eJ62xUrNqJ3kkmKUqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ZGgMumiB; arc=fail smtp.client-ip=52.101.193.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n10A77DZPnJyHod+IhZl43DIYpP7bGAuZTMhKmtB342XuqvWlTMQgcf7Zc+ONCGufhaTAzIRDzFMKyM4/MA8UqIecLGwSGTfumD9jSp2ENmiLh+GNB6pdekkHobptJvOmjJ2bKHVyJeykV+eXkRpuoLtB0cfZX0tKwlOoHLr9OG06K2ke+8ZfCK+qi2FgbvX7XrzEBp4luswXjkcvU21P+0Mg1Ma7kXLCMpw/hLCwYYrzWlQcu4pzRQC3D92ZYL+skfO1DMJke862+gZWZIed+sHl324wfkmenj4o2Y7ZnJMf9X0gSe9RgV/3/D6FDg2/VKu2yoZgiZI1glVXtuiwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11O5VcaUgby8ND1AU+MaA0BB/Nt83GMtu12Y4uWbo9M=;
 b=SCD+ezLw5eYvOKkNNzkPFOTDX508c9k0z5BIvg6bjdJEomd6z90kTIkUOcYUpKls5DmNNPchXX2gzc9KtOnohzjbGVg7Cbuf7qINElCGMMb1Kzerv23ZqYTYQHj+eTpxgabqydwA92JjMovNVcsvwpeU0nh32dhAJNj7NRpJzWyh3mWtxi/fT1FpzYxNfIE1zlt++NFIIdb2rzUjI8I7hHu7D0yvTTEbfJCEmxhMw/y7bGWEIYb1blP32/RDZWxNZE233DdbtZqKYb2zZsSu959hs415NniobuL+jXrGDvntUoR1ncAm4hLBOP68nHeqcypYYLyw/mP+H8puJ3luGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11O5VcaUgby8ND1AU+MaA0BB/Nt83GMtu12Y4uWbo9M=;
 b=ZGgMumiBmUuuLrIqlxnvH3uYd3ky0DAgXTtqDNjS2je/8XQgEISmd04OclGEZHi96cSGCPSMRzWgkw9M4Lia1FZk1qT/5AsjPZQ2DieI5i4YgwSyxM8biJkTiW+0syx+5OBH0HJVQJX0KA8BEBYVjxuYmTfJoSkKwGw4lCQrXVk2DbcH5NqiO4WsmlpFVQHoRbFMarawqBsRKl6zv6D03BwicU1+g+y7s9CKDPDnUW042SnBrnKS4Mgq8px3mgvorNsc225LSh6HsB1YIwPMWgTUBrdkV+Maq6GlxVnoDXDNkkiCtvuusrailm30r720hBwAE4fMXVBIi4tT2CkZFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 10:33:39 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9253.018; Fri, 31 Oct 2025
 10:33:39 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH 2/2] arm64: dts: socfpga: agilex5: add support for Agilex5 013b board
Date: Fri, 31 Oct 2025 18:31:17 +0800
Message-Id: <20251031103117.910187-3-niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251031103117.910187-1-niravkumarlaxmidas.rabara@altera.com>
References: <20251031103117.910187-1-niravkumarlaxmidas.rabara@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1P15301CA0028.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::16) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|CH8PR03MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: 919bf358-b144-4ddb-305e-08de1868f4da
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NcZZHjIhpNgeC1VHyAwbOE0pZk7yCDmLHUsx3mk9l8b3Cq1Kc3SGmLxEBiJX?=
 =?us-ascii?Q?oARlHQdN8+nh9uPP201SRZH+UsPqOfrVfgB2zvlHx0WvTJJRhu3lmMHLjYxv?=
 =?us-ascii?Q?Ez/BOxzrS9rgGVmecfMcdrU6amip8DKI04bA3nLGecKWQsDxNQbxLcXpOpvr?=
 =?us-ascii?Q?Rv7pdEPcVqh74sDsSM/UFLGPi/H97BIe7SS5FMn6SlqeVDfud1HUbtzlhxPZ?=
 =?us-ascii?Q?taf9uCQ7v1G5fC4ZJzN2V1wQ6hagKYSn4vln1DJrD6d9cSE3ifQ2RygBK6YU?=
 =?us-ascii?Q?tE8nXXFGInt6oBG7bb7Eoo6wRzHQ6+7XcVqBbbyYjaQnBiqmhMJV+VGEcdqo?=
 =?us-ascii?Q?cxKsVQsdB5HMxdMO8BzzEvc8dwDtJ4JJ6aKpOHtp5DnCXrlb2AIO6ID2wl3v?=
 =?us-ascii?Q?7Va6ZUGxSloSQdTe1IU86LqVWe6SoYYUygFgUdOuP1dKgnjQkYyT5O+sUKhH?=
 =?us-ascii?Q?HWMWxv57p04UvzQ3JJDV5nnvmz98DvWyZJvNhMMZ7SyP1Id98s04uK+uEY4b?=
 =?us-ascii?Q?e8Sw9qFbCg+4L6Jul5pVYBVID6tFNuDlxHBPeFxNe04ZXr2j8IWNkZkxn7d7?=
 =?us-ascii?Q?7rnAWtEvb2il70ZQ3y0hovMiWlM+oxa0D7DCJ976NfqR0Al5UCdY6e+DtmYV?=
 =?us-ascii?Q?/g8JLXzRkPreWg/Hs8Xc4+plsQMyI7ND8f3r8IweiqaS0c9XbHhVnc01NffX?=
 =?us-ascii?Q?E587qCIUPRKvc+eARY5zjOgpzaOWlOr++gQlgk3IOJFZTfhdflyE6yyJzdly?=
 =?us-ascii?Q?IlA28Ell9cBR/nXRtcFOZN2+c3lySSaDCYYG9CUJ5TGwQz1RYd3khYYZBo+T?=
 =?us-ascii?Q?Mq7bzzUueEDcb1Vjsa4B5JuhitdXqxBhflFUBX48X+6bJdC0G2uOjXY1XHTU?=
 =?us-ascii?Q?/T559TjP5H7c9FecdaAkACxoGn8WWPpqLcp1xyLiI4VYGeuLACSJmCcmavX4?=
 =?us-ascii?Q?M4USJ29GHCvRkdmWe2kN6kRSnGySGIlckATvgVdOQCGyJy1R1HoNvNHiqnqk?=
 =?us-ascii?Q?7BlXkq+XfWsVc9xaLFzYQ77E4mVSgvvgKefbdYo+aibYfm5H28pTY6ndnPnJ?=
 =?us-ascii?Q?VZCM2zQpWxMljFO0STGtcZj9wYR8bHYc7O9lZkUe/dkTgtJGkw1BsAezD0UW?=
 =?us-ascii?Q?JWE3D/mHy1Ce05puWwOXIXoNUXtzgHfm8tTYmGzpdqQFdZIPFGRg6+XXtLCq?=
 =?us-ascii?Q?M6bRM/on07wVspnVdRm0RynLxMlWRnT46HATWJ2AKOXxhygieeF8X/nY85mt?=
 =?us-ascii?Q?jQZZvxZ3/osrksjLUZrRhCmsmD9r4X63ODfsOpqg75NPtgMl35d+o1N4PKnh?=
 =?us-ascii?Q?l9A4k9sbUeAdkW7WYTJTG9nywy3j+5+yVdRlkkR2MceY23OgML2c8KkRIfDx?=
 =?us-ascii?Q?qA3WVVJI2OcpAULqzcnK/MxhrOXQvDjLKzaB3tGqFCd+u/IVQLebURvvX1xQ?=
 =?us-ascii?Q?YiP+pG+p17V96JKX6HsF2nkwE9cnE4XM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ip2+Lsea/Kh1M4WnrWhMtRABwqu4vs7Zkbb3fhny8yT8fsCWfn/snmz//TKd?=
 =?us-ascii?Q?iiTjkHpbIacSLgBqlRWhxV7WSr+Pe1C3QnU/l2yNGEHRJ4OXPbr8hCeOg+wT?=
 =?us-ascii?Q?frxdiRU6xPid9gbKDteTNIntOZZVUYzz7hkECM8kRqd+EQK3rqT4oa3o4SgX?=
 =?us-ascii?Q?cgzAzRMO0RStUXz23YfP3zkCrUDutoZdTndtQVuxyQ97kWp9mLrKueEqPBZe?=
 =?us-ascii?Q?ffCEOc5KismUt7Ix7KIVxar/hFVgSmfQqHq0unUNSbZIRBZE6xEaHqopJMIg?=
 =?us-ascii?Q?fWXAHU+HC9vbkeqlggTcfLQ0jSLzGlQpHztSJ5mkoPjqvmgLdPuq1DbV/TCe?=
 =?us-ascii?Q?TgfjU5QtvEl84eL+pwjy1ebJyZNJTc1DsWhaWHM0IvmJuRxe43v766TzAQ+G?=
 =?us-ascii?Q?x4EXFZ+Qz0eqGBaxXCPjA+6vuuemHfp7erj3cO0jCaFlnTnVUemJbBnilTlB?=
 =?us-ascii?Q?RWvvW111mcAQMFDDtpQF4ia2XRcPyU5fMxq1tWFxejqASNk35e8d4FFPLnq5?=
 =?us-ascii?Q?0uxvC8nnsGIAryF9cSC3P0ZVaCkCke4eCu5bx+HcEVKeCMGhm+A41htOcARR?=
 =?us-ascii?Q?VvBXIipouH4lpppgQhcYqEgOzA+X9pEST/Unqsm1wh+6aCQUGKZn5UOgAqD/?=
 =?us-ascii?Q?g4t7K945nOfT+SCzZXJC5gJXx8tn3DAlo1NkxUuaLPphedr9/c4ZyEBE3+MB?=
 =?us-ascii?Q?kRG7ms9+btI8ajEZ5vvHh8vKg9MgcKdaxSWRSu809qB13rEE5M1I7degGfMk?=
 =?us-ascii?Q?f0iP0ZGd30PBAzT9wwtAjQbxjq6MsuEBZPtAlNdMD6uuNjf0B6Nr5HLnJqJL?=
 =?us-ascii?Q?c6dNu9v3k7xmwOVQTzuqE+VxSCht2OjSeVuJpQcgkVLX1BqB97wbBR+TxdlU?=
 =?us-ascii?Q?g4L1g9uL1TTbIVM7pvCzbDHvdox9cXGqL+qWcPmHHH2zLu5HmSKVzqar0FWi?=
 =?us-ascii?Q?FamdUhVGCzZDeADhnHleRs9MGq4Sv7eWBRmna5oxxWv8E0KdP6VH/d3izwHt?=
 =?us-ascii?Q?24qxOko/YXHmzdBf24DbzxQeXG/wAMXg52g1PKqtG+DT2jjcmlspiGT5riFp?=
 =?us-ascii?Q?iRihkfh7HcYZ4LharKKZm//+aaW5iNaA4V9JMBJAPxoHbNZYmQxMfMdUxCw3?=
 =?us-ascii?Q?xDLjiN9XQ2/Pq0/TvSNfVQTC34wL86gun6c/QlMWm7DpzpsJmTIFhW696/zM?=
 =?us-ascii?Q?iqTEgraz4SMGJTKcmNRVrarB8vvNhtxjKB/0QQh9YMi5U8feuQLdNy1NdUbZ?=
 =?us-ascii?Q?bEznj5++bh3pm32eNHMzoM6gnHnpNbW6t2H38vMqcqXP482/pKRKZO/uhko4?=
 =?us-ascii?Q?S6ZYHtbpA3PFIJWbtG5CoZCx8vfX8Q48RA+SZzZRmupOnpuLeK9OP3yxzxtM?=
 =?us-ascii?Q?IqRQLJVj+KZHrjG/KfVkcY6FucfXiVzjY+DPckMMdLcTF8fOvqX73BP39ObO?=
 =?us-ascii?Q?ria4F8Z+8KfiqCPi3Of7DPgO+O2d1xwwqB4+XpB13Op/i8Marj1sww5cKYXE?=
 =?us-ascii?Q?pFn98xHLm2AcoRfjQ29nb0JmeeJxNJEXxfcoFp7IqxH3Bxw9A+rq45AR7USn?=
 =?us-ascii?Q?5QV0ao9Gg0hPm6VplnQCWT+6eVcky0MFhf4JMaiortjPh0RNbv+/TFGZkTf6?=
 =?us-ascii?Q?kn7R7FiIL5AcCWwdCOMd44RjVlfc+YFW0cwxkEDOOsWw?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919bf358-b144-4ddb-305e-08de1868f4da
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:33:39.8108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JoTH/1ok9detDWcS0nmu5D41r7HQ0zLiaX5l1lqa9Nrhu1h1FSi3sLzExA8WTz7nJLYtDa+NndHget5rEF/KjB2NR2qprcdOWNMlU5+KKC9QjdPWnWNE17+6ChvAZKaM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR03MB8275

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Add device tree support for the Agilex5 SoCFPGA 013b board, a small
form factor variant compared to other Agilex5 development kits.

Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---
Note: 
This patch depends on the series: "Add iommu supports"
https://lore.kernel.org/all/cover.1760486497.git.khairul.anuar.romli@altera.com/

Patch series "Add iommu supports" is applied to socfpga maintainer's tree 
https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_dts_for_v6.19

 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../dts/intel/socfpga_agilex5_socdk_013b.dts  | 126 ++++++++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_013b.dts

diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
index 33f6d01266b1..391d5cbe50b3 100644
--- a/arch/arm64/boot/dts/intel/Makefile
+++ b/arch/arm64/boot/dts/intel/Makefile
@@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
 				socfpga_agilex_socdk.dtb \
 				socfpga_agilex_socdk_nand.dtb \
 				socfpga_agilex5_socdk.dtb \
+				socfpga_agilex5_socdk_013b.dtb \
 				socfpga_agilex5_socdk_nand.dtb \
 				socfpga_n5x_socdk.dtb
 dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_013b.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_013b.dts
new file mode 100644
index 000000000000..37ff715b7928
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_013b.dts
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025, Altera Corporation
+ */
+#include "socfpga_agilex5.dtsi"
+
+/ {
+	model = "SoCFPGA Agilex5 013B SoCDK";
+	compatible = "intel,socfpga-agilex5-socdk-013b", "intel,socfpga-agilex5";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet2 = &gmac2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led0 {
+			label = "hps_led0";
+			gpios = <&porta 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		led1 {
+			label = "hps_led1";
+			gpios = <&porta 12 GPIO_ACTIVE_HIGH>;
+		};
+
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0x0 0x80000000 0x0 0x0>;
+	};
+};
+
+&gmac2 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&emac2_phy0>;
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		emac2_phy0: ethernet-phy@0 {
+			reg = <0>;
+			rxc-skew-ps = <0>;
+			rxdv-skew-ps = <0>;
+			rxd0-skew-ps = <0>;
+			rxd1-skew-ps = <0>;
+			rxd2-skew-ps = <0>;
+			rxd3-skew-ps = <0>;
+			txc-skew-ps = <0>;
+			txen-skew-ps = <60>;
+			txd0-skew-ps = <60>;
+			txd1-skew-ps = <60>;
+			txd2-skew-ps = <60>;
+			txd3-skew-ps = <60>;
+		};
+	};
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&osc1 {
+	clock-frequency = <25000000>;
+};
+
+&qspi {
+	status = "okay";
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+		m25p,fast-read;
+		cdns,read-delay = <2>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			qspi_boot: partition@0 {
+				label = "u-boot";
+				reg = <0x0 0x00600000>;
+			};
+
+			root: partition@4200000 {
+				label = "root";
+				reg = <0x00600000 0x03a00000>;
+			};
+		};
+	};
+};
+
+&smmu {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&watchdog0 {
+	status = "okay";
+};
-- 
2.25.1


