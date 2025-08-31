Return-Path: <linux-kernel+bounces-793586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9CBB3D59A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 00:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C2B3AB0B1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 22:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD6A247298;
	Sun, 31 Aug 2025 22:29:31 +0000 (UTC)
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020124.outbound.protection.outlook.com [52.101.195.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B092356D9
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756679370; cv=fail; b=fCVDFzStymENBhdb8kPjW7DTZa9A8YgtCQ5TK9Wj1Mfy3B9OMV4JZ8nlsN4Nn7CHyI47jP3cbknPwFiUDJ/8MFKsf4jTZ9WdPDMy3qdbvJ9wrm23qoNIfDgKDz84CQqPxmM0On/QAFqkfDDENLZSJUutBCOoCFR1eUQCJao/QxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756679370; c=relaxed/simple;
	bh=nhiQhpRTJaTJuUIYUZiQy5vKeXc+lqTKJ0euuFcNoNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VdLbMy/2v9ebu9LPkmFDtS4F7EPPcWlEJbelcU1SWj9ERKDsemmTiJV1B/oqys+BfyMg+PSfaGbeOoQic7icAlwBV3LJp4T0EaLv3paB7nwSj+MfAPc3fRA8CrHA/mcSfT2XwDymMYvMdkdnpjFowHzwo70m1OjjVif29AAkSJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehg+UfuPK975jOHrd1HYdPmM2Pf8Vz3expqFAj05n2a6LOOTAf2T8OQzUpolyNu0OpcaQ1ZlKspjT3zgfuGPRJMoZ6S9k/k0pvmNs23i+qMC+SXeTfbdfLS2dk7MuRhoyzmXMAHrzKdKDzwHfbLRoPj35kcucmrpu8xBOE3Hy6BkhDL4XCqUjqKzfFXqzzVWBRmGJBqahU+zrZo1rIOINBOLOEA9m/pMOMyajFfxZPCriM0Vaem8Op2rMTH6jBVcI3Q3fUJWk0fBDmDxy+nJNlFHH5+mx3tsCC4KZNptP2eMxdSFYKdL5pHAjaekRZ8SG3/q93rNGuVZuJWQqGlJxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VE7PPYXSVumL+OYhX5dUGLQqCrV16fvm+7TTbaIgDlc=;
 b=YmZcyOHzuxDXnZiBZx8DWldjt2BtGQe3iaM+TBW/PfE7TyhCcnGxAQeyfWH3Eszj0qWG3mJLP3fzZhbkqEHRE7ncimvE4bs0Yp+g15oo+DAXWQelB22p7Oa9ABFz8tiGhm4XpGDF0N/TnU9RQvYMhGBxlYZCkEJDxNwIQpG+bCouBYNqKyG5tGORDrUtoGCjQAn7Fzb3nnGY0+FO8FnZ9CW9kAPFbKRkkTiXhgn3PHK9/y9Vqq7gkAs96J4hLZh+yz0QpFXQRhtZX9K7kRxedXK1452uSzcrjYGzCKQjoroAh8uimhM4B0IEKQyVZnWAokX9qoN80rzl+aQ+ym8MCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB4084.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:8e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Sun, 31 Aug
 2025 22:29:25 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6%5]) with mapi id 15.20.9073.021; Sun, 31 Aug 2025
 22:29:23 +0000
Date: Sun, 31 Aug 2025 18:29:18 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Mel Gorman <mgorman@techsingularity.net>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, hpa@zytor.com, oleg@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, atomlin@atomlin.com
Subject: Re: [RFC PATCH] sched: idle: Introduce CPU-specific idle=poll
Message-ID: <hpyrujaoqd3qpd46ttrzpcj4hsbxeubfk55zw2k4tvezljxbvq@jeadvbhwdirf>
References: <20250621235745.3994-1-atomlin@atomlin.com>
 <20250623102334.GP1613200@noisy.programming.kicks-ass.net>
 <7n6zmi3aaxrwfpvkzbugt3e3274zw3qb2kci4yyq2q6gojb3ku@zh3g4rvnyqzi>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7n6zmi3aaxrwfpvkzbugt3e3274zw3qb2kci4yyq2q6gojb3ku@zh3g4rvnyqzi>
