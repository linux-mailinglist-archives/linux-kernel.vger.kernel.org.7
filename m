Return-Path: <linux-kernel+bounces-898312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB670C54D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 00:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 78C18347E79
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC792BDC2B;
	Wed, 12 Nov 2025 23:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nSQwpOIX"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011024.outbound.protection.outlook.com [40.93.194.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0FC265298
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 23:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762991421; cv=fail; b=dn3fcJJ3F041TjZcerErTWaAKny1f9jx+10JrSeIxf3PZOq6v+2o/iP+vWLWfXF0t/Tf3XW27DSrHaBhcTKNuiO4sB80o7nA2bRK9h9xP3sp9EgtWPOVCvlCQWw6oLOjetuOrGHuK+MtnW52OxARq7RqvPcYM4xv2K+qQaee6jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762991421; c=relaxed/simple;
	bh=2IbThGtYLNM0JlvJgzkk087t4zRfq50UUpp5dRlM5ss=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Chc8ZePxkmp7trxSlWLv+dcnRk/0P+kEVasrSXL/nzrA9ljF/u6w0yUfFnpq77rJAgvI6zcw7yxcbnCv38QtFfZchEo2gflklGTVEsmW0z0YticJdE0N1m/2jU2V82AsaBl3+0kjFc5CaAWz4oZhW2UmmYMuHL+jKOlL/pgseBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nSQwpOIX; arc=fail smtp.client-ip=40.93.194.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNuwc3PHBHgO9C+B0wb39YQWowLrByonpTKaySi6jUsButRbq8+MMenNLg9QwmfTCFLNQdVBEtQTEUdoBl0q5j891eCo2RG08bmy4aLNHylGNdPPpPtj4V2RtHmCvUMo4TtWRceNO3TGTK4D1gjJBIJzI55KOCG1NeCdgzyUWF1988FpO8v4lrFQnGh8xQbclPc3apZxnsr/MPHKqrzlBJdPoyxCQk5IUuByRAV39EptZOcHeL595ibCKjQ6nsZSuT0/ZPyD7YJxBh9oEMFSveZj851iPQgMYHfr1f/97Z7CkfFdSQ9Y0dTEV8AvEIHVYbmfqwMvuBIIQs59u0fimA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUEGj+D1Y+2W0y6k/XF56eIBc9Qq0FeXlI9HqaAes/c=;
 b=u2QLDFHqHKCqc4DfGvuHbpz4QygwnhRnVpC2L4nHCH+gToNAz4ydfh3uu+CIk2NqlH1bRXWw8xLU1Mea9BI+m6PfKAqwpM1193/zyIyZAQlo/eS4Up/4FvdpZbJj8GdetzuPHuIHamSmyl+exiBY4xB+N6ZimYX+nAmsC391KwTs0R512cLNVcVr4tGUpDVQWdYJKDAofJhryfyJgqfLWGgc1D6h3FSOeB8rR335WVoxsTxPc6zjPx7We3zfORVbwK6AKFGtCulQMRFiLmIOqBt8thbRfXETJwCQwMytUb2DqWQbb6R9f4zR0Fo34PfIuKNhVXkOqNlbVmTdEPv7Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUEGj+D1Y+2W0y6k/XF56eIBc9Qq0FeXlI9HqaAes/c=;
 b=nSQwpOIXxi5RHiwZtT2w5T0OOEu6Tkg13gRvwFovpGN49p4ZC/5ghOEKTlr7KHLl8X34TbxdTJrPQ8tEaajcuNMMDNjgrzOrnRNHaQbeaYrsiSXzN8y/wmLpDiETSEP5PlBQonhWshRthxJHGzc8pWeM1MYiHzafPPe13bHCGmbn+QUEowfYm40jAKhw11i8waipARNkQPlj9Qdf3qzDp1puRAz1NsJ8ZOeeqcIEzbsKAqsSANNx6hLqEREMiKax5fiL9gU1GTLTJvpLYd+svM1Et6QlFEwVj5gMZ4A0R1ZF98U1WfN3eHJV39RQ9rWk7u6dfQ6+og8F7tRZthFbUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 23:50:05 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%7]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 23:50:03 +0000
