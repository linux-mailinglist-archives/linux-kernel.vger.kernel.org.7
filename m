Return-Path: <linux-kernel+bounces-750442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5A2B15B61
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81CBC18A5C15
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2963526FDA5;
	Wed, 30 Jul 2025 09:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MlaYa7ez"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AE126A0E7
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867318; cv=fail; b=Q8XuR3pO3moltrZcfGV0YGv9W/drpZq03/i7LiQU1xf2uPZkf7DSa/UbN0Md7DJzoRJAB/MCibt5QARjKj8Fiwvo4LcF4YILf+fnwBKugFPjkZUieOQQL+E92PBkvzhAHxBpWcRdTs8ymapQFu+xs4yl+tnLzqaPtUBoY5tXVdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867318; c=relaxed/simple;
	bh=E5ucvU1cLIgM+QhSyHMsj+pB6lKJgj+83OA2SgGBFHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PTnp1ZwFvUGe/HKBANKRDUBpyu8jlw7kzzYik0UxUFH4N+xtRcoYOBwOl8fKadPL27fPGEZE7oNRqTfH+LHYsIphweXC8E4YVSA9k2sygSHa1HnDjm1H/mAVBk/KFlY8gY4M3rJwT5TcI3tXD9Kdz+hdqrI/5Z2omlNYQJdgA8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MlaYa7ez; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRuNxWRcc64MQEU1Nh9RB+zR49kstjNEA0j9KCPJR2BSb42/FEq31R6SZO+fiA1Cu0umXkP+kn1k+SxVu99vMyldqUai8vZJX304mRYlleTwBUsDXHDS15kWQqs4zCxWhCr0a4DOYTrej9INRmnJNZG4FfCHEQfBwEIsAqSOno/Uj0r+AEYegeQu9ZJFuXbp2jnT616RSOglrIozZbeSCDSH3G3T50gzABYiffzBMyI3tMx7XgpzdsgG+Bgm+uyjSmwvFmgsf1pZ564Or3tJX41+qoZAYYaA1mUpnebnuYlf2yDkTnPssiXA46gqh0c8GtA71ZJVLrsNDnmGUv2sFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxqHLF6nAQMeehF9bifmkAhwrXFQrXoM4omQnUIurWw=;
 b=xhVOWOn8AmuylOG6iavlGrrVolQ/W9+3Gic1FHFwI3ZUDActfEAFhZplbB/c930O+EplvfEq2+bLbX1NEd3KVo2YEjqMMYaUXtYCwXixEeJf5k1fqKnpNaXyyiNHMmqEeRtKcjbpvfBjq7PwFB6dhdk6mDgVcNhWBtLX3lKYgLulWL5PTTWrKhc/Dpnwzr+x8zSHPq4Hmfg9Ypu2miueIz1mdUQ/GqO1McuSLju55BKKC2FpujjwNbwFfPgl2gkLczyYnTHgfseR/ZfejPLmSsZzotgkbmqaEQ8aZPdQYvZs7lql67ee1OLSj7IPgbJeYMhdK5OHjjwpuyLX4Lr8mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxqHLF6nAQMeehF9bifmkAhwrXFQrXoM4omQnUIurWw=;
 b=MlaYa7ezXlMqKZqONfvfkwUkqwUrIp9K7Q09jOCcovyrDe9Js8osLEd4ZASppl1bWLwp2vKEIEE4JP25/Sc6o60TIfNjHEzpCh1JG/mCBCc9Gln0atpFy8Og+T9mqyv3UJgvzwvGqkSHblsjPVcQFKbpZvaKBQtl4z/SCnpwsZQKbhC4TbDDH9YW2C2KhkYvWj9p0VzzaX4R8sK2XNhy4X31QOvDzxkOa7vA9bK0+LIHrg5GBYuqccIT81YJwe+rnL6JTsuHSnw4zWcBUFsBvMzillp/+XhWixkMBL6iKzuWd+AhGs4Qv7q1YmqEQ3QIbPbGBEEgBwUIuRqBp0y0Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 09:21:54 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%5]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 09:21:53 +0000
From: Balbir Singh <balbirs@nvidia.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Balbir Singh <balbirs@nvidia.com>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Xu <peterx@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Jane Chu <jane.chu@oracle.com>,
	Alistair Popple <apopple@nvidia.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	=?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Francois Dugast <francois.dugast@intel.com>
