Return-Path: <linux-kernel+bounces-874778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E68C17115
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D016E1A24523
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8732DE6FE;
	Tue, 28 Oct 2025 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mDU01qTt"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013007.outbound.protection.outlook.com [40.93.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52222C1586;
	Tue, 28 Oct 2025 21:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687448; cv=fail; b=ELfCCEOys3IaN5txPaeuqId0wGOY4gQOo5/j91GnDjXTnB73TYBNjz+dCN8oX3DFhsKqNW2DiqTLVvSlqwOr81Z/wrOQzBcUFwXTSHaRFjsu7R3n2N1NZpaFWNPZw3O9po6NFZR9SAjZnlx/PEDNvXP3vCb3AGStqJXIpio4Xpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687448; c=relaxed/simple;
	bh=CeyLl7eR3UIhMox7SY3wElSaId+WsDd1xZvo9xoM8WQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gT1tHhlje3Yuu0a8PzEf0UbZj+DA64l6MFELdOBavpFm0/7auh1PC5sz1MHHgcfSxmHBReEkHD16VKk9sdoMNyWsg5FcMdHz9fDLUG7tdqinRYe66VVFFhhBkKTg+a7pdhT5mjAKeAWfv7ZNHTfm+cDp6djcCEqv9TKh+PovTKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mDU01qTt; arc=fail smtp.client-ip=40.93.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGWRf9fIu8tk7gOO/owNpurmsTkTa8gYGLM6PCl9YTJnIVCUDoIUQwye5yoQvI3uI1YuxA53GQIaPpqkpQso09SVQ6anBIIHe0Vtr15TNl7wzXB66W0oDFKzKHI6zpEiae4EOVpCjXhLmbl1CHxh4dzI64i9QhlrUTQoOSjlWf2QloGyU9iwbLW2ZpL3Ocht+a7i+aD8rLg7vf/sIwag/noQ9x6+QXzzV5MqVcy/LzrQVuQfjorH2k7sQB+m9p1Z75D+3KTQ22feswHiZ56Sy3PpLf1bUiSr+XRJiWMUJmGEdSSS4a30SGxZHOsHtXaIn6FSrHp9tyh5w+GhN3g03w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/Y1W31NfCvbQutoCV7/vpSp31y3fdqnUiQ6y5E6VJE=;
 b=jSn7c+GLtWIWT4XDq/RdeSodC4a/eMwijS/PKBFMCuar40NRcp9KWiMv1NY8Vy2Xr7seqnmo2E4b2I8aLCbID1uh1sfZmtkPObPE17tvU1hyRlX6mk7TOhY1eOcibRBc4lLvJdZ9zGaLxUPROHp++2AXb8bhOlPtaKB4LvG8PRmJMiAVBZaVe134GMTSaaZqGWW784anj5QiYmA83y0oKPzaB9BtlRFmVTNDZ/I969L6iLwdEfuqIkadF1FvKtZUVkaQlS+2fKxX1i1DEj/lNVu+h5eDSZlvzpeK3MM+I4ml2UDSGXVeUF4TJkAXSDgY5u5MFczk6ncOlO7C8V/G1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/Y1W31NfCvbQutoCV7/vpSp31y3fdqnUiQ6y5E6VJE=;
 b=mDU01qTttW0Z9j/kYx+cuWXHJr+q8guKaSNL+LB2z8G6FKUMLTmXfexjeIqrPHVt+bsPSkzG6mmZhv6kbCQBqzxU6rsgGhCMVOidzFeB1Vy6VRp5tBOPzviwTpdEGTakJAoaInzFr2P5M0GC3v2FK1xKGmCO3LMmJU/A3GgtBrw=
