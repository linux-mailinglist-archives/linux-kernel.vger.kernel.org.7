Return-Path: <linux-kernel+bounces-830979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE712B9B10C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78BC1380BF7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75294319864;
	Wed, 24 Sep 2025 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="kapLEZ8K"
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ECC42AA3;
	Wed, 24 Sep 2025 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735050; cv=fail; b=LML3HMqhEIzxuSQnOaPGLEG1jtvu4uNsL+p6CmaFWoieWkfX1Jr6hZGOAYJ8gLIR0fGZbdQYj+2u4/WFl/Xg/KIn63zM/YFwSMVsXERctAIivIjazbXzajybeELFIKetd3IpwHpREyjfP3CVuxfmPMlH9dOBnO3sbNuIV47e0a4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735050; c=relaxed/simple;
	bh=T4l8kC1Bj+GgiuRgaWCOr3r8UJlzSs8VsA2jtucNHlA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tPCrX15iusmmozT92bDWbkg7asUQ9skkXkUgh9d3qBj+2QtMLvTYAVV3WeRW6DCXkHrFseEXjue2a3nCVXL7bTzm+IrOUz3nKralNwa2qdPcZ3IXSEq281ZLj7vMMuJzG9v6LW//h0oyI1IiFV0Samw+B79iwUIkCPvP1bFIYiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=kapLEZ8K; arc=fail smtp.client-ip=173.37.142.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=458; q=dns/txt;
  s=iport01; t=1758735048; x=1759944648;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T4l8kC1Bj+GgiuRgaWCOr3r8UJlzSs8VsA2jtucNHlA=;
  b=kapLEZ8KXV/4PmMetx6aHS0/4IXR35l8AXN5PCEEKSV4aJ7HKEfa3wZo
   Ssdv1H/1QPuUoqrlNSF/bRxLV9o40uE9bR61+5Xh2iBcGujLrn8OpAc+p
   eESOIXjneO/uCagSHVq0KcptYRYwmXHHwPQ+t/Yw48SBGteX+RaUrjkrh
   pcND0aZGBk3pxJp2xrDuzOUvPUltrgTPsAr4ct2/IXBsT2QyNm3Rvl1qH
   Le8wnt5AsKHmWUtMPlfiAcYNcAlBUOZ1ohBZLcYLyaOR5EdnGFeCV43KF
   W1XablV2/IQ4DMraWTBwh0ScC1oSfpB8XYARf+flB/Kt09XN+zPelBTcY
   Q==;
X-CSE-ConnectionGUID: v/Gxu5gCRF6nqnOVGrHJAQ==
X-CSE-MsgGUID: F07PyjRZQKe4GjSIyweShA==
X-IPAS-Result: =?us-ascii?q?A0AHAADxKdRo/44QJK1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQCWBGwQBAQEBCwGBbVIHghdJiCADhSyGVYIknhqBfw8BAQENA?=
 =?us-ascii?q?lEEAQGFBwKMQwImNQgOAQIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBB?=
 =?us-ascii?q?wWBDhOGXIZaAQEBAQIBEig/BQsCAQgYHhAxJQIEDgUigmCCTSYDAQKpfQGBQ?=
 =?us-ascii?q?AKKK3iBNIEB4CaBSQGITwGFbIR3JxuBSUSBPBuCaD6EQ4QVgi8EgmZSkDCNI?=
 =?us-ascii?q?kgKYhYcA1ksAVUTDQoLBwWBIEMDNQwLLhUjSwUtHYEnd4QUhB0rT4IccoF0V?=
 =?us-ascii?q?0GDUx4Gaw8GgRUZSQICAgUCQz6BawYcBh8SAgMBAgI6Vw2BegICBIJHgRJaQ?=
 =?us-ascii?q?AMLGA1IESw3FBsGPm4HllaHA5Z7sB8KhByhcQQvg3GmepkGpFmEPQIEAgQFA?=
 =?us-ascii?q?hABAQaBaQE6gVlwFWUBgjw/ExkP3BV4PAIHCwEBAwmTZwEB?=
IronPort-PHdr: A9a23:Ip8vdBYnM43M7/EsGb5eQDP/LTAchN3EVzX9orI9gL5IN6O78IunZ
 grU5O5mixnCWoCIo/5Hiu+Dq6n7QiRA+peOtnkebYZBHwEIk8QYngEsQYaFBET3IeSsbnkSF
 8VZX1gj9Ha+WXU=
