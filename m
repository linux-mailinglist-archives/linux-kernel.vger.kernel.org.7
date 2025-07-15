Return-Path: <linux-kernel+bounces-732185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4243FB06328
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F6F189B292
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B516C1E9B04;
	Tue, 15 Jul 2025 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="g+cB7A/Y"
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2268C2566;
	Tue, 15 Jul 2025 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593907; cv=fail; b=aN3IiAOqXe3Qhx+VT9ns+5Ar6PxTfRf0KwDvH0PBH9xj1ClGMWvzLEhRVfUSz31t9Chu//mFnWEXMSCiCzCiWY2EctGzOfm87oQ6ZepL5vhXArvy77CB91TXeiQ2ZGP18soOPAaeNRiVc7Dz8gggytjZuCyt8LUmvbJ8RSGBibc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593907; c=relaxed/simple;
	bh=3h5ZYNuN1Lk9EsP+9YGDcVyQW21NBlFehcYiVcy/EDU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uuxGEAUfE6aHt98/ubg8lTERUiXljC4fU9BjIXTUq6fhlkEkEVynfYcBeyGt3QlQCkaARwmvwiEUL+2Y3ILniFcHoIBzSXfhhde79kZ0s/SY5nUAhLMilJOmtDuqlqXV09ZbiYyXBFdE/rh0iLoUJ03H4bmrllQfQLSZXlB+MYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=g+cB7A/Y; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FF86n8019506;
	Tue, 15 Jul 2025 08:38:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=hjocAUxzLjOkllVRwhLtYPLVGTYZ5GSLbe0S7u+YiI4=; b=g+cB7A/YvnUu
	R7TquR38E1SEuaDTdgELa4nUgDkdFF/m71Ywb/Fdg7AuMNjsW8lg2ahbGwKowKaO
	Kw7uFMeg052O1pYhVY187Hnpdb8mXr8ZboiLf9bp9JxMfn87GTlQ75Q0GaMxQLG3
	Ty6eQpq48fCSye1bxkFikn19gRJfXSNRpDVdhDPyifs+NEoSwRyLHuGNRbY55fHm
	JH5DJuX0zGBJirSX3G+/OhOyoPxhsRZ08pZH66tQlaF1xMqq0Mz01olv0vrlsvDb
	w7PZOEdVNpCHJbUeO9DThjSMuW9GQeLZLAMwA0NVwv8jH84sNpriWyL0jbJyvtX0
	8+j9h82C2w==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47wnk4t5vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 08:38:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/3Kqo8hKFec7BDQWQzTT89nQWlNOmFXhEJe9lJYeJMjVlcjSxZC6NPQSRNrRd8GfAc5bdqmrwM2ucwi7x8YY6rmqw94NP+FETmN6kaTm8wEfREe/g/xMNDCXIR6h3hG/0oGE173ocjx7Fhz/nGICrx8FKyj+GGaW8YrRoX3FCCAbglQeQPRaagtv/oQ+arq5shdNLK36v3czJWoa4kMevUYXpXsq1yIcs9yCXOMYYNM4LLPRUufwp6Pz9HbaTMFwocs0U9u0WODBXCidM+T/AF/kLOSd9iG7UWKZKLxNM0KeIg5JWSRtxb4OS9yVTn/K1c5VV1uWxJSeNnQ0gy+Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjocAUxzLjOkllVRwhLtYPLVGTYZ5GSLbe0S7u+YiI4=;
 b=cHX+zw+GTCyFAi/un4j/cA3tqPy10Z7DXF5H71c3kRYj1CijJB65POMmNm/IUR2LbYD2zqGESsh4pYWuLTTV8uR9tPkM00gkV5uXhswbeDDpPDMht3m5rmqHUkIBlixDMjm7Z6+h7532lk1gyMnK3By2723TqfTtv3mqXdhF/BEYEGwrAG7fhqX+W5ndSA4gQBcTSMQm25nwIHb/YX6BEDnuozVfzaUxiIdS0lj8j+A+UZrcL9Zo1iCmE2n7jchRBlUd4Kz9XfoOfsqb7hAKmX8k3hJ9sVQpx/RaPbZ71gEN4Nb2BXeLQpuVAW8COFtw/uEPWe/7iZ0RWCeaCbSEVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by SA1PR15MB4822.namprd15.prod.outlook.com (2603:10b6:806:1e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 15:38:17 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::2f8a:961:d95c:3b35]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::2f8a:961:d95c:3b35%7]) with mapi id 15.20.8922.025; Tue, 15 Jul 2025
 15:38:16 +0000
