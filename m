Return-Path: <linux-kernel+bounces-751496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FCFB16A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD915621A5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE1D1A5BA9;
	Thu, 31 Jul 2025 02:08:13 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E85B13AA2A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753927693; cv=fail; b=jPSfOyHlHGKOuK+wrEjH6jqAEMOLKOvfodG3vczdp3jx5WDRtUXiMDaY/NU8URyDnLqIG8R/Tnd6H/723RspsfB9hF3D1U+bMnvK9HPbAq6jYnJGqPFNimdOp6kvjaq6g2aoG/vroo/PdpiXY4+k2EjUxdb9LfXQWStuYoEBojs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753927693; c=relaxed/simple;
	bh=m5viqlUjSLdxSljKnJkjLKfovL4XEAlMx+2PsVo+Dy4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IAGVmIPrGK4+PjYZM5BQCCgvZrh502Sn1E/zfogz5sOJ+k5flHNGe4YU/kQmWr0fY8vkR7o/hu4lSwM1h/43BZI15buj4MpwUTvMspfFQMau6dxxMt7v7WrQKEbxEQYNJqjvWJqHJsDlHiqpKHa7VQh78dGC/IApMSq7MP326ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56V1Zexc372332;
	Thu, 31 Jul 2025 02:07:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 484m7xmwxy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 02:07:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X12ZnHCuW9j+YopNEG8iWk8YANGIEhkS0FBQlTKfES4uFUYdFqU5smOuqzmD4H3J1bOtKuux6GfxcS5yymn2Yc1JC+N6WNW/4H/1TKxsw7kgeUWPrQYDY61P23vZBO3B8ctckX63cgS89xzqrHgNzCThjnLQaTC2fCyTRJAvdraRlIZ9w7D7vgBksD08Pkvq7IOTYUiT9oK39zNBwtmd4B31Tb8V9yR0jEkIudc9+RUwTn8EubgeMTfTIRHEHLF33CjZp7z0wVcQ1FHpHM6sBffWzzr1kuRnqCXr4mvApHP5+NT8axAZkpAlND1UjLNF/ptz4a+mvMj9ZgFh1xpoKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwyxFeNpX9mdi3dHcfK87uNuOxtF5aDoFWkS1luH7Pg=;
 b=kBX7i13SNE4+frJ3eIibe+yEzWgBj7jt9EVllCCU2TN/RyRDgm7JxcUHgMFHApXl2bSzhQ/E1ABFq5pKg02KNIwenJrpKJqgKqY36G5k7+IK+Z4NuxJ8Vi9hC7JWWMHHzZznqGfgW2eVULuqmLJJIJS6pYR+mDtMsSuJVL+06D62YqqwwjtOFaM2X6JQyBF+1nsZPm1bF6pNISeyCo2t8PKmbyvdQD6vq9JbKLPL2Z0TAKDX/11eqJXTgqynMWbHNObC4tU8G9w6dnZr7R7Wkp23XIiarujv+uA3SIJgE+p1xIHgUY7VrajOcdJU8MnJAUbWE9zpMf72pD/cDN1s9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA0PR11MB7792.namprd11.prod.outlook.com (2603:10b6:208:409::16)
 by PH3PPF4B53DB4B3.namprd11.prod.outlook.com (2603:10b6:518:1::d1d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 31 Jul
 2025 02:07:38 +0000
Received: from IA0PR11MB7792.namprd11.prod.outlook.com
 ([fe80::385b:609e:4289:5e04]) by IA0PR11MB7792.namprd11.prod.outlook.com
 ([fe80::385b:609e:4289:5e04%5]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 02:07:38 +0000
From: quanyang.wang@windriver.com
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>, Frank Li <Frank.Li@nxp.com>
Cc: Quanyang Wang <quanyang.wang@windriver.com>, linux-phy@lists.infradead.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] phy: freescale: imx8qm-hsio: Fix a use of uninitialized mutex
Date: Thu, 31 Jul 2025 10:07:17 +0800
Message-ID: <20250731020717.2240392-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: OS7PR01CA0021.jpnprd01.prod.outlook.com
 (2603:1096:604:24f::8) To IA0PR11MB7792.namprd11.prod.outlook.com
 (2603:10b6:208:409::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7792:EE_|PH3PPF4B53DB4B3:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f9a20b-9fb1-49bd-8830-08ddcfd70600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?axQ34HGVy/MGpM+4niDSwHHBqpHQijiMW9rWD0z1qyX1Koh0XT0D27UeAV7z?=
 =?us-ascii?Q?/g5KepgWHykH/QKc7u1QGG/dGCmtHCb8OLF8p93Nbx2BHoWiKoYks7h65pCc?=
 =?us-ascii?Q?gF8JFtJVmYyzqGHH6Wioy9qIsNNOO4k2WUdDCVxgjRaV0hi5H2KVBR7jxvNV?=
 =?us-ascii?Q?m4OkBo2edlXZt1MbVa0AKZ84C4uWstJAaTui+i+Lp5ipaxfMKb05UT3OXbo4?=
 =?us-ascii?Q?62GgYrYqgmSC5difqT2I0H678y+VyxKjt5FIEDuQ3I72xvmUI+jy/f+CwJy3?=
 =?us-ascii?Q?utV2RYRgVqyurQ5cwBw2coUBDvWM8jXqAmYfD3f/4geidjKrimU3xMonxXAb?=
 =?us-ascii?Q?HglBObxkm1P5mlf9O/5vCLvqu7Bh/urCTuN65NVPKSlbrxyVNkEqVRpHam/K?=
 =?us-ascii?Q?Dmz3cn43Tih+jCwVjSP8qIDdHuMMNCFYe7RE+JzVVapLY+Z9Io9krq2LSoM4?=
 =?us-ascii?Q?/VIxQ/zcCPdDIoYsa73r1JFLUElb+AE5Ac4LT27p6ZVixsjojq2IvKw1Fb9b?=
 =?us-ascii?Q?uGkuaL9s6XlX8WlptNziY3o+VqfOOHYsQIoRmcP/XOs8UeTObYDHeqa+ctc+?=
 =?us-ascii?Q?9sHKhdiEQBKuqbFmn2w6RU18qCvngrGKEYaFRPtw+dHIaOHbCa3qkTAcGIZQ?=
 =?us-ascii?Q?vZm74EK/FEVAqCKYor38TuYhn/0XTcGHiY50FSLUsgsIwTdgbSAfxnzFb0Uz?=
 =?us-ascii?Q?SJmhzJ47iDXr7inkXs90tyn8ROJCSrH2kNqOQ1Jv8qaMfXi2O9zbX6duKFt4?=
 =?us-ascii?Q?QGr+xMvEUZpC1SmlIi3I7HJvhDJeWHM90PXoxhKEnIE7Gz6Kiq7iUm1f/QRU?=
 =?us-ascii?Q?lxk7yCsnAHSW5UhMA64OhYLMu/bmG3YuWcSbzZ8Ot6fCFNbjuA+der5DIx6M?=
 =?us-ascii?Q?T8V5/LDSHql04gjlAC27TIylwBtec7YBHdZslm89psFWC/0lPnn5cIUX32/4?=
 =?us-ascii?Q?ls8Hj5agdFFf1agT2vQQF9qowI8DtIWKlE1hy7bh7htdUepVQu0PhwiNhCYY?=
 =?us-ascii?Q?9YTQGTjUjF8oE9JSCNqKZ8IPEKi0r5xqnHJeh9JsS7vrRg6IBx99JrdE8cS4?=
 =?us-ascii?Q?PWKvBFRuuxljXs4rpugvknJZBuv1rx9/2OHYt7Ef+w/vBKbfIgcI+a/+D44y?=
 =?us-ascii?Q?j3MpV1Zfh6hMXOEWJN4CCT94oPS8yh1oHSvxQdzjNHohFoeeAHSPM73BYnWa?=
 =?us-ascii?Q?RWKsd5ElBTvqvrv5y0AtlElqKdzhqMQvXArEV/+Kw5s90766UDRjfbG4ObzV?=
 =?us-ascii?Q?9KzRkOZc3TTl+DOWiRiiedLvITUKItl5NR6koOGznfB3tN1YeazNF7WivAjc?=
 =?us-ascii?Q?cyRuCnG/W3u87YzDjNZm7A98vnaWazrmQ5HVt4mMcBFQwCtbVBOGQ2Dr68VK?=
 =?us-ascii?Q?2icFh5idMtfOUqLV+/+8Lbl+vN2nxtVdhBHHWHNzZN3vA6s/JHyeVSlA8CpR?=
 =?us-ascii?Q?WBANB3DVCfsdwardBNlDIOirX8hXNg2UiRTituiJ1xpMK2v20H2YnosBfkbS?=
 =?us-ascii?Q?BXqKu9ZKxwvT+vk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7792.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZfTXrub4hDYzjBdhMWS6JF990SHizHdPfvz30xL0b5RpWmqnAvvLQkMGA71r?=
 =?us-ascii?Q?OkPU6UqHG9k2sM28ZKyXkKrSA9+Sw796XvlQtDtQkpvjqzY+6hPKWa8NHqqM?=
 =?us-ascii?Q?kscpuSHc6sZuIy6PImYjhNS6i5nznBaAQaD5OwYDEvZopchgIzPnzOEtw52W?=
 =?us-ascii?Q?zXJSsWcKotVWe0hAqZYCkzgXGVae9gEm8KYn8LaRX/UogBbOE0m4DdQobGWk?=
 =?us-ascii?Q?SD3hrFIlyY0L1OesuQ8PXj/eqxA1RuqZe6zcxJd9MDo73TOpY/cNDHNE3Z0u?=
 =?us-ascii?Q?2BpGU/mIMyy86JKrtT5r0bb2O1x3KLGYHTfqT7N4vjx0X6VkLeo1WcemHMLK?=
 =?us-ascii?Q?Jn1XTpR2R4y8M3G14UHj1gl1AHBhtO5vTzzTZgMIEIy2QGooAOjWKs0/xYfq?=
 =?us-ascii?Q?qTcj+fL+OKAdgsP/kWQpv6bCAY5crTjHnKq9NO6RMsOtfc32wRy1c3ow1dmW?=
 =?us-ascii?Q?CkfFtaLpp9w6AEQH2Bk+bAndNRUa9ZTiGlfK6Iw95pPX0OdvITVQgnh/6ogx?=
 =?us-ascii?Q?r4T08hM6czZaE3KECS561bgB+sRoUH76QEgBM8tj5mKZnhgsROZoQHjOKoFJ?=
 =?us-ascii?Q?A9665VC3jZnThTD8AgMp6tT63wqOp14IT9LEoXdQ0+DDJClYumF9EQ4SIbwI?=
 =?us-ascii?Q?iNpHmilTnJjogel35ry/hCCPRRidC8vlv/CLD004kKBmvF+L/X1fjcWzjDxx?=
 =?us-ascii?Q?wrbsh/2Te2HGHY0+EicqLGErNhxuZCFkfoXf+7ZgScUYTLmgGxvpfJ+PPZfl?=
 =?us-ascii?Q?QlMKiV2qeGjt1INkPwukt292ZRjrUJUPvoVbQEXiSOVAxVwTbfLLWfvG04AQ?=
 =?us-ascii?Q?qUxRUDMTFuHfdxFbYihLJULs5/RKeFc7DDjZicpFJ9ktjm95BRezf/dLpozX?=
 =?us-ascii?Q?ig93YdKcKX7hDj8ZewNcU2EBcmNQbWN8rDifpr8P8dqwlOz+tWmVeoSZ4sXv?=
 =?us-ascii?Q?w1hUu4ykmD3MxCf5z2GFIx7Gj/4lBxba4WYRRt2sPkJss3FDT0zTsfJVqgUQ?=
 =?us-ascii?Q?vegAQL5+S/Rb1CebsUDJnBJZvFYKoSbc8tdznrojUU+f/lMnfgMj2Podkl5r?=
 =?us-ascii?Q?Pe/tXkzIPklERfXAQySvyZsjbODLb7hwqg2ef87meZq6ocnblee9q5oXlHJi?=
 =?us-ascii?Q?D6VT9qxS6D6eIL2Snom8WlEraqHO9FjwmUEK6NnWqKa7pHAQKKChkgpGD/cE?=
 =?us-ascii?Q?Xs++PIslXtmU/fMmpF/7R3aeTZVLkAMtJsmfxsHq0If7Sa+2iIJ6FlVNsoLN?=
 =?us-ascii?Q?xL/xrtDQ47CtMo5DHcstvEvi3bfgVy8SZLC969I+KfgQXoKGSwozdl8kjINy?=
 =?us-ascii?Q?qbfkig/I17ghvSMXEqBhMkneWKUTujDNYD0nVMTtLQ4BOaoQpVLgWPIITPcn?=
 =?us-ascii?Q?CfxJmPHJwfRMsJab63CxEWj4skkPnej/aTCgeAB6g8Y0s5/4Yd5Cw5tTqCWH?=
 =?us-ascii?Q?IYS4zfXU9QC+4fgLpjumCtWZgBARdhQGalSzCKudKzVnh97o+UNGqfFfaqoh?=
 =?us-ascii?Q?q+PPSu1cO4YvYyrBQ27BxVZmbcfv1dAK8fUG7mKBpLOCSffeMXKcahWitkGm?=
 =?us-ascii?Q?aFZguwx0xhWoUKkxcodo04u+v2IXaup+VGxwQbdz8CqlC2d7XBml2x8w8ewe?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f9a20b-9fb1-49bd-8830-08ddcfd70600
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7792.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 02:07:38.3974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNjemnBebRma19vj3iZL8a77zPv9vIvXgfucpvaDruS7XKL98xNFodMEnz1lGcWsK5vKATOyW28E7FbkIKKhGsjxM0uyikoffndznHJXrMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF4B53DB4B3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDAxMyBTYWx0ZWRfX7YX8Ci6SHlzE
 b28z/cuYCAAha0IdM9xu2OYq730nFEPg5NiKwzxXeJKYHCDr9ghv/aRbTPqPBI+KYFpEw2AiryV
 XBoyTnCLJPVWCyeyvpUQmaAXvlTWol6t6Cdsi2Dnz2wO4BQ7BTBFh6hsmciLaMXfFIITFk0lMAI
 rXJD7Zg2b7VgPjGE5JPN1ycnbJPs+bRi6o9llW422TCui06bHyN184/erqCrJzG70Kk2q7ti0I4
 VX24gx7rRJo87wiJbXH2nM08K+v0PfQPNLmOlhgQhG7lgTIYoyEfvVxYgNkKuRI6hTa92fj8X/1
 Q+edv5ZWXSmKDlFDmrGBNA6ZQuzxVW8gAHmP3CJl8NfX8V1m7Rxk6XDbpT12gueEU5bsnEYEzd6
 FWkCEshc
X-Proofpoint-ORIG-GUID: YeDjDln-6OjZN398UrmtuY26ohiu3GzU
X-Proofpoint-GUID: YeDjDln-6OjZN398UrmtuY26ohiu3GzU
X-Authority-Analysis: v=2.4 cv=Y9v4sgeN c=1 sm=1 tr=0 ts=688acfee cx=c_pps
 a=vlvY2cg+dyLOs7ISR4OrAg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=t7CeM3EgAAAA:8 a=FP8eLWCjxsv26ENVvGsA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_06,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1011 malwarescore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2507210000 definitions=main-2507250208

From: Quanyang Wang <quanyang.wang@windriver.com>

Using an uninitialized mutex leads to the following warning when
CONFIG_DEBUG_MUTEXES is enabled.

 DEBUG_LOCKS_WARN_ON(lock->magic != lock)
 WARNING: CPU: 2 PID: 49 at kernel/locking/mutex.c:577 __mutex_lock+0x690/0x820
 Modules linked in:
 CPU: 2 UID: 0 PID: 49 Comm: kworker/u16:2 Not tainted 6.16.0-04405-g4b290aae788e #23 PREEMPT
 Hardware name: Freescale i.MX8QM MEK (DT)
 Workqueue: events_unbound deferred_probe_work_func
 pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : __mutex_lock+0x690/0x820
 lr : __mutex_lock+0x690/0x820
 sp : ffff8000830b3900
 x29: ffff8000830b3960 x28: ffff80008223bac0 x27: 0000000000000000
 x26: ffff000802fc4680 x25: ffff000800019a0d x24: 0000000000000000
 x23: ffff8000806f0d6c x22: 0000000000000002 x21: 0000000000000000
 x20: ffff8000830b3930 x19: ffff000802338090 x18: fffffffffffe6138
 x17: 67657220796d6d75 x16: 6420676e69737520 x15: 0000000000000038
 x14: 0000000000000000 x13: ffff8000822636f0 x12: 000000000000044a
 x11: 000000000000016e x10: ffff8000822bd940 x9 : ffff8000822636f0
 x8 : 00000000ffffefff x7 : ffff8000822bb6f0 x6 : 000000000000016e
 x5 : 000000000000016f x4 : 40000000fffff16e x3 : 0000000000000000
 x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0008003b8000
 Call trace:
  __mutex_lock+0x690/0x820 (P)
  mutex_lock_nested+0x24/0x30
  imx_hsio_power_on+0x4c/0x764
  phy_power_on+0x7c/0x12c
  imx_sata_enable+0x1ec/0x488
  imx_ahci_probe+0x1a4/0x560
  platform_probe+0x5c/0x98
  really_probe+0xac/0x298
  __driver_probe_device+0x78/0x12c
  driver_probe_device+0xd8/0x160
  __device_attach_driver+0xb8/0x138
  bus_for_each_drv+0x88/0xe8
  __device_attach+0xa0/0x190
  device_initial_probe+0x14/0x20
  bus_probe_device+0xac/0xb0
  deferred_probe_work_func+0x8c/0xc8
  process_one_work+0x1e4/0x440
  worker_thread+0x1b4/0x350
  kthread+0x138/0x214
  ret_from_fork+0x10/0x20

Fixes: 82c56b6dd24f ("phy: freescale: imx8qm-hsio: Add i.MX8QM HSIO PHY driver support")
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 drivers/phy/freescale/phy-fsl-imx8qm-hsio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
index 5dca93cd325c8..c97b7ae3f5b63 100644
--- a/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
+++ b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
@@ -590,6 +590,8 @@ static int imx_hsio_probe(struct platform_device *pdev)
 		phy_set_drvdata(phy, lane);
 	}
 
+	mutex_init(&priv->lock);
+
 	dev_set_drvdata(dev, priv);
 	dev_set_drvdata(&pdev->dev, priv);
 
-- 
2.43.0


