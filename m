Return-Path: <linux-kernel+bounces-762020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D39EBB20124
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7561189DF9D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9402D879D;
	Mon, 11 Aug 2025 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rimTH0Ud";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bSLcVis+"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150B32DAFCE
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899350; cv=fail; b=QDKluTjZHhtd+7CCLYAdGKpwtuAkyxBiw/tpFTiMizpEUj0mQJWBZ2xJSEX3fIFAtmBH+Ttl2HcSPvsTWZsCWFTjTH80yJwpSsiDYhD/peOHAkG6ip3P+9B1PF7aOB/hDfT1cuaP9YHLHOBz3+nlnG1xDU/2RRvSezVzQ9EgLYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899350; c=relaxed/simple;
	bh=dwuvczmub7WACiKRaBoDQPg9Xz4GKqrkZ57HwbAcGKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y6BUv+Bka08VfKAKhiukZubUfDepXkG6rKGJbH5FTtJG8BIQtVQ+yHW8y4hid7X5e/U7soE76tu6giriiA8PWpyAihtcZhhMtexh1zDyl0U3o7U073hBMeVVSTjHDbDQwX9qtq/gOf7/obcGkny4wvzho6+gs+9RcXjilNA3WGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rimTH0Ud; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bSLcVis+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B5uEBR028662;
	Mon, 11 Aug 2025 08:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=dwuvczmub7WACiKRaB
	oDQPg9Xz4GKqrkZ57HwbAcGKQ=; b=rimTH0UdxUsnPunNcCfFzrFyL2KvAFD4oX
	iuLsL1vpd0GegVHskTKmb8KEcW0QjSjenZyuy50xOqAB5rUSuWbXRte4dmDhKIKU
	DJvSjKmJACTLqGXEePQROMtO2P0tQOmOJUGj8Dbpw8EqubavOuJILy2jjAwzOGzw
	IHw+0dDgOAMmTXOrkETameP9fwigJqcK5SxLEH58zN6htXGFwmC+t+t4wyZkjBhC
	CZ4IsfJ73FoZWMoivLcp30UXDFgUPtQBf+IY+sSoIFn6S40ljdWqHr1WcijJO8qR
	qSXFajdJ4cFaF75b3H4a57K6S3q7x1Ae2iELwB4a2mhX7O4uOdtg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcf1xyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 08:02:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57B6f97l010451;
	Mon, 11 Aug 2025 08:02:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsekrv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 08:02:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+GKXgIentCrJ90DNoZpaswPQlfV0wkINYIwbi26UbF1sTMZ3QZUTiSLkNc8kerMu66aLoFFE9tWWzJiwYXMb8MElltOP3tThRT066jLCJg/FMyrXyYb/Lx8zRRigT2m5zSOJaZvLc/eZXvT7CoiH1CCKxXt4ivm0K56YcUEx3hoNSfWRp3F4daoZ7bYNpnDB0MdFuq0RvQ82nKW+BkrJ5oq6uuPIu9zXARB6F376T8PYvc9Zx3Q0ouwzbPNuAdnQmRGrp76742iL4N9OR+l1vPwhDua2ZV+1dHvSYC1mVhZEwWfc0lccw7gZOpVn0YHJz/lh5CUdxRe1MqABVXrdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwuvczmub7WACiKRaBoDQPg9Xz4GKqrkZ57HwbAcGKQ=;
 b=YKeZNqPMUzcGghJZngU8EmwSjmcoKHium4iHNyfVBTTnv7ohbnPFPdW2YDCjP4msykw+WQDKiOq7jf2YzsTppQSXXgzWWqKF+J0zRHwmeIrr9THLfA830b2CSpmtd5HgJrG9C3AWS9SLJde4jjrW3s9AXVU+RtEN9KugNex6xFgRxHEq6rRWyK0BAaLiK4SkrrmFK3kHCK8ff9l0T1YCJdf60rmMdGOMJA/UFaOozIpaBvtX0fZw9mpyXLHIeWVTmnUtkZNC36+V5ocfZSfX4RZZVbrBnIW6MQTRbqEXoi7Q1Jk8aMCcjsaBQDoMMKAh6caPPCBQXZQh9mrSllEzwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwuvczmub7WACiKRaBoDQPg9Xz4GKqrkZ57HwbAcGKQ=;
 b=bSLcVis+C4Oo90LADbHr/tLKog8Bs4IzXmbvKFssgXEgYTBZ238/lPgfq5yizebOlm/dyI88c28A2bXKaqEwrd/4/9yjz1jwfqvbgic36EsQlKV7/MiGTPm2WefsHlvapwSBaR9vhD/z5dQiXuUy9L2gC3oasBts3NCjAptYrH8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPFB6A054FAC.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7c5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 08:02:10 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 08:02:10 +0000
