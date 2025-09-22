Return-Path: <linux-kernel+bounces-826787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B62B8F57D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B44417C9BE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430F22F7ABE;
	Mon, 22 Sep 2025 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="efztnReB"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED342749CF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758527565; cv=fail; b=AYyl0EMSTrNeJnCA5mNE08x4MC8QA4Rgrgjwz04JMuzTRVaeRFFtI9ZgXMFEmt3hCj+S4ca49amPSiCUZFXN/fjO7XDe6h72f7SVhe5jSxGInaytRLnp738g92DJ5fNMBiTC3ctnyhbteATXyX7DZDj/FERh0YxjO3wucMp8oJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758527565; c=relaxed/simple;
	bh=baKna0PviWYaW6G1hBv2tSTCaNm0vYvxa8wrfawNBqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mQss4NjK0r6oF2kU+EEHohbM1f4hEvWmvDFz7wcqdPVsaKfyyeyrZt7s8RMJVykxDVM2rZ0oHvINuiI2Ams+xvB6toGALB8jkMKKvKLj1ysYGGTN9GcDOPbyJKrzCv1TiN1SWbJH4x0DQqYU0WVi/wKJAkz/nMWSJOCE7uILY1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=efztnReB; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7Kphd010884;
	Mon, 22 Sep 2025 09:52:28 +0200
Received: from du2pr03cu002.outbound.protection.outlook.com (mail-northeuropeazon11011022.outbound.protection.outlook.com [52.101.65.22])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 499kkxxtv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 09:52:27 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rseilybiWFadiXLE3v+RpApIjaPeYH/AWwpbWoRYh0noWHv/9cIbdrnny2eO2YhJ2mC/fyO02is93Aepwnq/SvTjxnhxZZyDz9dazmrhYhYdw8w3CYySee+mnbZJPAiRF624c/NdmO4HeRtWo0XyyQVPRe+cOasrpFasJN6pBS4tCg2HP5IG+LmbMYPkWnXSVUPvDDjIddqICmBCyzrUZljEpMt2UT2CC4vCWqFT4jwDQs6Hqyiq9ZIskhjgpw8dy+F6kSpU0ChVSz3rvZfSpVUMbuNpkPJsrqerV0k4i2j1hDQnJ3O9/T3r+/edzxyLcHzdHUvNfk4ObyPgFxesvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Bf1iIBem3e4e8UNQB1BD3tDJECURo3kZ9TpjFAMz84=;
 b=ScjCruRFxOoAq3vjCXfDzya6/pDHUbQEBPbPkpX5FKwbi5Ti+L19otVf06B6qqEKPFlfWLwaz5+JwubVa8TjvOGZCwGBVm9EUhQl/y9JpAjKD05bhSfi2dTjyjquT8gHjijHTlE8nekCF/uVrdAu6E5JhWwMve13Qd+LwIzTr+tF3ZK1+QRYCFvZaVw299edpDhqbTkn3CKXyRybth51E5yBZWOfJixX6fqjdd1fcun0CZRJ/o6V8QGkJoSahvhkCtg9+Nd9Y6lDO5gofOmvPheg+1KcwnwBLWoVokP+BOO90yILDeRq0e68rGy4ToeW1Q9V/awbsv4Hyc/5ZV7AbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Bf1iIBem3e4e8UNQB1BD3tDJECURo3kZ9TpjFAMz84=;
 b=efztnReBPH+IuL0xBVdKgfCF9d4sB4nNgBhhBKoR2aYRRJ5AMHrMTzi7f1DGFLbMKmYNnUDqlFySYJ2zUtahMuYw5mGqOXf5C4Ll224oV2qSBYooJTlSPYRe1eU1s6XPEuJrb+IF/AED354H3z8H+KQbDxrtrLWIGiaGlr8WUqAm5bT2/i4QCMOGW5xELm5kgz9kYyhsvTPHuntso5sDaA6AQKKOCb+/dkedA5c/u0GPHXnK4r9QegTNsts/jVVDe6BRDq48Ta13U2xeoe/T11LYGvcfJjUsze/7IYKFrfOl5k1RXXd0cP87GQ1VCXq5KSzmHawISRUgDzPYG1J45A==
Received: from DU2PR04CA0025.eurprd04.prod.outlook.com (2603:10a6:10:3b::30)
 by PAVPR10MB6985.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:306::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 07:52:22 +0000
