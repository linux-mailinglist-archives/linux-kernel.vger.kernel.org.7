Return-Path: <linux-kernel+bounces-874032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FD0C155A4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F5A188E99E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC265339704;
	Tue, 28 Oct 2025 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="pOgUHxta"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020100.outbound.protection.outlook.com [52.101.189.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A782765F5
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664111; cv=fail; b=hgmrL4uP9WCqqIk0wa8HileF9jQD4XY2ykwbRyJZuW0YbB8Ak+sSMLCHwqa7/MbLJ+WNmaabeY4pP+eXAqg+9towwulG2oYbJ2vvP7FGzcaH9OdQ0lleuBj5rjiWhkz2ujejq90ib/4cnmrr1EX6bfp3xvzXFbhjSvqnbW/bnyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664111; c=relaxed/simple;
	bh=l+bixAkrO496iV+DCIPKQln42ud21A1niqKwpr6uitk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rm3zb69aJph5jH1r/11alF2+Mnentv8B4gL4f8ozZV4D+bWWA3px28AMs0alkmfg/WtTaqnH78j/okb9pgTHsw2GDx4VUI9gvJy/avw0LmC5OxQ5/4aeBnpCrLnW+DdESWmt+4JQuOp6D2iQlYAGjHiFxU7d27mgEaZGFMSCaaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=pOgUHxta; arc=fail smtp.client-ip=52.101.189.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlzHC1zYJhyy+veQI1Hij1mN4wbOZeiVPRLmps5P1kBH1k3FZxe1zFkAtJ0Ij4YKdMWvZ3Z+chQMC/etEzjqkEltKxXWaHEMp5uzb8kpkwkzP/9nG6PUFGTnluo4HWzPc28Yu0/dZsvPLB6B2lBTk7Rx/vA/wgyYkszMHFvGHuX+2XYM0mIoKJbami31h2u5itVFEYCAVdsybZtdQUz5d8hnjxq8yskjpdHiz5N5qHurFikxZgIc/H0XCHZhrWrv/3twgcO9bacjWnUwG91WHG1iHTvahNQH59PA3fF0mIV6y9oBL1o7mOVXtvxB5Z3be32oDVynHiv0xZ6NaccO2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JHvKyySp4Q7f83HDB/gj529II8SMMkEwLkuSmpTjIs=;
 b=FyzSg4w33zaVOjJyTot67dnpY0BQyEM+PogCRLuInzxubkmQoM2vzXP6duQPgWvdsFXq/5lhC75acHEp1pZwWEDP0yvoJbhAXYTtBhi2nfStnqjNIk0Z84eTALiJMVR0T9XQHmlPCVyafkPRDDLhdN69AdK65dCLqrHBOeOTVLX/RS7AZ7+ZUyX+UxNZBdYqUirmAF0rUROhEIPR7Ore7f+2yKt48tJgAn2GNS9U/BIz0l/INSXqCNRW2OpvT83heIzUEOs9HmYhmgwmP1bdrUsh06QtsK7quAvDmPO8kquPr1hNoO+fiyQibqVYIg7zj4/ruRV0m1QmUT/QzTB76A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JHvKyySp4Q7f83HDB/gj529II8SMMkEwLkuSmpTjIs=;
 b=pOgUHxtax/0lG11q+vvS8QhOSREblVXJUpFDo9b3fQW6m7gbklCZ36PtUDplQs5iS74gaHVJAeEsoPNIhxVJQlJKZIqxNCRdw/7spZ/Itma/Sp4iO8IZ+qNGBnmRs0shcXH37VTZsxLiGXq4QB8fHfzwaYy6/P3KDFO6uIpXG1vYorRknnsFzmV5K+9yiR92IOYOjg2M6AjoIZ1WtltgRTOCMU7vJgWGmoypci+Z7i/QF1XNVEYigyv7VcmTQRNRdkRBILhM8/S84aJ45XO34WHii4zreWNycgFc5T3sUt2Sp6ijPJRUECLc+bH8Rip8hnwFs1NL1igePykuOalbVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB8142.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 15:08:26 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Tue, 28 Oct 2025
 15:08:26 +0000
Message-ID: <365bf960-9850-4e34-8a97-c048f199b151@efficios.com>
Date: Tue, 28 Oct 2025 11:08:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V6 07/31] rseq, virt: Retrigger RSEQ after vcpu_run()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, x86@kernel.org, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>
References: <20251027084220.785525188@linutronix.de>
 <20251027084306.399495855@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251027084306.399495855@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0235.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::23) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: d70b5454-5561-4a9a-950c-08de1633d811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1dhWk8wYXhudWk5eVZJRHQ1K1ZOc2tOc2lXSXMxczhCMm9GcUplUGNPRmtu?=
 =?utf-8?B?L0NIQlg4VTRNWW5jWm9sSGs4dlEzdnlEVmU0dzZYTVhTY3pVaUZ6a0U2NHUy?=
 =?utf-8?B?blBDOE1GL3gxYVZ6MjhLcWkwckh2Y0YyMG4vTWVEanFLUU5tZEdBUFN6aG1Q?=
 =?utf-8?B?cGRTN1VOQ1pCelduMzUzZ1ZKYjBvOUdJN1FFZG1uRWdKcWxTalpBV1oxbno5?=
 =?utf-8?B?OVc4bC9ZdklRMmFNS0NhU3R3M3VHL2pxTGUvVHoxSWZOL2d3RElXcmF0eFdh?=
 =?utf-8?B?Q0JQUkp3YU4wRkF3aTZHKytNM1hYMFd3aFVzSzdUOE5oNjdRYlVieUd0K3lm?=
 =?utf-8?B?by93bFZPZE9hdFNIRjkzbVI3dmROc1k1akRzSDF4U0tPZlR2ZW9NRXUyRk9D?=
 =?utf-8?B?MElCcm1rWTI1QjlGb1FDaXU4VzV5bkovbC9jWmJ2MWlWeVhwRnZVNlpJUGNE?=
 =?utf-8?B?WTYySWZubitlclR3MTd3dlNIZ1U2enU1Z3RlTEJmL1FFS1BYaGtjN3ZIOUpW?=
 =?utf-8?B?cXlWUnpmdjdNNFU2bURhNU40NW9mSWJLTlhVOGdHYjFKSFlHeldTUW5QNjMr?=
 =?utf-8?B?dDV4TEE2QnZXajBRYWQ4TjgySjFrbHA3ZDluaGp5UEJrbnNjbjZrT0w3cytT?=
 =?utf-8?B?dXpxc2lwRm5zdFBKT0dGKzhlbzJ6NURwc2ZjcEw1ZHFTa2dpR0dMQjFjeWQ3?=
 =?utf-8?B?NzVsbk4zL01XdEFWVEx6MHdDaitsbHJ1dHRhZzdEeE9kRzFnRzJIdldvYUxw?=
 =?utf-8?B?b1YvSEpJekNsT2VvZWNVZHFaYnVrRHpRUDBJZ0pMZGJNMGZoSTJNaHQvZUNs?=
 =?utf-8?B?MkdVS3pBZVV3STk3N2pUTHQwN1d0TGN4dTFZdlZYdXU5OFVwT05jUlN6ODJa?=
 =?utf-8?B?MlQwMi9oOGhVdXgzbWUzZVVSZHhPUFhraUZ1ckFjWmdzNXNuemhaNkdpSnlW?=
 =?utf-8?B?VUx2dUtyWmhVMVRxaUswcVBoMmx0WWlETmxGNkFpcTJINitCVUVUNk5wZGdn?=
 =?utf-8?B?UG83aXoycEwwRWxEbitISHRVMmlEL0xVYTN5WFlCZGpxelE0SE11THNKdFVE?=
 =?utf-8?B?VnQrTVBzcU5WZnhGd2gvYVFuK0EvRWFuaklDemJFcHYxcUl2cHNYek1RQ1Jk?=
 =?utf-8?B?eE1DTUM1bmM4OGtaYVNyV2xEN3J1c1RyTGE5c3d0MWF6RzV5MTg3Ry9rUU5z?=
 =?utf-8?B?eDNHa1VhS1RlYmkreXhhVExZVlBjWkM0QnFpL3ZOUUNzcG1KWkxhYTNlTkRt?=
 =?utf-8?B?WjB4U015OEo5TjMvVnhsTTZ6NEVYK0REQXZBQWZHNEZtRGVGeW5TTHRWNFlM?=
 =?utf-8?B?NzBzbStVVEY1UTJvbGsrd2JhMGtnbTh2YTJpdFV6SlIvSWMxdlhRcFFJd0Ju?=
 =?utf-8?B?RnlPNmRSUFFQNVBEQ2ZHemhBVGk2OEJtcGtqSzJWYUNLOHlNdlVnaFMraEdU?=
 =?utf-8?B?eXUwTktNQlp4WTVZNlVHaU1UV0EzK3ZXOVgrNHlMOFZ4bGlEZStwV1dxZU5C?=
 =?utf-8?B?ZWRRVDlUZkxIenhSdkhQbTEvVG5JSE9PcWs2azl1eE04WEpFK09HVVNRNzBt?=
 =?utf-8?B?Y1dHbXpkckJvdlVERzVGZGkzMTRrNS9RR3lFRTZNT2JBNENHVkliSDMyY0Vz?=
 =?utf-8?B?WjJZbDRHSDBBSmgzekpvZTJ4d1h5UGl5T1Q3TStvb0Y4d003SzhZTjhkcHda?=
 =?utf-8?B?dkJBaTU0QmtjZzcwb2pSZmVsa0Z6MUNJOVZ3QmdQNWJaVUkzd1RlVGV1MUc1?=
 =?utf-8?B?cGd1ZzlzQlU3d3BpYkFrZTdITnBURnBvZUJJOFhRaElrNW85VWIzMmJ6bHJY?=
 =?utf-8?B?eWtFa05UOWFrenFCTC9idmNYbzZLeHBLa3p0ZTBSaEY5dm85T0FsTTNPdEZL?=
 =?utf-8?B?RlJTaExqaFRod1hXcEgxa2lHU3JJZk1nMFNQaFRqTnN2Unc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDNqY25uc0lUcWYzbW5Wby95bXVUT2RWditqQWVSRlFTVEdTVkQxWERPbUNx?=
 =?utf-8?B?RStoMkIzbUFKNHdNS0N0WnhQd2g1alN0YVkycmFoSGZLSHloVnFKbmlCTHRS?=
 =?utf-8?B?Y2FRQnk4SkRBRmdORHluL08wbndnRmE5MlkxN21MUTQ4SzVlV2cvOCtqbnJn?=
 =?utf-8?B?Y0VNN0JYdS9JUXFKdmRsVHh2N0Z5dHYyWjdhY0J2cnlRMVFRblF3c29GS1Zo?=
 =?utf-8?B?ZGVVT1ZsWXVIYVNsay9VZUxXREpWb25KNjZnN1hzaUo0UUJWT1ZNVGMxN1A3?=
 =?utf-8?B?ejI5RzVpcnBlbDBlMjA3MVNNblVNT3ROL2E1cTlmWVJycGYyWDZZOWZEaXBj?=
 =?utf-8?B?MjlLeXZNYm5MRktuSFd3UnZvNUdVTEFqd0F5K2xnNFJYbmlxcEJKVTRLcVla?=
 =?utf-8?B?NE50djd5K2txbjhNalNWbEhTZWM5YnFGQVFyN0NlTEI0MFRGU283ZTJIRDFQ?=
 =?utf-8?B?NEt4bGk2SUFpOGJWVkJkdXhibHlYV0dpdVNEV2M1Y2d4VERqNnlic20yY2Q3?=
 =?utf-8?B?d3FIVEtCeHlYOXVLbFcvTGxiWElSb2ltMHFFdVRybDVkUkUrdTdYT2llSVJG?=
 =?utf-8?B?ekxJWnpQbEVtczFYK0J1OWxUSEVpYkhIYjdHZFRwM3VOZWdEU0ppaWNHa09D?=
 =?utf-8?B?SGl2cmtnc2YrYm1LQW9ldElnTGhrQ05VWFNMVlNvNTFNYzBVRlJHOUpVM0dM?=
 =?utf-8?B?R2dScDBXWUN4OENQdm5tcXBwNXZHUXhyZ25KenZpVkQ3REs1NDRsNVNhK0xD?=
 =?utf-8?B?ZnczYmx0cE1KdkM0bDFDWHZUNjYyRDFoMlpGd2FHYW43RENqSUU1citGOCtM?=
 =?utf-8?B?WkZONzZDZm9mYjNnL0JHNXdtSVZyMlVmaDVJbkJQdmFjK2FoN3ZNZUpFbmFh?=
 =?utf-8?B?UWRGd1dRUFRhWnA4N0JBWXVoUlJzTUpxVURicGNobzJCekFUVGpGKzFMcDdx?=
 =?utf-8?B?cUlBZEhxbE1zc1NlcENUdmJSUXF1d1d3cTlMTktpN09nV28xNzd6RFgwMTJx?=
 =?utf-8?B?TGc1MmdmTk1qMzJOQXVZUldIR2F4L0t2NXpCZkYyNTlvd0lFUVlMa1VpYi9P?=
 =?utf-8?B?Q3N4MitYdDRHY0Q2OWh3dHpBVEVyQisyQWxpNFNqdHRyUlBmck5JQ1JvOS9E?=
 =?utf-8?B?enpjdzVUdGlxWUhaN09rZmpieFkzLzdrYnp3eXhWS0FMcW1hdEpLd3pFdjlh?=
 =?utf-8?B?OSs1amtSZXhCaWVYTkpGRnBkUWpqZEsvVVhxNkQ4N3B6bnZBSDc5TUs1blBW?=
 =?utf-8?B?bWlabkVNbG42em9mTHVzMEtIaldOSS85NjdoakZwVFNwZHZ5eUpxalI3Mk8r?=
 =?utf-8?B?VG1mSUROT3NQajdXT0w3ZWprVEovSVc0aFJRekY5bFBmajlyYnZJdjcxQVIv?=
 =?utf-8?B?ck9EeWFXY2xYTHhxTk51YVJwWEtOQW9NcTdvUDkxdGFPeEhRKzByUHN1bXRa?=
 =?utf-8?B?L1NYT2NRTFAxWFJOYWFJRzBDQzZveGI4UFRmSVluWXYrMkxCUEZZeVVMYXFK?=
 =?utf-8?B?MGMyUXArWm9IYzNKbW1rNXh1dEFnNXZISHoreTBnUGNNV2tuVXZnVEZ4eDdC?=
 =?utf-8?B?Y3VVSGJvVCtmeWh1L2p6TktnMGhreUY2ZnM3NGdLU1hhcnhMSE5KZmhpUzZB?=
 =?utf-8?B?c2g5Snd5NllSV05yVmRjNk5kaG1kSmxtUkM3S294V2dTRkphaUFTdDI2VzJj?=
 =?utf-8?B?YVQzVEV6Q2lXdGJ1SjNabFZNaGN3ZUVJNW5pWXV1NW1uRGZEUXYxdndVN1F4?=
 =?utf-8?B?TDd2UDBTVTJrdFBvdDRDWmRWZXp1WEZSV1d4Mm1kZUhDbTR5emdCOVFrSXU4?=
 =?utf-8?B?TGJZSkQ3VTZLQlVJWkxEZ29ER1lidTMwQVhNVFkzTjcvQnIvSUw3RkgvSmZQ?=
 =?utf-8?B?UGZCM2YzNHpPd1o1SWNoVWdZY2hVUWQ3eUMycWJvTkpIeVZ0dlRVU1hZUC9x?=
 =?utf-8?B?b0UzbEM5ZHlEeWt0eEE4MGRIQkJybHI1eU12d3AyeXZ6dFhOZUVES1R6dnI3?=
 =?utf-8?B?Ui9sa29zTkF0VVFqWWsxM2k0Y1QwL0ZSVzdkOXZFUUdtaXVZWkxaaGJQWXR0?=
 =?utf-8?B?V0ZzR01ERnFHVjhLcHhLeTJCK2ZyN2ZsYlhqYjQxa0NYRkh3VDN0YU5mTlg1?=
 =?utf-8?B?dXpqNndZYmZydmMrdHNmejRJNU9rMGFkYUtWSm5BUDREbnlSWVB5Zy9HWnZu?=
 =?utf-8?Q?lELwlrrVWw4xEJFnMTyk6hA=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70b5454-5561-4a9a-950c-08de1633d811
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:08:26.0722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/2hqggArq1zmvLPoiEHcc55ucMhlrHLATWiIVpxTQYs+92MRqlYKqkozbIsa/8dv9WewWRIEmPJXd23ndaV+t0nCrCre7fbhjtZIZn1og0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8142

On 2025-10-27 04:44, Thomas Gleixner wrote:
> Hypervisors invoke resume_user_mode_work() before entering the guest, which
> clears TIF_NOTIFY_RESUME. The @regs argument is NULL as there is no user
> space context available to them, so the rseq notify handler skips
> inspecting the critical section, but updates the CPU/MM CID values
> unconditionally so that the eventual pending rseq event is not lost on the
> way to user space.
[...]

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

