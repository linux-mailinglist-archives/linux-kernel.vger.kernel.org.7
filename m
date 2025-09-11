Return-Path: <linux-kernel+bounces-811724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711E5B52D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D9416A403
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1F12E9EBB;
	Thu, 11 Sep 2025 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JIWdXg0f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d+DDPYT/"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285242E8DE1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582456; cv=fail; b=R94wUis2+MGzmF2ASa0uaAR3H5I5nU5uHvhfyOQPh2qNdP3aRWDeAbtUAonuKfbsbgCFzGdXP30AReh9u1p+ffoSve7ICMKNOkco7kuEh3lIL1OTkmS2mEu9FYqwJ/wDopEGeX7oWYtrz0evS6y18wzwJ/MsectdJI3W46Bwow0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582456; c=relaxed/simple;
	bh=0flRyo49gVdLYkNB/dksKzZULEurYp2L5oKfzCj4aP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sgv7H2V6WSDEsWxXrcMc3qnP3x+wE2RrMBIVQ+aee59Ak0eMClQu6Tmi+4iGdYirmpyvtc1C95NJUVWEXMOxJmx2oY7it/cNg/RZYtpgY2emHTZLZcBYjsm/hpwu4kiRqz9jotsX+u6NP7wtWe/yCwJ63r2XOx3q0NjMQS/MgxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JIWdXg0f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d+DDPYT/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B8gsjM016096;
	Thu, 11 Sep 2025 09:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=aLOUkN0hrB6D1lmuXm
	gDjhV6/PtbyiLyW29PNXvepLo=; b=JIWdXg0fYqdVy9AUxFz6Er6VHnVXDRRKPs
	VzPN2CrI5+TwrfHlV9jIXzS2E5R60FRPjnDFPF2OpeS47+caRXyOVLerRpw//cfs
	8/DNUK+O0qbBJj8KI8O7yIDdQU4Q34nColYDb9WVCsjmsjnO92I3hLLbKllBngkz
	3jAvFRfaF1SUw1jKYFm7k8e8UVuEnU4WHAAijxt9yhWCTWYcgMT42Drb1La6PqA3
	ACLJ6nfxEv8+NRLNh8DEiLkDSQ6UJFf55U0/QAt+KZJQXrqwdGuW+imDj/5hafmb
	JHDqhwN6sjb44n8xG66DZzKbbibWWRW1ECQdXeEFdAUn6HzF2LCw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922jgww0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 09:20:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58B8cI1T038759;
	Thu, 11 Sep 2025 09:20:23 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013023.outbound.protection.outlook.com [40.93.201.23])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdc73kp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 09:20:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0frjtrkMtBhGqftY3zV214N8FxrzdwsvkfcaBVM6gPtFtZNDHldU0futrr/PPnykB7I53IP2ceoA9buNbrxpoe+LroiYBnM84LjCRdIbhGdh1i3V+QcbS96WCVYroSlkqgyM/WrAfqI6TfFyhhz7bywhd7ruo/wPzpVyGSK9W3YWPBgYFbsVrsrLj7HFm/SSNU3hsuqRdAMB+UQr6LgfkY4MoZrja3c1dpqLhNTAIbxg4O+vSHoTcrMiseCcdqwKXd3OlzX6CGp3KrH6lSNNKb1i3QNqByEfDzd+TnpSFK1tLxq0owtV6HTpr2u2NTB2U1PMeo1JAaWXPkSkmkYbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLOUkN0hrB6D1lmuXmgDjhV6/PtbyiLyW29PNXvepLo=;
 b=iF6ZGN3wv4o00AW4CVyrsduA8XSKvC/V7skvZKKXSW5+Dq8k4kzIjio1lPO9847c2X6+1rXh45aYSuex3nGAk48edDOF7QaoO8Ju+NyTz3F6uS24iFPsBGQYSN9N0C2XbXC+ysZTwkGcE1qTeArmoSRjUo/ls+ayWlA5CCbKljgMYe6LSvl6t/TjA1Z0JEuFwmJGu08JTHB8YZchMJezgx2uUwWt47ulZu8LTZhyeFmLgll9e1jF/bn2tTh6ByhEzDFhcU0BMdtfnLOXddMuL81A3QNOnHH2tMQHLW6+K0DlkBze3X5alC72NBWZuTWegT/3pwgu70ZcyBuJMrq4DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLOUkN0hrB6D1lmuXmgDjhV6/PtbyiLyW29PNXvepLo=;
 b=d+DDPYT/wjaE24Jg1GL8UEHKwf+vPV2A0KIij9tAFs6iEPV6XTbb1diMMjditsN1naPXOA42dm+JRFzA3iq7i917tjIk1Eivn6eTZcbB7diH/fgSiwMwxzO2NofHA49LZd+h7S9I82br02EQiLhFN8s7DgppjARbjdNxLWkYl74=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF1F8A3E3BF.namprd10.prod.outlook.com (2603:10b6:f:fc00::c11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 09:20:19 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 09:20:19 +0000
Date: Thu, 11 Sep 2025 10:20:16 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
        bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v1 7/9] mm: Introduce unmap_desc struct to reduce
 function arguments
