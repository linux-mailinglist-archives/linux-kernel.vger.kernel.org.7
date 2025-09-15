Return-Path: <linux-kernel+bounces-817348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47066B58103
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FACF16864E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE45D21B918;
	Mon, 15 Sep 2025 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="M+0WyrYh"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB94922258E;
	Mon, 15 Sep 2025 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950566; cv=fail; b=NP6KBqMjH/kk85F1r83x4O5ZCAtMRGuHwUU21S5n5svxV7IHUaz2gVWsBnruB/KlpsM63KnfM4ajJ/FI+AWo7bTF2Du1HiFyCymXH23L1RU5ZFS8CqskiaOMUeZJOiMe1s1sJUinzJ8YZtj7z1Cf+AbEJjVHtRid73XJ23XY60E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950566; c=relaxed/simple;
	bh=HJ2Mi0/1AS8PfOJuIuaBrQbsT7YShMGIMYznkpL5S3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CXax2+HVayH9y/Su/IYOdRXMLJ0qZPi8tjP6dw2QLnm/Aj6Gdd/Ovyl7OjtIl75CljMAV7pTJSVUM3AkNrYscZabd4LvrUnSqUOdJ39D6jh9BxYEAdczM6XeFuu5Kv2N+A6rjuChzgDf1MWXdcHi2OK65SZidkYlnhuH2qHIyU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=M+0WyrYh; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FEimYe032663;
	Mon, 15 Sep 2025 17:35:49 +0200
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 495kjnn8x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 17:35:49 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZFuU8w8p2JFazfDwp1lFXRQAbnYzaJnFPUO7DMROcIAfla4pPc4GV2/Odu0Z4xh76DdMtrttbIOlqyutUZh8SkRQHDsF/9oXf4Stx1ZRXDvgud7eTCnBvD+Xitv05MneY5tH0y/3Iv6PaT5AgazByRB0pV5uUbynsAPIXhB1BuaULZ9ohjv6FxVlOSro8qE+C32O+RCK+lHxCi2RiTaeZINhHd51ouQRPu25TfVhR7WqYzuy90tvYQTCyD2B7/SltU2j5aDpdhh814t6rNnaPQdIJCzYxZFrMzusV98/mI0g0j8lsfXxMk4caUQtvK0q/eO3gjbAkbtajujP/mE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IeUyxnmukjcnyCuB446526rY+tGjvpX9Akzz1rrT7w=;
 b=E/xAFXEo5sbj7/RnhX4Lwbs3xBKWlcfCsqBdtcLTODLxaJAB7yW6YJgygYoVrzdf5CWpQy7RbpvebhdqcZUhxw7oAHZCuQTBDuJJkzVzEMRZ7R+RbyxM4fDfWrgE+XUEA1t2P0HEHwwCZPAnR92Is7l5UdQDQusJ+72nkxckAs81/211SC6W7ITtBa7b3KirCBf06veB0yQJduZmeqwpqiJZQrFUZw9b5a3cIHjcOXUR3Xubf2UbgG230yEShqSnIPwnb+izF8n+DPzoGqK94bsqSIPxy2LEewy+PeZzw3ZTxpOvdrelw3OnIAF1tC+mRPuymAOs+hsdmCVidS0cfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IeUyxnmukjcnyCuB446526rY+tGjvpX9Akzz1rrT7w=;
 b=M+0WyrYhSiRPhGrFy3kI8yaqbp0w+hg6G3qMGq/9MmTPtt9PIHm8y57H5NEDkCMdm9dpN5G2aWhRJOIm2dDpRgMxir/Qb/b9vNjt8WVdHQOfeSXb9U/0zC24BZzCaohweHZ1RO8tZIKorVnBK/qIqK2xs5A4ws6x0KNTcJNV7kVSgkVKHUY8lrrftveHCWjVU9JtoFGzqRnXMAlDyE20AsWBL9yFuU4iXvBp5n3WgsALHaV6I/A77TcSbyrGrE/L8v8Q/e6aHSNM7vHn/3jDoeiAg+AZlTu5T9XSQAWLvfeR0nqDt88fihKYjVTAhSSV/eORqDQ45rYO3DlEuF1X4Q==
Received: from DB7PR05CA0071.eurprd05.prod.outlook.com (2603:10a6:10:2e::48)
 by GV2PR10MB7990.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 15:35:43 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:2e:cafe::72) by DB7PR05CA0071.outlook.office365.com
 (2603:10a6:10:2e::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 15:35:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 15 Sep 2025 15:35:42 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 15 Sep
 2025 17:33:12 +0200
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 15 Sep
 2025 17:35:35 +0200
Message-ID: <3a1403d3-5cd5-49bf-8b21-692497a26b6a@foss.st.com>
Date: Mon, 15 Sep 2025 17:35:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] arm64: dts: st: add ethernet1 controller support
 on stm32mp23/25 boards
