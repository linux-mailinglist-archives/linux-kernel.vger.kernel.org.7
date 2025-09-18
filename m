Return-Path: <linux-kernel+bounces-749489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03A7B14EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA396170EE5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B0E1C5F06;
	Tue, 29 Jul 2025 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MJGL0LYX"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82C317C211;
	Tue, 29 Jul 2025 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753797841; cv=fail; b=TnETMpK68EcYjRJddaGf0oxgvYTz+W+b4GwAZ1lsdoyByul6+tOF0NNK+Sa5xqklIauhKyvi4cW7j/Qn95tv+vkZS9uDs6zwZTvrIy5PsaC7FHucAmyvS6iWjnBTZyT4ro2NpVRzsADgp1fwho9TTei6KAcoop1w6oTPMuO3/yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753797841; c=relaxed/simple;
	bh=bFSlGuCdc4u0kRbLDBLW3UpgKGVg4CnVESe6BjHZSNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LesSMgRkaL3O8YvndoqMg1Iaf8DH+Hj5DwvVq25KZUenLHT3zXdc8Fy+YWMzciJBsfbLvN5bmRkkIMDMO1zO1L33/6DfL7LknezBNzEfoPrUWT1h+gnwmp8IF9LxNcA/nUEIYXxEGhEbx4tLyhkpcc4sb5hGUNROI/+7f1PKL3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MJGL0LYX; arc=fail smtp.client-ip=40.107.212.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q286QejTJDIXHFapfkibLNE4d0vW5g+yEXNtM7EoPxHznM6tdcrfV9yTmGPv8bbk5J90mOjfiEkTqlc88pslH1zmCXHlDwXhGdyaxL87Tf8LLCSIu/h8tqLRx9Y5hq86j5TCRSky2h+3HmvgHvQ12HSs6bKDlIhkogwMuryL4wuyGQ0lcFPNpWaaFPF/IF4Qlz+6u0zXtKes5XWtVo2YMe5aaJk8P+Fn+WF65S8kTmPD3I8O0vQp1LqMOE5RpO30vs6N04n2gpZJDrvK0Pf5+x+lNciEZDMpY0Q7+wf+MhNEbee9J8vD7z4ZgiVqYvZCDQokvuZtP+TJmJqYCKhQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5lfGgoFWb4/4+iV9JZkuHXLSYAa/T+6htV4L/MoZs8=;
 b=Jpx1eV21ynmpqWNsWbpKm3/qanQ1OiPnbRMUrrIBFhZMjMt0tdV4uqFmdzzs0cTqKeTlUfhT0Nqp0B9B1Ep0hBXyi6YdUdgzheZSQuPus2n/m4Sko18LYJqqMGS0GwLju4/jUTcbZq9mRTGvyOECzo+67EE9cN76SS2k77Adp3wwzyvnwhDFR0tATgr9aXSiB+yzrpkgzuS+2HaHlnn7OGpiafrgwHal86f9uPytR37aa4WJbCgHTKY4xPhCjRSIsTlBwPNwRA4SBiBP8rM9QgpBy+vW65pbhk1MCjxtBqL7iyid2UzcOvuInJirgXlx716iwwVxaYEOrCty7/SGQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5lfGgoFWb4/4+iV9JZkuHXLSYAa/T+6htV4L/MoZs8=;
 b=MJGL0LYXiYI1W+QNgkFkOYcm2ik4hCNRzFRQXflSgzV9S5hVwPZkggteDh0oMatx00Um4H3FtoHu0rOtr6+zUtpqq4sSB5s5ONTH/nZ5j7jYSu1/RLDPbrdIK7G0J+6g5PsaQ2S+Pe49/KPDSiQz9cthnPZ6ss/PvIgoYltJEH7vrxgj6/TBfRJYmkpAZdvgbe/AAkTyv2/f2Cm82Rr4H5CGvuvgBgWhc4UIlLniKxJMmrZ3dqbWKDVtkv6pV4Y+5pnqbp7Riw17eEThCfuFBcjb1Y1d7PwG1fzrMy9aBj/AXZh02QDfSbDUkZXC0dZsyPNXmsrBvgoq/NLdeId1+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CYYPR12MB8923.namprd12.prod.outlook.com (2603:10b6:930:bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Tue, 29 Jul
 2025 14:03:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8964.024; Tue, 29 Jul 2025
 14:03:56 +0000
Date: Tue, 29 Jul 2025 11:03:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, iommu@lists.linux.dev,
	virtualization@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/8] dma-mapping: migrate to physical address-based API
