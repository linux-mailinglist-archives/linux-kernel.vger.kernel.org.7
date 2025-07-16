Return-Path: <linux-kernel+bounces-734048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01A4B07C5D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86C53AC6C4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65694288530;
	Wed, 16 Jul 2025 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kxLF7OwS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p396GH5L"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3D328850F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752688510; cv=fail; b=NRx9Z/eC/1QMxnkD4GP4dgPPUm8E6d7ubcjINWlqr0CZ/kO7aF+DbE+yZkEZPwr7JW4bPS8eavv6+eAna7vVhT0HXn5ttJxfDRxM+5fDeAvxlmAx7105Hy5bwxxUbEtVGePaYVzaAZIH607GH8r+oTovbiJbdB2hNthN6wY326s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752688510; c=relaxed/simple;
	bh=mW5gm18T/vcbYWrWSEjK70H8pnPP8f31t0njzQSipMQ=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=FTtJpg9bYVRukFgXwd1BoHQ8t29Xw2xjwWMSITBeXPp+zd0pQE+IzfZOBNIKw+KPLL0CePMFqqSzCxYYXPpj8V/LBCXDiXIfNO+sRqi1tCxZULXv/UPp5TqyfI8P3F+yyJpFtZcnYTYjCV2+8GE4DQ1MO7aBGpTdRlSMBORfG9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kxLF7OwS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p396GH5L; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GHffKE001438;
	Wed, 16 Jul 2025 17:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Mw9cHUVaMgoiSteemJ
	7ig5k5s0zSAOj+HnBrE9CBfXA=; b=kxLF7OwSuhgn4eDyfblOR95e/BFOoGPZ91
	kMxl1C/oF1683hcqpc453ZmdJ6g8IUcYqRNVTuM3pSXeZ+hFQNJXmGrjm8GWyr5j
	34pg7CqnJD0VocQaNEoc6TV0SWYxEqkNgPy8PBEDCJkwlfjLwHZm/0e+PPRzMMZq
	FrYNvff10OBk0zTWzFEbtTEhj5X3ve88Wb4cbtMfDGfCwtu7OcrfdgcZAVM3gGRf
	/7Q6+MEDllIYsZD+cdfd+Pdru2MIRQwZKutov5wdxJIM9sX5CS9F5v+TncQ4uY25
	T2Wi+uYUyYWqVF8g+FjIFQmgdXI1i0b55fu1F6sKiVQQ+UTB7WFw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjf9ykv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 17:54:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GHP7Ie010831;
	Wed, 16 Jul 2025 17:54:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5bpawq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 17:54:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClkHMMZ2+D8gV4kK72pw0zq3ykN+0YMtDytZ9s6OCmK0pHLpXx8ng/meaPba8CqQtmWw9eQRnw2o7dIwGGyHUfN9GmTCmdtbr6fwBRRXLmemUdBslJZdRSp9QgcHasy8xFCsmSXeDKwUzF0t6YIsbNSry64onIsLdS9EO0gqNFYwfRzubaZ8Q4UIaD+mER+wwNqhUr84dH51NoLYyjbv1f6qKhN9BAAOG6WfpBdx3sLl8ZePGLoMxFqxOUncBj+w18ifYTMsLfRYtpfB0ur/56F5CxiZMueapHJOGFiFcIVb5DKzwHzYcmkwNP10Wiq3QCWqY9JIaT+0/uT9MsKa7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mw9cHUVaMgoiSteemJ7ig5k5s0zSAOj+HnBrE9CBfXA=;
 b=x7EBsFPXwgS3SuSfc/SjlUMb6rq0KyjUGkDZ7uRB5NDALbnI3XZj+m6VC15dE7MI/1elFBQXwN6WjzxuXfapg2jFaIVdezbOuHE/puOaS88rZff3fUNeg8dYnWKDwRuVen4SiY+c/p4WEqECP0VoJNB6VJQLwXkr0KH1O8vi+ZEDzUoH0Z8Ot4lGhu169qEBDyM/XrZ9EvMQe6GT6IS5qp6cW/NYroKl8Y+0OgF8Wf2Wo5alQz+8D8JWu5f8PBhUVSFaqvEAJf6B7Vk7ssopdMfPkC+YWL7/YwEeGhQtp6wGnALYAOiANV6duI5sP1XYRyoOeXDq30WxVD/tV2h84A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mw9cHUVaMgoiSteemJ7ig5k5s0zSAOj+HnBrE9CBfXA=;
 b=p396GH5Lw2zsivDiWdz+fwWH57sKnCAiiwr5vgywwi/3TkZMIbBJJIOuIoOnIcMHfJClhiQxrawRKa+Fgx7cf/9AvBXh0XHbsXJvPBav5CoMvBgD+a9dFrom96vaKebTpJYgX+2OJyHq26hLfmgUh6KWWfLS5pWctEtV8QjDURg=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB6799.namprd10.prod.outlook.com (2603:10b6:8:13f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 17:54:36 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.033; Wed, 16 Jul 2025
 17:54:35 +0000
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-14-ankur.a.arora@oracle.com>
 <d6413d17-c530-4553-9eca-dec8dce37e7e@redhat.com>
 <878qkohleu.fsf@oracle.com>
 <213a4333-24de-4216-8d9a-b70ac52c4263@redhat.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
        peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v5 13/14] mm: memory: support clearing page-extents
