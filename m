Return-Path: <linux-kernel+bounces-791415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7464BB3B68D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6664417D3A7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD302D480A;
	Fri, 29 Aug 2025 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cIQ2dRta"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013059.outbound.protection.outlook.com [40.107.162.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15FC2BE646;
	Fri, 29 Aug 2025 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756457869; cv=fail; b=EIZ7Qw8lkI4K1XmG6pcSJsYjc73C2dOVhCY36uAoWhz9bov8p9OxEN5TuBGFprVtnDfXFlKI/X3fVpOLw74geIG99QzYwGX1SWv1nTVI1vBCkpnrZRlU/cZOH6bTI/23fEJzPY6SQWGkRqtagLsCzOMLm0a6ed1f5O0WOmA6gtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756457869; c=relaxed/simple;
	bh=lJzXcZ41JVUmlZBhGsDGL0RcDuyeStiDy+X8sfQXlzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aXRhgfPW/TkuDOjMDUmhd13RMMrTmP8Ryv6MsDdQyWerfOsxPHiKi10njix5EcUWEYk7gQgh1wOFOWFSyV6Qug8W4KDIPnffVla+ut3oQCZ/aIZrEHIFoaisg3TUOyDxbwPESgANkbm2OGks5WTDvXJzVzQkYiQMYfK88CqbMmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cIQ2dRta; arc=fail smtp.client-ip=40.107.162.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aX7qj3bS/7YV5fRfdmCoiPTUjXlp/8/qLnIrpr7JAnsz1uZBZMwt+yrE7+XTYecDG7TT5Iu0sE9d+vx1YuDDrQXtuY/lkT7qX66DmEy7dvRbaPWLJbS3/proUkQ8npenjnS7uLu/rqd04myz0DoVh9mUam+CSILglVVpuEavrmfwO+IqMfD2PEpQHkE85dA0p0apTVO852GZSdgPMIy+x0yp2zUcoxP9zM3VEBBoaOfENZX6zQTm5ziJfiR9bSEl+RA3yF9wLcC1SK5weOmxiF6gMHf/88mYMEfjkNobZvAJfnEX1wlhRIHAKn9ZQ6F3kk60EzTuHGYnEiJf1id8VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJzXcZ41JVUmlZBhGsDGL0RcDuyeStiDy+X8sfQXlzU=;
 b=CGMjCCcEwb04Zk6kJ1aeTLIId3RT04p4ZHfwFTVHUbSshMYVdgxe1EbvA+z6rXVO2dkRfH3sN1dYiFR2roToixzPsyXMTiR041xLsWBKEPoW5a/jDs8fXiWC5B/q9DuVr3vFXwjR4VHdaLFfT6gu9CZGPoxa1p0iXr0hXAtOy37ZnzkF7Xv+JOGjniU2PcjY91eymPoGMFVUcza5WQMnsMGC5h5ZVqKVkU8ItFLWziwEZxNhCXruFp8d4HZ7fW8em2pLZfS4/WjLzDxNQkKHzH2PWSnAUK07vPF7/Oo7V8+JfFIvI+lzjMzCyhSZJQlyTmW6hXdUxBGBdtFRHOb4EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJzXcZ41JVUmlZBhGsDGL0RcDuyeStiDy+X8sfQXlzU=;
 b=cIQ2dRtauQTRtYPLNPXRVufzv4DTiFw8WrtLNe7A3cuuN+KUmGCAfg5HacMXVM0Xrc0/a4K19awq6jYgUX36g9gbV45MF/1R3cq4QyUAUsWw/oNhYeaUGBjo5q4hSEeqj/jlRE3KpdJmglFFpMkFv2tY6ypDLUl+Z3X7QMBdyJJI2usQ7zsZTwiJxm1qMeit5D5gcUDuzOtsLTQ7d+awk3E6/n4e5edTOoMc8svA6zr59rQOLnXlDS6cT08eNUEmlQZkQM++2toIQrMVUumPWXM7z+s9Cy/hyqAPYl0GhJy1izXgpBR//cfcj7MBGq9urWMSQSX+wKyRWSV/4y5c0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7902.eurprd04.prod.outlook.com (2603:10a6:102:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.9; Fri, 29 Aug
 2025 08:57:41 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 08:57:41 +0000
