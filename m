Return-Path: <linux-kernel+bounces-839175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52629BB0F97
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2804323252
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7449530BBA0;
	Wed,  1 Oct 2025 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="atVKkPsy"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011037.outbound.protection.outlook.com [52.101.52.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E24E30AADA;
	Wed,  1 Oct 2025 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331038; cv=fail; b=s5T1pf6/di6Bd0S+n5a+DEEegUbwecV6KjGjeKvrLTPa6KWd7z1mIJNApw+N1bCKHXNPhabzT4dj4mm0CUo1IRbpyGDuuccGT4CYPoC6bryUmjGk7fyPVVEMpuwm1cbIRTHqkNK6AL7Bboo/SqLjv+1T3n1nqWNduTuxxbiH4HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331038; c=relaxed/simple;
	bh=0y6FA6hp8XnL7jpO5ZgF6iKfJBjOZPBjfJrWpe4AHE0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MsN1T1uKKlHlwHj/kFkjDPscFNunrgkUeqW2HamBdp86ZIIospQpuSkh+D7h5MvL8Fxr8Q/WrNRSrWcJRxfC/1288w037Z8qKaRkI3eAapxVrTeU+wrX036ssJf9Uog0HBrUfrmZDnArqkxNm5e1xUGh+1PwrkHNAYhs0OdLp1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=atVKkPsy; arc=fail smtp.client-ip=52.101.52.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRyllkH/Yz0SAL8PS/S+EAXudT5YFPOnqJsNAjFpz8o8OlVAf5+qU34BLzsPuY4HV7jdd63Sb1F8HOEKKGQ056cCOgCDrMWAQ3FPd0Ge+hyBQJ52wnUU5Y1GDtPiGxBwxqyjknVey+KyzZPjD2tm97T4cULgOOxBrtSW/QFMJvYgig6MTDkwyZF3nU47jg2A9yqCz+NqJ+/abjlzp1yEppDjWu3swtqR1LaKXdkAffLERKtgFyUl6kyDiwSJrkRGTKuvwPC1He1bLsTWqoQp9dqOzNJeB1EWwrhxaBRkrymyHK8JVazEWc2GEoN2Y3nZTaFuXF93nFHAcR9A3CX4lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jUtMdsHmG9/4qOVUv6cct+MMXitxbXFnNKu85Nb2OU=;
 b=F13y3UIGQaF7l7ngQRlAgO3FL53XnCYl8UNNQpKy3gHKCYzC8paTm5EKFY4lHUNS5HBBE9BwVMlvF/xWDfY3kS0FXNSvzJC3bzQ2mqbAesGIejd1zyFoaLA+VmW86P848xtwQJO1dBVJyEAEh1TskSMkk479JVVXybz2BD7l9sZ0ydjOLKw7NS03l+5YCQwa4ShVD1sqJ+Bb6FM72zVqwc72MHpra6ldiSfl//oS9f2CHgYWbxKD2laCb6nTFxtsKXPuTcEXhsdjttnLAuN/mnoLbUbnm+QMv5ihVuiQwFjyd5uhfW9OCwgxPSbxrB183W5ZFil+AfxVEkjECFe1dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jUtMdsHmG9/4qOVUv6cct+MMXitxbXFnNKu85Nb2OU=;
 b=atVKkPsyLvZQLqz5kfbEzs5eDMU/PoyakiOtuwD66v10thtJOG8DpE9LtsRh7HlM+39eEab9hN2r3ACljT2gmTO7EBQWyuFhsedSRQ3yrzLuHxVY2FwePMXLPxHNEQnjCcLsXsblHGtGIIBwctoQnlrlUFjWV3Fw0v718pkCgD42kILMQX0tZ4g5wM2pMbUzT6ljPKRwrZrO/fB+m379mqRrTIkIe4QlLMSANQYWUD1ZeQPfjLgHlBm6Gj/3skUrxkP2a6/VpkmaCCdKPxiNHAFTwUcnpis9AsDIMHQSxO37p82y97XV/MdOFNuE874rmJ+vdFKl7IykDZWuu2KtZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ0PR12MB5635.namprd12.prod.outlook.com (2603:10b6:a03:42a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 15:03:51 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 15:03:51 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 02 Oct 2025 00:03:13 +0900
Subject: [PATCH RFC 1/2] rust: kernel: add bounded integer types
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-bounded_ints-v1-1-dd60f5804ea4@nvidia.com>
References: <20251002-bounded_ints-v1-0-dd60f5804ea4@nvidia.com>
In-Reply-To: <20251002-bounded_ints-v1-0-dd60f5804ea4@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: TYCP286CA0006.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ0PR12MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: b9927705-d3e8-4e8d-41bf-08de00fbbb7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1V6L1BYUFZ0VGYzQTFsRW5UdmtkeGtEa0pJMlFMZUdnc3J3aGNhdFFXeHZ1?=
 =?utf-8?B?bnBYUWo1Nlc4Sk5DeUpVUThNQW9JeGtNQmVzZjlVRXd4SERnY2NjZ1RwQXZk?=
 =?utf-8?B?TDFieWYwcGNxY3Rna29yVGtSaExlOUZ5cWdTdllwWXdnZVR1dkhFZnVJYUNk?=
 =?utf-8?B?RXd2RmU2cG5GV01ITmlmNElKQUtzV0ZCdVhSYTN6SmlhYVRTRmpJbzRLckQ2?=
 =?utf-8?B?YkRCdnpsSFpGb0FwcHEzejRYWjc4Vy90TXdEWVFmZE81S3ovZ1RpOUR2cEND?=
 =?utf-8?B?OXRtR2tDZFFxQ1F5VzFmamFIRnllOWFoalpUaE9BU3lQNmdjYld5Y0RLOUlV?=
 =?utf-8?B?ODc3U2M0T1Jnenl3aWZhSGNzWVFBdWt0bmluUVVNUmpRT3dSZ3lxODFRWmVQ?=
 =?utf-8?B?aG42QWc0V2tsQm81TmlKaXVVMmw0ak5TRWVSa0xFZnl2dWJ3RDdXWGllYW1K?=
 =?utf-8?B?cUdReHNLZU5WWTFnYjhRdXh1bi9VM0FPeHRobS9UdVAya2p2bmVoMnhCaVBW?=
 =?utf-8?B?c3UxMncwZGcwUkthNVJGa28yTURLUDBKR2ZOeUdQbzBwdHlDUEpXcW1ESmxr?=
 =?utf-8?B?VnZNOWh0dk1nNzBQSFBpcjJZMHM4RGF1WHczclp4dnppNW1qQWV0UWJPaGxj?=
 =?utf-8?B?b0RGNmpSR2NxVk1YR28wTEl1aUN4KzQraUJETUFiNkorSFg2MVZSU1BqUjFo?=
 =?utf-8?B?Y0NVVVFoMUtUTjdvcTdVZVBQNC9DWVNRREl3RDhGdDFlT0tJQWZoTldhMDZn?=
 =?utf-8?B?TDQvSzNOeThCTUZ0aUs1ZGg1MWVJK0kzZzI4TGUrbkQ2NXE1blNGYlFpTTJi?=
 =?utf-8?B?U2lYRWwzd3RNNmNydnlRRGcyY2hzeUowRDlERG1vYTk5anN1TnFvS09nNFBo?=
 =?utf-8?B?ZFNNQmtOZHNMdmlYemw5aS9wYW1ldjBFMmZnZ3JSb01kUnV4Mll6eHJ1bzRn?=
 =?utf-8?B?ZFhjSlArQmFURkhBTXJDMysrdTNaNDI0NEhOMlJYVmRwcmI0VDZkU3hxZkY0?=
 =?utf-8?B?QnJEaDlGZ3lDUXNEcTdFVVFNMUloVittQXpVK2tNN00ybXk1VXJ3YklpVkRU?=
 =?utf-8?B?T1RUVFBJM09FWUNrSkFBeVJQbWNnMzZoaENLY0w2Tm45ZnRPemZxeXJIVVd5?=
 =?utf-8?B?VjVGbDE4UmFHUHk5ZTh4Q3piUFQrQ3VsWVpTeG9QZ3crai9hL1gwbjNrbXpq?=
 =?utf-8?B?UFdiM3YxMTNKL05mazBxUlkwQXVUd082SEZObHQzaHVNVHhCaEgyTXNSSFNV?=
 =?utf-8?B?WmJ1MGFBVUV6OUpYOFZlc1V1MHBTZ01nRURZakVUMi9Fa1VadFNDbFdkcUlN?=
 =?utf-8?B?dU9XMnRsMGVGdXRBMEFsbVZHR29aVFhtdXRkcHFRMmhBZytkSFBCaGpYREhn?=
 =?utf-8?B?SHM2YWFEMlRNL3lGa2NYdnNuTjExUktDcW9KMmRSc0dESUpwdEpKUWVkVHEv?=
 =?utf-8?B?aTBPTC9DaU9SMkFIVGhnbUxsci9HMjgyK3dQOXY3d3I1YTB5VTdOajY2Vmx1?=
 =?utf-8?B?S0dHWktpS1k3VzJLVjZkZjdhbXF6Q0kxOEVhalNudkpwNmFFUW90LzZ0NlNH?=
 =?utf-8?B?UzN6dTM3OEpPeEd1V2JQT29ueU5ndnd1dEpUM3pVMURZeGV5WTAxdHk0LzJI?=
 =?utf-8?B?Tk1pREhQSmYxWmNQTzRjQmRGeUE2ZTRaTTRwdUczNXB3T3ZwQllKVDhHdFFQ?=
 =?utf-8?B?LzFVU3ovRmVQWmQ5SWNlWlJlVHB3ZWdEaGhZK3EvYjYwWEJiVy8rY1NQd1Fx?=
 =?utf-8?B?VDcvbW04YStKR09SQmZ2VUxWeXYrR25ibkdMc0JHWU5hNmNlUjV6Vjd0bndm?=
 =?utf-8?B?R3N3OGxReUk5Qzl3bE1sL21tZmcrRmcyQ1hXWjl6YWhsVkU4SUhrcnRIT2Zu?=
 =?utf-8?B?UlA1OGZjYzRyVWRNVlFEVUd4dGt1aVl5ZGZvdHhDYUM2TGQ3R25MRDZsaHFr?=
 =?utf-8?Q?kkDMUq1+okgAwatBWX/5A/f3LRkycOyK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmRrcWRMRmc5bmZZM1Z5RlhWM3B1RnRac1NCSjhIR1NIam50UE0xSkJTd0tJ?=
 =?utf-8?B?L1lBSVhtcFZ0b25rb29uNHAyTEpmMGlNZ0lwWWl4Z0FaUGdsRzhHYWIvcXR3?=
 =?utf-8?B?ckpMdVBHaUxOcnFZTk02aVRJNzBhR3ZYVTJ6NzF4V0tDTGZ0cDZXUlRqaWxK?=
 =?utf-8?B?azludTZEM1hQdzJQWDdpbTZLY1FVbXlnNW1Wc3RQMy9vT1J2dXZuTFdibnF6?=
 =?utf-8?B?dytibU1aUDlIZnFMM3g3TnBvTHZKQ3BHR0lsYkZkSXJERUpubkFYVkxLeXgv?=
 =?utf-8?B?SjEzYXBObjZ5STYza1BHL0FFYVVGd05sM3dMZk9ETGwxM09YOGZpaHAxdXVV?=
 =?utf-8?B?blFPSU84ZzE1UUl5a0hySm54WC9mMFU3SFdVWjdUcEdWUmROYUpoOUQyZXBJ?=
 =?utf-8?B?VDRTZGIzNGNJbGJuL1BGZFNDc0NlYzkvTVZ1dUZLVmx0dk1jOHBwdnJSOUJP?=
 =?utf-8?B?ZUZGelVJTGZrdVBsVXFOWDR5Qzhpd3lGMDJSUzJWUWs1ZzRXN0UxeGlYak45?=
 =?utf-8?B?WklrbUpRRnRtRWVtVk8yOHNVd21GQS8xckZwZnZ1ZHhoVmo1cXV2UFU5RUNj?=
 =?utf-8?B?VVR1WDZYSGVhclZGd2dtUnJUci8rajBLRWJNWDVtUnJLWUxhajVjSDB6cnY4?=
 =?utf-8?B?TE5IdG93ZUZwclE5aUhGOHdSMUlySzQ1KzY5UzlOQjhOc2szTVBKdjBaU3pm?=
 =?utf-8?B?NStUQW5iam5WNUxNSEc5a0l6ek5hTkwycXQyYTRiZXFFN2JTUlpRMHoyQklp?=
 =?utf-8?B?dFU1ejhPZnNkZjJ0T2VHajdvZE8rUzBhUkNxYWVjamZiZldnL1p3QjhyZHhl?=
 =?utf-8?B?RTF1R3RKNWZ2YjBqcStqWWFNMTZCTmY3T2lpcng4ZUt0S1BOQ0lQeWlYR3Fr?=
 =?utf-8?B?cnlQc1E3WWtHT3RVdmdYVXhrVVNkYjBabCtVVVVsRk5tYUNVNy9EbjY4NDBR?=
 =?utf-8?B?MUh2SFVacE90eG9OcFNuVFpCRGFGVVYwZTg1M2IvZFZoWkdnd2I4K0IyaVE5?=
 =?utf-8?B?bUpFaWlwU0FubWIyRzNpQlFoMGZzNDdDTVgzTUkzTDkxR1c1M2ZLcCt5Q3dY?=
 =?utf-8?B?MmtlcjdtRXBERnJIa285NmNYcU1JZnhaQ0xYQTZFM2xOcmV3Y2YxN3lDeCth?=
 =?utf-8?B?VFFpMnRsTDh4dG9WN1dIU09NME9QaVUweWlpR0dKTXV3emErU0RTaGNWZ2FP?=
 =?utf-8?B?WFBCejE5OWh0QU5kZnl5SGQ2UjkvYkpYNTVuYXYzd3NqQzdGOFZWbnVUVm8v?=
 =?utf-8?B?cDhzaVZWclZkUnVDUEs5TUdSUHVWbithODdhemFaMmtldU9YNjIrUDhrL0Rh?=
 =?utf-8?B?WE5iNFlncVVUK0U3Yjk1SG5xck5ZTUVzTjZVdm5iNzNzbW5wOSttR2ZBaDFO?=
 =?utf-8?B?UkZoVnJ2TnI4Zjh6R2c3SjdRZENBWWo0T3dIUDhKQllzbm5sNmp5dWsxN2lz?=
 =?utf-8?B?TGF4TEdlVDBlbFVKcWUza3p2akh1czdBMDZBUC9rUzB4em94c1BmdHJ2cW1r?=
 =?utf-8?B?cUgvbEx6TDBodWJEbmFXNE51NDc4V1Ivb2dpdVA1QXYyV0VvVSt6Q2p5b2Rk?=
 =?utf-8?B?M0NmcmdoUlFEUERPWEhFZ0hQS3Z3R2doZmRmaStSaGZSbGF2eVZHMTFBT3oy?=
 =?utf-8?B?anJjRGttaDcweXBFb2lmYWhJVVljK0JwNFFuQTNpQjhXc1Q3eFZ4MEMvdVg4?=
 =?utf-8?B?SFNYYkZLaGFwQ2ZmbXhrM0owL2lYK0NLZW56eHNkTkdWVjcxbnA1WmNmNmZY?=
 =?utf-8?B?ajlGQkFUa3RNeFlURkYxR1BTV1k1WmdkRGk4L081TGNNUW01bGNoVWFBdEhL?=
 =?utf-8?B?VVBnc0Rid2U4ald5aUhvaktQZEt6UFRYZjl1dmN4Yk9YMDJYQXJ3TkhQODNq?=
 =?utf-8?B?MG9VUnJhNXZXd1VxN0NQTHFoZ2twL0xnb0dzRS9iTnQ5RTFEbm1aSzdTMmE5?=
 =?utf-8?B?Nmlhcy90cHZlcE1uZTVvSDFwQ2JHQzYybzNDVVYrNnpVWjZFa1VYR3RhVE1s?=
 =?utf-8?B?MjR0NVJ3aDlFaWxRSFFtRmNld1VLRThhNWhINGZaK3JGdDJkOCtzOUpleHBX?=
 =?utf-8?B?ZlhmblBXSE5iRHdaemZvNzhJV29wbG9iajZROFRvYVdadjI1WkpLM0I1SlFG?=
 =?utf-8?B?RlNBOHZOL0FFeEVpU0pkb2lkWnpUNnNIcDdZUzhLMmFHcmdUeXJpNUJvcVk2?=
 =?utf-8?Q?9QCubBCQz9YXbQADQjbaKeWpfkB2BVsIMaCk3qUcYI5p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9927705-d3e8-4e8d-41bf-08de00fbbb7d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:03:51.6841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJmLO6gq+/0bT4g2HG56PrpIk4xYTMvtlPew6KjWrazamQTvLOipdl+dPGoRIHCYl8ntuwA9HCLHOAVlQct96g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5635

Add the BoundedInt type, which restricts the number of bits allowed to
be used in a given integer value. This is useful to carry guarantees
when setting bitfields.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/lib.rs |   1 +
 rust/kernel/num.rs | 120 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index fcffc3988a90392f1d5fc19f15c75d9ba7104f9a..21c1f452ee6a30d46d7ed7f0847488fac068042a 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -101,6 +101,7 @@
 pub mod mm;
 #[cfg(CONFIG_NET)]
 pub mod net;
+pub mod num;
 pub mod of;
 #[cfg(CONFIG_PM_OPP)]
 pub mod opp;
diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
new file mode 100644
index 0000000000000000000000000000000000000000..f452a4e229ca962ae0c2382d0cda55b5ee335973
--- /dev/null
+++ b/rust/kernel/num.rs
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Numerical types for the kernel.
+
+/// Integer type for which only the bits `0..NUM_BITS` are valid.
+///
+/// TODO: Find a better name? Bounded sounds like we also have a lower bound...
+///
+/// # Invariants
+///
+/// Only bits `0..NUM_BITS` can be set on this type.
+#[repr(transparent)]
+#[derive(Clone, Copy, PartialEq, Eq, Hash)]
+pub struct BoundedInt<T, const NUM_BITS: u32>(T);
+
+// TODO: this should be implemented by a macro for all integer types.
+impl<const NUM_BITS: u32> BoundedInt<u32, NUM_BITS> {
+    /// Mask of the valid bits for this type.
+    pub const MASK: u32 = crate::bits::genmask_u32(0..=(NUM_BITS - 1));
+
+    /// Validates that `value` is within the bounds supported by this type.
+    const fn is_in_bounds(value: u32) -> bool {
+        value & !Self::MASK == 0
+    }
+
+    /// Checks that `value` is valid for this type at compile-time and build a new value.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::num::BoundedInt;
+    ///
+    /// assert_eq!(BoundedInt::<u32, 1>::new(1).get(), 1);
+    /// assert_eq!(BoundedInt::<u32, 8>::new(0xff).get(), 0xff);
+    /// assert_eq!(BoundedInt::<u32, { 10 - 3 }>::new(1).get(), 1);
+    pub const fn new(value: u32) -> Self {
+        crate::build_assert!(
+            Self::is_in_bounds(value),
+            "Provided parameter is larger than maximal supported value"
+        );
+
+        Self(value)
+    }
+
+    /// Returns the contained value as a primitive type.
+    pub const fn get(self) -> u32 {
+        if !Self::is_in_bounds(self.0) {
+            // SAFETY: Per the invariants, `self.0` cannot have bits set outside of `MASK`, so
+            // this block will
+            // never be reached.
+            unsafe { core::hint::unreachable_unchecked() }
+        }
+        self.0
+    }
+}
+
+impl<const NUM_BITS: u32> From<BoundedInt<u32, NUM_BITS>> for u32 {
+    fn from(value: BoundedInt<u32, NUM_BITS>) -> Self {
+        value.get()
+    }
+}
+
+/// Attempt to convert a non-bounded integer to a bounded equivalent.
+impl<const NUM_BITS: u32> TryFrom<u32> for BoundedInt<u32, NUM_BITS> {
+    type Error = crate::error::Error;
+
+    fn try_from(value: u32) -> Result<Self, Self::Error> {
+        if !Self::is_in_bounds(value) {
+            Err(crate::prelude::EINVAL)
+        } else {
+            Ok(Self(value))
+        }
+    }
+}
+
+/// Allow comparison with non-bounded values.
+impl<const NUM_BITS: u32, T> PartialEq<T> for BoundedInt<T, NUM_BITS>
+where
+    T: PartialEq,
+{
+    fn eq(&self, other: &T) -> bool {
+        self.0 == *other
+    }
+}
+
+impl<const NUM_BITS: u32, T> core::fmt::Debug for BoundedInt<T, NUM_BITS>
+where
+    T: core::fmt::Debug,
+{
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        self.0.fmt(f)
+    }
+}
+
+impl<const NUM_BITS: u32, T> core::fmt::Display for BoundedInt<T, NUM_BITS>
+where
+    T: core::fmt::Display,
+{
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        self.0.fmt(f)
+    }
+}
+
+impl<const NUM_BITS: u32, T> core::fmt::LowerHex for BoundedInt<T, NUM_BITS>
+where
+    T: core::fmt::LowerHex,
+{
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        self.0.fmt(f)
+    }
+}
+
+impl<const NUM_BITS: u32, T> core::fmt::UpperHex for BoundedInt<T, NUM_BITS>
+where
+    T: core::fmt::UpperHex,
+{
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        self.0.fmt(f)
+    }
+}

-- 
2.51.0


