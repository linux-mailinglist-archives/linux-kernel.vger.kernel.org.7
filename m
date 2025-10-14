Return-Path: <linux-kernel+bounces-853277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0E3BDB17A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E103E9871
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE5C2D4B7F;
	Tue, 14 Oct 2025 19:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CGIQBz6l"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011018.outbound.protection.outlook.com [40.107.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC4B2D8363;
	Tue, 14 Oct 2025 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760470753; cv=fail; b=lrz34tKv2RL90U4dTCn/GFu0yz4RdTMLTx32NuyVRVFwrcJ+1139Z292PLhnqMJndIMMyKjmAxCuFfv+OH+l0n3P+gs5p5sbrcvP+iWEhB4CcW6X4tOT6a6FqzyOr2tL/zALmH/2PWunyOAjyVTeRIa2RWLyLrjPhFq8O1P7Fd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760470753; c=relaxed/simple;
	bh=jWO/vqLtawYq/L1FaW8TtkZRr1JxKgqoiCXRzAGpMI0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EfyzvjoccJRfZYkx82HoKbzsm5h2/JKco50be3r4UOvTSHMUlanMBLipsvUeTkRuC9fEfeh/QTp6MibLpm4dlfUPV2ho8EFmZthrPm6TJqbBdL0G6qcEE1/TjgUt/YDK4kY2uYGq7NsURCf9qfpETuLhggjicah4eB0S9felElQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CGIQBz6l; arc=fail smtp.client-ip=40.107.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UcsV6VQIXblnDj+iysAvbd/d6VRcJUGgiHYUu8KoUArrBIKwA3XHNNJg5YmkUKA8oDgRSVgKrwIWYFZjlgwIatFw68U8dB3bGkBd8VQzr8grrdpAMvcJPdTiGszW6nj4T9f8BJ/ek92CAaSYNJ6spWKpiBkxq2sPm4n4OlbKuOKvvvD3YsBY8nM4hNuvPwIBbGb0FuCScP5wid9x4mvlFpQCaDq+MJEA998FqQCa/xV/uIeppZbtQBZiAAY7Q5b2rtULIBZjZyZa4qDBNICTAEszJMkFg3sJZShlQHh3jk7RrkC2kFPlcqOt9LhS2zPWevkX8RM8nnpeeg0T+aTRaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mn0HSJcoEI9+hngbKgLsm2cPHG+N9USn0bhMvsyGCnQ=;
 b=GHkNautEmlWl+8BBl223bM0tXngXyCj52qxoVrwpWr+mY8/UVBrZYyIgSYCToYgdujGujOzTk0B65J3gGQqMw9gkhaZ7ti/l8poB3InRIAkOL4oi20EgIt6g62NUVBRuLup9ORCNrVBvcgy21TvnoOpIb44Zfmik4Ceg167rfBC/02P0u7iSo4bWi85ONmApiAElncjEuq81yJQVXdtxY/pSJ9EiKOGg65FplUFlvyXMdYBIe9hbzLddnY2a0x8ujC0FvaAQAMmaQgZKSQgqxJUrH5arGKzJMmR9Fs7A6UrtmInmATmm/MEPE4KFePT0M8InM8uzHeuidxxvmvek3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mn0HSJcoEI9+hngbKgLsm2cPHG+N9USn0bhMvsyGCnQ=;
 b=CGIQBz6lsNJej7Rvew5ctX7ZjXCAEEiagIQJqzsjQ38l88kC1zsTGGTvA4tiGHZOdkZPVFKmY3ihwfEKQv9X2BAhfZ4eEMg1kQ13bZyDXAIbXj5R/3NWcV9eSm3mZi/3jyjNGXpjXYDO/GKz0flWABuxw0B90Ys614hNo2FZnVMVJQcA2r49XdImiiWpmW2bEBnXCEpKDj3N6KvpRLwQv5B0jOAfFS1PL7xDYmrbA/yCXMOi1YofT7Via0kNhl0cR7WiCv9K8GrAp/1uHxRsQ2qBvDTmIAiLZx+0nSvOhsUrAqtNUMKLwhvBjIEwAZf5c/zShwAfhl0UdqffdKy39A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7241.eurprd04.prod.outlook.com (2603:10a6:102:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 19:39:09 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 19:39:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 14 Oct 2025 15:38:24 -0400
Subject: [PATCH 7/8] ARM: dts: remove undocumented clock-names for ov5642
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-imx6_dts_clean_2-v1-7-508b36e5a3fd@nxp.com>
References: <20251014-imx6_dts_clean_2-v1-0-508b36e5a3fd@nxp.com>
In-Reply-To: <20251014-imx6_dts_clean_2-v1-0-508b36e5a3fd@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Marek Vasut <marex@denx.de>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@dh-electronics.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760470717; l=1733;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=jWO/vqLtawYq/L1FaW8TtkZRr1JxKgqoiCXRzAGpMI0=;
 b=bqT2yjM7SyEsMeq17OvCzId7Gu5GqGdm0cSM+8OagPx9OR1yegsauP9W8vPGV8YAGp9qzLWtP
 arJMXa4kc9GDzKoVjYvV/t2CjdCvVausQm0J7izXNd4hw7R6/dX1lH3
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0065.namprd02.prod.outlook.com
 (2603:10b6:a03:54::42) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PR3PR04MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a2d085-b36d-4d03-8c48-08de0b59580e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmdvRlhGakNyM2dpQmlsSzhsMGJxa2Fkc2tydHRINk5ha3I5ZGpidm5pR1hU?=
 =?utf-8?B?Z0JJVVV0dTdPUUhBSkI4QVBFV2tMQzNVUHNac2dCMWlpZFB5dWdkaHcvbDZt?=
 =?utf-8?B?MEpiZDcxQ0JEdkpyNWczVjRzUXdRYkVGZ0ZhcDN2bnlja3NuZGg0WXJ0czRj?=
 =?utf-8?B?OVNMa1lCRzZTYUFSaE9yUVdIUHpTMDhlMmkzbzY1VTZVN1llbHkzNGFLSXlk?=
 =?utf-8?B?MFc1MzNRT1pLa1JnNlMxMkg0NG5yQ1pnOXpXRlZTQ0RUTnllU0tBc3Vhcnpp?=
 =?utf-8?B?U0pUN3dJN000M005b1hLNEtFbUZsT1VmYVc0ZFVLbmd4V2dxUWJDRyt4Z21J?=
 =?utf-8?B?b04yM2NUbEViSFcrUGo5VlZmVHp4OWlOWm1VdGM1d2hUbWFOOTQzL09kd2Zi?=
 =?utf-8?B?ajArR2d4eXN4ZUpCU0hNaDh6M1lVVlhCMiszYXB6c2pINWYvT1pUZjBHUk5v?=
 =?utf-8?B?UlR2dEdEYnQ3My92NjBMeWYyWnNybktzVFFzUXR5bmVmTHVrQloycnFtVjdo?=
 =?utf-8?B?WFJ4ZWhGeERmQVp2R3BpMmRuMVJrS3BhZ3RmRjgwZDNOTjBqa0ZrRXJCMVEx?=
 =?utf-8?B?bG9nbzBHVC9MelB2ajdrU0k0MVhLcU1yWnUzcDdXMVJ2UnBoczl1QWtwbzhr?=
 =?utf-8?B?eVpERTlrdytSeXUxclRzK08wMTdlQ0JEbmk4R2tYWS90dE80czV1Qk9DU0t0?=
 =?utf-8?B?RDVPdjNrVVQyOGdXcEFOYzV4RWpteFU5dGNyMDJJeXUwQ0pMUEtQLysrSVRF?=
 =?utf-8?B?NkJrNzE2dHhNMzRiV1U4Yzg0Vjl3VDRoVUtiOFI5aGg3dlJuelpkVFFxdEZl?=
 =?utf-8?B?bXByT1dsMTd0U3pkdkxvYlJ6Zk16UWpSbWEvSEIrMWY5c0xoTUFVS3YrMHBq?=
 =?utf-8?B?UlNoSUJQT1NzNXNzVXo3SG1icXZSem1EdjRQM0k3Y0Qwa0xuQWpTYnN2Q1or?=
 =?utf-8?B?bzl0emtncmM3UTdzUktLNzlRWHBzWlBHL0pFcHlWa0ZYQzg2RUI4WjNnSGw0?=
 =?utf-8?B?TmRpZmlVYkJ2QlBRWDhhZGxlUy9sZWdkZU84RW80YkFkUTVwQ2ZZYThMdVhk?=
 =?utf-8?B?ZHVJcUNPK1dacDNCVElyVE9QSmtzOHdwUW9ZL2JXQUJSYXVUdy9ZUnlaa1dl?=
 =?utf-8?B?R054cTRaQnVuYzdLaEJHbnpxOE9BcmE0TWVUZ2l1QUhGdi9LZ1lnWXRVNVNa?=
 =?utf-8?B?TVpxV2FnQ0dHZFBocDVxZWY0ckNUNlA2N1NRU1RJV2pSZVI1YnM0TklqM1J6?=
 =?utf-8?B?UGFpYkNRNjFsWnpTdUtYbllRU3UwTjN0dmR2Nkd4TUYrcjJ4Y3p2eTI2UFZT?=
 =?utf-8?B?djFDdzhYRC9aZlFqdGgzdkFYUUFQSUc4RUtzcFh6WnlxTG9ySWh3RUdhcTky?=
 =?utf-8?B?cjd0bEFvcytERVVlL0hKRkhFSDZtakFKWkhBUHovZHgwWjNkYnpYQUxCWThi?=
 =?utf-8?B?NFBNQk1GR1FiTXRiTWEvVDg3V2hjN0VSWnlsM01Od2tyKzlpYURGakt1aDNK?=
 =?utf-8?B?cUM5UlBoblNWMCtYdlg2YTRDRm1xRjlCRmV5STNOaWxnQ0NnRmdwQzlJZUQ3?=
 =?utf-8?B?WjBCRm9FVmc3WmRqNWRpOGV3WHNpYjFaRmVzSlNDN2hFRkpiOWdnaU5HREUw?=
 =?utf-8?B?Zm9ERExmSG5aZFgySTM0WXJlZkhla0s4VDRlbG0zb21zbVhWNTZqL1N4clVY?=
 =?utf-8?B?UG5qdGRuanBkbFBhYUZocXJUL2FYRTZid2prUko3YUJLYW44YW1IWjdwaGE1?=
 =?utf-8?B?UE52TFRWU0NKT0kvUjV2N3RHRWQxeEdJaVJnTlFVRlVReHF0V0lXTXl5M3BU?=
 =?utf-8?B?TFV6VjhBRTRHWHhhV3JhV0I3T2pwdW1FeWV2WHZCajRhYXNFNFdyVHdiOFpU?=
 =?utf-8?B?NndzU3lrTC81eVdnWTRnMVQ1K09JeUR6TG9uOHdkOFRlNDU5OUNRdkoxbWtJ?=
 =?utf-8?Q?tXYlUkn3PA5YQHz5iAvwpVexSQ6WTAOX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eG9wYjN0NllMQllvVGVzV2lGNnhpb3M2aVo5R1pybTZOelh5MGl1dkMvM2hF?=
 =?utf-8?B?Y2pWKzlPSjNMbXd2WnpqUWduMzg0QysxMDVNM3hRZzJHRFhQY3JTbk9DdzEr?=
 =?utf-8?B?SlExMzBGYzF6NmRXRGIzNHdvampVSzUxNmpnTGJsUG5JOS9xY2VnaFRHNlkr?=
 =?utf-8?B?bXBNTDFKTFc3eEtUVGpZVUozbEJWbVZxdGlqc01tWWRKNlo3UDJSZmljVW5y?=
 =?utf-8?B?cVJ2a2JFZWpUMmVJbmFhdjlNMjFGb0lmUzBQaVlTdnFveHZvdnNySU9JMEd5?=
 =?utf-8?B?UVJHTzM4VDNGTkRsL2lIcVRsa3VUMjR1Qm1lcUpIY1JLZ0M2UDNTclI1VDRU?=
 =?utf-8?B?cUdqMEp2Y2dNc2FGMSsyVW1tczFuMC9YMXBNU2JydkQyMWlNWVBxTnNtZlFq?=
 =?utf-8?B?MXZ2dnNmM1FlSEN6MnpaNW1CRHk4ZW51cmh2aTdaSFY1TndVdWJFVTRZTUk1?=
 =?utf-8?B?T0ZxejAwYm43cVcyQVJ4U0tDU1ErVEt0UUo5ZTFWeEtuSXBLdzB0WWhhY0hh?=
 =?utf-8?B?ZkVvNTA5eW5kZnBZVzU0RWl3ek5Za0lqV202VVdkNE5IbEJWZmd6L2xvSU9P?=
 =?utf-8?B?TlBnL3cwWm9LOWozR1NxSW53bVhpS21wQUczOEJLR1hDb3JPbjJWSjhrK0lY?=
 =?utf-8?B?UXl4MzRwbjdNdG1LK2dkTlpGelRsaUw1RzJBam5KQ2ttc2wrZEppNThBKzAv?=
 =?utf-8?B?L3F2WkwwNGgrcWt4aHU2YUZ2ZHo4UDNhSnhrY3NEZU5MeDg5UVk0U3BhWjFv?=
 =?utf-8?B?Zk0vc3BGNXV5WVRZTWRiNzBPTlJzbkcyRGFENE1pdlIyUEdIcjFDWFVQLzVX?=
 =?utf-8?B?TFNINVNuUHBxcVFaTm9BWkdkdnR4a2lRZ3hpVE9xUEhqVkhacFpGTHZyV1lp?=
 =?utf-8?B?MlJkdW04OFpUY1ovYmo4NDY4UlZ4MWFQaGszSkZtSHJ4RFMrTXA2VmJHRjBF?=
 =?utf-8?B?RWlBUTEyRFNBWElMT0ZJNWZtS24welVaa3BZOGNIL1FVK1JncGpLYlZlenh4?=
 =?utf-8?B?QmRCaklCMDhqTTBYU0daM0loQ2V2ODBGOHBvUmdXcmJLaDk5MW53Sk13TS96?=
 =?utf-8?B?bCtsc1B4aEt1UXBNT3BURFNCbkZ6ZWRSdGFJdm9QN1VhZ2oyM1RNSnNZbDZs?=
 =?utf-8?B?ZnFtQVY3bVZUbWl6NDdUa0pJbDE3SnVla2FHOGhESHd3VktJK0N5V2ZvTDRh?=
 =?utf-8?B?ZXhNT3RmcmFScHc4WFhJcXdvL1F3dUJtcktVZVFqUjRzMlBjMThULzJUNE4r?=
 =?utf-8?B?UU1EZElzdlFMRGt4bjhLWjhQMWpQS21iUThiVUpYVVlSYnJKZC9HMVdpSGRV?=
 =?utf-8?B?ejNydlNVUnZWK3dhZlE4N1dxZGtiWTJMeDVqTmtSamxzQyt5cDdtM1FHQVh2?=
 =?utf-8?B?bFFkRk9LM1pnQ3h3cTdqTGt5dHMyeElaMnBLOFZpSzZWVnZjZjhxWFVOVzhr?=
 =?utf-8?B?K1FXdHRNaDl3NWhkNDZpbmlMZU1hcW5VTlEyVmtERURYWmZ0MjVnOTNucFAy?=
 =?utf-8?B?b2VjNHdqTVVOY1RtazFIaTV0dnZoRkJaNUVnOXpYT3JuaUxSTEZhbmtJNzN3?=
 =?utf-8?B?eWRnbWJOdXFTZHlMK05UamlFQ0h4RWR2MTgxcld6bHZpemQzNjM1UjU3SFZu?=
 =?utf-8?B?NkVvMUkzS0JXb3Z0V0ZTV2xTSm9ROHVvNmIvUmZOaXpmS2ZEdmR4OUVVblJw?=
 =?utf-8?B?aS9tc3I5ZzdJSVlQRDdkQ0haTmtEazRZdVlCQzJNcDZFN2tCYWJWQWFUeVUw?=
 =?utf-8?B?WEk5dVcycXp4TXZheEI2Yno5WVd3eWFubkNKUTF2NmxudGdWVVVyaUtCeWNJ?=
 =?utf-8?B?eTBmNnlzTElSbW4wZnVIMkVRaFNlTEc2dkZzUVpmN1djQzE4TTJlRUF5ZUNO?=
 =?utf-8?B?ejkzU1VWVHE4Yi9lN2cxRmxoZk1McThOdndrbmQ5YXgzUW9PUmpyTll2NWRt?=
 =?utf-8?B?SGtBVGNmZmZ1VGxOdVlrWDdaaVNYWVh4WDZ2a0w3ZUs3SUljK0I1OWpjQUcv?=
 =?utf-8?B?SWR4NGJSNTNjMVlCV25KVkxRSWNxSysybi9ubUo3ZC80TzZCMDI4QnFlaDQ4?=
 =?utf-8?B?UktacjU3ZFQyWlBWNmxzcld4cXQ0YlhNdW85cDFrL01wTmJUOUFmT0FHNUVz?=
 =?utf-8?Q?wlPM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a2d085-b36d-4d03-8c48-08de0b59580e
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 19:39:09.2160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pix55w30ovJXE+HZiAOmqgo/RiRtmk0ZRSmn7KjgkvWWVmes2YJ0tsDn/Pnkx0DHvXgTwR54IFNpFQ9dykIERQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7241

Remove undocumented clock-names for ov5642 to fix below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/imx/imx6q-sabresd.dtb: camera@3c (ovti,ov5642): 'clock-names' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/media/i2c/ovti,ov5642.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi | 1 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
index b2d9e528fcfec55d5467a11ae4308fc92c1d1d50..3b7d01065e87b2587a87f97438eea205be3222f8 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
@@ -363,7 +363,6 @@ ov5642: camera@42 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_ov5642>;
 		clocks = <&clks IMX6QDL_CLK_CKO2>;
-		clock-names = "xclk";
 		reg = <0x42>;
 		reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
 		powerdown-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
index d1adbb11c51ae078094dbe475b85038c89d243ac..ba29720e3f7205675b46a14ea4ce3f8957790911 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
@@ -287,7 +287,6 @@ ov5642: camera@3c {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_ov5642>;
 		clocks = <&clks IMX6QDL_CLK_CKO>;
-		clock-names = "xclk";
 		reg = <0x3c>;
 		DOVDD-supply = <&vgen4_reg>; /* 1.8v */
 		AVDD-supply = <&vgen3_reg>;  /* 2.8v, rev C board is VGEN3

-- 
2.34.1


