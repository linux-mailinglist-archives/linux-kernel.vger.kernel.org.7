Return-Path: <linux-kernel+bounces-866418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1622BBFFB6D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5D834FE8E3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956062DC790;
	Thu, 23 Oct 2025 07:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k8Fe6S7L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y3VWT/LP"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E85B2DC350
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761205878; cv=fail; b=eRp35FEi0qesh3r321XDrdBHTqioUYbKCHUpuLDcGgjsNAI+GlXuFayS8xnwaHQlfUn93pMqv+NKzWQaiSMQpeoopXImLSGA8a4jYgyYNm3fTAio/f6uN2ao/Oq8HJ9uxE1K5T7m/Yh+0NJs3TP8XpKapHSs5vVeDT4H0wHg5+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761205878; c=relaxed/simple;
	bh=9xOrRjSCdJtoSAv/SEVZCsLBWIAFP3WpfDBvHpuep+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c64nntxTDH4+VkwapIqGlHVJQO3/JbAOP0JLTETx8dJ+yJNn03ov11mz4F2A50rQWTuY4VI/WgfRmb8naqAuymtWbEIQJmyZbGQPQMJIncgHFwFmzFFIGjXbeKzsDoU5hAIVUXp2Uq/a5mpGsJ1FV578ByQyvOgBYDYm4a8/doQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k8Fe6S7L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y3VWT/LP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MI1Xd1001628;
	Thu, 23 Oct 2025 07:50:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=R9KR9rXeLLdVOFgSon
	qUJ4TGBweaLcEk7OxG9HglvZk=; b=k8Fe6S7Lkh3gwHjFqaEwsqunQKYcr9Dmlc
	YpiKXjsFljWuRMySCXAZri+a3POL5joqcsnKjhmegbIGoHyXnU4QP6AjtHYiKGca
	Hd1r81pWVKq7fqz7r7I9lE0V7mZkXmyKyPjxQHyTQ3kQtrb373n3rGVxmJ5jm2Z3
	JVRQXY/+0KVT8sjS8xC+o1iiKNmXf/vFjENArfnhO1JuWlxn56ygDjHL5Xts0ier
	R5OAiDxTOWusRrFlYXG2ffE6DmBtrfhZHBqF0WpEnXVEUjVy4KbN7L0zJQVDC3xb
	3BfRjPxzBjaq3FDKcJrtcIlwbIbSDSvuJILjohjMq2ToR9+PP+qw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xv3ksxrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 07:50:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7AUKv022416;
	Thu, 23 Oct 2025 07:50:36 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bf9ed8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 07:50:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2tL3xEJxpxsivwqJ4oBMoAV9FCrpqC9Jl2iXC+zIzRrU+krTz6dGiVRQZBu+S2B22C7Dh+ueH0HopyH+nI5mTqAR97ZGH/zWc/JkLKK74xnP9uc/RyLpSK1cGqzVe34b64vw1U6+UYrehg1Ris5T8Q4DBFPnrCDu50OvXfTeE5PPpH2YN40KdY22Z4NRyCyAiqnJybClPn776G6zdbHaLacz4n8KMo/uY52gzYAjxhtkAA8s6ZzWMXTch/ghMdxLWZb5gJ5uRiKvA9FTZsQpDOuUFHZnrtuUG9yJv2hwg5XldYtCs62QvYQaBnQx+uotKwrfFzi1+lPfn5+g4tJsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9KR9rXeLLdVOFgSonqUJ4TGBweaLcEk7OxG9HglvZk=;
 b=jkPIqRKQraAKZT8Wjx/lwWl/JymXaVh8cXcv+0oLfdFx9Ihln2BLmvbM7E+USXFX+8vLxL9Qh4uHF2sbDBaa+Z0h+DLhiu9XOq+KlxWIia1tEIZ46VYWLB+CjnQ/K4StJ0VloWtrw3OkeJiEy4wdjykThhMGQZPT8exGEOZmyNoVOaPQZfUzUfiJ4MSn7T5tNgxU3ykMMQxG/q0nJyGgKU9lUgpvBH90fHgIpAE141wpS0falA9c+mjxqShvf2ZDEKmkFp2BkQ3+Z9rk5ua3JR6piNhxFCBCjJsHphNbJ8DTREK/Gq4vncxMFEpAYXr+QTqXzvvORrBbJCpmUWMx0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9KR9rXeLLdVOFgSonqUJ4TGBweaLcEk7OxG9HglvZk=;
 b=y3VWT/LP8OX+0NLkImiLHae1Wq4xINg8odUx2RL29r5P1ePa/LSUHfyf3eCwuItFH0R9l2oeNsiEokGFFgsOYkkWhh12odUM9QGaFiOvL/wseCLjvV9jR0pMLrt1MZHo6e/cvXu3kEHDHvgy6I2Ml292Z+UO8uPUlhFlAQ0Uj94=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 07:50:34 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:50:34 +0000
