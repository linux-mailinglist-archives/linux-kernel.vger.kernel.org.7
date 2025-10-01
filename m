Return-Path: <linux-kernel+bounces-839174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA07FBB0F8E
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FE332261F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660D530AD14;
	Wed,  1 Oct 2025 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PAQiPNDG"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011037.outbound.protection.outlook.com [52.101.52.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105CA309F01;
	Wed,  1 Oct 2025 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331036; cv=fail; b=pS+9oIzEJTrJyeYsAiYAXL/7Lgu+NglnGOekg50LtFo3GA2XJJPD3c8RYsulekqPVWsuKPJ8vPN8qnhvJ/ZubFPtlMmKlCRkGk00CiztVauY9hKkH7gHwzGiNPKxAem5nZfKNQo3LtSmG8QtqnMuRPmBcXcwm42yqTfMgpJCyN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331036; c=relaxed/simple;
	bh=Qia2K9aV49B2BiZbrpPEda70tg96Fnrm3ruH4N8e2D0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Gm730l2I9HreYDKX3bj25xwsLK/use0AWIv8pTPKTsGBHrpAAot/v9DZQhzXrEiTO4FWmxmPp3fhBw+HSPhJvm4awvSWSz5LcEikm8tvm8zeZD2qjPhOj347QpiqXJxiZejddQScl7lorg1VxVUrIK8lVb3ZvS/8jT8+54IxYGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PAQiPNDG; arc=fail smtp.client-ip=52.101.52.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTB+AdqhaOYNHnjeOiy/szdcqL2+eHWWNdA+gpbh15IBqArDCvUKbo12FXHXD1LUsk0ArfmAbIXgGWpwIHs1yGuk+dtAksK42yQCQKbuhSGMGa4gliruJnB/oTXd5CBtBKJkjLy46GHUX167wGsDCsyjvrJJPnRFQGAQVZJXzyjPHxItPldlOr7y0JuY/lb/yzQ+HYSL9ccyvRC5FBnDD+OHx1A+yM7wA3idab/WlDm2la+wDJ0ScH2dciAK0y+TJMkk/jFA6X/LMztlms+ty1h1cSmrHBR548r7sKs6cuyVyKqY2igIEwf/4aXN8mzhLN4U31naz3uCdPV/bGKReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SI1frVGiOhgYudFZlCnA1DD9wCq/0WEvwXX+xyetreQ=;
 b=dftKO3i1WTKeECdqkAE8m7+xddtNhIBkDyRT87FrT4une2+eyVM4eFpS1IUbtSdmMRdOsJvLjpNhUJI4CkItmxYMcc5RcvbPoSvhNXS6HiLuFGm0xq9G0pxFDKoy/EdjeQey4FR48iN9/kVN/Gj5rnByYBGUgEoyN3JY9fhaG6HNt6mGMjshcCjqnWZooIN7t3YC1iqWc3aUt3CwXN3B9/dhDa/ZbZNliXfcZMtKqcExma3oXplai8ehiU9H0+9tzlyhJpmws7AkoyIfOmwVDbRo+f9OcDmGCYCwtaRKnfGtpmRd1mkn288vcc5t8I/YFo+axMdf8Nt/szWBL+ykIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SI1frVGiOhgYudFZlCnA1DD9wCq/0WEvwXX+xyetreQ=;
 b=PAQiPNDGBtBbBmc/yLT11UnUrpaShp977EVeTAMIMZ8qDQ0Iakqm039FFMIMQDovpG4uP31xpZvnFFFjU5lylt7j4IKTraaOEoBYSbSBkJQl5KhdaPCEHICwwv5vHefpY7uud11EPv2R1VjhBDRyDVshe7xQxYlgaLadlEz4LTlXlKf4T0Z8ZpIsqCxJUFHwezKBr0f2W9lFPMPtEhgjsM811dUMOwjA2RHfjRgKFnqSD6mStACuifUEBSWvpvMAR/DBJFWkFA2OwwEo2dK8ztjpOlf978Cv2grAcmpVPSi6MQOR89NbQtZznXpmFOpyUiWETnNTHXZGvONiocuGSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ0PR12MB5635.namprd12.prod.outlook.com (2603:10b6:a03:42a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 15:03:48 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 15:03:48 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [RFC PATCH 0/2] rust: bounded integer types and use in register
 macro
Date: Thu, 02 Oct 2025 00:03:12 +0900
Message-Id: <20251002-bounded_ints-v1-0-dd60f5804ea4@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALBC3WgC/x3MQQqAIBBA0avErBNUsqirRIQ1U81GQysC8e5Jy
 7f4P0GkwBRhqBIEejiydwWqrmA9rNtJMBaDltooKZVY/O2QcGZ3RaFQNqbD3pJuoSRnoI3ffzd
 OOX+//Zf8XgAAAA==
X-Change-ID: 20251001-bounded_ints-1d0457d9ae26
To: Joel Fernandes <joelagnelf@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: TYCP286CA0167.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ0PR12MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: 03678604-b4e3-4d32-e69b-08de00fbb980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2wrei9mUnpFcXhXSXQzKzBlR3ZueVdKZERDNjd5Wm1JU29YWDc3aWs4MEFo?=
 =?utf-8?B?aUEreWRXNm5pS2VWM2tPem5iaFM3NTd0c2xDNUUwN1VYZFNYQ3V1dWRtdG1Z?=
 =?utf-8?B?Y0p4QmNML1BzeE5TU3FsSFRLemFsYkZ4V0FZV0xiKzJtbE9CRWdoaSt6Rjk3?=
 =?utf-8?B?Q3VZQTc4M0hGWG9zdXU0Qyt1N3ZBRFdkNkZBdysvUGtkNW0vMTBnbXdzNUla?=
 =?utf-8?B?VlNvV2w0cCs1UytYc2FBak54YWJNei9WZ3ZEU3pJWFcwRHdBOE5LcmUyaXhD?=
 =?utf-8?B?MmQ0YnRsS1lzNFYrdG5NTzFlV09zSXdMYUZ1em4ySkc5QnlwVU5nVDJWUXJX?=
 =?utf-8?B?SC9oMUlJUXJPbG1TNFZZeGRDUFpVQVNMVE9rYnNBQThBTW4yTnZRTUsxdkpw?=
 =?utf-8?B?Mlo0Si9oOEwvWm1pclk0K0x6NXlOa3pQRmZkV29zR3pQV2E5MDBtSzZFZk1n?=
 =?utf-8?B?VWh4anZxM2hHWENNM25OcVZTWEFBZWpjOWlPTE5sMCt4VGhaSXVxZ2xwOU1j?=
 =?utf-8?B?NjY1MEdadW1BM0xlV1BIMEdSVE05eStPZ3pzWlp6NjNoTEJINkt0ZXZ6VFJu?=
 =?utf-8?B?ZlJJSzIxQ1h6MnlaTmRNdzRkbWhydlErd0RoRjVUemFMYWNlaTl6OVF4Y2E2?=
 =?utf-8?B?bXRzem9qNC95dk54dldTYWhpZXo0cGtyeUlRZzk4SmY1NW5QMjc3Tjk0Y2Va?=
 =?utf-8?B?RngvclNjQTRxa05hOW1Hd2JLMW5GcXpkUDZhMFNYK29jMVB3MUtRb0lVM0tJ?=
 =?utf-8?B?U05lSlFhUWlSUlZhSXZCYkJ0SnZoY29iN0Q4OTQyUDlGb0RZK2ZWRmh5SHVU?=
 =?utf-8?B?a013akN6SlZock03dGMvUkF3R1lDc0ZuN0FkRHVpeUxselZ4N2JpbjZEUU1H?=
 =?utf-8?B?MzdFR2R1WTVSalgwenhoakJNaDJiaVcwQTNJd0FTY0ZrVkRpZWdnckpYMk1a?=
 =?utf-8?B?SGVoVGRReXNqR2YybTBVNkt3Wmo1bzhoTWxjZ2J5VWhsaXVVbm5VdG8wRXJ3?=
 =?utf-8?B?VjFsNWdSQXR2T3JhdUpOZUhZQWJpV3A2NStJR0xTOW5VcGlnR0tGN1ZOMkFs?=
 =?utf-8?B?WFM0ZTF3NW9WUUxvaFIrWXlScVp4SjFjRFhkeUJtMkpqQ1VyS0lPTEY2MzRz?=
 =?utf-8?B?Z2k1M2N2YkVYcE5uZ1NnMEpwN09PUXBCamNRamdpMDZ3WXZVWDFBWWFHUzQ4?=
 =?utf-8?B?aHFwRzRBQ1Fkb1hFcUFMd0xBbzhGLzhEcVAyVi9GWkU5YVdWVnljeWlYYTlp?=
 =?utf-8?B?dlRmWVlWK2g3cEpiVVZKMlJFTE5XQThvY1FZN0krWmJZd0JrQXBoQWJuYlFT?=
 =?utf-8?B?bjVDbUwrWnY5Wi81OWVyWEtYNVZ6NkVrYXJLMXNqdDdRQXNGU0gzbDdobXRr?=
 =?utf-8?B?NGZ3WkRGRFZnU1R2Q1AzOVkyeWx2Y3lPekJuOFZqMGhyRWRremEvaHFDL2k2?=
 =?utf-8?B?UUVmeU02VStoSTlzWWhDdGswUTJHamJHUTgycVpzN0J4bEN0TUY1VWpCUEo1?=
 =?utf-8?B?NnZucWhPWUZHQkNsdlJJWmRROXhTMGt2d3J4N1RmTmJTcEhNenlSbGZaV2h1?=
 =?utf-8?B?aFlxSm9HVW85OG5aaUN0emJJMGkwRFBaWEpkZm43M1RNQ1FpZEJCLzdRT3hj?=
 =?utf-8?B?Qy83ZjF4QThMRmQ5WHlNZW4xQ1BnVUJBS05laHVJeERhTnFuRUtwdlJNNyt5?=
 =?utf-8?B?clUra1lTMVhnL2IxK3RVSGdPdnNoZ3dBeFdxWGhKTEI2a3pKMEhKZUY2L0Zl?=
 =?utf-8?B?dkJMMC8wQmxycVR6c25MN3pSQ2FCYVk1dVd6NHN2ZGxEVG85dnlOY3Uvc2dL?=
 =?utf-8?B?VkRFVnVOTXdUNnExQ2YzcWIzNnRmdHlYQ3lBMHJNNTFZRmhyQmtyVmJOK1dT?=
 =?utf-8?B?anJzWTd0T1hDK2tTM2JRZTN5amkwM0ZWcTByOU9kWlQ1WGdTWk5BdlVNSy8y?=
 =?utf-8?B?TEpwelUxWmRmWFB1c1hmVXJ6aGF2c0FBenM1TU9IcTlXK2VJRGxpSFZnTE1O?=
 =?utf-8?B?bHR5RlRINnVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGVQMEVra1lOeWhPYzg3ZGpoZlJHZWVWYVVHMTZVM095WmRSTGRwUHNGSFUv?=
 =?utf-8?B?ZEtNa1p5Wk1BUFdoM0doUk1qVW4xUFhIVGFtdzM3V3Q1YjdDYzkrSDB5UWk5?=
 =?utf-8?B?RTJIVEovOFVUemRYYkRXRXZlS2dzR2RNbTJQY1o3YmM4VVJXeXZhdkM5ZXdk?=
 =?utf-8?B?WE1hcHI5R0hLMnV6NTBmOTZySi84V3F2bEsyVk55VE1vV1pDMUlDQm95ZExT?=
 =?utf-8?B?WnhMaWpYeStES1NDRy9iQzBaNzNmbE95TW1zNzRVL0RNMFBodmdQVEhmQjhB?=
 =?utf-8?B?YWMwaVJucllBNGlkZHBIYks4dG00RVZoMXlYK3dNYjFrZkdaUU1iWTNsSWpY?=
 =?utf-8?B?cmNVUUFhWHRWZzlrNTNXYncwYlEzd2prei9GYzRJcnZwQmI2SFVYZFdrbldK?=
 =?utf-8?B?Ry8yWkFGK1N2MmpFNVprQmYxUmFVOHJPZldTc1BBMnUxQm0xREcyR1p6YTMz?=
 =?utf-8?B?U2FPR3U5alNWS2xlOENqajN1ejV4UjFlVGhLUWF3azRQMklJbkpXUFl0dEFX?=
 =?utf-8?B?OEFuT3ZzaGVBMU5qVGZLKzhCYmtkS09QamJ5SWhsU0hJYUs5K0U5UnVZWUpz?=
 =?utf-8?B?cTZkK2haclFBVGxrRWM5dDhWdmlBWkFDc1JkbnFWcyt0QU5hUmlvUE9Dekht?=
 =?utf-8?B?SnYxVTJod3ZQdG9TQ2wwcktEOERHL0ptN1E0aVZjc3pick5QbGJ5eHFERTlp?=
 =?utf-8?B?OFJ1L1JJUHVJclVWYVBERk1IaUtNdW94SVBzc1VDTnBicTZuNmdMRGRRR0Zy?=
 =?utf-8?B?Vnd2a3pYMW1hNHM5NVB1dHpXTzZ0R2hpamJLUG1FYklGYVVCdk9ETEdqNHpI?=
 =?utf-8?B?b1YrYVRudnhyTEJnYnNmdUtadEZ4S3hRbTRNNElNNVduNldFZTJtdFg5eCsx?=
 =?utf-8?B?NUR6a1k5Y3NyVlR5dkJUM3BHSGh0YUxNeFg0UFcxc202YmlWSEVHVkg0cFY0?=
 =?utf-8?B?UlljWGRLWjVYZ01SbXRKZHRVNjJUMmliUE5BNlVaN29yTGVNK2ZXNWRjNkxY?=
 =?utf-8?B?bnhhMzhCV1JZaUxqWldGLzhCb3J6K095cXlvZm50b25rZFdJRjFoVGZ5cWpT?=
 =?utf-8?B?ZEVrOGFkalJMOU96cnZMZ1lKQkVZRnJ3RmZkVWRqUXpvV0UwT25vMVdVamdl?=
 =?utf-8?B?QXkwdHFkU2ZRdUNrTFowY1ZrYUx4Z0hvTTBxM3dqQzNuY3k5dTZmK2VYcWlh?=
 =?utf-8?B?NXJiLytWMTZWdndPeEgvZzF6NzZSdlczT25DOFptZ05ZUFhPYXU5MHN2Ui9V?=
 =?utf-8?B?M3dpYWIvSGhrdEhTRG9GdlR2RWlqRVRRdGlMZmZQUk83WnRZSWlqbm9HdzFY?=
 =?utf-8?B?RGVJbkNmUXpCa29UejUzTnFtdnJ0S01MdzFiN1pnRWpSLzlNU01GT0lVSmJO?=
 =?utf-8?B?YkxYanMwYmJ2bHJLSGpnTlpDMzFOMWtlbHlQYVlDRXJmVzN5QWdnbGtPZnZK?=
 =?utf-8?B?WGhObjlOOUR5K2d5RlU3ckkwZU0yK1lyRzYrQWJVN0FyUXNramY3b0IvZWsw?=
 =?utf-8?B?NExhcFBYd3MzK2dWSDNqYncvaVdNd0tqOHZnYkxsSWx5TEtIZUVHRFhIbUxB?=
 =?utf-8?B?cWY1ZzZ3eGhoOWNiNTdFVFRTWk9JOGNDVy9oOUJwdVp3SUhGNVhyV010RXVB?=
 =?utf-8?B?NlowTnQwaDFlbkljOElGV2JhaGoxOFFIUkduVHcxcUtVYjlESTJpbk9na0Vt?=
 =?utf-8?B?OUdJZEFOdHJLWmhmdVRPOHRrM21OL2dsTTZ2blYwU1o4SmxwcTZzTnRDeTds?=
 =?utf-8?B?L0VETVFqaUVIeWZHVFhHQUp4emJhd1d1NjlPRlVTbCtpYkZkVkFicVRKUDVL?=
 =?utf-8?B?ODdWclBrdFNXcS9tbGZDOEZPYU1OTXpvRU9XM09RUjRwSVN6SHZmZmd2dFM5?=
 =?utf-8?B?UVc4eXJublJscTJ5c0liVU5oT211WXhUYkRrdWlHNHVINlNRdHRQeWFTUjI0?=
 =?utf-8?B?SEtGT0twQUJlQnd6c2VZQTArcEJUOWtlaUIrM3M0U2JUeEQyRGw3QXRrUXBa?=
 =?utf-8?B?ZE1XMyttZDU0eDd2cFFiTTY4cTRoQjRmNjRMd1B3Z0dTRjJsbVNYRTlDR2Ni?=
 =?utf-8?B?blg5c2ZoTFI3dVZNL3htY1RaQTFWR04yd2VIUzVTZXFBWkR6UDFJTXhiaXZa?=
 =?utf-8?B?aGozRlc5NDBrZTM5cldBbmF3eW01bDFYd0tiT1R3eURWVDc5UXhYYUpCSnhm?=
 =?utf-8?Q?er65q60mYAWvn3fljq7TI7HTr9LGYgQAx2ocJI/Y7dAc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03678604-b4e3-4d32-e69b-08de00fbb980
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:03:48.3911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+dcjzK+dC0l5b0BQmyfbEVTiVZ2HFFB8mFmSEMpoVWCOxVLgb14woh2yuyggISfqPXP0v/dqp2fpSqe2Eqawg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5635

This is a RFC/PoC for an idea I submitted a bit earlier [1] regarding
how to handle truncated bits in the register/bitfield macro field
setters.

Currently, the register macro allows to define fields that are shorter
than the primitive type used to set them. For instance, in the following
register:

  register!(NV_PFALCON_FALCON_DMATRFBASE1 @ PFalconBase[0x00000128] {
        8:0     base as u16;
  });

The `base` field is 9 bits long, but is set using the following
setter method:

  fn set_base(self, value: u16) -> Self

which discards bits of `value` higher than 9 without any error or
warning if some happen to be set. And so you happily start a DMA
transfer from the wrong base address...

While this behavior is not UB, this can also be a source of bugs.
Several ideas have been submitted to not let these unnoticed, including
making the register setters fallible, or panicking or printing a warning
whenever extra bits are discarded [2]. These solutions are either too
risky (like panicking), or add extra code and checks on what can be a
critical path as registers are commonly accessed in interrupt handlers.

In pure Rust fashion, we would prefer to guarantee at compile-time,
whenever possible, that no bits are discarded when setting register
fields with a non-round number of bits.

This PoC proposes a possible solution for that. It introduces a new
`BoundedInt` type that wraps a primitive integer type and, using a const
generic, limits the number of bits that can actually be used within it.
This is similar in spirit to `NonZero` or `Alignment` in that it
provides a static guarantee that the value it contains is limited to a
certain subset of the possible values of its primitive type.

Instances of `BoundedInt` can be constructed infallibly when the
compiler is able to guarantee that the passed value fits within the
allowed bounds, or fallibly using `try_from(primitive)`.

This type is then used by the register/bitfield macros to let the fields
getter and (more importantly) setter methods work with the exact number
of bits they can handle. For instance, the above method would become:

  fn set_base(self, value: BoundedInt<u32, 9>) -> Self

which guarantees that no bits are ever discarded by the setter, since
the type of `value` carries an invariant that only the 9 lowest bits can
ever be set.

It is then the responsibility of the caller to build the adequate
`BoundedInt`, which very often can be done infallibly, but all the cases
that require a fallible operation are cases that the caller should have
checked anyway (lest you beam out the wrong memory region on your DMA
transfer!).

As mentioned, this is a short and early PoC. The BoundedInt type is
minimal, and defined only for `u32` (as this is the type currently used
by the register macro). It should be defined for all relevant types
using a macro, and extended to support more operations.

Also, instead of replacing the current getter/setter methods of the
register macro, this RFC adds two new ones suffixed with `_bounded` to
demonstrate the use of this new type, and change a couple of setter call
sites in nova-core's `falcon.rs` to showcase sites that can be
statically constructed, and a few that need to be dynamically checked.

Note that this is not designed to replace the other feature of the
register macro ensuring we are in control of all our bits, namely the
conversion of the field from/to enum types with only valid values. Both
features can happily work together (and the enum is preferred when
applicable).

Another side effect of adopting this would be that the bitfield
definitions could be simplified, since their type can now be
automatically inferred. This means that

        8:0     base as u16;

could become simply

        8:0     base;

And the getter/setters would work with a `BoundedInt<u32, 9>` (provided
the bitfield type is backed by a `u32`).

This is very early work, but feedback would be welcome. I expected this
to be more constraining to use, but so far the disruption to user code
looks minimal, and always justified when it occurs.

I intuitively suspect that such bounded integer types could also be
useful outside of bitfields. If other use-cases come to mind, please let
me know! :)