To: Gatien Chevallier <gatien.chevallier@foss.st.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250904-mp2_ethernet-v2-0-05a060157fb7@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20250904-mp2_ethernet-v2-0-05a060157fb7@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|GV2PR10MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b125b3c-2a81-4d9f-a786-08ddf46d87ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlhmK3AvZHJkMWI2OVVvcUIwRytFWFNFS0I0Vk40OHRVSWJaWnlDWjZONUd5?=
 =?utf-8?B?Z0VCK2ppd3hYVU9zU3MxaXN6SG5GeVFYVmI4dkdOSTJacjZkTmZjdEtNTzI3?=
 =?utf-8?B?NnRNUHQ4WXJKRnVGak13a2lldk9IR2JleHlhR1FIcmMvV2krQlgza21jOUpt?=
 =?utf-8?B?bCt1UStORHJzTWxVVFk1WTdkVnRSUElMdDFyZlBFMGtUcW9iajBocndWL0Fh?=
 =?utf-8?B?STJ6UmRYOTZmMkt2emwyaC9RUFJ4WWhBSzgwY09FT0J5UVptblNsWnlLTkpC?=
 =?utf-8?B?b2wrL1ZDRnJBbjhLYkhaeUxCQzdvZDdGTUdWT28wdlg5RG9OU1I3TCtWa2lj?=
 =?utf-8?B?NS9VRWc2dStPTHdTY1NKTkFJcmpXZFF6Mkc1Z2NFb0Ivbm1qYk0zTzB3RFhW?=
 =?utf-8?B?bmVaazNwYXl3QTJwTTBpZlBzc3prMDN0SnA1WUlUVldoWnBENUhMc1d3M1Vn?=
 =?utf-8?B?YnR4TE5NbHVjVFE3RGlOYXJhdzBoMm5DNTFKcnZMQXVIcFlrMEVEa3dzaUFG?=
 =?utf-8?B?OHJNdm9DSm1SQlk0dWFSL2o1TlVVRktJNzZBUWJ5TWxKaU0zMWFZWjZwaVNQ?=
 =?utf-8?B?dTRWVlhvdU9NNHBLejU1RHlpTmFSamxvQXNmRHFLMjhteDNCT0JXdTZycjZQ?=
 =?utf-8?B?aWgwZ01pYXlyOGRuamd2Ui9qakJjZzRoMzA0NFYxUEU4ZTJ3SE8zZXQveFV6?=
 =?utf-8?B?c1RzQXB1bFo5WnJzSmNrQzlZWnp3bnI3TlpwN011aDJrNU54eGljYVpxU25t?=
 =?utf-8?B?cWZXWTVkWUIvQUltcnQyVWxwNmFuU1g3d3QrT2o4ZUdpbE9HQ01ya1pLUCtB?=
 =?utf-8?B?L3Z0RTgyMFZocEM5TXZhb1RhODRvYmtHN0hhQTNPaDg1cmhCZ3ZLdTA0UzFl?=
 =?utf-8?B?WjVJbjV6ai92bWZjSUE0ZjVYeER3V21HVWxFcUtTSFp4MzYzS25sUzhXWENC?=
 =?utf-8?B?ckRmWUhJNEtmZkhOTldZeXFZN2hkdlZyTHVIdXhYZm5PVVR5L0dxRi9HZm9D?=
 =?utf-8?B?bXRlUFJoY1ZKTWVBT1pyTkEzQlNBeVk3QjVPVU9UZFlVa2xpUE9KM2RHcTAv?=
 =?utf-8?B?b2J1bC9ueFF6Z29DNVFhSWFlT3VaQm8ySnNsd1FEOERwTUJnSUhCaGxqREdI?=
 =?utf-8?B?eDl2UjBrM1FBbDFrakoxejFtNUl1OFQ5T2hEODE2dGJZejkwNExYRVExbnJN?=
 =?utf-8?B?UzNIT0VBNkE2NXJPTGRSdEkzaFR1dUQ2dmY1cmp0SGZSK0kyTXZ5d1V6Rkkv?=
 =?utf-8?B?U1IxMDdZQ0c4NTg3SHB3TjF3NUlEamc0N3NFdVBXQjV5bTQxMjNrM0NkcXY1?=
 =?utf-8?B?VEMvM2dmUldMWUtvUXl3Y3RheTVpV3BiZFZlMm42SFJLa3dSSlpDNVNXTnRk?=
 =?utf-8?B?eTNrZEZoTksxOXZ4UnNhcHdtczFSKzN0QllYdnIyd0kzNDNwRU1rN1AzdVRV?=
 =?utf-8?B?aU5DYTZ0ZHZRRG0xNlBXUGxIcSt4VElBWmFHQWRxYTQ3bHo1QndoaEt3TVg3?=
 =?utf-8?B?OGxHWU85S01zanNyRHFyQ09odmJuelNldWdIZ0NjMmM0Z2pCOUhRMld5cnFI?=
 =?utf-8?B?M2RPb0Nyb1B2VmE3WHR5ZW1FbWozaUhTTnFzNnltNk9RM1B1elk3UC9zNEwz?=
 =?utf-8?B?ZlRWS2pteSsyclh0QkxXcFpWa1F3dEVyWlFRR0JxRGJRbGRldXJDVy9FYlVs?=
 =?utf-8?B?dnhIeFQxNW9ldHhUYVVxMDUrVitsa1A1eXp5cWE4eHVnMzQyalRaRVJxalpR?=
 =?utf-8?B?UG96WWJKZWEvTWtWOUFiVlBpeWt5M0tUVlJsOXdPTWxkdk82TUpaTkJQRVdr?=
 =?utf-8?B?ZVQxMXVKTlNQclUyYXhmbndvQ3pqMFdlSEY4V0NwZURudXN1QWtCbE9yVEtK?=
 =?utf-8?B?Wko3NjExZ1pTK3lYazY2SW95QkZ5TTdPQW1xWG5aSEJIUmJ6L3owdHdJa2Nj?=
 =?utf-8?B?MjFaL1dNZTNlQU5jRmo3NXptcHQ4VTF1Sm9wQXNOOVR0bTNjV3lvUEFrOHdC?=
 =?utf-8?B?ZjhlbGxjUDdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 15:35:42.4398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b125b3c-2a81-4d9f-a786-08ddf46d87ed
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7990
X-Authority-Analysis: v=2.4 cv=ObaYDgTY c=1 sm=1 tr=0 ts=68c83255 cx=c_pps a=383bDpamuXABF3/M3Waz+A==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=TP8aPCUxYTYA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8 a=PfGPvkhpduPlouAW6xgA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: sUANwz1SOAeOSzzVCknZbQuUw7mrjE66
X-Proofpoint-ORIG-GUID: sUANwz1SOAeOSzzVCknZbQuUw7mrjE66
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE0MDAwNSBTYWx0ZWRfX0IZwwK5oYYvh BYhpMXYB74+5pJnkJqT4kqzWKeVzARuOxwFrj1ZPRCBJNVQNEcvi2gzA1nUDRkVQTGz2vk+RCHc tzriei81xce4jTfdEuSHgpEF8YkjjJSn9paNuhAYukEOzJ0pje+JEcJ+Lb5evxLvU0Q3BZgTlLE
 MifwUK1xummXbxhnGNI447WX0xwKTcdZnxKgYO3k36mWzPKeIOyD/3nRivkifvGWE/0SnAlS6j7 UnOewsJ2Pf9Sx4JRgDxn8MGyRMsbyDji2e82n1gO0Pe/Qc2xTDpe2nFw4+UZ+CA30bqD9maURwr 0RTpFnQZ3osbKHb9t+7ESZFBOUu3sweKHSfscn6dOAsu6gJSBlfz7jvSUFafDBOftgInrkCEh5f f8Ai6sZI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_06,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2509140005

