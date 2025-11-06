Return-Path: <linux-kernel+bounces-888091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BCAC39D34
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D244B3B9ED9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCAC2FFF99;
	Thu,  6 Nov 2025 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="KazQ/G6w"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B999E2580D1;
	Thu,  6 Nov 2025 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762421558; cv=fail; b=moWUN3onKfJwCuxdiQSprnMLKKxnIL6JNXmyfSb91TzeONIiEZTEuMD2/c3SMKCbfNsKeCd1No1krl+JYMbz+kAAvDsWkbCDASdDyXPse1ksOYmE20gCuUVpDmBiwfKe6K5r2BhogpK/gXD/Qe4mCayWxxsPV3bdPc9Lan8tp54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762421558; c=relaxed/simple;
	bh=TqxButCWgU0FXi/VEfH44GgU2x6505J7IlyWdIYxh5I=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Q22AeD+jWrwcNUcZJJgdV0XTsAQELxv/Pcf+fL6aUyhc+aMCxYikT/qgtRtA1QNLpAq72kjEJXjkufk7CRcuG5OJG6r8Cm9iOtwgOh3khB/G6PBfRX7lXG+ejJL6oe3cPP8Qvq3VtS+cnZfKuYQ35LEyF8VQCwuVbnoK7oB7Egc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=KazQ/G6w; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A69RqRX1396294;
	Thu, 6 Nov 2025 10:32:09 +0100
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a7g98bqyu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 10:32:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFnSnfIXwrv8HxjawL8zEKQIRHEfawzPSQ9XbjmX9Ir73lf88BVVXN4gUihB2BHxBXFpkl9d8/BZZ3qrGPTx4H7PjsQEzK/v1gz23hoZ0uXvU7pXwnl5mMWWg2bkbgSOvxjD5sv3lSw1iEKC/69LVUsShiviE2PpFGuRtG/qqus52aS2Ew34inCwzzC2SkZ0umy0eLxfejS6e0EhOKJr915Z/91Sm9T1Jw3P5Ug89iwuyg+9N0fFk8jtncNfeOwojGBfjZEZ0qwK0q9IHqw6ZyNECkim6z17gkQdQx+00MNCPJbo//eZKwnjMWnfj+GReLfYv5WEzkIw1h26mNQiTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHbUuTgWQLRYnigNUxNvzmCrVjY2uwm5sfeN1Rik5KI=;
 b=eLh2Llz0YpqKq52BNRgmKVHO8W10GS0Tqj+TxL3xzLH86j1FLGYrlrG5Z40XXUxr8y5c9SNfO4nQIJmTby2QcbHiqm7y3DRd3utuFuVPge4XFDhgbrqSUEKvL7S2bppJTzW03UtMEirW4XlD5aYKLd8biBBSd2PcpFP1d7Z24yCVQEmY1WESiIOp1Kwgt8cFHG30YGT69koOveGRryZuuvxDwkZiATw0tr8Q4FOhcOvHDaSkiebOOaaf3CVxdujZEHZtYmg2O6VJNBtuLhC6Eqyo6LSnzFD8QDo0usgHJtVQ/nMHU+bXcCnc9awpbeCKIdFX0hoFo4YaTj/0dOr8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHbUuTgWQLRYnigNUxNvzmCrVjY2uwm5sfeN1Rik5KI=;
 b=KazQ/G6w0bKRxzVKM3wrxFeYXF3v51tYBqrbOd5MAp8FzpV9KGfK4/cL8ZpiW8+geuhtOwWmVwkyHqTiBQIsL289e2x8V5DnyFO04gm9kR76enudUDKFRYnSCy1mxmxZNapCI7tLwOy5RsqeV0geXrt52Hx+nmQbdAhD1BPULDVd5AHvH4yc344czCR6omn/V04+XPoYYIB+6ELs8sbij8GOh6shDbzBKZWC5O3JREraIE47Y13DKyEawPLxK72JGNwggkznYRfpIFg8JPnBUwOP5STo306DsVpW77XXz7NcULmpSz0i0eJwUwtaMAyiMM5CX4aA+NFMatZAG+QKww==
Received: from CWLP123CA0056.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:59::20)
 by AM7PR10MB3811.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:175::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 09:32:06 +0000
