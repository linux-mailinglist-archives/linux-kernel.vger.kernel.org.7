Return-Path: <linux-kernel+bounces-832159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCEDB9E854
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1B41899242
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F8B2E8DFD;
	Thu, 25 Sep 2025 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kOgA09Z6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aNlnvZgJ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74BE2874E4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758794139; cv=fail; b=tv7PvXwr+zBJLEz7zH+SCSmLttZUutt4f8mJVu1h+gNiHTLetMDmpjQ6gZVfYKvphs+b18vsCwTv8XnB5zvFPTB3hmiOJz+6mivcYZQ1WwbxC1rLe7PVyYEIwT8gt5Qq4W1MUpENc001BIyLA1kq1B6Z/RG49PJcDVMksD+KviE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758794139; c=relaxed/simple;
	bh=H5NBJwQ2UomhFY/qd6CNTA7KGPVNIfDncLwzu+rHApE=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JNW6NE9QAm6t4svH82Ftm0rg68ETyfp9dZTP8HX4IzT2TeGqN13SHYpOv2K5yg4RUDdgYbuhQwp4i6Tel9UXaOkwvXVxEUFHB4nmYw7Gj4+XnAvowMrdR9Iyj1CZUtg2FG6GyemJi/c5TJqkjxUspdIkX1tQalocT7uZ7yqIRRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kOgA09Z6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aNlnvZgJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P7tuaM011354;
	Thu, 25 Sep 2025 09:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=CEWofR91XCkBmBqZbu8QkASI2rewj6l1fMclHxgtBCM=; b=
	kOgA09Z6NGprn1TVnUNRoVycusxXZB+ZfY4afXfnvSvGmdyDOTXB8aoivinUPG4z
	FNRhsxyRbyTTnCP1Qi18Ew/GdIqKjmlnFXylB8nbbS7A583X6TCLB5sx4uutpZtA
	bJ/mzjsfsQr9jKRPLNS4fxMU7ZOARFHwQbB2kygix7g+9YLPegWOfO1Vy1v8v7On
	iV2tiOlLaJqbjbmTASrFCq9zN2jinAuz3PCqi2aHz6FdqkcAgUmQZT1+qXJA4U6d
	VZE4Pnn4qClU36hWQ6jrbp3+PSSt31U4jt4sx2wkxGda5+iAs/z02KhF1f93y4Dm
	K9ZXHO3zCErlt9rSkpWRVg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499k6b1k8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 09:55:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58P7e9e9021738;
	Thu, 25 Sep 2025 09:55:29 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 499jqausbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 09:55:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAwW47HrhzXLwDJGJ6hoWYbizNlheG6IGDcazS+JBwFt3/wDlW+U90jC1GRZ/0r7/xsVvWe/U+WsQ0kmzLHg3MDlMAYxRqn5UCt91WV0Kn9gwYeh7eeckEXMSzeu4a5uotcYu3X42J2OaPGV2ljMhBWcXLZt1gcYR0YSZdHGG0W7L/pxfrVab0zdkbJfgxTCAMSvOqA4Cc9sanI+aogYAXygUqJkZyotDjwAfBHA668D7TV7e/27MSnDeSP4jC3j1sJRgx4Zx6Vu5+bGR++KVhQT7UIDq1R1rH0JIoVQJ5vFd69cUTmT/7AvVtteMK6jE2WHhVFjAT+7c5d6T13SOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEWofR91XCkBmBqZbu8QkASI2rewj6l1fMclHxgtBCM=;
 b=s20UTz3S3hjYmhFZUgQQ8WLAnBQSYPqImFNfrYk3sfCVfC8vdM30B1CWhiJe52bH+8ER+cTdvprZZjpMEv2/VqodCjrZ1vhLb66Fp2XUAchyW2l00DsvrjTJHfQdODTyQJR+DTDaNdc9AQJ3V5u8TxblZZBMbfmBTi++q5R6XzywDbNxfgYVJ33wfn0KRkeOMGp+mNkM4MiXQvSHUVZfQn4W9k1TgB0W+0H23o26CnXKw+v0nP9W5AkqWQOkTYEi/EmMp5Efr+1/SP1s1Yhko97D5rlwkxIT0GJbGbNsLxUzu2VISBUYq/R1/ywq6Z6BOQ+JfzsSXdI37VKjQPRF1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEWofR91XCkBmBqZbu8QkASI2rewj6l1fMclHxgtBCM=;
 b=aNlnvZgJ66MdlXXJpNigGYr8I15NQABbnOy9C60CW9pARAz8cmZFXn/17OGtlBW1zNXUC5fIkJMyOciXLICxtrckz7SUDf8EDPE1hR5PC+1av7uPUeQlO0B2sNBTqdMlUrNrbtxr7EkPHkRmIs0y9l2cJfPhKAC5UT54ZUYRxcM=
