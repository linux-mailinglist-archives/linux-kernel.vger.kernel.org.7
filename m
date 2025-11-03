Return-Path: <linux-kernel+bounces-882558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EFFC2ABE5
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41D904F2D82
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9522EAB8E;
	Mon,  3 Nov 2025 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="EBexaIWS"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214192EA723;
	Mon,  3 Nov 2025 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162032; cv=fail; b=XWDQ11NxuBCPEEX/Hap7wlHCH9q/BVVU+PVFHIcJHVSwepXB/nze3n2ARvWRauQQAJYhCo1dykSykrLjSA54Mqw1JtPFopbBG+S8fssju9wxm4l72WWKuGnjDVdkmVWGJmxKp2GXpEkSbcHGX2pnZDLrteprDMU19Y5SvLPmb2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162032; c=relaxed/simple;
	bh=1XnlZh1OHtxLEks1cFOBmnvs0Bv4ExetSb0Ui9h2Tc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FrMaCj69bq4oPH/B4P8sZjw6PCKQPFJy1doRUyy7Mb34f2/Vt+prHIwF63gEKGjaXVLy2q+ReyABvlbXjOh4PTCvQsZkiksXkhUBJmMgKv7jfsjVMec5afiRUQfT6CGenh3VOzbz7ifuQmz00M5Bg6pWXybwhxP1ONtZjd7M0wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=EBexaIWS; arc=fail smtp.client-ip=52.101.48.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpVqrR4cKv0qYAFveyyzX8IuJ+luvKtWfNNXt9HzBEYvLy3Wsm1lRGsTOl9e74vawLOL8FGDcCO3R025o8pCz+RyrsQIgqk4qaVxWTwk32eMMjnaFtgmkicBXOSxXmC4/TAJB1tu+OLKgRJGZgt060TvEHMhOVB45jyfVLdpSew1gB+fSR4XWxbiGY5J4KN9iZf1h/VHQmqv2E2WXe5nij7ux+rfK4jvTcdkJGQBJGagIiB3ipNmUFwVS5Lwdq7eq8oxpQQkRGRgIvus1wXOht9K/I30qU24mHm0nkR7P6Sn6YlWMitHmsJiTGivZNJz0nKK6oOfWYkJfbimqE6FOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LP4hE3Yn8QWjlS5STirkrNINJolR93M3hgcypy4q1U=;
 b=Rsp7bJ/Zs/WZx+Pj8hTi5HvIQhX6uYI3jONjeqq1+WOyQk1nISnUsDZWXpvr1BBS5TPklOVRMU27CI0kS2ow2vTGWRzP79ICEoxXDxdL0UX01biRjPYgf7yA5md/kG9WhE7vMoKUAw2Qo/CxrWbmcwa/cau+0u+LoL/BGfOYRA8k1SGnA3WovITANA3N2NFX8I/6OmOMV8Ps6WyeYvIxYQV2jo/BUgq8EZuddMm3tyKbi4R52rUq3PlaVNs79kQ15LH+riKOikFWxyAQyYSCCExdZDPvAdBdTcmiVrKjHoDe660zJKtJ0mu4T0Vjwv2tSCLc4bnYQd2KsHWhEAtx7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LP4hE3Yn8QWjlS5STirkrNINJolR93M3hgcypy4q1U=;
 b=EBexaIWSrvqwJCVV9r5CNg/2d9uziskn2VJpY2nmBXyEEbLs49FSmSFauukWuAgvKEDgY71DPOv4KkUPR/cNNWc9Iym8RO/z4IZ5CNmFlHYP7J+lDBZjl3fujK98GKTubQBgLvKOVKY1FQp1KvhO6bjNGyzyYLiSk3oMlZblpDIXZ9BBT5CTA9xcNEwLwMvmk0MIP6Jz48HMv1H1hV37d2KLGn8XLtiddC1CDd4Yz9vcogD2RhfZcaMr2cmx/nmAFLYkJXKBEZNTxHNICZDAIT9W3NGoiihrOq1oYKpscv7AsQIvrmleZbnxKfYa4G3KPZDnBaB26xONEwD9wOJM5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 DS0PR03MB7252.namprd03.prod.outlook.com (2603:10b6:8:117::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Mon, 3 Nov 2025 09:27:09 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 09:27:09 +0000
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
Subject: [PATCH v4 3/3] i3c: dw: Add runtime PM disable quirk for Altera Agilex5
Date: Mon,  3 Nov 2025 17:24:28 +0800
Message-ID: <ef57accb1c4e7239d27d04b24fdf412b8cb977b5.1762161408.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1762161408.git.adrianhoyin.ng@altera.com>
References: <cover.1762161408.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU2P306CA0002.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:14::9) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|DS0PR03MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: 8467b85e-523c-4cce-d6b1-08de1abb2991
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4qy07aKQ7cAZHUbN6JTpiBmh0mhEupwNGYR2dYModEUkzIapn1g1QXw9gmBL?=
 =?us-ascii?Q?8RThurPeNN3VS/HQnDkhCydKyA7f1fNqt1W3o85lBNkjxdthdRNOSuZk94K0?=
 =?us-ascii?Q?odN3OYNe4umKw+nZp5MPMXyqoNwnkNyHRN3X0W5MQVAcnWtcwn84Vyc/yuUU?=
 =?us-ascii?Q?LA7lvx5E/vo/iRwyiD8wb+xhZatTWK/a0z/3ipOD9M/LNbycwiJkmwc7oG3F?=
 =?us-ascii?Q?8UeYQwDfiriGB2Bpbnpd2XBHutWAYhO6RRwkryTTPg3FY7bQkVF0mu2kZp5l?=
 =?us-ascii?Q?8STrzTQlWE9CHINNoc6wyJp8odGqmJtkwuU3QfVsfa7pDuJuK3+QisnCX5H5?=
 =?us-ascii?Q?TQZSlOHA1RGE6g3ty6UAmcCgHnZRu2WLhowaSPvDTeyEbiEPnl5RKud1uEeJ?=
 =?us-ascii?Q?58zSIuuVXYlg5Uoos8HDbcIRYSNrHChN3q+42/i93KOSDYVSE4oEhwuTln+g?=
 =?us-ascii?Q?9UcnA2pSX9PwLK7KAuQfory241HLagoS8mEdxofQutek3W1Pay41eqhbmmCJ?=
 =?us-ascii?Q?Ap9MVNDbjYHg/9uJD8X4c9zP4Njz69ELaYWbTXTgX0MnJi9NiR5Wq4jmDVND?=
 =?us-ascii?Q?KRtkFtPsO7p1LfetB8mqJ6jLq+/iBOfx+mAhlHe5bmiNQ4PvnHHdt4iWIwe8?=
 =?us-ascii?Q?r8ZsSopf/PYj5/l39u4snyEsmw6JjrnnB2VKWie7SEYVWP3hSJO2yzoLo5yN?=
 =?us-ascii?Q?1V28QUA1FGdwgjdzVlZcfJfl0zjK3ghe04ySPC2wiWGHfJNBEYFTBEuRB8Zq?=
 =?us-ascii?Q?UvKuNtGrOCJIuaFs8n5W3/DXJSeTIOxyr4aJD4kElFm1NmRhGdkVFvT2LYhy?=
 =?us-ascii?Q?LV7LosloFnQnUNRz1w7V6cP7EQDJlYS0w/Y46qvpgkpEHnL6iNrmPWErS4Bt?=
 =?us-ascii?Q?L5mN4bEt2HkJ8TmbymiN03CiXqR2V/F2fnlCbaW/QjerEhJXJP/C/Hejl627?=
 =?us-ascii?Q?4Rw13i2d+EtCDXDG4y9wJRC6xn95uOsS1X7xuxZlVC2a8FUFVdts0OPHu+hw?=
 =?us-ascii?Q?0qMP0pX2GdoyPUjYiz282gVrmY3tUvzck8HZKU4gePRR4eQ2alaXqLg42Rg6?=
 =?us-ascii?Q?+p90eSR1tuVOxz1pWMTO0FQBvzOBnmGi5rWiOA5n6IEBkL4H3Fs7JIBZe049?=
 =?us-ascii?Q?wMp0nfIFL1JIeAv7mje8FaFnAgoIyxJ0B+PaJ8I0isH1NVXGrZp0miNDgOGR?=
 =?us-ascii?Q?eF+iyhnNvfZOzE6uAOlAMxDjMURb5q2h/AKiDf6M3vBU75RYicaG4u9HUyxQ?=
 =?us-ascii?Q?MTqv0W7XDhArxcaKQZ+i3Jd9jCGpDs0YXfii/BDhFEC/2gheHVhjxZckU6uW?=
 =?us-ascii?Q?/MwBrCCPy9OQ8Mc271vi8pEFaPJZjSv2hgPZcouR2JWP61VsoEBvxORRoo6R?=
 =?us-ascii?Q?7Yk+Qe2sgjrOkVktRRiGBumIqR874nFrjDQzHkJIqOsP6PbRhpJMjW8mNX1z?=
 =?us-ascii?Q?vLYripDjwfhsX4FmewhRSF2x9dyfv5f2zXW645vPa+9fa7kqucxmtb6U2DpH?=
 =?us-ascii?Q?q9l83VrGqaS4pio=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c7H1Jg7qNnO3avIvVueyJYDjHRj0pye81vX60ol2Gw3NDl/Mu5GHNBM0d/b/?=
 =?us-ascii?Q?OWfA8nLbU1tBZZafqrCgVYBZaSiPAhT9sy9atODZL1nh+G0MBuN0jrxPNIja?=
 =?us-ascii?Q?LoHmhcCnFZpaPayqGhCZM/9PD6YzEd04sbI3VNFh3Xq/boMuvy3jKgJ29WE2?=
 =?us-ascii?Q?0FnhLX03Hs2uYtYHFncs+wF8XI3YcnJy9u94h1YDUbGrVrSl5zVhDlb+YHgv?=
 =?us-ascii?Q?+baf3u8g7NcssPLaKEhW2cg5TQky7b7f5/Aec8oJSZkcwxNHugTsQFfiT2Jz?=
 =?us-ascii?Q?wrTupd3UlLegRyBJ8YgTmrGXdkflTeiFlbqjfJPrTqEnx9Z2dkKs1rXwACpO?=
 =?us-ascii?Q?4nwwOyBIGv+8DS8iWjD2mHnEN3oAotqlNmx3QL+p2m2p56cyqoGBLIAykCUZ?=
 =?us-ascii?Q?MqE8dZcUDWCCobfLx4j6XYG4nvmepcjQREFQABLTCwN6wXU/ZAIaaWX1ZVto?=
 =?us-ascii?Q?mLZznDhR2cCet+ERlMB35bDUK4IHxNGbv8LqzkG/ARgfaLY9ihFR1Xwt95Lv?=
 =?us-ascii?Q?r3btmX1fT/eRsezwT/Q+Sg5COdRyABHBZdD7ur/mGkBYwU7NPea6ZmJ4UhIk?=
 =?us-ascii?Q?ZxXAOqquIRPHS00CEj8Ed0eTPOEdbe2lnflmRi4Q5K6BCcgKDSfXtrkOANdI?=
 =?us-ascii?Q?7HjPwXMEcTJseGqITTT8KwFKZyRVMLM4M4ha/5p2NoHQg3t98QHZUmE+20JM?=
 =?us-ascii?Q?SPKP3MVxs4MeMpdQCPf1/+R+RU6u4sDMh+qcU0UTlNEsk3hPqu+gpDMO/HkU?=
 =?us-ascii?Q?urq37M5+ly2W5Un+n1cnDssztFMnX2lIayFgg68VhCzBt7ZZpEL0WRIka4fK?=
 =?us-ascii?Q?iRAfXvLk31icyW7IlKBDYYAXjnLzHRQFeJm+rnKBw5uZBCI9gdQqHj6SXcka?=
 =?us-ascii?Q?Dw30bZy1gZMEIOOuoHOGS1b2Oz7y0X43VXLn/+hORDcRoMqfUsZkO2hIBcpc?=
 =?us-ascii?Q?X3JadBcgTy0ZJAof6xtlFgnB7mLp3sNa1jXWk20/4OutI1CxAQrQMiDUHn/b?=
 =?us-ascii?Q?LOdo3nXqC8JipW2/JIpJUa6TYJ6Ew0yy0JPdAz24+LmAE44qFbkGBhn0J8sd?=
 =?us-ascii?Q?nIqAB2gdfIgKknLaAfnjC3Qi6PMq7RWGLIJiCIg3RzmRFVjbuMM/KTm08V70?=
 =?us-ascii?Q?5cQvy0NvPqFL9dTSIfoXJmxc6XN8qNrYtIGj963bxVrZhsHMhSv+uMZY8Dij?=
 =?us-ascii?Q?/LQGNH4bDShnbXBo6KkJd3Ut6qB/ysTNKvFobuZ/6o8r84C63Ne2jm5LOkj5?=
 =?us-ascii?Q?RhLEkp5hPcH/caEuOTpfo3KyVUC9XJttN40GJav4IYWGoNfMJVklmGBasH8+?=
 =?us-ascii?Q?LYgwl705sk/e8tPyyZKFwgse2FDHBmvuHopwedCeHRRHZFxR4UAbRaHUMqow?=
 =?us-ascii?Q?uVzChB1Ds+JEvxtEyM7r+dHr66LiIZj8oOmQjx37Vuqo8/23YfSOLXsOvZXX?=
 =?us-ascii?Q?M5eYguzfv+pl455wf1PvueyKuiwfRPhfslN0LIbskRoWs+J2WUxZZR3GMvwn?=
 =?us-ascii?Q?Z1b7EB2Ge6xlxAScISQ+vkhUb4I+x6MavXUPmpiDOFfm4kY1Bf3w+T0ZrIi/?=
 =?us-ascii?Q?ttECcV8Qzi9G9EFpLDsYKKxZFJE+f7kln6xpOXkJhWH1wtjMosI4jcQY0lZk?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8467b85e-523c-4cce-d6b1-08de1abb2991
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 09:27:09.3454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCiTo07cHa0lKiUSD2xt6mVf6uArpDSg9/5RU7jOohU8t9QeXgPBv2fHrI5X/Ixq31Siu6MmrW5HPw6AFrUxKIMPeE6+SH+djMFGR5r5krA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7252

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

