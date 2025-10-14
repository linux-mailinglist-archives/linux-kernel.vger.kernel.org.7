Return-Path: <linux-kernel+bounces-852542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30702BD94A8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D57A4E2BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA9631281C;
	Tue, 14 Oct 2025 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c8ewNr9F"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5E62DAFBF;
	Tue, 14 Oct 2025 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444054; cv=fail; b=GPAKxuCl4CqTnqorqzVVYTNgjqsMBtFarnWGXSa7XLCeB41FVVYxrHT3Kl2UU5ak4Vp8OGrVuUh1wqb1O94RsWK/rG1DHQHjkJLcln9JkS0eSXL98St+Gzf7SCxUMz2sdoFqnd4wawNr4EQ+xJASDEhhIALpUB8/Pf0f6EMKDms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444054; c=relaxed/simple;
	bh=pGiZ1qMdp7m36Fq3WUoR0zwTC17kYiWYa901uX5hbTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FAOMizopwUxEjyDTVWm3jDe+YUq0D8uYSgk9zekmKGj3MxDM2rTaaYT2Y1WJu1FkAa+0mSuH+BkDolN2igMzQcUtkULnnQsHryFStLDEb7eeD5PcbbRXJkca/YTmMYZsoIlUC5kE1Xj2Z+a1ZAsAmo3MfnqytfzBh9FCrhrvpEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c8ewNr9F; arc=fail smtp.client-ip=40.107.208.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hF8Pbx1rkCwjTdplBmY3vsTTHLcWKocShMNPSr/EyFtnyjuGZJIPjaKLCws8cGlAz9nrrBOA3S1ITHqf+vWk9af7H3dzAKOigniUoC62iqvljRrv9MG44t7FaM2V+jeJhw6tl0Ule4MaZ4tn+YsWAlrq6t3l7n/vtL8OBwSMuKZxBf5/RnyP2vGbWn3v/7KU4P6kF9/iFmXsQTrXiXVrsh7Vh5lYlnJuU0P4EIGpnwu1qeT+4M8vO90L2JHmve1WqvL9dpJiYd5+BOjIo7Q4mJkiIkyDdLL7bpEO9LR28Z/at4+emQB73ypLdo+eClwifSXeDsnkh9IGnbIPl5ZWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGiZ1qMdp7m36Fq3WUoR0zwTC17kYiWYa901uX5hbTs=;
 b=ytz+kAbczXdoO589JPZ9hC1Bzbyye1BOHdWtPgarP5sX3f0cCtcc8Kz4BKmiIjAl4mgVHa5l5/jhGEXVi5oSePUpLS6IybgLTeOhn4iLhWI4wy3BAx0tbfXJ/PuU/gnhhg9ScI/26EoH4sFHqN4GhaKSe+0VwMryoXhddp+JQAXZpE7K149PNZtX2JklesfNJ76tjucSc6V0/soUKPqT9hU/R8XlIwkBOAOWRgEI+ajuKST0dhYo3uVAxgZ240L9A/2cKR0QpJqkmZJkBXaonSgL8hgC0y/spunjXBli3b+sxCn0u3EHGLloH3lZshrQ+5CyjL3YDnIulK5WgF9kjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGiZ1qMdp7m36Fq3WUoR0zwTC17kYiWYa901uX5hbTs=;
 b=c8ewNr9FKoPs2YMpon+K31FVnnHEmdy3dmCUR6VRFsLRShLVy0bi9/00Y7COaTplBMoq/Yb8aTV028JuRUP8tJs6VK5o3Nze5LuR1/kO4/E6V8v66I33mYSSh76xHbh1G4M95SS/+TfWBIjtjaUOUwk8kbNd8gmFagVBHWAImx/aiNv/SOxHwSdlGNG46qs4aFAgtlwRlfIdZqrGFETOLhzwPI7hvGC1d/jt4eVUNHKzfcFHXn/bni5FKiPNqSGEEiuR2GMhrk9wkbNgOdLaGgGMHHMMnoiaS4V8hLv1bbTzu6eKTcFBP5A9/Ax8a63bySe5YfC6af50b/GMktagQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 12:14:04 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 12:14:04 +0000
Date: Tue, 14 Oct 2025 09:14:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: admin-guide: update tiny script for number of
 taint flags