X-ClientProxiedBy: BN9PR03CA0566.namprd03.prod.outlook.com
 (2603:10b6:408:138::31) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB4084:EE_
X-MS-Office365-Filtering-Correlation-Id: a236743f-6753-45db-4890-08dde8ddd5f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|27256017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnUxZHRqKzZydjlzdTJIb1djVEV3N3BIMFErVGlNNkZFYW9SUnJRRVh1dEhx?=
 =?utf-8?B?S1lFQmZtZmMvZWNCT1MzQ2x6bU52UjhGY2FuMzk1ZksvUUlGR3RYakhiRFZC?=
 =?utf-8?B?dVVhUG44ZUJpWFVmYUFoQU9iYi8vdmlhalhXNFBhZkF2TlFhQ2l6M2Y5NEVV?=
 =?utf-8?B?TnEwVUhKQ2h3NzZRTEtPUXg4V2RiQmorWC9Qdng4OHBTZ0I2SkFPaVlXVUJn?=
 =?utf-8?B?RFJxLytuSjh2dkZxMjNFdWJINjVIVHMwTFd5WGFERndpc0ZTRUVNdVVzcnpU?=
 =?utf-8?B?SlZoSmc0U2FNdm9kVDY4TGQ0QXR6RDl2L0IrMWs5ZExvRm1QNWZJOXFYcy9Z?=
 =?utf-8?B?ODAxWEI1RENNTVZHVkM5RHlTMlo2VnN6bW9SNWkyUHJxSmxrdVRsY1hxMjM5?=
 =?utf-8?B?WDVXRldYOVpnbVZTUlR3MzlEUFJwdzh0ZWQ3VW9rTVJsSWhLVmZXYnZYcHJw?=
 =?utf-8?B?QXg5ZHErZHRBVjFMU2NiVVlremljMTFpSGFvaXpmaFZpKzZDeCtZTlZ0OFJx?=
 =?utf-8?B?NGMzL3UzbUVXSlgzQTgxa3JSQTErbWJ6N2xMR0pNTUxCdEFZbStySWxkdUQ4?=
 =?utf-8?B?eHEwVjRqUXhGWmVUeVFMc2pQK25laUZrZFErS2FFZWdpY3RmOEdmejZCbm5K?=
 =?utf-8?B?VVE2eWVsTWJNNWxYYlUwM1V6OW02YnRyOHJiUjRmdEE2WXFDNWNZb1U4L2U4?=
 =?utf-8?B?a1RWbkVEc2c0WndpaXBJUUtaMlRlVGljTEhYdlpXWm1CNUtYWUUreDhNMmds?=
 =?utf-8?B?dERpeGl6cGlrV3JuakE4T0xzQlN1Q0Jxem9GRFROYU5PdjVwbENuSUkrcTdQ?=
 =?utf-8?B?cWRPYUNPNkZnVmZDUzAxbXVsUmFGcmoybjVvZnpNbzN3RmZ4M1Z6QkgrMnpp?=
 =?utf-8?B?aHhOQU9xNSs1eVNpVEF6WGR5eitlbGI4WEE4RXBKSVVHelFFRDR4RU9KSS8x?=
 =?utf-8?B?OTdSU2V4U3JZTGxNU1FIQzlBZExnS2djSkNBUWNCV1oyZXhCRHFUenQyMmZu?=
 =?utf-8?B?aGN4em1EOTYrTXhZUE56ZEpVRlhXTXZlVG5RaEUrMXdRdFl6TlUvcncrc1JG?=
 =?utf-8?B?K3duQ1A1WEE0ZWZxZUJrVkRYWThza0o1am9iTU93SkFNVGZWOE9qZEpmQXBW?=
 =?utf-8?B?N21zK2NseVJMczhMbGJTN29jOEFTRFFoMWlnUE92VTNyU0xUZUoxalZJSTJl?=
 =?utf-8?B?WllxdzlEVWZFTkZiMFowaUloeWV2VUFLYmRlTzY5dTd1UWUwUGhuaVJKMlBG?=
 =?utf-8?B?VkRwS3V5cWZMdmU1bkZraEU3RkViNGdUczJzdFRYRHZqUlM1cnZtby9RKzBV?=
 =?utf-8?B?clJ6aVExUkZJUy9VT0tPamxrT1FIUDE0SUVyWjZwdm5tYUZnRWwxM21HWWZB?=
 =?utf-8?B?QitpbnQ4USt2R3hkd2dOaGF5d3JYUmR4NFRFd2NiS2hFWkJGeVdKSEpoS0lo?=
 =?utf-8?B?OVgwK214bDNUNkNId3oweDRXbGJIdGhObGRNTVVoSzFUczd2aklTdGRtYzAr?=
 =?utf-8?B?TFFpM2plT2Z5UTVSWVNScVNRWEpzVno0SHdRbjBLNnZRcmZwSnd1M0p5a3RC?=
 =?utf-8?B?YllQMUlGcFY0NU1uVGhSZ3VVWUVLU2FXblR1Y1hDcDllSWxXY2hmbDMzQW9n?=
 =?utf-8?B?WExVaEFvRUdYL3lwSU9NUk9KeFpoWEVpcWk3MkxvYWVPWWdmanByeWFKREkw?=
 =?utf-8?B?aktkcXJOZGtoc25FTG9iSys2WkhvYmVSQy9rSjJUYTYxMmpic0xyLzIvSEkw?=
 =?utf-8?B?bEIrUjM5bHl4TmtvTTJrODVtbXZqNU11QncydWtZTDJRZVlUUlpaUGw0OU96?=
 =?utf-8?B?c0ZUQzZFcmkyZ2hyRm9hck1EU1doc2owbEVoUW5lZFhjMXlwWmcrSGk3R2Fj?=
 =?utf-8?B?L2xnN1NVWTlHeE04ZWRBQzR0K1NVSkdnYzdTNWttUHlQZmNqMGhtdHBTdmlj?=
 =?utf-8?B?U0MyU2RCVjNoUnFtbFJUNTE2NFd4eGVtL25aSGVsYXpVVllKSEtLUzFxc1pl?=
 =?utf-8?B?aTZlK0NudnB3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejZVdU93NjBVMlhsUFc5QW1sM3JaWVNEa3ZoL3RTVTVFUmZpalRhZmJuOERw?=
 =?utf-8?B?aVpWVk5lRDEranhaa0VCWHNrSVRtdkpLT0grQ3o2S1A3MnhNeU5XbkxYaHRv?=
 =?utf-8?B?TWwrcHpmTEI5YTJWNERwd2R2T2MzV1F4T0tGSzRiSnBoOFkwVjhWOHlUK3A0?=
 =?utf-8?B?a2k4SjB5YzFYZzNoaG5EeDVXc1ZYakN6Sm1BNy9IcUFSaHE4aEdQc2ppSDli?=
 =?utf-8?B?aU1HNGhoYjQ2dmg3K0JnUWRMNk9nZFZOaHhzcnZaMTh6ckZPN1RIeVVBUTFj?=
 =?utf-8?B?TUpSSWdBUlRDZGNFbkxhdld0ckxvRllFMjlmWFV2T2E1L0hjWmZCYnQ3K2li?=
 =?utf-8?B?czl2R0NBaVFnNzJLUTBUekhjeDMvd3F2MHBWZ3pWN0hXRi91Mlo3WXNxRytG?=
 =?utf-8?B?SkZ5YzREWFR1cVFFeXZFYS8vUThFL281OWJMUDhsYjI1UUNUZkRRZ3pEV1Y2?=
 =?utf-8?B?YlNDWDJrNXFCTExidzFucDFMcE44cVN1TVlXdVNKR0tKQ1ZwbDFpQXQyTmJz?=
 =?utf-8?B?aGpTeTZ0cnJGQ09CemhoNjFjYzdmQ0RQaHRQNUNlbTZXbFhnd0xNakEvMUJl?=
 =?utf-8?B?ZmIvTEVPY2pyN1hoL21hdzVidm5pS3NlRWZlZU5VVXowWTd1N1krWGNpMzZs?=
 =?utf-8?B?YVlzeWhGaUlnTFFFZDFjaWFzaGVyVjRubVpIN0JLUUlmKzcvVE5HRmZIZ3ky?=
 =?utf-8?B?eVVRRTN0dWZTM3hlZmQ5NUs0SlJlOU9KdVlDc2ZMSUhUdFRnQjFXSTByRTN6?=
 =?utf-8?B?VG1iU2F5eWNDeThIQk80MEQ1SGFqNnUzMlZ1WXdaM2xmaUdvVVJxUERFWXM3?=
 =?utf-8?B?UkhoL3BQKzdmWDhodmNIRVd5VnhoYmVjQ2toQkkzRE9qOG5Kd09aWnJtaU1x?=
 =?utf-8?B?Wjk3b2F3NGtaeEtZWjNIam9naVk0RUtid3l6UUVYUU91TWJqZjZtWjNlNVBE?=
 =?utf-8?B?YXJHY3FnZUhySUJlMjdTRFJNLysvQjJ1U0ZCNW42cy90Um1hc0R6RkJEQUFP?=
 =?utf-8?B?MGxmclFlMlJiZ0R4OWFIY3U0bTc3YlZBbWZ4aVlYdjJucWFRY2RLa1JXUmli?=
 =?utf-8?B?c3dhYTc4R1RsWUcza2c5OEU0Z2YvWGs2WkpLTGk4U09lVzVHa0I2dHkwdERn?=
 =?utf-8?B?amtnaDFjanNVbUVsR1dTalAyNlBkZHdYakpyNXdRWElEaDBFcWx0Y2hWa04z?=
 =?utf-8?B?cllieEdsOS8zQXlCU0R1dGNjZ09EMlFPOXArdFJqWFN2dWY3ZzBpaEkrMjVm?=
 =?utf-8?B?YlllZSt6d3hBQzc5T3FUdHdZcktLRk4zaVQ4MGdBenRwdHMzVHY4WkRmSkk4?=
 =?utf-8?B?d0pZYmg5T25hbFFPbFdzcW8rNkdwNW1GOWsrUXJuQWZZQk5PbkFOTS9IdlRo?=
 =?utf-8?B?amgyck94MEFlVFpHa0kwb29hditzSXdqNWhEOGZLODZKUjU0aHoxN1RNaS9o?=
 =?utf-8?B?dmF4cTkxSEpJTlJ6QjlSSnp5OU5LUHB3VGh0dE1aUnl3MktvMmt4Nytxd1pP?=
 =?utf-8?B?aVlwNG5nc0RmMWFHbVlqSlBYK0dxU3l6cFRmUkh1QlNYdTVVRld2dHZJaW1z?=
 =?utf-8?B?OFF1V081NEd5WGlTc1VKWVZ5cGlIdVVuUUZSVndPL1d3UDZuNzAzN0VzZ1JW?=
 =?utf-8?B?bWFLMGl1UjVvV3pHSmpPSHJTQmpJbktYblF2UFFiYURLTExndmh2S1VIVnhV?=
 =?utf-8?B?MXBqMnVydWVkQS8ySCtNdHlwOFVhWkl1U0c1cGd1R3Y1Y3dvTXl1b3dlME5F?=
 =?utf-8?B?ZTVEYm9FVWRGS21EbVRZUUthQllwYmtlUHI0VStNbVBrSG4rR2hFUm5pU1pU?=
 =?utf-8?B?UEo3a241eU5RUEtpd0pFbzJHck9UWGFQZlpEaG5UT0IrWjlUNzZNL092eDhF?=
 =?utf-8?B?RzlRcDlzRDcxWlpCSTBUTmpObUFyUVhmVVROVWtVMlhkMUpSTDhTK0UrUWQv?=
 =?utf-8?B?eU5XcmkvRGNmTCtjZWpZQnNvdzZ5amZOeWVhZXdCcXQrZlB2UERab3VsMVQ3?=
 =?utf-8?B?NXZSK0ZWcmdBS3VvblBobC9DUHp0ckxJd1dpbkpKeUdwdmxOUldUeU5qeUJX?=
 =?utf-8?B?dXlQMlFVWXo1Zk43ZUtBRmRVRE1KYTlERnppNlZYcW9TT0JkSW4yZm44dWxa?=
 =?utf-8?Q?vGzXvFS67TLlxWxsOsLhEvgi3?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a236743f-6753-45db-4890-08dde8ddd5f7
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 22:29:23.6660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nl74jt5y2K/yoWEVQuNo+U7yRI/2w4/Exv9SEXE120b5+9tVODxLhHIIthl5ggNDqDC4EvMR+6mI50HuOU/jnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB4084

