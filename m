Return-Path: <linux-kernel+bounces-856139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97788BE334D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2FB3E8150
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A59531D732;
	Thu, 16 Oct 2025 11:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="AEZXKxUm";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Yqw6Fhuu"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E20831BCAE;
	Thu, 16 Oct 2025 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615912; cv=fail; b=KHLXxsZH6m75y/O/nsWtPCw9/s1l+EuqbFPdqBXiELcDdalX9gkzYQt0cWSnJq6l44I/wxv5yr4CjlJnLKI0NKuf0hD+aRo+95TEBBYu9zJ88k9WDStqusSqZ/en6Is3TycSG+R1ljMBL6+7zF1iwW/EO6S/Fx2p25sNcNTRQ0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615912; c=relaxed/simple;
	bh=ZGeeJrIqZszCxSMYpwlISmys/UMiBnP2v3Cr8EFRZK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYeezsEOtYOfdCoip+5rDUMB1brnsk2ujMnjtiM+KssRC72gC6gLYmugMBxtcpNP0VGPPzQmPdQBz1Q4eWtYLjxxxB4T5kd/ghLQa5pS2smiHeTinoZKWhQWx2fPjubtvfYbZC+KRempAXvnvGDchXlanEz5El9L1tNxgVzQ+fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=AEZXKxUm; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Yqw6Fhuu; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59FN6m8i298627;
	Thu, 16 Oct 2025 06:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=0gUjlaAL1BGMjPuEg3sf1VDvAw6dmb4iUJV7xNizmbk=; b=
	AEZXKxUmWpJgLNLElOtG7C4maFqdG1aQV1f1aoR6AmMtYWpW01R9Xq7oDjRMhZiX
	FdZkUY4UrJr3xBRKcjym0qU7LCm+s+AlmhEfSPrzyuWMhbGOh0HlgsqbPctnAnrO
	TET8EOI25fmEx1dxeNXy10GezPCn2NNPlobAXFd1xLLYTcZZJOUpizyvFsEqijaR
	2EdWhOWs1s3gb1TVreCRJMNnahyEfPrFy3RKxIzERkOgIZwqGSXmQ9IY35jzTkPK
	BXHWJsWoP15VbfLhHBjBQFcuU+tHH9QGSZwn3Bt4rIDGbmFROFY5kYAJulg4nEPA
	RhuXCOguw/4KlcMI4dxujA==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020099.outbound.protection.outlook.com [52.101.193.99])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49t9mhhryf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 06:58:24 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlADihVi/38TqmGuNafmOiqsS4pbgmc1RxA+3dWbxWdRVKCuy/h2203WMQKMrCRxRkqB1q5Ck1i6C/0Foga7MxSkLioo9izSG0zlaBcfNLQmUTxCcmtuG/WBUqw5LT1eA+yY1J3Vg8N+OWpJH/xTSbeRDA0DXyN/9YppBGk3QNDR8dWK97oaMeIgmLKsz2l310jHqiX/l6mC2zvT0ztHYtgQqVPqdbUtVg6BQSFKvBm3P/H2ZnsT358+jEPZzem3DiaU+Oizm5p3TAL9j34Y2cnqdNjRA/pLaTyyap99cWCJOB8Vm8OJymufepQRS5zdzZbpHnifbfdf5Et9QvriiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gUjlaAL1BGMjPuEg3sf1VDvAw6dmb4iUJV7xNizmbk=;
 b=ZnO13JbgdfIhj1YsWOvuMepS9aclnooopVb7QBts2vfzzgeCZSSlBTrZMgHlyioLXcfN0K3OBnqrFq/ph2v6XaCWLgorm9MRdWB+HqmN3j/5xnLFSuKS1N7zwirJzSXBo6PH4eAOs1Uu7wCuiXeNy5nIVvgwqDl0GQkwhUv2BWuLoRXG/Mmqx964Llm9W43uhGmeU83r9Oy9SmD/qqHYh/F5dfMHzwHAoaWcyyfmJbEZyS/t7IihgwDIJdslyTsFD1FsWDsss/Zi7Zomr931B7VNgXrcgOZ6pcGDc51aHajPhpWXlJ52KffnYoV+jygGkdjhNZCmLvIpD0E2YaPrdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gUjlaAL1BGMjPuEg3sf1VDvAw6dmb4iUJV7xNizmbk=;
 b=Yqw6FhuuK/dhVAYPgIao7v0E1molGRsibNaLCd0vDgOZRGTwRluSEaV+oKOWZUWH6exroHnKtgMypfjaR10ybwzhiIEHEVkTSNo/1pdHP5N0xeyjZ10SLt/laamiSpxXkpjrX21ZpEJZiEe9Upc0Z8f7OB6EDFCl2sYVQ+HOd6M=
