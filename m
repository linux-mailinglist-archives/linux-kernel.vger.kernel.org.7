Return-Path: <linux-kernel+bounces-899592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41366C586E9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E168427E52
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A8F345CBA;
	Thu, 13 Nov 2025 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="IYpCGmvM"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5893D2EB5D5;
	Thu, 13 Nov 2025 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046869; cv=fail; b=lVrRZiJeLJHoka9XtnHQGzHnzJRlElR/FsUN2HAPBgQPSvk2bxTPEm7bo0bL9cDxT1w694AdaL0MROurOiUiNS7yW6WVN4xmfY05rQoTbKvXQC1kHW+0EPmQ87+/JBnRDSSNXPrdVbZPFSF6Xcn72HbTJNyfjg+JysTyJ31vL5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046869; c=relaxed/simple;
	bh=FLzJUymKS5d1w3C3URowSnw930PuT5Po50A48oonLxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=C0KsWo44Ymlfabg5OFZx7f4x6NHfyQEAc+QvDT+rZxUHlPLRS+dbn/65eAgsJ+xsXnnPm3cYE/mZnrwg9kxMZPbJ18nrMhpEK840XivXg9Y9iCaCbxFULzupOPiSqxkV1l+qbM/IkfMpLY6Zy1hweW9+T7wHaVGTgtFiLMm+C3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=IYpCGmvM; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADF8WcW259280;
	Thu, 13 Nov 2025 16:14:06 +0100
Received: from mrwpr03cu001.outbound.protection.outlook.com (mail-francesouthazon11011001.outbound.protection.outlook.com [40.107.130.1])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4adc9s9g3m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 16:14:05 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quiBJfq+ESWMXSVbDUheVnwslBYWHzpHQmY+bd7Q7GMVScYVPi82FmHvp5F27pte+zNorcO3cEwLDUzvXEeZcJBD1cjQqmF2OEplaPBeItMdXWjHLLgYdplgObCtIgGyePsupOs866ia7HcksMD39FrnYjEI4628jKxjAZrXmaz/tVMbrKqQnki356LXWQ2JZBUoXq3N0VwfRjNmL451EZugWvc6/SIEeAUWHIjsFfmErvDMPaJDgySi0+2Q95H8Yl3YstBsinWhs/zoO8VbxSFdV7bQaYbtwLPH3kL+Ew++q8DHI5HWDfT5DQS+qbqqUEa43c0F939USXvFUDeWpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UBw8t/H1t/frE1WcFSgjvRV1JVH4/+IlEyafohu6ts=;
 b=csexApa6fvKVaOn5Y9v6FDQBnS+p/MJvTlCG8WqjhpCxaO9LyW5XFUyemcK9AgTZJHSknRqJjppjcHwT5YOMAclMPkeUlO6iFyIHHr9C6qBWX54/inSYz2kx70s8FejveDoOh4BtKHDsfYlr4oh5wUOoUH0/Q37ZDfrVWNRFNJ0oF0gsli0bZLSYlgBP3XrSSp4vEMldqPSqDtdL2jiMCQUCRgZUa83suaYku06WjssmjUcubVBOiHYq9YTsxlNiXIoxqvtwVGLjgF062LO+gjOBQfgFdMZJ8M9tyb4n4cuhpHr+StDbFDTXesY1JH1JH67bO+3nIDrZh+sAyLeNYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UBw8t/H1t/frE1WcFSgjvRV1JVH4/+IlEyafohu6ts=;
 b=IYpCGmvMGQSPWRVMRwJL+JdtrJpyUjHWdfc7Zns6ZUELeuWBXlTfq+LL9IFUMKPfdIIuf+0chFUrh/V6cRbfhtcI6NDoEzywO3GdRjdIEHppakgjsOYogSGinH4+q/vuniZY3BzyzunbSZaVeMgg2hDnqaAkj/rMiNno9s7yGBMmwCw43wpBKLoZaCY5y5R0YDzGjdVys6WqHZuIEEJrSJrImIxx2tn69CG3pC7d/+h1N3h+HqB8GQL4tfKPhTrmH+taIFKMaw6c8YLdZqtD0c00E98CZDDT66I41bwQ7DfGv5cS7udDLeUt2AKguJUm2ygixRrALmuJ8TmWHEtcsQ==
Received: from DU7P191CA0003.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::8) by
 AS1PR10MB5578.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:476::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 15:13:57 +0000
