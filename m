Return-Path: <linux-kernel+bounces-803883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D94B466C1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 00:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83FA05C5731
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84932882A9;
	Fri,  5 Sep 2025 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rgXg0qC1"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBD11B3935
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 22:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757112141; cv=fail; b=CaabMaLOtVbQTj+MqV34fY9fe5tvjTiTidnW0SPBIUjirKpUiPtarI+4F94ZJOtgtgETM23or3VggdVlC53SkaiOLGcWQ/toLmf2YJNEroUtSUYiB7bj1yZ+z5TKcJHMJQ0wACZvIrYFgvPxwt0YaUgS723xkUsNeriq0QQt/ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757112141; c=relaxed/simple;
	bh=i8THVDHgiRJLC0boocs2/W3CZD3yYa8tE8ypERQDBF8=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=UU/l73PG6u1O7q2VNrdkaAICtyj1sthAFfdbXB166/yKoaJ5tp3Ql6Mys7r2yg7gThJUqb15Yr26aU7dOkgyyh3AuBha2Xa81YdZ3zjtahNEIMUICiozh7sMk4a1mpxmOFtAPtjnFOXytrrXZAESE4Q6r85HaqOqVGy9MrTs3s0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rgXg0qC1; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GomhA9+J7LM5J8v9A0UhMl9BnFLrCqLrONxeEFmfGZKYF+q6tebE8ivslqV/eKBPIhx28oPkMaE6OUiLPoOA6FNzOS+RrlRzm+Q/U9c3q//TAqYjrr4nm5wymVpGVWk3ylFaUu4Eo0NsICH11faxvIVPzJDgnB1e/FhpwsV8mXlAAq8ymkiTUilB6TdzKSxYPwbttem1eGqlqmKXc0bMkSMD9Up2mscZt9b1JUGBoX3dAdKn3Hs63AL8mun8eFFybyk26Jn5UHB3YwWxLjwSTiuKI9urjbCoF6JXdVP+kAzni2YM9UcJ6fVSw6EWedbXJ3j0vSdNUsTfmgPrYcFhXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vU/bebcp3HREI3sP9u0d7XhT++cBICW1iGA0162/QV0=;
 b=aypz1LDpSa+u3E6F5zRUk6BX95jvJWtyNlOv8xE7LaJSgJcOyrAR6Ln+bGKYnJarXl4u0Tculex9pKJiFvFqCcZ1eB8aO9M559P4cUoQUq0OVdg4naL/q3GduOL39dmFCv0vFiGhJ1LpAcwylv+fuQhSaLLQ5MBNRjuf2XFo5FMcVz/V4uvCS5/Gfcg/nBQj6RadkGsAk0W87JrvgOSswxDzii4WwE9WUmdZEjtJGd4Yj+KiLF6RYxaYxg3W026xSHV+BCBAaDSvbrV13IdZv6U5vTPYrrPnxyHcLhDQoNYKjTdXc0CBJG0zyAnd8rLn1NdTLZRMjJ9hq6FBJPgvZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vU/bebcp3HREI3sP9u0d7XhT++cBICW1iGA0162/QV0=;
 b=rgXg0qC1ftmaAnQj7teRqtfTqF8VENkHT3kiL4gcHSXCHddttYQ2GzqB2z5CL92AbhssenJaDbwODTBMN+YG27ujpK3AuPfpVX6j6/gL2x/WCgBJihnFe9tcjYCuVm99Emm8DWv+Yxrqcq0EW+hZe369gPBoBQee2wzCOmT27wY9nNTg1Y6KttdgzECZxAKagJGVKh1Dt/GOYUYOjKE4JbJS+CkuPo2jVl4jQaeCrK3vGpzdLlClCpfkOQGEeZhYmgzLT3mWWmeIlBP/Uj3hwosYtL0kfYPiJ1/gvH5dh4gOCeKczCtg0ASviWVWctZ1ebYhWwaZlCVGr59uewqsQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Fri, 5 Sep
 2025 22:42:17 +0000
