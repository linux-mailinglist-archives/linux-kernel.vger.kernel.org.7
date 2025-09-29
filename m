Return-Path: <linux-kernel+bounces-836652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69625BAA3B6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1845E16317D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C3421D5AF;
	Mon, 29 Sep 2025 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CPZYPIpp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LNr+CW5A"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF24219303
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759168229; cv=fail; b=lv/afaT6BvcB7DyNgJE/X1xgd88OaMmZA4pGkOfRtN5QnrR8wOxC8RtaF/qFYeyK60Jpe9hAZIZn0+mhshpKIxSNTw7L+PKwQjMjxKmV+Y6zhC/KeTMIr2Hto6ACCHwZ3RjTlcaRK0ymSJIoie7b9imgw++iZ9C5GVfDRXZa9Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759168229; c=relaxed/simple;
	bh=IpvikX9VL2hShBa9vDmpEITB45Ne0sgpiFH+INWvmuQ=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CykwhhEonCC7NChCzIvLi6cDWj2YJoqtngUsGSekrSHTKkIhu81CQKproJHrfdXmGX7EH5f1MuKmBd0+aLJGQ2kwhKgiwb+TYw1n6EMuoPTk1H9tKtDzD/QnlvTh9kaLA+yc3f7lAosZoPzEuZcVS5QFDCcpUgIRv65rv0bxvBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CPZYPIpp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LNr+CW5A; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58THNR6U008042;
	Mon, 29 Sep 2025 17:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7aew2JqZydDzgZwxJ1VIr1r7wbJVRrQsHg8zLELaxkg=; b=
	CPZYPIppJG1EIh1ShMIjaBXDiYxCGIS+LWGZba4IGDsG3xIAkc95yldHe81/3a+A
	WV/1eJA05RNqmSdeZ9j8tMIwuZ6015IxJPJ96If2rO7He/SsELEh8IbCSMyw9kEK
	uL1oSZTC4pQZoY3HpFolQNMUIqUPAZhvat94LW7j9rFAR0TWZffrOMLa7pd+NQjc
	aZoupVIe0JwOP8y2DojHUTf2mY9+PUcHekLyySm2PY2viVfJCkHsEwr6AZnDL12U
	pwFTDU8MkiNn9Q9dh/wCg3nGjIigeKassqmIculTn+AnEyM30lA++ZaGjoHq6QqK
	Nrfol8BgglqfPa5W0OTMQw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49fwyj03x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 17:49:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58TG52tw037411;
	Mon, 29 Sep 2025 17:49:51 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c714rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 17:49:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyC3dGaw/BMZIzcb1h1PlPZtbF5XO+vYuAlVwXeve81L3j1QnKTyE8KVkqb9Hj9YT+PaflzkZHW3rdYBiMVZGsGH4a642Yo6l5FTh7tEwfWA6g6AsdOu6moE0WLzt1tk68urdcaCRsvckmt/MtWbJ4L991lY0iCUqqB30SgpSpZbxQ1ZhLVyBk5tQoUoL/OCoE+a8d/SoFcIN72AHHspids5bGLzLoqNUClcOhakjTKBMwqwggpp9G0PtBbjOQ+sV7Po1mIFjL9E3UFTcLJJ7acwtW8NFsvyWv+jKk12yiQ0qTAm1A/yr4pZ8jRzHH2pEgVShU3+Z7fDEtVcJuEfTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aew2JqZydDzgZwxJ1VIr1r7wbJVRrQsHg8zLELaxkg=;
 b=TVOsYp9dA0jPqOq93l85wRFg/unZXSeryhpSCGP2UDWY0W2MLzvpwBS8eptL1qJp+I1QnXyagkMLF+VtJe2CkPD+H+Ig6Hn2/COA6dsupNZXv8LcPAdhWh5m/T2bT6u2yyRh2GlaKS3VRMh9zUMcd6+E1yevhwsj1UB7OwR7g6m/Wu5n8V7lRZ/cGo7DszkFmObeyiSraBkk+Lb9FlHdfNHmeUYwH9ap59f906PgYxyjd531TfUKdOwq6kESLJRPYXv+XTwxgEhurllFKDm1TyXN0dusQ8T/61/G65t8zHER3DYhlIh+LrqyU4mi5OjJbZoM1OfFCbZDqAb85FTwsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aew2JqZydDzgZwxJ1VIr1r7wbJVRrQsHg8zLELaxkg=;
 b=LNr+CW5AWWwFHKOMi4sA2xls2IOp+6M99Tq15YSTSQLf3P6A39yCDC7o2MNk5x24vWv2nwvSor2K3dJ3AN1I3XVaf6TnjYIKCj7YVL0sv0T9btmYFnrozZkrVKgmpenOX78HP9e4w5WprYMiXgYpRjvcY7owImeeM61/aWr3OH4=
