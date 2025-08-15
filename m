Return-Path: <linux-kernel+bounces-771377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6503B28637
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6993B645B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDB324167F;
	Fri, 15 Aug 2025 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VjWJmLI7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y+1GbJlI"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EFE2BE047
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285102; cv=fail; b=oPIBbGNfSQ+KIQmoJHwx50l/Q4uXHLf5GLD3wnuibOo9HbJf8ylq++WafEMH62m2e2mThMDYfJFnNKOvtIp/cv4wr0878KJTwficTh+3zdMsIoob7sLhrms6qZjoReAvxcrEIBlClTTT8pj+2PEhkIPMWozbzbfPpnvjExn1rKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285102; c=relaxed/simple;
	bh=yIhsPa5OfHNPvp1MAvk5Bfzpo6J4FZardRA7QQIOiEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O4qc/XK07MGt6jnszuSO8f4NKEd27yzf46iZiN5HgKdlI0VEXmyO34myJqUmx3ieXSmSKAMvIMEZGPp2CqVOpLh2BmUoy+ZpRjHA993e5H2xYjkcLFoYSKhuwJB1Py3LQwQNvgmaWGQqqalG31zrhOmmcoa1NYNVlRFetXIWOpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VjWJmLI7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y+1GbJlI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FHlKIq026403;
	Fri, 15 Aug 2025 19:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cxa4HsQyjCDbSgSGhu1S1rdqYziYP9dK0uKaD8t38Ac=; b=
	VjWJmLI7QyhA5V9WBfiWx9Iczn1rxUc+DAEZ7y9rFwPoy0OS/IQdYS1GAC0M2Lze
	lDmbL590huM3nokI3+3gGhCsruOZlMhJUfTfU1AYOf17mMn6o6XZ9Gm1Hk8LeYNo
	vOZxIxCLF+CvvnN0tf4IhX9Rd+bYR4gHh1mDPE4xBxJ70BDlELmUd7RTg8GL5S7+
	RRYPsuW6VmHVCcweOCE1x+y+BMNnWe7BrQQq5U6RHcRk1bo55blqbhQN7Xg2Tssr
	XAebX1c7njAXoF2ApRIP/yZnWas7m8+TUCR7nAty/WZA6gza8yNF4vBpUX88O5bs
	SE5C1sgsSkuwby6r89VG9A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw454hmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 19:11:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57FIkCXf017404;
	Fri, 15 Aug 2025 19:10:53 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsea96v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 19:10:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAPslISKWwfnYNksEkw3udxhB7yGDJEOkiE7RiE3eQfX3e4PL08G93XOg1sQDTvw8xc2v0U8ju1yB+V4Z30VhvgS/JnIP/R5QOZxUbEFXiKjWtoXRztUomYTEXxO2HGs5p8P5Bn7tPjanBCs74V5ssMRMoPEiHQyzmh4RrH7PuLAwJvv1fQPmVvbhMW3Th3DR9uU/8QxVxWpXRYTA3/d0pIiVinKVst4omgB1Q9DWdwLceCRP8klPzEWgnvc8Si6mrtPX+VJJ0WXazlVwLU8lEL6RE0vnyOb1pYnYF9XQ0ukogQaIqAmYmj6uDLcnrRG9afHsc/WNkqRxzGWdVFEYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxa4HsQyjCDbSgSGhu1S1rdqYziYP9dK0uKaD8t38Ac=;
 b=QDVwSzBWidnQfphMHvDp/4e4hPzKaThuSbpZqwVWeaGkAXsVpeza8QksAGgmexl1QwUTnHTbF1Pk333RQI4zJbN1iXqiTXhjYXySWCm9CHe5k3GGZ56D5Kuo8pWpTCdx3xWURqMXGYuOWafR8b0gFTptYvKsDXcVpUMIUr21b+05ZfnTeQV3aOtUksA/NKSALXa2NXZWgZM/WLGPiC/FzR1APkXEYiKUzTaJim0XYmoO5h0TQHtPIpVgPG8tDZbZAO2lzBx3+jEFBovgX/rrQyYm+9wtmNm0Wide086AaZwZlLySFvDZZmO8UZZxxHG83ewn+rb3REcmuGPhZsESxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxa4HsQyjCDbSgSGhu1S1rdqYziYP9dK0uKaD8t38Ac=;
 b=y+1GbJlIHMKpw0mYbZ9BPtu3q2nfZ8WJu5aqClKe3t4csMWLIbzEYFvUA30UQWKx8e0DAHEzcjIW4/keaeiLoP99EJEVfGtGqYKhv5yZwXKosJS+KgvRfX+OsiSo4XoWpRMlRSCwuqIhb7KC9a4NYODuHF7+kEY/DxLISaZx5t4=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by MW4PR10MB6464.namprd10.prod.outlook.com (2603:10b6:303:222::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Fri, 15 Aug
 2025 19:10:50 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 19:10:50 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
        bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [RFC PATCH 5/6] mm/vma: Add page table limit to unmap_region()
Date: Fri, 15 Aug 2025 15:10:30 -0400
Message-ID: <20250815191031.3769540-6-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250815191031.3769540-1-Liam.Howlett@oracle.com>
References: <20250815191031.3769540-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:303:6a::6) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|MW4PR10MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: 75fcc72e-26cb-468e-422d-08dddc2f72f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G5Oa7jjj/NG3EgdA4Fe54IRJixGrgMaPrY/GeSfcpfN+kdiJGTka1hvmX1g1?=
 =?us-ascii?Q?kSi0tTqw7FSAOTs27yNAqVKO3uFwxdaVCF+CNAzNUxQ5yjct1N96My+9I3mk?=
 =?us-ascii?Q?uFFxeVAPwin/0Or8nmxhmQH1Zpaa/Citqck4k8DVYKxnKPQvu7cLF4jG4uT8?=
 =?us-ascii?Q?kGvbFiICVSeZc3Ydnoe+DzNbEQA+8u+4V500Zc+8oFJTnfwjm3DkgZlyvyb6?=
 =?us-ascii?Q?ewRTLuVpcDZJIPvO4yebuvPV8KabaRsBeoMOqLzIqp/pCBLbqfE0HDfWndYu?=
 =?us-ascii?Q?p5TAiGfmlaFmWx78sLe/mqsXAG7gc9RfUyp8ewLYN3N+PZbl2fACHGowvlgT?=
 =?us-ascii?Q?F8bRXQ0sPF0vHX+H9w9ifC+LcE3HnirE/MCCy3PexhbcRa4PjK1NMFK9LIeE?=
 =?us-ascii?Q?8KfRd/Ogxjj8AZUkJJw4Z2fz4dh8sAEIeIMWFH86QPFRZjOx0Qdt/euDjXgd?=
 =?us-ascii?Q?z0nbRkpTExcYjzsQ9pEuEJPF9FULwnLGjcxiCGlmGR7dJ0I2woULNp2gjzOR?=
 =?us-ascii?Q?cOx8FUx4SokpfMaGhBvqRC4eCBJweBVKqCHRSKRZ6/JeQXPDQGel/ynBJ6Hj?=
 =?us-ascii?Q?faIvAOFhOoyHwDqOQRo5/5G4BP9nhgaYAPfzP2OIUMwCwlebA1aQ9ErioJT+?=
 =?us-ascii?Q?5b24rNaQb+YHNT+OQKOaba0crO/hs8IjyMfbTTiwDpyZAPCYc+47k0avD27e?=
 =?us-ascii?Q?DHX6wHCzSynhP5EWR9F1faBJzE0DGXsfQv9PXs5evQIDhDcMxyRgHk9MupbQ?=
 =?us-ascii?Q?g+KqABW3tIH7WSUpYq5YtQHzONK6baIhcicyOjhsqZXHjgrdtiuj9lvdcnmY?=
 =?us-ascii?Q?JKwixD8Gnp2lQhJlB80QVZiCGHSQ7iPogFN0IxPfSlqjdhl7i5bk1l2g3NiS?=
 =?us-ascii?Q?9AfSoh1puz3dQ6WvQ8xS8fmKIb3bnpsnxR0CdT9oaEy8bN+8g2uC3riwTFAB?=
 =?us-ascii?Q?r2XWL2vQXh2zK7RdoYAMKvvvZifwiOQr760b+rZCcqj8kUqW6HFc1OG+RO5Z?=
 =?us-ascii?Q?/dFJOz6UScZF1PcCSJIjiqpfCCJsj3Xb2qYkklaeJxqfVLbOkYLBKkazbDgm?=
 =?us-ascii?Q?RLFGt7eJC3LYIUqZe89HqYSZwjyhN05rQFYnHXyyTOBQXIHlMncFEifpFByz?=
 =?us-ascii?Q?ZxQ71dGXNhwjJ71mKiO6L5p4xlmigbqQIBVmblJt9xkhUiT39X+oH5koe/tk?=
 =?us-ascii?Q?+8olWoZQvbDtgVzfL1Vg9S4xXvjikOVFgT0dbauSwn8fkm/QkloNB8/m1R7N?=
 =?us-ascii?Q?QDxAFnk6eXiSdjN3WztqL5poKDUSyEvgkJwins9WGnQN2/njI2zULusp8poF?=
 =?us-ascii?Q?Occ6MnGEq5xRkjt7eTFPCaTN1NdmpfgkL9CHoTXmY8ZH2Q2UlMnoczUb0BZC?=
 =?us-ascii?Q?5sf8snKGok8BcSFvkWWs92O47zNdNpWZ2Y9l75goXCCyQdb/2OuIogIExOLX?=
 =?us-ascii?Q?9Ym4xJeUekM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KP49liB8kooayILQA0+LHNDdSmY6lfoD5J+1qrojRd0xTx8B5Hb9C6oBb0LB?=
 =?us-ascii?Q?CHBeOVQ6DLVVZqSBusdaQTZBnfRDMNsBm0VEN7unqDyKcdX+qskF2DLLf8R4?=
 =?us-ascii?Q?vzzkc6/JbnoCOE3JzQhitJqrypIXpUCcpitlmrq3tSBGTNLukCi6gSyhqCEg?=
 =?us-ascii?Q?DqI2Lg3z2vZBcJeP4gDzIz0DDVF/rAtBNdhuK/hGhJTZWculCcOE8LT2zBtV?=
 =?us-ascii?Q?wMGhau+XdM+miLzDD5fJXoYQQB/a64f/hD4XUE9T+TQpD/g/SZ/Gd1dFvVqw?=
 =?us-ascii?Q?FzbRD1Mnz60FHv82MV5H1EAa60ybezB18GJxSs9UGFLyFKAH5XGQO75LjTWz?=
 =?us-ascii?Q?tmw/QjGY/tPpbHbv8f0HwZaRnFM4rcO/qLc4MF4wZZvUsLt3widUBroqkAL1?=
 =?us-ascii?Q?kjwugOoS0AW2UUffYZys02+rMygZ25lviK0sEa9HPsbBMypwXEEKnG51eBkt?=
 =?us-ascii?Q?Tm5rs6V8UJB+moRNPJZeCYaa/SMdTWeMPO8HAVSzaUWGaZzpCfggnOL+sotJ?=
 =?us-ascii?Q?Fe1S/ya/yF6JNKFFmwkCZ0ZdFYX1vqgOKgFBU8IwdUv4T8Q5pma0sTcocj+e?=
 =?us-ascii?Q?NQ8KHM+iy3nlDZwPVQcEB3UeZ5saYEYplWFuILtb4coyeUTdz7e+RTjVN+/t?=
 =?us-ascii?Q?SyfnBowNzpCJGAcw1XmzwE0ZFph+HJ6FhlUhy/JIe6yEeAetnTMAZNQHlE9s?=
 =?us-ascii?Q?1alYiYgzICkqmLmO3FErooJ/Bt3s362Xx0aEqFe3KM2euJVvkSE2/nStRu8q?=
 =?us-ascii?Q?sxsbRy7hffyLjnGFcZMoMBu9rwTDPpljBEh0nqzHHCNoh9DunWwZ5gcgSUDx?=
 =?us-ascii?Q?lQwd4ZgD4SiJFO5zIfW6Ej6jk29Ka64DwVWcHLZ5ElNCiY/LaQaek/1GHlOI?=
 =?us-ascii?Q?pYXokF0U16pErKP2qvAzU4lzvxzGIwygNSa30jFWEG6Haq9F8YmxGgKGZ5rd?=
 =?us-ascii?Q?R/kcOBx6pnLn6KRde1etj6D8IhsM106pzudGMIauuINNjq5zWzRUCdvgH1ml?=
 =?us-ascii?Q?3MW9Wvf9f8wSGh1vPx9QATGAFd4KM4RHx+BfMz7QX4VmZlAso60wycZWyCvj?=
 =?us-ascii?Q?cWtPEWA7mmUtC+l1jddl7GPhG4xurou/lLkMyURUOQrHo5pmjny99i1Ew6iy?=
 =?us-ascii?Q?AGeXTx227o/NiJQs6Ju1qgDX8Dg1r0HwFpGbSZC8h1miEgdhSsLjVp1jJwdO?=
 =?us-ascii?Q?/ZpOx8ZzW5Zn/k/m56sdckfCIZz8SUaBIuy6GcTo8NujzvCiR5yg7yE1zz34?=
 =?us-ascii?Q?XMoY5oq7PEJG57y3jBSWXo4Dn6G8Ry1rZA6GoWI+lnyzQC0VTMHDQ/48IA0/?=
 =?us-ascii?Q?7rhN3B3XvW2pTlrDD0hE99UjSp3tqKsh4mTiO1GGaWGEop3F2f1CLhJGpMzS?=
 =?us-ascii?Q?96E1OdPvmdaw7TrILihtf+q9bUlgsaU3Yr0E6KhcxyNWQ9xEr+9EvWo3Pzxy?=
 =?us-ascii?Q?z5aB88ZbdXzQMRgRTa5aRqDR8gqR30XeZ6Ue38QkAdmcp+3Hy6uwuzEHOMRi?=
 =?us-ascii?Q?Z9QurcTlbFKRPuA/O8fUuQaBTjzUkTIUU84y0RgVzaOY9bvta99FQ1RptgxY?=
 =?us-ascii?Q?i4YB2ELUEse76f4LfA6lJlTiDFJDSgEJyw1JnRtq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zOUFkJweytRPLNntmzi6ERBPhwqy943gAlXniR61ShdvgpN7LnJlgZTqbkL/tQM/YSE3FBrNfP1hva60bn5kK4XfHBb9E9BH95WermL2TuYgDZOdKgrVULI2ekaYEysI/REzFizVL0XRf4oZGzx/4x/lTytbv4yYxDu9RJgGCCCpt9rhuUyK18CQ2x5pkogV+Ki2M884azpPjwrUoeMe6xhIRtHTYqUQOgf4IvHZQtgCUrLVtSaz+cKKqLjBsogNfOZvRchAAw6Qg4G4E6GSNVj4SiHThvM4I4Qsiv5bGo3xn3TBx5B9QV8+KH9T/1WFclb1YboFhAfWmA72Hy2wITX+EzQ/kFbfs5AkvmWYrvs6steV/PVAyNc1eIJfipJkqSoqqoh9vzK9pP27JEndZi11TIUuRJpX6O9ZV1QP5vbF71Tx+2VmdW6DL/nWyaZi4ZjOmqakZKWk6aWN/TLn8+Dn+hsypYJII2zdCeRwGF/hN0TjfESF7u0JJzcOrakK/7tjI+jEucIO9agWrjJlR0jGTuoRuCNS3G12m8N0Oaix1DV4LLlHf1cKE0QRbQ1RayBQun9RF++9yUH/Nj0FEv2mfGGbKNupcR5FL/sjmp4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75fcc72e-26cb-468e-422d-08dddc2f72f5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 19:10:50.8026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PycBTi66qFrYqE8mSCjpEE0UxmqXsAcJwG8NsJZCmX0Eb+7yLh2rWGUGjZHgx21I5w2C18YGFtljLL4uUXgV2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6464
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508150162
X-Proofpoint-ORIG-GUID: y5jD6G_-GPCNE1HHiPx6RjjQffioepNI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDE2MyBTYWx0ZWRfX/xW4smhKeliO
 Gel7COO2jpls4hYYY/+fkNqNP5EuLJOxfgNh+uZZD0v+/XPEhrKWuLFGxVCk/3juSi16Fvq1TEN
 bTZNk34Dd13YZjaXPNom8go2982GbBiphcypwlngYMOHhsz/q9njKCgQaS3b2ZdukgVcQK7kZll
 pDn5VnQ3BoukLhYWKbMweXpsBAfuN91/s3jsEVPGUq+6eGrezvl9e8dyyKz6+h2KJLbFCpnEeb4
 CaEuNoq2MmNryUqbCyOHbc1Vt8Z/4m+IcU+EFLm2Wm3ibC1I6OAe497ymhyaUalf+1TqjnvYLqw
 exOlDnFH7WtdeSaiiE6zkrqthpy9iB56l38d8QaXBuqRFPnRChWs4VKN/PFZ9JGLXqahEAN0Tjh
 7Y1cxkaU5dVpdOrpJbuigL1QikjIgjZEopqjaid1Ex0jSksWj5W2DxZWbue9uJM1RYy6SMmH
