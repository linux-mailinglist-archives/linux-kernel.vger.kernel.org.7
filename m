Return-Path: <linux-kernel+bounces-885333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360DBC329B6
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10880468585
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9675433E374;
	Tue,  4 Nov 2025 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fCgtWAQN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Nbq4qdba"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0F1329C5D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279935; cv=fail; b=okDuiqxQ4fNNi8q3BsBpTpQbzXaChoU1DGrAECb2M7fzuHFcth9JGv2pNELwztAutwFz/5bgxKq1PKy4kKfurEFMb0E73bFsbBTtJhh7C8un0Uu+hegly06MaINUfiXzlOXqlCXOn8+EGZpaIEBzn2bwxUg8Fb9ekJqj4KbV/AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279935; c=relaxed/simple;
	bh=JZTlwVGKMQY04pNmGWl1EHyszwZbkhTgEM1QhfPKFBM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eVAvECw+LCSohZwanVJa98iW90cXu/+V0TbUj3iIPW6peo+TYeX941/E70UkKOcLKMXyq+Im28Mk13SSm0khQVvoLo8uXeheV3lN7MkkJvNPg6Aiv5TFtpoRcUtPleEKopCTdBwf0jAD4jLrSA1Y+p7ZB2fvcMAWSgebEZfPpec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fCgtWAQN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Nbq4qdba; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4I9HI2018682;
	Tue, 4 Nov 2025 18:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=YFl6cuDjVW/X7jYFr1hzhL0IBwyxAtXrStLW3g2Fe2A=; b=
	fCgtWAQNTll8mbHntpijNzzWebSDwRjqj/rEbwxZsHAjWBZNi7wKv8PCl0W1mXQs
	mHKGC9FkGGv5y9vW/o2GgF00CDaHVnX51MGRLpnhuMlGWVm0U2q4YLe+rvshB2/6
	gi8Nrp18yv4iawmjlP9deXd8hEBnjPuJRZS+9oDmpsgXzIJXpzVj4pOH7DoxWCC8
	H+cCnWDPuIP0Scbs3mjTUp60gpAVtoto+j5cimB5FDD8xtlD3QAGffE3o2jlxSPO
	fpGKl59KhuTho9cYB6MJXF/hQVp1XNr/s40m5pkaCGT6bjynTRusKopDQIDI/lQj
	imz5HXxHgk84PwKF7QET2w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a7ph2802j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 18:11:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4GhxKD019528;
	Tue, 4 Nov 2025 18:11:48 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012053.outbound.protection.outlook.com [52.101.53.53])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nkqyu1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 18:11:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4m7fGNbj0ZO/TsPueP5JaViN8Q385YV7d79nRP/6SsE4TeC4zLJw+9yZTGGH3t4MXrllSe0JUlGp9uI19ojb3cEFz5k0Iv6pmb0ISjifEUO1ak0MdvLDo1Afd+ZvmSp+3qK7vUNLqXQtq40dd4yOu/Eg5+yKuKJ5QaBOYf5NqFqWvhtOwo3s4FwO4bVvwAn4MeSIcNmwBWn6Z3FwE5jn4/hqu4Up5zZelOY63fP8NiEkVfMfvwA9XrKmkCvlmehs84hrd9b74AnxfALYWlKyKRRfkqYGy3l5/2uycxNxOBDvqjC9ygNjsJCDwJ06C3mNw4xOsm3fHTfyfdK40lT1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFl6cuDjVW/X7jYFr1hzhL0IBwyxAtXrStLW3g2Fe2A=;
 b=vaIhrTTzxMLWiO/eo3UXfWA5WKLiuz+xdzhXXW9BiU2nHBXB3cvAPKl3A8BLe8ZhHRF9qT05/LM4WZUkGBfxTAs48gfrY6BM9yESLDwH+Qhm31lFDDGylak7bcLd9/biTuX1so37QU8DkJvso1gc+sR4HQDHCOgs41vwzxqIepDRMY9vatQCtAJO53L6g0Gx4b1gN41tLWHQ3oUfvyhoEl0l/N0Vljt5V2Aftvyolrg3/q7Ce6FIKjz1D03psamI384r8Fx2PuxjDu0jMKR7HNY8WArlmzxAba8P7qcy+zj6r/GeU6ayOmQKhu+UpY8Jkd6WUVbOw+5YN3BghnITgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFl6cuDjVW/X7jYFr1hzhL0IBwyxAtXrStLW3g2Fe2A=;
 b=Nbq4qdbawDqNqlKtUtPOlgXdz43nsQbHqdpfx4/Y20kbgXhHDLXurEZhrXRmkyechfq2DcW6glirl+9KCvYbxX/sopO3f0FsifRx9ciwX6QV3b0tVSxF4NYF4T6P+NfUcNJ6UH2Cep12d7qEfzO9xA15rbAJDFNfPAFpxlIs/hE=