Message-ID: <8102e84f-a12b-4e8b-9e24-99e2e9bc112d@lucifer.local>
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com>
 <20250909190945.1030905-8-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909190945.1030905-8-Liam.Howlett@oracle.com>
X-ClientProxiedBy: MM0P280CA0091.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::29) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF1F8A3E3BF:EE_
X-MS-Office365-Filtering-Correlation-Id: f99bb4e7-1a32-491f-e433-08ddf1146d6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JqbTqoKn7r10vhLMkljmZpiH4DG3R5rFveiuSgHZ5R3thyTzc8D0aSjhQgMe?=
 =?us-ascii?Q?F821aPAetSPoUZECTy7qIOS4FXkeWipAJj+W7FSpNo3EWLyD2OCjPgnoex2Q?=
 =?us-ascii?Q?3To2pQ9J8zq+ho7G76fmw5XB3ypvlXsyA/kSXyGnvRBZnJCJIpSQXCdCyO+w?=
 =?us-ascii?Q?HvTOBosZ5HL1wrMVhYQBwUGbc4hvyE87gHszqhGnPOnuS/YbzGRaN3H9NlxU?=
 =?us-ascii?Q?YUoInUqHvIcWAyJeJMOytpRtW3tXIgQOe6OBGs6mEX2htIVEkX2AwtwWCVUQ?=
 =?us-ascii?Q?nP0BywsgGrIDzDwdl2mxKVthIQqksOx2tlYCCFUcPQ6yzz9Upm8sUZ5adYwt?=
 =?us-ascii?Q?UJ23ujySCM2s3+KzbPxXBc8KA/uiFQwyMVTxBg/5+fxQzZAs3ExnGMsS0dWg?=
 =?us-ascii?Q?xcn19cNhs9rasGGOI7/8VdtsvlqcfWNDcMY8Ar8YgiSOzbzM5cSrvBU0vshU?=
 =?us-ascii?Q?PGYITPORbtkHnb7RHek6DnngIMROnTxqv+j66ddSQ2aRpQmlKP/iZCoKXW8w?=
 =?us-ascii?Q?jXheh/y2q7eA+V41Uf3YaM94ySw57/Cwv76CrSgxGxB0iWKhEH3d8rwBPCLe?=
 =?us-ascii?Q?8VYRAZ4P6i06jJqU4v1QVFBmmDolrQsEGuzdPHuRiyIDZLAd6vYe3mk9H1bF?=
 =?us-ascii?Q?v4MYMqapsYLFHWaq6J91CW1ZvTHEQQnrTNb9P3fBV4mDpKtNShRIx+GGIzej?=
 =?us-ascii?Q?J0FlzbuCqjZyFJCS1Jc4H2I+ekI558flZmQIefe577T/FMGfMqLJYXVz79Bi?=
 =?us-ascii?Q?U0fj10oaMgx0GsZ1Yd2jRGzycBdGBday9d2ZQ7O4d1bweA8tc1UDLY1DxA/o?=
 =?us-ascii?Q?iJFg997kLTQc5O895aK3TWHC3GSQ7MOoyfcWlVaQAD89ajR+0XEm9IMBfnIT?=
 =?us-ascii?Q?F8v7Tk3fj9E9B000kxNxvKS6WTSsREBifb9uHxzbbx3psTnii6zeoaWEoTSY?=
 =?us-ascii?Q?lP3+eVU/QB9KmUflQMrTXRt8hvzQi6OuVz1dQKHdd4m4d+9kMPweH6hnBtt0?=
 =?us-ascii?Q?0LmUxF5evACKX6sHxE08Ra0onJHZCsvuBwZYOYCIxU+MllSncrt4/JnhRCGi?=
 =?us-ascii?Q?IL8rmgmZsTGEoh8OVDdr/7xbIbFj+fuTLazB0Ceqrg3BWUfnviIWBgUmnp8w?=
 =?us-ascii?Q?CW7anpXcMuePWtJwYJ9FV4Jh+r/XpjWxswluQEio0lua72agygDToRmh/cg+?=
 =?us-ascii?Q?G9NP0JKsqR30w4kaRVHB+eWEhYpDzEhx+s0RCN67pV0bkFHssF9p2GmKVfQe?=
 =?us-ascii?Q?INnUbrNIsswOrftfQMczL8igXFZcA7+LOLrZN4ezvrWBVGKVnfZbwXQZy3zZ?=
 =?us-ascii?Q?K5/bxTYigIW+ip9L7KRCUhdKoDQg5MDXTiNoNkcoTiw1qVje5a9jgQdBrxrr?=
 =?us-ascii?Q?KLF3IjBNY6FQnldPZqUgYFUnFtZCndxNt0DGC8NsoCfJlVPxrjynZqyPjltp?=
 =?us-ascii?Q?YVexRLIc1VE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hnyh9pMBSmD46l8rR9+jyEwasWQvHcBhq/Yc1MZ1S+ePOHDQ8glhTcwaOWBl?=
 =?us-ascii?Q?BlqXp7XghCn7O/FgGcBhezg7aOx+aRutnMW8FOrMfoDQS86pRozMU2CpHRID?=
 =?us-ascii?Q?CkpD4exev3f90Z4ldk55bNTVgxX98jB2A4JJdGSSkcF2/YuoXcsrwCM1Hnxn?=
 =?us-ascii?Q?LdPtiL31CpAy7cKopZ3wCL/B/hg5u/sr+Eg2r0bblL3sAniD5ieHWaS0nDq8?=
 =?us-ascii?Q?SsDSm0PdXnbDwiYYW/398C1xfZDRZD4PZY1P8K8GKDrxwol2bQOrBy3wqdDk?=
 =?us-ascii?Q?R6VOMIW+eV73iJ9V5fsPHh6XBkBqZz0XaH9A2Hj13yra1eMZt/QGxOxrXlhA?=
 =?us-ascii?Q?8Ta+dAOJO+GvQZnTMp8q5tT8JaUVbtmg2Ogr7tCZVod2q1SjQidDwRPbWZTv?=
 =?us-ascii?Q?7FlzcvETcXY57quHCvcRKPTLtcay6qSUke1KAefvKyXr1dsGpZiHrFpYxzJS?=
 =?us-ascii?Q?LBKY9OKziHs4JW2eL/zy1BaxW6D9xRrTmmaLQX/YSOtfNw6f/PafFnar69lR?=
 =?us-ascii?Q?wfv5DHMR7+FCr1PiyCv2yB7k3TShUtkYIQQ7Sef0ZI9enDXRi7mn5NTWLDAX?=
 =?us-ascii?Q?cyiXcWQ0ovDMg5OKcz9tDqGKS4Ck1kMQ2B6LLyZVtFoHuk4sLutitrg7bHRl?=
 =?us-ascii?Q?MkP8sMeK3WX2S13tSaRG9HUIBo4jwyNa93/A70R0JuFYwOT3IVMpt917EIat?=
 =?us-ascii?Q?osEFxK0FhSWMUOqtP9O5hy6NVd9SP7e/tMWA8SEqtslcDnJvHcnE1So+vLVJ?=
 =?us-ascii?Q?dD/h2D6mhxaNW7etOClBOXmr/laF/nhrPz0WXe2N4blZ6zL1kf+hLtW59o6Y?=
 =?us-ascii?Q?k0jkR94SnejUcPYnQhTevYCNDcBn29wZCYkp+TmyLINw/yjrQHg4fOC4Rhzp?=
 =?us-ascii?Q?CpTB//9s9JWQDPF5/T00VaxartMIlmmZpd4s7naf68H9a4Dv0HktNCVxe1lb?=
 =?us-ascii?Q?AQ3xBeG9wDIQ5EeAuJXf5EazQp3LmTNAs4OGRx42IhMj8/xhmSvRHSgwPJlB?=
 =?us-ascii?Q?4Vsub1pjfCpJ+xvYrwqx9rKdxPPU6I3jTG6KqgQFj3d7Kgs9/8kdad8tvpPD?=
 =?us-ascii?Q?d4UTjNWiNhP3pKtVcWRFN00y1XLPZzcyOzM/RFY1MbQNYGcgWDPqkch54b0b?=
 =?us-ascii?Q?1vcTujxiWLC3Uey+/O3J4Ce9qycOYyPH5vSJFFhk3A2HMIxXl1y7KCKhZXTR?=
 =?us-ascii?Q?7h31AnGInSdTvZmQkGmlauWW0IngL4fKFS50KJ+WcAezAfOPZnmmlYzPpXsE?=
 =?us-ascii?Q?0eCuC1yJ1S6ZwEmEbTzX7R5UL+XTugr4VpLlRBo+dbw8TcGQqbkoXBNmQw9n?=
 =?us-ascii?Q?N9SgH+ARagl7ehFAN0PgtAEunCm4EpS/olaq1dgN1rmK8T4cnghJ5aCJHwZR?=
 =?us-ascii?Q?8kkpLsNpiSa9e9brKMWhcY3CZy/+9ybRytxtn+L7rd3HQMDNqM8EHAVqpHFt?=
 =?us-ascii?Q?DMa2QC1jFOP+Uaxcrv1V9CBkIIkmgxYzLGUE/j2ZCjdkkfiMeeDmew5Srsp7?=
 =?us-ascii?Q?UqPfpkrZ5ef/hPBdj5QNfyBhpOFwNUPh6k2ItwEx0PIqG5EvHgW+zBGXFN7y?=
 =?us-ascii?Q?fJX75+YzeVCl60kaAfXWzbb4kcEQYDKVXqqfHnyYUspP2AfikH8Z7pzw/v6Z?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/zSoVnAYnGOVeOju2V6i5vLvoobof6FBnCYbmHHFADhLcAO+V5jTF7vQ29+ELgrcuTDAmpAAHerM+fTCGhrBTXacEQ6nCVf8MtKLiCI2IaPH9NQl3Jy13JOTBECd0lrepx+EaGh72SseZeTjPsKs9LRLKLksNAT4/3b/F9peTzlsaUp1CxKH0PihJNIGGS3CFEvxCXN8Xm5UnR8TbhSf9LOu/7LagV6K9GefxmNxmFkL46GOgbZdr84HrdgDkeYSvVPsPtKR1BPzRAHwFxeAXTLvzJBJN+bWN2995huQNpMZp35VqgzF4DZNNLYeBygXnTGQ8pSkcYTu2jWLCwtTdJ7fZ4oAkK8WEkCmjslOeQ12xXPfs67X/QzZ/t4tuWV6RLMS6KyGu2kS2enk9jS8naZGzs8/0z4rS7OwrIWVkmCpicYY5NqPl9DZ+SDc3TnI9gVw/pqpRIPbNDBOIxJXnQZM4QLxW9I1yuv0WNjsMGX5QB4+QALWy37SaGT52GcS27dmzVinHlrLp3t9Q2vzq+sqXo/TFMazA4HFeMVO4ceLKrafK527uhm5+2gN8KL6U0lpBs9ns+kdJogeQlTvT0429h6FJ+kKk1mtAU+g5aY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99bb4e7-1a32-491f-e433-08ddf1146d6f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 09:20:19.5223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HAc5+vTFqDbPVZm34mAbvcVbUra0s9MvGS+WEsFpILfUit/BqKWxu74y45sQnEyrczdpR2p1+J4IpLwmDXEbn2u3x5uVZmgAxKMJXMV9Jkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1F8A3E3BF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110083
