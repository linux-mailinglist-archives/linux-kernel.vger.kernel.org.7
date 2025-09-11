Return-Path: <linux-kernel+bounces-811254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F319FB52680
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070C01C27A26
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 02:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DD220E033;
	Thu, 11 Sep 2025 02:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t3FcB8rf"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEAB33D8;
	Thu, 11 Sep 2025 02:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757558036; cv=fail; b=ee6Rz8ToBGxFLIgJsJHB3mvA2zAuRQYv8o71kqG5KWadxqHoLW3V4228zt4DfYUibTtfLdguOOYlX5DtIR+FlUzHivmm4CBdvwif5rJjIJ7DImXT4njFDq6kw2w4/Vmx4hDuRLdV76KsW96/pPqdfBDOvXW38lPQHYl6ZpQkp0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757558036; c=relaxed/simple;
	bh=iaKJZq/wXQ8W41dptZ8zuMM5H/e5br7BPdIvQl+Fhlw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=icJFPwpwWSPO/vc7Q3cmxJ18zQV/xK2fs8rdS8nzo8qYXrR4V8nHmuIXOsZN597/uvBKw85N93x+H0NX8kLU/4W9iSGwJMtXH+FRkKCc0adP1Z4Aa69z+Aj+cz+elW7TnS1mIS7zhwzeXwrc37WdFM320kQ6t8WpRSlIsxLwEfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t3FcB8rf; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdQb/7vp3pW+HtvUnOK1zajin+MwiYJQmQ0p3Pdb7w3bSoe8zW0JKfMCz6KeGk10dOJsUNH5GE0HPfyxojzXAyxIzvAXsQd/AFoE6bNLNCg34UU64TkvvOryqIyGCKYvXr+z5GVh2hkZBoCUvWq5vwiRj7la/ZeND5WaniS2S54LCl7+0BFBh5h5YvbYmCvUKQKYLwKDikxXTgicyQWY8qqXLlCFMYs9yXQiZ8Vy/Bnzzq8/jo/jK+naVxEHys8azHNzrKhLloVBjHX/ktsqSqGr9xicIMYtt2XBCPL6Zz6K9IBcoiV9xbLsKgKDHwiwZem4SvXLV+gNi20WfFkkZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUp9OL4gN0CyEHAUXhmpEik9VAKJ15S1RTC+050LH0k=;
 b=C0DYecapOSXCGpjG2iw8pLfTFkKu3zFh/SSPhNRIT8bquutbVrm4WHoWhosZcqrG3SwZot6ZjJ6wltHXcmD/eIyXmD8Yjt+f06mL2NqmlfqOXKvthBqe6my8jpvuGRZ9VUjYaidS/rxwKm4C+uYI1fwKIy4h+v/LxmcSCbv4ng7ZZrdo5ccslIQrl3jae/2JHjlFRAVgrEPlWmZG929htIuxHCbZtqlSnymwRnlklcEKVLO3HojmgULmx5K2qiW8M521UkyzjFKWmrWAZdhjYMDMoCAStixKiWB5u0YQwSN78SmsgND68pjjPY+9tIp+4tI/CHasGnzkm/vnBxB2tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUp9OL4gN0CyEHAUXhmpEik9VAKJ15S1RTC+050LH0k=;
 b=t3FcB8rf6rWhsiXSfTIXuepbG0MqZlt774U//NoWdzrfo6yNI+2j3jAHeV2Jyjit0dKGpiKhfrW+JyWLFrEqnacrUFF77N7NxfrqZmBBmA1CeZhI6MjIDNAZ0fobLclRTAaF9JGR5MuEZUAa6H0rJc7jkFw7M3cH9fGaryUSYleqx0YE7biLv6PRDb4OBAGuUzH/ppnRbvuK28OujGg1KHL7/AcfdyUqfbllMo+klJ8fg63dm+Ptw4jctZeigWCOl3ozFkVOn/7RIBNi/7oouHBMT0tJIDR9Xdk2ZTmmw0svD/cvjxsgQi2V6S+VmAemXX3QT8hvgOt6SGdAOt/a2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB7666.namprd12.prod.outlook.com (2603:10b6:610:152::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 02:33:49 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 02:33:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Sep 2025 11:33:44 +0900