Message-ID: <20250729140355.GA72736@nvidia.com>
References: <cover.1750854543.git.leon@kernel.org>
 <751e7ece-8640-4653-b308-96da6731b8e7@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <751e7ece-8640-4653-b308-96da6731b8e7@arm.com>
X-ClientProxiedBy: MN2PR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CYYPR12MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: 321d8f59-e99e-409a-58ef-08ddcea8c21a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gBJ85slrc/H3Axac9i3cCda2aAxYQWMhciU4YT1ZSRIY3Kfj1odW5Uu/4uzZ?=
 =?us-ascii?Q?Th2nB+KKROUt3u6rz9IdwrR8/TMjCbN7YpyDFFLPyJUIALGgkA2WF7SCM8BD?=
 =?us-ascii?Q?N0j69f9ROq7UIhu1/5nfiyfke3rPQPVXm8RfwqcuZlQnbVRk8p4RUftoXwyR?=
 =?us-ascii?Q?IRdn2vASVZCKP3zaRumg1ZGu+r06zmH+q2013BUz01OCKwXVKKy+Hw8UTKOT?=
 =?us-ascii?Q?5Q/V5EJ80NxpqLH+pNIUPoyjORO40+JDgUd57m6Xr19x4x0pE4VQf7ZNc/Na?=
 =?us-ascii?Q?RdNX/bNh7T7QBRFnAPFE3kbetAvuoprNJhUeCgVjz2lCAr+hmo5oKK44/dPq?=
 =?us-ascii?Q?w+Mac16vk5mqZq0uuWaTvTIb5hu0eQ8ZEyYXqheRkategZEeVU4Y/TgvSk1G?=
 =?us-ascii?Q?PJRSItOO9GujEq6dHTURGE+HON9LT4Zu4fn3LNSRcLWMqbjYO/5LnX2clhoh?=
 =?us-ascii?Q?/j72Rj4sxB4f7ewSsdhlQ1EzVk//FhE33XrXRdmRoyX8XX5uRSzGMdz1REZs?=
 =?us-ascii?Q?THdBB3S9L7sl09+ZlZliJNC92nXYvDmWVQbyCELiPUHNZCi5CsdKm47n9Msw?=
 =?us-ascii?Q?mj0DL8V7unmIvsHOU3Rf8L2P7gxvj+7D4OUeae/2EJkdVrkCLW8ctWlCu27p?=
 =?us-ascii?Q?yTjH/vptPB4ZM2ERifpougXel9iCDO5HQKeW5JLXSocGXF0Kpcl9zTn1XyXu?=
 =?us-ascii?Q?0NO3OVL5VsNmVz6LitocZXxZ3GcVfZzX5OmOYeUVTyBLEKxpBMlAAoDQ7AtP?=
 =?us-ascii?Q?88j13QO2n/n7ixeLPN6GqN1Kh6mmstX2inBpDcXkl+RFTO8rTKsMfbafuhq9?=
 =?us-ascii?Q?lZEtQ16IZT1zMpsEB0XyrbAjfwQB72vXkE+7YhssvjGK71tvUwn9fr9UPbIi?=
 =?us-ascii?Q?1wUWlYdrOvqvpw1VOJI2xPvCwwX6+hPqMMRgnH4kDh9+dEm9KQ8x1w01Me8U?=
 =?us-ascii?Q?V5rMVNEPKHNFL6RlxRHmxGl1DQ/o4DihgXMFyLRg7FWNpGx0DkG+BibqBCFM?=
 =?us-ascii?Q?mjlFyK916g/pCunDrYOdDWxw7aJRd1H0dmBxA+lDVARx736rw9tatnN3Y2vL?=
 =?us-ascii?Q?gYc+T2mPFuqQCUeo+nGBItlQIGzdnI+qOdkm8dtrXZETDbT91oeOGpiY6wkH?=
 =?us-ascii?Q?olqsT06as2CZ+gQUhcOuXnmau812h5/MaLQcYcLMnfkitR+D3fx5PY/UR4cw?=
 =?us-ascii?Q?FtOHYqXIjjXmWbmnzTOLsL9fOeYRQP4tNVSVbRuX5mlceZ1yvqhpi2o+zsU4?=
 =?us-ascii?Q?NSjEuQpKmhPUsW+e9gLRVcWU/frzhLhgs64v87vKw2PzijOI8VdxABFtdF9c?=
 =?us-ascii?Q?Gs3xt2UETfVAgTd3/0IDhYjJvOkjUoTRxR+7Mc/1fZDkOZXgjE5zwxBVVuXk?=
 =?us-ascii?Q?FK0aY2bGBnYM8AMsJkl18BySU6wZCFMTEO9bPRke9JJi+e8I9dOmu918iAaK?=
 =?us-ascii?Q?VInu15SYAPQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5a1dp+PcEu42Bl4LnHwXyTw4eSaLO+UzWWWpSfLrouzmGwET7/dbWIljD0mZ?=
 =?us-ascii?Q?CqPH6aXmSdGs4teQg6zaU5brTHgD7e9bNxvGw4qsJvik+a0hHu1CSkmiQrK9?=
 =?us-ascii?Q?dCUqNmWNMgFkWq4iqpZ8fjRZccNQ8/zw0B4j4CFAsDXvOVNnwOaQOoR1Er1i?=
 =?us-ascii?Q?FPnLdXahxGGUjZTAB+bBIyIxTZwLmTEO14tNkBLZafgRuWxrDDpBMVHyASfI?=
 =?us-ascii?Q?POlKLSDszgJ/TKgFiEE/9IUyT0jB0HOQd/jkioQG4gL5omeOGKXGWogZj7kO?=
 =?us-ascii?Q?QHLCRaKAMNEPptNoNC0bWMOzDk6uO+OZnsa3XuBmsWI0LDFCa/g73PhZwPBP?=
 =?us-ascii?Q?6hNCEbwD2z0DaCJnGH2xynjxVPaEPanwjZ351oTP1Wgf+SfkqiSrSQk4DMVC?=
 =?us-ascii?Q?KM76VulrzGW2+TsxyVx3/iSGNBMqWRArlIsJGPZ33EYuXvt4FuzRcB1yLNrt?=
 =?us-ascii?Q?qJAwHrQHCpoVR0VvjJBTxluNh0xUaCfAXy5vN5gQfxM9kqK7sgF18vo8VqFV?=
 =?us-ascii?Q?uPaK3RrMsYzngXpRpbKfv8EC4mGVto+EZNw6ZeFQFGBmZuOMYZ6Uo7nFzccs?=
 =?us-ascii?Q?NDthcpIoL1qEiqrY3rzI3XMatWoo4Xu01JhkZhCH9klsZJ7cWwgThyU/abq/?=
 =?us-ascii?Q?3hbIE5muaIIHLO7stJImcl6trGCdB8ISgJ1aYLredv3xfAmXVtE+1RauvVQp?=
 =?us-ascii?Q?xTMZNTzC3D3+xLl2BJF7/0MNo2d+9giIbsVEK1424l0SjAVCu/EmVPgQfve8?=
 =?us-ascii?Q?IQAIF+7/jJUCSGb5cDtEjWIfp7cBsmoTSpMbvem0oE8qml5a0SHOAIICBYiL?=
 =?us-ascii?Q?HAtZT3KrX6cr/nJrat6mOZfsylmrdwTYtg/aVg7koMsDOFJKQqWoWtOsbxXj?=
 =?us-ascii?Q?ZoPNBykCwjRDfT/ou0WgQI6Ejcisub1huUrGeqDl8carEa98BL0M1X3J3hMP?=
 =?us-ascii?Q?gUyxRYOA5Tw9FpdXhzs9lsC1hXoukq6nusIdFwiJYDVBcbtcgLUJTDMm5zuc?=
 =?us-ascii?Q?r6dzw+LaJaVy5KcJuozT7WyMinjanxiweMzTSsNyu7rbbdSltFwNpAE5Cv0W?=
 =?us-ascii?Q?r+fTNIEguGVqblJwp3NBoxjB+5s16aeB9u+MxVIzvQvdh40YVqSbqYrbSLqy?=
 =?us-ascii?Q?y9Jwm0hymchv6jQXLOInE5Bd6Cq06tuEFKMZIAmg/CamXzQV/KErVsxG1T4S?=
 =?us-ascii?Q?yHdDY6Qm9OCokTOPoLLET3C9HFn/vS0AmM1nlzq0P/9XbtEypa5XbtKzBUIp?=
 =?us-ascii?Q?8aEOprdpGrlK9Ozowi7xn8YKS1ij9Yx1h1hOFs3yAJx82IBVokA4LbZ2sZlp?=
 =?us-ascii?Q?aqI7vFFduGfhaqKFRIYasvPgkRNnj9OGKpnSvWlIsk1/QfIJM30cRl0lc2iQ?=
 =?us-ascii?Q?Id6+TNyaeEMgyxgiNR4rruaLm4i/3CPoqBCEf4ANExLAdfkYUYcRKc3bL9ef?=
 =?us-ascii?Q?02hQHm865f2g36+CMO4vy1lVqUOj6pjOaTeQ3Pq+LRRs2hc60uSoPyulLOXH?=
 =?us-ascii?Q?wAXeNeaesJNf1zN0674/HdTpKrORnwcaj9ypKitSHA1eZ1LkOfW+pUrGHDzL?=
 =?us-ascii?Q?pL70o21MA1cmbIY0/lk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 321d8f59-e99e-409a-58ef-08ddcea8c21a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 14:03:56.5173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yc8LWxbq5e0SbTKy02jNs5Q8GqwjmWV3o9MPp6uCqLldf7/dPEmD7gEtGg23bxk4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8923