Message-ID: <bf8e0c95-15a1-4eac-ba2e-52d361050039@nvidia.com>
Date: Thu, 13 Nov 2025 10:49:55 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory.c: introduce split_unmapped_folio_to_order
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ralph Campbell <rcampbell@nvidia.com>,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20251112044634.963360-1-balbirs@nvidia.com>
 <048134fd-6a3d-4a6c-a2eb-9a9911c3b35f@kernel.org>
 <efa37c4d-8c9f-4094-a713-4fd4452ae917@nvidia.com>
 <826df5b1-b61d-4794-a96c-dcf9ac19e269@kernel.org>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <826df5b1-b61d-4794-a96c-dcf9ac19e269@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:40::36) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|DS0PR12MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: 13a78b36-1a08-46f8-f64c-08de224632bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGY3MGE1SE5pellWVHBLOWd1QjFmemxyczNXSnV4emtIM3hZK2JybkFCSm8w?=
 =?utf-8?B?WWVpMGdYWGtPam9ZY1dNL25PUFk2UGZBTHZuNE15QlBvWEhzTm1zam1MR1JX?=
 =?utf-8?B?bEVvK1JXaGFTRG9rTWN5VDZlcGJ0Y1pnQS9oOC9KSTRnaExwOHhMQTkvK0o0?=
 =?utf-8?B?NzhOaGloT0g0TzhhUTF3QngyR245RzlyeVBtQzM3VCsvb3FibjR6akhoRXEy?=
 =?utf-8?B?dUtmUmp4ZFFXOG84NURFbWJrZnIzYUJlYndhelBKUUtvTzNua3B2OWxWN05O?=
 =?utf-8?B?YnJWdHVvNmlrcEZzUGlaL2c2QVphMW0rRnVDSnhzanYyS1NZMkx6ZTRXNCtW?=
 =?utf-8?B?eVI4VUZxTmxTVURQeHlyck1mbXoxYkJINzFxTXB5WmdRMkxwckJ4UmdXTE9C?=
 =?utf-8?B?TnZrODlWY3ZQaENRNlhGV0pSUkp3QlpKUUNITzI0eEhMSVM0K2FSd3d1bTRR?=
 =?utf-8?B?b3F5QzdWbkdob0hBR291RUd6Sm9YN0tqZWo3Z1ZYYUlNeHhRVnc5OWc2Tmk0?=
 =?utf-8?B?YzhwVUV3eW5BQUZvUUtZeVN2Z0tsbEZ3L25hRFlSYVc1TkpTR3Q1Y3BRcjFh?=
 =?utf-8?B?dmRxcEhUSkI0V0NwV1RWMExvWkczbHRRRWMzSE5YdHNBbkp0NXRGUlZocEQw?=
 =?utf-8?B?ejVWOTR2NUU5NlkzdXhucGNicGdjY09lRmZUR0Y4VC9CRGx1KzFUaUEvZmxJ?=
 =?utf-8?B?Z3Bua25YTU1SS0dBNDRWem5GbFZiQllPNjhZUE9lamYzTlEwUnFmd0JwZzZQ?=
 =?utf-8?B?RzVhL0ZvSGNaMkZZSFlFazg3WU5RYTUrM1hJUlhNZlhMVkFta0VPa1ZKdTFH?=
 =?utf-8?B?eWIzcmkycEE3K2xueW52WG9wN0R5WkpMUzRkOVFwSUU3MHFpU0QyVTB5bEhB?=
 =?utf-8?B?bWZTUVdURmxpNHdqYWY5Z2FFOFNhanBxcTVkS0lVUzNlV3dWRVVJbDhjdWhx?=
 =?utf-8?B?djA0b2V5MXBNbFZ0YVM3WXNxR0dXMUhuUzBBd3lTQTNSa0RYeit0dS9mRENy?=
 =?utf-8?B?VXNKMW1CV0pEY2dwRndoemxZTHdTVDhGcDkrOE1ZNHdzckNXb1h6bUNrang1?=
 =?utf-8?B?SFBUYVJEYnBLN0dxOXlrZ0haR3UyVlV5N1dVMml6VjZIRUh3WExvb3EzSmxi?=
 =?utf-8?B?Q0ZQVFltNVJVdHNQeG5LdE94K2dKR05QNkpONXNmVVBQcmJPMVFWT3dRQ2p2?=
 =?utf-8?B?ZnVHR0ZxaGZGZXBmTngyZW9mNENzTEwzZ2U3elNSTGlHNkpuOFJMTXlxU0M0?=
 =?utf-8?B?QTdQNFRpSWR2VnRaQTcwTm9XaEt4d1ZvUEVhL0NRcDBmQWtFSEJONWdEc3Rv?=
 =?utf-8?B?S0lWbFBRelRobnlMaEp5WUpnSEVuRWw1NFAyVjNXZWh1NzJoa2pQOUtReHRm?=
 =?utf-8?B?QlRpbllYTjdLOGpsYWIybFRIWFFTTHR3T29idWNVOFptMjRrRXRGYStVN0FO?=
 =?utf-8?B?R295L2dBbFduQ1FuOGp0TVk2WC9YNkJCZGxRUGdPbThxbmRQaWtiRXlWc2kx?=
 =?utf-8?B?aVVWMERqVEZlSWdlQUlTYm11VEdaK0xLNWpXMXlJVkROaXVtbmFYQnQrOFdD?=
 =?utf-8?B?TDRtVXJJV0FoWFBEZjZrdENSWUtZZ1JuYzd1dmFaVDgvNXdxa0VscENDTmFh?=
 =?utf-8?B?Y2tIaXNIeEovcWZSTDhNSzh6L1U0QXNrZVNJRmtMZVpQQnFnRHNhUlZab1ZD?=
 =?utf-8?B?RlBndlBSb1VpNTB6YmxCTGhMcWpMYVFSOGVuSVBKMEtaTnZDSTBERG1lQzhi?=
 =?utf-8?B?cGJ5OG12c3JHYnpPbW5oaG9udUhtVzF5VzJXaWs1QTVFbit0T2VFOWJiUmdL?=
 =?utf-8?B?blhzclN4cEVPV0IvTWxzR3JaK05DRVFQOXJOcjJEM2N3bnl3RVhwK1lDS2lF?=
 =?utf-8?B?MjJDTVJBeC9vOVFPRko3KzMzUmYxVUROV3M3S2JjYmVnV25XRnZBc1hpUjVT?=
 =?utf-8?Q?45R37QSNZzgFCsV5cSML4j9tJhJODGp3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekNVL1NvMnN0cFhVT1NPWkc1TUpzNjhaWk82YXpkaG05U2dFUFdpck1KL1By?=
 =?utf-8?B?czR6N2pqb2hoaUttaXdnZGx5WFBHVHdZNzhTUGVHdnZzSlVteGNFeGpwRHdP?=
 =?utf-8?B?UzJjbHZyQlRZU3pVR2hDVU5hYWwvYnNiVWJpZFEvR0I4dENaQjRQelpSbHZ0?=
 =?utf-8?B?ZlBQaHZ1M2hlZG9uRGY3ckZoT2pPN21QcmFPNVgyTUFPQUs2S0MyMDh0aDl0?=
 =?utf-8?B?NHN1NE9NVGp6cjU1TndTR3N0dzJBb1hmamJiU0g3UTUyU0x6aXQwRXZJUXdS?=
 =?utf-8?B?eWZIWGY4SVVxWC9HV0FBbHNuNTRIRnE5cU5ESW5MdUNJdzdiOFF6TEp0Z3ls?=
 =?utf-8?B?QnIxTTA0U0xGT3JsNGlReUVSa1pxM0lkWmFJbVEyS0NjdDNSbTNreGN0SWNv?=
 =?utf-8?B?bWt6ZFVvZk50K1NuSWErbUpIWC9zM0RwYkFzaEhZRGtJZnQyWEhZaFVPWTJZ?=
 =?utf-8?B?azYvWkNUM1hCY0EyVm9xL25yOVBCd1dFNGdmVmk5QkZ1Wjd4dmVQYVV2YkJL?=
 =?utf-8?B?RmRvRUdMZ1BmQ1J3eUxMTjNSM1E2WlZzRWFHdVBMalZsODl2eHhTYWRGdkwy?=
 =?utf-8?B?TFVLM2s0U05BdUhZeXExSXZoQ1grL2JETHprSzJzREM3Zk44ZEgwczhINTR3?=
 =?utf-8?B?akpySlp5KzViQS9jVTNWM0kvTUhPd3hzQlBBbHhUOGNCOVZvWE92MHgzT2Y0?=
 =?utf-8?B?alcrTXN1czhkUFo1TGZudGZtOTFrZEdFcXluYWs4ejJSblQwWGR0RWsrOWZl?=
 =?utf-8?B?OGlLZWtLMHFnclVUYnNhU0NDZ0dTdlRmckhwNlhiTmZKUHpGUnloN0hKOHc5?=
 =?utf-8?B?U3c2SmcxbnRoMElnYzQ4QzdNV2EzMUswVUM1SHNBbEVnUUpla1gvZ3UxRkVa?=
 =?utf-8?B?QVo4Wml1S2tlMTZGaFZGMk1Ob1c5bkdIVVlnOGxCbWpyR2M1TmppM3VXdjhW?=
 =?utf-8?B?aDIzd0JmRGk2WG44UTBTSkhpNW9rSXJYMTBxUXhvcmdISzF0RURrcXZRT21o?=
 =?utf-8?B?SXN2d2YraVM3ZFdBRm5qYUNQL0MxeGQyN0xKeHhuaFJEVzJXTmEraEtPT0FU?=
 =?utf-8?B?UUJFVURjTzlDM3lsSTFNaVpPSWNlWjdoVDdybXJ0Z0hGUnpwby9hVjh0clR0?=
 =?utf-8?B?UjRFeGNtV1ZyaCt0SnlEK2lQZ2dDWmhBaVBMVjJJZkZlcU5SZzhYRVJDejVE?=
 =?utf-8?B?dWRSendFRWhYT1dZTENVamZWZ3p0RGtFLy9SY0V1b3BTL1Z4bk9SVjc5Mk9X?=
 =?utf-8?B?Nmhia08zT2FrcS9WTnhxa2R1Vzg4Vk1tejZPL1hQUWFyYXBLbGtWVXZ5TFJk?=
 =?utf-8?B?aDkvYVNseVNxa0o5KzRxTmxJUkZNQUdTVFdudDRHa3NISkdpMGVPZ2xseXli?=
 =?utf-8?B?ejN2UUZpcTl0OUNtMXl3L0kzVUtDOXFTSnl6ZW43OXdwdkJ4N3lSNFdVTHdV?=
 =?utf-8?B?bkNnTDVmTEZtcitaMDFXSGM1M0F6VlREMjhkR0ZrRjRGbGVWODFzZEhyVkFB?=
 =?utf-8?B?VzJZQmMwaGh6N1FHQit4a3B5ZWNLdG5wM1VNcTczUXcvR2wyWmsvaVFkU3cy?=
 =?utf-8?B?b2lhbGR4ajJxbFFPVUUxWTNsa2FycmJYVWJVTXhkelhsZXdvRk93YjdsTVJK?=
 =?utf-8?B?c2piZHVOTkJwOFZ0a2JrMjJvTU1oMHo1Y294NGtZY1FvMTRQcjRoK05DMVJY?=
 =?utf-8?B?SVVWL1dUUS8zZTR3Y0Q4a1VyVEgwaHR1dmIwdklyb1lkb3NOaW93Q2NsdGhB?=
 =?utf-8?B?ZEVOK2hEa0FUVmZJaFVNa0xyRkJNMEhjSkRwa3dETVp2Um1vT0xhOXMzdVE0?=
 =?utf-8?B?WEpvTUx5M2hDSkpKZ3lxZXZra2xJMXBvaTlGL2tUekp5VmlxN0RmQklXL2ZS?=
 =?utf-8?B?SFk3WWEzYlg0aDF2L0d2Y2d2c0R5T25pVGppQlJ6bFA4eG9yb3RyYlFQMlRo?=
 =?utf-8?B?aDBXWGhWT2pnUEJGU0RCK1dBbTl0VVdMSWhKS3EwY1ZscmtHR2k5amx0TDZ6?=
 =?utf-8?B?bWNyQUZwcEtscmc5RjJnL1VLektlL2l1SVJ1Q3djUDRtR1pyOTNpMTVQS3hk?=
 =?utf-8?B?aW5HZDNXa3NVem1ZcUhzNzNIUkJtQ1BKMS9kZ3A2QzVDNzI3RU9RN3NtOFRi?=
 =?utf-8?B?VDBwbDQrRzdwVXRQNjRrNm55NmFPc2I0bXBLckoxUEFPRWtiY1VjZjNvby9r?=
 =?utf-8?Q?uON9bLdYZugG6XIM3CiLdF1FMsGwHpblIvPZw1kaVpnc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a78b36-1a08-46f8-f64c-08de224632bf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 23:50:02.9605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mwrq0z7aZOFUZ/rjVVhJQoHwu5WIXQno2KIh5Sdo5POEdGACRBigAiSONXpjgAaOunCZbApub4zThC1OEVeqXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8294

