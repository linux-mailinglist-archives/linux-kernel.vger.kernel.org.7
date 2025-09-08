Return-Path: <linux-kernel+bounces-805347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBFEB48762
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A14A7B1A66
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DDB2E5B11;
	Mon,  8 Sep 2025 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AhEOapRt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KazzdyqV"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD4729AB1A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320851; cv=fail; b=BvOHqTyYjCzjCJ73vYY6/oVUAQld9McngkqihLfSWSodGIkpb6iizyVQmXGhh9+jIq+5GCK2d7vx4Y+VZy9V4CRRNZR/836z8iMG8hUCMDpbrYEr2w3nnb+yCpvQCDmh8rp6azXMdhqBJdemQ944ATm2SK3XwjJ8LR2p/3P1ISM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320851; c=relaxed/simple;
	bh=ZPZcYdgNM8toyJpyyLPaRHO16rAWgDqBRJIYZeMao4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qUaZAFg+fHPduF9y8yRPZtpoQ7fsaNmUc1/RUVPXtNJbalq+PjaYcdQeZAdgjVLX46Wlog2cdB6AJ8/BdcsXyw38+/ZeA3jGD2izZtm1l8yQK//mO4Vi9Q4qHo2YlJvhsh6advgVq2C8jO1Or67jX25tvMzaYiG9TTY4Whp9B+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AhEOapRt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KazzdyqV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5888AFDW032236;
	Mon, 8 Sep 2025 08:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=cWoa4LMOffYBWpz+HS
	4ujA4paR0PF9a9M4LfE7ELy18=; b=AhEOapRt8Av8+Rg5Rj+WX0Mhbd6B9vgEMh
	arJadbLsNZ20mv2rUbipiIUiR8CyzXvBbSzw17Lh8zq5MZFTUZ7XQIDqO0hgk2Ti
	KGVtHPh3xSml2WK0J/FotXFHj8T9BX87K/pURi3kYXhPuCN8SZ6bWdge5KZjBFQc
	Z2UUHVU9y1Hfh5xkaRMfb2HOin7R7Gc96vaPbAlKtQrwN3IR3QMt5K5n9nimdhmr
	AKKH9/it7t2rLxZQ/VXGmqWbH/skQqYwLUlAYyfWEf89kmZuEzxcuS+qFjlwqpH0
	TjjMhCHPeVstPkKFvzZ848pHU3y8KQgOyE1Es7IdPFn0sSjoXIrw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491ucu02dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 08:40:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5887Isu9032858;
	Mon, 8 Sep 2025 08:40:15 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd8vwpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 08:40:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/x0AL0/3ZrteihWzen/WoIlMXGRHSkrtzfDWF3laxyEf35UilXHujVmXvzX0nNFht0LSWbuv3Owem/lk4HjzOn+/0T4z9yVbSTUfcqyONTYJGp2rVZVNKnwQEHb5SqEudzdrb5mq+zHF8UjTTjOJyUzcUjl9vzGO5/Zv6MVMB5biyYsAts2AQHtXpGpp7SRlm2Ri6j7vAk9UBCm5VmtDQ3rRCClIGKbLuu3FelgtzUmoYu8c2DHTZXCPyd+JaT3eVgaWajrymqap0DVFcf4ah/kXnVkA39ZgKHt0qW9McTFIokxiMahfBeplXMY+7B7lTzhHl695+bQOnd6ih5rzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWoa4LMOffYBWpz+HS4ujA4paR0PF9a9M4LfE7ELy18=;
 b=Mv80Q5hNBr39KPyn/VeEaK0SRGJhK0DE/47qVS1drhMcCUph6tabOh9l8rLEg66kwzyQ/TuqVIPPR+TI6csMgDjITEaRU9X/SuoA6rCCR3ib8+oeJ5d6FMjClyHCIlsrOCXLrmaScduUyPAK2AMMQiOkddSFyg83fYamFQjLw5yK4NwI1WYnQIeNORRp6/jjc7HnZD9i28qAQ2aCHj8oOsZn3mLwM00AKhSREhpX/tQF+HCuiMAtWKtDAAz0WH1WIa4VkUro8+7Z1eQtI9VPM+EMLHCsr9rTQpzmxZXAsj5Y5pPr1RQeGXIeYQxWSunPq3HFsJuwJhMUClDJzHwjog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWoa4LMOffYBWpz+HS4ujA4paR0PF9a9M4LfE7ELy18=;
 b=KazzdyqVGImV4Fr5+3nG6Tt2Zy0ZCicU7nJFSSMAOkfquSxG0XTTq9DU/7GaSH4C9joyTGir5iDEdNfjv0u9EgNgmO8+h8dZ7pAORp/zHLiddpsosDZrd4tMDv3KqgELBQJjlZTMt/qieMJevELq4j+HlJg5iPuBvx4gzBJ50SI=
