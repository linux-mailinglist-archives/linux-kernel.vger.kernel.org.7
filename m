Return-Path: <linux-kernel+bounces-851182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090EEBD5B39
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B70D3420BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19E12D7DC3;
	Mon, 13 Oct 2025 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L//M5qXp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eaNUETbs"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAD62D7384;
	Mon, 13 Oct 2025 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379966; cv=fail; b=HhWozknqItkwCEtYRDY8QSH7H4WuCDlTN0xUxSfMHQW3c+MJ+CDgxJsqf+jq1tcvolOZ+2pxNglpvjHSJkSytqqAdvcePGPgxQgHtblPNdksvGvbgOsTrN0NENkPFvgC85Y8o9h1yWZJ7vty4/RieTKSrskSUOOK9VAzTHkVTWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379966; c=relaxed/simple;
	bh=lPhXv1oLO6ZfSAwawj8fPs0cyP2O3NxSVcH+pQe232o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pZ0mGe5baNuwlGGs+J2UjH+b1W1FcM2sDz3WVwFzNXirsu3wUdSft+jqZB2ZcZNOdfl0/MIpubOqkmD3cgADr5IvNIRFWgaBqpj6w5B0AfiJYlQOGoCxBbsKPBQkB2kYR4qEvWACfNqFKRP7S8HM2ZSrj6Wwme9b+p+qSByygYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L//M5qXp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eaNUETbs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DFu7GX015609;
	Mon, 13 Oct 2025 18:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8Ke756+B4eUhKooN33axU9jaujolzMy1O1yO3hMYZfg=; b=
	L//M5qXpAv1sidvhGgy4QDM4pB5cihxVaF4kLW7fFj0RIi9Zd8MkEabQ8TtEvL0H
	gWwbDj+wtVbVAg0a8Un0oS9ZniIK9w54k9ffBwXmR05Wf3zvWNDPbtYzFKj5noxD
	uJWUhavvei3NO1ZBSRsdy2ss941sTUK+SnIhZqCOQ08d/IdE42OFV0NuQulNK8Ev
	028LL3mJ+Cj43cZN6yl2JXmTWUNIOUCs8RjYPEvDZ6ysfQdTg8hkgrZeLXqi/LBH
	881w239rHO/gCaMiIONitCKcAVWdJMvQUXKbF+ZyB1or9clqTPTADJX6k0Xuj3zG
	9uYABXa5DQCzeCMCT7/MVQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdnc2uf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 18:25:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59DH3cQw037188;
	Mon, 13 Oct 2025 18:25:43 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp7x04f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 18:25:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpkqnHqLs9mcWHX5PDwdv+fUfWFLubTlw++ntxpQ9B+usSy9JdX6zbn5QsXx7aACCYdGyM09TIGNki492uojjIpnTTLUgR+DbqgJkjonemxdMMceuPn/bgXvFKLip3LqGfT1QBYB9ooXjuVK4Uelef2s8W3ucIg+akm9l7owWozYAMuWglTEsUcZGV8zoQ941RTn6eZ9zWc5/971Ym6+8ajme6kgAT6N/vJUgAImKlqMsv08yqissoHytkqRRI/2ieuwqp1k+lT/76Dre1qHr5FZI6nS6+TP5D0bivQDD8phK2D23+v/JhdqbH1AZOCSQOZsETc6o/LpYmx7A+zWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ke756+B4eUhKooN33axU9jaujolzMy1O1yO3hMYZfg=;
 b=VkmIi3juX9jvHvKgayfT3VbHO0Yp1nuQyVR/BjD/vIpOxPowHp0xeZEgVrkR4Mz+xkqe/XBUJHeqMLl4OnFvXDuvRG9QIMQWb+dNdcd8CF7YI8dd9hNtitmlLy71wrOKhIHP2nkOauO8/bqatQxhhIISPx6uM2a9TatEnoI0egWG53tSmTFhHyoc/ZTmxQW8qC4FamREt5j/bZMLKA5Jd6pLfCj2btaPs4pipYiNB6oJqI3xFAxKYzglf+TGaOlr2dOwmw/PMaBX7wOKHOSj5+SCZ/TA+9WcdWBpj56lR5AmrGD/ZkdVT2TeH+sEvjijDp3N9BhBKI9oC6YezR565A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ke756+B4eUhKooN33axU9jaujolzMy1O1yO3hMYZfg=;
 b=eaNUETbsM0lMIqp6YoB7TvnmL19iDSMnnh4FQjgaho9KuxgLuI8E14cHnCf0AqoltD8cY1J4xZTtH0aOJbPnbXWCRI+HZiBuX5UFcVJOlMtaWvJjMAMgD2XJK7zQJN73LBjJcIkSPiXHyioED7eOK6FiPFTtmgrsXEiEyFC3SAU=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SJ0PR10MB6302.namprd10.prod.outlook.com (2603:10b6:a03:44e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 18:25:39 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 18:25:39 +0000
Message-ID: <cad7b458-5a7a-4975-94a1-d0c74f6f3de5@oracle.com>
Date: Mon, 13 Oct 2025 23:55:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v13 8/8] platform/x86: asus-armoury: add
 ppt_* and nv_* tuning knobs
