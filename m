Return-Path: <linux-kernel+bounces-852818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF155BD9FE2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2033F54428D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B521D27AC57;
	Tue, 14 Oct 2025 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VHVtKWNR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cizzI72x"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FAD27FD54
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452047; cv=fail; b=XJsN60V9uHlMYbiGThEKZxTnGIN6NCdsbSgQ00qXaa63KAKhlIvCPbd0Pkarz9ye7/AdcZ+NCV7pda3i3mdIu7I2FpqsA+O0zB2jqYn0MJKmFMfZHoSW5gMD4z1v0usPj7P9hmYtN1Lbn3jk13YlOHFS+S/xRV+bSayE4RCB/FY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452047; c=relaxed/simple;
	bh=8nDJR+yxqqLwWzffnoz/b8lZY6NSMsM5A56lmFUOU+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QCwpZOugLHDbvWOomHeu++tY7qz5DYG2K+vRZz47FkduVwH0VPgu5lI3cOpYvy5d7UtVSuJiK6/R+4sUtLcOzgKPujASEdrQXHudk3Ti7VAwm1Zic8/opQrzhE/arhudV5I1kfTH24xl1h4sG3vupZwt16vYqk2jrbDxiE+GNTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VHVtKWNR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cizzI72x; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59ECuA3m002213;
	Tue, 14 Oct 2025 14:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=fKky16XPL4sT3pr9QT
	ELSoNDe4I3/acp3sigSIjLqiY=; b=VHVtKWNRdUHoXtiwPo/oV6Jmc6BnrIulPb
	wqZU/m5Y3DBTULTmxNTmrVg3JaHeO3DSfikGFHxuQD6ellmB5kYt5qBA9Y3vPlkF
	6je74DIRf5ZdmjUe/rV/3boDv6q5yQ5uSIDGi60AFW+85gph/GxXRxvFzvFte9Se
	TdD0JL3vMkgZD57kJYX3BA7OHU+NnW8T1b9p/5YV4P0oZqVidhiNB+amG1zP8IE+
	i1UOJNgCR2Rk21uOe9pK6d/aPmiJ6HFSOXrLFuDtZIHpXyhxOdgeSMS1px1RLQD7
	C7W1aQ/BhNKMaK6E0v7NDhIEeept/O9o/MukY+RQmeMjAcK/+mGw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qeusve8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 14:21:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59EE9Cb1026225;
	Tue, 14 Oct 2025 14:21:41 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010019.outbound.protection.outlook.com [40.93.198.19])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp8rd9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 14:21:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8OOr5gISBLz/zxokDkY72zj3JDRIQv/rljh61PuWzXPwcD6hUcBNRleCKUXWcmmguVvudopUZwFgFPscujbJlFFeYFx3LK+DlFfKk3pjy6DGQN1mFgA/CDTMQd3w8UTujsZJeLUdlhaEnA1/Mz/joNXPks/wCFKxjOvkMIxG02Ied/wxkfgdbR5XJGLXtCg5JKd6ro+vW3ohx0V03sIJ1NTz9/EnQB3dtucp0fOQxTvskd1MLTmbYNhG4Ex2s/gwt2rjohYlI9E6D7euAwNZU876SePXJy6rztlzC+KSk46TqfXFg/z2+XNnLltFmS6wRk71LhA27sFWbPGDS+B8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKky16XPL4sT3pr9QTELSoNDe4I3/acp3sigSIjLqiY=;
 b=Plam/bb/gikpJ/EHtVx1ZzvqnSVMaNEdCWARoNG5xfne++PfQuwH6I4q5yAwv73fBWeYuJk/q/0KjkMPARtMiJmQ2nankeWFpHdr+odydpSmxSJTbWq3OiY5vRyBPXqcPtR2A0N5idUyYETRxtAWdShkDlNXhXfLD2jIgVxgd0GztErutWQ22ht4akPWQk5xOLj5xDuqyqLafdTb73wp6UDz6yWCWjiZq9IF1aA/crv7f4a1CcmeSf6fIlvB2QdXUszALLC7t/C490xxIv+50mysNO9REEnlJQLjPAZO2vfihZWonOcKyQc0Tm2cRyJm0YgKluZPWgIihm/1YSTDFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKky16XPL4sT3pr9QTELSoNDe4I3/acp3sigSIjLqiY=;
 b=cizzI72xhF1DVPgE56XA+WygT/AljeSubzmORTf6nA+FliRc/hDSOGRivzdfJwFseKL7uacPtYTgcEeA7mLwRtAQhVQfXRe784WrwUPzzlNwcxLh6Wot54G5EgzF+dFnZIrrWkqMJqSwnAvIWpCA8sHrcBh7SDTBtgC2MolWs6E=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPF969223381.namprd10.prod.outlook.com (2603:10b6:f:fc00::d35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Tue, 14 Oct
 2025 14:21:37 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 14:21:37 +0000
Date: Tue, 14 Oct 2025 15:21:33 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Huang Ying <ying.huang@linux.alibaba.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yang Shi <yang@os.amperecomputing.com>,
        "Christoph Lameter (Ampere)" <cl@gentwo.org>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Yin Fengwei <fengwei_yin@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH -v2 1/2] mm: add spurious fault fixing support for huge
 pmd
