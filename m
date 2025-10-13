Return-Path: <linux-kernel+bounces-850136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 242A0BD1FE3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C14E34E6548
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477D52F28FF;
	Mon, 13 Oct 2025 08:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="O4BreR6e"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013009.outbound.protection.outlook.com [40.107.44.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587672F28F6
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343586; cv=fail; b=YvM2LjR27MZmQrxE6zRttDjqJuSJEoyFcgr7o/A1Jd8rfRle/bUvQigLZHCdi2lTIOT/FhEmmWqGoki6h23wHBYu0T0efoSqwRIHxAroDPWncckPs+8/BsY8ymBO1fk60yKEM+DI9DWypnE25rB9LtM4ElfXeIwREZiH9ycYKiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343586; c=relaxed/simple;
	bh=eFw84Lt2/QgwiLRmKaf7eU4kLR9FPZ7fFj9hmouMev4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iR3HVc/hga5AuSck2G0qPaZBdAybQIguM2LMguvT1nr8n0VPNIOSH2O7SIKvQhb/AhWo0m7NS0sRM2uycEe0+q735JDOC9+ovLExVohj2Dtwg9vPVawytkgGWqSqTEn4yjmfNyiRetcFCK5lCenFr7yu7mzqCE0B+u5aw/laCco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=O4BreR6e; arc=fail smtp.client-ip=40.107.44.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4Sz0iKrWapZAiDK01PQsCn02RFBsUJG3PxXHqyX6eQ8aJszc06YeVPhv3nEOcGrmXqsoq1DKBtk+aR5qj0ehU2M0rOASkuQo0e0u/TadU0uX2DECUgpZ+NFzaN7Yc2gdRN438FxxlWRV1cXM6me1yfxpN33KO5EbT3E+TxkK/ec7JgR5CiDkXlqeiml1lc6ld8mwfH5D5Y2jZvV6zUmif/4/E0hvE5+OivIw4UKbVcenw+JSZ+6Wa5M3xZWMamSQ2o3OCEHxIw4VnlqlnBeeEMARPZ8mawkj46jB0EhEchNJLMzZNEObSET/eA4GudfOMPU3O3jAcVaUg2wOaVz3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFw84Lt2/QgwiLRmKaf7eU4kLR9FPZ7fFj9hmouMev4=;
 b=xHJYYzcz2jYGrOBG/nRkRCLLR0i2CwVFJTpt9S7IWKqdZAF666zJSi9Ip8Q2bn7JtlcEcYZBFliBzHbS57+Oi7rcu5GLDVIM2bnZ3+E8W/dhPK7KEc0F7PT4VPVF4Vfh8Dh52PZuy/MC90y+T2PEm6eG9G0WhObMyXR7eYYzVTIUPSOuyX/UnmQdaQwbnL5vD/GnZmTjjD+HLxYuAUldiTq6M5hu6uKbTe8i/UnGzmT/+yZlacEmCpSewcii/5VNyac+ldcc9BJAtZ5j6Xj8QNGuDAxT8IZbdnMRjDZHENdbpVoRiNIgozYBStFM3ODEeul+pZav4YeaOnFTtErVxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFw84Lt2/QgwiLRmKaf7eU4kLR9FPZ7fFj9hmouMev4=;
 b=O4BreR6eQzpW7Df6raKAg5XpZcPa2fldaknsABSvEIsdXfA7tZClmclcAR4MCzkkqjeO4M1Yfz5rQDz+QTTZKq05kFmZUzqPQq0FxjEf45Q1NbnLWX+21/f9pcf8MBMtNw3N7Jqf0CZCWiyGUPtIY5o1cUkYpIEk+Lr6nB4FSg6uW0QKGy3+z0i2Ohb+X4rOgY2oUuhNNVEx2aod8Gs2v9JB63ZLOjyh75SZ9GtY+E7hne22hbldlxW0Clsz8ZCUbMGG9hXacePVTQ4TtJBXyugYTgbi3tFz0A2LVyJwKPALgBQuzzkMRqrs5NcXq/3xSYCB4DO874nmwDlMr+OwxA==
Received: from PUZPR06MB5538.apcprd06.prod.outlook.com (2603:1096:301:ec::8)
 by SEYPR06MB8065.apcprd06.prod.outlook.com (2603:1096:101:2d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Mon, 13 Oct
 2025 08:19:37 +0000
Received: from PUZPR06MB5538.apcprd06.prod.outlook.com
 ([fe80::ad8c:f38:8633:708a]) by PUZPR06MB5538.apcprd06.prod.outlook.com
 ([fe80::ad8c:f38:8633:708a%6]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 08:19:37 +0000
From: =?utf-8?B?5p6X6Iqd6amw?= <zhichi.lin@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "elver@google.com" <elver@google.com>, "will@kernel.org"
	<will@kernel.org>, "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
	"samitolvanen@google.com" <samitolvanen@google.com>, "yee.lee@mediatek.com"
	<yee.lee@mediatek.com>, "keescook@chromium.org" <keescook@chromium.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?6LCi57qq5YWD?= <xiejiyuan@vivo.com>
Subject: Re: [PATCH] scs: Fix a wrong parameter in __scs_magic
Thread-Topic: [PATCH] scs: Fix a wrong parameter in __scs_magic
Thread-Index: AQHcOohIrECQhbV/0kOlisl0zf3oW7S9LwuAgAKQHQA=
Date: Mon, 13 Oct 2025 08:19:36 +0000
Message-ID: <8ee8f1d2-feb6-4b96-af17-c3a690e01a46@vivo.com>
References: <20251011082222.12965-1-zhichi.lin@vivo.com>
 <20251011101117.0b48ecef0dc7cfdd1f871273@linux-foundation.org>
In-Reply-To: <20251011101117.0b48ecef0dc7cfdd1f871273@linux-foundation.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5538:EE_|SEYPR06MB8065:EE_
x-ms-office365-filtering-correlation-id: e93c550f-50a7-45c0-ee18-08de0a313f87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|42112799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RXkxVURkVDE1bGJHSXYySzBWejNZR0lkQUZrK0VhK2dDQ2QvdGI4RlJkQmVr?=
 =?utf-8?B?eVhTdTdBRGlLUDNMOGRwa2F6NzRRanJac1U4U3VyL2dWYitWeVk2VERrOGND?=
 =?utf-8?B?aExGcjBMRW05NTJyTDJNWEgveG5FTFNDNzB4VTNzaEdnOHl6N0NIbTB0K0dy?=
 =?utf-8?B?Z0c1NnlIZVd1Y0VlMnJaV3FpTzhNYnIwNHF2U2NRY0l6TzU0SjNHV3ZLaUhH?=
 =?utf-8?B?UXhLcVN4WWQxQzlXQkV5RkI1d0d3a2JjZS8ybzZ6c2g5T1dnektZczZDTEx4?=
 =?utf-8?B?RE83ZDFnKzdHWjI1ZmljWXVRY1hDdFNUQzBTY2hzcitTQmdubFkwREswQXRv?=
 =?utf-8?B?L1l1SjdSOE95aW50WWM3WjJzTmVuUWVvVi9YZWtYUzU5dStIV2czUjdja0hy?=
 =?utf-8?B?QWh0YTErRk9QWlJtNHhBcHlxaFdKZHNWN3pmTnR3S0JZMEpiVFFUaml6TWdM?=
 =?utf-8?B?STk0UnF0NWJFNUdUV0RYVll4VDQrS2tJK25ucXEvOXlpa2tqNVpQS0ZmejJj?=
 =?utf-8?B?NnBmRWJzejFEU0FRMFdvQksvNmdxR1FTNW14U0ZkNlk5ZGEwUnZMUUlqQita?=
 =?utf-8?B?ZGdoSGI1c1Q3N21GbU1OZ0hUcjRuL1ZpaDBxV3JvN1BSZDFOQVMwTUE2VmVu?=
 =?utf-8?B?UkxGQkI3K3plYmJvNnp1dXI0Vmx1L2U5T2J4VkxyUWVlQTRhZ1FFK1lOVEFO?=
 =?utf-8?B?ejFQZTBZSzdyOWd5ei82akkzdW9ubkJpc0VScTJFWW5JK2NGeDZRakpDaWFn?=
 =?utf-8?B?S1cvWVIyWUl2VFhBTU1YOXdheG5rdU5uOVlOWDFJVWwzNDNqL2VCeDIxekh6?=
 =?utf-8?B?M2F0SWdRaDJEWXd2UTJ4R3luYnI2MkQ0NzFrMW4rNnROaEw0bndXM3JJZmVu?=
 =?utf-8?B?cWwvUENHb3c1SGExY3U3OHhoOExzSUlqaHhxaVNMdHhiOW5IQnRiS1NtNmti?=
 =?utf-8?B?aG1XK1RkeVNpZUkvS1VEcEFPVGUzOTJaQjN6cFJUUGpyM1crUXh0ZTAzU2xN?=
 =?utf-8?B?TU03SSthcXdzeWQ2cng3di9nMjRGeDRSQjFpWmx2TG14VXk4V0k4SjBSRElw?=
 =?utf-8?B?eVVuVm1FZW1razFaWTdNcTFvRGVzN2ptNHJSM1VWaGw3aGhDODd1aFh6L3Rs?=
 =?utf-8?B?eDNvSktUbWFhRDVoZmhVV2xldEZDcmFtdmNNb3M0cm5HNlB4cE9mOW1zT09k?=
 =?utf-8?B?ZUZMUEhlcGhXQUxNMktwQm83R1F5WTV0MytGclVteTlETDVUM2wzYklORVRk?=
 =?utf-8?B?RjZwV2xza2JnN1hkc1BnL0YxT3JjTjhEVXIxQ25XZEFHY0JIU1B6SFNHbTV3?=
 =?utf-8?B?Tm5aTzhpMEJtenRQK0NDc0E4QzJLVDRpM2JaNkVBRFk3M3Q5SkdKcHFXazhM?=
 =?utf-8?B?SDh5Rlk0MjlYUGpVQzJCc0puYzZHRXdvR2VLZ0hlL0dBTERSOU00VkZPZGND?=
 =?utf-8?B?SERla1NNc0MyNmN6R1dQR2dBSzJpOGtVMUVKUUNlSjY2ZUNEcDhzMVpPQzU0?=
 =?utf-8?B?N0VrS2FkNnNwazlvNGhzQlV6UEU0djJyNHQ4RWxEMTJNU1RHTHgyenpQSHpW?=
 =?utf-8?B?dmpITG5TU2NvSHA3b0dYek9kSi94SmloZXZxUStoVVQxRmd3WmxwcitPVjdj?=
 =?utf-8?B?aTRnTUpYQm8yUGkzcFJtOXFCajRoOVZHeU5HcWtmZ21ZVDR4MFJTU25uUkcv?=
 =?utf-8?B?MFlSalRZL2REMDJIMGp1QThUWUYrS0NaTG96MkUvcDF5UWk5NXlRV3Yrc0FW?=
 =?utf-8?B?MVVVTmlGaUUxMkp0TkNmT3RNUjhLUDhwTEJJdDJVSGVyTUkvbDJjT3ZoeXk1?=
 =?utf-8?B?d1kzeVNKYks5TEJCaFNEdU41L01CZHhqcVQzSENYMmRwR2J1YmJDUHpVei9n?=
 =?utf-8?B?WWQ3TkFiMStMN25SQlRyckFBR2JmVW4vQ2FtNEJYUXlOdW9xbHUvOFNlRzhJ?=
 =?utf-8?B?aW9zM0tGbzdOYkdibUtBZ0daeTdGcWI4VmtPS0tsUzhEcmo2RHVEMG5RQkRY?=
 =?utf-8?B?dERoRHlTc2tZekc4ZVA5NWp2OXMyRVMxNUpweWVDMnBOM3U0OEE1Y3NkQVAw?=
 =?utf-8?Q?8gwC1a?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5538.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(42112799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUtJYm5MekF4SlhTakRFZnpROCtGZ1lkZzQwaEgzWEIxUU8vZGI1a1Q3ZjJL?=
 =?utf-8?B?QWtMT2FmdjhLRis1WDhweXplY1VaenFEZy9lbjVRMGJiMDZWWlg0dUZ4cnlK?=
 =?utf-8?B?OEU4R2NJRWp1UmZRaVFoRTNSU3FPOWVsSHRjS09XdjdiRkdLd0VkR2FNMW4z?=
 =?utf-8?B?NzR2cTdReGpHM1VoZ2s0V2JjZTJPL1dIUEdpeTZtTm54dEY5N2pNRzZ0U0k4?=
 =?utf-8?B?MkNqZmZicmcyQld3NnF2SVFTSEFKU2VKckFUMVIvNEUrb1dnZVZZUGRZdWh5?=
 =?utf-8?B?cUlmVDNIL2NGa3U0WlVHQlAwekVBQ3hFTmhNTTFlcTZjUm9mNjJwSHVxTEh5?=
 =?utf-8?B?TW43My96U3BsNWpWMUlqMHE3Q2NYZVpBem1iRUlIU3JnRUZtekRFU29RNzNh?=
 =?utf-8?B?WjlHRWkxb2ZGUHR1aUdtUWI4dnJ6dWZoRVdmVUdjQkJ3UU9yZTExZFA3UTlo?=
 =?utf-8?B?MGtSaDFESG9QbG82WkQ0Y2xQdHBFRTlPNlplbmRER2R5Z041NDhqWlFGVnpQ?=
 =?utf-8?B?QndRSzFHVnBzcXh4dWFOVlJkV0VwL1Y0VDNYa2dqKzhRSUQzVVBiOVgyV3VB?=
 =?utf-8?B?aExMWnM1Tm5DSlhrZHdNaS83WkdmcG5SaDJ4RmtQbGMxdGpLaWpaWnArNFlm?=
 =?utf-8?B?STF2SjAvSVRtYjhuKzlEdWNuNFkwN0dvUXBZZ0xrVW9CejY3djArUUYzaEdC?=
 =?utf-8?B?TUYwNWowM3piR21kQlFlRUM2eVFHK3M3R2hFZm54V2psczZVVmNEbHFyWm94?=
 =?utf-8?B?MEIwV2xtRFVMTk9LaGFTT1kvR0FQUlFxUFVqM2JROEdjV1lTVTl0M2VraE5j?=
 =?utf-8?B?VnczSkcwdDFNWXlweDh4RU1kRWEzelNRTHgrOTBTYlR1WDhzZkVJK0pUSjhB?=
 =?utf-8?B?VWVDaXFPWWJQQ2ZuL05tc3VvcWdEV3poODFQK2gxWU9RdmtVVmFkWDM5MmdC?=
 =?utf-8?B?cEQ0b3hKeGlwTCtGYkRCNkJEMEUvZFRPRWI2ZStrVWRMdVRsQ2p1c2wxam9B?=
 =?utf-8?B?TE8zQXdzZjVFeU9DREFVVS9Wd3JqYm1SaDRvMGV0RFVjSGg3Yms5aEsya1hZ?=
 =?utf-8?B?TmNoN0V4d1RSK1ppVFdJdlU2b2xrTzkzY1h0cUdNYTdNVGVLakdsTlA3SEho?=
 =?utf-8?B?K25FRVNQVGpjT245OG1zbC9GdVlyREZkV2RpNkNPQ1ZWaHg2VEZHV0hMWC9B?=
 =?utf-8?B?ckgvQ1c0R1VoNUFqRlVNeWtXMGxXT2htbGkvZWlpYWNMSTFDM1JVcVRrWUNC?=
 =?utf-8?B?bmNKNEdWclFoNTdOUU43QTQwdzJTY1BKWGgvNFZxKzFSZ2J3aVN2Qk9XdUxs?=
 =?utf-8?B?OTJ0MWVkY1BJaVhOVWV2LzlMcFQ0YXJoRjFpdzNzaTFkeENGQm9WR21EZU50?=
 =?utf-8?B?MUZLZ09TV1ZXZGNLTk1iK0VIOVdOVHpHOUtpYXdUdmZGbXJTclFYOXdhaVBV?=
 =?utf-8?B?UjdMY3EwaGo3ajBISGlVOXJkNkttT1RzeVdJS0FTb2d1UXo1LzlKYW1jQ1RW?=
 =?utf-8?B?UVZPUlladHAzM0hndG91N3VEanN0Qy8wOGhjRm93amp3d2xCTTRyZFJzb0Y4?=
 =?utf-8?B?Z2RPKzdsOHhjUklSUVBtY2FPdjcwYmtJSDdmM1VkNEpFZWJGNWxpYk01NU5Q?=
 =?utf-8?B?TnhVaUk4U1E4cC81b0VIdmFoVjhzWng0c1hlQ29tV043eXhrUWtXM3FEZVF3?=
 =?utf-8?B?Y0hjbUxYTi84YzZ6Mi92Nm8yWHhhVzQvSDBqRWZUZ0Erc1F4MHg0RHNIbGZr?=
 =?utf-8?B?YWZpL0lXRnNyVWU4OUVrb3M2VnpNR3lRdWRMYzRJNnliTTE1R29KbVUxLzM4?=
 =?utf-8?B?bmhnbGN1VHB4bm1Xd0lxYWdaeDRCbTc3U1U0SzM1cEJLZHJjNE1xNmk3aEh4?=
 =?utf-8?B?T2IxeVkwS1pHM2lNUWNMRzFtd0NadDJQY3paekUwQVJvNHZFOW9GNk5EMGdR?=
 =?utf-8?B?S0V0OXMxQmRDcTBzSkdFSmcxNlZiRzhQa3lWaHFHWU13QUM3dU9zbXNYNjhp?=
 =?utf-8?B?M1BFeE5QblVPMytUNTlJd1lZOXFyMDJiYWEyTjh6eHpHdlovcWVJNDI3YVNq?=
 =?utf-8?B?ZWJiVVNKVFJRQ1c3UEZmYnRZRjAySVJlV1EyYTZJV29sSGpnKzlkaUFlTGI3?=
 =?utf-8?Q?4cXo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF57D7BBC21474489C87FDBCEBB42760@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5538.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e93c550f-50a7-45c0-ee18-08de0a313f87
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 08:19:36.8635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vEuAAwe0uJ7Qk5pCmDYYaWQcaE1F6nDxPNFxzxg4tvHqoV8Gp+ZZkZ/oStDcpWjrSGGkkCmD7gK0YpATEdUlYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8065

T24gMTAvMTIvMjAyNSAxOjExIEFNLCBBbmRyZXcgTW9ydG9uIHdyb3RlOg0KPiBPbiBTYXQsIDEx
IE9jdCAyMDI1IDE2OjIyOjIyICswODAwIFpoaWNoaSBMaW4gPHpoaWNoaS5saW5Adml2by5jb20+
IHdyb3RlOg0KPiANCj4+IF9fc2NzX21hZ2ljKCkgbmVlZHMgYSAndm9pZCAqJyB2YXJpYWJsZSwg
YnV0IGEgJ3N0cnVjdCB0YXNrX3N0cnVjdCAqJw0KPj4gaXMgZ2l2ZW4uICd0YXNrX3Njcyh0c2sp
JyBpcyB0aGUgc3RhcnRpbmcgYWRkcmVzcyBvZiB0aGUgdGFzaydzIHNoYWRvdw0KPj4gY2FsbCBz
dGFjaywgYW5kICdfX3Njc19tYWdpYyh0YXNrX3Njcyh0c2spKScgaXMgdGhlIGVuZCBhZGRyZXNz
IG9mIHRoZQ0KPj4gdGFzaydzIHNoYWRvdyBjYWxsIHN0YWNrLg0KPj4gSGVyZSBzaG91bGQgYmUg
J19fc2NzX21hZ2ljKHRhc2tfc2NzKHRzaykpJy4NCj4gDQo+IFdoYXQgYXJlIHRoZSB1c2Vyc3Bh
Y2UtdmlzaWJsZSBydW50aW1lIGVmZmVjdHMgb2YgdGhpcyBidWc/ICBQbGVhc2UNCj4gYWx3YXlz
IGRlc2NyaWJlIHRoaXMgd2hlbiBmaXhpbmcgc29tZXRoaW5nLg0KPiANCg0KVGhlIHVzZXItdmlz
aWJsZSBlZmZlY3Qgb2YgdGhpcyBidWcgaXMgdGhhdCB3aGVuIA0KQ09ORklHX0RFQlVHX1NUQUNL
X1VTQUdFIGlzIGVuYWJsZWQsIHRoZSBzaGFkb3cgY2FsbCBzdGFjayB1c2FnZSANCmNoZWNraW5n
IGZ1bmN0aW9uIChzY3NfY2hlY2tfdXNhZ2UpIHdvdWxkIHNjYW4gYW4gaW5jb3JyZWN0IG1lbW9y
eSANCnJhbmdlLiBUaGlzIGNvdWxkIGxlYWQgdG86DQoNCjEuICoqSW5hY2N1cmF0ZSBzdGFjayB1
c2FnZSByZXBvcnRpbmcqKjogVGhlIGZ1bmN0aW9uIHdvdWxkIGNhbGN1bGF0ZSANCndyb25nIHVz
YWdlIHN0YXRpc3RpY3MgZm9yIHRoZSBzaGFkb3cgY2FsbCBzdGFjaywgcG90ZW50aWFsbHkgc2hv
d2luZyANCmluY29ycmVjdCB2YWx1ZSBpbiBrbXNnLg0KDQoyLiAqKlBvdGVudGlhbCBrZXJuZWwg
Y3Jhc2gqKjogSWYgdGhlIHZhbHVlIG9mIF9fc2NzX21hZ2ljKHRzaylpcyANCmdyZWF0ZXIgdGhh
biB0aGF0IG9mIF9fc2NzX21hZ2ljKHRhc2tfc2NzKHRzaykpLCB0aGUgZm9yIGxvb3AgbWF5IGFj
Y2VzcyANCnVubWFwcGVkIG1lbW9yeSwgcG90ZW50aWFsbHkgY2F1c2luZyBhIGtlcm5lbCBwYW5p
Yy4gSG93ZXZlciwgdGhpcyANCnNjZW5hcmlvIGlzIHVubGlrZWx5IGJlY2F1c2UgdGFza19zdHJ1
Y3QgaXMgYWxsb2NhdGVkIHZpYSB0aGUgc2xhYiANCmFsbG9jYXRvciAod2hpY2ggdHlwaWNhbGx5
IHJldHVybnMgbG93ZXIgYWRkcmVzc2VzKSwgd2hpbGUgdGhlIHNoYWRvdyANCmNhbGwgc3RhY2sg
cmV0dXJuZWQgYnkgdGFza19zY3ModHNrKSBpcyBhbGxvY2F0ZWQgdmlhIHZtYWxsb2Mod2hpY2gg
DQp0eXBpY2FsbHkgcmV0dXJucyBoaWdoZXIgYWRkcmVzc2VzKS4NCg0KSG93ZXZlciwgc2luY2Ug
dGhpcyBpcyBwdXJlbHkgYSBkZWJ1Z2dpbmcgZmVhdHVyZSANCihDT05GSUdfREVCVUdfU1RBQ0tf
VVNBR0UpLCBub3JtYWwgcHJvZHVjdGlvbiBzeXN0ZW1zIHNob3VsZCBiZSBub3QgDQp1bmFmZmVj
dGVkLiBUaGUgYnVnIG9ubHkgaW1wYWN0cyBkZXZlbG9wZXJzIGFuZCB0ZXN0ZXJzIHdobyBhcmUN
CmFjdGl2ZWx5IGRlYnVnZ2luZyBzdGFjayB1c2FnZSB3aXRoIHRoaXMgY29uZmlndXJhdGlvbiBl
bmFibGVkLg0KDQpBZGRpdGlvbmFsbHksIHRoaXMgaXNzdWUgd2FzIGRpc2NvdmVyZWQgZHVyaW5n
IGNvZGUgcmVhZGluZyAtIG91ciANCnByb2plY3QgZG9lcyBub3QgYWN0dWFsbHkgdXNlIHRoaXMg
ZmVhdHVyZS4gRm9yIGEgbW9yZSBhY2N1cmF0ZSANCmFzc2Vzc21lbnQgb2YgcmVhbC13b3JsZCBp
bXBhY3QgYW5kIGJhY2twb3J0aW5nIG5lY2Vzc2l0eSwgSSB0aGluayBXaWxsIA0KYW5kIFNhbWkg
d291bGQgYmUgYmV0dGVyIHBvc2l0aW9uZWQgdG8gZXZhbHVhdGUsIGFzIHRoZXkgaGF2ZSBkZWVw
ZXIgDQprbm93bGVkZ2Ugb2YgaG93IHRoaXMgZGVidWdnaW5nIGZlYXR1cmUgaXMgYWN0dWFsbHkg
dXNlZC4NCg0KPj4gRml4ZXM6IDViYmFmOWQxZmNiOSAoInNjczogQWRkIHN1cHBvcnQgZm9yIHN0
YWNrIHVzYWdlIGRlYnVnZ2luZyIpDQo+IA0KPiBUaGlzIG1pZ2h0IG5lZWQgYmFja3BvcnRpbmcg
aW50byAtc3RhYmxlIGtlcm5lbHMsIHRoYXQgZGVwZW5kcyBvbiB0aGUNCj4gYW5zd2VyIHRvIHRo
ZSBhYm92ZSBxdWVzdGlvbi4NCj4gDQo+PiAtLS0gYS9rZXJuZWwvc2NzLmMNCj4+ICsrKyBiL2tl
cm5lbC9zY3MuYw0KPj4gQEAgLTEzNSw3ICsxMzUsNyBAQCBzdGF0aWMgdm9pZCBzY3NfY2hlY2tf
dXNhZ2Uoc3RydWN0IHRhc2tfc3RydWN0ICp0c2spDQo+PiAgIAlpZiAoIUlTX0VOQUJMRUQoQ09O
RklHX0RFQlVHX1NUQUNLX1VTQUdFKSkNCj4+ICAgCQlyZXR1cm47DQo+PiAgIA0KPj4gLQlmb3Ig
KHAgPSB0YXNrX3Njcyh0c2spOyBwIDwgX19zY3NfbWFnaWModHNrKTsgKytwKSB7DQo+PiArCWZv
ciAocCA9IHRhc2tfc2NzKHRzayk7IHAgPCBfX3Njc19tYWdpYyh0YXNrX3Njcyh0c2spKTsgKytw
KSB7DQo+PiAgIAkJaWYgKCFSRUFEX09OQ0VfTk9DSEVDSygqcCkpDQo+PiAgIAkJCWJyZWFrOw0K
Pj4gICAJCXVzZWQgKz0gc2l6ZW9mKCpwKTsNCj4gDQo+IFRoYW5rcywgSSdsbCBncmFiIHRoZSBw
YXRjaCBmb3Igbm93LCBtYXliZSBXaWxsIHdvdWxkIHByZWZlciB0byB0YWtlIGl0Pw0KDQo=

