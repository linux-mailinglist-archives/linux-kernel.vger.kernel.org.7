Return-Path: <linux-kernel+bounces-823735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627BCB8757A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E48F3A9713
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEE02F0C7D;
	Thu, 18 Sep 2025 23:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RCuZ3aek"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6877D34BA57;
	Thu, 18 Sep 2025 23:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758237264; cv=fail; b=Xyl8w2vo9IWaaEAdmFCBvJDUgtJKbGysLPnsQSYl36KpflNAQwEjqlvm5VWNYdCbJCA8ydm6TX++phtYai78slA6zpogZAKXbHILiwK9x+S9tJdMkxIIbrnVrVqIP2fcbQ0gCLo1W46p4386aT5IoIh/JqXgrutkhTpDsFDeHrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758237264; c=relaxed/simple;
	bh=68BJ47bCeJHXcnlzHB0+PNzWj/meScynwAEzdOS0plc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XYFDdPRT8s8FVvAeOI7FK0Yp9r16EH+kGVcRriGv6PzAGyBgT2ED1MQ58dIXjlQv95MXlFqw8gahPQrkINaMrL42Ens+NK9Y4lP0TJDx5U53NpQFehF9ko1s4cybpUWkIxzBgSAVOV00xOqUinU73Aq9bIOLB3t16CTYQX7Vnfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RCuZ3aek; arc=fail smtp.client-ip=52.101.46.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYgu/koOq5bnVttslx6tMioWHwys38fCiYKNnJqdDh1jJzuiv2UA7cbk9RPSCQZZU/iDFyTVMma9ltMMTdg4licEfie9T1QUXjMnAE0ypkrc2AiddMLSdyjRdFNBdx5VNaNhvd8osyYqU4jzsgjw7oyytB7pKncorej1S9YcJBFrZ6ujmw2eih8JN1q+Tqi/uPDn0ngCa9fUoygsTBKDzQIbw0i650fmPSicx7/KJAe0ipIpwDU6avaQ68c7uxMUqEKqipifZG/UrG8OvCSqaBEsJzOcLE4eDzDlWX0azNwMiF0ff8IeiXBayQgwdfP3zBrlfBxRnXc8o0Go1gzrjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fxpnlvy5mnwoWkxk1JDR86chtNcnnXQv+EF7nSmUv+E=;
 b=F4weQz9VJWJ9sJn8XjGgcdX5kJ39gMgP8Xz5a0nJaxpedB0MTTVZKeBRkdaMXclcRXoHFsJZyaYZ67uTZKtTH7gbKig0m6Y3ZbWfLhDPAFFz3yncLIzc4WCx9ilMlNjZzDWaYdLNpSk7vn1+Sa866WZ+537G2aMF8F0Vjq+OVl9ZglvumP93eugTbMQ1aMi+xx+LPzJbey4d143ArKjaE93z1VW2jPnxi1Acie+WDIjILnrMikVCBY8pm1R17Dj/9jKKXjJVTFYm6iKh5S9s2JK9MD0TJ3yjtACeu5dFec+/BvizZwiaE1YowedWmcDVAa62KdrxTeLIbwhraR5cTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fxpnlvy5mnwoWkxk1JDR86chtNcnnXQv+EF7nSmUv+E=;
 b=RCuZ3aekRqwLuT/lRtz1H4dhZfW8oWDYzrt1izTZk/tMJT+1MT8CPupcl0SlwTQr7iq08kZPHh0YbI5IGfJplQ9+9iH1EwU87CsjvilutD+73BVnpZn0co4+3vxNBOR3KA+B1ecTXhqDfEs2wHH7XmKsCW4d9f9urSsAyfb4Hw9Fe6jKNIcfUWXYg7VCtwmp952gU9loUQM6y4wgUbtf8q7sd2AL68XvgYo0laObW8Qj51u52Idpsh1jgkcuU0PC4ul+pxUJxvKcyVcpucL8rdvu5zFXj4b2g9gqMngfGwJO0G08sQme/xWhORn/dlBxzAxaJvOpw4AAgBTxTJ9g9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH7PR12MB5975.namprd12.prod.outlook.com (2603:10b6:510:1da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 18 Sep
 2025 23:14:20 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 23:14:20 +0000
Date: Thu, 18 Sep 2025 20:14:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Andrey Ryabinin <arbn@yandex-team.com>, linux-kernel@vger.kernel.org,
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	James Gowans <jgowans@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, Pratyush Yadav <ptyadav@amazon.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Chris Li <chrisl@kernel.org>, Ashish.Kalra@amd.com,
	William Tu <witu@nvidia.com>, David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 6/7] mm/memblock: Use KSTATE instead of kho to
 preserve preserved_mem_table
