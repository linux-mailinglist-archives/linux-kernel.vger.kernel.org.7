Return-Path: <linux-kernel+bounces-734032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5EBB07C31
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0EE04A08CB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3172F6FB1;
	Wed, 16 Jul 2025 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vot0lAwL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yId2+i3o"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551272F6F83
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687531; cv=fail; b=LA37mmVrIUzpbdu4jzsqw0dwFoTOX0ut2wxbG7G4P7k6P/in70g6OJf3BRN6RSypG/AKPjfKzmTbg8ksVAtAZHbb/i2DQ1/KngBmsLoADR7ZISrkyo6BoEhZFCG/z1Z4WMLv1Isk/gDTDXrW5z8PDHY13ri947HTC832SCC5Q78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687531; c=relaxed/simple;
	bh=NbVMQaGghG1IzidhSNNwYKq7eP0Q+k0z3m4fIu07RMc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=D07Qvdqwb/59h9iDSSkRWMSWnlNwKvtg5d05YfQj3hy9jN+GcNDUWpjgaKbxZLVJ8M74n1HVBRdD4YszprTpzGHOp7uuzXif799OC657a1EK0E5BLKHWFa7CoBVpEGpo8kJ3Ma4JLyXqqk+IXoMOqQVww/7ttJlZxJtfsKiqtLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vot0lAwL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yId2+i3o; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GFr6lJ010746;
	Wed, 16 Jul 2025 17:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=U8RJbMKKvpD915+8
	d22F27BOflwDKCKZjLRkJq8tvFg=; b=Vot0lAwLKcUMJdIWakWAMCjG1mjRUhHT
	UXfJkiFQfn9ZsgjuYfl/c1/5gJILHF9x+rxPY9VtOz9QjBgSpd03NVa8qCDa5MFX
	K+amlbLLjkU+5tlPbcMoLIaNU1NT6Su8YN9z9pz8uLpwgO7SAyTq4+2bd/tdj2hL
	M2tmi66+kPqdkUlt46pmRSHf3yqp/NXNXI4oamh9HWWhrYHP+C67dMVIPIjEL0xa
	wgJq/FY4En5oP0p3WDZr9287XlnSVb/Es2Ek4wDw7b50FHUzugQz6XBBOe6aNRN/
	mKxhNLDku56hBAzg/Xk2D/hD6yJhjScRMpy8NG/AeYm2eaBNsLqkVQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk67161k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 17:38:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GGjssa029769;
	Wed, 16 Jul 2025 17:38:35 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5bcnq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 17:38:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALm9dRMzRX2VDdFMPjLgIqF7Sod3CNOusOO3/rnsZrCYgn5U94+3VYJyc2ldShYSO+FDcOfhw5uA2xQHvX8KbJ+iZmiZ2psH48q8imyCTQBpeXLP9LT/o7hMUTB5tVpWs5mOJ7UYgbx7o5aSkc+0DALxzYozybQ0p/PK9++7KPgfMclkD+xXB/iuEjr09u1XgKvbG4C/X6DneEvq1NHCKDPzN0ZzOrdYXXpt5BTJFP7c/u55uJWNMuF9GJdea/rda1YWhTbko0BkOneQPItUtGe1ILR+FbOKUq+cSXqGDMPn42ifyG1V+RTdzQX2BXhRbyxUYgWyq44Ro4RXRmlGXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8RJbMKKvpD915+8d22F27BOflwDKCKZjLRkJq8tvFg=;
 b=LNdRy7iCyWy5NwWlewuxF9N0GtxLSwzlt7uA92wkU/E51q3swwojr2Ezk7syPGmnB0apET8xcR/y3NGlh9oNNc2Ylj2LZB/JErgl68pxHElObS42kn9cCkRs2dO/HBshAbGJYKkCKk5V/thmRIGlD6UAg6pqzYJ1CWJYlKJXkhQ+tLpvIy37bhDHTdftog2smBW56p2o3yS5F2BeYJoGqXl3XQS8tsmQBvc57oNHeLG9oC4PNbdtt2/J00olWl4qwvUYyyWpckcEJkd4hi8itxZ9VLr3IQ4qhRGY+chvKMDJdKYYeSUpro5UrHqzEJ4dcdd1xUoeZqUUGxJXWXXPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8RJbMKKvpD915+8d22F27BOflwDKCKZjLRkJq8tvFg=;
 b=yId2+i3oeJ+zCHGEmjf7ye24ahaTyeeQ+dsyhew1NAA99LiNtDu6jBJAGZHG6NK71WIzVmPvfI3NG6hBZiNayAL4nrWbf/18iewV8f5T67mGiB1tzHHsaVhyw9Z+Usfwx7WZclYFeF2Jf2U1v5t8fVnrr3CniuFrawsJCswDmVY=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SA1PR10MB7683.namprd10.prod.outlook.com (2603:10b6:806:386::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Wed, 16 Jul
 2025 17:38:19 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.8901.036; Wed, 16 Jul 2025
 17:38:19 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v3 0/5] mseal cleanups, fixup MAP_PRIVATE file-backed case