To: Denis Benato <benato.denis96@gmail.com>, linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        "Luke D . Jones" <luke@ljones.dev>,
        Derek John Clark <derekjohn.clark@gmail.com>,
        Mateusz Schyboll <dragonn@op.pl>, porfet828@gmail.com
References: <20251013180534.1222432-1-benato.denis96@gmail.com>
 <20251013180534.1222432-9-benato.denis96@gmail.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20251013180534.1222432-9-benato.denis96@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::16) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SJ0PR10MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 48d41f7e-4837-4a03-d8c3-08de0a85e942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0JwdFptVzZZZmxJWW9SbXlxMkxuVTJwYXRwcjE0Q09HSlV1QTk0dkgrcWY4?=
 =?utf-8?B?SEc5ZXRjRXJ5R0dpeFh5ZzdIQWEvRFdHZ1l2bTZNc0lJdzAzTlFzbUNIZ1JD?=
 =?utf-8?B?WFBUV0srODFraXlWbmpBd1BMSHhZcitWblZlTXljWEx1dHJjaUNpdHMxeXNX?=
 =?utf-8?B?Y3lxSGtYWkRDaU1xWXR5Y3NjT01pdkxZb21ISWpIYzE0OEp4UHp6TURqMFcy?=
 =?utf-8?B?QnJpOTA5R0JqaWdqaWpoZU1FcGloRnh5RGdhMmFCWEVEMUROMmpwTDZlQjhz?=
 =?utf-8?B?TEI2amNJcUorQXZFOVRCOENiUm1RczhCZXRreVowYWZZQXA4c3FLM0lZSk5W?=
 =?utf-8?B?bTEvcWo1SU56L2E4UEdvQ1lsNlNwcU1NZ01aVEJmUWtIN1A3YmtKU204M2tL?=
 =?utf-8?B?OVRCeGdYcE5jNFFvVTdRcmRac1NGSFJ2VDBtaTBQa1FRamkvV09hWWZsdzVt?=
 =?utf-8?B?bUxHWXB6SytTbVJYYmdzclRqQi8xK2tJc0FQb0VqQTkrYnJyUHpzN0VSNGsy?=
 =?utf-8?B?SFVKTEZzY214b1VDZnZ2cFdxSTBlaTFFL2pYNzc0SFZRbnNneUR0YnNyUTQx?=
 =?utf-8?B?c0hpU2w3dTZQcHhoaXowS01HWmltQUdmU1RvQjZXMzFFeGlua3VZS3FlcHhn?=
 =?utf-8?B?SkkvNHJ4TnJ5bXF2ZENGVVIwd3JXT3c4eXlXbEhQUWMzMDNJRlhWNzhRR2h2?=
 =?utf-8?B?cUZKVHl5K3dianF0a09sZTVWTkxySU40eHhnR093dE82MmJMUHZUcGFyZklB?=
 =?utf-8?B?YjlwZ2dkbGJiVlROaVNGbnVhaW5qT0ZjZlFpL2FMaUx0b1FKZ2ZhRnFhR0NX?=
 =?utf-8?B?OXBRSHllSFA2V1RzbjdqUGZnYkQrTWh1Mms0cVo1UW9qL1JSUmtzaUN1YVlM?=
 =?utf-8?B?V2ViYnhPUTZiNnJaOTV4K2ZMUDc0REh2MmRtMWcwK05BOFExVmo5NWZSa21M?=
 =?utf-8?B?L0poNDlEajNPYkJiQURTUzhyS2tjV2VZL0lWK0ZJYW1qUU8yR2gyOHdRQ1hI?=
 =?utf-8?B?T3Z1NHp3ZnIwSHlLQ0krQ2NFM0YrWWEwM002WGJ6bXZvWG9DdTBWR1VNQVJU?=
 =?utf-8?B?UFVpaEF6M1hjS0RhMlhSREkxejJPQ3RFRHRZM3BFQjk4bUdWdld5dlNnRmY3?=
 =?utf-8?B?L1ZnL0tRMGN4dHp2UFdSd0dnOFRDRFVaYjhQbFFFY0h1NERFN2Zxc0crTCtj?=
 =?utf-8?B?bVpqVWsyMGdYY2VWMEt4NmUzRitBMHBlR1RCbUd5Vi9neGw5b1QycnlleVdM?=
 =?utf-8?B?bnA2QVFQaEtMZkNFSEU0dWtrbGxvSm51Q0tEUGFsNWZnVUJoaWNvclpUaFI5?=
 =?utf-8?B?VjEvUlhoNnlvYUxYeC8vL0x3OHFmVjBmdFFUWHUrajhJWERTRmJLcFBpTERY?=
 =?utf-8?B?TWJKbUlwZDJlWFZIM0hYOGpyenRpaWNqVnQ3RG9NMlJWclBjYXRXczFmSGNS?=
 =?utf-8?B?OWUwV1N2V25pUGVmcUM3QWNOVzNzNS9KWlU3VWNYMkFRbHNQcmhVbUpqbjQ5?=
 =?utf-8?B?d2Q2N1JLUlVFV0lIOVBoWnlIQ25WSkRHVjBadFBOOCtDSXZFNmJiZE1Bb3hO?=
 =?utf-8?B?ZlVJOGJlalRhMnk4TWZOWDZOSlNHTHgwZHYzdlJ1V2plNTNnVkg5YWpvYVoy?=
 =?utf-8?B?SHY4dTRkMmpCelZMM1hUcWxmcXVhT3lJZzcyQ1c0Q2huOWpYY1ozR1BYbVNS?=
 =?utf-8?B?alRwUGx4Y2ticTFGSlNrL1FaZlJja0pKR1VIT1pyUzVSQlJOd3psdTdSWDNH?=
 =?utf-8?B?UG1qUHZmTGRyb0xBUm9KZHZsSmxmak1zQ3pCY1V1VnN5eG81TjhZM2lHSVRH?=
 =?utf-8?B?ZlBnbGRScXQyUTBadmFGemwvZFJ2Yk05U05PVTFXY1RvVjNzVVd3Qmc1SnVV?=
 =?utf-8?B?MHNaTFI5NmJCaGppTXptR3ZaUmw3YitmSXBzS3ljQkxpQ045aWYrekNBbFNx?=
 =?utf-8?Q?RDVTIATBQ1gBFX3qn4ivIiTHo1HMxD/N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWd3cGRvVkord0xtMW1IcGdpd2UyQS9mTlQ3U3Y1eWw5TEpPdlhBV1NqdGM4?=
 =?utf-8?B?NXpaZFByUEpqdis3MnhEUUlIbEZyVnhpNUZWVnovbE0yamVHK2VBZlltdnA5?=
 =?utf-8?B?aERqa0pISjBuU25XM3dwWnNGM2FCUE1Vd21qV3ZBclRLNjcvU2NvZjRwcGQv?=
 =?utf-8?B?K1lkd1ZIdG10SjFxOU1yUXFCdmxMWHVaOU03ME51dFVvbmFrVWxsMmxjNG1a?=
 =?utf-8?B?RExtamFSdUNsWHMzNm50aXRjL0hiQWxtanZuZTZpa1YzUDhtNkxKemN2U2gz?=
 =?utf-8?B?ZmsvUlBDWDBnRC8xdHArWXNZSFgyUCt0aWJIYUpVRWNWMVdpaUtnV2MvaXVk?=
 =?utf-8?B?Z3dRVEVqZ0xyd0ZOY1Rrdk9xVjlYejZ4TDJUVzc0aXgreVpCVWtlUXdKVlZU?=
 =?utf-8?B?eHVFRWhpc1FwbytZUzJnS0VwQnp2NE1KSWpDQk1mTlQ4eDhKQTdPREtZT1FF?=
 =?utf-8?B?S3ppSytFaURQMXlLYXZlZFdKaGszYitOWXcyV1M5YmJzYS91ZVJHZm91dHc1?=
 =?utf-8?B?ZjZxM0NiOEhxckpla0x3dk16dytQV1E1ZGwxSExJQjF6T1VrZGNnbFBHRzZY?=
 =?utf-8?B?MXJINWhvYjV4VVowamhhUWI1aGhLL0xSM1M1blBQMnpSb3FMbDBLWExHODB6?=
 =?utf-8?B?QlZoYm9MVDlTWExmZndDZjU4WElZYXVtK3dmSHp1OVNrMHQwL3RRelZWR2ky?=
 =?utf-8?B?cGNvL1VPUzhKenRpZGRnOG5PeEF6TVI2NklpMFZkVHF4TEllT1pGYXpRUklY?=
 =?utf-8?B?OE1MMXZ3NlZDSUxPMkxsbExEaHdwOWVrbDVwUUNHSitjKzZsMmNJbmozZkVI?=
 =?utf-8?B?QnJFdTNFYnVYR2c1SHlWTG90ZUtrUW9QUHM5WFZUazJMY1hlRGVBZDdQcWZr?=
 =?utf-8?B?WUEvbjNjazUrLzJDMlJpYi9Ia1BsaC9mZlpUSjJwN0lpUXROTUswYjlvd3Nl?=
 =?utf-8?B?ZmxvT1QrWEJNSE1QcnhyZEI3OVBpL1B3SzVOS0xVRG85eEpDV0dQUzJwcGRF?=
 =?utf-8?B?YWxUeDFwZE11Vjh4aHU0Qmt1djFjMSs2OFBXZ1M4cFhEK3EvRG1PNzBwWlpK?=
 =?utf-8?B?c0NuR244NDRLTElCSnRwZGZIUDVqOEZUMzlmckRpT1BDa243d21mejhTY01W?=
 =?utf-8?B?d3VOdHhyRWlSTTFuc2I3Y1dOVGdGMVhuTGlDQTZnMG5JM21weXFybmdQL0xV?=
 =?utf-8?B?REpOcjFxTmo0ZG52S2lReStQYVk5bUo1YS9mbS90QWZTSU5acGljd3dsSFBK?=
 =?utf-8?B?bHNmVXhSRUhGeUpEQ0pYWFBXOCttZTR3b0t2RW1KUXlMdnhFNXpVN3FwOG00?=
 =?utf-8?B?VzJIS0FwaThFQS9yd1Y0bUFMaHd3VUtORm1pL1dSYms5RmJWR3I0UE85VGtU?=
 =?utf-8?B?TGF0TjZMM3JWSjVXZ2d2STJmMG9WOWRoQTAwRU9ZUnU2NUpkWlJoUUo2NVdX?=
 =?utf-8?B?WHRoOGcvVkpuNE5UUTlrWjhJcFZEd3BHWVNLVlJBeDFVeG03V242ZXBGRW1X?=
 =?utf-8?B?K3p6dTNOSFU5V1lpemx5cTFBelBDd1JSdnN6K3hxYjRVTUZRSndBS2pIZUxz?=
 =?utf-8?B?T2hYRERKMklKR2dlamk1MS9uSGxnZmJQMjZhV3VJMWJoUlBZbVNneERuK0tV?=
 =?utf-8?B?ckFuNDQyTE9GcDdlRE4vMVVpU3ptT2NXa00wT1NJTENlSEIydkx1cWNWanVw?=
 =?utf-8?B?NEVncEt5RGVFZ01qZ3RtOWYwUlJtekJkZUZUYTRienM4UnB1Y1B2YjBKMktC?=
 =?utf-8?B?NVAxdi8xM2hVaHpkMEJIYUNnZC9IZ1ViNjZtVTRFb0tNN0F6Q3IwckRmNDFv?=
 =?utf-8?B?aFhOVlhDWVJtTFE0d3R4ai90YU00RUZIZlNKY1V0Rk0yT2JDUkZ6MFltWUMx?=
 =?utf-8?B?QU53dmtPSXZCbkdiM29qS3poNW0ybUswYmRTMExReW9pekRqZ2ZpOGx2YjNp?=
 =?utf-8?B?OXhpdmxtMlYxTC9OZHVuN0ZxczJCZ00zYjNVeGhQOVpBR25TdjZTQTA4MVhV?=
 =?utf-8?B?V0xBMExYYTA1WnpaT3JCWC9zRGVLRXc5VTYxN2QyT3ZITDd5VDNxL3Zldjg0?=
 =?utf-8?B?SUdveTJRSzVVdzhIamtyRlVrc3UxOUZROC8xdjhvUWxpcVdCK1FSeUw1QVRW?=
 =?utf-8?B?MU12SDNQVmJWUEkzaTJmSUNyT1FrSGhtTjhidDBOVW5DQ1h0WEowZ1lTR29T?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VKuGa6uUDOYlAdBM33ksDGy05iEPUTBs/CYshc1F/ezpoth7sr4jUsmpJglifACGLSCEs0yoWQ0W02X5koHiBgdjV7YMfhbRkovocmACXLLgE9yZhh94NGJHmlAuwwtm/ygTYFD9TGSS87SFbp/4WCptlc5o8cW8NvjP6VjW9bHkZWaMOrtA9T4PyZ+9GJQSDvkYiEogGltuP5tz8FVY+m+/hB4dN7HQy+3Uxulos3trYu+X0vURaFkMce14zw05R2izJ2CPCLNpT+YoIHR1eQtXIkp7BTat5opxJHZgBNJ6f0TY73+Dglu21Q56hNXCYpC0JFrgrkWMdDDNa7gJnu1wuoAmoFXYugIRLwLAiuivDHrMiUYiRZ70Wi42zZxS4wVsWMiFRBRqcUDxjPJPzCxh5qrHuguMylxo9DdBNAUeQLMr32qZzuURtaU7X0knuv8fJ/Kfave5WZyih9SeQnGogLoHK+PXT8dHoD1MmMOBE7tb3Ge+slvxCABPg5O7TOEwvV3t+N6uYvosE6EdFwU9FIwJFJK4gXmK0W+a9dShHH3p0LeldosyyUGdUhFRr8r7+yFtlqtropIdLgih9gwzZ03ZWA/ou9Y5EbKt8PQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d41f7e-4837-4a03-d8c3-08de0a85e942
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 18:25:39.5870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gs1U9hm65DOVx82f7AGvTri9wyajzm2skQH4rP83wWh3qQUVKdNR63w1TJvYQGDurtJWq+6ERV1FHa5PhZKWXbhCLcnrZugGXRi3roSkD50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6302
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510130083
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNiBTYWx0ZWRfX4FPmCjHEKOYd
 MzseIBESjD8V1/u2abPON33OFKtPdVzc1xIKB+TfRYAKrk1gsT1I/Z3Ep0q/dXSrZhY7Cz0hipb
 nKH5lCvp+GpWqLhjXagUBmX5NnELwjlKuIM+VQBp0Vrqy+Ctz2qLKX1u7RezFm25j4CxpvcsjQd
 h8XgWMBmf1zEUZTBfNRmiSrm5rLSS3NjTWIVXFqkKbZBGMl12MjLjhHaX20kbnqiCyNwRS2dfnx
 4tjVeKRuH4yuSz9zXt9pjJnnFB4sdFDP8h1J8CmIyG/zEwjuogoLMSz7Y2KMvIdwpFVBn7KGhr0
 mN39wMzlwLrWsTBB/83MntNDsSkofEOtmaWn3R/+SAEB/lwz+IfJ6B1LnHRU9SYYS4xD0kv+Mcq
 +OmBSKcRwgQgREChRvPCWyJLzEhyuQ==
