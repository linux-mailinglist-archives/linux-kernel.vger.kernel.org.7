Return-Path: <linux-kernel+bounces-737260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C3DB0A9F3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49BF116B596
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BD62E6D3E;
	Fri, 18 Jul 2025 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B7Mv39cb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r+HV2Ala"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68F32E36F7
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752861956; cv=fail; b=reeGeGjM3ZquHVNpcBNTPOzaCB7PSOM+4d+YnmW+bzN5BhAzH8Oezsbdhib+G6DWiWhGBiZwEe+lSUNFTU+Nxo52GhjOoR+6/hppWfNm9LfL1lulyBhVTvOO+cQDvSyUcfjE8rYUlDjruCondRM/gW876lscF4tOU6WZjY7XQ6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752861956; c=relaxed/simple;
	bh=9RoouWHwBnX5PEBTOUH/llbXxYr50THe1qdC1UTEdkc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YgaUVzmvxCQuEHBiKD9GMmoGJggwbapVuqjASQ5dTgFu8mnywy4dpQiOEG3doEc0Cit7GSp/Aijn/rnZFrX49ClMPGjEtpWM1a4QNguySUv8UriYGoD/daQSFdKLRUuHpDryYlXkcNW9aqSQNF12uMp5hsIQeyXUFEaXOxEg2qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B7Mv39cb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r+HV2Ala; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IHHjPt031774;
	Fri, 18 Jul 2025 18:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=w1PDv9i9k+bux/le8NPsSw+72CVbWWotVrGxMcMrhEs=; b=
	B7Mv39cbShOAH2yEuFBnTvCjSZ33sJXHZg24eirSXpmTlmNntBQ/xPhLqrlDKjip
	7GeP8lZOkwWInv0Aar0ZE89Ik/vuDGrVzOteBVBYnAcFKd9aGTkynnHHkWK/sHVY
	dl2uyF2T+3VuDNKzPfC+dqgRA3k2sqEg5xpuBFN6DOhGisDqgG6YPoj90PdkpPWQ
	vsMRvuGGe1zRqt1U83KOxqA1gQeljzC+DJLwM5Z6G2+V3PZ8kHZqNaKjBsZJvZij
	fJcbx2/oa+oEpudIY7F2SRO0DM1o8lQ86HT9EqUmFUe4PtdbFMjMmbKC5drB8zSI
	8tpEf/fyIwL4dtKwVuoGdw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk6759s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 18:05:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56II4Vxx028968;
	Fri, 18 Jul 2025 18:05:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5e2myy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 18:05:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRbJEe+iyh4zFK6SJkafrXlJ286dfYwPOCfMBYJgfLOwp2SYLY88huei/mh0tzn8s4S9urzWTuESPbbY5NYfeL0gtUY+ZqjHw93YPsRwo0cgoc0ri/CUlFItyP0S3hj9uj909qpaGeZ9V5QqCJsvpvkfXFewLgUvfpq8SoNRd+ByWYMEFXnS/LCB95LZOuL2gsH6c7o/nY1MjyYaowdNGBk70Fz5S23aNa0GT909Y9zy0lkfRPFXUuh5XtfH7z2tjf5H5T4GhP3XyTgQEtXDHHpQhCXSOK0KAF9g/YYgN4/GP48nQUunb9zASu4+mrLyV/vYE1ip8jNfCmDJ6wkuyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1PDv9i9k+bux/le8NPsSw+72CVbWWotVrGxMcMrhEs=;
 b=nxf+yRuaLqwjjM7vhUNXPR+4AVky8q5d5lQeAM7boJg2lTYdxPzQ461rCgj+kVyr7xefCVQOh/UpqLpNlxtkkh2M5tEbOz0rYa32ePeSIKeMgFMIq43+mGyIRt4Xm1abbHogbSKS+KN+gIHlAwFO0NYyWObx5j3xKA7b0zLSh1eT/3JqlpwcvSXe7qvX4Rc679SwNW0jZMTYmC7x0aqp8mtuwExZHJMLhq4KdaIf3FI0fRJVnamKR8/7aFPMSUKBUd6mrwwH+5dOJlLmIfTDULttfrWTiV7bPGne2i6EPVFo9gKcg7PVyzmHhrwyLHvcl8ZiLDfqJPMsecCNPX+mEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1PDv9i9k+bux/le8NPsSw+72CVbWWotVrGxMcMrhEs=;
 b=r+HV2AlaDEbKuDB10IKtbYdEDi8dq3tbjnjp9My92KhwAGvTKaHb87c5hUlBQ1cdI3DngpSI+/wLrfHEDFlqZW3JLPjRJhGvYJEYlEsPHagUwDKjRsM1F6ReQelTVIxbAbF2jwAlRgoSlAC0lZ4mrcft+NgktOgd8v0e+Iu8hEw=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA1PR10MB5735.namprd10.prod.outlook.com (2603:10b6:806:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Fri, 18 Jul
 2025 18:05:34 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%5]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 18:05:34 +0000
