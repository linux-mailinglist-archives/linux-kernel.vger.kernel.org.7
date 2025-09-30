Return-Path: <linux-kernel+bounces-837295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89337BABE31
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451B8189EA35
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942C933F6;
	Tue, 30 Sep 2025 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="V4063zGW";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="V4063zGW"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011066.outbound.protection.outlook.com [52.101.70.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B608622B5AC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.66
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218369; cv=fail; b=NIzixWufSzZc4IAFqTVM5Kirvbcth8UTDWWsotNPzrAtA2Dxy1KRzdvK8Z0s0q3SWURyLWglc7ME8ssxlGWnxXd5scRKM/3/w19rcX5dhtrdKlJukwF3rS3R0fU3G+dhh1CsvhCK5jQx0tsdSVet7yj2KbZSTSMd5vknxsWAkWU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218369; c=relaxed/simple;
	bh=KEDgruHp+L/g/pnHckAny+jdYW6eDhOiZa7bAUaxUGo=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=PQMHLPcklvULfozmqQ+8ELspJqvAWDdLi+Oom+DzuQRipw6SC4MGaMvKK/XsxeXBSSag6QPBjO3hxvgpb9OdPeWqvnNFtPjST2JCfkId9ulp4GK7XTvCu62OvrPcXgWXEVQQpx6N8mpSN2GLXabJhSjwJP3Se7qQ9ye5R3rEVTs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=V4063zGW; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=V4063zGW; arc=fail smtp.client-ip=52.101.70.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=fYsGZPSmbsGMkDTd3nOCNVImrlMKaE4xvG7UhT2iCzycjrt0eSYPUWSMLZZZ+ZoQwkFpZxylPzPaRdvRIPseVQQtdEpVYut5C7kWkx0nke5kpSt78S+s4QbF05UU3h2d7khuw1hX7kAAuIknYzJgVGyRuhcIC0hQD8R59/hIazRbqUpeX7w52w22iYkAsIg9hEmwgL0EobVs92Hksgx25kN2h0FcI4NjyOY4ulCY19ryZRGlIVNpkvBi7Bs5RTLBIdvvffz2do0x6tQ+hGHf91jRzoLU5bltm70SqTTizbMCCm0epTvESWSKjEb9TrcNV+mvH/tMdaaZZutJkYbD7g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkXVBwtKPyLz1sDnP+3d+i0HoNKJD/oOZ+EIZprwYQU=;
 b=XmLWfztqH5Rtuo++TVzNby9EJneYggh35Vnv836WSAdawMXS6IpclViUTCKdF9sLxSQUYVICp9Sw57f77b2wGR2ccms6sJWnw/EycthGl/oisaHfYe3qlPvWJ9Gb4ydDHKBZnxvja5fJnJL2nINPgk6eR6B5OcxmLE8LXRwHF5t627w2lWhTm4zPNmrU8JlYycP2xuXsjBNhx9HvYunEQl5/qmIPyH7uzoZ85QnrmfecrReloRG9ubkK37PfaJkMBWHW3WJ0Q/DNyRmTNgYcL0S2DTltCgweKqzkCKEhv5SkbnfGXhiqDwf1ZsDoyYhwjHgrCKivcywN+KmQSx8i0Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkXVBwtKPyLz1sDnP+3d+i0HoNKJD/oOZ+EIZprwYQU=;
 b=V4063zGWwukbhO/A7yxWJldf/n5/CZWU46i2TtJOYCoGmN/LV09grvXVu+pNf2HGxVl17z+6JLLav1MSWJDJ0/Yc62heZVvrH4ZzXBuH06dklqoxMyxCLWfbq8SOdF9jSvQx7QrVxi+wNQet9AeOBAJtYI62cE11kb+JMuEhbAc=
Received: from AM0PR02CA0198.eurprd02.prod.outlook.com (2603:10a6:20b:28e::35)
 by DBAPR08MB5798.eurprd08.prod.outlook.com (2603:10a6:10:1a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 07:46:01 +0000
Received: from AM4PEPF00025F97.EURPRD83.prod.outlook.com
 (2603:10a6:20b:28e:cafe::f1) by AM0PR02CA0198.outlook.office365.com
 (2603:10a6:20b:28e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.15 via Frontend Transport; Tue,
 30 Sep 2025 07:46:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00025F97.mail.protection.outlook.com (10.167.16.6) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.1 via
 Frontend Transport; Tue, 30 Sep 2025 07:46:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/dX0TYXGtal+flQee0T6AuBg3/+NbNNvAUCrlv/bPoNwVAyW/7VeK8naW427kU4xfjB1QslALONY6WktQVmEDsqn7Nhu271y//xUAATbKbD6TlJGmfAWm0335vDdsIc5vUnLv6B48KM0DoqZ3ZKzUTKla3BNMeEkx0Gl2I9y6WYgZ5Odz1cuWMcBVnAz2m/6Ce4bbUZoXUyYFy+vEsUn1tT2vn4V+LleTXyQgQGbAemN8VGGmkxh6RKt7IooRqd/WsH1TNA0vb5qKLC76sXssZNsBBR1j6azJCbuB8LXalkJdrRiUaRqFx8x3w9vqHqiX8rrc33oPX4JSNWLz16bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkXVBwtKPyLz1sDnP+3d+i0HoNKJD/oOZ+EIZprwYQU=;
 b=s+TD6gUgHLGSEcael7MIBuwRQCBaq50Yt7jvqgCgkGYytAGPL/k+irasVyRsEegR535wT3ITxJ2BsAPlD0LPOnICzYoefd7pylHcaNaAeE8yWXxWlnpWWhV5KWLf+ooMc++4wX/WrzErFmpFf3VMOulog5d9Mn39+6BE71VghMsaCsO3kEHQH/4BS3MoUIq7NeK9TM5LvhOpyLRru0h1XfEqStx4Z1VGwi2CgsGTwB9qDS4siOj5/33PriPGIRtTurGYEobolgudVvQk4fXHe66CeCQ4S3I/AkBXemTsupYQrj6BVoW00b8GxMhU1H/iaZY8rYb3GV/2M3QXaQe5dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkXVBwtKPyLz1sDnP+3d+i0HoNKJD/oOZ+EIZprwYQU=;
 b=V4063zGWwukbhO/A7yxWJldf/n5/CZWU46i2TtJOYCoGmN/LV09grvXVu+pNf2HGxVl17z+6JLLav1MSWJDJ0/Yc62heZVvrH4ZzXBuH06dklqoxMyxCLWfbq8SOdF9jSvQx7QrVxi+wNQet9AeOBAJtYI62cE11kb+JMuEhbAc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by PAWPR08MB9685.eurprd08.prod.outlook.com (2603:10a6:102:2e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 07:45:23 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::4ce3:fe44:41cb:c70]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::4ce3:fe44:41cb:c70%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 07:45:21 +0000
Message-ID: <1081f8ca-3c1b-46fe-a7d4-31303e5e2298@arm.com>
Date: Tue, 30 Sep 2025 09:45:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][RFC] sched: Introduce removed.load_sum for precise load
 propagation
To: hupu <hupu.gm@gmail.com>, vincent.guittot@linaro.org
References: <20250910084316.356169-1-hupu.gm@gmail.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
Cc: peterz@infradead.org, juri.lelli@redhat.com, mingo@redhat.com,
 rostedt@goodmis.org, dietmar.eggemann@arm.com, vschneid@redhat.com,
 bsegall@google.com, linux-kernel@vger.kernel.org, mgorman@suse.de
In-Reply-To: <20250910084316.356169-1-hupu.gm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0033.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::11) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|PAWPR08MB9685:EE_|AM4PEPF00025F97:EE_|DBAPR08MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7fd1db-c7ce-4897-1cb7-08ddfff5668c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?VUNlTDY0czcvZVdYMDF2OWI1enBoWFRKSVBEdHNYSXdxVWFzVGVMSnEvYzZ1?=
 =?utf-8?B?YkQrYzlQNlpFdjFRdFlqTHBpamlUSUdPT3A5TnhaUHFocjlpeXp0K1RERi8v?=
 =?utf-8?B?V3RVRXlmMTZrSFF2KzNEOVg0cVQ2TkkwbGo2cElmZXhqY054NU9qVE9MVVVk?=
 =?utf-8?B?YXZ5WW0weUFUcFZ6WExoU0I5Q0hhQjBsbkxzRGpxSXNZZG9FRzNicVRTd2Fq?=
 =?utf-8?B?Zk5UellobEMwaVhtbXo3MjkzNXYzTTJkT3R0T3JuOWNaeGlsVUEwaHNZMXdG?=
 =?utf-8?B?eDNEakU2a3c4YlFubzdZdFQ2MkZWajBSeENIZ21DS1pxcldITTgzQnNVd1BB?=
 =?utf-8?B?Y0F6TmdDenNzWDI0enJFczIvY2NzblRLK1ErWS9KNVZuNXk3RDB6Z2xPTlg1?=
 =?utf-8?B?eFl1V3J1ZndUeThsa25yVTRWR2lPSnFlSzZEallzYTdQN29TQkpIQUwzd2ZD?=
 =?utf-8?B?RWphQVRRM29VTFJRQlU5Y3FtcjlyYXRCRFJpOVczdjZSREdXZUVwVm42ZjZi?=
 =?utf-8?B?MThrMysrOENodXk1WDdtRTEyeUVLZDVmYWVCTTl1NVR5ZytqRWhsbnVqRXpB?=
 =?utf-8?B?SVZIWGRmM01GT01vcFRJdFY4alIwWElITDkwQ0tidkVoRDFzTjBzMDQrQzlY?=
 =?utf-8?B?N2RxUHFPSC9KZm5GTGJRRG9OK01GQkQvcFNrbFJNWjJKMjNPckxpYXkwc0or?=
 =?utf-8?B?UUdkYXBlbWFjbElTM040dGlLVnFIY3VOTkN5c01GaEE3TlBKdFRxVFdqbmwy?=
 =?utf-8?B?NzN2bktLeFlNR1VtQndVTmtVTXc4ZkJ3ZXI3cllSZGkrY3k0M1B0bW5YN3pV?=
 =?utf-8?B?dmk1SkV5Y0ZnVTNZcklKMlFwRXpwNHUvbEVyZlRGY3p2dVdkd2tWaE9FMG9F?=
 =?utf-8?B?NytkVlVMUHhxYllSeWoxQ1VVTEI3WlM1eEFaK21NOXgxNEdyUHpIcExoMkV5?=
 =?utf-8?B?UlNNMmxEaWwxNkZ6U05oUVlXY3d5VUR4a3J5bnlhLy96Zms2bmhFVlhRZS9L?=
 =?utf-8?B?emJ1NjZPSW5jcFRSRXB3SWVJYmFEdDU2dWk0TVAxdEF2dXBjZ1NmMFFNdkx4?=
 =?utf-8?B?ekEydFN4cjYraUJMSTBxQ0pWRnkxcU51SXJrTXFod2g5YW5jRTN4d1JpYWhP?=
 =?utf-8?B?dXhWMGtzOXE4TlhFSU95R3dmSmNycWR4TDhoeWhVWG1hZkNsWTVyYmtlRGhE?=
 =?utf-8?B?UUhFMEZlR1ppVllvcHg5bUxOajJrd1JlQkc0VFYrVzU5V24ybTVOSFdjbjVE?=
 =?utf-8?B?SXMxWUtENTRRZUZKZWtNSVAvWkkzUlVpNEthdlpLZGJMODBlUHkyQ3lBdDE3?=
 =?utf-8?B?YTN4UXVmckt5WHhGdEJlMitrVGo4TGlBczFRTG1aMUsyWGQzT0xpWitCbStK?=
 =?utf-8?B?MXJSbDBNTXQrMklRcFE2QWVsTzZTTU1CN25maEpudjdoQmQ0VkZDOWFrcTVC?=
 =?utf-8?B?WDkybTVPaE5qSllhWitkT3lMeXVxeDdCcXY3dWhYQkVydm9KSlM2eWpVZmhO?=
 =?utf-8?B?TDhRaGJ0QVpSbTFPbzA3Mmsrc05jbUh6QTZpdllGV2lBR2VmN3UwbnRuZklK?=
 =?utf-8?B?Z1BvbDJtRTRUbTFLQmxUVHhXcGhwSEVsMkJnNGZ5SUVUN2xQQ1Ywa0k4WkFF?=
 =?utf-8?B?bnQrT1I4NVljaVNiZzdaLy9MZm00TVVhNDZBMDB2aDNyTVd2MjZNREdhUlRk?=
 =?utf-8?B?VEQyTnhWWkIrMlMzKzdOM0N4OVdEdHptOHQ3ZmgwaWdUcGJRa3B6QXNiY1Ba?=
 =?utf-8?B?aUNOL1c2a0pWZDhCd2NzYkJZL0plNTA1QUNhNzdMNjBqTHhQSkk3ZEc0eXdw?=
 =?utf-8?B?U1ZpOG8za01TTGJ5QXgzeWU0VVdrUjB0UHVldUdqL2h3Z3FmbHM5cnlRa2hr?=
 =?utf-8?B?eHNDZHI1UUd3TUpHR3lXSnFteW1zVVhrS095MXZnNlF4d2ZlN3pMOEVpdTcx?=
 =?utf-8?Q?AdzgWPJ5e0A=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9685
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F97.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	23e9bb6a-dd5e-4042-7542-08ddfff54ee1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|7416014|376014|35042699022|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHFRcVIxN1M3TG1ZMmZHUW1KdkJjN09Ub2VQRlkxRWIrcGtGdS9LdVRhWmpC?=
 =?utf-8?B?QjYyOEJUcTVib0NBclVRdVFSalRXSWwzejhOTDdlbVdYaHVxWDVhNSttWnk5?=
 =?utf-8?B?VlRKKy9GVG1NMDNpaXBjenZTSU50VDdmdkoyL29vL0pZSlhFcTlacjhkZzVE?=
 =?utf-8?B?RnlKSWNjNVNxTjgvdzJKVnhVVGd0MHJ6UDNjSGtNR2p5RVB2eGFnWDJtSzRJ?=
 =?utf-8?B?aU45ZUNaSk00S1dkeFVvRmpQRWhDcDU0Q2ZzRWpoOTczRWxpNmYrcW4yMGNV?=
 =?utf-8?B?RnBoa0ZocGNlbitYSy9iVlVJeUZIQTZYTytQRHEzN1diWFJiVmxHWHFBTXJu?=
 =?utf-8?B?T2N5KzBHWG1IcEg5K3BDTkJJa0QwcjlvdW1qUk1LZXkzVlBBNjhsS3BkaExV?=
 =?utf-8?B?ZHRZV0UrbWc0OXV3SHUvcFdpZXhGTENmeVJ1NHk2R3l5STFHTmZOTDZESkxj?=
 =?utf-8?B?bGVjczd0OHhHNlVCZEJEWDRHMWp4RWtYampyL1krNkZ3MnQzOUpKY2tEdHJw?=
 =?utf-8?B?WDNXeEdZbTdkd01LaDg5aGpUWnM3Z05NMUpzTG14TU12VXBManQ2TUFBRG5V?=
 =?utf-8?B?djBlZjVBZVBzdVhmVWd0ejRkOGJIRWpDaUZRS00yQjJSL3lDNDByYWwzTkxi?=
 =?utf-8?B?N2ZraTdKVWxBdFlCWVBXbkptL1ZqY1ZBajQza3JEMERvblhuRExNQnNRSmgy?=
 =?utf-8?B?TUV4dkZodVdYcjVmcE9hZDJ0UVlJWFQvTVExajVRWGNuN1J0bWh0UkxNWHhC?=
 =?utf-8?B?cWxPZWlidERwQzlVaUljQXdBck1ubDhxK2plRzV6MW5KL3ltNjlVV2NVem1k?=
 =?utf-8?B?eEJQMm1uK1BkL1NSTUZJTVVFNGJ0MUQxNlBSVmNBTStWVEFXMXZDWG0vU3d3?=
 =?utf-8?B?aVF0cFUydVVOanFGckpLN3pyZXV4WndYak4zL0lKSEhPbEtUNFNKMy82MnN1?=
 =?utf-8?B?MnlCaWdwOWt0Y1BiRm5KdVFVR2xrWTMrSTZ2eWhSbWt0OFQrNmdNUkJhTWVE?=
 =?utf-8?B?ZmFsaFlXVW5qbldRWGFuNDU5bWlCQ1k4L3JtTFFYaityWUtURmwyd2djSVZC?=
 =?utf-8?B?YTZ3TEJYalluMU9ua2FtVEF4NXdVTnBDS0ljTEdCeXlIeUU1dTlDV0JjZC9a?=
 =?utf-8?B?OU53ZjEzL0hRM25sVHE3andWeFRwTWNycDNRdS93QzBrSXZ3a01xdW9vblRp?=
 =?utf-8?B?UVlqVVY2VlgvV2hvOHBVSFd2QkxuYithNHF2c1FrSHphTWIvc0pGeHV3SUJv?=
 =?utf-8?B?Zm5oay9XODBxTUNDc0ZKcTI0cExmM1lBMjJ5ZUgxblZjMU5LTTFBWUI2czRj?=
 =?utf-8?B?ck1uc1JNM2g4MzNzU1lpVUNBeFV6eHhMaVQwanhzcHZMM05Ib2VqcnF0RElL?=
 =?utf-8?B?UjRwYlV2U1BJQjM3L0RnRkc2SjEwTlFwaUVZQmN1TFpZbXVoWStuUnZ4QTZm?=
 =?utf-8?B?SndTQ0JpcFR0SkxYZGhYSWNRVFpBajJQazEwbkpiR0doemk1aStZZ282YmY5?=
 =?utf-8?B?U0wwNlF2L25uUEwrdVVJTHZHZnVEMXJJM0l4T0VuRVZmOFFFSjY4REg5ZTFR?=
 =?utf-8?B?VzR0YjdpNFJnQ05HRDJ2NS9xYWxxL0dhZndEc2NhcUVpMHgxZjAxZGpjYzNU?=
 =?utf-8?B?NjFIZHZFa2lxT0taeCsrS25FTXRmYnRSei9KVFhwN2lPaDJ2OEZKdzFSUzFM?=
 =?utf-8?B?RG5ZcUo4ZUFXcCtVZytmSThIOFgxdWhqQzhkTVU2NEJjOVBBTmE2SU9RNlh6?=
 =?utf-8?B?bXphTkZhMThLN05SMWZ2MEpqWGMxZ0tWYWp1UWZuUHBIdG14dS9uNWM2cHVC?=
 =?utf-8?B?MGNWUVNMYnJ3bUxCMkQwTVJqczR6WTBNRDJzQ1hsb0RieVBLc0tLRHJSRVhq?=
 =?utf-8?B?T3NyUkx0REVoVGtva3FXanpDS2hXQXNSOGFRMGZGU0lnVzVZSHltSnVJVjBD?=
 =?utf-8?B?azliS2lKOUwxM3Zac3dMc0U3YXVHR2xDd1VROUxnQktwNjljZ0NZL2RhVmVs?=
 =?utf-8?B?UDgwdXh6SUJZd3NwWUM5ZE9uZDBKNWhVWWE0SURHZXdCMnJnaDU0ZGNtbENF?=
 =?utf-8?Q?E+Neqh?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(7416014)(376014)(35042699022)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 07:46:00.7960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7fd1db-c7ce-4897-1cb7-08ddfff5668c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F97.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5798

Hello Hupu,

On 9/10/25 10:43, hupu wrote:
> Currently, load_sum to be propagated is estimated from
> (removed_runnable * divider) >> SCHED_CAPACITY_SHIFT, which relies on
> runnable_avg as an approximation. This approach can introduce precision
> loss due to the shift operation, and the error may become more visible
> when small tasks frequently enter and leave the queue.
>
> This patch introduces removed.load_sum to directly accumulate
> se->avg.load_sum when tasks dequeue, and uses it during load
> propagation. By doing so:
>
>    a) Avoid relying on runnable_avg-based approximation and obtain
>       higher precision in load_sum propagation;
(runnable_sum == load_sum) is not exactly accurate anymore since:
static inline long se_runnable(struct sched_entity *se)
{
     if (se->sched_delayed)
         return false;

     return !!se->on_rq;
}

