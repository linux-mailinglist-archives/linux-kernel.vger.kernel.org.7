Return-Path: <linux-kernel+bounces-766060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F7FB241C0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847F75803CF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FF42D3A65;
	Wed, 13 Aug 2025 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C5cA3hSe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V83M+SPO"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9DE2C08DB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755067383; cv=fail; b=f2HctGMmw1H3kxR1/BZvtl2waCEYX/7fPSkqTASk04T5z+1wH+nOIpgGKc25838Sg9c956xbIujmVFnEn3YBWVTUX31EdKUtPh9/9Bx5dtKUb2/V3aQe+rwt8Az3VZwbuOdRyixQb6XHIv+LdsgL49bID6cVSUTxRaj0puPkHxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755067383; c=relaxed/simple;
	bh=7Zpz84CUpbchD8LHLQOb2Clt1FjVu+fDNJiT7yBgJ4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eHp1G4MUjOqhrom49F7rV3GBurII09/YyFTPPzKrjLuFfVoeVHNJe77lnUH23WavAcXXGr7SkyRTBp80kIdXdIzLtuwRpnbQ3jgsoZQM5MpSGQOCm5uAE5iruuowro8joV1efJoD+jb8StPBdHBukGrunodrKaojFF1dCU/N1eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C5cA3hSe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V83M+SPO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D5uCpT024507;
	Wed, 13 Aug 2025 06:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=mHO7B0WJYVMgEHi7xP
	fucXVRpLLlaUMrEks3249CKys=; b=C5cA3hSeKIDWOxOBZ/Y52Gt3jm0SSXQ1PW
	l07n1ut1Y+rHshbQ9MX+TY7nRu/xI/71uQ6CU481Ir8+jIF9GwzJuyjdI6492nel
	CM8UDDV6i/kvZYt+mlNSPFezCFrFmsjLNbZUy0oUepyQWiVBpDoGv5bVs/kENzzj
	YBYttEBKD/d9+AQmfDisddk2iuVNrcZXNunAWnRMUe27KutIiYIxzb6fZsKVULyd
	mznMAVzY778H1/VJ30qE3PkmwP4zBAYx2VEjwBH3CbSB8HyC951SKWv+t4UyBffq
	kcRPEiYFS5fDmAfrNGjoNaYp5Xf5tC4IgiHY6fwdJh8ENDAwbfAQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvx4ejrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 06:42:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57D5fPlU030118;
	Wed, 13 Aug 2025 06:42:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsayttq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 06:42:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxXuiGkOsEQkWW8wTC8fptnw3vzNw6l601rlCRXC9av1+1EwmMw4+lLKQgJEjJoDy7bsXWE+Gx5dKuDbys9aTc4HqAfGXZG4Xs/Xe5oSTsGbkZmcORkmXWy/fPfvLV76NEZ0TUC6TgLASrw2YgiqCHhrURkrs6wu93xs+U2vhAiiifsBGGPxSx9tSDDN8ZnDDsYVjH10Su87Nh+0ZqPNttS0oF3RyoG/H3ktAJbvlHVGPc3V3hsVmtjfLBfJLemia73YmaZxezSL6QV5a9ZwzOto45B754RJq/M85wXkeOUJSbdTY33GD0Kc9FpWvJbCPp5u2NNS9spd0Y038ntsxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHO7B0WJYVMgEHi7xPfucXVRpLLlaUMrEks3249CKys=;
 b=hUEZ9AN4RQAmvPEgFljVaEQuyL1Noy2X/d/SnhgoAapk61Tp1Uk3M7iz8E8u7PfR8B1hAzkBSKiyksSpdvdntPy6rxR7KjubwT31Ztl4Ow16xcIzWkheoKEH4dzQ6msZcoSLTgnf/t3If1MnRf1IoDGYyR5G2e9WBUo77NO9ZAzfhtb0iKSZI5hHXYgJ5Zxe/zy93ip7YOmojQRuSRwG4J9FfmGuoUlwg4fTXa/I98qy/wwuqGoAQn/eZ6vRj0FC2D/JTNa1sg3urxTVrMyh9EFVbQKGS23IdoukpF3K2wocMGzMBnlykSQW/Qn6Oiws8IeVrq1gDZsLrXrFPtZL3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHO7B0WJYVMgEHi7xPfucXVRpLLlaUMrEks3249CKys=;
 b=V83M+SPOWxnbgYUbH4YGQXzMJgK5gz1j+Eus38dtrFcFNJpYZdYybOnLYENjA6fYk4WG5bePfaweVO4+6sHX1Mzd6pYpnbNBRaQUZ2WuZ+56nq598Hth5mgKiIJHJZGg8NfzvewXXDsgosnufw/re6FRP4BB+7I7wrTCAu0j6fw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7986.namprd10.prod.outlook.com (2603:10b6:610:1cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Wed, 13 Aug
 2025 06:42:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 06:42:48 +0000
Date: Wed, 13 Aug 2025 07:42:41 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linuxfoundation.org, mingo@kernel.org, namhyung@kernel.org,
        acme@redhat.com, kees@kernel.org
Subject: Re: [PATCH v3 13/15] perf: Use scoped_guard() for mmap_mutex in
 perf_mmap()
Message-ID: <a9085638-b560-43a6-861e-74e52b431783@lucifer.local>
References: <20250812103858.234850285@infradead.org>
 <20250812104019.838047976@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812104019.838047976@infradead.org>
X-ClientProxiedBy: AS4P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a00b3a-f848-4597-174f-08ddda349e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?phK/fN2QvX2Mup0qX8AQvPL7sJLjeix6pK3MPGoaJFOh7j34Cpzdbtx03Lp0?=
 =?us-ascii?Q?WEBSWpM3OtNdSlrZzyIpwx4ZeUjLGYRiFNJAuJuTkp2LYWP+ogttrH1MUx47?=
 =?us-ascii?Q?Kr0qaR2uHgyQoi/6zo8MtmqJrFU06oDq9iTgRl/CdLxMwgFZrNamlsgQnG5C?=
 =?us-ascii?Q?1JsUQd8qa1cb6oBdZzHACfukPpMr9prs+Izy6XCEyCv97V/wWXC5+spSGEgL?=
 =?us-ascii?Q?vBrXe6dLQX/kkhH/nh2a2bVpvdnVB48aaecHRcCoUzBoewvA5YEuXpjvYeQa?=
 =?us-ascii?Q?ChJtxL7li15aCGM4TzUJqnsfWV4EpnUjG/a3/OjfEFkqU9Udm45C5jYS5FGJ?=
 =?us-ascii?Q?WYASmIKDOKHrDd4ctFNIHWRwOYgg1Y04tCXtWJiTAviOud6fLUrrh5wPfs/z?=
 =?us-ascii?Q?SMcR4Fnx67nvlC1RUbwS3g9SbVqgVJnhY1MIDGeEJv//XxgGA/NCv7C8QGrr?=
 =?us-ascii?Q?5wcloGWzUw3g8XyXI5epaTvUf7TQ95eiRbudqkcaw+xtNAFUnSTURqjCKU4D?=
 =?us-ascii?Q?4IhbCC9hyiCyVArABx5PyFmxgDJqN+SjvmY7RLG9tSTjYDl77bUB/tPxKQPA?=
 =?us-ascii?Q?oAXORiHMjMNDexJVB1UyYUsBPyrmC98N5WQrWArJvLnVSh6GWdM0aaTrrl0i?=
 =?us-ascii?Q?Nkg40U1cX/Ubj/fGdchHkPOzJPtfOuEN31HWIOmNcdOoLLeyxHinlMwsJHiD?=
 =?us-ascii?Q?v76A006ZnMCkTURRwcU0QeejtOB/GaIZM1VequkZzvSagr25fUyLAUhet9+6?=
 =?us-ascii?Q?/A0fiu+vc7CpoWnJnDWFjnS5qRTMnd+WWz+azpI7VtBwimDIXrnixqQ3hQ2r?=
 =?us-ascii?Q?r+KUvyUNHO+kK/XfBN951VbQTTBu8rqc8mXvW2CxlJdEXSHZNecfRHuJnQ02?=
 =?us-ascii?Q?5sP/3QyQYtdSPelgl0ABM5aQRo5/neRFvcvwEuQXhiX5JzqMardCvtcHa0qt?=
 =?us-ascii?Q?uV2XvHG+Rt5BVFFUggpHc6I6efGZAD07nYVt07InEh/n5pf3dForr6wN0/ol?=
 =?us-ascii?Q?Ve6q5uPAGT7Z371JjRgjyRP/sQozHT3CZfR3c7QhJC5iPqLCUQkq5F0xaXj9?=
 =?us-ascii?Q?bVTRrjXaAaopvqSXflY1KcNTEgO+yoQ9x8sh/ByaNah+G7Kf5bjq0wrpfhKt?=
 =?us-ascii?Q?CuvC6srQLCq4aUne2x26k5RUBMQzzJzS+OjjqZWh9gi6zPVGoXfa2OsptDks?=
 =?us-ascii?Q?iA249mFuismMU5c3/kY5iEtcONS8f/V6NbBrpoQDJOp2TjuFhc70mbXbXDGb?=
 =?us-ascii?Q?c7oH1DozKBcIn68s/CgBNqXN6TaCkRCG3BZ3YqfmRWrielVqbcRjPn/KShtB?=
 =?us-ascii?Q?Jl402dwefNw6RE+BENSaARHIZwAlWaAA0cuH3JQ4H4o8xFx7CKUUlnqmI1xO?=
 =?us-ascii?Q?AmwDjps5033HfdCpvZ2S7MI/OUkoE/jXuIv+JuDjFiYe8v9MhpCY6UJct7i4?=
 =?us-ascii?Q?MmowLU9mCbA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JZBcEc0D4ivetOWGFddC+zf9WsP97GwHuOfkPd37O2T64SYxfDQBnEv3owcB?=
 =?us-ascii?Q?KZ/Aac7ZWx8XS3dsPZWi0GU7Rj47v26VDOG26inEBClIsEKSFARWXbFr6Dq8?=
 =?us-ascii?Q?B2fLqmoF9OSzbo2SCyAjIo6HCF07R2nncg1UIRMgKjE9Rivukwh++3zC7NTL?=
 =?us-ascii?Q?l++v8PNac0fUo30/F+cDoWNnH+KgLCEI8CDXRi1e6zwx77e9lghqzi6lfbNC?=
 =?us-ascii?Q?W6Mvwszwq6LecF93jjv42taaFk2/xBOF/R8oRSKIDC+EJFsn2CiqdNJqo2Lg?=
 =?us-ascii?Q?hUc99RIA8BYHG3kxF8qUkc4I0jKGwMMV9ZX8p3djnzm01JkjujZ0FNhZFWZZ?=
 =?us-ascii?Q?zPVKmgKDEE/8Fa7Bti4fh1TttFxhL89YBnZIYGCBq4/iOQhBcrQeTB4+9spa?=
 =?us-ascii?Q?hegQ9STtfWLGriVqkoRiRWdRppFgF4IowmTe69e9AKW1cGto7koisgyD5AJX?=
 =?us-ascii?Q?dtiEAf1lJ2zoz8itwjjl5N1LwpQAtVMycrLCT1+w/LYnM5OCyGtQy6yiGhVf?=
 =?us-ascii?Q?lXVQICNj4/lCHOcRW4bRGzIYJNMOgD+aWMb99PWpcAGQxZYribnYFR7YYfF3?=
 =?us-ascii?Q?mufSYDq80Z0yzfEtjsQoAVYKAghdy1Gzls2sV5SPH0pBr6NB3Vv7bWSocmsn?=
 =?us-ascii?Q?jRF7vG77qX17DUnVbvu1/w2CxbCz7PpKzF4hwlOk5vGADoaBNGxYnn9DeHg8?=
 =?us-ascii?Q?CLkhEyLWT8BTchxJtzyadvd1RXK0f3Ge1rhUT7m/0yeJFuH60wBXLcF8uPIY?=
 =?us-ascii?Q?CieleGzuYjRrLk0hA8cMaENNTyEpZD7ypzPJftX3GTp3SQz2uJTy03ephc5J?=
 =?us-ascii?Q?W9SVumnD/qIVyk+VY6bqf3YoYgt24QluFfplgKY09vc9h5x3vOflLF6J5eLU?=
 =?us-ascii?Q?VX4qBmubUuzCihO+d5Rz37wWOWnHcqHrXpNmGCrnuC92RJdJWDlC6UZnMkmo?=
 =?us-ascii?Q?179hGz5J7JOLiUM+IPb18wtlHbuE5/3kBJQmv2ZAhrmyyiEw26zoxy2IONqh?=
 =?us-ascii?Q?GZQg02rNpGqyaslqYIHsx3D0Wv8p93ASwJneJe2Ol1JizpXmnZyxuy9H4G/d?=
 =?us-ascii?Q?Fdf1qok4LgZahSZ8XMIMtvyAjSnfCFX378RKK3AbKDGFb1lL9MtbtHsEvyw6?=
 =?us-ascii?Q?ZVJgbio2zsmU2gGJPjp2JXiTRO+ItDRSKmsRzpgZzxEOIcXI2xVsxN8Vkde3?=
 =?us-ascii?Q?nJSQ9egu66IupfiQkV6s5lKNjiNfgPtoeyoDTLGkv0oyGPOfasynbazq25gF?=
 =?us-ascii?Q?Hdgi6hN4oQdRQ1tvAhH/GNChMFHud7flYG+DUsGJTtKxmngkrOmSZKWwcumB?=
 =?us-ascii?Q?u0GdKAu2ha9i+UZFlIXCUbRM/AXgzy3lMkr9dLWkKDmFxriqIyhYZ9WcWl8G?=
 =?us-ascii?Q?dJYuJPHfpX7KLC1shQ7duMBQKsCpUYruuAwMGQYwi9+dZg++jkewGyuMuCj2?=
 =?us-ascii?Q?ldwdgaw022u2jcAIDE8vlB8tIHyxqoW46In4UhL0VzCUU9CGMVge4dQtL2Q8?=
 =?us-ascii?Q?vPndasF5HVG9NbICsBhOOBvrrAw7xLNLtSYzstsSan+v1jKoSvtg3+4/vBWN?=
 =?us-ascii?Q?3Bq0rOQUDCKXMQqybPHG+zoLVW+3pChglcExzGaXIF0IRkpqryyD9m9Fv4wE?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8eWL9Z5O0pFWH8TLlDigbhjGIg9b3jx/KkeJVXIZZOEIfTfBU9nguOamcr2TMGpYoMbEcWkrS4dH377tQHMGFthr0jpzh44UCJRCKRIwwJE4tz+M74RdCFWaDfyzZELBrqohxrSrk7DUT/tjYThPErE1IMZo4gEWtZH5RvjoZuqeOXDLQGKIHLKKAkob38yWYgE9icQU+jkMMVzs+4uuMlA6x5v+tZqGDKMv4er7Uxnuxhafj0sx+flcqoJGSzT3sjYgfp6E19G+PNm1vy69mpdCxILZ9XZOhlLOyzJrhRxc8tuMnMdIwTcAFGUCZBBSnNlgETqK9hyKQ+5xPTKnUJssrV7k0NazZRn+3Lvm7K3NzEhqR7pgX6Fe7ruNuOqmp3K2RkfQw3EQYUW37YgrkE2O1c3+Lj03AT7m6+mLX9YfjvnPnzbvcdGR5Aud4m1j6Ai+UZSLqGpM+byWDHmxmHCpC/Fz+orZPqB3qfsU9Cr9GLGBa3Y8G2L3ZyjHIGiUTN6bEK4n4xNXFC8uovavWkoj+5DovSOhtq4Y8L8Xe3TNgB5b4TnHCPBWXDkDo9lXLVJezTX8f8n59mI5/zaR020vNqOLDuyudt4pK0MfmH0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a00b3a-f848-4597-174f-08ddda349e5d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 06:42:48.7217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SeMhJp+7O/4cmk70KpmlNnJKgFOjNc+YiSoYNZeLnObyhXVaWNlEJobZimg4U7ASX45rqoYkyW3lqTHYgUYMSy/ZGjO1jWgcxIaDJmXnxeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508130063
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA2MyBTYWx0ZWRfX0aP44FpMT1N6
 P68lW4YWCTUygntHjO5Crwm99MEeX8Jf8H/W6Ghuk3kVTjOPodGD1XwfK4gRTLD4YMnEn+UE6NO
 KkEWCqNoBJ/VpJUwBzEuUrjSlN6puqVmQxLiPvqgIDCNHGqmhn7mm+FMB/HC4Ax8Rb4QDBguKQa
 VKCsw14KBixMOf/FndIe8ythSzjBIVAuYCr3ODJntoG9Y8Hm4TXrJoGgpYqtvUqnXKrZan8Kpyf
 RZLqMSdOpSAaIwGnEJkuYb35CD9WeUKi4dyxkHlTfY/zKtSElOBx3M1MWPxVex3T+k9VH6KArIl
 zR4SNeijMv/qlJk2/pGtGme7B3NopWDFSj67cAIyBTePehzvHrMAgpFIXGIZDE3Xad0KmGpdXvq
 wDKNCttWDjegITU5QPX9GVFYj5dBdCGYlPyB42G+PLM32rpIMxRfv9OWt7aih6rJWdTr2Me5
X-Authority-Analysis: v=2.4 cv=eIsTjGp1 c=1 sm=1 tr=0 ts=689c33ec cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8
 a=dBd6vpt9E6kLQcjLx74A:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: H9yDXq9efMxn7QYaOCTrKu3j09sQaVqJ
X-Proofpoint-ORIG-GUID: H9yDXq9efMxn7QYaOCTrKu3j09sQaVqJ

On Tue, Aug 12, 2025 at 12:39:11PM +0200, Peter Zijlstra wrote:
> Mostly just re-indent noise.
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  kernel/events/core.c |   32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7143,27 +7143,23 @@ static int perf_mmap(struct file *file,
>  	if (vma_size != PAGE_SIZE * nr_pages)
>  		return -EINVAL;
>
> -	mutex_lock(&event->mmap_mutex);

Yeah getting rid of this lock goto stuff is great... mm is at risk of some
more Lorenzo churn to use this stuff over there... :)

> -	ret = -EINVAL;

You see, I'm getting in a pattern here with comment on prior patch and you
reading my mind and fixing it on next ;)

