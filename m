Return-Path: <linux-kernel+bounces-877504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5583C1E4B8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 04:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912F83BAE30
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E4D26CE33;
	Thu, 30 Oct 2025 03:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="gI0BA6Op"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012010.outbound.protection.outlook.com [52.101.48.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242CF243376
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761796466; cv=fail; b=Ce5tn/tMiNw72Dhbjf+9wgISwS2ACVzRpqBOJuUi0Yk0i2/tdmnRPtbLA4a07oPQZ3qhpl8xiOiw21jg1uOAKYtwcDQ4Gfiqf9tUsi9L3TrWHVmi+gQWnRlCuGgEHyfdDnXz/k0ZIOjUJ0HQTppByYsOviXAMuOvQiXxgkAwxPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761796466; c=relaxed/simple;
	bh=HqpqOzkkLm6BS+6RHJEx7CMPwVbBbW1Oru/67fljtYE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dSN258fK6mM/gdm7Qm2lvhhbV5VD0HnYexxPxH+DdO4ldy6l4suPE52OZGTeaQ93brEV4H1/wLvMvSQ5BowfERuK5V7VbY515i7Df7RmbU91WHEfWcyAbnuHIWxpmJls5GHJ6Pym1YRHuQ/mpOaj4OzzbdPH7PuS1nU7r/I3v6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=gI0BA6Op; arc=fail smtp.client-ip=52.101.48.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKXej+5+bmi6wFV9wAlxBZ9RnTEua/69PiUyviqjDh4+kY0UBXeaDzgivdYBUA/bSygTElHlOXet8apTdgYCWx81VFb76Aj3wegsDAthXCw3qBqStQhqMqHXOlFs57Xxv5ahS8rAndzuhkuWdpi1J8bEEHfqjxqKf+rokFmEBjQUKuhrnUqiswsuCvVhTN6mdksTIXq6o6uoMn0RpXC5Cj0/pSnZ+wH6fcJOwUb0VJk6sFOXYJ1LrtrjD+adPCxoCRqTZ2M40PYLLWVERZbiYJ7kGIa7SIo+ky4+3bl3/731lzsKX1WHXXJFd8TrUlQlZhdJF7T/iY5RigkI89P4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rCwSWmETIfFZWcZ4ZplMsZqO6xd+JHCpyX50EXa/t0=;
 b=W2UB7Ch8w/JTDakhgxedMZOGaGH3TnJjJK/C/qIQJowthkJEtNj2K6wr+Xy43XABnO5PZm71b3UwhWmZRkaq7FbtLbR9KuBiaQMdCKpTdhJ6Ig7Fwx0NTNcaCj6Ud9bguxJ3xIVmYAfFPuzh42ajsfCcCpxUP46A6KxyuVPmPuGgwii7IEiV53Po8w+8lMbua5GSVismSmzbHsVrv5M+lvz2VyW5iG04YByMl2FQPMfmmbecHctgRJ8D+KZZu7G7XURBwagYOJfzdLDN6XxcMRGazOhClszl5ZKQMsYd5qJ6/i+Q853sML5i6ljZNx+m6sxuw0ElGngctYEkP2AU+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rCwSWmETIfFZWcZ4ZplMsZqO6xd+JHCpyX50EXa/t0=;
 b=gI0BA6OpTy9TowWwmri+ztIMyLTN+a4FRWWcenvD3v9LH5M0w9udDHDLNoEMnjhOv9/+74wT3V6hqkvYlqqRurJ6zH18Dznx3RwqLsP9tstS1aLTYOCaMOjpy69KZO6NjoYPWzQnVW7kadilkcT2UBXGk0sG9WfGBH6fgEReOGtjyZNqoK0IKQ28i2lsHBDDLb319qgkBl3brpbGGUF5GZ8ow1jDgwvgpVu1HxyEeo+i+8JYaU/r650odjyOjodBIAcR7omlG6a/NUDL/XirjFMB/E91hNhZT8Sl/RGj6gre05CHLeihXZAixzTAdHgAuTYBcVqGWakmWYsYFictWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 DM6PR03MB5164.namprd03.prod.outlook.com (2603:10b6:5:247::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.13; Thu, 30 Oct 2025 03:54:22 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 03:54:22 +0000
From: adrianhoyin.ng@altera.com
To: dinguyen@kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrianhoyin.ng@altera.com
Subject: [PATCH] firmware: stratix10-svc: Reduce polling interval for command status
Date: Thu, 30 Oct 2025 11:52:14 +0800
Message-ID: <669f87ac9348a0532589f17a625664cec68e0059.1761796187.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0110.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::26) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|DM6PR03MB5164:EE_
X-MS-Office365-Filtering-Correlation-Id: 818ac79e-d238-466d-a8c4-08de17680233
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NktVN1ZseDB6U3RwT0tndElkYjNQVmRqcFhlRml1a2lXa2d0RUZFVTM3d1BH?=
 =?utf-8?B?ZUN1aStRejhROHZ0bVZhVHNzcUJKbUZRUHRUNHJCYnlOazNNTGt5a2dhU1Fw?=
 =?utf-8?B?aWgyelpqd05keWJFdFhwYTJrM244dHJZeEMxRFZZbHgvWVRoQzBIQWJIMEJI?=
 =?utf-8?B?cnIxVUVZeTBsRDJYZGl5YzZVQTc2Q2NMTkhKaWU4a0ZTUlpKVFM2NGVaWDB5?=
 =?utf-8?B?R3ZYd3hqa25TRVczM0Zqek1HbHV0NmdLRDdkNUpDUWZPYy94Q3IrQXJXdWQv?=
 =?utf-8?B?cXlzYjh1Zm1LMk5iTUtQWjk0SFJ3MWJzUTlLZ2pwNGtwL3NHeUhTQnFZOHZy?=
 =?utf-8?B?emJaRnB2czRPZXZ1Um5pOXpUTDJUQVFNUit2bmNyT2hUQW5HTFdPbGpSRHZz?=
 =?utf-8?B?N1haY1ZiRGd6emJxQzAxVmF6S0JyQlVEek1wUU9MYU9OZ291Nm1jaFRTSmZw?=
 =?utf-8?B?RWgwOWtWbVNkb0xzbnFqMktCNFZHTjFVSEg1TnRoS2pzN2tONjRJMjRLYnJ5?=
 =?utf-8?B?enBFbndUS3pyMnZXeTBIR05heHlHeTNQTW5EaTdDbFlPdkxRUWt6UW1XWVNP?=
 =?utf-8?B?Qlp3Z0RjcG96UTVMYTZFbWJvWTU2WXJzMkxxbmp6WXByYUZ1UGgrSitzTGtU?=
 =?utf-8?B?ZFhlMlZFZm5ua1RSaVkrYjR4djBwMER5NXZmZ3llU0IrZDRydjNYdWxZeEtT?=
 =?utf-8?B?UmZ4SDA5MXRONVM0V1VmT0t3SXdETFVsN214VXFOYjlwdE1FZnFMaWpYcE0x?=
 =?utf-8?B?Y2VJd1RRamdQd1NDb2NZYWVYVk5XVmwwb1RIcmlCeFJJWVZWZEFYOS9xNm4r?=
 =?utf-8?B?bGtneU1BdDNQMzZMSU81VnE4VjFFdTlIYjRUQXZqQXEzRFlxNGoxYjFWMENI?=
 =?utf-8?B?b1QySVRNeW56U1VoNS91ODN1Nm9LQStnWkM3Y2hBWmFzaW03VlkzcTZUNGxU?=
 =?utf-8?B?RFV0L2dPZnFsVUR1b3NLZm1ySHV4djRhd2dTODBTZEFQYXduNUhjem5YVmRM?=
 =?utf-8?B?OTB1aXRZblc2VFAxbTZTWXN2djV5YUNZMHI1L2l6MzMwQS8vYUdmRmxicnky?=
 =?utf-8?B?UEJYWTVlK01WT012YzVLTzRSTU9QN0dHNGVMY0NjaHpZbGtpRkVLUmpBYndG?=
 =?utf-8?B?ZUhSYXJZRFRybUlWb2pZYkpTamVjWjlVaUFFcE9wVVJoejRmWTVOQkUrTHlN?=
 =?utf-8?B?QVhJcHEwMWEwLzNYMzd3UGlDRHZ5Wm1GOWxMa2NlUXBNR2U4NlVwcmpnQlMw?=
 =?utf-8?B?Z0VlZTREN1NkRXhDMWQrdmJkRkVFZTZlUitWczNBT3FSdmlydHdTeW5LMFlv?=
 =?utf-8?B?b2tJZUNxeTE3ZGtDWUp6aDNsTURZazZaQTF0WnFEejhSb2d3aFFMcWozd0Q5?=
 =?utf-8?B?QmlKSmQ5YzJDUGtrbDErMDRTM0QzNnZiSnVnMjcwWlB6Tk54OXFaRmllVXNH?=
 =?utf-8?B?eHJObjEvbGZQTmU5R0R4dHJhRG1uOWpEdWRRNFhUMUNCZjFKUExtQlpleXBK?=
 =?utf-8?B?R3U1WCs2Ny9jbVJxMFM3Sm55bTRNb09GL2s0VldNQUVCZCttU3pSUzlnM1Rr?=
 =?utf-8?B?cTk1M2YvOHB6eWNTMTFBZmtsdWRCblgxSjhjQnd5cE5xUGdESkt1ZVJSVFJI?=
 =?utf-8?B?aUNkcERhK2VCSVlrSkxGRmU4bkkyR2dHbXFXNWFvOUlobnorUVJ3Nkt3OXk1?=
 =?utf-8?B?TUthbnRUR0hvMzI3SVpNME5GdHR4V2JNbFovNUcxS3J3SWZ5Ym9KMzBodUF6?=
 =?utf-8?B?UkdxYTRmaTRZeEJ5RllyNXozY3MzblMzbmhxa0Z0YWl6ZElDWnVRSmJEbU9C?=
 =?utf-8?B?QVZ5SFNpYTQrOVREVC9qL2VUQ25TNlZtSnI4dkF6bkpnNC9ObDZiOWplM3l6?=
 =?utf-8?B?VG52eUlzdlZHYzlFMEUwZ1B4L2pZMlR3M2Q1ZHIxSDVDNkVXOWd2YmtQcERm?=
 =?utf-8?Q?XjvRg9iM23YPzmkQUrCeTExug6wKe4T8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zlh2ZEdyVlF3alBsSWlPdzV3VC9qOWpCRmJEZTBiT0RnOERGU0NrK0JpUmlK?=
 =?utf-8?B?NTllTlZDN0dsc0Z0ZXpjc28xbjBGcHBVRm4vMWxUa1NqczVLLzR4dk5VeW94?=
 =?utf-8?B?bTlxNVVpY0hHZ0NoRHVKTlhxYjNwS1F0bks2L2NQTTRSSDRPYU5NNkhFcUlm?=
 =?utf-8?B?KzhlQUk1YTQydzk3emZDdGgvbmQyZ3U2UUpINVBjVGJvU2UvZ1E2Y0xnbENS?=
 =?utf-8?B?RmVsSDU3cGx4RGI1T08wYVdvTmJDemQrQUhLMnd2cmhiOXNsY1FXazFpQTBi?=
 =?utf-8?B?UzRFVlNlVERSVmxmK1N4Smp5QmRZcFBTTnF2UWJ5SWZ5dEthVGF5QUhTTWMr?=
 =?utf-8?B?a0hrQllUWDhhZlppSTA2dHRHcHpwQVA1RFAxaGIyRC82Q2prNnBldXBhU2dw?=
 =?utf-8?B?QmdyS0J5OGpsREo4MjNUbTk4WWFpb09nMVovZHRsSEJmZEg2a2h3d0dEN3M0?=
 =?utf-8?B?bjBIM0NPeWdNc01xUnZBTHpIcXJKMXFGWml0dmlWMzQ0RkMxUE5NNkY2Mi9w?=
 =?utf-8?B?b1l2R3NoZHJGQWtjalpTNlU4bCs1SG40NmsxRERHV09kaDhGUmFvNitkUnFO?=
 =?utf-8?B?VGlBSlplZ0FGWSt2SmNkaWF5dDlKeXJyc3VobEgxcHB1ZFd0Zlh4dWtYUk80?=
 =?utf-8?B?WjZ1cU5PcTB6LzZUTjJSMnFLRFUzcFQvYVM1UDdSWTZSYmlScEFybmM2OGRT?=
 =?utf-8?B?dWFuaHNvbTVpUWlCNlErUi92YXBEOGJnS3hZVXh2YUtaQSswUVNtSEtscDI0?=
 =?utf-8?B?SFg4QVNsQmNLbDZUYTlWT1RNV1VwN2p3OVJSc1owWmcwYmdweXpFUHQ2Vjl5?=
 =?utf-8?B?RzRIeGp2TVgwTjJ2OUZzdC80RGxzRnBGMFliRzVrZ1hTbldYV1EwWjVHOXBw?=
 =?utf-8?B?cUpPTzU4Zkt3aDlFNnl4VVBzZVMyeWtkRmQ1RVppL1FwMHhlRmRsZUVGSzVT?=
 =?utf-8?B?ajhNQ1RpNmtWeGpMQ0xRNHhWUFhPOFhtYU1oeVlna2xTZ0xGTnNmVC9Hc09E?=
 =?utf-8?B?aFR2dWVOMitPdGdzY1VkaW5SYzIvRHBEVVZEOVJtczJRUzNweG1ET2dTSElq?=
 =?utf-8?B?NnBnKzl5WGQ5OXNycUV2dkFFOEdtUFBGQW9FNytjTGJwTG8reExLQVFlajBM?=
 =?utf-8?B?bDN6T2JmSEhOdGZLdDdhN1dhWEcvcGQvWFRpZFRrM0ZGbzdaanZESktvUDZo?=
 =?utf-8?B?ZzgrOTJPRlpaeUVuY0R1QWI4UXY2V2lwczFpMEp3cjA0OGtOZ0lpcGs4NDBz?=
 =?utf-8?B?UU5mU0hCVUNzdm5wTjJiUE40MWIzTG1FWXBQWVFDRUltSkVkN3NKWTMrRWdJ?=
 =?utf-8?B?cVQ2a1JLblA0WVRla0RUbUpuWGF6MXpVZmZNSm8vZVRSN3M1cUt5elA3TnhJ?=
 =?utf-8?B?M3ZzQzdRcWVrZGJ4OGl6Q0l6ZEhrTWVFREhLcERyeVdtTGR1NlllUGhjcVRu?=
 =?utf-8?B?Z0trVkxvS0VXeEF2TDBzaytpcG41MmVrZ3lqd0tEbGg3dElZWitDNFdhZDB3?=
 =?utf-8?B?TFFvOFVsVmRSa0J5SEp4YkV6ZEdwaGY0ZnZ3VFduc1c4My8zTHdFL3hrb2ZV?=
 =?utf-8?B?cjdHbW4wQXUxNUQrY0lBSXNGRlZOR1plUmkzWEJMQVNFdDYyZ0FNMXg3UlVP?=
 =?utf-8?B?Rkg3YVlVcUlVaUU0VktTSkxNaWtONUd4bFVqdEhiQ3B5d0pxZCtzcjZIZE9k?=
 =?utf-8?B?dnJ2eTdBTzlDaDZ4N29pakN6SHZ0ZTZKZ0p0UmtxSXQwYThnM1BGTkx4Z2VE?=
 =?utf-8?B?UnBGNThhWVp1Znh5eGxpSHhDeERVZ0gya3d2VFRHa25MQ3dlcjhld01aYjFI?=
 =?utf-8?B?RG9ERTA1YjcwdGkvUEF2bEpzYUFSNlhPSE5KeFBKbjU2anBGVS9USmthdWVx?=
 =?utf-8?B?MVZTSFc3dW02ZTFkbldRcDc5MGN1RXJ6OVpNOEdCS09RUFAvTFdRWWJzRXFN?=
 =?utf-8?B?ZHBYZWFHR2dkVlhwcWt1ZkZXcndiaDc5a3J1Y0x2VkwwQ1A1UVkvaUo3NzQw?=
 =?utf-8?B?WkJPeGN0QVRLVk1zVUFDREZVUTk4clUremZkVUw1TUJwSmVoSGt2WkZFVFZT?=
 =?utf-8?B?YXpHUDNsMElldCtRa3oxc0R5R0VPbUt1WFNWZWJhY1pEbUR6Y3lzdGdoN3ZV?=
 =?utf-8?B?aS9oblZKUVBKV3JYbFBXQi85SzBxMWtJWjNheURrTDZTbXVTWUU0ZnZDWVVn?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818ac79e-d238-466d-a8c4-08de17680233
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 03:54:22.1681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7l9qetrZ/vffP81O/NIYN0M3QsNhdgz8Z4s/Idg7Ypq6i9MOXiLwD1G7VH9sw195X0J42Z4pZFqyPTW7soL8Fr4MuTF43QKM3Y8knfEhNoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5164

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

The service controller currently polls FPGA configuration status at a
fixed 1 second interval until the 30 second timeout expires. This leads
to slow response time for fast-returning commands and unnecessary delay
before reporting completion.

Introduce two polling modes:
 - Fast polling: 20 ms interval for up to 50 iterations (≈1s total)
 - Slow polling: 500 ms interval for up to 29 seconds

A new helper, svc_cmd_poll_status(), abstracts the polling logic and
replaces the existing loop in svc_thread_cmd_config_status(). This allows
the driver to respond quickly to short operations while still handling
long-running configuration commands within the same overall timeout
window.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
---
 drivers/firmware/stratix10-svc.c | 91 +++++++++++++++++++++++---------
 1 file changed, 67 insertions(+), 24 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 3acfa067c5dd..adf04ea56735 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -36,11 +36,27 @@
  * FPGA_CONFIG_STATUS_TIMEOUT_SEC - poll the FPGA configuration status,
  * service layer will return error to FPGA manager when timeout occurs,
  * timeout is set to 30 seconds (30 * 1000) at Intel Stratix10 SoC.
+ *
+ * SVC_POLL_INTERVAL_MS_FAST - interval for polling the service status
+ * at secure world for fast response commands. Interval is set to 20ms.
+ *
+ * SVC_POLL_INTERVAL_MS_SLOW - interval for polling the service status
+ * at secure world for slow response commands. Interval is set to 500ms.
+ *
+ * SVC_POLL_COUNT_FAST - number of count for polling service status for
+ * fast response commands. Count is set to 50 (50*20ms=1sec)
+ *
+ * SVC_POLL_COUNT_SLOW - number of count for polling service status for
+ * slow response commands. Count is set to 58 (58*500ms=29sec)
  */
 #define SVC_NUM_DATA_IN_FIFO			32
 #define SVC_NUM_CHANNEL				4
 #define FPGA_CONFIG_DATA_CLAIM_TIMEOUT_MS	200
 #define FPGA_CONFIG_STATUS_TIMEOUT_SEC		30
+#define SVC_POLL_INTERVAL_MS_FAST			20
+#define SVC_POLL_INTERVAL_MS_SLOW			500
+#define SVC_POLL_COUNT_FAST					50
+#define SVC_POLL_COUNT_SLOW					58
 #define BYTE_TO_WORD_SIZE              4
 
 /* stratix10 service layer clients */
@@ -370,6 +386,47 @@ static void svc_thread_cmd_data_claim(struct stratix10_svc_controller *ctrl,
 		 wait_for_completion_timeout(&ctrl->complete_status, timeout));
 }
 
