Return-Path: <linux-kernel+bounces-758375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF650B1CE33
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCD5D7AA05D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C59224AEB;
	Wed,  6 Aug 2025 21:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="num9sttN"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C63220F29;
	Wed,  6 Aug 2025 21:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754514265; cv=fail; b=O2JkP0daaSPhZDXCizecCg9E0lVQCJS/rf5MM/+z7b/ia7ybSuM/8WyeI2DakupoMGbC5X9a2cBcdQlT4UQw7DbtefFBXJg7uWP9BriBU8KyKE4aIPawcA8qoystx/S9kEOGyb6Elt/pdLqChE6fTTErNvtw/dR7AnO9U6TidJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754514265; c=relaxed/simple;
	bh=RtFc+lx1HsnjAQ48Z5ifILnuRr/yh8B1KdcptJSiwKA=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B697A66ntjtZ8ImBiJvF4xv6UjnIyarC8NNRZrFN4LjQDasq6ocJ1JNKGriza5RJeOadbhbnY8zqxnfdVKWTfC4kB35Qe7a6YAwO5f1Jm95Sd76/5vZNxLqM0tfnfSzQl0WA5NMauJYHPy1yFyJHDrjENysaO5GfRZuuQTmMo+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=num9sttN; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iT9rQIne3NXr/VUp7SBFCkHj1H1vlpp1ie5umUeFXIe3ICLg6+hMUq3xw29R6H9zjt5ciSVlTtGY5d07SXb7O+9N42xqs7swD0UpCSxeNHZvyRVcqCbk653pQluO1ZrHGWznmQAsfptGryHU4sb8Oabo3T24gCPfVxZ/aJ7rT6sEOKCyrKRkMDPVttBlo/Sv8r24sqnXxGDspqjOYwgEv3c2MFUmwW59atmfdwpsRFlj7oVboEhbpjRCXLwuHht0f70ilupqnoluz6uUjdw4E4c8PAgiFmMZIO+Gj9aiwSjo+aaGQ5+cOz+0RaPhUYoDot65vaAf8ncS5bU5CDh+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmuubP+BYZVvpXJm+vlUQvuxrJYPFrcsqKofE9fCJgs=;
 b=A6mX77h5QasBPVvJSuwy+7IXS1ZE2P9GmHggmldqkJiYiFOlAljJoV6y3r8T2V0xK+S+Q5xDERUnTsycptnv+JE8MvUm1bFgCQjL3TlZuKDdKoMa7+gGbMYgaWpIhDkmE5SY8aLIWJa0bLyReclwkBI1nc6oUgzqhFlYi9bk7jwJtbRV8SyY5IfTP2PXyteXDwibtUh2QLgCFzn4eBu+GpwUAyadq4SqEN18OT/xRSSCXiiwSBqgue6mQ7RzWlWDrktHBeU5MqeswSmJjb9nFSED0T4U56rCk+2+91ogdAYkNgqS7nqN66jlfsNGU34NgEo0xT4ossu/bKR2ve75RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmuubP+BYZVvpXJm+vlUQvuxrJYPFrcsqKofE9fCJgs=;
 b=num9sttNmxq+u7s5V46B84rutpQZkMRdAQzAfsNoUn5f8KhRdVfVUXIe8hT37uSGD7xa0kjBWDu3a2Iaolszu6vot8KcyvPq+tRWZ/fMiyZ3pOKzOq0b04Txdwo2uJitu3co3544/ZjloAi6s0k9JQFepyrHOdYbwdspA0SyCzM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by SA0PR12MB4367.namprd12.prod.outlook.com
 (2603:10b6:806:94::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Wed, 6 Aug
 2025 21:04:20 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Wed, 6 Aug 2025
 21:04:20 +0000
Message-ID: <829a2a91-c599-4973-a4b3-015323875402@amd.com>
Date: Wed, 6 Aug 2025 16:04:16 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v16 08/34] x86,fs/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
Reply-To: babu.moger@amd.com
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, james.morse@arm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc: Dave.Martin@arm.com, x86@kernel.org, hpa@zytor.com,
 akpm@linux-foundation.org, paulmck@kernel.org, rostedt@goodmis.org,
 Neeraj.Upadhyay@amd.com, david@redhat.com, arnd@arndb.de, fvdl@google.com,
 seanjc@google.com, jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
 xin@zytor.com, manali.shukla@amd.com, tao1.su@linux.intel.com,
 sohil.mehta@intel.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 peterz@infradead.org, xin3.li@intel.com, kan.liang@linux.intel.com,
 mario.limonciello@amd.com, thomas.lendacky@amd.com, perry.yuan@amd.com,
 gautham.shenoy@amd.com, chang.seok.bae@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1753467772.git.babu.moger@amd.com>
 <bb06941505a33df996fe0e8d997c2eb2c4f4b379.1753467772.git.babu.moger@amd.com>
 <aed0a452-9b16-46ca-8075-7be9eaa0cfd1@intel.com>
