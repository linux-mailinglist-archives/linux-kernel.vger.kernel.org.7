Return-Path: <linux-kernel+bounces-834996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DC1BA5FED
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 15:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2013280B2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 13:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ED92E0B68;
	Sat, 27 Sep 2025 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="o2v6rYb4"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CF51DB127;
	Sat, 27 Sep 2025 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758981083; cv=fail; b=ffqlGfa9atXDQ2EmY0yjXZlHC21H7Wspz32ZAH12I3RlFVPDgas8lVB2DKPX7Vv3ba+CWEQ74+YrNhUwIe47PeeMggvebOfvVYKUMmeOnxjFmGbmytjGlPxDbnWYiRhjmpBkCflKxkNN2Y/8pcdbaSopvvKiW+76tXKhAUNbFCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758981083; c=relaxed/simple;
	bh=nQH85ikgIZwK/wNiQPdt6UEy8pX9/3rBd/0Nn9O1d+4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L+lhynRZJu57cm3v+weskR1nO3EDFkNHLyPJY1eG3nG2w2VdrgeazHoY+B72bjuJBncB73FAMgRIwNAN8BHkSI+Xxj/zQGVy148Uoh+/W5YmEp7Vbw5ueHeUPW4ikkvj8qHjyFgeKQYhNUOC1Ky5ep2WJ5x9xZwiSPOiQp32Irs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=o2v6rYb4; arc=fail smtp.client-ip=40.107.209.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5WcAUngu0UThzUYj1OfAP21MJruAnrw/cHDR96ZqcDipMIO17Eq3iOp0jCtiHMOP0Jr5kw4/9Fa1GgEotxAOO64uNe4cN7gHF/77YkIY/oPM9rkYQK4sKyY63rlxjE2Jv3GIdLFwjsX4GlpbIcUkKDWKT29DMcmyMqMQdGYB5LbW0YLC5owrB+LzUGvEz36qoyxi9UJvDBO07FWikYsxVM+rmckP37tU6dc4DUulSaIhzp8mJFdaj/6kSjlswdqjaLAIyHlRo60oTQzNCMs6THc7U8X8a43uT1IiGuvO/DAo2pxhdmn7Z7IWLyoIYHjSgWPRfjMfcSUCbxM1fbbVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmmstizXlPtHLMOn7ZBbQj2m9tYiiYu3yNFwAIAnp5k=;
 b=yJSkEKbCryMeRFkvKKGByq9ABBN+xC+is+sSC/qwVpWpYrLgDApGqiXMMqFsV+wCzqeNkn6Ym4Q+Dhorsb7pg8/0C1fAWNSRFbSNzUCDRAnVNJniZrAbqtwMrLRLMPBPUGH9GXkW/fHUP1f2l5Fiw8mvf1pS3YZqmA4L/Y/X0cwFZy9MIVhhLmbhE6MZONnWGA84OhDHmXpis9uuuU4Y9WtfZcLDmEIoSXhqbfvOH9jwHoW53+1eJhNRy3TLZdoYyMs49jGTMLYuQ60P9FsibJ77F5MKnuF401wFc0qn2U7e0s5iTMLcPZp2LI8uUbWp7dHcvM7rY2R6Il2SJcq5rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmmstizXlPtHLMOn7ZBbQj2m9tYiiYu3yNFwAIAnp5k=;
 b=o2v6rYb42aJ1tBSrBfAJ0ptDSbTyQbIhMh2XpWZvEDrkFPNRoa9vXAvfn1RVE7yd+4ID3MgScFdfU7h/JtyJ2zkVaawuCO3phd3pPLIakQO3cX/y2p0FmjNvSFFAwSjZVC/0POZaNQI8LLyqwU1euRYlcAdZEzY+jvHzQUhokaSEeDlS43LRl6+0J9IJLKYUXcn8Ek5QlGEtttDVoJerUNl28DDuaDc0sZeTtLt+tpk6N1g/0d0mKamrFFB704vQ69FCBDIsmCIVJw/ioEIcMg4HVJIVUiX4/yU1Jd7k+qEI6SwjP5rR43BOXZjcoOTFOu57lSLv+vLYAB/SXv+Xbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by MN2PR03MB5264.namprd03.prod.outlook.com (2603:10b6:208:1e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sat, 27 Sep
 2025 13:51:17 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::79f:ee0b:809c:4efb]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::79f:ee0b:809c:4efb%6]) with mapi id 15.20.9160.014; Sat, 27 Sep 2025
 13:51:16 +0000
