Return-Path: <linux-kernel+bounces-746098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1A8B1231E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6770658246E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4032E2EFD97;
	Fri, 25 Jul 2025 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rDQ7il7a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="luKIkOXk"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A854E2EFD88
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753465444; cv=fail; b=NppbFYThCTPgsysfI39iUpE0utcaBkQ6K6eflTKOwDTXQ+nqOaRoqrqF9re9qnjdLwFcBlg4v/sKbG7E6bsBw8R9/zQtPZiTlBFysq+5zzjAFgKBzUj6EK5qQD4z7xcwzc8wdPpr+jBzpv2YIV25JMZb96X4foTuiio6N4pUp0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753465444; c=relaxed/simple;
	bh=/ZcIb8CODG/r9lfBiJpEHUrW14+q+1WoJeE8DvJUT3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YnnfIFi7pziCHGwOf8UqBSV04htsZILK5/GBLuLpZCHgrvPEMCyEcuDj6Opj0dZB+lsXvaz+7YWEVjQiArHboQPqXVS3CnpRJ1ffoaENZNTFfXR4hcUJU6+TUR07z9uTq/G8Zo6+VANzmyIpl9xui7NmrScDvIqdqVmRdejythw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rDQ7il7a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=luKIkOXk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PGC9Mk011107;
	Fri, 25 Jul 2025 17:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LUq8nc4+VTXMRYT22YE1Jo1RjOPVYzsophwXrTP2Vo4=; b=
	rDQ7il7aFsVLfFq/gLDRNkRth3pqqTg/c0n6YbClxFpVx7wbiUYo7H6sg/gxtfRh
	VrDuFpjVnf9akBWtXXpbTgUh8gMg9PU7SaNyRD/NwyWUHcHclR1YJFVUp1rY3fwe
	7g7dP3IWdRbYvL4VJXn01WWNS+VWV+viQemUkceBrjrBguxQpqy2+zegT1qI5SdI
	867QEDhb6t5M02fGKGWwKZqB4RYwoUeX04zFlnPeNyb3FwH4PMfwjpjH39VWphzO
	1fpTe6JaNa/p7N5qaFnPc8CpsU6c7vzV4k8aCO3OzFUkUDM+SVSptQk56cogiIMz
	xmATKrnFMDwATkFRspxHJA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w3vhhx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 17:43:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56PGb5TV005976;
	Fri, 25 Jul 2025 17:43:46 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801tdb5x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 17:43:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1/S/R+/L/h5AsU0IKOf/gr6L5PHCDz7E3TUa1zFEcRG2OmgA2BHe1U5LlRCgKyvX9k6jIzhWjez13MHFfbBsCf2gOhtY/q6K8jPM2q6pyWVIpOEsUZoRC1FanrkgT8gk/PuC3E5UXISKl1mZ096WXARwuwgMwIW3pqmL921queUEgApkPh6wLI5p26NjrfXEa8uoNFfGBKghOVOrGFkAFgAjYyTI/SJG7b9Us0CLn6R6xelDbVc1OGAZAMJ/Or152ONq/vCxIM8tO7xZ0f7JIqmdWiUomJ4KSYBilm0+qzAQgxkhNuFDcxTw1vDtLitVH6RFCeLCmZVqsuht9oRFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUq8nc4+VTXMRYT22YE1Jo1RjOPVYzsophwXrTP2Vo4=;
 b=WZaYN80DQNV9sOfifmDwBuixXpHYj0qigLpOdqntEEf9i/Pn6n5M22+QtS0ihRhqCEpicOQ2qAjxkoOk6xOQf/9ktp9DKlmJ4H1iNkXGcEXEwL7gW+DB7ibLJWPHNhwEwg2MYOKF88+8WWBhw4x+U/xFW7rXW6lno/kbg5v7jRwDlRGZgiSn4XHJkWrvm70rIbHcHE8BiLd/PqyH/RF9lPcX2PG4bR0QExQB/7/RR/PSUaxnoZFjLwsHVrrcCQqky+g9PobmDZue1Ic4w81ePG5KQJKTaHSKS+dbSIcHRh7UBUBPot6/un/G3FpYVGCP4mb4Ega4RH6J1SD06tNr7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUq8nc4+VTXMRYT22YE1Jo1RjOPVYzsophwXrTP2Vo4=;
 b=luKIkOXk83uILHqOuH2hmb1kSX6yUQa5wXLHk+o8PDUOv1H9rrjcOzU1DjJFA9E7yDxscc3A98GpyPFHgvwqkNZVbZGtdbKZpPFuDKbgIGRtNP6Cy0kmeikg7HWef5FCRC0gu6sl5EunHbdTwTL8iakTSF5UvieOikvmmbXe3xc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4280.namprd10.prod.outlook.com (2603:10b6:610:aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 17:43:38 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 17:43:38 +0000
Date: Fri, 25 Jul 2025 18:43:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 4/5] mm/mseal: simplify and rename VMA gap check
Message-ID: <ca6af6bc-1c5b-47fc-a00b-11d46867b5e7@lucifer.local>
References: <cover.1753431105.git.lorenzo.stoakes@oracle.com>
 <dd50984eff1e242b5f7f0f070a3360ef760e06b8.1753431105.git.lorenzo.stoakes@oracle.com>
 <CABi2SkVeHWt+SKWWodXUNhXZi1Wv9YazEOGWEUJLvgPbopqBrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkVeHWt+SKWWodXUNhXZi1Wv9YazEOGWEUJLvgPbopqBrA@mail.gmail.com>
