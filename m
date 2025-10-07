Return-Path: <linux-kernel+bounces-844740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7393BC2A30
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 22:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3ED1890C9D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 20:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC2D23D7C9;
	Tue,  7 Oct 2025 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dka2JCdN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Mtcw3VWD"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6874F23F422
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 20:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759868610; cv=fail; b=OhRmUBnLP56bPev9jV9wNVnQHNRmtJrviUtFpGcv6wxfHStJfIxLCa4M9zS6DatwYjOe1LTp3Ivvl1XLwbep8HAZqZv02xQscpjnhJVElsFADNX/RRD6EV6yOdW4v1BjVndyLX03qV5jLJXT880uZRiYs+SJuqX2pTpvBV4vU+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759868610; c=relaxed/simple;
	bh=CKccgmUpafdp6mblX4m7lf7ztwRv4AeKewBY7+p+JBA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aoKg6xBhHkFJhRlsoY/i9scR61nbPS76vtvjDY6CIYzJdJwxDb879P3WTJwVtHbzqJUZgLiDtLlI1D3taF+GmoeZOu86SiEPYNC0t1NI3fHHNVEwGZtUnvzVvXu7LpDj7bpjaEyAEXagCnT7VZf1i999Xa/qctbnQ/blzyBsBCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dka2JCdN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Mtcw3VWD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597JdlUJ032249;
	Tue, 7 Oct 2025 20:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=CKccgmUpafdp6mblX4m7lf7ztwRv4AeKewBY7+p+JBA=; b=
	dka2JCdNZYfVf8FnACrsx8PcaW38yOxSq61JmKo6kpdUz0CyywTHtL24A57viIJ+
	JBA07+/V5Yw23ADKcQcJpsUz7lsHqEOP8WTKFXWetqlXKg8tVW6B8TNOZTeLBqmv
	2E/1oiYLcM8tNrL892NSgZTKEg9emIK8/dVxyD++ENkwTgVwyqgwIk35DjIE6wnw
	XoM3fPARuKaJN9Ou56T4Py5kD2gE/4nRpKfb2ZaLV+imDfYuYtt8rT58etbk1N8K
	p3PJSqjG5OaHAKfjTnPgiguRVopi55f+uPzd/xEi3zPTXW0PehVfvSwV0HWyhiCY
	jTevGL7fRDwoRg/7krnR2w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49n976r2sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Oct 2025 20:23:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 597IeCgo021390;
	Tue, 7 Oct 2025 20:23:03 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49jt18xkhg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Oct 2025 20:23:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqHR+D0Wg8hMtwIcOkXmTTx5eganGcOb4lVIE/4PmW5xwro8BBIi+al7k6qtjmjnNPzJWs9h0Djo0rdUvy0v7Oeb2iRJpvwr42e5YlT8tAsQmUWsGNw81ys2vShDf6p4sEocwdsp94Gk7N9/y22TW3gE/1i2XcsMO13jd4ia6Y5s42zF/ZLLVh/IliVkrESP8It75tcWGDXMb9pZXsN+crNmKyds7LobvnlOJI+vH/zGgMszt03jeIYXriUS2NzOmbnk2xbaIQHrgsmSFGtnnkpniz/7Iu1NDMs8gxbOd4FhFqApWBaUEP9SoceceH8Xj4D2Y1v25v63yWpnXE8p2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKccgmUpafdp6mblX4m7lf7ztwRv4AeKewBY7+p+JBA=;
 b=KtlaIAVJ/63Zs8ePaQwP5/UUT2huvladbmULH9WeuU2crR5NHxr+I1/FCr6FUu/DAJMWBfzf5n6MeM+/NIgWOLhjutlYib2gN4x93MnNl5VF/JsaIg875ihoP2YWJRx8c3XlaxwlGoRQDE+7xS1wbYDGEHukz4QzkLZn4UxcEUpB+zJMH8kt776Pu3W7iBCROL5DIHf/1QeVpuRG6k1m1Sr4shMMHLkbU4gD2QkAu7Eya1XL5NI+SiAjwMz2NMP8iRXP/PsXSS++QoQdecHi+vL/X7UBbOqwR3GA+JyFSow9zqqU2k8ISXOasU7OxrznKraNDqsBmCGa76hve+eKrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKccgmUpafdp6mblX4m7lf7ztwRv4AeKewBY7+p+JBA=;
 b=Mtcw3VWDBkJi7iSxLjV4xH8tAEnyOCOz2wG4MQHrvn0a+4rK5beqHIDZ9df2WIBRRUt+yfVVGAqjyMd3qVMXsSpxPgKA2L5vJ9hIH0vakUJMxzXmH84DQ9vpVUhEOdS1rA86r5xLb83Qlz6ENbMY7lq/cqgLW8stQKqQFA7jA4k=
