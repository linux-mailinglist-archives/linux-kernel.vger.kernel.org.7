Return-Path: <linux-kernel+bounces-749152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99299B14ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B493A9D1B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CA027A92E;
	Tue, 29 Jul 2025 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lU60yyZA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nbZf19Qp"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D1D23535F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780025; cv=fail; b=DqeUkkOfDEt4W1bX1SzcdkE3VsiF6kvVRwXIQ4SoDT2BsmnuOSD104kIEOsJuEheQ6DVkoi8QWI0UVizfJnvmvTkEqc6cN37ZJjUt4nDmpclKiScxcWhPjjEr8Q7lef/khnGdJ6c/JGGzm6Nl6fDfbusCLWBOqMskj8cgnfl3BI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780025; c=relaxed/simple;
	bh=S1dnyZpt/jbhkN+DgT8AZAe3/tYhJefRE1JSXUK/rNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hNGWRi+6RLyxNRe7/sbsNJLQyxDKpFaO2OSiWyqt9LaIjAx6tSyzs8OAW3HhQeJKU1IHb7rsz+sa2Nc1iGR2ZfdH+IaweQ0bVvmGpw45CTuad6+h2BnVtzYcI1/2x8lLIeUGSlouH7td+X3mWNO+jeOaKC+57doT22c7eXLLaoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lU60yyZA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nbZf19Qp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T7gRPF015348;
	Tue, 29 Jul 2025 09:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=scxHVMgsOueIgoc02KRJ2RWquc7IjLF997Gh8+8iph8=; b=
	lU60yyZAIn6QvRQf08WiILFHYRczc4Fhcm7/0QwwoSiB4NQRPyMgZebwMLJbbIqV
	xYPWqpKcsGlcmyozgS6yQiMQ3cHwSLcI6VhTYrD3ZVebTDHV+nrDxKhPOeruLHWg
	DLdoFws7RTeXT6SOpkX3AhILwROjsDZpDK59p9M6IX2kkLzq4slPaFzhcoXunc2V
	VDw1KUX+gOm+LFNDtOxWsQchg5lgS8Cw6o1VDH8k2Spc5gThfuFmJVvRo9A3Idv/
	uJnuyNeDiixeTwhIw/tuv3lnSnrwPVvyx896HEWYoDOJf1N3kpU/Vnp1cLjxR5Qs
	SWop3Xu/kvUf03Rlfqlncg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484qjwq9as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 09:06:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56T96XgU020528;
	Tue, 29 Jul 2025 09:06:46 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nffx84b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 09:06:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsSmovPwdR1hBN1N2sifr2QauaMq+meW1kDN9pmisp0C616/+NETFmcCqZcthuR7FipT50bX8mGIETJ2+jlOnuRLkSG6QosniPz6NQgtXPJ+sqPRirckQj0aiul+iIrbxDV9A3bhaPpdxX+Sq+FSCAQ3HnKwgsQ1GMpz+7bipKTrBENMaoubhzjgQWcfbV8mJ/i7Y8LOoA4b+/pNCsU+/LiaK6QBYVhqYdcHm5GygP8RBepmNO3fvkwKgELuHDImH8dSmiuFcdfzd7u7mu5wkiDAX4plBGnLz6wVQjNA7fJQtcxfIUum7Nb0JYboM0mrun52PRnYM1P+Z0/uqmw+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scxHVMgsOueIgoc02KRJ2RWquc7IjLF997Gh8+8iph8=;
 b=Y1D1XG/YJwoMiytEmvXLrPm/Do3cBZ1PUbXDK9lIwa2vOYOimPxcNuzzg1M5T7odD5fh8k3Y74QFwtOG2eyJQxd7E5qYVQTeTeuwCwv8wG/CjBct+JtTdwGzz7yJxpo3kdr7s7O7OKRAgYo1cKoO/oikfjyTAUYYUpaCYfSnKXibI3gIsTfXD8WX28Nl9QSE7UpD2U0fBjCPgLF8EvwGXSO4YYv3USCnQQv+iKZYHMlnT9Nq3oYu5abQFTgqhxjFdza3XP8UkHlldVNmTAgI8Nq2SYtN6IF1GMUOhgWie1I/0sZ4XT+L1Q9ZFipSmfX/CBNOl6BIv7gopDCe49Mdvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scxHVMgsOueIgoc02KRJ2RWquc7IjLF997Gh8+8iph8=;
 b=nbZf19QpKaoUb/KofALLVBpJGvbtg4JGF1Q0YvBLd3uEcAZYGXIW9vwoqwatRDcaccL+j+xi8pL4T0aeR2+7ixOFiyVjq9FMDzPr8iBkh2vNzQyaUx0Y5faSgpHd1NyfS2gITCiUzj7WTlufketBUpBlzXBmPRhvkU42qmSUBFc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7524.namprd10.prod.outlook.com (2603:10b6:8:15c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 09:06:44 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 09:06:44 +0000
Date: Tue, 29 Jul 2025 10:06:40 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
        jannh@google.com, pfalcato@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, niecheng1@uniontech.com,
        guanwentao@uniontech.com, Jun Zhan <zhanjun@uniontech.com>
Subject: Re: [PATCH] tools/testing/vma: Fix function parameter declarations
 for GCC 8.3 compatibility
Message-ID: <e7554f93-03e8-4315-acb7-a55312354485@lucifer.local>
References: <EFCEBE7E301589DE+20250729084700.208767-1-wangyuli@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EFCEBE7E301589DE+20250729084700.208767-1-wangyuli@uniontech.com>
X-ClientProxiedBy: MM0P280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::28) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d53e1b-1885-41ae-5e0a-08ddce7f3d60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzZseUlRbEdocVpSUjhacFRGbWlwakpBQ05iMHNBVzRmbGd2VUZlUDNvQ2l0?=
 =?utf-8?B?eFY5bHNqWkJzYnVMMU9sSVU3dzFHdXl0REtQU3dmcU12a3RNZ1NXQzRZSlhV?=
 =?utf-8?B?cnNzY1RKS0R2bFdQREgyZFg5ZEQ3ZXdIS0dzYnlqbmtqcDBVcnQweVNHc0Jn?=
 =?utf-8?B?dkJDUndOM0kyOFVVN3ByQ05YN1ZUdEEzUmYvTm9ySWFYUHhCMGtIczRodlBq?=
 =?utf-8?B?dDJoTFRna0VCc0V2a2laMTQ3dTU2SUtiL09VTHFSTWNGanZuU2tBczkwNXNN?=
 =?utf-8?B?c0JhQ28zNXp3aXZyV29NZDhEWHdndk41WGRNZ0tnUnAxeGpYL0U1ZFJuRy9n?=
 =?utf-8?B?Q1JYYnFWNitiZmFtc0VFV0FMZVFLV2Z3aGY4WDY3RmdLTlpHZDkwblNEb0Rt?=
 =?utf-8?B?RlVoTTBOVVExYmJTb1JxSWNTZ3Y5NE5nYUludWhSZndiRVRTZnNkVmNZMGQ4?=
 =?utf-8?B?cEMra2RmdURiZ1ljejJmR0RvL0U3K3FUZld4ajVTTlh1eGlhRDNYakVTRWxi?=
 =?utf-8?B?NDBNV2toVXZvQUg5SGtnUlV2eXZZd2o4V1VTMmFrQ1B1dVdtd0RlaklUZDlI?=
 =?utf-8?B?T3J0QmE4Z0RnR1E5NlVhN0dyN1ZpTTNsa3dSUERBVjhmSnFZY2Z1ZGExeCtC?=
 =?utf-8?B?S2p1Q09TSDRjRDRqdFJodkxpdHJVZnVkZnU3ZysvL1R5RHRWNkgvOCtOZjhy?=
 =?utf-8?B?cjYvOFBaMktLalVDWGdrVUFFZTBsc3h0eDVtd0tSeUFmMTlJWHNLNHpmWnVY?=
 =?utf-8?B?bFFOWnN4M2pGMFliei9JNElqV2tPbHdpTG1oS2tOWURtUEtJRE1SYld1QmhP?=
 =?utf-8?B?eXh1M3BkS09SNU1RZnVKdFU3NDdhcDNyRk1tb00zWDFSUVJ2b2NIMDBVdzhX?=
 =?utf-8?B?VFhWaVFFcGtqN21weWl5THJpNnZtbmdwakdiS2R1Snk2V0xsdno4MzhlZktq?=
 =?utf-8?B?Q3RHL3EwakpvZTJLbHRNZk1zQW1aeklIaXNpOUFCb0RWY0FXOFlqZkMyTHBi?=
 =?utf-8?B?RWliTmdrTXNSTjUrb1ZtVWYxVXZncFJrTzEzTFNNY2NzVlBocEVOTVJzL2ky?=
 =?utf-8?B?VlRzREJiRm5lUGFGRHdLK1hQakUzN1ZzbER2djR1L2RXelhIV3ZQbEtIL1VN?=
 =?utf-8?B?S00rWDlvdW41U1FJeGYzMnEzRjNQV0I3YW1SUlE2cDVVcUdycnY1Wmk5eTZD?=
 =?utf-8?B?dGVKdWdDRWY2ellsajdEc3Q2R2JxaXlGenV5WkxnZXdjdE1XNTV1NGl1QkU5?=
 =?utf-8?B?TUdUa3g2M00wczZGalFINXIrMm5aT3pvZUMyaVV2eWwxSGY2QmdYNFFLaE1N?=
 =?utf-8?B?V0FpK29WamJjczZDSnJRZmxCTk1FU0lOKy9OUFNhWEpkVDBlaFhZZHZTUnJJ?=
 =?utf-8?B?d0pSUktrdDZoVERXc3JPaFhoRFVrRklaZHNoMVRMOUVmMDI0Sy9pdi9DT0g3?=
 =?utf-8?B?VU9qSHh6L3ZSNmlMUThlNVVjcWJ4NFlyMHFGY2swMmRWdzJHZHQvNnB0Unhn?=
 =?utf-8?B?T0tqVHc1MlpGUk9YMjJNT045ZmpmeUdrbzZwTXVHVlc1N0RWZElDZnZsVFpH?=
 =?utf-8?B?N2t6Mi9CcURPSE5sRnppV1JBb2lVOTIrcGNFamdHaVNCeU9FYlhJK3d3K1NH?=
 =?utf-8?B?enJvTFpaRTM1QmJNZmsyMWZMYnkwcER6YlFpaVF1dzgwaCtyWFNjblJIUlRp?=
 =?utf-8?B?NWgzV3BqaVB2Z2Z1YmVhTThZeFRtci9hY2FIdTlpWmVBUm9LRGsxVTdQdVZh?=
 =?utf-8?B?ZEdNa1lETFlFbHp2RCtxSEE3M0VMZHlYb3JVRlV4MHRyclVwa2RwQ0dsV2pn?=
 =?utf-8?B?aUFrQTlSN3J2YVd1eDhaRHZGMlJHNkkycmdNTUxXSHZoaGFHZ1pkSDJwcWYx?=
 =?utf-8?B?OWUyMTFCSDZOUmtRVmZYdnBrV0xpWlpBZnhvOG1jODlGMXI1NTF1azNJVFhZ?=
 =?utf-8?Q?y5LW/2bZsOs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDRwc2dFUnM5UkNmYXY0TFQ3RGFDMmRoODQ1R1NZRUlpOXNSY2VVTEloQ1pj?=
 =?utf-8?B?dGEzalJqQnY5VzdGbm1xbkVkREJNclRxSlBOZ0pUTjJTOW9jUlZPNmNZdzF2?=
 =?utf-8?B?UGhXODNoTHJlSjJDZTR6QnpGMUZPT1gvM1FhdjIwZUFWMDBBRjZoR0VSRldU?=
 =?utf-8?B?aE82d1NvaGNONmdtTC83M1AxSHFubmhvMVVUek1HbllqZ0xEQmgrZXNBMmRM?=
 =?utf-8?B?TWEyRkdnTnphSUVIYTNMdHhOc0RpZ3orY2NQNy9FdkdPMWZkVkNOMytTamJa?=
 =?utf-8?B?OGpHL1UwdWphRFZvUFFmZmwvRFlLbGwxT3VIRit2ck1rTUpPLy9UVHpFVVZj?=
 =?utf-8?B?ci9ZTllTSzJDd2hGbXl3Z0VWK0ZZelhFQWlyU09rRENKSmZxbXZzZ1laUjBK?=
 =?utf-8?B?WFp2K2lHbkJ1dDIyTGRuQVhPVzA0dFM0SWFMbldxSkRsTStJMmVqbnFxSDl1?=
 =?utf-8?B?NWV2WFp4Z0FmQis4ckpxOTdxK0dlcTRXa1UzL3RHQVNsZFRkUlp4MTRpdS9P?=
 =?utf-8?B?anZmQXN0b0lhRHo4bEJ0SzVWcllHZE5GMGpGV2VNb2tSNGp6K3ZaQ2k2T0Ew?=
 =?utf-8?B?Skc0Y2dEamdpUmpEMDVsSlNwZEdCd3ViS20reTgvL2NVa2IwWHRMNnJnaWZF?=
 =?utf-8?B?VlExb1ZpWUtSZ2FCY29Ga1RmeFpNODZBSGJTWmNJZkMwOE1JWGU3NUxJU3g0?=
 =?utf-8?B?Mnl0QmpGNmFoaktmdE1OajhmdWw5SVBQdmt0NTluUStZRkhYMjRxQ2xHOXZk?=
 =?utf-8?B?SndhN08zNE91VlN2SmxWSFJWWEYycUtyNm1lU3FuakUxMjN2RndGL3BtMUEw?=
 =?utf-8?B?Z2M1N1kvRWhub1FkK1laM3NLYlpsSEI5QWJkTDVURDU4K3Z3SVR4WTZ4ck8y?=
 =?utf-8?B?N1AzME1vUVhDZFkyRGpaTHdDV2hkUHd0cHlPWnB1NzQrRThuVXJVeWJ0TVBa?=
 =?utf-8?B?ZjhzbTVvdmprWWYxRVI4UHZMOU1RQTZzRmhDSC9ML1NHcDRVTWNpbStwSHVp?=
 =?utf-8?B?N01kdkNTUHdlSW9YV2Njc1VyeGZ5SERGZ3dBZ0pFTVhXcFlLYjJHcDFPYTlI?=
 =?utf-8?B?UlJ6Nm0wWUdnYlRPaDNLZmU0cG84aDRrS2tKS0NTOFV2b05nSlJuZjVvdFho?=
 =?utf-8?B?U3lobTRnRDJjTUdMaVVsSGw4M2JhdElCbDNIL2w5MU4rOHlsdDBXMkVFUTBY?=
 =?utf-8?B?U0xTb3NoWUcxdXg2clhJZm82V3ZUMjY4REJJU0N3Z3JNOVRNRDVKQ1Rqb0lp?=
 =?utf-8?B?QjgzM3NneDdER1JyQ1FzUXV6MHBzZVVNZWxmMUNKOTlQOFJub1lPYnE3Qkhy?=
 =?utf-8?B?S2lJei90S1NZdGZiQnJZQm5TSlVIUmFmNkpUbWttUmtuWW43TkJiMEhITnI4?=
 =?utf-8?B?YkM1T3Z2TC9taEFHT1I1MXdhRU45dFROemF3VldEY1luZDUyTWJWVnJSSkZy?=
 =?utf-8?B?aVVZMlBLU0tRL3lFZk5pVGxKdmVVUmdjQVQ3QjAwT2ttQlpQYklHcGpzRlE4?=
 =?utf-8?B?SVJMMEJlNEpJWFcrRnlyMkg1M3RQWGV0THM3bmhtK3VaRTVSS2R0MG1IRjRm?=
 =?utf-8?B?eXplQWxMaGw5b2F6ejFNNGxDNkhJaGMxR0pmcWhjL3hOb2pVbEtpZzVGWE5K?=
 =?utf-8?B?QzEvSjZHNmZEK1dlcjBkVEhpL0xiYnBBV29FRDhxWEJ6em0waDlyeFJvWWc0?=
 =?utf-8?B?RUZVUFdCR3puRzNhRlFjbkd0ajBVb0JQTlE5MWVTUzZWdXg2aGt5KzZZdUFC?=
 =?utf-8?B?VWhORi8wU3hiSU5oczMzekNHeFdiSzJFOUFnSmdubXUvY1hCK2JrT1MxRk9X?=
 =?utf-8?B?djBjS1dJYXZ6Z0RuQzF4WVVpOVBlSzJzSE9iaUtoKzJBVTB2alpudWk5MmNQ?=
 =?utf-8?B?QzlMU0R2Y3ROMEk5blV0V2JETzZack43bTJwWGRacEdVZ2I1dGFUTDNZRTFw?=
 =?utf-8?B?dTJLRldNVjgrSk1OdVN3M1RKNFlIQ01GaE94N2M2YzlhMHNaSG1PY3VVdlJT?=
 =?utf-8?B?MTdxSUZIOXhheVhxbFRzaWxzc0pYYUtDTERBejFEQTF3N0ozMlpVRjBKZnh0?=
 =?utf-8?B?a29CZFFmM25DSnNNYzRXUlduZHFrcFMreHVHTHN6YithL1dDMDdJckVRZEps?=
 =?utf-8?B?NXJJTk5QQjBJS2dBd0JNUWM2d0Y5SGZOdFgwUFpZL2FYUy96Sjg0SjhEZ2t5?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4L9/iqYaoSRCRKorGjkZmYaLEop2FGTq41Tf98/53GLqXTwLFPdPXaT3oX7pqJQFYEwDzrqAnRwEje1AiFUyuDkap84gRsLhzYq3ANxn/2SvtwdC8PQuwnXy3/OxLwWwK7w6WSiRlBiNHTUs3RQRAeJ/GYW3ExewuciHbxBQ5tU2ldeWA1/0KIdmpQn++B/MCIKL5EGOCBPM6A8nziGqHVKWB2oha36PSuePrUigvnqc4ERLbEQj46qszu9qqwbMPCOYjF25ALNM0M6KcWTZbYGtqZqc069NbGtT1agFVLK+8SWnl30gqJ5BhLM/BG+d2VgOvy8vMmNi3gbTP6J2pYwOHYfoe3JdNv7DQgPV9oOGt9KNjp8eAqBWd2uOay7hU70W3+gYhs1LohObK07b9FVRJQhbJvG5ZdCRPKrCa8qDm9SeRHTVnbI2krSJj2gsMqVqAqdvcnXZdL8C8TAOxZd1iKRCTk5/MCWO8IEzxNqKdd+df5nvsQWCK/SNr1n84eYPlW3aZsuUZ2YMl42CP6i73QLheenL0rWJ8mggXMW7e9KFghC0ZwLATSgCgtT6mNCknvVlw7l29SdBD6RrmpCF+pJAiJy8oDU2YQnHf/I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d53e1b-1885-41ae-5e0a-08ddce7f3d60
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 09:06:44.2955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSOOBYtIYCcJmf35Euv6v/0x7vZ3QHzChjRE8xWV+C5/FSAgMCoSH+66RIm9UOSotpYe6nzoqhuupX/VPBbAdrFQsPKpdT37iYM/sDE47jA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7524
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_02,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=766 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507290070
X-Authority-Analysis: v=2.4 cv=OvdPyz/t c=1 sm=1 tr=0 ts=68888f27 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=iHwBjlyiAAAA:8 a=i7JKvcW0x9HuoAmKtocA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uNSKXYNwxGiU6LD0JREI:22 cc=ntf
 awl=host:12071
