Return-Path: <linux-kernel+bounces-727715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31A2B01E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B624545CE9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888332DCF61;
	Fri, 11 Jul 2025 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="eATXgkJa"
Received: from mx08-0063e101.pphosted.com (mx08-0063e101.pphosted.com [185.183.31.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6A23C0C;
	Fri, 11 Jul 2025 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752242554; cv=fail; b=P/8sd+umczDVa2f2J32w58CVM/Iwz5A4Wh1/v9Lt/IjdNewKUBN013d/gm3RIyTIJoXgkvxZIdPQi6B+sFiUbS/bv8hiKb9YHQSENmerk4vpRlnaPT9PW4jha2cP4LzNmfPlhIeJjYpe0jPD+gg3ZXUSyr3pAsaWIH+JeA3iBHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752242554; c=relaxed/simple;
	bh=CpBHe80cLTDhpU5bywZnS52MfpOu3Y34zBxQ/RhEkN0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cU89QLml7IjEPCrIJA+6s9M9+O72wVq1I9eEHwo6WUrLbTD15HeF8ggk02Jev7sCsuReO8S7j9QjkWKjF6YksGMLYZ7gtnw+i+eCtcXQ5lx0i2Lo0/FCwhJYl7wr9TnjUX9V5EoGEK5x5x+hEYK64+5NrzJlen3Pc3jf8+lG8Gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=eATXgkJa; arc=fail smtp.client-ip=185.183.31.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247494.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BDxXNE011168;
	Fri, 11 Jul 2025 15:02:28 +0100
Received: from ma0pr01cu012.outbound.protection.outlook.com (mail-southindiaazon11021116.outbound.protection.outlook.com [40.107.57.116])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 47psctjd12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 15:02:28 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8aQ3fNMdoCVAcJEoM90JLBEhStrOFak01vQ2mmNJx77MkJgSMMF9Ylh8gvSvN6B3aWZZU13wXA/WXjXS8erOv5KOx5TCz5AHVPpK6QzUCPAa2xv6REEw2av6CKWq2mNY8y8tnVx903B/QiNDwG5KZrIQcnuKytxMPC3IYOrPXBvk4zhnlnmCN+uhazALNFg3/QIYm2GPaAxxU1vheH1jptXGZskX8belIsN19P/sX1lykga2kkblplo0cpwpODEu+HTZvTIGzk9Dt4v1XAfkpJ9No6FpN0zTg2ms4cdUG8u+NBGcroR7FxdZOvYF/IqRM3+vsgtiEYs6t7iXa2FdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ER6RH8R6xKqc5oSfA3zblKTfY57EyZx19el65SP82Bs=;
 b=SlvStosqG0R6MTQHCzbzqQwsnR90RETI/Rkj8sOD6ISeBdJpIiPAgN5/y67Qy4dkfO6c39AW1pjPQNZi4HyLRywG836JwSmedT2V6IesHEkDnBVq/RC8HIgqLOqbepPoRbp/TfDPfsPDKJKoSJrwdf7GhBC1SMaZRaDwvUdYsK9HIf3K7r2sFBfQcIJ0NUIEeRgHvnymRw8c6Afh9HTrIjXCz7zrL6rS3KDS5IlcwtH1a7DA8/XghtmABZd6Swwwog0N1nweoqhKyLOAUGljbw5ZprZI2bvueuOirzv8TOa4kkuhOHOpRqZylQS1uahD2Xhrf2OxCzgxa7k46LyJJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ER6RH8R6xKqc5oSfA3zblKTfY57EyZx19el65SP82Bs=;
 b=eATXgkJaVOeJrmkVmTnrTPGD/Njx0Op2tKw82hl51fcvhJALOCJ2Vb+1HTE1brYneHeaubUPDGVdPIJQSJJTah90eBQyGdKAgZxj9eu+J0usETHk1fKk5lDFDPy7H7PlB8A3T8SwCySFZaCGEEqO3Y2ygFh0gPXjnis5yUcSWaM=
Received: from PNYPR01MB11172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ab::16) by MAYPR01MB10414.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:153::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 14:02:23 +0000
Received: from PNYPR01MB11172.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5cd1:bf89:3bb0:5f83]) by PNYPR01MB11172.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5cd1:bf89:3bb0:5f83%6]) with mapi id 15.20.8835.018; Fri, 11 Jul 2025
 14:02:23 +0000
