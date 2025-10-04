Return-Path: <linux-kernel+bounces-842009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D34BBB8C4A
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 12:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62CDF4E2E5A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 10:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D0D25A642;
	Sat,  4 Oct 2025 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k7cW8VH/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Nzf2EdEV"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79284186284;
	Sat,  4 Oct 2025 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759572426; cv=fail; b=Q0X/9e6bzMGfCcw4ovW4U6yqeijJgdLj6E8SmnAC0l1yDRjKtTDab/kssJ5bsdAFXZ5nyogtv7NWGrSu7DH88HmKZEtAwa1VBERameoXcv0ytc4r10klY3vWS9gQAEijCC9nWrZLbKj0EoDPJINQXf1G4UJ/yWTS/F235P0IfYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759572426; c=relaxed/simple;
	bh=FMXsXy3oYuaok2WE12uSMrQgyXtPB+CTEvpPbkBBBSU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WMSbzqd4GY35+BgIfc1xB1r46Cul3s1/LHJETMBRHYwbabEgxMWcz2GuGqVVYqMlbhxHyKQcN/L9BChAUVYerKIyow6oXuYzJqihSmjOeEuzf7MIGbpvEItEoFzo95dWLB/1JCn9xuBydmvYJrBGJDdb8ZMBNX7cL+YosztHMSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k7cW8VH/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Nzf2EdEV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5949e2bU024358;
	Sat, 4 Oct 2025 10:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VEMS6m8vIfPDD1JC2w3Qfv8KDeq/rU6oKi7b6j6Llko=; b=
	k7cW8VH/LsM+45bJ0fqxvOya/LLOrsK/jQKSksTM1NiA5TGjJSEcy4zw5DDSUcyM
	Fr7YP72F4kqQlsOx9SxumWm0DNbptlJos24ekp+W0DCpIFSUQMZ+jYfuOqn/QmtS
	epIdeU/tJiGiP+2xugqT9a3Fcgy16uvD+ajRitCic/+45nOMgLzUF51hZ+4n8NRA
	cR5HfrYVjtlJyXhp/YrNivt71ylEKZKfOlpH74Us/FcJKa9HcXTKctlA0G2J5Nm/
	SG+QZ7ytZ3jahOGsOVtPbaeK+TvbgxOEfmki1cEi4fXTgyjzBUoiSprm0PdY57gx
	SbRLedK3Nlq+eQ91YXBl7w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49k150g0gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 Oct 2025 10:06:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5946uOx2028600;
	Sat, 4 Oct 2025 10:06:53 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012004.outbound.protection.outlook.com [40.107.200.4])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49jt157uf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 Oct 2025 10:06:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yp4UxBiFaAIt2uvkQ9OnTgzJF5vatCjn3kyfA6hqSwW+p8fEaSMo0YHBRZYV6y/BExnRN/JUCvqhEL4wmxV6RZO+eAzHK0a5HGoehHVjSHtprhP09SagWen+jFQmfq5Mj8yD2NtNQ6/iB0q0j2w5ooAkZVyScKZ5hRaKyKMY8s4i4K2kIP4Dr/ZrrWOrUSJXrE5fx4bjG2QyraN7qVoUo1q0RrFe+AlQBkSWUu91j02zcqtC3U6cpBc7YR/5Up4xlJsnHJAGAIIt3tAiSVf1PpETexlesY5vztyHn/RB73aBPwzmnnWlMVSgjmYwF3fbf53uxrqLEVQf4PmKfde/tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEMS6m8vIfPDD1JC2w3Qfv8KDeq/rU6oKi7b6j6Llko=;
 b=U0n2Q8qX3i4jBjX+Zk1EC9h3IhiXW+I4I4WGGyXxAnGEG4c9ehTVJbaqCLTqSfyMYlaHSwzy1pFMJ46VuWEPT+TbiNSv/uWz8hig+vpxgCakgI52/vuskppEfoBHIgA+79NhVId+41OZNfbyC2I9CAICVi3+eFoVs+8NPaWC3z5I4/Tl5305HJpmepJLXgm1vmFe7zc1N9Hod5ZkxXNYTRXe6eT6gwL1P0rtJ+QvzkYoOKCTqr5hMP6DTvdGy03YtW4EBCxvdn6f4OW8FDvOX9lzq3PZqQJIpH01Xn48WlSRsTI99EixZvDB7v7yTYdGOfu93G9WOnlEzqL3BwGCbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEMS6m8vIfPDD1JC2w3Qfv8KDeq/rU6oKi7b6j6Llko=;
 b=Nzf2EdEVaSNfIUrYALPQaheI/KQF+msYiiaJ18yIBiNQjEdOLY0laNDPx75jNUJOR10mZZSRYgrcXQ9WRk9Y78Gnc7JtBTW/X1lrvD0xovwcXwd+fKyovHTZEb8nPbT9cYphco8tO/1b72ZtpK6fw+rvo8X+qX4I5vcTr362hIc=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH7PR10MB7085.namprd10.prod.outlook.com (2603:10b6:510:279::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.20; Sat, 4 Oct
 2025 10:06:45 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9182.017; Sat, 4 Oct 2025
 10:06:45 +0000
Message-ID: <254aa744-6bb4-49ca-8b28-778ca9037815@oracle.com>
Date: Sat, 4 Oct 2025 15:36:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v12 4/8] platform/x86: asus-armoury: add
 apu-mem control support