Message-ID: <4c453dcc-2837-4f1a-905b-3462270f5e31@lucifer.local>
References: <20251013092038.6963-1-ying.huang@linux.alibaba.com>
 <20251013092038.6963-2-ying.huang@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013092038.6963-2-ying.huang@linux.alibaba.com>
X-ClientProxiedBy: LO4P265CA0130.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPF969223381:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b9941d-1f49-4056-8293-08de0b2cfc2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u3qMKcQFM9TjHFbu06OF85VJhwRCAuSCrky5nj1xNzVZks6HoVIiLQ7Y1+UV?=
 =?us-ascii?Q?BGCm5HUNfjD9tLausdyMc41ThxmD3cNlu6+oD/1GsfFHbHhCJ2D+Z5AA1hhr?=
 =?us-ascii?Q?SO7CekoMuFgRp1SV6HA8JiJi+2tcSaVrBB41SGQOtUTvsjZNBrgxfW3pa8Rp?=
 =?us-ascii?Q?glw845Rlkq9kJh01OFbzE75tXpcl0b+PYp5k35Txi2dlBCOdD0DE25D64a1Q?=
 =?us-ascii?Q?uEn/m4+PelrX4HA1kbrFH/z7crvmMR4NId3NsHpQrCfsdJVkXiOWacXzi/Lm?=
 =?us-ascii?Q?QajjX6XiZD7JwEaBcNuZ7PWAf488UvZZmSRa7KEgO1Lunf919dtb9gtt1tii?=
 =?us-ascii?Q?Yfofb536NWcfTaUecgr1BF0z+gaZ2xwe7k8W2GkXDs2xJboWItD/rasnD68/?=
 =?us-ascii?Q?EsJEQykvOPpmoE0rNHaxL3lxaubCmeyEAJB6NstJVPdvtaKy2vmd7h1UvdqM?=
 =?us-ascii?Q?3xpQcyUzkjNVkdC24bhKkLPzSk2gKPH/U3e0DHyRpXprxM4DSdy3D0EeOKbb?=
 =?us-ascii?Q?s/qYca5sqgyuIDARANg1N7gThaAuazlHz9kW0B3HHNHYrYFhf7PVhxaV2ITs?=
 =?us-ascii?Q?ZjWEnmS0Cq6b4SnF56FsUm555WeTY/LpD5ler3gNurGmnxIY4ONmxldNWm1t?=
 =?us-ascii?Q?2MlJuaNaFwUc552DS8CKTolHjpRc7YdEEVBo1mvQnFmAjr9Hp+3GPDdVwbsP?=
 =?us-ascii?Q?URoT5c7d1i5BjawH2XD/HMXeUxakdzJTMjk5IqBa2gxQWvAP6xDi9cB/CHbA?=
 =?us-ascii?Q?c2FfKcrzIYZCI0/bnAQMqw8fCLeYb2Q6yDpDPeZXkT6N0UIrs11Yobfc18+r?=
 =?us-ascii?Q?47kvWuswfcFXd8XEg5HP03Xg68XrJT6A8JtKMuJVcJm+JUHgvBeWbskTcyJo?=
 =?us-ascii?Q?IW/3T/XlBCA1v3btpy3SpfUS+FSFO9xklI9CrCbHUeUW23yRNMu4K1uNxNWg?=
 =?us-ascii?Q?5XD0mUgUPIIQ4XQ/F6u2XKfd+18moh1yRxkcVIQefu2QyLzuSinq2olGBlAW?=
 =?us-ascii?Q?gPsDestS+wuvRqJ7ddTkf7iETASnyb6y7TtZD68xXRn//rOmEVQkXp1fW7MP?=
 =?us-ascii?Q?h0Zz9qgjK/sbV5lcWGapHQeYsgzfHYB3d3qU2bkFtekvwCXyQwK/QxYFfnfK?=
 =?us-ascii?Q?eyDJFxoY6B7+ouWnxemUToKVKczsPSQxfpXRcRacSdr6HtP5HiaWE4oVFNLO?=
 =?us-ascii?Q?VQ98GXPFUnFvGMNPksQMIyAxY5OGoiZqcGMoEpl6AqNlN/Smz12KMRm9bIGv?=
 =?us-ascii?Q?7KiuzaxU1eH9MaktpRv+UDIKUqRMMDvpBcIHykcd46mCwCLdcQqh+GAVf9bH?=
 =?us-ascii?Q?K3ITP7wMVsArCMfujJ3jIXG8DSE/6NB0IhgD+kFqBAi6Ot8dP2R4SzUiwQWb?=
 =?us-ascii?Q?TOAtZqvK0eG35AQCBw9RWQC77NDFbGEUWgKG7urjxyONVWmmR2RxcQiIS4wn?=
 =?us-ascii?Q?SxtIKpgVEk50xM8uOX/QgnzcehGwWtm/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5GpcVp04QIqlZS7/73obw5b+O8Ov6S7CndBmLGie1gLkMntMolU4cgATPW2P?=
 =?us-ascii?Q?y3fbuWxhoJN9qtTFqRb5D6S9W87kokGPq+AvmgRGsCJbdnFnyEQM5SizHEVi?=
 =?us-ascii?Q?qgmjAlpJEKkd9GSpHWWd+nf+s5NzMZLim2H95RvoeHyeghfxy9MIgqJ/FcL/?=
 =?us-ascii?Q?uElu69kB4YO+6qpEhDjwgHhQlR742eKlKDDncV8QoZfFfcqBkEh0DgmN6Nka?=
 =?us-ascii?Q?ljOPCR8TegS44Zb8DTiORsf2MI0dvnUVxSAPjqhV+y4Cgl5wGlt1Ypmh3jZ2?=
 =?us-ascii?Q?PjdKixG+uhxxWjjEFVeYcvObprr82ij6TkqYc3EGAuHlrIC2a/2X9yRZdBfv?=
 =?us-ascii?Q?BkpnDlTyZpbs7Ahkuj2JSCE5l3dG6MxcpZ2dZlv5OhAhkyF8oyxPMr5Aj3mr?=
 =?us-ascii?Q?I39094s+F+gZH4wjZvaDbTlJAAkuQ0G8F5iHpP2qLXt3WAySDF5Ztd7IkzDM?=
 =?us-ascii?Q?tvhI6RdUNhW81xwKBtENxKEMPMKyEjDjKzw5vqK6l40mUUjqZRR359GBYpYk?=
 =?us-ascii?Q?Zxn/IIKj40Tj3aTUl/yERXGFM5bTEafkSt65o4d+RU8EmAuUusVOoJXeQZrl?=
 =?us-ascii?Q?LM2nNigJtUuJKLKan5oSr29oFqAUYqmbRF5gt1cf4mc2dfZF5YY4+TPO4M5b?=
 =?us-ascii?Q?u7nwlmK7xu5T1ZZbv0kXOmBrVeNMwyXrKQZOabnBBDzCgP9SOHxIOOpvFjf4?=
 =?us-ascii?Q?JJ0/C7CWzchXN8CpfkvWCGlj9xLe6bqRfS2wryoVeyWwOQctjNMppM1QHjKr?=
 =?us-ascii?Q?dmgSRPJ1KZ7xOFsn1GZUJDZNLflLZGO29m4XbVimG8zDf45uKc7lu3B6GWCZ?=
 =?us-ascii?Q?4o+Fz4NlSy8a07y22o0CVYMw9bss42xPribmTZhZa+UlWqwKaFznLxlqVd6X?=
 =?us-ascii?Q?jBmQtdQ0VDgYAXHIktk0pmAAQUCylaU9kZqj7T2RjUXx7eZjFVpdMEqqpWlk?=
 =?us-ascii?Q?O3JDVFgx8sqh/jVHwRFOILHIfImwXbY5LpJo0lf7OmOWSMIQpr4VYOyOAaJg?=
 =?us-ascii?Q?EWJZFeaY2MRF67PcV1HK4i/McDdvO7tCl26uCL9uLw0uvphl1VEI/+a935OL?=
 =?us-ascii?Q?xJOn5i35N3172T3vcZ3jwgsDZ8ZoUH3sC5S1KfQY9arWpYfSiGWNtxgND1BS?=
 =?us-ascii?Q?eWQcMJI+j/z6a9tTryVx3jHeFvTPoTS7JY9yj4UlDouVtdCCQWVYXEcm+7xd?=
 =?us-ascii?Q?FyOnCsEH36r3a/7mKILjJFyrOcAL0VH1DLW2RCXUbi6RWzUpWWvT5xb5MwnM?=
 =?us-ascii?Q?XdCZ1ZeLXrbeqR+21iH9KFADcKrGowV0ZpZ+kW5HnTsXXOU27EiVgAmtlvPJ?=
 =?us-ascii?Q?EJXWH0I5fdkta76b1Rfme4HvzywkXeOgGbTWRwmcNDZKN+95yL0K+GPEsuvg?=
 =?us-ascii?Q?E7boHjgaEmYsVvFsPq2JO9W2nU7ENyPah9/gYDCwae9f6AO99V11NdxYcTtG?=
 =?us-ascii?Q?X1eSyzyQxZjTmE6dwBb2cdVP7BEnMY4paGImIcjBKNVB7yEbMq5sCHgndn7A?=
 =?us-ascii?Q?Y68ekHzzI0fI0GlzNeHaIANloMjOur2zp5HtOLjYeKV891D1/5JBbUopQl8x?=
 =?us-ascii?Q?XaNmmPn/JYbDWbusK94z7R310FCdhfNRZ2nNb09yU8enLCaTrmBlFwSCsFhv?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JJJv5uflBAediu7dEVSw+bjtwlyIYTxvutlry/nYhcO5ab1wggEJogG/xBoLwUpi26WBqWD4MZ9RFKfD/em6LI5c6uB8KWAvSEy42DmpgkGBL+oM6ebO+O4ucu23xRzFoNulIWi4MddAIYA+vti0kAdTWHwTH4CPPtJd18sJ1quwl5dXs0EmdiDLsO+OY6cCY88R6hpAF3hMSOF8WwwsddCPnHBkzONuDra6TdJZpD+WSII34gz3DV65+xy7BbGSLaLRs9Jhukdh7ZTEJrRST5YbGNhtFOvp+Dy/9FRCG1q9++g+1OFm0srHWLiRJhOx86ask/7Jz96TFbc+4e5+o3FbocCP0niwdQfJPpgQYui22EVeYduWFgBfaSn9+VFxsuXc85qoFtNh9+HUMeUGsEMLgKB53g8Xc1ea1VV+FiGmzZQgO06jUTrIC0RaoAD5f6kmz3Yuy1QxDcqvfEj64WXtNM9tBgu/UPLSXrDTevGgXUdu+F2jjMtAvX0FDQKbHo5KJQ4CUV41F+3YykCZOvRTwlhPSllSd6FzCxPuSzKfs35m3naEdI8k65bdfrSwuA5tvVrmmdYogEnnhNnoIz4G5hBR9qpGr3v4MspvSAo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b9941d-1f49-4056-8293-08de0b2cfc2a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 14:21:37.0958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Etx2symg9scljm/TJ4dVcssDSiHuaqF2Eeq7LfORSR66CnosO2uD7MLZtLosPI+je5hY+aHs8qQc2cXBSQ1g3derLZ36hgf0A44CViV2No0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF969223381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510140109
