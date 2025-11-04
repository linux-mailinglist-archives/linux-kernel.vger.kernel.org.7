Return-Path: <linux-kernel+bounces-884852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56073C31529
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C031895609
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45DA32939F;
	Tue,  4 Nov 2025 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="c8VGaMl5"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42272FB97F;
	Tue,  4 Nov 2025 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264525; cv=fail; b=Ntdc1maxrYPFKLPYS2i34XestH6t9Y0J2EcSG1bHp+G+8uU2gLiux9LDnKaLaxGX1TEVPuPhK/EXcy/KlYSGibF2wutrOvI22Xg4HzQTwtrMKSaMFytF6wwzGfDUdjfTMIvi/Kmd9H8OkJKdsBNhxoKDg2t8kNWM1D8CJeiySGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264525; c=relaxed/simple;
	bh=J5gn1c1YJCnEr8s8+vDrFb51OmO3v4odHS8UWj/AM0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Z8a7WihJvHBi2xmAQHrs8+mWkBxl1yXo7sa7IaS/eRDZciAV+xplfZWLlE7kldpKLYVXjLPziw7Q6R2JVzreiMGc/UtPPLwIcVq2nnAKGkBYOGuM77Sof2YtNKqFY9RGD4xbiqvhVIA8pEbDVQhwYdGZNK3DoGRzXZ0vZN8cJiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=c8VGaMl5; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4Dldim348153;
	Tue, 4 Nov 2025 14:55:12 +0100
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11013070.outbound.protection.outlook.com [40.107.162.70])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a7g9n0vww-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 14:55:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUc2Bqfi6OXBpCBXVl1wh/jY+sFSavlhbZ/lv2cn9qGM5wBR7aQ+QzF549T6WsRj6qICz+2bjs/x+uODvUL/un0jl9UbCpPOg2hjPZKl4iMjo9bkF1ewknSBzWju+0ctElihcCCRFM6y5dbCUKPsQo+K6tuVqmitcFJyirvW9qqiAT15DjX+CrsEG/+ZJs6DHsHWneuGgSa3TRNeeZ8iGKhXYOgBnFCQNoFrnMTDMkX5XzzqDtdiCMnPYzuLLFZjgZ9ScPRDbPigP4nZrbBivN3CDT1J8GnbGcBkEqUVjn87ARwFjA7a2q7Mxck/1Lj25QxAtl5QrVoHOSxRJbEGEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BO0JNAmNGRkNmjqd9C2xk6cBARTw892mhAx4MhH4KAc=;
 b=u+YRy4zyGIAyz36xyyBc3seqJYGQ8W9hAWOCZYLfc1R7QaOX5eyzoRUMNfB/sX49RrglE3cmqpx0eQAMjsCVzMkCX0Sd2gi14+MI1so9w0jLVo4enHeltm5SXPqixtkuu0azRHjaSVOsRIntCZh9xCgSlAN5OqF4GT9+qPm8F+AvGep5ekvhnMxMn9KOKVmlDjziCKZw8aBi1TyVDNF6fprBC1x+1NHqIHwW8Ez7S5zDTmg+yZrCzJ63YIfuuRKijX5LU95HCwDXqMbTMR44krsYRQNOuYh8HXt6hgblEqtMioYz5FL5deJPCxKqm7YqIBK6rBrfn1CjO0Fpi+StXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BO0JNAmNGRkNmjqd9C2xk6cBARTw892mhAx4MhH4KAc=;
 b=c8VGaMl5FM7su1kIwSmNJV6rGDTP6V6FPMr4G4jtigdJ97oJ6XLwbbgydyAz4/UcX1tYHlYqaSDZkAzh9UCbkb4I1ck4dwYcTSLx9CiVFf1SRyMzeUqZs++r3OCqaBxThahixG2IySXXk/WRcxlwascBshdhy1eZIxcE8pYg1ASBjhTP6QQBLSLAE0fXuFFWQld/M16yDgV/ur/6z8edaF8qAMvg2Xg6WzFAoIMrWQdX8TSRG08dLhVxVE8WZnVxy+2k42nUOtbV7/ZPjUDYrSyx6EmgFTFw+UVpHXRJ7kL7quI4bq3HkifjBBhK1G2FVd7/gBjlT2h/TH+5nzkUDA==
