Return-Path: <linux-kernel+bounces-730341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DB0B0435C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D333A1885B9D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF0D258CED;
	Mon, 14 Jul 2025 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="G6egAU5o"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020112.outbound.protection.outlook.com [52.101.56.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820A36BB5B;
	Mon, 14 Jul 2025 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506155; cv=fail; b=lN47zDsOqPipfINJFyK2Hwb4T8hGBOihELiylD+/DZaVZLpBIvPjym2rdlyytgfLfj8rJ4LDPQ7e+0iqqajLvLnuM6lMjxIAofbcnu2T5c63IV0IZpDPzNXAYqfYtZPI1WMZBpdO0OAdEdJnuWzRu3dGEcti+TcTxeDw1iGuJTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506155; c=relaxed/simple;
	bh=A56Psng3IOBuQ+hR1mqZFhtcijrUlbwsKHNIWOaQrW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KYWvs9uVVS1ZRuKB1ZLQAK4Yi2txQqPvqE6oMMtDe+jqQdIGsLlKJcB9cXr99pHTOHjzPrv5+Kllpvdla0tsXTQqfKy94OxzPysGz2pyNnj9jjL9McLtVQ8ryfdT6hZGt7Mc2Zf7DhXk3rRR4Zcl4qmzIPPRA7fRCajDgb7VO3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com; spf=pass smtp.mailfrom=inmusicbrands.com; dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b=G6egAU5o; arc=fail smtp.client-ip=52.101.56.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inmusicbrands.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jk2IqVgMNJ9O1tLnhnQqoagsZw178bQ3iNEdlEwTrh4h7gHdhl4uKGVPPAHiEbfjyChmTX8oTR9xmb8Ss1mXVyi41RHkmGhfwr0bFRBzd2UJJ2aU2lIDfC1g0tXNi+KF1mb1iCK2o+pLXhrScfIEy4NfppEmwAOdo2auAzTbjKTBXs0RpJRnqxc0McQzaumf4YMCpyw7KtRSASE6ZF3pZ3vFFcPWneif/BlpL1BmsWuXl+kK5xzciYrVo+AdT85P9dI4eedGc7ghOYUG5GzVl+TH6HH0qyIFeI03VgVC7iCKIgHgoDhl8SSuxUiqjLHFjCnKuvlsKlcZXxJmyMN0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ygSKGZL8Na83xJlW8HqlTS26a5PsVkiYYDDUARydCI=;
 b=KsPS3myTnyEIomHLSBL/+PvVLzJRSUAHmIhZ4wE6V3V6Ff/jbMiFvgAPPpNooAsNBIFKfb1JMcOSkZuW4gG+wFYpSLBXUn+CDKj5ehSkW1KEelBYNQ2rSm/S0GbsZvpBHAegFbdxeU/Ul8EbpW4KjaoX8aR83aViBAuct2CevG7BmneZn/IydD64vgo7VN02VJufG8vSL5uPY69pH1NaJ8HMHuqmRc/wXqpabxmcf2tpykdJcIzK2ZFGMp1JBRpb1wwNOh4z+k7tDLBqKX/fLs87WZwa8v8zp3qI+Iqo4zYtjsOYFamBLPmYKbso3Y9O61fSaq3cGh1RONdUzUMl3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ygSKGZL8Na83xJlW8HqlTS26a5PsVkiYYDDUARydCI=;
 b=G6egAU5oA4Knn2YdT69BP9TCGU3IWOiMtNYWXmWbylbXk4vXmhIUkBVAVJAR7Pvh3iAekhxtlGTRmiGNdsVRcTv3q0YNkRCjBQyHu7M4zxov4kLy8yKgmkfwA9mLy7p2VbXIt7IaglHJaLTiqkEY4+Wzeo5vgl1tL4TnLQiPW14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from MW4PR08MB8282.namprd08.prod.outlook.com (2603:10b6:303:1bd::18)
 by SA2PR08MB6716.namprd08.prod.outlook.com (2603:10b6:806:11c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Mon, 14 Jul
 2025 15:15:42 +0000
Received: from MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401]) by MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401%7]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 15:15:40 +0000
Date: Mon, 14 Jul 2025 16:15:32 +0100
From: John Keeping <jkeeping@inmusicbrands.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH 1/2] usb: dwc3: disable for USB_ROLE_NONE
Message-ID: <aHUfFGnGZP4z7UgK-jkeeping@inmusicbrands.com>
References: <20250710152252.2532020-1-jkeeping@inmusicbrands.com>
 <20250710152252.2532020-2-jkeeping@inmusicbrands.com>
 <20250712001131.ax3rw24h3deekxfv@synopsys.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250712001131.ax3rw24h3deekxfv@synopsys.com>
