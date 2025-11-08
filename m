Return-Path: <linux-kernel+bounces-891336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0885C42765
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 06:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC628188DF37
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 05:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154172D7DDC;
	Sat,  8 Nov 2025 05:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o/v/mWWa"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012040.outbound.protection.outlook.com [40.107.200.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2262877D7;
	Sat,  8 Nov 2025 05:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762578134; cv=fail; b=VV+hAeJyDqAPQ7Phv1IfjM5p6VhD22uIYzydC+Ww3VzeMTh2kGHrh8CD0lPfU/mSua98dwNt+bGlrqWNOCvXpi0J3jdoyuIqiRBizLMTLAt7a/WLzRT21Sn9pxOEyW2DeLKkmj9jcZrfc+D6ml22FIcEQ5opbpb0xDwQI5gTcWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762578134; c=relaxed/simple;
	bh=vHJQ/cw3cVDLVX+g17TAUaie9vn7C9OHJO8eGNoSitk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nCLAQ7xK7scNxV39B4TARj/hdg+J7uDDejd9gAMMH1w2FzGlWuCjC+K3yHZ4bIyOgy+UamCDtGgFOmR6vNJqAyLADnp8T6FZ/iSV/wNukaiDC4hjhB9vpnxlfIqf9Ng0xFfxbfZsClFPxbGdF0z17vJHKjLkjasDcvMxGTS85PM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o/v/mWWa; arc=fail smtp.client-ip=40.107.200.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbYRjobHeuQyTuBOqfVL1nDmu7qWPlgpWMRu3TuDwZ1MVnXsKzTsRlepHzpZt19f6Yo8l/3phfbKPPV2iB6BD7npTRr9sImNj1KxQThCI/QLEXF9VOqv6QdRvLGFutWrdwVad/RP6X3XPYTQ0mnYPjN24J/4yqRGK9GqmSFldlqWIm1BmLL7/8X22jmLZjInebidbpPiB6m+sHo+2786qFgUsd2hf2shxPoNphclCgjR0/M6+T3ucyKVJ0FDGZRHtZUCRHTnmocX+6ILl/Li4jtOpdAfUa98IwtNbvofMefItmR3LalBrCiCpQZpns2gdUcCf2xgNMQ3mqoEH2qklw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHJQ/cw3cVDLVX+g17TAUaie9vn7C9OHJO8eGNoSitk=;
 b=OIU/XZxIscrB97yt/sVqKO+DDk4ispSlpnpFMkZhW7f77m3p3FJlZxxao+LxPi8NwmliQO+zq51gg83Lkl3wafxgwHYoggCtufJmI/gWbVnIO7OFfsZaIFIaMXIpcoWXEfBek8AVDtTSxPr9mDH15aGCFDOtXZSRavQ7RN9goSEdrhALOyQewkax0v6ucv/UNlTTkOOpDqnFwk90icJTEQnmP1Nou6ML9VyWzox0DcrTu+WPw7dnOtDyLnPkiTwMK+JYlm1f5FYdmJBK4cBUbpWoBJGv0KqaH9VjiV/auauxGlg2sHCGYDRpoXbzOUT7OSqOTpRl2cmaw0PqNA9uLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHJQ/cw3cVDLVX+g17TAUaie9vn7C9OHJO8eGNoSitk=;
 b=o/v/mWWaUEVyMG/Kx3i7DsObvGYvR+x7kBMIUvKBFbQ+LHbCfF6VD2UKsMSniCcaJ37RZ1314Mbcpk+A+uZenp6wbvGQUH1KzpK5fFrM/4v81ulvsz4VX4OL+yW0cRI3Et30IfQnbdnazu4GDDarnnn1NHjo/z/BHS7TrxySCYACgpKGayNPYIPS6Kf56lnCtF2dkq3oi8NCdVmAZJcbRK0glQJiDOzmZPIb1HldI7vtvsLoKedHwEiCFNqSaubnUoCq7ujFmZfwEU2mTP777nIQT2iXxdKp2+LozzaSs4SMW70vsMYHcG7g5+huvlbEPHv1fqOqfYjsV1+qVPl7ow==
