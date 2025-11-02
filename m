Return-Path: <linux-kernel+bounces-881825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC0EC2902F
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 15:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2659C188D882
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 14:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B012B22422D;
	Sun,  2 Nov 2025 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="llrfeenl"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012053.outbound.protection.outlook.com [40.93.195.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C835C34D3A0;
	Sun,  2 Nov 2025 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762093517; cv=fail; b=O0Q0V90gz+04aNX7p4BWn8fVTWlmUz9841JARFFAW5nQy3pjrTOJXXSEUgodfwtHbGSjy0JtdPBOFj5afUwpjHZwvx8apPOrzA9lW/i0jHyNwhXSnAyqtFSIl+WYgv8jmpJVyvUTCXVQGYg/uMet9nBIoZzWK+ZiQOiFJHS0lbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762093517; c=relaxed/simple;
	bh=zbboSyRfjjV3Fmd0/YwB+e4Og3YSayeSXX7Gya8tycU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ByLLIMaVkvNHEoWyZEFqeuC8YdB7IabC2EATLOeto43QQr6vFKCyLPf/IAI90F+I0RQd/nQdfg6bvp+XLDfunQX85uJyzJjAg5gXb5TAXJkfDGvdsLaGjQXYLSGVuaR2bCq8YdRoLbCE27NWUUAqJrAi6xvVxMvbEER1s8IheYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=llrfeenl; arc=fail smtp.client-ip=40.93.195.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crkk5b2eC+oePSRgylANlVQ1L6ShtBVmX2qfKLmHVBczZQnYyxvAeX/zLpmlmguiWMxn+PfGpLJMt4RtecrVMlmoGVNCe66xoVA+3GpAibIMus2GVNrZBOzz2GF1xyf9FzEdEPdXZmtLVVoEDC4Z7s+HqYYB6JAJsGJh8h6820tyEAeevR+f7wEkUxaPKc9EEvhqnrj6NVxe6CcRKwvK3/7o4trWSsHELW1ZuRezyNX9/qHR27XlzGhcPIhszmTvsLkfc4zsmY+2j+PsyxtE/2OgnIqVmm7wh57LvnV5G6oa1Hk4RQPVYjYk4VAgrCOvkyeYNaXpqwANcS8Y5kQpLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJKAkwRN8ZIPrpmXlO1m3kWfPPrqCjRQdU86seNj1CY=;
 b=msHHA/cncak/SOMH/fbDwrKv4VVt2QSi2OzVhrf4bcgG0xiVwudP9sIFC6EC6cScHREnSBEfqh42Oe0/ILmHVbbdvjwqxT7Zt30qPys+iFYrgEgj+HCIE0383SkgkS6uI0pPgHrJIsUwRbIB712HDpJWx3hapV9zuhExfnxsp4DjcI78eG5IYv52dXmdjs5KAF2aKqzohbnvu1hjVWpiVnRAuhhquZIVI9e8mL8ees2m3QJ3Fs5tqGmOpgZ7WLMbHxDSmZKrkZD+2BeWVJVa8L1rTjpoigDyRkjNE9Tv+YMnYuTRKz7+7gDHXU2dEv6stjzSIqwKNT9W1wvCjLA5/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJKAkwRN8ZIPrpmXlO1m3kWfPPrqCjRQdU86seNj1CY=;
 b=llrfeenlvXeGkbGBvK1wPWHgQXBtpwvuRg42T8MHQKXj6y3PNbDjbu2MqIqwgS8hFQ0IwcV04ZsDJ4KEXWVljVr27qYJwJTyKW8tt3+Aoq/O7ktiO+ocCIY9N/ewsAe62XOr1p2/JtW8DIGiVjlI02dAgSdOCMdbFRPcvPZUUatcGIua+kTQfuh/CApkHqyo/fs3C4azfGK6gwY6DdLhYk2PuUN+VFaBmTA7AJE9ybsm49HzPeKGpcI4tUtB2WApzQums3z/iMr9rAkCyXmAOVLbhQT2NtGs+e5mzsCWbAnlVbBvTl/POoXtmul3drXOLlJYiHIrIZfH+o6iizPYEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB7158.namprd12.prod.outlook.com (2603:10b6:510:22a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sun, 2 Nov
 2025 14:25:05 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.013; Sun, 2 Nov 2025
 14:25:04 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 02 Nov 2025 23:24:42 +0900
Subject: [PATCH v2 1/2] rust: add BitInt integer wrapping type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251102-bounded_ints-v2-1-7ef0c26b1d36@nvidia.com>
References: <20251102-bounded_ints-v2-0-7ef0c26b1d36@nvidia.com>
In-Reply-To: <20251102-bounded_ints-v2-0-7ef0c26b1d36@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0071.jpnprd01.prod.outlook.com
 (2603:1096:405:370::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: df69ae45-deb0-4e02-e1fa-08de1a1b9d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tkp6QWJ0VHZvU2RYNE5JamVoRDJiQldrcHZvcjhBbnBiQXJFamdJZ1l3K0No?=
 =?utf-8?B?RDUrcmd3cThJTjFucEY3ZWUvSDJGR3NTTlo1OXNhL1MvUzV2dEpOd0tDZ3RQ?=
 =?utf-8?B?eWVxQ2ZrbzJvbDc3MjdOUnVHMjJPTkFISTZMRDFuRWRpNlRVaU1XUGZyTTE5?=
 =?utf-8?B?U3c3Lzc4ZWNYYU5tblZBb0h0U0hXeWZyYXVsVHI2M1kwTGFaWTlwTU9pUXpl?=
 =?utf-8?B?R0Y0eEJ5T3lDT3BDdXMvLzh1TSs4MWI5aW5MVDIyTG5xMjd1VW9GWUlJQStH?=
 =?utf-8?B?RUM4YnZIcE9oUjRBeFhzcm9SQ2dxbXhSWFlJcGZBMUQ0RjgxVllKRzkyWWtD?=
 =?utf-8?B?V1h1eDR6M0NUTFFUMTllL1BPbm1aQ2R0b2dBbndHc3pUeGJBRGhJNk42bmN4?=
 =?utf-8?B?WEx3aVIvRUV3ZitkWFFRQXNmWDNmVFZQWTN6QXJKK3A5eTZpb2wyU0lIbEJH?=
 =?utf-8?B?emFnTkFHck51VkFEREoydFFBWi9Md3BaVXljTnlzQmhRN2RVTE9KN1JEQko0?=
 =?utf-8?B?QXNhOGFiVVdGSS9LY3RrMzJWa09PeUtqKzhjZCtjZXc5UnJ0ZDhtVWtERFM2?=
 =?utf-8?B?RjNZTUVEa2lUTlVYeFhlb1VhclFXWFozdysyUCtycmorTDdPSnpsMlgyRU5M?=
 =?utf-8?B?L2d4eTFCZG56YVNTOEd2bGZjTjFuejEvVTluakRVN3doUDJzZnJwdExVQ3Zk?=
 =?utf-8?B?bFg4WGVMMzE1cW5lVEVzd3J2U3VPbWFGOXJxWnhHa01Ta1hkRFhTRmJUNEZi?=
 =?utf-8?B?am1zTDNDZndEOXFKaWxTZGNHdnF5Z0w3L3NZUTZIdWdjQjh4MmZobkVwSE9K?=
 =?utf-8?B?RlBhL0Yvd1p5QURNRFRZbXpOVXR3bEJHSnpPYlRzQkhPZGZvYXBoTW9yRFJN?=
 =?utf-8?B?MVBZVGZQci9yZ2pvNzRNdXFvL1NkcXhGYllSdmJzemdLYnZ1SUtoTmtMZkkz?=
 =?utf-8?B?NmFlWTlhMU1HMjJOSW9oaXBnVUg2QnJQZXFRVDdFbEdhdHRSZURMWFUxbFha?=
 =?utf-8?B?aitFVFNqS1Yzejd2OVFkeUVNS2c1ckpwRFhZMmNPMFdodXN6ZnpRcHB4cDZ1?=
 =?utf-8?B?T0t5WElBWlZvUUhjeWxHSHB6T3ptL1lJUHNzZzlINDBTeWZjS1BZOWlSRGpO?=
 =?utf-8?B?YkxYcVN0cERHVVRFaTNkM0NITDJJaWVFUCttWTFseFRDaE5aNVc5dDlhUDd0?=
 =?utf-8?B?ekt2M1hwWWliR1I5TTJzaXMyRXBnSFllcHVZdE5uU1BjUklsMXFlR1JBVTdh?=
 =?utf-8?B?S09wY0pITVNUS3g4bVdBYnEwR3hzbnc2L2YvQTRZTHZFREVLbXFBRmRocWpn?=
 =?utf-8?B?Q1hOeTFOdW45WTVZUzIrTmI0MVZqZFZjemlobzlZUFZKSk9LcU5HekEvQ1JZ?=
 =?utf-8?B?ckZiZHdtNk5xcGk1N0FiWjdqLzMxTFVIQ2dzQ05jaE9HRXpkdVBQZzR1L3ph?=
 =?utf-8?B?SlppUThyMU5uckcrVktEeE04eitBTSs4WUtybHR6OTFGUGh3WDA4cWdxOUpl?=
 =?utf-8?B?SXlLeVA0aWsxZHBYL1laVS9qYlpmSkkvS3pZVTVBdE91cWNINHdab3VEanox?=
 =?utf-8?B?YWlCSUl4dVE4K1lZUm1CMUpQeEVZUzFRL2diU1FSNEEyTHl0cW1lMXhiOHMy?=
 =?utf-8?B?U2JLdnRVaTczL08yMjdZOHp0NXhJS3pqY2ZRMmZ0Qi96ZThFQ2RsYzdhNUhI?=
 =?utf-8?B?ZjRmVmZKbnRHakNOSno2cTFZeXVnU1E3ekJmUHYvMUJtRjVkamtNSWxWUjVH?=
 =?utf-8?B?aWdDdU8ybDJ4SHBEYjFkZ3kzUmlVWW1mSWRDd2dkU3BkYm1BaFROdVlNL1B3?=
 =?utf-8?B?eGNUbWNyTW1GMVl0QXdza1AzczJ1NTlHcytYS0VObTczSnZQOVpFbFpZR2Yx?=
 =?utf-8?B?RkphY3QrTkNoMXNNQ2tneWRqaDVTenlORW92N214bm54cmNkQjA0YWNzb05W?=
 =?utf-8?B?Q29PVG4xeloyTHhrL1NQY3dYcVlFVW1oblVXSmRzTzF0Zm1qeE9ZTzJ1Nlpq?=
 =?utf-8?Q?M79ZsYx9jLq0as5hSHDBpQ7GoMUAM0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGF4cC9WSS9ZR2w4WWlaVlZYVjBveVkrNFhUTGl4VGRSMHBWNjc4bVFnSzdw?=
 =?utf-8?B?dFYva2NGMC9OVGdzc21HdlNSQ01pcExGYklvNnZydC9NY2JUeFJaNklkKzlO?=
 =?utf-8?B?VmFibTA2VVVmQVpmN1RyN2hRNnJJRWphL0E0dk1aMFZNc3J6ZlFrN2p0NEN5?=
 =?utf-8?B?b2ovWGpXV1JVaEVObnkvVkdnendBQlBkbTdCN2VuUTdFRDgybWpPZ3NXY2c2?=
 =?utf-8?B?ZHJVVlBWYTZvRkRCNzFUb2R3UGlLZ1FoT25zSC8xeC9KNWlkdjZUTi9EcGNm?=
 =?utf-8?B?UE9hSmxhcWhjNHgvQlFEbytrUUh0TnBJTEszNkNXUGlCYnlxTklmY2xwT0ho?=
 =?utf-8?B?djYwSVRZLzEwZXFzc21FV2xYa29xWFl5Qlh3NEs0NFR2ODF2RnpvWlQ1QXFD?=
 =?utf-8?B?bC9HUVpKZWN2aEhjYTloVVZzV0NzcVFWVGV3ajdjMGdLMEdPU284eXlmMUJX?=
 =?utf-8?B?bFlPUCtzbmVZcDZxSjdSejZpUkdIT24xOHhLSG9oS091QVhTa0tMSDZuektR?=
 =?utf-8?B?TWV6ZGlUbnlLdUVTbHhWT3lCbEhna3FEeVBxTUgreHBPcEZMUkV4Y1liUmdV?=
 =?utf-8?B?ak9JMDNGaDExZitxdk9mM3dlbFlVY1p5NmtiT2VxSThKMnpTSlIyVm85NXFo?=
 =?utf-8?B?c2tOTDB3VzRRY1dzV25mYUY2WlVKbG9zT0tib2xzMGVtUzh1SXZ4Z0hlbzhN?=
 =?utf-8?B?Mk1Bei9WTVlCbjZnbzFXMEc3dDhNT3lCQm84WjlYbitaN2hoZ01HR0RlL2t4?=
 =?utf-8?B?R3FSUFcwZ2V2UTFLOVlFTGZqYTUyMDB2TFlsR1VUWWxZMTltbVB1clpFNHlp?=
 =?utf-8?B?bUtyNFNNZGFrcCt5bXltd3NPRlRZbFMxQmdaMXd2Z1ovc01PdEpNOFRSQ2Nr?=
 =?utf-8?B?WkIwcUVXS2IvTTVZMko5eTZHdWYwbStiYU5pSDZQbmJNSjg0dHpXelRIaGUw?=
 =?utf-8?B?S21TQ1d6NmN4K09pMUxqNkFkS2ZNSXlBTWVpNVdHVjBsQjJINHBZY3ZEQkpN?=
 =?utf-8?B?SUhZMzJKUTdoQUVCdkN0TUkyWVBTamhXQ1NuQURYU0tOd1VObVRzUkI1bDhC?=
 =?utf-8?B?Ukt0ZUcvL2g0VkdCaTd1NUR3Y1hZNnI2OW1TRk42aEV1em52WFNlcFBWb1VN?=
 =?utf-8?B?eExUV0VzaC9RaWJucFZPOUwrZzlRUEJjZDg1V1htNHFZRCsyd003RWVzL2xZ?=
 =?utf-8?B?aFFUN3h2K0ZEZzJiTVk0bmRGcmU4aEMxaFlrT2V1YTNtK2E4a2w1Y3RrN09B?=
 =?utf-8?B?Q3R3QjlzZUtNN0JRKzhBTXB4eDNScjFiWC9iYmlETEZTbEtvTlJxZ3RhbHJt?=
 =?utf-8?B?QytXTmhjQktSTjl6SUJjS29nMll4Wk9GTEE1Q09McTJzWUYyMmp0aWJDS3dP?=
 =?utf-8?B?Yi9lR2VhYkhlUzErVlhEQ0pFK2VIOWU4WDQ0ZG9HWTZVUHVMeFpEUmdIZ2Rl?=
 =?utf-8?B?anNzU09ZSzQ1WEVWZTVBVWlLTEVja3NuNVlGZ1VnSnAvQzZOc1FEbzkxZSs0?=
 =?utf-8?B?Y0IzcFBraEVDRmphQit3dGZ0aFQ0UERlMU4wNUMrRWh4aEhybjBiMFhXMjhk?=
 =?utf-8?B?WTBQNVRxT0tITit4NnNvd3djYjFmUnp0Wm9CK2xxZVRhVksyRzlKdzNVOGlB?=
 =?utf-8?B?RjByVzhNZCtMOW1wR2NVYk1XNmJnK3FHc2oycXV2RklqVk9ZNDRFTDFLaGdu?=
 =?utf-8?B?STdoV2dzUXpXQW9TRU1rTnFzTmkya1NQbmM2aytNM0YxcGhKMC9mOUozUVpt?=
 =?utf-8?B?Rk8vUkRZUEZMWVBiQ295N1M0Y0xPSE5tK3Y1Vll2bTQ4aytoV3p6cTZmY2Qy?=
 =?utf-8?B?aVVocmVpcU1OMHd1WXF6U2t1MFM2TU9tU2tHS29wbDdMajliaU1mN0QxTjRW?=
 =?utf-8?B?YTJqOHl3Z3oxd3A2SjdnZ2U5aVpOOW5aanBRaW0wa2xxblBhMnk2ZnhURU1L?=
 =?utf-8?B?dTRMcWpMMEFMNUc0eFFkOHNLV1NKTk4zMmRkaVVCZTM5S1ZDbmY3dlF6OVFS?=
 =?utf-8?B?b1NLdmRsS1FuSGNNditoOWZVblNWcktndTg1N2lZOHBGTmR5cEMzSnZKMFdo?=
 =?utf-8?B?Sm1TelQycGV4NlhVMFpJYXhPc2lzK3hMR0tmaldFeWxYQ092ekk3WVI4aDg1?=
 =?utf-8?B?Qlc2d3NpYVF5RkJ5cjluR0o4ejNRb0FMNDd4c1hPcFBiZEdwS0o3b2hPR1dD?=
 =?utf-8?Q?7wB3FIWcTieKCFCLXve9g6ecIM9N4z0DwjoYj62VQGAB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df69ae45-deb0-4e02-e1fa-08de1a1b9d8b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2025 14:25:04.5927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfnDlQhSDDmzIHICC4dCtN1BwfDHY4quVhn5cmU1JjXZDw+GnjjQkj3NxETARQ/9IZCkeZ2GMKVW8hUXitp3ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7158

Add the `BitInt` type, which is an integer on which the number of bits
allowed to be used is restricted, capping its maximal value below that
of primitive type is wraps.

This is useful to e.g. enforce guarantees when working with bit fields.

Alongside this type, provide many `From` and `TryFrom` implementations
are to reduce friction when using with regular integer types. Proxy
implementations of common integer traits are also provided.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/lib.rs        |    1 +
 rust/kernel/num.rs        |   50 +++
 rust/kernel/num/bitint.rs | 1001 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1052 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 3dd7bebe7888..235d0d8b1eff 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -109,6 +109,7 @@
 pub mod mm;
 #[cfg(CONFIG_NET)]
 pub mod net;
+pub mod num;
 pub mod of;
 #[cfg(CONFIG_PM_OPP)]
 pub mod opp;
diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
new file mode 100644
index 000000000000..21a4b8e14098
--- /dev/null
+++ b/rust/kernel/num.rs
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Numerical features for the kernel.
+
+pub mod bitint;
+pub use bitint::*;
+
+/// Type used to designate unsigned primitive types.
+pub struct Unsigned;
+
+/// Type used to designate signed primitive types.
+pub struct Signed;
+
+/// Trait describing properties of integer types.
+pub trait Integer {
+    /// Whether this type is [`Signed`] or [`Unsigned`].
+    type Signedness;
+
+    /// Number of bits used for value representation.
+    const BITS: u32;
+}
+
+impl Integer for bool {
+    type Signedness = Unsigned;
+
+    const BITS: u32 = 1;
+}
+
+macro_rules! impl_integer {
+    ($($type:ty: $signedness:ty), *) => {
+        $(
+        impl Integer for $type {
+            type Signedness = $signedness;
+
+            const BITS: u32 = <$type>::BITS;
+        }
+        )*
+    };
+}
+
+impl_integer!(
+    u8: Unsigned,
+    u16: Unsigned,
+    u32: Unsigned,
+    u64: Unsigned,
+    i8: Signed,
+    i16: Signed,
+    i32: Signed,
+    i64: Signed
+);
diff --git a/rust/kernel/num/bitint.rs b/rust/kernel/num/bitint.rs
new file mode 100644
index 000000000000..9228c1da7733
--- /dev/null
+++ b/rust/kernel/num/bitint.rs
@@ -0,0 +1,1001 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! [`BitInt`], a primitive integer type with a limited set of bits usable to represent values.
+
+use core::ops::Deref;
+
+use kernel::num::Integer;
+use kernel::prelude::*;
+
+/// Evaluates to `true` if `$value` can be represented using at most `$num_bits` on `$type`.
+///
+/// Can be used in const context.
+macro_rules! fits_within {
+    ($value:expr, $type:ty, $num_bits:expr) => {{
+        let shift: u32 = <$type>::BITS - $num_bits;
+
+        // The value fits within `NUM_BITS` if shifting it left by the number of unused bits,
+        // then right by the same number, doesn't change the value.
+        //
+        // This method has the benefit of working with both unsigned and signed integers.
+        ($value << shift) >> shift == $value
+    }};
+}
+
+/// Trait for primitive integer types that can be used to back a [`BitInt`].
+///
+/// This is mostly used to lock all the operations we need for [`BitInt`] in a single trait.
+pub trait Boundable
+where
+    Self: Integer
+        + Sized
+        + Copy
+        + core::ops::Shl<u32, Output = Self>
+        + core::ops::Shr<u32, Output = Self>
+        + core::cmp::PartialEq,
+    Self: TryInto<u8> + TryInto<u16> + TryInto<u32> + TryInto<u64>,
+    Self: TryInto<i8> + TryInto<i16> + TryInto<i32> + TryInto<i64>,
+{
+    /// Returns `true` if `value` can be represented with at most `NUM_BITS` on `T`.
+    fn fits_within(value: Self, num_bits: u32) -> bool {
+        fits_within!(value, Self, num_bits)
+    }
+}
+
+/// Implement `Boundable` for all integer types.
+impl<T> Boundable for T
+where
+    T: Integer
+        + Sized
+        + Copy
+        + core::ops::Shl<u32, Output = Self>
+        + core::ops::Shr<u32, Output = Self>
+        + core::cmp::PartialEq,
+    Self: TryInto<u8> + TryInto<u16> + TryInto<u32> + TryInto<u64>,
+    Self: TryInto<i8> + TryInto<i16> + TryInto<i32> + TryInto<i64>,
+{
+}
+
+/// Integer type for which only the `NUM_BITS` less significant bits can ever be set.
+///
+/// # Invariants
+///
+/// - `NUM_BITS` is greater than `0`.
+/// - `NUM_BITS` is less or equal to `T::BITS`.
+/// - Stored values are represented with at most `NUM_BITS` bits.
+///
+/// # Examples
+///
+/// The preferred way to create values is through constants and the [`BitInt::new`] family of
+/// constructors, as they trigger a build error if the type invariants cannot be withheld.
+///
+/// ```
+/// use kernel::num::BitInt;
+///
+/// // An unsigned 8-bit integer, of which only the 4 LSBs can ever be set.
+/// // The value `15` is statically validated to fit that constraint at build time.
+/// let v = BitInt::<u8, 4>::new::<15>();
+/// assert_eq!(v.get(), 15);
+///
+/// // Same using signed values.
+/// let v = BitInt::<i8, 4>::new::<-8>();
+/// assert_eq!(v.get(), -8);
+///
+/// // This doesn't build: a `u8` is smaller than the requested 9 bits.
+/// // let _ = BitInt::<u8, 9>::new::<10>();
+///
+/// // This also doesn't build: the requested value doesn't fit within 4 signed bits.
+/// // let _ = BitInt::<i8, 4>::new::<8>();
+/// ```
+/// Values can also be validated at runtime with [`BitInt::try_new`].
+///
+/// ```
+/// use kernel::num::BitInt;
+///
+/// //  This succeeds because `15` can be represented with 4 unsigned bits.
+/// assert!(BitInt::<u8, 4>::try_new(15).is_some());
+/// // This fails because `16` cannot be represented with 4 unsigned bits.
+/// assert!(BitInt::<u8, 4>::try_new(16).is_none());
+/// ```
+///
+/// Non-constant expressions can be validated at build-time thanks to compiler optimizations. This
+/// should be used as a last resort though.
+///
+/// ```
+/// use kernel::num::BitInt;
+/// # fn some_number() -> u32 { 0xffffffff }
+///
+/// // Here the compiler can infer from the mask that the type invariants are not violated, even
+/// // though the value returned by `some_number` is not known.
+/// let v = BitInt::<u32, 4>::from_expr(some_number() & 0xf);
+/// ```
+///
+/// [`BitInt`]s can be compared regardless of their number of valid bits, as long as their backing
+/// types can be compared.
+///
+/// ```
+/// use kernel::num::BitInt;
+///
+/// let v1 = BitInt::<u32, 8>::new::<4>();
+/// let v2 = BitInt::<u32, 4>::new::<15>();
+///
+/// assert!(v1 != v2);
+/// assert!(v1 < v2);
+/// ```
+///
+/// Common integer operations are supported between a [`BitInt`] and its backing type.
+///
+/// ```
+/// use kernel::num::BitInt;
+///
+/// let v = BitInt::<u8, 4>::new::<15>();
+///
+/// assert_eq!(v + 5, 20);
+/// assert_eq!(v / 3, 5);
+/// assert!(v == 15);
+/// assert!(v > 12);
+/// ```
+///
+/// Conversion is possible between backing types using [`BitInt::cast`], and the number of valid
+/// bits can be extended or reduced with [`BitInt::extend`] and [`BitInt::try_shrink`].
+///
+/// ```
+/// use kernel::num::BitInt;
+///
+/// let v = BitInt::<u32, 12>::new::<127>();
+///
+/// // Changes backing type from `u32` to `u16`.
+/// let _: BitInt<u16, 12> = v.cast();
+///
+/// // This does not build, as `u8` is smaller than 12 bits.
+/// // let _: BitInt<u8, 12> = v.cast();
+///
+/// // We can safely extend the number of bits...
+/// let _ = v.extend::<15>();
+///
+/// // ... to the limits of the backing type. This doesn't build as a `u32` cannot contain 33 bits.
+/// // let _ = v.extend::<33>();
+///
+/// // Reducing the number of bits is validated at runtime. This works because `127` can be
+/// // represented with 8 bits.
+/// assert!(v.try_shrink::<8>().is_some());
+///
+/// // ... but not with 6, so this fails.
+/// assert!(v.try_shrink::<6>().is_none());
+/// ```
+///
+/// Infallible conversions from a primitive integer to a large-enough [`BitInt`] are supported.
+///
+/// ```
+/// use kernel::num::BitInt;
+///
+/// // This unsigned `BitInt` has 8 bits, so it can represent any `u8`.
+/// let v = BitInt::<u32, 8>::from(128u8);
+/// assert_eq!(v.get(), 128);
+///
+/// // This signed `BitInt` has 8 bits, so it can represent any `i8`.
+/// let v = BitInt::<i32, 8>::from(-128i8);
+/// assert_eq!(v.get(), -128);
+///
+/// // This doesn't build, as this 6-bit `BitInt` does not have enough capacity to represent a
+/// // `u8` (regardless of the passed value).
+/// // let _ = BitInt::<u32, 6>::from(10u8);
+///
+/// // Booleans can be converted into single-bit `BitInt`s.
+///
+/// let v = BitInt::<u64, 1>::from(false);
+/// assert_eq!(v.get(), 0);
+///
+/// let v = BitInt::<u64, 1>::from(true);
+/// assert_eq!(v.get(), 1);
+/// ```
+///
+/// Infallible conversions from a [`BitInt`] to a primitive integer is also supported, and
+/// dependent on the number of bits used for value representation, not on the backing type.
+///
+/// ```
+/// use kernel::num::BitInt;
+///
+/// // Even though its backing type is `u32`, this `BitInt` only uses 6 bits and thus can safely
+/// // be converted to a `u8`.
+/// let v = BitInt::<u32, 6>::new::<63>();
+/// assert_eq!(u8::from(v), 63);
+///
+/// // Same using signed values.
+/// let v = BitInt::<i32, 8>::new::<-128>();
+/// assert_eq!(i8::from(v), -128);
+///
+/// // This however does not build, as 10 bits won't fit into a `u8` (regardless of the actually
+/// // contained value).
+/// let _v = BitInt::<u32, 10>::new::<10>();
+/// // assert_eq!(u8::from(_v), 10);
+///
+/// // Single-bit `BitInt`s can be converted into a boolean.
+/// let v = BitInt::<u8, 1>::new::<1>();
+/// assert_eq!(bool::from(v), true);
+///
+/// let v = BitInt::<u8, 1>::new::<0>();
+/// assert_eq!(bool::from(v), false);
+/// ```
+///
+/// Fallible conversions from any primitive integer to any [`BitInt`] are also supported using the
+/// [`TryIntoBitInt`] trait.
+///
+/// ```
+/// use kernel::num::{BitInt, TryIntoBitInt};
+///
+/// // Succeeds because `128` fits into 8 bits.
+/// let v: Option<BitInt<u16, 8>> = 128u32.try_into_bitint();
+/// assert_eq!(v.as_deref().copied(), Some(128));
+///
+/// // Fails because `128` doesn't fits into 6 bits.
+/// let v: Option<BitInt<u16, 6>> = 128u32.try_into_bitint();
+/// assert_eq!(v, None);
+/// ```
+#[repr(transparent)]
+#[derive(Clone, Copy, Debug, Default, Hash)]
+pub struct BitInt<T: Boundable, const NUM_BITS: u32>(T);
+
+/// Validating the value as a const expression cannot be done as a regular method, as the
+/// arithmetic operations we rely on to check the bounds are not const. Thus, implement
+/// [`BitInt::new`] using a macro.
+macro_rules! impl_const_new {
+    ($($type:ty)*) => {
+        $(
+        impl<const NUM_BITS: u32> BitInt<$type, NUM_BITS> {
+            /// Creates a [`BitInt`] for the constant `VALUE`.
+            ///
+            /// Fails at build time if `VALUE` cannot be represented with `NUM_BITS`.
+            ///
+            /// This method should be preferred to [`Self::from_expr`] whenever possible.
+            ///
+            /// # Examples
+            /// ```
+            /// use kernel::num::BitInt;
+            ///
+            #[doc = ::core::concat!(
+                "let v = BitInt::<",
+                ::core::stringify!($type),
+                ", 4>::new::<7>();")]
+            /// assert_eq!(v.get(), 7);
+            /// ```
+            pub const fn new<const VALUE: $type>() -> Self {
+                // Statically assert that `VALUE` fits within the set number of bits.
+                const {
+                    build_assert!(fits_within!(VALUE, $type, NUM_BITS));
+                }
+
+                // INVARIANT: `fits_within` confirmed that `value` can be represented within
+                // `NUM_BITS`.
+                Self::__new(VALUE)
+            }
+        }
+        )*
+    };
+}
+
+impl_const_new!(u8 u16 u32 u64);
+impl_const_new!(i8 i16 i32 i64);
+
+impl<T, const NUM_BITS: u32> BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+{
+    /// Private constructor enforcing the type invariants.
+    ///
+    /// All instances of [`BitInt`] must be created through this method as it enforces most of the
+    /// type invariants.
+    ///
+    /// The caller remains responsible for checking, either statically or dynamically, that `value`
+    /// can be represented as a `T` using at most `NUM_BITS` bits.
+    const fn __new(value: T) -> Self {
+        // Enforce the type invariants.
+        const {
+            // `NUM_BITS` cannot be zero.
+            build_assert!(NUM_BITS != 0);
+            // The backing type is at least as large as `NUM_BITS`.
+            build_assert!(NUM_BITS <= T::BITS);
+        }
+
+        Self(value)
+    }
+
+    /// Attempts to turn `value` into a `BitInt` using `NUM_BITS`.
+    ///
+    /// Returns [`None`] if `value` doesn't fit within `NUM_BITS`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::num::BitInt;
+    ///
+    /// let v = BitInt::<u8, 1>::try_new(1);
+    /// assert_eq!(v.as_deref().copied(), Some(1));
+    ///
+    /// let v = BitInt::<i8, 4>::try_new(-2);
+    /// assert_eq!(v.as_deref().copied(), Some(-2));
+    ///
+    /// // `0x1ff` doesn't fit into 8 unsigned bits.
+    /// let v = BitInt::<u32, 8>::try_new(0x1ff);
+    /// assert_eq!(v, None);
+    ///
+    /// // `8` doesn't fit into 4 signed bits.
+    /// let v = BitInt::<i8, 4>::try_new(8);
+    /// assert_eq!(v, None);
+    /// ```
+    pub fn try_new(value: T) -> Option<Self> {
+        T::fits_within(value, NUM_BITS).then(|| {
+            // INVARIANT: `fits_within` confirmed that `value` can be represented within `NUM_BITS`.
+            Self::__new(value)
+        })
+    }
+
+    /// Checks that `expr` is valid for this type at compile-time and build a new value.
+    ///
+    /// This relies on [`build_assert!`] and guaranteed optimization to perform validation at
+    /// compile-time. If `expr` cannot be proved to be within the requested bounds at compile-time,
+    /// use the fallible [`Self::try_new`] instead.
+    ///
+    /// Whenever possible, use one of the [`Self::new`] constructors instead of this one as it
+    /// statically validates `expr` instead of relying on compiler optimizations.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::num::BitInt;
+    ///
+    /// # fn some_number() -> u32 { 0xffffffff }
+    ///
+    /// // Some undefined number.
+    /// let v: u32 = some_number();
+    ///
+    /// // Triggers a build error as `v` cannot be asserted to fit within 4 bits...
+    /// // let _ = BitInt::<u32, 4>::from_expr(v);
+    ///
+    /// // ... but this works as the compiler can assert the range from the mask.
+    /// let _ = BitInt::<u32, 4>::from_expr(v & 0xf);
+    ///
+    /// // These expressions are simple enough to be proven correct, but since they are static the
+    /// // `new` constructor should be preferred.
+    /// assert_eq!(BitInt::<u8, 1>::from_expr(1).get(), 1);
+    /// assert_eq!(BitInt::<u16, 8>::from_expr(0xff).get(), 0xff);
+    /// ```
+    pub fn from_expr(expr: T) -> Self {
+        crate::build_assert!(
+            T::fits_within(expr, NUM_BITS),
+            "Requested value larger than maximal representable value."
+        );
+
+        // INVARIANT: `fits_within` confirmed that `expr` can be represented within `NUM_BITS`.
+        Self::__new(expr)
+    }
+
+    /// Returns the contained value as the backing type.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::num::BitInt;
+    ///
+    /// let v = BitInt::<u32, 4>::new::<7>();
+    /// assert_eq!(v.get(), 7u32);
+    /// ```
+    pub fn get(self) -> T {
+        *self.deref()
+    }
+
+    /// Increases the number of bits usable for `self`.
+    ///
+    /// This operation cannot fail.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::num::BitInt;
+    ///
+    /// let v = BitInt::<u32, 4>::new::<7>();
+    /// let larger_v = v.extend::<12>();
+    /// // The contained values are equal even though `larger_v` has a bigger capacity.
+    /// assert_eq!(larger_v, v);
+    /// ```
+    pub const fn extend<const NEW_NUM_BITS: u32>(self) -> BitInt<T, NEW_NUM_BITS> {
+        const {
+            build_assert!(
+                NEW_NUM_BITS >= NUM_BITS,
+                "Requested number of bits is less than the current representation."
+            );
+        }
+
+        // INVARIANT: the value did fit within `NUM_BITS`, so it will all the more fit within
+        // the larger `NEW_NUM_BITS`.
+        BitInt::__new(self.0)
+    }
+
+    /// Attempts to shrink the number of bits usable for `self`.
+    ///
+    /// Returns [`None`] if the value of `self` cannot be represented within `NEW_NUM_BITS`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::num::BitInt;
+    ///
+    /// let v = BitInt::<u32, 12>::new::<7>();
+    ///
+    /// // `7` can be represented using 3 unsigned bits...
+    /// let smaller_v = v.try_shrink::<3>();
+    /// assert_eq!(smaller_v.as_deref().copied(), Some(7));
+    ///
+    /// // ... but doesn't fit within `2` bits.
+    /// assert_eq!(v.try_shrink::<2>(), None);
+    /// ```
+    pub fn try_shrink<const NEW_NUM_BITS: u32>(self) -> Option<BitInt<T, NEW_NUM_BITS>> {
+        BitInt::<T, NEW_NUM_BITS>::try_new(self.get())
+    }
+
+    /// Casts `self` into a [`BitInt`] backed by a different storage type, but using the same
+    /// number of bits for value representation.
+    ///
+    /// Both `T` and `U` must be of same signedness, and `U` must be at least as large as
+    /// `NUM_BITS`, or a build error will occur.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::num::BitInt;
+    ///
+    /// let v = BitInt::<u32, 12>::new::<127>();
+    ///
+    /// let u16_v: BitInt<u16, 12> = v.cast();
+    /// assert_eq!(u16_v.get(), 127);
+    ///
+    /// // This won't build: a `u8` is smaller than the required 12 bits.
+    /// // let _: BitInt<u8, 12> = v.cast();
+    /// ```
+    pub fn cast<U>(self) -> BitInt<U, NUM_BITS>
+    where
+        U: TryFrom<T> + Boundable,
+        T: Integer,
+        U: Integer<Signedness = T::Signedness>,
+    {
+        // SAFETY: the converted value is represented using `NUM_BITS`, `U` is larger than
+        // `NUM_BITS`, and `U` and `T` have the same sign, hence this conversion cannot fail.
+        let value = unsafe { U::try_from(self.get()).unwrap_unchecked() };
+
+        // INVARIANT: although the storage type has changed, the value is still represented within
+        // `NUM_BITS`, and with the same signedness.
+        BitInt::__new(value)
+    }
+}
+
+impl<T, const NUM_BITS: u32> core::ops::Deref for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+{
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // Enforce the invariant to inform the compiler of the bounds of the value.
+        if !T::fits_within(self.0, NUM_BITS) {
+            // SAFETY: Per the `BitInt` invariants, `fits_within` can never return `false` on the
+            // value of a valid instance
+            unsafe { core::hint::unreachable_unchecked() }
+        }
+
+        &self.0
+    }
+}
+
+/// Trait similar to [`TryInto`] but for `BitInt`, to avoid conflicting implementations errors.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::num::{BitInt, TryIntoBitInt};
+///
+/// // Succeeds because `128` fits into 8 bits.
+/// let v: Option<BitInt<u16, 8>> = 128u32.try_into_bitint();
+/// assert_eq!(v.as_deref().copied(), Some(128));
+///
+/// // Fails because `128` doesn't fits into 6 bits.
+/// let v: Option<BitInt<u16, 6>> = 128u32.try_into_bitint();
+/// assert_eq!(v, None);
+/// ```
+pub trait TryIntoBitInt<T: Boundable, const NUM_BITS: u32> {
+    /// Attempts to convert `self` into a [`BitInt`] using `NUM_BITS`.
+    fn try_into_bitint(self) -> Option<BitInt<T, NUM_BITS>>;
+}
+
+/// Any value can be attempted to be converted into a [`BitInt`] of any size.
+impl<T, U, const NUM_BITS: u32> TryIntoBitInt<T, NUM_BITS> for U
+where
+    T: Boundable,
+    U: TryInto<T>,
+{
+    fn try_into_bitint(self) -> Option<BitInt<T, NUM_BITS>> {
+        self.try_into().ok().and_then(BitInt::try_new)
+    }
+}
+
+/// Compares between two [`BitInt`]s, even if their number of valid bits differ.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::num::BitInt;
+///
+/// let v1 = BitInt::<u32, 8>::new::<15>();
+/// let v2 = BitInt::<u32, 4>::new::<15>();
+/// assert_eq!(v1, v2);
+/// ```
+impl<T, U, const NUM_BITS: u32, const NUM_BITS_U: u32> PartialEq<BitInt<U, NUM_BITS_U>>
+    for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    U: Boundable,
+    T: PartialEq<U>,
+{
+    fn eq(&self, other: &BitInt<U, NUM_BITS_U>) -> bool {
+        self.get() == other.get()
+    }
+}
+
+impl<T, const NUM_BITS: u32> Eq for BitInt<T, NUM_BITS> where T: Boundable {}
+
+/// Does partial ordering between [`BitInt`]s, even if their number of valid bits differ.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::num::BitInt;
+///
+/// let v1 = BitInt::<u32, 8>::new::<4>();
+/// let v2 = BitInt::<u32, 4>::new::<15>();
+/// assert!(v1 < v2);
+/// ```
+impl<T, U, const NUM_BITS: u32, const NUM_BITS_U: u32> PartialOrd<BitInt<U, NUM_BITS_U>>
+    for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    U: Boundable,
+    T: PartialOrd<U>,
+{
+    fn partial_cmp(&self, other: &BitInt<U, NUM_BITS_U>) -> Option<core::cmp::Ordering> {
+        self.get().partial_cmp(&other.get())
+    }
+}
+
+/// Does full ordering between [`BitInt`]s.
+///
+/// # Examples
+///
+/// ```
+/// use core::cmp::Ordering;
+/// use kernel::num::BitInt;
+///
+/// let v1 = BitInt::<u32, 8>::new::<4>();
+/// let v2 = BitInt::<u32, 8>::new::<15>();
+/// assert_eq!(v1.cmp(&v2), Ordering::Less);
+/// ```
+impl<T, const NUM_BITS: u32> Ord for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: Ord,
+{
+    fn cmp(&self, other: &Self) -> core::cmp::Ordering {
+        self.get().cmp(&other.get())
+    }
+}
+
+/// Compares between a [`BitInt`] and its backing type.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::num::BitInt;
+///
+/// let v = BitInt::<u32, 8>::new::<15>();
+/// assert_eq!(v, 15);
+/// ```
+impl<T, const NUM_BITS: u32> PartialEq<T> for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: PartialEq,
+{
+    fn eq(&self, other: &T) -> bool {
+        self.get() == *other
+    }
+}
+
+/// Does partial ordering between a [`BitInt`] and its backing type.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::num::BitInt;
+///
+/// let v = BitInt::<u32, 8>::new::<4>();
+/// assert!(v < 15);
+/// ```
+impl<T, const NUM_BITS: u32> PartialOrd<T> for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: PartialOrd,
+{
+    fn partial_cmp(&self, other: &T) -> Option<core::cmp::Ordering> {
+        self.get().partial_cmp(other)
+    }
+}
+
+// Implementations of `core::ops` between a `BitInt` and its backing type.
+
+impl<T, const NUM_BITS: u32> core::ops::Add<T> for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: core::ops::Add<Output = T>,
+{
+    type Output = T;
+
+    fn add(self, rhs: T) -> Self::Output {
+        self.get() + rhs
+    }
+}
+
+impl<T, const NUM_BITS: u32> core::ops::BitAnd<T> for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: core::ops::BitAnd<Output = T>,
+{
+    type Output = T;
+
+    fn bitand(self, rhs: T) -> Self::Output {
+        self.get() & rhs
+    }
+}
+
+impl<T, const NUM_BITS: u32> core::ops::BitOr<T> for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: core::ops::BitOr<Output = T>,
+{
+    type Output = T;
+
+    fn bitor(self, rhs: T) -> Self::Output {
+        self.get() | rhs
+    }
+}
+
+impl<T, const NUM_BITS: u32> core::ops::BitXor<T> for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: core::ops::BitXor<Output = T>,
+{
+    type Output = T;
+
+    fn bitxor(self, rhs: T) -> Self::Output {
+        self.get() ^ rhs
+    }
+}
+
+impl<T, const NUM_BITS: u32> core::ops::Div<T> for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: core::ops::Div<Output = T>,
+{
+    type Output = T;
+
+    fn div(self, rhs: T) -> Self::Output {
+        self.get() / rhs
+    }
+}
+
+impl<T, const NUM_BITS: u32> core::ops::Mul<T> for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: core::ops::Mul<Output = T>,
+{
+    type Output = T;
+
+    fn mul(self, rhs: T) -> Self::Output {
+        self.get() * rhs
+    }
+}
+
+impl<T, const NUM_BITS: u32> core::ops::Neg for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: core::ops::Neg<Output = T>,
+{
+    type Output = T;
+
+    fn neg(self) -> Self::Output {
+        -self.get()
+    }
+}
+
+impl<T, const NUM_BITS: u32> core::ops::Not for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: core::ops::Not<Output = T>,
+{
+    type Output = T;
+
+    fn not(self) -> Self::Output {
+        !self.get()
+    }
+}
+
+impl<T, const NUM_BITS: u32> core::ops::Rem<T> for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: core::ops::Rem<Output = T>,
+{
+    type Output = T;
+
+    fn rem(self, rhs: T) -> Self::Output {
+        self.get() % rhs
+    }
+}
+
+impl<T, const NUM_BITS: u32> core::ops::Sub<T> for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: core::ops::Sub<Output = T>,
+{
+    type Output = T;
+
+    fn sub(self, rhs: T) -> Self::Output {
+        self.get() - rhs
+    }
+}
+
+// Proxy implementations of `core::fmt`.
+
+impl<T, const NUM_BITS: u32> core::fmt::Display for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: core::fmt::Display,
+{
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        self.get().fmt(f)
+    }
+}
+
+impl<T, const NUM_BITS: u32> core::fmt::Binary for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: core::fmt::Binary,
+{
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        self.get().fmt(f)
+    }
+}
+
+impl<T, const NUM_BITS: u32> core::fmt::LowerExp for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: core::fmt::LowerExp,
+{
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        self.get().fmt(f)
+    }
+}
+
+impl<T, const NUM_BITS: u32> core::fmt::LowerHex for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: core::fmt::LowerHex,
+{
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        self.get().fmt(f)
+    }
+}
+
+impl<T, const NUM_BITS: u32> core::fmt::Octal for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: core::fmt::Octal,
+{
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        self.get().fmt(f)
+    }
+}
+
+impl<T, const NUM_BITS: u32> core::fmt::UpperExp for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: core::fmt::UpperExp,
+{
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        self.get().fmt(f)
+    }
+}
+
+impl<T, const NUM_BITS: u32> core::fmt::UpperHex for BitInt<T, NUM_BITS>
+where
+    T: Boundable,
+    T: core::fmt::UpperHex,
+{
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        self.get().fmt(f)
+    }
+}
+
+/// Implements `$trait` for all [`BitInt`] types represented using `$num_bits`.
+///
+/// This is used to declare size properties as traits that we can constrain against in impl blocks.
+macro_rules! impl_size_rule {
+    ($trait:ty, $($num_bits:literal)*) => {
+        $(
+        impl<T> $trait for BitInt<T, $num_bits> where T: Boundable {}
+        )*
+    };
+}
+
+/// Local trait expressing the fact that a given [`BitInt`] has at least `N` bits used for value
+/// representation.
+trait AtLeastXBits<const N: usize> {}
+
+/// Implementations for infallibly converting a primitive type into a [`BitInt`] that can contain
+/// it.
+///
+/// Put into their own module for readability, and to avoid cluttering the rustdoc of the parent
+/// module.
+mod atleast_impls {
+    use super::*;
+
+    // Number of bits at least as large as 64.
+    impl_size_rule!(AtLeastXBits<64>, 64);
+
+    // Anything 64 bits or more is also larger than 32.
+    impl<T> AtLeastXBits<32> for T where T: AtLeastXBits<64> {}
+    // Other numbers of bits at least as large as 32.
+    impl_size_rule!(AtLeastXBits<32>,
+        32 33 34 35 36 37 38 39
+        40 41 42 43 44 45 46 47
+        48 49 50 51 52 53 54 55
+        56 57 58 59 60 61 62 63
+    );
+
+    // Anything 32 bits or more is also larger than 16.
+    impl<T> AtLeastXBits<16> for T where T: AtLeastXBits<32> {}
+    // Other numbers of bits at least as large as 16.
+    impl_size_rule!(AtLeastXBits<16>,
+        16 17 18 19 20 21 22 23
+        24 25 26 27 28 29 30 31
+    );
+
+    // Anything 16 bits or more is also larger than 8.
+    impl<T> AtLeastXBits<8> for T where T: AtLeastXBits<16> {}
+    // Other numbers of bits at least as large as 8.
+    impl_size_rule!(AtLeastXBits<8>, 8 9 10 11 12 13 14 15);
+
+    // Anything 8 bits or more is also larger than 1.
+    impl<T> AtLeastXBits<1> for T where T: AtLeastXBits<8> {}
+    // Other numbers of bits at least as large as 1.
+    impl_size_rule!(AtLeastXBits<1>, 1 2 3 4 5 6 7);
+}
+
+/// Generates `From` implementations from a primitive type into a [`BitInt`] with
+/// enough bits to store any value of that type.
+///
+/// Note: The only reason for having this macro is that if we pass `$type` as a generic
+/// parameter, we cannot use it in the const context of [`AtLeastXBits`]'s generic parameter. This
+/// can be fixed once the `generic_const_exprs` feature is usable, and this macro replaced by a
+/// regular `impl` block.
+macro_rules! impl_from_primitive {
+    ($($type:ty),*) => {
+        $(
+        #[doc = ::core::concat!(
+            "Conversion from a [`",
+            ::core::stringify!($type),
+            "`] into a [`BitInt`] of same signedness with enough bits to store it.")]
+        impl<T, const NUM_BITS: u32> From<$type> for BitInt<T, NUM_BITS>
+        where
+            $type: Integer,
+            T: From<$type> + Boundable + Integer<Signedness = <$type as Integer>::Signedness>,
+            Self: AtLeastXBits<{ <$type as Integer>::BITS as usize }>,
+        {
+            fn from(value: $type) -> Self {
+                // INVARIANT: The trait bound on `Self` guarantees that `NUM_BITS` is large
+                // enough to hold any value of the source type.
+                Self::__new(T::from(value))
+            }
+        }
+        )*
+    }
+}
+
+impl_from_primitive!(bool, u8, i8, u16, i16, u32, i32, u64, i64);
+
+/// Local trait expressing the fact that a given [`BitInt`] fits into a primitive type of `N` bits,
+/// provided they have the same signedness.
+trait FitsInXBits<const N: usize> {}
+
+/// Implementations for infallibly converting a [`BitInt`] into a primitive type that can contain
+/// it.
+///
+/// Put into their own module for readability, and to avoid cluttering the rustdoc of the parent
+/// module.
+mod fits_impls {
+    use super::*;
+
+    // Number of bits that fit into a primitive with 1 bit.
+    impl_size_rule!(FitsInXBits<1>, 1);
+
+    // Anything that fits into 1 bit also fits into 8.
+    impl<T> FitsInXBits<8> for T where T: FitsInXBits<1> {}
+    // Other numbers of bits that fit into a 8-bits primitive.
+    impl_size_rule!(FitsInXBits<8>, 2 3 4 5 6 7 8);
+
+    // Anything that fits into 8 bits also fits into 16.
+    impl<T> FitsInXBits<16> for T where T: FitsInXBits<8> {}
+    // Other numbers of bits that fit into a 16-bits primitive.
+    impl_size_rule!(FitsInXBits<16>, 9 10 11 12 13 14 15 16);
+
+    // Anything that fits into 16 bits also fits into 32.
+    impl<T> FitsInXBits<32> for T where T: FitsInXBits<16> {}
+    // Other numbers of bits that fit into a 32-bits primitive.
+    impl_size_rule!(FitsInXBits<32>,
+        17 18 19 20 21 22 23 24
+        25 26 27 28 29 30 31 32
+    );
+
+    // Anything that fits into 32 bits also fits into 64.
+    impl<T> FitsInXBits<64> for T where T: FitsInXBits<32> {}
+    // Other numbers of bits that fit into a 64-bits primitive.
+    impl_size_rule!(FitsInXBits<64>,
+        33 34 35 36 37 38 39 40
+        41 42 43 44 45 46 47 48
+        49 50 51 52 53 54 55 56
+        57 58 59 60 61 62 63 64
+    );
+}
+
+/// Generates [`From`] implementations from a [`BitInt`] into a primitive type that is
+/// guaranteed to contain it.
+///
+/// Note: The only reason for having this macro is that if we pass `$type` as a generic
+/// parameter, we cannot use it in the const context of `AtLeastXBits`'s generic parameter. This
+/// can be fixed once the `generic_const_exprs` feature is usable, and this macro replaced by a
+/// regular `impl` block.
+macro_rules! impl_into_primitive {
+    ($($type:ty),*) => {
+        $(
+        #[doc = ::core::concat!(
+            "Conversion from a [`BitInt`] with no more bits than a [`",
+            ::core::stringify!($type),
+            "`] and of same signedness into [`",
+            ::core::stringify!($type),
+            "`]")]
+        impl<T, const NUM_BITS: u32> From<BitInt<T, NUM_BITS>> for $type
+        where
+            $type: Integer,
+            T: Boundable + Integer<Signedness = <$type as Integer>::Signedness>,
+            BitInt<T, NUM_BITS>: FitsInXBits<{ <$type as Integer>::BITS as usize }>,
+        {
+            fn from(value: BitInt<T, NUM_BITS>) -> $type {
+                // SAFETY: The trait bound on `BitInt` ensures that any value it holds (which
+                // is constrained to `NUM_BITS`) can fit into the destination type, so this
+                // conversion cannot fail.
+                unsafe { value.get().try_into().unwrap_unchecked() }
+            }
+        }
+        )*
+    }
+}
+
+impl_into_primitive!(u8, i8, u16, i16, u32, i32, u64, i64);
+
+/// Conversion to boolean is handled separately as it does not have a [`TryFrom`] implementation
+/// from integers.
+impl<T> From<BitInt<T, 1>> for bool
+where
+    T: Boundable,
+    BitInt<T, 1>: FitsInXBits<1>,
+    T: PartialEq + Zeroable,
+{
+    fn from(value: BitInt<T, 1>) -> Self {
+        value.get() != Zeroable::zeroed()
+    }
+}

-- 
2.51.2


