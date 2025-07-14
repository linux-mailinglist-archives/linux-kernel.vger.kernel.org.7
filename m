Return-Path: <linux-kernel+bounces-730421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574ADB04441
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D9087B5B52
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A23AD2C;
	Mon, 14 Jul 2025 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q8Mn65nj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TIDI1Dy5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED957262FFC
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507269; cv=fail; b=oGcwvzd5SYjGQvn5dnhkZ128yoe6hhz8wGDDMea8SAYf8xPC263kcoDlpZmmg8nmUWQHNxzfX8MDy89Vy1Df2LePt0N4t7uPanohd1R8ESITK+l3lABxXbMZD+0GsJr47TtuTkXFPt7Kfsx7No/9g0BcckeCXw1plp3AFvUNiEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507269; c=relaxed/simple;
	bh=h2Flm/GbZiOV46iyBlxA9FRZ/tmXKnXoFnbjjTAhpzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gtLEKy2+OFx0zxSGE+6EqwKYIg4gm+di3NMBcDkuxRAcQzzG6q8F17kyvidmssnh/IzEB1zkxKgQlmvIhGiInTY0dfweEHtHY6DZVHW4ECAu4l8O4J+Abt8KuzZ7VFcsviqBbFh3cmpgFZxvkmjLoeKQ2qXV29kNETFdjrAKSUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=q8Mn65nj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TIDI1Dy5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z5NJ031165;
	Mon, 14 Jul 2025 15:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vglWeqIIMU0ALs56OI
	sbv/XbrMw4FL1sm4JMQUjzqfo=; b=q8Mn65njOGzIUoWnuYNtaI+2Dp7wVXOH6e
	9nBTY36SiTKh/K9o3cbTqfKRz1Axe8yD8Fo5amvdyLwZ+Vi4B9SVi0+nnhJcDvtm
	lOICEEJf4t7aq1Dxn4txZgwfQQlJFCfjqLHjfbjwjuWNhbDN7DKNTSAeOBCBo911
	Gx2BQpljsuARcNltgy4XRayZiX+/N7v5jPoW2Jrl0tCHNkfydlMjP3gKNYutjTph
	G01tF8Q4nPQT55dZ/1YlMRCfnWnx6gVJBWGMi9WyY0iQZK2+KWAtGcIMIz8Qhjts
	6dETTU0KK7XM0apIM8lupgGh4i3ffLh/03GaiR4FyP7qzO5J0hAQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr0vf12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:34:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EFJedc013567;
	Mon, 14 Jul 2025 15:34:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue585tfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:34:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X14lDj6MH2ozVFV1R+vziCKzFjGzqSL5+jDF/p60UNKTL8d+dNWBQZXR5tyKK31nqkW1a7Sq7szF6NUIOOF19Huz8kw0cSVLTxDMe2o43cSAs5hX+cKfBnqPdCkbRFypXXiiB+IqNy5NDmcNmlCH1jia+G69XFb6Kpz84dxdhozyQi5uBrsMofaKqjCqyS81ZqZDXquloP/FQfcx4UV5uPLeBviqDAaJpcGZ+d5wxgodVp0xFINHvEdu/MVaj3GEaazKXmW6w37Mm2fyiwbgM6sF5/LbE05t/XILo9LGT/qYxHeT6N/UAg4ENX5XAuQNYHzU3S8G9I0ECLW+eInmgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vglWeqIIMU0ALs56OIsbv/XbrMw4FL1sm4JMQUjzqfo=;
 b=hRXXOGK+OE9xCgTuDGcQVl4jSQlYF1JskdL4yy/ZQpRNIognDwxksxT79AY1S6bwN2HWpYG7YU5ILOwiFtP9I10WS5ClOXFYkM76UDUzRDFQrPyAXhxyvZSLXHxW9dHyEyQ9n3U3KjgxPs52BEDoycLJK+ypnB+rR84yFwphPNHczSOQNeu50iUxjWFcrK35+otNRZEV8uH03EOQ+wEwJReummqCLnddP48bcglG2gMXeVfDflHBt5KkjeHwiIeXakqgkihgSZuaL0X0lwJE/0geRdiheDR1isD7ljahL90K45jEptNrpGn2QA8MRoIudV7Fuu6/PBtXWS8yHuuoCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vglWeqIIMU0ALs56OIsbv/XbrMw4FL1sm4JMQUjzqfo=;
 b=TIDI1Dy5lBOpivej/JjgdJ6PywJUbftf9bFY+z99AX25PGDChXxOd4gOPH7zHhfbLWe3CKGUtVhp0Zj+ALDpdQ7pLOXoALrlTYMl58UHEjkS4ym3P8vcatt5AGy0CkiKR/MEvzBk3dZJz5XR7hl/GvizccWnaFM7tl01YVPt89o=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 15:34:02 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Mon, 14 Jul 2025
 15:34:02 +0000
