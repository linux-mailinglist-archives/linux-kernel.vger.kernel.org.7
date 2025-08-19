Return-Path: <linux-kernel+bounces-774792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DE2B2B78F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF9A17B6111
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6482A2376E1;
	Tue, 19 Aug 2025 03:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="ymyevHIS"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022093.outbound.protection.outlook.com [52.101.126.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331CF13FEE;
	Tue, 19 Aug 2025 03:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755574376; cv=fail; b=LbvQxjabPyFcChmjRdE+bsjYJQnRw65EuyFPuOWNW6RdyExlaE8596y2WCpfwO4ET1NEcoURzjUGE14Fz0FMctU1w8GnR5nHSjp6nh0hHM7VeB+hZ8QpA/hoswEhoCqxLd8QLRZ2PIrbrGFQtZ6Z+26IkHKCiF/0/z2VGVWN4r8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755574376; c=relaxed/simple;
	bh=CmV5XRgkdJTjJkl/e3IIlE04m5IaA0mc7t4OYv4C4tg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XEFBtJTCSHLQUsok/vTUBL4n4vUpd1+Y//xEFSwttiQ0pX3CwXetnEZxUmirSQIh2RQo1D/kNpytqimxvReh2Y6p8Pjw8qfkeQtfRj4kw43rlUoPcc8e77QxNBl3WiGRr1cSPYixoT10X2rLionjHesrsadSWOVn5xdsUq3MbeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=ymyevHIS; arc=fail smtp.client-ip=52.101.126.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oH2yDws9yiNBoc4ekyCoUx9mMfqWrtc2Gfz0Y6pexVQjt4/fqB0dQJH4ltIirdZXnw5k5DRToVAcYl0s45m41xGd7jPAUKz9XXYSF0bPNJR5plc1NVLmDyvEzl6x8fNpJkP8ObVtphfj6ATd//QcjdhMexE5LPicXUEc6RLSE1MdM44492RiXk1wNon2VzitgV6zDky120TU1PI8GHp5lqZCelw0mtyK0xrkRs9GSqnRCAeoXu29jTIeptRPjK439hPPqKWtb+Lp3txI4AjyXfYX9l1R7aB1XNudJKVhziRDUZVUsSU+Xh2KQTv6Kakdz2Lb+KfB8ntE/95MAy/6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FegF8Rm3/DS5oCAtGT5ZHuCNeH3IRH7aqBU3LdLR2PA=;
 b=DCAqI2lHhRjQVe/EL8mze0odDIpYc1PeAF5qOzcXPwzv0uphSQeDBsmdpRqQ5Zdfyqto2BBqFeVfP1Agqg7f2YRBYqWxPvpao2jLcEM1fReQhItjO3RZcJ7F4Gln/5eQiKdnuE5ygA4PftcK67Xv3y5ooPY6qx+9eI2i3TT0zeUQEjJhLoK+wYCqGKllYIJwJ6yVng6iqygDM4DZIlWDRoV8avILyiMYJEDpfm33WtlWoAbatDBnhSafGoWM+91KH6cqiYIcwPfNHoWR64lzGONvMjHheGojm3s+8NIu2JS/fpe+9NBBe+gGZsVZtKnNQZ1nbssUOds+6klwCrh3Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FegF8Rm3/DS5oCAtGT5ZHuCNeH3IRH7aqBU3LdLR2PA=;
 b=ymyevHISRTTi+l7353CXYfDrWJOLs3fAuWTTo2U1PiLXudDdW7Mz5VrLYyIZbfAi5HJvKOysLtTlCu3v1ZN5qWuuMt9T/xnLd/wtfDSuSHquQ8VKAInud4NxFbPbVE6DsVggeAK31Ebb9x63tVfV0fcKt0jkR3DZGZ+mQwGqDGzWv/vTOiww/KWSSDPf6aufRyIbOdCZwuuR2H+qagA6I+t0RYDrRYxt5sdcYkUxpPuBgvIUyEXLnHwp4mBMeKqm9D93Ev8+8+rE9uJHrS9bU+B8+Qr5SCKrJm2NHGXCYOcUhfcwmYRmVbQAznpjWvI/ueZsbgsCajvUT6l2amucbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by TYSPR03MB8445.apcprd03.prod.outlook.com (2603:1096:405:50::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 03:32:47 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca%4]) with mapi id 15.20.9009.018; Tue, 19 Aug 2025
 03:32:47 +0000