Subject: [v2 01/11] mm/zone_device: support large zone device private folios
Date: Wed, 30 Jul 2025 19:21:29 +1000
Message-ID: <20250730092139.3890844-2-balbirs@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730092139.3890844-1-balbirs@nvidia.com>
References: <20250730092139.3890844-1-balbirs@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:806:27::9) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 67b5c4ac-7020-4cec-15a2-08ddcf4a85c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STR3SU92a2JjMUw3K2pabVgzODZySHdRWmtBT2FVRkxRVEZFUm1MNFFjUXQ5?=
 =?utf-8?B?UGlxbnRHNjI1Sncva1U2N0NSK3czS3VUaWtxeEwzVTQzSURiN3hnb0hMMnd6?=
 =?utf-8?B?UnMvMk8rUkx2ZDE3YjdPQ2ExNTYwWmRGZHZRdkd6OHdjVHlqK0FZKzhZL2RL?=
 =?utf-8?B?a2gwMmljS0s5SDNZMldhVzRRbnRLVGl6NU5SOGpPempjcVgwZzRjYW1TWjhB?=
 =?utf-8?B?NmdWdVlqTktYRnlnQm5BaDcyT2x1QzB4RE90SE51WTRtcnJQTkNXdkQzVW1x?=
 =?utf-8?B?SE5nME9sU25NYmduQWJxY0RjaXM1MmtzczJCZml4SzJ1dld0ZG90cVlKOGRG?=
 =?utf-8?B?b3Y0R3NuUWpHSlQwYlhpZzhCaUpuU3E1ZUswOHVVMnY5VnJ3Q25JSVlKZnBS?=
 =?utf-8?B?T0FqVk1DUElrTzRNOG5RRWhlbGg2VFBDVnRra3VFcGh4TnhKTjB5djNxVWU5?=
 =?utf-8?B?dk5zbUVKK0E0YlRQaXRUV2dTZG01UFppOGEramxZTG95OGZ3UGlwQ2NvY2Jp?=
 =?utf-8?B?dGJsRHRtWEd1eDNiZldOaHBIRERqckUwWTIxWCtOdFJOUXh5bjA0WjJlamYv?=
 =?utf-8?B?WWNEOHVOV1UrSXBKdEVMS3F6M2NFNVcyMWxjSExDSC9NS05mZmFWalo0WkIw?=
 =?utf-8?B?NW5LcVdtTytUUm1HSmVqbkNwbnRTNVlrMUw3UFlUaDJEU0dKaDVDbXpEOURW?=
 =?utf-8?B?TGJGVE45ckJNZ24xejd4U2J0THNHNXQwZFlYUzN5c0RaS2VvL2pyVTc5dVhr?=
 =?utf-8?B?NGgraWYwTStWY2xVN25kVlV5YXJNeTZXWWNXRllaZTA5RjRNeFVaemlWZGNI?=
 =?utf-8?B?bzNEZkVjSUVzMGJjSFNGWE1ld3ZsNmFJdThmZW4yaEdnQ2xudnQvVXBZZmJY?=
 =?utf-8?B?UGNHckZiTTZ4dW1wQ2JIVktoTnBsZFp1Vm12WkNGTzA0VHJEb2J2eFErMWFE?=
 =?utf-8?B?SDI2d2s1NVdCb2RXaCtYcWUxWjFxeXBkZ2tSdHlOMGdZdlhFMU5iZ20zNFBR?=
 =?utf-8?B?ajQ2MjI0d0tCVklQZ1o2VFNndWl2OGVkR3FuRjUrd2xUN0NkVTBOTE5oWHZS?=
 =?utf-8?B?SEdid2ZRRmg1QTFWNTQyWG5CRjVTVkRvQ1BtVGc5Y0ZscVFNeFBKZW9VZ3lh?=
 =?utf-8?B?OEdoUVk1bmhmRFFjNlhyeE1JbFd4M005MFlnVmo3RkU1TDAyUG9jOFZyZndZ?=
 =?utf-8?B?bG5qczI3QkZWM3VkejVDZHdMVnNjb2lQZnBvMVdCQlpJTVhmM2dJVVk5cUtH?=
 =?utf-8?B?MFptV2dGZ2JRYVRNTHoxVnVSNzNlOXJHZXA0aTdtMVkvR0JMVzc0S3A1THNm?=
 =?utf-8?B?MG5hamYyak5tSVk5VFVYa3hERXo3bkdxL054OUlLNUYzVXZTSGlNSWt1Sm5Q?=
 =?utf-8?B?S2tLVkl3eC9tR0xnZW9zNUhsT3dSMnptbi92cHk0Q3kwdHA3SStybHA4RkpF?=
 =?utf-8?B?QnNGWjlYR3pXelk0NUpEN3N3UVl0Qm5oU3lvNWVMVHJBcUlPZ2N5RmJRS2c4?=
 =?utf-8?B?QnB6UzM2OUhkbG9Tc1hwZ0w1VjRCQWVndU5KVElwNVBvUVF2cUxtc05mZTIz?=
 =?utf-8?B?RW1TeHVYNzU4Z1J6cW5Qb2UvUTAvMzYvY2tHVkdXem1VRzkyWkltSGNuVW01?=
 =?utf-8?B?dG9FSGhpbTdCRzBqbkJ3VFFtOG9Pd3JHaUdzcXZTd2hjWjd3Z2NpdU1TZnJ4?=
 =?utf-8?B?d1l6cDhRTUtIbzQzWDBoUmVXNzEyZVoyenBhaUUzQkVvWXlPZU9RN2hnOTEr?=
 =?utf-8?B?QnNBZG9pQkd4NWwzNDc4UVV2RDVvOVo0eTlVY01QSUtyVVhFbXhqYjFHbVhj?=
 =?utf-8?B?MnR4WXV0R1NBZ2pjclUxeGNCd2RpR3QyczlDQ2haUFhJQjE3OVBpMDdSQThW?=
 =?utf-8?B?ekhUWlVLdDBpT0NTeXpmekxKa2w3emswYzhIVnhwdFdLaER3bXlNeStsTTly?=
 =?utf-8?Q?mdc2X3ZvlwQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUNlRjNERGVWdUgzbUUxVGMxVDJiUUcyODljRkhFMUZuUm9aME1MNXZscUc0?=
 =?utf-8?B?d1JDMW04SU9LRUhzSDVCenpkM2xBYWxYT0lyRCtzOFdqM2h2NVJ5ek0rVWl2?=
 =?utf-8?B?TmhVMFNJZjdlbnJubkpUd0YwWGtNUHd3b2NlYkJGdGR1R3cyVnpBWnVWQzZi?=
 =?utf-8?B?REhjS1Fmc3NEVjBaVk5Ubi9hdnhOSXFJbmlON2JyTkhoNHg2NXlQcFdoc2g3?=
 =?utf-8?B?OVJvQlAxVXlZMFhYeklCV2FrTHZNZnZleGcxK2FjTE1SNWVaQzg5c2hGcHl0?=
 =?utf-8?B?VGFLTzJyZVlFOHdaUkJoSSs0UGZlZmVPTUQ5bkFWckx2RkFtdzF5UUQyRmtx?=
 =?utf-8?B?dXhGcG5vNXF1YWtOYWJtVjFEbVRpOVE0RlFiNXFpYUtJTnhTNWs5NHhCQ05Y?=
 =?utf-8?B?MUE5dFB2RTVDaFRwRFlYMi84cUlLUzJrZklNVkp2VVpxZ29sZm5Vd3BZTHBR?=
 =?utf-8?B?QkRsUStxM1loZmpZS1RLYzR3RXFWeElsU1RQMGlIWWRJQW01UDk3eWNWcWMx?=
 =?utf-8?B?NnRPUEgreFBhbk5RUnhsT2pDWG9pUFRkKzFXaG4rRkdiZzByczVmKzVlTnZh?=
 =?utf-8?B?MFpXUlM0czhsaXc1SFNTNlZYbW96U3E2TmdxWWdpYTI0NjNlZzdDM3ZBeGRz?=
 =?utf-8?B?Q0ZYbUM2cWEyZktoMFhkSXAyM2pPUzZjYkFYUTdlejJDakE4SmNaUXc4S1JM?=
 =?utf-8?B?RTlQTXJ6WXdoNUdFZlcwa3JpMTF6TWZaSm9oN3dGRTlqck13Szk3SjlsS3VE?=
 =?utf-8?B?cElNUUFsWEdWZjJMczJOOTAwQmhBT0U1S1N6WTdXVCtWUXVjdm1HWkxxNEs5?=
 =?utf-8?B?SEU3YWpaTzQrQkdhMjV3MnVQNDdzNkgxakNuMGNEUUpxeER5SG9GcTJ5OXRJ?=
 =?utf-8?B?Z1RjNEs5Zm8xVkk0MWxnWmdOS1pqMjY2c1A1K21SVW1qN1FGdWpBKytNaDZx?=
 =?utf-8?B?M095M3ZnVnFOVmFTL1hudjFoc1U0K0Evbno5QmhBcFBzQUhzVmNKejVhZDh0?=
 =?utf-8?B?ZlZ5ZHBta2NuOGVmS2Fzc1QycHdmUWNMLzFGTUY5YkE5bzU1L05CQTVVY3Ur?=
 =?utf-8?B?b0hnMnVobnRsU1A0WVF0WlV6eGhOMXJNUkJvTE1TVHhtL0E3S3hwcTJLU2lk?=
 =?utf-8?B?eHBUaDFFV2VJNE4xSDJVYnUwS21EdFlTbmlQdkFTQkg0cWtrUEhrNHFWWFZU?=
 =?utf-8?B?QXhESElpdXZMbXBxUFI2Ukt4UWZaN3Y0dWNic0Jpc3k0WG9QNW9BYml3RTJ4?=
 =?utf-8?B?OTR0T2VKMlNRR3dEZCtHeGVIY1JZZ2VxRks1cWI4ZUdtOHgzNzcxNVZWWjdq?=
 =?utf-8?B?ODJ0Zk1JeUUzQndQaFNJV1ZiRlB1OWVzVnQrVFNwU2ljWU5rSDlkMlJvTmJK?=
 =?utf-8?B?U05DZkowNnBmR25OcndBY2FSRDdlQlRjSEVNSXprU0E5VzlqbzRINGxaaEJJ?=
 =?utf-8?B?RzFDWGxXTzR3STNJd0Q5RkxERXJ2KzMzMjhBR1lmb0h2aFRVRTBLNndhT0lq?=
 =?utf-8?B?ZW1mQTVFQ3YxOW9Ma1VUTEc2a2x5SXFWa2NOekVKTTF1S2NOL1RCQjNxWS9G?=
 =?utf-8?B?dE1NSk9nVW5iOW9tV0tyY1Job25tNW5ndm8zT2luYWw1OGd2eUF6bGlBbWNX?=
 =?utf-8?B?QVoxTlVaVkt5bWk5Z014RDJybWNYSWxyL2YzSUZjcGpoZDlZT0FpazZUQ1Jk?=
 =?utf-8?B?aG91Skt4V1FLRUs3MjJHbkNzeS8yUjYzT1NwQkhKbmk3RXE1RmlnUDJaTUcy?=
 =?utf-8?B?aFNObG1TZzYxbGVWWWlFUlNGV0hnT1BsSDV0UElvOFJ6cFhYZTJRc0Exb0xY?=
 =?utf-8?B?UUU0M0VrcU5vUlkxL2dmR2o5YlZSWFpQak9oQU9BVHlGUzhwOSt5R3FzR2d0?=
 =?utf-8?B?QVlSNTQ0d3hVUWdQVERRdUVIOVpobHhPV0JUVnBjTGFPNll6RTNTZnhYRXhl?=
 =?utf-8?B?V3gxVnVoOUdsN2tpSll6RjV4S0J3NzBnNWxvYTBZWlNGdTFNUU9rZU9vbEht?=
 =?utf-8?B?blV1a1pqTHllaUxGYXBnTkpnN1h5Nm5oT1pXV3B5aHQwSGxCTUpJOHZSRU5i?=
 =?utf-8?B?T0N2Uk1FckY4Um9WTWdqbkVJT01sUUxjbXQ0Ti9jdWN4ZVErZXozamtyWkU1?=
 =?utf-8?Q?DjzveGSIoJYoQJ0dUYrQlP816?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b5c4ac-7020-4cec-15a2-08ddcf4a85c2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 09:21:53.8577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pd1VK2gZN9vSlATfWhKXcdNVZH02THr5y44aWEUtSv6GeumYu75JWkfayBqZlZoRhD6hry9x5a9D+9yTpXKcLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428

