Return-Path: <linux-kernel+bounces-808552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1911DB5016A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94633A47A4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0F436CC7F;
	Tue,  9 Sep 2025 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XWz1RH02"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF5E36CC71
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431701; cv=fail; b=D5e7zbk6hEf/UBz8M7PP6jzHxGJVxpsx3xl1fVdZeBp0PLv0AaBX8ROHVBmlWuLhFRhxG6jxUPFKqqgLIsK6g85slhDmTDk7oD5AbFx2oQKyD9K/K1EK7SqDb5pR1iA85LBX9KCtzmovWlHd6DWb//61SFv/7yVB12ngv8xTQ64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431701; c=relaxed/simple;
	bh=bR4hgMftEcJ+ZUoe7OZh4fYLXFY8MpFIxx+uK8dOKy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NuR/MSXEcbuPbPa0ajK2g9Nth+7vS4lZgEjWQbYGib/7cLeXHhSfhde+pZAMHJcHmPkCmXZSV83DDObIn8vm6/2qHzRNSQ8PluV8Z4jEhKFL84UeCHurmcbynvNcOubNZZ+EJngFZELOI7bRlon/Ch9q53/LBjDLk5NVukYe3EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XWz1RH02; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZShrKjFuJno+Xzg5jJCOC0xbKxmgt0KbkJkSDVsMHvKhBce9lGbL7vzsZBtUbL+N6JA2gReRDmkDM5WYANlGMNgT7vqEwZSnS/iQR9PfG1qG/COv979yBrtjhUv3GZZpU/fMFhGdPIGF+h8dKxP6GMWOlkSQ6AbJ00qLz7zEPCftASBGwxjGd4nQ2+0hpzMR9IJkvm7QxE1K/IIamuh9WFG7kGW++zP/MxdrPWL1zXz9tu7Bamac9x8/Y837jxIbY5q/f5Ug/29iWsTXBg7a+PhyEpKXM7heZUhYNcJWWHQC4JNtOKG8HjJdnKneHkeXM6sMhMhZl9QtNYrckGyHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyqorAfibyYy2vAiLSrimJt8oFjbe4SH9WRahPxJm00=;
 b=JxcePNFBUvBf7J0KKvO8e6xcXbQRC5TY50Qt+B81GMA74LhLxOiDgm4+apXt9A7JmauqOcYzqMSa4a8LMVniLDvkursEcnLnWJdNhZ10o8ZZ5893ybQ+oOZI61bgryOtKVCTAIFCIqodnlFC/+yBAzrxaAaI0i6QE5kZgawwTU3oMNyxogIYWGuUyh+rLgLNFburCBCrZMJKVIm85Svxo4Nou8qw1uDYkcC6KEnyZCNsGtOlKLqmGOXYJToqso8w2o5ufXH0YHH2Ea/MUknGveo2lwW1vCdkGHc1pkNGO+vAggg5Gv5VRKgTCXj2KWFwnZ6yVpKsdQQBUecZjntS3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyqorAfibyYy2vAiLSrimJt8oFjbe4SH9WRahPxJm00=;
 b=XWz1RH02XjrEmi2JopCf94MrZPFGccaQmGPLz5qvKcGOPVR1NO4KW3eUurN7sn44rotOZ/6lr1sxgfGzx+N98FToGhswg4SHgoWyoWosYVTKlMvfDTKBrPHUeG4LIk48YvJNLvXcmO5D9/NxwBgdsczYo4TSIqLDddXka8nWwRoKK8+RWGqfROVN/1JYt8rupkwvVlBb20e2hdR4vHurzXt64UqW9pysamspbegm2qhw6y1JQAXuCH40b8b+CgpBvjvM8HSjNIIvUDcAyUxfx8gu7pgLzsm/7ytWc0ei0zBnnFqpf2aXQf9/av6x9RprmYP4umr+SJAEzxzebUS2zQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 15:28:16 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 15:28:16 +0000
Date: Tue, 9 Sep 2025 12:28:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Chris Li <chrisl@kernel.org>, Jason Miu <jasonmiu@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/4] kho: introduce the KHO array
Message-ID: <20250909152814.GL789684@nvidia.com>
References: <20250909144426.33274-1-pratyush@kernel.org>
 <20250909144426.33274-2-pratyush@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909144426.33274-2-pratyush@kernel.org>