When running compliance tests on the Altera Agilex5 SoCFPGA platform,
it was observed that the I3C bus could enter a hung state when a slave
device issues an IBI after the DAA process completes. This occurs
because the DesignWare I3C master controller enters runtime suspend
once the DAA sequence finishes, causing it to stop driving the SCL
line. As a result, the IBI transfer cannot complete, leaving the SDA
line stuck low and the bus in a hung state.

To address this, introduce a new compatible string,
"altr,agilex5-dw-i3c-master", that applies a quirk to disable runtime
PM for this platform. The quirk keeps the controller enabled by calling
pm_runtime_get_noresume() during probe and balancing it with
pm_runtime_put_noidle() during remove.

This ensures that the controller remains active and avoids bus hangs
triggered by IBIs while maintaining normal behavior for other platforms.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
---
 drivers/i3c/master/dw-i3c-master.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 9ceedf09c3b6..5913822648ca 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -228,6 +228,7 @@
 
 /* List of quirks */
 #define AMD_I3C_OD_PP_TIMING		BIT(1)
+#define DW_I3C_DISABLE_RUNTIME_PM_QUIRK	BIT(2)
 
 struct dw_i3c_cmd {
 	u32 cmd_lo;
@@ -1592,6 +1593,10 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 
 	master->quirks = (unsigned long)device_get_match_data(&pdev->dev);
 
+	/* Keep controller enabled by preventing runtime suspend */
+	if (master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)
+		pm_runtime_get_noresume(&pdev->dev);
+
 	INIT_WORK(&master->hj_work, dw_i3c_hj_work);
 	ret = i3c_master_register(&master->base, &pdev->dev,
 				  &dw_mipi_i3c_ops, false);
@@ -1617,6 +1622,10 @@ void dw_i3c_common_remove(struct dw_i3c_master *master)
 	cancel_work_sync(&master->hj_work);
 	i3c_master_unregister(&master->base);
 
+	/* Balance pm_runtime_get_noresume() from probe() */
+	if (master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)
+		pm_runtime_put_noidle(master->dev);
+
 	pm_runtime_disable(master->dev);
 	pm_runtime_set_suspended(master->dev);
 	pm_runtime_dont_use_autosuspend(master->dev);
@@ -1761,6 +1770,9 @@ static void dw_i3c_shutdown(struct platform_device *pdev)
 
 static const struct of_device_id dw_i3c_master_of_match[] = {
 	{ .compatible = "snps,dw-i3c-master-1.00a", },
+	{ .compatible = "altr,agilex5-dw-i3c-master",
+	  .data = (void *)DW_I3C_DISABLE_RUNTIME_PM_QUIRK,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, dw_i3c_master_of_match);
-- 
2.49.GIT


