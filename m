Return-Path: <linux-kernel+bounces-821379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BD4B81198
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88EA1588234
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0DC2FB635;
	Wed, 17 Sep 2025 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rJ3l21UP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pPaAAtQA"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDE02FB0A6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758128556; cv=fail; b=J1741L4jWpIngN2cGR0ecUAKf09jpvcul+r6o7znU/y74/ljgWHGLjvYxvtaY0OWNVchVz3BOa+8WbrbeTgsLgfxTgmcGN6o+InYyT0gVA1bnqja2GLBV1dzNrz+PbZCF2vNADCxbC8aZvh5oy0Vj9zG0qpl0crxubPJNrgTpZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758128556; c=relaxed/simple;
	bh=MrYPHUws50BiIPH+s27b54X2BIcwjrYkKFFOf0hsq1c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aGvJ6/Ius5W69DfppLHgOLA08EJMqVThLcCVNvHCLVagMvR/d4qTlThQ9G30cmM+zrJsyLCbNGfHFKkmlEDUof0Uc9Jr812ljZ7qxdG6EB38oXf+VJIN33A+RR0w5pbcoaLF+hyfWWxS6dxks/lPTiy6GXNz9lrM+HuEKat8P6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rJ3l21UP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pPaAAtQA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEIRXX001776;
	Wed, 17 Sep 2025 17:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=K/fdxGRdEj4lcNrFvm+iAvQrWFUxXF8E4szMpw/b9fg=; b=
	rJ3l21UPifRzUxDOzZ6VtYbLYqz7l09wNsd11bMgxUK5vfCkio1yG35wqdGT+Ekp
	pHAtkF+ZS83oWyLnD5EIEpLLS0HLlZmzUa/wzEWBMIgSdRGKQ+0fBt2hgAT9U66w
	aIdfHqQRlelnzq2pJtDpXjjLdYHjCFGmwZ27Pi9EwNNIdDN/Wcy5iiyinZDWCDWS
	CNFD2/xmb5IH0ipqLVG+FGu/XiRhjgsW15phqzdaQuqWfyRzP9ftjBMY7vZSbDO9
	E6qmQupLx4AHhIyxJ7Xnb28Y3QUxbGkMriVpLvxeGKFLYhOSeLsNbckQRFWROWff
	NLGz1VKpbrcxd+eFAFN6gg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxd1rbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 17:02:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HFR4Ds001510;
	Wed, 17 Sep 2025 17:02:11 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010070.outbound.protection.outlook.com [52.101.193.70])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2e98uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 17:02:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkCAPnYz8hGaKww72RfWSGDFiEI41vfnlolXtHQzz4bWJAcp/m3vPL+vULS39iBcaRX8Nl1PBOkp17PLqdM+TOdpW3QNoYQ0GXWJylfzXxSWNceQVDQ84u99xz2eYxJ/Ajc738VzL/RaWrXsw8juiE0KvgupCAugpzGcFuxxeB6q3xpGIAoiYn8bNK/HSml5Hbt94dYshGspha6yzrGjqvFfqu7iAPLXGVpVUQ6T/I38Md9dlesJg34bfVgTe0fTXGbsD8I7k1Wp/BLyrGgvEhNAu5hLTytyEOjSgL8HhzEJJFHcBBKLvLM20FD741BC9DmrhvjMI13PsmzWkFJK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/fdxGRdEj4lcNrFvm+iAvQrWFUxXF8E4szMpw/b9fg=;
 b=q4kH6SihX9GAr+VIsMQGBWtpb6NtLStg3ofiKSMwMeDz2akAkVas9Oals04Zj2hUoHJ9wS0e1+H1NHr609RQZQD9+UFjkebFZhfju62j1ILZriRIsuCliG+oMtsk0iLCvcprrU4aDhPtghHAzI8O/5YnnUecmSmqyFN/+T/KgDbTFZ8W+81TZlZIs19wN54cjJHmA9kOD6m9oyEWbtW23j3enKs+6T4y0a5s9GQgbH9l+NWZsRVigotekf3MFKcoGDumgP3fjWIMDudNgsAewe6KNPcNf5MS4X5zY1QFAgGCfKcfBnVU9Yt67dswMxqtnKxUtkpajuh1ASEfV2feig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/fdxGRdEj4lcNrFvm+iAvQrWFUxXF8E4szMpw/b9fg=;
 b=pPaAAtQAW7NKlGu2O2m0pC5f3lapOqrH5olsRbtUnjFIwQiHGiT5XU2u38P1deQ5kyrVT6Em06RrYGoFT6DKnRgFmDOMliUjS+dGLT7um5t7ijREQ8GPCOPQPhv2tHnQsmrXugucNYEm5VlswtLmVgVioJSokpDT3O1wcyeAMSA=
