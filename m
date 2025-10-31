Return-Path: <linux-kernel+bounces-880274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F54EC254AB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2028B427FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CA322D9F7;
	Fri, 31 Oct 2025 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tE/POzx5"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB6B1DFF7;
	Fri, 31 Oct 2025 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918013; cv=fail; b=I4tE9MRPnm/M7eOB8Pok8Htgpje7B6bf2qDGLHiyRmDo66l8IluErKA8OjQ64hOzpib+UsFExKLvin62q2upTXTeBbe2JGqp3+ForMpFzY3ELbj/nhTKTHCe7XRYN6lMrDobATy4SmudEMdcuJctbC1yYWRfJ2kXZy/zIAbPc+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918013; c=relaxed/simple;
	bh=WVcl5SXOFC436OapZbWoamEjN8FrJJolEHR3UD2EpeY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=V3hXeIwo7rsATeaUKOtWjbsSDKnFdQuNmfdj1/ScbAxAEE4t9lujCVP42M68+SxItOxza7DAJWtPFTiDTAUEcknDO6X7qx50yb9dfDpWMSIy8yLOvcpBu9Z6KwW99u97hqXXL8u3ss7GcQRFN1fr9OW7nVD+c87UhcXMSu1sIOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tE/POzx5; arc=fail smtp.client-ip=52.101.48.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s11Hnr1p02DgREsOaR7OuuYl2JrdXHstG1GdHGniQOQOdPWthdxEKNg/V3GrAtptuolws8kGBc/wvl6T6hmKDuIfJ/RzCpDKO7gADJ1DIrXwZq0O8q0USsz1NDPjp711x0O3fRL8/jyeysPbX+YM58lwZdTlS3M9EDgo+uKsekuZz8nyX7AlrYvl63Rx6LOGM0LPU42YdRD3hwQqKsDAqHg3v9Cf925g1THAGYTwfwr9/P3nRFzq5R39JpUjFoa4uNp0AV3TwYH/aHDhwXu1IQdwpusa9+Dx/MEAlekOdUWm+AcJYIR20sO7eLKIjqajfLPhsCPay9QNOqQMkjgkfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPNBNfxnO7naNrsZ4j6RN6idYh58nVK6wQHktHd1TaI=;
 b=pLEw6+HTqFpdzqNy2YzSeAdhZvrvcW0DR4F9p3XWp4TPjQ/zKBZ0ymC8OYWzbn3GzzYSJVqAihSWFvLW9e98HH9ld1LCH5STJQcJtbw/3l78LmG+RN3QneG5Dtc+mTDGKnxlA8h4usZtZZ0Ckz7SWuAau8zv54k5LjXh7N1x3SF0+5y28ovTjZTTm6U8G78VnE2mzA2ZnvzFF7/j8dqLPInxlRLDvYN/YL3o2ObDhNzG9m3V/3MPFbS5PdfaPslSLk3ieBMypx1qIWFO0n4MKtRnVWR1C2NPOj551uSKNQogqSOHR8QXJA0AT74/7q8MQQwQI/2lJogrdrunJRoN+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPNBNfxnO7naNrsZ4j6RN6idYh58nVK6wQHktHd1TaI=;
 b=tE/POzx557AzXNVIwF4lj6snFKdGujprqRl+4vvE5yY0xZXR3EnBZHeu4weaZtCJSPQPUepOo+EO7iZRms16URnVC+Y3klaOzXmkmb1noAwslQLaGW9rWksqdPZlN/+L1D6MUdCWD0tQLg6urAW90nc/zTcQhxBdtkLWJetcFTJ2HDrM+UDmCSHqhEcbL+QMRKT+M901WaUHaE39ICw+QKNDHEGMK+OpNm5VFdp1ITntGwpkNkGpznqcWCEhX4lxF2YiPFV+LsmWNZ2dS5usjgSsXacjN2JWyqSQoBgXvL4zAQytKpYocGDh4ld9K7FQuve1Y6VcJYMK7jso5opNJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 13:40:06 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 13:40:06 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH 0/2] rust: add BitInt type and use in Nova's bitfield macro
