Return-Path: <linux-kernel+bounces-836948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93B9BAAF36
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF463A7304
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB90F1FF5E3;
	Tue, 30 Sep 2025 02:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="tq/DYov8"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023095.outbound.protection.outlook.com [52.101.127.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC05A1EA65;
	Tue, 30 Sep 2025 02:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759198067; cv=fail; b=lUgGMdvpNw/oD+GFgb5dnBpZ9JNCeaK7HrN6lT9tPBCx9qhaZeqawUziiTCwjZpPQQNJnOnhaIle7kSWPP+tybAtNArvi5ZszObxxULd0zSQ3je+nSS2zQTFti5NLImaX11j6LVgGPvkh8eVrevLlE8T8goCseI37NYtKterkUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759198067; c=relaxed/simple;
	bh=SwtHcPx7wkBp4s1KyrzA457l2rtAc96RpM6Hs/lUShQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X8K+nlFwt5ooBFO+XI+Td7udmdnlu51MsJxt1LwCgcuF5FDB9tKnoH5Vh9dmibgGQuW3OAJYCVmwzFOQkZEFG9YTiJMU7Em/CRv4n29f2dlXA+8faOcgkl7qQdsBlqII3jbbV3dTFenaJh8V5Y6/qcwj00NXXG7kXDIALSQAE44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=tq/DYov8; arc=fail smtp.client-ip=52.101.127.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdcEfgc4efJuWNunMsGXMMB9vuc0gBSGYHA8ko+epAFh38UzoaZ36un9ym9wKdKLkpGAKT9jflVB3wk+Eg+PbTZ+FKgEWKWXRrYCXQmKPPH6MyWISW/D5tY9xVzr/vT8JibgqMEXzU3fzDsI5ib4HxyL6zlAXPsBpMbt3YtecbJKiGUWDiXsks5ihzBXW2AIEmsFD0Ytzc2hHZn+pMmFEaVNrCi5M1/hc4Ya0SHU40X8XenMiSWZihUXJAYPfkyUzKP494XDoOdVCxHBkpx167y73+hnglXwWrLIemvaDQRFNONHewboU01DaIvwCAHXR/F90voqX6Qr7YVFTKcbiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5YCV8WDuazodVawUS9VflF2Wb3gjBXW8hkwYpPr+Os=;
 b=ZTK74URVL5+BxtJR8k+f1jgi6uruQLyFLXFvnW5lMnuP7ZAjZ/u+EP45dX7YldtF2wqvIvrlFdU82HRj8mp2j41r7F281ocihAeQPg3nliOiJv6mQdm9+ARWkkqBIsycY1FUdPRacnKCu5RV4t11Mao2TTiKVGSdKaqfKzwHtwJmsf8jzlgd2VG/x4tw1M1qiJZazxQaUQd18EQmcqniSWF9A3snZAEdK49BY2BLHfNR7LEfA+nP6EVXT3E819hBWQuEtG19peOrTQS6TZHCbB8vbSQ8Ey0LIZfP5BZTC2O3F0yBnGUH7nHirThaKgilEXNEQ4SdpxypuIaKdRg9Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5YCV8WDuazodVawUS9VflF2Wb3gjBXW8hkwYpPr+Os=;
 b=tq/DYov8J96X7lyIbqu3ThfqoiWI+JA0Skv3AhDFq3yYefXIIuROAbaGD0c+WjKf1LzuXwALXSuMNvq+dyxs4XMnAo6x79UOW6tBH5Wi330D86QimocGUCWhIIDiLgv3YYlm0wzpPGTQdZiN7oIpwoGmiS4sbpbcu5Y7KRWGpi7dEDIS/JF4r8VmTx8MgKfChs9+d6dmJv5ujtyWmIay7ZLNw6MZlLsLgC7eoj+TvueB6VO/GzSkdECCnbNOEBwaCzOyR3ozKnPyJNRcQWqVH3/sgRRoTQ1UDjYmkgCT1BDsFYZiPEe6Ec6JbQzYdZGuzbwrE5/x4tEQMXWQmZ8amw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by SEYPR03MB8741.apcprd03.prod.outlook.com (2603:1096:101:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.14; Tue, 30 Sep
 2025 02:07:41 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 02:07:41 +0000
Message-ID: <1d450be2-bbde-4547-be6c-c7ae1605cc28@amlogic.com>
Date: Tue, 30 Sep 2025 10:07:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk: meson: Fix glitch free mux related issues
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20240929-fix_glitch_free-v1-0-22f9c36b7edf@amlogic.com>
 <20240929-fix_glitch_free-v1-2-22f9c36b7edf@amlogic.com>
 <CAFBinCBd5-s6vaBoJNerXavQiHgsv4Fm3v0svUX7geL=kJvVYg@mail.gmail.com>
 <20178015-4075-40e9-bbf4-20ae558c2bef@amlogic.com>
 <1jldyzrv2t.fsf@starbuckisacylon.baylibre.com>
 <e70e9aaa-f448-4f67-9149-cb5970c9bbd6@amlogic.com>
 <9834c7c5-9334-4c78-a2fe-588ff03cf935@amlogic.com>
 <CAFBinCCoX5+6+KQAtbhKx9KdSZhXVxS=cz8DfMVhjPX1c0iSPw@mail.gmail.com>
 <eee93d9d-2977-449d-8792-b2416f0c09ad@amlogic.com>
 <1ja52d5tbr.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1ja52d5tbr.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|SEYPR03MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b4f04cd-1e21-4632-aece-08ddffc622e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R09JUFFmUDBvaXpiZyt6Zk9qRnVwV0NZODN2SEJ4TkI1VHFtWWlQWmdsRXgw?=
 =?utf-8?B?MWlmZWhLdkcxWWxXWVZjc2tWNjQvNlpiVGVueTNaTlNiWTN3Y2d4eXgvUzJR?=
 =?utf-8?B?U2tFTmN0b0dXYVUyOXJvTXJSYyswYjZJU3pmdGkzS244SjFYS0w4T2RmS2t6?=
 =?utf-8?B?aHp0cnQyQnFGcWx2S1EwN3hZSVFxbjNKU1ExZUFvOFBqYjB3aVh3a2pXdU1Q?=
 =?utf-8?B?cGxJdWNhOS9JTS9KVkZ2L3h0UTR3TExGVTdGUThrMXBCWTU0TkxyQW9TT05j?=
 =?utf-8?B?Tk1ieFBsUUVnNjZ2KzZVcHVhVDdSb0wvTFZRWHNVbk5IcGhKeUQzMXZRUFBW?=
 =?utf-8?B?R1AzamJHaDl4SzNxUDFKRG9ra09TMTJxbVBJY0E0NW1xVE5YaHdrNW95elY0?=
 =?utf-8?B?YlltVE8ycTlHaUhBdjlKRGhYTmw2dlZudENWb1ExY3cxVFVaRHVRZm14VWts?=
 =?utf-8?B?RVh3TjdSd3ZCTStteXB0enpJTlVsM0phMkQxWGRlS2l1anVMQlBTR3dvaVc1?=
 =?utf-8?B?cEU4QUYwNWJxUUh0MHhiODU4YmhiQ2tod0ptbDc3dkJxVTlzUHJpcE9ua3B2?=
 =?utf-8?B?WDMzWnNXV3pPMThQTFZMNitvclJpcWw5TjVtNzRtV1puL2svZjI4dCt6OFpN?=
 =?utf-8?B?L3lJdjl2Ny9DQUVaOGt4cjFBenp3dEp2UUZLWGZaQmk0a2hQeW0wMS9aWnlK?=
 =?utf-8?B?ZVJKZFFFVzRLRmdCSS8zc3grRVEwdW9nVWZhZFY5Y0hhamt4Q2doaS95MFIy?=
 =?utf-8?B?SnpWNWVqUEFsNzZzeGkwbnFtblhUKzh2QUhMNm9qV0tpdHpwNUNzM2kxZmIr?=
 =?utf-8?B?aXowWVZ2b0E5WjNSZERBT3BGU1gyVkhYcm5kMTVMQ2czWnhVNnk3TDNEc0dL?=
 =?utf-8?B?Z0M4NFQxNis2bk9qS3AxeGxHR0NDSExoOStTYVB6NkdjeU16RkVXYWYrNWk5?=
 =?utf-8?B?RVFPR1VYY0J6QXZDWGhvbTB6R1JUT2JRTWJGNWVMQlR5UXFGdWRybGVFQjZM?=
 =?utf-8?B?V1plRVlaOCtwT3hFY25xY2M3dytlY28xZ2VTNVlYOGxMR2F3RnRRZTlveW1h?=
 =?utf-8?B?R043Wk5GUGpPNlUrWlhBMTJJbHh5TTl6a0tEVmpYOGQycjJLbS9PMklHekZu?=
 =?utf-8?B?UmVYQjM4U1FkNHdRdTk4NWRZcit5Rkkrb3lmeXQ2WktyVWFINU5qT1VyQnV3?=
 =?utf-8?B?MEFQa3l6eUxLa3hBQlZQekdmRmwwa0ovdXRydkFuYUE4UVhIVzFJWXEwc2VY?=
 =?utf-8?B?T2oyQzA5d3VCVmxDbkxtK2piVUkrQkp5akdTOUZSdnpVSzVZenZ5THJEMC9a?=
 =?utf-8?B?VDE4Zlh4UzV6V0U1ZXg0cllFdVpqZmE3UmVJOHJHK1dJQ1pieVJoY3FYT0JQ?=
 =?utf-8?B?Zm9zNHJnZTRUNG9VZktDcno0dzRKdHVQRG8rMXMrQXYxZUdzNDJhZGJ6V3hC?=
 =?utf-8?B?UENwOUxOVlZRZGwzYVBJV0hhcGFFb1ZqM0VTOEtYUFVRNXJNUStOMXArbHVY?=
 =?utf-8?B?MEpYWEwzRUJHVGZJdXFhTkV1TDE2amd4d1JVamE5UjEzQ1poUVZoOHpqN1ln?=
 =?utf-8?B?cWxBYkZQTVAvckIwVUZ4L0ZhaklETWU4ckNJWHhvTHFoK0hlMVZsTGJNaUVZ?=
 =?utf-8?B?V2I0RlNkMk11VmRFRjNsVFNuc01uS1o0c09jR1RoU0JGTHBkUU1UaWZ3RTlU?=
 =?utf-8?B?UDJ6WVY0Q293MFQwUmhvQ2tjUHRNZHY3dUZPemd5aWhNajVNN3JjYzlrTno5?=
 =?utf-8?B?OTlYOVMyQTVUVzNhbmpmYUdUZFRWd2NSbzQ4WFZSQzJrTEpOZzZwVm12WVNP?=
 =?utf-8?B?MFJ6TDcrU3ZyaWJlQ0Q1UFFNZCtGWWt6c3R3SDYweVM4Q2VnNTdCQndPbWoz?=
 =?utf-8?B?VnhrRGxvZERXVzlQSzJuQldIOFdmWUN0aGs0SmNtQXhhSVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmM0Zi9NbVZPNTdMbm5NVC9xNXQvd2NBa2dqNVdONTVaVC9KaFBuMVNIbFNJ?=
 =?utf-8?B?ODhNMll2ejdVdWZyd25IUFpJMW1uVWV4N2FpK2gvWDBZa0xHNDgrUyt3cTBZ?=
 =?utf-8?B?VjA3MzZ2V013ZkVVWmxXVk1PbUhTMkVpMlhzUVlNQ1JpeFJPUWM0bEEveTdL?=
 =?utf-8?B?Z3ViQzNGNmd1V09pN1gwdVVnZ3ZobWZNWXRINlo4THBoTDd5SWU1dDhHZE9M?=
 =?utf-8?B?aGRKVk0zZDJIWFJNQkE3dDdSQm50Rk54VUJtK011c0R3Z0U3dmpyNUZOdm5C?=
 =?utf-8?B?RXByZ3d3TXM3M0taeUE3ZmVRS3RWNTZQYzlMc3hyMWxZV0dDTDhFclNBQ3N4?=
 =?utf-8?B?Q3BRL1Iwa1B5Wmt6aFVhcUl6aGkrNitPdnB3NklxZVZadm5YOXQyOURaNFpS?=
 =?utf-8?B?QlV4aW0vR2MrSFlnWk5pR250WkZvcWJ2cy91Vm1KYmRIK2Y2TjdGTjFqK0Rn?=
 =?utf-8?B?T3BhU0ZoemdHeU5sYkFvK3VTcDU2ZUhpU0Q1WG1tcFQ0bm1NOStNeFMxbmRP?=
 =?utf-8?B?ZEtzWXAyQ3dHYXZvTzNKeTVOYlhkWUVGL2FZWFBocDZsVzVYSFc5Mm54Z3c1?=
 =?utf-8?B?amp0cjlkMjBvUjJGbmFtNmlTTGRJeDhTVnRIdTE2Z1ZnZDRqSWMwV0dZSmNE?=
 =?utf-8?B?Q0Vja2ErNVpYZ0ZmaklvTmFtdlhRWjNwWm5PcFkzL2xLZ1NmY2pJWVlQaEZ3?=
 =?utf-8?B?OGdWM2QwMVJDMVVuT0ZOKzNrcTkrOGdSV1JLYjBuRDJReU5jbEljOWozNHBQ?=
 =?utf-8?B?cytRaXZoOVJkYTFtRWM1M1A3bWs2LzVkeis2dHp0Y0QzcXdxNjhGcktmMXIz?=
 =?utf-8?B?YUNtTUdtUi9wdFBtSHhUWEc4VGVXNWFrQkpkeUQ0Y0pmZS9pN2dJRzByYm9P?=
 =?utf-8?B?c3AveWszZkJ1a2pPSlJ2UEloa051STFZL1VvK2kvajlDWXhYZU1SSE0xOW1i?=
 =?utf-8?B?M3ZFQTBoRmYrZXBtaDNzNDA1ckwzMFdoK01sK3hITnNkL0EzdGtpeFZUcFJs?=
 =?utf-8?B?VEhjTEdncC9scGQzNXdoTVZ2cEh0V1NIN3VuTHlSOG94NFJRY3lGTTBHemRt?=
 =?utf-8?B?N3JnL2VYU1pEQ3JsbG1RRFlNZDJtL0YxMTJZNDB5VlZPKy85Q0VTbmd6M0t6?=
 =?utf-8?B?ckhDbWFKZCs2c0hmaWs4U3BSbU1tTmpRemw0WXhJM2NoK2FxMFo0d3BKTE9w?=
 =?utf-8?B?azFsRzg1SnlvT2tKS2Zhb2pkZG96RFRBNThQMHhVVjVzM1NGQWVNK3BFbnlE?=
 =?utf-8?B?Qk0vanFNZ1JPT1ZhSDUrSDFrbDUva2pMMFdZZlFmdFBvdzJad3RFZC9JS0xL?=
 =?utf-8?B?b0k3UktXc01Nbzg5UkhUM2JBbTFBem9wUTE1TzE4bjNwL1FWaDdIMUtUdlJO?=
 =?utf-8?B?STFrYVBONmVxMTgwVGFyUk1oeGxKY2oyYXVuWHhrUy9wanJLcElkMzk5QmQv?=
 =?utf-8?B?cHYyR2tGS0xHS2YxV3liQ3lBM3RxdnJhbWxkZFUvSVFUdlBlVEljUC9IY1Zr?=
 =?utf-8?B?RDlURGptNUFvL3ZQM2FIZDQyTFAyYndmVTA3dlAvSVp4VEh5aEdwaVdPUUxO?=
 =?utf-8?B?VitTcEJLZTFEUHFhUHJhWWhOdHFGNGhmUHhXQ3p1RXlNdmNuSEUxby9EQ2Vh?=
 =?utf-8?B?bll6ak52TjdoWE45U3lQa1F6UVFqL0FFQ1Q4aVE5c1h0QmFONXdSMEJxZmNK?=
 =?utf-8?B?Rk9KQVVHSk9MQXNPZHZFWWhYWmc1a1RVNHU0TUROSTEvYW03RmpJajBhcWZT?=
 =?utf-8?B?WmV4S2UvZnAxWlJQSGtSVi82cW9MMlFhSXJPTWRDaUtZR29NOHoxL1g3RWJz?=
 =?utf-8?B?SFEzU3ZmL016OStCb2FqaEJ1TmhzNks4VXBOQ1RXTXBiUXhNcE42VWVQQ3Ux?=
 =?utf-8?B?RVR4bEp5ZWc0TUJ6TWtQeWZwckMzdDZld1ZPNzJ3YUpCeVNjWmdiSEtPTmdK?=
 =?utf-8?B?R2pHN3NhUzBDZ20yOTQvWnQ1TnhLeEJhR1VYcDF3bjgwdkdrclMwU0VuRGJE?=
 =?utf-8?B?VHFjdGh0djZXVmQ4dXBxdzZTSngwcTFER3h2WmtlQTFmZW12WGxhRzdNb1Rq?=
 =?utf-8?B?RFErYzgwNzVtRktzZ2IrcXgxWUtBZ2NoRWNvWERGcGpOWElKei9NMUZmTW5W?=
 =?utf-8?Q?MrLDiPb4U88/1JSuo6kXoywM1?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4f04cd-1e21-4632-aece-08ddffc622e9
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 02:07:41.2647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vu3K1AGMS8roBT0bLTD27OQjEjIELzy01FmNKZIh01uvhyGeUQ7I7y4UHeCdD0XGiaz+QSSZkoozP1AMT8WjGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8741


On 9/29/2025 8:36 PM, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
>
> On Mon 29 Sep 2025 at 11:15, Chuan Liu <chuan.liu@amlogic.com> wrote:
>
>> Hi Martin:
>>
>> Thanks for the detailed explanation.
>>
>>
>> On 9/29/2025 4:55 AM, Martin Blumenstingl wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> Hello,
>>>
>>> On Sun, Sep 28, 2025 at 8:41 AM Chuan Liu <chuan.liu@amlogic.com> wrote:
>>>> On 9/28/2025 2:05 PM, Chuan Liu wrote:
>>>>> Hi Jerome & Martin:
>>>>>
>>>>> Sorry for the imprecise description of the glitch-free mux earlier.
>>>>>
>>>>> Recently, while troubleshooting a CPU hang issue caused by glitches,
>>>>> I realized there was a discrepancy from our previous understanding,
>>>>> so I'd like to clarify it here.
>>> [...]
>>>> An example of the clock waveform is shown below:
>>>>
>>>>
>>>>           __    __    __    __    __    __    __    __
>>>> ori:  ↑  |__↑  |__↑  |__↑  |__↑  |__↑  |__↑  |__↑  |__↑
>>>>                      ^
>>>>                      1 * cycle original channel.
>>>>           _   _   _   _   _   _   _   _   _   _   _   _
>>>> new:  ↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑
>>>>                                          ^
>>>>                                          5 * cycles new channel.
>>>>           __    __                        _   _   _   _
>>>> out:  ↑  |__↑  |______________________↑ |_↑ |_↑ |_↑ |_↑
>>>>                 ^                        ^
>>>>                 start switching mux.     switch to new channel.
>>> Thank you for the detailed report!
>>> This is indeed problematic behavior. I guess the result is somewhat
>>> random: depending on load (power draw), silicon lottery (quality),
>>> temperature, voltage supply, ... - one may or may not see crashes
>>> caused by this.
>>
>> Yes, our glitch-free mux is designed to prevent glitches caused by
>> excessively short high or low levels in the clock output.
>>
>>
>>> Based on the previous discussion on this topic, my suggestion is to
>>> split the original patch:
>>> - one to add CLK_SET_RATE_GATE where needed (I think the meson8b.c
>>> driver already has this where needed) to actually enable the
>>> glitch-free mux behavior
>>> - another one with the CLK_OPS_PARENT_ENABLE change (meson8b.c would
>>> also need to be updated) to prevent the glitch-free mux from
>>> temporarily outputting an electrical low signal. Jerome also asked to
>>> document the behavior so we don't forget why we set this flag
>>>
>>> Both patches should get the proper "Fixes" tags.
>>> I think it would also be great if you could include the waveform
>>> example in at least the commit message as it helps understand the
>>> problem.
>>>
>>> Let's also give Jerome some time to comment before you send patches.
>>
>> A V2 version was submitted later with changes based on your suggestions.
>> Regarding the "Fixes" tag, Jerome had proposed some modifications.
>>
>> [PATCH v2 0/3] clk: Fix issues related to CLK_IGNORE_UNUSED failures and
>> amlogic glitch free mux - Chuan Liu via B4 Relay
>> <https://lore.kernel.org/all/20241111-fix_glitch_free-v2-0-0099fd9ad3e5@amlogic.com/>
>>
> The comments I've provided on this still stands.
>
>> Adding CLK_OPS_PARENT_ENABLE causes the CLK_IGNORE_UNUSED configuration
>> of it's parent clocks on the chain to become ineffective, so this patch
>> depends on fixing that issue before it can proceed.
> Unused clocks are NOT a configuration.
>
> They are by-product of the bootloader. You cannot rely on them. If
> anything depends on them, you have a(nother) problem to solve.
>
>>
>> Jerome and I have submitted patches to address the issue of
>> CLK_IGNORE_UNUSED becoming ineffective. I originally planned to wait
>> for progress on this patch and then incorporate Jerome's feedback before
>> sending the V3 version.
> I've provided a suggestion but this something happening in clock core.
> I suggest that you split this out of your series so things that need to
> go through Stephen are not mixed with Amlogic stuff.
>
> But again, you cannot rely on the state of clock just because it has
> CLK_IGNORE_UNUSED:
>
> * Nothing says it is enabled to begin with
> * Nothing says it will stay on if a consumer comes and goes
> * ... and yes, it does not survive CCF usage checking down the road.
>
> It is unreliable and it is not meant to be more than that, AFAIK


ok, I see what you mean, I will try to do that later.


>> Hi Jerome, sorry if this caused any misunderstanding on your part; I
>> will provide timely feedback moving forward.
>>
>>
>>>
>>> Best regards,
>>> Martin
> --
> Jerome

