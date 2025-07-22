Return-Path: <linux-kernel+bounces-740378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797A2B0D377
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D29216E5FC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8829A2C15B3;
	Tue, 22 Jul 2025 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5RQyLxvR"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A58128CF41;
	Tue, 22 Jul 2025 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169595; cv=fail; b=XjWvVPRQlNLWp+DFmj7dMI5F6Uf5Okwm8FosAuATYd8n8oMXaORUBS3behOzqDHJugRkVYjpZ1svZl/CeOtEXk9kXqX+wgQbFDXXcvQjWtwnylfG45HspzIeoHIJuJc7ZixN8Q22AD2Om1yQykgfwSXJ9KskGvDzcPYZ9CvHGBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169595; c=relaxed/simple;
	bh=JqNycejrQjg0iGiVO9XSKyhOrvR3JDab55zekPtCSDY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AmAOdpBdvJzTrt6pXhbChP86yWiw7dk12JkgZKiGF8qqehFdRIOVvd3+7o/JJWORH8LiZY4B3YCmmFmu09WV7PxnzVMqQ9mPyb/4m0ZNUamKBSy9lhXpruW9t/Yickw4lOrK2yD0KHWVqFgxWH6gFBDMrQGivcCmp5z/916ptlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5RQyLxvR; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zC/5XhR2IzaJtPzU+8LiOStoPwHk3hja2XrFRDBoDxfN52KEKnCuyZjEPMMb7jmyS1Bl+TbwZsWAMzUFCavE7X7rrES3uIYGLVjQMv4QmeqYGh0o3nasORrU5T2f7sPnTtwWOrzdkMFqCjXUr2W9ve35L8jo5BQ245VHYhDXUVTPxz5zOOD4Vo9hYeKnAyemVslSusGhhu2UOpeB3Ct+EamTC9Xu11FhITNh0W3yMjggY2JTTbzFvWtFEb8pxqWYQpjuBCVWNEJZrNgnZVPpvG9bbuMoTVdFJ6ZLuyqVGubOK3rv0xxLvPBQb4edrrLNcEEmXc4lNqLopsX19gqc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ytsc/8eBvEPCLIj4TX5aZAMpQWsoPhqpF4OtvJQuHSg=;
 b=CubawjdqT1bCZJ7mK7Pg8Wm4yjhORfbLUb3LT4uhPSh8rKwlSJa7rrEfjdvr2kpr9yiocvfFQ1YuvG05go4TFvPBHtVKgIgaIEBPZbzFfptXRyIa8qQQRcIwm+I/qg96n7fohfJIsYyM40etrLK2IpyjnbaijyfV2ITJzq0h3gZ7T9AcBxu7nmjk8zH6ABbN/tdUS+k6klR8/b4Tc4Na7+nsWnhslhuFSC2CoUvoRzAf5fFqWEWEHy6S05RcevKGivwjy0DQaVLyLSz+fYXbglQh9c7XjpwnoDwB6Q43QvjnMjJGpetiVx9el6niVgYsyfLkwQ/nau0FrI7dicAijg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ytsc/8eBvEPCLIj4TX5aZAMpQWsoPhqpF4OtvJQuHSg=;
 b=5RQyLxvR+PVFFpXBVweGzEGbTVtMa5DxBOyB3OGpBqRHSp5ijWU0DvpYusX2keHtTvnybkj5HsfcxbVUU3rlvjPViI5SR1fsmipfgX+bQez9Skrzb/jYb1sxNxUszra8LF2aOfXnD5dSxxtgSFsWF2N9rd/r6QWmQhYB253WfnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 07:33:09 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 07:33:09 +0000
