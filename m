Return-Path: <linux-kernel+bounces-733787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F198BB078F7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0EC16DC33
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B507264602;
	Wed, 16 Jul 2025 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kGBr9RXe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HtfKvfKh"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F4E1A262D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678110; cv=fail; b=KYPtCY85Pe4gdH2sE8iZtS+gOdtYlJGmh2aFRwQEZaNjfqeMdDS7xsrHhNEzM9Y6L3UoPio3lJaob05XHiizQok4jfZvNZLqsybbdC1UHXXJVkugoe0JEhsWue9O5OB6/Rf+bb50bfa7gU6tD9RqXTlimxfnVcFMpW+kwjSb36o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678110; c=relaxed/simple;
	bh=MFrZqaWiQbW3hqiBpGAZcqrn0CuV5+y+QxoFFqbDgZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G2G+nGq07+VY0eEDfChU4QUrx17Nof8JDYSeyn5IHFQkl7L5nNKqYSKvbgJzyBN7ksuFt03cwTaLPcvHrk8YOvr/DY2vTgFVd05etsVMtsEaJoiJX7t0YwdlA8rLNGQ7DuCCB6ZvJhvvy+HYim2TkI6UnA2GobyTqfITMSWdzhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kGBr9RXe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HtfKvfKh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GEtm3P004351;
	Wed, 16 Jul 2025 15:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=wjstpHywA/iFyu1jtp
	akrdghfiZz37KHkxSm4vWSWBk=; b=kGBr9RXeECOiYyAkDo9iLXNnPZi9hODYst
	2nikfdapAqh7S7OHME9C7L19eRRpsbZY0fHN4SqbTad5QA6UddlkHnkJ2CN3hGYM
	KReNBL1vdtwwD6cDerLUFQbT7vQl8fZ6e5m6VEj04P0fz1x76eBG8556nHaacF4Q
	q4IyurZ16le7GE/bjcUGnAcfa9w6YgrskbP4Ed5TVDIMVHd3szVimxne3hM/1LIs
	e6tR1MPYq2RVEKkSbMwfreoHLE8x6f/WeUHeOdm4yK2/Sv4baCrvRhMfnI4XN8Om
	MzYQgNs4AL0WeB+wsg1AQ/afIt9wlqE5cieL2XCEbvw+sW90QtfA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjf9kvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 15:01:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GECD71013034;
	Wed, 16 Jul 2025 15:01:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5ay7ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 15:01:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCZJaSZTqUO7pvTEKDXX42GfMsYpBE8MqPlmPeFfRqz6QUSzVXBWvZjU5r3Xa2z3EHcBMuDNGKuW/zSeIjvj0hKm/cg47HXJwGWr18v0BFn3cbrAn4u4IGJ+LYAcpuAaE1bO7Z1Mg2yTG+6Mt1m/Oi5c9q/dM5zLD3D7zCs3Ly15a44NVQLPUX+Zzw9sZ65e3738vg0GObkWg4cvb3yPyObtuD25QHM75c2tbznB9QpIINSBpiFPZJ2ZfH8GWI8tO01BrSYf9hEDPHTmcLAJz7OiJB8vh8HfKhxsv1tqeq1rh9GpQimbAZrOsLwuFt32TbjEzr/FhL/nop/ChDwWyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjstpHywA/iFyu1jtpakrdghfiZz37KHkxSm4vWSWBk=;
 b=OHoo5fnk5TS61AonsQShKYXe5F2I1tWMOISrETd3aFbNQiXoL7SU5EaAYyzTl5EU0iO/D9lAZsIFe5XwkvoFYkTjk9Hm7QvOpNYv2kXRtFstgOelLtQCzTechTP71yVNrMdmBrU89JzB2etDK/tFuH5ryDCwRdes4VZwTDOIEuF26oCDrH5q9tTJU0Q97oK70pd6gdf/WvgOOdtkWN7aVpYi3wxYUawSvlWxmkEau7Nsx1A2lHAyiT18eE67cEW93V0JU4n+q6EJsuGDZGbqTLsLvhLvPgLSZ0brtMh6zGRmT/HzGDyONhwC6DOMX5Lf9XcbrrZD6Q8JwZXakIi/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjstpHywA/iFyu1jtpakrdghfiZz37KHkxSm4vWSWBk=;
 b=HtfKvfKhfr6tJm2NnN/dlzgnIdMOaBT/y2OtwZ75qVvmfAuep/TJLvFHMyWfWgFNm5UQ6fGZnNLEwYbksyhaYhh/wvermRGUoWxceuNcSy5FdPpR2GdLInw0rSbpahnNlfEvxL84Faj3C7EUEpQv2g0lLqtRUfMcg4PGnUdeWCU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BN0PR10MB5144.namprd10.prod.outlook.com (2603:10b6:408:127::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Wed, 16 Jul
 2025 15:01:17 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Wed, 16 Jul 2025
 15:01:17 +0000
Date: Wed, 16 Jul 2025 16:01:15 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH v2 4/5] mm/mseal: Simplify and rename VMA gap check
Message-ID: <e657e16f-7929-4e2a-b0f7-8627979a8099@lucifer.local>
References: <cover.1752586090.git.lorenzo.stoakes@oracle.com>
 <8efef79c46553a9b8924878c1f4363998c1f49ed.1752586090.git.lorenzo.stoakes@oracle.com>
 <9845f6f3-6265-49e9-8eba-5855b2b5f90e@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9845f6f3-6265-49e9-8eba-5855b2b5f90e@redhat.com>
