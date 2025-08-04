Return-Path: <linux-kernel+bounces-754946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F062B19EF9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07A0189CB0F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA7423D2B4;
	Mon,  4 Aug 2025 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="vaFmJwYz"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010049.outbound.protection.outlook.com [52.101.69.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6CA1E1E00;
	Mon,  4 Aug 2025 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300862; cv=fail; b=n81WXcEyGUMYC6yqnFU3A4kPvfpFxR0FzHXnMVeU4Q6pPM53xVQqNrEGGM6Vk8g11VT52E2Z7JNvGv4VrLP0sbYsxrRMqwBt+Ap3bIGIG2agV5swhv7QKZew3ubJaPifBkUcFDg/HvBqRSlsnqvmQ+1zUMRgjfAykAAl0jO7GD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300862; c=relaxed/simple;
	bh=KJiamReGoVAVGsj5tJEuXYNEKfspYHQBVwdG9l918oM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Btnjou3Cvkym1cEschuIaLeLFFXpgBH5vAK1K5CNPSUnRlHqe9UysPpOyK7TqaRPSR2jGeL0ncfaX0HP94EWmMnZADThK7Kx01cuFKXbz4XxhnbcJGTwXVWpR9QyVCvKWLGVFUGVf0uUAjBeqnM6dqNCbHwCo3fHG6gLFjzsIp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=vaFmJwYz; arc=fail smtp.client-ip=52.101.69.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OyBi6iNOF6x2Bmkvhq/SZ0DsvBrTBBf43VlYkRNVwFdZ7lGXLfTMeRh8EI6otR7tN/s2Kjebs3YWt0orYY179lcfcEXr/pn/u94GB++F7wdQc/aKFhG6k+x5epXMDnvKZ8l0YMO9/FulBG99MfHLa0OJsIT78KoM+kk6pljFVLCjpUuPTctfaO+Z3Fy8j33z9yofdhs5gW6/IFlBXZywp2tXHEoVhTpH0x2+VZknl34kIQTz1e2YZHJFB9/AeQMBL91k6EFf/HyN2tJxi5k640qcMCEMCYhATxZbMtsNoijjoe4x6g0AjsjJsW7J0ijqtFjaUwO7o8NqJcSXk3Mxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJiamReGoVAVGsj5tJEuXYNEKfspYHQBVwdG9l918oM=;
 b=Gr85Eo8yqss0QkVDe319erI25AuanRD8b3BQ3U0XRgefM70wDGHZDqb8P/U5Xv/wuNyBVwLNK98X5aYI8ljPeRzeeDNCIeInPd/wR1GxLv6KUcr2vWyEv2MugwvOTebTDv4VvVkc9Z0CwqTW6kx0fMOU1p6XSiDfecPSC0WwN0umjus9IEZwabTyPShoHxywP9rH9zc49Acl3x7iNMqEddoEWLmorLqFzOrLhH888QvrpIjkXTe2bvQhAqbfwxSJvjxdf+4mqVzgsRZKZRBHxlnPz5nUhaCHvmr1vwSw7i35Fe5VF9d1tlyFzBq7piQPyBK9XMDZ4NUpsxxGnRietg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJiamReGoVAVGsj5tJEuXYNEKfspYHQBVwdG9l918oM=;
 b=vaFmJwYzujRKzCyp9z3gfSpTkH/bx+v4iDiANpQGikynxAeUOClPMSeuhQxEDyO0UwvVlbYVPyU/G64f9Wo+mSlqaTZG6eCLa24Q+yA9qO9s+Ffswa9JK79y1XiKs040IS4FZqJv5G+V13xTB0qMxL/d2/JG/NhDpUhIDGbaI+nOqkrd5NRGNtSVxQ/4gmRDwERXUE3Diype1Z26I1+9rDiB3sros8lK8i50iZRWi6sAZPTKk5YAzrY1aROX2Oohu+nPCnAuJqEu3hptFE8DQNt4IW30ZxjJx2Y0cdxk3mhEH9Lrm17HoqgQlwFfW7ah3CeXF9WpCNouUb4KJ9YGuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAXPR07MB8771.eurprd07.prod.outlook.com (2603:10a6:102:246::20)
 by VI1PR0701MB6750.eurprd07.prod.outlook.com (2603:10a6:800:17e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Mon, 4 Aug
 2025 09:47:36 +0000
Received: from PAXPR07MB8771.eurprd07.prod.outlook.com
 ([fe80::e125:c4ef:b872:5c60]) by PAXPR07MB8771.eurprd07.prod.outlook.com
 ([fe80::e125:c4ef:b872:5c60%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 09:47:36 +0000
Message-ID: <0d0393d0-d913-4595-86b2-59cbaf0dd076@nokia.com>
Date: Mon, 4 Aug 2025 11:47:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] genirq: add support for warning on long-running IRQ
 handlers
To: Jiri Slaby <jirislaby@kernel.org>, tglx@linutronix.de, corbet@lwn.net
Cc: akpm@linux-foundation.org, paulmck@kernel.org, rostedt@goodmis.org,
 Neeraj.Upadhyay@amd.com, david@redhat.com, bp@alien8.de, arnd@arndb.de,
 fvdl@google.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 peterz@infradead.org
References: <20250724155059.2992-1-wladislav.wiebe@nokia.com>
 <8de10920-f777-4419-9933-1d005828a9f7@kernel.org>
From: Wladislav Wiebe <wladislav.wiebe@nokia.com>
In-Reply-To: <8de10920-f777-4419-9933-1d005828a9f7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::10) To PAXPR07MB8771.eurprd07.prod.outlook.com
 (2603:10a6:102:246::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR07MB8771:EE_|VI1PR0701MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 25358a63-9de1-4e9a-07bb-08ddd33bf16d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVNwWG8vMmFzNkExV1liNHlsc2laNVRMQkxNMFJXRDE1UEUyb2d1ZVhPMHlR?=
 =?utf-8?B?eGoyNzFYRGV1UVBaY3hDTk1pRWxQbTc0RnJsSU9qM1h5bDlSK1F5SGNXQ2dM?=
 =?utf-8?B?Qk5HNHZFbkFKT1Vrald0azdCbmlDU2NzMHQ1enloVStaY1FNUFdPK28vYlhY?=
 =?utf-8?B?NHFkMlFzSmZBRnQyUXBvMEVsSW8xbnlYMWZaYWR0NXhCclREaFQ0dlgvd2dk?=
 =?utf-8?B?Qi96eFhyZFFReDlnOHFrMTNNSlF2RzZBWG5HYmVZRHBqemQ0M04wUmxZRnp4?=
 =?utf-8?B?NXd2SFRRMUpQUWU2YjNLUEVFaXAwMzd3aVVyQmg0cG9mSHl2YTRYWUtDTG1z?=
 =?utf-8?B?OTNScnNMYmx6YXBpaWpMNUFLbjZVOTZ6L1h5aUpiaTIrbkJkRVdKT1RRZmdz?=
 =?utf-8?B?RHFibHM2Y3Z4WmQ1aEwwWXp0aEsrd1dsZmlOcGVJcXRwdmhVbGVhQm5JNlBS?=
 =?utf-8?B?OTZjMUdjMWNVejAvalFZck1uUTFzWHBsOGpYQXA5U0drVUFOc2V3RTQ3Z2xZ?=
 =?utf-8?B?RlZOZWN1M3NqRTBsaU5FNnpjZitsL3lFWnZMWVZMYW5hL09jQlpzNUxWRjg1?=
 =?utf-8?B?RU1Kc2g2Rmw1bENvaVJvZEJLOWI2NVY3Vm9HeWUxUmdONHBwcE8wbXdUMXR6?=
 =?utf-8?B?ekV3dGlUaUFUdzFTdGRYR1FWdUZHbCtYOTNvZ3FTM2ttaFNiR25icnA4K3lo?=
 =?utf-8?B?WXpsNjdSY3Z3Tk92bzRPUmhZM1hHSlRhTXlkZEN6RjR6V0t4V2Z1R0x4SFA3?=
 =?utf-8?B?S1FBRlpOd01lZkQ3dHBhdGpuTmFZWnVwWFIxWk1yWjBiQTZCYWpaMmpERnRZ?=
 =?utf-8?B?QjZySkZYZ1p1VWNpSHFzN2dXRHRGZTRjRWQ1NmVVMnQ2R2pHV254aUIzVXlJ?=
 =?utf-8?B?eXBxOWlkZ3k5ZFpTd2tDVlRHeWpDM0lkZDIrU2cxTTBiYlVlRGpoK0d2YXFq?=
 =?utf-8?B?S3BwWFJkaW1YRFBhdmNISkJzaVVQejdEbTNXNUQxZnhRMTFUTmRRSElDek5K?=
 =?utf-8?B?QjgvTlp5WDQvNjVYQlVGTVpXTTJWWUI2WmZ6YzVVNU13UTBaaHZUYlNOaXR2?=
 =?utf-8?B?azJtV045bVhLVkIyOTgxR29IYXhmbmRtcjZZa01zaEdsbzczSW5RcHE4bTJB?=
 =?utf-8?B?U2pSUlUybHFrdXhnOUdwUW52WUlWUmI1UjdKS0lYSVBjeGY0SFgvSk80cDVt?=
 =?utf-8?B?MmFZNmJORTVYNmJUKzlCMHFLVjc2cTA5SVdtNldIWGczaTA1ZFpNMVJWVU5q?=
 =?utf-8?B?MjBxaXVPL2hvOHR2Z0tQQ1ROM3UrcStyZXFEeEZXcTcwSDM3SU8xVUdaU3Rh?=
 =?utf-8?B?eTV2SWhRYjZzYlVyK3ZyRmJkQW1CK2pKbVorSFJnR2xTT1VBNzBzc240UzZU?=
 =?utf-8?B?UmRrUkFLSnM4M1d2RmVoRFJTRVlKNmJDUWtYSnZjZEJMT2d2WGkvTkIycGE0?=
 =?utf-8?B?dmM3K0M4ODBsckMyLzNyQjZUa083dFQ4NEFTUFBHYjlabmNJc1hEZTJzczJF?=
 =?utf-8?B?ZEJ0UCtRdVgrekZpZkRaMU50SmpQdHNaUXhja3h3aHV0b3VhRUZaVXBUYXgy?=
 =?utf-8?B?S1dHQkFvcTUyMHpJcVg1eURralI2WWJaWWh5U1JXUFlIVENCMUt2QzYxQWln?=
 =?utf-8?B?MmhTdUgwbEhGVzk1RGgvT2JBMXZFMHhMbXl3bkRXN3lUZTVCYmJ2U2RFd3dP?=
 =?utf-8?B?TC8rbC9LUjBxWmF3L05Xc3pMYTFoR3orWEIyTk0wTTBtYUlqZml2N0I5OGtL?=
 =?utf-8?B?TVFSd1BaT2hKNVcwc2JvdzBjNzJncnkxMWxBekpDbzhrWWxCS2hzeWtQZkpN?=
 =?utf-8?B?blNxVC9KYVRVTlUxaVgzVDBvUGkxeXZ4WEVOSlAyZ0lwWHRxZ2dHQWNadENR?=
 =?utf-8?B?d2wrZjI0eXA1U3dKZHV4UGl1bi9DdmRscTRGc0xOVGllVC9ET3lFaGxtZ2t4?=
 =?utf-8?Q?iC5V5nnm9LA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB8771.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlN5OXdIenRoMzJLZzFwNFBobmhiSjF0UmlUUjF5Y2JMU0ZTUWN2aUNMOHE5?=
 =?utf-8?B?NFVYcWo0ckJDK0R4MnYxZWRUdDhteVF0ZVdXNnB6cWVNRjZsMTlvMHFHWnRj?=
 =?utf-8?B?dDQrWW5nNGhkclVIbDdudGVoQ1pVVGdwV25UdjFHN2Jrdyt0TFFlYm1rZ2Ux?=
 =?utf-8?B?QWs4Umt2ZDRWZG8vQnc4aUNHWXk4NzE4dXhqTWQ2RS9Xc3lQM29nTUdPZ296?=
 =?utf-8?B?K1FwbmZGL0EycW4rZzAvZmVYSjcxenVhU1o3Y3FsWFlaSFM2dkJZVmlRS2Nk?=
 =?utf-8?B?NjJNcERaZUVubGZxSEFjZmluYXhHZWJCc3hZUWEwa3JOcDZHUlBHbEw3emth?=
 =?utf-8?B?ZitlZVhTZkttRm9HZ0t6d3R5YnBXTGZVNmZwcEEwQVBMN05yWTg4aGNuUFZo?=
 =?utf-8?B?aDJuM1pJL0E4TWRZU2hrU2VVMUNJYkRJNWRWWU5WZjdWTmVzdExMclpDbjBy?=
 =?utf-8?B?VW9TandBQUVrTmtMYU1yYm5vL1lxRzRQRnYvQzU0WVkyMGJlZkdtSmhkOHJO?=
 =?utf-8?B?T1NnZ0w3Z2F3U0dmRmlhRWwrajQrOUVDS2czZWhCS29NeldaTlR2aFU3cWtl?=
 =?utf-8?B?MENIZ2lzRmxVbG5HRGRYSUUxWmpyWDZRVlBaclpxckhEUUtlL2oxSVZTSVB0?=
 =?utf-8?B?RU9kQUhEY3hJNUIzdDlBMXk3d1hsRldIemRPcEU2d2dqUklKZkh0c25QemlB?=
 =?utf-8?B?VmxneVdNWUUrdytnMUU1Sy9pODlMODVOdlhMQjgycm1FNWJoK3RmNko3SmNG?=
 =?utf-8?B?TStwZDVmbitwK25QWUxiQW9sb1hqSGVYU01nS2w5dFRDM0RpT0Q5Yk5BQjFi?=
 =?utf-8?B?UVdsZ2dhQlB5d3Z6b1lCYzQzT3BvbzJSb2c5WVg0Sm1OM1RGS3NvR2hnVDhX?=
 =?utf-8?B?L0hUM1JDUzR0djhRUXBzVjg1cXNCc3ZyTGxsN04yMXlncCtUTjVlQzRGZUVo?=
 =?utf-8?B?Q05hRGNsaVYzbUI4emtqdnpoZmdmMm52akk3cmVOeXNqK3pOVFBIdEl6UlA3?=
 =?utf-8?B?R29VMDZLK3VaZi9vU2RxeTlaeC9oa0lTSGZURW9XQVNIaUluUDZTa0R0MStC?=
 =?utf-8?B?dlRINEY5UytKUEJSTTVuZzRJM2tKaDNreUVmc3d0UUNBRUtSN2ZvZktRMkVx?=
 =?utf-8?B?T2dKRjFxTW9sVVlkSGUwaXdwN0VsUW1pbUoyRWw0Vjd0VFNySHg2TDZpTWpl?=
 =?utf-8?B?M2h6R0poWkFMeFRxYlcxa2lqQkhURjNKREtrWVBaRmxsTVAvQm9XRjBTYUxK?=
 =?utf-8?B?cUlvbEsrQ1Awd2czOVUyczZFUHVvc1BRZmRPYjBQWFd0Z2RsQmZ5OXdRSksy?=
 =?utf-8?B?NHFZeDV4NHc0aFJWSEVZK3h1VzNWUDlWb2FnSEFkeU5Pb2ZFaDJCVWEvY1pn?=
 =?utf-8?B?RGVCVmMrcitpVXhML25HY3djQnN2U1o0VGg2UXlSVHg0WlgvaUJzSDU5Q3dV?=
 =?utf-8?B?OEd5ZDlkbXJEMUhvbkNZYXhnUzV6bnZ0UUI5QTJIeGhzSDhmU09QNnNuNVhk?=
 =?utf-8?B?Q1d4cjJyQndUU01oOGdMTEkwYnA0NWVDZm11YU8yaXpqUFc5alZvZVYxR3I3?=
 =?utf-8?B?NEtEbDIrbkVMYmhsS0ljbWpUa09UM01vWklFV1dzQ09vM1g3d3hEcVZ1bGJT?=
 =?utf-8?B?dnpoU1BleExnV0xjSUdlS1lvaTVUTmswUGc4bVlkTm1CaTY1Y0RDaUlGWFVS?=
 =?utf-8?B?VnRzK1g1SzBlRERkbExLeTV6OWg2a3J4VFJHL0JTNmxWN2t2dWJpQ2FFd0k0?=
 =?utf-8?B?SWRISHgrSlM5cTQ5ZEFWY2t4Wkh4LzNtSUo4MkJNcE1lRUJzZDlrLzFMbUpK?=
 =?utf-8?B?aDFVMnBUamVKOVpmZ3FKNTUxdEZlWGdXVDFkLzRvZkwzUGxSQ2N2R2Z1Ynd2?=
 =?utf-8?B?T1AxR1RUdmZWWTZVQnpwdzFBc2FQY1l3QUlUL0R4NXVoU3dTODRRc0U1K3Q4?=
 =?utf-8?B?ZmpUNHB0SjR5WG1JU3dGdDIwSXJTSVgvVnR4Q3FjbWUwcGxTNlFGZmMwME5j?=
 =?utf-8?B?UE93SFllYzhSdmVUdXpZSnVoYTMyRW9nUTNYWWl0alNTN2V0eEdMY2g1QVh0?=
 =?utf-8?B?TDFBbHRwRDNnaDVWZTc0d2paM0l0QmxLODFvYjNVV2ZSOHV1ZWU5RXpRN2ly?=
 =?utf-8?B?WXFkZCsxWjl3bTV4bkFlYmkxbkNuV0xkT3AxTURUVFhtZi9Eb0tFWG9sTkFn?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25358a63-9de1-4e9a-07bb-08ddd33bf16d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB8771.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 09:47:36.4562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZ+0WLkJOgy4yZZ1P2u+nMgmvNQT83I7HNXKlx7+6tlLFldhN1z1K9TiIMtLb7dExKrhPV1+5WghrFKUQ4VAqPGkp1jjHIHQTVBNXgyRxpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6750


On 31/07/2025 09:46, Jiri Slaby wrote:
>
>
> On 24. 07. 25, 17:50, Wladislav Wiebe wrote:
>> Introduce a mechanism to detect and warn about prolonged IRQ handlers.
>> With a new command-line parameter (irqhandler.duration_warn_us=),
>> users can configure the duration threshold in microseconds when a warning
>> in such format should be emitted:
>>
>> "[CPU14] long duration of IRQ[159:bad_irq_handler [long_irq]], took: 1330 us"
>>
>> The implementation uses local_clock() to measure the execution duration of the
>> generic IRQ per-CPU event handler.
>
>
> This version LGTM
>
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

Thanks a lot!

>
>> --- a/kernel/irq/handle.c
>> +++ b/kernel/irq/handle.c
> ...
>> +static inline void irqhandler_duration_check(u64 ts_start, unsigned int irq,
>> +                                          const struct irqaction *action)
>> +{
>> +     u64 delta_ns = local_clock() - ts_start;
>> +
>> +     if (unlikely(delta_ns > irqhandler_duration_threshold_ns)) {
>> +             pr_warn_ratelimited("[CPU%u] long duration of IRQ[%u:%ps], took: %llu us\n",
>> +                                 smp_processor_id(), irq, action->handler,
>> +                                 delta_ns >> 10);
>
> Only that: would the division matter in here? Or print ns? But feel free
> to ignore this.

In principle one could think when the paramater interface is provided in microseconds,
the duration print might be in the same resolution - hmm.

However, for the division part I have no objection going with
precise devision as we are kind of no longer in the "fast-path", hence v5 prepared:
https://lore.kernel.org/lkml/20250804093525.851-1-wladislav.wiebe@nokia.com/

Thank you
- W.W.