Received: from CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20)
 by SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Sat, 8 Nov
 2025 05:02:08 +0000
Received: from CY5PR12MB6526.namprd12.prod.outlook.com
 ([fe80::d620:1806:4b87:6056]) by CY5PR12MB6526.namprd12.prod.outlook.com
 ([fe80::d620:1806:4b87:6056%3]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 05:02:08 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "dakr@kernel.org" <dakr@kernel.org>, John Hubbard <jhubbard@nvidia.com>
CC: Alexandre Courbot <acourbot@nvidia.com>, "lossin@kernel.org"
	<lossin@kernel.org>, "a.hindborg@kernel.org" <a.hindborg@kernel.org>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>, "aliceryhl@google.com"
	<aliceryhl@google.com>, Zhi Wang <zhiw@nvidia.com>, "simona@ffwll.ch"
	<simona@ffwll.ch>, "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>,
	"ojeda@kernel.org" <ojeda@kernel.org>, "tmgross@umich.edu"
	<tmgross@umich.edu>, "nouveau@lists.freedesktop.org"
	<nouveau@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, "bjorn3_gh@protonmail.com"
	<bjorn3_gh@protonmail.com>, Edwin Peer <epeer@nvidia.com>,
	"airlied@gmail.com" <airlied@gmail.com>, Joel Fernandes
	<joelagnelf@nvidia.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"gary@garyguo.net" <gary@garyguo.net>, Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH v6 1/4] gpu: nova-core: implement Display for Spec
Thread-Topic: [PATCH v6 1/4] gpu: nova-core: implement Display for Spec
Thread-Index: AQHcUGm31LMlKlcdq0WEFyDGEyMf4LToONaA
Date: Sat, 8 Nov 2025 05:02:08 +0000
Message-ID: <673640f6b26617bc5e1f4962bc2f9f7257346efb.camel@nvidia.com>
References: <20251108043945.571266-1-jhubbard@nvidia.com>
	 <20251108043945.571266-2-jhubbard@nvidia.com>
