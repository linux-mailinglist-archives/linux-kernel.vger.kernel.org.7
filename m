Return-Path: <linux-kernel+bounces-736089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A33B098B2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54A727ABD12
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252AE1A23B9;
	Fri, 18 Jul 2025 00:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="MCtkV2xu"
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D301DDE9
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752796834; cv=fail; b=jK1EixLtSSOsySiwM7POo9gvJKsG6M8t5/SuO/HvpTCKkb1hhnv7bfpBKhVmfxAxE3q66hsj2qGIdTybiSJhGEw1JWjRMAOXQm0yXgAZdbZNEIR/cIFqjo/UUhQQVTMXHWUOGIbG4tfPxhLMdyMaatwgotlCgmNNCVO/mdarCQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752796834; c=relaxed/simple;
	bh=5Sz77LSLx5DBcYqQwwOAHMn5m+ZtoiutwcTLbGsOIrc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sfr+wrbRBN5C1jT+P9VeN8wHOl/STs5O8kXG8d0X4P93GbbKIrktayP+wQj4KrOoxpX8LOF1QLTuH1LLzCgcKyQgscwit2ilRAKGekQR3Y3bn25vg57eS1B42mdGJQWG1vegdFLt3D2eCcKz/NpQLKiHapKBPwGdY05yXwUpOqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=MCtkV2xu; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HNAHVd010449;
	Thu, 17 Jul 2025 17:00:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=+fDRVMCAsMzvjmWmTEGn/tfVn296dyTvt/2eYv2CD0k=; b=MCtkV2xuDWA/
	AZ3vhfk4z2qjhVozqn5eoyRStdEXN0xLqbt39W7Tu6CFDSWSW8sFvFpjvXe4WIJn
	IweltVqG63VKxEAdriS/mQA74tBVz1iwbFAvvpvnEX/Z7+9SES+B7ejqkj4myM8o
	JtodhB8rCEljVpuha+GVPzqRlRtD8PEj6vK3bBomIWuMeRY05mwD1On68xP1L0G+
	B1FM9mi/zwMw+OzQaHSo/32INaHwPfpZjnTmNJS8a+vAM0WvUW2WfsfH6CSX2wOK
	P3Kgp1yJap+vzVTcJ/cEzbCz39Q0IZYHWfMt2VKwEU/JqV14JU8YCg87+7nIb1t0
	XUg0LyDGfA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47ya80gcwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 17:00:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kcvg6kdDHUSvXLzT+GxncAOpMtPRnb6Zogks5gDbddEkXD7dA5wssvOlPkzb5//P+csDPBk7YEzfZo5owhJaM1JTd41poNLqwav+Ii2DGPLfhoJ4J1cEEXIYT5YOqapB5wAuzXXo9X3LHpxagR2cbgcr0qA9LWgjlZSU2/JThFfUfrwiLCG0dEHBgMKvbVfSohqDnCFvK1FSe14YQTWqKQdMB/VVhFEUL4/93P9w7lGjl1N7JnwsItA245K/Ii+YFG9XljgmpYD7+fwakm4Cjbx8XoO1Bm5HWL/36eQM7R2muiqON+nmDoY6bQJu3PFUTYdxqCcOEuKxMnlE73tadA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fDRVMCAsMzvjmWmTEGn/tfVn296dyTvt/2eYv2CD0k=;
 b=KjuwCQBQhPgP/Ro50I72p+PXNq1Bp+TyoaVeZU7MytIq8KnUHX2CVFeUTTkRAchd9V/HaVQTlK+jwnCFfPX6k2FrVE1Eeafdh9i9Gd4cFbqhKHfRaOtzQY/z4y+1fsLPZ04Mig4+faeglbu9iWqUXnTgxQzhb6sqgruauojxLncgu4YrkloyafwX0pCGAhpjR+pD2ETs/fJGL6HcUijvCA/nbBFn57Y2Ox2wcaWGjfaw7qYUZocRmJHjWLPTpaLwHwM7fzo3qP4C9DsXezUtpTwY3YS0Z5+dUFxFC/4mWPMRrvCE+ORptk1cg52F+Ic4C+8yXc+ZcUUy4CrlcJ/g0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by MW5PR15MB5123.namprd15.prod.outlook.com (2603:10b6:303:197::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 18 Jul
 2025 00:00:05 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::f4f9:d61d:89e5:74a3]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::f4f9:d61d:89e5:74a3%2]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 00:00:04 +0000