Date: Fri, 31 Oct 2025 22:39:56 +0900
Message-Id: <20251031-bounded_ints-v1-0-e2dbcd8fda71@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACy8BGkC/13MywrCMBCF4VcpWRtJ0pu68j1EJHZm7CxMJKlBK
 X1304JgXZ4D/zeKiIExikMxioCJI3uXh94Uouutu6FkyFsYZWqtlJZX/3SAcGE3RKlBVXULe4u
 mETl5BCR+LdzpnHfPcfDhvehJz+8XMmsoaakkQKOo3qkKbXV0iYHttvN3MUvJ/Nb7v9rkmqiEl
 hBLIljV0zR9AIPayDrnAAAA
X-Change-ID: 20251001-bounded_ints-1d0457d9ae26
To: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Jesung Yang <y.j3ms.n@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCPR01CA0047.jpnprd01.prod.outlook.com
 (2603:1096:405:1::35) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: c7151157-f929-426c-f9aa-08de1882fff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aC9relF4VURpMElKQytNcUNUd3MwWTJUbk1yNXhjK0hXRWppdzM2YStiVUZL?=
 =?utf-8?B?c1B4UFBUUnVUT25kQi9JejlxUk5EcU1FSUVFbmgyNGl0dGk3WHAwUWplQ0tG?=
 =?utf-8?B?S0FpWnFCTi9Eek5TWCtmSWdkS0xhMlFzZHBqVVJ6UmJsVjQzYTJ1SVhlQjNJ?=
 =?utf-8?B?aVJzRkhnTDZaUUJDY2Jnb3JYSE90MnlBcGtsRWxVcmJBeVlxK3VmTFZjRDVY?=
 =?utf-8?B?amhyejdvcENwQ3RlSStqNmlyZDJHOVg1TDcwTVRtRFVLQXg0NElsTEl2U3JK?=
 =?utf-8?B?S3pJNytlNHgvZG1XMzFaaFV4ZlBGTjlyYy9zaUtzcUlvTS9SbjkxQ0V5M0JB?=
 =?utf-8?B?ejNhUjFRemFtS0JZOG9rb3g5Q3BaU2doWjFDRVJEcXdwNXVVQTJSUW50d2pp?=
 =?utf-8?B?WlpCdm5qdXF3OW1zTHhpN05LaVdIWThWZEJsTlN3alRpbEVMd280L2pXUVZ3?=
 =?utf-8?B?YnlXbUZvUFd0anZRT0wzUEdacHZhcTZWcnVtZDU3eFFKL2FsdnowekdrTUQw?=
 =?utf-8?B?Z21ZcGJCcGhReG9oOVI2R1FoMDI3cUFtTlViUlVnb1pINzNuMysvRGlxZWU3?=
 =?utf-8?B?Wlhwc3NMeTltVDF1MDFNREZKYzVPRGhDdE81ZVhPNEhUNGkrdUxWY1N2QXV3?=
 =?utf-8?B?S1hzRk9iYUk3MjFGNVBER0tiNE5IUUN5MWhBY2xxM1pqZWRpL0pYeXlCOXEz?=
 =?utf-8?B?SWswaWdMQTROVXZGdFoxL0Fmc0FKY2RoR2tUNnNEVGsyNzdUY0owdlBad2cw?=
 =?utf-8?B?aTd1cm1DN1g3YnBLU3ZVbmJMVnc0ZEFBaG1OVzBLOVVyRXhzYWRFMGs3QWVV?=
 =?utf-8?B?SXhCQ0daQ1ZZMmllaFdqVE9qNjNkc3ozZmhHM20zVEgrcG1XeFRLZjFIU3BV?=
 =?utf-8?B?MTZzamxHLzAvbDl1WnRwK0Q1c3A5OG5XZ2tJNXB3QVRPSDhJY2o2UlZnQ29y?=
 =?utf-8?B?ZUZsbElsRDIzTGEzdGNDNzVVV3kvWTZ1UmpLNVZjUnhPNDZ6Q3YvNGJBZEFO?=
 =?utf-8?B?WVJWVVEvN2NxZFY5TElUL1JVdEY3ekJRZWlKSmVZSUJDNlJZb0JEbExlM0x5?=
 =?utf-8?B?QW5xa1ozZDVISHU5bmlCWUNITGNlS1AxRklWRDNBOXR0am1kQllzNHRiMEVl?=
 =?utf-8?B?TWZiK2ZweWhMSHNzQjg1RTlZQ0NieFhGK1FiWGNueDFSa3l6Nk9pMyt0WGZZ?=
 =?utf-8?B?dzc5cXpPSEhIMXZmOC9Cakd1aWhWSFNlS2JTUFhac3VXNGNaQnZ3UEl6a1lL?=
 =?utf-8?B?dm1PSm5DaXlLMkZTaWdOTkdNT2hqNDNXWlBUYzZzUlVham1Bbk92MG1xYkxn?=
 =?utf-8?B?SW84ZHJGa3lHUVFmRlA2ZW5kdEtVd3NQTk9CM2FrYXAwSGg0Y2JrYmhiYmUz?=
 =?utf-8?B?aU16dmdGTW5XT004SGF1SXZQaTlrOGZ3ZXMxUHZTZUhaNG92S3hOc3NoUGNq?=
 =?utf-8?B?MXJTT3o3bzNjZmNsVHhqWXNnSFNMeEVNTzhXWFVoN09nSWFsbGczaXNOVWZ3?=
 =?utf-8?B?ajZtbWNmelI5dVdSbmJpRyt3ZG41RzZzOXZJTmtTY3VYWHQzazU1WDB1WmFW?=
 =?utf-8?B?dGRubEM2ZWlMOXdZTm1jc3Z2ZW05NXFIaG50cGh1b2NMdzE2anRORGUrUzMr?=
 =?utf-8?B?K2IxNzg4Nkx2ODhCeTRWbGc0bjgyU3dxK0x5TnJZNExzZUF5VkhmR0dXRHRt?=
 =?utf-8?B?enQzTmF2Qm8rNnRWTnN5ckVkK1lUU0FiWWxJNmNIdnNDNERHQ05ZL2lBVWlu?=
 =?utf-8?B?MlhMYWZodVFvb1daZWlKYUp6MXZTRFhUdFpPOUdMUTB2cXM5c0haN2FPdk56?=
 =?utf-8?B?ZjdJZEx3N1hqNjdUWnpLZU0wTElFZG81NmlxVjdHOHBqLzZPODNNSzViRzVy?=
 =?utf-8?B?OXd5Qys1K2Fnd0tmOEtQQlpoNGkxejFZcWxtNFFnQ2ZCN3VRM1YwTFFmZENn?=
 =?utf-8?B?cGZUREowc0h4N01wVEJ6MVVHMGRNU3EvN2xScDNJRmZkQUJoUzdsWnpwZ0ND?=
 =?utf-8?B?blRyWTloejdNWEJhOTlNRkNkRlRBbG1jRmtZWmtVR29CWDI4TWlidkREbmN2?=
 =?utf-8?Q?NiYFbH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czdORnpUbW1pL3QvVGhEMG9TSUV1YjVzZVEweTB5VFpYbFIwK1M5R3I1UjlX?=
 =?utf-8?B?QUVUOGY2QmphTnVBN0xENnhjbk12SWR0N01hbFZjeElVWDZBZ245VklFdU8w?=
 =?utf-8?B?clNEVk52TnN2RXlVb1JtRXEzdXU5N0FxWW9LRDM1NVhVK3pDcStlazkvMHZ6?=
 =?utf-8?B?TzNMRDRyTkRoOG4xTmxrWW9uNEZsSEh0aTNKQ1VSa3FjVm16SXhZK3hzQ1JO?=
 =?utf-8?B?MG9QdlpxWVZIVDFrZEFiT0ZEbGNoRzFaZy9NeDRIenlXY2V5OWdOd1hrdlZy?=
 =?utf-8?B?cmQzUC9wcEl3QmlEbTR5aVFCT2hOUDRGV1dxY3RuVUwyTUdSQmIwaEhiR2t4?=
 =?utf-8?B?YlBJMEllK0YxMUpCdGdoeDc4aXhOSzA4SkQvZXA2NjhyMmorYzVlTUxDaVUw?=
 =?utf-8?B?UTFNdmVGTG5nOUQvTnFHZmgzQzViMDVmbitQSmQ3ZUYxWXozRVZkYk5Xd0tx?=
 =?utf-8?B?M2Y1d3Y3N1JuK3A1UzBTbElzUlBuczNDYUdsSjR2cVdHSGI2Z2l0eW9XNC9C?=
 =?utf-8?B?N2NYSWFwQ1VnMDZvMFVYelRJNDdIQnpvOWRPUUpKVDFnamdQd0hGOTVSc05E?=
 =?utf-8?B?TTB5aVVDRzVtQTZ5OGUvbU1pNWhrWHVhVGRVcGhBQzNLWVg3YmZOSi9JNmw1?=
 =?utf-8?B?VUpLb0RyVzNXeEVhbG8wYmxNb3Y4QnNQS3lHMHlsN2RDcnY1YW5obG8vMnl5?=
 =?utf-8?B?WUdJVXorb2NvK2VtWE94Y3FnZzhrNXFzSHlFekptZ3BVZnNCVG13cEdlVTV2?=
 =?utf-8?B?RlVVeTJXRTJic05xdTNhUlFDY0xCZjdLSmtmelU3dTY4SDEyclBFb1ZpeDha?=
 =?utf-8?B?M05kcmVCZkJkR0dFZzFtK0JPNmVIUU5rc0RrVUpKYVFGUWhIQ0lJVU9GMWRs?=
 =?utf-8?B?ajZ0eFJORzhiMm1TTTJ3RVEvVGViQUVvbEFwbmlLVFcyaGlCU3ptN3g3aTRm?=
 =?utf-8?B?YmRKekpjVG4yME9Ic3NxL3dIU3JMRldWb2FuMjE4QzhQakhBbzFlUXlabDNl?=
 =?utf-8?B?RjhPRVhZRVgzVncvSktBb296SDRrNHNUVnZ3RGViNnZOTFNEZXEwWGluQTYz?=
 =?utf-8?B?MlhZdXVuOGV4YmtsZm5zTi95cFUxaS80MTM1cXc4Z3BLNDZOUVgrcncwdXJQ?=
 =?utf-8?B?NDN0SVBBUk9SVWVrZkFGYUtRWmo1eHhsd3p6ZERHazBSTlo2eWlrbXZmNmdl?=
 =?utf-8?B?SDNPb3Z4d2FBcWJJNHlON2hrd2ZIdkV4RWRTUG9vU3k1cGFtUWtXc2NoV0ZZ?=
 =?utf-8?B?QUpyRkxoekE0alh1U0h5a21Rb2h1eDR2OUZZeFYrUFkxYXkyNVV0Y0FkZnl2?=
 =?utf-8?B?akd2SFJHWUx0akxwTWthTzNRUEVSTnpRdjlNOEYzSUFFZlY5TklPSzhnbUJF?=
 =?utf-8?B?VkdpckNaTC9vSUJOZ3QveTNXdENqUHNwSGx4eTZ2ZG5xaGxJRkJQRFkzZ1Nq?=
 =?utf-8?B?bVdodlNSdzBnVFJHOGJYUSt5QW9HT2UyZk8rK3BESEFjdDFlZmtLejRzaHJV?=
 =?utf-8?B?QTBNNk11M25hVk16VTJFYjJOcitMVDB5YzZTc0NWTkRPbXdrWGFONHpqZldN?=
 =?utf-8?B?QVp2UDh4UTQ4bWttMkNkMFJVdStiRTMzUklRdFBOZGNQYjk3NGpoYjk0dW4r?=
 =?utf-8?B?aEZTdUh3T0dJbUFFVnZRWGk1SVZWTWEzVlhmZ2NOemRjSTZldGcxVXN5Y1Rp?=
 =?utf-8?B?RENIakl6TFZ5OU9OVjJ6c00vU0gvdlM4TUtObi9oaFd1YmwySmdnU1NKY1dm?=
 =?utf-8?B?b1hTRDM1dkdiR2ZuMUhpaXZwSlhLS0xIWmM4V3RVcTY5VnhKa2FDcTZ2aTVX?=
 =?utf-8?B?L041ZlRzUStEeGVmc1FJNHpxY0ZqTG1GTjVlbi9UOUhkeWJyUDFVcUoyMTZ3?=
 =?utf-8?B?SkU4aE45czYyeXlDRkk4MDJDM3lwTUFwNkdwV3pHeXQ5MmE2eEtZNnVTWUVG?=
 =?utf-8?B?QWlxVWllOWRSSEcvWVR0UzZuOFZFRXVmU3pYN2FoMmc1aldiVVVaN2M4eExN?=
 =?utf-8?B?NWNZcnpOdXNUUjBlYTZYejNjZC82QUV0bmtJdmZUSGdOWi9NNXNnb1dNbjBt?=
 =?utf-8?B?UGlOVnoySDlsY0JVbjJ6TmlXWEdvaGFNRFV3algzeVFyV3R0dENlUEJwcUJw?=
 =?utf-8?B?YUxUVmJUR0FjWlpJNWFRb0NCMytNaTVjeFJ5RExsMzA5VGNYVklYVUJoaUdu?=
 =?utf-8?Q?hf81uEy6gm1Eobt7qVsaxrcs8+EIqWyFAJbaLR3vRLI9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7151157-f929-426c-f9aa-08de1882fff3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 13:40:05.9843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8iVR6Nb2wXS85gyfWiSm1yWIFk5t91sTKFsXARnNXX5GYEefSIioD2Vt6lwDuGn5/w5UALKqnaMA8tBueQEpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211

