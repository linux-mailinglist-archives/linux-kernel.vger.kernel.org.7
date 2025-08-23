Return-Path: <linux-kernel+bounces-783069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 036C4B32908
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8444C58399D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE661D5CFE;
	Sat, 23 Aug 2025 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kuQ+IB3R"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA9C8635C;
	Sat, 23 Aug 2025 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755958581; cv=fail; b=ucHvPPxJFihWB3jMhhWwum4mwm4EYbEH2GZ29gROKnMOPWky4wwmjLRs0heg4Y2dgxTp9yh/kMhri/yQtIYUif3YidCbn8jmeEWGVue5bpwBkI4nVbMzwuf3tuf1EGD7Yegpydu93A/C5H57E5rhcD9hBNhfV/U9gpRVoaATPCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755958581; c=relaxed/simple;
	bh=bYJj7hkSA6bgrixiM527gobnZeQKzSq7P+gOwkxRIjk=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=a3gZ+9vcvdEVOm4mrRTvrjXz+OivxWCYJ1482mhILGd/HgrONJBghvKX7Kr4wysYt2udlRPZwYwmIV8K8gZfHtjloIR+T02vpl933jxJUbqUNKj0288pJpiaO+HKFHgxgG9Uj4osqBad7gzDnSwRFmBwps2fSZTCvBHPvB339Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kuQ+IB3R; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HagUHTK74ai0iYjeM/WiE/b0p5/BC0ROwqqgzT5brgGaZGGjOah7cYNGu3XccL76zbj8phES2aYy3BgGuSpHEvz0n1e9anr4NRTMNY1xWEpdAUG0FoPvAHS4lGKt8tjgUBBH5iUfOEnXZV9jFg2neMe61NRJU2hJY24cnAQ6VbzaBSjeBMGLATzL8ac4gYsGv0lgOCw0VwVSSjcMLvpWxMxfKTjlT1o/SFD81etNI9J0QpsyyiB+mJWiKX2sAVfUdim4GyLToQ7KMrQRYWPrr629AGzrltP8oGfvCB+Z06G6+2c6lWxHq4TNpAJ8T53N0T9QMlqq9OsBU7hSYWyAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYJj7hkSA6bgrixiM527gobnZeQKzSq7P+gOwkxRIjk=;
 b=LhBiPzSfTDkEJp3jbvN+S/k2KuxuC9by7wO4zZ9dOlnNobRugHoPyhFxEzGFT43RnVN1xWGXpdNtBhgG+6MWmvP/4xexCIwz+zKWaD5BciznzuYwX2GY+nG/gTYPfCr7l8jlgQDpByBwx+tFwHupRnT4BnNf8bs3EyGNgxNDBYQd+tndPjCA74xQA0JE/BPAcfPsF5Q5CZwS7AlSjETY9GSp8b5iTqH+sKGBDSZySX1NiO76x99UKteA0WpMbanhWGM8FmiThWvLvwBtaelZZLqTxtk2dgyqZE44ZkzaefCeGrp/1zIRCy661kZe7RpXCfSctJBaDoh/he5iakbbLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYJj7hkSA6bgrixiM527gobnZeQKzSq7P+gOwkxRIjk=;
 b=kuQ+IB3RtRjqZIwxRjEw/+TsYNSFACfpL5WPy64v4MSX1NmYcyfHGmkFCWH0DZSZjV9+KBaEvRVBWcBo2Cxfq++HX+3w2soctyuJbALMDR6qmuV1q+mvJX7LFTYKVfew7YRGpOtaJ7287hYfeTRwHxMRlmwOEnUt5C9wbmUhc87VqXRMsKmJei3P2lIpbmWWLmbLDnxIFJLLbEYFJD7knHWVBP+qCGzK+W/yWMzinKV1wUoYrhCTjK5zj+6fAM6e1cgN0x188DIdeohTC7PQyTvq2gwTYjusCZ+KtRckX0nE6/0ilJXwh5MDKurUMM4IzoI35HQ4heJzq3fQ0c0w5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BN3PR12MB9570.namprd12.prod.outlook.com (2603:10b6:408:2ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Sat, 23 Aug
 2025 14:16:17 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9052.014; Sat, 23 Aug 2025
 14:16:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 23:16:14 +0900
Message-Id: <DC9VD4LXAK9R.1RIJYWF1MFCMS@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: <akpm@linux-foundation.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <jgg@ziepe.ca>, <lyude@redhat.com>, <robin.murphy@arm.com>,
 <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] rust: scatterlist: Add type-state abstraction
 for sg_table
