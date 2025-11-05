Return-Path: <linux-kernel+bounces-886647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AEAC36298
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B3144F6832
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB5B32E152;
	Wed,  5 Nov 2025 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="fn8Bhqqc"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021073.outbound.protection.outlook.com [52.101.70.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39C4329C62;
	Wed,  5 Nov 2025 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354179; cv=fail; b=uipBiNGEH6OUmddycrw6kAiHZ+eIoqLmWS8GqgQEzuayFQVp2ujuosJxJE3BTlaE2XahK5D1XJ8AF/pAmoLNZC91uwJwQ3a8IbWrGYL5yPATodlPEZBo++1jxh6z3NzzL6YmGnm/pnQ6ErLhx/aIxAFK2/qku++oXWp8PJ0TFWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354179; c=relaxed/simple;
	bh=aNS7gd2nb0NcrUW7XOnlRCIBkPl9T1b7+A3pzMpURnE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=R18eN8+/kWZg0ucv5jWci5nywIBM3gMkY+qqq6QsOCLKUhBsGnf+GbPBEV8cMoRG4unZMab3sVkH5kQdHRTX/XsYT5olz5Z6jKUFdpjButNazBFnXpX8k2p4XT/agX9igrG9hH7BuWimVtfEL/UwpZm20YmfzO4R2nLZ+ZBGbMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=fn8Bhqqc; arc=fail smtp.client-ip=52.101.70.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdFhIOjykqGbPghBpcnvinMM7iBxZoWUmmfr3m3cxD40tJMt4xzFALGB41QgnIUg/Z5Mmyee1pbK9iIWadnf1ypWmAAsyGyfH6iNi9dxdDAGj6lqrCl9DjK5c4BmqzO+Ygv5yVia/pVuKLQYvJficda6/eqbBIsfUgSqxAG01TcMmLc9aer2pi70ZJIwz1VQAyVBHXxLFUresrQazpi6cXxkZ7XdCKUtR4FfocRdJAO3DT7Zll6scBPZA1IdyIXZJMG9tt4K9yMIc8UvMIi4alqI6dUFhullhJ6XNblNe8GpM8Xza23muVe+0eLHlE1IiVkRw5VH4+7XKvIH+6NMMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cStEy+38fQSHA7i9WUdoKSX19jl/lN8fZyHrzNOJoY=;
 b=H/YRrPSOGK6fo1MLYWNlVLiM1cU656PAthph96nWD5Al0hSKllNwo87doyPQQluF1CVa4V+Ue5iGLk8aCpkEpwmy8DgmiDGyIiiIdnrdvOizHL5q5Q8mYC6z6cQz6EQbI3OgJ0vBX2epbNGvod+8nsPCQbbILJJ6orU+QZIzC8M2HDv6R6Jv2aX1Hghc+pGSeuHEBx6lCDDB4xU+F+EMtmIaDHu+x5P1ntRJX2MDurKG8q19hniE2B0eKxmWBd4yEC8vAKXO/Q5VvNX6VwqY/eRvizo2G89YALKdf6Mli5/EDkxnqTp5PAzktH+XPzVRM63DB3Z/cbCSl4D/486cLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cStEy+38fQSHA7i9WUdoKSX19jl/lN8fZyHrzNOJoY=;
 b=fn8BhqqcgqG7m2z/HnHxv1GPEZDfp/rpLot+bymbW4Dm9rPe9qUZZn3Hn38X4EgtGWqqwPFwNRwZKoIohABOOAI4e2x0umswQOkT2X20sBE+usfhUcIJxZ5B/agRy8CPPQkuWK4QGKWuq5VZIDizDit7xFQgTBR0HxQUPRg3fQ8TjxnWQ3IgEOmRC6hKtUPAOkh5tdri7UtSl/U+bFwQ8Kk4jKNR4wSe/uy0vqeyC5u+CaFEtcD6QsgIYbczave5nsGz8xJLgXe8EW1ud11+uOsdh3Unu0ZXMKmVbiXlykI+JNuOND0IYMfW2Cc8xLKGslw/Mx/X1XVZUUL5vwCkAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by PA4PR06MB7215.eurprd06.prod.outlook.com (2603:10a6:102:fd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Wed, 5 Nov
 2025 14:49:27 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::f8cf:8122:6cad:4cf7]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::f8cf:8122:6cad:4cf7%2]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 14:49:27 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Wed, 05 Nov 2025 14:49:13 +0000
