Return-Path: <linux-kernel+bounces-741852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 905C6B0E9CC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A501C24084
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 04:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A85215F4B;
	Wed, 23 Jul 2025 04:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ASZOmamh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ytprlpeu"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571901FC8
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753246168; cv=fail; b=HTXuwgZe0ogQwKZxLed/YigNkeRwc9UG5vdmUvNG4Y+1yZR0v/iyy4qDFxR4fIkBg2FU+hru4AulcD4PBO8V2MfXnW/WZzEl/PRoq74Ly6OVSL+7UpOkLj4jIdWxCQWIfUMzNboTA5LahhAcdMxxzDlGrP4JuSQTGqmO5KDljI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753246168; c=relaxed/simple;
	bh=nsordmvT1N9Sb4hUb6Wm+lLslXw/IBrDz8iqEnqKMxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sufknL9tCMBlPFdOduFnDWpg5NKEDprmpiDFBYmFfH0adRakDRa+NG8ofPx47Ib8MdWGBpXGD6w7gMDGPmj2CUpSWOIkwUdt+UwtrKGSXD6tG0HTu8w1IBspbKDoxI7ENbar07TSr7VmSGdcKuRfQusE4ay1pWAYHjq92rwvwjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ASZOmamh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ytprlpeu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MMQmKo021733;
	Wed, 23 Jul 2025 04:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=j7mjHLU6Yvmnzok4wYU3L88pVKidK5O51T0kKh/nBRM=; b=
	ASZOmamhqGt0bMgjtmIuDrkYbdk8nN/VfxXR79IymkIfCyAhoBBC+4HQyXKmmr1M
	DzYcj7TPv6iDXHyN6FReRG01Ne26F+FxPydx0DQs2tr0yPwGKIFqp2AJYb93U4r3
	TGZuVb5gPvqGUNJG+oh1kZDkRCdk9ob359FQBQWzDKJukV3eNfXJxUsxtsWrOdrR
	Ex5GPDA0HK1DdoBqxz77G1SVLfXANlZZBOCD/K8eOqaQ1agp4VX3bAjiUKobmrZz
	k5Qoza4scxkCrf1USgxOUhduErlxsPwSLyjuc69Fi1UzIron0SJKvE33VaKML2Js
	Rm7MZLCiczrhlvrrqMgWQQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 482cwhs74y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 04:49:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56N4XQBR010475;
	Wed, 23 Jul 2025 04:49:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801ta4t8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 04:49:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxqMI3OxuO0xsFlFEOaBehmsp3L3KWGLLyYsnfkjwrfB6AvV8pey9wmkZpghJFCLzbES+FwYhid7/QdZWczxtURR38DtCHvMSbRXpvtuHMOmmhMX+iwrJutbKPLyY0Mb4heF17qChtEnfgps8lX4WrlBOXMOugmLRDABZWcRjICYA8N+9M22nogQsTlAY61/pGWSx+qvMwtWDdHfek7vLwRCDGmrKCb+UzrtwzzG4Lg1uG439R3uX+ez/5k2ujaw39w7Ppn9KgQHKGKihTdHfwMOB3lGVszmIZWRNOh/5UBiV+7wtjoNYkd2hebvIylVkT1wVl2jmwb+yNNG6vjEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7mjHLU6Yvmnzok4wYU3L88pVKidK5O51T0kKh/nBRM=;
 b=ne7Kwmnx5y/w+H95XiHav3f9l6YOUTuRlpFmCWPHKa+tMgXseBcAKR2WAfuUPUpWRWN9saWXHp9xHqWy1J7GETYEjDZ4ZVi3E5El3ggbHXYVk4r1/jmqGCRbDGitdhj2KxtOeZ8ccdPuPRqb/k03m24UqchpuEdI/FjXdaVVJXGl4OIgldIKACTCp+YhFWLd2oyBv7VBbsTCdDNGE6ZzCUWTjB4UZ83ijKikxFwNa8vvIRl3oyKPZ42s1N2SJNx8ZyOeHHPAHXKjwr/ejmJ248FXjkf9sKMIao4B37fBBjQA7o08hg59gkd5hutyIJIJDdm2kwWob0RSaqDtTa4URw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7mjHLU6Yvmnzok4wYU3L88pVKidK5O51T0kKh/nBRM=;
 b=YtprlpeuPtT4X8HTdcOzYxq0bUeUTiUz9XuMK3lbzLW9UBEhO8ITBtpouoDiGT5U+gxj3TVriqUmuM7RIpQO8lzgOfGeBjsQrYGi/lWh5I99br43IJcmwcGVcyIWOpraMKyopbvl5KFTOT44O1Vlz4jXZXzDiW6HUjHlE4DB/tw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB8030.namprd10.prod.outlook.com (2603:10b6:8:1f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 04:49:02 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 04:49:02 +0000
Date: Wed, 23 Jul 2025 05:48:58 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Nico Pache <npache@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
        Barry Song <baohua@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add missing mm_slot.h file THP section
Message-ID: <0712de1f-6a45-42de-ad3e-2522dd437737@lucifer.local>
References: <20250722171904.142306-1-lorenzo.stoakes@oracle.com>
 <CAA1CXcBY4rFLkNqJM2Dj-EajPw9TMTHNcYapw9P=U0bo=QNqkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA1CXcBY4rFLkNqJM2Dj-EajPw9TMTHNcYapw9P=U0bo=QNqkw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0639.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf51fe2-9cb7-4869-1264-08ddc9a43eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckFDamhpWktKeU9ndEIyRjM2Vy9JVXg0allVN09Vc2FhL3AxdHBHM0xJdTFD?=
 =?utf-8?B?VU5ZOW93M0NWTnkzY3Q5ZG85RUhiWm1xVnBNSDJxS2xKRWEvY2VmL3JtK3hI?=
 =?utf-8?B?VWJVRC9oT0FhZk9SVlBUeFZuRm9PNnVIdTY3bmhwQjF0Z0ZZOEdWWFVxUnZs?=
 =?utf-8?B?ajRzdGpKWnEwRjZ4L2JkeEJ5Q2hHRkVSNUhLejl0RUlMb1lKZVZPRXc2Y3Q1?=
 =?utf-8?B?cFJodHpKUUN6RU5KWUtrS3UwMWlYK3BBY3lpb094allEZXArWXl4VG0zYlB5?=
 =?utf-8?B?djdNZ1ppeW9yWlVIUU5hcjNKL25FZDZQK1dWRmZkZXBCY1VBbTBtS1dXUjZT?=
 =?utf-8?B?aElFbTA1Rmk2V0NPR3JIeXphQVRIZEdNZGZhN2djZk9TbnpSVlJFZWU3ODZr?=
 =?utf-8?B?UDlBaGtUOVFVdFkyallTaEx4UnFPSi94aHZqRWRZRDNYYlY0OXdUU2RSSHY1?=
 =?utf-8?B?ZVdqdXdUVERscU93WGlLMUwvOW1sRHpucGxMN0ZsOWZBYWp3MWoxZnVNTnRp?=
 =?utf-8?B?Qnl5c01reTlRMWhVczhaVGI3MHk2dUlac2VXcndmREd0anZzaGJIYnM3VTNm?=
 =?utf-8?B?QXFYeWZOOURCQ3BpY3c2eTFLa0xGR09DT1MxbVZxTTNqWDNlSU41WkVFUTJ4?=
 =?utf-8?B?UzloSTFLOVJRRWdMR0pYanVrRTlDTzVvZnFWRFhDY3pPRnZFNmExeHZaOVI5?=
 =?utf-8?B?cW5UWlZ5MVVGZDNzN09PYTNNaE9HU09DQ3NjODNYUDNONUM3bXlKU1JKWGtQ?=
 =?utf-8?B?WVEyazM3eHNZbzhySXZ6WndDOHRrUUM0Qk9iRkVPblFXZWJXWXQ1ZUtDditW?=
 =?utf-8?B?QkI1dnBDZnBSK2NNcE9SWTQ1QTNWNmNpM0Q5WEN1cnZYVGltaHd1bEdTSmZJ?=
 =?utf-8?B?MHJwVkNCcGtlNEZERUNndSsvZDIzTXFpN3RlSmQ2MHoxTGYxVkNxaGNlQ1Z1?=
 =?utf-8?B?ak16RmM0Z1BCM3h2Skl1Sk5oY0NzN2pkRDNzQTlkeExvWlArMVN4OHBzTmMy?=
 =?utf-8?B?bDNBNmNMV3ltdEt2M0I0dkdLUDhnM0loaGliMFVJU29wY1NoZjgzdFEvakM4?=
 =?utf-8?B?MFpWNHJ5TUJ3SzJsNnE5MDN5Nmg4a1dyRVVuUUNiWmFSRElWY3F0VW1nZDJr?=
 =?utf-8?B?Z0VxNWU5M1h3ZWFoamtSTWFweHUvVUd5K3BkQ0tZSk03OGxMamNJYlo0dyth?=
 =?utf-8?B?UHpoZkQxQitwZVRlNmlMeDdNc3M5SGJBVHNBQXdDSWlDeitaKzF1ZmdGNGhN?=
 =?utf-8?B?aHF0WEVGc05pK3MxTUI0OENSSUU3TFVLemxGdlNTSHVhS3lCR2d5b1Z1Vzl3?=
 =?utf-8?B?Q3NGZGVaaUhpRkk1WHRDNkZnbXoyZzBhSkZDVVNUVzB3VmNlT05STFB6Rkg4?=
 =?utf-8?B?aFFVNS9Ldm04WkNXVXF5SXpQd243a2lQUEVZVC9Ud2RsK2lQakdqMU01a0Jz?=
 =?utf-8?B?ZmNTUU00NzlEdFJJblFLL0hMNHFNL2xWR0J4RTY2cnJvUXhKbUljVkVQVGJL?=
 =?utf-8?B?bWdTRTM1NXVta2NvZ0RLcjZ2NVhVMDRxRHFCdmpKb3JNcy94b2RsVUhhWDM2?=
 =?utf-8?B?S29kaVBQRjAvY21oTkZld0JDVnJsMUR3Nm1aV0dYT2YyMFRtbzJ0OFZVbFZB?=
 =?utf-8?B?QmxlcmpJYWJwQ2U4TVhEUS9Sais4dGtRZ0p6SGZTTHhoWDEvYVlIbC9oRTF0?=
 =?utf-8?B?cWRCNFJkVTd4aUdCVW5vaHNxeEdQSDBTdUJBbWFleXlCTDJiSE51VzJsQXh4?=
 =?utf-8?B?ZU5SeEhrVytSNHlmekFYR2JETGpIR3gwUmFLeXdUbE5pV2lHdXJsK251TVJX?=
 =?utf-8?B?aDhNeXJaVkpFYnA2VVVQL0gwSkNieTgwQzdQN0d2WmlJZ1M2eHphaU0vclBF?=
 =?utf-8?B?d1VqR2kzOGZaNk1PYmNpT2U4UGpXRi9FWWdaamlOcUVkNFlNa1ZvVzJFZnVO?=
 =?utf-8?Q?BphSlB3A4YA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUNiV3RDOXZRYUVHbCtYZG1QWVRwMEVPRG9XY2JCL3d5Qk5KTzVtK0tyNlpq?=
 =?utf-8?B?RGVoMkJoYlJDa1NNaG5tSkI0VjZWMnV2VWErU21RL1Q2MVlPRGg2WWJLNTMy?=
 =?utf-8?B?a3o2cXZwR0NuTGJTSEpLbEVqWGRSa0YxWTI0WjR3WEdPRzEwRHNmVVVOdSti?=
 =?utf-8?B?bmZiZDBYSDA5ZVUydG10SktqQ1oxOXNWN1VzbzFVSCtkM3hTK2NhWUNyRkdp?=
 =?utf-8?B?NDNqZlYyVVptejRIMjJzN2piaWJKV21keUgxUDRFeXp3TXQ3V0pCRnhMZDg0?=
 =?utf-8?B?aEloOVdnWHFxUGJkei9UdjRiMGJNbnlQMFlBaThJKy9taDB1a1dVdjFkMWhk?=
 =?utf-8?B?YUg4VkhJT1BqN1RDZmZHSHJ5TVNFODhOVHhmcFRpMGhoK2pDNHdJcXdibCtT?=
 =?utf-8?B?UmNRb040OXdzYnUvQmxtbEprYlVuSHpjYmdSWWphb2k1Y21uMzFwSlJna2Y3?=
 =?utf-8?B?YmU2NDZQcXFqeG1VMnBmR0pETG1Mc0pheDl6Q0t3amlFRkRZRTBhUDJXai8w?=
 =?utf-8?B?VW9TWUhZUzk4Um8zbk9xLzlYUTBZcHNFeUtzNHVFeFkyVVpUcit3RFFZd2ZJ?=
 =?utf-8?B?QU5VaWJDZXZCekgrOVYzclFaM2hsNDRsSGZsL2dHeDVJbzQvSWx6cUxYbXZT?=
 =?utf-8?B?K0hGV0Vld0c0T0llaDFnTXF4d0R2VGgxWVkzeThPWlZZRzFuRkJwYnlVOENC?=
 =?utf-8?B?S0hSZm8rMFUvSUVCa3lZc0tsTjJYM21qdTZCd3pESi9keUNKZVoyS1ZQRnVm?=
 =?utf-8?B?THVLN2R6MDVrWm5kT2cvYk1zMmZSR2xvNDYxeXptd0tsQUltQUJ2OUE5YlBu?=
 =?utf-8?B?aFNjdU85ZXVkTGROQm80TndocDhLMlNUUjFjd1VVVlRXMWZYQ1ZiWnYxelJR?=
 =?utf-8?B?KzNVQWpLK3NKdllmTG4ybDRlMHo4UEFTaUZ1ZEJZWGQ1Ky9VM1hSVU9vSS9N?=
 =?utf-8?B?Wk43N2RwYk16eGNGeXFxTEVReHBwMTJPazFhOXVDeVJpOFZsNmdHYXlyb2Va?=
 =?utf-8?B?MGRtdE5JMHBLMGhLWnIwbWp4cHREZ2FZRjdrSUpDMXVWZ2pSQzBYTjM1WjFX?=
 =?utf-8?B?ZlFvaStmeUtoWTFEZ1FuVnZzTDF1U1pTbStrVVdmT3ZvWFprc1hXLzVCZWky?=
 =?utf-8?B?eVRlQ2hCbEE3Q0pieUx6MVNTeFc2T2dJSjVDcDZTRlYyb3NhOVNENk1nMy8z?=
 =?utf-8?B?azFvWDFoWURaVjVrK1dDaGpTN1V3NnFYMDFBQSthUjBFeE9RWFdmR3VWOHBO?=
 =?utf-8?B?YkYyMTlrbkpqZUIrMXMxWUc0QTRRUnNuTm9aNm9XV2h1MHN3c29LOVl3YUdZ?=
 =?utf-8?B?TkNsY21sdFJUMjRuSWp3VUZMLzArcDg5TEZLaU9MMHV3ZjhLWVV0OWNNQzNu?=
 =?utf-8?B?VE5CVmtGRER6MUc1b1VxSllvWFArR3FXbGIyNVZxazJ1US9vMUhOTktZQWQw?=
 =?utf-8?B?Nm9rS2x0QVBFSHM2NmV3WkdYL1VEUlhiTnJWeU5hQng5aXR4N0kyR0Z5b3dv?=
 =?utf-8?B?Mis2S2F4RzgrUnRFeDJzdHdTSmR0Nmw0N0Zrbi92eVl5VEJMWjU1ekR5aWtu?=
 =?utf-8?B?ejhnV1UvTk5GRHlIT2tMZk5PczdqNkVPc2crNXpmdmVidEM0Vm1Cdy9QaUJv?=
 =?utf-8?B?Um9DeUF2K2FqSHpyN244djdWLzYxTk95cE40Zy9Xc1RSbkk3dktOSzR6UHdP?=
 =?utf-8?B?cmlKR3BJc2JRREFmbWxxWTVCcFN3YS9neFZDM0czVXk2cndxVENiTFhvdnRn?=
 =?utf-8?B?Vk0rMVBGTFBrMFV6SVlGNUQyS3licXhreXJ2WlY4M2FUZXM2eVZZZzJsZ1Fo?=
 =?utf-8?B?YmdYRWxnTXA2Wko2TEhVTWtjZW5QMittcUxzZ0U4dVBEazR6Q2JtZ1NjWjBm?=
 =?utf-8?B?QUIzcWFrZHZ2YUFyeEEyVXpKMVg4ZHlQZUxXNU5PR0V3cGhDbk5pKzAzcS96?=
 =?utf-8?B?TVR1ZjFaclVBazYzQlZpSFNPbHU2eHRpT2haakRDQkJ5SVVKdi9jSXFxTmxx?=
 =?utf-8?B?dktsSU0wQ3FMYndrWi9ITVFHQS9rL1J5K1ZVV2pUVDgwTmN0NnZuTWtxb08r?=
 =?utf-8?B?NGk1YzNqeU51aE9QVXBRYlBLV1NCbmtyVGppUGo3RWZ5dWVHQUpVVks0d2py?=
 =?utf-8?B?Tk81Y1ova1BJd1lFNW90Y28rRndhU2JBQWJRQUFqckxnNnhxcEVDWkhBcklG?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l+ca7KrtPPQ5ErJYTTYrIRpoXv74JlWyxiOw/6EYW6I18y5x/gi/7w3hY1PcgNaDkvrCwYNuARtuJcXAOombxqaSMFY4Q7YyfGzGoarArPwsz7cLxOHtv1Uu8TsAyG9EKJ75/fP5tOdF+0WBmIkFjCS0AcMi1Jp1IN2FgW0Rmn75facKrJE6SQAxP7UuJ37gWxQ7kbnr5iQeaESPT1GDxHYNYI0LGW4Xb1glfqZ3YgldyA128SDJm8nmvBKla41XMjye/pE4evDa0L+VYYqXI2U+KRdanPg2vva3yF8kjuEA3y/XMNoJMjZ/LoS+GsE4ts/kDYmeH0f7hLtd7Qx+URmMef7fvLmqaiMAOueXErxxBu0u4cpyYgOCtIPYEtAfbvrkdLL/CzEjbTqGaKBwF1gKQCBL9gyENJlv8tDqUEI8W2m37WbzyOY3zfxJtf0wPlDYCSBMlGIPP9I2ansKMTNhPpuT14+eyi+B+9cayyjvkKBafgRUpeT2zhItpxjiiW8KDdWcUf7SP1NAHq6ZXK68NbwI9Q2OWie/wtn482Faik+qZiezKsQwx3fzbGeEUvsiRN9uZKXnDT3duIYKdRaQPUvjPymH1pKSH/92eUA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf51fe2-9cb7-4869-1264-08ddc9a43eea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 04:49:02.4395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zVqsq8cYUyDKMsv+QsyFtjiR59T3d6tRFzkc4T/X2jahp7QGzlEh8TOP3eYPxLdwIB2kR7ekeT+hOXZqbgXAAHBvhaDrmZDlYmqdNYuJEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8030
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507230038
X-Proofpoint-GUID: m4rfa3SoE-NLWgogg_sKsiC0L08LCdJV
X-Proofpoint-ORIG-GUID: m4rfa3SoE-NLWgogg_sKsiC0L08LCdJV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDAzNyBTYWx0ZWRfX5d2gbxLtB83p
 xcrV3GGPyYpoGdKWd1ruCQWpzmRZL+wRvIfFZ3GgWdYOGIuh0ulcds6D1CX66sMzzP9Xb1Cc0QB
 7T8fe1Juwc3yB64BVgn4yA939cFYVT3613Ln2C73g0w9Ooj+CfEuQVvJUlCOdfsYphS15zbJwbF
 0LabjEcJ2N2vTen4pMjUgXMBforwKn7CTSnQi/UmF8u0ZO+PCuXjXJVGZu+rfDn6Dqa4p2IH8FW
 K/7223na/ygjM/cdHDX1QcgVuDQ7/rZwWgYhhcIvQrV/MYt1+x7D2tfEhESQ2Yel/Ck8eSz2swf
 tqp607JtObGMsHfyo+v1NZd21lqE2lOKNI0eb4iGv8g0PiW4rmzh51fQsNbcMiwu5DcmIzb5vWK
 A19XTKBMz1/doZjLF0ZXhonRmlAvFvRR+vN55x81cISbHA15d6iT9VmctGfYhEluus2WrUh6
X-Authority-Analysis: v=2.4 cv=IPoCChvG c=1 sm=1 tr=0 ts=688069c1 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=LsFlvV74n0Hn42QnFawA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10

On Tue, Jul 22, 2025 at 11:43:04AM -0600, Nico Pache wrote:
> On Tue, Jul 22, 2025 at 11:19 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > This seems to be the most appropriate place for this file.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 837bc5cd6166..3f83fb317f51 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15966,6 +15966,7 @@ F:      include/linux/khugepaged.h
> >  F:     include/trace/events/huge_memory.h
> >  F:     mm/huge_memory.c
> >  F:     mm/khugepaged.c
> > +F:     mm/mm_slot.h
> >  F:     tools/testing/selftests/mm/khugepaged.c
> >  F:     tools/testing/selftests/mm/split_huge_page_test.c
> >  F:     tools/testing/selftests/mm/transhuge-stress.c
> > --
> > 2.50.1
> It might also be worth adding it to the KSM section since both of them
> utilize it.

Good idea, will send a fix-patch to do so!

>
> Acked-by: Nico Pache <npache@redhat.com>

Thanks!

