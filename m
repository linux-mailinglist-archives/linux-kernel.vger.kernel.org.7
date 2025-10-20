Return-Path: <linux-kernel+bounces-860656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE9BBF0A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8A21882482
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C573C2F83C2;
	Mon, 20 Oct 2025 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lrWIB/oq"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013058.outbound.protection.outlook.com [52.101.83.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AB223AB9D;
	Mon, 20 Oct 2025 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760956912; cv=fail; b=lqVI8dlErI5EJimKTxgcwZvd3xn+afn5lHyEK4juNJLujOsUwBh+o2N4OeedtfLBNm94XprZEuAAr0iNf8V9tHznTJiEKCNSpG8D/Ir0dS3epAxsoq0BBXZgxpy+ynT3jHf8Wd0mr7NcXlhD2M9lBfm8hYb6rusdunsN/L38pCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760956912; c=relaxed/simple;
	bh=O5j8krmAsanZ8R32wVEQDx21/M1xwNLde6ZDoNFYt3Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hzVaGlFxu8jEENhHTBrNor0RSjwmru51K3H2amUtVfuZPT8tB5huc/EPiuNV97UL2HRIj2qrpD6PEjIe1oBkrcyvTT2AhpBTbX0UoLza7H43mf/7eApMBsJpRd7YtZIGuqI3noc/LTYNa4FAgsjyGtAsJto8WhZAFdcTTTFTTaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lrWIB/oq; arc=fail smtp.client-ip=52.101.83.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2nRkmNkbWMPc2lH7mr0Q0mzmMu0LGTvcKQwArIKBCrjTjcUT2gLkjFzPA5NYAkGyNt1xuDqE2rbhTl3JV2ukwV4nlqhiwbSybq+Of7eChhvlXmdvWmFT2RZgXfgFdqlrbROBlfCETBH7+yLF7kUoMVCdnj1+2JVswV3IWLSYzOmDIUpl8BzcDdFi5cT8+Ae0HHPKBDC/jmKQUFHwipq4rWiJVzawZl1SjdMpA71uB8RAfi1tltPHIPbVibTnM397ZgZLCC24mt4E0HtRN6cRm56x8+I7ztdHQ9H1AKEgxWIyLF40LBrTtJVBz2Z9m4aSVIr4BryEufYORbrN9B1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5j8krmAsanZ8R32wVEQDx21/M1xwNLde6ZDoNFYt3Q=;
 b=sujedF60H5cmehd4u68fcxyFCQSPl927m9tKha7UbykLlaKcfw97/Lco9iL6cfuguQwLhs5kn3DINrLqMu1x2sRbbFmwH6rAeVSEfyVHCiWkJtdHfSl5auKs75Og0EfFcN97iTrmK3GHl4L1qlYc+xFJaNFCGV3z1Jot/ebMm2xUjSTFgpq9TbuUP1f+OFwwN2NRT43v2z2N/6pYcfx5IBNST8gJ8axN+6GARvoKakVvZrnyPZP1uUURFuX1mwCVoB7nYaUsvgKgzO3ow3NPVg7pkV5Z4jIPlWTcN2MTKWmmZ9RZ3SV38w0oIvapmjyp6fkcGWmRLqxrjSUepyBrJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5j8krmAsanZ8R32wVEQDx21/M1xwNLde6ZDoNFYt3Q=;
 b=lrWIB/oqc/YDOYNOUZix/LOegRTpOzgvJIHCyKdZ/gLyTGiJAch+QmiFDlLHy1rSVGNBUWAcurEyg7sZJa4OKX265mIQL4bwtbC5e21c3fn6wO13tpSSDTpMkh3Vnpizsob1IBrnNTixIUxai68jubR3afAMXDEkW32bwzx8R3h37MCBEJHvsWqbnPNkt3rK12bF9CQnWGwAwOwVgIOULuP+d0w9ubsg0z+5mTdKUQFszxkkjFshR0SS2pNjar0U/oiwSG2DcjjudnrdW3R9/Vc//Du3HmfVgvqB9CviGXgLpaT5QwH20PxO+HK4lA6DzwcWj61d1aaA9TCBrXl7VA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10634.eurprd04.prod.outlook.com (2603:10a6:150:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.14; Mon, 20 Oct
 2025 10:41:43 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 10:41:43 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Frank Li <frank.li@nxp.com>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] firmware: arm_scmi/imx: Support dump syslog