So obtaining load_[sum|avg] from the runnable_avg signal seems compromised.

It is possible to compute load_sum value without the runnable_signal, cf.
40f5aa4c5eae ("sched/pelt: Fix attach_entity_load_avg() corner case")
https://lore.kernel.org/all/20220414090229.342-1-kuyo.chang@mediatek.com/T/#u

I.e.:
+       se->avg.load_sum = se->avg.load_avg * divider;
+       if (se_weight(se) < se->avg.load_sum)
+               se->avg.load_sum = div_u64(se->avg.load_sum, se_weight(se));
+       else
+               se->avg.load_sum = 1;

As a side note, as a counterpart of the above patch, the lower the niceness,
the lower the weight (in sched_prio_to_weight[]) and the lower the task
load signal.
This means that the unweighted load_sum value looses granularity.
E.g.:
A task with weight=15 can have load_avg values in [0:15]. So all the values
for load_sum in the range [X * (47742/15) : (X + 1) * (47742/15)]
are floored to load_avg=X, but load_sum is not reset when computing 
load_avg.
attach_entity_load_avg() however resets load_sum to X * (47742/15).

>    b) Eliminate precision loss from the shift operation, especially
>       with frequent short-lived tasks;

It might also help aggregating multiple tasks. Right now, if 1.000 tasks
with load_sum=1 and load_avg=0 are removed, the rq's load signal will
not be impacted at all.

