Return-Path: <linux-kernel+bounces-868217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 855E7C04A89
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E493BC6FE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830BD2C11E3;
	Fri, 24 Oct 2025 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="pL2niA+/"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724DF2BEFEF
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761290120; cv=fail; b=c+07QiE4LEIuz3HdnBMAH/4qm3IfYzOpf0DH+K5Ew4wSiZuJWVFTdVXR8fu9PDJ8pZOxajlfcb8AK51LrD48yNU+mpsXh2/Iw+vmz/XvSe9Tl327Yi5uC3vb02P7GYs0JS0xf/tiCkX9qwP0Z8eoNp4tk9KvaP7cjElTh0bARKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761290120; c=relaxed/simple;
	bh=ZZXfYnUXLiugPCse/fxzGnjFc9CPfJxgZFbZk0WSVPA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pR7qiDOyhAQAls3BGE9mjIUGg+IbysrVEQRjeBL5GIl3ON7h6Ykn/La9gOWiowXpthoiNk1zMXhO/6VDMMSTFMNAxpWOTyJGWTFeBc0Tv3WKcPUJVaejnt/B9Q8Dexwqr0WxqFUAeNX34BEpehOhn/7PRnkHwUMuA3nc6i5ap24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=pL2niA+/; arc=fail smtp.client-ip=52.101.52.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGShaflDGBOT55sLCyRCrNKixXswlQWJdQ/vRgiXnK+B97eUW3uzQYAkxg/gBRaCsmi8ew4iCGKccUr7aHxBHtSq7zYEP5p9E2NSteMmfq3/VZA57Nan5cF3QERenEYlrpPsvyPHPyrBnYHSMG5ZXZw8DQ104Bo0M5IIH2YmrivT0lIgIw7VpABFfLxpJXQS72Ec4uYzw6c9KyoLzoVkH/drrvUEpcRKlD3vYuGlJjDC1b3kWyzhVcGXpkpgMziPyMz4uq4+2I8NPcSAe8cW1l2jdtfJo8ZIsrqOIjmw6/exvpc0fPZsfpa9/mjU/sSHn0WrmVa1Gr6isGhXDTnyFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4QIZYwib3XWhgIyeOJAW9/VrZ6QtM6o5l9kRm/FXwg=;
 b=RAEI5CZmGnmuyVou7zZ9uUPWJ8mwOWJkU9kCmV3SQv4kwiztU8saHx5a8DkuFApQf1D1EObb27eN/3f/SOBhiTQ2hyGNHl2qFTT3QYqGuvOBgD0i9Zn+xYZn/nLxrmF0PRIXCHEMKp5715apnxFHAFhrQKsmmHGk3o4Bi3e1LsSN1UZAWbXlZFn5tMZocDLJJxFwiaMBq7L8xYHVJj+5QJpdHYflxvWUTBz2lZ1cgl+Hw7/EU6WduDOyGIfDGeSrqCiWn/8BRh14F+vRB6IvgHICHNqRINIPRhxDkTwxz700gaMM3WKJ5O+w9XdF6/EVwS/PEWUQcr1SX7gAe47n1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4QIZYwib3XWhgIyeOJAW9/VrZ6QtM6o5l9kRm/FXwg=;
 b=pL2niA+/DVDPTWk7Cd4F62cJMZZHnXQNVrZBr+IfoWKv3FKd9gtIEeqY2EmaX/z0qzR+uKeoXQFT3vlXaBgqqzz/o9UxNyuHYUBHjR8ujU973IATabWqMZHOu06SE0wfZXi52RihWQQDjGVWz+4VCrr6L/RVg0JG4Rg6o/bte9T80rQmuDQNDRoYLuJkH3mJn+h3C7kP2Uh8WD+lmQp8VJMobdirfPtcH+aQ9YoEWmH5+k94OPtC8q/jsm/ce6cO7gR8FfJJ8Pq18JMcWW1YFuO1ahNsMd7BiS+8DYNYXQ0V6ntf+fvsdJJk9MS9qwILtqh4O9zkhYOAAST0qURqnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by SA1PR03MB6353.namprd03.prod.outlook.com (2603:10b6:806:1b4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:15:13 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:15:13 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH] mtd: rawnand: cadence: Add support for NV-DDR interface mode