X-Authority-Analysis: v=2.4 cv=X9FSKHTe c=1 sm=1 tr=0 ts=689f864b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=mRhb7lE__WOmgSHBrkQA:9
X-Proofpoint-GUID: y5jD6G_-GPCNE1HHiPx6RjjQffioepNI

The unmap_region() calls need to pass through the page table limit for a
future patch.

No functional changes intended.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/vma.c | 5 +++--
 mm/vma.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index aa75ca8618609..39f3b55a020b2 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -474,7 +474,7 @@ void remove_vma(struct vm_area_struct *vma)
  * Called with the mm semaphore held.
  */
 void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
-		unsigned long vma_min, unsigned long vma_max,
+		unsigned long vma_min, unsigned long vma_max, unsigned long pg_max,
 		struct vm_area_struct *prev, struct vm_area_struct *next)
 {
 	struct mm_struct *mm = vma->vm_mm;
@@ -487,7 +487,7 @@ void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
 	mas_set(mas, vma->vm_end);
 	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
 		      next ? next->vm_start : USER_PGTABLES_CEILING,
-		      next ? next->vm_start : USER_PGTABLES_CEILING,
+		      pg_max,
 		      /* mm_wr_locked = */ true);
 	tlb_finish_mmu(&tlb);
 }
@@ -2420,6 +2420,7 @@ static int __mmap_new_file_vma(struct mmap_state *map,
 		vma_iter_set(vmi, vma->vm_end);
 		/* Undo any partial mapping done by a device driver. */
 		unmap_region(&vmi->mas, vma, vma->vm_start, vma->vm_end,
+			     map->next ? map->next->vm_start : USER_PGTABLES_CEILING,
 			     map->prev, map->next);
 
 		return error;
diff --git a/mm/vma.h b/mm/vma.h
index 336dae295853e..ba203c0c1d89d 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -281,7 +281,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 void remove_vma(struct vm_area_struct *vma);
 
 void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
-		unsigned long min, unsigned long max,
+		unsigned long min, unsigned long max, unsigned long pg_max,
 		struct vm_area_struct *prev, struct vm_area_struct *next);
 
 /* We are about to modify the VMA's flags. */
-- 
2.47.2


