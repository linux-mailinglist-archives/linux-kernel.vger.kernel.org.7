Return-Path: <linux-kernel+bounces-759415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84105B1DD3F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83E3585B7B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDE32222BA;
	Thu,  7 Aug 2025 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Upenas6I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0NVLXbI5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE7B72636
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754593154; cv=fail; b=tw3WuzSo1lj1G03/Ei7I4X8PgCNyziToDfUsegcj9j/70UCt6EMgeKJ3hJa9MS9skl6CXBN7d/YagPBrNQlXUDAKZkKE4AIV+ugEt25VUJuajHPhSQPHNpfmrBKlMYUBMhTXGvxkmw+9CBKsM9UiTTGtMDoC2r6yiw62ptJjEqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754593154; c=relaxed/simple;
	bh=Gsp39xXOMdO+p338dO3qBP0HZnO4IQPRzRKgrUqALEs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=X2ddA7VTvYTd6BBm11gfOwC4iPJdlyRY/zZ2w0BTrzR5zysFjWWgKYqQnduigss3I/epeAiHXP1JMXzflcQGcKnjTZpNV/1bixQgN0N5XM0b30gc3GbkGZMu4YYEWj8G3eSHzBpI38Iq8PNJrVcMOwf5oC5WZAZiGAAewNX5FTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Upenas6I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0NVLXbI5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577HCAHl014523;
	Thu, 7 Aug 2025 18:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=MfRwGZi9z+lvDcYE
	rSTFJSMU8RAdA9Yli5oof3tfbmg=; b=Upenas6IHx09a+C9AFc71S2LHI3WyWZL
	zWyMq7ACXchhm1mxvsx1pyvryij03hmECILeT3Q6NZQEFTsgdq+L37NOxhS2S9+U
	bbVHodKy51QXJRe/NpWMGyyvSl9Cyq3A6VcAzFqRRE6rw7uWvBZ5L5UNGVYv1dSr
	bgClhKGKVuaW4hwwx+dVUuuUsTEgK3Ohmigu8LeOyu0Wykmbqt7HXcsSQY1FEwdN
	hEnOPOkBAA0Z13sTp4xEZErwLqyQQqO1vJ7/Zt796Qg6KyMwl/xBpMueyvG54vJv
	hS3P56JNvk+CYtoWGJ1WcOqHdsmkBSwgsGMjVF5io/igF9WyKAdRfA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvf4t2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 18:58:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 577HXo3A005820;
	Thu, 7 Aug 2025 18:58:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwyueuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 18:58:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfAlKcuXoHgRP8oYvnkcNtUQ9tF6JGnjYVmj0UJWysj78oQApuuNF8H+29kxbreR4gCPLl7pzoR5oyrhPQP36pdPiDUX/FUc7Wnr8Vy3YFR8DSSNaUw41QsJ2ubJtdEeRUn+e7X6wjepni2U5LClYXwQCaO5OPKTynZAsj4LEHtyvkJ3DDNHZ3qCUXtXipDHqpex/CvJdN0TvKJR4l4rNBPvnVrr4/oM8oHrTRneC4SokADyLSomBu1Ka/dS1N1sGHIFJp/XYAlsedJFI2ZcTNbFE6MIyWx27OLdSyKXjVy4McfjgGGiQZCfxqX+ZC6XlunFpwKT1kZI69TP9Gia1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfRwGZi9z+lvDcYErSTFJSMU8RAdA9Yli5oof3tfbmg=;
 b=FOnPaocRzDqaWOmlL9YswixbmNRZ4Vs25OzO+JFe2UEmkgZ3EQTA7FzXQRAbmHJfroPqFSWHqlyWlawZwzuw9jU5KCXfxNXMmi0KjGrxa8Lc7W0oTiNQIQ+1JMR7canR6UySeUsECSKoLcXCrEqcaoNmHKB8ztrcbtEx9IVLqHU1SnxNMTi8NkoPvx4nA2fhu1/b11KN6nFLpeOSIzyt63lNOxR7TQyjGabwaTndFv6hIWiqINY+QisXaDwHfFGhEBNC/tOON1rjHtcowNpkOuBi+7NFxqRuFhTjyxKzxHrAN/fA3So6EyA1VPTxALqJsJtOFSj7r9eCVAq98IXBbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfRwGZi9z+lvDcYErSTFJSMU8RAdA9Yli5oof3tfbmg=;
 b=0NVLXbI5RoXwL4lMj8uBjc7dwo794pi6n6YqvpY9CLRH26sNhGs64qOlw8KoXt9+MtAOlaYKCZAJhK7Uf5YdReTYA5rb4b5JaKZxrTep8FNv02vvpTS/RZK7Nr2EBzr4hLrqogdPGSNqHepuMJpGZcmfzbXrTb46uFSmw+eteu4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA2PR10MB4537.namprd10.prod.outlook.com (2603:10b6:806:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 18:58:27 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 18:58:27 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Barry Song <baohua@kernel.org>,
        Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: [PATCH HOTFIX 6.17] mm/mremap: avoid expensive folio lookup on mremap folio pte batch
Date: Thu,  7 Aug 2025 19:58:19 +0100
Message-ID: <20250807185819.199865-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA2PR10MB4537:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7fba44-46b7-4c98-ea10-08ddd5e4649e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L5qbJZOtcop4RpJlpR82zU4V6BMpE1tyciFIvTlXaMZL6BHQwmxN+mFJhyRw?=
 =?us-ascii?Q?/dz3Jd78KwPYqUERi+h+C6agG1WE4BaMZCRZ0oUSRTn2R4+SA+Utn7TPBe7M?=
 =?us-ascii?Q?NHNNxAl5tIdAdBOUL6+7G/xcRZU4XbkXSLPp0DmAcODQN09FOd/EhXmI4I/z?=
 =?us-ascii?Q?7iXbnfIpOf7YW1ktx2nwJGaFHysQ5/9AsA5CxDoj35+rUTnP6kmk5aH42HpL?=
 =?us-ascii?Q?/QlXyzP7NWv1bDC7vHSIg8Vc4eFf1etJ1QkgWbFNo5ALEgsv7KRMxT1txvd3?=
 =?us-ascii?Q?2zLdUZrRYrWeOrlZRHeEgzCGkeIi/Hwx4fu6O3QD6j9plzNV64dXknCcdVHM?=
 =?us-ascii?Q?uh9Pz6P4KR2ImylMQKXseHtOdxbBOjWm1PZf35FiWzVeByensDJ4VexvRJK+?=
 =?us-ascii?Q?fEIGU5b0oKqsxl+IrGmojq+HD7lVyztca3osrlbN/qw2qTVyjtUe1sZhMfkl?=
 =?us-ascii?Q?YXNuYnhFkXaYb6HqrvD2Jr1HuCoL3xw7dGqS3zFXPJwxcUBOcGsO9YKa6Sss?=
 =?us-ascii?Q?vJZnqrUwR506PSTNLH/7QRcv7j2oUAMIrFkxhi5bMcxRHZxQtLv8b9Vkc3kp?=
 =?us-ascii?Q?UWJD4fWJDM61trnfYGnrCyJPex36udDomPTn7jN4LBKAhdYwMkpfVgVdahbd?=
 =?us-ascii?Q?25a5HsgD9G2V7lIb2ryBk7Ok81DbN6rhy5lriPa+cql0egkdxbPe8Hz7UwaT?=
 =?us-ascii?Q?QmPR3lI1yA7chSzuOhGNhZZtuh3BTIqlp5KnJ0TL0gAaprP/aY1mNJUrId2a?=
 =?us-ascii?Q?N5AyUjJg8ogoPj+uKuT6Cn2nhkJd8oVpDikbYEr+v4vxN7Pv3Q18B9Tn1h7E?=
 =?us-ascii?Q?26eYElBRaBxku8h9hd+1O3DVtGoJ1znPvgeI6RDdyRj+Z5xJ9G+6eb/lUbND?=
 =?us-ascii?Q?rUUoLDxrLpKy9QOplzff2V9t6v6D1IqFUr9Ha78kjuMqftfJegYi6Fm4vHqB?=
 =?us-ascii?Q?huYHkqsJLTieOkIh8mh8XXzNQtdrqCTK/n4rfMUP7zCJm2S/Iijex85EV4K4?=
 =?us-ascii?Q?6T4HxC2v5IJEEhE4K+zS5rp1um6n7V+XiEz0X07b7uJKfK0vJIFXunQKeRzd?=
 =?us-ascii?Q?VTdhbeHACSj7jMeDc6BUMbZyuxYbojkt2ipc0DgThGJ0elhYJMQZu+hbQg3D?=
 =?us-ascii?Q?EIrAi6QQB8aICj7UIoGq8QB6HKxyjJ8T0s024KWs6Q6SpItcbZCixjZGSNIF?=
 =?us-ascii?Q?XlLbbgGBomHhtkgUcLCv63JaT1E/9vZHVe28VQsjycnV85yco/V1VF6MPKl+?=
 =?us-ascii?Q?fKZYKMKE1XH9RIAUYa3zXjdSLRg37To1HZWDX1X5u84NL6LizwYvpEZYeiA5?=
 =?us-ascii?Q?VnDwYYw5pdgCvxXCXx5sveeSDUfi3EdnoWl3Y7jcq6SwwO58yeTLy4kdmcVd?=
 =?us-ascii?Q?KqfFdW7lKqqGCc6GEAC68BlZ7TBMkRCbsrf6SHgwmgUfaZt/pBhvScz7GhgB?=
 =?us-ascii?Q?zS3015i+zhg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H66SsX6WsZYAsBqkozRlQ9OtQRrRMfMHCXvQJhbvpBWkx46oRf4r5SuEckMI?=
 =?us-ascii?Q?6MMO/3wDEzI0BpTkLBxV2GytYNM/z+bhZTQ0aDXBO10pgubuhKtSlq8Lp7Sb?=
 =?us-ascii?Q?0L06bc4Rl/51BlntFcZKfAhHrOdWxU4FPlgAqWbR+MIk65LC7DuChtr7USfk?=
 =?us-ascii?Q?XVs/gppIzPl1N0CUXU4gIKPfIbwwb/n9xhPaeA3n2RJpYcwhlaU9O8lWA6PV?=
 =?us-ascii?Q?9oqdwwG+u07uBC29OcrsyCIbEtYqAJzKDjY7XtswAba45FS4vjVzBnlfCXQd?=
 =?us-ascii?Q?565zZ2F2Ozc8UcYaNel3mbxaE+OYOYrTCcBpBAC2XxGJwcU2BZuJ3fV2+K11?=
 =?us-ascii?Q?oHI4E/9epDcxfcVt4WVJ1E3JDS4A49ZDC+fbn6JQnRyN8xjnKIfAVLizJj8b?=
 =?us-ascii?Q?zhpT1eWB5mavlZTZASfQCjhXxikYAUiBoPRFuwOd7dwn/FUzS/HdRazWwwqM?=
 =?us-ascii?Q?wTZ7UYBIB1Sss1FtgDcY+tyVxwgr6dU0We1stAmRik9SVoBv2kTz2kh/eTO0?=
 =?us-ascii?Q?eQ5GiPAv9Jv5jBUKSZssJkZfW+d9N/NZyOikSAbib3f7qgvWyydF90NC3LgH?=
 =?us-ascii?Q?mFeWeqc3PZB3pCxn2THt/zUbLnTPpilny85AjM+Ke3aqS1qBi2iyDaAf1Ya/?=
 =?us-ascii?Q?RWZjnqumcLDJIOyrCpMCL8eZcDA1mYwidI7UkLdXxmiZUGylPKB9O2zwAErD?=
 =?us-ascii?Q?JUjBNZNi17ZRqzfs6vbUzE40+/i4bCtTCapChULZUqoNvFN9NJtvKGlaVT9p?=
 =?us-ascii?Q?d4r77oQb4f37xaGVowP4KRP9I/5tTc9KXkgjn1S+A6kEoiEZc+Dws/DIpVK0?=
 =?us-ascii?Q?ZfLatQEIx6x+0bp1uXJ2O6t0NliFGWrhkkjuMKfPXfgDHrPDWzN/z7lZ7UM4?=
 =?us-ascii?Q?9Ggo6mCqZgHVLOER6837A5IRW1PetlKVOPjkor7T5iQ7iNwCDhY6dzlKsVCb?=
 =?us-ascii?Q?sghfamWTdJeIVCF5vdDgkrjMUJxsFeEinzF7i78MsTFwJniTqShkHoxXTyDQ?=
 =?us-ascii?Q?bZtCrLWX5msHF8hVqJdnNeMKZVixcdVmRZ0WaedeG2mrTd8DzSqJZBQ12Ue7?=
 =?us-ascii?Q?G1uhbXMc0LB/40zDmWhmf4K3Gc95aWV76pfJKSGdq72nrxEC83tBybNbEZKw?=
 =?us-ascii?Q?8L0jOYNeQ3w+CWT99Ts36L/lAzfEFM3skUuFwA7ICGqLNAuHvdwIrZ+14Ltq?=
 =?us-ascii?Q?ygN3etnfaOLa0fHeiXMcHt9qj+XFQuUtDDNB1HRyx7LakBp0gwpcsqHGHCBE?=
 =?us-ascii?Q?TdYRMECzUj0E6oSaYwaNhf53xKKqUYqxEmuoIZ+EBJuQKA+qH5g2EGmS9fOH?=
 =?us-ascii?Q?XQq9YBJLvBWn0gpmXuTw1EQeFhlMYxtzRJ4QrWTE9ePdFmegFQoBc3lIRD51?=
 =?us-ascii?Q?Jk4W8Z9kVJ/gEexkhMyLPVOLR4IoPUEDbv+0mhvvrEkfuh2BXKT6QOpP5brf?=
 =?us-ascii?Q?US/SP0BJDv8I7/sC5fyHIGsfkENverG4HtwfdU3/UaGX78fMgje03Q83yLfp?=
 =?us-ascii?Q?O1LLiqPVUqmISPOvFmDrbRuINBxRyOnd5w2j/D9j+0kBlGauv12QR/Vuw5V2?=
 =?us-ascii?Q?TTivYgSC/CbSbx3iWiaNn0+d9Ow/iJ1JbaNElgfm+j4KkwhmAeYbWo9J75p0?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vSa4shMyog+mOAwolsm0OhCDkHN8G5FIh3margPZJqdQOdTIM1usIO6DRIKybEa9YHQvWW+uGw7Ih+rDthqHjGufwg/48xyF+TerQQNxCPAt1VHcrVmoXG1mG8Pm6c9ltJmCNA2IV6KHksF8guhFp6/mlYFMqynBOiXXmO6lTGGNhrMo0XPFDqqbis4w127texzM2G4a/WtNGBoCN10HHISSM7UdUjR92+Twcs6nYgq1AF8KvqpRRxEYn/fqPkaQds7DWomMBvi6WEI5eVjTEqaRetzA+UFr2Ojlifc/2N2mw7EiWPX9F/JAaTU959Dx4JZ5x8NE824ZystgRM6795wgLNVLhkJnJg+UQFODKAvxXlF3pHOqLJ91Uiq+ZStVmZtapr5tR0ZBlkWU1hgHEI5ybJUq/3YVZTRh4IQmmDTqhxYe4AR1GkWmcBV65tLFaLLMP3UDsWA07SE4oIcZa+47Drwys6YV3UcEWtW4cVKLWSdipPX/eoLq6kD+Wz/78i89dr8KF0aotZzvWkuIKXjNG0tHe4tMJPBxBarZ3+lrpFZz89jQjWIISFyoZr2c3j//mZMjQEpX1Q209gjzU64WcJ9t9IewTKI3hWWY9K4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7fba44-46b7-4c98-ea10-08ddd5e4649e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 18:58:27.4620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEaDnywEzgEMUcY2Nbb5NBRD5rORN5lT5Q/s7kjDsTV29Lk2puiCkZOxn/yfVp71KC83+AZG4rrfis3mj+yIkHXJU4ElEOoXZbVv14d4xjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508070156
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDE1NSBTYWx0ZWRfX+kZ6Kjy8/YSX
 +/HdKDWpAPwyeiAyBlW2FUU++jVg2Z4IBtIyFst0Xa7dznWB8OwCwtg35gNrtLxYVCXFiLh1hc7
 A2mrYyGyYlzkMhd6gOGytxiRwufDbXOkO9r1940PGVQpPD0nLs4B4rV3fFOq0i7R8aficTmqQKW
 PeoiersNLFGT3dLn8oFXcQ0uuVwT1WflsrvOV5MHHN9Y4I87xf+ZxWXxv+pflX7xLy/chORS5YF
 w/QKBBFB4M5YGQV0jJj8NOhvsAKWLtPnyS00Es1ot55dKWosZt4L+7ugZUJCBIkNnGo/tuq3fjJ
 u0TaG1OzoV3PtOxLWoKp/zIs86YgGlN9/Z5GsTXXBFzTV+0UA7u9IHMvGNzP/Af8JldXIQ7iMtj
 34UAphR/6dokGmU67M6qcb5NzUJIrHkgguWuUtVWd5ystxWLkYfQIsuSzJAkmT8Nrfz8Qpkh
X-Authority-Analysis: v=2.4 cv=RtTFLDmK c=1 sm=1 tr=0 ts=6894f770 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=0EqDQRDC3ZQOoIW3zosA:9 cc=ntf awl=host:12069
X-Proofpoint-ORIG-GUID: 4JRrNEWwGr-aCL919dPF0X2w8KxMmsDA
X-Proofpoint-GUID: 4JRrNEWwGr-aCL919dPF0X2w8KxMmsDA

It was discovered in the attached report that commit f822a9a81a31 ("mm:
optimize mremap() by PTE batching") introduced a significant performance
regression on a number of metrics on x86-64, most notably
stress-ng.bigheap.realloc_calls_per_sec - indicating a 37.3% regression in
number of mremap() calls per second.

I was able to reproduce this locally on an intel x86-64 raptor lake system,
noting an average of 143,857 realloc calls/sec (with a stddev of 4,531 or
3.1%) prior to this patch being applied, and 81,503 afterwards (stddev of
2,131 or 2.6%) - a 43.3% regression.

During testing I was able to determine that there was no meaningful
difference in efforts to optimise the folio_pte_batch() operation, nor
checking folio_test_large().

This is within expectation, as a regression this large is likely to
indicate we are accessing memory that is not yet in a cache line (and
perhaps may even cause a main memory fetch).

The expectation by those discussing this from the start was that
vm_normal_folio() (invoked by mremap_folio_pte_batch()) would likely be the
culprit due to having to retrieve memory from the vmemmap (which mremap()
page table moves does not otherwise do, meaning this is inevitably cold
memory).

I was able to definitively determine that this theory is indeed correct and
the cause of the issue.

The solution is to restore part of an approach previously discarded on
review, that is to invoke pte_batch_hint() which explicitly determines,
through reference to the PTE alone (thus no vmemmap lookup), what the PTE
batch size may be.

On platforms other than arm64 this is currently hardcoded to return 1, so
this naturally resolves the issue for x86-64, and for arm64 introduces
little to no overhead as the pte cache line will be hot.

With this patch applied, we move from 81,503 realloc calls/sec to
138,701 (stddev of 496.1 or 0.4%), which is a -3.6% regression, however
accounting for the variance in the original result, this is broadly
restoring performance to its prior state.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202508071609.4e743d7c-lkp@intel.com
Fixes: f822a9a81a31 ("mm: optimize mremap() by PTE batching")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mremap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/mremap.c b/mm/mremap.c
index 677a4d744df9..9afa8cd524f5 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -179,6 +179,10 @@ static int mremap_folio_pte_batch(struct vm_area_struct *vma, unsigned long addr
 	if (max_nr == 1)
 		return 1;

+	/* Avoid expensive folio lookup if we stand no chance of benefit. */
+	if (pte_batch_hint(ptep, pte) == 1)
+		return 1;
+
 	folio = vm_normal_folio(vma, addr, pte);
 	if (!folio || !folio_test_large(folio))
 		return 1;
--
2.50.1

