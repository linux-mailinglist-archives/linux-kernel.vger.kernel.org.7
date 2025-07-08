Return-Path: <linux-kernel+bounces-720899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E2EAFC1D8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915894251DA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326C12192F9;
	Tue,  8 Jul 2025 04:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QCWXJNCD"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24AB43ABC
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 04:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751950765; cv=fail; b=X0PqblGPRwtle+cFKYAenD1hner47dn9uxIe7XwGpch0ix484FXb6RZFJqNCW1SZk5633TYYsNdCl1mvWBuTS0V1Rygb9qjzg0uLDShv/9OQ2otO7O74hef2/fX/3KAnCKHO++n5cKwYXbK17MneFCTr3D9BwrjIJbYF7qaoQlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751950765; c=relaxed/simple;
	bh=FodECwyCM40bmpalXNco2eFv0j56AJXVsuoMTr0I0WM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TPOdd1shTf/9/oX2S4Pq0IBFGJVX4v1Az6r5mz+17AIpu4oVxBpuy9PJwPdTJ6WQUP7Qf0s4YTRl/X9hZJpSti4IZQIWskJ8ChUJn4h+/yAYkoJ7TDXJAhR94Ehr72KqaK+v1e8MrI06NvTPiNIq9yVYC/VKo3lI0Jw23GEXSbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QCWXJNCD; arc=fail smtp.client-ip=40.107.93.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQ442DuNNGSRzeZhEjZw+Ba0AVjF/TitePZPoOLB2gt/Zvx0RPhSl7Tiu8IRaIP37gu2Ya5b3QoOqYMCLvZ8EXUTYP3t4FpbQOmWYIZWC4+PedoivP44JhbV6orS6xWYG0KFcAzzYXiRMppXngpIEdWM7j0let69R5ohtgQlNGgNUpt7+tjFfowywr5ncIWyzRAYW9caOXCvB/UHQixncqA/ooj3yc3sFrlCcFMhFFDDj+9j92ET+vKfE8+pgtAKJrt61yUbajry2LYtMcj7I/r2S+Ly3ZhD6zu9DEQ8gM8kI8tdDExi/siECTNZlVcECNAB1zhBn7D4uiBJQj+hRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27I1TZlCrO51LLiXpa7hTkV27R1XtesSYav+ZQKLjxY=;
 b=Lc9zZsg9+I+b6oOYoWytLPZ+jlsIKmtoTkvmf9Dxu2Oj5TlG9ldAUophlriCaWWTKmUn7rROJrUruQ2JDA9NjpNrrM9FjZao25fdeJjMyh8GA7HigRDhaRXo7CUtfhzCE5iqoRGcvGvwQlL3aVNQ91/+i65g4Mwf2NEH9shdsngHCh+HEWPKA+gaEr8XSBIyQIrLT8vJL9u2WJgErznyt8YvIFdhbk3KkPzkhItKWyXr7sI+wPTvRYihWNUQxVjX9gugwSPl6VjkT5gMN8aQRu7SmMEn13J43DjN1mhpjT4dWPJjnz2aXTZIxoRK7bpHczaMAnXXN/CnIOptjquqjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27I1TZlCrO51LLiXpa7hTkV27R1XtesSYav+ZQKLjxY=;
 b=QCWXJNCDRcMfgSDDl49JXqRPFtOBBOUceQVCEGRd/Q/Yrwuy7dCTUZCGadFAz9niE1lcL8UaS3S6XZw9JvByVQxbhZPNjey3g69a+FqnZuIRo4KAIM5sAO+eQYPJGUAhCijtKhuxyF6DZoqQr7bIJCZ7afAw4oZ/TfYejisD9+5tAA6G+Km4WqJpdA0Hs1zZUX+m5y5R64gZq8jUZKu4iVmkEfNlUmAC/dGRxLiSrLINIqDRiheooV4uBlCZXbhhLZb7rr3DnuM6+t7MNuTHBvpeefddHhGFlGNhTTeFObQxeamvJEdQzOUAPpQOIVyeX7xM5VnyVWm0d49AH3DATA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by DM4PR12MB7696.namprd12.prod.outlook.com (2603:10b6:8:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Tue, 8 Jul
 2025 04:59:18 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%4]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 04:59:18 +0000