On Mon, Jun 23, 2025 at 10:49:59PM +0100, Mel Gorman wrote:
> On Mon, Jun 23, 2025 at 12:23:34PM +0200, Peter Zijlstra wrote:
> > On Sat, Jun 21, 2025 at 07:57:45PM -0400, Aaron Tomlin wrote:
> > > Currently, the idle=poll kernel boot parameter applies globally, forcing
> > > all CPUs into a shallow polling idle state to ensure ultra-low latency
> > > responsiveness. While this is beneficial for extremely latency-sensitive
> > > workloads, this global application lacks flexibility and can lead to
> > > significant power inefficiency. This is particularly evident in systems
> > > with a high CPU count, such as those utilising the
> > > Full Dynticks/Adaptive Tick feature (i.e., nohz_full). In such
> > > environments, only a subset of CPUs might genuinely require
> > > sub-microsecond responsiveness, while others, though active, could
> > > benefit from entering deeper idle states to conserve power.
> > 
> > Can't we already do this at runtime with pmqos? If you set your latency
> > demand very low, it should end up picking the poll state, no? And you
> > can do this per-cpu.
> 
> Yes, we can. idle=poll can be hazardous in weird ways and it's not like
> pmqos is hard to use. For example, lets say you had a RT application with
> latency constraints running on isolated CPUs while leaving housekeeping
> CPUs alone then it's simply a case of;
> 
>         for CPU in $ISOLATED_CPUS; do
>                 SYSFS_PARAM="/sys/devices/system/cpu/cpu$CPU/power/pm_qos_resume_latency_us"
>                 if [ ! -e $SYSFS_PARAM ]; then
>                         echo "WARNING: Unable to set PM QOS max latency for CPU $CPU\n"
>                         continue
>                 fi
>                 echo $MAX_EXIT_LATENCY > $SYSFS_PARAM
>                 echo "Set PM QOS maximum resume latency on CPU $CPU to ${MAX_EXIT_LATENCY}us"
>         done
>  
> 
> In too many cases I've seen idle=poll being used when the user didn't know
> PM QOS existed. The most common response I've received is that the latency
> requirements were unknown resulting in much headbanging off the table.
> Don't get me started on the hazards of limiting c-states by index without
> checking that the c-states are or splitting isolated/housekeeping across
> SMT siblings.

