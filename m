Return-Path: <linux-kernel+bounces-857163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 055BDBE611B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 03:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 715704E38CD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C127023C39A;
	Fri, 17 Oct 2025 01:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nC52qIU8"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013038.outbound.protection.outlook.com [40.107.159.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C863123536B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760666211; cv=fail; b=rwy23pwmFozXYjH02Sjl2TmZh4OgSXjk6saLqbfckynzVE51sZzy/FxW8wEi65BqaA7EcU3VGafuxQar4UmP4Uv+3FpU3RRBJno4SKxsgVLY1LqAnXjCCK/jv1kO8Ex/DXPYM7g5YH9iqqKuk9YAdpB2uV3TldKz9vpIG1kXxeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760666211; c=relaxed/simple;
	bh=KuvCVWT8xoFXAPPntq+y1nv6AlYtm8br8QMU7b5MctU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=s0TGlq+ajkdMZtD9dJWz3E1ok4G8fgI48UDQ1Yyqohra61PkfBNDb20mNhabSg9dN/CblrqYPORfP837xq/HzOk4lrVIjS+V4qpTKPbycJtwwXuM5UtM6wTzR1XFN2yfDzi80QsBip0MHJ7Ps4MyFrnWhpeV97B+kxtJutQymtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nC52qIU8; arc=fail smtp.client-ip=40.107.159.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llti0XVlprfmlGg7zJEBRdtckabO2Fsn1O9GcWkg7dJ8IkzqDmkLaTItKPRRVfzweKxH60y9fGkQlHA5nGBJCj4+j0Xb+fIJrmcmduNSJrksPooWm3QZk+kzfPJzP/kkLvtpCJNknrughfONHkLXy9IACwcOQcQeNSpySjDqU/Hq8sbFJunYDlcOWhC5zYloOSO2r/KrqMp85uhGXfdkYy9FItYj+FKGgVTYfnHoOzthmQarE4E10IyN8LQOuGymwUhoDtTVemTLVELN6h9QXfb3WYgALDucMo4wCT3aHJZiXm8PbezPYZDxmUKs1VorevUj6rdtUMDii5R/8EjyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzYfg5jrbvzHT3rb0cW2AjFds9LtFpEsyOGWzVzAOOQ=;
 b=U3ok/Xz8u3UXwB0vYW2GnFNr08mQz7iqsROMoef99zJ/7AJ/Zu54R33+rFSeau4WYycPKRwxSijfAD93cSEuZcMpBL7aDn0rkptsKxCdvcv2XXlu9o7jvo1uRL+8ddoFGOKXf+mlbHRS6Dxohz2DyzyKcJGMaAj9JPhDGSCSy02uXYmdYftPdUUQ8isCNOWThoOvo7gdT5bbDhow98tgCEbU6vjtXe03QF71a8V4jfiHUfFlc1s+2ptE5h++iJRk4K0Vv6zRcj0XG13kyUJpw9sPUQM81cQLNojW14CaHP0pZmrzvTliUTf0wJHNaovcCfKli4WOw1x+MOJhSqWyeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzYfg5jrbvzHT3rb0cW2AjFds9LtFpEsyOGWzVzAOOQ=;
 b=nC52qIU8kT2ER6eY97RM7KmbVmudEDfQwBevSkfsn4UojZVNXRD5G99X3+o7MzFJOjuXSvIpP/OleVAVK2YQzUDRPWiBOVea4nv7IvkoljT2T5/BnowRN0XSI0q/VE3dA5Icd/trKjmFedBvsf70fx2lEr3G+3BovDbfKa3J10mwCMB27axn+072Ob1Z6jcEmbKzBWkCxZ6KML5jWVAN+pU8dKjsG0sYZzW3o5AI92sacfyOcjwQDfIRPBRYKlZDr3hBNnn6WQVxBCEnlN6W1vDx7xEr2F8sf8Iw9W98ewMhZciuavhxQ8tOJO1nklkd0djYKl0mZb+4+3wLrfyFvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB7125.eurprd04.prod.outlook.com (2603:10a6:20b:121::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Fri, 17 Oct
 2025 01:56:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 01:56:46 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 17 Oct 2025 09:56:24 +0800
Subject: [PATCH v2 1/8] firmware: imx: scu-irq: fix OF node leak in
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-imx-firmware-v2-1-b58f68ec2ea9@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760666195; l=1141;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=KuvCVWT8xoFXAPPntq+y1nv6AlYtm8br8QMU7b5MctU=;
 b=Azm/w0GdlqBwiNIj0f39mAQ99myl8F7+Kj8HApmmcT6O9CmFDvGgZ9ey+7FFGm0IM4Zf9Lb0d
 VjITbhN3wPHCgK42BrCcvwThgE6ShK8642AgDxQPztR21Eh3Gzk9zuJ
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
X-MS-Office365-Filtering-Correlation-Id: d1245489-bd77-4b6f-93a0-08de0d206d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUgxT1FXQnIwUGdUS1U4anpwMXhoUUg2bFpuVWtRem1WSjRvK1ZxNm5OU084?=
 =?utf-8?B?S2krTGNpaCs1NzgvNzUwd3gvckViNlhkMjdLbTY5UHd4eXdzZGRXMlNNclNN?=
 =?utf-8?B?bUhPbENjQ2tLQk42NEw0UkhQVmpveE0zOUF6QTBxdk9jbExaMlA0L0YrMmpw?=
 =?utf-8?B?SjlyZEhOV3F2TkJydXB2YzN4ZlN3SkhFY1QvYVhBakdDM01XZ0xNTUh0azI2?=
 =?utf-8?B?Y2FyQnF6YS85WmJlUm80S0M1Mk56bzlHVitmclNUM0VVSWFQb2lhellGMmdD?=
 =?utf-8?B?eVNMVW52VGNiVkNEanU2MHdXOGpORTU5YUdqZUY2VHltWC9jQmVXeUpzTjFh?=
 =?utf-8?B?TFJMZitoR3ZEV2doZ3doanFBdmJGUlh0T05CRHFxYTVNYlVaN1YzK1FHMmFw?=
 =?utf-8?B?TXJBZm1zMUFtSk5FNWdOZG5rbDhSdXZqZTNGYVVBZXBTa0xqL1lIcVFncldO?=
 =?utf-8?B?dXdxNFhxYUNPVmdxZ1g1cUxjU1VOaTNEb3crUjNuOEpzR1JZRE9hQk96Ym1P?=
 =?utf-8?B?MmtMdk03ZzZoWVl5WWRIZFZCWFlKTHVLR0tDajdsRVJIRFprVkJxa1hGSFRw?=
 =?utf-8?B?dEQ3bWRVN3IvR3FFMDNqV2orRVlJSExxWUxxZ0hJMXRjRzVEYVI2RWJpZWR2?=
 =?utf-8?B?ZXAzakJpNnpGaUpWYW5qUjlBWVliTS90eFRNZjBnYllvMmlod0hEQ0E0S0xh?=
 =?utf-8?B?K3pFL0VLRHBXRDFLc2tGRnZoUDlaWkdEUHl4TUFmTlpUTTNVckFYS1dZTEli?=
 =?utf-8?B?SkNQRkJwajZpaHBaZU92ZjV4RHlaVlk4VE52V2V3QjF2TXQycnlWTHBhbXpx?=
 =?utf-8?B?RkNNWjBubmpTNm9YS0p3VVVYNkcxYmpScmpjWEdkOHVHRGh3NGhMMEh2UFdm?=
 =?utf-8?B?TklqQmJlaTB0cUxEbHptenN4NUJkUnZ4ZWIveEE2ajd0SDBLbzlCNG9TcXVS?=
 =?utf-8?B?OUJsSnJlaS8xM01IVkZMZnJQTEFQbHI0ZnowSG1icjJMWkRFb2pmaXIwb0l5?=
 =?utf-8?B?cHVvTHdEd0NWbnM5bkZMWVMwVmtSVkJsMmJYVGdMWEVUbEpVd0JCdXhxM0la?=
 =?utf-8?B?ZVhyc1krQ1Q4YjY4c3puTUZBRHh5YjkzZlNPNTZvSjQ2K25rbXI0UysxbXBl?=
 =?utf-8?B?L0s2aXZ5QnJYU0k0d3JqK1NBVGZseEVKVzNsK0duT25GckR6dlRJOXkxbUE2?=
 =?utf-8?B?VUwzUE5CdWRnMUFuYXJzRkhvSEJxTlVldnhGelJVQUpKbUJJdGVMZ2JvWWE1?=
 =?utf-8?B?OTlJdHdGblRYUytGSUpISWdwbCtsR0xaM0xEWUJ2U085S0Y1WWhkQmhDeGV5?=
 =?utf-8?B?TzJqMGhKeE1YN1QzWHAvaDhRSlJDdThQcXd2VXRpdkdvY1N0dVFMSFJGQ01G?=
 =?utf-8?B?T21CazFVbDUxQWdzOXlFNnJNV3hud0h4cEhZS1Q3K0ZhWkFmcFFzZityUDJT?=
 =?utf-8?B?akJNM2VnVU91MGQwa25rMGUzbXRrYytvck5YU3dUTUhucmZmU0ZRaFBhclRL?=
 =?utf-8?B?bnNIdzlYNHc1K1F6dHR0T0JhaWgvdEp0YkwzYTdvWnUzUXBkN2dEbzdSQnFK?=
 =?utf-8?B?eFZ0OUpoMjNtZ2xqc3FZMXZETXQ0Zm9tMnBSSjNTNW13akFPTWxZNnlXdDZV?=
 =?utf-8?B?UmNXSkMyM2gvZXUrbkh0WTBsN09rQXhhajlhVEFPK2RMUEQwRWR0MERpcUFB?=
 =?utf-8?B?dDJWanZnVUFpUWVrMWFZY0xvMTdYSW1jQXUvN3BKOFZTWE9vZzdiUHBRVFpD?=
 =?utf-8?B?RThxZTZMcGFDZ1R5UEhGNVRJWEZuZ0Izd3lxYk9FLy85elpxcGZDR1RRMDh4?=
 =?utf-8?B?eWltQXhhMmZ6SVdlTW9ZVG95K29Pc2hoaGJQejRaR1Q5a0Y3Q21nRHFyblBi?=
 =?utf-8?B?QTJMNlFIeG43ZzFnY0l5Qkx0QTY4dC9wVWt3aHlNVXllSmlNWGNrcDhWQUUx?=
 =?utf-8?B?dXAzODhuUjViNnU2cDhDTXNoeko4dlBTR1FGblUxV01kV0xoSklzK0N5S1Vk?=
 =?utf-8?B?MjExbVdhekt0aHUvMVp1VE9zVHA3Z2IzK09ja2VSc1F4ZlFLVUxUSi9RWlAw?=
 =?utf-8?Q?Wk/nf7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmFOS1NQZllXaGZNMkZQa3JFS01yMVlzVk5OdDhJTmgvMnlzRVo3OGZ5OTJ4?=
 =?utf-8?B?OEVuQ3A2VnFKU0crRE96dTV1cjJGdVlzYmxybC9na2prbVNVMXgyRUJMUUcy?=
 =?utf-8?B?R2M3VEpHOU0xZEExb3FlWk84dW9xdUhvT3NyaVZqMWYxZjFBN3JkSjRRTXZu?=
 =?utf-8?B?Q3NvczNQR3RxMXpnRE9Lc1ZPN21KUEpiOVpKeDJOaHJGVFVQTG5OOUU2RDR2?=
 =?utf-8?B?NXhjcmNDRjhiMVZhS3dNd2hFRFlJL1lrRklhd0JqTSsrbkZ4ekVEKzlvWWZG?=
 =?utf-8?B?STVXZFVSejl0d0RITEVWUjFtYlJVZExYQ216ektJb1VKZHYyZmRzZUlyWnhU?=
 =?utf-8?B?S1FDM2gySUl6WU9NTy9nUEhXK0NBSTFmZjJkM2VhQnB0YXpUZUFoT25aNzI3?=
 =?utf-8?B?c1hXaGJOUXFoNm53dW9aQlhKR21jak1pUUVRN0hDR2MrenAyYU85SFVJSHow?=
 =?utf-8?B?dHJnczIzQWZMcHN5a25XdkRmeGI1TXJ2ZXF3a2VybkxCZE5JSDlqMVpmQXlR?=
 =?utf-8?B?R1hhdVltd3ZpeGlOQ0gzUUtsTXRsNU5MelRGSUhCT0xCeXJHODc3eDBFd0Ir?=
 =?utf-8?B?US9tbDdmSFZEb1hSQkpBU2dwK0hvMFRiMUdtVDB6clZtY0t6bFptbUVpL2xi?=
 =?utf-8?B?U0RpdURGYU0xZVFTNC9pblZjOFBWV1F4bUZKOExIV1pDd0JHNCtEOXMyelBC?=
 =?utf-8?B?QThkU1JDK2wzY2duUW1uZjBteVROekxGdW8vcFVRajNWNU9takU4ZVA5Yi82?=
 =?utf-8?B?cC9iZkd4WDlWcXIwMlFDekU5SFJZNm16eU1PZHI1c0JrUm91NVRLUWZMRk1q?=
 =?utf-8?B?VFd2bDMyRGRxZlNzSkpXbXo2TGFGYXNoSFdnVGQ5akR1Vm5TMndEcmtPVzBn?=
 =?utf-8?B?dmllZERnUDE5d0s1eEV5d2FHZ1VHRyt0ZzhKanFFb3BLd201d0R2S2pjeGZQ?=
 =?utf-8?B?eGd2YVA3OHZKdDg5SFNxOFBjSXVtNmZ2VTRLdGY5T3dFS0JJY2gxQXBBeGtX?=
 =?utf-8?B?Ylpnd1J0dDRZZTJxaWVjU3B1UTJvWC9JVkFzVVMzMEwyTjc5dGlTQkcxV1FY?=
 =?utf-8?B?Y1VLZndLaitHL09oUStQKzZ5RGd3b1JSTXRNQTkyczRxSFh1S2pZOGdiTnhJ?=
 =?utf-8?B?aVBpZGZITXNMV1RrZGJ5YjhacGt6ajBYaFZLcjJVZzZOalZpNVVjdldYVDVm?=
 =?utf-8?B?aks3aERDZ0RTamJ4S1hPYnN3UzVHV045OCs3elJtbVlzQkdsei91aFVIYTdW?=
 =?utf-8?B?U1c3aWE5Qml0OVlUSXNRYUtMQ2cxb1h2QWRCd2IwancvWmprNDM5SXhiKzFj?=
 =?utf-8?B?ZmczdW4zUXliREFjUTl2VEtNRjQvNjhLWmpCb2ZPVjI1dHZnWDVpOG5xYnFB?=
 =?utf-8?B?RFoxVHJCUXphV1U3MFA3ZEpDU1lJTDZNUDQvWWxxYVdQaVQrcnVWUHJGNWpZ?=
 =?utf-8?B?NlhKbG1HTUEwbDJOSEduRDZTbDhPUklNSGpyVkpNa3lNQjgzQlBGZUJVNWEv?=
 =?utf-8?B?OVczMlRkVERNc3E3ZE9QVlpuUHBIMWJnWWI1WHZpdUJVVWhDb1dweTBNOWRv?=
 =?utf-8?B?QUxZQzlLOWduckxEa3Z5bDBaQmU0eFRvdFZ6R1JiNzgwYzluaTQ1SGRNYXQw?=
 =?utf-8?B?ZjljMFZWVG1QOUovZ2k0TndqYW1YbDFiM3krdUZEcnFjWjcycjM3OWUzejRN?=
 =?utf-8?B?MjlOVE9xd3YxRE94RHVXNmlKcUVKWUtpVjRGMXlHaXhQeGZPK3A5YXBENUpC?=
 =?utf-8?B?U2Y1UFlFUXVjS1VnekY3ZG5ZRStKS3lkb0JMV3BPTFdzbjlxemdzTjVCZDBj?=
 =?utf-8?B?bVBrMTQzRGY0eVlwV1BjVmRUVkVQaXBNS1RRdEtJbXBad1IzeEFoNFNKSXNR?=
 =?utf-8?B?ajJHSEFhdXFUcTVUM3dKbG45WDFyaHVrVTlFUmZua3NwM2FyZ1VORHlucGZV?=
 =?utf-8?B?MktCa0R6aWR1YlVEcjA4VjRnMFR2NVV2S1RXb2Ivd3JicHNoRjI3bzE5Sity?=
 =?utf-8?B?d3BodHQ0bUlkc0JZZ2NkVDB4TUJiRUM3QWEvWVB0NzdpamhRL2VJN2ZwMlMr?=
 =?utf-8?B?Qkx2OE9ad01wUVo1ZWNVNGwyZmZLVW1NS0ZJNXFLZUFFb2p2M2xUZTFvOU9j?=
 =?utf-8?Q?bZ3Q3ASo1tlGsm7k9KR6m9rxB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1245489-bd77-4b6f-93a0-08de0d206d97
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 01:56:46.5610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0bswtr2XIhis5DFHMH4iF0AQ6D/5BRdAxZ6a2OPWygg5hX9+2LJ+o2CNE7npRHhX1EWvSg4HtsGe0K8apTpiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7125

imx_scu_enable_general_irq_channel() calls of_parse_phandle_with_args(),
but does not release the OF node reference. Add a of_node_put() call
to release the reference.

Fixes: 851826c7566e ("firmware: imx: enable imx scu general irq function")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-irq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index 6125cccc9ba79cd3445a720935b5c0b276c83d73..f2b902e95b738fae90af9cbe54da4f488219906f 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -226,8 +226,10 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
 	INIT_WORK(&imx_sc_irq_work, imx_scu_irq_work_handler);
 
 	if (!of_parse_phandle_with_args(dev->of_node, "mboxes",
-				       "#mbox-cells", 0, &spec))
+				       "#mbox-cells", 0, &spec)) {
 		i = of_alias_get_id(spec.np, "mu");
+		of_node_put(spec.np);
+	}
 
 	/* use mu1 as general mu irq channel if failed */
 	if (i < 0)

-- 
2.37.1


