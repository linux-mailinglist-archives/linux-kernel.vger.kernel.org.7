Return-Path: <linux-kernel+bounces-748482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C6EB141AE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5541516CECA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA21279DA0;
	Mon, 28 Jul 2025 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KvLCmheL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X7bOtnoK"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FC627603B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725534; cv=fail; b=dpTJoekEoT80w+tT+KGeetwWtBXIaSUIbzn/61e+YatdfL/iJ0xRf+tGI3tvvbSnIagMxVSsOu88UAZDo/wMKJnrOy75eoCvXdHfLWQT4uKV9K+IULSkXafFwqa1TtQ3Ym/Yf9toZK0gGzFMzS40RNLhw86A1lBbpZxqksr/8K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725534; c=relaxed/simple;
	bh=gKQGCk6pBjj0vZEbV87qUHXZAPt3DBft1mUp9Kygjm0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ALFatyAqWO7wsx4O97jPT1uFBUdy4vCIAhZT37PYie6PqUG0cS30nLSwRxnnryNxesx/qQLtuStxNMXtZ+EJq1EUUJD4kGYCDsDPq6ibU4qDbF0DgNfn63vcobS/EPmFeyhS/eAaFKIKHSKMrD4DwkdlYkRUvNVIaYC8dmX+Hgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KvLCmheL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X7bOtnoK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SGiLj8003583;
	Mon, 28 Jul 2025 17:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uPWkMsVW3JoNNJYz0l1PiK+Lb/pNRBzoM0ZT+1OcrPI=; b=
	KvLCmheLHiJrkb0Z9uQ67k4r9WCDyNnhfY9d+YZ6cxyaw8p5pnQaVU6061iOQc8A
	ZrAxMdGH7aaQqLdJt47LKjxCPrMQBVxEZDuklmJkoRILM6DQbGQ5sa3VTKw4t01E
	BPfsJWOXjfr57e+JdoF+TG1mMN3olt6XwWFkfavCOXKnhEtNokleiJxOBbPqpYSd
	6+zAaPBDGTg7QRi3Yzc84goA17q9sdjnSX2ehJTaDdL+n/fH7/M75k0hEt5hqCcE
	CAXcduKAoqh9KLToHB56I3/fQNFmkGZuEY8xXAHa8i+wx3E1u8BdjuaMEjRI20zz
	o0SzedQPPH8GJxboxGjpGA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q29p00p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 17:58:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56SHMsxw020528;
	Mon, 28 Jul 2025 17:58:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nff6fa1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 17:58:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCKdMkp4Aena3Ry7f2JvOpQZ0SqfQj01wnT7WxXppLDHFMWCKO35WHsU5S0u7pWRx5nsAW38ZbdR+bHDCzxnqdHQKj+DTciieapuwzQutf7gvVLyjmD7NAadU9/7v4Ws72j4ObE5w3dlwx8p9+gQz30WrdXagtMhRTBCpeoSLL5GuqIQlsbiRG+BFSB9T1WVTEeE3CM39MW2Wi5eG6j5yfvjw6a1HRG1Dwr9brUtkbTf5+1p8m/7l/kcpuUZwzqswQ31/W9S9QT03NPcQr030jSa2e1wUyQXZkoWCwhlMECGMInJuc3mUESa9xEKGXrNQsaZ0HXd0oD683GzKxSuQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPWkMsVW3JoNNJYz0l1PiK+Lb/pNRBzoM0ZT+1OcrPI=;
 b=RQ+bEXvddp9wCTvX+xN9Ax7H4Y08XOC8cKDrsZECpcwQ7pU14MT9ot07lLHzvE52trp5D+DUEykjFxJlP5HEIGCXJrVIBKdxiNMNMolgVYJ9SqFRa6VuVbYlaLekeO92nlDFn+ScuFSdEvv9/wKjanmGpY+knWm1KxArqEpr9lV6YoDgdvJsbPl/8ENgbTM+4d98SzA6mmIkXVabprPmQXkfRvZXcirr+XVgz7rol3aqizGoObyNvW73SlnM0ZIa1WoW3Y25NnAnhGo89nFA0RTupdVIUZ98RYnfWjGndwiVdjtzyOJ7VRvrwCCkgmlozvxlH0WJM9qpDItBMcEloA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPWkMsVW3JoNNJYz0l1PiK+Lb/pNRBzoM0ZT+1OcrPI=;
 b=X7bOtnoK+6BLgU5YMnWoG3DGGKkSV4r5BUQ7Ku+vOK/EJ4Lz1rIlSFn2+humbDpPCCkR4sMJdEX57QN2IiCpA0FVR2JEjCeME4+AYOaKzIOdnozOWouYubGWW/RKNmyu/RWY4nC/tT6BP6vtcCE5nRxuoJRzTXC7c1+NCKC6kmw=
