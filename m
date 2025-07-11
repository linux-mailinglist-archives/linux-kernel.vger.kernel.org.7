Return-Path: <linux-kernel+bounces-728271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 956CFB025AD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 22:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818A21CA4370
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9D61E9B0B;
	Fri, 11 Jul 2025 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MK9SgULR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0JiCW3h2"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE2919CC11
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752265131; cv=fail; b=psieFJt2kjva3TLMJR19lPnjGyYEs4i31mAeI+JpQ2/cOsfqas3WhKaS4jiVQ6scv04ADsaA+q3aJPlyZ/PAHI/+zLY0/4mfb+lIrMmpe5B22De08rJalaEK/t+TEOvumkg65mzlaFEMZoNEqOQcfhIFMzNY97yk/ZYsMK+Uq9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752265131; c=relaxed/simple;
	bh=yU6NlWx/euPTKheBYc6MmsGqNltmKuX2ddGuZLNwqsM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r1D3VtY62yeIcUvwzV/YfAS21sj9dZZExLaj07+nGQtd9sG9GJWLdzrE50oXxuqCuAalv2YOHJ9BX3VETKONxZIc3Em8FcwlqwV6cXjY8/ePiuJ7Jy9t9kPqoOQVwjD6JqMmnKIFoS5gvG5mH7Ixm8qbrLuvsNCftjmS0VEMvCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MK9SgULR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0JiCW3h2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BK1oYu008203;
	Fri, 11 Jul 2025 20:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0BTkjFj6amAmt+Da2Vkj6yv/9ppKlloawDXZIHSa7Yw=; b=
	MK9SgULRmOtZTaspbY2ROdHEyO9yIWv+MpuSxFfo6D0dkMRwB9nVIo6kIE7dL0zX
	P8dYV+h54PzztRY+LPeugoRni+cqAKJIF90KTGdK2/4N1FNsHtX4zZ35VFXwdRZt
	OezU0JsDMiyvW0QqPsA6rj7h8x0U0+G33wiw5xB+paqyl4f/py3Hyr2g2nZHS4d2
	dIMTp6EHiHfLP/k5tUISeAGcundAF9LExRxsJ9uJ2tLlzVs79NpCrg1j7od7dvfm
	oQEuqkYPyR9rH7kzHFZQ4BHpnt8zWWIijkQd76GtLG25K8gG6hhRkT2kqLWhN48+
	jCsQDTKQgIJgbFiHcdWbCg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u99mr0qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 20:18:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56BJEi0i021505;
	Fri, 11 Jul 2025 20:18:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgdyf91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 20:18:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8IWeMCi/lRXoQd+j1x4CsMad/twcuUcaiejpATCmUFa4ilHs5jafWiO+0HnDptEaTtYuDhyFuCMoJrv8oyq4WcGkRQFuoY3DxKSjtTHh5GljUkwXqp4Se7E8U9yf263KNYxP8TRIt/wgdp7R2OOkz4Yeoy6JJ/la+V8mgYTxQ0vVyTvTrR/JjSW5O8O4XUon6CEcDEZ34IuiWyWfo6b2iztxzN9Act4d2+tGKbLH4BLD3UCTqsPIEOSe8RXd+qEQ/0SYOKOS7boCnOl91GDGDVOp6bkQD0KaumK5yZOkHc+x2VROHAnppZXGIQ9i3OM3fh9ZQsSC75C2PVY4RW3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BTkjFj6amAmt+Da2Vkj6yv/9ppKlloawDXZIHSa7Yw=;
 b=weX1KGPbXCFaHCGQh46QNQwcL9M3MzZwRHG1b1p5oMHNPt9F6+onYq1Zlw0CdYAJGlAG804xzIP4tk9d2mY6v9HJkZWCj88N4p0R2o6Y5++V2XEJCyXF/uCZxfyI3vb774GNlVXqu9//axrtUbw7JwkOmI9g0BEPp3MfocvCrYGVphAQ2Oi2s0vk3Nu1iPtSyJ1XhV4j5Z8aK1eSoQSN5PkQHQskTKOBz6V/zga4LLV3H5CfXjipT59zJPuW9PSTt9LuPUF0PvfI9G9H6BLpPkIUsW6dlER3ncPJ6OzyTFg6k3IaB7xNJ6MC/7lt2zyP43FrPemYGRsnNjR8Thwh4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BTkjFj6amAmt+Da2Vkj6yv/9ppKlloawDXZIHSa7Yw=;
 b=0JiCW3h2fGEoB/S+Bb5dWOPD2dQnIZVNtjO6DUjZPCHt1ybeCRZPudUPubjEuuo9zqlf7OmIDOJV9YdbT7ufX51+fkCH82GP5iU0QfDiDaEtyySZzLkEiCCBr0DTnnzuPI5ZmKtKJhluWSukCxSb7A3TfdQ/waG5uppEKEEncjA=