Message-ID: <6963662f-eade-405f-83dc-6fdd05e202f3@nvidia.com>
Date: Tue, 8 Jul 2025 14:59:11 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 resend 03/12] mm/thp: zone_device awareness in THP handling
 code
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>,
 Donet Tom <donettom@linux.ibm.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <20250703233511.2028395-4-balbirs@nvidia.com>
 <c65ucmpbzz3rjjlj2pgac4embz3o44r5tb6tjgprfzv5oopcx4@rtburoi377i2>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <c65ucmpbzz3rjjlj2pgac4embz3o44r5tb6tjgprfzv5oopcx4@rtburoi377i2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0174.namprd05.prod.outlook.com
 (2603:10b6:a03:339::29) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|DM4PR12MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e0291c-9620-4037-bd82-08ddbddc31ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2ZEMGJWVXVJZjhrZVR0QnBTWEw0dUd0Ylh6ZzdDb09mWUFzMzNUUlB6TVl4?=
 =?utf-8?B?N1lwc2M3TFN6SVBkZXVUS29uK3pyNGtoL1FxZkdYR0pYRzQ2blFCRHdOaFBQ?=
 =?utf-8?B?MlB5ZU1qSmN0c3k3SkpDTytnbWRONC9JWDlXL05BNitFcHFWWUY4VDlSV1h6?=
 =?utf-8?B?VGthOTlhNjhJK2h5TVRaMllGVVBpRnRLKzFpRXNGdVlialY3THZyS1pTNWpP?=
 =?utf-8?B?bExZdkVKOVY2Nmlzdk1oMHdmT2dTTEltdTNDcmltUlphbS9hVjZPNGN5MlE2?=
 =?utf-8?B?aUEzRCs3ZmFUZXF1d3RNcGNIV1Zwcy9HNTloZVNqUTRkUHJBekxrOEozU2ho?=
 =?utf-8?B?dFRWOGhQMU9qUldkK1A5SzFzdEVmaEtySWU4Sm8wSWRpbHpoRnQrdHA4Y3Jx?=
 =?utf-8?B?eWVjTjZoZ3RxV0hCVFVDVGNPeHF3aVlIZlNocHRlMlkvejZxN1RBaGs5SGxC?=
 =?utf-8?B?a21tZVd5YkxielVFSmVzbUtLMzFQL0FqUlVzeXJTZnpDeWFSTjRmT1cyNUNX?=
 =?utf-8?B?eHA1RWNhNnJVb0JkVldXRmVrb3JDSVY1ZUpvV3F1Q2RaRyt5MW5BdmlYcEl3?=
 =?utf-8?B?MUdxU2ZwYW9LTjFON214Ym1WUGRVZ1d2dEpHZjlxc2F0NmpYWnJzZWFoRHNW?=
 =?utf-8?B?V0MvMGRXdUI1VU9ZWjRoTDM2WHNtN1NaVUljeHVTN2ZESlBoclNTajFqRWZV?=
 =?utf-8?B?d0hyeGNHK0NaR2dyNTdUQ1dYV0l4d2NRZE9nUThNK1lzK3pWbzROOVBuSXFk?=
 =?utf-8?B?S0pxQzUyYTJ3MG4vdHNzcHg3eTRNU2twS1dWd0Jhb1RvTG5wQ2dRWDhXMnRS?=
 =?utf-8?B?dXlKVGtMS1hvTEgxSDNkL25MU2lFWWdMVlRndXZvTnBkV3M0cE82QTdtZXdZ?=
 =?utf-8?B?NE9zVjhEZGpHZkpJeEM4dFpiaVlOamhMQjh3WjBtNjlGNlc1VnRDZDRlMXNK?=
 =?utf-8?B?dDVBTm1LUFFiZkc4NmlqT2xwcUVSanBGVU5QK3NaUk1tUHVVRjlLL2JxT0p5?=
 =?utf-8?B?V1h6MUIyTWVIU2pHUFBZZXJLalBPcXJHbXdGa1NRMW83RWYwY3ovdGdFVUU5?=
 =?utf-8?B?cVBkWk4vODduNjhETnRWVnNza0FrSTREOHFaSjR4b2NkeXhCM2tRZWdqOXI2?=
 =?utf-8?B?dVU1ME9uWDZzRGgyM3g2VlpHZVEzN0RvM3c4NldPOVlIUWhoUFFQdDdMWUhW?=
 =?utf-8?B?eEN1Y3NnVVpzcEdLNjZxZDQwckVRM3JBR0k4blpVbGJ6RWxPblk3L1ZVUjFL?=
 =?utf-8?B?K21GTXgvc1VpSE8yTjV5NktyTzVIQU5TR0FmVHdKaGFtZkZzQmZMbEtFa1JB?=
 =?utf-8?B?dWM2NlFWWXFydUk1eXNGZ0ZuYmZKcUNmRWRIenQ2bWNNMEhRc21tM3N3V3JN?=
 =?utf-8?B?UUVnUEErbEtScTkxMkt6L0NRazE1UFZkWFN5dEJyblkrZDIvOXhZMmZtbm42?=
 =?utf-8?B?MFlwcjZPYlE2MzJiSzJMNVZHMHRMbkFhcWMvM3h6K3cvT2kyMEp1VFRuMFNL?=
 =?utf-8?B?a01NOTFqNEV2NS9XS3JQM2hKNGFjd0FyVmRTVE1GOGdMMnhSdjFyb1dtUndw?=
 =?utf-8?B?cVFBbnB6eUxyYm1LZFJuV3EwTU1WcHAra1k2S3RPMjB4aEUyRWdVdncwMFRG?=
 =?utf-8?B?dkxLa3pVTTZ1SmhYQjhNQ3ZPMHZQUXVTYngyd2tNWWU4ZFk1aXZDaEg5UEIz?=
 =?utf-8?B?N2s3d0t1YTNSZ3BTaVpWZkdXNUpwVDJCMnYvN2czaWVTVm9ROU9DK0ZGSjhH?=
 =?utf-8?B?eHd3MER1T2dUNG1RbjdlSllXN3doTWV1Q2k1aFMwRVpXSndnMUxWM3ZtQzQz?=
 =?utf-8?B?RGFScTI2c1c4R255SGF5UzZzMWxwMUs5cDdRMEhsTklZRUp2N1M0TzRjZmkz?=
 =?utf-8?B?TTNMUzZBMGVNLytaY25HczF0NkQwdXg2dDgyVGtRYlplU3lORzN1Y1RTUWxp?=
 =?utf-8?Q?cPOkw7wlzJQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3haVlpXanlrK3BGUjB5Uk5mZU14V0NKYjJkTE9Mc0t4aHpuRVYxRXFFWWZB?=
 =?utf-8?B?SjZuTjI0U3RCQWUrRkFJMlNKRnc3Y3ZYNDBxOGU5VUFiNzhXZzVGdTBpY3li?=
 =?utf-8?B?eUdvVm4xektOSm5ZVEsxNEJVTEVwZHNWNEZJZXI1SGdSYU0rQmFpdHJTOXJy?=
 =?utf-8?B?NEFWbTN0cUNna2VRZ0JmUmpHeS9rQWxzSFp3OFExMlJOaGw2Ulp0ekhTelBY?=
 =?utf-8?B?MlNmRXFTaXV0bVlLWjM2WWVjR2gxem50UGMrK3dwZmY2cU9EZll2OFlTdUZy?=
 =?utf-8?B?NE1oSmVFSnIyVWdjRUJnRUk3Z3NpVmhCVG1jL3U5bjNpcW1LOWxKQWgrMnlr?=
 =?utf-8?B?eGZ0Q1NoVXA3NXJzcHhCUDE2emE0ZkZRUEVXazQxeXh5QU5EQWdHSk9tZGJn?=
 =?utf-8?B?SHFvc09CUUM2NHFpR2F6RTNLdDQ2ekZzWHUxcE5CYjFndVZEQVVlRXBlRTQr?=
 =?utf-8?B?MzBQTS9GWndRd29tRGlua1Y1NHMvZDZIL0lxSTR1N2Q5dUY3Sy9FenA2UVJL?=
 =?utf-8?B?UkJuakxLdk1ad1krdlJ3NTNaWncyZjB3M3EybGlyOVVaZG5rZWkxRW1kM2dX?=
 =?utf-8?B?dHFkU01xbHRLT1VQVDVOZU9lSGU2YlNqWEZiT3BwUmE5RUxqOHoySis3Y1Uw?=
 =?utf-8?B?UFZsNzVyUU9sOWp4Q0I3OHRhU1AwVEJFM2RtTy9GT0x5RU1JM0cvZHBIaGla?=
 =?utf-8?B?b3hGR203OHlDT3VKeWg0UERZVzhrTXhZRTg4RGxHQ3ZTeFJrSXc3MlljYjFi?=
 =?utf-8?B?OUNOOHBZZE1hRlZqeGhWSVErM0o1QVp4UG5FYXowZDdYWVFSUUsyUTJtSENO?=
 =?utf-8?B?VWQ3a040aDNEbjhjQ2xVTDRJeWswNHdOVE8rZXlwNHAvN1ByeUc2V081dG9h?=
 =?utf-8?B?dFVCMHBrd1dJclVNMmlZRUdlYkFTeEFGWk9xT3ZGWkhnSE4ybDhIcDBxY3Bx?=
 =?utf-8?B?WmxsYlFscTFNNTQramI2OUZWSUI2eVRXQjQ5YVcvc1gzNUQ5bEFVMGI1bnZy?=
 =?utf-8?B?QndTYjMzd2lqTnhMRTRraDBmZTBuKysyNC9oQ1ZKcmZ5bFhPS3pYU3E1VVl6?=
 =?utf-8?B?WDdjSFlhWUo3VFBwVkQ4K3hna0VxOVpaOXhyQjlhMG93aXpmS0dLUzNsRG50?=
 =?utf-8?B?VU5IZlhsOG1JODVlWG1ZRHl1cWgxdWZldFhDVGpML2Z3cHc5cFJpc2JMbDVn?=
 =?utf-8?B?M3R4OXIzSDVicUZRTEdIVFJaNHB5a09Pa0VRQ2hvR2krZGRjUkMwMGVteGV2?=
 =?utf-8?B?Y3NYZHgwY1AxcitkeDZ1QmNzd045V2MwTFNnVGFETFlVcWlMYS9qQnFJcWdr?=
 =?utf-8?B?L1VPNXlXYk9reVVMK0pYUTByMk9JdWtjMGwrZ1dUajJVVGVvM0pmUlZyaG9L?=
 =?utf-8?B?Z0hOTksyb1lVSEgxMkVJaDhLcWd4bDdwcGpyalNnN0hOU3Y0T3hnNm8vd01P?=
 =?utf-8?B?TTI4dHE1cUNaVjV5SEd0TVZHc0YvYXZvVGZZWjI0VDF4LzNzQmdoN3lJRXRs?=
 =?utf-8?B?UDZFc09aUkc0andBbnBKc3BmS1pGZ2ZZZ0ljeWVlYUY1R1FtbFpUdlNMSFhm?=
 =?utf-8?B?Q2lOQW1kZFVyUTcwcG00TnlHamFNekVKZm56R2I3WTZ4V1lZb0JSMUx6eXVz?=
 =?utf-8?B?d0kvZjkySURsTUl5aHByQUVGczBQL3hWZ1R3djIwVGI0ZE94RzViSGsraTR5?=
 =?utf-8?B?T3lNYkZ3cmFXM0N3TmlSV0RjTTVQQlQrQ09weVdTbm41Z3JxZlhCaHlyd2ZR?=
 =?utf-8?B?NEYvWm90aEtBeENIOWF4RjZ0am9rcjhvcnlJbjMyQmtNcVJraDd2N0UzbHp6?=
 =?utf-8?B?WWozcGcrNmVkNVhWMVZtOG5Lb1p3YzlPZjRtcVBaSk91SGJnQ2FrNGVBQzVn?=
 =?utf-8?B?L1RIT2twa2lMNUNNK2lXMXhqN0NyWTQ1cE5MU1NUUnZaelptNjFJVXBnUFZr?=
 =?utf-8?B?RnBLeEpzMmF0WTUxQk5na2xzbkR3L3pWclRUWGxiNFBBb0s5S3pITGU1T0Zs?=
 =?utf-8?B?bHh2cFJVT0xjYU5ac3NYQXhKeWVjRWdiRG9qdVBUd241QTVMdXlIZUplaklM?=
 =?utf-8?B?bmpveEpTTU1JR1MrTmQ5K3BtRG85MWJYckFuNkl0LzZPc0t5ekZPZ092RWxQ?=
 =?utf-8?Q?a2KJuhHzCPThjbuDDVtIuUPSm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e0291c-9620-4037-bd82-08ddbddc31ca
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 04:59:18.4927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mE1aJex3wExFXLAMylAoip9proBSdi3vxfoFdsjSjMKEF1IIckt785v0W984FSVal2RQIT5n1AMuuCYxOHFmCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7696

