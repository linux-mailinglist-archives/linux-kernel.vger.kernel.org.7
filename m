Return-Path: <linux-kernel+bounces-880248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 244C5C2534E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C2001350B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A4134A797;
	Fri, 31 Oct 2025 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0TLXEmbH"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010049.outbound.protection.outlook.com [52.101.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23E41A8F97
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916348; cv=fail; b=BTx7hKhZHmy2v1mLlJ4hngOqm04YUTMwQvjO/9b3hEnruSWGVtxe89k7tISa/SrtjbVDabk22P//EOC0M0Lpnhb/QXbKj+MTLW+EWUkBDeZMHVvhh+uVBgEfMvSLKbLCfC2jIoQ5p4QtIVi+FeiUzpa1j9cPAIAEAOZxOGqjArg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916348; c=relaxed/simple;
	bh=rj9XfSiztB5zHvlLHixtClUZqYv38GHqiIW+z0ffcBQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lI3SHwbWGxev4qJ6tQny6XLgOKcOPP5MstuGjoVwJG1TxOdzIyTxYENbTF2j4Zk3AxQpxKv/hsvaLur4X2fJDkBbNQPV4gU75H4zneu9NC1CrYl/wtQ3eNbuj79R7c+xHXWg5kns0rVYoRVdc7aN+9oqMhCZ+9nLMz1EVlqQSxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0TLXEmbH; arc=fail smtp.client-ip=52.101.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuLuzJiP24D69+ng72Rcs7xlHJ2ZuDETC/lxvAgNNp/iIZvCvg99/rLHqbLy0dmf4n+za1UrAEKGa4df4mSIQrAurmFpHGfeRceMJ+oiotXpxOwYEZH71O9uQEpG0029TzP5hZ4DbZZFJC742YMb0ZdeMw/8Qv9PYVBIooAwJ33tc+V+UhDFtxWOcPbKqXWJJkqosagvk46+7aYOnKQ6LR7cDF8SzsN4sMD6QWkvzXei/oAf6Ra9CKEuSrzdv/CbF3M7QLwqpKw6bUogOvctfPR3yCueh7hXxEKMc/tMZpSmPM8T7gzWL2hMI2mgEVBrV3NmgmKnyMCdpwm6onr1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rj9XfSiztB5zHvlLHixtClUZqYv38GHqiIW+z0ffcBQ=;
 b=AsG7IxEtIFcQ+rix3lxB1c3L4B0BodttDVhzVtiSbs6ndhZ7sKBkoeUCb98WD1Ilak+lcAuVX8iSBtKQthlDLGYZ1DaZTJLqFYpJakSBDu5PmqgB55rwITAL2exPTjNohN6n77kyhtpThW5IvmzUoVAi+mOSxGUBVANUui6gnk0gOMwCClAJVBAFHRWKCA4L8gLK83d7t87+KDX8ihcE2Cgt3+BpxH4SRbYwApIrrK+T6r2ZfdMV2WyuQYCxUsBUXWeBen5MZHX2WGc3X5N1fYRbD5HDSMH6leWIQgLdFvpIAwpeAWa29WadyfPPaXtRfMxhobgYowG3TulZMDMhKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rj9XfSiztB5zHvlLHixtClUZqYv38GHqiIW+z0ffcBQ=;
 b=0TLXEmbHWQIIp7R9uHK48ZIWdMsoa9Iw1jxVDzQpw3yal83fzKylIYx+kSjN1PheDFuF/o5+YQ5r/fTd6wkRyn484HSYlWbxkgO550QUSlSRVklL6kZJoAxaHeKDHLWirI9SZRUWmp53mCxJ2HPxT7AxL0cZCuwFHSTRj96sUUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 13:12:24 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9253.018; Fri, 31 Oct 2025
 13:12:24 +0000
