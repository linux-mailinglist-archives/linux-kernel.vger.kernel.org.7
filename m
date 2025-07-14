Return-Path: <linux-kernel+bounces-729342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B08ACB03537
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D431897324
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 04:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26671F130A;
	Mon, 14 Jul 2025 04:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ERzzx1fN"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D561F1537
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752467862; cv=fail; b=cgNs7AmxiqczHrxnFjVtFbKnBPQILwB1U3Dv9mVXszLz6LwaQkDw051ZlHIDQo/Fh0Cha7S4hD88eR8oi9mRRkg3YrcxdkJMV+j8+r4aor3T0+gW2bbqs6Or5UFCj+75m+aQQyj0w7XtkPXOH68I/16y/EGcWwkXmDVj4ysAx4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752467862; c=relaxed/simple;
	bh=V7jYgk8O2lFnQcVdVyoM2DW4zbSv0jUWZb4qvp0TABM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uYK7JbNLghSMzcbmL7J83pkRJdkXiJwY72ptcOjH/U35e7vBID9GAf3uLHer2kHIOe4qH7eyMen7M5CNDqeOGdBhuKfF+7q6KXNy/Qnfc2mmGKQ8lHnHZ5N7E6DvNFQW8/uxboqIFz6U9ky0M/5L0XcmXd7nUoECvh8Xcln0fYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ERzzx1fN; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdANPgIfclJmNBqaoO+CqoipCiehukiz/Repf3RIY2K4BYvkyetbMeslq03PV1URyKNQDEKpTxIAxdCFIzzc+GEBrz3iD+y615ZabTFgdpRI71ithIiCERCsGtMtovRxhsqAtlM8pC192jNOhT7CZm28vi4w80ukMZ7Id0NKXoTA342xu2AZyJrejMDxMRwtTp8csliZsm2FguA6tPc29sD7KJdBXjBWJ7Yt+Us+zkdayqu4kQt3l9WhaMSsbE5OWiy7bzeOVqp7lTfVaqTkKOpN31/l4r+U5LM+YnH4iOUslCnmYhP3tGrAkJ5KOtGVzzn/u4aUK+ghSon83RQJzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKqxfQf2va8iF6rknQE3Eo2k71ACQEJfQYAc0ZzHvA0=;
 b=XamIJqPK0rKTXiIb67QfAOjNZa2qIHiwP568av9Ks5uAEpBJyCoz3dGdcVzXCfox2d7dMiMjxbNV9sG30okfPoR4OWwWRSawZ2q+PdlzJZNSpzkhBmKTjxKlpL6A1tveEVIC83C93hrO2t7t1yWeKPow2hFUQQWjsMeXUpTtBfS9WUbWf/3MKQQmMtpm8jgE3B8IYyAvYd4uux6uSTp1F/QE/C49BSp0dYSvTD6/BHDh1tN0W7OvB8Qt3U317tEuQfFq8y9zIfwBCrY7PR0xTEQpcDRbM/pZ3LaxCFjaocYdAlEH3lA7ZM+UwBK8aBeUt6k5vieh0TG2d7gzX6LwZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKqxfQf2va8iF6rknQE3Eo2k71ACQEJfQYAc0ZzHvA0=;
 b=ERzzx1fNuOwdIKwlVC7iCqBoEKapq2841a8eFvOOtORS6vPbCC32GVHGbbWrfPuag2JSq7WobM4308LLWi2lGX1JhsMsLpH/1MVxIi6WqhNf20rqJ3gF9fvsQBYXCb4UiHo2883dmr/oWcDvRuDwAF7did9/QfU/neiPiYBjx3k=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by SA3PR12MB8809.namprd12.prod.outlook.com (2603:10b6:806:31f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 04:37:29 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%4]) with mapi id 15.20.8901.024; Mon, 14 Jul 2025
 04:37:29 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: "Joseph, Abin" <Abin.Joseph@amd.com>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"yanzhen@vivo.com" <yanzhen@vivo.com>, "palmer@rivosinc.com"
	<palmer@rivosinc.com>, "u.kleine-koenig@baylibre.com"
	<u.kleine-koenig@baylibre.com>
