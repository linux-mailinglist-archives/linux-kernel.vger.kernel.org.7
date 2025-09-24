Return-Path: <linux-kernel+bounces-830374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 196F9B9980C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36AF326F4D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6E52E264D;
	Wed, 24 Sep 2025 10:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ygrixa7U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oCD85DrM"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDF12E175E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758711171; cv=fail; b=a6Lfp90oHV+pjHhK/f/XTJIuBp4Fdmd4N2YZ+hRaPXxmv112oK2w4OgF2e3Bf3gzrjRdrdlmmhAXkzf9v6efOiV3eq55RGqyq7XW6bUZHEPjKh2rstSXKCOZT+ze+3K9aKVAce9xdfTAR65AbQnES9Gd90okAg/OSX+JQzGqWH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758711171; c=relaxed/simple;
	bh=eTAQW3iJDEJY9Qar1rDLzMWGIbOPYsdArmR4gHnjXto=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FJ9rZqLIOEmcJZdQmiuIhzsn8mUgAmElPAPD8NfpmFF2um2a81sBdXOtLebseLVnGGqFSQvginqf2YX6lzCd22Bvkg6G0jQsUcerfUykicA/rXR91ySlfkkBk3tVEcCbnnHIykIFueF2hK4XSLCVbg7UdY0K/8UZzZkDMsE8Z7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ygrixa7U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oCD85DrM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O9MqYr004322;
	Wed, 24 Sep 2025 10:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VfvX3qgtXCn4d1UQ2qN2vq567Yv07bmqBrwwZnFnhYU=; b=
	Ygrixa7UPRZ2DDsu44tj4kFz78BMgpCzkSBxw/z86v8UK/CtgNNPdOoipWd/KYRz
	hPCkf9LY9ZZK9OV9wUbJ1+dqUZ3PHemyaZ9vi5YBS2PlNi0tMmyG02nZlHmhG7ln
	DXXz1Z+wgEoiosCzDdVbQicrWNWrBBEF3DaFpPLnyVOZLn/7vNoqD87XxBabegVs
	aJTXEeUIazEWun2CIOll1dLmxU9cNSZ+NR+2/q2izzgGQp+Qaz4v04xyeT/NdqX9
	q3SXAvd+Z7xDqmX3RwY1I0gBfPMwsqDVND7dmWctSALo7Af05e+a2jSKqj340awE
	v6rMAb30CUmAhsON+LrUUw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499mad7gru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 10:52:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58O9beY0030819;
	Wed, 24 Sep 2025 10:52:43 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq9scev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 10:52:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7aEFrTFI18w2O1t+O0yDX9TmjwcTUry0FsmU3N6TJSRohDuEK966OH7Ub70G1442cgvWkqYiNtjdTX0slu/vsCAsSA4C8YuoD6c9PTo9zljEiy0EJ0TSiqkqtVvMl+0BsZKqp73vzEU4hycufsfkUh7Pqk7R2EBWOOsyd2rd9HFjuIb3YI+uRQAGWtu/h7HD/MLTzyTu+xOZHTepLtPlX2kdrYtyKIM2237T4ucuUODPYDGu8gq6Y2i6f2ccYwZPgEZAxHhCbkJnMlSBsjh7jMMXpf1QxPXLEX9Svv3SS3JLsaaFDbpkGgyXxbAJ6B2zxQR26MFBk53xkMBlElAmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfvX3qgtXCn4d1UQ2qN2vq567Yv07bmqBrwwZnFnhYU=;
 b=qdwj1zFfBWqivmmsTEtk9Nflu/EAzOGkYeXzk7F0i6KKynK8etMonpate38psIKYIV9w9y48yuZl9tWDIic+9TIBWr+u8K/Ib1BN5dEMmCWNn38OOi5pdQ9zyEqpzsy4GACOqt3t0EcYIVhHOT1ZDuIe8j8hOWyqqE7VkwSfXrK4IYbxddE98jMpd8z25CBwp9bYg3oUToFN7ZBymQMSd2wChWBIOJU7fZ71pCNydX5RZyli65e9NTbIBSdBoBAYzxu7ATb9fb8lzVjT0eatA1rItatms0vo7VqAEBb9j7g6Mk8UyQEuzkg+tP5BZSmnN6Kr1/BrXt25pMkkVBOMOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfvX3qgtXCn4d1UQ2qN2vq567Yv07bmqBrwwZnFnhYU=;
 b=oCD85DrMy4oSyGevNx5kPz7zA/j+HjnBLf1pgZxdQaeVdA/WSIqVRL5+TxuB/2pmvhcgrZI6voHjtA4OGwTHu6Ky2aVSU13MDIAj0VZUx3AFHekrJwHTJ1RECO5l9BNzNM6FvOAaGdsxsrxBscFEyjBd8EW6qtJFbosYHws9ZL8=
