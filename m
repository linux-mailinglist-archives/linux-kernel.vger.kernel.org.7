Return-Path: <linux-kernel+bounces-830884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A25EB9AC8E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C57D77AD8B8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284B63128CD;
	Wed, 24 Sep 2025 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="nF88tP3S";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="nF88tP3S"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021124.outbound.protection.outlook.com [40.107.130.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1EB311592;
	Wed, 24 Sep 2025 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.124
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758729411; cv=fail; b=RLt7uKjW0EuVeeDBT3ub5aRuvHC3Mv6sBgt0awvZQJ2N6shFw84kQsxMwVZi5fjo3PexIDpWZx2bh3qSaG5ZZSEILoSwXfMJS6ZUM+3dMj/iL8hTcvYi2Pi3MuSktJBAsAJqlBl7fDm7hF91nufGjOZ/GWMrw/yD9W305TlhIig=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758729411; c=relaxed/simple;
	bh=GZwVoN4sYk3wLxNGC52aV/K4RGm9B65lNDZn9RQXXyA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XPOk/Y55ZSM2o1OkyhK6dKmUE02xtadmm2bJ4XLVShRlyJtPwEg13Vd8mqGCO+0MGyflPyS9B3sX8Dqka6maxUUk5psqo1onURZp4aihDXHyEBE15ilGtIrvSRJQy1XiDGnzgTZO+iksSDEkzxyj7w/VI1Vy2+23JWLI7A71Kmo=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=nF88tP3S; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=nF88tP3S; arc=fail smtp.client-ip=40.107.130.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=fmA7lC/IqFNijsm/7cHmGYjjKuHoPjSKOzjyMQ+i0FoMhZyVntTmxHw2E1dSWI6ZGQsjIFtkzDa7ibQR3JDPLyRFYpiNic/pWzEpGGn+X3SG2yJ6XNhMpX+LZCmk8WR3vJE7/v/x4B0eyrOs0xzEos+MvZN2LBRi9/ex884MO7Za6/3LPruw2qUFZgFJaUdHZggSl/SXS5Ac94Yb0vP1k5sVDfpAMv3c5bXuqGOTdw9XigCJgC+4vg2RIHoFrDfUwXMNDzkM8LXb8uhPWBySuN2Xnj2qUNpsvBGm+o+O5zXwqPWAXHK3pjS1lSVuuOvJPVCfObdTlBpc+YFJ8bRNRw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZwVoN4sYk3wLxNGC52aV/K4RGm9B65lNDZn9RQXXyA=;
 b=PejnsGq5OlMu9AmpN4TtCS/ERg702ofsl25dmRIpy8CDBqrZ6be7L3+eOjonu6S6/kJCevjq9LOR0HFwJWEWCSdCpzTBaFBgqRp+/ANj09brPBqXs1a6SNa5X9cGWZ0QxQieILyWtydq6WUjaDJLYi6YDpqWPSXi8XLlTZ2e26XIXfLMzkwZWc/RKmOU2bVgrUXz/7c7EpGW+Z5ca8i/GJ6MXqSKbSpYnAI+cNQAwq2TQpmSTY7b3QbhuV7C/sgrzxk51jj1g9UBXUGzApA7LRYLvYDaj1DPhK4PrLLPdjCSS/4SiaRXDm/lgCNAWk/+/XiLk/SB5OAssbZE0AdfdQ==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZwVoN4sYk3wLxNGC52aV/K4RGm9B65lNDZn9RQXXyA=;
 b=nF88tP3SuoYCP7/hQSdLOCWUcWjZh23ELih6LRAyR6RALhybJBsMKBLzTxRR3H3Vddip3CZtDkKxlcGAs+SoP5d7X7T+Nh2tTqR2hA7UYwnhIdTm6epwE7fy4pejMaMo0MVa0mIycMHdLi45ikGM2HTuoapVKUK53zH4EjCZki4=
Received: from DUZPR01CA0017.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::8) by VI1PR04MB6928.eurprd04.prod.outlook.com
 (2603:10a6:803:12e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 15:56:43 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::33) by DUZPR01CA0017.outlook.office365.com
 (2603:10a6:10:46b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Wed,
 24 Sep 2025 15:56:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9 via
 Frontend Transport; Wed, 24 Sep 2025 15:56:43 +0000
Received: from emails-2874832-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-47.eu-west-1.compute.internal [10.20.5.47])
	by mta-outgoing-dlp-467-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 1D25E7FF52;
	Wed, 24 Sep 2025 15:56:43 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1758729403; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=GZwVoN4sYk3wLxNGC52aV/K4RGm9B65lNDZn9RQXXyA=;
 b=oHrS8/e5OkCIJnDv7InOXvqjqTr0Hu+RXiC8pHMXtFGKRXD0iuKPOj/vS8fz1Yz+QBpdy
 f3n8fgc9lsu26gBMbIJ7/EFTqV5fDj0vcpgAmyvmfc8gIcflt/OZfp0QgGBP7pxxshbRRRL
 7F0YqZC1j3n6da0F2oqCTXXBqRKbG2Q=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1758729403;
 b=dfOQ8yW2ElVi1/Os+V23GUECAM2BkT+k3OSM0tN8Hv4ZM1CIH+z8Tz0UZBTiIhc5j38GW
 4TQBmFvZPOJUs2mGE0h+T8pyAKYQwe56PhU3baplZQDM325r2W4/zwVkIprD4U1NCCj0mJ9
 EVuq7f83wJE+oNQU3E6322Ny31g2ycE=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyY5ergFeR6tzD+aBPIA7MfSIK+jExAXtJq6xqyxiqKn1SMdqpE5HVAzlmYHSKPRYFoVlCEEpAiFfIcEeyysRH49VartKumkv/CqwaiyTpovahBGjcXTv4nt4z95k94qpNPX8g+7eIvgXvCw1ZJxKRbXVrzaSPeiCh8GVW7j8EXu4kqsnPA/dV2k0trWERmyUYGhse2u3vHEHQhbstx8Hm8sAlskHTKY+h/ZIMelWookNyOcCMxyHwz1tT0gMMGVl692m7YmxBmPd0hErSo0Oos4ZJEItUt4fLlMbSjJ31mONJhUB2Xb1NcfBezZqfa/WN4f+ecA0/19xf1EVOGtbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZwVoN4sYk3wLxNGC52aV/K4RGm9B65lNDZn9RQXXyA=;
 b=df4Zi30wfe73/39XjCmewFenJksNZQU6Pbk72V23wrmlO5b8omP4AdAjV26uV91j4/SJUOm4GRkCIgeMkDRuzLKaLsk2DYQTUEL9Ta8bfVH7PvuVow4+qR6Iu2InC8K2MzVWBvlJdsrMDsF/G6OkZLryE/IP2XwFT0TTHSxAk8tTcFm86Brz/WAr6xVocdu5smWmvhXs1qiUIUAM2xUbfP6Y/3ZRW8/U68d0dzxSg6m5yw0FpGnC8Gz/tFTJFPjDhh9FYsICtGup7CXWw0nDUdvQdX8FNmR4EBBkfPvJKLz17OLHnK8pVk9R2kwIx+lQxs2Hh6bPI2rdqr/cBcktng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZwVoN4sYk3wLxNGC52aV/K4RGm9B65lNDZn9RQXXyA=;
 b=nF88tP3SuoYCP7/hQSdLOCWUcWjZh23ELih6LRAyR6RALhybJBsMKBLzTxRR3H3Vddip3CZtDkKxlcGAs+SoP5d7X7T+Nh2tTqR2hA7UYwnhIdTm6epwE7fy4pejMaMo0MVa0mIycMHdLi45ikGM2HTuoapVKUK53zH4EjCZki4=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PAWPR04MB9886.eurprd04.prod.outlook.com (2603:10a6:102:37f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 15:56:23 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 15:56:23 +0000
From: Josua Mayer <josua@solid-run.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Rob Herring <robh@kernel.org>
CC: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, Ioana
 Ciornei <ioana.ciornei@nxp.com>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay
 Abraham I <kishon@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 phy 12/16] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Thread-Topic: [PATCH v2 phy 12/16] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Thread-Index: AQHcLMKeC2lV9hki1UmNgNX7LGZlxrSiW/iAgAAfCgCAAAMFgA==
