Return-Path: <linux-kernel+bounces-735765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C02B0938C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43C716F3AC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9362FE32F;
	Thu, 17 Jul 2025 17:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TAwZN2KO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HoTZ4UnF"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511162FEE15
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752774287; cv=fail; b=iirzi2VW9DXiW0Its3DzO6l49WrNmeqMpI/zMgQ1HehEXgszASOkNkaJ/ZJgB6pNOd/D/sJIRJnw0lJDF8uE45kzISmPi32LJP/Wz5qWu5Oq2NXwxdI7WHm9xGE0Pz/gdJ3E0NC5IX+CjgidzwrmFMoYnq9ucKRil9WbGIx0mMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752774287; c=relaxed/simple;
	bh=4ySd6lRqDMQ8tSqqbFxCUwsTTzgQNiU5g6RnGM4Glgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Su+6b20CnGVvn8+8YCKopVJPKE95IjxGZ+KGclqx8AditahGfFSHgUqTcgMCYXQ73xe2OLo8lUZLJp4NdIK8JBGC6uZBsyMwgsKggYMwi4XpTYvnhDUViV3q7Epj9QevvVRiPnK/qQjlEoKKIKy008c85ojLPih399Nwr7kidbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TAwZN2KO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HoTZ4UnF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HH0iD4027536;
	Thu, 17 Jul 2025 17:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KOxA8E/5kCuDEY9/F8qmrsu77u732mZojknjSKPLcM0=; b=
	TAwZN2KO8q2IaiTNTM/96bPCvDIuDKxX8MkDlkWSlS+5ckSSewK/FHcltgcTx/Cv
	a0+Glh2wnPb+kQqke83yLOeZVwtLNUGYwHT2jtjhABdUQogyAirf4vhRCc+W4pH7
	uhU+LFtscHMHxIc/VcCFTPoXxrRcXDZpRNzDqeEeilaOEaiBXtHz+2NIYF06WoGD
	OEiLUGWtrTDSL37nPabcWH/EglrkMqN0BQn6q25gHuhlfp4NtNSF/ohWtv70AYmR
	pxncAUOiYC7U0LiYG3EA297+nf5g+G+aKM0APa0dNazyWxju182bbU6ztdR95f6x
	42iLDdLU9KPWqmPSjMMS2g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1b3pf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 17:44:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HHdiPU030345;
	Thu, 17 Jul 2025 17:44:25 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5d0b6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 17:44:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9bQ3WWifKwSsUrvC3CNkS1iLc5e7iUvwGUolLzbQwPrTFNX9sxCGnWq8Z2YOKsHftgNCbQpTWG/KgoCJRuUFRAvCTSRuCe396kvAAlvIYZxfMrehS0usFLn3QUMoOrHsVHgxx5AGO9bWlbwIHvNhJywcmI3+f6lMzitt/TZqHPerTv2zQ4JcX3OFCTC+C2nI6F9oXQrpGn0GsGEtzcctny8QWZV5nz5btnlASi/Xn052pH1l0aFYL6r7aHpO/lA8Z2TqrL5ymGjxe2ebqWGATyYxHCEAI5WU3arbaVhySqAgplAGTDM5glmlLlxPbXWomINnWz/Y5SHgHx5ssGK4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOxA8E/5kCuDEY9/F8qmrsu77u732mZojknjSKPLcM0=;
 b=G5+4I3yrA+1bkg+rBRFdzn5Z9rCi5YBD5ruVY7jizgcUfArVe5MpY5LPZ3DMblSyiam8UiPS2soCottRry2EvQszlXcB4QsL99xxkthS4x8+eyWzYrR/dg6avSri8+7XM0SI7re1joWyn20wnqL4ZPJaOY/uh/U28F47jrlBF5mvMqs68Oy4bvh0eqnoj99wMowwMqeEUsFotuog6NsWzW3WycSNnttkuyrlrTqlfTnw0fG6LaJU8OiTe+gKYZ8p0nhhtx9tjG9O+yBjsOlvcB/6md2FDUVfO/AsmJQ7+AXFBz1F9MRnJz5U7fEIPwf3e1APc8qFHPXk6qkMQ0eWFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOxA8E/5kCuDEY9/F8qmrsu77u732mZojknjSKPLcM0=;
 b=HoTZ4UnFFYggGce7Er+pP89flraowSYWguZ9cCeTjUfhPkEydAA17j1Cn8Lxci8IKkHx7YXkjLFBRZ/y9nQNMq/Bf3As2iFZUsI6xSmKGFHKcoIGLzewkeKGRFJrX1y6obbYD18+TyAi8H3Xqkvo/7ktutCfU+qqRrsYdh+jFiA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN2PR10MB4125.namprd10.prod.outlook.com (2603:10b6:208:1df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Thu, 17 Jul
 2025 17:44:23 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 17:44:23 +0000
Date: Thu, 17 Jul 2025 18:44:20 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>, David Hildenbrand <david@redhat.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Kirill Shutemov <k.shutemov@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm/huge_memory: move unrelated code out of
 __split_unmapped_folio()
Message-ID: <fbe387c9-4205-41df-84b4-ace69f7cbedb@lucifer.local>
References: <20250714171823.3626213-1-ziy@nvidia.com>
 <20250714171823.3626213-2-ziy@nvidia.com>
 <5c97b1a8-b877-438b-91a9-1d1da19964a3@lucifer.local>
 <214884E5-15A2-48F6-A495-6133CE07E1C6@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <214884E5-15A2-48F6-A495-6133CE07E1C6@nvidia.com>
X-ClientProxiedBy: LO6P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN2PR10MB4125:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a707e2-6b90-4b91-f756-08ddc55990dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SW4zU1R6SlpvaGplWEhmOWlCcU9NQXdEc29NbG5tQUE2a0o4ODdWWm5RaTI2?=
 =?utf-8?B?SkVhd3gxMGg3cTRhMStncC8rWXpOb05xc2E4YWlqR2xmUHpIZEZrQ3R1WmNL?=
 =?utf-8?B?R2MvOENvWmxlUFVhNHFOVDI4NENCbkpDVmUrclVwY0xSR0cyVkFDNHVMaWVu?=
 =?utf-8?B?RUFxR1FyZ25kMWlMeVByMTZuSFRpaitwQU9ISWZZaG45OXI4NzlEa3lwbFdq?=
 =?utf-8?B?RmVZbWlNaU9CREVDTWZtWExLbDdSTnpqcG9PQkJjVnplSGdKbFVObmtwZVVl?=
 =?utf-8?B?Y1VzeXdzYTVWcTBWbkZQMk5BYlRROVZlbGN2cExPdC9JMk9UZ3lwaDFHbGZv?=
 =?utf-8?B?azlpbHNlcnhZVnJhNHZEQUZNMXJtV0hwTWIwRVNsV3VJcWJQTmM1eGF6Q2Q0?=
 =?utf-8?B?bHQrQ2hxUG0zSUdJMXowTFNVcG1XWmc0aEFMTGhZa3FrdnQvd2hQZ1Y0bU43?=
 =?utf-8?B?bERyTmRERXlWUytOMHRZZTIrU1ZDQmZwY2ZkS2dhSFFoK1QzMnFPSlViNUdt?=
 =?utf-8?B?NFdFK3JGWjhCMXZmNUZ3Y05BYmYvYWVHRW9NanFPQ3hqNlIzRktJRmxpMFQv?=
 =?utf-8?B?bWtWbVBiR3VVdGdFa2daSktsTVdPTFdnMXVWU3FmRWl2Q3dyY1cxWDZFVzRv?=
 =?utf-8?B?T0ozV1UvNVRCUzdZdWNtQm1SV1lTVzlKS1VrdjVkWXBMTFpad1F2cnVqbThp?=
 =?utf-8?B?dUJxWFJtRFVHV3BXOUp1V3V5UFBHUGhKaDViZk56blRHOTB5dlN0bmI4UUNo?=
 =?utf-8?B?WWxLTVJnRm1OQUhteklFY1RLZVN2SzZRazFxTy9McVU5emNaOURXR1JYSTky?=
 =?utf-8?B?T2hVRGUxQi8yRm1rNW9oWFFiekRCaHIxajNUOWNaK2Y3Vy9xZkpJa2NLUkhV?=
 =?utf-8?B?N1c1L2txbGl0MFlyVWw3V3lDYU5MNlR5Z0hKQkQ1NGdjVUJHejkvWkVSSnJQ?=
 =?utf-8?B?aERWTVluRWhIUHV5OGd4S3Y4TGdyU0JHdnEwS2pmRnVFY1JJZzhMWmw4UTZv?=
 =?utf-8?B?TXA0ZkJ4OXdpOXdObGtnbjJab3hrUWlib3c5MjVCc2xxcU9DV2k1NFY5eG9r?=
 =?utf-8?B?ZG9sbVVQUkZWTlhDbDFnSzBIYVA5L0VqdkVhK1JpREFDRlBINmNtRks0SHd1?=
 =?utf-8?B?RFRVODE3NXlTdjljTHJBUHl1eWd3VTZkZGRvVGRSS1NwZGZXdWcvckh4aEN3?=
 =?utf-8?B?RUozZUM3RjRjWlgxN3NyWllhcXJuY29BRnFQWFZWOE94S2tNMGpLdDVuOFQy?=
 =?utf-8?B?Q3Boc1NSUHgwY3Y2Mm5ycHY0V0Z6WEdWelA5L3pYZXdSQnZ5UzJzM2R1TjRt?=
 =?utf-8?B?OTM4NUx3QWR2aWNxWExwMGxiWUdWaVRsSTRqbTJxdWN1U0x6dkpXSlVESmw3?=
 =?utf-8?B?dmVUMEZrL3djSVVQRU41NU81UzBMTUZDcWFCTkhxRCtqRW13bytBZnVOcXEr?=
 =?utf-8?B?Rnd2Z050K1dRL0Q3Si9iV2ZDQXl5K1YweFFubnA3VXdPSWJhNC9rdk9HREpS?=
 =?utf-8?B?UmlTbHh2RXdZRWtpbXlDVGZ6RkJtOXUvRmJpSDB0QzNqQnNVL3N1RmptRE0x?=
 =?utf-8?B?dmt6a2VsaHpjNEdZelZ2eFZPYlBFT1BBOUlUdER4SnpmcGVjZ2puTWcxZktt?=
 =?utf-8?B?dWNwa01hMGx3NVgxMUlhclpxTlpnZTFtVVhNRnFpOFhFVUs1MmtBWTQybmx4?=
 =?utf-8?B?cms0L0JuckE0empsQ0wvVzcyRHQ4WVhkL0xiancyTURwWUxDWldPQkNjS2N2?=
 =?utf-8?B?aWpGZzMrVHhHYkRhTWljOFBPRTRhZjVEMEJ1N0Q0RHJvY0Nob0ZVOWJDTmlK?=
 =?utf-8?B?OUFqWFNjYWlMMjBhb2RyaTRJWjVUcVdNWVVyYlp0ZEZDN2MxbHNJSDYyMGtk?=
 =?utf-8?B?Z3NGOG9DazlLTEdVNWpqTEJLN3ZvZmVPVEZrdHdkM3hHQmZacjAwam5IU05n?=
 =?utf-8?Q?8W0nkDvR9KU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUN3ZW1WNjg4TVp0L3lmcjlzT29JNCs3TEVnWlRKUHNSUzZsTkZwWEtXeFQ4?=
 =?utf-8?B?WEt1MHJhZnkyRGdvMFJFL2lwVEFkV05QRUFMaTYxRmwzR2dkeDdJSTVmOEtm?=
 =?utf-8?B?b3NlL1VVOEt6WVRicVdXS3ZtREoveE5KVWdHNDVZaUg5WWFOWTZhZDh2eWlw?=
 =?utf-8?B?cUxWOUkwOTlSdktFRkVpWXR1aC96NmhxUm5EczZDR1JkOWpiZXl6T1N0NUNw?=
 =?utf-8?B?SVRhblQ2ZXlYR09qcll1WW9TVTBpMFhENlQ3UEsrem1NWW1aSjFpd0tYNnNy?=
 =?utf-8?B?SHdRQ3Mvb20wdWVaaWRGRlB6UG82c2syWFpPMXVDdmNiVEV6RzFTbVczcmVS?=
 =?utf-8?B?VkZyNUYxRnAzUW5OeGU5ZHgxQ2h3V1hhTWNHd0NKSU0wbmlmR282Z29oT2JZ?=
 =?utf-8?B?MXhReWRiNXk0eHRMUk1CeC9OWWttQlFnT1V5V1VOV1EyWUZjbGJPdFBIdVJN?=
 =?utf-8?B?Vm15ZmhWQmx3QjNpSzR1M0d5TmROUGZoQlhzMmdHTUYzT014aUFWT2RaUVBr?=
 =?utf-8?B?QTVBSHhGS2lxNzBYZFZmMDJFNys1Y1RZRkt1ZTdFOTVJRUsra2tNWncxcDJ4?=
 =?utf-8?B?RzVJeC9nRm5BUVhJS2pFMVZsM3dwNzdjRUs2b1NYU0pDeDVnd1BWVXhuT1gr?=
 =?utf-8?B?OEF4VGhiZy9KcFpRc2U2RHZUWnhpb2NZejdTUlhQRm54M3R3STUvMHlCNnJZ?=
 =?utf-8?B?RmlJRHVMTXJFT2Nhb3RMekNkSkdla0o4Yi93Mm1rRld3dTl4ODd1SE5CRWdM?=
 =?utf-8?B?SE9RL09zbHA1LzQrcHd5YU9ZQlp3MitNeEZzTUdIQWdzWDJUUXBnWXA4ZzVs?=
 =?utf-8?B?TnliVStqRjQ2R3FFTTRES3dCQS95NThBUjkrbnVjQkVJUGMxNlQ1TGlCSnFI?=
 =?utf-8?B?WWd6Q0dxaUR4NmZJQXUyeXI2NllORmNzSWF6bFRKdWhPUTJCSUtPbkR4bURt?=
 =?utf-8?B?b3NBaTZHSFhlSU83U0Nva3NVVWZTNUVFeGVRbWtIakFsVzJGK0VBamVSVCsz?=
 =?utf-8?B?eDBuMEFVVnFka2NGaEs3VHF2QW1KYkdVR3NrWWdERHNpeU5wRDExaU1pSG5H?=
 =?utf-8?B?MTNzUlVhY3cyZDFIUEhnNDZvaU1GcXUvR3N1U0RCVDFEUklQdDBXejJKOVZI?=
 =?utf-8?B?ZGVEQTdlNzRJTWdENjZHR2tZOFdXUXJnS0xWbjUrZnp6WmFEb0pWU2h1aGFj?=
 =?utf-8?B?M29OTzZoVHhNSkJOMjNCV3hqcXZ5SU14ZHVsSzFaQ1U0ZUJNUSsxRFdHOUVl?=
 =?utf-8?B?REVJWlZiMDY3SzJncjdCM3VEdGJqd3FaZkxYNG9ocnNpVlVPdEsxOEZnTlk3?=
 =?utf-8?B?VXVldXB1T0txRFFmd0RjdklNd0RBYVJDUG1ERlE0T3dzN1QzVVNDWTNGZDB2?=
 =?utf-8?B?b1BNM1ZoZzduWlF4enpYd3pOcEZsVTVPeUtyNndtNVFpQnBUSmdZejBNczFY?=
 =?utf-8?B?dDhnN2p6bEw3cS9XcDJlMnI0SXBxOWora1BwdTRxSjI1dHk4ZkU1ME55L0FC?=
 =?utf-8?B?NGp0WTl2Q2ZXbWF6UGxEc3FLeVBjeitucCtGL2NNaHhJYmJwbmN0MGxkSURU?=
 =?utf-8?B?UWw3MHAweCtkNW9VN1ByMklOZ3JuTTNWS1BldjcxSTZ3SWYzNWhvTXE3ZUw0?=
 =?utf-8?B?TGdVZXJNNEhYQVJNdXJTa0F3TWlCaFQwOC9OUW02L3JHZlJRNWRsaklqYk1L?=
 =?utf-8?B?TEJJamQ1MWlDNTJLNFhmRDBmVzFmZUkydExRUUYzQ3FiaUJ6akpuQXp4WG9M?=
 =?utf-8?B?NmxvUXFUNUdkVDR2MmZhc3B0d290dHowLzE3MHRSRjhYVk9MRzJrTmF4bGt6?=
 =?utf-8?B?cDU2YVRYaVJ4bWFqUG4wVnFGN1ROZlJURWQ3U1ovV0VuNkJQSFNrZGVwZU1I?=
 =?utf-8?B?SFZMekdkNWRGcXR4Wmg3bXNRbW82YThMb1l6Q1JDTzF5aE1uM1RtQkpEVjly?=
 =?utf-8?B?S09Ec3RsNFBLNmgrQ3NQZXhVSlRTOWxuMTIvQXRuNllaY1NlSW5zb0pCWUs2?=
 =?utf-8?B?UDZWNjE3Z2dUWXZsL0FVU0hMendWc1ZSck5UN1laSkFScE56OVBoZGEyRGFp?=
 =?utf-8?B?cFppaEUyU3hiYWRqM1U1SlBBWEFyTjJ2Sk5mMUhUem1ZN2VzMnBpa28vWkNE?=
 =?utf-8?B?bWdtUWxKVWZKdVRWbWZLOXIxalQzNU1GcUxKclpCMUJ5dHNZWitObFlUa2Vy?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U1H+PbzZmlXSdAmFrYkMl1jOaruQM4PZT0oEBC5XY6zh7LwT2vbFZ8TVflBPCgt145ds5DGxUTSYrJ4L/Jq8/ruJzrjwpfttST05PsCkQ8X5m51Cyso2qiWEcukBZo9nW7symLYLJhDKWIhS8F/J/+lrKw2QyuL18C8SboTmf50BF08LEqR8ASaiUuaEs8ZoLmI9ZGwHTwq7onMEVRbeeFYEDEWKg8xnQ1K4ckD0dTsSDwNGGK9ex8uvni8RvGmb3xJm2y7rgZzpCcD+4c3mpDFDsfD4LpyN8hOW9IrNVT2cuW9TZ2DvFfOFA5II2WBQdrEv3Pc4IcI0vOnrKIfZpkQRAwJaIMuJ/qERbEkTi2ViPmfRl+6oPWdakTTHeeJs7TrDhduTtJZKGvKWrtzHvIu2eW50mzXLpBFf3fwxva2F7V/+H6vTqy8+66PfKIk+PK7sYnnXJfUIMY8j5wSZM/h91R7SCpx4IGicbFpMxBVGuqE/hXFPpLcNQOxViEA+IVxrKGYX0zrFK+Awij/PWF3PWOxOKEMZK2xkKKNbq1+M+C5y85lLPq5RnKnuDo9S0aS8ynrIMR/sEKfusALhjlJbgptGckctw96eQttrHIw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a707e2-6b90-4b91-f756-08ddc55990dd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 17:44:23.1634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoFCBZQkllkHv5wKf/emCPKEXXWyNzyPlaTF9ObSOkxr4pJ0Yj67cVGK4ozhf6AVlRODN8M4aEK+7PkOxvWpFdUNCfsPghK6TJHd0kfvZJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507170156
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1NiBTYWx0ZWRfX6fNj1VR9ZFZ1 BYig+8GbHWz4yKPuPSsA3EEaDH0L4pu9UJ/ZUMEgsyVMrCNXn6rTe05C+cqvTWHQH1h/2dzeYTH JNcUntnPIRA1w0FWw0GHxb3si5EL7ScOPuwIZhNknzXRpk4XizLB5j7bFwvDZlKXjejAOJSgBZd
 6DZGVZbNuOzI0nl+IU7zMva3I+GnjYh1LdioDRm/YWxq36e66/Lo79cuiK6NCamFc25xak6XhEp odjZ0Zdq1JBRq7F3aRmLYeRh7wynGggKS2CWTBQdUpnVWrwJ9f++QnXGTCriYjRkGugYRjwbYJR rIQWVJ7IzI37fv1078xTcK5/NM2yiK7TpUB5T6zPGPQzxrTEE0t3QpYVIbbkNHjznlY1pS6sVai
 IgwsIHxSyfJ/0hzJEgnNP75vuBWIRS6RZaMMqlH+OJ3XUJCjTOYL9SvbDxrp6uGG6Jqh/bwM
X-Proofpoint-GUID: CWFrrEAWl_V-wy3vUwZJb6bv6oDazHwD
X-Proofpoint-ORIG-GUID: CWFrrEAWl_V-wy3vUwZJb6bv6oDazHwD
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=6879367a cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=8_4wH5cj2mqUQTNh5RIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

On Thu, Jul 17, 2025 at 11:41:01AM -0400, Zi Yan wrote:
> On 17 Jul 2025, at 10:07, Lorenzo Stoakes wrote:
>
> > On Mon, Jul 14, 2025 at 01:18:22PM -0400, Zi Yan wrote:
> >> remap(), folio_ref_unfreeze(), lru_add_split_folio() are not relevant to
> >> splitting unmapped folio operations. Move them out to the caller so that
> >> __split_unmapped_folio() only handles unmapped folio splits. This makes
> >> __split_unmapped_folio() reusable.
> >
> > Nit but maybe worth mentioning the various renames etc.
>
> You mean release -> new_folio, origin_folio is replaced by folio?
> Sure, I can do that.

Yeah that kind of thing, just basically briefly mention the other stuff you
did.

Thanks!

>
> >
> >>
> >> Convert VM_BUG_ON(mapping) to use VM_WARN_ON_ONCE_FOLIO().
> >>
> >> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >> Acked-by: Balbir Singh <balbirs@nvidia.com>
> >
> > After a lot of staring, 2 difftastic's at once and exactly 0 coverity
> > instances, I've convinced myself this looks right.
> >
> > I think you really should have split this up into smaller patches, as this
> > is moving stuff around and changing stuff all at once with a lot of
> > complexity and moving parts.
> >
> > However not going to make you do that, since you got acks and I don't want
> > to hold this up.
> >
> > I have a few nits + queries below that need addressing however, see below.
>
> Since I need to address these nits, I might just split this up.
> How about:
>
> 1.

Missing some text? :P


> >> @@ -3706,10 +3594,13 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> >>  {
> >>  	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
> >>  	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
> >> +	struct folio *next_folio = folio_next(folio);
> >>  	bool is_anon = folio_test_anon(folio);
> >>  	struct address_space *mapping = NULL;
> >>  	struct anon_vma *anon_vma = NULL;
> >>  	int order = folio_order(folio);
> >> +	struct folio *new_folio, *next;
> >> +	int nr_shmem_dropped = 0;
> >>  	int extra_pins, ret;
> >>  	pgoff_t end;
> >>  	bool is_hzp;
> >
> > There's some VM_BUG_ON_FOLIO()'s in the code:
> >
> > 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> > 	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
> >
> > That should probably be VM_WARN_ON() or VM_WARN_ON_ONCE(), maybe worth
> > changing here too?
>
> Sure. I can convert them in a separate patch. Basically:
>
> if (!folio_test_locked(folio)) {
> 	VM_WARN_ON_ONCE_FOLIO(1, folio);
> 	return -EINVAL;
> }
>
> if (!folio_test_large(folio)) {
> 	VM_WARN_ON_ONCE_FOLIO(1, folio);
> 	return -EINVAL;
> }

Sounds good thanks!

>
> >
> >> @@ -3833,13 +3724,18 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> >>  		 */
> >>  		xas_lock(&xas);
> >>  		xas_reset(&xas);
> >> -		if (xas_load(&xas) != folio)
> >> +		if (xas_load(&xas) != folio) {
> >> +			ret = -EAGAIN;
> >
> > It is beyond words that the original logic manually set ret == -EAGAIN...
> >
> > And this is the only place we 'goto fail'.
> >
> > Yikes this code is a horror show.
> >
> >
> >>  			goto fail;
> >> +		}
> >>  	}
> >>
> >>  	/* Prevent deferred_split_scan() touching ->_refcount */
> >>  	spin_lock(&ds_queue->split_queue_lock);
> >>  	if (folio_ref_freeze(folio, 1 + extra_pins)) {
> >> +		struct address_space *swap_cache = NULL;
> >> +		struct lruvec *lruvec;
> >> +
> >>  		if (folio_order(folio) > 1 &&
> >>  		    !list_empty(&folio->_deferred_list)) {
> >>  			ds_queue->split_queue_len--;
> >> @@ -3873,18 +3769,119 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> >>  			}
> >>  		}
> >>
> >> -		ret = __split_unmapped_folio(folio, new_order,
> >> -				split_at, lock_at, list, end, &xas, mapping,
> >> -				uniform_split);
> >> +		if (folio_test_swapcache(folio)) {
> >> +			if (mapping) {
> >> +				VM_WARN_ON_ONCE_FOLIO(mapping, folio);
> >> +				ret = -EINVAL;
> >> +				goto fail;
> >
> > It's a new code path (in prod we'd just carry on, or in debug we would
> > haven oops'd), but I think valid.
> >
> > I wonder if this is almost over-cautious, as this would require a non-anon
> > folio to be in the swap-cache (since the is_anon path will set mapping
> > NUL).
> >
> > But at the same time, probably worth keeping in at least for now.
>
> Originally, it is a VM_BUG_ON(mapping). I am converting it to a warning.
> I will move it to a separate patch to avoid confusion.

Thanks

>
> >
> >> +			}
> >> +
> >> +			/*
> >> +			 * a swapcache folio can only be uniformly split to
> >> +			 * order-0
> >> +			 */
> >> +			if (!uniform_split || new_order != 0) {
> >> +				ret = -EINVAL;
> >> +				goto fail;
> >> +			}
> >> +
> >> +			swap_cache = swap_address_space(folio->swap);
> >> +			xa_lock(&swap_cache->i_pages);
> >> +		}
> >> +
> >> +		/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
> >> +		lruvec = folio_lruvec_lock(folio);
> >> +
> >> +		ret = __split_unmapped_folio(folio, new_order, split_at, &xas,
> >> +					     mapping, uniform_split);
> >> +
> >> +		/*
> >> +		 * Unfreeze after-split folios and put them back to the right
> >> +		 * list. @folio should be kept frozon until page cache entries
> >> +		 * are updated with all the other after-split folios to prevent
> >> +		 * others seeing stale page cache entries.
> >> +		 */
> >> +		for (new_folio = folio_next(folio); new_folio != next_folio;
> >> +		     new_folio = next) {
> >
> > Hm now we have 'next' and 'next_folio', this is quite confusing.
> >
> > Seems to me new_folio should be end_folio no, like the original? And maybe
> > then rename next to next_folio? As it is kinda inconsistent that it isn't
> > suffixed with _folio anyway.
>
> Sure. Will do. next_folio was coming from __split_unmapped_folio() code,
> I should have renamed it. Thanks for pointing it out.

Thanks, yeah this was existing cofusion and not your fault, but good to
make it easier to understand.

>
> >
> >> +			next = folio_next(new_folio);
> >> +
> >
> > We're no longer doing what would here be new_folio == origin_folio
> > (previously, release == origin_folio).
> >
> > Is this correct? Why do we no longer ned to do this?
> >
> > Is it because __split_unmapped_folio() will somehow take care of this in
> > advance/render this meaningless?
> >
> > This definitely needs to be mentioned in the commit message.
>
> Because “new_folio = folio_next(folio)” in the for loop initialization
> part. The @folio is skipped at the very beginning. I will add a comment
> to highlight this, since the code change is too subtle.

Ahh yes, that is quite subtle, a comment would be helpful, thanks!
>
> >
> >> +			folio_ref_unfreeze(
> >> +				new_folio,
> >> +				1 + ((mapping || swap_cache) ?
> >> +					     folio_nr_pages(new_folio) :
> >> +					     0));
> >
> > Again, be nice to separate this out, but I think in a follow-up not here.
>
> OK.

Well, actually no - you fix this in the next patch :P

>
> >
> >> +
> >> +			lru_add_split_folio(folio, new_folio, lruvec, list);
> >> +
> >> +			/* Some pages can be beyond EOF: drop them from cache */
> >> +			if (new_folio->index >= end) {
> >> +				if (shmem_mapping(mapping))
> >> +					nr_shmem_dropped += folio_nr_pages(new_folio);
> >> +				else if (folio_test_clear_dirty(new_folio))
> >> +					folio_account_cleaned(
> >> +						new_folio,
> >> +						inode_to_wb(mapping->host));
> >> +				__filemap_remove_folio(new_folio, NULL);
> >> +				folio_put_refs(new_folio,
> >> +					       folio_nr_pages(new_folio));
> >> +			} else if (mapping) {
> >> +				__xa_store(&mapping->i_pages, new_folio->index,
> >> +					   new_folio, 0);
> >> +			} else if (swap_cache) {
> >> +				__xa_store(&swap_cache->i_pages,
> >> +					   swap_cache_index(new_folio->swap),
> >> +					   new_folio, 0);
> >> +			}
> >> +		}
> >> +		/*
> >> +		 * Unfreeze @folio only after all page cache entries, which
> >> +		 * used to point to it, have been updated with new folios.
> >> +		 * Otherwise, a parallel folio_try_get() can grab origin_folio
> >> +		 * and its caller can see stale page cache entries.
> >> +		 */
> >> +		folio_ref_unfreeze(folio, 1 +
> >> +			((mapping || swap_cache) ? folio_nr_pages(folio) : 0));
> >
> > This line is horrid, probably one for a future series but this sort of
> > calculation of what the number of refs should be post-freeze should clearly
> > be separated out or at least made abundantly clear in an open-coded
> > implementation.
>
> It is addressed in patch 2. And you already noticed it. :)

Haha yes, always like it when that happens :)

>
> >
> >> +
> >> +		unlock_page_lruvec(lruvec);
> >> +
> >> +		if (swap_cache)
> >> +			xa_unlock(&swap_cache->i_pages);
> >>  	} else {
> >>  		spin_unlock(&ds_queue->split_queue_lock);
> >> -fail:
> >> -		if (mapping)
> >> -			xas_unlock(&xas);
> >> -		local_irq_enable();
> >> -		remap_page(folio, folio_nr_pages(folio), 0);
> >>  		ret = -EAGAIN;
> >>  	}
> >> +fail:
> >> +	if (mapping)
> >> +		xas_unlock(&xas);
> >> +
> >> +	local_irq_enable();
> >> +
> >> +	if (nr_shmem_dropped)
> >> +		shmem_uncharge(mapping->host, nr_shmem_dropped);
> >> +
> >> +	remap_page(folio, 1 << order,
> >> +		   !ret && folio_test_anon(folio) ? RMP_USE_SHARED_ZEROPAGE :
> >> +						    0);
> >
> > I really don't like this !ret but here, this isn't very readable.
> >
> > Something like:
> >
> > 	int flags;
> >
> > 	...
> >
> > 	if (!ret && folio_test_anon(folio))
> > 		flags = RMP_USE_SHARED_ZERO_PAGE;
> > 	remap_page(folio, 1 << order, flags);
> >
> > Would be better.
> >
> > But really this is all screaming out to be separated into parts of
> > course. But that's one for a follow-up series...
>
> Sure. Will add another patch to address this.

Thanks!

>
> >
> >> +
> >> +	/*
> >> +	 * Unlock all after-split folios except the one containing @lock_at
> >> +	 * page. If @folio is not split, it will be kept locked.
> >> +	 */
> >> +	for (new_folio = folio; new_folio != next_folio; new_folio = next) {
> >> +		next = folio_next(new_folio);
> >> +		if (new_folio == page_folio(lock_at))
> >> +			continue;
> >> +
> >> +		folio_unlock(new_folio);
> >> +		/*
> >> +		 * Subpages may be freed if there wasn't any mapping
> >> +		 * like if add_to_swap() is running on a lru page that
> >> +		 * had its mapping zapped. And freeing these pages
> >> +		 * requires taking the lru_lock so we do the put_page
> >> +		 * of the tail pages after the split is complete.
> >> +		 */
> >> +		free_folio_and_swap_cache(new_folio);
> >> +	}
> >>
> >>  out_unlock:
> >>  	if (anon_vma) {
> >> --
> >> 2.47.2
> >>
> >
> > Generally I see why you're not using origin_folio any more since you can
> > just use folio everywhere, but I wonder if this makes things more
> > confusing.
> >
> > On the other hand, this function is already hugely confusing so maybe not a
> > big deal and can be addressed in follow ups...
>
> Since it is causing confusion. I will use origin_folio in the moved code.

Thanks!

>
> I will send V4 to address your comments and add
> “mm/huge_memory: refactor after-split (page) cache code.” in.

Much appreciated :)

>
> Best Regards,
> Yan, Zi

