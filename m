Return-Path: <linux-kernel+bounces-743083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2354B0FA4F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4CE1C88172
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3391F2382;
	Wed, 23 Jul 2025 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="STBxx0QK"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FAE82C60
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753295681; cv=fail; b=Ekbvl85t7FOBVI7BSqvS7DSjpPLqNIuazKMDH9lbCvkBlBlQk6C/Jfxn2LmOvlqwdwnx3mE+tlhGqZygpKvOlMKO2S+eoS+jwcASlCCqTBLSBzngHIaMUdD8YcuHueEcCPvlTzTe5uYLde4ptI6w/Uphmx1rve/obzWv0dS+RFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753295681; c=relaxed/simple;
	bh=ioOiJMrjdh/aWhBqthXaoxXjG4Gw9cOWWzyihLTEcPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mVItCgSBQC9Rd1cle+XeIePXkqss7LWTajutsr5nVokEiEZ15Ot8xQzBfUFL5R7RpcQB5tkKTbqOBun0IM5L7iYUZUCO9M3T65WahokOMZ1ZX8lUF3MivrIq/KCzdeaJ4gXFa5F4kGHJfHEhBMSajdVE6I4YDbvzEZOVg0KQfEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=STBxx0QK; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8n7woyuZXhseLJ6H8XpNQyYzxxFObH0CLZz4DZdwgSxPL99sUaKYkC46GhFZ8yJs8UJGwmbYgdWcotEmM/CfbVDAoy/cMLeHnGPGZeauym6zV6+JVEujjYICV6lfh2iVwVRp91z5q8XTXciiVHrJjhpz5w1rSdGW8ap90yisZMEL7gzFS13j7cjSqn4Z+BQHnqNQidPTz0wfXkXGdJEoaqJe1jzaUQbN2AkyWhb3uSSt3sX7EXGKL1Wdj/7j2i8WIgL1m5pda7Bts0eTtgXR0MhMzliqmSJQ1zP4Fr1wunI3pzgwIGVhssiBbO3MIJiFi9ZgbKQv4ItYYlzrPBjTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seg8mGdC5YVMt10yN+dJ2ChTp/d1GR7v/mdlaK3r/gY=;
 b=lavnEBbBTX5Y7kS5egy5PTCR1zLzBRmXnjcduGErZyXhJ3kvRnU0zRKY2graXkI28lhKXk5JCR7hDX0i6Rd9uXIm97zEvoCId8GGeDrd+iJRne8Oh8+/Zgiqv3jy0jntVgkYOo6THIL2djAi5g3kxW1h7vpdXXURbV9OV7HJfLxFF7/65Z9WAMTrp7Bwr8fI+IvPzBVDRgR/yIArtHpU4Y471xXcp91ckzaN46jV3SaPE5dXim4vDhm/96qH3DCj5BVREix9hjnJZW0JmwtA6Zr47nqls+sinv+U3xSHzsN5ASyd+BHdT1Yqz8FB6l9qVdl2ah9fuX+eHC0hVNEuSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seg8mGdC5YVMt10yN+dJ2ChTp/d1GR7v/mdlaK3r/gY=;
 b=STBxx0QKvu5hZn69bRXxgxbYmeg1eE/dkji8MlXsP9amsqTVVSw0Sk0l/w3Ybnr1uxRoRO+B/CI5/R89NWdeldA2+yJfngtufVbdC5pWTbQrrKwalJvb9RmKoc5VNNCzRDmDam1aW5p7dkOyfIffcayyl8iatwdKa7/ktqEpbAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS7PR12MB5934.namprd12.prod.outlook.com (2603:10b6:8:7d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Wed, 23 Jul 2025 18:34:37 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 18:34:36 +0000
Date: Wed, 23 Jul 2025 14:34:26 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Libing He <libhe@redhat.com>, David Arcari <darcari@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] x86/CPU/AMD: Ignore invalid reset reason value
Message-ID: <20250723183426.GA1158000@yaz-khff2.amd.com>
References: <20250721181155.3536023-1-yazen.ghannam@amd.com>
 <20250722165615.GCaH_CryG7kNrAS4O6@renoirsky.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722165615.GCaH_CryG7kNrAS4O6@renoirsky.local>