X-Proofpoint-GUID: Sv8YXlRh7AZtlg3Q2rNJ9b-Ntnu9HITN
X-Proofpoint-ORIG-GUID: Sv8YXlRh7AZtlg3Q2rNJ9b-Ntnu9HITN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA3MCBTYWx0ZWRfXwmxT2S2TbL7v
 zSIAQ8yb7S+GLbO0Dt+V7ZeUHkI0a0/ecQObOe58yIZsenv0LU4gLMMVf1Isarb005FELbbhFh4
 SciQ0mCrYbE7vhsIy8rsxFwiM0N2psA6wZ17bFexby2nmcnQGNal+1VkvjIdEbsl4KdFhNVv0jN
 S4c1j3YV9rHmKZZ1SOpttuW+VhVEj/aZgXgpmPD/IXliymk+eS5CNT8v5UuqTS8+YjpIbZlCqUR
 Q/lri6OUEF3XFuGxidA2USJlJ2eFplTcDhneEBfom5p2V2b9nMGIJshY14XllAU9GjSKg8iCIAM
 Mjxqw/mLGa4Chpr5q/bkTT8Q150mS1NSSnxcsglTFb5pk3YEhbcJYBOCEqRX7y5pAP229ZPZZdN
 hV/jKo6TRGbdJt5pw9UmFlDdPP2g8KJ8CNlBqewF9m0iJNFa27s0CBZn6bBsltCsXyqrCo0i

