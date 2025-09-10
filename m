Return-Path: <linux-kernel+bounces-810900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BE9B52143
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435433A41DC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140EC2D8DCA;
	Wed, 10 Sep 2025 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="goVf5UDb"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91087DF6C;
	Wed, 10 Sep 2025 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757533233; cv=fail; b=lem7HFWLBS6pzlSlKN6+QaCSwDO1yuRem8zSewG1Mj8prUh8IsIh/ToX6TRu+LPr57pg/guegnBX4fdmeD9ZJ2v9afpTqO29+760UGI545+CK60Jco1QdqvDiVPfptjrTTBC3zqYs9ZqI0V2S/Jae2IH87Piuk31usMPN4gFfCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757533233; c=relaxed/simple;
	bh=3eWYbMyP8g1rTH1VENDH3usL9XOK2kAhh3Q5zSbuO28=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BSU9t03XIfLYx5dRHnmOHsEQLqvHjSDQz+ablOE4e+Sl2QnzkvIVuNTFX+r75kIY3g9EZX8b2KTGLMSzlD+Y0PhzNq8l7sxbtSjgMT7zRH6ODjhfOs03XpcOwS2UJNkkjJZ8BYxlZUDoBvIF/WhMqtQ9CIIhM1nhLZa3wu8bipc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=goVf5UDb; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cqkru4y7x+sz7SNbYeVxgDXoWfVrQticL8PqTiXWKBYLeZYqL3YrCjFuDY7650I3kboQPuLblpuYLRi+CxQN3U/78VhwhRQXeElOMIQSnCcamp4XKpv9DxpDzEM9+re9q4CX7K8y22Lbgic4i2sPq8XK74uRZC9XihizAYViKai/G2kLYe86iU1ZD622QQ6KUjp0WTGoLRlSFfMGjuRgHYdPtRMptIOG9A9qg/drSrjqx/GmojZt8S8zb8QSWsgzhnRggxO//IG/3S21PnRWMJswCrq+S8Gn21xa7vN3yLJoEPmV6tyVOIQbFYkGoOM3CCu7PbnOvXAz3sTx2yk5ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfjNSJm1vsWWBbCBswwyDXVJUGm4HK9vQVw2xsUZvnU=;
 b=WGP27umGuz3Sw4mnzddsnhPNgmMeD1a2HiaM0G0akiuFk/xYw5a9U3cIXdlcBue3eYEjSQ8nGjGBjZ7uj2Bl0d0TLpGiOZAFQy4reLtaNbxnLlUwO0bTr1SPGRTwH3DegH1ykRgrA4g0/DkRd8n/4MewiQDQPwmOgmCrN/CVHVEqbA/xiokwjqN2SoF/QywJJBf0vNQYlvhMHowjywF1qjhmBhLwp5vT5fceLC/HfbHtSd92EGtmLfev8EFdpalvX+ydqTGUnpjhx91ockx99fgdeSkmaylCVJq3wf6dgTdTCW59MKwynBi/J0213wH4frkkf1WFCGt8noSwxW9RVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfjNSJm1vsWWBbCBswwyDXVJUGm4HK9vQVw2xsUZvnU=;
 b=goVf5UDbUCd/tRMAqWA5ilTJxEf4Jk+97PKBFrq+eMOYuqrMJYhV9Zq1X3najAKiZU5BERj/pRukzu6F0F0K3/Ex8zLsLGs8zTSpBN6jEAU8e5Q4ieRhEfqdJoBvN5Vlm6Lzvr7w2d2Lk39jri/b23zH5oNNDR1R+KdSnyLMIvYf5HZQP3CPPErnflt1XZQrXxQfsRNC9kQO4vWm5Ce7wZRIJh//jCeIFaMqPpser8F3ooxumKREhBfhCujQ0UqsBF9kAzio6NYdTUxBc9u0KGdC4U7MqgttDiMWD7hieXxco9PG5K6WieDBir9nR2uLDIIembD3nuQUT4tnRb9K1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by PH7PR12MB7842.namprd12.prod.outlook.com (2603:10b6:510:27a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 19:40:28 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 19:40:28 +0000