Subject: [PATCH 2/2] mux: gpio: Add external mux enable gpio
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-add-external-mux-enable-gpio-v1-2-e59cba6f9e47@vaisala.com>
References: <20251105-add-external-mux-enable-gpio-v1-0-e59cba6f9e47@vaisala.com>
In-Reply-To: <20251105-add-external-mux-enable-gpio-v1-0-e59cba6f9e47@vaisala.com>
To: Peter Rosin <peda@axentia.se>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762354165; l=2633;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=aNS7gd2nb0NcrUW7XOnlRCIBkPl9T1b7+A3pzMpURnE=;
 b=iAb5WzHtw9nHgr1rEAJXl0SA/i5kSP39PBbG0cdS4dvA/LqskrqTOih+G3dPNxZeEQdGebNzk
 csuR9NZOP5GC84bUDeyoLh+kU18TK3SRZxqib0vStpQgxr02Vs4xNBP
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV2PEPF00003826.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:5:0:5) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|PA4PR06MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: bbeef974-9cbc-4e45-4b71-08de1c7a8499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnpFRnR3MVp6RzdRUU9IVWhIeXFLSUM1VXBnUGtWZ2xYOUNJVU50Q25vQjBE?=
 =?utf-8?B?SGpYMTc1MWt6VnFTUjF6dnBSWWR3bE5BaXFhQy84Wnh4Tjk0YTJDTkVYQUsz?=
 =?utf-8?B?VjVXZ1k2SDlMVEhzcGMreERwRXEzLzZMb3BpRUxoU0FtU0RrSmVtSk11cHhF?=
 =?utf-8?B?QkJUblk0MFo2MFp6clFmWXZ4T2hJSFBZYVp5ZXVJR2FpSldzS01XaTBSaXJi?=
 =?utf-8?B?MzZpbTBndGxjaXh5Ry8xTjhkRG1hUk1NTFBMRGw5dlNGSXJpTFVZcTJ0Z25K?=
 =?utf-8?B?N2pqR2srWTlyVGlJWmdrM0N1RGhqdFNDSzMwbk9ZK3Vocis3enlCczlBSHQ4?=
 =?utf-8?B?eFBOd2NaSE9mcVgrMFVMTWY2TnNxbTIxS2JrUmZPZHJQNkREY0NlNTF3V3pK?=
 =?utf-8?B?YVI5SGQzR2JSOWZFWGFVajJWWk1EQWI4S2tCYWtEby9IVEd6Z3hla1RHVVRV?=
 =?utf-8?B?cDRCbFhkaTBpR2tTMytCeU5Wait0M0xxRHB4Y1d3SlNrSGVuaHRkR2NkWXMw?=
 =?utf-8?B?K2FtcE92RTdiTmpLSTJFWTQ4bmxnUWdNTHhHSG9VUzlvVjltaENSRVNIVGZM?=
 =?utf-8?B?U1JDSjJMTWR6b1pvZTNDSzdUQWdXeHUzTGpNekpDNUJXdTJlbGxYMnV5cUlz?=
 =?utf-8?B?a1NlZysyWmMwQlNqT0REb1JCSkFhSjNVN2tMVG1VbFAyOTcwcy8yRFp2OWND?=
 =?utf-8?B?V3VhOWhKSjZxS3ZncUtFa0ZNZzlUbnJBMzNmRHZlVnlmNWgwUzZMWGE5aHp0?=
 =?utf-8?B?Ym5iOGlNeGd1YWwrVmpXbWdjK3B3alBCTHZGL0pmQUM3UUpUS3JwS2NkR2gz?=
 =?utf-8?B?OWN6cHQvcjBrTFpQckdSYVBEZjEzMFVCTk9QM2crRGtISmI2ZHRYZ2VTMVps?=
 =?utf-8?B?T1BnSVFxNnYxYzlZYlk0WkhlRHhIOWF6U2huaURKdEpvMDljYktyazBNa3Jy?=
 =?utf-8?B?OGV1czhEM1Zkc2dwdGdVZU1WUWFGNHRyM0JRVjg2VFd5NU5xbmNEVEIxS3BS?=
 =?utf-8?B?b0RPS2k3eHVxUURSbEM0aWVPcEJ3c0E4clNYY3oyWDV1THFkVVErU0hsUGVD?=
 =?utf-8?B?bk13czEvcGw3UUMrN1hzNTR4TWd5c1ZKVnBqUWRsQkZlMGFHaWNYckhIK2pp?=
 =?utf-8?B?RHNSZXJsOGg0aVlzbTdYUXU4UFNrYnY0MDBZQ3phR1dmN1FsUm0xdnJqNDgz?=
 =?utf-8?B?cnFydkg0MVlhNlN6TzBZbzU1cjZlMWdUc1I0MXFyY1pYb3hDdFJaOXFCR2lX?=
 =?utf-8?B?cEVsbjNsMXRMZkNsRm5neEZiaW1oYXR0T1ZJc1cxQUFxdTZwUldNWjVFVU5M?=
 =?utf-8?B?b0ZvMjQ2ZkEzTWJ0eEhzdU10b1orOXB2dW0xMGV2am5JWjh6U2JkZXpFdWN4?=
 =?utf-8?B?RGJzR01WUGZ4NFJEOWF6bVpBYmg3cWUxL1pvYUprcDMxc1h3MEZBYlZNbW9m?=
 =?utf-8?B?UEJ4TWZ6dkxEaUlVNmZLMFBzc2hGSnhyTXRJbzFwU3hGeGhGRk5IZ2NMUksz?=
 =?utf-8?B?cTUxRjMybVMzNlZPd1p5bVFmcFNHU3ZtSE95TTFaVjJnZ2diQnhYVUFoNllj?=
 =?utf-8?B?RWxWeE9lZm85cU9ob3FJTFplTXdqYllUcGx2WllHUzN5T3pVSjRjcWJVdFVZ?=
 =?utf-8?B?ZTZOMWwyeHFzcWMwRi9ISFpYSVRic1RsU0xEaUw1aTJtbTRYbmMzNzZrYm5E?=
 =?utf-8?B?WkVteWpuR1QrcXhxTEhEUWJjSStLVG10K09UVEpZS2hCRlg0VXdNSXNLTUpE?=
 =?utf-8?B?UU5wMUZ2bWp1MUUrV2tZZ1p3SzJGVC9xdzFxOGZ4eEV1WTdKbHRkVFMySldh?=
 =?utf-8?B?WDY2MS9YSlFsSlZVNDVoTWdUbjhGQ2syandjREp4MmJjOGpYU2ZLZ292Ritr?=
 =?utf-8?B?N2sxd3phNklveE9kUTBUWjRjaDVGQmc1KzQ1dmNNUHRuUEpIckRBRlV3WnFI?=
 =?utf-8?B?cWozL0k2MzdNZWQ5WFREYkEvN3ZwOTVzSVNOcmJsdnB4OXZVek1XRzBTM3VY?=
 =?utf-8?B?ZWZZa2FURVZ2VG9FWVBKNVhwYWx4UDU0YWtpQko4NEt5MFFXUW9oWHd0L3ht?=
 =?utf-8?Q?fRQRFm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eENrMW9MdHFheS92bU5MOUFqUElMbUZjNHVWU0MxdllrRTc4cnpJZVZubFdj?=
 =?utf-8?B?cUozcldxUkdvdTE0RDJEalN5czFrYVVPVXI5eHNVajZOWEFLY1l3NTFjRTNy?=
 =?utf-8?B?Q05xMjZsdEJUQ3BpeFIxRTVneEQyR094U0FqcW1ldDFVL3F3WitVK0RZL0pz?=
 =?utf-8?B?cHphWmJ0bUFKRnFZd1ZZZHZuSWFTQVRVbjl5TFEvTmcrR3RSTk1KWjdseHVh?=
 =?utf-8?B?cldLZVRjMFBxblQwUlRhRjV3TnNyYmtnUmgwcm5wNU9teFpYZ1FkOG9XV05H?=
 =?utf-8?B?OEFwNjU0NlZZeU5IYjJBWjZDSDhyYkpVWmowTG5xb3h1M0hXelQwdDMyQzEx?=
 =?utf-8?B?M1dQc3pCNUY4YU5OSEZzUnE2MWZrZ2ZWUW1IK3ZKMU45QmtKdEVnOFlKaWxm?=
 =?utf-8?B?allicVVieG5CWUdUeHVIZHJINmlVVVdKYWxzbVlGYmlIT25tVXZ4c0FJVzFY?=
 =?utf-8?B?SG9PNXlDbVZmUklWSlQ3bXBSL2lOd2c1eTVjWTIyaDZ0Y3ZCaHh5NU9kcG5G?=
 =?utf-8?B?Um9zYkJFTWlPa0tlNlB2N1RQbmt2QmVHTDFQUnhrUXBQUDFmYlhvOTVFejAw?=
 =?utf-8?B?Nm5JZ0c0SFZhU0ZRandQZGtYaFlFYWpLVDNVTzkwZHl6cWJ5aWdQeXhZOFFp?=
 =?utf-8?B?YmNaRysvdmVQYTNoZkh5d1RKeGg2cVA5TURwS2RHRmNkZ0NMU1ptbytnbjRE?=
 =?utf-8?B?REFld25vMFNtcGo4Z0JMOHBad0svQ2FTYXRvOHVsNkhSYmNvdmNrTHp6bWRq?=
 =?utf-8?B?bWpPWDJydEdlbVVsSWFxVjVhd1lLU2NuRjRPajBmMllzMUdNVkFyZ3BmOW1x?=
 =?utf-8?B?djdoNERSMWxQdVJCa0NBSW95WFpvZ1FOdHJSb1ZneEQrNFBvckRjSXJMQjJy?=
 =?utf-8?B?ZWNWeS9YS3g2Y21kL1YvYUtnV1ZHMmRKdEZRMU1iNzBkZ2JzQUlsRkVGV2My?=
 =?utf-8?B?YnppN3c2UzVPSlFhc1NaL3NoVlZEZWJoRWZVK29RMVgzdjlHMEhxVXZiM3Z3?=
 =?utf-8?B?TUpveEhvWTVkQ01ZWjhJRklhUU5NSkE1eHp6U0wxK3VsRUxaWFZWbytMaWdV?=
 =?utf-8?B?RCtjT29BaFU2cDBHOTk3bUNvVGdzdS81NnZMV21wUTJUeHgzRkVCZXJFWnJL?=
 =?utf-8?B?QTBqdnV1M1VEUXkrWmZCMzlqZHU3dEx3VkJNNXRFbkhqVzRUcWRScGNHM0N3?=
 =?utf-8?B?MkgwaHl2RTBHOGVVcW9NZlNFNlc1NS9kTTMzbHpyaktGQ1RNNGdjaDkvcWNS?=
 =?utf-8?B?dDBCUTl6ZmJrWFhCd21NQUJtNTljanRONjRWTE5wRUVWT2gyYXFDS0ZOcFJZ?=
 =?utf-8?B?ZXMyaGN5bWo3T3lYaS9nZUovSDc5aGpyV1pQZjhtM1dhc0M2bEJoeGRQQkox?=
 =?utf-8?B?S2FJQmVickJ2V25Va1c3dkJHdnczNG4wNjhRQ09yeE9sV3V4NGpsSitRMFUw?=
 =?utf-8?B?djlrSnpnSlZwdEs5OHRRUEl5QWVWeGlOZmUyWVV2VFdZSWVKWm9iSWpyK0lr?=
 =?utf-8?B?bVY2bHIxVmhBdlF1MUVjWmxkeXMxNDhNL0FxTDdkQXBtQUd2NzRwdmsxT1VJ?=
 =?utf-8?B?YTdtNm9CMVBwSDlaR1I1Si9MbDNtenNFS3VoRFUwd3Y1VFpPSk9wQ0EwRWRm?=
 =?utf-8?B?YUJqTDZPbXlwSVR1RjlxOGpCMk5xUzJnNkNOWnJUWjZJTCs2SCt0UnBrWVh3?=
 =?utf-8?B?WnFnNFZEa2dJSFp4eFF0L2hKVG56VGlTcE8rbVNDekRmelBZdElNclJDT2VF?=
 =?utf-8?B?U1VkdVBIZFBLbUF0ZG1PSFRJS09OYytFekdocjc3b0w1YW5PcEtrYktUbGsw?=
 =?utf-8?B?MXE5cEZjOHdTeXBua2M5VkdNNU02WkZqd2lKUTdRUE9kZm12c3lEYXZvejhK?=
 =?utf-8?B?dUNMNGRRZFE2blBWeUtaRjlHbGlUcjd6UGlwTzZoZzZtWk9kU05iKzdzWmdp?=
 =?utf-8?B?Rkx0L2xSdDMyQzdpbHNKZ2g0bks3K0dMaG4yeFBQMzNnZzE1S05RWGdYQ1p3?=
 =?utf-8?B?SDhEN3VtTUFpVHJxaWZmMXM2M0VGTEVVWU15aWl4VGFNekVsS1R5WXZBOFJY?=
 =?utf-8?B?dnFBci8rS2JMNzRodGFYTy9ldjUxWHRzV1JmbDZNNnhkejZicHJSSklQUisy?=
 =?utf-8?B?MmVsYmNwQUZldXdKbS91QUhGc29LZ0x6VC9jMXFmWDdpSGhURitWQkpmRkdI?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbeef974-9cbc-4e45-4b71-08de1c7a8499
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 14:49:27.2227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFZBIUSlbr4lHA0nvdB52+9/akGcsVcC/mnrUOe1BGcexSE3PRKKMlNfmDmkNAyAbne0FNM6rKrxLBMxDu9XjM/Xslw5TqADy1GTet6rqwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR06MB7215

