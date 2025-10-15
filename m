Return-Path: <linux-kernel+bounces-854905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE057BDFB99
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5B43E8298
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C545338F4B;
	Wed, 15 Oct 2025 16:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fQJwp6F8"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD990338F30;
	Wed, 15 Oct 2025 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546692; cv=fail; b=DiJ5dfVJr/MlnZZ106Mz7/eMax35SLGFnY7x34jCktfI8heCvsyWq/ekvZNfhd7b38tuJ7XWush5CTFd2iyTfDHqPuAuOkw7pfXqz1iUTX+4nE2YATM2Cr3mb+VwY4+eMOPdT5nZ3404WGxaFpW74Rl/VvO1OoXW8XyW9qWQOqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546692; c=relaxed/simple;
	bh=Ox4kTpcXXfxrAeNDt839yNnEHBpdgO9iOa3pbjknOL0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DKiSfjiU3S65hIztSKr0JrI95Z6rlGjD0NE3DTw7PwfRVEwrEFpriPOQkqRumXvVq67wd0NjUIw2SZt/7cPfNR2DVq/yNs8eAtMnDMEzWrUrpRMM2RQxiK8cDoB+O6Ch8pepBlBWJwlpFT5YHzeCIBiFqT+qIwVsK645B/5zW7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fQJwp6F8; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTgr54MU2suu6a8FmIH7JTs6+b2GIXjhIOJ6LWsXG1awvyqmG1hYAY9KBOwTF2UHltZmLr8pUk/SdUPGii1EGmU0G+Ldhm9l1pA5BEXz0rvmYO3yrIVMUEpyQ3Ux/gSnvB2g5HTrDxfx2ny8thalcXvjD+OBSBFaRt9pRN6G2QhJ3f8iIgd/4ofxR3rgmlPHDyTqqxNFZSYDq1GOTZUdbajjHOfwhlW6guZtRW20b/kvbhxZOs1XoSYykCeuhHlZqNjMYD8rMezUuimvIWgPgFs6L9SFYeJIU0rRraFXkxO/vLNzmeNqvlg3/4PGJZZHLiaBZB2hrgtXg+Znp2e8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOw67SIDS2bc6pmEmHnvZKVC9X08iOO+XmH05QSw0y4=;
 b=cVMMYCuDhcwpsrIonnwUb7GSVfcl79YODaFxUXONsVczizkbBhJ2qbWZ0eylljO8dxenRfkpp8hr441WxH/qGkWoVB6pXx7GTs3gqMhkx3N3qMYl59hFSa7LYfMjkDOEQuj1/fYF4EpyH76ExHL0Vzpd/IdMyDXZ67H6FQ2jQX/1NSckhItSa3D/zipZpBr6B59DIRkkTL6Aswyr60H0ATkYq7paweO+OwBFzCIVOlllqt6hsM16Z8xZhMcNIwBewYs3E+rIDvkATysBLFsuXz0Av9JC1tzmBHAYhZTUHtv0fgzmzn9wIoc2zcG/ltvsb0H4IIl58yilZWCNSPos8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOw67SIDS2bc6pmEmHnvZKVC9X08iOO+XmH05QSw0y4=;
 b=fQJwp6F8pKIGqEmi5NUEAjjsqI0VG7sCDjh5kA7991FADI7WFtzOHPPUGu6xqD9n+L4wqkv5u2COqwS7Kvkb+cz/4z4g9uYm/l7KpNZNeL2QdGHPvZos7IFxhifuVOn6ZbhQ3nNY7xWOPywbrbW5uKnWPRMiCKaO5b5pjIbQzikyDtMjg3k6HrnFZw6z5+g3ss73rYtL2i+UVnOz0yGp+9iVDTSRl9szyLsR+wwuShNwRuqA0DfYX1EcUD1dPLoVme7L2DSTyWGLymmzlRgZvZsfVay7Nzi8BhafNMfguLFK0oqYkX4FVnXzmbq8gX8jinCEnbk0pDfaMHDmTP1Deg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 16:44:47 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 16:44:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 15 Oct 2025 12:44:26 -0400