X-ClientProxiedBy: LO6P265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BN0PR10MB5144:EE_
X-MS-Office365-Filtering-Correlation-Id: c0802b22-4c7c-427c-ab16-08ddc4799d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h6ZmFojwHaKHNdVdPtm0D7omSFMGJTZ21LK90gZ2zNICyU6JZfTtqkTCgQfx?=
 =?us-ascii?Q?Hmcz8lw5jMuI4U0GoexJc5LIKwZuci5hWmbTRDkyC9WcT6vq1n+c638s0MHC?=
 =?us-ascii?Q?XVA3muiLT02wRu0PAb55tY/s2UJMcbndfzdvmrYIkeUjOAiMfnthmQ473GVR?=
 =?us-ascii?Q?+DOtPCaZ+tFt5WqRN5uM1C+sOa4PzmtEeEUiPNK/z4ycHNsRaKPu4/sUbmeW?=
 =?us-ascii?Q?hkEohuNt0rLx9iXSUD4m6UlO6n4QZV6hU2yJlrsMr9pPR6UN+ya4Kmb0gaSp?=
 =?us-ascii?Q?h+Z1RXLmjE2NKnH2YrYHv5VLIxa+RwUDPK6swdywTJnw3hMQqIW4zDbDhIgS?=
 =?us-ascii?Q?EU6kMOhKt//uotZXYMhPk93mB8DMOslHbBrBo96fRqi6nQmxF97MmvLCQhs1?=
 =?us-ascii?Q?ZFcwQmuuqiiUeGCiN9RdNAoMX04wHG6VmbITJw1wpTZrN5DBza6jWgHOGa0E?=
 =?us-ascii?Q?1l61f1jWmgavY+R2mCy3v4jTGcVPYZ7ubhdOMS8V7F+myAUlmaR/84g8f4mQ?=
 =?us-ascii?Q?ZI3bGAcEPnhx67inRm9fTyIEEOUAjObV3XGnllfm/wk2G23Z85ZuWP70Duvz?=
 =?us-ascii?Q?OqxFKLnghNj6eElNCV36FFs9XdrBtY1aljeI71enwP3EfvwlB2kt8TUmtZg0?=
 =?us-ascii?Q?oUUGRuOUMlm+iaWdvkPmEpTHW5T2tfiBbO3f9o+DWf6El3E/vThDEkeanVcS?=
 =?us-ascii?Q?t0zb7dz8Y7hnJuKgdwluows+KiDU5WPEFAMYW9iO3JuWzIejK6ptdO2berjs?=
 =?us-ascii?Q?5JLuMJFo1/6fDZP3R/2QCL4LY81ZhwBKQ7J5pdHY0ZVeuEQMrGqhbl2Goeq0?=
 =?us-ascii?Q?RuGoT9f+entC65ltes1i1mcVWe5cbqAB5NYIyB8zZUEFlCTOXFcAi+c22E1X?=
 =?us-ascii?Q?kvJOOMVk2CHrvE2Y3aOMJaxKIOk7f/b/22qYYJmtpfvKFW6ao2SVVKfA6IRl?=
 =?us-ascii?Q?h6vM6KGVIjaOWJSQoWXAJzGRgU+etMQW4YYpKFI8wr/YgMEPoC1+r4XLLIoz?=
 =?us-ascii?Q?kelgAEBFbmB287X6j6cElWy+/VblLAE5G1ZCIHZshtia3D+m69qx7c8DcSrs?=
 =?us-ascii?Q?SUa3ABzoGuhpqUskvn6qsSQJmVCpTKOAm10kBybGZtcV2/JGng0rpyK74lj7?=
 =?us-ascii?Q?IXUNgEFbcdNe/ItmNUCJZS5l99lgFrI3Q+vg8kfbo+63VC8tsOAwloP8aDQN?=
 =?us-ascii?Q?L5yJk6nNpeaCoD5gZWZWIx3IGEBoHYtxV3NVe1tLV/aKTQsr9iWcDiziCHFq?=
 =?us-ascii?Q?8737GNCp1BFtFMSv+UHJSndcydYeg/x8aHasmcPCSQtU1Ua8Gz9bpvsvl0ry?=
 =?us-ascii?Q?TnuCQ7Ed9CNJNtSWJpfqbeRRxaryJ1BAEQtgpnmf9ZJVV4/Q0L+/vGYjCD62?=
 =?us-ascii?Q?SMhpa9ZSPo9EI2TxTeKhK9dywkgj0//KGbBuDregK2bsMh+lPczwxxfYjUzJ?=
 =?us-ascii?Q?jcAbltCg0j0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AqfRbM894tNbMqgd7Om1m4nJR1XlB+1OM+iZkTa2/TvrrpQ84s4aucAfGd/j?=
 =?us-ascii?Q?dzTJGJGcwtlwzi6UCbigbapbXrfFVDOlrcKgc/8tE7Gy+oVPBUPCgndj78zu?=
 =?us-ascii?Q?wGViEmE6uBGo5RCQJqc5Ek7+WdprcuMePNoqyjOSQ843LNWC7tTNYRUXHNjy?=
 =?us-ascii?Q?XGuO/YLJ8TjAKp91ZiVMzPAlzU7u3YgwOqRp/QajpI4IRDhKd9nGy5FKv+Ph?=
 =?us-ascii?Q?XK+I+fGCKB3maoH1otFWnww1/VQFH2dp9zvg5fFD3gtGAPk/xFYzCGuxLIQ+?=
 =?us-ascii?Q?sC0y23FItKJuYpbjInGFBUa+jgoy6UgnsY8XDnTXQ1CgIT2Sn7fD3mLuL66I?=
 =?us-ascii?Q?bhOYh97oqzwPsKU9dyWRyaBymzi6OaPeWwEe0G3s83KDoUSSWS6ewwOkir6+?=
 =?us-ascii?Q?wbi5qm15QpFyQwPCv7AzT0CWWXNgNsUf0D370osgbmCc0Md6AxzktUw/hS52?=
 =?us-ascii?Q?/ZW15+R3pChFBkuAw4exAjWYLwDz61lsdK0hf+hL20VsgaVbSr0SYO/59Zz1?=
 =?us-ascii?Q?xB72rN8UsgTdrSA9KrKr7GRXYbi7FHJot+4MtO8Vnirn9cTq6LOCxgHXs+GV?=
 =?us-ascii?Q?RKOcTIjt4mkRHYVnwj3x3F4YtPuemf82NGkIKSt52nX1c7aVIRSWRqJQ+XOp?=
 =?us-ascii?Q?/LH4zrgHT234vq8hs0tNUdoy+SyHOrwTOl7YGQtS27oQ5pgMSWRyzXwTH/zq?=
 =?us-ascii?Q?D/S+6tK6CeeBak43//Pn8+9AGAguztlbv/Pgx0KoU57/C+xDwBURvUEu9e+Y?=
 =?us-ascii?Q?mZMIp6GNsj9dczEV/QoO4lKH+6lVuIDNuWwZe5GJAz6c0EgWXwvHxOoHS05I?=
 =?us-ascii?Q?+xf4jisX/6AKCh1xHQmQUbgjKmSMYVpZMUCJfISrwH7TGCfSxvKa+Bj6tm74?=
 =?us-ascii?Q?Sp5wBbQ9kV/xTSjO3uDnAqRg9f0sqjipeYajhu7jwzIst+NBtNpwbpGFts3o?=
 =?us-ascii?Q?uVP4kI5Mqg/+eICtxvxqy1MoiIKhWdvfKDQfUWcnQw4QEVm2MK2FjcLBszNP?=
 =?us-ascii?Q?AnIs74y1wi7evgZy7YAy+ZuvHQTAnd7alXtPjWX8BPS3j2rirEReUgfRkbK6?=
 =?us-ascii?Q?V0xtWiLHbyEdiQfXGjMlrh9k24dO4HlYeiimZLnZ7XUj/O30TJCo/eZMjhbz?=
 =?us-ascii?Q?pp8vWN+lh7+ADP3OxlciONHQN5HqIPWVL97aftH0bUcmi4SlficBRep5/cUI?=
 =?us-ascii?Q?wyine+4jAl6IvsGleMkUt1FMK648/KWbJcQ/Oi33hGoNOTRfkj5HTkC7zfeE?=
 =?us-ascii?Q?g/5VWOiv8tFnhgLPK+YTCK13lBVUaXwyvl+36iKb5Mdx5X3+9Y3N5F3fePz+?=
 =?us-ascii?Q?cvsnUgW70Ofj4qUhygrXgk7b5D7uhL0mD4EGmQ1Lf2l/k+VhpRcfg4nBaKVi?=
 =?us-ascii?Q?Wpy7iuxc7hPiuQRE54wZectOTHgPwxVHRx1Z9pYWY+n4wYEdYmYmDVkZajMS?=
 =?us-ascii?Q?YC80Zq+47xuTTmn1ug59G/LDBeNiNg59dP5hFI5Rn1pS3IkLnvwR6BWJbTHn?=
 =?us-ascii?Q?XW1jQ2nHdMrSxq1giOYwh56fGL7lYmQXUxfbQbMhf1/GzjaFKAR9PZv0PWdQ?=
 =?us-ascii?Q?e80dQUyh0RDiHn82Ek80kBbXaUdwojI46I+jd0qtNZqscjVcguT+TNb60Yu4?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h2J7s4yxilwPKFIrxA6XlO0tCvdObYSBPxEP68stTOk0BXCfFT+3aQxQvoTMBqa+OwhooqGm0GySrlWf5dP3R+m0okRoHM0Z0NY1kadvkq4rIRGyj+pSzI7HvYFcN0e4YDTobLm82dFzUnsXgmkfMEilyNvYjxjZJOnHIqrO6NX9VJFJA942DUrzRpOcs92jMmj3R6tJYQECaIa80lnNZR8m0qw6qMb86VPl36QG3kjhyg7lpV9zGU46Jg6q0sv1CvI9jAO9Dc2yh9jiD4Z8dHemWaAH5sWYIRIzU8IvsSjZNTOdXjcODTDFugO4uQp6Fn+ov3cw08itKW/N+GjUleRHq2V8hRTwPqBZRcs/TcE6gRn9iD3YI3q2zFEPrwZU8Ti02zMZGVpJqlZewoOJ1jfnVwgiHGb9qmqL3dkRfn8BxnL8/U++fbGSXMLwLG/RJsJ6Yi1XvXQwD2aN04U5azxCKuQgUKdd/7qKypb8zeRHRVvyImBMCov62y2X0HbdBzgnR4oqRgCRb7an9Dnwp+N9zJl651WSLG4JAs5AaBSpixqTDt+NYfj9B6s5wv6t7Ofv/LuIMDrpssDpO7gLxZMvAVo20djnoIyL8xn4vBc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0802b22-4c7c-427c-ab16-08ddc4799d92
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 15:01:17.0967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baw8zjnAvgHwM8AhRDXlXclI/EsP81HLFRHohTR0AIxb3T+ubkfD5G6VmLWpXdRSJG4thDNHwpwHk5+M2cbQGWAvbS5qrD5+JdZWGKdTj5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5144
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160135
X-Proofpoint-GUID: yQwTk4uDsLoWPG3AeUiDBUy-j9eN0AC3
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=6877bec1 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=J6yl7OL_X7DJ0qooIjcA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12061
X-Proofpoint-ORIG-GUID: yQwTk4uDsLoWPG3AeUiDBUy-j9eN0AC3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzNSBTYWx0ZWRfX1YaXMGnQqcXo uTcAxyw2ffsaOtSF7tiQkyR7P9b8sgK7VovnpqqxbqOH2F+BbBn73TzxYCZBB+WcRcHInCzv06z wJyj939Q95LN27j2qkvSAUNSAyviPtuMwM9hIY2qTCPks7bXKuL5/OWyC6IwdZ14nTdxRCU7kUo
 nswcvfXQvympi+NKE7GKHW4WqS0NbQwATQMmjFA4lCNO6bPS/qzFhtR+tzYu64wxsWQu4yO3EPc z9a0qmwxaArJS2fJt3xKoHSbPUFi0ypzVUkLdVDO/qtRDXTFFy4YxA8KumbE+N1VHHioYEa/SyI 1DTcu5GIR6hgiwagyklnAZopwluvky4axr9PzrsFd13xb0s/5blhUrHIbXEYxISJ+JKCHrM0yhK
 yrxVJSwQz2cr4ktdUrNkmx2+OC0zAyUjfT4XxQy1cerUCMTLF2NPEZnqwp9juN+B2r905fuv

