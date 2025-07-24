Return-Path: <linux-kernel+bounces-744720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BFBB11042
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA991CE1E27
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01063298249;
	Thu, 24 Jul 2025 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lZlxwqAu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A9Fdc/aI"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093207494
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753377454; cv=fail; b=ATV5BE05AzNISBuoc5tZ+mxPJjqEeI+6cb1muW1eGQLPrg2qly5NJnErysdT0yIpxmorDJND5ztQT8CfaPUsk2bs5UXUXQu6lSU/Z9+kAFv3+l4wfhl00o6MEAcey4hWN9gKdi3zSmUUFXmG6lnosIyD87S7tSK3a23AX9c+9nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753377454; c=relaxed/simple;
	bh=jJlijjfOF5Uv4aPoeWLP7oBPoPRv7bk3n61SZqKKb/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oMx/4h4ap+GyxOwncERr3eBooGyZ/m0I4Qo5q+kw9Bp6zwOxt6a8v98PArDEqwyqMprqrUMXZOj0jsm7sYJ9tkYHA7l0JGUsD+m8qSl99Ll8zPgKteSRm05Exj8C4f0iDYBAEzjELpSvCKhBHGQYRujQ+CsI0vKbTMdfOasT3Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lZlxwqAu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A9Fdc/aI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OGiqVZ000437;
	Thu, 24 Jul 2025 17:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=n9RReGLhY8HQy+Jlps
	LOeNJho9rEydEvGDsS/1qPU+s=; b=lZlxwqAu8jeafoVmJkNPpiTGsoahZCgnRC
	XCoaLHmJ7rnI/IPyhzCG7S8xJy56tm6E1EYVgQw+BTdlZVT+wAk23YUi7jN4ujwY
	K2TLR+7WhNKvQUNgtjX/WTzNGK285of4flGT3Ax6NbGBMOlp7jwzz8oWYEEsDrOr
	tw6INV8NMUlqGaGOus6lh++V/AxivguVA//a4N0EtcdjSIe3m6V6OkDiXr9FAJ1b
	0nhu6hwnbcddihjVf13WbOnOIGOMSGtwrsfQRrB/zzLN4Wd0UIIz0ikD/atJ5nYS
	qQtnHGcga42O5rUWND+jftvmk7pCQzFgtDYGYfE+N9CT9kvL4u0g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e2j1va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 17:17:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56OGdrtX006154;
	Thu, 24 Jul 2025 17:17:15 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013007.outbound.protection.outlook.com [40.93.196.7])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801tc42mj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 17:17:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WAnrqJXyfCrtsehyynTcup96bydADD/20G2e1W/gF5i7S805KqO/v7Wv5g+U6HP+pW1e81ihuM27ZSf+CZ5x20ZQp1plSmbqxikobiyNCfcWEMwzNALsFLDu7xGG4hWooZ6yifSbIDNNzdxXBafbbeEr3HV+v8N+VECmpSFRWaPEP7TAIYu2xd9kQ73sggsRcNPX8aEgIyw58zTw1mkNAdqGKjsI+o3QnxXUBLPMLLdW+Vfcl6fz+8mvYZQg1uMElOr+ZCfrWgcmAd+w+l8u2kp1kjjjoeTj9a2y1sJoH+LJOiUQ2McA7EoQiKow78HtSdq5TjK4aOGzLYzdJEPcCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9RReGLhY8HQy+JlpsLOeNJho9rEydEvGDsS/1qPU+s=;
 b=iZoAj0GGQSWj+O+U7xctp5A61/jJIds/v1ob5wLwqDT8YN9bUHX0+mnWPFjviYn/333uJhAJbRCfmkPokAr6q0Ra+IMei+Z0PmKcz5RVo+Py3IqI8qUiGO7lTpHhaeenESEyg1dIArZmaU4jpqPUl8TLw7LFgu9/g/ujPv0Dh51xAhkWjy98zc43Pfu8iAZa+NhF9JNU3qFdxnjF51csObxrtLg1c89KSeysDCEiueE1ZHf84l3HQlm1TE9bD57/X+comv9aJoZyTwTAXjl2IexfWfmbBBXP4fdH0IWw5dsTUGabZOSjIouEuPaRCyh42Mj/vEoYCtojpPNE94g68g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9RReGLhY8HQy+JlpsLOeNJho9rEydEvGDsS/1qPU+s=;
 b=A9Fdc/aIDbwDfspEubfc0/q8i6pTyd3nvkK8vjtGFXkuh3BvpSbUbOUadbF2m9M1ZWpH2oF2C7HLOVjl0X1z5sAfm2/LdrqJvXGJeP9YBYyFBlpHLDLuxxxvx6vtgerFhbQ5Fz+12nA3Itn7tSpfa/CUJuqLsI4TL+uVI2mzsC8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB7105.namprd10.prod.outlook.com (2603:10b6:510:27f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 17:17:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 17:17:07 +0000
Date: Thu, 24 Jul 2025 18:17:05 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] mm: add get_and_clear_ptes() and clear_ptes()
Message-ID: <4c998208-f3b4-4a6f-a99e-962541942f69@lucifer.local>
References: <20250724052301.23844-1-dev.jain@arm.com>
 <20250724052301.23844-2-dev.jain@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724052301.23844-2-dev.jain@arm.com>