CC: "git (AMD-Xilinx)" <git@amd.com>, "Joseph, Abin" <Abin.Joseph@amd.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] dmaengine: zynqmp_dma: Add shutdown operation support
Thread-Topic: [PATCH v2] dmaengine: zynqmp_dma: Add shutdown operation support
Thread-Index: AQHb80AoIWVqZT5Gd02Yi00/tmBBlLQxCfTw
Date: Mon, 14 Jul 2025 04:37:28 +0000
Message-ID:
 <MN0PR12MB5953CBA7D5D05F0D9F0A4400B754A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20250712151752.3669944-1-abin.joseph@amd.com>
In-Reply-To: <20250712151752.3669944-1-abin.joseph@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-14T04:31:55.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|SA3PR12MB8809:EE_
x-ms-office365-filtering-correlation-id: d35394db-df04-4c95-9607-08ddc29023ed
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PMFxErFSIg/jiFMD2v+fm8NVxzz3mMmc+OQDWoXhOyQHODLPzPMQUxquXom6?=
 =?us-ascii?Q?JHkbesM+1G6EC0lTZUOAtoF2wrnhFKnE0LXc3sy3yNIR55zZ79/5uTPHkppT?=
 =?us-ascii?Q?HcaNOlbndfBkGH+41gPHcFy2m9Y8l6us+6fjjI70/YDTSKFNqXCOKsJH9ZhY?=
 =?us-ascii?Q?MhB8ynZzI1STBWA6k9VUsSzdQkHqIjQwIJeAYjt1KXeNF9hKDZm746qLjM7P?=
 =?us-ascii?Q?9QqvcAuSTltndPaIJ8UaeCKjIH6AOGTv3uyHHC0bqKT+iDkSHLayBDvNhHih?=
 =?us-ascii?Q?t10YmtlR7Otdt/Ih8TaXw/an4Hpuo5ltrxyGbja5h2qpAnMvTd6nPH3Umwtm?=
 =?us-ascii?Q?Ti563vpIatyctSvZk/VY9bkKqU+cxwDLu69xR/T1t8DY7A4k9X+8+ZQG//Rd?=
 =?us-ascii?Q?thh6Ikw8W+Zd3MoYcR8QD059eNcQAFv++O3Y5Qf7XIagI8HGCqt8vj/5H6Sd?=
 =?us-ascii?Q?DLd4FeVDvPQ+R6M4atG4aV8yy7rsz5SYGcDkOhyzPcN7gLUYAPeTMiE3m17g?=
 =?us-ascii?Q?cLTzf7k54lJsP5CGn5ZnhqEu/MKjt53eKRcVyIDzyG+EOuiYJOTOmG1T/dVD?=
 =?us-ascii?Q?FdChfD3Wgjz8on6M3p1wO4axtJyZhxLukxiHBd7weH+K3xHEi6BHYBfjbozm?=
 =?us-ascii?Q?wigFSrCzbmPv8Kcyf36t5JrFT4JSpp0+Qb8q6VDpkDNr6MG5yegKxBHWSE6e?=
 =?us-ascii?Q?m5j1Vxxfoa8umpWMBkaLDt1owXb3E71Vo90lVAEy81MEJyuNCCAzG7hGAu+w?=
 =?us-ascii?Q?VYBixQ4m/odRx2uoiBeMkNNMEy4gIxAY05oArph8YWBglNy4S82WLlM2ETLC?=
 =?us-ascii?Q?hwqdNpmHxWGZLn4/jrtfbNIjheCBEmiKmj8MzPO7cF48gxz5ikVf84g9ZLpF?=
 =?us-ascii?Q?InygELMUUyKbOx6UgJc2Z+uaG98hhvhsXQtum8vwczF/k7BaP1LDSBt4aWMh?=
 =?us-ascii?Q?rEpOHRDVTKCexcPSbw/1ZyvFxvM1DZVMrs18C9tobygUnjMxmC4wIsXcnEPl?=
 =?us-ascii?Q?2DUpr2LYXZYc1DppQp/1L1BOAUxXF8+5uY+etme6v7bVvQ7CMUhaha/sQtsT?=
 =?us-ascii?Q?3L8y2QrRF36qKC8463C0pQBQQMhy36hqHREy5IU948AKdg8C8ntHpgSlIZs/?=
 =?us-ascii?Q?hhqdoiZONd6nnL7ljEHpbMDO8G9ajAi4E1ZuojqPsn4R8WUlkYb+yGVjJL5y?=
 =?us-ascii?Q?ebOoLhPnnaMChjFRezvW1ORMcqfYDiNoDjxym0YPTinho2qcMV3d/llnJOyE?=
 =?us-ascii?Q?/sP7ewnzkS34TLwIQxVqisavEgV5LwhZWLE9WuIpnW7kD2SGSBsNxjqKxlb5?=
 =?us-ascii?Q?bkzoattBZNoifmR+qK+EMqJ+9NbIqU9N+bgMDwE2xt4vKPyua5Q7qNdF9AbJ?=
 =?us-ascii?Q?IA4vry+cER2aFRfDfNhCmaua1c8e0dgM0WPe6yHPP2DT+UGdFL18y/xo2D+G?=
 =?us-ascii?Q?bGi+7I8/roL6Gk+DxxSYYPc76Gd6wwNs1OCUVbp0QxJVTtZJIlSIwTOwfRsL?=
 =?us-ascii?Q?kdCB3VydY3Nnri4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dunoBDv/L5J8ymrML9ZC3XSgfAYAPZ98WA/zzmPltI5/l1jnf7tai3LFnDmn?=
 =?us-ascii?Q?qadtzaW269P6j54EObBgKoBK3XA3+aqZAQJ13+MGw2LgEPyffY+XgVrihmbs?=
 =?us-ascii?Q?7dCmODVfFzpqzQo2fuvvjpDOzBgCG1jP92pFydpKur4B0MaUhzJs6kg0EYis?=
 =?us-ascii?Q?okA+w0fhqPfE39gwuDRPOPNeujurS/UxBjQ6WoUmDd77Wz6Y/NliKxOconnK?=
 =?us-ascii?Q?xglJbwTQNkaXOQT727sJx5nVdw9UqSd8n8TfFG1Xvjc58Q2veYi2dt0QuGN8?=
 =?us-ascii?Q?jfty6g2IeCeV83scaqQNC5zhp+5yYiJRCb00lGRtLomKy3Wo0dgDD21A2kyR?=
 =?us-ascii?Q?v533K0kwKtMINwZlsG/IIEf8Ro8zLPmvXux6OWES8Oog3pjnG7DeutJpeslH?=
 =?us-ascii?Q?EJhHSHDgTWFioSQSSv6EFVYFCuxRTELfVHNjgGo3hzlXBdqfx5AWyF82dBY3?=
 =?us-ascii?Q?RYqsvq/PTlHMPYzi6rHPue1ZEu/UqFdhHWI6muolHcJ+d/OgV8xLjM/hbBJp?=
 =?us-ascii?Q?Gwvs9kJaVkB5tGTTwuPpvy8coUBrPiT0VyTcyWBGZ4s2GNpZdOc8fUQS3jVL?=
 =?us-ascii?Q?uxL9P1kTQ/C/KYavZ7Gj4G8IkREJr8GUygDQGKeM9wOCycVvmLU8dv5BwihQ?=
 =?us-ascii?Q?jJH6GocXFFYu3NPF0rOUSfmkVJ1GjfrtJVzGjCmWqXahNiOEanGl4k7oAYAP?=
 =?us-ascii?Q?PGZmheNxfTDeTDTJAfu+rI2X6jjNwZh2CPeSUhbCn08H4r4u1yOiqCADQ3Jp?=
 =?us-ascii?Q?vr6EUjI/FnUrvOUoFcOOwI7PIn0uD5JQNgI7tlzZDyvdnyZSJDUJ33JQ0rx3?=
 =?us-ascii?Q?V+YrbBDZ85H4wxrN387weRg4izsHeeXQ7SeNuPF3XCVypcs0T/r/mbgyBkrm?=
 =?us-ascii?Q?W4DlD3YugK7zrUzkBa+pFHN39tCLe6voS8nvPYr5WpKI9m63AqZX3oYgXIxP?=
 =?us-ascii?Q?8WwpHeC1T/3qUoQiuO+lWolaEM4qHTzN5STNsKLl+O3ZCvi4p28wfy6PaSdj?=
 =?us-ascii?Q?0M3HYeLlgAu0fmjRU0ZJiNdFpyqNoeyDADJ8SegxbNGY/R9cVutGz+ktkV8q?=
 =?us-ascii?Q?BRwVL99hp791uPRzL9Vl/rB6UJCW9RvJscpo9CMTIuJYSJzXG8vCMewiCdXY?=
 =?us-ascii?Q?qce/S7e1MR2QjGVedc9QS7KUcFfzAvTTnPnR0OwVCXIbehkoAEEgGYjatPC/?=
 =?us-ascii?Q?2ySFJs8ZAyM7Ew8fZQIwcMlwCI083XhtIvRd0ZOsorf5HqK2ZQQsNjjm4HjM?=
 =?us-ascii?Q?rRkPOElmsx9hIxlbqhQLBL1l2t+459jFjwo6suraUPS7kLR6mbo9DpjDJqt6?=
 =?us-ascii?Q?NwMIGe4DmcNvvQ1cuYfj+5SmupH1Ht8VN2T2yVkwEfpkVs7yNOgmPx4uTdOa?=
 =?us-ascii?Q?bdYLuG0zVN2XMCPnMbWRbJ9JFAMaJuw1OmGzQPwnAXHdhIBPA8e+tLTpVSMD?=
 =?us-ascii?Q?IBlFqwYxHOq0sIBlWiNwNQlyYAqXFPcmYVG2xSA9ug06N0Ksnyb3KT4GEEhI?=
 =?us-ascii?Q?NiEQHqrT2Rir5BGCvrb9BkD5PNhhlWMiisIR87DHy3/DbGjWsOFu8oPmQRuQ?=
 =?us-ascii?Q?AFjq+cbEIzhTm5l8ZKA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35394db-df04-4c95-9607-08ddc29023ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 04:37:29.0150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0mkrYOxE3vFIF18QjU7v8bLLwkAElKOax9A+zH+yTSI/kuIFnQfI/I27B0BKynT/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8809

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Abin Joseph <abin.joseph@amd.com>
> Sent: Saturday, July 12, 2025 8:48 PM
> To: vkoul@kernel.org; Simek, Michal <michal.simek@amd.com>;
> yanzhen@vivo.com; Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>;
> palmer@rivosinc.com; u.kleine-koenig@baylibre.com
> Cc: git (AMD-Xilinx) <git@amd.com>; Joseph, Abin <Abin.Joseph@amd.com>;
> dmaengine@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v2] dmaengine: zynqmp_dma: Add shutdown operation support
>
> Add shutdown callback to ensure that DMA operations are properly stopped
> and resources are released during system shutdown or kexec.
> Fix incorrect PM state handling in the remove function that was causing
> clock disabled warning during the shutdown operation since the device