Received: from AMS1EPF00000048.eurprd04.prod.outlook.com
 (2603:10a6:401:59:cafe::44) by CWLP123CA0056.outlook.office365.com
 (2603:10a6:401:59::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 09:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF00000048.mail.protection.outlook.com (10.167.16.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 09:32:05 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 10:32:12 +0100
Received: from localhost (10.48.87.185) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 6 Nov
 2025 10:32:05 +0100
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Subject: [PATCH v2 0/3] bus: rifsc: add stm32mp21 support and config dump
 debug entry
Date: Thu, 6 Nov 2025 10:31:47 +0100
Message-ID: <20251106-rifsc_debugfs-v2-0-f90e94ae756d@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAANrDGkC/3XMywrCMBCF4VcpszYlF4viyveQIk0y087CRjK1K
 CXvbuze5X/gfBsIZkaBS7NBxpWF01zDHhoI0zCPqDjWBqttZ4w+qswk4R7Rv0YS1enO4aCdC+i
 gfp4Zid+7d+trTyxLyp+dX81v/SetRml1Qh/J0zk6R1dKIq0sbUgP6EspXwqfV3esAAAA
X-Change-ID: 20251104-rifsc_debugfs-5053ea033ce3
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000048:EE_|AM7PR10MB3811:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd13790-f53d-4708-0f69-08de1d1759c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHpyUFM2QnhTVFpsbTcvOFVneWxvV0h1blZRb0gyeEkwczY1dHlsTFhQcmVM?=
 =?utf-8?B?Vk9DbGFtRXlrTHlTUWtPRlZjcEx2aEp4SDNMMkh4anRNSXVlcGZYbGxLYkYw?=
 =?utf-8?B?U2tkcjkwWXprWTZUK1BGaHlpakhNV2paQldSaGhZazJDcDc3d240TkZ6NlVL?=
 =?utf-8?B?OTJWdytBMWtNZzdvYWR1VWlJb3NSenpGSnVKWTl5R0ZmV0FZYWZVWkw4OWhl?=
 =?utf-8?B?UXh0Z2RvZVlHMTFic2w4T0xhZmRZcDZ5Qnd2RmwvUUNDQW1UQTlld3hrS3JG?=
 =?utf-8?B?Mm1jclZhM21VUjdSR01NVWduUW44Y29zamE4WjZXellZaGhUSmlOdjkwZ2h3?=
 =?utf-8?B?dkpkMVliejBTMS9wUlZaSjhNNmlqclZFMElXd20ydUtablhuWFBaMUVHdDZ2?=
 =?utf-8?B?S3QxRHlUbkZiLzRyOCtQczdGNFhBMlJqa1hEalpoM0tNc0wwS1lxdktSdS9W?=
 =?utf-8?B?cURBbXhYbXkyajQzcFZQcVNGeklpc1BuaXZBaFVIUHRvNlJIcVpJRnpUWlJo?=
 =?utf-8?B?MXBJY1lDYVRYcHZxanNnVm1CU01DUnNzaWN0azRQQUdmRXA5emI0TTFsZTRE?=
 =?utf-8?B?TTQwMGlTMlQwc2hURXBEd0hyODY3TkwxcDdZVXMycDZrZzdHVUNHQUJQZ0xF?=
 =?utf-8?B?UDJNbzQyM3pZbWJxaXRKdS92bjExUTJnM1hiNEkwRlZLNXpCY1J3VVpZMUU0?=
 =?utf-8?B?ZjNUM1l2SVVPZ0NNVW90WWp3bXFMMGZIRDRCdE1JVzFYSzZLUFo2bGUvb3dW?=
 =?utf-8?B?ZjRaS0Nlak4yWStuUkxhQjM4SmdxUGZHWVY1VWxKMzdSS1hGMTBNU1NwdUN4?=
 =?utf-8?B?STBnWGh6a3JHWE1OaE42Vi9pNE1Sb2RSYjg5UnV5MFdpTUhkVnFoeE5wZEFZ?=
 =?utf-8?B?YTB5UmYrck4rV0wvaVB4TjlRREQvaTZVV0NRRUZoaEZPTXJzZHBkZ0plcklK?=
 =?utf-8?B?TS9Lb2VPSEtOVTFKQkxyNmdLdlhxek5sVGF6NHMzQ1d1V3pGVE5EUytRRlh1?=
 =?utf-8?B?S2ZwWFpXdDZYcU9OalBiQ2NWWlRqS29PWCszS24rdENUOXR1Nk04RTgwYkpj?=
 =?utf-8?B?QTltd2x3clhrditheWxRNWtaNmhtNTc1SngwK2FXWUFPWERRMk12NXg1VGhS?=
 =?utf-8?B?Q2xMNnBQTmF0NWYwbzdxSHhLTXNmTEl4UHRGMHYyb2pERCtLQU5MbmF0TUdm?=
 =?utf-8?B?Z1ErWEtkUFdvenhJS2FMQ1p5SVNSdU8vWWl0QnV0RGo4QUVMamFqNGhxcjRB?=
 =?utf-8?B?RTJNYzkrSFIzdlhoSVpCbUdFK1R1cTNWNU1Ca1VPT2JJdUhwUUxLc0tkalp1?=
 =?utf-8?B?aEdYcTkyRG5rOFA3Q25lTnF4dGphOWNwWU44MlUvODk5RU4wbGJWU2g0NnNv?=
 =?utf-8?B?MEJ2ZDl4eDRsTFZIVCt2Sk9lQWszdGNQdEJocTBwUEpEUllWSXJZai9sUU5X?=
 =?utf-8?B?OC81bThyZ0hTWEQzSTFHNjBtRGZLQVZ6TDVhbGowZE9hdDBId01MbUJvKzI0?=
 =?utf-8?B?bVlBcEc3UnJ1R1hPN1JEanlOUjhITDBBbDcwYmpLMWllS3BnRHU4Z2xxK21U?=
 =?utf-8?B?c2puTGxpZjM0d3k3VmRheTFEVlgxU3Q0a3BmNmhpSFhpc080dVpXd3JOZ3ps?=
 =?utf-8?B?Y3FGTVJGTmowbnYrdjFKOHVjaFJCTFlhUFBCVUtOR3IyZ2lxZFg4ais5UnNC?=
 =?utf-8?B?RGZPRVZXTHUvVW5pRnVqZ2kwZ3h2U2I5RXp3Zm9PS1RaRjhQcXZKaDB4S21L?=
 =?utf-8?B?R1R4cGV5MHhvV1NLWHRpN3FNQ2grdHllVTlTL1pwVDVFOTcycjlONzNsN2Q5?=
 =?utf-8?B?VnBvdWdpRS9Xak5GT2pFbXcxWnFvRWtuS25QTm14cDQxRUk3OEVzcktwd0VT?=
 =?utf-8?B?UHVVUUNiSysxNC90SzZTVVpJMVJ4WUZXNWZNTi84YWs4dGhRTE5CTTRoZXNa?=
 =?utf-8?B?OXpsRzJDMlFKeEJDVmV3M2JIb1JYYXh1aVRRQW1GRVRVbDh6SVVIcWV2MkN4?=
 =?utf-8?B?b2tGdWRCNkcwRWRBaXdmWHU2U2hKNGlEckJRL0tGMjc4Z3RqYUtrbERIYllJ?=
 =?utf-8?B?YnUwNDRkNlNYbERrWmFzaXFHNTVOdjlOVDN2dWF6UWxiN05teWNaWWFDZEFS?=
 =?utf-8?Q?/FpM=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 09:32:05.9784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd13790-f53d-4708-0f69-08de1d1759c3
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3811
X-Authority-Analysis: v=2.4 cv=K+sv3iWI c=1 sm=1 tr=0 ts=690c6b18 cx=c_pps
 a=TZl03fqgByJezl61SFqjKg==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Wpbxt3t0qq0A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8
 a=Qt6CvwFM3zD-zW8HttkA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: LKiyMUiLTx_JiqqZam_MZ06nzBO_YZKc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA3NiBTYWx0ZWRfX+HqBTIvdI8dZ
 v/edLRbyLRcpVkUbqCoFBvKCPByldbHUnyuP+fpMO5OSOwC2/acPn8WnvDYBaqfDxzwUkrZsa2n
 GP/v5I2tLrsxuXaT6RdaaoluchSkXOSBshu+YbqRm1cblEZIkOUUzIGeNLjG4ashAwqfPT+Kxdb
 kxmlPRe/zzEuYGr8t4/cxyPLa4N9nSKPnHvZWt2+NZ20zSa6Ztp++3YpcZb9BbGiQlaN0EZmpq2
 AygkpZa5QL9x2i2GYWXSQG07bv7u6TXjYc4K/VrLawvbWL9q9u356LQWn8Gdk5CM8mUoPfW8QTv
 JKtCIqpL3FjyNX4suPE6u1+qKMYPUybI3yBWZZ/870+d1O/NJAqtWpb53Jq/2KE7UJmhyFL+vMi
 MxYC7IRJlR01oX45+YItxKsbnsIwqQ==
X-Proofpoint-GUID: LKiyMUiLTx_JiqqZam_MZ06nzBO_YZKc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060076

The STM32MP21x platforms have a slightly different RIFSC. Add support
for these platforms.

Also, the RIF is a complex firewall framework which can be tricky
to debug. To facilitate the latter, add a debugfs entry that can
be used to display the whole RIFSC firewall configuration at runtime.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
Changes in v2:
- Added Conor tag on bindings
- Fixed coccinelle warning by using str_enabled_disabled() when
  applicable
- Link to v1: https://lore.kernel.org/r/20251104-rifsc_debugfs-v1-0-7ebdfbf8d33f@foss.st.com

---
Gatien Chevallier (3):
      dt-bindings: bus: add stm32mp21 RIFSC compatible
      arm64: dts: st: set RIFSC as an access controller on stm32mp21x platforms
      bus: rifsc: add debugfs entry to dump the firewall configuration

 .../bindings/bus/st,stm32mp25-rifsc.yaml           |   8 +-
 arch/arm64/boot/dts/st/stm32mp211.dtsi             |   4 +-
 drivers/bus/stm32_rifsc.c                          | 597 ++++++++++++++++++++-
 3 files changed, 602 insertions(+), 7 deletions(-)
---
base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
change-id: 20251104-rifsc_debugfs-5053ea033ce3

Best regards,
-- 
Gatien Chevallier <gatien.chevallier@foss.st.com>