On Wed, Jul 16, 2025 at 03:38:51PM +0200, David Hildenbrand wrote:
> On 15.07.25 15:37, Lorenzo Stoakes wrote:
> > The check_mm_seal() function is doing something general - checking whether
> > a range contains only VMAs (or rather that it does NOT contain any unmapped
> > regions).
> >
> > So rename this function to range_contains_unmapped().
> >
> > Additionally simplify the logic, we are simply checking whether the last
> > vma->vm_end has either a VMA starting after it or ends before the end
> > parameter.
> >
> > This check is rather dubious, so it is sensible to keep it local to
> > mm/mseal.c as at a later stage it may be removed, and we don't want any
> > other mm code to perform such a check.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > ---
> >   mm/mseal.c | 56 ++++++++++++++++++++----------------------------------
> >   1 file changed, 21 insertions(+), 35 deletions(-)
> >
> > diff --git a/mm/mseal.c b/mm/mseal.c
> > index adbcc65e9660..794d1043a706 100644
> > --- a/mm/mseal.c
> > +++ b/mm/mseal.c
> > @@ -37,34 +37,6 @@ static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >   	return ret;
> >   }
> >
> > -/*
> > - * Check for do_mseal:
> > - * 1> start is part of a valid vma.
> > - * 2> end is part of a valid vma.
> > - * 3> No gap (unallocated address) between start and end.
> > - * 4> map is sealable.
> > - */
> > -static int check_mm_seal(unsigned long start, unsigned long end)
> > -{
> > -	struct vm_area_struct *vma;
> > -	unsigned long nstart = start;
> > -	VMA_ITERATOR(vmi, current->mm, start);
> > -
> > -	/* going through each vma to check. */
> > -	for_each_vma_range(vmi, vma, end) {
> > -		if (vma->vm_start > nstart)
> > -			/* unallocated memory found. */
> > -			return -ENOMEM;
> > -
> > -		if (vma->vm_end >= end)
> > -			return 0;
> > -
> > -		nstart = vma->vm_end;
> > -	}
> > -
> > -	return -ENOMEM;
> > -}
> > -
> >   /*
> >    * Apply sealing.
> >    */
> > @@ -102,6 +74,24 @@ static int apply_mm_seal(unsigned long start, unsigned long end)
> >   	return 0;
> >   }
> >
> > +/* Does the [start, end) range contain any unmapped memory? */
> > +static bool range_contains_unmapped(struct mm_struct *mm,
> > +		unsigned long start, unsigned long end)
> > +{
> > +	struct vm_area_struct *vma;
> > +	unsigned long prev_end = start;
> > +	VMA_ITERATOR(vmi, current->mm, start);
> > +
> > +	for_each_vma_range(vmi, vma, end) {
> > +		if (vma->vm_start > prev_end)
> > +			return true;
> > +
> > +		prev_end = vma->vm_end;
> > +	}
> > +
> > +	return prev_end < end;
> > +}
> > +
>
> Probably better to not ... move the function in the same file? Then, we can
> se the actual diff of changes easily.

Sure, will respin with that.

>
> --
> Cheers,
>
> David / dhildenb
>