Received: from PH3PPF517B7003F.namprd10.prod.outlook.com
 (2603:10b6:518:1::79d) by IA1PR10MB6757.namprd10.prod.outlook.com
 (2603:10b6:208:42f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 20:18:34 +0000
Received: from PH3PPF517B7003F.namprd10.prod.outlook.com
 ([fe80::943c:5ede:5076:73d4]) by PH3PPF517B7003F.namprd10.prod.outlook.com
 ([fe80::943c:5ede:5076:73d4%6]) with mapi id 15.20.8922.025; Fri, 11 Jul 2025
 20:18:34 +0000
Message-ID: <76837be2-1938-46c2-b0f2-9644eb8ac30f@oracle.com>
Date: Fri, 11 Jul 2025 15:18:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [Jfs-discussion] [PATCH] jfs: truncate good inode pages when hard
 link is 0
To: Lizhi Xu <lizhi.xu@windriver.com>,
        syzbot+6e516bb515d93230bc7b@syzkaller.appspotmail.com
Cc: shaggy@kernel.org, jfs-discussion@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
References: <684abfc1.a00a0220.e7731.0015.GAE@google.com>
 <20250613030534.3839793-1-lizhi.xu@windriver.com>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20250613030534.3839793-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:610:11a::18) To PH3PPF517B7003F.namprd10.prod.outlook.com
 (2603:10b6:518:1::79d)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF517B7003F:EE_|IA1PR10MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: becd1ba7-48b7-4f67-73ca-08ddc0b81c46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTQ4N0RwRkRnZk8wS05vUDM5VENGbGV0dlYxYlp4WGhlRXhBT2tlaWo1TUNI?=
 =?utf-8?B?MGwzTTdGb2d1bmNDS2JpMDNiSVc3dm5kbndKaC8yQWcvMFk0anRmZU15VDF0?=
 =?utf-8?B?UGd6T000MWtKR3ZWWGlJSmNzR1RzVzdmQmFIbFNEazVnVGltNlVWTUdKRU9u?=
 =?utf-8?B?UWdCZFpMNWJSWk1DQnFLclk5c01IcDk2NkxVbUhkZDVIZ29EUStDbC8vNmRL?=
 =?utf-8?B?dk9lOTZWYVQ0NWNjYzFwUUFHWVlFaHNaVUZVR0t5a3d3alE4cDVSME5pTFB3?=
 =?utf-8?B?ejZ0blZuQ3pVMy8rSlVqWWYrSzJMODdhYVI3T1lRT0plcFZ2NVFrdmRNNkxy?=
 =?utf-8?B?U0xHaWtjdGNaUkUxbUlOSkhvejFYUW4vUHZVT1dFNjhSWk9sTWh2dTZkR203?=
 =?utf-8?B?OGEwWVp6cDQxWjlvRU9ISUZZZ2R1VEZ1WEUrejJsRE04cUEwSk5sdHEzd3ls?=
 =?utf-8?B?SjZJNUY0OFErQTRMSDhqZGJLc3d4cEVWeFduSjJSVHBpUFZmTW1tZTR0cXpq?=
 =?utf-8?B?eEJRZC9KalNLdFBmL1loS2tWTHpUWmcyWjdLOFJ5cnM2bG4rQVpZM1U0citn?=
 =?utf-8?B?UEJyUUExNjRDSGdHZHFRNDlXSTBTaHlVempJN2F6eE1zSGJGQVpmZVFrR2FS?=
 =?utf-8?B?TTFxYnJLNDFBK2lUdmR3enpBWXF2WWVyWHlGTWd5YUh3OExneE04S29aNVZ4?=
 =?utf-8?B?Ty9OS25XSkN3K0xaWHFuN0x3SWVHVjBXaC8zdVVtL2Yrb3F0aHFNMFptT0Vv?=
 =?utf-8?B?NEpNb0pSTDdPajBUajBQT002UUtWRWgyS2tSRnlpMnpIbTlpRzJtOVhMOUkr?=
 =?utf-8?B?V05mOUVDNmZxY3dPUFZidnJiVzRVcWxhV09QNG5yY3NPNm42V0ptNHdVRXY1?=
 =?utf-8?B?OEMvNFkrZjIrZDlQQ0RRcjZTeGxnbkpvaG9XZnJWckZUWXJaUzVCZ1JFY2p2?=
 =?utf-8?B?ekxBRkRhNmJ3d1lCWlV4VjU3RlRzWnJuRkhkbmNHc0lhU1ZJYzVRdFgxeDlF?=
 =?utf-8?B?M05kcEtJZm1idTI5WXNwK0FtQkdEdjVGWXp0bGxuWkJGL1NiV3FrNEVTS1Fo?=
 =?utf-8?B?dGNTYmpZdjhRV3BiYmZqQ1Bzc29yaVNXRW4reUl1UzlIbk1haGswdzFncDAw?=
 =?utf-8?B?R3ZOYkgzUi83aUNISW5DWkJlRUFTZUg2bklqc2tDaGxUTEtaSXdWdjRvb0g2?=
 =?utf-8?B?NFBJeDVCWFNBaGRNSWFTUWJoNHlHRmdGMkhpS2syK244dWdQRzVBM3EySUd2?=
 =?utf-8?B?c01Vc2Q4dk5QWWVPMDR4L05tZFF0djhURjhqWnJiNHJqZmV0akpoSnJHbEN1?=
 =?utf-8?B?U1hJRjZuMFU0czA4U1U4bEc0U3Q2Z1ZNaEltSEdteWJ2M3ExOEs0K3hTM3FM?=
 =?utf-8?B?K0UxMnBQQ1JCR1dncktpVTkvdE11ZXVYUTllQm95eTAvM2FOeEt6UVhJV2h4?=
 =?utf-8?B?MnQ1ZElmNGVWaUJzQkN1WnBGZWM4VEFCRGlrTVVxT2Iwb3VxVUVqb0pvQTd3?=
 =?utf-8?B?cUJDbE81Y0UzVjRtOEp3NnFGNFNlNTJYdW1QekdDWUFlYTU3cUcvYmpjdW9W?=
 =?utf-8?B?VTIvMEM0OFppbEFYcVZ6cHVUSUVkejRNeExJcUgwM01TZFNGVnF2MEpSTE4z?=
 =?utf-8?B?VEQvVDVPQWlmQ29RQkV3UVU0UkVRZEx5NVp1emxkUk12ZTlWeU14bmVwNmM1?=
 =?utf-8?B?bnFDczFHWGVEem5ac1h5U1N6M2lSY0ZaRXlmbHkvbnArNE93SFRyNThYNmxS?=
 =?utf-8?B?cHQ4MWdPdlZUMythRjlZdzQ3ZElUL1p3dTYwLzNzYTllaWdDNHdpcDZiQ0tt?=
 =?utf-8?Q?UviubouI5CY/dvd7hdM1hdFeaR0NXtGuXJBIE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF517B7003F.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGcrTUxoNUQycHd0ZElzM3Bwc2FxZzNTNzFkSXVRQm4zVU5TckNMRmVQRlA5?=
 =?utf-8?B?dHhQbWl3NUpBanV6NU5Ma0E1L2JTcjh0bmxXMUNTQW4vVkNIWTA1aXozbm96?=
 =?utf-8?B?Q3p2am9OekdoMVZycEszY0ZvMmJuMXpxVzFMLytCOVNVaC9PSjNhSTNOL3hS?=
 =?utf-8?B?NUo1T3VzOFhxWk0rRDh0Z211UWlqaEdwM3hOT2FTMnBiUGFNaVhlQ3JnZUNv?=
 =?utf-8?B?ZE1ybXBSWEFLd2lOWVFaSnFYbDdmU0ZRdWhSUlFaVi9UN3ZxaDA3bXhmWW1a?=
 =?utf-8?B?SUxDQ0VKRzUzVHBaNTliUzBiUmltWE0xaUZickE3aW9ON3VIZ0sxYUpOZ2l1?=
 =?utf-8?B?dUNXTzUvWVlPMTRIL0doQ1hqajdhNHljVE93Rk4weTRWd1h4THppSHd3M0Vw?=
 =?utf-8?B?VlJFWm9UWGZEd0U4emhrUU9RRXJMcXZ2NndaNHRSYk5PUXRxVjczM1UxamZO?=
 =?utf-8?B?aHU0azdmU0Ntbko1UytVcWtJN3FyL29WazBaSXJEa2hUUXU3YTVXd2hHQWcy?=
 =?utf-8?B?U3VXNFRQVWpWejBITGtxeCtyTEVqY0tScTgrdE94WHFndVhpdG94aUZxVzhh?=
 =?utf-8?B?bWYxMmRES0VTWHhmRzBZQ2xvdm9jQW9CNUhhZXNuZGhvL2w4ZVluRFpwRHkv?=
 =?utf-8?B?cXh3cEhkQUh2OXhCVDh5NGlzS05HbVphQTFyWnppYmwya1JKUlV0TGMyeXhP?=
 =?utf-8?B?UEdqMWNmak1nWi9HYXlMUkFuT1BZa25NbWR5eElrY0o2QVlEMVpVeU9BNXgw?=
 =?utf-8?B?a3NEL1BJN2FuLzlsN2MzN3ExMkk2R00vc1dSTkhQZGEzL3Q2NFNacGZxM2Js?=
 =?utf-8?B?aGxyTGtpakhEdlBtUXQwODZtUkw0YTN6L2JlQWZTT3VrQnlFK0FCdGIrVlN1?=
 =?utf-8?B?ekxlMmF6T3JRdlpVaWljUlhXR3JocEpySjJNNnp5c2tKTXJGV2JVOWIvbzA1?=
 =?utf-8?B?WVpwQ0hMZjNUTm81Mk56Q1QwcE4reDVVVjhwWjdkZjhvZDBES2laYTJENUpz?=
 =?utf-8?B?OEVrUEsvempmKzdJZUlBOEFtcDArWUlhTUd6OWZqaWt2NCtRQ2Y4eHR5RXZO?=
 =?utf-8?B?S3Z2YkU0SWdTNGdWTWpsR2x3VGhIUzdWRi9ZeklQanBnM3JUK0Q3d1IvQnFr?=
 =?utf-8?B?QTV0ZTFDVnNoenB1WThVU3YyRjNkQTl3Um1RNitCV0RQY0o3eGFZS0s1MHlj?=
 =?utf-8?B?Q1ZDYmY5U3FqYUZ4bUtKUmo5Mk5QWENSNG5PSU5CcTN4OWRjTzlodzgxMi9i?=
 =?utf-8?B?VGhsUWRCaGttNEJBZEZ1T1lBRUF4Q1JxSldaNGpNZTMyZGpWeHRJNFhBbVpa?=
 =?utf-8?B?VitsNk1RcXBZdFl6bDBXMFM0aVhOUWV5bEM0bFhOSXAwMk03Znk1VklKUkNW?=
 =?utf-8?B?bTFLQTZJZEtyS1hGUExsZHdJdlB1VERzb1FXSlpwNXB6S0UrMmFTdmUrUGgz?=
 =?utf-8?B?N2htcGxQL0V5R3N6cTJ4WUVRRFVDaGtEcGU0ZklmUHc2aUN3MVl0Wm81emU1?=
 =?utf-8?B?M3ZCY0JGR3kyaEkwTmhjU2x2cU5XQzFkRCsvVVpDOWVnYzVKMFZFZnlTQTM4?=
 =?utf-8?B?M0R0RGozWUY1M2tab3Z6OTZqMm9xRGtwK09wU2x1bmlpT1ZVMmtLcmhqZkVa?=
 =?utf-8?B?SWp1K3YzNHYvUmlGeVpsUnh5YjZMM1J3a2lKZ0UzRTdVTHQ4VXdyalhYUG15?=
 =?utf-8?B?bFVLMlpBSFFJUE5TdzFudnlrVnBlR0FtbnhJeDhQN3UwajVIV3B2Zy96eUFS?=
 =?utf-8?B?emZHMUNSZStFamxhZ3JoaGF0cVVYVUF5M0JEMzBsZXZoS2FENkRjcGdmUG5y?=
 =?utf-8?B?WTV1ZDJ0NDBiMUhaQjc3WFhIcW5neVhYMVZVMkRKZVZWbm1BMmhQd0VqdzJN?=
 =?utf-8?B?MTQxcTRtKzlQSjgyVzB0a3ZmN2kxUE9tVEN3anViNmM0cFhYb0VYUHkxQ1hG?=
 =?utf-8?B?RGtkN0R1U1AydmtZODB1WHdaQWtzdk1pOXRnak95QnhKMnFuaDNpcWZwUmM3?=
 =?utf-8?B?ZEg2RGV6SFl3NjZtNzQ5M1BxaDRSUlhOdVlrbWpyK2VPMHY1WmpUaCtIYXox?=
 =?utf-8?B?eUdhVy96VXpuYVI3Q2hqOThkTHN6alZqWmVDeitNcFJCbEcvTy9QNUxid1ds?=
 =?utf-8?B?dnhYSVdvU05NbVM0R3NYKzgyNmZIeGFzQzRNN3VpMGl3R2xOUnFmZ0w3NUJG?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3575zRvxRodg3crRs6U7ujWw+HwiaMVr69CirVfccEF/YqH93n+mVrHstSeIfarNP400rbw/gT1AJvvWq+0rZT+vaaGJtopxPGpsi4AUlITWToluwzMySIov+6maIHgUBPjrc0dfuUka9m3xkWBbahHbYmsQoJ1Ppim/6gwWf/38p/dN087JNXrEucI/DBA1OTVOGX9aMaFBoWT2PHP+CvxKCrsO/KSnbF0kr1A/Am41jRqTxuA440oaLJsJGGyOfmcPwyguwO/9jEMb30RnP4iuVxP8J4RMicEqtUtnKkHFDikUyI3I3zpJSx9NL80JkgDcXXaKy6Uqkk/HdRJWZ63jjYlmwG0AwRMtsxqXgyI3N1n6o+eX3FVbSJdgui1LPJ5OHirHwwYuJ/8imGpla2IpasPSC2rxpW8cQibk6YDfBG7LsDPQ1QKw2X+rJfQlHQ2/lOQDhxPq7Q6rjNVHjXBTBAou/d3bssg6BfqlOCfi79eFquDCP5RjLedv7PKtAzzSFCv1gzrBL2FlXEZQp6zQ6D9rKYkSVE0voZCTMLmJG7HwcJHGKMpzGqhOEK1k14FJnx7M/2mz6E9Q/8QjIn0On2HhWjlYKuBtD6Zh6X8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: becd1ba7-48b7-4f67-73ca-08ddc0b81c46
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF517B7003F.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 20:18:33.9301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sEm5TEsWh+uUE1qUiAb/tWT+CER/Uq7I20AoxSE4+eI6ummDPBYj5XuxLzSUvaMA+gwwJY5LK46EPx60KvseOYKuqWJtW2gMvTsY+52Clqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_06,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110152
X-Proofpoint-GUID: extygvNi7OYUGcKZlUi2Tl4DG1k5jdyh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE1MCBTYWx0ZWRfX9idhalcGSTui XiqhjD/v5JpILNkfkaUlsuDhx6IVXmXEY43P2m2yW0lP985PzwCYmbufNB9Y7vI1B7LdZdQmGom CHVZ7LqKG9hATK+/GajreI/ZZI89AdjjBAUgyDOAQW/NT1DTqVxNKbFcO4lwzwDawZNGr0I4JqY
 HfbWMcRdMork6bOSbSFH2zZBT9UuwjjhPWQfU0rhjCVpKeBqSU01FpZtb9sblWVSPjzHHKiK6fV r1sbWyh658Ha4hAqW2ZPtwhrQI8fqIGJxCZi2aEzGPo0DRntQ6TMBfGBe/DZ/f8rZ+jCYR8rxuj /hz+hKg6fZdW5uJBqJ7oMvz9fE5fh6Fxoj0FUxxYqZRAz702a8gQ8Wf+dhwYGjGiUSXuvk2Aj0M
 3hI/14YQac+EVh1oUUzYLZaikefdSOu+n4/1PMF1YUR5ic+pxCNWLnCmi9OgIy/GSDBFnhMf