Received: from BL1PR12MB5205.namprd12.prod.outlook.com
 ([fe80::604c:d57f:52e0:73fe]) by BL1PR12MB5205.namprd12.prod.outlook.com
 ([fe80::604c:d57f:52e0:73fe%4]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 22:42:17 +0000
Message-ID: <ee87cc59-2717-4dbb-8052-1d2692c5aaaa@nvidia.com>
Date: Fri, 5 Sep 2025 15:42:14 -0700
User-Agent: Mozilla Thunderbird
From: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: [PATCH v2] percpu: fix race on alloc failed warning limit
To: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@gentwo.org>, Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::19) To BL1PR12MB5205.namprd12.prod.outlook.com
 (2603:10b6:208:308::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5205:EE_|IA1PR12MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: babcdc8b-6787-483a-1373-08ddeccd7723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3ZTamx1TVpXcE1GK3gvNzlaK0pycTQyM1hQU1lXVFQzMXhEUGZXaUpDQW9Q?=
 =?utf-8?B?djlhblVNeStrUWk5UEttMFhZaEVBQmRtMGFjeEtrcUtHU1VaazY0MENnZmlZ?=
 =?utf-8?B?R3RCejltSkxNVWVNN3hQTmdqdC9YbFJWLzhFejhsUnA1MVpwODZSTGZBZXNZ?=
 =?utf-8?B?Z3lvbzYzN1lxaVRaWnhRNUVORXJybXp4eUg4YTVNNVJjaUt0eERldkkvK2ZK?=
 =?utf-8?B?UGRDN2ZuYTJXZ01PRmZmMmdGeVRQMy9ObFNqdTExaWNkMzlOV1doM1FQZjdi?=
 =?utf-8?B?aW1oUFNlclBxd0JCV0hMR2M2RHl0V3MrbUQ2WmtydlBJQS9mRGlYYU5oRStt?=
 =?utf-8?B?TG12UlJORTRFVWJ6M1RNVVdBVnZqeTIreUp0dURJbVdGZ2JvNGlmR0d0dGxs?=
 =?utf-8?B?bFRLVHJFTDVKOEppRk9CdWNsYkVmRlBkTjJSN0xpUmhmSDBDZTlleHhwSkho?=
 =?utf-8?B?UXprRFpHWmlkVEdYNXdjWW9TcGxkcGZBd3ZWV0FsbFN3R2N5K25HZk40Q2RU?=
 =?utf-8?B?Qy9nOGE4S1VYVER4OTV3Z0s2QmpXWXk5eHRCWGdENFBiRWNOZkN5TTljWU5N?=
 =?utf-8?B?YWNNeVFsc2hYWGFOOFZteUkrWVAweTZvUTdzalhJenVBVGhiZENKWWNla1JL?=
 =?utf-8?B?bm0xdmNlTTZPWE1Na2VHTlEvV2NuQktyMFhrNVJ3anRUY1NrTTFRbkVSbFp4?=
 =?utf-8?B?aDVOUkE1M3JMRFhqWGlyUm40a3B1QXlkOWJDL0pkU2Q2YjJKWnhWaWpYOTFu?=
 =?utf-8?B?TDVxOWhiVWxSSkFMSmsyZVBWcDJtTDZTa1U0QnRsL25zODVEYXJxcHZDcGFk?=
 =?utf-8?B?a1RxaDlYeWtkWkJMSXRQQ0tESjA2aUQ3aUhiZ3BjVG00OC9TWVcySjdUSkRP?=
 =?utf-8?B?YVVhKy9tWUxINFZwdVFzbU9PZDU5L003eFBYRVMySlJPbENoNXpWVnhZK0JS?=
 =?utf-8?B?Y21hd0Zxd0wxMU5IRU1CNWxzVnZOWEFjNDVla3R1Z3lHQ1pRQTg1SEdOT0lx?=
 =?utf-8?B?WjJLYXR5OGR1dVFKWlp2UGxWVmJKZitFWWtJL2NHcHNJa0dkTGNtTFRhdGxq?=
 =?utf-8?B?dElQNnprOWgxM3dnQVVtVWh3cjI2NFBRSWw0ZmZVNUF0eGlLWlpMSWpEK2lF?=
 =?utf-8?B?bFgzeld3ZEZBbjgxMmtNRG8yK0hsVEM4bU9JRVJtU3VXa3ZLZjEwbDJxMHZW?=
 =?utf-8?B?MkpYRFM1RWYwNTVGZlp3Sy9adDRIaW03bXVGeG1CZnk1d2hjVnVGOGJnOFBh?=
 =?utf-8?B?RllLMDVCWFlJeUgxZGIrYTlSbHkzakpwZFVHSWNwS09ncDBwak5nOTNOUUgz?=
 =?utf-8?B?U3ZYdjE1L0V2VjB5d1dTT0x3RkEvMFlHaWRqTU42Ulo3UlJEaTMwcWpqandC?=
 =?utf-8?B?TUNDWVZsVjhTbDlNVnR5Mk5zcnFaeS9Sb0pxR2Q5ZW1NWlhsT0MxVUZZbEZU?=
 =?utf-8?B?d3RqbDg4M0FQdTdjU3ZTZDlLakFwaEdhMGRyZENMdlgxL2ZGM3NXcHIwWlpl?=
 =?utf-8?B?NUFqYmEwMENOTjBDZFl0Zkp5N3dqRGliZXBGa3JnU2h6VVlwTC80UkVaUkR4?=
 =?utf-8?B?eG1ob2U5VG9Ha0x5MnhWWU9MRTd1c2NqeGtyQ2NoaytUdVpjS2xWS0ZnNHBL?=
 =?utf-8?B?NFBSWWNkMDVOSVNhRDRscUU2aTlndjVpMC9ERnRWcDRRWDBIMDZxRHh3SGRW?=
 =?utf-8?B?ZytiSjB6SkNrZW5tejFnZGdzK0k0NUM0Y1NMK3hzemVyWVpjT3pTTEZOKyt2?=
 =?utf-8?B?L3pLMWdKdzhzNG9YcEJualVWQnZPWE82NDh0dlFYTlQ1UStGdzdnL0VHMTE0?=
 =?utf-8?B?RnJ5NDZMeENlSnorOXV1azhaQUJCSWY3ZHBOMVFtNTJudG1pS2VVOTVmRWJa?=
 =?utf-8?B?V1dRU1ZDNHRub0I1QjZoMERMQWkrdXBhYUp0ajlPTW1Wbnh2dHE4SVV0V0hj?=
 =?utf-8?Q?tOXxaiNFJHM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXluSy9TdXlRcGRiV3dZeHF2aThZRjhNemZlRDNhVGlWRTJIL2NERjJwdjc3?=
 =?utf-8?B?ZzI0R1FWL1lDa0RSVUF1WWNHVHhEYW85LzRIenZVYjVSWWxLMzNLQzFkUVA2?=
 =?utf-8?B?YVNuRWdWNFpNNDgxVUhHMVhRUTVMTlFwWWJOMGpmdDRlWkE5RmYxajM1V1Rz?=
 =?utf-8?B?MndpRWYyeitDZTJ5U3AwSHVEY2ZReUFHcWl6SFFIeU1GMjRCVit4KzRVMElC?=
 =?utf-8?B?ZWVlZkFXOUNoREdhb2I0dEdHeDBxVkwyYzdnMnNrQnNIK0ovcnQrcG9jUkhZ?=
 =?utf-8?B?N2ZoRjN4YmI4WW1va3lVaGtoL2xmbFVSOHMrU2dYUlFHWk01WHR1dk9WODZK?=
 =?utf-8?B?UHBBbWRLakJDMUc1cjJqNVJoeWJXN1BWSzVqQ3pCd0laSjRHdlM3T0lSeDFN?=
 =?utf-8?B?Y241OUVhZlZOaGpkT2tBTHRPZks0S29CTHBaV0wzMkoxNk9PUmVxZVh4U0ZP?=
 =?utf-8?B?UWN3ZmZPL010MWY3T01QSE9waUtHdTFrdDhoLzREV1crR0NXUHB0bnBWQlhi?=
 =?utf-8?B?WklBdVc3anRLZUNFRU9VcG4renNWSXU0Ymh5U3poYi9wMzExSW5zcC80QjhC?=
 =?utf-8?B?VWFkS1J3TGNuR2JSTjVRUHBGby82cjZFdEFmb0lHWXpWOVE4aW1kb0FWMUVE?=
 =?utf-8?B?SWZwY3JPMGdLNE8rN3NoYmsxd0I3ZkZaeFJyQXordUlXdEYrMmp1b01FQlhD?=
 =?utf-8?B?N05ERXZlQlROc0duNXd2QmNkYmNRMGM4U0FNZnJhNVZUT3BvSitDZEZnaEc4?=
 =?utf-8?B?bHQ5QVM5Rk10bUR1UW0zQ29qT0dJOUQ4dEQ1aHpiWk1Pd0RkcjJVVVVHVnZi?=
 =?utf-8?B?UUNNTjJmSFBBalhJWHhUSnlFTXhNMEt2bmNhakwvS2tmY2MrQ3dqTXYyN3Y3?=
 =?utf-8?B?ZStvNG1ZNXR3ajRzUzZDdzZVaFA5Z3RoNWhPVmxUMHNkUW9zcUxVUnlhN21B?=
 =?utf-8?B?VXRpdW5oaXF1ZEZDN2hkZ215bi9abTN0T0V0SEx4VzVadFF2aGt4aHZ0TWJ5?=
 =?utf-8?B?VFN1R0Z2TkZhV2laWWxoa1BmTUFuT0xGd3lBUDVWZ2ZZdE5XVUNuSmluSi9L?=
 =?utf-8?B?UG1NMnhwNEVRL2pNRHBEOWxmKzBIVVRNMTRYY3FoM1dvS040alBtZUVCcFZq?=
 =?utf-8?B?Yi9hcFgxZ1ZxcXhWaVRFd29JTWF2TlFZc3RWNzBPTHBjN1I0RzAyVXJVRW10?=
 =?utf-8?B?Q1ZqamZxbkJCbm1UYmF4RVpLSWQwRG1NK2ZzdCs0SHRFRjcrRmpFMXdyNXdn?=
 =?utf-8?B?U3ZYQ2k0ZzJaQWlhRUYwVmYzQUtHZVQ5ZlByeGt2ODV1by9MU3M5VXc5WHdP?=
 =?utf-8?B?Wkc3RytMbThMdVZyRVJzS0E0SkI4STFaVDJWNVk5dXNKYkttS2x4ZGx4c1lJ?=
 =?utf-8?B?di9tSXpCL0VGaWdXQWFnNTEyZHJucld0eUhsOEM2MlNuaDExY1d4OVhSRUlO?=
 =?utf-8?B?ZEdTaXRRS3llOFdOOEU1KzdxRHRneEpXS2JYMHZXdENJWWgyNGpLSmh6U2hJ?=
 =?utf-8?B?aHl6YVEvUmp0RHBrakxOQnJWZFA1bjQ3M0RxYlVJWDBqZW9xdjJaYjd0ZDhF?=
 =?utf-8?B?YjQ5Um1HTGFzQzIydVkzRi9wSXpldklZRXpDOTdlY05tMEYycjdSSFhib0Jn?=
 =?utf-8?B?dDFUMmRWNWtCTlpONE4rS0dEUTZ5d1Qwck1oNFBRd0lpMTI2NU01bk9uTHd0?=
 =?utf-8?B?eUo1SDVZRlJCU3BoOVFzc3dteGk3VzVUczBseitSTGJ1QUhKemI3SjViMVBT?=
 =?utf-8?B?MDh0Mmt6ZTRQeXg3TktFcG1peE5vSVArczZPTklMYTNUblF1OFdHVnQrMTln?=
 =?utf-8?B?aUE5RWNrTEJVWDBXRTNEdzFIWElFaWVSRDF1d0NEMzlmbVlZK0VQMkx6OCtx?=
 =?utf-8?B?MjlhcDBGYjhnRlUxbFp0L0ZBV1RBN2drTEQ3c0JCenhacUI0Z0k4cnVQby9a?=
 =?utf-8?B?L01GUkZDU0hqbmNNODh6ZHM4cUhScUU4L3RlY0UxNDBkZjNWc05FQmZQbkxu?=
 =?utf-8?B?S1IzUXlYNjlTa3F6YzZDQzFvV0d1QzV4TTgzSkd0R2s4WlRLSjNobGZuaXVB?=
 =?utf-8?B?SlZ5YmFUS3YrQ2ZFNTEwZVBPU05qRGR2Nlg2S3M3M0c3OFVsbkg0ZjdRZGxm?=
 =?utf-8?B?TVlGaUh5dHd6bStoTjVzYzhiS1pySmFuaTdyZmZmZ2dLUVBqZFFBSkNlazZj?=
 =?utf-8?B?NGc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: babcdc8b-6787-483a-1373-08ddeccd7723
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 22:42:16.9502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJdW4QaLpdVowfPkvEG0DtHEKuJ1Ue2WxawBN+MOM4G2GlF1cvHBTpA8LDK+Twxjz97n5hkaoyo1cIot5t9Ikw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685

The 'allocation failed, ...' warning messages can cause unlimited log
spam, contrary to the implementation's intent.

The warn_limit variable is accessed without synchronization. If more
than <warn_limit> threads enter the warning path at the same time, the
variable will get decremented past 0. Once it becomes negative, the
non-zero check will always return true leading to unlimited log spam.

Use atomic operation to access warn_limit and change condition to test
for non-negative (>= 0) - atomic_dec_if_positive will return -1 once
warn_limit becomes 0. Continue to print disable message alongside the
last warning.

While the change cited in Fixes is only adjacent, the warning limit
implementation was correct before it. Only non-atomic allocations were
considered for warnings, and those happened to hold pcpu_alloc_mutex
while accessing warn_limit.

Fixes: f7d77dfc91f7 ("mm/percpu.c: print error message too if atomic alloc failed")
Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
---
v2 changes:
* prevent warn_limit from going negative, as suggested by Christoph Lameter

v1: https://lore.kernel.org/linux-mm/ab22061a-a62f-4429-945b-744e5cc4ba35@nvidia.com/

 mm/percpu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index a56f35dcc417..81462ce5866e 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1734,7 +1734,7 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
 	bool is_atomic;
 	bool do_warn;
 	struct obj_cgroup *objcg = NULL;
-	static int warn_limit = 10;
+	static atomic_t warn_limit = ATOMIC_INIT(10);
 	struct pcpu_chunk *chunk, *next;
 	const char *err;
 	int slot, off, cpu, ret;
@@ -1904,13 +1904,17 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
 fail:
 	trace_percpu_alloc_percpu_fail(reserved, is_atomic, size, align);
 
-	if (do_warn && warn_limit) {
-		pr_warn("allocation failed, size=%zu align=%zu atomic=%d, %s\n",
-			size, align, is_atomic, err);
-		if (!is_atomic)
-			dump_stack();
-		if (!--warn_limit)
-			pr_info("limit reached, disable warning\n");
+	if (do_warn) {
+		int remaining = atomic_dec_if_positive(&warn_limit);
+
+		if (remaining >= 0) {
+			pr_warn("allocation failed, size=%zu align=%zu atomic=%d, %s\n",
+				size, align, is_atomic, err);
+			if (!is_atomic)
+				dump_stack();
+			if (remaining == 0)
+				pr_info("limit reached, disable warning\n");
+		}
 	}
 
 	if (is_atomic) {
-- 
2.49.0

