Return-Path: <linux-kernel+bounces-778426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28872B2E58B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821D23AD6E8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CCE27AC32;
	Wed, 20 Aug 2025 19:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bfp1sfE4"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9962B25B2FA;
	Wed, 20 Aug 2025 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755717861; cv=fail; b=a/jeuQGJh7n9Y1F02NRngD8xDUyPA9gcDwq9DJnNNlIs0WAweWE4v83QcX/zMaGCdgHo826NOZ3VcPzZwd140PtNmnCDFba/tb7vSXvONa6j09eFsK//oR7ygUMcPjsIrYQX7kNcG+R5y6GYYnI3Sg8BVyxtiOGvOWfnX4CnVA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755717861; c=relaxed/simple;
	bh=MK9+PnlkVsomsJ5Bamt95CcJ4AU1FX25tlEtXAGZxFY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gydqSZpJeqWob+n4g6FZSCfP91Prgy7OvQTqwxsHGoviQsy2khepZVZWj/0nADbc34wUVNhSnBs/7L/bOjX5jHAFOiw7bAMmBsefBA2wRzZnhbx+d93jgPBWJY79fBE6ay0ZymXgYoSU9g62A4QlaT+Ul7DaF86t5nitZv19pvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bfp1sfE4; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKnqW0BYTwlL9LD1FjyJXsTNXquNvpKWqv+ly9QdntBdeMcB8i2VAukDoODK1t1R9UHaA3ZxmKKS1zUmUl62320/BcwZjsZ7JOakfrtw0xU8twAd6Jnp/82HZPAZLeQ/V0wFQlRmMNgmtbU24+2N3AIKMLGxCJt0i5N+Uag6pt1WcuPGLblHQZw/4lp7MIxI7eTHwq78raJLBNw8IlVqpJrV3S+XKaw/plaC5cByF/yEt+Vg81RCGhH+Ng81aGAjTfEYbBpF/OZUMWY6LABgxda2VWQdINDSEMfowWaLFOKRIBBg1ROZus7pAyaxfBzsOidOmEzgsn5NbpaYFrO0DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLt7cvhaUvEXZJ/LLEzOLLYwSFxgLRzDmB5aZD+OwJo=;
 b=h2hrpDk1mpCNXtZ2RmdPqd3ZDIQ6+8V1/dnWyCE+1DMBol0sN0fomW8A4LgNFwvmlMEJ9RqSPCBot66dAmgu7rAMQuMMqUA/E0iziF1Kec6FbHd/rUueos2h4r3IJyL32ZIcnEXLId4jWdPUJzyVL61ZuaNmY8rXZOTEegng1oEo0v+au6aAfFbH9RAxM9fW7D4FJca7z7e5uk+GnuRZhBl9gKgZ48b7i6ReWSpQNxLJFX/P+6UF2IV+QQrIC5NWN4Ftav3BIdezymfMU3du+1b3n4lSC+NabmHu9gKC7oaJv0vUsegELcxVu/bFcrAbahwaHK/Dq8AEYV0MI2PyOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLt7cvhaUvEXZJ/LLEzOLLYwSFxgLRzDmB5aZD+OwJo=;
 b=bfp1sfE475008C+CanGmlS6PaH96Aj9iCpDEMOPB1RONdVQxAssGfpcvXj8d64Y+Y37G04/xocjtxqN+URSmyOEgppKduknvsQ+I9u7P68jDxd0l06NGK/t++Vrdgv0ZiA0vouVNVPUIQJn9csvER8UWoRNbL4Jup/MbEtt7yjg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ5PPFD525C5379.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 19:24:16 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.9009.018; Wed, 20 Aug 2025
 19:24:16 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Rakuram Eswaran <rakuram.e96@gmail.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "Koenig, Christian" <Christian.Koenig@amd.com>,
	"airlied@gmail.com" <airlied@gmail.com>, "corbet@lwn.net" <corbet@lwn.net>
CC: "tzimmermann@suse.de" <tzimmermann@suse.de>, "mripard@kernel.org"
	<mripard@kernel.org>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"siqueira@igalia.com" <siqueira@igalia.com>, "Wentland, Harry"
	<Harry.Wentland@amd.com>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
	"linux-kernel-mentees@lists.linuxfoundation.org"
	<linux-kernel-mentees@lists.linuxfoundation.org>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>
