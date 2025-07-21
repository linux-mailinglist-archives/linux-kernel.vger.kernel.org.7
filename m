Return-Path: <linux-kernel+bounces-739689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4D9B0C9BE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587AB3A4454
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6C42E174B;
	Mon, 21 Jul 2025 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B3SwRQpp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KEmuz9sV"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EA8219314
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119265; cv=fail; b=ucoxhZ2o67lZMwjFWt56kuIXJEoZSy5fA4NAN1dQthXLpLDKIW6642qr5B1k5T5RqTVFnpcm8sv8L6Y48OAEBqp6HYEHi3j4Q8+xPq60rDgMIWxwqkeqcCtPfSUf36hj25x+/RO4kfiI7oVl36azyg3c22vfMLDfAdveH0uStyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119265; c=relaxed/simple;
	bh=mft2dmkAHpmHJabJLEw8AuiogTmrW6v2/ESlTZCP5M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ye1PS6WcdnRHleUGpTWCJr2bBIQ6Vu34IiMCTCNixcjcDeSH1aHm/jb+sT5945+QAbRdYjRRNBivtXwAA9BFxsxc7frwE/Mm9OixQcWqJgcaQMJXZDuFYkQq3Rm8PwWDSF0Qdb4cjCFssaZI+rUl1D/mMHLKc7De3u0r62kvWos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B3SwRQpp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KEmuz9sV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LFQgYa003221;
	Mon, 21 Jul 2025 17:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1w6UVH2MaCxcNnEf9nGArZOs+H3HYCR+iYFOfnf6Dx4=; b=
	B3SwRQppDl2JSLD2pnzvSqttIX755PV0Bc8uq6ERr5vqdKIXrW7mdxEJWcH/0gn1
	+YB10Ny2WMTk8KfOOfbVYVARqEKvh9RgkVPGRkwz30IxrVAyWyoDlRzCYWO/8wCC
	KMtuwZzEj41o6XcRJv6nSgQuBOmTAmtZ2GvZCYFIg04dkwV1HDCyxqB7L7rqGYEf
	+flvF0r/AvUdG06Io/bNj2SEuQ0tYZoybOnSa2JhmOusfreM6scUEIpfd274KexN
	2pugyB1zkEQj8OfrF68b6MFXo2rtFXIn+rE9DT1kkl8anhVmyubye318bhlDZuWT
	3KpJn8igoQ5unfwPXC56lg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805tx3c52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 17:34:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56LGsFwG010346;
	Mon, 21 Jul 2025 17:34:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801t8bahb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 17:34:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZOPh5AKwxH8F5B3D3eOaPS+pqyy+PD+bcVLCouwUzkCQkPKW+aO6YxNmW1YDYq1x+2uJuoXyIWGTItAcVc6hEOwVjd1W6jefvgvvixnZuPpveJ9Af6H9OlqCF5MNf/EoDrI4EJ63BonVPYZD1ZpqdOLnNsjL8QXBIw+00xbq53AGyJxSlWznzxZzP2SRseulEMZz0TCI0OEvF3bbzlnRE9ndcwa2/NtfZtABaVYitpbTC6rWsG8CgXVONkMUne8BnIrtKj1bVj6zcSlPqKGIDMG0ngC1DxuxbL4aE4CnQ7VnyzXQsvkmwVaP9GwaIJSP8RG1NcKedNEpDHoByE12Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1w6UVH2MaCxcNnEf9nGArZOs+H3HYCR+iYFOfnf6Dx4=;
 b=cgzC4pBRCdMOIDzEcp/S6Q9vySD4aJV4yHuD6pU5lT95eHNXRJUsGyQoL1VUxesdIeqGmnHE5PLJyWb5jFSQNd6qFnCaI3G2hk3wdOLZrfQYaF8/jXXnIJTbgJXdCfbdyPIrH7mLbzFnFtS4e2BE44AcO4JCHuYeFWkLgrQpwNZknZdt/q7LgfDWxe+VAUExfmCTd2/2EQ5BfXSHQ2ZMgDs+r+NYwu+J2xJNwz0qKIrMInce9h+usOmmqGc0Z68Y32VC60qCJ19R2JqdtR2uDocjmBZvOYaU8TGfjiOJMdZdcmnJhLIOAf3kbvwKdtuMCassTYi7ZejRvbGj0Uo7Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1w6UVH2MaCxcNnEf9nGArZOs+H3HYCR+iYFOfnf6Dx4=;
 b=KEmuz9sVoATroFkDQ5PfzeZmBKcc6wuzUnoVfgliYCjxngz9CnhGMeDC0Fse+w2knEMZtjkOvAEy7U90E45ptssovJQycnLeFAynKf4SowH762lr3146Szu+QyyZJY5F8elSiY5m8H8gZ7uXQMqW8Eu6pZkv8e3yPcVvyoZwoUQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4518.namprd10.prod.outlook.com (2603:10b6:510:38::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 17:34:09 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 17:34:08 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] tools/testing/selftests: add mremap() shrink test for multiple VMAs