Thread-Topic: [PATCH v2 0/2] firmware: arm_scmi/imx: Support dump syslog
Thread-Index: AQHcOqLx1io8zbjCQkm4G4SGa8XD5bTK5Xwg
Date: Mon, 20 Oct 2025 10:41:43 +0000
Message-ID:
 <PAXPR04MB845964BA93007D247E9F765888F5A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251011-sm-syslog-v2-1-v2-0-f43a3f6b32e4@nxp.com>
In-Reply-To: <20251011-sm-syslog-v2-1-v2-0-f43a3f6b32e4@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GVXPR04MB10634:EE_
x-ms-office365-filtering-correlation-id: 3032d7aa-582d-462e-c821-08de0fc54283
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eXlDRXFreUhNWW1mYXZuWVI5VXJMRXgwVVJrTGVLeW9PZDJuVVZsZGlGYTlH?=
 =?utf-8?B?Ly9oekFWbGJ6MHpFVmsrLzhIcll6OTRPajVIUlRkMURNclZzU2o4RjhvbzNF?=
 =?utf-8?B?YXY4ZVRtQ3JrODN4ekh4bC9DcUJSQjkyQ2JERkppVkpqYk43U2xZQnlza0lJ?=
 =?utf-8?B?enJrRnY4Ykd4cnQvdHVlaXpjVWJpR2x3cjc2d0NRd0twa0RrK0tjWWZ0N1pl?=
 =?utf-8?B?RElHM1djTEFTdC9UcHNRWkJlS2tpVWEwQm81a1FmN0ZBR0tzZDRLVjlSVGJZ?=
 =?utf-8?B?NVg4OGJBUExVcWVjNEJjWTBYdUJIK3BZRWJZbk96Z3FBUUIzR3NZbXhaZ1Av?=
 =?utf-8?B?N25JMEpob0dDbVQ5NFFFcWozQUJzVm15Ni9EVmJ1OWNDaGtMMzNpMHNHdThy?=
 =?utf-8?B?NzJnL01QV3hpdzIvdUR2K250R3ZmTC9Xc2k2TUNWUnBJVktBWWFaTGVocTNF?=
 =?utf-8?B?VXlsYWhVSUNSYzVJc2xHZlUyWGExUnpWNzBEazYya3IvVk40NGl6T0gxM2g3?=
 =?utf-8?B?TjFlNkNSMnJHNTNVY2gxbkloaWpHNnEvYXZJWUxDeEtQZ3g1YS8rempnQXMy?=
 =?utf-8?B?cjBsSTRaanMwMm11M2YydzlLVUozV3RibEFmbHhMTHpZbHhrcWNyU01uSENV?=
 =?utf-8?B?M1BGVWw2MjZvSm02MWFTTzVORkl0WnJvVERkTkw2dmdaY0EwQWFPZkVURjVw?=
 =?utf-8?B?RTNrekJIN2dzcitCd1YvTVUvU2JSVk5hUmU0WURRaTBUM1RZOEh3Uzk3R1Y3?=
 =?utf-8?B?UDN1MXl2V3JrRzZlS3NJOGpZTXVXTmJONVhicUJIcVdxb2ZIT3FaZHNjZEl0?=
 =?utf-8?B?ZlZ5TEJ6VzN0ckJjbzdTY2RYMU5pdTNyOUVEMTd3REM0czlndHJuVC8wSlJp?=
 =?utf-8?B?ZmpKQklMdHJOclQxY1dzaEZMWmE0bVNQZmdBQ2VOeXFrWXVZdjlaYWNrY3Rk?=
 =?utf-8?B?MUM3VVlMU3h6b0tzdXEvZjRVQXFWb0hkRHB1ZGc5NjMxQURKb1hHeDVMNGxo?=
 =?utf-8?B?eFhlZ3h3a0pkOVRZR0U3ODQvaFRiUkExNTBJd0ZDQlhkc2lobTJwQnpDdmtw?=
 =?utf-8?B?Qk1DL0U0b0ZFcE1RZGVnaDExaUJiREhKeVExUVQ0TTRueEdaTHRSZXkwTFBr?=
 =?utf-8?B?Nk5wQjNNZUl5bHcrVVVKb0ZLVzgzRGJCdi9vOWlyVlk5UWZsd2l2TklWenUw?=
 =?utf-8?B?SmdxUFpoemIwVXJKT0kvdXlEc0g5SHdZOE1JTkVnbW5FM21rZ1RjNUs4NExY?=
 =?utf-8?B?ZURtK3A5Q24wSWJ0Zmk0TkI5eUVlb2krdGI2OHJjRXg2dG4xS0pwWlFFUUla?=
 =?utf-8?B?Wnc5VXFNUG5wZWp0c3d4c1pjOEtXTDQyaWVNZjF2MzNDUytyNUZUbno4azlw?=
 =?utf-8?B?eGlNR3ZTak9EeVNVNFlmZklNcGNCU29Vc04zd05TVU1kNEdyOFRWVGo2U2tx?=
 =?utf-8?B?TFF4U280SGkySmZqRUF4VnY1SzBHZzlxcjd4SkpGRUdaNG82c2szWW96aWp4?=
 =?utf-8?B?bG0yRVlYeitlK09oUDF1UUR4K0R6MS9BMnZEZ1dlSGRWdmRXeUJqTlo0YVZs?=
 =?utf-8?B?cjFxTDRiYzB3MXoxVG10K1hjZlZhSTh6SGdlUEdTSGJWVVNDbDhwbmFvTzJ6?=
 =?utf-8?B?WUM2SDB1VkNUV2czMVpodDY0VVR3Q1d3b0xGbGVPT0pDWVpLblR2YUJIbUdH?=
 =?utf-8?B?blVWd2VTUU9WNzJKcUhPeS9oZE9iUlBNWXNHS1JydlJnVjhjUUFWdHprSzVS?=
 =?utf-8?B?YTlvSlFFRDZGSGx0RE1uYXNBeHZPUnFPa2pYTkV5aWh5UUZMTlRKRThKSkhu?=
 =?utf-8?B?L3Jxc2tuQjBEZWlKZzZQL0RMb1hYRzBFVFQxVlNTbWlGNStaMlRTQW5GcGlG?=
 =?utf-8?B?alpBdkpTdXdmL2V6eWQzVGljWkEwNUtMQ0RzekdVVHF1MUxzMkFsOUdmeHZz?=
 =?utf-8?B?MTdCdUM3RTRXTzF0aG8vVmZzdnFTU2JOaVBXT3N6MjQ0RS80bUh6U08xam93?=
 =?utf-8?B?aFplT3l4VUtBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MHpwcjhxRjJjSFdzUDllQ0gwb0JKMkdSWUJUa285Qy9ISmYyaG5GZkZydCs2?=
 =?utf-8?B?S2ZjTFFBakJ2UDkxNU9IYURFVkVCcFpYZFZFa2JuSFZzOXhxenJTdDN4MGZa?=
 =?utf-8?B?SUc3OTVkdFdqcTlYejgzSTArWlFqQWZ4MTlJcWlzT1dFVDg2M094bXFVZlVB?=
 =?utf-8?B?MHp3cERjV1BLSCtQbjlGNTBsV2J5YjMxUkdXTGIrZXlCcDR0eWhPL25sMW5B?=
 =?utf-8?B?VUFwVERsdFpLcDBqSTJZdlVOczlSbkRmSnNoaGhOMXJQeGtESzVvNHBndVpi?=
 =?utf-8?B?MGRraWNqNEoxc0ZHcC9ON0hoM2VEY1htYzFUZ0l1S0tsMzVKM294WTR3blNZ?=
 =?utf-8?B?RmVXOUUyYTBQbUJBd0tka3pPV21JZHFqV0hDWUR5dE5mdExPMi9hTjhDSFR4?=
 =?utf-8?B?OW12V2xrWUI4T1pzUTRwUzgzMzN1NkpYZm9ZSVJPd0tjM3pMUzFUQ3o1ZTJ4?=
 =?utf-8?B?ajB5Q1F6clR0b0d5eG5qdEYzSnNtbWZIbWlNOWVYTWhMRGVETUxoenBiTTdD?=
 =?utf-8?B?TmxJbWI3cmRJb2NvamxNNjcxVzg4MDVoK3NGNUlLd0lBdHY5SEdDV2lDM1Nv?=
 =?utf-8?B?bTJLOEpsQzQyemtid1VlVjk0R1gzOEVkQ3poT2FaMXgwenY3MWd3MzAvcmNG?=
 =?utf-8?B?OUJPT1ZVZnI1d1BLOHlubG1adHJvWkJrem5CT0hJQmYreUlGU1A5Y1Q4bEFC?=
 =?utf-8?B?MGV4V2JpU2pLdS8vUzU0RHZyQ3oyNGc1UmxhYnZYcGlPcStJU2JCUTRGNjI4?=
 =?utf-8?B?K3VWVTVvdWliT21keGgvajNQN2JEMFZNNlR1N3poTUNKVFhNcXAzZnVHUlhl?=
 =?utf-8?B?KzAwOTZMcUVlQmt4cWM0ZWNwbGRRd0ZBd1ZEUnExRHJUV1VBdXZ4eENnOGNp?=
 =?utf-8?B?akJCSStlbEh0V2tGR3I5bnZ3TE1Ma2xZL2N0czlJc0hwU3pFVkFKNjdWdWVH?=
 =?utf-8?B?YSt2VTMxRnhHZzhvSFduSGpOR3N2dmcrclliV3VSTGNxc1BmT1gvRGVxNFNN?=
 =?utf-8?B?VzEwQ2wwU2hYU2tzTkRFQ0J4YWZuaVdvWC85RmJhQkhiUU9iMkowVnY0L1Bw?=
 =?utf-8?B?NmplWHhaM0gxaVplTkRDaEw1Tk45cVMvUUVZU1hKdWJac0gxUGxsTTUxSkoy?=
 =?utf-8?B?dmJrVUl3WXk2U1pOeXB6WE5FazlwN1RZbWJCL1FZSUZldGVmaTJsSE9sTENv?=
 =?utf-8?B?OSswOUZtMzVPVm5rSjVCV0YwajdmeHpieXhwS3RDSHVTUTA2ZGxZa3NTb0I3?=
 =?utf-8?B?UEdva3RKMzR6ZnVsMUhuVmloWTlXeXQxWkVoZTg2NGdaMk5yeTZvN1Zlc0lS?=
 =?utf-8?B?OXBEYjc4WDNSZnNSemd1SStVbDk2cXFZdEpJeTd1Uk4rR0haNlZlNGNVR0Q2?=
 =?utf-8?B?blN3SXk3a1Y0OG52elRpQU9Vb0JZU21JdWVvZ1VDL3MrNFM5M3RGVFgrU21w?=
 =?utf-8?B?WDhCWHpDTXN2Si8vV2thZzk2RjZDQnJtQmpnNi9nWmFuVVFSQmdiTzF1K281?=
 =?utf-8?B?cjQ0THdES0xlK3YzWTZPZDloekdOVjJWaTcxcEVNR0tXR2ZZZ3YzejA4RFc4?=
 =?utf-8?B?NEpRY0M4djJTcWltNndFUzNpaXdUcVUwaURrYllQcE1qRm5HMGpEU0NHdk1i?=
 =?utf-8?B?YUdjMFRWR3EvaHZxZEN5M1gvK09xamdaaHdremxCQmNzZzcrZmhBaUJsaWdC?=
 =?utf-8?B?UlBYaUJDSDltdTI1cXdyb3JxRzhQWGRYV28rNTZxTXJsVENTSGdKeDBXSFI0?=
 =?utf-8?B?ZURlQzRRczR3eVU0ZEdpdDcvblNUM2tEU1JieEpRME9yM0hYSjlhYnhGeHRD?=
 =?utf-8?B?NG56YlVhdXRrN0Z5UnplS3MxN215TEJUSEk0ZWJ5eU9ZSFFDdTNPNGV0R25r?=
 =?utf-8?B?QityZk5WYlF0ckRPbldlLzZNcll0Y084RGlUd3Z1QzY5T1Fxam0yMDhXUXpl?=
 =?utf-8?B?L2FmZmFGT0RhZEUrVGFGY1JKdEhuVll4dTVKTFJqYjZpc0RBRjNYWVFlVlBM?=
 =?utf-8?B?SlRjVEtjOTNIRjZLcGFSOExCYUpIMzMzVW1VVStjUnYwVFJaSm5YVFFaS3FN?=
 =?utf-8?B?bGZFNVlJWDIySzh5MGMzOURRV2I0blFJSW0zTTFvRUJweFMxWC8wRU5MclUx?=
 =?utf-8?Q?1a1I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3032d7aa-582d-462e-c821-08de0fc54283
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 10:41:43.1982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BJST+p7sMvR/KEOCYhGlRLbDWIU21yGR4gxdgprUXAq9h9gF8BegodMqfuBQNpXos5iqLYyrg2MKVXDyLs0fww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10634