Message-ID: <42c631c7-7773-b029-6d59-a54112363a71@amd.com>
Date: Fri, 31 Oct 2025 09:12:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] amd/amdkfd: WQ_PERCPU added to alloc_workqueue users
Content-Language: en-US
To: Marco Crivellari <marco.crivellari@suse.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "Yang, Philip" <Philip.Yang@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20251030161011.282924-1-marco.crivellari@suse.com>
 <20251030161011.282924-4-marco.crivellari@suse.com>
 <690b3fd0-20a1-4245-8fc4-4e8b40695c98@amd.com>
 <CAAofZF4V7gN=AqgLwcva+zhJyROYfSjzJ2uLxoNeS2KLuytW9Q@mail.gmail.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <CAAofZF4V7gN=AqgLwcva+zhJyROYfSjzJ2uLxoNeS2KLuytW9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::23) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MN0PR12MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb3fd0e-5f2f-4d68-2181-08de187f21cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1dRdVJTSHdCWUgzWTk5RUtoTzRtRW4xak9jZlp0eEVUanVUSkx4MlN5QU5j?=
 =?utf-8?B?aTlIUXlUWHowMStXeUlDRHlBVjJkV1k1RzVYdS9tUzBubGJUQmpxR2VOMWVM?=
 =?utf-8?B?M2dRdzJJS0hJcXZoVEhFZ2dqcjhkbHEwWWVPQk9mcitNTitjR2ZrVHJmODNT?=
 =?utf-8?B?NkEzQnJuNGVlb1l1SHQyQURvbFJrQnRMTExaRkUvUzhneHhmcmdGL0JSeDVD?=
 =?utf-8?B?eTl3WGZ5QUJGMWlhQUNKUVdCWWt6SjFMaWZLenVYZFlZSE9Pb0k2WVVqVDJI?=
 =?utf-8?B?Q1kwSjJRa3RSR2diTXhyZ1dEMXpISHJpZjQxWjVzVHlzZ0MwOWdMSTk0WGVs?=
 =?utf-8?B?SW5iY1YySlJVYVIwVWw3ejhPOCtZeUY1bEFqbXpoR1lNYzV2Z2JsUHhpTkpy?=
 =?utf-8?B?UTJzNlJNVkhIYUVQTGZJUzdqcGlRVG5UVGZSQTRPdVZ1Vzd3UTB1TDkyUFRZ?=
 =?utf-8?B?bGJuWDVhTnJuMk9rSkw0UUNDUmNmRlNXWUlleklvZFNpSE5oNWswUHdyWk94?=
 =?utf-8?B?azJMUHJ0bWpDRytORXlnRWVXcU04U2EyTis2dHRPRndBcXpVcmcyWFE5c0I3?=
 =?utf-8?B?L3VreHlpZWJWY1g1YXZlMjFXODZPS3cweTVjQUozcHc0K3NGSHhENGVzN0ds?=
 =?utf-8?B?ZXRjWjlobXZxUENYRTA3MDVqYnZhUDhOSmxmdm9TeTBNQ21Ta1dqTCtEa3Nl?=
 =?utf-8?B?UUd6dGg5WXJ2QXZBajFYNk5rNHdsZ3NIQ2hOZC9weHlKYzVzZFVHTE1lR2Y1?=
 =?utf-8?B?dTRySzJoQURDd3JDWW1uY2xDaGwvMUdKTnE5aTdBUVYvVk1GeUJLNWVrenRt?=
 =?utf-8?B?SlNiS0dTWjZvKzdYTU11M0E4U0ljcmltMk5VQVNiKzdZZ1BaWDV5T0FoZ3NK?=
 =?utf-8?B?UEdRRWZPTm1QYkhZMUpqaWRJZDVDZlBmcDA0Q1YrSDZXazV2ZHlpMXA3NnBJ?=
 =?utf-8?B?aFdJWG9DYnBjZXB3U1Z5SXZqNko4c21UdUYxblJTa1F2K2xvdXU0THFYQVNk?=
 =?utf-8?B?OEh6Z0ZSVis2Mzk2WmxQMmJQMjRjOC94RXZrMjkrSWY0SDdNUmlQRjdUdGVx?=
 =?utf-8?B?MlpMWGt6WXgyaUE3a25VUlBvaW16cE00UXBycW52SU1OWFV0RlNqMUFzdWdp?=
 =?utf-8?B?R2VhUHk4eTVkY1R4NVVnZTN6K1N0RmE5QXllZm9PM0VvcnhyMEhOL3VwU3d3?=
 =?utf-8?B?UGpUdU1JMWtkK28zemViR2V4VHVYVmlac01mYUZoOG5maHppTmdiZ2NsR3Fl?=
 =?utf-8?B?a0R4UmN1NGFCN1JGTzRVQndHUEMzUVJheDBMV0ViY1BxSGNIZFZkQ0Z5K2c0?=
 =?utf-8?B?aTZxdTZSK2VCdlQ5ODdUT3lFTUYvdEZKVHJZcEN2bjNTc05RUUxjYm5FclVP?=
 =?utf-8?B?RUZ1Y1h6L2k1T1lmOXlTMW95YmtIOC83amovWnlNdHJLeFREZjlwZEloTFFn?=
 =?utf-8?B?c05BRGpHMFRjSFZBZm1hd3dkM3RlSHRTT0JXeWY4aXAyWG5OQ3J2RS9SR1JU?=
 =?utf-8?B?aDJjeUF3OXQ2djQ0SDU4ZlIvTEEyamFNdjBlMkhiUEhHVFNYWWR4dkl4eUZZ?=
 =?utf-8?B?MEtueENhcDAxMHFTSHFQbzRldXBPZGFzTkpqTkcyTzVDNUxaUmpZRzFiZGkw?=
 =?utf-8?B?WG5KSW9YbU1Bd0ZRcFhHYUphc1JqRmhCYkpGMk5lQzlHbEFGK2oyS29nM2kw?=
 =?utf-8?B?TGgwZjJMa1lvTCtOa25RNVU0K0cvckt4L21EeURaV1lCVXpVelNEem80Umc3?=
 =?utf-8?B?SzVsSlZkbzRhdnhOU0FJaHpDbFRRZXJCaDY2eHNFT2lCZ2pkUzYwZHNMTGMr?=
 =?utf-8?B?bjlUNUYrckVaMUxScHhsdTVIZnhaRXhhdU5HU0dhb1VCOHpJN3lNVkloZFZt?=
 =?utf-8?B?Y2xlU1MwWG5EcHBSbElRbHNwdGpmbDc4MEFpblNxby9NYmJnTFR5c2l1Yytm?=
 =?utf-8?Q?zJeZ4NRR2HK5oU/yN+vWy66i0xHiIdWq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5149.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajh2a01FTjRseVUvcUZ5bUxibno2azJJWGtJallyYUN5ZUQ5R3QrbDhvUGxR?=
 =?utf-8?B?czNIdDhaYWJGVnJtaFZqWjRucGN4WVpIeXVvSEFaL0NZNklxemhMeEdlaFJn?=
 =?utf-8?B?bXpIeUtJZlBRNDBOSGxJY25HaHZ1ZG5YRU1wOU5FWFpsaUZmYUp5V3JkYlhw?=
 =?utf-8?B?OE5rOEVlR0lLWDB4anlBWk12WklVMU1wSGxBUGorZmdPM3diOVhEYnBzeG9m?=
 =?utf-8?B?QmxqZEVaZ3Y1anQvOEVmeVRaQWNBSUxqZk5lWUZRV1hZb3JSK1plWVRjUnRw?=
 =?utf-8?B?VzdGUXdsWlhIR0JieWJLNzVSRmRGaXFuaTQxdERJMUFaRThKVGk3MWFPc0tP?=
 =?utf-8?B?VTJWU0dpTjM0eEQzQUtPY09lZHNpbm9PSWh6ME5ubjFHVzd4RVg2akExS0g3?=
 =?utf-8?B?U3RodmNUQ0dYMzk5RUhMZ0MyNVB0eXBYVTZHcTFJamd3RjdBVUFvU0FQSjlF?=
 =?utf-8?B?WVFHYTdObmVVT0N6Z2Q3Wnptd1ZPeDR2RE5tMklwei8zc3ZyaWg0MFNWSUIr?=
 =?utf-8?B?SDBUeDMyS0o5eVJTZTNIZWtadENUN0UvZ3p5dVJFbGNSSnFOekNnSHJOaEVM?=
 =?utf-8?B?M2M3TWxlWTVQZ21wVEEzK0lRbDBUNWxEQ0RTN1Z6LytiMnk3cEFOdXh3MURR?=
 =?utf-8?B?anRicW4vTG9oMThlRFBrN1NzOXB3eTVIVkNPajJFeW1rcXpPUWFSbUpJaURz?=
 =?utf-8?B?MVVZcTU3N2ljek5pSGFBbGJTdW5IL1o4SDVIWVNzcS9uZS9VcTRLYlIrcmFN?=
 =?utf-8?B?eWV1RHJLQTFKQWI4bDFMMGtuRm14ckp4UXFHOHBPanJVeHVaMUpsbEpiUGZo?=
 =?utf-8?B?UlhibmoxOGNndkJMUUp5MklhdzdYQlZmTVFROFZhSGxOTDRBNmR4aUdTdmVK?=
 =?utf-8?B?R2dwTHdEcnRNTjFUbmRRY2VZK1R4VlZEMGxrQUsveHplNC9SYzZsaEI3L0lU?=
 =?utf-8?B?VjB5aVN4WmNmWFZjelJRMFhmaFVFSVZTRVpmYVZ1cysxL3R3WkcrUno4c09F?=
 =?utf-8?B?cEJDL3lBREZ5ZU4zdmMra2M0NXNwMDJwQmxUbmNwemNOczJSVU9BdkpNZUov?=
 =?utf-8?B?QmIzSnByNklLc09SNnNOdXNwUlU4eEpmd2tsSlk2TkZySzFMbzl4ZThSdGFS?=
 =?utf-8?B?MHpGUGJZb2xTTVByYmtvWm1aR2FzTWJ4b0tWTXpybitDQkVSeHJ5bkZLSWV6?=
 =?utf-8?B?NG9lZTJwUkd3NWJ0Zm5SZXVIVS96WU1ZLzM0Wi8weUYzY0ZaYnFDUVM1TmdI?=
 =?utf-8?B?U1gvSnByYWZFeFlhZXBTT0RmQUhLZ3pTVDZadnBPYXlFeGxNaldxNTRlZFlP?=
 =?utf-8?B?ODhrRHNPWGJvaWJWK1lMa05Ca2xwOFh2STBzc0Q2bitYeDk0UkovbDNoTHBV?=
 =?utf-8?B?VVRrMjFMNDFteUl1d0xvWnBrT1ovdVVpMHhRYmo5QXg4MkxjMTdkQzhEdFdU?=
 =?utf-8?B?SUg1NFo0ZXlYOHJZMUQvcmU4U2Z5QzNOZk1JWUVMK3JscjZIWVFpRytGUEh6?=
 =?utf-8?B?SXBydkxnK0lmR05oYW1TS2ZiVHhlTVFxN0VITjd3WW9ZdmVpS1JMTG1rVldu?=
 =?utf-8?B?bC9TcTAydXg1b1lGK0cxdDljM3B3aW43VDBVL2xtNnhUWDlRVkZSSFRzL3pU?=
 =?utf-8?B?OFZLSm5mbUZEaTZVWlY3dUxxUG9neTVMQkVXM2F6Yk50RXRXOC9VQldOcERl?=
 =?utf-8?B?T0taNTR1ZFNzOUhOaFNleW85bUl3dkU4UWlIZHUxRFkyQlZsZ0tBVUtKSVlP?=
 =?utf-8?B?a0drQnJENmVmRnpXZTBESzJ2VHQzNHFHRTcyUUt5a0RFWnNkMk9tZnRub3Vs?=
 =?utf-8?B?Nkx5MWlRemVoNzZPeC8rNWlEdGo4M2Q1OWdES2NISVJlbUdxNnB2NHlSUUZ5?=
 =?utf-8?B?eXZselZBMVl3eTZyd1dxc3hYQmVkZ2pXbjBqMkR5THJ2NVNNUmV3dFVWRHhR?=
 =?utf-8?B?Q0hCRlRuZ3Y1a3BmTWFiUnBFL1V6WU9DTCtocVJ1ZHZPeCtpd2x6WlNwNUxh?=
 =?utf-8?B?dVVma1Y0STVWck8wVzlLTGhrS3VQczI2OWl6T3JFZDgyWEd0dUV5bHQ5a0RS?=
 =?utf-8?B?emNqTUsybHF1V1NObm83MzdxeURtUEMrUVRaOUwzd0ZBOG5zeHJwSTQ0Wmdq?=
 =?utf-8?Q?emfM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb3fd0e-5f2f-4d68-2181-08de187f21cf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 13:12:24.2026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADkwDpy04cL/t0BEIiHmQsxZFIuK+AYzrducjUWdY9pqG6HxN842BU5gI391UYyQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762


On 2025-10-31 04:48, Marco Crivellari wrote:
> On Thu, Oct 30, 2025 at 6:15 PM Christian König
> <christian.koenig@amd.com> wrote:
>> [...]
>> Adding Philip and Felix to comment, but this should most likely also not execute on the same CPU as the one who scheduled the work.
> Hi Christian,
>
> The actual behavior without WQ_PERCPU is exactly the same: with 0 it
> means the workqueue is per-cpu. We just enforced that, adding the
> WQ_PERCPU flag, so that it is explicit.
>
> So if you need this to be unbound, I can send the v2 with WQ_UNBOUND
> instead of WQ_PERCPU.
Hi,

WQ_UNBOUND is more appropriate here, to execute the KFD release work immediately as long as CPU resource is available, not specific to the CPU that kfd_unref_process the last process refcount.

Thanks,
Philip

> Thanks!
>
> --
>
> Marco Crivellari
>
> L3 Support Engineer, Technology & Product

