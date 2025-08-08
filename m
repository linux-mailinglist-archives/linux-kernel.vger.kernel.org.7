Return-Path: <linux-kernel+bounces-760332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3A6B1E9AE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C418717739C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11721145A05;
	Fri,  8 Aug 2025 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dGElGPWG"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F39513A3F7;
	Fri,  8 Aug 2025 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661400; cv=fail; b=pveNzjBCwwqEqop+VDZzvBErq8VKNSZuilqWAnQkC6aOR2mIoiu/iNtW0Vrg0je/9zXZ58mivsg80Fhjc9Z4UOZgBJWyiPzv9IjXwf+06mHFsJdnRoY9sl/nA9IQxGUmJFiVir+j5Wm5y3LkEqIJwxsE3//mSyZVzwyPxxe9fPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661400; c=relaxed/simple;
	bh=DiE9qvQQW6OX6YmM+PCrc+LqrJRiDdtGFeI4kx8b3tw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u5cuIi3H/GDItDGBJTp1ETYOA5m0pfAUZN+XtkCnVhZdU4UIE6IyEQIyjiqzE7kcelPT0BhQP0OWUKJzz8mvjqwZY1julY0+LsAZCi294L/C5NiS9fv9+nAcppY1tdhoRFnfgGiUqI23lDh5H7I6zyGx0DiqvvdQBbJyonoqJ78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dGElGPWG; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkQScQpxxSh+wJxDrseXHHzlL5jfmR4VTZzFJGF4SACznlGDP4drYCg5Ri/mW+a9Ar0R8zDgiiM52fANiWYaA1TBEIpNDrdgcMeR51vFkniegNsPZPkPBuLr/OOqFjhXhvhZe4RGUQhicVlxdN2h2PHCIElpSn+PWXFy4pAEpZOzk3EgzXYeABrL2zQZFCIA7qsymRQ3l9ZQcRT9PTOqiM5gghqddrS1kV+L98P20tuEKnHnD2JTihaO531OTeYlbgjG9/nLQU3wD8axfVagqddkYble73Fz2atktGpzZ5EKRLtZmgByw1MdGuEyymTlgN9hAHxUWCrD1gO+wiwMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aD8phu2cayVFKfi/FQiV+ZR/3dMk92Cxoxalp8g+W8=;
 b=keBhe1sjRqEQRnWqi9mA4JVZp4RhVLT56BJWzAx0g6rbA65IfPRDu3MEt2xKcL1o8vokFlirQi+wiKPfv9ytMf5dnebW/PxUKye/KqYQMpGLOLnb5GoTd7Jpl1+aNktSGkmlclW8rhOrdAlnqABe1uqr9tZwk0WosGtfugiqvAfco4TlZjZctpkeya9Zr8BqnC7ibXMRcndri/y0L4iavyquyAxxJakuvtaZMeEn307ougiSpOGxK6mD18RFtQvNbbgsRbxkdsreyIHNCY0mzNgrwh77d8uQJY6b1yb87r1X+VyV7lI1lURqEx9lssPtzMw0ywv6Ykr5ztAKhoO/mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aD8phu2cayVFKfi/FQiV+ZR/3dMk92Cxoxalp8g+W8=;
 b=dGElGPWGS87XqUrKud8G7tefDmMHLTt9O0M8/aP8rmFkU5pATsK4ny9ER5I/qqw4D2OjnL2yeWSp8LaBDb/X5WFpBF7GuzPNxXB8a0W7qfn4+lTBSN2UOHxwOBbkqg0MBDNEhCHF+APLpxVRBQI50Spa0EK/kpk3qjH4ccRGi68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by DS7PR12MB5790.namprd12.prod.outlook.com
 (2603:10b6:8:75::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Fri, 8 Aug
 2025 13:56:31 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Fri, 8 Aug 2025
 13:56:30 +0000
Message-ID: <40d722fc-e08c-4543-973a-3fb7ee29bf2a@amd.com>
Date: Fri, 8 Aug 2025 08:56:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 25/34] fs/resctrl: Add event configuration directory
 under info/L3_MON/
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, james.morse@arm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc: Dave.Martin@arm.com, x86@kernel.org, hpa@zytor.com,
 akpm@linux-foundation.org, paulmck@kernel.org, rostedt@goodmis.org,
 Neeraj.Upadhyay@amd.com, david@redhat.com, arnd@arndb.de, fvdl@google.com,
 seanjc@google.com, jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
 xin@zytor.com, manali.shukla@amd.com, tao1.su@linux.intel.com,
 sohil.mehta@intel.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 peterz@infradead.org, xin3.li@intel.com, kan.liang@linux.intel.com,
 mario.limonciello@amd.com, thomas.lendacky@amd.com, perry.yuan@amd.com,
 gautham.shenoy@amd.com, chang.seok.bae@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1753467772.git.babu.moger@amd.com>
 <13467b9a56bccf960974741741b4960a8f02e333.1753467772.git.babu.moger@amd.com>
 <99614342-b6ce-47ec-baf9-f5cdf42f77be@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <99614342-b6ce-47ec-baf9-f5cdf42f77be@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0124.namprd05.prod.outlook.com
 (2603:10b6:803:42::41) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 05941667-6fdf-4a2a-82c1-08ddd6836048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzVPNmNBRk9mb1p6MU5jaDJ5bHRKU0ZOdkhmQ25mcFFHT2ZjWE1pZ28vWVBS?=
 =?utf-8?B?NXYzSmdCbDNiVXFzeERoVFZFWHJyL0JSeUdKeDh1SytUellIL0Y2NXBFaWt5?=
 =?utf-8?B?WmFIcmdKZk9lbElYZEViZ3Fqc0pIZ1M0bERwTjgxWjFhZjdUNUZxa3YwNkw2?=
 =?utf-8?B?eVpUZCtRbDJSY0JwNXNFOGZlWnRpdzlwRGRQeW53ZHJVMVNYVlJNYURWdGh1?=
 =?utf-8?B?Y1lPUVNCY1VyYXZuSVFIUGk2bnpLaVZadnA2Mkg1SDFFSEZmdDlMMUZOSktF?=
 =?utf-8?B?cXlYUi9xUWdJajJ5OUJEOVJoSWVwekVJZEpUTW5lYUp4Skh2TzBadGpZSEJs?=
 =?utf-8?B?bE1SVCtFSU11cTNjSzhCUFpHRU5sRy9ERWhQOEc3b2pkNTROanUvMGE4c2tj?=
 =?utf-8?B?YlVCVVc3aWRyODlyRitPMVVydVE4YlVqN1hYc2RNU240UXJ6dHlDc3BmRVhm?=
 =?utf-8?B?YWdtV0p4Z1pURjZ4TmMwT2xIVmtwdGxQandib1dZVmxZRllPVGVMU1hvQ3Bi?=
 =?utf-8?B?cmxLdGJmMWNKblhuUlRkWHdZdXF5NVN1ZmV4aldFcENXUWNUWVBRY2xlRFgz?=
 =?utf-8?B?ZHBkSWhPN1Q1WkJ3alRNbHBTbkxIQis3UGtEaEZLSEVUNHVVeEY2Z2RLYVY5?=
 =?utf-8?B?ak9CeFJwZnVJN3Bia3VKbVQ4NGdsTlpGZFVqNk9OTVZNaEZMU0tDMWt4TGZt?=
 =?utf-8?B?aXkwTTNlelhLY1FmNnlvYUQza1FSOGxFNUlNVWpoSmRWbU9WbGFXcU82U0lk?=
 =?utf-8?B?Ynp5NS9rb1FPUlg0WDkzUVFwd1NIQkZWRnVWRkxwVUVJUkxBRmZpTnl1a1Nk?=
 =?utf-8?B?L3JESWJMMHNZUFFrc3lLc3dOdDlUYU5QYXpkNUtoWlg2ejZ5RGhueis2UUFi?=
 =?utf-8?B?OWhWUDZIaWEyNEFaQUJjYkE3V0dsNDJCYmUwUEhBYkM4Q2dxUGI2azJiOXVv?=
 =?utf-8?B?MnZnTzg3UG4rbWtEeGdNekJUMlp2MFEvMFR6and6eTZSOTVVMVFXNDU3L0ww?=
 =?utf-8?B?US9BbzQ4Z1EybEhtbnN4MzV1NXp3ZGxuR3VTcUhjeEdsa1k4Z0FmQlZ6ZEFE?=
 =?utf-8?B?akppSnlmdlFHM09YQ3ZCZjNaRFRwNkJtNmNxalJ0T1I4ZHVVRUxlejZPdjdD?=
 =?utf-8?B?WFgwZVQxRDBDM0RaWDJ0Z09QaUM3c1FNZjZXbzZHT2o2bDZzYURrcXl6T3py?=
 =?utf-8?B?MUg3T1plUjZuQURFWDRhOVJZL1E3UlZJMjZZNHhtaUhPcFVYZUtxKzY2MUg0?=
 =?utf-8?B?c3pnei8vOG5vRzVqMkoyeXRFTndGY2JWUUVJNjB4RHN0SUpobUI2OHU3d0Zx?=
 =?utf-8?B?Mnl5NUxjNVViREFpWlFtclZvMHl1L3FGYXpDLzMxVXZUa3dEQXAzLzladDV6?=
 =?utf-8?B?LzhwQmM5OURuU3hoTE5TcDlMMEs2Ny9lQVorazVWUzFWR0tNYWlGY1drR3Ry?=
 =?utf-8?B?dmhhNHBUb3lBaDJQcFBhZm9iNlBPVEJ4Q2NLaWM1THlkYkx3QWVrRzN5QWdp?=
 =?utf-8?B?ZnJKbDdxVm1pQzVZcldsM1dxdnFERUtzVnRsaXcybXZybis0c2x0emY0L2NS?=
 =?utf-8?B?Y085SXRTRHhOcXhrVm5jSzk0M1kxTUZhTktnZWd5a3QzcEVRb0EydXorSjBZ?=
 =?utf-8?B?cDlOaEFWNGRyZHRvL2U2dGU2Tlc2aXJIeEJpSjNoWDN5dnZzYUJtV3R4NG5q?=
 =?utf-8?B?N2poQ2VkTGd6clpUYXFhWWZuR29sWG8yajdoL21hVDJWQTUvTGhnV0hIdTZh?=
 =?utf-8?B?cFNSaEVQUVVuZDNIVEpkTXc2cHVpQVNwTk4xb0RmMjRrTDViZjZSK0FwUFhs?=
 =?utf-8?B?dUVCTHVHY1RRV3YwRmN5UWRnWm9CSmNCcGdHNVhFdTdUVXcxL1FQNmhxelFz?=
 =?utf-8?B?R2IyN2NMZDZBbFhIckpvcUR0T1lCQ2Faa3YrdjA4Yi9USGc0eXRQOFl6MnVN?=
 =?utf-8?Q?6PlKzGoJ2ws=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmtaZHByd3NKeEphMjhQLzNaK0w5Z2FPQnV5bDU3MStxTXo5TThKYjJkVGVi?=
 =?utf-8?B?SXF2YVY0aW9FWGhGOVZ3YXQwUXFJbXd5ZUxRZWEwd3FWckxDWFlNbFByd3pB?=
 =?utf-8?B?RTZiTms2Q2ZNLy9ZcUlWdXlUTWJNd3ZSeDZ2ZWhMVFdnbGsrbE1LRXpMVmlH?=
 =?utf-8?B?b2VoQzhsNHVjL0tQb3U4Szk1TW4wWW9kQkFpQjVhQkRxanZxWFQ0a0RnRUhn?=
 =?utf-8?B?N3lDcWpHK1YxUEM3d3ZJZllPTGpCc1E4eldWNVh5UlozWnF4U2dWYkEyR215?=
 =?utf-8?B?cStZNXdNY3VLTlpVYlZrZExHbnFBVzhncEpRWEhadnVlem5KNEhvWFlIWVc5?=
 =?utf-8?B?K0Q5emMrQ0ljWTIyZFc2SjZsdVB4VEhPT2c1ZmZGM1Y1V1VxRnY2WEhZejhh?=
 =?utf-8?B?d2cvUWZ3c0J1NXAyempGczVVK1hjK0JSUDFHeXUzQXYrTlhZQ3dZZDNtbE5r?=
 =?utf-8?B?R2ExL0pGQUNXZFdkazhFeXpabXVHYmJmVXJ6NUVyZkFacCtNTDkyM3lyUi9X?=
 =?utf-8?B?WXp5NDNJdmlFejVEQnhTb3phNWZISit2bkgwMzhXSmhiSHNSOXZhWVhmYmor?=
 =?utf-8?B?d1owVll4Q2RRYTlpR3RyTHIvRXp2UlZXYXc1ckhvZVpyUVhUZGZWTmNWdG1O?=
 =?utf-8?B?Y3lNWGNyUm5ncnNFL0pTM2g1VDVKeXRpWXNmVWNISjdGV1lWdVppTEZNYjNZ?=
 =?utf-8?B?TmVUOEp4MFlnK0l2aVNaWk9LYmFCSjlqZWpTM2RRZmtSbzg5TGg4U3AvdkdM?=
 =?utf-8?B?VGdxRXl1YUk5QSszaGVkaHJ3aVQwaE9CWXpKY2F3OU9hV21HWFYxUGFNNUNV?=
 =?utf-8?B?UDBEdldmUk9jYzdYRUk1VU9QT2NDSHZjQ2MxbWZ3VzJzcU02alVuN3Jjai8x?=
 =?utf-8?B?MjRKaGxrY2F0Q1p6SitKYy9PRDRGSU9uNWdRelhPdnAxQ09QOHdkMkRjZytM?=
 =?utf-8?B?bVlacDJGU1hLSkR6bEN5UXNSdEVjYXdEaW0zdkVGNzJpS2ZWaitHbkpFckYx?=
 =?utf-8?B?eFNQWndhT1c1blR3ZzhrMTltMEIzbG4zMEdRQ0FwOS8vc3pNUnRRSmd6aVJz?=
 =?utf-8?B?ZFg2UU5vUkdTRnIxNVJsTzUvNHhocUpIR1hZMWdaSlRSdW52RFZyNEgxeFhr?=
 =?utf-8?B?Tk14YTFuVXRsM0NaM0NWREdFZ1dGQ1dXODkyVjU3dGU2eGlKTlZQSmhuWWl0?=
 =?utf-8?B?bm1CM2tyNjJQMzZySzNCZFdhalpRTnBGOGlUYy9Jc2Y2MWlWT3VUcVBZb3Fi?=
 =?utf-8?B?Mi93Z0pLUjhLQ1NqSWRwKzI1MTRvMGZncWljckVNRnh0WnpGRzhKdFpHVFdL?=
 =?utf-8?B?cXU2U3ZWTGM2SEVVdkNoY0dkTzA2UmQ0S09BUDdENndsbzU1ajRvOUYwOWR3?=
 =?utf-8?B?YjNaMTc5RzlXdTdHQU56RDJuVmU2UmkzUUF5UndXb0lKaEtVN3NkdDR1bVox?=
 =?utf-8?B?WUZzdnY2ZlVnemNCNXZTclVDdFRCeTlIclVqVVgrVjB4Nys2S0pTMTJvb0NO?=
 =?utf-8?B?cCttK24xV0IyT1k5bkxOcVFLaExZREtkSmhGNnNNS2tqcHl2cGNhSWV5c1dp?=
 =?utf-8?B?SWRRa09PZ0lHMXZMVTE4UWx4cmI5ZjJTek4wVDF1ZWtLR05IR1NLblE4bkRX?=
 =?utf-8?B?bWZNN01LQitWY1MxNDZqamxTUXA3ZjZVbzV1WW8zMjNLRjFZa2RmcnEzNHRq?=
 =?utf-8?B?NHd2bmJqK1g0MzRQUGt6c2dFZHc2cmpMcXlIcG4zeWJrdExzM2J3cVhkcU9T?=
 =?utf-8?B?RVpYTklQSE9mZjVPV3dFOXRYNXJFTUlYaTRnZmhPdlppVjluV3BXQjlrcjgy?=
 =?utf-8?B?aGhsV0ZyZGVmQkFDNG4xSE9sMnFJV2Z0V2djRVY1N1V5aGd5ZTNHS0NobkNK?=
 =?utf-8?B?S0FWL3VxV21SRS8vMEpnSFJXRlV1VE5tSk1KK1hpYi8zZHd5TWJaNHplUnJQ?=
 =?utf-8?B?OGtoK2lNaWozVHRpQVl6QmJHMGE1eXVPT2NxZjFQUEc5T3ZoVVpXNG41Wm5x?=
 =?utf-8?B?L3E4Tk9TV0hjcEpzMFhkVFM1UUVVb1Vqb1hSM0JsRmtwTHR0NzMxYm5wU0ZX?=
 =?utf-8?B?a3ZaZlB2RXZlbUpNNUI0WmQyTExmUHlxUnViak14dWViM0FSM1RVa0JMZW1o?=
 =?utf-8?Q?MwhdBLzTT5FgICnZbCsD3NEH7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05941667-6fdf-4a2a-82c1-08ddd6836048
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 13:56:30.2745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbYTkBcI1QhZSQawXh7H0E0KrS9AlfoCCbnvo1bf4w+oXbH8MeJT9+9hkTI2c9A5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790