In-reply-to: <213a4333-24de-4216-8d9a-b70ac52c4263@redhat.com>
Message-ID: <878qkof2cm.fsf@oracle.com>
Date: Wed, 16 Jul 2025 10:54:33 -0700
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:303:b7::34) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f866894-df2c-48a5-7ef2-08ddc491d306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aleaE3lYlJ97WlFFaOMP3DyG3lkD4SiNH2eB6zd9KZy3otqd5o06Ebge9036?=
 =?us-ascii?Q?1AocrZ35fmEbls+UYtGvFDNGIySnthnCzWd9pMONzVXCRwLINyuvVQ9NL/JX?=
 =?us-ascii?Q?ADZcwaypFIVUeTKG9kPZ8Vc388KvA/48YSulNUx31uB5+aS+uFfHTvPAvqXO?=
 =?us-ascii?Q?rD7r8K3zUV4m0J2Xqx3W91lOyARejXhBGFXozuKRrXqRvw0sh1glKalbV4B7?=
 =?us-ascii?Q?75vbYXBDnpVJ7fWr/FZvbDHee2SQ3TmA+YOH5JX0uBiggv6WK+ynRDahJ6CD?=
 =?us-ascii?Q?+EzRYOGa3XzNDPUCPY7P0504ND/TPAGGhi1HTUeaM+sdFWcpfs1++UlVTNUT?=
 =?us-ascii?Q?eY07iLFVpH1gTWihmR5xIs/xAfkiJZ04pB0oDbFFWa+asjmrl+cuHUIj8Z0h?=
 =?us-ascii?Q?zji67yjtEag7tD4d8bTnoIt21mrS/RcCw/OK4VtkOiKpm/Omiw2rBL7/CWdm?=
 =?us-ascii?Q?qW1RjsOBs57kZeEBca7n5EdSHnotVvCT+s9rqFsx6066wohzs8KhqfMq8FAL?=
 =?us-ascii?Q?AifVCJR2JT0eRFB8zRNJS5kJ1yyWfPZ6EKDI5HlR9/HfsTAhEy6QIUp+YfxP?=
 =?us-ascii?Q?iSmZaI/vmRHtXHqa3ALnS/ca9/et6iAM4CDEQt8p+aHY0yPnq6QK48bg0kPh?=
 =?us-ascii?Q?D0uXIYvPuUYfyKK4xTkl65mCZD6WStldGVsQfgNpIngtbfOjNzF9lJTtyGL7?=
 =?us-ascii?Q?/kaA3e9JLJW5SF1aPwJK5E1Oh9Kj98Ant10dbhef9i1MaHLHwKgUC5Yw/4K6?=
 =?us-ascii?Q?HB8WOj065iXBAahEs5GyloqFFkELqM8DShPrBG56AQkxKBBRqfwhX9SJZrqR?=
 =?us-ascii?Q?hkPmHrZmZev5b7ECw92WQnRw9gmdvHdA162vMTh0kSZmFkBbiYXMH9epNXUc?=
 =?us-ascii?Q?z9jFhu1iZM/HCRFXIaWgNPYVuD4JyRSNBIPq1+iO9qkEy6Cv3SIhJTkHS/JG?=
 =?us-ascii?Q?HsxZxRraMZ5XmT9V8PZrDvnTEkGpwrqV+3ctVy0ZALOVnn8ie1FlQq7NgOCX?=
 =?us-ascii?Q?CK0/FsQUax4lrx1Fgb19+YPy04qBmMZumnjk+0s3OvP8tL55t5y/idjnXoG/?=
 =?us-ascii?Q?F1NwCTI/SZwFccmx/3RoIx2NEAYckhOgeVSWXu83564H4d5QsWDYYbi7l+Ny?=
 =?us-ascii?Q?PDHY6/WvEyjOq+iHD8CD02qfc8ocyiNfYHM8EipwedvJP1Rcc/lDF7Gg9wRz?=
 =?us-ascii?Q?XNFXpvFWipSDB9IMKBX8umreomunLH8ZQOHLLhEyrHtEhWVIz8UFtOacOJVK?=
 =?us-ascii?Q?jnIpM/vo1JZo5OABZlsgPSS/9RM7x1wdoAB58m0HgO8MPQw1hVOzNYWZp5F1?=
 =?us-ascii?Q?DiZgVpqnk7VTi4mKLvUATD61jAGfFeU5DddaD2KjpGNfLvZ7YEZEU2zFPnlL?=
 =?us-ascii?Q?z4QRLTFf6+FK7MZ2HC1BdoNKZfOoFn35vEXkiPLmzIwKMILerth/PRCiQ1rb?=
 =?us-ascii?Q?opBru4SAvl4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gf6QUD1ltg0eVEiXjQ+8PhcBNYuuJBjqn1IXTexhGXRxJWv2XHXw5aBtwwxD?=
 =?us-ascii?Q?AQY0EVtu1TW7sMM+8UvUx7bGjOTTXQNrxRAmsgCCcZaIFPogiQhPR8Ue5C1i?=
 =?us-ascii?Q?wOsP7QQXfizxVMtxT367KWv9a+1HDWyYAFUPfdrg3EOE/sjWsn+9AVKC/RFC?=
 =?us-ascii?Q?6jM6CeuaOtFAKxVo8P/eclB7wD3jX9IFwKgI4yblK4uWXu1pXj6Dg/z2GWhH?=
 =?us-ascii?Q?ne711zAbSWzn5G9zRzwGJNhlVCRlfFZEI/s158lj+mraIhaB2lM6njwG41Bh?=
 =?us-ascii?Q?T0cKi6bFw8UqCOVhpOlXXWSdzf8BHqR+gh8Bc8o9h1C98BrV8lOcWbp1g4Jo?=
 =?us-ascii?Q?a0aebQccv45JKMzAOwayh+oBL0wXOlYig85Am7wUcc/yNkdnp2uUQ7VywAmv?=
 =?us-ascii?Q?HgWV+GRngjm18rFE8r5OyHYGoqWrWhispyCeX7HOm5LBswoq6JPW+mc2F55S?=
 =?us-ascii?Q?/zUW2kKoYckMg7nXiufln/55Ptjeq5zUc8Vf7qI41TQX4ZY5n4TdNTpGnxqn?=
 =?us-ascii?Q?Xf6UEIOL+TUJ2AWV27uzDuuUh0i7qoqMnzPyflV/aEgQNE7ZfM9u/D+GtJNc?=
 =?us-ascii?Q?vM8P7SOvafDPFc3tmHtIfR794FdvRKZWF2rKyaG+bHKI+ronA9YywX/YThX9?=
 =?us-ascii?Q?80QziD05fKRyHGwo5TXf6u8LKM56dZx97Hm2bh6wffxAO6wVnGrpBIXefB6w?=
 =?us-ascii?Q?EwppW55XEN30igk5aJTBQhZIEPGQyX++RzgSx7IgUw9fqCWwJMbiw99yahs3?=
 =?us-ascii?Q?P6tOOR8kA/qKfTqUvsC9vgu8Sn8oqMcQ21Os+kCDSAJn8GvRj+L4SEKamZBJ?=
 =?us-ascii?Q?AbKm+62AlAlnLkOxewG916klMMRnNJeGhcNQgRYoyDf28PkRfhzN/mztkFO1?=
 =?us-ascii?Q?S4KrtGHEyTmy1/DqqAve34KlKqhlIrGYQqdcJNiSXtdbrcryGq0lobJrsvcD?=
 =?us-ascii?Q?qYUtn8T7zR3G8ZHKys2id6YVkv8MrIY8QXQBbOZbxu1pCYNDlsQiqiONcuJ9?=
 =?us-ascii?Q?eJcBkZoXZZ4TkC2SLEFaHh2mvDF8FbjRV1056V/4EG5DOl/iOw284OyE+MJj?=
 =?us-ascii?Q?WLoetE/o5NSHuxhbXUmA2MZnJyYgFKwrmNZdTnJBLt2DVizsvmlWgZPmnD2v?=
 =?us-ascii?Q?KorRl/KhS6wzwY93WAHyp9wtSCmnS618+32xHOC+Mm6sHa8kCQeCkQAWCX4u?=
 =?us-ascii?Q?+hpDMfhyrq5RdFQV7Oox+9nkRgrE/rYjzSvBmbVyL96199sBNGxxriSFS2UG?=
 =?us-ascii?Q?Sy6T95gJCtrJ+Dv4p+SSa37c9sopd74L97/Sp2WP8EVfcs9jtCxVVG3DqB0i?=
 =?us-ascii?Q?PY5QkICtrFhXnHLdAimZlj5v4YcA8w6/EBqKtDHlhCTDoapfxhKGVlqxAVnK?=
 =?us-ascii?Q?SJOdAE0haFaEj7XagprK/hirLmWsC/JiJcz19yhidYYet7jVH+6Rg5mHjLK0?=
 =?us-ascii?Q?1eDo3lpyNXkBRFsEv2cs38DWPoQqjRoXnPmb1bXE3p9Ne7u0LqxvhyU8z1KB?=
 =?us-ascii?Q?Sft4m7YDONXMH4D2Gab23q3zqBa2VHpJEa2QDbQIvMe4ex54z55doJftDO6j?=
 =?us-ascii?Q?BgzzFjwMlYaT7swgEB0CHDaMIZSH1EcR//L2Z9eaYX6ZcBnz5eYKBh6ZZPGs?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eOXxUgxjGv41rBvxATlerdyKg8XSSZY7GJhT+XyN7BxJ6xeUllbRl8QmB6XMlJxhG7cO0aYiuzYPg6pfCXTu0JcKT0j2QuDOqokihCmQu5nYotsvLmIf/PwQFulDKvM95ZGfGHZq04fQc3nJmAQPY02Lk73+5oWoc0xG0PjHWjnGcC0u0zXBLtfCaZMRyCjHV1lw40zzBaSObFdwGCmqrn9TE4ktoHob4+QUKThPlxj1P+Vhscq8rxi51U/jdiYGl5huwB9HbBP79tuBqLMbwRZNSD+XJpzFJz0fjfuXz3r7d92iE06QuqDljHqTstqX0bSkvVBNATR9gaaog03d7Gorw3Uh95nVoY1Vn83aOyDZJOENzX68Qy5ZFpaSfmO3COv0XhanBOE+P69B5aLPoYR9Y8kvXMFQK7sHsWPbnf2ccnl9Qba5146jMVXoH8eswyYpyGlpoYulyAlB6BnRyQ5Jfp+sz/oI2NfJMb63S2Q06m722av2F9yGY0j11TQ3hn7msyVojS/SandFm3lwxcYBc/KVAVlvfAm2sUk6ujYAcPSyLzJ3IFVYOXMYuMTt2z9Q1wFGgQlP5vdboDZK91APpZYsYTXZlOyDDqdOClo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f866894-df2c-48a5-7ef2-08ddc491d306
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 17:54:35.6883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcViAaL5rbC4JRMfRIBuUBTEKaiuqZFGsB318HhrfLr7cv6q4T7xeHmptm3AA+MsPxbiWLOdTgQTAVE54zaxyVy3CuGDARypdf9cmxXc6bw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_03,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160161
X-Proofpoint-GUID: t_aEFRy1PiOKCOEHb635fMdjxubhex6u
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=6877e75f b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=_aWlzPWFGaAEAUwkHjcA:9 cc=ntf awl=host:12062
X-Proofpoint-ORIG-GUID: t_aEFRy1PiOKCOEHb635fMdjxubhex6u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE2MSBTYWx0ZWRfX4YCfCVvKhGre fdoXWXnPO1GyTGqxsujXwvlS71oArH5nx3eVoEJuVgu2qWE8EHP6yEJnaxTH/NzH46m6cgBsx47 lWCetNjZL4mWoqybI95Myyari4F6vk47Iaxr2tPhzYy8JmSANqUcatUp1NHfqxC/904bu01XoRV
 YxKpZHjyzXk2DYuBCugQ9cG/JLsyVdwxGfzpVBHJKMfnTQk+qUFkYC22Nl++erXRqvUR540k1EE fszNakQiwGpR+R6b700A4dTM5eIH/HudWR7obtTjjhHCfZ8ClQbzHD/GZbH8/96zgADcE5qynDL 03iYlnkn4uZTfb8fLqt2RZRXtFMCxONc0dBfgkq3/TDdEK2wd+CVE9nkVyOO7PW7t/dWoBMONAD
 48AjroWE9y7dR58dImd1I66l2Mk4+1A6Jy8JeIiKjr9IXD6Ox6YnLe4cw5prrnsWn+B71WbF


