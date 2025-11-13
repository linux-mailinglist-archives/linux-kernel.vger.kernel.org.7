Return-Path: <linux-kernel+bounces-899018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E546C56982
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 171D44E79CF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B32E28000F;
	Thu, 13 Nov 2025 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iFeCqbOR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aRieSdYu"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F91D27E04C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763025737; cv=fail; b=YEtbCh4nF0b07+Df/DZfHdNgcpwKDYH+K2vYdBIEeMrrFswa3193KHBBV+MZW+GVq81MLhiBU9NS9eLBa0Uo8b2JHJqPmRdBAyYQRGO2z5RBMurOEoCVUbuSJOaDD28nBtjQzwNTIxhewJW7Onprw8p0hp4vPo/Va+0XmU1wl0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763025737; c=relaxed/simple;
	bh=GdhzTRN7HTsqlD8Z8sXxmL4mQI5DKALPi9rYG7GIxrQ=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r0GHEn7u7WUiqUt1NmzI6d2QDAg/In9787f7ldk+ggOuTgFn+R7Uf4GnBAjoZwvdGhpVLqIzT87tgYEoz8TnWDALTKn00tXuj2I8/gXB495OABPSDHN6heJrgJj9JlSprr0aLNCANTCSf4+AnCXZ/wsQfVauFm4No74+mp8aRtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iFeCqbOR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aRieSdYu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD1gWql015686;
	Thu, 13 Nov 2025 09:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qNUJoh25hhbA8SOvyURHQko4WfSaIEZdBuU+jS/Hvig=; b=
	iFeCqbOR/En5+17hF/NVCyi0aUN/6sO6Hz3OtjkLM/gn9trnUv6KGY3Lvvdw5k8J
	eUb1HYhVAA3+7WPPNzKmDCF8jYD5O/cZMfVD8VofN6bdl76OiQYVoFSBkV1FZCaN
	qcL8OUiD+rwl2DXTGP+ubVSLcoM8i/nuKQxF8SV4f4WgbvkRItCplTpAfS0suQPX
	1Zml8ht4AvrYvHY9blp/cbjfCYIKEkksCp6uD3pPPal+XYjnvUYxgQE/CpaHJoUO
	iG7g35maZaX+J7sKnVTC1LprdYBTsaC/iA/vsaOm54cOYSZXUO284VMhpBCs3YXg
	yXoFwps2GSLdeHjekyZxtw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acxfvhejt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 09:22:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD9FqtC029214;
	Thu, 13 Nov 2025 09:21:59 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vafwx53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 09:21:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4WfCbS1cRbUXKE+O23AArbHDoDdd927v8Mbo0VZ52Nnf9JzvbIWMlDE4nQlkNBBRbBRRZM7a0eXzosy4OfvwusFfeDNH8QvJXMA6frYNnSC6u0VHKR8sYv2E9pLncPfW2BjuBRoEgMqUut5V+JbxHo/3oWr8SDsB4Hwcsp1+zmg/MC+w0UIom9Wmw+f+VtrUNUx1LIQarla/juk95phGCHR4ZIdyf57x936ELP6tkJzHjEPcnKmrgVDV5B0WbHh64nFciyF0vVdSoe8zymrPWzQVWKnD3oFTPxfQOExzuBCuVlgxBl1tNlTKWFGtmKY8LVGWT3XnH/GiH0ddcmkNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNUJoh25hhbA8SOvyURHQko4WfSaIEZdBuU+jS/Hvig=;
 b=bOuNL21cpY6hB4CL9pPGz1QFuzidZFIDeCzYve3debTdMgYdP+QL+JTJyEdtC3Vqp6yxb4g8TxkuumilfGkUp0CioBzfAyJ6bnF42TqauDpVxuzeKb5QqHjwG1/j27Bu00E6sKtFZYdxCs7etaVX+0tsAcX47PLTS4K+ZlA/7xQQCNTiLZ6DfON3h5qH7nDJxvg6aWZWCaywJik3sNGooUI2hR5jX0PNZTkheUnuFI4deKSSDeM/NkWw4fAcRj4SbTCwTxAkb8B0BZUs3j4T4eRGYqpEJsej4dgS9JfHEfuXnWlsM5dFnd1uzF/+WXRuaoaYGhYBggktcEpilMaMEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNUJoh25hhbA8SOvyURHQko4WfSaIEZdBuU+jS/Hvig=;
 b=aRieSdYuRLMe6fs2GkuBASDVQLLc1yJ+uZvixgHaE269uJ2i9KdHuWgBbLyCHFRirI30rsYkcO/2sewLl4YvSU+vGYObKqGxXtQRILwA2mBM9+qCvLSm6pedILvCbG22WDXdHdh/UOD9FO+Uicryz5z62KseZOCVUNGjMb5c7bo=
Received: from SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18)
 by PH0PR10MB5847.namprd10.prod.outlook.com (2603:10b6:510:146::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 09:21:53 +0000
Received: from SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084]) by SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 09:21:53 +0000
Message-ID: <85dd05e1-055d-4dc2-87a6-3221e327fd67@oracle.com>
Date: Thu, 13 Nov 2025 10:21:50 +0100
User-Agent: Mozilla Thunderbird
Cc: alexandre.chartre@oracle.com
Subject: Re: [PATCH v3 00/28] objtool: Function validation tracing
To: linux-kernel@vger.kernel.org, mingo@kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org
References: <20251112160315.2207947-1-alexandre.chartre@oracle.com>
Content-Language: en-US
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Autocrypt: addr=alexandre.chartre@oracle.com; keydata=
 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
 swLliy6PdpST
