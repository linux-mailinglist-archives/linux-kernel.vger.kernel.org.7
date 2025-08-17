Return-Path: <linux-kernel+bounces-772539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E7BB293E1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 17:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86B11B257CA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 15:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6595928982F;
	Sun, 17 Aug 2025 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jT4WQ3Mx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D+Kp60CI"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6FE1F4177;
	Sun, 17 Aug 2025 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755444779; cv=fail; b=fTUqadq3vMZGn/Cq1JhJn7JH6II8Y9epwNtbuCAB4WCZhG1AP0l2YiWfY8BAqwAWEA+sIVKqrEr+8VFx8jaNZ/hoD1KLGT5+aYG5YQ8e6CMiV70g5+qdO88ElvxcYRalqbGVeqZApCZj63D+2g9oA6/qe+EH0923or7DWnlft/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755444779; c=relaxed/simple;
	bh=7xLtCgPr1JcO66IL5shjBDtEmvFKQL4JEl+TBN6GkWo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pgSdxEgvXbFaA6xAwea2f0UTkDH0mg2PIWRRQiC4feS9JtUeD3NkAx78ZHNYafMTqH/RRr3auy3S/ieD3x9P/7DUFBmPfG/5ak8Eq0KlqAZwAvKF2h1Be8IqxpTXDfuE2mRSrLv+FG1K4yXuCgDn9OXYvw1WPeB9anMvNb9p2b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jT4WQ3Mx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D+Kp60CI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57HCoD0B002809;
	Sun, 17 Aug 2025 15:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=K93o4lWaxGlj8JLemIt4kpfA25zPcJ4FGnVHwn4RCK8=; b=
	jT4WQ3MxWDESj/7fERdThMv3CrWufRp/jJQHW6dOWr9qpD9Y+6m6jsZklcjNSc67
	SrnTO5fxTlAUDhcCZ7PcKlNHGi63/Kj28Xa+YNMh2arKV2uvqJzOlAbY0HcKL4w0
	B3drgA6U72uoXmndmpt5nCOF8b039V+SSVcQv64ImjhR5A92NyBmXkwqXKPNGDo5
	EK3YUzvqm/lPyEyXJJMhHuHy9NY0svbkF9TziQm6YMYEX3OWFy1xv2KmYLmx0/E8
	Xj1ZwN3t8AW5Nv7CrIXo6jkXE0R9T/Wi+RTLtM3pZf57P889OxoWTyaSMOkeiVNS
	DGUyOyWIBQYY2Gw2NA7bgA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jgs5hkc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 Aug 2025 15:32:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57HCeNVC024456;
	Sun, 17 Aug 2025 15:32:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48jge80d0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 Aug 2025 15:32:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eawP028Ax773s/DnIBAbZEfgw99dVf7DrgKTHpMPqmbnPRBxX7aZYoKg8hj0j1PQhFGFk/Hm8R+kHnUn3IWMuMZI9+xn2M4Q1bpDf5YU0LvxYAkxg/t/4ERyC4OrgBhq1k6AazvZoKvqYIIK/dBEYOa8leKjfeIzXuR7my6dzSBNw/4gaXzBpHNTCDtD45u+doWMZyizxqAxPKpQgOe5E4OEVnBmV0y2yWecmLFpRt7mFVONIBYWNkae9mFHcybWat5RvlUDqa936cgFnPEAnENVmWdGUHfENihLwjLMU0FcTg4qKiKfnShVwfqIXG+mv859zvDyaZxPnBPUYLNAhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K93o4lWaxGlj8JLemIt4kpfA25zPcJ4FGnVHwn4RCK8=;
 b=Jy7UylN4nEpey6BQK6iySANP5wT9av4fAp9s7fXRZNC3lQAqf9ZbGyC90f9j0WRRZ229ZJBPLZhf7TAPHsqcqSRTp6tEaUloWTYcAFBIjh69T0Ydp1gWFVJghp4Qcxe46CN6NcfgTeGrGcQ2S5IMYH8jISHKXroDKWcA22kHA3d1Nh7lGwT/6qwMNM8e/2MUfoXi3UAdGNfog7bJez7yjgklI/UcNyq4PqUgUZi5ABdz/+KI4+X/4FAQbrvnUwrUkhOCtDBDcvYapdS+CAK5BTSY1T3OwFQcvqN4DyOSoTMIifx4yWRbRRtaVKZExIxHUlwqBanutxr24tFbYcnE/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K93o4lWaxGlj8JLemIt4kpfA25zPcJ4FGnVHwn4RCK8=;
 b=D+Kp60CIHC1ShN0MCqYkuaL4Hl6SyxZCF0HPYSjqVqZ5jeoOl2lvQT/wGHjL+xTNO4vdtxy6BNk8blvvLIOI6U1MM0AiR+u+tEAJFsPgfuA7LihBDuPBFlTQrD3UStf5e94Csnx1s0AnofMPXjSs0uAKDR6f6fe+q2lTQ1YEaQ8=