Mel, Peter,

Yes, I can confirm the PM QoS subsystem allows one to set constraints on a
per-CPU basis or for the entire system. One can specify a maximum allowed
latency constraint. As per function pm_qos_resume_latency_us_store() a
value of "n/a" will prevent the specified CPU from entering the shallowest
CPU idle-state (namely "C1") given its exit latency constraint.
Indeed using "idle=poll" to prevent a CPU from entering idle C-states is
problematic given its crude, all-or-nothing approach.

Thank you for the suggestion.



  ...
    do_idle
      cpuidle_idle_call
      {
        next_state = cpuidle_select(drv, dev, &stop_tick)
                     // cpuidle_curr_governor->select(drv, dev, stop_tick)
                     menu_select(drv, dev, stop_tick)
                     {
                       latency_req = cpuidle_governor_latency_req(dev->cpu)
                                     {
                                       *device = get_cpu_device(cpu)
                                       device_req = dev_pm_qos_raw_resume_latency(device)
                                       global_req = cpu_latency_qos_limit()

                                       if (device_req > global_req)
                                         device_req = global_req

                                       return (s64)device_req * NSEC_PER_USEC
                                     }

                       if (unlikely(drv->state_count <= 1 || latency_req == 0) || ...
                            ... ) {
                         // A CPU idle driver which more than one C-state and a
                         // latency requirement of 0 will force C0 
                         *stop_tick = !(drv->states[0].flags & CPUIDLE_FLAG_POLLING)
                         return 0
                       }
                     }

        entered_state = call_cpuidle(drv, dev, next_state)
      }