Date: Mon, 14 Jul 2025 11:33:59 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH 3/5] mm/mseal: small cleanups
Message-ID: <o2c423ag46jlnyw743s6fyuy5xwpf7mlrmgngcl6wsgwqosvlm@qxqsp7mabp7s>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Jeff Xu <jeffxu@chromium.org>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <4df6b55c407b5e6890429d4d7cc39e8f28948975.1752497324.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4df6b55c407b5e6890429d4d7cc39e8f28948975.1752497324.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0463.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::14) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH0PR10MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5d5020-e754-40a0-4a53-08ddc2ebdc4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qRVD+/BQtTiUuXqxTFO3Vj0FZD+1pNwQmBlxGvEYZGosFmbm5h2iSOYQ5NtM?=
 =?us-ascii?Q?KjeSZPA9p4Syb65gLo8Aa/QVh9tI4nRQpXfb3BB1Jx5gVaRLqYBgnU1EzfR4?=
 =?us-ascii?Q?ADVWnv+TcQhGgfmnIkW0hh8VEUqUTV8g4WvPRPVj+CZ9+2CpWi+diLJXyz/b?=
 =?us-ascii?Q?NArvsBE4L03fSL1JtFnLjMmcdW1+v7W8STEPgGP3d/VjgBCRtUKBFnCVJJwB?=
 =?us-ascii?Q?wadGkGdA8qffM/ZsIqFayWWUzk/w7iGCJJwaTQYBDREFOmGlD20fdfRnyI4j?=
 =?us-ascii?Q?bTL1wEkecFQmTi1X+L8ER8xxPQpUEIc/K4cGYbd+MmRQWH/PwL/+TCPbJ4eG?=
 =?us-ascii?Q?kJzff6u7cTT8mUptnOJ/xTEujYamXnKqY4V1oqY63JJU8wtfOzldAn1B9nPc?=
 =?us-ascii?Q?ivbbBtx+jThhUz9uZYpH49x3et/nzr3s9/W9NabGbX9oKxGddcHXx3Kk/A89?=
 =?us-ascii?Q?yaiiYtpNcCZsznPSOlH2f7DtRZHBaF8SZmgqTwgRzqlWYo+79CHPRA+eQOAm?=
 =?us-ascii?Q?noAhOCOb05cyiAVDTa4C+3BTliULUdBnyM/KWWDQhQ9VVWCYHFR0HOvcLqSl?=
 =?us-ascii?Q?VDFgE+X43qCEy9AOZhZV9ZPPHlJ9h2XbUh7WScvYWfJrtxC2GAu4OYH8BcGW?=
 =?us-ascii?Q?vTsnaqn0kTL0k5e33SI/yvAZXWpojYZRSHn7jNfBtaVCIotQj0gEnV2Np8RF?=
 =?us-ascii?Q?q1L8O4fnYZdT/a+kyn88nZxDzbuVZS7a6JhxhgFjpncSq0sbvP6I2nmmkjOA?=
 =?us-ascii?Q?TJMK8PR/LVea/kg9XTL5pBMVzp9J+CPNWnj7cve6RaFP8ab4wfsLokPGTjmk?=
 =?us-ascii?Q?jsfz9BqPC7nBtwtd2vyk7md9UY+QeFanENzF9b3ruUN6tHU1xC3qWvyOKZbj?=
 =?us-ascii?Q?oOq+kz33VPYygTLt17CibogU/9qUe0TyaoEUHeraz0P7tX1rngsaDE+A4DV2?=
 =?us-ascii?Q?Dgc5qklgI15aLZedyUAXLlzx9sfhlkNJz+1ah14SzUQEMp4qiw8qTakeA7yI?=
 =?us-ascii?Q?h4xS5Qt/CWx0IhvL+NUPS4XjUNcLZWbm4TcNJaiz6u4jqx+5xGnni55Ipxyu?=
 =?us-ascii?Q?RH3z/n4VDjLOc8yzfAIfamOd1AOPduvtW9iYuoooNT4W+EhDOf/PCPRZVFw8?=
 =?us-ascii?Q?YjPp64Q6vfNtL9pYMQp1tj2d8/jCIlbxsuvVJz2DutnxZx/g4mSsaViHcB3q?=
 =?us-ascii?Q?D69VIUAp5FiWj9VCsPOzA5UwjZr8TdKuA7yhK9Wds7BEMXMgVXW/3BMit2k+?=
 =?us-ascii?Q?NYOmY3z7k7uWUE46LQsnKt6zZidsXIuOc9qYMsy8zKtppLsxO7IKIGik8nmQ?=
 =?us-ascii?Q?w36bK6jAflm82U1wVPfEnCMfps4/Naj+Wv1qwp30sI/PAOm1lom5QJnQLkjq?=
 =?us-ascii?Q?oD4DYx2VRrlVNHT9AbqNx2zekIniJFhU+IQWWziM5DliKhjaD0Xd/zatHfZd?=
 =?us-ascii?Q?gkaIlndMjl4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UDAreFjZecDFkx4T79Z4AbaQkYy7nAqK2I9KsxPr9WNJcnjsK/8s8nJUUyqz?=
 =?us-ascii?Q?HkKvvNvkAwVpWfMttEK0bAM9u1ZTifOwG7VA0jeuoDitDdnA4N6YdBu7xr2a?=
 =?us-ascii?Q?D3Ke4GEDlaWmEZ0FmmT6eg0du2M0NO8itNoXZ1Z4oRuwpNgUFd9OrFyLzZ6O?=
 =?us-ascii?Q?XTIKXhhwgTUMB2OcmCjiFbHpclhee2IqXPddxT/rtGaFBIvThDqMHf7C1LKf?=
 =?us-ascii?Q?a2PLdYfVKQncWmWk8HXTF5GiBfUeq8Rw3CED0T/wnYhlUTaeoLo4ADzij7br?=
 =?us-ascii?Q?VxgtBItPux65gv0WeoypnQ/Y049nuvMfqXeLg5DRU1dRFI+pM6ZvUE5SylG6?=
 =?us-ascii?Q?f/OlMREfoVLX8u14manBtxBTl9eYAOyMAhXccLLEK2hpT5K0jTA2x0DbY8wr?=
 =?us-ascii?Q?WFvWX8ZpCrIn/EAFsBw/2rqK3d1doky/U6GASXbPWLe8MqTFhFCNJ54mJtae?=
 =?us-ascii?Q?MA3kPvKoQPj3noTbtmlEBMBGeTaseDx63HIJtv5VaHw2recS0CxL/J1rWtrG?=
 =?us-ascii?Q?ZXuBmwm7JMMPfuUxzDAl0F25a1Ysqgq8GGFSFCo3K+rzOhr2MAbneBU51bP6?=
 =?us-ascii?Q?CI96/6zet+alQq6v+Afsfeb35LbI9HYEt64lus3YPDzx2HlY0z1/QsZteVe+?=
 =?us-ascii?Q?0uf8+X9leXafehJuIppwIRpMxNXXCXAj/Gz1dKKRsohKQvUhy+ay2Xvqy0o7?=
 =?us-ascii?Q?Xukjg8A1t2m8OZty7/wz0v1Hav9V1jCQJwheb84Ve7kHCRx57LyUf6+ApK4s?=
 =?us-ascii?Q?hyM/29Jl577X7DvRxIqwsXqtunmy1Fdwf51JI3XjCd8hA9ykXBpGFnwLgj/s?=
 =?us-ascii?Q?b4VKyCOUoTxz2zz+fCkIILLzhso/6KeI3E35df8PL1LWWAYYb6nE7/wlFH3J?=
 =?us-ascii?Q?f40cv0wtBdL2Sb9I5POJYU6rhhxmgmre4sruj4df6U2Oq7EAlLroed42Oq1P?=
 =?us-ascii?Q?T2Lpk0TwkhYUj2dg5uIdotijrixot3PYD6B4tXlTgN6L+fwgXG/+zHCjUliH?=
 =?us-ascii?Q?meAZZxj1QsoR6vZky4NLghy76NRSXyr+pX5G5ULhDzEKMOztvUoaHemzpg0o?=
 =?us-ascii?Q?G9mUSzEow1gFxB2qqSFzzLKvSm66igv52nA5ZwOiBbUBVkWCENzZXceSkQS0?=
 =?us-ascii?Q?7jWL08pRDBtbr5nQeHBDfAGL7KNOiwYu8ifpy0C2pRTgU37iYkb6xsxN1E8N?=
 =?us-ascii?Q?+eaAuKqQVYSEjkXSMzO4Q0NR8slr2mCxyg4lBtVNK2IxhS3RsoVNHvyE/oL+?=
 =?us-ascii?Q?MvXWQl5Yh4iX0uwsy2556tOUeJ0ASARz9qhaiZ8/MXkZ44b0t/fVqiVYqbnw?=
 =?us-ascii?Q?g7uFZxZBwOcfIz1mOd5K0NvJCErfMLURo1YV3HJIH/39iY6j+QexP7SaOHVT?=
 =?us-ascii?Q?WELVslmTjvXUmKsSP6rFe68++HGk8Y+hvT0Rbg52ZPCTC0pWe/nkv77mJIL1?=
 =?us-ascii?Q?qDYmsqo/IsjqArsFUGwDFsNR90yY2s/eIkoiTsRAZQKgLssIB5YLY14v68yO?=
 =?us-ascii?Q?8XBugV1tam8KUn8g7kSZmT5o+GMTFKit8QM+gPHQ1nESxXOaKVaqdyQk2L6X?=
 =?us-ascii?Q?L2sTNhOuTLV7wNkMUF3rCCb93e3TAHSEIHlfOisA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D38wqFmicFkcU0PQbHjMWC8J6JsC+XTDJqBBCH0OX07ViuECDon8heO+iynRMCvKh78BH8qWvLACELpnF8Gq0dlMRgIOadqJfCIZuGDlETkkboJ8+rwA/6gnXt7qc/Tga98kyXw4hsIvCkRUD32IX0bGj14qdv+eXSAjzRpnglGYTK2mfB2SBDi8i07T4Z/new2wLJjYI3UiiOL4I7UCGEg3nRw7czrCBIgG5WDxtJ+kHsoy3mcuLJOZDdzreKzHDI7VFty1HWJhb+NKEPyoOACZzEoavQ/p74vqIk5puyFerIbbn0RcWT8TIQuGiUKl9S3I8qWSLL8B2mbbaXSH8hA4pAVxlo0ZGxJ8UI8eCA/0BVKGJID+aTc/1y9Izkaxu0l+5nxjt878bw7vc5gFbI4wijq5fOJaXTwqvBGYKUYlHP1V4mj7XXf/hZKFuS8lpq5vVJe4VuhfiSJpE7bYRfQnulHZNQvJFPak0SqUjKuzORcmDwyrVNLz2s9rlCd0NyqnJR13nSe6WMPKJ+isfGMLR00/1qs/ZKZVVE0SkJmCrjJSGLwN85LJuWExTFp0H9Su8XAk1CcKymcl39hEo/tKJj0Khr57PrlegUohxLc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5d5020-e754-40a0-4a53-08ddc2ebdc4f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:34:02.6824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYl2Irenqoy6W7k8CenI1/MduVIBCuu26OhsFRV8uamoqnMY3gHZk3WHjRyaqfjlVNRRwB+jTHMZMwFtqHUrHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140093
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=68752378 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=wI1VyRsccWRmCbpcl6QA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12061
X-Proofpoint-ORIG-GUID: c0CosyKfUaS0GoAhmbo0HY-G8a6e1Lxw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5MyBTYWx0ZWRfX6HNk2VofGa2G VQeTHd45XjnBsgVe3Rvn81spmo6m/qoQaYC66kchijSeBs6IWSH/+hQ7e7pc4n11pLXp+Yrpw6y 1lLFBNdFBPY9/XKQpa4obTYLHQ4+ttXI/FJBW4Q2ngWSJNrI5tOXckHz0cN/LJEVEfHoxLHkJgL
 gL8OCIVHvBMuHzFfD8/FbRLQuUFU488FYPGjuTTTMXfv4plF2SlKGJcDAMyPd51XSdNJiTmKQf6 guUXR0Kv+fdgAHNI3ixI6WALehn+7KAp7lUIHPU+bQCbQwWI3OjwxGK8szNAvR2IqAxnH0nJac/ h6ZjKL1HAmXsh4XkSd6B59oygOwfjOxHL+gHKftkMcPtDo+Hkcnd0jtsAgkh2G7OGwEmIr2FC2M
 ppuo4bf0FnO1vk09jWkICYnoanNuhzrCtT/np8hMTPorvsTsgnK+BCp/0kEt9eUhoyC3LhRe
