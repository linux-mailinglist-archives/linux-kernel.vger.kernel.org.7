Return-Path: <linux-kernel+bounces-720937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0031AFC24D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A331AA00F8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAF321B9DA;
	Tue,  8 Jul 2025 05:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mis9/Zp0"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079EB18024
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 05:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751954140; cv=fail; b=FiYuDwAX/Dgq01uEct+b3CDKvclPDibHFvjJLrFeuX7QbW0iIIh2BPLx3TbsmKa6Tpj4A6D95M94qNEBZdI3dBDwE3KHwXvE2kGcBvgld1yRq7t0xqaAHNMJtyOMqI/PzB310rlenuS8CQfcj3PM6csLAOeT5WA0plnnTQLtT5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751954140; c=relaxed/simple;
	bh=1zFTq2wq3PvyQOYK98/LWFRuhYXOsskCrKXyub5VWZs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BO+PhTOpzzVy9AfKEy5qIfuwm/EACntyH9bMNjE1jDtMp9ymONWTW5QXT73ZC6yYyBofxGfL+PzVeApQsCaxn0ZqLAj1/v4t+jw5bJ3PvGjKLrBv5pLCxOs3iw6TEkipB3G99s1iA/D3E2mT0RcWJJtDbmL2MuYZX8hrgXVz4gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mis9/Zp0; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A01vP07wEN2xaMUJQBEeT97uPWiaVwtIwqoJnKODkj20rOTVMvqljEG1lTeZj16cO5H9m8Fva5vp/vyKNahaIhLgHY72h+aFw4+9HBmS483UUOXcNfuqz5IrUBLrP0VTuS4Zl45PjH0QVBIqYvrR+YPmjYCogC2DLwxyct86tFIeJR6oM5KQCDH2B5RSThx2LGIHMttOvK7vf4JbAGL4ZLDHRbn1c12d+vxoeqTt/yBTIZMUIsWXzWtV7AAalFvuJ/Xa1BQSolPXKTP0TahWoBAIbmJ5ZwkptclKF/vb3c+Njpz7ePlLPcOSsJ6SgO4bBQXgD4ktsjIt/FaxoDJVAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6Fe63k+h5mtx917jECx694QxAaTw4BY6zY/UwL7anc=;
 b=rxCjcyW9gouULbXmf66dtMI6EoA5afovfOlt9MzBsiykHykn5NfKmTVN/Qbgul+INHgQqHshcj8y0k+WV2mqLKB7k4lsFALbKQS0W+uGPSeLIdLny+P9fe5AqzpxVgO+ME/MTNdSVGm/6Hmi0n8I2mulBE5GoF0iRlCWuJH4A4Oicro5CSE9sygmW2qNIpldMY4FFTapr5A+xues9123TfSxqSJyw5U7f/yP68PLopbIJvJWw0F1uDYZ1zA2X6C/8iJYyDq2B2X95RIW3OIz/LUnaFuxOxRfNEk6rsSgg45+w9BWz4dV4AqNN1XsJ1FtS5xCfq/7HDjAJpBK93mGMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6Fe63k+h5mtx917jECx694QxAaTw4BY6zY/UwL7anc=;
 b=mis9/Zp0wRdIaJSXgOHYYype1gq4P2cbF5l4xsQvZiFmoas8sTGPAhqyYJAxnUUMxPFxtCMy93fNxz73+NtRWsLF4W8jxRVhpAd5Q9wrSW159bMJF3CQvdn3GXQH6wUhA7rOrp7uUc7vSx+3U0jSlhi99PB8soFFWfvGDCGM9Y4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa) by CY8PR12MB7633.namprd12.prod.outlook.com
 (2603:10b6:930:9c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 05:55:32 +0000
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf]) by SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf%8]) with mapi id 15.20.8722.031; Tue, 8 Jul 2025
 05:55:32 +0000
Message-ID: <880b9e00-23d5-4c03-8269-8e2f9a50f358@amd.com>
Date: Tue, 8 Jul 2025 11:25:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] fs: stable_page_flags(): use snapshot_page()
To: Luiz Capitulino <luizcap@redhat.com>, david@redhat.com,
 willy@infradead.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, sj@kernel.org
