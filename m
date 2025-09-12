Return-Path: <linux-kernel+bounces-814324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AA6B55271
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A6477B517A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601FC30F552;
	Fri, 12 Sep 2025 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="toxltzWg"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2167130AAC1;
	Fri, 12 Sep 2025 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688957; cv=fail; b=KSoXKSArbSfsW04dFvPFXYlzk+NBTXDbDVh1sshB0eVTtP0d951p1CZrppNPg9055Ouwqzj3eINwukRrGI6D0lL93Kf6lQrA8+SBlz3kc+v+eFIc8csdFVbYoo/HOMnXDyBzlSxyacplGqLBq27d1mr1uePmylpsVnN0HSnZOZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688957; c=relaxed/simple;
	bh=jgmkBDxtv4s/DUkykxQdrZNtLSJ3+OHf5mfL8o0FzqI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=cdghgpxWh8nSDzO8aDAxlqVvV1o7xykpasMykUvXBZKgQN7c9BH4M/UCyxdWP2bGQlSCqpXX8EJPfN8BfN4lkGlf6B5ardMU34hZrcuOyq01HFnjACGg1caeaftwEUJleC8CGjJ2J5M1AyyEZ/hrYTupuZbkhoxo5se7h925mRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=toxltzWg; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CC3rFm011678;
	Fri, 12 Sep 2025 16:55:46 +0200
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012054.outbound.protection.outlook.com [52.101.66.54])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 490ywn047g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 16:55:46 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3ndQMjah+G/iF77CTv01UaskRH+qQIIfyYS3D3PCCVUjZFM5s1uvZAqqEgyPTQCmokseVU+nCuUJrL8mWeoAUN2aiiNDA2/pdkVLs50F1eY2iQ63UYTXjbFHH5DOQ+4lMyqLQIXQzAYZF2oISpqVknRNGdnYdce1EuWLGtqs3EEeylyHL4JbbYYiQSkMYvK4mqHTon5+Xvj/ivvFk5i5THd0BkWPw/AsXalNVDKKlDvfXhj2YNYkKb0XLeEk+CsxFaRr0NpytLZVvnU+ECymz9oNEiLNfDKilFeep01H5KZHmPXu90sxod6jkJEHXj8Fno3h4VgbaAIYm+IQ/KI2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MdOGzPG+iwXgs0Pv3ts6QQIM6i2jOXQ3adOAGJHJOE=;
 b=WmU3lxTmgfeFcLGbvN+4u/WNisbHdjTV7aJRatlqv7biJLE30eJcKcmXD6S1hIFIBdRIeVAGS5REgRPOhCOQJ04Mq19/YNgpkrkFRk6MrrBj+5GaC3LumVqn5bQ+VhIb62++3NGf58JPIy+aAT5YO1QAcLnoiNHcDz4V9EYK7GAA2HhB4rR+EDIcnBZaZ7mwShdTHK/8S0AHrvGJWMR/y+UydRXqCnIyF0occr2nZ715DuqZdzUELTasnwnPjKzZP/nwVES/G+7u20eRf2II4FyWer4+ndBF1g69XKjDH4fXHcsntlj5HtQmb8ixw+AXLsd4mjouTw/UEXtd9E9NjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MdOGzPG+iwXgs0Pv3ts6QQIM6i2jOXQ3adOAGJHJOE=;
 b=toxltzWg1ko0z+8Um4YCOZ0bNBSea11WnzHIqYN7buDB1XSQYbkWumyYfZhGH6OPtZ2fuhv5V9jynKdyTTCcsxi3h59/HJsmjtuFQNfNXg5WKLq2uQLqe/AyllPVgnwoAEz2JSTopU56rjZ9Qt5+FE29iEkbMvd1FV1bDrFzfxfseFewstju+3hHQN2+voiunyPTAmDL/qzXiSeBxaOaUGg1ZUJBCgrvj/T/aaWwWPFEKwAMpDm9yH9fpI1fc/eDfNi8zrQP/Fr3DapTV/Ft5CHL6m5HNgEXpZPR66Jmvshl8rEeM0HS1OfkJd+dJZ7n37ccMGcDKGLDYbJi5REjyA==
Received: from AM0PR04CA0049.eurprd04.prod.outlook.com (2603:10a6:208:1::26)
 by PAWPR10MB8259.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:38c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 14:55:44 +0000
