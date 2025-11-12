Return-Path: <linux-kernel+bounces-897064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D7DC51F3A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB1FB503881
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BF630C63C;
	Wed, 12 Nov 2025 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="D9mc1k5n"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645FA30B528;
	Wed, 12 Nov 2025 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945829; cv=fail; b=B5wPCKSXNnLvT/PC7ND2NkkX6LBXzn77xfC6U0YKf+B2jetO/WKlknIYrOmqnzrh830ltUFD8Krik+P0JtdPrG44ef8R+ajPHmHPG5sB4sS9hnlibir1V6nA6a33Lds0b5aMDU0MxhAyqzG3xZ6FyyZ2rOIMzj4ISiFVtnxbh3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945829; c=relaxed/simple;
	bh=qjd0DfaGNBxV3OAJZplcebU8FQr7xJ1xAGg6BjB0x2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Ohn2WdGnBkwWA59Uaga/a/eecPGFqELMl4KbdoH2HikNAO6BMDrAjdqofDahnz5+6vSUW3Fj4XxwXVUcoTvtfof60Wvl1VD+mNvwJzhpaSZZTratQQXM3jG4444P1bDE+pVImKvnZ3rR03lEdlYKERH5llQIapK6zK9LQ0aR1uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=D9mc1k5n; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACARG1m511076;
	Wed, 12 Nov 2025 11:47:11 +0100
Received: from mrwpr03cu001.outbound.protection.outlook.com (mail-francesouthazon11011002.outbound.protection.outlook.com [40.107.130.2])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acq20gkdw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:47:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWtZw2fSmXWSAkd4toZKMwT9r1WRqHWhqhVAdwORDTg9AGzd+yF6pgja0EIgTguB0Bvcrufl9UFtAqEjkREmhhl+6uZLMZ3Rkij6JrALWfDdiLl2X+NaLdobdsnyZ9L2vwEtIhKTwC8xGLPT38f3jISzOPN7gL2/0Il4lWnL6sGxfUfX5gQXtFTx79pxGO4tRj46Gi6MqBizHIrGKjL9tRDO6Hld6MovQaKSymfzx/u0tPcRs5GQzAwbcrLedBJ7Dl+fDu8WZdx7uVUtStQkQVLvspZZr+r13Y3o053eDtcKA/eyvWNd1JiZBupOURCPN5swsi/R8DNktWcl4fNfdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcYSCJOMADMDriEkRGECQRzSEcRFL3QeCl4US+2dRF4=;
 b=oGluQcsfZk3OsdnBfXLkBueyGn79FAo4i6/YSaaKML6h7KQDW0g7TfYkSv5AYsv5wTkV3MuPshmn8QZjFvvJUxtKgVi7XirJkzTvMA5JKXV/z2iFglAf1OmVVS3Ha/RCNNYSR9ra3l6o53kTPNNNlz4fKP3myCGWIz0SGqgyYcrdihguIas2OGxHPo9XavNhJE7cnlP+aonSzRiA/7N3xQDKjhMDSipqNEoj1qsl6a7y78y7se66VoNexLfD8WpOf56tcdFxl66egYgz5LCWavZnFTcZSf9yJdObbhJsYviB6JOCPTyV8cI2art9+EYUJM5YOMiRU+/9gzcQf3D1Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcYSCJOMADMDriEkRGECQRzSEcRFL3QeCl4US+2dRF4=;
 b=D9mc1k5nUlqxnNaiyBO5a5EtM/YqbU/vmvOfoDkTA8RsOFC/ce6OfCpd8aSdOiZJUfhhlguYTGUE2hY3bLOfsUDiCS6hqbzMlhkR3NG3zI+FWm9gNOdjm/rMsDaNYKwwlQstUqhVWXIR9LTwfqnEyZNTQPQwDasSz52tBEo9z5hbVuSjoNooN/ZsMItKpgQA7n5irHzE8OgcZ+T2knlDf7KtwKzf5lW43tsD7q4OsvcdcViVvCjHnff2pTlj/HGQbGXdRRxvmfjqNLSsU3Mj5z9/OU1a5+z9bN2xh4wgMV/ZaKZd+aSCsWI0g+FGvf+F4ZMdNfC+e+qDbRb0Ud80lQ==