Received: from IA0PR10MB7369.namprd10.prod.outlook.com (2603:10b6:208:40e::14)
 by SJ5PPF0687F9010.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::786) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 29 Sep
 2025 17:49:46 +0000
Received: from IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::c047:e76c:2405:bac2]) by IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::c047:e76c:2405:bac2%4]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 17:49:46 +0000
Message-ID: <7577871f-06be-492d-b6d7-8404d7a045e0@oracle.com>
Date: Mon, 29 Sep 2025 10:49:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
From: jane.chu@oracle.com
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
        Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,
        Luis Chamberlain
 <mcgrof@kernel.org>,
        syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linmiaohe@huawei.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        nao.horiguchi@gmail.com, syzkaller-bugs@googlegroups.com
References: <68d2c943.a70a0220.1b52b.02b3.GAE@google.com>
 <ce93b55c-75a7-4b4d-a68b-9d80baf1578b@redhat.com>
 <DB0E39CD-36A9-4929-BCC6-33F27E387AEA@nvidia.com>
 <70522abd-c03a-43a9-a882-76f59f33404d@redhat.com>
 <B0781266-D168-4DCB-BFCE-3EA01F43F184@nvidia.com>
 <cad74ef8-3543-4fc5-a175-8fc23a88776a@redhat.com>
 <E82638DD-9E5D-4C69-AA0F-7DDC0E3D109B@nvidia.com>
 <fzfcprayhtwbyuauld5geudyzzrslcb3luaneejq4hyq2aqm3l@iwpn2n33gi3m>
 <80D4F8CE-FCFF-44F9-8846-6098FAC76082@nvidia.com>
 <w2kwxcd6br6h4tdn6xigtuf73qklt6jhxvhtcwp7idugycgxlv@vqjx26vrnwu5>
 <594350a0-f35d-472b-9261-96ce2715d402@oracle.com>