Received: from AM2PEPF0001C711.eurprd05.prod.outlook.com
 (2603:10a6:208:1:cafe::da) by AM0PR04CA0049.outlook.office365.com
 (2603:10a6:208:1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 14:55:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 AM2PEPF0001C711.mail.protection.outlook.com (10.167.16.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 14:55:43 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 12 Sep
 2025 16:53:21 +0200
Received: from [10.252.28.204] (10.252.28.204) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 12 Sep
 2025 16:55:43 +0200
Message-ID: <db6c66aa-fb86-475f-8ab4-7567e8be1d10@foss.st.com>
Date: Fri, 12 Sep 2025 16:55:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: sti: remove dangling stih407-clock file
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Raphael Gallais-Pou <rgallaispou@gmail.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250908-master-v1-1-98efab52f143@gmail.com>
 <7f75a59d-356a-4af4-a1d0-8fb1261397bd@foss.st.com>
Content-Language: en-US
In-Reply-To: <7f75a59d-356a-4af4-a1d0-8fb1261397bd@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C711:EE_|PAWPR10MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: a29b0df2-28e9-44c2-9161-08ddf20c7302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEpEZjNWMjF1T1o5K3N6MzNjUXpybUxNVHhtTW9UM09sbmY5blJuNmhOWjRU?=
 =?utf-8?B?b2ZldlVVV3UzNko3Mmc3dUk4eHFvazBFOG5vUUZrM09qOUk3V21xQTlybUh5?=
 =?utf-8?B?M3NoeEhYZ2hCelNQa1hFbzJpVzY1MlMwbkdmTzljTDYwWXhsNktaYTBRdkI2?=
 =?utf-8?B?bTdsZzBGaW9DRlRrV2RsOCtMR21ob251ck85TTRsb0NxK0xON0R6NXdwUWpw?=
 =?utf-8?B?WHVuakdVdXN2UktnNHN1cjBST3RTVVZTbjlDcHpZY3lhQ3VPeWdEL1dLSEw0?=
 =?utf-8?B?d1ZQZ2JlUVZFYmtYWnhpYmxhdVpRdnZQMVc4YnVvUkRzWHN0RVZSdkw0WGx4?=
 =?utf-8?B?YTN1UWhsekhLem91a1YrN2VqZjhiNVRtVGtpZU85M3RDUWthWTE4dlZWVnhZ?=
 =?utf-8?B?UDVxOFhXQkVKUXdhOVhxaW5JZ3Mxd2tyelN4UFZYSnZTbXdDajY4WDdHdkdW?=
 =?utf-8?B?eEZIOC9MVnJIbHh3Rm54cTNsVlBobFQ1MEtCQlhlSzlhNHZWNmRZaldvSndi?=
 =?utf-8?B?YzU5bmZGR1k1RUxiK0xXbi9sdHM1NWFkZytSN3YrNUVnWTBZMG00UWdiWXEw?=
 =?utf-8?B?WG4zWHc4Z2xzckNMQTJRUGdvVFB4eFRnVkpqNCtKalZweXkxSW1BTnZRNGMx?=
 =?utf-8?B?akZxdTJ0TWJNN0JHRkp0akt4Ri9sWXdHL243Ri9DTCtqVUdSYkdzdHJJVTNY?=
 =?utf-8?B?Vlc0WUQ4NENlcXJ0MDBFUFdHU1J2UnJ4SGxHQjJEL05FZzdEdk4vMFdldzEx?=
 =?utf-8?B?L1AycFdCeDNpa1loVnNhQ0p0UFN4L3pydlpQa1RxRVdkMjhOMm1BeTNDdmRY?=
 =?utf-8?B?dW41MXhwdWJObG1vUHNYYjZqVEpMMHVlN3BURUdSTlg4VFJZWk5wMEVub1ov?=
 =?utf-8?B?NkxiSGhrQmtoNUFXTEJsOGV3azF4Q0lBeGFIOGYrL1RLUG5kOFp6bXM3Q3I1?=
 =?utf-8?B?WEE1L1h4eExDODFKWktYR2wzcnJtbnlhU2JHVXJsUFJqNHhOUVUyT1E5VlJ0?=
 =?utf-8?B?RFVpVW1TNDBCRzJyZURWVGZaKzJtNURYQ004Z1JFRjVOdHVpUG5QRVI3NXBY?=
 =?utf-8?B?emlsNFovNzJEc2plcGRnTGd2T2lRTjNieFluR0tyZU5NeEJUV1I5RmFiMHlX?=
 =?utf-8?B?WFFNYTZQTmNtWGpmam1GUlBuSWhSRFZReDZOOFhhMk9ESC9IaXhpRis2RDNj?=
 =?utf-8?B?UFNZVXZkZERSSC82ay9uUy85WlhKM29waWo0T3Zmald5V1hCYUNXKzdYSDJN?=
 =?utf-8?B?TGZLelAxK3JEQVdQSk94aXNwZ2dQdDFNS2UzQkxNYmVTc3dUSWdJUVVEQWJa?=
 =?utf-8?B?LzNCMEh6a2xuVVd5YU45elFnRk1wTEd3L2RNa3hBMWIvMUMybWZCRUVHZXd6?=
 =?utf-8?B?Yy94Q3pPejFxcTMzQS9CeVNCNnJXTkVqRWw1R01OSkwrQTR3eW9DNW5EYkc5?=
 =?utf-8?B?R0VwQ2pVUkg2bk5pQ3ppVzd1VndjcFFXVlV1SGdjY3hnVEdGdHNLbEF4bEJH?=
 =?utf-8?B?ZE4wSERxcnNicVZQTkVDdTY4WTFCUTB2dytCemNGVDNjNHFXQWowZms2cTg1?=
 =?utf-8?B?ZkpjMWVOYjExamdscURWSDVaNUtQeFFOei80MUNvTGZOT1VhdHUyZ1pIRnFa?=
 =?utf-8?B?OWUvMjdYRGdScDd1R2hRczdmSUhNM1JNODUyYmI1VXRMTTlSUjBLdS9tUjNT?=
 =?utf-8?B?ZkpneXpjWTZnZUh1aXRtaTlQNGZPcXBMQ3JvM0NTSmpwUTFJSnBVbEFucWJC?=
 =?utf-8?B?SFgwNDdnQ3ZkcDlMNlUwc1ZibFcxVVY4a3pKa0VvMFVYeDM5cytDNy9OeTlr?=
 =?utf-8?B?SDJvVDZsOSttV2pla0duMTJSc2liY21TWDZYQnJmVDJSTExzM3VCRDd5K3Vn?=
 =?utf-8?B?V3d6THBCa1laNW5YZ3ppcWxmaHlSaS9QVDR3K0ZlOEc0Lzh3TUdTODJBZ09q?=
 =?utf-8?B?NGg4QVArODhNdXpCdnJqc1V2cUxxTVZoWElvWTA0YmhuUXdTVDllWHJwb1BQ?=
 =?utf-8?B?M3FRNC93MU1WV1RUVFNCWkdENzFOdlVyUXVacmdOTU5ic0oxSUVFWTBUdlRr?=
 =?utf-8?Q?kMI9MB?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:55:43.8627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a29b0df2-28e9-44c2-9161-08ddf20c7302
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C711.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8259
X-Authority-Analysis: v=2.4 cv=OaqYDgTY c=1 sm=1 tr=0 ts=68c43472 cx=c_pps a=TPI4aLKDjCd1EbHbt8/hbw==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=d2j-ISUXm-8A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=pGLkceISAAAA:8 a=8b9GpE9nAAAA:8 a=RuKwHrkmIdvFytnfrUcA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: S784noySfHsOQOEe0kyVyaW-L8ObPYi-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA3MDAwNiBTYWx0ZWRfXxFoQn9IkcGw0 rJv4fJ+fpE54W9xcLyvrpHUQ488WeyLwbX/EeIXRqA5uQA8W7J6C6A4x20p6YAHe8NE7653kli1 V0HQUkV/3EXcQSXIKF6ib6pJoN6AvQXTlVjw5otBaicohz4igHR7hPkJqLbetk7ablp4IceeFT7
 gwO6/+7gary47h4257RrOA9ywwhL9xkr/JGiZMt9jk8rzljYFKO0njKbmBs1qYIiK5aT0uMNNOB 7h8iUAynBVvYe7xvFRDpNuLtZzE/kOW9Ph2PQlbUq+eCnmBns/HQJaUiLCGaQHbjgpccs3L+RpZ x6v1TKmm/0NRG8/TbWNN+SN5EvuwYsBWD3RoSE4+U/FxcmzE/q44VKKf2V4nTRsrP3e8FiWohVh h5l7CBEu
X-Proofpoint-GUID: S784noySfHsOQOEe0kyVyaW-L8ObPYi-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_05,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 impostorscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509070006



On 9/12/25 16:43, Patrice CHOTARD wrote:
> 
> 
> On 9/8/25 09:21, Raphael Gallais-Pou wrote:
>> Following the removal of B2120 board support, the st/stih407-clock.dtsi
>> file has been left unused.  Remove it.
>>
>> Fixes: dee546e1adef ("ARM: sti: drop B2120 board support")
>> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
>> ---
>>  arch/arm/boot/dts/st/stih407-clock.dtsi | 210 --------------------------------
>>  1 file changed, 210 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/st/stih407-clock.dtsi b/arch/arm/boot/dts/st/stih407-clock.dtsi
>> deleted file mode 100644
>> index 350bcfcf498bc410ebdb4fd00f2e1ea496a9c8be..0000000000000000000000000000000000000000
>> --- a/arch/arm/boot/dts/st/stih407-clock.dtsi
>> +++ /dev/null
>> @@ -1,210 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0-only
>> -/*
>> - * Copyright (C) 2014 STMicroelectronics R&D Limited
>> - */
>> -#include <dt-bindings/clock/stih407-clks.h>
>> -/ {
>> -	/*
>> -	 * Fixed 30MHz oscillator inputs to SoC
>> -	 */
>> -	clk_sysin: clk-sysin {
>> -		#clock-cells = <0>;
>> -		compatible = "fixed-clock";
>> -		clock-frequency = <30000000>;
>> -	};
>> -
>> -	clk_tmdsout_hdmi: clk-tmdsout-hdmi {
>> -		#clock-cells = <0>;
>> -		compatible = "fixed-clock";
>> -		clock-frequency = <0>;
>> -	};
>> -
>> -	clocks {
>> -		#address-cells = <1>;
>> -		#size-cells = <1>;
>> -		ranges;
>> -
>> -		/*
>> -		 * A9 PLL.
>> -		 */
>> -		clockgen-a9@92b0000 {
>> -			compatible = "st,clkgen-c32";
>> -			reg = <0x92b0000 0x10000>;
>> -
>> -			clockgen_a9_pll: clockgen-a9-pll {
>> -				#clock-cells = <1>;
>> -				compatible = "st,stih407-clkgen-plla9";
>> -
>> -				clocks = <&clk_sysin>;
>> -			};
>> -
>> -			clk_m_a9: clk-m-a9 {
>> -				#clock-cells = <0>;
>> -				compatible = "st,stih407-clkgen-a9-mux";
>> -
>> -				clocks = <&clockgen_a9_pll 0>,
>> -					 <&clockgen_a9_pll 0>,
>> -					 <&clk_s_c0_flexgen 13>,
>> -					 <&clk_m_a9_ext2f_div2>;
>> -
>> -				/*
>> -				 * ARM Peripheral clock for timers
>> -				 */
>> -				arm_periph_clk: clk-m-a9-periphs {
>> -					#clock-cells = <0>;
>> -					compatible = "fixed-factor-clock";
>> -
>> -					clocks = <&clk_m_a9>;
>> -					clock-div = <2>;
>> -					clock-mult = <1>;
>> -				};
>> -			};
>> -		};
>> -
>> -		clockgen-a@90ff000 {
>> -			compatible = "st,clkgen-c32";
>> -			reg = <0x90ff000 0x1000>;
>> -
>> -			clk_s_a0_pll: clk-s-a0-pll {
>> -				#clock-cells = <1>;
>> -				compatible = "st,clkgen-pll0-a0";
>> -
>> -				clocks = <&clk_sysin>;
>> -			};
>> -
>> -			clk_s_a0_flexgen: clk-s-a0-flexgen {
>> -				compatible = "st,flexgen", "st,flexgen-stih407-a0";
>> -
>> -				#clock-cells = <1>;
>> -
>> -				clocks = <&clk_s_a0_pll 0>,
>> -					 <&clk_sysin>;
>> -			};
>> -		};
>> -
>> -		clk_s_c0: clockgen-c@9103000 {
>> -			compatible = "st,clkgen-c32";
>> -			reg = <0x9103000 0x1000>;
>> -
>> -			clk_s_c0_pll0: clk-s-c0-pll0 {
>> -				#clock-cells = <1>;
>> -				compatible = "st,clkgen-pll0-c0";
>> -
>> -				clocks = <&clk_sysin>;
>> -			};
>> -
>> -			clk_s_c0_pll1: clk-s-c0-pll1 {
>> -				#clock-cells = <1>;
>> -				compatible = "st,clkgen-pll1-c0";
>> -
>> -				clocks = <&clk_sysin>;
>> -			};
>> -
>> -			clk_s_c0_quadfs: clk-s-c0-quadfs {
>> -				#clock-cells = <1>;
>> -				compatible = "st,quadfs-pll";
>> -
>> -				clocks = <&clk_sysin>;
>> -			};
>> -
>> -			clk_s_c0_flexgen: clk-s-c0-flexgen {
>> -				#clock-cells = <1>;
>> -				compatible = "st,flexgen", "st,flexgen-stih407-c0";
>> -
>> -				clocks = <&clk_s_c0_pll0 0>,
>> -					 <&clk_s_c0_pll1 0>,
>> -					 <&clk_s_c0_quadfs 0>,
>> -					 <&clk_s_c0_quadfs 1>,
>> -					 <&clk_s_c0_quadfs 2>,
>> -					 <&clk_s_c0_quadfs 3>,
>> -					 <&clk_sysin>;
>> -
>> -				/*
>> -				 * ARM Peripheral clock for timers
>> -				 */
>> -				clk_m_a9_ext2f_div2: clk-m-a9-ext2f-div2s {
>> -					#clock-cells = <0>;
>> -					compatible = "fixed-factor-clock";
>> -
>> -					clocks = <&clk_s_c0_flexgen 13>;
>> -
>> -					clock-output-names = "clk-m-a9-ext2f-div2";
>> -
>> -					clock-div = <2>;
>> -					clock-mult = <1>;
>> -				};
>> -			};
>> -		};
>> -
>> -		clockgen-d0@9104000 {
>> -			compatible = "st,clkgen-c32";
>> -			reg = <0x9104000 0x1000>;
>> -
>> -			clk_s_d0_quadfs: clk-s-d0-quadfs {
>> -				#clock-cells = <1>;
>> -				compatible = "st,quadfs-d0";
>> -
>> -				clocks = <&clk_sysin>;
>> -			};
>> -
>> -			clk_s_d0_flexgen: clk-s-d0-flexgen {
>> -				#clock-cells = <1>;
>> -				compatible = "st,flexgen", "st,flexgen-stih407-d0";
>> -
>> -				clocks = <&clk_s_d0_quadfs 0>,
>> -					 <&clk_s_d0_quadfs 1>,
>> -					 <&clk_s_d0_quadfs 2>,
>> -					 <&clk_s_d0_quadfs 3>,
>> -					 <&clk_sysin>;
>> -			};
>> -		};
>> -
>> -		clockgen-d2@9106000 {
>> -			compatible = "st,clkgen-c32";
>> -			reg = <0x9106000 0x1000>;
>> -
>> -			clk_s_d2_quadfs: clk-s-d2-quadfs {
>> -				#clock-cells = <1>;
>> -				compatible = "st,quadfs-d2";
>> -
>> -				clocks = <&clk_sysin>;
>> -			};
>> -
>> -			clk_s_d2_flexgen: clk-s-d2-flexgen {
>> -				#clock-cells = <1>;
>> -				compatible = "st,flexgen", "st,flexgen-stih407-d2";
>> -
>> -				clocks = <&clk_s_d2_quadfs 0>,
>> -					 <&clk_s_d2_quadfs 1>,
>> -					 <&clk_s_d2_quadfs 2>,
>> -					 <&clk_s_d2_quadfs 3>,
>> -					 <&clk_sysin>,
>> -					 <&clk_sysin>,
>> -					 <&clk_tmdsout_hdmi>;
>> -			};
>> -		};
>> -
>> -		clockgen-d3@9107000 {
>> -			compatible = "st,clkgen-c32";
>> -			reg = <0x9107000 0x1000>;
>> -
>> -			clk_s_d3_quadfs: clk-s-d3-quadfs {
>> -				#clock-cells = <1>;
>> -				compatible = "st,quadfs-d3";
>> -
>> -				clocks = <&clk_sysin>;
>> -			};
>> -
>> -			clk_s_d3_flexgen: clk-s-d3-flexgen {
>> -				#clock-cells = <1>;
>> -				compatible = "st,flexgen", "st,flexgen-stih407-d3";
>> -
>> -				clocks = <&clk_s_d3_quadfs 0>,
>> -					 <&clk_s_d3_quadfs 1>,
>> -					 <&clk_s_d3_quadfs 2>,
>> -					 <&clk_s_d3_quadfs 3>,
>> -					 <&clk_sysin>;
>> -			};
>> -		};
>> -	};
>> -};
>>
>> ---
>> base-commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c
>> change-id: 20250907-master-bb115f5b67ad
>>
>> Best regards,
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
> Patrice

Applied to sti-next

Thanks
Patrice