Received: from DUZPR01CA0030.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::19) by DU0PR10MB9345.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:59e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 13:55:10 +0000
Received: from DU2PEPF00028CFF.eurprd03.prod.outlook.com
 (2603:10a6:10:46b:cafe::b6) by DUZPR01CA0030.outlook.office365.com
 (2603:10a6:10:46b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 13:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028CFF.mail.protection.outlook.com (10.167.242.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 4 Nov 2025 13:55:09 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 14:55:01 +0100
Received: from localhost (10.48.87.185) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 4 Nov
 2025 14:54:39 +0100
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Tue, 4 Nov 2025 14:54:11 +0100
Subject: [PATCH 2/3] arm64: dts: st: set RIFSC as an access controller on
 stm32mp21x platforms
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251104-rifsc_debugfs-v1-2-7ebdfbf8d33f@foss.st.com>
References: <20251104-rifsc_debugfs-v1-0-7ebdfbf8d33f@foss.st.com>
In-Reply-To: <20251104-rifsc_debugfs-v1-0-7ebdfbf8d33f@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFF:EE_|DU0PR10MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4feede-6b5a-493f-3b8f-08de1ba9c4e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlhjZ25sOXYwaHNQY3R6QzRnVWQ2TURkSVhXT3RNNG1VbVl0Z2FVR0VtYjVX?=
 =?utf-8?B?b09uK2NZMkNOVDJLcG5JUW9RWktOemcvSDdKWVNUU1VYYjR5UkJQL215UE0r?=
 =?utf-8?B?b0dLWlV2QTF5VVVydlJEdXNnMmVCOG5uLzA1TnhGQTlCbHhZUHJjZ3RML3Ex?=
 =?utf-8?B?OUxMbm9RUWtNOXh5TXJZRCs1Y3k0QXVRNnpTM2RNQ3UxOG1ITGpoaklRbnJn?=
 =?utf-8?B?d3R5RUtkd3M5WDZ0RjE5RHBzd1plMEN5cWs5Qlo3T0dkdHRlOWNQbCtadDdY?=
 =?utf-8?B?SytWS0pFMU1DVXNSNEVES1FTazRqRlR4SXZoQUY1Y1ZEZU0xN09mN3JOU1Vt?=
 =?utf-8?B?b0J2azhDNzJzQ2EwMWVKQnZxTFZYWTVmeUdzcndnL1JBUXhMajFMOGdPTTc1?=
 =?utf-8?B?cTN6OUNGZFdyaVErUTcxL2pVYldhQW8xcGhPeHlJY3dGK2NvVWVLcVI4RHZX?=
 =?utf-8?B?YmJ1a2h4TXRyTnhqblE4WXg2Nks1K21zbjNEbVNyUU5GeDQ2Q1dTOGlYbGlT?=
 =?utf-8?B?Tk10R3hnbkFmaW5pMXVqS2YvUWFlRjZqVkN4WndiUDVYLzFPMWI2KzNwNi9H?=
 =?utf-8?B?QTlMN2dRRUNYSWtkcTBUUWwyS2lQbHVmRVIrWUg3VFBLWEZVUVNlMXF5M1Vn?=
 =?utf-8?B?SmZqaEVxR2ZpblJsNmtsSncwc1RpYzNTYjVreHB6OHozempJYWZmckJvaFV1?=
 =?utf-8?B?bC8vcVpaNGYveEVKWWlkVW5TYnpGeE43bXZtbURKYVoxQTQzcHNNQTlCUzdO?=
 =?utf-8?B?MjJWVFhaQkhTcXdobGpRY2U5ZElKc0hjeEdTSGRmWDg4aVA2cVE5NzdpUm5W?=
 =?utf-8?B?Vk9iQjBKaytuT0pqdTd2Yy94czh1ZkFkTDEzVWRMYStTakpFcGFnVS9wSGNR?=
 =?utf-8?B?eEFleS9hQnJrQlBscXI3TldnMW9SdmVxVXVBd09xVDdDN3U3bWVmMzd2NUNu?=
 =?utf-8?B?NXhiQ3VMclpVTHptb0pJR2JPMzIvVm9MdGNYVEdaS3FCaHlmdjJTY01Pc2FJ?=
 =?utf-8?B?d1d6NVRUUzZjeHBUMEs1VW9DMjUzUnJWMzdaWmZqM0JHaHBJaUtETi9oTkhC?=
 =?utf-8?B?SUtUem5ic0VjUEYzR0VJNGtXQUdyRWpTSWZrTWpOcDloNVNWc01oYzR1VmFm?=
 =?utf-8?B?bUNrQmZPcGwvUW9GQ1RZRmo1SGRjSllwQjFQU3pWQ01IT1JGbDczQ0dtSksr?=
 =?utf-8?B?azlINGxwdHZnY0UvcDFtNHAyL0tvVzY0VytBazlPSnZOR0cwU2VOcjNqcmJh?=
 =?utf-8?B?SStTc2Y2V0w1WDVLanJZZUp1SlNoTmNscDErNVlWNHFlMFQ1SXlNUTdWVjBI?=
 =?utf-8?B?R1FicEs0d3hFUVhmZGNWWnIwRS82RThkT042Z1I3TGYxQjNWbmZrSVNBNjUz?=
 =?utf-8?B?NmZzeVVkOUJLVkFlQkZTQjZUNmxwTkkrWlViSkZRbHhoV2ZqM0N3ZFJhc3FF?=
 =?utf-8?B?RXNvWjN2YWlHcFZvSzRiSEJsdDE5dldabEROVytKbUtWQTdyVnFGQU9jWVA1?=
 =?utf-8?B?L05zb2RJaS9Rc0JuSDJQNjdXSUk3MG5ldE4wV2RVaEpHeStWV3kvMmpSL3Fx?=
 =?utf-8?B?ODBSKy9qRzZKTFN3cm9mSmZwWnlvR1FsbUwycnppb25Tb3Y0Q2hOdDJqTklu?=
 =?utf-8?B?YUxvODhKdWRNZzI4emVWOE1KTDdaZElxaGd4d3VWQ1ZPc3BkdXZ1ZjhjZjJr?=
 =?utf-8?B?emdDOHlaVlMvN0xEbmpsdStBbWlhdU5KKzdsWHZMVWJ1UDRLQjc5NE9TaWNL?=
 =?utf-8?B?UzByZkwwN0daT0ROTjlITUFya3pHN1dJRnh3WnlMa2E2aDlhWWJvcFM1eHJE?=
 =?utf-8?B?R293V3A4Z2lZeXg0TDBxOEFSak1NVDU4M00zRkdJdFN6VHh6V1N5TDREQzcv?=
 =?utf-8?B?MzZSUytkZjdVMjhDT0xoRmIxcGE1MWJPd2g1ajF0WU1VdDBSajlVeGtiMTd1?=
 =?utf-8?B?Yis1NktDWkFhQWdWV2txd245amhZQ0F2M2tucnRXRW9hL2tYTmtoN1RwMm9Q?=
 =?utf-8?B?bndvbFZ4d2FrN2VDaGR0Y1ZwTVZtTW5SRXhpTUJIV1g2b2pzRzhnRGJWRDNJ?=
 =?utf-8?B?NVBOM3dCSjBaaXpNaDh0d21Lb2RWbndqck1kbHFJQk5Ma21ib1E0N1BzWGZr?=
 =?utf-8?Q?aUmI=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 13:55:09.9018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4feede-6b5a-493f-3b8f-08de1ba9c4e8
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB9345
X-Authority-Analysis: v=2.4 cv=WL9yn3sR c=1 sm=1 tr=0 ts=690a05c0 cx=c_pps
 a=0dS1Un6p98pWodQyLfc2pA==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Wpbxt3t0qq0A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=GThSmsW_2FqIp-Q6p0QA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: Rbk10NseHGosi_BvVBw-24d0ESKKuNuY
X-Proofpoint-ORIG-GUID: Rbk10NseHGosi_BvVBw-24d0ESKKuNuY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDExNiBTYWx0ZWRfXzyPYjHe+UpSy
 7ND3mE+q86L7Akw3/nCtNXBfmjD03OOrfRRjnh3+0xdKAO/ROFtL5P13iQdCdBtfmg8qzq08fvF
 E57S4r+LaKbaKG0a0n/K+dYennm1NyYlHcxTv363PA8OtK/TyvIPmlrwDD/qTIyHvaVx80hSfxm
 C+1EUd8wCfaBO2XtagRen8SFhkZZ5Z0C4THDO/HgtBinYt2VZ0nYudVhvF5XFdLZmxJTLAaPPIT
 6PmEFtOpoKn8fkpcckAeUFSx8PUxvfaTlolovbZypSRib8sZpTAanfUqMlIZKfn9XRqh9oUqhCR
 AuDaxY+LKoTfeY0njBiTnizst52AlSoPjOU5cSmIsBvGAf8qauGNNNXf7Q2G/e68mSs2R17dUpI
 5VpXtwvgiK/CpCz38x7/QtP8c3HrTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040116

Similarly to stm32mp23x/25x platforms, the RIFSC is a firewall
controller. Declare it as an access controller, keep the "simple-bus"
compatible in case CONFIG_STM32_FIREWALL is not set and update the
child nodes.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp211.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp211.dtsi b/arch/arm64/boot/dts/st/stm32mp211.dtsi
index bf888d60cd4f..cd078a16065e 100644
--- a/arch/arm64/boot/dts/st/stm32mp211.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp211.dtsi
@@ -94,18 +94,20 @@ soc@0 {
 		#size-cells = <2>;
 
 		rifsc: bus@42080000 {
-			compatible = "simple-bus";
+			compatible = "st,stm32mp21-rifsc", "simple-bus";
 			reg = <0x42080000 0x0 0x1000>;
 			ranges;
 			dma-ranges;
 			#address-cells = <1>;
 			#size-cells = <2>;
+			#access-controller-cells = <1>;
 
 			usart2: serial@400e0000 {
 				compatible = "st,stm32h7-uart";
 				reg = <0x400e0000 0x0 0x400>;
 				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&ck_flexgen_08>;
+				access-controllers = <&rifsc 32>;
 				status = "disabled";
 			};
 		};

-- 
2.43.0


