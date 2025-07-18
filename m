Return-Path: <linux-kernel+bounces-737035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EC8B0A6D3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956881C486E8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36032DCF73;
	Fri, 18 Jul 2025 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XeUYj5ga"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A3F2D9ECE
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752851181; cv=fail; b=fRBM/a53ue5sgUM1zT1BD2ykfNoqEO6xvLlGabr5QnpdiqhIQfXKWf77TFrg1F7M4KWNwP7UKLHPDmZ4NeV3h5yeI5Q5ZKjVNgZv/5dnHY9YxY8FO3/kxY7C9v2LbqKp73Cp+OqWab9HqT7Pt2e2Sdj43Ix+idYcMzcpJN3HtOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752851181; c=relaxed/simple;
	bh=MX2nEaStYKblwzz7K2RIAdtKCBcq7zYCTioFITaBDhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kzbo/6gQrgKWm5welK8QA3pBO/T7uFAEdV2mI8tervqLmiPLGSQA564wsWQdrCrSOs3FdP3zUPp5zpIuJlz9k05a8keNjo6S3hTa6Xf+Z131be8FlcO0EBR1W5feff+RXhHxxXF7gWvdD0WX4qLum77+Pq2yukKqBr0SU9SmYRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XeUYj5ga; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+W7tXTwOVgnu3vqWcblTAV2wyOCZM7HdyiISUEfPXDCpyxCaPNwEK3qf2gXqkVf60xqRmkVBpnJ7hJtYXTXuBoDL8EiBLblyArsSd+ikZechFPtzGPxr2yqb1Zibc3BR4U4zCIiBYIz4sIugDni10zGWEWgpSsmf3QkoR8VsU6PGSUehk4Rakvfv6QEAipLEEcYU/oAeOwsCK+gfc6pa4t5ph+poEcTHiwN2XiGmg9JA45ya1zSsDSpPcT4NzW6hlcc2e2pQg2OwkWWovTSdB+rnnjs5sw942pL0wZhlQ8pMKrGMdG++Wc30hTRHlpmTj5xp8ek4/kt1LKCjVQDvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeXLq6nEzyDIq+DaxdmHM1cDLilcB89/Z+nh3xg/4sU=;
 b=qrd4aLBYSBKDpGP6XV7434LCVvyN+wpT8En6Aa5MAuV23OM7N1UhoOtRYB1n1Ok5KUk7p3mWoeHHjPCnD0ayUmXYQsiyjFPgXvcKXVO/qpVelwwWvQkK1EdXW73u28qbZpUeuIuvf/v7serATsvdtixl194lzj7HG7uVSzEwZ8FO49zJ/7Ln9TKrXk/siED46eggXH3oOoBDzcGH1x/kl96fWK19go+24hRe/V0scd0Vvq1sTJtZox5VJBRPKkaqSD2rpZxs0PnaUFJxwvp7jPBDXR8DiwdCOXqNc1VoVsU3ZhKQcXp9fPdprYJGMkYueEG9k80Z8tcy4h7WdnEEGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeXLq6nEzyDIq+DaxdmHM1cDLilcB89/Z+nh3xg/4sU=;
 b=XeUYj5gaQSiDVFo50tcU9t8uPhbNvkASvS22z0kV8r+PMyqiZfIBqbME9rJqj71i6lmulyBJp40U5GHu6bDf88BB9r4AKj2R0G/BWMHCoWi39wOA/BWWLFBQMSm/N/67aELNfQ5+U2oPLGiNN9J6n81lj/GxZFNdETo0weMzo2cdjUTB11Vq4AnmbUxS8Rc9JVLdZwAJSNFTnpwFgBIZK98bQj6yut98tt8emIUJbeXVjaibJ6YgZGD0VIQUqT3w4qKUCTS+fVqTdfsXYarz+uA3AyNIUwrE2BJACFKp/uoEgtz8VTnXHem6yFZz9Y3l/6vSRampdh1Ey7XfbHQpmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.26; Fri, 18 Jul 2025 15:06:13 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 15:06:13 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?utf-8?b?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
 Donet Tom <donettom@linux.ibm.com>
