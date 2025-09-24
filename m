Return-Path: <linux-kernel+bounces-830263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 907F5B993CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496BC16E654
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6772D978D;
	Wed, 24 Sep 2025 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="WY5yEPeN"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5702E1E520E;
	Wed, 24 Sep 2025 09:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707386; cv=fail; b=YxuFCHDr98hVaINDvxHCkFwRCdRi6e4JgmRAu1AcqplmROW2ZvkuV9KZFV1dc7LaRCLa6r9LyrDSKiTICvTRrHN+bE/bc1cqGqkeS/Tdc2RU8XGeBAeO9hPodYXYjWw6r1qyHr4QcT99GKlQh82mYhHnTT7fI4SNRwmsot3fA+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707386; c=relaxed/simple;
	bh=Nl/VTeWECHkuclWt29kO1lTYqmnodtBcX69hWZlDISE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P7cbtR823dy96ZNACxYNDVkaLUJfPGJvf1wbK3TtrmtBty/fNuvvswmIR9hAIETi99qeufoNl+YYdQzXpA48BAZaBR4E+wR6BOgilQJyTZakSgR1IhWWN0IckYYrBy+4/+ZzYmY2fXKW49CtSLe+uWPmbZtS1xSGhbmvTALJMjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=WY5yEPeN; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O9mtQM031212;
	Wed, 24 Sep 2025 11:49:02 +0200
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11013052.outbound.protection.outlook.com [52.101.72.52])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 499hd79ncc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 11:49:02 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/QIso2j3VDGvV7YEDVIN9WvV2kT0EmKI4PGA9tjvk9tQm04pmACAQ+TQhO7rrJmHsBp0F9d45Ej8ho5MUIq5SBvHjFf9+ujDdLxRVewqNNrrgMupxU6bP6fumldViniaByJJg6Jmjr2y1YwTx3nKX1aYFKhmMbR0zaFrGwAHV87u5gAEdykTveLishcjKiYFaCQjEeJbVMGotlTn2trWurey6QfPQh3rrE5YoNTcqTDeiP9XYeUO5FjnCAa92lzKcbUHwzE259hnu1ChHZYXyAh5eZaZLWVNs9EeE1hbXbAa0EFpWUpvQFHHwjRVCoY0efBFqGaBDgQ3H5JbVdeQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/plAAalNIFyASmZL1uXMhtsgpP9B2u6DMRkxuTVqztw=;
 b=kF6idgC3VbgB5tAsjYfbcT/M9D3JKaFGv3dHx8kJapRGRHXaYbFITwBj5v2xDNkevfNDDsSeyW9Ce7/PNnYa1EXtQWmAGrnlpVt5V8Nptm8IQjQSJNJ48e1qRYVHr2z1+HLipV3eFHtpCfp+pWqCwJzvvVI2/v2iYyl11WaAYzoIWPcagsUzmtO5wPWmKZWnym4mz2C8A0YsUmnBIzZ18bBkn9SJylk2quH7/aEB3puH1QkQKoy3oJIFja4KAJJT70ArVICtCXwbUs12YnQPUJAtq3CYdnogXqglUNF34eGr0ILaXWbTQPjGI5Q8yc9g32OnmdM12HYUqzMTtdVKDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=renesas.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/plAAalNIFyASmZL1uXMhtsgpP9B2u6DMRkxuTVqztw=;
 b=WY5yEPeN4nI/YeSj88S5e0m4LPhxnv5XiP0FoNaWy0JABFPEsxrEzUnzavmsZjJVVjchBNz/Fwro/foA7HZaH3j+qAuEClaSvXPgaL+qihhDVBqgpoDOP6yJGsjH09PUywkC82rMtPcJunrLcK3C3dvV8fux8cQU/VYgC4bBL1rYn3Fj5xnqXdSqjy+JMKwbJWhyRHPf0a+yPl5PR8JwbcUQQuZ+saMB7KmhhE5M2b0vz9ZA2diHNlU/PEp2YHj//3zV0R96EtpCy7onnBvC1WWef2M5TeqTTlzsvghHVsH1xomLppDz4/GWlNnEP2/kBagviLCQuGx6Y3l6MSKaKw==