Content-Language: en-US
In-Reply-To: <aed0a452-9b16-46ca-8075-7be9eaa0cfd1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0259.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::24) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|SA0PR12MB4367:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eb6c1ea-80ca-41f7-07f2-08ddd52cd051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGwzL09FN05KM21JeGZiTXpoMGdWVktlcGlLM1drZTkrZm1nbktLVXBDY2pL?=
 =?utf-8?B?RjFkeC9kWU93dVcxNFZjOHFiQktTNGRxUXFKZHcweTVhSkw2K0RjbkZ2UHBo?=
 =?utf-8?B?bG41dlpPQ2ZMdU5RVXlzS2dyNkZTT1cybUZTcnBHWjN2b05DOVZuc2lkUDhB?=
 =?utf-8?B?LzZtaG9YNTNvNThia2w0WVVtMTkrMWxobVdzMGtDV084MjhwRW1Yc09idE16?=
 =?utf-8?B?bHpMa2xCeVhxMXdZNCsxNnc2dSs5dVl3UzR3YTNLaU8zYlpjRUNrVVgrQktQ?=
 =?utf-8?B?SnI5QytEMzhTR2YyTGxxT2V2aVBTbkl1SldyTjM0ZUx4UjZ6aVJqZzIySUkv?=
 =?utf-8?B?eWVqR1RLMWdPOXhiSkIvTklLS2ppWGJIUDQyMHpnNVU3L3ZGOXNuVTQyZEJm?=
 =?utf-8?B?VFozUS9LSENzZ1BoN1BxRTVIVWhnZGpERnpoemlxNy9yM2lKRy93b29aZndu?=
 =?utf-8?B?K1VKZjN1NlBqQWZqaVk5V0pzZThkNGhRSklaS29mVk5ZT2FySVpVV0xtSHVo?=
 =?utf-8?B?RFpmaUx4Q3ppMW9QdDFLa05FL3g5bFZRamoyZ0VTRHV4Sko4a0twRDgyd1Ju?=
 =?utf-8?B?QmFXREc4SWlBeGlHSURqb1dac3hjUjAvQjNWUkV2dWhtNmJ2bkFtbWFrWHNv?=
 =?utf-8?B?SFBvR2h4RVFOUTN5aUZNWVBGLzlDUHpteDVpTnp6eThyZmNRd0ZLN2JYd0ty?=
 =?utf-8?B?bGFSTGlBMzRoeFJmWDByM0JVS2JJcTVOZEY0NThodnBMS3U0K3VWTUxnUnN3?=
 =?utf-8?B?Z1dnUVoxMDBtOC9vc1JTRG9nRzA2bDZlWDJBcmlZemZuYXNOanFkVStyQzdx?=
 =?utf-8?B?b2pVM0NSMG56YWdGQ0NRNVpuR2p0VHZ2M2M5QXYrRFdHMDJGVjU0Z25JUmZV?=
 =?utf-8?B?V1ZScTlpZVE0Y2M2RHBMenZmR0MwZ3lWdHUyZG43Yk8ya2hrSGtwMDVsTVBM?=
 =?utf-8?B?aktlK0J0T3lsTW8wYWRXNlpmdlpYNTRRcEJEMnpKQ0lMdi9QR2MxMlZpRnVR?=
 =?utf-8?B?WGFzWXBaVXRQZTcwdW9aWHhXamdKTllIajNFdys2dDFqR1E2VUlOd2Yzai95?=
 =?utf-8?B?aC82bU5UTGt2Vk1iWjNGMGtKRTRraU1SL3lNQ2dmZXY4TWNJb043Ri9zbGho?=
 =?utf-8?B?dDdCWE9nRkdJUXNXYVViR3FQdG03anFEYW0xbFdMZDdRMXhweGVJSVJJcVBO?=
 =?utf-8?B?Z0gySXlMQktpZmZvdEx1eFFVWVVHUzhzdGhISk9vbGhGSmlidGhrWjNxNm5n?=
 =?utf-8?B?cWJTcGhlR2cvME5sU21LZWhjZVBKakNxOFVRcS9QVHYzTDQxUEJIeTJBZmls?=
 =?utf-8?B?cVRQMFBvcnF4Z1UzT0IyWFdwbFRmNVNRMnZkbVVIY0x5eFlPNFJSNjZCNmp4?=
 =?utf-8?B?WnQxTXlydEVibUNjSkVwTHQveUROV1R5R3ViZE5reml5T29BNEo5WkxzYk1U?=
 =?utf-8?B?amc3NWluZWhudVNORHRndEUyNy9SZG91bk9acDZvMld0VzFZbTIrbWEvNGdm?=
 =?utf-8?B?dnZtUVRmWWVtUHhhV2NPUGQ5TW9qRWI2RzhVaXBwd0xxVmorTjVXdlhOSE11?=
 =?utf-8?B?dHludThUQS9ybGIzVStuM1VTMWlDQXhhUFF0c3dQQlZsVk8rMnREc3E3c2hz?=
 =?utf-8?B?cmZ5N0ZpaXRHaFUrMzRPbGJaVlhuZkVpeWk2RkpVaHoxcEdGWnFsQU45K1dy?=
 =?utf-8?B?cW1STldnWVMxa1NHZlVrUVZTNWF4Z0JkTVNmRURDeWVadUdNa1FBcjNWZXN2?=
 =?utf-8?B?UjFBU09sajhDSmlIaE9kdEprNkhKd1NMK0Ftc3RicmVNejR2QlZQV2owNHhO?=
 =?utf-8?B?UmVwU3B6Yk5TcmZMV1VSc281Q3NoREIyUVgwRzFrSzZxMitFYkpvWE84VmZH?=
 =?utf-8?B?SG91RnZVamc0K0hmMUJRd0pMNGNtdTdUOWRpZE5HUjlBZmRPcWplQ250MXd2?=
 =?utf-8?Q?zFJMDcbU0ps=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3czRlo2YjIxNDl1cDJKN2xGVE0rNk1pVFJJNVVVSHlxVVFOUlloaXluaWhq?=
 =?utf-8?B?L1dQVjlOOWNyZXZnY0tNVDlSb0dMRG81MC9VbVRGVS9Zd3E1RTdqOS80QmVw?=
 =?utf-8?B?M2tXTXJFbyt5RHdzNW9rZEs2dzFsU2lJeTgyRFFKa2xxNk5xb3hDNlZRalVw?=
 =?utf-8?B?SXhCcHdxMFNYNGVMYmVyVSt5aDB2dkgyb0dtaEcyWlBWMW11a1NMdGtXSDBM?=
 =?utf-8?B?VUxEY3FpSm9reHdSMkZmWXRSejdNY0dDMGFvTjBGdmNxYVVxOGZ5NE9GYmpR?=
 =?utf-8?B?OEdydENweHJXZGl2V0VxWlZOU1J4VkpxdU8xNDZmOG0yeTBpN2ZmZldpUU1Y?=
 =?utf-8?B?c3BxUUxpNTFEVHMzUHhmdGRTc3V0Zyt3RklVVFNLSURFMjlxd0FCdXNNQ1VX?=
 =?utf-8?B?R1MvY3c5WU91TVptZ0graGxtMFBqMm9tYjVYME83aW1IdjBsODBXYndqV09r?=
 =?utf-8?B?YS9OTGdWQmVDUWx1TGo0QVEyU1ZOWnUyeW5JbkFUWERWOWhPMUNselg5SUUy?=
 =?utf-8?B?RGFWZ0F0VW1ld0xPTW9aNC93VE00RTl0QzJ6bDlaVTZuVnQ0cVc0cWl5eHNh?=
 =?utf-8?B?TFhUZ1F3dDN4RC95WUVKNXpPN2RoMmV0ZTJSb2t3RVl4eGdwbUNwTlNTdm42?=
 =?utf-8?B?K0xWUW1Vc1VmcmhwcnI3Z1BoSkM3aUF5SUF1OXV6TWo2eXo3WWxzQ2psemln?=
 =?utf-8?B?QytHR3JDdTA3QXVzK0xld0hIWHRkcEg4TjIzOVNEaWh2ZWs2L1RCdTY5akE2?=
 =?utf-8?B?cWRDUW9PRUhGNXA4WjRxV0drLzNGZWgrRnVPdzhTN1BDTVVHTHByZS95QkdB?=
 =?utf-8?B?OEZNa1NJRWh3T2MyZmhROVpJVFJITTg0czlkSkJWSlBwM3VIZTBidDFBUWJr?=
 =?utf-8?B?UWtpNU8rUW9ENUNxcDNERmkxVVU5dkxVMjUvalVXSkVadFZVc0VuMHNJcjJ5?=
 =?utf-8?B?amloWHdoYjR5SUU2MTNpa1cwODJuN0E0NzVzNGtCQStHRVFiY1A1eFFjVlY3?=
 =?utf-8?B?aGdXbEFkTWN1bUlWUkRQUXVIVmFMdi8yQ1hZTWpneEJ4RTkyU1Nkd1BxMDBU?=
 =?utf-8?B?bmQ1OFN4Z2d5YnBrQmtMVUZ3SzQ3eWV2REJBeXJnVXBhaWsranVTZXJydEhl?=
 =?utf-8?B?RHNlRE55NGFXWTBpUHBjam5XblBTL0RsVzluaFN6WGpZa1dpWEMyS29PMlF6?=
 =?utf-8?B?RC95dFliR001QVR0dFpSZU9MSHNGSEJ1WjJ5enJQTVhldFRReGJtaGdCL0Ju?=
 =?utf-8?B?NDN3d3JqWEdDYUw2SUx3eHpablRBL2RwMFlDNWFVYit5b1V6M0hTY3NKL1lh?=
 =?utf-8?B?WGo1ZmVsdmh2UGNEcEJKd0ptR0xCaEoxS0I4TWxTS2NaY2dra3BiWVAwL3Ja?=
 =?utf-8?B?Ukk2UWpVNE9QdVhCRDF2SUNFei9INlFBdmQvRmxMMVJsdTlzYVVnZ3lBWEMr?=
 =?utf-8?B?S0c1MFBzeFVVdG03Ny83MUVKdm1Qdmppd2N3a3JtRm9lLzUrSFZSTXB6bE16?=
 =?utf-8?B?YlBobjQ2c0dnVWQydmU0Z2VXWnlJaWdwbTJ0OVVZeHlqUzJjdUdBdGJVNStz?=
 =?utf-8?B?cWhuSTY0SjNyNUxuNXhnZWtMZVhjaTNXcm9QOTY1Y084c3gzUEQwL1AvalB6?=
 =?utf-8?B?WjltQ295YWhRN2ZQbzdFRjhETnVrK0FaOHlSRmtocTBsdnpvRURNV2FHTVpD?=
 =?utf-8?B?RTZzclpRT0RrcEJTQUNsZGxlYWs5UUt5WHJrbnhHdFdXaXdPcDlPL2g2NC9m?=
 =?utf-8?B?U2JGR0VMWEJWci9yL3dCSTh0SXkxYVg4Mk51SnhYd1dGUG5wZDVFZnArQkFK?=
 =?utf-8?B?cW5YdUxmT2s5THE3dkVkdWJYT291d2Z3OVMreitIMjF4V0tGM3ZOVGxVT1RU?=
 =?utf-8?B?M0RML0xxWHpja29XME9lUkRXQWh5UmxLSzlRRnVSM1BwdWRmeFJabjBBL3Q5?=
 =?utf-8?B?TVlJRHlMRElHbkxyalo0UVpGLzNiQTRvM1JIVU5manZEcC9yeFI0UHAzK05P?=
 =?utf-8?B?MGZ5QUkyQjRzdm1Da2NUN0tSeFpGYkV1V1pTbk12Wi9VdFc0dVJSZGNIWS9a?=
 =?utf-8?B?cU5TT0c2ZDhva1JWR2J0R3N4NDRDR2hpWndxa0gzMDhjbStHWjl3b1RHNm5R?=
 =?utf-8?Q?EDVM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb6c1ea-80ca-41f7-07f2-08ddd52cd051
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 21:04:20.8147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xu2gjq+Rrc20gGSBKA0GpvFPzQKAhdrpWolX7s2i63mfKawdF5fyowq7vpaPGhib
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4367

