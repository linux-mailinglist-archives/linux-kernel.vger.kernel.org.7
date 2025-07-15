Return-Path: <linux-kernel+bounces-731945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E905BB05E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C5D5006A1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05EF2ECD34;
	Tue, 15 Jul 2025 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bzSyzE40";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wVzCj+qn"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAFD2EBBB1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586696; cv=fail; b=RAlSUW2CpGdqHSvTB3d9FT++uWTov8L1SGf0GW+DUpQB+p/oMZX4BqzvEtc0hWApW/TInFhDRYUyb9Tz9E+eVzlDf24AvGL15CFoGmBAFMADjUT6LpQ1Ii0xmAkUrsvH+t9dARpHJa/WRgtKa5WzTum2q2aTMy7yYfI1xLONLjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586696; c=relaxed/simple;
	bh=trYQDrVkx3FZYsldoLF/m13XoQU5yBrxba3fu+UKhw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ueDF0NVR3BjraNJ6eoONNz2cdJqvQB7chcTlD5iGNn8Kvl00QE0U2ECHIU23nCb3FPXkVRIA4vRculDHc4tLY7Xee6NKwd9MhsgtUnHrNKj9mw+QbjfsZ6wStl6zQOp7xE8pld9TxfB2tBPDyjplrRnSiXMJVOcfhWJGoS7k2L8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bzSyzE40; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wVzCj+qn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDZGG2017700;
	Tue, 15 Jul 2025 13:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fZ6r4rNapeX0FSjpeG3dAJxTZ4h+Fmu2u1SL/h1+8XQ=; b=
	bzSyzE40Zy+Q9ViuywxBoBUj7ENnV4jcAbOfh8EvWBANFaBVKaUVnOiMNV4BwaNQ
	XbZYvL6hV5QLug4lsFFA6EZG0fZZ9WwROoniWPozLibeeJakFwkZDP/hqeYBGKlf
	SRFgBAqKCyuMds0FCvOB/nA1q7Ajo+9PHJl2QWwYr4oq3F7DL5XWTDC7FJM6vyPc
	Jsq3isF7AD5H/fT8HobW4PkZBbPbPMfuHE+IioSfKE4ljB0ytjnQVtgy0iSv2Xso
	qh2sM+vOhnKgIAfPDgYXv115X3t2eJpSyfhHSX9ETw/gL7CdMlL4xmnL6Zp9DKaI
	cyehD7HlhFkC6KEAqCUyRg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk66xdq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 13:37:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FCK4T4028988;
	Tue, 15 Jul 2025 13:37:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59qn1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 13:37:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLODDNestCXfArvxE2mFp2gCAQkX0VXjU0FWbPA63wDuidUwJq4NythE9tPjoIx+mywKFcFWfICVdK7hGVhR+DTt6VVYxSjBrYOUY5+x/+Oarn2HXfePJzI20bHoyAJt76/kw6ld1UyXb6lcm41zrtDXQs7gQuOODOzpJlMMRgsyhD2vuDuIBw18rqdCrGlzAixZCqGFXFuvptrSpg9NMEqCF1Y5rTQLIM5yHWZJNF+XU/JncjQ0bhcmpAHrrZ8IhVAfYVMy9I1rmw5m+CUrhsZV37NLZVFCO/kqQvgtZxivaGWyPZHza2Y5BAW8fOPH0lqUFVNZjkMJlY9M7bLT5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZ6r4rNapeX0FSjpeG3dAJxTZ4h+Fmu2u1SL/h1+8XQ=;
 b=XnoyOQrvLS5pRLrFVqcl2mqxlxDndILBqrNeXvTm9hqnD3O/pOknsFowhwuRfbdek4s/E85cDDRUHXj0QV8H5KO2S8uAK10wt8KXEbOH/LaaZ6Y2QLUuTC36su8OEyjnsjQiTsKQxa+c5vqiJyxtTjNljBhrzvMh+0D/u90Cwaz4CA4wu+gUViJzpJPvcKCZzHiO8bga9vV39RXMOt7ekvpELFNePhInyPbQAFopn0THrJEZwXFxBqTq9yaCl0qeViA07I8kobEaNOCsd6k8tjCRCRMoaOkIEYKcxcorZt6mOPyDWTjkPSevipTnJVvFrfR3LZIvQshoCgIUZPrmHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZ6r4rNapeX0FSjpeG3dAJxTZ4h+Fmu2u1SL/h1+8XQ=;
 b=wVzCj+qnKQfb3d7q0JFMWxTsLQ/0iPgsJatuWZjxDYqWsePqgW1uc5i8cuVojaYLBSON6wr7vImWvSRZqlPbN7UoW/vm+zyRJL5RNPRwEvqTDHlli6lUwXlBBZFKxkpVIxtD+UIkU7uV5kJ1euNBrAcPtM+DoK380Ez5bggNles=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB6370.namprd10.prod.outlook.com (2603:10b6:303:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Tue, 15 Jul
 2025 13:37:54 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 13:37:54 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v2 3/5] mm/mseal: small cleanups