Message-ID: <1c0b5db2-ebfa-4ab0-94df-4a2d70da0552@blaize.com>
Date: Fri, 11 Jul 2025 15:02:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64/dts/blaize: Enable Ethernet on CB2 board
To: Krzysztof Kozlowski <krzk@kernel.org>,
        James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        Neil Jones <neil.jones@blaize.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250711-kernel-upstreaming-add_network_support-v1-0-4a66a17c94b3@blaize.com>
 <20250711-kernel-upstreaming-add_network_support-v1-2-4a66a17c94b3@blaize.com>
 <7dffc2a4-c657-441b-86e5-b3869a72a800@kernel.org>
Content-Language: en-US
From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
In-Reply-To: <7dffc2a4-c657-441b-86e5-b3869a72a800@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0035.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::22) To PNYPR01MB11172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ab::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PNYPR01MB11172:EE_|MAYPR01MB10414:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df83396-3f0a-46e7-03b9-08ddc0838ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elZid1VXR2R5akMxM2VMeFZvSUM1MGFOWWdzT0RmL1YrNkE1azlyaFFvZGIx?=
 =?utf-8?B?c0U3Wnd0L1Q3RDh1UXlkcUlUY2dwREZYTE1tTXVYUGpxK1YxZm95MnBoVFlG?=
 =?utf-8?B?N3J4M0dKNTQ1Tk45cm5lRytrcm95bGdOL2tGRG9weEVZOVJuMWpzQTIwSGcy?=
 =?utf-8?B?djZXL20wMlV2UkUvU1FoeTljSmI1bms3QlhhQ1RXMzVJelpZUUtvRjFNZnNJ?=
 =?utf-8?B?TGE0dzIxZkhrU1dZSWRadXlhRHJ3OWtQTmcrQWRXUS92UzFNamY2VHppRFBV?=
 =?utf-8?B?OTJtRkN6WS9EMEpEckJaL2xVQUJKZGVuRHlINmxiZ2c1N253Q1gyUllnZEsy?=
 =?utf-8?B?bGwwbzBLNC80UTMxY3NycG5CU3FJUlpvVlgvWEZvVGtKQ3ROcWp5a3dackha?=
 =?utf-8?B?b1dwSFV0Q0lQV2pJT0s4VTQ4NXlqODJVZC9VL3VSd3hwQU5iMllPQTkwOGVB?=
 =?utf-8?B?alc0Y3NsdXp3MjU0cnB1RjEzWEdNaUNFMUFwZVRrQWp4Ujd5UW9HVVI0S094?=
 =?utf-8?B?N2Fvb0hBS3ZwMS80VmNFSi9NOXJzR0Z5ejJpTVBwYkJzb1JFSUorWVlrTFZO?=
 =?utf-8?B?RXAvcC9kdExVQW84Qkd4ZWlRZWpkNVFMU2tRNkU0U0NDUXFPd0o2YWovamNa?=
 =?utf-8?B?R3RRQ2Vqd1hhUXJuN1dNdnM4MUM1d1RjZXNLNGk4SjBUNTd5VmZZTnNOaXdF?=
 =?utf-8?B?UEZiV09xOHlhYUlSWGd3R2ZURXg2SUo2RWkxQ1MvemV5eEhvbU02cjFmOVNX?=
 =?utf-8?B?V09EREo5aFgrWWJQQkROWUVjQXV2VjY3bWNGODFVR3Q0RmFKR3RNZ014V25m?=
 =?utf-8?B?S3k1cFRJT25ITVFZcUtCYlJtTTlORG10TndqcXBKQUhRSlpOdmV3ZHl6RWpw?=
 =?utf-8?B?VFk2Nmp0bERNcHRhbFFGZXM2cHZhaDRkcUs3R1Z1TE1GdUlHUUlZWFd0bWU3?=
 =?utf-8?B?N3hONlh3blhoaEQvTWlMMXI1RnhNajZqeDJMc2N6RnU0dFZQUDdQTmZGb2FZ?=
 =?utf-8?B?N0MwLzFsbmFOS20xaGVZVzJCTjV1Unhub3FaWTBqclFiT1piTExLSGs2VU1j?=
 =?utf-8?B?RjZDRzdXY2xPaGcva0lhZzR5cXBqZWwzT3dUdVAvKzFtd3RLZHBCUmoxbmRy?=
 =?utf-8?B?MjZBNVdXSnM2eWRXckcrZytwbVJINU9QemgxUHVCU0RIKzIxM0RUQ3BhY3Nq?=
 =?utf-8?B?aFU5U1dQc3kwRGhBUVJtR2RtYkpJbUY2djRRTDNkSElnTnp6K0pjWVpKNnJ6?=
 =?utf-8?B?WDBZZnhmSm1FR2YreXdpYkRVVkVVZXFjZDh1S0IyRzNnd2FFeUxvQ2RqMTBQ?=
 =?utf-8?B?b1VsK2ErZ3lrLy84VHdDZi8xaFdwT1Y0MStWTlhBSWtsd2xVZ0lweHRSbkl0?=
 =?utf-8?B?aHc0NWUvS2ZxWnVjaEgwVkJ1dGh3bXU3K2NlemJnaVZ6TFlHWll1UjU4NHVK?=
 =?utf-8?B?OFRmdEZUSjRHUW5GVjVpR0NjVm11MjlVd0VRWGp0QTd5M3pVVHp4OVNyVDVl?=
 =?utf-8?B?UXZJc2ViZ2NJTktBQUlHRU13SU9ZV2tpRmFnS0ZyTW1VVjhWWkJ3Y0V0cDZ0?=
 =?utf-8?B?U3A5a0tGQ1VOcU83Yjlsc2NBL095d0x2SS9ubWE0OGdsS083WjNKbEFXMGRj?=
 =?utf-8?B?bnpPWFZ2cHhIRXFuV2N3a2ZyZmNoNXVLckhXbVI2VlFVVzg3UzFpZ1l4ZFpq?=
 =?utf-8?B?Um14Z1dxekZLenhNZEZBdEhreDhkOVFPQnA3eExlT1BvaXppSkdJcFF2d09S?=
 =?utf-8?B?amc2QUVJRmxZTUJrNUw0MSs0cWVNSjJLOVFnVnVheFQwZFY4UnVweHRGMith?=
 =?utf-8?B?SmFhWCtVTjBjNTVzdVdwd1UwWjZueXQ4T2MzUXJqd0lBcUFYQzZIcVI1VzRD?=
 =?utf-8?B?MmxwVVRORHBzWlVaOXBQekhHR2lQWUFtSGVtK1c1azJsZlUrY3pOV0hNaWJr?=
 =?utf-8?Q?ycOvH2QzTNQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PNYPR01MB11172.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDFTaEhWNWkrdVpvY0ZsZm1LUmpqdFhwN2NmNXdXQy9mZUk0bXdwSHlZVUo4?=
 =?utf-8?B?U1FpVXpnc2VzUkVBZzJQTnd0WjZiMUZ4bGhWcGErTTFOZzJOaERVZW5Id0o4?=
 =?utf-8?B?Sm9pRnRqaE9xd3VaM2dkNjVhN3RRNisrMU9WdlJmQjQwNFhXTFZGRzNOdkpt?=
 =?utf-8?B?QUVqOElzeitGUjRWektxNXFmRDZBYkVsYjlpY05vaXBUSWxFcWtQYVZLVmFF?=
 =?utf-8?B?VXZpNGlnR3UzaFR1QjZ0Nmt5TWp3ZWVFNWtRc0ZQSCtycjdid0JNWFo0QUN1?=
 =?utf-8?B?ZmpKeHpnQnVnRHVhRGR4RmhGOHB2NVN5YVA1Wk9OKzBESnlRcm9FQnZZc1Nn?=
 =?utf-8?B?OERMUHhBVytRN1pGMEdSRUZWOHlIZkhVeGFWT2xaS2hjd0NTMUN3a29DMmFQ?=
 =?utf-8?B?TlpnRGFGVE05dUczTmZnSXhSMkI3OVd2ZFhFUHl6L3lHOEJJcjFDa01yR2ps?=
 =?utf-8?B?VXJiS1ltRXJNSU9nN1FsVUp3WElRczk3Q1VKcVhJOEhac3RNZHgxcUEvckpY?=
 =?utf-8?B?d1RiZnY0VjFPZ1QzSVRaZGg2cmdON2tHM1FaT3lLaVIrUkU2bTlFaldCK1M5?=
 =?utf-8?B?TFBrdnZBS0NLRDBMKzhHUjVEd2Z3aDlpdVhHNVFzYnVudmJGV2d2SlhhVnRW?=
 =?utf-8?B?ZERaNEs3eU1WbjRzaVJ2bzZDZXdMaENSellnTmZiTXFiMjNDNUFOTFh1V0hr?=
 =?utf-8?B?ekR5dUZhNDZzU0RGcEUzQ05CVjd2NFROcnp3TWxaWmVzeVVoVEVmS0FlWUJp?=
 =?utf-8?B?WkRPM3RhSjNQQS9UeWx1My94dWJrcUpPcVo2T1l4MERFbjdvMm50TlJPWWlh?=
 =?utf-8?B?RDNCQktvVFU3Uk1EZWZ6SHc5enlCT1hJOEt0Q0dWQTU1MnUwL05iQUkwRGhh?=
 =?utf-8?B?ckVEUkFLZTJTRzYwcVljbE45UC8vMzJuYnQxQW0wSk44WEhJNkE2di9uajdh?=
 =?utf-8?B?UkZYaEVWb1pPajZMS0V6ZUFGSm8yam1wcTNTQm1NbSsrYkhHRUVxYURraWMr?=
 =?utf-8?B?M2Ryd0NqT3h5b0RrT2Z6QXNTRy9tTlB2VVpWMkpIYVdiYUwzWjJlbFZEUlph?=
 =?utf-8?B?T1RvU1orWi9PNE9vT1NBclpIUUhHbFNYcmdXS1AyMnJSTzQ5Y0RHdTNmYWlI?=
 =?utf-8?B?aSt1ZkdSbHlaMmJxSzF4TVNpOUVTd1djUkd5b2dpRyswNkV3alFBUWdPNTVi?=
 =?utf-8?B?Vm02Um52eFBYeXlEenRKaXdkK3NKeUtZeEo0c3RiWEtNdDVmQmI0a2VKSy9o?=
 =?utf-8?B?V1hSdkVZTkxLeGVUa1pUNHJpdkhtQU9lZjRodDRMTkpuODlXdzJWN1dYNEY0?=
 =?utf-8?B?Q0wwaDhnZEwyOFVFNDRaY28rc0RDL3VmelpVSU1ZekVzSy8weXBlUUtCU3RG?=
 =?utf-8?B?YUxUTmFFWE5DZWRxS29obWVqR2p1VHhZU0J1eUIrdzFHbFBhSVhuTkRKWE9w?=
 =?utf-8?B?cmJxTFZYWTBicENSVXBZTE51amkwUldkeXJLK3ZWci9UcDNGTEw0UEltcGFw?=
 =?utf-8?B?UTRVZWVpYnpXVkEwSU5DOWczVjRWeHlwYUR2R0lvL0ovZVhnT0NlaFZoU2ZI?=
 =?utf-8?B?MHhDYjBnSytyWjN0WFppeUFFczBRNHhRUHhtQ21nZzdWbkFMaGM5NE5xU24r?=
 =?utf-8?B?YzBuS2pTSmYvVnFXVituYVpZcjdzS0g1SXc5K0dlTUhReGN1V044VytoUXZT?=
 =?utf-8?B?RjNyaytUSThFMlR4clcvOWVJeVRUaUc5aXE2dzV4TC9JaW1qaHB2Tlc5aTlT?=
 =?utf-8?B?WDZmNTJiL2xpWmFpdndCZzNvUE52TnZxR29BVllqaVdCTG1BMnRiQUFEM053?=
 =?utf-8?B?c2NXYzBiQmxpOG5iSnE5MnNJQjFXdW4wRHZJVXlzZ0pyYXFJSlNIUG1uSkwx?=
 =?utf-8?B?cENpOFV1OXpLWWpIQWx0SkwycGtSV1ROS25mUjg2ZG9uK0NkZnR2cXJ1YWhV?=
 =?utf-8?B?NTRibEJmWUo5T0t4SjdLTTdPVUxMdFhiRWhsQnlqc291S1NLcW5QVG9QUUd4?=
 =?utf-8?B?cDZybHA2MGplSlhKZ3BMMHNxTWdranQ2WWNtK2lwemlYSGJZR2h3RENncXpj?=
 =?utf-8?B?V2YrcWtpWUo1UGNic3VqekxvNmVERkRlbjM1SXYvWkhsS2JJdFE3MFo1TVRQ?=
 =?utf-8?B?eUN0Y3c0bDBLOUIvaER1SFRoTlNZTTlnQkdxTUpSYkVpajRaME84VVNJeUdV?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df83396-3f0a-46e7-03b9-08ddc0838ef6
