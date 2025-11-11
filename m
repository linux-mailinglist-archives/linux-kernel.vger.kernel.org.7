Return-Path: <linux-kernel+bounces-895557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CE8C4E472
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208C63AFA3C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C243596E8;
	Tue, 11 Nov 2025 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Tyi1JMcM";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="pMYQDzYT"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1DE329E6F;
	Tue, 11 Nov 2025 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869591; cv=fail; b=JaSmzq3tPOYoYnPuaZGvWalkLf0vrsy2BuDxif+24cuiqTDD0KCKfKUEnr3AfPrSUgFrCJQ+2pf1Ophs4LXbBw1wGPwMpUsjUx7J6evvXG+YTuhcardBZNRYna58TwQntwnbGIsbTwvxCWVEEzkUw06hVs9NzymA+GB5G7842xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869591; c=relaxed/simple;
	bh=htNjjihoc1hbBUp9OTwiR0Yvuqc836bgBnx0e9NpFrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0zE8J4udHoPTj1nulbb6VLv8oFkUpIT1CCYY1Z5Owg/27rr37zfok87cbD24ehsAng1uzxjprsH5h/TFZVzMn6wyF+tGci09/KRefJu8/y21sjJjRK1NC6MU2gQyS9b17aOXH5I5Q3IJFVcHtJqS5A0kBK+faPQg6X9+D98XVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Tyi1JMcM; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=pMYQDzYT; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABDdgPi213778;
	Tue, 11 Nov 2025 07:59:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=rCX3dVOVDfygrsYzWS97LopcIVpUkabUqLC/mI13+rU=; b=
	Tyi1JMcMYMAfEyL8DmUJp5JOLyZct7P0Y7EZG3cr+go6vnVSn6jAjXEfxcdUboHZ
	FSavORCeteb4xjY6V/+3Txw9wWx7JK7q+r4ni6n74h2QQgdwUt2772fgm9M/1L7G
	1EkYwre8766D6NGUVhgDaBU1I0N42qiurS9jsNiUuFuSOoo5jkCRVZbLUglT9gpU
	kdUVo/w92jeMvMHLPHGGcbUjDsX8zYz6lImJJgUNU1IR7xzdRmCYMRWYzS5Y+LDa
	JqJrovDddh1O1ZZC90xllDbKrNBk1biO6WhI3JjS+IVnMv1Ciq+Iy9gMXDCWDLcN
	nSqDrvwVy7qm7mTg9SIqEQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021105.outbound.protection.outlook.com [40.93.194.105])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4ac67m0165-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 07:59:34 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlsgP0D49BNm4jz5yLKfLEwE+65Ou/8ySxTH20YdgYEO95vdVBhJ+BnuNhr8wq2V6085kdbZUjV5CCH/7pxQyLhni5pqNlSu0anTfS0SC6ZForTOafP6lrXg/r/CIBWG61++crUVoV+7giYdqF4eF6r7a4/b/4/pf1oTRc3E2tjyG18tm/qyxcr9rtu7Y8//3NPgTa37OsL0EQXpun9N9KvbwK2uJaBLDQhKwoTU1r8qUBSoJjyaAolAN2JGWOjTu3iSNW3Y9v03BoLZ0QsovnHAIo8FA2RLo8mnLMTcKgLplwP3V1N+4owfT9ICRuygRi3LIRlAdAz/vv0Xn2c82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCX3dVOVDfygrsYzWS97LopcIVpUkabUqLC/mI13+rU=;
 b=WqPHgEjgt+9+w1UFpYEDSQYDWrANkzG5cw+sY3n2nPGLSVrfOnFQkrBXnZK+g4wpLny0qoID0mRMEJjiVXsHTZFY8t6CsTq8zNPTZ2ffPp7CXgClazMGLhaMiLcshwCckyS8IRzxQcxsXd9CpydNorc1YKmOKvfCAQAiFCAXqXbtVkH7tJyJ5/ekPMVZNxWwd6iYyi28UUzcIBsqsepCO97/UkZIeqPyzVIzankfx6tt1ssuFowArR96ZEWQAtqetTXhWWKGl2U5IhFS2VA8FJPOy3qbKGlyGij152AgzQNQOMaMfSTgrpMiAVyXUzGLcL7RuPG0LvPFfp31MJopqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCX3dVOVDfygrsYzWS97LopcIVpUkabUqLC/mI13+rU=;
 b=pMYQDzYTsaCOJ9JVj+v+/ZDbOaLAXBx/w1kQe4rUk53kdSJKZjQAE2ItyjtsNUxbx0AArAhYl2f2dXbyqCS+l6GNxQ0yYhG/GuQVoK9hJLDKc7c4SSuwW4YgAh4Fe+mp/gxeIuvhUU7fOcETJf83r6orBBtdogkbp/VfDtG6eB8=