On Tue, Jul 29, 2025 at 04:47:00PM +0800, WangYuli wrote:
> The Linux kernel's minimum GCC version requirement has been bumped
> from 4.3 to 8.3, but this tool still fails to compile with GCC 8.3.

Why people keep reporting this for my VMA test series but _not_ the kernel
as a whole I don't know.

$ grep "\*);" include/linux/mm.h | wc -l
9

^--- If you use such a compiler, the kernel won't build.

So the bug is whoever is saying a version of gcc that does the below (I'll
take your word for it that this is in a normal configuraiton) is OK for the
kernel.

It's clearly not.

Oh just to underline things:

$ find include/linux -name '*.h' | xargs grep "\*);" | wc -l
1899

So y'know.

>
> Older compilers would fail if did not include parameter names in
> function declarations that contained parameter types; newer compilers
> are more lenient about this.

You're using a compiler that won't build linux. Stop it?

>
> Fix many errors like this:
>   In file included from vma.c:10:
>   vma_internal.h: In function ‘arch_validate_flags’:
>   vma_internal.h:1218:40: error: parameter name omitted
>    static inline bool arch_validate_flags(unsigned long)
>                                         ^~~~~~~~~~~~~
>   vma.c: In function ‘dummy_close’:
>   vma.c:281:25: error: parameter name omitted
>    static void dummy_close(struct vm_area_struct *)
>                          ^~~~~~~~~~~~~~~~~~~~~~~
>
> Reported-by: Jun Zhan <zhanjun@uniontech.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>

NAK.