Received: from PH3PPF517B7003F.namprd10.prod.outlook.com
 (2603:10b6:518:1::79d) by BN0PR10MB4855.namprd10.prod.outlook.com
 (2603:10b6:408:122::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 17:58:16 +0000
Received: from PH3PPF517B7003F.namprd10.prod.outlook.com
 ([fe80::943c:5ede:5076:73d4]) by PH3PPF517B7003F.namprd10.prod.outlook.com
 ([fe80::943c:5ede:5076:73d4%6]) with mapi id 15.20.8964.021; Mon, 28 Jul 2025
 17:58:16 +0000
Message-ID: <32e5a374-3b00-4450-a1f7-2729f1e3dfec@oracle.com>
Date: Mon, 28 Jul 2025 12:58:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [Jfs-discussion] [PATCH] jfs: upper bound check of tree index in
 dbAllocAG
To: Arnaud Lecomte <contact@arnaud-lcm.com>
Cc: jfs-discussion@lists.sourceforge.net,
        syzbot+cffd18309153948f3c3e@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20250424-ubsan-jfs-v1-1-2eab57c1ac50@arnaud-lcm.com>
 <e7b79c66-22b4-4d01-be5f-adfc5ba7e50b@oracle.com>
 <ce2b8d4b-7396-43fe-b948-5ab59294832f@arnaud-lcm.com>
 <efd5366c-811b-482c-9e69-ce2fe1ef3295@arnaud-lcm.com>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <efd5366c-811b-482c-9e69-ce2fe1ef3295@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:610:52::26) To PH3PPF517B7003F.namprd10.prod.outlook.com
 (2603:10b6:518:1::79d)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF517B7003F:EE_|BN0PR10MB4855:EE_