In-Reply-To: <20251108043945.571266-2-jhubbard@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2-4 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6526:EE_|SN7PR12MB7811:EE_
x-ms-office365-filtering-correlation-id: 3451b801-19c4-4168-e81f-08de1e83f812
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UTYyNnFjYkJGZ21nVktPaEFtWGxlMVdISENwSHY1SlMzZlMybzU4S09KYjhh?=
 =?utf-8?B?SDIycWMyT205RktKTGhnWnN1aFVCc09vcnYrdjJxelV5NHdEMDR2TXVxNGpG?=
 =?utf-8?B?VjVLOXkvTkhGVmczVHVDdEFYOWtCYlZWNzF3NlFGbVZpbHMvT1lwT0c5ZnBF?=
 =?utf-8?B?STh3VzFpajZwejlHTmpBWWRINFk2UmRwRDN5ZFVTaFUxRWpTSUpuRGRKbjJG?=
 =?utf-8?B?OVlyL1B1a0NnelljcHRyTVFBMk1RbmlYdGV2d2owRmJoZ3FoK2o3SVlpNk53?=
 =?utf-8?B?UTJ4cHZEK0M4aURFUG9VWUFoMkFkZ2NsUWw4aUM2OVN5clRsT1MrUTJwOUlY?=
 =?utf-8?B?MXg0TzZGWms2ZFlhVUVMaGZOTkVMZ3NBalpGSW83eTNaWkFFbm5rTE1XTHBs?=
 =?utf-8?B?cUhDR0I4a0wzMm5LTFhXeXBSNDlOVWF3aE1BK2pGMXNNUU1jZUlRSVh0WG9K?=
 =?utf-8?B?aTBsbU9CTFlOaWlSNzVIMDRQejRrNEhudVVMNlFDR2pMcGkyK0gwNUJkUW13?=
 =?utf-8?B?MUVQa0plcGVxcXdTaGtyYnRCUklBK1BPMDlMeG5ab3pvTGphRXovR09Nd2w0?=
 =?utf-8?B?SEE0UWNjZXR4RHlLWm5VR2UxVTM1WmUxODRKMDlFOVE4T2EzUEJLMWFjaERo?=
 =?utf-8?B?OGxESG9wS21BbDlZeTNPblN6OW45WFRLZ2FQU3hFWU5YUUlJTEQreEdYWmZJ?=
 =?utf-8?B?QXNSeXBwSWpNc0t6S24zaHRJU0YwZHdXUW52ekhFZ1huUFg4QjNpWnBLZVM2?=
 =?utf-8?B?ZmZHOXQwQWtqM1BkaVF3NFJETXBzSjNhWWgvRTR3c3VwblZPbEhPZ3U3dER2?=
 =?utf-8?B?Zm1wWFRoRUllTmhpZ2QwUDZ6eno0cWVNeUNGTnh6aWhqbGdyTTROUGk3L2hm?=
 =?utf-8?B?cllXWUQ5dmJQcDlGVmRLZXNlYUdBM3hPejg2OVJuMTJLRnZxc0dHcEZlak1B?=
 =?utf-8?B?ODdFOXBCR3VoWEdrWEZlSXhUaHdzYXl1NVErMmdGWDh6ZStkZm5qTURZaUE4?=
 =?utf-8?B?anJVQy9aOEo5ZWU4WTFTWFZSWHlxYUwyTUVlSVdOMmM5Y1FxNi9hZVJhWHZ4?=
 =?utf-8?B?NlVtRndISnFFRHBzdy9kUlJNeTFoNVRRNFpPWGM5N0Fwa2w5U2ErcEVrb3JT?=
 =?utf-8?B?dERSQVlVRUthSW5tVkxWdVZyci9tSzNMOFZzVEVyUTBaR0c2YkdsSjhpZ3Jm?=
 =?utf-8?B?dEJhUUowNlg1Q1FaMXFrdFBrQXk4bVQvVUhIMnhCc2VLT25JMGVESkxUMmk3?=
 =?utf-8?B?NG9VVUdiNGFkMENFRi94U255cGJsRzlGSStpbVdMN1k1dm5zZjRVckl6NkVw?=
 =?utf-8?B?ek8wSVBlRWFGbXBqRXNBR2FLeFhwWG1KemZJUUdkQ1BScG1GS1BYc0dKQjlp?=
 =?utf-8?B?T1Yzc1ZObENXc2xDZ25FN0ZkejRrcnYvRURUc2ZrZSs3c2IrdHRjYVplTkFq?=
 =?utf-8?B?Mm5HUEZYeDdzcWNSRkRqaWpYdmFvb0VwQUtYN3VQaXRTZEtpUzRHeWRROWto?=
 =?utf-8?B?amdzRGpqdVZoMXBOR1BGa25JM0grM2c5dWlSemNUY0VlQSszbGVobytQT1lu?=
 =?utf-8?B?RVdMU3NSbmE0UW5Rd09yN2EvdTkyMkl1ZmlqL0NYZ0lWREVud0g1UjNCM2No?=
 =?utf-8?B?a05UN2NUYjNCR0hmUDNVeWhpM2szNE81RDVmcTY3V2R6MG5DMlJ5NmJZcVBi?=
 =?utf-8?B?bVNua1hCaFVaMk5lTUl5L0c0b25JU2huM3JTRzFWanJnOExFSzVRL0pLK3VX?=
 =?utf-8?B?ejUzRTN6dndNM1I1VkpIVFB3enVDZWdJMUJhRkJEWFNUQjUxbXBDK0F1d1pN?=
 =?utf-8?B?bUZ4cWxnRHlBcDg5YUhSR1V3akQrMmJPbFJ0cndzK1M4N1dVMi84UU91bHRK?=
 =?utf-8?B?VzQzYzB3R0hwN3ZyVEFjWm9PMDN5cWFtSVhqODFoUVFCd2pzaXFoZUlKUFEr?=
 =?utf-8?B?SFVqUVNRR1puZFQwdFJCV1lISUYvVldaTzhaZG9JcXFxME8xSnVyR2p2RkpE?=
 =?utf-8?B?VjQrY2s4Y3YrcHNlWHdzL2FxYlI2eS9MSTZaWlVJUXF2WnpOWlFBVEp2Q29q?=
 =?utf-8?Q?aX+oDo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6526.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzRZVWo2ekVTeXJuS0NRRTZQa1R1U051WUIzTWxQa3lZc0ZoMytWNWpKcVZK?=
 =?utf-8?B?K1cxTHdsSmVDNXBYOUY4YXVkRWwrVHRXRHpFclRaUVdjVklDeW1vUjF2TXBz?=
 =?utf-8?B?UkVoOFZ2TEJsRE9rRzVOeDNub1lUeE5oSE1PRS9WOFdNSkZkOTdXemdDcm9h?=
 =?utf-8?B?UmRnYTJLOW52NHhZS1dkMGg2VW96NUJXaHJmdmF6Zlh1ajFIMlhPNlIxN212?=
 =?utf-8?B?VFEvN3o4bEtidDRNOEJmUzk2QjFRaEZNdWtmbU9OT2tOTXNmRW9zOWxMVTRE?=
 =?utf-8?B?UTV2ZEpsQzJ0cll4dXBIVlZpRzlDT3laRFZzTzNGQkhPUGU2SWNRT3Q1dWYw?=
 =?utf-8?B?aEFnSW5POWtUMVZxd1RKak9rbFlsNElVS0E3Q29oc05uSzhjblJvdjN2b3lt?=
 =?utf-8?B?SURGMzh1K1p0aVpGUHZtQVpsUzRGcUFUbU5LblIzaUlTY244cHR6NVQzUFlR?=
 =?utf-8?B?c0ErVE1ZZ2cwTnN2MnYxS3poQmpFWTNWOEVXcE9VaG9CaHJzU1BhWWEwZS9m?=
 =?utf-8?B?M1o5SzlIb1FlemlwZitlaUJ3SDhtV0QvK1Y2bWd5eG5xTS9GaWk0dk01bFJr?=
 =?utf-8?B?K1ZyaEpBMHV4RmljZ3luNUU0QzBCeDI2Qkp4SHpKeVovQm9EUlN0SlJRQlgx?=
 =?utf-8?B?Y1VrRkFWN1VTOTBzWUkxNGw0M3lXNWxSUkkrMWZUYWJNK3l2YzB6NURtcysz?=
 =?utf-8?B?NmMzall5MzdpRGRUZlFUbXM3bUYrUmo5THlxZzF3bFBKVjVmQVNPeVVzOUpm?=
 =?utf-8?B?T0hmRk9DeHp2T2lyL3VaVU8wYTVpVEZpdjZXeFNYMlhZeWhTMGRlUzYvcWI0?=
 =?utf-8?B?SzBxNVZmbU8xbUpGenY1bklOcGFManh4WExFckdRSmhVSWNMUytpdW9JVlYz?=
 =?utf-8?B?d1ZzMjZrZVluV2s5T3I0QUJGTGdXOWNUaWFpTWhBWHRLa2xmOXR6Z0w5ay9I?=
 =?utf-8?B?THVaeDIyZzZvVXpHckZFZm9ybjhBMjJPajVRcUdSSnRyRFRYSUl0T2g4aUFk?=
 =?utf-8?B?S0svOVB5SEgzaklXSHpkb1kxc0Q5WFRyQ2FTeCs5RmIrdkFDc1NlVER2Mjlv?=
 =?utf-8?B?QW1OK0E5ZWJIZUdPeTVBbU1Obm03T2FyTmtlNUlXdEhnN0dFNHU1TUxsSjBF?=
 =?utf-8?B?K2s4YkU0TkVodFJvamlYVXB1MHpwSmsvaVV4WWc0cXBRbEVjaktVcE16UXdZ?=
 =?utf-8?B?MzFsTnpBTkRZR0JDdG43enF1cThwRXhUdThZTFFWcHplc1R1VEU2SnZjNGhi?=
 =?utf-8?B?K3pCdlNFaENaSEVLeXlhd1R0eHR5VFBTUUpubjllekpuaFBFa3ptTU0vR3Fz?=
 =?utf-8?B?ZkZrSkNYL1E0bjZvaDRVRWFNMkZkbmRISzd5YS9WTktZS3QxdUEzTFRVcnVP?=
 =?utf-8?B?VFRFTWpHdU96Rm9lYzRVN1RQd0UzY3Z6ODhuYzR6eExHeWhoZHhwd0NjQkl0?=
 =?utf-8?B?K1FpeVpKMk5DNHYySXFCSEExeU0wTGI1NVhMZlV3U2lCczM0Q3g3SmpjOTRM?=
 =?utf-8?B?K2k3SDZGcENhdEVBRXgrdUVGZWpTeC93Zzg1c0JxR3dYYTdleG9oY0toamJ6?=
 =?utf-8?B?WG92UEpyeXFwZ2tEWGhPVFdOMWlGbzhUSWpNMHlxN3Rxc2c5dU9wNmFaSzRw?=
 =?utf-8?B?R2RYcFBWNjVPVk9ISjZaL1VEajFSKzRMaTdmR0hQNEh1bDZSajhJeDV1ODR1?=
 =?utf-8?B?Q0Y0YU9xaUpMME8vcms2SXlnL0VleS9Ua1pLMmFQQXY3Uzhoc1RqWGV6cnc5?=
 =?utf-8?B?WGFVTjNwUi9USldubDhLUFUwUlJPeXN0SmxnaktmWmdQeEVWZmRtMlREWmI3?=
 =?utf-8?B?RTFzRHRJMjlwb09sWmhzcThOZ25RWGVXZFo5aTRSU0sraUkxZnNtV0FPMURu?=
 =?utf-8?B?M0NJSmtFbDZXK25PZkVwR1ZTVXFHZzZoRThVRVBQQjI0bmRrUXVSbFNEMTNI?=
 =?utf-8?B?K1QrU3VIbkFlbk50c09Vbmh5QkxIbi9rc1hGRXp5QXp6NnE0OE1YRlRVRU5y?=
 =?utf-8?B?ZVpaK09DWGtMUVBuRkw0ejRBOGhrWHh6eUdDQXNGUWw5bThITkNOTFZmSis2?=
 =?utf-8?B?MDhLQ0hWVFdqa0tXQVY2VytlRVdiTUlyMjBidnBkS2owQVRocTczVXI1WFpn?=
 =?utf-8?Q?1O9QtWAyGAMN+9ZFgb3Mx1THK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B34084BCD091643BECD185B7C768E4E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6526.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3451b801-19c4-4168-e81f-08de1e83f812
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2025 05:02:08.4703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MhxvO7CajQgWbxu8RAsXkMfcEW+y3uWbD5w/mfjel55EgzhjT7u5hX3XkMtjyVRzaCIXlIhWHnRIt5FtcEm3ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811

