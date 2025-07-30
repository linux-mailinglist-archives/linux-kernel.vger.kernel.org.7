Return-Path: <linux-kernel+bounces-751129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B192B1658F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD5A5672C8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1792E03FA;
	Wed, 30 Jul 2025 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T5T/uu+h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g8PJrO1z"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C70A2D838B;
	Wed, 30 Jul 2025 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896833; cv=fail; b=BC5kYtm5wj8sptCdxlsWhnZUUDnFdv5fobOhNVqdAU5uw9yh+BgpW3xqd85mpZ1MLECBzh55WeQIxvA8n7OuUpB1ykLSDQUJQn25rvZZSTt5x3s25LvUpsPjzTGppP86RAcTiOFZXnyFFMqGK66Wq+ydY6TKr7WFhsInDShn1UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896833; c=relaxed/simple;
	bh=1bgwbqLmyM6maNAa8KDSCbfwAt1cmfwtMNBlfnEGUX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B2g2VZVDhhrfYAAc0cSzE+YUeBKdemsZ5zoornJrtRIEgwjnp2NWjgn8cxvDTjJZsaYb/TpsPQRaSEVZOvaFPXNthPt3ApRu4JleboccA2l8IkL/zGvn6/U0TW80P0ik6ZCKSwDguiDadUGYxON/G8PTK0V4Bv1B28aN/zgZe/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T5T/uu+h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g8PJrO1z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UHNQqs009253;
	Wed, 30 Jul 2025 17:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=mj0XS5PjRLP52KIkd7
	AKJB4Gyl/VQqZwky7rADK96xE=; b=T5T/uu+hnOhat0GdOI2+UrxvwbJcRkjsAr
	FskJj9CgjRRKZy+DxnpBG3ABAUilGz69g7RVlAcheYZV9vsxNXQg7BJ9Tilb+Di7
	LPTpUNMoA3JkuSAuFbgyNpKnmf1vYaTva05ucUXT2ZnaciWLYnYpEiC50B47MaK3
	jhWVibPYWaDgk3q/yNSs3cwegXV1OXdfIm3y109ULIW5B4VwtK59UcNO8k5TIwd+
	05DAQc5b6GDjwwcExDdlgQetwzQQ+5Ber2eRD6I8xMBeDDyVtNMoEl2x4jsz31Mp
	6ZSE6xUeONddqhAbznPKUA1BKMGlPb2Qq581catOUpityRXvyLgw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q5x2a3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 17:33:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56UHPvvM034427;
	Wed, 30 Jul 2025 17:33:39 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfbqh92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 17:33:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gef5z0nOz78/9QquTA5dqOmD+OKXfFD4JWtfhG5DimlAiPL0978sFjFMTS/jHHWkn045e8YlU0ssqUCJ9LvRdbFqQOGLj1xYO4Cd4l8yJyZ4PBiCMuOKdzzHDkJUFnF1YxndWbPB4kcy0uxftqeOnOZsXIqCvHQJolS5OwJeVQcYeYWDumFqIZDAS4FFv8nAjdAsU9uTFH61vAMv0jkPhhHVb4WLMQxHtgFGPEBQ0o9nY7agUVioW1Z6k0PflH62IzrJePKHoeZ6IlqgzJD5B0IbCrI9VJuJQocSr6YRxsH1srwVZs9l+20HxBIu8cr8QYzoLCJGadTX6E6v9bJr9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mj0XS5PjRLP52KIkd7AKJB4Gyl/VQqZwky7rADK96xE=;
 b=uLN6zs83nOiF5WW3cjfiaZZySKZEmvAlwuNQb1DdMhlJHXdvJzmBByzWZHOIx2zT+fnDGqa1nFWPYY3nZtL8Neq1u+CrphA1rF58WlQac/LOgG96KCZfRVxLi8r3SIK/MQai927iGULsJEVVu6OzpNbW3fy7+sFhjTSNl3s8olK2GFyuPdEFAVKhJQuQlrGa626Zz/7VyEZVqzhE0bWtPuVZgV9n4HBSTgAQ1pRCL54RFaUD3csZ4WWksKpobmpQm6cimyCOmBmOFctFYBpNgzr3MeNWGMjp+oKhuWSbYe+STgMl9njLGGLDD1skx1c994ooK1/+/Cusf3MIRCDzyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj0XS5PjRLP52KIkd7AKJB4Gyl/VQqZwky7rADK96xE=;
 b=g8PJrO1zsrhfrYCbhMkoQI7WaprpxHF6Mb+Gf78w+qXox1qaJFRya4HgAjUP4zedu5GiT8O8bZogm8u8r38m6UyrndNS62oRqQMb8FH+9NiJpAvXSWRdw6aUVLiY5DyrCKoBHymhFG8uxYQfMj4h4ih3LZ65XFtS3YHeNBwLKxM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH3PPFDB806AEDB.namprd10.prod.outlook.com (2603:10b6:518:1::7cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Wed, 30 Jul
 2025 17:33:36 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 17:33:36 +0000
Date: Wed, 30 Jul 2025 18:33:33 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>, Greg KH <greg@kroah.com>,
        Sasha Levin <sashal@kernel.org>, corbet@lwn.net,
        linux-doc@vger.kernel.org, workflows@vger.kernel.org,
        josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <b13949aa-a845-4935-b9f6-0cefaf31e12b@lucifer.local>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
 <2025072854-earthen-velcro-8b32@gregkh>
 <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <20250730112753.17f5af13@gandalf.local.home>
 <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
 <20250730121829.0c89228d@gandalf.local.home>
 <aIpLB5oMc1tSq1SP@gallifrey>
 <46973236-a53d-4d1c-912c-1e3dc08e4160@lucifer.local>
 <20250730132054.1e710372@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730132054.1e710372@gandalf.local.home>
X-ClientProxiedBy: MM0P280CA0082.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH3PPFDB806AEDB:EE_
X-MS-Office365-Filtering-Correlation-Id: adcc23ae-c0a8-4198-2533-08ddcf8f3703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DdjLhutpwAxGyqIbJHHstXOvLHQ+7/Lni3PSm2E6jvQ5Dwgx/AjynMY0TFr1?=
 =?us-ascii?Q?VVrbibevwSx+vHdV0lPxq0DYIc5YutvQMDFnhlWMeSaRsAMOGNdvw9M7HBMd?=
 =?us-ascii?Q?97cYvZmBwqPl3bdzfH+t3mFkGQl3MGTJiCtN0EaE3ElMn11LkHELzfkf+gmD?=
 =?us-ascii?Q?08Atkle8FpjrZs3fTwK1rMSVfIU22+SNc7GrM7ACT7cODvjO6ZNfwxkd9k9t?=
 =?us-ascii?Q?rakDpIflWr86lethLxXFhEl6/R+pIHIxJuyV+TqkxWpvOWb/bPa3hLrTBI8p?=
 =?us-ascii?Q?M7rx/C1HK+rWapLP2urpfiXSC97KE3nPKZ8JzXN6At5leIalY9iOXROUIJ5k?=
 =?us-ascii?Q?PEGA++rEo764QwTdaEIsgcRWgqme2BsWBUqloVfnWpd4l/5jy9S1A9VL0IVT?=
 =?us-ascii?Q?Lv5R57/B/58BNn2C+FTvp/soPn5OkMPTT+PVHm1VnGVWImmidLMThh/VQSpF?=
 =?us-ascii?Q?JaeHxRfz0AD3QjfaxCmhq0XdUXEKUK9vNOaQe3LoDfyWo7ArHc4pmaHQn7gu?=
 =?us-ascii?Q?Llhx40Zfmlfz/y8YOL62mJ3/Bhz0CzIsPFLdXGuePCd9qrSph8UNqPnT6cpZ?=
 =?us-ascii?Q?Enp03NYlQG6HJz8aed6XO4jH89sk5uwjmgLzS3/IWKXqyoAFeVhrSn4F2gGM?=
 =?us-ascii?Q?ieETvniYrDrjVi83eP32vE1yizdv/Hk5NA+pWf0u7JprDLJxfuSMAR8ajay5?=
 =?us-ascii?Q?BshgugcOmU88QUWWkfgOlkRrYTvCWxcy71eudILssThLRB/YMLuuRu4/Xxz/?=
 =?us-ascii?Q?bwfhTdZ0e7M8T/OnhZAzG+KAihL0jYkT1A8TXAjvEPRtHPhNaWmL2CyRgjGu?=
 =?us-ascii?Q?GrUMfKM5ooMgNyQ9fgbMPfe7b/1uPgjkmO4l4wrXQI7LeMUTqbTZHuxycSV7?=
 =?us-ascii?Q?wbtxKjm01xjgCa0Ni65Mc64Y2FzR5CFgQLX2Jox0MDv72GaUn231/WBL9eul?=
 =?us-ascii?Q?xky7hFV2VXjsIKqfGzk4dTTgLqWCaciFCkoKDDYN404RVxOb3WMjwkpH1/Zd?=
 =?us-ascii?Q?I94KbbRSKGDE63b385LKkB2e5S37kSiN3dMZpzCwVMPyE6aolzKiZcaS1yUI?=
 =?us-ascii?Q?RTQ08mt4+abf3mIvkqHkzp+9DX4JMg2e1bx4vfwuIv/JqKDgKbjsjU07RuX7?=
 =?us-ascii?Q?xAbXd86S+jSDAn0g0vEQ1pun26SiONbgkJzh24O5uEj5l0sLx0UoVs0kMIE2?=
 =?us-ascii?Q?HL5Ignjt1C7W0TqzrL6NKJAy8kqQ3xqmPB5Jt83ogIubRcsYfhA0A8Nk1Bo4?=
 =?us-ascii?Q?ZXZGVHUVjIg7dg/6pyCCneti62n6UKQ77ckBMh6PPWXex7dB7afvt+IOle39?=
 =?us-ascii?Q?zbswitTORbk8/MgYtSXHUYFc4++n7RtQ/goUP/t9F4U9sWvblFewQVkS3fI6?=
 =?us-ascii?Q?Vk8ABxJh/56vNOxxevkq4LHYHW8Mom0j3Sq+yHP9vP5sMErzQNSUrt80qFGy?=
 =?us-ascii?Q?VnwTnWZ5cDc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c78DtOCwzkoT8IIaU1Uo4tTgrdiYCDo80Ge2N2FwoC2+7zOJJ/dIbKZneua+?=
 =?us-ascii?Q?7osaszA3tKg/O5cmFQNpzQlMqLjQkIT4ADJtouocmxikfN1vTwHmcec0HhWr?=
 =?us-ascii?Q?bPy7KgWY0NQTlYHgCM4KR7ucOQSbbTcVuOHvG1ArpH7MzZajwvcbvP5lyvaj?=
 =?us-ascii?Q?VMkv1g8M0RaSLs+PttNRNJM7ON90mJMEmi9nG+dtru3jJg5uWpernXR+IxbK?=
 =?us-ascii?Q?J6lzR5IU2GrzdAGctYB7jaKEf1epfLNRxyNoDf9tQIG/TDFgrd0A2q0gtmqC?=
 =?us-ascii?Q?PKuBbuDR7n/qM0+0I26g+Ai/i/EGSNKOK/TDhs0LsdYU5uFDz8fVR4xlHQXj?=
 =?us-ascii?Q?VDgT5CVmI9SR0a4GT2lbX9DaI7gtHRbEizam2r/3fmLx8PtX3ICCi/f6lC+f?=
 =?us-ascii?Q?+1o4v2BrHAH6ZHxj8J+kDHxXnyvhcrvwpcSnUnCrw1msnzgqckYia5LEM4tV?=
 =?us-ascii?Q?YrmMxjxbquePz5flSN4kOHBmWJcpSWL7iibJIXDes5/njdqiWDFTsJq0TpBR?=
 =?us-ascii?Q?zeInuf7mnguI/ePrqk3sjQIq4kUd5gzkGGWOMOXw6H5+Ipn00nGhOqdej45r?=
 =?us-ascii?Q?mk0u3mEn1Tw5nYUajf9pG8B0L+wS+5L/Lr0sGFF4HOJ/jh/Kjv3srMaAX/dr?=
 =?us-ascii?Q?sYtu9xTtIXEDXaHC374+507BHScMQV4HI0IpK0picmd8bzhmCvc63ncN5Ik5?=
 =?us-ascii?Q?LoldDxRjjCMCvSaFG/wKL5Eb4ibwK3eybtE+JR7pw5rNK9EIg+y8jeAkfM2+?=
 =?us-ascii?Q?tnZh3RdSv9RzHzvourkIHpR3BUHNW6Zw5NTW3jr0qnAEd2qWnoHuJYYaeSIp?=
 =?us-ascii?Q?ohdUjJQIVouHZfV5UCig8oNZEn+d6yPHh/Ysz8rcD6zzWbhairIATNzTiMon?=
 =?us-ascii?Q?Zqcx6xC/bGXGcTUgGLSynrwEEGwQibSg9/9ZDDQ3k4jf9KgcXzfOsZD4DNwZ?=
 =?us-ascii?Q?xPp1JMnY0lXg1Un6mp6c2f6YK+y4K4VDXAuw2DJ5hEuYDB5cdnq8xeMwV4to?=
 =?us-ascii?Q?5qEWTVztBxJej4HQCHvkNsvsQ9XvCWsLZHXk0k3WPhldDg38iGNRrsWzXg8m?=
 =?us-ascii?Q?1+SiF6z+SrAhlyKXNEyzLTmON+NARpAyE+K9Cpzz1JGZ6jjjH85JfNb0/Dbx?=
 =?us-ascii?Q?sGBByfvhq8VdmhvQJubH5S7yiOA+vZpVXZbEsxCFNxKNkvUqgwcRnmx3dg+C?=
 =?us-ascii?Q?tZp+1BAaIlBeK3C8+JhfwKgrnemIZD/pyUBcshL6YhogGHgT7V0nmav5RY8z?=
 =?us-ascii?Q?Assxs/5sp/FqU3ocL9LTa1teaDgpVtQ9yq8tNy/L6o4Kd2WZ3TZLiT0AEV3O?=
 =?us-ascii?Q?0sGwYRqgeIIZI/YWzJlHtJGBhG25cnC4zGiq2XbujrvQINm7JTMmMvPte8/V?=
 =?us-ascii?Q?Q3ROwz5alnOlBE3mSDt/n+0gCyHNIavKw0XHtq5Eh+9g9xLrLXO2Pg0CXHz/?=
 =?us-ascii?Q?5pqdDWf4fm9Y+bhjzJ1DBfB/my+X7iOiD1iYS/6DGTW06xlJlFoUXFPqKfRo?=
 =?us-ascii?Q?cA1aBpsQZ37bCu7QuZwE/dxFizLTgKt5MtaDMDecbOpqS58nYaWbwsUbxbgy?=
 =?us-ascii?Q?8N+53847rA7eqZUfEEu04ucXzF1auHcg3EuUMZtbQY/R3wWUjx/YpkpEEj52?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D0pzDfb0RuFgrpxAioCnu2G6vxcneSnsvJeJsVqaAtg6k2W4xyw6b6poTcqwkQpdaCOzs+A9bxG9JAqVXbvBBIBQRrf6l7F0vxKKhq/S8o8WpT+beWs2cvfZUa3injsR5y6w3hSkBIzOQRdqB7ykUDbb1cRIOttA8d5DkvYRqdGbuwVdeSK5WjeFZbUZFyNnN3ilPrX6brvscpMfq5Z6DtETDhd3+ZNPqYlmxbMxiB26DkpVry5k3E3H8fvwu/xtP+zR5DdoYqpIAdcI+uKTf074cc2pcpwrWJp/YzhVmnjnh8seha1gjCILzN1mSyYRblADnj3IMd/ziw8RMMog8D9TqaA4iieHvU7SwQJBNoVLZAIYAV99Tn55YhIr1kWmHD16NcpValg+gQClzn2u83iH35yQDXIirm0kIDH0kgL7E05O7pQIkCrHH2D0a7tEzvYVZ3KIy8JIxuuFFpmKp1RtdVjt0g9O2aSgslqBHrSpd8ses8zS3R8ji1a5GfjNp3qAJmwGna9jQ0RwvmAYxcx125e87gbwUwZu/Rml6WQMpzDurakQSm8QJpOAXiVsc8nSwNZHBoSPvT2p/6hHzVNV2A+SxzV5U7PcKdwi9F4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adcc23ae-c0a8-4198-2533-08ddcf8f3703
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 17:33:36.7484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tr+TXd370AF7vLX23IwZ8maRaG4K/DA66LakDLNka86yjuSb0qxQCJnlPgl4TZZNtnZNQhWgyTz3acve3TCZaaGEkttONC8JBvxbxW/gybI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFDB806AEDB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_05,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507300128
X-Authority-Analysis: v=2.4 cv=X+lSKHTe c=1 sm=1 tr=0 ts=688a5774 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=ecXBDe8joHVeKG2hbdgA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: nIlN1Hc4mOUJyBhDk8ci8tupLQtlqs-W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDEyOCBTYWx0ZWRfX5GZqg+r42e3K
 3J1dNc4iCOzRRUPptdVcv/7F5CY8hIpJ2fUG++vPjCVp6VyqLzcSRQdhEhVdCacb3he0SfxuX8x
 ux1s4NsD5GuhyIMdXbYjCGTC1DgKx8PKK3dp0sCRV+l8obl5f5vDaXoSY4EE7el2xKXdPPL4Hil
 1p8N6FZqR820ULCdVOuQL0x5NrkRWApNNfXBdWemcfvKdWostOr00MwK842c6Jc6BS06IJnsW/Z
 0fBQ+U3xJde0wqyVPKiLblGK3FlCbiWfrmpPAiNtcea6WlKJFVIPQs12EpacodRNANc2blCusl3
 Udns/gb7hYkKqWlzoBSFUDgV91G5mdE2KiS34QS270yIMYmy+YnwJYJjYLv8QJokCLz7eypk/MB
 9z3SAFj/5rYyc1gAdmR0ZRJHO2wvvdiWFFqKeJQLeVBOAtJZgWsiCK6+9c5QYezsAq9ORXZR
X-Proofpoint-ORIG-GUID: nIlN1Hc4mOUJyBhDk8ci8tupLQtlqs-W

On Wed, Jul 30, 2025 at 01:20:54PM -0400, Steven Rostedt wrote:
> On Wed, 30 Jul 2025 18:10:51 +0100
> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
>
> > > > I guess a statement in submitting-patches.rst would suffice, or should it
> > > > be a separate standalone document?
> > >
> > > If it's separate I think it needs to have a link from submitting-patches.rst
> > > to get people to read it.
> >
> > Absolutely agree.
>
> Sorry for cropping your response about submitting patches, but honestly, I
> think it may get more visibility there than in a separate doc. That's
> because submitting-patches is one of the most popular documents kernel devs
> reference to people submitting patches!

No worries! :)

