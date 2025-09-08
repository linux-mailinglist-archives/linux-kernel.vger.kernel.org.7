Return-Path: <linux-kernel+bounces-805658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D868BB48C06
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25423BA39A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696A82FDC2F;
	Mon,  8 Sep 2025 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bc19Cnwm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iZPBXA16"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45402FD1A3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330321; cv=fail; b=c3Js/bP11xEE5oD3kTAP7WcvEvFU4SHzKq1YRQ5Z4R9LjaYxAC2D0aKGwQJlVGJo6R2svMbTmlYf2buCepVXcc5EDkz/onVLfso6GyrM50Ijiom6fqs2ExekQuoJQxg0tZVrNiViCHh9MnZVG1IAzJN7t4Wx2653n3tKXke7928=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330321; c=relaxed/simple;
	bh=3VNsNStJHoqc8S8tVFfWlsW/A5ItLH4yi/8z0Lcf8Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k9AtTn/MIBHx2IrlJ6LSGOTuISwyHV9y70qLbykCdG8mrf07yvPSlUWUKTz472szlg0GUIiwWtVi0h+MevXQkPvolTQexfS49uwqpGGBMtgiZ6wn0/1XYkeamGZTJNMf1mQ5isYlNkTQ0s5psuaAKv3cxI5tcymD5Sd13+DGGiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bc19Cnwm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iZPBXA16; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588B4qZM011597;
	Mon, 8 Sep 2025 11:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=5OvnI5xmImfpokXJNs
	rA1+FW6VEdGOj1rAArfpaKlFc=; b=bc19Cnwm1uYmxVI2kwOz0wmSUvPxtoQxX+
	YdHA5i7JBxVHDvXQF0godGx/sSLw4sbDnfE/Gr+Nl7HKrshUr/GaAR1sZWqT+hRA
	1TYPkkEXhwsD7vQX0/yGtiBi4m3fmUfgJY46Wid0KGX5uAzE8EMEPtZce1a/3iZZ
	JYfikwrXQOAT/V1Evu2GmRbr4hiTbKViQKLDfhEuQl4/VI1jhZ7/UBxlN9vwA7UO
	HYJtZsuTvx47/dePe5QHpUIQfPZ9/hn4clmYIOqHkCy7WMeZ8U3KxeFk7sPx47+N
	ouJm9NfbBYeD85aN47zIwnYxdNQvMbbhBOED7/gQ4WYBlKQvPjRA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491wxvg0g7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 11:18:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588B43or002944;
	Mon, 8 Sep 2025 11:18:23 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdej618-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 11:18:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YisqcYnYxaimIJICEt5lF3KwKSDz9/m1b94lCWFWl04F4ADPoDOdzmL6uHwMmjbioQQSGXIbphGlgst6HacocdNOgB8h0+p/NyXblv88u1F7H5RbcldwRNlsbhJFv6DahLUH+uohOd5xqbOqz6v++c2tYyK1x5yoFdf3EOcUeWYFoBuYxksdCs8aA2Fusdn0hxA9He7/h2ifgnjhImahgcbqRcjfn/ETQVZF+JSZOnbraoEGHv6Aq5I0WbdfiEiXhoYUtl0MdsjixDLhIM7/H46OYPmRyuyDrRL+/SNj96MQY9d3oeT12POeBYPNXo0vWSoh9Ult7zJU0+COGyclyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OvnI5xmImfpokXJNsrA1+FW6VEdGOj1rAArfpaKlFc=;
 b=JMakO1LxvbDv03J5d8G5U6pGvMbkqbHglO7YeMDKl1gemyc/9U68NcUi0byisR8FRYR0eQ5oWC4r2/Yuk7yGQNYUKu/1PstJU72IziP7c+bdg5lz2QEg7h6XJee1WUouBL3/CRWY0yuHrEHlAHFwUbvwPU94UbX3xEZg1+Gw2p4DUgAyUs1zK+odAkzfIU18xJGAJUvBnHHceO1TW774oqlgF4U1YIbuerSkwZhR+yuffWHoyd0Uk4ZiEDWKJXdaWHSSUamU4ns+oSSBYHnwgsdvahQpdSXbFW/agZbNOn3GFcRnoXGgSWuQZzlgOMNsICeqb4XprAdeC8+br1m4Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OvnI5xmImfpokXJNsrA1+FW6VEdGOj1rAArfpaKlFc=;
 b=iZPBXA16uYvqEMSCm8zspEuV/PsjFXh4mhazoOxneeoRhUhfvQ64+ycsn6BjPGM0rWqEF3oYqT3kqEXwpwrkTHaGvxwZg5K5xUkXpOHCT6Wlh/p4kqGvTUyKddL0OgmZnZ1dfIcMTH+fwJEcLacHtMEcwNM2+vg30XWDi7BGZLE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 11:17:58 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 11:17:57 +0000
