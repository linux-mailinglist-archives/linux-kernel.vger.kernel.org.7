Return-Path: <linux-kernel+bounces-878432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE3BC20941
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13003AC0E4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C572125B1D2;
	Thu, 30 Oct 2025 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="fO/IaOxq"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021106.outbound.protection.outlook.com [40.107.192.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7455B25A2DE
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834342; cv=fail; b=YsUIVPM1JVHP2oXE07hH/jgNA/8kmdzkL/NxRewf0UqrhvDXZWevvVk6l9bI1DOtNzcnfCZY+XunLeMIyzKxML4a/N1UQLubmDpLXSHCTqBapjc7jsNPpwvcahns/+zDtQAD1ElLUGJIyYySkRDrKkZRSknayVy16roAY68JMlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834342; c=relaxed/simple;
	bh=tP71DCQ4TTk7Bji28jdzhwQlFb/Dh5gsq2LcYJW8M94=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o2IY0P8WqNcrdMlJQ3pjWmiLY06ixz+Or8SNNCKvTo6ywjS0Xjy8hkRPt5HlXYJsixL7Ve037aCpRdF7KlJlYACKsS6n9AB7ZacniX0h2mookpjUUCBfnIW9CVOqxlpSrIEUHhoYvR0RNfaNjwCmVEEkrhjtpgaTqGzPWi7u5w4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=fO/IaOxq; arc=fail smtp.client-ip=40.107.192.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0+Swkv0uXXSxgFfF/krrV2APj8MgP+9DufcGNhRunxImJb0qSwUkYpKAFCx9IKNphb/dqnMApQb9q4JzR/o4KJevAW1H0tdU6krqyvSlv8B9NHbgLPxn73yKbxQmhPBoC4dPuflffHHiXNlE6vOglc6k0sGeulQHpsLq9ylGcb2dMnwgzKAnfJlw9wedbqYslUi992omMNlJ2zITzPiBSlmqwsmrJ/jo7H+lA1X57e1Bya71o0o2px9uZ/CdFiYlmet4+f8HnOXynntK8OtyAFfF5uwH1/NOyEskl644pfp2UxxcTtcrVEQhjkHXy6pavZkloCK8daTaB0W/0W/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPCsFl/+/a1m+8dmaXz/5KO3lnZZZ39yLCrZGDOSffQ=;
 b=HNXBZ2DyWncE/4dsWCmmimT171jnL/W0z1nHhIoOMLI45k4/SBLsTzHx8Oud1gjQqcuJbKkOdwPbVfNa5qo1o4GS3BCahEZdyRUUC6K0b/ZwYDyevEu7ftWcVNQ0YUaBnEU9T4aBiyg57qjWZMeXvj9N56uCtuzFeeB1qGZVSLOX+K1uIer6Ix2zbwrxo6w45ZDacxBWiycLuKDLDb9ZrwC3UIeq5ibcaQ0Fptp9D23hHYWVD1sSzzxeLHE6hjWGdT26b3isFD728nkU6BhW/7LXdLXh7VJelP06coKlF5tooIc10IOKSLZbnJFJmEOH31u4zJJWOouVjIUlo+nB5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPCsFl/+/a1m+8dmaXz/5KO3lnZZZ39yLCrZGDOSffQ=;
 b=fO/IaOxqrXFy3uHvM088/sqMyLUPsHtlqJXLmukZX5qgfYJl0nMO0kmCLuJoGlvm3UqtWYGkOB6pItgkq57aM4OHqSiYHWDt5MtqeSfQKd6/6IGpJdpMDgQxduUg/I5H8QbF4m1AP7mKhyyxS0KG3IuhhDLKNs6qza+lKTjgvS5ZYdR3Fach+fBvBq83fR+KCo8wVa2w1JA4kGb1DasUvJGDnHQoDLWeaCHupVYnlJZvaj36UxCrtBjJQFDhytlgvPtRG8RcZlpvESobM8dLNiAgx1iH+/39FunNzU+wvKqi2JdrOcthQJKc5EydtosOCYWTnxX2vXIv4LC9KVbXtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT4PR01MB9845.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 14:25:39 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 14:25:39 +0000
Message-ID: <84e063e0-350e-4608-b809-97114579019d@efficios.com>
Date: Thu, 30 Oct 2025 10:25:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 14/20] sched/mmcid: Serialize
 sched_mm_cid_fork()/exit() with a mutex
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124516.159532643@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029124516.159532643@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0162.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::35) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT4PR01MB9845:EE_
X-MS-Office365-Filtering-Correlation-Id: 8106e43b-e993-4f9d-fdef-08de17c0331f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?em0vYndQQ0MyMkdMUDB6Zzh2U2gyak1GcktrTnVqYkpidGMwaXV5WXZiZnhU?=
 =?utf-8?B?STdUY09Cb0U3RElZU0UwdVA1SFM0WnJGWW5FZHU0Q0NoMEpPeWJXYVp1YzQr?=
 =?utf-8?B?RFlqeVN3RkgwOC9lNXNpeVIvSzcySzdjR2g0RFBtMDNpZnN0ZzRsMkVGVnZw?=
 =?utf-8?B?MmRrUnMvWUM1MWxwM2Z6WDNMOG9tRW5JMWs0QVlGcXJZd2tNL3FVL3l0bWM0?=
 =?utf-8?B?K2lGQXJyQlR6MWtLS2dkcXg4WlNmQnk1T2lPMGdtY0VSQ253SU9oMjkvZWJX?=
 =?utf-8?B?eG8xNGZ5eW9TVnREQjZNdlJWWHFmcFFSeFNjWldUTDlsclhlTW9hQkFWejR6?=
 =?utf-8?B?UmN6bU1qOXdPWGk3U1N4bDE0Z0Z5Z2l5MnFDZVBYY2lsOGhvOERseGpMZExT?=
 =?utf-8?B?NWkya25uWXorazFxRS9vS2tRaEY1dHZlMVJHTStlQk84NEFSVXNQbytOM3Zm?=
 =?utf-8?B?cjdMYnVrMGtGc3lab3dwcEtNWlFkRVpka3RqdHRtVnpiTmh6SkJjSTBkNGFJ?=
 =?utf-8?B?c0ZHVkg0M0ZmTXBJS25QdUc1T1NSSlR3bithSkhsSFRzaCtRNHBDdjBWWlBy?=
 =?utf-8?B?WFVqdHJDMFN6RHJKNXF2QzVBanRqcjcwaktoa3UwSWlXaXg0ajFIemYwNXB6?=
 =?utf-8?B?TGNBSFUra0xmZDdPUHczNXkyZnRJelNFS0dMTXVkV3p3dGt3V1ZYZ0lmdk8y?=
 =?utf-8?B?V1hUTG4rZnNBR1pCQ0RZNi9KRHg2ajhYNUpINkFBQWRORmhML2NFR3dvT095?=
 =?utf-8?B?ZWQvRXRmTkZuQlozc3Q2SzROcGVWMkxaS1pmUTUwLy9wbTBVc0tnVXY5M1VI?=
 =?utf-8?B?TjAyd3U0L0ZDa3BrTGZzU1RjaVptSFU1V3pDbFJNVC9DaGI4M05SMTBmOFVt?=
 =?utf-8?B?UEhHM1dsc2Q3d2xXakZYNDRxa1pyYXova1dsclZVZ09WQ1VWU0lzNmVRYVdo?=
 =?utf-8?B?R0NKaEdQVkhVMlFjVUxIbW56UmxweEF3UUxQQXQ5MnczdjNPQmJkUEFiODJC?=
 =?utf-8?B?WUowQkxJci83SU9ZUHM5VXFqa2VZWVlqZitaTW9kUDRnaWxtTGJSMXlYeGEy?=
 =?utf-8?B?LzJHK2x0MDRPcEQ0V2ZuWHRQREZNL3dBMkxXZFUyTUpMcHBhY0ZkNHI1cGhq?=
 =?utf-8?B?aUpUeWNMTktHWC96YkI0cVpBZENSRThOeHlxMjF3TWlmTm5RdmpGeThNV1hS?=
 =?utf-8?B?YkhzRm1lYnQ5WkJ4UmxmNHh1REszMlRUNUcyeHdZaUZVQlVLS1gwSkxrb0Zz?=
 =?utf-8?B?NUg1Mk1BK1RpL1A2YmxYY1pHODljeDNQNmRjMHJlT2FBTDhVd0NTa09OTFBE?=
 =?utf-8?B?eTJ0SmdmMWtLcWdMNGcrQ0E1RFZGM0czU2Nqcmh5cTh0QXc3MGgydjhLM0pm?=
 =?utf-8?B?VlBLckx4Um9NYWQxSHBoYjRVS1FJcEk5TVVueThrZVlKeFF3WTN2TFFmY2ZC?=
 =?utf-8?B?eE5ueTlzeEV6YmhDMzBVQmwxWVNyODFnSE1rRzdrRElwL0xTNEhFbHJFSXZZ?=
 =?utf-8?B?djdXMTFXbHY2Yk93aFR5ZHBiUzFYK0t4N2huR3RZakcrRFNNelRXazZsOGZ3?=
 =?utf-8?B?eTFpb0FUUVFyRmNOaGZuajY1UkdnNWMxWlR6YWorZGNPUGVtNWJPR292ZWR6?=
 =?utf-8?B?Z1hiVzVQeFRVbDc2ZWFFNnBoeXJGQmFRbVJuN2o2U2RMQzA3L0VLOE1yaGlh?=
 =?utf-8?B?Y2tDc3daT3BXYTd0SjJscUVkaUdac051ckpxaGllRXFUYzdGYlNLMFlUV0xV?=
 =?utf-8?B?RXh4QzNORytYWFordGQrdFlGQXpOa1FIV0ZEeFVDcGNneXhEL3RCOUpZTEtw?=
 =?utf-8?B?cDNBTEdZTTdzL2NUL1ExRlBMYVdZMWFCY2p6OUdtR0JOUE43Tk9OL1JSNkdE?=
 =?utf-8?B?UVZvZnB2cFZZUXNFTzNMRHR0ZU1yeDdUUDdFbmN6c0dVZGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VStDTmpHQjVMYUNtTEl5T1RIVjEvU054aURzcGxyaXM4VjI0SXVublJWSm9k?=
 =?utf-8?B?V0d3cElMNk1sR3JPTDkwSFMrT3ZRZXpoL1hkYk4yaHZyTmRlL29BZllmT0JY?=
 =?utf-8?B?bW8vRVdyUGl5ZkxscndTelp5WVpZeU9jYm8wYVBpOFp2OXE1aEg3REs5cGVH?=
 =?utf-8?B?NU5ZbkVKUzk5MEduc0UzeThVcEhyeDlqZUhiK2ZRcllBUHFPTjVBNU5MMVo3?=
 =?utf-8?B?OFJqd1VGWlNpMDIwRUxIVkFaQS82eDB5SmkzTk8yS0tBSzBSaldRdFY2Wi9Z?=
 =?utf-8?B?TzFGb2p6VFpUN21TMTc0NjdETGxJSDdtMjRwN1JyVFRRbWg0d0FLVURrK24w?=
 =?utf-8?B?aENYNWpkNzd1WnV0QXhiNVd4OVBWTE9jaUhSNkgvbExNK3J2ajVaMWdVS0da?=
 =?utf-8?B?NGg4bExqZ24vZXU3NXZDZ1RKTUorQ3FpNmlQR1NRaitJcU90UXQzUzR4WXJO?=
 =?utf-8?B?TE1JSUFSbnNxR2tsc3A0ckRwZjFlVmlOY0V6bkhWMjNEN01pTnhvV2hTYkJq?=
 =?utf-8?B?TmYralB2N0hsbld2aVBROVZUQUFUK3RDWkJMa3oxRTRvU3M4Zis3NzJ0TFdG?=
 =?utf-8?B?US9KOUZZQUw1OC9WRzBLRFVWRmU1ZWR5eEM5SmxYNkFSdkIrSVl1b3M1aWMv?=
 =?utf-8?B?RVNwS2w4UVRXYUVhMVVlUnV0Tlp3MkFiMHVoZDZQYjlWdEdUckNXUHV3ZFZt?=
 =?utf-8?B?aXZZZGt3bWFEUW0vTHgybUJwOGt6dnRRWVFXTk9BT0dja2JPSk5qL1FGY1l6?=
 =?utf-8?B?NFlpVzhJU1h1VjZPWklFalNyWWdMY3FvRzY4am9lQUpEN2QzVVZ6QThxZFBN?=
 =?utf-8?B?VHZkZnltMWJ6TG0vVDJRTnR4cVRTKzNwait6WFo5SlRoaWpkanNYUEtjb3lS?=
 =?utf-8?B?V1F2VHdiT2hEUlArR2JmWWtWUTBJTkhxU1BSUU9lUlo5YkpCQzlyT2lZWWVE?=
 =?utf-8?B?cUtlWEVFb1NUSGNOc1hzRkxjNXZwbFFDNEVxYlJhVWFPK3pMcUVSNlpqaGxY?=
 =?utf-8?B?K25SUUMyVjFqNngxNWpETzJkUDMxUXZrcUpCL09LUkNqVUYzYTZIdW1BSzVi?=
 =?utf-8?B?K2pTeW1MODNuQnVFMDdibERENmUrajEvbkl3cSsrNVBvYXhsTGZuY2p5UExS?=
 =?utf-8?B?UlJrNXR6ZzFBcUtFRFNadGhnOWlHR0owVngwUE9aMTNWMHRsNDUrUitXamY2?=
 =?utf-8?B?S2o4OFk2L1RKY3ZGTjlXZFpMeHd6a0E3K1k0NWFxV1poSlhaN3d3MjVxdnVm?=
 =?utf-8?B?WlR5NjBtZkRPZ2VTT3RwU3NPWStWWXNWYUE1U0xvZDg2cVd3VEcrZGlzcWJ6?=
 =?utf-8?B?SWZlb1AxeisrMFcvcjBPOVZOSG9zbm1FK1RYYjFSUTlPV1M5cDJuWGZnZ0ty?=
 =?utf-8?B?RXdiZzN0UkkyWEhObC9HSm9VTXhOMmc5cUJLeHcvSHhRRWRZTElDdU5NY1ln?=
 =?utf-8?B?YW9GczRHVzJqNEhwdWV2aEF4MnpGRDJtQyttd3ZONVo0azVsT3hGZlFXbGZR?=
 =?utf-8?B?SXJsS29aa3E3TUphL3VmM25XMWwwMUFOY0kxcWlzN1F4K2o0K2lpdXR2eXh5?=
 =?utf-8?B?bkl6aWkvNS9rV2RvL0l4ME1NRTRIc2RQWWY0WTVKYjlYamVhMm9zUDZPV2xk?=
 =?utf-8?B?WVpYZ09XVlVCQkl0UU1qNzc2VitVMlc1Wmd5VHpINVd2NWhCVnAzVFMzOFFX?=
 =?utf-8?B?NUxITFFaSVFOTEpDbHhPWjF6WjFlKzZZSE8xbThTdEVFayt0MlhVNTR2ZUI5?=
 =?utf-8?B?L2Y5NUlCWlRNSlRiZDI3RVNTeGljWDNia3JoenQ1QjByYmduV1ZCVVQxcTcr?=
 =?utf-8?B?NEN3Qm0wek0vWmhjZjVjWEIyOVhySXI5OEE5MkI5Z0hKdEVoSkVEa09pMFM0?=
 =?utf-8?B?dTVVVzYwYSt4azVOY0tibWJ5VUR1YmUrQWJwdmhDd0tlai9tdmFKU24yZmJZ?=
 =?utf-8?B?bEhlOGkrK2lTTFJiS250REoxNVB1OUVuVFdsQStRUFZOTTVCWVdsd2JnME9C?=
 =?utf-8?B?OU9LK0ZRL0kvSWpsdG9YSXVhU0RRdEFLdEVEaktsUWpZRTVNMUtoTUE0cWJB?=
 =?utf-8?B?OXVQQk9KL2prSHVFc2NPSURDbHUzUVlaOVpneGJHeVNWR2NNZEZPQjVURUxp?=
 =?utf-8?B?YWZWTkJRa3VKeDFiWlk5cFJ0YnJUR0t0YkMzT2JUYmxCRExJOWRMTzdKM1JD?=
 =?utf-8?Q?UaV55BcwQIYhBs8BALd0sRU=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8106e43b-e993-4f9d-fdef-08de17c0331f
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:25:39.4180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CW7oes2SCNik9DEaQXt/q3oXqBzfcYg6wqOm0/qL11JWMzhNslS6fxSXb4bOnp7lEjmKQgeN6BtB9az1OoCKHl7KEOorzkVfzVl3phWAGW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB9845

On 2025-10-29 09:09, Thomas Gleixner wrote:
> Prepare for the new CID management scheme which puts the CID ownership
> transition into the fork() and exit() slow path by serializing
> sched_mm_cid_fork()/exit() with it, so task list and cpu mask walks can be
> done in interruptible and preemptible code.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

