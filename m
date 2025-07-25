Return-Path: <linux-kernel+bounces-745336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D19B11896
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F3DAC502E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33FE288C39;
	Fri, 25 Jul 2025 06:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KJnmmJQS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UgEdmnOs"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CDEA41
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 06:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753425634; cv=fail; b=RS7RWMM2rtKaKeQ11hmNMzvd1KFjX77qJQXcyYS3dOKgyD0Cgf5Pqws5BOJdUbUXi1kXwD0ykStDUEaQz27JdzwdFIAD2ZEa9Mr0dT/LKKNs4Hp/Wzf3gw4j7VmLV35WNMfZyUuw6bxKNrpG4Exk+JQ+luZkS1dUpjBNTHb0CQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753425634; c=relaxed/simple;
	bh=Lk2/xY3wagGkcLO3V3N6ffpNhl9jYCm7+p3iREwYSI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cnSbu7qGehdv8Wk9ROUxV+DPPuaNnstOkDZEP3Rweo1tdjujxHgvKvwg8FJRs2XFp/sVtgtnldp8v6wiYKV6vJM+FAdPLlld/aYIOgqT9AMynZHFrvFRf/oan52n9+8TWs0Yl6Echohw3aAEpkaa6fi0OjlyCVbJCQh8wqHSsAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KJnmmJQS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UgEdmnOs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OLjs7Z011804;
	Fri, 25 Jul 2025 06:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Lk2/xY3wagGkcLO3V3
	N6ffpNhl9jYCm7+p3iREwYSI0=; b=KJnmmJQSGQGFRvh7H/ECGIxlBvvIYGqV6D
	gXq6mS7MWXPXUNJlunzTrorS2PBhE/++FW/v6oJBqpyQRFkqOVFv6IoswQ9DqHAR
	0FVIWo975sWrgmEaIs+oA9QLiit9LdNxvD36AUcGVNq66ooJ/FtIu1VeJcpXd5M9
	VNkdYpv39IGkssqRrmGzx2bI7KwIrHmv8H3VAIdCOkDiC2WnHluMfZUq0tHAZIzN
	gfHl56/2d8YE1HaL3LP0QfJjvEkfh1k1Y0drPTteNFdeX4dGOwLfaSXidzpvKH4d
	tsPaPDhl+T+VCvqBZCA5KhTqZo1iGOeZHt8IXoxVXEdWhy9fIOCQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w1k8enn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 06:40:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56P5VLCn014387;
	Fri, 25 Jul 2025 06:40:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tk2e37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 06:40:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lu+xHmc0H5nEPKovoVqE4HWbnGUGk2ycHE3Sk7wr0n1Zc4HrVji1ZVa8AHRnLkx7zZ2+oIf4RkX0/fjjTaYrNWGFbI8xWRjwZUiJqWBwMC3y4/W0YLdpmyN1Qg1qNMzG/Bo9TlSrSv1332UdF4tkb4Gvy9jm6ZQBIEhxuFCz/VwlPOr1iMInDEJO99/0VNwsxzI9wXjopEq8DgBJQwC7hvW1KLYuUVbs4GHlVpJj4PnAyJyClTh8T8ok0Q18dqGiqhb1UYxtrd5gdq9L8iDto+J8cd7qbLMp6b8nZGEd5Vf2+y96hqbXjo44dTOVhWMkANBH4F7DeIONpEwsji2XMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lk2/xY3wagGkcLO3V3N6ffpNhl9jYCm7+p3iREwYSI0=;
 b=S+cwvVDhuTF5SGkdXjAScg/92CAtZWVtbJG+507vn4UGUYP0T+ZkjGDjaLi5KAnP0qr7tJdmQN7vAtcTY1Fo9SxBX74GABYdzKMWooXTNU0N2Dyz0bXsIrFLxjZ591JnAqcy8EvyLjawcnJ9M4qcVDRbma6lTANwDx2Gdx3JPkDn11FC6nq0BOaxh/rykfP72S2BFmagAFIDES+sRq6b/iwJcqMkJyfyljfEnTZy9QS7O3aNsmHSg7374qndc9KweJsQnYF+hzYGogND0mnCNaXkYbCZrdj3pDTCTNTcyQA5n1FY97ZRap056T14h01jzM7IHpnFIOdMRq/+uBJBUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lk2/xY3wagGkcLO3V3N6ffpNhl9jYCm7+p3iREwYSI0=;
 b=UgEdmnOsFYeu7/ewMDSCiI7r/ygojDlICtBHSKNMVIMkrdwwCah7IMBkafqUzohhqS8l/aW2m62mgXTRyvCONGINTxTH2YdAjAQdgfUfdZSHr2j0vmCDZUsBte6o7ocQ3r3P6izUrJiX+7V5gbnirKbcclRkjWYdWfvNC4n+axw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF6F34726D8.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7a6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 06:40:17 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 06:40:17 +0000