In-Reply-To: <20251112160315.2207947-1-alexandre.chartre@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0138.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:377::14) To SN4PR10MB5622.namprd10.prod.outlook.com
 (2603:10b6:806:209::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR10MB5622:EE_|PH0PR10MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 33cc1277-a26d-4f74-4a31-08de22961513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c00vblo3RW10NjBMaTB4U0o1ZnoxWWgxZXUybEl4dW9LTlJoc00xQjltaTFM?=
 =?utf-8?B?UHZKdXZTUmhDbkp1Rjd5RkRER0VPc3ZzUGdxWjExTFNqR0RJUjBpSFZGb0po?=
 =?utf-8?B?cHdLZkNZdUNmbk1iaWFmTWROWW5KQ1NHTVV4RHdOajVpbkVqVVYrWkNTZEYx?=
 =?utf-8?B?Q09USU96R2JrNWp3aWZMUHZxSkJMMHFRcUxIUEJldWpDQjdRSzRsK1lwNkdM?=
 =?utf-8?B?YjgzclR5cjMxalVWeXh6T0RxTTYyOEpUU0NoQ1A0UkdhQWJxRzRUNnlRNFpa?=
 =?utf-8?B?aUVhMHNWU3o2czhMM3VsN0FuM0djanlEUlcvSjBHVVlIUWRuSXEzOE13aUN3?=
 =?utf-8?B?OEE3WUhvdjJYa0EyUnptTnpHd3RISGQwTHJta05HcUFoclk5UTh1WWZWOG15?=
 =?utf-8?B?NXFOTzZEWTNRdEhqTkd6cWorTDFhS210Zmp4UUwxZlg0V2hUdituY3J4Q3Y1?=
 =?utf-8?B?Uklxa0FRRkUzd0FMWEp3WkFSbWdxQjVWZVZEZWlzKytXTGN5RzdCT2V0RTlG?=
 =?utf-8?B?L0lpWHRidnpNallzQ3FFODBwV0lZVjN0R29BOGxmZHNpUnFsUWl2Q1U5VWlw?=
 =?utf-8?B?cFh4NHcrazlHcW5GZXRxUmhPeDZRSURXaUZ4WU9Qb05kSWRBQlJ6cTFlekQ5?=
 =?utf-8?B?dzA4dmMzZGVYOHg0ZE5wckc5MU5IRWgvTEhVVTU2Nmh3bFB1Z0RTNCtrMDFa?=
 =?utf-8?B?MjdlZjBwMmRETmZBbGxJWGhPdzk1eDJlaEtCM2xuaDFrWFk1bkdja1A3ZGVG?=
 =?utf-8?B?MWFTLzJIQUp5VEJ2MGtBVEprdDhlOGhnUXFJbXRZUkprelByWEZEU3o4cVIy?=
 =?utf-8?B?cjhlVWtNVlZsS3VyQXJOclJ5L2RIQW0zc0pBb1F4SVEyUnBSVHNqb2pRSHhL?=
 =?utf-8?B?U1U0bjFBZU1kRWFtaFY2MEFPaElINWZwVjM4bGNSQjUrYzh6MldxWWcxRllz?=
 =?utf-8?B?a1NIYmR2MDBxQUN6TXNSQW0xS000ZjkxVGVKb0tkc042czRTL0tqdTQ5TFh5?=
 =?utf-8?B?bkJGWG13dVZFVGV0R0RVYTJGeGEvN3dFR3dSMVVLc0FnMU0wUWlQTHh3eXVQ?=
 =?utf-8?B?OG16dzFIM3Z5M29rQTFsazh1SzZvekhHVG5zeVBZcHJjZkxUK1lTcGR4TzI4?=
 =?utf-8?B?ODBYTkVuV2EyYWtLdFQ3Rkc1RWJrRDRBVGpSODdlWG1kTzFqa0RUcytDaVVu?=
 =?utf-8?B?RWV0ZG45N0N5REJKOFhWRyt2eTc3KzNtdE9IbmVkVmlvMkNCNXhoSnB4VGp5?=
 =?utf-8?B?eHNKRlV6K3JqdWxpTTA0Z3pBNCtZYWtZSk5NUGgyT2NMZW5uUVZHSlhqUWp6?=
 =?utf-8?B?ZFpXb0d4bVJheWEyWk9pMUFZMHlnbnRxcitsVzQ1S2hyRk9tRXJubmMwQlMz?=
 =?utf-8?B?Z2NJc3lOUnFMRCtQMVFkSkN6ZjdiSGIrdCtzbzNNMXFEVGFvM1c3dmpNR3lL?=
 =?utf-8?B?Z3dMbVlMRDZYVVMveldXclAyTjJHVjhwY1UrY05sMGhJQy9iS3dxV2tYSERF?=
 =?utf-8?B?RUJFS0ZLRDliWGFFTWdKc2VxOWxhNkpGMS9FT0hqbVVURWZJZXYyMnBnSE9Y?=
 =?utf-8?B?TVc2S3krYjdkdVFBeHo5WVQvWk9HSVcvNjNqQzRRUExKS0kxTXFWVlhwR0Rr?=
 =?utf-8?B?eDRtWUpaR01CeUIySjhiZ0F4ekFBZzZTKytPQzRzRE1LNTlodE9Qc2ZvREFO?=
 =?utf-8?B?d1hNRE1nRmw4QnoraTdVRVpxWFgyZG80MmZVLzg2cXY1N0oyblA4aStYbWRV?=
 =?utf-8?B?S3pnYlhYMGIxM2lYV3MwbGJHQ2ZxcXBxVjd0OXIxWUxUdll3eGFzWlVUT2FI?=
 =?utf-8?B?RVRoREhzYVE1MDExeHVIdjU1SnBDQlNUZ3NLWFcwbDRXR2tnSnBsQlRwZm5C?=
 =?utf-8?B?WWdQQ2hISVAwRFAyTG5TckN5STRuaHNxV2h6K2o5aGxzb3phUHBNcFd0OEVD?=
 =?utf-8?Q?UQyPTyMwjzv+5iwDp0QZnDqf0CCjqgND?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVRvdVhhcEFZT3lLOGQ2b0FaMmkrb2JVRW9NWTVrL05iWWZ5Z0s4dWxxZVpL?=
 =?utf-8?B?YitCanc0KzlsOENJUTYvQzVUcCs3cWQ3ekJIMUM0dUdSc1B0L3BEenc2T2hQ?=
 =?utf-8?B?TnV4Wm9XcGgrcVVaWXoxVWF6dUZJQkQ3UmJveWsrTW9ybXJ5K0w1b0QxQjlN?=
 =?utf-8?B?V1JEQXBTR3BGc3ZVZyt5cFRjY2ZWRkNvUFBBWENRRktIREIrK0tZSG1Ra0tV?=
 =?utf-8?B?SEpYb1ZCTFZ0akdGU0d0OThabmIyWjlHMGQrWjY2dmgycGhmUlpJeVJBK1Ju?=
 =?utf-8?B?Q0pFdkVlckRkdWVVTXpjTnlPOVRhNmpKNldZSi8vMnZCUndPeUl3Tk0rVnln?=
 =?utf-8?B?bnBrekF6dkJpaHhpSmZ3bEJSUVlDdXkwVy9wKzhQMWRSdC82QmdPUFNyN25n?=
 =?utf-8?B?ME1YVDYvUWUrcUQ5MGJMWmxoM3ZaMzJPNlQ5R254bHJDSDJ2Yittb0xFRURJ?=
 =?utf-8?B?VXo3UzVTSm51NGk3Q2V1LzIzbXc5dHU1aGwwV3E0c2wxZVcwRjhNVUdzaTNQ?=
 =?utf-8?B?S2dzSVByVHhyQzFVUGVWU2J4YU1rWWkxdjJCVnpWVGMvNStSUjFCU2lPSER0?=
 =?utf-8?B?Z1cxU2FCcnc3RFF1eGF5eC80SzE1VWJjWDVXVlpmcElWWTBxQncwNEZDZThs?=
 =?utf-8?B?U091ckhDNXBValhrQ1JDaEN2aS9oQ0ZMZ0RQbldJN0RpcHRiY1Y1TDNiSFVC?=
 =?utf-8?B?clU5NEltY3N1czVuVUdHT1pFejdkd0hBMVA3djE4VW52dUJlNTV0L2JhbTBr?=
 =?utf-8?B?Z3FyWmVacnJ5Rlk1dG5idzhDQmNIczdCT0FkNFhZZHFWQkFQLzhpKzI2NDlE?=
 =?utf-8?B?THZhanZjendraC9UbkZvYUFsdkxLa0RseTZDbGFuUml4Z2FhWTgyNURTQWpD?=
 =?utf-8?B?bndWR2trcHF5UWRlNTRpRnFhWXpwc3hBajBTbjg2M2l3SUZralZLWFRyTDJq?=
 =?utf-8?B?VXJnOFBUNUg1amRINXdwUXVIVXlKbmVnN1IxTkVQYmxUWHlIYUxLU0FlWExV?=
 =?utf-8?B?WlZWdkVOdGF4K0tWT3hoNkE3eER2R0xsZGhudTBFRlFXOXBPaUxKRVpWWVdB?=
 =?utf-8?B?c09BY1h1TGNKM2p3dExtTkpIcmZYUi9Ud3UxOXhqNXgzTDU0KzI0eTh3S1pB?=
 =?utf-8?B?cDVubGpEOE9OcWFFeGdUbnVWcDRGMW1UK3VZZTA4c3ZRY3NxM2NuRmN2cUFo?=
 =?utf-8?B?TXEveXA1Nno2VVVJd2g0dTBCRzUxY3lRVXNCa0hkemE3SVA1WDJoSHhmUEh5?=
 =?utf-8?B?L2M5M2xmOGp3WkhxU3M4N1pkWmZEck9WZkpkVEttZGZ2WC9TdC8rVzlDN3Bo?=
 =?utf-8?B?NkVjOWJBU1lpWU5nbFdGaUNCL2FySS9FY0lCSVZuWlpqbUZHRUN6QVpraXR6?=
 =?utf-8?B?eVhxL0hJM1o0b2o0RHptVEhoOEN1Lzdacm1hYkxIcyttanJJdTNoeE5aQi90?=
 =?utf-8?B?eVFnc2grYTVYMnRBaVNqM2xNdVJHMktOUzNaVGhnKzlkOU5DQWtyUmI3a1oy?=
 =?utf-8?B?bVEwQ1JoSXBMZExleTVSQTBZK2FRNGd6dDMwcWFHUC9waTJTSCtXMnFBSnps?=
 =?utf-8?B?RllHQkZpQzhHK0pRdGovbkRWaXg4UCtrR3M0U3ZnVGY0QWxvQndoT2FvdU80?=
 =?utf-8?B?UUFHTGNtN1AxMktmWm1UbWNRUWNXYVVWU2xna1hCaEdMMTNJbkZIemFmVDcv?=
 =?utf-8?B?alQ1TFlaN3A2S3dYcVgxbnlpL3pONitHV3MwOWt6cjFKOGc2YzJ6dFdXN3lW?=
 =?utf-8?B?ck0rZERybWppSmwxQ1JnbzZGZkpaS2poWnNCckEva1ZUVHc3SmtneFd2WWRZ?=
 =?utf-8?B?TGpPS0Nxcml4eVR6WHlyOEdlZkNHL2FILy9wSDBlQzhrMnl4SFJtWC8wTXJC?=
 =?utf-8?B?ZGlsQkV2RHcrN3JZakgvcmFzLzluZ2VacDlKQnZNdUlIWEpoY0k0dC96cGEv?=
 =?utf-8?B?SFo3elFEbWR0aVp5eUVYSzB6ZjUrQmJDWG8xQVVxZTlaWnZJWnh3ZmhMb0lk?=
 =?utf-8?B?cXpxUFFDT1V1UXVOMnFHK0o5WCt4MWd6SWtBL1pvQmprTTBFeW1QVm5sQlBQ?=
 =?utf-8?B?aC9WbWFtcTljWVVYQXJNWkJiRForMnI3RWhvbG4yQk5kVzZKbVA3RGtickVr?=
 =?utf-8?B?OE5ZUkEzbkxSNENwTUtSMC92NUZxNTE2cUttc0pHaWUzeWw3QU8yZzdsY2Fh?=
 =?utf-8?B?YzJ0SG5HT2x2eHlwaDgwMHpCVVErUXBkK1R0cDFmU2VtSk8wODNITUFoZmpG?=
 =?utf-8?B?SmgvL1A3aHpWYlN3S0Q3bVBKbHh3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SdIIBWNaqspUAN0Bnx3dzqBCSdy/qq/WVK4o5dWTqzJPM4tRsMHzN43kstK0IjRJuB35BP5/py9Tj8jTMOXdwgWEwn2ugV0pg2V2C/Fbr6Lz0Hb6sDn7q6LITrdvPzQMC4IM/r+v0v0x0aMDicOy2kKT1K7kE5XFVyJBlRQ8A43VygEQ/rZqq1GDpnJk+M/aSuh23mmC9ni1od0h/Pht+umTooYZWqyNtQMbCsmFpUrx2BgGGXQq3dwnMcxTAsTEVJFZ0m8G9qW6vAGEva1zCL1+3X6j/CM0OLW4BmDq9yPRkGCFbNvUp8aFH+UEnfx7d63Y6HQCv89AoIkqBnL9pc6QlDmrQ84gMcX3ZAjUMLzzeVvFFj+c9BkEXfYMUvZBiWh+wZmB7wbkq+C66n4aG4o0gsKc6ckR+NVAIqQk4LgTuOHmoPRNP04I56vcWSqj1Q+qWg9+V6grG8fIBhKalffWWmi/fPg5BN/HDCDKmlnkSjhS1eHxMM9dOEPF2EYu0064cSpWM/rEiBcyFOU3keo+BGVnWCZqzY6cpdPaLi8Rpt2uhvKfwxcOTsRtl4cZvHmbhDcj86A2/2WEcwJkNhY9cVWhMgCGcHzmFvaQMDs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cc1277-a26d-4f74-4a31-08de22961513
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 09:21:53.5995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYUlBUgvVeixirV91N0Ys7cJ7Z9ks6RwYGfbDcT0ggVVJ6qBG/VCZTFUK1w0O2VPiagsGGxFs43L9eakCcgOiGNrHqwiXIZTLOWazNO5jVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511130067
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEzOSBTYWx0ZWRfX3tNGsvZ8MxUb
 nr/Sa+1N0MrvEHDA3sjKr6aYZnxdqtsZNz+PKspY1toI8sSqQQn0X5MCouyUdkZAWF39xcKadIr
 P1xBmFGJzx0NWAzhS+UpIMvvS4Wb6m3C00tkxXf3UvR3h81av/Og5prI4bxrWqF74mYls40a11J
 kY3IkfXYuWnGwso7kISvWHndWylBSX39XBdATvKgvRdOsLq1gIpvDubkpb/zXXTjGQBLCGpvs7U
 9T1LSoxZmXXB6q10VJ5wjjb4FvZXYDX5V4RpljUu9KUaHmKWQjgRpv/Ma8jUEviv+Q5VuEfeefB
 8yScB+fpZU1lbOOj61wEsxDgicnti4l1Z4ilksvHgqugtf/KUSe86UslzGtvSgpNWSVkNrWcAV5
 A0GVSyQhdstzrJwgQclWuB6H7I2YIogYS++4HqcSKvCWH7PVQC0=
X-Proofpoint-ORIG-GUID: U5Gxf4Td_QGtORrk_2H4lrTulTHso2q0
X-Proofpoint-GUID: U5Gxf4Td_QGtORrk_2H4lrTulTHso2q0
X-Authority-Analysis: v=2.4 cv=FKYWBuos c=1 sm=1 tr=0 ts=6915a339 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KdDx-Q84udYN8ZVpZv8A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13634


kernel test robot has reported a build error on ppc for two patches. I am
fixing this (forgot to test build when there's no support for disassembly).
Sorry about that.

alex.

On 11/12/25 17:02, Alexandre Chartre wrote:
> Hi,
> 
> These patches change objtool to disassemble code with libopcodes instead
> of running objdump. You will find below:
> 
> - Changes: changes made in this version
> - Overview: overview of the changes
> - Notes: description of some particular behavior
> - Examples: output examples
> 
> Thanks,
> 
> alex.
> 
> -----
> 
> Changes:
> ========
> 
> This new version addresses comments from Josh and Peter, in particular:
> 
> - Josh: replace ERROR in disas_context_create with WARN
> - Josh: do not change offstr() outside the disassembler
> - Josh: duplicated "falls through to next function" warning
> - Josh: validate_symbol() has extra newline before return
> - Josh: "make -s" should be completely silent
> - Josh: instructions with unwinding state changes are printing twice
> - Josh: explain TRACE_INSN(insn, NULL): this prints an instruction with no
>    	additional message.
> 
> - Peter: display alternative on a single line
> - Peter: display nop-like instruction as NOP<n>
> - Peter: in alternative show differences between jmp.d8 and jmp.d32 (jmp/jmpq is used now)
> - Peter: show alternative feature name and flags
> - Peter: alternative jumps to altinstr_aux - see NOTE below:
>           Disassembly can show default alternative jumping to .altinstr_aux
> - Peter: some jump label target seems wrong (jmp +0) - NOTE below:
>           Disassembly can show alternative jumping to the next instruction
> 
> Other improvements:
> 
> - An alternatives is displayed on single line if each alternative has a
>    single instruction. Otherwise alternatives are dispayed side-by-side,
>    with one column for each lternative.
> 
> - Each alternative of a group alternative is displayed with its feature
>    name and flags: <flags><feature-name>
> 
>    <flags> is made of the following characters:
> 
>      '!' : ALT_FLAG_NOT
>      '+' : ALT_FLAG_DIRECT_CALL
>      '?' : unknown flag (i.e. any other flags)
> 
> - If an alternative is a jump table then "JUMP" is used as the feature
>    name.
> 
> - If an alternative is an exception table then "EXCEPTION" is used as the
>    feature name.
> 
> - Print the destination name of pv_ops calls  when we can figure out if
>    XENPV mode is used or not. If the PV mode can't be predicted then print
>    the default pv_ops destination as a destination example.
> 
> - If a group alternative is a direct call then print the corresponding
>    pv_ops call.
> 
> Examples are shown below.
> 
> 
> Overview:
> =========
> 
> This provides the following changes to objtool.
> 
> - Disassemble code with libopcodes instead of running objdump
> 
>    objtool executes the objdump command to disassemble code. In particular,
>    if objtool fails to validate a function then it will use objdump to
>    disassemble the entire file which is not very helpful when processing
>    a large file (like vmlinux.o).
> 
>    Using libopcodes provides more control about the disassembly scope and
>    output, and it is possible to disassemble a single instruction or
>    a single function. Now when objtool fails to validate a function it
>    will disassemble that single function instead of disassembling the
>    entire file.
> 
> - Add the --trace <function> option to trace function validation
> 
>    Figuring out why a function validation has failed can be difficult because
>    objtool checks all code flows (including alternatives) and maintains
>    instructions states (in particular call frame information).
> 
>    The trace option allows to follow the function validation done by objtool
>    instruction per instruction, see what objtool is doing and get function
>    validation information. An output example is shown below.
> 
> - Add the --disas <function> option to disassemble functions
> 
>    Disassembly is done using libopcodes and it will show the different code
>    alternatives.
> 
> Note: some changes are architecture specific (x86, powerpc, loongarch). Any
> feedback about the behavior on powerpc and loongarch is welcome.
> 
> 
> Notes:
> ======
> 
> Disassembly can show default alternative jumping to .altinstr_aux
> -----------------------------------------------------------------
> Disassembly can show a default alternative jumping to .altinstr_aux. This
> happens when the _static_cpu_has() function is used. Its default code
> jumps to .altinstr_aux where a test sequence is executed (test; jnz; jmp).
> 
> At runtime, this sequence is not used because the _static_cpu_has()
> an alternative with the X86_FEATURE_ALWAYS feature.
> 
> 
>    debc:  perf_get_x86_pmu_capability+0xc      jmpq   0xdec1 <.altinstr_aux+0xfc> | NOP5  (X86_FEATURE_HYBRID_CPU) | jmpq   0x61a <perf_get_x86_pmu_capability+0x37>  (X86_FEATURE_ALWAYS)   # <alternative.debc>
>    dec1:  perf_get_x86_pmu_capability+0x11     ud2
> 
> 
> Disassembly can show alternative jumping to the next instruction
> ----------------------------------------------------------------
> 
> The disassembly can show jump tables with an alternative which jumps
> to the next instruction.
> 
> For example:
> 
> def9:  perf_get_x86_pmu_capability+0x49    NOP2 | jmp    defb <perf_get_x86_pmu_capability+0x4b>  (JUMP)   # <alternative.def9>
> defb:  perf_get_x86_pmu_capability+0x4b	   mov    0x0(%rip),%rdi        # 0xdf02 <x86_pmu+0xd8>
> 
> This disassembly is correct. These instructions come from:
> 
>          cap->num_counters_gp = x86_pmu_num_counters(NULL)):
> 
> which will end up executing this statement:
> 
>          if (static_branch_unlikely(&perf_is_hybrid) && NULL)
> 	        <do something>;
> 
> This statement is optimized to do nothing because the condition is
> always false. But static_branch_unlikely() is implemented with a jump
> table inside an "asm goto" statement, and "asm goto" statements are
> not optimized.
> 
> So basically the code is optimized like this:
> 
>          if (static_branch_unlikely(&perf_is_hybrid))
> 	        ;
> 
> And this translates to the assembly code above.
> 
> 
> Examples:
> =========
> 
> Example 1 (--trace option): Trace the validation of the os_save() function
> --------------------------------------------------------------------------
> 
> $ ./tools/objtool/objtool --hacks=jump_label --hacks=noinstr --hacks=skylake --ibt --orc --retpoline --rethunk --sls --static-call --uaccess --prefix=16 --link --trace os_xsave -v vmlinux.o
> os_xsave: validation begin
>   59b20:  os_xsave+0x0                    push   %r12                                       - state: cfa=rsp+16 r12=(cfa-16) stack_size=16
>   59b22:  os_xsave+0x2	     		 mov    0x0(%rip),%eax        # 0x59b28 <alternatives_patched>
>   59b28:  os_xsave+0x8	     		 push   %rbp                                       - state: cfa=rsp+24 rbp=(cfa-24) stack_size=24
>   59b29:  os_xsave+0x9	     		 mov    %rdi,%rbp
>   59b2c:  os_xsave+0xc	     		 push   %rbx                                       - state: cfa=rsp+32 rbx=(cfa-32) stack_size=32
>   59b2d:  os_xsave+0xd	     		 mov    0x8(%rdi),%rbx
>   59b31:  os_xsave+0x11	     		 mov    %rbx,%r12
>   59b34:  os_xsave+0x14	     		 shr    $0x20,%r12
>   59b38:  os_xsave+0x18	    		 test   %eax,%eax
>   59b3a:  os_xsave+0x1a	     		 je     0x59b62 <os_xsave+0x42>                    - jump taken
>   59b62:  os_xsave+0x42	   	       | ud2
>   59b64:  os_xsave+0x44	   	       | jmp    0x59b3c <os_xsave+0x1c>                    - unconditional jump
>   59b3c:  os_xsave+0x1c	   	       | | xor    %edx,%edx
>   59b3e:  os_xsave+0x1e	   	       | | mov    %rbx,%rsi
>   59b41:  os_xsave+0x21	   	       | | mov    %rbp,%rdi
>   59b44:  os_xsave+0x24	   	       | | callq  0x59b49 <xfd_validate_state>             - call
>   59b49:  os_xsave+0x29	   	       | | mov    %ebx,%eax
>   59b4b:  os_xsave+0x2b	   	       | | mov    %r12d,%edx
>   	 		   	       | | / <alternative.59b4e> EXCEPTION for instruction at 0x59b4e <os_xsave+0x2e>
>   59b55:  os_xsave+0x35	   	       | | | test   %ebx,%ebx
>   59b57:  os_xsave+0x37	   	       | | | jne    0x59b66 <os_xsave+0x46>                - jump taken
>   59b66:  os_xsave+0x46	   	       | | | | ud2
>   59b68:  os_xsave+0x48	   	       | | | | pop    %rbx                                 - state: cfa=rsp+24 rbx=<undef> stack_size=24
>   59b69:  os_xsave+0x49	   	       | | | | pop    %rbp                                 - state: cfa=rsp+16 rbp=<undef> stack_size=16
>   59b6a:  os_xsave+0x4a	   	       | | | | pop    %r12                                 - state: cfa=rsp+8 r12=<undef> stack_size=8
>   59b6c:  os_xsave+0x4c	   	       | | | | jmpq   0x59b71 <__x86_return_thunk>         - return
>   59b57:  os_xsave+0x37	   	       | | | jne    0x59b66 <os_xsave+0x46>                - jump not taken
>   59b59:  os_xsave+0x39	   	       | | | pop    %rbx                                   - state: cfa=rsp+24 rbx=<undef> stack_size=24
>   59b5a:  os_xsave+0x3a	   	       | | | pop    %rbp                                   - state: cfa=rsp+16 rbp=<undef> stack_size=16
>   59b5b:  os_xsave+0x3b	   	       | | | pop    %r12                                   - state: cfa=rsp+8 r12=<undef> stack_size=8
>   59b5d:  os_xsave+0x3d	   	       | | | jmpq   0x59b62 <__x86_return_thunk>           - return
>   	 		   	       | | \ <alternative.59b4e> EXCEPTION end
> 				       | | / <alternative.59b4e> X86_FEATURE_XSAVES
>    1b2b:  .altinstr_replacement+0x1b2b  | | | xsaves64 0x40(%rbp)
>   59b53:  os_xsave+0x33		       | | | xor    %ebx,%ebx
>   59b55:  os_xsave+0x35		       | | | test   %ebx,%ebx                              - already visited
>   	 			       | | \ <alternative.59b4e> X86_FEATURE_XSAVES end
> 				       | | / <alternative.59b4e> X86_FEATURE_XSAVEC
>    1b26:  .altinstr_replacement+0x1b26  | | | xsavec64 0x40(%rbp)
>   59b53:  os_xsave+0x33		       | | | xor    %ebx,%ebx                              - already visited
>   	 			       | | \ <alternative.59b4e> X86_FEATURE_XSAVEC end
> 				       | | / <alternative.59b4e> X86_FEATURE_XSAVEOPT
>    1b21:  .altinstr_replacement+0x1b21  | | | xsaveopt64 0x40(%rbp)
>   59b53:  os_xsave+0x33		       | | | xor    %ebx,%ebx                              - already visited
>   	 			       | | \ <alternative.59b4e> X86_FEATURE_XSAVEOPT end
> 				       | | / <alternative.59b4e> DEFAULT
>   59b4e:  os_xsave+0x2e		       | | xsave64 0x40(%rbp)
>   59b53:  os_xsave+0x33		       | | xor    %ebx,%ebx                                - already visited
>   59b3a:  os_xsave+0x1a		       je     0x59b62 <os_xsave+0x42>                      - jump not taken
>   59b3c:  os_xsave+0x1c		       xor    %edx,%edx                                    - already visited
> os_xsave: validation end
> 
> 
> Example 2 (--disas option): Single Instruction Alternatives
> -----------------------------------------------------------
> Alternatives with single instructions are displayed on a single line.
> Instructions of the different alternatives are separated with a vertical
> bar (|).
> 
> 
> $ ./tools/objtool/objtool --disas=perf_get_x86_pmu_capability --link vmlinux.o
> perf_get_x86_pmu_capability:
>    deb0:  perf_get_x86_pmu_capability+0x0      endbr64
>    deb4:  perf_get_x86_pmu_capability+0x4      callq  0xdeb9 <__fentry__>
>    deb9:  perf_get_x86_pmu_capability+0x9      mov    %rdi,%rdx
>    debc:  perf_get_x86_pmu_capability+0xc      jmpq   0xdec1 <.altinstr_aux+0xfc> | NOP5  (X86_FEATURE_HYBRID_CPU) | jmpq   0x61a <perf_get_x86_pmu_capability+0x37>  (X86_FEATURE_ALWAYS)   # <alternative.debc>
>    dec1:  perf_get_x86_pmu_capability+0x11     ud2
>    dec3:  perf_get_x86_pmu_capability+0x13     movq   $0x0,(%rdx)
>    deca:  perf_get_x86_pmu_capability+0x1a     movq   $0x0,0x8(%rdx)
>    ded2:  perf_get_x86_pmu_capability+0x22     movq   $0x0,0x10(%rdx)
>    deda:  perf_get_x86_pmu_capability+0x2a     movq   $0x0,0x18(%rdx)
>    dee2:  perf_get_x86_pmu_capability+0x32     jmpq   0xdee7 <__x86_return_thunk>
>    dee7:  perf_get_x86_pmu_capability+0x37     cmpq   $0x0,0x0(%rip)        # 0xdeef <x86_pmu+0x10>
>    deef:  perf_get_x86_pmu_capability+0x3f     je     0xdec3 <perf_get_x86_pmu_capability+0x13>
>    def1:  perf_get_x86_pmu_capability+0x41     mov    0x0(%rip),%eax        # 0xdef7 <x86_pmu+0x8>
>    def7:  perf_get_x86_pmu_capability+0x47     mov    %eax,(%rdi)
>    def9:  perf_get_x86_pmu_capability+0x49     NOP2 | jmp    defb <perf_get_x86_pmu_capability+0x4b>  (JUMP)   # <alternative.def9>
>    defb:  perf_get_x86_pmu_capability+0x4b     mov    0x0(%rip),%rdi        # 0xdf02 <x86_pmu+0xd8>
>    df02:  perf_get_x86_pmu_capability+0x52     callq  0xdf07 <__sw_hweight64> | popcnt %rdi,%rax  (X86_FEATURE_POPCNT)   # <alternative.df02>
>    df07:  perf_get_x86_pmu_capability+0x57     mov    %eax,0x4(%rdx)
>    df0a:  perf_get_x86_pmu_capability+0x5a     NOP2 | jmp    df0c <perf_get_x86_pmu_capability+0x5c>  (JUMP)   # <alternative.df0a>
>    df0c:  perf_get_x86_pmu_capability+0x5c     mov    0x0(%rip),%rdi        # 0xdf13 <x86_pmu+0xe0>
>    df13:  perf_get_x86_pmu_capability+0x63     callq  0xdf18 <__sw_hweight64> | popcnt %rdi,%rax  (X86_FEATURE_POPCNT)   # <alternative.df13>
>    df18:  perf_get_x86_pmu_capability+0x68     mov    %eax,0x8(%rdx)
>    df1b:  perf_get_x86_pmu_capability+0x6b     mov    0x0(%rip),%eax        # 0xdf21 <x86_pmu+0xf8>
>    df21:  perf_get_x86_pmu_capability+0x71     mov    %eax,0xc(%rdx)
>    df24:  perf_get_x86_pmu_capability+0x74     mov    %eax,0x10(%rdx)
>    df27:  perf_get_x86_pmu_capability+0x77     mov    0x0(%rip),%rax        # 0xdf2e <x86_pmu+0x108>
>    df2e:  perf_get_x86_pmu_capability+0x7e     mov    %eax,0x14(%rdx)
>    df31:  perf_get_x86_pmu_capability+0x81     mov    0x0(%rip),%eax        # 0xdf37 <x86_pmu+0x110>
>    df37:  perf_get_x86_pmu_capability+0x87     mov    %eax,0x18(%rdx)
>    df3a:  perf_get_x86_pmu_capability+0x8a     movzbl 0x0(%rip),%ecx        # 0xdf41 <x86_pmu+0x1d1>
>    df41:  perf_get_x86_pmu_capability+0x91     movzbl 0x1c(%rdx),%eax
>    df45:  perf_get_x86_pmu_capability+0x95     shr    %cl
>    df47:  perf_get_x86_pmu_capability+0x97     and    $0x1,%ecx
>    df4a:  perf_get_x86_pmu_capability+0x9a     and    $0xfffffffe,%eax
>    df4d:  perf_get_x86_pmu_capability+0x9d     or     %ecx,%eax
>    df4f:  perf_get_x86_pmu_capability+0x9f     mov    %al,0x1c(%rdx)
>    df52:  perf_get_x86_pmu_capability+0xa2     jmpq   0xdf57 <__x86_return_thunk>
> 
> 
> Example 3 (--disas option): Alternatives with multiple instructions
> -------------------------------------------------------------------
> Alternatives with multiple instructions are displayed side-by-side, with
> an header describing the alternative. The code in the first column is the
> default code of the alternative.
> 
> 
> $ ./tools/objtool/objtool --disas=__switch_to_asm --link vmlinux.o
> __switch_to_asm:
>    82c0:  __switch_to_asm+0x0      push   %rbp
>    82c1:  __switch_to_asm+0x1	  push   %rbx
>    82c2:  __switch_to_asm+0x2	  push   %r12
>    82c4:  __switch_to_asm+0x4	  push   %r13
>    82c6:  __switch_to_asm+0x6	  push   %r14
>    82c8:  __switch_to_asm+0x8	  push   %r15
>    82ca:  __switch_to_asm+0xa	  mov    %rsp,0x1670(%rdi)
>    82d1:  __switch_to_asm+0x11	  mov    0x1670(%rsi),%rsp
>    82d8:  __switch_to_asm+0x18	  mov    0xad8(%rsi),%rbx
>    82df:  __switch_to_asm+0x1f	  mov    %rbx,%gs:0x0(%rip)        # 0x82e7 <__stack_chk_guard>
>    82e7:  __switch_to_asm+0x27	  | <alternative.82e7>                   | !X86_FEATURE_ALWAYS                  | X86_FEATURE_RSB_CTXSW
>    82e7:  __switch_to_asm+0x27	  | jmp    0x8312 <__switch_to_asm+0x52> | NOP1                                 | mov    $0x10,%r12
>    82e8:  __switch_to_asm+0x28	  |                                      | NOP1                                 |
>    82e9:  __switch_to_asm+0x29	  | NOP1                                 | callq  0x82ef <__switch_to_asm+0x2f> |
>    82ea:  __switch_to_asm+0x2a	  | NOP1                                 |                                      |
>    82eb:  __switch_to_asm+0x2b	  | NOP1                                 |                                      |
>    82ec:  __switch_to_asm+0x2c	  | NOP1                                 |                                      |
>    82ed:  __switch_to_asm+0x2d	  | NOP1                                 |                                      |
>    82ee:  __switch_to_asm+0x2e	  | NOP1                                 | int3                                 | callq  0x82f4 <__switch_to_asm+0x34>
>    82ef:  __switch_to_asm+0x2f	  | NOP1                                 | add    $0x8,%rsp                     |
>    82f0:  __switch_to_asm+0x30	  | NOP1                                 |                                      |
>    82f1:  __switch_to_asm+0x31	  | NOP1                                 |                                      |
>    82f2:  __switch_to_asm+0x32	  | NOP1                                 |                                      |
>    82f3:  __switch_to_asm+0x33	  | NOP1                                 | lfence                               | int3
>    82f4:  __switch_to_asm+0x34	  | NOP1                                 |                                      | callq  0x82fa <__switch_to_asm+0x3a>
>    82f5:  __switch_to_asm+0x35	  | NOP1                                 |                                      |
>    82f6:  __switch_to_asm+0x36	  | NOP1                                 |                                      |
>    82f7:  __switch_to_asm+0x37	  | NOP1                                 |                                      |
>    82f8:  __switch_to_asm+0x38	  | NOP1                                 |                                      |
>    82f9:  __switch_to_asm+0x39	  | NOP1                                 |                                      | int3
>    82fa:  __switch_to_asm+0x3a	  | NOP1                                 |                                      | add    $0x10,%rsp
>    82fb:  __switch_to_asm+0x3b	  | NOP1                                 |                                      |
>    82fc:  __switch_to_asm+0x3c	  | NOP1                                 |                                      |
>    82fd:  __switch_to_asm+0x3d	  | NOP1                                 |                                      |
>    82fe:  __switch_to_asm+0x3e	  | NOP1                                 |                                      | dec    %r12
>    82ff:  __switch_to_asm+0x3f	  | NOP1                                 |                                      |
>    8300:  __switch_to_asm+0x40	  | NOP1                                 |                                      |
>    8301:  __switch_to_asm+0x41	  | NOP1                                 |                                      | jne    0x82ee <__switch_to_asm+0x2e>
>    8302:  __switch_to_asm+0x42	  | NOP1                                 |                                      |
>    8303:  __switch_to_asm+0x43	  | NOP1                                 |                                      | lfence
>    8304:  __switch_to_asm+0x44	  | NOP1                                 |                                      |
>    8305:  __switch_to_asm+0x45	  | NOP1                                 |                                      |
>    8306:  __switch_to_asm+0x46	  | NOP1                                 |                                      | movq   $0xffffffffffffffff,%gs:0x0(%rip)        # 0x20b <__x86_call_depth>
>    8307:  __switch_to_asm+0x47	  | NOP1                                 |                                      |
>    8308:  __switch_to_asm+0x48	  | NOP1                                 |                                      |
>    8309:  __switch_to_asm+0x49	  | NOP1                                 |                                      |
>    830a:  __switch_to_asm+0x4a	  | NOP1                                 |                                      |
>    830b:  __switch_to_asm+0x4b	  | NOP1                                 |                                      |
>    830c:  __switch_to_asm+0x4c	  | NOP1                                 |                                      |
>    830d:  __switch_to_asm+0x4d	  | NOP1                                 |                                      |
>    830e:  __switch_to_asm+0x4e	  | NOP1                                 |                                      |
>    830f:  __switch_to_asm+0x4f	  | NOP1                                 |                                      |
>    8310:  __switch_to_asm+0x50	  | NOP1                                 |                                      |
>    8311:  __switch_to_asm+0x51	  | NOP1                                 |                                      |
>    8312:  __switch_to_asm+0x52	    pop    %r15
>    8314:  __switch_to_asm+0x54	    pop    %r14
>    8316:  __switch_to_asm+0x56	    pop    %r13
>    8318:  __switch_to_asm+0x58	    pop    %r12
>    831a:  __switch_to_asm+0x5a	    pop    %rbx
>    831b:  __switch_to_asm+0x5b	    pop    %rbp
>    831c:  __switch_to_asm+0x5c	    jmpq   0x8321 <__switch_to>
> 
> 
> Example 4 (--disas option): Alternative with direct call
> --------------------------------------------------------
> An alternative with a direct call show the pv_ops call and
> the default pv_ops function for this call.
> 
> $ ./tools/objtool/objtool --disas=paravirt_read_msr --link vmlinux.o
> paravirt_read_msr:
>    c3d0:  paravirt_read_msr+0x0      mov    %edi,%edi
>    c3d2:  paravirt_read_msr+0x2	    callq  *0x0(%rip)  # 0xc3d8 <pv_ops+0xb0> | callq  pv_ops[22] ~ native_read_msr  (+X86_FEATURE_ALWAYS)   # <alternative.c3d2>
>    c3d8:  paravirt_read_msr+0x8	    jmpq   0xc3dd <__x86_return_thunk>
> 
> 
> Example 5 (--disas option): Alternative with direct call for XENPV
> ------------------------------------------------------------------
> An alternative with a direct call in the XENPV case show the pv_ops
> function for XEN.
> 
> early_ioremap_pmd:
>   332d0:  early_ioremap_pmd+0x0      push   %rbx
>   332d1:  early_ioremap_pmd+0x1	    mov    %rdi,%rbx
>   332d4:  early_ioremap_pmd+0x4	    callq  *0x0(%rip)        # 0x332da <pv_ops+0x150> | mov    %cr3,%rax  (!X86_FEATURE_XENPV) | callq  xen_read_cr3  (+X86_FEATURE_ALWAYS)   # <alternative.332d4>
>   332da:  early_ioremap_pmd+0xa	    mov    0x0(%rip),%rdx        # 0x332e1 <sme_me_mask>
>   332e1:  early_ioremap_pmd+0x11	    mov    0x0(%rip),%ecx        # 0x332e7 <pgdir_shift>
>   332e7:  early_ioremap_pmd+0x17	    mov    %rbx,%rsi
>   332ea:  early_ioremap_pmd+0x1a	    and    0x0(%rip),%rax        # 0x332f1 <physical_mask>
>   332f1:  early_ioremap_pmd+0x21	    not    %rdx
>   332f4:  early_ioremap_pmd+0x24	    and    %rdx,%rax
>   332f7:  early_ioremap_pmd+0x27	    mov    %rbx,%rdx
>   332fa:  early_ioremap_pmd+0x2a	    shr    %cl,%rdx
>   332fd:  early_ioremap_pmd+0x2d	    and    $0xfffffffffffff000,%rax
>   33303:  early_ioremap_pmd+0x33	    add    0x0(%rip),%rax        # 0x3330a <page_offset_base>
>   3330a:  early_ioremap_pmd+0x3a	    and    $0x1ff,%edx
>   33310:  early_ioremap_pmd+0x40	    lea    (%rax,%rdx,8),%rdi
>   33314:  early_ioremap_pmd+0x44	    callq  0x33319 <p4d_offset+0x0>
>   33319:  early_ioremap_pmd+0x49	    mov    (%rax),%rdi
>   3331c:  early_ioremap_pmd+0x4c	    callq  *0x0(%rip)        # 0x33322 <pv_ops+0x228> | mov    %rdi,%rax  (!X86_FEATURE_XENPV) | callq  __raw_callee_save_xen_p4d_val  (+X86_FEATURE_ALWAYS)   # <alternative.3331c>
>   33322:  early_ioremap_pmd+0x52	    mov    0x0(%rip),%rdx        # 0x33329 <page_offset_base>
>   33329:  early_ioremap_pmd+0x59	    and    0x0(%rip),%rax        # 0x33330 <physical_mask>
>   33330:  early_ioremap_pmd+0x60	    and    $0xfffffffffffff000,%rax
>   33336:  early_ioremap_pmd+0x66	    mov    0xff8(%rax,%rdx,1),%rdi
>   3333e:  early_ioremap_pmd+0x6e	    callq  *0x0(%rip)        # 0x33344 <pv_ops+0x210> | mov    %rdi,%rax  (!X86_FEATURE_XENPV) | callq  __raw_callee_save_xen_pud_val  (+X86_FEATURE_ALWAYS)   # <alternative.3333e>
>   33344:  early_ioremap_pmd+0x74	    mov    0x0(%rip),%rcx        # 0x3334b <physical_mask>
>   3334b:  early_ioremap_pmd+0x7b	    mov    %rcx,%rdx
>   3334e:  early_ioremap_pmd+0x7e	    and    $0xfffffffffffff000,%rdx
>   33355:  early_ioremap_pmd+0x85	    and    $0x80,%dil
>   33359:  early_ioremap_pmd+0x89	    je     0x33365 <early_ioremap_pmd+0x95>
>   3335b:  early_ioremap_pmd+0x8b	    and    $0xffffffffc0000000,%rcx
>   33362:  early_ioremap_pmd+0x92	    mov    %rcx,%rdx
>   33365:  early_ioremap_pmd+0x95	    and    %rax,%rdx
>   33368:  early_ioremap_pmd+0x98	    add    0x0(%rip),%rdx        # 0x3336f <page_offset_base>
>   3336f:  early_ioremap_pmd+0x9f	    pop    %rbx
>   33370:  early_ioremap_pmd+0xa0	    lea    0xfc8(%rdx),%rax
>   33377:  early_ioremap_pmd+0xa7	    jmpq   0x3337c <__x86_return_thunk>
> 
> -----
> 
> Alexandre Chartre (28):
>    objtool: Move disassembly functions to a separated file
>    objtool: Create disassembly context
>    objtool: Disassemble code with libopcodes instead of running objdump
>    tool build: Remove annoying newline in build output
>    objtool: Print symbol during disassembly
>    objtool: Store instruction disassembly result
>    objtool: Disassemble instruction on warning or backtrace
>    objtool: Extract code to validate instruction from the validate branch
>      loop
>    objtool: Record symbol name max length
>    objtool: Add option to trace function validation
>    objtool: Trace instruction state changes during function validation
>    objtool: Improve register reporting during function validation
>    objtool: Identify the different types of alternatives
>    objtool: Improve tracing of alternative instructions
>    objtool: Do not validate IBT for .return_sites and .call_sites
>    objtool: Add the --disas=<function-pattern> action
>    objtool: Print headers for alternatives
>    objtool: Disassemble group alternatives
>    objtool: Print addresses with alternative instructions
>    objtool: Disassemble exception table alternatives
>    objtool: Disassemble jump table alternatives
>    objtool: Fix address references in alternatives
>    objtool: Provide access to feature and flags of group alternatives
>    objtool: Function to get the name of a CPU feature
>    objtool: Improve naming of group alternatives
>    objtool: Get the destination name of a PV call
>    objtool: Improve the disassembly of the pv_ops call
>    objtool: Print single line for alternatives with one instruction
> 
>   .../x86/tools/gen-cpu-feature-names-x86.awk   |   33 +
>   tools/build/Makefile.feature                  |    4 +-
>   tools/objtool/Build                           |    3 +
>   tools/objtool/Makefile                        |   23 +
>   tools/objtool/arch/loongarch/decode.c         |   30 +
>   tools/objtool/arch/loongarch/special.c        |    5 +
>   tools/objtool/arch/powerpc/decode.c           |   31 +
>   tools/objtool/arch/powerpc/special.c          |    5 +
>   tools/objtool/arch/x86/Build                  |    8 +
>   tools/objtool/arch/x86/decode.c               |   36 +-
>   tools/objtool/arch/x86/special.c              |   10 +
>   tools/objtool/builtin-check.c                 |    5 +-
>   tools/objtool/check.c                         |  745 ++++++-----
>   tools/objtool/disas.c                         | 1137 +++++++++++++++++
>   tools/objtool/include/objtool/arch.h          |   14 +-
>   tools/objtool/include/objtool/builtin.h       |    2 +
>   tools/objtool/include/objtool/check.h         |   41 +-
>   tools/objtool/include/objtool/disas.h         |   71 +
>   tools/objtool/include/objtool/elf.h           |    7 +
>   tools/objtool/include/objtool/objtool.h       |    6 +-
>   tools/objtool/include/objtool/special.h       |    4 +-
>   tools/objtool/include/objtool/trace.h         |  121 ++
>   tools/objtool/include/objtool/warn.h          |   17 +-
>   tools/objtool/objtool.c                       |   27 +-
>   tools/objtool/special.c                       |    2 +
>   tools/objtool/trace.c                         |  204 +++
>   26 files changed, 2271 insertions(+), 320 deletions(-)
>   create mode 100644 tools/arch/x86/tools/gen-cpu-feature-names-x86.awk
>   create mode 100644 tools/objtool/disas.c
>   create mode 100644 tools/objtool/include/objtool/disas.h
>   create mode 100644 tools/objtool/include/objtool/trace.h
>   create mode 100644 tools/objtool/trace.c
> 


