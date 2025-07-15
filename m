Return-Path: <linux-kernel+bounces-732319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCE7B0650A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 19:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29031AA689B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9C2283FCF;
	Tue, 15 Jul 2025 17:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jTcy219k"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BB3281355
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752600052; cv=fail; b=gyfFnUc5DDerSd09WdVROAiQeJ2+4wYx+3P1T96xTSILUaGKHOr8/mUVBKrnJgbFPe9f4mwtq+uBiepoFJU6arzrlYKz/xZzwTjvBB12qGmCMsM0Sp+HRikYs70g6ZecBMlrsMODCmQFFd67VpcMQjvq337Vl0/r0c19LlAwhac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752600052; c=relaxed/simple;
	bh=khuSd54QUr+jI7aRunflDmNhjzuwbHws5TMUFm6/N5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NToCc+2nWYVuyV5szMbJy6FvXtBhCLGEmjsEIY1HczPtvL+CN2uGOKiH2CJNBBI7oqEWrwuHfj0oOP2VRyzNngyLIP6fJXyYeHVRX7tmqWW0S5pyNlu01CEjYTQODq6cEruZJden1P88Nt5/ZIbTAZH+Fnr0WYQ6GCZjxFYiusg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jTcy219k; arc=fail smtp.client-ip=40.107.95.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nj22InoaLVV3W3Ab3raiLdnj6NCA7KQkIztI1AuCkaaHr2rxLAj5naASJX3bdB0ip8EWbyO+9pbymuWNjKFSDkY63xnmYIHHnEMvozJm2jmqXh3O9u9BT353c8AyS6+K/K6SYsEjNvoVMu4YVP07iJapqRkKPWVCw0pNmk1SBB1SeCIKbRz8ke2Cn0Xp9LH+eILdbSBKF2el5gemJelsDny6hgMRdktG2Ggni5NOoyCc5rtyJ2KNGCJiiSnO5ecjpNDflZujb/xnC0PseAfBb6ZqxOlgkg4DOS74ITEFPpr8iGPlNQ1PgOkKVPiKPDsoc1lRsHuO4dMVIE2ExKZc5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r74ysH1V6Vo3/Ho1qjh0+t6oeD/TQG+17k6N0tNlkbU=;
 b=PTp+gpnTETg2mLC0xZQcxVwpfRcCLfr3ao/h1kmKOHH5Nox/SFKhyGpAYdXPm4RPft88SUfbegK8MxflE7/0W1/CHE5tnXt8hinWGbf3HUe0tuYS/jUwlazrp91IQrCaulYj8M2xkO1rvMmpR7lC0vOUg2CVhQ5eXlhURPmJWtFMQxDMLjhTeYVHyLjlGWeKcho+3XtkYHWErkm2colk+IWbwSXmfDR6EeB2mht4TOycI9/tytkqY6L+wDvDhUcftLlPsPMOk13RcT/XsAKPYLVxiSaDE+hPsq/xYGzTYqZb3XT14zgns09v/1T1lwc6OvmBkwUUOcutvKEgVusrcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r74ysH1V6Vo3/Ho1qjh0+t6oeD/TQG+17k6N0tNlkbU=;
 b=jTcy219kVFWAr2+gJhrNgZWvPA1faDV5uyUWe+19KY+BCM0ZoOAbMOcXwIILNe5xD186F/e9MJ3FXG8qPnIcuh5HTkFWS9pLfLQ5ZCUMglmMR5pavFCJN6oGuzX+Eutdhynj05kLnL49TyhAdKi6fuPkJKnYUjJcBhfjiKx5augrTANuJWOWaon8j9V4B/PCU7sFJN8cYo/5B6JYhYQBM0I3AzABwgfeOUw1JUo/V36hdTxJWPbZVgdoo55EkPe1oXd9aakOzrZUFpfdMlfXd3iIlCEuHj90vUmpV17bqUNkq6wJFehVPIQNKrKe3guKd48HBi/zBhtalK1avqoJLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Tue, 15 Jul
 2025 17:20:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 17:20:48 +0000
