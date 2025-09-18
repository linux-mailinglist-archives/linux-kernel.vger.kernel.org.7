Return-Path: <linux-kernel+bounces-814430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 230B1B55405
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E307AE4DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716A223D7E7;
	Fri, 12 Sep 2025 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DjwQoZQV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MywW48PB"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883EC191F66;
	Fri, 12 Sep 2025 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691983; cv=fail; b=N32le9MmnKlKBgor4rYAqwpkGhwlC/MYUSZ8qcLo7Ut6eNGobZa12XD9mz+g6ZOvLXHrIb0jVRsDX4whi0mOD34fbpoHvzarsgTlIydCa7ThK/YT+dixnC52BiPiSuo1Q/dX8b9eTwzQI6IZMlZdyhU+HHFsEYX6zVv+5rb+CHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691983; c=relaxed/simple;
	bh=fXC7gJ46SGS6QSd/8WcdyKXqyqMqyWiYxWdMgCCle4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q5YGruziYVZwGsOryjYOBoqzMA/59oWXciBIvLWQGoL6MiFnp7digEVO1pDr5zzJzhMLb6ftRbeLrpAYbcpvQVyJyUvecE1oVIIpsabc8fdFbzTCVpiv5Mvq04ADlTPt1cgaH9sEBzIyICs9xAkrPiwiJmQsdvxVXL5ykkwQoZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DjwQoZQV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MywW48PB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CEbBIG027289;
	Fri, 12 Sep 2025 15:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=fXC7gJ46SGS6QSd/8W
	cdyKXqyqMqyWiYxWdMgCCle4E=; b=DjwQoZQVzNvU7m5ZdvUNzA+NeUr6h4X6ef
	DO1E8x4JKkhlEy1e1+XmZxfC93avKYfiO5j/1sLPeze/SRCXaTtsOEuLi/pNGM84
	iHJ1L/ycAZ2l3x0+xaOUx8t4Q5KzuLf6r63QK2M1Y7KvqJy+i8Kp9CCmXGJjPbde
	YjT65TUZSyJ7DxZgYMggk4WqFUkG7lexqO8ygZNn4ijyoF9cgE/YNyJGBjRUtBAd
	m//YC0tMPkLCY8ceP40KE/HJL5bJgOmCG6QQPVhLcnsbjNhCFynQ9WcyLbKtDBcJ
	+Egrr9Jya0HTr7G3SZGTeNcvMYCoa44OwNEP1QUMlKBZMh0p9yug==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922sj0d4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 15:45:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CFRTJE025921;
	Fri, 12 Sep 2025 15:45:34 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012070.outbound.protection.outlook.com [40.107.200.70])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bde36wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 15:45:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJpMPaDuhmabVTXai/zrlM+yv+r3zVOLsiSstkrUgyH1VUVo9s2aKsHGMkxRkgZNxVQiMk9puN5WqeU1yKeFvtMAoOAF5zt5VS9IUbYQ5WRb/RwxtG54XHBj7ylYOfuKzgFcy+N2bMV/AxB7oC38+kjBvL9tAlzoctRYjtlJGzfOIdqoIZFu5bDEaXRA5zbSpLJ0CBpi4clyEwiTyUwCt3H8Nw7oU7N3b/MSQzHTHwRG0G3vjHnmp21FvzhnLgL55gratRDnV27E15maQcO5ATHw/e774e2ZoIOnrkAufO8yE8Sl8VhEZtQrQD1lIbuJSaq1HuSAVrIYLwZk2yRhlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXC7gJ46SGS6QSd/8WcdyKXqyqMqyWiYxWdMgCCle4E=;
 b=eTmKPxRJiRYNYj7qYF+AUrYTI5Tror10nWM+vLSGcir1VVAo8qeFEWlSx0DsqXM1jiQZ1wskYyfnu7ttaC3sVpTesXpArofEP+5s38zPDwlph8N0f1zK6LKhFPlRQVxH2R+pT1tiqedknk/85QVzBW/BwZ2s042Esn6bSUiiv61Kelwq2du0PZBcK7weeGgw56TVvnCOlc/i78Uj6bLWsPsdsv+eo4vq0CjUA7ioPWA9A0PT/QGgOYVQxqRWdg6weB2V2wLdCJqXKZR3zymI3NHBVlxG//kqNt/T1HCOUUcPtmlW2Ln9Sk12ORAVVTJAsIxfOQu4x3jZiXzVjuJZcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXC7gJ46SGS6QSd/8WcdyKXqyqMqyWiYxWdMgCCle4E=;
 b=MywW48PBUm0nXy5HwlhLSabicV3ALPfpmMrIaktKFtseyktRnCp4yZXOBGgjd3ik/XB9UwD0ln/Lx/e24FKKNsB3ay1eTuSy6/NqkbvKp7cl+E1a0HU0r99Ff1DIUB6agxhA3p1wF5TqKkSW3w2yDC41yhR4uLjaD54PMOfiE/0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB4941.namprd10.prod.outlook.com (2603:10b6:5:38f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 15:45:31 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 15:45:30 +0000
Date: Fri, 12 Sep 2025 16:45:27 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Kiryl Shutsemau <kas@kernel.org>, Nico Pache <npache@redhat.com>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net,
        rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
        baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
        wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
        sunnanyong@huawei.com, vishal.moola@gmail.com,
        thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
        aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
        dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
        jglisse@google.com, surenb@google.com, zokeefe@google.com,
        rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org,
        hughd@google.com, richard.weiyang@gmail.com, lance.yang@linux.dev,
        vbabka@suse.cz, rppt@kernel.org, jannh@google.com
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
Message-ID: <be3525a7-3d7c-4dd2-a961-e4d49d082d23@lucifer.local>
References: <20250912032810.197475-1-npache@redhat.com>
 <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com>
 <20250912133701.GA802874@cmpxchg.org>
 <da251159-b39f-467b-a4e3-676aa761c0e8@redhat.com>
 <bd206c0e-3d99-4656-ad2f-f57316232498@lucifer.local>
 <cip5baipge3u2tb2ysds6qeoq7qjqmtkk2x7uefamcwpgh42be@24bwdor4jskq>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cip5baipge3u2tb2ysds6qeoq7qjqmtkk2x7uefamcwpgh42be@24bwdor4jskq>
X-ClientProxiedBy: LO2P265CA0489.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB4941:EE_
X-MS-Office365-Filtering-Correlation-Id: b86276c6-238c-405d-e0f2-08ddf213670b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6bLb+Pp6WYpcHg1ohn9x90vyPLZFfkEN8LgOoqhlNnPeRg8fYJYfksvltAQm?=
 =?us-ascii?Q?PfHNiFmLbqhKsXCpM6cJwazDGiuBDbMArMrzvUNkNMQ9BxYTcxl3IceJQFVr?=
 =?us-ascii?Q?mJw9X5EeGqLieGSoaPlfGyWb2fFFnc3xvVk73qoC1q4WtDK1fKZsfO6fxtG+?=
 =?us-ascii?Q?vzkIGubFOfx83VQwIciIspWZunco2Txj4FUfQXyuvQlVDFU66sO5vAuchL8P?=
 =?us-ascii?Q?awiqpDsychWueTfwdcSsS61Mfpgxn0ifkp60d3xamJeF2uOrGHysAhAYCk7I?=
 =?us-ascii?Q?+Mqk/DwLSgGgpe/ou7gnnyJDsAz6mOfdrAqi8Oi1lJlHNWaIdGN982jic5N8?=
 =?us-ascii?Q?3hBzuiCDvOtmiGSm4uDRzPoDwEiGqSZXJhWtye7QCfGF5kD1gjfJbje9ZTPx?=
 =?us-ascii?Q?EZSW9L3HLbxaSkLmYVcZcQU4WOMCdWk4znzmxr97+8ukkTGPsdyo3doF6wVb?=
 =?us-ascii?Q?WbL8IYzSwmLVTCXpGISR7TQSLWlz+8sGA3EZLwiM8FoHQcnB921JO/QwewPM?=
 =?us-ascii?Q?8Q0hE7nY4Q7lQ0sKJK30//eY4IZ4t9Tx0Hgp/8eCNmclLvIAThalOunhrnht?=
 =?us-ascii?Q?AUmSAcXWoFJK7p3L4iIdq2frdRxC5VoAaJZDfelTUEzuuMZWm/5aaIwdF2uv?=
 =?us-ascii?Q?Cd3OB27mgzkvnOjdjXzgVHkNqW96b3r43Pv9nBvmVvwCDOolDsDo3cxy4deT?=
 =?us-ascii?Q?D0CivC69B3I6MKEc0BcN+bUQlcz8Zl5ocshodGK7SrwyHVSh8vLis2mkuJmc?=
 =?us-ascii?Q?Niqb3XFKljTl8Z35nNXiccqFkL+wavnI3BmPMq7VVm9dIrSHT+eTc7cVA6uj?=
 =?us-ascii?Q?FhbJC2Lu0gqZ0KOCwyVt+hozFfs8qJ4vyls7h2xexvrtTTSh5g8I3QxsOcpb?=
 =?us-ascii?Q?EFtuHzlX9hQOFDZmf4aRlMT5SsgCEjrvl8mnZmYdAE3rj1n/V8q3Y1g2lChz?=
 =?us-ascii?Q?1Y/+dG27OGtkgOgS2o7HN7Jz06LgWGiV3ZsFHacZUt0WrirxNbDvlprGSL9G?=
 =?us-ascii?Q?V7d7XhEYTHj4lApiHo5Nq0G2ZMLC638TZSDiKd3qp5UuivyDY0I+omJuAW2E?=
 =?us-ascii?Q?FJtxGcTK57jm/x5N3pwlTMjDHZR9fuBjJxLHYsj4m5G171DDqR8JzRhVMeEV?=
 =?us-ascii?Q?XW1WOodMu8vOvCnKoNpReX6pYisPwxpoS+RF/acP/vU/urR1ZUuMnYcptHLf?=
 =?us-ascii?Q?NTHw7QlhYATmPmAhwP5vIrY7uBkZ24wLAp4qMI5s6p8ak9fpgaVjNWphjonV?=
 =?us-ascii?Q?8j4bIww78gt4h6rcJjGHr62eM/r+zt3wjJfLtH5tV4V6l4p8QdHpjZb2iy+o?=
 =?us-ascii?Q?tmHBIM+j5d+Z2MTxWmhHYgmYUFby3PXC10/pZ6LkMKsOICfHqHdA+KCoEALc?=
 =?us-ascii?Q?27/FS3C0cckumNFKLFn3eo/RVfa7qZRkTOsAxJe0mPZQUVDue3qZay3AmNHq?=
 =?us-ascii?Q?7teI/tQz0Y8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BVCoiz48iQaaYF4LueLjyy6JgteOZsMqnmDtjTPDux7uZIxqdvY/GCux2B+g?=
 =?us-ascii?Q?Q/Unnnmzvw5MB/I877RkwV1BqZ0YABw7rVts38oVWGJRBSpHg2wrwfRXQS5u?=
 =?us-ascii?Q?fPF8SPrIUNiJgDZp32m2rrVf9guPuWdRH9SDu+LCePnSsF+xZ5nQRm89nGQx?=
 =?us-ascii?Q?R7socLcBwBnlCGRLh25ug1drFlKkf+V5TzWeN79ii+TMmJPfDdpIeOV3hGOq?=
 =?us-ascii?Q?OK/2WvWme0w/szLewi5P/3bj2jQw6jQo8iDrcMTJHBE6sPCWLSmGRrm5eXkz?=
 =?us-ascii?Q?Hc6CVU/LCIXkqMA1Uislb/GO/TQWJ9HPryXRhk6EK8k+fNs3zGsIlwCkd55/?=
 =?us-ascii?Q?S4h7FrhgDT5HfwMO1eGwYHLnjJ4s7QzBkcCtcvAE6ohvdmQlJ4VZiIzWyXeq?=
 =?us-ascii?Q?7zeteULEl/97B95przG25xGNOMKsfAHmpyOa1OhxW+N1/zv7p/GRwiKNC7zY?=
 =?us-ascii?Q?gTr0NPY+QkLD5C1zI/JQh9RSENEhvJGoa7qyAPMARe9tlc1Qrp8AAam7l892?=
 =?us-ascii?Q?2fkyXBvh4+uROnu1dBg7uiVpqVsjbzK8LyJc+vToINTWeQSuW5Ds43dbL/Cm?=
 =?us-ascii?Q?fkN+CYhhN7GDz3z0O5EJivLw+cLcX1FuwvUYmSExXKvrZSs55sPctmnoBMzr?=
 =?us-ascii?Q?HWW9M5X8VRI6S2Ji+iyV/jRdIUv5Jf4LjNpI1V2254mfXFSpcosocoSVqtzs?=
 =?us-ascii?Q?6iI9c0ocq9WAPAPHYt60MPTLk/OVmtpwI91PMbRS0mnNirteZuBBwvFP/ycR?=
 =?us-ascii?Q?VLIYcDMTAgkHjmS+FzQEAnEUDIRZWjxP9UHhDc2jmwYDMVWpBkP9ST+WoIZD?=
 =?us-ascii?Q?0KIPmjEukX01MJsrFVdck4KyBCp5/3+vPxHTID+smd1txrWoNBPERrEvnFMB?=
 =?us-ascii?Q?rvCCycTqpUFe51PCpAXXYchWnXw5LOe91ZZUK8j8Iwl4BlEeQN1AbLjCJ0AU?=
 =?us-ascii?Q?EDzMuS3J7EomomEoRtJ8Pkh/o27hgQ4ZzJhxeYsmrvp05mL43m/+8JUASNNv?=
 =?us-ascii?Q?SdVjUzhvW3LaxCIRGz5kk5IQpHddHZFxi95lbZ6vJVyO8NxUDxL91H/qNzHH?=
 =?us-ascii?Q?cBf8sc8Lbsta+EJME+6TkB2rX37OlRZXOtWda+HSi5VgjQeXHWg12JYTqNJI?=
 =?us-ascii?Q?2UibYIx7Zk4Q5fSEX1EgJ0YFXK9iCevOrmz8ErUZz3AJ1Zhidg1Qbj+++Iu1?=
 =?us-ascii?Q?G1PgOHy4SROiLZlnQKPJOVh59iB6ZDs1jkbzB+sConNlbURs76w+0pSDPFCo?=
 =?us-ascii?Q?IycbPpRk5qHZnzTHpPnjD2A5gYkSXIvav38qo+Xa3h4kL8Y3E1o4I6j3Z33V?=
 =?us-ascii?Q?lGpOepIGwhqhxBGRJx6/DsU2ioAGHJH2X9PRkUpKp+XDYGozMipfdw9QqHFF?=
 =?us-ascii?Q?uaErl74a/8iE9UcDZFrNeHDxcng6D8wqE3A7Kuez6q15s0nyFOkdXNuEFI8u?=
 =?us-ascii?Q?b9mMjW9H0xvOTwH/keQxtzCZ2OZtWd2QDHUWe77vHeqzQKdY1AzqV9mwvxZJ?=
 =?us-ascii?Q?jYXnE1wuhUz47qzQ2AvJWiBVswtmdURk5kUZIddjKsFRzhGn7+CcpoJ92RkC?=
 =?us-ascii?Q?/2+V8C0IgsMUSYsq3toQ+JwTkB2Xmwca7DELjeTk/4/kY76nwwtbA3H+WN2x?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x9Vvj0tBCMG5W4Anrv80OiuXz68FuRh7XlBLte9psj7MOk6S4P9CTB9tVG6fXlxorV/5IhHWV7wYFWvWlrnn/uQKel6XTLMvcHZ3EyKfN2L8hPfVA4IboXZCllADZyrtO/kQ6Avy5Jg3NikeruQY8qjhk5Lw0M+YaxFO15bqq2NI2l5WvFRANprfrA/3/Vd4Bcc+K6GHQtmkpNJ5+4SazO2InGIUJJFUrDqru+f7CkjAbQaionQpnpRoZKBeLS0AtTnjXmADhJJXLkl8QuPPzcIaI79yVQVxGNeGtNnHIHlVErYl9HHZ2k/FVcnmFTR7I8LLtOzcAWhA0G+JlUaOH9LGyb26P62koC+BZM3wHl2IhvXBE4fN+AtEHbmaC9HzIzRT3/WlJ95CzOh9QJ298Y/b4GC3ru1ZcnvY2QRuLhJaHQIHuSBxGW0ag6OUofwDY80y6Uggu5GQ/+e3i10FJXRONlDb9O2W93M3p8X/vWTjbqdgJVrmkigpsnuHs9u3tZxMdvR/rxHstyTFGlqESTnPj/rNucVoNlipM4rBcuzbuHJcBVnE1Gxx1XbLFM5OlwXqFFZkEhhCqElDKc/1q30fSUt6DoUmwM0A07dEUy8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b86276c6-238c-405d-e0f2-08ddf213670b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 15:45:30.4317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45/udBxsoAVUhDEIVNgX1SrUe62Zo+iA5fzzZHamdr51i4EUz7GA89nO/wLYYg/DerLiV9uCl/G5o+TM5hg0SQIpI33Yb9rydHrjoZH9lzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4941
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=960
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120146
X-Authority-Analysis: v=2.4 cv=esTfzppX c=1 sm=1 tr=0 ts=68c4401f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=dS2fH9eHbaqBh2LGZjUA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13614
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NSBTYWx0ZWRfX0OR8pbDqnEnh
 VrCXjMCCQIxxtcpjUemkC/4ePy8Wv0qPM45Qm6Eqk/jlk9H41MdnKUVcbIsuz2fRDCNshHATmZw
 O++zpDym8JXLNvVa8XdBzGq/yUpj4s3rR7C4nU+ViMxrOmajkIpt0rAKvSpD8KJjJKvifNFeeOm
 7HJwGa4euyFySDbJqgSej2xbD4pcU13RUtE/j/Fq5IE8Xmvte31uufMvJrJMP2NZS50vnEi9w2M
 /lMN5aytBFOVRwT2/aGZpXwbVbdUlSGPxxNGH5Jio25L8Wz5bB/3sJ9Rn448WVXp4JjoXt4cfGg
 jQd07LjAqGjdkcAIy6z555S6iNi/crvz5aehYsruBIF6Sy7vt5Yq8GuTpy/pJjNVIBUvruSuv8r
 hO77Oomsj3GR2IAywZJCe/btIXR4Uw==
X-Proofpoint-GUID: z2chgj8fmlgvxXZ480RVCkIgjD2gkzUy
X-Proofpoint-ORIG-GUID: z2chgj8fmlgvxXZ480RVCkIgjD2gkzUy

On Fri, Sep 12, 2025 at 04:35:44PM +0100, Pedro Falcato wrote:
> On Fri, Sep 12, 2025 at 03:01:02PM +0100, Lorenzo Stoakes wrote:
> > Yes, but at least an eagerness parameter gets us closer to this ideal.
> >
> > Of course, I agree that max_ptes_none should simply never have been exposed like
> > this. It is emblematic of a 'just shove a parameter into a tunable/sysfs and let
> > the user decide' approach you see in the kernel sometimes.
> >
> > This is problmeatic as users have no earthly idea how to set the parameter (most
> > likely never touch it), and only start fiddling should issues arise and it looks
> > like a viable solution of some kind.
> >
> > The problem is users usually lack a great deal of context the kernel has, and
> > may make incorrect decisions that work in one situation but not another.
>
> Note that in this case we really don't have much for context. We can trivially do
> "check what number of ptes are mapped", but not anything much fancier. You can

I mean we could in theory change where we determine things, for instance doing
things in reclaim as Kiryl alluded to.

We _potentially_ have more to work with.

>
> The good news is that there are 3 or 4 separate movements for getting page
> "temperature" information with their own special infra and daemons, for their
> own special little features.

Right.

>
> >
> > TL;DR - this kind of interface is just lazy and we have to assess these kinds of
> > tunables based on the actual RoI + understanding from the user's perspective.
>
> Fully agreed.
>
> --
> Pedro

My overall point, FWIW, is that a synthetic heuristic tunable works better here
than one that maps on to an internal value that we then have no control over.

Or 'I agree with David' IOW :)

Cheers, Lorenzo

