Return-Path: <linux-kernel+bounces-886986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EACC36FB7
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8A494FEF0E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC4134FF62;
	Wed,  5 Nov 2025 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Of74tMLI"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011021.outbound.protection.outlook.com [52.101.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682E334F27F;
	Wed,  5 Nov 2025 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361765; cv=fail; b=WmfiAwknHoBVbSjNljGqQCid6mEg5JCYs3gFQJJbgBmcsOAOIEyOE5dqp0kkM2Kl2hXbV5w+4FprdQrKsmuPvVYr1oFeMWbumkBaDCeIv1BhqFcxKM05oQR9sx5FM9RV7J7hc+K2AyXCMZu4/pJ9Vmv2+L8Ar1ZYMp3V8+A7C/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361765; c=relaxed/simple;
	bh=qGgRnor8vbwiJSkJfhqAkBdVyHO+qlr4GmNtTL6oih0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lrQnLAV1jdNE8PburWI602qH1SjittCJ21YZmE2ig+oWfSXJJ9k1xSLJZCb5MJdm6YIIC70kE9JCBPIoVvcY5psvUYxya4yB2sBYO2CRtVXxe5KE0JW94ZnJVGiaJRoAzehgr1wk3QxvEXHRuKfBsmcTw93knlNAHgajvSPn+UU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Of74tMLI; arc=fail smtp.client-ip=52.101.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUyHhVB9Im3rFhXg5FMLMLAnpw8NYxwC3eKpuw8Fa22v1N5d400l6UVj3vTAykQLfi9FnFkJrLKBKy+3sdrqAJN26CPCCexG9VgnBIAmkaStW5cVTQZkukK41DegelRRDggmt24gjK0oLJ//9NzxWnlXDp6rGyU5RQa5Drta+bm4rp0BZlP/iW7ASFe7JKCVPXq1oRXZEak/4uXEi2S6Ml4MXstcx+Y2hMRCslumNE471FfjtCxF/UR1WDfa9mYLTC99OacpkUfmQWedDtkNtPKvwAQ01kXscLBbbSDzrlxTHYEq9KdpQOe42jVVw58s+PZPjeU7Ig0S+uf/nKbxwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tERNCa6zNHrxTseU3BMPb9w5opzMhl4aHDvzY7w/aIo=;
 b=X+yIg3jW1Co/f8cvXagi+cZ0B0BdthVKC0+3NvvmrfmuNLW2I3QooVtS0Rz89t53HorSFpoMiHVLon6azjKN4oSYOj9/s7hi5j1VyAGY77m2mv+jwIS/A4T0494AG7w9yy55AUCV79VR+oy9yBYWpbvHBzFuBvSsWkQpIa1IQ8eIlDMgwtsmnAun1lICOFWoJZyGrfHEEd4kH1ig8FxlC55MIHGwPx+6pVyRQACHYmHpbdgGyVGRLUALqClCOt5NIK+0He0AJE7oY8BhicvxYj1Gm6BF09lRdHljgo0MDsuucPG03FWX4c/6nDteGLw1EXdhv3Vm00LIdSIE3BamUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tERNCa6zNHrxTseU3BMPb9w5opzMhl4aHDvzY7w/aIo=;
 b=Of74tMLIAJHOCk/m5XYrwBKmLzZYZLCVJDcZ/pvsyqV9sc80qgevyAzL5ntsWOrUFqLV9YeBKhWEI/5N7p+n0V4bcjqB6qE4gH3gr60dnv84t/xW+2D1kW0UnmuDj7eDxMqnqHlv9Ua//mkIiqbvxrrCkGQ5vOeYXBrqYg9xe6fr1itACxTYYVD1GULsshCiNvyFbOyibi7N4UIgY+ggKSA0EDvWDhkTPO+5hivc2J4Vq3g3cMrDl/L4/Q4j/Byb4ThAKyC0ZMcPCTjM3uXPRXatrE97tlD6yzu6kfY2LhZx2XYdvQrhkgGdpMex2kUcx/56iC99g4I7/hKl6L5C1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PAXPR04MB8877.eurprd04.prod.outlook.com (2603:10a6:102:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 16:56:00 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 16:56:00 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 05 Nov 2025 11:55:30 -0500
Subject: [PATCH 3/3] ARM: dts: imx: add required clocks and clock-names for
 ccm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-ccm_dts-v1-3-6aadcdf97cb8@nxp.com>