X-Proofpoint-ORIG-GUID: ZijUrSvx28hWPpxaLxuzc_0-LmHFPzNe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfXzOWZcDfqT2mI
 M5tNxJE9QNZ+9t2rFSvJ73oMU2jc9yXejkk+eQEgO03c8sNNYcnzQxbGOwvS6BOCeHzCXYujZDO
 R3a1TZ5MqsEupValX6dQW/1gJ+Y4Xzu31OO5lnzBtuMu2apiZU08Ds78YpsF93XBB+3zJvn9trh
 q0iKUoex7tdDZSeOqV18brnSj752np/9tOy1gNuVn+2DQgzFxo4H0NGuep5bAO2YvopB+oqDAE0
 RrFi/7XawuRygN7XAJZo8W250KLsFNQSt0184sXA6pS1a+VJTdu+6619K2OXO5s3hWdM1oMetzw
 5TDvUpfTv5zfcM61iJX5dCRI+9sAly9DaQhOAgbMwNO1wfNP1+uO8SFxGHw8m/8bn0Pb2+Xi/vV
 /Yor/b94+qW2pUfvKzMw0F7iFtGJe4PVD/h7zOztGGKo8Nbase0=
X-Authority-Analysis: v=2.4 cv=E7TAZKdl c=1 sm=1 tr=0 ts=68ee5c76 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=SRrdq9N9AAAA:8 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8
 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8 a=vzhER2c_AAAA:8
 a=PuvxfXWCAAAA:8 a=BTeA3XvPAAAA:8 a=i0EeH86SAAAA:8 a=JfrnYn6hAAAA:8
 a=37rDS-QxAAAA:8 a=qLoRajl0y568ijBCVsQA:9 a=CjuIK1q_8ugA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=HkZW87K1Qel5hWWM3VKY:22 a=0YTRHmU2iG2pZC6F1fw2:22
 a=uAr15Ul7AJ1q7o2wzYQp:22 a=tafbbOV3vt1XuEhzTjGK:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=k1Nq6YrhK2t884LQW06G:22 cc=ntf awl=host:13624
