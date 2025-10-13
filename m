Return-Path: <linux-kernel+bounces-850912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAB8BD4E67
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CED948815B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF9230F944;
	Mon, 13 Oct 2025 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OGRBiqEj"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D740530F930
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369693; cv=fail; b=rVKYBrBEKs4zol7K2uojrTxtgR6Mjid1RN0DTr/IUIFibkdR3QK1WWGozUXKbGsMCY3vQYFnkbWSA0G7CE97d3pZuoijIGo5Xal8v0Cn+H4KFtgJ9tyfaurXyfXLxp3ciGeUog7m0MccPgJVHXopDZbqXIblYlrVqCboQ/tggGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369693; c=relaxed/simple;
	bh=I9OuCdo1vWSHSGwIVNUnLZtxOSvqcXTgpF8JiJ40onM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hg3IsHmNp6Ch+8SAXaib07T91Xx/WYwz4akV63S7lEM+slAvUe93PK5ya7XN/RxgSjvt2ePVM6RIjog+9+ArtHf4qaHR2m9Z6zFJAqnULBFJepT17couor7+BkBa3kuLyHORcVZ3eHS0hX4E0i8p1X/IR6Nype/7GFfze+q+i/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OGRBiqEj; arc=fail smtp.client-ip=52.101.56.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIu68gIqYlEM/s9LLNwRmCFFaKW/wNlhaxin7kqRM56jlNcI/P8A5crZW54ggFR5tuCgmfMk9CkRPs2qGLv7yMAg0CrWeVsdXz/0UyWZYsZt6dnJ3DqFcvJZL5pQuWyUAXPRYFsmTs+ehA1k6WiIEDGhjLpXO+kDoGksur4l4mFvm+pcmbwnOSpFxU8d+rf2PG1NOR6b4dmONvQJ4O+ZMsPV/TKPQGX5rprOcoVxowoDNW0IcmGApOin/cfdUZxurq9gUCwiTH9+N/+TumdNj45ads3ZzfoXaHGZNwE1oEtN1q6QPHS0j6lDrrGsw+G4DE9aNsBtYhvJPSWZ+dAhqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKqjdsjn1qU1G2WA3NlfrXwWrFk7nIjv8NFMdWKYI/Q=;
 b=Fd0PwjOarIOKe7SAyhZ3OEEy/CK+m9gF6reZyCntjOk2rZDaWJvaE0TyTwC6e7fOq3pm+SQ12Kea19U/JodzXIN7qK35deFH+ePkAXk18QOBHZihGw6bvRAlFDAovMK9+PEB00Dp78iOfmU7colPlVU1Og7ilxguUst0SLOhKdiE+MbriKu0L/lMKFHLhR/HRQWbicK9Dui7RpvS1/adKBkuMKf+2e9EkkVDUk5i08VUVeuNYmQARkNEUVI7f6ZLTdtp4ao6Hd7qCK9lcqYuG6Bx/N44OcVrs+bZ4VliVlDKpAbc8x0jMCYyw0bFUynwiDe+Ev0LT5qyxGhg5I3v2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKqjdsjn1qU1G2WA3NlfrXwWrFk7nIjv8NFMdWKYI/Q=;
 b=OGRBiqEjC+VOnGrNFqxmxfzUUmpL6GO+MLTpk6oZ45bTMlwBI/mqtqSmVEkoLx9LMwAkz0wj2ZbOUDBsdSBzXMOgCZAMYPW5X5RU9D9rt+SfRMjA8BNbxiaU25DiKcSqa//aZsxqoWrNuKoCa3MHG8wqeOyR0GfDVSzbedEIl/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.12; Mon, 13 Oct 2025 15:34:49 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 15:34:49 +0000
Date: Mon, 13 Oct 2025 11:34:40 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Rong Zhang <i@rong.moe>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/CPU/AMD: Prevent reset reasons from being
 retained among boots
