Return-Path: <linux-kernel+bounces-828245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA60B943F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181B73B9BCB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A86A2E0B73;
	Tue, 23 Sep 2025 04:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DklR8Yx9"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430F71A9FA4;
	Tue, 23 Sep 2025 04:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758602581; cv=fail; b=q/NS6F4XAT1Q/HfqC9moy1YGDpi8CDvp1ekvtK55G+PAixqTCiJKf97a35OX5EOnp5uUFVuwtRhq85kwpCKdLGAhWbBk4w6BQpw8KTT5CnQ+5NWLgvuT1/AgwDtjEguA7ORPZDPBSbU12tGv/dFDR+8QzAhQycJNpDbSlQ6m+po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758602581; c=relaxed/simple;
	bh=B7fJ5ClNZoMQgC77rBql39w/yuD6BR9wG2+kk7JqDtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L3N+YPAdxVldsxqz9UdYujQ5wu+qR/7t58iXF1f3ifMa2mzbcEySke/QJpYdfX2yu4Ko2BnmQheQSQy40TQvdcGJJZcSauXv7hBgN7rVpNatDgaQvoNPtZMfiLD978B4yKa6lwgCrsT4Q1dzEXW2U1jGa/7p4NJmj78KBwDbv1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DklR8Yx9 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.56.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jwru53Sb4A2NZXiSk7CWR5gVBBL/S0YdUcRUJ8VW5gW4P0mE6Ft9K9XXsgkKr0GjXSo2OLmNR+asLCjd1svc0ZCE/4RdkGDlg4EeiYgDdgCL3UoYnRNoW/GJ25N03HvUEONn/uNBbwzlHG6V4yFl/SEg1HRRvG/bU3/zc6Bb3sb1//Cptp1jYp9bZH+P07kX6gZm0TSMnyPWqa1f4CxfztZinEgZzuRd3L4PdB3kgIxTbpk5W6OnlGQfN/IQ6LxauySOS+Dr/jQh4AXMRcxuU3x8AEaVejh5CxhzJp7UNVNghIxEF2pLiEHAI5VT18iUUBpJXUp+eaMcJr9TbE5gIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MO3gaWb1BFzDH50VLxSVIbiPCOjAsxwwb0C+47VRk+I=;
 b=F41yMMw4WZJqqLUU7C2yaAf2Qir8DMTugY8ZIUlS7iuaqqdNzU5yCM51RxgjL1kiNWdaEEv1+QFAf8dDcRnDTSCyHOf5Lc9Mbn9++/ovJgsPRmv9vYyuLbXNOsybHU8pac/nft9gOzB0VeJYlIxVjasmowM8QzYhzgHMUS4tfFKgXPy++F80yqurWkZwuPXjRK3ETRiIg84mqnk8CeXhimLWejUdYYwxZEcy5/ySYCxxP1x9byaIhX/UwhO59QJXF66FRen50VrZ4rbFudIH75MBnMA4ScZrp+8QSBVMyoURewJl2Ym4cl+I77guSo/LWibJV3H6a0gF9UM6G1L8qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MO3gaWb1BFzDH50VLxSVIbiPCOjAsxwwb0C+47VRk+I=;
 b=DklR8Yx9OT6XD9oHMJNtjJyEUahA/pm2V2E6UPQRYMJBbRpCZ41fw1Iks5M2RaKm6cmt6JGYm06l5RPciZ7MlCSmLvrorzHPu5ziYR7AErgh0x8mjBuJ56Bzna29BeQGA9OrlH7ib2mdIaDLxl5fN43BGfePHXtHPzGTS55W4Aa5m7eNaqSi1jLBxSHtWmyY3tT9vIyGRyE0NnPaQFTe+3+buA9xX62spH9DhQiH3jvsP77IVU5OtjrVMNCk2AsFyZs6Nc1ZoOv3DQXZenUwaGHF5qMGxLmO1/nVu0VVnKkLlaixZlV2n8QWKQjgoGURY6oR9TPZwdukYSVxPWJUkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA0PR12MB8747.namprd12.prod.outlook.com (2603:10b6:208:48b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Tue, 23 Sep
 2025 04:42:56 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 04:42:56 +0000
Date: Tue, 23 Sep 2025 14:42:50 +1000
From: Alistair Popple <apopple@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Timur Tabi <ttabi@nvidia.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	"dakr@kernel.org" <dakr@kernel.org>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "lossin@kernel.org" <lossin@kernel.org>, 
	"ojeda@kernel.org" <ojeda@kernel.org>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, 
	"a.hindborg@kernel.org" <a.hindborg@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>, 
	"tmgross@umich.edu" <tmgross@umich.edu>, "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>, 
	"simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org" <mripard@kernel.org>, 
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>, 
	"airlied@gmail.com" <airlied@gmail.com>, "aliceryhl@google.com" <aliceryhl@google.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, "gary@garyguo.net" <gary@garyguo.net>
Subject: Re: [PATCH v2 08/10] nova-core: falcon: Add support to check if
 RISC-V is active
Message-ID: <5snrr6hpwqfd7pfpd4qqvytwuwv6aimfatv4zymhlo2ymre33b@hczasmdnwioh>
References: <20250922113026.3083103-1-apopple@nvidia.com>
 <20250922113026.3083103-9-apopple@nvidia.com>
 <38bbcbbb7bdf88f3a06ed9925d4fa058d6352d51.camel@nvidia.com>
 <be96c39c-4ac5-4a4c-b5fc-6b1c1026db30@nvidia.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be96c39c-4ac5-4a4c-b5fc-6b1c1026db30@nvidia.com>
X-ClientProxiedBy: SY5P282CA0192.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:249::18) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA0PR12MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: f73c1439-1e59-4e7b-3624-08ddfa5baa85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?mKCfyQpVOfa7/b4IFS43Ya2c6G2HwdEH4fbnpB+TXKeoyhPZDVEAs2p25q?=
 =?iso-8859-1?Q?dLWKvylcg8vwnPEB6NgX9zbK4azdzN2EknsgETJjfjrvNdt3gmkmRQcqIe?=
 =?iso-8859-1?Q?AY6pqnwYyHV+1G7yffap/V7FBSoS/LqVjyP+TjYMeXNc0bgenBcLM5KpPb?=
 =?iso-8859-1?Q?vHymWpCCxZFE3qS3Qn4huTIPgdnPX12DtUZ/J/qBW1LoYPAa9C5Sy+9FSL?=
 =?iso-8859-1?Q?26q2dG3wAU63VcXIoplH7PG6xks3SIBnuKrwovr74QOm5VGq8Zd1j92aJe?=
 =?iso-8859-1?Q?8ggMNQZVCqfsRLZx2+LUg4uUrzZP+PhlHq7ImHvjTM0a8Hfn79H+84cy6r?=
 =?iso-8859-1?Q?cdW8FKruNqlRoPVQfX8RxlqMNhPORmpqgBXQ3ddKMkY5Eucz+bCrpYo38B?=
 =?iso-8859-1?Q?hGZM/u+zuE1qryJcL2iSfPtCz+PTO/ga4UrPP2PUWJol57Ks9wkvRfeHAv?=
 =?iso-8859-1?Q?qGEieXtjXa3lTPECftkdTz9vwuaOt3jjgykjG2DWRQRTdnB2I5ZH8z3jHy?=
 =?iso-8859-1?Q?9zdOHq9Uizl40XYrsliQz3JQhegpt7Q/nf6psNuC7xzqDLNkUj2ZLsl27P?=
 =?iso-8859-1?Q?6LzCbftUN/7BauF0BcKN51Dn/E2Djn1zueZkXRuZX0BtABou1NBO76CNqm?=
 =?iso-8859-1?Q?rBQb0ix5n7+4mNNebvEL5KDGhgNB55lNH9VhlmSpvwGzb4Wh/m03fEa2yx?=
 =?iso-8859-1?Q?4M+L1Eui4PSFsBqTSa3CgcYtNporOtbSFyc2LQ+0eNBEMyChXvBA2jWyzJ?=
 =?iso-8859-1?Q?jFs+/2AiNj4CnPi5m6m4BpDDJWlnGM6TSA271mx+QbPcUvEuxqDpcibO9S?=
 =?iso-8859-1?Q?Mpnwtpm9lJf7dJgZxV/VFAgIWeS9CujdFMMe+S9tmz90GRoTwmcfZo3gn8?=
 =?iso-8859-1?Q?GSbabIcrBdme9dNaihOtXGFdWWUyT1GtbJ63UB+mZAjAd6a/vGKx3JwVM9?=
 =?iso-8859-1?Q?1hRvCjRgYEDNLoK7SW4Z0nbZDfJGhY4J9THGUiQuDeMh/O1x1e2Ay5uA5j?=
 =?iso-8859-1?Q?0MAk8DjJwc2YuTayFBXSOgpscmgLJbQgNBwhDm5P+ojeZa0bYeIiD1hHq7?=
 =?iso-8859-1?Q?gLQyypuiGErJ2A1NskXKIaCjU9dPZE85NlvY0gDo4dlZKyHeUXRUiDV6Kf?=
 =?iso-8859-1?Q?EiPjWREL5ilpsxLCU4NUcb30xkvOd5jWCS/OPRPSA48s0ZGgoxYU+veXtl?=
 =?iso-8859-1?Q?0fQw5+Kr9tPgrqLVYSnvJbLn3tm64k9X1/+Tv11tqUtSHr2OdiA6rKlKc9?=
 =?iso-8859-1?Q?8+w2XO9B8OTJU056u2tXrHSMB+mmKxAL8g6da8+zgA4+oGayZ+XvHqGCb0?=
 =?iso-8859-1?Q?E9MInjpSwAQvtYh/0iiB0McgO8oUkmL+ESLl6QkAccVxeGAdnfldJZ/qCG?=
 =?iso-8859-1?Q?i/+kLAQdEll3svYN4HVi6uqTEjEHBQhWXhzQ2uYOLwWBU6PedRTxXvfRZD?=
 =?iso-8859-1?Q?83ALRyCYk731O4a5LSpjyP3jJg/EXAif/P/+m1lcExWWuB0Hbp3oOD+SkT?=
 =?iso-8859-1?Q?g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?4P5l/VFtgxdoLOmdnrHmYjGvQeIEpYjyxZtVAmK76FAdo4fbKJkGBCpDaX?=
 =?iso-8859-1?Q?2u0+AkaJRll0k24KLoCBqxjI0z12rTByVLkGPBJQ523K6qNfA0RcTT1vrI?=
 =?iso-8859-1?Q?ZOG9n57Sz79PpGV2VKl9xgjDMNmVHiEWrk15vB9z+Xqi05BVYEpyu+cpTr?=
 =?iso-8859-1?Q?BmaiUpT7mOlLO7rRjBVR41wqxpxGq4J9ADEEOZGUSVhe3r+uEnn+M3H3ey?=
 =?iso-8859-1?Q?EVJhm+/b17Az8MkpO5NSIEVbj2yXArLTHYPMBzpTykuKlzZZQrCirYlnVo?=
 =?iso-8859-1?Q?H0ASmhjt1F4DJAJJ4rbdoJ7yTfeamGkZv0bW4FiZFFZERxJyb5Y1pSD+u+?=
 =?iso-8859-1?Q?bfhJGhBtzNtgOhySTjN8dxSi7I6eiWELD7kxZVm4zZPANrazyfcYG/0+5d?=
 =?iso-8859-1?Q?sNYXLC1CZogp+i1NbNNl1gfYq+jYSPfO43ioxBVAH2Qzakm3/Y8oZSSpgS?=
 =?iso-8859-1?Q?gdNJRak6+borqsIFyNdYxofNMhmCRb9agmxswhpGW+JWHzCOjLQlIKFB60?=
 =?iso-8859-1?Q?nV/Gz5o6WXe4SHwveCyFnjmk4WvdPbfP3hYyprDnBPWrLBkAbI4ZqujgR6?=
 =?iso-8859-1?Q?g7giggrZfRmSZlwGil1yGY8Od/lk9WlOOIbvTYNldXncB3iNiJqzYYmsS1?=
 =?iso-8859-1?Q?mczgBlMZTB/X6ZoubhIbZXP3C3Fss72XusuR61S6HVyScrvmxkThOJE28b?=
 =?iso-8859-1?Q?+aUG5DGkD5+FtyBwDQSqgOP2/+LSm1n/xX1RJSzC1wuwL9XmthE4ou9GQn?=
 =?iso-8859-1?Q?oFV+hrYXZZIH3xVAzAoIUyMHkLYC5d6dgOr3LwcCLkN5XCgSWL4p+as9eZ?=
 =?iso-8859-1?Q?5QTfGxDZ9tRO/jStqIWdGlrXk3tp//W3bvHeFBcxr5apww79nKvQAcb2UU?=
 =?iso-8859-1?Q?V32MqAwk0L/pwmvkfXPnqvygoihsheuaJgd49rAzSg8rlEii/QWoHy9W1M?=
 =?iso-8859-1?Q?QSJeFL9mRdilmRtnV7PrEX3gQTzsQzoVQPPRxb0Wh3KxrryReu57GIFhpB?=
 =?iso-8859-1?Q?icdpcoaOiTZPRGFWzzIr+W/lpsxrkNAJARJGOBqtLkNkZk5eM5fOpeNPVS?=
 =?iso-8859-1?Q?Td+ceC9XKuaN1nwGWp8tdlbJ/4NLJEZuwbJbqTcxdQfh21nG6orhZlbbeA?=
 =?iso-8859-1?Q?49jh+KOxk8H7pqx+V2XCqEttjv7vlg7y0VWhg0+tMFmayidp7bJa7sGUAp?=
 =?iso-8859-1?Q?7EcZftXdkjdwejyHxZ9UwRoN3rwFbRezNwLmLywSscfUt0J346T0o8D1pv?=
 =?iso-8859-1?Q?IIe0RJOP9mUv7jVyjqO4S8QM58/yXkDUGkFk0j6mk+aB7mtIRBhGcvfOWJ?=
 =?iso-8859-1?Q?ed6iD1qLdxGZtw7P5VnH0KQwqZ3KilkljsGecTS2z8hcC46sqfKgJPdfuJ?=
 =?iso-8859-1?Q?jDBCyRWL+ks5mB3pvbozhfpN0gCUO1S22ZLtYNuQBbOm10B/fOytvNvhR3?=
 =?iso-8859-1?Q?uMNw7Orsm2ypfkECQ4QxPuyN1w1VCUYOmRxeynqg8o0270KMODBgDDyy8E?=
 =?iso-8859-1?Q?RbdY5s8pwuv6jv08g/cBOqaapb2qeCUbtscwCeqjoTrYNw4LqirV10KMQc?=
 =?iso-8859-1?Q?lyukj+T2LSfj6IiTJqrTG4Z9EaiLkNMfJqiDtW7DsXJzURwdae8rKxW3Pd?=
 =?iso-8859-1?Q?r6PvDTSVT7gJbAHe+ybU8XoUtK/3jIlSRN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f73c1439-1e59-4e7b-3624-08ddfa5baa85
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 04:42:56.7467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjBfinZimSRSjJ3vI/jlPqoD47EYpTdmciDmQRwxeX3+6LF24GWjlUwqjAFbq3+8Oeopv87rTaITWZSYkjkGyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8747