On 11/12/25 22:34, David Hildenbrand (Red Hat) wrote:
> On 12.11.25 11:17, Balbir Singh wrote:
>> On 11/12/25 21:00, David Hildenbrand (Red Hat) wrote:
>>> On 12.11.25 05:46, Balbir Singh wrote:
>>>> Unmapped was added as a parameter to __folio_split() and related
>>>> call sites to support splitting of folios already in the midst
>>>> of a migration. This special case arose for device private folio
>>>> migration since during migration there could be a disconnect between
>>>> source and destination on the folio size.
>>>>
>>>> Introduce split_unmapped_folio_to_order() to handle this special case.
>>>> This in turn removes the special casing introduced by the unmapped
>>>> parameter in __folio_split().
>>>
>>> As raised recently, I would hope that we can find a way to make all these splitting functions look more similar in the long term, ideally starting with "folio_split" / "folio_try_split".
>>>
>>> What about
>>>
>>>      folio_split_unmapped()
>>>
>>> Do we really have to spell out the "to order" part in the function name?
>>>
>>> And if it's more a mostly-internal helper, maybe
>>>
>>>      __folio_split_unmapped()
>>>
>>> subject: "mm/huge_memory: introduce ..."
>>>
>>
>> I can rename it, but currently it confirms to the split_folio with order in the name
>> The order is there in the name because in the future with mTHP we will want to
>> support splitting to various orders.
> 
> I think we should start naming them more consistently regarding folio_split() immediately and cleanup the other ones later.
> 
> I don't understand why "_to_order" must be in the name right now. You can add another variant and start using longer names when really required.
> 

