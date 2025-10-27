Return-Path: <linux-kernel+bounces-871453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C3AC0D605
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955BB4259CE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EB62DECC6;
	Mon, 27 Oct 2025 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Rwv1DxKl";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="AZMQoAAB"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B2A2E2EEE;
	Mon, 27 Oct 2025 11:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565892; cv=fail; b=P3ecS0f7dLnGRlzdOMj7uxh9Xl78PEmbn1dVT5QWTT4oy+aE1uOBy6tMnSo4P8+HzkU9w+O1YTjLT6EQYJFeikQslXWBNwWsBJKZUsGp7jtxTf4Mi62DykZBdcwnO/hm94vupYrKMi5fEXiEHJ2XzaFcr+OUCHbEit+fIbYX8qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565892; c=relaxed/simple;
	bh=4KhOkmphPVTO+I3lkNQPu5YCwMmrAAd/L8xa5ZCgrw8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dMyGmAlfymYuRNEIRs56PzF1DMxdy7aryJxTdnM6HHuLP0JDxcP4jweOsNoalDJu+aN47Q7HwVZSqhd79CsQq7T61whiIoqDU1EVpT8OHgBttiT5VQCTb9fWFurgMYnCdvHcsxOwbfcr7HLvrbpGjE7frIm8zG5ptFkt1G1KR98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Rwv1DxKl; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=AZMQoAAB; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R5GPpG2663357;
	Mon, 27 Oct 2025 06:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=a6QRKhETuClgqdama/crx89Wz7jAgnl2SoBSvp+Tyf4=; b=
	Rwv1DxKlnrrKeMu/K7Ozcamgew9UVt44T3anrLyKIYoapcJvkKzmHYnr8feSbH7G
	6TFuSwaxYQcPyYCSOisrArfl18XsDmbzNs/6sO5a/T7SP70KmB9zFCDxQEQsqTHc
	a723uMrMw54qEVP4V/thJHHy6hWjeyShnuENDPJHJ/2XYnxhzz0/BYeI49Cpz046
	v9u5uW3XnZS087eyVs0hY2QZE2yc4s6SXbTMgQsbq8M2DxV+Q6n8SPWjnLxOP5XX
	Qx3S73bbZL0JYnrRrs5r7JyG0bDDduk4eW1spPPW5POwl2+z4BbBizvcPVH/bwoA
	TpWFJP7OxoqXRkqjY/lRPw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020123.outbound.protection.outlook.com [52.101.193.123])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4a0uy01u3b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 06:51:06 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKg7mO0wDicedJL6hhvQXi6Y2kHLacSPJBs0vy9tkzc2Cq7+EtG9aXdrZyVBmS5BDxv5bw9H8cOYq64YMbNqJZiD14y/1mrgOA54QxGL2qyZOd+H4yqno1/Q2MIyG/sLbKKK3Kq6Du2WTpSIJLEuPy2Zm2JIxsjJLzTsVGtMIiLWQcTSDSwF17SsE+WsyeiFL1QD3oKLxYAxTJznLRVK+qG69rVoX46wECDYYiln65PbA5d3AvsPvU+6QWy+SVxjVw9vwJBZ+spTKTF63GJfzNaFZuBPowG/0wCsWOE/kokWIhihnKYp7COyHTDp1a9fYEk/O0sfhe8kVhU+kqedhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6QRKhETuClgqdama/crx89Wz7jAgnl2SoBSvp+Tyf4=;
 b=cvT8fpynnQ+jKFirCKv8I82L/isFHT3Vxqdh3vNrIW+9cM+YLdw8XiILZm9/IiNBSgnrSJTGw8PZiJQ0SYpStmuSANY0EvYMF2T3s5Ik1EPoqdOST2C5ErvdOrDCCYw9eS82fmTRhuDyBHfRPl2h+K4d6G1BBBjOpetJ+m3d0TUIvVhr++b5xMgB2KZjj64UenRwYlDa64sPh4rR6KKGj2D/V84J/G3E4dKgMzwBRkDXDrRU4uLq7WatoJtcfrz34XwjxfvobOlZifGwcw+rZAh4nbhCBizi31M4dKazrQYg0SGrVlYHjnNBFVTj7zN1fdMUP0nbYHlLcRiaaGh/mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6QRKhETuClgqdama/crx89Wz7jAgnl2SoBSvp+Tyf4=;
 b=AZMQoAAB4wbUgm6BOI23ysudltQRSBZqiukZDTzzwsFNgIS0YptM47XIZ7UJzGN3nAyjpoRUnMvYZseKuReBCobvrWRJMIyLtJEulWTdVISmxxR5gYeNADLT8HbSO62ISyh3F2E9DSFs5vsfcP7C6Xc1v+1lAkMDOhFiVZZGgwE=
