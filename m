Return-Path: <linux-kernel+bounces-877691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBE8C1EC24
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4584220DE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E98A1B142D;
	Thu, 30 Oct 2025 07:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="AOkmYw3v"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023126.outbound.protection.outlook.com [40.93.201.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDDA3370F1
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809416; cv=fail; b=PjRamy3XTlwz3IUr0k/7NL10WDh6AYavH0w3LeLIkliEi93qy/hCd8WRagD8SNYBk3agqmWli6MIKNvxZBYO9VeeiJWjqS6unFIe74r4D1NafOGsca+JnMwslQfZbHAlsAOuDDsnqzogWsF68CEgoRbJMXoe3U2vqHtdSSrQT4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809416; c=relaxed/simple;
	bh=c6YqaUINWA4xM3n3FynLLUBqVKWomfkQ+2hJhyjadWQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KOMWzi+tQLYSsegFof1gbuknf5Y8aUOG5s2vy/skkaUhY9Bd//VyhnF55C3hcl6WoMW8QuhlWQX5mIMuk2j7mpUaql25vjkSevl9Ap+UkhGIPyUBD4mBCRffItn9nXepCaUnpBO7AXMZbpsh6GkVGJe84T5MnyNYENzgKJw3yuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=AOkmYw3v; arc=fail smtp.client-ip=40.93.201.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haoEuKZPDj6ukNda8NE4E50sJTEdDBZO4MNrupb6zDmyP5+lYMXO6gPJpOAj8VovKlqvZTN254hszhjmCzhIgYiLXe1pehCuGzo4dnCCqaFI50DRX5znnQAq+rbo7TLbWn4pERrWpJDCPeW4tA5xJY/VGdNsYTdVfu8KgdJiCfQ50lNDpBWqihwAxyb0Xtgh5LoRuf+OaYSmd1V0K+gqkh3ghV1N9w6eyasods4Dvt3dn6XtwVzJook5vrBm4YlDpxooPhMSgIKC7Zwhbzq6grRdqVw+Xk0izMkBbpXJOsAQQDBCjb5UH8IJm8V9+WVvkW8gX0Sx48TiUuTp5qs8sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=By08TWx60lsrdjAX3YFBj7ivSpua0Y0MZ4D1lrSoW9U=;
 b=ePFr8F1tsza1/Fpn2VWDXYbsOPG4HxOIYXuv/MROf9NYPMPzQO+GynZb7vt81mwKMCXi/AEaBNfWkURkzNcRaStHWaRyBVaGrJNtdXiBqiS/+FD1VpLCH3pMk/rNtlKF4TcWvcPp8J9el1i+FtfStx/PtFr4fQDYi8I4wxKCWaUqYFmVwgEOj3ff6uq68l0u3I0B+cIT8g7S6jdIYs+MDSaTPZYBp+Pz4oK26ZeBcUc+4vD1WfdHOK8bPdKY+y16MbXfGRaP0CursTWOcZ+mRe+8Rb3DM6olnq5lUkGQsJKzYKZ41mbX/Wdjq1R1dsGUlmGyLIZtPtGDUCq74fYbZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=By08TWx60lsrdjAX3YFBj7ivSpua0Y0MZ4D1lrSoW9U=;
 b=AOkmYw3vJZYn0U8SsW4Guy0ccY/k4hVZt4IcSnacx/Yxg15MZDTDsGvkICKvIayoBsyQelP2eLjzEEBk4q8qW9pchR7hJ6ZBNr7lnJRFZ1zvblhCAb/G7EwjTjEpT/KGKRMN5MXw72GkF8Sy6728L9FuIAu63K1AWenYXPaKcP4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 PH0PR01MB6795.prod.exchangelabs.com (2603:10b6:510:91::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.14; Thu, 30 Oct 2025 07:30:10 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 07:30:10 +0000
Message-ID: <97d9d369-aebd-4471-99dd-177fa83adbe2@os.amperecomputing.com>
Date: Thu, 30 Oct 2025 15:29:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][v6.17-rc1]sched/fair: Bump sd->max_newidle_lb_cost
 when newidle balance fails
To: Joseph Salisbury <joseph.salisbury@oracle.com>,
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
Content-Language: en-US
From: Adam Li <adamli@os.amperecomputing.com>
In-Reply-To: <ecca7938-a166-4a32-acb4-e38fb9b426a4@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0091.apcprd03.prod.outlook.com
 (2603:1096:4:7c::19) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|PH0PR01MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: 975d018f-6fe8-4ede-9e67-08de178627c1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0N6YXlhcjl3UjdKMmxrcnhiL3doRWIvbmU4aDlwbGJYNGd4M1VjWVB0VHU3?=
 =?utf-8?B?NUV0UWtVKzBkVWM0a2xoNVBvNGpncWVadjlkR2xKL3d4MTd6c1ZCbkNkUkc4?=
 =?utf-8?B?SExFdVRXT1ZwWjhmS2F6elU2NVQwblV4L2xxRCt3ZWFiVUZaeDZsMzkwRnN6?=
 =?utf-8?B?NzhSV0FFQ1BONTU0QllBOGltV2g0TktNWTVMM0RxbXlCbUJaYXpCRm4ybXd3?=
 =?utf-8?B?SHFWYTQrRFN0WWlSMEVUc2V6UHgrc05rSlNoUW5UTjFkaHQ1YmhjZkU2Q0FO?=
 =?utf-8?B?VUxNVVhocXlSa2xFUEQ5ZjdFUytXWDQxaFRTUjZwbm5CVnQ4SUpNcURKVkdI?=
 =?utf-8?B?YzZTVXhPcFdxbWhHUzBQMkRqek5zMHlFNC9vNEtIbHNmbmtqSHU5WHo1VEti?=
 =?utf-8?B?ZnloRzRKNEN2MnBKSml4aFZsV1FDb1YvRlBBZGpWZVhVWGRLSjFQVzJmM3Y5?=
 =?utf-8?B?TlpsSHFqNzBKai9wTWplM2t4bExNSzUxZTBIY3Z6ZUVXNHZDNElwMkJuSy9j?=
 =?utf-8?B?S2x1TlU1NW96a2ZEM2NWS05oU3g0ajQ4UlFQZFVTOEc0YlZzWTU5dHJaYWh1?=
 =?utf-8?B?SUtDa05FYTNqU1FpZ0dXS1lZNWY5cnRLcDJ4aFhFRlJiTDQvTDIzZDlXUWpw?=
 =?utf-8?B?eTdMalBYTzBUQ0w4cTd2ZU4wazBjQklVRUFyN09qSTBhcERDbTQzYURxOW9F?=
 =?utf-8?B?cU5vb1lZQ2Q0dndhRnpsNHhIRVRFRlZWM0FJa05UNk5LRUNZZTc2MGdybVNm?=
 =?utf-8?B?d1dFRXZiZVhQalEvMTEzV2x3MkxObzQrWXEreTg1ZHF1NnJ0cWpQaVZhQXgx?=
 =?utf-8?B?enVuaGZIZXhsT1hxd0hXZ05IT1I1WlpxK2ZpRUNGQmxGQ3VUblNFWFZWYjVQ?=
 =?utf-8?B?NVRvSklKY3N6WEdwN1pHQ2FwYmxWTmdtNzVWRGRLZGtRTmh0RVp1Q1djdzZz?=
 =?utf-8?B?SGU2c0JBdmFBUFVDcVJUTGZNWGpRU20yeEF1NE02NjBEeUFOSVFRZTlLTTBT?=
 =?utf-8?B?MUNqUHltc2xGc1doRW4wajBSRFNIQmZ2QlpwY29COUd3WWliQ1BqQlhzWmRz?=
 =?utf-8?B?WXdmSmVPUkhCWjdaQkp1bC8yZlJmNkdGUm9MNGhpZXNYTzJpenFRUHIxS3Rn?=
 =?utf-8?B?K2ZXUHFVWHJIWW1NZHJGYzA3NktabzVuWGw4ZEM4ZEVrTVRTdnBoNm95S2oy?=
 =?utf-8?B?bFRpMUduSGtxc1M5aUZJbXdQUWN2TUQ2WVhnY21QMENYdmw5R3I1NzhvV25Q?=
 =?utf-8?B?SlU4NElKd2pReTlZb3hscTMyMGlRZVU4WVhsbDVZNTFlTE1VM1VzR3kyNUtI?=
 =?utf-8?B?cUduZFFIT3l2cENHSitwc0pjd29qS3ZXL3Mvdm9HTlF0cUZKYzNtMDM1c3d2?=
 =?utf-8?B?YWxQQVRkc3BRekd4TnUwWFJ0V01pdHVSTSt6Vm5nOXpBMWhsbHJ2dmJqUUR1?=
 =?utf-8?B?cnRTMCtaU3c1MHRiNFVMWFZJTVBqNjhTMmlhcjhaT01qa21md0Zzb1JxVkw4?=
 =?utf-8?B?NWZFVDR6aFRIUXdjNUt1Slc1Z0twQW9EOWRNSHAyWDZ0dVJVekpVcE9maHhn?=
 =?utf-8?B?NENqdTF4VS9jTjF0enRKR21HV1FBM1h1UVZLWUlrbGI3Mkt2c3VidEgxbjdp?=
 =?utf-8?B?WUNORVRaWERNRlh4ZTMwVkNGd2h6MER5OUdMMnZkSFdEeTgyd1Zia1cyMGlV?=
 =?utf-8?B?MElrQitxWGN4ZnVCcVE2Y3FxUzZCWGdPMThzaWFqTS9HNTJ5Yjh5WmpSUkhM?=
 =?utf-8?B?SXNraG1ncUFaVmdtM28zZysyeDlSbHFGb2tDS3hHOVZRYS9JejlLNC9LQkYx?=
 =?utf-8?B?R1E5K3p6ejlUTFp3UEUxMEh2Mlg1MEpTWTBFRFRHNFgyMGdGc05rTWI0cUln?=
 =?utf-8?B?T1Q0ODBmWkp0SHp5cXNhenYvZDA1TXlCdXF0UDBDeWJLcDkwUlVoVm0xQ3V1?=
 =?utf-8?Q?awtfjLZ36xQ9LVkMfrE16INXZJ+zvbXe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vm5qVjlOYjR5MUgwazR6VDM2a2dSWWpvMlB3VmdYeTZvekYwVHFZLzFmd0tN?=
 =?utf-8?B?ZUlEQUUxdlpIM3M0TG5wb2RIQ0J2Ym5BZVRaSzlTejljTnlqZW1pTWFIMG84?=
 =?utf-8?B?aHRJTUo0NG5PSVJJcEg2bSthVjNvaUdzMitPTjFZNk1TdFZDQzk4S1lURkdU?=
 =?utf-8?B?NkJWVU5idXBnS1I2V2lWRWd1K0xpQ2RrRDQ5ajFwWVRFN2hsRHhCd3VDVm8w?=
 =?utf-8?B?bWdqNDN2clFnK3pFSGt2UlR6dzN3RUE2eVhGd2xMNHBsU2p2NjNKdG1UdFdJ?=
 =?utf-8?B?cXV3QmJ1V1hXVE1Jbk0xa0lHZURwblFEcGRSZ0tBOWFOcUhtVHV1N1JtQTlP?=
 =?utf-8?B?ZVlSWDdHUEZmUmNzU21QSlljOEQ1YTdkUy9ZT2pXM0E0QStsWlRORWlNbXlw?=
 =?utf-8?B?Mm9YckNSczRrTXpIcm9INGxqaFhNc2t4WTFoTmkwMVpKMXRTcnRkdWZoYTlG?=
 =?utf-8?B?R0k4aWRFY0Q1UVNMaFVOblF4elgvNlJOK3Bmb2s4RStIeVMxRHdCTEF1RjU2?=
 =?utf-8?B?M21qcWlIUXdFdjV2bmZtNlloVGhqSHhLMEdjOTRjRlZCT2VRN3drNVM1MVI5?=
 =?utf-8?B?elJTOGlTWWdVdjQxU2IrbkVVTDJoaWlXZ2JqN2E1eFptSjdtUDVUSVJhVUtW?=
 =?utf-8?B?R0VoT3N6YlllQkpzbWE4UWtWRzZoK0FveVFtcmxIaU1EbGE4SWdKNlJlVDJl?=
 =?utf-8?B?UkxuV2ZCL2hpRmoyS0J3VmNVeWlZaHg5NGkwWmszME9rcjZQMTBBL0tFajFu?=
 =?utf-8?B?MHFtWFFlVEdVNUt3blI0NDhSMTR3Tm84MmlTZitFSXFPOS9QUGVwZ0RjbTJZ?=
 =?utf-8?B?UEU1c1VoTHBVT1VoU1hoOHFvL0FiKzBXMWdiWWRwMjNWcDUxdDdJMiswaXpw?=
 =?utf-8?B?WTllU3ppYTR5b2Y2WStEVUprSCtBZ0pOOWNMR0QrbTdKSW9JTTdLUEE3LzFi?=
 =?utf-8?B?OW13TFdULzlNWUMvdmEzWldPblNBSUpLc3dpNkVzNXFkOVJHT2RGdFlsMmpC?=
 =?utf-8?B?UFBDcHltZDJxd3BpVncrVFhGcnhCY0gxQVFReHpWbG43bVpGRzl3enN2eFRs?=
 =?utf-8?B?ZGZ6aFZLdG9wK1gzT1NONG40d25IOEtUQnl3N0kzMXdxUjR5dnBUTHVsVy9u?=
 =?utf-8?B?cEIzQXIrVUxKN0FqZlJsaG1Rb1NjRSsvbmVrMVBPaTlEcU1aZmZSd29hOWdi?=
 =?utf-8?B?eUVRcUVneWNPUjI5bkZMa2dlUlVjVFBtdUU4OEtOWVpHb2ovYXpPdGEvNE1U?=
 =?utf-8?B?bm50WHBuMUIwSFJBNEJSbjBrdjZjUlNkMnBxVktocnRJYSs4UG9wY1kvUzRz?=
 =?utf-8?B?L3k1aW1lRElIYjVqd0ZGYlBSQUh1Z3IyUW5zN0lta3hTb3VsNkxxcmNTNFFr?=
 =?utf-8?B?TjhnMkxSdEdDVVRQMi9KamxSM09ETElJTmNib1ZaQTcra0xrQ2Y4ZDEvYmxQ?=
 =?utf-8?B?b2hwZDJUeVVQeStBRVQyOEd3WnJyVXdxVVZBdzFaL0N5SVhsMUI2ZUpWcWhq?=
 =?utf-8?B?K3hITHJKOGhFYXN4ZnhmdHJoZjRGdFlZa1J4cTdRaEJxTmpWQVhvdWk1ek1o?=
 =?utf-8?B?TGtyRFdGLzBWUm5DdE1KQ3RBSVFVNkFPTXFWVExxSWdhT25CSlpaVmJGZkd1?=
 =?utf-8?B?UzJrNDhyVGtYRWZkbUp4Um9YaTVOOUpLNTlhSms5dEVRYUJvUnpWdytDZnE4?=
 =?utf-8?B?MGF3aVNzWGpuNExad1dNbUN6VnB2Ry9YVjkyVHlOalhDSE13N1B5U2o1YVcz?=
 =?utf-8?B?SVc1VytHSE5NNk4yOGpDVnpzVHAxWThsV242WnVOWEs5Mmk4RUs2a0NsMVpP?=
 =?utf-8?B?QUlkU0RsVlJWWjVNMlBRTTFIY1djODlIa1U5L25DY0gzNUhJQnRqQ09LbUp1?=
 =?utf-8?B?b2YxRGtNeXh6TFg2NnNpZGJMYkhLQzg1ZDJTejg2b1hBK0hGTFJsNWxVSjBH?=
 =?utf-8?B?T1hLMm85bk1jVTl1NHF0dG5uOEZKVlpEekg4Wjg1SUFlMkV3L0lYeG1MU0d2?=
 =?utf-8?B?eFcyZXB4VG5hRGg3ZDZxVnNiSHBabjQyNndJaTJjcG1yeU5lTkhVV0YxckJK?=
 =?utf-8?B?R2dSVWNIT1lUVUI0V20yK3dPd01vMlE2UnIzekg5eEV4ZTI1bk53TCtOanc2?=
 =?utf-8?B?OTJQRzBWVEZJYTdMeEU0NFdPc3orZXB5VHhsbWJPSXJkVEsrQ3FOa3RYTlhh?=
 =?utf-8?Q?eQwgQw9NKQHIUcU873JW8ag=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975d018f-6fe8-4ede-9e67-08de178627c1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 07:30:10.1440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hD84TfbRPGRpgQnwIHzcGxcDjvSftts0sqkYDyGG2QYeBoosS/sn3Jw6g4E1LASKfAMFSzyI2m0dwuhn5wxPHChRxJ09qClLE6mCQX6qHRtTExW6EslYCTZ0MybGwNPP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6795

Hi Joseph,

On 10/18/2025 1:01 AM, Joseph Salisbury wrote:
> 
> 
> On 10/10/25 13:09, Peter Zijlstra wrote:
>> On Thu, Oct 09, 2025 at 09:04:40PM -0400, Joseph Salisbury wrote:
>>
[...]
>> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
>> index 3c12d9f93331..5ded210701d0 100644
>> --- a/kernel/sched/features.h
>> +++ b/kernel/sched/features.h
>> @@ -121,3 +121,8 @@ SCHED_FEAT(WA_BIAS, true)
>>   SCHED_FEAT(UTIL_EST, true)
>>     SCHED_FEAT(LATENCY_WARN, false)
>> +
>> +SCHED_FEAT(NI_TARGET, false)
>> +SCHED_FEAT(NI_SPARE, false)
>> +SCHED_FEAT(NI_RUNNABLE, false)
>> +SCHED_FEAT(NI_RANDOM, false)
[...]
> 
> Thanks for providing the patch!
> 
> I performed the same testing with this patch applied to a v6.12 based kernel.  The performance regression still exists and is slightly worse.
> The drgn stats are attached in a file named 'apache_drgn_log_NewidleRework_From_Peter.log'.
> 
> 
Just wondering, did you enable NI_TARGET feature?
It is default false in Peter's patch.
In my test 'NI_TARGET' can fix the regression caused by commit 155213a2aed4.

Thanks,
-adam


