Return-Path: <linux-kernel+bounces-868333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C944FC04F7D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76793A7CAC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EED02FD7D9;
	Fri, 24 Oct 2025 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b="JVSpUZm/"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023098.outbound.protection.outlook.com [52.101.72.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649372FB092
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292962; cv=fail; b=ndl4V4T45KvGsKmQuEFQnp9a1raNTfRATuQeoj9kUGpZ+aFcn1/OlOR2XqnZ2HzJhFUvEEXtrZqoY8OR4akD96gqFdVQKMjfecOF4WbuFfxXR9uOglvsRIsfzVhe5q3mtDEfZpIZ1WSQAA+1CuXewHHfAkLmw7C0kFggYBI5F2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292962; c=relaxed/simple;
	bh=TgtvTE3LQIvdoLMiblvzyNG9gaDynvYSswf58bhaYq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sL5uO5JBt6zUXDx9jlSwLZdKf15UmFZewMvbMrG3MP3vmpo8voeiBTroMmyILmocmuvu1KGVg0GHiinMYp4b/knAZlJ/Hho44oVHzTuzqVDIDznLPo1DrOHKg2F7ktDI/g8OhaUQYideV56kz+f6USTQyBh8ZMKv7g7b7vqTYuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it; spf=pass smtp.mailfrom=santannapisa.it; dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b=JVSpUZm/; arc=fail smtp.client-ip=52.101.72.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=santannapisa.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPtJLyYJYyC1SsXmuT3Vswv8l1WieeaQx2sfG647VaFGfcSSz4BzCwm2tPvsC811cxajQ1nCvW3dpTQWuRQLlNMgLR8hhHmBXK0wUj2OcLuKdpPdhGJP9EDpsvq1lAJNvmvXocQqNAoZmpnar9VFYyEgGcKOlTh0srOHOw/Y85HCgS9AqZGBCLP6uYECO6H79Jmo7IOVADiVhpy8kI4TjD+noHVZt2R2yMhASBcfvTTtk/MFIvI9SjnFYNMQTSVPp05PSAkPd4nICv4lGJW9xqrZ+i/BlHidbHBje2e2DVgg+i4AX3BohTqcb80qGGsbcyZjD1Ypzl9Xa8/zu8iWWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGX23FcA0GHMRJWk4C13az1kY2o6af8sR4vEYxjofvY=;
 b=IPfgxk3xyBN+PoqqsInWYhYHZ6ZgYuXZuq6nYBUEt87YVODcAk4WNNB3xh/hl2qWMvrQ7df8RYUG9A77ZRcWgwFbBwffiNm4qGe+ZxA8RmqX6XL6xtri/dl/dbb6filYsUmxh4yy8JaXGgeOkbdZI8qpQ3SKnXRHniFMjdzn8cOT+NqOCkeBRJdpzu5ejMznT+gaBlyK07pg1cGH4ADP3L2ynyPtXBhiy4yCMDGMDcbz7MzrLIYp418gNKeYgYOgAG+sq5r1HinX9BB+VvtvRu50sMgmSbLUcSsfEl6lA23MfP4C5VwkDGFZn6vYrsgTmOPfCUoCrS5MxHYvZEzlYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGX23FcA0GHMRJWk4C13az1kY2o6af8sR4vEYxjofvY=;
 b=JVSpUZm/OkMqjcvB860UMk/TyUBZuZTvt/wBE6+XBwbooBT8eEaQdwqkoz1rqNXmKalg7BA6oIJ9MzFmMVD9qKt+e+RGUpwyfxUJWWss+1unHGzmQO9HGP2YnpaWQ4hHH5WcvNxfeZN1AFKsjJa4L3ouovuhCnA51IbKNQd4Y1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from PAVPR03MB8969.eurprd03.prod.outlook.com (2603:10a6:102:32e::7)
 by AS8PR03MB10149.eurprd03.prod.outlook.com (2603:10a6:20b:630::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Fri, 24 Oct
 2025 08:02:31 +0000
Received: from PAVPR03MB8969.eurprd03.prod.outlook.com
 ([fe80::6bbe:2e22:5b77:7235]) by PAVPR03MB8969.eurprd03.prod.outlook.com
 ([fe80::6bbe:2e22:5b77:7235%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 08:02:31 +0000
Date: Fri, 24 Oct 2025 10:02:27 +0200
From: luca abeni <luca.abeni@santannapisa.it>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Yuri Andriaccio <yurand2000@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Yuri Andriaccio
 <yuri.andriaccio@santannapisa.it>
Subject: Re: [RFC PATCH v3 00/24] Hierarchical Constant Bandwidth Server
Message-ID: <20251024100227.6ab1bfde@luca64>
In-Reply-To: <aPYDhjqe99F91FTW@jlelli-thinkpadt14gen4.remote.csb>
References: <20250929092221.10947-1-yurand2000@gmail.com>
	<aN4_KE-5kOCbpQux@jlelli-thinkpadt14gen4.remote.csb>
	<aPYDhjqe99F91FTW@jlelli-thinkpadt14gen4.remote.csb>
Organization: Scuola Superiore S. Anna
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0080.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::10) To PAVPR03MB8969.eurprd03.prod.outlook.com
 (2603:10a6:102:32e::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR03MB8969:EE_|AS8PR03MB10149:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0b1f89-7d3a-4d20-0c2f-08de12d3ae76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TeCyPkT+QSeAMPqDxA3d99RRPsNvX47c43Bj5rMMxi5j2u++CleTn41Vza1E?=
 =?us-ascii?Q?AHWLyUtVEjTFCpePIrUQBlvCAjfLgnrckoOx4kfmlP2hlvR2TwAHSjrGgJWG?=
 =?us-ascii?Q?b+NOuvjdgRwm20/Z6j1+8lcemeC8nb3I9eQu7hmb6oZTk+yvVMRGtoG4lhlA?=
 =?us-ascii?Q?GVPv1b6bI+MaOdJ6cMc3blqEm+wfa0GN5yp42Yg4wA7ZAKXUi1aSPCb6mUzI?=
 =?us-ascii?Q?mOqG9XC7aXNjGcEVR87I6QGBZ2HrgTrgp9VInrMo/ppI0ZxwkbP34ZMkVor7?=
 =?us-ascii?Q?Znamxp5nXIVsPdAiXEk8s1yfJYzV2/pLaMuJzOIgOUi3rU92v+MkZ1ofGqab?=
 =?us-ascii?Q?Vb/Mxm9xJL+8iinF1ICYOqGt2yiMmLQ0p0A4AlMHneA+iz5zI5CTpluOC/g3?=
 =?us-ascii?Q?TPZRgdWjoX2xYRI+/PYYwYi0spVFHXxzjICjltzOGQNr8G59h9kGv8VfM6GP?=
 =?us-ascii?Q?a80QqNiRNk8tMIhViDKRYaqsayuIXCxdhK9ufBwzdgJ0dfFE88wXqOlkgKKY?=
 =?us-ascii?Q?PYdLEBj2rDw0ADvEHeR2rsOS6Z+yj5j3W/Et5XIPlLCpHaC6OfqAJrvWZ+vu?=
 =?us-ascii?Q?ps7s0AeZpsLTyPkMh/fQ59FACITIjDRCCHyHhqv3dT7frDWlSuDedtFvTOrs?=
 =?us-ascii?Q?C54ALpk5I8HbM/6aKOnwutVz4Bj+jr3whByLNJAJIq3JKb4+Io0Q8gOkUrfh?=
 =?us-ascii?Q?8hjE/iFo4Q9mrAFBJt4kSQrhr8+Qw6dX2ik9IU0n7ktMouTKbRzfNLTazHEs?=
 =?us-ascii?Q?s1u+L6OkfCBiumR9exQZQ7+i5kOAcPPqJ4gqriRSGW49tZD3p0SFg2rdp0OS?=
 =?us-ascii?Q?ZN1m1ohsoVCKAj6DklB7vA0PcXrqJrVuYq1Z2DtnIvV1T+yWParNAOxzBhhl?=
 =?us-ascii?Q?KhWG/xpkYK7l4TuknAz4NoaLGML6MS/tPWNDJtaoxL/1VRC2ZsxUdXHRf7FH?=
 =?us-ascii?Q?ZfF6fAw31KVW1+NdkAOJEdaXnra+ldaW2kwm7XyL//p0V7noP18WKcojg7jb?=
 =?us-ascii?Q?YL/QKpj1xeWkAjyP2m9knMsbmiEmH70AW9uW5vgDDMlBOJKzfugnwjVt5LAI?=
 =?us-ascii?Q?fjtzJ7PsmoKWrB2aP1E7gWrGpdYcXGWoGABCDg0niJxm+klQWuI7B5dHymLh?=
 =?us-ascii?Q?RkBDyfw2r1mujhB62KxTcwE93uk95RE8Be8X4FIbTL/ihXjNETnpOoC3dnSs?=
 =?us-ascii?Q?BH9nYuQvqsUuomqTXLTlK4Jlgv+0E2g2NAHD5k8uztbynNto+wceu5X4ZwUG?=
 =?us-ascii?Q?FOXU1Ikkv3//eD/GdIHf7x+LTD9V8i0h20eJbi4xbr3kHbeaxm/CL+11AZ6W?=
 =?us-ascii?Q?uOII0UQWa8W3ByE0PBrdtq7gEI537rsow1eY6OnVLb1emg+QjKs9WvOt6TH2?=
 =?us-ascii?Q?w9783fj9z7xjbJFyn+zzcWuNXV32GKRlJBpD20PGPQOzxYVo+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB8969.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Abf3ORcMIyGaPd9j65/rhkXa9Vrv6skM5LRoJxuY+z+16U9Th+PTAH47WHe?=
 =?us-ascii?Q?f+ZcQPli/+YOL9yJQu4nvFgmxMRYzM8R7d6D5mGeGiZNFpTTfplK+dojGO22?=
 =?us-ascii?Q?GDgkPkxMGO0veSS5a8oRAtl3vMs3uV3dL1BBAjj9eyQ00ZeX7eS2Mzoh4E9c?=
 =?us-ascii?Q?eS+FNkNaHtsGwR9l0S58jstLlHuIVJKLdAvfZ027BvxEHOsLajOZh/6Zod0D?=
 =?us-ascii?Q?JAAjHqQZaqx6P7dwM2FWgx83ZHMCDkr9L/RvAMCH/m1OYpOfC6lxmDIDFlwT?=
 =?us-ascii?Q?0L9QM71ifK0tFBok+4OjntU0a+E6YQ5mfjFzKNFfHjcNKWCalH9SrBGD4km/?=
 =?us-ascii?Q?/xlTMAzcbS4aevVmkBglNaMu5cxamikvqvLccGijM/TWSNTVkdDkdkK6tQ+E?=
 =?us-ascii?Q?ADYZYhFWywzoxxV9Tlcqi/SebVDXEcyGH31bDH/Z8CaHcSupL1nvMrA393RP?=
 =?us-ascii?Q?w2eavnj0wEdv0/qe3gJymi1OufXOvtqvaliwmP5OT+KUhY96WWJmf0221gKr?=
 =?us-ascii?Q?IweYjOEiFkn3aJivohY7Ym1C8UYHoEk7AM7AODMmKHRtW5TsYCrAzyM22Q1Y?=
 =?us-ascii?Q?aHeeZ5dgX5ihA5QTpMp7dQfS9iiEbb00nHLSAkRjRMsMqj4SsGozUUSWaPi3?=
 =?us-ascii?Q?14cKSF22WNNqPKcAp+qDrfFoIpvFhaVHfxKoStgsoT3k47OmnHBTZnRDkyg8?=
 =?us-ascii?Q?aWJtXEoumKxltE6eUNuOLgxIamGtWAbam/DPypTqOIf2mzUSg0xYaAwYTEp6?=
 =?us-ascii?Q?zGXKjtglnQSRVnTs1mpeIWqKjtN6rgXtBhybbHZez7KuBWfoDgeFK8Ax+8Sp?=
 =?us-ascii?Q?rRcvx+pJ5M9nrvt2/GpsJ1fdQjYauIJBHIys6WNacel+rX1rLX5XM7hUfp8/?=
 =?us-ascii?Q?sSyk7xtF/PVJQrLOzAK9fLOUnbBWFd5fP//Gg+FVJ6YwA36j+wjPLY1ONYac?=
 =?us-ascii?Q?lfso4jL8fQLyoRmzKhyoex+21q9CZkg6bRp8eX9tqk/gW5aoIPVhckoZ+G+W?=
 =?us-ascii?Q?QSaII6wgwm9K0G2XpHSWuqHB8zrHvJgUjB8VFTJT3DR5CFD1oUbr+69qYxEp?=
 =?us-ascii?Q?IYiawrpat9klnVOcGDnEQzCXmGM+TClCi1Uz6X/h8yU59WOs3ERuRl1Ez0G9?=
 =?us-ascii?Q?kGWXrHPdB1H313fDIKuOFcK1jBtrm7BcPi/JX2cPxfOaiAtoikSE6Go27zUq?=
 =?us-ascii?Q?1pTB5iqWIFYVokY8pA1ZYW4/MO29ikeUJTz6kA1wjVzNpi4oFbc/pT+NGY4w?=
 =?us-ascii?Q?f7V1dkHwLEadlsuVcYaffrqM/tDth+d7aAhXdhFtilleL0d6niXX0dgpcYUC?=
 =?us-ascii?Q?nsPvKNs7BbA6deCYEJY3qkdWfd3bw+24HkBDC/CSAyHSaL7g5yMxKYvH0soH?=
 =?us-ascii?Q?eIFB74/PryIVbK+/D4NCqUbRu1L2VI6XWese19s8JHaWwTpOdMJwb1/5UoWr?=
 =?us-ascii?Q?XLEBxsZlQVUnfvB3LXNHERJs/pMzlBZKqByKYVCzSHIA34t+TH+zUgSwk6XB?=
 =?us-ascii?Q?drku9XR8LYH4mxKhYTCneuH3Uftu1OUzU99aRwvWM0TD3eZsWuNVCUDHn9O6?=
 =?us-ascii?Q?BN3IjlL9j36gxOkzBmDsrpv0Crt8CDS9CcSZu+JLZhZUR6jZWWSwryf8Emh7?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0b1f89-7d3a-4d20-0c2f-08de12d3ae76
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8969.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 08:02:30.9527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtL6/ul/aTb2zEXY6vsGcGkFlQ9fzJkw9k0ld7jY7XmudusNmjK8k1j4EhJnG4GLvlEU3oP8sTcfw7lzCgbKkIctyBuim54fEzw3jocwygY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB10149

Hi Juri,

On Mon, 20 Oct 2025 11:40:22 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:
[...]
> > > - The first patch which removed fair-servers' bandwidth
> > > accounting has been removed, as it was deemed wrong. You can find
> > > the last version of this removed patch, just for history reasons,
> > > here:
> > > https://lore.kernel.org/all/20250903114448.664452-1-yurand2000@gmail.com/
> > >  
> > 
> > Peter wasn't indeed happy with that patch, but I am not sure we
> > finished that discussion. Both myself and Luca had further
> > objections to what Peter said, but not further replies after (which
> > can very well be a sign that he is still adamnt in saying no go
> > away :). Peter?
> > 
> > https://lore.kernel.org/lkml/aLk9BNnFYZ3bhVAE@jlelli-thinkpadt14gen4.remote.csb/
> > https://lore.kernel.org/lkml/20250904091217.78de3dde@luca64/  
> 
> I had a quick chat with Peter on IRC about this. We now seem to agree
> that a third option would be to move to explicitly account
> dl-server(s), correspondingly moving from a 95% to 100% limit. That
> would also make our life easier in the future with additional
> dl-servers (e.g. scx-server).
> 
> What do you think?

This looks like another good solution, thanks!

So, if I understand well with this approach
/proc/sys/kernel/sched_rt_{runtime, period}_us would be set to 100% as
a default, right?

It is often useful to know what is the maximum CPU utilization that can
be guaranteed to real-time tasks... With this approach, it would be
100% - <dl_server utilization>, but this can change when scx servers are
added... What about making this information available to userspace
programs? (maybe /proc/sys/kernel/sched_rt_{runtime, period}_us could
provide such information? Or is it better to add a new interface?)


			Thanks,
				Luca

