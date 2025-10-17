Return-Path: <linux-kernel+bounces-857166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A687BE6124
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 03:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84700484644
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE95C24501E;
	Fri, 17 Oct 2025 01:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yl2THJJS"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012036.outbound.protection.outlook.com [52.101.66.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0268A23C39A
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760666221; cv=fail; b=DIKhsrkmHQT/5B79iCKJljQM64X0Kpd/nq7GHnn50+n5n5y5EfCYW23qO4JQ3V+afXYx0do6FzAd08d1Qotq2jv12uFIJ6BwRt6WLvr59ycyrfNOqtodCSRvs67/7Ry0X/376gmQQkU6lHM+AgCAyRNOzsE/QjicxFTdnC+HpGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760666221; c=relaxed/simple;
	bh=aL4PtH/nxxFAndlyb2UYLjtpw3Yazz1/x2423Fcy1hs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=b747MqFcjPEu0hWrD8xm5W7zH6SApAtgIgAiaxc2PGTAXjf9PNAkjYtmBF//2sE1BKCeZtlrfK1TqNjf3PMFPcV9peRxCNW/wWT/rvLVHyqwM0K36eAReg+00upOSxktjVWs6IS3URMRNi+OIKswPqRpsnUTOOPy2IVYAEIL1I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yl2THJJS; arc=fail smtp.client-ip=52.101.66.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5nxUCyr1/AK2/sCDIUvrCDA3axetgFpsA871CNwEr2/rScTom8hMsHWGwJuW8y8g4LBug8fD1hlBG3h4JitWE8RFG8xb8QXs3V4pquFS2FVo7KDfbm8iVu+EiGBJ9ssw9USB0Kh8ktX1vJ4o2CzSfmhmz+W1ex24hvrUA/4Kkf/hMhxGOuin0XfOcBwDVyLW8QH17y6TgvJoXGCcateoaArv5zBJs+wDq+YlbwLSp6KCKQydqZ5/ZGqwEP3cqyFmG6iiBuZ5DHRVSGg8dZEcDz/azy3ZsCaa0m0bIBLK1QKqNqSAMVY17tp+hcJ1sK0Q4KPH0zMhCvNOAIbMZTbnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzN5/hIOAyUd71W7wU89SMWWYdf9mzxZhF78WIesvHg=;
 b=eXxwBMh7lu/Zdim68jwvh+PPN9mNQr19ieG9BnVOIt9TneVZtzI5Ryey2XTJyBi4/OWar1kpOGQVxzKocdtW8KrNIqPkcDtlRwVEKIZ5agbnCWuHKJBN/vGfGhVAcd+ELMuzCkXTzVHRf0rKaYeAyOqlD8//Q0O3kRlMMa77uxjhk4yl+3FPBh4nxnAojX+JRXEq0wTe6AJ+U5rTfO8nV7iOyu9aizD8ZWo1ITS27HmsBoEhSJSbCGXxczCOcRHjyR51Hiw7py9wDaUl5Euink+wWHugpLEzdnwtedRboItx5z7sBPJr8Kp1K8vR7kUnHfJrDOrti6S0DYXVcMQdFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzN5/hIOAyUd71W7wU89SMWWYdf9mzxZhF78WIesvHg=;
 b=Yl2THJJS8lrf5BPNTGF0j0PXfhUGvMJJNHqeEpiqWsnDvFh3M4Lth9esLmuqOKIH8Rmm27ixM66xiYcuU3y/uMHe+P8rQ0BFr82JnC21bEAcGjkSx3wyBCmbk6ucvy2MNTmznht88JbWYXicP6oe3OzrOOwwsmPgcLV0U2HaTGiEVt7BUr3ZKXvc1Jgoj1eXzEw4l2FZTRpN86GxYQMcmc5JJ83PpYZjg80jC/vJmw5Vw7ZHYQXWUUyq7HR8IUcLx8S2MiI5vKrNW4GK3iwTMw0fyuByRSrg9qYMKVDhqTNGgV1njficqotn95prrC3WWK3rPSrTPbVhuixPbJIQ2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB7125.eurprd04.prod.outlook.com (2603:10a6:20b:121::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Fri, 17 Oct
 2025 01:56:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 01:56:58 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 17 Oct 2025 09:56:27 +0800
Subject: [PATCH v2 4/8] firmware: imx: scu-irq: Set mu_resource_id before
 get handle
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-imx-firmware-v2-4-b58f68ec2ea9@nxp.com>
References: <20251017-imx-firmware-v2-0-b58f68ec2ea9@nxp.com>
In-Reply-To: <20251017-imx-firmware-v2-0-b58f68ec2ea9@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Dong Aisheng <aisheng.dong@nxp.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760666195; l=1769;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=aL4PtH/nxxFAndlyb2UYLjtpw3Yazz1/x2423Fcy1hs=;
 b=VWxvm1yZrudv8L2vQRV4XogVJePpl8655OVludw8ShtRk2h3wjW3C4TEpJECo+Xi97pmwdQEx
 m4bWHizDpylA3IcpcIrfqFdKdTj/Mre3GrSu5eO3l04Uh3M73i8801A
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: c8fed2dc-65ae-47e1-5670-08de0d207492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWZoRWExZ1VLNDA1K1R3NkptUUlKWUZGL0xpUXh2MmVCL2ZFVHVlV3c1QTh1?=
 =?utf-8?B?T1BuaS8ySEFKQTJYbTUyYkFZaWRvRGNNREVId2dlZElBbnRIQVROR3JtRFNW?=
 =?utf-8?B?Zk9Bc0ROMUdCeWJkdDZGV3Nwa0JFZU5nWEhCNUtyNC9pVDhjSG81U3p1Vngy?=
 =?utf-8?B?RUtLVVdZUWdwenZ3Z1hoQ1NRS0phSkx4MjFFUTZiZC9EYXdkNWlpbDM4UjdC?=
 =?utf-8?B?V3NpMXZiZ2poNHhMN1BDZERxS3krQ0p1a3RIYzhyZ2JYMDJOTllja3l1OEZU?=
 =?utf-8?B?cS9OUlJhMjRxeDh2RzBMMUN5V1YyaVFXVGlzYUE1M2N1cVpYSHdMNlZpMktP?=
 =?utf-8?B?aTVOREttWWJxS2ZETHFXWjAyR0I5Qzk1OW41R01hRkRnREQ3RWlUakFLSnNx?=
 =?utf-8?B?bkdPSzBjYnZ5c3JOR21xT3Jid1kyWE0rNHlHc1RuRXZVUEVvNkdHZ3d6WGR4?=
 =?utf-8?B?MmNmcFBYZjV3K2V4YkxSL3dtWUR1elZNNTBGeDd4b25IR2xHd2lNLzFIWHJK?=
 =?utf-8?B?QnUxR1ROMDF3aVdiMHI3dHlSa2ZVdTNhZTZwWExGUnJFL2IybXo3cHVCdGdH?=
 =?utf-8?B?SU9RdmZUT1Bxb3NZdVUxSXZhRTlwVFF6OEZIcXJaRys1aFhpRldFdjdFc3Ry?=
 =?utf-8?B?ZUpmR3ZXdEZoSytyVytvblFaYU9kN3F2RUhwOUkrRWVhOERGZ3BWK3R3azFt?=
 =?utf-8?B?OGJKYTNPM2g2dWxVaTlwekhTNk95amtSN1poUm9ndi95dityQ3Q2TXNpRVFI?=
 =?utf-8?B?b0R1ZTZ1b2Zyc2pBWnlHZVRRNzNIMXZOdU1leDYzdGVhNzRtcjY3NzlzY0x6?=
 =?utf-8?B?U3hmWVNIckxIeklvNVZMd0hXRHJBNldhcVZhNWx4d3N0OUQzZ2FGdE1sTFZk?=
 =?utf-8?B?eFA5eXdEYWsvendaY3VpUWZac3VLclVlZmRHUjVDUERCUGlOK3dUMzEvSE5Q?=
 =?utf-8?B?OHlPVUc5b3JhZ2RVWGtnd2x1WkRYU0FFVVRJdnhuS2loZWlFbTFwdXdjTi9S?=
 =?utf-8?B?azQrd2hHc3l4elk0Wnk4ODh3eUNwR1ZTbWpUVXNOYlN6Mk5Kc2ptQ1FLZTlL?=
 =?utf-8?B?Q3VGU2xpeDZ3YTQvTDQvbU9EakU2eVRCR1NuVzlQNEJvSGNqVElWbGdyTkFM?=
 =?utf-8?B?M2R2OGJhdnZGMEptRXB0VFlzaUFFL2lrNzdIRUttWGMxay9WcVphTmk2WCtC?=
 =?utf-8?B?Q2JJM3V4Q1JWQ3llSTFYUDlQaWl6T2V5SS9oOE4wWFpHTTBUejc5M1hyUlNB?=
 =?utf-8?B?SjVOb2R1dWxUd3VLay8yNThTSE9HQVZ0R1o0MGJpd0hYVThlY3U2WHI0VUF6?=
 =?utf-8?B?NERPc29tRll1dXRHb21jaXhPaGZ0WFM4UGlJcWthWXpyQ0R4NFE5c3pGU3Z5?=
 =?utf-8?B?NTQxRnUycFhXN0RTc1Y0dTRZT1hvcS9wL25HQmNjWWQvVXpTNE9NbG1GQVl0?=
 =?utf-8?B?YTZ6d0pGSVVNWVQwUk10QVc0a1NPV0tnMHZ6SS8wRjlqTC92MXRDSHJtMWx3?=
 =?utf-8?B?bUdLWUFBSjRVd0krSnZjNGtEQWRlbXJMR0RFcXdTQjE0eTFkQUxjQTBVS21v?=
 =?utf-8?B?ZnYybnBld3BZeVgwY1NLdjU0aDNES1c3dnlOYUpPb2YrUUF1dzZWN2oxTXlR?=
 =?utf-8?B?bGg2cUYyZWhiSGdVRHBDWjhhbFgwRnZaUG4zUW5KUlU1b1U0cHhDRjFNbTMw?=
 =?utf-8?B?OUNyRGJQZngzVllnd2dDNVNQNW9VWEhGUG1xei85WDJoeHlzNjNlYmE5cUJ5?=
 =?utf-8?B?MTNFYVVXU3ROYlJjaHpGTWJsRXFOM0dyc3VQRFZsNG5XTGxxWVlKeUd1eHl6?=
 =?utf-8?B?eFBlY2FqUTkyRUNQUVFkUWhxajlaV2xkTytnS2N6Y0V6VnpMUWQ3OHlUVVhu?=
 =?utf-8?B?NHFoWDdJMTVXMGlwak9kRTlUZFZkc3ZmbkZ2YlBrWVlTckdoWU5LSWFJRGpB?=
 =?utf-8?B?Wk40TGdxRTUwN1A3eGxscHBJVW1Zbzdod3V2R3ZwWTQ4TzRrb2QwN2pBSU9u?=
 =?utf-8?B?aEVOTzIxaUJSQm5zMTFkRTRBRkI3T2t0R0hDY0ZHVERnSmJyVFdzN0NuNEh1?=
 =?utf-8?Q?mxKKRz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWw5bzZpZk9xSElaV2w3aVp4NCthcmlReEU2Nno1UCthaDNnR1F4RnkwUDls?=
 =?utf-8?B?dFV5SkY4Y2dQZzFvckFJLzVGT0NPMXM4MzNxeFBGVkI5bnpOS1hNdTFVVFZJ?=
 =?utf-8?B?VytPWFFqQno1enBjVzhibGlHam5TSkpialF1TktNb1hXZkhtL2RQNXRrMjJZ?=
 =?utf-8?B?YklpNWtQNmR1OTZUc09EQXE2MEFDaXRKNUF6akRZa00zeXdablpudGdWSVM2?=
 =?utf-8?B?bzRuSGNjVlBjV1RuS25uUTVvTFp6VjRqN3oyVUhUS3h3MlhWa3ZrNTdMNUov?=
 =?utf-8?B?Uk52eE50WHVuZ2IvSnQva2toeTBaYVVhRXJvZWtSdC9NbGc0ektvR1MyekNo?=
 =?utf-8?B?RFFPQnFJczF4bzhvYlJ1WjFjdnoydjBwVjUxSGxjcUlHQ3FxN0RjTnJ1Q3E5?=
 =?utf-8?B?UjdGblBpY041ZFc2UkFSQTRqU1QySVR3RkpGdnFBSUNYTkRlWTRHSytHSnBX?=
 =?utf-8?B?TTlmWDV2cWhpaXRhYnYxL3E3ZnpQOFh4K2swanRsRkV1cjJLMFQ2NGpNWGVW?=
 =?utf-8?B?OXBUVjc2L29WMWNvYUlqUTBCRFZPb09abnFzQWRJcmIrZXI1aWR2TGFvaCtn?=
 =?utf-8?B?cGJ3Sko0RXoxTitNNTRZSk1TRmpCSWZHa05nRFR2L0IraUl1YzE4b0FFY3RU?=
 =?utf-8?B?UHA4WkFIdE5PdGp4NzkwamFQVUlxSG1kd0VRNGtraWlyeXloZkdMNjBiK21S?=
 =?utf-8?B?T29DaEk5WjNFczIwUWkzMHpnQlk4RmlJdTlIRGpJblFoZFd5UkNTYkM4Y2RC?=
 =?utf-8?B?M3RpdGVCN2JBVFBQckt1VGVpNVMwNHFsdUJIWHJxNDBkNWk3anJXOEkzM3dr?=
 =?utf-8?B?cEMyTW8xTjVOQXNjelB5R2ZRU0VFK25HS2hxRkppbFJhWjZ6MDFRNElLNElL?=
 =?utf-8?B?eG5xb2R4SkQxS3dsVHA1clRRN04vdVBDMzN3a1lVWTVqWGRjNVN6WE0vaXQ3?=
 =?utf-8?B?VkE5dUZpbnBRczU5WXk4NkhLVFVsS1lJUVAzKy9xckdwMVdLNU1vK1Jka2d1?=
 =?utf-8?B?OUtTQmVTZ0NLdkNCUU1xSjJTNkl6R2FhOTB2RjRUT0V6YVpYQWhETnFNbWdt?=
 =?utf-8?B?Vmh5d05ZSDlEL2dOdmVvZmdYRm1wMlJOVjZKTEZ2V01jUWFyVEJ5c3U2bnNa?=
 =?utf-8?B?L2VOaEFRSU9VNk9meDl1OUk5RTdaWno4czlUSzNSNDhycEQ5b0E1dzY2Qlcy?=
 =?utf-8?B?aDhhZDZBclFYK2d1WXhnZWdaRGxmQjV4dCtXRk9zSUpOTHY4SmZaNnZlWFFO?=
 =?utf-8?B?dFprL1g5UjQ1aUtUTHN5S016Y21xcjdoSXZzTGpCeEhXNkV6UTRtZ3RtZkNi?=
 =?utf-8?B?OFpHZFhyMTNGVlE2VXJMQnRLc3crUUxwc0dnVnVyN0tpNEZ4Z08raEllQm52?=
 =?utf-8?B?WnBBSW15RVkzUFBOM3crQ0hxVS9ZcjJPU3Iybmg0RmhlZWFTQmJGaWxSNU5C?=
 =?utf-8?B?TVZWSFZ2M1g5ZHM5UTNPdEdndmZ5SjlWM3hla2FSYTRGK1A1MFFpeDhnd0Q5?=
 =?utf-8?B?bDRaVmQ1YUhTUzlPRHVxWmEzWHlSOG9iZzJXQjBVL2VKS1pGVHZjYjlKWHNN?=
 =?utf-8?B?WFYzcGFDNnRzWUJJQVJzeXRVOVNDc2o3cktHek1Xd3I2dWlJNTFLZ0JSeENF?=
 =?utf-8?B?cjJvUFV2Sk9WNWJIRnFXeW81UTgrSFJQei84bFFQL2lQckJ4aXM1NVBLUkRz?=
 =?utf-8?B?MVR5VXVoa1YwSFphenI4WFNYUXBjSDdYQ0pONys0RlVzTWE1ZGlNMHNjM1Vl?=
 =?utf-8?B?dllyVi8yQm1rKzI0dkVMUVo1ODBZNFZ1OFoyL09oTXU0UGNKbUQvZUY3RnVm?=
 =?utf-8?B?MHNvRk1HblA1cnh1RUcyR1VUUGxuTk9GeEhZZmFRcnlkMmJrVzBhbWFhN01O?=
 =?utf-8?B?cVdhSjZzZzdySk9McmhwSlhCOU9MK01NUnNxK2h2bGc5OHRsQWp1VE9NMmx2?=
 =?utf-8?B?WlZqZ3VHV0VIa1VpMEY5OXZDcGhwSmovQnQ2emQxTkNjaGM0cVYzd3RyWEoz?=
 =?utf-8?B?YnR0WXE1cnA5K25ZM2txd3NWOGFoRG9GdENkbFIyMXd4bVQ5Y3VieHRCb3By?=
 =?utf-8?B?b1pKOWhoaE5MYlpIRjNJWG4yT3hXR2x0bENabGdjNFg0UzcwQVorZnBRSDU0?=
 =?utf-8?Q?fhbm6e5/+6XOX5YyVhoqKIVVt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fed2dc-65ae-47e1-5670-08de0d207492
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 01:56:58.3665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CRjCFWxxAjSpEJKtHJWD6nH3O+h2RyuRQOlQZreVX3r0/yL26Jfw9dwNSaaactQDrmlhFiedaMXK0+P6P32DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7125

mu_resource_id is referenced in imx_scu_irq_get_status() and
imx_scu_irq_group_enable() which could be used by other modules, so
need to set correct value before using imx_sc_irq_ipc_handle in
SCU API call.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-irq.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index 2d7237188932632ffd4960796c7e73b69ceac7d5..3dda42be4e6b9a0df0b2b1ddcfb64dd112007e02 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -203,6 +203,18 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
 	struct mbox_chan *ch;
 	int ret = 0, i = 0;
 
+	if (!of_parse_phandle_with_args(dev->of_node, "mboxes",
+				       "#mbox-cells", 0, &spec)) {
+		i = of_alias_get_id(spec.np, "mu");
+		of_node_put(spec.np);
+	}
+
+	/* use mu1 as general mu irq channel if failed */
+	if (i < 0)
+		i = 1;
+
+	mu_resource_id = IMX_SC_R_MU_0A + i;
+
 	ret = imx_scu_get_handle(&imx_sc_irq_ipc_handle);
 	if (ret)
 		return ret;
@@ -224,18 +236,6 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
 		goto free_cl;
 	}
 
-	if (!of_parse_phandle_with_args(dev->of_node, "mboxes",
-				       "#mbox-cells", 0, &spec)) {
-		i = of_alias_get_id(spec.np, "mu");
-		of_node_put(spec.np);
-	}
-
-	/* use mu1 as general mu irq channel if failed */
-	if (i < 0)
-		i = 1;
-
-	mu_resource_id = IMX_SC_R_MU_0A + i;
-
 	/* Create directory under /sysfs/firmware */
 	wakeup_obj = kobject_create_and_add("scu_wakeup_source", firmware_kobj);
 	if (!wakeup_obj) {

-- 
2.37.1