Message-ID: <94ea5721-2d32-416c-919c-a0d9e5eadf99@meta.com>
Date: Thu, 17 Jul 2025 19:59:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] psi: Split psi_ttwu_dequeue()
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org
References: <20250702114924.091581796@infradead.org>
 <20250702121159.050144163@infradead.org>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <20250702121159.050144163@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:208:32a::17) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|MW5PR15MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: 4789e099-3d44-4c0b-5038-08ddc58e0cbc
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3BkTm8zMFVPSlZXSWRiWGNLTjZxZzM0c2djcTd0Nm56K2VWSDdUdEppdzNN?=
 =?utf-8?B?cFpTanR4L3J2RytXRnJWbXIzRXVoWGlFZzhCNFRHSU92RkNWU25ocVhIbXFL?=
 =?utf-8?B?Sklqc29vNDk2bk1laEFMZkc0VktMS2xnVmMrdXpKQ0M2TVJYaVBXcVEzbjRv?=
 =?utf-8?B?UXpybnYrMUlwQ1VyQ25Xb29QaVFQSUFFMEVyVHhVRXJLbndBdDgvR0l3T2R5?=
 =?utf-8?B?SlFjRmlGWW8vS1c0c1JKSnJ0UjlFYzRXNFdzUkxNWHBlTlh6ejdmQks3Skgw?=
 =?utf-8?B?ZkV2SlRaLzhJREoyVkJRWkFncjZvNUUwTll0WmJuZE4yeHRFWG1QUkZpQ28x?=
 =?utf-8?B?TTJyL2U3WldpNzk4YUFRcnRsSFc2TEkrZzlwUEVmNGFUYlFQeFdxZ1BoNWxC?=
 =?utf-8?B?Z0lrS3JYYlp0RmRHbHpEcGlYa1cxanRtZ1BiSDB2RitCcHFRYzhkN21RSXBP?=
 =?utf-8?B?Y2V1MDFLMDczTG5ja0xvWFd0Y28xVnNiM1dJbkpVb1hUZjZteGUvbzc2TlRT?=
 =?utf-8?B?SHNtQkF3M0tTa25LS3pXVitvcjZ1dUFIV1F0YTBWbWtIemt5Z0Q5WUdaQXBR?=
 =?utf-8?B?SWtMRUhmN0xZYWZXbHg2ZkI2VnF2Q3oxdVBjR3JDMGVrZmpUMWVUa1lVUmU3?=
 =?utf-8?B?THRvQXhxZ0ptUlBJVHVSNUR1SlRJbHpzSEoxUklGQnhva2pjZlJ6NTFrTGFK?=
 =?utf-8?B?QkhYZUlCVWdJdGNFMTE2L2VlWFBKZ2NVWGYwNFlzL1ZKbi9SUkJpWlBCSmli?=
 =?utf-8?B?YjNVTmJLeW84NTFndkp3NnIyVTZPRDRSZ2xvWHNTcTNIdURUUndIRE9jRnlZ?=
 =?utf-8?B?Mzd4WDhrbVpmb0JPeG1wUHJNdzFuNjJZZFBKZTBseWdaOW5pZHZENGpUS1Z6?=
 =?utf-8?B?VzRtZEE1bmUwazJVNU5VdU9mVHdEd2dkQkNiQW44YVpYaEtpNkt3aGtyZzRQ?=
 =?utf-8?B?bnNSNklRekRtdUFGMXpGa1MyRjIvd1Z4dXZBdjhpa3UvOHZCVlRTOVlvNm84?=
 =?utf-8?B?dlJ3R0sxQUVSTjRaZGh5bFQ5dlQzeVpHdGFvbXJaWnl5ZElMUUcydER0OVNT?=
 =?utf-8?B?NVh2L0dOanE2OGNMb1BrMEN2VTk1KzZFLzRuRkJDUUVaZnJuMWhTRXh5VlpL?=
 =?utf-8?B?M0VGdWZRUW5BSVZwMForMGlZb0lsOXNORUw3SXpvZDg5UjZ1ZDBpSDhBMUxk?=
 =?utf-8?B?UVB0bWJsdVRYaUxXNXZ1YVBRSzg4NFBJSEQwZ3VwbzVmbWVvWEJoNzBrNEN3?=
 =?utf-8?B?WC9PRm5TamE2cXpVV3NPQUhXN2RMVVBkUkxPT2NKUHVEMDgwb21yRVJvK0Zj?=
 =?utf-8?B?U3NRZVFUeEltT3ZiWkxabWRYNVo3L0R6bTg1eWFXNXpHRlp6RjRwTS9nM3g5?=
 =?utf-8?B?L0prRDRhWWxpSVVFS3FIS1dwUVF5YXBNUDhFU2hVVmpwZllwOTFYQWxldmZw?=
 =?utf-8?B?cU50Q0lPbkVYejJZbk5vUklrbWVwVVB2blF2c3I0NEFOVUdXRXRoc0c4OVNN?=
 =?utf-8?B?QTFaZ2ZWVjhWL04rSkRkQUtPOFpMWmdaZFFpazFSZk1mUWNCaEVsSjNTR1py?=
 =?utf-8?B?SmhaSkl4NUhvTnZiaDh6bzlRMFJTbENvbnhtOVZVam5vVmFPSU9aMVo0SzdL?=
 =?utf-8?B?aWFNOTYxSE5JNEFCQ3hXdjlLcm9ONmVmeDAxSUt1VFFYSTczcFRRU3ZaT1BL?=
 =?utf-8?B?Nno4bTYya3lFL2NtOTRobTVBN0hNK2puK2JyRFhsK3RtYWo1N0Zma3hDVVg3?=
 =?utf-8?B?NHF6TEJrZVFGNm5sd1VldlZEcUh1U055dmF5aHNiTWNUcGszeENrOW1PYW1v?=
 =?utf-8?B?U1pIdGExOVJ4L1RubEtRUm0rWVJEYjczdWoxUlpLVWZWTkpSY0VjV2lwa0Fq?=
 =?utf-8?B?bklCbTBQbmx0bGlqQlhHZnFqZ1ljak5CZkJScTgvUkJ5Rnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mnd0aXQrNXJvOEk1MzZWckJSTFlidjFiN213am5tS25nb2dsOEpnQW41QlBI?=
 =?utf-8?B?emwycDUvbUpUZ3FkOGU0SEpxajBvQlB6MVVnbzhxZWJkWFF6dzJpcHJaNkhr?=
 =?utf-8?B?eDAxTFpCeENPaFF3UHF4RUg2SkhhVUowNzdtKzcyUnhOc3MzV1RmdzlFMkZt?=
 =?utf-8?B?OEdER1QvdWJDM21lL0xoQXlqc2daZURzVU1sU3dQME9ZVFNuU3EzZ29QT2pE?=
 =?utf-8?B?UmR3RDZxUStWZGg1SVNOTjZ6cXg5dDFVMlgrSnhlc2Q1bzdtNTNmZGFsaHVh?=
 =?utf-8?B?b0NWSVNuQUtQMkM5dzNLU2xtQy9Gd1hYWU1SaDdwR2ppUml1ejAvSFllZENS?=
 =?utf-8?B?YVFkSHdlTVFRanoySzNyUzJlSkwrQlZVaWdpK1NJM2c3UG9leXhxK091enp6?=
 =?utf-8?B?NFFscWlnQ3NvL0x4Wm5UNVZWYTdiRm5ybmc4ZGRMNE1tdnZLa1NTK1l3VTNt?=
 =?utf-8?B?NlV2aFhmNkh5TmU1Vm9lTnNReFdVNC9Jb01zOEJ4NTRkYnNhUHpxaFI3dDJv?=
 =?utf-8?B?aGN3Q3pvaElJcmdKSlJkZDNQeVI5THNmYUYxU2Zra2QzK2RRcS9DUmptcFhQ?=
 =?utf-8?B?cDdFcDRjNUZyTVZuWFpJR3RVVFhFL05jYXVTbnNWNFN1c05YcUViSDhVK2pi?=
 =?utf-8?B?UnJoUTNqMVhEaVhBZ0xENmJ5b1dQRXZKZHQ5SkdIRlQ4YkxHeE53eis3a0Y5?=
 =?utf-8?B?RnRVbkQvQUc1Nm00ZlhzWHk3SjlZM21CT1MxVmJZRUQ2T25PR01sTXcwZ2ZC?=
 =?utf-8?B?Q3hHMUNxT0Fqc1FOU0RsdXN2MTlKNENRNkcxS2U2ZFhFakwzTVpxUG93a20x?=
 =?utf-8?B?Z0hxMGJjRGNnZFZhbUhCT2tlWFpHelgyTzRXSSsrM2hFWDJlZ0dabGRiZFRF?=
 =?utf-8?B?eEFDenZQNXluY0NWdDRVcWV4ZHNwc3QwM1F6UG9LMGM5RWlmUFAvMmxNa3JT?=
 =?utf-8?B?ZUovblBpWk9RTm1OeHVqOU5QQ0poR1lVSDBMRlF2QnFBNDNmT3dSakZYUlZE?=
 =?utf-8?B?aUluNTNUVktWeWJ3aUw1cEgxTHJMcDZvdGdKZkJ4L0hYZGVEVjJ2M04rb0NR?=
 =?utf-8?B?SHRVQU1ZaWN3N096cnVxWEpzQitzc1hmbGxnYkFqZjgrUEE4Z0psVGhaMlRi?=
 =?utf-8?B?ZXk4Yk5uRjNsWFNIWDlvRGNNZmp0K3V1U3lJMmtTL205dWRBZEF0QWlYYVJG?=
 =?utf-8?B?V3JZYTZUVDhKMHBUOWt3ejFUN1NEbmNZUm4yVEVUTklxL3VaYkNWa2VHOFJG?=
 =?utf-8?B?ZktZNE9tUWVzV1Nqang0eVdCN0tiK1BnbGFlSkpnTExpSWUrWDg2R25aSERm?=
 =?utf-8?B?OFV6cUtBZDc4WnNVUHRlQStrS2hNVU1YUjkwS3BsRnlVdVRzRWJzelY4cHZz?=
 =?utf-8?B?cTRna2RTVkRzSjhzblJBbjNSZTBIY2xXSjM0UGVRRzdWTWFiWFl5ZTYrNW42?=
 =?utf-8?B?TlRzbVU5UGovb0srTEh0YTI5aDNKOWF1SkNyV0tHeEpybmNZSGwxM202eFdX?=
 =?utf-8?B?TXRGdkRzUDluWGhOVS9hUmJyTENRbExIT1Y2MzN0Y1VHUGZMdFl4R1VUT3RF?=
 =?utf-8?B?YU5YeWpiOEFzOStUcGxXRmhuUDd1QkIwVDZBQTlmS080TU5hOCt6cG81eTFU?=
 =?utf-8?B?dHViOXJXcmFXcnZ2cjR4TkhIRjNUZUYveTd5bHJTMTlRTUtXSVRPa2hWTVZn?=
 =?utf-8?B?L3A2akxScFhUYzRVSHRTRm9JUHgvRGU4SjY2K0NjZTZWOHFrL1RtMFNsOE5J?=
 =?utf-8?B?MXE4ejlWWE5pc3BRcDFUaXdkbDdKM2R5c0FVR3B4OFF0Z2czdS9DazVuODFy?=
 =?utf-8?B?RHdieDVxaGpUdHhMWWVMbzVCSWRxTnJNd1RZQ2RiS05XdU5vSFZ2WWRWZDcw?=
 =?utf-8?B?YmJkcG1hM2xrSUd6NVBydnRQNnRkUHhnU1FITEcvTkwva1FHOGJZblo4Ly9M?=
 =?utf-8?B?YndmZyt2dVV1TnZWZDhsU2s3Ulllamx1dXc2OGlUTWdTRldRd2Y5WUc4bTJp?=
 =?utf-8?B?bis1YStQWWdIV0FwQVk3eG14bUs5WGVOWWdEelJBcTk1K1lzTzVJbjE1NDN2?=
 =?utf-8?B?UTlFOWl5RGZZM240cVcxRit2U1YwelpsVkZMSExJZHBQNGN5b1Jpb1VoR2Nu?=
 =?utf-8?Q?efbU=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4789e099-3d44-4c0b-5038-08ddc58e0cbc
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 00:00:04.8851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7kiRdD4Sm++ctNaMoC7J9B0qg72QU8cVIxolVlMvWUjXytCS8altAgag46A39dW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDIxMSBTYWx0ZWRfXyLvbRUcNliO3 +FOiQbl6RqkPDWXv9TGTTfB3S2PbeWJ2JpBjx7WcvyeVgEz51SMSLbSqaGyHJnAmHVpUMstq84g oaF5P/Y+x5gBdRaujQ7hH2aq9xHTN548bTJR61I8dZDLi/2C51hCVX8/AGEylhqGWEiRdZtr4hP
 DHHw4MILTGkwDS1xwBw+tYVudG92Fb4i9kLS17QsUwuf8UAYAh+2p3K7Bqkz6m+UNfgs2IYLNNA nUXx6yvuWw8sgdVHhRUWh7Hw7eWImd+5fushIhDOYXM1Hc3wZZ9UGrhQctO57azUKvGrKCe6Ufz 34uV8lJb6OzToe2Ajn4x2489XuknXUvPjkr96b6t2EW7DTq5e6xNWNDIl5E+vec9bgRrSaGUTNX
 bjTFQ0owazWLhQZNbd3FTIz78xG4ODRLNlpubqmMMHjzIK0wi400aTuor5hjJcPyuGFURd/G
