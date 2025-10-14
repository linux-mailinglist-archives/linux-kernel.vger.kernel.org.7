Return-Path: <linux-kernel+bounces-852284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5050ABD8991
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC7C1923C93
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FE2222587;
	Tue, 14 Oct 2025 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YYTibjDJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hHCM2FyD"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CBF1EEA5F
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435852; cv=fail; b=cEonPCtoTIn5y6xtU9C4z8otzO73iXqlCSNSXW9Mbz/dOyRq92w48qC+bZ/LaEGCIL4dn3uwZc3jszxcJgc/NIW+dkCOVAcmU+eKjaYhLn7wCj+sKbDQcBg58qhdC7svSsS1C4ECr/iqyYQPAS5tYgVqqQ/tgHBj8HvMu1+UBwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435852; c=relaxed/simple;
	bh=T3m0TJOAH7ANOCWPQYsuC+XUzzRCW0BZ/py+aAbko4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IDNDqxY2PpFtMU4uk9A5oPAGSTqYJjWYXRQpsiPDhLXe0s7qTkps2lE8uZg1o10Vb+XFnF05bEwQZLMn2MZ69nh5z5TgzD1QuqfP7e5y+VJsG02RdRxR/Q0XqxEUHp7CbearUZA63EpWrafoiNG+CJaIYhqUJUH6kAK0tthyf78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YYTibjDJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hHCM2FyD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E9uCmi010771;
	Tue, 14 Oct 2025 09:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=EoagUEv/HtkIn3N9fp
	81PQ7N6e1pTyZlflE0jX+AySg=; b=YYTibjDJ4TNEFhsgH8TiNXp70KKNJw4LrD
	ZYRFiTHqEFbRMADS73Ke27SvD1kHFxuSWE27oqSKZPxJgFyL4vski2TSk7D7Ddve
	0h3qeFBWh+weKZIt1oh9HEUcTelcVpJt/AvXjqGbq6McA3zDWCfwn/dbrVI62yYO
	I0iN6SkvXBzGFtuDpNsg+b5iFit40a4ftr0pOtmDAxWNuC7KfiDbf0RycvmhHD37
	Nv8OPpBEkcQPgiBgQ6+n66a8EZkjYzuOe8PqR4ZiQkJUrHqeqO8ngJ+KseiYYq+8
	mo0x87IKTQz+m/ZHFbJpuAyo79Nw8kfYIMjMzAx5MNEqNkTjnwAg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdnc3ysq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 09:57:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59E8d8dL010116;
	Tue, 14 Oct 2025 09:57:19 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpeqhcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 09:57:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sv8ASqDW5sZMdxMyXgHCUA8uUoAxqV52A9V3jZREM+r+TDaXXqbTgj0GW8VTqjbjHsrpGxTE2Kr61jqXJD6hvjUEzmURxWere93ft4kQGCWoDrC7YRMwL6BFUwOKbIqKNUlvIUXyE7b/2x9yr9JVLmhwhQos/I1gLrarlz2Lj6glxljuw46Shl5BlDK/aTZVjTs346u7Bs88sr6I6Z5akq5itu8Dmz2IVUVjKI1T4BvVMAoJgsiBxhrpNhq0gINkE1P5+yRYSZFOjUXZ0bpyCDe+RMqzQ8gVDgeiFXC1ppQGX44pMH5kwuW5ekDaUhscAnZzpbTkNWhdwH2HAKcGmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoagUEv/HtkIn3N9fp81PQ7N6e1pTyZlflE0jX+AySg=;
 b=SFOcYheqThcnSjWILw5fKpci9pt/DrUr25LVq/8NslOmPMdlknl/b8u1jeKJSSU43/Md6n59VvL5Drqc701BVLUoKFsHJeczR4WqfvpPfJk+LqYj5gBifsaSiBePv96cTJ5SdJD+RKcjKdB9NpkeZRFqoHe9CL6VMOSAqpRMh/xJBH0FBIKpg4LRBeVz6x2oEw6HozmQ5io5muhijg/AqwLlsUqj72Z+TI+4jT8YX0Dp/s4BzfFIsPbG1q97JwSr60P/VZA4O2EH7ufX01OW9iAhZzViUIuUhDw7xtfHXTsUSh//C6G6YjaAHrO7Hvp1SGH+Cr+680PWo7aOmVaXtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoagUEv/HtkIn3N9fp81PQ7N6e1pTyZlflE0jX+AySg=;
 b=hHCM2FyDWyuPa3V9FqouOID2PzkRKTorBBZfF17rbABhh20+uaIxm/L8wqihH2ZGA50o2yqbS/NGcxba/hbh5l3H90/b+oVw17IlY1ny4jb+sjpOPMcB39fu0+dk4IXDpA/rStHfAO+SLsK3Ovz4KqzU2H8C4qaSUEfq8LgG0do=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB7129.namprd10.prod.outlook.com (2603:10b6:8:e6::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.9; Tue, 14 Oct 2025 09:57:15 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 09:57:15 +0000
Date: Tue, 14 Oct 2025 10:57:04 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mremap: correctly account old mapping after
 MREMAP_DONTUNMAP remap
Message-ID: <9b2c6986-da81-4a02-830b-17554b6f2cbe@lucifer.local>
References: <20251013165836.273113-1-lorenzo.stoakes@oracle.com>
 <rtdubi5ewzrptvl25zcdg6ta46kcd6ixowaguftwo3rtmx5cz7@f4sj33igjuic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rtdubi5ewzrptvl25zcdg6ta46kcd6ixowaguftwo3rtmx5cz7@f4sj33igjuic>
X-ClientProxiedBy: MM0P280CA0094.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::35) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 220a2abc-1891-43ce-55f9-08de0b080e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/VwIKL/0mWm2K/kg75zbCCZM6AlR4R3ittojXG4qi66Yq2x9A+So9xFhqaIH?=
 =?us-ascii?Q?mEeF8BzuSJk4EVN14UIHNjgZ15gm4V/C9AgsEDD4vPeu10lloH3kfnucpRDT?=
 =?us-ascii?Q?vTw6SQn41TtFG1Vt1xK5m2MkXldbx3ecmlTkrLSKIz6WxQeRLg/Vwjy89vLZ?=
 =?us-ascii?Q?m8bkX0hucT6XqCPGBFNXUyND2fZbNlEwVql5LuUKrWqY7kbtu05cxG36GP8p?=
 =?us-ascii?Q?5GiLwfn2Uo9hSpLNAQxPZdrZ9Jtj2auiBDktwiJPJ6YOunERQdRZaK5AiUGX?=
 =?us-ascii?Q?m4t4c53GSSIKh0NMP+W/VIJvsQaimiLHsub28uAieHA7FrY5+/HyXwDgCDcH?=
 =?us-ascii?Q?VWiiCOmAA3nL7DDDRtHqrDC7cP3XWcPfkTrnQDC4HLVF7cRLw36vFflNvVM7?=
 =?us-ascii?Q?EC03Xjvizdnrh2GjtD90wChAFZfrjU0zWFqtXYUkKPDznljiodQ2FqLEEFlP?=
 =?us-ascii?Q?IbDhjXBT8/zih70txKRG+NUgHqRa7S6QwdUt7vTdVC1pH+u3rSrMAsjyKM5G?=
 =?us-ascii?Q?iPsqvY7kBolQu9/qmQGE1TGRnUh2Mu5KQORpP1+BcYxJ4NHC16kJsqcaNO89?=
 =?us-ascii?Q?/MJ4LWT+dGt30lLq/1+v+Lda+Fi+HKIEW7QegFPYnqCISuAFEuMagXMy1f5M?=
 =?us-ascii?Q?R4hPae2u38A23YwVFwAif1aybwSP1wiiDlHdBVryNPKWFWB1RdDujUeCU+dm?=
 =?us-ascii?Q?9hUh54/Ozp4eK/xG1kKWtFZPIE4mlQiBfcHVnHfvgtm+jgJfz83Eob9tQ6Um?=
 =?us-ascii?Q?njqC0yy/eDyRx7hkPnx45+WxLv+sBmMY5bqcFhm5rAqGkOeq8C4ICs4mckTg?=
 =?us-ascii?Q?lsUz4xmwNSuw9IOmnFJrWg/0z97oAXLXbDFOWKYiZJWw1BUXBiuqUidNBeNb?=
 =?us-ascii?Q?9vAEVsg48X1XRy1AcTuHMaUQ56Ftexew54JO9M2Ga0j0+yy4v28GhfRIHZAR?=
 =?us-ascii?Q?hBAkZHIcMUDz97OyNKlJjk5puD8WVcOvevMUchRzKMWdbooE/+nLUMTpi8z9?=
 =?us-ascii?Q?UEOCZvRxW+qqIGTtQBzSqRPR5kKlCX+C64/rzy35jUX68fhAGmn14FXmw/QT?=
 =?us-ascii?Q?ro+9AiJux2lvLoinCn1xWjzS5qekfMyExVmXn88S6wmiyOPerIT3bxSoOdtb?=
 =?us-ascii?Q?xDHsRFN17XqZS0PrBqeyWgfKdESvVZxG1h/UpOHfsZzYJoEMnMiCrSvytkzH?=
 =?us-ascii?Q?fvCQs590P6FHpiQSY2CI1IjjzfhjadCrBaJ3PwBEEbed4G+49Z+gRu0K0oZY?=
 =?us-ascii?Q?t1NC+PfQndqNn25qBqCVBLNqnLZHqXRfdXp0oAevxCMI74sJMVtyZz3y/3Ye?=
 =?us-ascii?Q?P2Kf7xF/Pdq9EENogVqq55xiVDoe2AAUywAWbYQkinUbRnGaDnnC/mKkqPWo?=
 =?us-ascii?Q?KlQD+EjY7djVq/qzio8A3HTO7GRaYU7FtID71BH17Ai4uo23h+s8PYMSIIdO?=
 =?us-ascii?Q?9kgcww+XhIk4A51DKpTE3d325e4B9qQT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1nBhRA2HPDwn2HHGJrF7GIx5M5nzCwve0yUwxsCwwc4HpnvAoAF+zq98RymP?=
 =?us-ascii?Q?ek0XWa4ynn2Ns6XUbcKI0DOfCQ+TVrCQLKcA58dULD4ZNEtj7KA9Gt+p8Qv2?=
 =?us-ascii?Q?zR3E5eQttX4aoABl5W+N7mKaXRMsjt3B8wzyXNiUxEyouf+lDuBAXHPuQnMQ?=
 =?us-ascii?Q?MdNK4oP51cp7blXRiUJS0ubC+BXrYe4HFn1B0VNugOnnxsT4fEPTZqor7zlr?=
 =?us-ascii?Q?UkCr8QOoVofAFtD8DSTkdgCBaxuiFRthYUfD7xAzMvCFLY+NcjoIpmsXki9Z?=
 =?us-ascii?Q?AxGkFWSTn6J56DfLKdmGqLrCSJ9j0X5x6Umv4/Stp017Kxw1fBMFdEC3nEnA?=
 =?us-ascii?Q?N42N2gceo4wvKs4amoMqYk9yjjLUuqy0L+2QMwLaikREbAxdhOCwakcChMSe?=
 =?us-ascii?Q?Vas0qz95NOagI+EzCCFzQWrabYU0QbklrIS/zAxryvqMeWMINR7HMJp6ityW?=
 =?us-ascii?Q?9V1y9csVW5VQX1Pzie8sRcR9P9DmxylZfUNi0uTkkZU77ME6MxrDNLq0tHzH?=
 =?us-ascii?Q?BnnRaJqQgNoPbT2P9W4wLj5cngX6UgbykVXMecUCZAbse+bjf9S2a+2CC8lv?=
 =?us-ascii?Q?00cGQd/vKR8/+C1aDZHDKOrzG/r4ZbfOlJe5MJHvsEBsv785hHFNb87hKdqw?=
 =?us-ascii?Q?61dq7B2pPk71OxNpji9Cfj+sEIKrD9IH0QbFuulm697Y+GYrsdIXFnjMdZZL?=
 =?us-ascii?Q?zE5q6CIBI0gS+DEKUtYWS4hKDzRh70eiKmGGW1EowfWz5GEljFgGqjmVMNMr?=
 =?us-ascii?Q?soQwMhRqrBq/+EfWB7j3r91KXm6XYAiRRujtSr1DvMGW2uTFx5ZTqoLo/vyJ?=
 =?us-ascii?Q?dbMn7yA1xE6EGNc33j7QZiEj5lmeMrZX5+teDd5m8oYoi3ctAdKuhYy5yOp6?=
 =?us-ascii?Q?X0Tl9Wfmuyjob1OqD30/a8mlL7/PvjnUyIEF18jiTtZaGu1XiMEqDGKrMkhZ?=
 =?us-ascii?Q?O09q6xMkXeUWt03mR+9CYuZ0tCbe73z96kID13lqc0AQMTwkNwRb3LKIIHbE?=
 =?us-ascii?Q?6pvpmnDRrJOTOBEjyap4xBVw7WmiStB6idI4ZvjCF0csO+1xgsfmDxLwggXb?=
 =?us-ascii?Q?zV1SKB65f+ukdaFVZ9qlUbG4wqUpCHsEVeilm5dbwUmE6SlG+1EMYtyhHUW4?=
 =?us-ascii?Q?OwhXKVUqAC7/D/tGOV6gk1o0PPWqRe964rHm5dz9ebQctMX3Bw0Y+UbDx+th?=
 =?us-ascii?Q?Y7yWIyq5wvHgBXLwEUoxHqfDST46xzSDCgFTqePPQ2tpMvnqJAemJ3RetGH9?=
 =?us-ascii?Q?bUezfunjblAlC9OoZHgiX7n4L+jDqGr54+HxHGCOkRIsurFVCoHYpOBpYSNL?=
 =?us-ascii?Q?TOHd31ntxp5JzgdI5NsCp5dkWAczPFSA67mpNqUcXwdZgENX4Zd/UA4Bf+tA?=
 =?us-ascii?Q?qQRFM2jY5weDbh4i077sSWxQnyBnMJ51eqOnPDOEsJLH9IY7BbtRyl1X5Ft5?=
 =?us-ascii?Q?yqndVbRL8G7+bTlkSJpkBIe5qt9DMI8gfrHOmTuFkLaUpM+Xk2nE6cFnF13F?=
 =?us-ascii?Q?NhkVhuR7KaE6s6MWVrq8lVA6nIyQXDNDlRT6qy7xOwP6WuB0CZqJ6K6pUC/F?=
 =?us-ascii?Q?uCIPBbooq+OnpHhCdoD/WwYvV2lFsUwf9NG0jMVvvSsT02PzbNvtGXfbsqxa?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YvAYfRk6uIcvha2tbN4Jlal9HxtREbGzV2xY+ET4WRJQCGwmtGfu5Y0VuhSGVzsT+UPdSkSu5eWKB4tg3i5wneLrQL3R8GtEu8CBF9jN6UdVJltNUS1/RU0I9QKXkM+j8suWua5aJQwV6zofZp57dgO2DSzwpDYqXDttgvpuWG9malUG5s+YpKuNbcUj4wgdQwf+Sg9T0M/bIm9gKlXddBv1n9sqaCEbx3b6mi0ZAQYnspjO8oqw1uMF5/HfeWixmX65mRKj2HinHlMXoqVCOHSvOlwcBdNXEMxdTiiqLW2T2ZtwNzNDZ8KHgH8q39N1owJlhZ3I7QmS1Ut0qEwhjLBlm5CruLP5CYzMJds8fnHMoBYx91U8ctItzzqbpg1UFJ63LDDgiBHoSVQCeKaAud+MdLNm182UzSOYXgYH8/Fndl5YWQfoknDoIui4LNonRQ7AK6oQEJb1ZtHvz3YeHULhjxHvUwJA/Ee5S1zI1d/oXH9KY+WkLU/tbnaUut8eJcK9aXewb3JsB5wdtmOeUQ8o61vW05pipAvtp2DBwLvTWz1ryoSR6ljCnABnF9L0Abzik6zJ2ODx1sld3RdK6cmSPqbsl5mrd1VOq8PWpns=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220a2abc-1891-43ce-55f9-08de0b080e05
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 09:57:15.6756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsuYHv/052XnEMuZ350/rO3s4BtGOepK1iRey28vlvbLXTkFlWQWLelajRN8g40cgph8jN12993NCj6aJ8bAK3gGF41rH0VCyuFay7lvCdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7129
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=979 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510140078
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNiBTYWx0ZWRfX6Hs0jLcLyvVv
 34EciOPsxCr96CCVwCjhdDAh5IiwH8LnGK2N+YLwqf8Fi45jP3kEVJs2wgG8PcPsOhRAHyy1QQu
 fdJbJQrrj7oiid3l71JIMlafV1e0sP86ERCRbpefBpqL7vWPZ8VfrS2Cq5diVP3OaXDZ5gs9ZVs
 RJLHXdUS1g02DBNd5iDHQF4VLQNBNMFi1vnwJFHnNyERRlvnP7tP1hNe27OdvV1j/eH/q1/sz79
 sSOsfounBYBgwBFQcaQS1zoSb9OninCxVjeNdwz9osIvYAdeWyKN+V7aw5S596YLnuck7dHtixs
 XmhYdmOn84TdGQ9cvazAcTaG821hDyE08BLyIQHjj6aRmKcwS8gm4lg+gw+Q9MVRX3jMAaAIimm
 F8AwvJ2J2Q3T1p57zVYIBBIwyKluKj6l8sbZ0mtrRcFsCe0MZh0=
