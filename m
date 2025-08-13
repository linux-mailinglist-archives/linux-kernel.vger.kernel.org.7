Return-Path: <linux-kernel+bounces-766052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F283B241A9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE6F3AE98F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5762D29BF;
	Wed, 13 Aug 2025 06:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UzWbURep";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pIuo6Qg+"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1245D2C08BE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066925; cv=fail; b=iQVEefOtBIgzoJ2KcRwmcDlBAkzVolKafIrSzioo1axLkD9pjpa0JWpx4tUt75pTLKWGzNx9NC7Qn6J7GpDrNh8E+MubiPV7w4BGn3119neSMScbuyecR0YrncuntHj5BGZ/2LRBTODMrUB2Tyd3hbLibhUJ2fyKkOjQZ7Tds3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066925; c=relaxed/simple;
	bh=SB4+PqYzkY93Ks67j1wdEEptIfOcfr8SAzFexM4BuwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kzKwlHmH6fUKDlOPzyv8Wiu4jGYCJs0NJcirFSyn+AjIOSnPSQyMl//aTWYpdQ086ZuHDRpuqSWE8nECh4NzqcpWHTJZuHoNZ5BDt8ArFFBfTbA98iT3DrAdNXEvgHR2qEH9up1dVnEhnepFlqkMoWDSmY93ru5dWVyj6qxkn2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UzWbURep; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pIuo6Qg+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D5uAsl024434;
	Wed, 13 Aug 2025 06:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2ri8RiFREomqYNEcxu
	vwPNyNP6w/X2IEtNzkMab+n4s=; b=UzWbURep4PzZUIceBdRy+qYBQ8HFvWBD9s
	3N8Rwar798DVnqBxHBma0kpIRraHD5lHAHgPtmSNt5WD/SGU7RaDr5nyUXpLuwql
	LqFksEjte6/ZrjF7Tk4mEnST9qjVvas22MxgCkzrke+7FSHwNIiulLT0oVRBe+FX
	MJBk9gbhDkV5/WEb/2c99PuXtM3tEihokgcwpjbIbP4sW3ie7XARdW128n+nniHl
	jmYfgu/BWJu9LQeDS4Pi9gVzsfZOLyYPKOhgNwhwdkcTfDgIbOsVBHKwIlrZL8OU
	mhjBsIVgjxCybRVyw/KbKUtLmVAI+RbHbm6WaO+r32F591SbUXmQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvx4ejdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 06:35:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57D5qDtL006367;
	Wed, 13 Aug 2025 06:35:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsas7ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 06:35:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJZbYnlCECtYnrS+WU/luUEM6QC3oatwZfewLPLSXfv/V0wbgbfF2UhYduHJZfUsjMB825aLodpv5Y8J+Ja0URw64DLePdDNRn4NsBMQj80JO7jTgC2hGXH82p/OSthB3mu8ePUjqUZsOYjjHKmWqWxW5V9FB6o7GNVVErkgU4XyuAnXapNOtiaGIkW9+piZr+MMTssmyUgqyylnUg5+5I59fskM2R8gSkMIqqBnhsadhBt3n8CytvOj6sIaTlOolukLcyqgFjS/UYnNYy7eFg+Dmeo95Wa3akodM191l0FfdDgFail0dEJf/pm3At+AW/R/8SnQVgrGBp5CzrzVpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ri8RiFREomqYNEcxuvwPNyNP6w/X2IEtNzkMab+n4s=;
 b=q3+bYJdg+9/4DQMN9YVFtftMzYpBYNdD+blhd1KYLoyERRMdoRf+RC95AB/QdpO9mw/niXSXAmdtT9CrgMRQntsTBdy87bG4qxNnoUA1sQFOPzbchCdgAnHYpJd8uvm5XQMPEZVebYVtt7CdZljUcdPO3XoacTukFjDLVG0n0MwYSPA6ssLIrWdD8njFo7jGoW3BG97bsxgUWtTmqNW1nAHkejxpTtnhgQHO6dS4JQ5SZi3Q6qhCgmjnBMC03JpUMjUANfgnZ8P8eol0YO+TkFmNtTwbHdaasNcF3d8dkFkCVP1YhXVXJm5uRuhyMX5vsqCcQ13GSWN0hBI9FR+PLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ri8RiFREomqYNEcxuvwPNyNP6w/X2IEtNzkMab+n4s=;
 b=pIuo6Qg+/aFMAt0H6lGjKDITOgcSKdGPuNZaCr92nkucodjs6EjXJE8ndFKMK17dJrKe1nNmn1sL0sFTQN3ex9phndsgjUvJg7cXRfE2nHoWbZ1hf8rX/RtSFkpsjALDdKz9Dsd4riiq0qNmoTCERixqpF+yQ7L07hD+gWkQlHE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7932.namprd10.prod.outlook.com (2603:10b6:610:1ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Wed, 13 Aug
 2025 06:35:08 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 06:35:08 +0000
Date: Wed, 13 Aug 2025 07:35:03 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linuxfoundation.org, mingo@kernel.org, namhyung@kernel.org,
        acme@redhat.com, kees@kernel.org
Subject: Re: [PATCH v3 12/15] perf: Split out the RB allocation
Message-ID: <35b09c4e-0305-443f-9c17-c8d46d1792b0@lucifer.local>
References: <20250812103858.234850285@infradead.org>
 <20250812104019.722214699@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812104019.722214699@infradead.org>
X-ClientProxiedBy: AM8P251CA0003.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 58491500-20ff-4e12-f9c8-08ddda338c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mZlNd10VZlO9plWLwvKGGcrXQIExLAeMIBSeF67dFZeqV9QG3O9R6sYmO/RE?=
 =?us-ascii?Q?4GyNDOKzVtPAyUu9wMKdOIbY5kfm58MwmyhuWXBH4V3b6hsUlOiYlfntfCbk?=
 =?us-ascii?Q?syEZSAem/McWPOs5yGK+LovBLLfvQM6Z435zd8lWFUxqB6PT61PsOaidfs/W?=
 =?us-ascii?Q?DzoTgYOPOldTMJxq0sfSzY+rphB5a2e/kDcAkJAYeJtOHs7y72b4ddpVuNRc?=
 =?us-ascii?Q?rKKsgA8ft4KshdN0DqBcp++BRknFTbi84u9/doLNc58fmvJaR3aoC47HupWT?=
 =?us-ascii?Q?T6Os5kR3vZ6uV2WzbMA/geZwQLKi4T3O/Cwv7voxW9PmH/c2S6AXkddG/I78?=
 =?us-ascii?Q?5Vb9BkIxA6UbgC29MHlA1sB+f9oPV6blwM4BHmCIwz2m3q7jjCnWTtV+mCDW?=
 =?us-ascii?Q?1j7rSzsS7Z189QQMhHLkinS+hQNPEGtmtgvmiLJTBXkyZl2lzjquGc7kuF5D?=
 =?us-ascii?Q?//f3SaYlUAuYJeTe1leYKuSmj1fVetkiNQcBvCeJu+3YKz3AIaviKvcmGXro?=
 =?us-ascii?Q?0KwP+EOk5wmLaRdbWQ5Z+URDMDE1PE13kCoZ8a6F/GVPhcYcZgNnQBOMq+WA?=
 =?us-ascii?Q?TuPNThm2eCMgOBdpeOMxYElLUlR8wbgxn5oC8PbUmWUUG5MsAb5PYFhFPHAa?=
 =?us-ascii?Q?1ElBYcb1uXqw+73gCw3+CGYosiMYXOZKGno+s56Qqx1FwRFVXr+g00HPOz4c?=
 =?us-ascii?Q?GAoSz1u/jCtAsK9YLnyy6pl0htstn3ql1hwrzMZY/dEYpQwlqLR3L3maqu/f?=
 =?us-ascii?Q?VU9jPH0jAW+s7O/IoYmw2mIg3U2QCtqzaXRGVS1AXxePYcT3zCYRsZj+kD+s?=
 =?us-ascii?Q?MlurUDuK7T2WlWXxU/vh+pY6ldhhCXluQ2wSi1dKcw9SS8SigfuwXoZfISFi?=
 =?us-ascii?Q?FFLFF2Uv2y3Y4SdxLH/Mr+gMCDchCOWBEfPYbGhj799RxSM2xzhHqbAcCubZ?=
 =?us-ascii?Q?IkvSsIBp6NSWSMA2BwtEQv98ToGfSnSiSKMCiWOS3E0KPt258YVl+k0iLBBd?=
 =?us-ascii?Q?52XlRvXbNqup6sSjR7eBlLz6mXvG7T0rT33Gm3fnjXfxHlYKKMgcypzWoVz6?=
 =?us-ascii?Q?qYe22Od4f2s7khdQjqTn1EXToJdVelYTP90Zw3DPzvmipNcP/9ZayC/bZ+ie?=
 =?us-ascii?Q?/kTK+kp0itPINCsdBChwKlNcXIt4SKJb18/C08U5s0km1DUI1Dk3xNuCemVW?=
 =?us-ascii?Q?f2z4QpBAiztWMItTpiynH6PQj+0BKO9sWYoRFETUHBqGL0Ju6ntyKvxMJWBX?=
 =?us-ascii?Q?TnhnBmZXOEVW7UsYiXndrSnuaRNnxSRtZbGE4XKs8+rLnH7x0JaUaLJr6LPH?=
 =?us-ascii?Q?GkKXg320/cBIhJ1RtdtJMUzccVlLI05jbPuycbHySnS19fSM6/JFNqlwJsT7?=
 =?us-ascii?Q?iKFTd4v3krruIYBiGWbnOClEWuphTrgbBNRc62hck2ts1PNhSqbyQCgErikI?=
 =?us-ascii?Q?o5+efggm6Pg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n3lOGavfmg4DyXxJ5XDe5gwdLP4Evqz9kLi9ldunHvF3AqbyrifXjQ4gt5Zj?=
 =?us-ascii?Q?L0mMWMxEpugPfR4k8UOhYCNOc8XBHCqT5yifhR/Fldx4v0EuEzUKP1xK9hNy?=
 =?us-ascii?Q?Qeof80AXr7asZMiFpzQu6S3iCfqDPc3VIJg/pv+uuXQjwuURo36AoynfmwIA?=
 =?us-ascii?Q?73c81adt/4eO09yqkV6frCC6LC1Ey8MC+YBk31Wvr/t/uYhdjywLf/6NrRaO?=
 =?us-ascii?Q?HL2iTFQPZveewZlL/3AYO+sS2xUDYM2aIdT4L1RTAEIYOMRqpkaRmjFPmovM?=
 =?us-ascii?Q?AuOnsKuBdlGuXvQ2g8qQ1b03DRODsXt5p+N0jMz44xOnBvUEZP7ryBy80Fg1?=
 =?us-ascii?Q?87ab6o5s8gwtJQxQWe13rZOsaJqxueVhm6DcxM8isq1k0uJ1Jkc00ST0gyBP?=
 =?us-ascii?Q?GdD938RCVG95jfsPIQK+WAwoWj+4SIhtoOUdIUfHOxyp1nCxg4/GIv5LotF6?=
 =?us-ascii?Q?5Dz1/0te14gtRIc0tEpCLNoEj3J/z76vRlqJMKvJ2/e+DmmYZ/+ePfxAcq2v?=
 =?us-ascii?Q?dTJLPcLVaVVTHlGf8vi7/ElNk1S7p9usKtr2U/+MO1XIGeYaJJKAzb0YLzv/?=
 =?us-ascii?Q?vvNadA2FYP5VgaT27QGm4zYTQ1+HuSBDtSsXFw0jD9gVGNUHE5HVVT3IBTSu?=
 =?us-ascii?Q?iz0vfI8i5QTrWdPxNhTemZswr2kjVhQTMO8USo4h9UX1hNGGurmmV44uJ82G?=
 =?us-ascii?Q?9pz7M196MM4CtbMR1GxJLR3u/8iB4KZLkPvB0lcIzF7Kg/j7VXKehr67kEmZ?=
 =?us-ascii?Q?lCmwt5aZqlP7lC/6hIQcvtRKhQ73OtMzVBeNrZWm3/C2905h2LJKD+BP31li?=
 =?us-ascii?Q?ByPkgwNfm86BBxmDHDh8vjzY35QHNPcrPc7cub2soU33W4W19o0n+hYRBLdd?=
 =?us-ascii?Q?JadwcNHVUddAt35lQQS8mQzWWCO4e+1hDDq9DOaXiD30onbPyvO6GDEzMqYy?=
 =?us-ascii?Q?eyllwsYW9Qgzrke96oVCb7LBaPM7sktAXyWM73oR5VY9DIlyEzNc2iZFTKoH?=
 =?us-ascii?Q?CcWlTWtREfnV8O1HFSOBM4PGhz5sz1gzG8pta1pHncfi50XNBALzzRS4ne7N?=
 =?us-ascii?Q?edrpdEvbcEUTi/jscoZsQDpMSB6/tnpRxL/G2R1I4lDHPcNB9ESylVn4FR8s?=
 =?us-ascii?Q?l4OPGDouXrmVeOI1iUpM0lq1pl33MG2DyohFiaQRUi3J+E/R2zoSc+p8PoMg?=
 =?us-ascii?Q?x8Zznm5CQV+HKYhpi7+XTS2XhdZN8d+Kmrd6bSjinuVehc4we0jHPCP2D9VY?=
 =?us-ascii?Q?DZD7CkGhoWBzvaU63YtP90VaYXqQ89t9XYmUuNl+1PuIEgycYVrDoTSmv/Cg?=
 =?us-ascii?Q?OXEJEoMMbKkoynV+LGoyyRxenPGUuE4iyG/zMCqimIZPkNT8BowLukPOQrEG?=
 =?us-ascii?Q?MqEH4HjldGXFTRzoaOyJtIIETxKFfwBauZP96jp+amQPTf135aqU1E1SvEhf?=
 =?us-ascii?Q?g0/izX6bkkYOMkURpdbCt63zQylsmcaX9Nqo52kosA4oStnutd6w6i8v+PES?=
 =?us-ascii?Q?hhRRReU/4kCdNTPQdbC8goSvNYZ/DbZmj0ISo+W5q6sW56iqGH2GdzPFUmLT?=
 =?us-ascii?Q?GdPk6H/pg022Lj4CUmMeFYbTy9VuKv5xfcLptSzIGmEg5c7b+nMzRkJ3ZviX?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DVDXUQHzEKfJrhNei1qGWtZwCaC29V+MD6peGju4Q+Ce9tgyF72kuOJN56An3/jP9ds3eAe3VdOLa44OTXuG8puDqw4XKM4s4sNGTAurkP8rgIy7wJ3TnhAmuOYqbR2Zvi34G1ttfujfecK3fb6SPSvZ5Snt6jD7bMQQUYKaUsGhnWDhvuVBpyRVkB5xrVTKW9PINgcGRsTJTOMsOTQLk3s/v/xCe9Ojwja09Ywxwi6Qg4Fk3V5QMidEVKO6t3g1MnMBK2qbFadf403JqHYtizXtsJUOLZG992RTlsEHd1scoBV/xxmrW4cHFVEivfve13mnKtEULnKEMXEFofduc88wOUPA5/SdEUsjASRHzXsGb0ukMS1pEkSS53mKoa+BrSdmv6/TVPa8CnMDZtLKd80XEOOHWs6MAsUfeuxqu808kIO3ac9jz21l6DUpm/IDVXabj+sxw3CFFVimIgJvrp4FquWytnjQmr5LxQ6TXhIz98/HMtvXuZwr1URXZ7lRh6QBVpJvhwizbL7czLZXy48HHtImJ9j2ThiLvw0rYqnZaGO98QfFrsLKL6V9kryaiQfRU105M8K4fNpVnOQ4gvlxWg+dwNwVpg4F7tdp/yg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58491500-20ff-4e12-f9c8-08ddda338c33
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 06:35:08.7567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEVvKDHWx2QTy9lyFkd79yitUXr9WM2d29W9BDGSANxkfaVvzSsPeDESV+xXXPNrHEmZ8jZvh8miCSVWXyzmfFJ765/n337d3HffduXoj3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7932
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508130062
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA2MiBTYWx0ZWRfX5pqCUlbgF6RX
 Zs/SL8VutbLZ/38ttjWjuAf1lCO27UMnaO7GJFeymyQ7sm6jldrxZVlOhsIvzvY9qBwY7J2cwRF
 3ePcfgsQl9uthBgriLn6A/JYex1QBmYtlnsLQ/UIPNZIWHjgg4vEZOL9vHXs465X6L1K/Zahas5
 D80axE4hHZzIOUZxFJnuvo5JAn2mw/YyApJ+VDeiwiRhNMTYq08ZX9UnSkjk6UKKPTfwJD9waIh
 R2wXS5ZruPYPxhU/pRyBWQF6d/S2uX6mfCur3taqQ3EnPZgzOcPwoJOXe0d7SHm/tR2Yk4JPaEj
 RzVEoIaPtueeR7zgZFuSoG+dP5mk+8qeqbFNWbnd8R30a5atZA4FNTtgTxILxvx7YMolnvOLroD
 ahEKxWzE+MdjtEJ58ademBdieT3Rd9y/xVKWymq6xY8ZLcdpm/KwRQlP8ty+Rk/phe4+GugF
X-Authority-Analysis: v=2.4 cv=eIsTjGp1 c=1 sm=1 tr=0 ts=689c3221 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8
 a=EA5dGaE-hYpHLhKADx8A:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf
 awl=host:13600
X-Proofpoint-GUID: GvT3YZw6_UQKYR3p18m4ZtAoud0y0DEc
X-Proofpoint-ORIG-GUID: GvT3YZw6_UQKYR3p18m4ZtAoud0y0DEc

On Tue, Aug 12, 2025 at 12:39:10PM +0200, Peter Zijlstra wrote:
> Move the RB buffer allocation branch into its own function.
>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Ah yes of course, the very next patch :)

