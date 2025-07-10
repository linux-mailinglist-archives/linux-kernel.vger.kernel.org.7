Return-Path: <linux-kernel+bounces-726119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D169BB00864
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4727F543C1F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DC52EFDAB;
	Thu, 10 Jul 2025 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MP34qdwq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vlYzX9fu"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA47727145E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164233; cv=fail; b=GnWlCFtrrYF/MXeVsDeoI+DMJ1GRUxEa7Beyw3PlzDvmzPzjPTjT7GwNbWyMg15DU6xxjyBTqGoIr6IQyZIig32uutlT9Nu7l8Txvavi/bH0k6t0eF7gwI9H4Z5Pk9PUN9eHwKjMn1YQdaG5qXM8thHtN+Ta8ucRuBGWkmphaOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164233; c=relaxed/simple;
	bh=Y9NfnsdTedQRk0tygGkGDWcPGDP5jaiTsk/JD9dUvxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bgAlHLbsKdqgNpfQ4YYaNugS/FY5APpYMoLaEvefWKoOQsNWHC6JLn99LK0MrB3U/kHOHWPrK98+1CU5XyDF0R7XDGnILFOsqqksbTTkli4mar/1dbsXwkRiGeqc7d6G97jZVBoDMhnbkp5/48nGtSI53ggwF3yy51iq04LDh18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MP34qdwq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vlYzX9fu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AF7KqX008401;
	Thu, 10 Jul 2025 16:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=c/rOu8YJNSkCrHctx4
	GJ0l8oXpsJYvb293YXnQrJneg=; b=MP34qdwqthvRtnnL6MeJeosw72ikZqpWZZ
	PP+VJuwV72R+iFRwefSuURBmCzq0NYe06FTQsVhw897GdkxNM6C+mNgRaQp6n6ZZ
	K8chXvcGwUWQ54JL86c1mJ9LoDlKBR2x9fnS+a8SK2yNAVYyQvg8qdGhGv2x7/uX
	5PsuZaWqtz08ZhaWDPYs5eU0HspKLPtkr7Qjk/RXCEYxu7lMg0RTTFZwGJqLbMOt
	hu9qpaxTDjewKy23XcKyluOvylw/lgpb/sLI6VjAoq1qjF9z9GdC+Z7N9nc+BRTE
	bdID6hqsVXP4fP89pGOEk8ve+kS/JK3wUBt+FH61j7LkK5on9Gvw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tfvd04uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:16:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AFPcVo023596;
	Thu, 10 Jul 2025 16:16:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgcqy8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:16:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkXj3Lx+os64ZkoSgCM/hAiJkiLpiCXuRYojL9sTp4wNSKERbuZP6Cafs+tK/7U07yRb1Md7hSD4NcXqmqI2XiGdyLjBN6PW3Bg+9V2YKsqhHdehIWuLGCJjyviT8PNyeYYNUm5IeiYkagvzSVtaNQ3qgZ4J2I4ttfedTj6yn06+6LB8vJqg1E4RLvB3fPoJgxEHsu8WC1yCBXIY5J3pDXsOwwh7DyADDnTdpahE4ZBICk28lTlH9go79Yrlr6iKT9aIhQvE+2jB2yY1cdIFdXN7+LRycxymAcKAWXzhrwiEyXogKrAk+mfEdOZwqWJ+8BRuEG4e+wldNyo87aJDbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/rOu8YJNSkCrHctx4GJ0l8oXpsJYvb293YXnQrJneg=;
 b=Sw94PqEaKnWWfnNVOdK9AtGTiTTT6XJSb1W5/8BbDus5LiIh32udCslsHxsHlezizQDvNCRII0Mg0mk8IGlklY+RHHudtv5WRbXOCPT6GoSpzNXRSw5I+/tCkXFiv1U4QwPROKMmZRXf0R+g6Gb1nXGMZk6f/s1OXFw0mhjfh8t47zLuJ50dBt8Qypt3G26qy3dafSYwunVIsvzHPf/ZmHuf/W4+mocSFMnRcDYvSMtJFJaYjBLWVejZXivtV+cuXmABeqyoLgES1gTWxY8Kp7jN4dv2HAXq3dg+t9z5s8l2M67m0v5G8ec4s6Ay6Y/FXmJcTOuT0o4qF7g81BJBUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/rOu8YJNSkCrHctx4GJ0l8oXpsJYvb293YXnQrJneg=;
 b=vlYzX9fu85hdZ2RYTk6wHoJ93IbvA7XGaYTEb1l6AIUMdCmrav61DTX6UoSi/f+ccZQ6+Baxih2CyYnOfbOQJKMj/Hs2wY9uLm+ewiwWaRtkHuSRhs8s5XoW6GaLO/G5XqB7wHH2J8G2NUs2J4ev3XfyD2i+BglVo8YRpXZRNAU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8616.namprd10.prod.outlook.com (2603:10b6:208:57d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Thu, 10 Jul
 2025 16:16:55 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 16:16:55 +0000
Date: Thu, 10 Jul 2025 17:16:52 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: implement "memory.oops_if_bad_pte=1" boot option
Message-ID: <525a4060-2c8b-40c5-b4bd-b9c47de94f0f@lucifer.local>
References: <4e1b7d2d-ed54-4e0a-a0a4-906b14d9cd41@p183>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e1b7d2d-ed54-4e0a-a0a4-906b14d9cd41@p183>
X-ClientProxiedBy: LO2P265CA0471.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::27) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8616:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d7e2ca5-a52d-4d95-b805-08ddbfcd3046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MDzb0tIjJZrJwa2SFe46pFY64DNN7V5K7c6nw1JONy8ebop5UhqqARbmWeoy?=
 =?us-ascii?Q?RyGK4GFuRSaS8+G7PSR5aSJegJlQboBaNftYUcuPNZOKgl1PWXyQZ1f8qElb?=
 =?us-ascii?Q?io6CsVquyaONIEYz0B2O0SIwmnlN76jEbrPspM/0AOjWJOXHbo/dOGh8RqQ/?=
 =?us-ascii?Q?2igr1vn+zlEDhjQwcy0XjSTlP6iGBo4EmhaRfopyJvZUZGocnNM1T37T4CSn?=
 =?us-ascii?Q?hYSefybm0t5TPgsti9qrpb78aD1AX6jOwRTHSGRv2U9AsaZ9v2lGesS6l2oA?=
 =?us-ascii?Q?IGrVlwk3XPEMRU7uWOdluXllwssblGkipbw8SnualSt/tDNl1XL9nJgrd/BZ?=
 =?us-ascii?Q?RzGLaMxomVW2JKHkhkKufcgUW5UsIFyfLMl5WpfWGKtbckPZcbtv4lvovDLM?=
 =?us-ascii?Q?lLjOHQKwVfSEVsF+qDokFpbWCcx6lDC6hWZMQuxZzYB3VG2GC4hNod0KHTFu?=
 =?us-ascii?Q?p5XRQjUPZ5F9q9aRcdHG7m70ks8a+xWYEVUxSGsgIaSZzkDnogCQgPd4uXC+?=
 =?us-ascii?Q?e1RVJAKNbp/1JJ+e949+PlUXwjnteEwKkzFZOL3U6tElGc4ktWx4dZrghFyv?=
 =?us-ascii?Q?cIU8no1E+sB0WjDOfJ3nLfuR1RWVfZ3l20oUmE0TrGkdne+vNpLoJDFSYG28?=
 =?us-ascii?Q?MSKnUsZaPY1xwTHnfihIlIM8BzEK9KJ4ON3Bjcgg2w8liVN7IaBsDyfUuqzk?=
 =?us-ascii?Q?3b/+NbZcixUvXRfPPWn3id3ypJffTfQ6rDaoUzltWCkjRXJwOFY8uJZb/E+9?=
 =?us-ascii?Q?1q/nJAPwbUgECA5UsUhtqw9784vhuCWzalALphlCcrYUDG7YUVu2VDA0dhtJ?=
 =?us-ascii?Q?DFjFLr8TaRVoF9y1qwhSXhdkSCjqGgHycrPrv6wvcWTxez9iDrVKJKuppHHI?=
 =?us-ascii?Q?FodhkRLrIcziJbcI4sj3WRnQeFrnCYzeqtpnCG/eaP+NcfhbVs5+b+Yku76Y?=
 =?us-ascii?Q?gvobheaXJHjnAB80uWU5v+dOP1aCMryVoZPj6lci6RMQML2eKUXvw94epGnf?=
 =?us-ascii?Q?lwBSA/QKgQosMtpFvioDU3aU9iViBEGL/BpBXqAlNWyjygtJdgtbW8j3m14z?=
 =?us-ascii?Q?5GI9p0GufxRZBB/+RkUQSltJCdOyhKGCqHy+hh5YCQ3wCcwzy+mZE0N6S97r?=
 =?us-ascii?Q?CxCHZvHweiyajKx3CpQI6iaiyT5vOT7jF0nDkewZPj6AE4a+LFWnTX4kDE45?=
 =?us-ascii?Q?iv5IBf12x50QLJ/bcgSn0SCspWZ4SBrBg3KhaCHt29fBsB9AvCN8JypsYnO1?=
 =?us-ascii?Q?vkE2SOBfItz95zIXHtLEX9Of9N1X4Ab/d7poR3rTskOYu6elZi4spWKpiM5B?=
 =?us-ascii?Q?qTrmNy6VAgj6Q9vHfDUd4h79HI62xsCxAmnO2mlzp5zVhbix54re4pDIOsbn?=
 =?us-ascii?Q?tuZET/KPGooh3WzHuYtfwo9YJmn9ioO58A6D9LHO7gUxrgLJiVGbm6yDHgF/?=
 =?us-ascii?Q?eosOELiD070=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3LkN1qAowpclTplHCzNb0I6E2bbEIQR7N9quO0B+oqDLIYzD06HDsAD4RjXg?=
 =?us-ascii?Q?cUlqQ9wHgjviQtF8c0OmlIyUriVOhmsfAdXT6pa+WfOeltFjHV2yogsu+W+l?=
 =?us-ascii?Q?/O4BcEm9cb97Tcyu3mCKHVC8HVum1APTPuD22/OezBkAo5szCEgrTLVotz0S?=
 =?us-ascii?Q?vlxDfLEzgfGnm0fQMJhwy7OJ6EBUnfuddNQICoFYGFwlJ3xAjNzvhH8GHNAy?=
 =?us-ascii?Q?5JiRzDWgdB2qjmzgUxxH8qkBkdwpmEKIzKuLV1QsEk/pF4+EaBURkhYODfOI?=
 =?us-ascii?Q?We0DMM5QVBZFoTKOP0H4c3MIYBwaNLJAZ6vNN99TwUtH/CQoK2mmvkNkw16F?=
 =?us-ascii?Q?ETP1+fSvdWs9kN26R0znVDoHYx36eqHXyPFRQQSt8DmgDNLArt6gUc7A7vgO?=
 =?us-ascii?Q?hZQjPey7szjxoq1hHLpwVAISB+EnJnGPX37cjUcCJ3FpnpY6fkvyBPupEiHi?=
 =?us-ascii?Q?JIuy1koi6V63LoOuz+Xlmixk4u7FFgsdw4TOS79N60vhPphuyiNv0AkrqZWq?=
 =?us-ascii?Q?S7X2Dx1ZJ74oyi9JM/X14vmcRo6iv890wRdpRzTI/15eM4L0O1FYzI6PFZXa?=
 =?us-ascii?Q?hK9KkDpIpwXmzcTRGhWYNw175mv/ppokRfr2tHCwrL1uiSImHLdJlOrM3M+V?=
 =?us-ascii?Q?4LGYEk1zNoFoRmCU/Ul58pxa5tQmTvB49u1sQhStEaiMp3wij2GgETXM5GiQ?=
 =?us-ascii?Q?q5Euo45XoHlVj6vHW6z1sjU3mp3qDW3UcN8AeC4/716Pm+B2NEFIZaa1BLTw?=
 =?us-ascii?Q?69XH6w18Qjvgk4Bj7OE8qMfRYeAI6Hrx6qwwVIfvF8PVJ/Fvi2w3gj5KbeZU?=
 =?us-ascii?Q?fJYLUeblOkox4137r2e075nRMJ7TrACIrS4msc+PGysGDepxgWBFuDkcIf1t?=
 =?us-ascii?Q?dWLO3PXYdj+3jGsImxWo6jA4EuLLURQq8oelrnbDiBdZXQqcbJFqz3RZfOzb?=
 =?us-ascii?Q?EXiXa5JiTSslso8e80qyylBaN7zxOxvadKOic1qVJblFa/T5XWSQBasLdLgB?=
 =?us-ascii?Q?9e7W6tlsG2IbfsACDyx/u2Y9xCjb4TtjcY6sr5Gv+RwcX1r9fQ4xaNlGSo2h?=
 =?us-ascii?Q?tCadFDPSNhiOISZRDgjmC/OCu8Tfvk+Wc9nzYk6tPvcy6XWqO2Ww6/UhBtXd?=
 =?us-ascii?Q?WiVFvM6yKWp534GFBJivX/67jgqsP5EeqFUkj0NnDwqjC6DZBp9IlsYrIfvp?=
 =?us-ascii?Q?mpVCEBamPnEFrWyqU098JLyduFBnu4aNwICH1GoRVJGn7WvheYNkeu1nXAe3?=
 =?us-ascii?Q?qZeyqa03zMQZk4SHJcDmv8T4gQEamAEmXfsnZ/Sp2Xj6C1AL46oZsmuvVNcG?=
 =?us-ascii?Q?1SvelFBTfmX4fkvWh6/jTnI13suBWNDLINm5VlZ6/nYr2kfltVpur2Tw5zZI?=
 =?us-ascii?Q?3z+R9gWy5EqPnHA4UvL1p7WqP3/V9/n1lWNP0AsoLjQfg9IGG0x7TtN3dq3Q?=
 =?us-ascii?Q?ykSyzm1V48sn0/FiBMTA6PsEn8Yw/qxnFCqHle1ZNyNl+WP14Xz/nlCGjLlc?=
 =?us-ascii?Q?ll4hXr5+KH9VNEx6bujiYhJh5SfxprCROAyBamOFDVoby0GNFyEuTzhKZeg9?=
 =?us-ascii?Q?AiwxpWkfLNklx/Sa/0YEKTTJavnXdbh1ifQBHxR/WmQaa3g33kma8zCcAgiB?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8tGb5ndOkOTDcCFEUBlZPHC3p6E76ZmENUy0jDCfnnE9ElqHx4zQQXIqUjukYbPQa9Kh2o8/zK+2xiWMqjhMuP7S+2og0E2cCqM9k+XRmQj2Ms9acazpnQ3toOYfBHQVYiGPBQkzddtYQhYcu79xk9N8QblWfVhifNhiQNH79pTrtGxOuOW7lG2INVmXZFZPBXNCgfjzpHtbIAmbB3orgVsZ0DBXAcd7kzbasRXiSm5U2HiD+FoqYCG758fLAkaIusxrgIsolQsRXlJFyG9Axp3jozJVfNxPhmXL+hMJESDLgd3guIjfMBQU+rS9uqg1juJJ6uCSuPBLFLuBxuCUFiYYJFuy0QG9IeA8fN6hvDwwbZebVFM+om+AIvAzHdedqrYbGR6hwQi6qbN0qjTHRRgYMa4Q3RMbBhrVzdvMPrimAC2eWqAWP4l5mH5tJa3ezyCg5la8ZYvnLY2lSJe+e9+yZ3nZr2EAQzGLJx2oY2XgeO9sO1+jqAZPHK9ZcTgd/TY1T73L0uwG+thipSfFiD0KI77jwXzsvc+eYPGDdR4mTHRuTkVDlPOXe7wdsZMRzUvItOpETFqsawNxNy5tWQayj2JgJbeLxN+/n4badgc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7e2ca5-a52d-4d95-b805-08ddbfcd3046
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 16:16:55.6569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RbemTSUvMHpYNi9tpm24iZiQT6gnRRhc9WNgfR9YXpoVmuGpoo9x99LiB9LxI8DSYgWCbk6J2tsb+mrtmPswnVd7sdc1GNliuOtaC//lbTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100138
X-Authority-Analysis: v=2.4 cv=Ydi95xRf c=1 sm=1 tr=0 ts=686fe77b b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=_DLvLIr0jo5ZgU7zPwQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzOSBTYWx0ZWRfX1ciOeMsg9dSl SOVL0+b0tzj05cou3INcX2nQqD9xw0W+NxHl6pK+f0Rpb2KC9G2f/pqkSBC5PNJ3e5HP48sAoEG P2vKXYjTRz3DmCYlFVAb8iJOQLe+ywJUu2F8PyQalh/sljfAapxwTcW+s+mHP3b1s4q+5dKmxAP
 Qw2riGxsY8GL0ct2tPbhwO/gaFTKUbSOU5ntroVC8TxHfIPKpPbFU/5tWhUqEDtl7G9Vi2q9PjY msUKjMnNf6IaZ0zK/1lCs0MAnPJablNJoUPMb5WXHv7SaUKQQSm3fck0DYlGDrLVaFHyVLRaSVl GvOXBi95dr7QgzpuOoHK9vtwOKomA3Ezs8nbgaa/r89lU5d+MvRyBIuwvzoQ4AY2NAH86PGPBpA
 mGLlWXYjZPaFUqlp6Wyau4aIhuGMCsAYw0+NOhppt6q26+dQMe6W0GdXIMvNgtl/oLV57gdu