X-Proofpoint-GUID: c0CosyKfUaS0GoAhmbo0HY-G8a6e1Lxw

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250714 09:08]:
> Drop the wholly unnecessary set_vma_sealed() and vma_is_sealed() helpers
> which are used only once, and place VMA_ITERATOR() declarations in the
> correct place.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/mseal.c |  9 +--------
>  mm/vma.h   | 16 ++--------------
>  2 files changed, 3 insertions(+), 22 deletions(-)
> 
> diff --git a/mm/mseal.c b/mm/mseal.c
> index 1308e88ab184..adbcc65e9660 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -15,11 +15,6 @@
>  #include <linux/sched.h>
>  #include "internal.h"
> 
> -static inline void set_vma_sealed(struct vm_area_struct *vma)
> -{
> -	vm_flags_set(vma, VM_SEALED);
> -}
> -
>  static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		struct vm_area_struct **prev, unsigned long start,
>  		unsigned long end, vm_flags_t newflags)
> @@ -36,7 +31,7 @@ static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		goto out;
>  	}
> 
> -	set_vma_sealed(vma);
> +	vm_flags_set(vma, VM_SEALED);
>  out:
>  	*prev = vma;
>  	return ret;
> @@ -53,7 +48,6 @@ static int check_mm_seal(unsigned long start, unsigned long end)
>  {
>  	struct vm_area_struct *vma;
>  	unsigned long nstart = start;
> -
>  	VMA_ITERATOR(vmi, current->mm, start);
> 
>  	/* going through each vma to check. */
> @@ -78,7 +72,6 @@ static int apply_mm_seal(unsigned long start, unsigned long end)
>  {
>  	unsigned long nstart;
>  	struct vm_area_struct *vma, *prev;
> -
>  	VMA_ITERATOR(vmi, current->mm, start);
> 
>  	vma = vma_iter_load(&vmi);
> diff --git a/mm/vma.h b/mm/vma.h
> index 6515045ba342..d17f560cf53d 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -560,31 +560,19 @@ struct vm_area_struct *vma_iter_next_rewind(struct vma_iterator *vmi,
>  }
> 
>  #ifdef CONFIG_64BIT
> -
> -static inline bool vma_is_sealed(struct vm_area_struct *vma)
> -{
> -	return (vma->vm_flags & VM_SEALED);
> -}
> -
> -/*
> - * check if a vma is sealed for modification.
> - * return true, if modification is allowed.
> - */
> +/* Check if a vma is sealed for modification. */
>  static inline bool can_modify_vma(struct vm_area_struct *vma)
>  {
> -	if (unlikely(vma_is_sealed(vma)))
> +	if (unlikely(vma->vm_flags & VM_SEALED))
>  		return false;
> 
>  	return true;
>  }
> -
>  #else
> -
>  static inline bool can_modify_vma(struct vm_area_struct *vma)
>  {
>  	return true;
>  }
> -
>  #endif
> 
>  #if defined(CONFIG_STACK_GROWSUP)
> --
> 2.50.1