Add routines to support allocation of large order zone device folios
and helper functions for zone device folios, to check if a folio is
device private and helpers for setting zone device data.

When large folios are used, the existing page_free() callback in
pgmap is called when the folio is freed, this is true for both
PAGE_SIZE and higher order pages.

Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Donet Tom <donettom@linux.ibm.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Mika Penttilä <mpenttil@redhat.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Francois Dugast <francois.dugast@intel.com>

Signed-off-by: Balbir Singh <balbirs@nvidia.com>
---
 include/linux/memremap.h | 10 ++++++++-
 mm/memremap.c            | 48 +++++++++++++++++++++++++++++-----------
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 4aa151914eab..a0723b35eeaa 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -199,7 +199,7 @@ static inline bool folio_is_fsdax(const struct folio *folio)
 }
 
 #ifdef CONFIG_ZONE_DEVICE
-void zone_device_page_init(struct page *page);
+void zone_device_folio_init(struct folio *folio, unsigned int order);
 void *memremap_pages(struct dev_pagemap *pgmap, int nid);
 void memunmap_pages(struct dev_pagemap *pgmap);
 void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
@@ -209,6 +209,14 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn);
 
 unsigned long memremap_compat_align(void);
+
+static inline void zone_device_page_init(struct page *page)
+{
+	struct folio *folio = page_folio(page);
+
+	zone_device_folio_init(folio, 0);
+}
+
 #else
 static inline void *devm_memremap_pages(struct device *dev,
 		struct dev_pagemap *pgmap)
