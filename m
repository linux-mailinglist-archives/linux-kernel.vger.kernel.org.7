Return-Path: <linux-kernel+bounces-800546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4600B4390B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05BA37A475E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A872FC86C;
	Thu,  4 Sep 2025 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JiQSVSzw"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013011.outbound.protection.outlook.com [40.107.162.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1421E2FC877;
	Thu,  4 Sep 2025 10:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982519; cv=fail; b=FqvxZfM91DiuDVmyUV0pqGy3pCI94uwSSCgS0lL9N5hk1bfyJPOioR0CV49QcdhgH7v9YnmlW6+NE1pdxlbFx76Xie9AHuIueyC+jYeJLqrHOvf3gLuF21P/dMJpwKpqHMnMdrz3k8cf2G7YrGWF5H+QFk54mxvPAb9gHd1nMnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982519; c=relaxed/simple;
	bh=OJ7D4r7yKdFsldsWxIZehXAHLWF7wGKl3Kd8CkogeqI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nwdJxVJYQds+xcHquyTyxLxxqE7JwoMBfFqgJDxNzh26/R9EZNmwOayAvgRC7owttsfTEYrcBvN+T7Ut7cb95WVvWqh3eWI94wR+l4P7tMc6XXDBtJNJOb4m7SAjJaIzC/twaBNkFEJBb2FuaAeHjWJtkHgMF97cliWQIlp++Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JiQSVSzw; arc=fail smtp.client-ip=40.107.162.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPwHUJ6BW6+JTjyYxkBVKVx452s7nfnBLTlSmwNp2DQ3e70mo3/C4uxCVCGM8/SsjvREDFD7oxnTpxJ3mezGmNIzJKuYZ3kJlq7fhTCxETG9nJGlIMzGY3NUD1ROr7IgBmqn5+veMUqGeWOWAJLbCOmmFr38ZRaKH1XVumCXIA6B6TZVGifGsrJ4IMflRvG4agXdo/pcr2sveQxTt5f1HP20Zl2KQW16NXwAEbwZ77UM/xNdXXn9Mae1LAlyN5VlwK7V9Pp7iGRlFrqpG3aJuxXDVAMLwdlO53XzSuPOkl0t+oxTz6d77uNUpbc9pSzbWKveyHxrxBzcCFrS/i5hCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xq5YK5jEBzja05+ywRXUJeQCJjYUYz2hcjWmUZqaQIg=;
 b=NbH+2XadklyHxxHAS5utXepOZxAsa3FUB8L4WI/R6fU01sb+4NU5kP6wy/J4iVnEZdsrrO93MlUR5/rnnl3H3e6fPHeGe6ju5Rm9Q2G1/HaHEjDmScoj/7QPPLaVj5qeziLQfmUE6SVq+43+d6YKrPOPs8wM5OA63Vs+QOPLbNZZaRpWdCupLqqJps1d/f+YEu5A3M4V9JLWLLEE99f4i31ATmQd3fSh9dm9RT5v9oy7hyIjkfyGRm9BMk8wtcKS95xYTFeWQAuUcGD/ZktThzWgmuB4ZfVJTZUpZdPVtJO7oklzdlVcSl8H2NLyNtZQiN4JyTiE+B/faf8cSyEJ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xq5YK5jEBzja05+ywRXUJeQCJjYUYz2hcjWmUZqaQIg=;
 b=JiQSVSzwJaz5DIk225rR3w8o5sybdwD6pEw9nOeqcKcv4bxYw7dsCvDefOzumAuS4q4BLr27f2OFvHplhoAfjwB0ytgt6tMIBYTnJNCan+pW9E8ga8J0FyMcV6D/vhZT61X+w9ma9tPUovySTD/T+bQ2lZtC0YFkQOB8bkLaFz12wI2kxr3GKOqw6cS89/7xFKGJ0wCexxDZhZawxbr1rs/MN7w0hA9HU33zW0FImeDpYVyR+RqHlnnmpecc6EpV2Xw8EUa72B3tVBHleP5bzqPaZfv2sECIwRAAoDHDsQwqD6UNHZ/aYvBUEaHqBRLKa8oXv3Rm2rBdqEdOyvVVvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB6937.eurprd04.prod.outlook.com (2603:10a6:10:113::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 10:41:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 10:41:54 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 04 Sep 2025 18:40:46 +0800
Subject: [PATCH v4 5/6] firmware: arm_scmi: imx: Support getting syslog of
 MISC protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-sm-misc-api-v1-v4-5-0bf10eaabdf1@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756982492; l=5496;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=OJ7D4r7yKdFsldsWxIZehXAHLWF7wGKl3Kd8CkogeqI=;
 b=3S7aOcxVU0CDmRnPYVZ414M00b7o6FNxy7QahfJ07pYxTyaS5MbdOKwA+GISipsoFrCN5UC3H
 AYQzdPOlHNIDHfBbKJPLSDdbRffkrJwg8fmDP8J3CZAvkQx6laEr7rt
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
X-MS-Office365-Filtering-Correlation-Id: 05d3b0a7-1d00-4a16-c349-08ddeb9fa9e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVNmREozQXVPZm5LYjhlNmREN0dpMXhud2ZYNXdEc29oZXVtTzFPa0YzUGh6?=
 =?utf-8?B?YldmRU50YWI0Z2U0cld6WVU0ZEwyMG1YY1A2a29SQldKNG0rK3k0L0ZqcmF1?=
 =?utf-8?B?UFVrWlpVVSsxaFRjNlVMaFpqcGs4Y1AyaXBtSUNUUFNnUEpRenFLYU0rcEZO?=
 =?utf-8?B?eG9ITTg1RHg0VkZDcGdya3VqczliQWs1NFAyTENxb1FqUVZmdlN5ZEM1YTNw?=
 =?utf-8?B?ZW41WXVtRFV4alVUMFh3Nk5MS24xVmYzSkVRTkdUSDF0OW5YdndyMlAzVjcr?=
 =?utf-8?B?Yk1EYzRBRVo4TmVvTjBxTWIzN2ZOOE5uK0hVUTZRMkNTMktMbmkveXpKVkk5?=
 =?utf-8?B?cTZPSDVsWTRpNnZ3RzR4NzJOM01pS1FTcmZWRDZ3R0dHdFBlcmI5M0thM2dR?=
 =?utf-8?B?Mmw5cmRYcUZUWjIwV3oxRlRCYmozQ1NKOUNhLzRUaSt6WndFODVtU3BVaUhJ?=
 =?utf-8?B?a2pIU1V4MGdTV0VqRTlmdmhpV3BtZHBlSTNNS2lEdVQxZkpCRVh4R051WmJh?=
 =?utf-8?B?REtUcVNlbkdEMHZmeTVRTHVuT0FLNTJJb0RDMyszalZNaGxybVRiU1RrSHRW?=
 =?utf-8?B?ak5KaFNOMjFMcnlsZ0x6b3JWQTZXanJOeWJEUm9nR2lNaW1qanlNMjFta2Rj?=
 =?utf-8?B?dzBQZHVlY212VUljR29rSXlnd3lXSEJQME9YRXFIeVRadWxxckI4QndHV0Qv?=
 =?utf-8?B?QnYzdkN1bTdaZFZzMlBKSVRrbkFVREMxckY4WmQ2RCtuQW1nSm9RaVpLM21v?=
 =?utf-8?B?WWlPVzlmWGphSGdBUURtaFRGSlhuWkR5a1NZZzlJL21rV2p0M1lvZUhCNExv?=
 =?utf-8?B?S1VGY2gxZEJpcHdaMzdISFhoQTJiR2dVWTgrckxSejJVVldxQlhjRm5wN3NS?=
 =?utf-8?B?WDE3Vlk0dVhldnIrVjBiOTNMWTYrOEluL2pxVllKZEd5ckNoN3dRdGpHekhh?=
 =?utf-8?B?M0JtSEJiVCtMNkJibGFLeUl2OENvZ0ZxMDhFNnl5STN1b3kvdmZwNmZhYVlQ?=
 =?utf-8?B?WjZkVlRJVFlZQ2NIV09OaS9nUUU2WkZmT29oeEs1MHJzNHlLbzRFYnV4d05O?=
 =?utf-8?B?Uk44TVF6NGk4cXJSMHhwTVlsNVN2MEoyL2V1dWQ5dlUycHlhb0FFalFKK3JH?=
 =?utf-8?B?RWlIN080N2tTdlo2TXdlTnQ4VjBGc1RKdklpUDNabEZNeVNNaWhnaEJ4cTY4?=
 =?utf-8?B?cHNJMUhhazh0aFRCZzZ0Y2hxVmZ4S2VtR0pQSGxFRnRpUEJQZytuME1oUWVQ?=
 =?utf-8?B?SDNLa293SDd2NDVFemU0U2NlT0poaFJsTkV6RzI4aDJNTWE3WkxoWkZkQkRY?=
 =?utf-8?B?a1EvbmpuR2w0Z3Fya29wenh3dWRVTEJKb0dHbTliZnk1RDNSSlBLR054cm4w?=
 =?utf-8?B?QVhQdmhmeDJpVkszSCtMWGg0Yis1V1p3bE5ESkNzcWxRR0FCd0Z2NmtqcWxC?=
 =?utf-8?B?b0NCalU5WWF5aksrVjhkazh4TTFDQnRVdG9Rb2tia0pweUJkK293UTB4MnZj?=
 =?utf-8?B?eDFWaVZkOHhxY1A4NE9sSTJTS1RKOE00bGVack9ZTC9BbHZYRnZqZENNN1pr?=
 =?utf-8?B?YzVsK25jOGtXamtZRnRoV3RYQS9KdUNDTzFKazBkZWVhaHIwQlZaY2dESW9G?=
 =?utf-8?B?K0xaNmoyTUZLZEpHSUxrM3dLOHNQNk5pRGNRbDczMm5oNWtxbFlyeGxtWUlT?=
 =?utf-8?B?Mk9VQ2pMMGRDakhLZyszdC9wcjJNSUlvZnZmd3psN053Q2RaSmVaa2xaaVNT?=
 =?utf-8?B?UHhGd1EzdGRHT2VNV3FiVzMwYXBNS3JEOFRoRTdoejkvVDRWMTJNWTdYOGRs?=
 =?utf-8?B?N0N4NEpTTnlRVFp2NWhnZENpUG9mL3RyK1IrTzczQU9Jb0MwRFE5VTJQRHVJ?=
 =?utf-8?B?VHlmdmF0U1JKQmR1cmFXN2sxSVord3NKOFEzQllHVlcwUitteUFIdFZtcS8r?=
 =?utf-8?B?cXF5dEtidmFCUWR2TG1DTDI1NUpaZHh2RjVaVGNzSXhpbTBVaHo1UGtNaGlS?=
 =?utf-8?B?ZlZjbFF0enFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VENIeGFyS3lNWXJUMnJyWTlPTkZYK09JVHNBbjJlRTdFRlpvZi91QWwvN1FR?=
 =?utf-8?B?ZmcrNC95cklxR1VKUnVyVVFsZXlrUzVldDlKQytUdEtDQitFaWxHaVBqdGg1?=
 =?utf-8?B?cTRNb0pWMjZGeW1RbHBKMXR3OUpBOHM1c1dUYVpVcDFyV3ptSUlGeXJhdjRQ?=
 =?utf-8?B?NnNvVEwwS1Q1ZTA4Z3pjUWQ5bitLQWMvdllCT1YyVmloVTFVQTBwcVhydkpu?=
 =?utf-8?B?blVFSHpqUit2TjNxQU9qdVJGVlBQOURZYmtjQmt6eStNOGZkNlMzbytyL0ll?=
 =?utf-8?B?bHFmN1pUblI2RlFPdWwrRXR4YmFiN0JwaDduSXdRY05xMVlFMUJ1YUM5L29V?=
 =?utf-8?B?TzBoRXpJbU81YlA5aDEreGx5ZmVIQWFoTC9NQ25DV3dLTTdUeTErNEE5ayto?=
 =?utf-8?B?N0VSOUlUVWh3VmxlRmNPU0J4UnVVSHJwd2s4VFdsOXBrc2hDNldEMDllNjh3?=
 =?utf-8?B?eHJWSUdYQkhyUUtoWlpIRDRCend0REdCUWhmZkNQNll1a3RIbXk1eTVidnFv?=
 =?utf-8?B?S01MbytjOXBSMXkvU0pCSDRwYS9SMWRYRm9GVi96cVJIVURNZ2xBK0xEanNl?=
 =?utf-8?B?d0crLzlCY2MzV2hzK3BOOW1GSWdmMG4wRW5GMmt4dHJSUGZQY2ZrU29jRklY?=
 =?utf-8?B?UnROdW5aM0pqTjFjODdodzAvUFNrVVVuQTJqM0JxZzlUVDY2NjhadmU3RWVj?=
 =?utf-8?B?ayt3cWJNRVVITFM3K2JhbUErdlMrbEhPSndGemxOcW1oQnMyLzNSUzF4Rkp1?=
 =?utf-8?B?eWlvSXRWUFJTNk1SbUR0TzE2NW1ib2hjWnZ5SFJldTg4YU5ZMGMxODBIODlK?=
 =?utf-8?B?T2lCVzZWYVVmVnJ5dVpia0pCMUlGZUcvTGYzNG5EckZuMzd6NFcxUXZGaXd3?=
 =?utf-8?B?cTh0QUZqd2IrL3RiQ2h0TTZXUURxc0p2cTRqRmVKVTZaeVlSRmtwZmhrOWsv?=
 =?utf-8?B?NHgxRnlSMzY3Y2xWRUtMWGlCVTVxcXl5a1R4ekRLb2wrWVUva2kxZUVTZ2ZD?=
 =?utf-8?B?TThRVkJkMlNhMnVpSFBOanNXV0lWbUFLODcwT2tqcnRwUFVLNXBZVGxMYkpH?=
 =?utf-8?B?YkFHYjE1M2ltTldiUTdzcU1yTkFhSmE3TUJGRTZ6eGZLbWVobGlnMHltaXBO?=
 =?utf-8?B?RzdlR0wyY1BLbWloMG4xT1l4R0JoK3paS2MvYlVCUVFidXJQK05DbTBZVGJv?=
 =?utf-8?B?aWsweU5oL2lSdFVOd0MxM1gvRitOODZ6cmc0MysrcExubHV0ZGJIZFRXaVlZ?=
 =?utf-8?B?YzBxZW5QekV0SVRHU2FMOForNGJmZGFpUFNQTCtPZmxpS3NSNnJ2ZXpHaHRP?=
 =?utf-8?B?dGpGNzBaL1FOT3JwaDFJbWRrMkNTaVB1L2xaUElWdnhFR0U4elhoTUJ0L1Z5?=
 =?utf-8?B?MmczNThNMktUd0w1NXR1eGpHV2xwZ05uMW4rLy9EeFN1Q2l5MVhEeG5PeC8x?=
 =?utf-8?B?NllUNmJZVUpwYzlTQldvRGRUdEZwMDBVdEpqM2tEZ3hsaHBwdnFZMGJDcXJX?=
 =?utf-8?B?R2Q0VlRKckRsSE5nckNvaDMxcytwWFVVYTJSQWdxYU44YS8xOHpDTHlLVFhv?=
 =?utf-8?B?SnhRTTNHSFNDYUp5cWNQYjVyNnBCMkZ5Q0k2aVF4cGMwK1VSMitqQjNHWDZx?=
 =?utf-8?B?K3RCUUk0YlpQcTdsK21PbEVXbTFGcUVNanh2SlVvaEhhMjdHNHNycE9mRHIx?=
 =?utf-8?B?ZXhIdFlKTUs4QW9nZlZVdXhpcmMybi9qQkUxMHVDVXJ5ZmZLRVZqNUl4M0lB?=
 =?utf-8?B?SUE3ZVR2eDFoTzd2NEJtYWdSZmFXMjh6MVhnREd4bDRMY0xYT1F5eEwyUHdh?=
 =?utf-8?B?S1FlWWh2emVBMy9PdFcxaXptMXd3ZVgrZE9hSnVNRjgvVnZ6K3RLbzdnTkVJ?=
 =?utf-8?B?Qi9UdGZNQXQvc1lLSDBQb3VPaDlWRzBYSXl3V2FhekNYRnd5S0puUWxTVjdj?=
 =?utf-8?B?NWR1eHMvSTBSRmVndFIrbExDeGJLRXFVb1JPZDBYcVdHWG5UU01waE5XVVBB?=
 =?utf-8?B?QTYvRXZ2ekcvSC9BN1BxSmswLzJ5V002ZG9sOU5mWnVZWU9aUTM2Ty9ldFdI?=
 =?utf-8?B?MmlJRzZuZ2tlQ1VmSG1BbGNQcGRJWjlqODkzb0lGdWQ1VUFHd2E5ZXVnd1Bo?=
 =?utf-8?Q?V1H9XBuWSlQCgMFQuqs5JeqbV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d3b0a7-1d00-4a16-c349-08ddeb9fa9e1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 10:41:54.0978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/nE630ENEIED1n0vtXTr4nN71ZFxNAOfDrwOgze/UEqAruUoMWfi+jzXkWMDYxnid3/rOdrfjLWfmt+2GVYcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6937

MISC protocol supports getting system log regarding system sleep latency
,wakeup interrupt and etc. Add the API for user to retrieve the
information from SM.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 83 ++++++++++++++++++++++
 include/linux/scmi_imx_protocol.h                  | 23 ++++++
 2 files changed, 106 insertions(+)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
index 9055d3c848bd159c8133298de31d3dd5a8138ec3..95ef75de1843775dc60e4b6a597e155d4f5db227 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
@@ -28,6 +28,7 @@ enum scmi_imx_misc_protocol_cmd {
 	SCMI_IMX_MISC_DISCOVER_BUILDINFO = 0x6,
 	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
 	SCMI_IMX_MISC_CFG_INFO_GET = 0xC,
+	SCMI_IMX_MISC_SYSLOG_GET = 0xD,
 	SCMI_IMX_MISC_BOARD_INFO = 0xE,
 };
 
@@ -89,6 +90,19 @@ struct scmi_imx_misc_cfg_info_out {
 	u8 cfgname[MISC_MAX_CFGNAME];
 };
 
+struct scmi_imx_misc_syslog_in {
+	__le32 flags;
+	__le32 index;
+};
+
+#define REMAINING(x)	le32_get_bits((x), GENMASK(31, 20))
+#define RETURNED(x)	le32_get_bits((x), GENMASK(11, 0))
+
+struct scmi_imx_misc_syslog_out {
+	__le32 numlogflags;
+	__le32 syslog[];
+};
+
 static int scmi_imx_misc_attributes_get(const struct scmi_protocol_handle *ph,
 					struct scmi_imx_misc_info *mi)
 {
@@ -371,10 +385,79 @@ static int scmi_imx_misc_cfg_info_get(const struct scmi_protocol_handle *ph)
 	return ret;
 }
 
+struct scmi_imx_misc_syslog_ipriv {
+	u32 *array;
+	u16 *size;
+};
+
+static void iter_misc_syslog_prepare_message(void *message, u32 desc_index,
+					     const void *priv)
+{
+	struct scmi_imx_misc_syslog_in *msg = message;
+
+	msg->flags = cpu_to_le32(0);
+	msg->index = cpu_to_le32(desc_index);
+}
+
+static int iter_misc_syslog_update_state(struct scmi_iterator_state *st,
+					 const void *response, void *priv)
+{
+	const struct scmi_imx_misc_syslog_out *r = response;
+	struct scmi_imx_misc_syslog_ipriv *p = priv;
+
+	st->num_returned = RETURNED(r->numlogflags);
+	st->num_remaining = REMAINING(r->numlogflags);
+	*p->size = st->num_returned + st->num_remaining;
+
+	return 0;
+}
+
+static int
+iter_misc_syslog_process_response(const struct scmi_protocol_handle *ph,
+				  const void *response,
+				  struct scmi_iterator_state *st, void *priv)
+{
+	const struct scmi_imx_misc_syslog_out *r = response;
+	struct scmi_imx_misc_syslog_ipriv *p = priv;
+
+	p->array[st->desc_index + st->loop_idx] =
+		le32_to_cpu(r->syslog[st->loop_idx]);
+
+	return 0;
+}
+
+static int scmi_imx_misc_syslog_get(const struct scmi_protocol_handle *ph, u16 *size,
+				    void *array)
+{
+	struct scmi_iterator_ops ops = {
+		.prepare_message = iter_misc_syslog_prepare_message,
+		.update_state = iter_misc_syslog_update_state,
+		.process_response = iter_misc_syslog_process_response,
+	};
+	struct scmi_imx_misc_syslog_ipriv ipriv = {
+		.array = array,
+		.size = size,
+	};
+	void *iter;
+
+	if (!array || !size || !*size)
+		return -EINVAL;
+
+	iter = ph->hops->iter_response_init(ph, &ops, *size, SCMI_IMX_MISC_SYSLOG_GET,
+					    sizeof(struct scmi_imx_misc_syslog_in),
+					    &ipriv);
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	/* If firmware return NOT SUPPORTED, propagate value to caller */
+	return ph->hops->iter_response_run(iter);
+}
+
 static const struct scmi_imx_misc_proto_ops scmi_imx_misc_proto_ops = {
 	.misc_ctrl_set = scmi_imx_misc_ctrl_set,
 	.misc_ctrl_get = scmi_imx_misc_ctrl_get,
 	.misc_ctrl_req_notify = scmi_imx_misc_ctrl_notify,
+	.misc_syslog = scmi_imx_misc_syslog_get,
 };
 
 static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
diff --git a/include/linux/scmi_imx_protocol.h b/include/linux/scmi_imx_protocol.h
index 27bd372cbfb142b6acb0b1cf4b82f061529d0d45..ed78660d2f51c554e782b2f665e5bc5046678fd1 100644
--- a/include/linux/scmi_imx_protocol.h
+++ b/include/linux/scmi_imx_protocol.h
@@ -52,6 +52,27 @@ struct scmi_imx_misc_ctrl_notify_report {
 	unsigned int		flags;
 };
 
+/*
+ * For more detailed information, need check i.MX SM firmware file:
+ * devices/{SOC}/sm/dev_sm_system.h
+ */
+struct scmi_imx_misc_sys_sleep_rec {
+	u32 sleepentryusec;	/* System sleep entry latency */
+	u32 sleepexitusec;	/* System sleep exit latency */
+	u32 sleepcnt;		/* System sleep counter */
+	u32 wakesource;		/* IRQ/exception causing system wake */
+	u32 mixpwrstat;		/* MIX power status */
+	u32 mempwrstat;		/* MEM power status */
+	u32 pllpwrstat;		/* PLL power status */
+	u32 syssleepmode;	/* System sleep mode */
+	u32 syssleepflags;	/* System sleep flags */
+};
+
+struct scmi_imx_misc_syslog {
+	struct scmi_imx_misc_sys_sleep_rec syssleeprecord;
+	u32 deverrlog; /* device err log: timers, clocks, console and etc */
+};
+
 struct scmi_imx_misc_proto_ops {
 	int (*misc_ctrl_set)(const struct scmi_protocol_handle *ph, u32 id,
 			     u32 num, u32 *val);
@@ -59,6 +80,8 @@ struct scmi_imx_misc_proto_ops {
 			     u32 *num, u32 *val);
 	int (*misc_ctrl_req_notify)(const struct scmi_protocol_handle *ph,
 				    u32 ctrl_id, u32 evt_id, u32 flags);
+	int (*misc_syslog)(const struct scmi_protocol_handle *ph, u16 *size,
+			   void *array);
 };
 
 /* See LMM_ATTRIBUTES in imx95.rst */

-- 
2.37.1


