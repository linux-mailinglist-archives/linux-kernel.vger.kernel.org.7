Return-Path: <linux-kernel+bounces-855417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B520BE1293
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 03:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8473A19C3215
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 01:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94641DF970;
	Thu, 16 Oct 2025 01:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="pt3YKefY"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA96442C;
	Thu, 16 Oct 2025 01:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760577828; cv=fail; b=Lvb5FB2ed7HFOoQUfpcJQc5bweAu6tdqckpybn4hPLyWUghWCAYAUDiJU/yk79nR4gpxVBj81/mbm1AVI+nTrUYZWxOnhde+KOvsHFoSNkiRvtnLHydSvCOM++qX+7IDP6XQ+WVycpQZ8TfGKN6UIuiUHN2D3MJBD7toO71Ixs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760577828; c=relaxed/simple;
	bh=0c84ltf3qn5Fasfw7I9wqNiIQUNUbSa3w5nLkcZMXiQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XbyQYfDTmO0xUKaN0P3JpUrj0snhYMMl9krzFBNIis79qdmvEyBvUoM4juWgzqdVsxbYI1wb9mZkTlE8gvgxC+B6S9FENBveMORP/GGsEoZApASdiaZ0bdlXuGkoOoJjsH5HsPvL2GiY8EC1qGuFo4Ayzkz/b9cC97/ED1HTUvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=pt3YKefY; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59FNSoYN3313173;
	Wed, 15 Oct 2025 18:23:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=UKf5vMzAweJcGi3NzaiGKdpklrQ1g0fvRuZcKndJI8g=; b=
	pt3YKefYRwMgWMDIPw6cYibZwYt8PMPfNmVfq5tpsvxWSFwA2qXkL6bvCzV9PIdj
	FPrtv5am3nz3iIQQ3d17md3kQoST1l2hENglQEeI9zAKq2ZordzaG8gnnKg7StDx
	EMFLGNm1cwjR50zz12zyu8IHBs2cUuNcG5SjMP7UjwLkfKrrVCv6S2Sbcrqa8TVO
	1Hmt75hLigwRWmZfPLOu/AuSnpdjXpvur1f4SJA6gHHQ8CyFAX71kZng2WpzHTdn
	ibzhtR57dQy5E5Z4qoWbkPo7eNy41ZC/xlOS7UsA3ozbhoqPZLEGCLZO4WT8Src5
	HlXqmFhhj2pGxDdj5Ij6vg==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49qjh1nfjs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 18:23:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4G4EpeUcmtHEeip4uXqNEBAJR0xpdeRToijjLPyQlzCIYhAzEIrWpTPRdU7kiyVopW2W1w3RWS6231jjmc8+TDf5O6pVuOULfXp/C8ZaBragBXH2XgavbZW+0Vg2fzZPQKMDMFKv5K6KoDNRGjUePjHFHjdcLrJeaoTWh6XifOY4fwmYg5pTW8zC047BauJYDI2tYpSFYYgANENROpb89fs5kKSYPwD9oQ+x76FaEPBr5fIvaDjVJLZwk5P3kI+ktL48W4KG73OeimZWiFEMBKTcB7CVfVwn5cI1p/gVb75VnyMhZAl3fdAje1ESMMCYO3tYXOsjiViWhXZoqdDeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKf5vMzAweJcGi3NzaiGKdpklrQ1g0fvRuZcKndJI8g=;
 b=BStHI6+vu3BwIrK6bq7+77V9Ng0XTA/61ruREFPOE4uuVewUUCnbwreI7iyLdraV0V2BoQ1Bl+g0/POYvDYjqT09Yr5UTugixw7zVjPXaeEx9GJQMKwOPE/DYcotkVaoibZ6lHRvAlE3/9kz4guz01Sw1xdt/LKqwQ45Lh4oPxfV79hP/Jh81CkFm/uvcTzM0lp99SZ8RHVLnvj/aoVb6TuFjIp1C9z4qOHOuPpxEogcfr+aJ43fzTMLPRkzxnkKmIwNdyKHTlN7Ppo98aMZeAia6OKI5WpQmYPkhU2I4o9ES/sAaAm+Qhk+e5AtZCezt7unLeEhix+DfmjbLyfNrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ5PPF2F7FC4EE6.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::81d) by CH0PR11MB5314.namprd11.prod.outlook.com
 (2603:10b6:610:bd::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 01:23:34 +0000
Received: from SJ5PPF2F7FC4EE6.namprd11.prod.outlook.com
 ([fe80::5cd3:aaa1:1564:3e48]) by SJ5PPF2F7FC4EE6.namprd11.prod.outlook.com
 ([fe80::5cd3:aaa1:1564:3e48%5]) with mapi id 15.20.9228.005; Thu, 16 Oct 2025
 01:23:33 +0000
Message-ID: <9c8a8df4-f69c-4407-911f-0402bd06f4c5@windriver.com>
Date: Thu, 16 Oct 2025 09:25:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] clk: fix slab-use-after-free when
 clk_core_populate_parent_map failed
