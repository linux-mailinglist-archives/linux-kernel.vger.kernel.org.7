Return-Path: <linux-kernel+bounces-859728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0B5BEE6F8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C398E421131
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 14:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689872EAD1C;
	Sun, 19 Oct 2025 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="lu9cQSjo";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="SvA4JW5A"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890861373;
	Sun, 19 Oct 2025 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760883825; cv=fail; b=okZC+DvYcQyMqpuJGqg7D/02VnTCteGdtOVHcUtZ7DtBsEv5U6ZxwL55NaVv/h+xhUmvB280Cih8l0wDEAv2hRaLX4LZ2Mz6HlsSLZhG3QEmyRBnoc/awKPMxsFLH0jLvttLmtD3V2zhjEIPHibaYqjmVKF/ZNaMRDlvAf/43jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760883825; c=relaxed/simple;
	bh=9PZiosSfT++nWx5zucezjgmN9egmbGDtodzC641+aY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m287zXEbhiHOG0fbv0OE+3whf6EFNE6Oa1bg144iksKx0d2oUqmzKVQJcxWEu38CHIwnrkFCuHjxOCL4qrdwFCbYIG2gVkEKScQJrWtOqEXts2sAvPjnk1gP3hPGDnVXsVI7gAcJiVV+KddZR0fSsOUdK0B1LGyfDcko5dHlEdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=lu9cQSjo; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=SvA4JW5A; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59JDl9Ru1434545;
	Sun, 19 Oct 2025 09:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=RJfcQBECUQxXS6ElQ5qpXcewZd2sKEKexO6iGTWUDr4=; b=
	lu9cQSjoMrZmofQ/182UXFDYV1jY8xa2ZPBxFv+Mr3SwhCoJLrpJ+RATyjDtPViv
	d9Nn1Rsu2/tqq+jvK1UnnsI2DQJf4haqM4WPUqofZRfprU2QxOrm2kkxyxO8eCjM
	52WKDeswslKkOBYFKFh4+5/LVNjhkK24fz4n4ebo0f9gw6J4cLcmiXbf/Gz4kdDg
	uskQ5JvLHtYwkR1zq43CzsTNzuwfZlZ9IwPvoTc8oH9n5fxBPT9OW/2zcYoC3Hov
	oH2Uk3eb5gt/db0w7KBMpO3DyOJXLirTn+BXHf5QmmSE6HHZoXAuLDkkI3AD2PEc
	wD2dEsdA7Acok5rUUvjdPQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021103.outbound.protection.outlook.com [40.93.194.103])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49v8a1103b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 19 Oct 2025 09:23:20 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQYKNhWeX+LYar/3EufHsf2e+1jSGamynDGkPgLrQGrq+rrH41KNHZUDaEbWGXLYNDWMIEgo8A8T3WW48FjxcHEcF4boQCs+smtxGVrTV1i7tRpqkzrK4Q5j0BfDAfvHwcbiL/jIWYIoHFOpkR1OIGsrfoqdlm3vG5rPl5ZXHqn4XesMABkmBoqCIk6bk/ndRhD4Cd8TX24Mz0pYCObmbaJ6dSybbOeW9K9SAKGxwdDXDLG0+UVHTFxiQT8d1PMloWU1S+YWAtPPO4AHqZD0kFCD8I3NNy2t04hsthBOkLW3afZXCqj8pSS2zZ3dKR94EONFwYcY1UuBZBefwV2XDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJfcQBECUQxXS6ElQ5qpXcewZd2sKEKexO6iGTWUDr4=;
 b=qYaXMwbeg03VXPRIbIwS9NRA33mxx3sWWEuP5LCElULp4p7q2SO7QeSR0el5DkHbz1zFXCAiaj2EQUrAmiYQUdEj6YrcGt6VWKfWDSOHTOBg+EYcMW//wrFt2mBlpmgNiemq5+lJAuxGGu+AX/6TGb9uxPnRBzppI2lIexxKhWlnzVW2+AEKk+1tCEbdIo4q0FldAOO0Cgj9TnZ5sc9MvWb0colEunugIqqW68s3ui84pnRfsBLVHAApz4eekVbjiabODVCIGgg+5JqhD23oPynDEQS/lBj2jr0T/LGq7cUO6KdrxILM24nBdtGVytX/gJ+D1cFmmv0TCLRltiP9gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJfcQBECUQxXS6ElQ5qpXcewZd2sKEKexO6iGTWUDr4=;
 b=SvA4JW5AjM/5Ni7rKEXRhe17ftoqVghsE5jtnqSMkfDgQe6ONQAWHbD6D2idrH1D4fKhzXHgtIoJcmoHiHrCVf+2DRPQv5WvT0PpL86Ase7NFMCGoKyNkg9fFQ9NrUc9KdJw/12pDMOuyN8rdzWXwR5YfReL59l1hT6sBX7AQg4=
