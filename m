Return-Path: <linux-kernel+bounces-822567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1197DB84262
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0DB83A2861
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05221D88A4;
	Thu, 18 Sep 2025 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JB0U7vHA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ISzvBAWp"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C84828643D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192006; cv=fail; b=LsT2logld+oeECQojX4LEgWOR9Tm6E1wFGPTm/KDZSUK1aFE7kcGLh1jVj0BQ+eth6RoPSRy4IqR6Er/MKvDkaII4TOtx4k5twz831ayEfV+2CUfVGCpohdTmQNfuDb6VH0Z9mzuhsCVrsQGMH7xPyBZRc+Ir8H5pVtgoHuXbMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192006; c=relaxed/simple;
	bh=AVhcRs41hqbGVejSMjNu1MPHG5MC0ensmDbqtzHcahk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LMhJgokG8/n99wCfpz6kN0+8g880zZ0HvSiqyDHG4l9jZoUmt0pzRKFTdW0EemOn8+5iPJEx9j3cOuQGuN1EdFw03FQYE+GUs68toemVzc6Jhfasz4iGSoO2E8gyFylv4MbUpzh9Mbup58HbX6vNtYqgf06HllmnW8RlIxJoyLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JB0U7vHA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ISzvBAWp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7g0qZ021313;
	Thu, 18 Sep 2025 10:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=i0vxZonrPcr/a4ot9h
	f6r5UAGhr93urNNvSC3eySQww=; b=JB0U7vHAWFfv818ViCJcdamejqV9S1PHZj
	UxWbt849FilDYslAr/UL069mkUG5c5EnBkpISLx59AykJW/G4LIB5qcNRRyI9TIM
	MVpmtDYAcRuSvlHkEG5Riwxs/D5A8R8kVgFYjvg6+N9jx9QbAT0NA5onuslkkVnv
	NOdxIRWayVMpbnuqccIDetwVSgFOXnQ81R5opZtmmm3WuuFUBFF4yb/utrJU5Qg5
	Ib76gHqorCTcuXcEIYPkWF+Dz0uuY1MzddrUNQ4z7cg7V1Gl2cXsTv2UUPtplhNn
	fl/4izA1LcA+Uk8OPxC/a1RK9J8c6rXsx7nH9h5i2PP1IgZ2N1rA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx9u7qr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 10:39:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58IALxHu033679;
	Thu, 18 Sep 2025 10:39:59 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2ewhtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 10:39:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USsks8hh9JnvyDdt2LWkSWszMerhDqhtfWzw2D10dn+vtzgnQ66U9k1MjVdSHon7JeOhcQ2T7yc7ZcYDdjlycifZfrRxzajdfgjPj4oIoJ+KfuSzgKF4uRAtBz5h2SbqP0m4VoTibyxQeuA2UxcK06s15QU6EQ52cldtfJwbcxh3+e3X5vUDIyderGVavSNQkA0kQ2eb31OfkfEbxszQpKyaarpZTlXg4nvDcr0Ej2oDZ+SSZm9SSEcZnKugSGmq+FhaeoYZN7aWnNlSL3WJLlVsfAKDeJEXp5OrfCHExrqIGpGVYggmdZtzYfUX2gsMb/ePQL4N8uWIMKSBCmuPXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0vxZonrPcr/a4ot9hf6r5UAGhr93urNNvSC3eySQww=;
 b=a8/mpvQcJR36+d9zhLKclWkiid8IaxBTusY0gF7NKKUrmPCCsA/7jSFYt3h6KwYQfhoreVGiVuCYMJzbVuqDEg/H3vfPshgUHtTlETg0CjLotH2T6dGZK90dfbecii8gJV8kt59Z18bOEB2wHIxdWBzLMqxfm1jsNpfMnV1XIR/vmGdGXFic3vl1cnGKQoX0zN5htpGprm7sgZ0l8UIPsE3/pfhKzmyamCjq5+z4/zlVeAH1eB36zQVqlpm47gnvuUy91UqpO10/fVgut2oSaZhU+4LPR90QwXlacDCWEiEnmPZWZprC/pcsBHtccBVg3VfnbPHr2LdaWwhFLKyDhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0vxZonrPcr/a4ot9hf6r5UAGhr93urNNvSC3eySQww=;
 b=ISzvBAWpLmYGthq8O7JigiJjc/huBRmquc3LNXd40CNmjry69QPYdBB+kZ9hGnDuuwFiutKnIu8elcEWxGrKw7i23CAkBQqKVcPaP3qvblTZuW8fHpyEAmWEV59BPp0c4liU4apN35aPiR6S3ANI+yVNaqO44yy2fSbHyNL2sUI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4153.namprd10.prod.outlook.com (2603:10b6:5:21d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 10:39:56 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 10:39:56 +0000
Date: Thu, 18 Sep 2025 11:39:53 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com, Liam.Howlett@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v11 00/13] nommu UML
Message-ID: <cb1cf0be-871d-4982-9a1b-5fdd54deec8d@lucifer.local>
References: <cover.1758181109.git.thehajime@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758181109.git.thehajime@gmail.com>
X-ClientProxiedBy: LO4P265CA0035.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4153:EE_
X-MS-Office365-Filtering-Correlation-Id: 033aac6b-3cc5-4f37-7853-08ddf69fb564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I6XzJQHaNxxsQKl1ajubNWd1sx2mQe7l9oK467k/17TBLo59QSDWhxsIn4/z?=
 =?us-ascii?Q?HKKw3OUL1hWPgxZ90y8gXTFZfIjrmys/e0yQQOUcK98X2S4HoApshcFNdE5Y?=
 =?us-ascii?Q?bi7u1T7abmjsF9I94Sl58EUVDYECgErdy/Ya34qiTHDXtQRFZCYXtFBtdR5R?=
 =?us-ascii?Q?vlnbRtyAEzE6hLFs/vHakSe0NVIDA4ykMPwUV/lzzRODP3ua4u9u8jBd/sVg?=
 =?us-ascii?Q?0Sb1aUdAdMkEMNXTiJ3GJXyfXSP4TKb18pzs2JpeCES1YH+53lUpTLuFCG3O?=
 =?us-ascii?Q?0y++SA1zAK5iyu9z2HzcEMCulg0zS/YiZq5R4tJQorOFHE1lJ3wCdh3K/3ks?=
 =?us-ascii?Q?Bim8Im8PhGE/jA69KTjV8T+C0a/HgHr7eQiwoTT9ya/OzJg2H/3NmTkFkb74?=
 =?us-ascii?Q?OF5WQWugH5L8vapUVRlfyv5ckJCm6lmIiF/75RnZmzrI46B/TH5MZxfQkjE8?=
 =?us-ascii?Q?7Dv7ZR4o6Vt2YNmvz7ZwINHqgAKlDoMY7pKilJEYfIuusDw8I0ONgu2Y7WLf?=
 =?us-ascii?Q?perlb/zhKNBo6DfxjuP4n3wRqrHnXV1U8cYYR3xcrXkPAd23Vss3cqleOk5F?=
 =?us-ascii?Q?ZIifTmF11gYDHOITaj9SJpIxVz15XI+A2G81absT9l2Vrrluce3jeXkMVYR3?=
 =?us-ascii?Q?Cmdl2z0LdqVaQwA1E5AIDGs8xtYmXmG1IbnY0zS/wbZgIp2EXknihvU/majF?=
 =?us-ascii?Q?6/EZP7L/YCjBZt5FN8NAB1KLKdnSKcVDwzfM2893HaOW6lgsb8ooLg23eUDo?=
 =?us-ascii?Q?dEU82U6vKr4N37IjUvDEeU8fA4fQftFWUvoaLR8OsJNf55fJxMgh2d7qUjhf?=
 =?us-ascii?Q?gg8dVCaqjyr4/AsE/fiIzD4C5mOU8zqQ/2gxy789fXJWWhhFDSkBQJLRLX5a?=
 =?us-ascii?Q?EhXzt37Yq/oe1tmJaT4u9sPAnBUz4wQnKOSms6mYVNt7WUPX8Vg8BcoWmwkR?=
 =?us-ascii?Q?glbV055zF1VxtFq3Tshlk+EGSmGgq6qYZHr+SM1sV6jgv31+VJRJ/9ZBu50F?=
 =?us-ascii?Q?ixA0VJ1GOQ57oI2AlBkKcnaD++gKgA1mQdgCJU10BUx/kWDaQnDserrtwmt8?=
 =?us-ascii?Q?n5kPANQrKHVkUAPbzqg4kxgdb87hf35heT1Pd1+lG9G+kEb06V8iOK0aElPm?=
 =?us-ascii?Q?ibCkUZhzCndyqullwsMqN/4m/ybiuYYhA89Z0Qg7a64zJa0CZvDgkYCn85ct?=
 =?us-ascii?Q?13WadjndeF5LPGlkkgdjjRAPKOwCTB6LHJ4Sq6wn0Y1KlwdKg9j8d4bNUQ5a?=
 =?us-ascii?Q?V8TFuHDA6Pa/EFyQeDAiOODESFMKJv21bJ8yAmgevu9Zey+CUD2yRY23i6lR?=
 =?us-ascii?Q?Ld95+WQmT4OJIEBUD1Z4uhTTZ9o291C4V609x7oCwJ+wRvySqE+94zX0hzP9?=
 =?us-ascii?Q?6NXNQaXsIkwo8QR6ZFfgJNqTqKio?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xxs3pvLyH2QnNzT92KXI+20tsy8uqavIQVkgVuINCmEF63kHHchG0MvPzC5R?=
 =?us-ascii?Q?vIiHo/6NPzMvpdhcEs/edLc8ucMEov0lq+2a6cMTCaLv5oULDMGvved1+lHh?=
 =?us-ascii?Q?Wjuq66Fy+FwHvPBhYK2tOq0wyQJJc9OYzVBadGzKSbHL+1k63JNKfFMm3glj?=
 =?us-ascii?Q?LKci9PxQ+YRH4q8n5GhoaGiWVtBXthYtbCyx1u/ylt1aKxlia06V3pw5MGA5?=
 =?us-ascii?Q?CsSG3Y/o/r5BSOp/aN839ad5CWbf1CdDg0f4NK1j3IB6C/3aaL1BHj7qrPVo?=
 =?us-ascii?Q?4kEV2ALCEuzSl9knBgcNdz21lsWlppDCz3YYUiWZssDDse7nzf5cmgskYGRp?=
 =?us-ascii?Q?3AfEs76GPZwH+P/pbzbV9+58uPob8Kh5++96SCxI8PZHXM/60RZMpHO5xbmX?=
 =?us-ascii?Q?9NmEDcF8LAR++j7Uqx2lgi2W/QheJi9Tb5fKYroRe/O8tSPXSkgyZhThFHut?=
 =?us-ascii?Q?jTJQxVee5mR3bwzrvGkvia5XPOMVRGp45ufMl6LVwWLK49ywkTxk1XNfjqvu?=
 =?us-ascii?Q?gyjPySZOt+DEdJ1xeKIh9uxtN1F6o1QE13NNziTn3eBhITtat9TpHtQ3yS7J?=
 =?us-ascii?Q?pnc02smuKEVl3p+HkwGMfrv9tIsTBUBFhA0mIalTK9TJWJcDydOrHUfj+yp0?=
 =?us-ascii?Q?V6bUudh/PV4FQtGTovdHU/nWpT6iXIfxxXW/rDjq3KFY3DwMo2vNqLnDj+ZR?=
 =?us-ascii?Q?F0kSRSJDhMfHV1LyuFLiKxyz2s5h61Fg0KQmc0rgBjbsa51j0l76xyTOflsN?=
 =?us-ascii?Q?c/diojt48Ht10anobdZ9+LTqQnfgBLwW5DFWM+/if5EqV3uxnjxgXo9MA00N?=
 =?us-ascii?Q?9EEd8IVUtPjxIl7fhJDXiMK4AKbyOCNjPD2BGGR0X0vrzkhjH7z/A8TQ26z+?=
 =?us-ascii?Q?m+PADViP4vRYthd+avMYp+EB7XqadQeiS+/88au2C1ui/AW+VOCXPURbJK5x?=
 =?us-ascii?Q?gHFEZDG9x1BV2IsJZJ62E8pS2Jj1zwdyQ/MsRfVSBvr2Mk7ZoXqS3wIqFQJm?=
 =?us-ascii?Q?d8K9FSBYc1PzhmfebhN/Pv9XcfUTMX8eCSQ7F20Bceulavw9gIliBidart5g?=
 =?us-ascii?Q?R9xSAE6GLbH+vqskqIv+74KtCyeUGB2OWcTCGsuZbUnn8lg2bFConAChpYGO?=
 =?us-ascii?Q?LXKpaXmCk0glh3+T5c/rlkNoXALA3pV98yK7EAFkvKFD23QbVV8lxSW/oD8c?=
 =?us-ascii?Q?dccaQl2Xdn3D22qQLE+FZBrztCXSKbDZWqtQSDTXfzrhmLoY9AgqGXdJXerJ?=
 =?us-ascii?Q?G8o/unPhtnUleDgvoXFz3h1S5orFSjvG0x+hw1rwnvGlxlduTz2Zs4whgZ7j?=
 =?us-ascii?Q?EJdAfjJ1xARrQKsa9KceUXyQy1x54f6dCSW+91Sia65PbNqQW66L/W58dR/k?=
 =?us-ascii?Q?KQDuosZ6mptztQxLxdQVylH0ZVrvE34QhAS6BoiLY+EMghBqbU2HHKn1Z1yr?=
 =?us-ascii?Q?rSVf5VO7gMN8nUT5WtBmpfmjJVJgTZHfM9rSUY3zv12/vSVcamQLNMk1zXSq?=
 =?us-ascii?Q?+zBQuV56cxCJW0WI0K4AH/UTrFIILuiPAA1mklF9Jmks2j3gkMQSUZIzgskt?=
 =?us-ascii?Q?0sVTxCZOqG98ORk+7tAYkPv6n6CnSXnKfyF5sHbHD+KLwat3EMKSx99TIUrd?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fXMn1lR2s4cM5DjmLpl6dEzxRD5p5BjZo6MaRGBuwmHTv2s+f93MnNqvDeWRByH66VdNO7VxDb4dhhmHJOKaNnj1snszQtvHmPBqM/UhmqFl5G5lMawGJWXSdXwF8S0rpflbeD2JuARikvCK7FGbCdQXOqv+7hCgqquOeCIHg9LnNKERsgBNorny+4usr/APE7xiiS4m7vPFN1ItPn9111kTsIY1kSBPMIbPZBsiK6lTENeGNAoIrRV07YojqcJolBpVa0hALvP+HDLlBsTMDXY/2QIi5Cer4vcYWcazhnEH0C2QkvNaL4gC1ZSMUNLQU4Wd+seqI53VQd+KSjicVGz4oeJewi3Bz+tyYpik/tFeSXOCWIigeIQYRCfjuSI7uWwU8KkekWTVaCcGQUqwVqV8+ZJ8MR2H4vFG3INJKYVKmxx9Ck2l4lPEW/Mv6+m1O1t1PioWS3IsDJ1yEeC+lBGqsKILBZaKcTZ247z6qhYyB4UVWztyaqesmFStqDxtSbTmA4EjztpBsJo9kzkbOnXKp8cfqsVK3GIwRNT6DBG361bzlKOi/wD+hmWxK8IzzkCImZ79iRvoUoHPCpn6VGdTOVZy82N3F1zKieKBeA4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033aac6b-3cc5-4f37-7853-08ddf69fb564
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 10:39:56.0940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCQMuKXDXEpvOfaFntBbKM75/5BE5fSQDW4BLDPzRKlVzjNF7X8WQCUJszU5mo4Js+blt9vxf70Jw69VbWPgJNRQ8ZZYDVOSz7INqtri08Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180098
X-Proofpoint-ORIG-GUID: gUb1rX5DTWpCifUu08SPC2Qbj7N_6GBl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX3dukUTp3c4Qo
 aHIgJp7T2Gnb5bGsNi+ouXN8Vw+/bMIMjwu4TbbOwmjp1ET8d7GOHkaREW6CGGxZNLQ9aDYxHQ5
 sr7s88oUfyGtC+t3UC7CqAJpAcOxCBfULQVIGnkdZAza4XKVeDJQM+13ga/Xli4YySNPXOdx9qM
 UjndX3GNzMjEPDzs+udNwkc0H6Yr2RFjJKFfeQGVJsWvLV3VH/t4IfoElB3zGGpGqAZMnV2ob85
 D0Rj6vX6hkU18mUtk11lF41DTQ0XBTURoXnhQGLCc0JyNc3Mfv/8KHf9rtEIrFDcFRSiYSY9LxK
 TqPTaYRKz+VBGT33r6gzDG4AFBrcnjck+Js1cOBeoiYvVe5MbELp4c6n15QVqsn79c0/j6BBnOr
 IbSieL2I