Received: from DM3PPF35CFB4DBF.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c1d) by BL3PR10MB6091.namprd10.prod.outlook.com
 (2603:10b6:208:3b7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 17:00:22 +0000
Received: from DM3PPF35CFB4DBF.namprd10.prod.outlook.com
 ([fe80::211d:441:2594:6cca]) by DM3PPF35CFB4DBF.namprd10.prod.outlook.com
 ([fe80::211d:441:2594:6cca%8]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 17:00:22 +0000
Message-ID: <fc270ae2-3217-4364-bf74-62bbf26ff9c7@oracle.com>
Date: Wed, 17 Sep 2025 12:00:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: replace hardcoded magic number with DTPAGEMAXSLOT
 constant
To: Zheng Yu <zheng.yu@northwestern.edu>
Cc: "ghanshyam1898@gmail.com" <ghanshyam1898@gmail.com>,
        "duttaditya18@gmail.com" <duttaditya18@gmail.com>,
        "r.smirnov@omp.ru" <r.smirnov@omp.ru>,
        "jfs-discussion@lists.sourceforge.net"
 <jfs-discussion@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <BL0PR05MB46744E1F59F1E41E2C2E014EFF25A@BL0PR05MB4674.namprd05.prod.outlook.com>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <BL0PR05MB46744E1F59F1E41E2C2E014EFF25A@BL0PR05MB4674.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::27) To DM3PPF35CFB4DBF.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c1d)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF35CFB4DBF:EE_|BL3PR10MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3aa167-32a0-4590-2cd1-08ddf60bb07c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXB2OGQxSjFUWUlFWXRkQlVQOGJCN001Q1JnQVBuT080NVd0S0J6bGY4Mm9z?=
 =?utf-8?B?VnJXM09uN3dEQXRjbmkyRGpLb0dxM3JRbTN3MEpOMzdRVzJsSkVaZERlYjJD?=
 =?utf-8?B?QjZUR3ZvU2lySGc2S2ptT1Z4ckxrWSs1MEZmOTFZbWVhRi96MXRrRk5ici9U?=
 =?utf-8?B?Z2tYSnUwcWxUeVJmRUE2Z0g4elJXaHBpUjBxZWlWdENrZjlBaWd3WUFwY2V0?=
 =?utf-8?B?WTE1VEVtczBQRy9PajdWTXkrVmdqVUZSQ25rSCtnb1ZlNSt0YUQvc045SmFP?=
 =?utf-8?B?Z3M2VHEwanF3TTlBTzc3RCtIbm1CVll1ZWlDaCtnOGRBSzlkTktROXZSc2Rj?=
 =?utf-8?B?YnY4TmdRdEEvUjRyT2JPYTZVZVBJSmh6SkdwZTdhaVZZYjlEbnZZUHRjS2pn?=
 =?utf-8?B?NmpQb0xFbDRjN2NlT2lZRzJBNWtlZWJaakhUMS9DQU5zZGxBWU9jNS8rS0Fh?=
 =?utf-8?B?UWR0Z05EYm1XVmRURWhHSTVlajkvVUN6bnhzU1Vna1JNTVVua0ZPWXB3blM4?=
 =?utf-8?B?aERoUUM4UGtuZG9sL01CTWxHRVRleHpYOVM2ZDNENnpMQU9uc0ZkbmJkU2RM?=
 =?utf-8?B?VE8vcnVKUjBYKy8weURvOXdlS2VRVnZCNjduZVpzTDJNeHp5U2dmNThLa1Z2?=
 =?utf-8?B?RmdGWG1ObEtMNmVJYk52azFmNmZySjBIY2w4UW9SdVpneTAycFRsL1ErL2ZL?=
 =?utf-8?B?dFUyVVRUTTREUS84Z243cWp3Z2cyeXpzSFZzRkRtbEFtdityWmJqSURLbTlN?=
 =?utf-8?B?QXExSFNzeDRlMndqam05RnBSL2dzeWsxZ2tPYmpTMHVJYWJSUkFEOGx3ZFly?=
 =?utf-8?B?VFdrTEFBcWUvem5tTjhkVXFnUDhUOGc5YVRJall3Z2JzWmdGZU5SSUtSNnp1?=
 =?utf-8?B?L1ZCS0NzcU1WcTlZbFQ3NnhkMFU2eG95MEJYY3JZTFdyTkd4RWUzTERBTGFG?=
 =?utf-8?B?cnFiMWxzU0tic1RmazAwWUkwTnd1UGJLdDVVV3ZyZzQwdTlXTlhsbTdVcndn?=
 =?utf-8?B?cUxDbWNpcTlSMjN5SHhJUGIrNlI0bnZPckg5bjU4WTRDMDkvcXcxcmhKS29z?=
 =?utf-8?B?aFBLSlVDWFpTMjhyTkJjMVAwKzFDWis2eThvaUtYbGdQQ25tNUlXNXQ4a3BN?=
 =?utf-8?B?V0t4aFQxM3o4MHNVLzNtblpHSkUzeXhHN1o0SGxzUHg0QmQxcHJnY1hKbnFy?=
 =?utf-8?B?dW1ENnF0OWQwM2FVY2dCenkzMUx5T0lQZ1dwR3FaTCszWGkzY2lXU2FZOFdm?=
 =?utf-8?B?bzFhcFNrNHZEWFVyT2dLSDlWNy9sUmxVTVJjZnZ0Uk1MRjJzZ2VYOFMwN2hF?=
 =?utf-8?B?U2ozcldxcU1WWWNxY0t3L3JuNSt0Vlk2SkIxcjd3MlRRR2VFRlN2cjNvZHc2?=
 =?utf-8?B?N3FWMHlScWVTb2JDTHAvcEMwMWFud2g2U0ZBVTFPeXpiczA3a1F5dzZIWkdE?=
 =?utf-8?B?K1ZGT2c2Y1U2VnJKWWt2VHhadEJVVThNZmpYSEhuRHpIdEhwT21jWGxZcWR3?=
 =?utf-8?B?cFV2anY5ODhKeTdEQzd5eEtwckhBTG1uU3lidERvNk9pSit5WUFyOFFsNGFy?=
 =?utf-8?B?Y084Q1lBSG5La3V1L3V6M0RxbXRMRE0zSFZ3K291QjhIMTBXbHZhaDI5ZTg4?=
 =?utf-8?B?ZC9RdTBEcXZrcGowMmpQcWE2MzQ2NHN1NElwcEtXVFlDTzlJUGFiajBLcm5y?=
 =?utf-8?B?WlN2UHphVDNwSFB0d2ZWK28rUzZGb3EzNXZEeTI4alEvdGlmYjlXa2RJQ3N2?=
 =?utf-8?B?aXNPSHJYUnRjazJvTDBjdktkV042MnpsUjZ3dlF5NzQ5S3Y5SHN0d3ZzNmJ3?=
 =?utf-8?B?U2I4OG43K2IrdGMrSjMyZzEzNEs3VE1SSTl2a1d6VWcvSTFGK1BjSHZFRi9N?=
 =?utf-8?B?VExJdllsZTNvMzExaGhZMUs5NlFtVWdEaVVtUlJKVUVzYkVvQUxENFdEeHdT?=
 =?utf-8?Q?zSnF1SvXQcw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF35CFB4DBF.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGZhbHdtSkU1VG02R3VPclprNmZVVVFBbnRoQ0pVZWJqS3ZGM241aFN5a21i?=
 =?utf-8?B?OVZUdkExU2tDN0lwZzI5aVFQRUFPSjZ4c0xyT1FSNE01eDBGZ0h0Q0Yvdm01?=
 =?utf-8?B?Ri9qcVk2VXV3RmxlZnpBcXpWamNxd0F0M21DTnU4OWtZWjBaUmVWOTlaMEJZ?=
 =?utf-8?B?OUREQjRKbnNFT08rN0VFQ2N3NnJ0QzNidVRNNTFDQUxHT2hvSkxMbWFaM3Ax?=
 =?utf-8?B?VGxHWG9kMUl1a0FIUEhsdTBaOE1xMWZNdzZIcHZHSEluTnZyRkpJTjJpYzIw?=
 =?utf-8?B?VDZtMUVNeFYwRVMyTG5uOGxuaVhBZTJ4NUhmUlczVS9kTVQ0TzNTc0xwZE1L?=
 =?utf-8?B?UTJlTzdzVWUzODZQSXd5TCtMOWxwSGw1TUlpcVlrSmJEc0ZxZGx6emxCN3gx?=
 =?utf-8?B?ZGxIUXNjVm1EKytGS0Vuci9GVE1YN0NBZVVDZGhZVzJHVUhkbkU2VFdPVEg5?=
 =?utf-8?B?QnNMZEdGVVdMV21paGlsRVhJdW1EWWhCTmlYQldGZHpNU21qdVZVa2hRdmpu?=
 =?utf-8?B?MktIMXl0TmlUMGxyZVdOOVVWRFhMbXR3ODNXVVd5SzhOdERVZE50b05NWGF6?=
 =?utf-8?B?Nm9HRE10YzNOdTRHTWN3QjNwRFFySC9aTEZEdmtsb1VpYVhwSVA5VWpOc1FO?=
 =?utf-8?B?NDIrV3djUktBLzZpamdpTVIvcVBxdU12K3lnU2tKWmx3OXFGMnRFclhLQWd2?=
 =?utf-8?B?VURqNXFzSXlBOHRUNEFmUXRtbGVUVG5pcG5JTmIrNXhMaUN0amdoVlBDYnc3?=
 =?utf-8?B?VUNoT0EwMHoxUzNmVWI4cUhaU0VKTmRNMUMxTDRUUk9WZnM1bmtManhRdkx0?=
 =?utf-8?B?SzZ0MWlJUHM4UkJWOGxEUXZOZ1Y2NUJJZU9DK1RlcUE3YnZ5NVZWbE9QL01X?=
 =?utf-8?B?eGFvR2VuS3VOZkhFbDRIQWo0REVuMEx6US9pN21aTUJVMXVMTGhoc3JDNEVi?=
 =?utf-8?B?L2R2OGdBQ2gxWW9mQzFMSnhzOUNTRjROaTREV0ZKcVVsT2Y1VGhrdk5PTkN0?=
 =?utf-8?B?RkVZUjhIUjUzTFIvVHF1OUdBSENPSnVTSnpVNi8wT1I2NnBKamZSM1BBNzc1?=
 =?utf-8?B?TVlaSXJRQWVjL0p6RS82MzZJT3NJdlVDZGNpc0RWQlpVWG4wdS9HNFRxbHJ4?=
 =?utf-8?B?bE05ZnpDVEhzUitSS0pQbk16S3dseHpRMXFZOEpzL0FTejNhUkNUYkNrTVQ4?=
 =?utf-8?B?QWh6d3hST0ZKWGpCSlZTM2FmQzQwQXpua2dnZ3h0ZUh4QUJNdEI0YkgzN3Ru?=
 =?utf-8?B?M3BhTUREUGdpRWpvWGN1L2ZIQ1ZmdmwyTTFrT3NtTUVoZGgxc29JYXhWMWwz?=
 =?utf-8?B?Z3JaeEZYRzUrc1JZcU11aE9UaUY0alY1cFQxUkttMXdJU2luQW45KzFrOTh4?=
 =?utf-8?B?TGVEbzg5VFJkQ0VxU2hYWUtVRmhYcnRDcmdqV2JVODdvZnROWit0ZkJGQlVv?=
 =?utf-8?B?Q21SclFjOFROczlMd2huOXk2NHhFREUwVjVpRE81dktHdTRRV202VEFxWUM1?=
 =?utf-8?B?MERJQ3lXNGloVEVkMUpBVHNxZnpIM0JNVURLM05BUmFhTTkvNVJXRGxaT2hv?=
 =?utf-8?B?L2NXQngvRTM1TmFYS3RwSURqQUFqUE1UbVBmeE51WnpLcUZlS0ZkaDdQa0du?=
 =?utf-8?B?RWp6SEdubWhCNGd3SEk4UUZReTVyUFk3VytwQXk4N0JkOU5vb2svY1NhRXV4?=
 =?utf-8?B?Wk5LNUhNenFIVkpBc0ZnZDRGTUE4ZzBMS3ZTVzhCa3hObVZxS0hyYm5NNjNa?=
 =?utf-8?B?bDdYVWNLUGlNRWpCRFlRVkJKVmsxc3J5NG4zR2hJU2YzSmZ2RUpOQnhabWlE?=
 =?utf-8?B?aFpsMUJ4YStQU2ZDK1RWNmFoNU1FdHVvR0lzK3FhcWFRVW5SNFVUUkZLOW13?=
 =?utf-8?B?K0IxVjRlUGxMWnV5SnRXdnpOSERKZXJKbXZZU3BBNGV1Q0NCclJqc3B0bHVx?=
 =?utf-8?B?Yi84U0RBRHMydzhQR0FFMXlTTUNIcUd2eXdMYzRyV0VUTCtIVURWaWJBbVdM?=
 =?utf-8?B?UDViOFM5YWVaa01RM29iaklrZitxWmcwT1hMcTdRVm5HSko4Q0tid0wvQVdo?=
 =?utf-8?B?WURkMGt1RDY5VEptTkhzNzdrNTl0SVhCa3pjb3MzdmVoaXFmcnQ4QWF3S1VQ?=
 =?utf-8?B?UDdudk1DNWJNazFlNXNaK2poRnBhdGtJM3Q1d29aTmRLYWNDTkZTMHZPM0Vp?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s0umZa+OJojpOHmuH0irvdpYrteU1G9QXjwy0zNu0zTDG/fkGf5M2+Dhhckm4PUe85pRNAGv8FXehEWb+HLLRO1BuV7Y3kxZje4l0nQZrAmkzvY+godYkEIcHnw9BLP/jwyMvBEb0L3RydNSrYi1dACUhPzLOnamM6EBSMvU3RJ9FcXZMiDrWwLRh88mWuZEEVtqbAu7ZScifbKq0JS7sdA8waJey8/DTlsF7gw+UyjFPPBNetIQINjVblVc026S+7QE8+zi0A+RW4A/Q5wz7C4HQo+CUWPGD4711Oj5iq+Oo/NrcFkkq3JzUgPqaLL0Dy2Yn1xbuF97DvDhnuzHo+KeftSFtVjQLwizodwPQIKw5FEgJfIoIXhIHamrZaPZATHs31OHCyEJ2CvjH2fVbwgks567RJxFT97e2/0kLgBTX7ldfQAhd+/v9S9VsdEo22h6FVPBoA2l0KMNA9qMeSBBEX543D7uePMMYleMzAYbAcDXpcXdcdiLn4wb4fZLGGbt1J7SsDW+FodGL3qxUyGy7XdjGBKjRIVRuggCbCenqPaalAkkD0e/FjJ1hAz17KQJi4sY2SFYtu/yb5uV19FjxCJLEqENDqntUySBf88=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3aa167-32a0-4590-2cd1-08ddf60bb07c
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF35CFB4DBF.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 17:00:22.5029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hic9dO3VGvKtE9k3wGjqzlXoJPxX0hwA/o1Wlx4jdePxeyBr/wlHXL3GNKusBeH+NQNklI40n+iREE7ytSrc/oY4nt0fSEIbLghr02ZtZfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6091
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=930 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509170166
X-Proofpoint-GUID: 6a0eMKDpYaozCG6cPQ-n1rGgmy92Jppx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX7uF39lnHXxOc
 to16OZx/3DwkQ+eF2ssEd6a5y5xEJcY3jbrFa+SyBftm6gzzt5z6R9jJ+3CjDqtxbmLorC4iw+Y
 fhYIu29K8NBMf0JW+9KsQr9RXgxgCEK3WFrcfcPp+w6OT6WOMql8VV539wKnPsWMAscnF3cqeEa
 rMYATaLNIe7l99f5169wz2dHI4p91nlL79C1BS/5yrIpj1in9SBh6RBEqnbKBMKSMxqMo4a0Fp5
 0xUawSFPAzpOSRYNhsg+ttr9LSKXxZU8FLC/fQUwaY64GvE6tCFRFOnsMvEFIkiDSYRJDtaxCpK
 UwKP7vpuEmfCkn7jC/8XYX6foweDF1gHyAZCbljGtxkSMLhx3TX0Vc/0lWhck9xyrCS5cqSFvjb
 xd60wqqa