Received: from PH3PEPF0000409D.namprd05.prod.outlook.com (2603:10b6:518:1::50)
 by CH2PR19MB8896.namprd19.prod.outlook.com (2603:10b6:610:284::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 11:51:03 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2a01:111:f403:c801::5) by PH3PEPF0000409D.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Mon,
 27 Oct 2025 11:51:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Mon, 27 Oct 2025 11:51:00 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 0FA0C406547;
	Mon, 27 Oct 2025 11:50:59 +0000 (UTC)
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id F2417820244;
	Mon, 27 Oct 2025 11:50:58 +0000 (UTC)
Message-ID: <3cb73dae8e8ac1a29c856dc5c86064d568003316.camel@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: sound: Increase max size of components field
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 27 Oct 2025 11:50:32 +0000
In-Reply-To: <87ikg03ecf.wl-tiwai@suse.de>
References: <20251023092754.84095-1-mstrozek@opensource.cirrus.com>
		<318f2ed3-57e6-495c-a773-4a094a3784cb@perex.cz>
	 <87ikg03ecf.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|CH2PR19MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: a93e962d-5237-42fe-ded3-08de154f19a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWJMeGRWVEM2bDFjTEUwRkorNnp5VTV5OWR5UGRvNXhFcUtFcWp1bXVrcXZp?=
 =?utf-8?B?N01tbWZqNVN1NTZKek5ZMFJYSmlUbmNiV3UwZm5USU4rM0sxbWJQNzBBT1g0?=
 =?utf-8?B?cXV1VDNmZ2xKd1c4SWcyMjJ6VWlPb082SjJ0aytSZ3VHdGJibnBUMHg1d1VW?=
 =?utf-8?B?MmxmaHZPekRFUm5RaVVKcTdaazhYdjc5c3ZIalc3UytDbW5jMkVSaXJQUEQy?=
 =?utf-8?B?ckEweXRYTU9sVmc1UnRIZTh5L0ovVHRoRlBURis2aW5CRTloTW15TVI4aGpy?=
 =?utf-8?B?b0c2cE1vUGdMSGFVdC9TajdhWHd6bk8veWU2ZTFXMGsvbTRHUnJsK0F3Sm9t?=
 =?utf-8?B?WERrNTlBeWR4dk5HUzRoL3RjclFUQ2NlV0Zxb1cxQi94NVhSSTJvQjhSS1BG?=
 =?utf-8?B?aitNM2Z4clY4c1hoYXN0MFd5dEZCcGU1VjlzMDBZYzVsYVpoN045cGVkWkc0?=
 =?utf-8?B?T1BOaEFrQUw5d29kaUZMY0RmcVN1NWV2NDNPdy9iVXRhVDBLRXhEQTBZczll?=
 =?utf-8?B?RlNkc2VlZUtjVlR1MEF2SlZHNW9UMmJuWmxjRVVGOEcrL0dSb3V5WW5WN2RI?=
 =?utf-8?B?RjdTNEJTN1ZJSWFDOXV5cmNDanRTNTR3cEtRRFdOUjlYZ1RiK0ozU0N3RzVL?=
 =?utf-8?B?blg3TWlsbjRYb29TN0hmMHBTRG9oYWxTV2h2UTlHWk9nVTY2dHBOSzJ0VW9X?=
 =?utf-8?B?VnJZdTYyc0NUcEUxU24ycytKNWlXRjI3bEo5djYzcVNnRG1mc1lOSXB5aXFF?=
 =?utf-8?B?RzN2T1FTcWZqSGxkbStVK0xwcnlTYUozK0lFVkNVZTc4bWdOYmpPVnlGRWc3?=
 =?utf-8?B?MXAreUtESHhTamtOaVZFMy84dDI2UnZmNWowTG91cC8rcmk0UFd5TjFsNVJC?=
 =?utf-8?B?SDBZN2FQTWhFS24vQlpiZk9YYzRwM0c1V3crMWJ3OGxuVnJjL3ZRQjhnMSts?=
 =?utf-8?B?dUZjTzlFQk1qU1pOWDVLUWNLbnV2MW0yTUt4QVNrcWd2Nm1PTll2cVU2MEU4?=
 =?utf-8?B?SzllVGE3NWpoRFZoeDBHZ002UzZlQTJJN1AreU5UbjRDVjFZUVFnK3JETlRG?=
 =?utf-8?B?K2tjYlEwZDZ3aUV2V3k1RkJEeG50STFhclNzTGp5ejZLcFNjZW9CWHl2MnVy?=
 =?utf-8?B?eFF5eStyK004QjNaR1REcHAzdTQrclhRYlhabCtnTmt1RG8xdlZCblhJV3dH?=
 =?utf-8?B?TjBPUUcxSWhHUzZhVkZzNjhlUG96WEIrT1dSZFNpYmx1a3VZTnNDbUJEdEU0?=
 =?utf-8?B?U3kwRDJIa3RWOFhxOCtNcjZZWjBWSlFHNE5BWmxHYlY4Wm4wa3hYalFrV1V2?=
 =?utf-8?B?RUJUbm9ldUFkR0thVkdUUEV2ZVFqUGcrSVVYUnk1Q3JoOVREQmJjbks0UU5o?=
 =?utf-8?B?Z3JrWisxa1hVcmp3dEVDRVJrL0RWdjlBSW5YMXY5ZmUrMXF2NWR6OWxiVHZr?=
 =?utf-8?B?MnZ0dWJoMklnb0ZUbmxOUG9lWVhlcVJvUXVSZ3dpelR6cTE4L1UvRHdPU0V6?=
 =?utf-8?B?OXBEZG9sd2tHNzdGN3Q0UkxMSWdKU0loTHo3N2Q3Y3BWUmJMdzY1MGlTSm0v?=
 =?utf-8?B?anlEU3VHWGRJSHhZaXVaMkhWTk9OWEhxRk1WNmR3a3dkMkJ0RFF5V0k1Ulp6?=
 =?utf-8?B?M3NuNmNpdlRaZWJhM092RUp5ZmM5YUJLSEswS2lFUHZ1dm9FWS9YTXZzQnZS?=
 =?utf-8?B?cXdRTXJYYUVpbHR0TGQ4dUhWMlUwRDdvUDBPVmtIcVJtdmMxNFFwU0lLR2lM?=
 =?utf-8?B?RGE2SndNVU94My91U3RFQklFRGV2K3AyYS81R24rUVhZbXZTckNESFFIOEdB?=
 =?utf-8?B?YkZtaGw5eC9JV1p6Nzk5SU1UbVdmeXhwRStFQlA2alNVc1ByVzR5Z3RYb2tT?=
 =?utf-8?B?ZWhtM05QVXhtcS9uN3FpQ2dlTGl3WTBCaXdaNFZwU1Q3OUhycmoxRjN1K29Z?=
 =?utf-8?B?dlhlRUpEd3NCaElZZEsrWmxJRzRvdTNZdVRiQzBrQjljdGFkNmZidDcvZWg0?=
 =?utf-8?B?NDlwYnpIZ0Q5TTFOV0gxK0w4aFZBZ1I3TXdpcklHU3diYks4TmZZdzNhVzdp?=
 =?utf-8?B?NDkyTVlKMU8zSkt4Wnh3c2lZTTVSK2hZNGlKRzR2eHVvUjBpeG1sempCWXRU?=
 =?utf-8?Q?N0pg=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 11:51:00.7337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a93e962d-5237-42fe-ded3-08de154f19a5
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB8896
X-Authority-Analysis: v=2.4 cv=PdzyRyhd c=1 sm=1 tr=0 ts=68ff5caa cx=c_pps
 a=zwG93V3sI98pkU4B7UI0OQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=SVi0SWLsFK9toM8Ma2kA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: rFqFwFqtxhg86vW2SyzJ0XUU5bvZfb9d
