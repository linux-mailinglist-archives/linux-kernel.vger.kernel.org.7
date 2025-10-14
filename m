Return-Path: <linux-kernel+bounces-853087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8CDBDA9BE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057651893571
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A433009ED;
	Tue, 14 Oct 2025 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dpguHmMf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XaWm1Xnd"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE29214204
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760459268; cv=fail; b=rdFe7SpyFl/01+9p7ARSr9/KJ6KhqFBc9mVcgc0lzoBYy4bnWMGjUoVlOoskyqQKa4f+B4Qif4cJ0L/q3S8X21zOlUCBYuvq84zdgYivAX6Ya/0KGWQJygUIfHMh+mjeKipKGUUSPqZb2ALq93brDdfHad9OVvt24ViyxZpmQjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760459268; c=relaxed/simple;
	bh=+B5rVuUGShb/bRHr5qU+b25zdhYc01Pl5jJ86eeq2sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t6SuDVt0NBgb6Px8Cu83+VtBQmPFNcW+rfxuZOh0+JqgHvIypSgRe9FN7GwwoKnq77+VLag2ylNOhLu1gkEofNJSrS4bawfKFbe1tkgxc3vHE90BqRaq/V/d/QtrEexefdJlejEBsOzj3tCmzRXQ1cCCsaHdrxX6qEMsHMjo8kI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dpguHmMf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XaWm1Xnd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EEfKwW020556;
	Tue, 14 Oct 2025 16:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=+B5rVuUGShb/bRHr5q
	U+b25zdhYc01Pl5jJ86eeq2sg=; b=dpguHmMffBu820KGYnpP/2QxfaObVBIUwj
	4GisgdL8q7dTxvol8DdhD0fGWSAsXmM9u8yMTEIYiYRugftqo/5PH44TpeIFgVbt
	ISqcItz/fgu23xi39uGFFkv1Chl4VKBfNn3S5sRrdxo+xoEBVubrssyHQ1QPMksS
	WXMl5YBt8I1Chgm4OMopc+equg8IudFthBiWLltwAl3vWcY4OglkeSOXxdcJXP7b
	50ngnUBMQRf3gXvJKhMRtHW2Cwt2Q6S19/DQb7EXXoktZYHNFpp6bKLXsp9Kjaoh
	EP/7Tp28191J1iWJkflYDfmbOi4Bgtb7aV5ce2OIRYn6bMCJCeIA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qfsrvqux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 16:27:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59EEpNEV016801;
	Tue, 14 Oct 2025 16:27:14 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp8x231-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 16:27:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X59a14B68EXFM3xkLHB7G2VpTvbJ+ihrtykTo0Z3c5THActkHXykJBTDfkgy6px68ufC788qkiQizeBxg5FZ4kDeYgbfQr5d4/IW6O4QD4P+XLUoLNVHNQ1iIVZDV7s59ZWaUIqH21BnragdqZyohzPRo57upSwg/BWUb1ilwKO83pO8yHgmonmI46+vJLeC/WhZKG3zj+3rwOWuwoLwJe2SCvAmY1Zmyr5xqAqhEU7V142IZx5cRNQ6X1wZRSjenk4WX1Wwds88TSUAFhVitILoLrhqDLGaQ4DzCki/zjZ58H+a7BopyTg1KjnLdgqyU4OFp6k5c7Dt/MHGJwi+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+B5rVuUGShb/bRHr5qU+b25zdhYc01Pl5jJ86eeq2sg=;
 b=mjzipyASAGeO8fx6Wx/C+hhms/qpu9OZ0/VwN7mp6An2fhfIXT8UHEmPN4cJszDcngbyg9Wxo2tZKbTyu5XtnWHHpOrAcx4XHEzqmvLjH0rtjumh3Tx2PX3l+Tnv6QKNbHQo7XRGGjDMfyHX6QOkddtiyrOrUz14JqfwCMSJLcHrYdPHs+lDL8fCZD2dnm35RSs1vaYNimIQRyaNh7Ya2hZoo05bT6+skBLnSWYxEHD7cYciwx7F7zUsCL3wNAOwY2BWe9T+bwt9VVn90COcH4xKPTzlv3xnxJZNTUiYN1a9j7iCxbaLZdMprylRKYAzhC0Nqe1vO87fpUxU8FbTWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+B5rVuUGShb/bRHr5qU+b25zdhYc01Pl5jJ86eeq2sg=;
 b=XaWm1XndAt4vTVG9eNFJdHLCllGBFtItmGtoMr+3Hq4og4z9iG0i1g7lUyVV0CtM1YOn8gTz5i360CszebFV6xGbrXOWEZNZ5FHwQrO7dc+6IWRHzidisrw5AIiCEzIf8mdrBtC1wc0ZbBwnwyDSVnvd7z/fkLMEQnKbDQTpTEQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB4843.namprd10.prod.outlook.com (2603:10b6:610:cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 16:27:11 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 16:27:11 +0000
Date: Tue, 14 Oct 2025 17:27:09 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, baohua@kernel.org,
        baolin.wang@linux.alibaba.com, dev.jain@arm.com, hughd@google.com,
        ioworker0@gmail.com, kirill@shutemov.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mpenttil@redhat.com,
        npache@redhat.com, ryan.roberts@arm.com, ziy@nvidia.com,
        richard.weiyang@gmail.com
Subject: Re: [PATCH mm-new v3 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
Message-ID: <c176f6d1-2f43-4920-8133-f405e6756c5a@lucifer.local>
References: <20251008032657.72406-1-lance.yang@linux.dev>
 <f33735d3-b38d-4b6a-aeba-b415e6b24ea2@lucifer.local>
 <0bfdbccd-9d4a-409f-ae43-b44bb7347d70@linux.dev>
 <f7392f43-b8f1-4e6a-b9c8-25ad8a47f82c@lucifer.local>
 <95a223b1-8d57-40c3-8226-678b1db233aa@redhat.com>
 <57cffedc-65c0-44f1-8364-3a3ff9bdc760@lucifer.local>
 <b0e88b97-3c55-4be3-9782-4ab5e5d72ebe@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0e88b97-3c55-4be3-9782-4ab5e5d72ebe@linux.dev>
X-ClientProxiedBy: LO2P265CA0221.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB4843:EE_
X-MS-Office365-Filtering-Correlation-Id: f70f2061-a92f-4e5f-9b48-08de0b3e86cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uZjaQYCvsEp6Nyd+wA3D9ceMWK0LBC/oKi1/2CztAr5sHwPJUXi3ECJpmg5i?=
 =?us-ascii?Q?rzffIGWxutNwCd6rpvnblE0TQQMVhgF8HBoKatw2ql33tLQnuj8Rs3yzHEoX?=
 =?us-ascii?Q?5FMr99ldRInq44P7kCtYWtzjh8Pae9KUcaIGPe2EVyL1NnvjEFf90e094taw?=
 =?us-ascii?Q?8pARJLg4vgAErURW9eM9EGc6QJRpwpLcRfzuu2J54Ojf9amRSb63C/diKSCs?=
 =?us-ascii?Q?zKzPfRXWiffqpHZ1bDgnVd8+1nF4Ig+24DjMBQf/Doo6Av4/hv7v9lkP+eLk?=
 =?us-ascii?Q?Z+DzJwcb+Ned0X9S2rVMRmUhkvgPt21zeEyE+VTUtNPav2ny36RJI7qX7T7N?=
 =?us-ascii?Q?VgSoms4WWJekP7VdgPDQqShg8neYCrNpmX7bKdKTYcZetbovfTKvIWSwdKb4?=
 =?us-ascii?Q?YhRRKOn+jnhvtqwofhbtmnGOREIED0yB838eq1R6rKXecVvoSSLEzrL/bJA3?=
 =?us-ascii?Q?pG6Y3NqYiIi0Ong6x1ZlqPGUjkMMQd9fh8gu79FoNA2kJnL+s+Pj+xQ738eT?=
 =?us-ascii?Q?w4jqyU1VodKMy5uC+SEAKxvD3XgK4nl58FU8ZDXQBomvF/xzStvcE0EANJ0Y?=
 =?us-ascii?Q?teG+bJWJAWN+eMbgvvEk+Zr8uvSXLOWVtt1IB/elryQtNGhdF0GO/rJu5Ius?=
 =?us-ascii?Q?2pqYh2ew/7k6d0wNFr7q8dZyJ0b6HIX190U453jgd5BLJwXoN+OWmykPT3/F?=
 =?us-ascii?Q?nrm0bv1+YUUcfKebE+mybIahsNjV75gYYfxrGjytheUR0Jjhgdg7IgQbS3/t?=
 =?us-ascii?Q?OGEREAdqSd0aAbVpv02KK9f9o/xwpNpMaNLdWcyuFh6DB++eAI5z/83xAjwm?=
 =?us-ascii?Q?+4JnQg0IB4G+82EzoiDRDBiSezXDdzyITcmr7VBEvLrYQVUwlzqbhSInDNUG?=
 =?us-ascii?Q?iRipJxZX/vKDFj5P9E4BAM6OgfoOoHbACwVNskqWKO9/tDjYR4clpnziWiPW?=
 =?us-ascii?Q?+F+QUtZAbMh26T5yI/d0UobOiRRbLHDZfSP1kNkPZFEPru8JefNWoqszJLwg?=
 =?us-ascii?Q?smRvZrYRufNPRMq6XWfhXo7nNfp/Gjl7Rpnm5Xzrn3us+Ge+Y7VHtueatDj3?=
 =?us-ascii?Q?hW3XvIYHrEj4SkH3K0MLGMmkVv376rXuzLCUVJ7Hu0AgcYIdpMFGuBQuBGVv?=
 =?us-ascii?Q?tuj0o3xHmk3HbxYXlL+cT4HJRkLwVyWBhkHsbi8/U9OiO1UTgFHauOB82vjQ?=
 =?us-ascii?Q?k4cLEGB2qzLl67tMaRlTCcBlF5TKTjGvlJof9lJydbPIdkuX4K/a28y6d5fu?=
 =?us-ascii?Q?76wOKsB3o4r/Pypc9Kyz7xRYKduotDmz4cPBFwqu8mpOO54i3Cq3ZRlly+i8?=
 =?us-ascii?Q?cSV8nMdZWZwgtvyK/T9KE8hnjJvIYofvMZ1z1DkzH8Yn3KlQJ39bbX85kTrK?=
 =?us-ascii?Q?d8caKFn/9y2hkvQXQwzfHLlf+lg2dNvsGdp4KfazgY2y8Lapi4+G7k7jMdqs?=
 =?us-ascii?Q?bOWPgHV/dgDf3zaiGERsuvGP1BptKQLx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DitthsFct9ABDQsZpGFEqbD6C6GLr3bPSM+3Lpsu7ee0k83Hc7tKuje2hgm9?=
 =?us-ascii?Q?XpH+a5uQ97oPJxNy01ImqLES+E5J2in/TaqPa9v6HoJucsaEB/nMgKJvlmLl?=
 =?us-ascii?Q?unE8w0AC1fpM7s+FSJxV4WasXtgunxwC81KxHl73EBKsMyn2l1/EcEVD104+?=
 =?us-ascii?Q?XEId3AyKYFCQuF7ppRa2cvCo46I5Erm04kp1bKPJ1kPvXeCs4rv3th8ZwLpP?=
 =?us-ascii?Q?eiPqZVe2e2m1/atBsRIjP7+wzex8EWDTOdKiTxicPpWR1kCV9zK2nzzpE2lD?=
 =?us-ascii?Q?E+1H3x33Ia6UqgH5WcLCyK7fJN1ESqOY6eET5qUqU1v3a+qAmyYZOGmT1xEy?=
 =?us-ascii?Q?KSTTinUQubXKtotUcSVgHNUXG+809rhr3xoqRyTOzcbrMenY7h4OVIGpTL1e?=
 =?us-ascii?Q?ctVURH+ZzHyJSvkWhyYcZpvevf1+XlhKJtpBKVunZbDZdvjN5AbqAoiNjWT6?=
 =?us-ascii?Q?DSAvluhA8WeEb+PFuuLva9SGt7Kzy99DoMIR/oYTDJNSegpPkuZRVdF/H6Kl?=
 =?us-ascii?Q?baaoHwj2BzvGIDZRQE5vO1rn77dwhXIte601BO4FVmJhnhweuNUlGLeC1RdM?=
 =?us-ascii?Q?LVfuQWl62lxLM0Xo6VDcSqriSScP5G47KVnTHOAmmg7RNemW1mrBFXerII45?=
 =?us-ascii?Q?HiFKtvOCu/hqNPMf+1I2W4BF6dkoDtI57t+m26vrz+rpnFqb3XZxi8xGTWiZ?=
 =?us-ascii?Q?Vk5Uw1lNddYKp/jjf9LoIlmoJ3GB4GdJ9NU8FFxrlHLcffssaac1WhSbDpg8?=
 =?us-ascii?Q?tVaXQygmFxarzLRJKxWtXdn7y3ER9BTM4ih8E7dk3EKr5cYZObyvQSlAgnnA?=
 =?us-ascii?Q?mDe25nivKY4v2ior18PfVP96/PbvfWXaA2I54esql6+9V5bWSTXWT0aq2CBT?=
 =?us-ascii?Q?9lN3r3qEQbs3X74sSOgHpEPlvwISpJAGk499ziPBfXgr70uv3hKz49be6NkY?=
 =?us-ascii?Q?Moegt4uP/oYx69HXpLUkxXxR/Ms6jknCpxYJ/yNgEwbi7/8QMS+7HTjYNDtl?=
 =?us-ascii?Q?eMsBp54UT2O8iT9yEMgsCaUTnakZSPiZyzp9YvXFqsSnHrS2jOMlsOs5euOC?=
 =?us-ascii?Q?66+lyaU+KZUCPAW3lh4PCYB+KcVitNrJpyWchtkiNcmUmGPaV7/2DWV0XDZo?=
 =?us-ascii?Q?r5jUpN8ld9b0zpCXib9on7Qj4s0flDUQuurCc8AZFyWwNqHqF/PepX3KlvX8?=
 =?us-ascii?Q?yg7jHfSFJlEtj49nQfplN7WX86oEMkaq2cP05sZo9rc72Go14WDeaYnIuVFB?=
 =?us-ascii?Q?VsHycks/zJw3GVtOQ1lRn4sYwc32sieqvRn4EOLAm/+6j5yRFd93iK2mQOZT?=
 =?us-ascii?Q?V8bfpKL1HReZeKE8gzgC2pZF4nVouFdoKXR7Y6RQ2ew+YTC3uEx89VJ4l4jh?=
 =?us-ascii?Q?Es4ppjdAOI/zpIXTR0N8L4ySNjJuBkD3RNpFmBlE15sUeo8AYP9ico+VmLTL?=
 =?us-ascii?Q?9IYsdOxuKuQm7wHlxTxJW/sDFJc0J6bRLuq/mDz1AzRNeumT8xbclEXFKu8O?=
 =?us-ascii?Q?+yZQrbt0FUdHRIycIp8kUmP8HdFhCq8My43WWJ2sBYANqCyvw2d/O+LLeuo/?=
 =?us-ascii?Q?aas9lyqP2kbmUTfNOdcsFOxQt8erPzc5rgOUdzBIq8O0mHI72jNdNRptN0MM?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+zB8+iDqgie8iNVVYvcJd4DFunN3PohiDuo3IVepQ84qbxFab3yUzionZJXBmE19fHbjZ4hh4C9JHJLN/mggHxL2FY1bHxLfGn11c4WYJqPh+FJiLsCjqOz7WD+E/0JE/Bb3vWQ8NSaWysc195Ckrz3dyY3JX1gNfyWWsJuo5fnXJk6NgOaXOUwnnnKLd0+giwn3Li3J5H1kxW7YqKIloGuFzS94n2r6O0eSuxgBHDKmVO9fROkPadONM3FL8kNjA4r8+gQ/r2XAkIfjiC/vxWJcVl4zwFjt73436vf/Erl8CkNpLbO7Q+ZY0J/EDqPXtaCOiR/beg4myKAEEXFUoHswzWbdQek3HO7fwfJhXw5zvS2HBGgO2whmby1hEpbUMzMsD7FxhrC4Osy2eIgD1+0oaHZd6Az/YsJiXBRoYaA6R0CDF+SSpQ+albcWyZqOR7WEMoS1eadGJqcww7LEFy5rXuWp8c+7pZIEOU2wneXHH1txXaZqvtoW07sfLD/p7sRhgMdr+vcTMLN4UUwehGUPpDsWesM2HKaWOG/HmhwjnelWUE0dd8u3F6LoUcCT8dvtFBDa0B2LenBmsGpXHnJxHSmJ+u3UC/b+7HB3v98=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70f2061-a92f-4e5f-9b48-08de0b3e86cf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 16:27:11.1443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JlhangCn8o94dDzbgJKJ5spX6S9BKMkWRz85naea7DIDm41CLR3FZ9pJGipNZhfcvU8ztGxIao8teNG/AgEVoQRAfJ86kRy3+qLMMzjfig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4843
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=623 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510140125
X-Proofpoint-GUID: LhaDvkljrR-lWs1cU-xFtjWg9F-ReaQi
X-Authority-Analysis: v=2.4 cv=APfYzRIR c=1 sm=1 tr=0 ts=68ee79e3 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=jxp4CzYOe_3-huScVboA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMSBTYWx0ZWRfX8h4FufQAIPyW
 JbQJ9HDS/b+B9c7rxs0SkFDh9q5+5zetJdlfDI6xa4cVvGivQO/nkZnWPXkvBZXPWCEE8uuePHf
 gaPnFATuOWgSfvSzI7ZSdhGQCgnUC8qtHBAs4MKg0+qrMK0Uw95E0xJaVxXbX4TvrkFnQT8Fmls
 D4VvvuUr7nlnFYBwG7znv4yBI54dcErVTpzSV7Ldj9w2d2o9zaxXQ7cZeESkYOvEbb0sJlXGSai
 sBiVcth2GWTaeeDX8eqVPxsX+5OhZXbInC6yxF4IPT414JDJEF19VxxzUb2c+G/MPH+24KWUGV6
 6iFmoAVy54IeCfakkOXdEDVvt/ymJxQW0ylaK2SGdraFuC199I3kdlUtIPrti3mFDxzpClw/2zd
 qW2ijiluvy4nkNlyoPI3fGizpDfQ/A==
X-Proofpoint-ORIG-GUID: LhaDvkljrR-lWs1cU-xFtjWg9F-ReaQi

On Wed, Oct 15, 2025 at 12:09:42AM +0800, Lance Yang wrote:
> Hi David, Lorenzo,
>
> Thanks to both of you for the deep dive on this!!!

That's ok :)

>
> The code we've been discussing was moved to a new helper by
> another patch series[1], so let's call it a day on this
> thread and leave it as-is and just review/change the logic
> at its new home :)

Ahh, please do make that clear in future, I reviewed this on the basis it
was a dependency of [1] :)

I separately reviewed that on that basis.

Will reply there...

>
> [1]
> https://lore.kernel.org/linux-mm/20251008043748.45554-1-lance.yang@linux.dev/
>
> Thanks a lot!
> Lance

Cheers, Lorenzo

