Return-Path: <linux-kernel+bounces-771402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B00B28694
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1A95E5AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5AF29AB0E;
	Fri, 15 Aug 2025 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KcQ6UlZ/"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7AA21CC62;
	Fri, 15 Aug 2025 19:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755287239; cv=fail; b=DZNnfNp1g2cXFKvZngeQ1KiW2Zy5r/rpq3uNw8O0WClC68aoJynBysghIxndGlrAGsZKlHJLpjVVrpPlqLhXX1u8WrmCqe2tBg8V76WPkvrAM59Y/c5MDYKQ0O7uEQ/1YxB9zg/rYfkE7BvlbUoJWFK1cCC3Je2odQoIeoXsH0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755287239; c=relaxed/simple;
	bh=R9t5FOG9QnccNvWeEA8HSpHhJHv4X6AW4TpdFnW7KkI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=rxC1vem8wwea7nr+EE7odWsEL9PfD0CR9yI7LuPdMK8JOEahjcQNSTK0406AxPqMe666wQOO/wvYmpkMJ6ID/spokq5/5tYZhd/IqnoScfy9DjN4+yIBCOxUSxkd+ifMyXixUL+Mqy+IZNTXChRFiDzu4n9rqjesKXg4nXlEElg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KcQ6UlZ/; arc=fail smtp.client-ip=40.107.95.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0vNeanO4qpVpOR7P8D57j94kvnlIaneC8MSqeraFPsn3Zs3jzTY8W19O15zz8ShE6tS2+9U8ZZ/DuRYGDYgJD1siCL1cgLvhjMHkwFxscaFWBdfVKPROJw+gzjHuGeYfhwlENeXncs3HqxZaN0R1V/gERwPebsALmDW/JiVIpgyUk9625bni3OohgrQjkzubFV0af+MAbQXyKcW+iqwvMZpAtqrlshoI7em0DyLYPLpvUIJ4OFWphru55PJRSClQl0iRCEDEFGA2gCscPpA04QeWKHldkQiwOB1MwxA3QHkJ/yo0fJdTsv4Gs3EjVUaCwaBG17RQPKWuyyXPiwWCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qSzTnv2/dnIpSIZ0AwXEyJoyJ9dBRGadEwSSrlsKMQ=;
 b=ev+1gO2qz99ns4/TbT164jo4s2evGZ/oMQpFAFur67DE5OmLwgR9H+EUha9o8Hl3xLB6opkwRligsSeoHR10QB2/zI4sNsyk0pc6iawE2nzl1xuCM6Etk0f7k3z//IK0gW0JvZAy6tu4311dW6dqnWzswFUcYaskFUv4Us/ZqXLx9HmVn10M08w94BdOCFpoTThqM+/t8tklcR2M1CHn97Byp3CEkNU0QiKF8IyYzgQZYfhLR75j30KASr4xUYCj/grJkM3WMt97gmPkjkhVrD0ruNw7NzBPJHirW7+st0hdgjtSO8rv6wknzebq4IbzmgaXpdZXKm08nKCL916AnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qSzTnv2/dnIpSIZ0AwXEyJoyJ9dBRGadEwSSrlsKMQ=;
 b=KcQ6UlZ/I8SmswbC+UPgG7P3KhyHXYzl2aefgqjcI3Wx+/jtjQSGvb7GPLZOjOZbJP+ihYUOEe3y+8brO4s+YSOR3UGSI1oUiI/WNBKwE+Q4EEaVZEsLkH9dbd0jV6HDEJ5t++1txnJ/wdHfVegUTv/Z1FhmoNjJlbang1zpLwdxFbIVbAhfpdXUYPYaAfk7GDP/Io7JCr9DnBLA3ajpyTD/QZAuTUNjmNOYnPmoI+IixwVi5wwK90a03bVRTNTHhX3V6VcHAxwjsBOTbS0le/fP+mZKnrjyEFo0lBBnHj1nfvYMeR5C0IxvW4TQfxDASELmRjt/gNV7d58LIr9Hqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) by SN7PR12MB6864.namprd12.prod.outlook.com
 (2603:10b6:806:263::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Fri, 15 Aug
 2025 19:47:11 +0000
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::9de5:7299:4ee9:21e8]) by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::9de5:7299:4ee9:21e8%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 19:47:11 +0000
From: Marc Olberding <molberding@nvidia.com>
Subject: [PATCH 0/3] Adding device tree and binding for Nvidia mgx cx8
 switchboard