Subject: Re: [v1 resend 08/12] mm/thp: add split during migration support
Date: Fri, 18 Jul 2025 11:06:09 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <5B36BFD4-DFDE-464F-8B2F-6A846D827331@nvidia.com>
In-Reply-To: <aHnAgjaJeyKM+Osm@lstrano-desk.jf.intel.com>
References: <906590D4-04E2-40CB-A853-25FE6212700C@nvidia.com>
 <eab52820-813f-4137-b664-c79ba8b453b7@nvidia.com>
 <aHc5/pmNLf4e9brJ@lstrano-desk.jf.intel.com>
 <1DD0079E-0AF6-49F5-9CB3-E440F36D2D9B@nvidia.com>
 <aHfSTdoi/M9ORrXE@lstrano-desk.jf.intel.com>
 <a7e8485f-e9da-4edb-a809-a014517f26eb@nvidia.com>
 <aHl4IuMlE9D6yaET@lstrano-desk.jf.intel.com>
 <9E024BB0-7365-4A81-81E1-72CB44A07775@nvidia.com>
 <aHmYVkNDRjz5JwNf@lstrano-desk.jf.intel.com>
 <9F4425D6-609F-40C8-BF24-2455F15234A7@nvidia.com>
 <aHnAgjaJeyKM+Osm@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:208:32f::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM6PR12MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: eb256ae1-8f21-4a9d-05a6-08ddc60ca319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3NMUlV1RjJhTHpZeEQwK0p5OS9QejhtWEYvRWpKMHlUekdGc2E1NnBXZWpa?=
 =?utf-8?B?YnZTNnJGM3BsWCt0M3F4bmRCRXh1aXY2UlVicDZFMUhFemRscWZwcWliNVoz?=
 =?utf-8?B?SnFLMWt6UkdRWEVrQmxOT1VjcUl2bFM1dDFSa29DK1RhdjY3MGdiRENrcW9L?=
 =?utf-8?B?c2ZySmtGTU9jajRpV3NaZmo1c3BOZWxSWTFIUzl1azlXMUNFTjNvUTUvOGdF?=
 =?utf-8?B?THFNb2FadkVIbG9TaFArcTdkREJwMDc2RkZVVU9BVmVFWDZHeEdXbmMwV1pZ?=
 =?utf-8?B?MitVYzVjMzF4Y0IxU1cyNzlkbXUrWkxlUWdBS0xZRlNvNnhRdnZpZytLQzFO?=
 =?utf-8?B?b0hReG5aOXVKbG1yZStKYnhVbmFnbFY5WnRWVWtkOWEzUVlFM1ZhM3ZFREV6?=
 =?utf-8?B?d3BCUzlNaWJMbW52RW9yOVJLV0ZCcTZ4ZGR0djhZYkQ1YzVFTUlQdTFDdjIw?=
 =?utf-8?B?T3Rkd2pLNkdyVURGZ0EwN1lWUk1vN2c2Z3B3b1g5bHhFVlpnaXhENUw3Zno1?=
 =?utf-8?B?QjNweGQ5dmRjb29ldVR2UWdiNS9jTmpBbFViaFBkUG1MMVJBL0ZoUVpqNU5E?=
 =?utf-8?B?VlZnS2VtdkhNMzlDRHhoR0REaTVJVzBkcFZiN0FnQnQzVVVXNU5XbFZZdHZu?=
 =?utf-8?B?R1Z5U0NETVZBQVZhMlVjbnVTcEdzalpWcVU4cEZ4Nzd1N3pmb1BWbWF1a1Y4?=
 =?utf-8?B?ZUdlUmhXdUxWdUZvZUl4VFBaaVQwOWNtU2NYTmdCNDUrS3FISlg4emVEUkt5?=
 =?utf-8?B?b0ZzMHpmYkwxQSs2ZTB0dTFCUmhhVjRQQU5iVjFGWEZJUEMrRnhlcmUyV0M2?=
 =?utf-8?B?cThFWjZXRjFhL0FQaEZPVXhoV2VTbm9vc1lpYk1HZFRza3haeGU1NUF5S1RO?=
 =?utf-8?B?WEwwaTA1NWR4cXZpYXYyWFdBeS94Mk9PNGxuWW5wOGRHbkF1VXBvUHZ2UERO?=
 =?utf-8?B?cFRGZE5yRC84RXVlWk5VQ0NaSUFsS0I3TmkxTWt4V3RsV1NKTzJSQ1F1Qjhs?=
 =?utf-8?B?bUdMNUlMK2VuZnRrRUdPNjJ0MGpSbW52THVSSms4VDJ0TnBvdFpFbXNrenhu?=
 =?utf-8?B?TjNjVk5QSTJRSnVZelVHK21HT3Z6VW01R0kwanhJU3Zhem5IMnFqc1ZuUGgx?=
 =?utf-8?B?cG52NHZKOEk5NjVveGZhYWpOUGJhOFVRQUhBaHNEaWhvSkxHeVNmNGVGUVc1?=
 =?utf-8?B?K1Fid2EzVkFHWEtkUmNQS3ltY3Mwc3pSeW52OXR5eGt0NFZqNTIzblRRamdt?=
 =?utf-8?B?T3lvWUpxK25WMTVNZHJGbmZCb1ZuZWJYT3dCODBsQ0ZzS3VoMml0VjJOem9u?=
 =?utf-8?B?dVFpb1pzQldENTh6bWhKMU9STEN0Z21Ia0QwNTV3M2FXdTlVRk9zWFNSV21R?=
 =?utf-8?B?SS9LT2NlV0xhK1NyZ2s1MUMvbG1aYTBndC9UaEFyT1lBRnk4UmF0b0o1SHAw?=
 =?utf-8?B?R2xIcFpPenJ4bkJRbzVFcDl0S25GTCtrR2FveWkyc1cwbThoOVdZTjU0VnJi?=
 =?utf-8?B?QnJqSFZsL2pFNGx6anZ0OVRiakR3UU5vWnB1MWRDcXFsQTBWdjZJdGVXejJk?=
 =?utf-8?B?Zm02OFNXZEZGSks0T2w2WnArWElwb29LdEZhaUNKMWM0eXZuZDl1c0VuQWxp?=
 =?utf-8?B?bmszNmVoR1FYdmFXUDlNc2VkaW5LejdIdTZ6b0tFMytWL1lGbzBqeFhJbTA2?=
 =?utf-8?B?RmErK0E5WHhKM2FGcm1LbGlDbkIyV1NYZ1F6dzZMdEpvbWhWbVk3MDZ4eW00?=
 =?utf-8?B?QWs5UC9LUG15ZkFIYUs1SzJJOTFJRmZkMXZ4N2dqN0NnVFB6dmlqL0d4WjRt?=
 =?utf-8?B?MWZYV3RXTmQ0TDhibk5PaDBJU21qQzVJUHBhc3BzaVlxLytFT3crMzJKeVVD?=
 =?utf-8?B?U1RYSHZsenhlbE1ReldkRmRpNmN1ckE3cWs4VXNkMmMxZG9Kd2xFRUlPczJT?=
 =?utf-8?Q?QyHrlLf90SY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czB2WGYxV01VdFZvQlpyV0xiajB0MEtYcS9IWHc0MGVLWVNnZzE5cU8wa3Fy?=
 =?utf-8?B?eE96UjNldVJDSDk1RDhJZk9DMGV6NFpuZXNzWjVsZEVUNmxadUJGK1JXcmJZ?=
 =?utf-8?B?eTg1M21xc0VzeThBb01kbW1BUHUxT0J5K2svQmIyaWN5cVZCdjhpR0s3ZWE1?=
 =?utf-8?B?Y2JYWldWdnRUWG9nZXNHNnA2a012SkdpVmh1ZVZRM3VJektHL1l3aVR3QW5C?=
 =?utf-8?B?NytwT1JWbGlhMVMwbGV2TnFPZER2RnpCOVIyaFYreVBZVjRHVzM3VzJwVUpV?=
 =?utf-8?B?ZlNwRTVtQmM1YTVCb3pUVFhxRGo1T283U1ZXTWYzTnozMXRIZGZsUXpxT25t?=
 =?utf-8?B?SU04R3dCbUEwaC93cnJ6Z1J6dCtXSWNwYWVkOG9PVDQxNEdaWkZLMUQrSk9O?=
 =?utf-8?B?NVFFejlTNnErMFVVRndabHU2TEpQOVdVdEk5N1RoRTB0bTd3dXNRZklLRThY?=
 =?utf-8?B?WWRpWFZrUHUwdXN1NWFpcjJUT0xTZElLdjRaOEFDSnMybWlUL21ybWZ1V2pD?=
 =?utf-8?B?SkJsUzNYZXlDb1E2OTVRS1Q0QTZhajNBYjVPNVBZcFdiaUE3RVBZdlo5OTlr?=
 =?utf-8?B?WnE1eHA3b0IzSEJhNGROYUNnZVgrYkMyM1BNYzFFYXUvc01OeDBHZ2ZjKzlD?=
 =?utf-8?B?RWpicERKblAvWHJoYXBLSTVTVzEyM2l1bTFHV25GQ3RFY0ROR0tzNTE4Y1pD?=
 =?utf-8?B?RTZCdWJLdkFySDZLeFZhc2JZNVczRktlWERoQUZlcXdTbnVVNmlHemwrbU8z?=
 =?utf-8?B?L2R5Y0IwMURndFJwUWt0N3pKdXg4S3JjZWdad2dtVVdjRENzcFJjYW1oaGF5?=
 =?utf-8?B?R0U5ZCsveFZyVDA4bTdSb25jYXJhRGZmak1HMVlrYVliUUk1K0dNVUVnanUz?=
 =?utf-8?B?ejJIWFpNUWs4QnJBcjd2UE9KZnNMMTYzTVBqdzRUQzZGLzlTcVFTUjQ4Qitn?=
 =?utf-8?B?UVZTaTBXMSs3UnRtVnhkbVduRSt3NFRLNUltWFpBMGVJMmhBNFEwSllySDZi?=
 =?utf-8?B?RmZBRVdPek9jOE9IZ0FFL0w0bjdkNHRLT0NVNUh3MVlFZDVsMjE4WTNnZ1Vt?=
 =?utf-8?B?NEdubDl0K1UwYWVzcDFvK0dtdm9BNUhVZi9HWDBXSjJYcms0UEg2OUlUTm0r?=
 =?utf-8?B?dHdDNTdNOE5scnNBaEU4WTc1Q3Rha2RkTFRSS1ZzeE9XMzIxS0VveWF0SDlM?=
 =?utf-8?B?T0krUStLZlpWK2R5N0RFb3BKOHFUMVNJSTdlZklSNWEyTXhyWFl0VEFTZXU4?=
 =?utf-8?B?Zm41WC9VY1kzeEM0UkluY3NiaUIzSmVXVU5ZaFRKYUFVSUZuTHJVRldZeVhV?=
 =?utf-8?B?U1dKYWhqNkJUZUFoaFZKcDAyeHVudTdPd0lZZExINmtqOHJtTlViYWM1eUgy?=
 =?utf-8?B?Zk8rd2hPU2gxU3VCZk5CeldhQk5FS0Z6UUdUZENuekptb0JEbDNGYk84VWV2?=
 =?utf-8?B?cnBUZkFnUEZFMGdtLzVObWFtbjRYejNneEZKenl6QVo0YjIvejVTbG1GaGZC?=
 =?utf-8?B?SW9Pb1ZiRWsycFZwTDBQZ1BiVnZjTUZvTloySEMwcXBYYkFtN0J5UzVtWElF?=
 =?utf-8?B?WTBFSjJVa3ZTdzJiazFMVEtGM0dySEhMdnN2M1ZOYjN1c1hDRW5IOWNNNDRV?=
 =?utf-8?B?d3F3L0tQbDVaR2Mxay8wazZUWUt5c0NqdjNxN3UrbW5rb0RpSnhQV3pwRXFU?=
 =?utf-8?B?ZVRnUk4wSnAvU3BGSHlWRzI0L3ZCR2NzaVU3RmRFNWc1bm1kaVpVVmpnY3px?=
 =?utf-8?B?NmtCOEIzVjRMRHNUKzJNVVhMaE50TEdlb2RGZDdlejRURmIxTmxQbDNQMUVV?=
 =?utf-8?B?NkMrcUtjc2lmWE56TmE4T1V5cVNPZlkzU0JEa0Rldlo2Nk5jUW1YSDVwcXN1?=
 =?utf-8?B?TVRhU3NuazlUZzBUUU93NUxxRWxibTZuYlZkdjRaeVZ6UkdPdyt4SjVTLzVq?=
 =?utf-8?B?UzMyb0s4L2wvd2Z6WlUrMmZpc1U2ejhHSFpjeGs5WkNCV2RrQ3o4RHFJbDZr?=
 =?utf-8?B?dWY5V2VDU0M1U1pFaHhqb21oaHFPSGpWZjJMSTZsK2o1Yko3WmRueU81NDlz?=
 =?utf-8?B?R0FGa2wrREtyeDBoSWxxWTVJSVN4bDc0ZWZBZy9MRHBOR2wxZjVodFNUTnZa?=
 =?utf-8?Q?sg59ICZFoPMYxRzbhhRWWsij0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb256ae1-8f21-4a9d-05a6-08ddc60ca319
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 15:06:13.6131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CwQNm/0N+7AggkJTZqdtRdXiDZus2490XaH89/3GfPWEDnl6CK7d6yo2zEBNtiRQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315

