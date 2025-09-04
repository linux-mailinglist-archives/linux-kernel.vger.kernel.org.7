Return-Path: <linux-kernel+bounces-800544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 213ABB43908
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C33A584001
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663352FC00D;
	Thu,  4 Sep 2025 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QKT5c3lq"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013034.outbound.protection.outlook.com [52.101.72.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456472FB627;
	Thu,  4 Sep 2025 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982512; cv=fail; b=cOyb6xagxj4UUCYxQnZi41Phy4GX6cn4onCdWcdJIRl6k5IyyL/9OUe/UeH/K+Hg94PacRRwV0d75FMEvo8t4k8DPryx8TCDfQSbAPV3QtX458lomEle+Epr6DmZAmKQcvtFqkGFt5j9lopM+xDbN5KYobH9zQLp1BSmg0y1iiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982512; c=relaxed/simple;
	bh=kW7lH08VewSzz1EC5xd/P3+6zoGhLeO88dnyLw2uOgI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WOPrQ+1CCIMwMjMoh7pHDofKZFtE7Nh2MMLXodWZvGPMDT3+OKk1Gf0IGTsqRZ01cQMh8pBL9DiBzknBUgmYKQTJr44hC6hcCp65Qp/67kXGimI2xNou989EnhiGxkFNe38ZOdq1HwDywgAoEvZyJpucWsmkme1oeJveJE2ThrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QKT5c3lq; arc=fail smtp.client-ip=52.101.72.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgDH0UNxCFAywp2IM6Ghu6b29CGXKUQhhfI6Ew7POYUzgl2ia2H6ZYVgGbG0vux79inPr0O0z/oGlI0jwqoEDFsPjMaNjTdPmoYFMFBDbzW40fsaB1CGKVkB0HExRg3BNbEJCFiY6+M1KrFC0pZFNwI+0a89mdTq3oFAyftq98unwN3+WJHLpjnHQWo/OIaq6VtRAAVeEzC3wFR9J7Y6ZcTZJNJYf3sj5mthY5IIEMYovCRomnAVleKkfESTA4bS2JzZ0mWNV4G6iouHjFPamB2jzMmqjtkMZNja8p77AYAvkO4iUFNC+29sM5ukQpcQG7EE/BlvFluE0b03aHlVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWviZL6aHxYTIFpig9puQc7/yIaQ2gP1x0bgz1Rd6wo=;
 b=tyNliWij32OILBp98+D08VlxHMsjFkkkvLYEKUigzJbMHVyFu0fbZ/gv8IwEwdINaePfdtIhwiM4wbVCaFz1I8G9uOV03i2YbtSweqTCOtnvAIsMHvQOBm2AV/SpaP93ccMGqj4SZyC/ChmmbHRphtKF+iX00pwWRquWzG22dZaou6sp5mR2W6xnZjcSa4esci7lobGezx7wbXhELbiUutpTmJer7/BBPX+ozdkudb9KklXpttHQBEscgdOkHyOSzM80p5bbmLxgF3Xoc4n4OkkQl1M8o00nm7onRRxcsiW9mEPL65E4ChWklEkpUs2KROHKXtsciUWWKAoMU2dKug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWviZL6aHxYTIFpig9puQc7/yIaQ2gP1x0bgz1Rd6wo=;
 b=QKT5c3lqTn252pXrKe4JFL0wj0/6HCbKgzilEY85g5TS7raVh58V+q5dGfTWnGU87d5i7VTf+J0S9sm2OyXKS0Rra8S0Z41ZYbmUj1dySkQQJEetKkouLkvcsrImaXOwD2pzgvI+tgWOAiXGiJlXvhuou80gTcUj+o5VMmo35qWBRgKn7zsRVZeoP8sgfVG6X01s5vl/r9UT6r2A5hf6PjkDw2U8UlfkcSbmnK5ltznMnA7PrJvqnPoQHN4dSedjaERxRFHGgBdFjuPx4D2tc1scgbzQdynm0s0+f7EAAmNfemOQJScSDORMRbRsYNxqdymkwf0tql69qaT9arcJ7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB6937.eurprd04.prod.outlook.com (2603:10a6:10:113::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 10:41:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 10:41:47 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 04 Sep 2025 18:40:44 +0800
Subject: [PATCH v4 3/6] firmware: arm_scmi: imx: Support getting cfg info
 of MISC protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-sm-misc-api-v1-v4-3-0bf10eaabdf1@nxp.com>
References: <20250904-sm-misc-api-v1-v4-0-0bf10eaabdf1@nxp.com>
In-Reply-To: <20250904-sm-misc-api-v1-v4-0-0bf10eaabdf1@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756982492; l=2472;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=kW7lH08VewSzz1EC5xd/P3+6zoGhLeO88dnyLw2uOgI=;
 b=VnQNpTRF9+axZS7SMSNEpWVOPA01JJPeY2FdI/6hmheM4BAKV4m1kRuVeI4kcbOT85wVwJQAN
 FitcB442kZrBGaTPbNOjEEavnCHm5S171Sb1ORqSXQ3ZEE/Ks8QFqn7
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGAP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::15)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB8PR04MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a2ebfb-cc93-40eb-37d9-08ddeb9fa5e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1dHRVRXZlRodWZqZU5HMTNwekY0cVVmcFA4c1RWZU1IY0liZjdUWjZXSnpT?=
 =?utf-8?B?akVPQ0FYNSs5dTl4aWF3cWl4ZzhBVUZSdUttMjFJQ2V2NUEzNmthck5ESnRq?=
 =?utf-8?B?WW0xSE9yMEg2YzRkQW1PbVdwYWI0TzYvVFd3WDZ5NlpTUFpJTlgvMnBxZXE1?=
 =?utf-8?B?cDYxdXZlQzN3bXkrcVV5ME05MkVoaG1MYjQvWDZOM1phNmd3aEdLekk3aVND?=
 =?utf-8?B?ZHhjY04vTTh3TUx2b09oWG1RcTRlMEx5V01oNUhOVHMyejd0dVd1ZGN5by83?=
 =?utf-8?B?Y2E5bGZPdTNuWWFQdVhWNkxzcjRLSENuZEx5R3NNZnIwSjhIdTllRVlydzdS?=
 =?utf-8?B?dlphVWhKZlhZSGhtS0N2RG1lMjIrcDYyZks0V3oxQ2l0dEtZamgwSVlsQldq?=
 =?utf-8?B?eFM2cFlnWDE5bTVxUXNlWFdNQkdsMFEvaVRQeThXM0ZlOUhmcVpXZjdsUGgr?=
 =?utf-8?B?UWxqUGFBQnJRWUIwNk4zOHlFNFV6UkplUzJlV1RrK3pKZGNEVVBocFdwMWx5?=
 =?utf-8?B?ZUhVTEhiWjJNMy9ZZmpxb0psY3c0ZDU1SmNLL2JiNFl5NHZLQVp1eG9oRGQ4?=
 =?utf-8?B?UmpZck5QVis3bTl1eS9BY2RuM0w3dEJqSmg3Vi9CazZkUlhaUGZEWnZGUzFE?=
 =?utf-8?B?RzJDMmJmL0wzT2JYQlIxQ0pzcDNqNHJMZWozOG1qSlJiZ3l3NE85UXRzbmhy?=
 =?utf-8?B?TDF5Tm1ncW5kRC9DQm12ODZrbFc5Z0NubGgzS3ZtY3pZK3gyZG5Zem9MZStz?=
 =?utf-8?B?YlJHK0NFZko0dW4zRkQxcnYvcW15QzFxa1ZDSng4TkY5L0hJQmlOZFcrU3lt?=
 =?utf-8?B?VWYvVEppQXlUZTcwdHllYTQ1ZTR4UEU0UTd6d0hEUkx0M210K05VeXhNaEhv?=
 =?utf-8?B?dm5nKzFCYkpvbVNmc05vOUg3TnorSlE1MlFDVFdjVVZHYWRqclRYekk2SXM5?=
 =?utf-8?B?UjRCZXNpZjlFUmI0RlVSUzE2eHlvazdOdWptTEF2Tjh3UFZxWXZGWkhrVkFN?=
 =?utf-8?B?akw3UE5pd1pjUXRteEhNaGsrOW5TeDlvMGhuNzFNNU0zQjRxSTJ6RFZYSXNS?=
 =?utf-8?B?MHB5VVphdFVJcVg3N1BNeURyMWpBVjVJMnEvRURRdjdUSUNncGlqRzZKTlR4?=
 =?utf-8?B?dVF1cEpraXUrL3U0YVpoanNEaDROdFQ2bVdRT0pOVmtqdTRpZXlJTXE5VDFL?=
 =?utf-8?B?QTlMblBOdkxzQ3VSeUNrRXhFeC85ZnBLMHNncWErU1U2QkZmeHZ6cGNMNkdB?=
 =?utf-8?B?dXoycDlwL3pOWkFkOWZFcFpwelBRY2QwcjRCVk8yMG5UWEZ0Y0IxcEFFZjBU?=
 =?utf-8?B?NnE1TXJnVjVrdGRXRFZCamFyZm1pREFuVkZyNjRoN0RsOCtPZlQrUVFORnRw?=
 =?utf-8?B?aTQwRTZtZnZ5bWM3eWlWdWRHMWZxMXYxNnRqZjBhSWFNZ3A2YlJBWVFVanBr?=
 =?utf-8?B?MlVDM3h2VkE3by9sWC9kMkcxVW9iOGIvcVJXUWFNK3hiZzU3Q1U0SnN5RWpx?=
 =?utf-8?B?NThhKzRtNTRkTThEL0hkdFMwTHFsZWN1a0t6VWxTdXRJS29OSjBoUExBdzhn?=
 =?utf-8?B?cTJWRHVreEhPUDlMZndrOHB5Nmh0TEh0MDhqRFZ3K0dYNnJBTVZzMGVhRnpv?=
 =?utf-8?B?OFAzTU9zREFBZ21sTFRCNW8xSDdrL3NmMDhWYVNpNmMzK2s1akx0S25jR1h3?=
 =?utf-8?B?WnozQzErYlVsMU9pRllxb3BpdXhuZmgxdDVLZTVOMHlTT2UwMms5ODl6YW5I?=
 =?utf-8?B?SDFIaFNrWmJwQ3R1Y2xxWjNMSU1ZTzhycHNnSG1iKy9qZXl6STh4eC9GaXdk?=
 =?utf-8?B?ZkJFQmE1aThUdS9xM2lPL0JLbkRXTzQ5dGtVUG1CTkZzOTQxWHc5R2owak4v?=
 =?utf-8?B?Qys3QVYxaHFJOTVJdStZNE9TaFFrQmVMNGswQXEyVnZpUTRFK1hHYmoyMVJo?=
 =?utf-8?B?c2wvSi9jaDhJVzNQTG5zSEYvSlR2QWM0ZllqcmpMOUhHeU1UNVd5MEhBSkwz?=
 =?utf-8?B?TEI2SlBaZXhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STJURW9NL1dHMFFGNGxQU3NQZ21oSFVBWGdDWHBqU3pQeTZZMmo4OUlKeHA3?=
 =?utf-8?B?OXBQZ0Z1bFUyM1ZySXZjYnROVW5QT3dDOXVVQ2hEMGJoSTVlV1Urek11S0dS?=
 =?utf-8?B?MExNQVlKZzN5MWhITTY4WUhucHA0T0JIeTl5dUhFMVV0RHhBOGZoMzlGUVh5?=
 =?utf-8?B?TjgzczVLOXJtS1VoUkE0akRNWE9nVEV4NHRhZ3pxbVU4NkJNN2h0UGZiZ0Ev?=
 =?utf-8?B?NzlPenhYbjIvVWhmTjdOQnhPUkluM2JQam9ZbTU4cWNJUWtXREczTDRNSUZk?=
 =?utf-8?B?Z0wwdk02U29FTVY4YjR4Ukt6TExpWmErMjd0UStQTE9RTjJwRFhaY2RUZWwx?=
 =?utf-8?B?VXNpNWQ4NHpPdHZqWjJKZGZza0lCVkYza3VNU2dNODRQNzlFV05SLzl2MGJC?=
 =?utf-8?B?SHlRci9WdnhyN2czNWtoUTNOTG44WkZxSUtnWWFzelRaejI1K250N25OdXJY?=
 =?utf-8?B?aUV1ZE9HSmp0VXk0OGhuWFNRRXRwSy8zUUlXV2xyWXJWWVNvUE5oVURvR1cv?=
 =?utf-8?B?SFRkMjVPczF6VWhNY3hkSFFKQ3pHYTBsdnpCVGp5NU4wUEtnUSsrUThFYlhh?=
 =?utf-8?B?UG5vRzBYMWpOejdSUUVjV0xPcWFvTi9lcmRMUHpqODB3QS84ZUFIQzUzM1RE?=
 =?utf-8?B?RXQ4a0FjWVlwSU1UcERTK255TTFYUUNtTmljWTl0Q244dGIrNWcxYXQ3cFN2?=
 =?utf-8?B?UitTQjV1WlJoRlBLd0xXNUoxYVhrNE9zdGVEVnFmaGROSzcyZEg1UGN2Uzhz?=
 =?utf-8?B?OUcvU3M5MkM5Rk5qUjBEWi80K3RyZWV4TWJINkVXT3drdFh3ZlBiNG1DV2ll?=
 =?utf-8?B?VkpmT0JCMDh3emR3RmZlTWRPazJYZTVNdng2N2g0cm9OUTJzUllkTkgwczdI?=
 =?utf-8?B?UFF2c3BLSExtTXptaGlkOEtkS3UxUzNBamZFZ0dVWHhoYTA2MUNSNjgwOEhK?=
 =?utf-8?B?clY5VlBJdXRHSjZQT0dMUXRqdFJRbVNUZGFJS0lxQ2FoZlhNeXcxNlJUdFhH?=
 =?utf-8?B?VTUwQTYzaTFEV21CK0dTYkxvTkJnSXFoYnhLU1ZRZzBVdnJ4ZGJmRm9Yc0pZ?=
 =?utf-8?B?UnhOMG1lbzJDNnBYZkp2dTZSUzVvaEovWHNWcDVOMVBHaFlZbnBWSk8zNnZ5?=
 =?utf-8?B?L1ZUdldNQ2ovSW1nTEZ4U0tBUXFiNGpzM3VyZVMrZy9PRENIbmtyQys2K0dz?=
 =?utf-8?B?RCtWcVc5OGg5d0dtRzZNRzJoSUNTaytDbG9jdENzeXpaV3pyNkNnbjFFb3or?=
 =?utf-8?B?N0VUWHR1eHE4d3k3T0FmWUx3eUhuWitNc0NOKzJOTWdiUWh2WG9GeUtoMWIr?=
 =?utf-8?B?M0k4MG5WeUhUZlhkTW9zMUxQT3hBZElYNE1TU2ppSjg1ZE8weUREVkdpOUdo?=
 =?utf-8?B?Y2luMjU5NGx1cGlnWVdJemxwTEpvQ1NZYnlmRzhjWkYrVkEvQlBPSHRoZHE3?=
 =?utf-8?B?S1RtaFovOXYzZzNSajBpc0JLR2p4SlNyRUE5MFdTc1hRMmlUM2R2MjdZZWJK?=
 =?utf-8?B?ZjFtbkdqWXF2Vk5xa3BWN3FCNGVxcC9kelBTbkFTc204UGl0Zkc0WWd6ZWF2?=
 =?utf-8?B?SU1JNVFoVHVIQXVSV2Z1NzAvcHcxSGZBc2dWNDdReEZhMXgrRDVxWm5lOE9L?=
 =?utf-8?B?SlR4amhZSEVWM1J5ZmlucTlWTFJ6Y0NDNlEvbVNMZ0puOHZxQW5HVzljdWxO?=
 =?utf-8?B?aDJSdkZ3bW5vLzV3MDVaRWRhaitVM2pPTExWckxOdWhBeHJJQnBJNUt6dVVN?=
 =?utf-8?B?T0VzdGMremZja29XYmw2dmxwS2tiUzRjVWpEL3c0Tjlrb2cvZm5JWU5NRUpn?=
 =?utf-8?B?VTVFWG4xcFRwMlRldzhsNXpya3BTS0JwVkxGUjBLVTErTEh0UklvYmZabUFI?=
 =?utf-8?B?UEFIZit4aGdQZTRXMzZJczJBcjdTVDBFQ2wxS3ZaM3oycWVMK2QvVGkwMDM3?=
 =?utf-8?B?UlFSNWt0UlAyM3NtdGhaSytTbFZNOEpMdm9Nc01pWkxOdmJjMDA5MjNlTkJt?=
 =?utf-8?B?NWo1SDg3d0NrUDdGY0x4bkcyZnBOa3J4QWgrQk9EQkRRRkdyc2xVSHBkSkFT?=
 =?utf-8?B?Y3Jsak5QYzVsVFlCeHkvc3lVRnpRbGc2TkF0UEROZjdPT2x2Z2hKUHM0b0lm?=
 =?utf-8?Q?bv7ZPjgeKIp7umFAWcxmk7+Ab?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a2ebfb-cc93-40eb-37d9-08ddeb9fa5e3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 10:41:47.3600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2M8rpASIKReZMezlk5Nba95lYh+zF+eXDt6TTY9Op+jJDyND7mlwB3k5DyuYNhxvVjc7Vq8ehx71ym6dXjn1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6937