Message-ID: <ea5da9ab-c691-4339-bb39-205ea5759220@altera.com>
Date: Sat, 27 Sep 2025 06:51:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: arm: altera: Drop socfpga-sdram-edac.txt
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250926214738.1791368-1-robh@kernel.org>
Content-Language: en-US
From: Matthew Gerlach <matthew.gerlach@altera.com>
In-Reply-To: <20250926214738.1791368-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:a03:333::17) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|MN2PR03MB5264:EE_
X-MS-Office365-Filtering-Correlation-Id: eb18491b-ef1b-455f-6a8b-08ddfdccedac
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHRjQnJhL0R0R2ZHUTFuZyt5U0JLWDZnM1lKUWl0c2tlb3VLNGRabS9FMSt4?=
 =?utf-8?B?TzBhNS82cWZ2ZGR3ZDA4aWx2NGdkTWNRZC9hSldBbzdyRUk3TFVCZkRqN1Yw?=
 =?utf-8?B?QXk4WmJnNnRNVXcvQUJYdjNDMHYyaXBRMVJ4TmwzY1JRdEdFbGpXYm1ic092?=
 =?utf-8?B?TlZNM1h1bGNwRmtlY2FkM3Nic2ZuQ2NENHpnWEUxdllyeFhSSVpuS3l2c2F3?=
 =?utf-8?B?K2gxcmV4Mlkzb1NmLytvR1hZblVLOFUzUFFYMU9vemN6M3kxM0tQSDBJbGg3?=
 =?utf-8?B?ODErNVJjZjEyc3JNU3dSYmpFU3BTc2o0UnV4cWhBWnRqOU1tUTVON3FhemRn?=
 =?utf-8?B?dFgrU2hjM3ZZQWNlclcrRFJVSGllMXBNZ2pIUVpiRzZyUnpPSjZtUjZWeDJZ?=
 =?utf-8?B?UGNkdzlGKzFrQmRpenBYNE95ZExMY3FVYStRRlhWL3BhTmxBNGw0aDVQQTVm?=
 =?utf-8?B?aS9qdnowYzN6WndVY2RtZE9wa1FPelJma0dLVjBhUzUxZFRGbjEzQjJYcjdj?=
 =?utf-8?B?MW0rZ0FlSC9PdUwyTnZ0S2FsZC9Mb2g1ZjRQVTBraXE0RTMwcEp6V0xKT1JZ?=
 =?utf-8?B?MlpRajJ6ZlJTUU4vVjlCZnRqRWtzN2pqY0FLanJsZUMva1B5UzBnZU43VmlK?=
 =?utf-8?B?Y29oK1ZIcjhORlhRL3hBc2FpcnZmVzZSdFJ2UUk3R2pxVHVTY245dzd4VmJ2?=
 =?utf-8?B?ZjNuNEhmZXBRQXRNcmtjbjFvSENGdXVwTm9sRUJIRk1PR3plVk9leVlza1Ew?=
 =?utf-8?B?dGpjeDFXNkZGLzBjNGZ3OG01MVVWMTB2ZHZiUTVLcVBuZCtHVnJrU1AzUjVI?=
 =?utf-8?B?M3JWMkhHTWhiNzU5OC8vZW5aNEN3enJZNExIbGdTdU9lMGcreGZJUW9XMktB?=
 =?utf-8?B?VERodS9ZNGlqeDErMDQ5c0I2ZkJsRW51Vlk2TFNEcUJQSnBYQ0YxMzB5eHNr?=
 =?utf-8?B?Ulk4dWh2cFRDMFlONndlRCtISlMrNkp0Q2grcXh5bVp1RktSK0dnUTBnanJ4?=
 =?utf-8?B?RjlzU1o1eWVQUkJNQzJnUENaaS9HYU45NytwdklmdnNOSTF4Y3JqUXEzTHQ3?=
 =?utf-8?B?WENvcGxXc3dQUmdKbzIxMy8zVUo1ZEpFSE9rUWZWaFlISUQvcnFaWjBHZVRN?=
 =?utf-8?B?ZHJXeGIrQWdzNWpOdDV2c1pCb2JlbnNUK1NYYWZFSkI3SFQrSEdMWFZtaGR2?=
 =?utf-8?B?amh0NTRqZjF1WnNIa1hIN0dwS1JmQllsWFBWbVlCRmZhc09JdHZYKzNjRVVG?=
 =?utf-8?B?TWtmNjMwbjlnNU1BQllFK2xXVVN1WmRSdTRLVGNGT1B1bndzRTZpWjVMdVVa?=
 =?utf-8?B?SCtqOWFYM2ZuMnJKOG9LcnBQSTd4WUg2VmYrMkRhcTUrVUMwR2lBZVVlUGU4?=
 =?utf-8?B?VVZvbEdkRzMxdWFXTjNkNDhFTzgxL1VudXU4cTNZKzdBa0FZL2ZjYlpkeWdC?=
 =?utf-8?B?Z1QzZjdkdXdTZkZ5V05YYkU3THhVR1NJUGVCWTJZY3dKSW8vYVR4L2wxRHZ6?=
 =?utf-8?B?WDZzL3poK2had1pubGRpOTBuSGFoSDhDNnJXalpOcjBvaFNxaXI5czJ0VzBy?=
 =?utf-8?B?M1prZUJvcXNkQWVGcU13cmsvd0V6cUYwdG05eHZrZ3MyWnkrRnpyS3BDR0d3?=
 =?utf-8?B?NDRLeElHcGQ2S1B6VVNrVTVqMkF5NWlydGd5YmF2ZHd4d1cxSnlBTXd6a3da?=
 =?utf-8?B?ZlQvdzR3MHJYeFd2cnVzOXhWQVAreVJaTDVaWk13enB2akNlZyt6V0luTi9l?=
 =?utf-8?B?MEZVdDB4UjEzWWdmbzFjN1JPYnJIcDJuZ0kvQlZQRXAybzYxVDB4RDR2UCtC?=
 =?utf-8?B?Nm9rWFFiaGZmdE9kaVNEQk5IUWVqRkszdDE0RkJPdHlsaWRCcE5UWTFYaDFk?=
 =?utf-8?B?amN2VFc3YldFL0cvWWk2RW9WQVROMExoNnlKVEw5WkZpUW8xUmdocmJxUDNn?=
 =?utf-8?Q?ES7zPV6oq42YrGQQpF43KpKqbgCOKihD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDBTMndva1huU0JNYSt3VkF6NjVaUjVhUElTWFlwR0dieTlTbGxKV0piaFNy?=
 =?utf-8?B?SUdzbTJYN3JXRWlEOUNJYTNkbVhzUXVYWjVTQTNKU2JLUWlmbkZqWlUrZTFp?=
 =?utf-8?B?d29UdUh0UDA0RUJBbWQ4cW1iSElzOXNYb0dVeG9GTWZRWVc4VlhuOXc0NUdX?=
 =?utf-8?B?d1Q0V0U3SW8zRk0wWUg4cm1MZTRKOERMbGtRSGFVVEFqdm45bzE1TUViSXhR?=
 =?utf-8?B?ZlJvY21nd2tOanBzd1V2N2oyRk9mSjAzZ2xpZDdaU2ozYm1qSW5EbzJML2hQ?=
 =?utf-8?B?Si9JVmpHWCtRSFFmNk01QlNvSHFtQTJTTk9wTXR1bUVSZ3NLMVF2bjRWTDZS?=
 =?utf-8?B?aEhCck1qMlJPb0lMVGZBSEZpRlZHSDliaEhLTXNDQktwampUMW5QaFkrUU53?=
 =?utf-8?B?YWZ0WW5FQlAxRS9Xd0ltWHNaQ0JCSWg2ZUtJU2ZzOFVSRkNkZGVBVjZ2NGtU?=
 =?utf-8?B?TDFySVpPRkFOaGZXbjFZY0NEeURYV0dPSDRTeFhmYThMbmZ6N2lXTVpCaXNE?=
 =?utf-8?B?R0ZLMklKZnV0ays3Zk9vMEVUZ3htRGx3ZGVsRllDa2VWWWxaZzY3RHEyR0lU?=
 =?utf-8?B?WTVveG9iUXJjZ3VEOVI4cUZaeFNkQ0ZwdEd6YlJTS0RzcUNrZ1lQMURqVk4w?=
 =?utf-8?B?bHMzNCtQbkRRZ3BIenkwd2N5N2FyTENFa2RDVUEwUzltRzZkeCtnSmhUVWpM?=
 =?utf-8?B?VmlidytpNVluamV3RFlyMTdKSkc1YVNmcExOMVFaOXRVMDUvdmpyNWxqMGlq?=
 =?utf-8?B?ekhuOURiMlBXdTBFOTR2MkwwanBBWHlySlJpM1dKVzZpdnRIa2tKRjdUTVRF?=
 =?utf-8?B?MzU2UDBwemNaaWlEN0FlbnllYjljbW5teS94eWN5THNIU2lrQmJueDVVQ3pr?=
 =?utf-8?B?VFlxY1BTY3lwUUhibnk5LytNK1F3ZHQva2lDdlFRYmU5d1J6SzR2TkRPMHJM?=
 =?utf-8?B?b2VWY2pmRzNxWTZHczlOODVoY0ZXb0RxZDl3dkZ2ekNRd0dHck9XMlkyQVJh?=
 =?utf-8?B?UGtzUE4xRVVTS1J1T2R6bHhFdmlCZmo0cXhUWGZhSDNvdXQ5eTQwSlFhSmNl?=
 =?utf-8?B?aDR3WUd2V0s0ckhiV1M2Ly9hZGREUDFiR1FEbXNVU24wVGFSbGJTVVIvbHY3?=
 =?utf-8?B?MnVIaDBqYUJrVEI2ZHkyS2luOXE5UDBvMEFpc0xVN0ZMK3VzenA5L21GR3F2?=
 =?utf-8?B?QVI1MHFvN3JUdkVVa3k1VEI4NW83dDBKMWlDRytSZHQyUXdPa1JyVHJUK2FT?=
 =?utf-8?B?Z3pkenlFMXczdHJsMUloN0dmbWxzVkdqNEVYOWRuakQxRXllenhTSTZtclpl?=
 =?utf-8?B?b1hWRnAzU3F2UENQRjI3eVl6MGtDZ3oxY1orMDcvK1pFS3Y5MU02ZW96Z29N?=
 =?utf-8?B?K1BaMVB0OGpTdTM4b3AvWjExSGNpSXlDT3RQTXNNaGJMamxleVVwRC9Da3B4?=
 =?utf-8?B?Zlh2QkVXdXVKeXZUZTFVRlprMXZCTHk1bnd4VWlWd2M0TFJ3Q0xVaTJZTWNM?=
 =?utf-8?B?eG9MK1BMZXpmT3h3VTYwODN5cmk2amtZZW9Za05ZLzZjdjRGdEpUc2Jqc05U?=
 =?utf-8?B?cHVXQmJCQzlWb1c4OExqb2FReUltejBYUXZkemFXVkdBV0thZm9xV0ljbmMr?=
 =?utf-8?B?aHJvLzVhVGhKT2EyRU51VERTeHVqc3B5aXM0V3FCdkJJeWRRclRXQlBONjFC?=
 =?utf-8?B?U09UaGw3WXNXaDFRWlhnVm9ieWRmUzhIaEdQY1Era2lvUEtHc0tiZEFEczlB?=
 =?utf-8?B?NzAySGtzVDhjMkVObGZZTWZwOVFMeUJlQ3M1T3J2NUUzRitSdkxnR1h0RCt0?=
 =?utf-8?B?eExROVFlOGdYWmVWcG9IbUNISC80Z1g5VzYrMDBjbXVWeFZKeW9SUzVUOWxB?=
 =?utf-8?B?ZHkyQ1U4WFowY2gvSWt3dzNKV3RZc2NsQzAva1ZDbCtJNGJxTUcyYldneWQ3?=
 =?utf-8?B?MXFGQnl5anljaU9uTkZ2U3Q0bDEvUmtaTk52cjVhOUU0K0JBVVpGLytCeVFw?=
 =?utf-8?B?b1NVeTNtd3hOQ2F5QUZRRmFBZUxIcW5uYVk5TzBIb3lxMksrVWJSS3BjcnNL?=
 =?utf-8?B?ajNzQ2NjbUIyVGIzOGZlRW1DZlljUmJwQW9rdTJtS3lZNzN1K1o2aXNqRUh6?=
 =?utf-8?B?RjVDMGN4ZFFVTVlNRjhES2JtSVhVUXNtclNabDIrM2RhTXpGOGE2UGFpV1Nw?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb18491b-ef1b-455f-6a8b-08ddfdccedac
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2025 13:51:16.3941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtATHBHTBzMK4WiSsQhcpADAyazT6oUHSxWjY5TYIeDOpZwbflO2CTpER6s0Pq+PTZNOIlFiRCD6F8T/qQfFztipJlJRQUAOYBRcF9pzq4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5264



