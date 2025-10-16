Return-Path: <linux-kernel+bounces-856268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AEDBE3B32
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECFF1587CE9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1053339B33;
	Thu, 16 Oct 2025 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1RlNsK8r"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013039.outbound.protection.outlook.com [40.93.196.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4AA339B53
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621279; cv=fail; b=uKbIMMFYxmwkUmyuIM8DEoKBtnBOOyg3o1Vg8FVT25o41YKSgX68L8NpMk1xVMVUyD1sgICkjqe83djw5K3ApBYvWoWt3NODGoIqqSsbwhJbEOoxeSNszjJqFKZ/3WLnR+ON1HdzOIRmZmQhI32gZCAGSTC57pBVbN+hh18Eu6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621279; c=relaxed/simple;
	bh=BTVPkuj7zFfGXgwvp0V9CkPZndBSBvUy3vs5TZj1Z5s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U8+a+AQA5JNvwsKaxGO0EuaEHFuFT8qyV2aPFBOCl1vAODCNoqwHhd6GgJPs+BoA/jIM3O4G0VH18yofcbEjThABsSAG3c6Dm8oYefSAtxvMkaDTvAnIVrA2oB1zae2aqmB3jI6XBKJLM5D7/AGp0vWos5/4AFTk8YdpcgaXOpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1RlNsK8r; arc=fail smtp.client-ip=40.93.196.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5JAdjDNt3upiyXSFRa3FguW1WEo+FMRcpmSsqMHlcMeJWAFE/S2lVGSEgvr59s5ikE1mnBkNTWyO6MANQnpom7el8Hawve7/5tFMWVlFWE0liQlj9l1n7kFia9Z9DPkczNfDqlqbay9pTNihWt3skWEXP7jsw68xryyFzNaA4H0rP6eU0vo+WQd7noiwl4VbizpNOHGGe8JUW6iCGLEJWVBfLwskS4x2FESAgD8gomhsj6imoo97FgXn+TnStcKk+rXinfDXaEXc2RoH/pB1UboPnH7glL9if8m1r+aDaqwLK3ZWNj5MkRtyR5jXoiCfEM5vhLBSzy7UfXpbFBX7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=si5XXMO6bV8e26qqRIjKFaBPeLYKN/pG0oHvu5ZPhao=;
 b=J6U/m+4cZfeMWSGGXZBaeuLkNyHmsiiZUtUTSCmQ4DCuxzEoFnOYBoN66p9vd7FCjc4y277ioKhhUtUl4HUEiISEfg44WA0512jnQ0kvuPZ7sSd5Fncqlv/WmAXgPvTFMQyhAIFQ9EjlFwLIfdPTdJkl+3MM2BE6ICBLVF4syP5UL9nrWleVw/p46VGdG32WI30QetTSUyK7r1Vt+RZaoVCCgN0nuUTm26TmMwpqbdN3nh2nnKKdkDZJ6El0rRlw/JdPO/HENesAOXikXpMdyzOHDaGxPYjz2UCIwoB6VmMYf/04CbH7xEnEP2JggWuCuGzqQnsQ33o+fO38dSu+TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si5XXMO6bV8e26qqRIjKFaBPeLYKN/pG0oHvu5ZPhao=;
 b=1RlNsK8rSsCZ7V5zTYa9lCpIBjeoHMuUJxORrf+bf/fcW11OheeVGFGbUYnE40R0+xQRiQR6iq7F9VOeW2PHTbjMhU+mn4r26PizLu3NsnY9zYaX8LwpcR3jeFnv3lPPoI38NjGTiA1lkt7UfUdI9Sk8JtXOA9/tuAIPE7GMCgg=