I think this code is mature enough to be moved out of RFC, thanks for
all the feedback so far.

This series provides `BitInt`, a wrapper type for primitive integers
that guarantees that only a given number of bits are used to represent
values. This is particularly useful when working with bitfields, as the
guarantee that a given value fits within the number of assigned bits can
be enforced by the type system, saving cumbersome runtime checks, or
(worse) stripping data when bits are silently dropped.

Don't worry about the size; half of the code is actually rustdoc. :)

Example use (from the rustdoc):

    use kernel::num::BitInt;

    // An unsigned 8-bit integer, of which only the 4 LSBs can ever be set.
    // The value `15` is statically validated to fit within the specified number of bits.
    let v = BitInt::<u8, 4>::new::<15>();
    assert_eq!(v.get(), 15);

    let v = BitInt::<i8, 4>::new::<-8>();
    assert_eq!(v.get(), -8);

    // This doesn't build: a `u8` is smaller than the requested 9 bits.
    // let _ = BitInt::<u8, 9>::new::<10>();

    // This also doesn't build: the requested value doesn't fit within the requested bits.
    // let _ = BitInt::<i8, 4>::new::<8>();

    // Values can also be validated at runtime. This succeeds because `15` can be represented
    // with 4 bits.
    assert!(BitInt::<u8, 4>::try_new(15).is_some());
    // This fails because `16` cannot be represented with 4 bits.
    assert!(BitInt::<u8, 4>::try_new(16).is_none());

    // Non-constant expressions can also be validated at build-time thanks to compiler
    // optimizations. This should be used as a last resort though.
    let v = BitInt::<u8, 4>::from_expr(15);

    // Common operations are supported against the backing type.
    assert_eq!(v + 5, 20);
    assert_eq!(v / 3, 5);

    // The backing type can be changed while preserving the number of bits used for representation.
    assert_eq!(v.cast::<u32>(), BitInt::<u32, 4>::new::<15>());

    // We can safely extend the number of bits...
    assert_eq!(v.extend::<5>(), BitInt::<u8, 5>::new::<15>());
    // ... but reducing the number of bits fails here as the value doesn't fit anymore.
    assert_eq!(v.try_shrink::<3>(), None);

    // Conversion into primitive types is dependent on the number of useful bits, not the backing
    // type.
    //
    // Event though its backing type is `u32`, this `BitInt` only uses 8 bits and thus can safely
    // be converted to a `u8`.
    assert_eq!(u8::from(BitInt::<u32, 8>::new::<128>()), 128u8);

    // The same applies to signed values.
    assert_eq!(i8::from(BitInt::<i32, 8>::new::<127>()), 127i8);

    // This however is not allowed, as 10 bits won't fit into a `u8` (regardless of the actually
    // contained value).
    // let _ = u8::from(BitInt::<u32, 10>::new::<10>());

    // Conversely, `BitInt` types large enough to contain a given primitive type can be created
    // directly from it:
    //
    // This `BitInt` has 8 bits, so it can represent any `u8`.
    let _ = BitInt::<u32, 8>::from(128u8);

    // This `BitInt` has 8 bits, so it can represent any `i8`.
    let _ = BitInt::<i32, 8>::from(127i8);

    // This is not allowed, as this 6-bit `BitInt` does not have enough capacity to represent a
    // `u8` (regardless of the passed value).
    // let _ = BitInt::<u32, 6>::from(10u8);

    // A `u8` can be converted to an `i16` if we allow at least 9 bits to be used.
    let _ = BitInt::<i16, 9>::from(255u8);
    // ... but 8 bits aren't enough as the MSB is used for the sign, so this doesn't build.
    // let _ = BitInt::<i16, 8>::from(255u8);

