Return-Path: <linux-kernel+bounces-753036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E86FB17DF8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B9C3B5286
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFC31F7569;
	Fri,  1 Aug 2025 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WYo5ynqa"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051051F099C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754035324; cv=fail; b=dJHcbcTpV3gMtzxYxl4HfBiwMCwEMy9zH23tuOsuMFxN92lph5aiIPEh00M2EK1kMO3n4WXz3Fv4nc14LCtbrCL5aXGWfIhiies+jlPa25/w2k+Ie7cpzg4ZuWpkN2ea9pF2YGGAaove1DosYuVe9tj1tFqU2YQmFiI6AnNpSqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754035324; c=relaxed/simple;
	bh=fg7rU5+o/Rh81RPPCld+C6aiMJQKiTTTVTX77BkubP4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZKAh4zgSyYQdCATWCqN/SgUkxYSnS79gtE5LbjlpS7Q3V8i4f2OmljagFywAhQWJrk0sBRLWDra+jXTuFgmfcMD4rzSgGOg+mHBBKk8+PwwNEA/skNmP31m+pcmlngzg07sh/J9qy79VD0gL7sNkOBHKVwwyS15ZlcAH4s1gRs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WYo5ynqa; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkHbbDHuuRivzlniEW+D9alpNNnnC1arLIZy8VRTAR6b/Tu72+e8z7XsSJJQ5+PM2IoQgPn1YHDz16h5OkwmMQig5l6p+WEM5mcU1DvTV65lPQ6CK6rXZXAmoCiOiArJokMojozqMrX/beeVAfzMaGy+4QtYXXmEUxJ2wTvTN7iBfn80Q949Mf7Q5UoPP+/p0FHGUzzlFcG4xtxT6phbHkLwEMDKRMDhmte1F7d7FfkYrcfj70RUBIeJQZRRAw8tWliDNv1cIkgUycO5UZpbKcxXTHXAWTUIELPDOb4/+92i1uf33duoPuLlRCtjZdPQkvRYDnjTd2HaoYvxpzE/xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=semAa7Vh6LIuhlXG0j8rDMJ6gIvuGfrAM7OrelzKxqE=;
 b=TD3l/flXfHh2KdJmmLh5gp4KwAOwXGoC6s0pMAPx+DIg7zDLuFbWOnwD81d2G/us4Ut9zD3iDfBC//kKmcTmLSiL5Rj0tF/6oX+PegUHWeRKvnf8+OfEtV2WGFCcLA2DEdwg1zocQ5+yp6YIXY/w4mvQgElOImkX/cais6OaysG/OtZOzlrJES3oUdz5QXH2/ze4SfY7Ns/10nVa7ncJK4zUX8Mc3N95vFIwXASM1758Bf7epILSBWJzLyD+dWd7qp0WqojEeyj+VEromHffc032Xp/RxthXDNLG4nrJfjGDYaWUsq9D5Ease+YhqorXQRUgAq/BJZrIGFRa7KhK6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=semAa7Vh6LIuhlXG0j8rDMJ6gIvuGfrAM7OrelzKxqE=;
 b=WYo5ynqa9OaMhqED2dadeHlhlD8vc8YMvMyYQozLR6KxYj54rWjPko1/aT8p+HjBaOrgWTnXoKhgm8AXo2YM87I7tGDFb7rxAq4hL5883SoUqMDd6DWHFGPw0gOv5zPUbv0htN2xQLlivvDEL+NxNZCP87Dx1MgIcnPRcQQM5qCPrzxpogGqGDl4ngM6CM2jzQzR5mvVJM1Yg4XAlj7dmyzOegzYdSDNOzDVAAZwWfTMSlhODcFJIuKTWx35yWkpAAZK7SLxiSdWVG/1YuusV2BJsrlGR25JL6vUDpyP8cQrs1hZ1yaD9nQq9+1JeykIQXxJjCXv5vRMuUILT6XQuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by SA1PR12MB7198.namprd12.prod.outlook.com (2603:10b6:806:2bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 1 Aug
 2025 08:01:58 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%5]) with mapi id 15.20.8989.011; Fri, 1 Aug 2025
 08:01:58 +0000