Received: from MN2PR22CA0011.namprd22.prod.outlook.com (2603:10b6:208:238::16)
 by DM4PR19MB5714.namprd19.prod.outlook.com (2603:10b6:8:5d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Sun, 19 Oct
 2025 14:23:15 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::7f) by MN2PR22CA0011.outlook.office365.com
 (2603:10b6:208:238::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Sun,
 19 Oct 2025 14:23:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Sun, 19 Oct 2025 14:23:14 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 48B0C406547;
	Sun, 19 Oct 2025 14:23:13 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id CD2B5820244;
	Sun, 19 Oct 2025 14:23:12 +0000 (UTC)
Date: Sun, 19 Oct 2025 15:23:11 +0100
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 06/11] ASoC: dt-bindings: sound: cirrus: cs530x: Add
 cs530x variants
Message-ID: <aPT0T-xN-ghoP4id@lonswws03.ad.cirrus.com>
References: <20251017161543.214235-1-vitalyr@opensource.cirrus.com>
 <20251017161543.214235-7-vitalyr@opensource.cirrus.com>
 <71c6d7e4-0565-4444-a28e-b3432e209373@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71c6d7e4-0565-4444-a28e-b3432e209373@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|DM4PR19MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: edf174c2-a1f3-43cb-ce84-08de0f1b0aab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2dGbkczVDN3VUdVRCtCZjdKK2N0TlVOSEtuV2xwZ0lqejZySjJLMWpSWVdW?=
 =?utf-8?B?bkdpMFczc01RMENiN3BRd3BNZTVBZmhHOUlpZmg1OHl0QllwejF4VDA4YlBq?=
 =?utf-8?B?NXU1aERJd0xTYnI3bUFRbFVObHh5bmJ2S3pmN0x3TmRoZ0hMMzl1Tm9XYTRm?=
 =?utf-8?B?aVdnZmV0NmlEbldOZCtYZXFIYkNOQmRQeTdVekR0emdYdHFqM01mdkZYQml0?=
 =?utf-8?B?ekVkNzBnQTc1c0xJN0sxbnFCTllNenRGcElpblcyY0djZUpFTEQrRHc0cGZS?=
 =?utf-8?B?Uk8xVWF0b2N4T1krSmJIY2VhakdLRVF4bkxvMXVwanJXYkxhMlc0eHVldVhW?=
 =?utf-8?B?dWk1eWI5YUgvc2JtQk1WU2FtSzFabnJBNE9Ea0xJdTQvdTJORHFUT0ZTakpq?=
 =?utf-8?B?MGtlM2xPR0lSZmRINURDYzBNOER0K0ZtcDF3MFNKTkE2bDRIeUlrU3NDWGQ3?=
 =?utf-8?B?bERrUEEzMy93dE8xLzRZdW5QUXd3blc1SmZqL0YxR0psQ2hmYlhYTy96NlQw?=
 =?utf-8?B?cGtmSlowUk5pTmZKZlR5ejBoUHNaZTBRekRYUk1hbCthN01WSUMxRmxLU1pM?=
 =?utf-8?B?TDVWNW1hVkoyV0tzeEY3MWVMbTRaNmpteFNGT1Nqb0QycHJpTmFscEROa2kr?=
 =?utf-8?B?NjNxbEVFNmdNVmsxWFJMSnZDcDhhUVR0MHJvY0lRYlFzUnhETW9NWndaM3dF?=
 =?utf-8?B?ZVVsdFJSNWU3eENSYTQxVm92bXhqcUhkRFhVWmo5MDM1THVoazlGZGRqaG5i?=
 =?utf-8?B?cDVOZVUwZmQ3S2h2Qk9vRCtRZk02NjZYNjFWT0locWhKeHoyRWlEY0E4TjJr?=
 =?utf-8?B?aFhPcWRXTWp2ZytjN3pNNWxGdmJvY256TjdidmVDazc3dyt6blhpOXNjL2l6?=
 =?utf-8?B?OXJCS2c5WFEzZ2xwbUFZTldTNTB2NWwvN21JRDNpYmpCUHhpbVRhTmtWYUgx?=
 =?utf-8?B?dy9QRFZXUlJjMHJJZUplMVpuTmZMZSt4aHQ0T09VdldFUXJtMHpFdnpka290?=
 =?utf-8?B?alJzeUxmRTlVVEpHUlZQKzVRRzhKVm5JTm1yb2dDeDNUUGFrYkZiUC9Ld0ho?=
 =?utf-8?B?ZWxkTVg2SFhnQUxkUHlLSVRxR3FLQ3lmdFcwTytkRit1QnFsL01PWHdaVnBS?=
 =?utf-8?B?RXpGNVBrdnBCMktPMlR1SHk1ek1Db0RUNmZmY2w2Z0FxOWZmcklGbDhTNFFr?=
 =?utf-8?B?OExycDdaR21PV1VFVUxyNkVuS29iQlF2L1FiMW9FU2ZjRVhydHF2VFRmenZy?=
 =?utf-8?B?aG1QWG1Xb2ZHWEpMdFN3UGRnZkZFT3pqQWVwQTBIVkY2NlU5QmpMNi9yMVVz?=
 =?utf-8?B?OHJPSUN6d09DaWpoSkxVUTJaNUFITjJtdk5VZjRENnEzMWIzSGhGd3dBMVRl?=
 =?utf-8?B?N2thVWpJeEhrYVZsY1VJTWVZVGM2N1lySEdoWkRvQ0VhUGdWc0lSU0Q2c3hr?=
 =?utf-8?B?QldmZU8vNGphVVdFOXV0cjFjQXhrQkoxdUw5dGMvSkQyeGRtVXJOMTkxUm02?=
 =?utf-8?B?VURiamwxaWp0YUZhQk1kWTAzUUVjTEIrOXg5Vy83cTRYZWV1Y2FqNkVoUnMv?=
 =?utf-8?B?ZXplVlVEU21LNEs4UWtMUlVDd0Z5YlJ6UDVXbDJRR2wybklVY21Oa09xWEpl?=
 =?utf-8?B?bHE1ZTBmMzNXOHVHU3VKZ0JKQjdjTXBLVHgwYXQ3L1V2ai9vbXRqU1J2SVBj?=
 =?utf-8?B?SGpabURmMzREdW5FMHgwSG5vLytwWFg0TElaTlU2T0JXL3BLSTVaRkZJaU12?=
 =?utf-8?B?SDJ5ZW93eit6dlBPY0IrRTBENzBHaFcwbTFud0F6YSt2NHR0US9wKzErWUg5?=
 =?utf-8?B?SzFYdjQ4TFBEMFAwNWZ0aFVyYkRQSFAwTkMvL3UxVVl1OUpCVzBGUFBTUXJ2?=
 =?utf-8?B?M2oyd3htQ1R1ZHJzRkN1Rzh6cXFhN0VpUHZNTzcyd282VG01ckJlZFRkaXhn?=
 =?utf-8?B?eWs0Q0J5N0xoazR1S0JMcVkxeTdQWlZOV2ltNlVOekxVbko4Z09zN1QrVzll?=
 =?utf-8?B?T0UrSGxGMHg2WEJWUWxLT1RoaVVkUDgzZUp5c2V2dTY0R0dKZzczZmN4NmU3?=
 =?utf-8?B?dkJqUDlPTHg5eXBUOFpWYjN6VVJDVEtDUHgxa2RGb05EckxtZmN2K1hFNjRX?=
 =?utf-8?Q?gC/Y=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2025 14:23:14.8696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edf174c2-a1f3-43cb-ce84-08de0f1b0aab
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB5714
X-Proofpoint-ORIG-GUID: v7Y_8Aq8RXM9H-hBKKrnXwoLaf6ZeODd
X-Proofpoint-GUID: v7Y_8Aq8RXM9H-hBKKrnXwoLaf6ZeODd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDEwMyBTYWx0ZWRfXyXH1F4e29eaJ
 tg48B2TIF36obnL3TApI2zI384hQ8aW1X16qjyir8YJw8LSaZOl3L3whgJ/xU7RfgMd8CpyAJu3
 VnULWHiOqIVzZ4w5wUyCBa9JrG6bk9F86MEgDppTgCzyWuAmKdDDxnSroDPITZ3QCxSF9eyr73/
 PDXFCVOjz3ATsVFkwvFo9mNy9pSj+mfdT08XdPBrPJj3gZIe5FQ66Rlczv2LDy2SKvyYQMD4JPL
 eqVRMx3+0IFGTyRU8OYhSrZwYX7RFQcZQAGOdDe62AqH+Ab4mIiQsl5M+xfq/F2mAiP/UNFlF/G
 ph0AnIgctMU48tI4W66MvBP7v+uZVCLd0yULyB6SbhdWGUT8Fel5RDHPT8x00jC1l97Pf04zp27
 UMzTiNvugqZfRDZg4w0LUcc0qpuo/g==
