Return-Path: <linux-kernel+bounces-720685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD98AFBF38
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC04189F63F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A60E39FF3;
	Tue,  8 Jul 2025 00:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KOhhyeHP"
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011038.outbound.protection.outlook.com [52.103.68.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A055C1401B;
	Tue,  8 Jul 2025 00:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751934721; cv=fail; b=XIi6mGKW47YJ/CEuMOLNauTHELpqEB7YZF0W+4bIj4guos3bRxz9r5eh7hXBcIr/Ai77aHS1jcan+B1VJB1L+LclBNpSVt2OKMyx6RJDiJJj+zhFFgKUl72Zzo9apYvMNf94yMbcJVdgxXlaHpyPHl4PmgqRGlbt3aXs+nhWaTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751934721; c=relaxed/simple;
	bh=v0t3HAwNfSAjpAiJMbQvkNTAbb/fJGn3xTE7pIGXSQs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZnJyETlpjvuqNXBQazWYMPNx5a7fMS59L8Vde6cSabxS5wFahH3bNv9sXsz7H/8T7hK8EGFukVs4xkM1MTZvMlMi/apgeB58hoMrljMIlxjEKve8JkFPDnLANrqgnqzbWAsH45QIIZ0ingQOMkZF24XB3rD2l/L/8OFwlVcnnUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KOhhyeHP; arc=fail smtp.client-ip=52.103.68.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbMDFkwfvreXRgAD4III1s8OAakU5Hm4iiyMlFZdsCvplQfn4YvBAwFTmPyJnsYeBBeEVVL7ZGquqFDK9cz9ZZDiBYDVHe/4NEJqr3jiByFT8siSwALT9tkOpbNLkXLYf84u7G7M6B2r5/UM5gnv+YHuLkROUs9G1E4621RW9I2tn6DcHF4jlxl1oT7/WhuFCGghLjmv3KuRcV1XG37D7H+gYbXjaD8xtuFNhhGIqnCmx3hv27YyDMJ9fpLSVIg9wWOYFmzghAW5p19FriuoT+Wd9hZjX/mKJQw5jS6dyWSg3x+odgil8pYPc0qYDLlCJHvvJXs52psgYEm+6vnVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dalho3MdAQo3W3dE7tnYN3MD4KlkbpplhVFAbjzRk0k=;
 b=f6JyIjMtVy22xQ+2cExllDEFjLyc9Ow1ZCGfOrJoBmj7DEZkGxOf2SOO4XB2AS74w7pOc+Zii9LoSo3HV6rx0OBv8VjnGFF4T+jOuupggi1g+N+xhXT7qNdanQXAKf5+i3b3+ZNgwa2aLb/vC/XF8mLUGMLVgoEZk8lrH3TVVfOV6vukbn+xnOHDGIBbJOHe+UvyZN91p3RswA/QAStv9oY83hugzrDy8vKInj0Jk8zm0+GmciLAFieMoIO/2DRLg7xw8JVqDRfamq0BS9z9KrRBJ2p5knw1OyxwwyaSVq/H+hY0FayYR1GiIGx7pZ5FlJyZku37HrYTGjyTOdrQXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dalho3MdAQo3W3dE7tnYN3MD4KlkbpplhVFAbjzRk0k=;
 b=KOhhyeHPEHusVls6ediWeb7SH0faohBeYrllV0ABYcfoavfRQeSdCdxSgOuQhjeegY0BNk13p7q3nrC6YEkeJAhzZNG8/7WOjzm2dOJFEpzQb5nYWvKznSMVFklVLWFoKgYgtMmem0zm4jr1JxPRN14asZgzpo72j2gbVlqxZmQCiQUYBJVB7LKQ+vth7aapI+Zfysg0APDHQRZZPH+rHRf4xcBho9wx/ZIQ8OjwmmZItf0/pwOTIbhM3Q9/It66tKIZPqRvAiNBe8XZAC5fX+PgPmfxSgQMORw/KeuTiBrSneeaIxOhJ0rd0b7LXszMsLHGrFDNqfvasIYDW0AqhQ==
Received: from PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2aa::8)
 by MAUPR01MB11168.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:173::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 00:31:52 +0000
Received: from PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7f30:f566:cb62:9b0c]) by PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7f30:f566:cb62:9b0c%7]) with mapi id 15.20.8835.018; Tue, 8 Jul 2025
 00:31:51 +0000
Message-ID:
 <PNYPR01MB11171DF9E9E357A585476FCF0FE4EA@PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 8 Jul 2025 08:31:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: riscv: add Sophgo
 SG2042_EVB_V1.X/V2.0 bindings
