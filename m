Return-Path: <linux-kernel+bounces-732754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B909B06BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 04:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6312B1AA6D09
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 02:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15643274B30;
	Wed, 16 Jul 2025 02:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jGRyjUwQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j0hyTT/X"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749AA1CFBA
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752633632; cv=fail; b=kjm76GFzMX8xjrHCRrJo0pOaRH3Qj6qq6j7bIyrIl21TOIKCizysLSbGVu2nFSZODB1UB1YmnKEY9SWsq1IVUsBg6gjZGm0KoJanq0yFPY/asJqaVy4YBs4WQDn74uq1sdWi9l8p7HtRJ9olQUAbDA9tf12FY9EOekr1eoLBebU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752633632; c=relaxed/simple;
	bh=RXQVZUro/ewjpxzANYjBrzoCO7eWoQ+c7PBI9dOHFOg=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=GyO8nco5VZcqkVmwA+asytqQoVPKx8Dd7p03GYU/e9hpeWiJsARQyOKZZQVdnlttW6+MP0TK5whTsv8bGIHhuMH31+4sj1PnogBkIN3kfD3a2xKMuJHT25BMkgvxWLM7vRxN3E4WUnP1opma53B3/EguvueIu5ctgKD38y1rG8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jGRyjUwQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j0hyTT/X; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G0fpxM009604;
	Wed, 16 Jul 2025 02:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=RXQVZUro/ewjpxzANY
	jBrzoCO7eWoQ+c7PBI9dOHFOg=; b=jGRyjUwQjJm0wwJ4XH8Zn4Lfku30Yg8jcj
	oaZ8U07zPm8EpjcI5U0NbZNgj+awDQZXsZDn/snzlsKb8S1WUPqXmwbIkbLTm0ui
	NZFtZMfeUI08XqiDmll0N2zU6Ko0L9R9yj6nnAI9msvql8Q7Tfd46PISmAGhwpTu
	BJv+IGL+I4ozV9/T7yOdgIAY8TQh6R4hDPZCmnWsewQJY6bFGYDHZY2g6NJ10iB5
	mvFK9GzLvKpJmz7xTauktpfqi0g5Kmm/WZD7ctAa6pOiuK8mfymPkCghG4XKxrzq
	Qh6kgcf6bQX9/p8+uAKyS8YRB8QVq4Qg/nm92mc0lBx4djJy8zAA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4qy8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 02:40:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56G1nNvO011826;
	Wed, 16 Jul 2025 02:40:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5aseab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 02:40:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvkSFzVSrNlk4zybQz/PhZ9Da2NZWCK97DKKPkz7cNuUKsFrcfF7oLyo2KxYbqg74fxjNhpuG5z989he5l6Wg3Jd+hcYTo6KGuFHjDe7jryJVs/HtrQ7aRHEKHkg5y6gzUZrnObTbuGYSej80kfbhasguoHDJaVXFzOzMhSGJZ0DzXPpEERHoVhdTK+s6yA4vfNTeZzCGvUZsJLz1WaghCRUq/qUPvrqbSTacynfO3U7R7I5ZoqhZSB1VNrbdxV3POmkTX/N2Ll5G7PEW3J+bYklEi6IcFZaNX9rvlHCLCnChUVy33RExVu+akhBvPE3HhK2Oodv+xrj0MWRo6k2Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXQVZUro/ewjpxzANYjBrzoCO7eWoQ+c7PBI9dOHFOg=;
 b=ucmw6kkw4xKxAeX6Oa0X7aXXEFcDzQTNbV+qCVkdXtsnO2cqHFjPML7VG+RXSddMFMU5B+N1ZDiNhD0haEOSz/xBtlZBQwU9ljLxemk2V0/I53iEQB5+ssIlybynVosU05TmYKBYGa6oFvT29DFroh3HKqfwKbNJI0V136Eu725JmNfY1L0bl79mOWZfAdjjmLTIcatxFa0Rq87JpVCRgboflvILGm2eHLUrGeymZHNy8Y5rdUTjKGPySKg7zQRQNzggHuhtVDHB/dvbgKWu1VzS+86jVhe9hu80b7zVJMqi8DOwLyUPS5q/7EH2IWVQtucAxMHQqhfwBPJchJS7yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXQVZUro/ewjpxzANYjBrzoCO7eWoQ+c7PBI9dOHFOg=;
 b=j0hyTT/XNYVm1Uwdm0kL0VmMxWN7IvCHueKA3VtXnhW9DPl5pzg7sZU0WCUh/rgC2gKJrSkR9Pco9Iw36wPbzExCJcez1DfeRsNEU8nt4eRJpP4+dHRgvTcPYHo6kygLUKC6+mI+Bpe5we/vIrTb+fZpAO/QN08OfgB8r9ym4vk=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB5899.namprd10.prod.outlook.com (2603:10b6:208:3d5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Wed, 16 Jul
 2025 02:40:06 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.033; Wed, 16 Jul 2025
 02:40:05 +0000
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-10-ankur.a.arora@oracle.com>
 <aHa3_9ijsm3FC6_8@google.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        david@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
        peterz@infradead.org, acme@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v5 09/14] perf bench mem: Add mmap() workloads