Date: Fri, 15 Aug 2025 12:45:54 -0700
Message-Id: <20250815-mgx4u_devicetree-v1-0-66db6fa5a7e4@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHKOn2gC/x2MSwqAMBDFriKztjCtf68iIlKfOgs/tCqCeHeLy
 0CShzycwFMdPeRwiZdtDaDjiOzcrxOUDIHJsMm41Ilapjs9uyGoFocDlDXQCedccFlRyHaHUe5
 /2bTv+wHPDYAfYgAAAA==
X-Change-ID: 20250813-mgx4u_devicetree-c2e130607089
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755287229; l=1487;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=R9t5FOG9QnccNvWeEA8HSpHhJHv4X6AW4TpdFnW7KkI=;
 b=W00EeKOa/cF+tlHTKCy3cGyYx/x8sqs4lhxNG5ZcA3xgByCPbZRecfkiD75PrRRwWeva3qufE
 92Znv52Ag8HAYPF/tlEZTvu6Sj/IBNnleeqPNxzwXfd+WwB44dr008/
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4PR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:303:b7::9) To CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PPFDAD84AB72:EE_|SN7PR12MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: e613711e-6676-42d1-1f43-08dddc34866a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTVVdkl0emJaYnU5VjF2OXZoVjI1Q0xPQUd1V1liYkFVUlZHYXZjSkp3Zk1u?=
 =?utf-8?B?SGp6SysvRkI4VDZSSENDMzVONEt1VmYxNWtJNjlkYlFZbXNWMFhXcFhVZ1VS?=
 =?utf-8?B?Z3NhYzd1dHJyZENwMWQxNHFtNDhscG1SKzB4YmtWRDY2eFFNakxQdzFleDl1?=
 =?utf-8?B?eFg2emRhcmszV2k2UFN5UW93ckx5KzUydmJQb1BadUZoZEs3bzQ0ZllzQ2Z5?=
 =?utf-8?B?QjEvbHl4N0psSm96Z2xFY3J0M2FCSmtJZHhPdGtyRFF6V1F6NFJESmRDUEZR?=
 =?utf-8?B?MU1TRDE1VnNVTkVKRFFuTzJWRXg1RGFleEU4NFpqQldWS3RpanRyd1NHbTZ4?=
 =?utf-8?B?eENlODRHUUVwbnJKa3FxL1UxVWs5cGFBTkJBZkxMUUE0b3NaWlE2d09lajhP?=
 =?utf-8?B?UlZpSTdzNG9NbXUwdEI4ZSt6TmRtYjJlOFoySUxLcG5IMUxoUzJiVEU3a0tB?=
 =?utf-8?B?QWY1NUdIYzZDRkdNdGYwYUpkN0FJbUZiS1lYMmV1cDAvdURWSTVoRTNIU0tz?=
 =?utf-8?B?Tmt1UEN2RXMwRE1LQ1J2bXpHczFwbnhxT1NtS1Y5MHFMMk56TWdFN2pJbTBD?=
 =?utf-8?B?M0YwY3Q4Wm9KY1JJbVZSZzB2bDl0aDIwVCszaXk0dzljQnJkeVRhc3U5anlv?=
 =?utf-8?B?Qzd1ejdlc2xkWVlsNHVTZ0JGQjlPNG9CUU4wV3Q4b1Jsby9Vc0xuVlp4eEhJ?=
 =?utf-8?B?a0VOc01uZnBHOHBCWExMUjJWOE1ZT3RSNlM1emlBZk9DMjY4amVlNmVLUkxE?=
 =?utf-8?B?SEVjbHNDcmxJY2xPZ0pkQjk1aFpXQ0FkQUVCRFhNZTl2QW9XS2V2cC9sTWdF?=
 =?utf-8?B?T0pNOG5pU0NJOVZuWlh3TlovTjJwQ3JsK2djZ0xiblo5TkhLOVYvYndVeGta?=
 =?utf-8?B?LzFiWEhRQ3FLZDlWNm1BT1VJbDlrRmZBb2F2RmN4RHhvdFhxYk1aNHpobmlQ?=
 =?utf-8?B?c1JBcFJSa1dWcWZvMlJVNXhnZ0lWZFhFS2F2bjZzZDArM253U2dHNGJLZVVN?=
 =?utf-8?B?TjZEWjhWVk9NSGZPNE9oYTJ3V0R4NjV6RXN6cHBVcEowZkNBTFFtTXFvV1Fl?=
 =?utf-8?B?U2djZmNqdmRLSk95ckRoUy9QV2FiNjAveUFDbVdpVDRRNjRZdnFMYjNERlpa?=
 =?utf-8?B?UmJiL2ZwdXZHd2hHMlpObEJIcjVsSEw2bzl5eHNkajFYMmxhUUIvNXNsTFdY?=
 =?utf-8?B?TzU1bHN4T1o4SEZIMzJXbDlkRXpiL1NjZ2F6OERYK0tHNkdaeFlTSytwUmVt?=
 =?utf-8?B?NmNGL1pCQVVFQTVPSnlWWHlTZDFmN05IYVM3M0Zjd2VoRkY2UG5iWHhCRVlz?=
 =?utf-8?B?enJsNjFFTDVXLzlNVWZvS0FSUHVQdmZkaFExOGRJLzdpckRwZk5OcTZLMUJw?=
 =?utf-8?B?bWZYZ0EwYWkraHJ5WDlJejgwL1ZXZG02MG5HZjZwVndUMlB3WExxbGhsU0NJ?=
 =?utf-8?B?QmJwbG9HbUtWNlVSMGxFNzdiVW4vY1Bjb3QzVW9RdjYwa3VCSXFUaEsvVHkv?=
 =?utf-8?B?bERPQ3ZuZXR2VTh3SThWVjZZNm9sR3AvOTc2Um8xcGVTMW56R2pLSHJhZjN4?=
 =?utf-8?B?SkhKMnZGelR5RVV6SDJuaFA1N0h2dEJxMXZlU0UrbG5xTVpkeUZhTXh0YzVa?=
 =?utf-8?B?d21MRjhJS2VsYTJKcWE4ZGIrRG9QUU9vaENweDNjOG9zejZkREJGU0NPUzEz?=
 =?utf-8?B?UlZ6a0dLSCtQQzQvdCtud3lOZWxXQnRzcEpjclB1d2pTd1F5SS83VDhnakJB?=
 =?utf-8?B?VjJzY3J2azAvdVFXOU5DdWhXQjFac0FpL284K1FkTmo0YmVoaVFZWGpSNm84?=
 =?utf-8?B?T25QQi96TTE4UXZFazcyR1RoT0R3YkRhL0pQMXAwRCt4c3g1U2E4bnFWek84?=
 =?utf-8?B?WHk2ZllRNEQxS3NmNWxLcVA0a3BJcVY4YjZOUkVISVlFa0J0OVJiMDc5a0pN?=
 =?utf-8?Q?ObQU2lk782Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPFDAD84AB72.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTVtelBRWDliS3VRZk5zSmkvQm5MNnJJRElobSt6bnZldzAwU0FrM1NNaVlj?=
 =?utf-8?B?dGZad2xaY1RUOVpqUnU5YXVzYzZ6NTRmUlo0Y2ZXcVBvelZHeVpta3EzMFNm?=
 =?utf-8?B?dzVLZTVEa3pvbnhCSTJOY29nalNOSWJKTUdzbysvNGdESkdUOVZjWVdpYjFF?=
 =?utf-8?B?VnVBaUJqYkVLVllBTjNxWlVzemw3TTdoOEx5azFVZXJhNG1mMzQ1U2d2SVVR?=
 =?utf-8?B?L3VHL3YvdFFxL21LUm1SRlU3dVNJaTNQS1Z0eWVxK3lCczBadHFSZG9wWDVz?=
 =?utf-8?B?TVBIWnZrdkZjMFlXblN1K3lxSklMT3ArNE1wTTl3UjNWQzcyZ2JSTHBzWCsw?=
 =?utf-8?B?c09BSm9CTjZCNWtUNDVWdVFYVzdzeVFqY0NiWnlEWTVhSGhrRHk3QnQzMkZY?=
 =?utf-8?B?b3VLc2dGc25CUlNRWE5nOWZ3YThDY1UrOW5OU0hSd3NXTnowSHVGM3hUTzdF?=
 =?utf-8?B?ZURISUxlb3grWHN2cm5pWGxtUlNkS0EvL0NaRGFUdTY2ZXl1bUhIZ09YM1RU?=
 =?utf-8?B?bFhCd2Q5NHhOWlBwT2VOa0VablI3UEpwRHNISU5MSzVoWVpVR29FNnBZdTVz?=
 =?utf-8?B?R1AvNENkYWhKV1JEblJLRVNXUElELzdGcENXZlQ4czNwcEd1VjR2dDdsTTFi?=
 =?utf-8?B?WVpObzRLVmQ5SW5kb3BWYm9sSW5nOWlPWEk3UERpVWh6dUo4Zk12RExtR1lT?=
 =?utf-8?B?aWNBLzVFV2ttSGRPK1NsWU5vb08wSXlYL3ZmUUVyUGNWcFBBYnBkclZtd0Mr?=
 =?utf-8?B?ZFVoWWxSb3NWT1NBWmpZTFlkZzdDbGlqb29ZSkE5Z1dMeUsvaEorem1TQVV3?=
 =?utf-8?B?Q2JFb25TMEprM0hNT0MyalV0dEtSSG9kRHVOZG9yRDNNSWQ0UDdlQ1haYUlW?=
 =?utf-8?B?UGdNK29KTXNzYVlhUUkxUy84WlFGWEk3RlZHTTNla1NpUFBDa1ZhRkRIVFk1?=
 =?utf-8?B?dWkzQjg3ZHlyNElUVTNoK3Q1eVN0WTRRci9nWW4zLzdCZGdQdmNyaVBQNXA1?=
 =?utf-8?B?QTFQRk1TNThkRWFXS01tcCtkMWt4U1lUUzFPb01sK0diSTNmL2ZYRlpvRlpq?=
 =?utf-8?B?dWtuNU1xYXQ0dkVFTm9NY1QvMjZTL0NROGpFV096c1N0VCtoQ3pwdXAzaVVJ?=
 =?utf-8?B?c2tDVGFwc015azRLbUYvQlY4czBoS2RTWTJHTDJUbFVIWExBd0E3VkRvOU1O?=
 =?utf-8?B?WmdOYnkyOGxvcGlYVkloZ3A1QUlLMG9DRjRldXV2TGdyNzBUaWxxOWYvV1Rl?=
 =?utf-8?B?bTRxM0RwbXozODA2R3hCaTI0dE1PT1VZVmVVVmNlbWl5VzBySXc1aHBxa0V0?=
 =?utf-8?B?RmhpcDZudHo0SnQrdmhTSk92OTVTeUdKZ0s5TUhzdmpLdUNsQk1SSlVRZHJt?=
 =?utf-8?B?RGdrVTBvKzZzUU1oZU5qTSt3YldwUHVZaFJBcTMvTWdWcjJReG1oenNZbkh0?=
 =?utf-8?B?QWZScG1zN1ZMWlBlTEVtWFhUOHQ0aHBRMytzTDE5Z2I2eEtNeUQrSEF3K2V3?=
 =?utf-8?B?WXBDcHd1YUovdGRGUnE2dGlQcHRXYkMrRVFVeWUzTlpSYWFiM1hwSHZzejQw?=
 =?utf-8?B?OHR2S2pkc0JrR0Z4bG9PdDh2QWpRSzBPSVRPd0RSY2dza2RXdmJyRTZIMnJa?=
 =?utf-8?B?UVN5ekRPOVdyVEcxdTN0UnVIUFF0V203ZE4yQTBCTCsyU1FQYzZpWlQyS3BY?=
 =?utf-8?B?M2RjdVliR1hyTkxrRlAxdlZ2TDhjR2U0SUg3RjI0Unl6cjBBVkJ1aEp3OHd3?=
 =?utf-8?B?WlRESkNnZytyT2dqNUdWR2s2ZDR0Um1GVXRxanJDb1pkUXV1NStHaDhVQ3gr?=
 =?utf-8?B?WWZGNUN4UXJic0R0NjU1V1pwdCtBaGt1VU5yZEpjT0tKOWJqZjdSTW1vYXdG?=
 =?utf-8?B?SGZGM3pjMjM1ZTZleGNEcmhESmJUaUFycHZOS214eXNOQjVJNXl1TUlwRll6?=
 =?utf-8?B?UHgzZ2NYQkM1Qy81amtSQW5lMFlaMzlFTmIzdXNIL3NDQWU1RkV5ZnlLSXFU?=
 =?utf-8?B?VW9sQVREVlVmY1BhcnFOWG8yc2FhTVVkN20ydG5yeFc1MmRtUDNXdDBTYzJu?=
 =?utf-8?B?NTZqWUxGT09UQzcyY1JMZ0hKdE9wWnptcCtrd0RJdWFqandXME9jTXlyanBV?=
 =?utf-8?Q?Ueqx8BoIAk6R+e8pv8hLpfdzu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e613711e-6676-42d1-1f43-08dddc34866a