Content-Language: en-US
In-Reply-To: <594350a0-f35d-472b-9261-96ce2715d402@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::23) To IA0PR10MB7369.namprd10.prod.outlook.com
 (2603:10b6:208:40e::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7369:EE_|SJ5PPF0687F9010:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b31517a-f5cb-499b-70be-08ddff80941d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODBkSU95eDc2V0oyaE9Xa0ZTcU5ubHVDVGEzbG0xM1kwWXYzMkFpNjJhcUZk?=
 =?utf-8?B?aENBRXdWbTN1WGxkSlBzSi9PT3pKU2ptcHozcG9HWDAzeFdRaGErRGttSnk3?=
 =?utf-8?B?YVZxT0Y4SFc0aFpLR3dUS3pPTVF2WUNvK0FoMkVlMkFYR0ltbWZsUzlva00v?=
 =?utf-8?B?dkpiTmV2OFFsVVVpN3RybG1Wam1lY2VocVM5azNsUW9IZXJ1V0MycEpZNnFr?=
 =?utf-8?B?aTVSWmN1NEtVVVhrV21wQUZ2UmUzYk0vMTV1NkM0S1d6MlhwNzZCTTVYMWpj?=
 =?utf-8?B?T25vVnhqQi9DMmMwVWs0TjlyVkVkam9FWDgwTEEyMmhzeVFyVlMvdUh5eEVz?=
 =?utf-8?B?M0t2RGRqWldYWms2MjNwVGtrRVJwYkJBV0lmLzFJRStQWDdOK2ZZQ21JTU9j?=
 =?utf-8?B?L3VhVUc0RHk2R3pWaVE4MVJJMTFhZTFNcnU3NmxycW5vN0lBRjVyN2tQQWFJ?=
 =?utf-8?B?bFNRamJjK3E5akhWM1pTODJYd29UOXBwT3pZUDBOak1kSURRU1hrUVJTUHMy?=
 =?utf-8?B?eExiQThCcEU3QVZwSUNxbGZNU1JQakhvTGpYbm1TT0ZqL281aUs0d1NyRm9X?=
 =?utf-8?B?TWd0NlNGSldmSWJ4Y09TV2gza0NIQjdxTzJQOXh3cW16dFJ3YXJiUGtFbUtJ?=
 =?utf-8?B?Ym5DVzBPNlZzQ0svNWIzRTY0VDBFNi9sN05mbk5GNDJiVG8rSTQxRUhhN1Zn?=
 =?utf-8?B?cVlLY1V3cURjbVB3azRHcE8wZFlRSkFNVnJ5c0NHaFpERzJPVk85SzNrMnUz?=
 =?utf-8?B?MGh1ZUlXMzNmMU8rc2JpZlA3eEZXVWcwUWwrcThuQ09MTXZEOHZob2paT0pQ?=
 =?utf-8?B?V29DZis3ZHVQd29MNkdhY3hXcjZqMnlRMndTVk1RNzBob0wyUXJ6d1diRDVF?=
 =?utf-8?B?Um5naFVKV3U5bnpCdTRRb1pTc2FjOGNQaitWOVB6aCtZaGlMM3pQUWV4cks3?=
 =?utf-8?B?eU80eGZ2ZmE0citkWmVTRDIyVTJweFhEejJRRnBJdUQ2NmRRSis3b0pFN0Jl?=
 =?utf-8?B?aEVmK0pFUVVFbmJBRWFQWGo1ZmRYM1BlRk9OM1FXMWh3bWdFOC9IeU1tb3p0?=
 =?utf-8?B?N1lwNE1tQ2xlVXBXM24rREpqMm9WQWlPMU1qVXBuSTduclEyRVRjRGh5K0Rp?=
 =?utf-8?B?Sm9zNXV6M3FuZkh6c2cwTzhma2tWbjZ6dm1XRVhkMFc1S0NzcGljVEsvRkdB?=
 =?utf-8?B?RDQyTlFURUNVMFhReGJhUzJsSGk4bHRNZUMwRFJZU1NoaFF5VXVYR3lDOTB1?=
 =?utf-8?B?UVdIOVJuTUhJWHo4dzFlSjRRM0NrN3luU1NQU1VJS1dYL2JPN2srZDlnQVMz?=
 =?utf-8?B?cXhWdlBMb3djdmNOVjIrTkFISlFQT3I1NmE2a2YwczdiYW5ITlRieXoybjZp?=
 =?utf-8?B?NWNBT1dLS3g3bzJ6OU1xNytqdlIrTkxIYUN3V0lHcUEzaW9yZWtybTFtb3Bk?=
 =?utf-8?B?dFZzVGxDNkttWlRTZHorQXF2aVpwM2RwT1BmWVVKYnkySlRZaVEzUzltc3Jy?=
 =?utf-8?B?RURmYzVDdTZ5SmUyZ2QxWlRUcHFPSWhhMW5oQ3RTem5scjFtTzA4Tk4ra0pD?=
 =?utf-8?B?WVlvOHJ6dG5GS3NONTJ2YXA0WHRFTk1wV2NrL3ZKRmdFNitPSzQrZCtuMUpL?=
 =?utf-8?B?Y2VVRmpjcEhCZ3hYZFpkV3djbEZ0SXcxR0NyVWJaOHl6dXJsaFlMTFJ5TEEr?=
 =?utf-8?B?MjhGVW9JckgwVG92Tk5wWkZ3dEY0d1Y0NWJWSmpmRWxCRjU4RnZnRHdyeVo4?=
 =?utf-8?B?WmxQbjBENmdtUloreDNqNGptUHZ2Q1lEdmV3cjFNVXIvQldGenR3UHhnUjlI?=
 =?utf-8?B?cEt1VVdlNGZkYlZqamRpOHYrK29IU2loOW9iSGlXbUpVRWhwMHJ2WTlrZURO?=
 =?utf-8?B?TmlyS2xCV3Z5alFDZGtwVXY2MFkxMU9JQVV5TjFLcHBzQzlxL1J5SEd1V0dS?=
 =?utf-8?Q?BOzHfKZElR99+jNsjS8RK+jghjXWWTr5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7369.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjF6T25SN01PZS91QWo5OHRJNVJuaFZNSzVEZi9kbktSQkFadldBVnkydEdH?=
 =?utf-8?B?U1g4UDNxa2FwSHJMV3JTd0haNHdYRGlMaHc3VFFHcDRJWklOYzdYSzBuVFFI?=
 =?utf-8?B?bXFyNTlubENCTmxzUmhkemltcW5uV1VPazBZcUNCQnFDbHJiRGtPaFN4cmdZ?=
 =?utf-8?B?ak9EeE43OUNmbWJYUTNMeFE0SUZUZjZPL2w4MitBT25YOWdRQXIwaEFra0Ix?=
 =?utf-8?B?SjRSZXpEMit0OTdnSURaa1BCeGxnS0dhWXpRd1BnNHVIcVRwamJHRDNaVS9v?=
 =?utf-8?B?THN6MkZYWXN6Y1h0dzhkcFA0UHFkYk5GaVR6Vm80SjV4aEVWaVlKYXpKcXM1?=
 =?utf-8?B?TWJzMEpuK1BJcmNCK2VYNlNlbzRYTFJwL1VBSm92dU1aQ0JwWUFucnNWRUtQ?=
 =?utf-8?B?SzEzWURsTzhXUXJjaVgyUnNBZXQ2U1dHWE81S09iL0x3MmJzaXd3RW1vSitL?=
 =?utf-8?B?c2Y2RDNvUlNLRkx1YytjNm4vYlV4dEVBdUkwOVJsN3Q4aktiQkl3c0hYNVJU?=
 =?utf-8?B?ZXppNFNrS3UreSswWUJGM3Z0eFhROGRUUVUyZ05IdTh6dmg5WXduSFFOQzBs?=
 =?utf-8?B?eEhLdm9aNlRLYXpHRlp2RnloY1NjangyQXFOb1VvQnV5ZnNJRFJZT29CZ1JW?=
 =?utf-8?B?eHEzNTlvM1JWbXJ6QkJpRmorcDR6blNSYjZERnRubzN2ZnZBaFZJK0NDNTBy?=
 =?utf-8?B?RVJDSUNCRUNDNHhjQ2tHL3lYVGNYVHFWWlFuUWh6SzNEemZVOTQ2ZzVLcDFD?=
 =?utf-8?B?SWNvdldQNnoxM1FmbGlWT3hCTHlyOG9zU2V4MldTZGZrZU9PRkVtcGVUZ3pD?=
 =?utf-8?B?cWpYRWVrcXRTamFGbnpMM1VOUEtrZERZWXBvYmtXek4xclhVbUhsYThQN0JG?=
 =?utf-8?B?U1ZSMHhZNlhqK3dNanloTTRoNS9JQ1JVY21KMVlkdktKTkhCTHJjdjhndTJF?=
 =?utf-8?B?QW5YN1RJeGVuSXlHNHRQSHdEQndyOFkwN1VMTCtjRHhxRkp6bXdNU3prZFlk?=
 =?utf-8?B?QzJ1aVR4UTY3VUdhQnZIeFdKN2Y3dDZGb2lOMmRLaUx2S1VPS3ZtMklFN3VG?=
 =?utf-8?B?U2NHVXlYcXR3OXcrVGpLUFJuV3ZFcDZtL3hJQkpjeXFaZ3NwVXdTYzM1U1hk?=
 =?utf-8?B?dHVqa2tFdzNYK1ZnOFBIcHlHZmp1YURyeXpnTUI5THdwaVA1d3RJelkvTFdr?=
 =?utf-8?B?Rm5Fc1RsVkZla0kyWm5CVDhCVi9JT2UzK2x2OGtIaUMxT1M1ZjFDOStCNXRl?=
 =?utf-8?B?d0hNa2lnZVV0YnNNRFNMOXBMOENBZGgwT2o3Mi94aDdXd3dleGRBMVdERlI0?=
 =?utf-8?B?UmVzMUFGR0lFRkFqRXBiWlNGbmpZMEdYS0N2WmJQZ2s1V2ZrU3FXMG9QREQ4?=
 =?utf-8?B?U3RuSE0zS3pwRHF2TWxUTXZ1RkQ0V1ZxYWQ3bEpMYk0yY3RxK2ZabFN1OTZF?=
 =?utf-8?B?cE10RnA4d3VNa2R0cFdWV0FBY1p5YWIyOXBJQ0JnenVrWE1aR1dEQndHamZL?=
 =?utf-8?B?ZGV2TXFEQjFseThNRVRYL2gvZFdsV3dNb09oR0lvWE5WcUdyY0hSTXV1dHRr?=
 =?utf-8?B?S05KV1M4MG9RL2NmTjR1bXBtdWJXTzQ1dlVNUGI2WWZ3UDJoSjdMaDhMbVN5?=
 =?utf-8?B?bm5IakYxN0Y3bFVpK3phRWFLMHdGaFVNdGpncEp4V3NnekZMYXovTG9TekNm?=
 =?utf-8?B?KytZclF1SHdGRmxiVFh0VVA5SVc4NHVqamtNc0VSZGtjUjczUFEzSW4vU0k3?=
 =?utf-8?B?NDMySXpPU3AzbjdtSUFnTmdUU3ljY3YwNnU3K3pXdkNNTGttamVING9TMFVQ?=
 =?utf-8?B?SWtMRWFmaVVpSUhvRUNib3BLbXJyaDRGZnRKVHBjQW0rd0tFSE9HcE9CSVcw?=
 =?utf-8?B?UjZDcHZNOXI1d2VaNHNIQ2tRTUNMUU9sZXRaa3REaC8weVp6NXhyZkQxQ0FQ?=
 =?utf-8?B?UUpPTXFCWGNaOUtFUWFGN1AvWHRwYWNMazVZZ0FhTk1OZExEdFpsREtaSmtk?=
 =?utf-8?B?UC9FazRRMTIvTEQwdWJGWW8yWFhMVGlyOGlrMFNWYWE0V3JkRWZJVEswdTNl?=
 =?utf-8?B?cWI0UjZQSWl4QlpXemlPeWxEdHlhWERtSHJLNmZxbld4Tnl3d1JSc2JnY05a?=
 =?utf-8?Q?Sf9iVopf2NUHzZmhZW/aWjHIU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V0GIoX/mJDgGZjz9NdOJ55wx4a0g3GnbNjuPoctVA6Smjl7tHlzf5PWxW5IRHkaF7WXj+N2oX+CC1zcjZwClpXbNCjQ/w2qI9rpXIdezIzCiqGy2wtNrQc7abgoeAJgcx2FU5VLAH96ypb0+Kg8s/PUjAVQGwj7f4Zlb9w4c9vay1wfnvzft6xd0dthZ5iAuSfLPhbQwm9upyB/CwCw1bKBGAgIhaY20Oys/Q3O13ark4UuEpLFvQc92PaypyC7FofgXYMyz6t7RYXyB/PrLZzIdivrWHGh6/gCWC0WT4iKDP0krZvdLk6vb+yQItZLLedQ7LgnKF4KgMWKQD5eiX8/Y3RVCvGWseKQkg7SB0SoRtVAZ1jS99/n5fA9fk52lWi1wcEMZOMVcA9hUn+RJWCrYfS44Q9b/MMLE/O9WC+nnDi5Mxm8RqTnvms7Z0s3BkayaNmehsldKIw1Oxa4zOuGHMY89OgqiXgxxlAOL1fx9eOhP9kyzspti857s0f9VdnUsEPeg3TpJdz4K5GOdOAgTuc++z9R5HFZ8bidSLL94+xRAXeeKoPIEwpj5upMV069XPx87bBrZhqa3JUpkUC3HC/hxbkuftt5t8rcvvVw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b31517a-f5cb-499b-70be-08ddff80941d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7369.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 17:49:46.4849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzefxHO8VpLPxzXlSJCus9lcU4totzVHTaO/ehAyJDyCLxJI4ZSOM9l/zTHC96/72ZXlINQkYLFp9LhyaQRPug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0687F9010
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509290165
X-Proofpoint-GUID: DclD3YqWHhIBzRGcTQZ0zEHmCy5o8bfn
X-Proofpoint-ORIG-GUID: DclD3YqWHhIBzRGcTQZ0zEHmCy5o8bfn
X-Authority-Analysis: v=2.4 cv=LewxKzfi c=1 sm=1 tr=0 ts=68dac6c0 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=kx13CmaCRuZaGsz85vQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDE1NSBTYWx0ZWRfX34Tz9VSkH2dG
 neB57UahBtmWjZW7kI07LK4MxH/2kwLcJPGmuS5zcaYr1MoHmomIovMc8rgaSxYbtwANBWzU2D3
 nEobXMFepaqKS9sqVj9gHvqgcMUS4qNqDXHuerENlZEVFNLZxd//hFa5vf3dqnE+053Gi9FOxUy
 IVsSYxl6k7Ew93jFb4nmHs3L0Mggc+rWl9jv9q0TjhiLFNjaYVhVig778yDa36P9zIf/bulPTST
 jXoF+ut2jnnCnS5wKZOd/TI1jgbOejIm5A4H/08DXRmY4GBH+qEtXoNypFEgf0PZ+wqad/HJGle
 Vn+BIP4ymSCfHFEWZ13KYS+FhSJ7lTubGSBDBaE651hH3N2ERW3Wbv5AavQo6w+9fum8ayggZJd
 ta20WXiKDCtfffewF+swHbjrijJgPg==


On 9/29/2025 10:29 AM, jane.chu@oracle.com wrote:
> 
> On 9/29/2025 4:08 AM, Pankaj Raghav (Samsung) wrote:
>>>
>>> I want to change all the split functions in huge_mm.h and provide
>>> mapping_min_folio_order() to try_folio_split() in 
>>> truncate_inode_partial_folio().
>>>
>>> Something like below:
>>>
>>> 1. no split function will change the given order;
>>> 2. __folio_split() will no longer give VM_WARN_ONCE when provided 
>>> new_order
>>> is smaller than mapping_min_folio_order().
>>>
>>> In this way, for an LBS folio that cannot be split to order 0, split
>>> functions will return -EINVAL to tell caller that the folio cannot
>>> be split. The caller is supposed to handle the split failure.
>>
>> IIUC, we will remove warn on once but just return -EINVAL in 
>> __folio_split()
>> function if new_order < min_order like this:
>> ...
>>         min_order = mapping_min_folio_order(folio->mapping);
>>         if (new_order < min_order) {
>> -            VM_WARN_ONCE(1, "Cannot split mapped folio below min- 
>> order: %u",
>> -                     min_order);
>>             ret = -EINVAL;
>>             goto out;
>>         }
>> ...
> 
> Then the user process will get a SIGBUS indicting the entire huge page 
> at higher order -
>                  folio_set_has_hwpoisoned(folio);
>                  if (try_to_split_thp_page(p, false) < 0) {
>                          res = -EHWPOISON;
>                          kill_procs_now(p, pfn, flags, folio);
>                          put_page(p);
>                          action_result(pfn, MF_MSG_UNSPLIT_THP, MF_FAILED);
>                          goto unlock_mutex;
>                  }
>                  VM_BUG_ON_PAGE(!page_count(p), p);
>                  folio = page_folio(p);
> 
> the huge page is not usable any way, kind of similar to the hugetlb page 
> situation: since the page cannot be splitted, the entire page is marked 
> unusable.
> 
> How about keep the current huge page split code as is, but change the M- 
> F code to recognize that in a successful splitting case, the poisoned 
> page might just be in a lower folio order, and thus, deliver the SIGBUS ?
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index a24806bb8e82..342c81edcdd9 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2291,7 +2291,9 @@ int memory_failure(unsigned long pfn, int flags)
>                   * page is a valid handlable page.
>                   */
>                  folio_set_has_hwpoisoned(folio);
> -               if (try_to_split_thp_page(p, false) < 0) {
> +               ret = try_to_split_thp_page(p, false);
> +               folio = page_folio(p);
> +               if (ret < 0 || folio_test_large(folio)) {
>                          res = -EHWPOISON;
>                          kill_procs_now(p, pfn, flags, folio);
>                          put_page(p);
> @@ -2299,7 +2301,6 @@ int memory_failure(unsigned long pfn, int flags)
>                          goto unlock_mutex;
>                  }
>                  VM_BUG_ON_PAGE(!page_count(p), p);
> -               folio = page_folio(p);
>          }
> 
> thanks,
> -jane

Maybe this is better, in case there are other reason for 
split_huge_page() to return -EINVAL.

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a24806bb8e82..2bfa05acae65 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1659,9 +1659,10 @@ static int identify_page_state(unsigned long pfn, 
struct page *p,
  static int try_to_split_thp_page(struct page *page, bool release)
  {
         int ret;
+       int new_order = min_order_for_split(page_folio(page));

         lock_page(page);
-       ret = split_huge_page(page);
+       ret = split_huge_page_to_list_to_order(page, NULL, new_order);
         unlock_page(page);

         if (ret && release)
@@ -2277,6 +2278,7 @@ int memory_failure(unsigned long pfn, int flags)
         folio_unlock(folio);

         if (folio_test_large(folio)) {
+               int ret;
                 /*
                  * The flag must be set after the refcount is bumped
                  * otherwise it may race with THP split.
@@ -2291,7 +2293,9 @@ int memory_failure(unsigned long pfn, int flags)
                  * page is a valid handlable page.
                  */
                 folio_set_has_hwpoisoned(folio);
-               if (try_to_split_thp_page(p, false) < 0) {
+               ret = try_to_split_thp_page(p, false);
+               folio = page_folio(p);
+               if (ret < 0 || folio_test_large(folio)) {
                         res = -EHWPOISON;
                         kill_procs_now(p, pfn, flags, folio);
                         put_page(p);
@@ -2299,7 +2303,6 @@ int memory_failure(unsigned long pfn, int flags)
                         goto unlock_mutex;
                 }
                 VM_BUG_ON_PAGE(!page_count(p), p);
-               folio = page_folio(p);
         }

         /*
@@ -2618,7 +2621,8 @@ static int soft_offline_in_use_page(struct page *page)
         };

         if (!huge && folio_test_large(folio)) {
-               if (try_to_split_thp_page(page, true)) {
+               if ((try_to_split_thp_page(page, true)) ||
+                       folio_test_large(page_folio(page))) {
                         pr_info("%#lx: thp split failed\n", pfn);
                         return -EBUSY;
                 }


thanks,
-jane


