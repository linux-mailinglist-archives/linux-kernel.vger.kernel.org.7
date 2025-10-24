Return-Path: <linux-kernel+bounces-868265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F4FC04BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71FE84FABD5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871E42E36F1;
	Fri, 24 Oct 2025 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RHef1+l6"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013061.outbound.protection.outlook.com [40.107.162.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AE62E6CCE;
	Fri, 24 Oct 2025 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291152; cv=fail; b=lL5I1i+eoaYUNyixdE7UeDYrYqSajdauxg5g85Te17Yl/qaG/E2GYLwlqB9NYZJqKrtDsS3EzOZw758c8BH3Pn6DT8i88fOCIipJzDlWy4eB6q0peq37GLqEllSphLLUJY5qhMUjgjbMKvw1NmYQkXPSDN3kppqeMiOyJpoWEhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291152; c=relaxed/simple;
	bh=wPDTHI107/1camTME/ACILxmBwR+bBoJp87picLcW+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xp/l6pYOLmJ0Xp7ANg6WStuBnnro6EfXT0CPQrCTNRK5AutG83m6EaI/KaTX8ssfPQw6vGg/0qWaN9HBOnEQ6ud+5bJ6WuSzbSwNKWDM1MWMRZz8xrmPA4qofJK7YSUD7hFT3rTxB+Fn4gosw8Y5qFyjOsXaHuBkR8i37C0ZBE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RHef1+l6; arc=fail smtp.client-ip=40.107.162.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iseO4+8+DSVFqarBprJLRPIZYfDtBl3Q0Ty9riIUy1fFfwa3pkBvQTJuqP0KpbmND/abTVkCGUpps1Hcyg76RtSni5O0qXe9gx8UpAc3WQ8UPY/sbmeADpzUiTqRDe3jcObr9cTWJc1IVaNydgcw5gfW3JNuv/IUJGHzTdrCv7AijFLDrW102oDsHP1H5Ovj+1aINxPKeQBS7cwgermB5fw1Z41Rc4fvl6DoxprJgj9GDg2icnkzjZdaImuC1gDMsBVin4Z8PkRIEqT03ESjTbIFQc664b1N6zK2d1Ionh3J+ULL760/s9BUg0awhZQjPGueL68AXsgS23CWDemTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f61Ph8MBNeb1hdeOayiSHAh6b0cVa08mcRKbRioJF7s=;
 b=WJtxhUmvZaVL50eWrVfCMU/DXiL0apOrmIqj6dJ4yhoMQSjh9ci7meWbdl/ON4WYlUj+Djf0z+pmRHD2th8pj6qumL6FyalKIARcB898TuPLHrq1XEGsAg0rP3HwYYIQKkXJ7l4BNOFKQJ57Q7bHNB58EPAIOkzI0J1pDghbpah6pIgpJs6J70UGTzEVH5YD7RWEiwD2WvYa/vXnzT8PhaTaJp3/Vsg/ogs9eHvFRwlYI1ori1tcUptiyZmZLssXeElE7GUIbk4ypSNp8sF0MX8Zi+oLuBZe8RWh8MwF6hzLyuryJT1rcWS28cNZpaNikvRb5IDDhZOZKTDDD7fz1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f61Ph8MBNeb1hdeOayiSHAh6b0cVa08mcRKbRioJF7s=;
 b=RHef1+l6uEc2Wb74dSHxI8stMgflWxADiQ52WzHcy6sh5ag/eUN0C9w3pFZQBbG/G5QF2Nu7Xw+IHT/HtSyKfTiuWDanZYy1zvhPGaBW8XJn1Au6z6WG7rau18yq9DpHUSUNp7cqpc+tQ1HPmSfEiSu5jZJQuNZvzUSyMQShP4XtEg3nxg9fV55Q8fofUP86EVMBoyukwnIKEAd5YuqW8q92zn4UsF6Ey4yQItHVytJu66BEukC3y/y7+A1rNnvYHFAxfZiL7SoBuW+mtHhJSmDuClpDOExdWjvcETPb1zPtmJDpYufSnCIyGsPma+7gAkeO3hZXQ9yS2tyH6X8yOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DBAPR04MB7432.eurprd04.prod.outlook.com (2603:10a6:10:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 24 Oct
 2025 07:32:27 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:32:27 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	frank.li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: kernel@pengutronix.de,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1 1/7] arm64: dts: imx8dxl-evk: Add vpcie3v3aux regulator for PCIe M.2 connector