From: "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250820165431.170195-1-dakr@kernel.org>
 <20250820165431.170195-4-dakr@kernel.org>
 <DC9UR87GP16E.2K9E9SSTHEBRB@nvidia.com>
 <DC9UYN56HBRZ.XRDXQHO2QQQ1@kernel.org>
In-Reply-To: <DC9UYN56HBRZ.XRDXQHO2QQQ1@kernel.org>
X-ClientProxiedBy: TYCPR01CA0182.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BN3PR12MB9570:EE_
X-MS-Office365-Filtering-Correlation-Id: 98cc2fb0-efb8-41fd-856f-08dde24fa00f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2ZwOHRjbDhERU8rRmw1YmFjSDFUcWRweE1IWVJVZWxpczZXVjh1YkFxR1gw?=
 =?utf-8?B?SGVCalVsOGxKWFVKV0s2SzhacXAxNDFMbmlvNDZoeDJrcmZTUTcyZUtJSlBn?=
 =?utf-8?B?YjV0NDdiMW5NMlFyRDN4eUY1cXFGRWw1TndqM0hlK0VUTklPNHlveTl5YkZ3?=
 =?utf-8?B?U29YaExJMW83TGFEcVFZeHlJZHQ0ck4rTXJ0b0s3SUN5TjlzMUx2bmFyaGN6?=
 =?utf-8?B?QlFTV0piWW5KamlrSElIMW1EV2t2T3ZLNkVaRm9nRWsxTnJOWGdaMFVEVUdi?=
 =?utf-8?B?Q0NpeC9CVURSUWtUTGdSUEI3bmt5N3V3Mm8xRjZKZ080OGx3ZW0wVXhiWm5i?=
 =?utf-8?B?cjBmdHBIM1FSZ1Zib0NMc0lXVzU4dnErYklEMmZ6Z3RRMmw5dCsvb1pDOXA3?=
 =?utf-8?B?ZTd5bnBidjZjeEtlVWlNQ3FtYkl6NFRFQU1GeUM2UnNCWFl0eWwyb1Z2cHYy?=
 =?utf-8?B?N2xlK1N1WDB4aEQxc1FlbjJlWnJpcmtpTDk5aWJjZ2JrU05XcnNyb2dDMkZl?=
 =?utf-8?B?WGNaRGtIdmZzbUlJNEpyaDNUOE1CN1hOUGNRWVRmelZrcUhKRUFHWXNXdUs4?=
 =?utf-8?B?M1E2SUhycDRUS0I0ZTByaExFSVQ3RTdVczk0cUI5MHBQa1RnQWswSysxZ3Va?=
 =?utf-8?B?RU1zT1NMMWNoZmxkVHd2N1RKYmpMd2MycXVYQVBINmFVd3BnV3dHNHBqVXBC?=
 =?utf-8?B?dUFBcEs3RzZDUTRmeXl4cnpycW1hUksvckVFSC9ob1N2d3A3Wjd2OWk1UkFu?=
 =?utf-8?B?QTZvU2Q4QThBMENUc01lSFpjYzVCRk9OcXMwb2ZLZERrcndHb0hoYk5WMXdQ?=
 =?utf-8?B?VitqMDJGVzVpUXRjNWI3SzJsU2txL2M3cCsyVVV2eUJ5aksvRnJjakt4YmFa?=
 =?utf-8?B?OUxCNE9LUmU5Z1NjVFAvVnRPdEZOK3VWelZCbUdqWXVmRWJscTlZWVl3NjZW?=
 =?utf-8?B?VFBIdW9RcmdORTdqNTVVbkx2bHk0ZUpNclQ3NVdiczQ1Vlh2R3Q1YkNKL2ZM?=
 =?utf-8?B?eUtuUXJyYVErOFJjaWFpR3pVZkxKdGFZeVM0alU1Ymw5OWt0UGVDMXVjdDcw?=
 =?utf-8?B?OGVic1RhUmJPRkpqaFBPS2NGVDdaekhCa3ZEWkV2eTY4UzBiaUZralhBeWZC?=
 =?utf-8?B?cmxTN2JEOHdrQ2h5dEtnV3hIakkzK3IvcUY4eWlITXNPb1hibG03Q3lhQnFr?=
 =?utf-8?B?WnEyRjk2QjByTVRJbm5uSEJXMGIrMnJ3T25xajljRDYydXo2Vzk3QlJFWnlS?=
 =?utf-8?B?Z2N0RXlqTiszT0ZDZjVGcFVkbUc0SUl0ajh0S2pvR0tpTXYyU2ZMVXh3eG56?=
 =?utf-8?B?WUlVQkRzMW0rNHdkNy91bFNSU2ZtbW1WMWFXem05T3JQREJkNWYwTWo2WWdJ?=
 =?utf-8?B?OVhSVWRNd1YyUTNuYU9uOXN6NkplYUZKZUZ4WC9hUUR0MlBXaURRWlNlbTZt?=
 =?utf-8?B?Mzk5bTFVRUt2QW4yNjl3STg3L3JKNkNKOW5pR2Yzd1VEUFBvL3llN1V3NFlP?=
 =?utf-8?B?cVAvNzdOZHVqMnZFZWEvU2NxVFErZzEyekQ5L3E2U1BlWmhpd1g4TjRSODNJ?=
 =?utf-8?B?QWsyaXM0YkJ0ckFVMjlKcDNScW1abzdiODlWSjdRUFZPSU03WFIwbFB0UDRk?=
 =?utf-8?B?RHpJMDByWERodWRpc1prSno2dm9mNThMY21ja3N5NTJaK3NDN2x3SVlUbGEx?=
 =?utf-8?B?dnZuRE5xdVljQi9pTmhHQUpWci9wUlBNWm5CbFNCbHNXWlZJbkt5S3V3L0Ri?=
 =?utf-8?B?ZTBFNXZuK1o2K29KdE8wZUJBMENUQlNwaUYyM2daMklzWks2cnh4NER4VUlH?=
 =?utf-8?B?R2FzMk1MSms0WjdWS1Q5TTZWalEvWmFUc2RnY2xab1M3MWE3d3JyUFN5Tlp1?=
 =?utf-8?B?czh2azVhZjNYYVllZTB4US9xc1pPS1VXN3BYWmVOWWsvSjlXME52eVZ2VUV5?=
 =?utf-8?Q?qOUerzKBmV8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K29oR3U4WDN1WmVlOVk4L1dKWWprUmU2OGRGRGV1OXJXVW5rcmJmbDRpZmQx?=
 =?utf-8?B?Uy8xTi8yYmxqL1VJS3lLT25XWFNLM2RYbDdVUWJIWTJkNzhzQnFXS2I4Z1VU?=
 =?utf-8?B?dFI2ejBYY1Z0ZWFTOXA3WVhzZ09oV2NkUnZGb2ZpUnlkTDBaZ212WUZqdk45?=
 =?utf-8?B?ck5ZYVRPTE1WT3NSTE1EK1FOMk15Nm55RnBpUm5kbFVmclVORXU3SUt2SEVE?=
 =?utf-8?B?cFBLUHB2YUdKdFhDbmlCWVk2RUswK1E1T1hFNEQwN0daaTRaZzU1dVROVjB0?=
 =?utf-8?B?WFkwdDhqNXZiQ01ZRWpoWCtGbTZ4dzRqemtNNldvTEFUbHpadlBEelBiNjFV?=
 =?utf-8?B?dVAyeWY1SnZQRnp2MWFXK2VIeG5XT3p4b3NsbWtZSFdNOENJUHlVSy9HMWlX?=
 =?utf-8?B?OWZiTFljUXV0N203alM4czNDbHoxUjVidXk2Y01FS2F6Y3NjNFZrMTkwRkFt?=
 =?utf-8?B?aFpIVExzMlBZcGdUTnJKYnkzY2xqbUVCc05VZlVZSEI5VnNScUd4VmFPK1BK?=
 =?utf-8?B?N05ZMHhGUEUrOTZpT0ZqMG9GWGxNSmVRcVdrUk9NZEJNZm02Si9mbXhmNjRY?=
 =?utf-8?B?L1BhRVNqNjlwdlg0TWtkeUxIOXFyMkZkOTZldGNaNjFZYytSZXFIQnBuNlRw?=
 =?utf-8?B?bnFLWHhxTDNhb2FXWGd5YS9ZVFNzK0swd3EzYVBONDNQSXQ2SVE1cGhvdW43?=
 =?utf-8?B?aTI1MHBjQnRLbVVONWh2ODY4S2MweEJDeE9jS0owT3d6NUxPaVpwVmhrZzV4?=
 =?utf-8?B?d2dEYjVsYTJmU0VZNWNYRmZ2OGNLbnVIVlZpUERqVHRka1FIUU5JdVllNjZO?=
 =?utf-8?B?djVRQ21JM1JIbmxTc0NocTduays1Skk4aVg1QkdOU0dnVkY1Y0FVM2ZhRjd1?=
 =?utf-8?B?UEhDbFNMWXhtWjllVTdRTWNUcG1rU1ZvWWM4SlNwajFqMEYrSGZxMVZBajkx?=
 =?utf-8?B?MzFHaTFLSDAwZVREWG5aS0g2SFdycldPSGZXU3VoTHZtQzVDVFJFbDBvaElH?=
 =?utf-8?B?VXhZWHR1Zmx0ajNoZnNEWUVBRjU1UHM3eFNTODFyd1A0bzRyV1hpK1J4ZnRW?=
 =?utf-8?B?L1BDekg2eU1nRWVhbFB1ZjlORllpcStKaUtCblg1L2dQYWFRV01BNG9lZlBT?=
 =?utf-8?B?TTF3VGg5Q3RkQ3FQZGdPMVg2aUsxbCt0VjQ0OWFvaHd5NkRUSDhiVC9kZ2ZX?=
 =?utf-8?B?K1p1MnNiem9ab2N0QnVieEQ5MElpaVoweFlnMzFuaFhSMzBBQTBmcFA1eU1N?=
 =?utf-8?B?Qk9ncnlTTU1BbkROR1NWL0RaK1JDU3c3dmFZRk1Ja3V2cUFTYnZ4Wjhoc21Q?=
 =?utf-8?B?Q0d2UzZMck02dGZEOXZlQUJUcHlvZHhqVEV6UXh1N3FjVnNGbng5SFZBZnlp?=
 =?utf-8?B?SUcyd1I5S0pyVjUwOGFmdUJvZk5XdTZKSFRwR2VwMjEwRjczcE9vcFdrN0Iv?=
 =?utf-8?B?cng1V1ZJemhnNFk5MDczRXFOdEpPdDFVNmMzQnRaM2NFL2JicnV6NVJySnAz?=
 =?utf-8?B?cUlHMkpyU1NKZnUzZmpNWllGZXQzMUovNU56MU1JUEZ1ZHBPZjZPZEdBcUo0?=
 =?utf-8?B?eEVUSVRhbld5eVArL0c5b2RJWnB3NUFMZkJZZHZEYXp2Q2RTUGVLZStzbHlW?=
 =?utf-8?B?SGdZK2ZlWjN4UWdOOS96S0VrWW9Lb3NMMUgxaVBoVytub1hJVzJzbzREVTE1?=
 =?utf-8?B?VEs3MG9adzJFN3ZjMGRhaGY5UjArVHlYUTd4T3JnalJKTkdsRlc1cm5IUmti?=
 =?utf-8?B?OEVtWk4vSnBFWkdiS0FKV3JDUzZudHRsajFhS0FmTG9OT1ZlMU5Xa3NOVzVX?=
 =?utf-8?B?ZGRGYlR6R2tzcWRnQnN6RmRVaEdjazhpcU1UbkZkaU9sZlhHallqY0hZQ21I?=
 =?utf-8?B?dGlFclVTRzFHM2xGUDRtWHVDckE1MEttdFBKaFhudjhvZEhqSHlsRnh1bzc2?=
 =?utf-8?B?T1h6cERlTGxiV3c4NDJqenZ6UGlUOHl1Vm0zKzhFTUJKaW96emZvSzdHYlZN?=
 =?utf-8?B?WjNIRmtIcWpNR2FIdGRjdVN1NUIwV0oybUZGa1cvS2FTRm5TZUJ1OWFKTUxy?=
 =?utf-8?B?azNRR2ZlN2ZUR3Z2Q0ljMThrbzdqTU9WSU1ZMHRyY1ZrRFZKb200ZVFtNC9l?=
 =?utf-8?B?cm5RTjBwQ0lUVnM1RTQ5djBocnROT3ZpU1BBNDVQM2tjUjg3TFhhdUltbkdp?=
 =?utf-8?Q?OVHabRENeYtIhlSX07o85JbLKLYmn65K6Y0+QIJFsCM8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98cc2fb0-efb8-41fd-856f-08dde24fa00f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 14:16:17.3315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5t7G8f7sBh3xAs03GW/KAtQ6B4BASZ1FPCqrc4YHkp9YgNhqVCpztU8nDAGHdqvXzt8NlYxOWy3VChbZtjtWxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9570