X-Proofpoint-ORIG-GUID: IeQQFoRDFnmzW1YhSmQN6VHFd7x_fZyq
X-Authority-Analysis: v=2.4 cv=PLMP+eqC c=1 sm=1 tr=0 ts=68c29458 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=M11uUvSNW0UJzSJwq68A:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12083
X-Proofpoint-GUID: IeQQFoRDFnmzW1YhSmQN6VHFd7x_fZyq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2MiBTYWx0ZWRfX/TThZ8t3QlxA
 sgFhPJAL2LvEzFtlyVjoQcxsC44z8nd+VTC1b4YH+2LyXAUph1gI0+1XNUKwNQRPG3g41O+zi+k
 0BnJLYqjP7Z5TbFYacV1V/FHNtY3sstHy3xbaavEWLkyl+GDOepC0Zsdd41c3v2mYT9QkulWXNp
 rFA74Kcv+CCQi0JJnjecCtZcMopXYXDhqAg+HU8w0aURbyZcicr+YGSTJambgvgaXkGO8ohvM91
 yKYoC3RDptmI6LrAy9U+94M6jRv6crYwobaY5ai3ZIv1rwiDHoRkOZODptThhJITwQw0CFqegHs
 aOvZY5a2/LGo96Io6E0O2GWXcKxyt9+Ey5P9SB90rc8IiFgwqvyCHI2bY09IYJral/DCXkyTPMQ
 yaFN6IbolVBC+Ksbaj+bZCGiZPAfCw==