Date: Mon, 21 Jul 2025 18:33:25 +0100
Message-ID: <f08122893a26092a2bec6e69443e87f468ffdbed.1753119043.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1753119043.git.lorenzo.stoakes@oracle.com>
References: <cover.1753119043.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0133.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f046ffe-ff97-478a-0351-08ddc87ccc04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yPsJmp7AS3hugtfQ4XZ5cbUUC5703xockZTGbc+UOzxswgZEky6Yk9oo5DmJ?=
 =?us-ascii?Q?sQQITlCmnFCBQ7R49bX78R0jkOG1UwAtjpYHZRgpXaedgik+wewRr9L/wfV3?=
 =?us-ascii?Q?L2x+MmI8djkEXhtZlymzCrCUqpsEk1ExG8hd5UbWf4qmGmlRg9vlKSYduF8G?=
 =?us-ascii?Q?Rv8IWosOr4miCrEu/vjVuRpdUq/2Nm7A1qZLlhcDU1VfkfSgaNV75x+nnlCn?=
 =?us-ascii?Q?63Ji/jbT8XqsVDb66QfKrwgCnk8kRxF0PZGcMGks53tEDH8jZJY/HbRm0aAF?=
 =?us-ascii?Q?wia4NdDXqYad2PUJP0tge5wKm7yWH5690+2CMscO5a2Pp9fqATLA+ZpAC+rY?=
 =?us-ascii?Q?XKrdjm6lDoIuzhaPrifznKI4UbOwbWQo0Zl2jRKxNcc2KBYs1ppdfLh/TT9g?=
 =?us-ascii?Q?TVqo+8rwN3e2mn2zs3X+Z6Phv0277qLqKDbTeweFchZNMv6VnxK1vQ8EJsGv?=
 =?us-ascii?Q?okHCcpdCTE9Z41Qao7MKpLHhRWlocvJhhF+3LrZRNBv4+tCOUov8gB4GXpHK?=
 =?us-ascii?Q?GjV6XCJAjgtZ1QxuFw1RAmx3lV430S5Op7niLAXV3LyX7g66wzgXZnYxdyd2?=
 =?us-ascii?Q?lG1PtuydDWYdYnnR8e7RzawUiaJ88s/2a9/tepM5rfXBTH86rjWZj12YCbV7?=
 =?us-ascii?Q?gX7qVSpWLVlwBEgv+e8vcZ1VI5cGfXARuRUEgOOwS71BMjbThZbLmxKVDYoT?=
 =?us-ascii?Q?ECrs64pCgHVHsM4BhnlkMc8hTwaFc9JaWXVyQtvZJt3MWMxBDUwmfnxrX0xF?=
 =?us-ascii?Q?p9/UP7DAFNqA4WHsWdpFi6mmFUP0YvI4TZByfhnJ9+rRTXTGmnRdJzN5pOqk?=
 =?us-ascii?Q?/FrW8lIIxKQFszzG8YpBd73Bhsd2Bs0oAf5ny6MD87bRhka0WnBqjGzzWU10?=
 =?us-ascii?Q?IYc4PmVuc6tQZd//WfgUqJzKU/hL8Ut0kCQkekqhv1IC2a0jqLCuFSKF2l9s?=
 =?us-ascii?Q?s+6Fe9ntIzAGiXuRYEEjxXiW0Z8ZtH1ttpJ0DQ05MSMARWiLMal9z5arAb0K?=
 =?us-ascii?Q?ChIAndbGVK6wSiPfKnCDde5Llw+dHGSEznLUisk25VRlaQF7GzYOnlALZKOE?=
 =?us-ascii?Q?e3dtjx4MnVit76eUyMx+74wmhpdZb6lvQjAsm7UtngmYW8m361uraj0QHKCW?=
 =?us-ascii?Q?BavPAmT2M3ja98IN+VIXnKl42MUBBgjBlMuZQG5qWKpZHgiiYjpXU1/2n76E?=
 =?us-ascii?Q?bh07ODktFzSSlh4iSMjQo7ObBbAVWtI1DQfiL9cQitsM6nT73CknIrtQaj+5?=
 =?us-ascii?Q?hQoTJmyoziP8JoODsPC/YxZCO+3PpyUnaoHx6SUoSwx91okuT74es5ULQe5r?=
 =?us-ascii?Q?vGIETkAGtRaeAAAkwqVGO5Eicx+VeNJ9x5tAFy7jmLrVDjwgJNO9d99RpPGn?=
 =?us-ascii?Q?OJa8pjvX6zgBzMVcJ29n78mvbIZBvUJHDCT4zCVjEDRIQDnlGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iDK1wRvrdkUto0AOEDZopLr0IXMrHot3YDf5YmhQodfFkxJPMlXRjJe4tKUZ?=
 =?us-ascii?Q?wJECMEbb8d9dAJiJHsVq7Ci4REa4cH934PMSQZ7UxOzT77y4K9c1RGEIOygh?=
 =?us-ascii?Q?u+/q/2qcTzKFxA8qVbtQFQ/Oj9KkEyWqvQ5BagXZnif75VKG57A0XYiQDwJZ?=
 =?us-ascii?Q?TkNZxrQxqo6iIIstsv8vjDK1RtohAd7rT/Z9A3mXim4tTZ3JJ7qA9CwPpuKS?=
 =?us-ascii?Q?nN72x78Dbi3OkCGJAMk56rKLyKWfYzjB2Lo+SBTVE8Aw21aqUrMBhe1+nZ08?=
 =?us-ascii?Q?aBzGViXfzw5YrKRben51yrasbT8YXrjNlMpQCXyy+AlGSC9iKIIy8/MCYAZz?=
 =?us-ascii?Q?oB01Ej4RNqenBK1by4HM6JJMOGiAfxC7yOyS+tiP2av0DWcZ8Luzs46SVRn2?=
 =?us-ascii?Q?jBrc7kHag8qmMFacKum4l3QZg5EwxqFMdkunr/AAmHzeJIwknBaFbvEjqD6R?=
 =?us-ascii?Q?ZkHWWm/DGRxh3B76yAHmHjbRP49NKWHewBkOLhCDyFiHSDxbnCjaIUwSApfD?=
 =?us-ascii?Q?4OcyJ4P01M2vAy8rg8WggNTov8sWs0j20i151BvYwiQzrkF258GuiNcpF886?=
 =?us-ascii?Q?d9HlgmwiUKp+x9cBnGS0X7b5ZPXfjOj8ba8e5oElNbeJiMjEsmNOO0MmXFYm?=
 =?us-ascii?Q?dWYnWEatyQt7ZnWaXphISsZsrS6k7Oolsle6cXqVKSJ6rk9i8Y2hyJnTUOYc?=
 =?us-ascii?Q?GN8616eiHyCG3UkCg9sKdQWdl/ZzjZ4+brCo3YbBdWhWNr1pfTDkYJHgxY2S?=
 =?us-ascii?Q?BgkJzZxRomT0HTBJIBXXjskhhBNGu3IvI/Bi5N7T5ZQHAFtHYYRrUxlwOELR?=
 =?us-ascii?Q?F2VlyQEY1vE95SPVXkQjDAc00euVtcSV5y0ARGrYy46DPnhG33+tiPKMD8Ff?=
 =?us-ascii?Q?TFYvFUIPvzAy8WkC7hblBjmKnjyC7AJpmkq117pLzl+csRh99W9qfugdXNaM?=
 =?us-ascii?Q?sxBIIijGH0rvNv3XVmntJVQ2XLXt/n7C24/07E9XPtW+p1eYkHZaIapMz/H/?=
 =?us-ascii?Q?ZKZf5ypbx+0a11EhTQ+H79s+vokfSDZBBugQVmkUU+SmWGuVadc0Pja3cvfe?=
 =?us-ascii?Q?WQHjqPE+GUWmR3uhIkfbSEBYpt8L/AoXbkPVdGiUni+9n2AEf+D3QQbYf6gV?=
 =?us-ascii?Q?XfrX8cjBUHmtsPjYGC/ZnvFlrbtPE39GduqzpSvujLkGioNBpu94UIS5sDKH?=
 =?us-ascii?Q?7ML9zJEVwNEhLk30d+A3OhdcfDBA+t3NXF2GhCLgUYNbeLbwTZqI15Ubil+j?=
 =?us-ascii?Q?miQB8DzO9I7v6nlNOCr15XRVXbmmn5dXqtZblJ7Hcnp11ygV6jItPTX2pFGO?=
 =?us-ascii?Q?o7R5lvSvv7ch8EDWwJCv4PSHJYACBrdmO/EZWqpqoNzu6ThmF5V8xNVHHtjq?=
 =?us-ascii?Q?gkD3ZaD77kVWO+a5zaYdHEDN/3C8KnnTQuAp9/xWkoxKilAJbW2+9CWSWTVZ?=
 =?us-ascii?Q?v/pB0RB9ZNQ6VOff8uTi1yrfYa2QBUpHnp7ssMoik7OH2NKcRFCTMgaPn7KY?=
 =?us-ascii?Q?gEYWJ+qP4s2JqHlIX6D7puoJqpybcoMScNdM7XgRSYnj6EracoPBiCDmzE6f?=
 =?us-ascii?Q?IAW5ad23uOqzFHTXgs1GBgqGW4iQWLd8OiRCV/VFxn7NZaft8+RgScqqI0uk?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7hCJctq1lm8B/a0Oljo1KmfNMDGF1XsNWDazAQB/7+slnT5R8MHS2PqkTr1VVKo8Naa+/on1UICA4tq9dWBjdpvjkyG4gaBYySGRdASlqh6UDYGptzD8q1Mw1Ms3iRW6WfvZvwmLV1NMGE2/mCQENRQDvi20F65gaNgdOWSbBmgjjxSdMnbuDS/oGrIEckpK9VL849xiQr/3dVyMvXJsL2AguC0FHWQYJwi8sf1dGXPXj/8tesEU6Zq1kN+JILDE8BaCCRGyOd6TzYSy3UdHm73HM+GuMhH0jlGhJXI+bdYnLvYWfAEIth5rTLoq7HPps5hipvZ2sCBwi+6HLZdON+pqiRCjeRAV6mDidHMx73GnhAc7ayLF1S4PHJjO+ycF/+EGcAbtWSvDz+saAuUGabcEQYp+/NP027aGKXpe6GGBckINLX79pjjaNc1dVQeV5rYleT4ZcrFXUPF0LlfowBq5lJcVbLQa0MOOZU5X8X/4IAH1AtoztyiOS0WFgFaiBJIv0jWNyEmXYz2Fpr9ssPyVYu4IWOy/CHNkMEhkjPrl9kcJ1mwG+aUGIEJ/0WPkw5hUVURg8kT1MQ8DFpSmLXfKRL3fJIxPQYO5hOoQWxI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f046ffe-ff97-478a-0351-08ddc87ccc04
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 17:34:08.1710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +m4DM07tEB3ma4gdfMcx4Jo8XFigI/zM0KLrQsjrz0xNntBvUW2oRtb5F9a7k1rIk1muJo+b8Q/tpBW7rs0NxjnpVuo1G2wvLwfzrUQEDyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4518
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507210155
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE1NSBTYWx0ZWRfX2sk8KM6R3M04
 EmQRACJGLpj0aYLxgiA0BaHNfXtwXUBoKChTh4XPylDfy1lUU9w1k/zBvrmtcom0xOXrVCY/VO0
 G54A19V0M2uRIe+FTJdEKbZNcpQ9toWG7Z/3hxBOVALmwZu4c7C+EIizijYzKWx4gyDOTvGlFQ4
 L/tLOLOb9xehT5fjyZRcWehtcBLASuio4k4CjJ+IcRZf7xDyDdbG6vJOvV7S7PoSWWRPhtsm3Zt
 LFICTLoIr/P48I1B0YkVFksIB5xXUH0Ea/yUlRaGuJV5cf85ReNP3XAqDkWoO/kLygVLHeTxRk1
 181RTw0EgQOdrP/i93xBtAEqDlDbESfpFWXpalouKlW18iCwR1x0XU5rt8DOcBIpIApetqOA6zg
 gxggFZCi1nXrMYQWJcs6StiIHP5VwzQ5/4+EMugs0a5UEVu2ctYegFZMFe0uoHX5rj02nvIV
