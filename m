Return-Path: <linux-kernel+bounces-851376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE42BD64F6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0261F4F51CF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BC82F0C69;
	Mon, 13 Oct 2025 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ADX15JPf"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568B81CAA92
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760389189; cv=fail; b=dWuyVKZHBrDdYBxDpggzZKrIg+3435zPruLSZXQuJReLHC3nbnupF8i8PDYfk7qkLiZ+MfHEJyuQ6oZmxaSO8i1I6UTj6MkS6pAxBU5YkLANmumvaAH0JuT2TnTC09RJ2uIq1RMsgsA2OyuVvFLVuiQ7oiKAH/dOlxWJgWXBXAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760389189; c=relaxed/simple;
	bh=8nQKbGPAKfAFPCdjcEjk9sx3gNxNS6X5h23UMg4LxEE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AB1Y8GiJWcu2onfHaqt/3qJVKZFTV8qHMNd9P8MubIb3s2hgiERumWTfkW2L95oAXIy5KH5kwRPLmzKj5NqxHE5mrSNsekRpVh6jxw/vuuNPuabhETUNO+ss14fglDyLkwbPi8h582Ql7D0jNm8HEM6P7134t3S7yH9PcKe26V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ADX15JPf; arc=fail smtp.client-ip=52.101.56.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIJElUZY+6Vz7ngoaF7v4r/bUH2QpNAHMzSDNd5UWk1O0HqPtCpmeAKXW6jCZ+OR/nzEveVY6FRj+mirtEQw4p1025aRlcw3YXDHK6T50DwwSIa+pwnwobxx3lTswvHpSridk1TbkHlnha7L0GKqrwmyNjVt0h0dxk9mKCPEU0aUhipdZ6245V6bqhvXBB/BIdF7FGk4Jn+96sxT7amyRSsqvrqtWxrHWqTYJJmco5EDW2hVuveoDzb5vKMYF/jPWj0sZhLRhteOhRwfvOYq7RvcIIt5D9QjPnZrTXbfrppSL8YpYzgnyGZZt+UraVxhsCelFLKeyed7LXlm65ltSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFXG4CsQR3kgZRrXEGJc+IMNnO8d7UapazHMjbrnu/0=;
 b=eAgKX55iZBSEZtX0h9iGf3eo7kI5w+ddhZs4+S/ARdJEiVPsfepkAHsaRRVqNvu1FmMneCOcEX2TVsgflZJXot22JrMSIe2EUHuuXrPSTq9Mwr8jwzh067eKNTs3knvoGjEBK9xpPZ/YladB5L6dKR9tIedQSOVXUdHYPopuLx/o9Cbhgab1li8RC03Y5vudhRDV94zbBnM1JgEvGNWAdqbwrzqOSyVP8dMIYCQ0Kxn8rpLzM9UHmkgTKuAHjiEPxAiVT5KgXPnb6O6PhMNVTBSkKK/O2coFzmrBmcz4djzYqh213wS/jRh3f5jPbfJ1AfgA+4ZUMsdvTrv6gRI27A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFXG4CsQR3kgZRrXEGJc+IMNnO8d7UapazHMjbrnu/0=;
 b=ADX15JPfE3HdkOCTb8ukpd43dhJDMtpeX7AWD+5DZzO4CJXH18sh/kpts0rA/S6wmQIYkE+qjJvrR5PX54tzyHatAsjHvbxEoh5t7YTzkND6j4fSaS4hZMSBSQe+MIMOrg2uwFgOo+/Nk2qx/yvnDJHijUtKwzszvL7KBw2Na/2ZEljLWqppD/NG/85qBKsjs2Uh60BHcqgnY14VySoPGx8J+2wysIMZRJfW1VYkrKtMmAosd8nE0aOIbLW+rN5k1ASpt9q2jy5cQrn9wICIFn7i4XQ71P7l7APaSsvu5SdxE4Vs4ZaPhK7+gLo1n8JcPzTVvJql/m3M12eNJUpyDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:138::22)
 by SN7PR12MB6929.namprd12.prod.outlook.com (2603:10b6:806:263::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 20:59:40 +0000
Received: from DS0PR12MB7704.namprd12.prod.outlook.com
 ([fe80::e85e:e922:a750:e68b]) by DS0PR12MB7704.namprd12.prod.outlook.com
 ([fe80::e85e:e922:a750:e68b%3]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 20:59:40 +0000
Message-ID: <b8a138ca-9a5b-46e1-8d10-b6d31230f485@nvidia.com>
Date: Mon, 13 Oct 2025 13:59:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] firmware: smccc: LFA: use smcc 1.2
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: salman.nabi@arm.com, lpieralisi@kernel.org, mark.rutland@arm.com,
 sudeep.holla@arm.com, ardb@kernel.org, chao.gao@intel.com,
 linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, sdonthineni@nvidia.com, vsethi@nvidia.com,
 vwadekar@nvidia.com
References: <20251008190907.181412-1-vvidwans@nvidia.com>
 <20251008190907.181412-2-vvidwans@nvidia.com>
 <20251011010251.50c8be14@minigeek.lan>
From: Vedashree Vidwans <vvidwans@nvidia.com>
In-Reply-To: <20251011010251.50c8be14@minigeek.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0227.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::22) To DS0PR12MB7704.namprd12.prod.outlook.com
 (2603:10b6:8:138::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7704:EE_|SN7PR12MB6929:EE_
X-MS-Office365-Filtering-Correlation-Id: 890d1c3a-9ddc-4486-941d-08de0a9b6d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUw3akx5NWcxaHhjWURZMU51VUVEZi9lMjZVL2g0NzdXWG1CeEZtaXdkYklY?=
 =?utf-8?B?NXBCcjQyUnFuRU5pMzBtOXRqYzRFWXRuUXE1bDF6ZDQ1L1JFZ09RNVBNcEYz?=
 =?utf-8?B?YlZHMmlRRitVS0ZDN0dVcHRjcVRXZkc3U3dsQnBkYnlJbE5hQk04U2xpRUd6?=
 =?utf-8?B?M1BYU09WRkdiOStSdFVmVkhkVVNWVEk3em03ZGpDWkdweVR6ZEhDOG1pNUMz?=
 =?utf-8?B?U01iY2lnUmlVWTNVM242a2E1Z3ZRS1pxZm9kK0JnRHRESVBWbEpmdlpDZnhm?=
 =?utf-8?B?eTFyeXN4cTM4NmJKcDhNSEhLY0FJR1kwai9UemY5aEpTdzdOSi8wM0xCQkJY?=
 =?utf-8?B?Q3hwcUVJdlBsVGpvY1RLY1JsU3VhaEw0QjRHSEMwbkxjeUltaXFVWjc0VnUz?=
 =?utf-8?B?R0MxekFhdXI2MW8rcFAvU1VnRkszeFdwR2RQLzA3RXJhMG5hY1RTUDBZNTda?=
 =?utf-8?B?MmV0VFE1RnJ4bXpOQWxKOUpUajhjbTFTd0YvMEtHTW5GbkhNMnVaa1UvV29U?=
 =?utf-8?B?V24xWTlXd3JzS21TR0dIamJBQWtCRDcyNXBnK2QyYjJ2YlNtRDBKaTRnR2s2?=
 =?utf-8?B?UGdvMDd5RXJESGxnMFBhRjBrdHVYL0JJa0NDOFNoT3ZBejFmNitFYy9reWZG?=
 =?utf-8?B?N2duUmNEUFZMS1F4dHRuM1NRaHFwUGJHY0lMYkcwL1FNTXgvbTZxUittdXV2?=
 =?utf-8?B?TGl4aWd0czVnTGd2WXMzTWxYWEFMaHJNUVp6ZjJ1bktzdXExeTc2Z1RldDh1?=
 =?utf-8?B?cWNvNmM2cmIxUnVCM2t0UUQ1VGpQY2oxOFBPR1Uza1dqYUIwb0NIOTJUTmxQ?=
 =?utf-8?B?RUd3T3dQYklxNUx4Vk1qa2lpcTM5a0YvRElpTTUyUWxualR4WXZRZ1BzVXBn?=
 =?utf-8?B?NVdrNUNEdWVrWEM3aG5XdnM3UTFtYzZCcUlrcHpIU0UvQU5nWlFGQlhsR2VC?=
 =?utf-8?B?QjhNUmJUNzBMMTJCTWxuaUpmZDNRZjNNRFNKNGwrTnFnTU1xbFUyMTVKMDJr?=
 =?utf-8?B?ajVXRWFsRHlZdkJ5akhzTmp0dWtzaWM2Uk11Vk02S3o0R2xhT0tyNnZTeU1J?=
 =?utf-8?B?dkNKbUt0ZTBMSzBITytiT3B1enVhcG9TVlVoRDZIVkZxcUoxUHZrTTIwZHpV?=
 =?utf-8?B?NUtCeUhmcGtLK1g0V3FaVEtQQkxJNDd0YVRaYy9vVnNrc2NCaVhVY1dvMXNZ?=
 =?utf-8?B?eVFXM2tsQ2YwdXhOSlVqVzF0KzFWaDJ5bS9tRnlDc2dsRHBnRjlITWt5blU2?=
 =?utf-8?B?anpvZFo1Y1hhV2tyZEtmNGNsSGlYaEpFeGRwdnVIdTVMdWRNN3ovQmlVcUg3?=
 =?utf-8?B?R0FoUW15L3p3VEF5OWZ0eVdpY1ltck9XL2dLSzM2Q1pkTjRNZ3JyeWlITlFh?=
 =?utf-8?B?SHFiR2lNb3hOMzg1WEFPN1o1R1dwaDlBK1RoM2RwUTVWb21PWi9NU21EMG9z?=
 =?utf-8?B?ejQ5Z3hGRS9XQytndHVlcVB2Q1FvNVJYRzRFaloyZmNaVGIxeWk3d0tYRFd6?=
 =?utf-8?B?a0hKdm16UmZXVlR0Sm1yVDZyUTVOSGZsRG5PK3VSYzQ1K1Q3czVvdy9OUFpp?=
 =?utf-8?B?VHNYa3FXbG5YRkwyMXNFcWdrN1RLQk5ZTHBYVGF3MjZFdVNaMFpYZjIrK25m?=
 =?utf-8?B?RXIyb2M5TDQ1V3JRMlBBZkRJOUUyWjg3VlplUEVuUTI0TldlWXVnYjlYQm1T?=
 =?utf-8?B?bkQ2M1JLejZnZlhNdTJORGtRdThZejRBZUVobnIwcW9yWEkyY1R6aW1XYTRk?=
 =?utf-8?B?eTNvOHJQRVo0TDd0YTljNVRRZFE1Z2w4U2p1dmU0QWMwV3ZsYXlBcWs1UVJU?=
 =?utf-8?B?dU9PbDE4NlRoakJXS3kyRjhCL1RFYnU3S3FiRmcwY1BCK25qZEdUeFhqU1Vr?=
 =?utf-8?B?SVkxejF3SEswTWhMVUZlcUx6bEUycmJyQTloU3N4U0FabkZHS0Nia20xT1Fs?=
 =?utf-8?Q?4cQ25McGS7q+OtqCc1SBxkpbKHieYFCv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7704.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVdwRHFvWnpjRXhOeHM2OXdKbWZETGxKTkk1akwvMmhDVnZ6dWVjMkplblpR?=
 =?utf-8?B?U3NtRkZZWVQycVNZTG4zRmdOU2VmdTNka0IxV1g2N3RiNGQvMHVNaTNXQUQv?=
 =?utf-8?B?NnNDam5HRXNKNStEYnlJVWxFQ0xVUXlKQTNERWxpUUZnRno1MStNMXRNTG0x?=
 =?utf-8?B?U1QzOUNONTZvUEpoRkJwanRGR3E4L0hmMGxNUmYzOEVHbWJOOFRzdmwzRW12?=
 =?utf-8?B?TWt5aGRXZThZU2Z4V2xwQVo2MGJXdC85dyttdCtITDhRcUNTdFdxVm9ZWkQx?=
 =?utf-8?B?QXM2S3hWTy9lcVJsWHdUQ1JnTFhWSlFoQnYrd25CVXh2WTNQQm5yMllJVGRB?=
 =?utf-8?B?NWxCRTZYUTdEKzlwR2FYaFNVNjVlVXlJbnltbEFtd211YXBSNmJBaDk2UVlD?=
 =?utf-8?B?QWxLQnIvTWVjOXBBeFdZSVVNdzRveDUzVzkyWTVEZzMxQVU2V0Ewbkl4UkIy?=
 =?utf-8?B?OHRHaURKYktIVFJWdGhCcTdROXgxL205Y096VFlweUdMQkRlZzZZdFh3OG82?=
 =?utf-8?B?am1VeExyQzFVcmNJOFV5ZFhxTjZUcElwZ1dEWVl3ZnRIejE5ZktyVFQvdk5O?=
 =?utf-8?B?cys3MnpXN0dJR0dzeDN2ZFgyV2Mvbkt1cWNmTmw1V3VaaUtHRk93REtnMFpC?=
 =?utf-8?B?MW9FRVZoNHdGczlaQnVOQWtHQWF1UklOZTlFV2RYSHVjKzVoNDQrWFVUUFIx?=
 =?utf-8?B?aGJ5ZlpGUldRVkpkSWRLdjBWN0lLdzlsenZERUZSM1ljQ2FUc0FIUm41enhO?=
 =?utf-8?B?WGtGUGFXaDcvaFFGRmc4YWdkUGI5OERDYmpLdUdyMlkyQVpkQmx6UUhpalRI?=
 =?utf-8?B?eEhQdEo3THVSdENOV2s0Ukk0bXlwUDJORXpYM1dQNXVsRXpRbG9VQzBpQ3dX?=
 =?utf-8?B?dW1CSERESkRFVnEwNkRtTjQ2Mkc4OFNPVm5JMDRKcFZQaGlSTFc3MWZMaU5x?=
 =?utf-8?B?cS8xOFVVZWMrZVczc0NITVFWSnd6TFpzUVlzRU1WRDNvbzJ6SHF6d1NoeUdi?=
 =?utf-8?B?d2k1SzZuQmJhSW1jRmxqL0xkWlZOTk95ZndnandKdEVac1NOemF6eXBUcnAy?=
 =?utf-8?B?T3F5Mytmd0tZdlNjek9mQ0xRbzFMWU9mLzBEcjd6WDkydjk3dXRsL0d4YmRM?=
 =?utf-8?B?TzEwZzFEREJ6T3ROUHBFSXFjU0VtbmVwQUQ1RDBNZCtkRFVLNUlGbEZ2VS9R?=
 =?utf-8?B?QzNLZ0pvVXJwbUV1UFVjTDhja096dFZtZndLT0dXZTZZaUtDcXhNYStNYzFn?=
 =?utf-8?B?MWc3T01KRWo1dkhpbTNPRGNxUzg0YkhtVTMyZ3pXcFdOQkJVYjFiK3ROeUlK?=
 =?utf-8?B?UFVhMm8rdVp5YkdxZExlQTl0MWJSWHFFNDFwOXV2eTFCaWRGc284YklGMXR5?=
 =?utf-8?B?ZlBuNUdGU3I4eEJpb0JyZndPaHJZdWtYNXdwWnVxbW1jczVIS0hST1pnY0Q4?=
 =?utf-8?B?N0N4V2RwZ05kUk5ranJEdmxqdWVUdFZyQjVqZFczbllUU1pEbUpXQW81d1hO?=
 =?utf-8?B?NkR1aFhQeGhVYUl6N0JOdk52OThpWEUyZUt5MjFySUxMZVd2aW5TcWhUa20x?=
 =?utf-8?B?Vkd0VnhVd0lKMXJiOTFNa005d1grYTlxemVIUkRHZ05oL3BSblNadGZTQnNQ?=
 =?utf-8?B?Zyt5SUMzS29TZ1dvNXhUbDkxN0IvVWZCaTkxaWdJYjlZVUNnMVg2RGlGYldI?=
 =?utf-8?B?RERNcHE1VmtTck5JZGlzZjd0OVRnQU5mTER0QUd6UG0xVnJCVktuUjJoSXQ5?=
 =?utf-8?B?MEM2NEVlWWh5dXM1ZXphd29LSjVjWXVDZ0ZEWE50Ukgwd1ZJTS9EN3RHYmps?=
 =?utf-8?B?M0F4ZVhrVzk3QUhxOU1saGZ2TS9KbUxHSGltdUlqSithdWozUm5CWlZjZ1Iz?=
 =?utf-8?B?V2FiS0lRUlk2WjJ5b3pzVlVJanU5MWc4YmJDNjg1a3oyVkhpcS9hU0FQd09x?=
 =?utf-8?B?ZEswcjhuN0Mzb3RDc1BjdTJoVDhRc1pPQWF5RlpOYUZtNU5PZFk1SHI1T2ZZ?=
 =?utf-8?B?b0ZjWjdXYU1mYk5WRkNVSHlIQUNlcnphcU5MbWp5MEZzWmxISDRBVDdndU1B?=
 =?utf-8?B?THczWThaam84eldxcXlySXhyVS9GMUM2RE9lYWhKQkgvNW1kQlIxZXNmVE00?=
 =?utf-8?Q?9a4e9Zsgf6f/VjMGk2RMod0wv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 890d1c3a-9ddc-4486-941d-08de0a9b6d51
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7704.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 20:59:40.5183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gTD98wFty9rmkPK1j+YE5BirqmAowgry5OfpuMuuWb8ll6ldh6l7jm+LsO26kq+OiP4f5Pu9eM5QKvL7Xdp2KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6929

On 10/10/25 17:02, Andre Przywara wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, 8 Oct 2025 19:09:05 +0000
> Vedashree Vidwans <vvidwans@nvidia.com> wrote:
> 
> Hi Vedashree,
> 
>> Update driver to use SMCCC 1.2+ version as mentioned in the LFA spec.
> 
> ah, right, good catch, one call is using x4, so this must be the v1.2
> calling convention.
> 
> Just one small thing below...
> 
>> Signed-off-by: Vedashree Vidwans <vvidwans@nvidia.com>
>> ---
>>   drivers/firmware/smccc/lfa_fw.c | 80 +++++++++++++++++++++++----------
>>   1 file changed, 56 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/firmware/smccc/lfa_fw.c b/drivers/firmware/smccc/lfa_fw.c
>> index 1f333237271d8..49f7feb6a211b 100644
>> --- a/drivers/firmware/smccc/lfa_fw.c
>> +++ b/drivers/firmware/smccc/lfa_fw.c
>> @@ -117,9 +117,13 @@ static struct kobject *lfa_dir;
>>
>>   static int get_nr_lfa_components(void)
>>   {
>> -     struct arm_smccc_res res = { 0 };
>> +     struct arm_smccc_1_2_regs args = { 0 };
>> +     struct arm_smccc_1_2_regs res = { 0 };
> 
>>
>> -     arm_smccc_1_1_invoke(LFA_1_0_FN_GET_INFO, 0x0, &res);
>> +     args.a0 = LFA_1_0_FN_GET_INFO;
>> +     args.a1 = 0; /* lfa_info_selector = 0 */
>> +
>> +     arm_smccc_1_2_invoke(&args, &res);
> 
> I wonder if we can share the same struct for both request and reply?
>          arm_smccc_1_2_invoke(&args, &args);
> 
> Looks like a lot of stack space used for just a few registers.
> Same for the other occasions where we just do the smc once.
> 
> Cheers,
> Andre.
> 
Thank you for the suggestion.
Yes, I think using same struct for arguments and results should work.

Regards,
Veda>>        if (res.a0 != LFA_SUCCESS)
>>                return res.a0;
>>
>> @@ -129,20 +133,23 @@ static int get_nr_lfa_components(void)
>>   static int call_lfa_activate(void *data)
>>   {
>>        struct image_props *attrs = data;
>> -     struct arm_smccc_res res = { 0 };
>> +     struct arm_smccc_1_2_regs args = { 0 };
>> +     struct arm_smccc_1_2_regs res = { 0 };
>> +
>> +     args.a0 = LFA_1_0_FN_ACTIVATE;
>> +     args.a1 = attrs->fw_seq_id; /* fw_seq_id under consideration */
>> +     /*
>> +      * As we do not support updates requiring a CPU reset (yet),
>> +      * we pass 0 in args.a3 and args.a4, holding the entry point and context
>> +      * ID respectively.
>> +      * We want to force CPU rendezvous if either cpu_rendezvous or
>> +      * cpu_rendezvous_forced is set. The flag value is flipped as
>> +      * it is called skip_cpu_rendezvous in the spec.
>> +      */
>> +     args.a2 = !(attrs->cpu_rendezvous_forced || attrs->cpu_rendezvous);
>>
>>        do {
>> -             /*
>> -              * As we do not support updates requiring a CPU reset (yet),
>> -              * we pass 0 in x3 and x4, holding the entry point and context
>> -              * ID respectively.
>> -              * We want to force CPU rendezvous if either cpu_rendezvous or
>> -              * cpu_rendezvous_forced is set. The flag value is flipped as
>> -              * it is called skip_cpu_rendezvous in the spec.
>> -              */
>> -             arm_smccc_1_1_invoke(LFA_1_0_FN_ACTIVATE, attrs->fw_seq_id,
>> -                     !(attrs->cpu_rendezvous_forced || attrs->cpu_rendezvous),
>> -                     0, 0, &res);
>> +             arm_smccc_1_2_invoke(&args, &res);
>>        } while (res.a0 == 0 && res.a1 == 1);
>>
>>        return res.a0;
>> @@ -150,7 +157,8 @@ static int call_lfa_activate(void *data)
>>
>>   static int activate_fw_image(struct image_props *attrs)
>>   {
>> -     struct arm_smccc_res res = { 0 };
>> +     struct arm_smccc_1_2_regs args = { 0 };
>> +     struct arm_smccc_1_2_regs res = { 0 };
>>        int ret;
>>
>>        /*
>> @@ -159,8 +167,10 @@ static int activate_fw_image(struct image_props *attrs)
>>         * LFA_PRIME/ACTIVATE will need to be called again.
>>         * res.a1 will become 0 once the prime/activate process completes.
>>         */
>> +     args.a0 = LFA_1_0_FN_PRIME;
>> +     args.a1 = attrs->fw_seq_id; /* fw_seq_id under consideration */
>>        do {
>> -             arm_smccc_1_1_invoke(LFA_1_0_FN_PRIME, attrs->fw_seq_id, &res);
>> +             arm_smccc_1_2_invoke(&args, &res);
>>                if (res.a0 != LFA_SUCCESS) {
>>                        pr_err("LFA_PRIME failed: %s\n",
>>                                lfa_error_strings[-res.a0]);
>> @@ -211,13 +221,16 @@ static ssize_t activation_pending_show(struct kobject *kobj,
>>   {
>>        struct image_props *attrs = container_of(attr, struct image_props,
>>                                         image_attrs[LFA_ATTR_ACT_PENDING]);
>> -     struct arm_smccc_res res = { 0 };
>> +     struct arm_smccc_1_2_regs args = { 0 };
>> +     struct arm_smccc_1_2_regs res = { 0 };
>>
>>        /*
>>         * Activation pending status can change anytime thus we need to update
>>         * and return its current value
>>         */
>> -     arm_smccc_1_1_invoke(LFA_1_0_FN_GET_INVENTORY, attrs->fw_seq_id, &res);
>> +     args.a0 = LFA_1_0_FN_GET_INVENTORY;
>> +     args.a1 = attrs->fw_seq_id;
>> +     arm_smccc_1_2_invoke(&args, &res);
>>        if (res.a0 == LFA_SUCCESS)
>>                attrs->activation_pending = !!(res.a3 & BIT(1));
>>
>> @@ -298,9 +311,12 @@ static ssize_t cancel_store(struct kobject *kobj, struct kobj_attribute *attr,
>>   {
>>        struct image_props *attrs = container_of(attr, struct image_props,
>>                                                 image_attrs[LFA_ATTR_CANCEL]);
>> -     struct arm_smccc_res res = { 0 };
>> +     struct arm_smccc_1_2_regs args = { 0 };
>> +     struct arm_smccc_1_2_regs res = { 0 };
>>
>> -     arm_smccc_1_1_invoke(LFA_1_0_FN_CANCEL, attrs->fw_seq_id, &res);
>> +     args.a0 = LFA_1_0_FN_CANCEL;
>> +     args.a1 = attrs->fw_seq_id;
>> +     arm_smccc_1_2_invoke(&args, &res);
>>
>>        /*
>>         * When firmware activation is called with "skip_cpu_rendezvous=1",
>> @@ -395,14 +411,17 @@ static int create_fw_inventory(char *fw_uuid, int seq_id, u32 image_flags)
>>
>>   static int create_fw_images_tree(void)
>>   {
>> -     struct arm_smccc_res res = { 0 };
>> +     struct arm_smccc_1_2_regs args = { 0 };
>> +     struct arm_smccc_1_2_regs res = { 0 };
>>        struct uuid_regs image_uuid;
>>        char image_id_str[40];
>>        int ret, num_of_components;
>>
>>        num_of_components = get_nr_lfa_components();
>> +     args.a0 = LFA_1_0_FN_GET_INVENTORY;
>>        for (int i = 0; i < num_of_components; i++) {
>> -             arm_smccc_1_1_invoke(LFA_1_0_FN_GET_INVENTORY, i, &res);
>> +             args.a1 = i; /* fw_seq_id under consideration */
>> +             arm_smccc_1_2_invoke(&args, &res);
>>                if (res.a0 == LFA_SUCCESS) {
>>                        image_uuid.uuid_lo = res.a1;
>>                        image_uuid.uuid_hi = res.a2;
>> @@ -420,10 +439,23 @@ static int create_fw_images_tree(void)
>>
>>   static int __init lfa_init(void)
>>   {
>> -     struct arm_smccc_res res = { 0 };
>> +     struct arm_smccc_1_2_regs args = { 0 };
>> +     struct arm_smccc_1_2_regs res = { 0 };
>>        int err;
>>
>> -     arm_smccc_1_1_invoke(LFA_1_0_FN_GET_VERSION, &res);
>> +     /* LFA requires SMCCC version >= 1.2 */
>> +     if (arm_smccc_get_version() < ARM_SMCCC_VERSION_1_2) {
>> +             pr_err("Not supported with SMCCC version %u", arm_smccc_get_version());
>> +             return -ENODEV;
>> +     }
>> +
>> +     if (arm_smccc_1_1_get_conduit() == SMCCC_CONDUIT_NONE) {
>> +             pr_err("Invalid SMCCC conduit");
>> +             return -ENODEV;
>> +     }
>> +
>> +     args.a0 = LFA_1_0_FN_GET_VERSION;
>> +     arm_smccc_1_2_invoke(&args, &res);
>>        if (res.a0 == -LFA_NOT_SUPPORTED) {
>>                pr_err("Arm Live Firmware activation(LFA): no firmware agent found\n");
>>                return -ENODEV;
> 