+/**
+ * svc_cmd_poll_status() - poll for service status
+ * @p_data: pointer to service data structure
+ * @ctrl: pointer to service layer controller
+ * @res: pointer to store response
+ * @poll_count: pointer to poll count value
+ * @poll_interval_in_ms: interval value in milliseconds
+ *
+ * Check whether the service at secure world has completed, and then inform the
+ * response.
+ */
+static void svc_cmd_poll_status(struct stratix10_svc_data *p_data,
+				struct stratix10_svc_controller *ctrl,
+				struct arm_smccc_res *res,
+				int *poll_count, int poll_interval_in_ms)
+{
+	unsigned long a0, a1, a2;
+
+	a0 = INTEL_SIP_SMC_FPGA_CONFIG_ISDONE;
+	a1 = (unsigned long)p_data->paddr;
+	a2 = (unsigned long)p_data->size;
+
+	if (p_data->command == COMMAND_POLL_SERVICE_STATUS)
+		a0 = INTEL_SIP_SMC_SERVICE_COMPLETED;
+
+	while (*poll_count) {
+		ctrl->invoke_fn(a0, a1, a2, 0, 0, 0, 0, 0, res);
+		if (res->a0 == INTEL_SIP_SMC_STATUS_OK ||
+		    res->a0 == INTEL_SIP_SMC_STATUS_ERROR ||
+		    res->a0 == INTEL_SIP_SMC_STATUS_REJECTED)
+			break;
+
+		/*
+		 * request is still in progress, go to sleep then
+		 * poll again
+		 */
+		msleep(poll_interval_in_ms);
+		(*poll_count)--;
+	}
+}
+
 /**
  * svc_thread_cmd_config_status() - check configuration status
  * @ctrl: pointer to service layer controller
@@ -384,8 +441,7 @@ static void svc_thread_cmd_config_status(struct stratix10_svc_controller *ctrl,
 					 struct stratix10_svc_cb_data *cb_data)
 {
 	struct arm_smccc_res res;
-	int count_in_sec;
-	unsigned long a0, a1, a2;
+	int poll_count;
 
 	cb_data->kaddr1 = NULL;
 	cb_data->kaddr2 = NULL;
@@ -394,30 +450,17 @@ static void svc_thread_cmd_config_status(struct stratix10_svc_controller *ctrl,
 
 	pr_debug("%s: polling config status\n", __func__);
 
-	a0 = INTEL_SIP_SMC_FPGA_CONFIG_ISDONE;
-	a1 = (unsigned long)p_data->paddr;
-	a2 = (unsigned long)p_data->size;
-
-	if (p_data->command == COMMAND_POLL_SERVICE_STATUS)
-		a0 = INTEL_SIP_SMC_SERVICE_COMPLETED;
-
-	count_in_sec = FPGA_CONFIG_STATUS_TIMEOUT_SEC;
-	while (count_in_sec) {
-		ctrl->invoke_fn(a0, a1, a2, 0, 0, 0, 0, 0, &res);
-		if ((res.a0 == INTEL_SIP_SMC_STATUS_OK) ||
-		    (res.a0 == INTEL_SIP_SMC_STATUS_ERROR) ||
-		    (res.a0 == INTEL_SIP_SMC_STATUS_REJECTED))
-			break;
-
-		/*
-		 * request is still in progress, wait one second then
-		 * poll again
-		 */
-		msleep(1000);
-		count_in_sec--;
+	poll_count = SVC_POLL_COUNT_FAST;
+	svc_cmd_poll_status(p_data, ctrl, &res, &poll_count,
+			    SVC_POLL_INTERVAL_MS_FAST);
+	/* Increased poll interval if response is still not ready */
+	if (!poll_count) {
+		poll_count = SVC_POLL_COUNT_SLOW;
+		svc_cmd_poll_status(p_data, ctrl, &res, &poll_count,
+				    SVC_POLL_INTERVAL_MS_SLOW);
 	}
 
-	if (!count_in_sec) {
+	if (!poll_count) {
 		pr_err("%s: poll status timeout\n", __func__);
 		cb_data->status = BIT(SVC_STATUS_BUSY);
 	} else if (res.a0 == INTEL_SIP_SMC_STATUS_OK) {
-- 
2.49.GIT