Date: Tue, 15 Jul 2025 19:20:28 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Breno Leitao <leitao@debian.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Track currently locked rq
Message-ID: <aHaN3FqRG6gXNwbv@gpd4>
References: <20250422082907.110167-1-arighi@nvidia.com>
 <20250422082907.110167-2-arighi@nvidia.com>
 <xy47uzzirvauag3otkqhhhzwyhlpnnmeh3s77i2snmtoub3jhl@ywoeaxl3iq3x>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xy47uzzirvauag3otkqhhhzwyhlpnnmeh3s77i2snmtoub3jhl@ywoeaxl3iq3x>
X-ClientProxiedBy: MI1P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fbb4eec-20f8-424b-ebd9-08ddc3c3f098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fpp9Mac+ZWESWECTMDdud73pKtcQ2tIjx7XDAyGmcqwGsWrEVbAzBHCuEUPc?=
 =?us-ascii?Q?D0RUEi7j8BtmzzP6F1PvNWhXe6hf26mGC/8ThNnWgjkcVC/MHy2/UjAwgHN3?=
 =?us-ascii?Q?79so9SfCY3pLsMjgAxgui/wsyYVPq/zY6eHECtyhbtZmWC+5ncBQRpGkgnSP?=
 =?us-ascii?Q?5xh2Ep/QvuSrixr0HBK6iFtAAbXiSByQCvx5c4dgOEu07wa5A58x3PVOJAST?=
 =?us-ascii?Q?24LL2xzcIVR3yc5tbF6j6qZrlDqpyCsozn+BCmMPl9uUytWRkF8i+Trcu2xR?=
 =?us-ascii?Q?zOiTcLFEgMqYmaTHJjwuVgEFOgidLqCBdT0BHOt+UcJcg3COlPSVHiI7E45+?=
 =?us-ascii?Q?5L0ti9fzbhy59K9zzQsQR48paoGkM4VwP6NDqSgnHW/dKt3ZbiEdGbiADtGw?=
 =?us-ascii?Q?kbgyA4ziJ0jhUrlvjMlk0svJMWpaNpjy3fW6CujlTSNRY3ltUT0wM5H0MSq4?=
 =?us-ascii?Q?zFKS4BdIJ5Cxio+ce7Um/NJjnBebL+ATNPXpCa2rAUlY+RYDBVX/8pVIxmo0?=
 =?us-ascii?Q?k4iTA6uuGG41yF8Wr0fkMvSPQgplqowfPZ5WQYHJAcQqO1YRr2FtNYWYzS6j?=
 =?us-ascii?Q?1kseU96pM69u9frwejRhJlY6ouDMvXeZggqEzDpKgphP8vClau6qHcLXz1Wd?=
 =?us-ascii?Q?H8lvgv3/r58FNEvY19jTpvcfSVc/JBU/FL0VJPLKi1qUyqG0fhYg4MX5Jhjn?=
 =?us-ascii?Q?iTJIHcY4eJI71X5ZlZs1BP6uqkVpfxSnbLzf8WWtn12xYJbdi8SHP1RBiU1w?=
 =?us-ascii?Q?EljKlTwtS+PoP+XxHrd+Y7+yeT6/dvZ1gp258r5veI9W4N3qN45MFhY816On?=
 =?us-ascii?Q?/k3liuzfkGhFZ8C5h0skYF/vcCihb6u4IghKVXfVk2LNvENbxPZkW8MdW1Pc?=
 =?us-ascii?Q?hsK+Y2ihMx3oTp2zrBGwTEtWIjK9s0lJuQ+NTNwotjGSJDoIW5tYhZcBPZb8?=
 =?us-ascii?Q?GJOqtoiw/w6SyXNGgIWHMfrteXNPoNdAoUOwe+2101av9tO3fBw5I5h7YuX4?=
 =?us-ascii?Q?sahFygUTU7sSrUugnS6tUv/kUIK/xTeOccHPJECEpUQo84o2cruJtLDA4VUx?=
 =?us-ascii?Q?aXdQcIBswwfqdlAi84JP3CB1/u4bvZgGt47YnK/cUZGRRMpwWKn2L+UGvJ8a?=
 =?us-ascii?Q?Ei/QOH/mS9MOKbN3uiswfSbN5vw4gk0z7l3fMP0lPmFzkubLpbaFgCq0TDbD?=
 =?us-ascii?Q?c1ZUHLAILrCljgx5UUhjdQpomPC2UsM0c9A2DRdAGD2JQeQ3t1JyhWYg38uo?=
 =?us-ascii?Q?M32OaV2Qjvmd9qldi6qx8DNmV646gkqmDRUWwjjVjy9Df32/2fxIvq1Ciyjn?=
 =?us-ascii?Q?zTOxXu8qfXbT3Zbeq5Y3Bs3uIx7NkpEZIt5obVmFvksOmZgmUmRygBYPZH3V?=
 =?us-ascii?Q?TSTLmKa8pbK59XQq24FgI4CxiPmRFK7K15EI/mnk2yUq8yOT7Tmvbwv0wagD?=
 =?us-ascii?Q?IkJoHJPzwN0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QocsoWyFoDtI2vMUr0/47epRzzit2iMX2WC72ONWbsKNkB9cQqcubX5Y9TIi?=
 =?us-ascii?Q?LuSnnDD1qDmq5VC3xMZTpHbTrLb0v+90BNPwftfcXxk8fS1hP568T8mMdKHN?=
 =?us-ascii?Q?rcC64erREUg1zzv87vvtUwwY9iDj1VCx1orN5B+agSK/Ayeln+j0X7tYHhmt?=
 =?us-ascii?Q?iTchV2KZ75dzy0zefvAql9vNgoo55o5qzd79uT8ADVSV7Tgd+AuRCT6QLBjX?=
 =?us-ascii?Q?MyTSzJzu/tUgiFh6m+ferMkTirqXv/l+ltJHYz6kMeqYOfkpEsdqpJ7iNxel?=
 =?us-ascii?Q?wlxyRqp7CEu2F3UOW8kgKNCihaF/+IT4QCfw1YUoRWUYKdLo0OpI6QZJDzPQ?=
 =?us-ascii?Q?E6y1iEPfFX8Gb4NtMFCxuhLAZyEJm2M/fhP+dQc3vcUSYN0u8Lkus3/tkGsg?=
 =?us-ascii?Q?qIvmsww27Dvomc5D19gaW0j++Gcdk4A6eMzUNAunUD1etU52VviwDASetINC?=
 =?us-ascii?Q?GSugf9uyv0359ii8vvWOZDrIntdEo72UEAOajgHWTmwWgkqpFdL0+5lPXySA?=
 =?us-ascii?Q?aYZvgVThZGP/PMvDEH40sdpsILkizKt0EGytsIW37llNDSbEx6TsrIw4PpbR?=
 =?us-ascii?Q?T/HkUPGco6SSmjdm9SB7O9TEu4BRaXVeIiq6KMAnEq2LGYHZ3KQKs4+zD2fG?=
 =?us-ascii?Q?7NdP09MA+NFIKnCTysYKi5dOF1tvkq3zcodA+NKOujAbcqVJfQm1m33Y2WwT?=
 =?us-ascii?Q?+XpDlxrbjRRKp9QZLlvU25X8xfjc3WMuVI1FFi36/mTezoNVGkwggS7d+Kw9?=
 =?us-ascii?Q?jYqQZuLpGKkEUg/kNHYUK/FL1wCF9iKWvlxOmtxHrJn5fwwonZiROPM299ZJ?=
 =?us-ascii?Q?xj3QL3/NsMIR1CFsiKoIR0ADtsexqp9Ln5u1NgoNeASrbe1SdWd0wljxNGyE?=
 =?us-ascii?Q?WW60adyDXR3wNe8UcsjhkdebHUCRfj87DrD8oYMb4obi0hgPU97gndxMZFj5?=
 =?us-ascii?Q?Danosx4vcG90TBpJLk8FNgxNW5SABvZFMFf9dBFdXlZbNhZ6N3pfdudD7lSI?=
 =?us-ascii?Q?blxY0OT0p6KZqPGegjqn7s1X1rJ4FMs5EOuEVL30D0wLuSJ/CWXgkL5OVCtT?=
 =?us-ascii?Q?Z7Jba0IPr4fHT3OtbpeoX7hmGLC93kM1UI9BYTtfciZYWmqK0n1P8kxLhchA?=
 =?us-ascii?Q?LE/c9NRd81oerqcEgTlMjU2GfSf2q35Pb6xOl1hGwzcCUs1urG9Vw8c08k6q?=
 =?us-ascii?Q?lqJ4e7KCCAbnYK/yR9Pzq+FAA/kPUdoBCYu6Qqimg8cQ92BspSac9A/RUg8g?=
 =?us-ascii?Q?0GADwxuzWTkX3zxsmH/Kt6BHuzHqLcFYd9VU0px6WTT+wq1Cp0p6AbR+tJMT?=
 =?us-ascii?Q?iG6P4NmPE5A3Uuz2KFLsXxhwgkTtmkn0Eqf311vGQ/NUDGNicqcPOkT61G3S?=
 =?us-ascii?Q?f+yClyfVytVtmkKzfBU1M5vp7qCgQMl1Ie8fotDNm2ozOQpfS07co4rYHs0a?=
 =?us-ascii?Q?1G/pu16CCB+i5eoZLIqzw52HDuMqS0OwQxotVRTjYT96izW+EKuG8p0Nsflk?=
 =?us-ascii?Q?+NcOlWKxD7hr/rabl3NxoUztxDVSkikrz3of0mTlqKRA1zfplcDFQBE8Il57?=
 =?us-ascii?Q?Ep7MTPLx1NCs/GcfnWsX2VAcw9xmOCbEPR1CpJym?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbb4eec-20f8-424b-ebd9-08ddc3c3f098
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 17:20:48.0713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uH4GujtWyYXW0l4/BmoSvRmg2TVBH7L0AS5lyxGAAJJmSb8uSvqrEsa3+U6/bCNhn4cXtf3kzPVxTAIWAvDZPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867

