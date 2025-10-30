Return-Path: <linux-kernel+bounces-878458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F642C20B00
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76BEF4F289B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E6C26FDBF;
	Thu, 30 Oct 2025 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Br0j4vij"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010034.outbound.protection.outlook.com [40.93.198.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFF01AF0AF
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835160; cv=fail; b=MpeGmdM/1DWXTji/X93FcxN9ABbiF/akQNJY8QtbDFPfMt0hJ/P+G5BgUIQSLyZGYQGENxyQifSScvCPOa4iA3H7mdPBsTYOExqC8RRabx2sbYcx1IpJriccRpaJQNYXbV0PiXqq+Xz1QhOLs5F8liHGRdGnrbQROIrHWgvYToQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835160; c=relaxed/simple;
	bh=w4nxmF7d8arJyx7VfGerFU8q+X/mPXMq/mfz5dgGymM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qWntpsD9FszewXeC+rH6Wtw0QMqfdsV44DYNjAtGeoQnjQ5NImfDFDctq6dwC7wmaeqtVdJplGYlsgTil+3Hn3lZkWuGnXxhfJyhuQyQLdpxhAQC+K4Y0AbpCqQxDxRtg21FtrLRiwvuM85FpgPbapLhoeKML8CS76ACdzhB/aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Br0j4vij; arc=fail smtp.client-ip=40.93.198.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLn4iXkzAYmOm84bD9PpMfit6IywywujSimSaiNQ8GCowGfv4nlAJy2nnke/YSbQHkPbVFl5Pia2x7vRehmSjzs6uPhV7CHC2OxNHHUHP5whjDnM5eBtiFHyzej6sKKMaWTwOXyqtT1vG3FCLIl5tTTon1rWC4nHMqJSB18gx4PAVaf5swVxObOyW+I4C6K92MjPrK3v5yaZuhsqRigXfRomn0JNnta9EVU87gMaKrlRWwwq6abKNA9LFTIs5swHSCaPOwTewnEwoj6I6ZxKBiuyQ2MVfcMr9Gs3I+JMQ0udw7xybHa9Pdqgm5qixbYRQXUXMgpQkm8Ui0amllpOEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSOE/gtBEGmiahkmgp2Z1+dkxABacOn57Kreb9PpTsY=;
 b=b1C6lVmZGM/3PR7sG6llN/6EtqB4FV6wjVC7499nVtSqPcftefbHPWG3DNm1olZnvJBuOSLdOKE1UTFazDDgb5wYZmRBozgJqc1Dk3uGyFGEGm76vGW0AuG/P6GYlF+U17y/D/VsIw1KnNOYKbKL1+6G9vAFPxCv7mJJsH9oYg6EnOfGFia90e0xoCqwvVjQddFReCLc+QSyk6DjvjjCQ+CNzCYH59BXutnmgMDZiEOgOuxJJRyNgRja9tXu11nCjgBpsJ//Q0rlTY0ugGVyMIvjd42mpaJD33QZPrZcMhuoZ4FZwRakxrVybwNPAaFB/NU8yMtR9lipfxvImq4vDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSOE/gtBEGmiahkmgp2Z1+dkxABacOn57Kreb9PpTsY=;
 b=Br0j4vijs0IkYFgmu3W2BEk2EM0ny9mJnyIwt+YsYBCgtCbNGhgnhkVVdFBVjwnFcC0qfLL/xoJvoSfITsq9KIrsSIdXfoKr/5aYHFohLCp1YpjudJhUmSN3BmsaHRKa+GiDYQSW2MhfrgM7VzeUkyH2cnZhgsYThRsiASqC7aU=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by PH8PR12MB7349.namprd12.prod.outlook.com (2603:10b6:510:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 30 Oct
 2025 14:39:13 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 14:39:13 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: David Laight <david.laight.linux@gmail.com>
CC: Nikolay Borisov <nik.borisov@suse.com>, Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter
 Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan
 Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 34/56] x86/alternative: Save old bytes for
 alternatives
Thread-Topic: [RFC PATCH 34/56] x86/alternative: Save old bytes for
 alternatives
Thread-Index:
 AQHcPb/dNJRwYJelJ0iZ+pcOgQN837TDNq5ggBK5IwCAACi5EIAC2zOAgABxyTCAAGG0AIABENNw