X-Authority-Analysis: v=2.4 cv=NMPYOk6g c=1 sm=1 tr=0 ts=68f4f458 cx=c_pps
 a=GZ5nxs7iJwyXCG4rR3qJ+A==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=r1wxIN8fUqtLD_zMjlIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Reason: safe

On Sun, Oct 19, 2025 at 12:32:20PM +0200, Krzysztof Kozlowski wrote:
> On 17/10/2025 18:15, Vitaly Rodionov wrote:
> > This patch adds additional cs530x family variants.
> > 
> > cirrus,cs4282 - high-performance, 32-bit resolution, stereo CODEC
> > cirrus,cs4302 - high performance stereo DAC, 2 channels
> > cirrus,cs4304 - high performance stereo DAC, 4 channels
> > cirrus,cs4308 - high performance stereo DAC, 8 channels
> > 
> > Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
> > ---
> >  Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml
> > index 9582eb8eb418..90a5cea0632d 100644
> > --- a/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml
> > +++ b/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml
> > @@ -22,6 +22,10 @@ properties:
> >        - cirrus,cs5302
> >        - cirrus,cs5304
> >        - cirrus,cs5308
> > +      - cirrus,cs4282
> > +      - cirrus,cs4302
> > +      - cirrus,cs4304
> > +      - cirrus,cs4308
> 
> I asked about fixing this at v1. You ignored it. Then I reminded this at
> v3. You sent v4 still ignoring my comment.
> 
> I don't know what to do more.
> 
> NAK
> 
> Best regards,
> Krzysztof

I’m sorry, Krzysztof — I didn’t ignore your comments. I carefully read the suggested documentation regarding docs and DTS submissions.
My mistake was that I simply missed the point about sorting the string list, and I’ve already acknowledged that in my earlier reply.
Apologies for the confusion — it wasn’t intentional or out of disregard on my part.