Received: from DB9PR06CA0004.eurprd06.prod.outlook.com (2603:10a6:10:1db::9)
 by DU0PR10MB6605.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:406::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 09:49:00 +0000
Received: from DB1PEPF000509E4.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::15) by DB9PR06CA0004.outlook.office365.com
 (2603:10a6:10:1db::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 09:49:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 DB1PEPF000509E4.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 24 Sep 2025 09:49:00 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 24 Sep
 2025 11:41:40 +0200
Received: from [10.252.12.149] (10.252.12.149) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 24 Sep
 2025 11:48:58 +0200
Message-ID: <a4950a0d-32a2-4cdd-8c8a-8f451181b0d6@foss.st.com>
Date: Wed, 24 Sep 2025 11:48:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: stm32: sai: manage context in set_sysclk callback
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-sound@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250916123118.84175-1-olivier.moysan@foss.st.com>
 <87ms6taph0.wl-kuninori.morimoto.gx@renesas.com>
 <a9725bfd-a2b8-4343-83f2-d18908029ea0@foss.st.com>
 <875xdgpmq6.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <875xdgpmq6.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E4:EE_|DU0PR10MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 76b158f3-c255-4256-87f0-08ddfb4f9675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTNxT0MycENvMTNrYmhaWE5sTEpoRWxsWDNVL1RqdzdUc3l3SGNGNkxZdC9J?=
 =?utf-8?B?M1d5Tm1kWCtJV0gzU3FLN0p4L0JRZVVBcGhhQWw4cUg2T0VXbUJDQnprK0Fq?=
 =?utf-8?B?RmtGWWs1QnFLeVhRU3FZdERsUHZtQm1icmE1V2Y3SE1VVUIzNGVPbGVDVWdz?=
 =?utf-8?B?dFU3N1piOWZsVExxMVRZWExDNTI5Tm1WUGVJYTQ1eGN5R2ltRkYxZnhHQkFl?=
 =?utf-8?B?SEphWWsyZGV5OXpHRFZMQWlTOGQ4VDZUZENLMXVwdWNSMm8zRWhsR3lYSm4r?=
 =?utf-8?B?Q3pwc2ErcDBIcTNsN09Ya2RPMXVLTzE1cWRRd2VLM216T1EwbklEajhkS3dB?=
 =?utf-8?B?b0hKY1dXZGxSK1EzZUU5UmFJRHlaa3lQQ09vaEd3U1Z0VU1KSVF2K1N0enRn?=
 =?utf-8?B?ZG5HMXZQbkFnZk9aM3lXZUQ1K3Z1VGE0dkxJcEdLUnQ2a05jLzRXeitHWm1R?=
 =?utf-8?B?RTBCaHpWbG9vSGNyZ2tob0taVnJHQVNrRk5OREdPN2w4bWxLellYMkVBMS9r?=
 =?utf-8?B?eVd5MkV6b2pKay8ybm5ra3g2SXQrKzlVZTNNWDB5NGdBTFpwVkMzRzNOVSta?=
 =?utf-8?B?RFY4SlFnVkNMb2toS2F2UzMxRGJjZXpkTU5pdmNsa054V3F5WFIxWEVhdjdL?=
 =?utf-8?B?MW9TdWJIdmFvOE5zMlgvSm5pcXhiSFpEQS96N1EzdlZPQThKTytOMlhuK056?=
 =?utf-8?B?dDNKd1k3NW04UzFpUU5oR3BQRlEwK25qeXkrb0twVDdxL09NVlhSY0RQc0tP?=
 =?utf-8?B?WGNra0ExWFpnZnI3emJDQUtXRFVmcXo2ay8vZFpmVDIwenJCWVowdXZRakFK?=
 =?utf-8?B?dFg0VlRoeTRqZk11VGEreGdMUGpsUzRpdU1QR0daRDR4c1BpZ0hpU1lnYUJJ?=
 =?utf-8?B?UGJBQlZsMVorSHFERTEyL0t2RDErTDJ3UmwzUjkrNWJIYXBBTkN2MXNWdENp?=
 =?utf-8?B?RlZkYnpFR1N0dHAyZEI3TTZvNlp1MmF1bGgzYlgxRlhHeDFxOFA2emlFUGwx?=
 =?utf-8?B?cW1leDdkWWlGZWZBRmlJZnp1VHg1WHMrSWRCMlJTNmEvV2ROUlFTeXgxWGVK?=
 =?utf-8?B?WEVXek1vUjk2Y2NIaEwyaGRrMjFMRXhscFppOElBZkVHOENONWRvd1ZmQ0hm?=
 =?utf-8?B?OW9HNjdzYS9vRXg1S3F0S05oYW9kNHB6UUpZK3M0MG5jN0JhUGZDU0NhdW1T?=
 =?utf-8?B?UzhkV2huT0ZoMHZPM3JGMnhFcGF1NExYbW9FRDRYbVVkM0dBVGlUTFZxKzh6?=
 =?utf-8?B?b2ZzbmpIQmJJZGc3RGhieWNsZ2ZPVEtHbVQySWNUSFhxd0w4T0hWdkNpd2px?=
 =?utf-8?B?NkRLK1RiWXQ5UzFKUFBFV29YYWFHSkxTL3VDbVVaNHI0SlMvVzN5VGVxOGxy?=
 =?utf-8?B?ekxXUjc4VUc4aGc4Y3VrbHg1ZUw2bThiVm54S0IxL2pmb1JLb1pLSXg0djFO?=
 =?utf-8?B?U21rOUtHOTYvcWxOUElxWW9xcjR0UU9XbjZoUVVUSG1vVis2YnNXN0xRblRQ?=
 =?utf-8?B?YUZoYmZtSHYvQ0hzSU52YkQyMmlDc0lNMElEZEZ3SGlrZ3o3bmlvR0hIUkU0?=
 =?utf-8?B?UTUrMExtWHdLRTFEbXVrVC9TSklnUjVVWUJqUGhXT2VudkZoQzBvSmdSUE9Q?=
 =?utf-8?B?ajg2OXhOcWhRWjRpMm1IVkRiVm1OWC90MldGTzdMaWYxM0JkT1dlUFNWQyt5?=
 =?utf-8?B?OElPY0VzWFlPRGNjMDlaWWZHd2FBNlk2NmJzUzlUUngvbzlOYk5kQm1jL2tS?=
 =?utf-8?B?QWVDbHRFUkI5ZjJ5UHVEZld5RTlHbW9lRzloQnQrTlA3RnpVMDNXRzZwYVVP?=
 =?utf-8?B?djFBZnlnU214VFlNcks3UGJyWFZBdXlNSW1Kc1E5NjFZUVhOeVBzV05Cci80?=
 =?utf-8?B?Y3VEcFlKMnZ4M2xzOTh5MUtuajZ3dTE2WlA1eEI1TUtHR2xhZDBXY0N0WVdN?=
 =?utf-8?B?RHVnVzhndXRSTXpXdW1qM3NJMXJqUWpUQVlDVmwwdDFYUjYyUVlEOVlkdDFu?=
 =?utf-8?B?Nkt6UWFhdXVuM0lISE5mb3IwQXd6cVhyZERGM2t0TWVDV3NFSEkyVHRsY1Fi?=
 =?utf-8?Q?JodWt3?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.44;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 09:49:00.0668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b158f3-c255-4256-87f0-08ddfb4f9675
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.44];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6605
X-Proofpoint-ORIG-GUID: ZU7e4ibTYjWKwHWdcpavX9iFqN9gF-g3
X-Authority-Analysis: v=2.4 cv=W+c4VQWk c=1 sm=1 tr=0 ts=68d3be8e cx=c_pps a=0jypAZrmxcbgW+ytPeIz4Q==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=E_cj8LcMwhkA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=1c5YuWx-dZ7yCilmOUgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZU7e4ibTYjWKwHWdcpavX9iFqN9gF-g3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDIyNiBTYWx0ZWRfX3HYXYcoy9ig/ bMu+C2MPdIrTAHqeuT34siGcdnXUZyquNBD4GvL1NqL3hMMDDRQQ0fI3I04YFeSX+ABfqG/7tIN YXcnXyjeb/N3zRUCBC01HrRZQEnUEgIHxbANx2nf+JqQmGDZfRCuHjqQqNX/SHzDeB/V1w8PDRS
 BEOSnySxZW+UsPhGfqywXwMj8BE140o9qoiJjb3h7okVUAIIEPtlZdhX47uyekblCJujcrnyGaa mJ/vHlpzKvFVV7ZEWxbsAmof4O4NuaB48d1G0wDesxBFe7aNVJ6Rw3AiiJGn53xN1G2xmDeHd7x qIoRj6wdTb+mQj/Zj6zJgOuB8hTHPesGC7TL5SkGk5Lzb7t/hKZQWnNE2FS31cz+Ijcg0R+6pQI P7dKH88k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 phishscore=0 clxscore=1015 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509190226