Received: from DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14)
 by DS4PR12MB9770.namprd12.prod.outlook.com (2603:10b6:8:29d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 13:27:53 +0000
Received: from DS0PR12MB9273.namprd12.prod.outlook.com
 ([fe80::a3be:28f9:394b:74e6]) by DS0PR12MB9273.namprd12.prod.outlook.com
 ([fe80::a3be:28f9:394b:74e6%3]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 13:27:53 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 31/56] x86/alternative: Prepend nops with retpolines
Thread-Topic: [RFC PATCH 31/56] x86/alternative: Prepend nops with retpolines
Thread-Index: AQHcPo0Ir0Tctlr5bEu+zRmeqpsk+LTEoXuAgAAh1bA=
Date: Thu, 16 Oct 2025 13:27:53 +0000
Message-ID:
 <DS0PR12MB92738D3C38021EE0B693326994E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-32-david.kaplan@amd.com>
 <20251016110717.GE3289052@noisy.programming.kicks-ass.net>
 <20251016112327.GQ1386988@noisy.programming.kicks-ass.net>
In-Reply-To: <20251016112327.GQ1386988@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-16T13:24:32.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB9273:EE_|DS4PR12MB9770:EE_
x-ms-office365-filtering-correlation-id: bb2fd88e-9ed5-4984-2ae8-08de0cb7cfd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2oeZevVSem7TAgMcAYaTPIIwyqK4YsZwrgyKGNQN3sqR/th4CQ3xEsC/yD2u?=
 =?us-ascii?Q?moCDM4PiQUvtqNrFZlQvDNBcPkvjU8FW/m/7sHIsXi9tt/WcTAiyhB0WtyV+?=
 =?us-ascii?Q?5uuXDQmR7CwwXOtJf+4GluM9fvdOSF/7koy2PN/LNvWTx/4A3pFiwcZSqj9N?=
 =?us-ascii?Q?3U7zUWS2RgqYmRg0jkwbXjKzxFtq5VnNqhuyaIFRaSKf4z9iMo5+CMkTSkjb?=
 =?us-ascii?Q?1bEWLylfaE5EZu+53lRgsZMRtszX5PlQSsvoYJDNf3AdnmDNHehi8chgozId?=
 =?us-ascii?Q?6ybf0IXm55bYL9YIgAt6HJyIiVwmgDyWj3bG7Hj4CIHTUNOgHapA5k8dHnxW?=
 =?us-ascii?Q?PqKqZqsT9NuHH1iX3HP1NO19dAviSDLITlV+iAMSLY/P9fyhe0v1Pm+cit85?=
 =?us-ascii?Q?6D8kjD3Q4CeQ0MOxIl+NF6Rs9INOdqknDfpSz/iXXAN1hRfaBKCKyBu8bq2J?=
 =?us-ascii?Q?IzuUaxe+ydYgSQVCHGVnlv3xtpqiS2xDItCh84P9fbq7NA7lQYifRzf4ROXU?=
 =?us-ascii?Q?S/dnCp5TxrHgfaBTOAARKT1G2EqHv9/N26CyfTZWbofKAoGDwkyzHvJ4MD/Y?=
 =?us-ascii?Q?72ZMtmFGGp+Y1J2lTEwEo7A+4f+asasB27TecD6bzo2ng8zluCQnRrVjpIIK?=
 =?us-ascii?Q?QyGA0KS5JLA4AO4PeSPg91gwshkLbp7GBJeWXyPr2DIAFXSxWrZ89I1TxtoP?=
 =?us-ascii?Q?+8BfWAzifJiCAnfaH2JLGAVdS/7q4Chy9uRgcB0RQrYE7RWPk3HZxV1RSQZw?=
 =?us-ascii?Q?Dy3kgQut8NG21kqknfA7c+uV6+7qDRd0wmOwPkTyoe834RmIa59HYiRiRc5I?=
 =?us-ascii?Q?PfSC+e4GIH59YeEEo/hvjg0mnJ9IR0MZ4cXQMQIbiEHDVouGohsNelWfJac+?=
 =?us-ascii?Q?/ReUWh/+iE22ELBXpwcQQ1qk+TmP6Nt+X2RlCnLsvsNTUxODa8/hwSmzksAk?=
 =?us-ascii?Q?w1r5U7cWm03ITJ2w75WMfvq06uBFiKlG8Up2wjxFmcOK+kCctKefBU8+vwra?=
 =?us-ascii?Q?JDDfyYpwqQ+V8JKC4zZf9El4a2S9Gzjo3U69UpeweVT78r4HJBPLx+TWUfJy?=
 =?us-ascii?Q?eK0Btv4HS1SLJw2HGa4NLJngm5iW+l1ZChZXzz9qvpmX6MAKTDcj+V7lRmjF?=
 =?us-ascii?Q?aJSB1CgjzpLF8q0DiQjMblxgftVeo6AFtly/3veZgAXQ8h/cBsMAqlw/ms6C?=
 =?us-ascii?Q?HIXhYQGxwtW1jDxUVYTXczVF7nf+pRvlQIj4adfSkZwy2gXAxspo/4hjgX4B?=
 =?us-ascii?Q?XeU6M1pWvQSfWcCr3z362vMvLcQBq/jsU25/njr0ZJB0foClodldECemVkpr?=
 =?us-ascii?Q?o/06xjtg6C3um1NABHYw+doLiicigIm5ILxNlTDgKyn+seN1NPo18QuYzq6r?=
 =?us-ascii?Q?1dLJSf4czjsdin86dVwR4wUKbVTvaFFthBg5SGrRj07xhQo1thB8B71yyvAk?=
 =?us-ascii?Q?XWuybchSbdtaUINyLA0F20L7ckkr+CgghNKrxcADJBE7/amdSju1oYDr094l?=
 =?us-ascii?Q?o4e7b5iKPpwIr1vrJml6v5nghR9gOuJ1WzWi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB9273.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AArFGDQAhqe7gwKGCNvFy7pgbrTHobNrDAS8Ow+PQkhw7SMXKIasgDhqsYRt?=
 =?us-ascii?Q?W5vD1vsOYgA7ulJ70fP4Rezh/J5u8tZ/2+oQW6ktsEm3a+HKZS6IsbxNcLUk?=
 =?us-ascii?Q?7FbYr1FKjngemQYNwz8OxvIEac7TEqckutNcyNz+pePwVb5QbBpJExLJQANQ?=
 =?us-ascii?Q?LDgN4vu04/39bQUn8ox5ViS+G2DVak2u/D2zQbRi2m+w7d6RS1/xHTob/7mt?=
 =?us-ascii?Q?8Ga64Ssf4rb2+Ahv/KPl+Rk5ds+iWwR0dDPPD0r9c1vhAUE25pUSOGioP48P?=
 =?us-ascii?Q?EN7qYUc3k0vxjMN1uXXHAZ+C0zuBp/8QJff1wTIEHv46zzVnTVTvRfLc9/JY?=
 =?us-ascii?Q?8bJ+Bc48GhoJO3ZJDpkFZAUDxkFok/B23E3ZvoyDJFXte81Xvinc++qUkOVe?=
 =?us-ascii?Q?6Y0b/VKZChlcE4EkojF6GFImpOMtMDADlbk1e/0Fik2VRKPDfD5Jvtmin30J?=
 =?us-ascii?Q?v0dXfqzs6wZwqkp3CGNpusoFS3mE32vd26jLz2kRnVmoCNmGD3HUe5oDcJve?=
 =?us-ascii?Q?tOd6FnH3b2vS/tJRLtH3gNgkgvE0+6iTfvJ6ysgWMQF03xVI72MwypkgPW9S?=
 =?us-ascii?Q?r2N4iExUNwLeLWyDb2tdofgjl6bi5omDAtgw7LfGaqfF5On1m+JaJR3XbP3R?=
 =?us-ascii?Q?wY05XjjmsQ12RrnvMfO1yNOOa+amT1iEnwBE/je105fd8cCCcAEA3/id7bYe?=
 =?us-ascii?Q?g5sZUPNJxKRCLBdh7dVrOv1ADZbxNo7KIJof7g4eE2HaODb5EUkpIDqfSJFX?=
 =?us-ascii?Q?y3sLpfYmuatcAI/gszZJRHQQrz+6bojBZLrHbNwhryg/Ha8vgidHtvwkZKz9?=
 =?us-ascii?Q?dOzs5UECYSS98UZYj7RSBoJCN1gKpn0lipu3IDpxRyp5I21YP0eMbBVge24T?=
 =?us-ascii?Q?AxHLk7ugp8KR+WQdTPMgTB0/kBKfytQpFyVJkUXR1krtq7TAc1Pzn97H5/lR?=
 =?us-ascii?Q?tH04nNpc85oB1sJvsY91GTfMwyEFHPw4pE7w+V0HrnVDUKXGOFitapskNgoX?=
 =?us-ascii?Q?yKYB9fxqJj1ceokje2SHwUK7EVlhO+IhXcS0+3/tP96DU9mlFPjO2n0ItKk0?=
 =?us-ascii?Q?JR8BMi4sLlEdmvYCgIImJVhFTcP4NYlYh9w3VyfC3fKyaiuFjPyT+Yszq8YR?=
 =?us-ascii?Q?PcNY49TX9c//Vu0A0IveyqNPkl5kCs/VZ+BPDqGbXYEQa+l56QZGXafHRupA?=
 =?us-ascii?Q?qjzXdy3Af8nVZqu9sxLJUxBPKygPnBMKtWLH83+aipfCgYFnY9jAGEkjkbHk?=
 =?us-ascii?Q?XClrturqVd+ECs/WSrWhJ+rI2QF4ZRbhMBvawH8J8SJBVX6SzMKKr+sY1INX?=
 =?us-ascii?Q?8gsBF6GiyxH7JMd8lTL5wbGi4eXE3XLkEvAAXiiSWrsp8E5Bh0dTu3MU+6Jt?=
 =?us-ascii?Q?a9uvdNxWbDBy1Aj2kVtrV/zm7JHoqWnP6bOVfHq1Mb5u6zCu2JojEsGqAF+s?=
 =?us-ascii?Q?PSxhvky7bZCBwdzGvNouWOum/k3yf2LMMOuvtJegfon4wzDUA7QavytPIA98?=
 =?us-ascii?Q?hTWaOhoo+QcyyQ/pbmuFGTlXrelafOPg0aU80zQuKW84aWnbtdiWyAsZadqO?=
 =?us-ascii?Q?0bpmq5g/5mxQM6mPvIY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB9273.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2fd88e-9ed5-4984-2ae8-08de0cb7cfd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 13:27:53.8038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hk+/fG6Xb0yu8KgeCdgBrGBDE0qEOWtAjxjxwepKJ0+s4nOXujQAzDC32mmik7k8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9770

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Peter Zijlstra <peterz@infradead.org>
> Sent: Thursday, October 16, 2025 6:23 AM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>;=
 Josh
> Poimboeuf <jpoimboe@kernel.org>; Pawan Gupta
> <pawan.kumar.gupta@linux.intel.com>; Ingo Molnar <mingo@redhat.com>; Dave
> Hansen <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter Anvin
> <hpa@zytor.com>; Alexander Graf <graf@amazon.com>; Boris Ostrovsky
> <boris.ostrovsky@oracle.com>; linux-kernel@vger.kernel.org
> Subject: Re: [RFC PATCH 31/56] x86/alternative: Prepend nops with retpoli=
nes
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Thu, Oct 16, 2025 at 01:07:17PM +0200, Peter Zijlstra wrote:
> > On Mon, Oct 13, 2025 at 09:34:19AM -0500, David Kaplan wrote:
> > > When patching retpolines, nops may be required for padding such as wh=
en
> > > turning a 5-byte direct call into a 2-byte indirect call.  Previously=
,
> > > these were appended at the end so the code becomes "call *reg;nop;nop=
;nop"
> > > for example.  This was fine because it's always going from a larger
> > > instruction to a smaller one.
> > >
> > > But this is a problem if the sequence is transformed from a 2-byte in=
direct
> > > to the 5-byte direct call version at runtime because when the called
> > > function returns, it will be in the middle of the 5-byte call instruc=
tion.
> > >
> > > To fix this, prepend the nops instead of appending them.  Consequentl=
y, the
> > > return site of the called function is always the same.
> > >
> >
> > So this results in:
> >
> > NOP3; call *%r11
> >
> > And you're saying a task can be on the other side of that call and then
> > return lines up. But what if the task is preempted right after that
> > NOP3?
> >
> > Same for all the alternative patching; what ensures no task is currentl=
y
> > having a register state that is in the middle of things?
>
> Ah, I found it, you freeze everything, which puts it at safe points.

Yes.  In fact, I think you were the one who pointed me in that direction :)

Despite the freezer though, this patch is necessary in particular because s=
top_machine_nmi() uses an indirect branch to run the handler.  Which means =
that while patching is going on, all cores are inside a function which is g=
oing to return to after the indirect call site.  And so that needs to be th=
e end of the 5 (or 6) byte sequence.

--David Kaplan

