Return-Path: <linux-kernel+bounces-778198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A89DBB2E27D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBADC1C83767
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C5133436B;
	Wed, 20 Aug 2025 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BocsTrTH"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013013.outbound.protection.outlook.com [52.101.72.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E990022129F;
	Wed, 20 Aug 2025 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755707845; cv=fail; b=DN8GbMz5OyVtvzxfrSokBGDQOSkHJnIWDln1HXzDfS5FYeDBabrcoR2bAN5o67n2/sdDVh5QIvbPV/eoCqkgw2b4CULNhHNN6iCcmyu4ISSEJtDaKaU1pUf6tNdtFtDdXwfYjKSsoh4JmLnXzuGUf6Su/G9mUCPm+htzGe2QNTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755707845; c=relaxed/simple;
	bh=NWmUcJsvAnM6ROIyhGQejKUjCYwZ8nVmKH5A1wHxnxE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Jp9WItgP5HhUTtMxma1SNQb8VM0wQeCbrgHnaCkgnrpxoZ7RAgg3rfsOKpUdwMBhm8pzuhWH3UF2IbiKd74qDVXtus2t+Cr1sAV65gf5KkoRw7VglNkxOymNFtOtJlWp8Kx1UeXdEo88MVmKXN41hop+/D8JSXvJeszaKUx5bI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BocsTrTH; arc=fail smtp.client-ip=52.101.72.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJu8z+3x0mUYyO8SCMnPO3QhF2p62RMARALd6p0Gv5hAlO0TaAQKiEI20ejDhKpG2CwO1Amo0tDypa12rKLrrJBNvbatjbwgwX8MkqUC/hRMoWT7pa/x29dcR+W8MME465eb2cr91uM8/h1g0Beu2UJOn07Zft/R1/OKjAuKY7OSfnyF9aYi5+DbmHRyhOvYahV+YkpZaQz3gmP7qKnBHcznsA/OS+yJUoFKo9vMfn8QTnzeGqOcrjEYFOwU2z1eD/laLs3bIGo7b1DWYToineGPisqwYx42lemhL8eG3uXfTtWDmlccduMdMRmofj8QZcyvMych6slQ9awwagINZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbUWujwXRpk5fDpO9qmpyq5ZiKCQNxD/Ntue5Kp4A9s=;
 b=pT+vP6+K9RD5ROjFCJeDhSoUkO7jZ0zfgQBHi1n0mHvcC1APrrXL1GNHuwfgq14iR4qtANdexB/JuwBXR31g0HvE9332K7DIKrqOSpGG8G8a4BjpRiyQHZgIQ/wN6hJTBGQvaLK0G6xQZIU/22QyWM3uYOl2C+UrRfPcJGuZy2JeWjyThHvjoqTERGBMhQm2v8kirq9jJI/T9Z4UAWtvfaDzvxDRy++WCkvGupIuuLhPKifu24E7Dq1PWJTWp8I8IHdyPBwCFGtWlCHOP3nucL+oP3Hw/YxrFmFaCvSKkzNAp/ZycrO3Wjj4wNjZR77dgKpj0GSCjooZHlboFx5YIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbUWujwXRpk5fDpO9qmpyq5ZiKCQNxD/Ntue5Kp4A9s=;
 b=BocsTrTHqF7vLYb6lSileB5QnON9XlEW8Bl4Pb5bVJ8NUejdzarGlm3yn103inAcKKL/Csyxp54xSkB4eBnqe4ygysc9N/uY+Tm3qa7PzHFcD6MzCQuY1/5LmMySp4+W4hH0jlflipxSFzI1va1fMD5jC61cRiiVbbcl+L7x4mYsPVnXRhIJHJT6rtKXJ6+nlcT3/2GkQPVy40QREDcLuatuxzhllvXOypvzmIuZWBlThcd9OkEqXihWBQRsucY4+HdOlUU5pIiNo9U5R0wKuCKoxlmG+K40v+vyCG7th6nq1SnPyN/0N8iJl2MgmkpJGnkW60d5M7c24cM6vEZq9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU4PR04MB10338.eurprd04.prod.outlook.com (2603:10a6:10:565::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:37:16 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 16:37:15 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 20 Aug 2025 12:36:51 -0400
Subject: [PATCH v2 1/7] ARM: dts: ls1021a: Rename node name nor to flash
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-ls1021a_dts_warning-v2-1-2e39648a32b7@nxp.com>
References: <20250820-ls1021a_dts_warning-v2-0-2e39648a32b7@nxp.com>
In-Reply-To: <20250820-ls1021a_dts_warning-v2-0-2e39648a32b7@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755707830; l=1754;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=NWmUcJsvAnM6ROIyhGQejKUjCYwZ8nVmKH5A1wHxnxE=;
 b=JYtu8o6wHIJkGbw1U5DSWJOLljKOWtk2cbMmh7hX/5gPDyTaN4wYcRM5YLuReuWxk7Wnmsav+
 +6Oa5veeBTrBmDCfI3hblrjzI9jIbTUIl0Nm8EWNvnqfC/SUmBO5pKh
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::26) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU4PR04MB10338:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d64b7b7-b451-4188-6ea8-08dde007d26f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTRCYXVqckhnejlydW56dkwraG8zT2dZb2o2Szk2cFN5cUE1UlZSRUY5d0xz?=
 =?utf-8?B?ZlJIaGZJVUE4N2tIYldhQUY5WXMxSm9zQzFob0U4eHYvdHRwekF0cDc1V2ha?=
 =?utf-8?B?UWNNRnIzOVpvSjhHQytzRW5ZTk12ek1FWkNSOEplRm4vblUxUGNaTVlIaFVK?=
 =?utf-8?B?WXhGS2d1eWhPY1ZLZUxVQytUTEladXBDTm5GZCtQaTFsbFR1QTFzbFprQ2Nx?=
 =?utf-8?B?ekdsdVI3ck1PYVBaYklSdjRzUmUyQXF4T0NnN2RJUDN3azNMWFBVL2Q1RjA1?=
 =?utf-8?B?T05ZSkRMMW0xak1YdE5RZDBkOWFqTHBrK0pHZFQvd2svVE1MRm1IbllYOVph?=
 =?utf-8?B?elNjYmRRczlqVUg0ZnNWUXhSRGoxZzNvM2pjOG9ZLzQrVzNNbVc4TUtneVNJ?=
 =?utf-8?B?UVd6b09qcnpkdnVxTWxzQklvcGphWHdFTzFtV3BqeFNyNHkwaThtdXV1dTAr?=
 =?utf-8?B?QmI5UmEyMFh5VVVhaHdHY1ZCWHVVRlA2VVdSMEpldUZxZFJaYllscXFMZTdE?=
 =?utf-8?B?dDNCcjFlZVpxVlJqaElnWm5ldHZzMmk1cU9qSEZWK3E1aEhxS3l2Y014dGpn?=
 =?utf-8?B?WE1COEdGZncrK0h4TitLSG8xYUVhVnRBYy9aT2pkUEErUDBCWTBXWVQxd2M3?=
 =?utf-8?B?bEx2L1BOK0ptcjNXRnppU0NCMGVsRXZTd2J5cDBTcmN6bTk1UVFZUkdYTURI?=
 =?utf-8?B?Q2Z6Lyt2YktBOGxmcWNGZnM4U3RDQkQvMk1RL2RpMnRYVUZ6OGdaQlNzd0dX?=
 =?utf-8?B?S0I5VVMrM3crRHZsb3dqd3ZVOEwrdmNCdFJMOUIwWVc4NlgraVowcWNwWjZy?=
 =?utf-8?B?TEZxRTFFY09uenlzMWVPa3NzVHRiQlRPUkJPT011c05iVGJDaVZvU0dDejdL?=
 =?utf-8?B?dGQwN1R0ejVYUjRxWUw5TGdMSFcxOFUrMDlmdmhiOElUTldHMDB4QVc5b2Fz?=
 =?utf-8?B?UGVPMm9DQ1hPdkJaNkJHRERLKzZnVVBwNTlTNGJhODIwWkRTdDR2blRsbHdi?=
 =?utf-8?B?NjVONXNQcHF1YXVidXI4cjJvMzNnSmJWU1FyV1JCUXIvWmVPcWNjWTVJNllH?=
 =?utf-8?B?MjQrU3F1eThEZUlFSmJZWGZNNlpUaUs0Y2JmclhPQ2VyRE11M0JKT2hBdUZt?=
 =?utf-8?B?SmZJTVYxUFFxb0tvbllKVnlTbFYvK25tSEF6bkNyQnFzUkJKcmpsV3ROQVk3?=
 =?utf-8?B?KzJabmR5Q1A4T0N6MUNsTzE2Nnp1M3ZJc2NkR0pOSDNIT1lYWmVCWDc2RmMz?=
 =?utf-8?B?QnVVTUVsSVBaZlh0c3d4cnJKT0FNdTlWYjZBN2EvTy8vMHpLY1Q5RWE4bXRI?=
 =?utf-8?B?b3d2RXhLWUU5aXlnNDV1WnU0U21IMnNmdXJrako4aldIY1ZSMmg4QVFyL1dn?=
 =?utf-8?B?SjNyMW9uYmpRZmo4UW9semlMS2R5d0FmRFJJMHJ2K1JyRHQvbzZRUUxQelRv?=
 =?utf-8?B?dDcwZDR4VWVER3RucTFRaWdxNnVzT21hWDVNdFZ4TzZjYkFybmdDT1IreVk3?=
 =?utf-8?B?VGtuaXZpTW5mOVhMeWRZOGM3WmxRd3NUeDgzTjZJaUhvVDdjSkR2S2dnWjgv?=
 =?utf-8?B?SFdwbkxFejMrWkdCdUZCZnZyNmgySlNGL0NvTVFRSjlCbVJiQlpGRzE3M094?=
 =?utf-8?B?Ti9pV2lNanVBTDZ1Y0dwY0dIRVBIM0txSzgvUEY5eDFUUjFFQ2pCM0dzQ1pC?=
 =?utf-8?B?L3pmZ3NLUDZkNDk4RDUrUVpCS2NKZ1d2RFMyUHBucHZpeW9kUVFVUjBvZ1hH?=
 =?utf-8?B?eTVUV0lrR3d3MnZhUk5HcDR2S0thWVRyeUtqVXZ0bmxuSDVoVnU2MXF1bDcz?=
 =?utf-8?B?WklTdDVYaXo4VUF1bjhqbWdRYml3VVVNT0VZZDE0VHFVUGxhbWgwNTF2cXVC?=
 =?utf-8?B?WkRGSUpYckx2UFRIWFlsaG5XK1l3eUx5MkRVS3NCY0Ezek15T2xIRk5Ycng2?=
 =?utf-8?B?bHZJcXRIMzdTeDI0dWJEaGVVdWUva1ZmL3h1SFcrS2M4RVV1N3FzdXR5THU4?=
 =?utf-8?B?QXZVVEJjMStnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFB2RjJFWUhjUC8ybzZqYXRobXBIOVptd09XSHA0cTg0S296Z3d1am9QZTJY?=
 =?utf-8?B?WFU0NytCUThYZk9PbDNCK0Y4VlhsNjgvODdqZUVYQjVTK3RvL2JoTFhXS2k0?=
 =?utf-8?B?M3ozNGJ5UWNhaDJhWG13Tm9GejRpZmN0VjlnQTczUTFFemE3Qld3MkZFdGlI?=
 =?utf-8?B?ZVlHODErbDUrd0hnM2k4ZGdyWWc2RXFRNm9xaDlMN0NERE9VcklRUWRDaUI2?=
 =?utf-8?B?YVQxb2ZBV0dwZzhxcHZFMFQyWkYxemtWd3M2UzNiYlVxVkhzU0duZ3R4WWF1?=
 =?utf-8?B?MkRmSExObXBVQWJkZGtVbEt2Mjh6enNXZmg3NHF4YjFuS0dqM1JjRnZFNW5x?=
 =?utf-8?B?bk53VzJBdW9RT2lRb00xNTFJWG5qWlRWaGVjL0ljcWNWWHBoWEl6VmczMWxh?=
 =?utf-8?B?ZHdIUzhmU1JMUTFReHROSmpCVEtwTFFndGRjNWRab2IwMGlFbzRuazFrbEY4?=
 =?utf-8?B?Z3YyOFd1QjF5bkUvVkF1cjZ5RjJJZWgyV3RpVlhxazZXaGFzZXZKaEZNcGY1?=
 =?utf-8?B?TWpMdzhSNXMvWFRtQkdRNngrTUhxN0V4OTljZ1oxVnBHdUh1NHVIelVzSWdt?=
 =?utf-8?B?R1hJWldaSmlCL0xHdDhNeGVyZm04NnNoTVI4MkdzM1ZIbXNIT1BwdXhoclFC?=
 =?utf-8?B?bURzdmZkdjhWc2RIMGN4Vjc5cERDNzZKM0xYYncvVzdVU3VUTTVuZkhhVTVE?=
 =?utf-8?B?bWpjNVZtQzVoeVJsaGYyeFFINVBjTklCeEV2MDhxZ1VWaUhlQnZVem9Pb0Qy?=
 =?utf-8?B?ZlZ4Z3Jobnh6Z2MzSW5ZRmpEVnVvdWpzNGE5anJWNHU2OGI3L2tMS0FtbUhw?=
 =?utf-8?B?Z25pWXBvLzlkeW1SM29ONllUWDRJemE1aElMSnhEb0ZPV3BzQkhsYVVGU1pn?=
 =?utf-8?B?YmF5SVRYQ1ZpQkRPU2dGbjNKaXo5QmkyaXY1Q0UrTWo3R01RdFF1SmdieEU3?=
 =?utf-8?B?elI5R1ZETHpIbTN6TW95aWt0RkZKSmF6QXRZZ05ZRTNPTmlyd2NNcnczUnZu?=
 =?utf-8?B?WGZmY0FIVjl0VXRwU0tCNGFWM3FhSU91OFF3MFNZTU1KRGp4S3FvaVNleklC?=
 =?utf-8?B?ZUF6QkttcGN3WDV2eERCRUg2a3gxVk9DTktEZmV0QVhzRzVuVUY2cWVxRHRX?=
 =?utf-8?B?YjRFWTNSUnA5QTRqUHhuL1gyVW5hQjN6OU8zNzNRRm9CakwvY3hQMFc5K1kz?=
 =?utf-8?B?VHVmc25pYXdqNjNDY3dUU1JhcGR1NW5idktPeUd4REdBRmlDL3dLZHcyM3BZ?=
 =?utf-8?B?ckdzWjlLUC9mQ2YvMDBOUS83TDY0WjFjbTc3WVNTVHhGUXpGNjFCZ0VUZmtJ?=
 =?utf-8?B?ZnJSRjNLTjhOck5OSkdLanZ5Y2U3bWRDL3VNMWFrVldia0F0OG84TG84cktL?=
 =?utf-8?B?Znp6RzJtZFV3OUpwdlAzQUhMdHgveWkzZ2RPQ1BMRDk4My93eEFpL3JnQ3NW?=
 =?utf-8?B?R1ZzbW9RYW9ETTRoV3Z2Uk1FOFNrWnFXMUY2MytOQ1pZVUdmUWNhcnpRdmt5?=
 =?utf-8?B?UGQzTEtqeWJPY3NxeEh4c3FWRW9yMkJFcDNzY3p0UzNMVng0NmpwY0tmYTJa?=
 =?utf-8?B?LzIzb1ZTTDdTUmhFMVhOVy8yN25mcjh5Qk5vMnBMYjlINEl3c2hnaXV2Vjgr?=
 =?utf-8?B?R0tRWnRzMnYxbFBlY0dWTTNPY1BKWlBQU0M0cFBydm9tZGc4aGxuR1ArQUFz?=
 =?utf-8?B?ZnpPMGk4WG0xTTFLVDRUY3IxOEprdEVhKzBSK0ZBTDNTRnpUVHlXN0VQcTZV?=
 =?utf-8?B?NHZmTXpjaEY5d0h4bW05dWIxUjQrLzlHRkswdmx3NHk4R2ZINFRkVlZoVVpB?=
 =?utf-8?B?S3UrWERySDJYck1SMlgzUkxBd0NnQjJtRWtneGxPc3BpNGhhWENWUk1lWjdt?=
 =?utf-8?B?UUpwTjQ2ZHErV2tVbW50anFNZk5oQ0NwYWF2WWM1MExySjVINTk5TEEvbk5V?=
 =?utf-8?B?WEFYQjJXa3JXOVNlNExscEdOcHpYMzdzRkh0OFhHN3FkOGZmWnpacG1qR2J4?=
 =?utf-8?B?MUdQV09TekJtN0ZYTnpFb1VjRE9WejQybEFxSzBNZlFoSlcyZ3hHUWVqQUlt?=
 =?utf-8?B?Z2xlSW5hOHdjelYwM21VczRISFlYOWlhaUtDNFhzeCtqNUxUc09iWmdhS3FV?=
 =?utf-8?Q?lfTJaQBAtYIA8AVIf2bTk3ac+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d64b7b7-b451-4188-6ea8-08dde007d26f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:37:15.8908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLwbL3WlSkjgc12RMn7dhpCb6YyPKxifx8iXWiLV09kGmtA83OAguNoGkFQt9blvdEUMvRYiZYD8T2Bvrye6tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10338