Date: Mon, 11 Aug 2025 09:02:07 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kees Cook <kees@kernel.org>
Subject: Re: [patch V2 m@/6] perf: Convert mmap() related reference counts to
 refcount_t
Message-ID: <bb8e896f-7385-47c5-97a6-bb80ea5ea153@lucifer.local>
References: <20250811065859.660930338@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811065859.660930338@linutronix.de>
X-ClientProxiedBy: MM0P280CA0090.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::8)
 To DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPFB6A054FAC:EE_
X-MS-Office365-Filtering-Correlation-Id: fd4f8d78-dda0-41f1-4c4a-08ddd8ad5fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ndr7wCKDC1jJQ9chbUTaclsjg31pz4kH8+wnZ9QZx3kQCkk8SOk9JiGt0tkW?=
 =?us-ascii?Q?SBAu2q9omGix220jtRefbXwaG35g4cjQAhSVYV9PeecHzSrBKSsaJKqGDbXt?=
 =?us-ascii?Q?Cy5PgQ064g8K0yTXPELST9N65/cfI/zvS6pj1adWPcB12zEEzWe3gJGV69Ut?=
 =?us-ascii?Q?5aJTwAhTLdkmDrltNTWg6ffVzlpaulaXQOi+t4ZapEEk97WwGGcd/P/0tQk8?=
 =?us-ascii?Q?w+TPT5WAvp7uSfSTGkkun4NaSx/7KZe20OrK7eJLuTxqU1qI276EJ1Rud3nF?=
 =?us-ascii?Q?l2z4FGSKRt3ufr5irqN55l812Iud1iqDUG+uDgJ1r0XRtuokpxnW1/VIr+y+?=
 =?us-ascii?Q?fHZ+1JZRqY67YWfYFB41o/PexJnwAu48zJU/dkuWk1ngw8CpMDcgN6Pv6BtK?=
 =?us-ascii?Q?U7ArvceDNncNotdncDK4wrxLpzbOCqRQhPfXVke4FE125DaMF1o6h3Dd1zLz?=
 =?us-ascii?Q?VnP8WilfJspIx2XjSsCQx7PNic2G6FaFOh3St1aMcN+oC2Jt5NT8wNh68OFc?=
 =?us-ascii?Q?nQbZbHtdGUMULZ8GsUC9yGQN/IG8Hn0LCli1e2AASZDWlAI1dpOqwsl8suGb?=
 =?us-ascii?Q?VzpsT2CHrdZphc9jTci4Tt+8VrQzjdb0DkjeinSD6mHbikQCWaPE7/YQ+snC?=
 =?us-ascii?Q?s797QdIgCFcMJZaeHRpXLaKIQtbcMU/v3AuCNlbiw5LDZXVRYwog5n4heX35?=
 =?us-ascii?Q?9BN7xyc5KKHurIQvJaXEdzkwnK5Kxz0FBkSs2gk+vRDdx/7haC/UETu84H+q?=
 =?us-ascii?Q?Ekhja7kc+GtWnlvDjVkqCEZnjKVsLvRxCAXkcvH/oHGAiFUA0SXumkvUymcB?=
 =?us-ascii?Q?c1knRW4t+g6sq38WReUVBPC/Z//GUlWzwBMh76Iw0yA4ArHeJITO569EdMkl?=
 =?us-ascii?Q?Y3lGUvANaeLNvH8O9cMPID0w7yyl86HvT96jxIL6wyQwieHX8U+laVZ8N4pX?=
 =?us-ascii?Q?kvZnc7b7+aw5ihXR3yOUa3tq6DI0GCNgIErGKFRoNrpVxWmuUIuYkClQR8AW?=
 =?us-ascii?Q?AfMyNT28lsOqMht4CJpzireyl7cR9i9OC0wMkg/Y490+nIc+F/M8oRHtGxhV?=
 =?us-ascii?Q?pux6L8f024Aix/za2pXPnK/eR6a9b78f63/QPT4AZUwgfiT6zkYjjdMtWA7D?=
 =?us-ascii?Q?TDN4L2vTuLgebBfCsjoOB/jiPfR6am/TkA8btWePVYjpMYeddPnSDOJ66vB0?=
 =?us-ascii?Q?IHKFnz4Urv6wqw4trj9xUxsYjf4LYnPe00FfWxEhtkXlgWQKWdRhQ/7UqBXG?=
 =?us-ascii?Q?iSm+YCCULhUoEOj9NycJns986DT9zw5VSOw8UWbzPWvDgD4rCHhv6PL5b4Kr?=
 =?us-ascii?Q?jd437amLKZSg9rrauAcngPvdC1igNjUuSnR4pcCcfoIdtualuVx2L6LTukVX?=
 =?us-ascii?Q?1nIx33FBASeh0HSMRW4C3oPnLb5gQm2OggXX1dw5FEKsv83+FQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FdpGj0X+PLidHzjYAl00jrzYSyQcd6nwiSrt7bpVAfrVHlIyQ64HpJT1NO+j?=
 =?us-ascii?Q?DA1YQogQAJH+AlcpTrBBQairI04S2Hn1lCx7dhHlot22JLDRSdgTA8HYLlXi?=
 =?us-ascii?Q?i3anZYf2+/Bbut1Ros3QM+NQdTSaSMJKPiXkgn9/0NQs6kQOn2flTfWVGFp1?=
 =?us-ascii?Q?Y2m6O9d5zEtbHeeSSSiPmojbpyi7P58JrhTkfbaphTbpZnU5qsjPBFuk2yWz?=
 =?us-ascii?Q?+fGl8hYRuHcfiVfUaQBRb6dIrwSxgwvBBzyIKgWtSNkyes1G8GUwXaVToOqB?=
 =?us-ascii?Q?6bOj7lODxww+AzcPqqlyK6v35ZQI02qLsoGuVegcqG9mGD+bu2KnkBIYXly6?=
 =?us-ascii?Q?kiZjFs+BrWFmKt9KELsGvDfmhbOXnjHFM+YuNBmscMhF+GSyCKA+KaWRlJP2?=
 =?us-ascii?Q?hSxkw2/lMBVVrYSPnWDWsQWgP0urvHBAOg89RyW3YmEYv65XxGLvx/Bzzcj/?=
 =?us-ascii?Q?izhD8j/F6sy9o4ck1tCiloUhmSnoPT08JOsU4MZ6z/aI3zD3EJt+kk7kfhBs?=
 =?us-ascii?Q?GQP1zz8Edus9DOHtl5xZw1ic6cXt0OfWo6hp1rWCSk2fj+0btTVu/++lzpwx?=
 =?us-ascii?Q?KsUwZ48InnHqYzhzbmGQwcaGzeSyTuj3C0dIrbzxnHmegyY5L6+JKO8YNQiV?=
 =?us-ascii?Q?Toc0vMnHsuqNRrRK3kRhK25iyHjG6eydqljntYNRXt2hPM/1Odx8FN6wHXOZ?=
 =?us-ascii?Q?U1psi2HthRabQKC2LkvZBO4/1ZrKscAFUCUOfJXNrXPc3gDU/0xA1XLS4Iji?=
 =?us-ascii?Q?fyWHw/M7aFX4HfLlEkW+HzIyMXCbHZwsPSgE7j4ovjkDgiehYHFr0azld22X?=
 =?us-ascii?Q?Pu3aP74eETUhCCsg6dDbpr2AhL2mvkt03MSnsMGfGbuuEe6Zfimp4AwupKpq?=
 =?us-ascii?Q?OBs2amUtXPa/J8xAabapgzC2Ge/OuP/NEpMlEiYnJwfIkmkaxEDGtLTs9wgC?=
 =?us-ascii?Q?lTZdK/kk43twCmBLIkmbtz2YLgZQMq76AeRfSgLTtm7/PXVVF8Dkm3Qx34eM?=
 =?us-ascii?Q?LBuSnobnL9CRispG52zVN9LHubmGNJrz/t71CAzb270uhIT6HYJdPtamTJMf?=
 =?us-ascii?Q?uEd8URMhi8s5r8n+jHjx4b+4nXcPRVFKibufGiVxchzTRKudrH7UYK1RLT7b?=
 =?us-ascii?Q?jPDOj3tQrcHYx05NsYVBQqpgm6Q/YOHH6IyRTAy+BWcscX+5WqcWR9LSECJa?=
 =?us-ascii?Q?+14Y5Cq/oAeCoK9Y/6Uas4kxsr011HfndBh/0/Q6fYjx2DkOF1KzybFQoduF?=
 =?us-ascii?Q?jH4Dtc5OUeIs3f2dArHF6OuCavvVau9I97l6xAecl+MNybz3XN89V8i+ZuEU?=
 =?us-ascii?Q?Ne8C2revBV8UJ5h1jWki5V4e+ZBUeM6ncgVZ0xQebGEta76lJwQtJNNIDED9?=
 =?us-ascii?Q?0iIQ+wY0bZfXNK1xjfifO43TBdhCUIn+R1s8vGuCaqv8MYJIX3moZucyMBJ1?=
 =?us-ascii?Q?I3P+kUPmVjm9fhUNoLNj77N2Ud3ejJeAmkWoUyUO7fmshfuObyE1jnhlNMbR?=
 =?us-ascii?Q?NYH0iwuJ7giaaXCqJOuyOAbglg2iMigHbrTMsSlzJU05HS8WYEB77WTyGiLY?=
 =?us-ascii?Q?atHR+oKnXNv3wVhU7sLAAet5yweRs5IYL27+8AO4PX8zJId9xyxvIQcud4hM?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WRkB5Z16BDXwL0SW9nDRR71rD7f8qG/TRoVk4JBwOIZlg0nWivyY1+HB+Z/OinWN8jUDriUWF+7xC07gwZ0N0qs+mS5c/1n5aksPkfXt84nbP3REvJaZFzgV8syU/C6Knx8OzOXM1828PiuiXrCVtmvN/nWb1DRoe6i+9vx1NDaBGlHEOLhKT0IrN7jjirV7hnR8fH3U8VEUWDOzPLyfP9MM2nzK+ijn/042bRUx8qRbRwKLv0kbeOfldVNm/upEGepY3j/WwULpjlNART7UcFh4Q4Y8cX9ta7HLgmC2FABmEgReATJgeFwcRxyoiU87A6L9jMiWjMhNSlbKGly39HeQ18d7CXJd/pFTYda34RTo2Y6Ab3xU0dnKTxuktjwvbDebCc3q9xeTZeMInBh8AztLWxjafPyCvmCZsTRYcwJtzg+MCUUQ1LQe2dFhbJFLN9EhzPaoSbbaB+v5OfzIbGYD2qXtVz435TzW/GyTNW1sOBtPiR3yIvdunMnKXS2HjLnYKPWMraG344ILl1TsZPDk5ZQ/J5aUeUtuswmWi+lckX8pLwkh2B5z7DivGoZtDnpcJNKDpnXVKt0zeQgMKV8uTjSDjbOa6yxegNEhYto=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4f8d78-dda0-41f1-4c4a-08ddd8ad5fd5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 08:02:10.5889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPj+G2YP2ujhvkd5GIKwMjHQ5zIDoSUnZdoFfqjM09mbvu4zEdXdb6IkM4r5c/c+5ET5nYkBmWM9zboKfZmdgNAJ5XLV8di+n/vsSJ2hO/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFB6A054FAC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=886 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508110052
