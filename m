Return-Path: <linux-kernel+bounces-882622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE82C2AED6
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BAC33B81A5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716CB2FD7CF;
	Mon,  3 Nov 2025 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tmo27wNw"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C9A2FD682;
	Mon,  3 Nov 2025 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164502; cv=fail; b=GgWhcp299CWh8/Z0ecRdQa9Oc3RhUFGp5GakX2MHSQ2j7pAEr5nS0NlXyC45NOPZkT8mooc+V0LmQO66mRXTzzSHfeyHJktCDlKyGrUlVQQk0jpizekNOnUTR+ZuFQR0fqVGs2T+GdNWmOfzJpDIrGYF8mF9HM5c4gWBxzgqlPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164502; c=relaxed/simple;
	bh=pkKSSxFGWTei+bLmiottuJYERlzSp00rNaEjiYLMi+o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WJk9xsUY7yD3l5BkIkNhOG0pecT7bmtEyI9osV2VpgGRhswFDH8eWAUUyX8WTZ6kFlvq5te9i7XOiECX5DJT1gM/VUSmMUhMvdvrT4Bhzu4HFjN7T1oyrlGL6jBW+tK39fmN1uTz1JznsiFSFTOSP2O3UfYneKPtluMRm1SP9ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tmo27wNw; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDCERVEq+uEV1x3TzZ93g0VMk38qGfNIYvhT2xYjMuoS6GJYN43ikmU4py3uziFwRr230U0slTPlpXs/X408aYEH5xXq5CQ7HRn82vc5BkgPyvbMa1CX+LSgfhHnUO/LFRgOCW2jTZqO8mgmRTm+MP0JSeQXYWkABJlZywthPx91KbcCrnbUx1CkkPTnpM9u/rpIV5RL1l5i0zpZ4z+Bq+8FpVhv2kgEJtHf7qnyhG9aIfFtG8fTaomTseJHCci3pByOXVnX4FzuC0/cXhi7c3slfuIzBzlfL+S/nTCxqL11eyKEjA20mHoO6GKu0i+JAokIiPi2xKDL1X/jTaXRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efzoit/cX6vzWHCCKyuR/7QxlNHG0mr+AYzdFq71akQ=;
 b=mO59pwC9ee2Gb1CwnAw2tORSYWvyhZ4DOT+rgvuaLZ3T8FA4cHEnKAMxghIlaEigjlAfi2ke7A0bq50jkP+Tt4Yw4eUpTUd81bVgnsofL9P5Kjo6TVp8ZlRU6vRVw248xLIFonAH6F0fDO6j0nufBs6MvLS/SG2jTdWLhrxspdzVgeFQJn16Bj6k0E6pc7REG+Kof2UHTJ4scb74fL2P+4ZkFQbUhGko1q15IqMGfZUY/jZBUSMD43P0MulBtj6PWcGOHqpegCffx1POenLK6+dr2XMaIwERzSdlckiZKccYWy9Kr4LWXs1aalktURX0oE4GLkf2r0UjosmB8yBevw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efzoit/cX6vzWHCCKyuR/7QxlNHG0mr+AYzdFq71akQ=;
 b=Tmo27wNwkV+XYDNyL+V9dXpkdPdZBwjDb8kdvU+jQhV/lYNml6LfLD3DOX6ZusfhfovbXxYK8HbxqlOyb6Gk3rqFumTiNDvecqOnoAjzudnQxbWnbSR9NSKPc7FSnsMF2d+/7E7VkvYG3VDqBN4HJPJ+lOjGlBwUc0wgGC9jM4ofACuw02RTJd9qikGqG4ooNs7iWUpKBW3TxbL9Bkbd3ykaqVol+Q//kzsgbRJUoRqxg929nwfL72OIonGhebWYlOeThsICxctGIiCyIBqybaqh5JDW85wJ33Lfv9DdOTIrkNGSIJgoeufYeclxz3b4P1hCWJgeGaSjV94CTANckw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by DB8PR04MB6891.eurprd04.prod.outlook.com (2603:10a6:10:112::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 10:08:17 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad%7]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 10:08:17 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Mon, 03 Nov 2025 18:08:34 +0800