Date: Fri, 29 Aug 2025 18:09:03 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Brian Masney <bmasney@redhat.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: scmi: migrate round_rate() to determine_rate()
Message-ID: <20250829100903.GB16625@nxa18884-linux.ap.freescale.net>
References: <20250827-clk-scmi-round-rate-v2-1-3782a50835ed@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-clk-scmi-round-rate-v2-1-3782a50835ed@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGXP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::36)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: d3de1493-8f61-4946-8fd2-08dde6da1c51
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|52116014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0bEHdqJojeSXJopxzhKxaNddREPawDslQa0sSu0VWj9RXOgSF7BM7TH+9PQa?=
 =?us-ascii?Q?7j6uEHjeO880NLj+VgH+g1RTbzrAJgljFh0q6rFkErLM9CLU/udMSre96JTH?=
 =?us-ascii?Q?YLYXxpZtgV4iUNmoV1MBDUCn1f5KbZUvcLQLTDAZ3Onq3HfCtVBtJwMUpl3E?=
 =?us-ascii?Q?K2e45Qmetibz6de9d78WZmS9qbG60M+6XNao4inAzAJhRdx6l27/4AYpOYpW?=
 =?us-ascii?Q?1kQFchm4X16ZdQezHbphdi2JmxJ3AmyNGnf9B0Vdxh5wSMGhOJQY7anafUJj?=
 =?us-ascii?Q?6PoqkJxshhzASGAet2YT6WBgFFY78nCwA4HON+4d12Ce8RCDpaPKOeuBK2T1?=
 =?us-ascii?Q?vyCSAErw07nsLXPOM+vONgitxtb3CoUqLFQkSOGLYt287fV0eA36Ytb5knP0?=
 =?us-ascii?Q?NZhI+F7tIkTDVM96D32kaX2IqGJPXTJcUYzkbCISI74/83p/KvAeNA6DqfiC?=
 =?us-ascii?Q?cE2qdRFEvLvDwcURvPsoKWfIBvzIWWENTWz9T4URb6BVoeOj+vyMRURR+tiS?=
 =?us-ascii?Q?ihvvNGiBQgqti/jTEuEg/u2T69l9U5LGQhm0GLKJScCICpd6T7Vqdbg5Pjvc?=
 =?us-ascii?Q?E301LVgufrIrj8tVzhhxtgYgV7LBQflk2VNDSOFtbCwIFfQu28E76JFIlzN4?=
 =?us-ascii?Q?rmti8rchi9NQQBgmpD/sh5kPDeGNsX34d5qRTt84sg63d9C8fIuqRDMe50g6?=
 =?us-ascii?Q?bF+sokWT+gWHnYq+6E3wRKBO6z+zjbPuLfpXZIc28x9C/jkYdgeUnNVqYrKu?=
 =?us-ascii?Q?zJnKfwUjjLDNhmRlhUds1P3JI0F26QCeFPoHJX0fFo2DoEo3+JZFAvxF2jW/?=
 =?us-ascii?Q?3+4083/xQwfuZSIrTSxgoepD+2cpIodXvnxXJXh/BzXLrlXDgWouK7hqLkmW?=
 =?us-ascii?Q?PM0ejio0kgGYU/DQRU+WkZN5MJUFODwHArEHL9olciHwV+qXQSdxRd0uRIy6?=
 =?us-ascii?Q?8WnNeqQjXrqo6BhSN9EoyMjMTAHYRxO1nXiZfk1YAJCoaRgicikHFt1dzu1q?=
 =?us-ascii?Q?PXlv5jZ2/0FYFwjL0RtFvCmJL531ODcz6LHx66RsDzEcAK3ptI67Dpw6Suaq?=
 =?us-ascii?Q?96sZ0lWnZX2dNMgCKEQ3u/P9qZzdk6/FIvKTDXz6cHm2h67z/SaMEQUOcj5I?=
 =?us-ascii?Q?5Z/SqmIV3RVHra/j0NGw4FfRPtBx5ktGep/J8Xd0geDhQIUFz0ukb4JlHBL6?=
 =?us-ascii?Q?531PH4A5ztM7CquNQiEHYkrLPJAhMLuxX2dsHBH9k44XzYUjACn74YR39aNO?=
 =?us-ascii?Q?x9RChCXJCeQ7r0ysW5oGbnyosyHpQi7RNSkWn2VsGmgvJb2RuZ1lnp8FD+Bq?=
 =?us-ascii?Q?Vfn0y1+/ibHuuI50c8Hr51O11PgRPz/iYYLTB+KHWidjAVE4Ny+kzbcOVPgF?=
 =?us-ascii?Q?HxuZKP1nTqn+eGe19HpyUdgVSWkQfm70hwxEL3+bbL7IklACsdkzqGjRs0Xr?=
 =?us-ascii?Q?vk2HBarYE9O4dGQDgOXrW9+RVWjBKWYUFru7xjmqfTvQ5HcGe7K5MA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(52116014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bD+mA5iHvAaj2rntEPpxlY93Y+Kvg6Hg4523ckusd5PAibZZ9kHKy3WXlirw?=
 =?us-ascii?Q?WqUMcYTwZMr2IVIlz27lBohg8YPTHUAYaknxQmBNpMMkeKOl4YxQjLkkfkEz?=
 =?us-ascii?Q?PeFzM2DHrmiFuk37P7mMRVcSjFMFfG6CJDh3CQD7XJjMKYo4x3DWxHJmdjCY?=
 =?us-ascii?Q?v8fTKEtE/bGsw7eTFWFAVaTul1FE4jtCtpDFZsVK2qWOoz9h0xi8gIz3FKrA?=
 =?us-ascii?Q?zlj1kwWpVmCpvy+q33v4X8aJ2Ntw1cRaOBhLP5/HhFiJTYD/NEDEjkCDFuSz?=
 =?us-ascii?Q?+rbvtmR6yvxeMFO5BW31ZKXSoOPS8HzX4P3Xkufkxi01jBSU+24LwLIcSXoM?=
 =?us-ascii?Q?MwtikDmzXYgRzZIPpRfkM0kl1c9DviHCRl3lws3xCtRjQT5917Y7oib3JBTL?=
 =?us-ascii?Q?9zcAQnd0aluiz38FryugicfrUnoouegav1G7N+qnvlCX1C/BHeHD4EEHnx8i?=
 =?us-ascii?Q?FL3RJm4DWE7xGu5iNq0hKK0YWJ0wh/tGbgUmXT1OrDCJ8iPoLN11Iie3hurh?=
 =?us-ascii?Q?iriEV2Y+VQ1yPdBBaxOh+1w2rbaj6uF9VkxhSSIlGdBYU07/EeQBSM3VBiAY?=
 =?us-ascii?Q?YkjsoSnMP8Tu8228sR4lsxsThTRYDFg8OWoARpADeQ2LFNxs62SMxiPazxyk?=
 =?us-ascii?Q?ofYCnSFzrzRd8w8pZCVewZH1Si0y6w8QefPz8ql4PYI3+RDh7brQlkwm2Gl2?=
 =?us-ascii?Q?5Dis27qPwgl3N2EKs/eU9I1ssC3xvQu9am4pU12WDsF03SZLnJ+9yjtS1tMl?=
 =?us-ascii?Q?gNQZ8K+KaSrjAsdddMnRyh2toMS3NR+VC7qCWLrfGgzx5Q2vrxZ5tBlcpERf?=
 =?us-ascii?Q?Ufg25bw5WL7bUlMZIiFzbgS1vyeqi2d7F5luk/ZNLNcM6ganI6cAS46x3O9t?=
 =?us-ascii?Q?arf63fyjsJ712kiDtpE4bpveSRwfVkakO9UeAOneWftFL9bFLA82tU7SInZp?=
 =?us-ascii?Q?SVWdsLSPocMSvW98rcDEMElwx5tUuDakR+FKMFt7M8ogN/YO6sK5Nrh1qBwj?=
 =?us-ascii?Q?aJif+TxsgqKxmznlWMRxfhJve1PyDwNG8QzeBAtYzuoBhR8envee6Hry/+Oj?=
 =?us-ascii?Q?O3ERqMy2mueszJxD1SKJas8dde49rw6omugX32f15v71mWOb3YmbbUA+miSk?=
 =?us-ascii?Q?k1I9i8ihlBRNM1JLixbNkozmVh3ACEY+J0lxWT44Ycvek2RMIi2H1FiNrqDx?=
 =?us-ascii?Q?r11p/XFf17fuCWzMdMNBm6MU/ZL91ebv6Qxm8tNKnnssWg4AL4AyQ83Z//f1?=
 =?us-ascii?Q?Vbx4KZxhlmWZ9Hox/m6YutO3nbljnH/S9Jm4VQ/ZD4/6CUALau6I8EmgH/uR?=
 =?us-ascii?Q?l+x/uLVMg1kCFfjZEjhEs8CfNrTju0H6IxIdUIC+mhzuyYwE4o3RUvnjeNIz?=
 =?us-ascii?Q?XoBhkntIPMktj6ekKTGeVrWDn/ZlRCj5rKd6wTrzvyM1UBn5KIXPEkgsZrqh?=
 =?us-ascii?Q?zjGHABgiK/aAgPbwgBOy9Ebn5kBOsUxt9n3DVqlh9BQHI0ISpq5oOitcK1S3?=
 =?us-ascii?Q?sreQKEgfo71YIQpYXUNtHQsBrEA56W46BqehaNa4nc85suIlUUMx3OvoFRxY?=
 =?us-ascii?Q?68LIKqSEKkmEnOVHvtTLdCt+WfAM4m1VIkgzsMzK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3de1493-8f61-4946-8fd2-08dde6da1c51
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 08:57:41.4311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qgb7CWKGwXe27nYZGM2xQUP6WYiZJwXHHbScj11oRTlGCv/PXNJ+qKBGqpIuFqtnfGFQ9GXIQlFQMrR97WaQ/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7902

On Wed, Aug 27, 2025 at 01:12:07PM -0400, Brian Masney wrote:
>This driver implements both the determine_rate() and round_rate() clk
>ops, and the round_rate() clk ops is deprecated. When both are defined,
>clk_core_determine_round_nolock() from the clk core will only use the
>determine_rate() clk ops.
>
>The existing scmi_clk_determine_rate() is a noop implementation that
>lets the firmware round the rate as appropriate. Drop the existing
>determine_rate implementation and convert the existing round_rate()
>implementation over to determine_rate().
>
>scmi_clk_determine_rate() was added recently when the clock parent
>support was added, so it's not expected that this change will regress
>anything.
>
>Signed-off-by: Brian Masney <bmasney@redhat.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

