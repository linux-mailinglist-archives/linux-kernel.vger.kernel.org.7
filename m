Return-Path: <linux-kernel+bounces-801147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE099B4406E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54355464C8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201C123DE;
	Thu,  4 Sep 2025 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e1xoN/ja";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XvgZyFBr"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60966224AE6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756999345; cv=fail; b=C3yFcQG3bO6LtKTTtHdV/lOJVdSaUIZGfD6UN3GfdbpPeNA2KZ6aZiVmlmkYlikVIBVfqsNkInCXEf+oaxoIiiKNWSgg0M9EOhQtmgfxV9dmLiOzrdwTZQbQN/80t3rYqepEp1WTpir8JZW7EOVBOMGxULb4IXB5rHgPj+CBUps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756999345; c=relaxed/simple;
	bh=vLM27F9YSOQLLxoWTLGkI5UijBL9R+LqQuJ7C4qwtp0=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NcNNSXWap+N/LPF8xjjrZMBSky3CXtoyOPkIsU5axHecM0mXuXzxC3Rm2Y6uagsb9miWJikWXI7541lK8wj97Wb5IZ0cj5BpqCcugXFUNPUfVP+kjKeg1b8A0CU/Lhja0IR8P8dNsi22eKM/dW11Z4zyWElywy9Sd6sE0dwFsBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e1xoN/ja; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XvgZyFBr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584Etrdb015358;
	Thu, 4 Sep 2025 15:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=HNc7g5dHxFlDAV9Lmz
	b0s5SRmD1kYUuKY+Kz0GLMItg=; b=e1xoN/jaqEmI3eiBEuO+17McwhRd23NaX2
	FNbWDDIwbTXTM5Pft0IniT69sSqpsqlRLpxu7PNNQKKpxLo7ix8ERkSTKZKQnk1H
	UDvD57rootTkjoTLsXRj4lbpS9pP52/sW3k5/PAYxvkrRFop0mJQW0CE3kZB/3Mz
	yIcQ2xDVMqOBgoDNQKh4Dzy5rzs7Y+deOOV6VFm+AKy1wLDhOHLiSUNPQRdjauJW
	cQA2FW0/U1sROE7Tc78vhp8Tq+4VKhLcjrFoE/j9ljnD/7rjOrNZkB5ogUxDRV8m
	zSd9n9zvEqe9lKlsgjyy5YlPj1SbfwBbOsBbIVQpowlN1mzdmtLw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yceag4y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 15:21:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 584E7KOu040885;
	Thu, 4 Sep 2025 15:21:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrbed8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 15:21:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LU0dM4/1nXQIF+s5+LgEC5uv6BCZyWdPmvvzjNqjXOQFeXDjznrOhkRzUFDaMd9qMmfIEtN4loFGpq/RiCEuVQ52tYmZElUIDvisJCP72/g2lJuhMOP8TIR1pMMkcco2ShJsW/NA3xQ8PC2rhUcyYyYbb0YaV3mAysV6f4QAQEaQvqRSe2QyY29wi3qSX6B1VEDay63TSaWD5p2TiVaY4wtwc9jicqJj9FeCbOwXMyWsdRbfnghDx/xrJpNOS4vgsQJ036Q7JLctFKNBRiW2RWZh4jMFsHNPHhOyXzCJO0U7gzhntGttB+Jn8eU0bQ9gfjDO76rMy+85L2YzmR8x8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNc7g5dHxFlDAV9Lmzb0s5SRmD1kYUuKY+Kz0GLMItg=;
 b=QzS5k+RSq6ftKNmLk7Q76GZPfPtcGoJe542M1vgnafsnPDVp4l6MmZHpn4q+h0EC2uyAi4iSHlc56GBRBrpkcgtdWRlN1bDPyx3i5WCdvBW6QlScyYJz91QDKwvx124mDFQZROfVhUjN7DEChIMleoJWoPwCH/uOA/oQz0EJQajbz2halqhZVOk0LFMqBzn7xkZu8QjXzGv4fqxe92M5N5bcoGv1MdcVWi+qkjBkO++LzH0QBqZsCFR9O4trzT2RtAPGUfSvm7foLFt2Kf5304MzeVmTKxPWBAnhxByYl1RzCd/2fykWUYDw3RdMKj67aTVKsHDPtdMwyJlqZL3iVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNc7g5dHxFlDAV9Lmzb0s5SRmD1kYUuKY+Kz0GLMItg=;
 b=XvgZyFBrG1a2zSriPkZMbC6PErcS2JgjB/AMgpTA7/ncx2Vd43c53/797i+8wJZu0eG7pW9oBSBu1opHU8HGEcujc/qiI8NWj+PVz3QIqT9DpPMESC5WxM7HF7gxX9CPw4CdcubajApixWAF6zhEnXWaQuG2UKGKUBxeq02LaFM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB6074.namprd10.prod.outlook.com (2603:10b6:208:3ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 15:21:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 15:21:33 +0000
Date: Thu, 4 Sep 2025 16:21:28 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
        bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 2/6] mm/mmap: Abstract vma clean up from exit_mmap()