Subject: [PATCH v3 3/4] phy: fsl-imx8mq-usb: support alternate reference
 clock
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-usb-phy-alt-clk-support-v3-3-18b8bd4f01b0@nxp.com>
References: <20251103-usb-phy-alt-clk-support-v3-0-18b8bd4f01b0@nxp.com>
In-Reply-To: <20251103-usb-phy-alt-clk-support-v3-0-18b8bd4f01b0@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Li Jun <jun.li@nxp.com>, 
 Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762164524; l=2764;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=pkKSSxFGWTei+bLmiottuJYERlzSp00rNaEjiYLMi+o=;
 b=pXEWYgaHJyQftWBELXAsaXvm9vDWghC84Sw8h+izfDyYJDzcsk/sBVSzk/rO0XVTsJH5zh2FV
 38wv5OtmjVODHoPzlSLSGHeUjDinqhYpmZt8yqMVM8FgKvEXX4/mJff
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22)
 To PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8829:EE_|DB8PR04MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: ed7957de-b393-4985-7a51-08de1ac0e8a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVZkdUJYUjlqd1BNZzZxOFhpMnpZUkM1SWgxNUlxRnJEb3BjTnhIcmhrcGdG?=
 =?utf-8?B?QmZyaW9jcWxRZXNJMG1HVzk0OWgzeGhUcFN3UVZMbDFmWDNUaVdWVGtxWjk3?=
 =?utf-8?B?TnY4T1g3QlpnbzZMeTBXZ2E1TlAySG1YelRhSm5qSDNuQWxvNCtxOVhxREtD?=
 =?utf-8?B?LzhrdU96Vmp3TlIyRUpsN2tSVmZ0MWtkWGtnMmh2ZzFYaEpMcXJQZFJtcUlu?=
 =?utf-8?B?U3FqWmVJWHdMaWxtN2hNZnVTaE9XVzUwMnlCRkg5TGI5Yis5Q0ZZVytWRWxR?=
 =?utf-8?B?dkxSTldXVzNNS2FuamNvWlVTbFo0NzdVNUpxM0F0Zmp0VHBydFo0UlByeVZ0?=
 =?utf-8?B?c3g3Zk85ek5UTEhZRmdPUS9RcU9IaG0wZ3RTZi9OenRpbXBDRENtMGZvc283?=
 =?utf-8?B?elNpZ0ZicXVwZlhESHZUTFJIRk9RSm5DSUNrdHNPTFBSSWRqTTJJZEJVMXdS?=
 =?utf-8?B?TjVsY2R6emV2djZUY3BiRkpuMDRsdWw3MEZSUlFPbXc1Rjd6STluU05ocWV0?=
 =?utf-8?B?S3dqVEwvV2FaUzFNU0VSSElOMHFLYWJBRWJnVHdYWm1oaHM0MUlQVDhpcmpB?=
 =?utf-8?B?WlZYRTd6RTNZOFoweW04dXVoQ2NNLzR1QmRnQlVxRE02eHI4d00vbjJkRXI4?=
 =?utf-8?B?OVJXV0ZYMFJoZ0xyU1U0OWgxbjMyWG95SmN3OGM1TXlKRmFQMU1RU1dMK1py?=
 =?utf-8?B?MWJvZlNoblFWOWVFUzIrQU5zc05vV1ZhbWIzcEh3V0x3WmV4bU1KdVpKN3Nj?=
 =?utf-8?B?RmdjN2dhcG5rZWkraXp6MThYWWVvZ2lzcy8zdkdZTEw4cEhCUXpJNFM4QTNl?=
 =?utf-8?B?OWRYRkVDaEM1RGgrUElKeFAvNGVxSFg0blNJSFM0MG0xQmRaME13OGJrclhK?=
 =?utf-8?B?Q0tuaUVURzY3U1lzNm54RHptN2gvSDQxT2h6bnFTdnJXYTU1dXR2eVRpc29i?=
 =?utf-8?B?am9QTURqUXNrSHBWdWRwcVFKdlo2S1p5dGVSSDlmOXNEdkUwYmxTVDVzZnlI?=
 =?utf-8?B?Rnc0b0hHNUtYTU1kaWc4VVV0bHE3aVFxMEZqSXhQdkptWGZHTW1nR1RvNWp3?=
 =?utf-8?B?WkJVelBvTnJkbUNYZGV3eW9uWVZYL2FUUVVOSWhpcklaM2xaek5Oc3V3eUds?=
 =?utf-8?B?UitGeEFhTmt0YTdib3FLNzZEYWtLS0lFdjhpZkFuU2VycWM2U1gwVUhZMjNt?=
 =?utf-8?B?WnR0NTNZTVZZems0SWJuNElGZ3VsUktFY1BJVDFEM0NKTXltSzFLUTlkeXI3?=
 =?utf-8?B?TWFzUlhLQWN3cVMyRi9DS1FVMnV4dXJDdWpvbkIvWG5qbTBuYk5GamRvR1dM?=
 =?utf-8?B?WElCQS9IcFcvKzdrMXVwMDkySDB2di8rNUx5QzZmZ2FldTlXWFFpTERWL1Zr?=
 =?utf-8?B?RE5yazlERDBSbURDOUtrY2pSQjlLMXNXanZUamtYTCs3Sy9iMzFHZFNDNnVS?=
 =?utf-8?B?cU1zckZrVnVwZ0tMV1NNeDNlaWphajlaZkNmVThaK0oxaThTcll6VHlaMDdr?=
 =?utf-8?B?YVBHRENGNks1S01Fajg5bEFHVzdNVlhTSlRMYVF6Q3lwT1RUSTNmeG1vdWlu?=
 =?utf-8?B?WjV6cUxOUHF4V3d3TElQQ0tBMm9naWh4N2h4OUxoWTdpcVp1ZDZ6SmxCTmxq?=
 =?utf-8?B?U01PbG81TEJWcmNXVnJRMk1PRGhXbHNnWWZGYnZoUmVCZGR1M3BvckxCMmNz?=
 =?utf-8?B?MEtLU2MwQlVmUm51S09VL3RNeko3NzFjdGVEdXJmRW5tb3JZc3F1RlR5bG1Z?=
 =?utf-8?B?emVSYnVzR1ArYzN0blR3SVA4aTQvOWQ1TjhxaFE3bTZiMzFod056a29FaFV3?=
 =?utf-8?B?WUlOd0FzMzNQUFYrYmVoUzhEci9UcWpmNW5kWER1clFFRzhhNzl5ODlYQ0Nn?=
 =?utf-8?B?dVBQMVNoVU1tR0ZHUFdscDJ2aXBhOGszdGQydEhFNVpFeDdrMlF1UkowT1dx?=
 =?utf-8?B?dE9yNmpUR1hRN0VWVXNja1hTQUtBUjl2WlpBUVR0Q3RtZWhBU3FRZVNLaWx4?=
 =?utf-8?B?RzdFR0JCSWVuM2RVUy80TFZURG96dzlObXMxN1FIRmNUVDhlRktNVlAzOTZ3?=
 =?utf-8?B?d2FPTS9MQ3Bsc3BHRDhaZFJHVzUwSDVLNWRQdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1BMaWpQU2xuUmExaFM4RmZtNUlqWjk1L2J4VE4rMjIvUVdzWUxWeEg2eURR?=
 =?utf-8?B?aXFydldRVytGSDVlM1poaUZhYnYrMTAyNVN6WFBFU2lxRFZOK3doR0pjRjJq?=
 =?utf-8?B?YitBb0w5aVR3czM5Q0QzSCthREYxZVYvdldwQ0toRFJzZHZYWlg1aGdvMTZ5?=
 =?utf-8?B?Sk4vYU9mSUc3b3VieFNRdnYzMnVmVTlhWXZ0VmNXaERyaEJGZ0dpc1kxWGJV?=
 =?utf-8?B?alozMzB4Q1ROYTlPNm1QcXU5eWljSXNESmgwQ0hXNDY3d1ZnM0hSWkNXQ3la?=
 =?utf-8?B?SnJ1SzhOWmpTYVZwWkFaRUlreUxqYUVWREpJa2htVCttaFpOR1EwYVpzbEY2?=
 =?utf-8?B?dEd0NzBFUU5peU93SG5MK0pHZStZOUozOEVaNGFFUFdKZDhTcnExejU1OEdj?=
 =?utf-8?B?K2Y1bjNWV2gxRGk5VmJLREUyakxFK0cwS2ZaZkxDZERkUmdtczRyMGhSUzhR?=
 =?utf-8?B?T0piNFVERmMvVjY2djhnUUJTWFAvSGl4YzVZZjJnTTdvdWRVbHlXZjFRQ04v?=
 =?utf-8?B?ejNTam1vc3hBME52NDN4SjQrWndGdS9RWEpzdUhBRk1DUW54NGlPdjh2a3k0?=
 =?utf-8?B?bW0vS0hIUG5aYzh4VW1RSkpRTitHV0FkemQyMzhuc2o4YUl6eW9iS1RpdEsx?=
 =?utf-8?B?N0JDcm51WFR0VzgxYmN0TFFkQlpZZGdTODVyRWthcmMzc2pyT0pXdm8wQnRB?=
 =?utf-8?B?Sk5VMGJjNXZhVTBVMVA2UGQvaG1qYU9rK2hMcHozNWxXWG4vR21KY2dHSUtw?=
 =?utf-8?B?OC82VTBrSlNRR3lRaHBNdnZtUGpNajVsRGY1L21mUVFBQ3ZrZllvaUJXQ1No?=
 =?utf-8?B?aVQ5a2RTTnF0T0U4VVNOak0vbkVYNi8zL1NWcWcrN0l2YkcvWnVyNFFENzY4?=
 =?utf-8?B?SmhjMXBURVowdEhITXhuR2xOay9MYkd2NFN2V0xGcFQ1V3VxQmoxQytkTTRm?=
 =?utf-8?B?VTQrd3orbUFjVDR6OVN6b1ZZWGtmNkU5bExRYXQ5bmVMMnI0aXVzVGo0QXN6?=
 =?utf-8?B?WS9mdS80cWdaaFdHVGwrNG40N0ZLNzZMeWk4Y1FZc2NJMG05OHVpZEZBL2JB?=
 =?utf-8?B?ckw1UTdkMUQxUVRGMCtUcmxlM0xGcW1pVTVqb3dla0l6SDA2dVFaNElOVzlz?=
 =?utf-8?B?T2ZOV09TVGZYZmpaUDYzMEpzaXNwVEtsYzYzWmNmd1RYKzRYemdsN3ZvQ3d0?=
 =?utf-8?B?K2U1NXpBY1Y5SXZxL1pMVUwzUzE2TTBiaklITlo2aHlOclBjeTVPSS83WDkz?=
 =?utf-8?B?Zk1uTWtrcmszNzNkU3I1WXl6R3M5YVczdTZJZlRDakRwWHNPNzR4TG4vaEZy?=
 =?utf-8?B?VDZlZzhGYytZRW1HaVoxYVBoVWVnbGwxNDMvckZaSloramQ3UmFpSkhweGRQ?=
 =?utf-8?B?SXloVDYyenBIQm1WT3QvbEJHOFJqQVlWKzF2aWd6M3NER3JyZEVJTVN1RlY2?=
 =?utf-8?B?U2l0U1dObDJIQXNnKzRrMlhFSVBrK2RCSTNZWHJHVFo0cHRWYVU4dVB1Skl0?=
 =?utf-8?B?ZDVnRCtMM1RxWXhkWmVvRjRpSVpxclBRTDNVdlFGSlRSY1A3aFZrWmRMUHhG?=
 =?utf-8?B?OFR4aDN5MlgyNjNaRVpXVmI1eitCOFJmL2pSVWpJNVRQSlNncWFRcGk5UG0v?=
 =?utf-8?B?RnNLQnN2TDZCNTF3Wk90eVdHZmZuVE5MZXRkUndOUllscUZ0bDZ2N2NrK3Z3?=
 =?utf-8?B?QUFseDM3MXl1ZnVDTzRDbWx4KzlWM09kVThXc0x0QjVpUlhnZzNveTM3c1lo?=
 =?utf-8?B?VURSZTVzdmlvcDlRM0dwdFVSR2JPQzZ4RnFuL29pcjh0THFLTUMza09ZcHRD?=
 =?utf-8?B?NzBkTUVsTGVNR1lDOCt4ckhuYTVHSGI0SVVaSEtvbmprcWRGRzB6TE9YckNs?=
 =?utf-8?B?d1ZiajhJWTlIQkJONUg3NVJYRzZJT0sxUDExWmlaWk1Bd1hHVGtVdzZmeTE1?=
 =?utf-8?B?R2k3cVpmMHUxaytIeXppK0l1bWFKWXluMzFSZldjd2ZCaDVyR1hrZm14N3lQ?=
 =?utf-8?B?ckJLelFtSkZza2YzaDBKVjNaM0VCUjhmYjMrc20xdmhxd04yK1lMTUZiU2JL?=
 =?utf-8?B?OVFwckFUNjQ1MzFUQWxJNjNYMzZydG9qeWhiUUdyczJtZlkwSlVySTFScDRq?=
 =?utf-8?Q?dGkgUs6Z36E/obLOQ0EsZ8UFj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7957de-b393-4985-7a51-08de1ac0e8a4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 10:08:17.4029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQRzGIPqTN2/meOj9cyk3noa6XuLDTXANwMCRYxCN88namx09Il9OGujml12BKFEakRfMrW+MeR9UdM9xaNg5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6891