Date: Tue, 15 Jul 2025 14:37:40 +0100
Message-ID: <7c0b2bb1f88db0c587190c2ae8bf3557f889cb3f.1752586090.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752586090.git.lorenzo.stoakes@oracle.com>
References: <cover.1752586090.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0599.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: d374d086-654c-4884-4003-08ddc3a4cd70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SoRy6Cyf/9JJNXACCRIzeVzkCh2K1WMjggIqHbCyKYAr8N1/+33tPDXAUDWd?=
 =?us-ascii?Q?Os1WPLQrdlBMvHSA6JEm23P6gyQpH3sGHHsreXoz7Cp0rKTlexCRCs7TnQJ4?=
 =?us-ascii?Q?+2S11KyxpYM+bTlur0juuQMRkNn0PVAESQK8bdMqfcGWCBOJ3D22PsrZihGr?=
 =?us-ascii?Q?OiYZpM4Ctb69MliR5sqZEeAatL3YroSUUArWyFau31Kt9rdCSPaBD7wv8aC/?=
 =?us-ascii?Q?EbecGIt2/Wuyq/nJGeKOSNi3cIpgrI/KTtCzMoEI98IIxevfU5hlR9EEO1gI?=
 =?us-ascii?Q?55ncmZBeu1YGK+hfZolAyFtqp1JT14loLgWOKizOBlTMnNJfuvvhOYUz7jqJ?=
 =?us-ascii?Q?rawzo3C3WJm216DY+64VWd0JFncQ1wLzl4V3BdhL8VThl3+VYqteVDMR4vKx?=
 =?us-ascii?Q?HBCZozrSvIgD/tMgwU4miT3lX4DayrrvpOKV44bDawWg0gXD/2aRQrqRgNML?=
 =?us-ascii?Q?TEyZ2xbdAkwuOueLg+gMV/iDPGJwQnUqam0P5jgp9m+M32fpw55d8O0szGgD?=
 =?us-ascii?Q?hUz/b2ijlZLbR221tRwgE6377hN2fbuK0eg1pNStl8/ApKSOox/w5l2W8Kgr?=
 =?us-ascii?Q?T+AKJff0yniV1RTLCojB9ljl4/mF5eGxZopZq43oA4hdrVRJQ/MGS1e+3ZZW?=
 =?us-ascii?Q?blcvU3gkSHpAfBCGUDbKBgvm3fbsUO7Tg1KrTu3IvMr8JbIm7kW4Ljxiu2o/?=
 =?us-ascii?Q?YwyXEj4r2VaEXUnS1O1Jygu6ZhrWwTpzF57nt1Wd+hrWLnhuqMCCBQgnh6+2?=
 =?us-ascii?Q?Z/pd/UQ2awgEkSXmytEFKsc0wgTN4jNy9DMg2l6spb9Z5OQJmWFgRpVZdkpq?=
 =?us-ascii?Q?E23c8X4WgT9cEYK1vuiBFZoEJ1j5T2xT2GFgj0nBBiBXw0u62VKjBAa3V+PJ?=
 =?us-ascii?Q?Jx4V/Iy42AzETyGe4NU+Q19Ao/mTGUWPs1DsAZt/qOkgHBXs32rrWQ5JgY0E?=
 =?us-ascii?Q?h+d7PwGOgRtb/vVit5pNVJjWj1aEeC0YwE5MhAmno4xjgWtIazn8GOc9RGNa?=
 =?us-ascii?Q?96PmO9t7XLogWe40gf/L0xXhc5FInkkRtZLy6xsTXhYyPPMs71b+LnWVhXbY?=
 =?us-ascii?Q?plFm2mjJ9eyfxWvJiaY4nhlB1ksWWKBaKbW6NLd/zKcfmFlefpmn1pUy8gyg?=
 =?us-ascii?Q?3dJUjK15P2tAbQ0dk8sfAZwk/hMiJqcG8qECeFFPpoG8V90D21ZnZE03WPBG?=
 =?us-ascii?Q?naZFu/T+XbtYmImb0IusxhJGVbg58YYCR9ATQelgU6U9+dK26YC/qrpI45/v?=
 =?us-ascii?Q?SncCn6+EmnIVIoe8dwcPVXgpVKggmC+Pm7fKZ13Wtiyh88dEYwmzWMlGK4vr?=
 =?us-ascii?Q?XNfFSSDWXdEgczzZRd1Z5KT9pkS/Qlaef4EUIHM7zcTxT/WiV8/0OZGm7jdx?=
 =?us-ascii?Q?AdGt+/o8zPwNiGJy3JGjmcA3cyTWqCYlPmj/kom0PRgm9PrCs2XTve5AUVqi?=
 =?us-ascii?Q?c1nz7ROz/Tc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J04vrYxWDgoNfrmdUFkAMgniFcY1j5YGgwlBrCPBn79b+JvJ7JF6zFDAmAFP?=
 =?us-ascii?Q?Ah/GfBHrvSkgtiveM//tni+V+Z72Hc6VnCisVGCS6SXGw4tK/zw2g4cOw+0Y?=
 =?us-ascii?Q?djUS5+Xu3+NEVkYveR+5NqBx/eDwGXcAr0RP+ixiCSMr2Dg24YDk4/RxcOCb?=
 =?us-ascii?Q?xUZo9r26RyilP6RZFAeiQoXYdY/IbTdj3L3KBEhscbunQ0PMMRWFf4fzpCta?=
 =?us-ascii?Q?0CMo44ex5upEf4+rsRmrvrh8pBH0bTVkXgxzezv5NhBVujMSVy1Z5F2scYL4?=
 =?us-ascii?Q?RxBpG3ifopvZJrH8ICuquE1dKkpJ+VWzZESdr37r2N/bg+4g9OUSVS3Cxe1n?=
 =?us-ascii?Q?aEdaLcHMGVbsHOg2OOc+Xhyo838vzZALW6FYsbMPvC7YgmsQxsVhvPIrmzM9?=
 =?us-ascii?Q?Zpffog54rVIiJpfHe7S9/SYFCTotplLwjHjFuh9F36ijioQk/EElNr///rLF?=
 =?us-ascii?Q?bIsnjK1cbk0wdoFz+UasKbJOnTmdUyDLA3y2LhgwYZpDLrU4FQRQd62libnV?=
 =?us-ascii?Q?0lroMx61FDXgrXuQx0mnXK+vSzdnVAock4zKnSPLQdSzLtEutCfRCvnJ9Zm3?=
 =?us-ascii?Q?eMk/mv4CI4ZWGIaasrKnblce+9H8+TCLUnWgl9NIHFuniPos+/A4ocKKX/gF?=
 =?us-ascii?Q?7Tc9/J4rNAuFwiSakBwI6TFAj4Vs4rI1AVdN8H7rrp8U+2fguSx6jTWzW8jv?=
 =?us-ascii?Q?SakyG/boY7r37o1dgX2pM9vCnHG2LpqElsZLYN4sJa32tdnEDwsg60iq8E6N?=
 =?us-ascii?Q?t6DuuYAgJOJuu0e5thge21yZtKBkYlB9ObT9ecsxKVwFwSyCzogLPlMExW8V?=
 =?us-ascii?Q?pgJPp6dWaMasTNca8U/MMm7ikUDeGiR/OAS4QC/Y13ywxSl7zh3bT6qVNL9X?=
 =?us-ascii?Q?u+48lKpOkc1yHk57DN8yWCUWRabIeqvviGdUXdgj6C8vwSNeovKyFWbV76ZT?=
 =?us-ascii?Q?s/r4B6yNLinFr68ad10uZUctMCHVvgRf6VvrnrGPVPxeQPqymfU2t9QWMdSN?=
 =?us-ascii?Q?GtGzZOLWd38NrLDu1OI9K4WdB/FKJ/Okj4qxLTGnBKf0ZYhDXSH8R7cseT6b?=
 =?us-ascii?Q?toG9VXTGPqEl5lhKH2+HOUJkFjdAfl3Wab/v3KFW62YYPZhBTlAFdf19nSWC?=
 =?us-ascii?Q?BoGGjmA7GyqwW051SM5/T6QxaOwVIvhDyXoB4Qj5LvVzgXuIC0p4Z/3TcldA?=
 =?us-ascii?Q?zdqEXaSSL6qJ3NMQVevICqSKJJ661Qxwayg3zLR7qrCBfbqAcpdMw2shRw6y?=
 =?us-ascii?Q?jJzird9Kjid0TBJXbrm0xE3OgfNsX541rNY9XPOdgX0CaF1D2XwBGg6n5R0n?=
 =?us-ascii?Q?lP/IajyHkjgVAO0ei6KPCtBUqUtKtKfXMxEe+DYDXORcHx0rvSxDf/MTaqlN?=
 =?us-ascii?Q?TYhGZ6aZuCo0uhc8+yR4rN6ZnPa9lNlpvjPgfwf5i2xyebOv6NeEK/jE/Gy3?=
 =?us-ascii?Q?BflSAm6n9JgquDYhjGyIbFKp2AzRSA/Ye1xotXJoofQd/A774YDHpz1MdxGu?=
 =?us-ascii?Q?EmcQqGHmZb6MIinlcVWAkvZAjtbcojn2/g05/ccZ1F6sfUTeFgCHN0T1YeqI?=
 =?us-ascii?Q?q0jiaA4873u3ZDl67BelPfpANvV9JZfp9wKQvxxHNy1jbsp3bwsjatDlQoz7?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SheJL3673YQhVjWqSWjNgwjVlb2ZXKEFY6ZIbXD161V3Y7pdHQ6QuzCar6vHMsNPlyrd2BYbIBUs2hpOfxlr4afluiLMnWHEcR7R/AZXfyABB5D8O+QTN+ZAGyTCVp76YQPYnztpQMcG3bI6db6IzU3lv+KxQZuRJWKOYSlJYsev+bOg8KXaXnQZUM6y/1fqFRhcBhhdZifl6jp/jL2SylPDlc8+S5FnK7GdI2sQWwl8oOe79psbnZpQT9x8xsKmq0aAwMtjRSWeSzogxUo97hdGT0eJBLqE7CmfaGPpOToFT2hQRImXhWZZ4uTchjYF6jSunPG1bAy+8wHnZSCTZoGroIRy1156uttvFl+xPz3hZQlUhadKhpRBe0boORFqgHdYAp8yadYyl1xL3/gB0Fsp7S2YWRQUpp4VaEg5j58aWEViLvewBbv3gRv+WUkiZs3HSPYHYlK7HP8K4tRuowPrVVqFU0icWREVp/Ff5bTYmR8IxU3A9LdhIRqsRih6D2QEJvBVU400Ub76zljgO4nAIisurbmoleJJjfUr5ybLZkSssOtf9f8/xOBjAsxVsHz/TI1FJw/enjNEZVjMx87JjEzvAXva/RRvHJFg/70=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d374d086-654c-4884-4003-08ddc3a4cd70
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:37:54.5847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zT2XKujCVOn/EU5JHbXsrIJtJC1Y0s849ALVzdlFxQL23U/JzUgrATnvt3dGbibu3VF8UFJA4mYynKJpW4+P7/LLK2NvGrOwCuJxtvS49d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6370
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150124
X-Proofpoint-ORIG-GUID: S1pFfVal91jROi22oprjX1iyhUZ-ZZaf
X-Authority-Analysis: v=2.4 cv=AZGxH2XG c=1 sm=1 tr=0 ts=687659b5 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=dmlVf6ZvkT1LhkitNWcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEyNSBTYWx0ZWRfX0z7UqFTOcXDD 5grm1LNdwOQvf3+HIUabXArb7hRJo1Bx7KkMhxHsNUfHKwBhCBJ8XL1em36QsR6QZKc1x+FDNRQ mO6KePRJFLyqsSJoXnqc6iauTFwVerYxLYj6Wsun9VInjbuXl5UpYrSXYFk9Y/Jd1TJm7Y0C1wb
 tAXQ2p0S+Qqgx53p4NHtT00c7U1RpUvb53aYb173v3SD8ryWOULAh5y4X3zb4+fbcif0JvjTz98 9bsfeH23BbfxUQnF09M84ogCKtd9sB+PtikqP01ncvQk3+LS5Top+t2FVc9nPDlC+22PkbFdN5r 9s1peuuvevttNJiBWYMomORObk/diJy7mtI+J9RPEvQtJgTQpxgRUNVu83p1FepWTZPu/joAwBa
 1ZZZgSVRvsAlwG2JD0fh9LfzunwJ7QOSV7e8CzqBrFMbLS/KR3OZtIZ7/i4OwXYjwjc7I1MW
