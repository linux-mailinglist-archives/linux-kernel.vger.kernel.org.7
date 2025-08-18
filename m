Return-Path: <linux-kernel+bounces-773838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2D0B2AB16
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5DA258519B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C384F31E11F;
	Mon, 18 Aug 2025 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QScnOjcF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rb+NeCOS"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADAA31E0FE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527256; cv=fail; b=EqunFTDZ9CHXx5fzvDWMxN0ISEV9UGyEMh6EVy6xk4Keei3+CXhPO80ksDjKBK9T4PsEKVN/KLXOPWQXSsgZz1+74EsxU8+y0NP95vpkPUDAUU8EJ9HEE1HK3aUHYW9MSWlDUEfjLukZEPCISGWrfdL1WuYhOkWvw3At5OaaRN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527256; c=relaxed/simple;
	bh=HXjlbImP0rL0wd4uZBQRXTiHi2P6Ld9DA9brm7x2hhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hmVU8qj6TY+BFLYeq2QW3S6Bb6nQXBweMtS4mvMxZIbKkHt/sxtaSKBSmlkGSlBWTorn7FLmnr+GWe1DP0reTMZH0NCVI0o9uOq/fn2i0sY4H2GBjtkOmhru1xOtNVTKRty5jXKz8ENp4feMOhDScD4xWZny9+NzEWKKfDxkDds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QScnOjcF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rb+NeCOS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IENIpa024912;
	Mon, 18 Aug 2025 14:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=+RAagZI+cveuaOTnZ7
	TrPbbjoTdPe3Nz24g5JWF6pXw=; b=QScnOjcFCo0UIwBx7XPa8HTGtz+AxYJUxv
	lVVQCTNHBW2SO7TDkwbe9wyIf383wAQ4+K72jnbvxlytQDKAgO3e53o+tBYbgg5w
	NATKmtXcnDmknonR5YobZ7ND2uEy69UFZEZEKOzoFM/HcRnuRsHj0qnpAac51YMa
	fYudwrP4CncwwkJDLlOa3hmK4Scwn/ey4ZEsROiSVjGrSm6hK1Pyj0Cy9D3YHz24
	UQ30kt3k2omHLkWK2S6pTkoWItGw3x/FbsNuo2uAFJas+xxeHPTrBV1fqiDlNDn/
	BmnZHRvijdy4Oj8k1ZPlpFco73gIKlpsHwHvk/+/Av569X6s/Lmg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jgk4k9jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 14:27:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57IDLiXx010631;
	Mon, 18 Aug 2025 14:27:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48jge9b1rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 14:27:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQk4M4eEoPK8MSczg1lRMtmPpwwqpIpV8KdMadcbmR9I5JEplAFwn2MGitsYybyx5mNsJ681dGPwmcKkDodJ/k3xj1sgxpJ4LWfbQBvun48f9/vEQlLXXujhgq37m5TKdovbJ/HREcthYlTpb5effFLZC1Xt2V+ntvaGrwbfGaNuJk+QP3Nl2FiXjeeh4XsFU5an2HNbksDrtcOvi8CYEiRlLoZt6vkQCgRBX+LZpOjgemaWWnRym9Os1zC4tJtGfYFGe8/re/McsDnMozl0+IpuVofUaSI1L1XQW4/No3bkw9rPGWertKdRdBoY9jpEilyBl3dVHJyOZ6e7vN3sOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RAagZI+cveuaOTnZ7TrPbbjoTdPe3Nz24g5JWF6pXw=;
 b=ek6mbm8vWDQnoaWNuPbVaiGwcPiKRmWEWDbhiZP+7nRxWr9lkDD+/wF6BrKeuaCUMdK0Sj/IkbDxOApkmXK1dG1A6TV4jYHAADTJAjT/jXajfYVmktCpqUkS/euYpU2eYclWFVjhHs9LvMP7fn/U5fA/ArSXG8fXipY+AwPDmTUV8JW8nsdXSNhPEshmDMBiHnFsS4wRuh8kjfJhCydu4EebGOSFKh6NdcyZYmiGHztf/RtMLdlh/Cj9XWJ/gWdnG/T1XS92wTYx0WNbN6Zn32ARrmZFiwskU62yMOPyFLZqnx2QrW4kfS/W2SRsEv+hYKvISwC4iinzFte9uusW4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RAagZI+cveuaOTnZ7TrPbbjoTdPe3Nz24g5JWF6pXw=;
 b=rb+NeCOSRJMrUje8db2/p/z8BFR3Cd0T6TDLP+YcmtLBuTLxetbyunjnfnJEa3rj+7MD6pkuxZLk5XE2nkOLoJSnVPYSaw2wOOzVstIDdBnxChAaOWeqmrzE29mx47G+YcRWXBy7CLChGHnBxYQ6E4e8YxQr5a3iSpvOZt+zwNk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB6615.namprd10.prod.outlook.com (2603:10b6:806:2b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 14:27:20 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 14:27:20 +0000
Date: Mon, 18 Aug 2025 15:27:17 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
        ahuang12@lenovo.com
Subject: Re: [PATCH 1/1] signal: Fix memory leak for PIDFD_SELF* sentinels
Message-ID: <aaadab31-661b-4939-b245-75675eda9b4b@lucifer.local>
References: <20250818134310.12273-1-adrianhuang0701@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818134310.12273-1-adrianhuang0701@gmail.com>
X-ClientProxiedBy: LO4P302CA0044.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 424b5b19-a775-444f-88ae-08ddde635726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OnVX0vP5WOrx9yOkKBWB2en8fU4UReM9pBvTCNZ2yLsj+Ild6fuDxHJNK/ti?=
 =?us-ascii?Q?zCKVxrWvq0qFKV0LlZuQisMOSHew/CX3UTMfNMjZ/9+EBBIKoCNNswkbojGx?=
 =?us-ascii?Q?5LW3YyDqXH86ml/Cop8bNKcMCwJu3SytzeLI1Kx/Gf5GigxE+Q0QdL70IeRq?=
 =?us-ascii?Q?wp8Sl8Iw7hk22x3M1sNW0n28eXau7tENfhRmeYLJS+NmWedDfOA+ZfFOyDZc?=
 =?us-ascii?Q?z8Vt5ZsUO7bKLAQn/C6PTCgnx/P+ZpX6WugNLisiMbBeSfgxrm6K5GmpzDXG?=
 =?us-ascii?Q?BZIVqkcf7hSixolAUGzesvpK0GIHO9nuQxo2Dppjoh/Y20F1dD61sHMtmXNi?=
 =?us-ascii?Q?iOzxZg3ovMxvrvRd2Aa6I+c8TPO0nAvIbauO9f3nsuTuu5QoD6wCf8HW60Jg?=
 =?us-ascii?Q?yRXdzxpdPRqCynwsClan0/cOVFbySUUf97ne9l0cY5p+5OSey8cYxzSDLTuK?=
 =?us-ascii?Q?8EjfgkDdMUG1SWWqY0yg5oStlvq4m/wEkoonqqMB1V96sfwJ5aDbrg3Hdj6j?=
 =?us-ascii?Q?vBX85Y3A6lF1CfSUr1g+nO6gwocCrm5UAVWXQsQgEodl4EbfU1Pv4z/j6hdD?=
 =?us-ascii?Q?uQcs8wzn65FtQkok4BEBykjZ8v9xQXr96GB7gefNcFJiedOyHgeBv1bIR92V?=
 =?us-ascii?Q?PC0EYv7R1Zlgs9WNJILWCVHL3jQbXVd7YCm46OVN3ol/Nur92Xq649Fimruj?=
 =?us-ascii?Q?0CrfhNDU+Z4C9Q/tMEZAvLChRFhnJBfYL9xwpx39KFxJZGDrd/2bAI09P57b?=
 =?us-ascii?Q?s1+GO8x092ycy5faMwDfoK+p+vxflf8NfDV7+t2XeVRUn4ViG2xahCSCIhnV?=
 =?us-ascii?Q?+ML/PwvNEne52E6tXHM/cOX8hmFgZiNULUf7arkKNvNCo1aG5Kdc/LwDXBMR?=
 =?us-ascii?Q?sEyW1D9L23vchqYZ4jepqz1bCGkHEQsObccis7VElFL2NAd29stvVyZSH+Tj?=
 =?us-ascii?Q?y+737lDLYCEYy27VXwoaqRWOlwAfkGD5uVkJTwPRNbvXz3wKEhpl4XtGjIaM?=
 =?us-ascii?Q?+rXq/bWr1QzOhL+tjSv4YktSiRC39cpY+ohs1nJJ2Jd5ueYWjcO2WpCojRVa?=
 =?us-ascii?Q?LSj/q0SAr0DkyKi4qm+Ib5z9+9Ic0BICNpnO0GNyd+d5jF2/Ml6mlIOrz5Mv?=
 =?us-ascii?Q?xXpjhkGmHKtR2BA4RzdUhFsx/dtK9uAyudWv2RYmrsS2oysA6LYSKrNC4Fm3?=
 =?us-ascii?Q?SMweLmaASschAzn6ODJqeDbIsd5V2sP6oVTNz0X1S4YCCrfcn+8sAQjkHmSr?=
 =?us-ascii?Q?ikTPpYw7atG6woPwQXM9g9Yf/zIIeAKO4pNMYZUGimBOu41eZUrL+4by+TCA?=
 =?us-ascii?Q?qdcsnMIQWnhP2C8GRAHhbSB4EweQmhjgka51pASJyiISmIGGnypCFi9sohW7?=
 =?us-ascii?Q?BZQtmF0JQBkqVqbkG1vfSzJLSlKf4IhKlEx0FO3KsNB9nk5jzvsIalQqg0aP?=
 =?us-ascii?Q?pfjPCjvU9Gk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/5T7MzHv0niNvah8+GHJy4MUNFFJ6QFs2quoBv8QXrFlpogDjjKtFA+5l7n8?=
 =?us-ascii?Q?z7gNTc7v+jqZVV0Fd7y457JgSKpSWh4Pf8E/BPfcZ1x69gZFOiCpJGjBAgpS?=
 =?us-ascii?Q?YOzy4CVM/RU2nX42avecT5fcXEjMSwxzO1rsp3wduTqMVB9mJxbKfY4/3Vsx?=
 =?us-ascii?Q?hmGfXjXMPoJsrB1pNmhUFqUp8/ym9Q4I4KtzlXXmYb4kB1QiXuNAv+469KhN?=
 =?us-ascii?Q?Wg99Oes2sM5o6H9Y3cV25nyYvjF6SSv9Ru6MVuRlnno2BmOt0VZ7QDYQAsMP?=
 =?us-ascii?Q?6YXoWuHd63qjzgQNgJtKiBfeQll/COMt0MygBp0gLbFcdzoMzFsszO/Xo1DN?=
 =?us-ascii?Q?YfO7j/WshoqCvQIDcN6ec+sRQ1Bd4LD3ojMVtE1znmxkaCva59LxpYb3AbvS?=
 =?us-ascii?Q?oSqfuKWifRtTnWpukQ6qjs7xoJces9TyE3XkTlxz2x9ZzcolKo7E+XTCw70w?=
 =?us-ascii?Q?SLapu4ip5L7q3ac4CSn+jqh1T6zNxIWRTJ2N3QAvXMRz3plVSvu7G0A2A4gB?=
 =?us-ascii?Q?1giPe+wlllsBh8htVuIVw7RhypCB/FchQ1riGKJwHn8Qy+XLTeLVql1KQER7?=
 =?us-ascii?Q?QuiOQJ7ZGeNbXk5jCUSxknqFVcTyGz/cG/km3t35ywPHSKrJnBv+hKPCJNMB?=
 =?us-ascii?Q?/u4x2dG50Q2O0JskwQs54yj4mISiCaRFeyUoLEcWSpp0Fc5bBnD5JNlqeiuV?=
 =?us-ascii?Q?KCyGel69N8O6PNLS2iBcaIYs6TI9lzLY4/ZHHdrrbgcn08G4FWK8AtJnjZrf?=
 =?us-ascii?Q?9PMkWw+DyGCdfELpnf0eENJzKPWrI639RvKruFRDu8EfAJMarLrg01HU+8Ak?=
 =?us-ascii?Q?xZb66e2qOLpBd8BUFJfc00WG5i45xayua5dm1Sw2xAH7oQAvkJJCn1LHU5Kh?=
 =?us-ascii?Q?W0cdHoPltlqAN1HNl5tAcNbjxlzBeaU6+0HEnqLqwACWrRiWJkiH5kOdfakj?=
 =?us-ascii?Q?cKlCEk7Efpx1U2+g+sUsGWtCYZk2Ar5Mb7XyEarG37p1NNTtEmnNfry6vFr3?=
 =?us-ascii?Q?MOZD8uoGNrI44YwQGWc+HPsGrrkEG0ZdqQsgftaQqyEzfaIrdAzTGwRjLJD8?=
 =?us-ascii?Q?gvI06zS9/7gtsn05MUjwutnaO4QAl8nABN4bWiGQhvqmeT2Kqo9bKHOvC5EL?=
 =?us-ascii?Q?91OTkB18tJu7ALtI2hDIpVa8qBW7xuAnCe+wgdBcp3PSx7Rh85SUQBd3v/wY?=
 =?us-ascii?Q?Ur2w/0Z9aYMC1MXn7yAiBAbwPrfUK6OzHUMB+8Jp6aYZZpbPSbqSPAoZkBRJ?=
 =?us-ascii?Q?tMBk0zIgzc7AmSXBBgZkzXcKEqZb4HEhnGzY/4+EgUKw1AtpsD4nOsSUlO0Y?=
 =?us-ascii?Q?P9eFIG5HBwCMWtEFBPITOx0YO3vGfLafp0Qwu4TO+qzNq6v1nD0tqZveGh0f?=
 =?us-ascii?Q?SRtbYtFsnWKzjfqH3r4m+GIeZLwKUWrEximna2Y5BW0+Dcwv2drv+DsPVqDM?=
 =?us-ascii?Q?SPWtBNYOtcHpPPuJZ+pU0orgP0ZVFBinXCAfZn107o+iYDs8UUK9WQ02fY72?=
 =?us-ascii?Q?HT5p607HoyG0NMV9Y8lvEYMtALGg7FewskNPWIgyBG+9gtMkd5mwYv0Emw2q?=
 =?us-ascii?Q?wjIxHwtTwR5AUaCcNak01ZHExQmVjJAxmIQzb/qcGVoSA+XPo6XSjnRaR/rE?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2mRARdsRpvCzq9HtVnlw2axWQCqbC/KKiPeTmGtRBN77+6PEc7q39d0o8aFEPM1+RUnKsmiXsIB77aP8OjOPOFh1aqvZdB3+XdSB1maxkV2caGwMYowB7gRSSLoZJ03bFWObXXh2+EHxS3V/scBxgltcGL35w5TnB71GjqiFJWnrzJcPBT9Q8ocf3r9B3TuwvAL7faa+oi8Me0xuMLMITFRxWgUKv321/1lCui7z192UFxzjhPimVSVPaTOQhuCjJvWpDXYvkIyjHWAtiPnJFQAzVUH4MEVwWJa4GVdbtztZFPNyauJDwQuHGJx26nhBDK+xOX/DY8tCo2ez/7+MPEFWUj4ffGMculXzpJ0o29Xd3Mfjr+pNl0ieIK7iKjWc3tRJDRwnKinC4+0h447TDRSK2+vAeGb3t1WpMd1roCapSILc2AkTvuRrAH+IN0A+lY5TxV9qUPLx4GVztDfrWmZzwSE71IKdYzPxVs6+zR1p7LDd4b5gpBuVo6TKmFBRBFo44uBEA1Pguu2SBYJ3VR/OjxYhErZV1v4xRKBNUeEuSYQvmJ8Usw1WL5W3cmBnMZ7Jf3C3/B30wWeMgE570130/Xhkj0WInVHaPNfxY/M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424b5b19-a775-444f-88ae-08ddde635726
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 14:27:20.2366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jY1IqXQCzX0GSweCTFn+fv9HwF3PP86DbnkuEbK3eogrZTS4PLH849pn7Rj4EZIlBHjFFbTkS3Z2NDAdWqyjjnpy7EDrVxWuW+aJHfiXPec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6615
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508180138
X-Authority-Analysis: v=2.4 cv=FdI3xI+6 c=1 sm=1 tr=0 ts=68a3384e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=oQLXkM_hQugqAID4QK4A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12070
X-Proofpoint-GUID: 64X8KnHmAxdIz9al8dOhvNvk2Gmr8sSk
X-Proofpoint-ORIG-GUID: 64X8KnHmAxdIz9al8dOhvNvk2Gmr8sSk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDEzOCBTYWx0ZWRfX/k7fZG75jaFS
 vVHsyaCn+5cgpPFN8QXxoJGycr0V7TWMcp2pa0vTESt19qPZIVix+PDjWwGQTkqItIx62zb4sYB
 9+H+5HENm/JjQxXsgtwBDjFV288L0Z0GjiDC7yVHiQnjrwdRSU3nKfyPL1avERue+4IgWfqRFCO
 wqxqYO/Ca3v6x9Y8HBXXUYYMTOqxc4JHF2K6umLfSVEejsbVQvYFhA7nVj8uBbQFwC5EwRNWfbr
 Ow2A4RLTPDnTGg1tLCkDHFARTEN//uQfx586FaNeXZZpmZpNIj16HIQ/SYNjZjbj58gP8s7HrQz
 QZSU51jYjmNvQoywrOlWSPDiGyrioU2zY/XBIiw26c83qpeTAuNxGeJVEBwUvJBTJTlHHui7LcY
 2QPfwIelY/O782lhuB3xYWR9RBfHbAnljOxYSRG1smxedDnApFM2hNzObhTkcJGDpFxKp0rx

On Mon, Aug 18, 2025 at 09:43:10PM +0800, Adrian Huang (Lenovo) wrote:
> Commit f08d0c3a7111 ("pidfd: add PIDFD_SELF* sentinels to refer to own
> thread/process") introduced a leak by acquiring a pid reference through
> get_task_pid(), which increments pid->count but never drops it with
> put_pid().
>
> As a result, kmemleak reports unreferenced pid objects after running
> tools/testing/selftests/pidfd/pidfd_test, for example:

OK am observing the same, good spot! Tried fix locally, it works, thanks :)

>
>   unreferenced object 0xff1100206757a940 (size 160):
>     comm "pidfd_test", pid 16965, jiffies 4294853028
>     hex dump (first 32 bytes):
>       01 00 00 00 00 00 00 00 00 00 00 00 fd 57 50 04  .............WP.
>       5e 44 00 00 00 00 00 00 18 de 34 17 01 00 11 ff  ^D........4.....
>     backtrace (crc cd8844d4):
>       kmem_cache_alloc_noprof+0x2f4/0x3f0
>       alloc_pid+0x54/0x3d0
>       copy_process+0xd58/0x1740
>       kernel_clone+0x99/0x3b0
>       __do_sys_clone3+0xbe/0x100
>       do_syscall_64+0x7b/0x2c0
>       entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Fix this by calling put_pid() after do_pidfd_send_signal() returns.
>
> Fixes: f08d0c3a7111 ("pidfd: add PIDFD_SELF* sentinels to refer to own thread/process")
> Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>

Needs a cc: Stable too I think.

LGTM and tested locally + confirmed memory leak + that this patch fixes it so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Tested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  kernel/signal.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index e2c928de7d2c..fe9190d84f28 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -4067,6 +4067,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
>  {
>  	struct pid *pid;
>  	enum pid_type type;
> +	int ret;
>
>  	/* Enforce flags be set to 0 until we add an extension. */
>  	if (flags & ~PIDFD_SEND_SIGNAL_FLAGS)
> @@ -4108,7 +4109,10 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
>  	}
>  	}
>
> -	return do_pidfd_send_signal(pid, sig, type, info, flags);
> +	ret = do_pidfd_send_signal(pid, sig, type, info, flags);
> +	put_pid(pid);

Yeah this seems to be a product of the default branch using CLASS(fd, ..) to
get/put the fd in scope but the PIDFF_SELF* stuff not.

> +
> +	return ret;
>  }
>
>  static int
> --
> 2.43.0
>