Date: Fri, 24 Oct 2025 15:13:06 +0800
Message-Id: <20251024071306.242227-1-niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU2P306CA0019.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3b::17) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|SA1PR03MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: 930aea18-1b5b-4584-8fe0-08de12cd131a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N8wgVEkloWjHh2mOskJnIDam+dNR4eDS140CFeR1wyYYK0WyNvH3sWeIjlfU?=
 =?us-ascii?Q?gBlPdY8mJd5SG2RpN5CHfpG3UtLeBkVnZQlMB+ftxh8DIMhgzBgtJlJaMhcw?=
 =?us-ascii?Q?er/KfgwDBvrQu9k865/JfFsGZVhDUt/QkvjGoYZeT1qHHrCw7Mhxy6tR1kTV?=
 =?us-ascii?Q?nmRHPhBZ7myHk6wEAayv/Q+CBzoxEQXuP4j2y21wYv5wRzwl69K25xBc4ifL?=
 =?us-ascii?Q?mOr9g6sUmQsnQxcK5HiSgBU5aUKFN5GxJ/6HKwaOVf1idjPz+VjJgenwvSX6?=
 =?us-ascii?Q?3BtvfUyGzCcELdKIbwp+FpgdTLqOmwxPWqwwH4ATEyMllxBL1FBBDDXXn7fT?=
 =?us-ascii?Q?Fljn/6yjpWm0qhDzfbhkSjzxmoOQt1xlHsCjaD1mIzP7HPPfMQ2Yq8aFTGRI?=
 =?us-ascii?Q?dMwox+Xny4PehNf/SuwEJC+hiKG6R+alj2jh2GkYqUwkyAeOwUJqUKOfNX1d?=
 =?us-ascii?Q?v05NUp1qP+xtG0c8zCDMBC6HlLTkPv6Cr5xMmRmwowSEZHidCvPFHtxMia9N?=
 =?us-ascii?Q?aZuF2iP71ZwONZegHTqH79SxmADca/kGnlSayK1C2QFFOkg2JUPmMrZ0cDAr?=
 =?us-ascii?Q?rZmYrN9ZtmviXkUlumVJRcAu2HG3k0JhyHZ3A2wXq4yQv55WOiYESy64smQZ?=
 =?us-ascii?Q?M86enJD8T566JbPqAHMbmhxkP2bdCmEceyOrYL9AKavQoomT4DxxfEFeAHmo?=
 =?us-ascii?Q?RagoSyWIgtZkuZtd3VYcflKFYKB6j/n4QoZcORaAE62ZwxMdTNpUAbluHg/X?=
 =?us-ascii?Q?VXoyvSe/pmkBI5urh9MldqQ2uvWwoj36a6P/J6Xt0U594BnBYBfaxXquEIXe?=
 =?us-ascii?Q?aR+R6MGzIjFSjDhIUUcBiPlyzUlGWP+cVrsDwnY2J/SvxEq/olQJk/7iLBka?=
 =?us-ascii?Q?2NsJv4N9FoNPiw60hQ5mvVi8Oc7mAAjsElDweU+3hZd2QlR3M9zEt5BsehPE?=
 =?us-ascii?Q?8WM+vkcF9nNFzbABlpwTRdQrSGkx9wvHW8JvIyaIKFa3w2yAGLHghG+vVDGE?=
 =?us-ascii?Q?6EvPlb4HCS1tdUP+Fr5tQoVQkOohLQM4aFlWYmkmwXjGy+Fc85H5AjnGSG7J?=
 =?us-ascii?Q?L/9olD2XEsdjOJ1/IWdM74MVWKqRNaNj3U2KTQ+FGKBZ9TGutDboW26FpMWr?=
 =?us-ascii?Q?+1Ow/gT/FkCtzs1EeGzYJ4z0WLxax7A5lXvn923GdVnilC7IlK18LVJaonNP?=
 =?us-ascii?Q?pv6e1EPbhP9y8Gjtk5W1x8VuddZoLYcL8HhMH11vd03IrNug5rdlv5ZFJvyf?=
 =?us-ascii?Q?mKDNlZOLJB3/w81Km8MilCBYSuesBwkTwUkN33yXzsPNvDTbRxpBzX4RugHa?=
 =?us-ascii?Q?NfjZ1J5MMKu0TUfjrM21Sj/NhI5FWIvbqBwLkIX8Fp4e0Yvd5xxLI/g0rphC?=
 =?us-ascii?Q?LV6QQVtuu7/jrw+vNpFkHU+KO84M4dimSZPw48oGvYwiW0sX+fwWlZqEBh3Z?=
 =?us-ascii?Q?b/LH+eaFRcZEO+pH60Jp3ET2K2gDUDd5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eXSvBDtMuZPkW/ILUxoy2Lx7+6UV8O3XvjwUdcmm8BMv2rL0lh3RBy/9IAxn?=
 =?us-ascii?Q?ycxv7Eod/uzl80ZD7BZxK4rLk+rAF4UkOGRbnLyDIx1XB20qcHmn+trgEczx?=
 =?us-ascii?Q?ujQCwF7+7ina3FczGBndSuYJyVluNGiqmjx5BZ+brbY4kvX6w51qRryom2Ze?=
 =?us-ascii?Q?dThFhMgQGz2cyXlcHlDqupYG3aYL+BdeZ6oIay+jE6FO1keVzu7wz/sqGHKZ?=
 =?us-ascii?Q?3HlOnoLuBjwa60+34biHNZGNX50vxqj1kTJsdN6I6kBfpm93d9UAik3sEEGJ?=
 =?us-ascii?Q?0A91jM+YP5QFyeEgLV0ShmUQlk4rm1sACvtawLmWj4JC9fkdS21G7r4mIfpb?=
 =?us-ascii?Q?b8m4o6hwF5EJVz7+bfvFL0bzQrCRppogRpnWyZz0A8h68oWsg7SZD30WtbxQ?=
 =?us-ascii?Q?rzDBDsSU/wbEgIZPlRjEByjjkknPY57qOap/mK3METh/Z40MBq02HOc+mNgl?=
 =?us-ascii?Q?QfWY0zYDZMiELjnouN06cYLwZlZeB4mWMpM3FKgNPngcefRAiwbYivQjgcSo?=
 =?us-ascii?Q?VHJTqcXL5I0NabDhKlJprl9xf8hikCs2uydB+dtn8S9ObYrIxD1tIZuOsmRM?=
 =?us-ascii?Q?N0pwIrW9zmpeDMgdFvLWdhgzSQLkeA1cI12WbghXrVHwI1joofVyMgysF5C1?=
 =?us-ascii?Q?Cm1OotRaMTfsINAB1nqSVGvgApOtEeu7i06G4JjwPjHj35eEw1eK9jNrqjRt?=
 =?us-ascii?Q?UfwTti9A/mNeqEFBuANRrVdmZHCtCYNS6gR3v30beBdcXVw+XWELRogZwT7+?=
 =?us-ascii?Q?Sx7fj8v5/m6FYC6oVcYpLIRxebCy9NJJjRLVrFcaubFByK+s1oNpZhzUINxF?=
 =?us-ascii?Q?WwFSp9jSKgEAN9VbX8NSqriWuKRNNyfKbKJ+sh7ocVj7+uDZgfq2MfJeJZxL?=
 =?us-ascii?Q?W/uAgyz5toFFX3C9Vf9/C60Ey8pnUsABrDSSBhit84HAZqJCHNs9uV9fmLbq?=
 =?us-ascii?Q?a9J2oJyHUwLV3/G/hA6uD7gR79LZbVyEVyeHIEe138p6Fh5oVdWdMDxeffa9?=
 =?us-ascii?Q?LD/whan1vXfDsaD4Ev3KJh4oGbbuQZjHj06pzL61ZfvWw0HgZQUiISLfqMl5?=
 =?us-ascii?Q?8kCuV0GEPQWEecK8uUN7T8UlE3/QnwOHDGELZTEDn79g9fwrk0tE5odqrfC6?=
 =?us-ascii?Q?12RHKgzZaQf720iZmwE7Mnm/LlpJQ67sZAzkbxz5HcQJlMTtoK1aJbR+hLgr?=
 =?us-ascii?Q?GvK7EsSAcL6Ahl90X5M+VH8oHQz40cBlsSZiXbBpQ6YK8QKFSgAwlxzAHbJW?=
 =?us-ascii?Q?dk/8pUtQUTo4sXR6HJubMNGtFdPAoO3wpblDa6L6J+oFMTornq9tPV1G3NOb?=
 =?us-ascii?Q?jrtuVMsw4lj0MugWqKAPVRLZbzFeJhXllCAbGp/1/FO9XzjPTHWXT5mq6JfE?=
 =?us-ascii?Q?BVa9HlEe7sMMdNdE9HLWaVmlAx6xAZh3s6FGnvy5rOfRaa/reO5cOMIowBO4?=
 =?us-ascii?Q?ziAX5y84OvRVDHwiBlebPKZzGYEiYwTrISH1jvKCCe0RvvSkXpmxr7iwr9Ia?=
 =?us-ascii?Q?W8A4Lk6lUe4T5Iajui1sonIQCecHksQqZKI1BzceE82FHXmWvaLaG5b8IkH6?=
 =?us-ascii?Q?LKfWVtfjHHZPLUBGlBQ/B6x0Lt44JeRdj+sUBIto5urlqcwcRY1PlCL5tZe6?=
 =?us-ascii?Q?mwhUTg6lpU2eu/57+qfph1tnGVf5AhIpyRumToSJSZ1n?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930aea18-1b5b-4584-8fe0-08de12cd131a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:15:13.5148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k8593jtG04DAC329iJbfL+6rOBCmBS82olkQlbsxSyxb7MORI5DE8pM5NpIIfoc1I4bSlzsgyByHSWxjWe+MpVgH4hWJmLkWpOkzVQfd6iwXciCDhX7ahBvtcCJKwRH1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6353

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Add support for NV-DDR mode in the Cadence NAND controller driver.

Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---
 .../mtd/nand/raw/cadence-nand-controller.c    | 270 +++++++++++++++++-
 1 file changed, 261 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index 6667eea95597..6be1af4de119 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -199,6 +199,7 @@
 
 /* Common settings. */
 #define COMMON_SET				0x1008
