Return-Path: <linux-kernel+bounces-784136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1043DB33717
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5E5189E523
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B902918F1;
	Mon, 25 Aug 2025 07:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cSwobdjI"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010053.outbound.protection.outlook.com [52.101.84.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B411428C864
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756105263; cv=fail; b=dBUcl+sVQ4t5g3vhath6RQSE7Katnvp9DOaiafr85CLLdl6PoRPxJaBgzNdgDyCZHl93I/XtXNYlFmGs7oDnU/2afeE3U/+YV6ArQptBi3mi3ZUy79HdJmAaYUx19jWURFxUfCJBhClUj66cTzWdB+f4C4LA0m0AWUgPk7djx/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756105263; c=relaxed/simple;
	bh=iBj6YyLjqW69Y7lGXyVpU3vupD5OBS4/DxBywCzUFPk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NG5UIQJQJKMWw4umQU/wK2mo54kHXjwk/dAAYR3ygCE6CMH6ie6vA/WpCGaI61Q32B6Zc3PVu9ieB8c8RxAbus8GdQ8bSE73bj7cmcBjl7UnsZdnnih7pUaDF8emIZ9isb7Q2NpobjcR1g/fXuZZxIx4kJwsIt/xzQ0YxfsCp4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cSwobdjI; arc=fail smtp.client-ip=52.101.84.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpae79SWtmOAtznU4PEvc2vvVuAN1JS42otAq+TdhYJCJJ2KGEWyjXmEv2Zeka4so+sg6JFJSU4mjTV0AucpQiQ56Q4IBNWY7R1+XoHUhIZ3KVvdp7xDm66XHFZD5DyoWVKogsHnRKF4cL52ClH4PwQtTAZmApLhyeqfjzFbWQywIoL6swYNELkLjNZ9RmztwAhY2S1gaJXVVLBSIF33oL96iCtKBedIH4l4ttVbjwXOmSowu+vOFYaf7rB+UWoujeH6z9aVhNFMLt1UmNYHvyqR7Li/iEmiv5PyAisb1XBU2ci223l+xn4KyiKqtCqwzv/14vB4icUM+h7jErXQaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9T8wLAj4cZZm0QR7xzfaCORhcp+3bi1l3IDBkZYPjO0=;
 b=YIW+0FcMnA4Rt+/IpbFdq6jC2utZ2M2JZrmYcuStDFn30Tw5s8Gl+wA55cvC3SMo3mBqxLE98gGb3HxJrBGR9DI5+v4FSC5U4/y3ih+GUxv+6SU4qxvEslrwKT0glIuzDGnd3Nrzw9VyjZfQAlKOhrcuophFYG69/tXYJ00QPKQB9BKM22TjZgaHFxgOHwNgRvUuqkDXBJ/3CYm+UJmppelB8zO0crFAlG6WpHMX6gzaSDamJC/e2XwOq7tGtuv4Sc0Xmua9xd/+9ri7Rrs4BR+DmZCUA2uvWu0FDGb+6P0ps/hZMHSL8+XKi/OISOk16ztp1XFWFmbCB5+MteaEqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9T8wLAj4cZZm0QR7xzfaCORhcp+3bi1l3IDBkZYPjO0=;
 b=cSwobdjIQqNn4awhJlqwOzgrNHzd1TX2yDMCnTb/i21XhZF/aH7amV9yV4/wRMnz34WMCRtVHAmiGEMiEQZoADMd6Wtnc+pRBhhLp4YI7sO6Dvx7RL+LNk1s/vfmmf9fH6vATbjj9MvFCRWMMkNz1M6B8UnYMGxodxm6F7DtBJRkFJc/OYTenk5Brpadf2n5DYZYrQziJHpLR1USL46huuTsHawnxm0r2M9tHqgkMvtcqykmur48cvGH1WJsZbv8m69t7ZAxlQo9VCwSw/L2IftHMN7Z5SIPYbysowyGjRCRQaYKvWlx3Xl0SKolwj4synRfD5rnyvmo9nph9qeMnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10217.eurprd04.prod.outlook.com (2603:10a6:800:228::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Mon, 25 Aug
 2025 07:00:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.009; Mon, 25 Aug 2025
 07:00:50 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 25 Aug 2025 15:00:30 +0800
Subject: [PATCH v2 1/3] firmware: imx: Add stub functions for SCMI MISC API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-imx9-sm-v2-1-0bae0265e66a@nxp.com>
References: <20250825-imx9-sm-v2-0-0bae0265e66a@nxp.com>
In-Reply-To: <20250825-imx9-sm-v2-0-0bae0265e66a@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756105242; l=2097;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=iBj6YyLjqW69Y7lGXyVpU3vupD5OBS4/DxBywCzUFPk=;
 b=uAkm/2omRv7KKxQJGgYOzVFKRlZeS7V+dj7wdItQa96uA+sBosmobK3cEyofcEJKK0Iun25Xx
 U575Xy5l3w8CUQFNGNo3Ey4vcy0yjdS5EFozw3PNHiGGDcyYc2acIzS
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10217:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c324e5-7c5f-4a1f-2837-08dde3a5204a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cCtLOEQ5UU55SUcyNG52L3FHdkRsbjlvQ0FlWUk2ZlZjVm9XaCt2Q080UG93?=
 =?utf-8?B?dkd4TCtaMUpVMndKZWl0ZUdydUV0VTd6bVQ3SEtUQUQxNTNVQzB0SnQzS2p0?=
 =?utf-8?B?VzNWaUtKcVQrRUU3N1ZHMktsdlV4dGk3UXRCa3VrVGdIM3BMREQwNUd4S1Bm?=
 =?utf-8?B?Y1Z1TWxxek53VCtscW42d0Q2U2I1bWZKdGNNUVpUWTZBWXdjeFMxdjh0Y3p1?=
 =?utf-8?B?NDVkejVLa1liMXNTMHhsRGJ3dmtQY25YNUdqUUEvOGdWcVhCZ1NqQ29hOUxL?=
 =?utf-8?B?aFUzQTVOSXVjVzVKaXh3Q2R2QVA5K3hDWjBReU1hOW54MjEvVjVrME4zVHB0?=
 =?utf-8?B?SlZFVWptU2VKd2RjTUhoNlBDNmVUWU9HTlI5Q3Jpc21UZTdHeEljSndCNVlx?=
 =?utf-8?B?UklqdUJzelhJRGgzbTAyRTRJWXROMk81blNJNFpDSmdEdXB5bU85M0NRYlpy?=
 =?utf-8?B?QTF0bjQ3VE5PTEFSeWhPZEc2L29LeU5PVmdhUXVtc1dLcGhYS0hsT1VFTFJR?=
 =?utf-8?B?dXNhNFp2amJpUGV6VndXVEExS1NMZG5RR1g2RnQ5bjVoZ2pUcVdsK1FBcEVl?=
 =?utf-8?B?OVRxQjhnSVFNSUdmamppYlJrd0czbzExczlTNStTWWRrNkoxdXc4Qlo5RGFX?=
 =?utf-8?B?QTFWK0ZwOXV0ZzQ3SDd5ZW9PcTdvbm5RTk9FVXhJYXZDNGxnTTBSYlhuMVlj?=
 =?utf-8?B?Y3dIZG8rclVXVjl5Wm9pSDQ0cXBLNnAvVnlSTm9EZmpQUzRwbW9DRzRueXVF?=
 =?utf-8?B?MitlVWxXUHF6ZVU3RFBTZnRBZUpTWHcxK3E4WXdncXIxYlJ0b0VFbGhvSG5r?=
 =?utf-8?B?VVppbnR6NEJjTXFzNWRnL2tHSGt2T1hmYWtvblZ4YXZuLzJqZU85REhYYVQz?=
 =?utf-8?B?eWxreTRtaWxCSTlMT05aWEdIc3FEelZMcUJ4QWNkMkZZcXEyUUtqODNDNzJD?=
 =?utf-8?B?cE9pSWVNQ1dGMHU0YlFiNWwxRUdld21OVlJJQ1JIejVHUTlzOHRDaDlUbXBH?=
 =?utf-8?B?Ym4rZ3RlLzJJWVY1WkR0VnNrL3ZtejNyMDlDNjdoWnlVYWFkSDNvWEZTcHdw?=
 =?utf-8?B?a0JIWno3Ti9OZFE3MUh6V2lHWVFMK0dERDgzamw2cjI0ZXdhRGhvd29aWStk?=
 =?utf-8?B?NGNQMnRheDd5VEdkckwraW45a0RLQ3g0UTJ6dGRBK1Y3dnFQdzFYQW1BbDJT?=
 =?utf-8?B?OHczOVlMeUFJK2ZzaU5NV1BSbUZjbG5YK2VCWVFZS0FHYk9Yc1hUUVVReUtW?=
 =?utf-8?B?cUl6R1dRWlJ4Wmg3aXVyc2hNdng4ZmdiTXcxWDMrUnI0Z25idU1qY0h6TWdI?=
 =?utf-8?B?VXJlaVdvZmkzWThMUFVISHJvL2lpMEZDMXo3WU4yQ1JUN01OTCtXRUFNbUpt?=
 =?utf-8?B?ZzBNYjI0L2VDcVpRVktvTUpYeXZJTUl0TnM3bGRMTnFYSnk4eURnM21MWERG?=
 =?utf-8?B?cFdRWnRINVVzUjVNOTJsb21uZ2VvNEhsdnNHTjNZcFpKZ3VSUzVXUjZoVytk?=
 =?utf-8?B?OFI0eXVnZ2dCQnR2NEFCQ0dNYUJCSkNUQVdPUUVxVnhIVnBlUGFzZGlOVGRB?=
 =?utf-8?B?QzlZKzVDSVlvUXhWSzlwb2FwK1ByR0V4cGJMc0Y3cE1mM2NJZGFFNS94b3Jq?=
 =?utf-8?B?emhGN0xWMnRQRUNUVGdOcDJ6RCtHRUROUWtlS1huV3NvVmE0ZWRBa1VxVnRj?=
 =?utf-8?B?YklxQktjRTVvZ09LanZSTXh1M2gyS2xvNE1LS2w5eUpGSlZ6MWJKM2dicVFR?=
 =?utf-8?B?Sk1aR1lrcEViZHVCMDdyL2oySy8zUHg0Z2dMQ1czTFpGd2xsSXhYZi9nSSth?=
 =?utf-8?B?U0t2UVpkWisxZ3NkaXd4NXJkME5ZNmRRbm95akJaR3pvaU52MEh0eWVLeFNZ?=
 =?utf-8?B?ZVVDNzdKblBJemJ0VFdGTnk2WHVkYmVSam9HMm5kcEpOVEFFT1hMMXhRZkZ5?=
 =?utf-8?B?YU5JcnNia3d2TnY5bUc4OEU5dmltVXg5dVpqTnlYVTFlSWI5VnZjdTNWNmwv?=
 =?utf-8?B?cmJ3SDZUOWRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHM2TmZ4NkRsMzZkTFdHREtyMG92aTZPTTZTcndqaTJoVExBR1JQTjJhY3dR?=
 =?utf-8?B?UVFPYlN2elpQMGJJNDZWYnB5c3hERGF6cFFvS1J2MFdIQjh2dzBLUmhuYjVk?=
 =?utf-8?B?NUFFa01nSnpwYU9OaThaaTVabm1GNzFLK0I3MmJoLytYcks1eXVSRlhxaFM5?=
 =?utf-8?B?Ky9tK3VIczJOd0R5UDdTd240ODBadk9lL0p5Q2hYTURyOW9GRGN5bGkzenlX?=
 =?utf-8?B?bC9lYXpjUTd0UFhFdWNvQWZPNDVPUk1lUThMQS9QUnd3NkVGR3dVZGtBNy9X?=
 =?utf-8?B?YklCeDVMcXp3ZWs1RU1MaysvL09jVTJMeFlHallGcXBXb3dhcExVTEZnY2d1?=
 =?utf-8?B?bzlzOGlXOFNzUWVCUG0wczVTdGdWK1VQOTl5NU1jT3lvSnAwb010d1VFWnph?=
 =?utf-8?B?a29rNi93ei9SSUMxeTAwckxqZU1NWEdJM1B0UUV0OTEyWmNsSVJmQ2tJK0dJ?=
 =?utf-8?B?anFOeCtWcloyNHJYVWdpRWRlQVJReTIxVm5PZlM1VWlTNDhMVzRjQ3VITGVq?=
 =?utf-8?B?dVhpZlcvenRKUjN5MDRSQXFVeVFjM1RiOHRpQng1alVtSW90RGY5T3A5ZG9X?=
 =?utf-8?B?L2NuVkxNMWd6YWRuRXlNdzNhdWd1Z2ZTZXJRMzZBR3dkRXVQd2FUUlFUTGRD?=
 =?utf-8?B?eGtnUk1jK3lsZktlRWhpZnNEZk82RG40MHM2c1JldElKV24wQ1MxaTR6M1ZG?=
 =?utf-8?B?VW5YanVEWTd3aXFON21UVmpjOHA4R1JNV2dIVS9pNzFqZW01Qi9ValVIK0sx?=
 =?utf-8?B?SXJKL2FiNE1IZEV0N01KNm9pd0tKczQxekhRbjRpRlVPaUhpL3FSVVFIOURR?=
 =?utf-8?B?ZEdBM1NVcGxud3FvZ2pMaWp4L1R0bUYwbkhRU1dDb2FiU0txbXFXaWhnRUxV?=
 =?utf-8?B?Q2VNU3hYM1ZlcXMwUWpaUWZ1eXhUdUhTYW4xajQ2REhmemQ3NGM4VlEzSWlo?=
 =?utf-8?B?a1hWeDVTZmRjbnVMdkVQMDV1V0dkbDZKQUhhK3ZuVnZwMk9teUxXWkRKOU81?=
 =?utf-8?B?M2pqTTl3c2RqU1J4a21DQ05MQmV6RndGZHYyRU5nQ1VuVWJGV0Z5UzQzbGk0?=
 =?utf-8?B?RUVKdng3eGczcWllOGQxVldSVzRTWUkybXZFbGxodWR5bStWTUwxN1VRNnRG?=
 =?utf-8?B?cHZSd1pkQ2dyV1FlV1d6MlNMZFI3cEpSVXk0dEM5bjk2MG9pbjFOTUFtdTZ3?=
 =?utf-8?B?TjM5UUE4YjBpVnQ3ZXRmcDVHTmkzUk5qSlJXYjAxM2J1MS8xMHFuU1MxcXNo?=
 =?utf-8?B?elk5L3VVT3dYRmduMzNKOXo5UkpYcjhFbHo3dUVCSjNEOUdjMkJzb2pWM2hx?=
 =?utf-8?B?SUl6dkRWZmZBVXI4cVd2S2VWN3ppakkzRDFFNVRidHB5Rk5jeUl4V1NqYi9t?=
 =?utf-8?B?T0dLV3RvVzdBY1drZkFqcFBwTThEZmF3YUliSGxzME4zbzQwL2dPK3RMaUlR?=
 =?utf-8?B?b3VpNVVGOXRUdC9aemFnaFo3a1poNzdWTDJuaE5xeUthWGVKQWxpMkw3YlJY?=
 =?utf-8?B?NVZZRVNDQ1JMNFpRZzlMWSt4RUFQVlZnQmlKZ0xrY0tpKzhnSGVDQi9wKzNL?=
 =?utf-8?B?ZXB5NUNpZWJjZDAweGtocEFtYWl5THVuTHVqd1I4VW1HNXUrNFVXbFM3aEhw?=
 =?utf-8?B?QldmRjM4UGJhTzdXOVgxa2gvOGNWdmxlc0pkN0VXcExIeW5uNTJFdmdWZXZ2?=
 =?utf-8?B?V09MWEl4S2huMzYrZCs1R3R2c01KTFo5U2xKdjdBZ0ZwKzlhYmZwcU8veHU2?=
 =?utf-8?B?d093UW85MCtMNXJyd2tDNDdNRmZveTBhU1pPdDJ5RnpBM1ZyVlovTkUzUlVP?=
 =?utf-8?B?S3dhSkw3eXFFYlJNV2ZoZnBqdy9ncDJDVmlHSG04QmFzdDZaM3hCSGo1dVQw?=
 =?utf-8?B?WUdSOWlSLzl5KzFHNlRCdEJ2M29yRWZ1MmwxSWttYUJFM2xSM1Q5ZUtOU3RH?=
 =?utf-8?B?a3Z6c3Q1Vy9VM1dUSkJzYXR1dyt5anlGWURIdUI5YnJYUCtEdDd1Ky9iTjlU?=
 =?utf-8?B?ZnpCREFwdEJqTGU1cDJ1TjEybE9PdTBIeUxZTVpyS1VoTlVHLzVqbm9lOStT?=
 =?utf-8?B?Q1gxcWdzdFd6Vkc4Z3ZYd1VOWTd4RnBXVVBnRnh2WFhjY0cyM08rbldnWUVU?=
 =?utf-8?Q?YkpDBqzEA94HVa+NW0RqvwzuL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c324e5-7c5f-4a1f-2837-08dde3a5204a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 07:00:50.8865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuYVeFGKy39uKzxNmxAtGt0OmmZeM0si6N3sJg7gtjOWOlm0fYhDD7gOU4kKrhOH4R2tn0H069Ois2bftRgJ3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10217

To ensure successful builds when CONFIG_IMX_SCMI_MISC_DRV is not enabled,
this patch adds static inline stub implementations for the following
functions:

  - scmi_imx_misc_ctrl_get()
  - scmi_imx_misc_ctrl_set()

These stubs return -EOPNOTSUPP to indicate that the functionality is not
supported in the current configuration. This avoids potential build or
link errors in code that conditionally calls these functions based on
feature availability.

This patch also drops the changes in commit 540c830212ed ("firmware: imx:
remove duplicate scmi_imx_misc_ctrl_get()").

The original change aimed to simplify the handling of optional features by
removing conditional stubs. However, the use of conditional stubs is
necessary when CONFIG_IMX_SCMI_MISC_DRV is n, while consumer driver is
set to y.

This is not a matter of preserving legacy patterns, but rather to ensure
that there is no link error whether for module or built-in.

Fixes: 0b4f8a68b292 ("firmware: imx: Add i.MX95 MISC driver")
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/linux/firmware/imx/sm.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/firmware/imx/sm.h b/include/linux/firmware/imx/sm.h
index d4212bc42b2c17fb8f94d58856a75beb5611ce4b..99c15bbb46aa8329b5aa8e03017e152074cdf492 100644
--- a/include/linux/firmware/imx/sm.h
+++ b/include/linux/firmware/imx/sm.h
@@ -26,8 +26,20 @@
 #define SCMI_IMX94_CTRL_SAI3_MCLK	5U	/*!< WAKE SAI3 MCLK */
 #define SCMI_IMX94_CTRL_SAI4_MCLK	6U	/*!< WAKE SAI4 MCLK */
 
+#if IS_ENABLED(CONFIG_IMX_SCMI_MISC_DRV)
 int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val);
 int scmi_imx_misc_ctrl_set(u32 id, u32 val);
+#else
+static inline int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_misc_ctrl_set(u32 id, u32 val)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 
 int scmi_imx_cpu_start(u32 cpuid, bool start);
 int scmi_imx_cpu_started(u32 cpuid, bool *started);

-- 
2.37.1


