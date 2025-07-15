Return-Path: <linux-kernel+bounces-731577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2060B056B7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415C75644B8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FC02D77FF;
	Tue, 15 Jul 2025 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y8YCkbM6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S0yhQCb5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2239C34545
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572146; cv=fail; b=bWf/xM4x1lRRu7nOXxzEtn5Spy+7cQO6/n7i6RCdNFgEX6wtGfTmen0DxY/ze6ottrQrpDZayVFUPX7HTxJtsIrWrGswdHJDkYpE0X1Wu1TbeTyfKKlkgB3OuhenPqUf5c9OEAbMbv29kGV5x65wARfMi7GV0+ZQeX722B4sp60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572146; c=relaxed/simple;
	bh=zsFH0ana2fToD0ylwjrleSn4yoeIkc+NkSjG5TVCSBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AKEaMIPJVoLLrBxFTLa9dB20v0/2nKQo6fjMKgsYLUw4PqrvSfgoISHT95Ywn3inr33p9AIQqOhhtKPXmNgqdZlyilIAS8D31UbHiKR2jmi/ld8Mj9/1q3UvUigJXsERoM7v51FaCpnHpa54G/DI7Mxf9AXpBwsIaGUpNaQX6yE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y8YCkbM6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S0yhQCb5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F9Zc21021750;
	Tue, 15 Jul 2025 09:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=i3PLT5dq8OjAmArfnC
	iz+30t7QC6iPQBrmPLCh6Wpgo=; b=Y8YCkbM6dwUIfphTQxg/ITuEOH/rUKdx7O
	g3Ry9joCM4fGpuLY+kHQb6pg+vV6Wt2ArrTrFP0DD3mkHd+sEkfT6AdsFOCQ6E76
	lcfq/AVi9TmjAmkTy/HhWXdPbUBlWP1TCDImJPChh4fV15TEuCiwbfbWmsWYAmiJ
	CY98qF+VTdi4HPxkKiPEh5AKSgDwnEY0CLrDgWmwvfPgLM1+6ebVMm2rRSJ2oTyV
	CpIVrF57tKRahHEWKEP2AcCJA6CfTWlkG/Wi3BXDsdpySx6hWJIsXmgPJDeKkdsM
	uUC2gvBHR7uqP2hD43gQlRzSJul/ZhVUvKk1kc89LK4NtAyI4/gg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjf6qfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 09:35:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56F8G2ND023939;
	Tue, 15 Jul 2025 09:35:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59qtba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 09:35:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/qULiGu3PDkmQ/lNB3yUEX0HscqKMXUU0LfgcdnJZkmfwI4CKQ4uSN3YFmh3ZH74Oq51XZRPtGK24t29J9RDgYvYSrglp5ONgvycB8dMSldny9g6BwsT2w66WFbLXrvEz0wqRO+0DeCUGuThRSHxUQBySWr9YdVoxnwf8iKUKGFi3lLELzFCTEEVNxKkgBvKbnHTYLZog9NzJKPN01YsMNEfy2kmxj2JrxKT/tE6qcn61VoXFNcz/zwbT24lN4puU0vqnZ0E4ACq1oUs/WwY8+y7QBjLgEck7riX2P9hmzrvMH2UloYpSC0ZZymDXYLshQElxEfR7PcE5mGmnHkuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3PLT5dq8OjAmArfnCiz+30t7QC6iPQBrmPLCh6Wpgo=;
 b=xwSp1ITtQoyTqEYRtI6qTnQ005+kZzm0D64AdfanISkdbAm507MY0+C/CyxW51rpIFaBrJWLVgw3SZ5FZYVt73oyGZfvHdqodc5TZ847hd8rfkA7YR7i29o0KjbQ5EYDXCJJ9RtZM9h5+hMdYkL/TV/02nM9tSWbsU4k/8apOC2SKKK+GNXOnjllf3jGjFO9wYOQZYM9zxLIfdKpxroVERispl5MDCMsPZxf+BcrTVAWwdOHE5my+iIi4MUOeIGJsv9CI7pUL6RgKGlDybLPV9iwI5j/3MhgN0lI+Xu++zolz+n7OIz3IKeM9cFQ6gsINiLp6cr2K0mrFxnRX1HJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3PLT5dq8OjAmArfnCiz+30t7QC6iPQBrmPLCh6Wpgo=;
 b=S0yhQCb5ACAh9QvpW57YLRrqcj1wCp1ZxvV5ABz5dgMPmPLJrlds2LrgDFWaXuYXJeLgn8OLlIm5O7l+3Teo953x0L/+ola2IZd7OsD1cMuK3W9DiABC1AkvdVlZBBjEJme4m048bTssyMbwhbF0K1ikCbjQANuvY1WBYtayRlk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB6440.namprd10.prod.outlook.com (2603:10b6:303:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 09:35:34 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 09:35:34 +0000
Date: Tue, 15 Jul 2025 10:35:32 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+159a3ef1894076a6a6e9@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] possible deadlock in lock_next_vma
Message-ID: <9634800d-6585-44c8-aa26-79055ee5c912@lucifer.local>
References: <68753289.a70a0220.18f9d4.0003.GAE@google.com>
 <20250715012717.4112-1-hdanton@sina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715012717.4112-1-hdanton@sina.com>