X-Proofpoint-GUID: S1pFfVal91jROi22oprjX1iyhUZ-ZZaf

Drop the wholly unnecessary set_vma_sealed() and vma_is_sealed() helpers
which are used only once, and place VMA_ITERATOR() declarations in the
correct place.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/mseal.c |  9 +--------
 mm/vma.h   | 16 ++--------------
 2 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/mm/mseal.c b/mm/mseal.c
index 1308e88ab184..adbcc65e9660 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -15,11 +15,6 @@
 #include <linux/sched.h>
 #include "internal.h"

-static inline void set_vma_sealed(struct vm_area_struct *vma)
-{
-	vm_flags_set(vma, VM_SEALED);
-}
-
 static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		struct vm_area_struct **prev, unsigned long start,
 		unsigned long end, vm_flags_t newflags)
@@ -36,7 +31,7 @@ static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto out;
 	}

-	set_vma_sealed(vma);
+	vm_flags_set(vma, VM_SEALED);
 out:
 	*prev = vma;
 	return ret;
@@ -53,7 +48,6 @@ static int check_mm_seal(unsigned long start, unsigned long end)
 {
 	struct vm_area_struct *vma;
 	unsigned long nstart = start;
-
 	VMA_ITERATOR(vmi, current->mm, start);

 	/* going through each vma to check. */
@@ -78,7 +72,6 @@ static int apply_mm_seal(unsigned long start, unsigned long end)
 {
 	unsigned long nstart;
 	struct vm_area_struct *vma, *prev;
-
 	VMA_ITERATOR(vmi, current->mm, start);

 	vma = vma_iter_load(&vmi);
diff --git a/mm/vma.h b/mm/vma.h
index 6515045ba342..d17f560cf53d 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -560,31 +560,19 @@ struct vm_area_struct *vma_iter_next_rewind(struct vma_iterator *vmi,
 }

 #ifdef CONFIG_64BIT
-
-static inline bool vma_is_sealed(struct vm_area_struct *vma)
-{
-	return (vma->vm_flags & VM_SEALED);
-}
-
-/*
- * check if a vma is sealed for modification.
- * return true, if modification is allowed.
- */
+/* Check if a vma is sealed for modification. */
 static inline bool can_modify_vma(struct vm_area_struct *vma)
 {
-	if (unlikely(vma_is_sealed(vma)))
+	if (unlikely(vma->vm_flags & VM_SEALED))
 		return false;

 	return true;
 }
-
 #else
-
 static inline bool can_modify_vma(struct vm_area_struct *vma)
 {
 	return true;
 }
-
 #endif

 #if defined(CONFIG_STACK_GROWSUP)
--
2.50.1