On Tue, Sep 09, 2025 at 03:09:43PM -0400, Liam R. Howlett wrote:
> The unmap_region code uses a number of arguments that could use better
> documentation.  With the addition of a descriptor for unmap (called
> unmap_desc), the arguments can be more self-documenting and increase the
> descriptions within the declaration.
>
> No functional change intended
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Apart from bikeshed below, LGTM so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/mmap.c | 12 ++++++++----
>  mm/vma.c  | 27 ++++++++++++---------------
>  mm/vma.h  | 35 ++++++++++++++++++++++++++++++++---
>  3 files changed, 52 insertions(+), 22 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index aa4770b8d7f1e..5c9bd3f20e53f 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1883,11 +1883,15 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
>  		if (max) {
>  			vma_iter_set(&vmi, 0);
>  			tmp = vma_next(&vmi);
> +			UNMAP_REGION(unmap, &vmi, /* first vma = */ tmp,
> +				     /* min vma addr = */ 0,
> +				     /* max vma addr = */ max,
> +				     /* prev = */ NULL, /* next = */ NULL);
> +
> +			/* Don't free the pgtables higher than the failure */
> +			unmap.tree_max = max;
>  			flush_cache_mm(mm);
> -			unmap_region(&vmi.mas, /* vma = */ tmp,
> -				     /*vma_min = */ 0, /* vma_max = */ max,
> -				     /* pg_max = */ max, /* prev = */ NULL,
> -				     /* next = */ NULL);
> +			unmap_region(&unmap);
>  			charge = tear_down_vmas(mm, &vmi, tmp, max);
>  			vm_unacct_memory(charge);
>  		}
> diff --git a/mm/vma.c b/mm/vma.c
> index 4c850ffd83a4b..c92384975cbb2 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -473,22 +473,20 @@ void remove_vma(struct vm_area_struct *vma)
>   *
>   * Called with the mm semaphore held.
>   */
> -void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
> -		unsigned long vma_min, unsigned long vma_max, unsigned long pg_max,
> -		struct vm_area_struct *prev, struct vm_area_struct *next)
> +void unmap_region(struct unmap_desc *desc)
>  {
> -	struct mm_struct *mm = vma->vm_mm;
> +	struct mm_struct *mm = desc->first->vm_mm;
> +	struct ma_state *mas = desc->mas;
>  	struct mmu_gather tlb;
>
>  	tlb_gather_mmu(&tlb, mm);
>  	update_hiwater_rss(mm);
> -	unmap_vmas(&tlb, mas, vma, vma_min, vma_max, vma_max,
> -		   /* mm_wr_locked = */ true);
> -	mas_set(mas, vma->vm_end);
> -	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
> -		      next ? next->vm_start : USER_PGTABLES_CEILING,
> -		      pg_max,
> -		      /* mm_wr_locked = */ true);
> +	unmap_vmas(&tlb, mas, desc->first, desc->vma_min, desc->vma_max,
> +		   desc->vma_max, desc->mm_wr_locked);
> +	mas_set(mas, desc->tree_reset);
> +	free_pgtables(&tlb, mas, desc->first, desc->first_pgaddr,
> +		      desc->last_pgaddr, desc->tree_max,
> +		      desc->mm_wr_locked);
>  	tlb_finish_mmu(&tlb);
>  }
>
> @@ -2414,15 +2412,14 @@ static int __mmap_new_file_vma(struct mmap_state *map,
>
>  	error = mmap_file(vma->vm_file, vma);
>  	if (error) {
> +		UNMAP_REGION(unmap, vmi, vma, vma->vm_start, vma->vm_end,
> +			     map->prev, map->next);
>  		fput(vma->vm_file);
>  		vma->vm_file = NULL;
>
>  		vma_iter_set(vmi, vma->vm_end);
>  		/* Undo any partial mapping done by a device driver. */
> -		unmap_region(&vmi->mas, vma, vma->vm_start, vma->vm_end,
> -			     map->next ? map->next->vm_start : USER_PGTABLES_CEILING,
> -			     map->prev, map->next);
> -
> +		unmap_region(&unmap);
>  		return error;
>  	}
>
> diff --git a/mm/vma.h b/mm/vma.h
> index b0ebc81d5862e..4edd5d26ffcfc 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -152,6 +152,37 @@ struct vma_merge_struct {
>
>  };
>
> +struct unmap_desc {
> +	struct  ma_state *mas;        /* the maple state point to the first vma */
> +	struct vm_area_struct *first; /* The first vma */
> +	unsigned long first_pgaddr;   /* The first pagetable address to free */
> +	unsigned long last_pgaddr;    /* The last pagetable address to free */
> +	unsigned long vma_min;        /* The min vma address */
> +	unsigned long vma_max;        /* The max vma address */
> +	unsigned long tree_max;       /* Maximum for the vma tree search */
> +	unsigned long tree_reset;     /* Where to reset the vma tree walk */
> +	bool mm_wr_locked;            /* If the mmap write lock is held */
> +};

Nice :) comments really help this be self-documenting also.