+#define OPR_MODE_NVDDR				BIT(0)
 /* 16 bit device connected to the NAND Flash interface. */
 #define		COMMON_SET_DEVICE_16BIT		BIT(8)
 
@@ -211,12 +212,20 @@
 #define		 SKIP_BYTES_OFFSET_VALUE	GENMASK(23, 0)
 
 /* Timings configuration. */
+#define TOGGLE_TIMINGS_0			0x1014
+#define TOGGLE_TIMINGS_1			0x1018
+
 #define ASYNC_TOGGLE_TIMINGS			0x101c
 #define		ASYNC_TOGGLE_TIMINGS_TRH	GENMASK(28, 24)
 #define		ASYNC_TOGGLE_TIMINGS_TRP	GENMASK(20, 16)
 #define		ASYNC_TOGGLE_TIMINGS_TWH	GENMASK(12, 8)
 #define		ASYNC_TOGGLE_TIMINGS_TWP	GENMASK(4, 0)
 
+#define	SYNC_TIMINGS				0x1020
+#define		SYNC_TCKWR			GENMASK(21, 16)
+#define		SYNC_TWRCK			GENMASK(13, 8)
+#define		SYNC_TCAD			GENMASK(5, 0)
+
 #define	TIMINGS0				0x1024
 #define		TIMINGS0_TADL			GENMASK(31, 24)
 #define		TIMINGS0_TCCS			GENMASK(23, 16)
