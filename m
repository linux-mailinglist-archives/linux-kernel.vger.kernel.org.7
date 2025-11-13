Return-Path: <linux-kernel+bounces-899596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1FDC586A1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD6C34F1FEF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAE534FF67;
	Thu, 13 Nov 2025 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="UHEC744r"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C346345CCA;
	Thu, 13 Nov 2025 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046872; cv=fail; b=HUFfuqKacRT1c+07tqdPeJaQ9uJwvh3l2zoyLW/uoRwShNLuT7k33LH7gDpG6ky0mIJWKjo95w+9zH+fYkNZ2bIgObBgx43uRKqESRt7tDy99MdRNZ47I1U33jlGj/cJj1VUXs+fSNcCy03FHv08NHoS8yxzrif249FryIQjWuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046872; c=relaxed/simple;
	bh=Vu0cuNl8laYYZvCV1jNOEGKXcBKQ6dEZRP1HnPjMcyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LuRB2zKKY736Yq85WIKjNJuUtaYQa9wYWw6DGVxUt6xsADY59kCOIMv9JrvPwoYlCQY7uMgir2MqVrGVouvMwR1S978lobJTwfCQTVU279d4o9H3ZzydYpsP24dO13A9tF61PqClcRXaILCx693lvo8dBDw4r8ix4HgzW1qgJ28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=UHEC744r; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADF5E7S4145766;
	Thu, 13 Nov 2025 16:14:06 +0100
Received: from am0pr83cu005.outbound.protection.outlook.com (mail-westeuropeazon11010028.outbound.protection.outlook.com [52.101.69.28])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4adan2j281-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 16:14:06 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YD/oV2yhO5Gw2cY8qNIbwSNrEAKESxpzYvgEYBBFtDYAC7d8lo0U2pLxe/3/HYChxRvpqY8KXqpVttbk2arLZsdEGOuDZBRpvSEL/awQb5bVDMwGEQ0lhL+CRTSj4++e4AHE+lWDjZE2//bQflq0TiDWB7nsJPM2b1x0O+27Q9iYLBhKdcttPe+SuB3X5HK82BCDJgvTNBG39cowi4F0K7VlscrokMbmBnJqKyE4/aJqUIF0cBgKRpLS7R7wEPU0649xkCUxPncIKaXyA8Tf3RYyecx4fpbOe49sZGzIYu03K5oS15/yh0UjENlJL7v/1tMXiSMQfa2+4av7ix7ppA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+OH33L8crjGZWkxbGA4Yns9O2R75OVIawlulSTOr7c=;
 b=LrWxofqUXIdj2m7yUWkOKsfRFVzQJtALrinKO5Zvc5cKDtrUkSuNM0+rpHdYOQr5DQlXMyaa9P6eI865YoDAbGOrIo2DbskCCV1lTGaeDdDBVhkzaIdkIuB/kP3oksj1EvzYVQq2tX9i4pmgDsbROJ8zHIkoczsyMMYy4i3tlOXKYx6ey7d9yRDO0hE/Z6XBUZWeaIdEdOYf4KLoVDmXNjwi9+8pNNc27SIfLcoRlHElj8iWhERkzqQfxPWxj+lSCBczMC6Q+U8I4g5F4cOpxubzenmMAEUADfn7tFg3EmxPtJ8vmDkhCre5YJLH543K131bkBkZen9OQJLTIEoK/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+OH33L8crjGZWkxbGA4Yns9O2R75OVIawlulSTOr7c=;
 b=UHEC744rTseLLsU3DGwCLdVAietNjPcgdbLL34p3VTZCAra74QWonKT4Te2E6nlyy+GYNnKx1uTwHCjO4mmYffJN4K5/9ClVTtFoc7JcYT8VCrhY8tkZDXBiAL40gle8UQIieFkZqB9j59UKLZhj8o/MhmjRzX/I3PGHMJyPBp+W1Ug17YyFO+X5dA+fc/nbdLbc07K5+K65dLqvF7+qpgki75ROtxxduzBLZcR9fx2C7s6ChrPZylXbPXT4exmWGmj1tIl3j/AqdidEKkFyilL3aZtZVYxG+tFm81fEEafpUDvzPsilRjJqAkdcW3WeQqUEgg3UNrqPT7X2/YqeJA==
Received: from AM8P190CA0008.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::13)
 by DU4PR10MB8351.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:561::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 15:14:04 +0000