X-MS-Exchange-CrossTenant-AuthSource: PNYPR01MB11172.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 14:02:23.0774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OePtHmfu1G5uSRAQ2trdpnqoq68n0nHkFWx9cuYrS5DcgL0HBtCI6mTLSXt9PDyENtcvGXqei2hiuPZkXeKWBV/AsKQ2IyUEbfCmVan+jYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAYPR01MB10414
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDIwMSBTYWx0ZWRfX3A6+aH4cr35O mwkbiqBAa+Tx00EQoaRnbWv47i/iRtXDRtBebBw5JYN+XI0V7dkoKdlMhsWjOEAtFvWV4shdjvC AB5Tgj9YHwPAHPc9JaIkGaH0rSamMMM1UxktJqC7QLS8/WN+jHpxjKzf+l662Q7F2FqTuHZmdIR
 a7ZjtUUYH91SR0HGAD89G1Z7GnqMaLxcaEd44NFPRkoYy6IslL7TKDb/ouxJD0yOY5BkbB3XtI3 EErdeca2FcNiR8faGMHxPHX6sqnxqXncrZfrM6iFiqjRChry089lCF/SeOgWSIBGwBeQqtT8hEE 0/HorahzJFZ0r1NSm77JMsfuMreG8j1EjJJ+lzY+SyTGEHrRHczA4DPuI+RaGua0/oiJTT7QREJ B3HwylNJ