Received: from SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18)
 by LV3PR10MB8177.namprd10.prod.outlook.com (2603:10b6:408:289::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 10:52:39 +0000
Received: from SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084]) by SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 10:52:39 +0000
Message-ID: <90abf24a-326a-4215-8e13-2e1a2e3194ea@oracle.com>
Date: Wed, 24 Sep 2025 12:52:35 +0200
User-Agent: Mozilla Thunderbird
Cc: alexandre.chartre@oracle.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jpoimboe@kernel.org
Subject: Re: [RFC PATCH v2 00/17] objtool: Function validation tracing
To: Peter Zijlstra <peterz@infradead.org>
References: <20250619145659.1377970-1-alexandre.chartre@oracle.com>
 <20250924073649.GT4067720@noisy.programming.kicks-ass.net>
 <20250924074206.GW4068168@noisy.programming.kicks-ass.net>
 <20250924100847.GY4068168@noisy.programming.kicks-ass.net>
 <20250924101038.GZ4068168@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20250924101038.GZ4068168@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To SN4PR10MB5622.namprd10.prod.outlook.com
 (2603:10b6:806:209::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR10MB5622:EE_|LV3PR10MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 897ae02a-ffe5-42cb-1780-08ddfb587ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFNJSlE3dUo4ZFpCT3BhRlRTdG5yUkg3VHIwbU1hOGpOQy9MbnBaUmc2c3Rk?=
 =?utf-8?B?bXlsbitML0V4Q1NlRGdHcTFjMkh1NjJ3aTl5MGtoaldiRHVoakpkb3B2eTJS?=
 =?utf-8?B?VVFXTFI5VVVMeFdkamQva0FaNXcvTTRpOUZZSDh6dzBQZHh6UFc3eFQ3T0lL?=
 =?utf-8?B?NlI2elVvWVZPK1dVS1I5c3pjbmc1b0R5dHFobkNIaS9RamNJTkRTQStQckZi?=
 =?utf-8?B?eHVsN01wTHU1d0hHam45WU55YkY4ZDEzM294Q1lSSFNhbXNBTGo0djY5WFBG?=
 =?utf-8?B?YW16NU5WMUg4VmZNWVNGU2N4cmNadFMwZlNyNzYyVDZ2UXEzaFRvbURra0dJ?=
 =?utf-8?B?T1Nra0tYbUV3SkNFbDIyNGZsc3Z6Yk9abVdJOGxhUXZlKzkyWW5wRTJLL1ho?=
 =?utf-8?B?UWxSSTErYUZ5b0N4MVphSTFpbkFBU0NTa0hERTdhNWF4N20zM1NMK2poejl2?=
 =?utf-8?B?QklnL1VxdHdCWVpPSEZKMDUzbERWL0lEQUFRZ0k2b2xkSTBQSzN2ekF6bUZk?=
 =?utf-8?B?M3VUZFFFd2hLcUczVnYwek85N1dDUkcycEtYU0ZXbUtJZUJOUFdUbElsQmZ4?=
 =?utf-8?B?cVVBenV5OTM1THhxK1NtWFZSTjh5VGU0MGhiMmlQZVFYc3dMa2JMMmdIdmw2?=
 =?utf-8?B?SmZUcVArdmlhbFc0Q05lNFVSbUg1UzdZZGdSRjIvczNuZHhFZ0VDbFhhRTI4?=
 =?utf-8?B?REdheVAwcXJGdkZJbDFkMkhQM0V5TUllUVdIZXUwQjZDdEJsbTFLZm1tMmkw?=
 =?utf-8?B?aEtUU2k0cDBYQ2tGMTBLUG9jelhldlF1WGZtNWNTN21QOFQ1NmMrR1FsV29m?=
 =?utf-8?B?WDYvbmNuS0l2akFKZHNkMDFhNy9LRXJkTlEvbE05YkxzVmtFT3U1d2RPcGZZ?=
 =?utf-8?B?bzFTMFVLQ2VvVHNVdmdOcWxKUmFCSityS21qdEg5OTE5MEdWWmh4dDFuMk4z?=
 =?utf-8?B?Y05TSHJVaHhIZ25jWmxxLzBpaGk4QzBBR2FtSDN3dmdiam9VTEhKNzV5MUw4?=
 =?utf-8?B?RHBBSENNU1A3WFZxSDhCczRreHR4NTZSUUhKeXdrRjZpaWJPZkJBZmpOM1FB?=
 =?utf-8?B?RkZaY0padUhuakptTlA1aGZ5S3IxbnhJci94TFllS2lvTStJYVR6MGFCZzh2?=
 =?utf-8?B?akY1bE4xRFZhWFZNVzFiTy9uSnlna0VraTdaeXRQV2U2dHYvaXRSNTRaMU9o?=
 =?utf-8?B?b3liazFSbGludUVFbGRvQmEvRExxMEFxVWZpZmNzWFF5NGg1clhXdk1jQkds?=
 =?utf-8?B?cVlZdEFsYjJwYmtZeTkrTTZ0QXI1MXI3RkpYQ2J0dnkzbW04YTRBeThIUGto?=
 =?utf-8?B?Q2FJclJ2dEJIUWx3UkF1VFFFRUFLR3pmZjVSWFV4ZWJzV3RDY21wZVRFTUky?=
 =?utf-8?B?SUZIdTlpQm9VUnFKbEhXbjJZcWNzdUw5U2hTdXNrWFRCemtIQnpNNVNPS09G?=
 =?utf-8?B?NEk3OThEcm85M3gyR0VsVmNqWmF3OHpQT3REc1dmT3Jwd2huQkRxRVJ5VUd4?=
 =?utf-8?B?R2ltVVlBQjdESFFqaXByV2hnTEp6U2xESzR6VXk0Q0JtWU95V1ZnSFFXcVhh?=
 =?utf-8?B?czlkQUtpYXZkNm0wQ2hBbEJZVW5UeHpPUU9HSktBTzlTYndOeVJaRmhwRmNS?=
 =?utf-8?B?T2p0OXN4NkZvUU14L2ErdHBXQVJXTUlsOW9BdlZ2V0phajNPdmhWVmlhWENr?=
 =?utf-8?B?NGZZMjJmdjVKbU9BY1U4citYMXFPSTdYNGp1clcxcmZ1V0szWXFsWE9BRHAz?=
 =?utf-8?B?Z29oUEZhcFI4RmsvckQvWEpMZ2prbFZ5ZC9zWkRPUG5CWTBhbnlhbFZMRzhL?=
 =?utf-8?B?TTdRUlNyQmZXL2lXNThZaURUdUp5ZVFVN0F1ZExhdEVoM1RLRHE3cU5KSlYw?=
 =?utf-8?B?NW5RbzZZZDlPeXc4ZSt4NW5ybWZJdkNRKy9NUC9FVDVnZkxDYjRjM2xFWFJY?=
 =?utf-8?Q?gWrhABTRU6E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkhUK1hYTVgydDFzQWdBeTljRjdBeGhiLzlablpLTml0bjM2SWdpeHhBam1K?=
 =?utf-8?B?U2dxbUtGbDlhUENacEpjY2RoR0JaY0FaY0gvc29uMnBnVVhSMGZOS2NKaHJG?=
 =?utf-8?B?QzJUclM0eU4wSzBQTGU3UmNjSjMyQys2U1RYai9aMzNPQ0VJQjVnR0Mwa0h2?=
 =?utf-8?B?WDdCaTNIQUVCK0RCWm5KekR4UnR2WVJIWUJTZm9jc2hjRnozaFhTOUV4VkRv?=
 =?utf-8?B?ckJPTkpZUWFYQ0ZBOE1KTEdpTzBleVFwTUJxQkZzR1ExclRpNE9lSWxuRnhC?=
 =?utf-8?B?aWx2RDQzcDNveGhYeVZTWExSd2VqVnBweW1oRk9uTXdEZFJRcE1uTGcrU2lW?=
 =?utf-8?B?dHpidnVyMytWaVNtS2pRVlVSMTE1YUo0bmx2UFJHSGMwT2IrS1hFMGJ2NlpP?=
 =?utf-8?B?UFVJWlVCQWxEVkVCR2w5NnpXUTFKVjVJUDN4dW5CZC95eDU3TUJqNHR6VG04?=
 =?utf-8?B?clhBZTVEV0dHeERwOWh3blpoa3RqcnZYMTZ6RFZkMlRNNUE2SkNNdGpCd0ZF?=
 =?utf-8?B?MWd6Qjltd0VOeW5vekxGeFBzOVRhUlFNc3lpWW4xSW5idEdzbGJjSU8xZlQz?=
 =?utf-8?B?bHZDU2NXbDU4amx0akZ2SUl5MzJuNEtGdERBQVE5d0F3RzFIVm1Ia0ZmdXBa?=
 =?utf-8?B?MjhpNGdNN0N4WHNoeTFySHJIbDhIR005cCtWZisySGtaQ0VsRjZuczZzL2l0?=
 =?utf-8?B?M3pqVUJyb0wxRkp4Z2F4bWs2Z1MxOU40Y1ovcEs1YzRwbnd3UTNEQ0VrcERt?=
 =?utf-8?B?ZU9lUUhsNW5LN2x3NWduaGh4V1hNQ1VRaVNaR0t5bXF5UkZ3Q1dRdkpOYlhk?=
 =?utf-8?B?WFEreFlaTGw2bFpjQ0hUTDRCYnBITGtPdHdzV08xSDY2L2MvczJPMUJSMTJu?=
 =?utf-8?B?K0xkdzJNNzJUSUhDaFhycGN2dTg2LytyY2ppV1hmbE5DVUE5MzFtRDgzb0Vj?=
 =?utf-8?B?aDczRnNSc3FsKzEzUHkvaWgraTNBbUJVTVpRTlRITk9qcFhMYVN2eVRlaHVh?=
 =?utf-8?B?SmRNb1BBQmNrNko0V3diTXh0QmNSbVhucGFwOC8zUTcxdThHSHRRdmR3NmJS?=
 =?utf-8?B?WHVuOE1JQ3VpdTlpRmwvQlQ4NE02RHRiOE4wZTQwMGdZYTlyNjM2RjNkdE1y?=
 =?utf-8?B?aFlkMzJ0TEU1cTE3elJzR2NDclJJVlYrZFNEZktTdHA4U2E2NVJ0RWlia1di?=
 =?utf-8?B?dFBPbE03c1JVMlZST0plZDI2VDU1ZTRoWFhLb1lBbHVSaEx6ZDBLaTMyZXNq?=
 =?utf-8?B?UUhPTHRXQW9WVTUwUTN3ZUZUbWhIbTFGNGo3MTdyOVhsQkpzSWlSMmtXZEZt?=
 =?utf-8?B?VHZ0YTBVU2hHZm9qWkxkRFU2NGpub0VLZE1tbjhKRHp6aHArdncvZkNpWVpS?=
 =?utf-8?B?cTh5THlOZTdnclVlV25yWUpJeWFSSGJTTlNKZERzTGY4M1dKYnRtelFSbjI5?=
 =?utf-8?B?YXF5T1Z2bWsycmNVdkVoZjMyWWpwSGVla1hrK2NDZVliVUpiU1RPTUl4QlQ5?=
 =?utf-8?B?b2Z5QTNjaGlST3VHVm9hUHVEZW4vSERNY1RSczBUbHVqbjArTTUrVk9sakNk?=
 =?utf-8?B?TFQ3NkpmeG90WEtrTVZ6N0FtK3l0K3JIQUxyOHlpMU5nU3JzSU05YnFKT0VU?=
 =?utf-8?B?RlhmMWp2a0NDdjN4djJCTXY2ZWZmUi9WQ0JVK2JqSklydm5kUEEvMVFHYWJT?=
 =?utf-8?B?MjlSMTErSFFQWTBmNDEyS0ZrMEt1UHRZTHBiN1lrMTVFbEhhdlNoWG1FZHNm?=
 =?utf-8?B?TlNwUDB1MStOa0QxSzFtOS84N0p6YVUrSVA3enp0YVZST3dzN0MwM3Q4WitC?=
 =?utf-8?B?NUNzMDhLOVNxaUNuZ2E3Q21zTUtLbmwrUVpGVnZmdnM3bzIwbUwvM2RJRVJo?=
 =?utf-8?B?eUE1TnowS1RkZlRJakZIcXNJd3didngxVFlkV2hVa0hHYXhGVDcxL2s4OFNK?=
 =?utf-8?B?VXBkZko4azZCZkYzSWFXempwZkhNcHRnTmF3S0EwVXR2K09Nc0NDL1RjT0dL?=
 =?utf-8?B?dVNLZ1lGYzAzYXRjdzE4S0dTakVaSWtqeGNJUzNvVDk2V0I1eFZUcUFaRzE2?=
 =?utf-8?B?ZkdFcm0xU2J5bFdCM21ITmlmRjhSemxLdVRZa0VGNHM0ZGFrazd1S2FkZU91?=
 =?utf-8?B?OTN2M2tPU2RSemYvbEJvUzI3WWU1ZmhWZHJSRmMwby81ZEJWem9JNEkzQUI2?=
 =?utf-8?B?ZnVGb05NVW9ndXppZUZXRldYeWRMYmI1TTNlZjNLVU51SDExRXBQWjNKbUlW?=
 =?utf-8?Q?jqAW3moXlpCtmEBwb/qO/jEYGNbhbbjcNlqcw9cJKo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ocZDKQpVQ3b0GhMD/BekE3tcfegTOlzfnwBMqR8iNh1ZQd0Ct5AedMtzaMwldLWm79c68ZHbCnRTx4sLOfdw/IRnm7+AXBkzpY8oj62VV9AGEiSbQ6OGcXtlEJg8mHPpHan7S9j4HxKsUDvg6ezzIKgPX0F7EG/BqH1T0IsQ8t0CMPDOdcpAE1Bwc+ugdKbpk7kjsqpeiJdOzSn2C2Z/kS3YcRfok2ngz04HGjMcKFx3S/soJjo1MpF8BsT7mv2ybLTkq4rCZ5y3ko8x6Z7P/20gIK96gK30+UKXk/RzWq+mryay+EpNOxj9f/CyVAbDwg+HRUIbc4f3UB80N0qUdSw1zc8nmiWtDlf1eSJ78K0hazRIFRBgDtkUL/kmWJZEMh2H5G6KkaPShdcuA0Tb6exzEO4I4LGpMXgYRR/P+3sudB+JJLFhsrXYdVzZCfmm2QJnk7qUP8CqhwEKn7vB59GrfUaoiBTNPtNSVl7pqj1vGqbGOeD6bFYe2a/UDul3vbB5R8a3oZPe+pxvdP15CacwxbNPpyvTJoL2oWzJeOR6dYbJ3tlr+gwWOzGiUk1in+ZXUyszOoM9S+myhfi73+PxaG6DTO6ZyT25n+QgoaI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897ae02a-ffe5-42cb-1780-08ddfb587ada
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 10:52:39.6109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fqPRT+ky65qSp7T7Em6sLJUB8eHJ62q7bWb1ZAfE9pDFRqE+8U5OttGWoYl9YqTUVcgBD3RiiCIQuCcqoM+Zn/EuoSNMRj3KrClbnQm+3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=770
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509240093
X-Proofpoint-ORIG-GUID: 7MgBXob6BxUCJRtKieagyFZo1qsLhJMV
X-Proofpoint-GUID: 7MgBXob6BxUCJRtKieagyFZo1qsLhJMV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyOSBTYWx0ZWRfXxgW8xUyfRdny
 mPtGFbTBDpugVyMr8Ni3xONwJMWpZw6Sk1ZrOUprzcTpsVMPkejQMFl9S21ptcICGbnkW4UwdvA
 B3V8QvGVCO0PM4bzluHbq/SA8VDRSHLagpRkETlYVKz/RcRrhR2sqwLp2K6qEuwUupYPfzub1jw
 R2i/UHv6XbKzyIPWmbelgyQNooUJscn+XUQornMu+tLZ/cfHo7RmwpfLwCjo1mXsgRJxmxEBS0V
 /E5My7LXDt5KxLVVchxoiu83sjpTmpERTtWXo41VLLAbVE+kd3fqpgiTjpmWCYwKHubbboSAULk
 8PAJspcGuDU9CfVtKhotPYUXuiY5SumyLSR2OaidHw9SZNjjEInhArDFnnXayop0zOBi+Xh4dKU
 NU/EaB2X
X-Authority-Analysis: v=2.4 cv=Vfv3PEp9 c=1 sm=1 tr=0 ts=68d3cd7c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=iALoRJRVoE2oycEWPNUA:9
 a=QEXdDO2ut3YA:10


On 9/24/25 12:10, Peter Zijlstra wrote:
> On Wed, Sep 24, 2025 at 12:08:47PM +0200, Peter Zijlstra wrote:
>> On Wed, Sep 24, 2025 at 09:42:06AM +0200, Peter Zijlstra wrote:
>>
>>>>>    d051:  perf_get_x86_pmu_capability+0x51    | xchg   %ax,%ax
>>
>> That libopcode is 'funny', isn't that typically spelled "nop" ?
> 
> Ooh, I see, it is "osp nop" and yeah binutils also seems to do that as
> "xchg %ax,%ax".

Yes, "xchg %ax,%ax" is NOP2 (opcodes: 0x66 0x90), "nop" is NOP1 (0x90).

That's one more improvement we can do: identify NOP instructions and
display them as NOP<n>

alex.