Received: from PH8PR22CA0019.namprd22.prod.outlook.com (2603:10b6:510:2d1::28)
 by BY5PR19MB3794.namprd19.prod.outlook.com (2603:10b6:a03:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 11:58:20 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:510:2d1:cafe::ff) by PH8PR22CA0019.outlook.office365.com
 (2603:10b6:510:2d1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 11:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.0
 via Frontend Transport; Thu, 16 Oct 2025 11:58:18 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 3D25D406547;
	Thu, 16 Oct 2025 11:58:16 +0000 (UTC)
Received: from [198.90.208.24] (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 2D738820249;
	Thu, 16 Oct 2025 11:58:16 +0000 (UTC)
Message-ID: <14617d69-7312-418f-abd9-3c65a84f8421@opensource.cirrus.com>
Date: Thu, 16 Oct 2025 12:58:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] ALSA: hda/cs35l56: Create sysfs files for factory
 calibration
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: tiwai@suse.com, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20251016104242.157325-1-rf@opensource.cirrus.com>
 <20251016104242.157325-6-rf@opensource.cirrus.com>
 <871pn3860a.wl-tiwai@suse.de>
 <37e0f08b-ce35-450b-9abf-d3be09d2863f@sirena.org.uk>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <37e0f08b-ce35-450b-9abf-d3be09d2863f@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|BY5PR19MB3794:EE_
X-MS-Office365-Filtering-Correlation-Id: b09493d4-78f2-4ec9-daee-08de0cab4bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TThCZXlsNnJnOEhHNlMvZ3pzbGg0aFBJR2lrQWtYeXlCcUFFVkZob0Q5LzBx?=
 =?utf-8?B?THM1WDFMT2V2WENCbUREdUEzU2daY3BXeEJEaWo2Wk1Cbmdxcmk2UTJjM0JB?=
 =?utf-8?B?cnNxQUFEb3JtU003em1iU2dINFdQL3dtZllmeHJFVnNja0gxK01Ma1U5Zld6?=
 =?utf-8?B?aWM4R3NVTzVqcER5TytvTlY2M2NaYUpTb0hPbHpWd2V3ajZZejljVERQZzE3?=
 =?utf-8?B?U2NuYjBzRDJZalRFd0ZRZzVvMUFwVjVQNGJGVFpsMExtY2Z3NlFzb1QybjFC?=
 =?utf-8?B?YmZ3REo1blBHZUtJMUh6UWx3bDlvNFNnb3NRRE11T2FLWDMxd3dIY1ZjNWtQ?=
 =?utf-8?B?VjNScCtjbmQ0RlRRSWh3NlgxNkFKYWEzUXZlUC8vZm8wWE40NnNIbTNWcGty?=
 =?utf-8?B?Q1hxOWRwK25nOGo5V2lYY2c2cVJCRmVuaDFBRlZ2OVVNWTFqb3ZRaEw1cTNL?=
 =?utf-8?B?aGJhdVozbUVqS3ZRa0FEd3pRVUF2MWtuSzYvcWFvL0lyeTJROG1LSmM3V0t1?=
 =?utf-8?B?aUlISTMvZXFtL0d5M0dsdWlacEsyeDdsTzJ3akhhc3ppb3UvdmZXM1gvbWdu?=
 =?utf-8?B?NU5DTmZKUkhZM2Z0U2ljSURRY1pJY0hoTExsZDNzNXh6aWlVSEp1MmZwRDhw?=
 =?utf-8?B?V3ptR3Z0SEVIVG55emNidUN4N3YyQ252TGpROWVlSWN2TTNNdjJ6dkhQV08v?=
 =?utf-8?B?bERjRHJLRWZFMERTVzFPSjdUU3VveExmc1RpdUlxaDFNVEZIYUxaaC82MVhL?=
 =?utf-8?B?eXdWODJndUpPUUFNbXBXY2liUVBFUFM3TTlKNXdpVmdVL1Y5emtRK2ZFMVlN?=
 =?utf-8?B?aW9obHJGbS9zNFNlQldZdnl5Syt5clZlUk1QSUpSS1BPSk1YWU5IdVZpbUlj?=
 =?utf-8?B?MXVVbjk1cDR2R0dTamtOR3pDWnNOQ0JCZ1N3T3M1UmRsOGtxT05McHI0cWVZ?=
 =?utf-8?B?T01ZMkxDYktmVlRHcCsyRmdaVUVLenZNUEV5MDJ4YU1tS21iSlNUajZzVHdl?=
 =?utf-8?B?VjR6VGdWS2JiZWc3K2RSK2R0VG9jcisyMHg4MjJ4RDFoMUZNNVdtSEZpcnVj?=
 =?utf-8?B?Zm94RmdQWnJvLyswVVVqR20yc3JLVWxlYTNuZ3Q0Q3lEUmREenMyc0p6c3pv?=
 =?utf-8?B?QWNSYjZoWWRZZ2RzaEYrRGpRRVNWY01udlNKdVBNQ0p2TmE5UG9rcVI1N3Fx?=
 =?utf-8?B?OHJZUFd3Wm9OTjdzd3RiYjE1QXQxeEpMdlZNSndmK1UzVFB2UkR0djJxNmlO?=
 =?utf-8?B?cmY2NjBzQThjeGMraGVmNEp2QlY2K2F6YWRvRTIvdDZySnAzYWpDdUtnOGV2?=
 =?utf-8?B?aWFYOUYzTUVBUll2OTRRR3ErUys0Q2pOVkxPQXo1R2taek55azFFL0VZeko2?=
 =?utf-8?B?QTJYYVJDdFVIUGhSVGJQYlRKUHAzOEo3Q0VjbEEwMWtsNVhtcFNsVGpRMTVr?=
 =?utf-8?B?RUU0d0JEbHpFS3VwV0FjOTQ1OUs3dlZYSml1SkkwZEFvVGpMN2ZvNURyVG1V?=
 =?utf-8?B?R1RhYUx2NnhoeXVoZTlhbmt1ZStoNTM2elhrbm40dnQ4M3U2K0xPcjNycXo1?=
 =?utf-8?B?bG1qNnFGazV5aWtUYW1JV09uZ1VCU1lYVlNmNFNCYm15MDdYLzhwdXkzTkQx?=
 =?utf-8?B?ZHRCL2g4OXRad0M5R2d1ZDlhcW5SMGZmTVlRNEFyVk15M3dtSU0zbjJzNHZj?=
 =?utf-8?B?Q0t3Z2ZnZm01T0RhNWpiblRsVUwvR211NFM3Vng4SW5ldmlTd2d3a05vVkx5?=
 =?utf-8?B?bkZicEFFZkZYWlRaK2VyYnJNcVhyUCt2QmJQUlE0cThRREJTdkYzRkt4Y1h6?=
 =?utf-8?B?cTRTVzRnZmo0NjJtNUY4R1BFc0kwd05xQXJ2SGRhaUpkdlA4K0Z1bmFiZjhN?=
 =?utf-8?B?RzkrNnAvOWVFOE5Kd0hjQ0cvT2RqK1dEdkxrelBaTzMyd2JGUHJBaUQ2eHlo?=
 =?utf-8?B?aEtLTVdxWG5aNDdCQkw5ZmNIV014dFA5VVJ4ZHhaKzZZZkcvMGY4bEN5Y2Vh?=
 =?utf-8?B?U1BRaS9scUt1NlNBMHk5U0RPaFNkMHZKeThEamlsVlRTdWlpUnRNRndrVnpS?=
 =?utf-8?B?MHJUeWVjQUcxTHQ2MXpBeXIwa0d2WDkybjZDWGh0VUJaS3dQeHI2UGRlelJG?=
 =?utf-8?Q?jC0c=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 11:58:18.0529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b09493d4-78f2-4ec9-daee-08de0cab4bcb
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3794
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA5MCBTYWx0ZWRfXw4xfj0SncXqc
 qlfPomUqNBZNz+sOhAt+b+CHM6mgmGWJILapjtX+Q77tDsYzo0/jljzRwHnsmyhKr/x5k31MPaZ
 bJyR1q/KkEnvoMbmm+3wLSgF2T1XppiWjKlMK2Sf94j1kQ6yYHQewUHGJWLUC16y8priRs5EJKH
 2nCksqO3j922yL3fbC6wFexbSSng5xvxJFfrC0mDdDz2Z3dBxc8K59tkgFKpPMS5u3OVVeoMAkd
 cHVjGSrAlWgEdY6FZFtWYJGECZWg6O5xQcYAFrSsh701glgVP4ebU0h+leNddOjf9G+AoNwqUlP
 Joao7VYvDxtZNi+rMj660Q/+QErO31Oz35v1jH5Xuh7TAjbzVQUOyDkHhu6yaAMJes9gYXBvROF
 vSIj8YBsYU9kj6I6FNI68AVrbZ9ahw==
X-Proofpoint-ORIG-GUID: wDT8LHaytP4xX58-s69tOLEESZiQge8-
X-Authority-Analysis: v=2.4 cv=OJIqHCaB c=1 sm=1 tr=0 ts=68f0dde0 cx=c_pps
 a=Yoik/vw0OvDn0K+F3zf8Kg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=ZXba000GT0ZMcytDERwA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: wDT8LHaytP4xX58-s69tOLEESZiQge8-
X-Proofpoint-Spam-Reason: safe

On 16/10/2025 12:27 pm, Mark Brown wrote:
> On Thu, Oct 16, 2025 at 01:01:41PM +0200, Takashi Iwai wrote:
>> Richard Fitzgerald wrote:
> 
>>> Create sysfs files that can be used to perform factory calibration.
> 
>> What kind of data format should be written to calibrate sysfs entry?
>> Since those are no trivial files, we may need to document the
>> formats.
> 
> This feels like it might be a better fit for debugfs or possibly
> configfs?  It's not really within the sysfs rules, and especially
> debugfs is a lot more relaxed about everything.
> 

debugfs is an easy change in the driver but more complex for the
tooling. Unlike sysfs there's no standard layout or naming convention
for the ASoC debugfs tree, so it's more troublesome to locate the amp
entries.

ASoC creates a debugfs root by default if DEBUGFS is enabled. But HDA
doesn't have its own debugfs. There is an ALSA debugfs enabled by
CONFIG_SND_DEBUG, which is normally disabled. But enabling
CONFIG_SND_DEBUG has other side-effects, it enables more than debugfs.

Or we could create a new debugfs node specifically for Cirrus Logic
directly in /sys/kernel/debug.

I'll have a look at configfs. Although it works backwards (userside
must create the directory in which attributes will appear) it might
have some benefits.