Received: from SJ0PR05CA0042.namprd05.prod.outlook.com (2603:10b6:a03:33f::17)
 by CO1PR19MB4951.namprd19.prod.outlook.com (2603:10b6:303:f8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 13:59:32 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:33f:cafe::5a) by SJ0PR05CA0042.outlook.office365.com
 (2603:10b6:a03:33f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.12 via Frontend Transport; Tue,
 11 Nov 2025 13:59:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.13
 via Frontend Transport; Tue, 11 Nov 2025 13:59:31 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 5D52C406547;
	Tue, 11 Nov 2025 13:59:29 +0000 (UTC)
Received: from [198.90.208.24] (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 4540D820257;
	Tue, 11 Nov 2025 13:59:29 +0000 (UTC)
Message-ID: <40da8e34-f020-46ad-b3c7-ae48832b5563@opensource.cirrus.com>
Date: Tue, 11 Nov 2025 13:59:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ASoC: cs35l56: Allow restoring factory calibration
 through ALSA control
To: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20251111130850.513969-1-rf@opensource.cirrus.com>
 <20251111130850.513969-3-rf@opensource.cirrus.com>
 <aRM_a09S-_avzLUR@finisterre.sirena.org.uk>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <aRM_a09S-_avzLUR@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|CO1PR19MB4951:EE_
X-MS-Office365-Filtering-Correlation-Id: d6fb4579-11a1-49f9-3e0c-08de212a89ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXp5TDhrQlh0eU53UHB4bUc1bVdaQXlFb1pVakNHTWFNb0lCL3lTME5TQ2V3?=
 =?utf-8?B?aDA3SlpmalRseWJtaEg2am9LZEpIRW9hNGxNYnAxVllWTWxlV3FuaWRTZHdi?=
 =?utf-8?B?OER6ejFvb1VPdndSSHNjanRWUTBpWkY0U2lRL1pvbnRaZTRoOHdSL1EybzVF?=
 =?utf-8?B?dytHTGRJRFRpK3J2VklvZDI0WGQyN3dzdXFEOWF6bTBuL0hkSXpZM2w4NFJQ?=
 =?utf-8?B?eTgzQW1DYzB4ZHU5QTJ5eUQ4T2RuRzZEaUdOUnpteldHeno3cFRsNlRpQWFn?=
 =?utf-8?B?VVYwNG5IeFNNeDh0TGcvbk1Db0RSV3dRUFVwaXJGT0djVGhxR2FIYXcvRzJP?=
 =?utf-8?B?cmswYzlSdmFrYmQ3WHgwcWtQK09aenErUnpQbUhtWFJVdkdrcXNCS2prSmIy?=
 =?utf-8?B?WW95MndjNjdIbW1tcUlQd29wbnpPeGNaSGpUUjR5cFY1VXJxc0pPQ0V6THNl?=
 =?utf-8?B?TkR2Z1c3UnFqVTdkTUtQa1NsTXU2cHZvcm9KQlJISjdvcUowY0d5V2FpYWxz?=
 =?utf-8?B?aUN1dU1NcmtqMDVjTk5DNE5yMGdhK3NXRzdhQTlSVk13c2RjVHNTNXpFSVdh?=
 =?utf-8?B?R0xucXF3c0Z0N2ordklLNjdLUkhDaUJWajNLT20vVHJyelp3UmNLVVhwcVY3?=
 =?utf-8?B?a3ZMd1NkZXdjVFZYTHlFUkVZbDRQQkxYb01XUlY2ckNVSVE3MVhPbVVwZzZ2?=
 =?utf-8?B?UmNkZzRCYWEwVTl1OGpwZWxxM3ptaWNKOUtFaGhUMDhZVGhVdnViQjg3a21m?=
 =?utf-8?B?anRTMEJmcXVQcHN6dFRBdTNJZEw5QnBUWkJxaURvTW1TVXJnVFhqNXpnd2RV?=
 =?utf-8?B?a05SbS9VNUM2Rjg0TzA3S1ZQODhmazlyUDlhRi85WWoyWWNFTjVHMzJUUTVS?=
 =?utf-8?B?WHJxM2luRHB6ZFVvbjJxTlg5TWpDdjIxRk9aOWdEK0g2T3ZxSDhpMHV0Y3Nh?=
 =?utf-8?B?dW5UczUwQ2FFbVpnNGZHcVc3eHBkSmJ4QU9sZ0c2UXh0aFZubi9MM2VUMnMr?=
 =?utf-8?B?UkxMVXN3ZVNuSkRrNmhoemlabHZyMlVFYldLZXY2LzhVeG0vdXpoZytOVis4?=
 =?utf-8?B?TGxKMjU4UDZ0UGhvcG9jWVlsZlpkU3pSSkE3K3lOaWc2bmtLWSsyRmNTdm0v?=
 =?utf-8?B?eXE4RDhXZUlCOWs4cURUSGhUUndsWThpcm9xWTFJM3A5MENoZklpUmpaMEk2?=
 =?utf-8?B?b2F3aDI1K2FCLytIcGo0amZnekdvckxSbTZ0YnRnUjEzQ3A0NkNldHlWbmpY?=
 =?utf-8?B?SE5EeCt2cHBGZm9XOFdERnNyUzd1RFBxUFc1cVdCWjZjZm0xdDczYzh2QWJx?=
 =?utf-8?B?bWNSVk82V0pZUE5WRnRZY1RzUkRnR0Vlajl3Ui9aYzc4Q3hRRWRlTXdNY2Js?=
 =?utf-8?B?eFhSblFWN2J2bkxyOFBYNXZibVJnU3VZZE9hbHFHZ05SNENIMWRtT2hFU3ZR?=
 =?utf-8?B?bHV3alFIVG4rVTlXUWNZQW9CWUdIQS93YTgxc2NveW1sSy8ySzhDbDdDVE1a?=
 =?utf-8?B?WGhTc1ZBV3lqQTBBNmsydHVHbmxKaFM3YytveEdTNDRaSGZOZGVIV1VXbmF1?=
 =?utf-8?B?Kzh4ZHE1c0NTU01meGhGM3l5Z05aNDJKQUpwK2hWOURMVzBuYXdSNHhVUjRT?=
 =?utf-8?B?eGhWMkdqeGVyNGtFV0xEQUduRzFBSVFtcnZFMDFMUG5zY1k2bytVc1Z6TndZ?=
 =?utf-8?B?ais5emNHR0NCb0M3UDFVV1Y3UmpQdVVKOWZQOEZrRE0rWTJPSms4YXJLNjA3?=
 =?utf-8?B?OUFBbjB5YVlWVHlHL3VjRWVBL2ltT2RVTWE5RlV0YzFzRWs1OXpST1o0a0FR?=
 =?utf-8?B?MklTVW1GeUFmdGx0QStTdU1sYlRXZHVlYVg5cFBwcVVsdFVNUDEvQ21IYUZC?=
 =?utf-8?B?NzNidFRsNTZlYllOa1JnbzBpUGFzNWJlaE9qVCtsSEs4S0xCa0hwdE84SSs0?=
 =?utf-8?B?V3hEZnhxSzdtcXppZ2Vqd0hoUEN2bGJHNVI1bUFYbzhTNkNPbHJkOVZkUk5E?=
 =?utf-8?B?amtRWXMwVXJCVGQybC9hTy91c1NUR3gxZnNQVHgrMDdIZm9ZM0R6eHZyYlhl?=
 =?utf-8?B?SUxvNjdFd3J6aHR1eFRWRTV1NVoxK2k0MXJ4U2dLSXpoYWRyWVJCVHM5QjVh?=
 =?utf-8?Q?N6ik=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 13:59:31.2005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fb4579-11a1-49f9-3e0c-08de212a89ab
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR19MB4951
X-Proofpoint-ORIG-GUID: UhQ-ynbr4dQmLeEWJ_LE73j8KbjdQtMI
X-Proofpoint-GUID: UhQ-ynbr4dQmLeEWJ_LE73j8KbjdQtMI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDExMiBTYWx0ZWRfXwWWxjcD2Dh0b
 Vhj+eOEjrPTKgDje0jQdPLYCbar5bGDNYbi5KENh+k3Wld+8iNeurkdGrtDxaFRrDHnSIZ/e/08
 AKutHkHmSPlJDxVblNKwvB3CDBUPQ14JdxB/04R0dG9GMaq0gQnau4UUITWC2UlmbXaTaty6UOt
 dnV8S8jxaNhKGI2x+0kSHpVI4UNoP85T4gsdqvCYC+e8zb0BPZll+wMdeCvXSL9Bft2QhnyG6yv
 M4oC4zWH0adsvkTrLX7RAAgCxb5RHd1VuGrjYCUSKwhY13/HobmJzdglyqk1m5uVNesjclIgN9Q
 ZLRo6H0e/9p9Qj6DIr7368Og5QSE3na7sgYX18CsoeCKc/IEjhRPtvxUwd9eLsmjHkxDlQZFzEC
 D0eWVoI7bl5/w7k9mAKdRONOUMYGCQ==
X-Authority-Analysis: v=2.4 cv=NdrrFmD4 c=1 sm=1 tr=0 ts=69134146 cx=c_pps
 a=zmg3q5OHj3OrxBnMicu8lg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Gm82KTP2hv9gJ9BBzZkA:9 a=QEXdDO2ut3YA:10
 a=M91JV_wKSCcA:10
X-Proofpoint-Spam-Reason: safe

On 11/11/2025 1:51 pm, Mark Brown wrote:
> On Tue, Nov 11, 2025 at 01:08:50PM +0000, Richard Fitzgerald wrote:
> 
>> +config SND_SOC_CS35L56_CAL_SET_CTRL
>> +	bool "CS35L56 ALSA control to restore factory calibration"
>> +	default N
>> +	select SND_SOC_CS35L56_CAL_SYSFS_COMMON
> 
> Not a big deal (don't bother with a new version) but N is the default
> default.

Well, at least it self-documents that we _want_ N to be the default.
But if that's considered bad grammar I don't mind if it's removed.