Date: Wed, 16 Jul 2025 18:38:01 +0100
Message-ID: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0083.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::20) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SA1PR10MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f714298-345d-4b99-b251-08ddc48f8da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?99n9k1g2WGyb5FksRATjs3nJzGruW2UznIqZ+3a9GP32DirAPL137Vv4eJDg?=
 =?us-ascii?Q?3Evc8UlGU9VFy4DF1yhF8vmh7UZ2jQvRw/Ok23ikRzG1VKlfJJG/iJA7x7Ai?=
 =?us-ascii?Q?O3RYg/aj9wBzw72dn+Z7x19BTGXLPar7d4tNjxDjHQwHtkBPrSOhFn4gDFnp?=
 =?us-ascii?Q?YUJHwQ5vNeqekc5AF5U9MBRu+sbfCcgQs9f0nEFWhKrLnVDKxz9j0UTys3UI?=
 =?us-ascii?Q?+h0xpAKEZ72HCCE0KQhSREOj/+ibcLN5p8hXS3H2XqQ2WFbuLA17HqL42KZH?=
 =?us-ascii?Q?6EI+EOHEHpON7hG6qkz3hgEA9kDkVPPo3Sv3Tag1YiPBNKOXIdjLEujs0BrV?=
 =?us-ascii?Q?EvupPZZIQD53WgKEeWGK9wg2pynaFJJGkCyXmIhsFaTmb1/kkuKU6j7q64KF?=
 =?us-ascii?Q?4bdTCHw4/kD4qVeUvAHgNH2XHdEFndJeqGnJa6FLQSOt/erDqrU+HHPgkBdl?=
 =?us-ascii?Q?t2ZeAmXC1E6ZDQ9lZ+8SnXNIeVCsA3xbP+rnfykVlzjJZPRVSxGe/gt6A4iW?=
 =?us-ascii?Q?igi5JMkEa7OR69bIGyRyB6VlrfxIjOAGRIEyXWH9X5e37eVD9hqc2llanssn?=
 =?us-ascii?Q?MDSO3RurIAwZWKBsnlRofDsPR5d3zfTuzrExw/RRYj1XrzAdVt2oWjzfCG5w?=
 =?us-ascii?Q?/R+1Fey8DMx29Uf5QyGEf612+bGjs8NJe/HePgKEGBT3fakq4PbDBerf0Mqw?=
 =?us-ascii?Q?b9IGjL41uOBE6/RTt0+XFhjewcMyqvQr9YFblWpFTeLIe3qgeKiagVR/ehqY?=
 =?us-ascii?Q?qlut8qC8sLYqER59Mj3d01qdIsLUb/sAaIeajFyWItbadTDj5BbQ2NxWLG0z?=
 =?us-ascii?Q?RK2fv06PcQl8nypVD5A7D1W9KO75hMFK54BUxT0rOxbUdrYpi9VDb+MT/Bdp?=
 =?us-ascii?Q?r2EyT6zlMxMYLRnomJ+zWoQUDuycEXfT0jncJEkGNsqN6ch5oyd7qBKHfQ88?=
 =?us-ascii?Q?1j1DmFv/JglfOfinJyxEplJcp5gZZpZc49/Dw3oWZK3P/v+xKP2QvUWeTS1S?=
 =?us-ascii?Q?2cI9zsjGTksbZ7UVQ6d5Lx90SUMC+M+pwR5J5Lj1+BslGjv9etDsxIuFCt3m?=
 =?us-ascii?Q?yV/wWOcGFdM+bhnksCGZJ7gZBJbNtvk+/jUok8Z9rT+k8qEMPR52cti6SFDd?=
 =?us-ascii?Q?UeQAJcBWPNXrvJQfdLm/Ys2+7Sc4n/4T1snpxdiH7gVN23qICaECPh4GsM2h?=
 =?us-ascii?Q?NClSSR1UxbQw9uG3H4IsFuFSuZklYkp/1dxlbD1r8r7Vsqh8lLh4FPymFJow?=
 =?us-ascii?Q?jUXm08qdQAwsvVHxVH0AM9hBwgpg5vzoqOodFqGPafggMHunZjTjH+Q2S8Ny?=
 =?us-ascii?Q?/QkM4ciJpdl46JPuOxbSTG2M+wvCxZlb0yAA7m48Lg3swbZUvKasHG+BwtzQ?=
 =?us-ascii?Q?tJaNUVxR0fo/8UN3incv4uJN6CBXAcgC9M+8oIG3OOwQkJSchj0L4/eV4BON?=
 =?us-ascii?Q?edZ5O3oLL1w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GhN6ruiv0VvCaa3/zpltxhFgBhl24KYxR9C49DxxaGCI2XHWqUnDgRiQo13l?=
 =?us-ascii?Q?b5B32nvKdOgAdS8k5GW5GRTshtOXhifBLi7bviIMWFYVRCaDsGBKVsVkGKGx?=
 =?us-ascii?Q?Lz4TSRPzjAmJaEB7LgsZnSCkfMxzmh0fo2XYAGfyZmCfbURu3atow3nVTCDb?=
 =?us-ascii?Q?NurK3n6w5Q+NrO8oZMqUDMMFkx9WIvy4KkvkFhIEMGPhgo3DrL/1oOvxobrd?=
 =?us-ascii?Q?1Qk7LSjY376+8N5msgsnBehbiCmtHKBdNWgKAYjiAQfhOof5qAkefvIOwZw0?=
 =?us-ascii?Q?B3pS3VAHrCj3W/ogXYlNBNhyBak1smJt+Kjae+GhaaiU4vlhAUM2B2Ujnn5J?=
 =?us-ascii?Q?ybOnxr0a7Pc0nCInL7b5K+FOBHslQYLd3hrLyNRsN185iailUnTN8cOrKYmB?=
 =?us-ascii?Q?/xucf7PCY81i1+PzJicjFMQWk1xR4En2RZKRG9lm8ycpNt7SacxgwoAi/LCs?=
 =?us-ascii?Q?DjRfv7GG2GRJ0taUVn79JlVbJDGtK1NnVxBiBEjmq5N8hMARbk+ESsjCWGcj?=
 =?us-ascii?Q?2RZxmZPBiZl8VDtprCoP/WOctfmIRiabH5wNVLxpG8iGwJOAdkEfw5K7paNM?=
 =?us-ascii?Q?maS8JKq0CA4lxthnJFQBQL1fvaIJX6LHyRcHQsXHXPP6PhHeVEYlw+uaRW2W?=
 =?us-ascii?Q?pmTBs05JmOPtjDymX8w5iPUJJNms/1KM81IR6cxomKpzbdKk/3GoB8wWzC3e?=
 =?us-ascii?Q?OFoH3KeDVBamItbrUTkoadeOHgOzao4YHjwFTHsZ7K3TaZ9l0iOnjN7lE5Rj?=
 =?us-ascii?Q?q0lbJ3f5qANeS241M7X3vjhvd4+Kvuw3egD9v/8EZITk4oqjuhbOu4iP4wpZ?=
 =?us-ascii?Q?dAHNWDTSz1glMkkETElgFYl/ApmoX/bYtjDOC9aRliPyMcLxCj+K6Eb9goEa?=
 =?us-ascii?Q?yoU3uM1BTCMYlwibtAOXbhWzQkS8C5o2A9jdMDdwaAfTU2S8uFC5Rbe2Ws3f?=
 =?us-ascii?Q?AD/VYG4hv0dO743N+42FB9mTp+wKVbtWDP17HXwfnLMNw32Y9fG0mKmWd2x2?=
 =?us-ascii?Q?Y7k+DdGOmPAOAGkBZYxc5citGmRJEJwnbRC3SeC0vPu78HP99Q0+xqMv4644?=
 =?us-ascii?Q?9twm73vSGf3o8xRfzO95DEozjmEi8pvjE/P8MLjgRpv7wGvT7Xu7HgA1Pxe+?=
 =?us-ascii?Q?2+XBluy0jy4cISWG5WrHPiLiKErsc5wYuufO3TMsVk/PEBGJvJkHxdXvHwoR?=
 =?us-ascii?Q?6sanTKVMchQilWTItZkIE9a05z9CBwdeM4XNrjy0k3qEAFycIfO8AUN/rP3Y?=
 =?us-ascii?Q?HRsFmzMaqG5AJL8apfKzjmJD1E2d2RSqv9E/06I6ZV29neinp8xRFYP6GWqR?=
 =?us-ascii?Q?pyflVhP6baQ3Ucb29vCNtqQB2KOSDVXIaYzP7MrbgpxghDKCDicupbMM0sTs?=
 =?us-ascii?Q?VK5CpkJuSuVmm97c725fcbxpzXZM5issZK3wMN43sT7EzsHhQ5i+D6vUc0MP?=
 =?us-ascii?Q?Lu46CyZc+IsC2n8/X5jPVBoV/iHrN0ecQjVLKniQ8GZH7KvbClxoGW3k5rTr?=
 =?us-ascii?Q?QmwIQ8pWfokbQwJaTqQtC6iQ6v4segtWKFHX8Z0M+D4D4J8x3H64RgA6NK5d?=
 =?us-ascii?Q?JgCREbMMlu49u+DvtJGgHvyupJd9umOP0QGsPflUKhfCXi8ZeeHaV+dD9wS7?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R2THRXJTZAtTecFz7ZXcS7IftF8mEHaYumEqcVi0h/0exsgGMuGP8C7BYSJc/R/Gq92kczFos6zhUYfx5uOR8zVtsrooOuXQNJaFbhjdQJRa8k/bdEcPKfCI1UPIIQLMEQRxI6FUmWmXfxYl67qaFYoG/mMsyIb/uLBBLid5nibpEQQqdGNNOwon6HVjaLnKjsh38Tf7Vz/cA9sVPvrq5nxooqeTITiaiJeAnbbhm8ViUg+TCLidaAGRtTPzjsZqA8BMyrcvVKetN69u011wmCC7GcFGM3N3uT+NEJnNWygYDWvxlHYWnwdhRQp05eAogHDttgPWsaovkk8SBbGhiMsCM2LXnpk76ohnH4nKU/07kZoulQEyZ3u6oCnGfVMV8ZUOtKr6L+Udxz5bR9QUheNYq40ruub1+Z5HMbV7qyfWqVWx2qe+kTx1nsSVlLdRg5J6Oe+RImKXaUqyDJpDc1xNrAT/ZFNhjMO0jOYgK7CPbj8RrRRYLBJ6teSjGSugiqUz+8SYw93YzlEcEf0b2m2PRDgBdgPMW14Z5Yq6AATuhOby744l+id8SHjGCtphCmWOC6sywmCJYel5MX4+fsNV6pqzYddsalXikqBdCSo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f714298-345d-4b99-b251-08ddc48f8da4
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 17:38:19.2811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Af+uw+tlk9+giqbR7nuF+3lDoiztlWA6f7IVlVFjWXlC2HKVhhpYnbuOWV+ZEBBApUJIVOBwJdfdyEXMUH79smjgGHHNOj6qgTOBE4yfaAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_03,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160159
X-Proofpoint-ORIG-GUID: dSAkxn4s17WI9irqZbN9D9cQgjOQIcrK
X-Authority-Analysis: v=2.4 cv=AZGxH2XG c=1 sm=1 tr=0 ts=6877e39b cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=rBchI7fqkL5diFtp90sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE1OCBTYWx0ZWRfXyjB9pSzmV2vV 5vz1l8W+Dx0PMyQdebSZdS9KKhoYDbUrvgQb9QcOtfuGizvNMceJ1J5e/F9aBYc2uxXCppO1kTQ 9jnKhO31mJk50XB1Sxl5qcl/Qi58fggsqeZrrToBcWQMCVNl3fBrl4rjDvt+RKcWm1tcmlf8dRg
 rDjq5vnJ7gnhjwARiCmYX5uUobyN6G3NvU/q/v9r1RxG9FEdA7VZyyCFv+e9/NMR8bVXStN+qne OfQa782JDIasiKvTT22zDPYoPuvMAVbtsgspH0F/fxzkIuBV97cDyPsfOXnVCviA0APaPV3qogz xM6VsU/mw5fLzxh3p5r8GD0E5LBdZooAZBLQdyAbViES2RsIAz1wNQ3Rq83yYuymcWRqsVC7q+y
 b5shENLqQR7w+eYPnG3T7RyibzhXMcNFqaDtWQcwhXq0qczVb7MLwrHWP2ATQdqwKttQhKzI