On 17 Jul 2025, at 23:33, Matthew Brost wrote:

> On Thu, Jul 17, 2025 at 09:25:02PM -0400, Zi Yan wrote:
>> On 17 Jul 2025, at 20:41, Matthew Brost wrote:
>>
>>> On Thu, Jul 17, 2025 at 07:04:48PM -0400, Zi Yan wrote:
>>>> On 17 Jul 2025, at 18:24, Matthew Brost wrote:
>>>>
>>>>> On Thu, Jul 17, 2025 at 07:53:40AM +1000, Balbir Singh wrote:
>>>>>> On 7/17/25 02:24, Matthew Brost wrote:
>>>>>>> On Wed, Jul 16, 2025 at 07:19:10AM -0400, Zi Yan wrote:
>>>>>>>> On 16 Jul 2025, at 1:34, Matthew Brost wrote:
>>>>>>>>
>>>>>>>>> On Sun, Jul 06, 2025 at 11:47:10AM +1000, Balbir Singh wrote:
>>>>>>>>>> On 7/6/25 11:34, Zi Yan wrote:
>>>>>>>>>>> On 5 Jul 2025, at 21:15, Balbir Singh wrote:
>>>>>>>>>>>
>>>>>>>>>>>> On 7/5/25 11:55, Zi Yan wrote:
>>>>>>>>>>>>> On 4 Jul 2025, at 20:58, Balbir Singh wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>> On 7/4/25 21:24, Zi Yan wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> s/pages/folio
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Thanks, will make the changes
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Why name it isolated if the folio is unmapped? Isolated fol=
ios often mean
>>>>>>>>>>>>>>> they are removed from LRU lists. isolated here causes confu=
sion.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Ack, will change the name
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>   *
>>>>>>>>>>>>>>>>   * It calls __split_unmapped_folio() to perform uniform a=
nd non-uniform split.
>>>>>>>>>>>>>>>>   * It is in charge of checking whether the split is suppo=
rted or not and
>>>>>>>>>>>>>>>> @@ -3800,7 +3799,7 @@ bool uniform_split_supported(struct =
folio *folio, unsigned int new_order,
>>>>>>>>>>>>>>>>   */
>>>>>>>>>>>>>>>>  static int __folio_split(struct folio *folio, unsigned in=
t new_order,
>>>>>>>>>>>>>>>>  		struct page *split_at, struct page *lock_at,
>>>>>>>>>>>>>>>> -		struct list_head *list, bool uniform_split)
>>>>>>>>>>>>>>>> +		struct list_head *list, bool uniform_split, bool isolat=
ed)
>>>>>>>>>>>>>>>>  {
>>>>>>>>>>>>>>>>  	struct deferred_split *ds_queue =3D get_deferred_split_q=
ueue(folio);
>>>>>>>>>>>>>>>>  	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
>>>>>>>>>>>>>>>> @@ -3846,14 +3845,16 @@ static int __folio_split(struct fo=
lio *folio, unsigned int new_order,
>>>>>>>>>>>>>>>>  		 * is taken to serialise against parallel split or coll=
apse
>>>>>>>>>>>>>>>>  		 * operations.
>>>>>>>>>>>>>>>>  		 */
>>>>>>>>>>>>>>>> -		anon_vma =3D folio_get_anon_vma(folio);
>>>>>>>>>>>>>>>> -		if (!anon_vma) {
>>>>>>>>>>>>>>>> -			ret =3D -EBUSY;
>>>>>>>>>>>>>>>> -			goto out;
>>>>>>>>>>>>>>>> +		if (!isolated) {
>>>>>>>>>>>>>>>> +			anon_vma =3D folio_get_anon_vma(folio);
>>>>>>>>>>>>>>>> +			if (!anon_vma) {
>>>>>>>>>>>>>>>> +				ret =3D -EBUSY;
>>>>>>>>>>>>>>>> +				goto out;
>>>>>>>>>>>>>>>> +			}
>>>>>>>>>>>>>>>> +			anon_vma_lock_write(anon_vma);
>>>>>>>>>>>>>>>>  		}
>>>>>>>>>>>>>>>>  		end =3D -1;
>>>>>>>>>>>>>>>>  		mapping =3D NULL;
>>>>>>>>>>>>>>>> -		anon_vma_lock_write(anon_vma);
>>>>>>>>>>>>>>>>  	} else {
>>>>>>>>>>>>>>>>  		unsigned int min_order;
>>>>>>>>>>>>>>>>  		gfp_t gfp;
>>>>>>>>>>>>>>>> @@ -3920,7 +3921,8 @@ static int __folio_split(struct foli=
o *folio, unsigned int new_order,
>>>>>>>>>>>>>>>>  		goto out_unlock;
>>>>>>>>>>>>>>>>  	}
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> -	unmap_folio(folio);
>>>>>>>>>>>>>>>> +	if (!isolated)
>>>>>>>>>>>>>>>> +		unmap_folio(folio);
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>  	/* block interrupt reentry in xa_lock and spinlock */
>>>>>>>>>>>>>>>>  	local_irq_disable();
>>>>>>>>>>>>>>>> @@ -3973,14 +3975,15 @@ static int __folio_split(struct fo=
lio *folio, unsigned int new_order,
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>  		ret =3D __split_unmapped_folio(folio, new_order,
>>>>>>>>>>>>>>>>  				split_at, lock_at, list, end, &xas, mapping,
>>>>>>>>>>>>>>>> -				uniform_split);
>>>>>>>>>>>>>>>> +				uniform_split, isolated);
>>>>>>>>>>>>>>>>  	} else {
>>>>>>>>>>>>>>>>  		spin_unlock(&ds_queue->split_queue_lock);
>>>>>>>>>>>>>>>>  fail:
>>>>>>>>>>>>>>>>  		if (mapping)
>>>>>>>>>>>>>>>>  			xas_unlock(&xas);
>>>>>>>>>>>>>>>>  		local_irq_enable();
>>>>>>>>>>>>>>>> -		remap_page(folio, folio_nr_pages(folio), 0);
>>>>>>>>>>>>>>>> +		if (!isolated)
>>>>>>>>>>>>>>>> +			remap_page(folio, folio_nr_pages(folio), 0);
>>>>>>>>>>>>>>>>  		ret =3D -EAGAIN;
>>>>>>>>>>>>>>>>  	}
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> These "isolated" special handlings does not look good, I wo=
nder if there
>>>>>>>>>>>>>>> is a way of letting split code handle device private folios=
 more gracefully.
>>>>>>>>>>>>>>> It also causes confusions, since why does "isolated/unmappe=
d" folios
>>>>>>>>>>>>>>> not need to unmap_page(), remap_page(), or unlock?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> There are two reasons for going down the current code path
>>>>>>>>>>>>>
>>>>>>>>>>>>> After thinking more, I think adding isolated/unmapped is not =
the right
>>>>>>>>>>>>> way, since unmapped folio is a very generic concept. If you a=
dd it,
>>>>>>>>>>>>> one can easily misuse the folio split code by first unmapping=
 a folio
>>>>>>>>>>>>> and trying to split it with unmapped =3D true. I do not think=
 that is
>>>>>>>>>>>>> supported and your patch does not prevent that from happening=
 in the future.
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> I don't understand the misuse case you mention, I assume you m=
ean someone can
>>>>>>>>>>>> get the usage wrong? The responsibility is on the caller to do=
 the right thing
>>>>>>>>>>>> if calling the API with unmapped
>>>>>>>>>>>
>>>>>>>>>>> Before your patch, there is no use case of splitting unmapped f=
olios.
>>>>>>>>>>> Your patch only adds support for device private page split, not=
 any unmapped
>>>>>>>>>>> folio split. So using a generic isolated/unmapped parameter is =
not OK.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> There is a use for splitting unmapped folios (see below)
>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>> You should teach different parts of folio split code path to =
handle
>>>>>>>>>>>>> device private folios properly. Details are below.
>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> 1. if the isolated check is not present, folio_get_anon_vma =
will fail and cause
>>>>>>>>>>>>>>    the split routine to return with -EBUSY
>>>>>>>>>>>>>
>>>>>>>>>>>>> You do something below instead.
>>>>>>>>>>>>>
>>>>>>>>>>>>> if (!anon_vma && !folio_is_device_private(folio)) {
>>>>>>>>>>>>> 	ret =3D -EBUSY;
>>>>>>>>>>>>> 	goto out;
>>>>>>>>>>>>> } else if (anon_vma) {
>>>>>>>>>>>>> 	anon_vma_lock_write(anon_vma);
>>>>>>>>>>>>> }
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> folio_get_anon() cannot be called for unmapped folios. In our =
case the page has
>>>>>>>>>>>> already been unmapped. Is there a reason why you mix anon_vma_=
lock_write with
>>>>>>>>>>>> the check for device private folios?
>>>>>>>>>>>
>>>>>>>>>>> Oh, I did not notice that anon_vma =3D folio_get_anon_vma(folio=
) is also
>>>>>>>>>>> in if (!isolated) branch. In that case, just do
>>>>>>>>>>>
>>>>>>>>>>> if (folio_is_device_private(folio) {
>>>>>>>>>>> ...
>>>>>>>>>>> } else if (is_anon) {
>>>>>>>>>>> ...
>>>>>>>>>>> } else {
>>>>>>>>>>> ...
>>>>>>>>>>> }
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>> People can know device private folio split needs a special ha=
ndling.
>>>>>>>>>>>>>
>>>>>>>>>>>>> BTW, why a device private folio can also be anonymous? Does i=
t mean
>>>>>>>>>>>>> if a page cache folio is migrated to device private, kernel a=
lso
>>>>>>>>>>>>> sees it as both device private and file-backed?
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> FYI: device private folios only work with anonymous private pa=
ges, hence
>>>>>>>>>>>> the name device private.
>>>>>>>>>>>
>>>>>>>>>>> OK.
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>> 2. Going through unmap_page(), remap_page() causes a full pa=
ge table walk, which
>>>>>>>>>>>>>>    the migrate_device API has already just done as a part of=
 the migration. The
>>>>>>>>>>>>>>    entries under consideration are already migration entries=
 in this case.
>>>>>>>>>>>>>>    This is wasteful and in some case unexpected.
>>>>>>>>>>>>>
>>>>>>>>>>>>> unmap_folio() already adds TTU_SPLIT_HUGE_PMD to try to split
>>>>>>>>>>>>> PMD mapping, which you did in migrate_vma_split_pages(). You =
probably
>>>>>>>>>>>>> can teach either try_to_migrate() or try_to_unmap() to just s=
plit
>>>>>>>>>>>>> device private PMD mapping. Or if that is not preferred,
>>>>>>>>>>>>> you can simply call split_huge_pmd_address() when unmap_folio=
()
>>>>>>>>>>>>> sees a device private folio.
>>>>>>>>>>>>>
>>>>>>>>>>>>> For remap_page(), you can simply return for device private fo=
lios
>>>>>>>>>>>>> like it is currently doing for non anonymous folios.
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Doing a full rmap walk does not make sense with unmap_folio() =
and
>>>>>>>>>>>> remap_folio(), because
>>>>>>>>>>>>
>>>>>>>>>>>> 1. We need to do a page table walk/rmap walk again
>>>>>>>>>>>> 2. We'll need special handling of migration <-> migration entr=
ies
>>>>>>>>>>>>    in the rmap handling (set/remove migration ptes)
>>>>>>>>>>>> 3. In this context, the code is already in the middle of migra=
tion,
>>>>>>>>>>>>    so trying to do that again does not make sense.
>>>>>>>>>>>
>>>>>>>>>>> Why doing split in the middle of migration? Existing split code
>>>>>>>>>>> assumes to-be-split folios are mapped.
>>>>>>>>>>>
>>>>>>>>>>> What prevents doing split before migration?
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> The code does do a split prior to migration if THP selection fai=
ls
>>>>>>>>>>
>>>>>>>>>> Please see https://lore.kernel.org/lkml/20250703233511.2028395-5=
-balbirs@nvidia.com/
>>>>>>>>>> and the fallback part which calls split_folio()
>>>>>>>>>>
>>>>>>>>>> But the case under consideration is special since the device nee=
ds to allocate
>>>>>>>>>> corresponding pfn's as well. The changelog mentions it:
>>>>>>>>>>
>>>>>>>>>> "The common case that arises is that after setup, during migrate
>>>>>>>>>> the destination might not be able to allocate MIGRATE_PFN_COMPOU=
ND
>>>>>>>>>> pages."
>>>>>>>>>>
>>>>>>>>>> I can expand on it, because migrate_vma() is a multi-phase opera=
tion
>>>>>>>>>>
>>>>>>>>>> 1. migrate_vma_setup()
>>>>>>>>>> 2. migrate_vma_pages()
>>>>>>>>>> 3. migrate_vma_finalize()
>>>>>>>>>>
>>>>>>>>>> It can so happen that when we get the destination pfn's allocate=
d the destination
>>>>>>>>>> might not be able to allocate a large page, so we do the split i=
n migrate_vma_pages().
>>>>>>>>>>
>>>>>>>>>> The pages have been unmapped and collected in migrate_vma_setup(=
)
>>>>>>>>>>
>>>>>>>>>> The next patch in the series 9/12 (https://lore.kernel.org/lkml/=
20250703233511.2028395-10-balbirs@nvidia.com/)
>>>>>>>>>> tests the split and emulates a failure on the device side to all=
ocate large pages
>>>>>>>>>> and tests it in 10/12 (https://lore.kernel.org/lkml/202507032335=
11.2028395-11-balbirs@nvidia.com/)
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Another use case I=E2=80=99ve seen is when a previously allocated=
 high-order
>>>>>>>>> folio, now in the free memory pool, is reallocated as a lower-ord=
er
>>>>>>>>> page. For example, a 2MB fault allocates a folio, the memory is l=
ater
>>>>>>>>
>>>>>>>> That is different. If the high-order folio is free, it should be s=
plit
>>>>>>>> using split_page() from mm/page_alloc.c.
>>>>>>>>
>>>>>>>
>>>>>>> Ah, ok. Let me see if that works - it would easier.
>>>>>>>
>>>>>
>>>>> This suggestion quickly blows up as PageCompound is true and page_cou=
nt
>>>>> here is zero.
>>>>
>>>> OK, your folio has PageCompound set. Then you will need __split_unmapp=
ed_foio().
>>>>
>>>>>
>>>>>>>>> freed, and then a 4KB fault reuses a page from that previously al=
located
>>>>>>>>> folio. This will be actually quite common in Xe / GPU SVM. In suc=
h
>>>>>>>>> cases, the folio in an unmapped state needs to be split. I=E2=80=
=99d suggest a
>>>>>>>>
>>>>>>>> This folio is unused, so ->flags, ->mapping, and etc. are not set,
>>>>>>>> __split_unmapped_folio() is not for it, unless you mean free folio
>>>>>>>> differently.
>>>>>>>>
>>>>>>>
>>>>>>> This is right, those fields should be clear.
>>>>>>>
>>>>>>> Thanks for the tip.
>>>>>>>
>>>>>> I was hoping to reuse __split_folio_to_order() at some point in the =
future
>>>>>> to split the backing pages in the driver, but it is not an immediate=
 priority
>>>>>>
>>>>>
>>>>> I think we need something for the scenario I describe here. I was to
>>>>> make __split_huge_page_to_list_to_order with a couple of hacks but it
>>>>> almostly certainig not right as Zi pointed out.
>>>>>
>>>>> New to the MM stuff, but play around with this a bit and see if I can
>>>>> come up with something that will work here.
>>>>
>>>> Can you try to write a new split_page function with __split_unmapped_f=
olio()?
>>>> Since based on your description, your folio is not mapped.
>>>>
>>>
>>> Yes, page->mapping is NULL in this case - that was part of the hacks to
>>> __split_huge_page_to_list_to_order (more specially __folio_split) I had
>>> to make in order to get something working for this case.
>>>
>>> I can try out something based on __split_unmapped_folio and report back=
.
>>
>> mm-new tree has an updated __split_unmapped_folio() version, it moves
>> all unmap irrelevant code out of __split_unmaped_folio(). You might find
>> it easier to reuse.
>>
>> See: https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/mm=
/huge_memory.c?h=3Dmm-new#n3430
>>
>
> Will take a look. It is possible some of the issues we are hitting are
> due to working on drm-tip + pulling in core MM patches in this series on
> top of that branch then missing some other patches in mm-new. I'll see
> if ww can figure out a work flow to have the latest and greatest from
> both drm-tip and the MM branches.
>
> Will these changes be in 6.17?

Hopefully yes. mm patches usually go from mm-new to mm-unstable
to mm-stable to mainline. If not, we will figure it out. :)

>
>> I am about to update the code with v4 patches. I will cc you, so that
>> you can get the updated __split_unmaped_folio().
>>
>> Feel free to ask questions on folio split code.
>>
>
> Thanks.
>
> Matt
>
>> Best Regards,
>> Yan, Zi


Best Regards,
Yan, Zi