T24gRnJpLCAyMDI1LTExLTA3IGF0IDIwOjM5IC0wODAwLCBKb2huIEh1YmJhcmQgd3JvdGU6Cj4g
SW1wbGVtZW50IERpc3BsYXkgZm9yIFNwZWMuIFRoaXMgc2ltcGxpZmllcyB0aGUgZGV2X2luZm8h
KCkgY29kZSBmb3IKPiBwcmludGluZyBiYW5uZXJzIHN1Y2ggYXM6Cj4gCj4gwqDCoMKgIE5WSURJ
QSAoQ2hpcHNldDogR0ExMDQsIEFyY2hpdGVjdHVyZTogQW1wZXJlLCBSZXZpc2lvbjogYS4xKQo+
IAo+IENjOiBBbGV4YW5kcmUgQ291cmJvdCA8YWNvdXJib3RAbnZpZGlhLmNvbT4KPiBDYzogRGFu
aWxvIEtydW1tcmljaCA8ZGFrckBrZXJuZWwub3JnPgo+IENjOiBUaW11ciBUYWJpIDx0dGFiaUBu
dmlkaWEuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEpvaG4gSHViYmFyZCA8amh1YmJhcmRAbnZpZGlh
LmNvbT4KCkknbSBva2F5IHdpdGggdGhlIGVudGlyZSBwYXRjaCBzZXQsIGJ1dCBJIGRvIGhhdmUg
YSBmZXcgcXVlc3Rpb25zLgoKPiAraW1wbCBmbXQ6OkRpc3BsYXkgZm9yIFNwZWMgewo+ICvCoMKg
wqAgZm4gZm10KCZzZWxmLCBmOiAmbXV0IGZtdDo6Rm9ybWF0dGVyPCdfPikgLT4gZm10OjpSZXN1
bHQgewo+ICvCoMKgwqDCoMKgwqDCoCB3cml0ZSEoCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiQ2hpcHNldDoge30sIEFyY2hpdGVjdHVyZTog
ezo/fSwgUmV2aXNpb246IHt9IiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZWxmLmNoaXBz
ZXQsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2VsZi5jaGlwc2V0LmFyY2goKSwKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzZWxmLnJldmlzaW9uCj4gK8KgwqDCoMKgwqDCoMKgICkKPiAr
wqDCoMKgIH0KPiArfQo+ICsKPiDCoC8vLyBTdHJ1Y3R1cmUgaG9sZGluZyB0aGUgcmVzb3VyY2Vz
IHJlcXVpcmVkIHRvIG9wZXJhdGUgdGhlIEdQVS4KPiDCoCNbcGluX2RhdGFdCj4gwqBwdWIoY3Jh
dGUpIHN0cnVjdCBHcHUgewo+IEBAIC0yMDYsMTMgKzIxOCw3IEBAIHB1YihjcmF0ZSkgZm4gbmV3
PCdhPigKPiDCoMKgwqDCoCApIC0+IGltcGwgUGluSW5pdDxTZWxmLCBFcnJvcj4gKyAnYSB7Cj4g
wqDCoMKgwqDCoMKgwqDCoCB0cnlfcGluX2luaXQhKFNlbGYgewo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBzcGVjOiBTcGVjOjpuZXcoYmFyKS5pbnNwZWN0KHxzcGVjfCB7Cj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfaW5mbyEoCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHBkZXYuYXNfcmVmKCksCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICJOVklESUEgKENoaXBzZXQ6IHt9LCBBcmNoaXRlY3R1cmU6IHs6
P30sIFJldmlzaW9uOiB7fSlcbiIsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHNwZWMuY2hpcHNldCwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc3BlYy5jaGlwc2V0LmFyY2goKSwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc3BlYy5yZXZpc2lvbgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9pbmZvIShwZGV2LmFz
X3JlZigpLCJOVklESUEgKHt9KVxuIiwgc3BlYyk7CgpJIGJlbGlldmUgdGhhdCB0aGlzIGlzIHRo
ZSBvbmx5IHBsYWNlIHdoZXJlIGEgYFNwZWNgIGlzIGFjdHVhbGx5IHByaW50ZWQuICBEb2VzIGl0
IHJlYWxseSBtYWtlCnNlbnNlIHRvIGltcGxlbWVudCBEaXNwbGF5IGZvciBhIHNpbmdsZSB1c2Fn
ZT8gIERvIHdlIGdlbmVyYWxseSB3YW50IHRvIGltcGxlbWVudCBEaXNwbGF5IGZvcgpuZXcgdHlw
ZXM/Cgo=