References: <cover.1751914235.git.luizcap@redhat.com>
 <42122b9988871469f1311d71a608629f40c0c55d.1751914235.git.luizcap@redhat.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <42122b9988871469f1311d71a608629f40c0c55d.1751914235.git.luizcap@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::35) To SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFF6E64BC2C:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 53797726-0965-44fb-3b07-08ddbde40cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0ZGaG0vd1ZCVUZNS0ZLSGtRV0hkNHoyTHVjWkV3RTdZMDVpWG9iWDlQa2Qx?=
 =?utf-8?B?M3MrRjhTT0RqSFFsWE1yM0liTm8wYUc4dUxpS3RZZUlzM1NxS0lhNXVMZXNB?=
 =?utf-8?B?QWxFUkw5eVVKWnhrMFV5QklNUTM0aXVoMmlKOXUzTHM1ODdGU3loZU4rYys5?=
 =?utf-8?B?U0U4YjF4MVN6Y3dWbXZTOWtiOXIvVVY1ZzJoQkloZ3lYK0JkdlVPT2w1RTRL?=
 =?utf-8?B?Q2JIWnFnNForRU5CaENjTzQ4SER4dzZkMERUSzhPRlFQZ0JVWWNFZkZkTy8z?=
 =?utf-8?B?Wjd2UVd2TkxtNFRmK1R4RVUvTnUrLzZGeHQwZEVuWkRFUWVIcFBDVmlmK01U?=
 =?utf-8?B?ejJpK0VKeTJIUlF5a29RSk5wVDdpcWdkSFJIYVRaTG5odDhIUURKZzV2TXJJ?=
 =?utf-8?B?VWlNczVHYUNRYTZEalBudWVpQ2k1OTBuY3Q3YUlCQjFNb2pxZ2dMamhsdDhj?=
 =?utf-8?B?QzRKakFWNTZtMjJWTGhmMTNoM0lxRnZXbnhOUWtkRlh4UHhWMHpQYk1mTDJV?=
 =?utf-8?B?L1ZvMzZEeklUOFhSS3hhQlEvQ05LbU5zUmlnOGdrR0o4RzRwRDNkTkRaTWJS?=
 =?utf-8?B?WU85cDUycDJOTFlOM1o3ZXI1YVMzQ3UxMHl1QzZlUWZwZTFhczN2bUNLRTlQ?=
 =?utf-8?B?ZFlGMzY3RTFGekNFSjVpcTF3WGVqcjM3UHRrd2hIbklnZTNSclNPUnk2YjYz?=
 =?utf-8?B?RlQrVGphQmtPaWRqbjk0WVRlOHpqSmxpWEM4Nmh0bUVuVkhmUVhJbGxiS2Nk?=
 =?utf-8?B?NTRLbitwL2xReW5nTi9iSXd0RmFEc2ZUdC9zQVJHdElBNmJEaEdqNVlraDQ5?=
 =?utf-8?B?OHozQndIWW5KU0M4cGdwVWpaQyt5WEkzUTlQN0JPakNFZnZpWjZ3UUFhREtC?=
 =?utf-8?B?RlllUU96cG5nd2J2Zitsc3EwT2lKTVRQL1RJdU9nQThSNEkwLy9STi9QNVpI?=
 =?utf-8?B?REJ0OWFia2luRzhrZHJxZWpsWTM5VTd4emdnQzFJYUxrZ2lQRDJOd3BrSUhm?=
 =?utf-8?B?TXloRFNwS2Q0TVdBOWFydmt2MTRXVndNczczSjlpS2hlTk1xbTJkYUtZRTQ1?=
 =?utf-8?B?ejdQbHcrWWZudWlvczlmaVB4TG94WmdJb1RNRi9pNkozTmhDditVeDdSbG1C?=
 =?utf-8?B?K092OWhiZ3NtenJlNzF6bHZ5MmNPWDF0U2RXdXA4eHZxamMrdTNITkU3Y0hC?=
 =?utf-8?B?T0NhZXNHTUtkQnNlUm9sc1hOZUI5a1JHTERGamVIVGF1dEJMeC9McFkvZEh2?=
 =?utf-8?B?LzBCZ0tUUHpqWndsQmwvcmhYMFNnb0VnQUVzaFMvd3ptUlJSV1ZJTjh2aDFD?=
 =?utf-8?B?Z2tpdXcwbG4xK1U5TmJiVnZYek85ZlMzZURnMk4ranl3NU9hS1hvK0txamcv?=
 =?utf-8?B?ZForekkwcTNJUjdVRzl6UWtvTWIrWFBzM1lQMGV6dUtudCtHc3NLczQyQ2Ju?=
 =?utf-8?B?UWJrNG5QbzFSQnRva0d5ZmNZUWdJZlJWdTZTVVcvSXpGMUhFR2xxL1pVVU1B?=
 =?utf-8?B?ZWhGOHd3RDFLMlFESXdLYm1JSGltMlpGTm5ob2E1YjJXRGRNQkRKQ2MxWDd5?=
 =?utf-8?B?eXk0a2pSWEJkQkwxRHc0bnBvNFhISXVUMXROUEd5TlQreW5UYW54VGpCNS9z?=
 =?utf-8?B?MitxanplVlAwb21IR0Z6VTY5MTQ0MTkzZG8yS3RIY25SZWRzTGo1N3p0OFdB?=
 =?utf-8?B?WGs4ZGJnbTNwcTRiRXlLRjV0aDZPa28wQnB3N2hrbnhqSXRGVkgxMXpzTXdU?=
 =?utf-8?B?QXdnYXhTR3JEako4QjY0Nk5uR28xbXFJNXRxQ3NtclRsUmJQbFBPL3F3T1pG?=
 =?utf-8?B?MlVOc0FJSHVsb2JFSFBXMGMwdmRqb2piTG9YaVJKN1BlWUl3RGlnanVBUnhN?=
 =?utf-8?B?RUlraUZ2REJMUCsxbXBWa3FaaEhVQnE3ZUVUTnd4Z0l1OFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPFF6E64BC2C.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVdzNkJoUHFYODk1RXFiVFdmMERnd1FaZ1dCUkpGQWZmQ2Iyd2VleGphWU54?=
 =?utf-8?B?Z0JrVFJEOXhBNThxVnR0bW5WOCtpYUZvQURkSXVrUm1haTFGcUxzYnpvMUg2?=
 =?utf-8?B?SlpZbHZFWUJOd0huVDIwZVhIUkRuZEhZdXc2elhzR09BOGZDSmV4QUJabGZo?=
 =?utf-8?B?QVorN3RLMnFCcWxMckJwM0hPR01nYlVzcVBDQVE4ZGJlS0NsT29zaDhuQUhB?=
 =?utf-8?B?eVRYTGVRRkdXV0tWbS9OSE8rbFBHemI4azZSdEdXS3hmcm1yZWpZZ2NMYlNh?=
 =?utf-8?B?Z2tiWk9iTUE3ZCtIYU5sZWZqT2ZIbzZGczNRMEtTQVFxTUx1bVFENUJCVVBr?=
 =?utf-8?B?dHkwdzRYclRFYlYvc2tLWTBrb3JHWDkySlhSMGw2NFdjVlZISGcwWXR5b1gw?=
 =?utf-8?B?NUlPcGx6N0RCYTgxenhHdTNRRDB2R1RadDUxZ05FWkhlY3JqclFyb0Y1Y1Fx?=
 =?utf-8?B?Y3BPSVZuckpyZUFuTEd3SDdNcUpyVXpJVXhpWjZ4d01KMU5ra1lUZXJWeXc1?=
 =?utf-8?B?YjV3eG1ONWNFbEwzVndmSE5xMENmUVdldGdqRld5akt3V3FlaEN1TWFESmdQ?=
 =?utf-8?B?cGdYZEVjTmVqWGVPWlBvblJ1Z21CYllrNktEQmVEU2tWaUYyTS9IZUpSUDZj?=
 =?utf-8?B?WlUzWGV4Wmo3aFB6TFE1bndZd1Y4YkJuU0dZMG5LMitHeEhiMmhoa2FiWXdj?=
 =?utf-8?B?OXlPRUgvMGxXVjJQQmNmQmR5eXpURVJjM2FHZzVVb2IzbGREMmRjcTFSK3FD?=
 =?utf-8?B?cUFQNjdCdjYva1VranZKRFZ6WndITnZZV3JpRHBNWE9XYldqSU10VzQwakxT?=
 =?utf-8?B?QTV1S2l3WlpPaXhlWnc5Ti9IMCtxZkU5R09GMnlXNXJGc04vSytLSFJaSXVS?=
 =?utf-8?B?YTZNU1dveml0eWxiSFRqWVhzOHdCeFpIODlpZUVjWHhCRnNyck5IS21aaWxy?=
 =?utf-8?B?UjlpNkkxZUp2cVlpSU1DTXJZdVBXTmxGby9jaytMT0lMTGM3bXFoUEN1dStL?=
 =?utf-8?B?NlRFdnVndVBSUEFUeFppMXFGQXd1cm1Bd1dNNUlPcWMzb1NudlhLUWZBc3ls?=
 =?utf-8?B?VWZRWWY2VlBtQ1RyaVpwcWZ2dUhGRHVVUVltTGlNUy9oMEo5dHdYdG1Genhh?=
 =?utf-8?B?MmM2a3I1RENEODZRcWJiZld3dS80YTdDZUVWRnRCYVZFSHgvQnVMSHFUay81?=
 =?utf-8?B?QUYvemRYbGVDYlNDTEZXS0s4QXYyRlRtd0xhK1g0cEY2NkNGUi9WU1FyanQw?=
 =?utf-8?B?V3NwYklMcXpTNXNaUlg5c3loSG00cFh6b1VEYlkwR1BIRWRQWFpYYmM3Y3dN?=
 =?utf-8?B?VTQvUDVmZ3pMWFZhTTlHbkE5R28reEdZM0FFSGZNcGpHeFBFUVZOclZlVVBi?=
 =?utf-8?B?cTdqdERxSjBoaElLb1BkQVdvZHZSSXBDd3NPTFJlSUN1WHdxb2V6WG84Z3hK?=
 =?utf-8?B?ViszdFZrKzIrd0ErN2pvNURQMzZCbnA5M2U0T0syMXlwOTRVS055dkRFaTBY?=
 =?utf-8?B?US9KakNOclZmQ2t1ZlZlSjArWWVXSFJURHNqa0ZNbmlXYmkxOHdiS0tqMnkv?=
 =?utf-8?B?MlR6aDdlWUU3cWVkMzdTNXdybW1qdUFsSXdIMEJ4SWY0bWRBYkprNUd2c256?=
 =?utf-8?B?czJqTE1UalVCTjV1aFI2ZGdnWkZmSDM0ajM5VlBoc0V2OGpmRmJiSEhRSTBz?=
 =?utf-8?B?Mkc1UVM2RVg2eEhyZUpBREpZMDA2ZzhKWmgrcVRjeEY5Yy91bG1MbXF6bmdw?=
 =?utf-8?B?Zm1RK0l2NHFvZENSa2I2elE2ZThNN09IRTYzVVZBQWhhbFNLSVl3ZkpuMVhW?=
 =?utf-8?B?TUYrdWpXNTllVGhYTXZjOWNSTEI1MnMzYjFGNHlaUHMySE4yT1RNUXJFME5U?=
 =?utf-8?B?QVNKYXNCSjFmMENDdzhBMFlyajhJeUUzN2NJTnJUejdvdlVoWXh5MDlrRkpM?=
 =?utf-8?B?MXlPaUY3d0gyaGtUQ2htUUpvV01BcDNQRVVBOHQwcTB5Z1pSbFkxYWlob3NS?=
 =?utf-8?B?TlZXZTZ4eG5QL3AycmQvVld5WTNTcHdZRUpYQVZIUlpwUnpIWnU0VE5Ddi9n?=
 =?utf-8?B?NzA2K3JjRDlwRm1GWFJvOCt6Vm9uQ0c5MzladUhYTEFoRERIZDY5V2JqZERK?=
 =?utf-8?Q?/s8ekaMFEnCw9+Iy2GDd9QwWG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53797726-0965-44fb-3b07-08ddbde40cd1
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 05:55:32.4909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fh3cclTC/yyA9q72Sj33+2V+1ZViM2cCNLOeyq0xlnSWgYb+7YrG0hxQAkeMqQ5f7xl9nkxPF7w730tD8XLhmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633