Message-ID: <8c4e8451-72b7-4c34-8660-faa2a23a4667@oracle.com>
Date: Fri, 18 Jul 2025 14:05:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] testing/radix-tree/maple: Hack around kfree_rcu not
 existing
To: Pedro Falcato <pfalcato@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20250718172138.103116-1-pfalcato@suse.de>
 <20250718172138.103116-2-pfalcato@suse.de>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20250718172138.103116-2-pfalcato@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::17) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA1PR10MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: 3490e17a-1215-4566-f694-08ddc625b0c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlF6ZHduOFlFQzVIdEI2YTZvNUtrTXcyeGNLNk14ZDVQdkorRTJKUmhib3NX?=
 =?utf-8?B?ZjFNbU5zWWUxck5OZHRnblMyMjYrVmJleFdRczB4TjNnT2tGOE8zUkpsN3Fm?=
 =?utf-8?B?SlRTeE0wRUhZazR1a1ZFNEtEZXNxSmJGQ3hqRFIzVzBvQ3ZJT3lYcktDOW9Q?=
 =?utf-8?B?WWMveE5HWEpvU2xkaHE3bkduYW00c2hDMmk5MFVhSG40NzBEOG9WeGtFYllH?=
 =?utf-8?B?czVqOTlvVm8yYy9sa2V6c1JPUUxQZjlKYVFkTHY4YW9xclF0aXdOUDdFU0xF?=
 =?utf-8?B?TEJaS1BlNldQYUNOa0djUmRmWGI0b25tcWdYdG5CbDZWeTU2eWI1SE9teEpy?=
 =?utf-8?B?cWZ5OVlOdkJnRUVraG0vaHkvY2tPaUtnRWtzZ2tQbUFnK1lrSGdLdzZhemhO?=
 =?utf-8?B?cTFIM0FPMVlnRXMrMk43TGVRQk84bnc4RXBEZlhsbUFLQUhsd0o2MkE4M3hn?=
 =?utf-8?B?NnVnVlNQcms0clV4TVNPQUY1TmdVTnM3OEpiT0laSFZiVGtMMzZWV01LMzBW?=
 =?utf-8?B?SldzUzRra1p1RVJ4VHNvbnY5SjVkZmpVWnl4Z0NDandSQUs0V2IvQ1dyYjdG?=
 =?utf-8?B?WjFkdURwbnJPRDA4S0ZlbnRQNXZZUzhja3h6UUZsSzVUdVJRblc1aXpCT0g2?=
 =?utf-8?B?alFGaHY2WmlRVEkzR3ZnTnRYeGk5TjlaeW9kb3RyNGFLa1dmNVU0R1NDeFky?=
 =?utf-8?B?cnZwZU1leHFyT0l4M0JTamJlN0hSZ2dXQjVLc3MwSjFoeGVKWXVEajVGNWxp?=
 =?utf-8?B?OVZnNmIxVzZ1Zk96OW5tR0R0V0N1RFdXNjZaSUdUUHNaNk9ZaFQ5K1JpejE5?=
 =?utf-8?B?emZTNlI5U2xuejNOVnppRDh3eGQrSFRGaUhxU1dpdlp3Ump2dUJXMEdqV1po?=
 =?utf-8?B?TEwyWi9JV05JQjJ0cmYwTklURHl5RWMyMmpHMTBNRVkyQW5sMW1CdDVjc0g0?=
 =?utf-8?B?UnU3RTlma1hsRlE4N21RK0dGcFA1cEx0ME1paVZuUC9SdC9mSUNtME5takU4?=
 =?utf-8?B?bFlDUVJOc1ZHRW1DbHc5dW5pM2NMTnlGeWdLMGhqQzlZZlpUaFNBbzFzVExU?=
 =?utf-8?B?UU9aRUdDQVI3eFRtVnJoRFpYZEdyL21wakRJc1I5T1cyQXp2RkdYcVRraWV1?=
 =?utf-8?B?d1JKeTk5MjRaajRmS1FKRjk5ejBiUVRWbVVKTXpjN29lTU1WNGRIZWJxRW1T?=
 =?utf-8?B?NW00WitMNHF2Ymh0dlg0T2JDcGZDeDhTUXRKTS9rSU9NdHdLSWgrT1RVQkpL?=
 =?utf-8?B?bTdJUXZNMHc5cTJRYy9lcGtGbVVYUGZvUE9jTFJWcUIrengvaTA3WVBTc3dW?=
 =?utf-8?B?TEdPeW8vV0FHamNzK3dsY0JKNS9rUWRobjBlTElqVndZT0lLSks1VEh2Nk1N?=
 =?utf-8?B?TG5QZjI1clZvcEZhOU5OWVNhU05mSCtyWkI1Q1JqUXAwTnRCK1dReXVQd0I4?=
 =?utf-8?B?MmJWNjNWYmRlZE1tWmZNOXFhc2NlMXFEMUVtYTJ4bTVqQklNUTFlWE8vZDNS?=
 =?utf-8?B?MG9qekxzcTZaZ2d4WHY0dWRleGR5TTlneUZDTXZKRU80UmJORmY4QVNHVGY1?=
 =?utf-8?B?eWhweDFQRE4zRWhTNTBFY3psbW4vK0RnOXhnSWUyOHNObGcrc1ZMNXdPakNm?=
 =?utf-8?B?Y3lwaUZDaUFJcTI1cFIvaXYwVG9vMTU4SDRiOE1Qd3E0SytkczZuenNwYnEz?=
 =?utf-8?B?TkxwYVRCUXBWVFVpaVdTZ1gxdU8yVFpvNmN5M0tjTXdsMml2V0UwVmY5eW1p?=
 =?utf-8?B?VlJVeFVLRnJHWkcydklOb1ZDRTVJaU1HQjFsa2ZxdU01ZHNXeUJtdnJLVWtn?=
 =?utf-8?B?UGN3YmM1TE9SdGR6bmk2K3NSc3VTdFViSkw0WGZibnV1KzloZjkvZlhGSGVR?=
 =?utf-8?B?QnVXZFJ6T3NtNUF5ZmRNTkxDeExVUXpHeHJIRVIwMjF6YWxhNjZUZ041WEJE?=
 =?utf-8?Q?DtHgLjThec8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlB1WGJTWm84N0FiTjM3ckExaXhvZERobG54YUVOT2luV1UrWWVzVmpMZnMw?=
 =?utf-8?B?aG41S3VuL0YxL2t1K0xLOVBNdVMza0tZNDhlRDJSSkFPbW56eml3RU03WXpv?=
 =?utf-8?B?NS83MGFwRkJzWUpSMmtpaE41OGZhT2pic2Z0NGhEcHpkNFdJNTh2N2wvbEdF?=
 =?utf-8?B?ZHlHelR0YzlLRmgwZGtJenV5UkZHMjhlSVZrWVcxNnhqZGdyUitTcmRTRVo5?=
 =?utf-8?B?bEhpbWRLMzNSN2QyS080YnFSS0tqdGJRV0g1V2RaVUJDMm0vTE9Bd01GdUZx?=
 =?utf-8?B?SHp0Rjh2eUZQODNaWG9kVUY3NExFN1AwQUQ0NGY0ZzFDN1V1K050OTN6SmJu?=
 =?utf-8?B?ekMrek1nWlUzZ0tjWDNaZEwzUkN6UTMrT0dPdW1uTDBCWEhyZjUxME1HNzh1?=
 =?utf-8?B?MWx2Tjh4WUNzYVpOVWFnc0ZCKzNjUmJDOWoyOXltcEg0cStXMWtPci81L0tj?=
 =?utf-8?B?QVdUSUdBekI1VjF1MHQ5SG9Rc01OYkVWRUhpSFhPVEdvcnU3Wm5sa3dxdVZF?=
 =?utf-8?B?ejhaM1dzMThodzRlS1FnV2lwRGZDTG1LdmV2dW8wNjdsSS9odkZISDVVc2pw?=
 =?utf-8?B?ay9uVHFFcTZYY1h4NEh5UlJsY24yeTFyZlJiTE5uLy9OQ0xqTFZINlljUlIv?=
 =?utf-8?B?YURJM2J1a2xFZitLNkVnRk01Y3dQRU5yU0I3U3I0bTBUY2ljcGRzaFlHSVNu?=
 =?utf-8?B?K3lJOWVORUdrd1ArZW4xUVN6RVp4ZGhrMitNYlBGRkFGSy9mZjI4bjRWVHRZ?=
 =?utf-8?B?WnFKNTVBeXF0UmZFRjdLSHA1R1BFZm1UbmpRWmdnMVE3YkxyYUxKRVN1ZWND?=
 =?utf-8?B?b09kc0pWaVJhbkk2MGlFMnFBQi9SZ0RBSDV6czNYVHk1NkplQ29ZMVlFN2lh?=
 =?utf-8?B?WGZ0dkVuV1VTVDVjQWFGV2ZoSExzQmZ2bWNhWi9sMjQ0NENmYVZQcEx6cXpF?=
 =?utf-8?B?NmlvZHpwL3hmVk1BTzUydHNaV2ZxU3FRZ0tUczdGTVhvdndYdkhSSmhjUFBt?=
 =?utf-8?B?Z0xSdm9hdVhkZ2U0QXI4QVRlbURDN2o5RHpDaERmR1JIR3NMMUtPWktiN05M?=
 =?utf-8?B?MHk0LzlzUVE0RUh0SjkvRFJydUdXSks4emVERjl1QlliWGpPV005UkVyaXZh?=
 =?utf-8?B?VUJ5Mjd5NGI1Kys3VXgyT1hJOUM5T1lCR3dYb0YvVWxGcE9qbGthWStZMUNT?=
 =?utf-8?B?MVJBVkg1TFliVkwwKzNraTVCYmhSWUpTMjRFZXIxc0FUaTVpY05xbW1BSFcw?=
 =?utf-8?B?eERpYnQ1UDNQZVEwM1RZQ1ZxcEVBTGpqMTBsWjF1b0xWS3JrQnZuOWErV0pz?=
 =?utf-8?B?MVFwcVNuZ1hGby91L2pZNFVqV05ldnRYcUVkeElSaDB0eTlESFdPbGQrVXdN?=
 =?utf-8?B?WFc3SDRuMnA0SCs1K3EzME5nclMyMnVhcGw2dDZMZUh5R050bVViVHpzMEZX?=
 =?utf-8?B?dUF0V1ExRTM5TUtsZ2xhZjBqeUlUMW45MGJuRnpnc3JwdVhBM3pXZmNQMFR4?=
 =?utf-8?B?TjNQcVRjQmEvdTRCWk1KSDVFZThGdHc0REFjNi9QWjZjeGM1VDdyNlhkR0lI?=
 =?utf-8?B?VUMzL2tsTEYvUEVsQm5wM1g4RjBsNlFjREVUOFdaV3JFenZnUmYvRGVYQXVD?=
 =?utf-8?B?UmpodDI0bnhzdUEyUzFQb1BZSkhaNkFUclZrdG0rYVVJV1RPdFVJaURpV1E0?=
 =?utf-8?B?S004OTJjWUFvM3YyKzI5QklvYkRxVm0xM1paN2F1UnV0ZWVWelhMbVEyK2lS?=
 =?utf-8?B?NGM0K2dLSTFYbzJINzA4K0xZU1ljMUpWQnFzYTN0Q3lRZHNvQktFcmx2NDFi?=
 =?utf-8?B?RXF1c1JCREtTZ2NvZGJPYWY3VTZydXZleUJva0k3dlk1UWdlQXF2WWN0ajV0?=
 =?utf-8?B?RGpiL21IYjNEeCtOZXNEejVkUzhxOVlDT1BlcENKRWlWa0JUMXlhQXhzRHdM?=
 =?utf-8?B?eXFaK1VUVXBwbjZiZ3QwSW5ZMCtuUk96bmh1eXRzM2o4S3ovditsSHVwVktL?=
 =?utf-8?B?VVJxWW9qbCtmQktPaTB4eFpMRVFPTVhvUzNyQ01hUStnOTB2dmpqWDhkUEhz?=
 =?utf-8?B?V0JWbEkwdTFTV3dHczQ5eElmRjltaUZOZ1d3c0RySXhHdmxoS1dFRFkwallX?=
 =?utf-8?B?b25HMDkybXhZWG5aVDEyL0pDcDhkVUdkdnpDc1FySDJCQ0NkSitQeW9MVTFo?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MfFF2eU+Hs0UpjpcMm8qfA0MPbjV2jijLspY6Ejub3LUDrNUCUYLe6FMTbI78n09LZpNX0aZ9xLhDIJ2+80JR2iAp8o0dSkS4mvxx4GuR/Gi9N7i10XlOVnevBwaiu8e46iEq711Z3TcUxM2fy1fmID9+C8Lba0Nl7AtCJXLhaX13T/KrE9OcCQzEjGjM/INOfdF5z7j68EZOXrzroY4mq8Fh1iGeZbQdtxo1tBBHaTFKdmG+0raybO14hJjEQUguf58+Z/Sql9CcEMGL1efRV9cpU8eTDtmk/53m7+K9hF6lERjDYdu8rksFPLbAp+I3ae8qRGpdXXJZtPYVtuT3zxsRaNWuSs0lMh+DVjpR+aiNsONY0gS7wVRwNLQTqA/VsoJRyCw5wZ1ik+YHt1NPjSH7toOXD85NEg9+u1WZIeYgNNtgM54779LOPzSOawAnERFLHlQej0FQzITWIXY3GKa4xNYSPYiU11LebPfBiXNP9fhTjQAyJRbPGWHataKjNRLbU+kR/JqYVjC53rMzzr7sCkl3nLFEgaENrO5tWFJ4nx8J+cNnRdT8ywTJ772ozZXjwk08lEU9TWBRIo2Ikgcf7dCxfIHVOC/dPPL1ZY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3490e17a-1215-4566-f694-08ddc625b0c2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 18:05:34.4127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebqx0hjBwNmmX8XNqIRCvqR7k71vnZ2GNSDHeGDSmgIsOuZ0w1ve6gvQh8HCQHqu+RKk+tfFrwygwhNZt72hxNkH4vmyjQ4s1NHJLgthkO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507180144