X-Proofpoint-GUID: DgY7u1_OlBKmAFMwD1oqRFMvFtz_-7iK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA1MyBTYWx0ZWRfXyMrJvOyGNb3s
 3yK9BpFFl5jUlH+oFKSfzqLhFMSuXjrQ+pRXvDvSz65693skSQVOdc8diqq3CQiT57tViS8kVWu
 7V4pTu26vyNT/pwnAALoWdu8f3P2e6VRtYtGeHnWGbppqNCxnFSlvuQQBFolInobX8CFxdulzBb
 GcpUEPEq3j2pi0W9AKinBSX35CyqjjdPKMvrRwGp4UlJq8OLq9VOBO68UfHXQOf58++ymjuM41v
 2sHsZjwFymJGXw3eB9+Z++iqbxdQT+2XxPIkANvfrzVev+DKtUKphGp1w75LcKcuaUO40oUHlKg
 nvkFfhk43SWgABZzByw2JjOBZ0oQl4xWK37zy7wBtTXCpa817ib+4jghEUYL+KbHHlOyZUTiady
 PpAK4Z4zfqA7NlfUQnXhhCB+LjUPr6ol5VPqeyMFrFg4LlHe1EMePwmGg9RT6WbGFZsa04mf
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=6899a387 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=MVLC26js3dhxJ7H52IsA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12069
X-Proofpoint-ORIG-GUID: DgY7u1_OlBKmAFMwD1oqRFMvFtz_-7iK

Hi Thomas,

I think a script went haywire here with 'm@/6', would you mind resending?
Otherwise it'll be hard for to figure out which is which.

Cheers, Lorenzo