David Hildenbrand <david@redhat.com> writes:

> On 16.07.25 05:19, Ankur Arora wrote:
>> David Hildenbrand <david@redhat.com> writes:
>>
>>> On 10.07.25 02:59, Ankur Arora wrote:
>>>> folio_zero_user() is constrained to clear in a page-at-a-time
>>>> fashion because it supports CONFIG_HIGHMEM which means that kernel
>>>> mappings for pages in a folio are not guaranteed to be contiguous.
>>>> We don't have this problem when running under configurations with
>>>> CONFIG_CLEAR_PAGE_EXTENT (implies !CONFIG_HIGHMEM), so zero in
>>>> longer page-extents.
>>>> This is expected to be faster because the processor can now optimize
>>>> the clearing based on the knowledge of the extent.
>>>> However, clearing in larger chunks can have two other problems:
>>>>    - cache locality when clearing small folios (< MAX_ORDER_NR_PAGES)
>>>>      (larger folios don't have any expectation of cache locality).
>>>>    - preemption latency when clearing large folios.
>>>> Handle the first by splitting the clearing in three parts: the
>>>> faulting page and its immediate locality, its left and right
>>>> regions; the local neighbourhood is cleared last.
>>>> The second problem is relevant only when running under cooperative
>>>> preemption models. Limit the worst case preemption latency by clearing
>>>> in architecture specified ARCH_CLEAR_PAGE_EXTENT units.
>>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>>> ---
>>>>    mm/memory.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 85 insertions(+), 1 deletion(-)
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index b0cda5aab398..c52806270375 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -7034,6 +7034,7 @@ static inline int process_huge_page(
>>>>    	return 0;
>>>>    }
>>>>    +#ifndef CONFIG_CLEAR_PAGE_EXTENT
>>>>    static void clear_gigantic_page(struct folio *folio, unsigned long addr_hint,
>>>>    				unsigned int nr_pages)
>>>>    {
>>>> @@ -7058,7 +7059,10 @@ static int clear_subpage(unsigned long addr, int idx, void *arg)
>>>>    /**
>>>>     * folio_zero_user - Zero a folio which will be mapped to userspace.
>>>>     * @folio: The folio to zero.
>>>> - * @addr_hint: The address will be accessed or the base address if uncelar.
>>>> + * @addr_hint: The address accessed by the user or the base address.
>>>> + *
>>>> + * folio_zero_user() uses clear_gigantic_page() or process_huge_page() to
>>>> + * do page-at-a-time zeroing because it needs to handle CONFIG_HIGHMEM.
>>>>     */
>>>>    void folio_zero_user(struct folio *folio, unsigned long addr_hint)
>>>>    {
>>>> @@ -7070,6 +7074,86 @@ void folio_zero_user(struct folio *folio, unsigned long addr_hint)
>>>>    		process_huge_page(addr_hint, nr_pages, clear_subpage, folio);
>>>>    }
>>>>    +#else /* CONFIG_CLEAR_PAGE_EXTENT */
>>>> +
>>>> +static void clear_pages_resched(void *addr, int npages)
>>>> +{
>>>> +	int i, remaining;
>>>> +
>>>> +	if (preempt_model_preemptible()) {
>>>> +		clear_pages(addr, npages);
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	for (i = 0; i < npages/ARCH_CLEAR_PAGE_EXTENT; i++) {
>>>> +		clear_pages(addr + i * ARCH_CLEAR_PAGE_EXTENT * PAGE_SIZE,
>>>> +			    ARCH_CLEAR_PAGE_EXTENT);
>>>> +		cond_resched();
>>>> +	}
>>>> +
>>>> +	remaining = npages % ARCH_CLEAR_PAGE_EXTENT;
>>>> +
>>>> +	if (remaining)
>>>> +		clear_pages(addr + i * ARCH_CLEAR_PAGE_EXTENT * PAGE_SHIFT,
>>>> +			    remaining);
>>>> +out:
>>>> +	cond_resched();
>>>> +}
>>>> +
>>>> +/*
>>>> + * folio_zero_user - Zero a folio which will be mapped to userspace.
>>>> + * @folio: The folio to zero.
>>>> + * @addr_hint: The address accessed by the user or the base address.
>>>> + *
>>>> + * Uses architectural support for clear_pages() to zero page extents
>>>> + * instead of clearing page-at-a-time.
>>>> + *
>>>> + * Clearing of small folios (< MAX_ORDER_NR_PAGES) is split in three parts:
>>>> + * pages in the immediate locality of the faulting page, and its left, right
>>>> + * regions; the local neighbourhood cleared last in order to keep cache
>>>> + * lines of the target region hot.
>>>> + *
>>>> + * For larger folios we assume that there is no expectation of cache locality
>>>> + * and just do a straight zero.
>>>> + */
>>>> +void folio_zero_user(struct folio *folio, unsigned long addr_hint)
>>>> +{
>>>> +	unsigned long base_addr = ALIGN_DOWN(addr_hint, folio_size(folio));
>>>> +	const long fault_idx = (addr_hint - base_addr) / PAGE_SIZE;
>>>> +	const struct range pg = DEFINE_RANGE(0, folio_nr_pages(folio) - 1);
>>>> +	const int width = 2; /* number of pages cleared last on either side */
>>>> +	struct range r[3];
>>>> +	int i;
>>>> +
>>>> +	if (folio_nr_pages(folio) > MAX_ORDER_NR_PAGES) {
>>>> +		clear_pages_resched(page_address(folio_page(folio, 0)), folio_nr_pages(folio));
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * Faulting page and its immediate neighbourhood. Cleared at the end to
>>>> +	 * ensure it sticks around in the cache.
>>>> +	 */
>>>> +	r[2] = DEFINE_RANGE(clamp_t(s64, fault_idx - width, pg.start, pg.end),
>>>> +			    clamp_t(s64, fault_idx + width, pg.start, pg.end));
>>>> +
>>>> +	/* Region to the left of the fault */
>>>> +	r[1] = DEFINE_RANGE(pg.start,
>>>> +			    clamp_t(s64, r[2].start-1, pg.start-1, r[2].start));
>>>> +
>>>> +	/* Region to the right of the fault: always valid for the common fault_idx=0 case. */
>>>> +	r[0] = DEFINE_RANGE(clamp_t(s64, r[2].end+1, r[2].end, pg.end+1),
>>>> +			    pg.end);
>>>> +
>>>> +	for (i = 0; i <= 2; i++) {
>>>> +		int npages = range_len(&r[i]);
>>>> +
>>>> +		if (npages > 0)
>>>> +			clear_pages_resched(page_address(folio_page(folio, r[i].start)), npages);
>>>> +	}
>>>> +}
>>>> +#endif /* CONFIG_CLEAR_PAGE_EXTENT */
>>>> +
>>>>    static int copy_user_gigantic_page(struct folio *dst, struct folio *src,
>>>>    				   unsigned long addr_hint,
>>>>    				   struct vm_area_struct *vma,
>>>
>>> So, folio_zero_user() is only compiled with THP | HUGETLB already.
>>>
>>> What we should probably do is scrap the whole new kconfig option and
>>> do something like this in here:
>> So, in principle I don't disagree and unifying both of these is cleaner
>> than introducing a whole new option.
>
> Yes, after playing with the code, a new config option just for that is not
> what we want.
>
>> However that still leaves this code having to contort around CONFIG_HIGHMEM
>> which is probably even less frequently used than THP | HUGETLB.
>
> Not sure I understand your question correctly, but thp+hugetlb are compatible with
> 32bit and highmem.
>
> There are plans of removing highmem support, but that's a different story :)

Oh that would be a godsend! Whenever that happens.

> I think as long as these configs exist, we should just support them, although
> performance is a secondary concern.
>
>> Maybe we should get rid of ARCH_HAS_CLEAR_PAGES completely and everyone
>> with !HIGHMEM either use a generic version of clear_pages() which loops
>> and calls clear_page() or some architectural override.
>> And, then we can do a similar transformation with copy_pages() (and
>> copy_user_large_folio()).
>> At that point, process_huge_page() is used only for !HIGHMEM configs
>
> I assume you meant HIGHMEM

Oh yeah.

>> configs which likely have relatively small caches and so that leaves
>> it probably over-engineered.
>
> I don't think we need to jump through hoops to optimize performance on
> highmem, yes.
>
>> The thing that gives me pause is that non-x86 might perform worse
>> when they switch away from the left-right zeroing approach in
>> process_huge_page() to a generic clear_pages().
>
> Right. Or they perform better. Hard to know.
>
>> So, maybe allowing architectures to opt in by having to define
>> ARCH_HAS_CLEAR_PAGES would allow doing this in a more measured fashion.
>
> One tricky thing is dealing with architectures where clear_user_highpage()
> does cachemanagement.

Oh yeah, I was forgetting that.

> So the more I think about it, I wonder if we really should just design it
> all around clear_user_highpages and clear_user_pages, and have only a
> single clearing algorithm.

Great. This is exactly what I was hoping to eventually get to.

> Essentially, something like the following, just that we need a generic
> clear_user_pages that iterates over clear_user_page.
>
> Then, x86_64 could simply implement clear_user_pages by routing it to your
> clear_pages, and define CLEAR_PAGES_RESCHED_NR (although I wonder if we can
> do better here).

Agreed.

So, essentially just have the lower layer interfaces in place (generic
and arch specific where needed):
 clear_pages()
 clear_user_pages()
 clear_user_highpages()

With the arch defining whichever of those it needs (and ARCH_CLEAR_PAGES_RESCHED_NR).

And, a folio_zero_user() pretty much as below.

> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 6234f316468c9..031e19c56765b 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -264,6 +264,14 @@ static inline void tag_clear_highpage(struct page *page)
>  #ifdef CONFIG_HIGHMEM
>  void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
>  		unsigned start2, unsigned end2);
> +static inline void clear_user_highpages(struct page *page, unsigned long vaddr,
> +		unsigned int nr_pages)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i <= nr_pages; i++)
> +		clear_user_highpage(nth_page(page, i), vaddr + i * PAGE_SIZE);
> +}
>  #else
>  static inline void zero_user_segments(struct page *page,
>  		unsigned start1, unsigned end1,
> @@ -284,6 +292,7 @@ static inline void zero_user_segments(struct page *page,
>  	for (i = 0; i < compound_nr(page); i++)
>  		flush_dcache_page(page + i);
>  }
> +#define clear_user_highpages clear_user_pages
>  #endif
>    static inline void zero_user_segment(struct page *page,
> diff --git a/mm/memory.c b/mm/memory.c
> index 3dd6c57e6511e..8aebf6e0765d8 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -7009,40 +7009,92 @@ static inline int process_huge_page(
>  	return 0;
>  }
>  -static void clear_gigantic_page(struct folio *folio, unsigned long addr_hint,
> -				unsigned int nr_pages)
> +#ifndef CLEAR_PAGES_RESCHED_NR
> +#define CLEAR_PAGES_RESCHED_NR		1
> +#endif /* CLEAR_PAGES_RESCHED_NR */
> +
> +static void clear_user_highpages_resched(struct page *page, unsigned long addr,
> +		unsigned int nr_pages)
>  {
> -	unsigned long addr = ALIGN_DOWN(addr_hint, folio_size(folio));
> -	int i;
> +	unsigned int i, remaining;
>  -	might_sleep();
> -	for (i = 0; i < nr_pages; i++) {
> +	if (preempt_model_preemptible()) {
> +		clear_user_highpages(page, addr, nr_pages);
> +		goto out;
> +	}
> +
> +	for (i = 0; i < nr_pages / CLEAR_PAGES_RESCHED_NR; i++) {
> +		clear_user_highpages(nth_page(page, i * CLEAR_PAGES_RESCHED_NR),
> +				     addr + i * CLEAR_PAGES_RESCHED_NR * PAGE_SIZE,
> +				     CLEAR_PAGES_RESCHED_NR);
> -		clear_user_highpage(folio_page(folio, i), addr + i * PAGE_SIZE);
>  		cond_resched();
>  	}
> -}
>  -static int clear_subpage(unsigned long addr, int idx, void *arg)
> -{
> -	struct folio *folio = arg;
> +	remaining = nr_pages % CLEAR_PAGES_RESCHED_NR;
>  -	clear_user_highpage(folio_page(folio, idx), addr);
> -	return 0;
> +	if (remaining)
> +		clear_user_highpages(nth_page(page, i * CLEAR_PAGES_RESCHED_NR),
> +				     addr + i * CLEAR_PAGES_RESCHED_NR * PAGE_SHIFT,
> +				     remaining);
> +out:
> +	cond_resched();
>  }
>  -/**
> +/*
>   * folio_zero_user - Zero a folio which will be mapped to userspace.
>   * @folio: The folio to zero.
> - * @addr_hint: The address will be accessed or the base address if uncelar.
> + * @addr_hint: The address accessed by the user or the base address.
> + *
> + * Uses architectural support for clear_pages() to zero page extents
> + * instead of clearing page-at-a-time.
> + *
> + * Clearing of small folios (< MAX_ORDER_NR_PAGES) is split in three parts:
> + * pages in the immediate locality of the faulting page, and its left, right
> + * regions; the local neighbourhood cleared last in order to keep cache
> + * lines of the target region hot.
> + *
> + * For larger folios we assume that there is no expectation of cache locality
> + * and just do a straight zero.
>   */
>  void folio_zero_user(struct folio *folio, unsigned long addr_hint)
>  {
> -	unsigned int nr_pages = folio_nr_pages(folio);
> +	const unsigned int nr_pages = folio_nr_pages(folio);
> +	const unsigned long addr = ALIGN_DOWN(addr_hint, nr_pages * PAGE_SIZE);
> +	const long fault_idx = (addr_hint - addr) / PAGE_SIZE;
> +	const struct range pg = DEFINE_RANGE(0, nr_pages - 1);
> +	const int width = 2; /* number of pages cleared last on either side */
> +	struct range r[3];
> +	int i;
> +
> +	if (unlikely(nr_pages >= MAX_ORDER_NR_PAGES)) {
> +		clear_user_highpages_resched(folio_page(folio, 0), addr, nr_pages);
> +		return;
> +	}
> +
> +	/*
> +	 * Faulting page and its immediate neighbourhood. Cleared at the end to
> +	 * ensure it sticks around in the cache.
> +	 */
> +	r[2] = DEFINE_RANGE(clamp_t(s64, fault_idx - width, pg.start, pg.end),
> +			    clamp_t(s64, fault_idx + width, pg.start, pg.end));
> +
> +	/* Region to the left of the fault */
> +	r[1] = DEFINE_RANGE(pg.start,
> +			    clamp_t(s64, r[2].start-1, pg.start-1, r[2].start));
> +
> +	/* Region to the right of the fault: always valid for the common fault_idx=0 case. */
> +	r[0] = DEFINE_RANGE(clamp_t(s64, r[2].end+1, r[2].end, pg.end+1),
> +			    pg.end);
> +
> +	for (i = 0; i <= 2; i++) {
> +		unsigned int cur_nr_pages = range_len(&r[i]);
> +		struct page *cur_page = folio_page(folio, r[i].start);
> +		unsigned long cur_addr = addr + folio_page_idx(folio, cur_page) * PAGE_SIZE;
> +
> +		if (cur_nr_pages > 0)
> +			clear_user_highpages_resched(cur_page, cur_addr, cur_nr_pages);
> +	}
>  -	if (unlikely(nr_pages > MAX_ORDER_NR_PAGES))
> -		clear_gigantic_page(folio, addr_hint, nr_pages);
> -	else
> -		process_huge_page(addr_hint, nr_pages, clear_subpage, folio);
>  }
>    static int copy_user_gigantic_page(struct folio *dst, struct folio *src,
> --
> 2.50.1
>
>
> On highmem we'd simply process individual pages, who cares.
>
> On !highmem, we'd use the optimized clear_user_pages -> clear_pages implementation
> if available. Otherwise, we clear individual pages.
>
> Yes, we'd lose the left-right pattern.
>
> If really important we could somehow let the architecture opt in and do the call
> to the existing process function.

Great. Alright let me work on this.

And, thanks for the very helpful comments.

--
ankur