X-Proofpoint-ORIG-GUID: rFqFwFqtxhg86vW2SyzJ0XUU5bvZfb9d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDExMCBTYWx0ZWRfX9N5CRHtnrOvN
 9jNwTJvfimBLYdQR4CnsnJZNIY0+ERgWcyTskG99SLI0BENRGx34un/hjoJ8x8vzDSOebKenXAb
 YP2hIUMtxUsXfXOmzNz1GPPI2p2ibTSRxOhDEWQ4ONSgUUD8NxRFZ59px2Obo9C+RPnFhkigaOi
 otulOJ+FXm1VImA3uCb3Hrpya4tFJMnPRgxMyDNEqQb5vYfuPDqzb0xcf+QplN3BzAZhKQZx/+y
 FqXvnWKbtOPPI0J0Bua+8U8piFPO3J8V4so32UMQd3EpwWShI1rNARrQAc61FcYicXu6XItc+UM
 /s9F60ZqccxpemtysflRgcu3DzS6lovwkRzbzoiUEkTrcLmBWM1Sgp8w0a8SiZIsL6Em1+64T29
 GLhYOsziuQsc9sJT5r0R87aVJ3F6HA==
X-Proofpoint-Spam-Reason: safe

W=C2=A0dniu pon, 27.10.2025 o=C2=A0godzinie 10=E2=88=B604=E2=80=89+0100, u=
=C5=BCytkownik Takashi Iwai
napisa=C5=82:
> On Thu, 23 Oct 2025 13:56:26 +0200,
> Jaroslav Kysela wrote:
> >=20
> > Or, we may introduce a separate ioctl for the components string.
> > The
> > stripped components string in struct snd_ctl_card_info may have a
> > special ASCII mark like '>' at the end of string specifying the
> > availability of the complete string through another ioctl. I would
> > prefer this solution.
> >=20
> > Also, the components string may be dynamic in the kernel structure
> > (pointer) to save some space. 256 bytes is not small number.
>=20
> As Jaroslav suggested, we need a different solution to keep the
> compatibility.
>=20
> My gut feeling is for the option to provide a new ioctl as it can be
> most straightforward, but we can discuss further which is the good
> choice.
>=20