Hi Breno,

On Tue, Jul 15, 2025 at 02:13:03AM -0700, Breno Leitao wrote:
> Hello Andrea,
> 
> On Tue, Apr 22, 2025 at 10:26:32AM +0200, Andrea Righi wrote:
> > Some kfuncs provided by sched_ext may need to operate on a struct rq,
> > but they can be invoked from various contexts, specifically, different
> > scx callbacks.
> > 
> > While some of these callbacks are invoked with a particular rq already
> > locked, others are not. This makes it impossible for a kfunc to reliably
> > determine whether it's safe to access a given rq, triggering potential
> > bugs or unsafe behaviors, see for example [1].
> > 
> > To address this, track the currently locked rq whenever a sched_ext
> > callback is invoked via SCX_CALL_OP*().
> > 
> > This allows kfuncs that need to operate on an arbitrary rq to retrieve
> > the currently locked one and apply the appropriate action as needed.
> > 
> > [1] https://lore.kernel.org/lkml/20250325140021.73570-1-arighi@nvidia.com/
> > 
> > Suggested-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  kernel/sched/ext.c      | 152 +++++++++++++++++++++++++---------------
> >  kernel/sched/ext_idle.c |   2 +-
> >  2 files changed, 95 insertions(+), 59 deletions(-)
> > 
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index bb0873411d798..3365b447cbdb8 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -1116,8 +1116,38 @@ static void scx_kf_disallow(u32 mask)
> >  	current->scx.kf_mask &= ~mask;
> >  }
> >  
> > -#define SCX_CALL_OP(mask, op, args...)						\
> > +/*
> > + * Track the rq currently locked.
> > + *
> > + * This allows kfuncs to safely operate on rq from any scx ops callback,
> > + * knowing which rq is already locked.
> > + */
> > +static DEFINE_PER_CPU(struct rq *, locked_rq);
> > +
> > +static inline void update_locked_rq(struct rq *rq)
> > +{
> > +	/*
> > +	 * Check whether @rq is actually locked. This can help expose bugs
> > +	 * or incorrect assumptions about the context in which a kfunc or
> > +	 * callback is executed.
> > +	 */
> > +	if (rq)
> 	
> Why do you only need to lock when rq is not NULL?

We're not actually locking here, but we're checking if the rq that we pass
to update_locked_rq() is actually locked, since that's our assumption here.

The idea is to distinguish the sched_ext callbacks that are invoked with a
rq locked and those that are invoked from an unlocked context (and in this
case rq == NULL).

> 
> > +		lockdep_assert_rq_held(rq);
> > +	__this_cpu_write(locked_rq, rq);
> 
> This is hitting the following BUG() on some of my debug kernels:
> 
> 	BUG: using __this_cpu_write() in preemptible [00000000] code: scx_layered_6-9/68770
> 
> I have lockdep enabled, and I don't see the assert above. I am wondering
> if rq is locked but preemption continues to be enabled (!?)

Interesting. And it makes sense, because we may have callbacks called from
a preemptible context (especially when rq == NULL).

I think we can just put a preempt_disable() / preempt_enable() around
__this_cpu_write(). If we jump to another CPU during the callback it's
fine, since we would track the rq state on the other CPU with its own local
variable. And if we were able to jump there, it means that preemption was
disabled as well.

> 
> Also, I am wondering if the following patch would be useful.
> 
> 	diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> 	index b498d867ba210..c458dd7928e92 100644
> 	--- a/kernel/sched/ext.c
> 	+++ b/kernel/sched/ext.c
> 	@@ -1256,8 +1256,10 @@ static inline void update_locked_rq(struct rq *rq)
> 		* or incorrect assumptions about the context in which a kfunc or
> 		* callback is executed.
> 		*/
> 	-       if (rq)
> 	+       if (rq) {
> 			lockdep_assert_rq_held(rq);
> 	+       }
> 	+       WARN_ON_ONCE(preemptible());
> 		__this_cpu_write(locked_rq, rq);
> 	}

