Return-Path: <linux-kernel+bounces-774005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7370B2AD92
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7661C4E2775
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C3D280CCE;
	Mon, 18 Aug 2025 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MFXdvPmJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jDWN5ev4"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D713427B336
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532506; cv=fail; b=NxtnIfxSEVQs7BqO78H3yQsqDIx8qD2XNQpX97ZldMgv+28Ow8UuSDNSI1u8LVSr8oaVwmOypLwTPWOrcRz6Ay620cCxhU7ndLfyNoSayb27pZm8nJXXB3Fu5wbS0/cG9LeFsawJOIcpNsLnmHnXKaF5/9WWPk6gqiIc1muxeCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532506; c=relaxed/simple;
	bh=PhraR20V9O5NwAR239vb7HVjvClOPVB0HKatstHbAhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dyFGUOCWO9MOhG0D+IPrbyLRuqoGIXjayiUHQGH16F6z73fYQhovvucXtBC1F4cfW0FeDUGA0F1oz+vM57qjlqGAz0Q28DYOSdFqF+Q5lbiJdO3r24aBhV5psGZ+Z5XnnJ0rcPqAXqR329zId5crkCCx19zLDhitPopIlDHRCdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MFXdvPmJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jDWN5ev4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IEtnvQ030290;
	Mon, 18 Aug 2025 15:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=DNwdcgR5C7z4pysrCy
	pTqgayMXW6L/JXfTUEMPDaJkU=; b=MFXdvPmJOJnFbrot9zbfDGr93yGqi31u3Y
	OyfH8UpM+WpLdQNqo6cfhEq2D5b+eSYvsLkEp9zs+UxCiL+yYZ9hqU402NO+DQaI
	hBCQCD/JzX+AvL3ngtX0OZyh+5lFu18OwSEdNKLPpPfVi7LfiRrUZDeNsGtV2DJY
	H4JIU/GdfBCUKuaMwG3pQjbc7nkQwS0iDG2P1bww31UFGLKEAYfOU9+TxJsx51G2
	+vb6ALbaphSUrwgKT7KCsopHVgeellwhCAclSzmyghw/RZ5lnRKpS4hVnrO7uu3g
	H2cszY32bNDVLWi8vQNwNAl81EiidGX9jyIIFLQawh8PDYjkq8sA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jj1e3ejb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 15:54:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57IEuY7D003433;
	Mon, 18 Aug 2025 15:54:28 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11010054.outbound.protection.outlook.com [40.93.198.54])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48jge96ax5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 15:54:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBjip3Anhv8jwfJe/ovRO5fH7OTqBbI4apyG/p6tnOhfWT43jf1Ad4kbWwtGZ6s+OOBJYRoEZehOJghBPTyEINXlj0spOVtlzPB+JLWrgxdV6QtH52Qp7vCBilMgFKeT7vBemhM9YYOqF3CPuoCB8Hk7yPoGoeJP/38ebOjImTo0wymYv7X5OKjCGgRtiQZVIVdBimul1D8LCCFFAqYKNmDKkdPyA7OwCRzei7hO3QxGOA+ae1pqm1HdqLHkJ2vxTQewyXGSOKtlpuW7J8S+pIU88hH+j6r1v5payd3EFthSjOBnf/w2LNAD8A8mbFLCwn7JXNXqcKnS2m+hXBRNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNwdcgR5C7z4pysrCypTqgayMXW6L/JXfTUEMPDaJkU=;
 b=aUKbq6vAJaPgNqf8q4OFMhQLV4LIGDwV9nlyOBsy9cp1JiM7uxqX8QmMcHHtp6P94UnYs8vWH81p2ZJQ7Zrrcm0mVla6ynDQ22KN+eKm5oatpVuI4baGWsvt1Vr0thRk1nH9ujSkJTPQ7H04h5ZUL3Hb5LbxcFHiYzxI7AwANN/S5GdUHpSP+nQ0L2vMiIo2QCbS1i6Qng1B9UEp6OzQqsjlAJ6/EUFdNuUTk4J9qHmL1SAv7o5au3OS8XXNsgpHd5tt9rJSii5VS/NIuneu4meJMrxZcvV/Rq/MD+MVQtvP9PHuz/Vmp5seXEKzvRCATSzmo2mErRQKVCu2XZt0Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNwdcgR5C7z4pysrCypTqgayMXW6L/JXfTUEMPDaJkU=;
 b=jDWN5ev4/QSTlXYjBlPPrwKwGlffKsMa+bUBzwxoh3aitEMUTLtiHj3RRqcO2khQPF/PPPwsmyOTs3Z/KCY+eyLymJVXrgd345ErShVcUF1Hgvzyj9jeoErEQmRbO/4Zks7buRpRlIt7UooJdnSOWaI1W0WasQBfHXDM/zGIq6s=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA0PR10MB7230.namprd10.prod.outlook.com (2603:10b6:208:403::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 15:54:25 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 15:54:25 +0000
Date: Mon, 18 Aug 2025 11:54:21 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
        bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 4/6] mm/memory: Add tree limit to free_pgtables()
