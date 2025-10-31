Return-Path: <linux-kernel+bounces-880840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5436C26B03
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 20:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34B1934E73A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEB62848B2;
	Fri, 31 Oct 2025 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="UXUmFwVE"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022132.outbound.protection.outlook.com [40.107.193.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38073A1CD
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938248; cv=fail; b=I+BDRJ1w6/RRxFPOe0AE0PKEoAyXDFbdPlJ/YsKlh/YHqNfbODUcBeHHHWbF1Fbx5YJKoUkHBCnq4TH6LfS/z9javAPugICfoYO4e1+Ce50Q0yMeIiM/WZrOIVY1aU4tJkQ/9mZJ21/KV2c+fdIkHQ+A0LbTR5+zTKSRyOMNyMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938248; c=relaxed/simple;
	bh=tpf1zhvYEaIG3EU481fBikaR11+lh9dx+dVZys0e3D8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O9dq6/4b8oTf2A1H8ms49P3/SyUn6s9so9qmjai0lpsEkNqfJMGeWjQ16Nmmq5PQWqloGermkNTJSiWU58zOK/h+OIzJ9Iq0579bfsMVHGbKyUHLdRsQUNgN4vp1uvKM1fOH/3LJJTHIpmleOMZfi010L7/Mvjx7PjMbjmcB34k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=UXUmFwVE; arc=fail smtp.client-ip=40.107.193.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrJpwn7AnYqrOhaomreGGtMMSQhmPB61ikykcfGpvWp9cQVS5+EXIyE2P6jH174R/wlrmLrlkeM8Fpr7ofCIfnaTFSlegEJAz5RMcnSuGq0IcFGQYC0Lbu1VI/G4CsAKRusLWPLB7oKufxLB6To9vTqiRVUcRqkkLygij3LykIc1cdm/sLSyg/NLv5PQC7uaudmYnoG+5FJLrJRnIwwVkjCHx9t7oO15sxeL1S+yN605Efg7HOiqnqaTDj5zJmhSBYMkTBulOxDIkDGra9w+mUIR1wqu/lLkLlwc1qtE/7+P69vItbVSY4f3edgY8C73yL146rMF7kzCo5BuI3nGRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmbCxJU70RKr1KtEXfTZMpImUptPsGyfQ+YD2Fx9u6o=;
 b=lLLOkFic1+GdLhy0lWtPHL10JsvtCSixtSwiTi5VOO12v1dY8aNVYvoLMNEgE6lPc7Ah+M/VAwS+vEAhVHkbOsLHocP5XQQZ0lva1Cka0fxhTS5YinxPxgPC8NNBLejqpAho17RRQhsXJ7lYHwWTD/akpd/MocEa9LiZNVfUV9PK2cg3xN3iv0hI2fbR8eCu+yqC53mvTm9PMZ0q17iiNGzgMDk09t6FZ9l5Y+3s1U6InVCsZ6IseBAFfBkd1I62jM7O6aOwxhlgcvjl92iabJtFVDDO5r6E8dAGEqq4lBkquWzfWfFtW125aFqUT7FTz7XC68inW8kHCtJ7Bvnqfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmbCxJU70RKr1KtEXfTZMpImUptPsGyfQ+YD2Fx9u6o=;
 b=UXUmFwVExgVbbHe1ShsJEZtAhxB+jx9QTyQGMF49lR/wVHU4LUjJnnyn9Q1ezGB4QMK6jJ6OMzcPq88cIsgmf3MzpKRddCg32PFwnos+LnG2xIcNxfKKzGf4VRDnTfvNwd+9JFUAIgpC1HYPVFsNv+tBAW08yD+/nfRfX15MjzjOdKB3/Jjkv25fNf7p1p/LPX/kjjiErVdfK03ov6rp6yrSsjg8+6ZFfo6nxmXtGo8ptE8msT2oqBr7Ffm/kILXU9aOanlu9f3BI9q+PoBeL0EED4T9FGZFEhwlHBUB3VWB6hPYuuFr7se+HbnJc3+Wuv5llDNJKxb+zaUoqzr3aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB10275.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 19:17:25 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:17:25 +0000
Message-ID: <4c8e32a0-aabd-4690-9bc6-e6a912874184@efficios.com>
Date: Fri, 31 Oct 2025 15:17:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 20/20] sched/mmcid: Switch over to the new mechanism
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124516.529828589@linutronix.de>
 <72cc0b5f-b1e6-43d4-aaac-ef3ff2e20a01@efficios.com> <87tszfrov4.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <87tszfrov4.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0172.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::12) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB10275:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a28c851-51e1-4e1c-0264-08de18b21fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2xWREIwSXJnUWw5YmRuaTk1VHhuRkdyVW1uN3puWWRSS3VYNTBoVWFyZjFF?=
 =?utf-8?B?dDJmaEFZMWI1azl0V1JVVU9VeVorNEZPS3E0NzQrcklsa3J0UjB0SXV6bmdI?=
 =?utf-8?B?UTR6NGhTMjFTeVpNUWQzazJ5cHFOMVd5RTVGNXZTRDNFOHRLR0xVOFJQUDF1?=
 =?utf-8?B?Wmt6UlNid3grSUZ2T2FmQlJaMjY5R2FqUENqOWI1MXB5NDJjMHQ3elhlTzhj?=
 =?utf-8?B?RFh3RGFQMk9nVUd4bEMvWEEzamliMnJZRkg1K0Z3Z1FFbU5GK2lJNG5FMW9W?=
 =?utf-8?B?ZFg3OGE1Vm1NaGZ0dVI0UG9XNjZyNzY5Rnp5bSsyV3ZzTUU3V0V6WWtPTDY4?=
 =?utf-8?B?a1JLbXUweGhzTWw5MFI4WHNaZ1RGamYxeEdKQjQzSUI4MUM3SzV3emhZaXBJ?=
 =?utf-8?B?MGR3LzdBUVZQMmQ2QnFpR0hSQlZYdHR6VHZPWkMrMG1GUkJaWittenBYNjly?=
 =?utf-8?B?dDZweGVZZUFtRnlaWWNCTGF1dWNCYTFEa2ZkRXhIU2huaVRlZGZwMkJnaXA1?=
 =?utf-8?B?NlBOSmRleDJqTFp3RytZZHNFOExJMW9aVkdtNTN6Q1hzYUNwWHBqOHZ0ZnMy?=
 =?utf-8?B?VmNzSE5UTFVYQi92bHg1UWpXcngwc0VsbHJscVBvSkZTSVJyZ1VaTHdEK2Fh?=
 =?utf-8?B?VGlYUlJKZVcySnhRakZiNHk1OGZjK2MrdGNwUVQ5QmwvTGVraVMwNStVK1o4?=
 =?utf-8?B?Slk1QU9mTy9Mbm15SWJjei9Zam0vVGpnZ0w1cWVmUUh0VmNvR2szWWRMTmRG?=
 =?utf-8?B?Nkg2WFQ1R2VrTmQ4OXpNZWNFVEd4d3RWeHJDWFpwSWJNVXgxaFVnTHhiV0Nm?=
 =?utf-8?B?aFExdGpoNXN4UEFxbFVOcUxza3ArdGpKcE40MXR4M0Y0bEJmOUF5QldXV3hn?=
 =?utf-8?B?SmFKcisyT28zOXVKcEFrWjZvR256c3lmVllVV3cyb2NFVm9iU1RmQisxZ3hr?=
 =?utf-8?B?cXcrTDVOMEY3T2pMZTdYYkJnalU2V3lKT1IrQUlBRjV3MWVYdmlCZ3FiQlRW?=
 =?utf-8?B?YTJVZjNjZWtIK3FFSnN1WFo0VDdxUVdadEtvbXgvODVtYnlxcTNVRmJyZ3Ju?=
 =?utf-8?B?amlNVFFENFpmaVlPbGFzanpncWk5ajVneFRPWm52TW1MaHFUM0s0NktGaWtX?=
 =?utf-8?B?SUpFVHJyM1lpcGRtTGo2L2JnSVh3THdveXYrN1U5dEFLQXo2QW9JVnpBbVdo?=
 =?utf-8?B?dFg4cHc0Z3lyaDRXcDFPak5DTFVQWkZoMjJsd3FYZEZORzBBYlFVamNXM241?=
 =?utf-8?B?eUNJek82VHZ2bVk1aXcyUjl5b1M0MStXL2Fkd1BkOWYxb1luYlZPbEFHZW0v?=
 =?utf-8?B?d1NiQkhrRzZiU2hDYmZmRm9mT0dPZ2RyL0UrQkJXQVdWY2RVMWduRFJvYnpK?=
 =?utf-8?B?bVdJNnc0cHgyTHhRR0lSMzhEZVExTFFkRGFJNnZNaVpFaGdSUmt2V0xSaU82?=
 =?utf-8?B?OVVHVlF1NlBva2FwVVZVdk1hNnhnalhVQSt6T1NyTzZpb1BtRnh5M0JMMTZO?=
 =?utf-8?B?ajJIekpFTXhZWVFEWlIreVlkaklSTEgyNnFvbjRaS3FsL1A1RXMyNlNDTmR6?=
 =?utf-8?B?dTc1VjhlMnFHMjg4b3dRSWdlSGRKOHBVSGpHLzUxWTl1eEljeE9nRHlTTU1n?=
 =?utf-8?B?eGtHeFFOdWZXS2hwREhTM3BqS0hUUVh4MFhnRzU3OU8zQVVKblc2VlpxMUsy?=
 =?utf-8?B?SnRnR0tCcVBwQzZtLzZkTTJUeXA1SXZVWkgyNHFvT04rb01jTng5RGJLMXdG?=
 =?utf-8?B?THozVEtESFZoN21Nd3hYbFRWM3Q1WVZ4Mk9TVjZsdUpsSWhqTUlubkZFVXJP?=
 =?utf-8?B?R0krU29DTllEc2l3a0xCV3B1cTZvNG4vK0xiY0hTSWFJeXRnUEJzaHg5VHpk?=
 =?utf-8?B?QVhXZnhkWXVtUG9yQWtaM01vOXpJOWZIS3RNOTBtVDZQY1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVFJT0JlRmVXUlJYTituanBBbjIwZXVJdXlTUHIrcHExV3hiSENDdXBuVEI2?=
 =?utf-8?B?Ym9vUjdCRW9xQUZjcnV0aFJxMnV6VXNkU3dtb3ZEa2RwdlJsY0VPWURCMXBN?=
 =?utf-8?B?djVEZUpqMmVtK1VYamRQZEVGUG0vVkEvN0ZzRG1WTXE3bjc3TmlCQUd0d054?=
 =?utf-8?B?VWhKbGh5QkVpLzVxYXhYMUMvTFNWS0VraTJPbGEyNDlvYWkrK3g5UXd5dUgv?=
 =?utf-8?B?RUtxbkFtQUVkZFJIU0E1cXFWY1VYalF6cTN6S1p2eVk1R3ExT0xFM3h5RjZx?=
 =?utf-8?B?ek5zWGJRUkRhMWpNT0RIVW1oeTNpSmNsTWdUL2lVNkliS3BGYzN3bjdoMzg5?=
 =?utf-8?B?TDAveDI3UEJPVFBaS0REYzZsSDJBZ3o4R1FUMW1HRmdia29FTGJqdDBCMDdL?=
 =?utf-8?B?KzE2YjIvUTZhakFyK1NSOWM4bkowY1MwQzB4aWhkWndFVXpCbGJYOCtQK0o4?=
 =?utf-8?B?cGU4LzVZbGV4WmVUNTdndzNKc1NaNWhDN3l0ZlN5ZjNvVDNTRUQweEFMaG0y?=
 =?utf-8?B?enh4RzFPeWdFMDVBWUZsRW5ENVgrNmRGYTM4S2ZDT3Vnc04ySWovdG1nRlo5?=
 =?utf-8?B?OVJIU0dGa2hlUDdtb2x0dkRac1pHT01PODRJRURJMmYwd3M0UGlZUTd2bkI0?=
 =?utf-8?B?dVBmT0VwT3QwcTloekZTdDBJbmtzZGprUUxkVGVwWW42b2VCclAwakZYMUJE?=
 =?utf-8?B?TTZUbWhJempTRzltV2gxSm9VUXpyUUl4cmtuMk0wNENkVlFEelJFU3RwWTVJ?=
 =?utf-8?B?SldLOFVwcUxVZHpRTVpTNVJ6L25pWWRpNVZ0MDlETHBOTVh2cXdSaTV0WmhO?=
 =?utf-8?B?d3hhUkxlbVQ4dnZWNG1JV2l3MUszYUFlUmdDdHVjY0xzTEIzNTIzT2lsUFd5?=
 =?utf-8?B?eWZkc3ozdWo4SjFRK2Yya2lsTVFjV21XTE5XMkdXQXRMcHpmaXFvT2lDdzcr?=
 =?utf-8?B?dWNMY2pEUXE5ZDJNZ0dsZFRpZmFFeHppSk5TclhadmJLRVNwR2h1dGpqNkps?=
 =?utf-8?B?bUFqQVpvT0tUbmh3ZTlyRkkyVHVNWE9TRkhXL21zdDFCMXdwS3ZVVm1JZkEw?=
 =?utf-8?B?MVE5d2RqQzJGa3FmUkRmZUJjY1llcHE1ZytxWkR5dHpjUXR3aWk2NlY3Nllq?=
 =?utf-8?B?dXRGdDMvZG90OTZtd1NWTkc0TDcwS1FacVBPRDhzZmFPMnZTejF2MktIbnRW?=
 =?utf-8?B?T3FHL3JWQmxGZWgvNTVJTkZKbTVKcWxidDFSbGNvN3lIUTA3eit4YlZicmJ3?=
 =?utf-8?B?cHg2QXl1cS92Y1NpeTkzbFJ0NmFpNnZ3TVphMHB5RWlKRmNUMnVicm91RVhJ?=
 =?utf-8?B?WWJnbURzM1l1SzQ3U1d2ZHFJUWlvUWhNUUtoT2hjNHIzTVhLMVV6Y0dhcmNh?=
 =?utf-8?B?L2FCL0x5bWxSVzV2TnBiYk5hV0JvUXBOdE1STTVTYkVDQ1ZxcDkvSzQxVUdM?=
 =?utf-8?B?SmNoT1UraVhDbWFLTEhNN1k3QjNMNHpUMW9WZTd5TjkybnBrOVF6MkZsVVQy?=
 =?utf-8?B?YVVjSzNOVXcwNlI1aTJMRFhLQS9ZVjg1dk4rS0syWnhQWmNKMXFGUHpVcnFJ?=
 =?utf-8?B?d3FNVC9QR2RtV1I4eGVSaFp6UEdwTTNPSHQvV2UzUWRNOEZ3NU9hZHpOTnFn?=
 =?utf-8?B?QS9PamNaU0FTak85VzZVZ3BERzNuUXJBTnpnbnp4Mmo3dVNHMzZ0MzE1Zkwx?=
 =?utf-8?B?cVEwY3hUSDdpK0xDUHh1MUtCaTkvV2lzZlprTEpCZ2lKYkdoMkt4cUtSUExQ?=
 =?utf-8?B?RW9Rdk9hQlJ0MW9Xenh0dFV3NE9mbnk1cUZjdE92NklaY3lDYXM2K1l2NUNG?=
 =?utf-8?B?YkxaK01KeHZ1aDlLVFBnWGNZWHhUdlVtSm1SS1FnSVB1MXRud2FQZ3F1amVu?=
 =?utf-8?B?ejI0STVvNjV0d2dwaDBmcWpnU0s5cTV2R2JHbVEwUmhBUXJnSncvNW9iM2Zs?=
 =?utf-8?B?dVVSSFpTa2JNeG91M01VUEx3VUVpM3RvRUNVSU1YekQraTFFZENwNEw0ZWgw?=
 =?utf-8?B?ZVdVUHRLNEVKRnBBYVUvbGE4c1NnU2hZclJHQ0Jpd29PR3hwQ3h3Wmdwd3dt?=
 =?utf-8?B?KzhVWEIzOE82Q2FoOHBqcmZJSDBBaHlNY2FmV0MzTHJDdVkyVjlyekhuSkMr?=
 =?utf-8?B?Y013VEllejg1YWhNbDNCSDV3QkxYWUtveGVmRm1vNUpTT2E3VlZ0M3B3WEQ5?=
 =?utf-8?Q?mWcx0NXBSMp2FIqyjcSL7T0=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a28c851-51e1-4e1c-0264-08de18b21fbe
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:17:25.0707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKB6XvPwVZf1uA2oTIe8aaSS3PFdBHtodEczFzThdoMJQD5a16LsZU3xW/t2hUcygMDoBplFV0YXsHobqO6mDlxHF4RfeDpABJJTQK3lGAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10275

On 2025-10-31 12:57, Thomas Gleixner wrote:
> On Thu, Oct 30 2025 at 12:07, Mathieu Desnoyers wrote:
>> On 2025-10-29 09:09, Thomas Gleixner wrote:
>>
>>> @@ -10702,10 +10758,43 @@ void sched_mm_cid_exit(struct task_struc
>>>    
>>>    	if (!mm || !t->mm_cid.active)
>>>    		return;
>>> +	/*
>>> +	 * Ensure that only one instance is doing MM CID operations within
>>> +	 * a MM. The common case is uncontended. The rare fixup case adds
>>> +	 * some overhead.
>>> +	 */
>>> +	scoped_guard(mutex, &mm->mm_cid.mutex) {
>>
>> When exiting from a mm where mm->mm_cid.users == 1 (read with
>> READ_ONCE()), can we do this without holding the mutex as an
>> optimization ?
> 
> What's the optimization in that case? The mutex is uncontended and the
> extra instructions for taking and releasing it are so trivial that you
> can't measure it at all.

Fair enough.

> But aside of that this might race against a scheduled work which was
> initiated by mm_update_cpus_allowed(). So keeping it strictly serialized
> makes the code simple and race free :)

OK!

With the "eventally" -> "eventually" nit fixed:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