Received: from DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) by
 CO1PR10MB4419.namprd10.prod.outlook.com (2603:10b6:303:95::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.19; Mon, 8 Sep 2025 08:40:12 +0000
Received: from DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935]) by DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935%7]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 08:40:12 +0000
Date: Mon, 8 Sep 2025 17:39:42 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, Ye Liu <liuye@kylinos.cn>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: Refactor note_cmpxchg_failure for better
 readability
Message-ID: <aL6WTrXczZJYUoGb@hyeyoo>
References: <20250908071922.1062170-1-ye.liu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908071922.1062170-1-ye.liu@linux.dev>
X-ClientProxiedBy: SE2P216CA0138.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c8::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7341:EE_|CO1PR10MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: 69503b7d-1f93-4d75-a4b0-08ddeeb348a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AasZQjgmVJPwl/cCEm/lFTcEsmMYWGK75rb/u4vp8V6AN7MNPM4Vn0QUi1WK?=
 =?us-ascii?Q?28aG+XXLcFMC3lEyFx0syteOlvp7YZ5QtKMWsbYiTj9oN3gne96bhT49ejoR?=
 =?us-ascii?Q?NSUX58qX5dvlPJSalBKDh6pfzHzMh8QaT7PbfSC/iSidY/2fGF4OTv5oAQAf?=
 =?us-ascii?Q?eyHAWBhZnPTx2m513pm/C5GBL7dzFJ8qJEUUpkywqqSSAdQi2v6aIANyZbn5?=
 =?us-ascii?Q?XHBk7zPKaE/ku1QB2izVbF/zvyzY696a95G0S+QNjrQDUMqEb4G4jTRkNeb6?=
 =?us-ascii?Q?cloj+zE55aa+xzE5bU4KVy2ABKRnMqgqRKqrTBNIxt8jxrp1Z7nVIAhq8WeL?=
 =?us-ascii?Q?DfPZ0u/gQRiXHFuBXZYxpAVT8R+TLvIkQg7K18fE3Y3+9og7AlZm+ytblQ7H?=
 =?us-ascii?Q?dVYuFaOBLRqs4D6VsYnp7s/UyLJZhz+Urb0O5Sop51cvkMdQHGVbnXHuEoOW?=
 =?us-ascii?Q?yJ6syajowlHnLyJexNgWZsmY6yoLJpCfNI2a78MeW++LHEbj7h6KCOfX+buz?=
 =?us-ascii?Q?oLo5B7tCh1HbXezZXw9U5VUPasJeymx3+e6oUYRBLgNunot/H8ZZ0qnIJBku?=
 =?us-ascii?Q?xA1jNT4pbfvcBQwSHlrvCJW2D2gUx/0Z1fdennJCTzvbBh2I/E30rD2YIMfm?=
 =?us-ascii?Q?iEDGqwoijR7EoU0XHhedXe4028Y8p+inigkkHQ1a7rZTqcaig340QoEfRIGb?=
 =?us-ascii?Q?iP/FFcBTDEv0wquDiuh31iFqtOu5FZUsmZDvPvV0SDDCqyOi7QTURJgvgpPc?=
 =?us-ascii?Q?mtT/OL+tvCm5jTIcMBHEnhn2WOWQbxu3x4wuXYrmweiXs6WvSS2cUzT1ZGyl?=
 =?us-ascii?Q?wS/a/xUH13hSe+5K9CEb7n0zzUw0kOS+TRoP97ifMKOguneM2HO+fPL3kYs1?=
 =?us-ascii?Q?SlCTRT9KNB6tdb7CHimcIm+JKaayeDBn0wr/m+hRcZAQrtzd2iYoaIHOWEWA?=
 =?us-ascii?Q?1HrxfE166u5zBJYkn2lDT9/3YUoDQ+P++j1dGqo0zL3r/vzQL/UoUicW8xiv?=
 =?us-ascii?Q?XYpE8KKKCKQTeo8MP7OBgpWy6Ab+lxd2OmJN1ZoVfQXf4gVqtdCpot5ibLMt?=
 =?us-ascii?Q?295qqixn+Owqhx/3RzklZuB64WIMXh8wZip8ZUNgT4yoTRAjCGZRhS4jOO3f?=
 =?us-ascii?Q?Zb6c6iMiGUi+UWA2USj7JfbGDuz4PapO7HnJYm6bFlpSjf6VqeyMhG/VTb5g?=
 =?us-ascii?Q?2oCsyzuhMEm+vU4zr5Ft9D1OvpRat5m7ErOhL87CVrqrIWl2UuDKGRemqN6+?=
 =?us-ascii?Q?ILcjMhn6BkxxUBsDV0i4n0U+fH0SquMOECm6tpOXhe+JmIbGI2a0KI/f9nxC?=
 =?us-ascii?Q?e9L9Or44mEYLqJ+rQVbBQUJlvxdgaZ7MMspO73bDZqI3rMJ1kOeYVOohIbfj?=
 =?us-ascii?Q?tfPKrD4fawYfEV8DK06a8Cqiijx/+Ge1V0CwumMcmHDbRPrVWCzNA6i7fJO6?=
 =?us-ascii?Q?wy5hZQBxRgY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7341.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y4I+xoj0fTRqfU35lxwiIyctSX5OkeVegF8EJsHL+V4SgDbh/aiXSGNPGH0K?=
 =?us-ascii?Q?C7ssSBZ4ug3OXfmu47Len8dGBFkM99aPUOJbzPHsI6SyofGejftwvR6p1Q40?=
 =?us-ascii?Q?ijlS7mU3eBNpFvyUlfAJrSzZeM5iz3ItDDTSeTWHTya6OhgWno61qEopPg3z?=
 =?us-ascii?Q?sBCwIsoTJnEPRk3nuK1bYDBoEpOw0H5tkGUj4pKx2vvfFexdy0PUHWCrMotS?=
 =?us-ascii?Q?6mDiBzwDWvb7x7/KfHsPKX2OaQMNzJjcdDoMuvrZydmcOQ86T+5/rEylcVyi?=
 =?us-ascii?Q?Zdukha2iMiWkvsTVLy260eW0IdkV2FSvqoJ+AhPCWKnhBwvvkCvxi8CzIBGD?=
 =?us-ascii?Q?GO74/n2Qw4Q+cRfe4/5bg0sHr3U1yG4j/DfA3/Pno0WxUuHRj9/Q+3AFWWEM?=
 =?us-ascii?Q?nuUX2qOiF02k0RrrjMoBcoC/XiJf6XCdaVzo7og8R9DwSx71WoK5KiIuoAsr?=
 =?us-ascii?Q?k1e6wZPwb8yUZC3zGz4HrNtPq6xFxyPyvQiD/qOQq56+5D5GEDxcB4QoGwXY?=
 =?us-ascii?Q?MEIWGSwNZdyxwiJUFf3P2jf7TbURb6deH1pK+hPJ2z53nlJFVVruroSFhX66?=
 =?us-ascii?Q?5+LqJQ812JP3TZgKz0VOaAKzDg1uagoe4488r9NiOFoNjPTsCLgYP5G3GAV2?=
 =?us-ascii?Q?hXZCffPCIQT+004hrl8vYxuWnU4JqXooQVbHTt1xrPLXfxsGKueQiJMwicRw?=
 =?us-ascii?Q?fViT+CzQQWv0id4E/V2Ty3PeBRhjN2OphYdVFDyzzF0tRdeN7dDt3meqzy1q?=
 =?us-ascii?Q?H1W9hVZh1Mxqvi6/Gj5Ms1gPsrdw2bn5YfgYU5HdWNgMgCiJo6EbicK6f7AV?=
 =?us-ascii?Q?g98B62em/e3H+Do8k0Ax3/4l/MelhNzKllvpYOSsR/OKAYUFk8oRqhEEO4pN?=
 =?us-ascii?Q?Z7zrEyjqVdwb827ZOLOsemYsBLPRHyHQB1da/UGvDh8/sjro7Vq9oNqmbJGw?=
 =?us-ascii?Q?Fd9bkJxMLKGZM4VrHwXmndL4b3Z0DQ8zUcgnAnwKjpfgU/tIucPT6tMqNQMr?=
 =?us-ascii?Q?OBv/Qv3SWQCcx5iF6hroP4XonmXKKjuPK83RYSZaW8Qt3vspXMq7XwQTngm/?=
 =?us-ascii?Q?TXtSJ36HF6oFottpU6VeJy65K8EuQ1Ls9cQehEiETH16vr1/7sP6luqUhwRT?=
 =?us-ascii?Q?8uOyFkQ4Cv1LQs5d8j1a0rTytDmJPbg5Hzsb3LtNRqdxm6nhXRIOFhw8LxbU?=
 =?us-ascii?Q?qrlIb5LDS3NKzwxDyELPHlDYTLamZe4DZeyf7K5i/xKiHZRdUT/vlRHMlivf?=
 =?us-ascii?Q?M5Zxas3OFQaGr4zL5z1vxRuIOJ/0Bq3tHUxu8qPqnzglmTrjY5HhgBEfldG8?=
 =?us-ascii?Q?NJXjPf9gLs/2kWtmIJX//RunrAYv46QNuuU2caPahihgcOdukx7Q8w7Bs70y?=
 =?us-ascii?Q?vN/qIFDBiIREzpu/7KTmjGwqvn9/CKkHPcrpDMl7PhUjWgX1VTKP8NSXVeJo?=
 =?us-ascii?Q?qrQF4Dh4GLk8CDksn9eA1gRB6NJuljngrEYnCLSpojy9L19dLnJgsZxDRUJv?=
 =?us-ascii?Q?cNP34DiazGk5WF4Uv/Ey2uCV/vAYumotoDtOCKQmSR24n49eeMsIdPhAHB3t?=
 =?us-ascii?Q?cQOPX5dnFAS5YUyBuhT94HkDWhWE2OOQrNEqqdVB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S9//QHavltfGo/HEf7+deA+ircmGZ2Jbz1oD5+qaVD5mor9CZPfXis5TZAq3gAIqEXywrqpKqnXanNH+5pTeF6BUbuu9mEaeoqbbleIK81IeBV8YTYXaqDv9L8s9cpXYot8riKu1ZctnUbjfBH/15xr0p5jkrZaC918KFLkdFvKV0ykHbTEZG+2yt1yNDq9cS5URDmf3/tjNNmWys9j8sIu/s1Q0MUC0W9yEkewUbmeYou4SLYR4itH2+Nf6+R2UAN8tQbt7SqCboR3uplAO+5rWZZdFDLWXRg35Jft2EB4wbIefYLAXXXe5BkC4R3UTKXuAXOqUZJOvEoROA6NfTk32jmft4wDQoWgm8+j83zbxH1QPshTFhwdxB35aHPEGJFm0N2S1C0+z214VY2RY+rg1/QbFqwuif+0mdu2fLCBZoJ/Oh5JsylLSmnhh9YdZpoTIYwzvJcWfP0tk1xrvXL9dUnwHv9HAoOXTG8M7/j4h5PRWx0UBtniKHpvO6SwZtd1XemoysTLzST7Xwpwew3IZyy+Xf3PKKnAb1wUlWnoRsFsy6qqsTY4sygmpG9h1aBBhhuKsbvemKQ8nAswRwSssBWDMWRoH3ptJyrpBA1Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69503b7d-1f93-4d75-a4b0-08ddeeb348a6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 08:40:12.3840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHYEtvP/de6deIwwKIZ+A98f2q+e8PrUphS33hR412gXtO5pj5Rzd7kL7dNHb5p41uFha9qjN3kWqC77GPM8+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4419
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080088
X-Authority-Analysis: v=2.4 cv=c66rQQ9l c=1 sm=1 tr=0 ts=68be9670 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=OvTCiV0086DzhBq8J6wA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: F6hm5psLUinL4-sBdn8C20tcrh-W97ba
X-Proofpoint-GUID: F6hm5psLUinL4-sBdn8C20tcrh-W97ba
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA4MiBTYWx0ZWRfXzTLyTv2PQ7bw
 idzaOZ/cbuBgqQn7zzbX0AGRPUEwb65/q5FNnJu345sFeW8s7ZlehxG6Qt/4To6bEsOAlKbqhNO
 LXwJ64kxpGcpwaCHt2b0AZfcwtbYU/8tJKOOxA8Hr4z4ogaWYBX1sl9ST+uTczwx57LFosga3t1
 ycTAI/ffjNyok1WAeXTF3ymF/Yl1qWQVK61gTSZ/9AD//1DL3CB2FyQRsDR3cMhiVb5NLni6FRR
 JEAGierC0nhMv5U3JZKkE7htI6Y4wix5ghfa5zD92QYr99uBcJ3oitovslhZpGA6VuX1TNVDdZ5
 ksq9YAZVrp5x+H/Ci6+nxPpAJzEfJLa1kVQfr9202b7FkbDCUjSp800LR/ila2Uogc8/QgTudgu
 1zO3KmE3