On the other side, there might also be questions about the PELT windows
of all these tasks and the rq being aligned, cf.
https://lore.kernel.org/all/20170512171336.148578996@infradead.org/

>    c) Reduce one multiplication and shift in the hotpath, which
>       theoretically lowers overhead (though the impact is minor).
>
> Signed-off-by: hupu <hupu.gm@gmail.com>
> ---
>   kernel/sched/fair.c  | 8 +++++---
>   kernel/sched/sched.h | 1 +
>   2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b173a059315c..b8cf3687804b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4561,7 +4561,8 @@ static void migrate_se_pelt_lag(struct sched_entity *se) {}
>   static inline int
>   update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>   {
> -	unsigned long removed_load = 0, removed_util = 0, removed_runnable = 0;
> +	unsigned long removed_load_sum = 0, removed_load = 0;
> +	unsigned long removed_util = 0, removed_runnable = 0;
>   	struct sched_avg *sa = &cfs_rq->avg;
>   	int decayed = 0;
>   
> @@ -4572,6 +4573,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>   		raw_spin_lock(&cfs_rq->removed.lock);
>   		swap(cfs_rq->removed.util_avg, removed_util);
>   		swap(cfs_rq->removed.load_avg, removed_load);
> +		swap(cfs_rq->removed.load_sum, removed_load_sum);
>   		swap(cfs_rq->removed.runnable_avg, removed_runnable);
>   		cfs_rq->removed.nr = 0;
>   		raw_spin_unlock(&cfs_rq->removed.lock);
> @@ -4609,8 +4611,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>   		 * removed_runnable is the unweighted version of removed_load so we
>   		 * can use it to estimate removed_load_sum.
>   		 */
> -		add_tg_cfs_propagate(cfs_rq,
> -			-(long)(removed_runnable * divider) >> SCHED_CAPACITY_SHIFT);
> +		add_tg_cfs_propagate(cfs_rq, -(long)removed_load_sum);
>   
>   		decayed = 1;
>   	}
> @@ -4792,6 +4793,7 @@ static void remove_entity_load_avg(struct sched_entity *se)
>   	++cfs_rq->removed.nr;
>   	cfs_rq->removed.util_avg	+= se->avg.util_avg;
>   	cfs_rq->removed.load_avg	+= se->avg.load_avg;
> +	cfs_rq->removed.load_sum	+= se->avg.load_sum;
>   	cfs_rq->removed.runnable_avg	+= se->avg.runnable_avg;
>   	raw_spin_unlock_irqrestore(&cfs_rq->removed.lock, flags);
>   }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index be9745d104f7..659935a5c694 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -682,6 +682,7 @@ struct cfs_rq {
>   	struct {
>   		raw_spinlock_t	lock ____cacheline_aligned;
>   		int		nr;
> +		unsigned long	load_sum;
>   		unsigned long	load_avg;
>   		unsigned long	util_avg;
>   		unsigned long	runnable_avg;