Rephrase - it. Shutdown was not implemented earlier.

Say extend remove function for shutdown usecase.

> may already be suspended with clock disabled, causing the clock
> framework to warn about the double-disable attempt. The current check
> ensures runtime_suspend is only called when the device is in active
> power state, preventing clock warnings during shutdown while maintaining

Explain pm_runtime_enabled/ pm_runtime_active usage.

> proper clean up during normal remove operations.
>
> Signed-off-by: Abin Joseph <abin.joseph@amd.com>
> ---
>
> Changes in v2:
> Update the shutdown to perform same operations
> as remove.
>
> ---
>  drivers/dma/xilinx/zynqmp_dma.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_=
dma.c
> index d05fc5fcc77d..0b03c2092c28 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -1173,9 +1173,18 @@ static void zynqmp_dma_remove(struct platform_devi=
ce
> *pdev)
>       dma_async_device_unregister(&zdev->common);
>
>       zynqmp_dma_chan_remove(zdev->chan);
> -     pm_runtime_disable(zdev->dev);
> -     if (!pm_runtime_enabled(zdev->dev))
> +     if (pm_runtime_active(zdev->dev))
>               zynqmp_dma_runtime_suspend(zdev->dev);
> +     pm_runtime_disable(zdev->dev);
> +}
> +
> +/**
> + * zynqmp_dma_shutdown - Driver shutdown function
> + * @pdev: Pointer to the platform_device structure
> + */

Why we need separate handler ? Just reuse the remove directly ?
See https://lore.kernel.org/all/1748977771-714153-1-git-send-email-radhey.s=
hyam.pandey@amd.com/

> +static void zynqmp_dma_shutdown(struct platform_device *pdev)
> +{
> +     zynqmp_dma_remove(pdev);
>  }
>
>  static const struct of_device_id zynqmp_dma_of_match[] =3D {
> @@ -1193,6 +1202,7 @@ static struct platform_driver zynqmp_dma_driver =3D=
 {
>       },
>       .probe =3D zynqmp_dma_probe,
>       .remove =3D zynqmp_dma_remove,
> +     .shutdown =3D zynqmp_dma_shutdown,
>  };
>
>  module_platform_driver(zynqmp_dma_driver);
> --
> 2.34.1


