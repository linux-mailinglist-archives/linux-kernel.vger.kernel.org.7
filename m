Return-Path: <linux-kernel+bounces-765618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37074B23B58
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 23:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C78606E5CEB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB732D8363;
	Tue, 12 Aug 2025 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YyQhsAJQ"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF5C7081F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755035794; cv=fail; b=CxVaqx7xHdkqAP/OXY3AKG1miqnjvwalJibA9kHlOjzGZbx3gX42/8L/DNcaJGTQnDM/NT57lDEGddknY1me9CkvrDkM+eJn41p+hdxQYcK+T+oakT8CgGAZgzPaT/XWTfSmCYUKT571zrsExVR8Gj+l4c6PtWrS4SEnoqXq570=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755035794; c=relaxed/simple;
	bh=JIhxWsfG2WoT+06ebWpyBl325SYeQM+oM0kZXKgTL+w=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=sFfLBh+uAoz0KgaY38YdeA9hLKJqCpwcMfHLlE6sFc4DPb9l3xC0M3pdwZooTKOB8RUB8+CapVgk1W77TIG8bcQTWG+/7bUZZ+4A/d/FoijlSyq63MP3LGM2+KQvX+l7UheSCvbjMsDiwBqFoFEp3MUv5ycoX822hejwpiI8nuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YyQhsAJQ; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7gBxm1iD6LrGAAUPWnP8lHDGCqgQtInq82+fca3PMfjb3C2HsnGJTAp9iC7z8b/jb3ZQG1iG54FTK00alg0lNp50pYW9fE+8eR24gasPIfSd/T4a2eTLVqqG/hMuAl0HA1p1hnNUEZwddv2C7mzMskdw4qpNkSXkXIHrBLQT7SDmMz8qimR+cF0qje0iQFC0a13p41buyLqcA0nu/VkiIzNZxd2YyzueXmiWIEwd1G/A7PHiQP+cCtG5DdrD3FlyqOE3INyf5pvvTvMcg6bkOv0JYV91EJRl1yXk6Ts8fnTdZzetfPNrrOxDBolHm3mRjpfUkld5+KFbJnXDfIBgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2g6Ebc7/AvwDUcIwxhKRCOIMi9r2QZXmiF94YqUHQ4=;
 b=qr6Gw42Jhtlytl0r/CL1bAYXwzQWo91LrqYX7bvPHfEIBlKYq5TEfkQrOzSojkWXwTM+dlxnK3fOwGBsCvm4annjpuvrxeOitRJBpU6cGaDCLk0VmMVPA3rOCvP8FY4VAAKb8jn6mBI0dbZg+cWFxh03Zrk5StFZNddeqMmpeiKp8G87Ckc/9JP87nv/2Rnz2OKv7VrNtW9VGCLvz5fXXGFlqEuYJKoQv/Eam6TASNdjNneUFtG1ToNbZpyiAE4taczjCFVrPBvbNwNg2SvpIMHoAHxxK6D1JoBs+s+LyRly7zaAMiVQQtoa8aIdg1OK643Ffnx9sUEP2rMNiijnnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2g6Ebc7/AvwDUcIwxhKRCOIMi9r2QZXmiF94YqUHQ4=;
 b=YyQhsAJQDLOQ37nH4GUIMB0y8yZiDVVzE2iUVcN38/GW57WQZVpybPWpU/Oj21Nbeo1pgdb4fuun9di+aJt6JIbskKS3U2oo1ROdv6jHzi+YEgXKToNNiZjbkzp08iPsmgEvW4CkoESSh5OS6BMOeftJc9rplIvvXSERmLrsInE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 21:56:31 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%6]) with mapi id 15.20.9009.017; Tue, 12 Aug 2025
 21:56:31 +0000
Message-ID: <b88e7df1-7946-21cc-db0f-d5ce9dcff9b2@amd.com>
Date: Tue, 12 Aug 2025 16:56:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
References: <ee4e9ea71713cee72bb637e848c6a272f8a9e631.1753290066.git.thomas.lendacky@amd.com>
 <20250812213718.GIaJu0DgbRbBq2mfDY@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] x86/CPU/AMD: Perform function calls post ZEN feature
 check regardless
