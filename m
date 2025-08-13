Return-Path: <linux-kernel+bounces-766246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E766B2444D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829321AA3534
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6792EE29B;
	Wed, 13 Aug 2025 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e3sTJ9+T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Mg75NRNc"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6C32ED179
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073644; cv=fail; b=kV/LcfdfHZrq5iXh7l/EXtjYNjdWa+4dIhz51RlGAnFl7MgL8Tgiea7CGgLLpLESSqcQqSq1tC1c7jgzVNxu9PlhpwiZMnmFFptKd55ExZ9zG2zOdocDeAqIiKoUus45jssd9T3ErBVGiZaIob/dFiXiMdwgS7hB5+BGR+eP82E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073644; c=relaxed/simple;
	bh=ldhIPJSNt1mhws4gQ6BDiqQ/OwwYpgh9b97TIUJCwxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lg6hoRFh5W7m91YwfwVNr3xRZlnaji6MgEW6q5zL08RtMUTYBVAaRRJ8IFNirgubm1NBGPmyjE8WzVlSNLBJ9tBbinHQFOa6aT3ckhFqBlyUDxCMTjSYAvrAs7+gWFb54TkXpfguYken2bNqueJ/z6RbBpN4lZC6gYFJ0PTvQTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e3sTJ9+T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Mg75NRNc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6u6k8001280;
	Wed, 13 Aug 2025 08:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=C4ObAVMKaVRCgq61or
	9SHBC0AHU4PoVOMMkjjVO4od4=; b=e3sTJ9+T8qDIFuzHWeF9ZS2F/b6CY0Lsm2
	g7O5hOqq4DR/yUuhncZ25cAyPc7zDUinz5GFkCuhfQCjbfGfUBkqNyIPKwo1GuCh
	bbyx5dW/ZsPZ8DB1xPx4pBOyn+p9SSOipnYx/Dp0uGP0Gy4kmQ/VGv1lEeFO70lg
	16IG43tQJKXimZe5xreG6Twy25feXXQXRxzrQozfGGJrPJ+zEhliU6hw67VWE5r1
	qscwyzZ3uKhgMFjPnsO+ays2SOhoSxHt3M5fGxeXgI79Fy/948KkaVfekNkv80Yk
	+SI9s4KbSzoGslgMvaDUwLUajWSdIMNvS3bMeCm5mm47BA9wuiOw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxvwxqye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 08:27:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57D7tXOm038611;
	Wed, 13 Aug 2025 08:27:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvshn126-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 08:27:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=or4dbGHQTAyhEWYFvsyR9UcEIq1Fuc4ulcyBEG9EV+vTYtTMk+Y9bzaOROS+NArB8HZsBxQiuEox7u6g5SJ3yvYECbIdYlMnSHh8ubXe+A3FjtnRb5ZawWCjWlLp2chaEPhv6mC0Yx7Pi9q8C4tsYkMMHfPqotgYY1jPyEyKOMMkU/uAGJ2YuU0cfzLy4p19C89eCkIIGc8hy0tzQOWoToG42ejHlxr2pVV/IPvAyJHig1xJyRgM3USaDISuVdpzCtfhd3axvJKU3UGS2yLWv6ai67T0YvomBYrtZ1vNfKjvyUB7QopZshJy30ef9XP0e9yTTdqQi9iPy3XtFGK/fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4ObAVMKaVRCgq61or9SHBC0AHU4PoVOMMkjjVO4od4=;
 b=v8gpq/0aO9CnLpAzhrOdAZwOFM4DV8K/zDlj6bubiT0SuFAiVG+HXa7uHYkapq9qgPVJPgvm4rCm2jyfECNq6z1aJtv/uMTGlyFAkwgn2U7sgkZHkUB4qOQfOcPteHS79DOtZ0Y68OKU1Ct46/BMCc/hZcMYWZsnCOUU07N8e1nTQ5SYfKzmaMWAmwKZa4mr/GSZtJYxc70C6NrOMBwCiyWplykwKvApplGFdFN9BNP8YIhCW3DEd1p9rt2Ey2thGvuYFvQTZRMvaf6I8OJn/71yu4Aq9wmTqF5cGnLkBoRyQM2BcIlylpyfNlbowQPVpKGqT9YzHTLJ0ljjz7WKig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4ObAVMKaVRCgq61or9SHBC0AHU4PoVOMMkjjVO4od4=;
 b=Mg75NRNc5sGphE2jtTlE0ChssK/YskT/u2qF77KImeMZDChvVI5E7GjeqELiZJJtYNyFe6aaUl9hPYmx6GnIpA5p6wQ2FEBgSrQ/C/k/rUzSN9gytDBz6F24f4WnMtvG9omhX/JvKSzkY6F5BGXX60Zp9puE5FodhLbSPaLyNWU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BL3PR10MB6089.namprd10.prod.outlook.com (2603:10b6:208:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 08:27:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 08:27:07 +0000
Date: Wed, 13 Aug 2025 09:27:02 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linuxfoundation.org, mingo@kernel.org, namhyung@kernel.org,
        acme@redhat.com, kees@kernel.org
Subject: Re: [PATCH v3 06/15] perf: Move common code into both rb and aux
 branches
Message-ID: <e43b91c2-3139-488e-b7f6-0c715afa43c1@lucifer.local>
References: <20250812103858.234850285@infradead.org>
 <20250812104019.016252852@infradead.org>
 <9982e7b3-1046-4da1-9569-52bffe71c9e6@lucifer.local>
 <20250813082524.GJ4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813082524.GJ4067720@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: AM9P250CA0001.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BL3PR10MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d54fe12-8927-4b38-0b32-08ddda4330e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v3dcB84t2xOMcw22DQrltcojAkGYtVo+wC0rGPFKDV6L+wDkg5Zvlxhrq1ff?=
 =?us-ascii?Q?mJ7fWgjtZkyL2pYnL8NJwFdYq53v5KqNYTBeIJJqHzGaqY9pbvr9lEI3ZuEv?=
 =?us-ascii?Q?xEvFeaRgx3TOi9W0QEwxF1gQP6KzjHoCy3S2ekE9PBb7+8HFUGgjui/KDin3?=
 =?us-ascii?Q?p5QtgfOVhYFuOoCNhcvfjT7jaQS37KabB4wQ8uht83FFNuV/SE8Z7T4b7hiw?=
 =?us-ascii?Q?HSUmVRNfXzq2sLffyriDbqVvu0k817En+KKjsni79+epWtqYrmUyCmW9cmgx?=
 =?us-ascii?Q?39vC1L/Sm/l7coMGxooVheojyukzhZABRzBNyW1bUQtCoxCTG3y/00ZqNYic?=
 =?us-ascii?Q?MF50W2e3kkzkH7b9M7JsqGZOLVNLSyvyfqyiFq+7P71HgjF8VXVaB8Q4JYJM?=
 =?us-ascii?Q?s1amTON5SysEhd2vk0a/N3WlFmw9HYBx97CnE3MfOAPiKiNyDX/i/EaFeos8?=
 =?us-ascii?Q?yKpPez3ovekZT7IGksn4VMgfLUn2Q/rgQXnomJjZJ07ZZa3lxNrZ4pOgJJgX?=
 =?us-ascii?Q?ZPUmKDJYMStjFGZBWL8NClkTJxwiGwvgHalz+uzElBEoA3GYgv9wfbMu3asS?=
 =?us-ascii?Q?fPlwIRNh+dzcsWv3zlk3Wjb/EdZv6kgY9o5ilgV7/YKM0X2d/1Hv1ogDAa5M?=
 =?us-ascii?Q?XXCXyigYW6aMkUE3onwaF5XWWu3gIfXSLkKx4IxmTBX1NNWmxJMspfh8Vz5I?=
 =?us-ascii?Q?Bz4GKkTahHiFOwNRQ1U8zgsUsDD/oRktg02GhRRwYCibGSH1tGhg/12q0x7a?=
 =?us-ascii?Q?sA979QUdSZvg+4TUwjnromlVanSzxKCbZB98bgeRjx53ZTTVgKG3gGqLzi1Y?=
 =?us-ascii?Q?HNqchhi4lQjEN7/h8hYOiTrUcscjFAIGE1clCREI6Ib/WW9lrqEJlSHqJ8ER?=
 =?us-ascii?Q?qwTtA5FBDEt0aH9P1dx0dmaaRr/yw6+jt26goS23gOkPw5VaOlPrSbxy3Z++?=
 =?us-ascii?Q?M26YwpjRm9xPIzaKlu7k1ToQVAo0TvdcoUkTh1rHAO0HolXzdIvGKB0Nv+1t?=
 =?us-ascii?Q?OjIaMhHou4OzWEX2zwD5L2br1lDJZXDe+DCMIb/AJ+TVwJnWKJlCYozVepaQ?=
 =?us-ascii?Q?mrnw2UZfKjzm5zNiHuxJCJg92ciWtP9Co4wYUFHkSuLEGLn5VVTGS56rEnPl?=
 =?us-ascii?Q?LMTOBCTF5MOrMMkzMntthKyoa4tArkrGiFTPUEUgUOSq4/xlGAa2Cgo2hVXt?=
 =?us-ascii?Q?PkNYkYFC+d12J1Yt/hsZ/DrK4/Q/QCx2K+UBeg6Fb7OigAM9hMVlX6hu/wqn?=
 =?us-ascii?Q?WUvlvEZi40H1t/GVUx25kg8t0vGRAgBjyOQrsyhXF84k3eRk3llQkEyZiXeY?=
 =?us-ascii?Q?HY02n9QHLw8rySOphdMc7lIfCtce59hGgckiOnUueq70oAxegNQxL19ZsOAI?=
 =?us-ascii?Q?7vUaitSacQho0HJo4EodF9EzsKxLJxt+SemI3Rx2vG7yNoslVQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f/IAdrWGFv6UjK2mcSZnrIRxHshsJQU4Znqj0m+DzdFLWHwdAVgfF/OhVeyY?=
 =?us-ascii?Q?6K9TFqq+XdbR3lZEosSjQICfsN6kCe4xAhSjvQW4Dbhh8j7j3kiCx+E0gwOk?=
 =?us-ascii?Q?uI+kuSSSRJ1DKCbwOtEDfCA9qb37le1p8dhOCrJuJdLrvN40g83CBTDc3OfJ?=
 =?us-ascii?Q?QMvXTz+qgWSEsbJRGuH/xLtj11RU3dGOP3yfbtzRYtkKv7QX/wE3lrE92I+E?=
 =?us-ascii?Q?aGYUPCvKCb+Evy6DzyITOGCZDtKPi7DDQXs0KqXDiNb+hx32XITozxHssy/K?=
 =?us-ascii?Q?g1qu8YVl4/Vb73bY9q8Tqy143k077ll2q8Mk8mpOQime+Iq8QYzbvsZ0Ncyl?=
 =?us-ascii?Q?9U8Hl5A3VTjzyrLieyViInc/EUJn4sBx2yCxlc+eFgrqdAk3RqwRns8XL6F+?=
 =?us-ascii?Q?I7waPhP6psVOSN3TP5cH5M9ha1qA+rlc0YY1n/dYAWySjOAZE2JrEwllAV5D?=
 =?us-ascii?Q?fqrTcZrdDt2HT9zAFMKe96DF8ljgVCqUZtAKbXYmV4Fq3+uZU0NNNco0NMh1?=
 =?us-ascii?Q?8IqIb9iTmIaODeCo+aADxo3AkV1NMgZLYzMabnDaTdizXyPa6kcLE0ZzHn+Y?=
 =?us-ascii?Q?uw0JvVmScfv4XLWUqbcnt2TvetHp5Ma+ubgsp4u+n3NWE2KkyErpJmKn7Ktf?=
 =?us-ascii?Q?UMyYwnzvdFLsocaRFkd6V7Xlh+icdoiy3nhYl7s7VoJz+KeDTLD0tntdSPEa?=
 =?us-ascii?Q?s/k987a6nHV1FYMY5hIpjE1L5Cgzh6C7ceH7wg4CweDoqNZycNVm25jYHhDz?=
 =?us-ascii?Q?KM660lqD5nYopJdt5fsN9zj7xawNPzbVdxLWb+SKvVhu+jS6PR8zrP/CQRWB?=
 =?us-ascii?Q?LtXonA7ow+1DsC/qladrPBaJ3wuaozMcpZE8JuthDoWkTMGQU8ZKUhvAJ6x3?=
 =?us-ascii?Q?/swnMXoA6/oeRjWLjwcoyMClemlV5uzfSQq3HcGOwwNYUG5eR/k+TYuT8PNw?=
 =?us-ascii?Q?FB7dtW4WaUjEbaoS0mKe7cKPImJaaOmcd1RRgliTpZjFyM5tBg7CEatN85Xx?=
 =?us-ascii?Q?6ZyA+F/P7qZa/iIwC4Ot0NPoyEN06ZyM1K5YbOavNvqPaMIUq762DuDDjzzE?=
 =?us-ascii?Q?d8Hw1r4uyDwxL9O0iJW+W1bVWZWjGNq+iQlmlO7xJrEPptb1ELS7OrPP7CtH?=
 =?us-ascii?Q?LOpxWRynsrrsNFA6aEG3gc9Sf52dOFOzc3Dd+iV3B8FMaUkl/H/If3jM+26z?=
 =?us-ascii?Q?7dUQ64MCXKRWM6LCZGsIPeuLimO+Z+PgYU2RzozDNZlSKcd0rMi4aWsvjG83?=
 =?us-ascii?Q?3lktEDWduafH+wjJ9DOfCudJjA4ZEsrVP+bW6hdVXNzXTzR996ySgCPTtkv2?=
 =?us-ascii?Q?CeOYak3VufHeb0m8oSHhRqzGcVzqA8o5fmSxoBing/YaPYBDQs1Kz23hzBEV?=
 =?us-ascii?Q?GLxrYRyfHYYdKBi8EvFYxKUlaDgD8Whyj7t0bWGa15GQXAoDMMSdOyxvmRSq?=
 =?us-ascii?Q?g+yMlEnZROZMns9WlTLsObWC5m4I90iEq11MO6sC2TOCJ9mMAuf1Fsp5zTVd?=
 =?us-ascii?Q?9Hgd3sH/0D6joO85rRsUTmmeYlLJKfDN/DestGj8cXgQn2e8LqpPOglYWL1h?=
 =?us-ascii?Q?p2M4kgRHAetWUmsx//TC+oTs5frD5qcoJBjPgQV8st5iL6q7MhwGAibrZlq2?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DKkTJGYFL8fAcesoH3a+EWgn+0ZpXm1NvgXCsOJmKXNBIgNSJcVP0xPim29vVALJ/UuR6xUPbXznUPI46jLND45qJEE4ivehqCy5K1BQTTR6gSymtRwBg5f/6juUHWMRA9TmhMnFNREayZ7HuVlexyNsxd9d6jI0xx6vLafZWYQKjNC3ZEZY4euJL7KFYFkuB3Pu2dVTgXct70YKzy2RcRaQRdvm+FhUH8W8rWrX+mCUdWEgoaUof4hnAyW1wWICjvzaG5PvVN2oFKNNYPzs1JgiUHtbu2H7PF5LMO2GWfzWF2lacxyIjwPlJVk+qv1yLXhHSFsalg7kW4kyFuU6rzsQP5ojzmz3KTKW32LUjXM4iVIxeJ6sdSYbmeXjlMc4ay87AYEzGwoMQ8FJuOMIcX+lL2h2Q+S/gzTgx9mD1r8K7AcB9JCjDOH09K0IxxQsk+034YZQUrQ23bn5rhRkA87C/z4+kAWdmbWSwxUux+AMQDbRMx3UmRWggZluzz1HjNb6LNh3BYEuMkxz1rqXUPCgvChyGXM8AanUr+kdvaXdehm4qMDW4U0SgmdEJ6OwVONHVHL1Kt/vQqfjZ9tRYKg3sf3YyduFEM1BenbxL4s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d54fe12-8927-4b38-0b32-08ddda4330e0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 08:27:07.4804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhYWnVNSvb7MIoOGP1rJukWOgh46O8HsKAIbH8jI5KKuX6iQjEjWlxpfKhtlK2gl3ABW3ahiNGxXmbuBq6onQQbc+Eloxn7GgsKLF9eF15k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508130081
X-Proofpoint-GUID: J6_1FCIERDkjkTksi8WTMlhbh7P9EleN
X-Proofpoint-ORIG-GUID: J6_1FCIERDkjkTksi8WTMlhbh7P9EleN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA4MSBTYWx0ZWRfX+4nRRy5Zrl6g
 7BsMdMnqqug51fHz+J6HzggMR1IMNbcqdpoxaKip+cTlg08hVHhe1D19tWYStpTO9tydNz5uWjl
 VJZTgZxV4Nuoz8nvxbkyS/wW/gqwaiGKE30iovP5eFe4rsejA7URDu/IH235tLgx2LmmXqbHXyF
 48jJC4g1tQ9TatLbcLrIBUVgHBEbG47nkJ3LZ2FpC1j8pq8aglKqxNfFmasjcsOBOPdFWaGeTHm
 zCboIQsmzNjyx0boA5m1VTCG0dzlo6aKALjcN7asOU28E6h/Bg+QdozJ9kq6peWK0hX2gN8JfbQ
 Ls+pUGP5+RxEDB2OIbpgL65aC9vnASXPdoc3rCbQUASVIUs0ky0o/gfmtM+Ud50oQ9ufM+sYmVh
 aoErpJOwBCrQz0tkrLiMkJpbDhWeR9c3eizcPmkBIqGUqY0WmyH4AVFQ2cCdHOjjGjd7p2ky
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=689c4c5f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=JfrnYn6hAAAA:8
 a=KvC1prXJRCIfktJlXKAA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf
 awl=host:12070

On Wed, Aug 13, 2025 at 10:25:24AM +0200, Peter Zijlstra wrote:
> On Wed, Aug 13, 2025 at 06:55:51AM +0100, Lorenzo Stoakes wrote:
> > On Tue, Aug 12, 2025 at 12:39:04PM +0200, Peter Zijlstra wrote:
> > >   if (cond) {
> > >     A;
> > >   } else {
> > >     B;
> > >   }
> > >   C;
> > >
> > > into
> > >
> > >   if (cond) {
> > >     A;
> > >     C;
> > >   } else {
> > >     B;
> > >     C;
> > >   }
> > >
> >
> > Hm we're doing more than that here though, we're refactoring other stuff at
> > the same time.
> >
> > I guess you're speaking broad strokes here, but maybe worth mentioniing the
> > tricksy hobbitses around the rb_has_aux() bit.
>
> Does something like so clarify:
>
> Notably C has a success branch and both A and B have two places for
> success. For A (rb case), duplicate the success case because later
> patches will result in them no longer being identical. For B (aux
> case), share using goto (cleaned up later).

Sounds great, thanks!

>
> > Anyway LGTM so:
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> > > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  kernel/events/core.c |   25 +++++++++++++++----------
> > >  1 file changed, 15 insertions(+), 10 deletions(-)

[snip]

> > > @@ -7142,20 +7148,19 @@ static int perf_mmap(struct file *file,
> > >
> > >  		ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
> > >  				   event->attr.aux_watermark, flags);
> > > -		if (!ret) {
> > > -			atomic_set(&rb->aux_mmap_count, 1);
> > > -			rb->aux_mmap_locked = extra;
> > > +		if (ret) {
> >
> > You dropped the 'AUX allocation failed' comment here, but honestly I think
> > that's fine, it's pretty obvious that's the case given the literal previous
> > line is you trying the AUX allocation... :)
>
> Yes that :-)

:)

