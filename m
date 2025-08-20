Return-Path: <linux-kernel+bounces-778201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B19B2E28E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB3E7A03AB0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29703335BAB;
	Wed, 20 Aug 2025 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S87M4rNN"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013013.outbound.protection.outlook.com [52.101.72.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E12334387;
	Wed, 20 Aug 2025 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755707852; cv=fail; b=bNc0KaFZiFB9ujPpp96Z0cub9mDGd9hOGxEnK18CLXUJmo1pI2tr7t+GWX2jEpiK0T31uf5IViq7shGJb85N8tc6bu9iTnO5QkrUzjieRSWA7xiSJnvUrkwtucQGFKzQa1R5tyfLh/8QXZO+DUSFFsDUDsyIDrn9aZQCj4I4W7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755707852; c=relaxed/simple;
	bh=0IcAOrktPPuKjxAb7R/3LYoGF/PDnjXrrpSaiSFpv14=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Ul9hEB5noKOnZbrlpHblsMTYJNyqcs7qTwT6oiSotyhwmwI1RtrOemOWy9c2bjcZN95C3Nz6eQ5/1PYYMeMzn8mauXDVbQr/OYcvKN5bqo1+csVfcWKt0ArpOg/RpCeLt1h6uLWOmM7up7SeXJCRASuFblwgJvrQt+QYGI4qo1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S87M4rNN; arc=fail smtp.client-ip=52.101.72.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6/hGN/VHx1vofJ34/D+OIcNLircX/htfh12fyqWohzaQOo9vu8xUvOO6DCou8uYbo/gPq9XlbQd7zUkOvcmVe9gpmt+HTRQVbUTZWHxdBWZKZ7oZO/i++4IcAu8ivgkm/WjSTxggJVy4bQa+h7yh7miFjwK9s0LMEyX2hQXufaTeR3WaH8b34d5uH++qmFSJLpxZdITC8Ne2Jbfp3oob7WyagC4qQnUgFSa8bv0P8SSYa9aBBssDOhy23cZXNIwbtyI+cLiwCUluyFHlHUvlxHbJzpSDnwtakYYUJi7RvvgT4gWewMS5ZW/w/CMN0oZat9lkuSljGC15xuEjHr/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juGmYZjkOdqTWC0bSozMHSr/m5t0+gYiYmMbEe09hZw=;
 b=mxl9yKUcWL1jnmOCiREoAufN/uXBv0TNJQRTh6rYMk4FG/0a54kRKAqW/lhy0agyMb+xNih6ze7XhLk0ClnULiVujhDC4asAJ5s/TaVaP0h09WfpGEhTkjgKqahK7333UWaRkxQD0ucLcEA/Fvp4yScbTt+Qm0Wcm2cTZCuFbLcmuETnRpSlIh3kklRGwozmr1bQoH6F3aXv/NQKh55SkUJ4gjCpno+aNhHooTpjjXxVtfXweTLI+lADVkY1eMZLyvd6znbMRC2/pIjpKFm5oA936HTwjIfd2pmTRIy66k9iG1XVLvOtJC0YEdRgUmrsfBq6m0IE5BK63anWex04tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juGmYZjkOdqTWC0bSozMHSr/m5t0+gYiYmMbEe09hZw=;
 b=S87M4rNN7KjpfSNhccLC/4L6VUf3W7W7Ag3lRdmKzgTpumsk3mi6thI0Eg/DbvZBWTjNLE2sUpIDgRgc05FWhc0DGDM6KxC75gyZpEer9oM8H7F3wze3QDGDlztITnFNTYjzZNiuYhjrz+gWwbibvIw8A4pKmS2LT3UOzWNksqQ1YowZ6d0yTkLla0nqUVHPZfj/VNTysrMsVNMmzzk9rxfX7wBPafITEbPmhQ2reHrF3Uc2fFLHoIyZBQ3ZtKvh/6oNDciA0jDZPwNRa5cIbOZqoh0hWYUBthIRtVAO154CZMQlnwLqAVk9D+/cFDyJWCZ6DccsBeV7tmpmIfYhvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU4PR04MB10338.eurprd04.prod.outlook.com (2603:10a6:10:565::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:37:23 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 16:37:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 20 Aug 2025 12:36:54 -0400
Subject: [PATCH v2 4/7] ARM: dts: ls1021a: Rename node name power-controler
 to wakeup-controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-ls1021a_dts_warning-v2-4-2e39648a32b7@nxp.com>
References: <20250820-ls1021a_dts_warning-v2-0-2e39648a32b7@nxp.com>
In-Reply-To: <20250820-ls1021a_dts_warning-v2-0-2e39648a32b7@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755707830; l=1274;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0IcAOrktPPuKjxAb7R/3LYoGF/PDnjXrrpSaiSFpv14=;
 b=jh9J3O+cG5rrRhtZe3ETT7JKW+p6k7gclWAq664RRLHm6E5VgHVKhn782YkQtKSS+Zkbzlg7C
 19IPnJwlWwlBZsPmZXc47G1ijmt8Vyy9VBDcF8GJ5UNH1CNwJdSons4
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
X-MS-Office365-Filtering-Correlation-Id: 2ef48f0d-3022-414b-8611-08dde007d729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnVGamM4MGVXaVFPWFVVTU1EeVRBUlFuZ1k5bkF2RzA0eWhYUlJMdU53d3E1?=
 =?utf-8?B?dysvdlp0MHBRWVVGMHByeUJ6dE15Rmh2MGFwdk9MMFllVU9UenhySTNyR2V5?=
 =?utf-8?B?ZFBwUHVQVWhWVTcxbHFaWWZWMmV0TUsyRDQ2M2lTTFVIV1JsYzNnWUN5NlFp?=
 =?utf-8?B?Ly9kd0FzVFJyV081NFBYUkRxYlVmRndteWIrQTE5R3RNQUVQMHYrUVJTbERs?=
 =?utf-8?B?bVhOcmh2WTY4ZnJaT3RTa3JiaktkWlhpK3VYOVM2TnVzdXNWcmVIWTlNNnQ3?=
 =?utf-8?B?Tzg4L0RNMEd2Tm5NbWZGL1pyZ2hLcE8zN1lvOE5CVmM0OUc4MGYvaTdzcUFp?=
 =?utf-8?B?MS9DWXpheCtlNHlod0loNllVNnVTZnZyWVVPclJNOVEvbHlXZDRoUmRlUlc0?=
 =?utf-8?B?N3krQUQxZGJmRlVDL0VDbFdkUUlNbVNzN1NRek0vY3oxbEZMWWdJSFlGQnJL?=
 =?utf-8?B?Wkw1ajJPTzg4S3dPNWE4N1o4dUJHSDM3OXZsWlNPTFVmUUJnc0NDTTI3a1Vx?=
 =?utf-8?B?anFvMlgwNFdQTFpYdXNpUEwyRDlTZWdOekpCTDNjQzUrVitBWlNzOVh3a1h3?=
 =?utf-8?B?SGxRVjVDTVpLQ0pSV3hyY2RBSFQxQWZ1RGN5ci8rWkZiTGpwc1pNckJyUnZU?=
 =?utf-8?B?M3hROXptQUtnQXFlTTdvb0tOMDlDNEZEaWk3bDdManNFYlV4THVScmZiV2ts?=
 =?utf-8?B?NmJFRFRBclBGNFNWcCs3N2p1dHFGY1dtS2k3TDJlRUVZOEU3eHd1NzhYclhQ?=
 =?utf-8?B?TW1haG5CNGp4RFcrQ0ZwejMybmttWjJ1Qm1TMW8wTlhxUFFNTDhRelZkOEcw?=
 =?utf-8?B?eVUvL0tWWSt1bXBSb2ZKNzlUdWI4ZTN1dHpwOTFnTEhqS1ZwTDlBQ1BUZGpW?=
 =?utf-8?B?dWgxNlB2ZFFnYkQ4eFd4UFViY0hMLzY1b1QzN1dRbFM1dWxIZXBLaWwwcXgv?=
 =?utf-8?B?QWlTanRzZWt0Unp5YUtpM3FTMzV2M1lSN3MzVmFZa1ZmWm8wMk1YblhQNXhK?=
 =?utf-8?B?bGplWFFrTjdDSTFYcDY5SWpmNWZ1cWU5dUR0cnlOdTc4L1NXOHg3TkYweTE4?=
 =?utf-8?B?RXEza3ZpS0FiRkR3QXRXTTFuYU9lcWZWQVZIUGltUzRITy9ubHVISzV5alIx?=
 =?utf-8?B?K2dGL0pWaXlFUEM2YWpZT1gxZGdHZzZ3T0o0Q1RDNUZCcmFxeXJVUzNSYUNZ?=
 =?utf-8?B?ZWIvTjRqQkU0Q2tFYlBnL0krTFZuOXpGT3o4Z0RwUVJSblM5aHU2akdGUFA4?=
 =?utf-8?B?bVZUOGxNdS83VFQzdFF5bC9sOGh3VlU2T0pybmp2SU1WeHNyQjZ3V0V6U1Fw?=
 =?utf-8?B?aXQ5VXYzeWwyY1ViS3IvZGN5MWpMeCtsaEF2S1cwRitnWVcwSGVHRi8yZXg4?=
 =?utf-8?B?NE1nbVBKTFpHVS9WTFZLRXJXeStDWERIU2JnUk1vVStpSWNiSlk1TGR1SW9s?=
 =?utf-8?B?MStLa1huUitrNkU4WmYwVnBGT052VmQ3Wk13alU0SUR4YzVtbGpwZlZ6M2Fh?=
 =?utf-8?B?dkdOSUhFK01rRzVybjZrbWRya2o0MXBVdCt3SUU4Qm15UTAvQ25Jb3J1LzN1?=
 =?utf-8?B?N2VVSE5uclhrRWlvYWVvZ25QMVdDalZWZW9mT1VDdnV3NEFielErM0UrTEhj?=
 =?utf-8?B?UFhmd3I5Uk1xR3JQMnluVjQ0MkZkN2ltdlR0THFKZFNsTE96K0ppS0pPZFpv?=
 =?utf-8?B?dWJ5SlpBR0tGMUdibkNtNHBxUmwxSTF0Y0JGYmhsbUZrS1ROZUwzbWhoV0lM?=
 =?utf-8?B?TDZWb0hqdTkvSjUwbDI3ampkaUJ4T2FnMHA5U1JLVGliOHRxK3Z2SmlYTkdy?=
 =?utf-8?B?TWVOdlA2MHJjZlhIQzdUTGZSekdjaHpEZXFyRWdzT29JRldGRDJvd3pwQ3hn?=
 =?utf-8?B?bDNrdGZvVWlnMUl3Mi9VNmFYK1c0c0FuVWYwV3kyam9FMHBCWmd5Q1h0b2FF?=
 =?utf-8?Q?drcAtYO3ZUw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmJnUlV6M3Z3UFZYUk5PenJZMGZqVEtRTGFua0JLbFpsemgzeDVQMnhLRkZr?=
 =?utf-8?B?WWhOYzkxTldrODhSV2phR2k0S09IN2dqek5xVENRbWErOTQzend2UnIxVUt4?=
 =?utf-8?B?VGtXL1NSZ08zTUNNVnFFTUl6V1o4dXdOdEZxcVhTc2ZZa1JoN3FVZXBoc3lk?=
 =?utf-8?B?djFsZlBUK1dzUjA5THFoUFVtM2UvSko4RzUzU09mT0ZoUm9lamorUWYxVzlu?=
 =?utf-8?B?Mm9KdFpaVlNiSklmWVUxSEc0Wk04dEs4Ynh0Qjl4NDdIdC95eUtHTUdSbHhO?=
 =?utf-8?B?cWVQdVU2ckxST09xWldSdXVXazM2YlVsS2RUZE83aVZqM0o0TEZ3SXN6a2di?=
 =?utf-8?B?R2VWWVMybkJGVnRxVjlORkNwcy9QOHo5V0J1MzVzaGppWml6a0x0T2gremhs?=
 =?utf-8?B?bEdwVDM5ZGVYczNjblRCc2dnaGo3TlRrWndzbUhITXNweDJkTkdWdlNyNDFV?=
 =?utf-8?B?VTRVNk5iVnZ5QTFCSGcwTHM1VDZYcnJTY3RTMjNpUUN1TXczRTJuTStyczNa?=
 =?utf-8?B?ekcvK1hQTzNSaGNpVkdkb1YzRW5hMFhweUY1VmY3TU9rdDZyMU5DUlUvb3Z6?=
 =?utf-8?B?OXdkNWNIZGhPa3o1em95WHhQNTRDWGVqUnZoenFTRTk5UisyWlRkOWw1SitL?=
 =?utf-8?B?UlE0azFEZ3NYSWNodUJTL045VStvbldYZGVOaXptdGY5YUFLNkk0dkZ0ZHl1?=
 =?utf-8?B?dis2eFB5MnZuWWllN0hhU1RPTjFQRWMyQUtuWXoxTXVhcmJqbDFuOEdHWjNO?=
 =?utf-8?B?SndrVEV6bjdCZk85YWZoVFQzb1V3aGc0SGpiVUFmUW5GVDdlN3dTVk9oWVBa?=
 =?utf-8?B?WjJNZ09kY1JzREFoLzU5VmlBTStwRjlqY2g5a2JsWHZEM0s4eUlJanRPZ0tn?=
 =?utf-8?B?bFNHSUFHZDgrTDVLalFtaUllNi94eXBmbjN5cVhjMkw3WFFaclcxVzVpRVRV?=
 =?utf-8?B?TDVsSFZmNWZ6eVFjdlZaNUMzQUxZdmtoUWZLTGJ0VU1tMDlFQ3dCekpmNGc2?=
 =?utf-8?B?Rmh2TWdkS1phTy9RcWFnRWU1QWRDWEk4VEsyQk9jYjFhaTZMVGxOdEhqNkJt?=
 =?utf-8?B?UHYvZTM4cWVEZStvVlRCakFlNXJXZmJuVE80VGRrRWhtTXhoWDNsWTJXMkRP?=
 =?utf-8?B?QmRYQXcvN20vM2t4R0JCQStoVnhFcHZnTHhNazlxNzE0bysyM3g3SXFWTUph?=
 =?utf-8?B?VjlwL3AvYStqbDlsa01rbXpNNm1JQitEOTRsQncxRzdqNUZWWDB3ZFpVTHdj?=
 =?utf-8?B?Z3ZqdXdnYVpOSjZydFF1U0lEbjlBejRTNk1JbnlNM1BBNTZPRzNzeVFQTm5Q?=
 =?utf-8?B?N2oyMFBBV3VxLzMvcFZrZGZWN0tkdHpCK2hxdC95UTFaajVZcEtFbS9rYVFJ?=
 =?utf-8?B?TmY1emtrTUJIRVFBTWVIUDEweWFXNXVZeWxGMnVkQXJmajRMYkJTaVhmU0t5?=
 =?utf-8?B?a1lFQW44bGdjN2FJWGV4a3NEUmZlb1BNUGpMQ3VDK3VjRVJXTTMzQUV4L21S?=
 =?utf-8?B?M1ZBTC9ZOEc1QjVFQ3I5R2ppR1hUVnJCQmUySDlNZVJKNU10Y1VsUE5CL29D?=
 =?utf-8?B?MitXVlphRW15eVlkYWRSMXFGc3NVZDJQVzVLenJuV2RBa2RXNm5xRUVTa3Jp?=
 =?utf-8?B?MUd3VVlHaXpvVUp5Z2FkZ2dHMGFaWmhid0VVeXhLc28rOVZxM1ZMVWkyS3Vs?=
 =?utf-8?B?ZG9nQmZOQk80cndNTU03YlE5ano4anZTcjl2QTYxSyt5NGY3Z05LR2R6OE1t?=
 =?utf-8?B?VXdwendkTTNBeWwvODM5SThmS0xzNDgvRmUyTEpTVHNqRFI2NWk0Z0RSUlJG?=
 =?utf-8?B?ekVQUE14d2hRUEllSkFjckowbGVvdUZ2VStjSklwTU1SZkVvNEp5MmRIbGhq?=
 =?utf-8?B?b2FSc3hYN0QzRnZnS3IrQzNKQ1ozL2RuOUdoVGp3OEtYczdjWFRERVZ3QTc3?=
 =?utf-8?B?TDZwNVlRczNQdmFheDdkWDl0U1JXTS96QXFUekNRcXFRQVJWTjhLSXBwVGZs?=
 =?utf-8?B?OStiODhZOFUyRnY4MklXcFZtRks5U0lvTHJmcHBjQjdpZ0huZ1pmVFdCdHQv?=
 =?utf-8?B?RTJlL1RLOFp2eFZyOXFjcEpDZEgrbXBlMW1sRW0wRE9kSXRjNjJZMXhnc041?=
 =?utf-8?Q?RyMtLHw3fofBUMVQZX5BjbffI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef48f0d-3022-414b-8611-08dde007d729
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:37:23.7065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfdQW5axTUpJG401KUFz4msqt74PZfDa+ndolD0vFMKYCzGSudLUVBRMy092d2Nj6myQE6iZvIxlpC8zpcxHyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10338

Rename node name power-controler to wakeup-controller because it is not
power controller and enable/disable a wakeup source.

Add remove #power-domain-cells.

Fix below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtb: power-controller@1ee2140 (fsl,ls1021a-rcpm): '#power-domain-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/soc/fsl/fsl,rcpm.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index 6cce734b7ba336d2a4e4a1631333cd4232814d0f..c3aab7694074d714671ac6c827c87a8491c75585 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -937,11 +937,10 @@ qdma: dma-controller@8390000 {
 			big-endian;
 		};
 
-		rcpm: power-controller@1ee2140 {
+		rcpm: wakeup-controller@1ee2140 {
 			compatible = "fsl,ls1021a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1ee2140 0x0 0x8>;
 			#fsl,rcpm-wakeup-cells = <2>;
-			#power-domain-cells = <0>;
 		};
 
 		ftm_alarm0: timer0@29d0000 {

-- 
2.34.1