In-Reply-To: <20250812213718.GIaJu0DgbRbBq2mfDY@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::13) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DM6PR12MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: fe04a187-4c98-4944-87b6-08ddd9eb18b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVdzMGpqNHFoclQxWVo5Wm5WYU0rQnlRZkZ1blQrR2oyMlVkb0IxaWFKUVhj?=
 =?utf-8?B?dFZRd0VGbnlzY0dlOGYrNjBjdWs5MURKUXlxTUl4dkJadk5RY1dKTFA2Y0VL?=
 =?utf-8?B?cU1rMlVxdXhSWVdoaWJiQU4zVWxiY2VRQ3cvWFNZd1FBK3RyUTg2UldKZnYr?=
 =?utf-8?B?L2Fody8vVFQzWVA5YUo0aDMxSEx0SE5CTTZKTDY3bEtLWE1scElncTNMMjM5?=
 =?utf-8?B?RDIwdzA0S0JjeTBqS3JpUXhGSDdaZmlFTUdRL05vK21mNDJDZDIwNE05eHZr?=
 =?utf-8?B?cG4xZjFaWGhNMUtGdldnYkdQdmoxZi9KeHZvQWlnOG5rRGJ4NFFBZnAwUjM1?=
 =?utf-8?B?endjKzBITFBMcExJTzBFU0NpbUZNZlF6dUIzdHRUdzNVMndaYnVFOXozSGZ3?=
 =?utf-8?B?Mm1SYmRqR044WnJmNURzM1pzUE4zVFVDbkEybXk1ODVjcHh3VzVSTG5nbkRn?=
 =?utf-8?B?YnBkSmdLY3V2Vnl5YzZ2aEJVLzlCVnBEbmZuWFlhcmR6TmN4V2p3R3NvaXhJ?=
 =?utf-8?B?TDdpVHd4YkVaaTZHejRtdUdIZnR0cEwxanIxWkhkdFBwOU43ejdoWDZ2UjlF?=
 =?utf-8?B?U2dQcjlzMnlraWtDSUE2MzdseXVJalhRUG9weWVWcUE1NmNvN2RaQmxwNERT?=
 =?utf-8?B?aHppYUlhcUxqOEpLeHZvOEx0ZFVVNk5LVjg4Ui9pUnRCZ21LMmZaakVoeFVz?=
 =?utf-8?B?ZEQxVU1Ha0luMGtsMUZTNUpmaUQzME4xWUFwYlVaRWZkUnhsU2hPY1VMZWRD?=
 =?utf-8?B?am9jR014ZHN2U3QxbzlVL0cwL3BhWWs5NjczbXorb2ZMc3pha2xRNW5nUm5h?=
 =?utf-8?B?ajFsajJxUk5WOVhyL3djcmpVbnVDQlZVN3g1dE1LSDY1QktZblVZTmlUYnNz?=
 =?utf-8?B?M3FSR3pqRk5PckR0TkZQRjZqaGdVK1VxWFQ3WEJqM2lXbEhraDRjazlTeVRW?=
 =?utf-8?B?VVVmT2R0Y2dyL1I5UEwzeDRzOU42MjNrWmtNaktINHdVTjlnTktUdWcrKy9F?=
 =?utf-8?B?d2xJR0xGd1BMdEJtc3NIOWtpMkxoUWxGb3MreVlDczZ0cXV2NWMyaC9aa2Qy?=
 =?utf-8?B?M1g2QlRIdGJ1U2NEWWpPRWY2ME1Yc1dDREFRL2g1c0FmRzFwSEZOZFF3Yys0?=
 =?utf-8?B?Z09iOHlTRm0wbHBJTWlhekNJWVdlbzJoeHhpQ2VSbzd5TU43dGRqUHR2bHFt?=
 =?utf-8?B?SGJDQlBuNWoxbXk3L1N4UldVV3pub1Yxc0RxS2JJL1E2N1VQdEw1QkljREww?=
 =?utf-8?B?UHZXME1Jd3VPTlRDSSs3a0tLTmpqTzBmZ01KQk5IMnNVOTRkK29KVFNjMzRz?=
 =?utf-8?B?dWk0RG1MNjdxUDNLb1FHSHkwZjk0dkRrL3Nhd2IvalpUcEllQUxra21iSnd4?=
 =?utf-8?B?aTkwVENjMG51QmVFdmxsRDJPVEQ2MEcxVy9uRWhrSFV0Ry9SWlkrWE44MFF5?=
 =?utf-8?B?VjdId3YwRkVST3RiblNYMXVpYnU1VmhydGxuWE05RmZqeXd5SEo5U1BzdHZN?=
 =?utf-8?B?NzJlcHRPY0NSbG54eEIza3FqVENuMmlZQTN1dzJacHNudUpqZVlhREl0QVU5?=
 =?utf-8?B?bzZaYlYvcFB0UVdqSWZVa1VTcFZXK2tKb1dLUFJPdTIxL0FMWE5FYTV6Yjh5?=
 =?utf-8?B?NmVsOUxnb284TnZMZ0hDV3RYMmVDY0RnUU1TVndpR3greURQc2tiQmdTb3NE?=
 =?utf-8?B?eEJBUEdsRHRweGIvSW1DOHFDZHQwU0dKZ0F0SjFMcDlrZEVnRVJuV2xpcWND?=
 =?utf-8?B?UWdWTE5ESGZ3RmxrMEgwUm9jNmpGQU9EOVJ4bHBrazRCVjgzV3BKdjNLMjRY?=
 =?utf-8?B?YVJ5L0gvSHRScyt6NFB3eXhNTDlWN2RCUmp5aWY5TXhrNGQyL05IdTltN1NS?=
 =?utf-8?B?Qll2bVdSZlZFVGdZOGl1R2NvdlhnM0xlRzlQdnBERHA0SmpZRkxreGVRdGlR?=
 =?utf-8?Q?u04MbMESkSY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TS9qZ2NNV0NCK1c2NGFydUhGeU10amxPV3BNQ0M2amZVMERic3Z5U1Nsck5u?=
 =?utf-8?B?ZEIvS1BKakdZQmdGMGNvVnZMQTlEZDZ2eHNLUHpKSytSVkMxZHQzdWcwNG9C?=
 =?utf-8?B?VDBabjY2TWtwaTlOY0NNaWsydHhBUHZVbUk2dTg2VUJScWpESit2K3g4Q05Z?=
 =?utf-8?B?bnFuRHBRc2UwdVp2WUJ1bVBLb0lTd0xHRXlldXlhODhWMVpWUUljOHhwY0Vn?=
 =?utf-8?B?UEN1SHo1VG1LRGVWYnN1a1BjNnQ5M24wdTRjRDIwN2duTi9vTm9jQWpkN1Zu?=
 =?utf-8?B?QUk4TVNuSG9JWWFnbEhJSnpzVXRPek9CeEVSWXQraEtjZWhSTDFvdFNXdjIz?=
 =?utf-8?B?OUJJbnhhNmtCMWNSL3p5UmJCZWx1b2dydzllKzE4aWFOMk9UUkRFNVI5ajlB?=
 =?utf-8?B?TmROSVdwUTJLcnFlZ0RscmVyN2tkdm1hSXMrVVBjNnVPVm03anlwVmtzRnYv?=
 =?utf-8?B?MmJ3Vmp4dXJvUlM2eC9FVFJsbGNHekVQcnZWRit1N0h0VkszdjJZZGpOQkJT?=
 =?utf-8?B?b1MzU1kvUzNpOHdxdUpNM0lOOFRnV2M2Qjk5cTdVT3JETXcreXIwTjhTeDJE?=
 =?utf-8?B?L0NKV1pwdHExZ3Y1UjZHc3p3ZndLV0ppQWdRUDFMT3FXbVBEMzdmeTVnM0wx?=
 =?utf-8?B?dm1vT2ZHMStRTzVtbVlSN1FBUVh0clBQUEZaSU1zTlI3cXhBNE5hK2JpcnQ5?=
 =?utf-8?B?dUY4a05yUlZOdzh1bXJLYS9obTRqTnJrdFlORmJUZC9PZEtWUDJsdXZST0Nq?=
 =?utf-8?B?UWtQL3FSZ0VXNlJNQys4dkdPekNDOWlsUVEwY2lNZ3dSSDNqUUR2UWlCbHVI?=
 =?utf-8?B?ZVh3ZWRNd0RsNUdvQ2pRbGNidXdQc1kybzdZSEhGS1Vwems4MG5QRHZTMDhS?=
 =?utf-8?B?Qy9iZDVWelo3dHBLRlFhTHJtR1Y1TWRBZUU3L3BHTE9HaHV1UUdyT05UR2lk?=
 =?utf-8?B?QmNSZUFXN0ZCU05PTERobnNuOE9uUHgwY08ySFlGZGdpSHh6UUFobmgvRzdm?=
 =?utf-8?B?TzJVOC9zamJKZTNxb2lmaFN1VWdPVUl1aEFZQmlWNGRZTDJiSHczMURwUDRt?=
 =?utf-8?B?MzNneVcxTTNoOFMzNHgxVnZYbXhEK3c2cFVyUkF5SDREOXlJTDdPR1k5a2hK?=
 =?utf-8?B?Rk9qV29hTENXSWJCR3U5UG01dzZYNytiZ0Mwc2xENHlkdWY0NFJ3b1p1RFMw?=
 =?utf-8?B?d2duejZJQnI2M2hPb0M1TFZQVkFhYUxGNDZQRFJ6cDd0OXIveDVDMEFob1g3?=
 =?utf-8?B?YnpqV1drRXhvNkVoNFBRNC9Bd2RYbElvZndtS3R2OEFranQvcXJldFM5NkM5?=
 =?utf-8?B?VGZJVkxNcWxNTnQ5MTh1cjhtbmlPbmVpVGZlQnNJSlpvMGdqb29lcXRFTkJo?=
 =?utf-8?B?R2RzSVZ3RGVxRjRpaDArVVRRM1RPNGVuMnJFZm1EdHR2MGRXY3A0bDNQQzJ5?=
 =?utf-8?B?bmwzMjJpbEZTUzZjMWxHQUVibWNlYm5DK0NBdFAzMTV5WGpuL2p3c0UyU3Ry?=
 =?utf-8?B?akxqamxUYWcrRHlCRG51UnZ6U1NkamxYZlpmcUg4YTVkRXd0SHBMZ2pMNlRM?=
 =?utf-8?B?ai9GbGtUZUdlbFpqK0h3R3pDbGtvL25uS2VkYWY0MEFiNm53Y01relVtM0gr?=
 =?utf-8?B?R3pYSFY0MVlnZGp3WDNYZ3VXVm4ySHlsZDYvNXJNNlNRaWxoUGZ6cmR2ajRX?=
 =?utf-8?B?N3NTZ2pEMmw1SEVNTFZoMVhBbTkrdlNwaWI4K1NaQlhBQkh3Q3JQZ09xNTVw?=
 =?utf-8?B?RisxZUEvUGxFRXNacFh3cFk3bVpwT05jMWZpalNrMUUwYUJFbmU4L2p6Unp6?=
 =?utf-8?B?Q01Wa2lIb3lHdHZnZDNwOUdQN0xNR09tVkZNNEkyWm1Za01GMHZGR1VWbmVM?=
 =?utf-8?B?SE9xUlRNajNrb21RVFhhTytXelRScnBmc1hMVDB0K3dXZjZEVm5PYWc5YjVC?=
 =?utf-8?B?dE50U2xTejd6dlZWRmJhenhST2xsNFZLdHRTZVM0Wm1FTFJIaDdCSmthVDFM?=
 =?utf-8?B?SlBSWnBHZDlxQm94bndCSDc4Kzhnc2NxVDZHU3JFanZsQ0J3L3FPVDE2SG5z?=
 =?utf-8?B?UE11cUgyc2pueERUTjBqd2lVRGJiUmpJbVA3dW5PSWFrOXhxbDY5bWFRK1Rj?=
 =?utf-8?Q?GUZ2/EJvEQvuJmqJ/6Nap3Fu5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe04a187-4c98-4944-87b6-08ddd9eb18b6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 21:56:31.3378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7mFWeZMFPCVxUKxtMFUXr6IXN0jUCTJPqNthY4BHzJzovOlJVyP2XKi3MyWA6AiX0gVonnHYROeyAkvCCnKcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091

On 8/12/25 16:37, Borislav Petkov wrote:
> On Wed, Jul 23, 2025 at 12:01:06PM -0500, Tom Lendacky wrote:
>> Currently, if a ZEN family/model is not recognized in bsp_init_amd(), then
>> function calls after the family/model check are skipped. This can prevent
>> older kernels from enabling features on newer hardware, e.g., unrecognized
>> new hardware won't enable SEV-SNP because bsp_determine_snp() is skipped.
> 
> bsp_determine_snp() relies partly on the family detection.
> 
> If all you care is calling it even without family detection, why don't you
> pull it up, check c->x86 and be done with it?

ZEN3 and ZEN4 won't be set if we do that and since those families don't
have RMPREAD support, SNP won't get enabled on ZEN3 or ZEN4, so we can't
do that.

And, additionally, now there is tsa_init() and the CPUID_FAULT checks
that will be skipped, too.

> 
> But even then: we don't really care about older kernels on newer hardware
> - that's why they get backports. We don't really think about backporting when
> working upstream. Frankly...

Hmmm... i guess? Not sure I 100% agree with that.

> 
> So I'm sceptical about this.

Your call.

Thanks,
Tom

> 