X-Proofpoint-GUID: L5eVPPFNiaeTHSHCqPuPXCHCLWItUPjO
X-Authority-Analysis: v=2.4 cv=ReCdyltv c=1 sm=1 tr=0 ts=68ed4428 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=zd2uoN0lAAAA:8
 a=hDaAkW_4JELlBneUs5gA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: L5eVPPFNiaeTHSHCqPuPXCHCLWItUPjO



On 10/13/2025 11:35 PM, Denis Benato wrote:
> From: "Luke D. Jones" <luke@ljones.dev>
> 
> Adds the ppt_* and nv_* tuning knobs that are available via WMI methods
> and adds proper min/max levels plus defaults.
> 
> The min/max are defined by ASUS and typically gained by looking at what
> they allow in the ASUS Armoury Crate application - ASUS does not share
> the values outside of this. It could also be possible to gain the AMD
> values by use of ryzenadj and testing for the minimum stable value.
> 
> The general rule of thumb for adding to the match table is that if the
> model range has a single CPU used throughout, then the DMI match can
> omit the last letter of the model number as this is the GPU model.
> 
> If a min or max value is not provided it is assumed that the particular
> setting is not supported. for example ppt_pl2_sppt_min/max is not set.
> If a <ppt_setting>_def is not set then the default is assumed to be
> <ppt_setting>_max
> 
> It is assumed that at least AC settings are available so that the
> firmware attributes will be created - if no DC table is available
> and power is on DC, then reading the attributes is -ENODEV.
> 
> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Mateusz Schyboll <dragonn@op.pl>
> ---
>   drivers/platform/x86/asus-armoury.c        |  296 ++++-
>   drivers/platform/x86/asus-armoury.h        | 1210 ++++++++++++++++++++
>   include/linux/platform_data/x86/asus-wmi.h |    3 +
>   3 files changed, 1503 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
> index e27f964aebf8..918aea6fba1e 100644
> --- a/drivers/platform/x86/asus-armoury.c
> +++ b/drivers/platform/x86/asus-armoury.c
> @@ -27,6 +27,7 @@
>   #include <linux/mutex.h>
>   #include <linux/platform_data/x86/asus-wmi.h>
>   #include <linux/printk.h>
> +#include <linux/power_supply.h>
>   #include <linux/types.h>
>   
>   #include "asus-armoury.h"
> @@ -45,6 +46,17 @@
>   #define ASUS_MINI_LED_2024_STRONG 0x01
>   #define ASUS_MINI_LED_2024_OFF    0x02
>   
> +/* Power tunable attribute name defines */
> +#define ATTR_PPT_PL1_SPL        "ppt_pl1_spl"
> +#define ATTR_PPT_PL2_SPPT       "ppt_pl2_sppt"
> +#define ATTR_PPT_PL3_FPPT       "ppt_pl3_fppt"
> +#define ATTR_PPT_APU_SPPT       "ppt_apu_sppt"
> +#define ATTR_PPT_PLATFORM_SPPT  "ppt_platform_sppt"
> +#define ATTR_NV_DYNAMIC_BOOST   "nv_dynamic_boost"
> +#define ATTR_NV_TEMP_TARGET     "nv_temp_target"
> +#define ATTR_NV_BASE_TGP        "nv_base_tgp"
> +#define ATTR_NV_TGP             "nv_tgp"
> +
>   #define ASUS_POWER_CORE_MASK	GENMASK(15, 8)
>   #define ASUS_PERF_CORE_MASK		GENMASK(7, 0)
>   
> @@ -73,11 +85,26 @@ struct cpu_cores {
>   	u32 max_power_cores;
>   };
>   
> +struct rog_tunables {
> +	const struct power_limits *power_limits;
> +	u32 ppt_pl1_spl;			// cpu
> +	u32 ppt_pl2_sppt;			// cpu
> +	u32 ppt_pl3_fppt;			// cpu
> +	u32 ppt_apu_sppt;			// plat
> +	u32 ppt_platform_sppt;		// plat
> +
> +	u32 nv_dynamic_boost;
> +	u32 nv_temp_target;
> +	u32 nv_tgp;
> +};
> +
>   static struct asus_armoury_priv {
>   	struct device *fw_attr_dev;
>   	struct kset *fw_attr_kset;
>   
>   	struct cpu_cores *cpu_cores;
> +	/* Index 0 for DC, 1 for AC */
> +	struct rog_tunables *rog_tunables[2];
>   	u32 mini_led_dev_id;
>   	u32 gpu_mux_dev_id;
>   	/*
> @@ -719,7 +746,34 @@ static ssize_t cores_efficiency_current_value_store(struct kobject *kobj,
>   ATTR_GROUP_CORES_RW(cores_efficiency, "cores_efficiency",
>   		    "Set the max available efficiency cores");
>   
> +/* Define helper to access the current power mode tunable values */
> +static inline struct rog_tunables *get_current_tunables(void)
> +{
> +	return asus_armoury
> +		.rog_tunables[power_supply_is_system_supplied() ? 1 : 0];
> +}
> +
>   /* Simple attribute creation */
> +ATTR_GROUP_ROG_TUNABLE(ppt_pl1_spl, ATTR_PPT_PL1_SPL, ASUS_WMI_DEVID_PPT_PL1_SPL,
> +		       "Set the CPU slow package limit");
> +ATTR_GROUP_ROG_TUNABLE(ppt_pl2_sppt, ATTR_PPT_PL2_SPPT, ASUS_WMI_DEVID_PPT_PL2_SPPT,
> +		       "Set the CPU fast package limit");
> +ATTR_GROUP_ROG_TUNABLE(ppt_pl3_fppt, ATTR_PPT_PL3_FPPT, ASUS_WMI_DEVID_PPT_FPPT,

why not ASUS_WMI_DEVID_PPT_PL3_FPPT ?

> +		       "Set the CPU fastest package limit");
> +ATTR_GROUP_ROG_TUNABLE(ppt_apu_sppt, ATTR_PPT_APU_SPPT, ASUS_WMI_DEVID_PPT_APU_SPPT,
> +		       "Set the APU package limit");
> +ATTR_GROUP_ROG_TUNABLE(ppt_platform_sppt, ATTR_PPT_PLATFORM_SPPT, ASUS_WMI_DEVID_PPT_PLAT_SPPT,
> +		       "Set the platform package limit");
> +ATTR_GROUP_ROG_TUNABLE(nv_dynamic_boost, ATTR_NV_DYNAMIC_BOOST, ASUS_WMI_DEVID_NV_DYN_BOOST,
> +		       "Set the Nvidia dynamic boost limit");
> +ATTR_GROUP_ROG_TUNABLE(nv_temp_target, ATTR_NV_TEMP_TARGET, ASUS_WMI_DEVID_NV_THERM_TARGET,
> +		       "Set the Nvidia max thermal limit");
> +ATTR_GROUP_ROG_TUNABLE(nv_tgp, "nv_tgp", ASUS_WMI_DEVID_DGPU_SET_TGP,
> +		       "Set the additional TGP on top of the base TGP");
> +ATTR_GROUP_INT_VALUE_ONLY_RO(nv_base_tgp, ATTR_NV_BASE_TGP, ASUS_WMI_DEVID_DGPU_BASE_TGP,
> +			     "Read the base TGP value");
> +
> +
>   ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE_MODE, "0;1;2",
>   		       "Show the current mode of charging");
>   
> @@ -746,6 +800,16 @@ static const struct asus_attr_group armoury_attr_groups[] = {
>   	{ &cores_efficiency_attr_group, ASUS_WMI_DEVID_CORES_MAX },
>   	{ &cores_performance_attr_group, ASUS_WMI_DEVID_CORES_MAX },
>   
> +	{ &ppt_pl1_spl_attr_group, ASUS_WMI_DEVID_PPT_PL1_SPL },
> +	{ &ppt_pl2_sppt_attr_group, ASUS_WMI_DEVID_PPT_PL2_SPPT },
> +	{ &ppt_pl3_fppt_attr_group, ASUS_WMI_DEVID_PPT_FPPT },
> +	{ &ppt_apu_sppt_attr_group, ASUS_WMI_DEVID_PPT_APU_SPPT },
> +	{ &ppt_platform_sppt_attr_group, ASUS_WMI_DEVID_PPT_PLAT_SPPT },
> +	{ &nv_dynamic_boost_attr_group, ASUS_WMI_DEVID_NV_DYN_BOOST },
> +	{ &nv_temp_target_attr_group, ASUS_WMI_DEVID_NV_THERM_TARGET },
> +	{ &nv_base_tgp_attr_group, ASUS_WMI_DEVID_DGPU_BASE_TGP },
> +	{ &nv_tgp_attr_group, ASUS_WMI_DEVID_DGPU_SET_TGP },
> +
>   	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
>   	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
>   	{ &mcu_powersave_attr_group, ASUS_WMI_DEVID_MCU_POWERSAVE },
> @@ -754,8 +818,75 @@ static const struct asus_attr_group armoury_attr_groups[] = {
>   	{ &screen_auto_brightness_attr_group, ASUS_WMI_DEVID_SCREEN_AUTO_BRIGHTNESS },
>   };
>   
> +/**
> + * is_power_tunable_attr - Determines if an attribute is a power-related tunable
> + * @name: The name of the attribute to check
> + *
> + * This function checks if the given attribute name is related to power tuning.
> + *
> + * Return: true if the attribute is a power-related tunable, false otherwise
> + */
> +static bool is_power_tunable_attr(const char *name)
> +{
> +	static const char * const power_tunable_attrs[] = {
> +		ATTR_PPT_PL1_SPL,	ATTR_PPT_PL2_SPPT,
> +		ATTR_PPT_PL3_FPPT,	ATTR_PPT_APU_SPPT,
> +		ATTR_PPT_PLATFORM_SPPT, ATTR_NV_DYNAMIC_BOOST,
> +		ATTR_NV_TEMP_TARGET,	ATTR_NV_BASE_TGP,
> +		ATTR_NV_TGP
> +	};
> +
> +	for (unsigned int i = 0; i < ARRAY_SIZE(power_tunable_attrs); i++) {
> +		if (!strcmp(name, power_tunable_attrs[i]))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +/**
> + * has_valid_limit - Checks if a power-related attribute has a valid limit value
> + * @name: The name of the attribute to check
> + * @limits: Pointer to the power_limits structure containing limit values
> + *
> + * This function checks if a power-related attribute has a valid limit value.
> + * It returns false if limits is NULL or if the corresponding limit value is zero.
> + *
> + * Return: true if the attribute has a valid limit value, false otherwise
> + */
> +static bool has_valid_limit(const char *name, const struct power_limits *limits)
> +{
> +	u32 limit_value = 0;
> +
> +	if (!limits)
> +		return false;
> +
> +	if (!strcmp(name, ATTR_PPT_PL1_SPL))
> +		limit_value = limits->ppt_pl1_spl_max;
> +	else if (!strcmp(name, ATTR_PPT_PL2_SPPT))
> +		limit_value = limits->ppt_pl2_sppt_max;
> +	else if (!strcmp(name, ATTR_PPT_PL3_FPPT))
> +		limit_value = limits->ppt_pl3_fppt_max;
> +	else if (!strcmp(name, ATTR_PPT_APU_SPPT))
> +		limit_value = limits->ppt_apu_sppt_max;
> +	else if (!strcmp(name, ATTR_PPT_PLATFORM_SPPT))
> +		limit_value = limits->ppt_platform_sppt_max;
> +	else if (!strcmp(name, ATTR_NV_DYNAMIC_BOOST))
> +		limit_value = limits->nv_dynamic_boost_max;
> +	else if (!strcmp(name, ATTR_NV_TEMP_TARGET))
> +		limit_value = limits->nv_temp_target_max;
> +	else if (!strcmp(name, ATTR_NV_BASE_TGP) ||
> +		 !strcmp(name, ATTR_NV_TGP))
> +		limit_value = limits->nv_tgp_max;
> +
> +	return limit_value > 0;
> +}
> +
>   static int asus_fw_attr_add(void)
>   {
> +	const struct power_limits *limits;
> +	bool should_create;
> +	const char *name;
>   	int err, i;
>   
>   	asus_armoury.fw_attr_dev = device_create(&firmware_attributes_class, NULL, MKDEV(0, 0),
> @@ -812,12 +943,30 @@ static int asus_fw_attr_add(void)
>   		if (!asus_wmi_is_present(armoury_attr_groups[i].wmi_devid))
>   			continue;
>   
> -		err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> -					 armoury_attr_groups[i].attr_group);
> -		if (err) {
> -			pr_err("Failed to create sysfs-group for %s\n",
> -			       armoury_attr_groups[i].attr_group->name);
> -			goto err_remove_groups;
> +		/* Always create by default, unless PPT is not present */
> +		should_create = true;
> +		name = armoury_attr_groups[i].attr_group->name;
> +
> +		/* Check if this is a power-related tunable requiring limits */
> +		if (asus_armoury.rog_tunables[1] && asus_armoury.rog_tunables[1]->power_limits &&
> +		    is_power_tunable_attr(name)) {
> +			limits = asus_armoury.rog_tunables[1]->power_limits;
> +			/* Check only AC, if DC is not present then AC won't be either */
> +			should_create = has_valid_limit(name, limits);
> +			if (!should_create) {
> +				pr_debug("Missing max value on %s for tunable: %s\n",
> +					 dmi_get_system_info(DMI_BOARD_NAME), name);

dmi_get_system_info can return NULL

> +			}
> +		}
> +
> +		if (should_create) {
> +			err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> +				armoury_attr_groups[i].attr_group);
> +			if (err) {
> +				pr_err("Failed to create sysfs-group for %s\n",
> +				       armoury_attr_groups[i].attr_group->name);
> +				goto err_remove_groups;
> +			}
>   		}
>   	}
>  
Thanks,
Alok

