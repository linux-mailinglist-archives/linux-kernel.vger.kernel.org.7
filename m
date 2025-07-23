Return-Path: <linux-kernel+bounces-742170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3024B0EE3F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF04F568193
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7621285070;
	Wed, 23 Jul 2025 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a7UVJVo9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kAWhREVW"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15BF1E2834;
	Wed, 23 Jul 2025 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753262420; cv=fail; b=V+9r1pGJAVl8R+6E0xXebm0Ojce9C92heHD/btXN4xFu3bRT0VnbVcpmffVjhHlWXX8c6oXYGHVe4u7fv4hrsb+VLMU1guG+asLkLgohoei/fMqNkJnsa6jm5qBApNbJEi+h6cgCIVLIjDwqzGF1+ENXHJvIVllqxmcfSxotA44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753262420; c=relaxed/simple;
	bh=bUQTesde3xb2Ve66px5QUmg1a84qQJW7S5KkBTmv99E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OncAUvNKo4LxSrEhVuRfCZserP6l1VJiSo0cPNyid0efik4qicMz138y8idIQrt801QQpJo09T6/45T/Ql7XOC2bsXe8rnqI3UZJ38WKkYVZCUijg7MfwrDBOhFLJehBNwxtf1E9vgJrgOC/CAmlW2d5CBtMxpST0LpIY9P+xcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a7UVJVo9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kAWhREVW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N8Mri2023820;
	Wed, 23 Jul 2025 09:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=r7rpJn5As2nISDTDD9L5cvqjPRt7jWcldPzD4Iwaig0=; b=
	a7UVJVo9T07ygBCkJ57nIRlYCItJlJNpMtdj2KyYgesMwHbr1P3VQPXuSDJ+sEZI
	MnYwbNshqsIt1T46bKxtf/BijaeQtMrZE7p7SVBSpKldHcVrMOTRSvvXjU9083KC
	cLzw4KK7hpw3DsPcvo9VSfeNYvC8vwlGyEbZFVeReuBxwAuQ5Gz62kOOp7YqTf8g
	5XotRbHc6RAQRNxi7whbBp70yosQ80P3Jqvs7wSrrKagaiXD45AtlG9RTAXp/9C1
	pK2Ua+H+BXGS/wlVGrW8cSVKTQCjQHhoFoTE1jizVweSSJwpRWaO6Mog5tJ6SAhP
	5bARkVHcUEmxOam2ntfnrA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e2f3tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 09:20:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56N7oL7O037748;
	Wed, 23 Jul 2025 09:20:00 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tacywf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 09:20:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yjv6CVEGfkYpc1o5WHNUPr24GZt40x4bbDX3eanKzXE7fmq0dKzkQ88cOGkFBACOla+gkeY+EA1m5jx9nD1Uzi6tw6gaJO7hD4NT6XY+V248g6lRB6bPSB1t+lNZ1od5+tPtkehLNnnEEk+p/BOooKEuM0S3r8fahu3VEbX3s8c8srsb/6ucEd1ts4AIWIE8kK/JPNK17dOfrIVuxxIJ7hejgHi3u5IO9NW+N9s+fISn31xxKV3gx3MUvoLvFKoyPVRIxXC6di105OpNY0zk6rqDXcImi/+AWs3+XJzGS/YXAVkun1wDho8S0M/nKv59WNkXy7M4t2bEKBJIVFX/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7rpJn5As2nISDTDD9L5cvqjPRt7jWcldPzD4Iwaig0=;
 b=ixw+ik8WZDVjNpzuhLB+fgayuba9CQGRQA1jN3MdYXNE7TogCIU8ZqR9iGkHOOUicjkhgCQwfakeGVAyrswK+vtcrgk83mYJY+JPuiBJRTrBKioyjLRS1HKnUMQCYac2tUMXBFK8jtPUCqXSPBdjbFPcv73sTXHIZ9f0ircMUPlAQMvZ4ik/2YBsDhXNhqb6BCGyd6dOK1e0fu/raN7OQ+/r28CJSlOnF2Qpa7ox02syyzI0TDgvrcKVFcgIcv08lnOS8XN6y3tzmyLPoFu8vtBfYyie2dbjUXpOGFXZYSS1COEp7ZqldG+LXLkcrPQ6WpotkA36HFZnFvY9lJLnPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7rpJn5As2nISDTDD9L5cvqjPRt7jWcldPzD4Iwaig0=;
 b=kAWhREVWgQG/hn7AMVu3+0UfHl3HEGggCI/x7kLvlT2mWo1fxP7DfRgbU+7GqBGwqMzmGdu6Z4VVAd+Yz/ykTwlVKbG+vYkWIGdfQ+AQ0gIS3FymufFDfapaOhHDglukhtryjA4xx+ws1Hq3lRd+a2EAR32xheqgd7n5Zp5S4W8=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ2PR10MB7109.namprd10.prod.outlook.com (2603:10b6:a03:4cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 09:19:57 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 09:19:57 +0000
Date: Wed, 23 Jul 2025 18:19:45 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: kent.overstreet@linux.dev, rientjes@google.com, vbabka@suse.cz,
        cl@gentwo.org, roman.gushchin@linux.dev, surenb@google.com,
        pasha.tatashin@soleen.com, akpm@linux-foundation.org, corbet@lwn.net,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_tingweiz@quicinc.com
Subject: Re: [PATCH 1/1] mm: slub: Introduce one knob to control the track of
 slub object
Message-ID: <aICpMWKNvhveAzth@hyeyoo>
References: <20250723080328.4012263-1-quic_zhenhuah@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250723080328.4012263-1-quic_zhenhuah@quicinc.com>
X-ClientProxiedBy: SEWP216CA0086.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bf::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ2PR10MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 35d0e299-2d36-4d88-62eb-08ddc9ca178c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THZPUnIvWXpJc2tXUHpmbmFpalZ3WGxLYlkwRjZOeG03bEh5MlROZ0RqQXhF?=
 =?utf-8?B?d0V2RVE3bkh6ZU5KMkYzcU5RNTdsSEI5SkY4OHhZbk85Tit1aEVlQ1krcmxF?=
 =?utf-8?B?cG1WSGRFWnVGbkltVWdXK21nY2ZYU3BjaVJhNC9Qd1ExTDhmdk8zb2VJR3lJ?=
 =?utf-8?B?UHFDQ0FPU3VTaUN4R2ZaQkNwck9HVStabGhqN0crNGZSUDJWaTR1MTkyNWU4?=
 =?utf-8?B?d01RZmh6YzRGVEowVnZrM1lpR1BHMFlPS3duaFBSdTNOeG4vNkE5U3NDRld6?=
 =?utf-8?B?THJwN2VaUGxCSnRUSndmd1JMM0RmMXpReUI0VURDcHZBSmt5eTZ3c0p5MHlS?=
 =?utf-8?B?SVp4eGZvWEphdUVJZWt4MVdmbFhXMFlySW9mcnk2L2hjUkc3Uk1HSDJZendy?=
 =?utf-8?B?QmlTa0tjRlRqam50Sytvc1BnTjdzdnhGUTZ2eXFKRGZHaGhONXg3T2VkeVh0?=
 =?utf-8?B?dm1Vd2FJZlNnQnBscHdYeWJBVlFHelBlODVuMXhvdHpCSkt3d0l6VC9GZklR?=
 =?utf-8?B?a0ZnclZ5c3BCK2YvWUY3cnd4ekNCZnEyZnUzN1VUYm1MZ3B4b2NpRHBmVmRv?=
 =?utf-8?B?VTNxT3BTU2JOR1dGV0ZGVHdYZmZqUkQyMGd2aW96WUtCM01HSFNINTdrNVRI?=
 =?utf-8?B?eW5iM2lkVkY0NVVJbkpzVWZubUJMUEdibXdpTHJFN1owVU5iWUhML0NvV2RK?=
 =?utf-8?B?b0RMZzYzYmlNR0R6ZWhZMXNJL0Y2S3RxMjl5aDBFV1dpMlpxbnBOdWpGL2xu?=
 =?utf-8?B?MURNMFZkTFlDVUxSL1ZvMEt0dUE3WlZjeVBXcWRzYjBYdU8xakt5Rllmc0gz?=
 =?utf-8?B?SitrRzZqa01PM0oxSXRiVGhzNU0wa3dlNUx3elQzVERqRGtud0JwcGxoN2pM?=
 =?utf-8?B?aytSVUxKQ1NjcmtLU0l3UXZXR1lCWDBabVhBbjFNTnBwNGtHVEVvMWpDdjFv?=
 =?utf-8?B?U0xPeWo3YU95UG9hcFQ5c1hVOHhLWlJrVDZOMkF6d01PZFVrVXhmQnpkRlBH?=
 =?utf-8?B?Zm1ua2VraC9ZdFcxeDBMUTJ2TnJGbjEwYzlpS0prOW1YTWtucmlKT1ZFQU1t?=
 =?utf-8?B?RjlhYW13d2U3OTUzSWNJWmQwbjhCc3h6aFZ1TThwTmQ2WTZwMEdwczk3ZVMx?=
 =?utf-8?B?NlhhbGFFOG1XOXRERUd5VXQzT3BZNHJQckptbEdLRVlENHhKVWJqNTRWemxR?=
 =?utf-8?B?SHlMd3NNVjY0S1BHYnd6d25FYms4NzdPM1VvckhzRCtTSWV5TjhMQkwwbm9U?=
 =?utf-8?B?RElqOEhNUmVjblpNMHp3Wlg0azkwdlBUU04raXFSSVl4ZEFNNzlvcHBMMjBv?=
 =?utf-8?B?TzBPemFPcVJORldyL3MyMGNOVHoycHdQNzVvajZsajhSVHFkYU45emxUUjZk?=
 =?utf-8?B?cEVpOXhzOVdsT0pkdFNyVEVnUjNNOEYxZTZZUnFvUEkzMmN5NnUrL08xNUhy?=
 =?utf-8?B?NmhpVnpXekpIS2JXSzVlMjNSQ3dscDdmUG9VTE1Yaks5Sy9jL1p3RERXaElz?=
 =?utf-8?B?cUZMZEJPd3Y3Tk1Vd1JnRkVaZ2ptUjNjcTFZV0VWRHFZeU5iWGJzY3JodXd5?=
 =?utf-8?B?ei9lZ2NqSWJIdHNhR3JyNWF0VmNTeXU5Vk02OHhNWmpyMWQrWUFHaVVQVHVP?=
 =?utf-8?B?UWlwREVzdDdlVmx0QWNVdWdGSzNVaXhPTGR6bmxhN3hPOVUzSEppWVd3d3hI?=
 =?utf-8?B?dGJ4ZTRUZVZNNEFGaGVNUzE0NWJNYjIzZ1lDakJubGN5a2oxc2w2Rk0vY1Nh?=
 =?utf-8?B?Qm1iS0xBZFNKME1QVHo3TWRiVmFQZTQzVTgvQlA4YzhkUTRma0hWLytwYXND?=
 =?utf-8?B?L094bmtSd2k4ZFVTVWZrYnlVNEJrSzh6VkxlRW5XVGlwdk5nNzBFcUVQZzlJ?=
 =?utf-8?B?RVFENXFjZVg4R3FpYm5kME1GUXU5ZUZ5UjJRdmYxQWtaSFovbkw4cTI5RzZY?=
 =?utf-8?Q?in7e+THTniY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2NtV3BycHFjSW80bGNVZmUwZkhiandsdXcwazdwYXVIdVRVY0FCcnQ2QTRp?=
 =?utf-8?B?ZnNlaVU2Q0RaZHJ0T05kcWN2T1gwcGlhblVDb3FIOGpCTEozV3pTQ21xL2tI?=
 =?utf-8?B?dzV5dEw1RmsxblRrM09mL3VyV0FRQ3c3bXBtdlZGZTNNdUtxS0R3Q3hhZ1hu?=
 =?utf-8?B?cFhHZ2RaVWcvOUs2ZVNEVDQ4MnFuckpRQnNTVktYeEQ2NFhOQURhZDhXUys3?=
 =?utf-8?B?eHZYM3ZOUDZhSmhlcDd3WWR1K2NOYkg3WlBobVpzWjVPTFJVdVBrQ2VQTk05?=
 =?utf-8?B?Wk00T3FnajFRY212UE9hMU5Hb09FTFc2aTR5cWNPZkQ5USt4dGpmM2dVenZO?=
 =?utf-8?B?Rktpb3QxTm0xa1EvZVB2aHp5dFZYZ21iMGRRT3pkeVNSbE15c25qWnAwdDhq?=
 =?utf-8?B?RXhDWWJ6blBhVzM1Z0xjaDFLKzl1YW50eU42M05wNEFjVWNXN3VSWFhrY3NH?=
 =?utf-8?B?MmpsYlQ4V2orbllyQUE2ZnhtclNjUER4U0owMWhONEFCek5lbDMwUkpHTXYr?=
 =?utf-8?B?YUdIT2k4Qkhqd2hSLzBIa0M5UENGZXNqVTBBbGtvNjBlY3g5Z1FCVzlmVVZx?=
 =?utf-8?B?WW5ja05lYTJTdmlyZVhBcVhRbmJ5czRVN25pSFRoeU9TUmU4VVZ5UG9UaGsx?=
 =?utf-8?B?TkdweEdIZlY3bnRDdFNJNDlPSGJWMUt1elZjcWozb1lLWWgrKzJFZ29LcUtP?=
 =?utf-8?B?WmFzaWVpb1lxQnF5bjNvbkZlcVJTa2YzMmdMYjBzQ3JvdTNCUFhVaU5nd1N6?=
 =?utf-8?B?NGZHdGUxNWw1U3dPZTM1akdUc3d2Ym01Z1NPWStSU2IvOHE3VXJDM2hOdURn?=
 =?utf-8?B?MlNMZEZqRHRzV1I2Q0JibE9sdmtEdVlTREhuVUhpYStSRDJHZk5aS0lCVC8r?=
 =?utf-8?B?eENnaFRwaUI0MEM1Q0hhUTYvV2I4TVZLYzF2a1B4S0QrS1dETzRKMjNhR2tl?=
 =?utf-8?B?azRUWE9aamQ1RXV5azlkdEkrNWZpemMwQ2RlWjVjN1IxcmZ5VVZlK2c5SW1Y?=
 =?utf-8?B?blVyZ2VLd2FQN1VFQm1sMkltNGhCY0RrKzFhVWhJWm8wR3hzVkNQdndsM0RS?=
 =?utf-8?B?dmMrUG5ZWm90Q1kyU2N0RFhKdkFGZGZwaENQWmoyNnBhbEVMbDRXdS84SVlr?=
 =?utf-8?B?UUlvMUVmZmVXZjFPTGFtUHg4dlJaSjdxWndtSlhQeFlZSnFYUWhsSWltMWV1?=
 =?utf-8?B?VzJqVEdrcitMaWhRbFV3alNwK2NLVWVZVURBQ1A3OUFzb2toSjRWSGk0REFm?=
 =?utf-8?B?M3dpRXhQbDFMSEQ4a1hXeFZnbVhVMG1WemFpMFZxeWQ3eGtZZ3NBbytHL1NQ?=
 =?utf-8?B?L095c1hSTUVnYXBVUW1aRHk1SnRjMkJZd0c5eDIxbHpsRjI4L1FTN0hyaWxk?=
 =?utf-8?B?emxKQU84ckJpOVp1MllBa0k5VExTcW11b1FaZng3UDJZSUpXZFUvL25zYVRa?=
 =?utf-8?B?VVNpazRwTnJWMFlkbXMrcGE2TFZaam51cDN1OFNtMjd1WXI2UDNRUXpjazZE?=
 =?utf-8?B?ZnFZSmZObHpNNWRqZUFhMVRCcjV6NUg0MFZwUisyTDdpZjZZbm5DdlNxZm5M?=
 =?utf-8?B?dzUxRTF4MGNYT2ZpRFFKWFdwdHlHUVNDMFBDZCsxMU10YzBNTDBwbG1SVk8x?=
 =?utf-8?B?dXdjbFdJR2QvakN4MDl4Q3JxdGtDalF2Sk5WT0FOcE45ejVkUGpPN0NRd3hU?=
 =?utf-8?B?OGEzeHZMVGVtR29PSExBRTNLRDlaRDlvZmhtNmhYT0s1OUt6akJjaU5JbEN4?=
 =?utf-8?B?OHdpcndsRkZvM0Yzb1hjM3ZKUzZ1TTlHR0JPR2sySGYvWUpxVmxQSEpET0RW?=
 =?utf-8?B?QzlWUHc0MHNyQVNDV1JrZ0M5MmlZNk1qRlFpM3RYeFNINTkwQnVxRnVFZ3kr?=
 =?utf-8?B?MFBEdktsSnNnNFFMRm1MMks4V0NQK1VBL09zUTByNmtPUkVHeW8xWVUrbGVE?=
 =?utf-8?B?S2VleWh1MzRZKzRUaW1DV1BoTy9CS05RRm42MEtOaDZzcHVKcmszc2JqS1Fp?=
 =?utf-8?B?bThIMTdRR3lUVWlJcTV0VWZQZGxuWE1MTll0K0pwTFgwVlJSZW1mZE5pNzhm?=
 =?utf-8?B?cnZIbXNhbm9QUmpTQ3VLQ2JTUmJtZ2cvSGF0NU15UlBCeXArd2RtS2xpQkFG?=
 =?utf-8?Q?QJhvXeoju6Ibtq5OW8xMP/gKC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IJMD/KkQiukpx0MW7WptvP9DHxJMrkS280aaKUaQOFsuFbjoriul5lQHFsOXFCAoMfGdpvQ7ICbBvBwv3cvXiZTOlyYrfZxVBUWq51npW/MUE8MZlyDLZb4d6NjpPtTwMsTHjfe0Z0Lzh3P7AM2ulYQ8z6HO4YMAOZNcmgm3lv3zTvoWUw3K2Rdzt/QdEy2fvCQ9VaqZdP0XVRbWGKKZHV+xFVb5HBtmNlI8edeJJFyqlJNYGnXeJcssL88DzQLsKJliIuDFPJ2tKOpkOBFk0cnKvLZvWrQjrAcnSDnyqRKkDTiicVI9K6JP20c/U/mXduLleTWaxzgnZdu2it1XsmTkSeiNgWidar5hM6vF65Dita+cyu6V9mkd5YJrwept1MMOaet3gSbS9v6FDnRErtD9GApGzwdCrQ5Ylvl+n7tDkfEaXEOf0UaVSeON1C/okAWUblSrFwxf1oRkBJ+5R0dwLM+YhukZaD6b6Z4EkCLs5Nh/ckcfb/D5syIuY/5KIr8Jikjan9tiLspnVctRFnnY7uLMts9IeaGPtF2wGeP2y+FstoWM/VavFDkAyi9DlCZP9RGItDThyMLbziZ926prUAiwF6hUCPSSgbL8wM8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d0e299-2d36-4d88-62eb-08ddc9ca178c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 09:19:57.4669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uV33JOkdyYD1n76kca1n4OHH5XZRGNXA3zjL05W3BbwzVztMPSnURq7xOx3ZRTyMDNPyl1L2ylBAfPWsxeWr2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7109
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507230078
X-Authority-Analysis: v=2.4 cv=WaYMa1hX c=1 sm=1 tr=0 ts=6880a945 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=COk6AnOGAAAA:8 a=15wHjfbXKsZ9-jLX-E8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22 cc=ntf awl=host:12062
X-Proofpoint-GUID: flHSTAwE72Y7wlZEMUNszv5iplmSupLF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA3OCBTYWx0ZWRfXx52cWeRy0Oug
 LkEtx6ZbXld3WpNTbamEouIVUpFBF2puacRyBVE9w5lc4uaPX6UIcod2JvlT851ROoJZnMlJzix
 g3UqkYEgolf0T9KU+c63YzJmh4MF07onxs+BE0MohR9kSDwImHRvOSSJT9uePW/sjF/vjbtJVLS
 fRsFDFQQHDwtYEGOrx03nMjf1u+kIPJbn9IHxmhAnHiFgd6tPnKGm2eVXr5YeWHJGw01SYekIoo
 kyrAwK+f6lZ7v7Qz1pXhyIDYwzLMNRsNDCMoOcyF9XRs3H/SepoYiIleavZzHLso7rjwhOF9iTI
 CPxooTSoMimNAjiLd0yZmwK2Z0c64kUvWXoapt+6XfhGmbRMiZ/Tq5Srgzek2f5J+3JMMq7Kcy7
 3VqrxXel+nxBVPPNMd7avWEJxE5KHXXuJ32bgGPx4YGY5O+0qYbLEp6yNTnkyQ+BCPgmfgEt
X-Proofpoint-ORIG-GUID: flHSTAwE72Y7wlZEMUNszv5iplmSupLF

The subject is a bit misleading. I think it should be something like
"alloc_tag: add an option to disable slab object accounting".

On Wed, Jul 23, 2025 at 04:03:28PM +0800, Zhenhua Huang wrote:
> Mem profiling feature tracks both "alloc_slab_page"(page level) and slub
> object level allocations. To track object level allocations,
> slabobj_ext consumes 16 bytes per object for profiling slub object if
> CONFIG_MEMCG is set.
> Based on the data I've collected, this overhead accounts for approximately
> 5.7% of slub memory usage — a considerable cost.
> w/ noslub  slub_debug=-
> Slab:              87520 kB
> w/o noslub slub_debug=-
> Slab:              92812 kB

Yes, the cost is not small and I hate that we have to pay 16 bytes of
memory overhead for each slab object when both memcg and memory profiling
are enabled.

> While In some scenarios, we may choose not to delve into SLUB allocation
> details if initial triage indicates that SLUB memory usage is within
> acceptable limits. To support this, a control knob is introduced to enable
> or disable SLUB object tracking.

But what if slab memory usage is not within acceptable limit,
reboot without noslub and profile it again?

You should expect to sacrifice some performance and memory by enabling
memory allocation profiling. I'm not sure if it's worth optimizing it
at the cost of disabling slab accounting entirely.

Anyway, that's my opinion - the memory allocation profiling
maintainers might say something different.

> The "noslub" knob disables SLUB tracking, preventing further allocation of
> slabobj_ext structures.

nit: "noslub" is not a good name because slub is an implementation
of slab allocator. For the same reason "slub_debug" is deprecated and
"slab_debug" is recommended instead. Maybe "noslab"?

> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> ---
>  Documentation/mm/allocation-profiling.rst |  7 +++++-
>  include/linux/alloc_tag.h                 |  8 +++++++
>  lib/alloc_tag.c                           | 26 +++++++++++++++++------
>  mm/slub.c                                 | 10 ++++-----
>  4 files changed, 38 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/mm/allocation-profiling.rst b/Documentation/mm/allocation-profiling.rst
> index 316311240e6a..9ecae74e0365 100644
> --- a/Documentation/mm/allocation-profiling.rst
> +++ b/Documentation/mm/allocation-profiling.rst
> @@ -18,7 +18,7 @@ kconfig options:
>    missing annotation
>  
>  Boot parameter:
> -  sysctl.vm.mem_profiling={0|1|never}[,compressed]
> +  sysctl.vm.mem_profiling={0|1|never}[,compressed][,noslub]
>  
>    When set to "never", memory allocation profiling overhead is minimized and it
>    cannot be enabled at runtime (sysctl becomes read-only).
> @@ -30,6 +30,11 @@ Boot parameter:
>    If compression fails, a warning is issued and memory allocation profiling gets
>    disabled.
>  
> +  The optional noslub parameter disables tracking of individual SLUB objects. This
> +  approach, similar to how page owner tracking works, relies on slub_debug for SLUB
> +  object insights instead. While this reduces memory overhead, it also limits the
> +  ability to observe detailed SLUB allocation behavior.

I think you don't really want to use slab_debug to account slab memory
if you care about performance & memory overhead.

>  sysctl:
>    /proc/sys/vm/mem_profiling
>  

-- 
Cheers,
Harry / Hyeonggon

