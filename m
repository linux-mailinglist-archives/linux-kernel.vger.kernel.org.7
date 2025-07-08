Return-Path: <linux-kernel+bounces-721426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A59AFC90E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 367167A257D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518DB2D8772;
	Tue,  8 Jul 2025 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SfCiz5pV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TdqO42Ti"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B18267B94;
	Tue,  8 Jul 2025 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751972323; cv=fail; b=ipf4fc0Mpw0ZDf54J9/uzx43U/MtIGCMHP2zH/+ssNoVUmV2cz+hAGQvd3StvH3R4lGCvULO/y7hEE+8DgucjNFRxWARjxf7nmBxGcjvUf9koNKPM8SnD/ah5I7CE/uGA6+kVMPSuD+gYaUe8XAFXH7z3ACDcoWZN9lB0VCrbGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751972323; c=relaxed/simple;
	bh=UIFVVsMMN8DmRBKX5lfwk/UV7KSGhL2BjDL9zXXVS88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ngImh6R7JNlhCODk5QHBACCrrN5lL3vC6hlPKAJmCOoGKJ8caBcYb29Ti+ps7SlOITXrVZhn+GNh7TRciUpPmAueUcdjDYfi7doJ7fc/dz7QDFAVa8nh9WJzrSkDiXD3tkHVJ1zYh1QOncE9KWGO+O37U90f16Mf/uDmtdc3jkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SfCiz5pV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TdqO42Ti; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5689CLW9023402;
	Tue, 8 Jul 2025 10:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=GzSaZPFZxkq6msBsu0
	7qCVtIBNOfNgv9CGjDloPSJto=; b=SfCiz5pVFmF9F4KiKlQ51/+hLYAjK+j9/v
	aBRoGBXHmYnGbmSjYZvS0h5m3EWYZduetWoIfcGP8OV7ycyp6jWrrkfl7L5WtpYL
	k91GWiX4vn8yjNBfrl+iGgY3wL/IMCRYrFtQlQ8IPFb2EGgVkzObxXJcYT1+2AUr
	RMoAC3aP//+eGU8Zmjv47yEUP4LWUEpqCUvdOkPCorUlB+bOP52fkJ39Aqk0W9+Q
	NkZRCiqkZ/PO5g2wpERzft6JwqGvYx/3iPIC4F2ajHZCrOoRanQLg9md5sWncxxK
	ff7RbsS6PGQ3LvAr7OdIZs+U7LAWxt1Xgi7ENK4Ja66NrWOHUKyA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47s0g285fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 10:58:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5689pVUc023666;
	Tue, 8 Jul 2025 10:58:14 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg9q7vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 10:58:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xd+UBQMoEpLN26wZQRijgwOYlz1hbl3HQOMI94apZ1AVBvQG57SU/T+c5wDSDY1HfjKMdblZuxbxYYEBR7kZKUHHkSrOIrjrxPAn+XX6w6ihzE4IHPpf7iRScYhFQ6hktktRDYy7GIOCsIwoCKzSNTvKVwF4f52CyEg5PmkCozpoyp5BtFjhFJjH5qYlHvncHSSQ6cYMHrCISwMCtzk7RW4Oo9o2iHGekLDYdX4lBfQHycFR9O+zz2vfHQvd/KbKwbaaq+Ev7wp1J/7wgbF1dTM28RBZoF/fnXv3lV9WfI9k9b+UGLAKOUW22IqBz2WxpQw224P0nm2YD+JGZeI1Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzSaZPFZxkq6msBsu07qCVtIBNOfNgv9CGjDloPSJto=;
 b=QYBhglKLNaKlBIioJtfVLhkAR+gh9EDZYDfOTTC7am8zBr2wAUPOrQ9zvdMjNv9I0nlTm+TsCAJRhhcwMSgVB0EWUt1R57ETxEWUdw1k2clJpCJkt5jpnbvMc15iIJmwXvgQOj0/ecJrFRyE9n2ySfakF4nxoDy+mItqeQUzcWgN/8RwMgwus8xWQD3ngUqfVOHMXO2SDw144Ipq9jh3hYf6pL1x1JP0Z9Z9wNgzSlZhKbvKnFrXomTNaCBWATByfn9wonZcbk0p1aR16CqoAPz1i7ELHSSAtznDo5iDFD+joLMiUG/3EC7Csmi/or8xPNbyMq0N/sC/dvK078uhNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzSaZPFZxkq6msBsu07qCVtIBNOfNgv9CGjDloPSJto=;
 b=TdqO42TiKBPmO2ElHnuKwpsbzibzeiO0Szz8MiAcPfhzV/zXGafazmBtWqbkrVJIZok/BoYSc5oClSuXc4JLF4xfooo7Z7HjBD79rTrCdi2H0Y1nB8uUtKeAc41Z9EzvhBhc6bhH6UPdlj9MvDS4V/AS1QnHuGFdnUDhr+iq2uE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6587.namprd10.prod.outlook.com (2603:10b6:930:58::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Tue, 8 Jul
 2025 10:58:11 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 10:58:11 +0000
Date: Tue, 8 Jul 2025 11:58:06 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
        Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, rust-for-linux@vger.kernel.org,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [PATCH v11 0/4] support large align and nid in Rust allocators
Message-ID: <824065ea-1f5c-4cd4-9917-4b7a91882af8@lucifer.local>
References: <20250707164755.631374-1-vitaly.wool@konsulko.se>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707164755.631374-1-vitaly.wool@konsulko.se>
X-ClientProxiedBy: LO2P265CA0102.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b334101-28e8-401a-5c3f-08ddbe0e54bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0D5EW1TPPZaXf6R/RQKpmO+iXRqhodYtQijuKuKLbcBEoi0VQGmqw8lgl3F1?=
 =?us-ascii?Q?OT6VIdxWN3SbFbyQQIPIW+RcfFco9WM47W9LHxaf0NZ6QrjjfzNEMvTyX7L5?=
 =?us-ascii?Q?WbK3KvxGN03ybj3xS7Cs3DJfnbSADLfWUPA+zxgVW0FvOqJSYRQhQ1gMhPGi?=
 =?us-ascii?Q?DYH3YCWTH+3b+0JBPQguDgUgq+fdbuf6p5zcE9c8J+3/bsvzMaWSEbcT4xLG?=
 =?us-ascii?Q?oNzCoNrEMMpEfrENd7rFJoYNCEAyKiuwGQmsm6xJiPQenCMZTDjS/J3ANAPL?=
 =?us-ascii?Q?8CmP1v7Ke7QlWekWVL0Vvgt+fRDB31lLmHW2ZGJu+tEcZA94x459/Nm4M1bB?=
 =?us-ascii?Q?+qoIEtvv/bz9mRAuRaN1eJyo4pp3BA+CE50xYJMjmKNWl5sei9mly33qT5Qq?=
 =?us-ascii?Q?mk799Aoov1QEBw3EuZy9QiWjb25Q7Cx216kknIB/cAxC7h4IZqzAldqxSL6I?=
 =?us-ascii?Q?ev9K4Nkc8vHNfFAUEilzKLE8lKuRvlDLWH+BxRNJsf1hreCngU6G+0GYl8Lq?=
 =?us-ascii?Q?GC3KQGez9zvTci36O/qnEGUm2I92ua10jzGkzYPrhYYS3Q9Wzt7E49iyXCE2?=
 =?us-ascii?Q?OzTRdSz8R+EEzgw7gYt6fuGRBaLixnXa3Rur/GTzRRSelqrkYR1RY/ADjQWS?=
 =?us-ascii?Q?iui6JmT4QawAeoEcrGzfDSKCQGH+3xkMXA8zLJ7UFHgCmZbvw+ilb69ZOEIL?=
 =?us-ascii?Q?IbBgvQoAtjtakScwpczOMQuovhbKtduXTFgGFcAxM4ShPZbVSRYlC3BHm3Q1?=
 =?us-ascii?Q?LEmHLjegLTzQC/DC6u+0uO+FCr7tMdwXjCTrfxw3N3EeynvrOebylEaZjlfU?=
 =?us-ascii?Q?PhvJmrOavoitknGxXkbHdaO6DDMc8zsaoRDgIRwVPrkGzP/pr5TjM+Fi2Et1?=
 =?us-ascii?Q?sADCQ6cpd2fC0hZP9pQ7OMPtPchvky3wxXSGBYwshBc5rrJAiVEwotx4LXrK?=
 =?us-ascii?Q?PDlHPk3AuctBCFRK61RsSTBCvVNjnQmk4hm0uwyT0iOXoBOsVlfgzpzu38oS?=
 =?us-ascii?Q?ufat9PRh53UhFjbmeJSuQ2YlTskKvttcPjCyLpbiTg21M4jAkFMDMLCc1xeg?=
 =?us-ascii?Q?8RaObNJDIUuItJ3cNl8e9awVGP8KByufmLbYFWt7KWknhdTNn1N4YmodhD7E?=
 =?us-ascii?Q?+WlDO1VZP8gNWGB8fVt1BlrTO9/MrsSdtl+dqy+LvBME0SEC2zn6P8wNySMb?=
 =?us-ascii?Q?lnBPoWRK2j4u63x0Hp4A89EuxozpzwBetXUP6X2kWxxAvw30BC5CZjoXcYUG?=
 =?us-ascii?Q?ILCtKZsHD5XOmBR7unoWmKnVrCbiHnB/tQayCHDqb8to3hlzrHKP9KPDAiHr?=
 =?us-ascii?Q?qjC+jm/e6SfwjC1ejYqS92SWK0xNjkUbdenho0Vh35VTA1+tQ7oyoIFAiG6c?=
 =?us-ascii?Q?Q9ejcYB+jKa/nuP2+2gfGvqrhxD9duqGuVpqArKRCf0D12jP7qsFq7u2HVSV?=
 =?us-ascii?Q?RR8hjzyJnsY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P4MIWFQzfP6iqa2gFE8hwVPtMS8lZmeoS/LWLQvoGvUjfC43P/t0TPSqSh8P?=
 =?us-ascii?Q?MSXdhsrWPlkoFtf9uepGHGJQRiIYQ75K0xRBRWVZcLrv92EAxoZkReOWkeMX?=
 =?us-ascii?Q?BF97plOjzJUI+jLH061T37eKwbRqEhp4MZNp65o3UOt12FEfTvD9cjWtVjcn?=
 =?us-ascii?Q?/IdloZ0U9WzPCUom9iNO3GhqjddyGfyBUK44rjuXkMn5BGloczypame7shcu?=
 =?us-ascii?Q?gLj4O6KNBfh3ijGOohhyzBMDPjlXy5RvogMBeQ3xwYi4qCZCvtRLeES20cYB?=
 =?us-ascii?Q?jjTbo61zUO0PRWaAD6CYf58OTTZbYhG3D2/3/it/IRvM8mn/P23utf0tdUwT?=
 =?us-ascii?Q?zQ2xD/DtvF4zuxOdnRzeXQEPwgtKBFRSAA9YwXUZBd9DBFVi8PsReLaNEhJS?=
 =?us-ascii?Q?dmeBHUAoLJRc2sEEP5asjDO0l7/hiUfMbkBpzwEe/TstG5MYn+eJSl7Zqq5O?=
 =?us-ascii?Q?aCxqruLcfVuNMUom1QH+rE1LqJ9lAk+RSWcezecxkzMxFjTsXICeiHKB09zG?=
 =?us-ascii?Q?Cp8ISH/Aze7s/8gldZ8PtoAtlD7hCU4Aq1wOBzVCsXKMyVZ/ShNLUUXih4k7?=
 =?us-ascii?Q?Kq9ZIbpTyHwfhL+Wycv09a04fQRkPv8y6EfPnHnMDD9/o4vHwXiLrCw+PbZG?=
 =?us-ascii?Q?Zl/N5MYZFIcpS2zQEqBNqT/zu/Y6v5v924/zUmmTXZzd2ZCQOjXDDbkqHPZE?=
 =?us-ascii?Q?XzlJcNvDXLhAh6fJ6Lw/fmAqSlmjOPCh+o+XsmfbeNurC6Ij2ZWXQkTxsJgP?=
 =?us-ascii?Q?6bo2Rct25qpF93kcxM9AwXYEaifDkvg1jLKcwOeympc8sww3DFKKL43d+tJ3?=
 =?us-ascii?Q?sQoVXQrDkhGEp5CguSWqCLnVjEEPjAXKuBw6qXv5W0X51N9p3r3GpqWG+hgV?=
 =?us-ascii?Q?uCrTlrfswu7qKsMeBS69FXiSS/gkqCEupQ9LrhUBkko7rklCAgPLGE83Amv5?=
 =?us-ascii?Q?DipqOEAYTaOw+NXhcz3WSZOJt5lnUgb2puRcKbIM+a8UTwSVorLZHbiq41TE?=
 =?us-ascii?Q?W4gk6xfGaa18/W6ot1p2scHRdgn1hX6ZWL754EHKWbqmwiADMtJQLkmeKH+Z?=
 =?us-ascii?Q?RkjOnkVAqA6s+3wfowzC4lMsN9oDMk0nFANdwgYrWlNSP8adoQOGIDsjMyJN?=
 =?us-ascii?Q?IL3ta5CGN3sgbGeAGf13yir6/hiIhg7LTV06s/l7GHRvZIJv6BrGkIi2tW4D?=
 =?us-ascii?Q?M4ARq1m8/12ao5jRYPOh+dtr8J5rtmqBpckswZEn9APm6Xu1SOD20QLbRhYz?=
 =?us-ascii?Q?heD0yHrGxF3wPrtZ2hsziA3PlXhFEKeD0mD9Ky7sMaIxmz7AQieuet0Nuwz4?=
 =?us-ascii?Q?wXA1YOBdzEQCVPVAFAyUjEf7xFUH0l2Ki5gVSgzwyXfZBkuC5P6NvmahkBlP?=
 =?us-ascii?Q?M1qCeNSoRfPfFcHtHXmr82bm18KKR0AUEPql8F8wM5FPWwItuttF9cyxGZfE?=
 =?us-ascii?Q?U3iC8veS9WWDFD5PSc0SZKg4R9j78P1ij6yQZJcOqjHWoMHBqVyl+O+QyWD/?=
 =?us-ascii?Q?BVQFDtRHZrA4HiCxj3ECp9AxTocpmZ2R+4E4pJxU+IudVx/3deCpfOFd4yTY?=
 =?us-ascii?Q?KhtfKOd66fTMp3J9yTK0fvYvCv0wHQ0dOa0is+/B5gTDRq503VEMZiHCLHEE?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LdnA41XjEtkKCvKYb5qIGHyeroS26Bb47u4qlCuBLySqDlzjHj324QVnIfMaHhwX6QZE73c3SLGABmXC3kdETdwxyiPGplveb0miILalUZZUsQE7z4TFIcP509SnZbVKnSTseBEpixsJKExivMI0RULdbLS20Y9mND5OcybFYbST3BQFlNXFO8spQoqEU+LJ4TvIbf6+UxAoAD5BcQolTWIedsAE7PEaeavI6p4LFPWZCB9O7aiNr3F31NtE1Q8jOTRHtSDmqjQ9jSsWfZSZZV1HGv/XmxADqR5ev7QBUQRf3jSanGgdggrWoYZmF4tkBJy8218OEAca5utbt0bvuvkM+rXlaLBOlGbHLfANEHDxgF/8ep5FVIRcBbK3vX8DpVo4hW+VblVYMCONz/CtAXt+ix4qZwaKpsdCDy9wQS4MqyehNYP1qIwN3Swfh4QFceFpEMh9K6oNyqxWihil9byRr3m7EXO9TVv9fTy5kHUcKh/4xSz7cSZlb6/yMzHD3eQWt5ETOPKhZrDUEPMj32P4BTjO4AWmVXTxwEg/Ktry5MFyPpQGTVr16nUB/3aS7Jx2gRvMM8ykZJdcmvWKaUCJc5KAa0wvyK42kZF4Jgo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b334101-28e8-401a-5c3f-08ddbe0e54bd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 10:58:11.8983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qn5Y+U9ELP1xAvPVpmQEV4RngBZzKt0vlxgjDVmnhTGH5O9e8U9XPSDWRhXVmBEKuNWEPpOIitmijX2GkoPTLGOEh7+YFFIQPKy7ULRNbIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6587
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507080090
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA5MCBTYWx0ZWRfX2XBrf9/zCeNI k2uaffhaDhslS1NojXBwwm0TWdc7+7mDgBXAGW37AXTnPyAmIrN5RX8WNzRXPUj3pXjqj5Yc5uA 6BsRDZEocWLQ4D/aOZMd8T2B1oaqNE3eelsRfrVsZ0VK4I0loy7HFPybFDNFypGs2vRpGPcWV03
 DK30lmIyNs0ZrDd1vI0MYLNfUHnwiYmydyNi8+UAPMMB4WtrGfrq+weMawVFgmKrkqCKIDEMbw0 l8jrB/++HjNB+S204Ro6NOhVIph7hJ+VgxG3Jly62Ijw5P3+BMKTqhDGpig5DJ6NTZ2A6hADHD4 5CaRXNEyQAEOrL0shsjK5mS9WEE4tD7kw2s0yLX9XfXnWdYZC3FZVVV1eW32Nc6Klw07VusGh3M
 OayZOZNrS7gqlWFRhg45mkBaC3IIYDtfL6qq5ni+2ex0t8wYOBOK7XZtZbxTKytJKa/4FgkB
X-Proofpoint-GUID: inxw2F-_HASTzyRiYaAWcsd_wXJ6B1UI
X-Authority-Analysis: v=2.4 cv=eaQ9f6EH c=1 sm=1 tr=0 ts=686cf9c6 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=ZHbSMLQJ4WFJSCnL0CUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: inxw2F-_HASTzyRiYaAWcsd_wXJ6B1UI

+cc Liam

Hi guys,

We have a section in MAINTAINERS for mm rust (MEMORY MANAGEMENT - RUST), so
it's slightly concerning to find a series (at v11!) like this that changes
mm-related stuff and it involves files not listed there and nobody bothered
to cc- the people listed there.

I can fully understand there being some process fail here meaning you
missed it - fine if so - but let's fix it please moving forwards.

It's really important to me that the rust efforts in mm are collaborative -
I really believe in your mission (well - for me it's about the compiler
_helping_ me not shooting me in the foot :) - and have put substantial
effort in assisting initial work there. So let's make sure we're
collaborative in both directions please.

We have rust/kernel/mm/ under MEMORY MANAGEMENT - RUST too, I'm not au fait
with your approach to structuring in these folders but seems to me these
helpers should be there? I may be unaware of some rust aspect of this
however.

Can we please add these files to this section and in future cc people
listed there? We're here to help!

A side-note I wonder if we also need to put specific files also in relevant
mm sections? E.g. the slab helper should also be put under the slab section
perhaps?

You can have files in multiple entries in MAINTAINERS so it's flexible
enough to allow it to be both in the mm rust section and also the slab
section for instance.

Thanks, Lorenzo

On Mon, Jul 07, 2025 at 06:47:55PM +0200, Vitaly Wool wrote:
> The coming patches provide the ability for Rust allocators to set
> NUMA node and large alignment.
>
> Changelog:
> v2 -> v3:
> * fixed the build breakage for non-MMU configs
> v3 -> v4:
> * added NUMA node support for k[v]realloc (patch #2)
> * removed extra logic in Rust helpers
> * patch for Rust allocators split into 2 (align: patch #3 and
>   NUMA ids: patch #4)
> v4 -> v5:
> * reworked NUMA node support for k[v]realloc for all 3 <alloc>_node
>   functions to have the same signature
> * all 3 <alloc>_node slab/vmalloc functions now support alignment
>   specification
> * Rust helpers are extended with new functions, the old ones are left
>   intact
> * Rust support for NUMA nodes comes first now (as patch #3)
> v5 -> v6:
> * added <alloc>_node_align functions to keep the existing interfaces
>   intact
> * clearer separation for Rust support of MUNA ids and large alignments
> v6 -> v7:
> * NUMA identifier as a new Rust type (NumaNode)
> * better documentation for changed and new functions and constants
> v7 -> v8:
> * removed NumaError
> * small cleanups per reviewers' comments
> v8 -> v9:
> * realloc functions can now reallocate memory for a different NUMA
>   node
> * better comments/explanations in the Rust part
> v9 -> v10:
> * refined behavior when memory is being reallocated for a different
>   NUMA node, comments added
> * cleanups in the Rust part, rustfmt ran
> * typos corrected
> v10 -> v11:
> * added documentation for the NO_NODE constant
> * added node parameter to Allocator's alloc/realloc instead of adding
>   separate alloc_node resp. realloc_node functions, modified users of
>   alloc/realloc in accordance with that
>
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
>
>

Odd you don't have a diffstat here?