Received: from AMS0EPF000001B3.eurprd05.prod.outlook.com
 (2603:10a6:20b:219:cafe::58) by AM8P190CA0008.outlook.office365.com
 (2603:10a6:20b:219::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Thu,
 13 Nov 2025 15:14:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF000001B3.mail.protection.outlook.com (10.167.16.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 15:14:04 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:14:14 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:14:02 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 13 Nov 2025 16:14:01 +0100
Subject: [PATCH v2 10/16] ARM: dts: stm32: Update LED nodes for
 stm32h747i-disco
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251113-upstream_update_led_nodes-v2-10-45090db9e2e5@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B3:EE_|DU4PR10MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: 10607f7a-914a-4164-ab57-08de22c74865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzFXZ1VhTnF2YTVsODRhSys3OGZvRGhzVzA3YW1yQlhZbmJPOUJud3g3NmJJ?=
 =?utf-8?B?TDl0YjhLZ2xRdEFucTliZ2FIWE1QYW44dTdLeXNJK1haT01YS3pRUGFmbnY1?=
 =?utf-8?B?WlEzdUlPV0l3NWJaOHlYMnNxeXZTQjNRVjErS2l4Y1BsTFVManowa1JDcWxV?=
 =?utf-8?B?VktyS3IwWU90T1ZzSVhXOUo2eityM1Brekw5cnE0RVdtenZBS21XVFFVaWQ2?=
 =?utf-8?B?R1IxOVFhckQ4bU1UczhZNVM5aWR2cHErcU9RM3htZTV5ZWpMU25BSlJ5T2kx?=
 =?utf-8?B?TlpkQ0hleEIxbHUwOEFWR1UyOGJGQnhtaERpaExyY0Rmd2RPeGdUYmFFcGh3?=
 =?utf-8?B?bHExdURzYXFQWVZmclI2eHQ0bFh2SE8yMzZ2TzlrSk9lN1J0cCt1NkhkajZR?=
 =?utf-8?B?K1FQTkNWOXFpTlhJWnU1alBWSmVwQzk1dnI0U3VpSkZGLzJoZ2E5KzJobTRp?=
 =?utf-8?B?dWhEekN4a1FCNkRsa1Nta2ZscGJ4aXFUN2ZpdW4yN3hZbVdaWWtlcFR1UTA3?=
 =?utf-8?B?TlJTWmdjTU50WDhLMFQ0WjB4TERNMkUxSEtRcEZMWUVMK3lUdFN5Rk1mSnlV?=
 =?utf-8?B?RkVSK2tjRkpCczNDNlpmTEFKMUorKzArUXBSUHZOWDdWS0xySnRzL0hvVGVz?=
 =?utf-8?B?dFpvc1pLcmNmdUxkbHRwWGJzNUhNNlhZU1dXcGtIU3REMGdzZ29iNmFxTzFp?=
 =?utf-8?B?QVlWcllCb3E5VFlUZWE1TFRFNlhZSVNtR2FZdDJvYjRLTVNRcmZUYnplMnFK?=
 =?utf-8?B?b291aDluSi8ybzFnQk94dlE1djV3R0ZHMk5iOUlBbWxxQVkxOFNQNHdXUzRz?=
 =?utf-8?B?OWxidmMwa2VCZkYyV01HRnh3V1V2SThHZkdYQkFvSzVmWDVuSldaNnBINlRQ?=
 =?utf-8?B?U2FhOG5GcUVkbFFYamJvMlV0UUFBQk00T1l6eGlPR1lUNThkWSt5S0FQanF1?=
 =?utf-8?B?Uy83MDdMNllNRExhaUxaa24vRVMxMHRSZWJBLzRkbk1XNUwzWitJV29mZVVn?=
 =?utf-8?B?Mm5NZmpBbWFNYVR1SE5WRUpOemdNZ0FVQytDN05nZStGa0hFSVZkTFVNUFlw?=
 =?utf-8?B?Nk83cXltdkJHVDAxSk0vVEtlN1NJaHVQWDVPYXQ1bG85ZVM0RHRtZVdCbGl3?=
 =?utf-8?B?OVhQZ2RRZmlHQTFJR1NrT3lPdzhhb293eForbFBNeGkrWTlHZU5zbmtaWlVP?=
 =?utf-8?B?OGJmKzZscG53SEppYklGWjZXaHExaVlUTWtxb2F0RXlJNjFPNW14ZTROc2Ny?=
 =?utf-8?B?a3I0eFhNRFZBVThiNVZ1TDRHaHUzSk1vVFFpWW9xa080VGhySE1EUTdpYTMw?=
 =?utf-8?B?NVhJa1R6ZENBN0h4RElNcHBGaklQRjZEWW90bUd2M0x3T05uWEtjeWJMdVl6?=
 =?utf-8?B?T3JHbjQ1UDNkbXRrUlBlTlgrSmlRc09yaU52bDUvei9vNm9sazdkV28yR1Fi?=
 =?utf-8?B?akFYUmxFZHI1NXprVDY4MkhEb2xNSi9RN0x2dG5jNDdqd1NwUnRlcTJMdDlS?=
 =?utf-8?B?N0taREdPS3lvemVBeUs4QUZxcGhKUkhxQk9pVUloc0d0SERoS1ArSmxpZWFl?=
 =?utf-8?B?bms3d2tneEd4VFdXZ0dkd2hPRWQrTkNGODRhTWpQMlp2VjdxMnpQbjM5Z1B6?=
 =?utf-8?B?VDY0OGZKRVg4Y1JqVEpGekFaeE50djltY3kyNittWkhwRXdybXdMQWR6Umdv?=
 =?utf-8?B?NVBjWklZMVN2bzZIeXovYXZCUmhjcnNmOTRZSFYzMXNWTDlreDJkaUJzY29O?=
 =?utf-8?B?VzFGNXFGazAvNEdwWEZJT25hdEx2OGp6N3BEcUloRWVlQkR1Q2ZCTzg1bHVF?=
 =?utf-8?B?WTVhTk1KWTFlZ1dYdWIySW84MVhMbUZGQkJMQld4SmdydHJMS255MElqQy8r?=
 =?utf-8?B?YWFzTllacWIzS3BUWC9UcTdXQmRZWjIrZTYwTllFUnprNkQ4c1k3NkFEdVhP?=
 =?utf-8?B?RDFsTUJibjVmYWRQNmFObE1tN1BKTU1LVGFGSDFIcHk2Zm5YKzR2bXAwQmFo?=
 =?utf-8?B?cktRQ3pzS3ZNa1lmckxaRVVKQkduUFlKWlVvWjE5djRzcFliWm9NSFM1Sk5W?=
 =?utf-8?B?bUxwNWRsbjB2T3A2UmRNb0JDZFM4L2M2YXordjMwTDFjME5sSGU2b0NFV2hD?=
 =?utf-8?Q?tqS0=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 15:14:04.0832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10607f7a-914a-4164-ab57-08de22c74865
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8351
X-Proofpoint-ORIG-GUID: dRmCshN4fgahOQdMTEpkGhVPEP9RkDyR
X-Authority-Analysis: v=2.4 cv=DOiCIiNb c=1 sm=1 tr=0 ts=6915f5be cx=c_pps
 a=/VE8E5C3cZshg7htUwMT9Q==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=i6iesJtyZcC8ATvhLGEA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: dRmCshN4fgahOQdMTEpkGhVPEP9RkDyR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDExNyBTYWx0ZWRfX2gmeVIVwr6My
 C9kgP2aBpZ/I32dFRhDLOnNvVg1jeNCOv3cxo+sKyuo+s3SeoNw5dfOfCBj4QgMgB5wRqK9LOAc
 x3A29GVfrNWK1DHepIz9GGKzeq9uVqgkLdCmw8lY76dWqihtgnf5fdEk53SusYWLvT0DSn1Rn8I
 8UTidX9nEDiMw/eK71YjDtIFb5b9Io2kNkkRZ7sssFvj164dhq6z6gGa0wtZdup1sP7rHzWS+IR
 WAPIZls+QtcKS7d+XY1jkixj+Z7/pMN6Or3gtQs5KSSM40/5drnZrvbwQgKeLivrkLOZgMLigJo
 FU3yv9vG+fwhI9obdFmxNokQzkuYmCXO/3AGvPDO2ePKUx9Lznu0KKjphRsGEkY0rNZpAw95ifv
 oFr1o1pU0+8XV9rqeyZofaentnLuvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130117

Add function property for led-green node.
Add color property for LED nodes.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32h747i-disco.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32h747i-disco.dts b/arch/arm/boot/dts/st/stm32h747i-disco.dts
index 99f0255dae8e..bb6649a58bc1 100644
--- a/arch/arm/boot/dts/st/stm32h747i-disco.dts
+++ b/arch/arm/boot/dts/st/stm32h747i-disco.dts
@@ -8,6 +8,7 @@
 #include "stm32h7-pinctrl.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "STMicroelectronics STM32H747i-Discovery board";
@@ -39,16 +40,21 @@ v3v3: regulator-v3v3 {
 	leds {
 		compatible = "gpio-leds";
 		led-green {
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&gpioi 12 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
 		};
 		led-orange {
+			color = <LED_COLOR_ID_ORANGE>;
 			gpios = <&gpioi 13 GPIO_ACTIVE_LOW>;
 		};
 		led-red {
+			color = <LED_COLOR_ID_RED>;
 			gpios = <&gpioi 14 GPIO_ACTIVE_LOW>;
 		};
 		led-blue {
+			color = <LED_COLOR_ID_BLUE>;
 			gpios = <&gpioi 15 GPIO_ACTIVE_LOW>;
 		};
 	};

-- 
2.43.0