On Sat Aug 23, 2025 at 10:57 PM JST, Danilo Krummrich wrote:
> On Sat Aug 23, 2025 at 3:47 PM CEST, Alexandre Courbot wrote:
>> Oops, forgot to mention a couple more things:
>>
>> On Thu Aug 21, 2025 at 1:52 AM JST, Danilo Krummrich wrote:
>>> Add a safe Rust abstraction for the kernel's scatter-gather list
>>> facilities (`struct scatterlist` and `struct sg_table`).
>>>
>>> This commit introduces `SGTable<T>`, a wrapper that uses a type-state
>>> pattern to provide compile-time guarantees about ownership and lifetime=
.
>>
>> Is this actually a typestate? From my understanding, the typestate
>> pattern implies transitions from one state to the other (such as
>> Unmapped -> Mapped), but in this version there are no such transitions
>> (the previous ones had, though). We are just using a generic parameter,
>> so mentioning typestate sounds a bit misleading to me.
>
> I'd argue that it's still kind of a typestate. You can derive &SGTable (i=
.e.
> &SGTable<Borrowed>) from SGTabe<Owned>. So, technically there is an
> uni-directional transition I guess.

That's technically correct, but is also not the intent of the design, at
least compared to something like Unmapped <-> Mapped. Not a big problem
if you prefer to keep the current naming though.

>
>> Another random thought, in the owned case, do we want to provide an
>> accessor to the provider of the backing pages? Or do we expect the
>> caller to take dispositions to keep such a reference if they need to
>> access the backing buffer post-mapping?
>
> That's not going to work that easily. Once the backing pages are DMA mapp=
ed, the
> backing buffer can be accessed safely an more.
>
> See also the safety requirements of dma::CoherentAllocation::as_slice() a=
nd
> dma::CoherentAllocation::as_slice_mut().

Yup. So couldn't similar accessors (marked unsafe of course) be
convenient?

>
> If we want to support that, we have to provide a new type for this and ma=
ybe
> want to define a common trait for DMA mapped memory accessors, etc.
>
> Not the scope for this series, I believe. :)

I've had a few thoughts in that direction as well, but completely agree
we should debate about this *after* this series is merged. :)