On Mon, Sep 08, 2025 at 03:19:21PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Use IS_ENABLED() and standard if-else to make the code clearer.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

with a nit,

>  mm/slub.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 30003763d224..34853c0441a6 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3064,18 +3064,16 @@ static inline void note_cmpxchg_failure(const char *n,
>  
>  	pr_info("%s %s: cmpxchg redo ", n, s->name);
>  
> -#ifdef CONFIG_PREEMPTION
> -	if (tid_to_cpu(tid) != tid_to_cpu(actual_tid))
> +	if (IS_ENABLED(CONFIG_PREEMPTION) && tid_to_cpu(tid) != tid_to_cpu(actual_tid)) {

nit: insert newline after && as it's more than 80 columns?

>  		pr_warn("due to cpu change %d -> %d\n",
>  			tid_to_cpu(tid), tid_to_cpu(actual_tid));
> -	else
> -#endif
> -	if (tid_to_event(tid) != tid_to_event(actual_tid))
> +	} else if (tid_to_event(tid) != tid_to_event(actual_tid)) {
>  		pr_warn("due to cpu running other code. Event %ld->%ld\n",
>  			tid_to_event(tid), tid_to_event(actual_tid));
> -	else
> +	} else {
>  		pr_warn("for unknown reason: actual=%lx was=%lx target=%lx\n",
>  			actual_tid, tid, next_tid(tid));
> +	}
>  #endif
>  	stat(s, CMPXCHG_DOUBLE_CPU_FAIL);
>  }
> -- 
> 2.43.0