diff --git a/mm/memremap.c b/mm/memremap.c
index b0ce0d8254bd..3ca136e7455e 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -427,20 +427,19 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
 void free_zone_device_folio(struct folio *folio)
 {
 	struct dev_pagemap *pgmap = folio->pgmap;
+	unsigned int nr = folio_nr_pages(folio);
+	int i;
 
 	if (WARN_ON_ONCE(!pgmap))
 		return;
 
 	mem_cgroup_uncharge(folio);
 
-	/*
-	 * Note: we don't expect anonymous compound pages yet. Once supported
-	 * and we could PTE-map them similar to THP, we'd have to clear
-	 * PG_anon_exclusive on all tail pages.
-	 */
 	if (folio_test_anon(folio)) {
-		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
-		__ClearPageAnonExclusive(folio_page(folio, 0));
+		for (i = 0; i < nr; i++)
+			__ClearPageAnonExclusive(folio_page(folio, i));
+	} else {
+		VM_WARN_ON_ONCE(folio_test_large(folio));
 	}
 
 	/*
@@ -464,11 +463,20 @@ void free_zone_device_folio(struct folio *folio)
 
 	switch (pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
+		if (folio_test_large(folio)) {
+			folio_unqueue_deferred_split(folio);
+
+			percpu_ref_put_many(&folio->pgmap->ref, nr - 1);
+		}
+		pgmap->ops->page_free(&folio->page);
+		percpu_ref_put(&folio->pgmap->ref);
+		folio->page.mapping = NULL;
+		break;
 	case MEMORY_DEVICE_COHERENT:
 		if (WARN_ON_ONCE(!pgmap->ops || !pgmap->ops->page_free))
 			break;
-		pgmap->ops->page_free(folio_page(folio, 0));
-		put_dev_pagemap(pgmap);
+		pgmap->ops->page_free(&folio->page);
+		percpu_ref_put(&folio->pgmap->ref);
 		break;
 
 	case MEMORY_DEVICE_GENERIC:
@@ -491,14 +499,28 @@ void free_zone_device_folio(struct folio *folio)
 	}
 }
 
-void zone_device_page_init(struct page *page)
+void zone_device_folio_init(struct folio *folio, unsigned int order)
 {
+	struct page *page = folio_page(folio, 0);
+
+	VM_WARN_ON_ONCE(order > MAX_ORDER_NR_PAGES);
+
+	/*
+	 * Only PMD level migration is supported for THP migration
+	 */
+	WARN_ON_ONCE(order && order != HPAGE_PMD_ORDER);
+
 	/*
 	 * Drivers shouldn't be allocating pages after calling
 	 * memunmap_pages().
 	 */
-	WARN_ON_ONCE(!percpu_ref_tryget_live(&page_pgmap(page)->ref));
-	set_page_count(page, 1);
+	WARN_ON_ONCE(!percpu_ref_tryget_many(&page_pgmap(page)->ref, 1 << order));
+	folio_set_count(folio, 1);
 	lock_page(page);
+
+	if (order > 1) {
+		prep_compound_page(page, order);
+		folio_set_large_rmappable(folio);
+	}
 }
-EXPORT_SYMBOL_GPL(zone_device_page_init);
+EXPORT_SYMBOL_GPL(zone_device_folio_init);
-- 
2.50.1