Received: from DB5PEPF00014B8C.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::e6) by DU7P191CA0003.outlook.office365.com
 (2603:10a6:10:54e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 15:13:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB5PEPF00014B8C.mail.protection.outlook.com (10.167.8.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 15:13:56 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:14:06 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:13:56 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 13 Nov 2025 16:13:52 +0100
Subject: [PATCH v2 01/16] ARM: dts: stm32: reorder nodes for stm32429i-eval
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251113-upstream_update_led_nodes-v2-1-45090db9e2e5@foss.st.com>
References: <20251113-upstream_update_led_nodes-v2-0-45090db9e2e5@foss.st.com>
In-Reply-To: <20251113-upstream_update_led_nodes-v2-0-45090db9e2e5@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8C:EE_|AS1PR10MB5578:EE_
X-MS-Office365-Filtering-Correlation-Id: 05dc4eb6-e77d-4699-3ee9-08de22c74430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGpjaTZpaUM1ZlhpajU2WHUwbWRyMjNYQTlPejBlbUdNdHRRZWFiV3lzSWR0?=
 =?utf-8?B?cmFyOFlVcDNvUGlScHBnMjY1RDRtQU9ucHFScWZXMlJjbTJpMmQ5Rm0yNmdU?=
 =?utf-8?B?QmRPMU9CelFKQmp6MzRyTUFNWDVHUEZXZHh6ekRqTDJaWDlxZnI1V0g2UHFh?=
 =?utf-8?B?TDFsMERMM3FtL25waGJKK3VNdUdGa1kxcnFNM1R2QmhDMGpHYXJTa25JcWNN?=
 =?utf-8?B?UCtwSzQzSy84TmhPN3hnVmdXcERvM0RQNStHOVprcmlTcHo1WS9OckdBRmxM?=
 =?utf-8?B?cGpoUUhRcGVEYS9MNC94akF5Qmh6NE9IQmkxaVNPeHRsKzFMaXpzbjZWVzRF?=
 =?utf-8?B?eGFZcS9ONWwzQ1hNd0lyaTR5Y2hsdSs1YmJNNkZ2eDVtY3NxUitiTTJ3VVZC?=
 =?utf-8?B?aXFhMC9ydFlmbWZkTW5rL3hmZWhmV0V2cDZRc29tQldPcHBuT0ZUc1FEYUV6?=
 =?utf-8?B?U2tOSDF0aGhNTzVHZTBjSEhxK3JLaVVuZFdHZnliVThVT3hDV1d6aGNjbDA2?=
 =?utf-8?B?aEEwUXNVUjd4U2JlMzlqWUtPbHNpVll5a0g0TXorQ0Z5TXZGVkhGbEp2aHFp?=
 =?utf-8?B?MnJpNGVsdWtZbFRHS0VnSi9XOU1IQm0wOXVMaDlMVmVrQk1wbGNHNDNMb0U1?=
 =?utf-8?B?NUFFUlpsRnlFT0hJL1ExQUt0a1pySXJnRVNReEdxdTJGTkRHREt2R1JrOW1t?=
 =?utf-8?B?QmczS0haOFJ1eE5majRlZjBGOXlEVVFaWjdMNXZVQUJOSEltMnd1RlhqM1Y3?=
 =?utf-8?B?dTVSWWJkOVRoR2xpY2RmUFN4YTFyZEtidXhhUmsvUE9TNE1aeGZuWlh6eDNW?=
 =?utf-8?B?UzVMUzdTUzJxVGY1cktOSFNhVkVvWDBUWUR4Rzg2UVdDejRrK0IxVk9WaE1H?=
 =?utf-8?B?Q2NvZjY3Y0owa2VMWmMrTmZzMndPMlVwYW1ncm96TjJsUUVZVnAvd1pJNzBE?=
 =?utf-8?B?VUNjMGN2amVhbDZEZ3R1WmZ6T0NwRkt4UWc0K0JIT3lwTlEyMjhBM2Z4ODBR?=
 =?utf-8?B?azNjcEpCNTFYUThPRlNCSEVyY0JRTklKU1Fxdlc0Z0dDcUNmQjAyczhzNVR3?=
 =?utf-8?B?TmliODAwUHlnK2s3OFNLdmNXbzQ0SGtQQUpVVFVHRGdmRXhCYzBBNUJzOHcy?=
 =?utf-8?B?VFFkZzFTRWRTZnJPY0NaSHpHTzRaN2RSVUk1bnBzamFNb0toeitBK0xiL080?=
 =?utf-8?B?V2k0RTMwN3NzT25kYVJOK3hiQ0trZ0JaMFprUlAvb1Bla1NMSytjT3FMbnIx?=
 =?utf-8?B?RDNMMGY5NnVLVWl2dmVXTDBQU09UM3AzWndrSmJMMVY5amcrQ3M1Zm0rekpi?=
 =?utf-8?B?M2JZeDlpdjdncUkweFNiVW03QmVVU1REVEs4V1Raa1ZxQlFqQnY1UUlJTC9B?=
 =?utf-8?B?Y2dkbXNucFNTZVcvckplTklRODROV25tWVFGRnlNYlEwTE9TZ1Yzekc0RUNz?=
 =?utf-8?B?RC9CVEZYcTNPVGlZK0lEVDZsQlNKWjB5Q1ZhSk9wRjhMUkw3NFl2TUFQcEt4?=
 =?utf-8?B?M3FzRmsyRzRIM2syUHRENUtDRjFJU3hDak1lYWk0ZktwNDEzS2dXN0xEczVH?=
 =?utf-8?B?U1pNTThXUmhsUGtYVmt2cXR6R1AvVkdtd0xhRmIwM25KejlQbTNSQjJiTDZ5?=
 =?utf-8?B?MmdCWktsUXZkZzMvRGlDTEMyOURmVnJsN1B0TWtrOVZYcVB2VmlqRkhDeExi?=
 =?utf-8?B?K2pvREdwOFpuZXVCRUV2ald2a2NVU2VES3VlM1NRb3dya3I5QkV2b0VDU1F6?=
 =?utf-8?B?QndHc0ZhUUt0VURzekdBbCtTdkt6eXZ3MktmS011MGlZWlcyQytheUN2QVVa?=
 =?utf-8?B?RVBlM25IVjRSSFd5dXAwSytMSkVxVEJ1aWI1dkcyNXhvYXd1SFd4aWpqMkMy?=
 =?utf-8?B?b09DWmFLaXJMYnkzcGNSMHhRYWRqQksvZzV4bVdjcUxrTitlNXlJSkpVOWFH?=
 =?utf-8?B?ZmMvY2t4TzRXaDVOT0tPMDVRRXRveTF1aW40Z0dSNFZUNUJ3VG8zSytWNmxG?=
 =?utf-8?B?YmVJZWpjWGtURFl3TW9lUXpBUHhSTittVlRWV3RQMnRZN2tjZFRXc1dWM2JD?=
 =?utf-8?B?R3prUS8vUjd1aC9EZk95QldQZzRZTG9JNXowRGw4UkRlSXRCQ2w0d1RSQlNN?=
 =?utf-8?Q?G1CE=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 15:13:56.9962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05dc4eb6-e77d-4699-3ee9-08de22c74430
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5578
X-Proofpoint-GUID: 80pXpBIYh08noOFO3zjoPcbcEgAJupoP
X-Authority-Analysis: v=2.4 cv=M/FA6iws c=1 sm=1 tr=0 ts=6915f5bd cx=c_pps
 a=Ysb8huw0WkGZl9p39rEl0g==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=sCyeEXTu5xOGXj2OjYEA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDExNyBTYWx0ZWRfX69h2qTsNNJhQ
 ALsiGGudOY5icX2lV95RQTXpCa4DafxvsYdWvEpZF74AOmncj4szZkKYUojMfBF0jcP2Ly5+e7F
 CrjGC0keDH0ZsLQEVgXJspZGlPJiOoVyhFp+rlDX5nsVNm4Dl65vhAF0oQqdbIx51jTbfWXrB6r
 oZr74IBsQsLjRWXHTFSnh/MGvWYUYSk5oHQbUueAIPch0CsGsm6Q6jgBdnKz8pBCRAIkM1kX8VD
 /ZfWlofR0UtintI7gcexzrEf07L4Khtl5stT5dBww7bvcI/BtQGzxTRi1QnxtpLZdlfOHjZ9Doy
 6TiFY2VJ4RrUEd3unzN+LlgICUjBActhkO2tL3NUdReqvefR5QVaKhl/7xwMQgMk8ohfM7uDBa8
 /rPWrQjfiPqY9zWinE7wzMqI7opFhQ==
X-Proofpoint-ORIG-GUID: 80pXpBIYh08noOFO3zjoPcbcEgAJupoP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130117

Reorder nodes by alphabetical order.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32429i-eval.dts | 56 ++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32429i-eval.dts b/arch/arm/boot/dts/st/stm32429i-eval.dts
index afa417b34b25..6ce8d7e5565a 100644
--- a/arch/arm/boot/dts/st/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/st/stm32429i-eval.dts
@@ -82,27 +82,6 @@ soc {
 		dma-ranges = <0xc0000000 0x0 0x10000000>;
 	};
 
-	vdda: regulator-vdda {
-		compatible = "regulator-fixed";
-		regulator-name = "vdda";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	vref: regulator-vref {
-		compatible = "regulator-fixed";
-		regulator-name = "vref";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	vdd_panel: vdd-panel {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd_panel";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
 	leds {
 		compatible = "gpio-leds";
 		led-green {
@@ -135,11 +114,11 @@ button-1 {
 		};
 	};
 
-	usbotg_hs_phy: usbphy {
-		#phy-cells = <0>;
-		compatible = "usb-nop-xceiv";
-		clocks = <&rcc 0 STM32F4_AHB1_CLOCK(OTGHSULPI)>;
-		clock-names = "main_clk";
+	mmc_vcard: mmc_vcard {
+		compatible = "regulator-fixed";
+		regulator-name = "mmc_vcard";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
 	};
 
 	panel_rgb: panel-rgb {
@@ -153,9 +132,30 @@ panel_in_rgb: endpoint {
 		};
 	};
 
-	mmc_vcard: mmc_vcard {
+	vdda: regulator-vdda {
 		compatible = "regulator-fixed";
-		regulator-name = "mmc_vcard";
+		regulator-name = "vdda";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	vref: regulator-vref {
+		compatible = "regulator-fixed";
+		regulator-name = "vref";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	usbotg_hs_phy: usbphy {
+		#phy-cells = <0>;
+		compatible = "usb-nop-xceiv";
+		clocks = <&rcc 0 STM32F4_AHB1_CLOCK(OTGHSULPI)>;
+		clock-names = "main_clk";
+	};
+
+	vdd_panel: vdd-panel {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_panel";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};

-- 
2.43.0