Date: Thu, 23 Oct 2025 16:50:25 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Hao Ge <hao.ge@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Subject: Re: [PATCH] slab: Fix obj_ext is mistakenly considered NULL due to
 race condition
Message-ID: <aPneQRY5ei-zvSGQ@hyeyoo>
References: <20251023012117.890883-1-hao.ge@linux.dev>
 <aPmR6Fz8HxYk4rTF@hyeyoo>
 <b8c90552-7be6-45bb-b586-ee21f63499c8@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8c90552-7be6-45bb-b586-ee21f63499c8@linux.dev>
X-ClientProxiedBy: SE2P216CA0155.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c1::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH8PR10MB6597:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d64e9f2-d551-4ee9-2ff4-08de1208d890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bs/WS6pGRehV7IOnr59W1cBi+CbnoIBfhCHqP1oxhv1wMSOW9Pkd3aU0WqWa?=
 =?us-ascii?Q?tjO4iovzO6bRbMcXTs0baVfCsh9JTdplntbVSxi5prp5MBUOJfr6pIvkrlv1?=
 =?us-ascii?Q?HMPk0lW1cjp20vTuHT5OCX0lxYWNBrWbi8UBuLxKKynP31pdoVtxe3TSC0ju?=
 =?us-ascii?Q?IWurRQC0XETJUHtt+HBd1MVX/HxKLIFmoBmXL7QQr2k8rYPJI8NJNa45x9ZW?=
 =?us-ascii?Q?gGGGoXaBYdm3DNrjn2KaZJgDvzegMCGXD5NAMoTqIFnqXRrZoMFKPKIN/5UQ?=
 =?us-ascii?Q?HG4+FFKd0FMsdRzQm3UXYM5RewtY8R1+JwrKC0lZ9Rjl5n9z2NV8/uK83K8u?=
 =?us-ascii?Q?APqghXO60aluaCut1DM9Eu+p+QZjPl+dSlAvdS4Fn9zr14BlfGAyo0ZKaGU6?=
 =?us-ascii?Q?PL34muUDBHWiMrsg9dZ6uf0jQlkZzxN96/M06LtEeA4IfB4UzfJGnORK8q9Y?=
 =?us-ascii?Q?CRDxDnbWo9GMZPZKDvefckMdC4/FlE7cTnaei24ORcp7FaeAjliZECSU7kEm?=
 =?us-ascii?Q?r515lN+pMRnDcc282xTI/PDe26X3PTkbFk2Kp1Dj9r61Y4twA+tO6epagA/L?=
 =?us-ascii?Q?/cpQvs8EHkgw+W4trQB+MwGipXbZDjdn2QTjQy5b4kzaEyK/PQeGk5dIW+hG?=
 =?us-ascii?Q?UeK9g+8mSG0Eyja4seepdbKWTnRXn0CENsRf7XhqhUryxLyujS+hFlxI5ZHX?=
 =?us-ascii?Q?y/H8BuuzMSsy3kfuNPVSE1dzLmVNMT1x9Qpir+b4q9xjoN0Q+5wY8/mOtR01?=
 =?us-ascii?Q?ywRu/qVgCzGxbKa7cHV8Ggs1YPGD1H+I5H3dBqONi+CtUn4H0IDsf+yhn77J?=
 =?us-ascii?Q?dKagm/9t63eqxHdZ509uyuZ8yJLEfrnAfi512SdpsYbRX1L+TSxSjC+mtDSl?=
 =?us-ascii?Q?kLCh4UM3rGVnz+uY//N4BScdj6vYBLtd3wpkDBh/BZo09L3Hw12v+UL9xJ1v?=
 =?us-ascii?Q?G9PjJJZ8V702uH3xWflV/s7Vspw3GUW7TguK6/VSSsr8+IInYAhaVjzfX6I9?=
 =?us-ascii?Q?KbFkef3Mimpta28ne59dNF7i/4SwUfbC7JFFMXTxMUBP2AHRMan3UK9VYMmX?=
 =?us-ascii?Q?uYmLVhTlc8snBWo8nP5dSnfqn8L6/EInaD9CzgPe0XmRFqlLVra7p1S8DTKq?=
 =?us-ascii?Q?wi3PkWQRP3gsw6N4SPeeVoA5j0JE7yBN7H18pCv6MLFUO+jL8nFAzcM1/wQ9?=
 =?us-ascii?Q?SG409FLSmqpdCH8YYMW8x1u2TvIpd3U0vUCVyJD+pKFLNKFHky0XqDhz6els?=
 =?us-ascii?Q?FI/5ScnLW8saY9CBBHX4L8FubasW6hvztA375FC1qddTzEZFacG0+N+c7ky2?=
 =?us-ascii?Q?CHgQMxPUctz347smLX1JyqCkbA5dsAjzEOFcG8P+qeV3hjH2N/tpexJTio86?=
 =?us-ascii?Q?Bztu4Kv77H+m+fNKM6/8V+XT7ZvhDKcJKeJP2D6X24UXsuYIpZuZCLozj4rw?=
 =?us-ascii?Q?Pug0b//KDsXB4lNeE6ICsBjzJ3P2DthX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mbzjYarkrcthxI53cgtPBZwR0NAVdQxbnZ4hxDuL0DqMCEdq4sfhFbLD6DoK?=
 =?us-ascii?Q?Ix2XE/AvdZa6vVibERQnNyBzbRDAZ+qSIFRK7SHVAo6pUttea/CBeaEw18x8?=
 =?us-ascii?Q?5WZIb9zcyvvSlTOzrhaLznHc6B/alHl9WsQy4Ca5mXzIqH9eUWWgMhxa4mmp?=
 =?us-ascii?Q?yLdiFHLpZD4n2wkG8fxM5bVfam1c5A3sDciLS1L7Su3pGXWt2voEFFRZm55/?=
 =?us-ascii?Q?gUbSKsII1UmTrfE1CS5xb1ZoA0JmYC5haPOFubUh3p4LeGa9/Nl8fvw82PkA?=
 =?us-ascii?Q?xbFP2jnnGudjObaAM3iSnQxrhaCN0+R4F9Sig09r50RoKuNrx7+0VI5HRzAp?=
 =?us-ascii?Q?ud3kYqGq1QsmHFwyEfYn58Oa1vjacHUpY4BG8AcbDofv8VhqX8nM6tROHYPw?=
 =?us-ascii?Q?9Y8gWEPRdi7JD1iPdwe5vsXfBbI0g82Cg1cvfDtoGf0WS3S9dQ4cAcpR8+5H?=
 =?us-ascii?Q?Zwi+0TzppJGtxrKz7tSDTA7ve7yeiSLVugn6abgNtdtnfifbCFSG33b250E3?=
 =?us-ascii?Q?qHQhCOjF31LSIqiL9bimm/vlp02NEdOpso9Z4Oersbejc0zoAOMTDxTPdBSe?=
 =?us-ascii?Q?P/8HJ0I4YOFunr3lj6911s/3zW70OhZE5/ZeJlKdWoyKb6BI2bGwtKqQx4IV?=
 =?us-ascii?Q?O6fnHvDXLbPispggtHpQVGCq92KdN1cBgdlQWuAUVuSvh22JqIts26SE7jxh?=
 =?us-ascii?Q?fksKHZrHm53lqs8WQI9xFbtJxGV+l1EiwFTnRKTWdQdN+NI4d1kw5pnfBYFi?=
 =?us-ascii?Q?ArIpjX96bXMZmt2Zrrq/Dj87KP9JE5Sof3bZfzePbOiO26bPJR3D+dDaJJA5?=
 =?us-ascii?Q?DxNgLuCA4BL98tpRgpB/g/T5f6iAEozBNTZRuYfJwWvnd/2HN9LEUZJdONVL?=
 =?us-ascii?Q?j2o3tUoPbCH3bW2st0xiVjEN93gj9lBJhJlmq7yoymJRiKc4EwfyD3Uj4P2m?=
 =?us-ascii?Q?/ERQ1NwV08DLwXzQq7Te8rsyPnkG9P6DBO2ONtZ5F0rfljkx0hK1+UoBeAZA?=
 =?us-ascii?Q?d0F8TDU0k9YjWIjgjPMr+c97WdnZGWwcs2v5V0rtfgL/TX7dnSJDbSB2V5iP?=
 =?us-ascii?Q?nk0CBSXoxhgMv43GQVQd8fUyBBZ+opwYap1QbHzx5pT3B0l01cg1Pz+iT7+g?=
 =?us-ascii?Q?o+WLMRCqRuozgFDYN2vnMZhme/O0B0S+SKTwc3uklhdBROV7iXbCNhzwPCK2?=
 =?us-ascii?Q?iXjbNEdBqG+3XJ8RBXP+p9rSrosSOaANGt7cDCuKzt2kGUIbkmEKqEPv5JCU?=
 =?us-ascii?Q?Dzs8zJSTzsGwdg4RBaVWGHpDbf2eokHfM8cdsoE4jALs1Gg3iFIszC1Hq6a3?=
 =?us-ascii?Q?9Kw48+FmWnAOo/THUgLO5h7biq96OMmwS0B1973Ozz/BPETKeaKCDy0CvVNQ?=
 =?us-ascii?Q?OaJJkkXnAud7JM1vTSmygManDc6uOmWgMKKXakwW9JfGZVlx7TVMpYCTnm3w?=
 =?us-ascii?Q?Y3YpUkPKHpJfUBptHCxIxEg+K0P3CiyJbFYOBh2EyGIJTqH4U2F5AslFU+7P?=
 =?us-ascii?Q?mbPlubGHCHGCmeD1t/RGqao8786eBxXm4syUpGQqo9fegaXOZufEwQXHlXcP?=
 =?us-ascii?Q?pdyGN+lpkXoJAKZjVQT4+906QnzaaFiRfbdAoQbh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rLoWdjqETQxSza64uGcvYygsVHgF3L2ah8mtS+h/27WsaTjYAywtyZnml61Kkd4+6Jl9Ks/55XOXf9K1o2RmcaMcfsdWlJgS6EVJ4u/ynsRkahTlkUB+pZBQ9n+QHw3/8yR3nTsWLmUUwL67S+MrUGqzn1jvwnCbUeZ8Y2zmyWuDVjRR/NhzQ0sMi66OZnbf3WMND9gasYx0jMEXwj4WntEpOeT4+oa+tgxOyYZx+kXobnUWNezJFkMyZqMGVyfmINA6Mhy5iVy3yrnEN70XtP+4RboRh7ZecFWoALfzL4gG8dQHVrtmb0x5qU9xLwgNsxQZmJKr89CiBnv1oS19Ahv/YGNv+Irg/tS0lfBbXj0Sb0qmpfpS2J8ns18926LZyFSj/xBuMdVrUJhBum3flgY26uLySvZGuJuU+uWobfbPXJ3ZV7IITgeIrJu6vw7Mlbmvrak1bYqx+v2DDa3njgUeMlDUAfGHgHNv9kH0j2f6PVdem53nnXyF+hFag4nj2poTehBLTRi++V7ohBv4LvE4g5frxJGO7QkBS9AK+fmA8iMvoZncOJuk3OwI7uHpJfZP2/NmwTgN2fMiw4tEGpamyxNxMArjtZxePP1POtE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d64e9f2-d551-4ee9-2ff4-08de1208d890
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:50:33.9308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TyllYx3YgYZQsN6dFdRjMHXim+rjo3Qgy0eldfB5qhREHPPp9uNEc0rxJx0WFCyuLz4DKPDjsCdR4pomPGRduw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6597
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510230068
X-Authority-Analysis: v=2.4 cv=acVsXBot c=1 sm=1 tr=0 ts=68f9de4d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=J5sK39aKaI6gkXPejmIA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13624
X-Proofpoint-ORIG-GUID: 2qVsYsXNMHERXUEX5ftlxZtL_IgHSsWS
X-Proofpoint-GUID: 2qVsYsXNMHERXUEX5ftlxZtL_IgHSsWS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MSBTYWx0ZWRfXxhrEZwaV5JzV
 Gvxro+BzORKPop9pNugvsl4TnQ77semdQFkTZlKkkPVwLQYz7WQf0xJHU5gdo+oh7tI+B3Kj4eJ
 ngAviscVQMO9FW6hHq30aMZJsKhD0vBR7nuum9T/yBR9Bnkhqt1WIPqUafA8k0asytetwfGOHJd
 R91gl6hJ6//zHsch0815FjTDOsTjk/bFGtREV/OJgHj9M+mv1JN7Lf/THEnX3dWaP63e3MOv517
 2PSigdNsiFNJIGIuhheWNO78u2Q24btytdtYfn9YouY9vmjYO+g26B3ly8gOwf0bmCd4XRKr3QY
 jmXzsO5DhAHrT4S+IWOu39C6ZeAL86NNjPNS5pwyqUlUdzuWl/F+i3NsOqbzpEo7R5TxLx/ueas
 qdOARhfxEuZ/mSTvrELDoLz0LP49Ak+H6T0vWhn8Xl+1fSgeBNQ=