X-Authority-Analysis: v=2.4 cv=B7a50PtM c=1 sm=1 tr=0 ts=68798e87 cx=c_pps a=TmMIC04Ao4SyGwzX+1k7VQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=rPB-AxnlyNOECY8E_P0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GMjndMSswCVvVTHkYZTKKoF8LETbpWjV
X-Proofpoint-GUID: GMjndMSswCVvVTHkYZTKKoF8LETbpWjV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_05,2025-07-17_02,2025-03-28_01

On 7/2/25 7:49 AM, Peter Zijlstra wrote:
> Currently psi_ttwu_dequeue() is called while holding p->pi_lock and
> takes rq->lock. Split the function in preparation for calling
> ttwu_do_migration() while already holding rq->lock.
> 

[ ... ]


This patch regresses schbench -L -m 4 -M auto -t 256 -n 0 -r 0 -s 0 from
5.2M RPS to 4.5M RPS, and profiles show that CPU 0-3 are spending more
time in __task_rq_lock()

> -static inline void psi_ttwu_dequeue(struct task_struct *p)
> +static inline bool psi_ttwu_need_dequeue(struct task_struct *p)
>  {
>  	if (static_branch_likely(&psi_disabled))
> -		return;
> +		return false;
>  	/*
>  	 * Is the task being migrated during a wakeup? Make sure to
>  	 * deregister its sleep-persistent psi states from the old
>  	 * queue, and let psi_enqueue() know it has to requeue.
>  	 */
> -	if (unlikely(p->psi_flags)) {
> -		struct rq_flags rf;
> -		struct rq *rq;
> -
> -		rq = __task_rq_lock(p, &rf);
> -		psi_task_change(p, p->psi_flags, 0);
> -		__task_rq_unlock(rq, &rf);
> -	}
> +	if (!likely(!p->psi_flags))
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^

I think we need roughly one less bang?

-chris