X-Proofpoint-GUID: dSAkxn4s17WI9irqZbN9D9cQgjOQIcrK

Perform a number of cleanups to the mseal logic. Firstly, VM_SEALED is
treated differently from every other VMA flag, it really doesn't make sense
to do this, so we start by making this consistent with everything else.

Next we place the madvise logic where it belongs - in mm/madvise.c. It
really makes no sense to abstract this elsewhere. In doing so, we go to
great lengths to explain very clearly the previously very confusing logic
as to what sealed mappings are impacted here.

In doing so, we fix an existing logical oversight - previously we permitted
an madvise() discard operation for a sealed, read-only MAP_PRIVATE
file-backed mapping.

However this is incorrect. To see why consider:

1. A MAP_PRIVATE R/W file-backed mapping is established.
2. The mapping is written to, which backs it with anonymous memory.
3. The mapping is mprotect()'d read-only.
4. The mapping is mseal()'d.

At this point you have data that, once sealed, a user cannot alter, but a
discard operation can unrecoverably remove. This contradicts the semantics
of mseal(), so should not be permitted.

We then abstract out and explain the 'are there are any gaps in this range
in the mm?' check being performed as a prerequisite to mseal being
performed.

Finally, we simplify the actual mseal logic which is really quite
straightforward.


v3:
* Propagated more tags, thanks everyone!
* Updated 5/5 to assign curr_start in a smarter way as per Liam. Adjust
  code to more sensibly handle already-sealed case at the same time.
