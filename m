Return-Path: <linux-kernel+bounces-799210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED0EB42877
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71761B2757D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161B635E4F8;
	Wed,  3 Sep 2025 18:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ndoR/+cb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OQ0n2ieO"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8027A35A296;
	Wed,  3 Sep 2025 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756922492; cv=fail; b=aVff1cPiFuS5hXK+633iwt2FdVWvei5OLBq7Q5qe/oX09zoNUBOFsGMKKWo7zG/LZ5QgaLQWmrgIGf2K1lQVHRlvRe44b/o1VF8raHEMPLgoRz7v5zGNAvtjkzj61xEspe1ypcrKr7APQqzMUPYo9coCIOpX1Qu+tO7k/pG9g4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756922492; c=relaxed/simple;
	bh=/HrV2xwSERNIlkxP69miI2K5jOkhLF/x0gK5OR7vZVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LJAjFycNN2QSpEnQpTcvuWK7+SMhsVBTmhvNv74KkK/paJjLAtDcvRXA8UKiEuhqWW1zFEec2EOSHHVOfwibn8bUXlD//GrECxKQra+9uD9mLCk294BuPYaBp/t462VOuD9vqutEXGwtLlB1y9FoUP5buYxyHVcOj9sjp6FEDW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ndoR/+cb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OQ0n2ieO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583H4d3r001269;
	Wed, 3 Sep 2025 18:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=jME7gaU58VHRID0C3r
	D6usD0JLNzN012J0HHi1JVScE=; b=ndoR/+cb0DB9Snfi25Q9fnqgkqmW3fcy7h
	pnm4WJTXcbtBQQsjKiDfVUuiT4g8Il/LztENoDmcZckop/PHgBYRWzA4Q884CVbL
	bgBgwRGIzWEMvE9QqMsa6839eXOA0zWdSlPG71Wr844z0RgonZoA99nE77XW9A7k
	mgSvlmJLPrUIIKpiym/l+hRbpHJPHsfCW2sv39L8xdt38iBZ/g1ZU1RIiutopzSS
	HEcJTzOx2w956ezGShFG1Z//XCUCDhNHj4YdVua4/fZZ7YEPuH/b8bPfK0KgHv7G
	GnYF9ggtSsily7z2lz4j2SXCAN6caXuqR4y/KZD72LWWUx5wpEpw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48xsrm037f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 18:01:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 583H3Qsm031094;
	Wed, 3 Sep 2025 18:01:12 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqraqmbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 18:01:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQQbM1+RiHFB2q9tyUNvEnKY6joDLUBzvKVzNVJxzdmDsxjvdy6L6ZTOloPfPpzKS+8Te1HFmHPRgjo3n719tIeh/nIMqPbthnYB9SU7eOUQkfNd+dQC7Q5qtS1833QkuOS2Nh4vWx0sP5LMpnAV9eRzxjTlxPG2KGoBkxNyJDZSGEdHkUNrh2KhYCZvyGDl7xUNQk2otKPaaxRaSaJrLoId39rcvI48w5l5wufGBpTSbvOTliwEp00H+fTGFR8UMvWtqTI7CKuIOHnV6W+UJ2G/4ZEch6eLrkPApFrT7hoH5u/P8Kw3JfUDqHOtYcF6irPRsaaiAZbGMJzGuj1etg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jME7gaU58VHRID0C3rD6usD0JLNzN012J0HHi1JVScE=;
 b=je1ufiq4Qc5ZvObH4/Nl66oizkPo1qwv2ElRkvDsnmkkT3F9oOu5q5LpZvNjxwk8LhebNv5/pqWrcCqcLLywhT5Y5Mg4QgjdxmuXMK8N0RqvkShgjiaYEgWxh2FJ6b+SBG0EHzTx53xFDVB2svvGVV0ZVAYBUuT0R7mv/DMYHCU8HArNgoatTYVxXGzcA8+zNsh5OgQ1dqDVcNTB5gLz/RBrw/9S4d0esbR4aqPR0b5d4jWlB7rvaP1VHEjS0B4RdpDhFVWmPQYHqeOwchm2t5nsYNld5PtzaUVuIkqtQnrKAJQApTOcalcRaIPYkSsfYJoe+PgE95DkBuYN1bjAWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jME7gaU58VHRID0C3rD6usD0JLNzN012J0HHi1JVScE=;
 b=OQ0n2ieO5igPMjPen4C2PHdOVNDt+B3UQ7FAoy+7k6tgWy3tcdZyU98OodvaEGjcFpnPIg2pWWo0w4BlSs9TFGeFFRoY5Nzl7EB3Vb7EN8RFpVSNkC/41ePAAZmT/31QhcvLtbnX9v3TpL27ZMkrYOtVCV8z/FxM8e+vbYbdlro=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH2PR10MB4391.namprd10.prod.outlook.com (2603:10b6:610:7d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 18:01:10 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 18:01:10 +0000
Date: Wed, 3 Sep 2025 14:00:54 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] maple_tree: remove lockdep_map_p typedef
Message-ID: <o2vlyvq53kciyc5vhm7jgrvormdw6oyqmsnzbgagiq4niuurop@n3xa7p7ti7xq>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
References: <20250902-maple-lockdep-p-v1-1-3ae5a398a379@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-maple-lockdep-p-v1-1-3ae5a398a379@google.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: MW4P221CA0022.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::27) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH2PR10MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c534237-d42f-4ddc-ecff-08ddeb13dce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PUwXCyZYO5lhoDhyJd1oI+u5FIfr9NbUd5onMsoDB78ZakmD4BsFSiCIeX4F?=
 =?us-ascii?Q?W3zNxxQYpEGXOAHlAEeml0gm6r9in5Qw/Jl0RKmayJ2JePpxgwcvtabDqqCO?=
 =?us-ascii?Q?8evYlbRn8YOP/3viFaA+fFyFeze5T8gVYeERz2yqBuOTzfZt+f+GpJYLVLSl?=
 =?us-ascii?Q?8vJwyaQvRMNbFmrAq42CuKa9WPeVNmRJOSntW9hfOX8svYzt/Rp4WedearCW?=
 =?us-ascii?Q?86eyG5bj0g7klVJaFQoJINAKsQAPvkKKkC3jSKs9OGo/6QEIV41zn0pM1dec?=
 =?us-ascii?Q?ja0u1CFiQyxeTUVg8y11Jyd0lFNuhEGoy/mTBkz6Xjm88EWnbJAjsgBHcHZP?=
 =?us-ascii?Q?BGRFtJjLT386aZOtaxWB71K7YSFWtEHGJMGGV35Sas51gHugyOxnzE1iiHHs?=
 =?us-ascii?Q?6Fwqro4Sg4xUINIVipj5xlx2NEuEeLFgopRSjzm5cg4gbAZnuQfB7LEtQwhH?=
 =?us-ascii?Q?sKRD+bMkQ9zvas7yXq5ZIztJDBQoWDS+uU1kqXeb+eKDwVNXpG9k5+O1wdRO?=
 =?us-ascii?Q?3Fl45AJiR/TcqwADgd+/hco+KZQS10bMKjp83/HSFyb1K0oBqP73Q0dxGTKx?=
 =?us-ascii?Q?/4b9LHzx1acnIN2yAbycF5sbB7amESJk28V+px9mjJXPAE0KtzPVicPr6S6g?=
 =?us-ascii?Q?JaqAvYIiQvz56j4dka3y6NHXxMqlG45YT5qbSrXkZUi5x2ClzNKIoZnO+XWW?=
 =?us-ascii?Q?i8U4wQzwR9P4HzSPVIjf6OtU0BkFI9UkkaWu2nn4guZvnhPqJNIPt5wG/erP?=
 =?us-ascii?Q?GYRflZvD41E+Cnh7Kl35AAvk56TV1RnjZkCB4B8pAAfqQM/wcNB2FQtbHmLF?=
 =?us-ascii?Q?Fi1fkp4W7hJdiiEyBiNGlKf49dpkGkV5qmo5y3mr3ZL9v7FiX988zYYjJ0GE?=
 =?us-ascii?Q?OAKv8jAIKY/2+rYWG6o8EsdVA1wttka4h3t4DGsvsKwx7+y5anVgJWVnV3zh?=
 =?us-ascii?Q?ie9TftgJQEuNnt6FDjamKkVVEE8DYHbi+Ldvf0Cmg74rFBpYT8sxrMR7qBcx?=
 =?us-ascii?Q?RQSOps072DHvs/Z5mQFleb7YJ/pXl8QTbJt1+WQA2uQ5BKHYiREqqDV6iSdP?=
 =?us-ascii?Q?2/cSV61XggH4v1ODCMFkhEq3BEIm6MivPjyKowCvAS7spdEgRiz6EfI/wL4t?=
 =?us-ascii?Q?bCcX+sy6K+QpGs9WtkjDMqBKbMKQ3mWxcKQKTtNLV6v9omz93CjZhL32uGyu?=
 =?us-ascii?Q?OC6wGnZrYKW/UFThsBEW6nRwruoWvF/bTKvwiNDIVrUkrbfN+O5GRA1l0hoc?=
 =?us-ascii?Q?3H6fSIiIUsp2tWLRomOlz0oVx4+1eoZGdcX5pTwAnHR+ByMg9Yj5oT768Y6f?=
 =?us-ascii?Q?WImxmReXeJqFh9j+EIYQYV/QGZeY5fthkkugTySCZ/czRTZRSpsbsEGHNskS?=
 =?us-ascii?Q?31itAHSI1odYqxP8IunK3HmVKiWzrY/P/k3EMI6j0IxP7cASsK4IS+DigZLB?=
 =?us-ascii?Q?Pf49rQA8vLU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oK2AOXobljo1FrkyqXwMRN4iAq7hcXafJALN7Sp4vdj3QidlRTtSFD4zi6yP?=
 =?us-ascii?Q?RC0ra4ba0gnTKSdbI5mM0ux3vfc6rdHasvBnMT6HgOjZJZU5UlR3Icudvl6r?=
 =?us-ascii?Q?LmjWPS0JYZdTe8kcHrW276OoyBS4rf0ghV5AN756tMSrW1PqcFGEApV1bUHr?=
 =?us-ascii?Q?OXfqDIo/PjwWnRSzonvySSUe5EELQzpR/tr1mcoeReNVRwpwNFscxjef45T1?=
 =?us-ascii?Q?aXDcdutvtFOb00xKeXmlcEyXggwjoJfkH4V2U+iG688QGvsmuDTmax1NjWxl?=
 =?us-ascii?Q?xjKkRv+nrrjTR6bhloMcfi/Zhpw9kV9PlWQ16lUXZ4uEi4MPT9ddPbGHJmb+?=
 =?us-ascii?Q?ZVjO2Sd6LylS5uy5nivK1C8K6BgtTCNPpjJBakMVJgKm3fL5EDr1Abihqi8a?=
 =?us-ascii?Q?ApU60ERlAOOmPGTsIzRYXswcAQq0wLyvut1n+oTH3Y/MW2MP7ACMduciQ1YN?=
 =?us-ascii?Q?/1oPAueWpZ2YhItIr4n40hemhFTQhjZx7jmiMEIfH/dC875vLvdk7ELDZIE1?=
 =?us-ascii?Q?AJesT+AcA99J2jmKvMXBY7H8qoGnnmfqM6AOrsC82DXdfhfl8dRMgCo7KXps?=
 =?us-ascii?Q?SzfrsT2xa6K/8LkoUzssf43ga+K9NwSwLtnVqUzXEbafSrCB0jkF/DqAMh4e?=
 =?us-ascii?Q?rjUDg/pkFeb3Uu9JLk5vKd2gA2eoS08V6wAXONg87BgcxdMJr5rbUaDaXn/U?=
 =?us-ascii?Q?TMpAM3JH7eiOOQQEls4MAkBaRrgCiFid5NyG33hlLv5RvRTr1lpo4Yae+JEo?=
 =?us-ascii?Q?CqHAqUY1oL571aBiZkPEaIYCE7KrLPg5YbDlG+h7zMt5NGe4Z8oYe//P3/XK?=
 =?us-ascii?Q?CgwOsYuTc1sT/hgXmEd2QMrHap3yT42NYDkZKtTS2vYM6qEP0e3L1fJ6uV8O?=
 =?us-ascii?Q?TVrAj10xChW024JqalYOk42+EChTu4OCxZxtC5ONw3VasKQw5ENTaMxaH/ae?=
 =?us-ascii?Q?wxpGzNsH9HzOsAMAoENN5uopZBP/wSLv3ex2gSxKG4wUKQ2WCDJ/1zY/UhbA?=
 =?us-ascii?Q?Jn/iS9xbuuPCdkmLVM7Z5jETNYpJ29KmYbtDl0ek6DOKD5WhGQx8GwnI2mLU?=
 =?us-ascii?Q?UKsw3QQHY5gbLl/q+WS+n3L+kvS27urU1rYqydMhYkhCX7u/8lte50YpT12H?=
 =?us-ascii?Q?Oarp5RyPlqXKy276AgMf/3DwWKpbeExk34GtVcaCZyKAxGrGZ2O20HtGTggu?=
 =?us-ascii?Q?SfKgIjYVm+fn11+mOz+iUQV7OXos4BYTfSnQ3zkq6bLIpP5DPeCN3TDox7+C?=
 =?us-ascii?Q?JQHzV98CxjUPATWwU0LFX13wLfF+fUAH7/3sRMjjMY9cubeHv7jz5bxfwf05?=
 =?us-ascii?Q?2NI3eg0B+frHfQJiOQv5qrKc7O8uR91zMHxq4E4M6KNbydd+o5hgvF9UvqJ+?=
 =?us-ascii?Q?2hCWPNMY2gUm+/Zk3rjlBgn+xEtXsahpqS1ASdH3ouD8d/EdlTU/4U8iya3v?=
 =?us-ascii?Q?xOUYVnC9EbSFE+j4noJPcmDXKDMVfWOiZ4n5hPRNr+UoATZYsY9Ec1mg3+nt?=
 =?us-ascii?Q?DlYhLlfhEfvlKtagoTsHLySWTxOP1Li7P8WvtiP2SJomOfqN4ak9Ir+D4kCb?=
 =?us-ascii?Q?6bwYYxpf02f3weGyyoyoFRk+A9Mj/1A39O3ekSLv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ypy9sUZZD7qECU13X1t8eou47CfVlF0SfzZUep2gGp/YwmiwOlgrl6M1YvN/n2/ScKp5dXviOrEWzeyCWuSMGBRnSPRRRi1SiCeVlvcDkZvYeReM6Vv8f/bquQDlSAzmBNz/PB3EanSqglgUYHMpBbOjEJF66G0+spMnjkbb35ZzCFXtY0yR90eyK5AdxhguuCemdPnOk8ZgkZLGOyqFvRSRoxMLkC0LJc5iLkJ8iCLyzgnEl5qg7eske/ySPy7GVkSP7MabrEvU+Q2Npe+2WTwokcSnY76SrNDn6Fi3KKp9d989oa7VTTLvY3zs9mneEt+V5FKN3HrvrcJ5AnwoapksLXJPDBEOTAc4NnqAqosI7N6Hz68r1TXoeZzU6aKGcbNOSQgXHSX4etGj422DOMTwnDkBQghZOv7GDq4q0H7K9nok7z9djUyhTgKGFFo6yxpJWp7ppWUXxyzBFY48/YepmW1JQmrjgLqA5f+LtYSTWjbB69IQhlCiwGNj3Hm16LI2nxX/ES8RSt+sYpGFwDi/SVFFYZH9yXX22J8roKco3bLWNBIAiqnUR8IBPOYeh4xE5yweQv+ze3ikjpryN1vTPmfzG/dJzAJjOkCl/YE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c534237-d42f-4ddc-ecff-08ddeb13dce4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 18:01:10.1904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8yHWW64fE4DQmt4Icb7Uou4ZuoVV5A6G0I90kkmy9BhG8u8LSGQsAuvLES9DohJsgiAFZgHoUAKV7YOu7j48vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4391
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_09,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509030180
X-Proofpoint-ORIG-GUID: 5o09TRNqLjtmIbso5rP_Sk4R2L5ZwoRK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDE3MiBTYWx0ZWRfX7yuAXuwJUFij
 zVXCTuhfNDCzU+0BvzrB4lyQwXQjB4YbIHiaK3KzxejYeM1+eWZ+StFuKccegqIiM0LmVIwHUMj
 h84h4Do1Uy49UIydF/kfL/v/A9CAcS56KgeAduSIRQXGyeOGHqZHs1O5gqFDyBeF1ic6X1PJ73S
 ge7rJCKxpkFkC78fxCELsgc2DLOZw31bG2kkN5BhEvC9kbNsYUX5u4SxtlC7E9OysV1jdPhA3+r
 DSp2bfhsz8mCln5biQGSz0Y2My4N9i5oWzHtcx5tu+O4YaPIRf6rMdA1nzZicnt9neMWQ/+2P9F
 x0xwvFvDwFxREIB8Lkd7CWfyOvuvPayTWuPd1IX8QryhQ2+aIUWe89XUy5jrNhfr0lenctbcOs6
 iDKppdwswqpZTBEFBQFDcQsmDS8aOg==