Message-ID: <e49f9e6c-69ee-4ec1-bcc8-3a60fda9a7be@nvidia.com>
Date: Wed, 10 Sep 2025 12:40:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: rbtree: add immutable cursor
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Vitaly Wool <vitaly.wool@konsulko.se>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, =?UTF-8?Q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>
References: <20250906140256.3059395-1-vitaly.wool@konsulko.se>
 <aL6YHkF96ICqqbBZ@google.com>
 <94252007-f389-41d0-b5a0-ed948225543a@kernel.org>
 <CANiq72k6OXcvjzKimfzKAAw8QPzDoVxUx_smFA8KU6gEwJ3yeQ@mail.gmail.com>
 <3f8de021-8eb3-4a7c-9adb-8244c5aa250a@nvidia.com>
 <CANiq72=ex8zJx+KZTV5eRoqkYE=PUkbG5TTvOJo5cXTtd7b1Fg@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CANiq72=ex8zJx+KZTV5eRoqkYE=PUkbG5TTvOJo5cXTtd7b1Fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::35) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|PH7PR12MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: c91961a3-030f-4b42-eed6-08ddf0a1e54b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ditnRnN5UTlWTkFOMStlVU13UDY0QWVybnQ5UExtTUdKaE5qQ0xBNWlNVnFR?=
 =?utf-8?B?RGRrSi8yR3hxcytTK0ZqOXg5Q1hHWU56YWlWekxGSjlXSDRuMjFPSmNjUE5O?=
 =?utf-8?B?dXl1cFFyclhHancybkZ1WUZxS1VnWFdidEdmYlBkWlFZQVI4bjRoZ3FaZW1k?=
 =?utf-8?B?dDUzRFBhNEd3M2kwUVJ6V1gyZ0hxZ1BWN3hyWVM3eSt5Y243U3prV2JycjZj?=
 =?utf-8?B?Y25DOStBVHNmUHNyTlZYWWJJbVpoSnVQcGMvcFJGQjVwMURVd0g0cVhDbkJZ?=
 =?utf-8?B?UjA3amJBTVpvYms0Mm1YVElyaXRvaTkwSTl4U082T2tHME8vQ3BhSm5lb0Fa?=
 =?utf-8?B?bEdDWlJzTUdwaHQyY0ZkbzdTWTlXNzZkQ1dtRGJObDN5WmtNMTQ4SmFiMEhr?=
 =?utf-8?B?WHdIZHFuazRKa29COExmbStLQlZuUFMwQnY4NDAxRG0rOUdpWjRJQXQ0ZUlU?=
 =?utf-8?B?NGs0a3ZQS2lrSG5SeEk2MDNLSWRRYmZpTkVmdjRtVldhNlVmbTJQYkxnYkdr?=
 =?utf-8?B?MzVQU3RTOFNHVGJBMEV3c3YvbzQ2Nk5UYWtRMWNSRzllRGFJNnNvRFc5Q01C?=
 =?utf-8?B?RDhHQzJUZGh5SDZKbVBFYTYyZ1VBeDdPWkt0SlNOUGVUNXhwWnl1L3FWcWFD?=
 =?utf-8?B?bHcxdWgxeGtEREhyczU5Rm1yQUFsNktmQW5OMGVFQU1udXE5L1dJN0dLUWds?=
 =?utf-8?B?TEZiTkhGQlpQeVRUSGk1bE14U0pTdDhkNUxOREJHS0pxNTA1dzJBaExuQlhp?=
 =?utf-8?B?RU9iS1dTSmxNcFFOWHFOR0s4eEo0WEVPcjJMcDdFcmR0MjM2cGdmb2ppcEcx?=
 =?utf-8?B?NDJQSDl4dm5EdWQyWGVaU09qQThhZytGam1TcWpmeWRmNk1Ma2tHRmM2M0Ur?=
 =?utf-8?B?aTBrOEJ4QnE4RjdJUG8xMWhkYTVpSXZXaXJKRWVZcm5yTnh3RldYejZuWUtR?=
 =?utf-8?B?V2tZbExBNThsYTFvZUtOQjN5TlRxRCtUbWdVeDJDZnhYNm1nV3l3L2FJclZl?=
 =?utf-8?B?NUw2T0Rncmw3WGgyWUVMdmEyaVNKSDI1QzZRYnRDS2EweWJVNXZnTGE0Uk9p?=
 =?utf-8?B?ZWQ3MUMyMG42Rk9wOXgrSnRGdUdKUXhXVXFSa01pT2lBcVVxTHpvYWtMNy9h?=
 =?utf-8?B?U1pxMFJSbXR0RlZCYTQ1M3RzcEJMdXBNR2hnYUdJd1RLbU80TzFlS1FudWVZ?=
 =?utf-8?B?YjBOamc1dFRGZ2prdkpiSkRSMWVGQTZiN3pKY0Ivc0dZbCtPTWdBZ2NzekpB?=
 =?utf-8?B?aStFQmRiZGszZExqTk5LZUVXODBTa3drSVFFTGRKOGNFT2s2SjgzM0Z3ZGtN?=
 =?utf-8?B?SW1nZ1YyN29wM1JidG80STJiSEN6WHpaVW5JQ2ZJbTZrbjY2V1Y1cGY2RkNt?=
 =?utf-8?B?T2xCdDVodiswUk1WalVLZ0FyZ2E5eW9TNm5nRHVNZFY4b0ozcFBrM0JOR0sz?=
 =?utf-8?B?dUhhQjl6b1JQUUwvZ1REZGJ6aUU5TGxESXR3SDVLTjRLWHh4TGRGbTUyMHpD?=
 =?utf-8?B?NDhiWGc4clkzS3NuOTBZVWRYUmFlNVA1NTY2amxLdXdRSTBpeTJhWEZuWkxj?=
 =?utf-8?B?YVJUZGk5YWZPbVFIV0oyWlZYQ3UwTXd1Z2U1bU1UcWdRMkw1WXhKV2dLeDht?=
 =?utf-8?B?azd4U3d0d2ViQ1NydlB1MDdOK2IwTDFpbE9PZnM1YWRYbXdWMWZkSTgza0Uw?=
 =?utf-8?B?ZGJ2YmxXdkQ1aUt5MVd3bk9FNjhibjE1OEdUYWVnQ3dtaVIwR1EyNzZUMkRI?=
 =?utf-8?B?VVRjYTE4QUlHOEdQT2k4SlRuQWpPNnJGN1lqb0dPdm41OHBBcElFVnRMN21y?=
 =?utf-8?B?UHpFVXplQzdtRFlpRWZscHFtRDZhOTgwQVJZNlY2L1dCWGh0NGlNNWFyTy8z?=
 =?utf-8?B?TGNJRmtWV1pNaHRyRUoyOTRqQzF1Q0EyNkNobmxxaWx1bVlCVS9TZEhmci9v?=
 =?utf-8?Q?QZi8fOUBK90=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bks3SS9RS1laazVhMEZZWWozRzNlWDZsNW9FcDY1aGFlOGlCMHZ4Yi9ESGVw?=
 =?utf-8?B?dDFqSlRKSW5KWjRvSGtqYVlQbW9tWFpIOURNQXZXM1NPZnVzK2ppTStUdkNp?=
 =?utf-8?B?NUFjdVJaNmEweGNROE1LelV5Z3dSVTlPWVB0akRGWlFWNTA5WG11RjlQQTZV?=
 =?utf-8?B?aTI4S01jRU84dWFEMDBLTk1OTHNvUzgrOWhtcFAvazVXVGFHQVVXTjZMZmV4?=
 =?utf-8?B?OHo5RUV4UWpENmd0SE0vaitHWW5IWStycnJBTHQxa0pxMW5MUlQrcHYwQ251?=
 =?utf-8?B?bzJoekc2cVVnZFR3RmZmZE1oVXhEVTczdjFYaTVkN1hlMWFZOXBZOWxjbXBH?=
 =?utf-8?B?eGM2UmRkR3puMllvRWk2cnNidUdFdXc2Ump5eVYxNXZja0dQcm8xYkpWNE05?=
 =?utf-8?B?QWFJbS9FV0tWSWk4b1BFY0N6NWJ4LzhZakk1Ykx2UTNaMy9jMXkzQ0MxWEtK?=
 =?utf-8?B?a0ROOGpHSUZqT1JXa3F0aXpiWktDaDZ5MTZYK0hRY3V1NUZmcFgzbVp4em1r?=
 =?utf-8?B?Y0hhZjVIZDhJN0FtOWhOMlFKQzB1eHlNU2hTRFhHclJPVlo4aDRVNGxLc0cv?=
 =?utf-8?B?WnhmamwyK1MxL3JSYjlCVmc5TUM4WDZKajV0UzdlWlZoUW5TeU5pcjRMVEZ6?=
 =?utf-8?B?Q1dkZ1M5OEtsMXEvTmJUemhSYkxQcXVKWkp5SW5aaVM5T1QwV0UxTUFBT21S?=
 =?utf-8?B?dHZVU1lRWTVtRjIzSzRoTUdZV2tGVW1LTmxJTlBzV0dBZnRMdFQ5NmhTYUtp?=
 =?utf-8?B?M3Z4b3M1Q0NYWDdudkJhVDFtVVVVNG1FSkR0SEg2TGo3MjdEVEJzUFVVbG5h?=
 =?utf-8?B?UkVTY3p3YVhQaG1RWWR5aFBGbXJ2RUN4UEJJa1hiNkh6SXZHNHZvQkgwY1Vm?=
 =?utf-8?B?MzJHaWViaDB1emE4K3h4VXBTcFQ5ZG1mbVRIRDJteHRqdmpMcDV4UU5sSnR2?=
 =?utf-8?B?Qm96cUlabWhNUUJrbWlqb0FSWlNXSWV6S2EwUUhBQ055c0tKWXgvOURwcTBH?=
 =?utf-8?B?bzM5OGxjT2hDcHBPNi9nUWFqS1Nlc0RScndlRUVNeCt0VklGYXo4NWxBbG5t?=
 =?utf-8?B?NWZ0RjV0bnl4T1JRZWpZM3YvY0VRcGttTUlrTVZRNVZUWThXamp0VkM1Q0FG?=
 =?utf-8?B?bkY5eVg4Q20wYWlvdk81MFFFYVpQL2FFcndjRHg3akFnaEZURXI4OXU2MUZp?=
 =?utf-8?B?SUdvbi82UUlRRHNlaXEzMWlKUzVtaDJER0t6eW1tMG9XN2JtanhmYzc3VnN1?=
 =?utf-8?B?ZnJpaGxaOVBHMFlJdUlPcGJ1Z1Q2RkRTd2ladExSUENlNk01YXA3ekJwS1l0?=
 =?utf-8?B?ekl4U2I5ZEN0TFVGQTJDM1FZR0llZ1MvQWdUbG92YVFnSmJ6c1JRK2FXTXp0?=
 =?utf-8?B?WldXN1Z6ZnVPWDJVTTlMNGtxaGplazJGUkN3NEFBOFNqS0tjcC9pSG9KbHJn?=
 =?utf-8?B?cHJkK2dpc2V2TCswWVFMeVdwZ0gwcWVST1BzUlIvVnJCbHBpV3g2c3JXbzM2?=
 =?utf-8?B?WFVyczJwVWwvdHFhUUtBK0VOY0E5TkxpYzFGa09lb2wrUnlwT1o4NGtyNENZ?=
 =?utf-8?B?b1FReXBOakVUSnllT2hTSjJacFVtNDFyV0FlY082bVlnQStCOFZTMmFuWUxW?=
 =?utf-8?B?SWY3R0FHTmk1enZOdWxXRHZ3N0xjT1Iya1BRbXIzWURCTlM0d2svZGlrek83?=
 =?utf-8?B?TWFTMXpBbWNsVEZzTmxMR3hmY3crcktFN2M3bzBOb0lVNUR6blBQVmdXNzl5?=
 =?utf-8?B?cHFUQStvSExHc3JKQUpwSlBmOGhPc09mZThhU1FmczBybFgvNEtvcHBrZFF1?=
 =?utf-8?B?Mm5FODRhRHlWaTNvK0RUSlkyTlVHRVFLVXJGNEc3eExINUtVaG0xY3hpWWxF?=
 =?utf-8?B?d3B1VDU0YnZraDNINlNxVnBFbDZ2YUJRa08vSmlEcHk1dmNWUGtmNldOb2sx?=
 =?utf-8?B?M2d6VzhSa1FTR1phTWpOaDhrcXJ2Nm5oT3FTVG1QVW1tdGJOUDE2UzYxd21p?=
 =?utf-8?B?dnc3YnlsK3lqVWVTVUNuTnZkMnp6MlFYdG5RSDRhaHZyMDJ2WnFvR3Ryc1Fo?=
 =?utf-8?B?S1RkTVlZdkorN1lCQ1k4Y1JtTExtOWJTcnd6VkRoUFhOYUwwZjZlRyttSnF4?=
 =?utf-8?B?WVN3RlBHY29DUHUrTU9SbWdYVllqMDdQSEZMeWxvOStVMGQ0Um80WmdNT1gw?=
 =?utf-8?B?Q1E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91961a3-030f-4b42-eed6-08ddf0a1e54b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 19:40:28.5486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45yuxK9/9P9DLhfTozZc5qPFfC/QZIAHxe6N7nbiedkaUaN90uyq7FO4wv1jwJi4yBDmK3bE74PZN/Wmn6c16A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7842

On 9/9/25 7:50 PM, Miguel Ojeda wrote:
> On Wed, Sep 10, 2025 at 3:09 AM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> Interesting. I know the topic of rustc minimum version (1.78 right now)
>> has been discussed a lot, but I'm somehow still confused about how this
>> works, on nova for example.
>>
>> The &raw feature requires rustc 1.82.0. So I thought we couldn't use
>> it. But clearly we can...right?
>>
>> So confused. Please help. :)
> 
> Please see what I have at this subpage:
> 
>      https://rust-for-linux.com/unstable-features
> 
> I hope that helps!
> 

Hi Miguel!

It leaves unanswered, the question of whether (and how) to use something
like the &raw feature, which requires Rust 1.82.0, given that the
stated min Rust version is 1.78.

Is there some sort of exception to the "min Rust version"? I haven't
figured out where that is written down.


thanks,
-- 
John Hubbard