X-Proofpoint-ORIG-GUID: k4sbhUhomGypD4Pf9Y64nqAzp3WCwCfZ
X-Proofpoint-GUID: k4sbhUhomGypD4Pf9Y64nqAzp3WCwCfZ

Sorry but no - this seems to me to just be a hack. And it also appears to
violate the rules on BUG_ON() (see [0]) so this is just a no.

[0]:https://lore.kernel.org/linux-mm/CAHk-=wjO1xL_ZRKUG_SJuh6sPTQ-6Lem3a3pGoo26CXEsx_w0g@mail.gmail.com/

On Wed, Jul 09, 2025 at 09:10:59PM +0300, Alexey Dobriyan wrote:
> Implement
>
> 	memory.oops_if_bad_pte=1

This is a totally new paradigm afaict - introducing an oops based on user
input, I really don't think that's sensible.

Unless kernel.panic_on_oops is set this won't necessarily cause anything to
halt. Really you want a panic_on_bad_pte here, but that would be way way
too specific.

So it seems like a hack just so you can get a vmcore?

You seem to be using BUG_ON() to _maybe_ cause a panic, maybe not, but by
doing this you're inferring that there's unrecoverable system instability,
which isf clearly not the case.

All of the bad PTE handling seems to be intended to be recoverable and
handled by calling code.

