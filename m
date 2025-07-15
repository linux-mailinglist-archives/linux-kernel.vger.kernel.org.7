Return-Path: <linux-kernel+bounces-731195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C411B050A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 651913B4DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47342D29CA;
	Tue, 15 Jul 2025 05:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WAJj8BLd";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WAJj8BLd"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011048.outbound.protection.outlook.com [52.101.65.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FDD3FE7
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.48
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752556446; cv=fail; b=Pwww05xQlpFi7nQ7k+yKtbzVQc8yGI5VAHR7MMtwL98py/agAiWxJw20hzseuSp5EUcaod9W1mVWgmWfE44W66ZECJr0euQeTHBLG3pRqeaXliIT/Ev9D8DFQsMmHqTF3EQUTmaMbl+WSBRfAMsmuccfPf+9xeqh3KMOTrGu44E=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752556446; c=relaxed/simple;
	bh=uzlcZYjnRHjMyLLo28uvraRvCFfLUchPK2lwECNvWAI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dqMNANq5wDA0WzPLWzFR2D8woW1fkHXW/rThh0MdS+m3+9buCACh25d1CTwRBT9vtiIhdTpTEFrpBRczTwt8ofPaXFIRUT5ibfll94GNCNkdffCXSvZ8bIW1IRstGYpNoCCDdetl9yVX2LkRa74wiD4Sdk2FKv4YtQyPbTz9E7k=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WAJj8BLd; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WAJj8BLd; arc=fail smtp.client-ip=52.101.65.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qszstYoxR2XRuBdclhfMjGQCxZJHEsKGdjfl2hy7p5byASVgFLHDEBv3x0P2o6stAqoDxZyuf59ZYAev6XM0q12eWRpYOSaNnNUAGF32K0x06KIEotCqK5jqXbcoYbxznM+9b5vFoRrlBOOChr4S/Rh/0jPlxCCHJupq1LNZP4/5GUQxKIFhWKjZDvnbIk6ER7Krr8CNBxULEFJzMmwPG94l/pYXHTare4Q/lkbAstCT3yJU7U4xTRBnGqEPDn5b8x+uat23oGbo39uCltmtK2CUvakOeZ/z4Sid2Mqt9Yzd1pYZ4tUxQMZ3WNe/V9TQ+UYi40m6k5Pin48yzp+Vsg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtEqpHndy1W1HTiYGF+VZ4ZEy5wckxiNnM3gAiWMad8=;
 b=GTDlLwG3rKyrUEvsv+CgwIij8PcYbAv2ltXdu6qV/Cb9iujTQZT3SFq5hEUuwYKYZ4NeOvBIRp9pDwL0BTGJVnFmmATL56cXBOoS986+A50U2i9PyEWyb43VY6Z9/kFgSpJn+6Epb4mpen7U9IjKqnGQWvdM4R6xaX5KATtZd9O0jS/saBlAp+yRQWgwOFPTCvzHd6zzdE0eCg+4ECnW4uDYah995TEb3tcxTorwNH2gNGJ/rkeDjSSL/8m32ugxHH67v545WlG621nljBtbCF0NQPqYMPWbW3p1u7K4dvLPQY9yvkCT+GxAxgXWnk7VcusvmQVt9SssIZELe72kzA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtEqpHndy1W1HTiYGF+VZ4ZEy5wckxiNnM3gAiWMad8=;
 b=WAJj8BLdGNTlixOg8vuqMdmntpoL4dj2jZuKiepsfkdUSa+MrRx9Y1+w0pLTx/hZlfhM5qjRhWdQSGus/clJGfaQ3CKm0QmHrepdCPzCBuiqfqHkCotNFJJUqXHTvV2Y1nH1VWAxkS202F8YCCz3yRFQ10wCkHkVQRaiwvIIas0=
Received: from AS8PR04CA0090.eurprd04.prod.outlook.com (2603:10a6:20b:313::35)
 by DB9PR08MB8721.eurprd08.prod.outlook.com (2603:10a6:10:3d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 05:13:59 +0000
Received: from AMS1EPF00000041.eurprd04.prod.outlook.com
 (2603:10a6:20b:313:cafe::9b) by AS8PR04CA0090.outlook.office365.com
 (2603:10a6:20b:313::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Tue,
 15 Jul 2025 05:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000041.mail.protection.outlook.com (10.167.16.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Tue, 15 Jul 2025 05:13:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOiP9iBBK0SJeu1v4sdxCRjho3+X47Syj1YTsCnuZAZO2LMlNFndrZTGpCd7hk5ImYa2m0DcQpmlghdb9KtwojTDdrGLtVNIMCPdh0r6Ini2l7r/njPWAigw1I85vLWtlnJ/vVmoJWH+LaJ5Uyj7s+zM+5jLyuAKZbaYWVzZ7bfgPLzYgEpzRjxOTeP10us30DgM70FTTAAcc7Hvjx1jFuuzSjhjIeXqQ+pYM6UlORhf03308m5SMGEBxDpCrgfE4WgzXl1ze67LHpI8vZY5UrgpXviHGXG26CyY3F8PZ53TQyaZsLzhGjuO6aOZTTdGnkvR+9M0IlV43FzhyfMnlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtEqpHndy1W1HTiYGF+VZ4ZEy5wckxiNnM3gAiWMad8=;
 b=d3C0ZFcfjHTNwO54gpP62zmC2G2pQwhgrItW77gcFUUtkZu2T0JDdSVxVBWDIWGpvwRu7f+wbgcz6o69ZkOMu4hvlhMmEAzHQuSOUD0Vi57shmXNdwI2qpTgJoGyOcLY6RCSCGFSly7R8eaBOnJ+MiO6RzOPowxNQpsafhZT6yfznI48nSf1XB0Ed2qLBJkl65yeZr/vNqNnDI41ICWOYEY8BghZEXaqWEWID5UtFC7qd60jrS70IvLPVhuoWSluPHqKbObLPYqZ/66vPJFrW07ZhOnyF9XC4j0ANBiPWNxponk30inCKPsuJn2Q/2u/yjUXKb3gEBLj46pP1PC8wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtEqpHndy1W1HTiYGF+VZ4ZEy5wckxiNnM3gAiWMad8=;
 b=WAJj8BLdGNTlixOg8vuqMdmntpoL4dj2jZuKiepsfkdUSa+MrRx9Y1+w0pLTx/hZlfhM5qjRhWdQSGus/clJGfaQ3CKm0QmHrepdCPzCBuiqfqHkCotNFJJUqXHTvV2Y1nH1VWAxkS202F8YCCz3yRFQ10wCkHkVQRaiwvIIas0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DB3PR08MB8820.eurprd08.prod.outlook.com (2603:10a6:10:438::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 05:13:26 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 05:13:26 +0000
Message-ID: <cf0e85e7-8604-416a-bea6-0a59b5aaedd4@arm.com>
Date: Tue, 15 Jul 2025 10:43:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] arm64: mm: Simplify __TLBI_RANGE_NUM() macro
To: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
References: <20250711161732.384-1-will@kernel.org>
 <20250711161732.384-7-will@kernel.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250711161732.384-7-will@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0121.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::11) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DB3PR08MB8820:EE_|AMS1EPF00000041:EE_|DB9PR08MB8721:EE_
X-MS-Office365-Filtering-Correlation-Id: 9466dca4-7eca-4257-6a51-08ddc35e676e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?V1l5TmRobkJydXBRenNYSXl2am1WVno1aG5weEJCa3F2WUNkSFB1SFhhNVNJ?=
 =?utf-8?B?THlhMW1qaG9vaTI1VlRyaitLRmJ3YlpFblk2dHlkbXh5TWl1dEp1Z0FTSjlS?=
 =?utf-8?B?aTFxN2lUNlB0b0xubC9aRmZTVW5yNmtyQ2g1N2hRZ3RibDNxdGpma2NUOGo2?=
 =?utf-8?B?NmFFUEFxYytma3psU3JNZ3MwVXZ5R1hlZGgwTUdlYUhMdW5ON0FuVTJyVU5n?=
 =?utf-8?B?NnVtalI0RE8yeXpMSVdqeUdKN29XS2VDNUJDQ0pJWlpZdm5pRnFlbWZJSlJP?=
 =?utf-8?B?eWh3QUxIaDM2VTVPdVNmRkl2a0pVV2xDMjFZZThwbWM5SkVXa0ptM1NRbkNZ?=
 =?utf-8?B?QXRpMFJFQUNIcU1HNExEUUxib2cwQWpQTTBtVjI1bzZIRThGM0pHb3hDTDZW?=
 =?utf-8?B?NUlCY2hKcVpRMy9wVVk3SkVvbVgrcFNCcUdkZUJGblA2S09CQlV0aDdQcEFz?=
 =?utf-8?B?WUNaRGMrRHZsSzlNRlo1OHlyclpDVWlydTVVSzEzby9xNVZiSHd1SzM1NXQy?=
 =?utf-8?B?T3pOa000bFNGd2NmQjkwQi9NWUpUU3lZTzRCOXNwdHNhZXBpZmsxMWxzcC91?=
 =?utf-8?B?Y0xrSXN3RFF4WmpnNVZvNXBmaXp5WmVFMmMxcXNxWmlrQjhpenJLVWhWdCth?=
 =?utf-8?B?c2xkODJRRjZvSkdIa2RhMTVSYVB4eVYzRnI1UmMzZkdzN3lhUUROYWxQUTJo?=
 =?utf-8?B?S3ZROWhIak90cnM2QjdmY3pRVkwyZzBCcFY3OXk2QXlQUXJ3ZzB1R2NIWWpU?=
 =?utf-8?B?WEFIc1EraytXUUFGYUpsNkpqRUtMdDVybEx0WTFNQ1RpcmwrcFpNOS8zVURU?=
 =?utf-8?B?NURJNTBtWXM4OW5BVDYvUUM5ZlprMHcyRmJjUzBzZExFMWgvNnl1bGdnQ3Nh?=
 =?utf-8?B?anVTeVVya0J6L3ptSGcwMTlxWktTYmxhS1ZVdEJTUEpyclpzWkk5aUtUYXlO?=
 =?utf-8?B?MGV2dVptMVg4SldrckhiM1c0RmYwdi83VXUraFZWZ1N3Sld2RHZESzh6dE55?=
 =?utf-8?B?cEtFWVBtUlkxYTBLN01GU05Fb0NZVXg1YSs3RzBNTVd3RWlZQmJqUUlOZFhp?=
 =?utf-8?B?WDVkekxjckN2NDI3ait4cHl3UWU0ajhOUlN0TnJXVDl2R3JMeDJBTzM0eWhP?=
 =?utf-8?B?dGt1OE9mM3lEWE1Kc2VkUW93YVZPcTZUR2FmRmo2ZWY0VDBkR25qRnFTc3hq?=
 =?utf-8?B?WHJBZ2VGZzJteW5QNG5UNW1mcHJSZmN0bldOcENDVmdPTUM4WGg2YWErMGJN?=
 =?utf-8?B?aVVMa2syb3R5dUQyS0VIcmFjU2REclVEK0U3aHhSLzYvZW94NXIxVGpCU0Rk?=
 =?utf-8?B?KzlIaUlrK0grczFIUEd3a3FraGNMRXN4cUh6aWFMMHVIWmVvUUI0MjdjWjRw?=
 =?utf-8?B?L3VOak9rK2E0SkF6bk1wbUtSWDVycTJPUzZOS1AxVzJrRHNvNVVtanZvdjBn?=
 =?utf-8?B?RHpxMEJpMzBtUG41Skc3ZHI4UnRZMW1vdjVpVHplS1Q0UVNQK3dkNXFsZEZn?=
 =?utf-8?B?c05pVHh5Q1ZyOGJxendDeEdaNE5aN29NcGdYMDVCdjZGdUV6NFhkUUxRRG5L?=
 =?utf-8?B?c0lHcExmc2pCVVFjQXZuc1VRMUNZREJxMGhGd0hFcGRENVVBcUZzY3BlLzlC?=
 =?utf-8?B?eE96MFJTVTFsZVVjVTgxUzYzNGV6NUlrMFBMbVVNTlVKdGI1OFFuRnVVS0Zq?=
 =?utf-8?B?WlcxWFROZXZZV3hKV3ZOS1V4WkVjNkxoV0Nlczdqb2FjTHV2SFEwaFpsNkJ3?=
 =?utf-8?B?eWVGblpaNks1L1hwUU95di9JVElHclNYMmZLYitLdzA3UXpTVW9Vb2xGajRx?=
 =?utf-8?B?bTV3bGRQdDUwaTBsUGVyT0tYbnVjOWRCZDNEVWg5WDNQcEhOOUl4bjYxL25m?=
 =?utf-8?B?bmhMcHcrZ1ViVk8wNjNYWG9EZmZmcTRMcVZiQ0R0R0FSaGRmZCtMTTc1Mzhq?=
 =?utf-8?Q?qz3zhidSmgk=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB8820
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d9ce4854-6fd2-44cf-7b75-08ddc35e5405
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|14060799003|82310400026|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NCtLNFFpNEU3S2ZBNXg0ZFltZzdHVjlqVStXaXArK0dvWDRnaWZ1eHQyZ2ov?=
 =?utf-8?B?N0ZqdnZjK0I0dVNpaVdTaTVXQis0QUtkRlEySGdyTU9pOVMxa0hvZEZKY3hE?=
 =?utf-8?B?VnBRV2pha3FUR0hmNlltZW1jdzZJYm5uemJlc1Fqc1ljb2FPd3AxTzB5ZVg1?=
 =?utf-8?B?TFRNZW9lRmdhVzdIbVhhem1PbEpINDhNUTJsS1pDbEVOcTAyQzlDYk9VeDc0?=
 =?utf-8?B?UGdvc2NiS0dlT3FMQ0UxVVM0L1JLd2pLbEVMTHhLMVIwVEpJTFM0R1F3c3lC?=
 =?utf-8?B?QmVxOC9VbDhuZ2tESDRVamNHZHVhWDQ5c3RxSFUrNXBuSVZiN3JXNlFubnFY?=
 =?utf-8?B?dDRlemZ5U3V0c1JnTlpabkVtY2FFRjd5SDBSaDY3STFBeFpuUjlSUkhWdThv?=
 =?utf-8?B?MkVHYU8yMW5kY3pKaGIxR1AvZkw0N1dXZWQzdWcxM2hsVjJNYmI1K0RBMXM5?=
 =?utf-8?B?SStBcmtFWkpIemZRRUlOTlRaNWgwVDhwSGFNRXdydGwvRjhzZjhCdVZ2d1Fr?=
 =?utf-8?B?Y2dsWWNFcjJkTDdZaVY2STJSQng2ajBzV1JkT0hybXNCdWJaTnhGU2h5ZGs5?=
 =?utf-8?B?bDdYc1pvWDhjcFV2WnIwZ3ppT0NudzVnWGlCQ1NzU0RsRjB5RlFPd2kxSDJr?=
 =?utf-8?B?dDZiNThUMmh0RXZ2dlZTTzB2VVhHd0lCR0JlMktualVqbEo4VTlYVEhZTzdz?=
 =?utf-8?B?a0JBYWtjK21lUXFoYVZSeUdGaXJNNHVGREZmMTFRVXlMbHVEZHorWjBRNDMv?=
 =?utf-8?B?R3Y0cHNwSmtWRHl2aDVaeGFpL3VGTFJRSE4zNGtFN0E4Z0ZMN0lsVlI1Vkpn?=
 =?utf-8?B?MXZlc1Ira2xxdjVZS3NQMmJTcURVQy9pd3ZMY3QzL2VDYnZzelI4Qk1Ydzdt?=
 =?utf-8?B?S3JJNkl1R0dWS0QxUDZDeTJmMk5lUHdkN3ZTcHp2ZkptQVEzNTBGK2xzeENT?=
 =?utf-8?B?RXIxM1FyK2t0RWxRcFBJZjlJZGFONDl1WHQ2eTNlUXJwdFg2ZlNoR1dHTlBF?=
 =?utf-8?B?ak9WUFdGODlnK25nZUUxeVlZMFdUN2dVQkJOSXZCcUFnakVMaUU3MURIcUdO?=
 =?utf-8?B?ZUpmZW1TTTRycVErcEVRVmtKWUZockNrZ1ZTVDhHeUkyQUhwSmo5YWh5aFYy?=
 =?utf-8?B?ZVp6Z1JVaFZJVG5pb3JUYnN1SUtOZS9OQU9sd0VMc0MvY25wSFUwcExua3JM?=
 =?utf-8?B?ZEVOMlpUQVhXUmtqWWdWU0JFT2NsVEJUaWtIbEozaGFnRXFrNmVvcldHbkd0?=
 =?utf-8?B?cHpvaTZkVTd3dXFsWGJBTnBhSHozV2pGRndvWTlBWXU3M1RDMTR6NFdPWEtv?=
 =?utf-8?B?REFOUlNOOHFOY2YwblNncjFHSzBlWnFubUEwanJqMlp2cnU4dURhQ0wyN1N4?=
 =?utf-8?B?eGRvdzJ2TUFrcDVFTUR6SG15L2xvaGFDODVOMTFRY1cxSm5WYjFrNTVvM0Fi?=
 =?utf-8?B?MTlIKy96c2RTWlNCRVhnN2lxNzVxbHlRRGovcGVQeE0xdXI3N0xVR3FUS2lG?=
 =?utf-8?B?dE9oTDdhVU5TY3NEeWZ1WW1jZ2NyL3JZUjVsejJVYmQ3NjdOeDZoYlVVQWlQ?=
 =?utf-8?B?SFViVEx6b0JnSFEzNzVCc2xiUjk1Vklkd2VmT1BiSFBkWjhJaUVvOVNrYkgw?=
 =?utf-8?B?LytKeFFFNVdTeVZubEJCRWgrY29uck51bml4V09nV25xOEErTlBzcUtlYjl0?=
 =?utf-8?B?dmJYL3gzNVRpY2NmZTlMallpK0FPOFlzaXM1V1FoMFpKMk1uU0txWms3MDJQ?=
 =?utf-8?B?RldiczJDR1gycTVqRjFXZlZPUEpEc3JsdXo0WE1GMlh5WXNDQkwvUWZoZWRW?=
 =?utf-8?B?L0tPclhHckE4YTFQVktlZGkxMy9FcmlHVVVsV0V4TDRxamxQcFpheGZoeWtX?=
 =?utf-8?B?TkpaRGtteGZEMU5DTW1wY1ArTVRVZjlFTHdKYjhRR2h4UGVYV05reEdXK0NN?=
 =?utf-8?B?YnBUbEl1bE1YdzRBTWpXQ2tSVW9kb09GTmxSRWNEYnZUbXNxVVJCbWxnVVRs?=
 =?utf-8?B?WS9ncVdyczdUbHpCK2VvSy80dzFrZTE0cnpycHcraVV3aXREU29ZdWZtL0dF?=
 =?utf-8?Q?KIESGR?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(14060799003)(82310400026)(36860700013)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 05:13:58.5187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9466dca4-7eca-4257-6a51-08ddc35e676e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8721


On 11/07/25 9:47 pm, Will Deacon wrote:
> Since commit e2768b798a19 ("arm64/mm: Modify range-based tlbi to
> decrement scale"), we don't need to clamp the 'pages' argument to fit
> the range for the specified 'scale' as we know that the upper bits will
> have been processed in a prior iteration.
>
> Drop the clamping and simplify the __TLBI_RANGE_NUM() macro.
>
> Signed-off-by: Will Deacon <will@kernel.org>

Just for the sake of it:

It is easy to check that for natural numbers x and y,

x < (((x >> y) + 1) << y)

This implies x < ((x >> y) << y) + (1 << y)
=> x - ((x >> y) << y) < (1 << y)

Substitute x as pages, and y as 5 * scale + 1, the
inequation means that after the first iteration, the
new value of pages will be strictly less than 1 << (5 * scale + 1)
=> the current scale won't be repeated => the min is redundant.

Reviewed-by: Dev Jain <dev.jain@arm.com>

> ---
>   arch/arm64/include/asm/tlbflush.h | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index ddd77e92b268..a8d21e52ef3a 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -205,11 +205,7 @@ static __always_inline void __tlbi_level(const enum tlbi_op op, u64 addr, u32 le
>    * range.
>    */
>   #define __TLBI_RANGE_NUM(pages, scale)					\
> -	({								\
> -		int __pages = min((pages),				\
> -				  __TLBI_RANGE_PAGES(31, (scale)));	\
> -		(__pages >> (5 * (scale) + 1)) - 1;			\
> -	})
> +	(((pages) >> (5 * (scale) + 1)) - 1)
>   
>   /*
>    *	TLB Invalidation