Message-ID: <c8c89226-f9a0-4cc8-bf7a-fa65a1fe790a@meta.com>
Date: Tue, 15 Jul 2025 11:38:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: bump sd->max_newidle_lb_cost when newidle
 balance fails
To: "Chen, Yu C" <yu.c.chen@intel.com>,
        kernel test robot <oliver.sang@intel.com>, Chris Mason <clm@fb.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
        aubrey.li@linux.intel.com, peterz@infradead.org,
        vincent.guittot@linaro.org
References: <202507150846.538fc133-lkp@intel.com>
 <10abe013-98d6-4080-ac43-0f1e02aa41f9@intel.com>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <10abe013-98d6-4080-ac43-0f1e02aa41f9@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0434.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::19) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|SA1PR15MB4822:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c59f13-b743-4ef3-86ae-08ddc3b59e2c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OW1CY0ZjTURreDFjNndBSUdIazNJc1NKVzl3cE5UT1FnYkhsQXhHOUR0TklU?=
 =?utf-8?B?SUlsSFlBaDdvYjJmdjZpWERCQXpIVkVySDNaYmJUQzdpMnVpSmVINmZHRTZw?=
 =?utf-8?B?YkRmeVJsTklsUk9kZjIrZzRjb0R4UlZ6Qmhnanl4Ti9idmdQc3dFVVNSYU5o?=
 =?utf-8?B?U091UkJ6a0dla284QmJINE9TVEEzV2NFMHJjRnJFQjN1bk13US9aQmlBdDQ5?=
 =?utf-8?B?S0tWd1U1cFJXQnl5Vit1d05EYk1IRXlsam1PWWpHVG1YdVh3WVIydURQaE9j?=
 =?utf-8?B?NmlkTDFrRTVIWWpVT2Q1SjhyWkt4NHg0TDdXWmhwamljcXNySTA2NEdjSi90?=
 =?utf-8?B?UTBQdjAvOFBWdHpCTFNaMDg3cXFSbEF5anduajZ0dlNDY2xaZ21mTjVZYUxv?=
 =?utf-8?B?YlJpWEw0R2NpVEpMcS9uOXQ4VmRMays3cnN4NlBhdXJPUS9RQSs2REFWODgx?=
 =?utf-8?B?emhJMWhpbEZqck81WVRHWWNjTWo1TGxDa0kxNmhzRzF5anpSK29jTENsTDF3?=
 =?utf-8?B?TVU3REVDZG0zRXk5NllacWdGS1dtSk1zTjBoUHBlSENWM2U0UFRqL005VnJ4?=
 =?utf-8?B?a1hmWEI3bVFZUENEOVQyQ0NTdER6YWtlZzUzV0ZLd1NCcGxiekI1cjNvdU1J?=
 =?utf-8?B?RUtKTlowYmxxayttbG9iRUVkWVo1dDFscTlyUVdGbmk0cm1Mc3JwYnArZUU5?=
 =?utf-8?B?cmpVOWg5KzdDcnhqS1JnTUFFQjJzalB3WFZGNUcyeERwK1BrNi9aUDhNSDBL?=
 =?utf-8?B?RGQ4bmJEbVU0OW5hTTRoM0hXRFQ3QnpDT0ZpUnFDVFhEVlBvNzRzU0pDdDlj?=
 =?utf-8?B?Ny95M1kyRWJhd0ZJYkNzNlNUdnQrbnZJTGZiRDhXNVZOck9UdEFnWjA3VVFz?=
 =?utf-8?B?b29SUEhYeFU3MW9TUVZERzFHZGtZVUZCOWhhQklrV05lcU5CYkV5Q3Y1WHpQ?=
 =?utf-8?B?Vm5DaVpWTE5pcGdZWlJWZ2hTZUpmclJSU25pZzB6Zk1ncDl4WEZnQis0b1BY?=
 =?utf-8?B?RXBBcGRyS3FWUHN1WndieUx6Q3l3Z1lnT0lMUyt5c1oza0VKbjYwYUo5T1lV?=
 =?utf-8?B?SG94K1hJai9rNDJQT3ZldE9EYVRKQk12S2FUQ21mMlR1QjUxUjdNQWwvYXJS?=
 =?utf-8?B?T1VJMlc0eUlIeFlkVVkyb0lLcjNxQ0lsbHBuWW5zd2ZNNFdVTGxlMXJOSGVi?=
 =?utf-8?B?M0E1Zk1MSlNKMWx3VWtJL2owWVFVMjVkSGtJS2gva082TGVyUEZKa3gzYkRO?=
 =?utf-8?B?Y29qQ1J1c1pXQ1F1dGNnbFVTZ2w2Q3JHOG5xU0liTVV5anY3Tm1TR1RMQUNt?=
 =?utf-8?B?Rnc2S3dCTFpjWW5PM1NHenJXcjB4ZStjaWV1RVkxN3dQNG0vTDRpQUhkRHpR?=
 =?utf-8?B?ZWtJSTFIamlGc05IdGdVZ2dROWV1SElDVnh4bURuVmpLbDR1ZldNNzFtT0dS?=
 =?utf-8?B?U2lVY05iZHpFSmlNOU1RWXo2V3JNWU02bG0xTVZWUTNhVlhlYW1EUS9LUks3?=
 =?utf-8?B?YUNUaVB6TXBobnlpQ2h1SWhQbjArK3JyMld1Y0xOTmVORmM5MTdRMG1Lb0hm?=
 =?utf-8?B?MGhFL1R6UGtxdy9uV0E3dkpMQ2NhNzZmcTFmalV0OVQvTjVjUXJmZG5yOXhw?=
 =?utf-8?B?OGt1Z3lTWGZlN0Zmd3V3RVBiMld3NUVMbGsyYXF0cG5STGdKejYvZWQxUGVD?=
 =?utf-8?B?czEwUnFwWk8zblUwNENSQWh2OUJIWG5DSzE2bVFVRmtlSlVCWlRMQ1pzenVF?=
 =?utf-8?B?MDdzRnlYQUxhWUdNaGVlTUFNem5YUkd3QjQ4QlZ3eGZyQVBwcklJYmtKdmFT?=
 =?utf-8?B?MXpzQlR3eUZqYjZlYjR3SitBblZ0U2c3b2I0Y0sxQnMzOXRjQmdzNG8rVXd4?=
 =?utf-8?B?U3AwUlpRamZzSGFONmFGck9uMmdPWnpQZDJoM25zYy9IajhsY3NUMGxpTDc5?=
 =?utf-8?Q?eJx1G4JxlRo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnljUVF1cG9UWUhXeUtSY0RUM1FRUEI3MENWcytOSEI4Nit2ZUpQelV0eTQw?=
 =?utf-8?B?NzVuc1kvZzlLOEw1TUJuZUZtL0x0QjFTblN6NWRhQW9RMkI2d0pycGZzKzdV?=
 =?utf-8?B?Q2srWDhqc3I3RlMwRDdOeG9aRHE2KzROTU1scWE3YWQycjFNMDhmR3FiUXZV?=
 =?utf-8?B?TFZuYVJINEVZRWY3UlhwUnJ3TlY5VUR4SHJ5a2VMaHgwY1hVU2ZzVENpL2k0?=
 =?utf-8?B?Y21LcDFSOWRoNjFrY1Z3dzFkbmw1aUVOZTlOT3BUUUtHVUhNeTZRWlhHL1dw?=
 =?utf-8?B?U1RDVE1vNzU2WmtzalZTYTZ2LzV0YnZaM3lMQzJwcmJKdFV3WTIzM3BqcGox?=
 =?utf-8?B?bzRhOU5BSDhEc0hmVDNJQzlPa0c2ek5tVmZsV2Y2MlYvejBUSnM2UVBQeGpS?=
 =?utf-8?B?RUhoQWF6NmlsYjFxY0ZvK0llRkJFM2NwdGZkVUhaK2RPZ1pUYXRjUFhoUHZB?=
 =?utf-8?B?WEpnZE10RUZjT3ZUUmQwUTUvMjRZM1JLQSt4ZGx6dGFqK0VqUWdYYlltbFBC?=
 =?utf-8?B?UTBwQ0tpbklHd1VPSGo4RmRXSThLUUxPU2FKY1UwMzdoZkREcjZ1VmFRa0xK?=
 =?utf-8?B?ODkzbDhvakxRSVZBazhpaEhTQ0JyODAxRmdJdUcxUGViMklpd1ZESExucmps?=
 =?utf-8?B?YnFyL3plSkF0WEovRW1oUVhmWmhZYjBkdGJJZDYzcjNacU1qcHFjU2cwWTdr?=
 =?utf-8?B?emM2czJmT2JGQytUSHhLN2NOMFZjaGE2S2R4ZWNCanQwSlJZZEFwMXlXRzUw?=
 =?utf-8?B?L3RTSzBtd3M1K1JmcXA0WXFiLzBOQlpWSytYYW4vM1E0elVsTkhCVE1ZdFo2?=
 =?utf-8?B?S2pLMmQ3Mk82RXE0S0J0c21PRVJ3VHhyQk50U3V0Y1RQOVM5SGE2MkcrR1By?=
 =?utf-8?B?ODBZY05lbUFTaVRuQ044Mi8xSnl4bXdTU210L0J4UFh0Y0tSQ3djK2pvdVVv?=
 =?utf-8?B?VldnYm5CUzZRL1V5eGovejZqNWdwem54UFA5RWZrdDhYeGJrTmtFeittQU9I?=
 =?utf-8?B?S1JMVmVvUlJ4NVNNUzcrVFZ1azllL0owUXlVejN6d1ArMExEeWVlZllTYXV5?=
 =?utf-8?B?Z1JSNVZiQjVDUUUwOWFkanRCeFVCTmVZZld5aFNzRWplSUVtYkxQNlJXRlFW?=
 =?utf-8?B?RUxsNjQrUm55TEZZV0pya3lBWUgzVDYwRlJTeUlQQmxkd2VadU1peUdJb1ds?=
 =?utf-8?B?dFA1eTVIRUpiNDVET2YxcHFldkxCOWVMLzBNVjhJc1h4NFlaMFljQ3FNRGE0?=
 =?utf-8?B?SE1LTFRZK3hCa0lPQVV3bzFaVllIbWNKaTVKM05tdG1uYmwxUVdMZUo0OU1D?=
 =?utf-8?B?SUlNRkVveUxzMlp1U00wRE5TMXVsVlVFZHE2OWk2dHF3YjFqc2toUUhDemdv?=
 =?utf-8?B?a1hlOTFCdnJlZFNMTmM4ZUJnR09DenRzcjlPcFRMV3BLSVY0Q1MyUGNabWJa?=
 =?utf-8?B?RmlyT3N5YzRGa0JMN1h0WEg0Y0x5RE01UitXbG51RzZ2bmkycWdMWUZseGRz?=
 =?utf-8?B?b0Ivd2hlNmhiSGZuNDBCQjRidTd4VFNmQ1JpZjlWZ0lELytBcDdERkNQUFJk?=
 =?utf-8?B?Z2pHRjJ4ZE9vZ0wvS0pkMnRSNm0vQU1ib2ZHRzgxN2FsMWRDdlpYMWpxMGFO?=
 =?utf-8?B?b2IxY0oveWtyNGRIbkhrc3d4UGttV2FraWVSRVowSWdJQTBvU1p3bjhqcFAx?=
 =?utf-8?B?WWtFKy9YY0F2Lzg4Rlc0QlAwZEJzMmZOWDdabHptc1dsM0l5TFozMFV4aGVw?=
 =?utf-8?B?NVhRYzdsNWoxTHZhRW9GRDRVTkZMbkpBNVlxWHd3a2E5WXRFK1E3cnIrTHhx?=
 =?utf-8?B?OW5tUzFUMEcrTWJKRnB4Qk9zTGVIUS9KaW9xd0ZGU2ZOTzVoU2twZ2NEQ2FZ?=
 =?utf-8?B?NUhyeFMycEVqNzlCOFBqSHYrcEk2R3ZiczRlMDAyc3BEeEJqQ24vOUZiYUNY?=
 =?utf-8?B?a3pWN01zOHQxT1dsNXhGTEQxZXo0bG4xb0EzUWhNM1NtZm8vdndWNGpaN1Y0?=
 =?utf-8?B?OVJPR2c2K1owc3FLZy9uSmhHaVR5NG53Z2RwMnJ0eEdHOVdnV0hkWVlSU2FN?=
 =?utf-8?B?WFNHVDJTekFaUmE0MnpBbjl3bU1kQ1FFYTMvMm1SNmxINnQxNTFhUlJJaEgw?=
 =?utf-8?Q?du3g=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c59f13-b743-4ef3-86ae-08ddc3b59e2c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 15:38:16.8311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVMBf2GQulbyK4zBC4hCxS2r0FL+d3KV3C1u86gLKNKnxOPD1GBeYlUfzctOUM9H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4822