Hi Reinette,

On 7/30/2025 3:04 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 7/25/25 11:29 AM, Babu Moger wrote:
>
>
>> ---
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index 4c24c5f3f4c1..3dfc177f9792 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -310,6 +310,38 @@ with the following files:
>>   	  # cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs
>>   	  0=30;1=30
>>   
>> +"event_configs":
>> +	Directory that exists when "mbm_event" counter assignment mode is supported.
>> +	Contains sub-directory for each MBM event that can be assigned to a counter.
> "Contains sub-directory" -> "Contains a sub-directory"?

Sure.


>> +
>> +	Two MBM events are supported by default: mbm_local_bytes and mbm_total_bytes.
>> +	Each MBM event's sub-directory contains a file named "event_filter" that is
>> +	used to view and modify which memory transactions the MBM event is configured
>> +	with.
>> +
>> +	List of memory transaction types supported:
>> +
>> +	==========================  ========================================================
>> +	Name			    Description
>> +	==========================  ========================================================
>> +	dirty_victim_writes_all     Dirty Victims from the QOS domain to all types of memory
>> +	remote_reads_slow_memory    Reads to slow memory in the non-local NUMA domain
>> +	local_reads_slow_memory     Reads to slow memory in the local NUMA domain
>> +	remote_non_temporal_writes  Non-temporal writes to non-local NUMA domain
>> +	local_non_temporal_writes   Non-temporal writes to local NUMA domain
>> +	remote_reads                Reads to memory in the non-local NUMA domain
>> +	local_reads                 Reads to memory in the local NUMA domain
>> +	==========================  ========================================================
>> +
>> +	For example::
>> +
>> +	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
>> +	  local_reads,remote_reads,local_non_temporal_writes,remote_non_temporal_writes,
>> +	  local_reads_slow_memory,remote_reads_slow_memory,dirty_victim_writes_all
>> +
>> +	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
>> +	  local_reads,local_non_temporal_writes,local_reads_slow_memory
>> +
>>   "max_threshold_occupancy":
>>   		Read/write file provides the largest value (in
>>   		bytes) at which a previously used LLC_occupancy
> ...
>
>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>> index 16bcfeeb89e6..fa5f63126682 100644
>> --- a/fs/resctrl/monitor.c
>> +++ b/fs/resctrl/monitor.c
>> @@ -929,6 +929,29 @@ struct mbm_transaction mbm_transactions[NUM_MBM_TRANSACTIONS] = {
>>   	{"dirty_victim_writes_all", DIRTY_VICTIMS_TO_ALL_MEM},
>>   };
>>   
>> +int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v)
>> +{
>> +	struct mon_evt *mevt = rdt_kn_parent_priv(of->kn);
>> +	bool sep = false;
>> +	int i;
>> +
>> +	mutex_lock(&rdtgroup_mutex);
>> +
> There is inconsistency among the files introduced on how
> "mbm_event mode disabled" case is handled. Some files return failure
> from their _show()/_write() when "mbm_event mode is disabled", some don't.
>
> The "event_filter" file always prints the MBM transactions monitored
> when assignable counters are supported, whether mbm_event mode is enabled
> or not. This means that the MBM event's configuration values are printed
> when "default" mode is enabled.  I have two concerns about this
> 1) This is potentially very confusing since switching to "default" will
>     make the BMEC files visible that will enable the user to modify the
>     event configurations per domain. Having this file print a global event
>     configuration while there are potentially various different domain-specific
>     configuration active will be confusing.
Yes. I agree.
> 2) Can it be guaranteed that the MBM events will monitor the default
>     assignable counter memory transactions when in "default" mode? It has
>     never been possible to query which memory transactions are monitored by
>     the default X86_FEATURE_CQM_MBM_TOTAL and X86_FEATURE_CQM_MBM_LOCAL features
>     so this seems to use one feature to deduce capabilities or another?