On 2025-09-23 at 11:07 +1000, John Hubbard <jhubbard@nvidia.com> wrote...
> On 9/22/25 12:12 PM, Timur Tabi wrote:
> > On Mon, 2025-09-22 at 21:30 +1000, Alistair Popple wrote:
> >> +
> >> +    /// Check if the RISC-V core is active.
> >> +    ///
> >> +    /// Returns `true` if the RISC-V core is active, `false` otherwise.
> >> +    #[expect(unused)]
> >> +    pub(crate) fn is_riscv_active(&self, bar: &Bar0) -> Result<bool> {
> >> +        let cpuctl = regs::NV_PRISCV_RISCV_CPUCTL::read(bar, &E::ID);
> >> +        Ok(cpuctl.active_stat())
> >> +    }
> > 
> > This should be part of the HAL, because a different register is used on Turing.
> > 
> > You can leave it here if you want, and I'll move into a HAL when I post Turing support.  Your
> > choice.
> 
> Yes, it's similar to the DMA mask patch in that regard (Hopper/Blackwell needs
> a different value).
> 
> In the spirit of the current "soul" of patchsets, which is "get
> GPU firmware running on Ampere/Ada"), I think let's defer the HALs
> until the first patchset that needs them.

Agreed, lets fix that when we add/need the HALs as that's outside the scope of
what this patch series is trying to achieve.

> thanks,
> -- 
> John Hubbard
> 