Subject: [PATCH v2 01/11] ARM: dts: imx6: rename stmpgpio to gpio
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-imx6_dts_cleanup-v2-1-41a7281b98c6@nxp.com>
References: <20251015-imx6_dts_cleanup-v2-0-41a7281b98c6@nxp.com>
In-Reply-To: <20251015-imx6_dts_cleanup-v2-0-41a7281b98c6@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760546680; l=3867;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Ox4kTpcXXfxrAeNDt839yNnEHBpdgO9iOa3pbjknOL0=;
 b=tRTjDkXyQkvfElC0Ylon05sctK9zCssUh7EG8/BiyVAz9tnaiPGmBfcwwznfZ6jEFFnCXAW1b
 zZq92ddmcUKDIKTZoCIg8YYeeQWZVLFq1GXyTJzOHWJYTzS+Dz736MH
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0113.namprd05.prod.outlook.com
 (2603:10b6:a03:334::28) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA4PR04MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: bde9b09b-893e-49a3-674a-08de0c0a2681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|19092799006|38350700014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUJLdnVYWGFWaGlMQ3hWV29tZlBuc3NWWEhXK3J5YnZJTWFSOFl6V2wvb2tz?=
 =?utf-8?B?QzN0STBhSTk5aVZpZ09XcEIrSWtvc0hzR1ozZndlai9hTnd1dmNyQldCSzVB?=
 =?utf-8?B?Rzc5VUxBOW5hdWtORGZZcjFQcmFBOFpkb3F6UVRFRnd2bk1PeGd3dy9wbXMv?=
 =?utf-8?B?d1VNSXVsYk1jRGwwcFFtUXF1bUluUXNyQTlNbGZrbHJaSHNPSjFyblErQUVo?=
 =?utf-8?B?L1BxQjEzemdNNjdpMGVYUnZDVDlhUEwrWkpGTVpxR1YxRTc5aTZXdmZoNnM5?=
 =?utf-8?B?MjVSWmFFUXNQZzVKRGhpWWE1cHcxT0NIQWVDcVNzUTFLZjR4Zkw3cDVoM0lZ?=
 =?utf-8?B?azdpUzhvL0M3aTltWlI3Vjl5emlnNi8waW9tRzdiTFVQR0RGakpMZVRpOXR3?=
 =?utf-8?B?STJIQmY1VWVTZWVjK3doc2xYUG1BMGRoYjJIRGVpbldVZ3h4QTR2L09tdnd3?=
 =?utf-8?B?ZzBLZFdxZE9TM3NOMTJGWk8weEFSMkR0SEZLUWl3MzFvbHI1MmJwZkxXeEVV?=
 =?utf-8?B?NklYQnZBWldTa2NGTHJoQlJkQ2piTEV4UG9MM3hNemQ0L0JQUG9uNkF2TVpt?=
 =?utf-8?B?eWVHT0sxYU81bXhtUE1aTnY4ZXJaNWZjc3RqdTVPbUZpZ0R2VzBBeTk0U1Z1?=
 =?utf-8?B?Q1cycTZMTWFQZTh6OGJ4bTEzRE1sN004SEdzWWRKQldPT0RQUnJLLzZ4Zkc4?=
 =?utf-8?B?c1NHYlFCRWJUb0VDQXhqSHNYQ2U4NFNEaSs4TUw2ZVV1N1FndWpOYjg2ZDFX?=
 =?utf-8?B?akhKZ3orZjNwOUZ1K3ZqRktVMlUyS28xY0RhZjd5Smhsem0wdkhrayt6MHg3?=
 =?utf-8?B?K0IwTy9TckU2WFpGQnNWcldwUHlnaVRsK05DL0NxeFRUMHNxOW8yR3FnblA1?=
 =?utf-8?B?Q2E2UHNBRjlBNCtoUlJSK3VJQzJ2Q3pGczcvcVVZRHp6MkN3R3RiR2VVbnBm?=
 =?utf-8?B?dE1uT1cwWGRvWTF2M20ybTg0bFhrUllzcjNKVGk4Rm43SXhVbWVhYTZFNTRm?=
 =?utf-8?B?MmtWVmJmMUQzYmJEYWxLMllUZHhUOEVaVGVFWEppOU1USDd0OXZia092SXUv?=
 =?utf-8?B?Q3ovWUhDYW5ESW53alVkUUlTZmdoWkVwa2FLV285NW94akpka3pmVUJJTEQ3?=
 =?utf-8?B?blFrMjYzY1JOYXhuMzJ3R2RWYVlzZktGSkZXNkFWamtQbUhoM28rcDQwRkRL?=
 =?utf-8?B?YWMyR0RNbmJyblhLakI3OHhCa1A1R21ka0REeW44SS9KMW4vZE1zTXhPQ2VR?=
 =?utf-8?B?elpUbk00VVJtOW5TNXhLV0lPMXIwZ2lwMTBRZHNURStVdjh5Mzl0U2xieWll?=
 =?utf-8?B?UVdoY0ZNbyt2R0FPOXlFYlRtdFBTZG9vdFNkUzlzQkZwZEFNYUdoSHc3bHVO?=
 =?utf-8?B?RC9IaTlvNTRVdlpIVFJFZExDcWFKNmF6L0lBdEFWc0Y2VTdUa21XUHdvNGVo?=
 =?utf-8?B?dERoQ1F0aXBFUzgyZWZ4UCtzZmtQMHZYR0R1bUNJaGxDN2tJNFJ2VEs5cVBj?=
 =?utf-8?B?aFRXR3ZDN3pEZFczUnRjSDRKTlVzbnNnVnpRRFNmUUk4Z2JmSm14UG1yVzdV?=
 =?utf-8?B?K1JXN1J1NEUyWXRCY3NYVjZ2NjhMNFJKYWphVlVReXplWnpKUm5Vc09ZSW1V?=
 =?utf-8?B?UERndUpSKzkrR0VYdEZRMUNRR1NDWm85UDVZdzREaU4wSWZibkI0ZXJrVkdM?=
 =?utf-8?B?RXZOcSs2N3Foelk3dXZsV3BmYzR5L3NMQ2dUNUZPNExCYmVBczVoUU9uUFN4?=
 =?utf-8?B?d1lRcWx6YnVTcXdZYzFrWXV1Y2toY0pTZzdqZWR0NVV2ZHZsSXB5UHgzdVRT?=
 =?utf-8?B?OTB1S3BNU3V2ejZ2ZjJNNWpvZ1k5K09xdHVTT2x5Z1ZNS2krTnoveVhwMGJp?=
 =?utf-8?B?MnFDeW5pQkJzZzZ1bzFLRnQ3KzNaNVM3eXF4d2Zmc1dYSEU2NnYxSzA5WFpo?=
 =?utf-8?B?VnpRNEU1NmZnQVBrbnE2VEt4cTlaN3Irai9oZ0FtZHVWZUlCY2dKbnlrUFJh?=
 =?utf-8?B?Q3RRYWkwWW1BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(19092799006)(38350700014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFhDenJFdXl2UmJXZHI1MnF1SllLaTJDSTV6c3cwelZjb0U5ZU1MS3l2WENv?=
 =?utf-8?B?aDF5UEZYbldUeUYweEdzbStVYlhUNWYvbU9tYmFZY1A5WHpGQjB5UlpRS3Jj?=
 =?utf-8?B?bUxZTjh0WjlPTzFoUm80T09BZEdWSTNrRm9oUVpHY2xjTFJ4ZHBoTUNMNDhO?=
 =?utf-8?B?Ymo1alZFZ1BEZXgvdnR6eDRCOG9oVTF6WDZpMkZhbHg5cjl0RDlobjE4VGE5?=
 =?utf-8?B?ZkFTVWJTWEZJd1A4Z0hmQmkvSkxUbE1VYXZVL1dCMGdWcFl2TDViM00rZmRP?=
 =?utf-8?B?SkgrQjE2dUR1a2JxbTlJWnlWYmxSOSttdkliem9CblJZL2wweENZSUpncldu?=
 =?utf-8?B?QXkzcFdXWTlyeWdFVHB1clNmR2w4cFU2N1RLSk1JelRQVTVBa0F4aHBmbDhG?=
 =?utf-8?B?VGQ5emppclJUQm5nREVueDByUG9wUk5XYmZHeklHY1BzQmpXTWN0TWZLQld4?=
 =?utf-8?B?dEgvZ2xScmUzY2xTc29aZHpFMFVNcDdzUXl3OTRla2ZmMmxtK0IzUDJDeGd0?=
 =?utf-8?B?M2M1ZEZKZXBpSXJhVHo2L2NxZXBaNkt6cE5EaU51WjY5NmVrb1Mrb2htRjZD?=
 =?utf-8?B?NHc1Q2ZpU2tkV3Q5dGpiZC9MbTR1MTlucTV2KzRhZkwvOWM1ZkFrbnFRSk5p?=
 =?utf-8?B?ZVQ4dFdLaG1STWtEUzc4enFoam40blBhU2xMS3JHY25XUjZSbExGMGQ1NVFM?=
 =?utf-8?B?eG45K2lRVDY2Wkcwb3ZTRTVJTC9sUDE2ak03YXBsbFpGNWVtT0dqcktGWTRH?=
 =?utf-8?B?Wkt5TWQxVUYzS0NRNHU0cUMzSUN2c1dzSUxGYk9GQTBsZGZDWDB1K1lwdmQ2?=
 =?utf-8?B?aHIvazI2OTBTYnk3aFkyVG9FMytEenU2WjBXTSs3Tk9RNmY0cDhWUS9kZ2xE?=
 =?utf-8?B?RUdZUXJqMjRhNzJGVCtoUUozbTF0MDNsZjZONGh4MXZvOXpwQjdLN1ZxZnhn?=
 =?utf-8?B?Y1BrRndqMlo5VUhQa0NzRkJlaXozM1IzcjBuSVU3MW5Bb2VTNG1kWmxQLyto?=
 =?utf-8?B?Q1I1NGtYdmxDSkI2SDJoa3NVV1E1ZGozWVNVWVU0YU02bkQrQmFBc0d3YzI1?=
 =?utf-8?B?T0pvcjc3dzVOMGRhdjBoNnUrTlhNb09OSGw2em9Pd0JRc1YzbWJITHlZL1h6?=
 =?utf-8?B?dmwvVkI2R0ljaFQ0NGRiV1Mwd0prVCtLUk9NbTV4aTVubUlCbGhSc2FicEpS?=
 =?utf-8?B?R1FlQ1c2ZVd3dDlEc1RXTkI1SUpyOXVKenFhakt0UmRxaUNTejA2ck82SW9M?=
 =?utf-8?B?VVl4b3lqaDB5M293d2VpSk1EZEJ4WnR0a2JUaDJ0ZmtiM0lOOW1RdjdkTjk3?=
 =?utf-8?B?Sm5aOFo0RktZNHBqdDNqR1FhVTVuT213cEhINHR0SUpWendQd2xhZ2dnRmNK?=
 =?utf-8?B?SnJLV1lVYTRZbVJkMFlHWUdSbnI1T00zWGorckxmMjFva2VOZ1RZVGxwUnp2?=
 =?utf-8?B?enJLVDJSc2hVeWc1M0hBVUhURDQ5c2hkb3B0YkNFb25mRnRENi9xRnA2Mmkw?=
 =?utf-8?B?eWJYbHVPMnhNTVVLUlFkV2JEVmxkMTNIeVA4ODA2MGsyZFNrRUltQVVFUnRn?=
 =?utf-8?B?OGkyOEVIaXNad2EwUDdVMlRJK3d2NHZHdC9oUFpHeVlvQ1hIT0VaMzJTYlRI?=
 =?utf-8?B?MXYyMmtvSGp6bW9ERGFiMzdzR1MxR1I4OWVRb0NMazg1b2txZkdLLzBtK28x?=
 =?utf-8?B?QTVOWm5Nbkc1RkFpUjJPSk5Lb3NpTWNKVzJaMHcydHJaR1NjdzVmaWRxOTBH?=
 =?utf-8?B?SUlnVVNlYWZ1YldmWHo5eGk2Rmd0YUZ1UWNndHFSQmI2UGIwQVgwWUgvRUNi?=
 =?utf-8?B?KzgvNTFoampiTHlvNkdLN2hvWVRqY0lYSFRHSVZwMi8vcHpLUkYza3FmUTZw?=
 =?utf-8?B?Vi9XbkFWVjBHUmVhellXc1gvZzNnRXVzRVNqdk1UeVlwamZ6SEgrbUZJemFq?=
 =?utf-8?B?ZGkzaXlpNndLM2J2WVJPOUtVTGJlNW1lOWxoeVFCVkVMUG5iM1I2TXluNkpx?=
 =?utf-8?B?K3U3MmgzMHkrVlcza0FMa3BlUDk3T3dDM0lEZ3ZWNkh2WG5MaVBkZkxWc1ZF?=
 =?utf-8?B?V0NjWlR5VG5iT3JwekpBeTZ3ODFKQWRrWTlGTCtVOTZIaytuQmVnUFpkbnlS?=
 =?utf-8?Q?6Vq2utzo14IhDYvnwwHLp1+H/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde9b09b-893e-49a3-674a-08de0c0a2681
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 16:44:47.0691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRmFQTMvsBJ922TYFWLkS3Cq+d9/kVfh9VSjk+slKGBlsf7JthSg3ghSWNsLFGMDkb0maahOYkJ4RMoiFEJnlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248

Rename stmpgpio to gpio and add gpio-controller and interrupt-controller.
Rename stmpe_adc to adc. Move interrupt-controller and gpio-controller
under gpio node.

to fix below CHECK_DTBS warnings:

/home/lizhi/source/linux-upstream-pci/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dtb: stmpe1601@40 (st,stmpe1601): gpio: 'interrupt-controller' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/st,stmpe.yaml#
/home/lizhi/source/linux-upstream-pci/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dtb: gpio (st,stmpe-gpio): 'interrupt-controller' is a required property
	from schema $id: http://devicetree.org/schemas/gpio/st,stmpe-gpio.yaml#
/home/lizhi/source/linux-upstream-pci/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dtb: stmpe1601@44 (st,stmpe1601): gpio: 'interrupt-controller' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/st,stmpe.yaml#
/home/lizhi/source/linux-upstream-pci/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dtb: gpio (st,stmpe-gpio): 'interrupt-controller' is a required property
	from schema $id: http://devicetree.org/schemas/gpio/st,stmpe-gpio.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts | 10 ++++++++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi  |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi     | 12 +++++++++---
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts
index 17fabff80e903f621814492a8f8b837c5721adbe..cbe580dec182e1428d39477fa800a6e5ae1fe20c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts
@@ -236,9 +236,12 @@ stmpe1: stmpe1601@40 {
 		vcc-supply = <&sw2_reg>;
 		vio-supply = <&sw2_reg>;
 
-		stmpe_gpio1: stmpe_gpio {
+		stmpe_gpio1: gpio {
 			#gpio-cells = <2>;
 			compatible = "st,stmpe-gpio";
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
 		};
 	};
 
@@ -250,9 +253,12 @@ stmpe2: stmpe1601@44 {
 		vcc-supply = <&sw2_reg>;
 		vio-supply = <&sw2_reg>;
 
-		stmpe_gpio2: stmpe_gpio {
+		stmpe_gpio2: gpio {
 			#gpio-cells = <2>;
 			compatible = "st,stmpe-gpio";
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
index 419d85b5a66061d4389df5d42de626183c27a9e6..8a0ce250e57607ef157fe34859cf77f45f54935b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
@@ -589,7 +589,7 @@ stmpe_ts: touchscreen {
 			st,touch-det-delay = <5>;
 		};
 
-		stmpe_adc: stmpe_adc {
+		stmpe_adc: adc {
 			compatible = "st,stmpe-adc";
 			/* forbid to use ADC channels 3-0 (touch) */
 			st,norequest-mask = <0x0F>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi
index 4c09bb31269662adeb0b06991f45765935bef01e..e34c8cbe36aec682f46ffa128247bc47f3a6cab9 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi
@@ -122,15 +122,21 @@ sgtl5000: codec@a {
 		VDDD-supply = <&reg_1p8v>;
 	};
 
-	stmpe811: gpio-expander@44 {
+	gpio-expander@44 {
 		compatible = "st,stmpe811";
 		reg = <0x44>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_stmpe>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
+
+		gpio {
+			compatible = "st,stmpe-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 
 		stmpe: touchscreen {
 			compatible = "st,stmpe-ts";

-- 
2.34.1