X-ClientProxiedBy: YT4PR01CA0228.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::17) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MW3PR12MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: 3951df07-06f5-4921-dee0-08ddefb57f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4yKavV1gv70IRrvmYBiC5LzJxmCz54SRTFp9RQo8Gl7xLjiPtDd4R2TLNx4o?=
 =?us-ascii?Q?sihnN1MPxfSex7q+hmZiCyRUXNGpftUUHw7FUZkz5IbK6AGYOxGBSflSz5En?=
 =?us-ascii?Q?5R6gCPwm0qzHs9f7UaijZcJyx0kKOY/zfw4NgdCn5x6T93As0Q68jpBU5UJP?=
 =?us-ascii?Q?gFZE6cTDSTV5TY8AX4fhk2EPZ27W+BuU/+aO9/tPC+UrWlX+xXN3IlFh10Q3?=
 =?us-ascii?Q?xa7KQNxcO8hD5V4ijH8V4Di9+l1Z/SXX3QyIsDG6ezUYvhbDqN9IGlxWCfsD?=
 =?us-ascii?Q?DDjAOeihP8pYK1mlKiLZHCB9sx4ONHRsaZCl446gxkGDCQL4/3nVC0OjxhPI?=
 =?us-ascii?Q?9AI9vL85ilKCiQPtKn4VAlWzvRTNKoayS6Ay2DJuRuPuVYAn9/iITBpUyhky?=
 =?us-ascii?Q?FeSs+sFS747ruUEmMKMb5/Vav8cC1ZW+vVxVANj7hZpkMc2dXtzK5QgU7paC?=
 =?us-ascii?Q?DPpRxZ5SRLSvKcRIU+2a8yDY25MXjuARXdLFFiP6N7tLJ+9I4gezqnumqa5a?=
 =?us-ascii?Q?HUuUCGncJbKbtakvjiPwtXDjeTz5V4kLfJv7UHjn0SZGjOgzJDWkyV8OLIGA?=
 =?us-ascii?Q?qOiVWu7cS2zAvIqJhzsJk1ze1/VnBhexW8pMu675ca+vzof/RmaNSuWws2PY?=
 =?us-ascii?Q?GEguG3rVrHf8/sYqp6OobZVWRDp+82JXWzCHzrczI4+1GmCfznfQjaqzzpv/?=
 =?us-ascii?Q?J9JSP/qsw9TiyuKrbqj7/gFBxEWqM9Cin4ffqvYattz5CLHiwAbq3hiZ3zJU?=
 =?us-ascii?Q?+upnaY8QZOOe6S3CvxBjtlDHxsxXlV64G6yzIsfSTSMPAT7RFuQrXTZ7Q0nI?=
 =?us-ascii?Q?8l4RhkVcwp7bauaVTlQMD4pL+DokI1uNhIkTG3fklOnCieawviGEZxBKZuiF?=
 =?us-ascii?Q?nS8C6ZjMoPlv32B3SKzd//86Wi8TSKGJ9G5dOXdPWNAu+i4yZzcFGtOdEJgG?=
 =?us-ascii?Q?6U6cwtt63ZKyTQL2l9lQaslr5gfJzma7zQPLCgwmD3lk/FfSVMx++ii3StJQ?=
 =?us-ascii?Q?3AlR4V0DCbaeFDGkF5t/1DwqntSu/kR/H3r2ht2uHxrSnMeNp0algGeimeTP?=
 =?us-ascii?Q?WLv0B5HAU/10iDg5mbMM8gncFzbxcmDD2uRnGYRFwr2/SNnmuQwp2vEsabuR?=
 =?us-ascii?Q?ZmpxMu284GFXotQ7548uvTk8cENvWriDzOL3DPX7hydNXBXBtFfBVv8rhIXP?=
 =?us-ascii?Q?TpMZ/pZY8K75okesUHU/yvwl050Wx9cKgZtrRYXWvXqc3qVoBshntJ8Qh4o+?=
 =?us-ascii?Q?qI7XB85taeusmmmGl/6ZQFQbqbk+emj94LNlD39eg6LEJtNe74fLuWjRjLl/?=
 =?us-ascii?Q?BSVZ0uFLs/7/dTuvdCbUc49sHxgwEYPSu7R6oAd1hrwsBEnpSlFfIYOZfLS/?=
 =?us-ascii?Q?9wb6OsnyAlgNXYq/i+HxaiB/2bnTUrsDQYpwuplX3H0EM0jkvMfR19bkdPlr?=
 =?us-ascii?Q?48xLK1gkSG0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6fHyGWPo66sS9z0FxEjvmv23P0ioEyTfR7sUTNhT3+pnjSqb/A/BsAcqJN0s?=
 =?us-ascii?Q?LLvbfkkYavKDJpGmJaN9HoFoa7HS9GAKLLenvEDbMSdPzt99zlbb6yhMr8yF?=
 =?us-ascii?Q?3wSQDkt5lV7tS/IQVZ6Q64Ax8ENoNILu0BQC1ViDegKlyRKeSbk/mzcUQPVs?=
 =?us-ascii?Q?md5w0GFHCcEvxP5nJuh26RQksFzKMav/QEEGI8Z1yKAqzmGFJ1PBs0+kqEmQ?=
 =?us-ascii?Q?oBF7gJ8LXZN+bxWhcBpILiBaZqxm8IpWFPtbGfOS0D89nZ127738hlz0iU0X?=
 =?us-ascii?Q?D56QpwMLjPdgvZZCJhmTNPghR6bPFCQ0bWjVz+D9jn0pSaYYWu7vivBbg7iZ?=
 =?us-ascii?Q?LDO6MayS7Eggmz0hzPwp3diI36GnwheD6m9xNa0xh1+/GAxQay9qOVlWxBkL?=
 =?us-ascii?Q?7tVNQIWBuHnpySln4QJLiI/IlCRkoxQPGVuIR5fXHA1h2VC8aB4/E37P+MgS?=
 =?us-ascii?Q?u3NML3YcWTd19GGXXZXe3eGubvFDwy/vrpbInGJ4EYxygfodNj+3jc4LMu95?=
 =?us-ascii?Q?hy/HSG1fzHUi9gu++dasOVh+Wa9dhAE3AqWzM8fcR76Aa8LfNcrBZHeQl3ho?=
 =?us-ascii?Q?sqXfqkUIUAYWKkEIhwlnFlzF3s3MKnMYBfmNiIwRcvKOUvR5B0Thi23UzfOB?=
 =?us-ascii?Q?dsgqr8uqM12FTxPdLbxJe2y4S560X/+xK1cqpD7AtjXXScO1HGdQzxeke9k9?=
 =?us-ascii?Q?oJF+hfw7aIt6ywiXKuhwFi8Blai65q3u7bnad2uCC1a98b5GBQH0ZHWrms2K?=
 =?us-ascii?Q?5GPHw0b/a1NBY1tOAQG7zorKuliYpgsORVLnXqNOZzEV56gEjA/NRUBDSpP/?=
 =?us-ascii?Q?8GJKMs09D7cc4wVbPHSpAVYiMt9niQrJIkiPJfa7XUnsFsqjJdzHjRWoEX/P?=
 =?us-ascii?Q?OLeB9TxNpbu2w8onIR4ariailV4nL5r9+nz6iPH+m0HslYoVvVdHx7WtK8gq?=
 =?us-ascii?Q?ZKDFwicogmhjy1ga+SRlKghske777vUldO+Wu12ya20NCYGpOrBSM6DMmJSQ?=
 =?us-ascii?Q?7DkdyB1z0jYr3NeqPLAmAm2t3H/6HGG3LB9NbMZ7GvUDP95uBQPSUPGg1jlt?=
 =?us-ascii?Q?Me6eE4APHEXlHZMNtb6m8H6xSvH5txCvpv9RJS6IUqP0G1Piaw0EePmF8zpH?=
 =?us-ascii?Q?OLF35qRX4Md5xlsjeeE3sM35t9EwFHNyt/iD/y7G7ED2n3KwWfLobV72NSzq?=
 =?us-ascii?Q?O0xJW1hZA2xyHEZLvs3LVvaRDLV7NIwev8FCcxkYhGhLsfjapDGdz0JA1mkE?=
 =?us-ascii?Q?t24o3ocf0m1Zy+1jNY/7RcLUuepKeyyzYXYbAewYwgRac9O6a/t4AZHwzBK/?=
 =?us-ascii?Q?Ya/YByxsWmusUmU26i3AOQWsNhTXF/3MuE7TO/1iKs0D5RuJg9OO+be75Ezh?=
 =?us-ascii?Q?KPzQ4GlwNHpwDbcoYCKC1wnJDfFLsulBEq39N8lZsUyBb5mqypo/lKivQBVA?=
 =?us-ascii?Q?JYNim5AFaLgPDBzhr0S7/JM7DwcyLN6wgPDC3I/E+OmGXcRaD1IvuHylpTda?=
 =?us-ascii?Q?C7TWg17sH7JiylRfwAGPXWcsurXC/r7k8r4qS1rQV2Gzk9KNx1BS2KNG5awv?=
 =?us-ascii?Q?nVdVLMgyJcbrMwS3Xrk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3951df07-06f5-4921-dee0-08ddefb57f14
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 15:28:16.4626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xn13DIFI4ZFpcV/AeYZkscJv1C1PrQgBFAPc4OeXXOgMIElXgMVsu8ixROv30IZI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457

On Tue, Sep 09, 2025 at 04:44:21PM +0200, Pratyush Yadav wrote:
> The KHO Array is a data structure that behaves like a sparse array of
> pointers. It is designed to be preserved and restored over Kexec
> Handover (KHO), and targets only 64-bit platforms. It can store 8-byte
> aligned pointers. It can also store integers between 0 and LONG_MAX. It
> supports sparse indices, though it performs best with densely clustered
> indices.

That is a bit of an understatement, it looks like worst case cost is
4k per entry. I would expect better efficiency than this if we are
serious about supporting sparsity..

I think you need to encode the start pos within the entries in some
way so worst case cost is bounded to more like 16/24 byte per entry.

For instance if the page was broken up into an array of structs like

struct entries_block {
  u64 flags:1;
  u64 num_entries:13
  u64 pos_increment:50;
  u64 entries[]; // contiguous pos
};

And if a high 64 bit pos can't be represented with pos_increment then
you'd have flags = X and entries[0] == pos instead.

Jason

