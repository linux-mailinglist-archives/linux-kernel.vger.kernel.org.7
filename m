Return-Path: <linux-kernel+bounces-735247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBD9B08CC0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A408E3A1FDD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210402BD00C;
	Thu, 17 Jul 2025 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="G3p40X7O"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011043.outbound.protection.outlook.com [40.107.130.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3981329ACF3;
	Thu, 17 Jul 2025 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752754890; cv=fail; b=tGmi6Pox/Rt6iOmnbO1BqtRHklAaQv9nUerPHTY1dAO1jNJ+/ogbiRd8umokRZSxfZTJnRn9yqM2g9ghMrtT0DUmA+xU8nAn6Le6m/9ih8IaCbrlKb1XLtvUUwXkLNdSXU+haGL8aPgf9XsK6Ovdbuu2D2AunovR7Sx1wCAcKEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752754890; c=relaxed/simple;
	bh=hfEVasN29BKWoP19OuR3uFQbyH7MPFuKGxjsAahMhHI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jUO+ZpDXe73+Xu6BinBmNB/q1RFmujksQOoVOPKQooePkiKcgUZF2NoMURylDHQPnaDcN572rq73cUXrZ/OL/x5NTELGGZtanpBfpKA4xlhsK5HYg5q/p/1M0YL2XhtFk6HgeIVUAk9EOtBvQVqvArcHxfGS9SPqA+eDq5ynT5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=G3p40X7O; arc=fail smtp.client-ip=40.107.130.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0v6SnB2Owf8FbcRDJp1xrpXQBHIv+Cv4c+GRUgsptDqKRZFcQh+bYhhGgil5JeZ1zGNL4EqkbWS6cG/y3O+9veRdAKjNtUKGa6pHEuFeJJQrG8nFBgY36v7aa28XtqldTFHT1xYRwhHrUq0Qrf8XS+d/6bgFchFfpE66MqTNoR+VZl9QMvVh6IbqUphbJm4tFmySZHhAEP5OQWfpHnf4CU9L1vrsTCiu85LkryuTN4K4r3bnUN2jbTLamXL9bcDWm2lkXAoFv3q6U91ICuY7KnpnllaUKwTffvqQm+NT7wzG0x2UXIn7l65i8NhKKeGxpuuJnOarJj28qMFPb1VRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7ewydCkaWbY70NTSgS2/SowvSDW7glWGukpgLQ/s18=;
 b=xq3uc6DcFE9q6aksm6WaVaz16/SANX0wJoG3Xd0fkbfDvpiBUwIAqyYNQWrkCmB+6CRWqh15a+rw4PXszQ9qmtveMjDuRkKVjFaGOFn4FnYUfr8fYvpF3utg8oV6HJKSTKExKiJMt5cbGDZtWfKRhP7UQKrxtDpKkkga9OCXGZtBywQJEoZyB/lK0PSK80iEE7wEBlNy+jnCycGGp7qIy0emhwlUEGi+ANHg9jay8ddPH/UVLth7Cl5l7xapd5NAlo1jwBg0mAhPcg7UFcb8Rn7DNp5o2lRDz7Tyxry9Y62nmYczA2IMHvf3ZcUDdfkai5itjX/wZ2vcuwXPIUCxVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7ewydCkaWbY70NTSgS2/SowvSDW7glWGukpgLQ/s18=;
 b=G3p40X7OOHg5hKg/CvKXO/VE+3f5YTk36oashr/zXo2jit2g8t1LHkf2RUb0cS9PRj1KDllhLVzIac8IA/LUamI/iLCXuuVSi6rryB3XBioo0HHdFuqVyuhw9AdK/hQq6afs6bNWEFvIYtuFbRPZdRDN78MOwYgr3e9qsUXLoeA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA2PR04MB10347.eurprd04.prod.outlook.com (2603:10a6:102:424::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 12:21:23 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 12:21:23 +0000
Message-ID: <470dc543-9619-419c-9ea3-6671f4d52326@cherry.de>
Date: Thu, 17 Jul 2025 14:21:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: add RK3588 DP carrier from
 Theobroma Systems
To: Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, damon.ding@rock-chips.com,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20250716185027.2762175-1-heiko@sntech.de>
 <20250716185027.2762175-3-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250716185027.2762175-3-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0185.eurprd09.prod.outlook.com
 (2603:10a6:800:120::39) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA2PR04MB10347:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bdf07d6-bbbf-4dc5-0d50-08ddc52c719f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnQrTHNmZnh5VExMQ2pDMUMvNVRsYU93MmVVTVpvc3l6V3VzVW1hSzhKMmhq?=
 =?utf-8?B?UXRheExjNTd2cXBPazNlQmZwdGNjQ3dDVGg4RHd2Wk9NT2xJZ2tDdDMyU1JB?=
 =?utf-8?B?RW5UTVZVc3JsZEtWaVFPTG9JNDFBV3VRa2RxUjNVQVJJOTAyNVRRYjdubjd2?=
 =?utf-8?B?dXg3aGlRaHFBd1JycUkzMEFHekNkMEhWS1E2WGEzVWpwZGdHMmZYN013RTNN?=
 =?utf-8?B?MTR5VHVtaFRUem4xUEZCamg3b01hK2VyNnRxcDdoWFJXWWNhOHB4b3NVQ096?=
 =?utf-8?B?ZEZhcGljcjhHTmdvREJVbTh0eWpMeEtCWmROVmNiM2VPeDJBeWptWFVNdkRY?=
 =?utf-8?B?cmhXVEtTMFJkM0Nza2JEdkNNV01adkZ0R3g0WklQNlhkbUpzTUNyTll6N0kr?=
 =?utf-8?B?QXZXNGV3eXFCQmZpUU0vR2pzTk00a3prZ3MxM3FnYUVqblk5WWpUTmxsZDNy?=
 =?utf-8?B?cTVKNEN2Q29QVGVzcnFtTlFEamZnNy9kbGJPM25GM3pROUJiak9Kbkx0Y2VO?=
 =?utf-8?B?R0JvZzlIc3F6bDZSQkFUQ2Z0UHphM28vK2lqTW5yWlE0VlROVTFEdkVWZmZn?=
 =?utf-8?B?U3JlODA2SkJpSlJQM3QxSWQ0YlB0d3VuVWV5YzhhdG1sMURYbW1OVUd4T3cz?=
 =?utf-8?B?Rmh5ZVF0SFovVnltdHpYS0lhdnk1OUJYTjB5ZjVKT2Fqc1FOQ013Rm8yYWpj?=
 =?utf-8?B?U1ZrOFFPMmxLVWFJNmtKS0RMZ2lqSXZFZndhTmdRZGZQR2hkZWlYRmlrVjFm?=
 =?utf-8?B?SjQ3azN6Vk8xa2VGMXU5QUduSTREa3k2eEpYK0cwYk9pdHVrVTlzdEtLOEhQ?=
 =?utf-8?B?OEdtOHhHMXFEY21sRExwbklRbS9lZXZRZG5uTW1GNXp1Uk9NU0FTZUdpMWVk?=
 =?utf-8?B?MGtNVG5FOEhyY0duMGp3UzUzdUZyb3BIaVNWNDIwbFcxU2preXZCeURNY3hS?=
 =?utf-8?B?RnBEMG5tWklBclhVVjY3NEU4QmdiVmpDaGFYTGpuUUVEMGNZbUZ6SXkzWXR5?=
 =?utf-8?B?UWFEdS80aXh3a1Q2em1yVDJVdFhCMHB1bnVPaFdSNlNCdks1QUNDVXY4Y2hC?=
 =?utf-8?B?amtUdXNsOUpQRFhoMWZ0SkJvMk1XN3A4d290eU9KQWMyZGNsZU43V05nOVVI?=
 =?utf-8?B?V0Q3ZG14MTBiNEpqZVVLektzZU5PazNVTHQ5TGc1bmhSWlMzVjcrQjYrNFdB?=
 =?utf-8?B?RG9rcHk1Y1l0SWlKWEpKY2dXUW4zU1h6bnlIa210R2kwY2s5SmtUTlJZNndZ?=
 =?utf-8?B?Q0t1K2krRzdZN012V1BZUE92V0tIR2oza1dPTG5pWEtpWEZwNDB3eHh6dHY3?=
 =?utf-8?B?dTF5Y2g0bmJHWFVOaTljdE9SbEVhWjNwMGRJOHpRbFJiSjBaZWFmSC85YUpr?=
 =?utf-8?B?WS9ZQndsTi9odG03K1V6WkN5Z1dhTzFqb3owZ1E2NjV0SzVWNEduQzRoRGFV?=
 =?utf-8?B?MllORE13T0hLd21XbGVzaXJaMmt1ajhQK0JKS1BXODMwRzI1Ty90WmFRVjZw?=
 =?utf-8?B?eUc4cnE1UHNoK1BYazJvajYxT2lSUXBYOHVzYysvOW5odERMdUlxUjIxTWdB?=
 =?utf-8?B?dm1RbW9DSG1hQ3BuU21xTTdNRHVRNFA1WXJCL3BXVnpJWEZQVmFQV0UzY3lZ?=
 =?utf-8?B?L3B4bnJDcGxmbW91Y2NzVWZQUm1aaXpYRVpLVm9kVVYyeUh6U1hmaXdBTUYx?=
 =?utf-8?B?Z2t3cTNGR1FKdEZTUEdMTWxQM3VGUThKckpRdmFoMGRtNEk1UmVEWnhpSjlT?=
 =?utf-8?B?S3h2cjBVY3lqQ2dHRUNxeVNnYW95VjFQUXVNVFJvREpDWmpLRlFYV0RQcUpE?=
 =?utf-8?B?cVpFcUJhZTlrTVVWOGg4NThsdGRkSDhnOFU4c0VMa0pSTXE5T3E1RDlUa05x?=
 =?utf-8?B?L3lhZUF4cmliQkN4dmFXbllvUnU3eVdlTEx2SEdZTi9GNEhVZUxOSERxZW9l?=
 =?utf-8?Q?qw/zo4au9Bs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2RCVmtaVGJ5QjRKTFJJb25hb2ZVS2hmbmw4ZjVVUmdMQVV4NTJSNENRcFBl?=
 =?utf-8?B?L291TnB5TmNQZnFaUXpTVXAwYkFuMWNuNHZrTE9MWWFLQi92YVVjQ0M2dlZ5?=
 =?utf-8?B?R3FML0QxRitzNkwvSVVCbFRKRFB4MGxkbHR0SXpUZWFZYnhET3hNZ2N4MG9J?=
 =?utf-8?B?SXVEQXVvQUZOd2VCaHQrNnh3L2ZnanFzYkJBVnlOWElyT3gvcDF2RW9yeEZV?=
 =?utf-8?B?aHJLbVJMSVVTTTJIZThSam9CSHNqenppRVlMYzd4T3cxUCtaeFVtR3MvZUlz?=
 =?utf-8?B?MnloUDJzRlFSWllYQ3hyVGJlZ1Q5REZkM2ZNaEliaGRkRk9lQjlmbWJnM2tr?=
 =?utf-8?B?Ty9rQmx3dHFSOERDUm5YMFhRWTZyWDdvUkxHNDAvenZVeDQzS3ZMNVpQYzAz?=
 =?utf-8?B?WVd0eXZaMXBtNklUaE1pRWtDYS82NERnNUZTOGpLTmtzQXBKR3Q0TFdUWk9B?=
 =?utf-8?B?VENvMkZIcEE0TlA0U0pQU0FKU2NlM3UzaUh5eGx6MVRtQnB3cDZqSzZWbEpB?=
 =?utf-8?B?RlBZOWFxd0JrTHBnaS81Z3lrbUtpV2N4VWhwMXlWclV6L2FzVm0vZkQ1TGNJ?=
 =?utf-8?B?VEVIUWF6b3VVRW1yMlN6QUVDT1AxMEQyTm5Mb0xkaXNNeDV4TWFBeHA5VFBT?=
 =?utf-8?B?V2Fjd080d0w5Vkp2YlB5Qm5TOXRNT2RIYkFoVUNPYUVOQUVaZkFicWJpVjNT?=
 =?utf-8?B?d3FqWkh1N3I4U2VtT2ZSejhoNGl3SFJpOGhuMXpNODEyT3VCeGZQSnJrbXQ0?=
 =?utf-8?B?ajBsZzdPbU52bEp1NmIza3hCMmlOYXFFV1IzRHhGVVh6b1NpYnFKcXM5dFFP?=
 =?utf-8?B?UVVZY2JGL2g0Q0FsTGdaalFHckcwOGRrWEVVTlBoOUtzNGpaR0VBTnNtamt4?=
 =?utf-8?B?TFJUcmk5M293dG1sQWZnVnlya09Jc0gyN05tQkkwZ2dqZVZMS2VzV1dPNDJi?=
 =?utf-8?B?QmxOTGN5SnFLYVE1aktoSU5CRXY1SzNSYkNKNDBGUUxxRmRONTREUWhySm9i?=
 =?utf-8?B?Ym9ZWURnbE12VEhEOXE0bWIydXRQWWJ1RU1HU2hPRm1pWThadDZEd3BGQXpG?=
 =?utf-8?B?b243bzNsTXVhL1dpa2ZRaGtjTHBPcm9wUjRiazk0Tkt1QTBzcmlzK1J4dHRo?=
 =?utf-8?B?MkNPYjRqWmsvRnRSRkc0NFdka1FlRDkxTnZIblZGNjg3TjZYQkI2OUFKcjY4?=
 =?utf-8?B?V3l6QVF5RmhmVENOSnhrK1VyN0lRREFtT2R3WkQyVnFKUng1NXhrMnlKK0ly?=
 =?utf-8?B?SkhPb0Vkd0I3UWQ1Y2Zoa3JScW9XMXA5bklPN000NEF6OVFhMHdONjNSZTNN?=
 =?utf-8?B?a0VVdjJsdWt5ejNPYUFYdFJmMjZDd2xSRVYzVWJ1ZDJWdWlZekJaQjNKb3FJ?=
 =?utf-8?B?U2luZyt0Ym9sR080bm9DbHo5QUtvMjFORjA4ZDI5bnhVb2Mzb2ZrRklCbTV5?=
 =?utf-8?B?NDNsRUM5RnY5K1BQU2ZVZCtUdVY0U1BVKzluVXRERmgvWnQ3YWRFOVNWbk41?=
 =?utf-8?B?WEQ2cTdGd2x2Q3JEOGY5czlVeng2UzlEQnNtVEFXK2pLNFc3NkE1dnZCOTEw?=
 =?utf-8?B?ZklLQm5IbG9xMWh3WkMzeWlTWnYxb3dEaVNkMmh5M0ZxS1NTZytwOFN4cjVQ?=
 =?utf-8?B?YVFzVzlKeHVuMWcyNHdzVjRpM0pEL3VMRUpsNGNkMlVKOHNENGg5cTJkN2JX?=
 =?utf-8?B?NVJNSW9iTFI3YXV3QkNaUlVMdDBOTFZlekNjeHRscS9SbTdqMS9FNzNUSkVw?=
 =?utf-8?B?SDRsbWpLSzczbXlLaWN5NWI5dTJEYU93SGE4VnNpeU1DNTUzZElXelIvSkNw?=
 =?utf-8?B?QlRjS09qK013TmtMUlA0Si9aK1dxSnhhd1U0cGFmWmpqT1FaaUpwVTVlQlJR?=
 =?utf-8?B?WU8rQmQxWWx0TTdvdlUxSklRU3M3WjJuaEJ2WU1ab0pxbFJMcldsUWRJZUc2?=
 =?utf-8?B?dG04NHNta1Q4dnBQT1BKSGk0WXZ2MnBDU0NPZngvdlVXVDlxenNpSkNlUDFr?=
 =?utf-8?B?K2RVcElVOWp6QU1XNUFvWGNsWEdjbExhaUlKdW5WenIybURmSS9ka3hPR3ls?=
 =?utf-8?B?ejVjOEN3LzhOOS9DV3NUc2xoRzFITG5GMlBVRk9JTlJmQ2RwQ3ltU1BpMHh6?=
 =?utf-8?B?bHEyWkFRV09uRVRnSDVVUmtXQ3VXWWYrOGFiUDJoZy82ZVNmTjNyVk1YQXJj?=
 =?utf-8?B?YXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bdf07d6-bbbf-4dc5-0d50-08ddc52c719f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 12:21:23.4001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MHtSICGH1Csf2Pr/K1Am2r4QXYN/dFUlEpQIJ5seChsYRBnfnEmbFv6MB2LV789siz/PSrPuMiGxesJ1pFi5FMPzh9Z4dEXbHg5WiLwQjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10347

Hi Heiko,

On 7/16/25 8:50 PM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The DisplayPort carrier is a very simple baseboard only providing serial,
> ethernet and a displayport output.
> 
> But its main functionality is that it routes the Analogix eDP controller
> to this DisplayPort output, which allows to test that controller simply
> by hooking it up to a suitable monitor.
> 
> The Analogix-DP controller supports eDP 1.3 and DP 1.2, so can drive
> both eDP displays as well as full DP monitors. It does not support DP+
> so passive DP-to-HDMI adapters won't work.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>   arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>   .../rk3588-tiger-displayport-carrier.dts      | 118 ++++++++++++++++++
>   2 files changed, 119 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-tiger-displayport-carrier.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 7946bec10670..0c915679fde6 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -178,6 +178,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-srns.dtbo
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-plus.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou-video-demo.dtbo
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-displayport-carrier.dtb

Please sort this alphabetically.

>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-toybrick-x0.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-turing-rk1.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-coolpi-4b.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger-displayport-carrier.dts b/arch/arm64/boot/dts/rockchip/rk3588-tiger-displayport-carrier.dts
> new file mode 100644
> index 000000000000..5bd79877194a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger-displayport-carrier.dts
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2024 Cherry Embedded Solutions GmbH
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/soc/rockchip,vop2.h>
> +#include "rk3588-tiger.dtsi"
> +
> +/ {
> +	model = "Theobroma Systems RK3588-Q7 SoM on Tiger Displayport Carrier v1";
> +	compatible = "tsd,rk3588-tiger-displayport-carrier", "tsd,rk3588-tiger", "rockchip,rk3588";
> +

Please add ethernet0 to /aliases?

> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +	};
> +
> +	dp-connector {
> +		compatible = "dp-connector";
> +		dp-pwr-supply = <&vcc3v3_baseboard>;
> +		label = "dp0";
> +		type = "full-size";

Please order alphabetically the two properties above.

> +
> +		/* Q7_DP_HPD# but Q7_HDMI_HPD# could be used too */
> +		hpd-gpios = <&gpio4 RK_PB5 GPIO_ACTIVE_LOW>;
> +		pinctrl-0 = <&edp0_hpd_l>;
> +		pinctrl-names = "default";
> +
> +		port {
> +			dp_con_in: endpoint {
> +				remote-endpoint = <&edp0_out_con>;
> +			};
> +		};
> +	};
> +
> +	vcc3v3_baseboard: regulator-vcc3v3-baseboard {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_baseboard";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc5v0_baseboard>;
> +	};
> +
> +	vcc5v0_baseboard: regulator-vcc5v0-baseboard {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_baseboard";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +};
> +
> +&edp0 {
> +	/*
> +	 * Note that this board doesn't respect Q7 standard as Q7 has
> +	 * lane 2 of HDMI on the same pin as lane 0 of DP and lane 0 of HDMI
> +	 * on lane 2 of DP but this board uses HDMI lane numbering instead of
> +	 * DP lane numbering for its DP lanes.
> +	 *
> +	 * It should be possible to match Q7 standard if required by requesting
> +	 * the eDPTX controller to swap lanes with:
> +	 *
> +	 * data-lanes = <2 1 0 3>;

I don't think that's true currently?

The driver only seems to be supporting swapping the lanes, c.f. 
analogix_dp_lane_swap() which routes it to either 0 1 2 3 or 3 2 1 0 but 
no mix like the one we would need. Also, this function is never called 
with anything but "do not swap" argument. So we would need to fix the 
driver to support that.

Also, this is the kind of information we should have in Tiger DTSI and 
not some "random" baseboard DTS which will actually not make use of it. 
We should have data-lanes = <2 1 0 3>; in Tiger DTSI actually but 
considering 1) the driver doesn't support that, 2) we don't have HW to 
validate it works; I guess we'll just leave it at that.

> +	 */
> +

Aren't we missing the data-lanes property here? I don't see a default 
and I would assume we should be providing one?

Documentation/devicetree/bindings/media/video-interfaces.yaml specifies 
it either starts at 0 or 1, depending if there's a clock lane or not. As 
far as I could tell, DP has 4 data lanes and the AUX lane as well, but 
nothing clock-specific so I assume starting at 0 would be correct?

On a side note, is the audio output on eDP TX controller already 
supported like on HDMI? If so, we should add the edp0-sound node like in 
our downstream fork. But looking at the driver, I don't think we 
implement any dp_audio_* callbacks from drm_bridge_funcs which I assume 
would be the way to implement that.

Cheers,
Quentin

