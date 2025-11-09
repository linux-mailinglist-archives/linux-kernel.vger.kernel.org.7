Return-Path: <linux-kernel+bounces-891901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C25C43C8E
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 12:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44443A8C58
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 11:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B270A272801;
	Sun,  9 Nov 2025 11:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bvvvyK6M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bs4/hVB+"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D422AD13
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 11:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762686999; cv=fail; b=GotwLhGyxN//guWzw0dP85Kum0JCEnl6FfJVKAJdsUrE/MWTVCyD26WUaGCzxBq47cQvQGfNjBpHR0wbQb113zg2yLVd1Cd1jOz8uV1fdYLhkpPJdd/cv1dCOliZtBELrG3ODucmfRS00fdJ6X0mslDJN7bmOEvqY3DiGHuSk1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762686999; c=relaxed/simple;
	bh=OvjuWYDBCllfdQTVioTr9QzBqYmUL1h4qlnfd+yfR8M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P6t4nBmk0qVk6/H2/KzFK6QFY1BIogMCa0kRxbqD9JBPdADQQNU79E0mTpKseB3GpPGZH0FP41q9cEY/Jch31eD6iymabzaKGasnRDX/ZUMoJrD2Y2K9vhj8RDXJtV5B5/YcnmyLma7sgl1sCAmPnSFjo1dL4ByWF22TAMjLt1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bvvvyK6M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bs4/hVB+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A9B6kPQ006236;
	Sun, 9 Nov 2025 11:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=om2GqzOaTxu5arg5
	5u1YkSyccZu49zmhNumJPtJGqfg=; b=bvvvyK6MDyVpjEQ5g9ygE02/dtaHTsHm
	TK6DHCR54104fZDg7j4Uxb3z5p8sapneD99bKkXCsP/jP9uPEbx8fqAU4FF24hLM
	iOst7gky3K868xx7+Szbee0aV+nWKt14euVTZmoDtker/l7eSz8qAE1o0+PoFyp/
	sDQwP1z0jhq/8vz2pWJEGHZuHZkQ8E0zwenjC7gcBNMc23ZFLEOx+OFwlsXBxAWh
	eDYhlO8b6xbKYRUvL1HYuWPxDglm9RzFU3NOTectSDBQQKchkvttYpiWi0I4BklP
	lm5MbseHiqIESaz/h9np7JpPojJtqKRLJ0ja6g03Nq+c4UcrkB0gZw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aas1s81b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Nov 2025 11:16:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A95n7NW039984;
	Sun, 9 Nov 2025 11:16:18 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011013.outbound.protection.outlook.com [52.101.62.13])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va765rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Nov 2025 11:16:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsNTi/H7+6hxskvAyQnAPnJfWNqzQ+B5zn82+9vNkjFMeFAxOwipDMkofsdrLxCXRICxt1CNR+t6KfwL13Lh57no9c3HPQbJO1Psx9vr41ifjlfs3n2dC6+rT7mwgmagYqXhze1l+s9C6OKbejrvKkcSe9ACnqHyO6Ulbr85NqeUV8ZIs1glBjXd6c1+VahyDsX3ZQ4MjyPBBtfw1vLYkjGAR2JFhPNvx0vfl2TxT8JsIKrdmjqkPk13PjsZbkZIEUoCn/PWBxvG5/oSGaZAGcz6OTf9lkYGdqT6Ne20qWFsePQJa7gytUtVdVg+eAAUhnfts83jIerlfdQlD1+/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=om2GqzOaTxu5arg55u1YkSyccZu49zmhNumJPtJGqfg=;
 b=h91tZdcny0gifWTm/CUg5dQBGd7KNcnVXLY2GpQtQPo3Hl4iokJeBXepa2i0Q4s7l7R8wIV4aZlu+nq71J2D/NsbBgQrjpwBHw4wrqskybhZHJCIbaGHLkF/ciSA7OP4sbGjkThClw6R6D4kkzEvP2LCetchyj2cnCVPsMh/JATm59LS2FpWhWZ9W5jD/Uwd5ftRsKZEFn8TORscNWournLkf7GhkNXp58VJ515pkG88+GDBkvxy9X/vl66sSEJszvjbfeo3BLTpItrUzUcZyFqAsyQxuPYWSsppgQUZhHYlbjRDGVTNB0xMLeH4eU7XGFvVEeHTUY/3c9JySARoSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=om2GqzOaTxu5arg55u1YkSyccZu49zmhNumJPtJGqfg=;
 b=Bs4/hVB+xvJC+1YzEwre0t5kdQ0LL3sRIhlC+lB9kUAQazfWqdGL4aX+SyrsP1WMuudp82Z7cF5H91a0yErGS0EjAaYjiQX4N9FCpyTPiaWtP5qIQkRdn3Uw0MGE0W6VaNmLEom8sBJ6MlOfO3fj+ida6U0tH1alaL9Wd0R3q4Q=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH8PR10MB6410.namprd10.prod.outlook.com (2603:10b6:510:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 11:16:14 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Sun, 9 Nov 2025
 11:16:13 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mm: perform guard region install/remove under VMA lock
Date: Sun,  9 Nov 2025 11:16:05 +0000
Message-ID: <cover.1762686301.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0027.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH8PR10MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc54803-9e76-44df-9a53-08de1f8164d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wsQ6qKqKp48gRF06yUWR00IOR1bb78yhF+kb6FmVIR7RcW6n+hzdhoViTKwO?=
 =?us-ascii?Q?q7oZJDC6ly3Sfdw/B03Qya+S9ZRu6Wv4LsKJuWY3tMeDDhnQ1pWUKw9V3+Ei?=
 =?us-ascii?Q?bwkeJQnWkfb6OreQ0M2WedfFYh/1z8BUpOTHRefgvNHgXLGwsyn3no/rheSL?=
 =?us-ascii?Q?BEZE1yLKEHSXymYxoFgiKSat8O8BjYZ2ef9akx5zfOVwnVL6Me9HSGAdPeyg?=
 =?us-ascii?Q?zS9DuxdpXcLZUu446DxWKf1kXR1y6Ssthtk8oy8HhfOAAxMca1FlyhOUI5SX?=
 =?us-ascii?Q?JT4ZFVbB+NCgwfI39Etj9LuTKkNWDdSmyzXPs31ehH15h6YlEjHLj0uwt+Yg?=
 =?us-ascii?Q?QvB6rKGUMsH8yC9gdqjW0yJK7/huN3dEgXzDaeGC33NORXFCrnmfKoU7HRBJ?=
 =?us-ascii?Q?J4UP92gwpv+DHPPCtJBnbGuz9hYaKmD1joBn0sNvAhWSN0+yTjNPZxpon44X?=
 =?us-ascii?Q?ZqgVzlT91/D28JtGXO4MZTvDpuAiA21RprbNMjzp8A5l5EBCOK2DKTtk9Prt?=
 =?us-ascii?Q?WPQWYozikwGRVQhSIWoeP9M/qdWKShxGwhs9U0hd9PeUqyVlkslS6tQiEF7t?=
 =?us-ascii?Q?RHcypEiHX2wMuZRjnsodjK1KX0rO5E72QUDcQE2qkLdwugVhhyo6tgrXhYQV?=
 =?us-ascii?Q?NMMejYIo8mMld9NCtfLHyczmpT5NmqaWwkzaIDSJVoL/EG7W8SrnvfAwYjf/?=
 =?us-ascii?Q?RNrZvZtbzbnRv0GVhk2tc398wNHYOMshAalXwFkxPA5+2FEvpdaENhn4yp/k?=
 =?us-ascii?Q?pbvktdO31TJMxB/DMIDnkUTaNypLYZuzxq7i6qJALWX1Z1eG7jtUiteDlis3?=
 =?us-ascii?Q?K/VBQd7rrd/QYODHgRc7Lz3ERBVYmkvgjXKfgOp6pnbAyqqTpr8HPa6qvrKi?=
 =?us-ascii?Q?WvhljyDunYy3hZxt7BG7KUJFVX2N2futA4Ywhp6eSf4vdeukCbjZuxBbLmuH?=
 =?us-ascii?Q?frmwP268evpeGmsuruZz065dpXMenaDoqJJ2lS/dWAcZRGl2gda3136GCQXl?=
 =?us-ascii?Q?M/AsouIr3HnsLZe1ACirGughrNF+ttD7w5gpZkn6RjEgzf4djoka8hdtR/Mk?=
 =?us-ascii?Q?zE54d35S9LUNs7xNR4vz4GBgHU6yXjUPia+OH+i5EsQ4aQw6gYyMocqetvB7?=
 =?us-ascii?Q?kbpb0FDgwpsYXNRXi9lFjSNvbMAyAarZMY7GXAnjKolugdpIiWGLAGVafvjS?=
 =?us-ascii?Q?8ADvf6ojRdamzLAHTXNPKD2Q+vJkMMB8H8oqrtgmHoRikonqGq328EPAUI8+?=
 =?us-ascii?Q?D8EuxTRYRhmh/eGdSG37fExxuLedHv+Ba8iwSyvsl8zuDSk/7XFjmm3DRFMG?=
 =?us-ascii?Q?6k1vEVmnF3YUJLXrPfCPsFhNl30CY6tekp/inp5nd0ZPhA28gzNIXulTKT6d?=
 =?us-ascii?Q?nKBXszV54jpVQc8EaX988pG7XvQ+mWdexXWP4tQhrilAaarILeY6Lv44cC4M?=
 =?us-ascii?Q?MAiztXA9kjVbQbESExOvVij5wSmRPuYd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mLYZdbDBcAaSj8sXApRpeWX2DIl26lerT/+PUFzFwddR++5TCkcbQShKmwy/?=
 =?us-ascii?Q?7y3Z66mqO8X7AxIBVyovbYxDp49mDTs4iCuvenAWYpLTHndyOPZS3uCZ2+7D?=
 =?us-ascii?Q?Tz6Mk4izqXWGe4t0cGUWKMdVHcLrhp2FphMHiGhH5+EmT976lfNt1zWtVa8h?=
 =?us-ascii?Q?MM1OSHvINVX35eQqi453SRbYz37cihS5ZmAk/XWx5TQ2Ga92RfVeb/hhkP+9?=
 =?us-ascii?Q?I9Rzeew5BK84sMkf93ArMEk5nsEMXnmjzC+Hxz8ltQa8fi/8INYdIKywHIk3?=
 =?us-ascii?Q?W5+A67jvsxpdPzGMxvYlAA/IsmemHWJs3LDc/UDo+lDGEnrW/fexvErPfLJW?=
 =?us-ascii?Q?aXlXAAwbq6gAvHYdZ9RSujsJWUb2sOso+3iwYFBAPEA6z/Mfehq4a0BjP399?=
 =?us-ascii?Q?7WDHDJKWXZ2sGa94tRYXNZ7q/HSudjIC87lz9m5MGplNR+OOfILG0lYJgOtX?=
 =?us-ascii?Q?gwcMEliB+tlvzM6IdwAhRf3mL7qU+oXTy7GUeTGvc0J2nMhwd259wp7SYVCT?=
 =?us-ascii?Q?BNOjhcAegi/qL27OYnbQJ36JOiGKwvSTLQl/4kQ1ydU64dKhsfX/BgrV8Nq5?=
 =?us-ascii?Q?/DA1FCJd9I2FMLOKt46OZ0D8aEzqy1rqRCXG5gChyqTl15ypdZ14sjQr8vzV?=
 =?us-ascii?Q?pmzS56oLJjUxGVKuX5/AeOQA1CXn8mYzak9uhYBu9pxPj34JAPLN9T9euE3O?=
 =?us-ascii?Q?clCJ3SJsKdjGgpTlG2Lz2vvfJAYIu7Yr9Cj2Go/GsU0zet+wA5l+djap8jNI?=
 =?us-ascii?Q?lgB+MOGRgSz8vWnBLL5CicfFlklfuUCOovd1a/Y/4Wp7YgFXgYlZE7txItet?=
 =?us-ascii?Q?calYmtJ1p1Y07kRNhwkFnL4mg3vOliBCUAnFXefGzT205dxDklHT19a96BZ0?=
 =?us-ascii?Q?iEi9DnYpsz32zMEZCVQTGSDz3WA4f8iodOofMl634tBEt0/9fKhvZ5UE/CUk?=
 =?us-ascii?Q?EByzYIHSi1sXNHGA9/lBPkT5bDRRWTJvFn6eztHKuMFUKcYD51+0oNwrq8L5?=
 =?us-ascii?Q?3S/2h/5oNH9O/MsKFEIFWx1LKUvWDVAOgAsiGV0rYyaKBwub8LWDNmRbKJ6W?=
 =?us-ascii?Q?q0mVYkD2LDsdMQ/tD94v2kyjYaBz+UBMMxAkIimd7iRV4IW/UdmFvXWUC1P3?=
 =?us-ascii?Q?VQziraesZwDY24Nv1qK+4g+5/oeuFwz8ArSmowT/P+MR6ojrproHRjh6Rw18?=
 =?us-ascii?Q?22N4rAIfQz3UslwtZMBXMSTuG1rVGq3fVijMAm6xGfzVxiBanaeHiMOVhj/A?=
 =?us-ascii?Q?R56SqHYQDCwcIJ26KVPQJrJhoL3ihA63LyeZLqL3o7eoOIaxBvDPq8w6A+Nb?=
 =?us-ascii?Q?fvKTEX4rEe17zu+ZRm/s1tckq+uOE0Ul+JNmgCM+H/0DmjhRok/Pf1vlTy1s?=
 =?us-ascii?Q?s+5unEvTHlorg9YAIIH+8/1Xyzr+Z5Qap1461AjOMIltSYXlaavsaGUQMIGN?=
 =?us-ascii?Q?+sypGxoG+LmT4i4/3eyiG2V64IIrSo/J79wCV2O6OaZDD+I0sbm6UkockZAU?=
 =?us-ascii?Q?z4dwqe/SAJinZZCCGSXW1w7TDRKrpQcI23v3NeiGTZNBdTZjXjY/nX1Hst9E?=
 =?us-ascii?Q?XFHarc6nu+80qGnPPoML5vsSWFqgxVeJISzIMAUpvAlqrlTSRj0+wX890N2F?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BiScKSKUE2Vuomn+j/RcEeEpbklcSXHypPM3FHrNYCEeNMjXgeRQDpzlxEVy8ly5O784vAjE3Do1u6MUXbqzqXMgn7S1jdevnmREfvBTNGxNSg8AR2qD6Wgb+EnCzvCUEmFnEY4Lj9wFnXJ+xjD1nEsWkEWnm7zblmxep9hxuD+DHkCH2VCCq623/YlCC04OpTilqgLKL8xpRL/c2gqAqSpRLJxOJzbI3ggOOoCewPJM/ECF3NqvSgIpWeX+EXfXqWSCjqycMIqkmB6VfFm59B/P/Z8Wu2XzpZdAGZi2+9H1xu1hrQAhNZFOceJwb+fU/3odZGYV3gVZUgDI8n8+X8U21O3sLPSix8bUTTR4PAL5q1RwHJkxovki3ZV5iSyppuVYy7UErGH4j2ynT4IPKbnSgMadKzqZk/IVNj0clwnMICMzH7OwH3Fi/jGpMKBR/VRszzKgf8Gh688lmmS6xsdWB+1ziHoH2izUk39rSATz4YMD+3PmwjIHqpbXtMH5ov+neKTTg5LfvXLPRaS1eA32CK6pX2iP2bqG4Gve7H6QM5OBEVsoXfBJx7UJxO52XsVFZHH3RcR40RPr2pofDMBIFOQxSdDylPlDQPAXf24=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc54803-9e76-44df-9a53-08de1f8164d8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 11:16:13.8349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17GkV6lS+332ZXLWd1hpj2qjgQ+PqAx07JZT9Hk8I2MllrDhAGNZdpMCqMjs/WoSdiaTFNYKkWAQqFgC0oZQsOgsXUfiipgS10LSYrd/4Ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6410
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=730 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511090099
X-Authority-Analysis: v=2.4 cv=N6Yk1m9B c=1 sm=1 tr=0 ts=69107803 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=WRmLX566G3Uji8YqiXYA:9
X-Proofpoint-ORIG-GUID: MilvmVr3jnEm7SCpFZsV0tSV6zlskAU0
X-Proofpoint-GUID: MilvmVr3jnEm7SCpFZsV0tSV6zlskAU0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDA5MCBTYWx0ZWRfX+U4oiOo1flw3
 Q4wRw7hlsq5o/YE0+ygJA4RScZRgHUdS0QJwrMPGAK5DT/PjSmjA5jpNYzooFZPnMW26J4PjzWj
 iQwz1oZIX5/pGlHdjLt5xJ0T6w/B4bvKDUP7r3W3/lNsfhpqC9Sz91e/biASUFgHofI9i21r1Te
 a6F7aVq0Lu3f5B8MeGQPCuKfbfS8c/6YYvCjUYnr0dTlhtOLtfru/vRjwzhnVrNxZQDxFdM9tJO
 HU8G6sWbhxXHqoJ0M5rh9RYbrcHMo2bZ010W1KXfai1SUFZJzTWwGRBCA6RZOF7m2VCyT2Ai8Fz
 FLA+H+R+mj7pAlfUKwFAInSb/ZUtfJuEeF9HzKi8rAJZE/BdyEj3OOb4ENWz4/HVjHIQfXSRJXA
 tQ3Q4qPlaimRZSgV36dcnkjeDuWTeQ==

There is no reason why can't perform guard region operations under the VMA
lock, as long we take proper precautions to ensure that we do so in a safe
manner.

This is fine, as VMA lock acquisition is always best-effort, so if we are
unable to do so, we can simply fall back to using the mmap read lock.

Doing so will reduce mmap lock contention for callers performing guard
region operations and help establish a precedent of trying to use the VMA
lock where possible.

As part of this change we perform a trivial rename of page walk functions
which bypass safety checks (i.e. whether or not mm_walk_ops->install_pte is
specified) in order that we can keep naming consistent with the mm walk.

This is because we need to expose a VMA-specific walk that still allows us
to install PTE entries.

Lorenzo Stoakes (2):
  mm: rename walk_page_range_mm()
  mm/madvise: allow guard page install/remove under VMA lock

 mm/internal.h |   5 ++-
 mm/madvise.c  | 110 ++++++++++++++++++++++++++++++++++++--------------
 mm/pagewalk.c |  25 +++++++-----
 3 files changed, 99 insertions(+), 41 deletions(-)

--
2.51.0