@@ -226,6 +235,7 @@
 #define	TIMINGS1				0x1028
 #define		TIMINGS1_TRHZ			GENMASK(31, 24)
 #define		TIMINGS1_TWB			GENMASK(23, 16)
+#define		TIMINGS1_TCWAW			GENMASK(15, 8)
 #define		TIMINGS1_TVDLY			GENMASK(7, 0)
 
 #define	TIMINGS2				0x102c
@@ -243,14 +253,23 @@
 
 /* Register controlling DQ related timing. */
 #define PHY_DQ_TIMING				0x2000
+#define		PHY_DQ_TIMING_OE_END	GENMASK(2, 0)
+#define		PHY_DQ_TIMING_OE_START	GENMASK(6, 4)
+#define		PHY_DQ_TIMING_TSEL_END	GENMASK(11, 8)
+#define		PHY_DQ_TIMING_TSEL_START	GENMASK(15, 12)
+
 /* Register controlling DSQ related timing.  */
 #define PHY_DQS_TIMING				0x2004
 #define		PHY_DQS_TIMING_DQS_SEL_OE_END	GENMASK(3, 0)
+#define		PHY_DQS_TIMING_DQS_SEL_OE_START	GENMASK(7, 4)
+#define		PHY_DQS_TIMING_DQS_SEL_TSEL_END	GENMASK(11, 8)
 #define		PHY_DQS_TIMING_PHONY_DQS_SEL	BIT(16)
 #define		PHY_DQS_TIMING_USE_PHONY_DQS	BIT(20)
 
 /* Register controlling the gate and loopback control related timing. */
 #define PHY_GATE_LPBK_CTRL			0x2008
+#define		PHY_GATE_LPBK_CTRL_GATE_CFG		GENMASK(3, 0)
+#define		PHY_GATE_LPBK_CTRL_GATE_CFG_CLOSE	GENMASK(5, 4)
 #define		PHY_GATE_LPBK_CTRL_RDS		GENMASK(24, 19)
 
 /* Register holds the control for the master DLL logic. */
@@ -260,6 +279,12 @@
 /* Register holds the control for the slave DLL logic. */
 #define PHY_DLL_SLAVE_CTRL			0x2010
 
+/* Register controls the DQS related timing. */
+#define PHY_IE_TIMING				0x2014
+#define		PHY_IE_TIMING_DQS_IE_START		GENMASK(10, 8)
+#define		PHY_IE_TIMING_DQ_IE_START		GENMASK(18, 16)
+#define		PHY_IE_TIMING_IE_ALWAYS_ON		BIT(20)
+
 /* This register handles the global control settings for the PHY. */
 #define PHY_CTRL				0x2080
 #define		PHY_CTRL_SDR_DQS		BIT(14)
