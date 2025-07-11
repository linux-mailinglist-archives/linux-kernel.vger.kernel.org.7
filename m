Return-Path: <linux-kernel+bounces-727527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE61B01B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FA63B7026
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA2F288C1F;
	Fri, 11 Jul 2025 12:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="AS5tKXc5"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD50727AC43
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752235297; cv=fail; b=T7lb/5QRMqOKc3nuEhX+TkG95ZII4apFhdiQtgjhHqOSZ96J8TsXoi6gaRuNH8n8Rx50IwWQ0YGCJYXewG/7gvmOrmeGilYIJxUQ4nTfEg9/1UAnQZ4lFmCGcAOzuAtwbu9B5ki2isBKbg071P/hX5gpnEoosYg9RGweJ1vZgjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752235297; c=relaxed/simple;
	bh=JK1YU7vrA4jzIzkmhhrn/QsxdsaSkSX2s+X4Jf9xBvo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TAA9pgY40up50v4Dwgyf5/XXKRZlg12BnkV1ErhjS0bBxbzRFxKG7fHfnsraM60IeJAgN1nbYARhhL9zW81kVXRXVJChjHFrB8GabZMgtjJ9BJCDFnv0LWHtf5NwE3WO905BmCfQQVOJHWsYZQ/G/MSouTlB1UjR3og8OFrYiWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=AS5tKXc5; arc=fail smtp.client-ip=52.101.66.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgyEHny30ZPOjqW3qS2F1ht0piZJIQvRKfmFmtg0H9ZehupatdTRMYT4MnzGFGpbklBQhbqBALcTKd7zSEe7FWJ/FGTQ+mjb65xjx1sueRbeamZ4TOuBTLl5fONcmKDMdgcPzZgHIBYhx8l+y6PItioxrysFv3WuR0OC0ssck7F5F+j9ylHDhT/NkKQ2vz07ju96M6utg/xs9S6mVZVOi2keEueknDBXKA69AIHcyeoECp6tThBz0gLSKjcX0gI/+y7BmH+jv+VNErd9/vwamzYcaC3omnAwjLlyob6lp0GhZOc9Jza2w1lKd4mZ7cAT0kM+yMh5D/Ls3yRoNoI+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JK1YU7vrA4jzIzkmhhrn/QsxdsaSkSX2s+X4Jf9xBvo=;
 b=iSBywuRe+NKUHVUxVmURWD6Cl9QuS8t23ACYkir/do59cs3d7V0PTVzQUVzCXoCF/KVfj3YsSeToouZT7YI0jFcuuooQIrfHJjCa3DaPBM8RL98bpNHoLYzCRnD0gSqlaVoI3uC8ubA4rZMMSGJswXukRqIhDQYugG1ouejoeMPZw+7QKZdqS8mcgl3mqLKPLGdQGPB0WLvqUcbTUtDdvOXmDRSRnNB9ZLtSbFItyjAwOe5xACdoTXlW5kfbAmACexKIW5NaHpNbG18kSW69J2oFysdr0H8ydAtbm+c9mC/NgtRV8PpuvHvh9zQeMw3DlTPOKTXO7KvLqsksNaRzoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JK1YU7vrA4jzIzkmhhrn/QsxdsaSkSX2s+X4Jf9xBvo=;
 b=AS5tKXc59BTuA0GOQ13D0i851g7DFFDPoOcDoTaU2x/kdHqrk4cPNXVc938o/gV1S4DTVq7jlln3NpZQz6aIEsX0iBa+mpQuaciYvbIa3tcBBCIsAgxQgKggjQfjIxf2R77ytXDDgetoZdPcZXMrr4dXNWB/iJUNmIXSEb6hpBs=