X-Authority-Analysis: v=2.4 cv=cerSrmDM c=1 sm=1 tr=0 ts=68cae994 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=OiKpMoXlxSRDEFoYqbcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6a0eMKDpYaozCG6cPQ-n1rGgmy92Jppx

Looks good. I'll apply and test this.

I'm removing the Fixes: lines because this is cosmetic and not really a 
bug fix. There's no need to flag this for stable.

Thanks,
Shaggy

On 7/29/25 1:28PM, Zheng Yu wrote:
> Replace hardcoded value 127 with DTPAGEMAXSLOT constant in boundary
> checks within jfs_readdir() and dtReadFirst(). This improves code
> maintainability and ensures consistency with the defined maximum
> slot value.
> 
> Fixes: ca84a2c9be48 ("jfs: array-index-out-of-bounds fix in dtReadFirst")
> Fixes: 839f102efb16 ("jfs: fix array-index-out-of-bounds in jfs_readdir")
> Signed-off-by: Zheng Yu <zheng.yu@northwestern.edu>
> ---
>   fs/jfs/jfs_dtree.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
> index ab11849cf9cc..0ab83bb7bbdf 100644
> --- a/fs/jfs/jfs_dtree.c
> +++ b/fs/jfs/jfs_dtree.c
> @@ -2903,7 +2903,7 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
>                   stbl = DT_GETSTBL(p);
>   
>                   for (i = index; i < p->header.nextindex; i++) {
> -                       if (stbl[i] < 0 || stbl[i] > 127) {
> +                       if (stbl[i] < 0 || stbl[i] >= DTPAGEMAXSLOT) {
>                                   jfs_err("JFS: Invalid stbl[%d] = %d for inode %ld, block = %lld",
>                                           i, stbl[i], (long)ip->i_ino, (long long)bn);
>                                   free_page(dirent_buf);
> @@ -3108,7 +3108,7 @@ static int dtReadFirst(struct inode *ip, struct btstack * btstack)
>                   /* get the leftmost entry */
>                   stbl = DT_GETSTBL(p);
>   
> -               if (stbl[0] < 0 || stbl[0] > 127) {
> +               if (stbl[0] < 0 || stbl[0] >= DTPAGEMAXSLOT) {
>                           DT_PUTPAGE(mp);
>                           jfs_error(ip->i_sb, "stbl[0] out of bound\n");
>                           return -EIO;
> --
> 2.43.0


