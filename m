Return-Path: <linux-kernel+bounces-613591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9553A95EA8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 08:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65491896A58
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 06:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFC21F09AD;
	Tue, 22 Apr 2025 06:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e7Gz+kYh"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E71319AD70
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 06:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745304611; cv=fail; b=HSLSpnvdunQW5T61GpYvss85PR0JRmg9Z/SXZ6JWB3A9iQx/42imKXCNlxFwKmOjF75E/Ycr1tnJefcrvE1EUU7z3Q9jY+pBZ5BtJKUhM6ev8V1VHl2WCwYPdyn0ay1SopU1qgt9yB4xc7c8IyB9XMCOwdKrQqcoV/xb74fKTtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745304611; c=relaxed/simple;
	bh=Sz3WfKUysx3fKz5tM5cywBPpviuA+sgKDj7q5sVmpmk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZO6TNox8pshzJO9QeSFwILLrSJNc464hStBIiFhK+GRwYKrDIvIuNc+unfMi/EFNBYoXdSwcNNLAY1tsbY+qO8Pzg0wzNaIdhsJwn8g4vu/MGEuHZfbVlaR/xNBpXKi8rAgncDPqkZ1c1q7ruT1vMTfRIndfquIuwwYcPYL6ASE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e7Gz+kYh; arc=fail smtp.client-ip=40.107.100.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PM2tPfJgAB8GTWVs58d6p/WT4VnkInit8RKMJJ8xbpCKVdIQWDlXtAHWK1NA5tnPGs3i40TFH+wR4Z8gZInuY5e0HUmDXHEWZFdJv9mlBEPYEKg4F+cCoAtUsPbexLkXQDGDmeZ61A2jYPVN+Avk43yMyNrl5w7bIVmLTP/RC27lTBA/Zka1FaqHouTeF0S6CMYyNzcyD3DQnT6ESbwjB59Iy+49j4f1u0sZks+JRYr1aD65tCElGA5LtsPqcPw8SV67N0xLSLjCfq+f1iigOljuwWRu7KNt4U7SyC1imiPhtBwH3asS+KArV5Ndd/SyP0N5j9lI5Rs8XriDcQgUpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sz3WfKUysx3fKz5tM5cywBPpviuA+sgKDj7q5sVmpmk=;
 b=unXTXZN+TGvvr7wOGipfOV4YTy1EAcjRG3fMYBt7gYKZoNrKYimWkfUaKLgUrvxmRWrSLgT1Ae6z6yOVqwnNffJ5A1m9ZcAuNh3Lxxh+Hbg6T2RMji41vhZYFs7RsgJm5t0iT4No06RJtPJE5JcPCPNiD5QfPMoTkiFNcIREsV/XCJPD0NYFgIiaOn0hVCqQ5Emr0ZkpI2N0A3rWZkRdd/3ZsTfZd/ftBjykT9QueJTpTuZXu7LXi6byMaHlPMDA+6hhjD8A0Vku43ajao9RSBUIEUJbFBEb2qNDSQd8GOIdwrCNUo5PbOpOcujP3CVvIR1EMe3AsUiXZpwY0rTbWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sz3WfKUysx3fKz5tM5cywBPpviuA+sgKDj7q5sVmpmk=;
 b=e7Gz+kYhbnu0LDuV6BbDVZD2YAvsUrFwt+Ziz0KQ1wRe1+SB/GruGUI19ixqq8AscskaT9GUmEwBg4LlA5Z5rGLd51J7Duoe6mi1HJlpBsGqMqen58CULxptCynQIhxVSbmw6aV9J7yelVEN4MpVljFsa3LEu1HkBFzOwdKnEKA5+q1jkC/XVQ5H7YjV4uRu7mzj7IjLcE4V/2n8CT7gCAz7VBw3FxI4FwaXV32ciDSPa8XxU74zB021UHMcKzZk4uOT6uT52oAHU25l00D+QWo7Af6/yYr4WHN+GONQ8J3KyfY58IBcw6RpnDDS/NAiYFmzZpAmfk0qzE3p3jIvww==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY3PR12MB9680.namprd12.prod.outlook.com (2603:10b6:930:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Tue, 22 Apr
 2025 06:50:06 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8632.025; Tue, 22 Apr 2025
 06:50:06 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Richard Weinberger <richard@nod.at>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"hch@lst.de" <hch@lst.de>, "upstream+nvme@sigma-star.at"
	<upstream+nvme@sigma-star.at>
Subject: Re: [RFC PATCH] nvmet: Make blksize_shift configurable
Thread-Topic: [RFC PATCH] nvmet: Make blksize_shift configurable
Thread-Index: AQHbsEF+rFpCwd/m/0iFJLj8GwLz5LOvRQuA
Date: Tue, 22 Apr 2025 06:50:06 +0000
Message-ID: <a1641ac2-abe4-458a-bdb0-76921f25b108@nvidia.com>
References: <20250418090834.2755289-1-richard@nod.at>
In-Reply-To: <20250418090834.2755289-1-richard@nod.at>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY3PR12MB9680:EE_
x-ms-office365-filtering-correlation-id: 004c6906-c233-4ace-69b9-08dd8169ea8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U3RUeXpLUmZBYjVtQ3FxUXViU1Vzb3FaTmFjRGdoRHNhVk1hMG1UYnhLN2JG?=
 =?utf-8?B?SlFFcFkrSTh0NXZIMVJhR0RQWHgvWFdvTElrQXhEeGExd0l0ODgvUU5seDJz?=
 =?utf-8?B?dHBaU0NGd3lDa21XS0ZvaU83dHlvMXRKUktmdUtaN2lsQWFrUFYwTTZ1Q3VP?=
 =?utf-8?B?WUpEZDNzclJmdS9ENmNZSDNKWDM2STNrdmRDbnFiUVRhTUNLUjNVN2xGc3hF?=
 =?utf-8?B?dXd3NmJNWTRwVjZOSnJDV2g2b2JOcnovZU9mY2Q4Z3dORTBRK09CZlR6RFc2?=
 =?utf-8?B?ckE0bnVhT0w0YkZZaGVQQmVrY2dpbjcrUFJNc3ZkMWQ0Z25tWmZySFE2bHl3?=
 =?utf-8?B?ZTl6aWs4ekZBOUo4M3JGVlkxdjNibkQzWUlUVUQxeGo3N2gveTZla0pFR0dz?=
 =?utf-8?B?ZWhFVkF3THRGK2NaeTl5UzJKMEEvdVBMVzVjYjBMR0dyK3BGQWZsNWFHc25B?=
 =?utf-8?B?NFBKelZJS25hdGIvM1d6blg5WGxiVUF4Mlo3K2tUM0p4ckNlbTJqRFdDNmNr?=
 =?utf-8?B?RmUwSVJwTVBDSnNLRFAvYWxDNmM4cnVxbzR2ZzI4UHN5bHJDR2JSL1Zkalls?=
 =?utf-8?B?MEdqR2w0UkU1RDN6dlpsT203RHpYUjZ0dEcrWis4TWNmMFZjOGVaQkNMTTkw?=
 =?utf-8?B?YjNaT3lpT1NpRURvNUhqNWh6NHh3TkJFdk9YZGlaMmNMUTRGeWl2WUpydVFn?=
 =?utf-8?B?b1VlUThDU1dtVlIzWUVWazNuQncyTzluQ21ZQ05JRzBKb01xTzZLcm9wRzBB?=
 =?utf-8?B?NU4xR3NXbDlhZm93a1YybUJIZ3R5RTNPMVFXT2NqWnpHbHZ2NnVKdE0rc0d6?=
 =?utf-8?B?RGZpaVl3SXo4RzRVcmVsOFV0VG9seTUxNWtORm11dW5aWWdYWVh2eWs2U3VF?=
 =?utf-8?B?Tm5iWTVSdWN1b2JkUWRkbjk4T3ZOOWFFaWl4bm0vdWsrYlBSblB2MDh0Slhs?=
 =?utf-8?B?Mi96aUl3aFdyUml5a0preThsKzBpR3JRdHViQ1VtdVlzbXNJc1ovRFpNSUEw?=
 =?utf-8?B?N3o4elJUaGV0NWRYS1BGd2NuMnJDQ1ZwbFFqdERMYUxYbEFNbnNvOU9ocTBM?=
 =?utf-8?B?d0JSb01ibmVRVEZJakZpVUtGd1VRbVJrZi9UQWVyUCtpeHR5SDhDeXpsQ1Ri?=
 =?utf-8?B?d2NUWTdpMFJRY0Nna04vd3dhUjV6VHMrcmxsbkJBY0h5VlU1RVdYOVplVjFl?=
 =?utf-8?B?dmd0UU9jVUh5c3FKN0JzSjZzYy9hTFpLTllMUzBuZVY2b3l1TDdybi8zVkxr?=
 =?utf-8?B?SDlMRGEvYWRJd1dmY0pFSTRidWhuSUpMc1FzbzBXV2dYdUFNS3hCNzVDMWgy?=
 =?utf-8?B?cXlmQ0dLajNCVkNUVnZYdkVFcDg1S2FFKzVuN1BMNE4ydzROY0FJbkg3V2R1?=
 =?utf-8?B?YzdFeG1QeXBmMG1xNi9ZczEyb2FzNlNJYzZ5T2Y5blJDOTB6ckkyWTgvb0tU?=
 =?utf-8?B?ZjFjWGFhVjJDaFNBYW9aRW8zbUN0eDVhSmsrRnVHRmhMbWhNVWdoWFNmMWU5?=
 =?utf-8?B?dXh1NFBkUXNHRWtnb0lTSkorcEcvaUcvWjhSMDFGdnF4Y2d3QjlUazBZQjN5?=
 =?utf-8?B?bjRCdVV0dDg2T09OT0t5ek9pUlQ2WHFYeFVEWTVGdVh5eTFabmJIYlppcU56?=
 =?utf-8?B?aW4wTTZKeXFLZEkxOWx5UWhBT2dERlhiRGQvcFNyU0M1MDltcjFzOGFjMFJQ?=
 =?utf-8?B?SzFVMVMrc1RSVGdZZGlaNHNpMHpvcC81MHorVk1aajR0MlN5cW9XUzd5LzRO?=
 =?utf-8?B?UmhlTkYvVU1GOFF3OGthbStSLyt2SDF0MUNZTjQ2eW51eXJtdXhJMjVuSGJX?=
 =?utf-8?B?aG1oVDg2ZHV4aFFsSElubUJmNWtyaXFoR08zdVcrM1BkVTBQRHVsbHNHZitD?=
 =?utf-8?B?NiszeEZoWU9FTTViYnRXdFFuaVZrZk1EOGRyV2ttS3NTQUpXV3BuR0JyeTRl?=
 =?utf-8?B?N29KOEk3NlQ3N0JCaFhUczJwTStWVHI3KzhHdDZ3NjNDOVBCbVFQWWpSdGJk?=
 =?utf-8?B?dndVaW1wdDBBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dFppaDMxRlBrcW0yRnhvTStXajIydGVOUkNxNVh5bVEzQmhLWll1YUJ6azk5?=
 =?utf-8?B?enZiamdrNEVGWUh6ZldwZVhZUEJPRTFtdXI0S2lVYnV0REJXQjQrVzMzSnpm?=
 =?utf-8?B?V0ZaVEU4K3ZRTk81MzhPNTFGSlA5ZjMvTXdRbDZnZHgrV2czbGJuYndCQ2tn?=
 =?utf-8?B?QTZldnFiWEJZeGFCbFdIeXcrRFYvNGVSMnJNY3orb29LN1lPTHVSVHMrY0RO?=
 =?utf-8?B?UHBLemgyZWQrSFUwRUJPdnlNN3J5ZE5wV21YN2hjKzFMUExBano4Uy9aQktv?=
 =?utf-8?B?ZEpGU1Y3OWpMem14ajJ2ZUJ1NTkzbU5oVG5ONmRZd3dvbG9pV1Bpa3VYVTVB?=
 =?utf-8?B?UWtsUVRoMjNiOEtQbmIwV0xUZVllTm9ETFJUdmZEQ0wxejM5VFdoRmNBSmdK?=
 =?utf-8?B?TGVKSEszVU9EdFZzS0M4cVE5NHE4M2dtVGhFWTRQREltUWl1V0x1bC9WRlYx?=
 =?utf-8?B?VnRiaFF3dDZPSUlaQ3NmdEtjbk5kMVVsOVhQa1l5VE0xM245RWdJd2taSjl6?=
 =?utf-8?B?U1FWY2crcVR4RUM4VFUyemV4Y0hNM3I0ZEhMSUdINTRLdEVnSTMrRTJhUzFs?=
 =?utf-8?B?Q0JOb1V4L3QzZlE0UWJobzB4YU1Ga0tsWlRib0l4RjZrOUJGZXQxSGdod01K?=
 =?utf-8?B?U2hacEIxVFB6YzlCaCtmVmN4UXBiaDd0YytLTndjdlhKK1E0RHJ5L1FYTG5Y?=
 =?utf-8?B?Q3YyTjhXWnNwRSt1TFNvOW9IQUo1QlBkN2R1UUh1QzFzTEdIcCtkYUE3UTky?=
 =?utf-8?B?M2F4MENkWkNnZHF2WlhScDB1TXlOcnNoYTFETEpDQStNbW00b2FFL1UxeHJm?=
 =?utf-8?B?bDgrNHJCbFlmU1BPWWZHdUxNZXM5dHRHQTY1aS9mdjVJZFBDeTlkby92ejl1?=
 =?utf-8?B?S0FoSWgrUlY4NlFQb0FNRHRHZWFzUzI0QWg4dUoxQTFUb2Z3TEplZXE2RlBV?=
 =?utf-8?B?Ly94MUNPYVpTSnVFaUk2K3pqc25CMWJXdG10bVRyR0xQZWdIZ1pxVjhRZHJX?=
 =?utf-8?B?elAxRUFIeFczNW83aytRZGxnNUxnV2tCS3l5MThIcDRQZlE5UW5lRklwYXVZ?=
 =?utf-8?B?aGpxT0lXN2wvbFg1SlFwRlM3ekwvN2ZlQWFISkNuOVdBZ2VTTm5CM1RXR29u?=
 =?utf-8?B?WDVCTXdsUHlwRUdMM3l2RTdCblAvMWdGQXJNZFdXTVRYNW8ySUovKytVbHpH?=
 =?utf-8?B?bkg0TGU2bWR6ZDl4RE9SZGdkaE9hQ1ZYakliMjNYWWk5c0YzRWtlNUtXUWNw?=
 =?utf-8?B?Sk1aNXJOWUt2WnoyaDdnVGhmK25Ra1JkL1RVUU5sU2JCVG1KOFU3ZjdSVWJv?=
 =?utf-8?B?aUF2WC9vWTNrQjlRaUxHNnJVSXJXWUl2cGdNYWtFemQ4bzNBSnJDUVpabWVj?=
 =?utf-8?B?ZEMxZGIwdHJOYWt2MXBrMVhyL2xlWTRjZGtQcU1hTEVDVGF0TmsrdTdpa1pC?=
 =?utf-8?B?YTg0bkFHR0dLdVFidTNQNlhPTjlCVmJMTlVmNitnSmNEMFNpemVMaW90eDNP?=
 =?utf-8?B?K0wrdnFFRllRRXNwVGtIeXdFTTBmVlBFdURIYVBFQlpUaFg3R21HcnBHTnlX?=
 =?utf-8?B?akdIVmNPV0ZoRWhaV3hEZC90Vk9JYjlpclRtVkRiVzZuL0s1dHRpM1dMYnFL?=
 =?utf-8?B?SHl4SmpmV2tjcmQ3dDlZSTJPMXhGdnJ1SHAwdFJCcktlZVNqb1BrQ1VtSDV6?=
 =?utf-8?B?LzFYRUxVOUlKcDBpaCt4WlpaOHZPSmcvQTU2c1pSWmFYQmlkZG4rUU5zZDk4?=
 =?utf-8?B?ZXZUNFVDcXpFaDlQbjZhcG1pVWZYRkpTakQ5ZVhzaXgvcURQMFZ3NHJnc0Y4?=
 =?utf-8?B?V0I1VFFkV0o5QldKTExhQmVLa2RVcHgyelZUTGtLRTk1dnNYalRtWllla2hO?=
 =?utf-8?B?SFZPaEk1VE9IVnBtbmxpZ21wYXZmbExLWUhyY2dNMzh5dC9rRVRzcU5WY29K?=
 =?utf-8?B?dXZaNmJxZVNVeTZCOXZ3TEkyNmgxVFZoVEw4VFFkZEFkNU1DRi91T0U3WXdj?=
 =?utf-8?B?WndFVXo1K1lkc09sNDlJR3dsL0ZSL3l1eGljTGFYTkRwMFRSTU4wUlFJSGE1?=
 =?utf-8?B?V1dqdXJkKzRTKzVSeG9rQWpJek9oQmFBNEU5aXd2WVV0ZU9xYVh4aXNoWHl3?=
 =?utf-8?B?OWFxRkQ4dTAxSUdkK0FFTFkrTUw5elZQT2VXbUlLZk1pWGZLYlpvb1Vvb1I4?=
 =?utf-8?Q?phyELxZNitqcDY1uLq8RpSdKzj7jOdBLCcDbXlUC8kGn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <857E21C53C70FE4FBBEEEF98DF9AA7AC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 004c6906-c233-4ace-69b9-08dd8169ea8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 06:50:06.2850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9JvOKvuk2ZHFleL53+WT4eWqJKzS+WO7IgsqDthQ3IltCsk9325iiMgkidRVXav4V4WVE9VR+zb3A6Y8l1SZxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9680

T24gNC8xOC8yNSAwMjowOCwgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOg0KPiArc3RhdGljIHNz
aXplX3QgbnZtZXRfbnNfYmxrc2l6ZV9zaGlmdF9zaG93KHN0cnVjdCBjb25maWdfaXRlbSAqaXRl
bSwgY2hhciAqcGFnZSkNCj4gK3sNCj4gKwlyZXR1cm4gc3lzZnNfZW1pdChwYWdlLCAiJWRcbiIs
IHRvX252bWV0X25zKGl0ZW0pLT5ibGtzaXplX3NoaWZ0KTsNCj4gK30NCj4gKw0KDQpJIGJlbGll
dmUgbnMtPmJsa3NpemVfc2hpZnQgaXMgdTMyIHRvIGRvIHdlIG5lZWQgJXUgPyB1bmxlc3Mgd2Ug
bmVlZCB0bw0KcmUtaW50ZXJwcmV0IHRoYXQgdmFsdWUgaW4gaW50IHdoaWNoIEkgZmFpbGVkIHRv
IHVuZGVyc3RhbmQuDQoNCmlmIG5vdCBwbGVhc2UgaWdub3JlIHRoaXMgY29tbWVudCAuLi4NCg0K
LWNrDQoNCg0K