References: <20251105-ccm_dts-v1-0-6aadcdf97cb8@nxp.com>
In-Reply-To: <20251105-ccm_dts-v1-0-6aadcdf97cb8@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762361743; l=7991;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qGgRnor8vbwiJSkJfhqAkBdVyHO+qlr4GmNtTL6oih0=;
 b=6K93NYxnioj/TEazhXh0pODrUhkmGoZLntUIuqEJgLy8mrblmFsBHmV7D/9bEyEaGF9kaJMh9
 oHgN3irV1xhDWlWrD/QeA99mAlzO946MhgVIr2Om3fgcK4N93bWSwKW
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:a03:180::20) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PAXPR04MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: 8525efb4-61d8-416f-e813-08de1c8c3294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1lGS0RHSFBrWGNwcHNEaWRpTXdINVN2cXhTUzZLaDJtS0tDclV1aU54akxs?=
 =?utf-8?B?bitFaUg0TkFkelJVWWlMdEhwaGtKclk4by9zZVhabkJVdkh3Z0pnV2tabUxG?=
 =?utf-8?B?TDErTnFIT3p2ZVpJVURXY1JtSVNlVDBLL2M4QnJGU0lWOU9oWmVpUWdaU2Zm?=
 =?utf-8?B?VXh3QlV2eisyZ21JV2E4aTdTOFZySFFhVGtOdnFvc1pwd0daWkZxa2ZTT20y?=
 =?utf-8?B?Y0xWRTRnaXl6alFiWld0bG1lSTZjaC9SbmxCczBCS20wT3EwbDZ1bGhkVGVE?=
 =?utf-8?B?azVNREE1cHNlV3pwQ2pqOVVDUmFzK1B0UzJBNFdXUUZzTEpyMWpycnNYcTE5?=
 =?utf-8?B?ZGlpL1htOUsxUzJpKy9lOVN4ZVhiVWlSRGxEK01hL1VseWJtTnR0K1VVTk91?=
 =?utf-8?B?ZHo5dG1GNU04enpYVXVIcE1vK0pTbjJxN041RUF1Tk5pNFVYL0ZuWFN5OE9u?=
 =?utf-8?B?QXJJZGVXV3M1bkYxeHRFVmxFNmVLM08vd0RNejg5SVNram9DUk5Vd3J2YVdI?=
 =?utf-8?B?SmRSam0xNGJ3eDRQNWJuK3lqcUVCRjg2dEIvOEpKSlJ5aEtsYzliMmRlWklv?=
 =?utf-8?B?UEdabWRGUGpXcnVlNmJIUXZ1Q3IxUlBsbk9Na3FDWVFoajRpeUFGWEp6RDFK?=
 =?utf-8?B?RlFOQ1EvcmlqL25tY01OMVliYjc3SjZqb3FVamtPS0FUVG1NM2Fua0VtYmU2?=
 =?utf-8?B?QVlxSDA1OVFjYWxLbzRXcEN4OERHakMxYzM4Tk56enA4eVhJOGl6OU1lRzJF?=
 =?utf-8?B?RFMyL1pnRzREV2p6UVlWenFsM2NUVVZKVCtLVnJ4ekd4Vi9uVVY3U3doOHND?=
 =?utf-8?B?TTZleXEwbllXeFdGQVZKbGkwZFQ5SVY0eTFvQTU2RCtqSDdiMzczRzBCZjQ5?=
 =?utf-8?B?dmRUakJJdkptVWVSUUdtRWZ1K1JVRjJHMnA4NVFwY2xoWFIxTzUzTUxlVWg3?=
 =?utf-8?B?ZHA1ZzhzQUxna3lvajNDeTBHV0lROFZQZGc3VXArcG5MaFgyZzEzZ05jV1Vn?=
 =?utf-8?B?Y2J1ZmdVUVNRbGQ5V1hTakI4QVFnQnU4bFhtaFEzb0xHS2tBNXJpOVYwZXhW?=
 =?utf-8?B?aWhNZ2hwRlNVMXdsUC9razExVkNZQzUwUzQycHhlcGh6czlJWW5ibFN5Ukdx?=
 =?utf-8?B?czhIMFl0RjQ3K1NiZjBiQWZTOTlzQmVaUVJ2OCtPelBoVkk5ejMzK1E4ekdv?=
 =?utf-8?B?WmE4T0l6TGRKRmxOdmxKdFpNMDhkTWhMUlFjV3RMTkpoeTZ0SForaVdTZ2dE?=
 =?utf-8?B?dE02MlpMRko3MC8xTCtiWktjQ01lRS85Z09vZy9hVnUvSzJaYU9oc2ZUVU5r?=
 =?utf-8?B?TXRDcnNKcE1KNkRQMzhHVmRtdkJZbUkrZXVMNTExVGlLT2NqcGR6NVFjRW0x?=
 =?utf-8?B?L0E2dGRVbVB1cnZEU1ZGWWxqNGlBUzZaak4reFRFUXcyWVk2OWthSXh4aGhm?=
 =?utf-8?B?OURURUpuRU41YUphekV0YTNhTTNTbHd6WnlCYUtKZUtuUmNoZVBVMEFTK2U4?=
 =?utf-8?B?RGNFNDFEcEsxOWhMbC9Zb0U4eWc0RWpmdkVZeWY0NmtwTzkxU2ErVE13VDll?=
 =?utf-8?B?TWs1eG5yYXdxVWtCd1ZtVnB3NnJsUHFpUDdmRFJjTlNQK09adGsyUnM0dnd0?=
 =?utf-8?B?cTlPWUZDTmRyZGFsQWJKV05xSWxkOWRQVkk1Rkx5VVlJNlVTQ2NSYkNTeFgr?=
 =?utf-8?B?cFEwclpkM1Y1bXBVS0EwQVlLTlc2dWF6ZzZ1YS9mUm9pc0RtZWh0MHk0d290?=
 =?utf-8?B?N1ZpVW5RTytYZWE4bkNtSitWV2JaMDRoalhnK2dlSGVDeUxhTE5BQklrcXBu?=
 =?utf-8?B?VnovMThkUSsrT0QrQjdjUXFNdTliS2cwcW5ENURHWjFBVzFxcmk0Y2FQQ05X?=
 =?utf-8?B?VmlrUHJDZHRwOEpVVUl2OC8vMDZ1RjhiUUFweE9QS1cyV251ZDlhQkdUcFdC?=
 =?utf-8?B?MGhxRDBYUGR0UklMOTNJblBWd215emV4aFgrbGZGNDhVa1hjQldwR0c4S29n?=
 =?utf-8?Q?sxts2+1bs9EcWoTPqQAtYJAj7zFA44=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHZCL1lwd0s3ZEFzSytmQ2Zmb3lKbXBtNjF0L2hwRzRUM1BRUmNGTmRHd3VY?=
 =?utf-8?B?MXpLRU1wNlcxUkRzak94RFhINW56TFhXTHQvOWxXbFpCblFhK1NCcmFDNE1R?=
 =?utf-8?B?SEVCalFRcVFSeXNSb2JRSC9ENWtuK2ZwOE9XSFpyU0h1Y0Y2S2U4VlFtMEgx?=
 =?utf-8?B?cDlGUW5LM2N5ZTFjaE9Ubm82eTJkVXBOcVlxQkI3YnMxMHNoZ09GaC9PVkdt?=
 =?utf-8?B?NXdpdlMzalAwZ084Qm1QZ0oxUTNNcWlDZzh5dzdBUEdYQUdEWlErV2I4RFNu?=
 =?utf-8?B?NU0zZVpyMFNsNHcyTGdGMjgzK0xVeVU0aGtVa3Qva1RyMklNblNZcG5nQlE3?=
 =?utf-8?B?bVZkQ2xzMjNPWmkyR2hZL09SeFVIWmRYUjc0citqQWt4eHhyNmI2UWxLb1FE?=
 =?utf-8?B?ZzltQ1VaVWNLL3lVT0FCRThhckhKVzBsdUdyYTFSaFhQRC9xYUE0cWN5azdU?=
 =?utf-8?B?T1haYmZvSnZaZVFZbVhNdFltSzY3Q1ZLVWJUdXF1djlpZ3NWeUcxd1FZTWNR?=
 =?utf-8?B?eGdaQXcwOEJmVE5JUnpBVFJvVjlYWG9PeWkrbGEvZFNkRmtJc1FxLy9ZQWNj?=
 =?utf-8?B?RU5jL3FlVGk4eWFNZ1hDbnJIVzRNMnVDU1h0VTdFU3Raajc4RnVHNHovL00v?=
 =?utf-8?B?cXdMcGJETkVzbEd3WHRmQU9GdDh6QUpKbGZzVlZqNnhQOFRDS1kxMFQrYlBD?=
 =?utf-8?B?RkNWR2V4RFVUa2pvQ29Hd0VxSksyLzFPekY2ejE4RUo4L1RhTnZneXd3VEFK?=
 =?utf-8?B?QUMwdUNnaVVhaVdoYVJ5cjhvRnNIemdVcU5WcWlaUzM2Q3h0ejcvWnZTSkNI?=
 =?utf-8?B?Z1ZsYWtzM0t1a0lNWVIrSlFKeHRacVZXSWZFeEg4enNCOHMydUJuN0d0b1BS?=
 =?utf-8?B?N3AwaDMxTSt5SU5iWXdjTDVuM24wMGJjQi9GbHYyN2V0aG16VURQbGpNTS9I?=
 =?utf-8?B?cGd4bFg4Z2RoT0I5UUxMQ04vdGNxczhoMGxpdEFRTjkzZkRlUFRZd0JnNE5j?=
 =?utf-8?B?MTFzZW0rUUE1MEpzbWkxUUdxTXl0SUppQTNLa00xVVlFb1F1LzhCRXV2ajVt?=
 =?utf-8?B?Q042TlFCL2QyaGJRSHkvWjhMOTJLTnZwTHZaQldqbUorZTE0QWljUGpWWkRY?=
 =?utf-8?B?QXlYY0xEVm5ja0JhNExnUHA1UE1tNFhFa3V0RFRTS21nQnlyWENEVStNc201?=
 =?utf-8?B?cnIvVU1Od0hQeWVjOWhMUUVDMVowdGVXTkJwbDdkQnlrTUgzZFZRYTB1RUJp?=
 =?utf-8?B?ZUZmUk9YZldSamxmY25zQnVIMTJEWnNNS0M0d0hqSEZHWEFtejZZdDBvbWtr?=
 =?utf-8?B?UHhYZXgvdEJlajJUeE5ndUNYQnQ0TmZUUU8vNTlIWVRBTk4yZHNWWk44b0lF?=
 =?utf-8?B?bEpqdEc3TC9HcHo3NnA0NEhKbmF1UlkwRTFxK1A3WWQxN0R4YlgzNlFWbHVM?=
 =?utf-8?B?a09RTmJhVTQwREhLc2ZJd3BneTZTTHFJdit5T2thU1pBSWpadGd5SnRNcnBJ?=
 =?utf-8?B?OGY3SDc1WG9ieE82NEpNSnVGQU85aC95Um9hRWpJOFB2cmQ4WDVHL05vaGZt?=
 =?utf-8?B?ZDRCZDIxQnR5dzF6dDFmL2U1N1JleEMvN3VEMTBrZ3ZSS2poUnBRUmtKY0Zk?=
 =?utf-8?B?eUs3V1o5bURzSEdYcUFDVzcyckNMdkVjSXFkbWs2QTlzdDIyTXB6WXZBS0Z6?=
 =?utf-8?B?cVRzVUtDMUpleTlWcEx2TGFuS3hLUmxjKzFwWERjbXFoeVRLUDBwTFpPbzk5?=
 =?utf-8?B?ZE9xbXl2eWk5NXpTWVV2REdjZUVSeGVDSFpQOFFWN2pnZi85Ui82QTZVVkNF?=
 =?utf-8?B?U0szMlVLZnRQcXl3QmJ5OUdpYytWN1JMek04dGRYL0pMK3JwbWhxM1UxWjhk?=
 =?utf-8?B?T1JyczVpYVZiS2d2WGZVVmV2UU1rNEZBWUt5MUlsUE1mdFlTQzd3MDR5MG0w?=
 =?utf-8?B?aTJ4ckdCQXFHbzhJd25BWDJGSzVjWlRLbXpGYlZVT2ZxNzJQaEgrTWw2ZVQ3?=
 =?utf-8?B?NmhtYktIUHZZM3JBWSt1R3cvbnJOb0xZbGNDUmdSUi8vZFBIM1E4UHp4Vmk3?=
 =?utf-8?B?cUxCTExaSEdGTmk2R0dGdU8wa2syOVBvOFJnVmI1TmptcWlLY29nMWdGcUg4?=
 =?utf-8?Q?/4cPx9ojgSM3auJdX3+xcXvLe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8525efb4-61d8-416f-e813-08de1c8c3294
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:56:00.4952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhnufqPDgLiGZZzB72MtnEoDZpWSDuCW2X9H/XShsfBift6RkTHDefjuHh1Vi4NXn1jtFMnLXs/zR2S4cvgDOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8877