X-MS-Office365-Filtering-Correlation-Id: 4083aac7-09e6-4815-d048-08ddce0053c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2RjeEtpMEtjMmhVQis5MUxCR3hnNW9LbVBxQnF2K0hqUWVQeVBYcGZhSXZl?=
 =?utf-8?B?cVJ6R0JzTHJENFgyTFQ0Uk9hZDZTNlBzbFJ3MFc0YjRXNW5UNGRBa25ic2Vx?=
 =?utf-8?B?Y2xaWHR3QkpDNGh4M3VSTytJSGYvWlVPNnc0eW1YRStveU5MdnlRbGRLS0FB?=
 =?utf-8?B?eUJWZ0lVU1VEZUpWYXpCMG9sUW9UemhJWUZ5QnFXWlBmWW0vRGFwSkpKSWxl?=
 =?utf-8?B?R1ZTRFhXcUxPUzRVMmN6WVdkTGZkaXRveStLUFBYZ1F1VUlkTzlIZHczTUI5?=
 =?utf-8?B?RG1RbU5ndkdXRVd6cmNnZWRtRFpxcUZQV3JqL1FrSUY5YVdOQURreFNmK25n?=
 =?utf-8?B?aTFSOTE0cEorQ0FESEpnbXBGK290aVF2cHlFekxhMi90Um5xaVM2Rnl2bWlx?=
 =?utf-8?B?cGZYbVFBaEkya09BUDIzSTJFTC9MWGN0UXF3aFFjSnBJdW82NlRLRm45d2sx?=
 =?utf-8?B?ZDA1akQxaXFaRmt2Y3pRNk9FMGh4Z21FVmdIMXRlN25qWkIwTjFYdUxKYU5T?=
 =?utf-8?B?T2ZaKysrMnlPSEZuaEVHcXVjeU0wWlgvazRTaGxpMlN2NXRsVkxjb1dobjE4?=
 =?utf-8?B?eDZXVUt5RC9Xc3M2VmJDTHMyWVNIVGxyMnhRZVVLWkhRaGlqM3Y3TmFLaE5Z?=
 =?utf-8?B?N0x4U2M4ZjJ3UUM5NlZTVWwvUE1XT1hyNEU3R1NtR3VCanRSVmpJOTNuaCtj?=
 =?utf-8?B?Z1pNK2tDUlFCV3FEa3I3L2hFT3p6MFJtRjljNUJoTlBvL2RleFM4YmhHN0tZ?=
 =?utf-8?B?bVd1QXBoTUxtcEdIVWQ3NW9ST3Fra3FlQjI0RG5VWkM0dlNWSUc1M3BHNzBh?=
 =?utf-8?B?dXpqSVV6YVd3ek9kQmdTRkJ6ZlVTMXhJWldBRllVdkFFbGdycThwL01udGpp?=
 =?utf-8?B?NGJrdjJKRVhDdUFTMGVSMklacnNtdER5WXp0d2l6SzdqdzIvRloveGhPQ1Ra?=
 =?utf-8?B?T1hiVklWNUM3SVY1QTlQQUp1YXdkYUVoWVNpZUFTdVkzNnpydFF4dGVlS21i?=
 =?utf-8?B?b2ozLzVhR1pqUzF0bGF0NUwwL2xCdnI0TGJjVnBQL1lFVXlENVVSemZ2cnhG?=
 =?utf-8?B?OFROeEU3Y2NOOGIydkc0NkNHWlQrbE1uS3ZlUlhhbUZhZzdDTGE0QUpGeTVK?=
 =?utf-8?B?N3gxY0g1c3U2Z0FhdDJ4bE93YVBpNEhJQmo4NlNmcXJLTDdOR09LL2J1V3U1?=
 =?utf-8?B?SzVaWUl1UjduRHZ6SGJMMjJaSmtsbEJNd2JOa2ZvRk1BT3JCZ3JrbURpWk9Z?=
 =?utf-8?B?aDZxdWRBaSt5SCtYb3YyMFVFZ1ZtRUV4d3VBVXVMeXVkNFB3MmJVOG1yYVZh?=
 =?utf-8?B?ZkdPd0poU2Q5REZQeE1acHNLN2FSRG1nUjNKNEthdHRJa2puZzgva1dhb2li?=
 =?utf-8?B?c0RzNElZUGlRdXB2SFk1R3BjRzErZ3Zvd01xUXBTTjJ2TzhTa0p2bXkyYkxa?=
 =?utf-8?B?MzBtVjZ6L084MjkzaUVjblRpU2ErVFF3Z0FacldrbWI0TUlrc2hnSzZFb0l1?=
 =?utf-8?B?YStwdnhnMEZMV3BGWUdVMlEySEZydTJzWHY0THJrRmRNVHZLeE9YNnNLdFNN?=
 =?utf-8?B?cy9IZlViZy85S3c5M1NxbjdIblp1Mk5HSHhUT3NUb2t2UHEwalo2S21XRFVU?=
 =?utf-8?B?OVVObFJUNTE5Wjc1Z3RScnVnNHJYYnJkSTlCMy84K3Bmc0laTzdteGw2QnZC?=
 =?utf-8?B?VnhjdWRxUjVLQlJnekFyVWFHS1haWERiL1pYTkxhblNqdGgvc3NnRnBmRllW?=
 =?utf-8?B?V3Rla3RsVG9ZeHhEbjlZdHR4YXZLVXBwbXNTR1dlNXQyZGx3YWdCaEt0Qmls?=
 =?utf-8?Q?hsHaU/PXQ38ArTRM2lhnHfxA/HprwbQ/puieo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF517B7003F.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzVuSlJWcm0wSHBVTHVKUWFCTDJFeGRLTE5YUFI4TVRsSkYwbkh6TFUwby80?=
 =?utf-8?B?L3V4bFhVNFVTb1dDZ3NpcGxzYTl3NEtrUitoV1M4bGhkRmhiWEQ4ZmlKNWVY?=
 =?utf-8?B?aUhrMFhRc0pUTU1BQnhKMkZ3ZnorbTlFYjVTL1lQblpYZXpBMVRtU09GSmt0?=
 =?utf-8?B?ekRkNlVxWlRQek1ZeTBORmt3R3ZyU2V2bVBUZHBCajVHSXlqc1d3SjJhR1gy?=
 =?utf-8?B?ZEtvOWszRElxRk9uV0s2OHpZTHV4NklJdEx0Nnp1OWNta0NETE41U05xT2NK?=
 =?utf-8?B?d1dwTUE0M3o4SUZmamNiQ2o4WE9IclI5QkdxVVhvU3JHMkcvRHRMR0ZMenZZ?=
 =?utf-8?B?YmJUaVNhTWx3VlhSYnZNdkFRS3g2blNjNklTNjNtNlBIcWdCUU5jRHdqOGZD?=
 =?utf-8?B?NSs3T3ZjTU1vcGVPRVgvYWRBT1FXYktSdFBUQkp0bVJoNTlyQTZ6WitYMFlY?=
 =?utf-8?B?d1YxVXhqWXpFVmJzNTRtNHQzSWJQTEp6SEp2cnU2Zll1eXlkTmVuZGlKOS83?=
 =?utf-8?B?QkJucnJKL2o5RVk2L0pBNlVLOUNBQ0hBQk4rN2FSUDgyeVFKNm50MXVnZTQz?=
 =?utf-8?B?aVpJZnpxdldRUUFUKytuVFJRc2lubG1oUUV6Z0p4LzlKc2ZOeEtPTkxVeFNq?=
 =?utf-8?B?ZFpteTRtNUk3WXhKc2pPZGpuV2JSbFNQLzVaakxzVDJBMXZVdlNzVStZMGky?=
 =?utf-8?B?Qk1XcEJ6aG13ejZBSG1ZY0JWTlVXTGNpMC8rUmZWRjh5b2YrMThrSE9xU250?=
 =?utf-8?B?aitMWVluSWxidFdsZTUyVklhQk43ZmZQL0dQMVZ2Y0tPWXBGUmt6YkRhQ3cz?=
 =?utf-8?B?L2MxVE9nOGMxZFkzcFNvdXdWV3hGS2k2ajdQL2M4MlVQUGFFTm5OK0FMOFdB?=
 =?utf-8?B?a0lDY3l6UE52NXJubXkvZlBPWTFGcUJORWxPVkJSZzZmeUxGUzRWZHVFekta?=
 =?utf-8?B?WjRud1E5SUNpYTRDaUxkZGNQWWNlUGRqOTBaQW9nT0NpRitFRDBXdHVjZ29Y?=
 =?utf-8?B?YWs3YllGRmZuZnpHbFYyc2dLcjhiQnJMa2s0aitFZm1ieVlqQ3ZDRFF1SGF3?=
 =?utf-8?B?ZlVBdXoyNXBOdGxyMHNYV0xXcVdORFV1Nk0yRHNFamhHN0Q5QzBsRCtUNEFJ?=
 =?utf-8?B?L3RSUXlkbVpLdVJNc096SVRLMkZRa3hMUmZvRUVxa3F2eVcwQTZUcjRvVTdz?=
 =?utf-8?B?NGVFWit5NDJCSFB1MFppNnZlUzdBaWhlbExRM1hRSHRrL1QwT0JjRVlwTDNO?=
 =?utf-8?B?aHUzYXV5VHdSNU02bWVhUWtzZHh0dW1HSGNlVEpFQWVrUWt5RnRWRGpPQi9S?=
 =?utf-8?B?YjFPZTZ6SzhnM2JYdUZPbWRrMlR0RDkwS1BFSXJoVkQyc1lSck1EL1FvRmcz?=
 =?utf-8?B?YkFac3RUcTkyOCsyWUlRL3NneldxaTZuQW1DbzdGRUtCbTM4bkhNV3RFUFRq?=
 =?utf-8?B?WVQzbU1oNzVZaVlGUlB4RDIxdlpTbXJWS2tBclp4YjlGSG1RZld6eEhvVHNk?=
 =?utf-8?B?UnRLVWlxYTh5czBMZldhYStFSlNHOHkvSElveEJ0eVplVHRRTjBaS1R6SlF2?=
 =?utf-8?B?aTVQcTNWVFg3TEVmZ3V4dVlrRG5lb0U3Y0tjU0hqZUZjcmMzZERtNmN3cDBm?=
 =?utf-8?B?K1lCZzlYMVNRQ0R1WEZDZGJWYWN1WGpoUHlvUVRETHZ2QVFxTmtGK09FRXpr?=
 =?utf-8?B?RE4yWnQ1SU9ERStFeEZnVHlDUHpyTWtLbWxuOGM2TVlBQTlST1ZPeklRb1Az?=
 =?utf-8?B?OCtYRi9kS2RrdkxjK0kramdJMW8rdUhSTThTNzZHc0JIYXFTSU9iOWR5Rm84?=
 =?utf-8?B?WXMxUzRjbDhUVWJ6MGZHV01Dbmkvd0xjR3VNN2NmM3p3RWEzNUlRb3VpVlB5?=
 =?utf-8?B?LzlERTNDcjdaQU9XMlkzd3EzQkh0T2hzdmtibXRISVNSTjVjOTQ2LzFUVVFv?=
 =?utf-8?B?TjFhY0IrYzEwa2JzMjBva2ZHbEpEWjMwamVWUXpvSEhERmZDaGhNZ1QzYTFX?=
 =?utf-8?B?WGpzZWRFWmlxYkc3dDZzcnBUTmV6UGI2OUVmZVVBSXZGcTQxcHdTQmJDMS96?=
 =?utf-8?B?cWhPdTUwY0pNNWRuRkNXZytyUm8wRDdkNkNZZDZiRWdmQmE1bnp6akRWVlQ5?=
 =?utf-8?B?MmZ1c1BhZUJaS2E1Z1NjMDIrUjRUamd0ZW1GZUUrRHdMNXRwcmdEa3BUdzFM?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UhFg2IrTtLAhTL8fjMGKn5jCKI5OR27IPZ/b/kYMiWsz4vTcwCMRQvWsltmKzbdbwG5z4Ihmhp0t3X+bx4xldjG5HzOyhPILgbEI+anyAgfzX8qnjyvZE0sJo9i4iVRD0ccul4ucRKa7FWFDCmweZ9sY3r+qOfL8Slp12YZiGdAfB2ezNlsat7V3Kw9Lrabc8cj0HJH0n4qOrE7L9Tyj32D64gYP+AVlAgiMtOhPy1mLELMT4IaLsvT1GMZU7Spd2DN0OouF2Pr1hAMSvn+ZzCqHDO0d2lFZ0OhWEtR62zJ+vYWqRmjYJeXUmvAmZkAVye7YxCzgFkv+W57ERRfaIv7x5ela5cZP4TLNq6Y7nAtPgmwOS6JbY7gWlmehvd8EVw4Pt50E2crxfzL7ADS02Z4OosYpBz7N1zRVxy9evrkpNAzXuhrUYotY3IxIx1sRfOaEmQEoTxKJVFUrhs6LC+tQ1UIvsLJgjG2v/Sf5rWYA+Whil4IMqWhjOyE2Y9PplAIYxzUQXpNByDt+hjhXeFnaZOGAsDsWaCa/2/kxvK+a9Yt77Kmt1S9hTLDK4YboMMZH8Ne/0iKL/zWU8zNClbWpo/HJy0+eylvJGrwQG7o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4083aac7-09e6-4815-d048-08ddce0053c8
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF517B7003F.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 17:58:16.0410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yIgV+/mMNZ8j4vT+FanqP5v1FD9F7q1V/iRR5ub/1aH5h9ShCflWshlIChJTXdbwqfPXKvTpcmd4ycupLLmRBj9bPeBWMLYuOWOJpTCEYP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4855
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507280132
X-Proofpoint-ORIG-GUID: nm6WP9_3_LDpHwDBRW3eabdNRydnWZHD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDEzMSBTYWx0ZWRfXyXXlZvh9ky0z
 g9n1m0BJr7pfIw+/YmKL9vXV/URoUE0iflLb8jxxU4ZHe7SC1+MGpvS3pBzmnS6HeNY8zc0mgai
 NCnf+FUa3i+CWAaZvKhVxrJcDKPMX9uWbj1IsRQhv+KvDzbQOuewZm3y+bS0OrMBX6KvLq0hvBh
 I1FIchYnIl8ijxB0EOB9atzz1VSYOirJ4Z3ZPTiIIEI0irXONx+4WS2CEG8OvDN5816hsIwZs2k
 ebd+2gHhbZkUMkqqEX956wWYaATxUpP370vZr0hvYgxAn+S/tM0tsp84kdLuUWjJEwxjY9EIR1y
 xNnjFpB+oHOwj6KJxodRkYBa1X8cLHTy6LPbT1bJsDg9p2D/mHm6VpjHyirdS6MMcYFU+KNBGGQ
 0YgiVoazGKpAAVQnnYn6avN51h53QNjoHzyI31+6u1MxfKXkrpgiHx0Rneo+BpecKoMa9jIJ