Rename node name nor to flash to fix below CHECK_DTBS warnings:

arch/arm/boot/dts/nxp/ls/ls1021a-twr.dtb: memory-controller@1530000 (fsl,ifc): 'nor@0,0' does not match any of the regexes: '(flash|fpga|board-control|cpld)@[a-f0-9]+(,[a-f0-9]+)+$', '^nand@[a-f0-9]+(,[a-f0-9]+)+$', '^pinctrl-[0-9]+$'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts | 4 ++--
 arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts b/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts
index f1acb97aee69bbcc30c8034e627a0bc6584bf608..8bc8ff2e3b03d6eeb43d79fe0555842536ab735c 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts
@@ -66,7 +66,7 @@ &dspi0 {
 	bus-num = <0>;
 	status = "okay";
 
-	dspiflash: at45db021d@0 {
+	dspiflash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "atmel,at45db021d", "atmel,at45", "atmel,dataflash";
@@ -187,7 +187,7 @@ &ifc {
 		 <0x3 0x0 0x0 0x7fb00000 0x00000100>;
 	status = "okay";
 
-	nor@0,0 {
+	flash@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "cfi-flash";
diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts b/arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts
index f5c03871b2050c7cad854afaf59db046640df3c6..38281b904301df6a9d612fdd4384475a68b0cb33 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts
@@ -151,7 +151,7 @@ &ifc {
 	ranges = <0x0 0x0 0x0 0x60000000 0x08000000>;
 	status = "okay";
 
-	nor@0,0 {
+	flash@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "cfi-flash";

-- 
2.34.1