On Thu, Oct 23, 2025 at 11:11:56AM +0800, Hao Ge wrote:
> Hi Harry
> 
> 
> On 2025/10/23 10:24, Harry Yoo wrote:
> > On Thu, Oct 23, 2025 at 09:21:17AM +0800, Hao Ge wrote:
> > > From: Hao Ge <gehao@kylinos.cn>
> > > 
> > > If two competing threads enter alloc_slab_obj_exts(), and the
> > > thread that failed to allocate the object extension vector exits
> > > after the one that succeeded, it will mistakenly assume slab->obj_ext
> > > is still empty due to its own allocation failure. This will then trigger
> > > warnings enforced by CONFIG_MEM_ALLOC_PROFILING_DEBUG checks in
> > > the subsequent free path.
> > > 
> > > Therefore, let's add an additional check when alloc_slab_obj_exts fails.
> > > 
> > > Signed-off-by: Hao Ge <gehao@kylinos.cn>
> > > ---
> > >   mm/slub.c | 9 ++++++---
> > >   1 file changed, 6 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index d4403341c9df..42276f0cc920 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -2227,9 +2227,12 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
> > >   	slab = virt_to_slab(p);
> > >   	if (!slab_obj_exts(slab) &&
> > >   	    alloc_slab_obj_exts(slab, s, flags, false)) {
> > > -		pr_warn_once("%s, %s: Failed to create slab extension vector!\n",
> > > -			     __func__, s->name);
> > > -		return NULL;
> > > +		/* Recheck if a racing thread has successfully allocated slab->obj_exts. */
> > > +		if (!slab_obj_exts(slab)) {
> > > +			pr_warn_once("%s, %s: Failed to create slab extension vector!\n",
> > > +				     __func__, s->name);
> > > +			return NULL;
> > > +		}
> > >   	}
> > Maybe this patch is a bit paranoid... since if mark_failed_objexts_alloc()
> > win cmpxchg() and then someone else allocates the object extension vector,
> > the warning will still be printed anyway.

