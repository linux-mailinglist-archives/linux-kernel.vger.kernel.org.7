Return-Path: <linux-kernel+bounces-771329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDD5B28591
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 20:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA75606A8A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA8E30DEB4;
	Fri, 15 Aug 2025 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="vHIRMwvp"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010014.outbound.protection.outlook.com [52.103.43.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2DE2F9C23
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 18:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281341; cv=fail; b=MlJ/lKftF8jzgLc62IBFd7qOgtPI1WX9ghA7+7u8Remh8xkaWOxi8Th0Z9f9Ocghddox8m9NlOfKOMRb13kmnXwtJ71n3EZmQODqCTm2p+DFf3xEUawDsCp+0iqS2/dKCwBBN0c5iqROhgz5a9di/C1zAj2dwpcG7G0wxb5GH0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281341; c=relaxed/simple;
	bh=h1/ORmaPTXFJocF/HnX9A7FXAbWcP9lh3ZYiZ7eFKdc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SAVt7F+Q17KHLl+g4XRZYUxfMjjBz78V8bchtaSKn3Zkd9lUsRqaiMWkULwtymmMyI/HOUOuCKFjuZYn5jPcrme5OCZTOWyFlMKbhTERTe8ZYO417AHe32aUEE0ACYgMT0aM8NGp+ltB2yb6Ab1SGxdyeb/736Moj0UR5efzF0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=vHIRMwvp; arc=fail smtp.client-ip=52.103.43.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9507FQsaJcyktT3fZCGAaYMHHU436mHxAYG6soLpcPO4qzYab+LViyZjZTm2Ze76/ynzXlkcUluuXJWJKUli28OSR8w6ZTRabA5CzMPce5lvGf6uk7d/WtPneHUJNlLcymFJjVsk4CVkSaKkvIx32z58SRkkr+VYyGxq2SCe0JtNlbsI3UvLRkISOYOt2N4lfx23Ulv1BPx6BQ9KpR/TyDZKtX5PkPg8IXMVDw/CP1QppPT3HPWuvdAWqx8nFrO7enHdV0wioUKdh2Dqo5NZAsfcWBwef1SLq/U01cNzwMxCtl1H4n+n82ajw2ee2nj8rU2Q5xAzz+FTTCjThT/UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1/ORmaPTXFJocF/HnX9A7FXAbWcP9lh3ZYiZ7eFKdc=;
 b=gzMEvUnPLs4FqCVySPWOQwqJvr5eIqJWSAbdi2cUtkil3aezhaU/9HAzKaV4kNB4oU7562sCz3kRH/xFSFSez2CcxRwoZrrhTBaphM2rvvMKYq5Uqrmgax8T6W8nreoPlWEmzkMgxCcmaqBu8yi/Fayjy90VduAC+1kcLYOjphB1YvCnE1G89CBXvn7MxVxYxkvbA1tSoz0sBaIu9oMcrYC/a/tfJYk5SYaDAncnC1khvPlbYQKUIUBeKGvFxra0KWEHSaIX4ktkNs+q2WmxUpekDR5fK6ubRzb6/mSOtmFJAXyHeNExaLJXRfmDVMCVJyzF/u5lADz0oBuOhaZ7DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1/ORmaPTXFJocF/HnX9A7FXAbWcP9lh3ZYiZ7eFKdc=;
 b=vHIRMwvpjlj+JXAJs5wgh3JxLqIQao0A99It6XEX2oqxHqtJNfYDLyC29rSsw3+N/3zE1LG8MH+pNOYLuOfyVovR7BibEran9kcryDX7w0B/ia8CrezcFuGIGfK3ELHD/R/BzJe5gniGZ9K18vwTLGKEbrDrNFvzK9pgu+o22WAl+1XPLkInEEhYap8HUcthKYnYfVwyDoOmO8WPCdwKSG4I2WR2wNJ+MFkp3Jn2Gch/0u1HwXz2SwhjO3lTN56WIPwRz33oaSSMSMBVg3uW9x9+cFnhGCU7KmhXW+VrjtLLisqn8GFyl5J/1clSer9ai4XLyP04NN7f/RvY/ZwXyA==
Received: from OS9PR01MB15202.jpnprd01.prod.outlook.com
 (2603:1096:604:3b9::10) by TYTPR01MB10937.jpnprd01.prod.outlook.com
 (2603:1096:400:39b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Fri, 15 Aug
 2025 18:08:55 +0000
Received: from OS9PR01MB15202.jpnprd01.prod.outlook.com
 ([fe80::bd40:1d2e:2d1f:e8f3]) by OS9PR01MB15202.jpnprd01.prod.outlook.com
 ([fe80::bd40:1d2e:2d1f:e8f3%5]) with mapi id 15.20.9031.018; Fri, 15 Aug 2025
 18:08:55 +0000
From: Shixuan Zhao <shixuan.zhao@hotmail.com>
To: Kiryl Shutsemau <kirill@shutemov.name>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shixuan Zhao <shixuan.zhao@hotmail.com>
Subject: Re: [PATCH] x86/tdx: support VM area addresses for tdx_enc_status_changed
Date: Fri, 15 Aug 2025 14:08:44 -0400
Message-ID:
 <OS9PR01MB1520200AB9DB1EB76C9D4B1948D34A@OS9PR01MB15202.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Reply-To: enhnj775ryshjrqer24ki7wibngxaj5ydos7xjgone6wobuvdn@77luyq4cawva.smtp.subspace.kernel.org
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:610:38::22) To OS9PR01MB15202.jpnprd01.prod.outlook.com
 (2603:1096:604:3b9::10)
X-Microsoft-Original-Message-ID:
 <20250815180844.10998-1-shixuan.zhao@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB15202:EE_|TYTPR01MB10937:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c979fab-de5a-4aee-cf97-08dddc26cc7b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|23021999003|15080799012|5072599009|41001999006|461199028|19110799012|4295299021|3412199025|440099028|40105399003|13041999003|26104999006|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ug9ERdAXOKiiD2W6dimTtIC4go9WeOA8EHXd9TirBQDcF4p4YXUyeMzuFeF+?=
 =?us-ascii?Q?dmv1YbidlPZ8B4X20pUHcPp84fCjc1MpC2EsvhbFhfM7pDUWq57qmLEXR53+?=
 =?us-ascii?Q?03v8WeOFK8PmpmIoixU2RItjm+bMt8olCe5P86KY93wQeLMWfEB+zkoTddfc?=
 =?us-ascii?Q?5M8fJRCnitJIefNcU5XAvgvlNtml9sBa6Ew6+fFKYhVtk3fO+FUDfbO1DV4N?=
 =?us-ascii?Q?/NDftfsBSUaEtEPiMx9c+zxn4/vvra4ln8+PPtCOgmslCrjIrv1CbHVnUnu2?=
 =?us-ascii?Q?YfPPlL4mBxyxmUBBXRqkbrMgZQuBrRSj9X8h7VmiQEb82IDIhgOeG10Mt6jl?=
 =?us-ascii?Q?M0irTNmGS+hC2n59HSoYRh8OdBi4hpjQX7HSWl/YSpXkvPhHLS4NaUqY4DS0?=
 =?us-ascii?Q?TolIZiWH8uvkekJkQFkwYqelJPMcZtXXFjCNVkhuTH6Pl67l6dxoVTNFSq3c?=
 =?us-ascii?Q?0CIgsVdpUwM0k5sgceQtI7NhiRJmIpQ3geyFJtsUeoE98O8Intv/EAjkYbXk?=
 =?us-ascii?Q?y4cVasm+YoEZ23Ej8aM/tdcHLEQguOzTsL5u8ZIciqIw1QKk0UhgIqEN5Ehm?=
 =?us-ascii?Q?CI2dcQTOZGbSyHs3PqYYiOdYUXxBlLb1epkB6UYssEv4Lb7USQryKulxbX+Q?=
 =?us-ascii?Q?7PLtO4Dje5DNAFv/8a8ErjIfPFmyjOUcZYL3GaYt7eINpbSnLf+Jic+qciD9?=
 =?us-ascii?Q?Npm66GXL6OR1KfQnK4j9/o36AFnO2D2oCvyhDwS5+FtQc78BaVrPCW1c+LA3?=
 =?us-ascii?Q?LSah5RoRqHA0kZDOTRIIKkkI72/xmT0px3hOj0R9VmykQOISyx62DAogY6+t?=
 =?us-ascii?Q?ZRXA5ofROGCy8/6FoWoKPWLYTchzVmtv2yqmyJTK29cXShoUp5bzvbUdVh4C?=
 =?us-ascii?Q?5N97I+p+Gde9FA2ak8T3f7OknhhfLlPnQYM7NoIrDq4dzddoGJPfRHvyTm3p?=
 =?us-ascii?Q?MCgsjPTo2QKu76OeWRD1jmTFEMrPOpOtU/gPxjQp+nrUlCnfPXrNpHoadwI6?=
 =?us-ascii?Q?1KTGUsz7w4ouMuHh4DrWsw7C2d8aIGZAbmMJK6EXDRuMf0IDWxTZUV2D8q5G?=
 =?us-ascii?Q?5hMvV7wsjS8+FbCCxbyfLxRBc2kmBFypLRCyBGcsReaH29TS9ffWYIErW7cv?=
 =?us-ascii?Q?fRFQG2ulxMsMKfAaTQRgqvUuFNyKdZb/tXi7Tcs+VSllOot/i5jLK4k0db8w?=
 =?us-ascii?Q?ENYigswAWAgpmoB5uq0+ZiGhT3wmQWFW2m2k6xQdoVIXWzr5i46ljJZNFnNM?=
 =?us-ascii?Q?uwwvLgfD9NxFZD9lSkPyidvEMa75tT+neIiZHIB3IQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6m4K0K7SNAFz2iMr/rKeokUADJuw992O3EJpMyHs4HtvGZgd700w0fVy5YUk?=
 =?us-ascii?Q?E4Q44TAvsPNjpxosixQfo1ynp0V/CSGgNxPvv11LrcVXipAivftVSJWKm6h0?=
 =?us-ascii?Q?TbY4+jwgAz1rbnPFFAXKUwldhz0RY8WvKBLsczqV5JvFVHA+BUoC8WNyuo3h?=
 =?us-ascii?Q?O/QOtCBTrtT/Z7OQS1A31sj35pgA0EX6jsKCP6nuDKPEmITATIflNGghha80?=
 =?us-ascii?Q?qJOlqsvVsOk4R8AVAhdFh5RgB7GknnK2QH5OLpAhBxBBXPNJDBhomjbyTFzj?=
 =?us-ascii?Q?/6Zsr9d+mHvfzmjMbYSKa5bZJak7tFB4ZTmhtdrHpqF415CUIXD0Ld2EnwbF?=
 =?us-ascii?Q?UXKYXIcdyMJ1aW/Te6dpgMekdLPEi6wJ1xozN0zQCH68P2cTsYxYeIQVf8qz?=
 =?us-ascii?Q?NfWERSRXcYiyHUpEdqJ+wdywyQbZuAfIBPvxBGiz2+81tZ19gP7o2J1Y5P/2?=
 =?us-ascii?Q?DnJD9Lp//vTpPiuD7CY1oNRC1PtbFFRO3+2lRpD+LIenow+CrAA9ZuNgM3bw?=
 =?us-ascii?Q?1xNj0Nr9MN31XLBd3Ujaos2xQIMOkd3BM8G10f4L3nM9S0g5prT4X4wky6q3?=
 =?us-ascii?Q?4QFaLb9PTWPDwLw/0Y7634mma8QhmITjJ6jPi3f1/PUcl+yYBYNfeIzJds/k?=
 =?us-ascii?Q?l9t8LxsDWl62vGxOq5OFKohGAgmXPp2XtVXmS1ciyWQvova68KrgvbPrcryC?=
 =?us-ascii?Q?wnBQGVsUW0ouzZyCi3Xnc08sRDpo6fEd1PEyNB+CJPgFHBurFQWzni8pKJtL?=
 =?us-ascii?Q?r7WUKYwMG7wbklQkQKi/GnqkwJsKIz8AI047DaaAxOBjJ90w9XS4HMYlI9i0?=
 =?us-ascii?Q?FvPfLKl0fRZEFLZizTbesPyT9P1UKC/NGkZpd3ENy9f+HbUOBhDMs0WITBqK?=
 =?us-ascii?Q?jWxfO/foTPBvTKjFZuI1b4AFTol7BNQkiG/RENvkPbVinTKVqgNpTdXNOi2J?=
 =?us-ascii?Q?vLdb+mvgyK1ZHf83cIaxsO1dcruRL+3ZvyghNAWtU334xfsEALGbesf8XxqH?=
 =?us-ascii?Q?id6w4/tKM5Je3bxx6BKvOD5vl1z2DaVdlPBwLkdmsYuji42CNsmzUh4x6Xk+?=
 =?us-ascii?Q?Y5C5HoPekyU0ZGHaWOIx9Cm2TAfN0bc7UTZjgqisSaXX5t1SbJfEfyg62qpS?=
 =?us-ascii?Q?+CJwz+Xnto1hvxo4p7JAkPufpmMn7Qzq/iLJNaZ8IHzvzbtab1Wq0YjNWVSt?=
 =?us-ascii?Q?kFPKdafnI2TbDq7t1mUBiMjowPHQcThi3nu+f6XTuhlslZ1PfO8eDIga+Urj?=
 =?us-ascii?Q?M3fxXVaiiJaIy+2E7XSjVqxQT57PxYVgn8FX4SH0+rSL3mVBHtm9QAWxOfRi?=
 =?us-ascii?Q?DNoo/taBR3meZLmXoY1qd+Rt?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-9a502.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c979fab-de5a-4aee-cf97-08dddc26cc7b
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB15202.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 18:08:55.7738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB10937

> Could you tell more about use-case?

So basically I'm writing a project involving a kernel module that
communicates with the host which we plan to do it via a shared buffer.
That shared buffer has to be marked as shared so that the hypervisor can
read it. The shared buffer needs a fixed physical address in our case so
we reserved a range and did ioremap for it.

> I am not sure we ever want to convert vmalloc()ed memory to shared as it
> will result in fracturing direct mapping.

Currently in this patch, linear mapping memory will still be handled in
the old way so there's technically no change to existing behaviour. These
memory ranges are still mapped in a whole chunk instead of page-by-page It
merely added a fall back path for vmalloc'ed or ioremap'ed or whatever
mapping that's not in the linear mapping.

tdx_enc_status_changed is called by set_memory_decrypted/encrypted which
takes vmalloc'ed addresses just fine on other platforms like SEV. It would
be an exception for TDX to not support VM area mappings.

> And it seems to the wrong layer to make it. If we really need to go
> this pass (I am not convinced) it has to be done in set_memory.c

set_memory_decrypted handles vmalloc'ed memory. It's just that on TDX it
has to call the TDX-specific enc_status_change_finish which is
tdx_enc_status_changed that does not handle vmalloc'ed memory. This
means that when people call the set_memory_decrypted with a vmalloc'ed,
it will fail on TDX but will succeed in other platforms (e.g., SEV).

Thanks,
Shixuan