X-ClientProxiedBy: LO2P123CA0060.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::24) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4280:EE_
X-MS-Office365-Filtering-Correlation-Id: 91acb3fb-c1e3-45cc-89a9-08ddcba2c9d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OW5FTDFnM29QOFp0dWJLVWtuVmRKbUhZYU5pcVllVjZ6bDRIc09FNlIyZDAz?=
 =?utf-8?B?YytyeFRmU0pZYWVyQ2dzSmxybDAwcU14UWROdHM3RER1NHZKM3k3MDZ2L2E2?=
 =?utf-8?B?ZTZBQUlyT1pKN3l2NzM2VThIRy9RSGorOU8vbjgvNGJNRXdNU3BNQWhXYldB?=
 =?utf-8?B?Y1RCampYcTlZazcyRmJENWVYY25wWEF2cHk1Sk5HbzhpWUtkYzM1QmxZMHRm?=
 =?utf-8?B?LzFURllmWUtmajIzVXNKQVkzaDBCU2FJY1ZkaXQzamdFbFpaeXRFMFlQUmly?=
 =?utf-8?B?ZFdnNUZ6Um1xNllxRnpHTkNsdnpVMEx3VmxqV2tyRGJ2K09sM092L0xUVHNK?=
 =?utf-8?B?dFlwaE9YZmJ3ZmxTYndIR01aRWczTUk4R2VETCtCMHRFak9uOGFPbms0NFhI?=
 =?utf-8?B?a0lWZFhGSzJNRDZPUnQ1aFFjZVBHQjVVSmxyZ0wzSW5hTlJNdGMwYnFSbGRO?=
 =?utf-8?B?TzNBQnhBOXJOVFJYSUNmTDEwYzhSbHBFa2xVWXpBRHR4TFdMalVHQi9zekxG?=
 =?utf-8?B?c0VqNHlhUnBOeitwSWx2akZoYkpQVDNha3NXd0hMT2JBeHo2UDkvRDNSb29Z?=
 =?utf-8?B?azJsekdqQUNvUVdsaUJYeFQwUXd6K1lwV2JTejdraGt6VWIyL1VnM2NTdlJV?=
 =?utf-8?B?RkRtMk9PQThGL240aDVGZjZoOEcwVnFXT2lEMDZFTUFEd05hd2lnZXJ2U0pW?=
 =?utf-8?B?TzAyNjBKajYwMzFXZjUvV054N04xWVJ4Q3Vyb2tHV1pvYzJXVEh0bjh0NUNa?=
 =?utf-8?B?dDMyUUU1SHNGM053M0NjWmh6VHQ3RlpYQjRwT3h6cXhaWHhvdzc5TlpReUxw?=
 =?utf-8?B?NGNrNW4vd251WTZrWFQ2c0pyMWZycUdUNjB5NmhUNGtrOXVBM0VMOVhxRE9L?=
 =?utf-8?B?YUJ1RmxibGJJb2xqaUUzU0ttNElBSlJSMHpKRmNXUTZmODVMeThYeE9abVpa?=
 =?utf-8?B?NkZqeFR3bTYrOUZaZjEzdTNMN0FWSlVqTlhZdm9QMlQvZlRrQjdIcElJSkRI?=
 =?utf-8?B?MzJvcjBmc25qeGFmdkwxcnNZb25sWnRYMDlXL2VhOXB1NVE3aktjR2owajlU?=
 =?utf-8?B?OTlncExtQjFXT1FtVmk5VUV4T201d210aVdUNzBnOVVXTUxhY2NaZTFSYVZG?=
 =?utf-8?B?TW8yS0gvT2xPRTVGd3lFK1c2VXNTL3hwalM0TnBQczN2eTJQbk1LZ1JpaWZj?=
 =?utf-8?B?amxmTzJZS2t1UWhlWmRZb3BYYVZRdFpoNzRCOFVkTXpuazJ0U0hPbkVLRzkr?=
 =?utf-8?B?N3VURU1kYTFyOEdvTEtVWFN6ei9qWUU4bCtxQ0s3VTNicUZsOHhCdS9YcFNB?=
 =?utf-8?B?YUlLNWhqMG84RXJnVHdMaDZsL0FrQ2NYb1JxV0p6OFo1UjMxdk50SWpxSnRW?=
 =?utf-8?B?TTRRZWlYVzBVRGtUZnBHUE1vamREVmhYS2o0RGZudjNab3JOVkYxYUN6enRD?=
 =?utf-8?B?SE1PMUxMaytjN0pPUXlPWGd4M2Nlb2dSRnAxR3I3SHhvVTJ4eXZyQkZzdHdE?=
 =?utf-8?B?ZGZZM3lYbnh1S05XcHplamtZVHFJTnFKZ2pwOUkvQXo3RHRJVEJqTm1jbC9r?=
 =?utf-8?B?TXBKSlhkaTJhUnFTTytwS2syK0RQejIzeDlTY2dEOHFOcUNoQTdRaHdDM3BY?=
 =?utf-8?B?ak12eXBXVFl0QnhwNFV4dW1mcnpmcHZvWUFxZWxrRWZjRGkvVGphWVpWV0tt?=
 =?utf-8?B?NnVxenY2YVZLS0JKTEdLdGFJYjFHQzdMZndNS3E2VHF3QlMvQWQ1VGE3Zloz?=
 =?utf-8?B?Vks0SHBDV0VJcWRqbmNzWE1iV1VGMXp2QytjVllPOURJOW1oQ1pFZjBqN1Zy?=
 =?utf-8?B?NkM1RmlmcGhzL3ppMEZzbGJndHNrcDRaenhaWFZoN2M4OEsrVmhmUXUzbmth?=
 =?utf-8?B?eHVwTUxQVktoT2N0bXJuMWgzVVBxWE8vSlVsUit5RVpYeGRpWVA5OXBNSlYz?=
 =?utf-8?Q?Xlv36FF6qiE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVUvT01GdWV4ZWoyZXErWFBiOXR0ckpPc1pveWVxRTQ3ZlFSemN5d0lTOEk5?=
 =?utf-8?B?YzRvNER2YTNZMHp0THB3NzErU2RVV0djTjU1SFZkZGdEOHMrTUV5aHFvUE5O?=
 =?utf-8?B?aTRlbmJaZ1psWC9pMmFnMWJsQ1NsbytIdDhoWEZmVTRuSE5qK2tqYkNyVGxO?=
 =?utf-8?B?cFhxOEQwR0xXRmN0UlJLTWlEWTVJWklUaDV4azdJTWZnaExvWWJuSW9kbUk0?=
 =?utf-8?B?ajFlYkdWeDRTa1JHaFVIYXlWb1VNRGJTd25nNU40eWlMVG9EZzA4d29wRjEr?=
 =?utf-8?B?bUwrUVdHWmVpcXl5cVZvSUVYdmd5c2oxelptbDNFZkJlSjhUNlB2OEw3WkRn?=
 =?utf-8?B?WGlHYWFOeXVWcmZWckk0L2N0L0tickJoc1RqdFBEV3dDTTMrcGVxSzZmWkdr?=
 =?utf-8?B?eXdNbCtoS09yWTdpQTZqZFFHYktpQlV0QkF6M2VlV2FwVjViZUJRWTJSVjUr?=
 =?utf-8?B?QmxpU1BUUGpwaGo4NWIzV1FRbitEckJkWi9tN2kyWXN4N0lnQjBXNlhSZ3FV?=
 =?utf-8?B?b0pJMzJXa0NTejl5ZUZuUzdxMGZ5QkRQTnRjT1FmTXI0dkZpVHdTQ0lpUlFZ?=
 =?utf-8?B?K3ZxcWZsYkNnU2dZRDRTRWR0ZkVpKzVSWjRDcDdOVTMrZDRMMUFpL2JxSS9M?=
 =?utf-8?B?WHpIZVpLQ1U5ZFR0ZDVrWHByTlRBZnJmVHM0alBML2RlUTNlbjV0dm5kTUxz?=
 =?utf-8?B?VEJZV1E0dDZBbUM2czRSby8wdnlVTU5NTnNmeXRiNGwwekNLMmFxS1doa2l2?=
 =?utf-8?B?dmVSUm9URUJZWjNlaHVEYlJjT3FRK0E1K3AvNExKaHRac1ZRdkVaMHpWRVc1?=
 =?utf-8?B?TlY0c2t5TER3OGZJQnZjMUU1VHRseTZXaE4vYURNdHNCYmhVQU1uVGR4YXAr?=
 =?utf-8?B?Qk0zNDJ5U0VCcjlzbGxSVVBhKzY5ZEJwTGZlbzZVSDNHeVpQYTBveFAwaEJm?=
 =?utf-8?B?WUd3bXdrbWU3S0FSNGp5ZE8xTEFoTzFCRFA5WFhYbWo3bjB1WTZCa2dWTitV?=
 =?utf-8?B?emR6RVphVTNoY0UrNWw3NWdwSlhNRkVqclEyRm5DN2F2Q05VZ3Qyd2tUQ2dt?=
 =?utf-8?B?UVVrYzRpU3JrMm5WNHR5WmRQaXg3OCtuYWNtb2ljZ2c1WWJYWXhXVSs2SkY4?=
 =?utf-8?B?SndnTUxGUWh5aFF4N0FUaWxnRmozUlFPZ0x1VktRRzhwbmlLVU5obnBDcDlO?=
 =?utf-8?B?cndBZGNnUHVxNHFLVFVtazV2Mm5WUW11cmIxTU1UZzdlVkE4R2JIeEpQSTkr?=
 =?utf-8?B?OVRoNm1XT2N5dFpFM3N0THRnRUxOMTJBWk1BZmRhMmRWMXZLUVpNaXhhUVph?=
 =?utf-8?B?TC9IekhpV3ltV29GNzBKUlYwbktuUitNcjZFaEJudzJUMUtsamFBd05QOTlQ?=
 =?utf-8?B?cjBlWjdiMmwzY1hRUWNLMkNRajAzMWpRTXBMK3FrZDN3ZmU2SmxpR1J1cGtC?=
 =?utf-8?B?cURkMytHUVh6dndJZ25Ub2JtcTB2Mm5kVThnbXAxR1RnRndNdUI4Szc4T2J1?=
 =?utf-8?B?a2tDWWJ3dWEvUVptdHVJUHhQV1dJK1JwRFE3Q1B2aENJT2ZtSlRGcmwzbWg2?=
 =?utf-8?B?ejZ4M3VkbzEwbjkzNU5hU2JiQXhlWVMyWkdFZ0UyMmdrbk5pb0I5S0dpUDdn?=
 =?utf-8?B?YklHT2llMmdKM1U2bnNlbGx3ZUcwSzhSRzBHVkQ3d1h1YmllcEpJblNRNmxN?=
 =?utf-8?B?Y2hJQnp5K2g0d3JMdjJ3eE94aEw3ek15YU5ZN0tzRDZTc1E4S2JLcUc1eEtR?=
 =?utf-8?B?bVRId21ZZExtdGVZUlVhNXZ0MFBUTm5xYzJLS0FSbGhnWWdtWlZaczdWSEM0?=
 =?utf-8?B?N2pNNnR3L0FHRkxOMitrMEphUGFXY0N3VFhmL3ZSNHN5bFJwbzZDWHVwdmsz?=
 =?utf-8?B?TGh0dGlMYUYrUFY3R2NYMjNjNTk1MTNoS1hnandHUUh6NnZaTGJ1VDZ6dmFl?=
 =?utf-8?B?b1VkYzdwQTViRUpJMjhSOGZ3cjl3T2ZIMzRPRDJoWUUvbjNIRDdySDRSNVpH?=
 =?utf-8?B?Q2NpbHpNSXc2cjRyOC9BSkhNQTA4WnU0Y0ZJSGtWMFhLVk54OUNKOGEzMDFK?=
 =?utf-8?B?K25kQzRTaWJlcThlMFdjT2hWYW11NWRiSnZUbEFzR2Y4TVNMTWM0azdPcWtD?=
 =?utf-8?B?bUZFSkVpdnovbU8wVHFUS0ZKRlhsQ0xkaVltaGlTeFM5QS9uYnNGRWxKZzds?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C1wvnFIOD8rucyMQNl+01WsAGtEJFATQ2J0yBGVyGt7hEE/SPItxyIxrrtweh0ZSx9L9/Z+kLwUZ4cK6Hx7vJaUXA/Bdxg0JW+k9ewtyQIO9GSKZZ+VS8M8pk7phjf2U9QT7PZbBFmPYynfeEgmZWr4k2hDhS0uv2MjZnrPX4XgGBLmzTdl2tNaGcs4eu7jYeqH1FcFfITimHzSArG/3w8GGPbzVjmJyCruseX+PoIcc21EbkEtntxYCe0mEZnJJmCkFG0o3c8AQAn8xdip+kZ2wxbdAmGzV3ZuleAGFKPMb/OV73zE889fYWwlermVS7O2nkUGZL9WnemZmb1qItzT47+ZIqWylt999w/GEMBJGqUNKQmn4ppJ9tv4xY1IpDO3voMmVedOKoxrm5XiDXUAI1rWpVMfi9iehwDu0B1to0LrLK6aRlLz3NTAG8ylY/U0/5H+Ia1RnjRHv2QMmLaV1YUL4YgMF1eMgFZs+Y5ia6/+Qlg5gQv1HsZr9eJhyZSHJSHHKQtyR6sMjPPRdh0mgfgRYmuelOGPOLCQjdKZA7HodlcBGoshwWsdLg2KeddmkH4cJajksFMSc3QrfvmjhCi8v0ejWlkaeNyosPL4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91acb3fb-c1e3-45cc-89a9-08ddcba2c9d5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 17:43:38.8405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yL3QxS9q2Y7jdHdw8RQJW69PfF6uiEYd3zivuDXv26RpkMTb8ZmM9A+nyRGYAlOFLdZV+Tn2/RcgyaptqGjUESgls7wIpbdqjMt+jJTaJI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4280
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=993
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507250152
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDE1MiBTYWx0ZWRfXw+Ap8p58G0VJ
 vfjqyGJOc/NIkEKsLwFvwDLsKbgg+k5KNIJdXCGjpWhKXgcnCmAH/JK9GOJLwDFAT9sV+qpas5R
 ANej8ovwEN9KfY2P7d1aP+a/tudvXgnlT8iPLEHyUN0n+JXqMUjSQYcjUjKWV8nLTKPo4/FGr6L
 VklJTVkk49fv1o/aRiYFeCakdHdABSwevcId+kSx9SilVSHUZHPsY5kmz+D5GcJyrj0tLPivlhG
 snYr8cq/GsBdfHz/NI2r/XxBVMHag5ag5+u9qDBZWO83uZurO2oPaHtsh6g12Mvi6nFJn2qEMjy
 moTFyDTCeG9+/9drEH2aTob04ojxZ6dLohz3hMXanLzZlBj4ZYtlK9ZtruQ/NqWvzDxU8J7f9py
 4flRPv++AE/St0ZYZJVQh35NYNSGWqDsxwr0q+kczfEF5xXNqvTqmr4eVtpwFpsQYwtjphK6
