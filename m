Return-Path: <linux-kernel+bounces-743014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0F8B0F986
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D5C163A11
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687BA223DDF;
	Wed, 23 Jul 2025 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UTyh76+L";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UTyh76+L"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013064.outbound.protection.outlook.com [40.107.162.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDED221FF5B
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.64
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292351; cv=fail; b=CJ8fYheeQvIURdUBlXKRPkAWh3Y1M5ENKOC7Zzsvkp+gkvB4h+R/CkxDDUrv8FhQXRFEd7T5XVfH9c/+e/gfchtKSLqf469gk2T2XR1zrnSf7Dm/VbpLkNlXXiW1jiMIc9agO7hXJVJWgFP5xATTcqqPgN3JOP5VU+CEgAzvTv8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292351; c=relaxed/simple;
	bh=nQKTo4MgRrKxx315+TNQh6ufRrEl1ESsB+Elp8tCy2A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iafkeWqDeAVraaoZytfKIjgWYuP7gJwsRkhwN7AQbCjw4dmZqq9iuW6BXXX8xkjRC6dS4CEVC55vfN84HDiDMBb5JuwZZfn5dJp2tw/OhWD8uoftU79tyKx9tpgKmabE09EDIhWtm7ZfzrDfeLo/tzukd6iFtNSXiBNnuVttY8Y=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UTyh76+L; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UTyh76+L; arc=fail smtp.client-ip=40.107.162.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=naHOCiD0Z+CS0lp13Q3PIQfuPqrhHksQVlQCoyLOLDUQUjXKe3z5LjHImjo+dfoE4UP9aNf9zRce0T4CCQkYmtf7L4GQZOIhBbsTzd3sDUJ9u7jHRKNUnwkO0KG0Xjr1B7tLLUKnEDHp8pzPHlejl5yvpXKu+kFOHFjVQIgnXLV58FMjlrq76B18OUIOLxYFb6EyD7d0zNef1nAkkwc9DPznJiVy68c29G2OPv9Hwieg9+mOJ/spuIbTk7Ki/AFuYn7ITCDNbLYW3AVRefwRYF/+Jl0gjdj3A8afYvhh0LR0Nh2rjOWGpShONLa0af1H9dA0QGg8F95XNVAAu2Q4yA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KuWAgeSZzVpkeSSQNQ08PCbrWShNqCS4b+Yh1JoyV0=;
 b=YdXZ93ZQTGI7H/R5HULMgZ8CIs1zHabV+EyhKbhSLHqReElBwME8tBcaf6j1HGrLZtxdaixNvOwvSyR2iYJWRzT09Qwj3FdzrPrMS9Debz5JCu545eQ4GeskJ2wH5Nt1fM/frzmCV29vZWH5G3jGptCRSaUpGi/dxsYKUlOMZFs5DJfxU4WWgsmcy1IUS39Hm/A8i9jCgfmWVzv2qt+SgPBQAYuNbENsNmdl3CZQdNB9zAdywltNksLXAHj6y4dfHSjJtGQcWfnZDanVupKzCYQ8EHILs2JD2SZVa28jQ/WuXb5jLbMcaSF9tGnJyp12Wk/J/cL/uyblCZG0bGCoPg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=os.amperecomputing.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KuWAgeSZzVpkeSSQNQ08PCbrWShNqCS4b+Yh1JoyV0=;
 b=UTyh76+LX+c86TpXtTOPrO4x1XOA02ZXY0RQ5BbXbyO4nP2o6jfHTEV10yXuWyGLVQl7W4KaFH+kst68FvIUD0crdHbPvNs4fDKTH4iuSfOTcyNU69auMFOeIVci1H9QuOu4Yulv+TBfkUcrQFrcafHA/YOdnfVyyepmcao0QIA=
Received: from DB7PR03CA0088.eurprd03.prod.outlook.com (2603:10a6:10:72::29)
 by DB9PR08MB6505.eurprd08.prod.outlook.com (2603:10a6:10:23e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Wed, 23 Jul
 2025 17:39:03 +0000
Received: from DU2PEPF00028D12.eurprd03.prod.outlook.com
 (2603:10a6:10:72:cafe::fb) by DB7PR03CA0088.outlook.office365.com
 (2603:10a6:10:72::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Wed,
 23 Jul 2025 17:39:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D12.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Wed, 23 Jul 2025 17:39:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dN9Ck9LYR9HuZa/VMADVh/ppOSzjqDS+Eei1vZ6AFZBpx1IcNIq+7zKd53S/s2K/T8keFzz9Py47xg/B8ae8e59/pbqJSc79Ph3gAUlaV3shaCHFv5pCI04+R9cbHn5rUv90i/bPwPYccjB8YX2H0CygETEYtDcNpEHD7q2c7L5UnA+xMMrlrR0I66DEHJOqsxGIX3vd0t/andCqxY25TalGHdAIK1VURzf+FfYKgKaxHNE/UsuxHzqzO4LMGqgzn4slpxpiMVVZ4TfxHxHBG3G8ZUGxvbtujW5JK78zOl4lCEtk4RLaStNuNQALA5/opTIbkw5umcQqtwTMMFQLEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KuWAgeSZzVpkeSSQNQ08PCbrWShNqCS4b+Yh1JoyV0=;
 b=Msd4qxs9vi7WfPeP6k4bn9o8hrd1H+aR5H3wgIw8f02KIHV3RfozYqtozlEJh+e84zIh4MYZ9XoFdChpwsuaK5AlmPE4HY+BISIp1UF3TqQDI/NqROy2TB7joBdtWfiTMWOgOlkO9EAT4IuJaTM1/Cuo0y2hNRE7UivdK7FL9izM2doxCNnGpYAvds1cbI7M5xxsf5tGm3X6VRc/cJPWeXSLUv7KB7lR2YGP2TtXl/A5KU/hSL12ZQseFQY8QBz2N4YM7p7fYOY5Lw4naX25sTBfjNLgywUU7j3FqJPqKZ3YLS3kb0sxhnSGlPSd2fLYyzuzk5RCRWJF0z6nMMpCnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KuWAgeSZzVpkeSSQNQ08PCbrWShNqCS4b+Yh1JoyV0=;
 b=UTyh76+LX+c86TpXtTOPrO4x1XOA02ZXY0RQ5BbXbyO4nP2o6jfHTEV10yXuWyGLVQl7W4KaFH+kst68FvIUD0crdHbPvNs4fDKTH4iuSfOTcyNU69auMFOeIVci1H9QuOu4Yulv+TBfkUcrQFrcafHA/YOdnfVyyepmcao0QIA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DB4PR08MB9215.eurprd08.prod.outlook.com (2603:10a6:10:3f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Wed, 23 Jul
 2025 17:38:30 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 17:38:29 +0000
Message-ID: <452be681-f28b-4b5b-848d-c967672b4f5e@arm.com>
Date: Wed, 23 Jul 2025 23:08:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: mm: support large block mapping when
 rodata=full
To: Ryan Roberts <ryan.roberts@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>, will@kernel.org,
 catalin.marinas@arm.com, Miko.Lenczewski@arm.com,
 scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250531024545.1101304-1-yang@os.amperecomputing.com>
 <20250531024545.1101304-4-yang@os.amperecomputing.com>
 <f036acea-1bd1-48a7-8600-75ddd504b8db@arm.com>
 <50a4f767-0007-4f6a-8c62-398962d54029@os.amperecomputing.com>
 <ed942c01-58e8-4d91-8f86-3b3645af6940@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <ed942c01-58e8-4d91-8f86-3b3645af6940@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0119.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::19) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DB4PR08MB9215:EE_|DU2PEPF00028D12:EE_|DB9PR08MB6505:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ea089c-c780-4a72-e007-08ddca0fd0ae
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UW9pWm9jdlF6QllsN25GVjJaQ1AxVm0ycVB1UkowVFZvcXdycjRNc1lkV094?=
 =?utf-8?B?ME1jOXlyeWNSSDNseDlIbDZ3U3JLVFFzK3JTbjB3aDhQaVFSVVB5RHBpQ2Mr?=
 =?utf-8?B?NVArazFFRXRrSHNaTXVBSXR6S2lnVmIvaW9CV3pLYUt3OHk0alZnb2NGUGF1?=
 =?utf-8?B?WmRxTlpWSGtheHdYRnlhQzhMaUp1SlppOFBFVGNNcml5OUs2TEg1MldUTTVL?=
 =?utf-8?B?S0Q1Qk5DVElBSDhZcWROKzNuYWJMSjFEM3hFRGplNmM5ZSt1WlFWWUZRVTVw?=
 =?utf-8?B?SmhYMHdjV3VmbW5rTzhKMXpYT1VhSmhlMlJocklqNnF6Vzl0Y2pqWmsyd3Nt?=
 =?utf-8?B?NHNTemFPU28xMi9LaTNUcTVMWGNyYnpwb1NkY0x6UXpGMkFBaEEwT3U2SjVD?=
 =?utf-8?B?RjdQSUtoRjBKTGtSaVZGSzBBVUJRMGpXNTNVc0tkVnBvNjZKcWg1YU5YbWNG?=
 =?utf-8?B?ZU94Q3Fpd0h5TzV3V2dJWktFTWNiei8yK3BISVJJdXhxUW1Qb3NzRU9CRUNs?=
 =?utf-8?B?cG4ySzlTWVVhZXRhRVp5cTBBdTNjUUU3SkFYZ2VNaWpJRE5EN09uSlhVdjVk?=
 =?utf-8?B?YStkVm0rT3NyY05mVGVYRjJoVnZ6SFV0d3NJOGNkcWl2SDZOa0lKZ1g3alll?=
 =?utf-8?B?VDhBL0x0ZUcrMkplWDYxN05rc2NKQ21zd2VyRG1UUVJUbi9lMmptOVdxSFZr?=
 =?utf-8?B?WlN4LzR6bHBCWjZGT1BTRG9DMUtPa2Z6REJ0WTdMbzNDQ2ZBTzFEK0RtdDl4?=
 =?utf-8?B?R2Y3RHVJQTdwN2RHMzlOQTZlV056cVR1RDh1enZObXlLbFU5UEhzN0lzdkJk?=
 =?utf-8?B?MkRENEV2a2xnUFdSYXhpdy8zRjFUMDBBODVCUEtPQ0d6THdZUjduQlI3b0sv?=
 =?utf-8?B?ZWUxc0Y0Qnh6d3JBa25TaVFiajNnTFpOT1ROZEVPSG45bkRPbTV3T09DQ3lu?=
 =?utf-8?B?MTByYTR2SE9ZK0hyNGtwUktaSVhSWWQyQUpsY1NuOVJLTFQwY05Fc1BDTFRu?=
 =?utf-8?B?Wk52dGNoRmZXSzIyUzE4RUFVYXJKNmhNeXB3cjFPQTV6K1FDZzBKQkJaaTJ1?=
 =?utf-8?B?QW9QM0drUXBTZnBqT3NOTzZoM1V2Ym95WXdnaEZMUmJGMDZ5dkNNd09RUjBq?=
 =?utf-8?B?NGgrN3hmNWdzWXBuNjllNW1ZZHdleWZTeHFkUzY2S3NENXNnT0NhZ08yRWdD?=
 =?utf-8?B?b0dVaFlGRkw4bFNiYnJMT2g0S0lTbXlWQkZrUnEyMXpCcElxM3lMQW5pRGx0?=
 =?utf-8?B?MEtWRjhiQ2JpVGx4dHM5YjJzbUFZdVJiQ3ozQWNjak9zY053d1QvS05xZDZi?=
 =?utf-8?B?S2h3cC9HQ3lJK1NyODFvdlpUcm1WRkF4aldwME5jTUZZRnZYK1RXaVEyU1VX?=
 =?utf-8?B?MGd3TnlQelQxOGJ6MERIV3MvL24vNXFFWHRtNk1FQjdVeWRoRWIrZjB0VVdB?=
 =?utf-8?B?em1ISUtKbkdwUWFIUm1EWVdoY3dVTXIxWFFXdGxGYlVKV082MEVoRWU5eDFa?=
 =?utf-8?B?OHNpQTFDZE1Wd29KcUIrRTl1SjhKMlZzRHgxOFkrbEdzN3JHYnN4eDdGdjEr?=
 =?utf-8?B?OVVpSkx0TjIyaERjVnlkQms1a1lFM3FocEx4Rk5rUW1pS0FzMDYyVGRpYmIr?=
 =?utf-8?B?V08xOFJScld3K3BEcndZZC8xcGJQeUN4cHVUaWlqWDVJVU5EK3N3YzQ4Y0pE?=
 =?utf-8?B?RXdFVmVnOVI2WDloRkVsS21QYUMweGs1RU44TGtmRklUaFByY0NSN0o5QjNO?=
 =?utf-8?B?YUVNQjBSbnl2OWNpVkUyVUFRTTgvSVg1YjdtOEw5S0N5NGkwTklHaUJqUkZn?=
 =?utf-8?B?U0VuYjVyWFEySHdncDhMU0xUS3o2RmlBT0ptcEtDRGQrOFIvZWFXZ01nd3Rw?=
 =?utf-8?B?L1FBSlFuOEdUeWZZaHZleHRVWUNrdHBIOWljNVRYMGsxMUVsWFo1d1lJeUZU?=
 =?utf-8?Q?rlVmDxUVMik=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9215
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D12.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a62251bf-6d9e-408c-93f4-08ddca0fbc2b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|1800799024|14060799003|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NklCcitSVnNiTFZMeGVhQkpwRkpqZXp3OEEvSy8vNFQvYnFRbmtSS295cUZm?=
 =?utf-8?B?VXdhbzUwSEJGU0xnc2d0azBVMXVDYkp2ZlpsZjgrOXkxeVpuQkxkcEZmUEJ2?=
 =?utf-8?B?aEpmWGNuNFJRLzlUa2s5Q0ZhL01MQ3gxTGxtV1d3cTgwc1Nhdy9YRHlqanhT?=
 =?utf-8?B?Wk1GRU9TRzdvUWYwYnpZemd4MHZIMGxra2UvYitVWTdtMnVVK2Y5Rm43a3R1?=
 =?utf-8?B?K25EbXdjOXY0WWw3ZkIybG42TzRDUXNXMVg1WFJtYmErYzRkNVpjVTVyWmR6?=
 =?utf-8?B?aEFTeXk0TUsxMEltOHMzZVV6Y01GanVpeVR1ZkloMktma3B4azF1cXk1S1Yw?=
 =?utf-8?B?VzJLTDhZQlJvb1R2ditKQWF3ZnRBUC8vcndKTm5iYkJjSmRxVWExazVOOTZC?=
 =?utf-8?B?L2hoQkVwYXA5VHdOV0I4SUlHMVpadXZnc0FGWVM0ZEJrL2dUbWJZM2NmK1pB?=
 =?utf-8?B?Q1RpWnlKNEJVcGR1U2ZYbXFWeTQ0dG1idmdzV3R4WU44USs4NHdKZENDOWxx?=
 =?utf-8?B?V1hwK3A5cFJFVWYza0RvSDQvWHpOMDN3WmFYZ2MyamRMKzczR1FvZGJYTHdy?=
 =?utf-8?B?bEZjdHJEbmlMYkpoblEzRldzNW9jUGYycjkxNGo5RXBSUlJyWHJmb1dqemJv?=
 =?utf-8?B?SzlnZmRIVXg0Uk5xWjl1QkRzbDdpY2NKc055M0g1YTlaQ3Q0bjJrMFRBMENt?=
 =?utf-8?B?SUNUbC9KdlJZN3RTZjdIWS9jMEgxK0lNSUtlSHhUdGxIb1QwYTNDOGJLazJE?=
 =?utf-8?B?TDVDWnhpam9zRng5K0d6R1hJTzZXNVhMYWJGbUdmSmFGc2c4SmUwVFMxVU5m?=
 =?utf-8?B?V3c1aGgwS3NyNTRzbEZNeXVUTFJCMjdvbCt5S0cvTEExM1NjencxVW0yM0VU?=
 =?utf-8?B?dk9mYWZLUy9Xbytscit4a3ltTURkd1hCZWNPUkJ3cm12WVlRN0RxaGhuS3ZM?=
 =?utf-8?B?VHJkM2tWQkRVa2Yxb2EyYWJCajE5ZGZ4N0xqU2JzeVZUMWF0WE8wNEsrdE8y?=
 =?utf-8?B?a1BXZWxDSGpLckRCd0wyUEwvN25sTGZpWnF5Q1BMR2tWUSt2UXEwZFBGZVpC?=
 =?utf-8?B?T21NVWdsU092ajMyeXNmajQzYUorcUhIMmNoNkN6U3NCemNOYUpyVFArRm96?=
 =?utf-8?B?SHlaSS9TN2M4dldrZXFHMlFJTTBzZ1FCTWZDREVuQThSNFVWV3V4VEU0Wkg4?=
 =?utf-8?B?RTBCQzNMb0NNeUs0UXNmb2E2aGVhYUhZSlZxTm1JNWx5RnZjb1JKUE1Ha0Rj?=
 =?utf-8?B?c2dQTTV1aUJuMktSaE1jdnNvcUUzQUwrMzFmak5PZmpYLzhwOU03b2NtUldD?=
 =?utf-8?B?eHFHWVVLLzVaaWJ3SXAvK1gxVGpHZkZiMGVWeFVMcnRaWERRdDYwWDZQMEkz?=
 =?utf-8?B?TDBkajJLbkdzS1c2L0VpR2JqNEt1SThSN3I0bGRnejRCc1hwU2NsY3c4aVcv?=
 =?utf-8?B?OEYxSk9QamhCMzZ4cTB0ZmZ6MGx6MXUvanpMZTEvOFNDSHFkWFJhQUJ1U290?=
 =?utf-8?B?WlE0aWZ4ZEk3VnEzRVNVMGNTZjRlWG5obWRLNW1CZnNuT1NlTkJmQVlqOGh4?=
 =?utf-8?B?MmEzcVJDNTZ3OEthV3Jmdk5ZVlZrOHlUNnhKYkh1OHlVN0VZVytrUTE4dEJB?=
 =?utf-8?B?MllPbFhiV3RBcGcrZnp1RHpEaVF0bkNGZC8xQ1pIRk5hMjU1d1JLcHpMRzF6?=
 =?utf-8?B?UlBnbEx1THIyOWcrdnJzY2ZRa2VQZ2ZOblhQZ3Z2NW9TV1NBa0oyYW5GNHp6?=
 =?utf-8?B?eTFWOGZmZU5xbmxhcHIvRHVZV3J0RnVpWU9FcmRaK3Y5RDJBRHFEZkJjRE82?=
 =?utf-8?B?YkhaWm42eTNXeGtWdmorOWpVRng2RjBweW1kdXNoTUxNajRPSitvRytlMDho?=
 =?utf-8?B?NDlQQ0UxcHk3d1NSTXZPUTZKYkUyeGo0SDFtc2VPdHhDQXZRalpEbmVPSlNm?=
 =?utf-8?B?TTAvOWZsZXNpOHlnZEYzYjJ6REhoQlFqOTBLNWNidC9kdmpReG1PcG1iVzJ6?=
 =?utf-8?B?K0lseWR4SEVNOW05WmtyaUFZazQ1QmN4KzlNanJPcjQxNFhBV3BLUGF0UkQx?=
 =?utf-8?Q?sfpONu?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(1800799024)(14060799003)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 17:39:02.9853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ea089c-c780-4a72-e007-08ddca0fd0ae
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D12.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6505


On 23/06/25 6:56 pm, Ryan Roberts wrote:
> [...]
>
>>> +
>>> +int split_leaf_mapping(unsigned long addr)
>> Thanks for coming up with the code. It does help to understand your idea. Now I
>> see why you suggested "split_mapping(start); split_mapping(end);" model. It does
>> make the implementation easier because we don't need a loop anymore. But this
>> may have a couple of problems:
>>    1. We need walk the page table twice instead of once. It sounds expensive.
> Yes we need to walk twice. That may be more expensive or less expensive,
> depending on the size of the range that you are splitting. If the range is large
> then your approach loops through every leaf mapping between the start and end
> which will be more expensive than just doing 2 walks. If the range is small then
> your approach can avoid the second walk, but at the expense of all the extra
> loop overhead.
>
> My suggestion requires 5 loads (assuming the maximum of 5 levels of lookup).
> Personally I think this is probably acceptable? Perhaps we need some other
> voices here.

Hello all,

I am starting to implement vmalloc-huge by default with BBML2 no-abort on arm64.
I see that there is some disagreement related to the way the splitting needs to
be implemented - I skimmed through the discussions and it will require some work
to understand what is going on :) hopefully I'll be back soon to give some of
my opinions.

>
>

