Return-Path: <linux-kernel+bounces-817175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 661AEB57EDD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9C33AC15A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85976324B1B;
	Mon, 15 Sep 2025 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qe9xCSEs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aQusDMQG"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B753828000A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946337; cv=fail; b=uFYGYmKIOYk65WfVrgs/OTj9TJsqQL8ii5SUplj81rLQKXdwuYvzURjvEaifbZfW7vBnN1+33B+IAzMgw7VFqwU5NSB8t0Ox4aCEH8ZVkAFidTa1ViUBL7URoxjOoTb2+WpS4RkGyAF7Nna5MmFjUggLm+/llj94OFz70dE2n88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946337; c=relaxed/simple;
	bh=ouH6xRSVtYLWFqw1s5YqDO+yQ2Zk0lpUwlwH9gMPE3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V6tT6/1do6DaXJ+yOEBCqugBhO9KqGzXWEjzfN4XAHJuUeeSreE7Pcddf1ogWC1JbRc1g03vrCghpToi2kh+KzszO52z91neFJePnips2u125FgPyIesShAIbPEoZdy9BLVHGFk++/w8C1uvf9cHfoSdiUTrDPmE9pkJCOPCy1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qe9xCSEs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aQusDMQG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FENCYT024002;
	Mon, 15 Sep 2025 14:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=rOUFMEz9ZB7G73gmFT
	KN407LpCaxf1+uuRlumoDsvhs=; b=Qe9xCSEsVYtdrrNS7hLrdgLu1X4wrr82tW
	kgwYJesyhaohLutrxhRGVc/aGvL8ii32zoMuCQ6YJuIrYfbw/YAUxmq1X3fAM1Ep
	SITQUqtLXIh+rmZZ3RSIWdzVDES+AOhWn0jxyk0nkhxbioO80WqHXcS4c+Q8QXJt
	bjBWQBYi/cRVuJFTMK7yK/T6GcJRLfRv3gffXtA0DeKFxhdDdun8D1nHUXQhrHgs
	0csO+zz0x/vhDYMiwBaqJU5iFD0yaFs8eY2FpKbKWCvsEy2MbIms/GOQQyTgrexE
	z+rJ8A4UtSZBh1IttrM1UYZCftq+4+Nn4zO9e4Ei7cR4XJbD8lLQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4950gbjg33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 14:25:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58FCaGAb021391;
	Mon, 15 Sep 2025 14:25:20 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2b3h10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 14:25:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwaPC40hktRSTC04kZdNOTzA4EGmla+UFUEQOT2uoPOzcEmtVXkvzKZbM42N/xWIbIv20y0sXY4DsCb+yup1VsjPcfgqTGOLlkP+/llPAPvyV5cz8yhWoekdWJ22JDwOW8arSY3BOWgIWjYyLEihecyvAdox1Vxj3HmxslyyG1f9a0Ea79DRnJAKsD3Yeb4p/liaGL6f87kK/uwBgFu2Mhcdy8XAerljaX8OXQCElaPmmHznwtpDU4Yv5QycMq5ZKbku5XZBHzYgjJQYjrjw9ce9D/qAdiKf39uCXS5QgLiKgV+A40P5lNvShqL193O8rjwKAKL8Ec8WA/MakAK7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOUFMEz9ZB7G73gmFTKN407LpCaxf1+uuRlumoDsvhs=;
 b=Ojou5EYztsC7vMocKK6dVvzvFLX9rhooJaeYFNdX1A+B6HaNIXQA4MJCRprZx2FAascNMQfN2CwOjIE0TGcuF4sD7O1UKV016KsJvi6I2YhOqQUV8JAk7EGHipd9BehnRHUOsbc176s2dXBvvD1g5e1xaTT9nL4BAFdsr46ctTJUUJKJsPRZZLQbat5qMAXlT6u8C/ePFPu4wCUNmdDB1ZUWN6funOMYTmDX9KpDQyf4vRrOWnxT2oNeKzj8zfvRCpW3RyBMntlCMjUvjRy0QF3B7uU5MOJYINCdW8VEtG4Kq8hYXag0vkoGAOMtJlfeQI5jgTgy9ugLqjTspqeAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOUFMEz9ZB7G73gmFTKN407LpCaxf1+uuRlumoDsvhs=;
 b=aQusDMQGlzIejAvTc0u4EDvZaNAG8L1SQvGyi7EKzoIqE4vm3DPbA/kxUKuuvkzpaO/Xu7ChmoamZG2m5ipf8w+TI5qtaku2AP5Gu1JU8xP8DdqtTHRw1jDfZmj12DP4NvGbH6nc816V2QPz+2jJ64M00nPD+cCY0tmxt3Q9cmA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH7PR10MB5698.namprd10.prod.outlook.com (2603:10b6:510:126::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 14:25:17 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 14:25:17 +0000
Date: Mon, 15 Sep 2025 23:25:11 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] slab: validate slab before using it in
 alloc_single_from_partial()