One nit below about ret assignment, though I wonder if you address later?

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  kernel/events/core.c |  145 +++++++++++++++++++++++++--------------------------
>  1 file changed, 73 insertions(+), 72 deletions(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6970,6 +6970,75 @@ static void perf_mmap_account(struct vm_
>  	atomic64_add(extra, &vma->vm_mm->pinned_vm);
>  }
>
> +static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
> +			unsigned long nr_pages)
> +{
> +	long extra = 0, user_extra = nr_pages;
> +	struct perf_buffer *rb;
> +	int rb_flags = 0;
> +
> +	nr_pages -= 1;
> +
> +	/*
> +	 * If we have rb pages ensure they're a power-of-two number, so we
> +	 * can do bitmasks instead of modulo.
> +	 */
> +	if (nr_pages != 0 && !is_power_of_2(nr_pages))
> +		return -EINVAL;
> +
> +	WARN_ON_ONCE(event->ctx->parent_ctx);
> +
> +	if (event->rb) {
> +		if (data_page_nr(event->rb) != nr_pages)
> +			return -EINVAL;
> +
> +		if (atomic_inc_not_zero(&event->rb->mmap_count)) {
> +			/*
> +			 * Success -- managed to mmap() the same buffer
> +			 * multiple times.
> +			 */
> +			perf_mmap_account(vma, user_extra, extra);
> +			atomic_inc(&event->mmap_count);
> +			return 0;
> +		}
> +
> +		/*
> +		 * Raced against perf_mmap_close()'s
> +		 * atomic_dec_and_mutex_lock() remove the
> +		 * event and continue as if !event->rb
> +		 */
> +		ring_buffer_attach(event, NULL);
> +	}
> +
> +	if (!perf_mmap_calc_limits(vma, &user_extra, &extra))
> +		return -EPERM;
> +
> +	if (vma->vm_flags & VM_WRITE)
> +		rb_flags |= RING_BUFFER_WRITABLE;
> +

I hadn't noticed before actually, but it's really nice that we only assign
rb from below for the newly allocated rb, and refer to the prior one via
event->rb above.

Which neatly addressed my prior review feedback on this, very nice, cheers!

> +	rb = rb_alloc(nr_pages,
> +		      event->attr.watermark ? event->attr.wakeup_watermark : 0,
> +		      event->cpu, rb_flags);
> +
> +	if (!rb)
> +		return -ENOMEM;
> +
> +	atomic_set(&rb->mmap_count, 1);
> +	rb->mmap_user = get_current_user();
> +	rb->mmap_locked = extra;
> +
> +	ring_buffer_attach(event, rb);
> +
> +	perf_event_update_time(event);
> +	perf_event_init_userpage(event);
> +	perf_event_update_userpage(event);
> +
> +	perf_mmap_account(vma, user_extra, extra);
> +	atomic_inc(&event->mmap_count);
> +
> +	return 0;
> +}
> +
>  static int perf_mmap_aux(struct vm_area_struct *vma, struct perf_event *event,
>  			 unsigned long nr_pages)
>  {
> @@ -7050,10 +7119,8 @@ static int perf_mmap(struct file *file,
>  {
>  	struct perf_event *event = file->private_data;
>  	unsigned long vma_size, nr_pages;
> -	long user_extra = 0, extra = 0;
> -	struct perf_buffer *rb = NULL;
> -	int ret, flags = 0;
>  	mapped_f mapped;
> +	int ret;
>
>  	/*
>  	 * Don't allow mmap() of inherited per-task counters. This would
> @@ -7079,8 +7146,6 @@ static int perf_mmap(struct file *file,
>  	if (vma_size != PAGE_SIZE * nr_pages)
>  		return -EINVAL;
>
> -	user_extra = nr_pages;
> -
>  	mutex_lock(&event->mmap_mutex);
>  	ret = -EINVAL;

This ret assignment is redundant now, since in all cases you assign ret
below.

I wonder if you get rid of this in a later patch though?

>
> @@ -7094,74 +7159,10 @@ static int perf_mmap(struct file *file,
>  		goto unlock;
>  	}
>
> -	if (vma->vm_pgoff == 0) {
> -		nr_pages -= 1;
> -
> -		/*
> -		 * If we have rb pages ensure they're a power-of-two number, so we
> -		 * can do bitmasks instead of modulo.
> -		 */
> -		if (nr_pages != 0 && !is_power_of_2(nr_pages))
> -			goto unlock;
> -
> -		WARN_ON_ONCE(event->ctx->parent_ctx);
> -
> -		if (event->rb) {
> -			if (data_page_nr(event->rb) != nr_pages)
> -				goto unlock;
> -
> -			if (atomic_inc_not_zero(&event->rb->mmap_count)) {
> -				/*
> -				 * Success -- managed to mmap() the same buffer
> -				 * multiple times.
> -				 */
> -				ret = 0;
> -				perf_mmap_account(vma, user_extra, extra);
> -				atomic_inc(&event->mmap_count);
> -				goto unlock;
> -			}
> -
> -			/*
> -			 * Raced against perf_mmap_close()'s
> -			 * atomic_dec_and_mutex_lock() remove the
> -			 * event and continue as if !event->rb
> -			 */
> -			ring_buffer_attach(event, NULL);
> -		}
> -
> -		if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
> -			ret = -EPERM;
> -			goto unlock;
> -		}
> -
> -		if (vma->vm_flags & VM_WRITE)
> -			flags |= RING_BUFFER_WRITABLE;
> -
> -		rb = rb_alloc(nr_pages,
> -			      event->attr.watermark ? event->attr.wakeup_watermark : 0,
> -			      event->cpu, flags);
> -
> -		if (!rb) {
> -			ret = -ENOMEM;
> -			goto unlock;
> -		}
> -
> -		atomic_set(&rb->mmap_count, 1);
> -		rb->mmap_user = get_current_user();
> -		rb->mmap_locked = extra;
> -
> -		ring_buffer_attach(event, rb);
> -
> -		perf_event_update_time(event);
> -		perf_event_init_userpage(event);
> -		perf_event_update_userpage(event);
> -		ret = 0;
> -
> -		perf_mmap_account(vma, user_extra, extra);
> -		atomic_inc(&event->mmap_count);
> -	} else {
> +	if (vma->vm_pgoff == 0)
> +		ret = perf_mmap_rb(vma, event, nr_pages);
> +	else
>  		ret = perf_mmap_aux(vma, event, nr_pages);
> -	}
>
>  unlock:
>  	mutex_unlock(&event->mmap_mutex);
>
>

