Return-Path: <linux-kernel+bounces-804011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEF1B468A4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 05:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8C2567757
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 03:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FEA2356D2;
	Sat,  6 Sep 2025 03:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P3PjElwo"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139C92BB13
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 03:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757129226; cv=fail; b=MtY8JZ3CFU5LXw8R6R6/mYtz/Ff+CsaG3SR3B24lunhn/VEM0jMF0NZv3VJXIt+JKBWP/llVTi0XIUr3AowQRnwvvF155wzVpmbH4fxz9r0RSGqJXhQ1Z3i3kqTW9+XTu21uRmSKA0cZfn/BlooRAXfzqSqiW+SJmhh42Z6++hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757129226; c=relaxed/simple;
	bh=+9fngufvRh5CRjiiQbEgduIyijnDc9SlqctD5hqTC0M=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=acFVfw9guw0TQArpXwORtYioWGISxQNY9mPli28se6G+ACu0I/olnqWRfuCeVOsPTjXxL3zpjxtdLeOuDw3gGmhM/5cM6+MMEka/qQSRxGJFwmmFkdk75cPWe0SjUv7az935iRencNIFfst+dCv92R3rULH8P9SbpbX8JKnOwvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P3PjElwo; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzobIGJVLkx3uC26rXQFZN932CYYhSz5qUoBXNZHC7NB5P3RkbvmY3LGGOp36QZ5veOssU0Ykp8HiRks4tOQqBwv8N9V9ZCtcWq1fltStTUj5/qCALfuzCoVZqrEJiZuMr+PWOj6sWwtg4RecV26pTlAJMBDnie9etOJZuXKGVyj+efE0faC0+f3OV4o0w0G4XJqy+q6peRFId+2i/4cGFaeF2C8ljux6jETPl+4V9q6oUEXk1BvcF13SI92NEghgFuS9npl8StxMEy6OGybyIufDEZOXW1EnpQICxP27itKKloU9TxBlZHtj4VTPSpSS7VSCVhxvSbhkwP3FklsQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NZq95Dxek2ACTXZ/dVV1YBRQS+bOa+Ru8QZatFm01E=;
 b=g8Om3fF34cvVgOhK0TVMhDyYhqVLIeJ6yaXzKuVOtJxVdpuJxpt+0jotS/fXEx5uZA/0Dnur4vOitfHPbvxHDdBCgotyvBe59wwTUfKiyEXtpk2KyjPW29+J/CDCKacae7OFKi63+KtS5N4+qDNddN4ht4Wuja3fEmZEHKHgyLtJNG94PMC5Y74JneAj9Zc7Cx/PteOQ65agRRvyBZNPyRP+ihhTBtzCPUvK3ehiqk+ox4wdC+YezQiVcvuG9QaMUyk/Xx88Bqd1KrVuSKT9U1cn7FVySFA2USJpSLALzYrVYYYeOxNLpMEBEzWL9cFCrgelRzPD5E3F1vq5MNiepg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NZq95Dxek2ACTXZ/dVV1YBRQS+bOa+Ru8QZatFm01E=;
 b=P3PjElwo9BVymJAB/k05ty+704twi3So3CL9EuLYPGi4RMmzfpetsiGEWA6DODt8RNhh8GCW04LqixsUi2tD2CtkP5E5vKQi9CtZDU3fU4Q7xfthnn3JxO/dY++4rpIBPCTgHrM/nB1YEKuzbvsWp/9aWqcu0oTtMhIK7zt8Co3dPNxES/OJceVyjT3kVDzpdsS4NjCj37a9Z2vhRsY6wlNX54uIEUEWMUBTfS1ru43O82Y+gNXJ1yl/2fMw+q2W9HbdAJVNQ24FvXq01sgqCTZzPU9iEETK1U9qGY3AWAG88v6bNF08x4bjs5RmKxitxPf3oqUwqVjus4h86EpJeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by CH0PR12MB8461.namprd12.prod.outlook.com (2603:10b6:610:183::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Sat, 6 Sep
 2025 03:27:02 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9094.016; Sat, 6 Sep 2025
 03:27:02 +0000
Message-ID: <1ffb22b9-98e2-4073-8399-217f4ed4d9d9@nvidia.com>
Date: Fri, 5 Sep 2025 20:27:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/gup: Remove dead pgmap refcounting code
From: John Hubbard <jhubbard@nvidia.com>
To: Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org
Cc: david@redhat.com, osalvador@suse.de, jgg@ziepe.ca, peterx@redhat.com,
 linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20250903225926.34702-1-apopple@nvidia.com>
 <5f3b6bf9-1762-48b7-bc36-705055c99ce8@nvidia.com>
Content-Language: en-US
In-Reply-To: <5f3b6bf9-1762-48b7-bc36-705055c99ce8@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:217::23) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|CH0PR12MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: 995e0192-b407-4a61-c59f-08ddecf53efe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0N0TzRpUE96Y3NtU2FMak5CRkwxc2dMWmhhUmRKNnpFTlpTVWQ3S3dKSFZE?=
 =?utf-8?B?S2FySDMxTFFIZmNIZGRaOW1BcVIwaWMxVXNtSnF5NHRkbmI1NW1rS1E0SnNx?=
 =?utf-8?B?WTdUdVNXWmlZZVVvQm9JNGVlVTJUVzM0cTdvMlU2NzIxUnQ2SWR2Q1ViVXVM?=
 =?utf-8?B?MzRrMmUrWWkzb05oaCsyUVpsbDUrSjNRUUR2Y0daSTRza1VwMVBMTy9jdzIy?=
 =?utf-8?B?SElidEVwU0sxWEtsKzhXNzRqdHpYVjRIcU5NU3VsSmFJK1poZ3dnMWZIdGpy?=
 =?utf-8?B?VmxEWFk4OEtHTWpPd3duZFU5V0IxVTNRcmdIOEdWZ3E0S1pnOVVOM2s2dVNa?=
 =?utf-8?B?aG1kaVAxWWVtWU5yTC8xNGdJbG9ma2M5NUxFUG1NaTU3OGpCZEdMcVpqa2ZR?=
 =?utf-8?B?V3dZNm1OYmYxemo4RTByWStrb0Z1RlJSODZmZXcrUUFSWTRkM0pQajJWdmtE?=
 =?utf-8?B?aWdrU003Z0lmazM3SWl4aHBsQk9OTmczQmpPK3pCeXpFcm5iZVo5c21zdmVy?=
 =?utf-8?B?UG9jQ3J4NHlyMzI4cDJQWk1wODkvT0JyYUg5dmx6clJpU1ZWNFBwQWZwZmRk?=
 =?utf-8?B?NXI1b09KUHZLVDVQeUxaTEV6R291VzBzUVBvNHlGMWdvU2pOZUJuWWJtRkJt?=
 =?utf-8?B?bldHUFlrbGRKYUxhSTBYNkN5aUF4ZkdRNFZxUEpBM3BKZzNyczJYV0hkOWEr?=
 =?utf-8?B?ekNHUWhJK3N5Tkpxd1BMaFVmVUlGdGZZbDVWazl6bVhyaVZiSStkTk1GaVBT?=
 =?utf-8?B?cHNXTmZOWDFuR2h4N2ZjTjBUUEhNRXNrS25xa1cvYWJKdWppSkpKVEVZS3dX?=
 =?utf-8?B?RVFJSi9QWlVDQ3hzR0JrRnFMWHJ6Q3NESHF3TDNvSmFiRkx1WEE2YmRrTEpq?=
 =?utf-8?B?b3liT2xyckRDd1Ryb1UvVElWd0NwRDNvd1V2ZU1wQXppTFRJV1UwMVFUdjIw?=
 =?utf-8?B?eCtiaGhlTmtzclhNdWw5U0dqVllYc2Y1QTdGbDNjNVB2RHBlY2pBWHZUbjZJ?=
 =?utf-8?B?VTQ5ZkRwUXFJRnR4Z2c1akRaSXBQUjR4Rmg3L2h5WWprS2xkbm54WnZtNDY5?=
 =?utf-8?B?RDVWSlpYcDVCeGQrOUdTTFR5RVYyQmF0M1lPWmp2QzlRY2h3dk0zTVM2dXE5?=
 =?utf-8?B?RUlIbmNockJiMzZwYTRzald4QlRKSlRwMGR1VEdKMHpScEw2UllBZ0thdnZR?=
 =?utf-8?B?TmJnayt5TVVRQkIwVVRPZlhSdlNsWjY1SllaMEc5RGpVN3F2bzkvQlY1aWFS?=
 =?utf-8?B?ajJpdFFGbk1mKzUveTBSNDdjMlFUeEZ3blAxVU1RbEZ6dk5Bc3BhZmxCTEQ3?=
 =?utf-8?B?Qm84Z0lqQjlCK3ltdUJHOTRnd1BFTVpjWGNVWmVzVG5YMWRKSkJFWHB0M29I?=
 =?utf-8?B?aGRwdU05MUR6MGNiMzZPSmtKY2dJVnZMa0s1WExhdURubnYwMDJpV2tvZFV2?=
 =?utf-8?B?WWtqcEFVbXBwcUEzOW42c0dyWjhsWTJjOGlrM2RDT3VSTmZCTlZmMTB2U1pE?=
 =?utf-8?B?OHdGTDNJMHcvOTAyeFNySURVa0FURVZuazNUdEN6WnBVdFZNTUQzekhBVkNh?=
 =?utf-8?B?b1NzOVhieFZnNldEZ0x2a3hWcmx3RURDcTBLUmpBQ0x0YnNuNE9qVFdIaDJL?=
 =?utf-8?B?dDFKdmc3OXZjTXB4Z3VwSEp4NUZNRlQzcXkrZmVmcjNsRUtOUlY4WjRGUWtB?=
 =?utf-8?B?cVBBN0h0eU5IdmU3OHlWMUFoSnEyU0E1alVmZ3hWNnNmbEtFcC9aTkhpSWZs?=
 =?utf-8?B?R2FlaGZpbklFc2NSWTVwYjUreEhENFpIcVNkUlZlM1RrUEFNSTFPQW00Vld6?=
 =?utf-8?B?QmNlL05VRk5CSzM3YWV0OW9vUCtCWGw5N09zQmtjemx3Y25Kd0xST0JYbitv?=
 =?utf-8?B?TGJwdlNOZ0dENGxsZWJ0QmxUYWx5elhNUkZlRmNwS1B0dTZwdlJLT29ZZi84?=
 =?utf-8?Q?UUAn5uzq7tE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlU3b1plakRtTjFKOVFwVWhVdFdreEpvM0sySVhKMHU5Z2huUzZkRUJZcUxs?=
 =?utf-8?B?WCtBblYxcVMzaWJLaFNsR05WTVRJaHpQUCtBczJpdTNrNnVBVjFIUThoWExo?=
 =?utf-8?B?dEZPQ3p0YXh3eFJ3eDAzY2hWNkJsR0loTitNVFZnVTVKSHVNV3hMOFVwMkgx?=
 =?utf-8?B?SEpMQVJuSk9xZTNqaXdtaVhHc0lQUXpwUTRkc2JoOW1ydWttRnJ6VXBXbzJk?=
 =?utf-8?B?T0Vwa3N1ZHFFZnFIemNSNnZSSzFsanRINFh5RGJNUmFJYithK2x1MEdlbURD?=
 =?utf-8?B?U3h5T0VZYVBnL3FTZmlIb0pyQXMybFBMaWkxWjBScmdjMUZiU2VEWUZBTzJo?=
 =?utf-8?B?R2lWRGwzbHhjNHJMdkxjWjZqRUJoMTVHMmMvYnJJUzZabzZEMm8yWUFmYTMy?=
 =?utf-8?B?Y093KzhWY1RTVk9hYU5iMHRGdE9PRXFRVFdlVFNqR3BZeGt0V21CdlIzNENO?=
 =?utf-8?B?SG91OCsvN21aYW12d2phNnlQUDUrRHlPWjJiYVlPeEJlMnVrbUpMTTA5OUV6?=
 =?utf-8?B?SkZtUGI5d2pmV2c1OUxSYnpxZHUraEhITWpGNGJJd2h2c2M1SzViK0RWNnIz?=
 =?utf-8?B?NG5KSDNaOUJxS3R1WHlad0tTTklYVE1CeHQ0eVIwVmpzV1E2ZmFUcENzZDQ4?=
 =?utf-8?B?UkkrMFdKaWxOWUJKNkRtWFRlOEdPNWg5TFJJTWhnMG1jR3p2Q0dGVGRkMUFY?=
 =?utf-8?B?dk9DOUdKVjhEMlVTUlYyUU5jU3dWQ3c1eEpXdE9VenFDaUdRWjJzNUtRMVla?=
 =?utf-8?B?Wjh6ZWVoNXBQa3NaYVhoZU9hTkN5WU5jRUx4eVhZeHl6b2N6Nm9qQ0VPTXV3?=
 =?utf-8?B?WnB2RitCa0tEK2pSVS9LRzVBL3AzWTZneGkvOCt5dGdiczVNRXFha2lxdGtn?=
 =?utf-8?B?TWluWlp6SVBWdGZPSXB3SnExblpaS2J1WmV4SFlXNVlMYjc3SklGUW9abFBD?=
 =?utf-8?B?aVpTOUpQZHQvdHY0VjNzYTZnNDJ0dm0wUUN4c1lIYm8zVTcrbU9QZ2NKcFpr?=
 =?utf-8?B?U0V2QXhwbWpldVJOVkFyaWhOQ0R6QkJXcmlUR0FxS0lEQVBvR1hpWlgvNEU3?=
 =?utf-8?B?bUZscU0xNmdBYUdUOWtMTXl1cVB3c2tKOWNhR3ppd2pNdkFsWHlVanlxd2Nx?=
 =?utf-8?B?TnhEejFiWUg5Y1laT3FEelh4TGVoOWltVFNuRHh4WVAzaHRRcWhGWlBpS2tN?=
 =?utf-8?B?b1B4K09ZaGNXVDc2Z3pHaHhrTlY0UVY3N3QvSTFoU1hrQ3NxMFBwcm95VU9X?=
 =?utf-8?B?NEVQSmtkTlJWcjliYWNPby9FbFJrbjNPRFZVUmliOHVFcmlFTm9KUmhISUtY?=
 =?utf-8?B?OTNZYUVUTkp5akdyODNGQktFWVkwUDhuYmw0VUJ3VC9UNWJsaWJPS2xjQ0ps?=
 =?utf-8?B?ZmdYTXhwczM1aHVseFltbzlrNlFTQkJJV1l4MGsxOG56Smp4c2ltWnQ4MVRZ?=
 =?utf-8?B?QVBjMmYxbUJDOTBtZExLM2tNbmlieDBBMlViM1JHRXZHMUJQUWwxTE9kaUQ0?=
 =?utf-8?B?Y3AySnpEWUREYnpUd1MyZjhXSUJtRUdrMzJLQ3BOemxLOWJyNk9YRUlIYzRu?=
 =?utf-8?B?bkcrUDh5YmllcnpXZGNEL25aYUp2TnR6ckVDa3A4eUF6b3cra3BiTnkraVBy?=
 =?utf-8?B?YUN2YUVPcVFhWllGYnNQMWpBMlRicU5ZaXJlakh3WVNqK1dlRi9TaDdIcWJs?=
 =?utf-8?B?VThlQXdoNjRFYTVaVWwxSnJ3dmJhbHpIamQyZVRZbExxVE1EZHp0bk5IQTYy?=
 =?utf-8?B?aCtUZFdqSGMxaHBtVVB1ajc5SFZvREx2aDl1UkFHeUcrUFhJODBhdElHeGFa?=
 =?utf-8?B?WENONFgwYitwa3d2RVYwckZrTjJ2bFFSOUYzRnBqUDZxbjA0Rjk0aVVnK2lU?=
 =?utf-8?B?eUpHazJTbGw1THFFajREeE1vZngvejdaVmlvaWNYVjI2LzZzQXlBZVcxaXBy?=
 =?utf-8?B?SGo2a3FTY0x5MVNlbzBjd2JWMndHdXFack9mZ1ljenhDejEvWkJkQ3dNRXFp?=
 =?utf-8?B?WjRZcDAxd0pkbFJCMTdzUUNHdHpDV3ZOMTUxWTBYRm1SamkwMnFjSVQzeXIz?=
 =?utf-8?B?RnlLQnFPTmhlUXo3d1hEdzlZRmdGcmhXZlh6WllUU0JoQk9uRlRuL1hCclZV?=
 =?utf-8?Q?Hf+PQmactWbIykD3hMWRryagO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995e0192-b407-4a61-c59f-08ddecf53efe
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2025 03:27:02.6851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DNcx8T4/r+jruWU6jLAe4TJ/0QfBWH5TWyijWn/qmiqOLDF0QdiSuZ5gMHG20tMmwVhPd0UgVcjPm1TIFRluA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8461

On 9/5/25 5:56 PM, John Hubbard wrote:
...> Maybe I'll post a quick follow-up, in fact, to remove page_mask
> as well. No need to pass that around all over the place, I think
> it can instead be computed by the single place that actually
> consumes it.
> 

Almost, but not quite. The problem is in the -EEXIST return code
case for follow_page_mask(). In that case, we also need folio
size (PMD, PUD, or normal) to be returned. The page_mask argument
does that now, and as long as we are in C, it's awkward to do
anything else. 

oh well.

thanks,
-- 
John Hubbard