Message-ID: <673d8146-1cc6-430f-81fe-9e99896a56f5@amlogic.com>
Date: Tue, 19 Aug 2025 11:32:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] soc: amlogic: clk-measure: Add more SoCs to support
 clk-measure
To: Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250815-add-more-socs-to-support-clk_measure-v1-0-59f04ba67457@amlogic.com>
 <8e64245a-d7ce-40b7-b884-84a7234c4a3e@linaro.org>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <8e64245a-d7ce-40b7-b884-84a7234c4a3e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|TYSPR03MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 32df7299-90b2-40eb-0a64-08ddded11131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWdsWEJoN2ZUcmdJUVV4T1l6ZGtQWEpqZGsxdE1pR2Yzak1nYlBrS1l6TEI5?=
 =?utf-8?B?Uis5UE5tVkJzWFVNZ3VGaGYwNkNjOVIySnFWYXZiSjJ1RUQxRG4xMWljK2Fu?=
 =?utf-8?B?TWp2R0Fpa2VkcVBCRWp0ZnU1NHJzQ3d4RTdUMktQQ0Zldyswck9zd3ZteCtR?=
 =?utf-8?B?aURkZ2NRa0JrN2o1NjdUaWNHZmdzaUo4ZTRVL0FQR295R3R0Z09jSW9ycHFN?=
 =?utf-8?B?em51U1REaXBBWkJnbHlKT0xqaSs4enM4QzBhNWJFdUdVWGlTSFN2L3N2YlJD?=
 =?utf-8?B?SWFldG5RYy9rWjlKSlJzN2lOKzdCdk1DcFhqbDJCbjNMdzJvWVdLL3NFV2U5?=
 =?utf-8?B?TGFDajRUcDBCVDFKczA1MzFUd0dBSlpJT2FvMGYwei83YlRjdUs2WjMyTWoz?=
 =?utf-8?B?YSs1L0o0bU5WNEZXNW11ME05T1Z1RUxsT1VXejAxbjgrNU93cjA4RjNKSENx?=
 =?utf-8?B?dUQ3SWVRQ09mRW1JNUYrYk5nQkJKRzNmUzZOVGEySVNKN0l3N0RYSG5Jb3d1?=
 =?utf-8?B?QXFESjBXLy9zMnZKdUNzMFRJdkRKWkdCVEhHS0paRzc1YkZEMUQ5aE4yQUJD?=
 =?utf-8?B?YkowWWpiNnVYZVJlTE44V1NDSmdhY252QktNYmc3TkoxeUtKZzNnZU5zUXFs?=
 =?utf-8?B?ZzBZZ3VZOVNCeWR1dkVqTnN1aFNKRXBOUzlJMjR1UDJGTnYvRDczSU5VbWlL?=
 =?utf-8?B?UmI4cGZKWXdCL2NTdjlCQVlpK2hiMHFPUVBORWY0NDBrWXYvazIxaUVNYXVD?=
 =?utf-8?B?MEx0cm1GV0NROERRWlFjNDBUOFJjVlFqTEs2VFJyR1EzSVNqWnpXeGM4RzJo?=
 =?utf-8?B?UVliR1M5S0VvTHZ2VzNOWG01T3ZnLyszTHBublZISDhWdXA3bXZySXFkYmZN?=
 =?utf-8?B?QjQ4YXFqM0xKM1JtWUc2dWYyWTBiSjZoeE1YSGh5Q0dYUzdWNTQrNmkvZzBF?=
 =?utf-8?B?UXM5cmJDWFdXTDRIQ1VRVlo4WURJMzBIUFJ3NkFJMUpIYzVyeGszdFl0cm5H?=
 =?utf-8?B?S0ozTDZlZEl2STlJSHhvZ2pKL29VRFd4QzQyaktDbSt2R1dPcU5vbkN0ZU1J?=
 =?utf-8?B?aEJnekJhczRUVHViRndVVlA0YUZnYTc3cTAvZTRTdEhJT29PNHlHdVVBSGVm?=
 =?utf-8?B?bDFETGlWL3NJRVl5UGFmRUNoYkdhd0VsdkxLSGdZZ3pIZXVMVGtQcmRsWWNY?=
 =?utf-8?B?Qm44SGM4bmlkL3g4K1dkdDJMVG1HTFM5THZ1UXR6aWk2RlViK210czVXcEY5?=
 =?utf-8?B?VVVXWDdnT0RDS1gwaFU0a1dBL3FuODZSVzVIeUl6VXFITWN4SXA1djNaMWt5?=
 =?utf-8?B?RUFsZUphS0Y5bEwrWll5bTNHVTcvaDdiUGJ3Z1l5ZUZlNnJ6WDFVSEh6NXM4?=
 =?utf-8?B?c1hvbTlxTVc5bHFuZlV0cjBTeTRhMk41U01UdGN1VUVsVnFEMXRSS2ZGL2Jt?=
 =?utf-8?B?N3F1ZFFEOFAweW9kamdWQlJ4Y2lmYVhvQWJVSDQrTGc0cUJMSmRiUXRsMC9m?=
 =?utf-8?B?bmx6c0NvdFZHWVQ5WEwwQjcrVWxDZllDWlFxdUMvdjdJWklUd3U1a1BNT1Zo?=
 =?utf-8?B?Z2RpejNMSFdxeGNaWmhHL3VHVzk0a1p0Q3k1bDlPUnZCRml2K2grK1AxS1dm?=
 =?utf-8?B?Ujk5bVRnQmpaZ1JndjA2dDUzOWFjUGZpbTlCdlBwZ3BRdkVPZk05cVkrRmxC?=
 =?utf-8?B?U1BZQ1Q5MFZuVXRrb3FJT3pJS1puR3NRenpJSjUxUjA0S2pZRldOYmZmbnJM?=
 =?utf-8?B?a3cyY3YyTVlsVW53QllTNzMzeGNYdEFuTlVTMGVBTkhpTXJGZnIyb0RYdFU0?=
 =?utf-8?B?a1YwaEk2eGVrUkU3WGNQeVZGRWlUdDdwakQwaWpSdnM3U2NYMG92VVhONlpT?=
 =?utf-8?B?UVkxN2JBcXRQMndEVXlkdmdFRnloTjV5Z0d1WitBU3dvMUVwbEJ0dGdHSVIw?=
 =?utf-8?Q?0dOUtXYzPtQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWh2TVYwUXZadC9QaUVkZDBIRUduMmtmaFNDMmlJdytna1Jpblc4WmpBRzFt?=
 =?utf-8?B?akhRVUhlamh5MEtaeU9VaGZKZDhRSEhRYmVBMUhZUkQyb2haZmlDY3hxQzM5?=
 =?utf-8?B?b1hTVXREbFdobUhsS1owaFRzbjZydE5ENnpKQXZMNjZBUldLM2ZaTlB3UHdT?=
 =?utf-8?B?QU1lWFJOWU9SZ1oySUt5S1ZyVnJwVVhPcldhZ08xaXdaMmQ5ejhzYkd1ay9F?=
 =?utf-8?B?akRJakdmK1FtblNoWnFhSkVUQ3dnOC8rMDFZQlJ2aE5RWU1BU05YdjVhTGR2?=
 =?utf-8?B?b09nTUtZN2lXaVlKQXN0ayt1aHB2c05jMzdZTkYyMGdVNnU1bUozWjRvL3hn?=
 =?utf-8?B?TW56T2hpckJ0VXVYYlNNVVdzK2RNQUpyWXQxcDRiNVdneWdDY3JXOXF5NHdw?=
 =?utf-8?B?bEpSWjgxaTlzbWNqMXBoR0VBTm9JRWpjazhuNEhHektlWG10OFdRRXdnS0Ry?=
 =?utf-8?B?VHpqYkYwSE14M1hLTWZZNlQxVnE2SERxcWdBRDdGMUlYdStLdDFVWkV3NE5N?=
 =?utf-8?B?eEpDQzR2aCsyVWpkVlNBejFTVUNQSTVCcUg3aHkwZWc5bm1BbnBmVWVRM1E2?=
 =?utf-8?B?enRSTXQzOHlZUXpSVVV4OHlJR0gzcWdUWkZBQ0JGY29telZJTVRjSWs2R1Fr?=
 =?utf-8?B?MlVMb1N2RUx0QVVEQXpLYUF2NEVHUnlzQVlHVzNpdnAvNXMzNzNrOGVzY2Nm?=
 =?utf-8?B?NVFYRTBPK01XV0NkTHJjZm4relFNaVdEQS92T25Jb1VyZmsyY0ZIb0NvaTdK?=
 =?utf-8?B?cEFYOTBRN3FhRm1pVmpPTW4rUmNkY0VtS3FIL0JPQXFTTnV1YXZrYmNZMXFp?=
 =?utf-8?B?eWNiQy9jMFd2WXQ4RXpwUk9JTUFzbTNCQWhPR2pZSEpuVnpzSWNOYWd2UTZ0?=
 =?utf-8?B?bjJENVNCZ1lMTmFSRVJkQ3lxNi9zSzVFTzljZUZReGdKeTBWS3hrMFVmOU9C?=
 =?utf-8?B?VHFPMmwzTWR4K0hmdkEzRGNCRWtkcmJPL2kzaVBFVzlnYkcrRTVETjRybDBw?=
 =?utf-8?B?MFJCQ3JaSXd2L254bFlmR2ZlRnJXbW84bWl0QWQ2SGUyeGxUeU1OQTRyN1F2?=
 =?utf-8?B?b0pQNmVoUGthOU1FcTliOUhpY2pkZ1dURjJKSmcycFpkT1FZdkZESld1SkxT?=
 =?utf-8?B?R1dlL3lWcGJQa2NrVVFYODVLcHZqbGxPU2RpdGFiQlA0L0REZk1PbVl2cFZn?=
 =?utf-8?B?OEs0SUVJSjNEMG9PUTRtbmZWSi9uM0pmOE81VFJPZUhoRTVPcWhGdWx2eXRR?=
 =?utf-8?B?WHdnaUt5WGpUOTdMVUJodTlyM0FzZjF2azdSWk5QMFBlMk5jUzBhTzBDcUdP?=
 =?utf-8?B?aXZkditxWlNuVHAvR1FPRHVvWktyQVczL1hnU1RlbmZZYXFJMUpGZ0hTdVcx?=
 =?utf-8?B?SkNXcUJWR3EvTGYyUUk2Ni95RmtOMUhmZERKT25OaldzYU1veGtKd1piNWFE?=
 =?utf-8?B?WXltUEI1NHFqYTE2ZEIrNldPSkdQZEk4NVJnOW8xTmlnMTloZGdYUCtjdzlX?=
 =?utf-8?B?UzVpazJxTEgrZHI3bXh4UFdpalJnTVU0TTRJdTZraklWKzBvOTFkWkF6OGpz?=
 =?utf-8?B?Q3NKczFwRmZBbHkvQ0xFT1JOa3ZjUkp6U3BXSkdCOUZValROT1ZRYWo2VWZo?=
 =?utf-8?B?YXR4dXd5dzZzS2hPWHdlcTZVS0M3cXpCWEtqZHdPeFVEUTFIOFJKcUJ4WER0?=
 =?utf-8?B?MXFVcTlSbUdlb0hUNXR1dmJwWmxOMERYQkNiUDdKWHV2L0pxTUt6VFpKdXI2?=
 =?utf-8?B?TjNRL1BkRXlYajVCRjQyMmFCbWZOamZBTW5oTnQzZy9YWjRKaGFiYzNRMGhj?=
 =?utf-8?B?SmZaUmF1YW5CeTdPUmpzU2c4QWd4Z1lkU3AzNXpqeDNvV1RJVUt3RFkvd0Ro?=
 =?utf-8?B?WTI3MVZmNTBkRTJhUG1KTTBZUXVjakUvL1pTMDkxS3p1aUtWT1N5MUpnN292?=
 =?utf-8?B?N3BScloxR3hKRW8rOXlESlpDelpENThlWEp0QVBVQWVHZzdLTDhBYmxCcGlK?=
 =?utf-8?B?WUM3VjZZMWI0aFVzekp5Z3E1R3I4U2ZkdmVWQnBrd241cm4xMjFNdVpSaHBO?=
 =?utf-8?B?S05hWEFUZjJXUUh2MzZsa256b20zaDlCbFRLMTI1bWxaNnZQWFVDRTZtQlNJ?=
 =?utf-8?Q?OnVGS4yX8njLmMyO5UmVtnPvo?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32df7299-90b2-40eb-0a64-08ddded11131
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 03:32:47.6001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: coKCUH3epPKeLZ5j3rjHV+7kZBypt+uCa24lxWPx+CPqR1EO4x9R5LYVf4n6kDE1haKH4o8roHE15QKpCo287w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8445

