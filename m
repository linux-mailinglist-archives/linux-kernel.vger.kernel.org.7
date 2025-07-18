Return-Path: <linux-kernel+bounces-737144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5499B0A853
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90CFCA4617A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23C92E1723;
	Fri, 18 Jul 2025 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cAaEtJu1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qg1ENmHN"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B1C2DCF66
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752855641; cv=fail; b=n0oAJCcVBQQ9ewRhh7CqXn1aTbdijgqzN3okf7q5lkZqPdQPIH9S3uUxaaBlx7c4GH9ZB9wGk0qbzMWNvRTvjrqNSmMfXFjzUcoHoeYd5zqFOqSH0vkFwNfy4Y9ibw7ESvQhYXblnxwtbH0Uf9ZW1gPuXKh1EYURX0geV9vLi64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752855641; c=relaxed/simple;
	bh=cDA++UGe5fHYz6Df9LNQhxVctqW/c+TiaraI9yqU7Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OxXHVaRldoTcZuZvAS+yB+lDdvBehZ93ZQvgEeWstWOJGM/RfVeJ49v3rYSn1/zVrVYEAXuvLabWGeHwn+ffUVVKqyRw41lnEuW/+YhRGUPC7B0g0QZPyWGsKH/6RRRKtaSK39HE9hn33pVcbOwnMEUXwG7IaKH4fJEZ9iu4JOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cAaEtJu1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qg1ENmHN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IFtlrS015535;
	Fri, 18 Jul 2025 16:19:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=jlIUkq5kUb4zMbn3LF
	9TZXqGHrdUF8OrKujcccydcMQ=; b=cAaEtJu1m8jg0zlj3cTM1QYQdIR7OLeGBi
	iYfe/0AWhTQA/7ttwmqn3N5DJkntGiTOrfFCnLi7EM7L/vVQKiYEDRFfjUs0v7W9
	0HO7a9WtA82mL6U1QmC96+lj2ssWyzHSwkRHdxJ+RdfkNJ7fdOe1V8nqRHmJDmkY
	MG/H321BGvqCAksy2KrsmB0jGLZKVXydaR3LRoEjFQdr3paa9qHtWp5bynkVOQOS
	sbI21bI7t5RG3B2pQbJrg6/2etcVfudXzTnqirrP/Js5q0Q76P8VyqTwGYRpBU3l
	G8K0WXfqTeA9gVJsymww9Qn68u6Y2cnNfY1chN4RtZS8Cb1J3Ueg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx85kd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 16:19:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56IERmxj013788;
	Fri, 18 Jul 2025 16:19:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5dsrpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 16:19:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=px+Dn0fIF8ZkV2BppBiC1UIGk30Pq3kEl9r9i+UHOJOM6BoLIRLsdToNXF10M4SJxp+RpR36Po1aoiWNUWTMR2U5wlFMdh3aRzuEo7x4IQ3qhxFfJ9RtQxcBVNdJeQFcFCDIZDEZs3Q6u04u1LSL6Z3TpyPGQKbKCqVlOvDwsJpyVz5inT30HNT+HA24SGoOcWulydlZvgUOwINVWYfLJN6VEawXuu80nEkCYkVgmu6Ldo34L9BQFq4RO1WbGwATzSFGZMX6P1kG19LLAvMS+bmeo2q0YSaLSocOqRIyr2PQJhCZLkJnqIovEyuSSgJMOuU4rCsHQt0hxfvGHuLSUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlIUkq5kUb4zMbn3LF9TZXqGHrdUF8OrKujcccydcMQ=;
 b=OhYWOha2kG6hcgZK5p0GLMskQXD9P2Xe/ihcHGB5MYkG/XmemOhj6S4FDJiZt3wjVUzCLoO81N5sfhgBDcTnduvhNyCh2vqpGgQJWORCEoRK8iNtwSHMBFIt5DUVDKeT+zT0dT8M0KND4taV9gEKZTOUdaBxvO3bI4IXUiyckceeZDRrfgaNA/pJqDJpM/ISQTKBQylmCpesjQBuDbk8codCOh/1mpPgXzh0/6xM86EuJCWppYnZiT3PShljfwGYsbEdhtSt+Dlx6A3lYBMcWnamYWE5SRn1l1h7e5ENkKbOnfK5QBoDR1Q2CTlDY5J7XqX5fmDm+m4MO1nO0m5bqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlIUkq5kUb4zMbn3LF9TZXqGHrdUF8OrKujcccydcMQ=;
 b=Qg1ENmHN5l+prhpwPaFa4pWVhDWJtF+YVRUQOLpPQY/q6J37RRMvBmJnX+vfVHhsUg0PS4e1hWGv/Y5ZnSHs07DGR4gOxa55ELIumm5/vpRFDzsneD+7nIrC1kmK4EPGKrP8yE4Tz2RHj1t01eZSQLHSVvJQafmyUZxG1mC4F5w=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB7486.namprd10.prod.outlook.com (2603:10b6:208:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 16:19:40 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 16:19:39 +0000
Date: Fri, 18 Jul 2025 17:19:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, david@redhat.com,
        willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, Liam.Howlett@oracle.com,
        vbabka@suse.cz, jannh@google.com, anshuman.khandual@arm.com,
        peterx@redhat.com, joey.gouly@arm.com, ioworker0@gmail.com,
        baohua@kernel.org, kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
        christophe.leroy@csgroup.eu, yangyicong@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, hughd@google.com,
        yang@os.amperecomputing.com, ziy@nvidia.com
Subject: Re: [PATCH v5 1/7] mm: Refactor MM_CP_PROT_NUMA skipping case into
 new function
Message-ID: <ca34f1e0-7f39-4db2-8471-2044ac079f4a@lucifer.local>
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-2-dev.jain@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718090244.21092-2-dev.jain@arm.com>
X-ClientProxiedBy: LO4P123CA0056.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 974f1a9b-b912-42cd-80d5-08ddc616e528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tQF/HlfAPUEU5Arixw8OviQgkIO2GTaCA2GOKnoHoaNd7ACF0ZsvtaasiEqS?=
 =?us-ascii?Q?xn6KFA+elX/lAR0WwXh2l1kf1Dr7brqf5zkquMDzO+H5cYYNfBR68BaqoQ+Q?=
 =?us-ascii?Q?T8D/Bdj6PqmsqmVsurCTElYpjapXsCii07wsCb/ylpbm+LLoajnTa5IZ4wpE?=
 =?us-ascii?Q?zn5wpXl1SPT95wLHTq90C0V3opMzsV83xtMq56kyeMnIxsfflNS1dcvpSvq1?=
 =?us-ascii?Q?+KgFvBZOATFUrbBq/nabcqdiE1FqRI/lr0b7w8j3e/rz70ynf+cHoXKEa2oI?=
 =?us-ascii?Q?xqs/RVnn/OzaTxT1/MFG7TIA6wK09DvDvyzVcJAS1NaSq0oSmkXtqxDlUUYw?=
 =?us-ascii?Q?8nqaVwxORskxMW4dOH2BNbOJwL+MWGV+mkC90C9FrnJFGrRZn4hV//2Pi23u?=
 =?us-ascii?Q?nIl/QkGMFqD3sHFFGLFRDdbKwUghzy1napOCNnZR/zbHT8AIsWQNmrszqJ2I?=
 =?us-ascii?Q?PEdh9f6RHKgXQWCvhNxWcsgVMuG2Zt9EnZ0rP+x33ANMQCS3udI+4YruOh9G?=
 =?us-ascii?Q?KfzFj1s7uzeR1g4+8Uvko+zNTiD6tXsFj8gs5/L4vHkP4ykWqObCm23jBxsY?=
 =?us-ascii?Q?Q94+yeFEFzSGge/UHZb11i7clTQ7JFbP5q15u6tNj8kaM8zYK8oTfrJNozKz?=
 =?us-ascii?Q?k/tpXsz3kUOVkEVb8pRx7K/dbqDLiXvl0LccQjVz4JprEG/ADqa19PAUwtnh?=
 =?us-ascii?Q?UetupwJcw0g7KhegKKVjbN/4/kcJbIMzm2yKflqomrV7VCb4/xgaoHT5R5T8?=
 =?us-ascii?Q?XQH7pgnRmB3GDXOMX23V632jjGky8q+7r1ggNt2tXqLJ7ITnvs29/apL64vN?=
 =?us-ascii?Q?nYo7q5czg6+PVF210Hu3DwIOfkOGLqQr5XDuVScOxaUh8fOmneAgaauYI4I0?=
 =?us-ascii?Q?nuiEq/UYG9Rw3Yd0D9dkvyXobyAkmtdCOQocOrTof5MU/W1QdDv7KtvBwKvU?=
 =?us-ascii?Q?G6Tn8/UmfrydWSdweRkcjg4cT7fX2sM0Ac5o6TFWYuBqP9VjGkus8yg/4ekI?=
 =?us-ascii?Q?i64q8qR9qER7MZYSlCJFUexNweKAsCA/S5YyhAJBCr3hvuHrkODIrPrLzkwY?=
 =?us-ascii?Q?iqOrr2xzQ8HA/8IoVeQZY8z7k1WmfGg0vxFWQSIPo/O1zutY7OSYLuS1ukeF?=
 =?us-ascii?Q?JuY2PFBdQ1SoPXLmxMGzaSiGEsD9LV1s9dmGnNqgs5Daxl7dPD7qMxxRZy92?=
 =?us-ascii?Q?UtGupcCQSfqGBUI+XUcjbuLQZd6coU56EtaRQOBU4FcybiysuIv/doicBDIp?=
 =?us-ascii?Q?oB/7PeNO9epTLl/mdirZMlzuJcQ0ur4D9us/5RFwn6s10N08hYOvI7jXTUm8?=
 =?us-ascii?Q?ECOYtVB8bBV5aejH5yUuTbYZgiqoOlOTlGVK7iXmu5uUN8m1gYix5KqR10Rd?=
 =?us-ascii?Q?0k3ndYYhicH6WvZ7g9aPYpMJ+cf/KeGIo+TGndVHnqEdpv8rZZLMs//PXRUT?=
 =?us-ascii?Q?bFoQAnSQqB8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aj9XsMumNEfcq2i0WTRaYge4/hrqpSHFxArjyS+kOZ3bdUxKVqat8nYTf72K?=
 =?us-ascii?Q?YK9JhzDZVRmhXuvk5klvrvjAcKSJMmikhF1vI4oXBBcWwhiDgjyCJCch62Pz?=
 =?us-ascii?Q?xfnR3oDMxasxO6cDFAF9LbtDglisUsbGiui5EIwHZ3o1Qq03tCMuuSyLCLE7?=
 =?us-ascii?Q?Qb74aaKNrIus0fcHq9qamws4dsUz+QSwOd91wIpXSrj2qtkgxiJsAnzOY/li?=
 =?us-ascii?Q?ijYwj6YoreWLYzz5vJYPDPs/YJFq2LEPQV73GOjALt6LWCVVzljlOlO1fLDE?=
 =?us-ascii?Q?j0fbKjE827crTDTnouatvvmUPRbeZJBui3Fu+8wYplTZDIkVBGbkcRwfEDBQ?=
 =?us-ascii?Q?8QgHeDjSboX9iF6ZtFnbpm1F4G4tm5jNn43wrJ3ixPmKp7CqIp2jBkdlays9?=
 =?us-ascii?Q?6bi8iF4D7IJey/AG0JC/ztpys/94lWpmVTVGRTQNZcWvF5EA8FyzDKZl8BC1?=
 =?us-ascii?Q?6P82ld9jVLdia+RZS823VLeyxqpcAdPpBwwthnhVSNW3sMO/xUCqHq8wkV94?=
 =?us-ascii?Q?osNpmPhsAnbs6+ctNIFFH47zaf3dGESNGGnyjlFMNkZN3Ww6pTgf9o8u84js?=
 =?us-ascii?Q?o2Zy+FSITdC4mma+sx9INHTgIIotzzueUwfBS5jxInab7p9KuSAStGvUUn4F?=
 =?us-ascii?Q?Gz86xE2PezAnZu0eBl6bW0rNmURe4RSdoxps1xUEHfOB6qsfi3UE8DKG7duf?=
 =?us-ascii?Q?9BwYFYwQgUAT0PXhbxoR3vCz1GP/DD/jS98ik35GWZuYfvuiKHAnlHodRzji?=
 =?us-ascii?Q?Bnbj43JBlvt5ywHScZxamJFJxtUxK8c9ZQEmNXUI6T3xG9MvTODzuWH/ah+J?=
 =?us-ascii?Q?x1iNf9j7IWBaei68kToOtJbTI7MoDk0K32xx8nmS8FAdjW1u5uzQDVUi1Naz?=
 =?us-ascii?Q?OEmJ7HIh8Fo+psjE9PyC+T1NVyuQFK5HnHdh8hpY3KQ7KiKdTLXzcKb37AUD?=
 =?us-ascii?Q?5IeA1JwAXQkdqbqzrWdQqE7VdpZF6/GprG9ElERX23fJjORoDqOswayGqzgM?=
 =?us-ascii?Q?yAHcz3wswSS2Sn3n/saKqQDAk5/7Re5sbgl6Y9l9zsJfqFrYvZMyUkHzpGHJ?=
 =?us-ascii?Q?CvrD8DvGKY7lwpLcoqz0/NhYPMavkMY/W++wHKDsZTnoNqPWu8JQ+ixOqZWQ?=
 =?us-ascii?Q?dalqDBtGIHw2r06OEtr8LoJFxPlG35wY54UZjn/uGzLO0phYvZNWeIrV4vJY?=
 =?us-ascii?Q?zQ6J5wiMuluNuEZlRtLG6oejWvm2ICsqeJnXdYInn5Rq2ano+7kh+RhXIxsf?=
 =?us-ascii?Q?gYBK4q4hwnoDRN1q/Kkt4PPIcwgmKJYESbRAGyLwzwAIMFMZQ4E/aLRXTLI6?=
 =?us-ascii?Q?CLMLTTxxqpA4nxcbJTnC9HMCuptP8105nKUOjdN1uxgHoqK1WebRmItf81y4?=
 =?us-ascii?Q?lpVjBBmvWZf/0nTcvpkfJipMh8d81aVLVwZ2LT+uaQvf+TlTubPaEDCGQXww?=
 =?us-ascii?Q?vz+KGqV5On9ZYrNlZQuxo5sNX/my6MOfI26Y7mivZ9fN3A5NKcDkAHXohK5A?=
 =?us-ascii?Q?jjma3yWSVpvccqJ0ucKIPOR6sQ8GDMb2PfiUBtAshWKdw9k44lbrPEmYuwr9?=
 =?us-ascii?Q?bgTsUN2Wt1sqt0iV7I2cSwojRQ7vBcDncwWp+2YAWMJlnRiodzjkztTQqjc6?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IQfFEHtk09lq81awsZwUWRW6pKKJrCFl84cPTOQUBQk4a5BZIQaQL2BXjnX5RgKZ2bTzh2xBAZsevDYLphRjajYQ3GqWN/kqk85te1AX4mQPwv6N6E4SCL7VDt9eWN7usbAdqCPgzXcvGfx6mF6vmETVt0OFLyum8wFoSY6pW7KYXLaSJ9tLZCsxDKrmhcc3VadSciX5kAUgP0x7gZl7e6X6ko8Nu3V0yaHqoNbf3i8myHP3e73jc9iR9ObC0aMyS9/DlN0WDLdTIrpAk1B5G5PMc3WvSO3Fv87/rd+4SUcU1GdadLSAF4hUvxZXXi0iJ9Q7X9g/EULEafblfZLDRGtH80y/PrxVnLQ29aP+hieHwzj471cqR+LdspNiOk5OYdOU2D5DCdgk+wjZAw2Bn/cmNUj7SKflwlBQ0FnLQTv+z3GfCEbSXBCLyZ/O1uSFrABDElXLbeOG62vBlfBZj+CMmRzLrikIvrkrQtc03YtiwgEQjbAeHZBoFFjEwZWsNkxlfNn0c9IopIAINE4DELF538bBQ6NKhT7u4qrWoAA5EygzPaNiLHcTluE6qJIvmf2ND5+C0fDS8l6DLrdptU40frAPU/cxvmuibjOlbeg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 974f1a9b-b912-42cd-80d5-08ddc616e528
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 16:19:39.3634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ircTI50WiNRTfkkqF4NkPPmxE8eo2yn6aBFbtBS4tUE6crz64PFd1OyIuHTXz1bton0kFILadGtjmHrbdawVN3GHVEAkqdY8N0gA/GPszCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7486
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507180127
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=687a7421 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8 a=pGq3Qpx6pUIs351l3lsA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:12061
X-Proofpoint-ORIG-GUID: PeV6Z_kW557S3hJYSW9nXazSam92HEXF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEyNyBTYWx0ZWRfXwcfcT4F9upZG pm209QQ2kJlezdamKQNYDrrGCZru5l7i8qrCH+cfq5RNz1Rg3T0tTKfVZzNDXv1Dm15ktmcEzZu 84y1ZDOpxCMs+LSkpZ0wXbfopheHjvI2V0PClu0kQ1XogeTBfV1i9XNbCyfVvdaoeC9NiMUGGkY
 DFJAySLdsTcJRGqXp2vc+sOE1n1+rKg/625LiJvcTia/9CwR0iSYagQYyos/HfW/Cx3yLrhMWgt 0zLypVD0jBe5tx9IzD+im2oIQRcbODE87IKEvG87Xe0slcwaD4ZMwi4TwjoWj6As9709GcdMUIy WGOnrnwRVEnj8pRbeWbD0i0q0WNuzyMOlWgrPVOTyr2KYNMX/QczI5Is65yqYv9cms9V3b33k+I
 GPQ2NFjPrHLqB125HtcwTNqt1k6VufGQPvkVqAMgO1U183MMpr6nI4R3ZXC39hi9ig1jzLRu
X-Proofpoint-GUID: PeV6Z_kW557S3hJYSW9nXazSam92HEXF

On Fri, Jul 18, 2025 at 02:32:38PM +0530, Dev Jain wrote:
> Reduce indentation by refactoring the prot_numa case into a new function.
> No functional change intended.
>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/mprotect.c | 101 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 55 insertions(+), 46 deletions(-)
>
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 88709c01177b..2a9c73bd0778 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -83,6 +83,59 @@ bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
>  	return pte_dirty(pte);
>  }
>
> +static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
> +			   pte_t oldpte, pte_t *pte, int target_node)
> +{
> +	struct folio *folio;
> +	bool toptier;
> +	int nid;
> +
> +	/* Avoid TLB flush if possible */
> +	if (pte_protnone(oldpte))
> +		return true;
> +
> +	folio = vm_normal_folio(vma, addr, oldpte);
> +	if (!folio)
> +		return true;
> +
> +	if (folio_is_zone_device(folio) || folio_test_ksm(folio))
> +		return true;
> +
> +	/* Also skip shared copy-on-write pages */
> +	if (is_cow_mapping(vma->vm_flags) &&
> +	    (folio_maybe_dma_pinned(folio) || folio_maybe_mapped_shared(folio)))
> +		return true;
> +
> +	/*
> +	 * While migration can move some dirty pages,
> +	 * it cannot move them all from MIGRATE_ASYNC
> +	 * context.
> +	 */
> +	if (folio_is_file_lru(folio) && folio_test_dirty(folio))
> +		return true;
> +
> +	/*
> +	 * Don't mess with PTEs if page is already on the node
> +	 * a single-threaded process is running on.
> +	 */
> +	nid = folio_nid(folio);
> +	if (target_node == nid)
> +		return true;
> +
> +	toptier = node_is_toptier(nid);
> +
> +	/*
> +	 * Skip scanning top tier node if normal numa
> +	 * balancing is disabled
> +	 */
> +	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) && toptier)
> +		return true;
> +
> +	if (folio_use_access_time(folio))
> +		folio_xchg_access_time(folio, jiffies_to_msecs(jiffies));
> +	return false;
> +}
> +
>  static long change_pte_range(struct mmu_gather *tlb,
>  		struct vm_area_struct *vma, pmd_t *pmd, unsigned long addr,
>  		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
> @@ -117,53 +170,9 @@ static long change_pte_range(struct mmu_gather *tlb,
>  			 * pages. See similar comment in change_huge_pmd.
>  			 */
>  			if (prot_numa) {
> -				struct folio *folio;
> -				int nid;
> -				bool toptier;
> -
> -				/* Avoid TLB flush if possible */
> -				if (pte_protnone(oldpte))
> -					continue;
> -
> -				folio = vm_normal_folio(vma, addr, oldpte);
> -				if (!folio || folio_is_zone_device(folio) ||
> -				    folio_test_ksm(folio))
> -					continue;
> -
> -				/* Also skip shared copy-on-write pages */
> -				if (is_cow_mapping(vma->vm_flags) &&
> -				    (folio_maybe_dma_pinned(folio) ||
> -				     folio_maybe_mapped_shared(folio)))
> -					continue;
> -
> -				/*
> -				 * While migration can move some dirty pages,
> -				 * it cannot move them all from MIGRATE_ASYNC
> -				 * context.
> -				 */
> -				if (folio_is_file_lru(folio) &&
> -				    folio_test_dirty(folio))
> -					continue;
> -
> -				/*
> -				 * Don't mess with PTEs if page is already on the node
> -				 * a single-threaded process is running on.
> -				 */
> -				nid = folio_nid(folio);
> -				if (target_node == nid)
> -					continue;
> -				toptier = node_is_toptier(nid);
> -
> -				/*
> -				 * Skip scanning top tier node if normal numa
> -				 * balancing is disabled
> -				 */
> -				if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
> -				    toptier)
> +				if (prot_numa_skip(vma, addr, oldpte, pte,
> +						   target_node))
>  					continue;
> -				if (folio_use_access_time(folio))
> -					folio_xchg_access_time(folio,
> -						jiffies_to_msecs(jiffies));
>  			}
>
>  			oldpte = ptep_modify_prot_start(vma, addr, pte);
> --
> 2.30.2
>