IronPort-Data: A9a23:S5yCQ6g6K5q30pMNxHHBbRszX161CBEKZh0ujC45NGQN5FlHY01je
 htvX2GEb/jYMWf0LY8ka462/UsHuZHWnIJlHlQ/pHw2QntjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOKn9CAmvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZSPULOZ82QsaD9Muvjf8EkHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqUGvclnHDxB3
 sY2djYUaDe9qPiW4puCH7wEasQLdKEHPasWvnVmiDWcBvE8TNWbHuPB5MRT23E7gcUm8fT2P
 pVCL2ExKk2eJUQTYD/7C7pm9AusrmLkeD1RpVmWjaE2+GPUigd21dABNfKIJIXUGpUKxBnwS
 mTu0TymOgAYDu6m6jfZ3XCXp/7QkBj7cddHfFG/3rsw6LGJ/UQfBQMXXlanu/S0olCxVsgZK
 EEO/Ccq668o+ySDStj7Qg39o3OeuBMYc8RfHvd86wyXzKfQpQGDCQA5oiVpYdgisooyADctz
 FLMx46vDj10u7rTQnWYnluJkQ6P1eEuBTZqTQcPTBAO5J/op4Rbs/4FZo0L/HKd5jEtJQzN/
 g==
IronPort-HdrOrdr: A9a23:Bc39uqltzmdB1hCh7qTDgGvTjkTpDfNRiWdD5ihNYBxZY6Wkfp
 +V7ZcmPE7P6Ar5BktApTnZAtj/fZq9z/JICYl4B8bFYOF/0FHYYr2KnrGSsgEIfBeOt9K1tJ
 0QPJSWZ+eAd2SS4fyKhDVQVuxQv+Vvk5rYxds2rU0dMD2CApsIh2wWe2Trd3GeBjM2eabRf6
 Dsn/av0gDQAkj/Gf7LfkXtMdKzwOHjpdbNWzJDLRgh7wWFkDOv75DHMzXw5H0jegIK640PtU
 zenSLExojLiZyGIxnnuFP73tBzop/M29FDDMuDhow+MTP3kDulY4xnRvmroC01iPvH0idprP
 D85zMbe+hj4XLYeW+45TH33RP77Too43j+jXeFnHrYp9DjTj5SMbsFuWsZSGqc16MThqA77E
 t55RPBi3ORN2KZoM3J3amOa/itrDvunZNtq59Is5UVa/pvVFYYl/1twKoSKuZCIMo/g7pXTN
 WHy6rnlatrWELfYHbDsmZ1xtuwGnw1AxedW0AH/teYyj5MgRlCvgElLFx2pAZzyHsRcegN2w
 3/CNUiqJheCssNKa5tDuYIRsW6TmTLXBLXKWqXZVDqDrsONX7Bo4P+pOxd3pDnRLUYiJ8p3J
 jRWlJRsmA/P0roFM2VxZVOthTAWn+0UzjhwtxXo5J5prr/Trz2NjDrciFir+Kw5/EERsHLUf
 e6P5xbR/flMGv1AI5MmxbzXpFDQENuGfH9euxLLW5mjvi7XbEC7NarBco7DICdZQoZZg==
X-Talos-CUID: 9a23:GPvjMGDJoVXrJuH6Ezcg214JR88OSFODym7WBHGXE0ZLYYTAHA==
X-Talos-MUID: 9a23:dbhcywja783RBEvDx2E5X8MpGp8327WsMnI0sphalMu/FD1vNgydpWHi
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-05.cisco.com ([173.36.16.142])
  by alln-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Sep 2025 17:29:40 +0000
