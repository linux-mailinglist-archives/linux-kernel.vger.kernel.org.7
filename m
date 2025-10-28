Return-Path: <linux-kernel+bounces-873623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85434C1448B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1082502D27
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D4622D7A5;
	Tue, 28 Oct 2025 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="w1znli3G"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9092FFDC2;
	Tue, 28 Oct 2025 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649176; cv=fail; b=jLd8x9Ai4zqeFvAPF/pXws76gkU+KeEW4Ze/8MvP+r8ijhSsEh/u3hSnxcrMf0ATPbaKX08Ajgse3cP7RXTeSNBFMxI4jLN+KXWgUOkZIjvwhq9lkGiD57+9+7gnZh/uE9yULLXzjYCVWR1s9ydlXeBIUO0S1sqaYREInjJvy6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649176; c=relaxed/simple;
	bh=xi8RS/KIa9/Zkxfr47iEQid2m+9rABAAHskdcq1dBHc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mCWSKIfH4DYHnqmtoyLAkDgxKMCXX0oLShSwLAC1aL5EuUF3loz2xIFwvaMqiCaSfTHItJK5LKxHd6NoqkEUCpEPX4gpoHxLwBBYMTLtNFOSfJYzv8WCdXHBuWj9JqjflPgBRhkoEshmnTnosqc/b5jYQqqW99ud5mpnP5Emdlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=w1znli3G; arc=fail smtp.client-ip=52.101.53.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlH7RL+WEoKvQpbotrCar+9YNAwm1hiq6xzCJku/qMJb15gciFSK5fk84w0W4EI83W4JN2WQu1iuusBIqmiIamhBbeJLe6MRcWaJFKwNzVcDQTHn0nPM5Uz9tCY2KiNrhYyoT+D+ePx5IWRuXPjmVBDY7yeN+EAzNHp3t2yIg/83BtLh3u0ZB7Gic3ku8xP/OD4p51JvHlFIc2zNGymlpnKcgjY5NruVYXH9YUHaAK+0d6kEyZkrbZ9rqokm9jg6CJyx/3AxzqcOeEKdjO34LzkhGCnnvu5LQxn6oWErv1eLvi5TMbYmIAqfoRemTXlCGKKC6dywER8Y7ccXzHGqng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xi8RS/KIa9/Zkxfr47iEQid2m+9rABAAHskdcq1dBHc=;
 b=eFTWzaRbky+BBoxoCottg6sE9BfH1CDyvXLq6kY0NI34+FOC1qhNYBZoASgUXlWyxTGiHHy1gzqTiz5CbNHDhNu+o8Y5uVDCBO/E4hp3D97uGSocsCS0NZiFvV9jFezoHW55WNsjrvglWwKDObqwnZ7ahgyeimZ7PZrQY2aWk9drK/GHVc6ke5XrneGou/UGRASRI760qJ2sB06S7AcaAW0LBHGNNf4f+m6a2/+OJP/UGpBW1V44ZT50i/nevTk2ohplnfyyhRh+SwsrcKzPKV5j2a3ZbdovWp7BtDKXPcj+OkKd+ZHNtOw/4buxPR4yjZAbE0phH8RIC7n9hx/GDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xi8RS/KIa9/Zkxfr47iEQid2m+9rABAAHskdcq1dBHc=;
 b=w1znli3GfqwlXyXiDPPFUEMiOW9pNdUT01lnhsouwIZdpsRPLbBzIH4hXspxBX3dihzHeSXYD4sfl2FAehB8yXY2umpQE38YuM733k61deEemrvHhYLzzXcL+rgbKG7xDmt7UeiU+9BmnVzqotdoY2xW2Cwk+C1lr+DIKrgBlSBbmPWVbbj6eQ8dYcVqO0pwzbeAIiDfAOik7dwlyACOr+Vf/Axh10IDFZ45sH/ZH0+gCbw+/ht4VDs3COmJ929zIUdSRT19elsTgbxq2bQ251vufALDTrCk6Jq8+uvkI+MvpcwTnV5hfE94wD7iH4U2ikHKccl76TTm//8G3X1uGg==
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SJ0PR03MB5550.namprd03.prod.outlook.com (2603:10b6:a03:28e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 10:59:28 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Tue, 28 Oct 2025
 10:59:28 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, "Rao, Mahesh" <mahesh.rao@altera.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: firmware: Add Agilex5 SVC compatible
 string
Thread-Topic: [PATCH 1/2] dt-bindings: firmware: Add Agilex5 SVC compatible
 string
Thread-Index: AQHcR+1OlBssQ2Uelk6G52JrzCr5H7TXTGmAgAAXl4A=
Date: Tue, 28 Oct 2025 10:59:28 +0000
Message-ID: <c99c4b5e-a8f9-4de4-8997-6e7aa7e47386@altera.com>
References: <cover.1761643239.git.khairul.anuar.romli@altera.com>
 <728e10b5100e3a41d2d4595f227d26df6bdbe205.1761643239.git.khairul.anuar.romli@altera.com>
 <ec66c0b0-33c0-4036-ad33-c1faf9633e02@kernel.org>
In-Reply-To: <ec66c0b0-33c0-4036-ad33-c1faf9633e02@kernel.org>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB4927:EE_|SJ0PR03MB5550:EE_
x-ms-office365-filtering-correlation-id: cfe83cc7-322b-445a-81ce-08de161110af
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?Sk1sZXByZUNRYkc3YXJJalpMalpKTXRDZGlGN0xCSG12TTVCczYvVitGMVJr?=
 =?utf-8?B?V0VzNlJEVDJJL0d5ZlJRTExKVVhKV3lNOTNkYk1qeFY4WlRGMzlFM2ZNVzVB?=
 =?utf-8?B?dmI5RG1vWjVVZ0xTWW0ya0JDY1BRbENKRW8xREp3SzFoNWJyb1J2akc3WnRp?=
 =?utf-8?B?bG9tZVBJTGd2UnFXOEF4NUJsbXpHYVFzMkdscFcvclRFYVZpSWFzc082NW1Z?=
 =?utf-8?B?Y0ZrNStLZ0Nmd3R1ZGVXOW5tanhHZkdsK2szcWYzUVhxUVY2QTFQOUc0OTdF?=
 =?utf-8?B?Nk5NSGlncEp5eFhyTDJwb2lCMXR4UkdmTUFrUXpzcVVEbnJyRUJEdjlOYTI1?=
 =?utf-8?B?bGh5TzhqWWtVbzVTYUdCdisvVWdIQWtkbW4reklPbHdDcUxHa0c5RzZmai9G?=
 =?utf-8?B?ZTNLamxOcVE0aHk5Q0JCS01sTnFDOHcrMnphSWt3Yko5RGtrMGJLQ1JuWTBh?=
 =?utf-8?B?MFArZXEzRFpjd0N2bGJ6b2FjcnB6cFRUdzV3YnVVYVNSblpzSFFJdHBlOThv?=
 =?utf-8?B?b3BPbExYYXpCMmJoQ0c1aFcwKzZSajVOTUZVM0dDUER6bDVTNlo3L1BlUkdY?=
 =?utf-8?B?SnE3dmJ3WjFhRTgrbmVYUjRIWlJ6TE5NS005UVl2NDluZFBUNEhtSDVsci9L?=
 =?utf-8?B?RW0ycHhTWDVnb0IwOWJndzJ6OGw2YzRvS0xtcWNwanQvSi9BcE9jS2dLcTRV?=
 =?utf-8?B?VzBhSXhtdDFYZXhmZzlLbFltaUl0N2Q3VFNhWmRvdmJVZnhWbUxoeEVFSUVr?=
 =?utf-8?B?K0dOS2ZvNExVTmRnS2RmazErZVZuenh0dVVCV3llUHlKN3YxYWl5UmtKV0Qx?=
 =?utf-8?B?YUFzRm9DSEJ1MXF1Vld5MnVHT2lnUjFudENZSEVDVTR3endMZGIvZEtIRkZv?=
 =?utf-8?B?N3hvem13VkRKcGVQc3V0eEFRWEIxc1JxUTZCZHEwdG5Zc2YrMk9DdlFkZ0w3?=
 =?utf-8?B?ODgvTlFDaC9qSmliNE81SCtaUXlSMkIwSWtsRDNqS0QzLzM5WGlUNzk1VmJO?=
 =?utf-8?B?NXlIMGVJWm1iMXB1dytpRFk2dEQzMnhySzVKYUp1MmNRTXcySmtDZE5yK3F0?=
 =?utf-8?B?VW5qL2pwV3ROajRvcEl5eTZWRXNoZlIzRmtzb1R6SGRFTzdwSjIvSW5NUTcw?=
 =?utf-8?B?bEd2eGhvM3lxQ1l3T29vL25KaEhYZEVwSmQvLzNhSGhwVi82THRBblU0N3dr?=
 =?utf-8?B?aXVOWkIrKzM1bS9kWXNOaHlQeUFqbVZpdThhWDR0RU1vd0RqSEdXcytCUHU5?=
 =?utf-8?B?RFZWNkpZNG5lY3pSR0l1ZjRpNjRVb1BOT1BycUk2KzRHamdSZGYyZ0J6SUp3?=
 =?utf-8?B?V3RscGg2a1lNdUZyYkNzb1NZWXZPS3JjdnhZN1orR2dsblE1ZEY4ejVOZlJn?=
 =?utf-8?B?VFo2ZThlNGxzV2g4Z2JpZ2xSdzlkeE5MNlZkQ2hPQWt6ckJmYWMyWk1xd0NY?=
 =?utf-8?B?N01oWksyTFFiaEd3R0dGaEZOZVRWUXQzYkNNRlVJQmJxb3FDekVkaitSeTdG?=
 =?utf-8?B?bWVrWm0rYzJzdk5Fb2hmQ2dIQzEybUl1ekN3MEJla2JJU2g4dllHVUd5V1c1?=
 =?utf-8?B?L0NYZzd3U2daNEMyaUJmaXQ0akdnYXhsQXprQmVWNDR4MUViaFF0RU12SGVQ?=
 =?utf-8?B?YWdXQTI4Q014VXRSZEVmOHBtVW5RcTY3c2NjZzlBaE1kVnhpdUtpaHBXdVpX?=
 =?utf-8?B?S3c2ZXN2eW1TVGRUaGxucjlyT2x6REEwZzRpRDlTbzRzdEdpUnhOUmVBcUt5?=
 =?utf-8?B?UzJpcm80Q0VjNVdudk1kY2NtWW9UYUxjMURsSEJFUEJudEFYRDFEdTBNNkVO?=
 =?utf-8?B?K0hkT24rNlRvSGNVK2xqYjUxY0I2cnRHS3AvcElmNGxmQmxtczkxUS9TaE16?=
 =?utf-8?B?V29lR285czhMRTZRSUNRU0dpQm1mV3FaZVhUV2Z6clJaNnVEZmxrOFRYMVdz?=
 =?utf-8?B?TDZqbWlFbyttSmw3ZTRjeDVNLzhRSXBiQWNMeVcyQlMyTFp3U0pwRExUaUQ2?=
 =?utf-8?B?dURVWEoweWdXYmJsZmVRaHBwRFZ6VG9rTUZ3dHVTMlhnVHFpS3VFV3p0QUhE?=
 =?utf-8?Q?+VDbwf?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1oyTUlqUldObzhKN0lwS2czVUluZXgrVjJ3eXBaaklGWTlVZUd4YndLV1ZS?=
 =?utf-8?B?a3dUTUx3eW1YVVF2Qk8wVGJhbDA3QmM0LzhvVzU1MnNWV242SURIeXNIVzMr?=
 =?utf-8?B?aUpBVXRKY2tXTXlpV0FyY2h1YlJiR0J5NlBQOGd6SVdkTUxZSU1FQldmcC9P?=
 =?utf-8?B?bDFrVzFUa1V3MERFNGJiYUFWc011cHpzZzM5azBYRkZrSGsrUUdwY3I3Wmp4?=
 =?utf-8?B?eGR2U081cEM0cjlUNVk4WlF5eFh6NjJZbS9OTjFrYkNmNmVtNElrY29KMC95?=
 =?utf-8?B?OWsva2lNcUJxSjNTY2p6Tmt6RnV5OHVQVzhYSTE5U2FBOFBhTFF6Y3FZRTll?=
 =?utf-8?B?K0xXTm1PNVp2ZjBWUUtuTlRrb3ozRElPUHduWTkvTjdlWG5qWGVOdzBia3cx?=
 =?utf-8?B?TjdYMEZXZ096YmMweFZHRUFHbi82MEJ6aEwyYmxNejlqTERHdkJnUWwrdXd1?=
 =?utf-8?B?T1dQQVVlL2ZWOU5QdE0vWlRLYUtsSjdUamN1d25LaEtzaWxtSjJTV09abkc5?=
 =?utf-8?B?TGhacForbUVWYlhxYWhiRGxSQlBaVGRRd0VLeWRvRk5CZlNFdUttOFI1ZDly?=
 =?utf-8?B?MUNvWW1iTFJ5czEyV3R5VWNQR2c5bTZ2V3R0MzVyeEgxQ0JkMm9lRCtXNUVk?=
 =?utf-8?B?TDB0bzRzeFJBWVd5b2p0ZW1rMjRmbXFyQVVXS1IxdFhtd09hUzJKakNrcGNx?=
 =?utf-8?B?TkpNRmk3VVlhVlFLZXhZdW1CVlQ5WTZrY0owcitoSzdHWCtTZXY1RFFRcjkr?=
 =?utf-8?B?bTh6dERlSnRXa2p6cURuSU0rMGttMmd3azkyd0l0RHVkaW9YL05INGk4dFF2?=
 =?utf-8?B?NWU4QXkxVVVjWkVJcksrRWFNU1dBdDlvaTdFRXh0cW00RXNtS3IyUEtRcDd2?=
 =?utf-8?B?aWw1cFNjdU1WOXcxRUd1YVRSbHc4bTEyRk9seXdnYTdNR1pucnR6NWNYcWRV?=
 =?utf-8?B?M1lETWxldlpGMFpZN0pPTmxEUFl0bWhXZjFlVmZtL0NsUmZnQk5WeC9UZDV5?=
 =?utf-8?B?ek9JTnlXOEZISFJWQlN2aG1IWWgvSmMrT0hTcnFFc2JZa3R6UWZyQnFzOU5v?=
 =?utf-8?B?bmtHUXloWnI0RDAxY2JSeklIVG1IaWQ2aFVCYzMrNFBRbGFvTFhSbm1hVUNP?=
 =?utf-8?B?dlZHdlFKOEE2NjRLVGtsbjJsUjVlQVp4VHBJcWIwbWhQb01kTmxOS1Rrc05T?=
 =?utf-8?B?Q3dxQWJ4UXZyQUdlb2hyL0lRMzhwajI4eWpjLzFZMU9nVUZzblJOTCs1MHAz?=
 =?utf-8?B?OVFkL1dFeHp3dUJLWVdMZFpOM1g3djB6UUJrTHlOczAyczhLV2daaTJEUy92?=
 =?utf-8?B?Z2NKSE9ZM0ZpRnZZZmQwb3c1UCsyaWdjMmlxdlJIM1BVcnBFS2NuMzBwdFJQ?=
 =?utf-8?B?Tlp3bXY3bHJLempqUDZhUGJLRTI0MkNFcERXYWNjc3h0NzVkbENoZkg3OHV5?=
 =?utf-8?B?MVFjWTcva0pGeEhObUlaL2JIbGVFZG4wQkFsQ0tqci9sY2JYMFVSUkYvQWUw?=
 =?utf-8?B?TFVlNFNiNDRJbVZ5Zi92QnRsNm00MVAwL2xCZmVlVGRPQ21wY01VRnVsSnI4?=
 =?utf-8?B?a2FJbWZFMjl2Zk1uN2RabTVYR08xMHhvWmRkWXhrWjBvdW5SN3JiTkFQM3li?=
 =?utf-8?B?ZTdvaVR6K3QxNGNGZHF5ZCtwYkJ4aVZuVFVmMW4wY21lM1M1dWM1RTZtTkky?=
 =?utf-8?B?ZTZQRmE3YS91MkI5ZUtOVHRjQ0w1dllWM1hpb05Md1NsZ1ZiSTd5N0xNRktv?=
 =?utf-8?B?TEhSZXNCOXVvTStRRlFuN1lqa3hHcjY0Z3dSMnZwNE1qNWFMYjE4cjRhWXlv?=
 =?utf-8?B?ZVVVbmRvemhqRkpnbFpXRG94clNoWVRPZ1N1djY2N1grNWpwME9XbXlGT01J?=
 =?utf-8?B?anptdzd0dkZqcGRyUTRQUjZ4aDRNRHh3dWhJWFRQNW4vb1RVMUxUYUJDZ0R2?=
 =?utf-8?B?eW9kNjhCZFFZU2h3L2wxL1k2TzdyYkoveHlmbHZFTkVCSlZqc29EckdTc2lP?=
 =?utf-8?B?Mi9Qc2J6RENFbXorVG0vUWRuZ1NZM3F1V3BnMlJPNnNLRnMvSXVKdDJOYUVH?=
 =?utf-8?B?bUF0V3VhenBZczdqUHRkV1l4OWZTL091bVlaVFMrUXNhUVppRkIydEdiekFa?=
 =?utf-8?B?Z2dGK1NXdGNnNFJkNXdvOVB1SERRZ3ZSOWU5bWovUjh1Q0NiZE4veS9yc2hw?=
 =?utf-8?Q?WJO9Ovo/TDGcBwbxG3MQJjQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B9FB91E77D4C74791C78AD87F1B618E@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe83cc7-322b-445a-81ce-08de161110af
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 10:59:28.3067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uY/2aBNZw4MU7TuQO0scItzmQTSwerPWjfLqT9nTd1126OJMRB41K+LUfLhwqPvJxE5/8mx79q7K0PR6bxiFjyw3R7NKQl2GCoGVVenwPQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5550

T24gMjgvMTAvMjAyNSA1OjM1IHBtLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBbWW91
IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGtyemtAa2VybmVsLm9yZy4gTGVhcm4gd2h5IHRo
aXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlm
aWNhdGlvbiBdDQo+IA0KPiBPbiAyOC8xMC8yMDI1IDEwOjI4LCBLaGFpcnVsIEFudWFyIFJvbWxp
IHdyb3RlOg0KPj4gRW5hYmxlIHN1cHBvcnQgZm9yIHRoZSBBZ2lsZXg1IGluIFN0cmF0aXgxMCBT
b0Mgc2VydmljZSBsYXllciAoU1ZDKSBieQ0KPj4gYWRkaW5nIHRoZSBuZXcgY29tcGF0aWJsZSBz
dHJpbmcgImludGVsLGFnaWxleDUtc3ZjIiBpbiB0aGUgZGV2aWNlIHRyZWUNCj4+IGJpbmRpbmdz
Lg0KPj4NCj4+IFRoaXMgaXMgbmVlZGVkIHRvIGRpZmZlcmVudGlhdGUgQWdpbGV4NSBmcm9tIHBy
ZXZpb3VzIFNvQyBnZW5lcmF0aW9ucywgYXMNCj4+IEFnaWxleDUgdXNlcyBhIGRpZmZlcmVudCBt
ZWNoYW5pc20gZm9yIG1hcHBpbmcgcmVzZXJ2ZWQgbWVtb3J5IHJlZ2lvbnMsDQo+PiB3aGljaCBy
ZWx5IG9uIElPTU1VIHN1cHBvcnQuDQo+IA0KPiBUaGVyZSBhcmUgbm8gaW9tbXVzIGhlcmUsIHNv
IHRoaXMgZmVlbHMgaW5hY2N1cmF0ZS4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9m
DQoNCkkgd2lsbCByZW1vdmUgdGhpcyBvbiB0aGUgdjIgcmV2aXNpb24gYXMgdGhlIGlvbW11IGlz
IHBhcnQgb24gZnV0dXJlIA0KcGF0Y2ggc2VyaWVzLg0KDQpUaGFua3MNCktoYWlydWwNCg==