Received: from DU6P191CA0062.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::11)
 by DB3PR0302MB8941.eurprd03.prod.outlook.com (2603:10a6:10:43b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 12:01:31 +0000
Received: from DB3PEPF0000885F.eurprd02.prod.outlook.com
 (2603:10a6:10:53e:cafe::a0) by DU6P191CA0062.outlook.office365.com
 (2603:10a6:10:53e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 12:01:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB3PEPF0000885F.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 12:01:30 +0000
Received: from N9W6SW14.arri.de (192.168.54.39) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 11 Jul
 2025 14:01:29 +0200
From: Christian Eggers <ceggers@arri.de>
To: Srinivas Kandagatla <srini@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Dmitry Baryshkov <lumag@kernel.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
CC: Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha
 Levin <sashal@kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] nvmem: Fix reading MAC address from OCOTP on i.MX
Date: Fri, 11 Jul 2025 13:55:46 +0200
Message-ID: <20250711120110.12885-1-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885F:EE_|DB3PR0302MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: 0498dbd7-bf44-4e34-aa03-08ddc072ac71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmgxQXlIZCtlRklTbGk2MzdqaS9jd3ZQZGFmU1JBMkgvWm4wcmRjcDlLaUli?=
 =?utf-8?B?c1B6cHovZGhrMk10czRNcUtja2RBV3M2ZkRxdExPeWRRR2RvZDVuUXlZUk5N?=
 =?utf-8?B?TFVmQ3R6WDdUaHo3aGU4MmZDeE96aWxKcFRRWE8xWVA5eXZaR0grRE9CclA2?=
 =?utf-8?B?TkkzakFCRDQwOTBwb0wvOEJROGpuU2xLeG1ubVptS3lSOFE0OTJrbmEySitp?=
 =?utf-8?B?VjRwa3NJQzdnSmhrVGdIVlZjZDlVbWVMNDQxOWVRU3oyT2ZEZWhMMDNRYkN5?=
 =?utf-8?B?cndQUnY2SkJ6aVJ0OWw5OWhqSzJOYkg2OHJWdFgwaEw3TFAyVFdOblpaM01I?=
 =?utf-8?B?UjJtMWQvNDdHMlFRTjhQejVkSkNnTng2SUhHR1pHYTlZS05idVB3T0ptYVFk?=
 =?utf-8?B?MG1Tb1NkVmo4OW5MVE05eDgxS0ZVeTFIL1M1M2F3QzVNeGNSSXhzdEowZE1V?=
 =?utf-8?B?a21sQkR5RlFDT2dmR1lxUnpTeTZkQzFvOEFUM3RIZ2U3S0ZzSUU4dmZtL0xz?=
 =?utf-8?B?Qkc5RzJRUkJnYlBnMktFOW8vN2x5dFJtOXREK0lKWVIxWnIzVWlrVE1yanZt?=
 =?utf-8?B?eUNmYy9aQ2E4WENiY2pjczV4WVVia3ZTTnNGdFZHbjBkWkg5Lyt4bmZMVzlV?=
 =?utf-8?B?ZmpoS3RaUWREN0tTTStkSzZXOWt4UXNTOHhueEFnd3ZTUU42YUZkVGcrcjVK?=
 =?utf-8?B?dFg4ODYrQ3RtOUNRVEhkN0JYREl5Z293WUJJUVJQWG1tUVV4UXhZcDVBTFYw?=
 =?utf-8?B?UXRWZElQT0lwMjFYNTB4VnJ2cmRFMlQrRWYrU0tSU3lJd0NBenBDT0pKY1Fu?=
 =?utf-8?B?Qzcxb24rNlJyS0JXaUVzb3dyeU9kMnZIS0VHdFArbmhRNURXQ3plSXhhajlO?=
 =?utf-8?B?N3dvVmgxNlRuSFZXQTBpWTlYNnNKM1dtbXdqbTRJN1ZnZHY5RmZaazZmRGVo?=
 =?utf-8?B?ekZrRVhvZ0NVbTB0Nlc5eHBrZ3JSLzU2dHVKSEdjaDZsSTZBeXdIK0hrbWgv?=
 =?utf-8?B?dWUvRGtPZ0ZETU1PaEtqOHpBSTJKRVUvSlRZS3V5U21YQUJ0dDJRcVdvckRw?=
 =?utf-8?B?ZnIwTFFPb0xON3IwdG5RUk5meWo0ZTlITEx1c2Z2Q2M1OGZNMmVhOHAvK3Nv?=
 =?utf-8?B?dklhNHNFL1l2N0xZSS84dFJlcXlPNFYwNWdtUTJRaVcxWE1NV3Q4WTdPNHI1?=
 =?utf-8?B?cmhTSWF2NGI2KzFVanZoMERXV2x2RzRRZzI2WDhTYWxhUVZQNHFqUm92bG1H?=
 =?utf-8?B?bklKOWhQWmxwTlM2QVFVbDE0TjZWQjZ5UzgzZnlJcndxdzBZZG5XNFhLa0sx?=
 =?utf-8?B?bUpSbW9DWFRCb1IvSnFIUkpBdFZkQWlNS1JSMk80bVZIcjMyV2xURzdqOTFm?=
 =?utf-8?B?ZWJ2L1hzbUVmeXdIaU9hZUlDbkFmNmw4U1NYVStkRDVzQXo5QzNZQVM4eXli?=
 =?utf-8?B?SjZ0VVgwcXpEQU45VG05UWRvRjQvcTg4RHVzZHhWMWtIVTBESDBRcVpvZ016?=
 =?utf-8?B?cHY2ODh4OWt3RitzTVFzQW4rbmx2SzJiOW1HK3FsOFpBaTltekI2a2FxN3lB?=
 =?utf-8?B?eTZ4eHhwN2srMDFhbkpoS3JmM29zQ0VkbTkxRDV4OUcwelBDNzVRYTZPUStR?=
 =?utf-8?B?TkNyUG5HYzJvdnBiaDlzempXaHh5S0NGd2RGVG5ySHRWYVUweGpVcU1qZGJT?=
 =?utf-8?B?SzN3ekZmWExhVmNYMWNQY1hvZFRZbmtjdERYZXdUc0MraFA3VHhRaWNtWFNS?=
 =?utf-8?B?MDVzZnZMTVIwdWg5dktxSE1HaVRwVUt6TmxtNko4dTNVRjUrWVZyOW9sQW5M?=
 =?utf-8?B?WlZlTmJ0WnQxSnVDcGlPVVhuT040aE1iU21tcFIvQVRHQkd3bTFnNDNaUmJC?=
 =?utf-8?B?OWsrdWFWT1EwS0NMcXNsdklvNWZOQUJmVk5XdU5JZGN3VUFsM0lHbGNOMU9j?=
 =?utf-8?B?VVEvTWZZZkRjNnRMOWFQZFVrWGRwUWNEeDJONzUwdHFPaFdMMFl4MUVxbEJG?=
 =?utf-8?B?bkhNaDFuODd3S0d6VGs5VTA1aDVHYzJTNzE1eFdadlByeU9odHBTMWZ1ZkhY?=
 =?utf-8?Q?gzEwNC?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 12:01:30.7699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0498dbd7-bf44-4e34-aa03-08ddc072ac71
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB8941

There is a (minor?) regression (also propagated via -stable series)
which causes wrong Ethernet MAC addresses read from internal OTP.

Probably this doesn't affect many system as usually the MAC address is
already read from OTP (called OCOTP on i.MX) by the boot loader and
then passed verbatim to the kernel via device tree fixups. Only if the
MAC isn't present in the device tree, the kernel reads it from the OTP
itself.


