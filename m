Return-Path: <linux-kernel+bounces-840747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF5ABB5228
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 22:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C204828DD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 20:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657532566F5;
	Thu,  2 Oct 2025 20:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="VrZrNzV3"
Received: from alln-iport-5.cisco.com (alln-iport-5.cisco.com [173.37.142.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8F8239E65
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759437303; cv=fail; b=Q8QXwrFw6ZM6bDMLNHTTOhS0jU62ahuGKJppaCLMe0fUFpVMLegO/CcsTL81FucpF6noSfdvHeMHRb+Ok/VDJTLYuKYQPSy5UPlLGl4ZTuJc9pFh4fGqA/dBlhufRlxklJTn+kAWgZrQSJmvWBbOUIn3ycgU9+iW7xmPyFRN6xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759437303; c=relaxed/simple;
	bh=MVcjFUNBWbLVF7730tJ8ctermXCCx93YpLwwWo8fV7g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HW7TaQXF7FZzZuOwvhABKZgFevyivjqbPZO6dyr2j5MhPBFLdKBozc2Xl+GDKb+SPT0Zb00fDwe7YZRzn+YLt7oTtW47ALI7fZ0xo3605tY8iLGX8CsJKkciMfA79Oh50Bza9vIjAC2DEuQwqIc1im/iWpw9wklLf+M4lyZCNa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=VrZrNzV3; arc=fail smtp.client-ip=173.37.142.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1563; q=dns/txt;
  s=iport01; t=1759437301; x=1760646901;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MVcjFUNBWbLVF7730tJ8ctermXCCx93YpLwwWo8fV7g=;
  b=VrZrNzV3YTuwT9F00F4czuwvJG7ww0AH6o9B0lmhqI1CG401+inokBUf
   IkSxqlMqYpnSHovg+ySsT6wAWkTX2n/bjlefUHyXEsvwHxg1qoDTTJmQ9
   wmIoMUbbzcm5vJE+GW8gO/mfPIXLSD7QhjLQbLgYROGqyUKyBZXB8zMch
   4KyhRQjZGKVQMCBrOM7ZgOnfA1Z/zF5WlIdeu3YLvNPAs0mys/KcpEwRr
   L/mL39umv4Qmb2+7H/b+FebbGfvr8zIa3CuwgI/rhLb6cKWM8SiMPopie
   L+LsYqBa9KC6IkS1qnzNekWM4QB9e8EcHY1Afhlk8reYbFrUgAagU03xW
   w==;
X-CSE-ConnectionGUID: MyI4VLIVR+u1yUyRfdJn3g==
X-CSE-MsgGUID: qBdtG970SfuintvQo4/jKg==
X-IPAS-Result: =?us-ascii?q?A0A8AACJ4N5o/4oQJK1aHQEBAQEJARIBBQUBQCWBGggBC?=
 =?us-ascii?q?wGBbVIHggUSSYggA4RNX4ZVggQghXqMcYsvgX8PAQEBDQJRBAEBhQcCjEYCJ?=
 =?us-ascii?q?jQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThlyGWwEBA?=
 =?us-ascii?q?QMSKD8QAgEIEgYeEBAhFw4CBA4FIoVTAwECo3YBgUACiit4gTSBAeAmgUkBi?=
 =?us-ascii?q?FABhWyEdycbgUlEhA4xPoRDhkQEgiJEUoFVjlyEL4shUngcA1ksAUsKNQwzb?=
 =?us-ascii?q?UMDgTJLBTdoEkB3hBSEHoMWcoF0V0GBSxiCDnEPBoEVGUkCAgIFAkM+WoEQB?=
 =?us-ascii?q?hwGHxICAwECAjpXDYEEdAICBIIvgRKCKg+BbwN4PTcUGwaZZYNIMoFWmEKwH?=
 =?us-ascii?q?wqEHKI3qliZBqNZhT0CBAIEBQIQAQEGgWg8gVlwFYMiUhkP1Sh4PAIHCwEBA?=
 =?us-ascii?q?wmTZwEB?=
IronPort-PHdr: A9a23:xG7TkBHS96kRVAQx6K7f3Z1GfhMY04WdBeZdwoAsh7QLdbys4NG5e
 kfe/v5qylTOWNaT5/FFjr/Ourv7ESwb4JmHuWwfapEESRIfiMsXkgBhSM6IAEH2NrjrOgQxH
 d9JUxlu+HTTDA==
IronPort-Data: A9a23:cEse0qMiymoSKcXvrR3xlsFynXyQoLVcMsEvi/4bfWQNrUoj3zFUm
 mJNCmCDa66PYzGgfIp3atyxox8O75TcndUxTHM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFDmF/03F3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WlPlV
 e/a+ZWFZQb9g2QsaQr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj69B/LR0IGawmwKVqWHBz5
 MYWJBILNR/W0opawJrjIgVtrs0nKM+uOMYUvWttiGmAS/0nWpvEBa7N4Le03h9p2ZsIRqiYP
 pRfMGE/BPjDS0Un1lM/BJs4neqsmXDXeDxDo1XTrq0yi4TW5FEuieiybISLIbRmQ+1MtEqEi
 TOZp1/3HxAcKMKmzmbC8FGj07qncSTTHdh6+KeD3vprhkCDg28eEhsbUXOlrvSjzE2zQdRSL
 woT4CVGkEQp3EWvSt+4W1izp2SJ+0ZFHdFRCOY9rgqKz8I4/jqkO4TNdRYYAPQOv84tTjts3
 ViM9+4FzxQ22FFJYRpxLoupkA4=
IronPort-HdrOrdr: A9a23:cAdTr6AaJGTRc3rlHejqsseALOsnbusQ8zAXPh9KOH9om52j9/
 xGws576fatskduZJhBo7y90KnpewK7yXbsibNhcotKLzOWyVdAS7sSo7cKogeQVxEWmdQtr5
 uIH5IObOEYSGIK8voSgzPIUurIouP3jZxA7N22pxwCPGMaDp2IrT0JdjpzeXcGPTWucKBJb6
 Z0kfA33wZIF05nCfiTNz0uZcSGjdvNk57tfB4BADAayCTmt1mVwY+/OSK1mjMFXR1y4ZpKyw
 X4egrCiZmLgrWe8FvxxmXT55NZlJ/K0d1YHvGBjcATN3HFlhuoTJ4JYczAgBkF5MWUrHo6mt
 jFpBkte+5p7WnKQ22zqRzxnyH9zTcV7WP4w1PwuwqgnSW5fkN+NyNyv/MfTvLr0TtngDi66t
 MT44utjesSMfoHplWk2zGHbWAwqqP+mwtTrQdatQ0tbWJZUs4QkWTal3klTavp20nBmdoaOf
 grA8fG6PlMd1SGK3jfo2l02dSpGm8+BxGcXyE5y4eoOhVt7TlEJnEjtYQit2ZF8Ih4R4hP5u
 zCPKgtnLZSTtUOZaY4AOsaW8O4BmHEXBqJaQupUBnaPbBCP2iIp4/84b0z6u3vcJsUzIEqkJ
 CEVF9Dr2Y9d0/nFMXL1pxW9RLGRnm7QF3Wu4tjzok8vqe5SKvgMCWFRlxrm8y8o+8HCsmeQP
 q3MII+OY6UEYIvI/c/4+TTYegnFZBFarxmhj8SYSP6nv72
X-Talos-CUID: =?us-ascii?q?9a23=3Aza0ROGvv2DreXvz6qz38Ewn36IsAY1yB8lPxHXX?=
 =?us-ascii?q?7FD94dayvR1Oy/vhrxp8=3D?=
X-Talos-MUID: 9a23:8k2lAAifhGcUjTfrpGuGocMpLe1k/4v/Vxg2n4gHvdWaDCssfDW+g2Hi
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-01.cisco.com ([173.36.16.138])
  by alln-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 02 Oct 2025 20:33:53 +0000
Received: from rcdn-opgw-3.cisco.com (rcdn-opgw-3.cisco.com [72.163.7.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-01.cisco.com (Postfix) with ESMTPS id 6D515180001A2
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:33:53 +0000 (GMT)
X-CSE-ConnectionGUID: iSfEOJtBTK2KI/HN2g4XGA==
X-CSE-MsgGUID: lP7FetL0S0KVSH0FVMe3dA==
Authentication-Results: rcdn-opgw-3.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.18,310,1751241600"; 
   d="scan'208";a="44918237"
Received: from mail-cy3pr08cu00101.outbound.protection.outlook.com (HELO CY3PR08CU001.outbound.protection.outlook.com) ([40.93.6.105])
  by rcdn-opgw-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 02 Oct 2025 20:33:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3vOy03CUsT1DNObPwIXJmNNklShuL/YZf0CYgLzQwHAEvT0GAEGSmMsNhkf97rkHS3GMPxohcIY/D+ycTHzNbN51q8cH7LWH43satglivhZmQq3NhD46g3izzG8uK1y4+l7wtuQGLeR7HEUzY3clSexSkyh5jm8iCva4EjcsBkv5sGOnmPPm6ng94o77NfSNIpaKEb6tXtguR3MbpbmWBabs87PhMPrNb86oqaBI9r2lCnZRiwKGa8tDz9HQSWd4aBBPi5Bl2uN/M8wVZ0/0x1MBhPMUeefcsP+8+v/EF0u4MVskchNHlknuVP6S8Zz/fhz2EL/ev6XAi6mpRqMUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVcjFUNBWbLVF7730tJ8ctermXCCx93YpLwwWo8fV7g=;
 b=lzfuRkkTV3neTSMfRLtiZ3LUmzIJaO2+7UOnr24uheUt1y48QBszW1YPCDz304D8AGnI36IyWyqBmx+8udj7b+HNyeC8E9KMQC8j+T+ZhWp37N4DenByaYhznYtik0wigxWYSJcWVp3GrzE0vvcFbuxTQT5ZuC2WrHzuHEMR8sx0QIn4L2i//K5/Bd0woH0pfRatLE2aVuNAPQmwKV9kUqMhCR0mRnCFnoeF18TY53i1drVd71bfkGochuFlB/B+QjI3XRDElx8HPKITfthKnsSZK/4uRtcQ+oueGJgcvCdrpd0dObQclNyeaAqeu5PQuJmqOoVMe0uWagZnEbgiXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from CH3PR11MB8775.namprd11.prod.outlook.com (2603:10b6:610:1c7::5)
 by IA1PR11MB8173.namprd11.prod.outlook.com (2603:10b6:208:44e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 20:33:47 +0000
Received: from CH3PR11MB8775.namprd11.prod.outlook.com
 ([fe80::d17a:fdd6:dfc9:19da]) by CH3PR11MB8775.namprd11.prod.outlook.com
 ([fe80::d17a:fdd6:dfc9:19da%6]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 20:33:46 +0000
From: "Daniel Walker (danielwa)" <danielwa@cisco.com>
To: Brian Mak <makb@juniper.net>
CC: Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew
 Morton <akpm@linux-foundation.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] x86/boot: Add option to append to the cmdline
Thread-Topic: [PATCH RESEND] x86/boot: Add option to append to the cmdline
Thread-Index: AQHcM9vaUgnSkbSUKU+xShdi6UXz3w==
Date: Thu, 2 Oct 2025 20:33:46 +0000
Message-ID: <aN7hqiQg1cDIMIG9@goliath>
References: <20251001230408.13137-1-makb@juniper.net>
 <f2ed7b6a-46f5-4ef2-a0d8-703595a5ffee@intel.com>
 <D435A8B5-46E2-440C-940F-A3FE5364C1CD@juniper.net>
In-Reply-To: <D435A8B5-46E2-440C-940F-A3FE5364C1CD@juniper.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8775:EE_|IA1PR11MB8173:EE_
x-ms-office365-filtering-correlation-id: 0a029683-8255-40a0-1375-08de01f2fcc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zaotDrvtsj0BiTgLzSnRCBCf5Zka16gaLLLgWHHH1QCUdsGD0FrrZnmcOkz9?=
 =?us-ascii?Q?Iax6+E4T27wLqkojkffbVDA9cW3YIfdvPdXxcfG3IVNNIYI4iXzADm4WU4BA?=
 =?us-ascii?Q?iqy0JD0xTWwTCtwbBri2evoOEkyUMEFEhvVMGxrOui+DkKTzpoi3/ODBATIv?=
 =?us-ascii?Q?JUat4ZFHOyDDLpTeyaTNMcrFHDs5orL3q4Gq64InYU46ICrv/PIKec+874Tq?=
 =?us-ascii?Q?xeYggesWCs4eXjijxq7yQBjDnGNimuGwaNPvMLnNeF+Km9zz8FBN7k79z7QP?=
 =?us-ascii?Q?i/i51M/SXrLIFlkjx6uP6SfBDDg3c2cACLvKbXdA+kPe5co6fibYuclR+Q4x?=
 =?us-ascii?Q?t3+4UQTeTGAPxxMjD96ZGjsDlHHmSD+vZVAkDy6Mv5IrT+S8SzwUWlfKcBFK?=
 =?us-ascii?Q?hjuvHNIQne0hfy/3l66Mad0Fd9cOu44sd9eqCWiYSU41aisH1CB1aOkmpYw3?=
 =?us-ascii?Q?Wly4Rfk3nfFFP/Otshl8/NG02iwFBO6CZCuR0xZSSjBf37HhmvTa3DgO59xm?=
 =?us-ascii?Q?nmtkrqe5TpaEFW7ccN3CSZQPt5k5X7cjVab9hw6oDZYAQ5R/cj5PTqcdCjpi?=
 =?us-ascii?Q?4a8I0Q5gYKe3g0EBqBuj6ayqobl4AF6IPO6INuZ8Is2YSac04NlPFenJvg45?=
 =?us-ascii?Q?MUJfSoN9DGGeORYfieXQCXJ9vv8ndT9T0PJjKdXHP3S1rMVkVkZOGJU+QtDL?=
 =?us-ascii?Q?m2xy/QpLf6RY897UGqzmaadMxLT49eD9aF41/CO0LgKXHkpgTDpPfr9Gl3mw?=
 =?us-ascii?Q?bpSFZXRjw4jJU6hDj0DT7ai10dgXtviIKZmZJAdA8DOpfQVV5j13xMtye4gQ?=
 =?us-ascii?Q?sJGzTYXpgY5RskAeL1Sx6bTEzN4NJ7Toec5yDFNvLYVd0dooug4cRw2xjoqX?=
 =?us-ascii?Q?o9PyfNJVPFGGerRM2SeAVNHJn/4ZQaF4v/fzVM0s3Kr83TZjchtPrMQqVCMo?=
 =?us-ascii?Q?3Q1lxrYs4RVeUiH/wU13Bt4mWWmhoSaKsci4ELga7SkU1OlUWNYPv8qq4Emp?=
 =?us-ascii?Q?l5wnfDMTVixNHwEuPQofCtEgxh+aIFUR035yRBkBT9Japbi78flNWN2Gij8K?=
 =?us-ascii?Q?Woe1Kz8uBldNnPnwDHehSHqGJmYyVKV/HeVzUIn81CKaUGeUdifpH99chPK0?=
 =?us-ascii?Q?UfK69vRKhFQCbJLudgnV5thD/n/MNnoROlUoMySkdfSB+YLaNh5/2C0OWooN?=
 =?us-ascii?Q?S+NQhvXcXN1g/Q7PkbWFR+e3aXLliqwBeNUbpx9CaQklrIw77n/tSMCpwXGE?=
 =?us-ascii?Q?KNf1r5LNs32mvg2SvEYaTgFFSqJQFBZdYL8SdvOviXLTdw50M6TpvM7VoYaz?=
 =?us-ascii?Q?rMQo5oakvTrj716WSBTF7329RNJMZILByuxqh4ORUCP/M22TgY0KC28mfU7c?=
 =?us-ascii?Q?fVJxjRejHd/QGTU2d3PSxx0adi2DYPxdzWFIvb04kPGc8zzyoYhRdJrxocjv?=
 =?us-ascii?Q?UtZLrRYhVr7DLKGtLqjhC7C9jVJWvPOQ8pI4AgfQEsL2jDKdsYDfr9FG/VcN?=
 =?us-ascii?Q?b9QmYPjQuH7BwiZf5iqLzVgtEGdEl9z7HI5E?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8775.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9V3qAlevn5daNAGFtvMB2ScG6d3N8nJWrjt095LB8svnYGAsLloZR8VbVU/U?=
 =?us-ascii?Q?iP6/0GZXyNg2sxS3JT62TEQ99dO8BYz5xS6RluA+gFz6eCZtfKuzhOJ4oS4O?=
 =?us-ascii?Q?yAgLvIHHWHYjjYBhWXxf2JqVMBtc9VFn82ZM2UCq42dNLAAXt+l10LNlmuel?=
 =?us-ascii?Q?xMd6uTjSjG5vlE2Fwph3FqG/7x4QDBR7cehA0jX/IBA13tse4y0Qs9wUbHn1?=
 =?us-ascii?Q?n5B7A49UyCfwa8s5V/hkIcILWT8CiMwQXS2xo47PWnp7XK/sODf1zboJFjX2?=
 =?us-ascii?Q?8eO7JnbzktHBTmSeOoRnyuXosmgG1ELJCPN/YoFifA/lDwNff6it9jAPF8lg?=
 =?us-ascii?Q?xvRwGVm0d6aVhsYAYhlTrmb/2kkbeURCkelS74zTKhQDLWURNqvb5j3w11E8?=
 =?us-ascii?Q?TXsCO1nxLPx+fEbBX6FOYFoQzC+7Y5fvAjs0VaaFdGcqG4Ow0Gy5NRmI/Wgp?=
 =?us-ascii?Q?Kw9J05ngT5Uy15fpGnSSkz9K6tZpemI9reVw4NvZlwgcB4qBSWTFZptKp/3B?=
 =?us-ascii?Q?2V5V529xPJISP/XT6F1+WvZ78q5/v/F/8rWB/VGvQd3M6gFXe/8d3PVM7aYS?=
 =?us-ascii?Q?qWajJQrBGo+uO2prJTCEbvVWdb1JTukH2/VFxgwfWQzHMExWElq9Hs7vQanX?=
 =?us-ascii?Q?w/fIcQNUl2sSHOKWokb2Dt2SnsL62vBMYe1/3b1AI0hH8lNLschbRYzIatIW?=
 =?us-ascii?Q?LaUkm1/S2/GQU0wQbMd4pSCCi5jaI1XqHt4SXEA93WDjWUezmAFF9sZsT/hV?=
 =?us-ascii?Q?6dud99O31BA7VCUwGm41SuSvjCF68YyMGq8pHk+CEzFjP5w7JUyCJFEQ4ltR?=
 =?us-ascii?Q?A1eIsR3ab8r5Ei+snc5trPaJqVfJzI1dzbaydB61mOv2JDv1if6iPMMi8CG2?=
 =?us-ascii?Q?BGGTK57EAwToCkhsMI9yO7LB10CusHKjM2U+SXb7Z0P04pFaOHWD0DIUy1sr?=
 =?us-ascii?Q?e8Y7HvyAmysPBAqj0fNIMtzD7nPPdMlHoMfFM4iBlwTRZEoPX6lsyTr+iUGl?=
 =?us-ascii?Q?oUA6bPrF2lVhQVvDMZrhEyWjeTEaHBWmdUp8/7vvNOkd5aaeMcuVOnxfkdWW?=
 =?us-ascii?Q?ouOuLZj0JPeMG2/z7EmouvfhgBneKK6ZCfAOnIsGF8A4wfPBup5J0kO/4oGe?=
 =?us-ascii?Q?ACe4ySBd85vRabAG0TNL58XbXQV7gUQwRWefcIgg6kB5jtB7uMn0n1ud/2nT?=
 =?us-ascii?Q?/uLoMC0dWaP7utTx7L+pcaWh7oo1z/B4dyc56TH8c8aVDwqka7lB8/JrCG5l?=
 =?us-ascii?Q?9Aa1zqLS9qFnmiRMn1IziGC1/NyIlym++GmEdlWJTBj8m3REOUWwPRQd2PLu?=
 =?us-ascii?Q?aIPOcQ0Zs8B+S5h3zSl+X+bKw+e7w/MaX+qstTS4dQ5ailpXDR0GGPx3ri7d?=
 =?us-ascii?Q?C4Q+GB42J6dMrISsBFsZwztjjlUCNi6AsPCPOttSqJFASpG0IVtiZBXB01WS?=
 =?us-ascii?Q?wswZGdCMblAeHNo4W07nVSsNdbcCnuTAljerPcXSYirc6Oi4RJko2M3GXHll?=
 =?us-ascii?Q?VU+2YY+rB6vx65OsWnLoSqAfMKm1UjRph0UDYggY0S9t72C5GWi9AyPz+4at?=
 =?us-ascii?Q?SraRuCd7oy7pLueZzKSqfgzyj06wfkV2vNR9gmd5?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5BF2D8D8E733B64581D2FF7D10E2A85E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8775.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a029683-8255-40a0-1375-08de01f2fcc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 20:33:46.7172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Z4x2DetMSUIPUSUW0W+0shcwwWf/F50dircSABAEDoSuhRWM/905hp/YbQLU9ZaEgEfMslppDWu7uSog+4hHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8173
X-Outbound-SMTP-Client: 72.163.7.164, rcdn-opgw-3.cisco.com
X-Outbound-Node: alln-l-core-01.cisco.com

On Thu, Oct 02, 2025 at 05:30:10PM +0000, Brian Mak wrote:
> On Oct 1, 2025, at 5:13 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> > On 10/1/25 16:04, Brian Mak wrote:
> >> To solve this limitation, we add CONFIG_CMDLINE_EXTEND, which is alrea=
dy
> >> available on several other architectures, to make the built-in command
> >> line append to the bootloader-provided command line.
> >=20
> > I'd really rather not have another copy-and-paste of another
> > architecture's Kconfig bits into x86.
> >=20
> > At the _very_ least, we'd get a boolean ARCH_HAS_CMDLIND_EXTEND which
> > would then expose an arch-independent CMDLINE_EXTEND option. Literally
> > duplicating Kconfig options just isn't scalable.
>=20
> Hi Dave,
>=20
> Thanks for your comments!
>=20
> Sure, I'll introduce an arch-independent (ARCH_HAS_)CMDLINE_EXTEND option
> in v2.
>=20
> > I also cringe every time I see code like this get added to arch/x86 tha=
t
> > really doesn't have anything to do with x86 and really only gets dumped
> > in to arch/ because there's never been a proper refactoring of all the
> > copy-and-pasted code.
> >=20
> > In the end, refactoring Kconfig is dirt simple. Refactoring
> > builtin_cmdline[] into arch-independent code would be a lot harder.
>=20
> In the past, there have been efforts to add arch-independent cmdline
> processing [1] (CC: Daniel Walker). These efforts have been stalled for a
> long time now though.


We use my change at Cisco in production, but I don't submit it often enough=
.

Daniel=