Received: from SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18)
 by MW4PR10MB6558.namprd10.prod.outlook.com (2603:10b6:303:229::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 09:55:27 +0000
Received: from SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084]) by SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 09:55:27 +0000
Message-ID: <f17d5e92-2aaa-43e7-ba67-ea5e7d07601a@oracle.com>
Date: Thu, 25 Sep 2025 11:55:23 +0200
User-Agent: Mozilla Thunderbird
Cc: alexandre.chartre@oracle.com, jpoimboe@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] objtool/x86: Fix NOP decode
To: Peter Zijlstra <peterz@infradead.org>
References: <20250924134507.288529132@infradead.org>
 <20250924134644.154610650@infradead.org>
 <b6aaa53d-2658-491a-9308-32ae2b5aefb1@oracle.com>
 <20250924184158.GZ3245006@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Autocrypt: addr=alexandre.chartre@oracle.com; keydata=
 xsFNBGJDNGkBEACg7Xx1laJ1nI9Bp1l9KXjFNDAMy5gydTMpdiqPpPojJrit6FMbr6MziEMm
 T8U11oOmHlEqI24jtGLSzd74j+Y2qqREZb3GiaTlC1SiV9UfaO+Utrj6ik/DimGCPpPDjZUl
 X1cpveO2dtzoskTLS9Fg/40qlL2DMt1jNjDRLG3l6YK+6PA+T+1UttJoiuqUsWg3b3ckTGII
 y6yhhj2HvVaMPkjuadUTWPzS9q/YdVVtLnBdOk3ulnzSaUVQ2yo+OHaEOUFehuKb0VsP2z9c
 lnxSw1Gi1TOwATtoZLgyJs3cIk26WGegKcVdiMr0xUa615+OlEEKYacRk8RdVth8qK4ZOOTm
 PWAAFsNshPk9nDHJ3Ls0krdWllrGFZkV6ww6PVcUXW/APDsC4FiaT16LU8kz4Z1/pSgSsyxw
 bKlrCoyxtOfr/PFjmXhwGPGktzOq04p6GadljXLuq4KBzRqAynH0yd0kQMuPvQHie1yWVD0G
 /zS9z2tkARkR/UkO+HxfgA+HJapbYwhCmhtRdxMDFgk8rZNkaFZCj8eWRhCV8Bq7IW+1Mxrq
 a2q/tunQETek+lurM3/M6lljQs49V2cw7/yEYjbWfTMURBHXbUwJ/VkFoPT6Wr3DFiKUJ4Rq
 /y8sjkLSWKUcWcCAq5MGbMl+sqnlh5/XhLxsA44drqOZhfjFRQARAQABzTlBbGV4YW5kcmUg
 Q2hhcnRyZSAoT3JhY2xlKSA8YWxleGFuZHJlLmNoYXJ0cmVAb3JhY2xlLmNvbT7CwY4EEwEI
 ADgWIQRTYuq298qnHgO0VpNDF01Tug5U2AUCYkM0aQIbAwULCQgHAgYVCgkICwIEFgIDAQIe
 AQIXgAAKCRBDF01Tug5U2M0QD/9eqXBnu9oFqa5FpHC1ZwePN/1tfXzdW3L89cyS9jot79/j
 nwPK9slfRfhm93i0GR46iriSYJWEhCtMKi9ptFdVuDLCM3p4lRAeuaGT2H++lrayZCObmZxN
 UlVhZAK/rYic25fQYjxJD9T1E0pCqlVGDXr2yutaJJxml5/jL58LUlDcGfIeNpfNmrwOmtUi
 7Gkk+/NXU/yCY17vQgXXtfOATgusyjTFqHvdKgvYsJWfWZnDIkJslsGXjnC8PCqiLayCPHs+
 v+8RX5oawRuacXAcOM66MM3424SGK5shY4D0vgwTL8m0au5MVbkbkbg/aKDYLN33RNUdnTiz
 0eqIGxupzAIG9Tk46UnZ/4uDjdjmqJt1ol+1FvBlJCg+1iGGJ7cX5sWgx85BC63SpKBukaNu
 3BpQNPEJ4Kf+DIBvfq6Vf+GZcLT2YExXqDksh08eAIterYaVgO7vxq6eLOJjaQWZvZmR94br
 HIPjnpVT9whG1XHWNp2Cirh9PRKKYCn+otkuGiulXgRizRRq2z9WVVQddvCDBDpcBoSlj5n5
 97UG0bpLQ65yaNt5o30mqj4IgNWH4TO0VJlmNDFEW0EqCBqL1vZ2l97JktJosVQYCiW20/Iv
 GiRcr8RAIK8Yvs+pBjL6cL/l9dCpwfIphRI8KLhP8HsgaY2yIgLnGWFpseI3h87BTQRiQzRp
 ARAAxUJ7UpDLoKIVG0bF4BngeODzgcL4bsiuZO+TnZzDPna3/QV629cWcjVVjwOubh2xJZN2
 JfudWi2gz5rAVVxEW7iiQc3uvxRM9v+t3XmpfaUQSkFb7scSxn4eYB8mM0q0Vqbfek5h1VLx
 svbqutZV8ogeKfWJZgtbv8kjNMQ9rLhyZzFNioSrU3x9R8miZJXU6ZEqXzXPnYXMRuK0ISE9
 R7KMbgm4om+VL0DgGSxJDbPkG9pJJBe2CoKT/kIpb68yduc+J+SRQqDmBmk4CWzP2p7iVtNr
 xXin503e1IWjGS7iC/JpkVZew+3Wb5ktK1/SY0zwWhKS4Qge3S0iDBj5RPkpRu8u0fZsoATt
 DLRCTIRcOuUBmruwyR9FZnVXw68N3qJZsRqhp/q//enB1zHBsU1WQdyaavMKx6fi1DrF9KDp
 1qbOqYk2n1f8XLfnizuzY8YvWjcxnIH5NHYawjPAbA5l/8ZCYzX4yUvoBakYLWdmYsZyHKV7
 Y1cjJTMY2a/w1Y+twKbnArxxzNPY0rrwZPIOgej31IBo3JyA7fih1ZTuL7jdgFIGFxK3/mpn
 qwfZxrM76giRAoV+ueD/ioB5/HgqO1D09182sqTqKDnrkZlZK1knw2d/vMHSmUjbHXGykhN+
 j5XeOZ9IeBkA9A4Zw9H27QSoQK72Lw6mkGMEa4cAEQEAAcLBdgQYAQgAIBYhBFNi6rb3yqce
 A7RWk0MXTVO6DlTYBQJiQzRpAhsMAAoJEEMXTVO6DlTYaS0P/REYu5sVuY8+YmrS9PlLsLgQ
 U7hEnMt0MdeHhWYbqI5c2zhxgP0ZoJ7UkBjpK/zMAwpm+IonXM1W0xuD8ykiIZuV7OzEJeEm
 BXPc1hHV5+9DTIhYRt8KaOU6c4r0oIHkGbedkn9WSo631YluxEXPXdPp7olId5BOPwqkrz4r
 3vexwIAIVBpUNGb5DTvOYz1Tt42f7pmhCx2PPUBdKVLivwSdFGsxEtO5BaerDlitkKTpVlaK
 jnJ7uOvoYwVDYjKbrmNDYSckduJCBYBZzMvRW346i4b1sDMIAoZ0prKs2Sol7DyXGUoztGeO
 +64JguNXc9uBp3gkNfk1sfQpwKqUVLFt5r9mimNuj1L3Sw9DIRpEuEhXz3U3JkHvRHN5aM+J
 ATLmm4lbF0kt2kd5FxvXPBskO2Ged3YY/PBT6LhhNettIRQLJkq5eHfQy0I1xtdlv2X+Yq8N
 9AWQ+rKrpeBaTypUnxZAgJ8memFoZd4i4pkXa0F2Q808bL7YrZa++cOg2+oEJhhHeZEctbPV
 rVx8JtRRUqZyoBcpZqpS+75ORI9N5OcbodxXr8AEdSXIpAdGwLamXR02HCuhqWAxk+tCv209
 ivTJtkxPvmmMNb1kilwYVd2j6pIdYIx8tvH0GPNwbno97BwpxTNkkVPoPEgeCHskYvjasM1e
 swLliy6PdpST