> +	scoped_guard (mutex, &event->mmap_mutex) {
> +		/*
> +		 * This relies on __pmu_detach_event() taking mmap_mutex after marking
> +		 * the event REVOKED. Either we observe the state, or __pmu_detach_event()
> +		 * will detach the rb created here.
> +		 */
> +		if (event->state <= PERF_EVENT_STATE_REVOKED) {
> +			ret = -ENODEV;
> +			break;

I don't absolutely love this break-for-what-is-not-obviously-a-for-loop
formulation (I know scoped_guard in practice _is_ a for loop, but obviously
that's hidden by macro), but I guess hey it's C, and we have to do what we
have to do :)

> +		}
>
> -	/*
> -	 * This relies on __pmu_detach_event() taking mmap_mutex after marking
> -	 * the event REVOKED. Either we observe the state, or __pmu_detach_event()
> -	 * will detach the rb created here.
> -	 */
> -	if (event->state <= PERF_EVENT_STATE_REVOKED) {
> -		ret = -ENODEV;
> -		goto unlock;
> +		if (vma->vm_pgoff == 0)
> +			ret = perf_mmap_rb(vma, event, nr_pages);
> +		else
> +			ret = perf_mmap_aux(vma, event, nr_pages);
>  	}
>
> -	if (vma->vm_pgoff == 0)
> -		ret = perf_mmap_rb(vma, event, nr_pages);
> -	else
> -		ret = perf_mmap_aux(vma, event, nr_pages);
> -
> -unlock:
> -	mutex_unlock(&event->mmap_mutex);
> -
>  	if (ret)
>  		return ret;
>
>
>