To: Denis Benato <benato.denis96@gmail.com>, linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        "Luke D . Jones" <luke@ljones.dev>,
        Derek John Clark <derekjohn.clark@gmail.com>
References: <20251003185520.1083875-1-benato.denis96@gmail.com>
 <20251003185520.1083875-5-benato.denis96@gmail.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20251003185520.1083875-5-benato.denis96@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0032.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::8) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH7PR10MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0065fa-307f-43d2-10c4-08de032db980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnNuK2hkRGtpdkRqazdOU1owbnB1Nnd6Uzh1eGhxcVJJTjVBWERrVVRnM2wx?=
 =?utf-8?B?cm9vWXJDT0tJVTBmcStaamlvZE9leVR4YVl5SERUS3I1K296Q3N5aW9hNURi?=
 =?utf-8?B?ckFOSnY3RnJrb3VjSFVzTEtueVFoQUN3UUNlb0dLWFkzY2d6UHRGM3NtTS9C?=
 =?utf-8?B?SjBpV3pSaWpuRFlWSlNiRUVFN2lNaTFmdjR3UGh4Zk41MXFKaEM5L2lRUzYv?=
 =?utf-8?B?c0kzZjdWRlpzZzVkZTRoV05sa1U1d0p6SUxZaDZkSW5YcGVNSkNRUUovUjBy?=
 =?utf-8?B?QWNBL1k3Z0dENmp6a0NEODVMQzVnQ0VwNVhwWUNRNUo5ZWlFYVlxRnBWMWVP?=
 =?utf-8?B?TkdtWWRVUy9sOUhiYkp0U2dBd3ZlNUxDY251V2VqMFR0cG5PQTZoQlAwTEV0?=
 =?utf-8?B?UzlwNjRHVERiWFdFMXFOMnZrbXRZNmgwbXB3djU4YkhkbGE3Z0lSalUrbWk1?=
 =?utf-8?B?dHVoQkpsYWJaNkNsY0t5V3Fpd0NhNTY0akZaQ2JTbVF0MTQ0a0VUeDBiRU9p?=
 =?utf-8?B?WTJTbjgyUHQ1V29Qby8xbWc5Mk1ZelIyaThYUENqN3VITjYrUFRZZFBNY1lH?=
 =?utf-8?B?T0t6YkpRbjRYTXBHVTZRN0F5TWI0dUFyMmk2c2ZJd3pHTzIzaUlVc21aNFRO?=
 =?utf-8?B?YjFaOTlUZ0dDblRZNjhkUDRIZytmTnFEWGJmeHpyNlNCMFBvMDFxNXgxUkl2?=
 =?utf-8?B?MEpjeFVRV09zQXNsdEhDWXJCYkRNV3piN2xFRGRuVUo2bllYMFc3RTJtM1Rj?=
 =?utf-8?B?SDMrTGlJa1h5a2ZiY2xDWEZHNi9tMEZyT0IyYWoyYzBsaVU2QVVCSFNhNTVZ?=
 =?utf-8?B?YzFzZHBZcURGK21XbzJiL2xlNGNycUMxNEpGNGlnNyt3cTRwRnJXUGNFMVhx?=
 =?utf-8?B?RDF2UFIvZzJPQ3RTNngrMzlpWTBKRWVpS2xFWHdWeXRNWE5MRXpIa05QYnhj?=
 =?utf-8?B?eVR2OUNJdXlvb2dDdGN6ZlcwWTFOU1kyWjF4eUtIM1VRS0xJaWZJQk8rcWhB?=
 =?utf-8?B?N3BQdDlXSytHeE1IVUMyN25XSHhOdzVZUE9uRmlyK1QyWE8yNWJsSXFVYk9F?=
 =?utf-8?B?Y1h2dm5nYllDZTN0dVhzOEtNakpIU1lHL2RqR2EzR2hlck1Pbjk4UiswZnFD?=
 =?utf-8?B?aks1OU94SWs1bGJmS0xnc3RvTmkycW90TnhMNHV5U0k5U1JieElTVTZiMC96?=
 =?utf-8?B?bXlTcnBrN3Z1Rm5ZSmFjRWViMDFHVEhMVk4xcUdwRGNTSFk3TG5Oa1hremR0?=
 =?utf-8?B?WmYrSkZaVTJGQmlLY3E5SUV3aGdubDArcTh2c2lvU05jTFFsbmR3R29vcDFM?=
 =?utf-8?B?YlprODVLbXAvQ3RscFJXd3c5ZlI2aGlzbEtnNDhMNHgzblNXbnRlbDNNbFBz?=
 =?utf-8?B?YnRtdXA2eUhwS2l0M3IzaGpaOVM0OHN3NFZCQi9lUDVhckxPOGpBQTdNeXkz?=
 =?utf-8?B?cEhaNXV2WkNOTmhGNWxDTDd4L2VIOUxsVTI0WUlKTEZrZzZQa1NoODQrcmd5?=
 =?utf-8?B?V2hHZ0FlSVdtYTJZeUFxdGR1UnVyRGpiNXcza05QdkM5VWZSbk5uamd6eW9K?=
 =?utf-8?B?YklhQ051VlVxekhSSXJmalFTckFuM3JHQlFJanlTRnl0L3N2RnZ4aW5DL09V?=
 =?utf-8?B?c2dKeUltRzJDeERUeU45QjlRN1ZZU0piUU1nZDhQT24xa04rMUdFcWtsZ29Y?=
 =?utf-8?B?MEY1eG9VMGtTQm1jYTRxWGRlVFZCWm1hTkJ0Q2drdUwvNWI5UXhVRUdmdmwx?=
 =?utf-8?B?NUdVWTBJcTM3VUoyQkpOc25TRWp2Y0hKQWFFVSt0RHlCdzRQR0NQaGpRNmlK?=
 =?utf-8?B?dVBhNVNZZjYxZGRvVFpCK29DMjgwU3FhQUxaSSthS291U0g0bkdwVmJPTW9l?=
 =?utf-8?B?ZisrU0xwMWk3SWo5SmplM050dzJteGZOTFF5MmVqYitMVU5Fcy9oSE9UUjJk?=
 =?utf-8?Q?MCAogrwMItQGdDsGVr+eJ0f9X7ov0+em?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGloSGFxSGFWRVNVWjJYRTRkcnVkMlQzR3Bka01hYVZuSGN4NFViK2oxUlBQ?=
 =?utf-8?B?UnRPTjdTeXBxdC80L04zUFdSeHJGSzU3QlRGbHVMQjh6bEJtdWJLN0dZeStX?=
 =?utf-8?B?Uk5TVVp6MGxLSzBKM2hOSGR2WFhmdzM0MGRrbjF0cVV1OVUyNHh3ZmF1b0RE?=
 =?utf-8?B?cjhMUEw3bDdlb2Y4VTNoQmZKaVlQMHBuTlY3aVc3WGxraklhdEc2a2pZWk93?=
 =?utf-8?B?Q3Q0azQ2bVIrYm5KVUdCQmVKeUh1eUFhenUyVno1UmtsdDh2NHdBWHROL0F2?=
 =?utf-8?B?S2p3NERXZ0ZmdjEwbE40TFlIUW9mcHZWbFo4VDVqOWY4UFpTdEtsUW93VGp2?=
 =?utf-8?B?VGxOSHNla2p6Nkh2SmlIcjhrbXpUTjJza3NHN2RaVFRyZlhMRy9naGRGbmto?=
 =?utf-8?B?NExIRVh0R1JDMW1ERjhLdnNEMzhicUlCYVRmRFN2MHdPZHU0VUhad29FT291?=
 =?utf-8?B?WTNMQUsvL0JkVk9NaWpIakJQWWF6cUE2NkxNZGpxenNGS2xkMUFlR0YxNnZE?=
 =?utf-8?B?SVdoWGlhTFlFWkR6YjRUV0RnTm5ESC9YQmI2b0NPVUpUTHZQNmFCd0o3Mzd1?=
 =?utf-8?B?OEoxQlhQc2s5eXlzWjRNSCsyei9vUDB4L0lidEc1UUd6SEdPenJFQzdLbUhL?=
 =?utf-8?B?cEd2TFVJVUpWbVlaN3JnNzFYOG5wTmhkMmw1ZjF1T0cvOXcwd2dNdGpDSXNC?=
 =?utf-8?B?Q2R1VDRJZkFFRk8yOUJtak52Q1lQbVhkQm5DS1FwZU1yUVJObW5FY2h6OStZ?=
 =?utf-8?B?TVdCdWl4WnNsTHB2bTl0bmdIdVFsRTBmOXFVVWdXUnFxUkNlSWJHZWVtUzRk?=
 =?utf-8?B?RTUxci9BRDVvVmRBUVNLd1MzT3lQMjBRbXZEVUg3RHpnRFRGQnpHelRwbWty?=
 =?utf-8?B?b1k4UzBYMEJ6N0c3eWJyRUZIbDV0b3ZNVDY1MzB3M1BTN2t1ZWU5V1pqSFd2?=
 =?utf-8?B?MTNsWDUzU0FhQUhhRFNGSGhvM3dFd0xFdnprcE9iYkg5QjJiZEtDcDlpWktU?=
 =?utf-8?B?UnpUUHNNdE9YR2piS3QyaG9OaXBaMFRGdThMMTZsNWFDeGhwZ2toZDZ2N1di?=
 =?utf-8?B?OUFvZnp5dFJBU05JV2p6K2cwclBiQllWdGhOUEtJS2NxR1FERjIySklFKzZW?=
 =?utf-8?B?NU1jOGVVUzJPQVk2T1ZkK243T3VxbnZ3QUxYNEVwZ3dmRStpeGs1c1JFMlg1?=
 =?utf-8?B?cG13MkRkVVUrdGVZMXIxUHNlVUF6VGRhc2NNS3YwK1VLa3luZmc5eENoSHU0?=
 =?utf-8?B?a3RRc2xnSVRWdmRwWGFWQU1HTkpHc1BPQlN2bTdlRjNaTGV5OHBXREZKYmt2?=
 =?utf-8?B?L0U5WDVBaERBMHozdDRMUFptUkFqMzFzNkFFNkpqMFNCYno0bDJwaGVMTERZ?=
 =?utf-8?B?TWFqdno3VUZ2RCsyQVAyb1MrbCt2blBENmljSFh0T3VMS2ZrMmU5QlZPbDIy?=
 =?utf-8?B?ei92R0Y3cnZyMG16eGtuTUczekx4ZUpqTWw0MGljb2RsU1lFYVNFRWZUd1d0?=
 =?utf-8?B?aWRQWm9rMlA2NDVNM09RS2xBRFZCMWRmV1NMbWx1T0ErY3JPb2p1QjMvYmtH?=
 =?utf-8?B?anRTUTZXZktJNXBLb0tISkY2SHBqWFZ6RXdmQzlHc1I2aVAzcldOYTJYTHR4?=
 =?utf-8?B?V291Umx2bnQwSXB0TWlBSmMxSksrSVFSbFNsbjZlbDdabmxUczlUZlRoZ25T?=
 =?utf-8?B?TkZrNzl0OGVlVWdTcjVNOHo3NGx6Z1BLY0ZmNGhjL01PQUd3aXpwUDZiRjg5?=
 =?utf-8?B?dTgzVWY0L1ZjWDZvQXhvQXgxNmRqRCs2eURwaGhvdFZnVng2SStoNHpNV1pr?=
 =?utf-8?B?M0tqSXYrQjZjaTg4SktPUUljSG5vdnN5RGI1d2htbnoyejdnMU5ueVZBeUxv?=
 =?utf-8?B?a3ByK1ZDRFdxWkpZUm85VHV4OXlxVFdRdEYzck52QXozRWRYTm9WRSt2TFZE?=
 =?utf-8?B?VysxNEhJYjMyRVNJNWNidUxVUURzZDUySHJvck9NOTNIcldaT2k1ZGJuRVB6?=
 =?utf-8?B?aFhzNHRkREcxNCtaOEl1SXpiNFk5Qkx6MHdtdWdiclVhR0w3V2NrcHVTRmNm?=
 =?utf-8?B?VU1SVDZsK3Y4ZzJlUGRBUXliNngrTnk3OG5ta2pvaUNhd3lRZDBpUnZIVUlw?=
 =?utf-8?B?eE0yWVpacklzdmpNQzNGeUc5a01PRkRFbVQ0dFBadUZMMGs2bElkMFhIZThw?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KkQNYtVzuM/G9SE5ecGqjt28WWxy8mr8liJi4V2l7NJ9rMZzAw9SIj75HqjOWCtvVfX+N+q1OorZ8FFBr/w6QLZxecjzvyD8UEuMh6tFpWLTTKl5CcYHbh33NiyD2CfOKXONCkKUEVHs7/zJExFWjb5CFGpofHvVGjRd1t/A2hYHtuCrnLVth+cupK8cspMfPvWFVxfcn1NV2Q2sC8ICriB4AoF5DrYaVtSUeOmZsEHZk4+P3V6XEQGMzZrYNMWswvzlv4z2X5BqpdkDGhC110gCGwxEkGJX/6TSZui/Dfn7GX4XkfRWxQLmU4YkwyVX4hgwJ2vTuHZiEXO6NV+FG8N7eFy9B5MEud4uDIPq3vgLDguWd7pvWuehRSTv0l7rEdyRz7J7iSqep22b07E6JmEU2YLx1vz8QYJJ2Fnfp8SWQDtZxZC0mEV4BEGQ8YH8koP0vRA8Hmf7wTCpDuOqbuaP/rJ08//z9VOSHGyEDFiCsJI+yxLRKbBZ4K8iA1UpjaUdabSvufhbpcuDbX1EVBQ9AuKgIBd3wLl59XIWqpdn3TFc22hsqyoMREsP1wUWgEwBG8pd4amJrN2zj2+zEmnxiA/XhGxoxO4QeA1d70g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0065fa-307f-43d2-10c4-08de032db980
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2025 10:06:45.5998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nI5phRPDRb0M6ZJ5IaSyQOqc2FsqeoMoJmqohUU0v8Q1j01E2u5D+O361MpZLbroAwlX6j04EIWP1tVazJJQuP/e/pJ2hOT6HGpPannUwxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7085
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510040087
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDA4NCBTYWx0ZWRfX59ZQaPETxusk
 z3qPDjow3R07CwmiBLSG0ek8AXD8DExUep8GR3f41wANZuMwb2vllUJ3z39nQ7BvdIzsjMSHKXf
 YhFeeyGv8l8nthtUW2Su4RryzvTC0Rps7/qRWh+51YP9Pwejclni7CqrHkwjW5kluWn+uwSt6/e
 kdzxB2THsusUyiZ6mxqxoy8TN5kQHvxF9rKz2yJ+FanoKaT6UJAVxjRRvjaR/enxoRyRWL7faBL
 WCAS+FsInNNqevVcYX88e5fr3ObNPjTqmp6R/qnkFdzl6PtConImI/C5AD3pfyL+vPrxZ44RmAS
 cVZQ1PJQ6I4Y2TAQH61CI4ju/3f+DoNse34RkklGIX5Rz92OSsKs8wXksVNUh6D1swfrL0lXOeJ
 +HUvorof1BcMQtMkp6Oa9qYTEOzpu9XFzRR7g5QESj2hZdywuiA=