For convenience, this PoC is based on drm-rust-next. If we decide to
proceed with it, we would do it after the patchset extracting and moving
the bitfield logic [3] lands, as the two would conflict heavily.

[1] https://lore.kernel.org/rust-for-linux/DD5D59FH4JTT.2G5WEXF3RBCQJ@nvidia.com/
[2] https://lore.kernel.org/rust-for-linux/DD68A3TZD9CV.2CL7R7K4UAICU@kernel.org/T/#mcbf44a779389c3664d885224ca422130b4cec5a9
[3] https://lore.kernel.org/rust-for-linux/DD68A3TZD9CV.2CL7R7K4UAICU@kernel.org/T/

To: Joel Fernandes <joelagnelf@nvidia.com> 
To: Yury Norov <yury.norov@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Alexandre Courbot (2):
      rust: kernel: add bounded integer types
      gpu: nova-core: demonstrate use of BoundedInt

 drivers/gpu/nova-core/falcon.rs      |  14 ++--
 drivers/gpu/nova-core/regs/macros.rs |  34 ++++++++++
 rust/kernel/lib.rs                   |   1 +
 rust/kernel/num.rs                   | 120 +++++++++++++++++++++++++++++++++++
 4 files changed, 164 insertions(+), 5 deletions(-)
---
base-commit: 299eb32863e584cfff7c6b667c3e92ae7d4d2bf9
change-id: 20251001-bounded_ints-1d0457d9ae26

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>