Subject: RE: [PATCH] docs: gpu: Fix spelling mistakes
Thread-Topic: [PATCH] docs: gpu: Fix spelling mistakes
Thread-Index: AQHcEf+KsUH6CFO6iEeooxxYq1KfnbRr69yg
Date: Wed, 20 Aug 2025 19:24:16 +0000
Message-ID:
 <BL1PR12MB514474E3D1951AA174431414F733A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250820182259.11227-1-rakuram.e96@gmail.com>
In-Reply-To: <20250820182259.11227-1-rakuram.e96@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-20T19:23:44.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ5PPFD525C5379:EE_
x-ms-office365-filtering-correlation-id: b610a5c8-6d4b-4e12-567f-08dde01f275e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?//oXJRYFTjjkJrYPe5tUwfBZu6q1BdmSNTsIGagnZcuPHb//Y92Z03bPXPz2?=
 =?us-ascii?Q?A7h8RiH7hfFgNR1MPvBOqwb9yvMj96M9ae2O5h5NqnEl/76oUIfEGFRdMvz9?=
 =?us-ascii?Q?PNKKcK9OGq0cj/xw8he+ad5ucDMBT94Rtw+hbmQLwioQCpOwUwbS0Mv5Frxw?=
 =?us-ascii?Q?PJjQjR00rxh7wLd2s8FzJJnjTsYEHQUwmrwFQ7f4CNBy6IMT9T7WSVtKzMi6?=
 =?us-ascii?Q?jGwYfuo06b0m3WxrpwaEDZqmb4fpi0sgBSine4lYSn2L2iPu6y9dz9TBgXXW?=
 =?us-ascii?Q?+5DFviy5VjhmQbj5C8U3mF+afm6dmY2i+SjNHG/B0LkdNQv7KNnNhwSUTQh6?=
 =?us-ascii?Q?1EryR8XN0CHvjwmwBQghxPi5HMwW19I7RNWljmXi3bbfOEY9Yai79jdbi52j?=
 =?us-ascii?Q?hFBPX6KzdJwZiwn4kBJmzSpF2EmF6GYyEg3Mv3OfDLyqV1Lt/+HpAosQIlGh?=
 =?us-ascii?Q?oJH0mVgPP79/sgMLzUAA0s3QC02cauoa2La0XJvsPdaBgJeezoF3PI+qaOXl?=
 =?us-ascii?Q?Rk/swMA9sck/tVHWwM4dbjX0B6GI0OIWvVJK1eRo+ZtuKRY7sA9EQAgLdT+h?=
 =?us-ascii?Q?4fqrrwHjiHK8bIfWCxYpyvWSNY18JqRWAU7FVd2iwd4OmiJ22P2kYlLh1Hu6?=
 =?us-ascii?Q?2qgvxboQi+YHPT4kgPpfeM6gAXXF5Z9FbpGHsND9yAVltxYe01n869X4822h?=
 =?us-ascii?Q?oE9BpdAfTRblgBYwt/LlyvfKYM6ninSkKYdxiUBmibYgCiY2oJSCoHFTTM8b?=
 =?us-ascii?Q?8MqtIyHNq/3oO7XV9VK396fkgq5G25owewO5bHa518a9WzyoZ5hEli/kvQTr?=
 =?us-ascii?Q?d+/sU4jJWGId4BVUq2DYTQDhhlDpboHVk88jf9V8Bkaa+//5S7YNyPURAPCc?=
 =?us-ascii?Q?pddTirIO8fNKrUTY79zINAyL7w/iaXHlxZks3shDYLZqFMlhoCrxQHttw5em?=
 =?us-ascii?Q?28CoVCMju9wJ+1cCpR+2L8rIbPWXLP0rfwmFwZYMnIeholbmr//vuwv4jBiZ?=
 =?us-ascii?Q?vFEjXpkKOKvT4qK1E3soh0PkqKJOvblAyvKEBsmIVubFxrlv7ooUgSix6LH4?=
 =?us-ascii?Q?oivXC6e++WAwlEhAjXeOWZ29FDqsLiUnrgg3jK9gxf6A72icDRq4x3dPovMs?=
 =?us-ascii?Q?+VkcPNkmlTxcMQNoErTq4tVWQKVaKt5J5mdJTo3Y74LATFNCOoSEyt6NCB6n?=
 =?us-ascii?Q?ICrLUQ99nH9nDez9FLyUD8f8g0/B6bWcxRM2tKzMwRyXR1POxbS2pkAJW7it?=
 =?us-ascii?Q?BMkoq3WSL901oTnZ5BYwxwQ8wC1IEbRkOQXgNUNeNeWXq76o+/wiYSJVxbrA?=
 =?us-ascii?Q?zVh0N8/HYc2tSqbLohDVRp0oW4RCSwM7OSnhKNbfjNa0tfvU7qT2HF0+Disw?=
 =?us-ascii?Q?NCeDUVwJdgLjkwOMIYPqHdhcoYGF0F0UZXgx3jlvSClsJj8topVofz83RdlH?=
 =?us-ascii?Q?FppeAWhBEAHnCkBGLs+UgAH5l1pIyPJSRKZCSQCLgw9fzoger3vGMUDzqLOM?=
 =?us-ascii?Q?1FREam+oQZEntI4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?E9T04zZDOgZTnlcQ2A9GvUyGbCPl7GIm0m/Tde9KUBUnADjsQVGf6Fx4/2lW?=
 =?us-ascii?Q?qiQMCSSmvPvc7pI3vhrWoWfeS2LjoeAwZFKM8MmJBsjZ7/6eyIGHyes81dhl?=
 =?us-ascii?Q?7LWERCbKmsBV4Q3yG968RxcxT2dfZaqw9+5/CMoo+LdgCTSqxO5R8mqVLbkp?=
 =?us-ascii?Q?u+K0XmJqlNqan3UpfjtoeSy6+BWTVcFlDO5stKFPvkunnay/eZDpsSDm8f/g?=
 =?us-ascii?Q?j7WlrmiwUA7RKHE6c5MbtRd3zES+5mVZ9pnYw91B18+jW3R/XhWhJTvJbwbz?=
 =?us-ascii?Q?MgfrYvDI2kDUtVyilqo5ENoVOJnbOfKxYYvFtUCOnxbW6V+qPwX8wXicvKwo?=
 =?us-ascii?Q?PDJFH3KdG3CPNajfpUu6zJPeDRvw0IB2Lxsy0pQ+sDI+UwEzuMomhRUCzMQ2?=
 =?us-ascii?Q?rG3aX43SUIYahtYfSgzzPdl7FQl9ueqGT1nDx/3ynxvfAoQ5TXaHxrmYBwEn?=
 =?us-ascii?Q?5eKqtZzRWV9k/aHnK5iGxATG5QLR23q7tirsIvVCD0Ufo+zIXlRWwNLugeJH?=
 =?us-ascii?Q?ZnIuuIinGGX8VEnasL3kZrSIjeab7w/Pzmm9Qu/1Jr+JJF9YpiFEDpVOwTKt?=
 =?us-ascii?Q?+dXpy+4HT+z+TSc+Ccb3AcM8Lkw8l2dHPUa87KCit0aixBfoIUk/uoMp9uXi?=
 =?us-ascii?Q?lCqGxtH00iBJdRf5eM4Me/MwbQTHAJo28FlrL0uFb4y+VSS3BuZlKFZMvV5S?=
 =?us-ascii?Q?/K/WFFbTm9bd3upRNaq9GgePTvgFmSdIVo7i3kXsH1Wuo2zHxe21dFKpRJUY?=
 =?us-ascii?Q?Zws+riRapitIlXOoEdWBWmtE3ulNpGMs0yIjrqbiP2dQWzqfff2Ec5j/BWA0?=
 =?us-ascii?Q?WbR+k7PBekX0NVdVy6ja+REd/ZMFVOfEu7vCicpSNIYnxj7Ub/R54/V+aAng?=
 =?us-ascii?Q?uccgveUyKfu+D8AV2b3idGAPgMqVgnJf67eqpTILteQcFfE3aIgzrKq2gyYg?=
 =?us-ascii?Q?xxhVn6zxJDuWR7RFCRTF3QGY7REn4iHLLweLUkkPbj7VatneWJNayDHPwETO?=
 =?us-ascii?Q?JdGymndljs8OMknmzscC06P/1ofFZ5KDDbNeSe6awqbYHW2dyAeluQHeRIO1?=
 =?us-ascii?Q?2Qq0MZ/FRhyAtmkcEbyAjx/wRWF90jGF41orm+YuYgT/H3CogxQV3QMMuKrQ?=
 =?us-ascii?Q?7RgCBd+6RM5pnS2S+k0KNhURe3ocfjmylpDkrKeVHwblTmwXhp5cop/kNsjU?=
 =?us-ascii?Q?ka1Jk2DvLgc8aeEzI6Nq4t3WJsMXzevoQqnGs0M4h/tVXzJo2Xv9S0fVz2er?=
 =?us-ascii?Q?3umZyekHaTSmSrivQTHxFIw1tGoh34yjn5B/rHy34X0aTu9b+aMnlhhlmuLS?=
 =?us-ascii?Q?2nrFZnEWoK/FOZbFpNbFSeTEsDpyj+AStTEtfTnARbz9hBLnx9gIpZxSIkvu?=
 =?us-ascii?Q?fynBkr0Pp+vPqnQKjjtEEKEo2tE6ZxdDTIQkj/PnxUH7aP3rQfvgkZAg3dEu?=
 =?us-ascii?Q?MdXoImCe82JgjNp9QO4UgLKiqYteyPdZnuxrosbtNEWmT3WLdpcjj0s8xuAs?=
 =?us-ascii?Q?j+raRsW1KWTmnr/uga3DOZf7v4hCTFXU5gr4ubulvc6E5QWzfCsJSEnCSmjC?=
 =?us-ascii?Q?M0ftiWN12HoP6Gwtyv0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b610a5c8-6d4b-4e12-567f-08dde01f275e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 19:24:16.5491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aCyKA+II0KnvdH0/9nNMiJKSPVe9+1SMvT7pK+StSpi1CanZ58bCbNab9nYvaFruoaa3r7ZR4Md69pYbl3Uvow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD525C5379