Date: Mon, 8 Sep 2025 12:17:55 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>
Subject: Re: [PATCH 1/1] MAINTAINERS: add Lance Yang as a THP reviewer
Message-ID: <649403cf-e95b-47d4-9236-10db4f672a4d@lucifer.local>
References: <20250908104857.35397-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908104857.35397-1-lance.yang@linux.dev>
X-ClientProxiedBy: GV2PEPF00003830.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:5:0:1c) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 4101c7e7-9b50-4c21-7ede-08ddeec95d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ajEaV+EOUzlxS5Nm/uxiwl0k2BMSwiHBZxBFil6VJwZBzvKJPEzWoYluSfNf?=
 =?us-ascii?Q?ALuvRe/mC3CCuEAzxrDa9IO43efywWtF6mVYu6fWTa5u1dAVaX6ecnBHjWUk?=
 =?us-ascii?Q?QkNPVw727/fNVQzynq3h78OLeU8OrQwQu7n5Y2rthHP7gAkWY/VfUzPm8sWx?=
 =?us-ascii?Q?YNx2pcyaRQ+cu5LrqKIDwhzZQj29o1oAsg4It5z/x7kXWUfVwXmpk3O3cUTP?=
 =?us-ascii?Q?bpQSG7pPy0ecRxGK8c4t0SAijvTN1T8HZj12hfpZD56fRINEkzIiGUDl24St?=
 =?us-ascii?Q?saPQ6ht4SMd6G7s/5gkdERijJLJ0hu1s8NvWhLwDEONcQeZ/pbj06KLLdYTw?=
 =?us-ascii?Q?lvo/MTOGN6nECecv4l1I9KG14IZXqZhqJnA7hWAl+6VVbG9IBB9IG9XTDHNy?=
 =?us-ascii?Q?UlGVbsQ8Vick8uwepEMJUOaokkKEH3vNP9yU9f0Qnmi9gx1ZJDeX9xbUKhNl?=
 =?us-ascii?Q?5OxG88vSn3k0GJ8ZHFTbCA5NNKpAW2Lhajv+hnHH78jJYsiyh0PzniZw9oId?=
 =?us-ascii?Q?SCJ8ZybEw3xue/foxjafCm1dQeGk/j/Wcqi4Srbn9I+XGHunoSUgbciWlci1?=
 =?us-ascii?Q?eH72TRYh6acwA4u3Zr+K6qHssIFBTCfDnKbZqJ47H57glQqKWypfBss6TFZe?=
 =?us-ascii?Q?X0vpowXhVfQ5KlABfG6YvgjZTyDtC9Hh9V76hx6npKJrAmYfpGHMSttHtMnD?=
 =?us-ascii?Q?Wpya2JnF4fAbrqbrpsiLTPpOlWgHN/J3DYtYpIF90LiBSDrLqqLrTGsXjEnX?=
 =?us-ascii?Q?hRZbiNS1r5EUWtLYrjaMZO0B4HNmqCtLMpqkaiApdW3gj+qlHcLz/7besOZd?=
 =?us-ascii?Q?R7CIJoDpmYk3C+mdcCSAmLDyVJ88zx/Heo3WKy78GMLDPG7qYR3oVNzZkm6V?=
 =?us-ascii?Q?hQowMyxME1im9lno9b+G+ykCjGndr3Ow1Cpi/CHwbvGwJmz9LSIkBkaWgcos?=
 =?us-ascii?Q?8J/m/0D3PK/jVVLildJzH1rshYFO54P/ENfKUVXYraADIlwE5Cmfr9wHs5RV?=
 =?us-ascii?Q?D8+HLCnv+3BfregNih+k/pX4dU7X1D5bV0OnDmyL4qIfGJHr6DHvKA9LsHGe?=
 =?us-ascii?Q?BQitsWW3RsIPGl35nS/O2zweF2GGfoMzQOiIfpJtqIhnu7ydJgRjsc8XtHEp?=
 =?us-ascii?Q?38HGDM+N+ZV3uKHyXCQMgAuoA+C9c/mkanAY0R35Q6l/8dijc3nP+qwcxlcX?=
 =?us-ascii?Q?84r+PJycez9w5GNIFfd6yW5CIAD4hqJ8eIr5v9L/akk/nHglRmihnNCAhN3X?=
 =?us-ascii?Q?1AoOIV01VBo642O9qhtJQAjy0DlRvuDUH41LMQzH1TwAXF3x3C0oVO7Eyuq2?=
 =?us-ascii?Q?G5KJlM7/jaSG9eBeP7eoOTmuPy5t1EzEi52qyvGSyZ9JHJAiVW+aczG+yR+o?=
 =?us-ascii?Q?aHtYWk0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2QdCxLn+Ez5NNVWPe9og4sJiLq2vp3aSPmXA3ZnNCugIbNyvE2yINY1Z1ntz?=
 =?us-ascii?Q?b4y8LDsZn6QdPDV40+hbMUQSpPUr1bntOs5UdyvhetUBx81xcOQhz/DfUV8+?=
 =?us-ascii?Q?E9flJl8WRIFj/Z9gApAPx+3iUvOfDuG0j/hIdHpPoWZ9ILmY7to98knFuDa1?=
 =?us-ascii?Q?K/6ieTd8UYV6g2M9YgYh069XZ3eJz++HkcTkVAsQTsbn1JsIrXfw5TwyoNvR?=
 =?us-ascii?Q?nWHBYOCbY9aW9IJXviGkrhHyEa5Fw38UY5xvY966VsD1WSsI/zg991gjFgS+?=
 =?us-ascii?Q?kHj2PHE7J5uHoE3sQ8kk2nFItcmO+F4B6FOwMOhgl+a5U5kyFOaSlZdYvTZy?=
 =?us-ascii?Q?XXI5iBLSaq9l277Kjg1l40BbaWvue6sEpJmsx+hqq2uQQ1JzHxuQnUvh1AMw?=
 =?us-ascii?Q?LwtVlofgeqtcqpfHf7EpQJL0GYG+DU729GRCaA7NlE5TuX28DCwwT7WoZ6MV?=
 =?us-ascii?Q?9YNm+bfjuuDG8ip0eyu+jISbHNVKQJzBNKTzW6zAgC+tqjdIIluoXxEaGXIm?=
 =?us-ascii?Q?s7AXx8GQnDVv81iTa76R7wrx6R8ovzER8euX+cpnhHZvf6RFxeKXZksrS/Kq?=
 =?us-ascii?Q?5xymVMIKjYPXPGOvH1oDFtvpCq8lei+Hn8yy0ZBs/iUeEt6FtKKKaJ7tJrRu?=
 =?us-ascii?Q?tq/Bu23UHkNUm+b2VG5Ul9Mqz1fe4IskuYIOkMIIcmTw8CnpDTnU19cALz+E?=
 =?us-ascii?Q?UNhLLQWpq2l5J5AadBfQfBzSKLTi+5jj7LMbRnneSOzbs0+FjA3PZWD/Vd0N?=
 =?us-ascii?Q?a3n0uqM54FPovCLxQHe9b+sRZ/53ZMLgSpvG+dmddXSy3AbIxleVWH7tqzLK?=
 =?us-ascii?Q?hPGAJp90lCRUmf2ggyPSN4lEaM3iD2rbEm6kUv+ydDZ6lQRUnQnsgut65sne?=
 =?us-ascii?Q?t5182Z5ShAdKOrPTj2ISfYYvZs1Z4ACCE7Xx/pc+18s52EE+Y415bkAvltvP?=
 =?us-ascii?Q?PRbFArEobJheobYuMq4+ltS+VLkpQKn7yRbRCBCT3g8QoT906bJNP+eMJlFe?=
 =?us-ascii?Q?9/paoPhRkMXNfVaIzKvxXZyb81kNYz2nbaXkay7oQtqfrb6OSQxmGQzBJpTu?=
 =?us-ascii?Q?NRtg8FjMsHsVwGPimtlcSv6C3hvkA40VK6GLq30fNR7UnZiKx0igHw4Rz6Ig?=
 =?us-ascii?Q?4fBYjSYG7VAmpxHZLGBItVXASrunQa+D7DWzJQv4OVT71b/qd4P7RQnqcin9?=
 =?us-ascii?Q?jsY62rD8eEwVZ+nQanftnMB7hQV7yIth3ghRtetKZiiyqeMGxh81cjKiWEGH?=
 =?us-ascii?Q?tgxGICNPcbt6vPIUgPcwqJTdg1ZHCR52vhTl/z/uetcItHkoyCTl5zrmBWAH?=
 =?us-ascii?Q?5n88HG4gjp7CPLZWHydYCDrjSa1qfI9+xpmOEeNnM62JSQzFjJNH0T0wMzPL?=
 =?us-ascii?Q?tuebPQ3m11LwtO+rj3aM/OzEi7WQN7sJ1HoaSx5pOMnWp8avOeGAcxD3YaFY?=
 =?us-ascii?Q?U0sv6rA3DibwD43DeUTyffPQPIQBdH+SJ71N18wPxfxNfYkjFpX+fVjtwBvj?=
 =?us-ascii?Q?uaSkPQX7PWSaephNHI4uy/H4gYaowEskr93rFoaaTJNLyQgu2U/78a3jkt34?=
 =?us-ascii?Q?yMIn+08oYBK6dy+TqXGDQLpp6HEwzKLaBAhAgqLXRzM8xHxH+6YlTvRscRpO?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FhcT3N6uRr0H9f4LRH0ys7EHGaDFZwGJbTXMldeKCVaabpLC6SXtLzml9pEWdTs6hPRbUKNqVnrtlUmjiv7jpX1WifLohyxYmohX0IhajMA5dzFIOS25zH/BKFrokXYSWAVWwp9Qyvzr9AZvetWAYYwS4UkXdcqVbvUZGUM7r/jr1IW1AbeIYhfk8iFt/eohjEI15AmHdueIR5okeZkbSRly/H897WVKSJ1uvkMuDTqbg5j5hYlpCNxMvpo23j/OxPOgN2jE/At9U4SNky8CLzWwHrV0XCcG2DJ8vBptD0OX3vMmsN107UDWKRM3kQ31sGcVPrj9RDkwQg32IBrLAwPFBARt+ydHSp3MgaLrt1QtiL9zLTd3gg3WleGqT65qUfeNB814FPmBvmi20JKhhko1ErxUwZScksVRehsbN9lx3306Bk2gwXaKmpqsLMd2qWY3ylE7EVHXK4/HofXy84BV2f7pHArRS0Zmeq3zxbmOs+0U2BIn1AwUBe2CjaJqbKF0Lc6O3Rr/0Sl5YwIL/lhVeTmlhDAIGc6matHXp73yWJIZJoQwGAXLzEMhr4lYlzYLUCDYG+3oeGyqlN8FxZAitVbVqhHb7v/hx8Kekw4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4101c7e7-9b50-4c21-7ede-08ddeec95d5b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:17:57.9273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Cgi21EidaoUMV9kQFjp9KPCoygKq/eiPu/OPGQmxHCSFiYX+lzF2PMJkkG7BkhDTa9arpYYgCUZ5M5FHMeWo/1usNadq06fqOR5aOUe7fA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080114
