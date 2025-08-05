Return-Path: <linux-kernel+bounces-756971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C28B1BBA9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3956212CF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34CC23FC4C;
	Tue,  5 Aug 2025 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YBbsJewa"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013032.outbound.protection.outlook.com [52.101.72.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB93F1C1F13
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 21:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754428488; cv=fail; b=dYkI3HX8vRVwnzHy1pJ2usJydBgKtbua+n5qF4wQasgzofnSFFBCR5CSE3ODDYuOtWMpsV8g2/bQZ6zhKCmRuRxFRrwPSTGKozjlTc1ZxuYiwxLeBBdmdnKzfnzsmAJoKXJFnqIqxKouq8im6mXt1Oj9qFsjSwCHPBDN+ojda9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754428488; c=relaxed/simple;
	bh=wfKFXFM1HG1yZ8l/1JLL1l6rJB25f6B/jwlTjRKs36Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sglnCCguMZMKpgnSR2lx0UHqWffalTlXavlm7Ufg0pY/NBKqnTbbq+JMV6m4GxTHhephysR2YvdHIDgUczZaMx9Ykjkyl465bwNjRSauMGaoPe9MXPfeuYQdQQ8ZPxqrfUxGBN1iLWGx8k629a5TvlcVmISTbkykTJTDkHfe1R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YBbsJewa; arc=fail smtp.client-ip=52.101.72.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrmFNzWb49NUTLy6LjNDlAroORRX+dfLD0xZy0Kp9YbftNIJ6DqBQ3f8sWIUV/beIXH1SwGetC2iN8+y+4m9UloG+Oci4xeeT6cktGrpX7FJXX7LBscpHeFpy4hVesiA4w0bMZjw85oMuhRHxve6TrKDiupQX02LidisI2n1hjOAbb97D3BcckpkIOzW90Pj0bsyTAAIS2lmgONiw+oeU9qqrO5ue68b4LV4/9I7ivJpE6Jr6MMhjr6rt4LQ0ocIpth1A9W7dX7QVax6hDBfD4OLoIq7fZH+9CWZ4aqv7eZb6IOpSiRJt3+IjUmeiq7FsmPTEgC7vNritxcCktq8CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyZtWbP9vm9kp5jkxbSFeD9O471u1BcriJCXYr0+S6Y=;
 b=AVVQVq3z33CVxr02DAxIVdF8Y658iH1iBBlaKmfaTBrnALoe/Ymy7bEAmSthFniTgb3cqL3wWw88VFD20ZLB7CXchWZlsbPx+0yvgCfZcjuXtEdTB4FXk63+wHoGgsKHTAzdjzAQ9MlGU4S2YudRnp33SdSZm0gBB0vJSlJkzYUIFZXbsmxR/N5DgBdttsoXmMduvgxUrW6woMHx+bw0bBdykHvpaCg61G+htB4KzBESXvAcE1p4C73G4Q/74NSYpZ2tl14Q0VaZKr9GkJKqs2a947XiKXj1NHoC+IS8f/jnfgi9l9bvPpXeYw/p8ErBCAOIz6TNP5bRwK9uxyMVfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyZtWbP9vm9kp5jkxbSFeD9O471u1BcriJCXYr0+S6Y=;
 b=YBbsJewaVjC6xgxw6AfcG4yEtevKuo3bkf4oebT148n+os/dp5EgphL/yMsafQRutEuIoYcFi01iDb3Vhrh3kVnWME2DXe3VBUJX/9bXnl7MCJ0AZMv3Ug6TODH2+03wFftFsXK1De2vwX3m1sN795pqE7sd4qw1/Wj634+DQ8Q+Q6MxJBWLTlwV/E3Ep+sIaFsV9IEcSjPiQ074dx2WdQ10VPhf0iC/+eHRyK5QErps5yLNuVAEi1TmK0IwMwpUD0ajEf8xEP9CDRumUczB6bD480PrEuOo9Md01ayYDJVOUdt+2UoKiEK6HWfET+0PWSG9T9+bxzfnGo/gg67CjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB11007.eurprd04.prod.outlook.com (2603:10a6:10:582::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 21:14:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 21:14:42 +0000
Date: Tue, 5 Aug 2025 17:14:35 -0400
From: Frank Li <Frank.li@nxp.com>
To: quanyang.wang@windriver.com
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Richard Zhu <hongxing.zhu@nxp.com>, linux-phy@lists.infradead.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] phy: freescale: imx8qm-hsio: Fix a use of
 uninitialized mutex