Message-ID: <2460fe1c-3e9a-465a-b164-12f92aabde00@lucifer.local>
References: <20250815191031.3769540-1-Liam.Howlett@oracle.com>
 <20250815191031.3769540-3-Liam.Howlett@oracle.com>
 <bdb27f25-d979-4dce-889e-a2fd17fc06a5@lucifer.local>
 <ft4brzgr6jitmyfs4jplbokpqoz2z2ejsudfrezuke2oqygbs5@b5i3zaxgxrta>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ft4brzgr6jitmyfs4jplbokpqoz2z2ejsudfrezuke2oqygbs5@b5i3zaxgxrta>
X-ClientProxiedBy: LO4P123CA0598.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::22) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b8ad070-124d-4de5-4799-08ddebc6bb2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZagBbo1+Cvh8eEc+FiXYbhtTlVe3wBJU3VxhFA9F4vXZjkLMYJcyuNVDzv7V?=
 =?us-ascii?Q?6AmzkR7AQQsysHUojWZBn+bIfJWjv+O7oaoiCgMqd7nOBwF2TS0FIGhn4xVL?=
 =?us-ascii?Q?tV8yHW1x3fyZDf/So5IRtmXq8HnqloBSwLlz3MA0/ClwazFRcJOpyDOx9uyd?=
 =?us-ascii?Q?P1OzeljqwVGr5BItmnUvjoUzfU7vyu3lQAET1jRWM5Zmi8gzs6iYcpPzi1vr?=
 =?us-ascii?Q?FgBHkgRu0y1y9j76hf+sI+0rwHtu1sbxY7YnOX59UW53XaBjeTX2WjT/uPwY?=
 =?us-ascii?Q?pC0MpJMrwMcvDvNfl3JLCwENhISscHyumz/QGNx0xY3ITon4POCwQ1SXfQxf?=
 =?us-ascii?Q?B8hmKULLqgVCR+S2JkNDFJr4of6WdOEooJOyqRFKvdtlQ2+5xm1OoDc0KYPV?=
 =?us-ascii?Q?fGoQ36/XIG8e5pWBZk0qI0aSd0qhSDDXP6+XBPk1rgUaW8gmRZHEusB726rJ?=
 =?us-ascii?Q?ehNde+krV93l5WszKE4MjG8dr33oL9g510PW+DN+8sVUa2lwLCDX7lf2cYF5?=
 =?us-ascii?Q?CdXHC8fBcY+aOULMD56WRwj9tW27LmRr0j9eLUtgnoP2aOfebKEWj/PrbEC6?=
 =?us-ascii?Q?FyN43O9nnSSfTKbfKI2/9WILQc0KfFxSrmypmB/f1fEcZEzudCwkXj5V93NU?=
 =?us-ascii?Q?ACRV7C9gcgJZQXdhc+TfMd7IiAXfaEbY6dJn9/Pjb8it8ihcA/GaW28EZsh+?=
 =?us-ascii?Q?Enm7jjCy45v7plvZynSCQZSX0EntqFyBOIX1/3RX6TuNMNFieIdebPM3Q74R?=
 =?us-ascii?Q?+3XLYXlEUQ/Ve53+9bzHQxoRcmNH0nZNSWg294AkPjxneiyfwxP8Cmh6D4aa?=
 =?us-ascii?Q?1oyXCzHvHVJI02xpfG1ZqHFDUCYM9apSiL99HVk2lDLFn2iNVQQ4EnmbAqkC?=
 =?us-ascii?Q?HkiZpJgiV7HHqbDFyIDxFzoSOJOycgoaXU8lr/d18lXh8N7cAf8QvVHT43eB?=
 =?us-ascii?Q?+fzqmN8+Ekd3pWHWoFZejlGyFEYmKbIye8Lk7g2oFwAOnhtZulF+XzUdQsbU?=
 =?us-ascii?Q?l+IWMvkP9JQ2Tz/waxH5JthrCYkS9Yj/zAa6jf9ZUuKvDG576BNJgU/MuG+D?=
 =?us-ascii?Q?Qg+CK5+8rkL/0fze5vKu69rpZsqR/Fwxh9oSSlciY46gWEC2ETOxjTsD/Ek/?=
 =?us-ascii?Q?cM8ue6DMbstCgeAi+W1ocqRDV/TjuvkbSosA2vQ+yD3EYXpMBTeTdjhhPsUt?=
 =?us-ascii?Q?x4AWLXzPbIC4fX93Tlqn71MhBcqMiL55ScB/Vk6lACU47WwczaVGm6dB1gp5?=
 =?us-ascii?Q?7w2gLMuT3uSCVYciRNZSOJFgQ2bfFGQKNq+NBlYelwflVuNQHEJL03QHqNYJ?=
 =?us-ascii?Q?aX1prXzmYhI/ZzhqFR2ioko5ypKReJsHyZWdNyp1t0rzwXTOv9R/sJp3r+1a?=
 =?us-ascii?Q?mafaCXOWdVGdg3IU6xUBwwJ8DhA0sqKE6G36HE/E7XfovjaviDMT73lKpU/s?=
 =?us-ascii?Q?tcdXV+WRiSUHvhdqKx2Nl6VKL7iqfm976OJBed8rFGTO/PEfzUFxww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b+sB/YzyZmJPh3CENk+3Ld22c8pSoWaohFSQi5l1s6XjIprb5YRXt5ifk1Q4?=
 =?us-ascii?Q?B8eUPHIDc6VoGjYUBvntlie0bnxhL04BrtZlGCC4i7kQQu6P5BC1RsD7JxP/?=
 =?us-ascii?Q?zmfBl3JNHaSAKfuc2jwvl558CUdCzKlMNsFtBbL2ZyDFW0kTcPp+9BchhXcS?=
 =?us-ascii?Q?tzwT0/LWr7JrQC47ET3jxo17DZOunk+m8JDQv69Xcl7qzf1y+x+EfcFDM/Ga?=
 =?us-ascii?Q?Sfn0ToZK2vpcdOBspgZDy3cZiPBAMWpPmOkgeXc+ZzbqSSN0dXZEvbv8iULe?=
 =?us-ascii?Q?4CkSz7vu261OhlpoSGtiRgTIe9ldmqHBQxDQHIEH0CgQQ32ilOF7zeBLa96u?=
 =?us-ascii?Q?9Qogglmj/VflrGFsVduWe5PQODAMTEyvwgEWII98bpXgv3HXqOTjosKdgLZx?=
 =?us-ascii?Q?H5hKu20hIq+Ujutgms54PG5iuztB5pucGbqG/3pqZjRFfr8KhOHar7yQXrxT?=
 =?us-ascii?Q?yOwMY2ncw9Cy85eLkUGPnswFaJzL/Gmiy8ZaCrJfcKeeth5KuoDAE1rJ6prx?=
 =?us-ascii?Q?XsBEF2iuX6rmBceWd+6w67E2xFL6pAFZ5FD83rYkbzEUNVsM48vK24oUOP6k?=
 =?us-ascii?Q?bqFfCNpH/7ACLTmd1VyGpOBwXPkqd2MAzVMyct0RdSsetvB/7c/GBTqoZI+D?=
 =?us-ascii?Q?G9mWqf4DlPOJ/VJTduxujxdTUOdFWI0s8k3SXVoiHD9I05Fix4vysGGNCBn2?=
 =?us-ascii?Q?hNhsgrQ/nKxNW3GFLyyJJ/pIqlMW+vAU8huxaHfdNJBzoN2XdGqGIwDLEx+N?=
 =?us-ascii?Q?RkC6MLykykKx1YtQeeO2RBct8rNxvpfxSdBidCveljnQPEeX87Iz0Z8Imbdd?=
 =?us-ascii?Q?PeoArabfxvJ3N8XGQy84MDJSCNmd0Rp85sbJ3oYaLZSqBI+Bze4w/BwVLXjD?=
 =?us-ascii?Q?0eXyPA7UYgqfoO8KhGoUjL8OPLKKu7z+un3f3jOvdxvroXCDCf4MuPVa/RRY?=
 =?us-ascii?Q?bzrS0k/2KwWVl66shCEh4K7qqzI8/1/epsECR7CiRn+smO0R3dvFKzTf/24p?=
 =?us-ascii?Q?mV+LuRpu4cW4hJxOmWdb3bdz1ACyQjLChHujUIAt1YoGUSsrQTakdmHhf41D?=
 =?us-ascii?Q?7S/PxH33PJY2USpDZuecbfYxii1EvHmVpi6d6Gj7DHXtN9aoIvL6XIOkVSHP?=
 =?us-ascii?Q?x8qE3Rt1xOFSFF1QBVP5JdIDvBW/T45o/NaPuLSnlm/kHmlnsyXwq4RT2CZD?=
 =?us-ascii?Q?RQ6oL6j2TMow9+A5QE6pFLMIwVB7ZlQ+2qw8lZGhTj//x3Go1NJ9ejLLBIrX?=
 =?us-ascii?Q?4WqCzcUiZTDX7ZrVNRNcx0zZ8d+svmMuB7Virq1bQ3WrTuDYiYqv/jZEr1o5?=
 =?us-ascii?Q?OXYFwyrDuv3vmDslg+tAwLpS4T8QzA991Y4UbugkYnNY/uNJ8hwDaui74xd2?=
 =?us-ascii?Q?7HNO6BOfd2L9//XkzpPhonLYWMLN7f2fWcT4QTozVC84Q0rH1rEc8mcUoRTg?=
 =?us-ascii?Q?CGikWJG41rc7C4ZnwGudkfUZv8Utr19aXRJQLIxDwsAM/FmbC4NhgIWoallm?=
 =?us-ascii?Q?KtKYf4e9I+Xvv2oV3twWGF2fpRoyF2S4D1HncdyC8xgME9J+6jULHTytNRtj?=
 =?us-ascii?Q?ZV9pAgOoFBFRb8G/6TbCmEqZs/vy42wPABelIYvM+y5ajiJmbh5ffD8ofsIn?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6tVRfaoYccbjQiXtg9yq9U4yl2BMXdJjW5zCOlBWkOy5vk/cO+1MKwTNUoq37NoYmf8VOy6gQmzRlRrJAJOmPXeGmOrlZ+KWDjNTxdCJbiXpoftTe7ccm0+x/iP8koZdDDPT9sxsRrMh7SN21TTHTA5YR5Z+4WeeIsRew7nB1sAwBanRwFxMzkTNiYF+so8oPGcs7+NqIBhJSfPxXxC+BU3kJht8i+N3RkLeumyWz4E43gl7GN+n2LmeI4RAUC8tgxmd5ZJ7mAqKK7eZbIy8C4TFiJoXUB3+nyIA6SF5Ak8AaG9W1L5saJIRtpBw9m6CP3F8ji8FH6Il2okr06UZt4EOOuHa4FU5aXC9jeFuZ44o9rXWkbIJQqa80j59QkQSIEZYZ3VM/PINtIXJrftuR4VE4j4GJ03vFFGSZKGXZlJuzWcXUrJDDv5JV6Lh1jWkBu7mqJfvJaY2yeQ9/dj80h/cfqyRVu0hv+XCTbrcodJ1aZQRXinI/WCcqm4fFeF/j+4mbdWJDLEyBBWm+D2/cnv+D/lcChkCjVzb4rXdwZD/SwIJZbyP0ScwsaV0R8zQlR8zh0vby4i1NnZ4ALIFM7tyoDrOcA/6Aoco/nVS+0M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8ad070-124d-4de5-4799-08ddebc6bb2b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 15:21:33.3549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WeaoVHlB2s49SAbVCCfvHv5BZbKsY4tLUmqeHnNqhB9FexDZr1FL8U8qPaDyD/eVOdHJmfuV9niwpH3zrQhUrg8iVopGerfgdOxiG4js3VY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6074
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509040151
X-Authority-Analysis: v=2.4 cv=CuG/cm4D c=1 sm=1 tr=0 ts=68b9ae83 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=00Bsw7oZ_biKWIGMlJsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: _dMy2Z9IVOZePhW40RodgKh2PAp7KqoN
X-Proofpoint-ORIG-GUID: _dMy2Z9IVOZePhW40RodgKh2PAp7KqoN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE0MiBTYWx0ZWRfX1seJjWMt+M5I
 7tLGcT/hnQYL9nsuv5ug/kVZiQ60D2OLWcZYn33nkw9YLC/EQIt62mu9ZwsiU6hJdPAdqmBT8pD
 2g4KASxK1zF0Fp9ZhcHSuVeUz35nNX32p6p4AVx8llx35TDtBk0n6KKjsqCx5FZ/+Kb8edYuVRb
 RVrw26MjmUTj04bRc4dCKhCk5ItUxThPYEdo6ZxW/EeBFmqxheTEleTpHzXuw3aBHOfF4d7xXrb
 f3A3LwhEnPfHoMgmdFifca8oX8KDzY5o3G1h4M/QvamTNEIIdiGuZTGQurKYs1xtBCLYHK3gw9z
 NEbJNZaKQnBv9POoqQtt38DUpoYFfKbgK2xLRzH7+wyvf4dwnoP86F4XVjnscDRV6d913ZofDju
 DRoRsaSK