X-Proofpoint-GUID: ZijUrSvx28hWPpxaLxuzc_0-LmHFPzNe

On Mon, Oct 13, 2025 at 05:20:37PM +0800, Huang Ying wrote:
> In the current kernel, there is spurious fault fixing support for pte,
> but not for huge pmd because no architectures need it. But in the
> next patch in the series, we will change the write protection fault
> handling logic on arm64, so that some stale huge pmd entries may
> remain in the TLB. These entries need to be flushed via the huge pmd
> spurious fault fixing mechanism.
>
> Signed-off-by: Huang Ying <ying.huang@linux.alibaba.com>

Right now the PTE level spurious fault handling is dealt with in
handle_pte_fault() when ptep_set_access_flags() returns false.

Now you're updating touch_pmd() which is invoked by follow_huge_pmd() and
huge_pmd_set_accessed().

1 - Why are you not adding handling to GUP?

2 - Is this the correct level of abstraction? It's really not obvious but
    huge_pmd_set_accessed() is invoked by __handle_mm_fault() on a non-WP,
    non-NUMA hint huge page fault where a page table entry already exists
    but we are faulting anyway (e.g. non-present or read-only writable).

You don't mention any of this in the commit message, which you need to do
and really need to explain how spurious faults can arise, why you can only
do this at the point of abstraction you do (if you are unable to put it in
actual fault handing-code), and you need to add a bunch more comments to
explain this.

