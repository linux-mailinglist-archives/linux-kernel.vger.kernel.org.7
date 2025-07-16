Return-Path: <linux-kernel+bounces-733659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAF4B07782
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C9E582EE1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCCE1FCFEE;
	Wed, 16 Jul 2025 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kUaCatoy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HvNTY0XU"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAE21F0992
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752674409; cv=fail; b=eE15rhyUnkL7pW002z39g0/C1nnj91npbQ1y2AgxSdV9F5C91v8uFyj15p7W2dDuDDvgCIiH34noCDoMuRokAcKbNYRkLrBh4MYghf/ODW68bmKhOjE1IHRsshwNOTZ2vtAOyhdmbcMlrSYsn1Zgzbl2IuSecEEL0sUmcN3EFzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752674409; c=relaxed/simple;
	bh=A4jIYbjAPf9ZGqwTXCjjIKcpvC9dh/aweIoliPKQxgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q1jnFLUPqT1BPC63rrAuhFeGu3fi5Mx4VoYlMu2QIpv6GMiI3uLIh0578X4N3PHKGuiRU0uT52I+VHWU4WN5dxGpBtQgzpI5abND+0kMyAwtQwJ8gazEzRvepJWkSWM5IprUpgm2WWH8VGXBoxZeakuN6D7Dv0Ol5oAuHwKSysA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kUaCatoy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HvNTY0XU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G7fqnE018623;
	Wed, 16 Jul 2025 13:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=QgGUa4yhyHGZj+H+Hj
	3oodPh3SltMOGSpHlhlikqsHI=; b=kUaCatoyq8Zjwhaqqhxap7x/5aBOtqUbcz
	frW5mE3kFBoHAvHlCXIPYXI18W1Y9rhj9OM+Wi8ZgqHT17HBWtmd8DCHfACjP+gx
	Uw7hSWoZBwhPxhSJSCmnsbyZ0h4VQO4oVK+qFroMT7LY+0snZs0D2rnHFpU/nGcA
	ZTQSrfMh8/vK2gcWXAuazhBV/a0gN1o0O+a5CNDULybGZyFN9oEdHkpE7OMPihD1
	Et+ed3aB6lxoqRrQkyM3+/gZT7u8wJC1KE2rjXSwwHahV5204uU4QsBYwp9KrH/8
	DnvsbOwysYwzKSEPdsP/2cYfII4CYUup5cQQ56oOcQ5QChuxYlsg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ufnqsrcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 13:59:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GCVCNP028891;
	Wed, 16 Jul 2025 13:59:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5b47hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 13:59:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFYIzUwTcGifd0Rf14YVY3ulM1MHPmoC3eALxDAW4gzny2qqrtz/HQ89gRohqnlQLwQv+Yn0sya2mX9THt4SsJgYlLVWSNW751YtXbThuAz8SJ2I24smhs6R7OyTdfzd1aYGz5VJtMHWrwL3u1M/vwZx6JaZor1NaMS9td6ZF6Dhg6tpmFxkCy0c13+VTANI117gLY0/csZTBZb6K3BEAj4ST26yDXF6owZcabytUSgjrZP7IlOPgBjpArOv0oCSh/C3Tj7NAvTnOTX4fWmXL7L5N4Fi5h/pxQSvB0V0CUtjAflqmhYSnrh5f0xipmn8Pl2jnqTSe/mH5ZOAtL1xuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgGUa4yhyHGZj+H+Hj3oodPh3SltMOGSpHlhlikqsHI=;
 b=onV2BZpnx07o5yhqmShAUqtOvhO1g7OMyXUcqWJlcoFs/l8EQnijneet8BwLIGF4EE7VlxYgDQaNjC1USYThxGF6sSup7CxR/ajspLz4RQt6DGlRB/FKxbhk6vEoF3BnCcqTGnZexJgx1kZukk99D1L0WTFBd6qlgudw2axNZThev+oucYS1jmF5AEd5O4LWU3Cri4CAy7k7/waHPg0UoTOxjYW0nZIY6U18+/+TvplTUcpWgJcBmjwQy67iTRXy/5I+MpGawU+Hbr8BzXKUgMnPiOv/BKl/CQW+dqhLNrfq5L2AxStnd76I3YkpOiPZLHhAH080iOtqrsT6pz5Yvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgGUa4yhyHGZj+H+Hj3oodPh3SltMOGSpHlhlikqsHI=;
 b=HvNTY0XU5AyH/Oof/M7r9aBnfsMBNWiumynbBPpyd1bLo3fkwxIpXtcFfJpIMwFxH2UHe5aIXOn5r/yv9BUfvLmPRTkQA8HmeqPHPponZXW5RvpPlfr+dTT5vYi+7/WZpfovngTMyaMxCKdprA8agUp+ipf/JtxKybdvQNdypcI=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by MW4PR10MB5726.namprd10.prod.outlook.com (2603:10b6:303:18c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Wed, 16 Jul
 2025 13:59:30 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Wed, 16 Jul 2025
 13:59:30 +0000
Date: Wed, 16 Jul 2025 09:59:26 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Dishank Jogi <dishank.jogi@siqol.com>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] "fork: reorder function qualifiers for
 copy_clone_args_from_user"
