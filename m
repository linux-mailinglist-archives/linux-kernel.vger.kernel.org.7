Return-Path: <linux-kernel+bounces-741306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AC6B0E2A5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C845633C0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D2B280308;
	Tue, 22 Jul 2025 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lKwUAz9V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tfLo8mmY"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7169E27FD5D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753205713; cv=fail; b=dy6FzU/jPd7x1acDpWBmCZ2HLqotixdCAi0R1l/3FGQmt7ClYcdQWzv4IDBdhCbHN9Q4r9M2Kqe4Bv1F6HIaueWlkmkmWCybLyb2JFH3BKX8E9Ax6w0hFKqhtleq/NSQTJkeq9ZnU+vYijkNNG2z62u6qbaoWoKlSMv/4HtOBzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753205713; c=relaxed/simple;
	bh=RMVrIucj66MkFx9ipOZTH4BxXdRP9Q8Hzenw4sIxxsg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PW0pafhFCB46v2JycGdw3Bwzt9/HR+Yy7NH5HT6rghynsXscgqWtB7NG+reovRovDfkT9QrEvpaV59ME1XemFUw8jk2nbVCqi/z7C8/Fi9cYBMCa95vj6G3/PSVeLkp1hVeGVrcZlfTdkijKm4P7B7U/aaOJslHGBbVI1s7wXN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lKwUAz9V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tfLo8mmY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MFXlVY005735;
	Tue, 22 Jul 2025 17:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=KsBJ90CXvPLBna41
	fROMGI/UBz7ijLBTMSBeaKJ1jr4=; b=lKwUAz9VbQRuKTtWTxsm0tUFBw9apMUC
	M9gFbsZoiWAk4WOrmwFFuP+MNB1cgY869w6Izg2qyEF/2u5EZl8e7A+82/zS21He
	AjySJp5vs2dddZPAXd1+XMd/K+aTFMeoe2TR22ZvtgojdRVtKLg+GOTaUCPmpN5/
	HJgYzf8Yxs2AiOrr8b4N6laoyfrLRb2xXMCZDICOiAhst7hs/p+XW8nFVbdd6QJt
	Fs/ga/bI10B/0WJgdhqUNZOYrCQ2W3uyv5Izv2rHOSxgUiLotkMnlyATopmsrWfR
	yJY51jZ6+4N4uZY1RzTJaw68TtqbDZhVFd6AFYsdyCSoF66jp0O07Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e2dtu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 17:34:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56MG3TxB014506;
	Tue, 22 Jul 2025 17:34:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tfwnbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 17:34:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugVrPTCb0Gkjr2GdLk76u2X95wY3RqXnbeRctX/FDfI4XRSH0foyN6oq3cINgxYEdTltyYCcbKVDj1sT40Lbd7pjLN7fExtNTDIsDbJhlNRFkzmwuMzk2pnMsSED0dJdDkyEnJbvFwr1VHEzPiRpVSXhPZbTSSch4MPE0Uu3psnkIZfj8XW9AxUy8JmFaLHsfZPa39GASZLWGqoJHahaq1tGlUxNCDbkHOCqxZFEuzvuDteFx5y5Ls1F43EWHrpnCX0wImuAU9I+SsaLd31e7NK8ZJ6tGc89Kt+215w6Ah7w87Y6k7IpNugLbseyoVZwSh1JwVwAJv/mQnoUmqwS/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsBJ90CXvPLBna41fROMGI/UBz7ijLBTMSBeaKJ1jr4=;
 b=X5jCX/VX6vOfjmxTNZZSosgsAjzh4SGvnVvr1RgV+syCj5SpytoBiIrVg1mJ53MO5lxEa6qU7v2rOGFuK5nOyH0zhcsRHUffaPxrLuiETCfDphQp/NtUC+/5AZtNWOHOBmydbbkBYWng3eRh5lS4g+yiaSjiO3FiAMaRih/cItdMuGz/vWlEIL5f8bIoH+hN9r5xYslCgh8i1IpDnjeRcUwXGrHZ14LiE232xveCHvettoM+PdHqrG7hWe7FEAssqTkxkQ8U7Wf6EYgiLBm4cEjTp8+cO2h31bV52mHiM9K3mED6DvFUMwERG9qcA5udWgkH5VG5SAJ8o5ognzKWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsBJ90CXvPLBna41fROMGI/UBz7ijLBTMSBeaKJ1jr4=;
 b=tfLo8mmYjO9vD+vtmfY8kyl0HH1VbDcShNpRKgtNuV4SuxFL4d+W+p3IRzinjpxyusTuo++gxudP7p7gvZLFIjK/QP6IVv73jtDdm7sfhMfLO7Ul5sv5T2g18fBUW3dhhdnOFEwxgfrtHrLh5YSo9UqSPjnrLYkVoQ9cHo8OBJg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF3AA48E9FD.namprd10.prod.outlook.com (2603:10b6:f:fc00::c1f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 17:34:43 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 17:34:43 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>
Subject: [PATCH] MAINTAINERS: add missing shrinker files
Date: Tue, 22 Jul 2025 18:34:36 +0100
Message-ID: <20250722173436.145526-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0371.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF3AA48E9FD:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf09601-ba57-4a3e-58e0-08ddc9460b66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gvII43kdYH2qVQwmTmJcoLqZaQq52NOKEmFYCujuvRjP7qwsSW4ydjj0ddnQ?=
 =?us-ascii?Q?ffsteTFADa+92CysMwWhjYHsa56/v3Utu4d3PKRXukXP6tn2BRzi0cEWCsYB?=
 =?us-ascii?Q?twGH6h3wA2PPRINCWple94Ho879VHPgv28scmp7s5u0BJpXe8Ka4lB8R4Ry+?=
 =?us-ascii?Q?zHeCI72r2pawULwfd/aXuh20onD+Twuz7s/h3D2HGFx7Lrdf6jUPZZ6pzjr1?=
 =?us-ascii?Q?hb1utobWc/cQjC9I3UbcIRCUyIg83c6SHtISlUPirSUXCLVhB4hoESp9i4xJ?=
 =?us-ascii?Q?plrZLCgGyYcVwYfMYdh4WLeEn/FS69B/AhqUsqCkjFT9PK9dka/+kXQ1DJzF?=
 =?us-ascii?Q?GoxEP1oSDMUHeQx8gfwd7oqGFRo0Ro/CtsBa9TXa98glIoVhLJJfySzkO7d6?=
 =?us-ascii?Q?M+sulx4yTQIn1ZoiPT8+vOWqUI+kKqStUq/niQsrdH1VJu5J8f2JzgRyqdIl?=
 =?us-ascii?Q?VEHRlmNoxY6BHKo3RDMsiSOlqZslTsTV5OKO2b4U0lWwpWL9VVuJV5APVxOX?=
 =?us-ascii?Q?TP5iOilU2z4r3DaueVeuLObauMrrPSxv02BQ6Veh5Pl6PCg8qaWtAtKldTPC?=
 =?us-ascii?Q?2ocd/TsGHwC0BBo+b2AmNNSo7bCjvjSTUBSsUlEvXThzVxKqoPzs7o5R+cFs?=
 =?us-ascii?Q?WspegYrhcPEFhC5kShnK6x2hgAjpjr/CqI75H2jDZ3BYA7SyIOPWCcqOZ3w+?=
 =?us-ascii?Q?gWBF6ju7NknrBNLnSZSzHcR1AxyqQM4JVTOrW8jS4kAt5ZVyRtASsvYUNAYO?=
 =?us-ascii?Q?IC1WFmlx0yFwBVuA36zOj4nAHtbURiEs7YrVASnvnb7rmNFH6MDDTy0a6M69?=
 =?us-ascii?Q?JORGU1rlsJ6vcdDu5r1tR3QvRlJSo9IaaKpqHFXeCWYUygkmmrmYa9pFFkgB?=
 =?us-ascii?Q?I3YyAfB3joBzHXbP9MRwFOxbxT/jb45cLeuuQEJtudhAWqrRNEx6FzOqWJVU?=
 =?us-ascii?Q?gu+2OZax1zOiHhJVSslJJDa9nUHaoFQU67SEozYZMk1haTlw8vKzMHwvHG7D?=
 =?us-ascii?Q?bFJzNm6v/wrEmXFjaY9dwAcM0W+kGt5LUrhoyHwolvamSB8CjukRA3lxaZYd?=
 =?us-ascii?Q?G8vTgAwT+g5EvnWHksJIhj4KgiPaE4iChO20xtSVMUcgZogiGCHilr/KT4bS?=
 =?us-ascii?Q?TAmi6W2TADRqIzUBQ72f9y4SN8nsNHtVrjuCj6A5pzjppac/imJx9WEA4Qw3?=
 =?us-ascii?Q?MS+L9qxPF7xtAMfYms4BUZKYwpc74H9Xj+Cd8uiFMxXzYlRUU8S+RielvXEX?=
 =?us-ascii?Q?V73Asl2gDh+h2A8nEIviNIyXxGb4QGFk46X1yhALngqFpK2lB91YgFEb6MRU?=
 =?us-ascii?Q?sXcne7jyJ3/ElCdlbbYWsV2AWekVqlfzOh3gHWPr9Di6Bo3/s4owaJByzWlu?=
 =?us-ascii?Q?Xyya7KvK0mYTPNQDZ1jLBQIWluJTBHpxjhojAbV/M/lZNuiI5zzbj/D12oNw?=
 =?us-ascii?Q?AmYo1cHd308=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MwVujhttAPfxas8g4omqq7x2t5ce2Kt0vq0jleDcoNS30G2yF2qnLua8w7GL?=
 =?us-ascii?Q?/+dRPkDxyhVA0LfqqjQUh0TelzZy4pA6aXuDPiVF5YmVMRdjbbkO0EJqmdLI?=
 =?us-ascii?Q?MQZwywLycfVePuJV2MyRJO6aFhFzG+Lrd/d9eGPLXdur9zPiHX1Ifn5Egv3n?=
 =?us-ascii?Q?SVLqtjIBmmvtHT8a4CZ2AHeoVe0jLUdHed9X0dz7l3GTkUpqLtpDaaN7YnJp?=
 =?us-ascii?Q?s8xJZ71ayCppou12+7MhBD3j86rRZG/TRknvqsNDf+NU3nasv0fcWDFERLeR?=
 =?us-ascii?Q?S/FgziVuEzQtbZX+aZ+LY6xYf9JWAVl31s6IXqIaNFBeDHPXcCKqafF8z8Zs?=
 =?us-ascii?Q?9uK9FPZGaHNoxhlKawBrN90i5pCQGtaQ+lbFKK7+5AJTA4k94BJWWxK6jmHU?=
 =?us-ascii?Q?0Rq5jLqK/e9SyJvwQy4uM12hhmHZHXvWqrXlXt4LOy8iXhpJOgR5XqVqJI6N?=
 =?us-ascii?Q?HiwX3ZaB/3vR73afZDUkJ5enJOtDJL6LXmdYKrf3zCk5bbq76CRfg3D0bbKr?=
 =?us-ascii?Q?9vjgU4ig/WYqxJ5oGAPVuaM1OzcuNEHSghBpFBc3jx7R0+sPAlks+NOpfCsB?=
 =?us-ascii?Q?/JU9onIJ3zs1BkK0ZVm8nxfMm7S9WwuP+KBk5nqXnhG5q6WzTYXiXzoQI7K0?=
 =?us-ascii?Q?Md9PD98K5yDq2OTUEb8jNPCYQWbxFEYe/LHpKJH00x2lIKxj789NH1FG473G?=
 =?us-ascii?Q?eaCMmAgtQeuuISsMPFvPvldpgRnpro56U2yJK57qWuQdQAyegby5ntkhgDJp?=
 =?us-ascii?Q?mF9KrDdvw4ATq0N1FRlZR7mQAOqFBqlOOqAFS85qrC2pX4p5fsDpHWwlQmQf?=
 =?us-ascii?Q?Ry1P2lHxQvOdEmsMtUSzcpk96r1oAMTkT3FOBy2mzqJ0MNnnSy1teOPFLbmm?=
 =?us-ascii?Q?z0jkOE+Ye5viSrO9oiCHLlGcgQRHtDnLvtM0N3G30cYWUt723RuZGC+sitrj?=
 =?us-ascii?Q?bxNO+GXZYljX0J3bhqrG+71Sw1uswfQcAEUL6xBhuW94t6YasAJbCjXL8yQW?=
 =?us-ascii?Q?nh41hjlLdgNl5xdu9PRZmpksnpS/peoQzdBijRrh5VJg+lv4l7fvWYkDWvMs?=
 =?us-ascii?Q?VRBT6dk3MA6wJoNW+fVBbkI4lhayHTgJUm32Qcbk5d+sTCUCpgIdF5POwwfa?=
 =?us-ascii?Q?DSCAuPQRbvP1cD+x/QP66MA1ztZDml8D8/yDe56QcIFWUrhVscuXP4tz3rij?=
 =?us-ascii?Q?QrJYCtccKqGFrdCuPGnOglyJBEA9EZ3NXAgCxmj15qPpQHSLLJoXeTWRCYL8?=
 =?us-ascii?Q?F/Pfn6hKeirlYISjVzLxif9nqcHb2JwKLLIDX7YArAyeUXtRXq8o7d0uqvoT?=
 =?us-ascii?Q?ZaZGMhAwwx2SES0O4rmZ86Jr9RwZyZAgwfDZgXOtoNc3yCVZUBknL0vvVOwa?=
 =?us-ascii?Q?/EwclMX3oPk3Ma37Mn5/KM3n2Ak0Su8pztCG2SD0GwwGkKAmb5Wlmy6qEU2w?=
 =?us-ascii?Q?wLuYAHOyR7Rd4U8Xn7Evq4gsmnx8COVmIF8WRCzeonBs3pg96nS4e6Yd7Zrf?=
 =?us-ascii?Q?Rs5Lf9+SCpo03pjHGPIuw4jymueJrH+9xrEtO+JGAe/HFwl3awMNN9v60vvH?=
 =?us-ascii?Q?hWBqgA8ntcyZbz374jZ8rLfttXG3OlmZkoz398hooTpG5fWXeBiI/zwOnXMy?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CjNg79RBwdZxVYEg5PDZYZ1XOIf8OKDf49lbJiMGtup+cBtkgRdD1vZNCP47oZgzxUGe8kxljLLrG3CSSWvtQ8lLW7URQxNiB3aHspvQ1OrdJAbjdyMDSh6/qmhdvzN3KAoDyjjyTn+qE9xdalYlL3RWmBKApm1B3ufkICo497xYbQiFpx0c1vKEiLkcZpM7xPZgtfJFiQxXvW53ibRGF1f7BD1RwwZB+Y4t6qTwhJ6FjZ7zm4ZQ+RPX3g55bl1TL32wnez5gec7coVBWVW1F+I+oKsPZyXHv1Qo4nxEPNlM+luHf2CRnYfidV+V1BbRPPqDsuuuJXBilih5UYHvYV1byazD+YJoPoLEzzk1QOKQ5H4PpNWNSuHk9X6UGRHLUolG4CQ2nZH3zSAlIIiHVMC6rygAu5RpK6gxMxGrYYuxIFI7zJEtHg6ccnuw3XGeoqbMQE2jLpG4B4MAeNo2FACgCbdJX/SUd4XRW0IAVbcISsljg+4XwNA5SjGs1FELNxsrqK2qqxZabUpH8Mq14Hvjq4K6miuhaHm29cq1qryegXjGslBX7JaLKMlUE2gyX54nmGEthXTTmSAug2nopeCwdOqraP78aqUrtltOWqE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf09601-ba57-4a3e-58e0-08ddc9460b66
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 17:34:43.3202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ryn6u3T9uTax1i7/ZwKpGmUXOdPDtmjZzHFNqJj8UjNSYBKUwOekgm9Vj5O/PHpGFNVDTYfb3vSCYRKyxLjwdeL7tmENZg1/ioJlZuws04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF3AA48E9FD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507220148
X-Authority-Analysis: v=2.4 cv=WaYMa1hX c=1 sm=1 tr=0 ts=687fcbb5 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=37rDS-QxAAAA:8 a=hdCJvu6vi-O6ykQZt0QA:9 a=k1Nq6YrhK2t884LQW06G:22 cc=ntf
 awl=host:12061
X-Proofpoint-GUID: 8SiKQzrYnNFdZ2mCmbDOIBle4C_6u92Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE0OCBTYWx0ZWRfX/+/1zIK3SRx6
 TMQWoHbJy23U2XmMF1Wlf4oCaQSaiV5f9JazXGITAg/mFSSs1Vq6HNsluFQQwA2t2/E1h+g/KDN
 VmkABW85Q1n4ezOvwzI2JH2UvIKNYJMraTrId8wytYVH99+tWNXO2fEiR3E+0QBAxwBeoSUyAKJ
 KMp5nixe9mCzF7w3u2sScVIv7zUuoX/ecrjD5zaUPpNIqmDL6fEp3b/+qf8QGTeqdmvw4yAArzR
 PPpvrOahuh6lwK+7iQT/qRjv6rz8kcchaKVRrFZmq9A8uD6+oHSbuHr1hIcyrl8ePFq17RQWL4M
 H2xorhEt8WXJKryZoW+Cd7auTi450MMSkSgkrh5DdGiO/hu2RYTBi1Nvwd34ozcC3zgWhq7mOfz
 LDrQczfWKZtzq9BBnSuwyahPthcTDPdH2ogwhHr/uW9oPPQq1lTKhyVx6EceYV3tvTkTPtEH
X-Proofpoint-ORIG-GUID: 8SiKQzrYnNFdZ2mCmbDOIBle4C_6u92Y

The mm/list_lru.[ch] files implement a shrinker-specific data structure so
seem most suited to the SHRINKER section.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 837bc5cd6166..d1878165f2de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22631,7 +22631,9 @@ R:	Muchun Song <muchun.song@linux.dev>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/admin-guide/mm/shrinker_debugfs.rst
+F:	include/linux/list_lru.h
 F:	include/linux/shrinker.h
+F:	mm/list_lru.c
 F:	mm/shrinker.c
 F:	mm/shrinker_debug.c
 
-- 
2.50.1