X-Proofpoint-GUID: 5o09TRNqLjtmIbso5rP_Sk4R2L5ZwoRK
X-Authority-Analysis: v=2.4 cv=V5Z90fni c=1 sm=1 tr=0 ts=68b88269 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=yPCof4ZbAAAA:8 a=qxUsu1MzZj1EZAismqIA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:13602

* Alice Ryhl <aliceryhl@google.com> [250902 04:36]:
> Having the ma_external_lock field exist when CONFIG_LOCKDEP=n isn't used
> anywhere, so just get rid of it. This also avoids generating a typedef
> called lockdep_map_p that could overlap with typedefs in other header
> files.
> 
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

If it helps you then let's do it this way.  I don't think there's much
risk leaving it the way it is, but there's not much risk changing it
either.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
> Originally sent as
> https://lore.kernel.org/all/20250819-maple-tree-v2-1-229b48657bab@google.com/
> 
> But I'm moving it out of that series as it did not have the intended
> effect on the Rust bindgen output. However, I still think it makes sense
> as a pure cleanup patch.
> ---
>  include/linux/maple_tree.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index bafe143b1f783202e27b32567fffee4149e8e266..8244679ba1758235e049acbaedee62aae5c0e226 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -194,7 +194,6 @@ enum store_type {
>  #define MAPLE_RESERVED_RANGE	4096
>  
>  #ifdef CONFIG_LOCKDEP
> -typedef struct lockdep_map *lockdep_map_p;
>  #define mt_lock_is_held(mt)                                             \
>  	(!(mt)->ma_external_lock || lock_is_held((mt)->ma_external_lock))
>  
> @@ -207,7 +206,6 @@ typedef struct lockdep_map *lockdep_map_p;
>  
>  #define mt_on_stack(mt)			(mt).ma_external_lock = NULL
>  #else
> -typedef struct { /* nothing */ } lockdep_map_p;
>  #define mt_lock_is_held(mt)		1
>  #define mt_write_lock_is_held(mt)	1
>  #define mt_set_external_lock(mt, lock)	do { } while (0)
> @@ -230,8 +228,10 @@ typedef struct { /* nothing */ } lockdep_map_p;
>   */
>  struct maple_tree {
>  	union {
> -		spinlock_t	ma_lock;
> -		lockdep_map_p	ma_external_lock;
> +		spinlock_t		ma_lock;
> +#ifdef CONFIG_LOCKDEP
> +		struct lockdep_map	*ma_external_lock;
> +#endif
>  	};
>  	unsigned int	ma_flags;
>  	void __rcu      *ma_root;
> 
> ---
> base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
> change-id: 20250902-maple-lockdep-p-a930e865c76b
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 