X-Proofpoint-ORIG-GUID: gd-PFjsekcs0dvBa23X1ClvB0RaU-AU0
X-Authority-Analysis: v=2.4 cv=AZGxH2XG c=1 sm=1 tr=0 ts=687a8cf2 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=wcJrYnJmcS420O6A8-sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE0NCBTYWx0ZWRfX8luq21Dw4N+y hPQ7Lix251//694UFbFQuNG2VQGQh6TY3TsMQndZMKQr1g3kmpTCSP9kq6U7EmlqzH5umRNgof1 gJJepSGPYXbQTB2A/2p9hZyomwkvi6LBn+Hm5zKv7+urxM09Qw0E0pGcQjbaHOxlFpWK2kTo9of
 nOZg46YT+IAcacomqF6Bu9yh/VM7dBI5phzG03KmmdmvByjRT97UwWYHPNVD4poarF9GzsKVnCm A+r6yZ4WBotbDj6TIj5EZcRht60tj+wwUZS8otKgaUOcrjdY7UbfjhTGwYVw6u87GxacmR4Jqfa +d9ab9Ksj3D9ycPQ6cEVstxzq4eWwvhP/NstQWja7UszR/CxKonLNsj5fxQBw/5ubWaTyVCJyJw
 p70bkJCf/9JeDKTlC5i5Q1PaxuKH7cbPf3jaOL1tMo/YMwmM4BtiaoRuth+jhBErYrb2/emG
