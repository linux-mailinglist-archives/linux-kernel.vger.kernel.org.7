Return-Path: <linux-kernel+bounces-847801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA91CBCBC33
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77EC34E800C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 06:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D1F23A995;
	Fri, 10 Oct 2025 06:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="QkwT8EV/"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022138.outbound.protection.outlook.com [52.101.126.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D06E846F;
	Fri, 10 Oct 2025 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760076965; cv=fail; b=lyAEXt5+SWbngo/QhXkMnuEKj1Gvn90Mdnma3HCLAJWYJp2dDKGOuJ3UC0wUQ4WM71Oj72DLvTiipEUXvdmZ05aJimEnIZiRQ9CgLkWFSR93/HLKK8uXZBFZzIm46aYRCqZ0hyOcSBr556fhUfupSy3DxEpGqmP+KOJz/VFNsqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760076965; c=relaxed/simple;
	bh=9dQivKikC88iIJgEdfgQRz+26lDka7F2LWccz/wiA8o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ih5qrPUZM8J/5ALD+9QOXKfbPo4VB6sy61Ejvz+oVXHjUVr5ZrXDHZvG0b6knyi+QSrVzqgzGHpb6dRIcYCYZoE6OreShC9i2IVLA7lre+fv+aCJDd6O7+eXzAnxlYOk8eDwgWmXRQin0XrENKqTWVBGlvX0JK7KwJod0b7c0vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=QkwT8EV/; arc=fail smtp.client-ip=52.101.126.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRr6YGXJij5rtHDK5Vx4cu6pWoyBBaGwsZbLiRhgPOkBK6+ZqjzaqH+3Sy8fjfOWctHLLEyDPsoGs0bqP3kNaQb+1rM7BZKFL+vFhwdPRCfOGEF4/wJbIzlturv4D2eTo8sqWXM8pXJQttekOmE4+3RGyPpKpltDi4y8Q6GGDcZFA+MvETbRMKaf4G2x0HX9Xc+XeMmIeM5LUoYEPdgwKxrucmIl26UD8NE9Fsbc5/nkDbzG3ayebrIf6sYTBhxj8J8b7zSRnoyAPIqB9lmUJ5F/szG95S+j7kFC7pzMIrx1d2KvTkR9IacUSiY1a2ipPQpqqXwcmtnwacOtIV2t/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0tEEn6hNUD6h+dyUFAchOmokesqzgR6hxejIbJiTFk=;
 b=L1BxDsPQ2+IpDTI0H0+KaxpWGfOLyKsJgtPs1akg4/flMC1zbevCTT2Ss/JHKKqnmEmMQRUhGrsVZqNeYvIVNRdLFQFUoLamlafqFgVzA7fE/RkEv82TSKM/+F6pVakhEM2buahdz9Y885begNoFijX/OsU0w2rcHWrSswiYqc1j03MN36W/DLIh2aD/L59hJsFj4CSqUAAOB9AlvY9s8YNgsPdJ0XKRHvsLNrRXKk127BH6zlpnUn2aifALvDy3xOqsM3srwcAwABuMZ3UmdT6or7inOunCX4GkfsADS0mNhRLPVu5orivBFpXGTz/Z3wUTgwjYdMuH+jTKzzXB0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0tEEn6hNUD6h+dyUFAchOmokesqzgR6hxejIbJiTFk=;
 b=QkwT8EV/7IoVTjLU/F2lE1VahfqSl/B+hW0d/bP0/CIhmLRV0KJEs+jQW7bggazQqkVBuwNaB63HgbEQ/nRuZD5J0goYCbxFo0UceazlLTuOnpUZ+107JDOA3MD00FrJE/WdcUIZpYGpvHkCM0RVeaNEb3e4VpjO1aODBvMrEX55mnWLyWa105BBHyONr8xzzcIp9daZ0kIDuAmdMJuK40RzP1+fYwjRVw51LhNmuYztJwxJdOREmgWA6uZAakAXhHU5wXeaxXSHir7CQKQwSWUq+wCWvUWZjvhG2M8t8F3C7RmSAXW7TnG4lGJNaBZUq86u5ernwLbWRKZzgQCW3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by SEZPR03MB7701.apcprd03.prod.outlook.com (2603:1096:101:128::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 06:15:58 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e%5]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 06:15:58 +0000
Message-ID: <362b6daf-6b2c-4385-88b3-f2dda38f6612@amlogic.com>
Date: Fri, 10 Oct 2025 14:15:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] clk: amlogic: Add PLLs and peripheral clocks for A4
 and A5 SoCs
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Jerome Brunet <jbrunet@baylibre.com>
Cc: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
References: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
 <1jv7kz3w1p.fsf@starbuckisacylon.baylibre.com>
 <b8105d25-112c-4406-9f3a-8fbbd0754b26@amlogic.com>
 <1jh5w84iat.fsf@starbuckisacylon.baylibre.com>
 <7a5d3f57-4c0e-483c-9d6f-9556583180a7@amlogic.com>
 <c922430f-3efb-4c2a-8b10-b2f150db827f@kernel.org>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <c922430f-3efb-4c2a-8b10-b2f150db827f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:4:7c::27) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|SEZPR03MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: c3503f87-38cc-4e3f-dc72-08de07c47a40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M01CaDR3b2VrNWtnOHhDQWZmWXVaVFJCNXg4WGxtR2hUUEo3Y3ZBM2lZTXpX?=
 =?utf-8?B?ZklJbHZmZ1p1am5JdTJpSkdYeWkrYjdXOXNOMDZGN0VYMXl5L3BHcTNDZVh0?=
 =?utf-8?B?YVk3dmVvZDRzSHRVUlB0UTZMeHJPT3JBbmFqSm1RY1l3bVJrc0hUTHhBWUhG?=
 =?utf-8?B?V3RXa0VJUU1rYm5adTdIMFhkejdYUXJMTnhnQmFPU3RjMm5oeTdRd3VvZFVk?=
 =?utf-8?B?TjQ2OXAwRElFNFlJNDZBMWNCZXR1eHhsRUVacHE1K2NNbW5IZEtlQ2NTeW9w?=
 =?utf-8?B?dndZVUZnV3htZnljZlZST0w4cTdDMWRPbnQ3ei81c0pNa1g5cXFtajFWZ1hW?=
 =?utf-8?B?azlzVU9idVA3VmVESkNPUFQvU3ZqRGVSQVZ6K2J3TkJsWWpVc0RLWVgvZWRu?=
 =?utf-8?B?cHVjVjZiRWZib3BMSTBRT2pZT1R0VCtRcktZcmRFV0NrZEIrVC9PV2VlaUJN?=
 =?utf-8?B?MUZwb1drMC9jWTdIOUZXb2EweTRaZWJaUmlnQUFzR2t1bFNHcDcwMWxWSEpK?=
 =?utf-8?B?TllST3RJaFRFa2lGZDBxb0hVNWoweGNualU5RmNCSjBEV1NML253Y2Z2TVo1?=
 =?utf-8?B?U2hhQ3E2LzNVdkltZHB2K21WbDhxbWFvUU5zS1J3OTlsZklLeG93M3FBMXVp?=
 =?utf-8?B?bFNJcjVEQ1JSMU1SZUR3N1ZWRzg2RnNyNjErQXVoNGRKd0VOMWNwT1lOdlhW?=
 =?utf-8?B?L2NWdW9vVWpwMkdZbVJpTlZCaFJad0VKQ0RpSUdxZjhTbEdNRDd2eUdoMnhl?=
 =?utf-8?B?dUREaGRQd2JyM1ZKTlgwTjdOM0diVmJWU3YwVWQ1V2JxRThlb2pkTVRoUzVs?=
 =?utf-8?B?OER4cjJGMW9NQ0dydFBoais0YVNkMStuT041NnF6WkhEbnVMcThlaWhJbkVl?=
 =?utf-8?B?eGQrSXpOam9tQjVxNkgrOWtUMXZ1WnMwcUlXZ04vemF6aU9TTXdWcTVpUXBH?=
 =?utf-8?B?MlJnODArcTJidUdIb2lrelpwNkh3UmFSTlNEN0ZMejROc2hZVDMyU1RyOWhh?=
 =?utf-8?B?dlQ3bFN5WWhhWTVrVkdvSURKNEZFN1lHeHZUVXBJaFFYVVJQRyswMGlXd0tE?=
 =?utf-8?B?NkdRaTZuYkdZdFVob1NoUFhRd3pqdmJLSm1vMjNmbWdaNmRWQktJVmxRNFlu?=
 =?utf-8?B?a3ZhR0ZsSEEzUjFmTVo5cEdmbTNiek9ZRnJPZ3g5TXNpeldHKytSNE5BV1lu?=
 =?utf-8?B?NVVJRnVvemM5MHVSQkJNZVRVMk9EV08yUjloMnVmdnBIT0wwenhValI3cnFu?=
 =?utf-8?B?QzdsUTVEWkpCekt3dit5aEk5akV3c0xrSkM2ZlJ6em5nSUZJV1NqVTZBWHAw?=
 =?utf-8?B?aWFhQzBlMXFOVXRmR0txM0Ryc203VENXdE9HQnZ5N1MxT2Y3OXFNTEpxeWla?=
 =?utf-8?B?V254NlRiUTdUeDVqZ0g4UXNJSm5DSXFydWVLWW5ldHdtN3BxK3lwUDE1Q0Yz?=
 =?utf-8?B?THdmY000VUpPMTZCcGNxOHNkYmZXNHVRNDNFeGxTQmUvcUZrYlNrTXN1TTNV?=
 =?utf-8?B?VXljUkFkalBzRHJSZmd0STYzNVM3enVrUzRhRGJlODF2TVk5WldDL1lPODd1?=
 =?utf-8?B?MCtZcnAzZzhxY29DbWkyR1pFcnR5b2VNVUttSUlBNDd4T0JtV3dCUkJXTDdP?=
 =?utf-8?B?bElUUFdNNE4zT0tSVlhUeDR1ZW10N1RRU2d4cldxSkFXQjQxYStTbGo3RFlY?=
 =?utf-8?B?cEVLVzRLeWwrMDBCbnR3RFNwK0dZYVNhZklmb0xGUnc1OXh1c0ZMbEtIdGlj?=
 =?utf-8?B?YlF2VXZWVHZveVYxSmV0RStvU0pLL3ZXZGIweHpaSUlGaUkxWUlIQ1hOV2tZ?=
 =?utf-8?B?SzBtbnp5RXJoLzBYS2pERG1JRmREc1JlVytIOGxJS0NTQ3JWNXNZYWRtaE9k?=
 =?utf-8?B?dEJNT2xSaWk4Vkp5anE5MmlQK1lJTXAxNWRWd1FHYWxKU1h0ckQ1RS9xNURG?=
 =?utf-8?B?K0hEYW9wcWJ5TzZHRU85ODRlclE5SVB2MzI5cVh4Yi9la1JPaDA3aGpzbTVo?=
 =?utf-8?B?M3BaWjFxVStnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STZXRzU2anBKZWFWWVJqSU1FQUxwQTRhMmF2R1ExQy9walZVRTJ2N3hNTkJj?=
 =?utf-8?B?dmM0emhBemtmQU94VmdNMFlObS9NWU1PNTl2MUFoRURicDQ3ME1EVlh0R3hH?=
 =?utf-8?B?cXRGNnA5NEd0ME9VeFhqbWpkQkI0YUp2ZDBYNHZ0S0tMWnl4OUFOSCt0czlk?=
 =?utf-8?B?Z2xJZlJwMnM4c0kzb2ppTEpNOFdlR2pSUmtnZHl4N1BYMm1WellYeFFEVFZH?=
 =?utf-8?B?cDAwaUlTWDVsd1lGMDFtWE9MdlhXVHJ6TndkWDV5V3N5aDMzNkpGZGlabXJZ?=
 =?utf-8?B?ZU1Qd29NeURnU0o2T2x4Mkswb3ZJOURGaVNFZ2NEQURuYnBoUmJoV2R6bFpF?=
 =?utf-8?B?Z3JvUGJldUJFcW9XTEdmc1JCRjZDUnBXYmhuMXNxNTRUSGYwNm9HWTFLN2pX?=
 =?utf-8?B?Z0sxRE0xYU9ZbS8vaFhySzIyc01qa0ZVaFBEYVBycnVyekRFYzUyZE1UcDFm?=
 =?utf-8?B?by9ZM3JQZVpDRG55UUlwcFFFNFYxVjBBMFFydm9IUXVoYzc2VnJ3clpEMzFU?=
 =?utf-8?B?VFQrUXVHNEdlSTJNYnhwREM4WkcwUy8vTDQrVnY2M2hoWm5FYjAzTzhGV3FD?=
 =?utf-8?B?Q0FLV29kckN5UjFrbzRVdVpGMy9wVTN2UHEwaE9KbGkwcHhxOE5PYkdNVWtt?=
 =?utf-8?B?Q1MzZjJ2Y1F4VGRNNkhQSUkyaUJvRTdoWERlOTQvcXRXdjkrRnhtRFJuVTBT?=
 =?utf-8?B?TWpFNXVlWGhIVzlPNEE1RS9FYTRDcDZKN2ovMFFmdS9OY3pqdG5WNTY5RkNZ?=
 =?utf-8?B?N1U3QjczWUF3RU0wc0xNKzJHV3hMdEFZMW1LUFBEQmN1N3RJK0tLRWQrdEhu?=
 =?utf-8?B?aU1VN3o3R241S2tWRHkyUHlVOVFRUVdmU3J0UXlLUzFEOTF3QzJ4RExwak5B?=
 =?utf-8?B?RjIzcVQ5L0tnQjNML2dqV3c5b1BtUG5XSGVNSHdOc0R6bEcwdnZkS0VPS2Uz?=
 =?utf-8?B?dlVYaGVORXYxWUlyeWx4MGlJZFBaYklrRlY2UW5hSzZjTEVpUnkzR2FUTCs4?=
 =?utf-8?B?aVgxSHBDR3NEbGU3bThNcWYxZ3pBeGg2TERGVm1nY3ordXRhdElDMFVVa09Z?=
 =?utf-8?B?QlBvQ0J2SFBOcGRpaHprNlpHQVdxbTJpSTFNb2NZb1p0aTRXMis2SUhPNm9h?=
 =?utf-8?B?bmJGSTZtcTY5M291QXAwbzBCbGFRNnJYNVVLMkE4aVRqaGlKUnRwREJBbXRK?=
 =?utf-8?B?NlVCMG1qUnI1NmlMVW40bk5iaGVzR2g2RWIwdGR6ck1XMkIxcnVUbVhncWtY?=
 =?utf-8?B?cElaYVpVVUxwNTlKUlZrUm9jYXNkMWQ4bUMrMUtUSEw3cEhyNlBlSDJpR014?=
 =?utf-8?B?Vm82enJhWEo3N2x0RnlmY3QvVnFyTm5yYVBqdnNETnZ4RkFMMUVjMjA1bUlk?=
 =?utf-8?B?SVNQRCtlWTJMbklZS2VmY1pVWUZ1RmhXc3hraVRwdG0wMW1pUmlZMWFQRjhY?=
 =?utf-8?B?aXdBazArOW8rTUpkK2FIczBlUHdzc2RmYkdSa0wrSTlVeGdNL29TeDUrWUp4?=
 =?utf-8?B?dFhncFRaR2E0aDBzUHkxZ0RWamt3L0Z6bHBBZXNzNHBkdGgzNmlwZFNWa3Zu?=
 =?utf-8?B?UE8rSFFhNnNwYzBUa2Y3TlZWUlNvb2ZxNDc3NlY0aVFSUkcwZ3RTckkxSnB2?=
 =?utf-8?B?WEZVTlpOMVVCMjBoeWpkSys5YTFCOENrTDNaZStjSzhaMWl0QVMwTUFsR08z?=
 =?utf-8?B?TmtmSTQxMm5Wb3NzZ1NGKzJyTjNscXh3WU9YUGgzSEUvdWpWR2xrMGw3K0Jq?=
 =?utf-8?B?M1BMc1BzVndVVnhaUzdJN1BBRSttZGlSbHFKdk5wUThITXVDamZvZ3l3ZnRj?=
 =?utf-8?B?T0lzOHcxb0JONU1vU3pXREJ5R1dyM2NOa1VKZHdsRnI5N3B6aUtHMVQxWE0x?=
 =?utf-8?B?blFOa2I5NmhJc05ZK0tBK0hoTUNYSDk4cklYZ043d21maDZNbUVsQlNkVllk?=
 =?utf-8?B?K0ZyOUoycGx5Y2ZEeitqQ3NSNDdxZU9CSzF1cUV1VmFEZHNqbVhOWmhyWG0y?=
 =?utf-8?B?NC9Wd1FPSHN5V1ljQVh3WUI5aUYvM0trWW10QW94QTR2ekd5REMvLzBSOEU4?=
 =?utf-8?B?a3d0ZWxRWFloeFlmNmF6eGY0Z1ZacTBmMmhQbFZTSDZ5b3o5UnJOOHhzY2s2?=
 =?utf-8?Q?qOBx6fJA0nQWHi81Ctk06M9PZ?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3503f87-38cc-4e3f-dc72-08de07c47a40
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 06:15:58.0923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tc8Zu0bTkp6Iok40Yf0uKxe8cfVMGiCbgZ7tIVfWVS4U5CksP/YrrGx4yKyDoo3GOHh4y/TsGMrnhvHOr8zrPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7701