@@ -375,15 +400,41 @@
 #define BCH_MAX_NUM_CORR_CAPS		8
 #define BCH_MAX_NUM_SECTOR_SIZES	2
 
+/* NVDDR mode specific parameters and register values based on cadence specs */
+#define NVDDR_PHY_RD_DELAY		29
+#define NVDDR_PHY_RD_DELAY_MAX		31
+#define NVDDR_GATE_CFG_OPT		14
+#define NVDDR_GATE_CFG_MIN		7
+#define NVDDR_GATE_CFG_MAX		15
+#define NVDDR_DATA_SEL_OE_START		1
+#define NVDDR_DATA_SEL_OE_START_MAX	7
+#define NVDDR_DATA_SEL_OE_END		6
+#define NVDDR_DATA_SEL_OE_END_MIN	4
+#define NVDDR_DATA_SEL_OE_END_MAX	15
+#define NVDDR_RS_HIGH_WAIT_CNT		7
+#define NVDDR_RS_IDLE_CNT		7
+#define NVDDR_TCWAW_DELAY		250000
+#define NVDDR_TVDLY_DELAY		500000
+#define NVDDR_TOGGLE_TIMINGS_0		0x00000301
+#define NVDDR_TOGGLE_TIMINGS_1		0x0a060102
+#define NVDDR_ASYNC_TOGGLE_TIMINGS	0
+#define NVDDR_PHY_CTRL			0x00004000
+#define NVDDR_PHY_TSEL			0
+#define NVDDR_PHY_DLL_MASTER_CTRL	0x00140004
+#define NVDDR_PHY_DLL_SLAVE_CTRL	0x00003c3c
+
 struct cadence_nand_timings {
 	u32 async_toggle_timings;
+	u32 sync_timings;
 	u32 timings0;
 	u32 timings1;
 	u32 timings2;
 	u32 dll_phy_ctrl;
 	u32 phy_ctrl;
+	u32 phy_dq_timing;
 	u32 phy_dqs_timing;
 	u32 phy_gate_lpbk_ctrl;
+	u32 phy_ie_timing;
 };
 
 /* Command DMA descriptor. */
@@ -2345,11 +2396,9 @@ static inline u32 calc_tdvw(u32 trp_cnt, u32 clk_period, u32 trhoh_min,
 	return (trp_cnt + 1) * clk_period + trhoh_min - trea_max;
 }
 