* Updated 4/5 to not move range_contains_unmapped() for better diff.
* Renamed can_modify_vma() to vma_is_sealed() and inverted the logic - this
  is far clearer than the nebulous 'can modify VMA'.

v2:
* Propagated tags, thanks everyone!
* Updated can_madvise_modify() to a more logical order re: the checks
  performed, as per David.
* Replaced vma_is_anonymous() check (which was, in the original code, a
  vma->vm_file or vma->vm_ops check) with a vma->vm_flags & VM_SHARED
  check - to explicitly check for shared mappings vs private to preclude
  MAP_PRIVATE-mapping file-baked mappings, as per David.
* Made range_contains_unmapped() static and placed in mm/mseal.c to avoid
  encouraging any other internal users towards this rather silly pattern,
  as per Pedro and Liam.
https://lore.kernel.org/all/cover.1752586090.git.lorenzo.stoakes@oracle.com/

v1:
https://lore.kernel.org/all/cover.1752497324.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (5):
  mm/mseal: always define VM_SEALED
  mm/mseal: update madvise() logic
  mm/mseal: small cleanups
  mm/mseal: Simplify and rename VMA gap check
  mm/mseal: rework mseal apply logic

 include/linux/mm.h                      |   6 +-
 mm/madvise.c                            |  63 +++++++++-
 mm/mprotect.c                           |   2 +-
 mm/mremap.c                             |   2 +-
 mm/mseal.c                              | 157 +++++-------------------
 mm/vma.c                                |   4 +-
 mm/vma.h                                |  27 +---
 tools/testing/selftests/mm/mseal_test.c |   3 +-
 tools/testing/vma/vma_internal.h        |   6 +-
 9 files changed, 107 insertions(+), 163 deletions(-)

--
2.50.1