On Wed, Sep 03, 2025 at 03:56:03PM -0400, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250819 14:38]:
> > On Fri, Aug 15, 2025 at 03:10:27PM -0400, Liam R. Howlett wrote:
> > > Create the new function tear_down_vmas() to remove a range of vmas.
> > > exit_mmap() will be removing all the vmas.
> > >
> > > This is necessary for future patches.
> > >
> > > No functional changes intended.
> > >
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> >
> > This function is pure and complete insanity, but this change looks
> > good. Couple nits below.
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> > > ---
> > >  mm/mmap.c | 37 ++++++++++++++++++++++++-------------
> > >  1 file changed, 24 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index c4c315b480af7..0995a48b46d59 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -1250,6 +1250,29 @@ int vm_brk_flags(unsigned long addr, unsigned long request, vm_flags_t vm_flags)
> > >  }
> > >  EXPORT_SYMBOL(vm_brk_flags);
> > >
> > > +static inline
> > > +unsigned long tear_down_vmas(struct mm_struct *mm, struct vma_iterator *vmi,
> > > +		struct vm_area_struct *vma, unsigned long max)
> > > +{
> > > +	unsigned long nr_accounted = 0;
> > > +	int count = 0;
> > > +
> > > +	mmap_assert_write_locked(mm);
> > > +	vma_iter_set(vmi, vma->vm_end);
> > > +	do {
> > > +		if (vma->vm_flags & VM_ACCOUNT)
> > > +			nr_accounted += vma_pages(vma);
> > > +		vma_mark_detached(vma);
> > > +		remove_vma(vma);
> > > +		count++;
> > > +		cond_resched();
> > > +		vma = vma_next(vmi);
> > > +	} while (vma && vma->vm_end <= max);
> > > +
> > > +	BUG_ON(count != mm->map_count);
> >
> > Can we make this a WARN_ON() or WARN_ON_ONCE() while we're at it?
>
> Sure!

Thanks :)

>
> >
> > > +	return nr_accounted;
> > > +}
> > > +
> > >  /* Release all mmaps. */
> > >  void exit_mmap(struct mm_struct *mm)
> > >  {
> > > @@ -1257,7 +1280,6 @@ void exit_mmap(struct mm_struct *mm)
> > >  	struct vm_area_struct *vma;
> > >  	unsigned long nr_accounted = 0;
> >
> > No need to initialise this to 0 any more.
>
> There is a goto label below that skips calling the tear down, so this is
> still needed.

Ah yeah, sorry missed the goto destroy there. No worries then :)

>
> Thanks,
> Liam