Message-ID: <aMghx7WTJP9NHoNe@hyeyoo>
References: <20250915-slub-slab-validation-v2-0-314690fc1532@suse.cz>
 <20250915-slub-slab-validation-v2-5-314690fc1532@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-slub-slab-validation-v2-5-314690fc1532@suse.cz>
X-ClientProxiedBy: SE2P216CA0008.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:117::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH7PR10MB5698:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e71df0b-0429-42fa-f9f2-08ddf463b128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hIUlh2FfGuY59lkvmMMEi7SZw5MQ3Ylk0y99DaV7kAosMI/HpKJSQ2Fi8ga6?=
 =?us-ascii?Q?vcRsZ8U20/VKgnRhM8vzQgkOTU/MmiUvx/c0Hd2bW8aJ6R76j3cSQqX9eaTl?=
 =?us-ascii?Q?geI9Yd69mTEafRaugxqwV0UAM5FmOE/r/5LxoSIKRGrfRJuEW5SHoCWKT2Zj?=
 =?us-ascii?Q?YSL/89ahB6d4EFf/MEseMXSQqHD9gRWACq0+iqgiJ9PWjWMtjtXtRRGqT+BV?=
 =?us-ascii?Q?HBxSPg+MYZ1XeKiWs/EtI/sQQC5wq2RYjsRn8YtsTvrUlCRHmjKM/oqCOKQC?=
 =?us-ascii?Q?ZcSpj1D2CuCfaa0SmaurSo27LAzu/GN+i8uFBB62C4rNVSppoRE/nw0S8hpI?=
 =?us-ascii?Q?doDb/fmNPooF1ZXA0oXxAxI2/OyKAjy0IDPiCmG72rZhYygzu+4Y2P2kZ/b8?=
 =?us-ascii?Q?p/QXzFadwiYco3vvwZBe/Agnt3VPKBftv5079AWBrGMoQtU1Z4B9vKA/0klH?=
 =?us-ascii?Q?IwJZLkJC5a6SFCZdKhSpQ4CToYZ6nskMYCqpou+bi237Y8muyqGnoR8GK8/a?=
 =?us-ascii?Q?ast2g7Yz+64KedTb6mr86ixddGoIeXKhEZFCXN1/Zcsbrt5q7lWFk6ia+4wf?=
 =?us-ascii?Q?n8/2hl/Tn4fS1YAXUTlkEbiDGaeWgAEz1JgvySftT9lZIsJYnIrNZxp+17je?=
 =?us-ascii?Q?A/qZ+wEipn9zVoP4sHobJJrqs+xDDEWhSzmA2jUUff/SEmLVmmwFGoRM3W2W?=
 =?us-ascii?Q?vQ80mrzDd/AiXkQBLb4KRfcUMym4lTWDMNNf499wTkNKIiZYLdDJsRSuM1d4?=
 =?us-ascii?Q?Omtxy1xjGdcx/yGs2uZ/T3KE5XcvK/EAnBzS2++60rL88fYKQjeAcwVOUMO9?=
 =?us-ascii?Q?aY1kw7y7XTS35bGs8Gp3ZXYJTfuL6kRY0zYR50wgqs6Pfn4MJIp4UTTqiHrK?=
 =?us-ascii?Q?BLYoHjtwg0UFsLS9mqqGke+s9xsbqd4HxBI3JU8mlFnVXyMuVP7J3+nOYF7L?=
 =?us-ascii?Q?kWiSWlqYLsmuLInmi85E8DzjvDBq77/twQSAC/jDJL1C8VAK/+qfRIgVnZCK?=
 =?us-ascii?Q?+WLmjTkFD4V9Sd4uS50NM+elZhQcRvIvVKZGvO6xypTMkBZ2sm7+KyhiG1y4?=
 =?us-ascii?Q?3+aFGr7/9jJykCQfpTYJLb8k/pax2gLfrXbrh+VX3DxC2EOmqHWjtec5Gh1b?=
 =?us-ascii?Q?E3ugPXlriTHcXLGgJ1V8zWD5JikC/XY4CH+/u1AFMqf3PDaUliDgJg7yTcSF?=
 =?us-ascii?Q?nJ7bJ15rgZT+0kV1hQBHCvcP6/NrLrsCb1XSHX26S8BIpi2p+wqJkUxJw4V1?=
 =?us-ascii?Q?B8Mnnj6ps/PHQYlW2zrZkYRc0UFDmUACOS2nULJVoM6gRcW6mIXnqvrjfL3W?=
 =?us-ascii?Q?zq7G5YcivGhmEFY0T4XdJDyTtFDsrPJg7LWeF2qkrobGQlJ4XB3mvwEhs4CW?=
 =?us-ascii?Q?jE2s0gcyFC4KG2s13pB5KJmxrHWChDg7GFzRH3bmDV1nOG4H/S4Z5BxhwF1E?=
 =?us-ascii?Q?KrJwOR7orVM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1WlDmpxxaF6EihK95jveCOqZ9TvNv6fFR3XvXn8BCkq1z69Iz5p82Vzku9JO?=
 =?us-ascii?Q?TeZlcPCioG/9azlC6UosgVKzt/9WP2TksxeL+vXDJb4YBvfiW/9D25kDUGke?=
 =?us-ascii?Q?HXYg7goR3EKrC+EmMWg+ITE1TDeMnyj/FfnZrldAUzQ1Q66nwWjCfvitNpni?=
 =?us-ascii?Q?ZyhcLkAyTDQLiTsZjsD4jb1GhCoEpxDY/j9/YX3nb9TYXnANRg8ltlazPZH5?=
 =?us-ascii?Q?W4CITxEZJxbPN3G8zwTerfdsSqZ44XkHjTuinYkqNL9ylgwY8L3mNTw5OIjp?=
 =?us-ascii?Q?rMwFMUrey1eqIS42wPXD4X74swf5NWCtFPIAicg6XNzMlbLxcOS0VE5X0z9M?=
 =?us-ascii?Q?3cflYsktbVpJ445ttalWAP0vreXzm8slHCtdmDcrq2q5/6SIi5HziVXAVc7m?=
 =?us-ascii?Q?M7nRoxbjeDReXCG/UlSdCDODdmGQhx5madfovxMR0AR4XMw/r/7vbYBdeZ1Z?=
 =?us-ascii?Q?fqH4d9/pLxdPDgFfPsgK5f7xQcFE3lnU2hpVq6MByzjV6T9duw1A5j8G7Aes?=
 =?us-ascii?Q?7pLrpWyRwyFkTVQplFS902jOzQUfB1LAAVL75QxjkGcxllXBiJGjnBiDOxD4?=
 =?us-ascii?Q?S9fNJwn7sEXFeDJ3En+ZY5sdV7B26iv8VuQV+rbpv55OzzgHcH7czaL/iUUj?=
 =?us-ascii?Q?u9owDzi5Cb97LEbxf9vK+zvTcsBuO+Wx2kVAGZYvFzZ2p7y7h0/dAnjjQ5u+?=
 =?us-ascii?Q?7hWptjDaxKL9YLyLSSlbQu79QCJJO1KqBowtBXFTiL9L/eSIi5zPkIfpI8Oo?=
 =?us-ascii?Q?kRKeC+PK1eScor/PhBu/tTDbMHhDCSSeryhvLLI5X8mRcuIRESGirq4jCeMg?=
 =?us-ascii?Q?jm4D9B4uoNnc4qaDMfjCfE8I8sOQpvf05oFE56qZF6bMLassygqcoCZhAObB?=
 =?us-ascii?Q?qEJ0Xt4GYuqoZT551k95kTa8i5CMvBea+RaqYl+Cgv5WZmIqFecTKz0KL40A?=
 =?us-ascii?Q?QkJX6EmpwzetJ8WBekP0SgT8oAyBfgnOWDOLKdwXwecXcthJQyVweI0ZqYnQ?=
 =?us-ascii?Q?cpQo/2yW8N3hRZ0Sm7rjX/jn8/uref7lLoqurgbUwIUxMBPqGLu7AKwYN/Gq?=
 =?us-ascii?Q?m1/fJ3mw9vQ22D/HbRqMG2rKunFT518XsqTW4fnmMCrTl96YwmVnTfGdVVZR?=
 =?us-ascii?Q?muA/bnBVqOT/zrhJIiEpl/mouKKnJVqr3mwV+PeMAndbkg/BLeuy6qwgY7HF?=
 =?us-ascii?Q?3G3Qnu7/chDHNwBYPb28m9pjaV53RMXtkssDqktiAblfGUK1iKll/6KyTeEp?=
 =?us-ascii?Q?1gP5Z9VGxPS5GPG/TGkow9OxpTr69Dx6Bjg7vV6toF9D188PKQte25bXQCo5?=
 =?us-ascii?Q?bj/gh/0tnmiDmj4Gnpe9Z3YuGow9Ks4kD7rfwj5Pa0v+YpunZYls9MrVD42E?=
 =?us-ascii?Q?dyPmxuyb7kyqrd21pXGRrfPXzwq2ljQSr6uBkLqod85iBm5k+efdIEOHiCIy?=
 =?us-ascii?Q?Zca4A4me7cuxYgQ3iQjl9aCLU6xpPQakDpqcNzI93ckXifudnP1bkkc15q9r?=
 =?us-ascii?Q?ub3RFEb1wz3L60qYzGyWisiajkru7iEbNWrcRShUQaq46f/D5Rbi1ImGbwge?=
 =?us-ascii?Q?gf/JnqNnaKdpQAdiO4AsE00WcFe4wUTxhMGfhvXB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1tFViBR1oooQzM9ihA2/X00Fm00xW+htz1RPpA+1yiEjm5v678oSMB05GOIP2r97Nb0HthyfBYWCkDg7uNpwS9oPGyMFcXPs+McUXU/a/mciTsjYOzu6kDuIzBy5O6cJoWUiOwsF55zEEqqZEKWF4Gf7g+kujgVccr7mwq8jgWxBFMElz0V1GWDxDyEbwUSZCBSoSBjuNVSG3wtc8/+4kZvR0qn+dYgFpcwozU8CwaSmhU+xxxXUt80kLzsMRjhmpxDfNtbDCgI6tR6c8njDmDeUiSXmRAeRVrXgJT1IixT5tXJ+/ZbXileydGyuFPhGS608J2ags/F1zeBoQOJbMeRuBDdU0wDT5AXfE4XflQYKCaogSrFPaYHHCOGdI2DDplMkHhKx+MoiC562Itzpv6dH40VInguU8lYzFwb4J4rIFgm5rwH4/V+a14iuJDVWGqmrKAL/CvKkLLJuV9GAHcVHW2SC/VH5BtvUJnm2nGx19sBdxdKrLbT1F/lN7lAKYZakBQq+xdwI9Hw8npJhjdzilRCa9ZC7QBbZAe9JdKWO9gzPCBLSQuz1sP746zHz+44Th+YDKJeUMS3ZDAdXBRiRfdy4SFsA2ep+1spHXfA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e71df0b-0429-42fa-f9f2-08ddf463b128
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 14:25:16.9477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6T2eqGbUFcpa8+RBlwNZLqhv4EVm9RMhdiFcoFp7xQpkqxSWqtfz/93WYdVgHv6QwZLzCWct3ZMSaFuvHYL/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5698
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509150137
X-Proofpoint-GUID: 7D4EMhvJjiMcRvuVfYgZT-c0jN2n3rRI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNyBTYWx0ZWRfXz2X1WtTcA1tB
 rbAqpjvNiKdgMoGvzXWdzcKdCaWmhzHmWh9wfnle5mvtvgC31vrLM37MAW2Ejgd76SkvnM2QNdV
 H4lDBL6Cfe6S6ecC9DPsw8TzPWWLvARGOrkg+xgNZZGOYql/u/qSbFvRUDkqoB7BkQQyQOOGQtz
 HfAe+tjzuXBFC8oOYRJvvEuqOucgD6hsW6Yu8vjB7CFjuCEgF4Kc7bhzPpOh4uLoG/IAR9ex4uS
 auCuaiOywHpqadLOIDrrrJ+YNpq+tZTQSq/NPejg63Nt1D4xjah9GgQih4QQPpFUreLwqErieor
 nSk6iU1c08+kpZ21AlhU1FGuGSpoM1ojWogVkLipOk08L73CMkmtmVFsveo7jppKsMzS3DqS5ZP
 OAmPyDCJ