SGkgU3VkZWVwLCBDcmlzdGlhbiBhbmQgYWxsLg0KDQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAwLzJd
IGZpcm13YXJlOiBhcm1fc2NtaS9pbXg6IFN1cHBvcnQgZHVtcA0KPiBzeXNsb2cNCg0KVGhlcmUg
YSBtaW5vciBidWlsZCB3YXJuaW5nIHRoYXQgSSBtaXNzZWQgdG8gcmVtb3ZlIGFuIHVudXNlZA0K
dmFyaWFibGUgaW4gcGF0Y2ggMi4gSSBhbSB0aGlua2luZyB0byBwb3N0IHYzIHdpdGggdGhhdCB3
YXJuaW5nIGZpeGVkDQppbiB0aGUgZW5kIG9mIHRoaXMgd2VlayBvciBlYXJseSBuZXh0IHdlZWsu
DQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+IFRoaXMgaXMgdGhlIHBhdGNoIDUgYW5kIDYgZnJv
bSBwYXRjaHNldCBbMV0gd2l0aCBzd2l0Y2hpbmcgdG8gdXNpbmcgcmF3DQo+IGR1bXAsIHBlciBj
aGVjayB3aXRoIFN1ZGVlcCBhbmQgTlhQIGkuTVggU00gZmlybXdhcmUgb3duZXINCj4gDQo+IFN5
c3RlbSBNYW5hZ2VyIGZpcm13YXJlIHByb3ZpZGVzIEFQSSB0byBkdW1wIHN5c3RlbSBsb2cNCj4g
aW5mb3JtYXRpb24uDQo+IFNvIGFkZCB0aGUgaW50ZXJmYWNlIGZvciBMaW51eCB0byByZXRyaWV2
ZSB0aGUgaW5mb3JtYXRpb24uDQo+IA0KPiBJbiBwYXRjaCAxLCBJIGRyb3AgdGhlIHR3byBzdHJ1
Y3R1cmVzIGNvbXBhcmVkIHRvIHBhdGNoIDUgaW4gWzFdOg0KPiBzdHJ1Y3Qgc2NtaV9pbXhfbWlz
Y19zeXNfc2xlZXBfcmVjDQo+IHN0cnVjdCBzY21pX2lteF9taXNjX3N5c2xvZw0KPiBObyBvdGhl
ciBjaGFuZ2VzIGluIHRoaXMgcGF0Y2guDQo+IA0KPiBJbiBwYXRjaCAyLCBJIHN3aXRjaGVkIHRv
IHVzZSBkZWJ1Z2ZzIHRvIGRvIHJhdyBkdW1wIHRoZSBzeXNsb2csDQo+IGNvbXBhcmVkIHdpdGgg
cGF0Y2ggNiBpbiBbMV0uDQo+IA0KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYXJtLQ0K
PiBzY21pL1BBWFBSMDRNQjg0NTkzNzIzN0UzQzFBRjVBMkFCQThGQTg4MENBQFBBWFBSMDRNQg0K
PiA4NDU5LmV1cnByZDA0LnByb2Qub3V0bG9vay5jb20vVC8jbTZlZDMwM2FjOWM1ODRjNmUyYWIz
OWY4OTMNCj4gNTlmMzEzMWINCj4gZGZjYzllNQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGVuZyBG
YW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIFJlYmFz
ZWQgdG8gbmV4dC0yMDI1MTAxMA0KPiAtIFBhdGNoIDI6IFJlbW92ZSB0aGUgSVNfRVJSIGNoZWNr
IGZvciBkZWJ1Z2ZzX2NyZWF0ZV9kaXIgcGVyIERhbg0KPiBDYXJwZW50ZXINCj4gICAgICAgICAg
ICBDaGFuZ2UgJ3JldHVybiAwJyB0byAncmV0dXJuIGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldCcN
Cj4gCSAgIERyb3AgdGhlIHNpemUgY2hlY2sNCj4gCSAgIEluY2x1ZGUgJ2xpbnV4L3NpemVzLmgn
IHRvIGF2b2lkIGJ1aWxkIGJyZWFrDQo+IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvci8yMDI1MDkxMC1zbS1zeXNsb2ctdjEtMC0NCj4gNWIzNmY4ZjIxZGE2QG54cC5jb20N
Cj4gDQo+IC0tLQ0KPiBQZW5nIEZhbiAoMik6DQo+ICAgICAgIGZpcm13YXJlOiBhcm1fc2NtaTog
aW14OiBTdXBwb3J0IGdldHRpbmcgc3lzbG9nIG9mIE1JU0MgcHJvdG9jb2wNCj4gICAgICAgZmly
bXdhcmU6IGlteDogc20tbWlzYzogRHVtcCBzeXNsb2cgaW5mbw0KPiANCj4gIC4uLi9maXJtd2Fy
ZS9hcm1fc2NtaS92ZW5kb3JzL2lteC9pbXgtc20tbWlzYy5jICAgIHwgODMNCj4gKysrKysrKysr
KysrKysrKysrKysrKw0KPiAgZHJpdmVycy9maXJtd2FyZS9pbXgvc20tbWlzYy5jICAgICAgICAg
ICAgICAgICAgICAgfCAzOCArKysrKysrKystDQo+ICBpbmNsdWRlL2xpbnV4L3NjbWlfaW14X3By
b3RvY29sLmggICAgICAgICAgICAgICAgICB8ICAyICsNCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTIy
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gLS0tDQo+IGJhc2UtY29tbWl0OiAyYjc2
M2Q0NjUyMzkzYzkwZWFhNzcxYTUxNjQ1MDJlYzlkZDk2NWFlDQo+IGNoYW5nZS1pZDogMjAyNTEw
MTEtc20tc3lzbG9nLXYyLTEtNTFjMGRhMmZlMWQwDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0t
DQo+IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KDQo=