X-Proofpoint-GUID: gd-PFjsekcs0dvBa23X1ClvB0RaU-AU0

On 7/18/25 1:21 PM, Pedro Falcato wrote:
> liburcu doesn't have kfree_rcu (or anything similar). Despite that, we
> can hack around it in a trivial fashion, by adding a wrapper.
> 
> This wrapper only works for maple_nodes, and not anything else (due to
> us not being able to know rcu_head offsets in any way), and thus we take
> advantage of the type checking to avoid future silent breakage.
> 
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>

Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

> ---
>   tools/testing/radix-tree/maple.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> index 172700fb7784..bfdc93c36cf9 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -23,6 +23,23 @@
>   #define MODULE_LICENSE(x)
>   #define dump_stack()	assert(0)
>   
> +
> +#include <linux/maple_tree.h>
> +
> +static void free_node(struct rcu_head *head)
> +{
> +	struct maple_node *node = container_of(head, struct maple_node, rcu);
> +
> +	free(node);
> +}
> +
> +static void kfree_rcu_node(struct maple_node *node)
> +{
> +	call_rcu(&node->rcu, free_node);
> +}
> +
> +#define kfree_rcu(ptr, memb) kfree_rcu_node(ptr)
> +
>   #include "../../../lib/maple_tree.c"
>   #include "../../../lib/test_maple_tree.c"
>   