Message-ID: <da1c19c7-60af-4841-9554-7758324a58bf@amd.com>
Date: Tue, 22 Jul 2025 09:32:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Add Xilinx INTC
 binding
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>
References: <6ddaf6f1e3748cdeda2e2e32ee69343a06c60dcb.1753166980.git.michal.simek@amd.com>
 <b30f00c3-9062-4d19-8088-5fc5e951eb5d@kernel.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <b30f00c3-9062-4d19-8088-5fc5e951eb5d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0412.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::20) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: cd0d0d82-c2d9-476c-a909-08ddc8f20163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkE5RVR2dFpWOENsMk1kSDhtRC9GTU5TZ1llOUdJdE5aV2pEeFRoelFIYkcy?=
 =?utf-8?B?SWVKelFQcUU5dFZYYlJHQlY0OUlWelVIdVpNem4wWEF5eFEwTWhLcnlobzZa?=
 =?utf-8?B?alpjYUF0b3JUaWFVdXhCOXVkaUtpZnk3YWU5a2hIb2FtblJnWDRzdkxuemdD?=
 =?utf-8?B?WjYyWG12UE5uWnljRm1YRVNGdkY2R0d5ekIzV01nLzhUSFBsTitpYWpDcXBw?=
 =?utf-8?B?eUl1KzdDbXd6N2lxN1IrblMwS0xTQisyWmMwZGF0Q0lyTitZUzVwNDhxTWMy?=
 =?utf-8?B?NFZlcHF6bDdURlZmaUtPYmdCNnNKYlRxRTQxR04zVDBuM3dyR2djcVF1YWRx?=
 =?utf-8?B?WUdYREEwZ0RMczgxSGtHNUJZMW52dko2RmFnbldIc09pNHlqOWV1QVJrTTlO?=
 =?utf-8?B?OFlzRm1MMnB5QWRtUktHblF2YWR3OTNtbnJYSTVFS245UnllU2g1SmZHb0tF?=
 =?utf-8?B?UHcvb3hLa0R2bmZJa3B6NExpbGtOTkZqRFV6RUVscnBmeDZ6UFM2WktGYXgy?=
 =?utf-8?B?UkpqZWNoSkxSMFFpbUZXMFlsVktLYUNiYVF0NndETlpxWDMxa2NrTFZMdUtG?=
 =?utf-8?B?SCtkT01LVDVydVcyaWp2cXlKYi9CQS9uZlE0dWRybk85bTRQSWdEUWRJZkZt?=
 =?utf-8?B?U1hjQ0ZFSjJIdE5VSUxLSUdwOEdZdDdiVTdJQmVweWlFRzBYWmxUelJnTEFN?=
 =?utf-8?B?Qy96N3FONVR6dS9MU2RncElneHpsWkZwallUQjlYNFpXQ1gvNHhoU1MrNVpI?=
 =?utf-8?B?cHMrTm9ETHUrQXNhendyTzFpdllKSnhWRFBZZDZWbm1HMGNGQnVCRzBmVm9X?=
 =?utf-8?B?VWpJbUZtL2hwOWtzUjJvWGZSWU1MYzg3YVp0R29PR3g4Y0VicXh2dXlRQWkw?=
 =?utf-8?B?WEFBdUFPZHAyNGRKSVl4dVlSU1l1R3g2U00yd1d2UHMyNDhJYzlzTWlxUFhu?=
 =?utf-8?B?RnRNbG83NG1iU29nOHc3SmllNitsNUIwckVmbmJ4eTV4NHdxeW1VUlRaVkM0?=
 =?utf-8?B?QUNXNjlVT2tza21xKzZWZWdGMjRWd3ZPRTU3ZkFuanQxbzkvd0FkUU1GTENR?=
 =?utf-8?B?N3RQZVAyVlltSHFoWnoyK3ZYM3lsN1RvTTlqN1g5c254V2VnWFJuWHZ1dnpw?=
 =?utf-8?B?WTNweTQ5NWJhRVJMMm10YXVMTzBJWFlWbWJoQ2xMY21ldktCa1VHcXZnWndj?=
 =?utf-8?B?RElNbU05ZDhhTkRmd1RwYW5FaHdLZ0NYNkE2RjI4RENNeklJYWtac3JrcU9P?=
 =?utf-8?B?Q3FBMUtlSFNtM2g2eTFlZk92cEszRUhlaWd5V1JIVXAwMEJ4WXFuKzloWllS?=
 =?utf-8?B?YmNPRGNzYlBReUZPU09INGNyRlo2S2ZFRUd5eFo2cDlPSm1aUW9iWWJxSFNi?=
 =?utf-8?B?RFhPaHJiYzNDTmhPT2kxZFVnY1orSmYrYjlPeDI3WG5mMHRjUlh5SFU5RWJW?=
 =?utf-8?B?WGM4SkwwTjA0Q0pwclFqUXVib0svT2ZMNlZHSjM0VkJPRERzVU9DRjhRa2Z1?=
 =?utf-8?B?WWorUGF0UHBaWjZTYzBoZ2FMS3pJTTIwNUVhSGY2OTRiSWpZZk1pMmg2b0JJ?=
 =?utf-8?B?SjAwcStseWhpWjdVMVY0dWw3TE9KdmxMMjJ3SU1NSmo1eFRiZjJZVjdoc21k?=
 =?utf-8?B?T25SckUyTDBEV1hQR0JjcXZWVExUcHNBcVgzZzBmSFpqVWMveGFxQnVMcTBJ?=
 =?utf-8?B?UlJxTTFUYys1TjZzWTladjMyYm5jSE9IcDdFQjI0SDFlYkFwd0oyWTZMMG1P?=
 =?utf-8?B?WGh6RTdGNCsxRk1NOFJ6RXI5WmZtRmVXd1hxR1JEOVJDdzZNb1RxTXZKdDVs?=
 =?utf-8?B?MTN3bEtxNmk3Qk5ENWwweTQ1TEZxNUIyVGpLd2NRejI2V2VNRENXWG9vZGVI?=
 =?utf-8?Q?JcPED+Zz5xaRm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2FXSEFZNm44bm1MT0xyY203RXphOElBeis3U2wyMnUrTTFDZ1Y0cDRuS1Uz?=
 =?utf-8?B?azVUZU1kUlpvbnBySVJMRlVoclhxSTdpYTVrN0w3MUZ5SWVIcUVlRlJVZTNW?=
 =?utf-8?B?SFMwazRQK3g5RW5VWmwzR0kwaEpsUzZqMFA2T29nOTdVVUppRjVQZXU1bjA3?=
 =?utf-8?B?MkhPS3pkY05adG9hNjNTKzNFQ1IwVS9OR1p5WFBvUkovWnlTRDl1NnFsWlI1?=
 =?utf-8?B?NlV5YTRsKytLaUFsY2UxdDBMNGVVbVBibnlvWnFnWFl3QzhIOWRWbkxFTm8v?=
 =?utf-8?B?QnZHRkhDSEVtbXlQekZMVzl0cW5zcTByK2ZZaTNoblA1am5YRjJIUGtqeGxV?=
 =?utf-8?B?Nzd5S29IaEphdWJaL04yKzgxU21uQXUzUXhMVFYzRVFuZFJkLzRpOU4rejRv?=
 =?utf-8?B?QnVJZC95SndFb1czM20wenB2MDh6RTBMcjhqcFY0bHNaRFBjOTJjcHkrR3hT?=
 =?utf-8?B?Q0xlYzRDbk1KK283bjh2V2xneVhvemV4MlVUVnhGd2U3WGR5TSt4V0lLWFAy?=
 =?utf-8?B?Z0pkSE4rYk5TaFpxZDBaZEZlWWhHUktqUi80YlhNeXp2Z0VHZGlabGxCU3BO?=
 =?utf-8?B?SE1Pd3h6K0NzNHZFYWZzTkExN0xjMFlva0t3S0ZCemlWK3JSQ0VER2pFam5a?=
 =?utf-8?B?cVVOb2JhaEFzY0Z3Ti9vSFlBWThwVTVFMURoQU9jNEZnc0ljRWxrM2xNN01X?=
 =?utf-8?B?bFJwMFNycC9JMllvVHNnUWZoY3pNL0o1a1JhZ0JSaUJJN2xsY2dSWTI1VHlH?=
 =?utf-8?B?eGJZemRjZUNtM2U0bGVnOXRKQ2xhWWRPWFI2ZFI5Vmlrd3hiVU4venJtMXlw?=
 =?utf-8?B?NCtMS0VTenNvT2ZRdHNxM1phL3hINHBncnI3ekJkOUJ5Y3hxeW9sa1huYXNP?=
 =?utf-8?B?cmQyV3dLbkZBWSs5T2JnU08xMVRZY3BjZGJrVXNjeHl6VFJYWGtoTTZxQ3RD?=
 =?utf-8?B?dTgwdTczL3ZnNjdvQ3ZzMlVEeGk2bFA3elhoWkJ2V0M4ZXQwOTI1cVJXYm9O?=
 =?utf-8?B?bStNVVo5OGhGc2hWZWZsaWFNaTcxMElUSjZHSzlwd09vTldPM0xvMlZCNGI4?=
 =?utf-8?B?aStydHVVYmc4RjlseXhvam9sNHJrcnZ1dDg4MDNCdWp4TmxhSWFmd0VEMHJS?=
 =?utf-8?B?Vlc0UEVJVitVaXhPS2JDd2JoemtoSEJiYTlJRG5kTlJXTVBEeThlV01zNkhP?=
 =?utf-8?B?UUdiL1ZFSUgvWHl3RUJWT3RWOWFtUGo0K0FaTVFlWi94ZXpxNG5UTDVqMEgr?=
 =?utf-8?B?OUJKTUs3WHZsNnhOVnQvNm9vWUlESWp5ZVJrNThDNUN5TVpJMmpsTmdCZHQ3?=
 =?utf-8?B?WmJVL2U5RkVDcUZKRVV6NjhuV0w4U3ZYR3ZNTVhkVzBFcElRMVdjSDh2ZVFC?=
 =?utf-8?B?cnk5ZkRkb2ZVODJXTlY1UVo4Mm94WVVXU1FIVWs5bUdsOG1WU0R3NHo2aUkr?=
 =?utf-8?B?RTVSK1ZSNjB0VkNodzB5eW4xMGZZbTErc0gyREhSSWx0NVlGYkdWZFBKZkxa?=
 =?utf-8?B?ckthbmRnUlc3N0lRcHFnNnM5N3k3K3k2c2RZSG9WRWpBMlJhRVNsWGZ2QWtI?=
 =?utf-8?B?M0tKN09xZXJBQlAxakhVeUpwKzZ0eEwwNm9QVFc5TjJHTGh2QVpxbUV6amJQ?=
 =?utf-8?B?TGhkRnVwSzBjN2dkY1FwSUtoMUJPaGpTNFJRRU15YUJxUmhFeURkZWtVNFFN?=
 =?utf-8?B?NDFxZjZ5Q0JMQU1SQkdWbElvZk5sdGYvbTFlL001eUVLZ2ZyY3dqQlZFWDlV?=
 =?utf-8?B?M1VqcitoSXJaMFpRbGY0cUJEOEljeTB2cVZxNzJLSGtqL0MzRlpjV3JnakVl?=
 =?utf-8?B?aFR5KzRBUlNxM3JhUXo1d3htYmMzcWJXQWNZSVVTbkEwZERudHQ3TTJjNmRW?=
 =?utf-8?B?QlBQUTdudE9UaFdtRnU5eFJRVHhrUkNNREcxUFNFYVpmWGtXWngyS3FuTEY2?=
 =?utf-8?B?STBjeFdDL3ozdDJ5TUV2VXZGckNoRUJMMHVoL2dlb3QrL1Yyc2MzS3VWNkZW?=
 =?utf-8?B?dldHQ3dNN1h1cGhMR090U1BHOUluVjMvcHR6dUltSm9aWFNjUFlBVUlUNVlX?=
 =?utf-8?B?L1lHMzdnYlNHaHNkdEhYcjN4N0haZXFQbVZieE5YRU9QSTNsdmRUeG1rTU5W?=
 =?utf-8?Q?iYzm5DmDjLOMilNOuvMFDsoeC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0d0d82-c2d9-476c-a909-08ddc8f20163
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 07:33:09.0030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WI4Dq/ZwnFqqAT3i2e8CdPmBoPDGfZuQm1zHRT9TFJVMiGcq7ybcR/twmzfcvbkJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396



On 7/22/25 09:17, Krzysztof Kozlowski wrote:
> On 22/07/2025 08:49, Michal Simek wrote:
>> Add description for AMD/Xilinx interrupt controller.
>> IP acts as primary interrupt controller on Microblaze systems or can be
>> used as secondary interrupt controller on ARM based systems like Zynq,
>> ZynqMP, Versal or Versal Gen 2. Also as secondary interrupt controller on
>> Microblaze-V (Risc-V) systems.
>>
>> Over the years IP exists in multiple variants based on attached bus as OPB,
>> PLB or AXI that's why generic filename is used.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> https://docs.amd.com/v/u/en-US/pg099-axi-intc
> 
> 
> We usually do not take bindings without users, that's why bindings patch
> is always part of some other patchset. Commit msg also did not clarify
> the usecase here (or exception).

Example DT is already the part of arch/microblaze/.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/microblaze/boot/dts/system.dts?h=v6.16-rc7#n338

DT has been added in 2014 before dt bindings that's why it was never documented.

Thanks,
Michal