X-Proofpoint-GUID: 17QPIN73sSukKG4szDwWY2M74VTwO3LJ
X-Authority-Analysis: v=2.4 cv=ReCdyltv c=1 sm=1 tr=0 ts=68ee1e80 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=UWAWf51EsFS9SconwKIA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12092
X-Proofpoint-ORIG-GUID: 17QPIN73sSukKG4szDwWY2M74VTwO3LJ

On Tue, Oct 14, 2025 at 10:41:18AM +0100, Pedro Falcato wrote:
> On Mon, Oct 13, 2025 at 05:58:36PM +0100, Lorenzo Stoakes wrote:
> > Commit b714ccb02a76 ("mm/mremap: complete refactor of move_vma()")
> > mistakenly introduced a new behaviour - clearing the VM_ACCOUNT flag of the
> > old mapping when a mapping is mremap()'d with the MREMAP_DONTUNMAP flag
> > set.
> >
> > While we always clear the VM_LOCKED and VM_LOCKONFAULT flags for the old
> > mapping (the page tables have been moved, so there is no data that could
> > possibly be locked in memor), there is no reason to touch any other VMA
>                         memory
> > flags.
> >
> > This is because after the move the old mapping is in a state as if it were
> > freshly mapped. This implies that the attributes of the mapping ought to
> > remain the same, including whether or not the mapping is accounted.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Thanks!

>
> Looks good, thanks! Should we add a test for it?

I considered that, but this is fundamental behaviour and so is very unlikely to
regress so doesn't seem really worth it.

>
> --
> Pedro

Cheers, Lorenzo