In-Reply-To: <20250924184158.GZ3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0023.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::28) To SN4PR10MB5622.namprd10.prod.outlook.com
 (2603:10b6:806:209::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR10MB5622:EE_|MW4PR10MB6558:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd69299-ab38-4f33-3c0a-08ddfc19a74c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXFjQkdYaHJJb3Nzby9GL3JFc1gxT3MwK1dGTDRwMi9XQ1ZXZFpPS3NacU1X?=
 =?utf-8?B?L1JPMHg5VEJEc3ZRK2lWZ05RcGYva2VYd2RJOWRXTi9uUU0yOThaSDAzZmpM?=
 =?utf-8?B?aExobmoxU2RyVTEybHdqbGhYQ1ZZOUc0NzErY1Y1ejVYUDY5US9zWjdabXoz?=
 =?utf-8?B?NE1qaUhFUjlSNS9nbFMyZDFvQ2M4QzU5bUxTSkZNTlVUN3Zqa05hbzdYSDlw?=
 =?utf-8?B?R1FieEdNdFNGMFBZTzdhemgzSFY4WXkvMkVsM25OQVJvZG83endxeFN2MlZ2?=
 =?utf-8?B?QzZYR1pKbkxlZXFHWnI0NnRpb0NEK2dRWlJNblM5TEVsZmd2QitHRGtlTEJ1?=
 =?utf-8?B?amxsaTVoZUNTSmQxT081eU9Ha2RLS2REWWhuS2h5c1ZjU2hTQXk4VDd0b0E4?=
 =?utf-8?B?aG1mS21xTUllK1htZHc3K3p0SEF3NXYzS3VpYVRHaWkrbDR2MEV4eG1ERXZS?=
 =?utf-8?B?TnRxTm11bVBrU21QMzlVN0VzOWxsZEl0cGxML042eFMzQVkrYi90TDRaUjM4?=
 =?utf-8?B?aXVjbTF5VmRYbWVSY3k0R1lDMVk3Y1lhQm0xSHJYRkl3eUNsUGNzdFJBc0pq?=
 =?utf-8?B?Z0c0WmdnV2F0VnZScUQ0Q3JrSWJkMDE2emlEY2lsYWJqUEhuU0swSUNIcDRy?=
 =?utf-8?B?a1BabjdwOERRa2ZCR2NkTGhBbEt0OFhMQVhMK24zUE1peTVsbVk5aWV6a3Qr?=
 =?utf-8?B?MWd0aXlPNkhQQkJYVkc4Zmh0WFpPenM3blo0NUZsNUZIYjFHalJrRG5tWmhP?=
 =?utf-8?B?dmVOWmdOK1VxZi9HbDBDbnUyc0pMbW5vYW5IRVZ0eHQzdTR3d2EybFJ2emk3?=
 =?utf-8?B?TU1xL09xcS85cEVtZjRUREZKZnFBRUk3d0xCdlZzY2xwWXdaeGNCQ1B4eE5i?=
 =?utf-8?B?enFvMk93T2tWdDFLdlR6YWF5dkFqR0duN09OZGlja2FlS3lqWVZPUWt5YjBJ?=
 =?utf-8?B?TDc5QllXZHZNWGNDU3lNV3liZW5saUU1WHNVSXY4VWpJNm1wTE9yeWJBOWdw?=
 =?utf-8?B?RVRqcDhDbVlxMFpiOUh0R3hKeG01c094NWVNYktjSUd2L1VTb2FMZ1dsZzRn?=
 =?utf-8?B?bVZwc0FrdGpXMjFFcGdWekxFaFFzUGh4c2RQbE1pTEdFVW1KcmFNZDkxYWxn?=
 =?utf-8?B?ZUJyWDBZVlc2aW54cm9qOWZKYUYxck9aZmJjcmVpZGdnenUxR3BPcmpCZHBK?=
 =?utf-8?B?QnRtNFptU211Q09pYjgrUWZGaXozcEJ1UnZueDMvVEs0ZjFTR21IT0p6WDZI?=
 =?utf-8?B?N1RPK09sY25yY3Fhd0JuMnZmSTZkb3VCVkpKalNCNFVWbnRHbnJqTGNJeFNF?=
 =?utf-8?B?OWJmV05QWmZMT3AyN2VpbDVNeDZIb25TRmt0ZGVienN4ZGE2Y0Z3TFlYY1M2?=
 =?utf-8?B?TXVKa0tjMFg2TjB5dFdUQm1YOEZrM2JoSjFBMEM0cUhHRG1ybGFxWWcwZ2c0?=
 =?utf-8?B?anBrUVcxVnFBcURkQWh5ak5tY3ozanVUcklob2VnZ2w2Q01zN0ViQnVBMmdF?=
 =?utf-8?B?UjMxQkhtU0dpOUdIQUVuR1I3bTlGS1hMQzdIUzZnS0FDQVBKL0pFQWYzQ3Nv?=
 =?utf-8?B?aTJoWGJBc0ZEYVJJcTlwdDdSNlRaZDgrQWtGdjlpZ0RtZ1I0bXNGTStaVVNF?=
 =?utf-8?B?WHZHV1p3RVNvTEtBb1RkZCsvbXphUVk5LzdqcDVSUmgyMDd0RWY5MlNwajBL?=
 =?utf-8?B?ZEIwZnVDSWdueGFXZmJLNE9VYlNlbGl2ZFNzbEZZU1cyUUdMWnFVcUFaR3Fm?=
 =?utf-8?B?cm9ic3lZSEREdXRXNFVHZTRNMmxYaHluMStrL052R3JLc2FNYXl6T1JIOVNa?=
 =?utf-8?B?bGhJaXZqdkx4NXIxOWVzVE1DNWp3d1hCTWw3THRtYlgxdTJ2VUM3ZzJLdzly?=
 =?utf-8?B?OGFtR1Q4ekdKdUZla1hvRmZQSlF3ZHlUQkM2RFNiYVVuV3Fwb2F5SU5CZEo2?=
 =?utf-8?Q?ImVJtawIm6Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjlqcHpOMzY1R0lldzdXakVUZ1lHZlF6QXNtVXlGZllLdU5EUDJMZlVZNkVM?=
 =?utf-8?B?WEU4WFRldWJIbWxHaVoraDBtdWJNa25sZW5xaGZSaCtCYmdpYmh5cGtEUzZ3?=
 =?utf-8?B?S28vTUtLY2lJR2VNQzBKQUZTd0x1NjNpSFNWVUtIbHhwL1NVcTNRL0kvQldo?=
 =?utf-8?B?Tms5MGNEVlRQdUZ0TTFCVDN1TUJNbENnU3JtSGpLcHBJQitBd0dBNU5WRys2?=
 =?utf-8?B?dG8zMFJLa1MzY3FJZXdQUUVtd0FaVWNCdXkrcTU0cU1DMkxBNEE1WnhXeEZE?=
 =?utf-8?B?WUR2cS9XT3M0T01iT1RRU2ptVVpnMHpLYzJVeFRVak1iRHp5MlExREhTV1ZQ?=
 =?utf-8?B?aFFEVWJXcjRhTTcva1kzb0E1ZzRaeFNSMnVFSTJVRXBMZENKc0QzK1plSllO?=
 =?utf-8?B?czBmWHNJSHFtVnB3OXM2elI5Nncvd3k1cUk3eUVTSERqdU9vbDVVclUxc2NG?=
 =?utf-8?B?bVNhWTNVYi93Q3ZDa0kwZ3VMVC8zM0V4aU9raUFoZnN5YmNGUXFLdTFpQlh1?=
 =?utf-8?B?MzVYR1R5TUVUa1ZnR213K1EzVWJadWN2UXJsRUJ2M2U2VlUwQU1jNVBRamtv?=
 =?utf-8?B?RTArQnczOHJrRnViVXYzaFRTcDhKdTE3Y2NGbUxRSDBjWTF5emtwM2UzZks2?=
 =?utf-8?B?ZVJsaHJTWThOQ0k3QW9GZGo3RDJrbm95dStITE9RNzhoejIvOG5PRFErZUto?=
 =?utf-8?B?YVVuY0tIMXFZNEd0a1d3dDFGSUNPNWJabTMrcTVWL0htbzIzbzZFSGRJcU9S?=
 =?utf-8?B?MHkwa1JZaVJUV3VzNUxwVEVnWXhDV3QyTDJEWi9FOU9raGVIZkJRMG5pZytm?=
 =?utf-8?B?ZlN1TXk5cTVIYUdVSVN0czEydm83RmNhTXBPaWYvaENTK3ozOW9yNlRUbGVW?=
 =?utf-8?B?cTVUN0Jvdmw0TzRvK2pKMUFwb1lEbkpaYVV1NGhvR3d4MDJ1Q05pcWZ1cTFs?=
 =?utf-8?B?UFJwN1lBSmNqaktWQWpCMVh6Z1RXS2Nsc2RvMkhUNlBGOHJJczhQa202UHkw?=
 =?utf-8?B?UXFBMkZHN1ViT2g5Rk1jMXVYcE9QdU9xdVBxZVFya05rUUJpR0ZtcktWWmh0?=
 =?utf-8?B?TUJwL2txMHBRUHVCNG93N2NkT0hLUmFGREc1YTN1NzZUU05GUnpPQnJDQ3FO?=
 =?utf-8?B?eWhFMzRVdVgvSUM3SytIUUdvckt3LzR5aEpoTUtub1NHQ2duRU5DdklPeG0y?=
 =?utf-8?B?anJLUWQxcXdrNUhrUlQ1NzhHeFltNEpabllKdGMwODUyQkNCMVI2UUtsa3c3?=
 =?utf-8?B?V3p0a1VSdHkyWHN4Q01lMGdyOGhnSkRoUWovSEY3QlFBOXdaVlFVRjNVZzlq?=
 =?utf-8?B?Nm54Z1ZVODlEdCtlaGx6c0hjdUQ5aDlxRnlHVk9QWCs2Ri9LeUN3UWl5VU9I?=
 =?utf-8?B?SE16QnhGZ1hkMHJvVU8zZDUzWjk2cFhISzlRMW95V2RNVUF3dGx0eVA5bkFT?=
 =?utf-8?B?by9sSlVJTVF3UitJWVNHUW5CeDlPelBvYzdPQnorUWI3bk02aTRMVGtFTExE?=
 =?utf-8?B?Zk1FU1p1K2UyK0FESldrdm56SzFmSkJjVzB4eXJqM0lRRVArVCtjM0IrbThB?=
 =?utf-8?B?bXh0Qk1vWEtibGFqSUJTV1NqT01WQjZnU08yM1Q1d2kyRjJCTFBwOHlVOWtp?=
 =?utf-8?B?U3RObGlCN21jb1l6OCtBRTNHaUF1ckNlb052ZzRQWEpHVmVXWEZzTnFjMUFn?=
 =?utf-8?B?ZWg5QklPenlpRW9naFVTcDVLcTZHTHpHQWFQWlFoVit6bUFzZWJzTktIMlJy?=
 =?utf-8?B?UmNSK3VsVXBkMXRSeVFYbUFlS3ZTTVZZWEFaTkRMSlEyaVFqRDE0Nm1JTFpK?=
 =?utf-8?B?cXNCandvcUhHRkxCRzV5amdKQXE5UERJRHl5K0JlbGc2ZmZBdXJveU5HRFFH?=
 =?utf-8?B?KzArM1ZjelBTcW51Qm5zaUM1b3l6RXdqNE5VcWQ2dFF4TUhYVzBJay9XNEZT?=
 =?utf-8?B?VUIrMlhmVlRQSVh2K0tIY0FNSFh1TVhpaEE3d0MxYXplV0ZaMVN4QVR0amZo?=
 =?utf-8?B?cWM3L1o1bUZ6NHhLdEJiWWhJNVFuVHJSSTJHN1VoVjY1UktTMzBGRDJHUXpl?=
 =?utf-8?B?WTFzdnJjbmxURlN4Q1JvcU5SWDhyMzlCODNKODI5cFZMcko0T2JsQlVCSDBo?=
 =?utf-8?B?YkR5MmJNLzErU3E2TjNVK0ZEN1Jab3BlKzRJS25HQ05ScE9JUEg5VG1vdXdG?=
 =?utf-8?B?MitZem1BU3NMU2lVUDN4Znl6K2ZBVWpDeE9BdVA3bnRDcTZaUmFuVHV0S1dX?=
 =?utf-8?B?S3p1TVF5T0ZwcVBHaU10MHhUMVZnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6R00VBXNRn/lUv2DcXbU4UVRXl7ItI0+korZUqIQe9KIWqp0Ehq29Gv85lwIY6JX47aVRPTW/w7GDsS51NtheFU7mi4lyGnSkSiOS9EoOh70Q+Yu1PII0mYthVvnjtr2wZwX1uAImWGzuszzh8BymfbGqI78fBerKjlF8Bax+fuQQ/6AGC6hDmjdZogjCrpukaco3/ZmuEIftllIW8WFmIGbLKj1aO4NscHNxUzdNMrCIaFldJoFyl4R+uVVye4eA7Vf63Yonsx3x6lEKl55B1LOkrIkPGI/PSGhBylarlfsnXOS1wT0u8gYOqGV9M6n+vBKICHHwjXWXC2LKPSTQ4xAB1JRs876+KdeS86smzGiBspQhjAvZhyreWyxzwZf1RXWsdXkik1mt9CzElgIqe6ShSXtF/gFxeLpqv++6Y7UKLbP0QezGbvZkWYrASEjJJMmlEFimqFUYEE6Xo9u14tU1JJh8q8m5iAXBEP7/sdPXHUKglRnGz1pMAF/SzQzF88+pj5D+8TXppR198Hob+p82o32ATJAp0+hVmQQmRi6GXN/3mFNA7ISirRnbvX07rdT9r6NRwX2GtHgPXZ5BauAwbAImaYuglb5AYAiluU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd69299-ab38-4f33-3c0a-08ddfc19a74c
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 09:55:27.0432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPMBkuBe9j83w2cOUMH9k5puMQJBg7aEVYu/ZCQ7F6+JY1Ep8sftMWa6DQxvWj+JUKZS4fYE43nDwWBQUxGB0Vi9/YQMgTXVDU1fZjNFld8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6558
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509250093
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNyBTYWx0ZWRfX5Lw0+O1JyhGG
 RHVsdbzdOllv/OEghp8kiC1ETz81apOW5EdDd0x8IRrQhy4bmhLA6uBHWzEqpIWWq7m2exQV4gw
 4FKO+UFrb8CHqQ5xzcuBZWvKPf8Nm35j2/O0VATRZFJwotVtWHnAEctkbPItlarCYih1Q3ka4bs
 nIp7/9XZrgZ0NlY2thJI0PNdeQfGfQq/feN7fQdjLKrFQe+fnMx34aeF1dr14u/mpl6VEDD1uwb
 4By/+24mX69PRWfolvBsfLwe+E2riCaZq+ZHIsztu/cGengLLFFGdbB9WRYCCrMQSMreoj/S1ZD
 gQo3JVCTZJxQQE2KORB9hfghZQeSnSjxdTpmDjRCESCl4sEPCbkbg6vhxrI3hoCNg1tiQj1ikD5
 4EIIds6PL/sdg5U0i5Wd6HWZO3r9nQ==
X-Proofpoint-GUID: TOa8SR0yRJfSYRWiD5RwIUv8aSa4QbOT
X-Authority-Analysis: v=2.4 cv=E47Npbdl c=1 sm=1 tr=0 ts=68d51193 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=JfrnYn6hAAAA:8 a=aniYae4j0MgXNfDtpxAA:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12089
X-Proofpoint-ORIG-GUID: TOa8SR0yRJfSYRWiD5RwIUv8aSa4QbOT


On 9/24/25 20:41, Peter Zijlstra wrote:
> On Wed, Sep 24, 2025 at 07:34:00PM +0200, Alexandre Chartre wrote:
>>
>> On 9/24/25 15:45, Peter Zijlstra wrote:
>>> For x86_64 the kernel consistently uses 2 instructions for all NOPs:
>>>
>>>     90       - NOP
>>>     0f 1f /0 - NOPL
>>>
>>>
>>> Notably:
>>>
>>>    - REP NOP is PAUSE, not a NOP instruction.
>>>
>>>    - 0f {0c...0f} is reserved space,
>>>      except for 0f 0d /1, which is PREFETCHW, not a NOP.
>>>
>>>    - 0f {19,1c...1f} is reserved space,
>>>      except for 0f 1f /0, which is NOPL.
>>>
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> ---
>>>    tools/objtool/arch/x86/decode.c |   12 +++++++-----
>>>    1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> --- a/tools/objtool/arch/x86/decode.c
>>> +++ b/tools/objtool/arch/x86/decode.c
>>> @@ -494,7 +494,8 @@ int arch_decode_instruction(struct objto
>>>    		break;
>>>    	case 0x90:
>>> +		if (prefix != 0xf3) /* REP NOP := PAUSE */
>>> +			insn->type = INSN_NOP;
>>>    		break;
>>
>> So this covers NOP1 (0x90) and NOP2 (0x66 0x90), right?
> 
> Yes. Everything with opcode 0x90, except 0xf3 0x90, which as stated is
> PAUSE.
> 

What about 0x49 0x90, which is xchg (XCHG r8,rAX) ?


>>>    	case 0x9c:
>>> @@ -547,13 +548,14 @@ int arch_decode_instruction(struct objto
>>>    		} else if (op2 == 0x0b || op2 == 0xb9) {
>>> +			/* ud2, ud1 */
>>>    			insn->type = INSN_BUG;
>>> +		} else if (op2 == 0x1f) {
>>> +			/* 0f 1f /0 := NOPL */
>>> +			if (modrm_reg == 0)
>>> +				insn->type = INSN_NOP;
>>>    		} else if (op2 == 0x1e) {
>>
>> And this covers all other NOPs (0x0f 0x1f ...), including NOP6 which has
>> a 0x66 preifx (0x66 0xf 0x1f ...) ?
> 
> Sorta, it accepts everything with opcode 0f 1f and modrm_reg==0, which is
> how NOPL is encoded.
> 
> Both: 66 66 66 66 66 66 66 66 66 66 66 66 66 66 90 (NOP15)
> And:  66 66 66 66 66 66 66 0f 1f 84 00 00 00 00 00 (NOP15)
> 
> will be accepted here as max length instructions. The kernel will not
> actually use those, since a bunch of micro archs have decode penalties
> for too many prefixes.
> 
>>  From arch/x86/include/asm/nops.h we have:
> 
> You're looking at old code :-)
> 

Correct, I was on the 5.15 branch.

alex.

>> /*
>>   * Generic 64bit nops from GAS:
>>   *
>>   * 1: nop
>>   * 2: osp nop
>>   * 3: nopl (%eax)
>>   * 4: nopl 0x00(%eax)
>>   * 5: nopl 0x00(%eax,%eax,1)
>>   * 6: osp nopl 0x00(%eax,%eax,1)
>>   * 7: nopl 0x00000000(%eax)
>>   * 8: nopl 0x00000000(%eax,%eax,1)
> 
>   * 9: cs nopl 0x00000000(%eax,%eax,1)
>   * 10: osp cs nopl 0x00000000(%eax,%eax,1)
>   * 11: osp osp cs nopl 0x00000000(%eax,%eax,1)
> 
>>   */
>> #define BYTES_NOP1      0x90
>> #define BYTES_NOP2      0x66,BYTES_NOP1
>> #define BYTES_NOP3      0x0f,0x1f,0x00
>> #define BYTES_NOP4      0x0f,0x1f,0x40,0x00
>> #define BYTES_NOP5      0x0f,0x1f,0x44,0x00,0x00
>> #define BYTES_NOP6      0x66,BYTES_NOP5
>> #define BYTES_NOP7      0x0f,0x1f,0x80,0x00,0x00,0x00,0x00
>> #define BYTES_NOP8      0x0f,0x1f,0x84,0x00,0x00,0x00,0x00,0x00
> 
> #define BYTES_NOP9      0x2e,BYTES_NOP8
> #define BYTES_NOP10     0x66,BYTES_NOP9
> #define BYTES_NOP11     0x66,BYTES_NOP10
> 
> But yes, first two are NOP and then it switches to NOPL for 3 bytes and
> longer (2 opcode, 1 modrm). Where for 11 bytes we have:
> 
>   - 3 prefixes
>   - 2 opcode
>   - 1 modrm
>   - 1 sib
>   - 4 displacement
> 