Otherwise this just ends up being a lot of open-coded + confusing 'you have
to go look it up/just know' type stuff that we have too much of in mm :)

So please update commit message/comments, confirm whether this is the
correct level of abstraction, and address other comments below, thanks!

> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Yang Shi <yang@os.amperecomputing.com>
> Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Yicong Yang <yangyicong@hisilicon.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Cc: Yin Fengwei <fengwei_yin@linux.alibaba.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  include/linux/pgtable.h |  4 ++++
>  mm/huge_memory.c        | 22 +++++++++++++++++-----
>  mm/internal.h           |  4 ++--
>  3 files changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 32e8457ad535..341622ec80e4 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1232,6 +1232,10 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
>  #define flush_tlb_fix_spurious_fault(vma, address, ptep) flush_tlb_page(vma, address)
>  #endif
>
> +#ifndef flush_tlb_fix_spurious_fault_pmd
> +#define flush_tlb_fix_spurious_fault_pmd(vma, address, ptep) do { } while (0)
> +#endif

flush_tlb_fix_spurious_fault(), when the arch doesn't declare it, defaults to
flush_tlb_page() - why do we just do nothing in this case here?

> +
>  /*
>   * When walking page tables, get the address of the next boundary,
>   * or the end address of the range if that comes earlier.  Although no
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 1b81680b4225..8533457c52b7 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1641,17 +1641,22 @@ vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
>  EXPORT_SYMBOL_GPL(vmf_insert_folio_pud);
>  #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>
> -void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
> -	       pmd_t *pmd, bool write)
> +/* Returns whether the PMD entry is changed */