Message-ID: <yh7uz62miutywngwevm433lhdanxm663eq7peyfegzmzteu5fy@3bnmwaafrzhm>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Dishank Jogi <dishank.jogi@siqol.com>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <20250716093525.449994-1-dishank.jogi@siqol.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716093525.449994-1-dishank.jogi@siqol.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0231.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::21) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|MW4PR10MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 46bd31ae-b477-4460-bd27-08ddc470fc43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wdEQI//hIUjfsEoEXSzFCeBeceQKmobCEBWLBxg4lCO++Yc5f3KseIXWxRXj?=
 =?us-ascii?Q?gZtbzeqK0zuOl2q4kz0ofNNmOa+SaRPm8o/haRweH9wj9052/uNAWNBkDwqH?=
 =?us-ascii?Q?0a21ftLCCzTQgeLW9t6assoaP9gj5226IoAClqyLcAZkTKVS5B+VC/tTPEOs?=
 =?us-ascii?Q?imn0Stx7o3M+KUdweGjtL8+BZmwX/bdLvOmDsOm2wi8j7A3WGg7uPe35uK4G?=
 =?us-ascii?Q?wj3QV5AjRyfcgFZcNMddeqbn6nJ6ZLO8Xwa66QlYJ3vF672hAJ9mUgcfPdV+?=
 =?us-ascii?Q?hZuFu7qP4Rw467MlAqlNsjc5FftlBkJpTxj3mVlYxlvQeBIGN7KnBz7w1Bdj?=
 =?us-ascii?Q?36ZuGv7rwI9/xX9elFXdL8a7UuKxt/Hq1ScbPwVqUmIpQe4zUortWJBFOrvA?=
 =?us-ascii?Q?CwXhA8lg+WilI5H0C2/sA25e2VJVH2By5eN0yzj4pCz2a/MxrlCCnBbQopyD?=
 =?us-ascii?Q?OJW26xWMPzJbZawrjmS7viBBccOHzcqhHThwRzhgupCdsLsN/mBZnKADofqR?=
 =?us-ascii?Q?xzTSYJsP6OHb05n0xtPzh0Q3Ku/PykbQmn9U91xL3uUVQwGDxpI5lMe+A18H?=
 =?us-ascii?Q?al2NLi2DiEE6tlKk9ug6y8lxY9RSV1GWP7aXEk3rOnS4DEVUkaNoirnSK1fn?=
 =?us-ascii?Q?HS4Yin1jFJG1ooaBJPkSkkrTGSLjmF8ofRk4vInIQgrGhstL+q6ccTo4IfhG?=
 =?us-ascii?Q?8+z0IR9GSApzKg163DA4TNSOQGu45zw0g+D4lq25/Sg9WuPnFQn0R48i9T/3?=
 =?us-ascii?Q?igZT/5qEMukdPTfXIwefMgBuaPdx8sLUj/TwQESENq2xIbU0AcSiAFzfz5sl?=
 =?us-ascii?Q?5XKHaemKucin6sQp2Ztdoi/5AJomZUku0/b7p8j3BF+pUrTopQfyuGpkbJuo?=
 =?us-ascii?Q?Sd4GS1/u9QPNxk0DCTAH1IL/8QfgI5Juz2a7HMYU52iPbgNy+7k+ADvU1xEh?=
 =?us-ascii?Q?bm8uPg6sSo/pvH82CBCtxIwrShrGdnWKajVRiklOUGxaYNDWri5nWI+07kTe?=
 =?us-ascii?Q?+eAjfTWDqsGRnvOFD8xc6yDeo8XYgjclKuDQ3ox6OQm6eVuMAf+L6WagTAAi?=
 =?us-ascii?Q?XjiBHpVNahEnLTBM5qQdbBubD2SBFhE75GQK+vHT0QhVxIXmKbflyNAuqp8i?=
 =?us-ascii?Q?F6N6iMjEaae7XJnFZlHaNnyTOSWRkkIqclSGmI4O07+UdGJCX4ymw8InT4/M?=
 =?us-ascii?Q?uIJW6CqvzxdDsDm7u6T//SjVmeKcw9AKacpPW3ErAo2xkhR8jazUCadShzQ3?=
 =?us-ascii?Q?kRyOP+iLKOa9i51jQfXPfrewY4HiE3pRti07+zxZdbFoa7ckXQeS/B3tl5Cb?=
 =?us-ascii?Q?3A021pR2hClGUTZ3/xIjpLAMhJrZr3NuTo047wam3+e4DoHsTuIzjh9byLXC?=
 =?us-ascii?Q?p5iMdbKiC40KWqyub7zQ0oKzRmBSz1q8Go3ziKRzyhcnXgXMks8QeWJkNXlB?=
 =?us-ascii?Q?Bbr78si82uY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ORQgqFwK1gftNpM/VxJx1VouoXkys/wFAKXBBYuaXritoJP+O83dWKEfciH5?=
 =?us-ascii?Q?KCA5gSMhcmbE886Au7K296u7dpJHZNCMxlaPXvKsKZ9kL8UrAzrq5mSKJpOg?=
 =?us-ascii?Q?z6bC5mhsUA9ZnTe3Ypozivi6pMPHu3tVtpvpwiN+8vvQ0wI7Z6TR2X4qUL4E?=
 =?us-ascii?Q?3lyTJ2QORjQ6ds28M80Js6U1tznYLOfpw9VvC/R76xuFshVS8j7lnMeSerAG?=
 =?us-ascii?Q?61pqid0zK3Zca7BcukabHdl2aALITNrERSDUIJhV+Av8c0ZepBrE1IX1wOS0?=
 =?us-ascii?Q?98ce+GalQDeUc/G28zC5N4VBae9C/89ZkABAMR/4ctx36HxxzvV/FwknM7Bt?=
 =?us-ascii?Q?d+EzpRfRG9kE7i084HED3s4qBbDEyXJJhtYLZq9RL0UIw6MpkLutzex6FUYI?=
 =?us-ascii?Q?/4BeH2xBxOeetdI9gjR5rT+tB7QRt4d4xPxiK9c2QbSAm36JPbLR3B5K0uWU?=
 =?us-ascii?Q?4SjdobqzJ/UVLZBaL05FudnSACfZ+udzEA7LAShjIDCwGCi2AZRoNuP2vDUI?=
 =?us-ascii?Q?PIkwZEpu1P0Rd33f542CkUa483UO1ShkUxKpAMYbXdG8M5+o9N0WOBazVC1n?=
 =?us-ascii?Q?CT+yayt4lVmWO6eze1pWnAEw7faoHXq7Me9Q0dbRi7UbX/CUovPb0l7WqCdR?=
 =?us-ascii?Q?wxzDp+r9qOAkWDdCsHrl52VPszC6eqMGBgjCTj+wjO6/zlD3oAGuDEeXifIK?=
 =?us-ascii?Q?6ZAMSnwU8rmivhNyj79OvXIed9WbE8BUF0bbhZWY5VKjNOQlFX68q7ScXSNC?=
 =?us-ascii?Q?Rh+z9WrB6tsNPpBGYOU/vy5ulNYhGuUVFgkSNHiKw1ITHSGoWrirkchOyJ/4?=
 =?us-ascii?Q?kuT7gfh4m4d51fgR6wQtFw6DtH592vrs27n/Qy9illDmIvKadEIsV+2b3p25?=
 =?us-ascii?Q?46jF3V9yQvoLcgyD0mWbbj9urUO95ZqgOQiQBod+jSowhV1HnUr7VnJqBVyl?=
 =?us-ascii?Q?XKjH8H+eWXtdA7U8nszzVcLJymxR1eK8TRNHVjhXkfQMziiULVY9JlSLugiG?=
 =?us-ascii?Q?5Fp9gzt/0xduTKRXJ3XRfMqEayY5APTEK3zAQSDOlZpwpowXvy6vCIG6Z8fj?=
 =?us-ascii?Q?YuCZGnX4iaoc/uY/7UECNVsu/Fd/0w5mMeWZh8EfZ+2pGFAVGm6sOPOX235f?=
 =?us-ascii?Q?/+dwwiLqzCRx76jKLZqqUwt1c2UA0WT/VUodtZBt2Y0FeAIKSBPvgwpPAFFd?=
 =?us-ascii?Q?go0LfACsPKDrot4CjanoeE7lmiajUD+9aiNw8Zpa0wiKjs4b5UEGSRdWMHdf?=
 =?us-ascii?Q?HeMk+KP50yNM2sy0LEsEnql9XALtdf7l/M5icAz4lACA0dP34KzSceHqGHoj?=
 =?us-ascii?Q?/10i9rrxeWgWaLgD0y70ONdQaVz/c+Tw6dBY/+gvhyj2Op47tZYr/J2RL5E8?=
 =?us-ascii?Q?aEeMgrJVFzR1H6NxlP6YX1h8rZU1WhvcsumhgggosoyJ6bJ2J+59BK/3SdDA?=
 =?us-ascii?Q?7aNuW/Ah1MCDRCmSRWt68W65h6eJZNRwTKKUu/lnONkpma6AHPv/47w5jSSd?=
 =?us-ascii?Q?b+ml5QI8/HuRCJNIvEbPs6M+W3ZUEQrIEBpq4Hco8QdkJA0adtjGdbtKoyYd?=
 =?us-ascii?Q?tcQJO+8j5iNSRV/uAjQoeNWDKC6lB8u4TYX15+MD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N6wyO6icyx6J6FbagMy4jZxKBNczJ5gJKp36yKuhZWXrFmZOBAoycqKQRwAXSsoX/HtZGpCtHNfB87axkWHUPUphKG3AsMY9O94ZvRVRHLRyZ4lm627J4yfbS8vhEkprYcKOnOMORrBqEYd5Ybo5GWAKN60GySFDFpVC3lwgkN2SbddMbngtyqR1rIbA+dnih3L+zA5/wq198W4E77XMjPlAwtU3kAMQgegd8Tu1kbN2MLuyGUzI8Rv/d9av0AVJrbyTZsjADSRii8+B6BZL6eHo2PgpmJzM9H8n8NKExf0uYyrJoyUZ2GQD8coHsaSLwHjdJZfbhl2CBPEpm6+uEmtrVz/c9g30zPiPLkMlDH6aXRZOX2+VvWmt+PT+c4gz4gMlLxnqsXy+oeUR1WHiGrkRahqCfjMBH+ILxLoIzrxsXxNLQonaPs6YIGFx2uXX3Ssn7oGn+Jje9c4NTz1kQ9LuE3YEf8mu/W+pkSyTDzwG41WLpZR/ODKRGiN8/CrVJUPaOTLgNU3Ljn3ZMKe3bIqc+ROOwgO4eIacCesZeOs1CONx8i30UXweTutj1pHJevezXHx4U9Q9+we3oOgVmOGIxeZvGt3c0N59mJBcS+U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46bd31ae-b477-4460-bd27-08ddc470fc43
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 13:59:30.5485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ol5HIPij46JXGuOoFBFwvbMB9n7AAFupttLTCtt2jphJhDEodGXZHbtncfB3ienpDENmuVJTpk6GKX8qrlELSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5726
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=787 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160126
X-Proofpoint-GUID: RnK7ZMXvpWYoU4PA-phAZlMzSt0dsf7m
X-Proofpoint-ORIG-GUID: RnK7ZMXvpWYoU4PA-phAZlMzSt0dsf7m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEyNSBTYWx0ZWRfXxDjQkS4MUyTu QvrQB1VX7IS2vteUu24xUxZldrJ7110V/eiC8kxYu4AMvcjrVRybXS2McyYnStDdWvsuFlnWwOS jLw3VzcExkSVrmHLVNpQbHkkTBDiquFwb+rHYjHnygv/HM8BT57HZFMY7ZqA/EJhvf409LHh9Yz
 tOA0qnHqMcv6UIqY3t8e3xnGCcv4QsVYiJptHmlGdf+jEzqse9I4vrKIGnOExGR7xCsEHeuZGkz cmvbiYZ0l17JtC+RnGbEIRkyOAS0Wi6rKPb6hO2vrJp+UdISaU18eEKjP5nVXbO2dt8Q0X1rUka H+Gp9kVGZAil0f+dGM7G7+yLdHazETm1LwJ5xZ2F0b4CvwGcvKb0x0/upkiwqGkw54EKSi8oxr/
 p16VjXhz4YIeginbXauenN6OyWNK/5RmxPf0aKbX4pgwwCXRVZObMyIfLT+X2EWq4vqXqelr
X-Authority-Analysis: v=2.4 cv=U9ySDfru c=1 sm=1 tr=0 ts=6877b048 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Dk1iwPu2AAAA:8 a=yPCof4ZbAAAA:8 a=TnKu_QuseefpN43wDJEA:9 a=CjuIK1q_8ugA:10 a=i7bt6S_etotbxtfMFQE0:22

* Dishank Jogi <dishank.jogi@siqol.com> [250716 05:35]:
> Change the order of function qualifiers from 'noinline static' to 'static noinline'
> in copy_clone_args_from_user for consistency with kernel coding style.
> 
> This is a non-functional change intended to improve readability and maintain
> consistent ordering of qualifiers across the codebase.
> 
> Signed-off-by: Dishank Jogi <dishank.jogi@siqol.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  kernel/fork.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 1ee8eb11f38b..574ff0d983db 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2743,7 +2743,7 @@ SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
>  }
>  #endif
>  
> -noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
> +static noinline int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>  					      struct clone_args __user *uargs,
>  					      size_t usize)
>  {
> -- 
> 2.25.1
> 