crash> p cpuidle_curr_governor 
cpuidle_curr_governor = $1 = (struct cpuidle_governor *) 0xffffffff9ab913e0 <menu_governor>

crash> p cpuidle_curr_governor.select
$2 = (int (*)(struct cpuidle_driver *, struct cpuidle_device *, bool *)) 0xffffffff99157ed0 <menu_select>

crash> p cpuidle_curr_driver 
cpuidle_curr_driver = $3 = (struct cpuidle_driver *) 0xffffffff9ab04dc0 <intel_idle_driver>

crash> p ((struct cpuidle_driver *)0xffffffff9ab04dc0)->states[0].enter
$4 = (int (*)(struct cpuidle_device *, struct cpuidle_driver *, int)) 0xffffffff994d32a0 <poll_idle>

crash> p -d ((struct cpuidle_driver *)0xffffffff9ab04dc0)->states[1].exit_latency_ns
$5 = 2000

crash> p -d ((struct cpuidle_driver *)0xffffffff9ab04dc0)->states[0].exit_latency_ns
$6 = 0

# cat /sys/devices/system/cpu/cpuidle/current_driver
intel_idle

# cat /sys/devices/system/cpu/cpu7/cpuidle/state0/name 
POLL

# cat /sys/devices/system/cpu/cpu7/cpuidle/state0/latency 
0