X-ClientProxiedBy: LO2P265CA0160.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::28) To MW4PR08MB8282.namprd08.prod.outlook.com
 (2603:10b6:303:1bd::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR08MB8282:EE_|SA2PR08MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: fb44d944-6b74-4f7b-8379-08ddc2e94b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0muWFhu+jsXp1WDpSsQ6WpMKg+FRXzQY9xpCbmPQN4s0uDwxgrUgfO6RcWnn?=
 =?us-ascii?Q?yW1X+DTxU/Do1ZADAqnvvHS6X9td6uAGr3XaaOitWrq7vsrKKVSgtadtKxex?=
 =?us-ascii?Q?9LlNLCepIxDW3tBGKABFKrNBUWt3uQQP5meYQkEu99dgGuRJu5pSB8cjtiys?=
 =?us-ascii?Q?cnRVxTZln7n+82BIkTTCSmWnXGspPWxoOSS9jdDn5SlyNXmexL5rol/tinFi?=
 =?us-ascii?Q?j1lO2oAax6oAIC2H5L+0gSXAiPLn1PdvAmZNUMr5FDVloo41wKFm3SEHE3Z5?=
 =?us-ascii?Q?HD4t7h4ARSxSbh5tl8I8TWL1l2cp2BNexiq7lflFrCRBvZuYOa6RhL8cqPfL?=
 =?us-ascii?Q?Itmluq4EUh7nGpOQSnNWJwdXpg/69KLjQISv/+c71GxO+zP3rCaY16O0JA1B?=
 =?us-ascii?Q?EwxmJkG/nf4VWVpESBvAyJgRj/Wr5dMF0T4g7tHxlSbbc2m56PUdJP4yUvH2?=
 =?us-ascii?Q?pTuYfleZz3+TS17YpqK/rGOviaUg9cVslRV2nIflBl5EB9aDuhA0ircsNu6x?=
 =?us-ascii?Q?3EYC3/2fdqbfQj3rdTredUJt6y74+Orts6e6R/KatcvoGPhIliXrr0pdgJdG?=
 =?us-ascii?Q?u2ps0Mw8JjP7A1aLtyT6Y6w5vn+2/jOe8iqD9kyyUfs/hZozjaoosVkUXsG+?=
 =?us-ascii?Q?CnzW0wuO0H6iOF1lQVDNd+Cmtg11uMpJ55J5QdoYZmDxAu2TTbWcwyd4Rz7x?=
 =?us-ascii?Q?CeAPcvM88kiMfe8tu6WY2NGYQsD+UAqUIWl3BERaSY3uVSZA7nz+TPth0Yl5?=
 =?us-ascii?Q?JhBdgptiRhpNU+aQ90pOuWy8AOj3OHm6Z9zsgYlUuakSAxHwDJLPkp1G7t1F?=
 =?us-ascii?Q?um6QyriwKsqpTS9aKlt6mYE/36yjrx/SUNZ8rVSZbjfPcsYgkPXcTaFO38SI?=
 =?us-ascii?Q?Jeg6gHBC4F4by9JRq8NCEroffjIG+JwtnRrAgRwMi0jOqnq17/UXYBO2385W?=
 =?us-ascii?Q?oOghl35JC6YHf0JEsydWXAE39v7p19K0SABj/a0tSj565MfpU2Du/Mei1i90?=
 =?us-ascii?Q?wMN/pdAYet6OKuHVbLQY98XE8Vc8tzvssZm2eGBWwf9VGfKG0VuJiYGlKBI1?=
 =?us-ascii?Q?CpBkyvjFcw6rMlTxTrQ8grGMGS6KEMM1yNoZX8mCR6CWTPPtwGl/kf5k9tEI?=
 =?us-ascii?Q?g3V88Wj274pisSNux9/bl4cTQvnon0teFZnhyiQBLyKhcdrKtnsSVAjGZ16d?=
 =?us-ascii?Q?zCz3pTdCDzxqMV5TYw7PVU8XkGdduon1TXqnxCKxVqMAw6k/UZn965HkaGMY?=
 =?us-ascii?Q?+nVnZGhI58eSIcywlMxdHDhX8rkHYAdg98X/MSyyCa3Cp1ldb5qxsuCIHKs8?=
 =?us-ascii?Q?S+eXpr79PU/fvlM6++tuSauHSazKIfJd2i8u/PrvY3p+gvFIWw3yToQvC8Pa?=
 =?us-ascii?Q?vX7imMeuSNK4I1MxDEsZ6WXPtuZcmFzvWUfqK1m8BOusIlR+ZopOnCfwWGGe?=
 =?us-ascii?Q?Prwy837iAS1EIudlFOhiUzIneOUqyPQHmWXV8Ic3X8B/mIzz6RwkfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR08MB8282.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wzAEQy2pRTc+RXH+nSa5S5ZLviB9wpHnDeSVTxO3pPR//T9UTUZ2YtSSSkm3?=
 =?us-ascii?Q?HMgCBFF+L6oLS5nexHNmYn2SOUOi0RwDmrv1cEM0LAQzpJcgl2qi+MgLi8H7?=
 =?us-ascii?Q?KM3UgK9OaCAJ9sZHGQGh0j5hNPMbTGSHXgXA5T+heRUG2K15o+NJBd+QRZ8u?=
 =?us-ascii?Q?jUB819xmdN59x6DzqsKQF6S6A7NgKf2Z8bikXSrEqQ7rv1DrqmfF9bOZ7cu7?=
 =?us-ascii?Q?c1ZAyJgf3wC9Gdni5bv9dDnu8xDoAe+JdE8KLk5WzYNHU4PY4lYsgHBc0qWP?=
 =?us-ascii?Q?XAJ8tqC+36M8SOJFU3RgRPx3RW5aX59ZFP7Mh4DkLT7qns7DVEHPf88XTCG1?=
 =?us-ascii?Q?rwYDvyhIO54l93AlzRYF28KirwhsKL72kh7qC+2pz4mD3+uUY3Op6YqzIMKA?=
 =?us-ascii?Q?/vOKAeTegvKtPMEVG1qEuTtYaxEGItyudU9LlBzebDB18zV6NJLrJPY7kwu1?=
 =?us-ascii?Q?tA3iX8kAqPd6YxymUrXVegqAQBQ/VrFT/GOB6lmkCMkWOOwczfLugrRQqCcW?=
 =?us-ascii?Q?36j4EOU5KqgkXuIYusZfzzC4+R6XlRY6UK0HsFUq0rMG5+7DBRZLykJELiyk?=
 =?us-ascii?Q?NaI8WvkI7Qtp0T+C9lMRRqBm3rP7w+zGAoTaMtmTg+hUmmsV4M6ShitCK8kp?=
 =?us-ascii?Q?hT/7+d8XjWMZ8PKmforg7cxgIO7WBMLoW/xJrg62FZS2tUk09JoEwLI9IWEP?=
 =?us-ascii?Q?8ZcaHysyqmWPZ+zbb2h1vnlKESE8bA7Fw5h2KeuQy4DdGNjUoxr4IXq/ZowB?=
 =?us-ascii?Q?madkeep/To4MOZJVjcaEva3qfIhHKE61C0YPjz9LYWaEvMFEG9MLhAyf8rPv?=
 =?us-ascii?Q?MXJLNL8vJkBhXNHbDEOP5vQq3dUBsmnRh+CApsXZ+C0k5HydmapMLJEqr/7c?=
 =?us-ascii?Q?CjLH1kKmBeeRhPhaQojHkdXw9/VoGG63Tkavw0xT/hGDUv5yaFN3/lh859jq?=
 =?us-ascii?Q?VuSeF6uXoqiPJxFBuOtKX1TxKTnOTp9hnRSeKvFMBXz0WkupCl810AZB9HYe?=
 =?us-ascii?Q?gFAPHAqAgLBiUTeCSvXO6QyBlbxPW1et8Wqfm8kwzVMU+9THPyl0HvFu1Y92?=
 =?us-ascii?Q?cq+LZO98PZSqb1Wxh5rOREZvzRoLCD9XTBvgeV4VNJ+XlKZcFjaEW7wEMHEP?=
 =?us-ascii?Q?web9HcIy3pjSVSNF62tOZGTnSXI38babhGtURMEYlp1aHjtZbpnDxNVB8rgZ?=
 =?us-ascii?Q?pZNtWhsLeCI3jeJL60Wh+YIT3aAnjLgfCfv4Dh8CbjI2AQaVFnLzM9pjS5xB?=
 =?us-ascii?Q?uYwiHfxzQVm70MY0gs5zz4DaO9PTx2ap9G+ViYaB2iTyRcFfoPUz/17I+PYC?=
 =?us-ascii?Q?tsB3wlfWK5Gh2CqgpjhB6faJpb8ww36ogq8tjjlyCBANmqsQxNo6WVvD6zYI?=
 =?us-ascii?Q?wXFX9GutdNV/x09mgAe+z7WkMpRdYlVBOaHO6xft81gxWDKq/MAgkrwaIFoY?=
 =?us-ascii?Q?wmANAFWY3alOh7a/LQjILrZmedsDfdUjelZIka5oon9zCJMoPAJDopapiM1X?=
 =?us-ascii?Q?Ue5Wb0T58GwOl082jdUYGiS0i8eDXI7AHeigOjxA0Z9iwgTq13HBcRffSl7/?=
 =?us-ascii?Q?7qDJ/DyR+QADp0uGGMTgUPjmYpbk0TtfZ9DjoGeGsXYZTZfSQE8rBpH/9R8D?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb44d944-6b74-4f7b-8379-08ddc2e94b59
X-MS-Exchange-CrossTenant-AuthSource: MW4PR08MB8282.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:15:40.6539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIRFrvxbTCO5LNAgtmpW08oNvGwPaCGcjmcYnGRSQc8NuBGat/I+QBZUOLcFS+ceCWzoyMc/v9nbdZJQLqfGkfzijnH6lOwAex7K7/aMqZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR08MB6716

On Sat, Jul 12, 2025 at 12:11:38AM +0000, Thinh Nguyen wrote:
> On Thu, Jul 10, 2025, John Keeping wrote:
> > When the phy is acting as a Type C mux, it may need to reset when the
> > cable direction changes.  But this should not happen while DWC3 is
> > trying to use the USB connection.
> > 
> > In this case, there must be a connection manager to notify the phy of
> > the orientation change and tcpm_mux_set() ensures this happens before
> > DWC3's role switch is informed of a change.
> > 
> > It should not be possible to go directly from device->device or
> > host->host with a change in orientation without transitioning through
> > the "none" role as the cable is unplugged.  So ensuring that DWC3 always
> 
> The controller is either host or device mode. It's odd to use "none" to
> indicate connection.

There is no connection in this state.  When the type C controller
indicates that the role is "none" then there cannot be a USB connection.

> > informs the phy of the new mode whenever a plug is detected should be
> > sufficient for the phy to safely reset itself at a time that is safe for
> > DWC3.
> 
> Couldn't the phy do this as it detects connection/disconnection.

I don't think the phy can detect a connection.  If it is configured for
the wrong orientation then it will not monitor the correct data lines.
The phy hardware does not signal any interrupts to the CPU for the
driver to react to.

> It seems what you need is a full controller initialization upon new
> connection on orientation change, and you're using role_switch selecting
> "none" to do so.

I'm not sure whether a complete initialization is necessary, but what I
want to avoid is the phy resetting while the controller is part-way
through device enumeration or setting up a gadget configuration.

It may be that simply avoiding resetting the phy if the orientation is
unchanged is enough to avoid some of this problem, but I suspect there
are still problems if the clocks from the phy to the controller are
stopped unexpectedly.  However, I have run some tests of this change and
it looks promising.

> I'm not sure if role-switch has the right interface to do so. Perhaps we
> can introduce one? I don't think we should change the behavior of the
> current flow and apply that to all other platforms.

I don't think it's unreasonable for the controller to be idle when there
is an external type C controller notifying the connection state.

The hardware setup looks like this, with the Linux type C code notifying
the phy driver of the orientation change and the DWC3 driver of the role
change:

                      +------+          
                      | DWC3 |<----+    
                      +--^---+     |    
                         |         |    
                      +--v--+      |    
                +---->| PHY |      |Role
                |     +--^--+      |    
    Orientation |        |         |    
                |   +----v----+    |    
                +---+ FUSB302 +----+    
                    +---------+

The advantage of using the role hook is that we are guaranteed that it
is called after the phy has been notified of the orientation change.

Do you have an idea of a new interface?  Or do you think it is safe to
reset the phy underneath the controller when that will halt the clocks
from the phy to the controller for some period of time?


Regards,
John