X-Proofpoint-ORIG-GUID: FlhQ5UtWTm1RdrXN3-u8wNqAd6E6m9HC
X-Proofpoint-GUID: FlhQ5UtWTm1RdrXN3-u8wNqAd6E6m9HC
X-Authority-Analysis: v=2.4 cv=MMVgmNZl c=1 sm=1 tr=0 ts=68711974 cx=c_pps a=Va5D6ErfYIqZernUEk7zVg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=-5LYVjoNHPMA:10 a=SrsycIMJAAAA:8 a=YsUoFwrBjw7bHZ9OMMQA:9 a=QEXdDO2ut3YA:10 a=zapPnUM7SFj2ezx6rUw-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: orgsafe

On 11/07/2025 14:51, Krzysztof Kozlowski wrote:
> On 11/07/2025 15:36, Nikolaos Pasaloukos wrote:
>> Use the Synopsys gigabit Ethernet controller on the Blaize BLZP1600
>> SoC to provide Ethernet connectivity using the TI DP83867 PHY which is
>> available on the CB2 board via an RJ45 connector.
>>
>> Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
>> ---
>>   arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts b/arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts
>> index fb5415eb347a028fc65090027a4c4fc89c8280f5..cbe8f0930ad3741b0e770dd7d494931e3b939815 100644
>> --- a/arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts
>> +++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts
>> @@ -6,6 +6,7 @@
>>   /dts-v1/;
>>   
>>   #include "blaize-blzp1600-som.dtsi"
>> +#include <dt-bindings/net/ti-dp83867.h>
>>   
>>   / {
>>   	model = "Blaize BLZP1600 SoM1600P CB2 Development Board";
>> @@ -14,6 +15,7 @@ / {
>>   
>>   	aliases {
>>   		serial0 = &uart0;
>> +		ethernet = &gmac;
>>   	};
>>   
>>   	chosen {
>> @@ -117,3 +119,23 @@ &gpio0 {
>>   			  "BOARD_ID_1",		/* GPIO_30 */
>>   			  "BOARD_ID_2";		/* GPIO_31 */
>>   };
>> +
>> +&gmac {
> Are you sure you follow DTS coding style? Which sorting rule is used by
> Blaize?

Hi Krzysztof,

First of all, thank you for your fast review. Apologies that I missed
that I missed that one, it was meant to be alphabetical, so above the
gpio0 section. Thanks for catching that.

>
>> +	status = "okay";
>> +	snps,reset-delays-us = <0 10000 50000>;
>> +	snps,reset-gpio = <&gpio0 12 GPIO_ACTIVE_LOW>;
> Do not use deprecated properties. This is new code, not legacy.
>
>
> Best regards,
> Krzysztof

Thanks, I'll remove those.

Best regards,
Niko