Message-ID: <20251014121403.GX3901471@nvidia.com>
References: <20251014031538.764059-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014031538.764059-1-rdunlap@infradead.org>
X-ClientProxiedBy: YT3PR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::21) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS7PR12MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f7eadfb-bae4-45d4-3f55-08de0b1b2a93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+eXLwWB5Vu+wCanmINHoVlBcUjhatUm5KjvQRd16fpdhUNZMv4uQ9PLGbrw7?=
 =?us-ascii?Q?w7SG82Sh3CgrEQhhAdZuk6HKNwJn0HaxUeRFC8C5VfzZoa+dJUzII/my52s9?=
 =?us-ascii?Q?dFikZrihDgczUoWnhqv+vgaJcP1KDqCzWwfAyBVA2DnNgyyqh0+Jd69GyjKh?=
 =?us-ascii?Q?vtQ0xrAVRdusocKFNwEeTnlennsi93/fRF2vGRy6U0TdrFklpKb3xVj9bO/s?=
 =?us-ascii?Q?sg3iqsWBrWavXZrRqr1+JLPXDRIONuCsh24xdvNy5EztwFww4cP7rPlfYRh3?=
 =?us-ascii?Q?mz3MCeHJqePndymCfUFKiRjOImJxO+TLIi9UKdNQTP51WSXrErcgZz47VzqY?=
 =?us-ascii?Q?VMp6quYdXMMIF6Fc9zQ1LHzJYBExKG5eo/HZAvPqAKpEEr3lkAB88FCXS2Zx?=
 =?us-ascii?Q?aMxCdfY0BhvdT+qsJW7jn6OeM1bjZ0RVGiXSpceG7WRaq3ixRH7m2ni1xi/S?=
 =?us-ascii?Q?k/lY11kV+CJuxa7YYkQ74sequVJSXMU2wPCfAf4cNhaf2bAyXs5ElQTWgLTW?=
 =?us-ascii?Q?dAR6P+rAAO7EzK2lOdd4cbSPJhvl89wwm9GphZv54YuiNuLYGT9gvjBgrj6e?=
 =?us-ascii?Q?1I+BMEFVna7OBF9jpEipu3YqrAWrMcFXE9IwJsN1E4TynwbwTOKvCrQ5uU1u?=
 =?us-ascii?Q?uEPonVyJf7xZW4EOp+aIzCf83plWke7i7TVVOTxJ2k9X5ruOFPRPnl0Wr1P9?=
 =?us-ascii?Q?agITlSVMjZ8gEYrBViL8XN2jgN+Y8XmMUjZM68r9CkkdwXIsSDWwn+SXgN8n?=
 =?us-ascii?Q?CmhWSHOiV9fwyWOj+6VKPFo5PiCeO1yCA17PNWNsdcbmBb1gKw2086CCDuhp?=
 =?us-ascii?Q?jmB+79RdMyp2bQeDayNc4RLsNy7iD/RfNi42iVJs7LwXUE0BZI5/Zw3+NgIM?=
 =?us-ascii?Q?lpSBh0OCu1vwPFveqccjxpDxn7V6OpzQFbYDKLcw0J+jRPGsZIh04UDxVpMn?=
 =?us-ascii?Q?fAHP1D5OCSw8grvAvg+DsmdC7dOwuquPEfJhNbAIRN0LnohchtEe17nCeUJ1?=
 =?us-ascii?Q?rmgvSHSXTaD2kwdhk6LmsmP61gOV9sQmuZcSuJbHH41ftgme+OnLmThpGawd?=
 =?us-ascii?Q?yUNurXnby3qgkQumm4WNBDV3juAWJx+2cOVpiTq7tLbMjqH4VB0+LXKKIOO0?=
 =?us-ascii?Q?9umeQVM1Qema0UwMaOJPL8MAQS57oqoF8vj5YgKoYYH3VlR9kOztusFYGgGh?=
 =?us-ascii?Q?IJSkUBu5vC+3ol3Kgur0pnFtsTQ+vhB5VcdOcfwt9j/nWxckYd1MimQyq/1K?=
 =?us-ascii?Q?jVvpiw5Zey+axWwE3hvIz4FuPvCBfKOqIjYt8UNpIam9xC9krqlUUHc5SXkk?=
 =?us-ascii?Q?fv61UStlIM9czCb3EZ7dY70F+sc4dQp27H66YGjmDHwlkNC8JItsHkQSRDeM?=
 =?us-ascii?Q?pMkvYxwuqQkbX/TKlekpN3bQkavSGJHZNcnLBomEFvmjcQKDE/yTUVRNbtPL?=
 =?us-ascii?Q?+Jogl5Qhupdu1Q4AqbA6U667FXxLsG/P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zv94JbdXN0RN3BAfpyccC8a1TImt56lFkZiA6HfL5Xj2Aajf4tWHHUmtoXM4?=
 =?us-ascii?Q?ILtvLQLbF3e5gMCRhV+D/qMkdErtkC7VtXUI4jqLpAl5oroids3IoULInqBk?=
 =?us-ascii?Q?dpQjuC/T/jqu43L4TtiujjS53kJd6jV43PWo2u8PRLCx46+cW0vcTqguI0Rs?=
 =?us-ascii?Q?wXYM1kpTYmSTyDwlpQr7bgVzVbM+IG1BXHj5FR1Tk86s3zypZSHMJreQaYs0?=
 =?us-ascii?Q?fv8yYwjS4/uxqvWfbmlpN+IOa8X923oPiPaUV09KivO1XCgymCObhvbro+Cj?=
 =?us-ascii?Q?tOAPuARLVHpueZYrQ2V/Guat1a2BSPZYQuOXnf9u5aH+F2ONyIm4ZBNlo0uT?=
 =?us-ascii?Q?Cqpz+9M9UXdJ5OCsc/ztilFMj1U7lQ9G5fsMlI9TqVq+bbisghmtVQJ0VD1H?=
 =?us-ascii?Q?k+VEtvsbWvn7DN4/B4Q3rJ7REZPac/XejVNJt4Y/AD6u0Jl9WK6BIRRUjF3N?=
 =?us-ascii?Q?Sqz+hGdHzXOhquZO1U92fOj1n125qNi9Mte/PsVONPBkRzI0eZ6C7JV57J9A?=
 =?us-ascii?Q?RWbmeglaFPlxvyI+TCdXA9zshdl6KcVUK4vug8rgufiohxfloqKlLoqVxDEg?=
 =?us-ascii?Q?JXs6lZvY4iHnL4vfZs9MToLwwsswS2RHzNnuNt5UwVqi9olfx9IM/2Ott26C?=
 =?us-ascii?Q?5ZIzi/KFHO+LT1r8R2ka42SA6hlyXEm/dwby/DmYuOQa0X50cR7WHEJtg4Dg?=
 =?us-ascii?Q?XlJtJSz2Tn34BTf4zlLT39liwEOcFrS5///zR5HSyy6WPuqbLk+JOsg8kepQ?=
 =?us-ascii?Q?Nb5XcbxnwYl6xMeSR2JtkkqJb41lgL+kRbvBK4o98TtkBwlEyH9A5vABkuEQ?=
 =?us-ascii?Q?Bn5UiRzzp3xeoajolnxyrZMLOZBOlE0WC9P1qMAR34j0vrI/+vI3AkxVp7ig?=
 =?us-ascii?Q?P9+qCHZg8aABlPieRxeFhcbRMaAcUbA/4kB/7rD/GIoV54Kla+ZygFhxWm2m?=
 =?us-ascii?Q?tdn/HDKQPH0YQKPw9yWhHiUKT2IE6bY+MBB0+7GjmqnDN5d55vFSSjDm2Nmm?=
 =?us-ascii?Q?BSdec18TzuYueEpfzbUjn38YOGtMNCkJ0T2G74uPUSCmTqZaT9nY8+b3GbsK?=
 =?us-ascii?Q?QBKidS06DdopMHJdlG+kfF0UCpL3Ofq5mrYhB3Rwxm4GBtJ8qenjWNzL3jcY?=
 =?us-ascii?Q?mWBZLpDpoepl5P6GNBZ3tGFjEvIONAoHIQHL82Q2cca2RqKxG5y6s3/s5HnY?=
 =?us-ascii?Q?UxaRVAsZDdg+n5p5GsPPtZifwVUrRXS7eAKLIXwSzQGtqKjOKbq5rZgBhvnE?=
 =?us-ascii?Q?9yxyc4BFMZGwqB/X3PFKBZU/GtTamcCkfrjGqXtLAdgI9fkoOzuJNlN2DeCL?=
 =?us-ascii?Q?MGIODHVr5t4ian5iI4/DgYS3xRRdUsHdZqbWCjJ1tqffmvabbXpd49/DJccL?=
 =?us-ascii?Q?q8MDYgF/YW5HWOn9a4gHIH2vrJVvPZ1vx6ip96BYo0t8GU11qWLiQpvFp0Br?=
 =?us-ascii?Q?F/R+jiRWjo9c0C/j537FFL8GNjHR+owc2mfhsBbc76h13otISAvu2Bm6RT/b?=
 =?us-ascii?Q?AtAeFAILgTapBsIuZXPO1HyMySNzBI5wwXcpILLM7nV24W/DsTnTVhg4XVOd?=
 =?us-ascii?Q?qitgLLFjf3uOdxV7fKg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7eadfb-bae4-45d4-3f55-08de0b1b2a93
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 12:14:04.1412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qg7XpzPJJ9Sp5IlHMUIZ2QYYKCczEnkeiJ1H8uctEjBS/dS+bDWK+jfkPPqg2DM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095

On Mon, Oct 13, 2025 at 08:15:38PM -0700, Randy Dunlap wrote:
> Account for 2 new taint flags being added by increasing the number of
> bits handled by the tiny show-tainted-flags example script.

Maybe add a comment near the array about this :\

Jason