Add optional gpio to control gpio-controlled multiplexer
gpio pins, according to the state of the mux.

When the gpio mux controller transitions state,
it first configures all required gpio mux pins,
and then sets optional enable gpio pin to logic high.

When gpio mux controller sets "MUX_IDLE_DISCONNECT",
the optional enable gpio pin is set low.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/mux/gpio.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
index 4cc3202c58f364e80ad9f632763f568d184d4173..ee2bca1214d67feb3031fe60556b68b59293f0e3 100644
--- a/drivers/mux/gpio.c
+++ b/drivers/mux/gpio.c
@@ -19,6 +19,7 @@
 
 struct mux_gpio {
 	struct gpio_descs *gpios;
+	struct gpio_desc *enable_gpio;
 };
 
 static int mux_gpio_set(struct mux_control *mux, int state)
@@ -27,10 +28,18 @@ static int mux_gpio_set(struct mux_control *mux, int state)
 	DECLARE_BITMAP(values, BITS_PER_TYPE(state));
 	u32 value = state;
 
+	if (mux_gpio->enable_gpio && state == MUX_IDLE_DISCONNECT) {
+		gpiod_set_value_cansleep(mux_gpio->enable_gpio, 0);
+		return 0;
+	}
+
 	bitmap_from_arr32(values, &value, BITS_PER_TYPE(value));
 
 	gpiod_multi_set_value_cansleep(mux_gpio->gpios, values);
 