Date: Fri, 25 Jul 2025 07:40:14 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH v3 0/5] mseal cleanups, fixup MAP_PRIVATE file-backed case
Message-ID: <2285b146-ed48-4908-ab5a-f600eabe4d1c@lucifer.local>
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO6P123CA0038.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF6F34726D8:EE_
X-MS-Office365-Filtering-Correlation-Id: e05ba1c9-09de-44e3-a388-08ddcb461e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VakCbNwg6+f2F3HNo4I+zvM7prXcCYjBas2qCOV1BMf049cBS+Uq4QlyJeWp?=
 =?us-ascii?Q?57+oboH7iEf435cxUG/iYH/pY+lBTWAvAGowDbX3cT6kFcanozdK15ZkJv39?=
 =?us-ascii?Q?whT9J5ES7VHD6B/2U8wVe6qGYcVvoellH/1+Hyz4PZnuZ1UVYLwlrfPeep7W?=
 =?us-ascii?Q?VyBHdbKDkTxMaBbntr4jUh4CqxP0OGponILOv9AG5SdfF2UR02ygzNCk2ygV?=
 =?us-ascii?Q?JXG5LwK4jfqrJt9WA3ss7sEm22ZI/uIXOVsCgHJUEyWD9xqYmx2FX7wwj44Y?=
 =?us-ascii?Q?w/q4RcNS0Mv1I8SWUSGty6D7RrxX8Y4WUx9MMtLZVpzw1rI0HO/xbjxzSTr0?=
 =?us-ascii?Q?EbAsvh52J1ZPNvVzofAyfQ+vGL2BgN38VHPaOujqS3tBNUSE100vR/Ztqp6+?=
 =?us-ascii?Q?ThLiWxRmX3wRWu6LETZggJTkrgYu4UJNZlVym4axxbynmqxjyyN2WYEtrM8U?=
 =?us-ascii?Q?0TAb/yldF2L+rzYi8Ym5aZb4C4Co99ViiuPctWAMFnS+Iv8wDgnqV8Xz0v0u?=
 =?us-ascii?Q?pWfA6u2RmPsDdcpv1M1f2ni4ZmP1DZsmuXal9ySbitjJIiaBV8wKQEnWHLV2?=
 =?us-ascii?Q?pflRch6J0oR+NS9qDJRW1ByTqyVL5gwi+h2Mf0K6/DZ0nXybI8sx6UXj6QNe?=
 =?us-ascii?Q?O/GVEGwGJQXea/WyY3PeHSVo6U+VOzq2Uf/d8tYNLjxqUfbe5kYTVOhl+G3x?=
 =?us-ascii?Q?RIwLzMxOjBVl02lVJ8MmjHWFSNbRoF1ATP40Xjqd2xUHCMPev3uqJj4SuRbn?=
 =?us-ascii?Q?wU3BitpxtQe7zaWcfHBjL2eCTK2HzX5jPcqAbzjwoeWLPeber9Me4QZtc/8V?=
 =?us-ascii?Q?AwZeFr3KQNDj0ezlPfiKpPlNEdkbi39SeMZwuBivEpjlsMD1mGUSDhGhB23N?=
 =?us-ascii?Q?ylpMdA2rMf/TxCaFmhePEJxBEaFohEvY9AMyOWbb6cG3n7CHnISTAMtsQXFu?=
 =?us-ascii?Q?6Z/U1HhZ/+2G8x1iVpoFs1agxc2eusq600jEuSV9QDQPhCxGR7qEyFzUGrx+?=
 =?us-ascii?Q?wMarcJEZJhEqpuGWRCa62thuQ2cZRyB1c1EjKsSV3LGfvmbboynLI2L83+iA?=
 =?us-ascii?Q?L8qnbnMNa0m2dQznYVjKhwP4AGZjkHOF1aG7v8z6o8l4dU+ZKsEbfSiVCMCo?=
 =?us-ascii?Q?s2qPy/5ziNi0QNQxNEhLuxXpnOLFBhwAuZM4lRdChUQqkXXrIG3cagw0mKwl?=
 =?us-ascii?Q?FRA3FSUTgt7n1/Sx8hg0uox0R8ZN97RefWRIXmJTXkyZ/DzXQBKYDouOfLpq?=
 =?us-ascii?Q?ADAyHWfa9hDq904/JQB9B/WLP4PDVHV4/fl09eQgbDdgw1TdPnzI20R3K6t8?=
 =?us-ascii?Q?Edxsd8rcBngGE0x80xpBpAA8wvSJS4OOwnGs0AOXEigYicQV7GY5FFd4OpBP?=
 =?us-ascii?Q?FX3yLXeunHNooS8ofp8KOr/sobC89LfAVMkpR1412jcyn9+AE3FGC9EQyDN/?=
 =?us-ascii?Q?ThEE07RahIU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s7MhdOregeR088WOevxj1rdaNb3uD1ccNsBzEfgWaz+AYULdzkpBhC5uqQ2z?=
 =?us-ascii?Q?kFhJgvJTuqf8/5UciYqdD9L+GKlQLqX2nB3XHJ+fGMpKxiwQMnyODMBPiHIZ?=
 =?us-ascii?Q?TGACkGNrvnHSb40A4jvz4pc490TF3vwPFJ8wA+YvSaJLaRdczSgEcSZumtMs?=
 =?us-ascii?Q?W1LPWvvvvtfeaTsV7zM5O8WeixC+9FmznA40FVqyYWGhMnRJ9lPxoS9GyvnB?=
 =?us-ascii?Q?3hVQ0PilPM3C120Rly53/IMlJ7gHmwFCxE20YpC2Q0xZ6ghQThsGNMcM8YsO?=
 =?us-ascii?Q?8w+5wd+pC368l2g9GXOdbK9vz5j+aSMUzj/+Ks8kiNA5VtgR6E18yGWD9eph?=
 =?us-ascii?Q?+u2mJxvNT9m/E00PHNFXRaglfxi8j2CAYaNiPdZx1EHHZnQuY8MSK9OH0YBu?=
 =?us-ascii?Q?PHcjAhu9v0sbp8MUK23KwTQfIgo9k1YPnDUQISVuVwDnvfd1PYZbVZV4wH3Z?=
 =?us-ascii?Q?0fNPP7S5n3ThuXUhcmqWXqR1blJmIubKCbNjesKfyfRDSeIfn4TgxKqOciM7?=
 =?us-ascii?Q?rjq33WcRyI6YaCkIzUzqKx+ELfsCwhj7NTkNmR/qAeliPwmQT16ZAIxq7WVy?=
 =?us-ascii?Q?oswDg0gYiTNaKjs3evU896k400v8b3CLxhmiF2/yslrk50zjXwwLZgjh0UkL?=
 =?us-ascii?Q?18/ngOZporsBp66I25PkJ/2RU9Sm3AZLA4fN4RlCobGK9SzlnJaxxzCFeBRZ?=
 =?us-ascii?Q?eP0bfx9duMBmS5VTQUZi6sPLWGI6/9gJurPQSh7y+r/bJtTiEqFQdC6M6uEk?=
 =?us-ascii?Q?t93stkLc1kpNnM6daZxDWLX5uzxCXYgMrrCDG00VvmlUwhqAyIPBaUMOHeGq?=
 =?us-ascii?Q?zto0yYA9kxceR9Fm9zMkRm1RauMlRlh3dfeoTQNcmv8EbQAs7D3hGhcRGFND?=
 =?us-ascii?Q?T7MA1noZ0J0Pj8nzTIAA3XOJ00vf4WHjXT0CmIz/UbK68h5F5EWg5+n8Chtu?=
 =?us-ascii?Q?Gpx7K330EERQiuzex08qSYCNnyeWdy6Xrfpjr66mn0Wicwpq3vQFl4BlkxIT?=
 =?us-ascii?Q?ifLnYrW+850uRypdKAkM8QXwMpBmseTOarIIiWHl0aCJ8WPZZS1m9pWDG0FB?=
 =?us-ascii?Q?+q62Vg/9ymnfKrVvXo2zmThVIb99JmwiK/byLENuKFMhONaQ+XpXZu0wfcxd?=
 =?us-ascii?Q?y9Zru5DDrmovTszeBmEiir9FRRu3lbpl8e50c1eeLkbMvzT/KEz17eyyB8m2?=
 =?us-ascii?Q?AfXHKDFuit1B+BdrK7EehzMWvo4y9PJtsMe1nGu+HijdiV/2/3nAjOBMUUgG?=
 =?us-ascii?Q?vl+awQkrw3u/36GCSqQf4dcNKDGKNk0jP9xzVNW1PElTEBXgHzJQlU2rEDFr?=
 =?us-ascii?Q?MpLsiRfqU2HWmmx8dlIQ+ZV3cAZZnxoMHzsoL/kPGgbqxUXStX9xsubOpOIh?=
 =?us-ascii?Q?2sSkt4FiD2LhManF33oGhY08qOGjIw84liP8qug8Ut3v8FNNcB0u7s+LVgSe?=
 =?us-ascii?Q?W63vbG8ZCgOD0Vi+Leq85IIb8OEJxwSpgtYewsaij6XD9m+1On629mPaQLQd?=
 =?us-ascii?Q?pngNp+D4Ls9IVKAFHGINuy/yfo4B93nR97+h22zt9DmpV+F/WyiAN6swiczI?=
 =?us-ascii?Q?tdstfzrECleGcAC4escXjwHiX2HT1QmUq0Pi53inOhMwDvlGqquSPBs7k/dM?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JyFLAEDJ97M0T2HW6qH5snHIF7aB+sgJUMtocDWb5B2i47siUzoSXVS8T8K30YULY8sZuMh3w0Y2/X9x8hplUv7d6grPJ3kEIkDBB/DOdFK9s5zi83K3NR6lagIsuTQmlF2pCRk6JmaJRq8tQJQwxt12/77DBpco6ciMAunAd6OTpilzoE6gNpzEa4p8OoMH3ZV1MQwPOZD7E7J6Pr6YYR5WG3zjPx90NHIcHDfXB3lyQ9l0htj1qV60cN3MZLUNxYw13CZiMT5r0ACPxpKUBb7gHchgBdh/58P3MTHKsqjRXg+wah/LlfQej8Jul1uHUkkr+cOLVq7KvWPoClTb8b6hLqpsha5GpmimV8o9XDQnzBz/h4jF8Jg0Wprn9UX8wPM/T4ECiYWPYfbcW9EK/yqDoa8XSp5P1j4PbMEar+Wv4nL7xL0Do02aNFamuntJkwpY8bTlPks1OLmvIT+hiKuFbj2d1PnAVru5adnYdsznx4QqCB8Z6YKHmXpeo6PkP5IUaT7VXSK5F/g4AmaO9S/+3WvtGiPx/v2d+AXOX4PtDXjbteY4LzHZLl9eaWlX4QPFZwtW6t3tAFM40LbYLxXKPzAEBWw4mmkSdSSyoaA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05ba1c9-09de-44e3-a388-08ddcb461e32
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 06:40:17.2016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6Qvdh268mmSbiXRA2WLoXTnakl2U7TkyLgY6zRLIMTf7wEBTV3ah9jw+dg/5fHuEHnpJ87DZS8Ix64ewLoRvuyMg7CwdvDL4VSV+sakK2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6F34726D8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=447 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250055
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA1NCBTYWx0ZWRfX32Rk15QxUxoC
 vJU+dj24PPot/pdXd+T/TCqLw5XgxbgxEgZ3IPqSAir76Rd0WeA57nH9RC0hrL0UUrksYL36Ywo
 0RNwE9qwhxeml1ILPKcdyuzws5NzeacEG0SIfqOhPyUiI+jzVfM/jaL58ZDa2Mx91Ej9bKj25aq
 N0pkRibimsbkpqeksrvs2xywHGd4ZfhI9s+CUStq6nHocBfTnWimoKGJ740bvMpb061mSchSFTD
 ZJ+8zd+oMINQ56nyi8jL9FGDjXRzSb1BhjOpgNKIRFfURAg1hL1C8aqEwIGkciZxrwOtzfSm1oK
 Ke8eoIbr0UP/xhICUZB2s24VNbGEjuzCOfilmoYB9MwJbGuZzW2iTzs9cI91it4dMI3LN1S5tJH
 QA7SZk3RH8hij1sSukiUmu3oY/wKXhvvElv+bljmjX6Z+Lptyf53hVJz/qGyG5EJNmF3x8ET
X-Proofpoint-ORIG-GUID: Ugj9cNYEn3Q8PJWlG7-KPLqK5vhX08Wp
X-Proofpoint-GUID: Ugj9cNYEn3Q8PJWlG7-KPLqK5vhX08Wp
X-Authority-Analysis: v=2.4 cv=JIQ7s9Kb c=1 sm=1 tr=0 ts=688326d5 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=SLDz20RXPPZUwH6GnY0A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12061

Since there's debate about the semantics of the MAP_PRIVATE stuff I'll send
a v4 with that taken out.

I very much want the refactorings to land in 6.17.

So we can carry on debating the ins and outs of this and make any
_semantic_ changes for 6.18.

Thanks, Lorenzo