X-Proofpoint-GUID: oWaAnXYEdkmmRXnzI-ctAerCbUX-t875
X-Authority-Analysis: v=2.4 cv=IsYecK/g c=1 sm=1 tr=0 ts=687e7a15 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=w3ZyRhC76O03mK4guMEA:9
X-Proofpoint-ORIG-GUID: oWaAnXYEdkmmRXnzI-ctAerCbUX-t875

There is a an apparently little-known feature of mremap() whereby, in stark
contrast to other modes (other than the recently introduced capacity to
move multiple VMAs), the input source range span multiple VMAs with gaps
between.

This is, when shrinking a VMA, whether moving it or not, and the shrink
would reduce the range to a single VMA - this is permitted, as the shrink
is actioned by an unmap.

This patch adds tests to assert that this behaves as expected.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/mremap_test.c | 83 +++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 0a49be11e614..141a9032414e 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -523,6 +523,85 @@ static void mremap_move_multiple_vmas(unsigned int pattern_seed,
 		ksft_test_result_fail("%s\n", test_name);
 }
 
+static void mremap_shrink_multiple_vmas(unsigned long page_size,
+					bool inplace)
+{
+	char *test_name = "mremap shrink multiple vmas";
+	const size_t size = 10 * page_size;
+	bool success = true;
+	char *ptr, *tgt_ptr;
+	void *res;
+	int i;
+
+	ptr = mmap(NULL, size, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (ptr == MAP_FAILED) {
+		perror("mmap");
+		success = false;
+		goto out;
+	}
+
+	tgt_ptr = mmap(NULL, size, PROT_READ | PROT_WRITE,
+		       MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (tgt_ptr == MAP_FAILED) {
+		perror("mmap");
+		success = false;
+		goto out;
+	}
+	if (munmap(tgt_ptr, size)) {
+		perror("munmap");
+		success = false;
+		goto out_unmap;
+	}
+
+	/*
+	 * Unmap so we end up with:
+	 *
+	 *  0   2   4   6   8   10 offset in buffer
+	 * |*| |*| |*| |*| |*| |*|
+	 * |*| |*| |*| |*| |*| |*|
+	 */
+	for (i = 1; i < 10; i += 2) {
+		if (munmap(&ptr[i * page_size], page_size)) {
+			perror("munmap");
+			success = false;
+			goto out_unmap;
+		}
+	}
+
+	/*
+	 * Shrink in-place across multiple VMAs and gaps so we end up with:
+	 *
+	 *  0
+	 * |*|
+	 * |*|
+	 */
+	if (inplace)
+		res = mremap(ptr, size, page_size, 0);
+	else
+		res = mremap(ptr, size, page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
+			     tgt_ptr);
+
+	if (res == MAP_FAILED) {
+		perror("mremap");
+		success = false;
+		goto out_unmap;
+	}
+
+out_unmap:
+	if (munmap(tgt_ptr, size))
+		perror("munmap tgt");
+	if (munmap(ptr, size))
+		perror("munmap src");
+out:
+	if (success)
+		ksft_test_result_pass("%s%s\n", test_name,
+				      inplace ? " [inplace]" : "");
+	else
+		ksft_test_result_fail("%s%s\n", test_name,
+				      inplace ? " [inplace]" : "");
+}
+
 /* Returns the time taken for the remap on success else returns -1. */
 static long long remap_region(struct config c, unsigned int threshold_mb,
 			      char *rand_addr)
@@ -864,7 +943,7 @@ int main(int argc, char **argv)
 	char *rand_addr;
 	size_t rand_size;
 	int num_expand_tests = 2;
-	int num_misc_tests = 3;
+	int num_misc_tests = 5;
 	struct test test_cases[MAX_TEST] = {};
 	struct test perf_test_cases[MAX_PERF_TEST];
 	int page_size;
@@ -992,6 +1071,8 @@ int main(int argc, char **argv)
 	mremap_move_within_range(pattern_seed, rand_addr);
 	mremap_move_1mb_from_start(pattern_seed, rand_addr);
 	mremap_move_multiple_vmas(pattern_seed, page_size);
+	mremap_shrink_multiple_vmas(page_size, /* inplace= */true);
+	mremap_shrink_multiple_vmas(page_size, /* inplace= */false);
 
 	if (run_perf_tests) {
 		ksft_print_msg("\n%s\n",
-- 
2.50.1