[Public]

> -----Original Message-----
> From: Rakuram Eswaran <rakuram.e96@gmail.com>
> Sent: Wednesday, August 20, 2025 2:23 PM
> To: linux-doc@vger.kernel.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; airlied@gmail.com; corbet@lwn.net
> Cc: tzimmermann@suse.de; mripard@kernel.org;
> maarten.lankhorst@linux.intel.com; simona@ffwll.ch; siqueira@igalia.com;
> Wentland, Harry <Harry.Wentland@amd.com>; amd-gfx@lists.freedesktop.org; =
dri-
> devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; linux-kernel-
> mentees@lists.linuxfoundation.org; skhan@linuxfoundation.org;
> rakuram.e96@gmail.com
> Subject: [PATCH] docs: gpu: Fix spelling mistakes
>
> Fixed following typos reported by Codespell
>
> 1. filp =3D=3D> flip
> In Documentation/gpu/drm-mm.rst
>
> 2. complection =3D=3D> completion
>    implementions =3D=3D> implementations
> In Documentation/gpu/todo.rst
>
> 3. unpriviledged =3D=3D> unprivileged
> In Documentation/gpu/drm-uapi.rst
>
> 4. propogated =3D=3D> propagated
>    aperatures =3D=3D> apertures
> In Documentation/gpu/amdgpu/debugfs.rst
>
> 5. parition =3D=3D> partition
> In Documentation/gpu/amdgpu/process-isolation.rst
>
> 6. conections =3D=3D> connections
> In Documentation/gpu/amdgpu/display/programming-model-dcn.rst
>
> Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
> ---
>  Documentation/gpu/amdgpu/debugfs.rst                       | 4 ++--
>  Documentation/gpu/amdgpu/display/programming-model-dcn.rst | 2 +-
>  Documentation/gpu/amdgpu/process-isolation.rst             | 2 +-