On Fri, Jul 25, 2025 at 09:05:46PM +0100, Robin Murphy wrote:

> But given what we do already know of from decades of experience, obvious
> question: For the tiny minority of users who know full well when they're
> dealing with a non-page-backed physical address, what's wrong with using
> dma_map_resource?

I was also pushing for this, that we would have two seperate paths:

- the phys_addr was guarenteed to have a KVA (and today also struct page)
- the phys_addr is non-cachable and no KVA may exist

This is basically already the distinction today between map resource
and map page.

The caller would have to look at what it is trying to map, do the P2P
evaluation and then call the cachable phys or resource path(s).

Leon, I think you should revive the work you had along these lines. It
would address my concerns with the dma_ops changes too. I continue to
think we should not push non-cachable, non-KVA MMIO down the map_page
ops, those should use the map_resource op.

> Does it make sense to try to consolidate our p2p infrastructure so
> dma_map_resource() could return bus addresses where appropriate?

For some users but not entirely :( The sg path for P2P relies on
storing information inside the scatterlist so unmap knows what to do.

Changing map_resource to return a similar flag and then having drivers
somehow store that flag and give it back to unmap is not a trivial
change. It would be a good API for simple drivers, and I think we
could build such a helper calling through the new flow. But places
like DMABUF that have more complex lists will not like it.

For them we've been following the approach of BIO where the
driver/subystem will maintain a mapping list and be aware of when the
P2P information is changing. Then it has to do different map/unmap
sequences based on its own existing tracking.

I view this as all very low level infrastructure, I'm really hoping we
can get an agreement with Chritain and build a scatterlist replacement
for DMABUF that encapsulates all this away from drivers like BIO does
for block.

But we can't start that until we have a DMA API working fully for
non-struct page P2P memory. That is being driven by this series and
the VFIO DMABUF implementation on top of it.

> Are we trying to remove struct page from the kernel altogether? 

Yes, it is a very long term project being pushed along with the
folios, memdesc conversion and so forth. It is huge, with many
aspects, but we can start to reasonably work on parts of them
independently.

A mid-term dream is to be able to go from pin_user_pages() -> DMA
without drivers needing to touch struct page at all. 

This is a huge project on its own, and we are progressing it slowly
"bottom up" by allowing phys_addr_t in the DMA API then we can build
more infrastructure for subsystems to be struct-page free, culminating
in some pin_user_phyr() and phys_addr_t bio_vec someday.

Certainly a big part of this series is influenced by requirements to
advance pin_user_pages() -> DMA, while the other part is about
allowing P2P to work using phys_addr_t without struct page.

Jason

