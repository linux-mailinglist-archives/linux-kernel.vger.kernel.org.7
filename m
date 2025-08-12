Return-Path: <linux-kernel+bounces-764854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 064D1B22808
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB41756027B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9D2283C9D;
	Tue, 12 Aug 2025 13:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ivlZ+CwT"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732D828314E;
	Tue, 12 Aug 2025 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003814; cv=fail; b=c7E8fbvhpr2Hul3wSXaZ0pdY8LPUZgFLO9izRjVuTcaDQ5EGehFnIVtRZ1kGV+1H/bJHgCk8iLK9orFY3FdmNPzqcZ3yUvhjkgs59noFWdUloAtu0vLIhWuQz43s52gNdCn5Uxr4M2k6d2ZrIyulg6DdyzrBenUKNMrsUKg/OV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003814; c=relaxed/simple;
	bh=MrSXX46QUY8QBqwhZeaeGNH32J41u5qXBxLHvnrQ0yA=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=PRicAbtFCYxQ73/sU7RfNNiU91XjzrbIZXQ+cW1S+Sc/gI4R4GkS80JGoUEc1+B3OwuIRVI3+o3XLEjdHQXeIgvHTDVEric11vSVj2jOetslJnyaC3s8YM/liHQY2PMgIaGGc/XDM1DThcTsR4oLbue9xuS6pCtNS/Q2gC2vmC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ivlZ+CwT; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kImBSK0qUHdf3CWh5JbjHJONZCSFxTNJDG0doETyGu6AMFXgbk33k+afbvdOxKW+J+d2/eQP72jzlJyrrDkLeMui1N7dDTRoRc3uIFN5JENEIQSXWCks/0rDjErhfdgntnfokOlfzIkw/D3Y9BuD+2ldNE8MmHXHM91zeu5qEfvyNRHwiQ6pBPmoDt5cMe/nqhiJCSyFWbMF5gMPnuIdWFego/rEASgZtCFHZv2wWsaPbg3bkC1LpfRifl0SE/pZN5Be5WJzwICzfI1O5VrpMZMRHfFPgedy83zZdVqmLWqbjYtWxVPdJPDphoZQhxT7flOwlwwDhPLzqELZ7Ds/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrSXX46QUY8QBqwhZeaeGNH32J41u5qXBxLHvnrQ0yA=;
 b=L8aBPHUTWCHesME7smv+jUgHMJaLQZWUq1ZRBINFM37L2AewiVrjTWgTwNt0b8pjA7kNvqO4gnXcmq/h4ZBS41XRLyitTDn0VQTMEO6rqZRbL7JPfHWEVRO7IuSkTugQ3Zyz994lGV/0yz8RCZMqhKKrf5rMCdN2EiC4aKZrW+YYzijBj/9QAH55p+agQA5Lsa4pc8PMaJMa54tPO1jTBVyFr6/3dQb2VmAJX7ayppdfISgAF5v5ICvSaTB+g3jbH//sl9PY8eX/KxLTSKZdTi3DlkhFwbUUJ+NvUg0jAuHuDuTkGcBZxbucoxs6eyqObRWa0mTACw0eUfOoHuWdLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrSXX46QUY8QBqwhZeaeGNH32J41u5qXBxLHvnrQ0yA=;
 b=ivlZ+CwTwoILuR4EUN4SvsXMGQu2CjP7WIZOOu+UIIV/UwdFd/+2kjBsaUzKBAZ2jWeO+sMuc6LOUT/iyWiZMHzPfLH0h6RMkBFRd+6kbvrX3XPPzZtXX3NL3877lKO2SQ2sODz3E2E76TFRZY8lkg6xhw+JF3d0Osp3cuYHD4Avx4XmYXE+SLPX6tXPmTrJBEDaGR88wBH3Q7CGG6DjFcifBYJ/myZiqa/G0BKw5yas4rgAEkvy3qA9CPvKC9wUUzlivuJdqQ/e1gevkJ0mOaqudiflAJSSlsWRw5hcWdqZJ5Kd45MUmRneTMiw1mUPJojnxWdkpkFY/hU4BJUVbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB8563.namprd12.prod.outlook.com (2603:10b6:8:165::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 13:03:30 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 13:03:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 22:03:26 +0900
Message-Id: <DC0GXEDHVYB0.3TVKDQ6DFVMIQ@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>
Subject: Re: [PATCH v2 3/3] driver: rust: expand documentation for driver
 infrastructure
From: "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250722150110.23565-1-dakr@kernel.org>
 <20250722150110.23565-4-dakr@kernel.org>
In-Reply-To: <20250722150110.23565-4-dakr@kernel.org>
X-ClientProxiedBy: TYBP286CA0037.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::25) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: 53742f33-5edc-4405-41f6-08ddd9a0a259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTlYd0dUczZ2Yjhtb05tSXFxbVBHRlJtZFR1cm1mWVJWMUxKUG9UZjlsWlBi?=
 =?utf-8?B?MksvZUN5S2RNOVE1cGNCdDhRQUdHTllHdHJvOXlZUzlwYWU1dmdRL3ExUHZO?=
 =?utf-8?B?cGQ5QmNlVXJVUzR0dWo0M2MxTy9rOUUzbGdLeUpvYWMwN1JkS0xzdHVWUkcv?=
 =?utf-8?B?UUxpdlZacjZxK1N0N1dmUHFZMWI1YjZJeTBwOFNuMTZHa05TZEJYY2U4aHVR?=
 =?utf-8?B?QTRQY3gvbjRWMkFhU0c2TUl4UzFXNDRiSFNaSW5DWlQ2WkRoTThIcGs0TFNt?=
 =?utf-8?B?U1dNNGk2WUpCTzNtMFl5MGhzeU9TYmUra1pDaTJJeWpqZXZCUERJSUh1VXhk?=
 =?utf-8?B?NVpTcGNKVlJpWXZnb08xZCtzUGlqcHh5UDkreStOZWlnblQvRE9iY0I4bE52?=
 =?utf-8?B?NTNiWXJFOXpTSjBNR2U5djR0d0RhcjBUeXFlRjRQRWdVSWJVN3QvYWF6REZo?=
 =?utf-8?B?VWhkclNoaUdvcFc4eTFWQ2dQNkxuS0lsbVYvZEhTMUVHSDJEa1RxK2laeU12?=
 =?utf-8?B?bUpKaW85M2tmZUw1VTNmeUdvTVNFYS8rY1NSL2xqK29PNHJZVU9xakk0NDhH?=
 =?utf-8?B?NEltZ216WXViNzgvTjRrTUJzY09yVXdnakJ2S1NDTGZzOW1KSW9mTHo1WnZ0?=
 =?utf-8?B?eGl4OFRMSXRObXlFenE2alZZZ3poTjVTZkZabFV3MWRHa0c3dGdGMnhFQWRW?=
 =?utf-8?B?VDRRc1MxbFMzbjdIbzZUZ3NyK21UZGVIeGxKWm9qZnNpRDY1Q25HNEp1KzBW?=
 =?utf-8?B?azlaL3pDamQ0U1RqblU1bFZvSkJodEFITWJCSzFtQmw2QklaaGNlR3c2aVU4?=
 =?utf-8?B?MnlEVTFxUUJyZXkvVGs0SGt4NUpBcTJFMmJJTlE5QU1VbEJHalJoUnpJOG9j?=
 =?utf-8?B?cktHR0FZY2JlOHJMZHc3RFJOYi9yUnV4NEo2c3J2Y2wzaVFwOGs1WE5mb0kv?=
 =?utf-8?B?dGdxT0ZGcHJxS1JUWDY1R0hKOCtLYllqeCthQURkMnNENXJqRWZENHFEOUR3?=
 =?utf-8?B?TzRlVWVDTXR6b2RZQnRGNkpobWVSVk0yZHRRWkg5RWpvdEtjVnVza3dKeWwy?=
 =?utf-8?B?cHg2ZDB5NkNsWFVpVnpVQnJSNVBOR0FPV1k5MHpBZVlCQTYxclFER0hpZFVO?=
 =?utf-8?B?RnJDSktDTmEraXZuei9TRllNUHE1bkFXNC8zUjlEL0VjUVQwRkhtT1pkRzRr?=
 =?utf-8?B?NGYwWmdOcWh3TUFjald6eStBQnFYdGRoYUJBVFFoRVhJbVNjZElpTmV3dFJM?=
 =?utf-8?B?NHNaSGxLMFRsVGpCOTF1bm5CWURWcDEzY0I3cFFqYlQyWW16Z01IQXBpZC9z?=
 =?utf-8?B?eU40TDVKdmlhWkNidmdhUk9Sa1BhNTRpSC9xck9DNXc0U3gvYSs1eEtkU29W?=
 =?utf-8?B?YnhsY0Y3WXhSL2MxZi9ITDVCUkNYb25EUlRqQmVNRnYwSXRzU0wrRndXdlps?=
 =?utf-8?B?bllTQnVsdGZaUEp1K0l5SEF2RWY4QTBjbEpUbGRMRmpOVTIrYTBZcVJmYlZW?=
 =?utf-8?B?czdpVHJneTJ3NllKbkc2RXoxK1Jkc3ZkTWtqa3FIbVNxd0JNV2NHRVpwVzQ4?=
 =?utf-8?B?aksvRHRzWjdkQTZqR3dkOURBMGRnWmdNZUxoRHJmbFR4d2lOSEpTY1FubThK?=
 =?utf-8?B?N1hpTHNwNG05elg3V0RlSEpscmU0dWhVTTRsTkg0eUsyNHdCZWlUVndNOHVy?=
 =?utf-8?B?SW1yT0J0UXlCOG12UUEvRm9UZjBmTkI2RTFORU05dUw4bzJhMUI2VWZSVFh5?=
 =?utf-8?B?OW03M2J3T2tnRUxtbXdvWWcrc0pUK21SMXVuMGFURjYwNHhHd2RDMjBFSU55?=
 =?utf-8?B?NDhvOUtHQXo0TktMQk5BNWh0UVNMZ0xiV1Y3S2RNNkNYOG9SdElFSm0zb2I5?=
 =?utf-8?B?STkvbHpZVXQ2NjdKYWE1RG9vNWtucHBCaVJVR0dYRmJNbFFPK09RdExJMUUz?=
 =?utf-8?B?RlkySU5pVWVOdU5ZTXhybjUvc0NoVis5WEQvZ2Izd2Zia0J3Z2Jyb2NLelBp?=
 =?utf-8?B?UUhWRHhNUUhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0d6T0FPd1VFODZ1SGZlZWVTWktWay9laUo4M0hHSjhvd0ZZNGd5TUVGbW8z?=
 =?utf-8?B?eHBlZWltTDdwcnNVRnM1RDdJN3dRVFpCRlUzN0NZVlhBTmtaN3A1ZHBmT0k2?=
 =?utf-8?B?bmxGa2kyUDhrR29GZE5GaVAwRkpyYm4ydzUvbUwyYUZqVVIrQTQ5UGRJeDN3?=
 =?utf-8?B?MUVKb21VcUtnLzQvWFZrTzdOeVBrTzRqYlcydElOU2VPZHVVdXEvdkpKOTA3?=
 =?utf-8?B?R0czZEROY1A4Nko1WDFGMEVUUXRpVHdmTUk1T1Q2Q1h6cis1S1Z3MzF0cDV6?=
 =?utf-8?B?UVhTazVvaHNBc0xwbzA5Z0ZzK1ZwWHg4a3ppd0ZWaC9uemtwaFd5Y0hQVVow?=
 =?utf-8?B?K1BsUDdCRXR6dHhUUWNqV1NCQ0JEMHY2NGpucVBWMzkyUWxmSTlsWGdBcVJK?=
 =?utf-8?B?QTRtM1poSDI1MkJpemhlRy9kZzlsaEpjTE5mQkliaUx6NjJvb0c2eEFJYVgx?=
 =?utf-8?B?Q01YcWpTeG1kTDRoTmNFOEtmRzdJSFA5b1BaZmxrSEE0L3paWm5sQklnSzQw?=
 =?utf-8?B?T1VDQlBJNTl3UUs0R3lWREI5dDJNR0FxdlAwTlEzWWdkMlQ3WWNCRnFrblNu?=
 =?utf-8?B?YW1QVERKd1prdURJQjZPQTRmN2FnM09TR3hvdkg5SEM1ZWVuZCtUbFBzcHMy?=
 =?utf-8?B?MXZkNmp3OUhNWGxxeklXcXRNYm5Ybk5XTitGZ1lUSjJNWFZtdVljaUR0dkhh?=
 =?utf-8?B?UWVNbElzelJEWGgweXFpTXFFZUQ0U0I4M1lCNHorUGdRS1BNT2NOSGtLdXNk?=
 =?utf-8?B?ZGpzWERJM1Z4L202REE2ajYxb0lkMWEyY2R3RWdIMTl3bWlpTjVLRlM5OFhI?=
 =?utf-8?B?SU1kLzIraSt4c0E5eUNPNkZzNzBHWHRHalh3aEkvcEZDMzlzWG9SWCtmbHNv?=
 =?utf-8?B?dkllT2p3RjJVUXcrVWhzSnZGSmxPZERsaCtwUUtwYkVnR2dtM3VDQVVHdFV0?=
 =?utf-8?B?VjUwaU1jTGVPV1M4VlJieUVNTnJSSUdqczI2OFlzNmZZend2RytxMlJkN0g4?=
 =?utf-8?B?eXdHalAvYkxzb0dJclNySU96T2kzanZETG1BYjFrY2x0WjJNczNiNVA1U2sw?=
 =?utf-8?B?RngyR2VhZ3RQZFhoSUhYeXVEYm5IWHdCKzZUeFRuUDF4UjRVMy9MYVJsNG12?=
 =?utf-8?B?cHIwMEkwWGRRNnZnK2FVRHh5ekxEcWt6VndzQWowaHdiQytlRUNvbHV5Nzd3?=
 =?utf-8?B?ZVZQSUkwUGhCallUR2NJRkE3MWN4K3FxVStaTE55Z3g5T2RORDlwMXBFU0E0?=
 =?utf-8?B?K0VqSDA5SC82Nm91eUFkTmY1MGRHdm45V1VTZ3hycDd3S3c1Q2NjUWVCNm9v?=
 =?utf-8?B?N0ZOTEJucXhqRmVZQ1dCVHdXYjEyRHV1dEVpUHVJbDJiZ054cEhOQi9MV1VW?=
 =?utf-8?B?V2Jjb2p0N2w0MUpHbnNVVFFjVG1kVm5Jd2JHYnFzWWVhYzlSRXcycStSZGZC?=
 =?utf-8?B?d3hMWVFCVkl6b2VsbzQ4SHpJSFZRVjVJQzBZS2toNnZNRno3VHBZeG1ldmNS?=
 =?utf-8?B?TDNqY29ndldCbGliUVJpOHdhVUxLbjJ5ajloaEZWNlVjYzI4cXk3YmRBdmR4?=
 =?utf-8?B?d0JTblZrL1dwWDJFSDRWN2NrM1Y3L205ZEJBQ2F6M3ZvMU4rM082a1BaMWxv?=
 =?utf-8?B?dGxXL2hMY0R0YzJib1hIeWlvVmNZNE9lbnRxeExkUEdCYzczZmRnUzRzMmRh?=
 =?utf-8?B?MytYcVRjSXh4cE5NajhLTGdKYWdlSjhXTjJBS0pxT2c3aXdNSXd2Qk9DYlM0?=
 =?utf-8?B?ajhSQmdUT09mTGh5enYrTHI1dWpobEpvVjdOMWdvUy9WUGhMdW9PRnliNzJR?=
 =?utf-8?B?TTlqaUV0d0N4NTA2NTNwVlMxVHk2MElVVDQ0MGUwdEZ6TGJwekozVlhFVm5S?=
 =?utf-8?B?L1JwdjBaaUQ2Y2VHeFR4cnVuMG1MRmEwK1RjUUtWQVhWRG1HRnhUN09qbTFG?=
 =?utf-8?B?bk1HbVdaaThxaFdMTDlZeXAwa3BLQWhJSW0zbUZBUGlhVXMycVBTSHNWaloy?=
 =?utf-8?B?dVhna0YyVzFCd2RsYkJxbmJCTmtLVVFGeERLWktPR1lDS2J4T1hobHBES2dK?=
 =?utf-8?B?eHIvcGJYTHUrTEd6TmRyODhtNkpuNEh1K05UdjFNVHc4eDg3THVNY0g0OXlr?=
 =?utf-8?B?U2RTU0UyOW91Y21xeTRNWmVwY1VDbERLV1h5QlVyQlUxR2d3Y1VRSEdMTmRP?=
 =?utf-8?Q?PO8Aa0h7MZjIqXCwn1FO90QkoT8d6iiKtWBvTaTKeWzF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53742f33-5edc-4405-41f6-08ddd9a0a259
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 13:03:29.9755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6FrKUJ7ke7M2qM3wigRN9gMzzRV5R73UOvKDJDbB99jUp8z0uU6AcTeJjtp+G67zVAX6uHKN9ST7VHN3ewbzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8563

On Wed Jul 23, 2025 at 12:00 AM JST, Danilo Krummrich wrote:
> Add documentation about generic driver infrastructure, representing a
> guideline on how the generic driver infrastructure is intended to be
> used to implement bus specific driver APIs.
>
> This covers aspects such as the bus specific driver trait, adapter
> implementation, driver registration and custom device ID types.
>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