Received: from DM8PR10MB5430.namprd10.prod.outlook.com (2603:10b6:8:24::10) by
 SN7PR10MB6329.namprd10.prod.outlook.com (2603:10b6:806:273::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.21; Sun, 17 Aug
 2025 15:32:37 +0000
Received: from DM8PR10MB5430.namprd10.prod.outlook.com
 ([fe80::9e25:f5cc:10f5:14dc]) by DM8PR10MB5430.namprd10.prod.outlook.com
 ([fe80::9e25:f5cc:10f5:14dc%4]) with mapi id 15.20.9031.021; Sun, 17 Aug 2025
 15:32:37 +0000
Message-ID: <42232742-6409-4f07-9f9f-ee1e0ba4d1f2@oracle.com>
Date: Sun, 17 Aug 2025 17:32:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 xsFNBE4DTU8BEADTtNncvO6rZdvTSILZHHhUnJr9Vd7N/MSx8U9z0UkAtrcgP6HPsVdsvHeU
 C6IW7L629z7CSffCXNeF8xBYnGFhCh9L9fyX/nZ2gVw/0cVDCVMwVgeXo3m8AR1iSFYvO9vC
 Rcd1fN2y+vGsJaD4JoxhKBygUtPWqUKks88NYvqyIMKgIVNQ964Qh7M+qDGY+e/BaId1OK2Z
 92jfTNE7EaIhJfHX8hW1yJKXWS54qBMqBstgLHPx8rv8AmRunsehso5nKxjtlYa/Zw5J1Uyw
 tSl+e3g/8bmCj+9+7Gj2swFlmZQwBVpVVrAR38jjEnjbKe9dQZ7c8mHHSFDflcAJlqRB2RT1
 2JA3iX/XZ0AmcOvrk62S7B4I00+kOiY6fAERPptrA19n452Non7PD5VTe2iKsOIARIkf7LvD
 q2bjzB3r41A8twtB7DUEH8Db5tbiztwy2TGLD9ga+aJJwGdy9kR5kRORNLWvqMM6Bfe9+qbw
 cJ1NXTM1RFsgCgq7U6BMEXZNcsSg9Hbs6fqDPbbZXXxn7iA4TmOhyAqgY5KCa0wm68GxMhyG
 5Q5dWfwX42/U/Zx5foyiORvEFxDBWNWc6iP1h+w8wDiiEO/UM7eH06bxRaxoMEYmcYNeEjk6
 U6qnvjUiK8A35zDOoK67t9QD35aWlNBNQ2becGk9i8fuNJKqNQARAQABzShWZWdhcmQgTm9z
 c3VtIDx2ZWdhcmQubm9zc3VtQG9yYWNsZS5jb20+wsF4BBMBAgAiBQJX+8E+AhsDBgsJCAcD
 AgYVCAIJCgsEFgIDAQIeAQIXgAAKCRALzvTY/pi6WOTDD/46kJZT/yJsYVT44e+MWvWXnzi9
 G7Tcqo1yNS5guN0d49B8ei9VvRzYpRsziaj1nAQJ8bgGJeXjNsMLMOZgx4b5OTsn8t2zIm2h
 midgIE8b3nS73uNs+9E1ktJPnHClGtTECEIIwQibpdCPYCS3lpmoAagezfcnkOqtTdgSvBg9
 FxrxKpAclgoQFTKpUoI121tvYBHmaW9K5mBM3Ty16t7IPghnndgxab+liUUZQY0TZqDG8PPW
 SuRpiVJ9buszWQvm1MUJB/MNtj1rWHivsc1Xu559PYShvJiqJF1+NCNVUx3hfXEm3evTZ9Fm
 TQJBNaeROqCToGJHjdbOdtxeSdMhaiExuSnxghqcWN+76JNXAQLlVvYhHjQwzr4me4Efo1AN
 jinz1STmmeeAMYBfHPmBNjbyNMmYBH4ETbK9XKmtkLlEPuwTXu++7zKECgsgJJJ+kvAM1OOP
 VSOKCFouq1NiuJTDwIXQf/zc1ZB8ILoY/WljE+TO/ZNmRCZl8uj03FTUzLYhR7iWdyfG5gJ/
 UfNDs/LBk596rEAtlwn0qlFUmj01B1MVeevV8JJ711S1jiRrPCXg90P3wmUUQzO0apfk1Np6
 jZVlvsnbdK/1QZaYo1kdDPEVG+TQKOgdj4wbLMBV0rh82SYM1nc6YinoXWS3EuEfRLYTf8ad
 hbkmGzrwcc7BTQROA01PARAA5+ySdsvX2RzUF6aBwtohoGYV6m2P77wn4u9uNDMD9vfcqZxj
 y9QBMKGVADLY/zoL3TJx8CYS71YNz2AsFysTdfJjNgruZW7+j2ODTrHVTNWNSpMt5yRVW426
 vN12gYjqK95c5uKNWGreP9W99T7Tj8yJe2CcoXYb6kO8hGvAHFlSYpJe+Plph5oD9llnYWpO
 XOzzuICFi4jfm0I0lvneQGd2aPK47JGHWewHn1Xk9/IwZW2InPYZat0kLlSDdiQmy/1Kv1UL
 PfzSjc9lkZqUJEXunpE0Mdp8LqowlL3rmgdoi1u4MNXurqWwPTXf1MSH537exgjqMp6tddfw
 cLAIcReIrKnN9g1+rdHfAUiHJYhEVbJACQSy9a4Z+CzUgb4RcwOQznGuzDXxnuTSuwMRxvyz
 XpDvuZazsAqB4e4p/m+42hAjE5lKBfE/p/WWewNzRRxRKvscoLcWCLg1qZ6N1pNJAh7BQdDK
 pvLaUv6zQkrlsvK2bicGXqzPVhjwX+rTghSuG3Sbsn2XdzABROgHd7ImsqzV6QQGw7eIlTD2
 MT2b9gf0f76TaTgi0kZlLpQiAGVgjNhU2Aq3xIqOFTuiGnIQN0LV9/g6KqklzOGMBYf80Pgs
 kiObHTTzSvPIT+JcdIjPcKj2+HCbgbhmrYLtGJW8Bqp/I8w2aj2nVBa7l7UAEQEAAcLBXwQY
 AQIACQUCTgNNTwIbDAAKCRALzvTY/pi6WEWzD/4rWDeWc3P0DfOv23vWgx1qboMuFLxetair
 Utae7i60PQFIVj44xG997aMjohdxxzO9oBCTxUekn31aXzTBpUbRhStq78d1hQA5Rk7nJRS6
 Nl6UtIcuLTE6Zznrq3QdQHtqwQCm1OM2F5w0ezOxbhHgt9WTrjJHact4AsN/8Aa2jmxJYrup
 aKmHqPxCVwxrrSTnx8ljisPaZWdzLQF5qmgmAqIRvX57xAuCu8O15XyZ054u73dIEYb2MBBl
 aUYwDv/4So2e2MEUymx7BF8rKDJ1LvwxKYT+X1gSdeiSambCzuEZ3SQWsVv3gn5TTCn3fHDt
 KTUL3zejji3s2V/gBXoHX7NnTNx6ZDP7It259tvWXKlUDd+spxUCF4i5fbkoQ9A0PNCwe01i
 N71y5pRS0WlFS06cvPs9lZbkAj4lDFgnOVQwmg6Smqi8gjD8rjP0GWKY24tDqd6sptX5cTDH
 pcH+LjiY61m43d8Rx+tqiUGJNUfXE/sEB+nkpL1PFWzdI1XZp4tlG6R7T9VLLf01SfeA2wgo
 9BLDRko6MK5UxPwoYDHpYiyzzAdO24dlfTphNxNcDfspLCgOW1IQ3kGoTghU7CwDtV44x4rA
 jtz7znL1XTlXp6YJQ/FWWIJfsyFvr01kTmv+/QpnAG5/iLJ+0upU1blkWmVwaEo82BU6MrS2 8A==
In-Reply-To: <cover.1755256868.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0127.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::19) To SJ0PR10MB5439.namprd10.prod.outlook.com
 (2603:10b6:a03:303::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5430:EE_|SN7PR10MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aae6132-da7f-434f-a8c8-08dddda349f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VCtLZW5jaHZ6a1AyS1h5bW1YSTFjZWpIOU1rWkhIOGwxa3ZnMWJHYWZLL2hW?=
 =?utf-8?B?TXgvNTQzUjR1ZEdidW5QUFJxMEljWW9iTGkzd0FEZW9OOVlrcUVLWTAvODZq?=
 =?utf-8?B?ekM3cGJIOVZIWGorY2tvaU9ySERzK2dvbnZmUXZCV1VTWlp3T0ZUYitWWmYv?=
 =?utf-8?B?bG1hakxmR3c3SmlmcjJLNy8vNStjaVR6ZEN0SGltTUFyMWVJemFtdHNyR2Iv?=
 =?utf-8?B?TzhJeVdyN2FMeFMyY09yQnVnUjdwN2FtdlpZaks5RWY2TzU4aFZRZmhFZkdl?=
 =?utf-8?B?ZVVDeTZEUy9HYWFGSGpvZTU1dHRsUGFDOUhzVyt4d0h0RkZlMlNPMjVQQ3Br?=
 =?utf-8?B?d1RaaWNRSFpnVlhaQ2Z4dEwxblV0Zjc5WXQrUm83NGIvQnFWTnpXYzVrU3NB?=
 =?utf-8?B?SVEweVpzaVoybFIrSjFRUWRnQ29VbVFiZnVpbWlTNHg3d2dMQzBpdS9ObTRO?=
 =?utf-8?B?UlNXREM3UzVuV1FZaE5sdnRJNW9sQmltTnN6Q2x6aWRWREI4QTdmM010V1RW?=
 =?utf-8?B?UlNlZzE1VVhnb0NMbW5XRk9remVDZmhNWG52QWtkUUFZYUtOWFBFRkxBN3BB?=
 =?utf-8?B?dS9Na0JSNVpTTWEwaXdrV0FkOVVhYmtTQklWYk5FLzFSYk0zN0J3S2d1ZlY0?=
 =?utf-8?B?QkZlS2d5Q2UydXVGZitHSzhvV3lnVUFMNmVZMXN6cnJCaGpJNENCQW9CaGdI?=
 =?utf-8?B?emVGL0ljL0NWYUI4Snd6WHJJN0RldnMzUmQ3bXI5b2Y2bnlKMGlCckFnbzZD?=
 =?utf-8?B?NlFURmhBUEVxeVRCYXRDMFl4bHdMV1gyTGdmUUpZaklSUUtmUDJPTDlDQUtt?=
 =?utf-8?B?L0JHREU1T0VVcW02Qi8yendjLzQ0V1JYNG92bVJDOUQrVWF0WDNEOC9HV2lD?=
 =?utf-8?B?b2tTR0Vmb09zN3lPWk8xc3puS1ZTM1pWMDdyMTB0cnNqT3hpSHlPeVhTSHh5?=
 =?utf-8?B?U20zajFDL2tMbjV6ay9xVFpQbFdELytORTM5bXdWaDdUWDhtdzgvdHhQbkxu?=
 =?utf-8?B?bjlvR0JEVFp0aUo0ajdoaVVtM052TFUrTVdyamR6SkJ5bml4TU1YYVdsWWRK?=
 =?utf-8?B?YUlYbitFakFJdStUbTJMTGlPWUtmTUFNS1Q3bjZ6OEhGczR6NXJReU5zTHdN?=
 =?utf-8?B?Nm53ZXRITUp3bGlZTXNZaFhTR0QycGU1Y0dzdm13SUV4U21LMUM0clhTYjdK?=
 =?utf-8?B?YmZDZUE0Z0UveEZrTWhrQjlSbVo0VE1QeHdnWEJNZ3VaQSt6cVFLRjhWaEVy?=
 =?utf-8?B?Mnp5S0JPdFhsTEZMZWRIZUl6QkpCNXlyek9Id3F6V294ZUZNcHFnOVROZi9i?=
 =?utf-8?B?bHdxZElTdGFhQ3J1b2FxRDZlWUl0S21XNkxGNGNzNDBCZFFSVkVwMndPNzA4?=
 =?utf-8?B?RG14OEtwdnBrWXF3bHo2eXJrT2RFWVo2cG5nVjFWMGpIMnd1S1Jnay9BK05J?=
 =?utf-8?B?ZnJsREdvbmlrNndGRUxvL2h2YlRoYWpleEFNVmRmdmVleEVJclVmL1pTdUxG?=
 =?utf-8?B?ZFNKai8vTTVSeDY3TENkeGtORGtDZE9IK3lGUWhVVWFERlZXelQxNE4wYy9E?=
 =?utf-8?B?UzhSMi8wL3VRZFJaUGdJcVc0MWVrVlhHdE01S2Q4OE5BSUdSc3kvSEJteDRa?=
 =?utf-8?B?YnhvQVNIYmJXNDV2YTBYSVV0R3d3eG5HaWlHY2ZTVm9mV205Nm1DU09IeTJF?=
 =?utf-8?B?cnR0a1B1alNrZm9OWnJJZlloRVF3eW83TDRxMXlwZjdpZzhRYkFRcnc5S2Rx?=
 =?utf-8?B?cFVSUnorell5ZloxRVBjLytjazMzME0ycXp2eUE3THEzVXdubDVqL2FDWllF?=
 =?utf-8?B?Y0pzdDRENzZNeGFaS3ZSU0swS3pBMGZVUHN5MjJCTWRIa1NDQzRsOXF6bWxL?=
 =?utf-8?B?MWlRVFhSR3hRZTRJclhvQ0RWUys4K1lnR1NsNFRja3c0b1d4OVRoZlRUSUFE?=
 =?utf-8?Q?IJQGRnSWBe0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5430.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTdjL0NiWGZGdXZSY05rdDZ5TXorK041R3Q3NEpoRldwUW1oRUpaTUhYYWFI?=
 =?utf-8?B?dG9tOE1PVjFHdStOZzZ2bVgrOFhJSHdDVW9MbnIyaUIzaUU0RWd5LzRnV3V5?=
 =?utf-8?B?M09tUCtTYXBla0Y1RG12K2lTeGFGZG04YmViemRLbzAzZ0s5aFo2Q20vREcw?=
 =?utf-8?B?a05FU3RKRllrU05vR285d3liTW1GWGZscnRXVmlvMkFuQVNIY0h2QThoVGtk?=
 =?utf-8?B?bks2TDltc1hpVjV0VVdPMWhmbTN3L3hWZnZIUjdFSnhJTjJIdkcwMnJtVEJK?=
 =?utf-8?B?OTFPMXN4aDdCTTVlZkhvT251eTg0N1lZZ0dPbEVhU1dZRVc4ZEVjZ053cjBL?=
 =?utf-8?B?L3dWNmxmRWd4N0I5emt1b1lqZ01ZR2dHK3JBdG4zanc5TGprZkZZZnV1TEIx?=
 =?utf-8?B?UHhySHIzb0MwdEJ6SDVCWklsMlN6Z2U4V3pVbmF1VGEwNitsSFFUR1M2N3Vq?=
 =?utf-8?B?dlEzTUtaKzQxVDJaNjVyK3c2OGpxZWhtak5IQUM2eXhtSTlFVW4wS0MyY092?=
 =?utf-8?B?cENCTlY3K2FTVHdabTF2NTNpR3NhK3EyeElRbXJmeTc4ZDZmODdZVzgvT245?=
 =?utf-8?B?TXhkcGZQWFplcDJybzNRY0lvMkdlMEs4ZGpZQVFuMkhtL25UNjVsOEtLek1p?=
 =?utf-8?B?OTliNEhJcTRQUm51NjdCdTh5T0xHd3FIK1RPNWhwQ1JKWmRjR2dBTmJ0VVU4?=
 =?utf-8?B?SzZkQVJRSUxiUmlJbGVTZDQrdDJkNGJCZlJkcU9wcThqS1FMbzA2dGVaMkVD?=
 =?utf-8?B?OWN4WERVSE8rK0FwTUpvaVhQWUZibXppMVQvYndlT1lLSE5udmlpU205MUN2?=
 =?utf-8?B?Ym9sWUtteE5DNndqOXZiOXB2b2lVZDI4K3lNOGhuOURrcm4vVmJzMEw2Wmhu?=
 =?utf-8?B?RnBNd1VtZkFVNmZQa0g2UVdZQ1RiQ1hlbGNrcVI0d1p1ekxxZ0wyZlloTHVy?=
 =?utf-8?B?QWRrWWxIUDNnaFAyZ1hUUEo1YjZtYjg0VWEzcDRLelI4SXdUMnNpWlNpVXp6?=
 =?utf-8?B?RUdIZmkxSVhYajRyQTF5amVxUFZVQlFGVlAyMnZqWjR4SWtUdkhwazFTSVFj?=
 =?utf-8?B?NjJVY0UyZkhIbm8xSlVsVStsa0ZFNnhRUS9WV05nVjVVcFZPZk1TeEM5YlMx?=
 =?utf-8?B?VTR4QkhkQkF2cVhpSzgyOHQ4ZHZoa0ovWFYvSHJUSHdtdnVtTXk4VU9pVW5P?=
 =?utf-8?B?NTF5M1NHNExXenpja3dhZjMyYXlwTWJ1UzF1NlZnRjU1RWh5RlNsaXNVSjBV?=
 =?utf-8?B?eE1NZ3ZZRmN6UXcvTDZxZUtzbnV3OFZFUDBSNWJwUWNnalk4aDB4Si9zYzNU?=
 =?utf-8?B?L29mYlowK0l6R1ZncksrSFk2ZUhZYnlSbVBsTFgwLzNLS1F1bDdsL2JnV2Ny?=
 =?utf-8?B?bUFZVTRMY0YxR3FZdkp0WEJiY3JZMDN0M2l4Zm1LRk1wZ1Vsc3YyRFdrdDdh?=
 =?utf-8?B?endzeFFUR2N0dFNpR0IwV1o0MWNjWmY0M08zay9MVVkvRHFJTFg5SzdCYlpP?=
 =?utf-8?B?bHhQSkw1K1dxcnpOZGQxUGxRTFp2TXRwdU9TVFVGREp3MldtWXFEUjBRU3hm?=
 =?utf-8?B?emxOT3dnNW1lUWJMVld2Znl6cGRkcTBWQzNKaXdOSERxcHF5SzNMc1JFbTlT?=
 =?utf-8?B?QWNlSHJ3dmh5eXJWbTZpTGxqY0tsYlcvL2VlcTNXdmZZOFZ4VFVKcUJJcnlt?=
 =?utf-8?B?ZnZvRjdvMjhoZWpaVFkwMExSYkpvbk5sMVFVellQcWtGNjFwWGNkOXV4ZXNJ?=
 =?utf-8?B?QWFsMnlxbkpURklLOU9adkM1QWhGcnQ2N1Ixa3MxS0VVWDJKWFpDd2xpY1BJ?=
 =?utf-8?B?clU2TlJ3ZVdRMHAvd2xWT1ZDcG0ydmdqYTEvbmtZVURnMnFKdDI2TFljYjNn?=
 =?utf-8?B?UnRta3A1NFN4T1R6c25xU0dUYmgyMW9qdEtXTExsR3hzSEVVNVQ0NTRVSjFQ?=
 =?utf-8?B?dlI4RkpWVkh1Vi9tRzMyMXlKVzN1YzA1QnFsWk5PbElaL3Vtck5uWEI4dmN3?=
 =?utf-8?B?SnJKdXdjaVpid0I0b2ZKcHNGMExwTVluTGxKL25uc3VvU21ubzV6YVg2WC9P?=
 =?utf-8?B?NHMxeW8rZzRyY1ZiWWlmcHZ6OW04bUp3NUZ1TGYwSWJzK2JaVFdkSEdBQnBW?=
 =?utf-8?B?dEw5b1EzQ2E2WmZvaXhTTlk3aGNCU01YUWJjUk1HYWVZVjdoNy9xeElRSEF3?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tI+NFsDRCvUMg9QdHCsvdSLbCQM9R72coFOfrWlqRU2rD/kRkzHmhZcp8U4TrPZhORmSeWUf/jsabFgK9d6EP4rEoiNuRDmJZrMKPTWpMd+jt3rVoczGikXSci8WXAbLEHXeK/Y/WwnD5fS/KARUfgrThEqt3lV9rvCYt6Wfy7bXcFg9EupiHaRlpLNWNHoyO0ROOEeW2/p4e+Sct9VimSQOAKsrscAJPrKInUr3ZCLRA47tNhgFEeMPgXY315zi/LV+11y9DPoIiOWAeYmGe007Vsz9XHUhk8Mdg3KbBVUZ7VhnbNZKT8vKN2szKMHVndRImM5y/FgHI+MttWk1BxSEMkHC2MKDfwIzpAnFN57HYyqdXbJPu8Mu8kt7v1GoCWOJwONZjs3dXv5fZfNAeybvY9YoEuzOBbQebYPColYVkRqmGuqzgeOaBzEWlqGOHir5tKo43P0RQezlWXtwd8aOGQ6VHGMxn8/jeONZpazKK4pYIxCRdbMTzKGBiEeO5rzpgBc5W+HQu53ZVqABqfqP6bTZ6kh2toUJleXiXr7/x7GmRjiY+vazocl4/ZNrQarnnnZomCF9OFbeREotr3NNE8Ap0b06NMWqbsSVKB4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aae6132-da7f-434f-a8c8-08dddda349f0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5439.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2025 15:32:37.0006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhJKwTmI+RnKWSxf1HuYiYEivVcxAETz0xqsYpZmgvbCHJkdui/pv0+IdmClbe8eNyUlh1vD8iLkmZNqAmquQIkAW09sHpeUBCSD+0OmclM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6329
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-17_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508170161
X-Authority-Analysis: v=2.4 cv=DLiP4zNb c=1 sm=1 tr=0 ts=68a1f618 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=gUb43z7MIW0LjZvKxGIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE3MDE2MSBTYWx0ZWRfX15AG0O475FGJ
 vNU1wB2YFeA1+BRxHGULWc11ta+WtGP4vC6PB861z4jrNu35voHLG50fttxtgh3HjUD/4TXCdUH
 LB9dyHE2AFHTx0hTBavO0iVC9XbBEzmKMQ/B9YEQVjWRvBwZgzaM2MdpmvcUgfvSGMf3TrYwuYk
 VsXoe7Bpcn0+WUh2jAFqfXbO40W7eJo9S2lVJO3p66UDtWKxjPtAs1zHIO9wHJhKeQ+QiJVLy9s
 9FwSnUxemWORC2g2A1e/gAZJQNMgr4Cn+mcJy8gmV63BlSgH648ax/BtviihCgPoCL8QCcD76PZ
 SxtN34dduiRCwsgUS9xnjhRyHjc8y6E5Pi05Qkwa+P/EVBvfAuLybMbfCrbms3QMMBIanI/DK+n
 cZIsjVhLxHxP3erWff8hDinwC6nBHA2HK04xmv9yAloyVcTbmPq0pgOiRAB9tbaNYvNpfnz3
X-Proofpoint-ORIG-GUID: EvCky81f6ihbaAelj87JsbKkrRi7j9JX
X-Proofpoint-GUID: EvCky81f6ihbaAelj87JsbKkrRi7j9JX

(trimmed Ccs)

Hi Mauro,

Thank you for testing on OL. I'm wondering about some of the results,
however...

On 15/08/2025 13:36, Mauro Carvalho Chehab wrote:
> Oracle Linux Server release 9.6:
> --------------------------------
>      PASSED: OS detection: Oracle Linux Server release 9.6
>      SKIPPED (Sphinx Sphinx 3.4.3): System packages
>      SKIPPED (Sphinx already installed either as venv or as native package): Sphinx on venv
>      SKIPPED (Sphinx already installed either as venv or as native package): Sphinx package
>      PASSED: Clean documentation: Build time: 0:00, return code: 0
>      PASSED: Build HTML documentation: Build time: 0:06, return code: 0

How is the html PASSED with the build time only 6 seconds, that looks
rather odd to me.

>      PARTIAL: Build PDF documentation: Test failed (Build time: 0:07, return code: 2)
> 
>    PDF docs:
>    ---------
>        PASSED: latex: FAILED (no .tex)

This doesn't seem like it PASSED either if it FAILED.

I tried on OL 9.5 and got:

"""
$ scripts/sphinx-pre-install
...
You should run:

         sudo yum install -y ImageMagick graphviz
...
         sudo yum install -y python3-sphinx
"""

But I actually need to do this:

sudo yum --enablerepo=ol9_developer_EPEL install -y ImageMagick graphviz

and then

sudo yum --enablrepo=ol9_codeready_builder install -y python3-sphinx

respectively.

After this, I see a bunch of red warnings but 'make htmldocs' succeeds
and after 33 minutes.

For pdfdocs and latexdocs, respectively, I get:

$ make pdfdocs
Documentation/Makefile:156: The 'xelatex' command was not found. Make 
sure you have it installed and in PATH to produce PDF output.
   SKIP    Sphinx pdfdocs target.

$ time make latexdocs
make[3]: Nothing to be done for 'latex'.
Using alabaster theme
Using Python kernel-doc
Documentation/i2c/instantiating-devices.rst:36: WARNING: Could not lex 
literal_block as "dts". Highlighting skipped.

real    21m12.103s
user    20m58.124s
sys     0m18.567s


Vegard