Date: Wed, 24 Sep 2025 15:56:23 +0000
Message-ID: <b18dcd60-8e14-4328-82b1-f4e5c75cfe96@solid-run.com>
References: <20250923194445.454442-1-vladimir.oltean@nxp.com>
 <20250923194445.454442-13-vladimir.oltean@nxp.com>
 <20250924135429.GA1523283-robh@kernel.org>
 <20250924154534.cyyfi2aez46iu2sw@skbuf>
In-Reply-To: <20250924154534.cyyfi2aez46iu2sw@skbuf>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|PAWPR04MB9886:EE_|DU6PEPF00009528:EE_|VI1PR04MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ddac170-8481-4b1e-1191-08ddfb82f50f
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ckNiSW5ubHZDZGpKOU9FQkRMd092SHVWaUo1RStZeTlMVy9hdm00eEhPNk94?=
 =?utf-8?B?T0VGQWk2b3NiSU1ZbXdpb09FSXZFS1dmVVdNMmdSUVU2b0pRT0psYkxaL1VK?=
 =?utf-8?B?SCtGV3hmNWwrcHBKb25VUTNGV2hRU0ZraTByeTF1VDNhMDgyUE9YTzlGQVhi?=
 =?utf-8?B?MVN6OFZDVFhzak5YRjl0ZzhUSjNMRFY4NjB2R1d1cXZFOHN5bzZid0t3ZC9Q?=
 =?utf-8?B?Q0pleE0zNm1uZTdzaDlzcGFEeWxldUlCMlM0QVdobEJaUCs0aUpkK3ZwTHZ0?=
 =?utf-8?B?UE02RVpvcWpPZWd0WVc2cDZGeXN1L1NXTWZ4WXhLZ2hTMmFCdStoL2F5Vk5w?=
 =?utf-8?B?aFQrTVBvYTlzOHRzOVhRbDgwZ0kzdklTNU1lVmZCdTZEM0o5b1BQTVdVVHNK?=
 =?utf-8?B?eGRjb0tDa3B3QVNEcm84Y1ZMb2dzNlpWYlVxUzArZm85cFh6V1BXQVhOeW5X?=
 =?utf-8?B?UXVnY3ZBeFpza05CV0pUTkNBWmVQQmxzSE9tTzBOVVRpV090SGVZWElqdGx2?=
 =?utf-8?B?VThUK1FDa3FiMndkd2lUbllSL2kyUjIzS0tIbmlyMVBVdzkrNWVodURjcHhM?=
 =?utf-8?B?eG1iQmRhUVdGUGdSelJnL1ZvYW9CTUlsSXNSaWwzemtJY2pFMUxObWtnQmh2?=
 =?utf-8?B?bzg4QkVWSmlZTFB1YzBWTmtwbzJyaWYwa2JOTlM4S1o2a21XYXZtS01Ub2tT?=
 =?utf-8?B?MzVBNUxYTjFhdXg5ajQvQm84M21jU25aT1Z3VDlrUWxtdW9tYWJJNnlta3Z4?=
 =?utf-8?B?ZGVDb0ZsUjVzcTM0WCtXZXJ4QkxSSHltQmRqWU41UUpFS011ODJDZjhhdEYx?=
 =?utf-8?B?eFJuQmJ2TGJ6dXpkNE5GQXlRT0RIU1d3SDAxUE1OU3JrNURRUnhTdlVjR25r?=
 =?utf-8?B?YXI2MkZsVzNFV0RzS2F0LzB1TWZLUkYrdzVsVWpUckJPdWlMQmFCczNxK1lu?=
 =?utf-8?B?dmVCQnE5bHlEVDFZNXZHc25mNmJENlJRS2ZxVjUxR2VpTWErSGtueVVUY2pr?=
 =?utf-8?B?aGZNTk0vZmJzL1ZtQXhGUGxtczlkWjAyalB0ZkhRUnNqb0JNQ3kwTVBPdFEr?=
 =?utf-8?B?S2xRaitJcjVTdFdyY3N0NDAvSHpXVXFCY3RxMC9zcXRVanBOd3Y1RklzR1h0?=
 =?utf-8?B?ajlhQlVuWDQxV0p0ZjREMGlKV2Zzc2JUNUU1T0svOTBMUFJTa1pxNHl5SlRB?=
 =?utf-8?B?RzdjQVZ5VHRKVDFrQ3JSL2Z4Rjk2V1l1QTJJcnBPdE1pOWpINlpWL285L2xM?=
 =?utf-8?B?ckxkOHl1bnZDWm1YQThDTmxZMTRuSmlYV2hFNWJsL1pUTHBBSEREeUFPM1d2?=
 =?utf-8?B?TnhaZUlwZXI0N0syN01yUVN2TDJpdlVJM0M3Y0VCTXc5amoyc2x6KzZHZExa?=
 =?utf-8?B?d2VuR09ienJObEpRUldpeGNnTE50TmsrTTFZVE5CVUdFSTJaQWY3cjh4dFRk?=
 =?utf-8?B?QytBOXNUM0VZTCtKL2c2OURUMW8ydkpYckhWemRpSnF6YW9IcmYxL3VXaDd2?=
 =?utf-8?B?U1Z1MTcyajU3V2swQVA3SVRBZzZUNVVJRHBZMzIxUFdBWTM1SVVnSFh1a2lr?=
 =?utf-8?B?TVV6aGp3dW93TVowbkQ2R2R5aEV3YzBpeUJqRUdYOUhOUnhjeWM0MGdSR1o4?=
 =?utf-8?B?R2E2N25YRGVhL29kaDRBUG1SQmhSczBkUkloWENCZHhJQTFTZUVmcUUvc0hV?=
 =?utf-8?B?dUozRkdiWk8zTnErQWZGWnE0SStSd25tOE5rUHgyaWFzSmNNcUpLNWRNWDJ5?=
 =?utf-8?B?dVg3dGNHMlVLVC9uVVZjSk5CdEhzVDBzc3F4MW5jVkxBSjJycjJtTDFhNEtO?=
 =?utf-8?B?aFFXUmRXa3l0TUt0WVAveTNPb1g5dU9ac25jRWM3VTNrYnhrZEZ4TG1tb05L?=
 =?utf-8?B?Z3hPaWEvNG5rbWcrMklEZURIbmxaRGVtWGd6TlNjWU5NUHJNSElMT0dzNnFW?=
 =?utf-8?B?QnRnTEIxS3YwcDNuSEh3elVvZ2Z5UUl6U3lCREZlSkJ2ZnM5Wm42TWpYZWVr?=
 =?utf-8?Q?tSEhsw7xuLfWdTXNbj8jeHbQC3dJu4=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <10BBAC50456AC04084EBFEBAD7CBD418@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9886
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: d55bf16216b849b296bb6d3cd7975683:solidrun,office365_emails,sent,inline:4bce423a7dbcd08a776417f5cacc4ae4
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4f026173-a628-4743-57ab-08ddfb82e92e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|7416014|376014|36860700013|14060799003|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlZDZG1xNk5lMDRYcTh3UGM0U3ByZ1RkYjE1N3pydlBKWlZJK3JMdlFmYnVq?=
 =?utf-8?B?SS9KYW9Bb2h0SU1HTzJSWllKTFJ0Y2xJRnl2aDIxcHcxSjdRc1F3ckJ4aEhR?=
 =?utf-8?B?TnphZ29DV3F4Zm5KdzMzaWVydDh2eEc1RzdEZDN1RUFUTkpZOHRkOTBZdkdy?=
 =?utf-8?B?WnZWZ2ozVWR2MU51d1BkNXBlWEpXTk5KckVsSFFUQkJGUXlUOG05ZklRelM0?=
 =?utf-8?B?dldxc0ZrY1kzZDNJSkMvZFdvcGFBa242cXgxUlc3RjRseTJBSVJaS2hQZXVn?=
 =?utf-8?B?WkpPM1ZIQlgybWdjUmtqNHE3cCs3dnN5Z0ZRNmxMN1d0KzM2L2xyYmVia1JY?=
 =?utf-8?B?b1YycG1FUzJlRUVCTGJ0TWZ0cWVlZDZjci8xajNlNkc1clVCZzBxazFZeFQ2?=
 =?utf-8?B?SzRYOGJXaGRWMGQxd3hYYkhvK2pCb3k4MjJ6TGNPbUdWYTdiMkRnbVh4bWFj?=
 =?utf-8?B?V1RjMkJFQkgzdlRQLzlNUzJFci9UNmgyK1J6VTlIQTV0SmFyeTk4U3pUQjhr?=
 =?utf-8?B?TUNZVFFQUDFINThKRnhTVVVpVjNsdk56eGpLMFVBNCsrVjlOUnllRy81Mzhu?=
 =?utf-8?B?UXFtcXdrVUdsYWVHbkZjL21yakEwV0wyM29JWlB4SmcrVkZ1VXlheXFZbkkw?=
 =?utf-8?B?b0pVd3lqL1U5ZkFMeWNucWtBelJrRjVScVhuMzk0UzBNQksvWVRoQUExRlly?=
 =?utf-8?B?UXhWaUJSdjdWbDVRUTRJb3VHTEVrbEltcFZPOEVBVmdleWVHWUtaVjNtOFI3?=
 =?utf-8?B?ZTB3Q2s1YVE5SVd4bkJOYXhkV1QrNDI4VFJlSGhVSFloSE15L3FlWmNFMzJJ?=
 =?utf-8?B?N0grS0d0cFhTVjJMRE1WWGpiM090VkRwSmtlSDBxczNJaFlpOWJKUCtIckFv?=
 =?utf-8?B?VXJ0cHpSbnV6ZVpldzd5NFhaa0FySytHalNUMnVNUHBkS2lqSzVBeVE2dnY1?=
 =?utf-8?B?VlVic3NxVmFtNHpmZmd5VEFPaVRBY1c2NGFiZGhvK09OK0FVcTR2MHA2b1Bt?=
 =?utf-8?B?NU55RkdqREcyeUFnQ1JSNFVUYXVYYlR6b0VYUUhEWm1Wc1QrejNjMWVyU21o?=
 =?utf-8?B?WVpQS1NZbTFKQmJKOGdLR1FFYW9NWWNJYWJHOXVZeEtqZEc0UlovV2d2NEdQ?=
 =?utf-8?B?NGVubDErNDNxcEhnU09wTUM3eFNscEJ1Y2tlV3FTMzMvODRpSFhoUk5nVEdI?=
 =?utf-8?B?UHlQcEttcmtIRFJLeUpmazl5d0tPUlRWYTl1OTBzb2lXY1BzTjZHcmoyMzRF?=
 =?utf-8?B?a3Y0M3BvMER4U1VqT2dCaVFnNTBhd2RUV0ZVa3liMXVPUlIvRVVUMHNuTFBa?=
 =?utf-8?B?Ym9rNFd2ekdJTzVFZ0hlRmFXUUtra3Vwc05DaXhUbTNTSFBTRkwvc0JkREF0?=
 =?utf-8?B?elprNklmTTl1UUQ3eWYzUk9USkxWTVJWcnBrYlBBTDB6dUUyYWRpUU5wMmFX?=
 =?utf-8?B?Z2kyQWI5Z1cvRnAxSWVYalp5aUlkMTgwelJUMXVHKzY5SW9LUHRkQWQ5QWlH?=
 =?utf-8?B?OGJPMW51RVExL1Q2RE9KazVxMHhQcVhQSEdJNHJZNS9HUTNYOE9QVUxJSTcr?=
 =?utf-8?B?T3hhcFpqam9saVdmREdiSGcyVC9MRUd3cG1DYytFSG83OG1zbWY2WmUrQTc0?=
 =?utf-8?B?S1lGcktNRGcwandGaVhZblZlWkUvN0x3QSs0ZVAzcGtCZEFiWElXbXNQU0Ux?=
 =?utf-8?B?MWF6T0hGWktnUG55UUV2aXJxWjAvME1KK3E0bHFSLy81cVl0aXFUK0tMaHFD?=
 =?utf-8?B?blpRRm1HeW1RZkI1UGZyb3IreGEzL3JlZ3l1THp0TkxnNm8za1NSNWEzdXkx?=
 =?utf-8?B?NjJybEtJTWFqNkJ3cERaODBYYnZSSHBXYThySzE4RlY4aFo5ekVDRG1QRkxt?=
 =?utf-8?B?UmRCY1VJTmdLL3R6L2NmNllnK2RUY0FhaE5nSWZpZ01SY05RUVhyUENjUlNu?=
 =?utf-8?B?VkJaNTZLWjlsZHFjd1F6R2xLMGZvTDNYQ3BSSmRhcHN1eURSSGVLOWpDa3Bw?=
 =?utf-8?B?dHNuWDlhSjd4UjloaWxRTHQwSUdGQmhpS2xtOHVta0RrRkRiOFZ1ajBSbkFv?=
 =?utf-8?Q?S3LZbG?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(7416014)(376014)(36860700013)(14060799003)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 15:56:43.1762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ddac170-8481-4b1e-1191-08ddfb82f50f
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6928