Message-Id: <DCPMBM7DOG2Y.9N56KZVVO7GC@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Vitaly Wool" <vitaly.wool@konsulko.se>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, "Bjorn Roy Baron" <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <lossin@kernel.org>, "Andreas Hindborg"
 <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Subject: Re: [PATCH v2] rust: rbtree: add immutable cursor
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250906140256.3059395-1-vitaly.wool@konsulko.se>
 <aL6YHkF96ICqqbBZ@google.com>
 <94252007-f389-41d0-b5a0-ed948225543a@kernel.org>
 <CANiq72k6OXcvjzKimfzKAAw8QPzDoVxUx_smFA8KU6gEwJ3yeQ@mail.gmail.com>
 <3f8de021-8eb3-4a7c-9adb-8244c5aa250a@nvidia.com>
 <CANiq72=ex8zJx+KZTV5eRoqkYE=PUkbG5TTvOJo5cXTtd7b1Fg@mail.gmail.com>
 <e49f9e6c-69ee-4ec1-bcc8-3a60fda9a7be@nvidia.com>
In-Reply-To: <e49f9e6c-69ee-4ec1-bcc8-3a60fda9a7be@nvidia.com>
X-ClientProxiedBy: OS7PR01CA0017.jpnprd01.prod.outlook.com
 (2603:1096:604:24f::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB7666:EE_
X-MS-Office365-Filtering-Correlation-Id: 02353722-b226-488d-f7fe-08ddf0dba34a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzBPSDVscmtWaDRzUXNnYjVSK1ozM2hnVkZNVnVOa2VzbVJGL2NmZ3QxcjFm?=
 =?utf-8?B?R2ZKNk1qNlFtTUpISS9EREJnSDBYOEtOcFBNL1RIZFpkYWRHZG5zbXpBNnFq?=
 =?utf-8?B?RENZZHFxRWFKZjlVQVNGSjNWL1JvcElaOFYvbmJ5eitET1JOb3I5KzFoV0ho?=
 =?utf-8?B?NlpPbk1ZbXJuZ0RuYVExdEhHcU10NFBjdVFNdG1EZ2x3Z0RDYXJIRnNWaUhO?=
 =?utf-8?B?dmc4Tis5T3hiM08rSm9XbFFlV25lR1Ixd0ljckFDSGJQYnd6VVNseU1paEhE?=
 =?utf-8?B?TmUxOGZGZTlFT29Ca3FJZjhIc1pqdkNadG00MFhhcUFPcVpPOERhMzJ5b284?=
 =?utf-8?B?YWJMODNkRG9yeWtOSUowejdoUUxLVU53QzJtbm56YzlzWHBmSmFQQ3ZwUkwv?=
 =?utf-8?B?a1k0aFp3U0hrYzl2ZHFDTHpCaFIzbHUyTjV4ZHFmNWh6cUVYQTM0djB1VkNU?=
 =?utf-8?B?WndkdE1FT2Y0ZVlidDNFMGhtREhITmhtNk8wdTlPK1VlMi9xb1VwNlVKZTRy?=
 =?utf-8?B?VURWZHhjaXdVOEltQitHS2xLSHhiNjYxenp6SXVlZWJOYnlKY3dEem9GOURz?=
 =?utf-8?B?bU1WL3pleldVUnl1Q21DU2NKYlZvbGdZN3ZVYlVYUndtRHZpRkFyNWpUZzZp?=
 =?utf-8?B?dGdid010aWcwZ1QvNlRacE1obXVlMVhPTlhHS1FnSFI4aVZUT3A0SGJ5R0Nm?=
 =?utf-8?B?SHR4NDRiQjErbTVDTlhLaGJMQXAreDFpZlNmWHBvaVl4cnJXM3E0RGVqZEZp?=
 =?utf-8?B?SmpjcEpacFU1cWlablUrdzlqNmV5WFFIdU14RERRa3BZbVREczVGNmdSZVVH?=
 =?utf-8?B?bTQxTkZabHU0UHVaRktpMHZCNE1rRi8vKzk1VEpSdWZOZGdzTFQvWVN5Wnlz?=
 =?utf-8?B?dmphbHNkZzc5Y210NkJRSmlSS0gyclRIMU14M2dhNFJCV1F1dEQ0SmlXM2J0?=
 =?utf-8?B?dnBsVW1PY0g1QVhXclhxWGdaRFNRNUkzdzlicXNZUUJ2N2IyR2sraFRKQlFr?=
 =?utf-8?B?ckQ1TGZQZ1JZSms4ZXpuczdpM20rME9zOEpoeThRYUFPeUFneFFZSkNnY3Ft?=
 =?utf-8?B?d3AyUVYwS3pDWVZvSWc0RDdXancrRDhXaXJRcGtSTTcxYjlZVEpxRUUxWVdS?=
 =?utf-8?B?OEZOZEZvUDdrUmdaejQ3QWZuT3ZFNXJBVUxuQnExVDNydFV2VG5KQUxxWi9p?=
 =?utf-8?B?cTNreE5mNkZSeXRiVEhsNTVaMDZhNjk1eUZ1MGJQUDdJNG5EQ01wajhoT1ZI?=
 =?utf-8?B?UTE1bnVYZWcvYVRsK29iM1RscWtLdnpsZVlxZ2J1RVNHbkhHTUlkMkJkcVpn?=
 =?utf-8?B?Y09lWjRYc3N5WVNzNHhacnpqdHFNcVZOSkJsUFRYTG1qZEV5eEs3TkpVL2Jt?=
 =?utf-8?B?a21PM3B5SS9jK2VlQzNWYTFUZ2NGU21tWHU0Z2hqQ2RJeUZVdmwyWkZpSUx6?=
 =?utf-8?B?bVRUeWZnVDdMeHNhMkRBRnpDOUJ1b1BNcGJ2ZUR4Y3I2QnFwM1J5R2xsY04w?=
 =?utf-8?B?M3ZMd1dzMW9LdnpML3ZHNkR5ZXNmN0xWaXpocXRaajJsRXBlYTloU3dZdlpL?=
 =?utf-8?B?QmZDeklqZWNweS9ScllQSEZwUmx4cnJmU3BTZC93TWxaUGdrcVhnU2phZ1BI?=
 =?utf-8?B?b2RpN1BMMHRZa1Z1b0hmdWltUDJBK0M1REVOMEZ0WGYrVDhHbTB6clRRRHQ2?=
 =?utf-8?B?OFQ1Y0QzZ3JoZGZpUVloT2hJR2dGMTRobjdpYWJzME1kbXN4K1hWYUpBVXA2?=
 =?utf-8?B?SDVxSW9jM2twWDBvWk9jQ0pSa1h0eC94b1V2bjVhWkhyd0w5WjhvdnNJNFlq?=
 =?utf-8?B?MU5oaEhMdWdjcmhhSkNWM0VYYzBCSzhndDAzSkc1dktKU05TRGVHS3JyaHA4?=
 =?utf-8?B?cnFHMTBVUmREN1h5ZTFIblZzQXM5Nm1ielFDTXlSVXJ2aVpxT0F3dmxhWmZB?=
 =?utf-8?Q?iapN2BfMMMo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVZQQzVjdy8rY3F0VXdRMnd4TWh5Y1hwOHZFbG03TXJTaEZGV1k5NjE4MTBj?=
 =?utf-8?B?eXJhd2NaVW01dnR2bFh1KzZWUWJ6YTlXRTBCY09hRXp4VEw4REUvZ093ZS8z?=
 =?utf-8?B?YUk2dEo1STQyd0FHdzIwZTVMQnVUR2Z5aWU0YldJQnBRVkNsNEtHeXBwUTFa?=
 =?utf-8?B?YnFuVU5uOEJFUW1lZVpqN28vRVVKR3pPcTczRlZLRlB5MzZnWXh5TUdkQmJp?=
 =?utf-8?B?V1Y2dnFqTzVtNkpBdjkza0N2aTFaVGRNYnFVQ1piMjY5UTZJd2lyRERkMVBx?=
 =?utf-8?B?eWw4elB5TUNPQ21Qd2xlY2FNUzhNOTNCS3l6SGsxSm5maVF1aG9ad1hWd2NT?=
 =?utf-8?B?SGRJL0ZPaU0xS0dvNlFCQXlEa2I4UFdZbDlqOHF6R0UzcitmSkRYUWlFUVpm?=
 =?utf-8?B?NzVBUy9Sa3BYUFVJRXp4dERpa21EbDZXMG1GOWt4ekUvSFVZeDc3R3V1SjdY?=
 =?utf-8?B?VWNvMzZqSXBaU0h3dHVidnhlSElLTmY5amRWLzZsd0VCZEFqSU9pTFZ2T29z?=
 =?utf-8?B?bTNKZnRNSmpoZjV5VWZqTE8zamRIUU5WMVl2T3g0NE1Sa2RpSytZVVV3aXha?=
 =?utf-8?B?b2lmZEJrVXpJZ2pjVUhObEZDQ0ptcjdjUWRydE9oaG5IR1R2ekJZWmszK3Nu?=
 =?utf-8?B?akdVSzdnV2tEMU8vVThYWmc1cWwyRmEvSi90dncvblJBQnVJKzk1UkZPcDBO?=
 =?utf-8?B?UjZwL2VGdE0xaFFpZDJaWm9JUjN6dXJiR2pnYWxudmdneXdWUzF0UXJMT1JD?=
 =?utf-8?B?N2xXZUJwZDZEMDhpVEk5WW14NVR5RTR5dmZvUDBDMnQvTTl3d2dGZlFTd3FL?=
 =?utf-8?B?cG1DQ2c0YkJ3WnYvekVNRE5kc3FuZWpEbDFmZU40NThsV2djUXdSZml4eVM2?=
 =?utf-8?B?RDEyNTZOYXBISDJuRTQxTFhlenIxNkpHTk9xMlNrYVZDeGN4eVdoZVFMMjJQ?=
 =?utf-8?B?THJnNzljLzlwVk5XaHU3aDh3NHNNMk1KWHplcWQvM1lqdnpkNTB1K0laUzRQ?=
 =?utf-8?B?TVVqTkR5OW5UNi92NlRseGlZaHE3T0pVSUF0VE9SYnlKOExNZFNlZStzdkF2?=
 =?utf-8?B?ME1DZGs5Z3llY20wZEJrUUJudWlVUEpCQlFWVzVBQ0lXR1ZJRGgvOElianJQ?=
 =?utf-8?B?Z2FKYlRqK0lndGZDb1BOYUxjYXZjTURQbTE3bHpxMm1BVmdvRDlSeHd5ZEdM?=
 =?utf-8?B?OGxtNkV5RzF2L1dUdGp2UzVFNHpZMzM2SEc3b2NCVEtFcm9SVVNKcUpyaXpT?=
 =?utf-8?B?d3JOZktvOU1EVVNqK3o0eHZDMFdPOVlJMm0ybXZWaXJjaWJ6aUJvaFpVN2o4?=
 =?utf-8?B?YWZ1SEp3MWVnb000QmozZ3lmcnVVQVFsMU1RMGJ2cFpjaiszcVplVytabXRT?=
 =?utf-8?B?WWczU1ZtY2JMT29QYWZEK1had0tObm5WL3dpVDRzNjQyMTJQVERJdGVTenZO?=
 =?utf-8?B?aWhINHh1QXo4TTRlUWoyRXRhYklsVTRObEdNdTNQRW51eGg2VUFjQlRyZ3F2?=
 =?utf-8?B?SDdXc1VIek1peVhEUU9kMG5UUUNKKzJhS0pqMnJXOWNsWXFzMkdUYTFTTnpl?=
 =?utf-8?B?L0JqdGtkdFlON0tGd2swaUNFeEdQUDhFN3JPTTZNNC84aTFKdm1uY05VRHlZ?=
 =?utf-8?B?d3FlU0QxVTF3cDgyYTAyWVlNM0VUbFgrSkc4U0FKTU4vd2ladmpqSUtaN3JX?=
 =?utf-8?B?MURpZlJHenhqUjNFTDErcHlyMjdPeGpGalB6Y3dRVVhlMEc2NWFmRnRVNXJs?=
 =?utf-8?B?Uk9yTWRFb3ZBWUh4ejRDMW5zSHN0WXROTk5yZFhnNzhySnUzK0t4bUd0L0ts?=
 =?utf-8?B?NytjN1JLUUVnWFNpLzA3R1diMDVQZEZUMzhQVkJvM0NYb2pwTkxtQTlvV3A4?=
 =?utf-8?B?bnZGQVNlcGhUeWlaT3V1bVRwcDZyRGZWbDFma1pmd2RJM2dzeGxHWXFDd2Iy?=
 =?utf-8?B?RlZJWVJrU2JnRU5WYWwxS3B2KzUwYittRVBkSTFCWVhUbFlyUDVlY1BicU0z?=
 =?utf-8?B?dkcrNHA1NVdKbys1ODRWRHdEdFJ1NXlUS3d5bXhiSys2Z0dDT1JiNXBIblA4?=
 =?utf-8?B?Q2ZaZnZPdlYzbEVSNVdIQXBZUWdQMjF0T0hyNnk2VTFocnJidWF2NUlEMkla?=
 =?utf-8?B?ODhOYW1Ya3l5K0RuZDJFZVZVdHorczRreldFUWNhVWlXOUpoT1ByWTBOZWZI?=
 =?utf-8?Q?RglSPBWy9y5OGGKXjC9FxrHq5ugHHA7yPI0TCiwhnpCx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02353722-b226-488d-f7fe-08ddf0dba34a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 02:33:48.7971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XU8lQIsyE0AkOLZWcavMhyKv18oaPx5oYuqE+q9dLUvhRaFoerFjBQVKygLB7B9+w1RyLdQpUrzCZIaTz7rSJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7666

On Thu Sep 11, 2025 at 4:40 AM JST, John Hubbard wrote:
> On 9/9/25 7:50 PM, Miguel Ojeda wrote:
>> On Wed, Sep 10, 2025 at 3:09=E2=80=AFAM John Hubbard <jhubbard@nvidia.co=
m> wrote:
>>>
>>> Interesting. I know the topic of rustc minimum version (1.78 right now)
>>> has been discussed a lot, but I'm somehow still confused about how this
>>> works, on nova for example.
>>>
>>> The &raw feature requires rustc 1.82.0. So I thought we couldn't use
>>> it. But clearly we can...right?
>>>
>>> So confused. Please help. :)
>>=20
>> Please see what I have at this subpage:
>>=20
>>      https://rust-for-linux.com/unstable-features
>>=20
>> I hope that helps!
>>=20
>
> Hi Miguel!
>
> It leaves unanswered, the question of whether (and how) to use something
> like the &raw feature, which requires Rust 1.82.0, given that the
> stated min Rust version is 1.78.
>
> Is there some sort of exception to the "min Rust version"? I haven't
> figured out where that is written down.

My understanding is that while the feature enabling this syntax
(`raw_ref_op`) is stable since 1.82, it has been introduced as an
unstable feature before 1.78. So it is here, just not enabled by
default before 1.82.

R4L enables some of these unstable features when needed, especially
since they have been stabilized meanwhile. For instance, we did it with
the `pointer_is_aligned` feature for the `FromBytes` patch [1].

[1] https://lore.kernel.org/rust-for-linux/20250824213134.27079-1-christian=
santoslima21@gmail.com/#iZ31rust:kernel:lib.rs