X-Proofpoint-ORIG-GUID: Q0bsUfst9f3gLSEtP2QsiXO5XiiqorHA
X-Authority-Analysis: v=2.4 cv=fN853Yae c=1 sm=1 tr=0 ts=687675eb cx=c_pps a=GHFRT9iJO9BovS83oyvw+g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=FOH2dFAWAAAA:8 a=TBcCAj8ITocztAwLIxwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Q0bsUfst9f3gLSEtP2QsiXO5XiiqorHA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE0NCBTYWx0ZWRfX7aM/VL6ZqKmD Q+ECsI2CPfO8gXC50afTiwMPEJSt0bb4mFIw+BCgPskgA4QpIzuAVvpwBzpNBMpYSSZmlOCR3wd v+ebOi0sAF/D2MUUqPlov9GYt1NBC2c0UsxDgo2uSEsrFT3mD6NT7vOfoQZ2LRLHZBzjVyilhLd
 dlXSz65oW0Hl/msX0XA0oUobsCmnIDjCZII2i2Hl2a88Y/WIXjTRZPMo2p4HV6XayrRLYG8YSRE Qur9hRsdGxpIjx2BJTNZsUoZtE5saYdYLnnVDKLNuqS4eQaAz/z2W6qNsaN9tcQY4oxYluglMAU rEZbphPVZuLNFn9gomAgmqrkV/MjNXtBJ1D5O/4gdUDhAyDw74UISZS/yt1XvryrKbFC5vOGpNx
 49OyfapEpXX/zFK5aN2KxdmmAWnH2vJIbqW3PRLEmce+ZEVvTjOeNFMh30BuH8nHq8KDOdA1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_01,2025-03-28_01

