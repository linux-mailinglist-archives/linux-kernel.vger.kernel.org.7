Return-Path: <linux-kernel+bounces-723594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EDAAFE8E7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93531C48210
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D235A2D9ED8;
	Wed,  9 Jul 2025 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R+j53w82";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ys3bcGa4"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868532DBF45;
	Wed,  9 Jul 2025 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752063914; cv=fail; b=V0d5H8QhCgM9FKPQicVBHtapi2tOtoC/6N6EBo8p8cxSeuWDiVS5v5VXdR6DLlAy69Y1reZxKT/qv1G207/oTuFzMvrwKC6AFWfwD0DSKA5E2vcGKOQMhomJlAJDNN1RmlAa0BpgQmGd1Uw4emuFvDHj+NJKYEzXvxgAms7oWoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752063914; c=relaxed/simple;
	bh=Zwn3wroU1Ek1B6S/KJOTDSRStRd8FCWvPAxhWnjpOpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gzUNY8OJvnpamceiJ2XuzqmyWkFvHSHW47qUvkn3oy4GB9pxZyepvejz/F3OaNsZHZvAwTl7trGE2FM74ff2iBDvJRpHuXgjBTuvMB5FBV3e3LPdIPV4pQe5r5TDldxW388yKglMP3eOVcXsR5yIAZbE+P6y2jM/fvtCs2KKRww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R+j53w82; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ys3bcGa4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569AqEnD006712;
	Wed, 9 Jul 2025 12:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PGhzQ6kiLMgp4sSUqH
	2njYEERG9rdydvVDJTMdfnHH8=; b=R+j53w82qWqONha62/kvFJcAVp1dYQSYpG
	zdZhZFyLyRtI5uXVJOcOX/OMOF1jfJiojvoJQxv/LVfFZ+lRslD0RhYeNNZda5xb
	rGs9hSLQH3dv13c4RzJ9tsoUUBPCq67l3/w8tGJaEiQgfwRNne8aEca8sicf4ksR
	ME5ZDyun51QJmQ961/+pnaX+LReUlxahh59xWfHQs+pHkTZmuEEpcIrj6T9w4Hyh
	7u8hUoiou8dD7Op902mWkkxE2l6wCFCPXOqbhYTU63bqFG0ELDJKJQ83V1E8qF9w
	0DFY6DNPgbVe6zkpWjezLyY3TlbSO0l+XuMhKu1grYwzd97lb8IA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47sq1x04wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 12:24:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569BwXAM027080;
	Wed, 9 Jul 2025 12:24:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgawa7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 12:24:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9P5iU/FgWQU81rnCWPmGtJraOHxtfeCF8/mOw603SrKeq2rlLoHTS0aA5z7T7btXeDCuvdHSChHJp//ioDixkh2s5Y4d2Emacp76NBlLQf/gGLwlk3/RksW3BnXdJ/NWVPSUlsRT/D/HAZYcz6x5KeLLWCK4w4Yeis6LnFxLLRzZGTATNiI+lKGCerbOJg7bpPA6LIADIrfmLDtX+XPrX+eIyivBl/hOyO30aR9jkRJGGHDv/GL9/Yh0z370a5+UfvSlfUfS9yQyc+ILlycpoP/79uJHjXGxFT3urC0ARGVS1v0rYMA5coUTgTtjlxfsY0Ycb7vAzlbYjZzov9edw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGhzQ6kiLMgp4sSUqH2njYEERG9rdydvVDJTMdfnHH8=;
 b=Ejp0JmC6oAbntUF1d3jRu11iKj8y7zeuDWE/aVt78YHkmgppAkz339PHWAUs1z9p5iUlVEmnazMU15yjAmlrA1VKWfn2giECDbtRuL9A6l6eKoHHI8dY4rpqcwKzQvUKTcj6HB2kMvY/GzPVRa1HWFj865t2T3+l2uEfyEYJv5H6A8Zok9f8zXbrjHXht1Tt9j53TWLIwU6dFZnyMKDQ8+zDCvws9MqRVUUwWRSRy7qAv3czUysELF2CVluH/y/ULdYcKtU+OurOsX/A/KAx7Pbi8Iugy0RqRgdCBCyBAlFUxXs9RQOtfOGW7qxob0gA6BWpskF7IAJWy/XkoZrrlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGhzQ6kiLMgp4sSUqH2njYEERG9rdydvVDJTMdfnHH8=;
 b=Ys3bcGa4VKuu3gPqs5pYuKE+wcR2OgtilrvsCOAVvM6rxFa+21+q3fe9dgbyxgWpKg5RiaKwMOYmHrmmubbpk2TzenwS3n7hocTwxkinaIoKCd6Ng+eHcRdTJ2iJ4aUMSMGGPFJPuBvt1iO+PfBKuK/gmbZhczztj3ZCTM02PXc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5859.namprd10.prod.outlook.com (2603:10b6:a03:3ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Wed, 9 Jul
 2025 12:24:44 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 12:24:44 +0000
Date: Wed, 9 Jul 2025 13:24:41 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Vitaly Wool <vitaly.wool@konsulko.se>,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, rust-for-linux@vger.kernel.org,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [PATCH v11 0/4] support large align and nid in Rust allocators
Message-ID: <4ef38b15-727f-454b-bff0-4804299434f8@lucifer.local>
References: <20250707164755.631374-1-vitaly.wool@konsulko.se>
 <824065ea-1f5c-4cd4-9917-4b7a91882af8@lucifer.local>
 <aG0HJte0Xw55z_y4@pollux>
 <54fc10ce-c3b6-4571-93e7-eebfc538d0c7@lucifer.local>
 <aG5TE3oq1w1cSdOy@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG5TE3oq1w1cSdOy@google.com>
X-ClientProxiedBy: LO2P123CA0078.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ae54bb-6b7d-46a1-bb81-08ddbee39647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZZp0MRjRLsFV+IMAfTEq/mER/WUKV8hWT9wErwOklRyjtcXToSpPD46FLvIv?=
 =?us-ascii?Q?bSxtIHb9vwGxUl0ufKIsv2gM8lvs8NiKNTmBRz1+di2OFBFdQUAb4vOdniSe?=
 =?us-ascii?Q?LGxqxsJDX4CwgFEC8K16vRfSILZZ1ONRqOdjGRRTstko/u9RwH03qxwp0HXL?=
 =?us-ascii?Q?Jbk7i4BbE+C1QN1z4cl/TO7C6RP94X7+AHmPbGs1MuItFLSlquQsB31UVfYd?=
 =?us-ascii?Q?5MdjyTh46ycTil8Pnu9XwFFiy9wN/tP+pMIR2qLgi8V6e05reeq/U80N82V9?=
 =?us-ascii?Q?zDLodaNMIri9L/HPc4xXSsDw0y26rleyS/3UN3aMqU8WpiWVPjh3O5+yZTeJ?=
 =?us-ascii?Q?NroCNZvOt+CKAw5fgUAoMSw6AGPImu0wTgIqnHk2LZk4q/mYSQqD+hNKztyd?=
 =?us-ascii?Q?F0sL9p/+F/zKNBJILPVZgvphYoqGp0DpRgWwzaGX7HaRjJ1HeesN0vPciSaa?=
 =?us-ascii?Q?Xed4v3QTVhv6BybS8ys8OtGjR3DA2BVS5IrkglMBS9uewiUTdvSaHcmxeVYg?=
 =?us-ascii?Q?Vpi+TktaATEX+QPDs7NoezPXJGhjBtKARRVlPltUL5+sntYanzniCME6PJ/7?=
 =?us-ascii?Q?5oaLE3AgJpeWMIG4MEJJThd453Y/KEuSzOg2XAsER1liz3HV6fwt7lTQPsLa?=
 =?us-ascii?Q?DaIXZ4oVTGZnrBNdNMnWCP9zdrIEQkcFKd5ocQrxeUrRd1hkGsqSNTwxkA+F?=
 =?us-ascii?Q?QYtm6+FMzIQQqyDisho4pT/XUegYBi9dCWq9yNulybDFPLEkHOvOxDvBrd49?=
 =?us-ascii?Q?yqczJUiyfa70GuWbIif2JwOm4s2+PnJVvhe55+hdbxbOCJJbpvnZpNQQTUfj?=
 =?us-ascii?Q?329Asqe+hBg5LTk7f3VnTRz1KbczrytJnS6oYGN0orfweXppL/G6WHDbxktK?=
 =?us-ascii?Q?oBZ72D/KlsolubvI8QdhH4j0UBUVzwS1XLXJdbs0w4q+RdFiVndOPTrDWRx5?=
 =?us-ascii?Q?FDK9nE5ENKtapH/Tre5oxz9Ke92KjRw2PX3+iSAjOG2VHXxm+5N4MsLiuscJ?=
 =?us-ascii?Q?NEKyau1e5XClZLXGKKabNr9VuRbkIOtdFn+0+U4ymFJBhELfv0pQei0LxT9B?=
 =?us-ascii?Q?zKmHlFdn+bkbdHeRjkccyN1MCebnqH1N8Mx6JTA1ptVoUNG6BSz2xqLunPus?=
 =?us-ascii?Q?FR3pWQw3BtWfOiwNLbtWbsKWU/6iamIq7mTq/7lukV0TwiW3vQ+rbnsGouc3?=
 =?us-ascii?Q?ihRMlcQaDHrWcMVR9a9Cc4hT1AQUOAzO6/EnKcV1Bb5/8Ni0Sd3lRLlGXBvb?=
 =?us-ascii?Q?8qYlu8/jMMzYdYeq3gc6pbMmysTgpN+1Yq7gE1ODSJY08F7OHzXXIa5g2tE2?=
 =?us-ascii?Q?95/pY1WEW/u5TZAaE5zNeMojSfr3ftHlw3nDFRk6KSeD7KfcynFZa8EQGQ7o?=
 =?us-ascii?Q?1Z6y9wh3GbZFC9DmOMYkelwBGCby2wr7h9XIHCXjzjxLBtaMf/BjEQYnxZ9+?=
 =?us-ascii?Q?uVwpBUmX9ZY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JEPxcVojStQap0hr1LAHufb6bBfGOOQ74dPIQtU/jAZor+BNcQ7WvziBYLPt?=
 =?us-ascii?Q?Sd06ir4DorzKJjr3KoTUlR4IjJIhNAKkRVkn7ZP8fFQCudg5MQ3PzYEHc9SO?=
 =?us-ascii?Q?Fv5o0P6ljuaPbFQPjMh2kvocLRIAsllbQFZ1qNAoTdWwB6XT5mu15x3kj31A?=
 =?us-ascii?Q?wzVshSmV3Ei49Uqsn8zHroLpakcDyJRPUlHqW3/s2IzZ7dMvYfdKujAprjVw?=
 =?us-ascii?Q?D6CcoVYJxLPm3X6tNtzK6ZYGxEhasAU/AIWWEdX+zKgmq4QQtKi19CTwp1Jz?=
 =?us-ascii?Q?xlh54vQ5OgcpQ9REm75XaWq0vkfGztqTCV7g9jTstoJG7uHY14e9YQpoJDvD?=
 =?us-ascii?Q?S8NkU9iSpw0mnkFQPnUvrIUpELHih+VsMC1G/0gGLYtxKUpGmtrxNTmthxyR?=
 =?us-ascii?Q?ixwlHy+Jhlhw2A1XSEyN30B2rvxILXmFXeGAXR8WHVkwvoFmXLZ7Miq0ng5V?=
 =?us-ascii?Q?wcsa6ulMdZY+s3AP9o6dfDGtK7MMIeUbq0rLaahAPsi5agleW4NfJGlPz10q?=
 =?us-ascii?Q?lI3OO3jaE9b0u8Am11qTE/6Zn5swfiFZgXu3jz6VUReRwLmvHZ387Wps1ycA?=
 =?us-ascii?Q?blHKysPgZYV6nwh2Ua2qDZGkDQHHjRKjm/+VLkZJhIpwhkLJ++FHFImjUrLC?=
 =?us-ascii?Q?IxgEiPtqgXGtA81tGKLY9R/g4K1EMjzH4RxyBwhTOf72kQuUnaVuQZ70caov?=
 =?us-ascii?Q?uFC8oLwpkjII0Imz8Iu/nY1DVGoEXgtrxiv48OjT1mrJ3vGlytXbLmpT/mOQ?=
 =?us-ascii?Q?FXCJK806aNjY9ZF2q8sRD2XgobAU4eiPiZamOVyoezb4deLRHeimPkYmomqz?=
 =?us-ascii?Q?6JQ5TWYhOInHRuSmPGueQpjhomJOl5ZaKAPrdW00QD8RRZg6Jd+k4j/7wuuv?=
 =?us-ascii?Q?2dyiDxMj9uR2cSQufObkHi4jeEiL3sbZfu1pgIAGi+ZkOxvm7vf6RhuCLygf?=
 =?us-ascii?Q?bEvGCa5QYr2wrQjpsrnrfP9ShfkZU82RVqspWIb/4rCfxf/4xgfBONQglf8p?=
 =?us-ascii?Q?1hdZ/Fd+5/1LhJHcsmuVN0yezPvzBpa2I11HGmjxj8ssO/8mA4hCca73Rf76?=
 =?us-ascii?Q?r8zySk1IS+JQmSDD9H1beIofFEw6SM/7rB5EOnNFYyfTyohUax85DiESwLrv?=
 =?us-ascii?Q?0TtKATS9CRaGEq4n2P6IZb6iA9fIoMStuQ82AJxVOJHdBZPnrLgN2ZEOxI5u?=
 =?us-ascii?Q?8ws17hxzZ9x5oZkCrGlxnSXvSLk36OnYx6plYbJ8udQmMg/EAwMwnAi5IU/g?=
 =?us-ascii?Q?nlRQsAnZ06haDCI3IqrRqhX9C7PWai56EYT4BpY+scquVCuSMeJBEzUJxRRM?=
 =?us-ascii?Q?GTpFr7m+Ny9BAWGeQ3Mj43Q4mfHHhqRc7oUCwHDKsRrT+6MVN92gTlnY6Fg3?=
 =?us-ascii?Q?Y3KImQWIRO9xcEfEiXRCOh4KZCDhpxN0kzQ+3bz3WluXJlha8SpYqFREWrA2?=
 =?us-ascii?Q?i5zQ88hXW22QtQamAUG2ChkDloQjZls/OKNyH7Jx7VjIt0WBW2nWlI48Wu7k?=
 =?us-ascii?Q?U9qzRRPvivhyDkSezrR9MzQvrSU6wnVsl42xjau907kvwrWg8wOu5L7BNsJM?=
 =?us-ascii?Q?cOBIXMeXM23FcYEZZHuQtVTWALnnxrZJjaRlPlwPM84gNact9VEITmGGceWg?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jrwiGdTL59AAJtHV3MS7EnqNXYig+Cc33D1xlH9ksgFUwOb7qkXLGGHX+9RLp439Pl1Q+IKRh/YNm3022LDqEurFFlkifQh9tp0qwRhric9z/N2lLpd7W5CjUFh4/GZAnN1cSuafm0kNFuoHZNNa8DskeZZ3OflLrUEsuNTZeRjVjUk/E5EM/1VJ71Ufb/SoTOnplBr0H7Lr4RqlgoZQ7MLaohtGQqsVya43wGrT9WPJf4Ij5aMj/CyOGW4NBHtdX3DVLTQs2sgK/X8TI/NwxXy+qH1k58ansbUSd4LSHwAWRMvokKmakTzVJsU67zR9ZzEmjS/xVjFGSWF4kI2LZnI70FqntCYE+S1g58pbf0tcZW0EnQjSMUjKgpbWL6PnHLqEJCFTRdup4wPB/rQKZ7ck1l79lZ0Pkvlf/FmkN6RcimGfr9ydOT2ecz7uoGTENfR2Xz4hSZUdZ3CIF7AnkdnPuqyXtOWy7aIxM69SfVRZ4d/g7ESi94EL80X3R//LkeTvLyV214O7Lfyuf2bCpTKFGY6GkiWZM04YPp0YZu/1BqEey43PuToINJPho/9xRJdAlbsfkjbTrXbYU4TgW7LVLQbbMetImF+u9+vJX1M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ae54bb-6b7d-46a1-bb81-08ddbee39647
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 12:24:44.6544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8+1duT5nGDTWN4L+saj+TCjiyJfLyhuGx82dAMsKQGSNWDH1gFjM4WpJ5vZRM2M6IuL3+YFSVuFtKQ5SLsfOBZIuzhtlG3RWFfgNHeMrnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5859
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=717 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507090111
X-Proofpoint-GUID: JpGT73A-4S3Hb3PohW4bwRDoBBxSOQmx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDExMCBTYWx0ZWRfX2q/b2YgDMggn fcTaJ0HN92wjkN4b8bB/4/olLSd5KU5yoZjPsLi+lem4yWvFEEdXtjkktO3J+bVFX1gwwxEtl6e zckYldX7MebRa2WR1tjMVZYd0MmZPuVEuNnsZnUxSrRF6bAryYp8r4dhUB/ky77HMQTXSQIK+xc
 B7hTqRTI84dorJ0B93j9/iJk4y7y/hSaDF08jhfZbNwOD7CxybQGDmHpgmtbsjEAJ3LhZKb6afq lP3bAxOEAspf9QsmMItWQH0fila0ZR8KRbJMhtSoq4oR8i3n0jlbCQ6uMwaEh9kEiENONxkRoI6 Ew7VLT77bI2EQv3FJNYMB42o8J6QMFa9NeZ2yIgMvwAef9CLTaKxRbW8ui30zaxi3Emkc8s7R2H
 2YnskeOOL4U/q5fQ9/Qgzi16K0K6pu3NGQ2fflGcF/7rgpgdPFlqBe3qg+bnepI/7Q7qLRPl
X-Proofpoint-ORIG-GUID: JpGT73A-4S3Hb3PohW4bwRDoBBxSOQmx
X-Authority-Analysis: v=2.4 cv=RsnFLDmK c=1 sm=1 tr=0 ts=686e5f90 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=ITTQ9m7d99Q1d0iBuE8A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12057

On Wed, Jul 09, 2025 at 11:31:31AM +0000, Alice Ryhl wrote:
> On Tue, Jul 08, 2025 at 02:19:38PM +0100, Lorenzo Stoakes wrote:
> > On Tue, Jul 08, 2025 at 01:55:18PM +0200, Danilo Krummrich wrote:
> > > On Tue, Jul 08, 2025 at 11:58:06AM +0100, Lorenzo Stoakes wrote:
> > > > +cc Liam
> > > >
> > > > Hi guys,
> > > >
> > > > We have a section in MAINTAINERS for mm rust (MEMORY MANAGEMENT - RUST), so
> > > > it's slightly concerning to find a series (at v11!) like this that changes
> > > > mm-related stuff and it involves files not listed there and nobody bothered
> > > > to cc- the people listed there.
> > >
> > > What files are you referring to? Are you referring to:
> > >
> > > 	rust/kernel/alloc.rs
> > > 	rust/kernel/alloc/*
> > >
> > > If so, they're indeed not under the "MEMORY MANAGEMENT - RUST" entry, which
> > > so far seems correct.
> >
> > Looking at these, they seem to be intended to be the primary means by which
> > slab/vmalloc allocations will be managed in rust kernel code correct?
> >
> > There's also stuff relating to NUMA etc.
> >
> > I really do wonder where the line between this and the mm stuff is. Because
> > if the idea is 'well this is just a wrapper around slab/vmalloc' surely the
> > same can be said of what's in rust/kernel/mm.rs re: VMAs?
> >
> > So if this is the rust equivalent of include/linux/slab.h and mm/slub.c
> > then that does seem to me to suggest this should be considered an mm/rust
> > thing right?
> >
> > It'd be good to know exactly what is considered mm rust and should go
> > through the mm tree and what isn't.
> >
> > Maybe Alice has some insights on this?
>
> The Rust standard library has three pieces:
>
> - core. Defines standard types that can work anywhere. (such as ints)
> - alloc. Defines standard types that require an allocator. (such as vectors)
> - std. Defines standard types that require an OS. (such as File or TcpStream)

Ahh this makes a lot of sense.

>
> In the kernel we used to use both core and alloc, but we switched away
> from alloc because it doesn't support GFP flags well. The 'RUST [ALLOC]'
> subsystem originates from that transition from the Rust stdlib alloc to
> our own implementation. It contains essentially three pieces:
>
> - Two data structures Vec and Box.
>   - The Box data structure is the simplest possible user of allocation:
>     A Box<T> stores a single instance of the struct T in its own
>     allocation.
>   - The Vec data structure stores a resizable array and maintains a
>     pointer, length, capacity triplet. There is a bunch of logic to
>     manipulate these to correctly keep track of which parts of the
>     vector are in use.
> - The Allocator trait.
>   - This trait defines what functions an allocator must provide.
>   - The data structures Box or Vec require you to specify an allocator,
>     and internally it calls into the allocator to manage the backing
>     memory for its data.
> - Three concrete implementations of the Allocator trait.
>   - These are kmalloc, vmalloc, and kvmalloc respectively.
>
> In my eyes, the further down this list you get, the more likely it is
> that the patch needs to go through the MM tree.

Thanks that's a really useful explanation.

And makes sense that the closer we get to the underlying bits that provide
the actual memory used by all of the above naturally we get closer to core
mm stuff.

I think the implementation details of all of this, looking far into the
future with rust doing a lot more, do end up constituting essentially mm
semantics, as if a decision was made let's say (for the sake of argument)
to - rather than use kvalloc to back an allocation, introduce a new
heuristic that determined whether to use vmalloc or kmalloc - then of
course this would have a very big impact on how slab/vmalloc allocations
were done in the kernel.

Overall I think the approach we're taking - simply adding some mm folks as
reviewers to 'RUST [ALLOC]' - solves the issue wrt being aware of changes
in this area without too much fuss.

>
> Alice

Thanks, Lorenzo