Please split this into two patches, one for amdgpu and one for drm.

Thanks,

Alex

>  Documentation/gpu/drm-mm.rst                               | 2 +-
>  Documentation/gpu/drm-uapi.rst                             | 2 +-
>  Documentation/gpu/todo.rst                                 | 4 ++--
>  6 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/gpu/amdgpu/debugfs.rst
> b/Documentation/gpu/amdgpu/debugfs.rst
> index 5150d0a95658..151d8bfc79e2 100644
> --- a/Documentation/gpu/amdgpu/debugfs.rst
> +++ b/Documentation/gpu/amdgpu/debugfs.rst
> @@ -94,7 +94,7 @@ amdgpu_error_<name>
>  -------------------
>
>  Provides an interface to set an error code on the dma fences associated =
with -ring
> <name>.  The error code specified is propogated to all fences associated
> +ring <name>.  The error code specified is propagated to all fences
> +associated
>  with the ring.  Use this to inject a fence error into a ring.
>
>  amdgpu_pm_info
> @@ -165,7 +165,7 @@ GTT memory.
>  amdgpu_regs_*
>  -------------
>
> -Provides direct access to various register aperatures on the GPU.  Used
> +Provides direct access to various register apertures on the GPU.  Used
>  by tools like UMR to access GPU registers.
>
>  amdgpu_regs2
> diff --git a/Documentation/gpu/amdgpu/display/programming-model-dcn.rst
> b/Documentation/gpu/amdgpu/display/programming-model-dcn.rst
> index c1b48d49fb0b..bc7de97a746f 100644
> --- a/Documentation/gpu/amdgpu/display/programming-model-dcn.rst
> +++ b/Documentation/gpu/amdgpu/display/programming-model-dcn.rst
> @@ -100,7 +100,7 @@ represents the connected display.
>     For historical reasons, we used the name `dc_link`, which gives the
>     wrong impression that this abstraction only deals with physical conne=
ctions
>     that the developer can easily manipulate. However, this also covers
> -   conections like eDP or cases where the output is connected to other d=
evices.
> +   connections like eDP or cases where the output is connected to other =
devices.
>
>  There are two structs that are not represented in the diagram since they=
 were
