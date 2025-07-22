Return-Path: <linux-kernel+bounces-740590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1E7B0D624
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B321891409
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC362DEA71;
	Tue, 22 Jul 2025 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="IQMEID7B"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2110.outbound.protection.outlook.com [40.107.94.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF042557A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177235; cv=fail; b=J+QZowR0f2Cr38AaDfZ0VE/y5LPuy9L4tCnzuQu+ygXJd7KYv+2WEUGgT/T4btx21v2eBKaQwcBRQagplTA4Que0NHEKn5sviOAwt4ZkGK1tmVMgaphCH7G4swyOB90v2sFZHFqnQ/grsrPuoKqQ8FnDWGgKAS30gZkhHUZhLlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177235; c=relaxed/simple;
	bh=wC5NvM3ljbhtMTCxxYRLh8KIZl7Jh5nzAVTJVtj80Jw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tYTabXm8R2WLIdPrrD0+aMSVFzwGASIDLBTaNTVjGhXVM7Tztlkv5VGMYQSUu6p/ecrKmHYK9FuxmXFN5CVjZazanYaBDqiOQ8tH3Y4tqk1+ApUhrjIfuf/aLnUkZpcGDunuF8zbStbGaJ/qXtP4KXeaxTb4fyuDgvxzJm9r4MY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=IQMEID7B reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.94.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVQj4dnQ9+h+yw3C7hDd/7dXLXw9vcBpJcy01M8aK0HDtJzrvLX4BpoqGPmq4NnrrP4LQ4V5Lj8DJLqGsQC0rc/BLABrhtU/ynBQsT/vJ19YZgykcxVtIrCC9B113Hu+6pnQGRvsQg2CI0S/YMSASD6dSFAwD61zeh5uZa9098BYWEk3g9v0ZRk1mHEwnuvZa4byS/bgA1jdTT7LlSzxyRLTp3k2rguqGcBi39iLsUo2DfkIEKh5QX1mUPkDpJnsg9VyT5dI79Pm/9l8rouRezfUHOKa3+irjeodKMTnGN7NG2BeyihTXrYAK+zzNlXI3e0fZ/l3PDgM1GPkqohiiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htOGHzuX0EkEfAeSZ8VIGRVJ+wSDlPbk2SEA5P6v7oI=;
 b=aTDY18D6btnd6Us0jXE2iU27h7t+gf0H/SLfm/8Mosr36KYhPo3i6IaibSG7oiVkgymfLsdWOD43UC+bd/9owozfYsAZYPmTsn2lHEFo4c68BgdsPmn2VXvhk8sPHuB56WyETASFFiDYHs/AfZaTUXu4hMhjpkaPhZRFYiiIt1ed2bhNPbZBF+TCXlQp1ut6fXn/t0yKEBc1L0ml2sDFkxVa55EkW59wFKjfmGkpIAxZ/2i0JAfObOWzqalTjJWbwy3mFg3Bgieq6GmY/JiOBH0M0J6Rt6uG27+RQz1fQuKKjgwFV0uQCIFx1qJYgA4+VpU6A5Ufld0xch+c7DFmag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htOGHzuX0EkEfAeSZ8VIGRVJ+wSDlPbk2SEA5P6v7oI=;
 b=IQMEID7B0wMCnjqXK4C8Yjoxyf5LkFwzG1V39JfF6VQlQ8xGaIu9zaG9xHlI8esOvnu3YwKkOxs0beKfwsMjzL8wKu904kMcVi8F5ZrnC+ibSeJ4bLZNfBCHPyWPUV9+YxfUlDVRVS5BdeaT1irOn6VVa078TDF8io/2vQr1oEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 BN0PR01MB7166.prod.exchangelabs.com (2603:10b6:408:155::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Tue, 22 Jul 2025 09:40:30 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%4]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 09:40:30 +0000
Message-ID: <7748caaf-4f32-461a-ba32-9311c04fec63@amperemail.onmicrosoft.com>
Date: Tue, 22 Jul 2025 17:40:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] sched/fair: do not scan twice in detach_tasks()
To: Vincent Guittot <vincent.guittot@linaro.org>,
 Valentin Schneider <vschneid@redhat.com>
Cc: Huang Shijie <shijie@os.amperecomputing.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, patches@amperecomputing.com,
 cl@linux.com, Shubhang@os.amperecomputing.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 linux-kernel@vger.kernel.org