Received: from DB1PEPF00039234.eurprd03.prod.outlook.com
 (2603:10a6:10:3b:cafe::a3) by DU2PR04CA0025.outlook.office365.com
 (2603:10a6:10:3b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 07:52:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 DB1PEPF00039234.mail.protection.outlook.com (10.167.8.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 07:52:21 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 22 Sep
 2025 09:45:00 +0200
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 22 Sep
 2025 09:52:20 +0200
Message-ID: <d7a4e6c6-6670-41e3-9537-4be705ca3805@foss.st.com>
Date: Mon, 22 Sep 2025 09:52:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] bus: firewall: move stm32_firewall header file in
 include folder
To: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>,
        "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
References: <20250916-b4-firewall-upstream-v7-1-6038cf1e61d8@gmail.com>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <20250916-b4-firewall-upstream-v7-1-6038cf1e61d8@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00039234:EE_|PAVPR10MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: 54189be8-daa1-44e3-8e57-08ddf9acf5f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUc5NHhoclNrMnA5OTBuUFVHNWoramdSblpjaHozN2J0NS85cUlMS2kza1c5?=
 =?utf-8?B?NXRyelB0TkozYXJDMExqRTZvZDlyTUlqSk9qUWJqRFk3MDFqL0dBSTlGNmtk?=
 =?utf-8?B?U21OWG0yUE9vTjhXRWMyclpuS1Y4c3ZNUDhuemdZMTJzNnF5eU0vMWZhQmc1?=
 =?utf-8?B?T2JISWRoUENoQ2UxU3d5aXg4NURlOW0xRW5SWjZaWW5SQmRkaDQwVXgyWitt?=
 =?utf-8?B?ZmZUbzNUd3FTZnIwYkFrN3c3bnYrZmVUeTdNWjQ3ZmgydVUzUE1nVmd1d1My?=
 =?utf-8?B?MlhGRjBCSm95SWNWMDlxS1MrbVFzbnZ6MGVKNFVleWNlNjRSaTRYT0ZvM0pu?=
 =?utf-8?B?dFIxRFcvOFBWOW9IUVlVeE8yclAyYTRrVVI1azlCaG1wNnQzK0ZwUFNVSFgw?=
 =?utf-8?B?V01NREQ0dC9EcHIvZmM1SFhvSk83d3Z2TEsyS2p3SHREeDlNZ3JNUzlEOTMy?=
 =?utf-8?B?cUp3UDNDbCtZNXRKWEN6VHlyQ2NlaFJqZFNDYVlYZGE4bUx0bXAwYTdhU1BH?=
 =?utf-8?B?VnY5clFManh4TXpTUE04ejVreFVkRk9WZkEyYS9iT1BmdW5aRTJ0SmhaWTFS?=
 =?utf-8?B?dTdoV0tMcGgvd3orUVM2OERxaE5OUVdrc1VLRGJ3QUxzNHIxcjVVOTBPVG1Y?=
 =?utf-8?B?VDdyWFF2bUpQeHBpT1VqaEVvc1NwVDhkL2xFREYyT3NSUElkbGFtK1F3OS8z?=
 =?utf-8?B?RUk2Z0VObldINkh3RmV5R0pOb1FzSmxNMVlGTXR4WjNtR0lVSy9JTnl1WlNi?=
 =?utf-8?B?R1VnUXJaNEZKQ3ltSktNME9mQ1BVMWs5UWJhZ0FYRzl1alNhRm90aWpLMHB0?=
 =?utf-8?B?cU43RmpxQ1JYOFdmRlgrSUt6L016UkU0dVMvcVVNNGtFS0dCVzBYNjB4TSs3?=
 =?utf-8?B?ekZGUExOMlFBMGd0NGhxc3pwRnZaa243YStPMzFpS04rdDdwTys0SVFpV2d4?=
 =?utf-8?B?V2Nra1JNUWFmb3pDWXFmZ2lHREZvTWQ5OFBQYWoyZXh0Z1p4MVNXeWk0c3lp?=
 =?utf-8?B?U0VXSGlYOUtSKzBCbFdDd1BqUFU1MGJGckJkNnFZNW1qV1RhM0hMT3FSNmdW?=
 =?utf-8?B?Y0c3ZGJQcmlYQSs0QmhOT2pUeUo0MnFkSzRmYm9LZ2Rnd2hTeUFKaEtQOFZF?=
 =?utf-8?B?WDFlVFMwQW9OQXljRTI1QmZGWW5WakdCL3FxYVlCV0FnYnF6a1l1WXFRaGRN?=
 =?utf-8?B?akhFNmJVVjUvek5LdzJvTGtBNDMxZUxNUEw0MFM5eUpXWnNBbUZVNG8wb2JK?=
 =?utf-8?B?TXBPeFJjMVJ6K3lQdmVsY1lwcnZoOEdpRVFOak1BSXBmTmxzUkxHcG53blRl?=
 =?utf-8?B?dXlxazdYaTlTNXA2d3FjaStJanBVWG9PMlpla0YyVmtuVU1qanRlU2syKy9Q?=
 =?utf-8?B?VmxDNWRjbytMcjRmbnJuUjNVU2NQVVhNTU5FZlhyaU9hVm1RUkNya2hYM3F6?=
 =?utf-8?B?SGdHdUM1M0JJS054OVp1cWdwV0EwOU85cW5RMy8xbXB6QWhBeHB4Ni93Y1Zo?=
 =?utf-8?B?NFZJcGJiZFlXUW9NUDdzZ1gyaXJQQTZ4YVVSdjFSNlRwVFFwbnNHR3lOZmtT?=
 =?utf-8?B?ZjRHcGVrbTdOa0tKaXJOOWRXOG5nWFJISWpHV2tXNDRCYzhHLzhNWWMxUkNn?=
 =?utf-8?B?SjcvdU1UbE9HL3lnSHZNLzRWVTVqRGhHM093bkJ3QW1aWjlpTFVrajFsWW9s?=
 =?utf-8?B?V3hMUFZWR1JmYVg5TUprbkQvckx1OStqc01odlFIcldrRXN2RVY2QmQwRHVZ?=
 =?utf-8?B?VENMZmF0OVMwY3ZpaDZCUUJ4eWIrWGZiWDIvdmRYODRYMUdseGRMTVhlcjFN?=
 =?utf-8?B?TFZ1OThCbk85aXZhRmw5N0FPZzRIdkEvdU1HQmdzR2Jxb2JCQXJGTUFNVlhx?=
 =?utf-8?B?M0VBd0l0WC9WQ2FaQkZsSGh6OUdWY0l0UmF3TktiaDZUR0laWlUwaXZmUVIz?=
 =?utf-8?B?ZFpDcEczRk5IaVNLVlNJVElkR2ZHdnJmcXcxdFp0TjdVWGJSemFRVUFvc0dm?=
 =?utf-8?B?cGlHVWN4UFovaC83VlBGTlA3Yjg4R2tTTVpHSU8rTnZzWjhxbnMwNlpYRU5y?=
 =?utf-8?B?cE1QVWJzSndQRlFobXN1RlduejhSMlNRNWdsdz09?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.44;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 07:52:21.1621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54189be8-daa1-44e3-8e57-08ddf9acf5f6
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.44];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039234.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6985
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMiBTYWx0ZWRfX4HdaDKrFGV9C RgteYSCRsNnQg+bCApV55FXnWA34AlyTTPuuwFnCavCVCv976KjCIRDe8jONGh7o9moVF3IB/qP AE7bRbrvbB8g4ex3XrwS1PfI7IBB6onwiZUbVxddMkVadpXiAAsQB3+ez7zMoA9XxLmD+XRUa5M
 U6EV3EQaaMDIbVgfRTKHXHoJBS960rfxE5qM2ihfx+gouAmQyEJqxdNDKw1+0q1McbM7Tp1NiT/ WyGT3RJHmVv1y1ZZhCgE0d+Z/8NAwusNJjOfA0uZ38HjsB8mFcBIlYOMXEwTQMO3U5l+P1bGoFs EtftsDJy/mcVW+681q0k9WmjvsJ/ZBWhbk8ZDHNFMtLSpArHZw9BapdFHNCAMmuG9hetcvZvZ1+ wHhapsb5