Could we have a kernel doc description here?

> +int touch_pmd(struct vm_area_struct *vma, unsigned long addr,

It's 2025 can we use bool please :)

> +	      pmd_t *pmd, bool write)
>  {
> +	int changed;
>  	pmd_t _pmd;

While we're here can we rename this horrible parameter name to e.g. entry? We're
significantly altering this function anyway so it isn't much more

>
>  	_pmd = pmd_mkyoung(*pmd);
>  	if (write)
>  		_pmd = pmd_mkdirty(_pmd);
> -	if (pmdp_set_access_flags(vma, addr & HPAGE_PMD_MASK,
> -				  pmd, _pmd, write))
> +	changed = pmdp_set_access_flags(vma, addr & HPAGE_PMD_MASK,
> +					pmd, _pmd, write);
> +	if (changed)
>  		update_mmu_cache_pmd(vma, addr, pmd);

We can make this simpler, e.g.:

	if (pmdp_set_access_flags(vma, addr & HPAGE_PMD_MASK,
				  pmd, entry, write)) {
		update_mmu_cache_pmd(vma, addr, pmd);
		return true;
	}

	return false;

> +
> +	return changed;
>  }
>
>  int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> @@ -1849,7 +1854,14 @@ void huge_pmd_set_accessed(struct vm_fault *vmf)
>  	if (unlikely(!pmd_same(*vmf->pmd, vmf->orig_pmd)))
>  		goto unlock;
>
> -	touch_pmd(vmf->vma, vmf->address, vmf->pmd, write);
> +	if (!touch_pmd(vmf->vma, vmf->address, vmf->pmd, write)) {
> +		/* See corresponding comments in handle_pte_fault(). */

What are the 'corresponding' comments? How can a reader of this code know what
they are? This isn't a very helpful comment. Also those comments might be
moved in future...

Presumably it's:

		/* Skip spurious TLB flush for retried page fault */
		if (vmf->flags & FAULT_FLAG_TRIED)
			goto unlock;
		/*
		 * This is needed only for protection faults but the arch code
		 * is not yet telling us if this is a protection fault or not.
		 * This still avoids useless tlb flushes for .text page faults
		 * with threads.
		 */
		if (vmf->flags & FAULT_FLAG_WRITE)
			flush_tlb_fix_spurious_fault(vmf->vma, vmf->address,
						     vmf->pte);


So I don't see why it's so egregious to have the equivalent here, or actually
ideally to abstract the code entirely.

In commit b22cc9a9c7ff ("mm/rmap: convert "enum rmap_level" to "enum
pgtable_level"") David introduced:

	enum pgtable_level {
		PGTABLE_LEVEL_PTE = 0,
		PGTABLE_LEVEL_PMD,
		PGTABLE_LEVEL_PUD,
		PGTABLE_LEVEL_P4D,
		PGTABLE_LEVEL_PGD,
	};

Which allows for sensible abstraction.

> +		if (vmf->flags & FAULT_FLAG_TRIED)
> +			goto unlock;
> +		if (vmf->flags & FAULT_FLAG_WRITE)
> +			flush_tlb_fix_spurious_fault_pmd(vmf->vma, vmf->address,
> +							 vmf->pmd);
> +	}
>
>  unlock:
>  	spin_unlock(vmf->ptl);
> diff --git a/mm/internal.h b/mm/internal.h
> index 1561fc2ff5b8..8b58ab00a7cd 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1402,8 +1402,8 @@ int __must_check try_grab_folio(struct folio *folio, int refs,
>   */
>  void touch_pud(struct vm_area_struct *vma, unsigned long addr,
>  	       pud_t *pud, bool write);
> -void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
> -	       pmd_t *pmd, bool write);
> +int touch_pmd(struct vm_area_struct *vma, unsigned long addr,
> +	      pmd_t *pmd, bool write);
>
>  /*
>   * Parses a string with mem suffixes into its order. Useful to parse kernel
> --
> 2.39.5
>