Oh, just to be clear I was talking about the other warning:
pr_warn_once("%s, %s: Failed to create slab extension vector!", __func__, s->name);

> The process that successfully allocates slab_exts will call
> handle_failed_objexts_alloc, setting ref->ct = CODETAG_EMPTY
> to prevent the warning from being triggered.

But yeah I see what you mean.

As you mentioned, if the process that failed to allocate the vector wins
cmpxchg(), later process that successfully allocate the vector would
call set_codetag_empty(), so no warning.

But if the process that allocates the vector wins cmpxchg(),
then it won't call set_codetag_empty(), so the process
that was trying to set OBJEXTS_ALLOC_FAIL now needs to set the tag.

> > But anyway, I think there is a better way to do this:

What do you think about the diff I suggested below, though?

> > diff --git a/mm/slub.c b/mm/slub.c
> > index dd4c85ea1038..d08d7580349d 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2052,9 +2052,9 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
> >   	}
> >   }
> > -static inline void mark_failed_objexts_alloc(struct slab *slab)
> > +static inline bool mark_failed_objexts_alloc(struct slab *slab)
> >   {
> > -	cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
> > +	return cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL) == 0;
> >   }
> >   static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
> > @@ -2076,7 +2076,7 @@ static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
> >   #else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
> >   static inline void mark_objexts_empty(struct slabobj_ext *obj_exts) {}
> > -static inline void mark_failed_objexts_alloc(struct slab *slab) {}
> > +static inline bool mark_failed_objexts_alloc(struct slab *slab) { return true; }
> >   static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
> >   			struct slabobj_ext *vec, unsigned int objects) {}
> > @@ -2125,7 +2125,9 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> >   	}
> >   	if (!vec) {
> >   		/* Mark vectors which failed to allocate */
> > -		mark_failed_objexts_alloc(slab);
> > +		if (!mark_failed_objexts_alloc(slab) &&
> > +			slab_obj_exts(slab))
> > +			return 0;
> >   		return -ENOMEM;
> >   	}
> > 
> 

-- 
Cheers,
Harry / Hyeonggon