X-Proofpoint-GUID: kEVihndhSV5h7Cum9OHKnr7ztqxLcT3M
X-Proofpoint-ORIG-GUID: kEVihndhSV5h7Cum9OHKnr7ztqxLcT3M
X-Authority-Analysis: v=2.4 cv=dY2A3WXe c=1 sm=1 tr=0 ts=68d1003c cx=c_pps a=qDHLbbvJlrr8V5LZr46qng==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ei1tl_lDKmQA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=8b9GpE9nAAAA:8 a=YYNlyAMbr1-TTnqoXNcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200022



On 9/16/25 11:07, Clément Le Goffic wrote:
> From: Clément Le Goffic <clement.legoffic@foss.st.com>
> 
> Other driver than rifsc and etzpc can implement firewall ops, such as
> rcc.
> In order for them to have access to the ops and type of this framework,
> we need to get the `stm32_firewall.h` file in the include/ folder.
> 
> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
> Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
> ---
> This v7 is a subset of the v6 and other prior versions, splited to simplify
> the review and merging process.
> 
> Changes in v7:
> - None
> - Link to v6: https://lore.kernel.org/all/20250909-b4-ddrperfm-upstream-v6-1-ce082cc801b5@gmail.com/
> ---
>   drivers/bus/stm32_etzpc.c                       | 3 +--
>   drivers/bus/stm32_firewall.c                    | 3 +--
>   drivers/bus/stm32_rifsc.c                       | 3 +--
>   {drivers => include/linux}/bus/stm32_firewall.h | 0
>   4 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bus/stm32_etzpc.c b/drivers/bus/stm32_etzpc.c
> index 7fc0f16960be..4918a14e507e 100644
> --- a/drivers/bus/stm32_etzpc.c
> +++ b/drivers/bus/stm32_etzpc.c
> @@ -5,6 +5,7 @@
>   
>   #include <linux/bitfield.h>
>   #include <linux/bits.h>
> +#include <linux/bus/stm32_firewall.h>
>   #include <linux/device.h>
>   #include <linux/err.h>
>   #include <linux/init.h>
> @@ -16,8 +17,6 @@
>   #include <linux/platform_device.h>
>   #include <linux/types.h>
>   
> -#include "stm32_firewall.h"
> -
>   /*
>    * ETZPC registers
>    */
> diff --git a/drivers/bus/stm32_firewall.c b/drivers/bus/stm32_firewall.c
> index 2fc9761dadec..ef4988054b44 100644
> --- a/drivers/bus/stm32_firewall.c
> +++ b/drivers/bus/stm32_firewall.c
> @@ -5,6 +5,7 @@
>   
>   #include <linux/bitfield.h>
>   #include <linux/bits.h>
> +#include <linux/bus/stm32_firewall.h>
>   #include <linux/bus/stm32_firewall_device.h>
>   #include <linux/device.h>
>   #include <linux/err.h>
> @@ -18,8 +19,6 @@
>   #include <linux/types.h>
>   #include <linux/slab.h>
>   
> -#include "stm32_firewall.h"
> -
>   /* Corresponds to STM32_FIREWALL_MAX_EXTRA_ARGS + firewall ID */
>   #define STM32_FIREWALL_MAX_ARGS		(STM32_FIREWALL_MAX_EXTRA_ARGS + 1)
>   
> diff --git a/drivers/bus/stm32_rifsc.c b/drivers/bus/stm32_rifsc.c
> index 4cf1b60014b7..643ddd0a5f54 100644
> --- a/drivers/bus/stm32_rifsc.c
> +++ b/drivers/bus/stm32_rifsc.c
> @@ -5,6 +5,7 @@
>   
>   #include <linux/bitfield.h>
>   #include <linux/bits.h>
> +#include <linux/bus/stm32_firewall.h>
>   #include <linux/device.h>
>   #include <linux/err.h>
>   #include <linux/init.h>
> @@ -16,8 +17,6 @@
>   #include <linux/platform_device.h>
>   #include <linux/types.h>
>   
> -#include "stm32_firewall.h"
> -
>   /*
>    * RIFSC offset register
>    */
> diff --git a/drivers/bus/stm32_firewall.h b/include/linux/bus/stm32_firewall.h
> similarity index 100%
> rename from drivers/bus/stm32_firewall.h
> rename to include/linux/bus/stm32_firewall.h
> 
> ---
> base-commit: 46a51f4f5edade43ba66b3c151f0e25ec8b69cb6
> change-id: 20250916-b4-firewall-upstream-dfe8588a21f8
> 
> Best regards,
> --
> Clément Le Goffic <legoffic.clement@gmail.com>
> 

Hi Clément,

Acked-by: Gatien Chevallier <gatien.chevallier@foss.st.com>

Nit: peripheral names should be uppercase in the commit message.

Thanks,
Gatien

