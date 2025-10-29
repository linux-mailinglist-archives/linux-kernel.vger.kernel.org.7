Return-Path: <linux-kernel+bounces-877056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3033C1D14B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12C1F4E36D6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2034D363BA7;
	Wed, 29 Oct 2025 19:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kol+tGAS"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010065.outbound.protection.outlook.com [52.101.84.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189A5363B98;
	Wed, 29 Oct 2025 19:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761767723; cv=fail; b=gFSUWqJjUFm3V6xSlFIDi5oa5xb5RrdwTPF3KCaJIn27cI+/ydGj22gVhRMniYUGGMzbx82iYYTkClAOEr0z91lALIMlYwpOMdAgfbzWGjGhIVgpkONGhsKo9CvEsCPO/pEb/RgqhPNrQuSQiDEWZn9uYVjkqKvdg2Ls7IdMzeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761767723; c=relaxed/simple;
	bh=7hvzedHgQC1BC3E0ZUKMidqd/vJ0hjZ0iD6kbs03fyU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rOPv70HOra2x52s7djwyNH4d7iq+y5eAn751Xc5rrc/rzXRDeSLkViZcMMP9hrqQRcCbMDYOMvX65HprxXrCe5Tf6LLCWeE5mU9MS1eQyOoOyZYtyFdBEnQbq9k7l2xnpzH2pbCPd6ZI4ycYubb9HOJmkjmG0DglvTegxBKu1yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kol+tGAS; arc=fail smtp.client-ip=52.101.84.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHqISNwEwPyDcYi5xydr0gs6+7PVKgrBnRUQQJ+CJLFP+Sxo5mZ0GgqjJ8WgJeEmLE02+Vezhj5ltlcAFZVc8RsxavekU/gCWutychGFjfSMZm62Ju54Gg5o3JJXGNn8kbghVs4r1FOsHGc/d9H32OwvRuSIfTA8VRAvrBFoO1CtcNm4bmREKcWwYgw2FNx8dm4yjLhPTGq1me2j40TF4yn8HxQYR2v49d3LpA9V9m7k9yUCWIcH8jNVid2N5tHACBbFPWkFIB177DcGJlB4ZsFeZuhEav3/5dI6FFQuFhNKt+cZZEaUH8sqZ6yYwkVF/h2hP24vjBBnuibaZ7269w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/VXKpmzQCkHS5a/TWBXT/oGTaeRPxl42Z7brHIbJ7g=;
 b=MG3ckaT4ZWRtb4z3+pvrkNUl+9Cw7ve1Gxqu/jvuKJqVBqqxwx1X5lHjJOOgfgt8twQZ76DqDbYpr5+QIs6HYEEY/p6H8YdDZTfQ1/LUY2E5kdCE71krwOutakj/vKb8Zd+9mBmvwmYQw5FwxB0TN9vXaWCHoGUL7hs6MTmKr0PpyKDqBM75BniSZ+cGQaCJBGvwuH3fh2ln3oeQV4gb1uWcVPElYxWA0ZAgDR22vVEGVAoC0R88YK6HybOTJbTFhhQDN0Eiyk1OlU/4iiPwaLrnymKYmVEa245pQ9etUaqpoZC1bOYj5noL5zDJO86D95AajZtu6nwQb3S1OsdQqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/VXKpmzQCkHS5a/TWBXT/oGTaeRPxl42Z7brHIbJ7g=;
 b=Kol+tGASvTa3WsLGwAj/1+v485AHVzpSYfUvYvp39CQTMRVbPZZni5osJB/KkGHkzyOd2VXDqh9y2RcJ1aRb9WhtvNeL16tb28vbOSL5CqcRVSzIwU5/vrBSBAZXBk+ZZS4N6eViR76vWyEgpzg9Mb6rLt67plInR03FPgVXk+9TFs9UG0G7azsKni5D0i+Ai3eiILBUUFYe1wjlPhaK+wlvt2/ayyUdgCdauBiG+F9+zf56gMM+uGLe9JP7XH/7CoP+zIUnMkzGYruLzexyy6mG8KgNB2Ha1Aup3yfI6Fq3NsrMBK+vBuuZr0q4HnSVYedmTxZN++Mz9yZHIJSlKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV4PR04MB11377.eurprd04.prod.outlook.com (2603:10a6:150:29c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 19:55:17 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 19:55:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 29 Oct 2025 15:54:44 -0400
Subject: [PATCH 08/12] arm64: dts: imx8qxp-mek: add fec2 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-8qxp_dts-v1-8-cf61b7e5fc78@nxp.com>
References: <20251029-8qxp_dts-v1-0-cf61b7e5fc78@nxp.com>
In-Reply-To: <20251029-8qxp_dts-v1-0-cf61b7e5fc78@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761767689; l=2558;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=7hvzedHgQC1BC3E0ZUKMidqd/vJ0hjZ0iD6kbs03fyU=;
 b=qh0CNiKtrC2+F0qb7E1+KAWIHCz7k8zCR0w/nuzEhrGH/FUzaSPqzgj5Ydm4pqLTlc6tpI0K8
 W1nfRg2iRPdAvazMJtibrnbnHobJvUJLgq4ALUm81/BqF1M4kcCUmWB
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::24) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV4PR04MB11377:EE_
X-MS-Office365-Filtering-Correlation-Id: e89bcb89-7404-4c3b-e611-08de17251534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWJVdE9DYi8vbklCaDlmL2VBc25mMW1nY1FnRlhMMkNFeWh6OTBLMWFGanBy?=
 =?utf-8?B?eHhWZE9lcE9aSHdEYmRKc1JST2gzR29aaVhmL1QyZFBXUkErWjBsbDhVZTZI?=
 =?utf-8?B?TmVuTnp1cm1udDMvYVJzZHhkK2xVYSs0cGw0S0lldForSHQzenFzMldBaVJU?=
 =?utf-8?B?d1dwUnBMSVlXVTk3ajlacXQ0UHU5RU9KT3BzWSs5TFlPZU8wUHJGSmFhSC85?=
 =?utf-8?B?aCtWVlRJOHQxUHNQSm10RTFnWUlJVE44MmxJR3UwMGpPNUVnZEk2Yjdoalgz?=
 =?utf-8?B?bWtxeVFvc1F0RVQyaFlqalArVUZvOG1UU0ZZVHB6UWhNUVNEenE4WGhiY3V2?=
 =?utf-8?B?S0VRbDFVdGtYaEdyUklGTDVTck51OVpQWldiUUh6WDk2enVFNnA0SFE1YVY2?=
 =?utf-8?B?ei9NOE1lSHZXU1B6a2oySDAwV3pKTWUyNE9zR1plVlo3NGhUdkNuOC9vVGhw?=
 =?utf-8?B?TCtpak5RNDJQZjV0SHZQc3o5SGN2MmNzNkZGNmVSRFhzWCtzeFlmRUFkMnFv?=
 =?utf-8?B?eTZlTnpmMDBnanoyTGJ2VWNHYUtTMks2dG5TSkwwYkMzamxjQXl6dFNCalRY?=
 =?utf-8?B?TkY1bFBnVDdpcnhZTlZPMkxBd1F1cUdxUUlhbjhXT2cyZmpBSHBMM1RaeDhT?=
 =?utf-8?B?RHFzRVM2K3dvWld2eFJTRzdlMU5GTm5rSEF2c2dHR01nTjZDaEJRazliZHcv?=
 =?utf-8?B?cHlYMHBLTjBoZGRudjBTNzhLN3JsMnlsMkgwWnpCcU5HT1hCSGZaUk55NXhz?=
 =?utf-8?B?V01rdDNiK3ROY2I0b1hLaGJ5VFUyOUIyaTA0ZHdMRzdTN04vMjg0TWo5S3dJ?=
 =?utf-8?B?MWd0VnNkZTVPQ2M0Qk5NaFJBNXovSWl4WFlEZEhwb1hBVWVTd2lDd0JEUUVP?=
 =?utf-8?B?TElTUzc2bDUwQnNpWk11S25US3BwS3l5cjEyK2dYdUJ6L1RaSFoxZ1E0M2sv?=
 =?utf-8?B?M1NiZ0t1NVJZTys4SERWM1NZWTNvZUZEcmpEZWxvMmtNZW1jcTc4eGhzU0Z4?=
 =?utf-8?B?Y01TdnloMDhHSzd1RWtvRmdTeFVoVVBwOHUyWkVRUjVYZUQ4NHJDRHkyc3p1?=
 =?utf-8?B?ZHdwalI4bERydU9Tb05CQlBzRGZyUWZ3YTNqcU1BckVzb3RuT25qWU00SFZG?=
 =?utf-8?B?Q0JWY3hsNDE1RkZoSE40bG5jQ2NYaW92ZDN4MjVWbDNWd0NmMHBrTGpZUk9P?=
 =?utf-8?B?M25mSzZ1eHM0blVaSDRCb2k0WHNnYk9hd1NNd2k4d3RFVkdQTE1wNSsyaUpI?=
 =?utf-8?B?bEN6WXduc0xQREhuaWxBdnczeE9yNGwzSnFiQ282UjVnamlWV1Y3TUxZNEt3?=
 =?utf-8?B?clBBeUJsRWhtYndNaTV5c3UrTFJDQ1lvS2lIUUFsZ2xnTDlqR0NXNS9pMDN2?=
 =?utf-8?B?NGFqQUN1UUd2TVMzYUp3U2dtSHZlK2pmQmcxSXdzYWs5Slp6REppeHIrbWpR?=
 =?utf-8?B?TjZlMlhOTWVDY0VIQkJMQzBlZGQ1dHdhYlNablhobE1WUnUvdURCbHpKeWZB?=
 =?utf-8?B?RndUaXZSWjY2THZUalVKZXNDOHYwMzNaek1vOWRDdi94Q25XZm1XbzlGd0ZM?=
 =?utf-8?B?UEtLbFFWQllTQ0hXeEEvUWlXK2JQbWNtZmE0NWhjaVhqYnpwOUV1VUFIcU5y?=
 =?utf-8?B?d2REd01UWklVUkxoOTBBUWFwdjNtdE5kQTcxM08rZ0VteDlUUHBhMWVMTko0?=
 =?utf-8?B?dHFTbHlZWmxTV2ZBUXZlZVBHTU9QZ2RjOWphOVBtQVJoL0R5dHZyZnRpV0tJ?=
 =?utf-8?B?Mm8vM2J4U0RyNS8wQlU2dFN6M2R6SWxlUGw0aHdmVW80RngwdFVXd0dHT2wy?=
 =?utf-8?B?NEh2Rm1RWXEzM2FlRDhkZ1ZnZDJnc2E5c29ESE9Ta2lSbEZLMkF3NDkxTnE3?=
 =?utf-8?B?UEo4WG5oV1F4NGVrRFNNRHREbHVYRURJMmphU0RmVmJMZHFVYXJnellZeUpl?=
 =?utf-8?B?S2NJaWtQUXU3Y2FVQ2F6dEt2MVV6ZFNxUW5Vd0hWbnJNcCtsZHZxNVgwNEl1?=
 =?utf-8?B?djNndUc3NUVMOUpraG9YNGtDQWorN0k5eFRXZkdka21ib2FYa3JFWHJaM0pm?=
 =?utf-8?Q?C11iMr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUs5RmRtZnUvUlVvU1J3Qlk3ajZUQ3k0WUV3Uzg1eWxqVkxZSlIwZU51c3Mz?=
 =?utf-8?B?VVl2TGhhcm9BYzVLKzIrTHlTVE9VdExocVJCamRnQzRRcUl3azdDRDVRWm5O?=
 =?utf-8?B?c1ZueTFVSkZNOHRrOVBBNi9nUEtHUEVUYUFpNDFzMVNXUzVQZmpSVzFEL0xL?=
 =?utf-8?B?SlBld0FPaU81MG8rSkhTc0o2N1BxVXdwTUVJdDA2azRIYmRZRFhnQUdQcjVp?=
 =?utf-8?B?blNjZ0gvNE5LU3E0YVErdmlaZ2xpQ0sxVFVkcjJVeW0rMnRuanhTR0NHNlVn?=
 =?utf-8?B?MEFlNjRuaHpSZEc3MXFYNE1FTGN3VTVrdTBtN0drRXlqby85dHJDR253azQ5?=
 =?utf-8?B?V3NGM0RGbUlYdzNyai80S2JsWnBkVVRFbHloNUs1ODBOQitqTlFFOStOZG1N?=
 =?utf-8?B?dE9MUlQzTjFHci9VczRocCtXNW5oMytUTTlEUk01Mng4L0Y3d0x6T1ZNOUQ3?=
 =?utf-8?B?NDdNak5MVys1YVZQZUVSenBZYU84bG9RR09lVHpOeG56VkVDZkpHY2dqZk9l?=
 =?utf-8?B?WDFvZnFMSVAvdXRqR05vR2M1czZDdWNMNTN0YXlDRnZMMHJYKy9FempMTmUv?=
 =?utf-8?B?d0hzOTVxdXMzQS9saCtodkJJWTB3TW1WVkxhSGQ4MHRtem02dko4TEpSTThE?=
 =?utf-8?B?MkRsNC90YU1kRU95d3FaOUt6c0U2cVVTVjdqYWJRRzl3OXRHQUhPeGxVczZx?=
 =?utf-8?B?M0czVGdmeUlQVGVrUldZcU9SM05OYTNOei8raUtMaFF1L0lTc2creWJnZ1Nk?=
 =?utf-8?B?cmdQVElnSlJsYWM4Tmorb3dLRjU1U3RUU05yVS9XUkJlVXE2SU5wQ0lVaW5H?=
 =?utf-8?B?UWVYU3BZNUpaR1krM3FaQ3I2eTlwUWE1WllOYkltaWRyRkFMM0ZYdXFlNzNx?=
 =?utf-8?B?U3JhUU40dTRHcU5CbjJia0J1ZlhUbXRtYzkwSjZJT0c5Sld4UmdMbnNoTkRT?=
 =?utf-8?B?dnkvUStUQStKZDArZ1NXS2JiMDUrNWFiaDBoaEFwcHV0OEY5UlhMOTVJMWMv?=
 =?utf-8?B?S05aSkwwMGVnU3UzZHhYTkphYXk1TzlSUEpMaFNGY1o2a2ZYcUFxcDJzNU5F?=
 =?utf-8?B?bGQ5YjNPVWpqRFVhR1VxcW54Qk1VZktHMUZBbWNoSTU4VTJmMXRzTHlsZjdV?=
 =?utf-8?B?cnVMbGUyMWR5bk81NVNOQjlLa1g2ZEh2cXZkd3NOU294cmYwZnA1UXVyd3Q3?=
 =?utf-8?B?R0lOV1ljRHZpR0NJSjV1RXcwRFZXbHJpU1BvVVd2aTJCa0tFVHg3Qk9XWmRE?=
 =?utf-8?B?RW1tcFUvdzc0UkFjbHlQNG56aFJKc08xU2xZMmRlNnRPMXBHYVF3MGVGaDdX?=
 =?utf-8?B?bUtqOXl6bHYvVVIwQWhVK1F0RXJGVFJzcXdSbzkyTHlPS0JrZ1B5Mno0TGtv?=
 =?utf-8?B?NndFMm15bnV1OThWdWpRQWZkb3BKZnd5Z1FoKzV0QWFycUd1eEJxTGJ1cTZ6?=
 =?utf-8?B?WktodkVCMGxzQWw4UnYrUTVnaiszR0FKTlR5V0UvM0VPTVVYZHN5NE1aZ1NE?=
 =?utf-8?B?OTZQeU1aV3Z4amo2ZE5xb0VDYnl1Njd4ejVmNE9IVDQwb29YMFNIZmVUSDhX?=
 =?utf-8?B?T2lodmxPMkUzYnRnNjJMbFhBaCsvUm1FbXVoTnBHQ3pjbUhuMzBWVzU2RVRM?=
 =?utf-8?B?QkpWS0lHaW1Nc1h2M0RLeXJkSVp3V2dBK2htRE5KOTZZRzZxSE5hbTlkVCtJ?=
 =?utf-8?B?Vi92MFNWblNPUStlZjdtQWJvZm5ubG9FVEpDeU9LS3ZFMFdNS1hGeFM5SXl1?=
 =?utf-8?B?T1cwc2thYWxoWXdqY24yUXJIdnBXbjkyUGNGTDYzSzBDTFBTUHhHd0FEakN2?=
 =?utf-8?B?dVIzQllJM2g0akZMeDArK1kreHN3OTIzZ2M1L0IySUhIYTI2ZEdla3luV3Fz?=
 =?utf-8?B?ZUk3MUZQRUh6NmpJRHlFR2h4TmJ1V3BxL01Dc2hiR0pQWlZuck5RQjZ4VW96?=
 =?utf-8?B?MncyLzNESjUyRG5hdDB2c1FpeXBUbithcTZjZHJtY1M0Q2hhMWVUOG9EQ1Ey?=
 =?utf-8?B?RWVvNWRjbm9iL09wMldSUjhUTTJwSGc1M2ZCemsyNSszVkx2ZXVHRG1EU0Ra?=
 =?utf-8?B?bWJFemFrcHVDSXl6SVZWVnpGN0l3amtIYzExUnZxdnJlRVVMTzc1d1hEb3Fp?=
 =?utf-8?Q?fye1PG/wHQiw+AXUT0InM7dUx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e89bcb89-7404-4c3b-e611-08de17251534
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:55:17.2365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJOwrcNtguwvNtS+RbsBotWKXW6RdFh/KJCDbDAyfQ0Q38fj5nmOK+W/8/4qn491Min4gFiBpvEE3K5ttr7U6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11377