To: Han Gao <rabenda.cn@gmail.com>, devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Inochi Amaoto <inochiama@gmail.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Guo Ren <guoren@kernel.org>, Chao Wei <chao.wei@sophgo.com>,
 linux-riscv@lists.infradead.org, sophgo@lists.linux.dev,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <cover.1751700954.git.rabenda.cn@gmail.com>
 <204c8214aa084d592e8dc45d6c5ca23381937b54.1751700954.git.rabenda.cn@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <204c8214aa084d592e8dc45d6c5ca23381937b54.1751700954.git.rabenda.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0052.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::21)
 To PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2aa::8)
X-Microsoft-Original-Message-ID:
 <a48e5a4e-fb44-4908-89a0-fad42662cff9@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PNYPR01MB11171:EE_|MAUPR01MB11168:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a07c9c-72e1-4fd5-25b5-08ddbdb6d550
X-MS-Exchange-SLBlob-MailProps:
	YfhX3sd/0TUSvyb7a5WmO4GG1jBgOC313Tf7Z2eyVE98rSUo+pRefmQ+cAsithuDhiW7W8UgmwHRkc6y0Tpcn5rHA01qogFEz2AfVWECcC/95cRq2aO207yYYENMIF6ss5zYBgkOpLjjfxpiDpgZtIuvwQrNjyrNYwO8e5CXiEs7MysuXNtRwtkE6KgBlS6cwozdFBxDOrpVbZrB5mWV1rv5H0MuQL+WRe8Vy2zoinvrP95pqMq5uV5ur+x0mGYXJRYjakPIirjBEDajnnx/YnLE0U7TKT6PnAQN33Nkhls+Z8a7y1C718ADkzcrRSpIyGHwlb7SWqYI42iImUTU4u+x7Jf4rjoUmJyxPgRN8QHasnXrqUuNPSC275QU+9c3OzD2vnAe4hLCsHZSlhMYNALek2Iy9QDE9DeD2PfWoyOrcKi7mykn5CSpsNbduQh/4/TiGkqP/M0WfSJzHlIm8R+m5yowU30d5MxXkeIq07v065f4EiRMtBXFCbQhWHo8A2Sxe0qMDXdxPgkcXmIEXcjMSXxf8Cz9ldB88H4tkvujBQh5sRKN8RWDIRM1fXidIh7+pcpLt9OWQ2vsnBn44Hqrzyhr9Wq3fYcFWDyxfGaisIqCbI0i+zaBQ/6cMhQxjDDSGrgD1c37ziuP9VIEL7VWEXbcb4R+FN6UmMnRXxkv9LkpzX2UKm4cm4x3H/NESH67f6oLpku5j48u0hNzx5V/s1MuOnrOag/230DAHMnzeBtwdsf3TRw9DbTiRAts9wFf58zUHCUR5qnnux0xkzTEZDu7SAFgCR/WqJQ9XRg=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|15080799012|6090799003|40105399003|3412199025|440099028|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dG51L2JSQldicjRYZmJsV1YxcTBqdjMzOUNnMW8zbk54ZS91QTk2NWNTajE0?=
 =?utf-8?B?SDdXd0F4azg5NzdOYzUxV0F0ZE9wUUU1ZUlhM3luRWR5TW81eWFwN0ErT0ZQ?=
 =?utf-8?B?cDBrMC95eWMyTzVSdC9nNTMxVGlKMks0cFUvUjUxcFB4clhCQ08zajdORnZk?=
 =?utf-8?B?V1pzZEVsK0phc3VkbjdFVTk0elVQQjdjQjVmU0hYby9MZEYwd0dmaVQxQ0RR?=
 =?utf-8?B?cHNjZkpuYkhvY3Q1VWNsTVZrMzIzbXpMWW9HazBnK1g5M01hTVVzM3hpUndn?=
 =?utf-8?B?VFRwdVpyaldtNU5SMThnNzczcGJSZkJBMkloR2RHY3IrRFFLQ3hYUWN2czhh?=
 =?utf-8?B?c2t6L1hTQU9sMTM4NzR5T2Nvb01nclB0RUpjUm16YktGSCtCY0ZFQzMwUFZX?=
 =?utf-8?B?enJ4SzltTHRYNjlZZmo0NXU4aURYZVpGWFVxcDFIbzJ5SHRzSHlZdjRGMk5l?=
 =?utf-8?B?VElObEFwU1hHTm1DeHhBOW5CQnUzOUtoWFJNalpPMXFVVUt0d2RCakRLSk4w?=
 =?utf-8?B?SjJ1cFdONS85dCtJSnhCS011dFRRU3AxSTZTcnpGR3E3a1NXWG1ReU1YY3Rj?=
 =?utf-8?B?RFRJT2dTMGluT21YVXV0ak5XL1pPYWx3VUZhZzZhWWFYdk1NL1hEUVZuTWJz?=
 =?utf-8?B?enE5QVo0RWxjWEF5R3ZiMGVDWEhsU0NyM1ZGVEd1NEVLT0VtMXJNMU9uZi8x?=
 =?utf-8?B?SGFvVXZSYTd1bGJ3cDE3VTNSaVZRa1Vydmpna0o4d1lIL3lMR0lJdHpacEl3?=
 =?utf-8?B?Z1lLQjBFOTBwUjlxTHZvTU1RdXdGZGx6THZXS0ErNWZHT2xhNFlKYlBGQTQr?=
 =?utf-8?B?RGx6dE80NTU4TGplakxNUUNZMTd0TlNuMzhESTR2NEFDUlVlVUdvb0NjZzlh?=
 =?utf-8?B?a0ZCaEpLMDhYcnJQOERURTdRemtQM2oxdGRadTFOWEMxV2ZpelVrc293akZ0?=
 =?utf-8?B?MHFSK2dMRzQyd0ZiMlFIdzFUNmRSNFM2RFBZZTVQeVgxWVpJOTZxK2JSYzQ5?=
 =?utf-8?B?T3J1Qklxd1pYZkU2MTRXbXczWHBZTjZRQW1mYUVtc0VQL3pNNWRJejYyRFE0?=
 =?utf-8?B?TkxTbW9PK21SMEZMZlRJd00xN0Jlbm4xU1l0TmpKMitFVER4Z3IxeDZ6Vmd5?=
 =?utf-8?B?QVdiRkRuZVBQNVY2SkhJRTgrclZ6eDhpR0pjL2ZGaDU3THVlSVVNZEtmRk11?=
 =?utf-8?B?WWllL0d0VHFVQWFjdnlNNkx6WmVQanlMZG5UUXZOT3RMVGozdjcvSzhxUkUv?=
 =?utf-8?B?c2JoSHdRRHpvNUlqbzE0NU9DMVZiMkJEdnRSTCsxaUliWnVRQ3pHbDlEOUFq?=
 =?utf-8?B?N3Z2YWVxN3Fza0dtUkhCNTF1N0VIV2loN2tnWklnVWZWanpZSnN4UkM0OHlK?=
 =?utf-8?B?VS9TVDJiVWMvUGlQdkVBaWtjSW8xcHl3cEluQ0Q1a2R4ZEUrbTk0c0JRazlG?=
 =?utf-8?B?R0hrUGlld3J5U0ZLM2ppd3JzKzdrZm84Q3BMQU5GNlExZENmUFR0MVVYQXVH?=
 =?utf-8?Q?BoegXo=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWlZWHlZL25XYUVBYk5rSHNkY1B1NEkrbzQ3ZG5tNVNoMWtWRG9XVkh3bDFw?=
 =?utf-8?B?ajJBeWRyTnZwNE1vZzlNT2k3NGJOcjRWU0h2elJEZFNKZjFTT0tkSWFFa1Z5?=
 =?utf-8?B?Mm1HQ3hlOUdrZHIrOSswSHJrdGpwTHBQVWp2d0Z4WlJ6MUhMcG5uR3FDMzE0?=
 =?utf-8?B?b1QvS3pmSEI3RVh5Z1FkRGMxQ1NRMEZjNlllSVpESW5GdG1HTTVIaDRvNGxz?=
 =?utf-8?B?NXNIYVl5RGVDWHA5MkdmdlVVOEtkTHI0T21MY1V0YjVaWFBzYys0ME5DU2FH?=
 =?utf-8?B?THRTcHpURlNEMW9xejd4aFRTLzM1dDNNZC96dnVhR01qMHhLZ3JWNTFKMWQz?=
 =?utf-8?B?S2NncDR5QVlzV1pZYkJINGQzR3lRNkxaMEVpd0tCOUZlV1hYa0Y4S2lxQlpo?=
 =?utf-8?B?MVovblRVZHRDUCs2QlpvOFVHOVB2clBGMG9hNnNmUDl0N05VYVE4U1lkdzlv?=
 =?utf-8?B?czVDRFhyVXN0cEQwTG91WWtKZEQvM2xlcmVrLzE2a2RuMFpjOHQ3NjNRWjd5?=
 =?utf-8?B?dVIyblRZVTNOS1JwTDh4SDlhOHRybzFkYm5tR1ZncXJ2OS9aQ2hpRUx1RGZz?=
 =?utf-8?B?bTlYU0themVoM0pQSXFVeHFzSkpENGsyZzI0OGxPV3pveThhSHpveVhYZHdo?=
 =?utf-8?B?Z0MyVTJ6d2hXU0FKMHQwdnAyQVVya0ZkRWxtSkNoRWhEa1Y3ZzcwdUszZVRL?=
 =?utf-8?B?VC9rM0pMWXhzZFVncXc0Y0ZpNk5TTEdoQlRLMU1XL0dLaTVHQTVwdW1xOG1a?=
 =?utf-8?B?RXIrVnNqUUs1NkxNZW5sVmZDTnY3NFJPRElVMzJ2VS9CQk5JczVSRlFDd25I?=
 =?utf-8?B?aFY0aUxyQTgzNmdOcUV3eWZ6dDc1ckt6OGtlNzdxanVkcUwyY0w0Y3FmbUxy?=
 =?utf-8?B?bmdQZFJvUjk3dVdpc1hUSndyTXJ2Z2tBMUhzKzBIWXl5d1g4RjAxMG5ieWw2?=
 =?utf-8?B?YW4zWWdLOWticnZLNld5ZGVsNnF0WVNuZVpOSnloTTRoUVJDZnJuaUtsTXBC?=
 =?utf-8?B?RUk2aWRTWGNlamdnVlBZSjFyeHNuckRiamxibkxzVWRaMVVVU1ZNcDgvNXlu?=
 =?utf-8?B?NzJPd2dHVGlteTloaWRrWGdhZE1ZRGh2OWVhUkM1N0hrZkJKc01mMHk2ZVVn?=
 =?utf-8?B?cVVyOE0xQW05QnBWdk1CRDdMME5TVjdFaXhHUzNQQlA4aURvdnZwUSttUW1y?=
 =?utf-8?B?YW0wZk45eXBGZ29UdTg2T0dwT0FmTGs5dXBac0NtekdvcEk2eTIxUUV2MGZ3?=
 =?utf-8?B?d0hMZ2hydVV0ajNiVFJKUDFBeFdibVo2Z2hDTTdrTHdsRnlkVjdQWnJTbGxN?=
 =?utf-8?B?MXd4clJuMGZRVXJFdHpPY0hOQlFQNXBDT3Y1SGhlREVOblJHaVpFRm1mT1Zq?=
 =?utf-8?B?RVFMbmJlZUQ2YVNVTmtiYkdTZzFBRlppcXpOVE13cTNPZHlyc2RrSjdHbERO?=
 =?utf-8?B?T2dyN1g0a1J1SDFPVm5YYW5SZHVodE5yOVpjRTd6d0JZeFlLYVJiclV0WDUr?=
 =?utf-8?B?VkFuaCtxQlF6aDF1Zlo4eWFZT2c0TmpIY25HakVESWJ5VTlrNnRSTjI5eEI0?=
 =?utf-8?B?eUJBYmNjMFNiMnhxRldMK1lNdDNIZFd4N1loM29xOEk1V09PbnI2SFBVZ3FI?=
 =?utf-8?B?S05SK21kTWRmUFRXNHEzb0laVWVqREkxNy9sYWVHcWN3RW5GU3NrOUIzWTlT?=
 =?utf-8?B?S3VhWGN2S2NwbFZ6dk5wdUFCU05iUUp3L3RQdWd5Q3I0ekhtQ1B4NmtFMFVa?=
 =?utf-8?Q?/nTfiP5jFswZOEY8IBTCm2cdaSaIjD71ETHEY2n?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a07c9c-72e1-4fd5-25b5-08ddbdb6d550
X-MS-Exchange-CrossTenant-AuthSource: PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 00:31:51.9059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAUPR01MB11168


On 2025/7/5 15:39, Han Gao wrote:
> Add DT binding documentation for the Sophgo SG2042_EVB_V1.X/V2.0 board [1].
>
> Link: https://github.com/sophgo/sophgo-hardware/tree/master/SG2042/SG2042-x8-EVB [1]
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Han Gao <rabenda.cn@gmail.com>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>   Documentation/devicetree/bindings/riscv/sophgo.yaml | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Documentation/devicetree/bindings/riscv/sophgo.yaml
> index b4c4d7a7d7ad..e21b65938a65 100644
> --- a/Documentation/devicetree/bindings/riscv/sophgo.yaml
> +++ b/Documentation/devicetree/bindings/riscv/sophgo.yaml
> @@ -34,6 +34,8 @@ properties:
>         - items:
>             - enum:
>                 - milkv,pioneer
> +              - sophgo,sg2042-evb-v1
> +              - sophgo,sg2042-evb-v2
>             - const: sophgo,sg2042
>         - items:
>             - enum:

