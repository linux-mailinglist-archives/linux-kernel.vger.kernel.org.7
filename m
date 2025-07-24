Return-Path: <linux-kernel+bounces-744534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D792EB10E20
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C647AE40D4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8901F2E8DE4;
	Thu, 24 Jul 2025 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PNfyXukm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WV7RX1yN"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98A3284B25
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753369005; cv=fail; b=LXlvDYEgBEwqtX19DuHDlNvol2NnMHJsKs240JzWIbGPCgzFBfXme/iHM09S46VWdPsVwBMATpuSbiEwLxz1s9ttue9Y5q2Xp+QYCqDAJeHC7X2VfDuX1m7kXgvc/R13d/lgM8fk5ksaC8gmawHeyw9jGY+9AfQK1zcMdZTBV2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753369005; c=relaxed/simple;
	bh=jvNVCrM8sgQoF2KX6RerZJH9RKx6XzvXy6DPMAAhA8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d8IyJMCqcwsXE8cVENXAMgzuYPkDAo15Fl4mbKckrhEtd/iDkFwLTF5JRPsmc3Q2h6yLQbjK3P4qqYgmffVyDjUC/KHyNKhLBOZsw0Clzdel1li2bPAM2VPIDvLRRmQIeup5WEE06OOM3SLiB59EmF7yLU6HPN0DzpOW5LHrnaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PNfyXukm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WV7RX1yN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ODRHwh025329;
	Thu, 24 Jul 2025 14:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Zxrf/eGS0XvY+yzCCB4tgZ7kbwhDMZ3jTUg2Gy7sQP0=; b=
	PNfyXukm58QeHOjyElgF2G9+AyyN7ngm+aN1ocH+Axjfys9TiQSvd2KRJybUAAXh
	yU8fT8pkLFTOtwQ6Bt4o3rL4ihjEAHDJtQtr5X2DcUXAr/JPe72PpYldgHmYzvz0
	6gXxaMY39TT24g0ajKu3F3PHdC3kJ1QDrlXpS34ZChfzwIr2XbVw/M8TxWbqyLNT
	RVPhel1+a9eExckgdb+LkfH2VVBDpRJMii0VbyLfP1pPQf1Hdn6BpxZYrNfVMhFj
	1HRB+e+C3EEWJTKEaPCaL+dJWTmyv8lgZITG8xgweSfoEUFL5PVNyhljH8H88xtb
	6wQpzCyzQwgL5JMYhAmB5w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805gpste3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 14:56:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56ODWOlS005947;
	Thu, 24 Jul 2025 14:56:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801tbxv2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 14:56:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLqMmUt6UoKH/GXnBZssTwWg6XEcs/dZZfHSGkN9XCbWzuU2vlE75CEA2OM6unqMMyoOqtKI0KJ24B3wlTpVjEwgZUL/CG3vek5J7PkIvZwKksCjdEm30j6uM5115BHMMF+G8cJ93qzn9woSO/93McYzkd8x8KWhAG0dzsn52WmreTGPwVbv2YYBmaJkj5CU5jG6zQnx1ayF+sXgc9GQcTx4Mo31winvo/93sb8HcxB6+ZsrDufOkFxberM8W62KWtv62hCv1KkMzHJZWYXjjMMaK+2oWXOEYLLjpgL3xjVYgHJlr4aBToodZJD/5mRff7eGlqO66HS2w0L92t40hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zxrf/eGS0XvY+yzCCB4tgZ7kbwhDMZ3jTUg2Gy7sQP0=;
 b=uGcEnP3ONoU4Vgfk2qoBX6eI/heZw6omUBaKALN2opqvGOlOLWDLKooBMgwafo7h5YOIjfL6KX14f9UgSSTcux5R5alooEIj4U0pO9eOSmkhHjE4j2KmFwav4t9MQwUsOrL9pMBwdikTunT3lZqaKLaHfJW1izznLMw0lxbSsrTGFl8zj9//FH9ZIEtue8knHwT8dWWbXEFoXG50kFnxdBREBUOrl9Nk9EOJCwFJrrWdX9i/NQvdJHeemQ0nVP/SkhZn1b+r54P05aBjPd2a0N2LJ8uZSewwx1vX46ELtkkF9hyWubxUVjuKgS7Bnc4S4SSpiLae6tt6mu4F/kulEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zxrf/eGS0XvY+yzCCB4tgZ7kbwhDMZ3jTUg2Gy7sQP0=;
 b=WV7RX1yNLRfbTQniEPfos54VwqP81Sqsl7KG4nYKS9x0vT/w7hMAceV/9VKG0IH0xw+OrG7ODMwZPh5o7apwqk2obFpPG4Pl38H1FUpSHau5v8/miz4lk8xvTdCvLO+1SRNiolnJLkvzXWxD7MQ12H2EqzywVTqXiXeiB+ySnNc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB7074.namprd10.prod.outlook.com (2603:10b6:806:34c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 14:56:28 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 14:56:28 +0000
Date: Thu, 24 Jul 2025 15:56:26 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Pedro Falcato <pfalcato@suse.de>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] hard-to-hit mm_struct UAF due to insufficiently careful
 vma_refcount_put() wrt SLAB_TYPESAFE_BY_RCU
Message-ID: <3209575f-433c-47dd-94c8-95ee8e41be7f@lucifer.local>
References: <CAG48ez0-deFbVH=E3jbkWx=X3uVbd8nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com>
 <6df9812c-96a5-41be-8b0e-5fff95ec757c@lucifer.local>
 <CAG48ez1A17JC7Q35jmurY+Co0t_a78bPy9eRWRim7xJy9oLCvA@mail.gmail.com>
 <3a233a85-3a94-422e-87be-591f93acbac7@lucifer.local>
 <CAG48ez36AcGBy8_wo09WEHz98Dp44yKZ_FiVtFt8tcV9WiHafA@mail.gmail.com>
 <b798c84e-f3fd-486d-ad70-c827385a558a@lucifer.local>
 <CAG48ez07dfabOERsOQoh8LWkcYTXo+svQk9X31afmWVGAVg9Tg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez07dfabOERsOQoh8LWkcYTXo+svQk9X31afmWVGAVg9Tg@mail.gmail.com>
X-ClientProxiedBy: LO3P123CA0028.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a86eecc-405a-4941-cbc7-08ddcac244f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVltbUQwZjh3b2JxQmg1UjdZNi96Wi82dFJoY2ZXY210NDByWkpBd3JSZ25Z?=
 =?utf-8?B?THNsbEJHNGQ0aVZ0U3hiR1Z5dDltVlhYOC9BbVBOeEVyMzA3Sm45L3R2OEx6?=
 =?utf-8?B?WlhBQzlvaXBRZG81aG44ajljTW02b0lxL1ErZ0hpd1FrMW43MHVYRi84ZEN2?=
 =?utf-8?B?eG1Ha09PVUU4VDhiVlQ5bWEyekJTaU1JU3VncUQ1QmFOTFZrSW1aRDVvMEY0?=
 =?utf-8?B?TkZhM3Z6Nlk5UFlRcEVvaHpUd3ZzMGp4MUFpQ05STWFjSWZmaFUzeWIzbEZZ?=
 =?utf-8?B?QjFFM3NHa05DanVLeThSdEZib1h2NHNmTlV6TXI3MFdNSlZubnBqZ2NISjcw?=
 =?utf-8?B?NnluaEpoVzhnR2o0YVB6LzE5S2daTEhxUWlpb0M4Z0lwRENYcGVIVExIRk9k?=
 =?utf-8?B?K3o4S1dQUnlkQ1l1NDlBNnQ3SEdlZGg2MHhHNmFOcmVWd1IyNWpkakhNMm0y?=
 =?utf-8?B?RjR0VzYraytTUFVUL3h4OGZyejQvUHNlVURUYWR4MEZNeDdScEZnWTBPdWRw?=
 =?utf-8?B?cURydkczRjRoYkJJTzIvb2VGaDZ4SzZFNjFHM3dPb2FYbk9BRnRXVEF0VmN0?=
 =?utf-8?B?akd2eTZneTM1OU5SQThCb1FlTnBiTHYzc1kzODZMT0VjYzJiUmZXNTJuZjJC?=
 =?utf-8?B?eWwrQm55dkR2bWtaYTZYcVRzalVDSU05V25rYzVSaCtUMEVUb2tNNGlGOEtL?=
 =?utf-8?B?UW5PekFBZCt4OWkyeUtscDVtUE83alBSODVoaGJ3KytHNk8vallvc3QyQ3li?=
 =?utf-8?B?Z25POG55WUlGcFU3MHBVcmhJMlAvNDVIRERCNzJKeCtKNEhvOWJ1azV6VzRa?=
 =?utf-8?B?VHpzanNlTUM2MGpkMy9zdzE0N01vU1dKUVBudWVFZm8wU2tReFEzWlZlSVJv?=
 =?utf-8?B?Vys3UEFXTEF3UU9aTjVBanVBZmxBTFBPeU9BRFNGSjZGTzFLekowUEx1MHdL?=
 =?utf-8?B?KzU4ZldrNHRLSFUvRVRLc2Q3R3R2M2xja29jZnZ3S1ByWTF0dlVPWHNyVTZW?=
 =?utf-8?B?MmZKanU3SDNxTTh3M20wSEpPcURGRjFvMlJUa0prbWpBMHQrZWpJMi9aaDdB?=
 =?utf-8?B?WGxhZWQ0Uy9RY1c2cHJJaWpJVHkyWmUremt0QjR6M1FMS0daWVJQeDZ1WlZ0?=
 =?utf-8?B?eFVBWjM0dzRZVzcxSXVtcUdPb0JiaTJqOGVjTmFTSzVJZENBUFFhaWo1SU5i?=
 =?utf-8?B?WDVXNHRtT1BCMERUa1RMQVhoUUJlZ2JGbkVhdHhIWFUrVTNqSmQvaVlZd3la?=
 =?utf-8?B?cHpNQTJoZlZ3REp1OE1NQ2NHWlZqdEhPUmhsQUhidGRTL0poclRvdEhBS3JU?=
 =?utf-8?B?a3d6dTBSZ1R2VHZpVXE1Y2lmR0FCa084N2x1ajJmSnJ5VG1yNVVFbHdBbVht?=
 =?utf-8?B?U1I4QnMwV21HeU9YUlZLNFN5S25RSVBBSzF3U0lmUzl3NXRqb1d0S2RCNmlX?=
 =?utf-8?B?dncrUHo1UWhFaFlicDZEalBuRXVxMGg1ODY1Z1o0eWhmNW9icEhMQVBjVXlY?=
 =?utf-8?B?V3d1aFFYd0NScERkalRuY05yMEZlL0ZYSE5oSi9Qc0dPYUhqNC90Y0NkY3Nz?=
 =?utf-8?B?MkQ5d1VFODB1UStCbm5wSnF0V2s5REU4dUI2U1JPL2pUTmZMS2l4REo3L256?=
 =?utf-8?B?eHZuWklIa0JMQ09Uay9xaXNPVEJjZlBaSEtMbFE1OEJ4dXV5WmVURWpGNVJ1?=
 =?utf-8?B?czFRR2pETHdjQUdLd0FTdTIzcjFmbERybm9MS0dMdFRNaVhkbXV3SURGK0c2?=
 =?utf-8?B?N2ZhT3UwV2RNdWI2eTZqVmxBZTBUcDNheVh4cHM2ZTZKYjlwS1RoSm5NVklM?=
 =?utf-8?B?dmExVjkvQTUrRFlPQ3dzNGp4UU1tTEJtMDh3dGJSTTA1bStxZG5xdmU3Vlhj?=
 =?utf-8?B?TlVHcnJpTTdNRDE5S1RibVpCMkorSFNIWHQ4ZTE2aWlRYVpWVHhobFdvZjZt?=
 =?utf-8?Q?Ab2ICgHQbNs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cW5CdVZDUERmWXh2UVVFS0xoK1MzdFV4YmgvR0pwVnZsNENxOUhpdFV6Y3VB?=
 =?utf-8?B?VFR2djdYbTJGZGZkbVVlQTVlbzJWQWREa25sV0RvS2lTYmp5RDBmRkpjMVAr?=
 =?utf-8?B?aEhacnVkeEJFWmNncGpzelMrZnpmQ21aK0xxTG5PdWxZY254SE9BaFJNejht?=
 =?utf-8?B?b3dwMFFmVnBjVXE0VGZ1dzVjbnRoMVlzOGxZbHFNN0F6cnVPSHJsWkt4RFJ5?=
 =?utf-8?B?MDdaQ3dhSTVuZnlHamxTMFN3dlRWTCtsc0wzU2loS29tUFVPa3J6MllLUC9L?=
 =?utf-8?B?WTFGVkVRQ3E4dktRWEpFbzkwa0hhNWR4cXhEZU5jUjdWOUhvQzFsQVFPN09U?=
 =?utf-8?B?Q0hHQTR4QnRQbkh5L1Uxd3NBYldhWjh0S01tdHZWcWYrWjVPd0tQdmxFblZY?=
 =?utf-8?B?UkNubVhic1o2K1F1QnJoaUViZDYrc0JpZUM4ZFdJL0E2UENYQjlkUktMcjY3?=
 =?utf-8?B?amQzMFdsdDJNWWNhZHZkQTVFYkdIUFZZS2VlZXBMMVVVcEViMEtRb3NaVXVW?=
 =?utf-8?B?RTVVc1N4M09jemNyWTE0UnJzOUJOb3l6TnBkYXl3aC9tUWE3NVR6eU10clMw?=
 =?utf-8?B?QmdjbHk1eG04ZEVoYnpmSXNaV3BnN3VWNU1qdlI0Nk9DRGxTamErQlZ3aTBJ?=
 =?utf-8?B?ZlpNVHErbk1ZZmhLREtwOGkrV25EeUJmU0Q0R2VNZXZyMlYvNTZad0ZlSEti?=
 =?utf-8?B?Mzc5d1lNZUZ2Nm1uZDNUdEJ3V1RYRC9FQ3VRWDJ2dVBJSzFaK2FGWjhRY1g2?=
 =?utf-8?B?TUtHSWJIUGFGRG9IQTdMTlF5enVPWlpPeFlDNGUyeEhHNGFoZkVaME9oa3Va?=
 =?utf-8?B?dEUrdlQ3OW9UV0x0YzVmL0NYcFkxU09nb2hOcVJtRkl1NGk4Smg4M3RhanNV?=
 =?utf-8?B?enRIOFVIdGovQUE0aExvVjlYVzhLWnIxa3gzYmRFUVdha0hhVXRmcktVMVJX?=
 =?utf-8?B?WjVEWWl3NXlvRjVyMXRJejNlVERtR0hTVGsreDN6aTlrYVZuVVJsc3BUMG5m?=
 =?utf-8?B?L2VESldZaVJpbjZENkJqNmNKRmxGaXh4VjlSTlhVOWZ1UmV2cGVLdWp6T2hC?=
 =?utf-8?B?U2MvN09tLzhWL0pNdTNmUUt4NEUxQ3A3bDgrM0xENElERytyZ2xhd2YzYmJv?=
 =?utf-8?B?OGVjZHhGZkN6VC9qOGFkdk1nYWZTNHV5dlpRdDJKWWZSQUlSZ053K05veEdD?=
 =?utf-8?B?OUMvT1M2b2Zka1Bja2RzcjE5dE9aWVd0L2pXOSt0aWFKQTFzc0VIZHNueE5V?=
 =?utf-8?B?YzJqQ0Vldi83VGVmOXZiaHVFTURPWU1HbTh4WFZJaWtiYkNZemluN2VDVU9H?=
 =?utf-8?B?ZWhGTWVPY0ltS29tVlZhQ2gxczNzbnlUajg0TkpLME1LTkNhd1g3eGk3dytl?=
 =?utf-8?B?a2VmVStKeFZzVnF5ZXZWUGRjNjBQVXYwc1BEclBVVkdFQUN2cU8wdU1ydTJI?=
 =?utf-8?B?dER6c29UaUlIMnRiRitBam9tUmNoRCs1N1RqSC9KUnJhY1ZNR0E3RlUxWmhJ?=
 =?utf-8?B?NWpzOWJRSWVHQlRiaHNyQjVzT29oZW1kY0NwdjJHdGk4SW5WeU9sSGpWZ3o0?=
 =?utf-8?B?ajgxODg3UUJxOVF2bHNiRjN2QUUyV2pHRHNodndzUWhSN25WeUhOamxnMGN1?=
 =?utf-8?B?RmZhOVV3ci9oQUxkTTRqMHlPclRVTnd3VDBrNVJWa0dKbW90cXhHQ3lBcHRK?=
 =?utf-8?B?NUJqQlNuNTNSdmdzMmJKMzk0T2l4V3Mzb1RzWk1FUEI0cHNkNHp6cjZRbzY4?=
 =?utf-8?B?Qlp1NmRzWk1SYjFWSytEc3pGclZFOE9VQ2x0WC9zRHluTzZwQXR4cERVbzNx?=
 =?utf-8?B?ekFMYTNyaTJobzV3Wno4ZEZxYm5JVExicUJuVnBhQ1NmVStnbUx2UWVIZ1BF?=
 =?utf-8?B?Nm0rN3lwakhhT3l4b05xd2x2bDB2WTJXendxZkNQanp0UFNCL3ZXZm5jcHhM?=
 =?utf-8?B?S1FQQUdTcUxxMlQvYVluQWZ3Vm5BTGFDZ1g0ZGxjYXZGWGtqQUp5N2lWakJO?=
 =?utf-8?B?dmh3YmV1MnhnY3hqQkpJR01MbkFST2txTWc0SVBTVC9xQVZ2bC9KWDlnNEtK?=
 =?utf-8?B?M2hja1VxZS9ZUlp5WDY5Nm1Pc0Q5RWpFOFN3TzdoNTlpdm1FWTVBelVjdGpx?=
 =?utf-8?B?TTNkTGxOM212WE1vaGpuMjlvM0t0MlRRVTZ5cUhFL1lXSXZjZ3pMM2FIc3Nj?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mP2pPXhxFpdXd74xYYTU41R4Jt7nfAn4aZHD7ERjm2MBkP86HSPftvrNcNbdk/aA0Lg+7qqYPH4yMTo/ncly5V+M78Pp7OQhXlHSvabM2d2jG9dCbLBRF338zIxC9g9PJ/wu2A7bkkwNKILl4ocv2Ub7RVuIRE6xmnsJg+JG3gAb7t6UdpGWhpSQGnNRrPNuNCM99/nvKP0T2B0K+3/BjCW7SaDE9qBh7WPzJJDiE+XKLdbU7q8cCywoR7IxpYF8pU66/oZ8uA8qXLNxSzEtH4ad9lXhc/bh+eQUyOMkCqQmegTEmepmuNickOmWlG/j7aIBs0onfzNsCHIZD32RgMHYxXxST6d9kO0Gw98wlQgCHHPjbR1ph6zK9TPfIPVhzCyy10M4nYa/QSrxX/azhUPog6t5Lk68pKDU6YknNj/47ijzIUNuwa0PBDmfU7Y9d7J8jiM7D4FVdJ04nIaGEgmbFh9GpHlfqyIGXcFiGQMzklqgG987hTWa6o1BQ2isiVOIUXe6tU9Y1p5zrcME1QxCEQ0r+DScQA1386zj9NFc2oOb48nAxUfTTd2thdu1oJZrmzcr2WEirCaghsHEhH0zmw7Uow/xuOe5DQyRLhQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a86eecc-405a-4941-cbc7-08ddcac244f8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 14:56:28.6713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lo4LJvaJWfMrabZBLQjsj22dbs0fHo+yGUZAxxsyUr+dVTQVDZX7K7kiav07aX0NAfBYLEHwkkktlfnjbX1XBOZpAbyims/xDNRyhjwEXoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7074
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507240113
X-Authority-Analysis: v=2.4 cv=TfGWtQQh c=1 sm=1 tr=0 ts=6882499f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=nSEaKs5HCrgWq3QKgTYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: H9fLYOxxLPk4X-jP5DAOD7PXcMwfrfaT
X-Proofpoint-ORIG-GUID: H9fLYOxxLPk4X-jP5DAOD7PXcMwfrfaT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDExNCBTYWx0ZWRfX3L9BI9qo8fFM
 VM1eln/5oalQ3BjveIR9AJw7e+BxNWBws0CVfHNMprKkuzpgUVRNlhys2/s1BbM+FRhIibnLPa4
 BSBkgLqfu6pj0FnOYyAyumSXnUn+AVi6cFxfwxdPVkElCi6txvhnCR5h1hh5JKlWJAnqPPoDzxd
 9v5yKkniLOmTGQK4GdIXXkUCJpEjvk0T1DIwjAUR6qnMI2+hxS5OEg+4qsRq/8HUfqa/CPq1FP3
 KzAlDIIxMZoi4g92TTZvkqCQa9Gcte264S3I/qYpmI2QCjd+yZpgrZDzOV7y7KmXJQwd/Lzair/
 PMaonRtmr99ndFbOSEhWrE2uL7sFcoeWvYiekHAYu/nJnmC7hIVENXt7YRwbOvPa2pNo601ppl7
 UHjhntf94sIPAPp+xs8hIxABwOpJP1tNt58a73JlyQzp6otIVTbA0XMNAw3NHHf6If5OK6TP

On Thu, Jul 24, 2025 at 04:50:49PM +0200, Jann Horn wrote:
> On Thu, Jul 24, 2025 at 7:13 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > On Wed, Jul 23, 2025 at 09:43:35PM +0200, Jann Horn wrote:
> > > Sorry, while typing up this mail I realized I didn't have this stuff
> > > particularly straight in my head myself when writing my previous mails
> > > about this...
> > >
> > > On Wed, Jul 23, 2025 at 8:45 PM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > > On Wed, Jul 23, 2025 at 08:30:30PM +0200, Jann Horn wrote:
> > > > > On Wed, Jul 23, 2025 at 8:14 PM Lorenzo Stoakes
> > > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > > On Wed, Jul 23, 2025 at 06:26:53PM +0200, Jann Horn wrote:
> > > > > > > There's a racy UAF in `vma_refcount_put()` when called on the
> > > > > > > `lock_vma_under_rcu()` path because `SLAB_TYPESAFE_BY_RCU` is used
> > > > > > > without sufficient protection against concurrent object reuse:
> > > > > > >
> > > > > > > lock_vma_under_rcu() looks up a VMA locklessly with mas_walk() under
> > > > > > > rcu_read_lock(). At that point, the VMA may be concurrently freed, and
> > > > > > > it can be recycled by another process. vma_start_read() then
> > > > > > > increments the vma->vm_refcnt (if it is in an acceptable range), and
> > > > > > > if this succeeds, vma_start_read() can return a reycled VMA. (As a
> > > > > > > sidenote, this goes against what the surrounding comments above
> > > > > > > vma_start_read() and in lock_vma_under_rcu() say - it would probably
> > > > > > > be cleaner to perform the vma->vm_mm check inside vma_start_read().)
> > > > > > >
> > > > > > > In this scenario where the VMA has been recycled, lock_vma_under_rcu()
> > > > > > > will then detect the mismatching ->vm_mm pointer and drop the VMA
> > > > > > > through vma_end_read(), which calls vma_refcount_put().
> > > > > >
> > > > > > So in _correctly_ identifying the recycling, we then hit a problem. Fun!
> > > > > >
> > > > > > > vma_refcount_put() does this:
> > > > > > >
> > > > > > > ```
> > > > > > > static inline void vma_refcount_put(struct vm_area_struct *vma)
> > > > > > > {
> > > > > > >         /* Use a copy of vm_mm in case vma is freed after we drop vm_refcnt */
> > > > > > >         struct mm_struct *mm = vma->vm_mm;
> > > > > >
> > > > > > Are we at a point where we _should_ be looking at a VMA with vma->vm_mm ==
> > > > > > current->mm here?
> > > > >
> > > > > Well, you _hope_ to be looking at a VMA with vma->vm_mm==current->mm,
> > > > > but if you lose a race it is intentional that you can end up with
> > > > > another MM's VMA here.
> >
> > Right I get the SLAB_TYPESAFE_BY_RCU thing, what I'm saying overall is 'can we
> > detect that we lost the race by knowing what mm this should be'...
> >
> > >
> > > (I forgot: The mm passed to lock_vma_under_rcu() is potentially
> > > different from current->mm if we're coming from uffd_mfill_lock(),
> > > which would be intentional and desired, but that's not relevant here.
> > > Sorry for making things more confusing.)
> >
> > ...and because of this, no we can't. I hate how uffd is implemented.
>
> I mean, we are in a context where we're looking up a VMA under a
> specific MM, we know which MM the VMA should be from. And we have a
> bailout that checks for this. It's just that by the time we can check
> if the MM matches the expected one, we've already grabbed the VMA.

OK.

>
> > > > Right so, we have:
> > > >
> > > > 'mm we meant to get' (which apparently can't be assumed to be current->mm)
> > > > 'mm we actually got' (which may or may not be freed at any time)
> > > >
> > > > The _meant to get_ one might have eternal waiters. Or might not even need
> > > > to be woken up.
> > > >
> > > > I don't see why keeping the 'actually got' one around really helps us? Am I
> > > > missing something?
> > >
> > > We basically have taken a read lock on a VMA that is part of the
> > > "actually got" MM, and so we may have caused writers from that MM to
> > > block and sleep, and since we did that we have to wake them back up
> > > and say "sorry, locked the wrong object, please continue".
> >
> > OK I think this is the crux of it then, and what I've been missing here -
> > we have taken a read lock _by mistake_ in effect on the recycled mm, which
> > may end up to be a spurious one that we need to immediately drop, but
> > because of this we might have waiters that could wait forever.
> >
> > OK I get it. But to safely reference the mm here we need to be assured it
> > stays around because in case of this not being true, we have nothing to
> > prevent that mm going away right?
>
> Yes - as Suren explained, as long as we hold a reference to the VMA,
> the MM also stays around, but to access the MM after dropping the VMA
> we need to somehow grab a reference on the MM first.

OK.