+	if (mux_gpio->enable_gpio)
+		gpiod_set_value_cansleep(mux_gpio->enable_gpio, 1);
+
 	return 0;
 }
 
@@ -71,14 +80,23 @@ static int mux_gpio_probe(struct platform_device *pdev)
 	WARN_ON(pins != mux_gpio->gpios->ndescs);
 	mux_chip->mux->states = BIT(pins);
 
+	mux_gpio->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(mux_gpio->enable_gpio))
+		return dev_err_probe(dev, PTR_ERR(mux_gpio->enable_gpio),
+				     "failed to get optional enable gpio\n");
+
 	ret = device_property_read_u32(dev, "idle-state", (u32 *)&idle_state);
-	if (ret >= 0 && idle_state != MUX_IDLE_AS_IS) {
-		if (idle_state < 0 || idle_state >= mux_chip->mux->states) {
-			dev_err(dev, "invalid idle-state %u\n", idle_state);
-			return -EINVAL;
+	if (ret >= 0) {
+		if (idle_state == MUX_IDLE_DISCONNECT)
+			mux_chip->mux->idle_state = MUX_IDLE_DISCONNECT;
+		else if (idle_state != MUX_IDLE_AS_IS) {
+			if (idle_state < 0 || idle_state >= mux_chip->mux->states) {
+				return dev_err_probe(dev, -EINVAL,
+						     "invalid idle-state %d\n",
+						     idle_state);
+			}
+			mux_chip->mux->idle_state = idle_state;
 		}
-
-		mux_chip->mux->idle_state = idle_state;
 	}
 
 	ret = devm_regulator_get_enable_optional(dev, "mux");

-- 
2.47.3