Additionally we have uses like zap_present_folio_ptes() which use it to
output PTE state in the instance of an invalid mapcount value - I don't
think oopsing there would really be what you wanted right?

>
> boot option which oopses the machine instead of dreadful
>
> 	BUG: Bad page map in process
>
> message.

I'm not sure what's so dreadful about it? And why an oops is better?

>
> This is intended
> for people who want to panic at the slightest provocation and
> for people who ruled out hardware problems which in turn means that
> delaying vmcore collection is counter-productive.

Seems to be a specific edge case.

>
> Linux doesn't (never?) panicked on PTE corruption and even implemented
> ratelimited version of the message meaning it can go for minutes and
> even hours without anyone noticing which is exactly the opposite of what
> should be done to facilitate debugging.

But are there real situations you can cite where this has been problematic?

>
> Not enabled by default.

Yeah, obviously.

>
> Not advertised.

Umm why? Seems like you just want to add this for your own very specific
purpose?

>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>
>  mm/memory.c                                 | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index b0cda5aab398..90b92b312802 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -42,6 +42,7 @@
>  #include <linux/kernel_stat.h>
>  #include <linux/mm.h>
>  #include <linux/mm_inline.h>
> +#include <linux/moduleparam.h>
>  #include <linux/sched/mm.h>
>  #include <linux/sched/numa_balancing.h>
>  #include <linux/sched/task.h>
> @@ -480,6 +481,13 @@ static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
>  			add_mm_counter(mm, i, rss[i]);
>  }
>
> +/*
> + * Oops instead of printing "Bad page map in process" message and
> + * trying to continue.
> + */
> +static bool oops_if_bad_pte __ro_after_init = false;
> +module_param(oops_if_bad_pte, bool, 0444);
> +
>  /*
>   * This function is called to print an error when a bad pte
>   * is found. For example, we might have a PFN-mapped pte in
> @@ -490,6 +498,13 @@ static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
>  static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>  			  pte_t pte, struct page *page)
>  {
> +	/*
> +	 * This line is a formality to collect vmcore ASAP. Real bug
> +	 * (hardware or software) happened earlier, current registers and
> +	 * backtrace aren't interesting.
> +	 */
> +	BUG_ON(oops_if_bad_pte);

Except that it won't without panic_on_oops?

I mean we can't just go around putting arbitrary BUG_ON()'s like this for
cases we want data on.

And far worse here - this is a print_xxx() function, and you're making it
oops? That's really bad.

> +
>  	pgd_t *pgd = pgd_offset(vma->vm_mm, addr);
>  	p4d_t *p4d = p4d_offset(pgd, addr);
>  	pud_t *pud = pud_offset(p4d, addr);
> --
> 2.49.0
>

Note that other page table levels can be 'bad' as well, see pgd_bad() et
al. - none of these will be caught.

Overall I suspect there's one single case you're worried about, that really
you want to put a WARN_ON_ONCE() against - then you can panic_on_warn and
get what you want.

If you can make an argument in favour of this that's convincing then that
would be a potentially upstreamable patch, but this one isn't, in my view.

