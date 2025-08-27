Return-Path: <linux-kernel+bounces-787644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0831AB3790E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 06:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A773B3BDF4C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0BB285050;
	Wed, 27 Aug 2025 04:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DGLLRJMU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tjl58uvu"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BEB25557
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756268761; cv=fail; b=t9XkXbFzREUO0qXkQ1QS5CzrdU54v1vGwIEINT2jaWPQ7LxwCrpV+0ZINLqQQ4DW4dKQMi70I881cYF5CgcaSc0a3XZsFl28VSmlfAHRuNNmQuDf11YjO/4z5IlU5HRSoC0RBsG95qfjzbyCSKC+sdEzAG7ZBEu/VCJadR2CgpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756268761; c=relaxed/simple;
	bh=+A0Zaun0Hj9IjXNNbm3uKE3R+AKyeXfrhL3QfUsA8fg=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d8BXfNPIFTpvGdVHKNpjoGwMWPkzlfk+vcbWZ6RIuRrxDWUEUJzNtUbslpSoWGlYnyy4F59wfmJ90rCfNBE+PaDc9Cz24m8tFQbYA+hIywlGkGLSS2ul/FwQgG0k1U9U8WhWAf7XhprbrRELzSNXPnxlaGqabN/mUZMSPh3M4u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DGLLRJMU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tjl58uvu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QLLnxc003260;
	Wed, 27 Aug 2025 04:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=MYpyf75vBBY9MT0R5I
	TobHRivbHWqDcyZfKNeby9JLM=; b=DGLLRJMUtdhHhNp2fUJygOKxcHzhK5AYM2
	PUFBH1VrYXaE6jAO6qEscDN5jfhi2FAeZiFG+mzhYufpq+h++tH0J+4EoO5UnWFW
	Ux95vhpj7a0C6d4iIY86lfPrN8ne1ZcYhyTsA8f6ALojTUHM1fIjxsxdW30eDYgJ
	vFLZON4JEqvyGkddWzvCPYo7IDgLLZlWvSgEq2boYHqf/CSyhNvXw42vZtXxYD6H
	RHp2LcxmAv10lWya+oUcsBoYN3lYST+hHYlSk6vz463EiAHXsknFQ7QRN9pyoMSN
	rtsKvAq44yVCF1dRH0j/twnNu5awVX2KfcfvlhRUNyi4VKCNLkOg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4e25tdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 04:25:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57R3rtY2005044;
	Wed, 27 Aug 2025 04:25:39 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48qj8ajbu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 04:25:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRGdni4yMJ7qYSEo3owEAn5u90Nue5FiBuXmhOyWV/1mciEGduRFLKMMs2iX+QFwuTW6NBsxF/kVLvoALVAnXVwWfx7Ktoov9xTrWCxwWkbqEY81nRO3JUfeM5AeUdKXtJ9DNayBC6NcDjPgk+JJsSuEYTK2obN3BD29FnN4w/BO9GRSI/II3+4tmdeRAfvHg7SApT9pL/uEurEef8Qg5khJxSVUCXI5lsi0jpMuR+D/4JL7Ig7R/llKrU/ba3EQz/JKsqbXa5nIgu13GOaJcM6o6tNvK4nnleAvK/4zgnquaGBAuVanO16mG/VU/Qn8TLWQBm6KwdRymHJ02dBIVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYpyf75vBBY9MT0R5ITobHRivbHWqDcyZfKNeby9JLM=;
 b=kS+TOk+2+1VaJlT2laJ7UkWM1Rye2zDx2FGRJHyjmD/MwC1oszHvkNxcrwjHGrReIjTkDNqiwm+zVDeEY8I2FkQNAij6Tgefe2uwfFg6aYHol0P7BE9KdLCyoazZpAtp2b3fW3/9XfUhHbbyD22kAaM7qg0fxu5aT0yoAWuiugcKCPnT8HqpeQs4qFgaiyaECGZgZT+zoqwbYRlz9toxiV/66WebXPNMlxaSx3E67U4oOGqQND0oKUC9465+qM4tnPE/1fO8irpioNvCtQwLUyEdC+bXKrvNgMNcz9iK/zVXFj8sQKrKed0DP5vZlb6+tTCyE7RRz0A67HYWNDeD8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYpyf75vBBY9MT0R5ITobHRivbHWqDcyZfKNeby9JLM=;
 b=tjl58uvuM86rV9iE/DD66XdKqCXix/+kFYuh9LcXE0wTJjyydGPPMnfuMGIPXlNOXpwxJX0dJIHBO7CEId4WgBGVXpZ5155Y1wU6/As1elfPL4G45bpF/mXXQGZnv6sWCzhxodhZ8Tq8/a1PFuxn1klGhc7OpOv4ewtleGqrq90=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DM4PR10MB7403.namprd10.prod.outlook.com (2603:10b6:8:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 04:25:37 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 04:25:37 +0000
Date: Wed, 27 Aug 2025 00:25:33 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        zhongjinji <zhongjinji@honor.com>, mhocko@suse.com,
        rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, liulu.liu@honor.com,
        feng.han@honor.com, "surenb@google.com" <surenb@google.com>
Subject: Re: [PATCH v5 2/2] mm/oom_kill: Have the OOM reaper and exit_mmap()
 traverse the maple tree in opposite order
Message-ID: <z2hc7mdhwyxiv5whchw4ky62ni26upybxqogcuthi7mbiy5nug@rtfjsmyvsjlo>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	zhongjinji <zhongjinji@honor.com>, mhocko@suse.com, rientjes@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, 
	liulu.liu@honor.com, feng.han@honor.com, "surenb@google.com" <surenb@google.com>
References: <20250825133855.30229-1-zhongjinji@honor.com>
 <20250825133855.30229-3-zhongjinji@honor.com>
 <002da86b-4be7-41a1-bb14-0853297c2828@lucifer.local>
 <nwh7gegmvoisbxlsfwslobpbqku376uxdj2z32owkbftvozt3x@4dfet73fh2yy>
 <bcabe7cb-d09c-4789-ae39-407b2e0653da@lucifer.local>
 <ip7al6pv3nm54raaptrxq3v4t7cpilqgppkezowzn2sfbjax65@qt72zuotrwnw>
 <oogiwonpxtqurkad7rt2zxc3ffgeujtilivno3ibcybzucsliw@ym7jm6r5kdil>
 <6cqsibtttohay7ucs4ncmq6nf7xndtyvc4635i2e5ygjsppua6@7iwkgpp245jf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cqsibtttohay7ucs4ncmq6nf7xndtyvc4635i2e5ygjsppua6@7iwkgpp245jf>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: MW2PR2101CA0029.namprd21.prod.outlook.com
 (2603:10b6:302:1::42) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DM4PR10MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 363dee9c-0ff1-4a6b-1373-08dde521c5bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|921020|7053199007|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XbT0QN64Ur04khfxYKxhG6nV4Xje7L092nVpKj1pEoIDAHWWb5AQDya1XIbc?=
 =?us-ascii?Q?4X6q60yk+z6C5J+zb18NMhWR0eAWf0xdxJQFGioTpskXD0fy19dMsgcJ72G3?=
 =?us-ascii?Q?Cs7m5RE7OOo1nxOnh5vmu+KBfRYzG44SrCzjqhK4DKprbHHevXOl68fM1MPd?=
 =?us-ascii?Q?D6vB3DA5SqdSBd/1Iptw+qLDBTVlB35BHwQiDsXFiIc5kOWtvVYVwaLfZMvM?=
 =?us-ascii?Q?VAvMjK3BHyTgwxf2x/QLOtgBGvKISkBSUw8LpOiMn2N+a1ZIW3RRTMFAkj+M?=
 =?us-ascii?Q?NRfejts95FM4sGU4loabuAoQBKTsxdcsl5l4XdSU+h8unVGI/8QOgJ/UmR/t?=
 =?us-ascii?Q?kgs0MXJ6gPxkARdqRYuzUHHS0ei65PLoIW/GB57TlPID8U1qWXpzr2qAYsQT?=
 =?us-ascii?Q?o/yeCoJQf8MGYVPFfITSIHGouBgiyS9VY+p6faERWvkJ5j+3SJjn0vLHGQmg?=
 =?us-ascii?Q?tLK6k4UJ9vhd0DlBJMMoWanpWvmrLMe7kL6VHQzVcW7KfbrOaBatuIX/zwpq?=
 =?us-ascii?Q?S7HxSOpH/zaL6pVj0PhyHadXFI5o2dTeAw57/zWlbd4ZaAWIMQG8rpRtasew?=
 =?us-ascii?Q?DCmzPWLoIAsujF/SryWhu/FbF2gUa+TwYbzuUHvBLpFbRC4w0MRtklFGyY/Q?=
 =?us-ascii?Q?X2RmazowhZjVBgz7bACjYre28VsvAZn93xVUBSOFhgDMUwN0+LB9c/watiUp?=
 =?us-ascii?Q?WkxZX/ptYIYuS3P42SdlwlYQY0i3K232ZQ5RzLSIyGNG4eLkdHYXWPhpYQIA?=
 =?us-ascii?Q?kYsU027+DFrP8taugw63TrWQra9pHKJQxAQLn39Um6a+kD1VNs4jLviTz9bN?=
 =?us-ascii?Q?WQyOVPJdmRPpUY88lP/y1B00BRqV/j7bhjedLEEWzq7xCz3X6IxYty+Honra?=
 =?us-ascii?Q?AVAPI/Ix2NRd/2j+6TjEiJC52kmQwcEZK0Xe1Rl96pEjnCLoatbvwZFG/YGx?=
 =?us-ascii?Q?kVWIz37t1aZNgLko2RsapPLEyAZsRJcraHJmCuVU/zafFaNdOvTpR3/TfL6y?=
 =?us-ascii?Q?be04fbGBhThHlfCYRwP1On3IK0Q+6YCcjRg1EhzBZ2cW4a+cdCySbY0M+n03?=
 =?us-ascii?Q?CxknaQL44+jPukB6r7WhTvd8x1sBbKNKuZZDcooO65bM+mfC60jgLiysoyiU?=
 =?us-ascii?Q?mh06lllin9tlJRvvwCjASisb83nyIHFDUdKR+zo0SUmvpBzMnKa+yeLfAEj5?=
 =?us-ascii?Q?e3N1r8wgCsq7yEmzUGdFj3YxpVkI/veae4NGBdxlLb8simU8zolHdcA8b3EM?=
 =?us-ascii?Q?wtHEi0LW3i+oJqvUQ06e/U1jhA0lZVe6apzHHNZdNUVM+eHHC/7Bolei10gg?=
 =?us-ascii?Q?/PAkr3axusJAb6S91FsthFo14DvPq/dzoUFWdsYgk9UFMq2CdkMp11fjWojI?=
 =?us-ascii?Q?pX3X06ToSU6rCySJrwGNkwyxoP5rbnM5Yry5j84aL8TtdMwNP9Wc6/Gi5mO8?=
 =?us-ascii?Q?FmUzwHFSULm7Joi49ohjwnAuGt+zAPAG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(921020)(7053199007)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DaPNJ4pHDU9/BldS009AcE727Lihct13HWhSoXUzc+e+ekqMshIsesJ4pFDX?=
 =?us-ascii?Q?BEvUV9nKRIMJ0/LJA5ztlxd8Qy0r8WZ4AgAfC4H0FkFZ7X9nMslOO0UXhs/F?=
 =?us-ascii?Q?lVHVEvKbzIPHsoQMaBB6JIEZN+I7CdDOkpTAr6C/0xCpq9FaautlU9LB5v/8?=
 =?us-ascii?Q?fhxrx4HrVuRU/irVsBxFegxRfP9SVAuvmomvvZE0rfl3/wlivWeHCL6Ezkfk?=
 =?us-ascii?Q?C5oi2eFD9nK9UYN2ElqGvMmTtjEx5KBchggJmh1UiNBFQFITAeLMMZaWwXRv?=
 =?us-ascii?Q?dJDWJHavLChoFuyOfNQBXGY5NhTQ9npsHJNUXgW2VdOH+QTbPDEGxuL2ysx+?=
 =?us-ascii?Q?VHVNW6VLFZwDAQ99ieTbrpYR4rWDoE3wNNUCQLkgke4owlDbovKBmR3p0nRb?=
 =?us-ascii?Q?CTHqwxluJKLNjuICFLa3NMLvf4P0cN+vnZy+YOuD09uFKPlDk8pJ1QDyjIhL?=
 =?us-ascii?Q?/uMFdJXoh2bkgRC2k8VWHi49rdZy/mI3CCr4Y+kXybsbTmqW3c/Ip+BaVd+6?=
 =?us-ascii?Q?8sAu1V7sd1yaVqyoYrzHsjGN8GK7/bC0VBciMiwo6kqznsAz/GEU/LfC2ctb?=
 =?us-ascii?Q?FreyR5Kszbf0lKBZ98j2sRV9/rjJgfj2XalU1yN4BRJ7NjafKjCQDD7ZFMQ3?=
 =?us-ascii?Q?3Rlj5IHVLpBlfugqgZlVo0p0VuDy8E1RYifJ+9gDK8yYrjblGCx1TnrhPyzA?=
 =?us-ascii?Q?D7dRg8jaKf7Q+YaTlaMoCIW+H6ddF++5vCj+N/6KRFaVJrFs2lftatMHtbU3?=
 =?us-ascii?Q?mNGghta5EFmwockrfyQFZinO9SeFBsJE8Pw0s+DNIriAclf2wkEKEPWiordr?=
 =?us-ascii?Q?MPCXSOoJzjdGO1tEZHuo/TVdxWRr7YEnUWel4ng7sHwzJfFQG0vCSWfMMmxI?=
 =?us-ascii?Q?Mz1WLoFhnKoPEm9saOGPQAtsOqihCUYTHDvFlF2NpOk+1K+Yr9QjMlGM+PJ7?=
 =?us-ascii?Q?WV7tCqGYcY1jteW70csKG2Ijfkw+06SCdj3uiF+ikCsV4Trl/LXzIHx4vQGd?=
 =?us-ascii?Q?JZiKTK1weviaM7lzYItOhnTphWJ9/319fLyob41R3GjOFICecRi9sRRd6VAs?=
 =?us-ascii?Q?0Tr8LMbfNHhntNTkuohuMR2LfBDEqGPzp4MeN68RMuTv1vZpDo/fTErpkUdh?=
 =?us-ascii?Q?g7pSQybDoDbhcBC6/407ftXnXE+6coDzpYN9xlgDe1GaHlg9yg4/XgBrgsGO?=
 =?us-ascii?Q?yt0F5k/insEQkefwAxSqCNEL33I56D3EqqshOJtIyJn00SgelchnaBUS5xGd?=
 =?us-ascii?Q?0beYj9yOt0VT8oMKEe7ql6Ttq3Z9FnWuzvyPObY8eZMZJ7A/ISEYpwtgS9Pk?=
 =?us-ascii?Q?uGSjOYKiE7F602Ox5Y0EQDF5oCaTJL+lk8ukT5ePyN1kmohpMQMiKLEFfy28?=
 =?us-ascii?Q?g9Jk87WR+qHO5S5WuxMKgvL/RV73LXLkyByGar71Sl1+l9p/ZYnqGbCc2LFX?=
 =?us-ascii?Q?FAgcF9V70mCAuxRLDk7yGlmozhBzcXUqZKnPEBIMya0u7A1YZgvJJkRGz5ot?=
 =?us-ascii?Q?RSt0ri5EkWdOpAauUAGT6orFTKxWLsgEM0TiirXFjd+fDwIUp8izn4Tul7vS?=
 =?us-ascii?Q?az+hs538BrKUjkqH4ucmkKDTxKrRKNrIBU3OEqLo6sHBxLcEtN/fPSoTRjQ/?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FOVjUxw5qmo4k+avz22zG2W5FEUysTpfdkeQQoLC4Y+eAV6Wu/BW5KLfxbPV+5I7zZk7GBTsqVAvtYk5JHXb525JhHnR6KizwrSh3oqw6Ui6Oiw/+mgtNT1orETPGHgVgFyPJSKOGZNqIIVD7DEraqCLYMRbpWNFX+OsX49fUSpzciEsLGScofV0WS/JMJUHhQvv6M29YLSoh6WmjdMoijH4u4GYi3p2z31BNlxfiK3SmGOPJjX98jloLCLmyJDDst9hb1q11MsHDhg/P3suSN57gcxMn+Fd6WejmJAVi9vWQe0k8syXR3uBe8P4A3rZB9JOaojlSaHOnTLbQJJ427J7iXaofXfEcAw9NRhBFy51+vd+LjCv+S5xezTdfV5GuyczktJwsv6NNJlgyijCqUN1E0BFcolRpduMgvbSrtxWg4nsarkozoyzLs9/Ir/UeMq5lhUfa3rpy/49h85NR/VrzUjznRG4TANTbOwWRfF5akFMfAoFXsxmXmQ4tF+VsafpXMYtxeOq+LrIphL/4ICoX/anUwun/4WJNTPosLYV4IbYWTAUb1tifiGzBtI/0r36r7j77zmhy341fudcNqo+OPX0uuHdRkdQnYU79T4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 363dee9c-0ff1-4a6b-1373-08dde521c5bd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 04:25:37.2562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fyL1xpflNPPUAFzWuEKnPT94zqNviC56bv65yfJVUKETTmmCQ5J4yHNrIJC+4TUdFlKftHekdtIQc9GQ/D9KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7403
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508270033
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNyBTYWx0ZWRfXyEoKRjOBowBv
 9fHP+vElPhhyUmhJcucBuqTGr8cYVfYPMxCQc2yBlNRYaqZnCtQwism/U/PxflrR+48q0DXKSQO
 etAcJ5Z4E7lu3iAtEZRneuxRVZ4/Cs4yRqH2ONSl9fA509S348H4kdEfzU5Rs2KfTLlDfuHB6y4
 RN8nsRZrnvgz7cSPo2g6w1Chj3/2nEjJH7DwkCrqISdSatM3rpLh99QHcEr0QupqwxH25H60Y9j
 Lf10peqg7gdhpSvp3qiCpqERu57wISPUv+3P5/Kynpi2bvd/5wmYKjo5woXW7NMZt/OqMJPc0wJ
 17PmsdfXGsrjXAToOp3LPcGPbnmBwBPDTWMdieBS83w/+G0y7ieeauArfAsP06SAX8cwaGFFqlU
 lzkisJenVhX0+n+n4ENSatkgGadJMg==
X-Proofpoint-ORIG-GUID: oVl2UFIT87n1GyIJGH0vA4IFHOWI1Znq
X-Proofpoint-GUID: oVl2UFIT87n1GyIJGH0vA4IFHOWI1Znq
X-Authority-Analysis: v=2.4 cv=IauHWXqa c=1 sm=1 tr=0 ts=68ae88c4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=P-IC7800AAAA:8 a=yPCof4ZbAAAA:8
 a=3_caJKcdmu7Sg6cojqkA:9 a=CjuIK1q_8ugA:10 a=d3PnA9EDa4IxuAV0gXij:22 cc=ntf
 awl=host:12068

..actually add Suren this time.

* Liam R. Howlett <Liam.Howlett@oracle.com> [250827 00:12]:
> + Cc Suren since he has worked on the exit_mmap() path a lot.
> 
> * Shakeel Butt <shakeel.butt@linux.dev> [250826 18:26]:
> > On Tue, Aug 26, 2025 at 11:21:13AM -0400, Liam R. Howlett wrote:
> > > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250826 09:50]:
> > > > On Tue, Aug 26, 2025 at 09:37:22AM -0400, Liam R. Howlett wrote:
> > > > > I really don't think this is worth doing.  We're avoiding a race between
> > > > > oom and a task unmap - the MMF bits should be used to avoid this race -
> > > > > or at least mitigate it.
> > > > 
> > > > Yes for sure, as explored at length in previous discussions this feels like
> > > > we're papering over cracks here.
> > > > 
> > > > _However_, I'm sort of ok with a minimalistic fix that solves the proximate
> > > > issue even if it is that, as long as it doesn't cause issues in doing so.
> > > > 
> > > > So this is my take on the below and why I'm open to it!
> > > > 
> > > > >
> > > > > They are probably both under the read lock, but considering how rare it
> > > > > would be, would a racy flag check be enough - it is hardly critical to
> > > > > get right.  Either would reduce the probability.
> > > > 
> > > > Zongjinji - I'm stil not sure that you've really indicated _why_ you're
> > > > seeing such a tight and unusual race. Presumably some truly massive number
> > > > of tasks being OOM'd and unmapping but... yeah that seems odd anyway.
> > > > 
> > > > But again, if we can safely fix this in a way that doesn't hurt stuff too
> > > > much I'm ok with it (of course, these are famous last words in the kernel
> > > > often...!)
> > > > 
> > > > Liam - are you open to a solution on the basis above, or do you feel we
> > > > ought simply to fix the underlying issue here?
> > > 
> > > At least this is a benign race. 
> > 
> > Is this really a race or rather a contention? IIUC exit_mmap and the oom
> > reaper are trying to unmap the address space of the oom-killed process
> > and can compete on page table locks. If both are running concurrently on
> > two cpus then the contention can continue for whole address space and
> > can slow down the actual memory freeing. Making oom reaper traverse in
> > opposite direction can drastically reduce the contention and faster
> > memory freeing.
> 
> It is two readers of the vma tree racing to lock the page tables for
> each vma, so I guess you can see it as contention as well.. but since
> the pte is a split lock, I see it as racing through vmas to see who hits
> which lock first.  The smart money is on the oom killer as it skips some
> vmas :)
> 
> If it were just contention, then the loop direction wouldn't matter..
> but I do see your point.
> 
> > > I'd think using MMF_ to reduce the race
> > > would achieve the same goal with less risk - which is why I bring it up.
> > > 
> > 
> > With MMF_ flag, are you suggesting oom reaper to skip the unmapping of
> > the oom-killed process?
> 
> Yes, specifically move the MMF_OOM_SKIP flag to earlier in the exit
> path to reduce the possibility of the race/contention.
> 
> > 
> > > Really, both methods should be low risk, so I'm fine with either way.
> > > 
> > > But I am interested in hearing how this race is happening enough to
> > > necessitate a fix.  Reversing the iterator is a one-spot fix - if this
> > > happens elsewhere then we're out of options.  Using the MMF_ flags is
> > > more of a scalable fix, if it achieves the same results.
> > 
> > On the question of if this is a rare situaion and worth the patch. I
> > would say this scenario is not that rare particularly on low memory
> > devices and on highly utilized overcommitted systems. Memory pressure
> > and oom-kills are norm on such systems. The point of oom reaper is to
> > bring the system out of the oom situation quickly and having two cpus
> > unmapping the oom-killed process can potentially bring the system out of
> > oom situation faster.
> 
> The exit_mmap() path used to run the oom reaper if it was an oom victim,
> until recently [1].  The part that makes me nervous is the exit_mmap()
> call to mmu_notifier_release(mm), while the oom reaper uses an
> mmu_notifier.  I am not sure if there is an issue in ordering on any of
> the platforms of such things.  Or the associated cost of the calls.
> 
> I mean, it's already pretty crazy that we have this in the exit:
> mmap_read_lock()
>    tlb_gather_mmu_fullmm()
>      unmap vmas..
> mmap_read_unlock()
> mmap_write_lock()
>    tlb_finish_mmu()..
> 
> So not only do we now have two tasks iterating over the vmas, but we
> also have mmu notifiers and tlb calls happening across the ranges..  At
> least doing all the work on a single cpu means that the hardware view is
> consistent.  But I don't see this being worse than a forward race?
> 
> As it is written here, we'll have one CPU working in one direction while
> the other works in the other, until both hit the end of the VMAs.  Only
> when both tasks stop iterating the vmas can the exit continue since it
> requires the write lock.
> 
> So the tlb_finish_mmu() in exit_mmap() will always be called after
> tlb_finish_mmu() on each individual vma has run in the
> __oom_reap_task_mm() context (when the race happens).
> 
> There is also a window here, between the exit_mmap() dropping the read
> lock, setting MMF_OOM_SKIP, and taking the lock - where the oom killer
> will iterate through a list of vmas with zero memory to free and delay
> the task exiting.  That is, wasting cpu and stopping the memory
> associated with the mm_struct (vmas and such) from being freed.
> 
> I'm also not sure on the cpu cache effects of what we are doing and how
> much that would play into the speedup.  My guess is that it's
> insignificant compared to the time we spend under the pte, but we have
> no numbers to go on.
> 
> So I'd like to know how likely the simultaneous runs are and if there is
> a measurable gain?
> 
> I agree, that at face value, two cpus should be able to split the work..
> but I don't know about the notifier or the holding up the mm_struct
> associated memory.  And it could slow things down by holding up an
> exiting task.
> 
> > 
> > I think the patch (with your suggestions) is simple enough and I don't
> > see any risk in including it.
> > 
> 
> Actually, the more I look at this, the worse I feel about it..  Am I
> overreacting?
> 
> Thanks,
> Liam
> 
> [1] https://elixir.bootlin.com/linux/v6.0.19/source/mm/mmap.c#L3085
> 