Yeah to be clear - I think this should be a link, very heavily highlighted. Or
we could summarise (using AI? Kidding ;) what the document states there, with a
link for details.

>
> Of course, adding a link as suggested above may fix that too.
>
> >
> > >
> > > To summarise some other things that came up between the threads:
> > >   a) I think there should be a standard syntax for stating it is
> > >      AI written; I'd suggested using a new tag, but others were
> > >      arguing on the side of reusing existing tags, which seems OK
> > >      if it is done in a standard way and doesn't confuse existing tools.
> >
> > Yes.
> >
> > >
> > >   b) There's a whole spectrum of:
> > >       i) AI wrote the whole patch based on a vague requirement
> > >      ii) AI is in the editor and tab completes stuff
> > >     iii) AI suggests fixes/changes
> > >     which do you care about?
> >
> > I think any AI involvment that results in _changes to the code_ should
> > require the tag.
>
> I disagree with this. As I reply, I don't think if you have AI finishing
> your for loops and such requires disclosure. As I believe that may soon be
> the norm of most folks and then we may get AI storms.

This is actually a very good point.

This is going to be tricky, because hallucination is such a serious
concern, and even this kind of autocomplete would make me want to have a
closer look.

>
> And then, if you have people saying "I don't want any AI patches", does
> that mean those that use AI for templates and such will now be forbidden
> from submitting to those subsystems?

I think that's something we can potentially get more fine-grained on in
future.

>
> I would say if AI creates any algorithm for you then it must be disclosed.

I think what consitutes an 'algorithm' is very nebulous and you're likely
to get people messing around on the definition of this.

I think rather we could have an 'unless' list like:

Unless:

- It's whitespace only,
- You used autocomplete features for for loops etc.

AND you have checked that no hallucination has occurred.

The perennial problem with LLMs is that they can hallucinate in _very_
subtle ways that can be hard for humans to pick up on.

But we also have to be practical so I agree, we might end up with the tags
being noise if we don't make sensible exceptions (whether we like it or
not).

>
> >
> > >
> > >   c) But then once you get stuff suggesting fixes/changes people were
> > >     wondering if you should specify other non-AI tools as well.
> > >     That might help reviewers who get bombed by a million patches
> > >     from some conventional tool.
>
> I should add that non-AI tools should always come with a disclaimer that
> they were used. For the most part, most submissions that use non-AI tooling
> has done this. I just don't think we ever made any formal policy about it.

Yeah I've noticed this too, would be nice to standardise though.

Cheers, Lorenzo

