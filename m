Return-Path: <linux-kernel+bounces-830555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9676FB99F8B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E09616F154
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CDB2FD1CF;
	Wed, 24 Sep 2025 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dR+kYjkH"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010041.outbound.protection.outlook.com [52.101.84.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B7B2DF703
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758719222; cv=fail; b=V1K0aJ4lvRA8s9mbmcTFv8v08rUb1inK7fGrYzClw14Cq1PLwKtWWXjrborxg+XR5FYZ/Hzhc/60ttXyiuWwYMaJAOoV1LlGp1zjOB/onb4OLJowKEY7SWOWvSQWmAYfOOFGm7OC3iBYkCnWrLD6+9Pd8l0RAALWzD62SYMfwEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758719222; c=relaxed/simple;
	bh=BM2hLeEczMUKfqzRezQwFbWrhqWzvwZTogUk53BmnHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RCF4/p0VMCfEcnwpL34M7/XsxURQv5HdHaCbUtijgdOV2Wr8gIuqeWaSng7+O0OhDgFpcHM9qg72W4PwtoP1nINauVdswBrGGNqPMSod7QL5x03ScnVHl9bI+HA+tUb20T0PeTU2h30mCpsdr2qdM40mzvVZpbDLZ0jELy7wP7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dR+kYjkH; arc=fail smtp.client-ip=52.101.84.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoRMFbtFafG+pq5HWRt9lTHCB2lj64WtHr/RSsATJ31eDwkyFS3WeCQIqOAPCYzLptPaIQHr9+rDDXxm5shpAa2GHiO4UfwQfO96PJfXQgfaBXJsOC0GlpTw88uxvN3i+/zVh34IV+3O5JSj/TEFb+9dkoDfeaTEP8jgK0edfk4JO6Pxn65+6dDyg4kfZJQxVksOD4KoQ9ELqZNlgAMffPJCni5ckI9bQKr9JILTTeOPoZoxBB5eFEJQuiUFtTu//+VEVm3deo1OHg4shavC/5b2LVbIhlsI7vuxH3JhbVykQCLUl+pxhgSKU8uxqGUwTqNBT19pP6KYfXfg83wrWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymqj8QIdeKqC04VmJvPtOcxfD3O2cRYe5Z3otAd3sqs=;
 b=om6it0Ih6DIHS6zyKkb+Hka25iK9wfB4rEm/o+YRJkA1fLHdhYgg6hGDtRGl+a6WAABflxZfP7v2WIV7xu9vOgKD9JpKhQvyz1xezYPSoXoIddU8AzbNGDM2mK7AVaSHwfp+LUgkwtlK8TshhPf2ItsD0+Gfpv8x88NsYV8hhl2F4uabgNEkCtVgfPufJQtVpvBGU9l+P80qAx5o6c4NP40iglxAIhI7L6P+gQQlTcfhbtS7Vqm7pHu40hntBAhIgpUDMTRoFEJPYwnJB08z72aKBThXEXb+9gBvEwxZgjNL0o92BlvY9xqJHKBf35d1JFO9b93pgeri/mh6+87hjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymqj8QIdeKqC04VmJvPtOcxfD3O2cRYe5Z3otAd3sqs=;
 b=dR+kYjkHyV/6qqUU3x8p+UKiRN9sT8xJimq42OPJB/XLgwZwj/qM+KPxm6nXwrvd3EAN1akuui8ritNqaYWR3rYMQXil7ql5cRocSnwwQVqBcufsrs9LdTwZbPJWCdzYCagAg+FEQdCczsCdtjWHOilY0d/f6XXx3BPE/xH/6V3Sy72GPccSKMePACAYOMw2MgxjP8I7GrjinDjmEoOSeHW+FNdqbNuPjRGONs6iuEzfReLloVwQha8wA+USVNVdSBX1pGIF4ni6DclA8lffo9dt2RmKvD7lS9ido95x8RsTnQNVYWvlmb8nHvOGAmUbvIivZw5M529Yt56jgOUzsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU4PR04MB10457.eurprd04.prod.outlook.com (2603:10a6:10:561::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 13:06:57 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 13:06:57 +0000
Date: Wed, 24 Sep 2025 16:06:54 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Josua Mayer <josua@solid-run.com>
Cc: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 phy 15/16] phy: lynx-28g: truly power the lanes up or
 down
Message-ID: <20250924130654.nnliddqiug5hkbsh@skbuf>
References: <20250923194445.454442-1-vladimir.oltean@nxp.com>
 <20250923194445.454442-16-vladimir.oltean@nxp.com>
 <e04dd32d-801b-4019-aa2f-95bf8973c566@solid-run.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e04dd32d-801b-4019-aa2f-95bf8973c566@solid-run.com>