> elaborated in the DCN overview page  (check the DCN block diagram :ref:`D=
isplay
> diff --git a/Documentation/gpu/amdgpu/process-isolation.rst
> b/Documentation/gpu/amdgpu/process-isolation.rst
> index 6b6d70e357a7..c1297a9e4d09 100644
> --- a/Documentation/gpu/amdgpu/process-isolation.rst
> +++ b/Documentation/gpu/amdgpu/process-isolation.rst
> @@ -26,7 +26,7 @@ Example of enabling enforce isolation on a GPU with mul=
tiple
> partitions:
>      $ cat /sys/class/drm/card0/device/enforce_isolation
>      1 0 1 0
>
> -The output indicates that enforce isolation is enabled on zeroth and sec=
ond parition
> and disabled on first and fourth parition.
> +The output indicates that enforce isolation is enabled on zeroth and sec=
ond
> partition and disabled on first and fourth partition.
>
>  For devices with a single partition or those that do not support partiti=
ons, there will
> be only one element:
>
> diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rst =
index
> d55751cad67c..3496ef28b15c 100644
> --- a/Documentation/gpu/drm-mm.rst
> +++ b/Documentation/gpu/drm-mm.rst
> @@ -153,7 +153,7 @@ size in bytes.
>  GEM uses shmem to allocate anonymous pageable memory.
>  drm_gem_object_init() will create an shmfs file of the  requested size a=
nd store it
> into the struct :c:type:`struct -drm_gem_object <drm_gem_object>` filp fi=
eld. The
> memory is
> +drm_gem_object <drm_gem_object>` flip field. The memory is
>  used as either main storage for the object when the graphics hardware  u=
ses
> system memory directly or as a backing store otherwise.
>
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.=
rst index
> 843facf01b2d..7435664a1ffe 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -535,7 +535,7 @@ ENOSPC:
>  EPERM/EACCES:
>          Returned for an operation that is valid, but needs more privileg=
es.
>          E.g. root-only or much more common, DRM master-only operations r=
eturn
> -        this when called by unpriviledged clients. There's no clear
> +        this when called by unprivileged clients. There's no clear
>          difference between EACCES and EPERM.
>
>  ENODEV:
> diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst inde=
x
> be8637da3fe9..1d064e617699 100644
> --- a/Documentation/gpu/todo.rst
> +++ b/Documentation/gpu/todo.rst
> @@ -319,7 +319,7 @@ everything after it has done the write-protect/mkwrit=
e
> trickery:
>
>        vma->vm_page_prot =3D pgprot_wrprotect(vma->vm_page_prot);
>
> -- Set the mkwrite and fsync callbacks with similar implementions to the =
core
> +- Set the mkwrite and fsync callbacks with similar implementations to
> +the core
>    fbdev defio stuff. These should all work on plain ptes, they don't act=
ually
>    require a struct page.  uff. These should all work on plain ptes, they=
 don't
>    actually require a struct page.
> @@ -854,7 +854,7 @@ Querying errors from drm_syncobj
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
>  The drm_syncobj container can be used by driver independent code to sign=
al -
> complection of submission.
> +completion of submission.
>
>  One minor feature still missing is a generic DRM IOCTL to query the erro=
r  status
> of binary and timeline drm_syncobj.
> --
> 2.43.0