Message-ID: <e8f867cf-67f1-413a-a775-835a32861164@nvidia.com>
Date: Fri, 1 Aug 2025 18:01:51 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 02/11] mm/thp: zone_device awareness in THP handling code
To: David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Mika_Penttil=C3=A4?=
 <mpenttil@redhat.com>, Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
 Donet Tom <donettom@linux.ibm.com>, Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>,
 Ralph Campbell <rcampbell@nvidia.com>
References: <20250730092139.3890844-1-balbirs@nvidia.com>
 <20250730092139.3890844-3-balbirs@nvidia.com>
 <c2f2fe52-a358-489e-a1f2-5c0a6f5b4db5@redhat.com>
 <22D1AD52-F7DA-4184-85A7-0F14D2413591@nvidia.com>
 <F60614E1-28D1-466B-A434-7FF1061B0778@nvidia.com>
 <9f836828-4f53-41a0-b5f7-bbcd2084086e@redhat.com>
 <884b9246-de7c-4536-821f-1bf35efe31c8@redhat.com>
 <6291D401-1A45-4203-B552-79FE26E151E4@nvidia.com>
 <b62234fc-051f-4b2a-b7da-0c0959fb269b@redhat.com>
 <8E2CE1DF-4C37-4690-B968-AEA180FF44A1@nvidia.com>
 <2308291f-3afc-44b4-bfc9-c6cf0cdd6295@redhat.com>
 <9FBDBFB9-8B27-459C-8047-055F90607D60@nvidia.com>
 <11ee9c5e-3e74-4858-bf8d-94daf1530314@redhat.com>
 <b5fa0989-a64a-4c91-ac34-6fb29ee6d132@redhat.com>
 <EC99D49E-86FF-4A50-A1AA-FC43A7D3716C@nvidia.com>
 <14aeaecc-c394-41bf-ae30-24537eb299d9@nvidia.com>
 <e5dd3f46-c063-45ff-8be7-64ac92534985@redhat.com>
 <71c736e9-eb77-4e8e-bd6a-965a1bbcbaa8@nvidia.com>
 <edbe38d4-3489-4c83-80fb-dc96a7684294@redhat.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <edbe38d4-3489-4c83-80fb-dc96a7684294@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::34) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|SA1PR12MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e2dabe-eb4b-4e4d-b933-08ddd0d1b03a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlNGTVlROUUvcGRZSXFXME9yZWg5ZHVJdjJOM2MrNHZaYWYrbnJBQ2hyVnJD?=
 =?utf-8?B?aHZoaktBTlBxdGg4d2pBL045bWgvdFBDQUFyRVJUV0d6OVpmMitPUjVXMmd6?=
 =?utf-8?B?d2dkQ0tFcndkNnhZRGMrVmhKT2xDcWhCbk43T2kybWIrTlNEL0tRVEpHVE1M?=
 =?utf-8?B?YW9pWnc0YWJlMnBjWC9OcTRjQzd5dGpqVVRzVWVUak0zck9IWXlHRG9YSTZs?=
 =?utf-8?B?UW4vZUJzSXkyM2NBc1RiWk45Y1pWU1JaeXk4ZUY5aWVYYThzdEJVUHY5cTFE?=
 =?utf-8?B?TjlPa203UEViT0d3QTVrZFI5SnltRGV0TlMxMXFPSGFlTTZlSzY2SVpKRW9u?=
 =?utf-8?B?VHo3b3E5Y2tJY2lNL2dCSDFKbDVQaUdIdktNdGxuNEY1dEZnSVdFKzVZUjF3?=
 =?utf-8?B?YjNTdVNKeUFZaGZjVjE4Sk96KzhCcmpRSStRUFg2dC9wYzJEenJaa0ZjaUs1?=
 =?utf-8?B?MzVFbHBPOTQ4WjQxbkd4eW9KOExUbWxIaDRJZ3hJWDhnRE9HeGpicXdCSG1I?=
 =?utf-8?B?ZW9oL3BBWTZzWUFHczgveCtPVWNBc3lDNk4yZnpqQ1hUWVVQWXFsd2FCdFRT?=
 =?utf-8?B?MC9saTVlTHQ2VDczKzVwNmVoaTVoVnRJYnQzWDVyYkN2R2xGNXluaHd2MitH?=
 =?utf-8?B?TFhDeThmQVM0UmRHZnNuNjZYelZIU2hoV0QxV0hyaStncUo0N0lEOFExTEtZ?=
 =?utf-8?B?VnZIeER3Znl5TWhUNm1uVjBOdjUxWnhMUjdEd2NpVmtZMkxWc3U4YkpDMVdq?=
 =?utf-8?B?WXN4Rk4zbWRlL1N5LzV2OXp5K1JHcFVtWmx3TktMTUtVN084M0c5d1ZHcGgv?=
 =?utf-8?B?MzNubURRT0pnclRHM29SOGdPT3pob2grNC9tR0w3TVVOU3hGTGFTTlhLNnV2?=
 =?utf-8?B?bktyQUdZYmFNa1JJTTFucnBGcUg1MHM2OVppcldiNmd3b1dTS3lnZmNOM3g5?=
 =?utf-8?B?eHQyZ3JWY3dpb3RwOTF6eEIxZ29XaUIyamFRSWNyLzJqbjNabmdtcjJMVDdv?=
 =?utf-8?B?UkVMMUMzVDhiN3pzUmwyRDFONVpPWnRJSGFsMWxJS1RxcnR1OU1rTjBwYWtj?=
 =?utf-8?B?dGFFMWovSWIyVmlVcUFFTTBOZDZ2Mi9ob2dBN0VCNG1lMkNPRUNBYTFhZnN5?=
 =?utf-8?B?OFBQaEVnMkRRaWdaOTF3ZnU0TDM0RzJnUzhIUnVFYmZYaVdGUDdDb1U5OFNh?=
 =?utf-8?B?YjQzMm0rcnh6Mmtibkoyd0ZTU1NnUitXTi9xclQ0bFJHQklHb2xaYk50dnRj?=
 =?utf-8?B?NzNuTS9vbnpRRTAxSTMvdElJYk9aY0JETjU4Mk5kZFVvTjE4YktQUkhXUys0?=
 =?utf-8?B?dlF4Tk5SWkpaYlRlUkgrTHZKRkxyTUJiNld1T2hlN1c4MUJ3WG5BQ1d3M0Vi?=
 =?utf-8?B?SHNlVW1Fd29CQms3R3FjdGJGUEFxRUJzS05tTkpqMnRGc2lIVXBCRlZmOFc2?=
 =?utf-8?B?VXFSUWlCUStiZC9BbGIzb1Y4dFIzekRiTkk0QkJJd2Q4c3NSU09nL2JWU1ky?=
 =?utf-8?B?SENQUGhUKzFydzFNWW95UWkrU3RhTVhoQlg3MHlCZy9jdXY1SXFSR3RFS2xu?=
 =?utf-8?B?Y0JNVUtxeEdZU1VNMnkwQ0FIRXdZNlhmUFpncE0yUXM2S3JjTDhMNmFBemlZ?=
 =?utf-8?B?Q080ZnVQNmRUY0dDKzY0SnZtMG1XZGFuUlQ2UXBkNkY5SHZWRlFxQlFRa28r?=
 =?utf-8?B?cUR3dlJuRXBZeEN4OWxvYk4xbHJvYmticTdjbExDNk5BaS9qSFc4ZS9oa0xl?=
 =?utf-8?B?ekhLR2taZkxaL3VGME4wVkpVMG1rVjFQdEZmWmVvdWxvK2k1emc1WXU2OW1T?=
 =?utf-8?B?U0pDNmlLVTZheEt0QnpEOTRWWjNCTXNxOTg0TWZkUExrR0VHcGEyUHBpNTJz?=
 =?utf-8?B?ZVY2Nms3QVJhSHlWQVBRNWY5cE5pQ1hmeStBNHJTdXp3TzNoRld2cU1Lc1VQ?=
 =?utf-8?Q?L80LcB5JXdY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZENLcTBNOHIxUlJiRXBYRXB1eFFyVDE5czZlT2pEOUQ4NVhHa3l6VDMwZ1Q0?=
 =?utf-8?B?bWxoU0lSTkRSdFZ1NURjVU9MOE5rQmR0OFdQOTJKU1l4SlRhTzNMcFk0Wlkw?=
 =?utf-8?B?M1ZPSng5aUprOGJjeEdLelVYdnVYeGlVaXBwTGlsQ2N5YUYzK29MU01vR01K?=
 =?utf-8?B?Z1NjOWhmMHNPSjZkVUtKTE1EWHQrOFVBNUoyTE12MVFXa0FDeHR5aFlyUWpv?=
 =?utf-8?B?REkxcGdLYVhUczBob1BsMUxOb2dVUnFKVnkrejFEMkVTS3BKTnVLU3laSHJI?=
 =?utf-8?B?bHpVeDNLVWFHY21mcEZvbmJabHA2UERhVzN6T2RzQ0xrcEtCcGw2MEhWMHBh?=
 =?utf-8?B?bWx2UUZGOGJxZGhGcVpqbmdHMjlQVlZDbkUvaHRlS3RENmR1ZXhGZmZvOTho?=
 =?utf-8?B?cjZEVys1a0R6amJ6V0RFcDBhWFpXc2Yxb3NlR25lbXJaSDlaR08vWDlWblFR?=
 =?utf-8?B?aTFNNXRpdWhPYitJbzJiNnQzSnl3ZmEyOFEzU1ZNMkhiOFhiQTkzRm8zV0ZQ?=
 =?utf-8?B?VGE0OFRUWm1jcWMrcjlCV084N0JYTHBmL1dIR3VFQ2VhKy9XSklBV01oSzNh?=
 =?utf-8?B?RTMrZFF3VWNiVlVRMTcvdVowMlNWeTNmWm9vd0Y2TFFGTVZ0ejdmZWYzVWRh?=
 =?utf-8?B?WDJERE5zajAxQXpDTktqbUVlYmhPSFY4RitrQWlEK1hyNEk5Q0F2VjlLTGNw?=
 =?utf-8?B?aE0wbUFCNmpBZS8vVXJJbE5yQm92N1Y2aHNEcHBRWTNaWWp5SGMzTzg0T3JM?=
 =?utf-8?B?R096SUJzc1R1aUN3ejFXUWlPaGRHZ2xTZVI2ZFcyaEl3RERqQWhSa3U0enVO?=
 =?utf-8?B?VXJTNmUvd3d2YngyeVh1SHZ3SXlUdFI4WVI5MmdwcDE4THBHVlJqRkx2ZTlv?=
 =?utf-8?B?NXRHVEpobG1Dc3BuUEFPSytMeTRYako2bDkvL0Zpa3gvLzFuQlA0YlNkdi9F?=
 =?utf-8?B?ZjdNSVphMnk5cDkvRk1wUUs3Rkw5WHpYUzAwZWc3R1R6aDAvUEJ3OTYweExi?=
 =?utf-8?B?Q0NiQmNud1RxTHlTampsblZSMWdwdmtDeEVWcnU3ZnpMUFhDVXhpOVVOUGty?=
 =?utf-8?B?TU0rbkpzbUg5anluZ0hNQnRQVHZheDR3S2hmMXViVGN3TkhaWW9LZzRRTDhG?=
 =?utf-8?B?cUxKazFEZzZxVkd5ZkJuRHJJRmh4YTVIUWUyS2ExRWxCT2IwWE9EckNTUjlI?=
 =?utf-8?B?ckE3QmhSTHF3NkI5MXQzU1hMajlhMmRSaitGeE9RV2IvblNZR3QxUDdFOUx1?=
 =?utf-8?B?bmFDQXN1K080a3ROeUlieW5rRlc2V0JiSEU3bXNKSUxqYmhTUHlQQlZ2b1RX?=
 =?utf-8?B?OTBEWmdyT0ZRM0ZKaHhSenpmT2ROTHZWRHVNTzBwQnlMd0pqMDZpTUxsS09Y?=
 =?utf-8?B?ZXpDbjRmVXh4dUtXN2R4NEFkTnNIc200eTFPZW51MlF0ZGIyd1JORHU2RUNj?=
 =?utf-8?B?dUE5cDZvK2JvbG43bTI1amJ5TXFxZFRXRWkwUjdQVjZWVGtIeTFXcUk3WHUr?=
 =?utf-8?B?emE5Z3hnVTR3OW5uUlZYZjJEY20zZEZia3RFOTdTamVEa0syL0pZZ1ZjWTNB?=
 =?utf-8?B?cGNmY3FrcittRC9xZUR1bEZ4QmRGbk9IcUZGM3FtdmRCNXJEaENWK2piS2dz?=
 =?utf-8?B?T3Uyc3N1NVhRRXUzRWMzV2owR2NZQlJyMmtvazRlM2FsR0lCSU1UTGcxOTJO?=
 =?utf-8?B?Z2Zqamh4N0xsNHZMVTVLRnBMeVJHbVhMalFkL1NISmpoeHBVNWVjcnIzRnRo?=
 =?utf-8?B?NjBOcGVJRmFGTVJzdllnL1cvTGNWbUNaOXlxay9QMHhWdXZESDNtSmdsN2pL?=
 =?utf-8?B?Q2laQUNBQWluL1RqdHZuL1BOSHJBeWdGNFhmYmRVQ0ppbkV5UGRhUk4vNEVW?=
 =?utf-8?B?YW9DbVZFK2xZWEFkMFhiU0xmU1RvMGZMVlhNdEN6MDZXaHFNU25zQjFqV2Ru?=
 =?utf-8?B?OFhLb3F4eW9PanlEWS9qckZTYzBWVDc1a3ZJa0lmMWVIZHcyUEpSVWMzOUZW?=
 =?utf-8?B?T1d3YVNPVG90cFl0SFRxNHBZcXg2QzdBY2pzNXBiWHVSdmI0b0JxWnNmTnVn?=
 =?utf-8?B?ZXVqSVFkaG5JcitZenZWREVnSlRWSXhEQTZJeDNjWjNqRWxIeG1yRWRUamFm?=
 =?utf-8?Q?/5NbLFA8g7KWMAfPKbs6ovhKv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e2dabe-eb4b-4e4d-b933-08ddd0d1b03a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 08:01:58.1574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/EzLi29cL4euLD3rftb6Ugq5aE3LFcGD175rv9yFfeoqBW5Ozn5hKu6eukjycAYKuNzJ5OYhpneAxMj8NNrFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7198