X-Proofpoint-ORIG-GUID: WdWYs6n0fwsahQJVgyUU20XWfuI43a96
X-Proofpoint-GUID: WdWYs6n0fwsahQJVgyUU20XWfuI43a96
X-Authority-Analysis: v=2.4 cv=Zovg6t7G c=1 sm=1 tr=0 ts=68e0f1bf b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=-lPWu3-zMgunchEdDqwA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13625



On 10/4/2025 12:25 AM, Denis Benato wrote:
> From: "Luke D. Jones" <luke@ljones.dev>
> 
> Implement the APU memory size control under the asus-armoury module using
> the fw_attributes class.
> 
> This allows the APU allocated memory size to be adjusted depending on
> the users priority. A reboot is required after change.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> ---
>   drivers/platform/x86/asus-armoury.c        | 81 ++++++++++++++++++++++
>   include/linux/platform_data/x86/asus-wmi.h |  2 +
>   2 files changed, 83 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
> index 68ce2c159ae1..e458d23d020d 100644
> --- a/drivers/platform/x86/asus-armoury.c
> +++ b/drivers/platform/x86/asus-armoury.c
> @@ -394,6 +394,86 @@ static ssize_t egpu_enable_current_value_store(struct kobject *kobj, struct kobj
>   WMI_SHOW_INT(egpu_enable_current_value, "%d\n", ASUS_WMI_DEVID_EGPU);
>   ATTR_GROUP_BOOL_CUSTOM(egpu_enable, "egpu_enable", "Enable the eGPU (also disables dGPU)");
>   
> +/* Device memory available to APU */
> +
> +/* Values map for APU memory: some looks out of order but are actually correct */
> +static u32 apu_mem_map[] = {
> +	[0] = 0x000, /* called "AUTO" on the BIOS, is the minimum available */
> +	[1] = 0x102,
> +	[2] = 0x103,
> +	[3] = 0x104,
> +	[4] = 0x105,
> +	[5] = 0x107,
> +	[6] = 0x108,
> +	[7] = 0x109,
> +	[8] = 0x106,
> +};
> +
> +static ssize_t apu_mem_current_value_show(struct kobject *kobj, struct kobj_attribute *attr,
> +					  char *buf)
> +{
> +	int err;
> +	u32 mem;
> +
> +	err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_APU_MEM, &mem);
> +	if (err)
> +		return err;
> +
> +	if ((mem & ASUS_WMI_DSTS_PRESENCE_BIT) == 0)
> +		return -ENODEV;
> +
> +	mem &= ~ASUS_WMI_DSTS_PRESENCE_BIT;
> +
> +	/* After 0x000 is set, a read will return 0x100 */
> +	if (mem == 0x100)
> +		return sysfs_emit(buf, "0\n");
> +
> +	for (unsigned int i = 0; i < ARRAY_SIZE(apu_mem_map); i++) {
> +		if (apu_mem_map[i] == mem)
> +			return sysfs_emit(buf, "%u\n", i);
> +	}
> +
> +	pr_warn("Unrecognised value for APU mem 0x%08x\n", mem);
> +	return sysfs_emit(buf, "%u\n", mem);
> +}
> +
> +static ssize_t apu_mem_current_value_store(struct kobject *kobj, struct kobj_attribute *attr,
> +					   const char *buf, size_t count)
> +{
> +	int result, err;
> +	u32 requested, mem;
> +
> +	result = kstrtou32(buf, 10, &requested);
> +	if (result)
> +		return result;
> +
> +	if (requested > ARRAY_SIZE(apu_mem_map))

use requested >= ARRAY_SIZE otherwise out-of-bounds
apu_mem_map[9];

> +		return -EINVAL;
> +
> +	mem = apu_mem_map[requested];
> +
> +	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_APU_MEM, mem, &result);
> +	if (err) {
> +		pr_warn("Failed to set apu_mem: %d\n", err);
> +		return err;
> +	}
> +
> +	pr_info("APU memory changed to %uGB, reboot required\n", requested+1);
> +	sysfs_notify(kobj, NULL, attr->attr.name);
> +
> +	asus_set_reboot_and_signal_event();
> +
> +	return count;
> +}
> +
> +static ssize_t apu_mem_possible_values_show(struct kobject *kobj, struct kobj_attribute *attr,
> +					    char *buf)
> +{
> +	BUILD_BUG_ON(ARRAY_SIZE(apu_mem_map) != 9);
> +	return sysfs_emit(buf, "0;1;2;3;4;5;6;7;8\n");
> +}
> +ATTR_GROUP_ENUM_CUSTOM(apu_mem, "apu_mem", "Set available system RAM (in GB) for the APU to use");
> +
>   /* Simple attribute creation */
>   ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE_MODE, "0;1;2",
>   		       "Show the current mode of charging");
> @@ -414,6 +494,7 @@ static const struct asus_attr_group armoury_attr_groups[] = {
>   	{ &egpu_connected_attr_group, ASUS_WMI_DEVID_EGPU_CONNECTED },
>   	{ &egpu_enable_attr_group, ASUS_WMI_DEVID_EGPU },
>   	{ &dgpu_disable_attr_group, ASUS_WMI_DEVID_DGPU },
> +	{ &apu_mem_attr_group, ASUS_WMI_DEVID_APU_MEM },
>   
>   	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
>   	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 10acd5d52e38..a4f6bab93a6f 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -137,6 +137,8 @@
>   /* dgpu on/off */
>   #define ASUS_WMI_DEVID_DGPU		0x00090020
>   
> +#define ASUS_WMI_DEVID_APU_MEM		0x000600C1
> +
>   /* gpu mux switch, 0 = dGPU, 1 = Optimus */
>   #define ASUS_WMI_DEVID_GPU_MUX		0x00090016
>   #define ASUS_WMI_DEVID_GPU_MUX_VIVO	0x00090026


Thanks,
Alok