Received: from rcdn-opgw-2.cisco.com (rcdn-opgw-2.cisco.com [72.163.7.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-05.cisco.com (Postfix) with ESMTPS id D50D718000153;
	Wed, 24 Sep 2025 17:29:39 +0000 (GMT)
X-CSE-ConnectionGUID: gPWyVfTLT22JIm1DU9/uBg==
X-CSE-MsgGUID: sAQ7NA6wQouqj9FtoOeFTA==
Authentication-Results: rcdn-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.18,291,1751241600"; 
   d="scan'208";a="39253471"
Received: from mail-sj0pr08cu00102.outbound.protection.outlook.com (HELO SJ0PR08CU001.outbound.protection.outlook.com) ([40.93.1.74])
  by rcdn-opgw-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Sep 2025 17:29:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exHJ9iYTnZaXOgz1uPIeiGlfPvpm1hJD6OhK48shYYNolqUhCOjDziklMIDI1z06NUfGro2LgM7TGJrhoQpzGKFSG/neFcTQZxI3Znf0dfYoU+XkUUoh+pOGnqX3su6E26zYrjp7A8YQEZsriyWiFAvnEFVfJ6gWTmQHAjlATrVjh1oF6SdrbIA1JFC7oLaE86CmxxupzuSkSR4Vl9dBRckQCHhnRuBEthSBNCQCl/3m2MbxM9qfNEwvzrff+ME5hoQdWOE1KM07xQSKA1rQH6q2nJRHpo1OkzsrRENJfqk5POeKFVXlikU+vpe2mCRImVANXVsdRgiAoHrlg30HuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4l8kC1Bj+GgiuRgaWCOr3r8UJlzSs8VsA2jtucNHlA=;
 b=WGFX6NEZgX9yYEQftwSOWWa6pnq5OBmJ76KEYdGh6Th6hExSWpNV8Jjg12qps81lMT+8yBgP65G6nCleAcPrf1VD3inD2MprUeMn2dK8fDpW9egTuUfTdM1R+tMjybtoUYIQEfPKZKsr4uuS8o0cx4GMZUUWAtxBMeznQE/D3Jx5e19NgFBzQBZEB7XSlaA/+HL/wT8Ok7FuRJMv1QeUqr+NgVufGEWBZ/fgL3bkbQOelgTDgUjhVK8JWwLUF6Sejav5ld6rPLQYC4QPrKVuiqDHmdNU7xGF/jYn+uhrmjLKB7Q0ZmxXOgduX8pGQY3wtF+Kdp9+hH2qxrFHgL+dlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from PH8PR11MB8108.namprd11.prod.outlook.com (2603:10b6:510:257::6)
 by CYYPR11MB8358.namprd11.prod.outlook.com (2603:10b6:930:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Wed, 24 Sep
 2025 17:29:36 +0000
Received: from PH8PR11MB8108.namprd11.prod.outlook.com
 ([fe80::24f9:339a:70bc:39b9]) by PH8PR11MB8108.namprd11.prod.outlook.com
 ([fe80::24f9:339a:70bc:39b9%3]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 17:29:36 +0000
From: "Stefan Schaeckeler (sschaeck)" <sschaeck@cisco.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
CC: "Rob Herring (Arm)" <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "schaecsn@gmx.net" <schaecsn@gmx.net>
Subject: Re: [PATCH] dt-bindings: edac: Convert aspeed,ast2400-sdram-edac to
 DT schema
Thread-Topic: [PATCH] dt-bindings: edac: Convert aspeed,ast2400-sdram-edac to
 DT schema
Thread-Index: AQHcKZ802JEjjJGaEkyYuLZKcCcm1rSelnGAgAQGvYA=
Date: Wed, 24 Sep 2025 17:29:36 +0000
Message-ID: <60D59E9F-B7AD-4A2B-A3F0-AE15EDC6B89B@cisco.com>
References: <20250919195326.2079446-1-robh@kernel.org>
 <0fc79e55e5fc0f8a43586ac3f90599b8f2a6c817.camel@codeconstruct.com.au>
In-Reply-To:
 <0fc79e55e5fc0f8a43586ac3f90599b8f2a6c817.camel@codeconstruct.com.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.100.1.1.5)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB8108:EE_|CYYPR11MB8358:EE_
x-ms-office365-filtering-correlation-id: 5a03f50e-3b36-4201-91ec-08ddfb8fef15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|10070799003|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2CPPoivqXCAGpj3Q84r/QfUQyQ/DXF6JpgQyZixkTY3Y7qbtN/KSHuRdpIvj?=
 =?us-ascii?Q?buCGbX2EgC0zw1rRwLi+NRuHdOMfqjR0ZmFudfVTfqmQpeavUqgrAWqmrFN/?=
 =?us-ascii?Q?+JnI7prV3mluGnUgLZwQhN3jwxf/sVk92vj9sNHff44lsl5MPpz3/En/RiUI?=
 =?us-ascii?Q?WwqAOF3U5PgdTsNdN8ajtqMT1//hnchgIgyDKgzpwIP0GQYNOnvp+fdTnHIX?=
 =?us-ascii?Q?WoE8Sj0ciW7QfeTP8xFStaZR4BJjwfcDFVI7SNFpw8yihx/c6i0/dtmVRX6+?=
 =?us-ascii?Q?kimfe2ICv5Y0fDB95kabQcEpMFcYehhgXoXvTXX+/qsCMY0Y6oRiJ4Y5xfWk?=
 =?us-ascii?Q?BesF9aIhTpsKjcHAIUqXcyx6qniZEECrztsCV+ODwTGrF9qlRSnT13kAXC8q?=
 =?us-ascii?Q?kgY6KMEBt0+uRIRKgiUZlvQSAeCMrz3p6IYs4yKDwXDLkXfNyG0fQHiaUiHH?=
 =?us-ascii?Q?GDcIb8jxwIcsU6kGiMrI4xaUry99REcseRAQzgK9zdFSk0KvoMBlbD2rrn7j?=
 =?us-ascii?Q?10KqnyFvX+0mp7A9oLM62pCQUonC2WV9yIBCLW3JXfuSdekObujalyeD+v8H?=
 =?us-ascii?Q?JZ1gofqI9Ch4aO2Co0BaTqU1omH+IHdsI6t4yyyFyt+3F5JJQcp39j0zFlgG?=
 =?us-ascii?Q?DPYNfghQ8UB6GTyGOGmJBMa0S8q/dznTE9s4yHXqHsp6KxboxM8PkwLaebhN?=
 =?us-ascii?Q?mR77h8+Agfhk7QlzhAhpsEkBZ8oVZcw6gqRkBzsKXj8c2JMBVGYJucFn6MX6?=
 =?us-ascii?Q?V6fZ0oSYPkkNd3aiza16+xyV00ILEOgiDGfZVs+XdwZtG316khR3l66npuDc?=
 =?us-ascii?Q?n2R6ISAIyvsHPL1rc1EbtIT9n+2gSSWG2Uw/c6AzZtrIYLciaof4er7vQmv3?=
 =?us-ascii?Q?WlbCb053HCEH9NGnNYdmtzhm2PmsYwS/mi3b1Qrx01ZXDOsZzuO2QnynCYie?=
 =?us-ascii?Q?JiL8/+6PsAL2MCBxYznRZErQpmU3BX/Ybvsc5cGVP+VotW/fDTo8LZZs7rBM?=
 =?us-ascii?Q?X+N4DeT3HxgE7B1vkZMLf3XuMFL8vQbMjUb4EnQwY9CAYFrFm5fwbCsKzymP?=
 =?us-ascii?Q?2uA9Fuqg/r6rqN1Q35UilRfxJwTiQ8QQD3uWjCos2q2mPJ/FKMgnmvGCKcla?=
 =?us-ascii?Q?KfBctFqFTlbOd2SC0oWhZXRwFJUTr/gwuFp+W06ji84WZkyPqYj3fiudWop2?=
 =?us-ascii?Q?MaShDfaaDsuHhdmVCeq37Suvb+oUwTbtM4Szo4Uob2zXLaEKle0Gu9+uLPYW?=
 =?us-ascii?Q?OUdAZXLaIgGh1ZwDEM2ciykMSig1YlfC2P6mGlUVRBXluQVuuNYmZ6EuS8Ss?=
 =?us-ascii?Q?YHoBFB4+bfdlu0u63Z5RWo0sLziDNrXhuWK5mjG1HXHhOcb+PMeYSh53xoLT?=
 =?us-ascii?Q?OLLHx1+FGYY6TDovEbwqC0E3jMu6whaZyu7NRIC08nJ3jhzw7q7zQetnZz3n?=
 =?us-ascii?Q?AvdxfH7wly32iUqydm4KSKvkHtWPk/TDdZesecYdK0wIbbkgSYN+EgKGS2fe?=
 =?us-ascii?Q?/uIpEdmtSP2VgGw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8108.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XE1B9hZhC1Fgfz4/UWHyM6/N098A8QoePbWZ8MXR05nCXcef1pnFiR1U1e/D?=
 =?us-ascii?Q?dUbVJ878tKxqDu+6vgLr+qXdCJiIH7tk+pGWSFqDTJM+4jG/sEa8uhwlFpDF?=
 =?us-ascii?Q?7v4HPZXSp7oTxDiHvEM3Yuuna1nJ3zK2s9O/SWtTEF4TXod5jnJ2UDQvDMYR?=
 =?us-ascii?Q?kXB8ddBLT35hjrowDs2PYwpNinrAYqMQuyENXmaTAH7wd14lSPuw4xuKuA8/?=
 =?us-ascii?Q?VK/s5UuG9vhZCQM5zOr8kmv/a/g4kZBL+6BhR0SMehPjEDpYhfEdsVyAr67m?=
 =?us-ascii?Q?znSIhfqMk8Z21cisr1XSjVWdQ6zgMDiH6dpCPOQusU9j78buii+glVbn5UBg?=
 =?us-ascii?Q?rSiVAXwhOoppzyH4NvoapR0dmitxjWTSlMWRIik2A844F7CJqapWhkUiyNTf?=
 =?us-ascii?Q?LICCo8ceyZtbq3SIzr5f5UrPyhpo3SleAbKp5UXxb2GCr8zzSF2bh41Mg0F2?=
 =?us-ascii?Q?Wz1pCHQN3J48uGJlodsI/re+AqkSSppNiC+luzzqqXRtUk/ckFZLO/QR0Avo?=
 =?us-ascii?Q?h9pIJJJ+a/cr8M1E9vG8Wm/FI8VQ3t3EwJN/KailDwpk2wibnD2vsG4na5xz?=
 =?us-ascii?Q?okyf1ZFCBD9zripRFfADv3LsmUaOWWY7/Yv62Xhq5SwUagx3HI36/YOIB7Xt?=
 =?us-ascii?Q?Jd5Hk9ScpIfzEwddrft4BGdXmd71r4Je88cToMlXaGJ5SiVH1RWaKHx4aG6R?=
 =?us-ascii?Q?tcNtNA/kLwLarpJo1RmMn3y+LgC9Ln0Rxf+imPhNaklqkoMJxFObwvqbsC3J?=
 =?us-ascii?Q?Sco3H70SpnaopuBcOO+v5gJw9jZIehthbscUjtlp3sQjZ6WyiN/PvbnrkPyE?=
 =?us-ascii?Q?Rr5N75BUutZ99OjpZIXaqZjrqP1eonM9n03Dh36h6yvl8inuxPWAY4Xlmbj1?=
 =?us-ascii?Q?/nCRjoqwcKylDEAFutNnvLz6DRj4JU1dQIk9Nhbpnfyn5GKb1ZNHo7m7eXAi?=
 =?us-ascii?Q?8hCaY/ULuwRL5oRedKLdMIjLLDXKWfSPLZRmufFHK9wV6zuhG7g7CwOXVWQH?=
 =?us-ascii?Q?RuLsceKY6aA/HJPRxYuHjgdqgVYAz3uoPXMb8UIUjRtkO9vk4aFEIge4bl7p?=
 =?us-ascii?Q?mOddGAhtHQAp9BwjjNa25bMckOFJ6GmQcEFkaDiwfxfsAAip34d3zygZV+0M?=
 =?us-ascii?Q?N/pkk+bwZ+7pdEljge+h8oXfzSVkPPjzNsQ7mMviFf9poEwgUb/PIn3BtQXt?=
 =?us-ascii?Q?bb0WM13I/n3Q+Tn7+FJ/vur/yqXVpNJ4lTVdhhHDCg/H2MqJaDuwhfgVWVQz?=
 =?us-ascii?Q?Oa9e6y8kCbXv8K9RhBmKabzOlHkMvfXhrHf9X6cQa17GMgJNq6Fh94MflSbA?=
 =?us-ascii?Q?m7Edauu0Vhw8xvzFQ8Ft6Kbc+m6HsdVqliNJiGNaVGxkpFI43Z8pNoTnYH4+?=
 =?us-ascii?Q?oAsSNQblUiVNdKo/EM2F/YtJGR3oHLdi8tNYKuNXt6+agt/qlba9fvoP+N1X?=
 =?us-ascii?Q?XpbFUw//qDdEA1wQzm3Hn4dGzf+5+ibwHUT4a+CSjcKee7QohWcmnPjiGjkA?=
 =?us-ascii?Q?v0RM2bIIOrvQeoigO9aQH9DaeoZaYTxUjTPmhpQmu0nzfWtrqauQHDWuiNaC?=
 =?us-ascii?Q?BSmkPPnYM8I/0pnLGf24cFVOtMyGN9OPvQMrmxN1jtm0MYIurnESNPTXZlju?=
 =?us-ascii?Q?ZP/MBoinYhX6hNfRFq2HkAgM5BuiUz4aYQB543cYONaR?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EDE87D521D42AB49AF5CCA71A6B06C8A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8108.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a03f50e-3b36-4201-91ec-08ddfb8fef15
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 17:29:36.6455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eZzLNZ5vpf1xOm7OthjfUIdGqi5/uv+wAQCzZzn2bqv60DCLZOEDAuo8h38gpZ4bCPDOES1mkEwgBS6y7awiCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8358
X-Outbound-SMTP-Client: 72.163.7.163, rcdn-opgw-2.cisco.com
X-Outbound-Node: alln-l-core-05.cisco.com


> On Sep 21, 2025, at 20:56, Andrew Jeffery <andrew@codeconstruct.com.au> w=
rote:
>=20
> On Fri, 2025-09-19 at 14:53 -0500, Rob Herring (Arm) wrote:
>> Convert the ASpeed SDRAM EDAC binding to DT schema. It's a
>> straight-forward conversion.
>>=20
>> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
>=20
> Thanks Rob.
>=20
> Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Reviewed-by: Stefan Schaeckeler <sschaeck@cisco.com>