X-Authority-Analysis: v=2.4 cv=FvIF/3rq c=1 sm=1 tr=0 ts=6887ba4b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8
 a=WWoXvQQ0AAAA:8 a=zA-3K44VG7j0h5tgmxkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=jSEAb1kaveHxcfb6UDw8:22
 cc=ntf awl=host:12071
X-Proofpoint-GUID: nm6WP9_3_LDpHwDBRW3eabdNRydnWZHD

On 7/27/25 4:55AM, Arnaud Lecomte wrote:
> Hi Dave,
> I am bumping the thread as I was wondering if you have some updates.
> Thanks !

It's in linux-next. I'll be pushing it to Linus this week.

Thanks,
Shaggy
> 
> On 14/07/2025 21:35, Lecomte, Arnaud wrote:
>> Thanks Dave !
>>
>> On 11/07/2025 20:23, Dave Kleikamp wrote:
>>> I'm finally trying to catch up.
>>>
>>> On 4/23/25 5:13PM, Arnaud Lecomte via Jfs-discussion wrote:
>>>> When computing the tree index in dbAllocAG, we never check we are not
>>>> out of bounds from the size of the stree.
>>>> This could happen in a scenario where the filesystem metadata are
>>>> corrupted.
>>>
>>> Looks good. I'll apply and test this.
>>>
>>>>
>>>> Reported-by: syzbot+cffd18309153948f3c3e@syzkaller.appspotmail.com
>>>> Closes: https://syzkaller.appspot.com/bug?extid=cffd18309153948f3c3e
>>>> Tested-by: syzbot+cffd18309153948f3c3e@syzkaller.appspotmail.com
>>>> Fixes: 263e55949d89 ("x86/cpu/amd: Fix workaround for erratum 1054")
>>>
>>> Removing the Fixes: line. This doesn't make sense.
>>>
>>>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
>>>> ---
>>>>   fs/jfs/jfs_dmap.c | 6 ++++++
>>>>   1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
>>>> index 26e89d0c69b6..7acebb9a21b0 100644
>>>> --- a/fs/jfs/jfs_dmap.c
>>>> +++ b/fs/jfs/jfs_dmap.c
>>>> @@ -1385,6 +1385,12 @@ dbAllocAG(struct bmap * bmp, int agno, s64 
>>>> nblocks, int l2nb, s64 * results)
>>>>           (1 << (L2LPERCTL - (bmp->db_agheight << 1))) / bmp- 
>>>> >db_agwidth;
>>>>       ti = bmp->db_agstart + bmp->db_agwidth * (agno & (agperlev - 1));
>>>>   +    if (ti < 0 || ti >= le32_to_cpu(dcp->nleafs)) {
>>>> +        jfs_error(bmp->db_ipbmap->i_sb, "Corrupt dmapctl page: ti 
>>>> out of bounds\n");
>>>> +        release_metapage(mp);
>>>> +        return -EIO;
>>>> +    }
>>>> +
>>>>       /* dmap control page trees fan-out by 4 and a single allocation
>>>>        * group may be described by 1 or 2 subtrees within the ag level
>>>>        * dmap control page, depending upon the ag size. examine the 
>>>> ag's
>>>>
>>>> ---
>>>> base-commit: 8560697b23dc2f405cb463af2b17256a9888129d
>>>> change-id: 20250423-ubsan-jfs-3a58acae5e57
>>>>
>>>> Best regards,
>>>
>>>


