Return-Path: <linux-kernel+bounces-812937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD493B53E71
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 00:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C7A1C824D3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CB9338F58;
	Thu, 11 Sep 2025 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="QZzb5BY6"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023108.outbound.protection.outlook.com [40.93.196.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6AF327A3C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 22:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757628220; cv=fail; b=EHIRoxOnWZhjBd1Ds2LhBZ9/4fvJBPyRY6NDSYtG53/dxK/2R131iBJbtDCVXhB1yP3yk/nMzHjWCSGCj/m+zBjbrUfjizGV4En5QIEQWjnElQnFaR3wWmrsaWsNNvD/vRtvUiVAakOYDhhsso9Oj4jSzpfbdcb2j3gxuM6VTQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757628220; c=relaxed/simple;
	bh=qpQjw1yJMXpx+UVWmAQyeuiLAVbeNpE9RIDKFac8siY=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BWvuRfMBeErCqdkpv0VC20e1vZ9DaR73O2INWC/lq2Wvwze/i1+uNoRip2OlWaAfZxfwbWeox5wPG/vgA7C7ULmQtGKbG5zCh+CTZyEvCgjEwe0gw5sFudvFm828x+YH6DTrshrnJzqAV92ZVPC7DwR3N2QODzzQx/TUWlZMC8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=QZzb5BY6; arc=fail smtp.client-ip=40.93.196.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lw+dBo78TtcqZQ3DFpZl9gInj5rZsBsBYk4TkWj0OCY5dV6R3abMJc7Fo2qgKAbB7/U1gf93yR4T3z9ghYjRa+KNTkeWxx+oPAOekeoHV/bIgusi09BsGJgiL1wAF6m5x9NXlqbPJVf6aRSTqzfdGufiHLbM3nNaTb8HvGl3QHVnKSBsmT5tIfHdyGSow0KKPDO2Ak04Acu6H5sgxQgu8hYx9gpc3EPU8phbXpTDN4OGQa12x+FncRJlGOaL3NdT5nBh8AK9v4kxL9ankuJhIBfbEuyLo6STraTsZLVLwhSr0lp5DS7Jlf6kjCSTSYH6qa9puBofi8tYEYxuFjVLjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLrzS5995+QUYnn1oLHMMTReLarVOW4xt/rPvHODSJU=;
 b=v/GjiOKmavIbwSr0Pr6qKz0LxufGPs3XrFuvAqcWDcfTXLRNK0oCPiFKSAmo544zunPgkeFAuQXS2L3CmHBVfyp+knmzPzQ/Zky75wrB5pde7M+6BiwdMPcVhBzFoQyXHr0glMnx+NCBepHOhb64uYFd0Whu00NbGo36jqf7znBi3rwEiu5LCcMC05a2SXoc7ujpRjFRzer5sRUSn+LhMiaoWGgRMZCpMG5M+ohiCcSCRtTKUGQcd11BW4J/UGCjHmUTwC9GrKPwKIKO2iqnd66OkGv42KhoxTlXOX1I8Qc/E7x4ePd458ScSy/jK73Qct0ORPv7hxZrlgRjkXbHDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLrzS5995+QUYnn1oLHMMTReLarVOW4xt/rPvHODSJU=;
 b=QZzb5BY6JUBmpPvIH0NuwSUofAeQ440zNsRgOdi287jVTqe+IbDW3yMaiL5TMdDB2+n4qspdarAqH9raM8fotynIkMSr5K2D/kl9XMHMo941ywgsh3khlhoda6v3LpN+b6iqUI9HcPlXxERfTxYhUc2C+LqCilW/gncTXJxrmoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 BL4PR01MB9175.prod.exchangelabs.com (2603:10b6:208:590::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Thu, 11 Sep 2025 22:03:35 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 22:03:35 +0000
Message-ID: <92719b15-daf8-484f-b0db-72e23ae696ad@os.amperecomputing.com>
Date: Thu, 11 Sep 2025 15:03:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] arm64: support FEAT_BBM level 2 and large block
 mapping when rodata=full
From: Yang Shi <yang@os.amperecomputing.com>
To: Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ard Biesheuvel <ardb@kernel.org>, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250829115250.2395585-1-ryan.roberts@arm.com>
 <e722e49a-d982-4b58-98f7-6fef3d0a4468@arm.com>
 <dd242f5b-8bbe-48e8-8d5f-be6a835a8841@arm.com>
 <aeb76956-f980-417f-b4e7-fe0503bb5a2b@os.amperecomputing.com>
 <612940d2-4c8e-459c-8d7d-4ccec08fce0a@os.amperecomputing.com>
 <1471ea27-386d-4950-8eaa-8af7acf3c34a@arm.com>
 <f8cf1823-1ee9-4935-9293-86f58a9e2224@arm.com>
 <bf1aa0a4-08de-443f-a1a3-aa6c05bab38c@os.amperecomputing.com>
 <39c2f841-9043-448d-b644-ac96612d520a@os.amperecomputing.com>
 <d7cd4004-bacf-47b0-9cd8-f99125e02238@arm.com>
 <fe52a1d8-5211-4962-afc8-c3f9caf64119@os.amperecomputing.com>
 <8c363997-7b8d-4b54-b9b0-1a1b6a0e58ed@arm.com>
 <4aa4eedc-550f-4538-a499-504dc925ffc2@os.amperecomputing.com>
 <1cfda234-1339-4d83-bd87-b219fbd72664@arm.com>
 <55a79826-48e3-41c0-8dbd-b6398e7e49a6@os.amperecomputing.com>
Content-Language: en-US
In-Reply-To: <55a79826-48e3-41c0-8dbd-b6398e7e49a6@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0040.namprd13.prod.outlook.com
 (2603:10b6:610:b2::15) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|BL4PR01MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 60efdd55-1173-43d7-fecd-08ddf17f0dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2xVVThseGNNYVNkQ2s2S2dVV2lsbDZFZVpTK3J2dS9lSUVjZ2NFZS9keW1F?=
 =?utf-8?B?SjM0T0pML0tiUVgyVGpYcG1vYTZyeW45UWM3blhZTy9ZeW9odmZOQkd0S21X?=
 =?utf-8?B?TGpQSWZvTUdTdHlHSFVKR0U0RVd6MFdGUGZJSy9aQ0hpMkxIMGQ2bEpobkNE?=
 =?utf-8?B?b25xVXB3ZVlhbHRUdlVZSm5UUUFGWFRKRHpIaVJwcmVKSVBGbFl3MmZ6NXBD?=
 =?utf-8?B?Zy9jcVJiZFV5Y244aHBtNTk1NlZabFpWb2dsQ1YyMGFWU05RTUpZeXVPNkhM?=
 =?utf-8?B?eEFRRUtxUDgwZEVZYTBJejhCMVQ4Sm9zQU9laGZEd1NaUFNwVXZtZ2NzTVpp?=
 =?utf-8?B?a2QwSWhIV0duVy9RSFRDTVVqWlhSM2ZPNWtZUWU0SlBhOUlJSlZDWlpsNW9x?=
 =?utf-8?B?QStMYTRlekluM3E5dm4vVmxKR0lZV0FtOEgySGVjbTRHU3o1cS8rU1VlVnc1?=
 =?utf-8?B?eTRtbDNCdnhwU2hZb2tzL3lETnpDSDU5ZzBsLytRSlIzMzZmOVVlNUZQd1lG?=
 =?utf-8?B?cml4VTFheDJlclhYZ3M5UjNvd0JnQk4yRlZVYmhuS0ZJVjA0WFN3T3YrOHZC?=
 =?utf-8?B?RVpEdm9XNzhHaGt2VUdQRnJmWVU4VTNtSHVUcjNDblBRQjFhSkNEYUEySTFr?=
 =?utf-8?B?K1lUalRNWkM2SHYzTnQ0SzZ5SUtqd01aTGFYRkU3OFd2ZWtyTFBTL2xaSnhM?=
 =?utf-8?B?M2tNUEpPYWpMQzJ0eXpIUzhoN3dRR0ZtVXkrSUFJQVNBZXZUdThQOGpFdUln?=
 =?utf-8?B?Y3A1eXVQZXdGRys4d2ZPWVB0V2Z2WGRDZ2tSK3RodTFOSzEzNXMxWVVkSGp3?=
 =?utf-8?B?SHZ6R3hsNGJoUVppVW9hQy9PYWpyU3JUM0dBWnB5MlFJbVlxUVlJNzZRL0N5?=
 =?utf-8?B?eHpiczdQUVpVdHFmUXhSMFBnTzB2ZVVPRld6YytsOG1xanVTSGJmK2pIRkFG?=
 =?utf-8?B?VWEzTGhNYXlKSUFKaWVUR3oyTmhVclFSK1djWDhrSjAxSXp0Q2t5UlNaY0xI?=
 =?utf-8?B?K2dSenZiSE01MHEvNGp2R3g5QWpkemtmVDkvaFlPcmtHdGVnRVVZdmlIT1Nn?=
 =?utf-8?B?YkdpUEpvNjRsbVU0MDdwNWZlUjRkNlNOMWZTTElCWFYzQnhnMXN1UEVSa1JU?=
 =?utf-8?B?V0ZCcWlZN29YTUxnVHd0b3c4WExVTzR5MXBQT09aaU1CQ1lReldLT1VUeHZ2?=
 =?utf-8?B?c2ZxRnEwRWtyWXVEWWhEMlpKTVVZaHpnWmpRMm44VldlM3YrQUhyWDNNRmJG?=
 =?utf-8?B?c1ptVzZUZDhnNWxDM1hBV3lBQVpOM0pnNUxVN2kwSmhFUnNwT3BuOWhTQ2hr?=
 =?utf-8?B?NnVYZ0NaY0d3MS9KQm1Ieks3QzVndGUweGppV0JmcGdFeUttREd1L1k0WWJh?=
 =?utf-8?B?VG9oUzBPY2tPWFQxK3ZBb2IxaHl2Z3FOSUhCVjBYUzUvMFlGenNkVXRDUkxM?=
 =?utf-8?B?U2hUcVJEbUJFQm9GV1dnUnRnZmdVMFlNQTRyamE2TDdMeTBxS1RRR3RpdFlI?=
 =?utf-8?B?elBmWE81bE4zem1JUXpHOGcrMWlTbjBOZ1JuQUk5QVVsY3FBWXBMVmFuanNm?=
 =?utf-8?B?SDBlV05WTWJQVHZpaCt4L3UzeE9WckN0blE0cEJTM1ZleHFtU3FXcCtSNmQz?=
 =?utf-8?B?VlJuSFVUSnByUW1Vck9ydmVqTmhsdURIWTQzR3VrSTZJZW8zdTFhT1UyaDh6?=
 =?utf-8?B?MmJBR1BtREt0VW1zR0tKMml4YVlONko1SHNUUU5WYmllUTZ4TFZ4RWlNakZv?=
 =?utf-8?B?UFliTVVsN1hxWlRoWVNGVGVjNkhGUi9ieEFjdHZHbUZDNWJHODdKQ2JWQzIw?=
 =?utf-8?B?akxkZTI4NGZ0SlpCL1MwSGI3emJwTldSU3l4cGZCMUgyNlFqV2NWOGJ6Rm1a?=
 =?utf-8?B?MzdJS2VreDNMZUV5TXRjci9BdWNocUZpOXJkV1ZneXNkNzJlL2M4TW5kUExx?=
 =?utf-8?B?bEJjemVVSjMxU0ZOYnM0QTBZemZkUzRjelZuYzY1VUgvOGQ4NmM5clZyWGtU?=
 =?utf-8?B?L2MwYWpWa0NnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGpsMWl1Nnc4RFhIVzZ4OTArNXhxQURjZ0x3dVgzVWttWHg3RGErTXI5OUkv?=
 =?utf-8?B?YmlLTmc3NnQvR1pjQWFOaEdTajFqR1M5VjY5cTU1bTNIR0FDNjBqdlhaSEI0?=
 =?utf-8?B?WGR5WWJFQ2ZQWlhIMlBNeERLWnJSZ2lIZGliaU9oSk81MnVGSjZZdlJNaGVF?=
 =?utf-8?B?K2hhM29BQ1dRZlV2ZTZIUmxSWlZRRDRXREdrUW1Tb0hpU3F5M2h5RHdEV0Vq?=
 =?utf-8?B?S3ZtbEw0M0txWnFzRWlvbkdmNlI4OU1HWGdhcm5yc0ZqUmcrcFBjMFJKL3lY?=
 =?utf-8?B?ZG9BTUZ1ODNkUWxXTUF6VXpGUUh4bWlhWGFJRHpERkpZd1d0cUJxYTY1Mmlw?=
 =?utf-8?B?NTJJYTRUUzN2cndVNUpSdWwrZkxpa0dNVVdiMFoyZVZkRkVobzNnYk9ZenU0?=
 =?utf-8?B?QWE5azBHVFB4VVdFb1MyQzk3a2ZsVytNMG9FOHFQRjkzWXdaMFdUVEVjZUlZ?=
 =?utf-8?B?VDVPVkplb29LWkpWSGI5eGtDQzBiQW9uUFA4SDFXVVVocGh0cmJINzlWR2hr?=
 =?utf-8?B?UEYzN2xqLzFxZlNCbElMU1lndnJ6VGIxWnZ1ZXhOdFdJeUpoYUs2TzRrVURM?=
 =?utf-8?B?M1JiR2dZenVTdnhEWTZObkhNRzdSKzU5dTZMektlNG5UTXhMWlZ2MGpmZkNN?=
 =?utf-8?B?WkMvSVI0ZWdod1dDUDhjS3VLZWx1ZDI4OTZJSllaRm54Y2QrOGg0dmZ5NmtP?=
 =?utf-8?B?dXlJR1JtdTFldXQxTFBkeSs2R0UzUWJnYk5QbiszYk1wMlJuYklxdU5jb00v?=
 =?utf-8?B?Vk9YdkJGZHM1cCs3emJYcTFHZjZMV2RNQzQvQ1M5RHRrU3pvNEtrYzB3T0Za?=
 =?utf-8?B?Ykhnb2t3ZFAySHBnUDBqRmQrQUNPWGMyVkVxK1lZS2tFbkNiS3RGS0E4NE8z?=
 =?utf-8?B?WjVXdXdPN3BMUEVGRXR6eEN6TGMxbHp0RmQ1SkFveXMyaHJEVWhLZjh6SHZT?=
 =?utf-8?B?OFpWTjI3TDZaMTFOMUwxWG9LTGd4QVp6Q0Z5bzgrNHJKZmNYcWtNbTJqdXph?=
 =?utf-8?B?ZkNIUm12Snp4MzlVaUNDcEZBY05YTUF5OS9CbWhxcWdpVnE5bndHM2ZvNGRy?=
 =?utf-8?B?REw3WW04Vm1HMnhhekRpQVNLY1Ruc3VScUNld3crUDlldG5Va01lWGNPSGdD?=
 =?utf-8?B?WDVCOGRxMVIxa1VpdU8xY3loMFJSQWN4QXgzOW0wdHpoMjZXd1U1OUd4dDZy?=
 =?utf-8?B?K1c0OVc4cGZTajJBcUVUL2N3d0FpeXBLZDR3OVNUV1ZZbTZUdFlvWTQxN0Zr?=
 =?utf-8?B?SkM1L05RYW9abDhNVU5lSHBBRjJaamhqcU5OZ1FXcko3cWhod2l3elAwZ0pl?=
 =?utf-8?B?TGhwUXM1MElLWXVVNmhRN09WUnJ5b2hrOXhNbEc1cmlZODhlSmFLTG9oMEZ6?=
 =?utf-8?B?TGE1S2Nza01ZRUJiSE5OZDgyS1hoOWlVK21yK2oraWVDK3VKaythb1gvcE05?=
 =?utf-8?B?UEpMUXROMTVGeWNUZURFNk1hL0hEUldyVDMwdUpKbFQwZXl1U2YrQVRNdENJ?=
 =?utf-8?B?M3hFRjRhWlJwVTZjZVZXVGk3ajA4TmZRRFVoWjdFdDFRV3NkRTZmenJJTGhO?=
 =?utf-8?B?d0hFZEwzdy94OWNZcUt1S3pKa2pHTnNQMll6eHE5Q3JKTElWbHc1cHhRbkkz?=
 =?utf-8?B?cE92ZzhFSnBENWpFdHlrZ05sN01yRlN4Yk5xblExQjJQTzh1bzFCeEdBTzBn?=
 =?utf-8?B?aFEra1dVUlJUSnA5MUNrMW1FenE1ZnJVRDJ3R0JXNGNkSyswc1JrYnB0UzB4?=
 =?utf-8?B?dnd6bEdITFgyT09vR1YwKzlkQkduZ0ZNVXhLVUFFd3VFNmpyaG9rMTVNWjVi?=
 =?utf-8?B?MzBtbEU0TDNjT2dTcU0zK2ZyQmJNOTc5R3FwYjNWY2RKcWF3SWJEVWd3Y3lj?=
 =?utf-8?B?MXk2ZCszRWNqdjkvR2p6WjJrMDVWbW1ia3NpOEx2ZTd3K2c1R2FYdHM4WHhZ?=
 =?utf-8?B?QTJOa2VROHNXUjJHU3laWWdRYXFxc1EydXh0MjYxaXZRVmM5ZW1uZTdURHRN?=
 =?utf-8?B?d0NidENrT1BuekFVV3RvS01tR055Vnp0OUpKWDI1T0VYN1Y1QmlEQ09EUzhV?=
 =?utf-8?B?NnUwdStuUjl6c2JUL0tENnJhQ2ZkN0VBS25FM2FpNkpRV1J6Q0wwd3cxbEhh?=
 =?utf-8?B?MDBoVTNLSlQ3eHpxa3JDWUxCOXZpYzZBM2lkSjlzY2JXWVRzekJsejhRcTlw?=
 =?utf-8?Q?kbvDOQ8NR2nCPpOsTP4GOEY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60efdd55-1173-43d7-fecd-08ddf17f0dbf
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 22:03:35.1496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzMME7EVtgRU1tFSf7U/Grv3lmIMGqxBLr29LO9nHVTJKKmF/aSBFKfG6tBXFS59rsTceJncJb0FVTt8Q86Qv21zcqvlrWH+ZhuuI56GoXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR01MB9175

>>> IIUC, the intent of the code is "reset direct map permission 
>>> *without* leaving a
>>> RW+X window". The TLB flush call actually flushes both VA and direct 
>>> map together.
>>> So if this is the intent, approach #2 may have VA with X permission 
>>> but direct
>>> map may be RW at the mean time. It seems break the intent.
>> Ahh! Thanks, it's starting to make more sense now.
>>
>> Though on first sight it seems a bit mad to me to form a tlb flush 
>> range that
>> covers all the direct map pages and all the lazy vunmap regions. Is that
>> intended to be a perf optimization or something else? It's not clear 
>> from the
>> history.
>
> I think it should be mainly performance driven. I can't see how come 
> two TLB flushes (for vmap and direct map respectively) don't work if I 
> don't miss something.
>
>>
>>
>> Could this be split into 2 operations?
>>
>> 1. unmap the aliases (+ tlbi the aliases).
>> 2. set the direct memory back to default (+ tlbi the direct map region).
>>
>> The only 2 potential problems I can think of are;
>>
>>   - Performance: 2 tlbis instead of 1, but conversely we probably 
>> avoid flushing
>> a load of TLB entries that we didn't really need to.
>
> The two tlbis should work. But performance is definitely a concern. It 
> may be hard to justify how much performance impact caused by over 
> flush, but multiple TLBIs is definitely not preferred, particularly on 
> some large scale machines. We have experienced some scalability issues 
> with TLBI due to the large core count on Ampere systems.
>>
>>   - Given there is now no lock around the tlbis (currently it's under
>> vmap_purge_lock) is there a race where a new alias can appear between 
>> steps 1
>> and 2? I don't think so, because the memory is allocated to the 
>> current mapping
>> so how is it going to get re-mapped?
>
> Yes, I agree. I don't think the race is real. The physical pages will 
> not be freed until vm_reset_perms() is done. The VA may be 
> reallocated, but it will be mapped to different physical pages.
>
>>
>>
>> Could this solve it?
>
> I think it could. But the potential performance impact (two TLBIs) is 
> a real concern.
>
> Anyway the vmalloc user should call set_memory_*() for any RO/ROX 
> mapping, set_memory_*() should split the page table before reaching 
> vm_reset_perms() so it should not fail. If set_memory_*() is not 
> called, it is a bug, it should be fixed, like ARM64 kprobes.
>
> It is definitely welcome to make it more robust, although the warning 
> from split may mitigate this somehow. But I don't think this should be 
> a blocker for this series IMHO.

Hi Ryan & Catalin,

Any more concerns about this? Shall we move forward with v8? We can 
include the fix to kprobes in v8 or I can send it separately, either is 
fine to me. Hopefully we can make v6.18.

Thanks,
Yang

>
> Thanks,
> Yang
>
>>
>>
>>
>>> Thanks,
>>> Yang
>>>
>>>> The benefit of approach 1 is that it is guarranteed that it is 
>>>> impossible for
>>>> different CPUs to have different translations for the same VA in their
>>>> respective TLB. But for approach 2, it's possible that between 
>>>> steps 1 and 2, 1
>>>> CPU has a RO entry and another CPU has a RW entry. But that will 
>>>> get fixed once
>>>> the TLB is flushed - it's not really an issue.
>>>>
>>>> (There is probably also an obscure way to end up with 2 TLB entries 
>>>> (one with RO
>>>> and one with RW) for the same CPU, but the arm64 architecture 
>>>> permits that as
>>>> long as it's only a permission mismatch).
>>>>
>>>> Anyway, approach 2 is used when changing memory permissions on user 
>>>> mappings, so
>>>> I don't see why we can't take the same approach here. That would 
>>>> solve this
>>>> whole class of issue for us.
>>>>
>>>> Thanks,
>>>> Ryan
>>>>
>>>>
>>>>> Thanks,
>>>>> Yang
>>>>>
>>>>>> Thanks,
>>>>>> Ryan
>>>>>>
>>>>>>
>>>>>>> Tested the below patch with bpftrace kfunc (allocate bpf 
>>>>>>> trampoline) and
>>>>>>> kprobes. It seems work well.
>>>>>>>
>>>>>>> diff --git a/arch/arm64/kernel/probes/kprobes.c 
>>>>>>> b/arch/arm64/kernel/probes/
>>>>>>> kprobes.c
>>>>>>> index 0c5d408afd95..c4f8c4750f1e 100644
>>>>>>> --- a/arch/arm64/kernel/probes/kprobes.c
>>>>>>> +++ b/arch/arm64/kernel/probes/kprobes.c
>>>>>>> @@ -10,6 +10,7 @@
>>>>>>>
>>>>>>>     #define pr_fmt(fmt) "kprobes: " fmt
>>>>>>>
>>>>>>> +#include <linux/execmem.h>
>>>>>>>     #include <linux/extable.h>
>>>>>>>     #include <linux/kasan.h>
>>>>>>>     #include <linux/kernel.h>
>>>>>>> @@ -41,6 +42,17 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, 
>>>>>>> kprobe_ctlblk);
>>>>>>>     static void __kprobes
>>>>>>>     post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, 
>>>>>>> struct pt_regs
>>>>>>> *);
>>>>>>>
>>>>>>> +void *alloc_insn_page(void)
>>>>>>> +{
>>>>>>> +       void *page;
>>>>>>> +
>>>>>>> +       page = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
>>>>>>> +       if (!page)
>>>>>>> +               return NULL;
>>>>>>> +       set_memory_rox((unsigned long)page, 1);
>>>>>>> +       return page;
>>>>>>> +}
>>>>>>> +
>>>>>>>     static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>>>>>>>     {
>>>>>>>            kprobe_opcode_t *addr = p->ainsn.xol_insn;
>>>>>>> diff --git a/arch/arm64/net/bpf_jit_comp.c 
>>>>>>> b/arch/arm64/net/bpf_jit_comp.c
>>>>>>> index 52ffe115a8c4..3e301bc2cd66 100644
>>>>>>> --- a/arch/arm64/net/bpf_jit_comp.c
>>>>>>> +++ b/arch/arm64/net/bpf_jit_comp.c
>>>>>>> @@ -2717,11 +2717,6 @@ void arch_free_bpf_trampoline(void 
>>>>>>> *image, unsigned int
>>>>>>> size)
>>>>>>>            bpf_prog_pack_free(image, size);
>>>>>>>     }
>>>>>>>
>>>>>>> -int arch_protect_bpf_trampoline(void *image, unsigned int size)
>>>>>>> -{
>>>>>>> -       return 0;
>>>>>>> -}
>>>>>>> -
>>>>>>>     int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, 
>>>>>>> void *ro_image,
>>>>>>>                                    void *ro_image_end, const struct
>>>>>>> btf_func_model *m,
>>>>>>>                                    u32 flags, struct 
>>>>>>> bpf_tramp_links *tlinks,
>>>>>>>
>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Yang
>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Ryan
>>>>>>>>>>
>>>>>>>>>>> Thanks,
>>>>>>>>>>> Yang
>>>>>>>>>>>
>>>>>>>>>>>> Thanks,
>>>>>>>>>>>> Yang
>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>> Ryan
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>