X-ClientProxiedBy: LO6P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e621d7-aa22-4d05-b0b3-08ddc382f2e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?esCCno/XRRlVbFpWJ9L77xtPdEFGrKdHWqb0oJDCrdDn3TqDUHAW1Qbm1u7p?=
 =?us-ascii?Q?bGILG8CVICRTnUpYOfNpcJGLp1fL2uZkRrpWR/5IySR14g8/cpERGkSZn5VX?=
 =?us-ascii?Q?zMNPtMdZK1azzMiurWykuyJsshyZ+gvP4lG5UED3Gl1CEAzSS54pIsBozkhH?=
 =?us-ascii?Q?8TIHviaFm8QYV7fAWPbNPmA+mTqiot054ZOhrja/NDojsPRm3V1RyxPAHmZq?=
 =?us-ascii?Q?sXVhqD8bMGG20KuyiUE0nQDPTnmfO/mBtup3SZekrj9hSXk8reWEt3xDR7V2?=
 =?us-ascii?Q?Qz91aSkda806I5mmVuNG/QLdXyyHjq3raqtAZrL0LsKylJfuBew1b2IfoWR5?=
 =?us-ascii?Q?F8cZ8ALY5a3u3Z+GyQaL+s/foKqjPlIDmXRpVhyf7TATbe5ohevdUwifMeuG?=
 =?us-ascii?Q?mTVeKc1lGeoY6kB9UE4xROjRkzO+R6Hp6uMIk64ljnRqLQildZ4Rt9Wvfykb?=
 =?us-ascii?Q?CxyLnANlQYmNAH1UfHo+GPIyq4IBcKGLFTMU5kBO+SaRcEGJxBaNHtSDHLIF?=
 =?us-ascii?Q?dWeRdVkchD1icbbAyS/d1bvBeITVhUz4OGA8ZaJvl5usxnDgESjmidp0er6G?=
 =?us-ascii?Q?rkzcTQMyBFIT6N6v5ok99kI8OODC9VXmgdQg9Quadgrsr8XmuU+cSW+v9//2?=
 =?us-ascii?Q?GBdMSdZeqp4Ren0HLLWgtipzkfs2F0UUzYSiK5Iz9j4xhxt/hWDwbKndD+f2?=
 =?us-ascii?Q?RLxVIOBqpvTmA2NdC9ts95C2PUpLtffrStz+Vefj3D+ScXFm+g9KAwlWik3m?=
 =?us-ascii?Q?7qK/HmwCEIU6+jumt9NDGnr276sJKd5po9DyDpem7yIbD8IRrEFgZ+snqkDV?=
 =?us-ascii?Q?gdqQmAye02qKT9uCGlAwE0E5xrSN2gPM7m1M56YUpNG5+GzH2Z7i28k8LPbF?=
 =?us-ascii?Q?q9RSwRMG0jx92uoz3ovdoYcGI1KmrpXZNshHFHdE0JayJlyN3fJb6s8xPJy0?=
 =?us-ascii?Q?MOhCrST2kjzVKmCeq9Mi43LY+IM+Wo/JhWgtJqaMJq3CErSUa4JoJ8T2aKM6?=
 =?us-ascii?Q?qafkb6K6HlHr7VJNRvTXR4m2mTK4X5l+rVmHmUtu3mNVyVoJbfaG/c6vd80B?=
 =?us-ascii?Q?3JMqyn3MzJqVQl27zzV9VxopVqCdaVJCmKFT8F3NOsDqQB3frLTns18/czTS?=
 =?us-ascii?Q?k/vH4Zo5RByueIQLCv0Oeqqj4Jru+Au8UxCaFTYvVMXzn6bv5+shz2Zm0qc/?=
 =?us-ascii?Q?uS4rloY7IUuo9ArrscGZld9k1PRp/jvxXpNCiA2/CdKtJMB8HqWrd5kJLakP?=
 =?us-ascii?Q?YD1lblfcXxYU9ItwFocG7AWR4i+LU6/sRsjsVr2m4+K5SLMtD4+o4guRHoWK?=
 =?us-ascii?Q?HgkYzJevu/63lmZHTebdApW61kidgLf8SWUfLJ+rIwJ3lMJlQRbV5Ga9kSjY?=
 =?us-ascii?Q?vLn8smAcPYUR/gudAjONArmTBp0M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C8nNTRVFUb89Yx47/oftDSChd1CgfYJ9LcwpBoPU89LeDAHDzMVGFZmNbEpj?=
 =?us-ascii?Q?9Pkt71jpH01aUkGeEayIm+OdPxFWdiS8BI/GVg1b6pSRmwrIkZE5yP37dkBe?=
 =?us-ascii?Q?7HZWOh08c7RyTw2WjIOKNMtyBB7Uz8FQow3CTGCmjylAo0L32keucMQ6yTU+?=
 =?us-ascii?Q?YHJbqjqzPyyxp9P8BKAeNqaP8PYGzv2e38ovXve/lmEm/v+2qBkvag2x5SGl?=
 =?us-ascii?Q?4Gr0VZ/Ju6Yy/zNR5n5/HVPpnWcnTOIz8cNqASljji2hJLA/doAas9r6v7fN?=
 =?us-ascii?Q?7JB2B8ybnD5bh0ixcfZC3oEsZwBsVV9AbVIa9aTvahg1nisKT8LoYmRtP5nM?=
 =?us-ascii?Q?AjUKDpRJHLR85SZSSxwAdOsXFnZ3ZXWVBHM7HxTIojnmBXPk0FnHLvEG7dDa?=
 =?us-ascii?Q?xDJp2cwXqsz5vjeG44wtRExG3sNSSRlf+dSXNS9f9E78tkfa+jlMI0BUlGJs?=
 =?us-ascii?Q?r5tvZYS+uQw2BodPG/TINgY4zyumxdX+pjKeZEtRRmsJuUNxL/YWwMgJtJHG?=
 =?us-ascii?Q?U8GU1a/htuc4OtDFL+7/+RUBDQo/scRI7JDuimMPWZKyqbJ2MmhRA+ZPKWf1?=
 =?us-ascii?Q?gKd8/rHnUqnIosT3L0tOr9JqteRFyxyTF3pPI8MUe9cljRPsvUIyodB9Hq7i?=
 =?us-ascii?Q?vxsCjUnLeM7bDM2O8cpoetbzhc5ZSrUH/9sHg5owp9LsRq0cB1ImyZv9vq31?=
 =?us-ascii?Q?0Zs0sA2nLjZJfq/QRridigJOk3/abvT6b0rBi4C94arkOX3/GutzwbaOqbDq?=
 =?us-ascii?Q?A+bSOtxEaM8nQWUvaPJMLudEPrqmF9B7RytQUQ3F2P0sRR5EDT6k9dQCh8hq?=
 =?us-ascii?Q?RPhJbkKuMlW0Xi4Tlpij0Q+kngHGQvpo6Opa+19LTF8xDdUEf0UF8GHvi4AT?=
 =?us-ascii?Q?FddQ5CVqdz8YKQnv+RUSYhM3vnoHlIc4hi8OWHNEGL5bDKW1QYal8APYfuHp?=
 =?us-ascii?Q?nkLPw3YG3gUYm91yLpUJznAWbUwYyJ3vzLuUfhlvohwaS0iJsHqqjgNuVcj/?=
 =?us-ascii?Q?1mkJYljdIVCClksRwoG8SExcWRh5joX0LylTaiWKeJJRvjoPe9lqz4LckTLD?=
 =?us-ascii?Q?gvx0ZVthYHJl7NZJCI8m2YZT8d6eJcMKozeD26vGPnUWZOQTABNHr5gYeOGG?=
 =?us-ascii?Q?A9huz50dbOi7n5ItuQ2tGA0nCWgrElvZRf/T8AQBuxdVhHhXa5wwHc12dWst?=
 =?us-ascii?Q?atGgcr+kWiCfVj5yKpCWvm1Uiw8RG6Z+kNM6UuFGT/3LklRiYqVa5+JGrFVv?=
 =?us-ascii?Q?VJE4NNYkTcE9x8rN4PVT08IMcnMFUdD99hU8CtoMwXT92L0F8siah8ZeNW/A?=
 =?us-ascii?Q?Gb2V52XrZQKPG/9bRk0gOyStAeb9TNUXCNhWEoqcQUAbSCJf6CHEOpNKSBbD?=
 =?us-ascii?Q?OMVLpK912Ti72znK1ctJO1E1CwLYoOxCwiqOTJE/Ppq0+LZ+umo+mkZ1r9pR?=
 =?us-ascii?Q?yGTzjM288jvsvzia958K95KLMMCLs1t35S4Ku1Vef5u9Wak5OJfm6TwRNjJd?=
 =?us-ascii?Q?UiyfU5VHO6Q0db5y2hZqHASFTnL0oafw/IAUCzapZKPbRGAT0SknYwY+V7vW?=
 =?us-ascii?Q?I32DkmpyavnZt6achupWE0PL6XzCNWLf7aVXUCpmnGEBZf617nBOlpuqMyj3?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NBlaMlct3nwKd6xfDsInU9bs61GwOXwrG65f1LgPPRb1CuRn/3wVloVTQkAIom94ESKbL9+okdjQpHQejjET0CM/RHwJPywozXqu6pni30sFUPep+xRtHLKC34zDmpcUuEJG/eZl24FNQCczHXAIvxY9D3waL6zizeQb3yF3Tmc06BVZQOlfKtaBVednxp3GDHzMiRSXSvC3yGfaQx88OELfcpCWGwsVVczWbmCKdCNUiA0Ba+PfOr3+KcMqXQBWWN/lP+bM8DLm0vLRIoqMxBafwQFUCFiL796pWqvMkdUMWgr2wZNiNdtuvZVwQJ5m11MUWZ8b3tFMeSnnzzesjrQlsBKxhpPudR4/dXyLipsw5QNi4EaX10gvdKi1jfknAlAeN86ywnLY4N675G2BXJ1rl8f5wBbB2sEUcdqftx/C7E5uSDKWmcNxvgw0okPxKpjTJQE+6VGxdVAluW8CcaAQRsWBBkKKdK8Mj1fUwmNnXqtAmeP2Lkj/BHhk+aGcic1SwQRKr5AJ9b94uzVxRdLfdIhRg+PJqpq2qxVy12rkNA5nlOwAChm+58oFhz5oGhY9mKt/d/yWxmDNl/WCRhYy/m1zyosO25NAYf6pBhs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e621d7-aa22-4d05-b0b3-08ddc382f2e8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:35:34.5574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SY/btaTSFXSu8SVbjD6fUhcfiScA809BECuNWLw6lpAgpHVRnAqPl2v028D23f4thNHzMkpq2QVNxyZmjrhEdMNrB61ZKweTpcTN79vENp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6440
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150086
X-Proofpoint-GUID: NllSfWcSxQ-Ax7WqRhYO5tpmaw10T2aQ
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=687620ea b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=edf1wS77AAAA:8 a=5mAx9-55kBnUOBWMUjEA:9 a=CjuIK1q_8ugA:10 a=DcSpbTIhAlouE1Uv7lRv:22
X-Proofpoint-ORIG-GUID: NllSfWcSxQ-Ax7WqRhYO5tpmaw10T2aQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NiBTYWx0ZWRfX8tpJiADvBQFq o9OkdCdSz681Wu+v/PXIPVbMcIlgm7/fRyEQPFMcWp9Rbxd8ftfZ9bru4E4JuD/vUciv+fR0YSU zBCFhsgkQTwr1fmLUNHSsuG+rf37aoqElRvowlpYyQeOvAR+7xZWIJdxF3s+D105RVacl8E7LRF
 e9n3ygKFmQy5/J7DuMNmqtwW2I+BWSEGtCCcHaSv/paowQ9G7L8KvJgPhcPmqChx9qNUcyiQ+Uk ZR0dZq08RycMO9OuQz01/foZqJrtOVC9lrM4tz0f+AbNB5lnhxOrG/0tCJ2bsxySeZCjDm+0tun AG78ZgRTUX/MaHl6x/486X+MWCGnqH3Qn/xB9Rg4AMhP4B5e/g/8XXGWaunP47JPucYEOd+gxn5
 m7XVPhp2gSRL2eblcdvQ5m0OWiwoipGmA7yH5TsDNRDtQHenDAr+NHVlHlq9/eEuMR/XHX5n