# echo "n/a" > /sys/devices/system/cpu/cpu7/power/pm_qos_resume_latency_us

#
# Samples: 2K of event 'cpu-cycles:k'
# Event count (approx.): 89401819821
#
# Children      Self  Command          Shared Object                                   Symbol                                            
# ........  ........  ...............  ..............................................  ..................................................
#
    99.80%     0.05%  swapper          [kernel.kallsyms]                               [k] do_idle
    99.80%     0.00%  swapper          [kernel.kallsyms]                               [k] common_startup_64
    99.80%     0.00%  swapper          [kernel.kallsyms]                               [k] cpu_startup_entry
    99.80%     0.00%  swapper          [kernel.kallsyms]                               [k] start_secondary
    99.75%     0.00%  swapper          [kernel.kallsyms]                               [k] cpuidle_idle_call
    99.34%     0.05%  swapper          [kernel.kallsyms]                               [k] cpuidle_enter_state
    99.34%     0.00%  swapper          [kernel.kallsyms]                               [k] cpuidle_enter
    98.97%    98.56%  swapper          [kernel.kallsyms]                               [k] poll_idle


swapper       0 [007] 1203865.059685:    6998090 cpu-cycles:k: 
        ffffffff994d32f8 poll_idle+0x58 ([kernel.kallsyms])
        ffffffff994d16b4 cpuidle_enter_state+0x84 ([kernel.kallsyms])
        ffffffff99156241 cpuidle_enter+0x31 ([kernel.kallsyms])
        ffffffff9844ab77 cpuidle_idle_call+0xf7 ([kernel.kallsyms])
        ffffffff9844ac68 do_idle+0x78 ([kernel.kallsyms])
        ffffffff9844aec9 cpu_startup_entry+0x29 ([kernel.kallsyms])
        ffffffff983663db start_secondary+0x12b ([kernel.kallsyms])
        ffffffff9831452d common_startup_64+0x13e ([kernel.kallsyms])

-- 
Aaron Tomlin