Hi Neil:

     Thanks for review. Here I'll briefly outline the background for 
this patch series:

The motivation for moving the data to DTS is primarily to reduce memory
consumption. Currently, this issue is easily overlooked since we have only
submitted support for a small number of chips upstream. However, as more 
SoCs
adopt clk-measure, this problem will become increasingly significant (we've
already encountered it frequently in our internal branches).

Moving the data to DT can also make our clk-measure driver more 'common'
by encapsulating chip-specific hardware variations in the DT rather than
requiring frequent driver modifications. This approach should help reduce
long-term maintenance costs to some extent?

Admittedly, defining this data in DT may appear less organized at first 
glance,
this approach effectively addresses the dilemma we're currently facing. 
If you
have better suggestions, we're happy to adapt. However, the current 
approach is
critical for memory-sensitive scenarios, and maintaining it otherwise 
has proven
quite challenging for us.


On 8/18/2025 4:01 PM, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
>
> Hi,
>
> On 15/08/2025 10:37, Chuan Liu via B4 Relay wrote:
>> As support for clk-measure expands across more SoCs, the current
>> approach of defining all SoC-specific clk-measure table data in the
>> driver .c file results in progressively larger compiled images,
>> resulting in memory wastage.
>>
>> Move SoC-specific clk-measure tables to DTS definitions and extend
>> support for additional SoCs (A4, A5, S7, S7D and S6).
>
> This breaks ABI and most importantly the clk measure feature on new 
> kernel
> and old DTs. So instead keep it as-is for current platforms and try to
> add this for new platforms.
>
> But the fact you need clkmsr-reg-v2 means you at least need to add a 
> generic
> compatible for v2 register map and drop this property.
>
> Overall, I'm not a great fan of this, it moves data to DT and duplicates
> the strings in _all_ board DTs, which is worse in fine.


