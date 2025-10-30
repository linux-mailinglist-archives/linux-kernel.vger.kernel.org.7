Return-Path: <linux-kernel+bounces-878594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30150C2112F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275B018948D6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955F2365D40;
	Thu, 30 Oct 2025 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="k6o3NZKi"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020120.outbound.protection.outlook.com [52.101.191.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270CD365D33
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839535; cv=fail; b=n6G4pugeDeaMp/yVhHGSA3mGkCNuwE8CgRrv7mfZt+1A5zItOOVdK2DlrhIVnL3wZ1QpMRb6SxP4ZPeSSHdgYI9A/LBn1NLmeWpaaVGU4+KCiaAGD1m9uJ8o01nWNtcFW/XgiqmdjSfqFbEUvjsEFBMqUitoj7EX5jTXu/njXLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839535; c=relaxed/simple;
	bh=a/OSacBm6024mLV+KC1HiwL4Sw2PIM45teYqlBnVeQ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H0Gp7xcyWFakERm1d1Wf/W3ySbC+RK3JOV4plqNOAXTttOASUzmnN2lIerWrCDkrRm6duWdOMossNSqe9JHeGJJvWsPdhvewSWTDeLPtONE0mwgrUr7lB3NFTsW9UtFJgx2M6/RKcrFsQaA3XGW3d7b10O368tPvx5l1Ljfr4po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=k6o3NZKi; arc=fail smtp.client-ip=52.101.191.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXhu4IgHCtVussMAoaLATdTGjkhlhecWP3UnxbBRSbQbHDXFXRummSPyM4aw/nW7BfmlkDozBay6/WdSluOpVOLmlLkrQxbN1xDvyKFuND9O56+UhI9IDxCjIZnQBqMzBfoeIRhcAr9SuPYNXDQiygH84AWOLBUyapqqFCbzk4YggESvG+KRpdrV2ffO4k+uJsJxVD3Tal/qyDwQZUg/fD1U/13BkYJodIP86IXhd/++Vitt4pTP99l6jOjJqQD264dyypEHKALegTuPA+BamaW9GNLMITRjzOeRLh0USe/CPMVcVQxUiLM4r5iEjpERSBoUg5pb+8P7mFxKmTqggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3rd00ADpmLYdbkAuX9+8ZU9nbptDaYzH9IDNX8R520=;
 b=pL9jQSlS/OPUPNsr4YytRmqFxKMCSDVmGY2eF6SSP3AyiOVLLLfxttnsfkveGpn5DJONa18jykt8Prq5Ykq4oiGktC/bK26zuL+9VPbVOl+Yl2r5rwbOSSfP6zMtrNVIFkLbxTRfdiEqbl39korl34FkzN/OzK3tr77DIHtsCNcdfFYWEFIA7zItqKpT4TX3VXVNcnc9xKe2Ca7/IyMwIHANmO1YiayYLLmfrQ1L4tAuFUhekCZR09ykE7D+iOetUFwRnwPcQGQUWafript7D7qf94oVCsjcCHF/39l9jd3k8LBLI2QiB5sXNcr3iUh3oReO+KJPVFr2ah3AlxI8Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3rd00ADpmLYdbkAuX9+8ZU9nbptDaYzH9IDNX8R520=;
 b=k6o3NZKixlP04909MIv9CR+HYH9Csm1b1Dtm4hE8w1Byg7KjlxiyerJs/DUy39IGBkK/gYgnY68IpAp+dpq8zzL74RlpaLErdaQhR6Rb2RHNLmPsvOtNW3YT8UeerHWHXmbw+DjpwCIhwC1cnybQdt8kax2zux5VALsE3DKZGRNZimi/XRJl0eVMPEQXW68cS5ICstAkwRS2i0ycbo/GypIUZNZ/969H1v/vMIE0mk8MwDpFZynn3YRzlRi1CwLJ883upYbhrUUvKDBBOfU865i2bEefFM5/7gg9U/mPgqWX/+ftYolMpIB4eu2art7AZaX8f7QlZZ4gkNAn65kzsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB6580.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 15:52:07 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 15:52:07 +0000
Message-ID: <3957b2eb-8654-4636-b4c9-17467279f383@efficios.com>
Date: Thu, 30 Oct 2025 11:52:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 18/20] irqwork: Move data struct to a types header
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124516.404582236@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029124516.404582236@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0233.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::25) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c4520f-731b-4cd6-3699-08de17cc47b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cURoSU5VeTVLR3VhSmg5SS9GY3RzdGk0Y3k2TWhiOHZCNnJBeVhBak1OaHIx?=
 =?utf-8?B?ckM2bGFJS0F1SS9Fc3QxWnh1YmZaTmt2ZDMvTzZmNzRPNVhTZnRSbnJKMUNr?=
 =?utf-8?B?ZzljejVhaHMxVUdvN2g4cEd4SVdSNEdGbjJwZ3NGUnBkRDMrT1dtWWdBSGN1?=
 =?utf-8?B?dElhbEpMYVJzTSs3eFRORUVUNGVkQWt3SjZySk1xNE5CbGNxVkZyeHpqM1dI?=
 =?utf-8?B?ODhoeGJBMVQybDZkQUkzZjBsdXhPVFFYOUJVN1ZmTlFhbUJ6TktHK3hHZFpT?=
 =?utf-8?B?eXBYSWVQMUdIanA1T1ZFUlJ1cGpEZzNFR3dpTDZ2QUQycEF3ZW1FTFpZMC9Z?=
 =?utf-8?B?SmNPaHpYTTFOSno5QUVxaEhhMlJpRTE0UkRodUplYyt3dU9XS1QzVkFnL1Jr?=
 =?utf-8?B?T1BuRnVqMVQ1R3pVWmNZK2l2UVBnM3hJMFl4RUJUcXp6RGQ4Z01TK0grZnlI?=
 =?utf-8?B?RUJwZVVJVmovN3lvK1B4VStvdXV1YWVEVmZGOFR4UzF2QWlMbDJ2dlYxV0Mx?=
 =?utf-8?B?RnBSelJwaUJ4UGdWbjkraWNrdjhUS3dDYzh6SE44c2hxMVNOUzZQbUNHWE8z?=
 =?utf-8?B?Zlpwd1BCOUEwa3VaRjkvZlpvT0NYR3FTTGRWbk9sWUszeEdJOXp6L3JINXNR?=
 =?utf-8?B?czJESjFUdFZkYTUydnA4RzVoRVpqbHQ5cWZndVIwK3pHZGxjU0RNMDlpVEJx?=
 =?utf-8?B?SHVRdUNpeHhFc05LUUsrbmI5a3VsbTRDSlV4ZzFWdzNjTG0rNisxckNQMHBn?=
 =?utf-8?B?cjFpbnlyRDgraW02elgyYTQrcXNSOEFyNmRndTl6SEtSSTQxS3pWcWY4aGRk?=
 =?utf-8?B?NjZ1bmV4U2cyUnhwMUhoRHhIbysyajJkR1FobWMwUWZQNXlMTWFKUzJKemdM?=
 =?utf-8?B?UzZEcExVRUxzdWNpbWFUK3pDdGYvSGFYUkxOYXB6Z3V2Z1pOK29IdHFRRmwv?=
 =?utf-8?B?Zm9VRm9VK25tRyt0UGZUeUxqd2IwVXdldkhoVmhPNUYwKzFwSnVPQTF2ODhF?=
 =?utf-8?B?MDl1aTJlR3E1MkdIY3JzZzVvbU5UN0xvc1pPS1JSbytFaWtpbUVjTUJaVmta?=
 =?utf-8?B?WnMxUW1QdHE4c01lYUpKUkp6RXl1WUZhL1huclZ3TDRQNm84SC8rVFE3WE5L?=
 =?utf-8?B?SXJtcGJSTk9GeG5GcDlvblh6cWJHT3oyWkdxcjNrM3p5cVg3ZzhGUWNiWm9w?=
 =?utf-8?B?YlQ5Y1Y3OWVhRnFBTG9Ya1h5MGVJMENuVDJtYndpMVdtenBRUXloVGgwY2dk?=
 =?utf-8?B?TFduRFBMaGRXUlJhK3JialRid2l6VEljVThRNUNoSG1Rc2NMVzlab1prOVho?=
 =?utf-8?B?L0RhUXluY1A1RXpQU0NsOXNtV3N4ckdrNDZ5ZzBNd2tHTGY1Mnc3ZlNaWHhC?=
 =?utf-8?B?RFR1ampkU2doc1ZxMDhqeGhWVlFzK0xGQU9LN1ZxdjhsNTNGYktZSlByN0Ir?=
 =?utf-8?B?Nkx0VmkxYnZ5R0ozQWVnS1ZVREtHekd6MTV1NEZyMGQ0MWlnUlhyWnA2bFdR?=
 =?utf-8?B?aGNjMmFUNjB4ZUNHSmp6NDRzZ1dCT05UR0ZrTVQva0RqUUxrblF2OXdHSUM2?=
 =?utf-8?B?bENkeEhvUHV4cEZ5Vk4wa0dSRTRKUkNUVWM5VU41WGNWaU1Qam1UVUNRRHFN?=
 =?utf-8?B?WWlIMVBGYVJ2OUZKalBSc2pwZ3JRZ09FU2Q1UldVdlVNS3NHL1BCMFBBWkhY?=
 =?utf-8?B?ZlZOZHhMamRXbGRJNk91L2hCQ2xMU3FJVWkzekM5UDl6Qy9iZXgwaGpKMmVj?=
 =?utf-8?B?YzBxQ3VTT1ZVNXlVSjBlWnM2dGlTdkMzK0oyOFRqSTBQM3FQSGxQY2tkMlNW?=
 =?utf-8?B?U2xDeC8xR0hKQVdwczBiaGNWWnZxWXR6Q3NuL0VHMGdjVXVtU3V2Y0E1WWJ2?=
 =?utf-8?B?ZVlUMS9oWS9CZHNNOUxjQlJVZytmS21kdGJ6bXppbWxEQXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUlaNXJua1Vma1JML3JMSVNLNDRDeitNak9INFpuSE5ES3BvVWVJdTd2Vnpj?=
 =?utf-8?B?cFhDVUZibGJxTmlkcFREd0RUYURSSEEvbEg2SWtlQ2djN09zTmNmTmZvS2Iw?=
 =?utf-8?B?SmhlbzV6YjIyb0ZRWjVxcFp4VTdLa2NUTlF2elhkaFZzUnVuN3MxNXZtbWta?=
 =?utf-8?B?RHJydG52WDFranRJSlBGd0Vub1NDdllPT2oyaDlxTm40MTU0ZEx6R2lVZ1hL?=
 =?utf-8?B?eDFtYXRhd2R5ZmgrZ1AySnk4blpHWlIwVElrbGlFOGhWZlI4SzVmbHNsZDhX?=
 =?utf-8?B?K3JNekc5MWJUdzdvY1Z2SW85L3Nwa2NyNzNOYzhKTjlEZnE3ZWNrc2IvZHdH?=
 =?utf-8?B?a0JRUkk0RTVkekxkZ1FjdU81VlJxOEVRMFpkZFl5S0dzNTlMV0JJQm4vWlEw?=
 =?utf-8?B?WUtHVHNLbkhwL3ZtT0hpSnRZN1RnMStET1F0RGNzWXpsVlg0RHNoZkZPb2Ja?=
 =?utf-8?B?cG1IdVhRcE5TTWlxeXU0ZnB4RTN5RnFMNDZUUHlTOEVFeS9OcjB6b0M1eWth?=
 =?utf-8?B?MXFDWFpNa2xNY3ZEV0Z2V1kxeEtNMUhRYnUzZHMzdzhLTXpoMjFDN05zV2VG?=
 =?utf-8?B?Mmp4dXVTSTBZaXZzSjVGRi9QVG1wN1hhdXEzUEYyWHJ6bmo0ZDhUQnVXM25t?=
 =?utf-8?B?ZkZxUDlaNkZiMmROaGNHdHVIbmxOUlFyT2dHYzk0QXlJWUlMRk1zNVBkWm1j?=
 =?utf-8?B?RkV2akUxYW5oNVU2VXJoUldNVElNWjdySXNTYW9KSkxHSlJIbWptc1p4UTR3?=
 =?utf-8?B?WjJrNFlZK0k1cEh2UVVyWVpEZkl2NzZVdzFKZ3phOW40ZGJyYzU3OXd2K1Yz?=
 =?utf-8?B?dXpuQzBOTm9YL0xoMmhmVVpxaCt3THBRWW40akNZcUpseDNSS3oxQkNITXla?=
 =?utf-8?B?bEs1ZENUVjBHblVXMFJlTlZNRVFEbmdNSGF3bmNGRkllclIzVHJEZUd6RFNh?=
 =?utf-8?B?THVVK1RWc2RMamM4SHBIbjA2aHVUT2NjMjYrR2lDNkVVMWpEZjZCYmVpc211?=
 =?utf-8?B?ODdTZ2pUNHN3c2JYby9FOGJvelZNOWdzWmJZRi90RkJ2S0ErYVlqTHhuQThv?=
 =?utf-8?B?OERRSzRpWkM3a2xxejFDRU5TdE9WWmQ1MWcxMUpBcHdweEErWnpVZmc0SjhV?=
 =?utf-8?B?c081UmZtVlN6Ull0V2lpMjNhcXZab3MwZHVIM2ZiYmRqcExpSUMvcGs4SUVa?=
 =?utf-8?B?SG5XUFQvY1oxS1h3aW1BYmRTZnR1UElxNmVJSXczK0pZMEFtcGJlVTlrYXRs?=
 =?utf-8?B?M25WMWlQNHZSRkFKeHpseHNvTnBNdEt6QTFaODd1T0E3YjJVWTl5WkVnTU5l?=
 =?utf-8?B?Q3g4Y0xnNzdUWkhWbVY3aC92YXBpRnhHUDNHSGNSNlNvbjhIaWZLZUMrNS9T?=
 =?utf-8?B?U2pxOERRbm9rQktudmhYdHdzQ1F3bDlpOURFb1hReWJncGZHaXR5TDdrL3Vp?=
 =?utf-8?B?aU05WG1QUkRSdTVrQ09ZU01QY2lOT09lOWpHK3IxY1Nuc3JraWVFRFVJVWxE?=
 =?utf-8?B?SzBGQjBValJvMUVSQmcvWHdJbzNudEtFQW5XcnhGREJoZFNtNmhDM2ovaDRN?=
 =?utf-8?B?QmRnRGNodFljUVZuVlBKMjd3ZU45WGw5dXBTVlZwRDUyVjd5bVh0d3RHWWNI?=
 =?utf-8?B?VlhVNG80SXhaUW5mQUpEM0RxVjVZM0NBbUdtZm83Uys3dmp3cW5iOW9rclZl?=
 =?utf-8?B?RnlXMjhCYkdzMk5McUsxYmxzR0o0SGt0NzREUDF2NWtHWlc5S3dlT1Z6amly?=
 =?utf-8?B?TG9tMGc2WHFYT0p5SENrUjQxZWRpdG5yRDEvcmhlbTB3NlE4a2hhS0NHaFpa?=
 =?utf-8?B?WWFCd2NNSGlkci9hWmZtRS9vZnpTTGpvTTc1cnA5MmNiL0MwUjJHS1JhWVlY?=
 =?utf-8?B?blRGMU4xeWFTaEt4RXBIT3J4YXF0WjViYklkRHIvMHVZN1BhekcrUVE2Q2pE?=
 =?utf-8?B?VDcrTVBLRG1qYzhWODF0NVorTHdwdUE0ai81OEpmU2p4Sk9pL3FBNlJ0WGt5?=
 =?utf-8?B?dDlMbG5RV0w4L25pL250cndFdWl6QjZnQWV6bW4zUld0UW9wSHBGdXJ1K0tN?=
 =?utf-8?B?S1BQcU16WmJDVVp1QU41eHpYcjYxcFJJRzZPWEFLblRDaVlsTDEzYU1ITEVI?=
 =?utf-8?B?NTVBL2g0OXBJUnBDRERRaWt1ekp3Rzk0S0pkQlltYWFWWjgza2xUQ2FtdkI1?=
 =?utf-8?Q?PIa1Tj+/3/9GgUewpzbcAJ8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c4520f-731b-4cd6-3699-08de17cc47b6
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 15:52:07.8570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XG9aRukTOS5uPtQt9L25rHG58ME7M25D4kR/icXEYxvA+by9x8vRzxOvO6N0O8IRs6hS52set2YLEx8SxwyyhbVzh2PEF44JS10raPXrRZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6580

On 2025-10-29 09:09, Thomas Gleixner wrote:
> ... to avoid header recursion hell.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