X-Authority-Analysis: v=2.4 cv=VqMjA/2n c=1 sm=1 tr=0 ts=6883c252 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=mqm5q0hi6Phm8K2wZgAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TxOqrULD_TsOEpL4CtsSOu5OBu-mKgwY
X-Proofpoint-ORIG-GUID: TxOqrULD_TsOEpL4CtsSOu5OBu-mKgwY

On Fri, Jul 25, 2025 at 10:30:08AM -0700, Jeff Xu wrote:
> Hi Lorenzo,
>
> On Fri, Jul 25, 2025 at 1:30 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > The check_mm_seal() function is doing something general - checking whether
> > a range contains only VMAs (or rather that it does NOT contain any
> > unmapped regions).
> >
> > So rename this function to range_contains_unmapped().
> >
> Thanks for keeping the comments.

You're welcome.

>
> In the prior version of this patch, I requested that we keep the
> check_mm_seal()  and its comments. And this version keeps the comments
> but removes the check_mm_seal() name.

I didn't catch that being your request.

>
> As I said, check_mm_seal() with its comments is a contract for
> entry-check for mseal().  My understanding is that you are going to
> move range_contains_unmapped() to vma.c. When that happens, mseal()
> will lose this entry-check contract.

This is just bizarre.

Code doesn't stop working if you put it in another function.

And you're now reviewing me for stuff I haven't done? :P

>
> Contact is a great way to hide implementation details. Could you
> please keep check_mm_seal() in mseal.c and create
> range_contains_unmapped() in vma.c. Then you can refactor as needed.

Wait what?

OK maybe now I see what you mean, you want a function that just wraps
range_contains_unmapped() with a comment explaining the 'contract'.

range_contains_unmapped() enforces your required contract and the comments
make it extremely explicit, so this is not a reasonable request, sorry.