To: bmasney@redhat.com, mturquette@baylibre.com, sboyd@kernel.org,
        dianders@chromium.org
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251002061215.1055185-1-yun.zhou@windriver.com>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <20251002061215.1055185-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0278.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::19) To SJ5PPF2F7FC4EE6.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::81d)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF2F7FC4EE6:EE_|CH0PR11MB5314:EE_
X-MS-Office365-Filtering-Correlation-Id: 012ca287-1e16-48f6-19a3-08de0c529f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFltcHlGdjloMDNiNHVJOEk4eUZGM21Rb1VUK0ZmUkc5a3FORy96U1BtYUM3?=
 =?utf-8?B?ZnJOdVgvSUJidXN3K2JLYUcvOVVqdDZWcmVWNUJVbmtlMXRWSW9TZjhINkdj?=
 =?utf-8?B?N0tmdzBhWGRURVNMUlhNUGc0N1htWVZwbWN3UGlNQXJrRVlMTS9MU1hkTHFC?=
 =?utf-8?B?V1E1U0pOUUVqVW9pY05WMzFmbW04cmN3cWdIQ0ZhcE5PaW1mTEY2Q1FKZmFy?=
 =?utf-8?B?R3l3U0tzSmlLaHR5WExsMjJOMy9YN1I3M0xmaENrNlZZQTFiclZuYllqbisw?=
 =?utf-8?B?TGlxMHJSNW5OYUt2amI3K3RlT0dFZFdBcHRMbkt5cnQwbzJSWURSRGFFbzhj?=
 =?utf-8?B?azhUUm9OeVkxUjlINVpRMCtWZktqL3k1VkY5blJjRk5VbVBjSkMra3FYb0xL?=
 =?utf-8?B?M0ZCNVB1Z1Eyd2E2Z1lkV21LalY0by94aG91VUNUYnNaSGtWdnhjNVBubXNt?=
 =?utf-8?B?aWIrNjNLRWxOUFBGNFZMNkNRL3NXdFcrMk4xWTZxY2xEUWQ3STlITDlmazZX?=
 =?utf-8?B?UCt2aFQvRUs2dGtwOFhOU2JoYm82TkNTZmRCUDU3UHo0dkhUeVBaV1hMZ3VY?=
 =?utf-8?B?SENaVkp0cnI4MFFTZ1l1WHdHU0pwWlZVallOVDUyajhDNEVQa09HWkp6Mnph?=
 =?utf-8?B?N1Z1OU1FZW1WVGljQ004bGhMTmVUbmxGWi9FeENIS0pnaE1oVHhSd0M0c0M2?=
 =?utf-8?B?NkNQWWJiRzBqQlJoSkpyeUp2azErTVc2eVFvV1FQL0k0K01OaFc5MFBRbDUr?=
 =?utf-8?B?K1JuaXR4UkZEbllPYlJZU21DR0dkbFFPOHJCejltd21nWEt1YzYzbnNQaER6?=
 =?utf-8?B?WDMxUmw3U2poYVEyMU9wUjhlMkdXNjBLWkVKck1TMUFONU9FQWg5SWFVcFIw?=
 =?utf-8?B?TTllVjNVYVduY1J2QzdXc0thcXdrUVdjRC9KVk5QMTJLa09xQlpCZWw3TlhJ?=
 =?utf-8?B?T0RiMzA1U0FUTzhtTWdTaTVtZWZuaFJXTUlpUkZGREtRLzVvaStNNzJJbjFo?=
 =?utf-8?B?enVRbkQzbHdYck9VMU5rZEZvZ3VGUitWZXBZc2EyeCtiWWRLUHhVVmJmNnhN?=
 =?utf-8?B?Q1l0Zmp4V2NEZHMzakJieVFDVmxuV2RuZm5JSXFkVDlQc2F5RlZ4OG41dmFE?=
 =?utf-8?B?ay9ubkYxMGRDbnR1Z2tUbkk0OUdlZ0NVcG9YbGxkRnRZaVdOWnd6MGNoenVy?=
 =?utf-8?B?YWhCL0pJa1IyQkh1aXA3eFE4SVhVL3oyd21QMFdoN0lOMnNnd1NidzAwMG80?=
 =?utf-8?B?K0RZMTFWSDc4eGVVTlR4QUVMd2s4UFEwN2ZsVWJIWEIvbVczbXdJMG96TG1v?=
 =?utf-8?B?MW83dUlzaUJ1NWZMTVZUcmV2M3ZwK3J1TEhTRmEvQ0loNnBKR3ZuZ2Q4T0JN?=
 =?utf-8?B?SDd6dmdRa3BYd0ZzYTdFVXdDbzlsL0hrM0xlMDZhTDJCTEpZY3hOVWZ1cHN1?=
 =?utf-8?B?UXhkaklrdXRiMURqSGd6OVdmaXNsSXkvMzlQN1BteUQwWmd4eGNWdlJQT1oz?=
 =?utf-8?B?UFFVcit5RmlmN3FQZ1FYdkVLbHl2VmpOOFA5S05oZTBxcUtjV1JXTUFMK0s4?=
 =?utf-8?B?Vk5yTnpEV0czTE9sTjJaeFlLNXF3WmtlNklBWXk1R3k2NlV4RTEvYmlYQm4y?=
 =?utf-8?B?TWlqVkcydllNNzN6OEFxdFR1T2dRM0UycGxRc2VvcFBUVWp1K0xyRkRLckpZ?=
 =?utf-8?B?dWU5WXBHVGdxdGtPN084NDlCZm5xRU4wWnJVVUhvaU9zWUNZejdHZFJKQlBV?=
 =?utf-8?B?MndYN2gweERMOEdiQlQrcHhEanFHNDl5R2dUQ1p3ck01SXNJZTZBZjhpclcz?=
 =?utf-8?B?bUxMckVSRXMzbmhQYzJsS3NKTkVPL2NZN0ZkZEkvejFHNXFpZVZmQkZCbjBF?=
 =?utf-8?B?TGUxZGpCSDMwd2V5VEg0MU1TamhvN21yMXVuWk5xL2w3M3h1SGxVMFRNRURz?=
 =?utf-8?Q?umeJ2Ar0d0KSO2h5AEeRiqMin2xFjvP7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF2F7FC4EE6.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czhYd2ZMVWE3M2dwalNoTEVkRWFqNkNiMFYyK1p6TjMxWU5WRGJMMmcxNXM0?=
 =?utf-8?B?aVRHNnZBRi9VMTlkYi9SZ0xYdG5oOGdQcnVpbWNYN3gwZkZzOEkzc2hMWlV2?=
 =?utf-8?B?T0VISWJtUnM1OUhka2dQaENyWFhvbVhRMkVSOFRoYXY0SWtTMVk1aHBYYW5K?=
 =?utf-8?B?OCtvc2RVS3J4TmFTeDEzeThLOStPeVNZemRabGw5OHhPN2NrQkZxTWpKZEN3?=
 =?utf-8?B?MnlROGpsb3Rmc3RxR3NSQkk0TE4yZjY1ZFlMamxiNURkcGtVUUNXZm1oUEE3?=
 =?utf-8?B?bXRVT1NpckhwNzFkZ2xIclFPMm5TNThhZDUvMmlYM25mUDJQWXFrZEJPY09O?=
 =?utf-8?B?N3JMeUNLRU91Vkh0RGt2VFI5eURiQnNZTFdtQlVrVVY0cVBUK01ObVArNUla?=
 =?utf-8?B?OGFtbXBWQm84TlhkTVNDbVVmcU51TzBJSzM5dFdEbEpvN0YvVjFSLzJDVUM1?=
 =?utf-8?B?UUlnRytlR2EwdSt2YWphTjZUcUppdEk1SGI2aFJHL1pjVTBZZWpsaHNOeVdj?=
 =?utf-8?B?S1pnM0FadmlHczdESDVTVFZZTlBkSG91UDljaDBwY2Vzdmx6U0loYWpVczZr?=
 =?utf-8?B?dGpFSVZqdS9XSFdPZk9qUmlnTjFpM0I2WjZzdWI2Vy9Od2p1bFVidTFjL1VU?=
 =?utf-8?B?bGRnOTRKSVRuQWgrQ3FpMUk3ekJIMUFQeitHT3JZOEUrZFBRUkVxWFRFN2xi?=
 =?utf-8?B?MkpRejQzaE5BZGFhbXZ5aVdQOHRqMmJPSE56bU9LVTNEYXZYSzJFZndkcUla?=
 =?utf-8?B?N3RBckMwLzM1cWVremJRL0MremZESDk2MkY0T2J3UWZaUmh1MWdZaUZHaElD?=
 =?utf-8?B?b1liMG55dVBPRWdnMkZMVVZnai9XSmZTUk5vWEdXZE1xMndMWCtleVVQY1Rt?=
 =?utf-8?B?dGhDUk55TlpWUkQxdlVIYU9iM25rVlA1Nlg5STMyQ3R6cFlBenNYRlZXSmox?=
 =?utf-8?B?UkFsZmZJRytQQitsY0laTnVUU3dIVU9rTGwwUEJoekxDUTlXUkxzNEVobks2?=
 =?utf-8?B?MHplTFZRVFg0Ukx1SUFPYi9mMVZDdWwvMFlGMmtUOXVLY1BqMlFvSVN5dFFJ?=
 =?utf-8?B?ZmdDQVpkdDNqcU1DY0tCajRFZWhVM0pFNktjeDd5YVFTTWdnY1NuUFo4cDNj?=
 =?utf-8?B?VGIzSlQ1NXNkeEhCUXVrYzZERnpHWTQwOFRHb05CZnl0QlN3c1hlRisrRlo5?=
 =?utf-8?B?MmsrZno3ZjY4TEtXOWVHMUdUQnNBZjkrNVdtSWVvVnJwaGZ1RDVMazNFSlor?=
 =?utf-8?B?K3EyMUk5Mm1KbzlyZFdvQ1NaOXdmRDBuYmFFY1VLRnJKbjBFRzVjUTRCaWdj?=
 =?utf-8?B?dTQ2L2JzNzcvVjBUUkNSYU9Vc041cDl6RGlRUk1QR1lCZk9uRWgrdU1mL1o2?=
 =?utf-8?B?aVJjWGdsZG9hdUlZN3lhOExlaEJuUEg3NWl1K0ZLK0R0Z1FMV0hXdU8zWFVD?=
 =?utf-8?B?ZjJZeW4wU2NQRjIzcEhrdm9zN3c2M25WZ2FheXhNWkw3Tm9kSEtFbVREZ3dw?=
 =?utf-8?B?a1BNOHpqcjhyZ0pGRDF4dlB1K1FWc2ppQitLampyanc1R3Uyck15ZlpyMm05?=
 =?utf-8?B?WDJyVnFzUW03eUVpSkFTTUdiK2kvSVBuSmxUeHM0NG1Na2hNT1plckZLYWUr?=
 =?utf-8?B?NzZzVDN6SjdxbzY5dWJXYmxJd2l4U1VwT3BKa2orb283MTc5aWNnVURFVDAv?=
 =?utf-8?B?RSt4T21FL3kxdkxOWjdiVW16ejU1UVBnUFV0TUE0U1FOd2I0MVRzVGU5MjF4?=
 =?utf-8?B?TTJsZVNJRkNUUURpZE84Tjg3N0lBK1N2Uk5ZVUl3ck1CYytMVVdMTlg3OVEx?=
 =?utf-8?B?QlI4MWpwUTV0ZXBBaHhjNHBySkhmcUlTdm5teVZjL05HY09obG9DWjBaZmhw?=
 =?utf-8?B?enl3Z0hhVkpLR3pwT1lWdHQ3d0drbEV5aC93RDkzT0N5TmNwcEJLaXN4bUx6?=
 =?utf-8?B?VWFRUnhpLzMxd2xtaHdqeVRVV29CcTF4WVlLR3I0YTBFODRoZ2RaZnJDeVhp?=
 =?utf-8?B?aWtneWx3YkcyMnFjcFovb05xNUJoWnVacENUcXB4R2xYUFN6LzcyKy95Y3Bh?=
 =?utf-8?B?Q0dSZkszcG9lMEtLVnk0d1ZEaURGVyt6L1U5NXh2ZHBCVUFNQnJRZnUzNDFm?=
 =?utf-8?Q?6cJ8Q8Ag5AF9o0hpddIliyvt1?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 012ca287-1e16-48f6-19a3-08de0c529f4b
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF2F7FC4EE6.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 01:23:33.7058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxNqt2OQ3Eu+gpfxbIZ2xE5q6fvyeFuB7hoMw5eD3Kc4zhYuPim6958OsTS8YflMJdPfp781hjASXYPmBAkC7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5314
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDAwOSBTYWx0ZWRfX4en80+ltP3W4
 +sVN9Re0FxSpq5XXvXbI0uj4zfqtA7a+UVlOlnsnfZ3umrS8Jp0wjiKqgKda5hpygkrKS1F89hG
 iJTt4vzLP95vRMIFhkHqjxAPMrfZhqaUupoJmjAd7tGCGbGFXlmJP9Muqd1RbmTVwzIBVzuG7iR
 v0Fk2JHNbj8jWPC+rYzMs4oWdt9B3p5NCN0Zr/WF152KvnoFoFGUYYpMdYPBy5nZd00xCP63duv
 LTwhfVUoufvkn+A+T606IT/4CvdMcqSQifoufQEHTPYO9gIPXoZPsiJeF5cp3x2a0yHH7XRUf6Z
 e8iaTXhcQVP4TFdpZq0i1pNLppSkLd3hsBcp0flwWwkh6CJMuMq5BYRopq4gFH7Xz1NkoMIBW9B
 eiKXyUZpnMMawtC9asg/BX9jh+x3pA==