Message-ID: <myuowejmixaoxdulcqdjlscdma3zagek4u7rorn3ncryvsbze4@4j75fnafe6ml>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, David Hildenbrand <david@redhat.com>, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Charan Teja Kalla <quic_charante@quicinc.com>, shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com, 
	bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org, 
	Matthew Wilcox <willy@infradead.org>
References: <20250815191031.3769540-1-Liam.Howlett@oracle.com>
 <20250815191031.3769540-5-Liam.Howlett@oracle.com>
 <c8f402b1-386e-4dbc-9d4d-3e5464d2ed61@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8f402b1-386e-4dbc-9d4d-3e5464d2ed61@lucifer.local>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0397.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::16) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA0PR10MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: a7277d0b-29af-43d6-028e-08ddde6f8175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EWZTibJBJm0I1G5Kp5oZoubxCS8RZjZMx4im9dsQx4KSori7pYvU5r86bhWW?=
 =?us-ascii?Q?vS8CQYYze1tdl/LNUtETsaPrSMbeRFkgvrNJDAm7VGvOQCAyKW3ZXK1903i2?=
 =?us-ascii?Q?baOBNWi35TN5oDfAcvqQjN3NNuTuIgwlTktCL7bv8IhI1yZYXSiiOKFRox6z?=
 =?us-ascii?Q?FEm3g1c023LPBt9o+cKY025c0xAgL8u18kW5gzGcJeR8t5yjnDjn6px4HdNv?=
 =?us-ascii?Q?AoOisPCRZWSopvd+o/XzQbps0vSRooDK/f5KCdxdwGiob48giDNWx0iWNDSs?=
 =?us-ascii?Q?hJp29/2LZyGEnlxwJaDJ/DF5lGI3dQey2UcaS2TjOENCvFUeVDJEr1NuzzZY?=
 =?us-ascii?Q?fPi8Ze74gVngNsrGY32p4FmawHIE8VCeKB/ddShuPDqZ1xNJFAK0IWhaHZxy?=
 =?us-ascii?Q?HmBk+vDERano/5mnyaTseyWfA0kUsHnhCeS6r0YJUs8wRFyE7neFey0cjqRD?=
 =?us-ascii?Q?k9SOcvY8aA8uvnXkTpkS4Pf8YtnPrbTdriELVnCMJmrAl1cVafHrTk+VW9QF?=
 =?us-ascii?Q?vIeGEkf708yz2iZ63WdaYqd8usvkwzZSuydftlAVRjGA8I9G+30+/mmqXUgL?=
 =?us-ascii?Q?/4EXnnDSvPLdN26qNcZSwuuoXO8Y6J//Wp+6E1zs9loqKLcdO0ThYF4xUewV?=
 =?us-ascii?Q?xM9R9aCGxNEJywS2vNwM0vQD/GU39iGDuynv6OdDGiHzxF1oHAfSPvw6h2Si?=
 =?us-ascii?Q?qv2kAXgpIdBxVI7TGNe6ld/s0EFBKPGUVGlb49o0hnXFGgNgrDxdxQiQ1CUJ?=
 =?us-ascii?Q?TSOje9CNlMwIJ2F9gXjVSyyj+ByU4ijqa7nLxwFa23zvrS+Y4BeiLS2vsm2M?=
 =?us-ascii?Q?+EiOgAWHw/SeMb/E/5Ky1OdVS2sXjKaAFUUqwwLWV0Xsu3MiruYEyZG+xQ9A?=
 =?us-ascii?Q?s2P0CweLwdTP1WCWjqYvX206OkgULuEhvvHGNb423zgqwnom2uRtJmYkuHle?=
 =?us-ascii?Q?v/8gmlgyLW/1q3cm5s7n6rc755dPjwv2aPvZ0k711PEyBVfhcArqJMH2OHn0?=
 =?us-ascii?Q?RgH98ti4B75ULvz/pBO4OXcClGy0N2GMD5EfIpI4p+4tzynvyD6e5Nz41ccB?=
 =?us-ascii?Q?rPAV82jGgHUIBrxOQfXO6ajYx3pg06HC+cQwu0jS6pdTms0RiRpQ9Qy5A6jT?=
 =?us-ascii?Q?gLIFu6QFBBhgB2LTODIZcSGV1t56wOB2aEW5beyfzNDT4xW3meT5CLnsRZ/h?=
 =?us-ascii?Q?mMWlZSa0uqail8K6BJLA5aYcN7jLuhJed31fuTJKKdhZDFmNcOpPdaA/hiQc?=
 =?us-ascii?Q?/YL6CAWRL/QxuxG/4q1yXUDvw01lCGrErJaHJuwL8EUIyjSUWpna2/2uscL+?=
 =?us-ascii?Q?ssTQHZv6FufK17s/swYkYZdz5H761slKLY0ufgjKzMLUjekSg7q7vA/nyZp3?=
 =?us-ascii?Q?0f+Obg6Mnul+O+8oxhMV+Qc7V2WOerJ6yqi3ec0zuk+fJUYyzSjmVYlXHYrn?=
 =?us-ascii?Q?KWLto+hxIRU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FFgQ/F4AqJJDa1FilJhmCwlq8Qwqg21OHHODs7gKyU6urDpnEHEqk7dg/gw5?=
 =?us-ascii?Q?8zSEhoE7YSkvaCJXSXROtUOD3ebuMKOcKNLsbfvqn4Sd1wJ/oeNNzwcFKhHi?=
 =?us-ascii?Q?yH+Ye3QsP+rjDuj3U8IIDiH2cDCuLFyFraiGIJHdZhdGb8nFLwQfMbAekveT?=
 =?us-ascii?Q?4sy3RHVEgb4i2zIsQ1h54oYkIUPxLuNZANjRTror843VRV5ED6qFVM3VIdjm?=
 =?us-ascii?Q?a6lljteIc4qhuDlx0Id1Z3tA4hNc97/yfpTmEUnSx2G3gMPeX2amu3G0VRI7?=
 =?us-ascii?Q?n9sEXgxyhWGCj3Bf+iNzSTLCpknikuLnHK93JoS+ZL6pgn9PzuKoBeEUTP+3?=
 =?us-ascii?Q?nNJfgWO1sluZ67iENdaLS6Y6JI3WSl0UiOhJPSaw9kstxFp9C/sHNKY+izwC?=
 =?us-ascii?Q?ZnZ19hywJ50RM+ptxw1t0syIqLiQbtWmuT2IBGbajIs4+0WRTYfJdVefZxgM?=
 =?us-ascii?Q?7C03MYSpW2JUhSY6bB+u68P7rjBa8pra+QiOyPytKE+8Vwuja8xLwdGzh3se?=
 =?us-ascii?Q?c9yzRQDficRjiYxZ+q2y4ZyUQyZo6yUlVbAh5n+AUvOzkQdO2azQ51RrYQoQ?=
 =?us-ascii?Q?NEnKTnJA26gED7hdUY5OWKNoaLwMG6zT7hLuZvcSn62nFawE+36w6pbQoL18?=
 =?us-ascii?Q?7m09WnpCPdoD3YFbB1hlxqxVb1QdwtOuHRTm7C6Ms34dX45PPNEAwpdggsJs?=
 =?us-ascii?Q?lNerB092xYTIPUF7BPGyDqTi38gtKlAvlx46eovwa9gICre+d3d5aAglleMr?=
 =?us-ascii?Q?AqmmVZ8LRuNDiZLJyiIk6j6O6GwRpwXNFLjSKTTJSWrjSIiKWFOe14eKS8n3?=
 =?us-ascii?Q?YvUtSE5DTjcP2JdprCeGtYEmNnfKSzDNnLFSYpFTXO6Og18CdOSfwZq8rg76?=
 =?us-ascii?Q?a8zmb8ghZLfikxTGxQaBPjk1kLTEW+BDZwy86jFsPI9odHSeiZ4uxXh4mkCV?=
 =?us-ascii?Q?/kKX4zbLUHZKpGNdHnz33ieLhXTJzXnKrrPcCXGfkW2bjGj1ON1p65Nx7BCs?=
 =?us-ascii?Q?CaAu23yVlVM5PqsWe6W6xpWJQgyPPHOEpFkMvbW1DuVPQX9zgFWrOFJtqeuA?=
 =?us-ascii?Q?wuTnYKYGyRwdc4r26OrY1TjB8IZsC2EPLTHkRDXThl00B2G5nLn4thbVbnZu?=
 =?us-ascii?Q?BcjCQpBulbLQbRAPr4iKBZ8i9vZ7zO3VbgM2lWQUytxHYskWgF+S1QkBN5fF?=
 =?us-ascii?Q?WkJTDsTOjGDymKf/XqvD90G5tsgwcNZ2dOo3J4WIY886tzDHt+JTUE38b2L/?=
 =?us-ascii?Q?IcBcPaY7Q1wkZz791ipMQRz75TyqxtHsPT4LV2mS0vH8FNBA8l0/h9E3I8ZN?=
 =?us-ascii?Q?DcdNMLZnKgeRXIqGVucsDIMGBE/SXf+oVyLOpM5wdu6cLXB1911FB6T9w7R3?=
 =?us-ascii?Q?DiVdRztYAP3x701aqfjJC+Gb7bfbpupJPjLSXYRqDbf7gDla3CgH96D8bWFS?=
 =?us-ascii?Q?eqpXO5UoA3ZgJ8XhlTbL1ov3746tN1SxlHjXp67JqyNcYgTw6PVZQyfZpw0x?=
 =?us-ascii?Q?qyxwIi/sKI8Eun69rvEaI7C4PAgMpnHonB2qecVcOwUzeerFYa/PmpjgS0eX?=
 =?us-ascii?Q?zHPUznJN2hVTtwE3j2bfUz7xxEuCeUG3bZP4Ei7L?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ktJTMzIgTe9bt8pwD/5QH7R1ocBlRsrxnCsB5TL4tUv+LmcpGsUAoEafam3a3IHPrx7MaQPMHIJvk6eHYKTJhTTiKT8juHkOkqU6ijy3v/sLGxFCLLu5BePfM8l8LB7SNIKC9XiNt3PjRRP4o7al2pa8C0nj9HuzkPoHp2VhvUdfhFzzh/m3OsU1bGrbc1kmHRVtgu5nbHCYmwbuk0HFTjvgvvOtYrDmsDKe9f7ArptcYECUzuuy2R4oeLIhp9VVKqeXsQqB50xHBNC2SVyBAGzJBaGKB4pOtwQPJjXSXc34QUsBhU4FMdCDKGBHyyVCgjZ4TdKpQo1SgCk7DvcFVSL9ACQIfh22b9OrrqGRKGnJaTfY6wddrVOFWLkzqnbJ1vCGgjvQfa4MOhvqaxTcMX1mGI3H4PCa2f45h4g3LgB/gZ+pYOU6m36XJOo8o/DguPv0O4IpUfFoWnclzI41l6c20Nf2AgGEiLA6P2pBVCxpzhj3kZqc1ikvyrj2g/aI7aVWZmdKtKi8eERbvlmigGifLsW+Oft+YfEBI4SYJid38ya5hvDralCQ+5Wi/LIeBkpLWed0EnGTz20tOwwLBzKBUv6oDB09wVldMelQTsI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7277d0b-29af-43d6-028e-08ddde6f8175
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 15:54:25.2406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Lr1FWRKJUQaRtA8j+4EURCT3jCT/1BRIk9Y70ru3aqBkKOillD8MQ+/Q6LyLv89vb+SRMctBrnNp9Jqye3fIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508180149
X-Proofpoint-GUID: I90n4TzhDooI8yQucQxc0CxBEJE8lXy5
X-Authority-Analysis: v=2.4 cv=dN2mmPZb c=1 sm=1 tr=0 ts=68a34cb5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=W7fSGNyg6wTEdSoANoMA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE0OCBTYWx0ZWRfX2c/jZIpAD6Xx
 z80EAdpJNqxBS/JjkeMs7L5XzkjNCEODI+3HDy+EepWSMA/dbMNFmtWJI8jLDAdvj3jg9pnmr8+
 MjpRZPKRH/6YV7sPHQBbbM1qgEyUA5poWiT+lTlwatfEEwFoRrc444qKcrJx3hYsuz/BUutSWwW
 JUdV/SuVo4xt/Q8/ZFx/GA4ibtr2yBpzzRLX4xLKi4Obfm+GoBoIs2VObUR0Ii+KYnwOms0GDr9
 MDvptKn6XjWCbbMHaO2cjfU/tpMM6B0xuEpqsY6wsBRRNn5kpYgxLmAkpYf7wCQmk40Gp0GOaoR
 IPFNS6oU48ZQvq7zbW9h42eOGQ9EMnwkM3ZKD4HoaMt8+GxE03+iY4JRy2vtcYI/0LMUGfggmJP
 5i0NhaY436zb+XIDAH0nXrBf177BY5umIPOyflPK7dGlTKDIksQb3suXxd54N99ag+2GNKYy
X-Proofpoint-ORIG-GUID: I90n4TzhDooI8yQucQxc0CxBEJE8lXy5

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250818 11:36]:
> I know this is an RFC but to be mildly annoying, you need to also update
> tools/testing/vma/vma_internal.h to reflect this as this causes those tests
> to break.

Sounds good.  I did check that, but on an earlier version with another
vma testing fix.

I'll check again before sending out another version.

Thanks,
Liam