On 7/7/25 16:07, Alistair Popple wrote:
> On Fri, Jul 04, 2025 at 09:35:02AM +1000, Balbir Singh wrote:
>> Make THP handling code in the mm subsystem for THP pages
>> aware of zone device pages. Although the code is
>> designed to be generic when it comes to handling splitting
>> of pages, the code is designed to work for THP page sizes
>> corresponding to HPAGE_PMD_NR.
>>
>> Modify page_vma_mapped_walk() to return true when a zone
>> device huge entry is present, enabling try_to_migrate()
>> and other code migration paths to appropriately process the
>> entry
>>
>> pmd_pfn() does not work well with zone device entries, use
>> pfn_pmd_entry_to_swap() for checking and comparison as for
>> zone device entries.
>>
>> try_to_map_to_unused_zeropage() does not apply to zone device
>> entries, zone device entries are ignored in the call.
>>
>> Cc: Karol Herbst <kherbst@redhat.com>
>> Cc: Lyude Paul <lyude@redhat.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: David Airlie <airlied@gmail.com>
>> Cc: Simona Vetter <simona@ffwll.ch>
>> Cc: "Jérôme Glisse" <jglisse@redhat.com>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Barry Song <baohua@kernel.org>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Cc: Jane Chu <jane.chu@oracle.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Donet Tom <donettom@linux.ibm.com>
>>
>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>> ---
>>  mm/huge_memory.c     | 153 +++++++++++++++++++++++++++++++------------
>>  mm/migrate.c         |   2 +
>>  mm/page_vma_mapped.c |  10 +++
>>  mm/pgtable-generic.c |   6 ++
>>  mm/rmap.c            |  19 +++++-
>>  5 files changed, 146 insertions(+), 44 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index ce130225a8e5..e6e390d0308f 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1711,7 +1711,8 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>>  	if (unlikely(is_swap_pmd(pmd))) {
>>  		swp_entry_t entry = pmd_to_swp_entry(pmd);
>>  
>> -		VM_BUG_ON(!is_pmd_migration_entry(pmd));
>> +		VM_BUG_ON(!is_pmd_migration_entry(pmd) &&
>> +				!is_device_private_entry(entry));
>>  		if (!is_readable_migration_entry(entry)) {
>>  			entry = make_readable_migration_entry(
>>  							swp_offset(entry));
>> @@ -2222,10 +2223,17 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>  		} else if (thp_migration_supported()) {
>>  			swp_entry_t entry;
>>  
>> -			VM_BUG_ON(!is_pmd_migration_entry(orig_pmd));
>>  			entry = pmd_to_swp_entry(orig_pmd);
>>  			folio = pfn_swap_entry_folio(entry);
>>  			flush_needed = 0;
>> +
>> +			VM_BUG_ON(!is_pmd_migration_entry(*pmd) &&
>> +					!folio_is_device_private(folio));
>> +
>> +			if (folio_is_device_private(folio)) {
>> +				folio_remove_rmap_pmd(folio, folio_page(folio, 0), vma);
>> +				WARN_ON_ONCE(folio_mapcount(folio) < 0);
>> +			}
>>  		} else
>>  			WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!");
>>  
>> @@ -2247,6 +2255,15 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>  				folio_mark_accessed(folio);
>>  		}
>>  
>> +		/*
>> +		 * Do a folio put on zone device private pages after
>> +		 * changes to mm_counter, because the folio_put() will
>> +		 * clean folio->mapping and the folio_test_anon() check
>> +		 * will not be usable.
>> +		 */
>> +		if (folio_is_device_private(folio))
>> +			folio_put(folio);
>> +
>>  		spin_unlock(ptl);
>>  		if (flush_needed)
>>  			tlb_remove_page_size(tlb, &folio->page, HPAGE_PMD_SIZE);
>> @@ -2375,7 +2392,8 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>  		struct folio *folio = pfn_swap_entry_folio(entry);
>>  		pmd_t newpmd;
>>  
>> -		VM_BUG_ON(!is_pmd_migration_entry(*pmd));
>> +		VM_BUG_ON(!is_pmd_migration_entry(*pmd) &&
>> +			  !folio_is_device_private(folio));
>>  		if (is_writable_migration_entry(entry)) {
>>  			/*
>>  			 * A protection check is difficult so
>> @@ -2388,9 +2406,11 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>  			newpmd = swp_entry_to_pmd(entry);
>>  			if (pmd_swp_soft_dirty(*pmd))
>>  				newpmd = pmd_swp_mksoft_dirty(newpmd);
>> -		} else {
>> +		} else if (is_writable_device_private_entry(entry)) {
>> +			newpmd = swp_entry_to_pmd(entry);
>> +			entry = make_device_exclusive_entry(swp_offset(entry));
> 
> Argh. The naming here is terribly confusing (of which I'm at least partly to
> blame) because it ended up clashing with David's PG_anon_exclusive which is a
> completely different concept - see 6c287605fd56 ("mm: remember exclusively
> mapped anonymous pages with PG_anon_exclusive").
> 
> The exclusive entries you are creating here are for emulating atomic access -
> see the documentation for make_device_exclusive() for more details - and are
> almost certainly not what you want.
> 
> As far as I understand things we don't need to create anon exclusive entries for
> device private pages because they can never be pinned, so likely you just want
> make_readable_device_private_entry() here. If we really want to track anon
> exclusive status you probably need pte_swp_exclusive(), but then we should do it
> for non-THP device private pages as well and that sounds like a whole different
> problem/patch series.
> 

Thanks for catching this, I agree we don't need to track anon exclusive for device
private pages.

>> +		} else
>>  			newpmd = *pmd;
>> -		}
>>  
>>  		if (uffd_wp)
>>  			newpmd = pmd_swp_mkuffd_wp(newpmd);
>> @@ -2842,16 +2862,20 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>  	struct page *page;
>>  	pgtable_t pgtable;
>>  	pmd_t old_pmd, _pmd;
>> -	bool young, write, soft_dirty, pmd_migration = false, uffd_wp = false;
>> -	bool anon_exclusive = false, dirty = false;
>> +	bool young, write, soft_dirty, uffd_wp = false;
>> +	bool anon_exclusive = false, dirty = false, present = false;
>>  	unsigned long addr;
>>  	pte_t *pte;
>>  	int i;
>> +	swp_entry_t swp_entry;
>>  
>>  	VM_BUG_ON(haddr & ~HPAGE_PMD_MASK);
>>  	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
>>  	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PMD_SIZE, vma);
>> -	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd));
>> +
>> +	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd)
>> +			&& !(is_swap_pmd(*pmd) &&
>> +			is_device_private_entry(pmd_to_swp_entry(*pmd))));
>>  
>>  	count_vm_event(THP_SPLIT_PMD);
>>  
>> @@ -2899,20 +2923,25 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>  		return __split_huge_zero_page_pmd(vma, haddr, pmd);
>>  	}
>>  
>> -	pmd_migration = is_pmd_migration_entry(*pmd);
>> -	if (unlikely(pmd_migration)) {
>> -		swp_entry_t entry;
>>  
>> +	present = pmd_present(*pmd);
>> +	if (unlikely(!present)) {
>> +		swp_entry = pmd_to_swp_entry(*pmd);
>>  		old_pmd = *pmd;
>> -		entry = pmd_to_swp_entry(old_pmd);
>> -		page = pfn_swap_entry_to_page(entry);
>> -		write = is_writable_migration_entry(entry);
>> +
>> +		folio = pfn_swap_entry_folio(swp_entry);
>> +		VM_BUG_ON(!is_migration_entry(swp_entry) &&
>> +				!is_device_private_entry(swp_entry));
>> +		page = pfn_swap_entry_to_page(swp_entry);
>> +		write = is_writable_migration_entry(swp_entry);
>> +
>>  		if (PageAnon(page))
>> -			anon_exclusive = is_readable_exclusive_migration_entry(entry);
>> -		young = is_migration_entry_young(entry);
>> -		dirty = is_migration_entry_dirty(entry);
>> +			anon_exclusive =
>> +				is_readable_exclusive_migration_entry(swp_entry);
>>  		soft_dirty = pmd_swp_soft_dirty(old_pmd);
>>  		uffd_wp = pmd_swp_uffd_wp(old_pmd);
>> +		young = is_migration_entry_young(swp_entry);
>> +		dirty = is_migration_entry_dirty(swp_entry);
> 
> This could be a device-private swp_entry right? In which case calling
> is_migration_entry_*() on them isn't correct. I suspect you want to have
> separate code paths for migration vs. device_private entries here.
> 

Yep, I will split them up based on the entry type

>>  	} else {
>>  		/*
>>  		 * Up to this point the pmd is present and huge and userland has
>> @@ -2996,30 +3025,45 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>  	 * Note that NUMA hinting access restrictions are not transferred to
>>  	 * avoid any possibility of altering permissions across VMAs.
>>  	 */
>> -	if (freeze || pmd_migration) {
>> +	if (freeze || !present) {
>>  		for (i = 0, addr = haddr; i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE) {
>>  			pte_t entry;
>> -			swp_entry_t swp_entry;
>> -
>> -			if (write)
>> -				swp_entry = make_writable_migration_entry(
>> -							page_to_pfn(page + i));
>> -			else if (anon_exclusive)
>> -				swp_entry = make_readable_exclusive_migration_entry(
>> -							page_to_pfn(page + i));
>> -			else
>> -				swp_entry = make_readable_migration_entry(
>> -							page_to_pfn(page + i));
>> -			if (young)
>> -				swp_entry = make_migration_entry_young(swp_entry);
>> -			if (dirty)
>> -				swp_entry = make_migration_entry_dirty(swp_entry);
>> -			entry = swp_entry_to_pte(swp_entry);
>> -			if (soft_dirty)
>> -				entry = pte_swp_mksoft_dirty(entry);
>> -			if (uffd_wp)
>> -				entry = pte_swp_mkuffd_wp(entry);
>> -
>> +			if (freeze || is_migration_entry(swp_entry)) {
>> +				if (write)
>> +					swp_entry = make_writable_migration_entry(
>> +								page_to_pfn(page + i));
>> +				else if (anon_exclusive)
>> +					swp_entry = make_readable_exclusive_migration_entry(
>> +								page_to_pfn(page + i));
>> +				else
>> +					swp_entry = make_readable_migration_entry(
>> +								page_to_pfn(page + i));
>> +				if (young)
>> +					swp_entry = make_migration_entry_young(swp_entry);
>> +				if (dirty)
>> +					swp_entry = make_migration_entry_dirty(swp_entry);
>> +				entry = swp_entry_to_pte(swp_entry);
>> +				if (soft_dirty)
>> +					entry = pte_swp_mksoft_dirty(entry);
>> +				if (uffd_wp)
>> +					entry = pte_swp_mkuffd_wp(entry);
>> +			} else {
>> +				VM_BUG_ON(!is_device_private_entry(swp_entry));
>> +				if (write)
>> +					swp_entry = make_writable_device_private_entry(
>> +								page_to_pfn(page + i));
>> +				else if (anon_exclusive)
>> +					swp_entry = make_device_exclusive_entry(
> 
> As above, you're welcome for the naming :-)
> 

:) We don't need to track these, I'll fix up the patch

>> +								page_to_pfn(page + i));
>> +				else
>> +					swp_entry = make_readable_device_private_entry(
>> +								page_to_pfn(page + i));
>> +				entry = swp_entry_to_pte(swp_entry);
>> +				if (soft_dirty)
>> +					entry = pte_swp_mksoft_dirty(entry);
>> +				if (uffd_wp)
>> +					entry = pte_swp_mkuffd_wp(entry);
>> +			}
>>  			VM_WARN_ON(!pte_none(ptep_get(pte + i)));
>>  			set_pte_at(mm, addr, pte + i, entry);
>>  		}
>> @@ -3046,7 +3090,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>  	}
>>  	pte_unmap(pte);
>>  
>> -	if (!pmd_migration)
>> +	if (present)
>>  		folio_remove_rmap_pmd(folio, page, vma);
>>  	if (freeze)
>>  		put_page(page);
>> @@ -3058,8 +3102,11 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>  void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
>>  			   pmd_t *pmd, bool freeze)
>>  {
>> +
>>  	VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
>> -	if (pmd_trans_huge(*pmd) || is_pmd_migration_entry(*pmd))
>> +	if (pmd_trans_huge(*pmd) || is_pmd_migration_entry(*pmd) ||
>> +			(is_swap_pmd(*pmd) &&
> 
> Should we create is_pmd_device_entry() to match is_pmd_migration_entry()?
> 

Yes, I think that's reasonable, I'll look into it

>> +			is_device_private_entry(pmd_to_swp_entry(*pmd))))
>>  		__split_huge_pmd_locked(vma, pmd, address, freeze);
>>  }
>>  
>> @@ -3238,6 +3285,9 @@ static void lru_add_split_folio(struct folio *folio, struct folio *new_folio,
>>  	VM_BUG_ON_FOLIO(folio_test_lru(new_folio), folio);
>>  	lockdep_assert_held(&lruvec->lru_lock);
>>  
>> +	if (folio_is_device_private(folio))
>> +		return;
>> +
>>  	if (list) {
>>  		/* page reclaim is reclaiming a huge page */
>>  		VM_WARN_ON(folio_test_lru(folio));
>> @@ -3252,6 +3302,7 @@ static void lru_add_split_folio(struct folio *folio, struct folio *new_folio,
>>  			list_add_tail(&new_folio->lru, &folio->lru);
>>  		folio_set_lru(new_folio);
>>  	}
>> +
>>  }
>>  
>>  /* Racy check whether the huge page can be split */
>> @@ -3543,6 +3594,10 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>>  					((mapping || swap_cache) ?
>>  						folio_nr_pages(release) : 0));
>>  
>> +			if (folio_is_device_private(release))
>> +				percpu_ref_get_many(&release->pgmap->ref,
>> +							(1 << new_order) - 1);
> 
> Is there a description somewhere for how we think pgmap->ref works for compound/
> higher-order device private pages? Not that it matters too much, I'd like to
> remove it. Maybe I can create a patch to do that which you can base on top of.
> 

