Return-Path: <linux-kernel+bounces-856796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 673ABBE51BA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 194AD427797
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A5E221D96;
	Thu, 16 Oct 2025 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="HItHdpna"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020121.outbound.protection.outlook.com [40.93.198.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFFFDDD2
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760640669; cv=fail; b=p3c/8orkgcfILjIqN4Nk4fLMf+E+Cx07My8yO3rHejrTOnFpqHHRY4dqTmy2osUjk3b+LteoF8C4RzxiUeLeHSMQdtIWl/7KE2NRTuEl+JOP6c+rqTqMzHBmxwsqobeLEUmByHoHzJlqhMwSuE1/+5tdpr/aR7FEqfso57hK8DM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760640669; c=relaxed/simple;
	bh=dC4HhQH1MLJQekvSZQl8gk554aRz5SV4qLGEeaJAnHg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G/GYm/vAXxuADo5BR4EF2wRPaq+Pp7QpMDR2gWpzbLMZUwsjPw0kbC4vW412+iT0pD7Ml3JeC3XQIZwdteoOGP5SRI9guCLbcz22NjoDYHM9z0McQxA3Qhxf574LvVWBCXa7r9LXyJzjg1I66yd3VNvz54TqmyMNaRC4aobtQw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=HItHdpna; arc=fail smtp.client-ip=40.93.198.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYrQal2XPXtCNQ1A8Kl+eK+6k8QnC6FTaCZl6Qn2AqhJWS4ykSh2uUTigpJr1jxP3etVTQExVtU+VKRxzuTKrBmNjwdTX+F/5L64Ukrq0UAhQP4MlNqgoeGgpv/JOsNIQ9KTsxtR7LFYFP3wCTQizjQISOxo8fX5PGw5fkUJoaVeMona+xWpOE6xoLKkrBChjjacLU+MpqseS8hmfOmCpxwbaccJjsQs3JxHOTFz8d1OAdUPOe++nHtc8c3b7zN9xjVzjl2tmrZpxUlbiLCqXkiEeHrjr0/jIs0xVsRrzXumBauEqNSzpRUPwWqSY0s3WZrC8AikSYCLl5d1DlTYNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDjVQ9/9sXJHSg8tX3WCI/sr/s1WYBupSUut1x2QOlY=;
 b=dhNYStzkPk6hlCD6fQkHnxobWCUE/Y9FPnzJ70wo+c35qwyCRu2DVSJ6TWPxpK2pTveaz93MsJyAlGhw8h/fzNALjpKng3pOZpP+IESMTbb/BIleew2RvAz/fgNoubK9KUOG1NXav/+iCRZF6S66MHSSvkYtsHZ8AdbJUTBhtJE94D/b62NY3Qb4C7MFZ/2DAmsNH46wkLogyTXn7+oGkfcjBThlYtUY+qja99cGPUi2zGbbtONhF0foGTqRt/fuoe89Z2AkuwpFbk5j04jLdM1rqyeJ3jHZAI1Buvxmorsj6RbqzZchlGeQ/rVwHQTv4JLBxukL/6RVQzNx5YAxjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDjVQ9/9sXJHSg8tX3WCI/sr/s1WYBupSUut1x2QOlY=;
 b=HItHdpnaZnmooixGHstzIDADZHPWVHhkAs6y1dGP84/vUNuvlviH5FYFJgivnyPng/83n989x3BmksTs4cKH0i0QYv4uSdmZ9YPsNMiY5J7wJU0hBFiOvZ/QvNiHaBvH75v/1/ARkFYwjHTx/LRJ0/C7LHGJ3FLALg21bVSdnrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CYYPR01MB8566.prod.exchangelabs.com (2603:10b6:930:ba::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.13; Thu, 16 Oct 2025 18:51:03 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 18:51:03 +0000
Message-ID: <05331884-9723-48ff-a3ce-c2ea023bbabd@os.amperecomputing.com>
Date: Thu, 16 Oct 2025 11:50:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: mm: relax VM_ALLOW_HUGE_VMAP if BBML2_NOABORT
 is supported
To: Dev Jain <dev.jain@arm.com>, ryan.roberts@arm.com, cl@gentwo.org,
 catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251013232803.3065100-1-yang@os.amperecomputing.com>
 <20251013232803.3065100-3-yang@os.amperecomputing.com>
 <eaa67b0d-e256-4db6-82e7-c4d56df70c09@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <eaa67b0d-e256-4db6-82e7-c4d56df70c09@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR15CA0079.namprd15.prod.outlook.com
 (2603:10b6:930:18::15) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CYYPR01MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: dd12044e-a174-4a43-16f5-08de0ce4f495
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azBWTC9yc1ZwTkoxQWUxb3hPblBwQkZIdWdVd1EwU0cxZzk0djZPT3IzQUtT?=
 =?utf-8?B?MUhITEsrZ3VwUERKZ0F1Um9DRHZKZGI3OXpWbERNYzRmTVYvaVRXcEdRbjZD?=
 =?utf-8?B?Uzd5WlpGMEluRmZVYU8yRzRjdnVRR2lBNDFwNnNwazZxY3lSN29FK2JPaklK?=
 =?utf-8?B?YW1ZM2NESkFMa3dlcWdtRFZjbGQwRzd1Y21SOHEzbVFqcUR2cmt2Z0RRSlkr?=
 =?utf-8?B?Vy9ROGpyRlRicmt5N1l5ejVMMVpmaXN0TlVNSm8veEpTSVZNaGRtME1HQ1Fz?=
 =?utf-8?B?Y0JGYzlXdGFmWjhzUzd3dkVQalJhZmhSK1VYMXpDWUdndHZLcEVuU2UxWnVN?=
 =?utf-8?B?MDdaZzRIUVF2aUhML202OEk2dTNZU0NObFROeWlBR04vT1VrNXQ1TUY3cFBL?=
 =?utf-8?B?anc4RDRleTNabGV5QVc1WVlwTTN5OCtnSFpGNGtCMk9Dc1lwdEkvV2tNMHU5?=
 =?utf-8?B?dC84MW9TZjJNblJRSXhaTE85MXFldUhaOEhOc3lQV0JIZkx1K1Y4YjNuTUZk?=
 =?utf-8?B?U3F6eHc4YXBOWTVBYzMzZzFHNVlPOVlZOTZnN1E4ZGVOdThKOWtTRmlFZm1U?=
 =?utf-8?B?ZXQ2SkxZbzgvcXdQMkVLdDdHd1RvdHRUdEVRcGd5ZXpBZ3lYYkZkcS9HYWl6?=
 =?utf-8?B?eVpaNW1rNUhhODhuZFZueVNYS0tSTTNCOXhCOVRjaElIcmRNOGNoS1MrdGpF?=
 =?utf-8?B?YzV2YndudmlpWUZxTEZLcmZkc2lPWHo2Yi80bStyalcwaGFHKytJL0tJeG9Q?=
 =?utf-8?B?Wm9scndER3g0YVdsUHlSTVdYRDRYTVBFWGtPem9Cc0dZakdyZm9IVm4rSXZq?=
 =?utf-8?B?VkkzYkFEd0xQeTJicDkwYk4wUHM1MUgzSEZFRzAzL2RzZ2lsUS9PUkFVWkww?=
 =?utf-8?B?R0F0SGdoMXE3YkJNZnVmVERyM1dFNnpxTnJnL2RzRXdJZDNROURqMzZGS0pj?=
 =?utf-8?B?TjdFek0zODNwc1RsV0l4bHhrWm1uUTFEemlvWEgvRXN1UVpPdUxsejZQc2Yx?=
 =?utf-8?B?b1N3YmpnZnozYmVVaDlkMmhXbjFpQkFFUGxGVU1EVWlDbjBnRGdxY2lKVXBU?=
 =?utf-8?B?M3NWL3FQVEtEb1F4ako1RWV6TFkwMTlvN1JVOGt2ZUQzSS85ZFJ4ZSthMXJZ?=
 =?utf-8?B?NENXSVJNMVpRNWYrZXRtUnZ3VXRhRTFKZjBRMld1UnVOUE1JNHJxamVWZy9T?=
 =?utf-8?B?OEFGQjNXMEJvUzZyenZzb2JYbjQwNklXMnlHazc0ZXR1a3hqMlgwTTFLSlc3?=
 =?utf-8?B?MXJXYnRONGNESFVTSy9INFRrNXFmZFJSLzhwcjNQQmRzbHkvcExPblZITTRh?=
 =?utf-8?B?T2srUEUwem1QQWdwekdqaTAvMEFIYWg0R0NHVmhpMG05eFdoZGpwcXp4blR0?=
 =?utf-8?B?cVpxQytVRmNVVVdERFpzQnR1OGZMbHdlb2JSb0hCTElKN0dVT3hicjBtN3JH?=
 =?utf-8?B?ajA1L0hqZjRjMDJ4Y0VSYTdiM3lTT1NlbHB4MThUd2t0dmJIZ09CeUxQTGc4?=
 =?utf-8?B?MXhFS29td1NQMitaVTNlZWt6WDhtQ0NGRHhRYzdjZE1BMmxvZVlOeFp3UFd6?=
 =?utf-8?B?cGVKdUwwQW9BNmh6d1VlWUc2QTY1WFNKaWFnL1NBTkZvbG5ONy9sYXk4SE9p?=
 =?utf-8?B?SThReGh4YUljNUxGaWJsYWdkTStQT0d6YW1aNUY2SE1HZTBMQ1lldDlzdFg3?=
 =?utf-8?B?ZWhLSzAraUExMFBVWHdKWUR6ZXBrVDVSM0ttSVhTV1dwT2IwUHFxem1GMXlq?=
 =?utf-8?B?N01PUjMrSmxKeVFiY1dCVGhCVTNLc1NjQTdSeXpqWHAzYzQ2ZGsvSjkwd3pE?=
 =?utf-8?B?eGZSUmRLQklXNnNUL3lncm9tS216R3lKM1ZBODZEQjY3Zkp1NVJINlFXRDd0?=
 =?utf-8?B?alVablpSS1NGQVNRT0l0eHY5MlZ4Q2dzcDZnMkxMcVgyUCtaWTZhN3ExSVFH?=
 =?utf-8?Q?yFTNutWSq/XZPjh/q0XtrzL93XBSvuiR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UktFZ2daSXNvU0FnTlZTNkZpRnVDV2VJZXZuZWFZQTJtVVllR01JWFVVd25Q?=
 =?utf-8?B?Z0c4NlNId1ovSklkYzhpcDV2M3p6R3dqN2VBZzV3OThsUU5GZkJ3MmIraDUy?=
 =?utf-8?B?MFFOT3Exc2tKOFB4Wnc3SUdsdjA5WGQzUFlFQldEM1lmTk5OODZPRHl3Q1JE?=
 =?utf-8?B?bEM3TVphV2RHZndGaU9mcS9oTGJYS01sK1lXZlN1UWFSRDU3RWpTWVJQc1g5?=
 =?utf-8?B?R3pka2loTGlBMXQrNTlOSStLOTQ2endBZkNPaTVEaGM1Yk8ya0c4TEJjOE0x?=
 =?utf-8?B?dWR0V01BY3pOMGN6S2dCMGhvUGVBc1FvVGpodU1JdzF6ejAxWUdGWm4vVkxV?=
 =?utf-8?B?bFRxQ1BDSEVONkN0NFRlcE9xOU5BODZ2b0huUnplaWZRRkZSUGE0S0lCR1ha?=
 =?utf-8?B?dkpsVXdWREdzUjlvR0tDRkZ6WlVhZHdvVmxadldrbDNaOXJLUFpUaGZoN2h6?=
 =?utf-8?B?RFBVaE5PVlRsNms3eW9uZVRlTjdFaW5pWXEyWkJWWFZ3K25zMTg5M3N4Y1pV?=
 =?utf-8?B?eitway9od2s4OVB1dVEyWXpGR0djUkxLUXVOTTRPOHBSV2pSOUNwZ2RZMjdT?=
 =?utf-8?B?Z041Nk9OOXpqS2J6M09tQWJ2WkhFU2ZkWDM5YUJ0R2U4RktDN1NRQkZ1WHJE?=
 =?utf-8?B?dlNpNTFEK2dNQ0k1eWRnMVVQRW5aQkM0VkRQeHBYOTRPb1QrbXpibDJuVlVC?=
 =?utf-8?B?YnJPSDN6eTVxT0ozUnJWSnFUUWRQNmZSaUYxTUljdEppQ2ZZR3NjRzR0Wnhy?=
 =?utf-8?B?Z3QyZFlta1ZyMDlwQUJpUXh6bzZFT01KYVhudVFwV3JWTHZtL3JOdU01Zjh5?=
 =?utf-8?B?MVNFZjRVdDhndEhrM0c0T1NuL1crSmM2ZlNjMEQ3MldGaXJEZm1RV093dUt6?=
 =?utf-8?B?ZkVMc1dJY2xEZE1JellTbVJyQnBXeTVkZHk2dGxReDNRTmVTd3hkTUZBeTFt?=
 =?utf-8?B?aVJGc2QyQ2hKcndBN1pxbHl1RnRXVXlwaUdEbjFwTk1ub1d4eTMydk9xblAv?=
 =?utf-8?B?UXQ2bkVTbGxMdkp3bXFnR3dXWlhTYzFHTUh5R0pBMTI5TU9jc2JldHlzejRN?=
 =?utf-8?B?alIxbFdYeXZVa200UkN5T2xzNUNJa3NPaW1jN0ZZalc0dFlkYzJSbi9nOTkr?=
 =?utf-8?B?eEk2Rk9yVTNTV2lUK2xMVThLd2w4V3U1NnNrSWZMMEM5NnNjUHpQL1FoZ2dr?=
 =?utf-8?B?MjE2TGRZYit5YVlDYUdETHQzZXVJdkJPd3dGUnU1N015MjhoenFuUTZlY293?=
 =?utf-8?B?VmhyRExaeUVyblFyZzZNd0RGSlJMTVpsckxjdGVnY3EycVVEUTkxMi9EV1Nt?=
 =?utf-8?B?RWdaT3h3T2tPM3ZnQVB3cVA4NGl3RDhqMk9BdStjVHU1MDBKenJhUWZaMlpL?=
 =?utf-8?B?aUdwRHFEWXkxS0J3K0VSRUpqS3pWb01odUM1T05vcmdYd2g0cUdFY21uUzcy?=
 =?utf-8?B?L0pKUVprZVoyQXJCT0NiNHdtWFZpcXJwcXN0RFZmbXBxR2lKa1RWR2htVDZC?=
 =?utf-8?B?NmJ1U3AyZlcvWWh6dGMzREZiTDNuSHEwM0ROTWdPZ1VoM2xtby9hWXRsQzdD?=
 =?utf-8?B?QzVaSE5jVlJjUmxvQXg3L2RjSWp0Wk5RT1ZqTzJ5SC96ZXdKQjJVMloyR1JN?=
 =?utf-8?B?V3NkdmZDR0NDNUwrb3NKQ2drT0hjNjFoMnpJZU9MN01DRDczeERWWkkxTldU?=
 =?utf-8?B?N2orS0ZCaytibXEvUXVSMHFadXB1VlRMMGVuNXdRVGZta1ZrbzNkdDh2Yzdv?=
 =?utf-8?B?LzNFSDVtMXVBQTI5M0dpZ0lpZXFhNXNBNkZEekhwR1JOckJrUVZxZStJTU1n?=
 =?utf-8?B?cjh3SDZYY3N2UExKT3dOYkp2VlU4WG5YZkRvT0ZYVitQbzJaQWcyK2dudFk1?=
 =?utf-8?B?Sm5lUE1xWnhBditRR3dLeEtiV1FWV25UMFl0U3dobXYwVERyZkZUaW5PaVFl?=
 =?utf-8?B?UllQbnVwUU5ic0JucVBLdGliMjI4eUluem5FRzY0d0dvVGdDK2NoaG1OUkRM?=
 =?utf-8?B?RCt0Um5IbFoybHBTb3BzV2hHUXlmSm5RWXdWRVFXc3NXZWdGWXlpaEk3QXJM?=
 =?utf-8?B?alVub3NFM1NlWjZJeFZCZ1BHM3RRWDNZSFJDTnBkTm9kT05wS2oyVGUzKzFa?=
 =?utf-8?B?RnQvNm5lTDdQTHhMRFROV3VTMUlUWnZlSDN3VVZFSnVmU3FMblVFRUpRd2h5?=
 =?utf-8?Q?sdHITd7oKerb1xZVRmu5VNA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd12044e-a174-4a43-16f5-08de0ce4f495
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 18:51:02.9853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKowPzPKLDJ9F3jGGz4IAen8He7bJaXfrqR/acwqts/1JqhIr63mDEVgShcGbDr5/ydmO0I1OqBSP2Cb+iTl4p0MWGDy9bW9OJXwjjDWiYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8566



On 10/14/25 11:50 PM, Dev Jain wrote:
>
> On 14/10/25 4:57 am, Yang Shi wrote:
>> When changing permissions for vmalloc area, VM_ALLOW_HUGE_VMAP area is
>> exclueded because kernel can't split the va mapping if it is called on
>> partial range.
>> It is no longer true if the machines support BBML2_NOABORT after commit
>> a166563e7ec3 ("arm64: mm: support large block mapping when 
>> rodata=full").
>> So we can relax this restriction and update the comments accordingly.
>>
>> Fixes: a166563e7ec3 ("arm64: mm: support large block mapping when 
>> rodata=full")
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> ---
>>   arch/arm64/mm/pageattr.c | 13 +++++++------
>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>> index c21a2c319028..b4dcae6273a8 100644
>> --- a/arch/arm64/mm/pageattr.c
>> +++ b/arch/arm64/mm/pageattr.c
>> @@ -157,13 +157,13 @@ static int change_memory_common(unsigned long 
>> addr, int numpages,
>>         /*
>>        * Kernel VA mappings are always live, and splitting live section
>> -     * mappings into page mappings may cause TLB conflicts. This means
>> -     * we have to ensure that changing the permission bits of the range
>> -     * we are operating on does not result in such splitting.
>> +     * mappings into page mappings may cause TLB conflicts on the 
>> machines
>> +     * which don't support BBML2_NOABORT.
>>        *
>>        * Let's restrict ourselves to mappings created by vmalloc (or 
>> vmap).
>> -     * Disallow VM_ALLOW_HUGE_VMAP mappings to guarantee that only page
>> -     * mappings are updated and splitting is never needed.
>> +     * Disallow VM_ALLOW_HUGE_VMAP mappings if the systems don't 
>> support
>> +     * BBML2_NOABORT to guarantee that only page mappings are 
>> updated and
>> +     * splitting is never needed on those machines.
>>        *
>>        * So check whether the [addr, addr + size) interval is entirely
>>        * covered by precisely one VM area that has the VM_ALLOC flag 
>> set.
>> @@ -171,7 +171,8 @@ static int change_memory_common(unsigned long 
>> addr, int numpages,
>>       area = find_vm_area((void *)addr);
>>       if (!area ||
>>           end > (unsigned long)kasan_reset_tag(area->addr) + 
>> area->size ||
>> -        ((area->flags & (VM_ALLOC | VM_ALLOW_HUGE_VMAP)) != VM_ALLOC))
>> +        !(area->flags & VM_ALLOC) || ((area->flags & 
>> VM_ALLOW_HUGE_VMAP) &&
>> +        !system_supports_bbml2_noabort()))
>>           return -EINVAL;
>>         if (!numpages)
>
> This will conflict with my upcoming vmalloc-huge series, so best to 
> leave it to me,
> I already have this included :)

My point is that I hope this can be merged as a hotfix for 6.18. I have 
no strong opinion on either the maintainers take this one or from your 
series. But if this will go into 6.18 as a hotfix, it should be also a 
prerequisite patch (standalone)  in your series, and the rest of your 
series should be based on top of it. Of course this argument will not 
stand if we don't care to have it fixed for 6.18.

Thanks,
Yang



