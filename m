Return-Path: <linux-kernel+bounces-758488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0170B1CFCF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 02:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505C23BA90A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 00:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8424B4501A;
	Thu,  7 Aug 2025 00:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="qrM508kb"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2117.outbound.protection.outlook.com [40.107.237.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B529F1FC3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 00:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754526562; cv=fail; b=eAeBDAs7krONLpn1WTCNV3TVL0mRwq4ePrdkwJ1j2aGjxAIst0vPUdUzcpaTTaUm3q2HjJyJJ94jx46m3NY9QHOKQ5srXBlqzlUw6R6qpn0S9PJeCHU8FABzRTACm+iFs1oMoz+19GxknW4n9ez8CfpDlZG8QhQuaMBR6nq0UJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754526562; c=relaxed/simple;
	bh=66KRAQkUqfgQmaBBE23ShVddrDDWYZYjrqrqxug/7Ro=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n+sDj7P9VgGZj7hUh9llH19qWwV2C+AMyjcITU+5uwLkMw83uNn+FJBvBBuFbNIoNuwKgiPCHjAi616Pl5iX1xrGL65V27cjjm26Uvz3TNMJHe5kQRZc6ptipwbkxueD5CkeYb+BCiMavncxsaqPt1IAr170DW7JV99jh9BAEnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=qrM508kb; arc=fail smtp.client-ip=40.107.237.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QISRCmwsXeWAq8VL+MYYX5sbjhALXJeg7jr7iaZJZbr6updSNvG60WbjRldsZzh76K5HRmB6lTU13YX4W2p7yGOYq3MeipfR+xdQjIt8Gc5XdUx8Uo+eGAHcqlKjSRFwvhCoJhw6d+26tz6KmCM4wuwdalKc9dTpFPRBuN0txzc80ROwvM/qmitT5G5B7MstKj/fbPvyJ7eoAGcDcUCVv487qPKmNoLJXWksRuPOH9QFwQNPZk2VpPkowsDJiRr1HTZt1sYqpoFthkYju41/gXjDhI9rDmajJDI66H4g73yMfxJvNWDGlw7uXf25aEm/6rix0XyI+KLcIcVHiWcWNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfZihU+EHSyexOawfjrlJmQ3o4zHa3J479zkdhz7U7A=;
 b=JzRPWAJ1iHWPvFKc1HAUaqKgF4juqS2GbjA8/q7aY5jpO9TxccQE22Z73WdrkHxY1T3Gr1/pU+YWo8AQSJDVrgrpPZkm86ZBju5RJB0+K3ft4d+8oO9Y9bpIREt2RxiT1d2F9OJe4/Hh0JkFGIfkWm/Gc0+Tve+/Syk0XbYScsKLpNLeJ3jOcPdJMQxyd/uGvMcBV+dd3IV3jjWGlgs81q9isuZG90uXIQIh7O91FzYa0ZF+g44/zlLXYr+1vA2KLVAZsVqog45HkQ9XL/RRFIp98AviJIblfSJeuEa5si1me8Fi2R6ldtUlZunhqXojMw8xF3PT/A3MXBVearmVnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfZihU+EHSyexOawfjrlJmQ3o4zHa3J479zkdhz7U7A=;
 b=qrM508kbIH5vEfxQBYdVv2qJp7/IH4rWHvdYeAUg0lY15U8fFxHthaslLtlww3430OBoMKNgz9oujQSbGvszafYr7o/DlCUCSuHioezM+6/MV/cdQ6JdzJPdAM4bf+6hAhiNZb+I5vdGYtoJO482kWTBU3nNQLq8Zb2I5LIthGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA1PR01MB6591.prod.exchangelabs.com (2603:10b6:806:1ab::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.15; Thu, 7 Aug 2025 00:29:16 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 00:29:16 +0000
Message-ID: <d564ad05-efda-439d-a9c0-9eba21d4ae90@os.amperecomputing.com>
Date: Wed, 6 Aug 2025 17:29:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 4/4] arm64: mm: split linear mapping if BBML2
 unsupported on secondary CPUs
To: Ryan Roberts <ryan.roberts@arm.com>, will@kernel.org,
 catalin.marinas@arm.com, akpm@linux-foundation.org, Miko.Lenczewski@arm.com,
 dev.jain@arm.com, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250805081350.3854670-1-ryan.roberts@arm.com>
 <20250805081350.3854670-5-ryan.roberts@arm.com>
 <6d32bdf5-ccde-4779-a2df-08b6859dbf8e@os.amperecomputing.com>
 <ea41f07b-a758-4944-8b80-37b3f20032c2@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <ea41f07b-a758-4944-8b80-37b3f20032c2@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::11) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA1PR01MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: e40eaf06-eb91-469a-67ab-08ddd54970d0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emJCZ2hvZDd4RE1RZzlsV3NPeUxhWXZwOWpqS0FYSmtHNEVYTU1NdkR0bE1I?=
 =?utf-8?B?ekpQMXp4RWNrWTdPNlF6Vk12ZFhmbDlXK2R2UmIwVDdVVHBDUWpKRTB3Y3VP?=
 =?utf-8?B?N0hlbFdRcVZnd1N1c1JGNUx0bnlLOHI1MklTeTJGWHpNZ2hhcE04RzFabDBy?=
 =?utf-8?B?cDh0TXNFVmpBK1crd0owbHZIR3U3TUdEeURONVVuaThxVUdaY3dzZmNqTDhk?=
 =?utf-8?B?eVdGaFlsb1I1Y2JTbUQ5NTZSeWhsMmtNTVRKMS84alZ5VU5nQ0dIYkhJVktS?=
 =?utf-8?B?ZlZaaElRb3k0WndPM0gxSTlCZjVHbkVqNDZzOWRJVUVYUUlYTjBqYlhZR3kr?=
 =?utf-8?B?WEFVUHB6VTd2QUZQUHJWdnh2M0xzazFwZWk0cjBEa2ZIcGI4b01NYjRUUGl4?=
 =?utf-8?B?MGxINEhjemt2TkJnT0daKzJlQ3l4ajRhQ2V6TWlROE14em1LNG82NGNESC9r?=
 =?utf-8?B?SmQxdmtra2xwRm5FbXl4WWZVaE1rZ0ZuV1BhZHJHYUl1N05mSm56UkdydnlI?=
 =?utf-8?B?WThDeHBoU3lTYlFjMVU1UHBzL3ZmVDNoeG9iOTEvQWVONGg4Y1FCdTJ2MFBh?=
 =?utf-8?B?SVlXRml1SXBZVjM5U2VsMmgrRmJEL2pPc0pEMTFWVHpMWEx4ZFR6OTFkcFBS?=
 =?utf-8?B?enZ5SXJpNDdVMzc1SGVwd2xHbEtvRW4wcmVqTGZzMnRlY0haTjdVWVVUaHlO?=
 =?utf-8?B?MndkR3hBMGN0dDg4ZWdEL2pRMWQ1Q0hoaUFrWDRHTjRBMVVYQTJMS3lHb0hI?=
 =?utf-8?B?c3BFZ2ZsRExDYjJXN3I1UURuK3ZBdUJKRXp0OHRQc3dqdnBMQzN2cnQ2dWNX?=
 =?utf-8?B?bU5Jd0lnRUdNZnBCR1RMWHJGb2FFdHlMN2RNdXAvaGJOdUxGQ0xRUG5ZTjVO?=
 =?utf-8?B?VEFRdWZrcmRFY2tFdnhrV1lsSC9PaGtSb21PM1RXdm5Bb29Pb0NCRm9ZSzBE?=
 =?utf-8?B?aUE1K1JDUXNBOHlSd2VJZS9YaGlPQWM4Uk51b0tnRHRKMDNuSGVwMXJBV3Vo?=
 =?utf-8?B?VVVIV2hKUXNLSzk4YnhmS3lEeHgvREVXWDlEbEN4eENWSXNvY0JyN0hMMzJn?=
 =?utf-8?B?N2s2cFBhL2taUEdLU0lEVEdmZFdkMjB6Vit5ZHF4UjVaOUk2cjFsTmg2SS9o?=
 =?utf-8?B?Zmk3ZVErQitJd210MHJtNzVjRjF1aDhlUFBRWUN1bkR1blM2QTBMTEFRODJL?=
 =?utf-8?B?UzkwaWFFZGZoc3dQOUx1cnJ4YWUxdjNKNDY3S3hkT3ZpWUthakhjWDFjVXpR?=
 =?utf-8?B?U1FzM3dTQkhONDc1cEpoeEkrclVHbmVyOFRzcFNwWWozNDB3ZmZuWlh3aEZC?=
 =?utf-8?B?cjBlK1VlN2RXbEkzdVJGOVNQbVVqNlRmdUhEUWlNMGIvYlU5aGFnZ3czVW90?=
 =?utf-8?B?WnNXU0NMUlNIVU55USs2bWxQS0JwTjBYRGQ1SlNXSVp0ci8vSEF3QTRMcVMz?=
 =?utf-8?B?YjRCTWZIWUpxcHRlVWRhTklmL1dNV1RUVnNXelBzb0ZkQzNZUU52eDR3L0J1?=
 =?utf-8?B?bmtPbUk5S3FlWEhCYUd0ektSWlRsRUpGVFhXL1lHUDB0TGI1WjRBZ0dhTXN3?=
 =?utf-8?B?V0RDdDRhUEd1NmpQdzZqTHFDVUp6azgvKzFnUTZaTkgwSWpDdmQ0OUxxZ3Jr?=
 =?utf-8?B?OG81K01rbTRhdmlZUTgzT2xhNkFTZXlVUzF1V3V2ZVJ0cmYxYmovUlVjdGps?=
 =?utf-8?B?YTNvakROVzRDNU1wd1FFVVF3TFU2M3RrcWdHMk1uWlQ0NGlQOHduQUJMVkNO?=
 =?utf-8?B?S1lUUSsvWmdJKzU4OGJpYVZORjV5M0xqQVRaTGpPM3RDQkEvdnViYUYyS3Iy?=
 =?utf-8?B?QjdMVjEvdmRSZE00cmJLbUVGZ3hLeUdZaHJNTTZ0S3h0dkIxZkRDRTJJQjFa?=
 =?utf-8?B?WWxrbzNwYnpDL1krUGJIbUd5dUd5VG1iTGl3bzNIWFVza09wOUVSMUVKbFZ0?=
 =?utf-8?Q?kSZO+LL9zNw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDZTekI0K3FQMFRualA0dTlpVGpGcFd4SFRSd2Z0YTJhQTFwN0hxZnF0V1Bv?=
 =?utf-8?B?b3BwbVZvTEJkcE1iQnN2N0ZwY3c3WmVQM0tnWnE5eHhUdHY5Y3F4czhPbEx2?=
 =?utf-8?B?UkhWMUI4amJMYTRuVTV5Q29lZE9qc0NQRVQwaG5aaUtJUy9pbzF0MUJFZ1Av?=
 =?utf-8?B?MzBRcnZZM3E1aU1PUHdjcnM4dVFqOVNzTDhlbEdQYllQSUoraE5mamhDZkhN?=
 =?utf-8?B?OFdlRjBqNnpvUFdrMm56S1laTFhHOHlPaHllSmtGaTdGVXppWExVQzdOa09W?=
 =?utf-8?B?bGlPczFRT1JiZ3dLejhZaVd1b29VQ0pzZGJXK0xaY0hpWmpHNXQ4ZHNUSllE?=
 =?utf-8?B?d0p3aVIydDMrTGF6THlHZ1VlY21zVm5CaG9XZC9oQ0I5b09sV1F0SGtWZlBi?=
 =?utf-8?B?WEdzc1dKR0JuU1ozRGFmSlFzbTVuYnNWZno3Z2lFWktjZVFMVGN1UTZBVGZs?=
 =?utf-8?B?VVRlSi9FU0FhZWE3THpKMTdQa2Vrc3VveVQ5K1hPT2xUV0hDazhBMnBoZEM1?=
 =?utf-8?B?OURJWkxyNXN3azhuQ0lrV3hoVHl0K1RscWFrQkp3ajNzcTZaMGdVYlZGNjlu?=
 =?utf-8?B?cHhqTC9idzV3cVVlTzRHaEFCekFpczBOSHgwUGkxSXBiZ1RNU1lCazh0bWJv?=
 =?utf-8?B?bVhucUMvT1FNQkxoc2hxUHJnWnFma1d4ekNsOXQxeVVKY0c0ZWtUdG0wYXlF?=
 =?utf-8?B?dnZ5RXJqM0w4ZzdmNVZUdWdIWjhMak9aVTRNK2tHNHAyejdaMHVPcHJDMWtZ?=
 =?utf-8?B?d0FYNTlkR01DYjFCRlphaVJWRHQyZGMweEYyaGZ6NHBFcnR2M1dTY1hyZ3Bp?=
 =?utf-8?B?YzE2MkVHd1BuQXA5VGhuR29ZVWRBWjZ6UXJSM2ZicFUyZ0QyM0NMSzJxa3Iy?=
 =?utf-8?B?cDY2b2dhNnhhT0xFeklpaEpjWW5rV0h4Q2E4bEN3d0NIWWJCOXJUTXhIYWVP?=
 =?utf-8?B?bXMyS2dBWXVweW5ZUFM1VlM2NUd3VlQ3TFFvNGU4cTFaQlF4QlcyTHFoUWJX?=
 =?utf-8?B?ei92OVNSeUZNUGZobmhIR1VDSVgrT3pZNGpPSTJYcFlRbzJTMjJkeVowNHdx?=
 =?utf-8?B?SENOU042UWx6SWhBbWMzejdZY3REMTRrYkNKNWVwa0FvcFFlbU1BQ2NxSXEr?=
 =?utf-8?B?aXRqVDQrUTNIamRPc3JNMnFienN4cWZxQVlhUTV6aytWOXN2ZytWeFlaR2wz?=
 =?utf-8?B?MzRtMWQvZEIzZ3hCM2JzN00wNm5vbzBPQ2JRdlBrTGdxbFV3M09JVnlGakRD?=
 =?utf-8?B?OWlGKytvRWh0MzQ1SlBMQWl3TERQMGhNeXpUd1ZtY2tEK0NZMXhzTGJWdjFQ?=
 =?utf-8?B?YVVOV0p1Z1FZQWlDdzRiK3l0TFBwUDhHTThScHp6dmdBajlmaFJQUzlxU0ln?=
 =?utf-8?B?QUtrVWM2YllVZHVSRUlJWFRIb3RrcFB4ZXk3M3lUZEE2eU5uSzgwWXNibmNm?=
 =?utf-8?B?NGUrRjZmUVphR3ZLTWhIL3NuS2ZpOTFMUHd2dDcva1hlL3JUUEN0ZnEyOWVW?=
 =?utf-8?B?SWtDMVVnYTFjS0FZK1pxWTl5cWEvVW1DLy9XK1Q3dlpOa2tlOWN5eFJ2SWV6?=
 =?utf-8?B?d3dndzNkLy9HNXRyZGlYT2swa3RtalcyMVZUTWdKc1dDM1dYdzE4TmRoT2hH?=
 =?utf-8?B?em1rNDJEcGhyMERYZmhnS2poSzh3QTVMU2k2WW4xWkM3MFZsblVkdDdsV1Fs?=
 =?utf-8?B?eEZWa3l5YTZ5U3gxY3VrSE92WVZybzJsb3h0Zk1sYng1UlVvcnJyT0psblhN?=
 =?utf-8?B?VEFHMTlvRjdRQStCWTVVYkR2MVpjK3BLQk1QSmkzM3V6RlV6R0cwRUo5bi9U?=
 =?utf-8?B?NWRSSWdIYWhqa1E3bUVHUTRSVk5IbDE1cU01Mm03OUljd2JIK1lhTkNscWJh?=
 =?utf-8?B?S1pQYVArNVBuSEhZSG40Tnk0M3djcU9vd1U5anZia1NPSEZqdG9vd3MwN0Jw?=
 =?utf-8?B?MnVaRnFjeTJmcU44dzRpQ1daazVwd0JlS2hqM1JBNEJaM3dYb1ZSTFBSWFd6?=
 =?utf-8?B?b2dhbHM3WThycmtRS2tWWjh6cU0zR2tiekFjeVYvRWEyS094YnhiVXpTbHNZ?=
 =?utf-8?B?YWc3aFlXSG0rVjhKU2hxM2xhT0o0VjZXcmVyNnphWFhhMHJ0VVJVR05ZUmU4?=
 =?utf-8?B?QWlaZFI0Z05NajJsRFd5UTltb29GdDY1T2pYUkdRNGdpaEExY25LNzVublRj?=
 =?utf-8?Q?/038xnSSfMoaKI1WfPGnoJ0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40eaf06-eb91-469a-67ab-08ddd54970d0
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 00:29:16.0554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAVERKnLSOIh8RrSg0OAbanAV7mtyEpEE8NZ6gnT2VMNsdASCTZ8Ddey553guX4KXOIWJMFme/TlLjsi1T0u3zcH2K1SMBUt46URFTQ9ba0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6591