Received: from PH7PR10MB6988.namprd10.prod.outlook.com (2603:10b6:510:27d::5)
 by IA4PR10MB8544.namprd10.prod.outlook.com (2603:10b6:208:56d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 18:11:46 +0000
Received: from PH7PR10MB6988.namprd10.prod.outlook.com
 ([fe80::3432:737c:a431:7edf]) by PH7PR10MB6988.namprd10.prod.outlook.com
 ([fe80::3432:737c:a431:7edf%7]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 18:11:46 +0000
Message-ID: <b113f554-f14a-4285-950d-0c645029ac2a@oracle.com>
Date: Tue, 4 Nov 2025 13:11:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [REGRESSION][v6.17-rc1]sched/fair: Bump
 sd->max_newidle_lb_cost when newidle balance fails
To: Adam Li <adamli@os.amperecomputing.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Chris Mason <clm@meta.com>, clm@fb.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
        LKML <linux-kernel@vger.kernel.org>
References: <006c9df2-b691-47f1-82e6-e233c3f91faf@oracle.com>
 <28340138-a00e-47bc-a36f-270a01ac83b4@meta.com>
 <20251007113459.GF3245006@noisy.programming.kicks-ass.net>
 <36545e62-9947-43ef-9bc1-776f5663a45c@oracle.com>
 <20251010170937.GG4067720@noisy.programming.kicks-ass.net>
 <ecca7938-a166-4a32-acb4-e38fb9b426a4@oracle.com>
 <97d9d369-aebd-4471-99dd-177fa83adbe2@os.amperecomputing.com>
Content-Language: en-US, en-AG
From: Joseph Salisbury <joseph.salisbury@oracle.com>
In-Reply-To: <97d9d369-aebd-4471-99dd-177fa83adbe2@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:510:339::15) To PH7PR10MB6988.namprd10.prod.outlook.com
 (2603:10b6:510:27d::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6988:EE_|IA4PR10MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 2867a915-3d85-41c0-7613-08de1bcd9d91
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VnV0bkwzL2JzUlNDeDFpdmorWG5TUUlTZm82NTRNOWJYcUlCeVF5T2NvREFv?=
 =?utf-8?B?SENNSFNRaGNiMlJMOG1lQXhkcmFUVmt0bjJ6UG5RaVlUb0RTS2hQbGFvdkVY?=
 =?utf-8?B?VFIyR3IwNDFKbTFYSHkwSEJId3BNV3VNRWZrQnluVTBSUFZvYjBPVHovendM?=
 =?utf-8?B?bjBwUzlnenFPODVtQkd6dXR0YzhBYTF0WFhGQjVDQk1pRVBKZzlZaFhuWERk?=
 =?utf-8?B?MERSTG9yYXBNcjFxUTBLemZCalJMTlJ0ZldZSVZ1TnF1ODZRZVh1RXRYbDBH?=
 =?utf-8?B?R2h0eEVQemp1bGxYSXE1V3g3RTBtYi92RWh5RjVRNlFzUmhxa3JtNzZoR213?=
 =?utf-8?B?NnNTRmhVd0trYTRLd2F5dTNmNDJEMUhjN2pUQ0VXQThUaXdPSTVYRHhmblVV?=
 =?utf-8?B?cGR4LzA3YUVDM05FMmllMEhEWGlHbkNoUStFbFdQVEt1cGxyODFYdURmbWQ3?=
 =?utf-8?B?dTgzZy8yNDVNNkRoMmY0Tjd3TjAyYmhlSUloVjFtQS83T3FNSENsaXg1MzFX?=
 =?utf-8?B?UHl0U3JpY1l4YlY2NU9JU0RrSkZ6ZVhJU3QyUFR4MitITnBQUzg4Y0dwY1dS?=
 =?utf-8?B?bXAzTi8xSnJkQWJ2bTFiSy85OUpIWC94aWpaOHBsTGR1Q00zeHVlTWUrcVhv?=
 =?utf-8?B?Nm9KeGlHNVZzcU9RTXZUUiszMG9ycHhxZERRbFk0bW1venJzMDhlTFNKSHdl?=
 =?utf-8?B?UnJ3MGpabDd6S0RkQzUvejR1VFNaSG4zdHAxaFdsY0xjWFhhNnVuMjM4Nzhi?=
 =?utf-8?B?S0hkRms1Q3FrcUF6K2I1V09Ja0FPaEdTVldhVDFjTGV0K09zWUkzZy83Qyth?=
 =?utf-8?B?ajdiSW5lRjFQUHNQZUhlTWE0KzJkLy9iSFlVODNZdCt2b2V4cG9waU5UOU1z?=
 =?utf-8?B?blJ5OUpHQnpvTTAxeEhHOUxXR2t6M2JIMytEZFNEdTdQeE9IYnJiQnpxRWVD?=
 =?utf-8?B?ZE9QejdERGtUbWNhcXJLc3pKMkxkbzJOQXBESDlHR3U5ZHVLMDhJZitNOVJT?=
 =?utf-8?B?U2pWTzJKSVJUbzdXK0VIeGhuVnlaTW1jbU1FQVowZDY4cEZuV1BvQ0xieTY4?=
 =?utf-8?B?eVo0Mk9tNmJnQXFtVjA4bGdEUDZyWEhSaVcyOTJkL0szZVVzc1AxaUlFSWlr?=
 =?utf-8?B?aXNPeHhqQ0FpUjZCR2lmbisrMWMxZG5WbTBvdkdxUjJXM2FEbGprVFRLZ2ZR?=
 =?utf-8?B?U0h6R3A4NGpnTGlHblhJUFVVelVvRDBZL3RQTi9teHBYVjFmOHdZa1lPVUhP?=
 =?utf-8?B?eHR5RVRtNWZZeFJrWkp0MUxUajRocks2VHFGd0tiZ2Zyanp5ZUgrNGtoOU5n?=
 =?utf-8?B?Nk5zQVdoaE5qbE9iOXBFYXVFbXE4UWJ4bzVKQnpmK3F6UHI5VGRGVW1YL1Ux?=
 =?utf-8?B?RUROVFg4aENVM3gzZUtCczlWOW9BcW1PelNzQTZPUlJFRlRUcHltdkNHdFVv?=
 =?utf-8?B?WFFncGVXWnIyRlFiQTlyekV5Y0JqeDRsUTdvWHNVN3V0b0ZzQWdISC9jbnM5?=
 =?utf-8?B?QS8wMklzT2thL1ZBSGgvSjdMVFViVENvVmlLTzFuaDhLeGNGK3FJVit1cUJH?=
 =?utf-8?B?blE2S3RHVkE4YndlN1pNaExSZTV1dkhyUjVaS2ZTelVDejh2T1pEb0JmNDlL?=
 =?utf-8?B?SitvZm56UFE3RkVIUnJTNG03eUU0cDFMQ3BNNElDUXVsOHV5bU9VOHpldVJl?=
 =?utf-8?B?d3ZzVVNITzdwc3lONWgxVkxuWVBwcmszSkJMZUd5ME81WEdxb2tFZUFWUWV2?=
 =?utf-8?B?ZUVlOElmR1JHVjlYZEcxZ1o0amRMa1hXVkJqTGRnVFNDVFJaRGFib1FaQm5Z?=
 =?utf-8?B?MFFhd1d6VGhLWE1uYVAyYWZRR1o2VnRwNC9YV3J1bVE4OHcwVEV6SHVoY0Ji?=
 =?utf-8?B?ZUtmMnJscjRIcXJxS0J6UVNRZDBGMGxPQVJzUlcyNEp0Vk02U2pOK0UxVmRk?=
 =?utf-8?Q?LWm/EVc+DesSRpUcRHGQqe3SIqHZAoUU?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6988.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Z1RNeFFLanQ5YWJ0dWlMQjEzMXBpOHV3ckN2aFhjWVFUdWcxMjI4NlRuZGNL?=
 =?utf-8?B?ZzNoVW0xNXZla1MzL2hxTlp6bCs2dVQ3cCszZkRrUWpTbEt0bTV3dFE3RENa?=
 =?utf-8?B?WlNoUU9kU3U4cW5DWlB0VzlvR2VvL2JLTDVtaFdjZEZKOFl3cnp3NFBIT0Fj?=
 =?utf-8?B?bmFQcWkzRTI0cFNHU0R3dXZYRjdMYmtwd3VMUnN1VVlZNGRPMHpQbGp3S0Zp?=
 =?utf-8?B?SkxTSkYwdVRmRGxSSW54QVM1WHBRWnprVVFPOUlBUmxUZThtc0YyanlkWDFs?=
 =?utf-8?B?MVpSYzRBMEM0SERWYVFWVFgraW91VUg0OGhma05EUi90UzlYZTRGdHhvK1JL?=
 =?utf-8?B?QzNzSm1zY2FqbDRvL2VycFVSaDNpNmpyQi93c1E1dEN3YzZiWEdYbjMvL3k1?=
 =?utf-8?B?MWlHL1dHejFacmlKRDFmajNaa2Nhc3Byc2h4eW5PWU0vdHZGc2pSU2h4dG1N?=
 =?utf-8?B?ZWRDTWxZNnI0dXA0VUtLUTBEalMrUUJHbTZoZGx5Q1JGbGttd3RzSzIzbktK?=
 =?utf-8?B?MVhuZTBoUTNoM0hFdUxya04wVUpZdmJvNUdlNTJGdVo1ZmRqeFBuMUV4eFVl?=
 =?utf-8?B?V2dqbXRaZFc2NG51eWxMRlhFbCt0Y3BYWDBoZEw1eXRCK1BYS2EydU1Xek1D?=
 =?utf-8?B?eCt0OTlSVWZuS0cwL002UVZuLytRSnR4cXJMTXAzd1picURUaXlISndRWUdT?=
 =?utf-8?B?U01lZVFKVHJ5bDcvb2xsc1hPbml1azhhVlRxRERLZktQSFV0bGRBR0xkT0tE?=
 =?utf-8?B?eHc5OEF0L1MyYTUxRFhSc2VnVmdVZTNUcDhrY1BwWUlCUXpsUWJ0VEUzZVlP?=
 =?utf-8?B?SmREY09vZSt0UFhHMlpkUGVmd3BmTVRSTUNnSVhpUGNjY3pPb3VoeTk1Kzd5?=
 =?utf-8?B?amUvTENmb1JybnJlVWN4K1IrMEFYSG5uV3loQk91RXdBZ2R0bmk5N2dmK1RY?=
 =?utf-8?B?cmU5L0YyS2FpK2tlZVl1Yjkyc280Q2kvUEY5dWpOQzN6eTd6TE1mL002eG5P?=
 =?utf-8?B?c01NYktYcFR3aGxuYjZ3NDIvYXdteExzekFWNFpXRXhHRWpBNUhLdFE2dlFD?=
 =?utf-8?B?MGF5UkZRWW1yOHZnRm9SYmpKckJYdTNRRXk0ek1lQzMxS2tQdTJFOEwyU3VC?=
 =?utf-8?B?Z21xWlNPN1JjZWY3ZG1yWm1vdE1hUFZrNW5Kdjg0MG1Td0l2b216dFFjWUor?=
 =?utf-8?B?UWpOV0R3TE1KdlJNOHY2VWFzbnBXdjJEM0ptRWU3aGc3R1FmREdHVEFTSmpE?=
 =?utf-8?B?VEZCdkNSRTJ6S1hjcDBweTV5RnlVdzlLYVZtMjRTQzJKcmtKbmxzTXI4QSty?=
 =?utf-8?B?K081Q09QOUZaZk5YMDBUYzZMYytaNUIwZ0RGWEdxMWYwVUhYQzJXMTk1Tk03?=
 =?utf-8?B?WFo0R09CbW90WXZKSDhMUEczRnR1Z0pNNkFGZ21rSUgvMzYyYWdGWWNicHd5?=
 =?utf-8?B?bHdEN0lPaVY4eHhrUkZOdjlQYXBoT3hQUW9xejFkbndzTndxRGNHZ1MwaGZk?=
 =?utf-8?B?TTdGU3hxNC95N21IdXdheUs3ejVoUytKZmNNZ291Z011RlZyelMxOE1vWUJI?=
 =?utf-8?B?a0g2djJMd3lCR0xXMXhsMUhZc0NZM3dBUkhPb1BpQXNTdCtDc1RGT2U4cTE4?=
 =?utf-8?B?N1k3K1NlMHlQcXRGQ3NybUI4R0dUS3dHSGhFdzVQeUtzc2orWFBkVWNaNldt?=
 =?utf-8?B?NWRpa0ZDNEg4Q0V0NUMrSFgxWDltWS9zMEZhaXNCQldzRVc4OEpxRlFydEpv?=
 =?utf-8?B?RHZnLytwVVRVUm03OCthS3lmOC9mZGFjVDJ5UnhHakZrNGx5dnBpWjZlU2Jx?=
 =?utf-8?B?dHpPbzJmU1RMNWxEazVmK21ac0Y2eTNzS0pzcFoxbUlKZjJQZ0RkekxVMXJG?=
 =?utf-8?B?OVlmQVZuTGZNR2xsTmNIMUJpTHd2THJqWDRyc2Y3WUFCdXhSOGFEbVRpOTZL?=
 =?utf-8?B?UzRZNFdPR1c2ZVBsWW9RVzVPekZJRWtFQmxVdm1qcEY2b2JYemZlcVN5alIw?=
 =?utf-8?B?ZG0rajgwd2R0N2xzUU9kZTg5VW80M3BzNTZFN0FYWDhDYlF0NEMzeTNsL29s?=
 =?utf-8?B?UnF6ajZDeW90RDdmMVZlWnJNTUNGaWFIY3lsRVRhTHBKN3NvaEUxS1pRYmFI?=
 =?utf-8?B?RTJVdTJ6bXlGUmVldFFFT1ZXcWplRnlZcDJkTFNCeEhCZE1BQm5SNFFpbTFN?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v+egfM40bDDFLx8v3bjHkR1eYxuxl5/Lt1M46rnvxb/b+ENaoTkAf1nGYDHPf/YrkY1nWvRuWT/lEhg5CHjI2qslTCHR5796tj/3CArObo4RokPemHPxoZCbbHCOTqZrtgcK3exq2o+jO4odU1SGNoYFMrretLEiTFqJrLNUSBTL6zuu8uL6GHDmtVR1MnSUHYsHe5tYgNQ8f/e09wKx1iWe9uh7Nko7nyV4cko58Xs1/zet67j8MVyso5uZnheY2Cks48QO6fyO61eehAFAYDlvI4iOzlhL7fj0eN/kkoVdo0LXFA6nFFBeRRJt2t/cI1pYc+dCoi5KM/A6gFtfRFrKZeoVZuuziOR4bXTKrFSl/H5fsFyxyCuP5nZnU9EwGlh4EYiBQs2B3lEGCMt2Yq0f4sZwZWs/XfRWTZfj1hUS4aggQ+2VbSyctCSqW/9puPSpIQk1y4idJEeG57sqAM/auhIb+lcjNytZJZ8cTbDvapmUeylvkZPPiexpgNaExzg3LWGoE0XKlLqdt3mmlg9w65KQ7+mldXH8BQFQBw4o3mejJDXsc2JmH918Isw7IQcE+hK19gFBtw2Y7trb4TdftxvF5eIaL4UMf18Ah5M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2867a915-3d85-41c0-7613-08de1bcd9d91
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6988.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 18:11:46.0761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dEdZlnN6KSZCSLaYRyPgdP4jmUdS15SV6Zf0kkSKKD1wQOx6F+LWKTshbTyTVsdmsw/bB3ac3IcsLZjKHHqsGRkapVnsVSsBYPcqx6Jq2rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511040152
X-Proofpoint-ORIG-GUID: mTj_6avWSSEMuwIYUHVMjoNQQwsZg9tM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE1MiBTYWx0ZWRfXzulo+zkVD48r
 /TMLsvn+0X9YoQzoXkXaGnPXbTJvwM7tObwk+5lQT9FPNPe5UtVZGwgqU3q9H+Kq3NTBr5fSoYh
 eILTzc/8JliMDwwwJiCmk245gEYCVogSHbg1abJxEueRfCI2dw8K+Y8hDA8+ARZ/EBw+UtALblD
 7ps+BFUWBPNaoOTOFP3l7E1k/ZwqTj25f5zFYBjJm1saUxiDdX8j7qQlXKAsDhLLiI4q5GYgBCx
 a7gwvr0A9EX0pmf+5cUVhfY0+7SzbQrEuYfCdv5qT+BrOeWC9hQrjenCwqZYnsm2E6lDpmHakaV
 w5lHrEyj0E9fd0jHGMKnrwlo0ntG4qFlEk+Gbsn9wI7iiRNoITisv1xrUF3cBl/DV9CXHErdU+6
 Jg0GTRNgrSy4HiKrNw7Idhy7LJnhF1JynRwrSi9YJtApPxY41IQ=
X-Proofpoint-GUID: mTj_6avWSSEMuwIYUHVMjoNQQwsZg9tM
X-Authority-Analysis: v=2.4 cv=N4Yk1m9B c=1 sm=1 tr=0 ts=690a41e6 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RGnG5d-m14Jcu087PskA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12124



On 10/30/25 3:29 AM, Adam Li wrote:
> Hi Joseph,
>
> On 10/18/2025 1:01 AM, Joseph Salisbury wrote:
>>
>> On 10/10/25 13:09, Peter Zijlstra wrote:
>>> On Thu, Oct 09, 2025 at 09:04:40PM -0400, Joseph Salisbury wrote:
>>>
> [...]
>>> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
>>> index 3c12d9f93331..5ded210701d0 100644
>>> --- a/kernel/sched/features.h
>>> +++ b/kernel/sched/features.h
>>> @@ -121,3 +121,8 @@ SCHED_FEAT(WA_BIAS, true)
>>>    SCHED_FEAT(UTIL_EST, true)
>>>      SCHED_FEAT(LATENCY_WARN, false)
>>> +
>>> +SCHED_FEAT(NI_TARGET, false)
>>> +SCHED_FEAT(NI_SPARE, false)
>>> +SCHED_FEAT(NI_RUNNABLE, false)
>>> +SCHED_FEAT(NI_RANDOM, false)
> [...]
>> Thanks for providing the patch!
>>
>> I performed the same testing with this patch applied to a v6.12 based kernel.  The performance regression still exists and is slightly worse.
>> The drgn stats are attached in a file named 'apache_drgn_log_NewidleRework_From_Peter.log'.
>>
>>
> Just wondering, did you enable NI_TARGET feature?
> It is default false in Peter's patch.
> In my test 'NI_TARGET' can fix the regression caused by commit 155213a2aed4.
>
> Thanks,
> -adam
>
I ran some tests with NI_TARGET enabled.  I can confirm that Peter's 
patch with NI_TARGET enabled does regain all the performance back.