X-ClientProxiedBy: LO3P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6b7224-6185-4c7a-7fab-08ddcad5eb05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AW3ZpB+sZJnO/owbGvTdA9KwruPN/yNx3JgHu4UtriGg7x/weRFP38n8aLrg?=
 =?us-ascii?Q?hJq9Xz/jVHHV9i5m4oYGsfNaMPQhM6Cz1Y0oPpfpjfuagvv0xpuGygCdbZ5x?=
 =?us-ascii?Q?f8Be0mJmXX82cbULXbqIyzYI+RSmXGVXJLlsdVIO/H/+vNlgK0OCZ6fbMfH3?=
 =?us-ascii?Q?Sz8XG/VaR3s2lzS4GPAiaxu53UVmh08tpK6+9FDQFub2blijMpMdt/pO2zdE?=
 =?us-ascii?Q?N1Yg3/6Z6pkBOW79A9GVH7Y3IOCjYkZpOAj++1MKPSDANjOLVijnpdyRnSgx?=
 =?us-ascii?Q?TmsjCNxnsaDT7t4GA3qYlfmL/SrrnA3iRAh5MUN9dqOO/wmLYBR5GzDK5OSM?=
 =?us-ascii?Q?kGUCByNUVRxk/YBYWWPXlJfZ/FCYdv+YchJFQD/O9hWiYz2mfUQYRLJM/cUU?=
 =?us-ascii?Q?7g7gY4t/eTOwZBtojgCBYm6behzFJ92xPQ0MgjP/53viVoRoyoRUt2ibRjlR?=
 =?us-ascii?Q?kZD3sFvU5dxaCICNeboj8p+a6JqjEPXnrm19ALpo9jTdkp24gpezOHNPuJKM?=
 =?us-ascii?Q?toXYrJKgcfv0sJvtzruPhn+0yYRyG9eA60BdVnZ7lSs/XhOZWIch1OrysacY?=
 =?us-ascii?Q?I9tjVFKpjuDuvoF9HGSS12oHyyL2V92/8UIu+rVv5bcdXACYCdgHHRYS41G5?=
 =?us-ascii?Q?zmRxgwNnHy+4hNS/DwHWh0/bcltv6pM8vRxHiMLF0U5d3B5lFMeLybFIwNOi?=
 =?us-ascii?Q?CsL12hdnWa669kWs7SOnawC0hpfsf/TLWwqc/z2UiH+DbS+Vnhf0ymnH9KzD?=
 =?us-ascii?Q?COupdsviJQHJvqpQLcrbYUEKlQDw0ipP8nADYymktVnwICnQTWATZsKuDWcX?=
 =?us-ascii?Q?Y5SVtYXVagdQtGhq1PK1Pt6YNXGyxf7sQVToSotr6+a5NzOSuT3h/iWuA8Bd?=
 =?us-ascii?Q?8nSHoYxcoA3KUVoCDkrghImoWlmrY5GD+b5+ryjMXWjPnFaSR/+YWUA2NKcY?=
 =?us-ascii?Q?WuDreKsxmQAWzqhAJS0IC/0BjAQnJRSKIJpAdpQd07u3Ib3CqkYWT99+YXPK?=
 =?us-ascii?Q?Hlqt+s8Yp3R734peTaiwOwchXcyDjBAibtAykIAHxHXezh3V/Bb1ubqqVOx+?=
 =?us-ascii?Q?FPQf8JIKbQj8GBZ3RdbThf9cxKrxURqOqa6MCDfDdj7OxE278WlrlNa8EUvN?=
 =?us-ascii?Q?iX7wmArhuxBAAc19CvN3H7mv1Vuw8WlozGnq2GaNbp3WtTBoJFrtpP8fKa1U?=
 =?us-ascii?Q?bqdJMwSQrj1UxHqxuv9MYrd5rqtOVlNWfyJvX55wiB+67k+GNCdwTH+R91Yo?=
 =?us-ascii?Q?OyJ6IRQgkdlFVR6wtvfmPSD/BODkv6XTd8G7DjGTphZvkIVEANJNKh0NubD1?=
 =?us-ascii?Q?Nygyn6/uL3qEvhcHMdMXN8GBYD6PdPyL+qEjlMan7erGnM8/95cwbcPYhz7f?=
 =?us-ascii?Q?lw14v0qdSSGSlKVI/qbeuyTYKvKl9lMkR6s8FOYkA4exUTzSvZI+Mv9yXQaJ?=
 =?us-ascii?Q?z/3583qo4RI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6rcwyQVVaBN44fXbtE0Q85k6Vemqr6qwtnNoWMnsC6uSRCKFzMr9w4/SWNL5?=
 =?us-ascii?Q?Yzk4I3+rVu53plCu4G4eyrQiWQTmK2JsCTPOT34CybGJ8NK7NlO/WvP+2qtV?=
 =?us-ascii?Q?yqwQD7A5CKlLNa54/O+PeIhLiQuV41KWKdjNimFP588QpJGlGqLXpwLpXLbd?=
 =?us-ascii?Q?tTwu0m6mjY0q2k9CQmireRm8gws3pckWb87bBonNY+37AwFIvf9LWiwMy8JS?=
 =?us-ascii?Q?2ZCHdNARhj+zMhupy86gnWcD2EOOj8R9gdTvYpoj1Id6PK6JUBFxUD7Vhels?=
 =?us-ascii?Q?utrCbJyHGBcHhV/BKhFb5c+1dQdSM2c88eQEu78Jgp0HEARA/X2TpRKA199p?=
 =?us-ascii?Q?w7+IV0+mrxdV5KVwMZtWZdLjz1+Lp9i2h6n2F+tN1yiL0DKjcWdwdyuU1/Nl?=
 =?us-ascii?Q?eLLuR3mXfRKLpOHQWGhsh/81wjV/FYM+OzY2Cbiy5PqY9uPyapEr0QUlPlqy?=
 =?us-ascii?Q?Ii+AhRk8zTAWXxjnz+fMZirBOmoDVM2W9q7i73FaAm7XNFNfIhyE15kwvzf7?=
 =?us-ascii?Q?HAghb8YnDZOlE9phOlvYJVEPLRQbv+ezY1C8gYETbxia/2FZbNjnrCBhCvIc?=
 =?us-ascii?Q?yafniBI8eM7eJ4BYwTeUCaQWzrwp+iUB7gHCBEGKHqwt8Iyw0LPtaJwdzSfh?=
 =?us-ascii?Q?ar2b+Z0EiKiGy7lOWyUlYecbWuUdQcQlO+7XDFoGkks/7QnI2JJ9NK7N+5MM?=
 =?us-ascii?Q?vj8EnMKbY3fkYERenV3pDrd9HF5jb9df/XsTLYBvHz1H8QKSqeli1lj2b1ZX?=
 =?us-ascii?Q?tW5sIshI/6FHlj8S/kOxIu6suOoUegeWlriIDzMIyA8NDoYCkeR9N3AFd6Tt?=
 =?us-ascii?Q?iHRf39dVIcCBRlJ60mBarlDCwDVAAmhz5vzrHA/4jEBzIVJJ5ShKBUl6/NAN?=
 =?us-ascii?Q?kRRGgv0gIRkOP3ehwj0Oh/CfQC/V2rmCvFwfDKUVtqRhszinCZK3ezAtaP+1?=
 =?us-ascii?Q?mB+4LyWmeRj7RFXmBeZPIEMxUc7kw1u1TbEnjfvQBQr2h/2q1mfvLD3IgLAy?=
 =?us-ascii?Q?D3ESOZGa/+KjHGq6pObAN5iqBRPew9Ejz/y9pzEQyrTiNprjIwBZQRW1rmeI?=
 =?us-ascii?Q?QG8cakUPwadzIpS7A80dwARmIphC2XAr6Ry+p/iovg9+7JHhghHmMmy/1x9j?=
 =?us-ascii?Q?CjQOakD0S0Q3u33exhL9pChABSJcaiHYcZVGsy/8EIyv/osoLGj8PYwmj96u?=
 =?us-ascii?Q?fendiGxjEdJMKXekLhv159RGbyDSuEZQ3EKlvsASvW/aW4fNAba623Z0wp2t?=
 =?us-ascii?Q?bVtn+P2Zynm9oBDgzH7URP7ANfQVTDnNvR8y9wzzMiZAY3JMRbi4AZNE6Ny+?=
 =?us-ascii?Q?nj3kXGHIrZCXJZaEG5mFv/inziGsy/pln9JQxw1QckoB3RFFsMTpMNXxUMDo?=
 =?us-ascii?Q?Ca4nUrh0qLrUtJcS5lHd6X6L/XcQBzUGFek02TAIyapsvW92CIgIbGB+duq0?=
 =?us-ascii?Q?ValpO2i7/21iP9aGYA0CgqIZkYU6bOzzbaFvtisYPNAb/rvnkyjuI72RVQE0?=
 =?us-ascii?Q?qBBMpIcvcV2E5tb5Q0uDab5VK4w+JYHNxDSE8Nds2ktk7uuuPzeGS6/dAUD4?=
 =?us-ascii?Q?uVUgDxTtwM7fDpiXznJFMWX88FtgZTJ+bb0Mfz8alvJpqHcCzV5xMzPYFwW/?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qhLMLeGVqumNl24xVmrrzfUIwAXpdSw3guAiTCAXklmgy2hXNFSlV8coiUwvENQrz4ioX5Q0Qlu3tmIoLClMXDZnmCYfmk/U4palaDu+IAD20q7x3V3ARBunckt92FnQFad9QCmbtDs4K+kapy4o1o6Gdyi+bYAuYVnpz+4AHHiAyesL1vJtvBog+RrttyU17KxutAhshAuqexJGyFJOImgMB//oasR4t8674IP28fawncPy90PZwihnVJCTuFM4/BMu5x41dXvJdOqTg6rl/8gC1xKTcPGcZfs6wISDtSLrLxHTZ21Ul9N6Xu2aNA8anhDkWgU97IOPOwY++RzP/sxfXDq1tiu/pXrGnXumuHQvjj3avVEy78xRP2Z/Es6nTxghMhaiswIctOBZFCIhgBriBJx+i9JMTz2a3nh+KuP8AUqjepXX5MhWa3Nf7jiRBJ5uUzJFY9gL0tTvDKOQZp9CI9mvsdmfu3PTuJJRkjy3cW1MTQZ+ICrDJd3vYQ/CQPHDlVKbugRqMfdkAGIuvh7/I1CwCBF8QZCcXNkf3BSJB/mDwpSxSuTB46es89op1DrJGUuEBHLwwR6B9OS5PevwAXEJ/r5DsWi5Pev1O0s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6b7224-6185-4c7a-7fab-08ddcad5eb05
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 17:17:07.7163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93W+Mz1Hj6F/kWB/4yUO9pMq4HXOsXXn5pwU1oSwgrpXX0+AQOyKHbFAc/jCmQXvTZksrMV+fQR0QhjtALyk3wcOPvMgS1ifDCVJv9gv6mg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=749
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507240131
X-Authority-Analysis: v=2.4 cv=WaYMa1hX c=1 sm=1 tr=0 ts=68826a9c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=20KFwNOVAAAA:8 a=SRrdq9N9AAAA:8 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8
 a=ywGVW2r4aqsSmIhoKUoA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: neB1xfU2cV4LYQm-BEPWeotiG60RujZE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEzMiBTYWx0ZWRfX3BuoEvZs5FxU
 9M9/6TYMRbs2G8koUnQiJr1V2lNuX2gdHKFXeygzl/GM1jZLWatY3Qc79RpUum9ZnuCEVz1EoFb
 6/JLsu1g4fsMk8aQ+i7wZdanG9cW2rzvbqbAdXmu5CHo/s7fcXOT8dxR/wzmAitPHliVs/OpQdB
 Lea2dO/ihovl/n2Pw4skpHuvBc+E09UymAVwRtCnkfUfn+uHQnIu3NJ+41Y2/jD4RCAutc4QaQg
 oUb+T+vBuLuDyBacr4kZoRrZ/zbmImCCKGGyFWNWEJI+aXT9twzL4x0TtURjUVUHPy/hqKUFG5p
 eBvIMpmQ4gmTIJRbBWf48JohW1DBaNGkBcLw7U8z/PMeOKyK+5weHHBH/+/1LPeWtOCesWKJ+WI
 cee5wCiLaZ2cZ4kTDYDSf12etjm4mBSIecyywvIw8aK6ylnsX69lNWkW4nwmQZnegbJzE2ZC