On 7/8/2025 12:20 AM, Luiz Capitulino wrote:
> A race condition is possible in stable_page_flags() where user-space is
> reading /proc/kpageflags concurrently to a folio split. This may lead to
> oopses or BUG_ON()s being triggered.
> 
> To fix this, this commit uses snapshot_page() in stable_page_flags() so
> that stable_page_flags() works with a stable page and folio snapshots
> instead.
> 
> Note that stable_page_flags() makes use of some functions that require
> the original page or folio pointer to work properly (eg.
> is_free_budy_page() and folio_test_idle()). Since those functions can't
> be used on the page snapshot, we replace their usage with flags that
> were set by snapshot_page() for this purpose.
> 
> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
> ---
>  fs/proc/page.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index 936f8bbe5a6f..cb58f066eb31 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -147,6 +147,7 @@ static inline u64 kpf_copy_bit(u64 kflags, int ubit, int kbit)
>  u64 stable_page_flags(const struct page *page)
>  {
>  	const struct folio *folio;
> +	struct page_snapshot ps;
>  	unsigned long k;
>  	unsigned long mapping;
>  	bool is_anon;
> @@ -158,7 +159,9 @@ u64 stable_page_flags(const struct page *page)
>  	 */
>  	if (!page)
>  		return 1 << KPF_NOPAGE;
> -	folio = page_folio(page);
> +
> +	snapshot_page(&ps, page);
> +	folio = &ps.folio_snapshot;
>  
>  	k = folio->flags;
>  	mapping = (unsigned long)folio->mapping;
> @@ -167,7 +170,7 @@ u64 stable_page_flags(const struct page *page)
>  	/*
>  	 * pseudo flags for the well known (anonymous) memory mapped pages
>  	 */
> -	if (page_mapped(page))
> +	if (folio_mapped(folio))
>  		u |= 1 << KPF_MMAP;
>  	if (is_anon) {
>  		u |= 1 << KPF_ANON;
> @@ -179,7 +182,7 @@ u64 stable_page_flags(const struct page *page)
>  	 * compound pages: export both head/tail info
>  	 * they together define a compound page's start/end pos and order
>  	 */
> -	if (page == &folio->page)
> +	if (ps.idx == 0)
>  		u |= kpf_copy_bit(k, KPF_COMPOUND_HEAD, PG_head);
>  	else
>  		u |= 1 << KPF_COMPOUND_TAIL;
> @@ -189,25 +192,19 @@ u64 stable_page_flags(const struct page *page)
>  	         folio_test_large_rmappable(folio)) {
>  		/* Note: we indicate any THPs here, not just PMD-sized ones */
>  		u |= 1 << KPF_THP;
> -	} else if (is_huge_zero_folio(folio)) {
> +	} else if (is_huge_zero_pfn(ps.pfn)) {
>  		u |= 1 << KPF_ZERO_PAGE;
>  		u |= 1 << KPF_THP;
> -	} else if (is_zero_folio(folio)) {
> +	} else if (is_zero_pfn(ps.pfn)) {
>  		u |= 1 << KPF_ZERO_PAGE;
>  	}
>  
> -	/*
> -	 * Caveats on high order pages: PG_buddy and PG_slab will only be set
> -	 * on the head page.
> -	 */
> -	if (PageBuddy(page))
> -		u |= 1 << KPF_BUDDY;
> -	else if (page_count(page) == 0 && is_free_buddy_page(page))
> +	if (ps.flags & PAGE_SNAPSHOT_PG_FREE)
>  		u |= 1 << KPF_BUDDY;
>  
> -	if (PageOffline(page))
> +	if (folio_test_offline(folio))
>  		u |= 1 << KPF_OFFLINE;
> -	if (PageTable(page))
> +	if (folio_test_pgtable(folio))
>  		u |= 1 << KPF_PGTABLE;
>  	if (folio_test_slab(folio))
>  		u |= 1 << KPF_SLAB;
> @@ -215,7 +212,7 @@ u64 stable_page_flags(const struct page *page)
>  #if defined(CONFIG_PAGE_IDLE_FLAG) && defined(CONFIG_64BIT)
>  	u |= kpf_copy_bit(k, KPF_IDLE,          PG_idle);
>  #else
> -	if (folio_test_idle(folio))
> +	if (ps.flags & PAGE_SNAPSHOT_PG_IDLE)
>  		u |= 1 << KPF_IDLE;
>  #endif
>  
> @@ -241,7 +238,7 @@ u64 stable_page_flags(const struct page *page)
>  	if (u & (1 << KPF_HUGE))
>  		u |= kpf_copy_bit(k, KPF_HWPOISON,	PG_hwpoison);
>  	else
> -		u |= kpf_copy_bit(page->flags, KPF_HWPOISON,	PG_hwpoison);
> +		u |= kpf_copy_bit(ps.page_snapshot.flags, KPF_HWPOISON, PG_hwpoison);
>  #endif
>  
>  	u |= kpf_copy_bit(k, KPF_RESERVED,	PG_reserved);
LGTM

Reviewed-by: Shivank Garg <shivankg@amd.com>