Message-ID: <20251013153440.GA78919@yaz-khff2.amd.com>
References: <20251010165959.49737-1-i@rong.moe>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010165959.49737-1-i@rong.moe>
X-ClientProxiedBy: BN9PR03CA0626.namprd03.prod.outlook.com
 (2603:10b6:408:106::31) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: faf79389-383b-402e-6e39-08de0a6e0b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qwhS06N4jjO7Mwn/Shk3YIN9RHwNbeBAWPwTQXk8LWv7QVlR6GxU8b/jitnW?=
 =?us-ascii?Q?GJwn0JELRBXt5+g5nqEqrKFeEaLvfBXhmcy7Fbui+kVwmEKe/pv2jCN/pH+M?=
 =?us-ascii?Q?RCxRmqkEsY7WaMr8/knNyzyk8l0WW/UddyV6sG7UQt0DsuSCJcbQZVHDnHN5?=
 =?us-ascii?Q?T5c2K2FmN/qR9jYUB4xzhdJGTSjUPEKlZxLi6rJOdolDmm0y5doH2OXrkgRg?=
 =?us-ascii?Q?dRCSZhh9kvFjRLh6lbPgS0qAyiP4VcUAnzltAFZ7xPXhlvGgW+bFqKMEyI2i?=
 =?us-ascii?Q?AukH/IkQ9GgSfGykY986T/stD0YoP4sIS7OM0Utq2NSjQVt4aRKuYKQJUlbL?=
 =?us-ascii?Q?NVKYgVIzNcPla659Hx2vap7y1TliGHJySCCrLo3UlYuTocpiRkEnnJrqo49N?=
 =?us-ascii?Q?8QwJCzvqQZKhPpuIuS6v5YW78RsF2LF6D3BduiuO1zcQeijrjLd10tihUbBE?=
 =?us-ascii?Q?chneFCmQ0KTpW/J6kc8f6k/Ds+ZyWpJUqNL7YJesVFBt1Ic/tz1V95Usv4NY?=
 =?us-ascii?Q?u8/Jt/6ZUSPYPD4QbEh943vyAjmefBQ72BFJHNRVP5P8FSvXYRJ9TCO6XntA?=
 =?us-ascii?Q?SNpHhWmELiqqRB040naTPpO81Br/Yn8LV010Uw7Mu/5ICh0TrdS/QjIliv54?=
 =?us-ascii?Q?hTE8cGn+L6BNqp0rd5VuHa+MnKxZjD5brw1V1vxKaH2+IeH1VlsKFUyE4e+l?=
 =?us-ascii?Q?AXvsLSWbvKxcI16Q4E374/5yv9rEXrjGNG2t/+vuoCgMg8U5FU92CMyR54Qq?=
 =?us-ascii?Q?SS6GmDr8qlC7hqIc/jFDsUmvrSIwCfwgDBsBTCRKfFhCG+FJTL0RLB+CSmvQ?=
 =?us-ascii?Q?MjHRT5ZscZmBI2gG0wtwg1Y0C+3lAc9Eyio42BLjL0knKYXxNgXAFGP1UJvO?=
 =?us-ascii?Q?jrBjyR1Scy8r/5hKfdVAp0xCqYzI8TsXVH69B80p6+il0o5avAhHDE3/af1a?=
 =?us-ascii?Q?bMs2/+G/4Dc8QInbcbCb82DfgLl6EYfEXgDWFlMxVLJhW8If7LUtealnVJOz?=
 =?us-ascii?Q?dhJyIi+k/AbQVVscl9OreEBOWMgFCaZ1PUg9O9eV+CQnIjU8agzpnOWtGVO4?=
 =?us-ascii?Q?0gmVyUXM2PvCHc42JIewrDs9kFuntKVVXQ4WJPY2MYYR1Bs4xTU67+Zs8jri?=
 =?us-ascii?Q?Bv7EeoXLuvIIy4ALRhfVNRxNh3LnXFKbYVUmuTxXOTz0+OfW5LRKKRMmOfiY?=
 =?us-ascii?Q?7piFKzkjLuib5ZTMdFsQ8d7Bsl0KzA6G9dTttDDaPrY+T82AXLKwc7/8iaYc?=
 =?us-ascii?Q?Xr8YdLvYZ2IZL2bZh1k9oQkSXAnNaoO2mRJ7waQ3kDRSxw/fC1GB7dIUGpak?=
 =?us-ascii?Q?BmPPtrVMuFmL24EC071aBjpolggkJcFejrhR9queRz3fNuQuWx4X6wczLamU?=
 =?us-ascii?Q?J0nqOV694VJex3gSozvjUfxaQKCw1KuBWfQjypaceeiIFVfEyYOpUMNPss5u?=
 =?us-ascii?Q?Fzoh72pzBRL45PAYZ708X3TYI0kE31ELOFwp2F3M25EpdF1Wu53gFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QtzQ19JjD5xtECY+FbVDBu45csqxrROhDi53JUA0YeNfuuNgGR6IBZo0a/y+?=
 =?us-ascii?Q?AdjWSVr5loMEPxNluquAsuhiF0iGg2ArIzd4xwRo/L7JyTVd3AOUtA7Gonf0?=
 =?us-ascii?Q?CXUUcBGN8XF6l+WQ8nyI6lLhRVf1RSmmVylIjfCh3rHmcabuSOoJG1GDvPJn?=
 =?us-ascii?Q?tjnH7NaHk1cz+eo5yghhQ04Wr1TbXpGLaNfJmmbEEhLAwyxnWRF3fug+PfRp?=
 =?us-ascii?Q?aQa7oXilCxgmirpux0ArnpzJE0Kyc0vXsmAJc22ViTkcK8RWzVh5SAwFi7PX?=
 =?us-ascii?Q?f2imjiJFK9zVF/xgdWtDAEqsx9ExUgBFkjBZVihN9GmIay94YjxKb5ESylqv?=
 =?us-ascii?Q?3gIkdYqb3eI6ygBmEsFrt8xtYNuOtf2Vf35dv/Y+Ku6F7EUGc5HXzIQEgO2Y?=
 =?us-ascii?Q?1RmcabUh4Dq+pj0N9PyXDrCIOOYLRsnNvcSqIF+BT9yaPqoim1/nsYwghJDk?=
 =?us-ascii?Q?c2IpUT7TV8xInsCfoe6hVq+BIYh+xGz8cvmhSkavD0HMRS3oj1aRHaqJ9evx?=
 =?us-ascii?Q?ZfyIXOZDE2UvvK5uLhPDb7t1z5B3yBB6D6jPTAITtcmMe1lBY4YOK20Zp2mX?=
 =?us-ascii?Q?PLfKz8SYD2Gh5I55/6EBoZ07+yAePjUJuDvE2MgxD0bDXD5iy43D4wXhFb9r?=
 =?us-ascii?Q?d4rKOr20PyBSAX9caV5HkhuRBEcMyMevYu62CoH3f1KV4yHsAX2rT9GPHvKU?=
 =?us-ascii?Q?XICIk2pcDbOuyxco1GqWoudNUw9lIU8d96QO26QsPK4gvAlMjO16E8rkfl9F?=
 =?us-ascii?Q?Eo2HBWsj5mlTDjg8JM/Wk4K4VZRIL/WQQT0X1tHGJA/rfL6PaUlgb9tGP5ym?=
 =?us-ascii?Q?ET/Pffz6uawaXSx8WYhZvFK/2hpzQT4H2IOqGnqs0krKKpfw7Lgsd5mWn9Wy?=
 =?us-ascii?Q?/NL1a/TNGj90EeQNl9RA27e8H82u1HGl75Z8p2gUYhWJiPAySn+aRfRi+N0Z?=
 =?us-ascii?Q?lfmPfzLZ88HwQP190LNpoJaQ+rh03vadj/tWr3OuIu9UY9zFAwWSjqOnIJ5o?=
 =?us-ascii?Q?JGN8evMXDyxdLIBFul9LxwCVK5CjIBS7IzUqZ4yieXm04Qedb4i9wtLcwOrg?=
 =?us-ascii?Q?0ot+HyJJCLUCx4sL6+IBgcj39s1LO5acBZ9Ur0GQEvl24K3zjRfdOhKBn7SP?=
 =?us-ascii?Q?+S0jtbTqpOwwQlNwUGu7pWBeXXO0v3iqFE+dmXkGFp2ifbAbG1YzmHpMdbcx?=
 =?us-ascii?Q?nxDnYqti2vX00fFZbsCi9XxhnrKIg+FhXjx23RNrO4oz8RbJ80fOsILo16PB?=
 =?us-ascii?Q?SvsVHNHKjQ24Z4I0i2mhLtw9aKe6wiIwQ/RxEYnwCdnrnVHC3g+jacL4IWKX?=
 =?us-ascii?Q?7v8LmRl2FzPJhhYLCBXj6bRQbq0ZU2WakNx43gaYVGJwh1oWxyOxRiO9IRxg?=
 =?us-ascii?Q?5OKc3eyqeo7UmnLeUEgLqmBYODq/K81eZqf/ltDkR+Qm7qugggL1cdfd8t4J?=
 =?us-ascii?Q?tKTBzICHT44uEuccUS0nmSljrSE5EJUY0m0wkskRvk6H7d8GnUb79e2HzS01?=
 =?us-ascii?Q?RLXQUqvWy+MOkw5ZUWx7IFtqQLiA73Y78kreMN2Oar9Rvok46JlOhYwnpsOT?=
 =?us-ascii?Q?T1OZFwKlsIFas56WqQd/dYOIuSP84JGmKz56devw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf79389-383b-402e-6e39-08de0a6e0b5c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 15:34:48.9286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YbbjANqGcTvTxPGO7ozwu0+q0a1MAt2w14LimCBOsU/9jzL/bospwTbUJQZdpxhhzi+X7hTUNsgTNRe5hc4Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329

On Sat, Oct 11, 2025 at 12:59:58AM +0800, Rong Zhang wrote:
> The S5_RESET_STATUS register is parsed on boot and printed to kmsg.
> However, this could sometimes be misleading and lead to users wasting a
> lot of time on meaningless debugging for two reasons:
> 
> * Some bits are never cleared by hardware. It's the software's
> responsibility to clear them as per the Processor Programming Reference
> (see Link:).
> 
> * Some rare hardware-initiated platform resets do not update the
> register at all.
> 
> In both cases, a previous reboot could leave its trace in the register,
> resulting in users seeing unrelated reboot reasons while debugging
> random reboots afterward.
> 
> Clearing all reason bits solves the issue. Since all reason bits are
> write-1-to-clear and we must preserve all other bits, this is done by
> writing the read value back to the register.
> 
> Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last reset")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537#attach_303991
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