On 7/15/25 6:08 AM, Chen, Yu C wrote:
> On 7/15/2025 3:08 PM, kernel test robot wrote:
>>
>>
>> Hello,
>>
>> kernel test robot noticed a 22.9% regression of unixbench.throughput on:
>>
>>
>> commit: ac34cb39e8aea9915ec2f4e08c979eb2ed1d7561 ("[PATCH v2] sched/
>> fair: bump sd->max_newidle_lb_cost when newidle balance fails")
>> url: https://github.com/intel-lab-lkp/linux/commits/Chris-Mason/sched-
>> fair-bump-sd-max_newidle_lb_cost-when-newidle-balance-
>> fails/20250626-224805 base: https://git.kernel.org/cgit/linux/kernel/
>> git/tip/tip.git  5bc34be478d09c4d16009e665e020ad0fcd0deea
>> patch link: https://lore.kernel.org/all/20250626144017.1510594-2-
>> clm@fb.com/ patch subject: [PATCH v2] sched/fair: bump sd-
>> >max_newidle_lb_cost when newidle balance fails

[ ... ]

>>
>> commit:
>>    5bc34be478 ("sched/core: Reorganize cgroup bandwidth control
>> interface file writes")
>>    ac34cb39e8 ("sched/fair: bump sd->max_newidle_lb_cost when newidle
>> balance fails")
>>
>> 5bc34be478d09c4d ac34cb39e8aea9915ec2f4e08c9
>> ---------------- ---------------------------
>>           %stddev     %change         %stddev
>>               \          |                \
> ...
> 
>>       40.37           +16.9       57.24        mpstat.cpu.all.idle%
> 
> This commit inhibits the newidle balance. It seems that some workloads
> do not like newlyidle balance, like schbench, which is short duration
> task. While other workloads want the newidle balance to pull at its best
> effort, like unixbench shell test case.
> Just wonder if we can check the sched domain's average utilization to
> decide how hard we should trigger the newly idle balance, or can we check
> the overutilized flag to decide whether we should launch the
> new idle balance, something I was thinking of:

Thanks for looking at this.

> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9e24038fa000..6c7420ed484e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -13759,7 +13759,8 @@ static int sched_balance_newidle(struct rq
> *this_rq, struct rq_flags *rf)
>         sd = rcu_dereference_check_sched_domain(this_rq->sd);
> 
>         if (!get_rd_overloaded(this_rq->rd) ||
> -           (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
> +           (sd && this_rq->avg_idle < sd->max_newidle_lb_cost &&
> +            !READ_ONCE(this_rq->rd->overutilized))) {
> 
>                 if (sd)
>                         update_next_balance(sd, &next_balance);
> 


Looking at rd->overutilized, I think we only set it when
sched_energy_enabled().  I'm not sure if that's true often enough to use
as a fix for hackbench?

-chris


