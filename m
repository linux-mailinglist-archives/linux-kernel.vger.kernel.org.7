Return-Path: <linux-kernel+bounces-732606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA70FB06971
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4DEE7A5AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3608C2C325F;
	Tue, 15 Jul 2025 22:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eQio7d05";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OgRsCOIV"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988B5274B5A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 22:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620063; cv=fail; b=c+hySwHh+cd1mnu/+ZgT8KXqbm++m2Kp0O4GWFJ1lXQpeFaJMMxaLSMBhVV8ah+8HYXR8kGtaL3q6auc0fQS1LPFWKSq3wvUVuQ8pdREwAN6iYtLjN0XRCzp3c2HdJ2x3tQc4cFj6Mo/6z6Vml2Afns7d0jfy4/W5PAb3toJ5tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620063; c=relaxed/simple;
	bh=p6QQ2TnCZHYPsaLk5H+k2wH/YLQL0mLpeeGDossQqMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MnXVJla5yS6J2UZ4iaozFBO86boeui66ua316sqC8Y0WUzK8kaGRZR6OWFRRg1ZdrjZdQ4MXKEAzdok9AoI/2r7FCEoGqUL1vJd31N8xdLy7CjLu6Oy9DuiTMsMXRPoAEtPNBdA9ICj7HozxL0/VgDXLN4d6+2+KkIRh63QxC0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eQio7d05; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OgRsCOIV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FKXerW031984;
	Tue, 15 Jul 2025 22:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=C0FIkSsQ8SLzk7UD/f
	Ga/GBJ76xK28EBGgcewKeGBnU=; b=eQio7d05wDn1KYwKJj4FddTi8+TSTd/QrI
	xmYeW7badU9k0jtr0wRy5NHMPQ8p6s+PjlemAipN5QydKbfUkykWxyBxMyoVUAgT
	wC1F8DCAXcsMZyzNioE6zifdXcPcv2GbCN++JILi6Eou7jXQxtsTMOpUEoHk5z6y
	yw53IcgApBgIQNUHyVVdAb7Wxdy6o0CvF3/36oKLMxQxMB0/aB6g1cUblIv0cLYi
	WPQWLJoQpduEYC7XllfLHhPy2YnxTH5uxE0ShBeZ/0K4zgR2i9d8BU+GbQaoutfS
	L62uFAW4kwDfjaBhtr2htR3r+Vn1jg+KWD/4EiivwUNvWtDmepWA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx800td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 22:54:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FMU4Ku011555;
	Tue, 15 Jul 2025 22:54:03 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5ama33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 22:54:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQJflKLHEypG1k9mRbkhsxqhiUCprg+kxNPoQoW4yXFpUxGDWjSD6uvKYgc/3BZ1gnkxdJnlewtjOB2530eo82d7Hv3x1gtf5OjstAfu2IPrjDcD53nRM1OeSqfi5q48SXMlH63ngfdYqsJTWk2F9mW1CU5IDU6KRSxWcVMPZzqbhfX8b1wbRPUsqkKuG80naLevidGYYzVn78psmvaZptSUTSvzhJbi+jxl7SPcyWfplGhXoVQ+V7DSGw2S0fiirtpBhvLF2CxftTwCHwObScR52BT7XkwQQXriVokXrU5IEt/7RtpcmdNoRbhlJ5bOIMdRAdgZ1oFbcLB/T+LLoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0FIkSsQ8SLzk7UD/fGa/GBJ76xK28EBGgcewKeGBnU=;
 b=XdqLRb7PwNx+jnL4VCHEAu2FcVZwSLiWzTxTpFzW6oBybjzHUUDNj5S8vYfn5MWYZt3wn92rj509NxX2b+GvVi6x6RTM2ql6TlCbs2YckQzItLLTGOZaekPp/Rf72hgOwb6u83ufjiie10nU1z92ficIXnAQEFcwevLPr3TDEUr39rpU/LnWlFAabh2sYCuhCUcGiwvlUiFBthUKHUbWRWiDy3AiuWj57f8GIBQ8FO9PgpUOxWZTr77o/gvqHwCROcuoZoyFKaV4iI+bpuFMjkjFkIgplI/hg9EYjrZIn2CTJavwwYTNt0BzyCp83Kf4cBPdzIrFZ8Z5/cUXiEKA9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0FIkSsQ8SLzk7UD/fGa/GBJ76xK28EBGgcewKeGBnU=;
 b=OgRsCOIV8pWFPYqEFk8q+fTDE5ptqKbaAwmFl2aRb6mnoc5vdTsLtx7ooUgz9LcH2MWgREZhuyFpErwjKrrXec/0SvdJRK2zBUrFTS0Xm1eNKmCHGkZHWKnkDnYcip0Wc+OspEZ1NJZ9gmZLyqSXXUcZexbutVMrJCKzkhVX20c=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CO1PR10MB4547.namprd10.prod.outlook.com (2603:10b6:303:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 22:54:01 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8901.033; Tue, 15 Jul 2025
 22:54:01 +0000
Date: Wed, 16 Jul 2025 07:53:56 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Luiz Capitulino <luizcap@redhat.com>
Cc: david@redhat.com, willy@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, shivankg@amd.com,
        sj@kernel.org
Subject: Re: [PATCH v3 0/4] mm: introduce snapshot_page()
Message-ID: <aHbcBJV04fZoV6wF@hyeyoo>
References: <cover.1752499009.git.luizcap@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752499009.git.luizcap@redhat.com>
X-ClientProxiedBy: SE2P216CA0032.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:116::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CO1PR10MB4547:EE_
X-MS-Office365-Filtering-Correlation-Id: 3197fbf4-36b2-4034-bd51-08ddc3f27d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VdduSOsGupkFU2ixqh7PmcV0jaJcqDQuyw4SjnX8Y1kQqxxQUjBOrtr+9RC3?=
 =?us-ascii?Q?Ccr8oN2Mi9epvXJYhPqmf3NXscZRQPCQqjlf+RMb5nl+9Moyw89Z71ecFqXx?=
 =?us-ascii?Q?kOYLAOWksR6KFE12jD7uM2qxg/Pqnzx6U4edB2ECVW9EuE3wFr78a3zhbpXa?=
 =?us-ascii?Q?LpJUENlFqgDLmel9bLFHNkxlxX0Mm9GrXjj9e+pxVhBDzhx5OpAaOPha2Rgc?=
 =?us-ascii?Q?NboZpHIK4+EoV/1zMtXHrK1DssPMk1OhaAv1f1XAjY8kFKDh0S7ul+IXEZCs?=
 =?us-ascii?Q?oSTo32mU5TotYEE51q2FlS2qGRfaGiGxzuewe6kZpq/AcX2BZMjihJwfiOH5?=
 =?us-ascii?Q?jiMIBoRwzeA6/YpAtqTmd0v9HSr1jJrcXhmJ1ImHmzuFHY2ZgtdkYskV5xhl?=
 =?us-ascii?Q?FUUi0llYEBNUGrUC7JtLEi7B3U/2LwDr2pJmSDL/GXRE2tCVSwJtzca4mUZZ?=
 =?us-ascii?Q?/sAaJZR392wgoJBllXcE5l0IKon7fUfFrmaGUj/7L246MpWyG8ziVCZ3DEol?=
 =?us-ascii?Q?zTSlilMsC/ORVEmNB9kRlksa7u1mBvwEAs6g2x6bmjvm1bCvZwcQ5ZVdrD0F?=
 =?us-ascii?Q?BJ5Y1+j2wxighq4oquslke1PPmJSZEXRQwGI5yklpj4uzoabwidQMNDfsEz7?=
 =?us-ascii?Q?TJSQXtB6HORufviTVoBhNIaNBqVHkJ4/18v7ePkzeMtFm0EUSZBAwPw+oGdV?=
 =?us-ascii?Q?K2t5UF0uI3G5w55AyWd99rfoy1cUQ95cBrgk48HOq6xCNBSJoD7FNuCcb3+k?=
 =?us-ascii?Q?9Pg70erF0eIW4b61Y31nuBzRxP3tFIe3nbHbZUkIb8oTIAxVT6xef2JxM5Uq?=
 =?us-ascii?Q?A9QTbT6TV86xaIx+5qsZZV0IHDGCeaAf1tLAxvIUEBZZmYPXvHN9eqitIRsj?=
 =?us-ascii?Q?fuc8cP+B0v2KoCBS6grvyALD4gqG/t7H2nTJbAZIGKSsI+zh3QD4xKekGg3M?=
 =?us-ascii?Q?jR6nbVzHFDQ1P8KC1GSvIC+rG1kXzSOy83aSK49fwgoY7P5wntOW+5bz+iay?=
 =?us-ascii?Q?qezUJlIHdu0tLhAHZrz1YBhLHPj8s8hXrfvfmDzHO03/jSNjOu4AdtLrGyZQ?=
 =?us-ascii?Q?wfct+ItwXtpewgs/ttkIHZZBRFtOjcYlomiJVzvNJBe6Jad7dcBzvGJx1aTf?=
 =?us-ascii?Q?I9QrYreIVZ5VrMYuxtA9/zpqXthI614xiqnzxHY+RJUzZkZE/Yz0zMdxQ5+P?=
 =?us-ascii?Q?QSWCt4BPHX9MIRNmRAjTRQh+MaOV8N+UuHGJk5/OmMgOMPrvg6fsxJYH3ZRx?=
 =?us-ascii?Q?thlM4I+NVIMefChScyJQHnMMcF+LNgxKKpe1/SXIEpjMTe8xfhyXGtaZzg+R?=
 =?us-ascii?Q?Xjjq2S44dQ6SwUp+65kBGFrdvX11O9ObwwciCvzMLoBAuokKvS/MrM49+PG8?=
 =?us-ascii?Q?yI/2L8MjlmUGzqnCBxVAgjO4RsErpgP06jjt5Kgw6Hf47xoPWJhrEJ5aF9Ds?=
 =?us-ascii?Q?iiQ/tDqlvHo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aJ4SByZUn+W4+W2q4KSXQUreBRs3nMfYpPjp1Dtns3YYssW/i3EUderUsErv?=
 =?us-ascii?Q?U3yU4/8K4S7DqiIFSpVmUDM0L+ixlP9187ZJGdEfBNgOkME00StGp8/phpFP?=
 =?us-ascii?Q?Q4llHFWRN4367JVJXvmZ/PkUpKW4fkIYX+N2b5pa+CM/ldgXy3hwFQm0Ta7n?=
 =?us-ascii?Q?VCFIC7aghCIfr+h3lXiA9cp97RtitQQblGTgFq8kSQwuhaznQvDZfH01QkB6?=
 =?us-ascii?Q?fDengFFDX07AHLpEcoZ+UkggvzUQN1nzxDnxUVzPMS5pEr0D7WfFf/LQ/bde?=
 =?us-ascii?Q?T47YW8tnx95KY4KUQIxKpy1gy/Qt2VJxjXroRFS4lzHhk1HmEtM6h0ly9DNc?=
 =?us-ascii?Q?vR1Jk/Y10fzdCXbg54QTIKsjH6OTgFLceJ1bG9xzIRmuJnp+WQLH38jeglK3?=
 =?us-ascii?Q?gcMHoWX/FPCzVcX6GgkIJGuEDa12CrftDM0rUbim0+ASqAMUnvx0aXzl7ADC?=
 =?us-ascii?Q?79Z4dTzjF2Q3Oy7Tadi6pogdvvv3f6Cc5vR7IWJpNEl2G0BMBznOEgfFx8B3?=
 =?us-ascii?Q?39zKBmXmGjyK1e5qkvQn2qNnmdO3uu+S+77xTLTHBoKkm6l3ngbsu8K8/vdQ?=
 =?us-ascii?Q?FbdsZQkXXbrxj+ryDF8IVIj8g2mxLsOu2QU8GBZw8S7mkcdlrCyPaJq8uMct?=
 =?us-ascii?Q?0cksd9Hh9492cBBInCtLy4kTFmmt7QNhIeXBrYXa250loeI50+kSTqvfQGbX?=
 =?us-ascii?Q?+cXv6TbNexxfjI26AkgfCD/p6Eis3HTRNA8gvMs3sM/lVC1KsEqlbmAiG1gr?=
 =?us-ascii?Q?SuWJ0qVk7n3Oq6ipD2KttnxIEv5xhMiAn5uOf3Vl8NLK7UH9uXkltNe0sHOw?=
 =?us-ascii?Q?4Pge5gEw3DssiLsLGvj+ZmrvHbgYw9Lp5/Sz4yD6FrsKEeuSNDrChgKlFGQw?=
 =?us-ascii?Q?oZBduK/K0gvolCBwpqWxAAxFm6trykb0ze1tEV+EwCXDhMtVjEONIxOj8FiP?=
 =?us-ascii?Q?D36qA1Ypol5/2aQxzFqPZdG2+JeQM+Ela8wOPYJ+25yJSGfDmur3FftaBgc7?=
 =?us-ascii?Q?kS0OPQ1acwTfBRWE6wNWVeq0lJ0WgA1q6Q5kxj+3MUvkf/0WtgaEuvQeRoMw?=
 =?us-ascii?Q?7J4w6eT7x44IXWADByQIuNY7JVV7A28NL9rNygvax1VxgA06lRwshdNNbs1q?=
 =?us-ascii?Q?bxH8ET2v0/6NzM6lkSgvDV4zJA8l5sMgOZaBqq3vvzBBpqvoQzaeQxugwUuT?=
 =?us-ascii?Q?Io48CR9JnVbt/IM3hvNQbcq0a9QpxWjljjF6ERnpfWPPenct7iE936cWZazp?=
 =?us-ascii?Q?s9lBJSTVzqJ6+2v/xIgxFTJlXJuvFYFItsMlmcK5U7T1qsMQ8tr6zjh+wwRM?=
 =?us-ascii?Q?dppP6McSGn+6R3J+54fvLxfPV+6xorxePdxybz1+jpW8S/oUmFweTxBF+Ctl?=
 =?us-ascii?Q?hGCkyL2B5QDcmOshNyZevlcZZtD2UZDussS7S4Ezrl6TW9Ix29qlzW27sey/?=
 =?us-ascii?Q?g3XACDSZPHUdrFkT9XsBFacBYgEvX4QdchVCE6t4oj7HWJ+DQvtbg7u1TqOH?=
 =?us-ascii?Q?V6tiRz47BL5xa+KU0J+2gAqj/HhkkyOy0VNRg57pwmQihgCaWN7wZwbQMo9a?=
 =?us-ascii?Q?OtYlklh7+cQN2JixRT47ol8rVqqXlQsHggBFlKzN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FO8Q8lCIhhUo9DDYRhLIzZ/r2tGTMUm7kxBTIHRO1QjIUlKgjdSr1qytBR8tvQVww1tXJqeZ+fIywIJb4aQUzjYgdRS0vfBIwY4A2qq+VlAnAzA5Qu3sak2qWkuFPi1RiW+gOiDoLEwwbUkLBBgFQqu90IuF7rchNqTMqgEIYi3/24vgKVfBvHTlxEIphOqq+mzVxz6hqrMV0WaGM3ekOZqquIPdIs2jKQPPD8ssWjFJSmVC0Uzrf/BPA1Na9v2sBDJEtVlkUQz3LG9XQ6Tv7xXu7GbasL2ipcdgRlAibz3DyEn3v8BQj0OrfEilf51ZJNnFhznAqi5NdcxH48c7hYRTa45QkxhyrWiLzGaTinlVeAQBK5/ZpvlQvf9FoI3ITODqG40/XdfA254LzcSPPFt1F6RV+DMcXjYAuZjUOX4kClnXRCK3oM83O8rwc8bqEuMTTwzHeTRRPiNw6aLf0SzORae4cKCnDvLeWOY5aGX5U1G5t66F+b0nVzxzj/jX639eYE15jja88cVyLdRSsOm4FIe91Ww4ZfwB2D8P86PkyVm2WMPKSgaiz2LCH1+CNlhlXwbmvakEVze7Y0n1jXHw3tkaY8q8qZN54RXO4HQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3197fbf4-36b2-4034-bd51-08ddc3f27d87
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 22:54:01.6239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3RQFZEcZMjKgKdN2Rr+cbOl04x0HVacDYJs6LPp2KhxHtu7NCaAAMzKq3ZP9+vO+UETqnW2avR3StqpooXgONw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_05,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150212
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=6876dc0c b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=wfy_MAKSaDUhjPy5v2MA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12062
X-Proofpoint-ORIG-GUID: fT9aGEpXIz9dcyzseK6vJxzVyu46yrzt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDIxMiBTYWx0ZWRfX8OjCZrLz4pfW uQWERPAk3k+a6zhWcbnFxRrJRzmgVbSib0TYWv9x4xUlfsDl4trem9+EmZV6RfRZfK+5OFoNMWP AAa2PslC+4GbYgDF1vMigXI3F7tBrD7dlkpAZpwsvFqaeLSA7NEiD0SziERFqjW1a16lfwJB5AK
 cNJFnCS/mQPBrKsH5kS2UFccK7efI2rYq4HuC8CMCTQuDreudc+ncQ7GtOcwJirr079c2kz7Kam onvqkopJo5+wEQisFsg+Xy8M+cM/eEgOhnpIFjBkWS5XCtT3/t1dyU71dIU0EHmc2/Wau3Ai85V B4esPkBrxUcrB8HdrwkvoNEg7C99UNf3eOGLaCnkEm7Wy0/AxSSP5pzZYjFKuU55hb5MiDSPTQy
 SRqus1bMWhuxgdoFDHIWq1tXVfBGOAwfdb9UQvCEQuHyXWyT2YEzEaYwXTwgqrYn7bYSeNu5
X-Proofpoint-GUID: fT9aGEpXIz9dcyzseK6vJxzVyu46yrzt

On Mon, Jul 14, 2025 at 09:16:50AM -0400, Luiz Capitulino wrote:
> Hi,
> 
> The series introduction will follow the changelog. This is against bc9ff192a6c9 .
> 
> Changelog
> =========
> 
> v2 -> v3
>   - Small snapshot_page() refactor to simplify and fix stack-out-of-bugs bug
>     reported by Harry Yoo
>   - Use clear_compound_head() in snapshot_page() (Shivank)
>   - Read head pointer from ps->page_snapshot() for tail page case (Shivank)
>   - Improve comments and macro name in snapshot_page() (David)
> 
> v1 -> v2
>   - Include is_huge_zero_pfn() patch and use it (David)
>   - Move free page detection to snapshot_page() (David)
>   - Changelog improvements (Shivank)
>   - Added Acked-bys
> 
> RFC -> v1
>   - Include <linux/page_idle.h> to avoid build error on sh arch
> 
> Introduction
> ============
> 
> This series introduces snapshot_page(), a helper function that can be used
> to create a snapshot of a struct page and its associated struct folio.
> 
> This function is intended to help callers with a consistent view of a
> a folio while reducing the chance of encountering partially updated or
> inconsistent state, such as during folio splitting which could lead to
> crashes and BUG_ON()s being triggered.
> 
> David Hildenbrand (1):
>   mm/memory: introduce is_huge_zero_pfn() and use it in
>     vm_normal_page_pmd()
> 
> Luiz Capitulino (3):
>   mm/util: introduce snapshot_page()
>   proc: kpagecount: use snapshot_page()
>   fs: stable_page_flags(): use snapshot_page()
> 
>  fs/proc/page.c          | 50 +++++++++++++++-----------
>  include/linux/huge_mm.h | 12 ++++++-
>  include/linux/mm.h      | 19 ++++++++++
>  mm/debug.c              | 42 +++-------------------
>  mm/memory.c             |  2 +-
>  mm/util.c               | 79 +++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 144 insertions(+), 60 deletions(-)
> 
> --

Haha, I was waiting for this!

The previously reported KASAN splats have completely disappeared on my
testbed.

Please feel free to add,
Tested-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