Hi Kuninori,

On 9/18/25 03:34, Kuninori Morimoto wrote:
> 
> Hi Olivier
> 
> Thank you for clarify the situation
> 
>> Looking at the traces (see below), initially, we had one call with the
>> 'in' direction (kernel clock frequency) and one call with the 'out'
>> direction.
> (snip)
>> Now, both calls have the 'out' direction when the property
>> 'system-clock-direction-out' is set. This seems more consistent with the
>> changes from commit 5725bce709db1.
> 
> Ah.. simple-card-utils calls snd_soc_dai_set_sysclk() from 3 functions
> 
> 	- simple_init_dai()
> 	- simple_util_hw_params()
> 	- simple_util_shutdown()
> 
> but its "direction" is...
> 
> Step0:
> 	Before
> 	a728f56094e7cf60a1dc0642fe86901d1a4dfb4e
> 	 ("ASoC: make clock direction configurable in asoc-simple")
> 
> 	- simple_init_dai()		fixed: 0
> 	- simple_util_hw_params()	fixed: SND_SOC_CLOCK_xx
> 	- simple_util_shutdown()	fixed: SND_SOC_CLOCK_xx
> 
> Step1:
> 	After
> 	a728f56094e7cf60a1dc0642fe86901d1a4dfb4e
> 	 ("ASoC: make clock direction configurable in asoc-simple")
> 
> 	and before
> 
> 	5725bce709db1c001140d79398581e067e28c031
> 	("ASoC: simple-card-utils: Unify clock direction by clk_direction")
> 
> 
> 	- simple_init_dai()		dai->clk_direction
> 	- simple_util_hw_params()	fixed: SND_SOC_CLOCK_xx
> 	- simple_util_shutdown()	fixed: SND_SOC_CLOCK_xx
> 
> Step2:
> 	After
> 	5725bce709db1c001140d79398581e067e28c031
> 	("ASoC: simple-card-utils: Unify clock direction by clk_direction")
> 
> 	- simple_init_dai()		dai->clk_direction
> 	- simple_util_hw_params()	dai->clk_direction
> 	- simple_util_shutdown()	dai->clk_direction
> 
> In Step0 and Step1, your dirver is called with both dir IN/OUT ?
> 

Yes, based on the trace, this appears to be the case.

>> In my setup, the kernel clock is an input clock. Maybe it should be
>> tagged as an input clock. However, we have no
>> 'system-clock-direction-in' property yet.
>> Anyway, the patch in the STM32 SAI driver is still valid.
> 
> OK
> 
> Or maybe reset simple_dai->sysclk somehow (not sure...) ?
> (simple_init_dai() will call snd_soc_dai_set_sysclk() if it has
> simple_dai->sysclk)
> 

Yes, resetting simple_dai->sysclk may also be an option, but I could not 
find a way to do it in practice. Requesting a reset of 
simple_dai->sysclk from the CPU DAI .probe callback might be the right 
time I think, but there is no service that allows this.
Another way would be to set "system-clock-frequency = <0>" in the CPU DT 
node. However, this is not possible, as it conflicts with the following 
check in the simple_set_clk_rate() function:
if (simple_dai->clk_fixed && rate != simple_dai->sysclk) {
    dev_err(...)
}

So, the current patch still seems like the better option to me.

Best regards
Olivier

> Thank you for your help !!
> 
> Best regards
> ---
> Kuninori Morimoto