In-reply-to: <aHa3_9ijsm3FC6_8@google.com>
Date: Tue, 15 Jul 2025 19:40:04 -0700
Message-ID: <87zfd4j1tn.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:303:2b::7) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd5e869-c8f5-4d7c-9c30-08ddc41212a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8aH83mF6iZQ3icsC31FIRBo3QVlpkhad2chwJSdLBHPaRyIprbnPsi95gOsp?=
 =?us-ascii?Q?10Esy8rlkMODLeXTc8vN1i7RyAIyjZRgHnIv9XdRW3eyIcB/B1tdC4ZE5Bh4?=
 =?us-ascii?Q?eLdoCUwVp3+xDmSVTs6kVLKkYuFz9U53hau9rgo7v4F5uMmElXWvMKk+oYdu?=
 =?us-ascii?Q?L7LGQ2ksyyUQKX4lX2rSnHSZaYoP/aJirjJ3WfppMVVGRgWyNjqwo5VV7+Cz?=
 =?us-ascii?Q?65ew+jM9v0e0wJQsnIPrPuZJ48+Ut/za4q4ksv3GnsRaADsG5F6PUw/GRPjW?=
 =?us-ascii?Q?cXDmOq8V/CYr6CKkn6A2xlY8/HBx0NUfv8F+1TNGMGrpEY9P4aysvvJgyqUD?=
 =?us-ascii?Q?ghYF+1rTaAbk53ggwbcfEdrt/g2SlR1vaT5dWhh/lB4PyR1famvB6zXsx+G0?=
 =?us-ascii?Q?3vsYjiSJpF/L3ZobGmVsOr7thuFdWB4FowAp3V3qFwdwZ9WWi/HGzLHDNSDQ?=
 =?us-ascii?Q?teEATRmo+aPclsUX+NpyNjySiwzNZAKTgEs571X7pc22VlU+DJ7/EellHTnd?=
 =?us-ascii?Q?8bqOEjb/QHSwOXvX649PqupDkkGWXnI4NZuIFh3Fn4xSl2LQT83CpC6BxrF3?=
 =?us-ascii?Q?lxWw/kqeRDJEYB3Q5nEBjdcotCsSsYxPWG9EzHBI2j5GOGTNraklGxeo/5yK?=
 =?us-ascii?Q?QDdPt2kmNMpiZN7jM5d00zHc5E4WegXzMJWeknBky2pkGfY11EJ2FM8dCAZy?=
 =?us-ascii?Q?UXbQSwyVlTf7WB14+6BWPIt9m5MAoZL4lKkgR7gj56rlee5glaTUPDBaMa5H?=
 =?us-ascii?Q?FHzEAjR+Yq1DbKqx36hEmJFYbtYxojW10WnlpMa/DBCZvKxK8NBegSD7lcj5?=
 =?us-ascii?Q?KxetyzMhHndjDkoKgZt9xwFBQCnCb1GCVobVWlel5C7GNO69N7gvICvgDePT?=
 =?us-ascii?Q?JJ67cZ1df1ePsKbdT//pj/yq1z3sQ2kOJ/LNFv9s3FWoCIpY+H69D0JhMrty?=
 =?us-ascii?Q?vOkNFOSTn6uMmbsCFXtO5M0ELQFu6hgezL5FCKM7k2EsKk0YEne0VWyeueFr?=
 =?us-ascii?Q?UOC9VxZQ1eejOSrvqBd0Sv5bd9F2kOQ8rUbbWhRiFK0YXvG8Jx1woE6TFvQl?=
 =?us-ascii?Q?oH25zioiJwaywcGTyz6JFf1MBcUWJ2wW91Wm9w9oeTzM9+lEzb5l+1CqgKrB?=
 =?us-ascii?Q?6JkWZ5juT1tkyGQMVJaJPzF99EY4pcI/dg8VFu7nQUHfkt2T5ZG5C93yg95l?=
 =?us-ascii?Q?gEDfwK+jEYgd21eISIRNfprqVaMukwP+60n/l7ps/A5vigtZKSBYVU8g4096?=
 =?us-ascii?Q?XwooA1AoS6+gwm6u0OhUbMMwNZCr3Ladi3N3yNud/i+LB4EFlPMrLTyxBr4V?=
 =?us-ascii?Q?1Ldfac6RrJ897LvzjLlw1KI2swmRsNy7xNX9uSI81AZ3o37v9m6w3vq+Q1RA?=
 =?us-ascii?Q?d6rwhHufo3eA9SX5D+qdvyLTVPL1XNphv1iPz6VGFrB+avVbJlM5tOzH8KoI?=
 =?us-ascii?Q?W73b+pnN2Bg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0g1AnEe0yCxF5ZPiEXD5VR192mt1QkYvKnoIruLXQJgRk+P9ndhdz8gP+j+0?=
 =?us-ascii?Q?qC98RCfFCe81yogn9zvNXPoGuL0kW54Aj/9iKpcJnW7ZUT1xLGEndxrBus1J?=
 =?us-ascii?Q?75p7tQaQX3FUL993BA4QyYXEsNS7A/ybPUq7X6Bd9uFRjoqmB5PkMvSxldtT?=
 =?us-ascii?Q?j/i9vFp3a5kdRFQapG3IgTsFRB3GUdWnQ9Bgvjrap8/iUZgOUUmWX0JCwSE4?=
 =?us-ascii?Q?IJq+W03l/9hO+2YSwYOdtcRMmblpdFbg7casNQxzy7EwB5tSr9RJ8QPmmh0X?=
 =?us-ascii?Q?1HQN81sYHp0Icw7HWVuvXzGEVx6qpih/x9QXlxaAjNRyQFHeD+1PKCAXYrR/?=
 =?us-ascii?Q?XVcJQ29ZMx6bUJiv/vi9gB24elUxhxN8+p/0tsTcUuWV4W0lbdWYsufdsN/I?=
 =?us-ascii?Q?zkmiZqN93sfV2Oy4Wciyi2Wj4HbeTAkR7leod54/tp367QJ9GzkcIpH0X8wp?=
 =?us-ascii?Q?2ITm0/OBb+z1IW/+vnOCU8ccnf61gm16060TXiye119/j6RBFK3KQCMyORx0?=
 =?us-ascii?Q?BFKOJakgX35qY1gyGaYp5Gic5p5VQlhW6tSXu8DuAa2JunVa2Q9xpLZL70bB?=
 =?us-ascii?Q?UGj/t34y82H2RwpGqDhzTlNqgOTo+X3vqw5W/MLGupli44UaPnAvcS0g++fz?=
 =?us-ascii?Q?r5ABm7lNkaGewXspkG850CX8WczzIFjm2yTgX84/2XcbQyUkmKfX2HuxHIwN?=
 =?us-ascii?Q?kLqBWyw4LaszE8bs8qrXTPW91o9Rd/VpCbnc9CY83WXlvlbgHcU1/fhaq+Af?=
 =?us-ascii?Q?nD2EHFCxn0oWPtuJvTxSdbz8VwcMa0SwpCY929V/Dxrb+Sm3uN2bY0EeIuS3?=
 =?us-ascii?Q?PwUp/s6Gg1VCA6ghiyGdte62b6cqL6iDSB9QBJj1G+A5zpIrNkOQ2k3clvJs?=
 =?us-ascii?Q?Mft6GFBpZB16gr32mutDLhI+BFafXh1V7Wh0v83566ApBW0po/s2CIjVC11Y?=
 =?us-ascii?Q?RgPuUsmexmX7NG2TmSsAbO6zpg+nruB0y5NH0XgGbri/u/dGwVZA9iB5sv/R?=
 =?us-ascii?Q?1WrrnF4WOjWn6SliHh3efOmE2ruOT0EOa7G6k5JEnhFU+ryu/F0mzwViOkKh?=
 =?us-ascii?Q?gECe5lnuIp1x/uIumcgo8HIsuZoBiZFPSbGb2qCT6noftVvzQhERw9hxhEMD?=
 =?us-ascii?Q?vPPysbpYzmhzozB9jxz//UsMwbcC5euspnyEgKgJ45vZRWtW1lq1GQyLlbbI?=
 =?us-ascii?Q?yeXhm5cXg3G//Exq6hrNbNFfcWC5eWwg70hbL32+s3cOObT31Qm72342ADgP?=
 =?us-ascii?Q?jmniiJ0OcKsVUwbarJbYHHvxImbJtYTpwcrAP36pCCEVUiCRhVdt5U6RLos8?=
 =?us-ascii?Q?wyd4zgQiKUmRMRQ7wmyBQZDrq+E5hulzP/39/wLrJScZj7hmHyqk8k065sXO?=
 =?us-ascii?Q?K6yovCN5Y0Qy8xmtpBCYhJsC2jrbKkcW319eWC+0mmxblquDPjDjs/hsq3Qs?=
 =?us-ascii?Q?9c3Zwm6mZJy2R8ABq4M1mqj4ItykZkMvOWpOZuK+iP5PfSx1BwHt932hwmzC?=
 =?us-ascii?Q?Kmu01irO3lbRnTHtEXBryK6+RYe0KTLi38B/I4ywU4FspdkVatZHxnjyLS58?=
 =?us-ascii?Q?57g6DfxNj0Dmga0yC0O+gvx2O8dVc+NBVXk5aYC4vDldDDYs7Q8iy9tXN64K?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ay5hU0iQ7/IjXRoUm25FQ/Lz7NMTlg1cebkj92P3OLYLHOX8sNt90H6z0TyAcOYGSOpBhcWCJ5asvWv4q9p0NKjit856EnsCX0u+dw91T0n6E9liODyqhODCCSLd4ulnvinnHSPfZjh+J3lUjc63HPfP4+mXoVHQSWzvteCoz8xJtsxEPPawnZal60SHdEzAV4GxezLfwTCHTz4BD8XRU6tyirzyURyQSwtYChyiVSXA0wSo2j28G8JQiKZg+M8TOCBgtFXZHUSP/OVVR1msixnmoQ5+axDXJgqphp7Ija/Z/tKbvlcu05U7s+RY2xdiuMnhdKQqaOiHzKPXktSh1N6ZLHbBq2mj/OKo49u5WDb+AV++GNuuDVC/nZ8yczC5BYG/HnUiB/o9t4MtKdXLDgS4zKIqUYbOFQ9HZ+Yj0TKlyd6FmwMF9wvIktGZaq075u5EqlT7V/nhB0pjR1wvYm3+KPuAXchl8eqfJvif3M/c4IcNCTRLXR28Y58GZl7M86YyuaBKeO5Cx6cQc0EVhOvVJc+fge2hkaLUs5nOUML9UlwRS9/qFEgp58/N3dbCpTwwkFWnLt6PiGTMkYJPk4fafdfJMPkYoltZVj6w4NM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd5e869-c8f5-4d7c-9c30-08ddc41212a0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 02:40:05.9007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8Q17GQ+6CsgHNHfwSwT6HU9Bmt19ySCMmEPQbTXtMQoo/YfomzUF2B/81COkHK3wciiMkY4+U5cEY0ejPp6Cf2g0O35TQEKZgIle4PrYYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5899
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=935 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160023
X-Proofpoint-ORIG-GUID: qIiv_0AoadiKRppz_7Eqf1Q0xGlqNHj7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDAyMiBTYWx0ZWRfXxWkhRaCu3cE5 /IlOfYLksLxszHkGTl9cqunFbC20qod3EstFLuwcFsh7/btS6vQi+ME245bAEXuNLO9+YVUF5cu lDpxd7xhX5E3CclRfa+mpC7N03iI13Jvu5jUb+w7eOIaeuicgsDjItZ68jdH6PkHHr+5O58+q1V
 alZR4VYz4hulZrgpfvMsUPfFEi08Uu9tMqdap4jDC+B46nexOByTbzHtrSUVtV0tox+xMhUHGta CMDhlBd45zaIIVeIdYpC8P6FLwv4ONphL7j8gtaaLpa2xpcQQYZNlpiz5SkRDMJNj3HDlDxSVd4 4LJsHMH9PU4vlkO/XpOaB+5LAdHzC4plvYN3UpPkOoAdHL2maVlShCsuUShNnNNr+hoSdU4cgBf
 T/fB1tv1GOrBEk3z6al9MyjCZBargFoHqLdm+QwhwZwdXIL4MZwVpT7rub/mHLrNV9OAGyZW
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=6877110a b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=8EOdmaCDJJT60-FaLRQA:9 cc=ntf awl=host:12062
X-Proofpoint-GUID: qIiv_0AoadiKRppz_7Eqf1Q0xGlqNHj7


Namhyung Kim <namhyung@kernel.org> writes:

> On Wed, Jul 09, 2025 at 05:59:21PM -0700, Ankur Arora wrote:
>> Add two mmap() workloads: one that eagerly populates a region and
>> another that demand faults it in.
>>
>> The intent is to probe the memory subsytem performance incurred
>> by mmap().
>
> Maybe better to name 'mmap' as other tests named after the actual
> function.

That's true. My reason for not doing it was that these tests were
oriented towards testing the memory subsystem instead of the system
call itself.

But I guess "map" is not a good name either. Any suggestions?

> Also please update the documentation.

Will do.

Thanks
Ankur