If you agree with this approach, I can refine it based on your feedback by:
1. Adding a new compatible property: "amlogic,clk-measure-v2".
2. Implementing a struct platform_driver meson_msr_driver_v2 for the newly
supported SoCs.

I may not have fully grasped your intent, please correct me if I've
misinterpreted anything. Thank you!


>
> Neil
>
>>
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> ---
>> Chuan Liu (13):
>>        dt-bindings: soc: amlogic: Add clk-measure related properties
>>        soc: amlogic: clk-measure: Remove the msr_data from clk-measure
>>        ARM: dts: amlogic: add clk-measure IDs and names for meson SoC 
>> family
>>        arm64: dts: amlogic: add clk-measure IDs and names for Amlogic 
>> SoCs
>>        dt-bindings: soc: amlogic: Unify the compatible property for 
>> clk-measure
>>        soc: amlogic: clk-measure: Unify the compatible property
>>        ARM: dts: amlogic: Unify the compatible property for clk-measure
>>        arm64: dts: amlogic: Unify the compatible property for 
>> clk-measure
>>        arm64: dts: amlogic: A4: Add clk-measure controller node
>>        arm64: dts: amlogic: A5: Add clk-measure controller node
>>        arm64: dts: amlogic: S7: Add clk-measure controller node
>>        arm64: dts: amlogic: S7D: Add clk-measure controller node
>>        arm64: dts: amlogic: S6: Add clk-measure controller node
>>
>>   .../soc/amlogic/amlogic,meson-gx-clk-measure.yaml  |  66 +-
>>   arch/arm/boot/dts/amlogic/meson8.dtsi              |  94 ++-
>>   arch/arm/boot/dts/amlogic/meson8b.dtsi             |  94 ++-
>>   arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        | 212 +++++
>>   arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        | 202 +++++
>>   arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi        | 275 +++++-
>>   arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi        | 312 +++++++
>>   arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi        | 253 ++++++
>>   arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi       | 243 ++++++
>>   arch/arm64/boot/dts/amlogic/meson-axg.dtsi         | 144 +++-
>>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi  |   2 +-
>>   arch/arm64/boot/dts/amlogic/meson-g12a.dtsi        | 229 +++++
>>   arch/arm64/boot/dts/amlogic/meson-gx.dtsi          | 136 ++-
>>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi          | 301 ++++++-
>>   arch/arm64/boot/dts/amlogic/meson-sm1.dtsi         | 255 +++++-
>>   drivers/soc/amlogic/meson-clk-measure.c            | 930 
>> ++-------------------
>>   16 files changed, 2877 insertions(+), 871 deletions(-)
>> ---
>> base-commit: e5624eb63c452efa753759e74eb27fe132eb577c
>> change-id: 20250731-add-more-socs-to-support-clk_measure-b2a43590d5aa
>>
>> Best regards,
>