X-Authority-Analysis: v=2.4 cv=QIloRhLL c=1 sm=1 tr=0 ts=68c821d1 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=j8R8Cj29S844qgnthlQA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 7D4EMhvJjiMcRvuVfYgZT-c0jN2n3rRI

On Mon, Sep 15, 2025 at 03:55:12PM +0200, Vlastimil Babka wrote:
> We touch slab->freelist and slab->inuse before checking the slab pointer
> is actually sane. Do that validation first, which will be safer. We can
> thus also remove the check from alloc_debug_processing().
> 
> This adds a new "s->flags & SLAB_CONSISTENCY_CHECKS" test but
> alloc_single_from_partial() is only called for caches with debugging
> enabled so it's acceptable.
> 
> In alloc_single_from_new_slab() we just created the struct slab and call
> alloc_debug_processing() to mainly set up redzones, tracking etc, while
> not really expecting the consistency checks to fail. Thus don't validate
> it there.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 12ad42f3d2e066b02340f2c30a85422583af3c5d..e5b53d1debddd3fe0f941f579a1043a5b976e50b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -821,6 +821,8 @@ static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
>  	return *(unsigned int *)p;
>  }
>  
> +#ifdef CONFIG_SLUB_DEBUG
> +
>  /*
>   * For debugging context when we want to check if the struct slab pointer
>   * appears to be valid.
> @@ -830,7 +832,6 @@ static inline bool validate_slab_ptr(struct slab *slab)
>  	return PageSlab(slab_page(slab));
>  }
>  
> -#ifdef CONFIG_SLUB_DEBUG
>  static unsigned long object_map[BITS_TO_LONGS(MAX_OBJS_PER_PAGE)];
>  static DEFINE_SPINLOCK(object_map_lock);
>  
> @@ -1651,11 +1652,6 @@ static noinline bool alloc_debug_processing(struct kmem_cache *s,
>  			struct slab *slab, void *object, int orig_size)
>  {
>  	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
> -		if (!validate_slab_ptr(slab)) {
> -			slab_err(s, slab, "Not a valid slab page");
> -			return false;
> -		}
> -
>  		if (!alloc_consistency_checks(s, slab, object))
>  			goto bad;
>  	}
> @@ -2825,13 +2821,21 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
>  
>  	lockdep_assert_held(&n->list_lock);
>  
> +#ifdef SLUB_DEBUG

I'm sure you meant CONFIG_SLUB_DEBUG ;)

With that adjusted, looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

> +	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
> +		if (!validate_slab_ptr(slab)) {
> +			slab_err(s, slab, "Not a valid slab page");
> +			return NULL;
> +		}
> +	}
> +#endif
> +
>  	object = slab->freelist;
>  	slab->freelist = get_freepointer(s, object);
>  	slab->inuse++;
>  
>  	if (!alloc_debug_processing(s, slab, object, orig_size)) {
> -		if (validate_slab_ptr(slab))
> -			remove_partial(n, slab);
> +		remove_partial(n, slab);
>  		return NULL;
>  	}

-- 
Cheers,
Harry / Hyeonggon

