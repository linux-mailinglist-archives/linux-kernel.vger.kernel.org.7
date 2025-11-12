Return-Path: <linux-kernel+bounces-897435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D975C52C93
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8384E348C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4FF3451D4;
	Wed, 12 Nov 2025 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="R6kUFbbW"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9962133D6E3;
	Wed, 12 Nov 2025 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958453; cv=fail; b=rL1BTBkVST1jQC4X4wnfBXzEY81XVJ3dtK1LsOHiUDhTjga0+weByR2UxDka5XnKd9wvCJ1ChfBRd7qbDBco8tDUYXMhzvhtccq9/Bi1X9tKJqwxRXTapejy4bfL/E3snmyIfu4+czWz5oTv8OAXOdmIAV16bfw9qju/8p00x3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958453; c=relaxed/simple;
	bh=lAUf2m9Grw58B8lJHHSESYJGEvUeG3dUJN1fX6L9uZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XO5dfojC9yOb5uSEXGlZ2P0FjRuQDs4Lvn8n4W7iV/3RJmIYysHhNh2rsIxH25K9VNMEpLscKf/NIrIG9SM4JOB+W//jy5Q32IcUwEWbuJS14VRk4hfGNzkOIyczcjw7QcYaacdaMa+6y60wUXiMZoWAgz+axO75n/UVetQ29RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=R6kUFbbW; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACEXkjq1391421;
	Wed, 12 Nov 2025 15:40:40 +0100
Received: from am0pr83cu005.outbound.protection.outlook.com (mail-westeuropeazon11010002.outbound.protection.outlook.com [52.101.69.2])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acret90dm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:40:40 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8fM3a9vHpv0up8KTDFchp4DIGrGrQEAbq9QOmXe1AKcsTLZq1AqYTQxokJ2zOSthvHvJxa5ruV/aR8XZh4SrcTXLLzrskNIR1zi5w08IEtvDxStB+fWG1bpQYKCYarxr3DJT90heRDikFFpmgx5i1P5qglKYwHWnENHq6EwSChS9qTO8q+216jg5bdk6k2YpYrgGEX4VuPpSim7h1Yb6sa3exzdk8vesIf/QOWkJXX9XvwM5+3leBa3cFJhuK0QLsJTpk9f1jVGGkXkBbbARZj8ifv63XneKNtGwYF1RcfPJqnLMfeKQf7lL0rDi1NPPRl3LmmifS7F2APYj9162g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnM+EcUsN4+OwPvxiT/KNe49zAAuzaoRjmMRnzXnuPM=;
 b=DGkYvQC8I2zRjzWRfds9tCIdiKp5n2G/Pah/ZADoMvwzkIlulExrKu0ZjdaGlMD1qHghCOP6SsZkNPuRWtzbIgKK1VzDs6CJFc88TeA3MRyzPplSQgFlgKOh1iEWdhxrIrH+bKZ+EqIIMVfdBl3xd83qI1cT9RT1f0MkdlQNSqt9P+uXWSa9A0wDafhx5NlEa/Q6+D2jaHoJ93KOpZ5r8TpoS5v3S70nPz1Bn9jNVfxSYoysBZlqn5uV/dd/XUMK5i6gtcU4+GAxy8TOKU50Mqpso9l8NUFDMRkJVcO0pdr1/KItX6rprKy+qNW0M+C9SVyPm1T6UgU3cJmQBUKwdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnM+EcUsN4+OwPvxiT/KNe49zAAuzaoRjmMRnzXnuPM=;
 b=R6kUFbbWlRqNRyiH6G9KOWM9zU9VdoCdIv1bdE8Gd5WSk+hEBflgcyJh6xiKJJY5ZgGGgPC5D3tB06gvJg4W+Vto7EeGyM6wkCkxtvgCUoGHtXkVIpiJa/OLnOAYPrkhZAEEsYuAGEafmLRkmig4ndUnJ1K8s7RtMa7Ryajz6EjHFw2TJ7TC4aHUxp6dn/QsCLPMcNMYxX7kNZzIwE8qcjWLrx8YDVjNmnkiODkVufKQrKJw4rY7kjDth2ZiVMr5j4C86SIePKdoEXzBw8lPTRGRFXrR6nCP9DI/LLJNPBH2WLRW7tMSshn0o/J0C37IDA6vHMP3SPfScasnOGUwnw==
Received: from AS4PR09CA0027.eurprd09.prod.outlook.com (2603:10a6:20b:5d4::17)
 by AM0PR10MB3588.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 14:40:36 +0000
