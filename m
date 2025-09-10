Return-Path: <linux-kernel+bounces-809254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF3EB50AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 04:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 292057A1E0E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AC322B8B5;
	Wed, 10 Sep 2025 02:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hehpeL5m"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013045.outbound.protection.outlook.com [52.101.83.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6312D1F3B8A;
	Wed, 10 Sep 2025 02:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757469817; cv=fail; b=CRtHfOj/85D0iJJTqTmtduyJwKK3aUHyGCBbyTtKMS7Vho+95kA06H1XoyOHkuPNDcTZr4SeC3P5cAWLvvdhdqWtlfkbmTa9gstQEwYzKYlGFU4T/TaGCn0Hxiue9W30Rrvvot+bPFua6awF6LoTIIqiHl9hiRDpLdGCLNqszPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757469817; c=relaxed/simple;
	bh=xb8YrGJPNM100arYgCFdCGMMZP/2Lj+9mj+5PrHhXVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u0KgilvYmAQsuV7hkhgHKYu/xtVkNelipyiDaQ8gcCTfimTyRWssu1hnxtDBgcKBp4esUkwDyEbCimGtgylyaT3o4PPZyPtAtS/2YtmlIFt7tXJCGPmpyUrzuet5+MKizook0sEiFuWvytdgkdtEkrYLoF8mSHGYj8zuj+nxdgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hehpeL5m; arc=fail smtp.client-ip=52.101.83.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddvMsuLfHdEM/e4fUSH1GjAZu/4Pc64LQMGrbA96lNiuNUM8/KQv60aeUwble8VWoRHcJ5FpHopdFOXF8lJYc6r12Xm8mz0Nfp7jsnSKDuRtAKt4irzxrziTpDiRUpf2Be6KCD0nX7py+tsPcOCqkCyqhbHNfn2wLn1cYS4x6K/AK+B4/xQte8Pn6GQSujcbpLUsn86wNxxXXXyI+zCdpIyvKrN4lNk2Z8UP94nGXrh2f9gAw4DQpUbRkDW3D/2jiNzBJ6kuEL/0DiQSSJ/dVZRQ1VTSAeo/XREi7l9LWw2q5c2a8zZt95FSXxoucVjeRHHHfRtrOECWy1foJpX6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRknlA2K1eNOXlh2hrTNKcmhhfBuUGS+fb+G+RVVCkk=;
 b=MBkf3IKRs+DPC51j/i0c0/IkfqJQbPx9ZmJjy3Rilt9pKeijbfyYTgQQC4hnvw5TIbX16xjgm595kfNmIAk4lUhro+VW/3G0/rB1/y+HP93IpP0VtaGrPsy9bORI0+28P6dr4GqbVGoiAkkQOSZaEIOgZwOuLK3xB/5fsd/Zb4Be5wCenXfxoZ+v/sYzA5FoSBk27naV763F9fo4Cpl4vWzePeyk0K4Lc+xijncbpMGKbK6zbUF0X8l+I6G/xOjoMXHCR3S3JzAGdafm9KeK+oX+eZEyT8w91bHpn2ZITaK+hNwrYHQerHytjV0sFm+JtyqlhtcnO/k3DHlxl6z1ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRknlA2K1eNOXlh2hrTNKcmhhfBuUGS+fb+G+RVVCkk=;
 b=hehpeL5mz7yru9lp8ELbe5kvGsvfSK4uB9/PS2StS0gkZHfZK1ayyIUX4+JowHdZ1ukagk3Fdj/sVVDYCNuRXfDbiFfTtP12S9qSsbAKY+uqMnaRinwwsouJrM02BBJFRQpYpuBeA4jFs9YrWc8RPSzGQqP4DctrPnXbx5Z+FK46AeQsqT2ucqPmAH46lg1aKj21j3bCFNzgqeehsLigXCcKCevOFmPXLCFt3mRPlz/A85LpLIS1vPY2FT7J6dkAnKvZcR6IBvu0DePg7nW6tUOX1ru5F+TTcde3tw1veSgKeLsk9cIUTeLDWaiqev/q6kzDo4ZN6KgKvP+btUXS9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU4PR04MB11316.eurprd04.prod.outlook.com (2603:10a6:10:5d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 02:03:31 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 02:03:31 +0000
Date: Wed, 10 Sep 2025 09:57:33 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: krzk@kernel.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, 
	robh@kernel.org, conor+dt@kernel.org, gregkh@linuxfoundation.org
Cc: swboyd@chromium.org, heikki.krogerus@linux.intel.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	jun.li@nxp.com
Subject: Re: [RESEND v4 1/4] usb: typec: Stub out typec_switch APIs when
 CONFIG_TYPEC=n
Message-ID: <sd3icq365ndmdw6jzo2xnlc5hkir5fb6po3fd3v2ahtikre4jt@hnftxhiygpfn>
References: <20250908053335.36685-1-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908053335.36685-1-xu.yang_2@nxp.com>
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DU4PR04MB11316:EE_
X-MS-Office365-Filtering-Correlation-Id: cefec5e8-70d2-457a-6f90-08ddf00e3d7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|19092799006|38350700014|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mXGPY0/V/fjh9KDVQlwn6iVkWuItyjuOAqXSc3rNHJNi4rdjyeObstroMwCB?=
 =?us-ascii?Q?0MmXKJ7uEdc395qLPxBHvt1nV2XcJGxwmGXgJYRImzSK0wfDNbVmi5n4FjJC?=
 =?us-ascii?Q?7avHr3Ee3KxVq/NHnl9zS0ecwftUjpyor/3EZhMzCH4Hi09WrNW+Ir/6f+s5?=
 =?us-ascii?Q?KSsucLTCVGh4Io8YsBZ7pYLQjviuVf8Ht66tQGiQSp1713MsYYhkffzax2tu?=
 =?us-ascii?Q?lYjeXOUa3TBc/bhbR47WQGoX7+3nnIo1UIlIEOyAxzz4CT30tYcXmMOZJpB2?=
 =?us-ascii?Q?jeN+Agudwkxo7vasLsgaGDwuCJ4odUKBuExxF8axoGhPaX3+ZybnNp+AOjbZ?=
 =?us-ascii?Q?cYuMAo+WTOCgZSn58oTSVuH4AuaYqs1NsUTAKLJdbHCiBJ8cbHbAyTs0Ns3r?=
 =?us-ascii?Q?HplBQYkIm8Vh0JPRsUbWPttha7s1lCJc0cD6GN2mzZIAEOCnv0DGbsm2JvSt?=
 =?us-ascii?Q?prwb1HXPu2UuGnwIPrv70IabePxeudBi1z4eSjysMKCFNzeJdwFMTLM0kZji?=
 =?us-ascii?Q?5HWHtU+kc+VCt9OhYbdi3ficMVN8SU6jO0hQHH7YIFvSsavMuGLqi0NHDz8n?=
 =?us-ascii?Q?WGGOl3knzrF4v/4pL0Z09YAMKxJZgOAguO6bCcBmXBIYa1+wDFtu1h3Hx6tQ?=
 =?us-ascii?Q?S1imPiXIeJdsWDwRFehsvvv4WQHzzXAYOVE7t8GW2P5kDE2NUXlS08nqR71F?=
 =?us-ascii?Q?xkJwv9ge2AJfUDZpFl+KabmuRlFc7iAXzenpDLGdb/7lvtPF1T+Lcu0bFbmq?=
 =?us-ascii?Q?fxxzx9/E2FIMaAaLf7XXLGwsc9TuGpW/2ncEKDg+SBoU+2w4G/NZHoS3zwAX?=
 =?us-ascii?Q?9Ro67GqabBnQuowwOwIeY7p6HKoHF6MP34ac+kNdGkyHLgK64u1HbLKv/tzY?=
 =?us-ascii?Q?ouHNCY7aO4pAPV+t/nTx6FkcpgywSizcfYK/Lm3ZzoXBSuKijU2zdGE2XwF0?=
 =?us-ascii?Q?ULfxHJH/YXAIdor6XSL6YKnfsm7GHyj3v0PiWpzmsP4+8wItz7BxkjNqpex2?=
 =?us-ascii?Q?Xwn0B+S/dRESI5W4iUrZaxF39dr3ql4ubYW66S4YdRYZgsJTJ8atfQKPTEGj?=
 =?us-ascii?Q?WWTj3z0Xmnq2UujonUVIq9SXSSf3BqvqK7XcVe5KomiHbM9Ou+F4PbSPEZWa?=
 =?us-ascii?Q?XCokfKdRypG0VJf2gxigb9lmBn0L2jeSf1Y8bSN1ByEWZ9w2x+yTtPCd8oAm?=
 =?us-ascii?Q?59xusKo77pSrlkHQCvlA9zBcdlN/Tiu8aGtpazNMMgz4lztyOI+dL0pLFWXd?=
 =?us-ascii?Q?vKQRJ/CMkgAPXcXL1UZgHG1Gl2FDprIm1nY5kGdpUsAbLhHTgocra+6VTH9E?=
 =?us-ascii?Q?KnHbPQ+MYosirAEqkFjFEzLDRFsttvktuj9ECpQPKvQtWNibyTw3d2nytSK/?=
 =?us-ascii?Q?wPLkztQnxjCUJD1KT6gctv5TLZjAT5F4XbroO8k8O+g1NGhB+gjQZEAUjYXJ?=
 =?us-ascii?Q?dzcm8n9xbp9xBqqImK87s5FrTQ2k5xMCbU74dVzMO7dACLOyNUxQ1CzPSUy8?=
 =?us-ascii?Q?ZmW84xpNueKFmScqW89GpAfhk7UyaqO9v8Su?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(19092799006)(38350700014)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZHUegCFQaYTchAYgskl7//rvJs0AtrmFQQN0pyH0mdjcJS/2TtO7i0lGbO3V?=
 =?us-ascii?Q?jzULJ9kerGZc1bKq8sAEEluFeB9Y7cSVcg89DMnD3FWoIO6GB7mEBiyTPbVZ?=
 =?us-ascii?Q?7f8k1j8AdX/vvoTofBT7W5TzcS6qjkIGmio8C5V3C/3L+l7ib0fLHy1wq8No?=
 =?us-ascii?Q?BZ0B/pHS4JOnMrWcHoDaZ8LZA6lpLlrojS0OPcW1oy+QS/f05cjtRGF0F3wa?=
 =?us-ascii?Q?nl99H8a5aCrzqVHcySmd76k+UUzLcpNc7L2s+33uc4TE8M/kwk0nHqvIBEVI?=
 =?us-ascii?Q?x7yVOrTGaPUXWmQWDKYGcqMShdIH9KIRGs770OvQunz5wu1hguK+MgIdaeLQ?=
 =?us-ascii?Q?5bxHMnxSDtVqIh9rrWwpEgOg5oD4jNuUIVgx1aDbEx4RpvwCDZysslUQDviT?=
 =?us-ascii?Q?3GMFBAI9zMwlEBJuSTqPKyqVnrFIaxyxLemIfdXJ8MVODZihSThwwGl9TS00?=
 =?us-ascii?Q?/zFn4ZL6Fbp56me0Vr5nM4lVcW4qveggopg1Kbm8LRYkuosazOwt8cjvBfxO?=
 =?us-ascii?Q?7DF5y0/ec3gFj6iKsYQkUJDqdHSbztN3UOXWf/IqKuxaNihnRhXeuLjRhK8E?=
 =?us-ascii?Q?+1uIIaX4Rj0Bg+PEeqIH/PxMFkCKTK39u+DKCahAZKqQaIZxArvop/fGXzgg?=
 =?us-ascii?Q?lhThbqBsBMSQzw6PwIRiu4k5I8AD7FMBIPjC545RmcFKXU7XCo12Da9vfGAz?=
 =?us-ascii?Q?Q5BMhkWflB6rEHs7nSLDAdLR+7LaDLy067wXKldjU3BGOxM3dWlodLOKXyPO?=
 =?us-ascii?Q?5FHhlir3hMeycbiclY6DGgygqQTLlfSR8JbxVoy239TYmVOVoaima28PhaBT?=
 =?us-ascii?Q?6aPiNN43STP4ApuxunAPr8XOsWFkBRlg6IBSrvfVwuL/kW0QIm8rAQZ/GEBR?=
 =?us-ascii?Q?qLHx1hKJAWyoCKgznEQU0k+sxJnd2bY9fVqmI1PUhTPHENTPxYeV8k+LebMI?=
 =?us-ascii?Q?zWbG7xur7vfdgq8BsjKsQ7SotNq7aB+dGmy4vkbRyKPemFAkgflL+6FRi1JM?=
 =?us-ascii?Q?2NJ0Damy0U70m5iuR5mOzP+Ce8DM1QoJ13vw4w5PeABDTptUhnnzWLJRPseY?=
 =?us-ascii?Q?xCtvGD2i9N5HwV6lj3JtU/lKH9bO1VZRo3FUknUHDABohZpeR+MdWk7Bv4T7?=
 =?us-ascii?Q?S/RVg4Ym0fkB6z5qKLUDCLS2pteq7J7+CdEcG93EnkfUU7UrRg5G1q5+OD49?=
 =?us-ascii?Q?vwKDeH7Aw1qu4QUQke2SYWDuU/aTx5wNIfZq5oF8zzrWQbER0UZ0UPvHvOIg?=
 =?us-ascii?Q?Jk0eGIgIaRNm046pCUwLODr0Q5knIl3rVpcpKb888EEQytREhirnEaQhbixz?=
 =?us-ascii?Q?0rcx9Bg20X23NcwIWZMxNiWKgRTeX32Pu+lF0rL6CEcOa4tWVO4lbJRsFJR8?=
 =?us-ascii?Q?iPc+ZxAFYjWGaStX9FCEi71OUHo6hA7hkLBeW57fW62uOnEfevb1c3aeNM1E?=
 =?us-ascii?Q?bvkqVQE9Yj2FuzbuqoNDUb1WbKsSKIqUGV+Xbo33uCQ8fUgcRjwTVX7o7ybS?=
 =?us-ascii?Q?MKNtvEVCitiKgGeQQXr1ceF1xruBUYXw9r6jcv9qAJKKpxlNdw/TkNEaPM3n?=
 =?us-ascii?Q?yyXk1Z0nkSvDbvXQEycCZ78pw6amWN6pNFSq6ZQ6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefec5e8-70d2-457a-6f90-08ddf00e3d7e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 02:03:30.9972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUIdLaNXs1krj8j9NtvAYa7kytatK+wQjLc1cT6nvTIyZY2dudcRll/aabOS7Y6M1b4nQ4PnUt7nEX603R9LWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11316

Hi Chanwoo and Greg,

Where should the first patch be merged? The other 3 patches have been
merged by Chanwoo, the build may fail without this patch and if
CONFIG_TYPEC=n.

Thanks,
Xu Yang

On Mon, Sep 08, 2025 at 01:33:32PM +0800, Xu Yang wrote:
> From: Stephen Boyd <swboyd@chromium.org>
> 
> Ease driver development by adding stubs for the typec_switch APIs when
> CONFIG_TYPEC=n. Copy the same method used for the typec_mux APIs to be
> consistent.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v4:
>  - no changes
> Changes in v3:
>  - add my Signed-off-by
>  - add Acked-by tag
> Changes in v2:
>  - pick up this patch to fix build error in v1
>  - refer to https://lore.kernel.org/linux-usb/Ztb1sI2W7t5k2yT7@kuha.fi.intel.com/
> ---
>  include/linux/usb/typec_mux.h | 43 +++++++++++++++++++++++++++++++----
>  1 file changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
> index 2489a7857d8e..efb5ed32b813 100644
> --- a/include/linux/usb/typec_mux.h
> +++ b/include/linux/usb/typec_mux.h
> @@ -3,6 +3,7 @@
>  #ifndef __USB_TYPEC_MUX
>  #define __USB_TYPEC_MUX
>  
> +#include <linux/err.h>
>  #include <linux/property.h>
>  #include <linux/usb/typec.h>
>  
> @@ -24,16 +25,13 @@ struct typec_switch_desc {
>  	void *drvdata;
>  };
>  
> +#if IS_ENABLED(CONFIG_TYPEC)
> +
>  struct typec_switch *fwnode_typec_switch_get(struct fwnode_handle *fwnode);
>  void typec_switch_put(struct typec_switch *sw);
>  int typec_switch_set(struct typec_switch *sw,
>  		     enum typec_orientation orientation);
>  
> -static inline struct typec_switch *typec_switch_get(struct device *dev)
> -{
> -	return fwnode_typec_switch_get(dev_fwnode(dev));
> -}
> -
>  struct typec_switch_dev *
>  typec_switch_register(struct device *parent,
>  		      const struct typec_switch_desc *desc);
> @@ -42,6 +40,41 @@ void typec_switch_unregister(struct typec_switch_dev *sw);
>  void typec_switch_set_drvdata(struct typec_switch_dev *sw, void *data);
>  void *typec_switch_get_drvdata(struct typec_switch_dev *sw);
>  
> +#else
> +
> +static inline struct typec_switch *
> +fwnode_typec_switch_get(struct fwnode_handle *fwnode)
> +{
> +	return NULL;
> +}
> +static inline void typec_switch_put(struct typec_switch *sw) {}
> +static inline int typec_switch_set(struct typec_switch *sw,
> +		     enum typec_orientation orientation)
> +{
> +	return 0;
> +}
> +
> +static inline struct typec_switch_dev *
> +typec_switch_register(struct device *parent,
> +		      const struct typec_switch_desc *desc)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +static inline void typec_switch_unregister(struct typec_switch_dev *sw) {}
> +
> +static inline void typec_switch_set_drvdata(struct typec_switch_dev *sw, void *data) {}
> +static inline void *typec_switch_get_drvdata(struct typec_switch_dev *sw)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +#endif /* CONFIG_TYPEC */
> +
> +static inline struct typec_switch *typec_switch_get(struct device *dev)
> +{
> +	return fwnode_typec_switch_get(dev_fwnode(dev));
> +}
> +
>  struct typec_mux_state {
>  	struct typec_altmode *alt;
>  	unsigned long mode;
> -- 
> 2.34.1
> 