Add fec2 and related nodes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 43 +++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 8ff2e4d4c21908826c7801d3d269fc60f4b5778f..13c308d007fc0f991a5714d13a9162bdb499db2c 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -212,6 +212,15 @@ reg_can_stby: regulator-can-stby {
 		vin-supply = <&reg_can_en>;
 	};
 
+	reg_fec2_supply: regulator-fec2_nvcc {
+		compatible = "regulator-fixed";
+		regulator-name = "fec2_nvcc";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&max7322 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_usb_otg1_vbus: regulator-usbotg1-vbus {
 		compatible = "regulator-fixed";
 		regulator-max-microvolt = <5000000>;
@@ -410,9 +419,26 @@ ethphy0: ethernet-phy@0 {
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <0>;
 		};
+
+		ethphy1: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+		};
 	};
 };
 
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec2>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy1>;
+	phy-supply = <&reg_fec2_supply>;
+	fsl,magic-packet;
+	nvmem-cells = <&fec_mac1>;
+	nvmem-cell-names = "mac-address";
+	status = "disabled";
+};
+
 &i2c1 {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -873,6 +899,23 @@ IMX8QXP_ENET0_RGMII_RXD3_CONN_ENET0_RGMII_RXD3		0x06000020
 		>;
 	};
 
+	pinctrl_fec2: fec2grp {
+		fsl,pins = <
+			IMX8QXP_ESAI0_SCKR_CONN_ENET1_RGMII_TX_CTL		0x00000060
+			IMX8QXP_ESAI0_FSR_CONN_ENET1_RGMII_TXC			0x00000060
+			IMX8QXP_ESAI0_TX4_RX1_CONN_ENET1_RGMII_TXD0		0x00000060
+			IMX8QXP_ESAI0_TX5_RX0_CONN_ENET1_RGMII_TXD1		0x00000060
+			IMX8QXP_ESAI0_FST_CONN_ENET1_RGMII_TXD2			0x00000060
+			IMX8QXP_ESAI0_SCKT_CONN_ENET1_RGMII_TXD3		0x00000060
+			IMX8QXP_ESAI0_TX0_CONN_ENET1_RGMII_RXC			0x00000060
+			IMX8QXP_SPDIF0_TX_CONN_ENET1_RGMII_RX_CTL		0x00000060
+			IMX8QXP_SPDIF0_RX_CONN_ENET1_RGMII_RXD0			0x00000060
+			IMX8QXP_ESAI0_TX3_RX2_CONN_ENET1_RGMII_RXD1		0x00000060
+			IMX8QXP_ESAI0_TX2_RX3_CONN_ENET1_RGMII_RXD2		0x00000060
+			IMX8QXP_ESAI0_TX1_CONN_ENET1_RGMII_RXD3			0x00000060
+		>;
+	};
+
 	pinctrl_flexcan1: flexcan0grp {
 		fsl,pins = <
 			IMX8QXP_FLEXCAN0_TX_ADMA_FLEXCAN0_TX			0x21

-- 
2.34.1