Hi Krzysztof,

Sorry for bothering you unintentionally. I haven't fully understood
some of the details yet, I'll do my best to work through them.

Thanks again for your reminder.

On 10/10/2025 10:42 AM, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 10/10/2025 04:38, Chuan Liu wrote:
>> Hi Jerome,
>>
>>
>> On 10/9/2025 3:59 PM, Jerome Brunet wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On Thu 09 Oct 2025 at 11:09, Chuan Liu <chuan.liu@amlogic.com> wrote:
>>>
>>>> Hi Jerome,
>>>>
>>>>       Thanks for your review, because the national day holidays did not
>>>> timely feedback.
>>>>
>>>>
>>>> On 10/1/2025 3:45 PM, Jerome Brunet wrote:
>>>>> [ EXTERNAL EMAIL ]
>>>>>
>>>>> On Tue 30 Sep 2025 at 17:37, Chuan Liu via B4 Relay
>>>>> <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>>>>>
>>>>>> This patch series includes changes related to the PLL and peripheral
>>>>>> clocks for both the A4 and A5 SoCs.
>>>>>>
>>>>>> The patches for A5 were previously submitted up to V3 by Xianwei.
>>>>>> https://lore.kernel.org/all/20250103-a5-clk-v3-0-a207ce83b9e9@amlogic.com/
>>>>>> After friendly coordination, I’ve taken over and continued the
>>>>>> submission as part of this series. The dt-bindings patch retains Rob's
>>>>>> original "Reviewed-by" tag, and I hope this hasn’t caused any
>>>>>> additional confusion.
>>>>> ... and yet you restart the versioning of the series making it harder
>>>>> for people to follow that
>>>>
>>>> Sorry for the inconvenience caused. The main changes compared to the
>>>> previous version by Xianwei are in the driver part.
>>>>
>>>> The dt-bindings part only has minor modifications in [PATCH 14/19].
>>>>
>>>> The driver part has relatively larger changes because it needs to be
>>>> based on the code base you previously submitted.
>>> I'm not seeing a justification for the mess introduced and I'm not
>>> looking for one to be honest
>>
>>
>> Previously, I provided a basic version of the A5 clock driver to
>> Xianwei, and he helped improve it before submitting it.
>>
>> Xianwei has been responsible for upstreaming many of our modules.
>> Since clock drivers require significant effort, I’m sharing the
>> workload by submitting some of the clock-related patches.
>>
>> The three versions previously submitted by Xianwei mainly focused on
>> improving the dt-bindings based on Rob’s feedback. The driver part
>> remained unchanged.
>>
>> The driver part in my current patch series has undergone relatively
>> large modifications to adapt to the latest code base, so comparing it
>> to the previous versions may not be very meaningful.
>>
>> If it's more appropriate for the A5 clock-related patches to continue
>> evolving based on Xianwei's earlier v3 series, please feel free to
>> point it out. I will continue to assist Xianwei in completing the
>> submission of the remaining A5 clock patches.
>>
>>
>>>>>> Both A4 and A5 belong to the Audio series. Judging by their names, one
>>>>>> might assume that A5 is an upgrade to A4, but in fact, A5 was released
>>>>>> a year earlier than A4.
>>>>>>
>>>>>> Since there are differences in the PLLs and peripheral clocks between
>>>>>> the A4 and A5 SoCs (especially the PLL), and taking into account factors
>>>>>> such as memory footprint and maintainability, this series does not
>>>>>> attempt to merge the two into a shared driver as was done for
>>>>>> G12A/G12B/SM1.
>>>>> ... and we end up with 19 patches series while it could be splitted into
>>>>> manageable series, for each controller of each SoC
>>>>
>>>> I'm not sure if I understood you correctly.
>>>>
>>>> Do you mean that I should split this series of 19 patches into multiple
>>>> patch series and send them separately? For example:
>>>> serie 1: A4 SCMI clock controller (dt-bindings)
>>>> serie 2: A4 PLL clock controller (dt-bindings, driver, dts)
>>>> serie 3: A4 peripherals clock controller (dt-bindings, driver, dts)
>>>> ... A5 similarly?
>>> Things that do not actually depends on each other or which are not
>>> merged through the same tree should not be sent together. There is
>>> nothing new here. Same basic reminders on each submission.
>>
>>
>> Sorry, but I'm still not quite sure if I understood you correctly.
>>
>> This series of 19 patches mainly falls into three major categories:
>> * Optimize PLL driver
>> * PLLs and peripherals for A4
>> * PLLs and peripherals for A5
>>
>> Are you suggesting that the PLL driver part should be sent as a
>> separate patch series, while the A4 and A5 parts should still follow
>> the previous A5/C3-style submission?
>>
> 
> Please read submitting patches, soc maintainer profile and DT submitting
> patches documents. You ask us to repeat same knowledge multiple times.
> It's waste of our time, so we have documented it for your convenience.
> 
> Best regards,
> Krzysztof


