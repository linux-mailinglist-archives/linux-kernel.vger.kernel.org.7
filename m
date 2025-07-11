Return-Path: <linux-kernel+bounces-727760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24485B01F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A6E16B2C8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA1518DB24;
	Fri, 11 Jul 2025 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mlgtVkrs"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92A42A8C1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244637; cv=fail; b=otSdYK4I5LG2KrLOJDbout4mOWlfi9LYiKZ4gQn1BEHFac7boBZOpZc+guwdHHZ+LbU9ZGCjVfXjQBV+et+ABqLSvxpM+JQaFJztDse4xTjxLiFJNbx26cWb/Bgnu/QJuKzURc48MbRqkoy9ESW4I6S2irtV88AVZDpA5Ev6uvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244637; c=relaxed/simple;
	bh=yiAfMoHBtR1OUvIB9X3wkEJHr9EfvrfWvyxDiGGlHN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iVKfxFRut2U81PJnsYd6KYmUYTnjUeJmKMi75IS6U7OEzHcMltlkMG5uMCQ5nDgdv8fxlezgUWMQ3UFn+DBUogLjLP2mIVl/v3advhQFSegbcXKw7+UtP4uNud984i9CfyVnZ5ByEWKVE1FgOmBRr40hG8SKxyha/26ZAWFg2dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mlgtVkrs; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jv+qgeRzJKRn+Ld+ajXrhn8NveyYxWkardyCVBIpKcevVglJoSHX7TTyIOLmTUa2EUjiKzmMxPFi8FIuWSiCGoUYpEocGA2Wr1bmQNxw15Y7ziJ1HIPg9eQwg3llrHDSV+uH935idicNGr0LetUV2qnkMNVlnUAd3t0u3F8TL5tSmx/z8Te7XPL4X7o7YmLcG1xCWW0MLoWE7py2SLk489Qghajo6Cqy+C7rc99mLSONYs13akK3iXV/4USwifpJ+6RN6ftjJYwBz5HRCQKYpgIMdxORddPewUZas1GqyRn585vE7znp21WYJacbaWv7jH+UcBURSDSZ+7jDToraNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzTS+iTUyLd8G6/KA+rEQhGGQpG1cOvV2qquIGGan3M=;
 b=hKhPHCV/8C/rhNQj2d2FA9bhYDbrVllM4AzFMJQTYff56ABV35cj1IzGQQWtThOJhEdGMnGgtZuBGigTXLxZFZ+fRT0obb8fb+VqKrm+Dr3OrfEaH0cXmVeBHKaBxXWC3E+1SpdHPZ711ki5m2Deos57JT7oolmkN/p6hIuNhoqXjLiWZ2mlkYWo3tDi8j3HdkKB4YLtWI8rUgQPJIGSzp3S+/TnWHp5PFJnnWIDLsV6jLG+dTWuqcgZDZlg1MpvxW7Yotij6g54n4Ykl7oMB+Qyu963tQ9jWik3KLL4Q05NU/G9tmKOgDuoT40h9odqDfjJtTweYRpxUf3gfxVD+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzTS+iTUyLd8G6/KA+rEQhGGQpG1cOvV2qquIGGan3M=;
 b=mlgtVkrsgh8P5DS9A/NKE243yw8K3eLfDM33GONRMP/S6BAv2Ka572AVAFU25wlCc5bP2tF54Oge9S4bB638bZEIZhFki+gp/rgTNr+9thuOfFhctuWIw9xtx/xOzo8jXLGOpWrnxqL+5f1sD4tFFzcCC0BXR/JpBR+4yU9pySznlYRhq5Id4GbtVec2POgMUSagP+HFPGlWhPD4VBl0FJEhXkviGIYQhiHk6eRhgqrWN+0msVo7rbEZbesuahba87FmsD0bK064Xbekl2sWIa5kzaFBVCAbVCv2OHVCXpUnNHV0xJCTSaAWuBLoN3iyIl/vSIvs2Z08JDCx6q9tBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV3PR12MB9142.namprd12.prod.outlook.com (2603:10b6:408:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.31; Fri, 11 Jul
 2025 14:37:11 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 14:37:11 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: move unrelated code out of
 __split_unmapped_folio()
Date: Fri, 11 Jul 2025 10:37:08 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <2AE055C4-BFFE-4B61-A96A-6DE227422C7B@nvidia.com>
In-Reply-To: <c7e82a13-aa93-4eb3-8679-29cd32692bd0@redhat.com>
References: <20250711030259.3574392-1-ziy@nvidia.com>
 <c7e82a13-aa93-4eb3-8679-29cd32692bd0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0356.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV3PR12MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f770cd6-947d-4bd5-1311-08ddc0886bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkFHY0ZNOFM0VnErcEFEN3JLcVhXYWJoazJSZjNXUHhPd0RSM01kNysvNWJ6?=
 =?utf-8?B?Q0prT1pvTEdJVGF4ODU5VTRSdG05aVEwZ2ZESUdFQjY2NkNDZmg1aGh5NWJD?=
 =?utf-8?B?TStML3NNd2JXUmJxckUxZkVFMUhvTk13NXVmMmFYWE1UaG5NTnNBUXgwT3Mx?=
 =?utf-8?B?UlppV0c2RitPMGxHUWVWeE1zMU93bXgyZDZmYWpvODgrdW9ORGRiMXRveEpZ?=
 =?utf-8?B?TXozSEhZR1lPTk5lem05bDRVUWNlODJEMktPR3AwR2tobUdrRjhzYWkxTnBM?=
 =?utf-8?B?TUd0QjBNWThvUENUNDQyUlYwdzVoWUk4ZldsWHdhc013TUo4SDRHTjhEdUJ4?=
 =?utf-8?B?UlNpd3JkQjIzQ3V6eVprdENnUHlvSTJiWXRzUGhZc0RkbUxFS3RNSkRnWjdH?=
 =?utf-8?B?SEFkT1hQdkhVY05xclB4SUd2dUUycG45eTNGN251WjZiZWg0cVRDN3NtVUVP?=
 =?utf-8?B?a2FkeklKeFZjSTg0Vi9NZE5HWHVPSGsva2FMbGl5Qm0wTEFMYTlYbTczYjVi?=
 =?utf-8?B?YVVQODN6aVVOV3Y2NXU2ZWdBZVBaMjdYWWNxQzYwcjliajhCVjU0U1h1Z3ZJ?=
 =?utf-8?B?WXFONGROZ1VrMW1ZamNiaktKWkU3NlNJU3ZpY1U2UWhNN0JsWUd4TlRhWnpx?=
 =?utf-8?B?MkY2VmNyVjZFYWU4OUJjczdaMUpDOFZzWDBzQUR6RkVBWFVyT1lIZlAvQ0g3?=
 =?utf-8?B?WU50Ym5UVjVBc2JJZlZ6S0QzM0pzdm8zWDNhcTh0ZHFyWk9ZZVVqaVFEeVgv?=
 =?utf-8?B?a1laME9hN3FubDNTUmJoSGVvMFFXcWZ3cDJZYjNKcTZIbDFoQXhBajJFRnZM?=
 =?utf-8?B?WmVKdFZnSWVGUFZkZU9Ub2NRQ1llbWJVR3QrK2NyMXROSXpMbUN2YW1xVUJ5?=
 =?utf-8?B?MFhXaVVjM0QrcjJTV1dOY1ZxaW1CcVZ5RUlLSDRUOUh4YUV2V0QzRk85UEVt?=
 =?utf-8?B?MUp3QVdud00vV3B6dkN4WjRNU1VWNFFSQlVDSTNpeTdKRTcyT1VqemFGYVRG?=
 =?utf-8?B?ajFjcG1FSnloZnpBRHBjdkZjNjVEa3pQZlhIaElZVXVIUExsaHJ0Y1dHTGFs?=
 =?utf-8?B?L0RFME11K2N4ZXFkcWpGTVpmc1NCTUpVdWxjVmlVZnRxQjhoY3ppdFVDcVFp?=
 =?utf-8?B?dXZmNkJZYTFOVC9rVGxNZ1JFT3ZieWt1elpKNXJPSFlxcHF5WlR5bXlRNy9u?=
 =?utf-8?B?c1pzZXROQUN5WkdmdFk1R25ZZUZMR21aV1hIMVBvZC9BN083dmVDNCtRRXpQ?=
 =?utf-8?B?eWU4ZlRlWC9LancwVloza0JRM21xUU9qWmZ4ZjBrUWNnT0w2NzIvMXNJdHlC?=
 =?utf-8?B?NE10NWlSWk9CVDV5OU94Y1l0OEZhRTdQaXQ3Y29OVWh6Y0M2NUVZZnd3S3Fy?=
 =?utf-8?B?S09WZGFyZ3ZzUE1zdnJqWkpHOGU4UTRSblRWcTUzaHBuNlZsYnVBRWpUMHds?=
 =?utf-8?B?WVpYdmVRajNNTGJwaXRNejVGMjI4N1Z5WWlKVVRvTEpYbjN2VmNvb0RsZ2FV?=
 =?utf-8?B?dmh1WVlkRWZlVHJzZnZHbUtSU0xGWkwvUmQzQWFHcllZY0JWZ29XbU1aaXNZ?=
 =?utf-8?B?eHl2aUpPTWJqZmZGaCtRbWVrVGJwMS8xNHpRcy9NVU5sUTNoakNlTTFvMWht?=
 =?utf-8?B?REluZ0RwaGpFM1pRQkFRNmNCV1ZJRHV2cFlhZWMwaEFmdUtPaW42V1BpZzl1?=
 =?utf-8?B?UmluYTlxNGhNTVA3VEZKSy9Qai80SWozWkdBYkNlbEFLNjdMZ1VDMFZVYzZC?=
 =?utf-8?B?Z003Y2kydWN5enFiOGtOaTl5NTdra3I5bXBHbzV4MjF1VCtpbDZIa0IzcGtR?=
 =?utf-8?B?OEpNdGlCUWZ5bnE1emJSQmFoOENtUEZOZXFZa01LOWVIVWhmd2xIQ1RGamhi?=
 =?utf-8?B?RzB6WjVGdG5QTExBaGpUTHBIcnk3SGlVQ25sdXU5SkFwTlJoSFcrNmlXNGl2?=
 =?utf-8?Q?m+OgMmQAAfM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjJlNWFrWm9iSnd0SFFxZGJ1b2liNWZ6aEtpcVFiR015dTR5SzVJZXpkN0pM?=
 =?utf-8?B?ZC9EYjB1TksyNXNFeTFQTzlaWkpSa3RXL21XalJ4YThaSGs1WWt6clRNQi9T?=
 =?utf-8?B?eWRleENSdFdJbHFnR0lrV0FodTF2YzRQSnNXdHB5K3V5KzBjdUxSa1lUcERa?=
 =?utf-8?B?di9TdFp3dmRiNzJpaDZGbnl3QU85ZFJHTEdUSjRaRW00TFdkcFVKUFFiSGFS?=
 =?utf-8?B?MC9hb0p6a3RJaG1vaWtNd0d1aWVjWmF4RDRIaytYVXNjS2NzZmRLd2dxdnhX?=
 =?utf-8?B?bHZ1WGU2RDB6ZWVIS1dteUVhYW5Obm12eG4xZ004d2c1alZFSFY5Y20rbkxr?=
 =?utf-8?B?RkI0TEVSYzNNRjNGNlVqR3Q0M0F3bWZLTTVRcXdIZ3laUjB3TzVVY2VRTzNs?=
 =?utf-8?B?RWJhNlNYclZVbSs2OTNtNk0yZFdUdXFMSG9CdkR3bjQ4MFZxcGJOM0FVaHk5?=
 =?utf-8?B?TkpKY3ZRNFVKWjl3blFjYk5ZR1pBYUFOOEpxcWQyRldsTmZjVkFHRE8xNm1I?=
 =?utf-8?B?MW5vY0twTEVXNVVac3k5YTV4MlB5Yi9nUDJWNlBuSEVsb3lZRFFTWTZydDNU?=
 =?utf-8?B?dUUrbmtJbDNXQ0lacXZwTjZBZFl2d2t6SEVNZXMxdDFSc0NvTmd5YWhnMW5z?=
 =?utf-8?B?c2ZYcG5xbDRjQ3FJVmhDMXM3UEg0Q1B6OUErU2FVZTVtUi8rRnRTMC8yejVy?=
 =?utf-8?B?SlFtRHdYZWpvTzRLVGtvQlF1WGwwbFo1bWwxRE80cTNKbzdrdUFLdnhkRjl6?=
 =?utf-8?B?U2NDQnR6QjNjc0RGSzZWdmNjVUpBVitaSkJnWkhsUVlSYldPdGVnWUtrZEVJ?=
 =?utf-8?B?MDl4R3RyV0swdjU1R0JSOXNKS0ZucktVL05yZ1R5RFNjTWZqUmxuc2VMTWRw?=
 =?utf-8?B?R1FDRHB1VGQ5MGViZXRnZVoyWVBYd21kQjZaekZqSGU1eGhSZmluYnkxR3pt?=
 =?utf-8?B?eDh4eURkQ3VLSkUvWHo1aytBZkVZZmovRkVtcFpQSWtBd084cTdxMUsrRGV2?=
 =?utf-8?B?QTVCS3REWko0YVd1cmNUTjZFS2RNTFVQWW85MjAydkp3OXdsT3Mrd1puQ0hN?=
 =?utf-8?B?T1lOMjRsQyt4UFJkK25sTkZsRXZtaUE0dUJkTkNuR1BOcnZISGpsNElyMDFw?=
 =?utf-8?B?UTJYWE1HK3RaRmVvT0NjbUdMUjZOYTVXbmdUcnprNHc0UUNSTFBMak50UVdC?=
 =?utf-8?B?WndqbkVTWElPOVpqSEQwQkNFRm1hOHViSTV6NktOZ2tqamcyUHcxdDhjbW9j?=
 =?utf-8?B?WENXRTFxMUpncEg0WGRJYm5LekVrSVUxMWgxV3dVeUNLM3oxMVBJamN5b1hQ?=
 =?utf-8?B?QzFlVmNDa3JBYi95RnBCZitGbk9EZXBiZzlhNkRoMW1UUFBWZWRNLzJObXZK?=
 =?utf-8?B?VFVWUkliNFo0OUFkbE45ZWh1R0wzN1YrTWd1YVU3V2VpUDg4YURmTFFCRkZn?=
 =?utf-8?B?Z1dyUngyYXZxZDRpZHVqWldKeHlpWkhqSU9tMlhPNGkvM1pldDZwTGZyd2pX?=
 =?utf-8?B?dkZxOS9ZTHJQUjhMa0p1dEQyNU9OSFRUYW4xUU1UUGNIQWY5MXdKWjdJOXJr?=
 =?utf-8?B?RmN4VXdvWlIvTlNjSmZneGR0YWFIQ3RRVkN6Zlo0cERwUHBxNE16OHd0ZGtm?=
 =?utf-8?B?eVU2V042cFgweGZkWkttaEM1ZnNua1Z4R1RsWjExcEZjYVBnZ3NMWVFkNkc1?=
 =?utf-8?B?V0ZpVU85S3lqYkFlUHlvTmxqRXFJdjV5Wk9DT3dVcXF4M24yWmdxQ0cweERl?=
 =?utf-8?B?c0loeUR5cXp3d21GUlgzeVErNmJoM1IyU0FIQnJqNnNnNG5TU3VMWExrdzFl?=
 =?utf-8?B?cThlRmFLUG1BcXNxMW00YUVxSVBCaVIvZVZqS0NhazR3WkMraHlYZ3VYVjRB?=
 =?utf-8?B?SHYzSnRlZHp3d2FHSHFHUmEyM2lOMTAza0UvTnBhUmsrNG9ib3RoeWVUTWtu?=
 =?utf-8?B?TWJXR2hYdDlyYzFQWWdXRGpiUGtkRCt5NGJ2ekx0NW9ib2Y2dnZqd0VNKzFE?=
 =?utf-8?B?V054RnhXeXg0Tk9WUXFhY2dyV3ROTllpMERuYTJUV3NMajZQMnFEWWF3MzZt?=
 =?utf-8?B?dWZzd0ErR1dPMDc0TExTMmZTTWF3Y1czdWpOUGR0cXMyVU1nZG9hQ2oxbVdO?=
 =?utf-8?Q?0qQ6WWarWmqJD1A6S8sSXS4b3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f770cd6-947d-4bd5-1311-08ddc0886bf6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 14:37:11.6959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBfrQltZGcpf9ERVKKTwRD/3mcGkH0KumFlUtHV6FMleueTPS+LAx2XHYgs0Ml+i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9142

On 11 Jul 2025, at 2:41, David Hildenbrand wrote:

> On 11.07.25 05:02, Zi Yan wrote:
>> remap(), folio_ref_unfreeze(), lru_add_split_folio() are not related to
>> splitting unmapped folio operations. Move them out to the caller, so tha=
t
>> __split_unmapped_folio() only splits unmapped folios. This makes
>> __split_unmapped_folio() reusable.
>>
>> Convert VM_BUG_ON(mapping) to use VM_WARN_ON_ONCE_FOLIO().
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>> Based on the prior discussion[1], this patch makes
>> __split_unmapped_folio() reusable for splitting unmapped folios without
>> adding a new boolean unmapped parameter to guard mapping related code.
>>
>> Another potential benefit is that __split_unmapped_folio() could be
>> called on after-split folios by __folio_split() to perform new split
>> methods. For example, at deferred split time, unmapped subpages can
>> scatter arbitrarily within a large folio, neither uniform nor non-unifor=
m
>> split can maximize after-split folio orders for mapped subpages.
>> Hopefully, performing __split_unmapped_folio() multiple times can
>> achieve the optimal split result.
>>
>> It passed mm selftests.
>>
>> [1] https://lore.kernel.org/linux-mm/94D8C1A4-780C-4BEC-A336-7D3613B5484=
5@nvidia.com/
>> ---
>>
>>   mm/huge_memory.c | 275 ++++++++++++++++++++++++-----------------------
>>   1 file changed, 139 insertions(+), 136 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 3eb1c34be601..d97145dfa6c8 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3396,10 +3396,6 @@ static void __split_folio_to_order(struct folio *=
folio, int old_order,
>>    *             order - 1 to new_order).
>>    * @split_at: in buddy allocator like split, the folio containing @spl=
it_at
>>    *            will be split until its order becomes @new_order.
>> - * @lock_at: the folio containing @lock_at is left locked for caller.
>> - * @list: the after split folios will be added to @list if it is not NU=
LL,
>> - *        otherwise to LRU lists.
>> - * @end: the end of the file @folio maps to. -1 if @folio is anonymous =
memory.
>>    * @xas: xa_state pointing to folio->mapping->i_pages and locked by ca=
ller
>>    * @mapping: @folio->mapping
>>    * @uniform_split: if the split is uniform or not (buddy allocator lik=
e split)
>> @@ -3425,51 +3421,27 @@ static void __split_folio_to_order(struct folio =
*folio, int old_order,
>>    *    @page, which is split in next for loop.
>>    *
>>    * After splitting, the caller's folio reference will be transferred t=
o the
>> - * folio containing @page. The other folios may be freed if they are no=
t mapped.
>> - *
>> - * In terms of locking, after splitting,
>> - * 1. uniform split leaves @page (or the folio contains it) locked;
>> - * 2. buddy allocator like (non-uniform) split leaves @folio locked.
>> - *
>> + * folio containing @page. The caller needs to unlock and/or free after=
-split
>> + * folios if necessary.
>>    *
>>    * For !uniform_split, when -ENOMEM is returned, the original folio mi=
ght be
>>    * split. The caller needs to check the input folio.
>>    */
>>   static int __split_unmapped_folio(struct folio *folio, int new_order,
>> -		struct page *split_at, struct page *lock_at,
>> -		struct list_head *list, pgoff_t end,
>> -		struct xa_state *xas, struct address_space *mapping,
>> -		bool uniform_split)
>> +				  struct page *split_at, struct xa_state *xas,
>> +				  struct address_space *mapping,
>> +				  bool uniform_split)
>
> Use two-tabs indent please (like we already do, I assume).

OK. I was using clang-format. It gave me this indentation.
>
> [...]
>
>> @@ -3706,11 +3599,14 @@ static int __folio_split(struct folio *folio, un=
signed int new_order,
>>   {
>>   	struct deferred_split *ds_queue =3D get_deferred_split_queue(folio);
>>   	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
>> +	struct folio *next_folio =3D folio_next(folio);
>>   	bool is_anon =3D folio_test_anon(folio);
>>   	struct address_space *mapping =3D NULL;
>>   	struct anon_vma *anon_vma =3D NULL;
>>   	int order =3D folio_order(folio);
>> +	struct folio *new_folio, *next;
>>   	int extra_pins, ret;
>> +	int nr_shmem_dropped =3D 0;
>>   	pgoff_t end;
>>   	bool is_hzp;
>>  @@ -3833,13 +3729,18 @@ static int __folio_split(struct folio *folio, u=
nsigned int new_order,
>>   		 */
>>   		xas_lock(&xas);
>>   		xas_reset(&xas);
>> -		if (xas_load(&xas) !=3D folio)
>> +		if (xas_load(&xas) !=3D folio) {
>> +			ret =3D -EAGAIN;
>>   			goto fail;
>> +		}
>>   	}
>>    	/* Prevent deferred_split_scan() touching ->_refcount */
>>   	spin_lock(&ds_queue->split_queue_lock);
>>   	if (folio_ref_freeze(folio, 1 + extra_pins)) {
>> +		struct address_space *swap_cache =3D NULL;
>> +		struct lruvec *lruvec;
>> +
>>   		if (folio_order(folio) > 1 &&
>>   		    !list_empty(&folio->_deferred_list)) {
>>   			ds_queue->split_queue_len--;
>> @@ -3873,18 +3774,120 @@ static int __folio_split(struct folio *folio, u=
nsigned int new_order,
>>   			}
>>   		}
>>  -		ret =3D __split_unmapped_folio(folio, new_order,
>> -				split_at, lock_at, list, end, &xas, mapping,
>> -				uniform_split);
>> +		if (folio_test_swapcache(folio)) {
>> +			if (mapping) {
>> +				VM_WARN_ON_ONCE_FOLIO(mapping, folio);
>> +				ret =3D -EINVAL;
>> +				goto fail;
>> +			}
>> +
>> +			/*
>> +			 * a swapcache folio can only be uniformly split to
>> +			 * order-0
>> +			 */
>> +			if (!uniform_split || new_order !=3D 0) {
>> +				ret =3D -EINVAL;
>> +				goto fail;
>> +			}
>> +
>> +			swap_cache =3D swap_address_space(folio->swap);
>> +			xa_lock(&swap_cache->i_pages);
>> +		}
>> +
>> +		/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
>> +		lruvec =3D folio_lruvec_lock(folio);
>> +
>> +		ret =3D __split_unmapped_folio(folio, new_order, split_at, &xas,
>> +					     mapping, uniform_split);
>> +
>> +		/*
>> +		 * Unfreeze after-split folios and put them back to the right
>> +		 * list. @folio should be kept frozon until page cache entries
>> +		 * are updated with all the other after-split folios to prevent
>> +		 * others seeing stale page cache entries.
>> +		 */
>> +		for (new_folio =3D folio_next(folio); new_folio !=3D next_folio;
>> +		     new_folio =3D next) {
>> +			next =3D folio_next(new_folio);
>> +
>> +			folio_ref_unfreeze(
>> +				new_folio,
>> +				1 + ((mapping || swap_cache) ?
>> +					     folio_nr_pages(new_folio) :
>> +					     0));
>
> While we are at it, is a way to make this look less than an artistic mast=
erpiece? :)
>
> expected_refs =3D ...
> folio_ref_unfreeze(new_folio, expected_refs).
>
>
> Can we already make use of folio_expected_ref_count() at that point? Mapc=
ount should be 0 and the folio should be properly setup (e.g., anon, swapca=
che) IIRC.
>
> So maybe
>
> expected_refs =3D folio_expected_ref_count(new_folio) + 1;
> folio_ref_unfreeze(new_folio, expected_refs).
>
> Would do?

I think so. Even further, I think we probably can get rid of can_split_foli=
o()=E2=80=99s
pextra_pins and use folio_expected_ref_count() too.

Before split:

if (!can_split_folio(folio, 1))

unmap_folio();

extra_pins =3D folio_expected_ref_count(folio) + 1;

After split:

1. new folio:
expected_refs =3D folio_expected_ref_count(new_folio) + 1;
folio_ref_unfreeze(new_folio, expected_refs).

2: original folio (it can be split, so need to check ref again):
expected_refs =3D folio_expected_ref_count(folio) + 1;
folio_ref_unfreeze(folio, expected_refs).


>
>> +
>> +			lru_add_split_folio(folio, new_folio, lruvec, list);
>> +
>> +			/* Some pages can be beyond EOF: drop them from cache */
>> +			if (new_folio->index >=3D end) {
>> +				if (shmem_mapping(mapping))
>> +					nr_shmem_dropped +=3D
>> +						folio_nr_pages(new_folio);
>
> Keep that on a single line.

OK.

>
>> +				else if (folio_test_clear_dirty(new_folio))
>> +					folio_account_cleaned(
>> +						new_folio,
>> +						inode_to_wb(mapping->host));
>> +				__filemap_remove_folio(new_folio, NULL);
>> +				folio_put_refs(new_folio,
>> +					       folio_nr_pages(new_folio));
>> +			} else if (mapping) {
>> +				__xa_store(&mapping->i_pages, new_folio->index,
>> +					   new_folio, 0);
>> +			} else if (swap_cache) {
>> +				__xa_store(&swap_cache->i_pages,
>> +					   swap_cache_index(new_folio->swap),
>> +					   new_folio, 0);
>> +			}
>> +		}
>> +		/*
>> +		 * Unfreeze @folio only after all page cache entries, which
>> +		 * used to point to it, have been updated with new folios.
>> +		 * Otherwise, a parallel folio_try_get() can grab origin_folio
>> +		 * and its caller can see stale page cache entries.
>> +		 */
>> +		folio_ref_unfreeze(folio, 1 +
>> +			((mapping || swap_cache) ? folio_nr_pages(folio) : 0));
>
> Same as above probably.
Sure.

Thank you for the feedback. Will make all these changes and send v2.

Best Regards,
Yan, Zi