Message-ID: <aJJ0O2fZgn5kvOIv@lizhi-Precision-Tower-5810>
References: <20250803061529.2303291-1-quanyang.wang@windriver.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250803061529.2303291-1-quanyang.wang@windriver.com>
X-ClientProxiedBy: SJ0PR05CA0188.namprd05.prod.outlook.com
 (2603:10b6:a03:330::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB11007:EE_
X-MS-Office365-Filtering-Correlation-Id: f82942da-7c85-471c-0d7d-08ddd4651878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wMexXjnKsTIdlddOVpeWBA2HtLdPICnaanArPm8v+z5oH1TbWzMtKz1mg7Ly?=
 =?us-ascii?Q?5gZfwOThW8Bu4C4U0u1sVcMiOHdHSgY56pG86Fv2Pdbsmm5w0m+yI8n+aRZ6?=
 =?us-ascii?Q?ZZ+htN/hd6AZ9epdhm/hk7Qvm0bNNQyFzX8/BtYCERX3f/Vxnao2Tk/NtWBN?=
 =?us-ascii?Q?x+DwoTRADvrW45OEJxMLwEDD1Y1lumabQH0Z8Ozln8JOke6ss15ZQZZvcsbG?=
 =?us-ascii?Q?fpzS1+GuQm/0CX27YtBy4dRxNiRJ9bZT5rNrNsxwJ8pseqwgLLS6A6UoJGz+?=
 =?us-ascii?Q?K+C3GHKBpW2rgwqK5dVjEgTzZjfGWxfO621/Cg2q2/QkAflsghSZVls/0XIo?=
 =?us-ascii?Q?d8sMdQpxpY4gSERKbQjxpZqrakbsYSF1nWrelVTGaJLqS6NdiWxcn5rPrlYF?=
 =?us-ascii?Q?yh8bzhRGQUWSP+9h9tWUHJI/ZI9LwpsWL/UxGQWcoo9Jbgn7Z41mbwDOsGHZ?=
 =?us-ascii?Q?BnEtlSoHCUyHTSV/E8dDkku081Nx47AxrVjYHmlWq46QFv07OPlQi9JcUm3f?=
 =?us-ascii?Q?/kXoNoSaBWLk1y9oskAhln+NuEFzABBHnTNrx7HEG2qh8BkZyBXLOW6ub4RW?=
 =?us-ascii?Q?Stj6r9LQzCGboEG1Q9jKKY5IJfPBdWWK+cDx1mlVtAdElwv3P2eBnOh6RRpy?=
 =?us-ascii?Q?knRd4dMzonqiHqPLMBqie8uHxotjOpW0nB2IeJYNDLqyS90J23gXKDvYVO4h?=
 =?us-ascii?Q?PhJSbx1azCuHqbvEFHl7put8TqcXgC5AZKA6QdPf2McK+ys3cx7UeQrSLRPU?=
 =?us-ascii?Q?dcNNga7Q9Tj7TVF9e5B5gATAFhkC5vJBZOR6X+a3DJhgEzCQ8goqllM9xEhq?=
 =?us-ascii?Q?OJcBmUagHKqoI2yAjDfocXOBMVuzE4aSXrpWodmgETZag9JjRWuszteQm0Vh?=
 =?us-ascii?Q?QrUGHgfScuDbok5mqZe2vr27I+xkrP1BHjX1IjiJF+AxkIdHUhD3imKvn1lD?=
 =?us-ascii?Q?FO7YyW57x8WMVn3ivRLH6/ymcOmPgyZvBm7LRkbtkkug3KBG+bLDreHcj7s3?=
 =?us-ascii?Q?sMTn9jZ4rmWbEVLnksWLIpYc8LsVoPNGRxjquZWzRON8LWXediDQVs+VPL54?=
 =?us-ascii?Q?pDrGPJIz4QK9dfiUeBHAIpihM5287amrULTKyWJV6sPeR3e1gTFsqR/pn4Mb?=
 =?us-ascii?Q?KunJWrYu6XHLpc5qOsqKdXNllS9KVQTMx5F73vR+Rg/KZ+WPtQ4IaVchJ0OY?=
 =?us-ascii?Q?dPWuW+V71q5W62VNRezvAVTRt4okvBpw2nBHZkD55ubJR/ylVQO26B5A3CoR?=
 =?us-ascii?Q?Yl1L9ai3xo7Iifvpbs1ythfAhg0LxL9svfAGA68P58VgKSu2mrj+MWRuBa9z?=
 =?us-ascii?Q?Ct77o36nkYIoFlLE/FXAxacGaxhv5OyuVzH9q4xdTmgBFjny9Lt2IsyCC5E1?=
 =?us-ascii?Q?vh3+sH/NNy6245/hfRNPH+6TsLv43z1frFZTzOJDe5ZtULukLnVvzvNytxg0?=
 =?us-ascii?Q?H++r2StEOj9eEEsUUwu7Zu13zgLMLUsYJmyx4gLiH/CNrmriF8/XgQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B7+0OXITv07ujUrOpp/5IvLU7uHKRLJ3/80bW+ijKz/uMYIf8mr96vGK8988?=
 =?us-ascii?Q?pi2joPIkezwe75An14TKyclzJQqdaRKLlbySi+fighGzZ3Cr78+Nbrl4LgWy?=
 =?us-ascii?Q?MzbyLMhsUQl0BhDJiBLNhSxJ7iIZcuzVviSd0mBGZvGu9+cM8JMXK6pokDWe?=
 =?us-ascii?Q?Z008h0YOF2abo/FibnYcZ4XCXZPGC+4XXli5ZAkY6v89JBi+JKov7/+xVj/9?=
 =?us-ascii?Q?//RgH8Iea6uPYWn1y32LsjvoLFjEoxY8QfyVsC8+A7nOpgNQszVDShfCWR72?=
 =?us-ascii?Q?ANXNAA9W6dkAk/gKhkqyhzMIJHZV3hPtwGloCSsN2ntAIHjgM12JOXwo/ytm?=
 =?us-ascii?Q?QSLve6aE9i5giE7eQqHy6zMqN9ZVLR+tiMx8Ae/HFtWJ4UBlStVnT3XCYPcX?=
 =?us-ascii?Q?k4GhOcTRHpQpV5ejGrQBs5rxvy4gJmIrcuhkdHmng3pHCJAETAHTz0tgcDKf?=
 =?us-ascii?Q?z9HKSaa8DIROJXofNk+XI9g5ReOk8QYmmMXb4/2sgsHk6KjW0MrzFlI0oR5a?=
 =?us-ascii?Q?hP3zXQtosCi+wtBBAXGGd9/AQnUIDv2w3ZExAQBd4iE90sWewBB5b1/DK+xf?=
 =?us-ascii?Q?h5XGACmmCiTpS2xYqZKfChq8HJcgSaOgw0gLITy5d+nPZACEwWWin06vKr0R?=
 =?us-ascii?Q?OlJDDBs/oiosQTaySygknp3q+jvxjDYFxeLNIchOAQ99VaLYaVNfxrr34erU?=
 =?us-ascii?Q?G/RbuFkK/XY1hZruKZYUuJHLoqoBBMRhZa/wpytBi9TrJ9jSGsGnUEvCf+b/?=
 =?us-ascii?Q?pIWmcOxv7RehIh77NFY95/G3DID35+OtEXcEmEaJdNk2c+f9gFDypPXjbGTf?=
 =?us-ascii?Q?V16qAwuxeiJ9tiUpmp/A0OB5G6/pPhTGWukcurxsmsV/WE1KIPr8+Z+ZxKuL?=
 =?us-ascii?Q?apHZHOakb+zrvDBttvIqk9/dptBaQQOV/Dp85Ar78Z7hQ6VM58M+TRG9C355?=
 =?us-ascii?Q?YeY3E/TgPB5xUkDtYiYR7cKRuDIH4iSrUA0wzoxDF2aySUXzWFJtLtrCKOu6?=
 =?us-ascii?Q?aWfeTqLruMG8E3acxIvOQ87n2LapaWqqhKkJWXJ2H0+VzGE7/XG/o0SH+ZOz?=
 =?us-ascii?Q?rSzrFBWnqUw/bT/8fb+QtM8yCZPHjUyLrY8tHEE+rFXAWhoHQGfX6/nLGtA2?=
 =?us-ascii?Q?OlZj1bEEYIUHWtAzc9UQ381QgUns9YRxDMOTJG+UdPWY917zCn/fNPOb6hb7?=
 =?us-ascii?Q?HEl1mxmmSa91KACxIpfVZ3/lDIARZ5y0TCmYZdFRCTz5138EP4U+t2jzyrom?=
 =?us-ascii?Q?xo14McGoLDaO/55/gA9aPJeVX8K4dHB/t+SeL7BFJS/T6sh2LTYNp44ulUnQ?=
 =?us-ascii?Q?qlWov5vy2W8QYKN6MEHBCRHA2b/NgKYvhPiav51vW4Em88Fp1Np5XzhhYGJH?=
 =?us-ascii?Q?AIWokyRcHMSA+AmkaSua13md727thbBJTLEypT4tpqGnHBgXdFDvkg7JELjC?=
 =?us-ascii?Q?cyUXNBEZfMEJ117Ysz5DMeetR1abJ2iWn3f0vX3ZZ2JeIKmn+PDkzwN5D31Y?=
 =?us-ascii?Q?EpTEKWxLaUy87qZ0Ovzd1lVcCGPJ3i7ZP9jhAPB+w2Dt+Df1ibUGM8EqIeGp?=
 =?us-ascii?Q?tgtYvEgzK0P1o2VMgHnnmbPheL0NiPMdzk4fS1+J?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f82942da-7c85-471c-0d7d-08ddd4651878
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 21:14:42.5502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqwbzIMDkGjuoB/rh1TnmYA38DJQkljBFEa0oMngRk5yaT5vwg7sfIqNiebWQfBTn2NP0DziZgSqOctZg1I5Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11007

On Sun, Aug 03, 2025 at 02:15:29PM +0800, quanyang.wang@windriver.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>
>
> Using an uninitialized mutex leads to the following warning when
> CONFIG_DEBUG_MUTEXES is enabled.
>
>  DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>  WARNING: CPU: 2 PID: 49 at kernel/locking/mutex.c:577 __mutex_lock+0x690/0x820
>  Modules linked in:
>  CPU: 2 UID: 0 PID: 49 Comm: kworker/u16:2 Not tainted 6.16.0-04405-g4b290aae788e #23 PREEMPT
>  Hardware name: Freescale i.MX8QM MEK (DT)
>  Workqueue: events_unbound deferred_probe_work_func
>  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : __mutex_lock+0x690/0x820
>  lr : __mutex_lock+0x690/0x820
>  sp : ffff8000830b3900
>  x29: ffff8000830b3960 x28: ffff80008223bac0 x27: 0000000000000000
>  x26: ffff000802fc4680 x25: ffff000800019a0d x24: 0000000000000000
>  x23: ffff8000806f0d6c x22: 0000000000000002 x21: 0000000000000000
>  x20: ffff8000830b3930 x19: ffff000802338090 x18: fffffffffffe6138
>  x17: 67657220796d6d75 x16: 6420676e69737520 x15: 0000000000000038
>  x14: 0000000000000000 x13: ffff8000822636f0 x12: 000000000000044a
>  x11: 000000000000016e x10: ffff8000822bd940 x9 : ffff8000822636f0
>  x8 : 00000000ffffefff x7 : ffff8000822bb6f0 x6 : 000000000000016e
>  x5 : 000000000000016f x4 : 40000000fffff16e x3 : 0000000000000000
>  x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0008003b8000
>  Call trace:
>   __mutex_lock+0x690/0x820 (P)
>   mutex_lock_nested+0x24/0x30
>   imx_hsio_power_on+0x4c/0x764
>   phy_power_on+0x7c/0x12c
>   imx_sata_enable+0x1ec/0x488
>   imx_ahci_probe+0x1a4/0x560
>   platform_probe+0x5c/0x98
>   really_probe+0xac/0x298
>   __driver_probe_device+0x78/0x12c
>   driver_probe_device+0xd8/0x160
>   __device_attach_driver+0xb8/0x138
>   bus_for_each_drv+0x88/0xe8
>   __device_attach+0xa0/0x190
>   device_initial_probe+0x14/0x20
>   bus_probe_device+0xac/0xb0
>   deferred_probe_work_func+0x8c/0xc8
>   process_one_work+0x1e4/0x440
>   worker_thread+0x1b4/0x350
>   kthread+0x138/0x214
>   ret_from_fork+0x10/0x20
>
> Fixes: 82c56b6dd24f ("phy: freescale: imx8qm-hsio: Add i.MX8QM HSIO PHY driver support")
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>
> Changes in v2:
> * Use devm_mutex_init instead of mutex_init, as suggested by Frank
>
>  drivers/phy/freescale/phy-fsl-imx8qm-hsio.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
> index 5dca93cd325c8..348fefcfe7a5c 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
> @@ -534,6 +534,7 @@ static struct phy *imx_hsio_xlate(struct device *dev,
>  static int imx_hsio_probe(struct platform_device *pdev)
>  {
>  	int i;
> +	int ret;
>  	void __iomem *off;
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
> @@ -590,6 +591,10 @@ static int imx_hsio_probe(struct platform_device *pdev)
>  		phy_set_drvdata(phy, lane);
>  	}
>
> +	ret = devm_mutex_init(dev, &priv->lock);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to initialize lock\n");
> +
>  	dev_set_drvdata(dev, priv);
>  	dev_set_drvdata(&pdev->dev, priv);
>
> --
> 2.43.0
>