X-ClientProxiedBy: BE1P281CA0322.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::16) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU4PR04MB10457:EE_
X-MS-Office365-Filtering-Correlation-Id: c0df665d-8412-43da-a5a0-08ddfb6b3d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qGlGVuk1VeV+Xi8S46puuJ+XrDSDjUcBBWF3ShisWkkiR60+l1AS3KyZAS/2?=
 =?us-ascii?Q?bwWZtX0soGloMg4sLHPjZmTelDexUa3jYMayAqjanZotQ/u+ohevSoQvcD40?=
 =?us-ascii?Q?egvEmFk9gYpEE8KpSmNLCHpX1/Bftw1zY1HCnuKCz3Qq6i9H2kC60tW9MqCc?=
 =?us-ascii?Q?EI68eGKljdITp0oILdLC43R1glRruSO/JCrXzZjIuSujn0RhZtIisABUhKRQ?=
 =?us-ascii?Q?9VSIl+/glYbsbIN+HjbrdfeSzo3KRgInXRqEoNu9VXCFzMJzupCi9ifCbKBF?=
 =?us-ascii?Q?9nv2MMJwg6YDMIxMxWV1EkfnJPhM72XLLueVRcT78QQZngqvYr3OOzNbBBq/?=
 =?us-ascii?Q?N2lLyIzyGocc76AXq1uqGr+RokHfnbEluqeH64zSmuxXY/6qHH61Ur4ZPXa3?=
 =?us-ascii?Q?NmHOADbaiuwlynG1szmg3BPXeEPKaUWn9AinyL3HSjh+SRQtkisZAEdnEoyv?=
 =?us-ascii?Q?R4S4rdlkRHjfNP0R9bBXwRXmlC7oTf37UjwzIRaP3LMOGZnCNuXDchzCFMqm?=
 =?us-ascii?Q?5nKTR84/s9k0Tj8qfaZPvHfzYSTCYyF7ybWx0qN/jUJXg6A2DK7GXeKKMFSs?=
 =?us-ascii?Q?11AKrbVO8OO0ctsi1KIIf+tRhJrgW6eZxIric+1TuedWoGWXXUdSwE8HhDDo?=
 =?us-ascii?Q?Z73rTMT4i8sutoBf4y8ClWSY8d09nzLv6dzOpU3BNWsCZDPXpaP2yopySJm2?=
 =?us-ascii?Q?dmPoXayBzqrMVtFcfLnS+KomqqqcnH9FKCnm1+YmjAXDi/Wuz2/lZw6/hWQK?=
 =?us-ascii?Q?NdjFeygx+LEZLFjEKjEl9+LAB+IR+npRmHMLEhvFnZl/969ocI6nq0x9YL0I?=
 =?us-ascii?Q?VVVoyjQSCSNwqdxrptrv15Tz/4s1TLf9uQQf9jrG1ETHx5bsoqIgE5fH8fNd?=
 =?us-ascii?Q?fDgtzkN5Lizj6usijZCdLhUkIGmlcasthtFQZY9I5KR2GAKevkTto180koVY?=
 =?us-ascii?Q?SP1Z95WKXkcSqL/bpQPTd2ym9O1+81dMBBUt3Vh7R9sYmAQJ44YyYK6NXOAF?=
 =?us-ascii?Q?qvG7PZZ9aweOfwpSa4AZ7i6CzlUYgtkK4IjTdFY3fxOndhXwYYRyP4AZaveb?=
 =?us-ascii?Q?jz/zjxamtty4tkDrLUaDIgVYKOEIYlMQI1cbVrWDYetbUIb+oZMquVmw96jQ?=
 =?us-ascii?Q?9ivxqsu6TAcKj232VF60/+nr9YLc81xD74Xx392KPPg7ee3IhBYUrEUtaUJO?=
 =?us-ascii?Q?USf0ZLjcaYgfg0OzJbZTkQyhVp7Wl1dXoFZ8EMOY2Ky8y2Azq5Q7+hihLhr1?=
 =?us-ascii?Q?rEK4UhVndHO6VRhQ0Ut5u0ocaJuhQST29GuIC6VPGesggmKrGaexmKi4tbyj?=
 =?us-ascii?Q?sPJHDRiYtlnYidgImysWUfOT9IB8TrfzrWDbhpKw/Pou1Pb143xauDTNKfZe?=
 =?us-ascii?Q?QmGrw9E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kPwIS0+G/Gh64IdfCToD7CjbgRc5Tc+QSSaY+0WGhGZhdeP2I+uPKmaUXNMg?=
 =?us-ascii?Q?t0d4dLY6Wbrj8qnu0SX02+dHFu6s+K/ai2X3eqbi1FBhdNB13afEJbJSaWby?=
 =?us-ascii?Q?x2BlqyRn+ia71KsyNrC4Kmb2/+NBGMbpiPBq1LHBbBtDX5qB/QFLwVGn4cch?=
 =?us-ascii?Q?DCjSCs1Y4RzdkBfm1ucZeGBW5z8PTqz4yTEm7J9E5XjOF2LttIViZIjPLyyZ?=
 =?us-ascii?Q?H3m4uY2tLsTqLFJ8bZ7orRQnFOeOq3PVE3/azSzVzv+gJq3hwItnx5R3pROl?=
 =?us-ascii?Q?yT9exItGWsR6o+x1bjpK8TUgcDYURvyKo/D0Ndwrd40/My9wUyVABSeEnimd?=
 =?us-ascii?Q?oZduFj9pRxRRfdhwJ4ZW15o4B7/fUnfbnSnKgi5tlkriHNOJAHfLwK2SU42N?=
 =?us-ascii?Q?mh8TuIdvAVYlxFPEaccBaoBF8Ssxv6LEAqlcIjZgFH6B6xW1M6187hr0hm42?=
 =?us-ascii?Q?9J16DxBf956EUdujp3JBBmvxYfEl/1+LVBsKGjlLubJrOt22NP90gJH8uvdo?=
 =?us-ascii?Q?kcmdHJ1tJHvtfsw+86Meh2aupmzNNHFinLcDtcewEUw/A9tu0TpTyauaRQ8D?=
 =?us-ascii?Q?E4JPiPnhnj/AQH6WYLGAJ4P//zJ94meYW/V2BlhPuvvgqX1b2xzHUus9Iu9s?=
 =?us-ascii?Q?kjvj+bIgK4WqU4qScX+zJ/KHXrEjxeAlMwSWBndAPQPEJbV3ijuBwEjtTRjU?=
 =?us-ascii?Q?ucBPDsgcA8zkqBguhh94OopEkKhtsOHtZrCgmbBBOwZuVe5eLlV81RCTYd3u?=
 =?us-ascii?Q?7XsJed3KFrgMDHA6Eu47/PmQtOg/S+pIt8II+4WRahph6EUFJN1dvJQ4OKmk?=
 =?us-ascii?Q?5CPt7ToJMVqEgK9+yKiYYdTVCpOQNbNGc1Pk46/3kJETC1Q66SSx5ViHuHrg?=
 =?us-ascii?Q?Yb3cDFkFN0rIBOys6yPJYN7K7Yo9+qIN7WtmHq41p/P3mtkRj3imkW1yHq3N?=
 =?us-ascii?Q?wXa9NlC1YiHdeCLo/QaZ0xTVBKLWVTQI9okjzMr7UA+JU7TxWGjm8JImRB/V?=
 =?us-ascii?Q?95HVpPtRIhB8oxdGqM0TOm9jgeFgCfTbaxqzITEzpphpCA1zCCgl9Nga638Q?=
 =?us-ascii?Q?bGdQzTyeimQ/1NMHNDGwt1JObhANRa2UAPvIf6d4PVRZ2YUJNoW1jkxyLuiH?=
 =?us-ascii?Q?F0KGPLoB74Cvv9Cu9c5zkFqnM7H6DLrezIWBh/YZw6CU6BvUT0uPYm1qMvE7?=
 =?us-ascii?Q?IXMOLS0WumDBCHrr2XEz7DLcw29UX98+LdKRo2r4g7Z3U0qCOB2lrz1WlxEL?=
 =?us-ascii?Q?MMQsOG3aeUob1JoXaVrS3tt22tlXeEdtf1HayeECg0jkweTGkEj6Iqknsn3N?=
 =?us-ascii?Q?Dpcy1Ltyc/tUp7ElnXG0plxl5IwybcbdFlsxd9hE96aG2Rk5nqQftGbTMQxH?=
 =?us-ascii?Q?0LdsxPblZvIQPNb8wJ4r97gQ9VQxNC1jr2Gcx/THrrziZCCYX7p2u7+qa2FL?=
 =?us-ascii?Q?xAgp/vWoG9FerligjuB7sOro6dz13cHfEccSbDajOxlhaQrmesjWlgX+7acc?=
 =?us-ascii?Q?/H6TTqZudFgksiBnpfiPyJ7cx/M7y/Q0f3/IIY3KdqiqJLbyKFwmAZY9wQMH?=
 =?us-ascii?Q?gzvxhCtjZbjwb5aBr+nlmL4deFlIJvQMs6L3jhExF6dIEHGQkUr7VP6XbcIy?=
 =?us-ascii?Q?B/TSN2mcUNDcNufpKWbKGOZ3S5NOa2paW+SfL9Wl1Ll/eKgIjv5wk5rvQGNC?=
 =?us-ascii?Q?s9sr4Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0df665d-8412-43da-a5a0-08ddfb6b3d85
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 13:06:57.0677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ju9IqEN7rClB+TZcGEDjvDqlr32gaUAPp8x+3VZrzVJ0OyC6PJbBIKtsEb9ubQ2q8ui8RZ6XF25oQ+guipE4ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10457

On Wed, Sep 24, 2025 at 10:09:26AM +0000, Josua Mayer wrote:
> Unbounded loop, perhaps use timeout.
> 
> This can fail on unbalanced calls as you discovered,
> but also e.g. when a pll is unstable.
> 
> See below for when this came up previously:
> 
> https://lore.kernel.org/all/20240218-lynx28g-infinite-loop-v1-1-59cc5cef8367@solid-run.com/

Ok, I can make this a 17-patch set, no problem.

What happened to your patch? Did it get lost? Do you mind if I write a
new one myself, with a single read_poll_timeout() call for both
LNaTRSTCTL and LNaRRSTCTL, to keep the functionality same as before?

