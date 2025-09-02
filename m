Return-Path: <linux-kernel+bounces-796095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A4FB3FBDD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4C03BEC8C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32FA2EDD75;
	Tue,  2 Sep 2025 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="a3PmcGRF"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BD42EDD74;
	Tue,  2 Sep 2025 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807749; cv=fail; b=dYgbu938K4KfzotGVGknV1RfVXUYzSiwVNZytmSFOT716owmz+2lloInWkygY60G3Zs/0oFRu+OUXpglbrZ99v1t7pttoZaSS8G0KtIHUwQKO3Y88THuuM6w0fqewZSs2EzVrmyCj6vA5QckyMSeOLCgpSWTvrDs4iGsKhjWhdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807749; c=relaxed/simple;
	bh=o55uBt2raUgIMUzeZmDfWmInczYlwnzPz4m9LmpY4/U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AWBXxRvWEmter6Io6mwHut/7A5qNAsWkBQlpUQv+Al5OMICPzXplh8wyPODr2Jxpg2KkPRDJNTInyRpS+AR66Vgs+8ylhDrU4dkxEjKWYp8MOIpemrKM3aBJIvgjZI5b37PAtGsVzKAWMcZlUXLArWiVLh4wyAWZ0aQz0a9Bxsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=a3PmcGRF; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBomYgAXPEeEDjIjSKYI+zqegJxx48RIuFxGJICdzNqOcLlqr7qnbWtOE3Mqwf9l7C25R15lG6P4cBJVKTwxDggZYXbfaD5IqtmU360quwlHU6lV0sjvGSFRMi/EZJG5Xjfnvd5vtQRyndYRVlgJdemHM836HM/YPHOz+vtCrHVURovAwkeMv4V5z7uUc+wasqkxGT4r3oUEkxMwmfx25DqQEOLeAjdjQS9nDRTNCq/slgdl6eOBzAS6LQ6Ckm6Wzfq9vyxoVglCAKdE0yqJMm7W7UEX/HeW/0gdyeL7/RqLBG7OEGvM0NuLdyVvooHMqtWzG3eMAzGMfYfyfSf7JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHg1qFM01tJMigCatbQ+jjFvJMdZedaGTTL7b9UwAVs=;
 b=lAs/xc3w0308srQvvgtQOc8lN6sKWfSB22LFEvgrDJoE//l5AI/MXf9bOwpQfa7joHKI1aWVqLaUfOH6vhXHIhbo7WpjGCLEXLEbSbipS/Fe4GbIE8VbzItqTrvzAhNHT5V7YXybLW/YiAHrxH8F0vuQ/EhXymSjDZTdjYvWtyG2KysxJRq+hzz7Aihhpa8x/SgAUgFn9x382Yw0VIre24NbQETxTAm4MA2Rtq5YaDk2ST3rXm/TAwNhAZQ+Z7KhpUQzpm8R7Bz5q6PjwxuIqFDNOX1MO7dt7m6rxvjXflZBWH6Ckc1Q48uph4WB+C8V8vx1RnKapGMjjtt5iyxf9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHg1qFM01tJMigCatbQ+jjFvJMdZedaGTTL7b9UwAVs=;
 b=a3PmcGRFcM4xbEGXuxHpGDgdTVKro4H2QHbllYOK7lNHFk/Ld5m1U3jUVqanR1rB+T9hdWJBe4ceTbOOIc2/rtTb11BaoPHHCmVSNEvZn/qTkXv0jGFzao0nY6qDtBpic67ChmXQQVHDItGbFV1b9zDAX9ZY+NQwGWuBfNzEaOuEuiWyP6JFaefNGCCLwkgz/bZJG7ZAAAUeQOxWQU8LW81Wt7ZsqLBEAoSaQVeDb3GGftwGfsJ5sNvFCcjy4nu3NfempHNFIxJ2sWedk2htr3x4utL8XOLA6/y2C7rixNYVbCCbdU+K0w4BP2Ow4xX8o0qn6MSbvoXNTXqfS4xOSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN9PR03MB6201.namprd03.prod.outlook.com (2603:10b6:408:11e::20)
 by SJ0PR03MB5582.namprd03.prod.outlook.com (2603:10b6:a03:281::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 10:09:05 +0000
Received: from BN9PR03MB6201.namprd03.prod.outlook.com
 ([fe80::6b16:5fd0:112:ab8e]) by BN9PR03MB6201.namprd03.prod.outlook.com
 ([fe80::6b16:5fd0:112:ab8e%2]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 10:09:05 +0000
Message-ID: <1d26bcf4-ac25-4161-ab5e-2f823099cfb7@altera.com>
Date: Tue, 2 Sep 2025 15:38:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 4/4] firmware: stratix10-svc: Add for SDM
 mailbox doorbell interrupt
To: Dinh Nguyen <dinguyen@kernel.og>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20250812-sip_svc_irq-v2-0-53098e11705a@altera.com>
 <20250812-sip_svc_irq-v2-4-53098e11705a@altera.com>
 <f2411365-9443-43cf-8420-3afd2c5bf6e2@kernel.og>
Content-Language: en-US
From: Mahesh Rao <mahesh.rao@altera.com>
In-Reply-To: <f2411365-9443-43cf-8420-3afd2c5bf6e2@kernel.og>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::11) To BN9PR03MB6201.namprd03.prod.outlook.com
 (2603:10b6:408:11e::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB6201:EE_|SJ0PR03MB5582:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c642ecd-d292-4697-4df0-08ddea08bf59
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1dqRElxYmRQclBqUHZ1TEdqUWxoV1VBYmtzQnI5NmNmdmc0aWNCMW1xL1lZ?=
 =?utf-8?B?bmlTZjJ1ZzFmTTIvMnBUSVo2T0Z2ZGYyOUJITGdBd3I0eG4xL2tXRGxSTU1v?=
 =?utf-8?B?YXJ5QWdRdXJpek9EUVJldktMZDlLNG5XbENkTTlKT3pNZU5rdDIxRncyTHhT?=
 =?utf-8?B?OE02dEhqK2tUNStxcWpKMGRrL1UwdXVUbEFaMUJ0Slg3UGJGNUJubjdXdk5N?=
 =?utf-8?B?Vm15MTk2NEl3NGM1NHNlellUODREQy80VkZCM2k1YTlTbXpaWXpMaDJlRjNT?=
 =?utf-8?B?VlAxNFZ3VjkwdUloWEVSVmlOZ3RsMXUzcHVtbk9uQWhML2pvQ0lXZGpWVW1j?=
 =?utf-8?B?cTZ0OW1JZVIwdERXSFA3dDBaVjJSNmlrZWpnTCtIaU9NUlJmRjBoQ0djc2Q2?=
 =?utf-8?B?Y1FiR05KL2pJcWlDMzRYVTlJcFlybmtLZUNhZGFybnQrc0tLSU11NWFiZXRH?=
 =?utf-8?B?SnJ1S0UzRkc0VEdpU09XUmFxYzhsbm9hdkpWT3pUdDFEOE1kRWd2ays4dklT?=
 =?utf-8?B?eW1JcGRlSzRUc3hZdHJycnNCQ0hySXFzQTNSYnphcTh2SWV1U0FlVXEvYkxs?=
 =?utf-8?B?ckNSQ1htWG82UVJiMG96RzNxRnU2LzZIeE5zY0E1bmNsazVEZ3RPZjRWL3ZI?=
 =?utf-8?B?eDdtOVdqbkVPYnVicTZtekEzVUVQYXlocFgwZVpNV1Y1U2l2VnFreWZFUGtI?=
 =?utf-8?B?WHo1aFJFM1FQcWg0UTFxaCszWi9Qamk2Lzk1NWVta3ErNThmVnp3TkUxYVN5?=
 =?utf-8?B?NmF2aU1PTEhZa2JQODQrSGpENnFLT21wNE9BdkdZdU92cHREcFU4cndBSitn?=
 =?utf-8?B?NnVRVTBzWkt3SUl0N1BXQlJSczhBMXZOV1NWZStiTmEvY1UrY0NXZWJNNkNU?=
 =?utf-8?B?ZUdCV2RJRWRwT1FvbnQ3dTl1bHpXdFV5bUw1dmNESXFZVitjMTJYS0RzL21Q?=
 =?utf-8?B?MVRjWTkxaDlrRktTM3p6QUZRTHFTajUxKzhOV2RmRGFiZHNJbTVJRitDTTcw?=
 =?utf-8?B?RjZneTNNVHRuNFgrdzhoSW1GWEhBWlNGbkhueW9FSzhEdjE4QWo2RXA3R2Ni?=
 =?utf-8?B?dys0WjBjVHlWKzBzcFQzMWRDenJ0aXZCZTdxZXB6UFNpNDRVdk5BNjlXelJ2?=
 =?utf-8?B?Mlh6RElhUXU5ajVNVE5LNFdEM1JERnJEdEFoRHR2bXBxQk5tUGQwRmJDcUdo?=
 =?utf-8?B?eHZoNnNrTjAyWlR4eXJHd290RWNJVm4xdXIxVEx0RGc2SXFlQTR1RURlRVRr?=
 =?utf-8?B?REI2Z1ozSExHcjh1UDUvKzMxWWdhYnZjRWJ0S1o5bExHcmNMcnNCRGVYclQw?=
 =?utf-8?B?eVp6QzFzbkEwUDhCR1Z4dVVVT3k3NEkrQzJxTEJ5aGJEMjJ1UmRXd2tRai9a?=
 =?utf-8?B?czJpMXkyUHU0amZoS3JpUjIzQ1Fib2tja2hBSGxubG0rc2swUkR1eDFET29j?=
 =?utf-8?B?V1krZGRndE1sVW1hZDBjbnBBcEwxalc2ZnYrODZxZFdtYjIzQnBWU1BMNHR6?=
 =?utf-8?B?NVI3WDFIN091ZC82RjhuUDZyenM3ZnZuTmlwdmtNK094SFNweE1nTG5lSk9R?=
 =?utf-8?B?UlhqRlJwV2VYN1dlN2N6eVRZcnMxelpvTWprSk0weHA0dWxuNVlqYkdqbzVS?=
 =?utf-8?B?amxHZ3IycmRGZWhkZy8zMTJ0MFBSUTl3dDgzdTN3OTJETlJVMDV4QllPc2VT?=
 =?utf-8?B?bUpwMDh5bVU2eXI0YTJpTExGekNEUGpTZzF1SUpGcXFSdzBMR2R3czFHR0po?=
 =?utf-8?B?UHFaWE5vMkZOMTN2ZS82Q0ZzOGZDTGVYWmlRN3VMdU8wRGhFdGhYYnNIampV?=
 =?utf-8?B?NjNIaHN3YTJFRWFOckhXMkJDSmx4NVEzblN5eHhrU0ZhZUFDWTFRRW5jaUEr?=
 =?utf-8?B?Z090V0s1UXBEc2pXdktZM2Y1MzEvYjBzWFNpZkZkUHlmWDJSTlZqYm0xT20r?=
 =?utf-8?Q?QSKDuWEBeG8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6201.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3c1SlJrUlVqcHBFakM3eEhUb3pwUVlSVTlpbFVDVzIwUjVqMHdCOFdmZVoy?=
 =?utf-8?B?cExpSVI1dHlYYlRFZklGR1Q3aVA1UTV2RlVaVldhOUF2ZThlWCtFUWJPSHc4?=
 =?utf-8?B?T0JpZ1BjMXRhcEkwNlVzK1hIWW1mZ2JKZGdSRm42MXYvMUdaNTZiS1Vjcmxl?=
 =?utf-8?B?RzI4Z043UGNBZjNVZFNLdlFjZ2VrVWNHTXU5VGM3TERyeFVZeTNWOFdLZndY?=
 =?utf-8?B?Zm0yTHFBNVg3M2YyUGdEcjd3dnJZSzBrNEQ3Qk5TTndsUUZ1RUc4L2d1L2Fn?=
 =?utf-8?B?UlZrZzBodzJ3T0JWSDlXOTlTYzJPWlV6amNCTUNDR2lETEF1dC9EcVFFalNO?=
 =?utf-8?B?b0E1cUxTbUdLUlNDYWhhMHhEaW9rTi95cDNTc3BROTdkbVlVZzRVbFFWdWVE?=
 =?utf-8?B?bUNDMWl3QXhBaVJaSzlYUkNGRXQ5dVVVRWlTakhhV3pOTDl3QWJEMk1ZMVBV?=
 =?utf-8?B?bitHdy9ueHNNTFJTeG5PWnNFYjN2WlF5N1Y1VUIwbDBRSHc2NWF6V1BaNDZV?=
 =?utf-8?B?QkRMSldnRGhxRk1UWXloT2g2QXhaRHRGcE9Cd1pxMVdtMEhsbE1qYUNiejlv?=
 =?utf-8?B?YXFvaFNXMDlmMXh1Q3FoeWNXZ3NwbGtKNGdhRk9xZDhKNkw5MzNQbzVCMmJq?=
 =?utf-8?B?NjczWVBIT0hYNDZWN0NPMWZ3UWxrbk03ZnhtWGExRUpUZGVMWU45U3U5WjFw?=
 =?utf-8?B?Q2RicXJDL1ViNHBpdkF4Uzk1WFBxb0E1ZlpucnF0a3Njc2ZpTytMbWxJWGdW?=
 =?utf-8?B?c2YxMmdJNVoxQmpzZWtLQ1RCdnBZRTIzR0pTRHBDNHYzNEhQdUpxL3BTa09H?=
 =?utf-8?B?VXBpdmE3MmxJTmxDQ3Y2ZjA0RTJpYXhvTWhQZTFUbEFscG1yOUlpNFJUUDhX?=
 =?utf-8?B?Ylp2RFNZSi8renpvdVFSclRtRnFZeFlRaG5vUmtvemEwMVZkK0xtM2NRNjVJ?=
 =?utf-8?B?a2o5OG00bXNFWmd6bGpkSkRFQ00vVDdLRFQ2dXdscXZnTFhxNXRtV1ZhQ3Yz?=
 =?utf-8?B?dkw3R1VKeHFaQnovVmwxTldtb1RBYlBUaVFKYm9DS1d4OURld3BJaWYwblJv?=
 =?utf-8?B?SFNzOU9LVkxTUzRXSEl1T2tqVTNKZ0dJYityTXZFek5PKzBCS1AwalJHWTYw?=
 =?utf-8?B?QjZvREVkNGw2azNQWmNXOGkyZmFLc0ZPSGV2TTNWbmJpSGx6cmN3SmJMQWRW?=
 =?utf-8?B?MkdjL1Q2R3p1cEVrOGFsY0lQTk91VXUvSWlGZ1dvVFFsU0xsNW1pSFRVZy9K?=
 =?utf-8?B?UktDMEg5UEZvZjIvcWM1cTNqSW9JOFMvUGhlYzA3dFNldUlaZzNJVVl2TTVm?=
 =?utf-8?B?cjhSRkpNa0ZtZGplYWxwcVJXTE5VTlYydEo3bXBTMjhJZVdsZkw1ZW1Mc0M4?=
 =?utf-8?B?YXBiZVIzdWN4dlRBcS9ERmtYdithRmhHZ0pEbXlSZklqRmY3Q1NpUlBnOHRC?=
 =?utf-8?B?TmZDeFlzYVdGWXpTK3ByMFFYTmpnSGErbkFDeDhta3R0NjJmUXYzekREVzdh?=
 =?utf-8?B?QWVydksyVHQ1ZnB5WjViZ3dLQ0JaaFNPTU5oZFNMSVpUbGZJSWhkVENWVDhS?=
 =?utf-8?B?bHNlK1hsZ3MyMGdGZmNZSktnb0NwSlA0d2lvRjlaOFlpWlRxaXVWbHE0K1lt?=
 =?utf-8?B?dU1QR1IwTVBKZWgrdlZIaGRFc2k4RmkzeWx6U1BkbjdYV1RMMy9heTNEbVh2?=
 =?utf-8?B?cHc0eTN5c0NWOW1KNEY2Q3M2OTg5dFkzbkVUZjRxdkRJV3Q2M0xjcWNQQVAy?=
 =?utf-8?B?QmZwaFJUK1BvcnFBcFNSa1kwN0l5RWxiNzBKTG4xZXJOSjFHYjJaanBBOEtv?=
 =?utf-8?B?TWJGME05SGRvSVRUckVtaGcxVDZ2cU1EY0Z4RlNGT3N6SEFQbWRsb05QTG5E?=
 =?utf-8?B?QWJQNy9LYk43TXI3VVNDbjJlK0tqUWVwTUVuOTJDQXhReXlhZGMwc3BqNlNL?=
 =?utf-8?B?cDJLN25CbXR0ZTJVY0QwTjNvODJ6Y0JubW91VEFpZkc1UVc5VnhmbFJRRER3?=
 =?utf-8?B?QkxvZWdTSG9FSFhndUY0dGc4bVVhN3Y5eWtrbnVoc1VJaU1XMWF5cndqQlJS?=
 =?utf-8?B?OW1WdGJsdllKMUo2Z0ZpTUlrSlFUUmZ0VUF4ZFJSdXBTdndpVGxKbU42TGta?=
 =?utf-8?Q?ekv2AFcy3khajegPY83TLiLD4?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c642ecd-d292-4697-4df0-08ddea08bf59
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6201.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 10:09:05.2956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrYN5l2zH1vu4aCr5KJBhVmC/6n39PZ+RGyH6A1nQlNjRats+S27FxNEHWhy/mH5DPSxXqgZdxc1FoWSoa/cLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5582

Hi Dinh,

On 01-09-2025 08:46 pm, Dinh Nguyen wrote:
> 
> 
> On 8/12/25 07:59, Mahesh Rao via B4 Relay wrote:
>> From: Mahesh Rao <mahesh.rao@altera.com>
>>
>> Add support for SDM (Secure Device Manager) mailbox
>> doorbell interrupt for async transactions. On interrupt,
>> a workqueue is triggered which polls the ATF for
>> pending responses and retrieves the bitmap of all
>> retrieved and unprocessed transaction ids of mailbox
>> responses from SDM. It then triggers the corresponding
>> registered callbacks.
> 
> You should configure your editor to use a full 80-char width. Why stop
> at ~50? When you're unsure, look at that other commit logs from other
> developers. If yours doesn't look similar, its probably a problem. For
> example:
> 
> "Add support for SDM (Secure Device Manager) mailbox doorbell interrupt
> for async transactions. On interrupt, a workqueue is triggered which
> polls the ATF for pending responses and retrieves the bitmap of all
> retrieved and unprocessed transaction ids of mailbox responses from SDM.
> It then triggers the corresponding registered callbacks."

ok, will do.

> 
>>
>> Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
>> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
>> ---
>>   drivers/firmware/stratix10-svc.c             | 117 +++++++++++++++++ 
>> +++++++---
>>   include/linux/firmware/intel/stratix10-smc.h |  23 ++++++
>>   2 files changed, 130 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/ 
>> stratix10-svc.c
>> index 


>> +    struct work_struct async_work;
>>       DECLARE_HASHTABLE(trx_list, ASYNC_TRX_HASH_BITS);
>>   };
>> @@ -1709,14 +1716,81 @@ static inline void stratix10_smc_1_2(struct 
>> stratix10_async_ctrl *actrl,
>>       arm_smccc_1_2_smc(args, res);
>>   }
>> +static irqreturn_t stratix10_svc_async_irq_handler(int irq, void 
>> *dev_id)
>> +{
>> +    struct stratix10_svc_controller *ctrl = dev_id;
>> +    struct stratix10_async_ctrl *actrl = &ctrl->actrl;
>> +
>> +    queue_work(system_bh_wq, &actrl->async_work);
>> +    disable_irq_nosync(actrl->irq);
>> +    return IRQ_HANDLED;
>> +}
> 
> Add a newline here.
ok, will make this change.