Thank you for the advice! Not sure if I understand Jaroslav's new ioctl
approach properly, can you have a look at the quick draft below and say
if this is (more or less) what you would expect? If it is OK then I
will prepare a proper V2 patch here with a corresponding change for
alsa-lib repo too.


diff --git a/include/sound/core.h b/include/sound/core.h
index 0eb2e3ee0dd5..c4e52fb1704b 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -88,7 +88,9 @@ struct snd_card {
        char irq_descr[32];             /* Interrupt description */
        char mixername[80];             /* mixer name */
        char components[256];           /* card components delimited
with
-                                                               space
*/
+                                                       space */
+       char *components_pointer;       /* full components string */
+       size_t components_pointer_len;  /* length of full components
string */
        struct module *module;          /* top-level module */
=20
        void *private_data;             /* private data for soundcard
*/
@@ -297,6 +299,7 @@ int snd_card_info_init(void);
 int snd_card_add_dev_attr(struct snd_card *card,
                          const struct attribute_group *group);
 int snd_component_add(struct snd_card *card, const char *component);
+int snd_card_add_components(struct snd_card *card, const char
*component);
 int snd_card_file_add(struct snd_card *card, struct file *file);
 int snd_card_file_remove(struct snd_card *card, struct file *file);
=20
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index c302698fb685..7d53f6da59e2 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -1069,7 +1069,12 @@ struct snd_ctl_card_info {
        unsigned char longname[80];     /* name + info text about
soundcard */
        unsigned char reserved_[16];    /* reserved for future (was ID
of mixer) */
        unsigned char mixername[80];    /* visual mixer identification
*/
-       unsigned char components[256];  /* card components / fine
identification, delimited with one space (AC97 etc..) */
+       unsigned char components[128];  /* card components / fine
identification, delimited with one space (AC97 etc..) */
+};
+
+struct snd_ctl_card_components {
+       int len;
+       unsigned char *components;
 };
=20
 typedef int __bitwise snd_ctl_elem_type_t;
@@ -1198,6 +1203,7 @@ struct snd_ctl_tlv {
=20
 #define SNDRV_CTL_IOCTL_PVERSION       _IOR('U', 0x00, int)
 #define SNDRV_CTL_IOCTL_CARD_INFO      _IOR('U', 0x01, struct
snd_ctl_card_info)
+#define SNDRV_CTL_IOCTL_CARD_COMPONENTS        _IOWR('U', 0x02, struct
snd_ctl_card_components)
 #define SNDRV_CTL_IOCTL_ELEM_LIST      _IOWR('U', 0x10, struct
snd_ctl_elem_list)
 #define SNDRV_CTL_IOCTL_ELEM_INFO      _IOWR('U', 0x11, struct
snd_ctl_elem_info)
 #define SNDRV_CTL_IOCTL_ELEM_READ      _IOWR('U', 0x12, struct
snd_ctl_elem_value)
diff --git a/sound/core/control.c b/sound/core/control.c
index 9c3fd5113a61..5a96a2ed4a45 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -886,6 +886,23 @@ static int snd_ctl_card_info(struct snd_card
*card, struct snd_ctl_file * ctl,
        return 0;
 }
