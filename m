Return-Path: <linux-kernel+bounces-804655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F102B47B20
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 13:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97993A5917
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 11:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBA32652AC;
	Sun,  7 Sep 2025 11:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R8jrUdUZ"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013061.outbound.protection.outlook.com [52.101.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46ED1F4162;
	Sun,  7 Sep 2025 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757245973; cv=fail; b=Jd8RifFWHl57qiqHvf7r3EZbz3pCaryTIM0ULXq4odEDSxTZBZAaWkbOb6Qzn6IA/ezqCOJnz4IN71QPJGv70O773K2DhWwPt/Gr8rOdw5aXVuVHUfZd4UM8RHooRsB3J8SHXECFw8uysGeMzOuJ1ZDnrzS094btlLRuKuyJHa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757245973; c=relaxed/simple;
	bh=bJzO3SxZdeQFGS2WOKwVU0zTJJBMkAUz+DsvdU+zdpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k81A2+95k/hLYPa4X6GSqqD6hzx/Q7wLoIQ0drU/nNe9Sh65SjVvCyYn/vtxel+megrjtaTjp4Jf/W0soTtVlcBJW9Piurn34kFmqWq6ANXYTyOfxAtU9Da5xJ+rJ+w3iL3cnoM0qZQMYYdZot4xsUo1v6+hIc+jZey43O4vHeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=R8jrUdUZ; arc=fail smtp.client-ip=52.101.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yh+9cvMqfAon6g3ob8LNNL4DZ5XgM9MWD3MR2SL01BtLkFOFPI4ohUXsrPId29R+0aj1g7fn+YOo9I+2nx0JHgmQdFFxyy5ozbZyrH4OPQFX4OQxkXLalkYY3Qs8SjkZAtQF8UVXs9D3VTWWYRir+DAXOgDVCjZB0L2o5CVVVnDZfNkDhToufurDwqT23fV4obQL4A7KMWmWDBmGxYPztDH7YnKDk3CfF9ApBF98M7lZRisLEMPLdgOUoc/uZ1KXjNaCYwwYXwrPz49O+bUvH43nlgzmGnZnmPyGI0x0uca28858RTF6KAUxHl3IXTmmiePq28h0GEI7gJ93adP/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tmWEkQ2rY4W3kwKQKqKcR21WT9Z93lqB1wJu57jdi8=;
 b=FEouFuLSxzkUs9/y8JQHOISMC74jlFdH1YFXEuCWC9oFxiBwCguMu1FgRBLmufBZhfRuz4gVgSiwZkf+pPbxLlk/F1lGQY+AQHF1cGRSR8WY3HmqZ3pwnm/K65j2Ir9UcvLnxoyh9WsLMaG8Q7T0UktLOI5ibA9gBu2a7BRr8xmDAwVwMMD5OB9rG/QFIK85dPdmO4jRQFy6oEeyz0RvdQiPHyqedBYnWv3SXZvz1rKkehUOo6mTXmSSDJsuvHhaCyBQkKy1CGFyN0VHtH4PkUxqBg8cVe+ghgwwUdHWl20SPt6ZLso56OXaG3GMJA/etlKl+jW9yObCI5h/QTC5PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tmWEkQ2rY4W3kwKQKqKcR21WT9Z93lqB1wJu57jdi8=;
 b=R8jrUdUZpV3dpwwKHTgB3zOSyW2pQkdfsSGZtmUXJgwG6FpqHcxPu975VE4DlrgI0JplTgOt/xT37Zf0trTK2+uDE/unKZhZViep4KwlX34JbwmXVzamH3AkYptucNUrT/Jyvdve1UQ0yiATUsOODW9lOwjxbHq9uo42okBYvaK4dLYbCRc1vRNFjrelNfEC+PHVzIi97XjUMwCeDFj9AxtZOkzRFn5ZrVit20iLL7BKRLb5O9sHZI4P3j7MLTgTq6z8GZojwrbhJgezMcJhJ5GKc9N3XHOnJC6IBSCXKT2H3jSRYmi+XyxuY+VKa35gMuNY7ub4QkSPf8LWHBsZ9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10298.eurprd04.prod.outlook.com (2603:10a6:800:21b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Sun, 7 Sep
 2025 11:52:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.018; Sun, 7 Sep 2025
 11:52:46 +0000
Date: Sun, 7 Sep 2025 21:04:09 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Brian Masney <bmasney@redhat.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] clk: Introduce clk_hw_set_spread_spectrum
Message-ID: <20250907130409.GA26925@nxa18884-linux.ap.freescale.net>
References: <20250901-clk-ssc-version1-v2-0-1d0a486dffe6@nxp.com>
 <20250901-clk-ssc-version1-v2-1-1d0a486dffe6@nxp.com>
 <aLdpKEwfqP448eMd@x1>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLdpKEwfqP448eMd@x1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10298:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b89f9dc-a1ee-45b3-fb2d-08ddee050f59
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iNbm+BEWcMMqYlEi4Y67/tLZOxOmZS1X6tVSgpqO2PXTdBX76Are4Nlpp5hn?=
 =?us-ascii?Q?DxtbdqrpJci3SaJSNAOFC/TXFjxGdYAYkqXd1BFJCGV0jWpuuUfsZD/ZDZEU?=
 =?us-ascii?Q?KQjC8Uv+zQn/5uMstz7lPzU2uxPNNACIWB+OG1GGfn88/kRFvx3C4uKurl+J?=
 =?us-ascii?Q?A2yzu61Z1+KF+/AWPyn1+y0Cy7SrLgDvVxC3lrxS1xiwyHES9e3fIX4d4SAe?=
 =?us-ascii?Q?epwoE/RI3MItTvPmSUejBwDA7HVSlch9G+QxDLIa/bYg/7MQhJmYz+i8joFq?=
 =?us-ascii?Q?NmsKrrVJc5f9f0ujkCTTpAfPDw55gUKKXvfH4qeLgtK5oK/ZoJbTB0wkhTKa?=
 =?us-ascii?Q?y6ZKG+Mn4BJAjtpQHP8MyuMS0LNWINYTcBgfQ/uEIBvTXpKYXeX2zy5i6Ahd?=
 =?us-ascii?Q?UcM0WObt/aTrmXTJIUfFpYmJywmR/gtDuAqB4kc4+6oWuvB88xCd7takyEIe?=
 =?us-ascii?Q?wnQ109Fdl2mZ1k/Vt3bJNQMNNW1BzP8sCCKd2cYL0/tE6Xj7nFKrT2yel4k/?=
 =?us-ascii?Q?FodUCWnR+JK/vxujOOCbjMnRDHxB6hpTEiSKdveLy0diIanevbwfOm6vGnPb?=
 =?us-ascii?Q?M7brEI90blxRv/Bpih6nswvSirslENj64/TRYxwUZ5q6TRC0Ed/8Gq2g+2p5?=
 =?us-ascii?Q?7RaykRARtsmYHuux7nqWML+X1YrBVLuOpYIB+eJrMoR4WMPWa8yL68J9fM4r?=
 =?us-ascii?Q?o9PEFeHkN6RWIOjclwUpmMaXjqENigd8BE5MdNl1y1dV434BJ0a6TwRmP31V?=
 =?us-ascii?Q?eujyfU49btAFny1CM5CwQsN3VZPQYOyxxT/9NLEDeAKoT1Yja8xhFYxFGymZ?=
 =?us-ascii?Q?g+2AkEkxx8Xb9zMQd6GO44nAz1P4vh6uYGDa6aHnV1P/OkHd4oc39yCLqGVJ?=
 =?us-ascii?Q?rcad8LAlaJhfC2GPIE4/73zIVKBkIEtmtadl/zNezd+bX4LIF7EW/Ko2xFS7?=
 =?us-ascii?Q?N6ptkmZeIz4RrqqSSJ2YvHG9ZVMxCB4nLd7BLHMA7wype1426UHTr/qP6UIc?=
 =?us-ascii?Q?6qSpTYgq5SqdpMwsIuSLQyye/0HVglKq/0Oqj5NYYkYLTDJYymSbzslZacDN?=
 =?us-ascii?Q?Wl/wiv1/gDap78wt4lil9cPHClB5cBmLiBRiiTwfuUk21tGli9I/4dCEt7wd?=
 =?us-ascii?Q?kKprQdneE0FDfFjrqTJhnLOl9jxhFE7kH1mvj1KOQJaDhF8RjWMPmRnwnJNH?=
 =?us-ascii?Q?sNibpcVlvtL+VgllH5ixNxztTDm4yfsB4q3dIQC2kVd3HCz8ZqfIMfoGhA2/?=
 =?us-ascii?Q?B9AaxAn/vWpFKO0xv6G9Qbu+z7Hft/yBf7pwXwrAAh9dEt7i6xL1yVGV8gP1?=
 =?us-ascii?Q?FuVhOzxTSjHAj0ayY/d6hGFXUFvlzqUIewiP7SQ95KtGB81ZXB+gLL4Lscc/?=
 =?us-ascii?Q?Ka0iBUe2qLKG/K0zLBHjLoT6y/HDnCCVzoV+habZoNLzIiCtYIETZO7a8Qlg?=
 =?us-ascii?Q?DNrpLZu9hDSfQS8M8SfhmtMwJFc8L47XWdh7vpUGkCQF8HOjTVDrOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jp29QXcEZkpIe+A9jnwmfFvW1NAtP/dGIMdrw+zmio1nW9M6lLvzj56iW0Cy?=
 =?us-ascii?Q?kxGHWQ3jdhefWiNJx+iUNg8us4aVGQWevTk8wp1AcGwh+msXiM0Cif2Z8HM9?=
 =?us-ascii?Q?1B2BRM/EIWxRshl0ex0tn5dMyw+fpoTAqiQ3u1xxpKT8zLkk0A9QmTL2SP6o?=
 =?us-ascii?Q?gbCoFdHdghPp+TcDRR8h7CXQVItA2sAxTC4JFkH8jxClh1Nq206tAcywtvbJ?=
 =?us-ascii?Q?GS0t1zfyP4UEvUfhj9zKFnSAcdVZ9HrQ1ioQabbfe6DMui9B0SDULx6D9DnE?=
 =?us-ascii?Q?Zy6yoyY0u4yVhI3A/bVZe3jw9w1VgN1FQF1++PZkGbYXyNU5V0zpiu3l1Z6Y?=
 =?us-ascii?Q?9N16ERD7ExEm7YFcELlNSTlaMyyvAsFFWpRqiBrXDRymfl5may4NUav78dMV?=
 =?us-ascii?Q?3Jhaca57rWZLPmXPpDcU8GafHwfpFgseKduGNzR0h7s5U/66EJDXmKeA/K/X?=
 =?us-ascii?Q?rCwzB+If19lNXxt4DdD88WhtB+wfS2jaEmZKO3zK6ey7hs0IY+Bb3tD6HtMP?=
 =?us-ascii?Q?aa7EYSWMbmP/DkMXsUPVo07uVUqSemBIjUqZYRTsHe90x8evHCeDC/mGXhz3?=
 =?us-ascii?Q?LDJxFypjQsBhYfzwSKX2ZROq+vKwknsdnvG0MgSoYTtqxbHNM1GBb2DoiW/M?=
 =?us-ascii?Q?HFQtjILmIp8vUMqMUlEXKr5csWTSBDnrk//wQ26zq7o9GARMNSLq/kV3+8Wy?=
 =?us-ascii?Q?YS5sM2wmyfRnlkXKgmsTuJJMjS1sDDmSXIAeTM4XAj5StYhMsGX3waa8b+D5?=
 =?us-ascii?Q?gDTVeFjnF8XNV8ubIykHXrmDrZ5YZoz9Unq5rT0meoKCWv3CEO/eJJ62Zqpp?=
 =?us-ascii?Q?AGGpJtInfqONENpgEm2uVK5unXm+j6vv/gk2iLO3+KuZhtyQTjm8Bm0tjz+X?=
 =?us-ascii?Q?3Pid5VnSLZyxMqYJSFHZPaXg/FmuGXMVB4wyQ1KM3E7jAB/l5+hOSEoOKSJR?=
 =?us-ascii?Q?tRp3Hj4Qu4CnG+1XXo2xAUik1U1P+jbOZEyGtSLBsIYzL8yEwh5tgf3yHgcO?=
 =?us-ascii?Q?c9KB84RJhxWdmRI7eeVqZWwXHc7G7loWoDONoUzFCmJ6Asu3jlIkISHCapkF?=
 =?us-ascii?Q?SXdj/tBB2eHToZRBmVYJBbzLFphko393XKlaYhVFrhVRiAVTq/IZhAsmmtsO?=
 =?us-ascii?Q?meoDifo55hcIwB3lTviFWbDunEr5rgCA8ioJ5+6jTXTpZiOefOvhn5HW6PPc?=
 =?us-ascii?Q?s+pGl79hAdiW4b2fXTuCyh4E8IWbTm8uZ3u1FYrkzytSDJ/jLLnfsD6z5GTi?=
 =?us-ascii?Q?2R+R7ZPr9z4lFzVzDSxoALW+8Ag8vji0xgLGAyFBY8/omDTdLAkkKfU2lSt2?=
 =?us-ascii?Q?FCTVd4xgdpjl/QNKoctgRCiqhz0gWNIl+gCCdCGBFkD6x02lTDQM58cDG7sP?=
 =?us-ascii?Q?yKPLdvy0tb8uQ3VY6fUpvGcaIjqX6bA6rdvkd2i2o9ftUBHoY3xWdB4IwvP4?=
 =?us-ascii?Q?Lw1eXqk6Q2UHb4KYBD//758GiYjBOsJL2Ta+Bukne0Q03eef+95ijSniAecB?=
 =?us-ascii?Q?5wBnt3gVHfVDxZGGtpRQ5ifhNydC7J2TkOGgZCKR/c/CWwHFC+GFTWKtisOU?=
 =?us-ascii?Q?q4Czty5yr6VZocKm3oICo55moaZLkA9G6u5uF6A8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b89f9dc-a1ee-45b3-fb2d-08ddee050f59
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2025 11:52:45.9249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ElfNGvX1YIXUqKD1KcSfrhzZ+jiiaMo/nuycSr9s/2MX8kKm29BiNDdgcA9nwd3wmd+SWY2q9bn0kopUCZGfHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10298

On Tue, Sep 02, 2025 at 06:01:12PM -0400, Brian Masney wrote:
>>   *
>> + * @set_spread_spectrum: Configure the modulation frequency, modulation percentage
>> + *		and method. This callback is optional for clocks that does not
>> + *		support spread spectrum feature or no need to enable this feature.
>> + *		Returns 0 on success, -EERROR otherwise.
>
>I think it would be worthwhile to call out in the kdocs that this helps
>to reduce EMI. How does this sound?
>
>@set_spread_spectrum: Optional callback used to configure the spread
>		spectrum modulation frequency, percentage, and method
>		to reduce EMI by spreading the clock frequency over a
>		wider range.
>		Returns 0 on success, -EERROR otherwise.

This is better. I will update in v3.

Thanks,
Peng

>
>Everything else looks good to me.
>
>Brian
>