Hi Reinette,

On 7/30/25 14:49, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/25/25 11:29 AM, Babu Moger wrote:
>> ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
>> Bits Description
>> 15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
>>      Monitoring Counter ID + 1
>>
>> The feature details are documented in APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC).
>>
>> Detect the feature and number of assignable counters supported. For
>> backward compatibility, upon detecting the assignable counter feature,
>> enable the mbm_total_bytes and mbm_local_bytes events that users are
>> familiar with as part of original L3 MBM support.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 267e9206a999..09cb5a70b1cb 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -883,6 +883,8 @@ static __init bool get_rdt_mon_resources(void)
>>  		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
>>  		ret = true;
>>  	}
>> +	if (rdt_cpu_has(X86_FEATURE_ABMC))
>> +		ret = true;
>>  
>>  	if (!ret)
>>  		return false;
>> @@ -990,7 +992,8 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
>>  
> 
> To complement the change below, shouldn't the snippet that precedes it look like:
> 	if (!cpu_has(c, X86_FEATURE_CQM_LLC) && !cpu_has(c, X86_FEATURE_ABMC)) {
> 		...
> 		return;
> 	}


Sure. Added now.

> 
>>  	if (cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC) ||
>>  	    cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL) ||
>> -	    cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)) {
>> +	    cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL) ||
>> +	    cpu_has(c, X86_FEATURE_ABMC)) {
>>  		u32 eax, ebx, ecx, edx;
>>  
>>  		/* QoS sub-leaf, EAX=0Fh, ECX=1 */
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 2558b1bdef8b..0a695ce68f46 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -339,6 +339,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>  	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
>>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>  	unsigned int threshold;
>> +	u32 eax, ebx, ecx, edx;
>>  
>>  	snc_nodes_per_l3_cache = snc_get_config();
>>  
>> @@ -368,14 +369,18 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>  	 */
>>  	resctrl_rmid_realloc_threshold = resctrl_arch_round_mon_val(threshold);
>>  
>> -	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
>> -		u32 eax, ebx, ecx, edx;
>> -
>> +	if (rdt_cpu_has(X86_FEATURE_BMEC) || rdt_cpu_has(X86_FEATURE_ABMC)) {
>>  		/* Detect list of bandwidth sources that can be tracked */
>>  		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
>>  		r->mon.mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
> 
> I interpret this mbm_cfg_mask initialization that an ABMC system will report which of
> the memory transactions can be monitored. 
> In patch #15 "fs/resctrl: Introduce event configuration field in struct mon_evt"
> the event configurations of memory transactions that should be monitored are hardcoded
> as below without taking into account what the system supports:
> 
> 	resctrl_mon_resource_init() {
> 		...
> 		mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].evt_cfg = MAX_EVT_CONFIG_BITS;
> 		mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].evt_cfg = READS_TO_LOCAL_MEM |
> 								   READS_TO_LOCAL_S_MEM |
> 								   NON_TEMP_WRITE_TO_LOCAL_MEM;
> 		...
> 	}

That is correct.
Changed the assignment.

mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].evt_cfg = r->mon.mbm_cfg_mask;
mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].evt_cfg =
r->mon.mbm_cfg_mask & (READS_TO_LOCAL_MEM | READS_TO_LOCAL_S_MEM |
NON_TEMP_WRITE_TO_LOCAL_MEM);



> 
> It may thus be that a system may not support all memory transactions it is configured to
> monitor. It seems to me that the initialization done in resctrl_mon_resource_init() needs
> to take r->mon.mbm_cfg_mask (what the system supports) into account? If so, then
> the same hardcoding done by patch #32 in resctrl_mbm_assign_mode_write() should
> also be changed.

Yes. Sure.

-- 
Thanks
Babu Moger