There are still a few things I hope to simplify: notably the many
implementations from and to primitive types. I have added an basic
`Integer` trait to allow writing generic code against integer types,
which simplifies things a bit, but it is still a bit too complex to my
taste. Suggestions are welcome.

The first use of this will be to represent bitfields in Nova register
types to guarantee that no data is ever stripped when manipulating them.
This should eventually allow the `bitfield` and `register` macros to
move out of Nova and into the kernel crate.

The second patch is here to illustrate the use of this module; it is not
intended to be merged this cycle as it would likely result in big merge
conflicts with the drm tree.

This series applies on top of drm-rust-next for the needs of the second
patch. The first patch should apply cleanly on rust-next. A branch with
this series and its dependencies is available here:

https://github.com/Gnurou/linux/tree/b4/bounded_ints

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v1:
- Rebase on top of `drm-rust-next`.
- Rename `BoundedInt` to `BitInt` (thanks Yury!).
- Add lots of documentation.
- Use shifts to validate bounds, as it works with both unsigned and
  signed types contrary to the mask method.
- Support signed types (albeit with some bugs).
- Use `new` for the const static constructor and make it the preferred
  way to build values (thanks Alice and Joel!).
- Rename `LargerThanX` into `AtLeastX` (thanks Joel!).
- Support basic arithmetic operations (+, -, etc.) against the backing
  type.