X-ClientProxiedBy: BN1PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:408:e2::27) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS7PR12MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: 775fde5b-d4e4-45ac-59e5-08ddca179394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FTqIysW+RoPdMlX16gnTj5ntHBkgsSVIqzV/9CV+VxZXSWZy9opP5asF+XC7?=
 =?us-ascii?Q?8UQXwup/ymZv0BZ0Lgjn+eBXWK2m9ZxlHo6PDYBrOuTvZIGREFLK9xFsNYPE?=
 =?us-ascii?Q?95gWZiKZ7mKpgZNbcHch2cNrdEJwc2dVdhuqMBTwWjus3NSlTXz8zDCS19LE?=
 =?us-ascii?Q?EIoutYekaNeys+Z+Du072naOwrqcD6gh8RpWNpFA8Js9wuZGqAlQ9IAXGjk8?=
 =?us-ascii?Q?AQ6X9aF6yWu7bR0xQYkdBBLz9hL/W0qkaxIKk8O4BD/oNDEdcPCvaSQdzZ1p?=
 =?us-ascii?Q?Sq+zTHNtsTDfvApwWokLhR+cNaeSB1VCMH53x+wjvo1XCbRcwXCNfknaHZyi?=
 =?us-ascii?Q?WXTRhbOUnSISmHlAbGsnxTOcPt5X4lphkCTI6uG6O4+CamS9XmssaoDNiD1N?=
 =?us-ascii?Q?mAdb+5gyoyHgybQDknnULZX1euwk0AXIa1owdvdddaROlZ38j7SdZbfHxAXN?=
 =?us-ascii?Q?7jAXssJwgsjUv31ZH3CTxAx8AqSCf9/jfdVXg3bEF/FGnCVJxNhT/CXLKdLI?=
 =?us-ascii?Q?xSKWrbo06yL/3+owRCfJ5o8/eIyqxfAb5mX/IVOR2NkySFKzT5q2ynP/pNJ+?=
 =?us-ascii?Q?yKr/JhD9ZqtmGOkDCLAWO9r940UTHKypxHhe5qpRZQHyzwzytqVS8gRJSO0P?=
 =?us-ascii?Q?WzBM68MiTqz5dE2mnsMHKtYrHCnf4RUXmrZL4OPgBTA5hUUk8gjrN+09gXEm?=
 =?us-ascii?Q?hydLPrFTgaQL1pbQLV6bUWSf7APzEqb0MJV+ZvW2iOGkzCmhMky/Eaej8g4b?=
 =?us-ascii?Q?e/oAZ4Pyikurvo3AKkl3M8SwIyUONN6FsbdJm5mkDuxq5fQCAN5uF3rdlmNS?=
 =?us-ascii?Q?q7tJK6ZOK9U/YdsgsFkahACg0dsqVoPqW9z0dhJ+sYrcUaMIvgW4uLiwKDDi?=
 =?us-ascii?Q?KV/iRGif7qDDf2vaRBfzzUeZWI+PvOO5rVKlEAUjxWwZk04U/Ut1yt1B4e7y?=
 =?us-ascii?Q?kRR2tN1gnh+iFaOV5QTeRjld2YG022nyiyxqPI+erTGYtzlQnjzkJbUF6A8x?=
 =?us-ascii?Q?ZJqqsD1mqhqFubCtoZWwolcvWDfmSEy3Yjq++cSWkqPBH0Yus+zxCuyB1JxG?=
 =?us-ascii?Q?hlOiLpDQeA52lVRQQsDxDOCEYP4o252EtO1wou5bNWl+1FJDq6FscjbEmsBq?=
 =?us-ascii?Q?lWY+Ja7ElPh0mGLZrc16jh0TmZ4Thkyxup0tZ5m4JATOKuXmDYFZQVlaPMQQ?=
 =?us-ascii?Q?lUhRhnzNUQAVlzeVKYAUXIKlN74Kf9dX2Ut3Vo6wtW1cIQ5daVGgIyKuQKld?=
 =?us-ascii?Q?zJsWhf/l7LY1iAGsScwdm1VC6dBShIFGcOC4fHDh9SL+3YyVKK8rfsSQwD3P?=
 =?us-ascii?Q?KH99AJSrmw9CmcXzJE/pLe0QSfpk4jYs6VwywPmCojvPMupYNhT0eLLNs8Za?=
 =?us-ascii?Q?V6UBa2Lhi2FD1N4Q2orq8XKZinr09rGvdLcU0D1zbs/S58T+hTQGoe/8wSX7?=
 =?us-ascii?Q?hjaZrZEfLpE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?udqpGumafDcqNjTD3O2HxnFmugqCkBrVqBz4qLwmz/BnF34MiH964EH0Ihq7?=
 =?us-ascii?Q?Na+X32urjpsnBooHftaAPMCJXq0TvbrprICGnxqd91rjBE44M16hOfvqHLQn?=
 =?us-ascii?Q?EDFo9IsLik7z1ZdMYcPRvf2wv6fVn+dFmP7G6J623UX7HxaGjRZWW3fSgPo9?=
 =?us-ascii?Q?WjVk6vcqffFTnll9+pKxjdqAOrxpJ7eASckvEHj9wF3kBIQ7iYe8TczC6XvG?=
 =?us-ascii?Q?l0hZB4AkVAjYiWtk685x9cVITfxSA+AHWGaHS0CaYtpvbnz1I6fV9kIKL1pl?=
 =?us-ascii?Q?gWuXz9ANB26svfJ5ZDqYtvCnTWtMvINafDKn5KNMuUTczT+eyo2fNbzLevpc?=
 =?us-ascii?Q?JLWnW0kIGx9EemBDv/vBGNyzdYtJ9563exif2Y+kO5+0leeStaaKaNqzXHbv?=
 =?us-ascii?Q?3nle+mE1j5HY0cQ3GKSA9jm/nQiUuRwH5iyRViMPVmM59ap6lBx4JJzllg4G?=
 =?us-ascii?Q?t2leAvL8Y91oocRYaPwh0Q7yaGeDesyV0cGoAZ1QoRoTcYeMpHpppMSKlCls?=
 =?us-ascii?Q?LdN4ArnjBYgF9Xz8QN7v05SvdqIHMnSDJVmUkwgZzKU3uvfEnCuHJr/PAHZ2?=
 =?us-ascii?Q?pMKjBJskssYV3FeCImOXVpYChsdaDqSO9wnMRP8GeEcUDaf1wYlPcFlPGhi2?=
 =?us-ascii?Q?JX9p7CwxBGwTO5cvY4g54Z8E4WeECNvu0kdyB0PTF2XjkPCNbvEKouNxGzem?=
 =?us-ascii?Q?8H0sP062djUEWbCqYuwTIwyQDfOVU5ah0++AHZQ76z2ldvGs8ND+UzYFCqse?=
 =?us-ascii?Q?eCY4l+Pussn2MfqLS8WYLua5u1z0v+Bd6igEDHrdTwZPQ1TPgsc9YnLZOAHU?=
 =?us-ascii?Q?gWrgepNNzNlmHpaOg/NLi2Z2pQBf2pMha6YPpUQ1csa2eTIYnRW2ntjZX3y4?=
 =?us-ascii?Q?h3GSLOgi+Vvn3bt1UvBJm/QsxOyttnWzuTw6KYDzh2A5rQo6yKRTu7huuJ6j?=
 =?us-ascii?Q?6r0LX7WVFB0F9PT/JUdzvqUk7zSlYFev+XzasaPoPp0Fel5cUesrtbEMPARf?=
 =?us-ascii?Q?5S7CaJj2KIYtBWIH1F1+mEnWwM+KtsxXS8Ra7Lx6bhe0m/x0D3gf+HZeGWXZ?=
 =?us-ascii?Q?ufdNBnLAOWsD8tPStr7UZyLb+1ums7cHK4VTZn4X+Rfu7rRhym3fTGdbRkrG?=
 =?us-ascii?Q?4m3Wy1YNSaW4p3JdOBNcKQ938Jny1wVtfS7UtC+k9LEUDItiy4D3qlmNK1xl?=
 =?us-ascii?Q?PUDOQIYB+DxeaX6mLZ4WfXmYC6AjYprRNWHRqOJdsXC++/nLd6eRAOLXe8x2?=
 =?us-ascii?Q?qXn7EXJNe2qW6WpBjZDx4pE80/NlUvedTpPkQGjtchu7MBXE/9x5wj9TwTRl?=
 =?us-ascii?Q?ahMD83kFcEFDaMoXfrIaMOW7siMvxzQPEqT7bEk9qvd2Z5r7JAbDkB8iDQN+?=
 =?us-ascii?Q?XimbH26rbtA9CHJn3++ETtmoJXk/YbogNuM1WE5EqX2StaQu4b0i+RM1b73v?=
 =?us-ascii?Q?qzuFgHvw4vSNuZfy9S9HBFhwm+SSIhKiNESSy9OVf9KEoISxmv+R8T+0Llji?=
 =?us-ascii?Q?Me66xam0vrbtgYM8AnWuFQa8MvV1SCJE2p6d1c4lW9by9+f87QeeVAiO73Ug?=
 =?us-ascii?Q?NRIDQaEDBH6L6DpaXeFwDUWGLDMXdBWSNR6R6aGo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 775fde5b-d4e4-45ac-59e5-08ddca179394
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 18:34:36.8162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QiXZK7O2+IqobcZWbKnqbFEaOWti0uu64vdeiKviDf1aCgnfjLQeBz90xlBTsQGYP5iZPDI2XCoW8mBno0P9Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5934