MISC protocol supports getting the System Manager(SM) mode selection
and configuration name. Retrieve the information from SM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
index c2928bc89b001b288ee64565cec9da5668b56e7e..92b641f467b053a1a15332fa0a584ea7400e3bda 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
@@ -27,6 +27,7 @@ enum scmi_imx_misc_protocol_cmd {
 	SCMI_IMX_MISC_CTRL_GET	= 0x4,
 	SCMI_IMX_MISC_DISCOVER_BUILDINFO = 0x6,
 	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
+	SCMI_IMX_MISC_CFG_INFO_GET = 0xC,
 };
 
 struct scmi_imx_misc_info {
@@ -75,6 +76,12 @@ struct scmi_imx_misc_buildinfo_out {
 	u8 buildtime[MISC_MAX_BUILDTIME];
 };
 
+struct scmi_imx_misc_cfg_info_out {
+	__le32 msel;
+#define MISC_MAX_CFGNAME	16
+	u8 cfgname[MISC_MAX_CFGNAME];
+};
+
 static int scmi_imx_misc_attributes_get(const struct scmi_protocol_handle *ph,
 					struct scmi_imx_misc_info *mi)
 {
@@ -309,6 +316,30 @@ static int scmi_imx_misc_build_info_discover(const struct scmi_protocol_handle *
 	return ret;
 }
 
+static int scmi_imx_misc_cfg_info_get(const struct scmi_protocol_handle *ph)
+{
+	struct scmi_imx_misc_cfg_info_out *out;
+	char name[MISC_MAX_CFGNAME];
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CFG_INFO_GET, 0, sizeof(*out), &t);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		out = t->rx.buf;
+		strscpy(name, out->cfgname, MISC_MAX_CFGNAME);
+		dev_info(ph->dev, "SM Config\t= %s, mSel = %u\n",
+			 name, le32_to_cpu(out->msel));
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
 static const struct scmi_imx_misc_proto_ops scmi_imx_misc_proto_ops = {
 	.misc_ctrl_set = scmi_imx_misc_ctrl_set,
 	.misc_ctrl_get = scmi_imx_misc_ctrl_get,
@@ -340,6 +371,10 @@ static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
 	if (ret && ret != -EOPNOTSUPP)
 		return ret;
 
+	ret = scmi_imx_misc_cfg_info_get(ph);
+	if (ret && ret != -EOPNOTSUPP)
+		return ret;
+
 	return ph->set_priv(ph, minfo, version);
 }
 

-- 
2.37.1


