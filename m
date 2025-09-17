Return-Path: <linux-kernel+bounces-820902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD614B7FA4B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B84A317F3E2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81BB2EC0A2;
	Wed, 17 Sep 2025 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="muKUEBsa"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012022.outbound.protection.outlook.com [52.101.66.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4882253AB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117007; cv=fail; b=ZBnQQxc07ES8GqKKUb3Wm/dyZWwkAnihqwLor6DFaNVQC1Wx4ZaFsT8LdLxqot/5nP4LErhGL19MR17cQo3O/dKNWjq+yrja7+TzBLyGVIp2Cu4191+fwUkWMZSs1KmayARxfrAB8Ev3SYnlVJ4G7S2TU9SJe1dICQdq5IZChAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117007; c=relaxed/simple;
	bh=dMyTqR7+tkan1VaRVdOUQgLhL1aNGkmE6dgfb3VsgP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nK7JF1eE+wjMAq8dALWKsYnQ7JU2o6ndIs1Hd5NDFjm38dGrk8E2TxHAXtIc+/G9BEjD2FWB5L59cZGLKfNtCo3CkQq7WfWoepJFUogm6PpgRbzPsi9Oq1mlHBmpdOPiteU5AnK5fxtBx7EGa3BswXbsdevbUqnUv9b2kItWHms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=muKUEBsa; arc=fail smtp.client-ip=52.101.66.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvxSB9kaslkM2HmllwbGrztqKK6WVpRD5Gwip+vYf1E35hkuZv9gSWDDywxKney8aEP/wtSdqhLNohrnbshQm0mJ6/e+shpMn9d6jS9ovq6iMkiqxeHisalDneyQMzit/wvfSRoAl+bsYAV7VAQEGJ5CGTi7iZoTgLjBg7aaz2itcLglUm5xR/gMC7wZ1z7+RoYLjDlosVInoCQm9+OyGdM6ZcHdUsnvW01KAvg7AmaB8CcZJKwHPIdsI3hDijUiUMsogmsuPmvOTSHCqqlE/8ClHw7rS61Mzx5sjr7kCfjcAuIUj1swEj+jgXY0whSmuLlsB1lkYfwkqqN9KlIA5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYhaDAlZnX736holjwY0BXw+nuPy03/dZ0ZU67Zlkec=;
 b=iZy08n5q7IXhhdtgsWxay2pWlFbh9ny1jPbV5G6AuM35RJjz8PlA9EduTMzPOEOgxeXko0FRRlBiP/xnHswzHswjcqNooRxVZ0PGeOqBAhEXnz6j5hInyTXuTt/Mct0PpnOv3XxX3rTytCc1DsX2tmipwiBQtjMUdbxOXyAXl0heBNuJSfnYpUTxVPnajyORw+FwBhFmDJ5eKcck6wsnIqIUApfpPsGupE3njV5W2lhlBWK43DYgF6r0O9FctdICjZM9ln3uJb0ZJIr3eIoJRTM1WxFv8AnHr4CLs+an4iEcNmCaxFMwLHZtWwiwXYO8t+MiZ0s2TiWDVMxRehtTbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYhaDAlZnX736holjwY0BXw+nuPy03/dZ0ZU67Zlkec=;
 b=muKUEBsaakGCkgbtxBxhDO4/Kh11kbmB26zv5aSvTJJ3AwBvzTTBRVdCocM+hdNRuBa0U3rhLyTbVUZCGNK9Az3n4jEcj3aWHye0PvA8RJwLBGWAruX8osJJsO9l096WBmB1GZEt+kvRHOxWCEgf08IjUXHbJklYitMLpwStvYfb2a3GFDXjp4Sdhea0MbR4Y2g3ZG3DnC41onZzxMxABNNu7s39VYfMyuzeZDAGT1vXay6beMLSwZ0/MODouFS4AjTNsaR9eFHUaRshx07HB/rM3SzHHzjBrCg8VeCsxEbz6u3SDZNmt6ERJSK4y5+KnA+NlIMIjIqChIg5eUFe1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS1PR04MB9237.eurprd04.prod.outlook.com (2603:10a6:20b:4d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 13:50:01 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 13:50:01 +0000
Date: Wed, 17 Sep 2025 23:01:35 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Joonwon Kang <joonwonkang@google.com>
Cc: jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox: Fix undefined behavior in of_mbox_index_xlate()
Message-ID: <20250917150135.GA28673@nxa18884-linux.ap.freescale.net>
References: <20250916153455.2527723-1-joonwonkang@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916153455.2527723-1-joonwonkang@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGXP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::15)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS1PR04MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c2abdc7-1663-444f-3ca5-08ddf5f118f5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3VJeTpNTvsHl0GwDEBwC0gr13x2xOtEo/WyT7CWSm5lQXm7665YPQHMKSB8K?=
 =?us-ascii?Q?Zi88BTQMmPH2wCnbGWeENyjfft1cgAIk0zeu1folxsFsOcxnRcMyixwD0Ukf?=
 =?us-ascii?Q?ucvucxHHV1gM0Y+YXhRQhkJBVhiALNBfLOEZD7uFHNwwHZR5UQ1i0HtFCK4h?=
 =?us-ascii?Q?ppYHz+fIfRlHCvXJSPlQ6yCbICz14bkBB4qDO1H/YfsyceoHbaJ2plcHFH6s?=
 =?us-ascii?Q?zoTFLdkQ5fztvokZ4CsFl40fHnl1Kv3d7oUvvIMS1+EJ6xYW/JjtM0BQV6iA?=
 =?us-ascii?Q?MdIn48yHYKc3a2JT8GbAVvoqIHlVbetdWAr/AxUUspbnHDkZY+HaG3pom5+u?=
 =?us-ascii?Q?bqddMAnvSnWD0WGj+ig+q3E/uL3/NBQIQq1UxpG8agbKsVBuxMsGyHCpeaEO?=
 =?us-ascii?Q?c5MMdJEwDQ8X/dlGWpdi/tkXgva92oFHk4O+WWB7OOKgrUaC1o9AJYz4S+VC?=
 =?us-ascii?Q?4mgjdexm2gaawWEe5mWbpa0oIxpvzXX7ryFQM7jUM/M7O7e9I6VIMDON3+qu?=
 =?us-ascii?Q?gJMXWRf5gRMC1OsXfumUjLMYGURTaSFvI33TvZGSlQCmlF2M8UErkmCKls0B?=
 =?us-ascii?Q?GIe6/nrmmtfU+I3iKsNmQv4jVWl2wrylrI7g+UgUnvqgYcrBNv5aAScaRTb0?=
 =?us-ascii?Q?3+PrucI8srPshB2EL9ey6TwWOwXMytjuSZCo4m8Ew4v21WAyFXs9lCxdFYwj?=
 =?us-ascii?Q?ZZRVgXq5nH99GGhIrH+s1goSUZZkAbGbAz2kTXAdz4tVelClgzRPQuaoyZRS?=
 =?us-ascii?Q?g8wBtc/LNxFALC68mDOmvQK5cKmUqs1+u4SLvbg7bViIlTpC0NZJhn4jvM4g?=
 =?us-ascii?Q?sQsgt6i7xqYqYGTBhBCGpIYFp5gcIsr6/b+dBoVv1zPHJUTJiFEHpYnlPAtA?=
 =?us-ascii?Q?84/TGLg/ku62VwHirK5SDbXMOglt4A8lWeb97DGhFxLdIehlgcwcro+QsfHR?=
 =?us-ascii?Q?dtmwk/COCAOuzFNGnuI3t353PQKdQLmPMW7r8NIPQjo/0Enzj4JcLu980IbB?=
 =?us-ascii?Q?R7C/rspLyCaselLdcsgHObBt1jvyeZP82btH+zAtB+sBTdkyeS/VRlTGSFOL?=
 =?us-ascii?Q?Rbn7YiFbJ3+on7RcvAUN6Rj7Tk8mONyuiDWP1szfywr+Gzoa/0H6YvRGFrd+?=
 =?us-ascii?Q?IoXwsC/B1cbnMwk57ttwgekB6ecCNwkE8r8N02UV1onIcR+2ywlJ+4gji/dJ?=
 =?us-ascii?Q?MxJI9y8ozg8wRV0yaCXNyGKlkku3lZXL5VAHwuJ5weRbqAfpPezEcW723xcY?=
 =?us-ascii?Q?p01HGcX/SU8c864iBY1rIZTvV1wHKNBtPwgbNEUX4J3Usnu1Bmf6XDd/tcIA?=
 =?us-ascii?Q?ADTKJbVnG2XVw+NnguriJUZB3nzQphX3cNc5c9jrC65TGSP0wbeaCYrqYP0R?=
 =?us-ascii?Q?iaSmWOWH/caWKH/AUdzCZBZIN6qgeHoRFzhOdManvO7cjpmge9l8eBg4h+wb?=
 =?us-ascii?Q?fwcs1nEKz0JTdITb0rmDDe03HSKIKZMFWztiGMYkl5ySQVl+JXUKyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zXRAYMMMkqxIZ1g5fDKMILH9tzmWNApHWOPN0X6uXHI3GL+EzfE/Cl+x8lQu?=
 =?us-ascii?Q?JZd4yK9hHlFxVtibgCuc/ayk/JkvFfFMd+403MbN4yxCEzCLVOiVEgpOgs5X?=
 =?us-ascii?Q?S91/zfDeQifJ91J+bLQxyP9eMn/D9rIeAMGdCmlpY8YGGrbZCI5dclGrx+Xh?=
 =?us-ascii?Q?7Y93N8S674APIP8ClvmtGtK57SXaOxJtZKJxETXmf1ZH8ftwDIAYTRBzXgu/?=
 =?us-ascii?Q?e/YX+X5ZWj/tU95yg1jUcu2IkNVDGCRYQ97+g47nC6YO8ODGNZmRIEo2/RwJ?=
 =?us-ascii?Q?Z+knMYc+TlALLvtpfniq/KexSQ/KdlRLccO64UhhWFnEVshXbA1ENeC0/sWC?=
 =?us-ascii?Q?Zce5kTFTPCKHz+5E4fxDBz9RbxGWrH11PSq7viCNvwwLXbcqDtnZTqz9LioK?=
 =?us-ascii?Q?iEsEgawB4vMorpuUpiT9ZHClG2Rfp65yBLxaLQAA4BhMZmRd2gjlIezSHL2A?=
 =?us-ascii?Q?jgeB4UGRh+0kC8zIQ3gylYnGwWyefnkl1IAannyHg0LFoKRcYZ0s4PwBtWwd?=
 =?us-ascii?Q?z5PWPZAwDupIl49ywgygSvtPyVgmwTbifwo43Otcy7BuoZ+BzsjTWMgb8e2U?=
 =?us-ascii?Q?g3YbqPwmeLmhM3OyFNrTTV5EIEQKHym//5EYnGqia9lmLBNY6HT2K58wnQKa?=
 =?us-ascii?Q?bPURCVGQ3BsMfp2kaxMAEdBTiE12N1p1qAFjBNajOro6ZYQi3oWWUac+8XbS?=
 =?us-ascii?Q?aOZg2/otkCR+2m5hV5/6gbnyO2aSAvaupPEM0qUxMd3lSa0kgChhTUyGaI8O?=
 =?us-ascii?Q?CSFY4Pl570tZW8yHr0bJ7LmQg/JIhGlPu+8zcz/0KuJAnJHciO6kFD+FQPcI?=
 =?us-ascii?Q?GkYv2/mbeVfSfm96J6kWU8vvi6yhZgLCCA3mo1RebrlnSN7RKE0chmmlOACi?=
 =?us-ascii?Q?VfrvRpJi5/pBew777TG8o9qAluJC5WrOfbVyG1X1GmnoDb1Yq9Xpq9xpk9p7?=
 =?us-ascii?Q?hyw4r6WMZlHrc4GtH9gYRPHvwV6ghfK+JKD+zapPMEZq1v+O53wNHNgp2P+U?=
 =?us-ascii?Q?fWmtEBTOdI23qk/2LlfM5ee3Oiz4PY6CNmpDYHyEYi7UE8fGo+EnaIvYsKqt?=
 =?us-ascii?Q?HNaBAKqpb98LDFnyYhgL60Bs+A2DVd0EjEYOEmKz5aFFlCx8+660D30F0z/X?=
 =?us-ascii?Q?Hhbo6cF1XpTOhAy2w1dwKyUDR7Uc1cfuBaxpRLbcdwEIfsLNKzRY7KqG19m1?=
 =?us-ascii?Q?/IoHQS6sGmBh3NkdLSdxLRPRYs/BphdIDo0tvZPmhmeif1bh9ucqGx/l2Gcg?=
 =?us-ascii?Q?1hmK+enHGesGj8Q5xQJSY1Zsv0hxlBw24nMslzIJscd2F2X+Aez2ssGOgnet?=
 =?us-ascii?Q?AbTLT75L64x3fCXdMz+qx0l27Ml0Hsr/Dbs0tXWRR7wvE3MWWPX+EFgGv1/d?=
 =?us-ascii?Q?VaYEs4aeDVbax/64Qg7FVtEpKGAP7kXfqPbIs7Kj0VjuqwSmu6Iq579QlbzI?=
 =?us-ascii?Q?gLlmCaxHcMXe+7SiaxkJ1ZEl71coMapGvZBeyAKhWEmM+bWO8AaG8z995TLL?=
 =?us-ascii?Q?CMYagO2eo1AXYEt5xV+4RUYx0KG8lVtXWaakk8+YLxQWFcrXZ2Tfypyd3rey?=
 =?us-ascii?Q?vaM5YTkAaU6pHkHtr/xTxDUUtz/jgXpBt7ASgjJV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2abdc7-1663-444f-3ca5-08ddf5f118f5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 13:50:01.6840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99CWkKPTSRaj3lI+sfIOsBNNC1Aa5wxXZVR4MS4YT8RbtQFpDlfjab4r5VM3t8k3nztIdFI6QxJUTyWkSLedwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9237

On Tue, Sep 16, 2025 at 03:34:55PM +0000, Joonwon Kang wrote:
>Although it is guided that `#mbox-cells` must be at least 1, there are
>many instances of `#mbox-cells = <0>;` in the device tree. If that is
>the case and the corresponding mailbox controller does not provide
>`of_xlate` function pointer, `of_mbox_index_xlate()` will be used by
>default and undefined behaviors could occur in that function.
>
>Below is a problematic control flow which results in undefined behavior
>when `#mbox-cells = <0>;`.
>
>```
>static struct mbox_chan *
>of_mbox_index_xlate(struct mbox_controller *mbox,
>                    const struct of_phandle_args *sp)
>{
>    int ind = sp->args[0];					// (4)
>
>    if (ind >= mbox->num_chans)					// (5)
>        return ERR_PTR(-EINVAL);
>
>    return &mbox->chans[ind];					// (6)
>}
>
>struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
>{
>    struct of_phandle_args spec;				// (1)
>
>    if (of_parse_phandle_with_args(dev->of_node, "mboxes",	// (2)
>        "#mbox-cells", index, &spec)) {
>        ...
>    }
>
>    list_for_each_entry(mbox, &mbox_cons, node)
>        if (mbox->dev->of_node == spec.np) {
>            chan = mbox->of_xlate(mbox, &spec);			// (3)
>            if (!IS_ERR(chan))
>                break;
>        }
>    ...
>    ret = __mbox_bind_client(chan, cl);				// (7)
>    ...
>}
>
>static int __mbox_bind_client(struct mbox_chan *chan,
>                              struct mbox_client *cl)
>{
>    if (chan->cl || ...) {					// (8)
>}
>````
>
>(1) `spec.args[]` is filled with arbitrary leftover values in the stack.
>    Let's say that `spec.args[0] == 0xffffffff`.
>(2) Since `#mbox-cells = <0>;`, `spec.args_count` is assigned 0 and
>    `spec.args[]` are untouched.
>(3) Since the controller does not provide `of_xlate`,
>    `of_mbox_index_xlate()` is used instead.
>(4) `idx` is assigned -1 due to the value of `spec.args[0]`.
>(5) Since `mbox->num_chans >= 0` and `idx == -1`, this condition does
>    not filter out this case.
>(6) Out-of-bounds address is returned. Depending on what was left in
>    `spec.args[0]`, it could be an arbitrary(but confined to a specific
>    range) address.
>(7) A function is called with the out-of-bounds address.
>(8) The out-of-bounds address is accessed.

There is no need to write such long commit log to describe the issue
which is easy to understand what it is.

And the subject should be improved:
mailbox: Avoid out-of-band access in of_mbox_index_xlate()

>
>This commit prevents the undefined behavior by checking the array bounds
>and matching the types of the argument for correct filtering.
>
>Signed-off-by: Joonwon Kang <joonwonkang@google.com>
>---
> drivers/mailbox/mailbox.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
>index 5cd8ae222073..6ed53868c83d 100644
>--- a/drivers/mailbox/mailbox.c
>+++ b/drivers/mailbox/mailbox.c
>@@ -474,9 +474,9 @@ static struct mbox_chan *
> of_mbox_index_xlate(struct mbox_controller *mbox,
> 		    const struct of_phandle_args *sp)
> {
>-	int ind = sp->args[0];
>+	uint32_t ind = sp->args[0];

int should be fine.

> 
>-	if (ind >= mbox->num_chans)
>+	if (sp->args_count < 1 || ind >= mbox->num_chans)
> 		return ERR_PTR(-EINVAL);

Regards
Peng

