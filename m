Return-Path: <linux-kernel+bounces-753281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E89B180F8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CA6E7B0779
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D6C245033;
	Fri,  1 Aug 2025 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w1uDnVAB"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBD421FF3C;
	Fri,  1 Aug 2025 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754047258; cv=fail; b=nxcWC3ZuB/nfTPjRcYbWrbcZfbBm278xJ/ZSWFjnujomf2Zy85xhhMV/Olsqfi4wJmJpZ7DxQzxfySNhLpiAr7QmhFDYlcKt8p96gIk4iyuBljnDCdjRZMaTdvM5BlmMasGuYewHFCsaKxwLWwdzvDO6nnB+Zx8H07UfJD6ZYkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754047258; c=relaxed/simple;
	bh=TVPjxNPxOAjyedBHFR7OonwnwWOjizXCiEmlX9O6vr0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OVA9XgPGjut8T7KXkUTdEIEFncbQYsBcZZR2JM+sg2QKEQv9cKMcIvpJnfhuzjafw/VGZzR7cg4QLC+f+BX2wKwR0O9qRdpS9v7O1zracgDDPfTD7okZ6ejcugVD89QNyy5xRVn9eo6JgXOl0IsXVbYGNZffChOYXsWxdcFm+/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w1uDnVAB; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgRsEXuZiO36Vy4yp0bOGL9eW3fWM0qyI+N5Bqf5heKZCUNy2S7jeEZJinBTvIBrupFMC81o5yMlzZJ4i+uio4wN32E0RBsLE6X7sL7RadUnew+0juySnaQwSNigm53zA4zLOL3lVZNT1bQKGGLWgW4+BHTE6AtLj3qw1rLF5sXeqd6EAHHOmGNLtHP7OkaCjrzAL2HcWEqXSaz8DWKWzjPCyxQqwG9M1KV4+uUQAD+22o7kYfcT72o+a8hpFS4V3kPmQTzww+cRxX+JHlc1ghIOhLRAXlSGERuLJG7zRgfbyPism28ScH8X77ismj4+ulUGS+xzMdQwEq95gMb6nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhdMxAzCCMAChM6sX9WfU7maotPK5GWfs0GaLqgUEFo=;
 b=dyP85KE2BvlalOSXOv2dhgG6ol458THXolpuFWLpMwcJ8f0c6HFhxkCJTaMCSKdFUn6K/okmCqtKe7ozKnuSqac53UDGLMxF5FEdJewoGxt33Z2f7BYSrYtrqQfPmeOQM3QEdxLQ7Lv0Ax2F1qqwR5iDAgUANtXmGg7mpPqe+kYwmHQa0JDoJurDAK9uSxBS24MOK94BmblVBarZ+fMYNTeLTxpaN29730qkgspREscPzChADrCW3K/3ahqWgWt5vWc7hSaymbTCA90QdOxoefmUqTwqvPaSOMMaVs+OWBB/EIAbJIUkyZCBCYYZx54Xdqb6v7cy5O6q7kfh2McPBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhdMxAzCCMAChM6sX9WfU7maotPK5GWfs0GaLqgUEFo=;
 b=w1uDnVABBnLIlCcbHv7l4McWTKKIkc6XjSSafQa3vEBa4UYLJw8+2sDn4oLx2Ymiq1n+vT2W8JXEqVyAH2dSqtYpUq/6Ov1uQ9woBc+9N7Zx6pcX5yd1IiCinqGhBYe0LhedfyzSm2vDYV3KM7KvSdbW9i5BJQP6bXSY/9GK3uE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH2PR12MB4197.namprd12.prod.outlook.com (2603:10b6:610:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Fri, 1 Aug
 2025 11:20:55 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8989.010; Fri, 1 Aug 2025
 11:20:55 +0000
Message-ID: <091bd33b-f72f-4d9f-b234-29ddfa21acb3@amd.com>
Date: Fri, 1 Aug 2025 13:20:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Enable PSCI 1.0
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <32be8050838512d4340486227c32f38298ddde57.1752839409.git.michal.simek@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <32be8050838512d4340486227c32f38298ddde57.1752839409.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::13) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH2PR12MB4197:EE_
X-MS-Office365-Filtering-Correlation-Id: 535ea41e-e9b2-4f3e-7d21-08ddd0ed7b3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vitld3ZLbnBXenVQZVp2NStXM1d3MVlOSFdHSWhRSEdkamhBTEZiYWs1cFNr?=
 =?utf-8?B?Qmd6aTkxQ05Jbjc1OXhGSktTdktYT0g4WlFUdDhzWG1DaG5PK3ZTaXRQMDFN?=
 =?utf-8?B?VlJPdi9yL1BBVHBrOEsrcTlMT0dRVkVGMmpkLzRYaHM4Tzd6eU1aalVmYWZZ?=
 =?utf-8?B?a0t6eGNJZnhIR0JJOWtncjUxdi9qMi9GWTV0SVFDQklQdmkvdUhzUHIwd2J4?=
 =?utf-8?B?OTZKMVFYdlVrTmFnWTNNVVFnOWpOd3dFVms4cnRoM3B2eFIrT3liOFVMRWMv?=
 =?utf-8?B?VjVFdXNQQXQ5UUdQRkkyUHd0QlJtUzdNaEo4QW9kSDV3QlFMbUdDTUhqSjI4?=
 =?utf-8?B?NTZlSVl2R0RxTTJHYm94Y2NWNEJXd01aWC9pckVnME1UK25XUm4vZmpCZnpE?=
 =?utf-8?B?QWVZYkJMYmVjVnplWUZ6bTlPcmpDNE9keFBXbm81TllhTVk3a2g1dTNVZFA0?=
 =?utf-8?B?d2p2QlgyZGgyY1lhR0NBNmZZYlRpZlhmMFVQeng1MVFsMlFLbzkycDI4N2Ro?=
 =?utf-8?B?TXl6WS9VWnZSSlBnWGdZOE5QeGh2TndsSTZoQmY4MzJocHVNWS83b3oyODJn?=
 =?utf-8?B?OFlrZlBlWUVaekptL2JmVDBNbkEzUFJPWThLcXBKQk5tUzFJb1FhNSt0eUJl?=
 =?utf-8?B?UWhubnB2Ynk1RkZ6TXRYeFJNOFdVSzF4eXBoN3FaSDJPR1g0V0dYSHB4RjRD?=
 =?utf-8?B?WTRXZWhWZVI3OE9JaC85Q3luWTM3U0JWMTdHY1cxV1p5MGZkbTRubFlZb2NC?=
 =?utf-8?B?RHB4SjB6KzJGa0lSWWQrUDRxVjJXMUp4dGdYc29LK0NLV0t0Z212bWZrVnBT?=
 =?utf-8?B?bjdtSzk0dEYrZDB3aTBvK051WTgxdG1DM2FPYVhyZTllTmpFZ05yYUUxM2p4?=
 =?utf-8?B?Z0pGdFFKbnhTemhvUVAvMnQzOFBDVnJoTW10ZWl1blBJM1BjYjY1V3JORzkz?=
 =?utf-8?B?MzZGYlYwSkRVM2pCTUFXSklxYm52UGNOOVVSaHVITUNKakRMdkNVaXdkbTNV?=
 =?utf-8?B?bW9lNHhhbzN6WVdqaVd2bEtWTjlUcjM4RjZZSytqSGpSaWY3cGI4RWFIQVN1?=
 =?utf-8?B?aTRnN1NITS9QT2ZyeDRsV1B6UmRzVDl0SmRDSnZUWko2ak81Y0FYRVpZRXdZ?=
 =?utf-8?B?QmlpVWlXcVljZDJsRElnVHdIZW4rWm8wNGRzL0VjZUJXNS9qWGZ5U01nVklQ?=
 =?utf-8?B?R002em00T2xoZXR2WGtzOEFyYzNJeDRpRGNyMCtFQkVIWmlWaTdsNmhKbkZC?=
 =?utf-8?B?TXVxdVRoRHhKOXVlNG9sREQyZDIyRzFFVUlENnR6YXRoTzh3S3ZHRkRZZTZU?=
 =?utf-8?B?S0tQRHBBV2FRRHBrekRmVjVKdG8rRTNWeTJGYWV4dWRqM2lvQ0NFQ2IwUFdn?=
 =?utf-8?B?VllpY0xuL1ZnNVd4YnE3VVFNS3pabzZQNVZZRmxpTm53WHFraEpZQkhUU3JH?=
 =?utf-8?B?emtWZytjOVA3UjBwVlY0dTh4WXdiaU5rc1dlNzRFTWFNK2NDKzRSTVVmOUQw?=
 =?utf-8?B?Vm5tbWhEY0xER3UrNlVneUhEeUR3eDZocVBqV2dFYnVLR1lQLytYbUF6UFZS?=
 =?utf-8?B?TTlQSjY4eEozZjB4ZEdmZGx3RUY5YktjRnJoNEtlRVZZcEVRUTZBVFNqYlhU?=
 =?utf-8?B?STk2alZTQ0FmaTRMZnZ0NlVqK1hWK0VBS0d4ckNCTFJwd09GczdnV0tWN05J?=
 =?utf-8?B?MlRmNGRRbmhCYTNyVC96QVBsZHBLVnZVSEJ0clJqSmNrWHA4VnR3VVdod0xm?=
 =?utf-8?B?S1BkVUZ3b2MvaGZHSVp1OVF4aExKRlRkTWlFUlUxOWE3MkVHa1JpUHlPdVR5?=
 =?utf-8?B?TDdtU1FkQUViK2tXdzdjUm9BR0J5U0d3ZmloUWhqQXJpVUlkUk5yQkFKSXQ4?=
 =?utf-8?B?VFZxdkl2bGgyQWtrK2VCNXBBaDJnekV4di9EdFRqV2xoRGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnpOWFhJVkZBczJ6ZVNHRGMrZFdIQTR4YW9OcElPNCt0SjFhMjlzVDZJVHMx?=
 =?utf-8?B?ODM0eWwyWFM0Q0xlYmVVMkZLbWhadVBHS3ljVFAzNkN0eUlEdXJtR2NlbkxU?=
 =?utf-8?B?bzM0NCtzK3hZZ0pZZytFVWdKNU54K1VJazhnZ0E5VE83bWxvcDJxd1M2bWJW?=
 =?utf-8?B?dlBnNTdiRTFHVFB5U1BzNHU1R0RWU1k5ZnpyQ2ViREwrOWpGR2tGckFIMUFt?=
 =?utf-8?B?SjA3MnZ2eGx5MmJ5cDlnVkt3cXNhaHpTZFNmMUtrLzRaRkhpNWdYQ29paDVO?=
 =?utf-8?B?dlZWa3hidGwzN29NZldtU0FtM0s3UnJmMUxWdjVIdnI2YUZOa3dOVS85c1h2?=
 =?utf-8?B?VGFWWUE5aVBwTnV3eWlBNFl3bmVkUmJwUUJxV29yNGpBYVJQT3dwK0FEbnp3?=
 =?utf-8?B?M1JBcjZIVGZMMmx5Z2doRGErZVN6eFRBMm01eUpyVnFGdHoySXp1SnJIRHps?=
 =?utf-8?B?aE1oMVIxTzdnOFA4bHljUXpSMU9xbFRqNjdOWnBPbWJNUkhxR0hmK0JLQTJh?=
 =?utf-8?B?K2EyZmptT3hNYUJnRk9ORDcxVzd5WUdZNEtBZWpPQmlaR0FOV2tzNjhuczBF?=
 =?utf-8?B?SzFGNTI4azJieFZUamtlMlFIMjNaMHVZY3MrdmwwZWxnZU9QeVFvWWllYkpj?=
 =?utf-8?B?TFNOL2h2QUI5UnRiN05sT3F3NkU4S09kYXJxcFREblhUbkMwa2FndExTU2hX?=
 =?utf-8?B?WUR4Y1VhM3BNWWkzb01VT1pTeng4d0RYbGlZOVdqNTJhRitqcUUybmhrK2Fk?=
 =?utf-8?B?M0o0M3ZXN0ZJTnN6WmNRbytWS01LQW03U0RJYXFlWG5OTzEvTUNYbW5ockVi?=
 =?utf-8?B?Qmd6N25pM1hYNVFwMElBODU4Ty9jSU5vNlYxa0xDK003cFJYTDROSmxXbXJY?=
 =?utf-8?B?R1NSZndsQzhFNnovM1lQb1dpMjEyZ1gwN25DcVdBc05kd0QrYVlleTJuU0xI?=
 =?utf-8?B?UVEzREVUT0x5R2p2UUo1TlI1VzUzVEtvWWxlWG1jT29nOHlnM1E3REtidmJL?=
 =?utf-8?B?WWF6RS9XSGN4bzVOeDM2MXc0blpvcXYwMjZGRG9SZ3F3cU94eEtXV3V1MmhM?=
 =?utf-8?B?NXJNL0FEc3FpcGU1SGNPRkllYkovVXBRSnJZdnU3dVhkTXEvU05iL2htbHNr?=
 =?utf-8?B?cGMvL2RsNkoySVFXSkNiNThMQzNkQ2pwS0dzNXhSWHZLZ3h2RVQ2cDFhS0sr?=
 =?utf-8?B?cnhrVDQvUXEwY0pXRjBYMmhzVlVldnd4SjBtV2NKbHdaMW5FNWRDMm9LZ0xM?=
 =?utf-8?B?ZVRqdU1EWWZnOTR6aTZSTEY0eTlqRHdSZERDMFYydk1uR09aWWY2R01BMUpR?=
 =?utf-8?B?S2lEVXhKbmpyc2F4cEhWVllSRjErKy9xZXJicUt2TXgwNHlGTUFIYWkwdkxp?=
 =?utf-8?B?ODFjY3FaMXZiNWZMRUVkRURQdU0rQVZ1bFVrYzlmSFNJSWhEOGtzdzFnOVpG?=
 =?utf-8?B?RjhLNEpQY1NsaTR6RkNpTnlEdFRFckhVWmR3ZEF1VkZoSEZrM3VMa1crSkw0?=
 =?utf-8?B?RENJK0gzR1dnNThXaXVMSXhDTmVzOXpVWlVTUHFka2NiZitVbFlkei9VOTV0?=
 =?utf-8?B?YTExbFRYays5U0ZzZ2VqRHluNmVHQVl1eFYrSy9PK3pKZGJQaUZmdnlDY3dI?=
 =?utf-8?B?Q0hxT1N5d1ZxdXBubEFlS2VZRnR1dlJYblBBNFBycUU0S1E0bkN4MGp5UE9x?=
 =?utf-8?B?T2dEaTBiSWJIRWoySU5MNmkwbGZicVdNNm90ckxXVjhJMzN5RDZwMVo2QXdO?=
 =?utf-8?B?SkEyNXdjcWd2eHBSQUhSaHBXSnNlNnhGVFBqancyTkd3UWlzbTUxZ2xFZTNB?=
 =?utf-8?B?bktkQjJwVktQeEdDSDkxcnlXNlRNd2JqNlRwK0xvT3d2UitoUVFjVG4wTjFV?=
 =?utf-8?B?aFUzeklEbnczcVFhaVZtQ0hZUmgzcXFQM3NZalRiWVVsdmM1RHlJcWtHVlJU?=
 =?utf-8?B?YlJ6YVpNYzF2OFB1WUJVNzcxekxCK0U3N1Job3RvNWNZbHgvZzFLZVlRYUNC?=
 =?utf-8?B?cjVOcXpzMkFuTHVMNFdMaERicEVSc1pXMGRSWnhpMVVlQmMwUldxajQyajdy?=
 =?utf-8?B?N3NySkpQOGczNE5JT1FtNGt2QzBINk1ZY0M5enFwYy8vbk52SjR0YXdnMXVY?=
 =?utf-8?Q?lpKvgYusBYNbN23Og06uMtqVf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535ea41e-e9b2-4f3e-7d21-08ddd0ed7b3a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 11:20:55.0938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4JoI7vsi2LaW4xqHbRsJadtMrjiebBSxxRVghsf0eVmdRlfy6CZfBqXx4dYDleM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4197



On 7/18/25 13:50, Michal Simek wrote:
> TF-A is using PSCI 1.0 version for quite a long time but it was never
> reflected in DT.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index b20a560741e5..5f26649c9e11 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -187,7 +187,7 @@ pmu {
>   	};
>   
>   	psci {
> -		compatible = "arm,psci-0.2";
> +		compatible = "arm,psci-1.0", "arm,psci-0.2";
>   		method = "smc";
>   	};
>   

Applied.
M