Received: from PH7PR10MB6988.namprd10.prod.outlook.com (2603:10b6:510:27d::5)
 by DS0PR10MB8126.namprd10.prod.outlook.com (2603:10b6:8:1fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Tue, 7 Oct
 2025 20:22:59 +0000
Received: from PH7PR10MB6988.namprd10.prod.outlook.com
 ([fe80::3432:737c:a431:7edf]) by PH7PR10MB6988.namprd10.prod.outlook.com
 ([fe80::3432:737c:a431:7edf%7]) with mapi id 15.20.9203.007; Tue, 7 Oct 2025
 20:22:59 +0000
Message-ID: <22f0cf5c-ad9c-496e-a500-fee97daf160b@oracle.com>
Date: Tue, 7 Oct 2025 16:22:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [REGRESSION][v6.17-rc1]sched/fair: Bump
 sd->max_newidle_lb_cost when newidle balance fails
To: Chris Mason <clm@meta.com>, clm@fb.com
Cc: Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
        LKML <linux-kernel@vger.kernel.org>
References: <006c9df2-b691-47f1-82e6-e233c3f91faf@oracle.com>
 <28340138-a00e-47bc-a36f-270a01ac83b4@meta.com>
Content-Language: en-US, en-AG
From: Joseph Salisbury <joseph.salisbury@oracle.com>
In-Reply-To: <28340138-a00e-47bc-a36f-270a01ac83b4@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0PR07CA0099.namprd07.prod.outlook.com
 (2603:10b6:510:4::14) To PH7PR10MB6988.namprd10.prod.outlook.com
 (2603:10b6:510:27d::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6988:EE_|DS0PR10MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f477344-dedc-4aa1-9633-08de05df4ed5
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?c005RXlESUkrTzd0RHQ2TkdyeHFkSlZOL1gzZjJ6UUx0Zks3bElCMTkvVjZl?=
 =?utf-8?B?djlYNjVRS3JIQVBMQmY4UGNnaW16andHL3U4WEpDK3hWSUtyK21mR0ROSVQz?=
 =?utf-8?B?dVF4MHZwNzk4WEtvT2FVQTBNK3k1S05adGN6Tk1EYzFwM09yWlFsQ1o1djFP?=
 =?utf-8?B?QjFrdUtoVFJ5WXVZdFZrbHRqVDQyaHRtZ2dkUWdJdFV4QjQ2RzYzcVVvclF2?=
 =?utf-8?B?aGE3WGNpbW5pc0M3UjlKUDd1eTVrc2RnQndLMHA0dG1aRVFVbFJnSHpCSGt3?=
 =?utf-8?B?R3NtRUZOUWZtUk1Qc0k1R2svVlRvZXVqWHVNaGd3V2t5WTdCWGRwN0xnVnNr?=
 =?utf-8?B?c2ZROHFER1RzKzFPT1FHdndtN1dadUpQRjQ1UkwzU1ZPSzZPRXlNeE52RWZs?=
 =?utf-8?B?R29jMTcvaWNUYVVhTEtiYy9kVmhSTmpaYUh3Zmd3WDE5SmUrbHN6ZVdPTldv?=
 =?utf-8?B?bDIzRVNJblNhdHJ2NTBwME53TFN4N3grSHROQWx3eTJoQWZkYW9BU2FvWjhI?=
 =?utf-8?B?dHF4SlBqN1JGeXBrYktsdnl6QWg2Yk1HbFZzMk5PUDFtdDZWQ3ZJSFhUSEp3?=
 =?utf-8?B?dU5od3kzOGxacnl3c3hUcGlielFrbXRRcmlPMWJPcGpkSE0wbXZZd0FqMklH?=
 =?utf-8?B?N1ExQktGRUswZlhUR0FwTlBYMnI1VWVRdnltOWhsRkowQ1FHVWFaeWF0dlZs?=
 =?utf-8?B?MnlXWHlrS3cydnF2elFxNFlTTmhwQ3BnV1ZWcHYxZ0lMMDc5cTJ5SjBqdzdS?=
 =?utf-8?B?Q2EyUEZRTUtnSTFhUGJyL3FNTEs3VjIzZTRjTzIxQlFSdVVBZzhLT1hFL3dm?=
 =?utf-8?B?TUFORkNoZDI3Ty9TWGNaRE1NTEQ1Y0Vpb3BZMzliY016NnhURzJyT1I1cm03?=
 =?utf-8?B?dGdvMTJHd0RHZ1VwcG5GTEhsc011QnhTT0NCYXRIeXVJalFtenhTRzB3Ukh4?=
 =?utf-8?B?bVRKd01KMU1sK0pvOVpkd1FmM250WURYNks5cnVvcmVOcWlhODdPYWowa0pY?=
 =?utf-8?B?WlMzeTJmL21oU1FXSlVCazZkN2MweEdBNHpOMFpDUFljTXQ0Yi8rRVo1ZzhB?=
 =?utf-8?B?cXl6V3VJakZJNjNIVTg2NHROUk9NTkdOWXNoQmttR25YWEQ4MWpva1dKa0Fa?=
 =?utf-8?B?UWpFWGk4cytYUExNTlhNcDBNRE5nQU5kYkdTbnVBbTBTcXZtZUxmcFFWU1hB?=
 =?utf-8?B?Tndjcy8rSHFMTEpadCtBcnloYURHWU53Vk1UMk50RHRvNnhvNndTQng4Wloy?=
 =?utf-8?B?SFMzR1pMNGtpMWhTbHpNTjZSRW1LakFGbHNoRjErcWFNcEEvbXQ5d0pENHdx?=
 =?utf-8?B?aXdGUFNOZUZtWnU5eG9iTWtsa0d1Q1V4dW9EYm1WNkpyZHBaSkdDRE1pMlFL?=
 =?utf-8?B?MEhiQm5Eak51dUdYQ1ZoRG9HTGtsY2s5b0pkUlB2Qk8zeStIQldFbG5CQ0Ru?=
 =?utf-8?B?Q0d3Q2ROY0lYYjBxc2FyRmg3bGFaRFBhZTB0dTBjM25HV0VTY0E1bzVLZkxz?=
 =?utf-8?B?TlJuN25sOXhkY2EyRlppZS84ZVVSQnF2WEo0YVhGOTN0V2wrdVVxTmh3WDdT?=
 =?utf-8?B?bkxhbytUcDJWWWRuZWhQQzlCQWhvRS9NUHdsSHNpQXVVM1doMEJEaW9wOHpw?=
 =?utf-8?B?ZFpFVWN4aGhwQ3lPMmZBZGQ5RHZGYnBtWG5XNUtSNytYQ2M1RmVFajgvQzg3?=
 =?utf-8?B?dVFsaFVaVUZPRTIzUC9MakFmOWp3cTFTYlhvenJROG9lWU43ZTVZMXNTQlhm?=
 =?utf-8?B?WTJlbFBPaDdtYmJrNUdiUTZ5aUYxd1pQR0MwOWZWMDdrRWdlZ2llNDQ2aktp?=
 =?utf-8?B?cWwwMk1KQzNmUFNvTnVYMXViS3g1WW9UMVNYM0FtTm9nTzJSZkQxYzFlLytS?=
 =?utf-8?B?MGNjejZxMUsxbm9XUXVxL1VqVUl4NnFJdkp1OVhselFCMjlvcmdGZ3R6VjVG?=
 =?utf-8?B?bUluNm9PeDZNSFF2a2NNNE5JdGJZREpucDhDTjA0bTJPV2w5ZmhYcUlzR0Yw?=
 =?utf-8?B?NnhRUGZ4SHdBPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6988.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WnRJRlNVdjlCcDBRRkg1dHIzQnRBS0x4TjVWR205VkZMSjg2cFhTN2tSN3kx?=
 =?utf-8?B?ZkxJTng3UXpwbGxRZE44clBGamVPMXBwRWJzSTdzTE9KMjRHdVlFMWk1dGQ2?=
 =?utf-8?B?NytWZ24ySm5wZHVEUktsYURMdDJlejMva1NPRW5zMHpNc0t2RENTcjd4Nm5O?=
 =?utf-8?B?ekpwNnhxNjFSRnQ3L0RlcVB1Nmo3T2RSbW5mWjhKdXR6TWR6L2hUNUpHODlo?=
 =?utf-8?B?V2paY1EzSzRRemwyRWtUZmo0djM0RXBydkQ2emhQY0J2UTdXWUdFZUdxNTFU?=
 =?utf-8?B?cG01N3l2bldmVEovdEM0bzRjNGo4NUNWRGtUZDdwSkVNYVVRWVlLdG44UFBL?=
 =?utf-8?B?c0FkaExSdjJrOE5mQVVKMXdPOC8zYUM3MFdJQU1GZGFUblZHMnVPbGdMZk1Z?=
 =?utf-8?B?TUt5d1Zta0tWcy9pSUtXWGlxMG10MEsxcnlvVDJRUDFqYnJqRnkrajlMYm5X?=
 =?utf-8?B?dHZGQ1R1eFRqaUg1eW00TXcxU29NRS83YzduczZUeTZMZnlsYmdpUVJjTi94?=
 =?utf-8?B?L3R1VFp6NTM0NmhoUTkzb05FcHliT2RSRTRBZUxMUGJnSS9OYnFxOTBNWWZp?=
 =?utf-8?B?dWJRaDN4NDdudEVPdWJYdDBkTGI1dm9MN1dkVUlDSlhEdGI3YTgxWmhvZ1l3?=
 =?utf-8?B?dldtQmF3TW5rV1JYV0hXNWc3ci8zeDdvS3NYRFFnbUNBdFd6U1dJamgvODBT?=
 =?utf-8?B?aHU4VERtUUNWbENhK085Zi83QXlqRzYzdnhQODM4enAxK0Jsb0NtZHVIaGVR?=
 =?utf-8?B?bjVSRCtvRVk4eUI2VjJrY1NpZkF5Y1hBQXRwcU9ZQkgvcTRES0dyV0tRVlFF?=
 =?utf-8?B?NEhmMnM5clJ0T1lWTi9GazBZMHpyTkdvcEQrSE1rbitaRFl3ZU0xVkFaaTRx?=
 =?utf-8?B?NmdWSTFBeXY0QWp4NVU3VWl2ZGM1TFozOSt0YWduTFZKZ1EreG5sdGdlWmcr?=
 =?utf-8?B?d2gyZ2lqVGYrVlFGcUpjdkhucDdGUjVwaVJUUTYyYUJpbDZrenVWdnBKNzYw?=
 =?utf-8?B?VHJmd1MwWERoSmMybDVjcFM2bWR5K0sxOGZTazdJa0E3eUQ3QWdScXViVDFv?=
 =?utf-8?B?NVk4bHc5ZWY2b0J1QUJoYXRqK1cvc05hNGZsS3NFNElxUEU2NVM0eWJ2RlhE?=
 =?utf-8?B?NlZ4RnhHRTM2YkVob1JVcTNBMWU4c21ieHY0eW55MmExbTlvRGxBbzJMSTBx?=
 =?utf-8?B?R05yd0tHVzM0MWU2REZoTmdteTR5cFd2dVYyQzJtQUlFTUpBTnI2ZGNWZzNx?=
 =?utf-8?B?UmhJMXRRazNUSmt6cDBGRHZTN003QzhCeVlFZUV3U3ptL01TelBiS1U4dWYy?=
 =?utf-8?B?NEVubjRucUZkYitZYjk3SWlLWmVpNHptQndtcnd4Zkh2R1FSS0ZNRjhtSEpp?=
 =?utf-8?B?a0gvdXBkYUpHS0xTMzJ5MklwdTlVMzNZSlB1MkRRR2k5eGtHREluWVFXL1kz?=
 =?utf-8?B?eUxSTy9vc20wMWlGNStMd0x3UHo3SEliY1U5TXR3OUkyc3k0RU9ET0ZjV3Nv?=
 =?utf-8?B?ZnpIVzI5SkhkWE1HVkhIa3NWM0Y1MkF4dnREUUZTblJPK3A5YVgzUmh0S2x4?=
 =?utf-8?B?elBGeE1IamcwelZCNys0K0pHbngwV2EveW56Y2hmWjhhUTM2a3pRNmVlMGFx?=
 =?utf-8?B?ZGpUWlpSV3hQUVcvYndraGxzeVEvTEN0bkI2Ny9OYWR0djVoTUJSU3FpbEpp?=
 =?utf-8?B?ZzRnQytVNXgvVmEvQVR4Z0VZR2k5TGJ3bVBqZkJLbXJyazFIcmJ0R25TSU5I?=
 =?utf-8?B?dmxBNnRlVlBCZ3BhYVUvV3QxT2xSNTBxbXFsSVJwTzVHVUhvNGZjOERxa0Mz?=
 =?utf-8?B?MkI4Um1JZjJIZWJzMlZ1K2JtSnBTMDVGUGUxZ056VGlGTS9YT2h3S0hqUHlr?=
 =?utf-8?B?d2FSVEZqb3F4cllTSXM2M29DZ0VDTHBpaXJOTHBwK2NZa0NlUzM4VDYzNytk?=
 =?utf-8?B?MU9hZ012VHM3dWsrN284SEhDSTlkVzQ5b2w1NkI5N21LRFQ2RHF2cjE5V1hp?=
 =?utf-8?B?Nk9NWjdvbHdWdzlZQ3dWS1V6SWdNcTZLa0lhSjlrOEJITDZjbCtnM251a0tt?=
 =?utf-8?B?V3k3ZnNZOG1qMnVHaHYyajVUdENJWXJtR0I2WldrUTRnT29IU2ZVZkhoUDVk?=
 =?utf-8?B?TTBsRkdHYXc3MGJzalNGSmxGNUN0U0p1cXBrODRGKzZzUzVQdFhVdDdZOEht?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7NCnFTkUi448Wl++Mb4/lIjZkhn6+8SjEOWnADnn4Wv1Zpe341Agh/PSttbvDcmCjVjJTa5AMFmiKNxWAkzFbs3R43XnIMCmHBD9PDo54NqTLfPgXqG6r4vNN4aOB7RVySxHDcEU+18asZCszljh3SvmQK/VV0neQvdUXCSNG+08atInrM+U5RDO7aCsEzsFiM6OQoTrGXOEhf4lDGr6A9DaeWnBch8ADrwpdzAd2BvkjRuC6S5Y/RQNYIWjOzJu0wmcMgrOQAfW3CdxTqLO7xr1UmJqL9g63SEoEAWu1GvgrqSd+elSqqiXu4WgKQ86hhyqbsatiJLFJwjAfXP4wavSBCRyfDYXg6L23rh3gvh2HWkSakXwba+b3tRkVsYm2RmPIegoBW8ciIBnaEbUjKuZsAz1+UiwQJWlGADDBgbz7J1ytR0E4CTk4OpXyqUig6BbBoxie89u37jBJFAKQkG/o87TrAA4slcSdkWmR+GwNpxNRRqUwPQeRcku8Ecgx9CfaTuoopAfWQHAnJ3TrzTfSjY2oXVLoDk+Z7tBYV1uWdvukA7gmp23d534XMmq1OVqoQWagYI5Ic1XDDaWH2tNRpuxeMOtUt8Xkxnv+mo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f477344-dedc-4aa1-9633-08de05df4ed5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6988.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 20:22:59.3415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lLt/+obrCJ7lsIaVXmHRfKEit6f7yOUX+bml1BKI65ztD3IN1i5vRF7M25uOksSHDP21SBEhwDw/k4jzAvnfa9ksOvfqcD18ziJGCYIm/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8126
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2510070159
X-Proofpoint-GUID: OTpV40m4KLXCUNXAxjQiED84QW6N7k87
X-Authority-Analysis: v=2.4 cv=WeUBqkhX c=1 sm=1 tr=0 ts=68e576a8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=tMj_ddulewJ9nrc7s50A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: OTpV40m4KLXCUNXAxjQiED84QW6N7k87
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE1NCBTYWx0ZWRfX999WtfIyML1Y
 IembpeHAaqY/Y9dfWsYgixCxzRu5GLyCi1JXvdEU0I2jTWhZwhbyCGEjBUDycNffbLetmc8Iwcw
 Drw2rtekw8Wb6xIWolUydI9ydUacxEpJJT7UQeTJ6PAMDrhz4QvBLeAh5N0AmB1MoEWZ9kbC5Am
 YRYehiXOeJgR4hi8KcWi43LN6BIknci1yQcR+5NPauYq8jkowJchzq1XrAJf3/j1fSfegEGJipX
 W3cOCoWbFNBrJEQvOzfpbizOk5ZyCJruIJdrj6wi29BhdnUBeJlMP6KJLB166ZfpjtdmErg0Xl9
 Ui7NayGQjiYV2r+n9y4zNInGFiXLPqeYH6OeqtCMvp+zGV7OnRSeYI8fl/SwsXx6/+TV1gLpGAK
 XVrfJLATRLyZZ8kDh26rVUCRAGfgrQ==



On 10/6/25 17:23, Chris Mason wrote:
> On 10/6/25 4:23 PM, Joseph Salisbury wrote:
>> Hi Chris,
>>
>> During testing, we are seeing a ~6% performance regression with the
>> upstream stable v6.12.43 kernel (And Oracle UEK
>> 6.12.0-104.43.4.el9uek.x86_64 kernel) when running the Phoronix
>> pts/apache benchmark with 100 concurrent requests [0].  The regression
>> is seen with the following hardware:
>>
>> PROCESSOR: Intel Xeon Platinum 8167M Core Count: 8 Thread Count: 16
>> Extensions: SSE 4.2 + AVX512CD + AVX2 + AVX + RDRAND + FSGSBASE Cache
>> Size: 16 MB Microcode: 0x1 Core Family: Cascade Lake
>>
>> After performing a bisect, we found that the performance regression was
>> introduced by the following commit:
>>
>> Stable v6.12.43: fc4289233e4b ("sched/fair: Bump sd->max_newidle_lb_cost
>> when newidle balance fails")
>> Mainline v6.17-rc1: 155213a2aed4 ("sched/fair: Bump
>> sd->max_newidle_lb_cost when newidle balance fails")
>>
>> Reverting this commit causes the performance regression to not exist.
>>
>> I was hoping to get your feedback, since you are the patch author.  Do
>> you think gathering any additional data will help diagnose this issue?
> Hi everyone,
>
> Peter, we've had a collection of regression reports based on this
> change, so it sounds like we need to make it less aggressive, or maybe
> we need to make the degrading of the cost number more aggressive?
>
> Joe (and everyone else who has hit this), can I talk you into trying the
> drgn from
> https://urldefense.com/v3/__https://lore.kernel.org/lkml/2fbf24bc-e895-40de-9ff6-5c18b74b4300@meta.com/__;!!ACWV5N9M2RV99hQ!Pm-G5L97VLtQdDRHad16cdOnEwHxyKGHd8U1FSLtAY-oy2pNcbmCjTS1XRjq-ypIoQdJGkE_12KkAr0$
>
> I'm curious if it degrades at all or just gets stuck up high.
>
> -chris
Hi Chris,

Thanks for the quick response!

Yes, I will try out the drgn from the link you posted and provide feedback.

Thanks,

Joe