On 9/26/25 2:47 PM, Rob Herring (Arm) wrote:
> The contents of arm/altera/socfpga-sdram-edac.txt are already covered by
> edac/altr,socfpga-ecc-manager.yaml except for the "altr,sdram-edac"
> compatible string. Add the compatible and drop the old .txt binding doc.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Matthew Gerlach <matthew.gerlach@altera.com>

> ---
>   .../bindings/arm/altera/socfpga-sdram-edac.txt    | 15 ---------------
>   .../bindings/edac/altr,socfpga-ecc-manager.yaml   |  1 +
>   2 files changed, 1 insertion(+), 15 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
> deleted file mode 100644
> index f5ad0ff69fae..000000000000
> --- a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -Altera SOCFPGA SDRAM Error Detection & Correction [EDAC]
> -The EDAC accesses a range of registers in the SDRAM controller.
> -
> -Required properties:
> -- compatible : should contain "altr,sdram-edac" or "altr,sdram-edac-a10"
> -- altr,sdr-syscon : phandle of the sdr module
> -- interrupts : Should contain the SDRAM ECC IRQ in the
> -	appropriate format for the IRQ controller.
> -
> -Example:
> -	sdramedac {
> -		compatible = "altr,sdram-edac";
> -		altr,sdr-syscon = <&sdr>;
> -		interrupts = <0 39 4>;
> -	};
> diff --git a/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml b/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
> index ec4634c5fa89..3d787dea0f14 100644
> --- a/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
> +++ b/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
> @@ -53,6 +53,7 @@ properties:
>       properties:
>         compatible:
>           enum:
> +          - altr,sdram-edac
>             - altr,sdram-edac-a10
>             - altr,sdram-edac-s10
>   