DQpBbSAyNC4wOS4yNSB1bSAxNzo0NSBzY2hyaWViIFZsYWRpbWlyIE9sdGVhbjoNCj4gSGkgUm9i
LA0KPg0KPiBPbiBXZWQsIFNlcCAyNCwgMjAyNSBhdCAwODo1NDoyOUFNIC0wNTAwLCBSb2IgSGVy
cmluZyB3cm90ZToNCj4+PiArZGVzY3JpcHRpb246IHwNCj4+IERvbid0IG5lZWQgJ3wnIGlmIG5v
IGZvcm1hdHRpbmcgdG8gcHJlc2VydmUuDQo+IFRoYW5rcywgd2lsbCBkcm9wLg0KPg0KPj4+ICsg
ICIjYWRkcmVzcy1jZWxscyI6DQo+Pj4gKyAgICBjb25zdDogMQ0KPj4+ICsgICAgZGVzY3JpcHRp
b246ICJBZGRyZXNzIGNlbGxzIGZvciBjaGlsZCBsYW5lIG5vZGVzIg0KPj4gWW91IGRvbid0IG5l
ZWQgZ2VuZXJpYyBkZXNjcmlwdGlvbnMgb2YgY29tbW9uIHByb3BlcnRpZXMuDQo+IE9rLCBJJ2xs
IGFsc28gZHJvcCB0aGUgZGVzY3JpcHRpb24gZnJvbSAjc2l6ZS1jZWxscyBidXQga2VlcCBpdCBp
bg0KPiAjcGh5LWNlbGxzIChsZXNzIG9idmlvdXMpLg0KPg0KPj4+ICsNCj4+PiArICAiI3NpemUt
Y2VsbHMiOg0KPj4+ICsgICAgY29uc3Q6IDANCj4+PiArICAgIGRlc2NyaXB0aW9uOiAiU2l6ZSBj
ZWxscyBmb3IgY2hpbGQgbGFuZSBub2RlcyINCj4+PiArDQo+Pj4gICAgIiNwaHktY2VsbHMiOg0K
Pj4+ICsgICAgZGVzY3JpcHRpb246ICJOdW1iZXIgb2YgY2VsbHMgaW4gUEhZIHNwZWNpZmllciAo
bGVnYWN5IGJpbmRpbmcgb25seSkiDQo+Pj4gICAgICBjb25zdDogMQ0KPj4+ICANCj4+PiBAQCAt
MzIsOSArMTI0LDUxIEBAIGV4YW1wbGVzOg0KPj4+ICAgICAgc29jIHsNCj4+PiAgICAgICAgI2Fk
ZHJlc3MtY2VsbHMgPSA8Mj47DQo+Pj4gICAgICAgICNzaXplLWNlbGxzID0gPDI+Ow0KPj4+IC0g
ICAgICBzZXJkZXNfMTogcGh5QDFlYTAwMDAgew0KPj4+IC0gICAgICAgIGNvbXBhdGlibGUgPSAi
ZnNsLGx5bngtMjhnIjsNCj4+PiArDQo+Pj4gKyAgICAgIHNlcmRlc18xOiBzZXJkZXNAMWVhMDAw
MCB7DQo+Pj4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsbHgyMTYwYS1zZXJkZXMxIjsNCj4+
PiAgICAgICAgICByZWcgPSA8MHgwIDB4MWVhMDAwMCAweDAgMHgxZTMwPjsNCj4+PiAtICAgICAg
ICAjcGh5LWNlbGxzID0gPDE+Ow0KPj4+ICsgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0K
Pj4+ICsgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPj4+ICsNCj4+PiArICAgICAgICBwaHlA
MCB7DQo+Pj4gKyAgICAgICAgICByZWcgPSA8MD47DQo+Pj4gKyAgICAgICAgICAjcGh5LWNlbGxz
ID0gPDA+Ow0KPj4+ICsgICAgICAgIH07DQo+PiBUaGVyZSdzIHJlYWxseSBubyBkaWZmZXJlbmNl
IGJldHdlZW4gaGF2aW5nIGNoaWxkIG5vZGVzIDAtNyBhbmQgOCBwaHkgDQo+PiBwcm92aWRlcnMg
dnMuIHB1dHRpbmcgMC03IGludG8gYSBwaHkgY2VsbCBhcmcgYW5kIDEgcGh5IHByb3ZpZGVyLiAN
Cj4+DQo+PiBUaGUgb25seSBkaWZmZXJlbmNlIEkgc2VlIGlzIGl0IGlzIG1vcmUgc3RyYWlnaHQt
Zm9yd2FyZCB0byBkZXRlcm1pbmUgDQo+PiB3aGF0IGxhbmVzIGFyZSBwcmVzZW50IGluIHRoZSBw
aHkgZHJpdmVyIGlmIHRoZSBkcml2ZXIgbmVlZHMgdG8ga25vdyANCj4+IHRoYXQuIEJ1dCB5b3Ug
Y2FuIGFsc28ganVzdCByZWFkIGFsbCAncGh5cycgcHJvcGVydGllcyBpbiB0aGUgRFQgd2l0aCBh
IA0KPj4gJnNlcmRlc18xIHBoYW5kbGUgYW5kIGRldGVybWluZSB0aGF0LiBJcyB0aGF0IGVmZmlj
aWVudD8gTm8sIGJ1dCB5b3UgDQo+PiBoYXZlIHRvIGRvIHRoYXQgZXhhY3RseSBvbmNlIGFuZCBw
cm9iYWJseSBoYXMgbm8gbWVhc3VyYWJsZSBpbXBhY3QuDQo+Pg0KPj4gV2l0aCB0aGF0LCB0aGVu
IGNhbid0IHlvdSBzaW1wbHkganVzdCBhZGQgYSBtb3JlIHNwZWNpZmljIGNvbXBhdGlibGU6DQo+
Pg0KPj4gY29tcGF0aWJsZSA9ICJmc2wsbHgyMTYwYS1zZXJkZXMxIiwgImZzbCxseW54LTI4ZyI7
DQo+Pg0KPj4gVGhlbiB5b3UgbWFpbnRhaW4gc29tZSBjb21wYXRpYmlsaXR5Lg0KPj4NCj4+IFJv
Yg0KPiBXaXRoIHRoZSBwYXRjaGVzIHRoYXQgaGF2ZSBiZWVuIHByZXNlbnRlZCB0byB5b3UgdGh1
cyBmYXIgLS0geWVzLCB0aGlzDQo+IGlzIHRoZSBjb3JyZWN0IGNvbmNsdXNpb24sIHRoZXJlIGlz
IG5vdCBtdWNoIG9mIGEgZGlmZmVyZW5jZS4gQnV0IHRoaXMNCj4gaXMgbm90IGFsbC4NCj4NCj4g
SWYgSSB3YW50IGluIHRoZSBmdXR1cmUgdG8gYXBwbHkgdGhlIHByb3BlcnRpZXMgZnJvbQ0KPiBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L3RyYW5zbWl0LWFtcGxpdHVkZS55
YW1sIHRvIGp1c3QNCj4gb25lIG9mIHRoZSBsYW5lcywgaG93IHdvdWxkIEkgZG8gdGhhdCB3aXRo
IGp1c3QgMSBwaHkgcHJvdmlkZXI/DQpJIGJlbGlldmUgaXQgaXMgcG9zc2libGUgZm9yIGEgZHJp
dmVyIHRvIGNyZWF0ZSBtdWx0aXBsZSBwaHkgb2JqZWN0cw0KZHVyaW5nIHByb2JlLCBhbmQgZm9y
IHRoZSB4bGF0ZSBmdW5jdGlvbiB0byByZXR1cm4gdGhlIGNvcnJlY3Qgb25lLg0KDQpUaGVuLCB3
aGV0aGVyIHlvdSBmb2xsb3cgYSBwaGFuZGxlIHRvIHRoZSBwYXJlbnQgd2l0aCAxIGFyZ3VtZW50
LA0Kb3IgYcKgIHBoYW5kbGUgdG8gdGhlIHBoeSBjaGlsZCB3aXRoIDAgYXJndW1lbnRzIHByb3Zp
ZGVzIHNhbWUgcmVzdWx0cy4NCg0KVGhlIGRyaXZlciBhbHJlYWR5IGNyZWF0ZXMgYSBwaHkgb2Jq
ZWN0IGZvciBlYWNoIGxhbmUgd2l0aDoNCg0KcGh5ID0gZGV2bV9waHlfY3JlYXRlKCZwZGV2LT5k
ZXYsIE5VTEwsICZseW54XzI4Z19vcHMpOw0KDQpPbmNlIHRoZSBzZWNvbmQgYXJndW1lbnQgaXMg
Y2hhbmdlZCB0byBhIHZhbGlkIGxhbmUgbm9kZSwNCml0J3MgcHJvcGVydGllcyB3aWxsIGJlIGFj
Y2Vzc2libGUuDQoNCkkgcHJvdG90eXBlZCB0aGlzIGEgd2hpbGUgYWdvOg0KaHR0cHM6Ly9naXRo
dWIuY29tL1NvbGlkUnVuL2x4MjE2MGFfYnVpbGQvYmxvYi9kZXZlbG9wLWxzLTUuMTUuNzEtMi4y
LjAvcGF0Y2hlcy9saW51eC8wMDMwLXBoeS1seW54LTI4Zy1hZGQtc3VwcG9ydC1mb3ItZGV2aWNl
LXRyZWUtcGVyLWxhbmUtcGgucGF0Y2gNCg0KDQo+IEl0J3Mgbm90DQo+IHNvIGNsZWFyLiBDb21w
YXJlZCB0byA4IHBoeSBwcm92aWRlcnMsIGVhY2ggd2l0aCBpdHMgT0Ygbm9kZSA9PiBtdWNoDQo+
IGVhc2llciB0byBzdHJ1Y3R1cmUgYW5kIHRvIHVuZGVyc3RhbmQuDQo+DQo+IFRoaXMgaXMgZXNz
ZW50aWFsbHkgd2hhdCB0aGUgZGlzY3Vzc2lvbiB3aXRoIEpvc3VhIGZyb20gdjEgYm9pbHMgZG93
biB0by4NCg==

