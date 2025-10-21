Return-Path: <linux-kernel+bounces-863119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F05BF7132
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C00E3BEAF5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0691633C52B;
	Tue, 21 Oct 2025 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kPMQpFj8"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964F533C51C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056718; cv=fail; b=lgsPMAXyJq5NBJbBXlfhw/0t2R74pAYnCHaeEwr1NatCgdF4Zi5lys8pB/5lUg87e/D5pk3b5zoYF+iKQvL8gK4iW3MINdNM0f4T9fVp7afEuBWl/MDl1JB69LRGVriyxex/yi4YEBZ2QX8lFI2JdDvU1BQsycxt84RGVipqo+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056718; c=relaxed/simple;
	bh=qXpoUtD/aioQ1v2XZ674G0UQfw9zBxoIp6Z8V0rxDrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KM33ePl5Cm5Lxq/AfIpZJ+hakJaErXYu54c8HHdlJ4LEUatw1IR/ApPLLOtHst+rdMAfaHATvnv+Mxap0sDjIvHSJtpCmxXRNYRm69g/8h9A8LZVBZ2gmXYK+JDtJK5eHFFSiERjPn8nz+InjFwU63zt3Zix75nos8Horm/mcN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kPMQpFj8; arc=fail smtp.client-ip=52.101.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPRr7mwq+OOprWXC8qqC3JgyoB0VVIn8+aEAawueuOEWQMGM/BJnmiLx/KzI8mkPGn8O5v24yAUaTMAQ+V9wjgzVJbMDqK32QURbdAWb+CofUUJTCQ1/mnYkT9eqsrI+YZl6Y8kpPbzKXP7kNho3cmJe/7Sp/dpHvrb5I+WcNsPojxc8MTcp8PlfnNvHu3/hOyJ6j+a+c575nuActR+UTSxtI8kxtYfpTK4a2YSoBM45+QQxhI9tJjgBdjv7uW0k43f1RP27/7IptYfjYoiQr8sz4uV2P4+G23ns/tEZA7fZ6JGsVGKZ6w+WscKJejAdPAmcMEaoVVDABeJjlXmkKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0wp1Xg+JRo8re+ZpkRP1bSo2E5fZpkk+G0dK7phrig=;
 b=kxfdMqBpjuE+H1Ue7o7ZgX9s+mJ17hMRCAoJ4QaeY49AbutiffmFh+uY1LaNp9yWaXogyVdR1yeaIWX/Vcj7goI9a25usyOPuZT8WGsa7CX9/KAQ9tMqBVHnMPk9PY8QEA6cX0GZ/rj8axI+lAuSkW75mJUxj5qMHdHxCvsqSoro4Jage430be5fPFNEiueUBtKwk2LWvvQkNGkDY/LapKrsrOtVHFzhR02YR6YIkkmJJfp0a2/bJ2Rh7GWztStdHiNoTJ8LZyiLZeiGCie3BV3LbF3TW3w8QCNT3x8q5EmFchl240vYsvtC+liqY/0oqhPqWv0AVOvtUCxsakKScw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0wp1Xg+JRo8re+ZpkRP1bSo2E5fZpkk+G0dK7phrig=;
 b=kPMQpFj8JnOrptmNci2bPUuEBdmjCZoNjdwYqdkFkjQnXlnwR19o8zsQQwGFNqWZJ6UD1FlpLjZu+YNRkppOWbazvILSbwCPkod7Qla4DJ9D9wUs6KnetfPAvByFqaEcdUhl2wv6VxZpRzdb71jEJAaJaGPtwivjk129MpZunzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SJ2PR12MB8941.namprd12.prod.outlook.com (2603:10b6:a03:542::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Tue, 21 Oct
 2025 14:25:11 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 14:25:11 +0000
Date: Tue, 21 Oct 2025 10:25:07 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Filip Barczyk <filip.barczyk@pico.net>
Subject: Re: [PATCH 1/2] x86/amd_node: Fix AMD root device caching
Message-ID: <20251021142507.GA62725@yaz-khff2.amd.com>
References: <20250930-fix-amd-root-v1-0-ce28731c349f@amd.com>
 <20250930-fix-amd-root-v1-1-ce28731c349f@amd.com>
 <20251021122909.GKaPd8ldoGqAf5JPfQ@fat_crate.local>
 <20251021133745.GA3976@yaz-khff2.amd.com>
 <20251021141500.GDaPeVZJ8MaPbtTYv_@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021141500.GDaPeVZJ8MaPbtTYv_@fat_crate.local>
X-ClientProxiedBy: MN0PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:208:52d::11) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SJ2PR12MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: fe020ca4-5539-4eba-1d2c-08de10ada4b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3IE6OjZcJyTuEyu0ohg4PwT2tabJvVeFSl9VCd11ASJ/SUt1GRZafVG5lnhE?=
 =?us-ascii?Q?D5suUtLnq6fUWGzKzSPdh5mooyQbjt7w9dv6cRSk9oTDD3+UV5+/Xt6FxHq6?=
 =?us-ascii?Q?q9ftjGFwfZNzU8bKjGr3qDtOTprpUr3dvq9cf90CJ/nOL5VI2OcVAB/mIrHM?=
 =?us-ascii?Q?hsTtv+fEYiKE9NwUqkw3SB5YxMloAzrqEed4tflMA61mlPw3eghVD+tAy7yA?=
 =?us-ascii?Q?rg3Sm0YUtAngjDigMqUrFoeYc9YRO7yhF/+mMbXQYb3rq0icYorRUcprFbxQ?=
 =?us-ascii?Q?S8E0I/4N4pwmsw+pJVNCQtmBhIzlQo8jMi1seWR/+0gN+922OJpblgzG5CFL?=
 =?us-ascii?Q?aiEfbSz+TSI7Lsg1j8jX16UMjyzC4ORzJIGDRqduyZIBdfe8vrFcHfUadEzC?=
 =?us-ascii?Q?n9qPnqQtirLi2vt81AG7NlIQzomhfxffaDYdpsS6Tme+KgIOUBJrKn7osqFb?=
 =?us-ascii?Q?FuKDHVmaXOagYs4KksA+lIcomQ1tApX/XSdWV4DQ58nSipOryUdPOshVDeW3?=
 =?us-ascii?Q?+6TB0X3jwCLjL7BY6h+8MDWV4VnQmF7iZuc1X9BPIziWYlLjo7p7VdaOtr37?=
 =?us-ascii?Q?pyLHexmOfbB3E8L8/gWQ6hA0DO1s/UFV8H8HPJbDIVq3pS6H6VDD4MLz5k2n?=
 =?us-ascii?Q?O/5PhXfR22QsfE3aKMSm2W+BK8ub3D0UOasgWX7Mp65DfrO+ZgbRaUvLAvYz?=
 =?us-ascii?Q?GBXRDd/URztcsluEYpiDLMFoU0fn8xlOzi4ki4yKd6hrIEmWHsjfHo6o6hJk?=
 =?us-ascii?Q?cfBio+cdCWcph+8MH5stDNoAxjDOO/vrT4RCKZ+zMA8TsRhU0tBUddK19dTE?=
 =?us-ascii?Q?QnXuWGlhh2hfNePQs/6J2l3Ma3+rOxlouACL5cphmMmTdLj2+YTgEhy3Saji?=
 =?us-ascii?Q?Nc6EqdhDX4qruu4sZtsNqGHeKYqIiJoLhI8pAzZ08ILPWXrY8Q5B5CDQ9etD?=
 =?us-ascii?Q?GMDw1Ef8OUYj77YjfwPAibeN2c4dDOAjou1xwyUOxj6EeGZ8XbSo3bop2ZjT?=
 =?us-ascii?Q?XvBcf7oSHlLuTkGZY6zWAoOUZssSewWx7hPMccoJLywfivWMZEJ1u8KrbMge?=
 =?us-ascii?Q?4j6LrfzrzfYlXdtWAb6Kbu8HSTKC0O+cWVZ3phVofhH3fFdkxiFF8w64HpYs?=
 =?us-ascii?Q?xBQn+UjddMDlnQn5Bma/tYvRnYpydS0Sbdfb8wtc4vmPe/Rx+pj/862jUyIC?=
 =?us-ascii?Q?9q+gBFqIYT8RxQs+xOfRV2Qw3LvLeYzN0WzTPVYoZHaa6qu0Z5Qxh8PROau3?=
 =?us-ascii?Q?38lpudDWm+T/Tt8Ka5jn/6/LmBPj2E0oZ2BnILcK4ZQtNNNXgFp0plFFS8aF?=
 =?us-ascii?Q?GUiSl8EIuxrbFKxrH6PVHv6Ue/3p9zD5Ni3wWp58YoBHgLNyWng30ToMWxBI?=
 =?us-ascii?Q?0RIKffDt7b96HvNz06+q662kcGbs+9DQ+9PQcvOpsGeg4OBAGM4FrLpsq6N+?=
 =?us-ascii?Q?t6hOUMRyWiujwWtU7dF3Vig7BMZpeN9+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jf/mDFnpVulJsOhIB030JJYkWXYPYqiy1QDAPg5IHXpk9qnJHa8D9N6cGhBu?=
 =?us-ascii?Q?PgjB4jLjAAdSTpu4URlOKGRmqmFm76lBcPZkgWlP03u5aNWsYqCLM5G7MlDp?=
 =?us-ascii?Q?NlRJM8q4G2ddIY4i4RQisqaFW46ckd90bwR2EU8WIeDeD8TfNtM34T8LJr9O?=
 =?us-ascii?Q?mKt2V2FxtPfGhytg/bFlzptqOrAznUFtUHZsnfM6pVljEITR4JyXdfhoMAl4?=
 =?us-ascii?Q?MqLvsLyirqvQDen3VVaQzdMyOI0NfljlUwO0ZmBYsDEARim8nBvJ6UBsdmue?=
 =?us-ascii?Q?u6hlEBJZ8tHBDa031Zca0tNoQsiRDju47pfebfDroPeefvB8TAtMDkN1SnOR?=
 =?us-ascii?Q?xq51U0/RWGZCQdGQq81gQri5fCW9qfRCB2pMFxCHKT543ydcurupgKgjxEMs?=
 =?us-ascii?Q?RTWTnQUsLyuhhmimVr/X9KPEqih2mtvHWKZbbbeKYl0HeI64iszFLfDelvKo?=
 =?us-ascii?Q?ebrCevprgicF93hPOGQtNgGn0frXDjXK6+nJwaqXzQ5krxcQRfegZLmNshPF?=
 =?us-ascii?Q?PZhVJXpGaXUqKbmMqGLVFsRK3ys16W3vSoysrMHkJqnhNyv/wbLtZ0picv+M?=
 =?us-ascii?Q?kifP1sbZEnixBbkQz0gcn+8EWc585hK5jvW8bME1iQ/9+5nXmInW2vY97UCm?=
 =?us-ascii?Q?QDk3ILnPKCwET8d4qHwAAfuSAnyERB998wNAB2Y4DxDFJPYZlR6PEyKaweR6?=
 =?us-ascii?Q?9XN9Bqvw8+Ep8Y3jaww54MqZBkTLmRYTgRgHdPZNvl0ReNmgBNOuKdFyCy+k?=
 =?us-ascii?Q?dgmlcPR8BwioyMiF+cITantPddlXDXdZ8LVZzbHeJOp4EDVp4gglSVKX3L0i?=
 =?us-ascii?Q?ZbNmYpp4Zbvkbj37W08bsdDu3WApUwZx4xqQpoL4Rn00tCNUDavOYMHb+3iU?=
 =?us-ascii?Q?XKElyy5mbS+RGU4LBIMnr3Bn3sL2Kni5HLKIbtWpuX2vnS24HMtBwkYspNmj?=
 =?us-ascii?Q?X6SXoMEFJQMoam+TQG8j1OTZSMhW+iqhpz7bM2KTAKOpQRJR0Blww4GiJ42V?=
 =?us-ascii?Q?pElSMVLZaYFB2w0GxJCwENH91igBaxWvtNtZF3kOAl5yjgVqjWKz48Zin24q?=
 =?us-ascii?Q?GdCFjsVUGJLpQJa2sWgt+TCqudSbW1Be716hao9cZC9oxbUGpJXZKutVtyA5?=
 =?us-ascii?Q?bIYAuhK7yN/gwuMli01fX6dWfMXCCo1nGkK1PykUOTKbupiLPaMJ1/57Y/Z1?=
 =?us-ascii?Q?v/NGD1hma+KlQvAfH4ci39MJzis+23jsebKS2oXxeInnwFC5NsVy3+RntAll?=
 =?us-ascii?Q?Twvukuff7bKIRCcMpQ/T6QbSqWvJAIeeIJ1kTGPKY1mw608KZTjslY0DvK6U?=
 =?us-ascii?Q?O1kdt95XwRo8S0wA0vT6QYynP+IUgmgjfYC6+NHfxwNapkvw3QtLDHxqqxwB?=
 =?us-ascii?Q?aRE8kScI3HC7MccaVEMRrixHdpadl6DcLEvs7FVue+dokeKS9Z4jAtGZglv6?=
 =?us-ascii?Q?BxZQa96jmRZ9FCFdXePxne1FzV0ptRXD5dzfXy85qImlY0eWOKuIxujTOoqu?=
 =?us-ascii?Q?dWW/VnqRb67oQgxowIJpr+3VD3VX6WOxkICSWjnMOZp4jJctpSQbnJm8dK+R?=
 =?us-ascii?Q?6FKCd5I0i1pMEdxHhp8j3DiNWNn4AseTSHTC9AIu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe020ca4-5539-4eba-1d2c-08de10ada4b4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 14:25:11.5385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7o714qHcigpv7Y2qHl3z16xE4N8Gyhwz2D+5YmzGxyHoQlHIoy0mZgonLW+vWNe2vlaQERQVOBK7zXTk2MZDmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8941

On Tue, Oct 21, 2025 at 04:15:00PM +0200, Borislav Petkov wrote:
> On Tue, Oct 21, 2025 at 09:37:45AM -0400, Yazen Ghannam wrote:
> > It's correct that one of the root devices will be on bus 0x0. But that
> > device will be part of AMD node 0. So we still need to pick a root
> > device for the other, if any, AMD nodes in the system.
> > 
> > For example, a system with 2 AMD nodes could have this:
> > Node 0 : 0x00 0x07 0x0e 0x15
> > Node 1 : 0x1c 0x23 0x2a 0x31
> 
> Aha, so next question: isn't there a way to figure out which is the *first*
> PCI bus of a AMD node? My gut feeling tells me there should be some info
> somewhere which we can use...
> 

Yep, that was one of the goals of the recent rework. I thought the DF
register held that info, but I was mistaken.

I haven't been able to find anything else. We can keep looking, but I
wanted to send out this patch as a fix in the meantime.

Thanks,
Yazen