So, initialize both total and local event configuration to default 
values when switched to "default mode"?

Something like this?

mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].evt_cfg = r->mon.mbm_cfg_mask;

mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].evt_cfg = READS_TO_LOCAL_MEM | 
READS_TO_LOCAL_S_MEM | NON_TEMP_WRITE_TO_LOCAL_MEM;

We are already doing that right (in patch 32)?


>
>
>> +	for (i = 0; i < NUM_MBM_TRANSACTIONS; i++) {
>> +		if (mevt->evt_cfg & mbm_transactions[i].val) {
>> +			if (sep)
>> +				seq_putc(seq, ',');
>> +			seq_printf(seq, "%s", mbm_transactions[i].name);
>> +			sep = true;
>> +		}
>> +	}
>> +	seq_putc(seq, '\n');
>> +
>> +	mutex_unlock(&rdtgroup_mutex);
>> +
>> +	return 0;
>> +}
>> +
>>   /**
>>    * resctrl_mon_resource_init() - Initialise global monitoring structures.
>>    *
>> @@ -982,6 +1005,7 @@ int resctrl_mon_resource_init(void)
>>   					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
>>   		resctrl_file_fflags_init("available_mbm_cntrs",
>>   					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
>> +		resctrl_file_fflags_init("event_filter", RFTYPE_ASSIGN_CONFIG);
>>   	}
>>   
>>   	return 0;
> ...
>
>> @@ -2295,6 +2339,18 @@ static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
>>   		return ret;
>>   
>>   	ret = rdtgroup_add_files(kn_subdir, fflags);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if ((fflags & RFTYPE_MON_INFO) == RFTYPE_MON_INFO) {
>> +		r = priv;
>> +		if (r->mon.mbm_cntr_assignable) {
>> +			ret = resctrl_mkdir_event_configs(r, kn_subdir);
>> +			if (ret)
>> +				return ret;
>> +		}
>> +	}
>> +
>>   	if (!ret)
>>   		kernfs_activate(kn_subdir);
>>   
> Looks like the "if (!ret)" above can be dropped to always call "kernfs_activate(kn_subdir)"
> on exit making it clear that this is success path and function exits early on any error.

Sure. Will do,

Thanks

Babu