-static int
-cadence_nand_setup_interface(struct nand_chip *chip, int chipnr,
-			     const struct nand_interface_config *conf)
+static int cadence_nand_setup_sdr_interface(struct nand_chip *chip,
+					    const struct nand_sdr_timings *sdr)
 {
-	const struct nand_sdr_timings *sdr;
 	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
 	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
 	struct cadence_nand_timings *t = &cdns_chip->timings;
@@ -2370,13 +2419,8 @@ cadence_nand_setup_interface(struct nand_chip *chip, int chipnr,
 	u32 dll_phy_dqs_timing = 0, phony_dqs_timing = 0, rd_del_sel = 0;
 	u32 sampling_point;
 
-	sdr = nand_get_sdr_timings(conf);
-	if (IS_ERR(sdr))
-		return PTR_ERR(sdr);
-
 	memset(t, 0, sizeof(*t));
 	/* Sampling point calculation. */
-
 	if (cdns_ctrl->caps2.is_phy_type_dll)
 		phony_dqs_mod = 2;
 	else
@@ -2633,10 +2677,218 @@ cadence_nand_setup_interface(struct nand_chip *chip, int chipnr,
 			PHY_DLL_MASTER_CTRL_BYPASS_MODE);
 		dev_dbg(cdns_ctrl->dev, "PHY_DLL_SLAVE_CTRL_REG_SDR\t%x\n", 0);
 	}
+	return 0;
+}
+
+static int
+cadence_nand_setup_nvddr_interface(struct nand_chip *chip,
+				   const struct nand_nvddr_timings *nvddr)
+{
+	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
+	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
+	struct cadence_nand_timings *t = &cdns_chip->timings;
+	u32 board_delay = cdns_ctrl->board_delay;
+	u32 clk_period = DIV_ROUND_DOWN_ULL(1000000000000ULL,
+					    cdns_ctrl->nf_clk_rate);
+	u32 ddr_clk_ctrl_period = clk_period * 2;
+	u32 if_skew = cdns_ctrl->caps1->if_skew;
+	u32 tceh_cnt, tcs_cnt, tadl_cnt, tccs_cnt;
+	u32 twrck_cnt, tcad_cnt, tckwr_cnt = 0;
+	u32 tfeat_cnt, trhz_cnt, tvdly_cnt, tcwaw_cnt;
+	u32 trhw_cnt, twb_cnt, twhr_cnt;
+	u32 oe_start, oe_end, oe_end_dqsd;
+	u32 rd_del_sel = 0;
+	u32 dqs_driven_by_device, dqs_toogle_by_device, gate_open_delay;
+	u32 dll_phy_gate_open_delay, gate_close_delay, ie_start;
+	u32 dll_phy_rd_delay;
+	u32 reg;
 
+	memset(t, 0, sizeof(*t));
+	twrck_cnt = calc_cycl(nvddr->tWRCK_min, ddr_clk_ctrl_period);
+	tcad_cnt = calc_cycl(nvddr->tCAD_min, ddr_clk_ctrl_period);
+
+	reg = FIELD_PREP(SYNC_TWRCK, twrck_cnt);
+	reg |= FIELD_PREP(SYNC_TCAD, tcad_cnt);
+	t->sync_timings = reg;
+	dev_dbg(cdns_ctrl->dev, "SYNC_TIMINGS_NVDDR\t%08x\n", reg);
+
+	tadl_cnt = calc_cycl((nvddr->tADL_min + if_skew), ddr_clk_ctrl_period);
+	tccs_cnt = calc_cycl((nvddr->tCCS_min + if_skew), ddr_clk_ctrl_period);
+	twhr_cnt = calc_cycl((nvddr->tWHR_min + if_skew), ddr_clk_ctrl_period);
+	trhw_cnt = calc_cycl((nvddr->tRHW_min + if_skew), ddr_clk_ctrl_period);
+	reg = FIELD_PREP(TIMINGS0_TADL, tadl_cnt);
+	reg |= FIELD_PREP(TIMINGS0_TCCS, tccs_cnt);
+	reg |= FIELD_PREP(TIMINGS0_TWHR, twhr_cnt);
+	reg |= FIELD_PREP(TIMINGS0_TRHW, trhw_cnt);
+	t->timings0 = reg;
+	dev_dbg(cdns_ctrl->dev, "TIMINGS0_NVDDR\t%08x\n", reg);
+
+	twb_cnt = calc_cycl((nvddr->tWB_max + board_delay),
+			    ddr_clk_ctrl_period);
+	/*
+	 * Because of the two stage syncflop the value must be increased by 3
+	 * first value is related with sync, second value is related
+	 * with output if delay.
+	 */
+	twb_cnt = twb_cnt + 3 + 5;
+	tvdly_cnt = calc_cycl(NVDDR_TVDLY_DELAY + if_skew, ddr_clk_ctrl_period);
+	tcwaw_cnt = calc_cycl(NVDDR_TCWAW_DELAY, ddr_clk_ctrl_period);
+	trhz_cnt = 1;
+	reg = FIELD_PREP(TIMINGS1_TWB, twb_cnt);
+	reg |= FIELD_PREP(TIMINGS1_TVDLY, tvdly_cnt);
+	reg |= FIELD_PREP(TIMINGS1_TRHZ, trhz_cnt);
+	reg |= FIELD_PREP(TIMINGS1_TCWAW, tcwaw_cnt);
+	t->timings1 = reg;
+	dev_dbg(cdns_ctrl->dev, "TIMINGS1_NVDDR\t%08x\n", reg);
+
+	tfeat_cnt = calc_cycl(nvddr->tFEAT_max, ddr_clk_ctrl_period);
+	if (tfeat_cnt < twb_cnt)
+		tfeat_cnt = twb_cnt;
+
+	tceh_cnt = calc_cycl(nvddr->tCEH_min, ddr_clk_ctrl_period);
+	tcs_cnt = calc_cycl((nvddr->tCS_min + if_skew), ddr_clk_ctrl_period);
+	reg = FIELD_PREP(TIMINGS2_TFEAT, tfeat_cnt);
+	reg |= FIELD_PREP(TIMINGS2_CS_HOLD_TIME, tceh_cnt);
+	reg |= FIELD_PREP(TIMINGS2_CS_SETUP_TIME, tcs_cnt);
+	t->timings2 = reg;
+	dev_dbg(cdns_ctrl->dev, "TIMINGS2_NVDDR\t%08x\n", reg);
+
+	reg = FIELD_PREP(DLL_PHY_CTRL_RS_HIGH_WAIT_CNT, NVDDR_RS_HIGH_WAIT_CNT);
+	reg |= FIELD_PREP(DLL_PHY_CTRL_RS_IDLE_CNT, NVDDR_RS_IDLE_CNT);
+	t->dll_phy_ctrl = reg;
+	dev_dbg(cdns_ctrl->dev, "DLL_PHY_CTRL_NVDDR\t%08x\n", reg);
+
+	reg  = PHY_CTRL_SDR_DQS;
+	t->phy_ctrl = reg;
+	dev_dbg(cdns_ctrl->dev, "PHY_CTRL_REG_NVDDR\t%08x\n", reg);
+
+	dqs_driven_by_device = (nvddr->tDQSD_max + board_delay) / 1000 +
+				if_skew;
+	dqs_toogle_by_device = (nvddr->tDQSCK_max + board_delay) / 1000 -
+				if_skew;
+	gate_open_delay = dqs_toogle_by_device / (clk_period / 1000);
+	if (dqs_toogle_by_device > clk_period / 1000) {
+		if (gate_open_delay > NVDDR_GATE_CFG_OPT)
+			dll_phy_gate_open_delay = NVDDR_GATE_CFG_MAX;
+		else
+			dll_phy_gate_open_delay = gate_open_delay + 1;
+		gate_close_delay = 0;
+	} else {
+		twrck_cnt = calc_cycl(dqs_driven_by_device * 1000, clk_period);
+		dll_phy_gate_open_delay = 1;
+		gate_close_delay = 0;
+
+		reg = FIELD_PREP(SYNC_TCKWR, tckwr_cnt);
+		reg |= FIELD_PREP(SYNC_TWRCK, twrck_cnt);
+		reg |= FIELD_PREP(SYNC_TCAD, tcad_cnt);
+		t->sync_timings = reg;
+		dev_dbg(cdns_ctrl->dev, "SYNC_TIMINGS_NVDDR\t%08x\n", reg);
+	}
+
+	if (dll_phy_gate_open_delay > NVDDR_GATE_CFG_MIN)
+		ie_start = NVDDR_GATE_CFG_MIN;
+	else
+		ie_start = dll_phy_gate_open_delay;
+
+	dll_phy_rd_delay = ((nvddr->tDQSCK_max + board_delay) +
+				(clk_period / 2)) / clk_period;
+	if (dll_phy_rd_delay <= NVDDR_PHY_RD_DELAY)
+		rd_del_sel = dll_phy_rd_delay + 2;
+	else
+		rd_del_sel = NVDDR_PHY_RD_DELAY_MAX;
+
+	reg = FIELD_PREP(PHY_GATE_LPBK_CTRL_GATE_CFG, dll_phy_gate_open_delay);
+	reg |= FIELD_PREP(PHY_GATE_LPBK_CTRL_GATE_CFG_CLOSE, gate_close_delay);
+	reg |= FIELD_PREP(PHY_GATE_LPBK_CTRL_RDS, rd_del_sel);
+	t->phy_gate_lpbk_ctrl = reg;
+	dev_dbg(cdns_ctrl->dev, "PHY_GATE_LPBK_CTRL_REG_NVDDR\t%08x\n", reg);
+
+	oe_end_dqsd = ((nvddr->tDQSD_max / 1000) / ((clk_period / 2) / 1000))
+				+ NVDDR_DATA_SEL_OE_END_MIN;
+	oe_end = (NVDDR_DATA_SEL_OE_END_MIN + oe_end_dqsd) / 2;
+	if (oe_end > NVDDR_DATA_SEL_OE_END_MAX)
+		oe_end = NVDDR_DATA_SEL_OE_END_MAX;
+
+	oe_start = ((nvddr->tDQSHZ_max / 1000) / ((clk_period / 2) / 1000)) + 1;
+	if (oe_start > NVDDR_DATA_SEL_OE_START_MAX)
+		oe_start = NVDDR_DATA_SEL_OE_START_MAX;
+
+	reg = FIELD_PREP(PHY_DQ_TIMING_OE_END, NVDDR_DATA_SEL_OE_END);
+	reg |= FIELD_PREP(PHY_DQ_TIMING_OE_START, NVDDR_DATA_SEL_OE_START);
+	reg |= FIELD_PREP(PHY_DQ_TIMING_TSEL_END, NVDDR_DATA_SEL_OE_END);
+	reg |= FIELD_PREP(PHY_DQ_TIMING_TSEL_START, NVDDR_DATA_SEL_OE_START);
+	t->phy_dq_timing = reg;
+	dev_dbg(cdns_ctrl->dev, "PHY_DQ_TIMING_REG_NVDDR\t%08x\n", reg);
+
+	reg = FIELD_PREP(PHY_DQS_TIMING_DQS_SEL_OE_END, oe_end);
+	reg |= FIELD_PREP(PHY_DQS_TIMING_DQS_SEL_OE_START, oe_start);
+	reg |= FIELD_PREP(PHY_DQS_TIMING_DQS_SEL_TSEL_END, oe_end);
+	t->phy_dqs_timing = reg;
+	dev_dbg(cdns_ctrl->dev, "PHY_DQS_TIMING_REG_NVDDR\t%08x\n", reg);
+
+	reg = FIELD_PREP(PHY_IE_TIMING_DQS_IE_START, ie_start);
+	reg |= FIELD_PREP(PHY_IE_TIMING_DQ_IE_START, ie_start);
+	reg |= FIELD_PREP(PHY_IE_TIMING_IE_ALWAYS_ON, 0);
+	t->phy_ie_timing = reg;
+	dev_dbg(cdns_ctrl->dev, "PHY_IE_TIMING_REG_NVDDR\t%08x\n", reg);
+
+	reg = readl_relaxed(cdns_ctrl->reg + DLL_PHY_CTRL);
+	reg &= ~(DLL_PHY_CTRL_DLL_RST_N |
+		 DLL_PHY_CTRL_EXTENDED_RD_MODE |
+		 DLL_PHY_CTRL_EXTENDED_WR_MODE);
+	writel_relaxed(reg, cdns_ctrl->reg + DLL_PHY_CTRL);
+	writel_relaxed(OPR_MODE_NVDDR, cdns_ctrl->reg + COMMON_SET);
+	writel_relaxed(NVDDR_TOGGLE_TIMINGS_0,
+		       cdns_ctrl->reg + TOGGLE_TIMINGS_0);
+	writel_relaxed(NVDDR_TOGGLE_TIMINGS_1,
+		       cdns_ctrl->reg + TOGGLE_TIMINGS_1);
+	writel_relaxed(NVDDR_ASYNC_TOGGLE_TIMINGS,
+		       cdns_ctrl->reg + ASYNC_TOGGLE_TIMINGS);
+	writel_relaxed(t->sync_timings, cdns_ctrl->reg + SYNC_TIMINGS);
+	writel_relaxed(t->timings0, cdns_ctrl->reg + TIMINGS0);
+	writel_relaxed(t->timings1, cdns_ctrl->reg + TIMINGS1);
+	writel_relaxed(t->timings2, cdns_ctrl->reg + TIMINGS2);
+	writel_relaxed(t->dll_phy_ctrl, cdns_ctrl->reg + DLL_PHY_CTRL);
+	writel_relaxed(t->phy_ctrl, cdns_ctrl->reg + PHY_CTRL);
+	writel_relaxed(NVDDR_PHY_TSEL, cdns_ctrl->reg + PHY_TSEL);
+	writel_relaxed(t->phy_dq_timing, cdns_ctrl->reg + PHY_DQ_TIMING);
+	writel_relaxed(t->phy_dqs_timing, cdns_ctrl->reg + PHY_DQS_TIMING);
+	writel_relaxed(t->phy_gate_lpbk_ctrl,
+		       cdns_ctrl->reg + PHY_GATE_LPBK_CTRL);
+	writel_relaxed(NVDDR_PHY_DLL_MASTER_CTRL,
+		       cdns_ctrl->reg + PHY_DLL_MASTER_CTRL);
+	writel_relaxed(NVDDR_PHY_DLL_SLAVE_CTRL,
+		       cdns_ctrl->reg + PHY_DLL_SLAVE_CTRL);
+	writel_relaxed(t->phy_ie_timing, cdns_ctrl->reg + PHY_IE_TIMING);
+	writel_relaxed((reg | DLL_PHY_CTRL_DLL_RST_N),
+		       cdns_ctrl->reg + DLL_PHY_CTRL);
 	return 0;
 }
 
+static int
+cadence_nand_setup_interface(struct nand_chip *chip, int chipnr,
+			     const struct nand_interface_config *conf)
+{
+	int ret = 0;
+
+	if (nand_interface_is_sdr(conf)) {
+		const struct nand_sdr_timings *sdr = nand_get_sdr_timings(conf);
+
+		if (IS_ERR(sdr))
+			return PTR_ERR(sdr);
+
+		ret = cadence_nand_setup_sdr_interface(chip, sdr);
+	} else if (chipnr >= 0) {
+		const struct nand_nvddr_timings *nvddr = nand_get_nvddr_timings(conf);
+
+		if (IS_ERR(nvddr))
+			return PTR_ERR(nvddr);
+
+		ret = cadence_nand_setup_nvddr_interface(chip, nvddr);
+	}
+	return ret;
+}
+
 static int cadence_nand_attach_chip(struct nand_chip *chip)
 {
 	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
-- 
2.25.1