X-Authority-Analysis: v=2.4 cv=fvjcZE4f c=1 sm=1 tr=0 ts=6871719d cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=yL3PUf6oI2Z7YNYVi6sA:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: extygvNi7OYUGcKZlUi2Tl4DG1k5jdyh

On 6/12/25 10:05PM, Lizhi Xu via Jfs-discussion wrote:
> The fileset value of the inode copy from the disk by the reproducer is
> AGGR_RESERVED_I. When executing evict, its hard link number is 0, so its
> inode pages are not truncated. This causes the bugon to be triggered when
> executing clear_inode() because nrpages is greater than 0.

Looks good. I'll apply and test this.

Thanks,
Shaggy

> 
> Reported-by: syzbot+6e516bb515d93230bc7b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6e516bb515d93230bc7b
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>   fs/jfs/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
> index 60fc92dee24d..81e6b18e81e1 100644
> --- a/fs/jfs/inode.c
> +++ b/fs/jfs/inode.c
> @@ -145,9 +145,9 @@ void jfs_evict_inode(struct inode *inode)
>   	if (!inode->i_nlink && !is_bad_inode(inode)) {
>   		dquot_initialize(inode);
>   
> +		truncate_inode_pages_final(&inode->i_data);
>   		if (JFS_IP(inode)->fileset == FILESYSTEM_I) {
>   			struct inode *ipimap = JFS_SBI(inode->i_sb)->ipimap;
> -			truncate_inode_pages_final(&inode->i_data);
>   
>   			if (test_cflag(COMMIT_Freewmap, inode))
>   				jfs_free_zero_link(inode);