Yup, aligns with my analysis, thanks!

I think it's just a case of parallel ioctl's not being taken into account
here.

On Tue, Jul 15, 2025 at 09:27:16AM +0800, Hillf Danton wrote:
> > Date: Mon, 14 Jul 2025 09:38:33 -0700	[thread overview]
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    0be23810e32e Add linux-next specific files for 20250714
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15cfb0f0580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=be9e2082003f81ff
> > dashboard link: https://syzkaller.appspot.com/bug?extid=159a3ef1894076a6a6e9
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1003b18c580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11437d82580000
>
> #syz test
>
> --- x/fs/proc/task_mmu.c
> +++ y/fs/proc/task_mmu.c
> @@ -585,6 +585,7 @@ no_vma:
>  	return ERR_PTR(-ENOENT);
>  }
>
> +static DEFINE_MUTEX(query_mutex);
>  static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
>  {
>  	struct procmap_query karg;
> @@ -620,8 +621,10 @@ static int do_procmap_query(struct proc_
>  	if (!mm || !mmget_not_zero(mm))
>  		return -ESRCH;
>
> +	mutex_lock(&query_mutex);
>  	err = query_vma_setup(priv);
>  	if (err) {
> +		mutex_unlock(&query_mutex);
>  		mmput(mm);
>  		return err;
>  	}
> @@ -712,6 +715,7 @@ static int do_procmap_query(struct proc_
>
>  	/* unlock vma or mmap_lock, and put mm_struct before copying data to user */
>  	query_vma_teardown(priv);
> +	mutex_unlock(&query_mutex);
>  	mmput(mm);
>
>  	if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_name_addr),
> @@ -732,6 +736,7 @@ static int do_procmap_query(struct proc_
>
>  out:
>  	query_vma_teardown(priv);
> +	mutex_unlock(&query_mutex);
>  	mmput(mm);
>  	kfree(name_buf);
>  	return err;
> --