Hi Gatien

On 9/4/25 09:40, Gatien Chevallier wrote:
> All of the current stm32mp2x boards embed an ethernet1 SNPS GMAC5.x
> controller.
> 
> Add the support for it on stm32mp235f-dk, stm32mp257f-dk and
> stm32mp257f-ev1 boards and default enable it.
> 
> On the stm32mp257f-ev1 board, we choose to keep the ethernet1
> controller as a standalone ethernet controller instead of using
> the TSN capable switch.
> 
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> ---
> Changes in v2:
> - Remove pointless max-speed properties
> - Fix property ordering (reg after compatible) in the stm32mp257f-ev1
> - Link to v1: https://lore.kernel.org/r/20250903-mp2_ethernet-v1-0-4105b0ad2344@foss.st.com
> 
> ---
> Gatien Chevallier (4):
>        arm64: dts: st: add eth1 pins for stm32mp2x platforms
>        arm64: dts: st: enable ethernet1 controller on stm32mp257f-dk
>        arm64: dts: st: enable ethernet1 controller on stm32mp257f-ev1
>        arm64: dts: st: enable ethernet1 controller on stm32mp235f-dk
> 
>   arch/arm64/boot/dts/st/stm32mp235f-dk.dts     |  23 +++++
>   arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi | 126 ++++++++++++++++++++++++++
>   arch/arm64/boot/dts/st/stm32mp257f-dk.dts     |  23 +++++
>   arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |  24 +++++
>   4 files changed, 196 insertions(+)
> ---
> base-commit: 08a5d1b176ed503a5cef40991fc89549d85e8fe8
> change-id: 20250902-mp2_ethernet-97ddde08f903
> 
> Best regards,

Series applied on stm32-next.

Thanks!!

Alex