On Tue, Jul 22, 2025 at 06:56:15PM +0200, Borislav Petkov wrote:
> On Mon, Jul 21, 2025 at 06:11:54PM +0000, Yazen Ghannam wrote:
> > The reset reason value may be "all bits set", e.g. 0xFFFFFFFF. This is a
> > commonly used error response from hardware. This may occur due to a real
> > hardware issue or when running in a VM.
> 
> Well, which is it Libing is reporting? VM or a real hw issue?
> 

In this case, it was a VM.

> If it is a VM, is that -1 the only thing a VMM returns when reading that
> MMIO address or can it be anything?
> 
> If latter, you need to check X86_FEATURE_HYPERVISOR.
> 
> Same for a real hw issue.
> 
> IOW, is -1 the *only* invalid data we can read here or are we playing
> whack-a-mole with it?
> 

I see you're point, but I don't think we can know for sure all possible
cases. There are some reserved bits that shouldn't be set. But these
definitions could change in the future.

And it'd be a pain to try and verify combinations of bits and configs.
Like can bit A and B be set together, or can bit C be set while running
in a VM, or can bit D ever be set on Model Z? 

The -1 (all bits set) is the only "applies to all cases" invalid data,
since this is a common hardware error response. So we can at least check
for this.

Thanks,
Yazen