On 8/1/25 17:04, David Hildenbrand wrote:
> On 01.08.25 06:44, Balbir Singh wrote:
>> On 8/1/25 11:16, Mika Penttilä wrote:
>>> Hi,
>>>
>>> On 8/1/25 03:49, Balbir Singh wrote:
>>>
>>>> On 7/31/25 21:26, Zi Yan wrote:
>>>>> On 31 Jul 2025, at 3:15, David Hildenbrand wrote:
>>>>>
>>>>>> On 30.07.25 18:29, Mika Penttilä wrote:
>>>>>>> On 7/30/25 18:58, Zi Yan wrote:
>>>>>>>> On 30 Jul 2025, at 11:40, Mika Penttilä wrote:
>>>>>>>>
>>>>>>>>> On 7/30/25 18:10, Zi Yan wrote:
>>>>>>>>>> On 30 Jul 2025, at 8:49, Mika Penttilä wrote:
>>>>>>>>>>
>>>>>>>>>>> On 7/30/25 15:25, Zi Yan wrote:
>>>>>>>>>>>> On 30 Jul 2025, at 8:08, Mika Penttilä wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>> On 7/30/25 14:42, Mika Penttilä wrote:
>>>>>>>>>>>>>> On 7/30/25 14:30, Zi Yan wrote:
>>>>>>>>>>>>>>> On 30 Jul 2025, at 7:27, Zi Yan wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On 30 Jul 2025, at 7:16, Mika Penttilä wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> On 7/30/25 12:21, Balbir Singh wrote:
>>>>>>>>>>>>>>>>>> Make THP handling code in the mm subsystem for THP pages aware of zone
>>>>>>>>>>>>>>>>>> device pages. Although the code is designed to be generic when it comes
>>>>>>>>>>>>>>>>>> to handling splitting of pages, the code is designed to work for THP
>>>>>>>>>>>>>>>>>> page sizes corresponding to HPAGE_PMD_NR.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Modify page_vma_mapped_walk() to return true when a zone device huge
>>>>>>>>>>>>>>>>>> entry is present, enabling try_to_migrate() and other code migration
>>>>>>>>>>>>>>>>>> paths to appropriately process the entry. page_vma_mapped_walk() will
>>>>>>>>>>>>>>>>>> return true for zone device private large folios only when
>>>>>>>>>>>>>>>>>> PVMW_THP_DEVICE_PRIVATE is passed. This is to prevent locations that are
>>>>>>>>>>>>>>>>>> not zone device private pages from having to add awareness. The key
>>>>>>>>>>>>>>>>>> callback that needs this flag is try_to_migrate_one(). The other
>>>>>>>>>>>>>>>>>> callbacks page idle, damon use it for setting young/dirty bits, which is
>>>>>>>>>>>>>>>>>> not significant when it comes to pmd level bit harvesting.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> pmd_pfn() does not work well with zone device entries, use
>>>>>>>>>>>>>>>>>> pfn_pmd_entry_to_swap() for checking and comparison as for zone device
>>>>>>>>>>>>>>>>>> entries.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Zone device private entries when split via munmap go through pmd split,
>>>>>>>>>>>>>>>>>> but need to go through a folio split, deferred split does not work if a
>>>>>>>>>>>>>>>>>> fault is encountered because fault handling involves migration entries
>>>>>>>>>>>>>>>>>> (via folio_migrate_mapping) and the folio sizes are expected to be the
>>>>>>>>>>>>>>>>>> same there. This introduces the need to split the folio while handling
>>>>>>>>>>>>>>>>>> the pmd split. Because the folio is still mapped, but calling
>>>>>>>>>>>>>>>>>> folio_split() will cause lock recursion, the __split_unmapped_folio()
>>>>>>>>>>>>>>>>>> code is used with a new helper to wrap the code
>>>>>>>>>>>>>>>>>> split_device_private_folio(), which skips the checks around
>>>>>>>>>>>>>>>>>> folio->mapping, swapcache and the need to go through unmap and remap
>>>>>>>>>>>>>>>>>> folio.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Cc: Karol Herbst <kherbst@redhat.com>
>>>>>>>>>>>>>>>>>> Cc: Lyude Paul <lyude@redhat.com>
>>>>>>>>>>>>>>>>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>>>>>>>>>>>>>>>>> Cc: David Airlie <airlied@gmail.com>
>>>>>>>>>>>>>>>>>> Cc: Simona Vetter <simona@ffwll.ch>
>>>>>>>>>>>>>>>>>> Cc: "Jérôme Glisse" <jglisse@redhat.com>
>>>>>>>>>>>>>>>>>> Cc: Shuah Khan <shuah@kernel.org>
>>>>>>>>>>>>>>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>>>>>>>>>>>>>>> Cc: Barry Song <baohua@kernel.org>
>>>>>>>>>>>>>>>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>>>>>>>>>>>>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>>>>>>>>>>>>>>>> Cc: Matthew Wilcox <willy@infradead.org>
>>>>>>>>>>>>>>>>>> Cc: Peter Xu <peterx@redhat.com>
>>>>>>>>>>>>>>>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>>>>>>>>>>>>>>>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>>>>>>>>>>>>>>> Cc: Jane Chu <jane.chu@oracle.com>
>>>>>>>>>>>>>>>>>> Cc: Alistair Popple <apopple@nvidia.com>
>>>>>>>>>>>>>>>>>> Cc: Donet Tom <donettom@linux.ibm.com>
>>>>>>>>>>>>>>>>>> Cc: Mika Penttilä <mpenttil@redhat.com>
>>>>>>>>>>>>>>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>>>>>>>>>>>>>>> Cc: Francois Dugast <francois.dugast@intel.com>
>>>>>>>>>>>>>>>>>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>>>>>>>>>>>>>>>>>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>>>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>>>>    include/linux/huge_mm.h |   1 +
>>>>>>>>>>>>>>>>>>    include/linux/rmap.h    |   2 +
>>>>>>>>>>>>>>>>>>    include/linux/swapops.h |  17 +++
>>>>>>>>>>>>>>>>>>    mm/huge_memory.c        | 268 +++++++++++++++++++++++++++++++++-------
>>>>>>>>>>>>>>>>>>    mm/page_vma_mapped.c    |  13 +-
>>>>>>>>>>>>>>>>>>    mm/pgtable-generic.c    |   6 +
>>>>>>>>>>>>>>>>>>    mm/rmap.c               |  22 +++-
>>>>>>>>>>>>>>>>>>    7 files changed, 278 insertions(+), 51 deletions(-)
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> <snip>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> +/**
>>>>>>>>>>>>>>>>>> + * split_huge_device_private_folio - split a huge device private folio into
>>>>>>>>>>>>>>>>>> + * smaller pages (of order 0), currently used by migrate_device logic to
>>>>>>>>>>>>>>>>>> + * split folios for pages that are partially mapped
>>>>>>>>>>>>>>>>>> + *
>>>>>>>>>>>>>>>>>> + * @folio: the folio to split
>>>>>>>>>>>>>>>>>> + *
>>>>>>>>>>>>>>>>>> + * The caller has to hold the folio_lock and a reference via folio_get
>>>>>>>>>>>>>>>>>> + */
>>>>>>>>>>>>>>>>>> +int split_device_private_folio(struct folio *folio)
>>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>>> +    struct folio *end_folio = folio_next(folio);
>>>>>>>>>>>>>>>>>> +    struct folio *new_folio;
>>>>>>>>>>>>>>>>>> +    int ret = 0;
>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>> +    /*
>>>>>>>>>>>>>>>>>> +     * Split the folio now. In the case of device
>>>>>>>>>>>>>>>>>> +     * private pages, this path is executed when
>>>>>>>>>>>>>>>>>> +     * the pmd is split and since freeze is not true
>>>>>>>>>>>>>>>>>> +     * it is likely the folio will be deferred_split.
>>>>>>>>>>>>>>>>>> +     *
>>>>>>>>>>>>>>>>>> +     * With device private pages, deferred splits of
>>>>>>>>>>>>>>>>>> +     * folios should be handled here to prevent partial
>>>>>>>>>>>>>>>>>> +     * unmaps from causing issues later on in migration
>>>>>>>>>>>>>>>>>> +     * and fault handling flows.
>>>>>>>>>>>>>>>>>> +     */
>>>>>>>>>>>>>>>>>> +    folio_ref_freeze(folio, 1 + folio_expected_ref_count(folio));
>>>>>>>>>>>>>>>>> Why can't this freeze fail? The folio is still mapped afaics, why can't there be other references in addition to the caller?
>>>>>>>>>>>>>>>> Based on my off-list conversation with Balbir, the folio is unmapped in
>>>>>>>>>>>>>>>> CPU side but mapped in the device. folio_ref_freeeze() is not aware of
>>>>>>>>>>>>>>>> device side mapping.
>>>>>>>>>>>>>>> Maybe we should make it aware of device private mapping? So that the
>>>>>>>>>>>>>>> process mirrors CPU side folio split: 1) unmap device private mapping,
>>>>>>>>>>>>>>> 2) freeze device private folio, 3) split unmapped folio, 4) unfreeze,
>>>>>>>>>>>>>>> 5) remap device private mapping.
>>>>>>>>>>>>>> Ah ok this was about device private page obviously here, nevermind..
>>>>>>>>>>>>> Still, isn't this reachable from split_huge_pmd() paths and folio is mapped to CPU page tables as a huge device page by one or more task?
>>>>>>>>>>>> The folio only has migration entries pointing to it. From CPU perspective,
>>>>>>>>>>>> it is not mapped. The unmap_folio() used by __folio_split() unmaps a to-be-split
>>>>>>>>>>>> folio by replacing existing page table entries with migration entries
>>>>>>>>>>>> and after that the folio is regarded as “unmapped”.
>>>>>>>>>>>>
>>>>>>>>>>>> The migration entry is an invalid CPU page table entry, so it is not a CPU
>>>>>>>>>>> split_device_private_folio() is called for device private entry, not migrate entry afaics.
>>>>>>>>>> Yes, but from CPU perspective, both device private entry and migration entry
>>>>>>>>>> are invalid CPU page table entries, so the device private folio is “unmapped”
>>>>>>>>>> at CPU side.
>>>>>>>>> Yes both are "swap entries" but there's difference, the device private ones contribute to mapcount and refcount.
>>>>>>>> Right. That confused me when I was talking to Balbir and looking at v1.
>>>>>>>> When a device private folio is processed in __folio_split(), Balbir needed to
>>>>>>>> add code to skip CPU mapping handling code. Basically device private folios are
>>>>>>>> CPU unmapped and device mapped.
>>>>>>>>
>>>>>>>> Here are my questions on device private folios:
>>>>>>>> 1. How is mapcount used for device private folios? Why is it needed from CPU
>>>>>>>>      perspective? Can it be stored in a device private specific data structure?
>>>>>>> Mostly like for normal folios, for instance rmap when doing migrate. I think it would make
>>>>>>> common code more messy if not done that way but sure possible.
>>>>>>> And not consuming pfns (address space) at all would have benefits.
>>>>>>>
>>>>>>>> 2. When a device private folio is mapped on device, can someone other than
>>>>>>>>      the device driver manipulate it assuming core-mm just skips device private
>>>>>>>>      folios (barring the CPU access fault handling)?
>>>>>>>>
>>>>>>>> Where I am going is that can device private folios be treated as unmapped folios
>>>>>>>> by CPU and only device driver manipulates their mappings?
>>>>>>>>
>>>>>>> Yes not present by CPU but mm has bookkeeping on them. The private page has no content
>>>>>>> someone could change while in device, it's just pfn.
>>>>>> Just to clarify: a device-private entry, like a device-exclusive entry, is a *page table mapping* tracked through the rmap -- even though they are not present page table entries.
>>>>>>
>>>>>> It would be better if they would be present page table entries that are PROT_NONE, but it's tricky to mark them as being "special" device-private, device-exclusive etc. Maybe there are ways to do that in the future.
>>>>>>
>>>>>> Maybe device-private could just be PROT_NONE, because we can identify the entry type based on the folio. device-exclusive is harder ...
>>>>>>
>>>>>>
>>>>>> So consider device-private entries just like PROT_NONE present page table entries. Refcount and mapcount is adjusted accordingly by rmap functions.
>>>>> Thanks for the clarification.
>>>>>
>>>>> So folio_mapcount() for device private folios should be treated the same
>>>>> as normal folios, even if the corresponding PTEs are not accessible from CPUs.
>>>>> Then I wonder if the device private large folio split should go through
>>>>> __folio_split(), the same as normal folios: unmap, freeze, split, unfreeze,
>>>>> remap. Otherwise, how can we prevent rmap changes during the split?
>>>>>
>>>> That is true in general, the special cases I mentioned are:
>>>>
>>>> 1. split during migration (where we the sizes on source/destination do not
>>>>     match) and so we need to split in the middle of migration. The entries
>>>>     there are already unmapped and hence the special handling
>>>> 2. Partial unmap case, where we need to split in the context of the unmap
>>>>     due to the isses mentioned in the patch. I expanded the folio split code
>>>>     for device private can be expanded into its own helper, which does not
>>>>     need to do the xas/mapped/lru folio handling. During partial unmap the
>>>>     original folio does get replaced by new anon rmap ptes (split_huge_pmd_locked)
>>>>
>>>> For (2), I spent some time examining the implications of not unmapping the
>>>> folios prior to split and in the partial unmap path, once we split the PMD
>>>> the folios diverge. I did not run into any particular race either with the
>>>> tests.
>>>
>>> 1) is totally fine. This was in v1 and lead to Zi's split_unmapped_folio()
>>>
>>> 2) is a problem because folio is mapped. split_huge_pmd() can be reached also from other than unmap path.
>>> It is vulnerable to races by rmap. And for instance this does not look right without checking:
>>>
>>>     folio_ref_freeze(folio, 1 + folio_expected_ref_count(folio));
>>>
>>
>> I can add checks to make sure that the call does succeed.
>>
>>> You mention 2) is needed because of some later problems in fault path after pmd split. Would it be
>>> possible to split the folio at fault time then?
>>
>> So after the partial unmap, the folio ends up in a little strange situation, the folio is large,
>> but not mapped (since large_mapcount can be 0, after all the folio_rmap_remove_ptes). Calling folio_split()
>> on partially unmapped fails because folio_get_anon_vma() fails due to the folio_mapped() failures
>> related to folio_large_mapcount. There is also additional complexity with ref counts and mapping.
> 
> I think you mean "Calling folio_split() on a *fully* unmapped folio fails ..."
> 
> A partially mapped folio still has folio_mapcount() > 0 -> folio_mapped() == true.
> 

Looking into this again at my end

>>
>>
>>> Also, didn't quite follow what kind of lock recursion did you encounter doing proper split_folio()
>>> instead?
>>>
>>>
>>
>> Splitting during partial unmap causes recursive locking issues with anon_vma when invoked from
>> split_huge_pmd_locked() path.
> 
> Yes, that's very complicated.
> 

Yes and I want to avoid going down that path.

>> Deferred splits do not work for device private pages, due to the
>> migration requirements for fault handling.
> 
> Can you elaborate on that?
> 

If a folio is under deferred_split() and is still pending a split. When a fault is handled on a partially
mapped folio, the expectation is that as a part of fault handling during migration, the code in migrate_folio_mapping()
assumes that the folio sizes are the same (via check for reference and mapcount)

Balbir