Received: from AMS0EPF000001AC.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d4:cafe::3d) by AS4PR09CA0027.outlook.office365.com
 (2603:10a6:20b:5d4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 14:40:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF000001AC.mail.protection.outlook.com (10.167.16.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 14:40:36 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:46 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:35 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 15:40:23 +0100
Subject: [PATCH 06/16] ARM: dts: stm32: Update LED nodes for
 stm32f769-disco
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_update_led_nodes-v1-6-f6c77739113c@foss.st.com>
References: <20251112-upstream_update_led_nodes-v1-0-f6c77739113c@foss.st.com>
In-Reply-To: <20251112-upstream_update_led_nodes-v1-0-f6c77739113c@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AC:EE_|AM0PR10MB3588:EE_
X-MS-Office365-Filtering-Correlation-Id: edb802ac-6f82-43fe-f0eb-08de21f97175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enMyUFVWVGZxTnRhdmNtZEsvVmdGZ2o2QWp3SzdIY0QwUStWaitZVTNUanBX?=
 =?utf-8?B?L0grRE52NWxMOFFnU2dVV3ArWTBURFNGSEcxUmI2V0I1OS9mTjRqWXdwc0p6?=
 =?utf-8?B?Y1pZRzhwdS9ISHc4RDJQc05vOG1tejhFODlFUzJFT0ROd0JnOVZMaSthZDZo?=
 =?utf-8?B?dGtneG85YnExRUhNTmR2dHkxTE9zcTlvMFUxUzlKTFJtQnAyMVFGQU1yYUxQ?=
 =?utf-8?B?WkhOejl5V1lMZnpHRFVmbnZqN2hZejhaLzFYRWYyeDVtZzl6TnJHM2hkNVgw?=
 =?utf-8?B?YisvL2dUTWpjODQ1R1dwNVZITVJYdkE3NkF4TDljaVZBZ3JqTzFLbXAzNFB4?=
 =?utf-8?B?OHFnZW1wWThNK0ZRMko2dVpCMlgrakovUjJMeTRJdFd2Q1JFT09ic09mTFI2?=
 =?utf-8?B?T3ZWVUU3WEV4LzJvSi96Mkt4eVFXYWlsOUVYYXBpdHNVM01Yb2F5SW5ZMFdm?=
 =?utf-8?B?ZnoydDdxQ1d3NUl1TlZRQndMMjJyRGFQd01hWHdXOFdyYnJiSDZDSS9JUnFW?=
 =?utf-8?B?WTBsQzRJYmNXeFJZY0dXbmszeEhTYmVhRTc1ZEg4RGY2ZG9QSFNwaUJiblVO?=
 =?utf-8?B?QWJFK2hPenBmdXdhd3Y3eVVwR1FsdVhNR0hpZ2R3TUREVTZuL05CTkt0dStH?=
 =?utf-8?B?WUhYYW0zaElOYi9HQUJ0KzNGVjAwalUyMnRjRjRXcDJxR3B6NXBzOUx3cGh2?=
 =?utf-8?B?OWFVQXdpMDdYb2JORUwrcGJod1k2RjRzb3g0bzZHZ3hHYTNBWWsyZDdRc01S?=
 =?utf-8?B?blVXVEl1UThrWS9tcFpiMjVqWkVZTzZ3QVlHN0UvNWtpRmx1eGgyenZ6N0gw?=
 =?utf-8?B?eWFjYUJOdVE4T3M2Q0duRlRDUW5SRkFiR1VLVUd2ZUVXRkdqMCtvVTFiOXhK?=
 =?utf-8?B?SWRqVFBVeFNNeGpvZ244Q1ZPU0tuVE80WlU1dVhUY2pGNVR4N1E2dUVjSkFm?=
 =?utf-8?B?OHRBbDkvR1IyZUtwUnUwK1IzQlRLaG5iWmRjVEk0dmRjU3Zsb2F2ZzlJQ0lZ?=
 =?utf-8?B?RzRxK1h2bmd0U2thcGpLQlJHN1JTWEhLVkNoOWhoem8xcVhrdlR4ZmdMekpl?=
 =?utf-8?B?TEZVUEx0WVpUZlZWdHk2bGF2TGI4d2pUWFhhMWZtMVA3WGpTUC9Wdy9QNnRV?=
 =?utf-8?B?QnpZQVhacUlKb3NRNjh6azdWODViR2RoYlNVdTl3MC91VWdjSjQ1U2Rhcjh2?=
 =?utf-8?B?UUhWdTRMR2NKdjduMjdIVG0rQU4rOGkxQ1ZIbC9xWWpYTStKdW5KRXlFWFN0?=
 =?utf-8?B?aU9qb2FsdFdwRmtvdUtueDlmcEpTSzBpSjdlQkNLcmdxNkxHQnBMVUpwQ0pJ?=
 =?utf-8?B?ZnhyOXF1OEVhekVMdWc3SW9ldVlieml1NDF4dnFPMFZrcHJybkE1K0hSTm9p?=
 =?utf-8?B?QjJ4akR5eDMvTnJiVlNxeEJvaWI2Sm52WDdJcW1GVXp2WVZvUmZxcFB3OUJo?=
 =?utf-8?B?N2lTaWtxUU0wRmlYYjBQT2syanBpSm5VNSsxNlZPOFkrWDUwUmtjS1JGK2Fx?=
 =?utf-8?B?NlZXY3g3NXJpQ1EvakJtRlNLVWdZOVo2eHRUZm01MnhWSWkxMkdlUEF3aXJO?=
 =?utf-8?B?U0plQTFTWjBPUlRHdml0K1IvOUdwR2JyWWRMT0J1TGtid0ZjZkcxT0t3UURS?=
 =?utf-8?B?b2pQOE5ua0ZUM083djBtT0JkZXVmVUQ1Z256d1ROemNKVnBoVTNqQXNaVEZX?=
 =?utf-8?B?Skk5VUFTVkQ4bGdESDM0by8xaFBKWmtRUFpXelF0VHVSamV1M0FETnRTVzd5?=
 =?utf-8?B?THNvaWJMQjdrNXM1Mlh6M1Q2UExmbDZXSGpyRHN4SzFIVEg3UDVoalg0eC96?=
 =?utf-8?B?alVUNTVVKy8zSXFVMVdXQU1PN1pLUXNsdEhVemcxUTZUb25JLzFWS1ppVlNB?=
 =?utf-8?B?RmxPZzhXdXJrVGtJRkZlSE9JRTR1Yk42OU1jeGM5eExNNGFFbGM5Y3MvSUZy?=
 =?utf-8?B?WVhlbmIvWFVUOXNEVGd4ZmlGN1N2OGlNeEl5dGdqMGJDYjhZSHpIZXpFWmhX?=
 =?utf-8?B?K1VFVVlOb0tRaFlXV0V3d09Ld2dNWnBaNWV3WkRtQURqaTVrZ2dRbTB5RUpK?=
 =?utf-8?B?K2NHQ1Y5NUM2bTlSWGtYOENGVy9hVUFWcTNQYVdvS3IraHNSNGhoNkwrQWJs?=
 =?utf-8?Q?+i4c=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 14:40:36.6526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edb802ac-6f82-43fe-f0eb-08de21f97175
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AC.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3588
X-Proofpoint-GUID: e42NNAwpra1f9v6MdXgxj8lrTWQEorLh
X-Proofpoint-ORIG-GUID: e42NNAwpra1f9v6MdXgxj8lrTWQEorLh
X-Authority-Analysis: v=2.4 cv=SMNPlevH c=1 sm=1 tr=0 ts=69149c68 cx=c_pps
 a=PbTrrvy6TquqRfd5lZmsGA==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=Xl1y7immRxvDyKJo7PkA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOCBTYWx0ZWRfX1iobKn6YvekH
 11pHFsvpnBtxVUScsotl51xe79gknseHw/0+pcneA51Iu85IaaWYs3I/rRW/gB0+feNc3qtCxaf
 7Y+1BK4/bAgOXq9OR2ADWMNmB/8EHH8u4X0fjcgSnjbaYBu/BtFekdiEzJ2V1MD97Wcj6diVSWB
 upei7Vo4GEJe1TqeBg30qmaKSTdPqMkm55CgMCap9Rw7WVPSr4GvfNo7kOLgDSkaEDXZVEvuAO+
 2lAwJzyLvswhvNHHsucLR6qGCCGhcw3LqtcbFvuR/UMszjWURWiSyItJuCZA7rz61aiGDHFU4RQ
 UQ2DhAOsVW9Y7ZUXyZPGkS1SDb3mhrWjrVmGS5ATDZayaL/tfCvkpHOPPdbL5ziW4OCVMXx/8rc
 d89hmxoyX2w7W1HvSMHlHp+vcdy5OA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120118

Add function property for led-green node
Add color property for LED nodes.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32f769-disco.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32f769-disco.dts b/arch/arm/boot/dts/st/stm32f769-disco.dts
index 535cfdc4681c..97c276f81f9a 100644
--- a/arch/arm/boot/dts/st/stm32f769-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f769-disco.dts
@@ -45,6 +45,7 @@
 #include "stm32f769-pinctrl.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "STMicroelectronics STM32F769-DISCO board";
@@ -80,13 +81,17 @@ aliases {
 	leds {
 		compatible = "gpio-leds";
 		led-usr2 {
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&gpioj 5 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 		led-usr1 {
+			color = <LED_COLOR_ID_RED>;
 			gpios = <&gpioj 13 GPIO_ACTIVE_HIGH>;
 		};
 		led-usr3 {
+			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&gpioa 12 GPIO_ACTIVE_HIGH>;
 		};
 	};

-- 
2.43.0