> 
>> +/**
>> + * stratix10_async_workqueue_handler - Handler for the asynchronous
>> + * workqueue in Stratix10 service controller.
>> + * @work: Pointer to the work structure that contains the asynchronous
>> + *        workqueue handler.
>> + * This function is the handler for the asynchronous workqueue. It 
>> performs
>> + * the following tasks:
>> + * - Invokes the asynchronous polling on interrupt supervisory call.
>> + * - On success,it retrieves the bitmap of pending transactions from 
>> mailbox
>> + *   fifo in ATF.
>> + * - It processes each pending transaction by calling the corresponding
>> + *   callback function.
>> + *
>> + * The function ensures that the IRQ is enabled after processing the 
>> transactions
>> + * and logs the total time taken to handle the transactions along 
>> with the number
>> + * of transactions handled and the CPU on which the handler ran.


>> -    int ret;
>> +    int ret, irq;
>>       if (!controller)
>>           return -EINVAL;
>> @@ -1775,6 +1849,22 @@ static int stratix10_svc_async_init(struct 
>> stratix10_svc_controller *controller)
>>       hash_init(actrl->trx_list);
>>       atomic_set(&actrl->common_achan_refcount, 0);
>> +    irq = of_irq_get(dev_of_node(dev), 0);
>> +    if (irq < 0) {
> 
> 0 is a failing value as well.

will add this.

> 
>> +        dev_warn(dev, "Failed to get IRQ, falling back to polling 
>> mode\n");
>> +    } else {


>> - * the asynchronous ID pool and invoke function pointers to NULL.
>> + * This function performs the necessary cleanup for the asynchronous 
>> service
>> + * controller. It checks if the controller is valid and if it has been
>> + * initialized. Also If the controller has an IRQ assigned, it frees 
>> the IRQ
>> + * and flushes any pending asynchronous work. It then locks the 
>> transaction
>> + * list and safely removes and deallocates each handler in the list.
>> + * The function also removes any asynchronous clients associated with 
>> the
>> + * controller's channels and destroys the asynchronous ID pool. 
>> Finally, it
>> + * resets the asynchronous ID pool and invoke function pointers to NULL.
> 
> Did you mean to repeat the same paragraph twice?
> 
> Dinh