- Add `Deref` implementation as alternative to the `get` method.
- Write correct `Default` implementation for bitfields.
- Make the new bitfield accessors `inline(always)`.
- Update bitfield documentation to the new usage.
- Link to RFC v2: https://lore.kernel.org/r/20251009-bounded_ints-v2-0-ff3d7fee3ffd@nvidia.com

Changes in RFC v2:
- Thorough implementation of `BoundedInt`.
- nova-core fully adapted to use `BoundedInt`.
- Link to RFC v1: https://lore.kernel.org/r/20251002-bounded_ints-v1-0-dd60f5804ea4@nvidia.com

---
Alexandre Courbot (2):
      rust: add BitInt integer wrapping type
      [FOR REFERENCE] gpu: nova-core: use BitInt for bitfields

 drivers/gpu/nova-core/bitfield.rs         | 366 ++++++------
 drivers/gpu/nova-core/falcon.rs           | 134 ++---
 drivers/gpu/nova-core/falcon/hal/ga102.rs |   5 +-
 drivers/gpu/nova-core/fb/hal/ga100.rs     |   3 +-
 drivers/gpu/nova-core/gpu.rs              |   9 +-
 drivers/gpu/nova-core/regs.rs             | 139 ++---
 rust/kernel/lib.rs                        |   1 +
 rust/kernel/num.rs                        |  75 +++
 rust/kernel/num/bitint.rs                 | 896 ++++++++++++++++++++++++++++++
 9 files changed, 1325 insertions(+), 303 deletions(-)
---
base-commit: 9a3c2f8a4f84960a48c056d0da88de3d09e6d622
change-id: 20251001-bounded_ints-1d0457d9ae26

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>