X-Proofpoint-ORIG-GUID: neB1xfU2cV4LYQm-BEPWeotiG60RujZE

On Thu, Jul 24, 2025 at 10:52:59AM +0530, Dev Jain wrote:
> From: David Hildenbrand <david@redhat.com>
>
> Let's add variants to be used where "full" does not apply -- which will
> be the majority of cases in the future. "full" really only applies if
> we are about to tear down a full MM.
>
> Use get_and_clear_ptes() in existing code, clear_ptes() users will
> be added next.
>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  arch/arm64/mm/mmu.c     |  2 +-
>  include/linux/pgtable.h | 45 +++++++++++++++++++++++++++++++++++++++++
>  mm/mremap.c             |  2 +-
>  mm/rmap.c               |  2 +-
>  4 files changed, 48 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index abd9725796e9..20a89ab97dc5 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1528,7 +1528,7 @@ early_initcall(prevent_bootmem_remove_init);
>  pte_t modify_prot_start_ptes(struct vm_area_struct *vma, unsigned long addr,
>  			     pte_t *ptep, unsigned int nr)
>  {
> -	pte_t pte = get_and_clear_full_ptes(vma->vm_mm, addr, ptep, nr, /* full = */ 0);
> +	pte_t pte = get_and_clear_ptes(vma->vm_mm, addr, ptep, nr);
>
>  	if (alternative_has_cap_unlikely(ARM64_WORKAROUND_2645198)) {
>  		/*
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index e3b99920be05..4c035637eeb7 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -736,6 +736,29 @@ static inline pte_t get_and_clear_full_ptes(struct mm_struct *mm,
>  }
>  #endif
>
> +/**
> + * get_and_clear_ptes - Clear present PTEs that map consecutive pages of
> + *			the same folio, collecting dirty/accessed bits.
> + * @mm: Address space the pages are mapped into.
> + * @addr: Address the first page is mapped at.
> + * @ptep: Page table pointer for the first entry.
> + * @nr: Number of entries to clear.
> + *
> + * Use this instead of get_and_clear_full_ptes() if it is known that we don't
> + * need to clear the full mm, which is mostly the case.
> + *
> + * Note that PTE bits in the PTE range besides the PFN can differ. For example,
> + * some PTEs might be write-protected.
> + *
> + * Context: The caller holds the page table lock.  The PTEs map consecutive
> + * pages that belong to the same folio.  The PTEs are all in the same PMD.
> + */
> +static inline pte_t get_and_clear_ptes(struct mm_struct *mm, unsigned long addr,
> +		pte_t *ptep, unsigned int nr)
> +{
> +	return get_and_clear_full_ptes(mm, addr, ptep, nr, 0);
> +}
> +
>  #ifndef clear_full_ptes
>  /**
>   * clear_full_ptes - Clear present PTEs that map consecutive pages of the same
> @@ -768,6 +791,28 @@ static inline void clear_full_ptes(struct mm_struct *mm, unsigned long addr,
>  }
>  #endif
>
> +/**
> + * clear_ptes - Clear present PTEs that map consecutive pages of the same folio.
> + * @mm: Address space the pages are mapped into.
> + * @addr: Address the first page is mapped at.
> + * @ptep: Page table pointer for the first entry.
> + * @nr: Number of entries to clear.
> + *
> + * Use this instead of clear_full_ptes() if it is known that we don't need to
> + * clear the full mm, which is mostly the case.
> + *
> + * Note that PTE bits in the PTE range besides the PFN can differ. For example,
> + * some PTEs might be write-protected.
> + *
> + * Context: The caller holds the page table lock.  The PTEs map consecutive
> + * pages that belong to the same folio.  The PTEs are all in the same PMD.
> + */
> +static inline void clear_ptes(struct mm_struct *mm, unsigned long addr,
> +		pte_t *ptep, unsigned int nr)
> +{
> +	clear_full_ptes(mm, addr, ptep, nr, 0);
> +}
> +
>  /*
>   * If two threads concurrently fault at the same page, the thread that
>   * won the race updates the PTE and its local TLB/Cache. The other thread
> diff --git a/mm/mremap.c b/mm/mremap.c
> index ac39845e9718..677a4d744df9 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -280,7 +280,7 @@ static int move_ptes(struct pagetable_move_control *pmc,
>  							 old_pte, max_nr_ptes);
>  			force_flush = true;
>  		}
> -		pte = get_and_clear_full_ptes(mm, old_addr, old_ptep, nr_ptes, 0);
> +		pte = get_and_clear_ptes(mm, old_addr, old_ptep, nr_ptes);
>  		pte = move_pte(pte, old_addr, new_addr);
>  		pte = move_soft_dirty_pte(pte);
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index f93ce27132ab..568198e9efc2 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2036,7 +2036,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  			flush_cache_range(vma, address, end_addr);
>
>  			/* Nuke the page table entry. */
> -			pteval = get_and_clear_full_ptes(mm, address, pvmw.pte, nr_pages, 0);
> +			pteval = get_and_clear_ptes(mm, address, pvmw.pte, nr_pages);
>  			/*
>  			 * We clear the PTE but do not flush so potentially
>  			 * a remote CPU could still be writing to the folio.
> --
> 2.30.2
>