=20
+static int snd_ctl_card_components(struct snd_card *card, void __user
*arg)
+{
+       struct snd_ctl_card_components *info __free(kfree) =3D NULL;
+
+       info =3D kzalloc(sizeof(*info), GFP_KERNEL);
+       if (!info)
+               return -ENOMEM;
+
+       scoped_guard(rwsem_read, &snd_ioctl_rwsem) {
+               strscpy(info->components, card->components, info->len);
+       }
+
+       if (copy_to_user(arg, info, sizeof(struct
snd_ctl_card_components)))
+               return -EFAULT;
+       return 0;
+}
+
 static int snd_ctl_elem_list(struct snd_card *card,
                             struct snd_ctl_elem_list *list)
 {
@@ -1914,6 +1931,8 @@ static long snd_ctl_ioctl(struct file *file,
unsigned int cmd, unsigned long arg
                return put_user(SNDRV_CTL_VERSION, ip) ? -EFAULT : 0;
        case SNDRV_CTL_IOCTL_CARD_INFO:
                return snd_ctl_card_info(card, ctl, cmd, argp);
+       case SNDRV_CTL_IOCTL_CARD_COMPONENTS:
+               return snd_ctl_card_components(card, argp);
        case SNDRV_CTL_IOCTL_ELEM_LIST:
                return snd_ctl_elem_list_user(card, argp);
        case SNDRV_CTL_IOCTL_ELEM_INFO:
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 6459809ed364..edb7b28d8177 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -416,7 +416,7 @@ static int snd_ctl_elem_add_compat(struct
snd_ctl_file *file,
                break;
        }
        return snd_ctl_elem_add(file, data, replace);
-} =20
+}
=20
 enum {
        SNDRV_CTL_IOCTL_ELEM_LIST32 =3D _IOWR('U', 0x10, struct
snd_ctl_elem_list32),
@@ -445,6 +445,7 @@ static inline long snd_ctl_ioctl_compat(struct file
*file, unsigned int cmd, uns
        switch (cmd) {
        case SNDRV_CTL_IOCTL_PVERSION:
        case SNDRV_CTL_IOCTL_CARD_INFO:
+       case SNDRV_CTL_IOCTL_CARD_COMPONENTS:
        case SNDRV_CTL_IOCTL_SUBSCRIBE_EVENTS:
        case SNDRV_CTL_IOCTL_POWER:
        case SNDRV_CTL_IOCTL_POWER_STATE:
diff --git a/sound/core/init.c b/sound/core/init.c
index c372b3228785..a7ac62ace1dc 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -587,6 +587,9 @@ static int snd_card_do_free(struct snd_card *card)
        snd_device_free_all(card);
        if (card->private_free)
                card->private_free(card);
+       kfree(card->components_pointer);
+       card->components_pointer =3D NULL;
+       card->components_pointer_len =3D 0;
        if (snd_info_card_free(card) < 0) {
                dev_warn(card->dev, "unable to free card info\n");
                /* Not fatal error */
@@ -714,7 +717,7 @@ static void snd_card_set_id_no_lock(struct snd_card
*card, const char *src,
        int len, loops;
        bool is_default =3D false;
        char *id;
-      =20
+
        copy_valid_id_string(card, src, nid);
        id =3D card->id;
=20
@@ -1023,11 +1026,13 @@ int __init snd_card_info_init(void)
  *
  *  Return: Zero otherwise a negative error code.
  */
- =20
+
 int snd_component_add(struct snd_card *card, const char *component)
 {
        char *ptr;
        int len =3D strlen(component);
+       int new_len;
+       char *buffer;
=20
        ptr =3D strstr(card->components, component);
        if (ptr !=3D NULL) {
@@ -1035,8 +1040,28 @@ int snd_component_add(struct snd_card *card,
const char *component)
                        return 1;
        }
        if (strlen(card->components) + 1 + len + 1 > sizeof(card-
>components)) {
-               snd_BUG();
-               return -ENOMEM;
+               if (card->components[sizeof(card->components) - 2] !=3D
'>') {
+                       // TODO: figure out if it is not deleting a
character from an existing component
+                       card->components[sizeof(card->components) - 2]
=3D '>';
+                       card->components[sizeof(card->components) - 1]
=3D '\0';
+               }
+
+               if (card->components_pointer) {
+                       new_len =3D strlen(card->components_pointer) + 1
+ len;
+                       buffer =3D krealloc(card->components_pointer,
new_len, GFP_KERNEL);
+               } else {
+                       new_len =3D strlen(card->components) + 1 + len;
+                       buffer =3D kmalloc(new_len, GFP_KERNEL);
+                       memcpy(buffer, card->components, strlen(card-
>components));
+               }
+               if (!buffer)
+                       return -ENOMEM;
+
+               strcat(buffer, component);
+
+               card->components_pointer =3D buffer;
+               card->components_pointer_len =3D new_len;
+
        }
        if (card->components[0] !=3D '\0')
                strcat(card->components, " ");

--=20
Regards,
Maciej