We could do that as well and fix individual use cases, but I think adding
preempt_disable/enable() would be better. We do have callbacks that can be
called from a preemptible context.

Thanks,
-Andrea

> 
> This is the full stack for the BUG: above:
> 
> 	BUG: using __this_cpu_write() in preemptible [00000000] code: scx_layered_6-9/68770
> 	caller is bpf_scx_reg (kernel/sched/ext.c:1261 kernel/sched/ext.c:5558 kernel/sched/ext.c:5879)
> 	Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE, [N]=TEST
> 	Hardware name: Wiwynn Twin Lakes MP/Twin Lakes Passive MP, BIOS YMM20 02/01/2023
> 	Sched_ext: layered (enabling)
> 	Call Trace:
> 	<TASK>
> 	dump_stack_lvl (lib/dump_stack.c:122)
> 	check_preemption_disabled (lib/smp_processor_id.c:?)
> 	bpf_scx_reg (kernel/sched/ext.c:1261 kernel/sched/ext.c:5558 kernel/sched/ext.c:5879)
> 	? bpf_struct_ops_link_create (kernel/bpf/bpf_struct_ops.c:?)
> 	? rcu_is_watching (./include/linux/context_tracking.h:128 kernel/rcu/tree.c:745)
> 	? trace_contention_end (./include/trace/events/lock.h:122)
> 	? __mutex_lock (./arch/x86/include/asm/preempt.h:104 kernel/locking/mutex.c:612 kernel/locking/mutex.c:747)
> 	? __raw_spin_lock_init (./include/linux/lockdep.h:135 ./include/linux/lockdep.h:142 kernel/locking/spinlock_debug.c:25)
> 	bpf_struct_ops_link_create (kernel/bpf/bpf_struct_ops.c:1367)
> 	__sys_bpf (kernel/bpf/syscall.c:5907)
> 	? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> 	__x64_sys_bpf (kernel/bpf/syscall.c:5943 kernel/bpf/syscall.c:5941 kernel/bpf/syscall.c:5941)
> 	do_syscall_64 (arch/x86/entry/syscall_64.c:?)
> 	? exc_page_fault (arch/x86/mm/fault.c:1536)
> 	entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