Date: Thu, 30 Oct 2025 14:39:12 +0000
Message-ID:
 <LV3PR12MB92650036427F97D5F2413BC694FBA@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
	<20251013143444.3999-35-david.kaplan@amd.com>
	<d897be07-ed59-4538-aceb-53c6512aeccf@suse.com>
	<LV3PR12MB9265295ABF26898CA59B86D594E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
	<754ee3ec-8819-47df-8251-dec2906a020b@suse.com>
	<LV3PR12MB9265E559972E1C6693AAE7E794FCA@LV3PR12MB9265.namprd12.prod.outlook.com>
	<5f1fa90d-5c84-43e6-a99e-ef4a215b5055@suse.com>
	<LV3PR12MB9265295E1470ED9C5BE9EF9094FAA@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251029221416.5b33e1fe@pumpkin>
In-Reply-To: <20251029221416.5b33e1fe@pumpkin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-30T14:30:44.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|PH8PR12MB7349:EE_
x-ms-office365-filtering-correlation-id: 964950be-cfa9-4456-a867-08de17c217ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vOq++Of2QSupb4byt4z9CIw7G0H/8CEvsQyJ1ofS047YIR0nIA6pKO50raA7?=
 =?us-ascii?Q?E61G9IWDzbrOI9JgL+k0jTGSnBibkbeNk+GYVHRHlImXvRz+OiNxj1eiY6y9?=
 =?us-ascii?Q?L/2MQL0Bus2ZOSP84OGo1n5Y0nHnLeyNeIFUpV/p6/2ZoZfE1e2orBISoRRe?=
 =?us-ascii?Q?X+blG3i70oGpT/PK2hxtsq9pbGfTb4O9yta1KBzXpWC+9XC4H4K4S4e6f4ZQ?=
 =?us-ascii?Q?JNakYyy+6IEfgc7FT2otN3VXgJpVA5ceitcp8rHhCEqxXf8uq47oyU8H4gqo?=
 =?us-ascii?Q?hBU/rxJOSVpVpcPf8a6WlbNizXEWzggPLAVNW9HeaV7Lw+wFhwTR/ZtbGQdz?=
 =?us-ascii?Q?qwASh23O7N1mWU5UrhgzpMLoW6uvXaNNAzWZ+a139dAuv1D2irfHLq6d8A0R?=
 =?us-ascii?Q?PtM2YnJctRnC8tRotQzPY1yqbBfIekd4Go4A/xaQHYOZChRojZ2n3tFS+rlO?=
 =?us-ascii?Q?zeDSzEWtEyGPRl0xUjxZVD+p29PgVhFoipgPIjz4e1ZXVz9jjEpqIfBZ+PG1?=
 =?us-ascii?Q?89kHHj9ikcmqJ5gTtfhpS0Ne9/1YCOs5Yoq++ygLDrMJ9LRiA83GAoN1ILQH?=
 =?us-ascii?Q?SiUEeVe7Airm4R5zlSRZKXTpLSiJ2DbnBB2IV7l8iklQ7m/YVY2bqxvBMEPH?=
 =?us-ascii?Q?YBR7LHWHcBzEOaRDvqh3ce74eCy2tT2v45oOFrzwST+5zvVa+3mXe58T6Gt2?=
 =?us-ascii?Q?YsepUYhSxlsU1w8r112xWFtrq7phg1zFpw7vOkH+ITPEilqEMmUwYHlJ//u5?=
 =?us-ascii?Q?WmZKezRtryvbEtTTyA+MnyZvT/v1v6a+ANIov4RGoDAvzLoXTUa5OatnMbIl?=
 =?us-ascii?Q?Pm7OQCAP/jdmZpGkjKouwvQHRXpgC6wKEpXakcOwzFeAzifcwo6invX1WfMB?=
 =?us-ascii?Q?vU/Cw7v1fTUvKNA+hm4wYeQNODoEdMSRLw7Es4t+WamTrd/0SazSnCoGXOnq?=
 =?us-ascii?Q?bY4Wp6hKIm/w5aQCtCsGreU0oCWbfhHaaef/GU+O6CuH53k84ms8Ne3QYY5p?=
 =?us-ascii?Q?gai7IZjgcP3olhwqqc9pwnnC4rBEVKvMYYYr4IWPAtxKn2ZfpSfZ2mmPxZWE?=
 =?us-ascii?Q?ZF4A+DkmGvYLYHeKkbinEqg/r3Z+9AxOFB4/mQ1t5V8JMtXxwzLqN2CX5eYk?=
 =?us-ascii?Q?99bZUeQHgBVmqXKzm8OzoCW2R/9ltmnNXxNjm4P9cOs+UZLfgtjVTv6itSEB?=
 =?us-ascii?Q?s29jjJ7fdrdzuO60JPTDb/foBeryqzrB3pMIlmCbp4gAFF8o/7wjuMLTpu7U?=
 =?us-ascii?Q?UdCCZOnxfh13dKk2Sg17uAcesEZ8Lq/49T8fglp5DCL8wNBmUDzlhpccD8h0?=
 =?us-ascii?Q?8fWIMsuWCk2OLL6vlDe9X3iQG5tDUyED2ragTEfYlWj1kLku4N8eW+Odhpnc?=
 =?us-ascii?Q?T+DB/HB5gkd4I06IEh4srzVezch8HlNqatzIRP9yTltlhsJNWMAm2lHr4CrJ?=
 =?us-ascii?Q?wW+kRhvKX9xPEOaFFMgss0mGt2rou1F5TQ5F31v64xggzVp5GTIVu1L+AjJb?=
 =?us-ascii?Q?ianAWkDhw+pkuHWSd5oAZaS2QEzZAr0ikoh2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DD0dL8n78gmooOuIkkIe4h8217xz9z/M4WMx7jlVSBzbENxVJwr/aww/YoJX?=
 =?us-ascii?Q?UDwvANgfSUcN5WCjeabdBHlaAptNujFX64OC+Tv9DoFTDxcTzeGpztWqlet9?=
 =?us-ascii?Q?Mj8zGHOnITm0rKIrBuJhd7FV8x8COJphBmuXQqfry/sLHkwXfIQ2GhSVbkXg?=
 =?us-ascii?Q?l70TvMw3wB7OUKQ2jdAyHqXx35bMsWkjpJsc5aQTwP3p2+LCw7pmicbp2aUr?=
 =?us-ascii?Q?vrltE+qgs4PI3zcs4lLyV7Y4EJvDsVhht+sW6hoE71MJLmST87iM4twr8ykw?=
 =?us-ascii?Q?anSX0+7t/lgVex/FCKw6uBba1nTGP1j3Jmq62wpGoWNnpbFg/tyww76puFZY?=
 =?us-ascii?Q?u/XJgVfGW/TR+W2IU2f8cNubrNj7NOKDN7B1BK2JNpa45X355cLdZxrVg5c4?=
 =?us-ascii?Q?PlgTlWlAXYaJI56I6QwDvh0o+c6QmrQ8djacbkOMzGNRPJjqve81P4KXWjE+?=
 =?us-ascii?Q?l/iRfn8AJul6tNy7UzQf+699x0wBa7HxF+LCOU+907x6y3OApEMh5UonLkQe?=
 =?us-ascii?Q?UXWgV+o6QiQ1ZoHiY5S1K5SMv/Q7hGu+vVp027VWIsw377GOX4VYqYrkwfeU?=
 =?us-ascii?Q?slotdTBAGNWGj7AwTnPxyZ7Apl0hHkdi5m9k9dRMg5gdn1xvixduSbpIKpb2?=
 =?us-ascii?Q?/9Hb8w7PAncJ0C3r5KjuU8E4k3ND/QadNaMF5XBR8Gdo6Mc9IQ5LoRzaHsNm?=
 =?us-ascii?Q?JLL2l+D0aFNyX2ChFaJ0q6AiSQW/HH0tSANMOBiSDnTKM8qfpYHTJaXRU1Gy?=
 =?us-ascii?Q?en+7rL88ViDEOoD0dVbBLCRnWxlyTglACN8nVrLSiddRTecFYQknf7S+Pwet?=
 =?us-ascii?Q?jUstSVVcLN5jtVRjSVx9O/PzQb8VycV4a+v25bLzDCv8mP0kGxJe2jSuZ5im?=
 =?us-ascii?Q?J9VPDjVGfbcCXzAmldB21I6QmbSm5+1jrjUzt8K3NxUssLgofz/XOYGTqEYE?=
 =?us-ascii?Q?/SDehnjKoQeXMQUnkCpzxWAUYrszQWIEh52gqgVob5LrJ/A6s01a0x/C/LgH?=
 =?us-ascii?Q?69OtwZhaV5K6q9BiqpITEAN3qpRl+n5sMUJnXMBgbh6ascp2f4KrmXW5tZJq?=
 =?us-ascii?Q?QE8I1/xvVAWCridGYogWxZSm/nOp3Mb64JELBUlEmxI3b4Hbv0+ZCSoDBvCf?=
 =?us-ascii?Q?hTXi3KuyWNc8EuEWL3m3u/mf/sHcMV9V6pIna+ZecwdpXMzOKVTiwhaSJSqh?=
 =?us-ascii?Q?BGFRbi560xafCJ8ukPCA6SbfZkVKA8ZHVsuztgI32SkLh0CtBfvaBuFuJ0Lo?=
 =?us-ascii?Q?mkhRYJbzwwF9ELxSYF/rSbdgMdIoaAPpp0vEbNNl+XGFOJN9COuBJJ3aW/wu?=
 =?us-ascii?Q?QLvOFkDbzgXJEgd+lFcqSVw3cpl2R3D5rgI2usrqkySH3zYdGqtTzCG9okGI?=
 =?us-ascii?Q?Ey37nMO5W4VFvz+o2kgedHbl2SERxxH6RguhbIs6ssh4oY+mxT7GSO6tszHA?=
 =?us-ascii?Q?QllE7v0PBL4+7jktLhYHyQZHynxOvV8yGeajc8/YwLyKtX1158gAZc9zV0I5?=
 =?us-ascii?Q?yzraXjKCOOircalngE5N7LWIOoOFOfpDnFC1GmK+1DdI5uN7JSMkg2+OKrHG?=
 =?us-ascii?Q?xokfOovB/lonIp0kc4w=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964950be-cfa9-4456-a867-08de17c217ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 14:39:12.3176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Or4aqH3oXLdceHwzhV3REv63Aqb+ZoAV87cAzrsLNwlX2Qf6UglJ2nTtUsQ23i5L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7349

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: David Laight <david.laight.linux@gmail.com>
> Sent: Wednesday, October 29, 2025 5:14 PM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: Nikolay Borisov <nik.borisov@suse.com>; Juergen Gross
> <jgross@suse.com>; Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov
> <bp@alien8.de>; Peter Zijlstra <peterz@infradead.org>; Josh Poimboeuf
> <jpoimboe@kernel.org>; Pawan Gupta <pawan.kumar.gupta@linux.intel.com>;
> Ingo Molnar <mingo@redhat.com>; Dave Hansen <dave.hansen@linux.intel.com>=
;
> x86@kernel.org; H . Peter Anvin <hpa@zytor.com>; Alexander Graf
> <graf@amazon.com>; Boris Ostrovsky <boris.ostrovsky@oracle.com>; linux-
> kernel@vger.kernel.org
> Subject: Re: [RFC PATCH 34/56] x86/alternative: Save old bytes for altern=
atives
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Wed, 29 Oct 2025 16:26:58 +0000
> "Kaplan, David" <David.Kaplan@amd.com> wrote:
>
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > > -----Original Message-----
> > > From: Nikolay Borisov <nik.borisov@suse.com>
> > > Sent: Wednesday, October 29, 2025 4:37 AM
> > > To: Kaplan, David <David.Kaplan@amd.com>; Juergen Gross
> > > <jgross@suse.com>; Thomas Gleixner <tglx@linutronix.de>; Borislav Pet=
kov
> > > <bp@alien8.de>; Peter Zijlstra <peterz@infradead.org>; Josh Poimboeuf
> > > <jpoimboe@kernel.org>; Pawan Gupta <pawan.kumar.gupta@linux.intel.com=
>;
> > > Ingo Molnar <mingo@redhat.com>; Dave Hansen
> <dave.hansen@linux.intel.com>;
> > > x86@kernel.org; H . Peter Anvin <hpa@zytor.com>
> > > Cc: Alexander Graf <graf@amazon.com>; Boris Ostrovsky
> > > <boris.ostrovsky@oracle.com>; linux-kernel@vger.kernel.org
> > > Subject: Re: [RFC PATCH 34/56] x86/alternative: Save old bytes for
> alternatives
> > >
> > > Caution: This message originated from an External Source. Use proper =
caution
> > > when opening attachments, clicking links, or responding.
> > >
> > >
> > > On 10/27/25 16:19, Kaplan, David wrote:
> > > > [AMD Official Use Only - AMD Internal Distribution Only]
> > > >
> > > >> -----Original Message-----
> > > >> From: Nikolay Borisov <nik.borisov@suse.com>
> > > >> Sent: Monday, October 27, 2025 6:35 AM
> > > >> To: Kaplan, David <David.Kaplan@amd.com>; Juergen Gross
> > > <jgross@suse.com>;
> > > >> Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.d=
e>;
> Peter
> > > >> Zijlstra <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.o=
rg>;
> > > Pawan
> > > >> Gupta <pawan.kumar.gupta@linux.intel.com>; Ingo Molnar
> > > <mingo@redhat.com>;
> > > >> Dave Hansen <dave.hansen@linux.intel.com>; x86@kernel.org; H . Pet=
er
> Anvin
> > > >> <hpa@zytor.com>
> > > >> Cc: Alexander Graf <graf@amazon.com>; Boris Ostrovsky
> > > >> <boris.ostrovsky@oracle.com>; linux-kernel@vger.kernel.org
> > > >> Subject: Re: [RFC PATCH 34/56] x86/alternative: Save old bytes for
> alternatives
> > > >>
> > > >> Caution: This message originated from an External Source. Use prop=
er
> caution
> > > >> when opening attachments, clicking links, or responding.
> > > >>
> > > >>
> > > >> On 10/15/25 16:45, Kaplan, David wrote:
> > > >>> [AMD Official Use Only - AMD Internal Distribution Only]
> > > >>>
> > > >>>> -----Original Message-----
> > > >>>> From: Juergen Gross <jgross@suse.com>
> > > >>>> Sent: Wednesday, October 15, 2025 5:38 AM
> > > >>>> To: Kaplan, David <David.Kaplan@amd.com>; Thomas Gleixner
> > > >>>> <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>; Peter Zijl=
stra
> > > >>>> <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>;
> Pawan
> > > >> Gupta
> > > >>>> <pawan.kumar.gupta@linux.intel.com>; Ingo Molnar
> <mingo@redhat.com>;
> > > >> Dave
> > > >>>> Hansen <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter
> Anvin
> > > >>>> <hpa@zytor.com>
> > > >>>> Cc: Alexander Graf <graf@amazon.com>; Boris Ostrovsky
> > > >>>> <boris.ostrovsky@oracle.com>; linux-kernel@vger.kernel.org
> > > >>>> Subject: Re: [RFC PATCH 34/56] x86/alternative: Save old bytes f=
or
> > > alternatives
> > > >>>>
> > > >>>> On 13.10.25 16:34, David Kaplan wrote:
> > > >>>>> Save the existing instruction bytes at each alternative site wh=
en
> patching.
> > > >>>>> This is only done the first time, and these will be used later =
to help
> > > >>>>> restore the code back to its original form.
> > > >>>>>
> > > >>>>> Signed-off-by: David Kaplan <david.kaplan@amd.com>
> > > >>>>
> > > >>>> Instead of saving the original instructions at runtime, why don'=
t you
> > > >>>> expand struct alt_instr to have an additional offset to a saved =
copy
> > > >>>> of the original instruction, located in .altinstr_replacement?
> > > >>>>
> > > >>>> The new field should be guarded with #ifdef
> > > CONFIG_DYNAMIC_MITIGATIONS,
> > > >>>> of course, like the added handling in the ALTERNATIVE() macros.
> > > >>>>
> > > >>>
> > > >>> That's an interesting idea, I think that could work.  That would =
make the
> kernel
> > > >> image on disk (slightly) larger though, as the original bytes will=
 essentially be