Received: from CH5PR02CA0002.namprd02.prod.outlook.com (2603:10b6:610:1ed::14)
 by SA1PR10MB6341.namprd10.prod.outlook.com (2603:10b6:806:254::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 21:37:23 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::7f) by CH5PR02CA0002.outlook.office365.com
 (2603:10b6:610:1ed::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 21:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 21:37:23 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 16:37:20 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 16:37:20 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Oct 2025 16:37:20 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59SLbJo32949068;
	Tue, 28 Oct 2025 16:37:19 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>,
	<s-ramamoorthy@ti.com>
Subject: [PATCH v2 0/2] Add PMIC support for AM62D
Date: Wed, 29 Oct 2025 03:06:43 +0530
Message-ID: <20251028213645.437957-1-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|SA1PR10MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: b7cff15d-47a3-41d7-d086-08de166a2e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|34070700014|34020700016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3IvR0xkbVhEdFg2eldWVmpST2paSkEyU0VKckdOVFlYR1UrYzlTMHI4bGhv?=
 =?utf-8?B?VFk5Y3hlbm9XMWdObThtVWMwWHNQQzlJdmhmZnJLcTA1aUc4SmdyMVFNWjlK?=
 =?utf-8?B?SWEvQmdXVE82eXl4SDY4YnB5TVl5eEt5V2hudWdjdGZvdTJOUUJHZHYzWDlz?=
 =?utf-8?B?Zkc5ZmFvaGRLRFhmNTlwcDI2aGw4NWhPU2RVZ09hMEtGQUhTTDg2cmVjcFNG?=
 =?utf-8?B?SGJFbzZDTGdwOXliUTlLampVM2VqK0Y2QUE3VHJtcW1SbXF6ZGNoWkcyVDVk?=
 =?utf-8?B?WDJWV2tnUWlpM3BBc3N0b0xJZDA1bHdlTDhkK1VRTzZiVG9VMHEwSDgwMWdS?=
 =?utf-8?B?dkpxMXQ1RUIwMng3YzErSWdVY2lNN0l4WGtzbTA0S1ZLTmR6MEYxa25DQmJu?=
 =?utf-8?B?emI3SUV6Ny9LZzVPT3l0Q0NybmZWNUFvenpwcEl5VFh3YVpvblJSRUJhL1Rp?=
 =?utf-8?B?NCtNRi80c0VzN1gxUzI2YTA0ZjMrcjU3emVraGxXWXJPVzlGNHpLYktrc2VE?=
 =?utf-8?B?M2Uxdk0xbllKZG1rUDdFbHZrOHRwOHRvWmNCYVdZRHh1UTFZc0wwSGVMbFlw?=
 =?utf-8?B?R0JCZzhCeENWWVp4TmtFNFZGWTZNTDNUVERBUEprYlgwK3RGTjV0clFmUTZS?=
 =?utf-8?B?bVJCZXJrRXMzS2ZzQUU5eU92YUw5SDRHNnhpTk9lYWx1K21MTlFTT1psb3dM?=
 =?utf-8?B?QTVXL2hWWUF4VExjdDIzODEyNmV6Z01wNEw4Z0gyN0d4V2Y2aCt5SnN5K3lL?=
 =?utf-8?B?cVZoODk1S2l1UHR1N3hRajdvOERjWCtTU0syNTVOMjFOeVZoenQzZGpoSm9D?=
 =?utf-8?B?NnhWV3doc1NpcUxuVjNKWXlpbjFYeDV5eGUyMEJWRVgzRlN5cHMrWGw0MWJW?=
 =?utf-8?B?T1Zza1kxTmxLRmhlOUNTeko4SS95ZmZFNk9zK1h1UTRBbTFqMXFCR3UybEdM?=
 =?utf-8?B?bDExaXR1djBURjhwMHhHWnBUMWt1bjdXZzh4WllTYVorclI2ajVYZGhBejRl?=
 =?utf-8?B?UWxXY3B5K21sVU1UY2hWNEZiRnBBeitOeUhhd0F2TjFNWFgzY05hUE9zblhx?=
 =?utf-8?B?T0MrcXA1VjZwUDFOVVR3MWxqcW5rVVF2K1lscFNpaHZjSnVrMi9QVUc2R01Q?=
 =?utf-8?B?dW9FdVpoK1QvczVEUVdidVNRaVNhdm1venNYUFBzbHRDbjQ0SzVJWDJmQXVB?=
 =?utf-8?B?VWd5c1p3VWpPMU0rSGJFZ1hMVDVhSmtWdTJUYWJBZUdpTjNkdHd1N0NuV1Jt?=
 =?utf-8?B?WnNTNzByL3R3SDVtYnhjUnlKay9qYUdKeGhMMEErT3FOaFlMMVVsZE00S0d6?=
 =?utf-8?B?RFBwL3dTa0hEUWFTVHJSL1c3V0QrRnRvaGZlVzgzbjFyV1Y5ZzhodlVRZEdB?=
 =?utf-8?B?VFdhQWhWMURZeGVHYXF4aUtUUXVONXdOYVhtTTJuWlh4RFZ4aitlQ3NDN0Q2?=
 =?utf-8?B?MmdPU1R0bzI4amZiNEtpTG5pUG1xV1hHZlJUOUtWMXdqaG1JeHE4RU1nWlpE?=
 =?utf-8?B?bDVOMnVrNmNxT2Ewa3Q4RWNzd3NCTmJPWlhHWEhweWFuWXNjNFVsakUveDR0?=
 =?utf-8?B?VnhzVFgrNDcwYkhBa0RJN0hJMmhHek9MMnN2STBjbjJRKzBwdEJ2T21TU2dE?=
 =?utf-8?B?SjJxVTFSL01DYmR4bHdyM2pRRG5jTEpDeHJrU2syc1lhQTVINjZTUzBQL0FE?=
 =?utf-8?B?K1A5SDE2cCt1UHM2RVZGN1FwcjRvMjNudTdzbjdkemxBNllHNHpFWHhEMWFO?=
 =?utf-8?B?OGlBbmFnT0JvL01XRnJNSW9ka2czdzZlWlIyUkk1bS9kWlJwZW1IeEJxM1lp?=
 =?utf-8?B?SUsvK0NxUTYwOXBVNVJ4TTdMaERQVEp0NkhSSnZRY3hNdFhvZ3ZiSHN1YkZK?=
 =?utf-8?B?SndkT2xxZlcvZlUrbGs0a0Jtd0NhNGl2Z1dXZGxlc3UxREx1QmYwTi8vOUpu?=
 =?utf-8?B?amhFV01SMzNUV29VWUZqN2YyQ0RCVHNjZ05BYkZIRHlucys1ODZXRWpoUzZ0?=
 =?utf-8?Q?5luV4d04aU1/GSaQg3aOVkrOCOGJgM=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(34070700014)(34020700016);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 21:37:23.1680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7cff15d-47a3-41d7-d086-08de166a2e66
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6341

This series adds PMIC support for the AM62D2-EVM.

The first patch corrects the PMIC pad configuration by wiring the 
PMIC’s INT pin to the SoC’s EXTINTn input.
The second patch enables the TPS65224 PMIC on the wakeup I2C0 bus.

Boot logs
https://gist.github.com/paresh-bhagat12/11dee1b07be3019d5f92f893fa11229d

Datasheet - https://www.ti.com/lit/ug/sprujd4/sprujd4.pdf
Schematics - https://www.ti.com/lit/zip/sprcal5

TPS65224 Datasheet - https://www.ti.com/lit/ds/symlink/tps65222-q1.pdf

This also depends on this patch
https://lore.kernel.org/all/20251028210153.420473-1-p-bhagat@ti.com/

Change log
	v1->v2: rebase to latest tag and added cc stable@vger.kernel.org

v1->https://lore.kernel.org/all/20250919032806.707926-1-p-bhagat@ti.com/

Paresh Bhagat (2):
  arm64: dts: ti: k3-am62d2-evm: Fix PMIC padconfig
  arm64: dts: ti: k3-am62d2-evm: Enable PMIC

 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts | 93 +++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

-- 
2.34.1