> +
> +#define UNMAP_REGION(name, _vmi, _vma, _vma_min, _vma_max, _prev, _next)      \

Not to bike shed, but I we already have MMAP_STATE() and VMG_MMAP_STATE() for
instance, so perhaps UNMAP_STATE() for consistency?

> +	struct unmap_desc name = {                                          \
> +		.mas = &(_vmi)->mas,                                          \
> +		.first = _vma,                                                \
> +		.first_pgaddr = _prev ?                                       \
> +			((struct vm_area_struct *)_prev)->vm_end :            \
> +			FIRST_USER_ADDRESS,                                   \
> +		.last_pgaddr = _next ?                                        \
> +			((struct vm_area_struct *)_next)->vm_start :          \
> +			USER_PGTABLES_CEILING,                                \
> +		.vma_min = _vma_min,                                          \
> +		.vma_max = _vma_max,                                          \
> +		.tree_max = _next ?                                           \
> +			((struct vm_area_struct *)_next)->vm_start :          \
> +			USER_PGTABLES_CEILING,                                \
> +		.tree_reset = _vma->vm_end,                                   \
> +		.mm_wr_locked = true,                                         \
> +	}
> +
>  static inline bool vmg_nomem(struct vma_merge_struct *vmg)
>  {
>  	return vmg->state == VMA_MERGE_ERROR_NOMEM;
> @@ -260,9 +291,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>
>  void remove_vma(struct vm_area_struct *vma);
>
> -void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
> -		unsigned long min, unsigned long max, unsigned long pg_max,
> -		struct vm_area_struct *prev, struct vm_area_struct *next);
> +void unmap_region(struct unmap_desc *desc);
>
>  /* We are about to modify the VMA's flags. */
>  __must_check struct vm_area_struct
> --
> 2.47.2
>