X-Proofpoint-GUID: gUb1rX5DTWpCifUu08SPC2Qbj7N_6GBl
X-Authority-Analysis: v=2.4 cv=C7vpyRP+ c=1 sm=1 tr=0 ts=68cbe17f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=stkexhm8AAAA:8
 a=pGLkceISAAAA:8 a=0RWOglZha-g4fNQPOk4A:9 a=CjuIK1q_8ugA:10
 a=pIW3pCRaVxJDc-hWtpF8:22

On Thu, Sep 18, 2025 at 04:38:55PM +0900, Hajime Tazaki wrote:
> This patchset is another spin of nommu mode addition to UML.  It would
> be nice to hear about your opinions on that.
>
> There are still several limitations/issues which we already found;
> here is the list of those issues.
>
> - memory mapped by loadable modules are not distinguished from
>   userspace memory.
>
> -- Hajime

I think this will need attention of um people etc. but THANK YOU for sending
this :)

If we can get this in that'd be _very useful_ for nommu testing for us in mm
especially :)

Cheers, Lorenzo

>
> v11:
> - clean up userspace return routine and integrate to userspace() ([04/13])
> - fix direction flag issue on using nolibc memcpy ([04/13])
> - fix a crash issue when using usermode helper ([06/13])
> - test with out-of-tree kunit-uapi patches (which uses umh)
>  - https://lore.kernel.org/all/20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de/
>  - https://lore.kernel.org/all/20250626195714.2123694-3-benjamin@sipsolutions.net/
>
> v10:
> - fix wrong comment on gs register handling ([09/13])
> - remove unnecessary code of early syscall implementation ([04/13])
> - https://lore.kernel.org/all/cover.1750594487.git.thehajime@gmail.com/
>
> v9:
> - rebase with the latest uml/next branch
> - add performance numbers of new SECCOMP mode, and update results ([12/13])
> - add a workaround for upstream change on MMU depedency to PCI drivers ([10/13])
> - https://lore.kernel.org/all/cover.1750294482.git.thehajime@gmail.com/
>
> v8:
> - rebase with the latest uml/next branch
> - clean up segv_handler to align with the latest uml ([9/12])
> - https://lore.kernel.org/all/cover.1745980082.git.thehajime@gmail.com/
>
> v7:
> - properly handle FP register upon signal delivery [10/13]
> - update benchmark result with new FP register handling [12/13]
> - fix arch_has_single_step() for !MMU case [07/13]
> - revert stack alignment as it is in uml/fixes tree [10/13]
> - https://lore.kernel.org/all/cover.1737348399.git.thehajime@gmail.com/
>
> v6:
> - rebase to the latest uml/next tree
> - more clean up on mmu/nommu for signal handling [10/13]
> - rename functions of mcontext routines [06,10/13]
> - added Acked-by tag for binfmt_elf_fdpic [02/13]
> - https://lore.kernel.org/linux-um/cover.1736853925.git.thehajime@gmail.com/
>
> v5:
> - clean up stack manipulation code [05,06,07,10/13]
> - https://lore.kernel.org/linux-um/cover.1733998168.git.thehajime@gmail.com/
>
> v4:
> - add arch/um/nommu, arch/x86/um/nommu to contain !MMU specific codes
> - remove zpoline patch
> - drop binfmt_elf_fdpic patch
> - reduce ifndef CONFIG_MMU if possible
> - split to elf header cleanup patch [01/13]
> - fix kernel test robot warnings [06/13]
> - fix coding styles [07/13]
> - move task_top_of_stack definition [05/13]
> - https://lore.kernel.org/linux-um/cover.1733652929.git.thehajime@gmail.com/
>
> v3:
> - https://lore.kernel.org/linux-um/cover.1733199769.git.thehajime@gmail.com/
> - add seccomp-based syscall hook in addition to zpoline [06/13]
> - remove RFC, add a line to MAINTAINERS file
> - fix kernel test robot warnings [02/13,08/13,10/13]
> - add base-commit tag to cover letter
> - pull the latest uml/next
> - clean up SIGSEGV handling [10/13]
> - detect fsgsbase availability with elf aux vector [08/13]
> - simplify vdso code with macros [09/13]
>
> RFC v2:
> - https://lore.kernel.org/linux-um/cover.1731290567.git.thehajime@gmail.com/
> - base branch is now uml/linux.git instead of torvalds/linux.git.
> - reorganize the patch series to clean up
> - fixed various coding styles issues
> - clean up exec code path [07/13]
> - fixed the crash/SIGSEGV case on userspace programs [10/13]
> - add seccomp filter to limit syscall caller address [06/13]
> - detect fsgsbase availability with sigsetjmp/siglongjmp [08/13]
> - removes unrelated changes
> - removes unneeded ifndef CONFIG_MMU
> - convert UML_CONFIG_MMU to CONFIG_MMU as using uml/linux.git
> - proposed a patch of maple-tree issue (resolving a limitation in RFC v1)
>   https://lore.kernel.org/linux-mm/20241108222834.3625217-1-thehajime@gmail.com/
>
> RFC:
> - https://lore.kernel.org/linux-um/cover.1729770373.git.thehajime@gmail.com/
>
> Hajime Tazaki (13):
>   x86/um: nommu: elf loader for fdpic
>   um: decouple MMU specific code from the common part
>   um: nommu: memory handling
>   x86/um: nommu: syscall handling
>   um: nommu: seccomp syscalls hook
>   x86/um: nommu: process/thread handling
>   um: nommu: configure fs register on host syscall invocation
>   x86/um/vdso: nommu: vdso memory update
>   x86/um: nommu: signal handling
>   um: nommu: a work around for MMU dependency to PCI driver
>   um: change machine name for uname output
>   um: nommu: add documentation of nommu UML
>   um: nommu: plug nommu code into build system
>
>  Documentation/virt/uml/nommu-uml.rst   | 180 ++++++++++++++++++++++
>  MAINTAINERS                            |   1 +
>  arch/um/Kconfig                        |  14 +-
>  arch/um/Makefile                       |  10 ++
>  arch/um/configs/x86_64_nommu_defconfig |  54 +++++++
>  arch/um/include/asm/dma.h              |  13 ++
>  arch/um/include/asm/futex.h            |   4 +
>  arch/um/include/asm/mmu.h              |   8 +
>  arch/um/include/asm/mmu_context.h      |   2 +
>  arch/um/include/asm/ptrace-generic.h   |   8 +-
>  arch/um/include/asm/uaccess.h          |   7 +-
>  arch/um/include/shared/kern_util.h     |   6 +
>  arch/um/include/shared/os.h            |  16 ++
>  arch/um/kernel/Makefile                |   5 +-
>  arch/um/kernel/mem-pgtable.c           |  55 +++++++
>  arch/um/kernel/mem.c                   |  38 +----
>  arch/um/kernel/process.c               |  25 +++
>  arch/um/kernel/skas/process.c          |  25 ---
>  arch/um/kernel/um_arch.c               |   3 +
>  arch/um/nommu/Makefile                 |   3 +
>  arch/um/nommu/os-Linux/Makefile        |   7 +
>  arch/um/nommu/os-Linux/seccomp.c       |  87 +++++++++++
>  arch/um/nommu/os-Linux/signal.c        |  24 +++
>  arch/um/nommu/trap.c                   | 201 +++++++++++++++++++++++++
>  arch/um/os-Linux/Makefile              |   3 +-
>  arch/um/os-Linux/mem.c                 |   4 +
>  arch/um/os-Linux/process.c             | 138 ++++++++++++++++-
>  arch/um/os-Linux/signal.c              |  11 +-
>  arch/um/os-Linux/skas/process.c        | 126 ----------------
>  arch/um/os-Linux/start_up.c            |  25 ++-
>  arch/um/os-Linux/util.c                |   3 +-
>  arch/x86/um/Makefile                   |   7 +-
>  arch/x86/um/asm/elf.h                  |   8 +-
>  arch/x86/um/asm/syscall.h              |   6 +
>  arch/x86/um/nommu/Makefile             |   8 +
>  arch/x86/um/nommu/do_syscall_64.c      |  75 +++++++++
>  arch/x86/um/nommu/entry_64.S           | 114 ++++++++++++++
>  arch/x86/um/nommu/os-Linux/Makefile    |   6 +
>  arch/x86/um/nommu/os-Linux/mcontext.c  |  26 ++++
>  arch/x86/um/nommu/syscalls.h           |  18 +++
>  arch/x86/um/nommu/syscalls_64.c        | 121 +++++++++++++++
>  arch/x86/um/shared/sysdep/mcontext.h   |   5 +
>  arch/x86/um/shared/sysdep/ptrace.h     |   2 +-
>  arch/x86/um/vdso/vma.c                 |  17 ++-
>  fs/Kconfig.binfmt                      |   2 +-
>  45 files changed, 1312 insertions(+), 209 deletions(-)
>  create mode 100644 Documentation/virt/uml/nommu-uml.rst
>  create mode 100644 arch/um/configs/x86_64_nommu_defconfig
>  create mode 100644 arch/um/kernel/mem-pgtable.c
>  create mode 100644 arch/um/nommu/Makefile
>  create mode 100644 arch/um/nommu/os-Linux/Makefile
>  create mode 100644 arch/um/nommu/os-Linux/seccomp.c
>  create mode 100644 arch/um/nommu/os-Linux/signal.c
>  create mode 100644 arch/um/nommu/trap.c
>  create mode 100644 arch/x86/um/nommu/Makefile
>  create mode 100644 arch/x86/um/nommu/do_syscall_64.c
>  create mode 100644 arch/x86/um/nommu/entry_64.S
>  create mode 100644 arch/x86/um/nommu/os-Linux/Makefile
>  create mode 100644 arch/x86/um/nommu/os-Linux/mcontext.c
>  create mode 100644 arch/x86/um/nommu/syscalls.h
>  create mode 100644 arch/x86/um/nommu/syscalls_64.c
>
>
> base-commit: e66ae377fe219c98d3d5b8a0d35da4413a5390ca
> --
> 2.43.0
>