References: <20250721023939.19703-1-shijie@os.amperecomputing.com>
 <CAKfTPtC7+V6ubaGDPy0MW2MFG7w_yrnYCPQ-b2=3uYgeM+-+EA@mail.gmail.com>
 <xhsmhv7nleqfl.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAKfTPtD8uF=6kr=RpduggahJRztH4DtQFQ5Q5zM6PWY8EESfxg@mail.gmail.com>
 <CAKfTPtBxtAu1=p22Z5N7_EMeTMyRvN-gQDa_G==dTDDKtPdYzA@mail.gmail.com>
Content-Language: en-GB
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <CAKfTPtBxtAu1=p22Z5N7_EMeTMyRvN-gQDa_G==dTDDKtPdYzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0059.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::20) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|BN0PR01MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: b9fb56eb-9d4b-4c9e-1c10-08ddc903cbe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDAwd2pMVzI5c3ZNRVE3NmFqMXVuSU81bFFnVUova3RCVVBqa1AwYy9UU1Vv?=
 =?utf-8?B?MzcxUmhWRTByY2dDdXovVE1wVFBDUjhTaVVNODZGM1E2T2dncjM2citSTWJu?=
 =?utf-8?B?SzRVQU5hN21ZTUFBU3M0OFJFQnBLRGtwRGVFZUpPNlJpbkZ5VzlJTVJpdFVx?=
 =?utf-8?B?aWJhaC9ZUkJCQVF5b2p4TEZMeWZUQUVsbFhQSFgvTmdzcXZjQWhhVHdmY3FB?=
 =?utf-8?B?SmtyclErVUZqZEZpQ2ZyMVFCS2RySHJpMFovRWJLQ2syMWlPbVhyNUxNQUdz?=
 =?utf-8?B?NDEyMW9BbkRrVzA2RUc0NDVaK0puRkhqNmx1WTNQOVVqemNaN2VCQzVBcVp0?=
 =?utf-8?B?S2RQUFVaQWRLMlBrUStxcHhVbXk2VEk5allxTVhhNlVLV2F1TDRZYmhRb0JP?=
 =?utf-8?B?a0tWNFdDTXNlTDQ3MDJnOHIvNEJ3Y2QrWkREM1hjM2JUeHlvQUZnR0h6N2lp?=
 =?utf-8?B?OGxWQ0FENnFHQnlBS0J2R3lpY25hSVhxMDhSK3p6WWhZUGR0WFRabXR4Q09R?=
 =?utf-8?B?WCs1dzBpc3NaM0VTZVFYVU5uSllBU0ZZY2ZlVVMydjFhZzV1ZmVWTU1rcEdn?=
 =?utf-8?B?eXdPRjFJZWZqUG83UWg5ODkvQit2dm9INExXaTU2eEZZY3cyZ0UzdGJ6dEhp?=
 =?utf-8?B?SnFqdGRndVczYytqQ3ZrWG1JSHFkTnFoNTE2QXdsOW03Ukp0bFJ2SWJvZjBB?=
 =?utf-8?B?UUl0RUJjNXZVV01JUVNQTzZBOURqNHNHQXZGZ2ZHdGp3SUlUSlhOVEdNV2Rm?=
 =?utf-8?B?Z1JhanpBSGxwajE0TWRBeHVacWkrbit2azlBa21RNStxczA2VWVtVVUzMGxH?=
 =?utf-8?B?aFNFejErVU16MFVIZjV4bHVVQXB4eDNTZ2ZXcTQ2Sy8zZWNndVk0Q0VoOHh0?=
 =?utf-8?B?b1oxSjBIemIzNjB2NHRRSytLZ1NDU3FQRjlzc2luWkMwOWczNnN0WGtlSVJU?=
 =?utf-8?B?RjlrRGRWVlRaeW9qdlU3NkYxOFltZUZYOUkxQ3Ird01VVXJUZk1OTFFZakdM?=
 =?utf-8?B?SmN2dFlabkVHbjBFd0ExSTdVTFZBU3JlUlUvZ2NlRTZQMjhLLzFwbEc4S3Zw?=
 =?utf-8?B?cDRqRCt3L25CK2w0bFA2cU01RW9lUkdUVWtDa2N4SWh6djRzVGZNTlQ4THN3?=
 =?utf-8?B?YWgyN0w4eGxjT2o4RUxZUmZjMUNFdUhjdERkVzFFaTdtbm5DelpXTzFCREFa?=
 =?utf-8?B?ZnlhTE9qdWRsVUlLRHJ1UDF4V3NTMEpJQ1ZUMjBDd2dPZXk5WlFnMUNmRDVi?=
 =?utf-8?B?UjBobXdEaG1CUmNyMFJQaUtmZHg5NlFha0NDTzhJUXlLUm9SUXRpMVhqcmVT?=
 =?utf-8?B?eWpCZkl4b3UyakJENUZlQks0Z3NpemFtaHRrbThGU3ZSQ2MwaGtPQmo4Sm5z?=
 =?utf-8?B?UmFxOEJUcEhqS3pUWnVPVUU2aEFnKytPSHg5Y3kwSHh1VXZneGI5ZGZyaTUy?=
 =?utf-8?B?cmZFaVFPM1BtZk5pSklkcUJJTFpQd0IrNk1IbFR4TU41UmZmYTVNZzJnZnY1?=
 =?utf-8?B?NVJjeThjM3lJalJ6T1dmSGd3aEhNTFNtWUhxKzJ4cWVvbW9IVWprQTB1Vytj?=
 =?utf-8?B?cFR0di93QUZtaTNQV3AvVUdPbjRXaWt3aXRkY0xXRW1KQzdqQ1FHWk9KY1dZ?=
 =?utf-8?B?cEhOeU1FdzNJcGI2eTgzZHdSYXBvaXNXVHRSSWlBakVDV0o0YmwvbklwbDBl?=
 =?utf-8?B?QVFwYWFWY0dKendWNy8yaVgyOEl4MmNiTkZDNHUrZ1ZQWjhsSk81TWVlRS9p?=
 =?utf-8?B?aTE5aStPY0ZJd09OQWliN2RNV2NOT2M5ZGEwdXhYbmVIQjRQdlpPZEgrZGYz?=
 =?utf-8?B?Wm9lcEVCalI4QmxuSDVDcEtvK25Jc3pVVEdOM3duQ2ZUNGdyQTNFWGgyRkZn?=
 =?utf-8?B?TXNkTVlkMyt0eEhjdXN5VWEzaFkwRVVQSnF1OU1KWXFuSHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUJLWmwvTkpDWFpJeFZZcVA3bmEzY1g0WEpqTmxQbU1IOU9lSEVCbGdHQkEy?=
 =?utf-8?B?c3VIS0FiS1JtalcxRlhrTDJvby9oVkd2YXhFaTVPY0FlYS8ra2JXcDIzNGtQ?=
 =?utf-8?B?bTdiTEZZUHF1SkwyVWlBNFVzdnVuUDVzNDdGM0Q5YVZVckxXMFFNZ211WWlK?=
 =?utf-8?B?UmRBUnFJOEMyYkZyUitia0pKeGVoZE5Pd29uM3dlMzNRa0tJWGJna1VqeXBz?=
 =?utf-8?B?SzJvZjMzaUQwZ2czSDFJU21aYk1iRkJGS0lLUHFDWnlHLzJrelhzcTUvU2pJ?=
 =?utf-8?B?YUd2Y1JmalhEYURQVWg0cUZIQ2ZtUVVDMXRnSzBJT01sU0NIQ09wRmprZlJO?=
 =?utf-8?B?RE4yMUU0a1AzWXFaTkRGY21MVDE5WTQxVzBFVUl4M1AxTk9vekx3MkpaM3NP?=
 =?utf-8?B?ZTllU2diU2RuZmtxaHlWcWpWZ0VMUU81cWdqVSsvTDB2QjlUMnBHbktJajJx?=
 =?utf-8?B?enYra2pTV24vanMzMGhybTkzTUhNZFBFQWtZRjNvZ245bTBHVUozVmVKc3Q2?=
 =?utf-8?B?bExjcTN2ZUcxM01vbmJSMjg0Z0RtU05oUVkwandQTE1SZGJIQTVpUXN3a2hK?=
 =?utf-8?B?OGdrWHhwMFNzbFVOcm54WmVzelF4VDk1d3ZpQjR5RURJUUovWVlETDNHdzNz?=
 =?utf-8?B?VGJ2YWhYS1p4MTJud2VqSHEzdHg0Z3hqZDlVNUhnaER3bG9sREtCYlpCMXpH?=
 =?utf-8?B?M0NhblZ1WnE1TTRTS0Zaa2ZGQkZhM0djT25lT1ZSZDduNUNGL2d4cHUrcUtr?=
 =?utf-8?B?ZXhQMnBCaHJvY2JwNEdqa3I0YjJzMnZKUUUrY2FXVUJMR1VwVGRvdDA5YzZY?=
 =?utf-8?B?TEh4am02dXpYWFRHTW0rYmRmWThPQkxvSm1ZNmVuUkJCa0ZSZndRQ2ZDcTJE?=
 =?utf-8?B?YzdYeFJLV2dZRlNYM0N3TTBUZWdhUFhTRXJPWGN0VkRBMEZBMTl6anVvL3ZM?=
 =?utf-8?B?NXZJM0wrTldqalZEeTdvNWEyS0tJdVhKVVVjN2xSS1E4SW9pSGdGWWd6MkJk?=
 =?utf-8?B?clEwamt2cmZ5dDliZk1PdC9veEdXalpTMENCMWpMYmloUlpqenFycVhlR1Fk?=
 =?utf-8?B?YWlmZ3ZZc3VRbXdEMUpDL0dCRVVCWEFEK3hYQXZlNFZBWTZOSWtpbm5jazJr?=
 =?utf-8?B?NXY5ZitHalg1S3VncDNvVW9QWTd2cEd0WHovSzA0cFhmYVk2b3k1ZGVMVWVS?=
 =?utf-8?B?K3pBVWlLdUN0RElPZUsrd253anFoOEdkSkJkVTBWcW1oWnA2R29qU3cyTW9O?=
 =?utf-8?B?ekxtaXprSThaLzNxSVpKSS9oT2UvQ3hiRVR6U1QxVjNYaUx0Y2c5ZUdhSDFU?=
 =?utf-8?B?ZkMzYmhRZ1J5TytHd2NxZ25nRGRIZ1FZdGJWQ0Z5bVM3Zmh2SVh3dURWVklt?=
 =?utf-8?B?bkVqb0VkZG1hTm5Za2VWTURqVUdWejFZd0VPSDFpSWpsUExYRXgvaXBseGtP?=
 =?utf-8?B?SHY1Q3MzVmRESFFXN0I1ZHJUa3NacU9PWVBQTUc0ekh1TEVrQXNKYlB5Nk9w?=
 =?utf-8?B?bitsa2xGb3p3YzFzNGYzWXV6TWQ3dDlNZTZKQ0hucWgraUEycmxyT0pyRC9O?=
 =?utf-8?B?MEgrbXByei94YlZ0NU9rcVQwbUs0ZmRSNFVjWGtyVkFXOHFlYUtuUXNOY0J3?=
 =?utf-8?B?Y0JiWG1aYkEyTUFqanBXajZiT3ZiUDN2MEtmTVI1M3RjYS9SNmc2VWUrVWdw?=
 =?utf-8?B?UHBqdW4xN0hsSzBPV213WVM0TUloaXVrNGNsQ2J1cDh6VHdjSkxJTjJYenlk?=
 =?utf-8?B?NEhWdWRFYlRtUVcwOXBqcW42M2dYNkV5UitXV1VQRE9ldkZCUSs3azRTeitO?=
 =?utf-8?B?c0NjZG9kYkEwSVV6MytTNnlIdS9WOE9DeldqVnVSODRVWldOdXhDMGZhWDhm?=
 =?utf-8?B?dnRocVg2c3ZqME5laTJJTnBaR1FNNTNFQUhxeUp1NW9ZMGlWY3hKdlJmaUJN?=
 =?utf-8?B?ajJJQmplQ0toVkoxSEtRcjdNc2FmUDVKVzBqWTUyYVV0N3c1YnV4WFkzSXc3?=
 =?utf-8?B?b1BqVGZGcUJhL3oweWZKNUZmNnU4K1h0MmRwTCsrK1NUN1FTSUM5SmlHNmt0?=
 =?utf-8?B?eG9PdjhOcUZ2Y2V0Ri9VK1F1Tk1OZDAyQXRhL21OcExvQ2lkSDQ1ZGRadWJM?=
 =?utf-8?B?V1VHaGJoQzNySjZtOFNVeVdhNzhJTHdjeEc4dGx3SUlKMjIxaENuV2pnNHFM?=
 =?utf-8?Q?NZ+R/HNn4hve6hb4GhJl4n0=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fb56eb-9d4b-4c9e-1c10-08ddc903cbe3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 09:40:30.2729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+cLbT7UhfTPRUrHMDUk0oYORCoKoUk60RKG2dRBWC9NkqKT1ySvJVcaOqg1O3pESIfpOkzwPZ91twPG5KvRU+CQg24EStTdToJi7SFOzMj3e3qqQgKk0i7fpezbC9+i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7166


On 2025/7/22 15:53, Vincent Guittot wrote:
>>   more_balance:
>>                  rq_lock_irqsave(busiest, &rf);
>>                  update_rq_clock(busiest);
>>
>> +               if (!env.loop_max)
>> +                       env.loop_max = min(sysctl_sched_nr_migrate,
>> busiest->cfs.h_nr_runnable);
> it should be h_nr_queued as mentioned by Huang and my patch has been
> messed up by my web browser

okay, I can create a patch later, and send it out after it passes the 
Specjbb test.


Thanks

Huang Shijie