This bit is not needed, I'll be removing the above lines of code.

>>  			lru_add_split_folio(origin_folio, release, lruvec,
>>  					list);
>>  
>> @@ -4596,7 +4651,10 @@ int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
>>  		return 0;
>>  
>>  	flush_cache_range(vma, address, address + HPAGE_PMD_SIZE);
>> -	pmdval = pmdp_invalidate(vma, address, pvmw->pmd);
>> +	if (!folio_is_device_private(folio))
>> +		pmdval = pmdp_invalidate(vma, address, pvmw->pmd);
>> +	else
>> +		pmdval = pmdp_huge_clear_flush(vma, address, pvmw->pmd);
> 
> Do we need to flush? A device private entry is already non-present so is the
> flush necessary?
> 

We're clearing the entry as well, why do you think a flush is not required?

>>  
>>  	/* See folio_try_share_anon_rmap_pmd(): invalidate PMD first. */
>>  	anon_exclusive = folio_test_anon(folio) && PageAnonExclusive(page);
>> @@ -4646,6 +4704,17 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
>>  	entry = pmd_to_swp_entry(*pvmw->pmd);
>>  	folio_get(folio);
>>  	pmde = folio_mk_pmd(folio, READ_ONCE(vma->vm_page_prot));
>> +
>> +	if (unlikely(folio_is_device_private(folio))) {
>> +		if (pmd_write(pmde))
>> +			entry = make_writable_device_private_entry(
>> +							page_to_pfn(new));
>> +		else
>> +			entry = make_readable_device_private_entry(
>> +							page_to_pfn(new));
>> +		pmde = swp_entry_to_pmd(entry);
>> +	}
>> +
>>  	if (pmd_swp_soft_dirty(*pvmw->pmd))
>>  		pmde = pmd_mksoft_dirty(pmde);
>>  	if (is_writable_migration_entry(entry))
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 767f503f0875..0b6ecf559b22 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -200,6 +200,8 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
>>  
>>  	if (PageCompound(page))
>>  		return false;
>> +	if (folio_is_device_private(folio))
>> +		return false;
>>  	VM_BUG_ON_PAGE(!PageAnon(page), page);
>>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
>>  	VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);
>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> index e981a1a292d2..ff8254e52de5 100644
>> --- a/mm/page_vma_mapped.c
>> +++ b/mm/page_vma_mapped.c
>> @@ -277,6 +277,16 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>  			 * cannot return prematurely, while zap_huge_pmd() has
>>  			 * cleared *pmd but not decremented compound_mapcount().
>>  			 */
>> +			swp_entry_t entry;
>> +
>> +			if (!thp_migration_supported())
>> +				return not_found(pvmw);
>> +			entry = pmd_to_swp_entry(pmde);
>> +			if (is_device_private_entry(entry)) {
>> +				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
>> +				return true;
> 
> Do other callers of page_vma_mapped_walk() need to be updated now that large
> device private pages may be returned?
> 

I think we probably need a new flag in the page walk code to return true for device
private entries at points where the callers/walkers care about tracking them.

>> +			}
>> +
>>  			if ((pvmw->flags & PVMW_SYNC) &&
>>  			    thp_vma_suitable_order(vma, pvmw->address,
>>  						   PMD_ORDER) &&
>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>> index 567e2d084071..604e8206a2ec 100644
>> --- a/mm/pgtable-generic.c
>> +++ b/mm/pgtable-generic.c
>> @@ -292,6 +292,12 @@ pte_t *___pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
>>  		*pmdvalp = pmdval;
>>  	if (unlikely(pmd_none(pmdval) || is_pmd_migration_entry(pmdval)))
>>  		goto nomap;
>> +	if (is_swap_pmd(pmdval)) {
>> +		swp_entry_t entry = pmd_to_swp_entry(pmdval);
>> +
>> +		if (is_device_private_entry(entry))
>> +			goto nomap;
>> +	}
>>  	if (unlikely(pmd_trans_huge(pmdval)))
>>  		goto nomap;
>>  	if (unlikely(pmd_bad(pmdval))) {
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index bd83724d14b6..da1e5b03e1fe 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -2336,8 +2336,23 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>  				break;
>>  			}
>>  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>> -			subpage = folio_page(folio,
>> -				pmd_pfn(*pvmw.pmd) - folio_pfn(folio));
>> +			/*
>> +			 * Zone device private folios do not work well with
>> +			 * pmd_pfn() on some architectures due to pte
>> +			 * inversion.
>> +			 */
>> +			if (folio_is_device_private(folio)) {
>> +				swp_entry_t entry = pmd_to_swp_entry(*pvmw.pmd);
>> +				unsigned long pfn = swp_offset_pfn(entry);
>> +
>> +				subpage = folio_page(folio, pfn
>> +							- folio_pfn(folio));
>> +			} else {
>> +				subpage = folio_page(folio,
>> +							pmd_pfn(*pvmw.pmd)
>> +							- folio_pfn(folio));
>> +			}
>> +
>>  			VM_BUG_ON_FOLIO(folio_test_hugetlb(folio) ||
>>  					!folio_test_pmd_mappable(folio), folio);
>>  
>> -- 
>> 2.49.0
>>

Thanks for the detailed feedback

Balbir