X-MS-Exchange-CrossTenant-AuthSource: CH1PPFDAD84AB72.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 19:47:11.0152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QysRpcHUavWzYT46NcdfGxR88S0+m756lV9LZ+bTwAbJZ2N70eENTHh7Wk9+JFrutWcPeW85Qkod74KwI8KTnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864

Patch 1 Adds the binding for the Nvidia mgx cx8 switchboard
Patch 2 Adds dtsi's for the mgx cx8 switchboard itself
Patch 3 Adds the dts for the mgx cx8 switchboard motherboard reference implementation.

This is an Aspeed AST2600 based reference implementation for a BMC
managing an Nvidia mgx cx8 switchboard. Dtsi files are broken out for
managing the mgx cx8 switchboard over i2c, so that others may reuse these
if they choose to implement their own board. There are two dtsi files
since the i2c topology is not symmetric between busses going to the mgx cx8
switchboard.

Reference to Ast2600 SoC [1].

Link: https://www.aspeedtech.com/server_ast2600/ [1]
 

Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
Marc Olberding (3):
      dt-bindings: arm: aspeed: Add Nvidia's mgx4u BMC
      ARM: dts: aspeed: Add device tree includes for the cx8 switchboard
      ARM: dts: aspeed: Add device tree for mgx4u BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dts    | 1078 ++++++++++++++++++++
 .../dts/aspeed/nvidia-mgx-cx8-switch-north.dtsi    |   80 ++
 .../dts/aspeed/nvidia-mgx-cx8-switch-south.dtsi    |   80 ++
 5 files changed, 1240 insertions(+)
---
base-commit: 7bac2c97af4078d7a627500c9bcdd5b033f97718
change-id: 20250813-mgx4u_devicetree-c2e130607089

Best regards,
-- 
Marc Olberding <molberding@nvidia.com>


