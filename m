Return-Path: <linux-kernel+bounces-721690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE0AAFCCB9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F8017996D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89332DECA7;
	Tue,  8 Jul 2025 13:54:09 +0000 (UTC)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022103.outbound.protection.outlook.com [40.107.75.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608312DECC4;
	Tue,  8 Jul 2025 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982848; cv=fail; b=ugDNmLrueDHqif7cNzMtHm6LbvE/3VN5prIcuSVSvzjPumEWzpaYvngIl/Tanh04fajfUwP3IUCuK6YFTYmA/SI5R7081MQZ1AJmDC9HiSiRXW/dDuOBGI5WsgQ4dGP7eK6XVk+/4UPx4sqzYJhRpxJsDyxwG2ZD2IDtgojAvn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982848; c=relaxed/simple;
	bh=Q+u86wLUJnPbOGRpuuCW/00Ck4fQaRNmh9siuxEqasw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhomyzL/vPw5w++6nIGF2nLIEq9FmSSVPbR0jcrT7YqNLWjwMZbRlAOSdUzDOdw9FP7DpS0kzxVF6pRQse/P1VNrvRy1CXP3OGx8/vEXdbGMs5/QNSnovOGi2qopCdoH6ZNrbpRBieaVl9OeuV1z8VD28ZNiStqoviblHBjw1q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eetcY4J9IcAj8alFYCwVX96RDAixpvlewLxoQXb8V/43bg4pOVnuvAQQBvA7k2huMi2uQihNaVoclstgoQextoMi6Nj+VDF0hn/+MpaEIHmp9M9UXNkfJJpDl/AXMLz6vvVgpnRee+jpp/IC+C7yvR24o4VPrYfynPYm3Nu8rngvpi/3u6HT4/59K/OcEfomPl+WUDwkrINTZWg7AVctoZzahWoaKiFSDtiz3XHqmaCdj9s3iSlTJ9s07Ec+NtO4UlnscsxM46a3wbSvr2FLsuhYNyDmTpdVp9YfOzDsZiucX2eHNAt6rvbp+Z1Ho4oeQ8MdG96CJZmEUmNx++gl/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaKnVh4SFM/8SE/7K6ZJNMmxyn4gZ5cvssxitE+gQ0I=;
 b=a8pny8Sm264D3GBZtjsejCicgUqp6CaPrqvaCCzajG0Tkycj839jCf3NM+okSP2V6fw9T3eaeWKfPZbNN+eej6TMP1DOwm12k0AnF3BaqphSt4knQ9TtV1Z6htbZfosDJOPyB+KgamlZtMNcH9XcBdaQ8ROMNk7G5CtTe/aDUfR/w3wnG3cUYVrA+tAHJUo7Qg4CI3j2Eoj9qqcngQBCuQI9Mqp/5DYCPcaswszzJckhwtC5cBEjiy1/Oylt1T78gLob/p3ka3PndzUCcqRXPDXT72/tfWJnOCNwWw+4nOd86KllYWra6ajmt4YdVpeR7DooTEaOO2ExHQwuITkiHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) by PUZPR06MB6125.apcprd06.prod.outlook.com
 (2603:1096:301:11b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Tue, 8 Jul
 2025 13:53:56 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:4:191:cafe::62) by SI2PR01CA0009.outlook.office365.com
 (2603:1096:4:191::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 13:53:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20 via Frontend Transport; Tue, 8 Jul 2025 13:53:55 +0000
Received: from gchen (unknown [172.20.64.84])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 45F0D40A5BFA;
	Tue,  8 Jul 2025 21:53:53 +0800 (CST)
Date: Tue, 8 Jul 2025 13:53:51 +0000
From: Guomin chen <guomin.chen@cixtech.com>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	Peter Chen <peter.chen@cixtech.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
	maz@kernel.org, sudeep.holla@arm.com, kajetan.puchalski@arm.com,
	eballetb@redhat.com, Gary Yang <gary.yang@cixtech.com>,
	Lihua Liu <Lihua.Liu@cixtech.com>
Subject: Re: [PATCH v9 5/9] mailbox: add CIX mailbox driver
Message-ID: <aG0i75h32dWg/L2G@gchen>
References: <20250609031627.1605851-1-peter.chen@cixtech.com>
 <20250609031627.1605851-6-peter.chen@cixtech.com>
 <CABb+yY17OOBx73655OhBp8At1b81w9M61zzGu4uhXcMTw4Q=Dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABb+yY17OOBx73655OhBp8At1b81w9M61zzGu4uhXcMTw4Q=Dw@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|PUZPR06MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f10062f-6b6a-4012-9272-08ddbe26e14c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHYzL3J4c01tRDBzZjNvd2p3MDg0ak10Q1J2Y0dxbk1mYk13V2xIQmZSVTJ4?=
 =?utf-8?B?alZ2RzArMWxYQUlzSkhXckpJTVIzOFpUYnU4WjFBYkoxbVBxbjBIRlcrK2tR?=
 =?utf-8?B?cG13eE9QZUFqK0ZKQ1NlZkREY2trODA1RkpzR0NGaHVuL053cXlZRjJiZWpK?=
 =?utf-8?B?SWhuYUxEV3VxRzkrS0hpU1kvTzBjR1E4dXBtRXI3N09NQ29DTlZWWVIzeVVy?=
 =?utf-8?B?bVBTN1ZSemwvMmtCOTkvRDN5TThXOWxLelFQamRLdVhEcFozbHBlMEJBZ0M3?=
 =?utf-8?B?ZW9jeHJHRjFmRmZDRVVyZU4wS1RGUWJUeVh5NGQ0NWdLYm0wYVVQTWprRzlz?=
 =?utf-8?B?L0UvRFZvNU13MmptVWt2eCtZMlpab0hOZ0g5Sk9XSitFbmhRb29KankxeWxP?=
 =?utf-8?B?dUdCYjZoUUhnMWNYN1ZxQ2hkNDJPVjJSSERIYUNNakQwbHVwd01BTU5aek9v?=
 =?utf-8?B?KzNxTUtVdy9DUm5BSUc1WmdDYTRQTFA2eUNvRWlTWUY5QlZUSGdSRFBDYjQw?=
 =?utf-8?B?Vzk4dFRIbjIxMnc2K250cWFXY0ZaTCt0L2EzeklYbzB4OElRM1ZJcE90Y1hL?=
 =?utf-8?B?bmxNZ1FvR25QWjhKUkE2ZGh6Z3RzbmhVRTFhZ1hheGRrcDNNZ1ByT1lJUXFL?=
 =?utf-8?B?ZEZ3VDVHdzVMT2hxR09UMUQwL3dCdGdNbmR0N0ZPUklTYzBUVzlPQy93WkZ5?=
 =?utf-8?B?aFFjcTFPU0tqQVdjRzhVYkt6QStOY213aXlZd21oMXVvR2hLeUFpNUtSUkVq?=
 =?utf-8?B?d2ZRUWJpYnZPbDkyMmRzcmFudHpOd201bFR1a2ZGazlSbGlRRGc5L1FBUnMy?=
 =?utf-8?B?TVNQdmdIVC9PSkFxOS96VFRqd00xOUFsd2loQUJWdlFRa1lKbGk0S1lhSUpO?=
 =?utf-8?B?VXRrSXBCWGg1a0ZyTmNNZ1Q1RjlwN21Ia1gvbm1WZlhkdjBNbFNuZjZHTVZS?=
 =?utf-8?B?VVF2OU9Dcy92Q1VmQ3I4YTVZQ1I4YWx6SXE1cjBHTWlyTFlMK3ZJTjlOYnNZ?=
 =?utf-8?B?VWVUcnRwNkI4QkxoM2F1d2lHOWlMZ1FUYVc4SU9ybU1tYUVqWTNSeTJzQnYw?=
 =?utf-8?B?cjJablFzS0dFc2hyQ2FmNGVXM0d6R2RERml1NlNhZXY5eFV3TnlyNTBmTjNh?=
 =?utf-8?B?ejlrUU9CSUdhdi9zbHhiQW85NkR6MDZvMk1ZVmpPNFZpQjNQKzlGUnNUTzdT?=
 =?utf-8?B?VXpXQmsrajNtODJuOFdZSVZXeERibkpYeHJ4VVRsVlVYMHpQMitKNElUakJT?=
 =?utf-8?B?OTVsZlRmbnpWdnZldG1YalJsR1hJVlRjY2hob3JSaytlcjJmYmhaN0JVSWwy?=
 =?utf-8?B?S3FnZHoyTzY0WkhCWExkODBWR0p6NTZmRWdTLzVobWxpMU5QSGhTeHdMZEc2?=
 =?utf-8?B?enpXTURFRG1NangvWG9ZTkNZdjZOSmQ3eG1WU3o0ZlFibUxDWWozOUpQMnVN?=
 =?utf-8?B?cW1XVkdsUS9zNE11YjhMQU1wdkxJYjY4Wlh6cnhtWmVMTEM3YVlJeUhxOHR2?=
 =?utf-8?B?NXZURndmNWgvTml6NEZOS29IVi9BRHRML09DSEUvUkV3NGhpQWdVUVhSUkF0?=
 =?utf-8?B?amhuSk53TTJSVjhReWJqUS9oTUVEcy8wcnFhbWJ2cWFEVElOMUVmWG04MzR6?=
 =?utf-8?B?ZlJlaExhMVA2TTBjWXF1dUl0RWJDb0VyTTNpbFBrbXRJTXdhUDhFc2I3Z1N3?=
 =?utf-8?B?SGxjbW80eGRiQkJKaHY4MmVNakE2elpEd3RLUUEyMWN4NlU4eXgxQ1I3SU1k?=
 =?utf-8?B?NDhHRzJqS1RrSmZVL1NiNGIrYS9zR01vOVJ0Skx4V2NrR3BhZGdleENPMWI3?=
 =?utf-8?B?cVQ2WFQ4WlNtQitXblhzeHlYd3d0eS9Jc2ppaWhQd09QNk9RdlUrdUZXWDg4?=
 =?utf-8?B?djlYajdnTS9ldXgyaFFsRlNmWGo3Tys4YXZwcTJ1Q1RHS2lmR2QwT3R6azJI?=
 =?utf-8?B?aEJyQmk3YVdZVUJ6SUJoblJMeXp3U0pzUEI3QWlQZ01iVElaWGlCY3Z4d0U1?=
 =?utf-8?B?WHlTL1FKQ3pRNWxudy84WUhmS2F1T0tFUm1uU3VVaXJzbVRKem1YWlJDQm1U?=
 =?utf-8?Q?1W7946?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:53:55.2466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f10062f-6b6a-4012-9272-08ddbe26e14c
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6125

On Sun, Jul 06, 2025 at 02:30:01PM -0500, Jassi Brar wrote:
> [Some people who received this message don't often get email from jassisinghbrar@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL
> 
> On Sun, Jun 8, 2025 at 10:16 PM Peter Chen <peter.chen@cixtech.com> wrote:
> >
> > From: Guomin Chen <Guomin.Chen@cixtech.com>
> >
> > The CIX mailbox controller, used in the Cix SoCs, like sky1.
> > facilitates message transmission between multiple processors
> > within the SoC, such as the AP, PM, audio DSP, SensorHub MCU,
> > and others.
> >
> > Reviewed-by: Peter Chen <peter.chen@cixtech.com>
> > Signed-off-by: Guomin Chen <Guomin.Chen@cixtech.com>
> > Signed-off-by: Gary Yang <gary.yang@cixtech.com>
> > Signed-off-by: Lihua Liu <Lihua.Liu@cixtech.com>
> > Signed-off-by: Peter Chen <peter.chen@cixtech.com>
> > ---
> > Changes for v9:
> > - Move macro definitions above where they are used
> > - Remove the brackets around the number
> > - Merging and sorting local variable definitions
> > - free the irq in the error path
> >
> > Changes for v3 (As mailbox patch set):
> > - Update MODULE_AUTHOR.
> > - Remove the extra blank lines.
> >
> > Changes for v2 (As mailbox patch set):
> > - Update the real name and email address.
> > - Remove the ACPI header files.
> > - Update the Copyright from 2024 to 2025.
> > - Update the Module License from "GPL" to "GPL v2"
> > - Add an interface for message length to limit potential out-of-bound access
> >
> >  drivers/mailbox/Kconfig       |  10 +
> >  drivers/mailbox/Makefile      |   2 +
> >  drivers/mailbox/cix-mailbox.c | 635 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 647 insertions(+)
> >  create mode 100644 drivers/mailbox/cix-mailbox.c
> >
> > diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> > index 68eeed660a4a..4fef4797b110 100644
> > --- a/drivers/mailbox/Kconfig
> > +++ b/drivers/mailbox/Kconfig
> > @@ -340,4 +340,14 @@ config THEAD_TH1520_MBOX
> >           kernel is running, and E902 core used for power management among other
> >           things.
> >
> > +config CIX_MBOX
> > +        tristate "CIX Mailbox"
> > +        depends on ARCH_CIX || COMPILE_TEST
> > +        depends on OF
> > +        help
> > +          Mailbox implementation for CIX IPC system. The controller supports
> > +          11 mailbox channels with different operating mode and every channel
> > +          is unidirectional. Say Y here if you want to use the CIX Mailbox
> > +          support.
> > +
> >  endif
> > diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> > index 13a3448b3271..786a46587ba1 100644
> > --- a/drivers/mailbox/Makefile
> > +++ b/drivers/mailbox/Makefile
> > @@ -72,3 +72,5 @@ obj-$(CONFIG_QCOM_CPUCP_MBOX) += qcom-cpucp-mbox.o
> >  obj-$(CONFIG_QCOM_IPCC)                += qcom-ipcc.o
> >
> >  obj-$(CONFIG_THEAD_TH1520_MBOX)        += mailbox-th1520.o
> > +
> > +obj-$(CONFIG_CIX_MBOX) += cix-mailbox.o
> > diff --git a/drivers/mailbox/cix-mailbox.c b/drivers/mailbox/cix-mailbox.c
> > new file mode 100644
> > index 000000000000..eecb53d59dfe
> > --- /dev/null
> > +++ b/drivers/mailbox/cix-mailbox.c
> > @@ -0,0 +1,635 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2025 Cix Technology Group Co., Ltd.
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mailbox_controller.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "mailbox.h"
> > +
> > +/*
> > + * The maximum transmission size is 32 words or 128 bytes.
> > + */
> > +#define CIX_MBOX_MSG_LEN       32      /* Max length = 32 words */
> maybe call it CIX_MBOX_MAX_MSG_WORDS
Yes, CIX_MBOX_MAX_MSG_WORDS is descriptive.

> > +#define MBOX_MSG_LEN_MASK      0x7fL   /* Max length = 128 bytes */
> > +
> > +/* Register define */
> > +#define REG_MSG(n)     (0x0 + 0x4*(n))                 /* 0x0~0x7c */
> > +#define REG_DB_ACK     REG_MSG(CIX_MBOX_MSG_LEN)       /* 0x80 */
> > +#define ERR_COMP       (REG_DB_ACK + 0x4)              /* 0x84 */
> > +#define ERR_COMP_CLR   (REG_DB_ACK + 0x8)              /* 0x88 */
> > +#define REG_F_INT(IDX) (ERR_COMP_CLR + 0x4*(IDX+1))    /* 0x8c~0xa8 */
> > +#define FIFO_WR                (REG_F_INT(MBOX_FAST_IDX+1))    /* 0xac */
> > +#define FIFO_RD                (FIFO_WR + 0x4)                 /* 0xb0 */
> > +#define FIFO_STAS      (FIFO_WR + 0x8)                 /* 0xb4 */
> > +#define FIFO_WM                (FIFO_WR + 0xc)                 /* 0xb8 */
> > +#define INT_ENABLE     (FIFO_WR + 0x10)                /* 0xbc */
> > +#define INT_ENABLE_SIDE_B      (FIFO_WR + 0x14)        /* 0xc0 */
> > +#define INT_CLEAR      (FIFO_WR + 0x18)                /* 0xc4 */
> > +#define INT_STATUS     (FIFO_WR + 0x1c)                /* 0xc8 */
> > +#define FIFO_RST       (FIFO_WR + 0x20)                /* 0xcc */
> > +
> > +/* [0~7] Fast channel
> > + * [8] doorbell base channel
> > + * [9]fifo base channel
> > + * [10] register base channel
> > + */
> > +#define MBOX_FAST_IDX          7
> > +#define MBOX_DB_IDX            8
> > +#define MBOX_FIFO_IDX          9
> > +#define MBOX_REG_IDX           10
> > +#define CIX_MBOX_CHANS         11
> > +
> if it is not really a single controller owning different channels,
> maybe implement only what you currently use.
> 
As mentioned in the previous email, a single controller can support 
multiple different channels. 

> And s/MBOX/CIX/ to keep everything CIX specific. Here and elsewhere.
Okay, I will change it in the next version.

> > +#define MBOX_TX                0
> > +#define MBOX_RX                1
> > +
> > +#define DB_INT_BIT     BIT(0)
> > +#define DB_ACK_INT_BIT BIT(1)
> > +
> > +#define FIFO_WM_DEFAULT                CIX_MBOX_MSG_LEN
> > +#define FIFO_STAS_WMK          BIT(0)
> > +#define FIFO_STAS_FULL         BIT(1)
> > +#define FIFO_STAS_EMPTY                BIT(2)
> > +#define FIFO_STAS_UFLOW                BIT(3)
> > +#define FIFO_STAS_OFLOW                BIT(4)
> > +
> > +#define FIFO_RST_BIT           BIT(0)
> > +
> > +#define DB_INT                 BIT(0)
> > +#define ACK_INT                        BIT(1)
> > +#define FIFO_FULL_INT          BIT(2)
> > +#define FIFO_EMPTY_INT         BIT(3)
> > +#define FIFO_WM01_INT          BIT(4)
> > +#define FIFO_WM10_INT          BIT(5)
> > +#define FIFO_OFLOW_INT         BIT(6)
> > +#define FIFO_UFLOW_INT         BIT(7)
> > +#define FIFO_N_EMPTY_INT       BIT(8)
> > +#define FAST_CH_INT(IDX)       BIT((IDX)+9)
> > +
> > +#define SHMEM_OFFSET 0x80
> > +
> > +enum cix_mbox_chan_type {
> > +       CIX_MBOX_TYPE_DB,
> > +       CIX_MBOX_TYPE_REG,
> > +       CIX_MBOX_TYPE_FIFO,
> > +       CIX_MBOX_TYPE_FAST,
> > +};
> > +
> > +struct cix_mbox_con_priv {
> > +       enum cix_mbox_chan_type type;
> > +       struct mbox_chan        *chan;
> > +       int index;
> > +};
> > +
> > +struct cix_mbox_priv {
> > +       struct device *dev;
> > +       int irq;
> > +       int dir;
> > +       bool tx_irq_mode;       /* flag of enabling tx's irq mode */
> > +       void __iomem *base;     /* region for mailbox */
> > +       unsigned int chan_num;
> tx_irq_mode and chan_num are unused
> 
Okay,I will remove it in the next version.

> > +       struct cix_mbox_con_priv con_priv[CIX_MBOX_CHANS];
> > +       struct mbox_chan mbox_chans[CIX_MBOX_CHANS];
> > +       struct mbox_controller mbox;
> > +       bool use_shmem;
> > +};
> > +
> > +/*
> > + * The CIX mailbox supports four types of transfers:
> > + * CIX_MBOX_TYPE_DB, CIX_MBOX_TYPE_FAST, CIX_MBOX_TYPE_REG, and CIX_MBOX_TYPE_FIFO.
> > + * For the REG and FIFO types of transfers, the message format is as follows:
> > + */
> > +union cix_mbox_msg_reg_fifo {
> > +       u32 length;     /* unit is byte */
> > +       u32 buf[CIX_MBOX_MSG_LEN]; /* buf[0] must be the byte length of this array */
> > +};
> > +
> > +static struct cix_mbox_priv *to_cix_mbox_priv(struct mbox_controller *mbox)
> > +{
> > +       return container_of(mbox, struct cix_mbox_priv, mbox);
> > +}
> > +
> > +static void cix_mbox_write(struct cix_mbox_priv *priv, u32 val, u32 offset)
> > +{
> > +       if (priv->use_shmem)
> > +               iowrite32(val, priv->base + offset - SHMEM_OFFSET);
> > +       else
> > +               iowrite32(val, priv->base + offset);
> > +}
> > +
> > +static u32 cix_mbox_read(struct cix_mbox_priv *priv, u32 offset)
> > +{
> > +       if (priv->use_shmem)
> > +               return ioread32(priv->base + offset - SHMEM_OFFSET);
> > +       else
> > +               return ioread32(priv->base + offset);
> > +}
> > +
> use_shmem is set for only CIX_MBOX_TYPE_DB, but it affects every read/write.
> Maybe instead adjust the base for TYPE_DB?
> 
The reason we introduced use_shmem here is that we had to adjust the base 
address of TYPE_DB to resolve the reg conflict in the DTS. 
This change has virtually no impact on performance.

> > +static bool mbox_fifo_empty(struct mbox_chan *chan)
> > +{
> > +       struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
> > +
> > +       return ((cix_mbox_read(priv, FIFO_STAS) & FIFO_STAS_EMPTY) ? true : false);
> > +}
> > +
> > +/*
> > + *The transmission unit of the CIX mailbox is word.
> > + *The byte length should be converted into the word length.
> > + */
> > +static inline u32 mbox_get_msg_size(void *msg)
> > +{
> > +       u32 len;
> > +
> > +       len = ((u32 *)msg)[0] & MBOX_MSG_LEN_MASK;
> > +       return DIV_ROUND_UP(len, 4);
> > +}
> > +
> > +static int cix_mbox_send_data_db(struct mbox_chan *chan, void *data)
> > +{
> > +       struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
> > +
> > +       /* trigger doorbell irq */
> > +       cix_mbox_write(priv, DB_INT_BIT, REG_DB_ACK);
> > +
> > +       return 0;
> > +}
> > +
> > +static int cix_mbox_send_data_reg(struct mbox_chan *chan, void *data)
> > +{
> > +       struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
> > +       union cix_mbox_msg_reg_fifo *msg = data;
> > +       u32 len, i;
> > +
> > +       if (!data)
> > +               return -EINVAL;
> > +
> > +       len = mbox_get_msg_size(data);
> > +       for (i = 0; i < len; i++)
> > +               cix_mbox_write(priv, msg->buf[i], REG_MSG(i));
> > +
> > +       /* trigger doorbell irq */
> > +       cix_mbox_write(priv, DB_INT_BIT, REG_DB_ACK);
> > +
> > +       return 0;
> > +}
> > +
> > +static int cix_mbox_send_data_fifo(struct mbox_chan *chan, void *data)
> > +{
> > +       struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
> > +       union cix_mbox_msg_reg_fifo *msg = data;
> > +       u32 len, val_32, i;
> > +
> > +       if (!data)
> > +               return -EINVAL;
> > +
> > +       len = mbox_get_msg_size(data);
> > +       cix_mbox_write(priv, len, FIFO_WM);
> > +       for (i = 0; i < len; i++)
> > +               cix_mbox_write(priv, msg->buf[i], FIFO_WR);
> > +
> > +       /* Enable fifo empty interrupt */
> > +       val_32 = cix_mbox_read(priv, INT_ENABLE);
> > +       val_32 |= FIFO_EMPTY_INT;
> > +       cix_mbox_write(priv, val_32, INT_ENABLE);
> > +
> > +       return 0;
> > +}
> > +
> > +static int cix_mbox_send_data_fast(struct mbox_chan *chan, void *data)
> > +{
> > +       struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
> > +       struct cix_mbox_con_priv *cp = chan->con_priv;
> > +       u32 *arg = (u32 *)data;
> > +       int index = cp->index;
> > +
> > +       if (!data)
> > +               return -EINVAL;
> > +
> > +       if (index < 0 || index > MBOX_FAST_IDX) {
> > +               dev_err(priv->dev, "Invalid Mbox index %d\n", index);
> > +               return -EINVAL;
> > +       }
> > +
> > +       cix_mbox_write(priv, arg[0], REG_F_INT(index));
> > +
> > +       return 0;
> > +}
> > +
> > +static int cix_mbox_send_data(struct mbox_chan *chan, void *data)
> > +{
> > +       struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
> > +       struct cix_mbox_con_priv *cp = chan->con_priv;
> > +
> > +       if (priv->dir != MBOX_TX) {
> > +               dev_err(priv->dev, "Invalid Mbox dir %d\n", priv->dir);
> > +               return -EINVAL;
> > +       }
> > +
> > +       switch (cp->type) {
> > +       case CIX_MBOX_TYPE_DB:
> > +               cix_mbox_send_data_db(chan, data);
> > +               break;
> > +       case CIX_MBOX_TYPE_REG:
> > +               cix_mbox_send_data_reg(chan, data);
> > +               break;
> > +       case CIX_MBOX_TYPE_FIFO:
> > +               cix_mbox_send_data_fifo(chan, data);
> > +               break;
> > +       case CIX_MBOX_TYPE_FAST:
> > +               cix_mbox_send_data_fast(chan, data);
> > +               break;
> > +       default:
> > +               dev_err(priv->dev, "Invalid channel type: %d\n", cp->type);
> > +               return -EINVAL;
> > +       }
> > +       return 0;
> > +}
> > +
> > +static void cix_mbox_isr_db(struct mbox_chan *chan)
> > +{
> > +       struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
> > +       u32 int_status;
> > +
> > +       int_status = cix_mbox_read(priv, INT_STATUS);
> > +
> > +       if (priv->dir == MBOX_RX) {
> > +               /* rx interrupt is triggered */
> > +               if (int_status & DB_INT) {
> > +                       cix_mbox_write(priv, DB_INT, INT_CLEAR);
> > +                       mbox_chan_received_data(chan, NULL);
> > +                       /* trigger ack interrupt */
> > +                       cix_mbox_write(priv, DB_ACK_INT_BIT, REG_DB_ACK);
> > +               }
> > +       } else {
> > +               /* tx ack interrupt is triggered */
> > +               if (int_status & ACK_INT) {
> > +                       cix_mbox_write(priv, ACK_INT, INT_CLEAR);
> > +                       mbox_chan_received_data(chan, NULL);
> > +               }
> > +       }
> > +}
> > +
> > +static void cix_mbox_isr_reg(struct mbox_chan *chan)
> > +{
> > +       struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
> > +       u32 int_status;
> > +
> > +       int_status = cix_mbox_read(priv, INT_STATUS);
> > +
> > +       if (priv->dir == MBOX_RX) {
> > +               /* rx interrupt is triggered */
> > +               if (int_status & DB_INT) {
> > +                       u32 data[CIX_MBOX_MSG_LEN], len, i;
> > +
> > +                       cix_mbox_write(priv, DB_INT, INT_CLEAR);
> > +                       data[0] = cix_mbox_read(priv, REG_MSG(0));
> > +                       len = mbox_get_msg_size(data);
> > +                       for (i = 1; i < len; i++)
> > +                               data[i] = cix_mbox_read(priv, REG_MSG(i));
> > +
> > +                       /* trigger ack interrupt */
> > +                       cix_mbox_write(priv, DB_ACK_INT_BIT, REG_DB_ACK);
> > +                       mbox_chan_received_data(chan, data);
> > +               }
> > +       } else {
> > +               /* tx ack interrupt is triggered */
> > +               if (int_status & ACK_INT) {
> > +                       cix_mbox_write(priv, ACK_INT, INT_CLEAR);
> > +                       mbox_chan_txdone(chan, 0);
> > +               }
> > +       }
> > +}
> > +
> > +static void cix_mbox_isr_fifo(struct mbox_chan *chan)
> > +{
> > +       struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
> > +       u32 int_status, status;
> > +
> > +       int_status = cix_mbox_read(priv, INT_STATUS);
> > +
> > +       if (priv->dir == MBOX_RX) {
> > +               /* FIFO waterMark interrupt is generated */
> > +               if (int_status & (FIFO_FULL_INT | FIFO_WM01_INT)) {
> > +                       u32 data[CIX_MBOX_MSG_LEN] = { 0 }, i = 0;
> > +
> > +                       cix_mbox_write(priv, (FIFO_FULL_INT | FIFO_WM01_INT), INT_CLEAR);
> > +                       do {
> > +                               data[i++] = cix_mbox_read(priv, FIFO_RD);
> > +                       } while (!mbox_fifo_empty(chan) && i < CIX_MBOX_MSG_LEN);
> > +
> > +                       mbox_chan_received_data(chan, data);
> > +               }
> > +               /* FIFO underflow is generated */
> > +               if (int_status & FIFO_UFLOW_INT) {
> > +                       status = cix_mbox_read(priv, FIFO_STAS);
> > +                       dev_err(priv->dev, "fifo underflow: int_stats %d\n", status);
> > +                       cix_mbox_write(priv, FIFO_UFLOW_INT, INT_CLEAR);
> > +               }
> > +       } else {
> > +               /* FIFO empty interrupt is generated */
> > +               if (int_status & FIFO_EMPTY_INT) {
> > +                       u32 val_32;
> > +
> > +                       cix_mbox_write(priv, FIFO_EMPTY_INT, INT_CLEAR);
> > +                       /* Disable empty irq*/
> > +                       val_32 = cix_mbox_read(priv, INT_ENABLE);
> > +                       val_32 &= ~FIFO_EMPTY_INT;
> > +                       cix_mbox_write(priv, val_32, INT_ENABLE);
> > +                       mbox_chan_txdone(chan, 0);
> > +               }
> > +               /* FIFO overflow is generated */
> > +               if (int_status & FIFO_OFLOW_INT) {
> > +                       status = cix_mbox_read(priv, FIFO_STAS);
> > +                       dev_err(priv->dev, "fifo overlow: int_stats %d\n", status);
> > +                       cix_mbox_write(priv, FIFO_OFLOW_INT, INT_CLEAR);
> > +               }
> > +       }
> > +}
> > +
> > +static void cix_mbox_isr_fast(struct mbox_chan *chan)
> > +{
> > +       struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
> > +       struct cix_mbox_con_priv *cp = chan->con_priv;
> > +       u32 int_status, data;
> > +
> > +       /* no irq will be trigger for TX dir mbox */
> > +       if (priv->dir != MBOX_RX)
> > +               return;
> > +
> > +       int_status = cix_mbox_read(priv, INT_STATUS);
> > +
> > +       if (int_status & FAST_CH_INT(cp->index)) {
> > +               cix_mbox_write(priv, FAST_CH_INT(cp->index), INT_CLEAR);
> > +               data = cix_mbox_read(priv, REG_F_INT(cp->index));
> > +               mbox_chan_received_data(chan, &data);
> > +       }
> > +}
> > +
> > +static irqreturn_t cix_mbox_isr(int irq, void *arg)
> > +{
> > +       struct mbox_chan *chan = arg;
> > +       struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
> > +       struct cix_mbox_con_priv *cp = chan->con_priv;
> > +
> > +       switch (cp->type) {
> > +       case CIX_MBOX_TYPE_DB:
> > +               cix_mbox_isr_db(chan);
> > +               break;
> > +       case CIX_MBOX_TYPE_REG:
> > +               cix_mbox_isr_reg(chan);
> > +               break;
> > +       case CIX_MBOX_TYPE_FIFO:
> > +               cix_mbox_isr_fifo(chan);
> > +               break;
> > +       case CIX_MBOX_TYPE_FAST:
> > +               cix_mbox_isr_fast(chan);
> > +               break;
> > +       default:
> > +               dev_err(priv->dev, "Invalid channel type: %d\n", cp->type);
> > +               return IRQ_NONE;
> > +       }
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +static int cix_mbox_startup(struct mbox_chan *chan)
> > +{
> > +       struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
> > +       struct cix_mbox_con_priv *cp = chan->con_priv;
> > +       int index = cp->index, ret;
> > +       u32 val_32;
> > +
> > +       ret = request_irq(priv->irq, cix_mbox_isr, 0,
> > +                         dev_name(priv->dev), chan);
> The same irq is requested for each channel. How do you expect it to
> work? Maybe request it just once in probe and pass the 'priv' instead
> of 'chan' , and in the cix_mbox_isr handle according to INT_STATUS
> 
For the same mailbox controller, there won't be multiple channels 
simultaneously requesting the same IRQ, so there won't be an issue 
here. As you mentioned, if we need to handle multiple channels working 
concurrently in the future, we would need to modify cix_mbox_isr. 
However, that is not required at the moment.

> > +       if (ret) {
> > +               dev_err(priv->dev, "Unable to acquire IRQ %d\n", priv->irq);
> > +               return ret;
> > +       }
> > +
> > +       switch (cp->type) {
> > +       case CIX_MBOX_TYPE_DB:
> > +               /* Overwrite txdone_method for DB channel */
> > +               chan->txdone_method = TXDONE_BY_ACK;
> > +               fallthrough;
> > +       case CIX_MBOX_TYPE_REG:
> > +               if (priv->dir == MBOX_TX) {
> > +                       /* Enable ACK interrupt */
> > +                       val_32 = cix_mbox_read(priv, INT_ENABLE);
> > +                       val_32 |= ACK_INT;
> > +                       cix_mbox_write(priv, val_32, INT_ENABLE);
> > +               } else {
> > +                       /* Enable Doorbell interrupt */
> > +                       val_32 = cix_mbox_read(priv, INT_ENABLE_SIDE_B);
> > +                       val_32 |= DB_INT;
> > +                       cix_mbox_write(priv, val_32, INT_ENABLE_SIDE_B);
> > +               }
> > +               break;
> > +       case CIX_MBOX_TYPE_FIFO:
> > +               /* reset fifo */
> > +               cix_mbox_write(priv, FIFO_RST_BIT, FIFO_RST);
> > +               /* set default watermark */
> > +               cix_mbox_write(priv, FIFO_WM_DEFAULT, FIFO_WM);
> > +               if (priv->dir == MBOX_TX) {
> > +                       /* Enable fifo overflow interrupt */
> > +                       val_32 = cix_mbox_read(priv, INT_ENABLE);
> > +                       val_32 |= FIFO_OFLOW_INT;
> > +                       cix_mbox_write(priv, val_32, INT_ENABLE);
> > +               } else {
> > +                       /* Enable fifo full/underflow interrupt */
> > +                       val_32 = cix_mbox_read(priv, INT_ENABLE_SIDE_B);
> > +                       val_32 |= FIFO_UFLOW_INT|FIFO_WM01_INT;
> > +                       cix_mbox_write(priv, val_32, INT_ENABLE_SIDE_B);
> > +               }
> > +               break;
> > +       case CIX_MBOX_TYPE_FAST:
> > +               /* Only RX channel has intterupt */
> > +               if (priv->dir == MBOX_RX) {
> > +                       if (index < 0 || index > MBOX_FAST_IDX) {
> > +                               dev_err(priv->dev, "Invalid index %d\n", index);
> > +                               ret = -EINVAL;
> > +                               goto failed;
> > +                       }
> > +                       /* enable fast channel interrupt */
> > +                       val_32 = cix_mbox_read(priv, INT_ENABLE_SIDE_B);
> > +                       val_32 |= FAST_CH_INT(index);
> > +                       cix_mbox_write(priv, val_32, INT_ENABLE_SIDE_B);
> > +               }
> > +               break;
> > +       default:
> > +               dev_err(priv->dev, "Invalid channel type: %d\n", cp->type);
> > +               ret = -EINVAL;
> > +               goto failed;
> > +       }
> > +       return 0;
> > +
> > +failed:
> > +       free_irq(priv->irq, chan);
> > +       return ret;
> > +}
> > +
> > +static void cix_mbox_shutdown(struct mbox_chan *chan)
> > +{
> > +       struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
> > +       struct cix_mbox_con_priv *cp = chan->con_priv;
> > +       int index = cp->index;
> > +       u32 val_32;
> 
> Never saw this style before, may simply use val
> 
Yes,I will change it in the next version.

> > +
> > +       switch (cp->type) {
> > +       case CIX_MBOX_TYPE_DB:
> > +       case CIX_MBOX_TYPE_REG:
> > +               if (priv->dir == MBOX_TX) {
> > +                       /* Disable ACK interrupt */
> > +                       val_32 = cix_mbox_read(priv, INT_ENABLE);
> > +                       val_32 &= ~ACK_INT;
> > +                       cix_mbox_write(priv, val_32, INT_ENABLE);
> > +               } else if (priv->dir == MBOX_RX) {
> > +                       /* Disable Doorbell interrupt */
> > +                       val_32 = cix_mbox_read(priv, INT_ENABLE_SIDE_B);
> > +                       val_32 &= ~DB_INT;
> > +                       cix_mbox_write(priv, val_32, INT_ENABLE_SIDE_B);
> > +               }
> > +               break;
> > +       case CIX_MBOX_TYPE_FIFO:
> > +               if (priv->dir == MBOX_TX) {
> > +                       /* Disable empty/fifo overflow irq*/
> > +                       val_32 = cix_mbox_read(priv, INT_ENABLE);
> > +                       val_32 &= ~(FIFO_EMPTY_INT | FIFO_OFLOW_INT);
> > +                       cix_mbox_write(priv, val_32, INT_ENABLE);
> > +               } else if (priv->dir == MBOX_RX) {
> > +                       /* Disable fifo WM01/underflow interrupt */
> > +                       val_32 = cix_mbox_read(priv, INT_ENABLE_SIDE_B);
> > +                       val_32 &= ~(FIFO_UFLOW_INT | FIFO_WM01_INT);
> > +                       cix_mbox_write(priv, val_32, INT_ENABLE_SIDE_B);
> > +               }
> > +               break;
> > +       case CIX_MBOX_TYPE_FAST:
> > +               if (priv->dir == MBOX_RX) {
> > +                       if (index < 0 || index > MBOX_FAST_IDX) {
> > +                               dev_err(priv->dev, "Invalid index %d\n", index);
> > +                               break;
> > +                       }
> > +                       /* Disable fast channel interrupt */
> > +                       val_32 = cix_mbox_read(priv, INT_ENABLE_SIDE_B);
> > +                       val_32 &= ~FAST_CH_INT(index);
> > +                       cix_mbox_write(priv, val_32, INT_ENABLE_SIDE_B);
> > +               }
> > +               break;
> > +
> > +       default:
> > +               dev_err(priv->dev, "Invalid channel type: %d\n", cp->type);
> > +               break;
> > +       }
> > +
> > +       free_irq(priv->irq, chan);
> > +}
> > +
> > +static const struct mbox_chan_ops cix_mbox_chan_ops = {
> > +       .send_data = cix_mbox_send_data,
> > +       .startup = cix_mbox_startup,
> > +       .shutdown = cix_mbox_shutdown,
> > +};
> > +
> > +static void cix_mbox_init(struct cix_mbox_priv *priv)
> > +{
> > +       struct cix_mbox_con_priv *cp;
> > +       int i;
> > +
> > +       for (i = 0; i < CIX_MBOX_CHANS; i++) {
> > +               cp = &priv->con_priv[i];
> > +               cp->index = i;
> > +               cp->chan = &priv->mbox_chans[i];
> > +               priv->mbox_chans[i].con_priv = cp;
> > +               if (cp->index <= MBOX_FAST_IDX)
> > +                       cp->type = CIX_MBOX_TYPE_FAST;
> > +               if (cp->index == MBOX_DB_IDX) {
> > +                       cp->type = CIX_MBOX_TYPE_DB;
> > +                       priv->use_shmem = true;
> > +               }
> > +               if (cp->index == MBOX_FIFO_IDX)
> > +                       cp->type = CIX_MBOX_TYPE_FIFO;
> > +               if (cp->index == MBOX_REG_IDX)
> > +                       cp->type = CIX_MBOX_TYPE_REG;
> > +       }
> > +}
> > +
> > +static int cix_mbox_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct cix_mbox_priv *priv;
> > +       const char *dir_str;
> > +       int ret;
> > +
> > +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +       if (!priv)
> > +               return -ENOMEM;
> > +
> > +       priv->dev = dev;
> > +       priv->base = devm_platform_ioremap_resource(pdev, 0);
> > +       if (IS_ERR(priv->base))
> > +               return PTR_ERR(priv->base);
> > +
> > +       priv->irq = platform_get_irq(pdev, 0);
> > +       if (priv->irq < 0)
> > +               return priv->irq;
> > +
> > +       if (device_property_read_string(dev, "cix,mbox-dir", &dir_str)) {
> > +               dev_err(priv->dev, "cix,mbox_dir property not found\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (!strcmp(dir_str, "tx"))
> > +               priv->dir = 0;
> > +       else if (!strcmp(dir_str, "rx"))
> > +               priv->dir = 1;
> > +       else {
> > +               dev_err(priv->dev, "cix,mbox_dir=%s is not expected\n", dir_str);
> > +               return -EINVAL;
> > +       }
> > +
> > +       cix_mbox_init(priv);
> > +
> > +       priv->mbox.dev = dev;
> > +       priv->mbox.ops = &cix_mbox_chan_ops;
> > +       priv->mbox.chans = priv->mbox_chans;
> > +       priv->mbox.txdone_irq = true;
> > +       priv->mbox.num_chans = CIX_MBOX_CHANS;
> > +       priv->mbox.of_xlate = NULL;
> > +
> > +       platform_set_drvdata(pdev, priv);
> > +       ret = devm_mbox_controller_register(dev, &priv->mbox);
> > +       if (ret)
> > +               dev_err(dev, "Failed to register mailbox %d\n", ret);
> > +
> > +       return ret;
> > +}
> > +
> > +static const struct of_device_id cix_mbox_dt_ids[] = {
> > +       { .compatible = "cix,sky1-mbox" },
> > +       { },
> > +};
> > +MODULE_DEVICE_TABLE(of, cix_mbox_dt_ids);
> > +
> > +static struct platform_driver cix_mbox_driver = {
> > +       .probe = cix_mbox_probe,
> > +       .driver = {
> > +               .name = "cix_mbox",
> > +               .of_match_table = cix_mbox_dt_ids,
> > +       },
> > +};
> > +
> > +static int __init cix_mailbox_init(void)
> > +{
> > +       return platform_driver_register(&cix_mbox_driver);
> > +}
> > +arch_initcall(cix_mailbox_init);
> > +
> > +MODULE_AUTHOR("Cix Technology Group Co., Ltd.");
> > +MODULE_DESCRIPTION("CIX mailbox driver");
> > +MODULE_LICENSE("GPL");
> 
> GPL v2 ? according to the SPDX-License-Identifier
> 
> And please make sure you run scripts/checkpatch.pl

Yes, I'm also confused here. I was previously using GPL v2, 
but when I ran checkpatch.pl, it triggered a warning due to 
commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE 'GPL' 
vs. 'GPL v2' bogosity").  So I changed it to GPL.

Thanks 
Guomin Chen