This phy supports both 24MHz and 100MHz clock inputs. By default it's
using XTAL 24MHz and the 100MHz clock is a alternate reference clock.
Add supports to use alternate reference clock in case 24MHz clock
can't work well.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - add Rb tag
---
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
index b94f242420fc733cd75abef8ba1cd4f59ac18eb5..ad8a55012e42f2c15496955d00c6d5fd85c5beb2 100644
--- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
+++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
@@ -16,6 +16,7 @@
 #define PHY_CTRL0_REF_SSP_EN		BIT(2)
 #define PHY_CTRL0_FSEL_MASK		GENMASK(10, 5)
 #define PHY_CTRL0_FSEL_24M		0x2a
+#define PHY_CTRL0_FSEL_100M		0x27
 
 #define PHY_CTRL1			0x4
 #define PHY_CTRL1_RESET			BIT(0)
@@ -108,6 +109,7 @@ struct tca_blk {
 struct imx8mq_usb_phy {
 	struct phy *phy;
 	struct clk *clk;
+	struct clk *alt_clk;
 	void __iomem *base;
 	struct regulator *vbus;
 	struct tca_blk *tca;
@@ -582,7 +584,8 @@ static int imx8mp_usb_phy_init(struct phy *phy)
 	/* USB3.0 PHY signal fsel for 24M ref */
 	value = readl(imx_phy->base + PHY_CTRL0);
 	value &= ~PHY_CTRL0_FSEL_MASK;
-	value |= FIELD_PREP(PHY_CTRL0_FSEL_MASK, PHY_CTRL0_FSEL_24M);
+	value |= FIELD_PREP(PHY_CTRL0_FSEL_MASK, imx_phy->alt_clk ?
+			    PHY_CTRL0_FSEL_100M : PHY_CTRL0_FSEL_24M);
 	writel(value, imx_phy->base + PHY_CTRL0);
 
 	/* Disable alt_clk_en and use internal MPLL clocks */
@@ -626,13 +629,24 @@ static int imx8mq_phy_power_on(struct phy *phy)
 	if (ret)
 		return ret;
 
-	return clk_prepare_enable(imx_phy->clk);
+	ret = clk_prepare_enable(imx_phy->clk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(imx_phy->alt_clk);
+	if (ret) {
+		clk_disable_unprepare(imx_phy->clk);
+		return ret;
+	}
+
+	return ret;
 }
 
 static int imx8mq_phy_power_off(struct phy *phy)
 {
 	struct imx8mq_usb_phy *imx_phy = phy_get_drvdata(phy);
 
+	clk_disable_unprepare(imx_phy->alt_clk);
 	clk_disable_unprepare(imx_phy->clk);
 	regulator_disable(imx_phy->vbus);
 
@@ -681,6 +695,11 @@ static int imx8mq_usb_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(imx_phy->clk);
 	}
 
+	imx_phy->alt_clk = devm_clk_get_optional(dev, "alt");
+	if (IS_ERR(imx_phy->alt_clk))
+		return dev_err_probe(dev, PTR_ERR(imx_phy->alt_clk),
+				    "Failed to get alt clk\n");
+
 	imx_phy->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(imx_phy->base))
 		return PTR_ERR(imx_phy->base);

-- 
2.34.1