> > > >> duplicated (at the original location and in .altinstr_replacement)=
.  I'm not sure
> > > which
> > > >> is the better trade-off (kernel image bytes on disk vs runtime mem=
ory
> usage).
> > > >> Although I think we're talking about a relatively small amount of =
memory
> > > regardless.
> > > >> Most of the runtime overhead of dynamic mitigations comes from
> remembering
> > > the
> > > >> call sites/returns.
> > > >>
> > > >> It's not just about memory usage per-se but also memory pressure f=
rom
> > > >> allocation and the resulting fragmentation, though I'd think that
> > > >> majority of the allocation will fit into kmalloc-32 bucket, still =
having
> > > >> them as part of the kernel image eliminates the additional allocs.
> > > >
> > > > I see.  Just to understand, the issue is more with the numerous sma=
ll
> allocations
> > > right? (that is the kmalloc at each alt_site)  And less about the sin=
gle large
> allocation
> > > of the array?
> > >
> > > Yep, do you have some statistics how many allocs have to be done?
> > >
> >
> > On a typical kernel, I'm seeing 6427 kmallocs() from this with a total =
size of
> ~36kb.
> >
> > If that is too many, another option could be to go through and figure o=
ut the total
> size needed and then do one big allocation.
>
> Is there also an 8 byte pointer to each allocation? They add up as well.
> Is may be worth doing multiple (say) 4k allocations in a list (or array o=
f pointers).
> Then the pointer can be replaced by an offset into the overall 'big buffe=
r'.
> Align the entries (a bit) and maybe a the 8 byte pointer can be replaced =
with
> a 16bit index?
>

Yes, there is an 8B pointer to each allocation (although I didn't include t=
hat in the number above).

There's a number of ways to optimize this, doing a single 'big buffer' with=
 perhaps a 32-bit index seems rather straightforward.  And maybe there are =
then further ways to squeeze this.  But I think we're really talking about =
a small amount of memory, especially compared to the other overhead noted a=
bove.

Thanks
--David Kaplan

