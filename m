Return-Path: <linux-kernel+bounces-889365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36352C3D640
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 21:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFC83A6DC8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 20:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6075F2BDC29;
	Thu,  6 Nov 2025 20:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="bAdOkjDr"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021089.outbound.protection.outlook.com [40.93.194.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AB81D516C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 20:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762462015; cv=fail; b=FkiItj9WGjLRcIhst4L52y1ogzR1iUP6io3WuhGAIcAML+2mLbO7VwFmQ99qqdXBQXz9s1+GoRLTjkiIz6CxGEi8Sd1521oG8uuaVx343q1OBr6pjVZNQU3jETspHyVreyqBnptPH898g6VJzHzGz71120RhMkepskLkxqqN/aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762462015; c=relaxed/simple;
	bh=+Qd9deklEyVGMakqisYsAjN/rrrA9OfmGdbJV426cS0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qjEgVviGfZmEuxycL5GsKQxmQeQe+QEvqfAPrK6AV3G/DrKt3VX0/P1T1Wcume29VM5putMog7m5QJVycbTn06cmucS8BpOFVb8uPY/rollt3HHRvfLCcZ5xXvl4XA/N0sDM8dI3tEp4BCWjQR3+aNTpserb3+Ek6btYzM5tV8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=bAdOkjDr; arc=fail smtp.client-ip=40.93.194.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdvemsnzwPATOM5Motn9Q0w3pzo7TCjGvS5JHRkGEGZ+V10jQq99EzhmDnNJUtaBuBez7SmmYZGA7kgQjvdkpe7y82s1Y/0QsgeIIgUI9MG3yh0R5hoO/22Mgn6c36NAqvFOjRZkuwuYKVIEOXHP/hDZbAS257vVoA6AYEtgkQQFQLfjdN4auaqZPo2ciQjdwPfmAWkzK+ON5crYiJ0ihppY3DmtciZr/pMOFMcRmooHrd3ooqBBqDPtdxBoWgyu5z8JeJJ8aLSLs59Ww104zZ1eY41BFYjJd+lpcImyv9r09nHkZAz8ottjOWOEy6ljr5Ehd3v3uL66o+rgoRETqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkQEm2RtSesdXVzvwLEuntE/BIwgFVv+hrTg1KqMqwA=;
 b=c9NX41YZFucqGXjdZexivyh1Unach+1RrCHHh75eRcP8wnpfBuJwV8vHwwZhZFoYiGTxN0BtnI34PiKcYhrAiIgXijAVcaL3vVrIUVt6CzoSyV99RdnoDF5uhtdZT9lCk1nKA502NqvOsSbjE+LDpo97DNE6wRVQWiplre1VN8a2oRceaqoX0m3aoIHurJyaTqfSu+bNUxLtA/F6dUrDprw+LBgQH4OedKOkC+RuhbVlCJzbxO0T9DY7q0JNu3p3wyQwGu9QtRRAwnywvfsaK8+xFcPtHXV/2uWVu8gjLDqqwj27PmJbxTdhaR3GTvqpvSmY7BiUry/Tg72xiLaJ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkQEm2RtSesdXVzvwLEuntE/BIwgFVv+hrTg1KqMqwA=;
 b=bAdOkjDr/bpzQcmaWsHylgRc0waxUBWS1xESOnSVbNw09k6kTwRHwKAH8jdPnblOAj03S2xabwXN4bP21qIpmRIzE6HEXW2bU4O6YePN/oIeniQzzZKry0apPYbHXeM92b0WOiDb4Z4zslT0nR1QrCspYK0hnGpTyQ1MN88fnHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 DS1PR01MB9039.prod.exchangelabs.com (2603:10b6:8:219::12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.12; Thu, 6 Nov 2025 20:46:50 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 20:46:50 +0000
Message-ID: <d6d7e038-aa94-491a-8ad6-f48541b98b6a@os.amperecomputing.com>
Date: Thu, 6 Nov 2025 12:46:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: mm: Don't sleep in
 split_kernel_leaf_mapping() when in atomic context
To: Ryan Roberts <ryan.roberts@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, david@redhat.com, ardb@kernel.org, dev.jain@arm.com,
 scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Guenter Roeck <groeck@google.com>
References: <20251106160945.3182799-1-ryan.roberts@arm.com>
 <20251106160945.3182799-2-ryan.roberts@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20251106160945.3182799-2-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0205.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::30) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|DS1PR01MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f9fca9-e3d6-4573-e05b-08de1d759be1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2x3d0Q5MXFTVTdYTlBxaUtoQUpvM2hGcC9la2xLY3BFRmhIa0NJd3RGTm95?=
 =?utf-8?B?a2lHTWR4dnRKWG5oaThrWnBNUGErbXFrYVdQSkFjcEZZbUdwTGt5cFBKSDVR?=
 =?utf-8?B?ejBucFRZVGdoaldHeXV3QzhIZHYremdCV3lENVNTbTR4RVNvekFYckhGMEoz?=
 =?utf-8?B?bjkwaWR5SWZSR0t4UmFkbFQ4cnBRR3dhNkgwK2QrNDBjdWxKVUJuNzYvSHZu?=
 =?utf-8?B?Ly9BNVVxelRhaE9uZjhDdFYwMjYyQTJYK0tFTGk2SW9PNnlyQ2JwSWNuellW?=
 =?utf-8?B?TVd5dDZqMkZnUlFQbXpva2NaeWxkdVc2QmJnRVlMZWkxRGFDVnJZTUp1N25R?=
 =?utf-8?B?RlJlYUUzY05EbDNIZ3Z2MXFGQ1FHQ1dTUkQ0eWRmWEtwTlhmZ3daUDRzZVRH?=
 =?utf-8?B?a0IzbmMrTnFjcnppdHVsZ1lVNEV3NWhHM3JTUTErWEk5THpxOFhEQmdZdEla?=
 =?utf-8?B?NkNZZEEvelVVdWJBVVVrTzliN2twcTdMVUxZaVJ3SkJIMGtzRmFFWWExcGFF?=
 =?utf-8?B?RGZTVHh1WWVnZlFsQWpWMENvZzhHbE8zOGdmRStHY3M3QlhCdk4vbjZKZU85?=
 =?utf-8?B?QnNvNGdVYktVUzJSVDBOSnlIKy9HanJ2RjF2TzJWd0pDdFNXanRzUUlPMjNC?=
 =?utf-8?B?YnRGRkc5WXRTTVgrdWF0MFdWeTgxZmYrUjRCYnZlUExjUVNKRnVSSUhoUlJ5?=
 =?utf-8?B?NTAyOVF3a0FGRGZYUUludk1UcGF4K2M5dERuU1lCYm5HWXhCZE5acXcyVGRY?=
 =?utf-8?B?d2FZZHRDSHYwYWVYdnhQUTM4WHA4TTN4dk5XZDgzbldpUUhUKzhtMnNSaVFn?=
 =?utf-8?B?MVJzZmgrVllZd3VURjhmWTFzVi9LMGluK3ZucjBKTnBVOGdpRmlET1YrdDl1?=
 =?utf-8?B?NUtTb2lqV1NNS2k1b1BDQ1BoK0xxV2J4dzR0YUw2OUVvbUd5b054VEI0TStR?=
 =?utf-8?B?ZFA1cDhUSTBLZkdVS2ZWaG9LZDZXWlZZZWZEV1ZKNU1PUHMvZnJEMXpydGl6?=
 =?utf-8?B?bEMwbUk1Y25UMXZoUmU1YmJZTkdkRy94UmZTZzE0OWpYeGl2QWJUa3VZb1R3?=
 =?utf-8?B?MHloRHU4bXVrMXF4alVBRGluSXdtakJWQm9SencvZ3FGMXVlTmwwVnc2bmd3?=
 =?utf-8?B?Rm1DdThuVWRiVm9mYko2aWpKSWpZWlNrQ0ZnUGJLUFVtMEJlMnQ1UU50cGhK?=
 =?utf-8?B?RWlMMkcrZU9QV2E3TDBXZE94b2RiZXRjMmhldUlaZXNOMXc5SlVlZHEvS21H?=
 =?utf-8?B?RmR5OHRpNE5UMlhHUHFNYmRySEE2QVMzRHpIZmtnRVcrZ2F4NHdXeTVaVTQw?=
 =?utf-8?B?ODB2eFBxZXRuKy9UZ1Ezczl0dUNMbXk0RU9Ua1htTFlYRWhtN3o4bmYzWU1C?=
 =?utf-8?B?d3NzbnYwTGt1NHhaZ1ZDTlVSL2VCMEtiRFdTUVJsTDYwQ2M1bHIxamIxcnYv?=
 =?utf-8?B?Y2gxL2l4NEh1SlozdkNiRnBDR1J0ZjZlNlVQL2RTRWhObkNiOGdlRjR6Mnpz?=
 =?utf-8?B?bFg5SFlaaE8zYVBjRHZNRUMxM2xQM0plb0t4SGdSL2p1TzRJd1FBZUlpRFZT?=
 =?utf-8?B?d2I3VkZVWVQ0RURrTEpUbThCcFRQUFZHQmw1bDdhZG1nY1AvL29ZcFB5NEZq?=
 =?utf-8?B?YnNoUVRHS0lWNkp4UTZtdDNiTUpIU2Z2UkV1YTEzWVdBOXJ4RU1hR1hodFRo?=
 =?utf-8?B?SXJQV29KRHVMN2V1SXE4N0Z5Y0ZEL3ZXbGhoa0xka0F5MkpVcnBHU2h6clBK?=
 =?utf-8?B?cng2aXlKdU5mRTc1VUc2UWFIM093R0MvRnJVN1lMaExOK1k3VzBlZXFUR0Zz?=
 =?utf-8?B?QVpUdXlFSUdZaUhPMXRqYWNGWi9TQXgzSERyM0FXVUxYR2FsMzI1QkNtWVk0?=
 =?utf-8?B?UGVmQjBOWnZCYVR2N0I5bkkwNnhRa3JCdTA4Qk1wZDk5RGFNSnU4VW9XQ2l0?=
 =?utf-8?B?YnNreWtieitCZ2xIME9OVDFRTGNIa2t2dVZ5RUNTRTNldkU4MFBjUHZXa1Zl?=
 =?utf-8?B?d29HZ254T3RRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1A2TnkwV0dXQ0piNXVFcnNLM0ZnekxXaGRMQmZhdys3elkwb0hYSExtYXlh?=
 =?utf-8?B?bzA3d3RGbnJ1dVdFdm16UnUyWWh2cmdiL1JxUlpqK0dGN01QNGYzeEtUaVZk?=
 =?utf-8?B?UHNMK0JPQnlyam42dkR1VVR5NCtETjR4TXkxOFJsczhsbkZiaG5LSTBLOERv?=
 =?utf-8?B?VjdMYlJoVHFMaDZNVm0zdWpYSlpIenpaelBwT3Fxank3c3ZnU1Vjb0pPRFlK?=
 =?utf-8?B?QnJqZGZEVStzRlFvS1pORDBFSWpKRWtVZDRubVRqbkZabW0xV1R5Tk0vS3pQ?=
 =?utf-8?B?NlZLdEFLYjREbE5aa0xqWHYyN3RBdS9ROXJ0Z21zRGRmell6SVpJL0ZUWGE3?=
 =?utf-8?B?bzg3Y09zd1pKVDlsdVZ5c2huUnZmVDVxVVhOcDVGNFZYdzRqY0wxTmtqREhE?=
 =?utf-8?B?T0sxdHJhOTlvYjNNYURZanhNZDZEZU1mdndsTUZ5SklsNTRBa2dCajFnRHhm?=
 =?utf-8?B?K2F4RzJKWExTb1lmNURWWXI3QVpONm53bjJGRmE4NU51S1l4VzNGcnh1UzBW?=
 =?utf-8?B?Q0p6bk9FRUFnK2JiY2wvUjRXSm5UUWNlN0FMSWExeHJzdHB1elFMRFBlMG81?=
 =?utf-8?B?Ymg5VDU4UklZeXZHZ0NCdEFDMi9ZYnVXaysxelR6dEM4N2F3NjlRb0x2aUI4?=
 =?utf-8?B?Y1NzYkQwclJXdzdvcWYvWnJ4OGNPcWM5YUc2dmRzUGMrdTJLQ05uWUdjOTBS?=
 =?utf-8?B?Q0NEY005YWNHUUpIOHZCV2hnOEFyRHUvcjYvSUt0VU9icTUwK0k1azJaaUNq?=
 =?utf-8?B?M3BUSFBBcExVNTFKVlpYRFo0VmpZNnNGUi9FSDc4eXNiZFE1MkZUU1dHN2lX?=
 =?utf-8?B?QkxuM20wdFh6dEJTbDBoQk1SY2xnMVJYSk9EbHdJOW4vTzgzWEhWb2ZaQkRX?=
 =?utf-8?B?dzBFYmxiOThYdGlqS3NldCtxNFUxR1pORTZldStYOC8vZjFsTXZlS2RDK3hu?=
 =?utf-8?B?RDFqVUN0UWVrejNEd1IzMHpHVCtZRnY0b05MNitrWTNqTjBZaFBWWEhEelRj?=
 =?utf-8?B?S0JIRDNYazNyUXE4bG0wYUpPelYrdXdReHMrSWhBb2wwcTZaYXpaOWdJNzd1?=
 =?utf-8?B?RmlPazFZV0NFdXhndzFrdStOOE5xWmV2SE9WTjNtbzNHWHVnOUdvZHc4TFQ3?=
 =?utf-8?B?Q01XYnhHS1VpNVBLUG9KaXg2cHRvQlh4VjNPL3FXMzIzUDlCUzgwTU9VNFdx?=
 =?utf-8?B?eHl0a0plS1duNDFFZTZZNnlQV1JiL204VWFXNkFWMGhhdGMxeUthT3Z6ekIr?=
 =?utf-8?B?RGM0WHNTNHhFL0dFSXNDVGxHYUt6a09EdWpJbm92Y3hmUTh3bVcvdlVvcW55?=
 =?utf-8?B?dHpyZDZOb0RyRCtYWDhDbkNrWGdNQ3pGRGlDSm1ncW13dlR1TlRSNk1zM3VR?=
 =?utf-8?B?TDY0NUY1Nzc1UUg0SE00NHE3aFF1SnRIUDNpTmt3QlZlUndYZ2JHTjJ3ZlJM?=
 =?utf-8?B?S3VrWDBGNnlEUDNUbnVNV3RTMFdhRmU1dXhXcEozeWlRRHVlVVN4bzhiMUFZ?=
 =?utf-8?B?VkhjWGJOa3FYcE8yOUU4Z1NsQ28vakVXaUVNcjBpWXlsQ0tsNVNqd29nUk11?=
 =?utf-8?B?SVFxclFvY1N2TzFwYWJ3MG9UK0hxR0RCZ2hjUGVmSnc0c0U1Wkpib2JOSmY1?=
 =?utf-8?B?YWViRTlQTkdoazA5cHFEbGRWQ1R4cTU5ZWlmT0FZWVI5WkliajJLbVZ4SEth?=
 =?utf-8?B?U2xsUEJZbkVTNDM0UzNlNmw1U1FjazFlMjJURFNLV2ZPUXo0NG9zWUMyNFV0?=
 =?utf-8?B?K1UrekpPdjhNMTIxRHF1eHJHOWd0ZEdwaHhwN0tmVmc3d3NibjduSHBzOWhO?=
 =?utf-8?B?dnFaRFBZR1JRSFpCSXg3bFdQM3RQMGRGRFlRelo3eEVPZVRBMGd6NmRqNTVi?=
 =?utf-8?B?NlV1T1VtaDRyVmp3VFhFT29NZmhZK3hHc2V4bExWaUlmeThWYTJSb3JxWUpJ?=
 =?utf-8?B?N2d0Y2pvcjlhVHhpVTVnYkdxUTdZM1FyN1Y5OXJBeEluNGJJM3VhMHBwd2Vp?=
 =?utf-8?B?NXNQcW5lK1B5YlJxaUxsTmFQQ3hyWW9zbVk0bk5sV05NamhjaHgvNmZXOFRs?=
 =?utf-8?B?OUZHbGhYR1hjeHdJb3NaMlRDQlBKZ1BpbjU0U0dwQUhUUnNXZ2FpMERLcjVo?=
 =?utf-8?B?TTAvMi95bkt6aEdTNWxaTExYZFRudkpRcHRqTmVvSWxieGZhUGgyUzJheU9z?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f9fca9-e3d6-4573-e05b-08de1d759be1
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 20:46:49.9659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IeNlKnlFTYj0m8yo7TmrZT3o9aBRXNJRMsjlUwZ2QQhdJH/Am9h2FY0p8wLcyaYfeJMF1hWojjyFGCTIWrTvN1kNYi7oQUn75WCHeu/HUH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB9039



On 11/6/25 8:09 AM, Ryan Roberts wrote:
> It has been reported that split_kernel_leaf_mapping() is trying to sleep
> in non-sleepable context. It does this when acquiring the
> pgtable_split_lock mutex, when either CONFIG_DEBUG_PAGEALLOC or
> CONFIG_KFENCE are enabled, which change linear map permissions within
> softirq context during memory allocation and/or freeing. All other paths
> into this function are called from sleepable context and so are safe.
>
> But it turns out that the memory for which these 2 features may attempt
> to modify the permissions is always mapped by pte, so there is no need
> to attempt to split the mapping. So let's exit early in these cases and
> avoid attempting to take the mutex.
>
> There is one wrinkle to this approach; late-initialized kfence allocates
> it's pool from the buddy which may be block mapped. So we must hook that
> allocation and convert it to pte-mappings up front. Previously this was
> done as a side-effect of kfence protecting all the individual pages in
> its pool at init-time, but this no longer works due to the added early
> exit path in split_kernel_leaf_mapping().
>
> So instead, do this via the existing arch_kfence_init_pool() arch hook,
> and reuse the existing linear_map_split_to_ptes() infrastructure.
>
> Closes: https://lore.kernel.org/all/f24b9032-0ec9-47b1-8b95-c0eeac7a31c5@roeck-us.net/
> Fixes: a166563e7ec3 ("arm64: mm: support large block mapping when rodata=full")
> Tested-by: Guenter Roeck <groeck@google.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Yang Shi <yang@os.amperecomputing.com>

Just a nit below:

> ---
>   arch/arm64/include/asm/kfence.h |  3 +-
>   arch/arm64/mm/mmu.c             | 92 +++++++++++++++++++++++----------
>   2 files changed, 67 insertions(+), 28 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kfence.h b/arch/arm64/include/asm/kfence.h
> index a81937fae9f6..21dbc9dda747 100644
> --- a/arch/arm64/include/asm/kfence.h
> +++ b/arch/arm64/include/asm/kfence.h
> @@ -10,8 +10,6 @@
>   
>   #include <asm/set_memory.h>
>   
> -static inline bool arch_kfence_init_pool(void) { return true; }
> -
>   static inline bool kfence_protect_page(unsigned long addr, bool protect)
>   {
>   	set_memory_valid(addr, 1, !protect);
> @@ -25,6 +23,7 @@ static inline bool arm64_kfence_can_set_direct_map(void)
>   {
>   	return !kfence_early_init;
>   }
> +bool arch_kfence_init_pool(void);
>   #else /* CONFIG_KFENCE */
>   static inline bool arm64_kfence_can_set_direct_map(void) { return false; }
>   #endif /* CONFIG_KFENCE */
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index b8d37eb037fc..a364ac2c9c61 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -708,6 +708,16 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
>   	return ret;
>   }
>   
> +static inline bool force_pte_mapping(void)
> +{
> +	bool bbml2 = system_capabilities_finalized() ?
> +		system_supports_bbml2_noabort() : cpu_supports_bbml2_noabort();
> +
> +	return (!bbml2 && (rodata_full || arm64_kfence_can_set_direct_map() ||
> +			   is_realm_world())) ||
> +		debug_pagealloc_enabled();
> +}
> +
>   static DEFINE_MUTEX(pgtable_split_lock);
>   
>   int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
> @@ -723,6 +733,16 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
>   	if (!system_supports_bbml2_noabort())
>   		return 0;
>   
> +	/*
> +	 * If the region is within a pte-mapped area, there is no need to try to
> +	 * split. Additionally, CONFIG_DEBUG_PAGEALLOC and CONFIG_KFENCE may
> +	 * change permissions from atomic context so for those cases (which are
> +	 * always pte-mapped), we must not go any further because taking the
> +	 * mutex below may sleep.

The path 3 changed the comment, but since patch 3 just does some cleanup 
and code deduplication, there is no functional change, so why not just 
use the comment from patch 3?

Thanks,
Yang

> +	 */
> +	if (force_pte_mapping() || is_kfence_address((void *)start))
> +		return 0;
> +
>   	/*
>   	 * Ensure start and end are at least page-aligned since this is the
>   	 * finest granularity we can split to.
> @@ -758,30 +778,30 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
>   	return ret;
>   }
>   
> -static int __init split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
> -					  unsigned long next,
> -					  struct mm_walk *walk)
> +static int split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
> +				   unsigned long next, struct mm_walk *walk)
>   {
> +	gfp_t gfp = *(gfp_t *)walk->private;
>   	pud_t pud = pudp_get(pudp);
>   	int ret = 0;
>   
>   	if (pud_leaf(pud))
> -		ret = split_pud(pudp, pud, GFP_ATOMIC, false);
> +		ret = split_pud(pudp, pud, gfp, false);
>   
>   	return ret;
>   }
>   
> -static int __init split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned long addr,
> -					  unsigned long next,
> -					  struct mm_walk *walk)
> +static int split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned long addr,
> +				   unsigned long next, struct mm_walk *walk)
>   {
> +	gfp_t gfp = *(gfp_t *)walk->private;
>   	pmd_t pmd = pmdp_get(pmdp);
>   	int ret = 0;
>   
>   	if (pmd_leaf(pmd)) {
>   		if (pmd_cont(pmd))
>   			split_contpmd(pmdp);
> -		ret = split_pmd(pmdp, pmd, GFP_ATOMIC, false);
> +		ret = split_pmd(pmdp, pmd, gfp, false);
>   
>   		/*
>   		 * We have split the pmd directly to ptes so there is no need to
> @@ -793,9 +813,8 @@ static int __init split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned long addr,
>   	return ret;
>   }
>   
> -static int __init split_to_ptes_pte_entry(pte_t *ptep, unsigned long addr,
> -					  unsigned long next,
> -					  struct mm_walk *walk)
> +static int split_to_ptes_pte_entry(pte_t *ptep, unsigned long addr,
> +				   unsigned long next, struct mm_walk *walk)
>   {
>   	pte_t pte = __ptep_get(ptep);
>   
> @@ -805,12 +824,18 @@ static int __init split_to_ptes_pte_entry(pte_t *ptep, unsigned long addr,
>   	return 0;
>   }
>   
> -static const struct mm_walk_ops split_to_ptes_ops __initconst = {
> +static const struct mm_walk_ops split_to_ptes_ops = {
>   	.pud_entry	= split_to_ptes_pud_entry,
>   	.pmd_entry	= split_to_ptes_pmd_entry,
>   	.pte_entry	= split_to_ptes_pte_entry,
>   };
>   
> +static int range_split_to_ptes(unsigned long start, unsigned long end, gfp_t gfp)
> +{
> +	return walk_kernel_page_table_range_lockless(start, end,
> +					&split_to_ptes_ops, NULL, &gfp);
> +}
> +
>   static bool linear_map_requires_bbml2 __initdata;
>   
>   u32 idmap_kpti_bbml2_flag;
> @@ -847,11 +872,9 @@ static int __init linear_map_split_to_ptes(void *__unused)
>   		 * PTE. The kernel alias remains static throughout runtime so
>   		 * can continue to be safely mapped with large mappings.
>   		 */
> -		ret = walk_kernel_page_table_range_lockless(lstart, kstart,
> -						&split_to_ptes_ops, NULL, NULL);
> +		ret = range_split_to_ptes(lstart, kstart, GFP_ATOMIC);
>   		if (!ret)
> -			ret = walk_kernel_page_table_range_lockless(kend, lend,
> -						&split_to_ptes_ops, NULL, NULL);
> +			ret = range_split_to_ptes(kend, lend, GFP_ATOMIC);
>   		if (ret)
>   			panic("Failed to split linear map\n");
>   		flush_tlb_kernel_range(lstart, lend);
> @@ -1002,6 +1025,33 @@ static void __init arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp)
>   	memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
>   	__kfence_pool = phys_to_virt(kfence_pool);
>   }
> +
> +bool arch_kfence_init_pool(void)
> +{
> +	unsigned long start = (unsigned long)__kfence_pool;
> +	unsigned long end = start + KFENCE_POOL_SIZE;
> +	int ret;
> +
> +	/* Exit early if we know the linear map is already pte-mapped. */
> +	if (!system_supports_bbml2_noabort() || force_pte_mapping())
> +		return true;
> +
> +	/* Kfence pool is already pte-mapped for the early init case. */
> +	if (kfence_early_init)
> +		return true;
> +
> +	mutex_lock(&pgtable_split_lock);
> +	ret = range_split_to_ptes(start, end, GFP_PGTABLE_KERNEL);
> +	mutex_unlock(&pgtable_split_lock);
> +
> +	/*
> +	 * Since the system supports bbml2_noabort, tlb invalidation is not
> +	 * required here; the pgtable mappings have been split to pte but larger
> +	 * entries may safely linger in the TLB.
> +	 */
> +
> +	return !ret;
> +}
>   #else /* CONFIG_KFENCE */
>   
>   static inline phys_addr_t arm64_kfence_alloc_pool(void) { return 0; }
> @@ -1009,16 +1059,6 @@ static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp) {
>   
>   #endif /* CONFIG_KFENCE */
>   
> -static inline bool force_pte_mapping(void)
> -{
> -	bool bbml2 = system_capabilities_finalized() ?
> -		system_supports_bbml2_noabort() : cpu_supports_bbml2_noabort();
> -
> -	return (!bbml2 && (rodata_full || arm64_kfence_can_set_direct_map() ||
> -			   is_realm_world())) ||
> -		debug_pagealloc_enabled();
> -}
> -
>   static void __init map_mem(pgd_t *pgdp)
>   {
>   	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);