Received: from AS4P191CA0049.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::8)
 by PA3PR10MB9329.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 12 Nov
 2025 10:47:09 +0000
Received: from AM2PEPF0001C70E.eurprd05.prod.outlook.com
 (2603:10a6:20b:657:cafe::4b) by AS4P191CA0049.outlook.office365.com
 (2603:10a6:20b:657::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 10:47:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM2PEPF0001C70E.mail.protection.outlook.com (10.167.16.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 10:47:08 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 11:47:19 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 11:47:07 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 11:46:47 +0100
Subject: [PATCH 5/6] ARM: dts: stm32: Add boot phase tags for
 STMicroelectronics mp15 boards
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_uboot_properties-v1-5-0b19133710e3@foss.st.com>
References: <20251112-upstream_uboot_properties-v1-0-0b19133710e3@foss.st.com>
In-Reply-To: <20251112-upstream_uboot_properties-v1-0-0b19133710e3@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70E:EE_|PA3PR10MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a85890-09e2-478f-28f3-08de21d8d412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmIrdXZ2ZVRGSmZnQUQ2REUzK3R6MHY4R2VJd2VlS1RQU1BHcWZCL0YrOXhQ?=
 =?utf-8?B?ZUZLbDIrMDBORjdOUmZEVU1EZXhOWnF3MW1LYWUyTjhGb3h6OG9LbXdLVlF0?=
 =?utf-8?B?RUM3VnRxWjQraXdPODBkelJYQ2dqVjBXM1VrSENNSU9raEN5WWI5NnZYeXVT?=
 =?utf-8?B?RFRIeXpOTG1neXV3WFhERjc3bVVUVFJMTDVIYUlqcHU5VE5ralZ2L0F2azJw?=
 =?utf-8?B?bU1sZ0pxL3R0d2JYa1ZncDlvaFZSMUtXNUNoZTJhSTcycWt0b21lcmdOSDBQ?=
 =?utf-8?B?YUtxcmV5WHhSSW5QbVdoaVFzQ2pFRTJVOUJhdmlnYXU2dGFzSkdSNit3amVj?=
 =?utf-8?B?a2lYUURNZVZTYVZKYlJ0Q0g4bjFtbTJ0eXFZalZ6bkVoMENPZXVraHVzZ3pr?=
 =?utf-8?B?RGVLV2VGeTlnazFZaW44Z0NnSTBBOTZXdThSR2JsNkdPRU1LZWVIcGprbnU3?=
 =?utf-8?B?a0lSSkxJZkZWSlErZkFGa1lhQW5zZDBJdVdjdUlHbmlzZGk1dW4wVlpnNzBs?=
 =?utf-8?B?Vi9uQ2xzTmE5TU10bzM3QzlKVzF5QzVUMGFoWDB2NENtTUdZWGpDQzlScUV4?=
 =?utf-8?B?bU90YXAyRUxZdG9KRjV4bDdOSWluUWp4MXdRK3QxQW5NK00zWTA1ZlQ3R1pj?=
 =?utf-8?B?dlo0TVhaWFBrN2s3dVZuVEgySzgvTzd0dk51MnVBMlVuR09Ub29waG02Nmpx?=
 =?utf-8?B?NDFYVUwyMzBGZ1hSVnFuS3V1bDBnOStHbkwzYjIyNHdWM2Q3dTJITVd2aGdx?=
 =?utf-8?B?RG9EaTZ0S0RHYlhSZ095STIraHV4clUwR1F0alFkTmdRSmp6b0VNZGpEQ1lD?=
 =?utf-8?B?RnpLWXdKSmFXOFB5VEg1UW5aRTEvK3hGOS9rLytrV1FYYlZFZVUxQUxzYXJD?=
 =?utf-8?B?UUFvSGFwNUJCY0tjV1lYODNJZmwvZlVjbE4zWWNxQTdpMk5mYlVOOU9zZmNo?=
 =?utf-8?B?cnFjL3JNNmtjOFFKaWNSWVg5anpZaXJhcityODRMTzBOZDBRMnJBc1V5Zi85?=
 =?utf-8?B?OEtHNUFGb3JTVUtIT1c4MHVoTGlscGJyWXczRGxpSnEyQ3VEVno4dWxLN1RE?=
 =?utf-8?B?aEo2NzZDL1dHV0lpMG5xRHc2eEZkbHllaUpYcWhLbERoTVNBM2ZEY3lzb09k?=
 =?utf-8?B?dGQ0Rjd1SEJjRThuYm9iL1Fna1ZPM2dKa2xKclZNWFdhc0xMc080d3hkdVAz?=
 =?utf-8?B?ZGEwQkZ0bGU4bmlmYzVHZW5ncHB2c28rYUFKemh4ejdheGNhbURlYzVJRlZE?=
 =?utf-8?B?ZTJCeTFnSDVTeCtZc0tGS1d1bE9raXVaNC94TkxSbXhFNTdybE1HUkpLQnla?=
 =?utf-8?B?SmNSZFdkZW8yM1pXM2JweklxaXdJRFhKb2p5dm12RjVWUllRNHV1UUE4KzJX?=
 =?utf-8?B?VnR1NHVDSzVoRlFqVGp2MXJLd2JSaDJHcm1KKzE4ZjIzb3MraWR6SUs2Nm9U?=
 =?utf-8?B?OUtrRStWcUJnUmo3YkdCQlB2M3ZNUVN5SGM3eGJneVYxVWRuOHdpZnBibno2?=
 =?utf-8?B?S3o2c0lBdGc2K1oyeUNFb0Nic3JMQlFDamVpVzlDT3c4ZCtkQnJOUzQyV212?=
 =?utf-8?B?Si9wQWxIOCtUSFpGN2NaVm9XK1dEeFhOZlV5OFBJM3M2TnJ2OTBVZkNUWmJO?=
 =?utf-8?B?YkZ2Z0Z6ZENoNWJsSGo5dDJXdFNrME9IQ2JtdS83WXdvUHNVZUo3aTFBblJ4?=
 =?utf-8?B?cVhBYkNTb3VsTkRobXN4d2VZNkkyV0ZjdGNwOUdCQlZuaGtDRjhpbW5VVkU4?=
 =?utf-8?B?dGNxRlU5SFlZQXdJQjdQN2hueE1XNE5OWWtyOHkwcFB4T0hZa1FsZ2IvclFI?=
 =?utf-8?B?YmFwVnhjTmVFSUpHSE40Wk1qcXMwZ2RCdW9uS2JHTEczTHRMUGlkcXgrVXFU?=
 =?utf-8?B?VVR4dkRIbmxJcWJxN0VzMVJBeU0rOTdFbW5vSjhLdVBLUVJadXdpcXBEdk5S?=
 =?utf-8?B?cHpKK1hLa3k1Nmt3VkQvUG1NaUhuUk4yayt4cG1XNVB1THpqTCtZMU05UEps?=
 =?utf-8?B?VE8xcGEwY0QrU24wU21VeDdQbExkcHJTWDhVaWU0Sk80VXZJTEluOEROK1B5?=
 =?utf-8?B?K1IyV1dwYy94TnE3SEdtVlp1R2gwN1pjZEVTWnRTUUtwL2hRYW9PdHFIcEt0?=
 =?utf-8?Q?reTM=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 10:47:08.6967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a85890-09e2-478f-28f3-08de21d8d412
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9329
X-Proofpoint-GUID: GmFGnVtlJ5MCp7pmBh-nbF6bLkDWnrb0
X-Authority-Analysis: v=2.4 cv=LaQxKzfi c=1 sm=1 tr=0 ts=691465af cx=c_pps
 a=SGe/7azyRjuZN0HCPUD+aw==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=44I5eye_6M4fdnXrIMoA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: GmFGnVtlJ5MCp7pmBh-nbF6bLkDWnrb0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA4NiBTYWx0ZWRfX7AWlPn5273fx
 qoFCeL2V3euXqskpf9HJ1Ov7J8lNZIPzsgWiA6MW3EH7ToFLAYqG0mmKUu27RZ7ASLT5yOXmeih
 /11pEI1wSw2nvEg7YWUm1zL198W/WbSiGQJdLycTDYrdiXrXhxEmS+KvztSbxrii8Hem9s6UpeQ
 aZh/usxpQ2kzx9X2is4KhjnXy7O7xjTSetbJ3Gjh6eGLuSjwBIwIdUw3fOa9eNVbc7nWp6IXPaL
 Xg723xojgaAWC0XDIZ1ZE950aryyFHOZiqEfAkc/xPKSyTcYMCO5ItVYjPQlgLXnjpApOX26/tr
 difD65dm8Ym2zvjOhdPzrBO7EUaH4cWTzyRG8K6Y46Sg2MNRJHlPysnD+J+4a67cy2rGYdf/Me8
 IEQCcnKCqYVuX7dgD48+HJHJxspJhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120086

The bootph-all flag was introduced in dt-schema
(dtschema/schemas/bootph.yaml) to define node usage across
different boot phases.

To ensure SD boot, timer, gpio, syscfg, clock and uart nodes need to be
present in all boot stages, so add missing bootph-all phase flag
to these nodes to support SD boot.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp15-scmi.dtsi      | 26 ++++++++++++
 arch/arm/boot/dts/st/stm32mp151.dtsi          | 29 +++++++++++++
 arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts | 14 +++++++
 arch/arm/boot/dts/st/stm32mp157a-dk1.dts      | 43 +++++++++++++++++++
 arch/arm/boot/dts/st/stm32mp157c-dk2.dts      | 43 +++++++++++++++++++
 arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts | 14 +++++++
 arch/arm/boot/dts/st/stm32mp157c-ed1.dts      | 60 +++++++++++++++++++++++++++
 arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts | 31 ++++++++++++++
 arch/arm/boot/dts/st/stm32mp157c-ev1.dts      | 36 ++++++++++++++++
 9 files changed, 296 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp15-scmi.dtsi b/arch/arm/boot/dts/st/stm32mp15-scmi.dtsi
index 98552fe45d4e..c58d81f505be 100644
--- a/arch/arm/boot/dts/st/stm32mp15-scmi.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15-scmi.dtsi
@@ -13,6 +13,7 @@ optee: optee {
 			method = "smc";
 			interrupt-parent = <&intc>;
 			interrupts = <GIC_PPI 15 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
+			bootph-some-ram;
 		};
 
 		scmi: scmi {
@@ -20,6 +21,7 @@ scmi: scmi {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			linaro,optee-channel-id = <0>;
+			bootph-some-ram;
 
 			scmi_clk: protocol@14 {
 				reg = <0x14>;
@@ -64,6 +66,26 @@ scmi_usb33: regulator@2 {
 	};
 };
 
+&iwdg2 {
+	bootph-all;
+};
+
+&ltdc {
+	bootph-some-ram;
+};
+
+&pinctrl {
+	bootph-all;
+};
+
+&pinctrl_z {
+	bootph-all;
+};
+
+&rcc {
+	bootph-all;
+};
+
 &reg11 {
 	status = "disabled";
 };
@@ -72,6 +94,10 @@ &reg18 {
 	status = "disabled";
 };
 
+&scmi {
+	bootph-some-ram;
+};
+
 &usb33 {
 	status = "disabled";
 };
diff --git a/arch/arm/boot/dts/st/stm32mp151.dtsi b/arch/arm/boot/dts/st/stm32mp151.dtsi
index b1b568dfd126..7abee7ce0580 100644
--- a/arch/arm/boot/dts/st/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp151.dtsi
@@ -33,6 +33,7 @@ arm-pmu {
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+		bootph-some-ram;
 	};
 
 	intc: interrupt-controller@a0021000 {
@@ -54,34 +55,41 @@ timer {
 	};
 
 	clocks {
+		bootph-all;
+
 		clk_hse: clk-hse {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
+			bootph-all;
 		};
 
 		clk_hsi: clk-hsi {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <64000000>;
+			bootph-all;
 		};
 
 		clk_lse: clk-lse {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
+			bootph-all;
 		};
 
 		clk_lsi: clk-lsi {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <32000>;
+			bootph-all;
 		};
 
 		clk_csi: clk-csi {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <4000000>;
+			bootph-all;
 		};
 	};
 
@@ -122,6 +130,7 @@ soc {
 		#size-cells = <1>;
 		interrupt-parent = <&intc>;
 		ranges;
+		bootph-all;
 
 		ipcc: mailbox@4c001000 {
 			compatible = "st,stm32mp1-ipcc";
@@ -142,11 +151,13 @@ rcc: rcc@50000000 {
 			reg = <0x50000000 0x1000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			bootph-all;
 		};
 
 		pwr_regulators: pwr@50001000 {
 			compatible = "st,stm32mp1,pwr-reg";
 			reg = <0x50001000 0x10>;
+			bootph-all;
 
 			reg11: reg11 {
 				regulator-name = "reg11";
@@ -354,6 +365,7 @@ ltdc: display-controller@5a001000 {
 			clocks = <&rcc LTDC_PX>;
 			clock-names = "lcd";
 			resets = <&rcc LTDC_R>;
+			bootph-some-ram;
 			status = "disabled";
 		};
 
@@ -364,6 +376,7 @@ iwdg2: watchdog@5a002000 {
 			clock-names = "pclk", "lsi";
 			interrupts-extended = <&exti 46 IRQ_TYPE_LEVEL_HIGH>;
 			wakeup-source;
+			bootph-all;
 			status = "disabled";
 		};
 
@@ -404,6 +417,8 @@ bsec: efuse@5c005000 {
 			reg = <0x5c005000 0x400>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			bootph-all;
+
 			part_number_otp: part-number-otp@4 {
 				reg = <0x4 0x1>;
 			};
@@ -1876,6 +1891,7 @@ pinctrl: pinctrl@50002000 {
 			ranges = <0 0x50002000 0xa400>;
 			interrupt-parent = <&exti>;
 			st,syscfg = <&exti 0x60 0xff>;
+			bootph-all;
 
 			gpioa: gpio@50002000 {
 				gpio-controller;
@@ -1885,6 +1901,7 @@ gpioa: gpio@50002000 {
 				reg = <0x0 0x400>;
 				clocks = <&rcc GPIOA>;
 				st,bank-name = "GPIOA";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -1896,6 +1913,7 @@ gpiob: gpio@50003000 {
 				reg = <0x1000 0x400>;
 				clocks = <&rcc GPIOB>;
 				st,bank-name = "GPIOB";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -1907,6 +1925,7 @@ gpioc: gpio@50004000 {
 				reg = <0x2000 0x400>;
 				clocks = <&rcc GPIOC>;
 				st,bank-name = "GPIOC";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -1918,6 +1937,7 @@ gpiod: gpio@50005000 {
 				reg = <0x3000 0x400>;
 				clocks = <&rcc GPIOD>;
 				st,bank-name = "GPIOD";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -1929,6 +1949,7 @@ gpioe: gpio@50006000 {
 				reg = <0x4000 0x400>;
 				clocks = <&rcc GPIOE>;
 				st,bank-name = "GPIOE";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -1940,6 +1961,7 @@ gpiof: gpio@50007000 {
 				reg = <0x5000 0x400>;
 				clocks = <&rcc GPIOF>;
 				st,bank-name = "GPIOF";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -1951,6 +1973,7 @@ gpiog: gpio@50008000 {
 				reg = <0x6000 0x400>;
 				clocks = <&rcc GPIOG>;
 				st,bank-name = "GPIOG";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -1962,6 +1985,7 @@ gpioh: gpio@50009000 {
 				reg = <0x7000 0x400>;
 				clocks = <&rcc GPIOH>;
 				st,bank-name = "GPIOH";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -1973,6 +1997,7 @@ gpioi: gpio@5000a000 {
 				reg = <0x8000 0x400>;
 				clocks = <&rcc GPIOI>;
 				st,bank-name = "GPIOI";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -1984,6 +2009,7 @@ gpioj: gpio@5000b000 {
 				reg = <0x9000 0x400>;
 				clocks = <&rcc GPIOJ>;
 				st,bank-name = "GPIOJ";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -1995,6 +2021,7 @@ gpiok: gpio@5000c000 {
 				reg = <0xa000 0x400>;
 				clocks = <&rcc GPIOK>;
 				st,bank-name = "GPIOK";
+				bootph-all;
 				status = "disabled";
 			};
 		};
@@ -2006,6 +2033,7 @@ pinctrl_z: pinctrl@54004000 {
 			ranges = <0 0x54004000 0x400>;
 			interrupt-parent = <&exti>;
 			st,syscfg = <&exti 0x60 0xff>;
+			bootph-all;
 
 			gpioz: gpio@54004000 {
 				gpio-controller;
@@ -2016,6 +2044,7 @@ gpioz: gpio@54004000 {
 				clocks = <&rcc GPIOZ>;
 				st,bank-name = "GPIOZ";
 				st,bank-ioport = <11>;
+				bootph-all;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts b/arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts
index 847b360f02fc..f721c398e576 100644
--- a/arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts
+++ b/arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts
@@ -85,3 +85,17 @@ &rng1 {
 &rtc {
 	clocks = <&scmi_clk CK_SCMI_RTCAPB>, <&scmi_clk CK_SCMI_RTC>;
 };
+
+&uart4 {
+	bootph-all;
+};
+
+&uart4_pins_a {
+	bootph-all;
+	pins1 {
+		bootph-all;
+	};
+	pins2 {
+		bootph-all;
+	};
+};
diff --git a/arch/arm/boot/dts/st/stm32mp157a-dk1.dts b/arch/arm/boot/dts/st/stm32mp157a-dk1.dts
index 0da3667ab1e0..c4581e28504a 100644
--- a/arch/arm/boot/dts/st/stm32mp157a-dk1.dts
+++ b/arch/arm/boot/dts/st/stm32mp157a-dk1.dts
@@ -23,3 +23,46 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 };
+
+&i2c4 {
+	bootph-all;
+};
+
+&i2c4_pins_a {
+	bootph-all;
+	pins {
+		bootph-all;
+	};
+};
+
+&pmic {
+	bootph-all;
+};
+
+&sdmmc1 {
+	bootph-pre-ram;
+};
+
+&sdmmc1_b4_pins_a {
+	bootph-pre-ram;
+	pins1 {
+		bootph-pre-ram;
+	};
+	pins2 {
+		bootph-pre-ram;
+	};
+};
+
+&uart4 {
+	bootph-all;
+};
+
+&uart4_pins_a {
+	bootph-all;
+	pins1 {
+		bootph-all;
+	};
+	pins2 {
+		bootph-all;
+	};
+};
diff --git a/arch/arm/boot/dts/st/stm32mp157c-dk2.dts b/arch/arm/boot/dts/st/stm32mp157c-dk2.dts
index 1ec3b8f2faa9..4fc670bb4cb0 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-dk2.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-dk2.dts
@@ -79,6 +79,17 @@ touchscreen@38 {
 	};
 };
 
+&i2c4 {
+	bootph-all;
+};
+
+&i2c4_pins_a {
+	bootph-all;
+	pins {
+		bootph-all;
+	};
+};
+
 &ltdc {
 	status = "okay";
 
@@ -93,6 +104,10 @@ ltdc_ep1_out: endpoint@1 {
 	};
 };
 
+&pmic {
+	bootph-all;
+};
+
 &rtc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&rtc_rsvd_pins_a>;
@@ -103,6 +118,20 @@ rtc_lsco_pins_a: rtc-lsco-0 {
 	};
 };
 
+&sdmmc1 {
+	bootph-pre-ram;
+};
+
+&sdmmc1_b4_pins_a {
+	bootph-pre-ram;
+	pins1 {
+		bootph-pre-ram;
+	};
+	pins2 {
+		bootph-pre-ram;
+	};
+};
+
 /* Wifi */
 &sdmmc2 {
 	pinctrl-names = "default", "opendrain", "sleep";
@@ -127,6 +156,20 @@ brcmf: wifi@1 {
 	};
 };
 
+&uart4 {
+	bootph-all;
+};
+
+&uart4_pins_a {
+	bootph-all;
+	pins1 {
+		bootph-all;
+	};
+	pins2 {
+		bootph-all;
+	};
+};
+
 /* Bluetooth */
 &usart2 {
 	pinctrl-names = "default", "sleep", "idle";
diff --git a/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts b/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts
index 6f27d794d270..00d4855f9a85 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts
@@ -90,3 +90,17 @@ &rng1 {
 &rtc {
 	clocks = <&scmi_clk CK_SCMI_RTCAPB>, <&scmi_clk CK_SCMI_RTC>;
 };
+
+&uart4 {
+	bootph-all;
+};
+
+&uart4_pins_a {
+	bootph-all;
+	pins1 {
+		bootph-all;
+	};
+	pins2 {
+		bootph-all;
+	};
+};
diff --git a/arch/arm/boot/dts/st/stm32mp157c-ed1.dts b/arch/arm/boot/dts/st/stm32mp157c-ed1.dts
index f6c478dbd041..f63a3d68d2b4 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-ed1.dts
@@ -168,7 +168,9 @@ &i2c4 {
 	i2c-scl-rising-time-ns = <185>;
 	i2c-scl-falling-time-ns = <20>;
 	clock-frequency = <400000>;
+	bootph-all;
 	status = "okay";
+
 	/* spare dmas for other usage */
 	/delete-property/dmas;
 	/delete-property/dma-names;
@@ -179,6 +181,7 @@ pmic: stpmic@33 {
 		interrupts-extended = <&gpioa 0 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+		bootph-all;
 		status = "okay";
 
 		regulators {
@@ -314,6 +317,13 @@ watchdog {
 	};
 };
 
+&i2c4_pins_a {
+	bootph-all;
+	pins {
+		bootph-all;
+	};
+};
+
 &ipcc {
 	status = "okay";
 };
@@ -365,9 +375,30 @@ &sdmmc1 {
 	sd-uhs-sdr25;
 	sd-uhs-sdr50;
 	sd-uhs-ddr50;
+	bootph-pre-ram;
 	status = "okay";
 };
 
+&sdmmc1_b4_pins_a {
+	bootph-pre-ram;
+	pins1 {
+		bootph-pre-ram;
+	};
+	pins2 {
+		bootph-pre-ram;
+	};
+};
+
+&sdmmc1_dir_pins_a {
+	bootph-pre-ram;
+	pins1 {
+		bootph-pre-ram;
+	};
+	pins2 {
+		bootph-pre-ram;
+	};
+};
+
 &sdmmc2 {
 	pinctrl-names = "default", "opendrain", "sleep";
 	pinctrl-0 = <&sdmmc2_b4_pins_a &sdmmc2_d47_pins_a>;
@@ -381,9 +412,27 @@ &sdmmc2 {
 	vmmc-supply = <&v3v3>;
 	vqmmc-supply = <&vdd>;
 	mmc-ddr-3_3v;
+	bootph-pre-ram;
 	status = "okay";
 };
 
+&sdmmc2_b4_pins_a {
+	bootph-pre-ram;
+	pins1 {
+		bootph-pre-ram;
+	};
+	pins2 {
+		bootph-pre-ram;
+	};
+};
+
+&sdmmc2_d47_pins_a {
+	bootph-pre-ram;
+	pins {
+		bootph-pre-ram;
+	};
+};
+
 &timers6 {
 	status = "okay";
 	/* spare dmas for other usage */
@@ -399,11 +448,22 @@ &uart4 {
 	pinctrl-0 = <&uart4_pins_a>;
 	pinctrl-1 = <&uart4_sleep_pins_a>;
 	pinctrl-2 = <&uart4_idle_pins_a>;
+	bootph-all;
 	/delete-property/dmas;
 	/delete-property/dma-names;
 	status = "okay";
 };
 
+&uart4_pins_a {
+	bootph-all;
+	pins1 {
+		bootph-all;
+	};
+	pins2 {
+		bootph-all;
+	};
+};
+
 &usbotg_hs {
 	vbus-supply = <&vbus_otg>;
 };
diff --git a/arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts b/arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts
index 6ae391bffee5..802a492f2ed8 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts
@@ -77,6 +77,37 @@ &optee {
 	interrupts = <GIC_PPI 15 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
 };
 
+&qspi {
+	bootph-pre-ram;
+};
+
+&qspi_clk_pins_a {
+	bootph-pre-ram;
+	pins {
+		bootph-pre-ram;
+	};
+};
+
+&qspi_bk1_pins_a {
+	bootph-pre-ram;
+	pins1 {
+		bootph-pre-ram;
+	};
+	pins2 {
+		bootph-pre-ram;
+	};
+};
+
+&qspi_bk2_pins_a {
+	bootph-pre-ram;
+	pins1 {
+		bootph-pre-ram;
+	};
+	pins2 {
+		bootph-pre-ram;
+	};
+};
+
 &rcc {
 	compatible = "st,stm32mp1-rcc-secure", "syscon";
 	clock-names = "hse", "hsi", "csi", "lse", "lsi";
diff --git a/arch/arm/boot/dts/st/stm32mp157c-ev1.dts b/arch/arm/boot/dts/st/stm32mp157c-ev1.dts
index 8f99c30f1af1..879436cbb72d 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-ev1.dts
@@ -262,6 +262,7 @@ &qspi_bk2_sleep_pins_a
 	reg = <0x58003000 0x1000>, <0x70000000 0x4000000>;
 	#address-cells = <1>;
 	#size-cells = <0>;
+	bootph-pre-ram;
 	status = "okay";
 
 	flash0: flash@0 {
@@ -283,6 +284,41 @@ flash1: flash@1 {
 	};
 };
 
+&qspi_clk_pins_a {
+	bootph-pre-ram;
+	pins {
+		bootph-pre-ram;
+	};
+};
+
+&qspi_bk1_pins_a {
+	bootph-pre-ram;
+	pins {
+		bootph-pre-ram;
+	};
+};
+
+&qspi_cs1_pins_a {
+	bootph-pre-ram;
+	pins {
+		bootph-pre-ram;
+	};
+};
+
+&qspi_bk2_pins_a {
+	bootph-pre-ram;
+	pins {
+		bootph-pre-ram;
+	};
+};
+
+&qspi_cs2_pins_a {
+	bootph-pre-ram;
+	pins {
+		bootph-pre-ram;
+	};
+};
+
 &sdmmc3 {
 	pinctrl-names = "default", "opendrain", "sleep";
 	pinctrl-0 = <&sdmmc3_b4_pins_a>;

-- 
2.43.0