Add required clocks and clock-names for ccm to fix below CHECK_DTBS
warnings:
  arch/arm/boot/dts/nxp/imx/imx6dl-alti6p.dtb: clock-controller@20c4000 (fsl,imx6q-ccm): clock-names:0: 'osc' was expected
        from schema $id: http://devicetree.org/schemas/clock/imx6q-clock.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6dl-alti6p.dts           | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-eckelmann-ci4x10.dts | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts           | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-plybas.dts           | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-plym2m.dts           | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-prtmvt.dts           | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi            | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts           | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6q-prtwd2.dts            | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi       | 4 ++--
 10 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-alti6p.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-alti6p.dts
index 9bb36db131c21956a33f0a5a013c5bb4cffe1890..50448135329d21f4dfb6259d28d98c961e73604b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-alti6p.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-alti6p.dts
@@ -193,8 +193,8 @@ &can1 {
 };
 
 &clks {
-	clocks = <&clock_ksz8081>;
-	clock-names = "enet_ref_pad";
+	clocks = <&osc>, <&ckil>, <&ckih1>, <&anaclk1>, <&anaclk2>, <&clock_ksz8081>;
+	clock-names = "osc", "ckil", "ckih1", "anaclk1", "anaclk2", "enet1_ref_pad";
 	assigned-clocks = <&clks IMX6QDL_CLK_ENET_REF_SEL>;
 	assigned-clock-parents = <&clock_ksz8081>;
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-eckelmann-ci4x10.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-eckelmann-ci4x10.dts
index 5ed55f74b398f24a69245dbf88f5c93ee0d347d8..de06006d8c6989ea09712c882b0eb01e347d2f13 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-eckelmann-ci4x10.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-eckelmann-ci4x10.dts
@@ -66,8 +66,8 @@ &can2 {
 };
 
 &clks {
-	clocks = <&rmii_clk>;
-	clock-names = "enet_ref_pad";
+	clocks = <&osc>, <&ckil>, <&ckih1>, <&anaclk1>, <&anaclk2>, <&rmii_clk>;
+	clock-names = "osc", "ckil", "ckih1", "anaclk1", "anaclk2", "enet1_ref_pad";
 	assigned-clocks = <&clks IMX6QDL_CLK_ENET_REF_SEL>;
 	assigned-clock-parents = <&rmii_clk>;
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts
index 47a6d63c8e04cf28795310aafcdd3b2b05740830..38dfcf1b0c73b0114042937e02cf596802d21e8c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts
@@ -119,8 +119,8 @@ &can2 {
 };
 
 &clks {
-	clocks = <&clock_ksz8081>;
-	clock-names = "enet_ref_pad";
+	clocks = <&osc>, <&ckil>, <&ckih1>, <&anaclk1>, <&anaclk2>, <&clock_ksz8081>;
+	clock-names = "osc", "ckil", "ckih1", "anaclk1", "anaclk2", "enet1_ref_pad";
 	assigned-clocks = <&clks IMX6QDL_CLK_ENET_REF_SEL>;
 	assigned-clock-parents = <&clock_ksz8081>;
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-plybas.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-plybas.dts
index 84f34da06267ebd477fbe71b465a44ffe5b4c098..9483ca1a1192b31d74a969c9a01bf047d5aebdaf 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-plybas.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-plybas.dts
@@ -101,8 +101,8 @@ &can2 {
 };
 
 &clks {
-	clocks = <&clk50m_phy>;
-	clock-names = "enet_ref_pad";
+	clocks = <&osc>, <&ckil>, <&ckih1>, <&anaclk1>, <&anaclk2>, <&clk50m_phy>;
+	clock-names = "osc", "ckil", "ckih1", "anaclk1", "anaclk2", "enet1_ref_pad";
 	assigned-clocks = <&clks IMX6QDL_CLK_ENET_REF_SEL>;
 	assigned-clock-parents = <&clk50m_phy>;
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-plym2m.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-plym2m.dts
index 0ef24a07dedf986efdf4ce8ad4032814752e7271..ff64b94df5af9f9e103a792c77577635978633da 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-plym2m.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-plym2m.dts
@@ -199,8 +199,8 @@ &can1 {
 };
 
 &clks {
-	clocks = <&clk50m_phy>;
-	clock-names = "enet_ref_pad";
+	clocks = <&osc>, <&ckil>, <&ckih1>, <&anaclk1>, <&anaclk2>, <&clk50m_phy>;
+	clock-names = "osc", "ckil", "ckih1", "anaclk1", "anaclk2", "enet1_ref_pad";
 	assigned-clocks = <&clks IMX6QDL_CLK_ENET_REF_SEL>;
 	assigned-clock-parents = <&clk50m_phy>;
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-prtmvt.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-prtmvt.dts
index 2160b71778355623a9f124975e2cd4dfba4be900..d1c49eabfa3730950bb524ec37456c692bf9c50c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-prtmvt.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-prtmvt.dts
@@ -294,8 +294,8 @@ &can2 {
 };
 
 &clks {
-	clocks = <&clk50m_phy>;
-	clock-names = "enet_ref_pad";
+	clocks = <&osc>, <&ckil>, <&ckih1>, <&anaclk1>, <&anaclk2>, <&clk50m_phy>;
+	clock-names = "osc", "ckil", "ckih1", "anaclk1", "anaclk2", "enet1_ref_pad";
 	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>, <&clks IMX6QDL_CLK_ENET_REF_SEL>;
 	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>, <&clk50m_phy>;
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi
index d5baec5e7a7824c05ca64c36a1839efff0bd7f71..fb674ac2c2485a818ae593c63388bcec548a100e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi
@@ -71,8 +71,9 @@ IMX_AUDMUX_V2_PDCR_RXDSEL(MX51_AUDMUX_PORT1_SSI0)
 };
 
 &clks {
-	clocks = <&rtc_sqw>;
-	clock-names = "ckil";
+	clocks = <&osc>, <&rtc_sqw>, <&ckih1>, <&anaclk1>, <&anaclk2>;
+	clock-names = "osc", "ckil", "ckih1", "anaclk1", "anaclk2";
+
 	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
 			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
 	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL2_PFD0_352M>,
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts
index 76b0007d20ad22eee738ab40ed126435a8fd17fd..75a6bf4b5308062518a4d1e94e32ee4fe89dac43 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts
@@ -160,8 +160,8 @@ vdiv_hitch_pos: voltage-divider-hitch-pos {
 };
 
 &clks {
-	clocks = <&clk50m_phy>;
-	clock-names = "enet_ref_pad";
+	clocks = <&osc>, <&ckil>, <&ckih1>, <&anaclk1>, <&anaclk2>, <&clk50m_phy>;
+	clock-names = "osc", "ckil", "ckih1", "anaclk1", "anaclk2", "enet1_ref_pad";
 	assigned-clocks = <&clks IMX6QDL_CLK_ENET_REF_SEL>;
 	assigned-clock-parents = <&clk50m_phy>;
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-prtwd2.dts b/arch/arm/boot/dts/nxp/imx/imx6q-prtwd2.dts
index 0e02e448db1085e7f508e55cd55d4441d2f51a54..c8bf04238bf565eb2fd1595031d6d1e813aa33ed 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-prtwd2.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-prtwd2.dts
@@ -57,8 +57,8 @@ &can1 {
 };
 
 &clks {
-	clocks = <&clk50m_phy>;
-	clock-names = "enet_ref_pad";
+	clocks = <&osc>, <&ckil>, <&ckih1>, <&anaclk1>, <&anaclk2>, <&clk50m_phy>;
+	clock-names = "osc", "ckil", "ckih1", "anaclk1", "anaclk2", "enet1_ref_pad";
 	assigned-clocks = <&clks IMX6QDL_CLK_ENET_REF_SEL>;
 	assigned-clock-parents = <&clk50m_phy>;
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi
index c93dbc595ef6eceda5fdf7b90dac57bfed59e489..5fd7c4b52871eafa6bd6c092ed1bd7b516da3a2b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi
@@ -238,8 +238,8 @@ adc: adc@0 {
 };
 
 &clks {
-	clocks = <&clk50m_phy>;
-	clock-names = "enet_ref_pad";
+	clocks = <&osc>, <&ckil>, <&ckih1>, <&anaclk1>, <&anaclk2>, <&clk50m_phy>;
+	clock-names = "osc", "ckil", "ckih1", "anaclk1", "anaclk2", "enet1_ref_pad";
 	assigned-clocks = <&clks IMX6QDL_CLK_ENET_REF_SEL>;
 	assigned-clock-parents = <&clk50m_phy>;
 };

-- 
2.34.1


