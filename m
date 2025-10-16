Return-Path: <linux-kernel+bounces-856544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC41BBE472A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B315E497F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEEF393DD9;
	Thu, 16 Oct 2025 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SVxWW8lB"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011017.outbound.protection.outlook.com [52.101.70.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1768336CE03;
	Thu, 16 Oct 2025 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630447; cv=fail; b=PKBp00+0TpRb71vaCVuDooL/bpMTSV7F8irTqgYZoR35iBHiGjQOzK2nkimuc4FBMOtnNH5zsijw3CSWg4fCTmUHAZirqrknOJJre4rJhCaKVn1ElfIJxUnRjLbT0yp77V1uh5hZo/XymRmxgfy4AgCS3pr0OmK+tieYhlbHyc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630447; c=relaxed/simple;
	bh=IBe0dESJLCX7jHaCf9dLwBLd5K8sW+7qIOzaAeP0mA4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ioq/pjhsWMjJTBk2I0dnCmelGm3GOBu8C0TYFWQ5XJRAvkD4FHC3kW8mZqA2SyrlYyEeh6k9kuUyA7pmmDnQCLLeHkEs0OTtxFr8PghnarNKJSnccBwK2oPZL6+0Zcv/jhxA4Aq+SldSAj8t80uZI4hDXycMM8lNJYLHZIpdw44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SVxWW8lB; arc=fail smtp.client-ip=52.101.70.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ejbyss7NYBk8Muo37f/m/cb0Z2/VgDC1L5EE6Nhg2bTCIkL5BRDfIBape1EdUFEgyes7IQPQZ17uCnQYwxIvWdfqZwV2Npjk+XoKtRZm4ZtTFk38u+QEJqf3b4AYM75RWIhUdKOuGkW0A7bObUeyxqrr11WGMqlFNnRhhybfonXC2HtgVszxJT6hg5BuEmE7iMsMrYAQ8JpnRvwO6ZiCIy1yGS8ZsAX9w46V0O83DleU1zWPMlQrZDyZnIyjyzQRtQuwxf9u8HRz/gPmBpXBddqA9oTqB3H/c7NAcrcqoTuOFKlSP36Zi1D7449yzImF8qmSapI8SL7vp+LLJ33YQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDXJc4Up7QXPdAyEDqSa4Ayrn8e6rVWtgxGrmOuUZ0o=;
 b=P/aX+5Z2DPiyNhPRlcfFScYGrdvnwl0MAt2W24yhR6LFYWIieotCJq6godUwaPgVGxT5UgBfA5A9DLUCVMB25Se2UPbDmzfkUrN8XoCkW5BO+Z9p8UqeDZzxrp5dZ3D/LspXkxdZComqzem3IVh8WTKcjmeaYDAKzSknp7oLQ62ZU/O8VgPRFbrauuXiCBsYDtrPCuqdCfwd+FZ0ju4YBv/fsPOFoLsVle0qjt98OjzJ5Psgjinm2qzPysgZ7jyyVyOFILHdlQro3rReClDp07CXCRcj8eIVunLorRymFlWgo97pyzE3VjzMQl/bqyPiy4y4bk/vWvy3dcPBjH7hqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDXJc4Up7QXPdAyEDqSa4Ayrn8e6rVWtgxGrmOuUZ0o=;
 b=SVxWW8lBpY+Zq23E5wXCiLNzwX8IgYX5e5G90U8LvKUcLxD9MjPZfNu4wp9BaVEz2vYOq7Scn/gGLl8oYEb25YdYWcoNoDv+pXQe6F0QaZ996Clsv4AtbxmqmS6KPB11NFw1fZ+Avl+AEG0b57dulOX+NQTyCHGpt0Ya4hv4ql0OHRDjm0rGfWFkjOudjqrDDxPIr2GSpOcPLK8eUTfUOxXCnzvMNusUsd7tT8gnE4FYw41ZOnqXgig/q0IeTdo1XdOuaSOwzybzRcA/F3rR9I8d7rEo4wquifInYm19WH9TqzTjjhiWjslb4tZZaOEclBRn9ldcOnEZ97JfhB3t/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10069.eurprd04.prod.outlook.com (2603:10a6:150:121::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 16:00:42 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 16:00:42 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 16 Oct 2025 12:00:11 -0400
Subject: [PATCH v3 07/11] ARM: dts: imx6: remove pinctrl-name if pinctrl-0
 doesn't exist
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-imx6_dts_cleanup-v3-7-baf2814f8a15@nxp.com>
References: <20251016-imx6_dts_cleanup-v3-0-baf2814f8a15@nxp.com>
In-Reply-To: <20251016-imx6_dts_cleanup-v3-0-baf2814f8a15@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760630414; l=1499;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=IBe0dESJLCX7jHaCf9dLwBLd5K8sW+7qIOzaAeP0mA4=;
 b=AimKTVgHMUKg1f+hGxZ5gU3EwPJbKbI4hQAWYm2D5PtitAQosJ4cfqBlrEyaYsfz4S1kNe5Ea
 xS9DxqFHTznDmW7+wX1Fra9Nq0d8jMBbiad5QpPahrWkpjGww6ilbkV
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:a03:180::47) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB10069:EE_
X-MS-Office365-Filtering-Correlation-Id: 19203005-09d0-4691-0458-08de0ccd288e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzR4WmlOYVJ2aUVWeko4NHA3TmZTcWp4RCswTVJkc3NsOHpXUlE5WEZudEZq?=
 =?utf-8?B?cFhzUXBhb3ExcGhlcGhBR2YzOU4wc1NaZSt2OCtGSHhrSU8yMFRCbTRpMjNE?=
 =?utf-8?B?dFdWbGVaMEE5WVFJMmcvMXAvMzh0b2l1NitRZDdyNEVVdUpVa2JkME0yRlFO?=
 =?utf-8?B?MnIyTG5SVVhvYTZBMDZueDVka3BtZXViRHRValBSYnU5T3Erc3E5bzhybUg4?=
 =?utf-8?B?eFFSdVhsc2liZk5kYVpUZlNNZDJHQmMzQXVIeW1uUmJsSFY0Wm5TMlJvV0k3?=
 =?utf-8?B?Y1lseTF6RUFEdDgvN25FS0VPYkFHajExTnlIcnFwM2ZzTzZoc254VjRrZHN6?=
 =?utf-8?B?ZEgzZEFvN1JlbGpsQWRlTTc3YklQUVM3ODJxWkUwdnM5RUxMR3RUbmNDZjdu?=
 =?utf-8?B?NSt2djRrYnE3TDZmbVhYbkl6WVIyTTJOVzBHWDNMWjlsUjZaQ0JPTzV6RnpT?=
 =?utf-8?B?cHR0YUFQUHVhUnpZVVEzN0ZuYlhndFM5Z3ZkUkloTWl4enVxVlBDVjB4WWVu?=
 =?utf-8?B?eUkvbEV0aVEwQTdUeXd4eEZNMWJtTUZSeXFETnNjRFdtUE9lV0pVdVpnc0E4?=
 =?utf-8?B?ZzRUbUJjMlh3OWM5T0VlNDRtS01zcHlRbElQeDRqQkpWdkF3QjFjSTJlMzNT?=
 =?utf-8?B?a0dSNk1TT2pzYmtFRVFTbmpWcmhMNVh4RTVkWkxURjdNSkNFR25oUktIQTg2?=
 =?utf-8?B?YjBaQ1ZrOUcvbTQ1aEdkMlpZUTZ5OFowTllhNmduZUp5MjF6MFp5dFZFOVNU?=
 =?utf-8?B?VHg5T1lEZ0ZTc2hwSHBzMnhLZVpuWFUzWEF6N0NEOHNVZHJweW8yaFgvYkpy?=
 =?utf-8?B?Y3FuYWpDNS9vYjFJK0o1bTI4Z3JqNXVBcUxhS1d1YW0vRkZXVHk4a1JFSmZU?=
 =?utf-8?B?Y2NDc296ZmJLeFl1MFV6MFVyN1lTVlU3OVZvekwzcmwyc0ZTT0xOZ0ZtOGZz?=
 =?utf-8?B?S2tHNFRNNXdkaWducTlFcE56NU8zNGVXY0d3K1VOK290a040MGUxYUxLUk1r?=
 =?utf-8?B?Vk5MVkZPMnpqYkxlekZ3V3JFSWRncjBUR1dlVTE5UjQvcm9WVm5xYnVRdDlN?=
 =?utf-8?B?S01Fb3V0amZUMmxtYnZJbGlSd2RyZ2d1WGpoYnMyNm96ako2NTlVRlVySEpR?=
 =?utf-8?B?L1FkY1Z5SjlwQkRza0dySVBaZzVtdm9Eb3MzQkpsY1FUWHZMd0E2RHZ5RlJF?=
 =?utf-8?B?L244c0Z3a2o1QnpBeC9wTkR6YWsxNHVvZEdxc2h4STJIS0Q2b2w2NVdranAr?=
 =?utf-8?B?OUNXZ2xDa3EyM3htV1JPTG84cDFsejkzSmx6TmtrbnBxbXBORjFGQ0NzOFpT?=
 =?utf-8?B?VEJTbzJPdERwb2t6cW44bEd4QmF5NDlrdldNL0dPWkpKbWhoQ2ZPQnN0R09X?=
 =?utf-8?B?d0R6Q1dXVEVxYUhFaHR6czdydHNOSGViNFFnOW5nalZFbWlTdytVUmN3dmRH?=
 =?utf-8?B?ZnE1WWppTDBKYVpjK08rd25hb08vSnlRRnQ2a2JzU0RmdFIvRGRGcnIzeldy?=
 =?utf-8?B?bzFPSUcvem1xQjh3WEg4Z1BDYlhPbE43aUZnc3R5Ym5KbHdXME1Gcnl3MHZF?=
 =?utf-8?B?VFJ6a2F5MUxuamlCZ0dJT29EVjk0b2tpcm51MGNLN2dZK0dkK01LUlkxaVNR?=
 =?utf-8?B?MEY1c1UrUHlNQlNSeVVEYVNnaG9IT0tiaUk2bWxGV1FzVDVPa203YkxjSDJG?=
 =?utf-8?B?ckFLSFI4RWs0V2ZYUVROSTcxRmlLN2pTNHk5ejNiVU1YamZtK3dDcHg1RGNr?=
 =?utf-8?B?WDJQZWFiUi84SXBxVWphSkYzZnZieWNMcTVrTlk2VGxtVnl6Yndzc0FVUWtF?=
 =?utf-8?B?RjBTK1hldDZDVjArVnBzQUV2TDhHUWV0NkYzeE1YMXhmeEVteG1NS3VDS0pO?=
 =?utf-8?B?T09CQjR1N0R5TTM2Yml1T2w4NWtld1RMdjZkVkNXMk5TVG40UXV4L2lROTlR?=
 =?utf-8?B?cy83SWtWa3FOMTNsNml5bzBMV3JySDJhNlJoRGR5ZXBtQ1d2ZitwQ1FDM0lZ?=
 =?utf-8?B?SzJ5RG5yQnZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OG5mcUsycUFheEtaV2tmVkRiMmhQV3AyTEExTFRZTklJcWlqWkt0VVVlNHFi?=
 =?utf-8?B?aHVRVU1TczZaWEFBN3JwaDIxWlA1ZDhYSWRCb21KakxGYjBQRVVwdWtKbVN0?=
 =?utf-8?B?R2x5OU40TSs0a2IwcGNFSnN5MmdtVm42TDFaVElPOWNud2ZmcGZyUXhtYnpv?=
 =?utf-8?B?QU1QKzJhYnUrZ2ZlSm5jeFVLcVpyRFFZTFVBZ0lnc1ZPWWZ1MnhxUnBhUEt0?=
 =?utf-8?B?Qy9zclFhMEpXb2hndTNZKyt4dFpya1A4MTBjeTYxRld6ZEMyb2VDazRJeTVa?=
 =?utf-8?B?cUtFVHhVemxjT0Y1SDd0L3VXQS9CZTVNSDZvUkdZeXFaWHZHUHRiSW8zYW9Y?=
 =?utf-8?B?cGtDaURzNUM5U3pMTFk2bS9xOEVhQXlXZ2dNRjcwRk81YURsQllXRGZYd1Bi?=
 =?utf-8?B?MUd4ZEdKaUU1V0tSUmVRcDhXeGpJVFRMSXlwWEtGOWxLYzBFaElzL2tRMmRo?=
 =?utf-8?B?L1JRVC94NjJENStIeFJ2UGtnd0VDTDNJdmdPVWhxMXhneEovalF1T0dPZyto?=
 =?utf-8?B?Qk5JMklndFdlbFpWZFJyM0JNTTVxcHBMS2FLYjVhMENGemlUaVl2VUhlL0w1?=
 =?utf-8?B?TzRtS0tzN0s4WUNJMktNZmlZd2RVUHpOM1l2SkxkV3NSYjhmUlFaaC9xTU55?=
 =?utf-8?B?UWVoNUljS0NMTUJ0c1ZCVk5qSHVMNnNqb1NlWi9QelladEZHSEJtSUZEMitN?=
 =?utf-8?B?VVk0K1p4RFhQQ1A0SmJjUjlJUTF5UWxxbkhCamk1eDFzOXhiZkpRRE1SN0M0?=
 =?utf-8?B?cmR5ZjlmSUh6TjNLUEU1NEFqQVNwQXE4Rkk4MXR4cWNwa2FSbXFLeUs0dEZ5?=
 =?utf-8?B?c2pRYmFEeEQ1L3JucVVyNk5hZ25hSlFqaHlEaHQvRG1CL3h5Qi9JcDltTlZ3?=
 =?utf-8?B?YVRyTWx4dFpwcm03aGZ3UFUxNVhWRlJWOHBwcHNId3BvaUxJWFlZNGl6TTl6?=
 =?utf-8?B?NTBzM2c2ZTVpTnlZNjlkUTc4dkJWdjlRQ0M3UHJvZG9uK2h1K0lTV3J6NmJt?=
 =?utf-8?B?MS9XUFNCc1lMM0F3TGQxeGhsRjNvenhtUU1CU1ZvV2NaN0xyZml6Z2dMdW5l?=
 =?utf-8?B?eEhvTjZ6Z2dSd2VwTWNCVlNDNHpyTDE5T2tzNnlYWWFsTFNrdEwxQzMrcHZZ?=
 =?utf-8?B?NHk3bjBNYTVHZmdoaUxkOGdoN25qSFlQOElvWEZrK1k3UFFXMU9lV1BEc0kw?=
 =?utf-8?B?bzh4WHBqay82S2pEVzAra09lZGx0UXJkbExMRzYvdUNUT05vZXBTdUpYbHg2?=
 =?utf-8?B?RjBLMktnK0FSL3JZYmk5U0h6MFh4bTJyYmdsdlVGYmV3RGFGMTNOeGZzbWZU?=
 =?utf-8?B?VVYrYm5abmxMUUtyaHE3R1o3RmVwK3Z3aU9rbEx0eWxSVklNTWJ6Y1AzUzlL?=
 =?utf-8?B?MzhoeTMwTVM1VHhSOVRKUFV1SVB6MUVMd0s1SS93dTd6Zi8rb2x0Y2Y2VS9y?=
 =?utf-8?B?d25zVVUrU3JUMTlHS3hSaFpQV0NpQ2M5TnNvUUVnbGowZ2hkd1hFWldZMjFG?=
 =?utf-8?B?MjhDZjUrR1NKWjRBWTl5NHdwSkIzUHcwYzR3U04rWDZpUjlUcDJUQXBDT2wy?=
 =?utf-8?B?QWpKUzhoc2g3cTZKMFExMGlFZnk3NG84UXp5QkdiTjhHRHNOa0xZVDFubllB?=
 =?utf-8?B?SFRQYjMvbUhHOVlIcWpTUUpOWHdPZjI1UVJZdkU2T2Fwd0VEeS9OM0MyZ0Uw?=
 =?utf-8?B?M2lmandmQ2N1Wmw1azZnMmcxRDZTWlBzKzBoMFlRY0FVRjlhblgwZkUvUzh6?=
 =?utf-8?B?Vi9Kd2hzTEwrQlJPZ1gzNmx0d3RMVjJ5K3B2MEI0aGlnSGQySmJycE1rNnBD?=
 =?utf-8?B?bjdaYytiYUNrNzIzM2F4N2JDTEtoSVgvRk91RHR6dVpyeklxT0hWYW5qd0l4?=
 =?utf-8?B?L01WSVFiNGhTZVA3Q1Vnbm5NanIyUVVnZkJOZm5RYWIxa0toTkl1WEl3cXh4?=
 =?utf-8?B?VGNtTWgvRVVHUm42N2pWN3NrWlpkeEw3clBscVBOOFZoNERNWUZSU2RJUnZL?=
 =?utf-8?B?SDlKTDhSN25qOWdmTi9mTWI2emZzS2JoR2kvLytCaTB0cHNOM3A1Z2FmY05D?=
 =?utf-8?B?NFlEeE9CZmZFei9pMGNuc3g2a2l2cSs0NGRFUmxtSzVSc0RiN2RrNHZUVVhU?=
 =?utf-8?Q?601gUvdwBHZ56sdZE/XTXGAcp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19203005-09d0-4691-0458-08de0ccd288e
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:00:42.3044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQhAlOapK25A7S9fhhHEChmKQETWVJlVGnkDoQhk/PHqjSPuMqxSTxMtlk+gaxzotgMfVADyHI+DX9LYU7Tofg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10069

Remove redundant pinctrl-name since pinctrl-0 doesn't exist to fix below
CHECK_DTBS warnings:
arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dtb: pinctrl@20e0000 (fsl,imx6q-iomuxc): 'pinctrl-0' is a dependency of 'pinctrl-names'
        from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts      | 2 --
 arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision.dts | 1 -
 2 files changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts b/arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts
index 56b77cc0af2be51d8eb6a9b0931d977e1f267670..6665c3ee623d915f4a4a2e240478e41a23d1b0e5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts
@@ -324,8 +324,6 @@ &i2c3 {
 };
 
 &iomuxc {
-	pinctrl-names = "default";
-
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX6QDL_PAD_EIM_D22__GPIO3_IO22	0x1b0b0  /*pcie power*/
diff --git a/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision.dts b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision.dts
index 2694fe18a91b12718c756c015ba99589073bbf07..7cda1f21e4182cd26a9322bc92ef6b7f88945eb4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision.dts
@@ -227,7 +227,6 @@ &usdhc4 {
 };
 
 &usbotg1 {
-	pinctrl-names = "default";
 	disable-over-current;
 	srp-disable;
 	hnp-disable;

-- 
2.34.1