Message-ID: <20250918231419.GQ1391379@nvidia.com>
References: <20250909201446.13138-1-arbn@yandex-team.com>
 <20250909201446.13138-7-arbn@yandex-team.com>
 <20250915114707.GB1024672@nvidia.com>
 <893401bc-4754-4c67-a82a-0c49c8e7f447@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <893401bc-4754-4c67-a82a-0c49c8e7f447@gmail.com>
X-ClientProxiedBy: BLAPR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:208:329::28) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH7PR12MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: 39175efd-73ad-42c6-ee58-08ddf709190e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2sFaQ2uvlTIEM1Eje7tTCSNzb/+lGOOwqzm7eM4wMJ7MWSyqJ9XZlNeShHAu?=
 =?us-ascii?Q?8PF5/6Qb5SE8gG5q062aydlnMiCKGc72aGjgcxgbmhjbYVT4fTlqFurZM5Pk?=
 =?us-ascii?Q?APgqHO19cESaD6HuJ0rSxm69wVtKIFY0PP6PfwIK8Pjv/UZWqiWytbBGEJxz?=
 =?us-ascii?Q?PRfp60Obzw4w9t0yN2+EVld7kzm42Lcr0PIqnVhZ7KCtIKUnSLp6gIQhP8gn?=
 =?us-ascii?Q?vMbIfuynZcCbmbVor0EfggO3VSK9QlEezxDn620pFGjbjww8R7xsQYfJhswX?=
 =?us-ascii?Q?2YTj6bgsKx/L8QD3dLoshapcEjcXvLeyXoSg++MsqDSIfEhuCQ5psfSEpXjb?=
 =?us-ascii?Q?cOFXAndtj/fIEfes2+RwPJ1eRbSbon6xqHfMp/Yy8llzx63s7drSehImqaGN?=
 =?us-ascii?Q?IsxwI7vc925uf3ab+v+dIxKcZNm4xwcZwJeoAI4WPQpYLgpeAaeKBRAJWP4y?=
 =?us-ascii?Q?fh0+xzxZclHI/7Oc9G+gtRsuUk5x7zD1uV7E5iikyKRrMLH1i2m8sWWYO/Bo?=
 =?us-ascii?Q?YzROrPj0Bpkny/Z8ryZ0yYVWP0wT7aPSArtlUw5ykdZRFujgD0qT+g0BOg5j?=
 =?us-ascii?Q?wXOL9uJuQ41r/9j1awsTkIezPijRAzPEaI2r0fzIaTipKaO18CCOrHH9mAEy?=
 =?us-ascii?Q?/YSgQzHYOKFHJPLglpaYj8Z1S+ydW/8+mwljy8klkYp/ebqpHrXySXIZAii5?=
 =?us-ascii?Q?Ocoj2J8SFZnPc0hSaMquqFO9wt8ip2WyTBBJ97q1c6op4uL140Dfsc9q6ZG8?=
 =?us-ascii?Q?uX48P9AsCeM2XI5TcsvmuRkyj+6PJ+Y0UlbUjg1kusC6mhXSwpDxDIPWoQVg?=
 =?us-ascii?Q?4rABRWkVC8MmStNgAobL+SfXIDNTqmLnMEQK0s90eN8GTfAB4qmaM7yXuDQK?=
 =?us-ascii?Q?m93BAMySShqbuLcdX+94S7osKirOPHFUP6bCgs5RqOXaPkJlPcrnApOnZziC?=
 =?us-ascii?Q?04fJqvcP/n4LZ9yO6FFDIqHrKvvnwq9kea/u8kKygkcUZUGCMoiumwjTRjm0?=
 =?us-ascii?Q?amUoM1OkwXk00Qd0Npx7TuF9GhCd68wwyiTSGNYrpSp7+Axnee6oEhJNqAvP?=
 =?us-ascii?Q?rFqUdfvp3HxI/ViSjldLM5qV1+PrATTNAMuZc+le2prpBlANnY2aJFx+G6mK?=
 =?us-ascii?Q?Ob0ZIxWwpOrQQtGPAuBWqMc2nhUqg7o3xizywXqK1AIB+ZzInuJiMd9ZR9vk?=
 =?us-ascii?Q?goLHizW+WIr2w6iYFC7yEURPR6nsXPsycg/zlZItdu+jW5CEJ84zMKvS/++E?=
 =?us-ascii?Q?PJhZWlaEzZU2LLrZGAE0MMBm1UBxJESHsj6C3CB/dSFIzcUTLdLMN6zrmr29?=
 =?us-ascii?Q?C74NTSVim+EjBu9Mo+jvgbdiblKwRJpumbbI72uhG1LZ7QWWD+pyMzwixFjw?=
 =?us-ascii?Q?1H/eoc77gR0v+Lgu519XLN87jNX1S/mMrbfnlPItFiEaYAsE2BYgCCQpYDmV?=
 =?us-ascii?Q?TjIsxG9dCBU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dzou9WuhTbWbJQCGuya75rjNET8SHZKTN0UD/YE7l1rLfo82HIp4OdDS8bZI?=
 =?us-ascii?Q?BOcgFGz5OFeQjWQjeC274re6U0zr+XxwD8bM0RHWrhwll27vdAiN3zhVO27F?=
 =?us-ascii?Q?OV8gukxEi3ltQffC0waN+Hh5NVaKUEsM5vOLKGGKXSDq0AH6whusIa/LE4YA?=
 =?us-ascii?Q?hRYsSIJdve+SyNCTBtJn7NHlDDL2adIrU80K9RF0bWGbMAgTuemCsQjRkwwf?=
 =?us-ascii?Q?Ksaaa9g482MPxwZBcseAN40T/h3ufYwS3B2/GJtPwukn2Aiz4ODZvpS0WCxb?=
 =?us-ascii?Q?NYzP/5zeXNpKIXCbjBltnSpkzHQjHfBi1+iZvfYrU+q8wYRe+Dj6l4MkU3hq?=
 =?us-ascii?Q?pyq+Ue/bfZXzP6gIuNzTLdvWpXkbtdlM4NHF2JQroxRHAszwxseu+xy+4h+f?=
 =?us-ascii?Q?PPD5sQRJM6ewc+8YuQ0dk8qxexnHxWIjMn4Xqctki8pCDUXYz+8cRu7rEl5l?=
 =?us-ascii?Q?9g4Ot2rCgg6MZGzW8hF5KQYnNlmdmtN79YOHJbzn8GRd4Xjm5R6MBMg6+EMq?=
 =?us-ascii?Q?brJX39oF+8bFNF1fHPtcsTb9wBjpsSqCmdKk45RABtlnKxwgl9Yjm9K60OAH?=
 =?us-ascii?Q?ySlBZZjWaj3S6V30yPfUOebv2hGFbLFQZOlG4mFfieYtB0SgZz8HSQcvGvS3?=
 =?us-ascii?Q?W0q7CL3tgYgMJzoy+GfmckUDIGBCcECS9vLyrYa2NzH9GXXzPYLpNlp0/syF?=
 =?us-ascii?Q?WDhvVNHCIMQdx74O8kXXz+/YEq2I/xbMzfiZC7himgPJlCz4oIjSTuKhc1uR?=
 =?us-ascii?Q?I/s5fS1/qCsBOM0v0GbJBnwdXIMY+uf6HhakWFRIcNx5DPAqXEv1QUmOqgI9?=
 =?us-ascii?Q?2JIth04vUu87VlCTRy1VjXWXWyMp5dVA3ERy9mVxHyzMfo+R9c0L+s9FMdN8?=
 =?us-ascii?Q?2xZv/ze3vfcGbPtRYzqfXiWJzgO1BxatK4wNCV8Teq1qEnBx3cltGuaLPk31?=
 =?us-ascii?Q?xDLiKclAH2lY1krfVTlFwGgI41W+F16ntGISbu8Oi+eZQWaUkyjBb3X/BWSN?=
 =?us-ascii?Q?70SuPweTsBIvsMrWFi/diqRXa523TJ73VyZYC02FQd/87pah/t0kVFB/hlms?=
 =?us-ascii?Q?zdelrjzBJlSUziRDO94ycRBIpwLyMuQbx9mYJqVrsH30yom6oU6x9gVQqINC?=
 =?us-ascii?Q?K5t9T1VCj0ikeinmlp8p81hHsP2CL6Q6uMGL7LyRI3DWLxe6nuqNLxSy1zWV?=
 =?us-ascii?Q?uKlJd+XdlU4iHb60dNA0YCEBxXRFu/e1NQ8oQm5lz+Ziq7JM+FljFCdxxNeh?=
 =?us-ascii?Q?nB5LC8xCyTGg9qs3IXeTw1DngPLymlJn+uYkXlhS2fSryVzKSQAP+Da5SdL7?=
 =?us-ascii?Q?jGeoda7bq4ybl9njvlGO96sMuWb6vD+pVzJs1ehTyFodDLh6t+s4GIqt+9BT?=
 =?us-ascii?Q?qffhLApEI+/zAqJW4VeDfX0pnDciKLchhYvpBoyXXMvC4nchfPyYHQAPsXKT?=
 =?us-ascii?Q?rRKtSKvwzACnvuPPclcA48lCWVzS8H2HdoB+3yvx5Y9GtuEsa9CMKrqnZV0Q?=
 =?us-ascii?Q?EKGxU0RaRUzpp9tfXHEtGZ3RVwvyxypoQOtcLe2dYpCUxG+IZijkfy4cmQwT?=
 =?us-ascii?Q?u60wKYiNf2HM03NTYtDIRT1z796KuEhnFQWZ4Vy6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39175efd-73ad-42c6-ee58-08ddf709190e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 23:14:20.5819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJfg/8Wf2a5KpQ0/NleD3PUV0WffnnzFmfSzWSwHDccUbtWf/LLz1ZF6SWNnhtSf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5975

On Thu, Sep 18, 2025 at 09:00:31PM +0200, Andrey Ryabinin wrote:

> By contrast, KSTATE centralizes this logic. It avoids duplicating code
> and lets us express the preservation details declaratively instead
> of re-implementing them per struct.

I didn't really see it centralize much of anything, it is just a long
way to spell "memcpy" the way it is being shown here.

I'm all for consolidating, but please do actually show some
consolidation..

> On the versioning side:
> With this approach, introducing a new ABI version (say, abi_map_v1)
> would require us to maintain restore logic for each supported version,
> and carefully handle upgrades between them.

Yes, you MUST do this. It cannot be magically avoided.
 
> With KSTATE, versioning is built in. For example, adding a new field can
> simply be expressed as:

No, it isn't. The code still has to process versions and still has to
understand what to do when the unpacked struct didn't have its fields
written.

If anything it is making it more obfuscated and complicated to tell if
the comparability is done correctly or not.

Jason