X-Proofpoint-ORIG-GUID: vK4v0V01RGLMVobsGktCAHYVYS9yigpH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDExMiBTYWx0ZWRfX3bTaTo6cyK3F
 lKDySa4qr1O80nOFvSSUjXgnbDyoN2He4RkzC+ah+rbDRpkIINcKyju6ln/yB3Phj3vs89cuqiq
 B+KsYaN26Jpx8Kl/JcJZ23SFz3Ow+J11ynWhOZHsdI0o6eboBV8EX4ke3bZBlDjrC4b482NoMqh
 nKdUddqXnMpWxBzj4tiAiFcd8PrugWzzA+mjwzNL8t8yiM512w6gDOLKXhsjF2c/6cPWhOH4utU
 9KwiE2WuWy2d0/yaiHaRbFG3zYifYVI00Bx2hn62ehYla9TI1TDr+IitCtY1N6WszRI0NiJ8rZ0
 aG+JZKvSIaI90muf272/XDPdf703PHbyMnnr3KEsTqu4KdDr7nxvzMvQ/GS1rNUuxsJN7RBzFaQ
 QHI4ZXKMo/xCpDxUJ/5jftB3avpQAQ==
X-Authority-Analysis: v=2.4 cv=MIFgmNZl c=1 sm=1 tr=0 ts=68bebb81 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=1-S1nHsFAAAA:8 a=20KFwNOVAAAA:8
 a=Ikd4Dj_1AAAA:8 a=SRrdq9N9AAAA:8 a=yPCof4ZbAAAA:8 a=7CQSdrXTAAAA:8
 a=VwQbUJbxAAAA:8 a=37rDS-QxAAAA:8 a=uOfGiP3dBfq78NCPK6oA:9 a=CjuIK1q_8ugA:10
 a=gK44uIRsrOYWoX5St5dO:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=k1Nq6YrhK2t884LQW06G:22
 cc=ntf awl=host:12069
X-Proofpoint-GUID: vK4v0V01RGLMVobsGktCAHYVYS9yigpH

On Mon, Sep 08, 2025 at 06:48:57PM +0800, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
>
> I've been actively digging into the MM/THP subsystem for over a year now,
> and there's a real interest in contributing more and getting further
> involved.
>
> Well, missing out on any more cool THP things is really a pain ;)
>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6dcfbd11efef..34c5cc3b05cd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16238,6 +16238,7 @@ R:	Nico Pache <npache@redhat.com>
>  R:	Ryan Roberts <ryan.roberts@arm.com>
>  R:	Dev Jain <dev.jain@arm.com>
>  R:	Barry Song <baohua@kernel.org>
> +R:	Lance Yang <lance.yang@linux.dev>
>  L:	linux-mm@kvack.org
>  S:	Maintained
>  W:	http://www.linux-mm.org
> --
> 2.49.0
>