X-Proofpoint-GUID: 7oBjnhVXjx7IFBehqlTVHs3REr5Uj_De
X-Proofpoint-ORIG-GUID: 7oBjnhVXjx7IFBehqlTVHs3REr5Uj_De
X-Authority-Analysis: v=2.4 cv=aetsXBot c=1 sm=1 tr=0 ts=68f0491a cx=c_pps
 a=Uzy17SEabGn9o4QNHCkmvA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8 a=20KFwNOVAAAA:8
 a=pTnrfKvW9UhFVF-HwIoA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510160009

Hi Brian,

Can you help me check if there are any issues with this new patch?

Thanks,
Yun

On 10/2/25 14:12, Yun Zhou wrote:
> If clk_core_populate_parent_map() fails, core->parents will be immediately
> released within clk_core_populate_parent_map(). Therefore it is can't be
> released in __clk_release() again.
>
> This fixes the following KASAN reported issue:
>
> ==================================================================
> BUG: KASAN: slab-use-after-free in __clk_release+0x80/0x160
> Read of size 8 at addr ffffff8043fd0980 by task kworker/u6:0/27
>
> CPU: 1 PID: 27 Comm: kworker/u6:0 Tainted: G        W          6.6.69-yocto-standard+ #7
> Hardware name: Raspberry Pi 4 Model B (DT)
> Workqueue: events_unbound deferred_probe_work_func
> Call trace:
>   dump_backtrace+0x98/0xf8
>   show_stack+0x20/0x38
>   dump_stack_lvl+0x48/0x60
>   print_report+0xf8/0x5d8
>   kasan_report+0xb4/0x100
>   __asan_load8+0x9c/0xc0
>   __clk_release+0x80/0x160
>   __clk_register+0x6dc/0xfb8
>   devm_clk_hw_register+0x70/0x108
>   bcm2835_register_clock+0x284/0x358
>   bcm2835_clk_probe+0x2c4/0x438
>   platform_probe+0x98/0x110
>   really_probe+0x1e4/0x3e8
>   __driver_probe_device+0xc0/0x1a0
>   driver_probe_device+0x110/0x1e8
>   __device_attach_driver+0xf0/0x1a8
>   bus_for_each_drv+0xf8/0x178
>   __device_attach+0x120/0x240
>   device_initial_probe+0x1c/0x30
>   bus_probe_device+0xdc/0xe8
>   deferred_probe_work_func+0xe8/0x130
>   process_one_work+0x2a4/0x698
>   worker_thread+0x53c/0x708
>   kthread+0x1b4/0x1c8
>   ret_from_fork+0x10/0x20
>
> Allocated by task 27:
>   kasan_save_stack+0x3c/0x68
>   kasan_set_track+0x2c/0x40
>   kasan_save_alloc_info+0x24/0x38
>   __kasan_kmalloc+0xd4/0xd8
>   __kmalloc+0x74/0x238
>   __clk_register+0x718/0xfb8
>   devm_clk_hw_register+0x70/0x108
>   bcm2835_register_clock+0x284/0x358
>   bcm2835_clk_probe+0x2c4/0x438
>   platform_probe+0x98/0x110
>   really_probe+0x1e4/0x3e8
>   __driver_probe_device+0xc0/0x1a0
>   driver_probe_device+0x110/0x1e8
>   __device_attach_driver+0xf0/0x1a8
>   bus_for_each_drv+0xf8/0x178
>   __device_attach+0x120/0x240
>   device_initial_probe+0x1c/0x30
>   bus_probe_device+0xdc/0xe8
>   deferred_probe_work_func+0xe8/0x130
>   process_one_work+0x2a4/0x698
>   worker_thread+0x53c/0x708
>   kthread+0x1b4/0x1c8
>   ret_from_fork+0x10/0x20
>
> Freed by task 27:
>   kasan_save_stack+0x3c/0x68
>   kasan_set_track+0x2c/0x40
>   kasan_save_free_info+0x38/0x60
>   __kasan_slab_free+0x100/0x170
>   slab_free_freelist_hook+0xcc/0x218
>   __kmem_cache_free+0x158/0x210
>   kfree+0x88/0x140
>   __clk_register+0x9d0/0xfb8
>   devm_clk_hw_register+0x70/0x108
>   bcm2835_register_clock+0x284/0x358
>   bcm2835_clk_probe+0x2c4/0x438
>   platform_probe+0x98/0x110
>   really_probe+0x1e4/0x3e8
>   __driver_probe_device+0xc0/0x1a0
>   driver_probe_device+0x110/0x1e8
>   __device_attach_driver+0xf0/0x1a8
>   bus_for_each_drv+0xf8/0x178
>   __device_attach+0x120/0x240
>   device_initial_probe+0x1c/0x30
>   bus_probe_device+0xdc/0xe8
>   deferred_probe_work_func+0xe8/0x130
>   process_one_work+0x2a4/0x698
>   worker_thread+0x53c/0x708
>   kthread+0x1b4/0x1c8
>   ret_from_fork+0x10/0x20
>
> The buggy address belongs to the object at ffffff8043fd0800
>   which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 384 bytes inside of
>   freed 512-byte region [ffffff8043fd0800, ffffff8043fd0a00)
>
> The buggy address belongs to the physical page:
> page:fffffffe010ff400 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffffff8043fd0e00 pfn:0x43fd0
> head:fffffffe010ff400 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0x4000000000000840(slab|head|zone=1)
> page_type: 0xffffffff()
> raw: 4000000000000840 ffffff8040002f40 ffffff8040000a50 ffffff8040000a50
> raw: ffffff8043fd0e00 0000000000150002 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   ffffff8043fd0880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffffff8043fd0900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ffffff8043fd0980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                     ^
>   ffffff8043fd0a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffffff8043fd0a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
>
> Fixes: fc0c209c147f ("clk: Allow parents to be specified without string names")
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> ---
>   drivers/clk/clk.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index b821b2cdb155..b93f38de4cac 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -4254,7 +4254,6 @@ static int clk_core_populate_parent_map(struct clk_core *core,
>   	 * having a cache of names/clk_hw pointers to clk_core pointers.
>   	 */
>   	parents = kcalloc(num_parents, sizeof(*parents), GFP_KERNEL);
> -	core->parents = parents;
>   	if (!parents)
>   		return -ENOMEM;
>   
> @@ -4295,6 +4294,8 @@ static int clk_core_populate_parent_map(struct clk_core *core,
>   		}
>   	}
>   
> +	core->parents = parents;
> +
>   	return 0;
>   }
>   
> @@ -4302,7 +4303,7 @@ static void clk_core_free_parent_map(struct clk_core *core)
>   {
>   	int i = core->num_parents;
>   
> -	if (!core->num_parents)
> +	if (!core->parents)
>   		return;
>   
>   	while (--i >= 0) {