On 8/6/25 1:15 AM, Ryan Roberts wrote:
> On 05/08/2025 19:14, Yang Shi wrote:
>>
>> On 8/5/25 1:13 AM, Ryan Roberts wrote:
>>> From: Yang Shi <yang@os.amperecomputing.com>
>>>
>>> The kernel linear mapping is painted in very early stage of system boot.
>>> The cpufeature has not been finalized yet at this point. So the linear
>>> mapping is determined by the capability of boot CPU only.  If the boot
>>> CPU supports BBML2, large block mappings will be used for linear
>>> mapping.
>>>
>>> But the secondary CPUs may not support BBML2, so repaint the linear
>>> mapping if large block mapping is used and the secondary CPUs don't
>>> support BBML2 once cpufeature is finalized on all CPUs.
>>>
>>> If the boot CPU doesn't support BBML2 or the secondary CPUs have the
>>> same BBML2 capability with the boot CPU, repainting the linear mapping
>>> is not needed.
>>>
>>> Repainting is implemented by the boot CPU, which we know supports BBML2,
>>> so it is safe for the live mapping size to change for this CPU. The
>>> linear map region is walked using the pagewalk API and any discovered
>>> large leaf mappings are split to pte mappings using the existing helper
>>> functions. Since the repainting is performed inside of a stop_machine(),
>>> we must use GFP_ATOMIC to allocate the extra intermediate pgtables. But
>>> since we are still early in boot, it is expected that there is plenty of
>>> memory available so we will never need to sleep for reclaim, and so
>>> GFP_ATOMIC is acceptable here.
>>>
>>> The secondary CPUs are all put into a waiting area with the idmap in
>>> TTBR0 and reserved map in TTBR1 while this is performed since they
>>> cannot be allowed to observe any size changes on the live mappings.
>>>
>>> Co-developed-by: Ryan Roberts <ryan.roberts@arm.com>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>>> ---
>>>    arch/arm64/include/asm/mmu.h   |   3 +
>>>    arch/arm64/kernel/cpufeature.c |   8 ++
>>>    arch/arm64/mm/mmu.c            | 151 ++++++++++++++++++++++++++++++---
>>>    arch/arm64/mm/proc.S           |  25 +++++-
>>>    4 files changed, 172 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
>>> index 98565b1b93e8..966c08fd8126 100644
>>> --- a/arch/arm64/include/asm/mmu.h
>>> +++ b/arch/arm64/include/asm/mmu.h
>>> @@ -56,6 +56,8 @@ typedef struct {
>>>     */
>>>    #define ASID(mm)    (atomic64_read(&(mm)->context.id) & 0xffff)
>>>    +extern bool linear_map_requires_bbml2;
>>> +
>>>    static inline bool arm64_kernel_unmapped_at_el0(void)
>>>    {
>>>        return alternative_has_cap_unlikely(ARM64_UNMAP_KERNEL_AT_EL0);
>>> @@ -72,6 +74,7 @@ extern void create_pgd_mapping(struct mm_struct *mm,
>>> phys_addr_t phys,
>>>    extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
>>>    extern void mark_linear_text_alias_ro(void);
>>>    extern int split_kernel_leaf_mapping(unsigned long addr);
>>> +extern int linear_map_split_to_ptes(void *__unused);
>>>      /*
>>>     * This check is triggered during the early boot before the cpufeature
>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>> index f28f056087f3..11392c741e48 100644
>>> --- a/arch/arm64/kernel/cpufeature.c
>>> +++ b/arch/arm64/kernel/cpufeature.c
>>> @@ -85,6 +85,7 @@
>>>    #include <asm/insn.h>
>>>    #include <asm/kvm_host.h>
>>>    #include <asm/mmu_context.h>
>>> +#include <asm/mmu.h>
>>>    #include <asm/mte.h>
>>>    #include <asm/hypervisor.h>
>>>    #include <asm/processor.h>
>>> @@ -2013,6 +2014,12 @@ static int __init __kpti_install_ng_mappings(void
>>> *__unused)
>>>        return 0;
>>>    }
>>>    +static void __init linear_map_maybe_split_to_ptes(void)
>>> +{
>>> +    if (linear_map_requires_bbml2 && !system_supports_bbml2_noabort())
>>> +        stop_machine(linear_map_split_to_ptes, NULL, cpu_online_mask);
>>> +}
>>> +
>>>    static void __init kpti_install_ng_mappings(void)
>>>    {
>>>        /* Check whether KPTI is going to be used */
>>> @@ -3930,6 +3937,7 @@ void __init setup_system_features(void)
>>>    {
>>>        setup_system_capabilities();
>>>    +    linear_map_maybe_split_to_ptes();
>>>        kpti_install_ng_mappings();
>>>          sve_setup();
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index f6cd79287024..5b5a84b34024 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -27,6 +27,7 @@
>>>    #include <linux/kfence.h>
>>>    #include <linux/pkeys.h>
>>>    #include <linux/mm_inline.h>
>>> +#include <linux/pagewalk.h>
>>>      #include <asm/barrier.h>
>>>    #include <asm/cputype.h>
>>> @@ -483,11 +484,11 @@ void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t
>>> phys, unsigned long virt,
>>>      #define INVALID_PHYS_ADDR    -1
>>>    -static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
>>> +static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
>>>                           enum pgtable_type pgtable_type)
>>>    {
>>>        /* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
>>> -    struct ptdesc *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO,
>>> 0);
>>> +    struct ptdesc *ptdesc = pagetable_alloc(gfp & ~__GFP_ZERO, 0);
>>>        phys_addr_t pa;
>>>          if (!ptdesc)
>>> @@ -514,9 +515,9 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
>>>    }
>>>      static phys_addr_t
>>> -try_pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
>>> +try_pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type, gfp_t gfp)
>>>    {
>>> -    return __pgd_pgtable_alloc(&init_mm, pgtable_type);
>>> +    return __pgd_pgtable_alloc(&init_mm, gfp, pgtable_type);
>>>    }
>>>      static phys_addr_t __maybe_unused
>>> @@ -524,7 +525,7 @@ pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
>>>    {
>>>        phys_addr_t pa;
>>>    -    pa = __pgd_pgtable_alloc(&init_mm, pgtable_type);
>>> +    pa = __pgd_pgtable_alloc(&init_mm, GFP_PGTABLE_KERNEL, pgtable_type);
>>>        BUG_ON(pa == INVALID_PHYS_ADDR);
>>>        return pa;
>>>    }
>>> @@ -534,7 +535,7 @@ pgd_pgtable_alloc_special_mm(enum pgtable_type pgtable_type)
>>>    {
>>>        phys_addr_t pa;
>>>    -    pa = __pgd_pgtable_alloc(NULL, pgtable_type);
>>> +    pa = __pgd_pgtable_alloc(NULL, GFP_PGTABLE_KERNEL, pgtable_type);
>>>        BUG_ON(pa == INVALID_PHYS_ADDR);
>>>        return pa;
>>>    }
>>> @@ -548,7 +549,7 @@ static void split_contpte(pte_t *ptep)
>>>            __set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
>>>    }
>>>    -static int split_pmd(pmd_t *pmdp, pmd_t pmd)
>>> +static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp)
>>>    {
>>>        pmdval_t tableprot = PMD_TYPE_TABLE | PMD_TABLE_UXN | PMD_TABLE_AF;
>>>        unsigned long pfn = pmd_pfn(pmd);
>>> @@ -557,7 +558,7 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd)
>>>        pte_t *ptep;
>>>        int i;
>>>    -    pte_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PTE);
>>> +    pte_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PTE, gfp);
>>>        if (pte_phys == INVALID_PHYS_ADDR)
>>>            return -ENOMEM;
>>>        ptep = (pte_t *)phys_to_virt(pte_phys);
>>> @@ -590,7 +591,7 @@ static void split_contpmd(pmd_t *pmdp)
>>>            set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
>>>    }
>>>    -static int split_pud(pud_t *pudp, pud_t pud)
>>> +static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp)
>>>    {
>>>        pudval_t tableprot = PUD_TYPE_TABLE | PUD_TABLE_UXN | PUD_TABLE_AF;
>>>        unsigned int step = PMD_SIZE >> PAGE_SHIFT;
>>> @@ -600,7 +601,7 @@ static int split_pud(pud_t *pudp, pud_t pud)
>>>        pmd_t *pmdp;
>>>        int i;
>>>    -    pmd_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PMD);
>>> +    pmd_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PMD, gfp);
>>>        if (pmd_phys == INVALID_PHYS_ADDR)
>>>            return -ENOMEM;
>>>        pmdp = (pmd_t *)phys_to_virt(pmd_phys);
>>> @@ -688,7 +689,7 @@ int split_kernel_leaf_mapping(unsigned long addr)
>>>        if (!pud_present(pud))
>>>            goto out;
>>>        if (pud_leaf(pud)) {
>>> -        ret = split_pud(pudp, pud);
>>> +        ret = split_pud(pudp, pud, GFP_PGTABLE_KERNEL);
>>>            if (ret)
>>>                goto out;
>>>        }
>>> @@ -713,7 +714,7 @@ int split_kernel_leaf_mapping(unsigned long addr)
>>>             */
>>>            if (ALIGN_DOWN(addr, PMD_SIZE) == addr)
>>>                goto out;
>>> -        ret = split_pmd(pmdp, pmd);
>>> +        ret = split_pmd(pmdp, pmd, GFP_PGTABLE_KERNEL);
>>>            if (ret)
>>>                goto out;
>>>        }
>>> @@ -738,6 +739,112 @@ int split_kernel_leaf_mapping(unsigned long addr)
>>>        return ret;
>>>    }
>>>    +static int split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
>>> +                   unsigned long next, struct mm_walk *walk)
>>> +{
>>> +    pud_t pud = pudp_get(pudp);
>>> +    int ret = 0;
>>> +
>>> +    if (pud_leaf(pud))
>>> +        ret = split_pud(pudp, pud, GFP_ATOMIC);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static int split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned long addr,
>>> +                   unsigned long next, struct mm_walk *walk)
>>> +{
>>> +    pmd_t pmd = pmdp_get(pmdp);
>>> +    int ret = 0;
>>> +
>>> +    if (pmd_leaf(pmd)) {
>>> +        if (pmd_cont(pmd))
>>> +            split_contpmd(pmdp);
>>> +        ret = split_pmd(pmdp, pmd, GFP_ATOMIC);
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static int split_to_ptes_pte_entry(pte_t *ptep, unsigned long addr,
>>> +                   unsigned long next, struct mm_walk *walk)
>>> +{
>>> +    pte_t pte = __ptep_get(ptep);
>>> +
>>> +    if (pte_cont(pte))
>>> +        split_contpte(ptep);
>>> +
>>> +    return 0;
>>> +}
>> IIUC pgtable walker API walks the page table PTE by PTE, so it means the split
>> function is called on every PTE even though it has been split. This is not very
>> efficient. But it may be ok since repainting is just called once at boot time.
> Good point. I think this could be improved, while continuing to use the walker API.
>
> Currently I'm splitting leaf puds to cont-pmds, then cont-pmds to pmds, then
> pmds to cont-ptes then cont-ptes to ptes. And we therefore need to visit each
> pte (or technically 1 in 16 ptes) to check if they are cont-mapped. I did it
> this way to reuse the existing split logic without modification.
>
> But we could provide a flag to the split logic to tell it to "bypass split to
> cont-pte" so that we then have puds to cont-pmds, cont-pmds to pmds and pmds to
> ptes. And in that final case we can avoid walking any ptes that we already split

Why do you need to split pud to cont-pmds, then cont-pmds to pmds? Can't 
we just split pud to pmds for this case?

> from pmds because we know they can't be cont-mapped. We can do that with
> ACTION_CONTINUE when returning from the pmd handler. We would still visit every
> pte that was already mapped at pte level because we would still need to check
> for cont-pte. The API doesn't provide a way for us to skip forward by 16 ptes at
> a time.

Yes, page table walk API advances by one PTE. My implementation can skip 
forward by 16 ptes. :-)

Thanks,
Yang

>
> Something like this, perhaps:
>
> ---8<---
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 5b5a84b34024..f0066ecbe6b2 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -549,7 +549,7 @@ static void split_contpte(pte_t *ptep)
>   		__set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
>   }
>
> -static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp)
> +static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont_pte)
>   {
>   	pmdval_t tableprot = PMD_TYPE_TABLE | PMD_TABLE_UXN | PMD_TABLE_AF;
>   	unsigned long pfn = pmd_pfn(pmd);
> @@ -567,7 +567,8 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp)
>   		tableprot |= PMD_TABLE_PXN;
>
>   	prot = __pgprot((pgprot_val(prot) & ~PTE_TYPE_MASK) | PTE_TYPE_PAGE);
> -	prot = __pgprot(pgprot_val(prot) | PTE_CONT);
> +	if (to_cont_pte)
> +		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>
>   	for (i = 0; i < PTRS_PER_PTE; i++, ptep++, pfn++)
>   		__set_pte(ptep, pfn_pte(pfn, prot));
> @@ -714,7 +715,7 @@ int split_kernel_leaf_mapping(unsigned long addr)
>   		 */
>   		if (ALIGN_DOWN(addr, PMD_SIZE) == addr)
>   			goto out;
> -		ret = split_pmd(pmdp, pmd, GFP_PGTABLE_KERNEL);
> +		ret = split_pmd(pmdp, pmd, GFP_PGTABLE_KERNEL, true);
>   		if (ret)
>   			goto out;
>   	}
> @@ -760,7 +761,8 @@ static int split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned
> long addr,
>   	if (pmd_leaf(pmd)) {
>   		if (pmd_cont(pmd))
>   			split_contpmd(pmdp);
> -		ret = split_pmd(pmdp, pmd, GFP_ATOMIC);
> +		ret = split_pmd(pmdp, pmd, GFP_ATOMIC, false);
> +		walk->action = ACTION_CONTINUE;
>   	}
>
>   	return ret;
> ---8<---
>
> Thanks,
> Ryan
>
>
>> Thanks,
>> Yang
>>
>>> +
>>> +static const struct mm_walk_ops split_to_ptes_ops = {
>>> +    .pud_entry    = split_to_ptes_pud_entry,
>>> +    .pmd_entry    = split_to_ptes_pmd_entry,
>>> +    .pte_entry    = split_to_ptes_pte_entry,
>>> +};
>>> +
>>> +extern u32 repaint_done;
>>> +
>>> +int __init linear_map_split_to_ptes(void *__unused)
>>> +{
>>> +    /*
>>> +     * Repainting the linear map must be done by CPU0 (the boot CPU) because
>>> +     * that's the only CPU that we know supports BBML2. The other CPUs will
>>> +     * be held in a waiting area with the idmap active.
>>> +     */
>>> +    if (!smp_processor_id()) {
>>> +        unsigned long lstart = _PAGE_OFFSET(vabits_actual);
>>> +        unsigned long lend = PAGE_END;
>>> +        unsigned long kstart = (unsigned long)lm_alias(_stext);
>>> +        unsigned long kend = (unsigned long)lm_alias(__init_begin);
>>> +        int ret;
>>> +
>>> +        /*
>>> +         * Wait for all secondary CPUs to be put into the waiting area.
>>> +         */
>>> +        smp_cond_load_acquire(&repaint_done, VAL == num_online_cpus());
>>> +
>>> +        /*
>>> +         * Walk all of the linear map [lstart, lend), except the kernel
>>> +         * linear map alias [kstart, kend), and split all mappings to
>>> +         * PTE. The kernel alias remains static throughout runtime so
>>> +         * can continue to be safely mapped with large mappings.
>>> +         */
>>> +        ret = walk_kernel_page_table_range_lockless(lstart, kstart,
>>> +                        &split_to_ptes_ops, NULL);
>>> +        if (!ret)
>>> +            ret = walk_kernel_page_table_range_lockless(kend, lend,
>>> +                        &split_to_ptes_ops, NULL);
>>> +        if (ret)
>>> +            panic("Failed to split linear map\n");
>>> +        flush_tlb_kernel_range(lstart, lend);
>>> +
>>> +        /*
>>> +         * Relies on dsb in flush_tlb_kernel_range() to avoid reordering
>>> +         * before any page table split operations.
>>> +         */
>>> +        WRITE_ONCE(repaint_done, 0);
>>> +    } else {
>>> +        typedef void (repaint_wait_fn)(void);
>>> +        extern repaint_wait_fn bbml2_wait_for_repainting;
>>> +        repaint_wait_fn *wait_fn;
>>> +
>>> +        wait_fn = (void *)__pa_symbol(bbml2_wait_for_repainting);
>>> +
>>> +        /*
>>> +         * At least one secondary CPU doesn't support BBML2 so cannot
>>> +         * tolerate the size of the live mappings changing. So have the
>>> +         * secondary CPUs wait for the boot CPU to make the changes
>>> +         * with the idmap active and init_mm inactive.
>>> +         */
>>> +        cpu_install_idmap();
>>> +        wait_fn();
>>> +        cpu_uninstall_idmap();
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>    /*
>>>     * This function can only be used to modify existing table entries,
>>>     * without allocating new levels of table. Note that this permits the
>>> @@ -857,6 +964,8 @@ static inline void arm64_kfence_map_pool(phys_addr_t
>>> kfence_pool, pgd_t *pgdp) {
>>>      #endif /* CONFIG_KFENCE */
>>>    +bool linear_map_requires_bbml2;
>>> +
>>>    static inline bool force_pte_mapping(void)
>>>    {
>>>        bool bbml2 = system_capabilities_finalized() ?
>>> @@ -892,6 +1001,8 @@ static void __init map_mem(pgd_t *pgdp)
>>>          early_kfence_pool = arm64_kfence_alloc_pool();
>>>    +    linear_map_requires_bbml2 = !force_pte_mapping() && can_set_direct_map();
>>> +
>>>        if (force_pte_mapping())
>>>            flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>>    @@ -1025,7 +1136,8 @@ void __pi_map_range(u64 *pgd, u64 start, u64 end, u64
>>> pa, pgprot_t prot,
>>>                int level, pte_t *tbl, bool may_use_cont, u64 va_offset);
>>>      static u8 idmap_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE)
>>> __ro_after_init,
>>> -      kpti_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE)
>>> __ro_after_init;
>>> +      kpti_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE)
>>> __ro_after_init,
>>> +      bbml2_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE)
>>> __ro_after_init;
>>>      static void __init create_idmap(void)
>>>    {
>>> @@ -1050,6 +1162,19 @@ static void __init create_idmap(void)
>>>                       IDMAP_ROOT_LEVEL, (pte_t *)idmap_pg_dir, false,
>>>                       __phys_to_virt(ptep) - ptep);
>>>        }
>>> +
>>> +    /*
>>> +     * Setup idmap mapping for repaint_done flag.  It will be used if
>>> +     * repainting the linear mapping is needed later.
>>> +     */
>>> +    if (linear_map_requires_bbml2) {
>>> +        u64 pa = __pa_symbol(&repaint_done);
>>> +
>>> +        ptep = __pa_symbol(bbml2_ptes);
>>> +        __pi_map_range(&ptep, pa, pa + sizeof(u32), pa, PAGE_KERNEL,
>>> +                   IDMAP_ROOT_LEVEL, (pte_t *)idmap_pg_dir, false,
>>> +                   __phys_to_virt(ptep) - ptep);
>>> +    }
>>>    }
>>>      void __init paging_init(void)
>>> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
>>> index 8c75965afc9e..dbaac2e824d7 100644
>>> --- a/arch/arm64/mm/proc.S
>>> +++ b/arch/arm64/mm/proc.S
>>> @@ -416,7 +416,29 @@ alternative_else_nop_endif
>>>    __idmap_kpti_secondary:
>>>        /* Uninstall swapper before surgery begins */
>>>        __idmap_cpu_set_reserved_ttbr1 x16, x17
>>> +    b scondary_cpu_wait
>>>    +    .unreq    swapper_ttb
>>> +    .unreq    flag_ptr
>>> +SYM_FUNC_END(idmap_kpti_install_ng_mappings)
>>> +    .popsection
>>> +#endif
>>> +
>>> +    .pushsection    ".data", "aw", %progbits
>>> +SYM_DATA(repaint_done, .long 1)
>>> +    .popsection
>>> +
>>> +    .pushsection ".idmap.text", "a"
>>> +SYM_TYPED_FUNC_START(bbml2_wait_for_repainting)
>>> +    /* Must be same registers as in idmap_kpti_install_ng_mappings */
>>> +    swapper_ttb    .req    x3
>>> +    flag_ptr    .req    x4
>>> +
>>> +    mrs     swapper_ttb, ttbr1_el1
>>> +    adr_l   flag_ptr, repaint_done
>>> +    __idmap_cpu_set_reserved_ttbr1 x16, x17
>>> +
>>> +scondary_cpu_wait:
>>>        /* Increment the flag to let the boot CPU we're ready */
>>>    1:    ldxr    w16, [flag_ptr]
>>>        add    w16, w16, #1
>>> @@ -436,9 +458,8 @@ __idmap_kpti_secondary:
>>>          .unreq    swapper_ttb
>>>        .unreq    flag_ptr
>>> -SYM_FUNC_END(idmap_kpti_install_ng_mappings)
>>> +SYM_FUNC_END(bbml2_wait_for_repainting)
>>>        .popsection
>>> -#endif
>>>      /*
>>>     *    __cpu_setup