Ack

>>
>>
>>>>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: David Hildenbrand <david@redhat.com>
>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
>>>> Cc: Rakie Kim <rakie.kim@sk.com>
>>>> Cc: Byungchul Park <byungchul@sk.com>
>>>> Cc: Gregory Price <gourry@gourry.net>
>>>> Cc: Ying Huang <ying.huang@linux.alibaba.com>
>>>> Cc: Alistair Popple <apopple@nvidia.com>
>>>> Cc: Oscar Salvador <osalvador@suse.de>
>>>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>>>> Cc: Nico Pache <npache@redhat.com>
>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>> Cc: Dev Jain <dev.jain@arm.com>
>>>> Cc: Barry Song <baohua@kernel.org>
>>>> Cc: Lyude Paul <lyude@redhat.com>
>>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>>> Cc: David Airlie <airlied@gmail.com>
>>>> Cc: Simona Vetter <simona@ffwll.ch>
>>>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>>>> Cc: Mika Penttilä <mpenttil@redhat.com>
>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>> Cc: Francois Dugast <francois.dugast@intel.com>
>>>>
>>>> Suggested-by: Zi Yan <ziy@nvidia.com>
>>>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>>>> ---
>>>>    include/linux/huge_mm.h |   5 +-
>>>>    mm/huge_memory.c        | 135 ++++++++++++++++++++++++++++++++++------
>>>>    mm/migrate_device.c     |   3 +-
>>>>    3 files changed, 120 insertions(+), 23 deletions(-)
>>>>
>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>> index e2e91aa1a042..9155e683c08a 100644
>>>> --- a/include/linux/huge_mm.h
>>>> +++ b/include/linux/huge_mm.h
>>>> @@ -371,7 +371,8 @@ enum split_type {
>>>>      bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins);
>>>>    int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>>> -        unsigned int new_order, bool unmapped);
>>>> +        unsigned int new_order);
>>>> +int split_unmapped_folio_to_order(struct folio *folio, unsigned int new_order);
>>>>    int min_order_for_split(struct folio *folio);
>>>>    int split_folio_to_list(struct folio *folio, struct list_head *list);
>>>>    bool folio_split_supported(struct folio *folio, unsigned int new_order,
>>>> @@ -382,7 +383,7 @@ int folio_split(struct folio *folio, unsigned int new_order, struct page *page,
>>>>    static inline int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>>>            unsigned int new_order)
>>>>    {
>>>> -    return __split_huge_page_to_list_to_order(page, list, new_order, false);
>>>> +    return __split_huge_page_to_list_to_order(page, list, new_order);
>>>>    }
>>>>    static inline int split_huge_page_to_order(struct page *page, unsigned int new_order)
>>>>    {
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 0184cd915f44..942bd8410c54 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -3747,7 +3747,6 @@ bool folio_split_supported(struct folio *folio, unsigned int new_order,
>>>>     * @lock_at: a page within @folio to be left locked to caller
>>>>     * @list: after-split folios will be put on it if non NULL
>>>>     * @split_type: perform uniform split or not (non-uniform split)
>>>> - * @unmapped: The pages are already unmapped, they are migration entries.
>>>>     *
>>>>     * It calls __split_unmapped_folio() to perform uniform and non-uniform split.
>>>>     * It is in charge of checking whether the split is supported or not and
>>>> @@ -3763,7 +3762,7 @@ bool folio_split_supported(struct folio *folio, unsigned int new_order,
>>>>     */
>>>>    static int __folio_split(struct folio *folio, unsigned int new_order,
>>>>            struct page *split_at, struct page *lock_at,
>>>> -        struct list_head *list, enum split_type split_type, bool unmapped)
>>>> +        struct list_head *list, enum split_type split_type)
>>>
>>> Yeah, nice to see that go.
>>>
>>>>    {
>>>>        struct deferred_split *ds_queue;
>>>>        XA_STATE(xas, &folio->mapping->i_pages, folio->index);
>>>> @@ -3809,14 +3808,12 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>>>             * is taken to serialise against parallel split or collapse
>>>>             * operations.
>>>>             */
>>>> -        if (!unmapped) {
>>>> -            anon_vma = folio_get_anon_vma(folio);
>>>> -            if (!anon_vma) {
>>>> -                ret = -EBUSY;
>>>> -                goto out;
>>>> -            }
>>>> -            anon_vma_lock_write(anon_vma);
>>>> +        anon_vma = folio_get_anon_vma(folio);
>>>> +        if (!anon_vma) {
>>>> +            ret = -EBUSY;
>>>> +            goto out;
>>>>            }
>>>> +        anon_vma_lock_write(anon_vma);
>>>>            mapping = NULL;
>>>>        } else {
>>>>            unsigned int min_order;
>>>> @@ -3882,8 +3879,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>>>            goto out_unlock;
>>>>        }
>>>>    -    if (!unmapped)
>>>> -        unmap_folio(folio);
>>>> +    unmap_folio(folio);
>>>>    
>>>
>>> Hm, I would have hoped that we could factor out the core logic and reuse it for the new helper, instead of duplicating code.
>>>
>>> Did you look into that?
>>>
>>>
>>
>> I did, I ended up with larger spaghetti, I was hoping to look it as a follow up
>> after the series with the mTHP changes and support (that is to be designed and
>> prototyped).
> 
> Looking at it in more detail, the code duplication is not desired.
> 
> We have to find a way to factor the existing code out and reuse it from any new function.
> 

I came up with a helper, but that ends up with another boolean do_lru.


---
 include/linux/huge_mm.h |   5 +-
 mm/huge_memory.c        | 336 +++++++++++++++++++++++-----------------
 mm/migrate_device.c     |   3 +-
 3 files changed, 195 insertions(+), 149 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e2e91aa1a042..44c09755bada 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -371,7 +371,8 @@ enum split_type {
 
 bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins);
 int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
-		unsigned int new_order, bool unmapped);
+		unsigned int new_order);
+int split_unmapped_folio(struct folio *folio, unsigned int new_order);
 int min_order_for_split(struct folio *folio);
 int split_folio_to_list(struct folio *folio, struct list_head *list);
 bool folio_split_supported(struct folio *folio, unsigned int new_order,
@@ -382,7 +383,7 @@ int folio_split(struct folio *folio, unsigned int new_order, struct page *page,
 static inline int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		unsigned int new_order)
 {
-	return __split_huge_page_to_list_to_order(page, list, new_order, false);
+	return __split_huge_page_to_list_to_order(page, list, new_order);
 }
 static inline int split_huge_page_to_order(struct page *page, unsigned int new_order)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0184cd915f44..534befe1b7aa 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3739,6 +3739,152 @@ bool folio_split_supported(struct folio *folio, unsigned int new_order,
 	return true;
 }
 
+static int __folio_split_unmapped(struct folio *folio, unsigned int new_order,
+				  struct page *split_at, struct xa_state *xas,
+				  struct address_space *mapping, bool do_lru,
+				  struct list_head *list, enum split_type split_type,
+				  int extra_pins)
+{
+	struct folio *end_folio = folio_next(folio);
+	struct folio *new_folio, *next;
+	int old_order = folio_order(folio);
+	int nr_shmem_dropped = 0;
+	int ret = 0;
+	pgoff_t end = 0;
+	struct deferred_split *ds_queue;
+
+	/* Prevent deferred_split_scan() touching ->_refcount */
+	ds_queue = folio_split_queue_lock(folio);
+	if (folio_ref_freeze(folio, 1 + extra_pins)) {
+		struct swap_cluster_info *ci = NULL;
+		struct lruvec *lruvec;
+		int expected_refs;
+
+		if (old_order > 1) {
+			if (!list_empty(&folio->_deferred_list)) {
+				ds_queue->split_queue_len--;
+				/*
+				 * Reinitialize page_deferred_list after removing the
+				 * page from the split_queue, otherwise a subsequent
+				 * split will see list corruption when checking the
+				 * page_deferred_list.
+				 */
+				list_del_init(&folio->_deferred_list);
+			}
+			if (folio_test_partially_mapped(folio)) {
+				folio_clear_partially_mapped(folio);
+				mod_mthp_stat(old_order,
+					MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
+			}
+		}
+		split_queue_unlock(ds_queue);
+		if (mapping) {
+			int nr = folio_nr_pages(folio);
+
+			if (folio_test_pmd_mappable(folio) &&
+			    new_order < HPAGE_PMD_ORDER) {
+				if (folio_test_swapbacked(folio)) {
+					__lruvec_stat_mod_folio(folio,
+							NR_SHMEM_THPS, -nr);
+				} else {
+					__lruvec_stat_mod_folio(folio,
+							NR_FILE_THPS, -nr);
+					filemap_nr_thps_dec(mapping);
+				}
+			}
+		}
+
+		if (folio_test_swapcache(folio)) {
+			if (mapping) {
+				VM_WARN_ON_ONCE_FOLIO(mapping, folio);
+				return -EINVAL;
+			}
+
+			ci = swap_cluster_get_and_lock(folio);
+		}
+
+		/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
+		if (do_lru)
+			lruvec = folio_lruvec_lock(folio);
+
+		ret = __split_unmapped_folio(folio, new_order, split_at, xas,
+					     mapping, split_type);
+
+		/*
+		 * Unfreeze after-split folios and put them back to the right
+		 * list. @folio should be kept frozon until page cache
+		 * entries are updated with all the other after-split folios
+		 * to prevent others seeing stale page cache entries.
+		 * As a result, new_folio starts from the next folio of
+		 * @folio.
+		 */
+		for (new_folio = folio_next(folio); new_folio != end_folio;
+		     new_folio = next) {
+			unsigned long nr_pages = folio_nr_pages(new_folio);
+
+			next = folio_next(new_folio);
+
+			zone_device_private_split_cb(folio, new_folio);
+
+			expected_refs = folio_expected_ref_count(new_folio) + 1;
+			folio_ref_unfreeze(new_folio, expected_refs);
+
+			if (do_lru)
+				lru_add_split_folio(folio, new_folio, lruvec, list);
+
+			/*
+			 * Anonymous folio with swap cache.
+			 * NOTE: shmem in swap cache is not supported yet.
+			 */
+			if (ci) {
+				__swap_cache_replace_folio(ci, folio, new_folio);
+				continue;
+			}
+
+			/* Anonymous folio without swap cache */
+			if (!mapping)
+				continue;
+
+			/* Add the new folio to the page cache. */
+			if (new_folio->index < end) {
+				__xa_store(&mapping->i_pages, new_folio->index,
+					   new_folio, 0);
+				continue;
+			}
+
+			/* Drop folio beyond EOF: ->index >= end */
+			if (shmem_mapping(mapping))
+				nr_shmem_dropped += nr_pages;
+			else if (folio_test_clear_dirty(new_folio))
+				folio_account_cleaned(
+					new_folio, inode_to_wb(mapping->host));
+			__filemap_remove_folio(new_folio, NULL);
+			folio_put_refs(new_folio, nr_pages);
+		}
+
+		zone_device_private_split_cb(folio, NULL);
+		/*
+		 * Unfreeze @folio only after all page cache entries, which
+		 * used to point to it, have been updated with new folios.
+		 * Otherwise, a parallel folio_try_get() can grab @folio
+		 * and its caller can see stale page cache entries.
+		 */
+		expected_refs = folio_expected_ref_count(folio) + 1;
+		folio_ref_unfreeze(folio, expected_refs);
+
+		if (do_lru)
+			unlock_page_lruvec(lruvec);
+
+		if (ci)
+			swap_cluster_unlock(ci);
+	} else {
+		split_queue_unlock(ds_queue);
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
 /**
  * __folio_split() - split a folio at @split_at to a @new_order folio
  * @folio: folio to split
@@ -3747,7 +3893,6 @@ bool folio_split_supported(struct folio *folio, unsigned int new_order,
  * @lock_at: a page within @folio to be left locked to caller
  * @list: after-split folios will be put on it if non NULL
  * @split_type: perform uniform split or not (non-uniform split)
- * @unmapped: The pages are already unmapped, they are migration entries.
  *
  * It calls __split_unmapped_folio() to perform uniform and non-uniform split.
  * It is in charge of checking whether the split is supported or not and
@@ -3763,9 +3908,8 @@ bool folio_split_supported(struct folio *folio, unsigned int new_order,
  */
 static int __folio_split(struct folio *folio, unsigned int new_order,
 		struct page *split_at, struct page *lock_at,
-		struct list_head *list, enum split_type split_type, bool unmapped)
+		struct list_head *list, enum split_type split_type)
 {
-	struct deferred_split *ds_queue;
 	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
 	struct folio *end_folio = folio_next(folio);
 	bool is_anon = folio_test_anon(folio);
@@ -3809,14 +3953,12 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		 * is taken to serialise against parallel split or collapse
 		 * operations.
 		 */
-		if (!unmapped) {
-			anon_vma = folio_get_anon_vma(folio);
-			if (!anon_vma) {
-				ret = -EBUSY;
-				goto out;
-			}
-			anon_vma_lock_write(anon_vma);
+		anon_vma = folio_get_anon_vma(folio);
+		if (!anon_vma) {
+			ret = -EBUSY;
+			goto out;
 		}
+		anon_vma_lock_write(anon_vma);
 		mapping = NULL;
 	} else {
 		unsigned int min_order;
@@ -3882,8 +4024,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		goto out_unlock;
 	}
 
-	if (!unmapped)
-		unmap_folio(folio);
+	unmap_folio(folio);
 
 	/* block interrupt reentry in xa_lock and spinlock */
 	local_irq_disable();
@@ -3900,142 +4041,14 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		}
 	}
 
-	/* Prevent deferred_split_scan() touching ->_refcount */
-	ds_queue = folio_split_queue_lock(folio);
-	if (folio_ref_freeze(folio, 1 + extra_pins)) {
-		struct swap_cluster_info *ci = NULL;
-		struct lruvec *lruvec;
-		int expected_refs;
-
-		if (old_order > 1) {
-			if (!list_empty(&folio->_deferred_list)) {
-				ds_queue->split_queue_len--;
-				/*
-				 * Reinitialize page_deferred_list after removing the
-				 * page from the split_queue, otherwise a subsequent
-				 * split will see list corruption when checking the
-				 * page_deferred_list.
-				 */
-				list_del_init(&folio->_deferred_list);
-			}
-			if (folio_test_partially_mapped(folio)) {
-				folio_clear_partially_mapped(folio);
-				mod_mthp_stat(old_order,
-					MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
-			}
-		}
-		split_queue_unlock(ds_queue);
-		if (mapping) {
-			int nr = folio_nr_pages(folio);
-
-			if (folio_test_pmd_mappable(folio) &&
-			    new_order < HPAGE_PMD_ORDER) {
-				if (folio_test_swapbacked(folio)) {
-					__lruvec_stat_mod_folio(folio,
-							NR_SHMEM_THPS, -nr);
-				} else {
-					__lruvec_stat_mod_folio(folio,
-							NR_FILE_THPS, -nr);
-					filemap_nr_thps_dec(mapping);
-				}
-			}
-		}
-
-		if (folio_test_swapcache(folio)) {
-			if (mapping) {
-				VM_WARN_ON_ONCE_FOLIO(mapping, folio);
-				ret = -EINVAL;
-				goto fail;
-			}
-
-			ci = swap_cluster_get_and_lock(folio);
-		}
-
-		/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
-		lruvec = folio_lruvec_lock(folio);
-
-		ret = __split_unmapped_folio(folio, new_order, split_at, &xas,
-					     mapping, split_type);
-
-		/*
-		 * Unfreeze after-split folios and put them back to the right
-		 * list. @folio should be kept frozon until page cache
-		 * entries are updated with all the other after-split folios
-		 * to prevent others seeing stale page cache entries.
-		 * As a result, new_folio starts from the next folio of
-		 * @folio.
-		 */
-		for (new_folio = folio_next(folio); new_folio != end_folio;
-		     new_folio = next) {
-			unsigned long nr_pages = folio_nr_pages(new_folio);
-
-			next = folio_next(new_folio);
-
-			zone_device_private_split_cb(folio, new_folio);
-
-			expected_refs = folio_expected_ref_count(new_folio) + 1;
-			folio_ref_unfreeze(new_folio, expected_refs);
-
-			if (!unmapped)
-				lru_add_split_folio(folio, new_folio, lruvec, list);
-
-			/*
-			 * Anonymous folio with swap cache.
-			 * NOTE: shmem in swap cache is not supported yet.
-			 */
-			if (ci) {
-				__swap_cache_replace_folio(ci, folio, new_folio);
-				continue;
-			}
-
-			/* Anonymous folio without swap cache */
-			if (!mapping)
-				continue;
-
-			/* Add the new folio to the page cache. */
-			if (new_folio->index < end) {
-				__xa_store(&mapping->i_pages, new_folio->index,
-					   new_folio, 0);
-				continue;
-			}
-
-			/* Drop folio beyond EOF: ->index >= end */
-			if (shmem_mapping(mapping))
-				nr_shmem_dropped += nr_pages;
-			else if (folio_test_clear_dirty(new_folio))
-				folio_account_cleaned(
-					new_folio, inode_to_wb(mapping->host));
-			__filemap_remove_folio(new_folio, NULL);
-			folio_put_refs(new_folio, nr_pages);
-		}
-
-		zone_device_private_split_cb(folio, NULL);
-		/*
-		 * Unfreeze @folio only after all page cache entries, which
-		 * used to point to it, have been updated with new folios.
-		 * Otherwise, a parallel folio_try_get() can grab @folio
-		 * and its caller can see stale page cache entries.
-		 */
-		expected_refs = folio_expected_ref_count(folio) + 1;
-		folio_ref_unfreeze(folio, expected_refs);
-
-		unlock_page_lruvec(lruvec);
-
-		if (ci)
-			swap_cluster_unlock(ci);
-	} else {
-		split_queue_unlock(ds_queue);
-		ret = -EAGAIN;
-	}
+	ret = __folio_split_unmapped(folio, new_order, split_at, &xas, mapping,
+				     true, list, split_type, extra_pins);
 fail:
 	if (mapping)
 		xas_unlock(&xas);
 
 	local_irq_enable();
 
-	if (unmapped)
-		return ret;
-
 	if (nr_shmem_dropped)
 		shmem_uncharge(mapping->host, nr_shmem_dropped);
 
@@ -4079,6 +4092,39 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	return ret;
 }
 
+/*
+ * This function is a helper for splitting folios that have already been unmapped.
+ * The use case is that the device or the CPU can refuse to migrate THP pages in
+ * the middle of migration, due to allocation issues on either side
+ *
+ * The high level code is copied from __folio_split, since the pages are anonymous
+ * and are already isolated from the LRU, the code has been simplified to not
+ * burden __folio_split with unmapped sprinkled into the code.
+ *
+ * None of the split folios are unlocked
+ */
+int split_unmapped_folio(struct folio *folio, unsigned int new_order)
+{
+	int extra_pins, ret = 0;
+
+	VM_WARN_ON_FOLIO(folio_mapped(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);
+
+	if (!can_split_folio(folio, 1, &extra_pins)) {
+		ret = -EAGAIN;
+		return ret;
+	}
+
+
+	local_irq_disable();
+	ret = __folio_split_unmapped(folio, new_order, &folio->page, NULL,
+				     NULL, false, NULL, SPLIT_TYPE_UNIFORM,
+				     extra_pins);
+	local_irq_enable();
+	return ret;
+}
+
 /*
  * This function splits a large folio into smaller folios of order @new_order.
  * @page can point to any page of the large folio to split. The split operation
@@ -4127,12 +4173,12 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
  * with the folio. Splitting to order 0 is compatible with all folios.
  */
 int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
-				     unsigned int new_order, bool unmapped)
+				     unsigned int new_order)
 {
 	struct folio *folio = page_folio(page);
 
 	return __folio_split(folio, new_order, &folio->page, page, list,
-			     SPLIT_TYPE_UNIFORM, unmapped);
+			     SPLIT_TYPE_UNIFORM);
 }
 
 /**
@@ -4163,7 +4209,7 @@ int folio_split(struct folio *folio, unsigned int new_order,
 		struct page *split_at, struct list_head *list)
 {
 	return __folio_split(folio, new_order, split_at, &folio->page, list,
-			     SPLIT_TYPE_NON_UNIFORM, false);
+			     SPLIT_TYPE_NON_UNIFORM);
 }
 
 int min_order_for_split(struct folio *folio)
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index c50abbd32f21..23b7bd56177c 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -918,8 +918,7 @@ static int migrate_vma_split_unmapped_folio(struct migrate_vma *migrate,
 
 	folio_get(folio);
 	split_huge_pmd_address(migrate->vma, addr, true);
-	ret = __split_huge_page_to_list_to_order(folio_page(folio, 0), NULL,
-							0, true);
+	ret = split_unmapped_folio(folio, 0);
 	if (ret)
 		return ret;
 	migrate->src[idx] &= ~MIGRATE_PFN_COMPOUND;
-- 
2.51.1