Date: Fri, 24 Oct 2025 15:31:46 +0800
Message-Id: <20251024073152.902735-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251024073152.902735-1-hongxing.zhu@nxp.com>
References: <20251024073152.902735-1-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DBAPR04MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1421f3-3049-4b8d-4845-08de12cf7b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rm1IcXFPQlJGdTBnQ0pnNGhTUXprZWx5S2R4VnhEakI4K05rYnFQdkIyQ0Z0?=
 =?utf-8?B?TmpMZmp6ZUZXajBLTTZSV3JtaXFDMDJaN2NlaDk0MVdnMlVyT1R0SUZlSlF4?=
 =?utf-8?B?bXNzLzlpVzhBUmJxZ2tZd0IxdDJ1S01DWnllM0FNa1hudmdxTGZyek1MZk04?=
 =?utf-8?B?alJkT1VXREpPbzhYRm03Z3c1Yk1XYjJrN0puMGhWVVlBV28wNVZLQ09ibkhY?=
 =?utf-8?B?TWZNR0txY3VITGk5SHpHUHJzVXhDSEFNUzJaT3cweklDMXNMcjBNRjl6TG9j?=
 =?utf-8?B?M2xsNXptUGI3SVBteXBKWkF4ZHh1Vi9OM1dQOU43RWhBQ05DSzRsYThvdkhV?=
 =?utf-8?B?cS85ejJRTHZhTkZNdnVRaDdPWHpSZnMyR1B5RmkzYkRCOG1VamJvWVhPUlpz?=
 =?utf-8?B?R2ZvTUlUUm16T3ZPQVVoN2dhekRuNC96ZWxpelBiY0NiYjNtZkwvTmRBRE4v?=
 =?utf-8?B?dVQ2VDdlTnlMQ051VGVKbnBrakEwZ3BPOEQ4d1BZajNKRVNZL0lGMjJhOG01?=
 =?utf-8?B?LzlEK0ZiU0JmbVZHcnhzSGpDVjJFWTEvUDRObGl0cWZNK2lOcW82YzBBK1d6?=
 =?utf-8?B?TTZMUDdrQk9xamFPUmhEeFhaVEdET0FIb0orelVyQTRYUmw1SDB2V3lVbmNy?=
 =?utf-8?B?WXBsVTcxU1M0S3pENUdYMm0wSzZ4bEZvVmFwOWhHV0tFRDlYaCtPdjU0TEVv?=
 =?utf-8?B?eHp0M3JzOWVNb0FySHZlcGRFeTNMM3BzQ0pDaGhwWnRFTW04MVRJbTdPNFJI?=
 =?utf-8?B?V29FM0RKaDVqMVV1UEhzQ0pGamZOQXdwZ3E1RFFUak9yNzh0UnY2enhhaW5S?=
 =?utf-8?B?Y1VBMENkTGRaZWxBWWs0NGJRUGphRVV6dVNSbldwOUtOSk9FcWRTQzJkZ1RT?=
 =?utf-8?B?bVF1MjFCMU03M0psT1NrZU9ZdWNXeGtLb3JmTEtWZWlkbTBZV0lPTzZCTWhU?=
 =?utf-8?B?bytiZXJIODhwTU5xcjhMV25nN2Z0ZUtSaWhzdy90SmttZWdTMi9aNk9EYktI?=
 =?utf-8?B?ZkZiN0JqS3Vkem5jUzhFNWxiYjRIdUZsbHAwRURiLzkzdzNFVEhzY1hLVjhC?=
 =?utf-8?B?VWlnc3FsSGFYQWhhZHJXMlhVRmF4T2t5NXdQaWIyUFVKVGxiNzl0bmJmOUxa?=
 =?utf-8?B?RVBJZlY0aDBBZGdnNXBYK3dsQW9Cb2o1alU4UWVZdUczbzE3eVFBQ0Iva1Fm?=
 =?utf-8?B?MjJlZEd1UEwwa251cTB1Smo4N2ZZUjloaWhyRkY0b3hCNWtkUXpwWGY5OEIz?=
 =?utf-8?B?SUZ2bk04OHpuVzhlUU04NkVOc3RFMU8vdzhwb3AxMmYyZVZQOGwzQjVEcEdL?=
 =?utf-8?B?b0dpRWlCelA3RDIyT3NFcmRKbFJrTjcrRDV2V0tFbHVXUzFmVTNOcDFXV0w5?=
 =?utf-8?B?b3NWejRmU2tNYVZmbURHbk5jUXpsSEQ1YnhMK2VrY2FQSUtad3lHc0Z3RWoz?=
 =?utf-8?B?UUNHUGlPVTFWNXVJWmJJRkY3bGlVWVBhakxUYUZNTXpzMjNOaE1Gelk4RlZq?=
 =?utf-8?B?ZnhZVndhSHdrd2MzeG5ZK0gvdDJZSmlKZ1k1UEZ3Q1lXK01zMlRhVDZnNGt2?=
 =?utf-8?B?cU52aS91VS8yUlhVcS9KZmVjdy9vdmFlZGdac1hJTnFRczIvaFFCSDc1dy9N?=
 =?utf-8?B?MFRiWXFQRGpYQ1M0Um8ra0JQOWc3NzNEdSsxQW5VaWxyS0Z4c0RjZEswOUFt?=
 =?utf-8?B?dUVSUXZ6QVEyQnlnYnJROU83c1VTWUUrcEEwNkJwdmowSFBNZUVjMDFhaTUw?=
 =?utf-8?B?Zlo3U0x1TTVPRlR6K1F3R1c0Q3JXQUUwWEdVSWgrdXhVdTE5eE80MEFkdFgr?=
 =?utf-8?B?bG5kRWpmQzNNb1g0bXFaYUxoUlg4Q2JXaHFOcjJ0RW0yd3l5TE4zYlFPMytj?=
 =?utf-8?B?SENVT25iWFRHQmlBQldaK0Zhd0NIbFhSZm1hYklMeHV0dmwwOW9KWHl6TWJJ?=
 =?utf-8?B?Mm5zYmxQSVplZ0NubkZGWXFnMlppRVpjNTZJSGNrWjhDTnV2eXFPQzl6YUdL?=
 =?utf-8?B?UDRTd0J2ZXFhYUVoMEJ4S3lHcVpyc2cyR2VKb1ZnN2Fjd2RJOUlXYnNwTERp?=
 =?utf-8?Q?6wpFEr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkloKzBJcmh4by8xaWpQRGtOUW0xUlVaSDRmditSU1J6bDF3RVFBeUNxcmdR?=
 =?utf-8?B?aDlGbXBRaC9XN1hJZ2V1dlBtWkVXTGwvcksyNXVkQU5jVXhOOGZpMDZyUDVR?=
 =?utf-8?B?Wk5LUzIxSVM5OXE5SW0rTVFQY2YzWnY4bUVIS2x6QlB2bXkrNEt4aEhTRzRJ?=
 =?utf-8?B?VlFDblVNTi9DT0R1dVhEVlFYOE15ZU1NTXN1dmRBZk9NTFlmT3RXdEJrdlhn?=
 =?utf-8?B?WUNvbFdxTU5Ndk84ei9IbGRuSjg5TVZkb3JMRzZhbVhBWXZZQ0hSTHc1QXRD?=
 =?utf-8?B?QUxqM3FxajRRaWdZa0dSZ2JMZWhwejFPeDd6b2QvNUJ0dGVUZmRWdUlqNlRu?=
 =?utf-8?B?Y0hvOEdycHZVSStYMGJKeEZ1cW10S0N2YmttVlZYN3ZoOVF0NTZybHhkWUFj?=
 =?utf-8?B?YkFaNFRsT2RkNjRudWJNdU1yWE1oWXVhOUhwSkdJVUZVUGN4M0VLdnFCRlQz?=
 =?utf-8?B?TkdxbWI3ZXhtNGNTdWZqeG9IaFZ5NzNuL0VMZzZSWkJ0VFFZU3Q2cCtiQ1Bx?=
 =?utf-8?B?ZXNyUWN5OGxwWm8wUm5qUWhKSFdRZnFnRGRrcUtISy9LdFd5NW40ak1PdjhJ?=
 =?utf-8?B?Q2tLeGdQNm1OTzIvazZNYTBLZVpBcXFJYkNZM01FRGYxM0NWN1lKUk1zRmRt?=
 =?utf-8?B?NzNrbmpCUTdHK0FadnFYaUpCTkdZZHlUdW05bzVrZmJoNWluU0V3ZEtDeE5H?=
 =?utf-8?B?NGhHQXQ3ZWpsM09meGhKSWVobmtFdnFHdnVhcVJkdXQ0MXJJWk9hOStod1Mv?=
 =?utf-8?B?VHZhMys4WUxMS1ltMHdoTzQvLy8vam5aM01CNnpMbVRjNWdNRE1QMUtSVjN5?=
 =?utf-8?B?RFk5djhZT29rQWdmMTFleXFUaGRaSFhRMkRvWnB1YU9tQjNTdmZyaTBYQllO?=
 =?utf-8?B?UHRteEJ6aVVoZVFKY2RPR2VjZENQTTFZc01GWE9zZkZ3UGpzNDJBSjJpUzZB?=
 =?utf-8?B?bi9zMnBFY2lrd25HMSsweHRod1NMalQrSjUweE4yVzJzK0xmQWFOdzl6cExP?=
 =?utf-8?B?NWp5VFhvMWEwSWFHc296RnJYeDdjeWFpcVdNRmxLLzk0bW1qWXlmM0J4OEhs?=
 =?utf-8?B?VG9qellJZHJkb2tMN3c0MGdYK1dXdHhWYThkLzVkSmZTcUNXVWNVM3BSSHpn?=
 =?utf-8?B?VGJIZzBnclBNVDR4b3YxZlBwd2VCSWdiKzVtcjJJTXJSeVlUVXpIMTBGZ3lZ?=
 =?utf-8?B?T1J0WnNCMjRFOG5yQWo0NjBhenBSbE9mQWVKaEpyK1ZJV0o2a2VEcmJlbzJ4?=
 =?utf-8?B?RDZWTlhzbGZCbTNkWlRLWnc1UG1RczNxcWs0VGZBTE5zV0tETlcyalovbHV6?=
 =?utf-8?B?Q1JXc1Z2SVc5TnVnV3RyRklCVkZjb20xSnAzMDM0MWZwclNSVHE5T29kU0dn?=
 =?utf-8?B?bjVPUDZKT1JlUlREeDQ1OCt5R3FYSVhYa1NEWWlNZUVielBUR3dzZUhMT1RR?=
 =?utf-8?B?OTdKaGs1dG9lOWRidU9BczU0VWVNa3prNCs3SFVDNUJOVmJrdU9nQ2s0a1V1?=
 =?utf-8?B?SFJ5MW44Y3B2NHZlQ1dReVRBM05MdUdrWXB2R0dNMk9EZHlieDJ5WkwrQ2pK?=
 =?utf-8?B?ZjViYkQwdlJ6Nk4wblZjWjRjdXhZK0NUOURQS1F0dXMxZzdhQXAvMUFXZnM2?=
 =?utf-8?B?MW5oNWMwTXo2VjgzeGhXd0daNkVMTWxqU1ZsaTNyZnU5TUcyS3ZsMkhVaWFH?=
 =?utf-8?B?ZFZ6aFczN013TUpKUW04eExEMGNIN2FuRHlERTVmRG13cUtKbG5oUW9jbE0v?=
 =?utf-8?B?eXdyWmMrTXliNzVnVmJ3Tm4xOVd6T0VSY2pFTHN6YldHSnp2Zk5Fd3VrbkJT?=
 =?utf-8?B?bFAzeCtYMDVPQ01BRThEUDNLampqZG9vZ2d1Z2FxR3RvWkVjM2R0ZXhkWkRE?=
 =?utf-8?B?Uit4dGdUdUR0Umk0K1VCN2lhc2tjUnJFdEh0alliVkFadmRBVitpOWR3MTVG?=
 =?utf-8?B?aXc5NFNQTWUwc0xES1I0anp0TStNeC8zRTgyUjZpWHhEN1BkVlZ4eW95UEZj?=
 =?utf-8?B?UkxxbXNmTm1iSEVJVEkzS041RngxNEVxOExPWG1hTmpXdWRmVkNadlFOeU9l?=
 =?utf-8?B?dGhBZVcwZk1HV09DTFpzQjZ0aWJQd0c4M3Y3V0VIU0xyWUtlNE8wVllmYW5Q?=
 =?utf-8?Q?ul1RhZQv6KsX9a4k8AYsLylJs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1421f3-3049-4b8d-4845-08de12cf7b44
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:32:27.2470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Z+TdAbbhsergab8ps4Ft9KlprXe88bWP6TmAnRQEz9gBl38p17D3ZjjeFg075am1S3qrtNBISX1OXURqzkhYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7432

Refer to PCI Express M.2 Specification r5.1 sec3.1.1 Power Sources and
Grounds.

PCI Express M.2 Socket 1 utilizes a 3.3 V power source. The voltage
source, 3.3 V, is expected to be available during the system’s
stand-by/suspend state to support wake event processing on the
communications card.

Add vpcie3v3aux regulator to let this 3.3 V power source always on for
PCIe M.2 Key E connector on i.MX8DXL EVK board.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 25a77cac6f0b5..7704dba9e37c0 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -649,6 +649,7 @@ &pcie0 {
 	pinctrl-names = "default";
 	reset-gpio = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcieb>;
+	vpcie3v3aux-supply = <&reg_pcieb>;
 	status = "okay";
 };
 
-- 
2.37.1


