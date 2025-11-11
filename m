Return-Path: <linux-kernel+bounces-894508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55522C4B324
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F2544E3873
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB906347FD1;
	Tue, 11 Nov 2025 02:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="JDgDrKKo"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978D02BCF43;
	Tue, 11 Nov 2025 02:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762827758; cv=fail; b=jU5a6n5veNgrTZGpoxfNNog3skCcdmIPIe8xlDW7r6/RACZOTENoXKlqb3QfAPCT+3oUVFtlwg1zBToGosmSr1eyNMTPAFYMmLwqW5sIKoFZencCev5CB8r3mxCSJsBApNyijUVL3xzIF7QN4chnO2sjXUnhsv9xbFBkL2rQE74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762827758; c=relaxed/simple;
	bh=pQ4Gq+QVskSNHSRh1VTwFUf1sTh7De/H9ju6c5Jkx/A=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IjLptXoieLa0QtiDoExRbX7DUBl0VCqAsPAt1wNjPqG4KyI/ReMYRVGS/hBgzA8A+nYQPI8mkrcoM4JkNF9+2goVYUVb4EUJNbG4tKW4RnkSVapXo9GLRKvbV/GGuhuDKbfWlIg47Jx8ZIb0BnnnN+ZfW2bCGrpXE+dlk5tirAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=JDgDrKKo; arc=fail smtp.client-ip=52.101.61.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuON3j8X9aB4gazDcR4K2WLbtqyT4wg+WaCSrI9pELVQs96R+5Qnuerhx0mIDuF5nkYLdpwBGiIBm9YITWMXzUwLC+hEZMHXSDpO/vUVdHnKfsdvmdkC2JSAnmE8n6pyacddSLntPhhtph+Azl5FMw6Kk30hupyf+l8zidWNpHJWGaKYzQQgiqX81U8NmvrLaOJA8uXz4wZKvNKfmde2Jl95Qa8At9mqqhOsO1De+Zigdvjnn1z5lKBeSu/UZPjZzlYwt5gfPyIWVnbkpmrSSYEhhnjWsIJDN5DDhj36adzx7SFu2l61T1W+9/WZJfWdLUv+Aw2RFH1XKBjtGnzd3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jcXPjAZCnaMkgaAqvql7ZqcrREZh/DrC4wYpb1Eyzs=;
 b=uk0AEdiiUP/W/kZedigqte1w2su92HOcqKLKuDMkek9Shxj7F7Ay2NP4PIbeWYnZ4RtyDzKD41R4aeOSsbdO5aSKdRaMROc7UnpwkJlxXBH42v+OX0f62KYnZxQnKqWaEC65zuapWKxWS7m3A5qx2URIUYU6hU3KAbbiS3XPlmAB76VWTo42kOd8oJEAPGZ6z3brePozpQKFpkO/Kl0OfPbYQxmzV4zKWQQO8RCcdU+GG98OTUH8avZ7xoYlT6grF8NQ9hg4mj57Ct+ZwztnE816t8AZKF+66tsd/4pnDcwcCYGt9gzknP51Ari4sG4TQmZHA+gwMaAmP0O0XDrreQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jcXPjAZCnaMkgaAqvql7ZqcrREZh/DrC4wYpb1Eyzs=;
 b=JDgDrKKoLJyElUQzDsI82H8pccrHUnjQ355gY5OFH8S9YoWx8mnb+HdMZrMpJSBxO1qCbGY1KXG+hjKL7jN7j7BDdJNqZzK3nTehMRu3cvJW4rtb7bkUduirZaPfQHAI69raJwL50GCWBIVHJGhQDb2gYuQ4sX3hnPo+FxFqyv+TW4I77WuA3DEuVjDx478HzqrStJiHzjl2alzkO/vEdr/KeZ2oOfcjjPwOok8XgGNNjFMGFQz8uFMWXmHG3R2TEMb36yKwnDE23ATASHRu2Lgp3RetPyaql95iiJZSPgZwI4JasRxAm2xvwYdmeq8yS5bP+E7AsvfB4XwjZxmEkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by SA1PR03MB6529.namprd03.prod.outlook.com (2603:10b6:806:1c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 02:22:33 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 02:22:33 +0000
Message-ID: <7d27e580-9e1e-4d0a-998a-3d8eed2c72a7@altera.com>
Date: Tue, 11 Nov 2025 10:22:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: socfpga: add Agilex3 board
To: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1762756191.git.niravkumarlaxmidas.rabara@altera.com>
 <aa19e005a2aa2aab63c8fe8cbaee7f59c416690f.1762756191.git.niravkumarlaxmidas.rabara@altera.com>
 <b3ef901f-9efc-4847-afd7-70e9a5c35d80@kernel.org>
Content-Language: en-US
From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
In-Reply-To: <b3ef901f-9efc-4847-afd7-70e9a5c35d80@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0177.apcprd04.prod.outlook.com
 (2603:1096:4:14::15) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|SA1PR03MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a391e9-971d-4937-165a-08de20c92ba9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWIwSE8xNEJCbjJ3aCtkck1qbm1KbUF1OXZEMEptbDVnb1hjMHlRYVpSbjlF?=
 =?utf-8?B?dFg0K2Y2OVExKzIvd1hUSTRVZmZRUlRReVZVZ0ZtbFZEVnptclV6ZC9aVUlE?=
 =?utf-8?B?QWtLT2kzMlEyS2lVcXQ4TnlxN096ZzZjOTRPOGtBTTNvZTkveVdtTnNzdHA2?=
 =?utf-8?B?TlhoM001dUtvODNKSzgxcmdicHFETXYwRGdLWTVBTjVEM0JGTHlmWWNoWHFp?=
 =?utf-8?B?djRKRDhlemxOK1prNy8yYWVhZDFrZ1R0dVpPSTduZ09NRmowK3MycmROaVZu?=
 =?utf-8?B?clNJYW0xNUFZTEF5RkdtVnlPOGhFVVI5dlVKRUFzMnpnRDNNNVEzc1dFOWN0?=
 =?utf-8?B?R3BmQ2hhRzArTXJ2aXdpM2VUb3hPUitYVUxlMENuWlJJcENTR0d2cGI3R0Rv?=
 =?utf-8?B?NjNtVEhtTWQyeVExWTRER0Z5WXNWZEd0SFM1VFZjYUdxR2l5enhNcXd3QlB3?=
 =?utf-8?B?Z0xVajkwZXJIeis5eEFLb3ZaWDVGWGZBc3ppckZjSGlsamhiLy8wUjlhZXo2?=
 =?utf-8?B?T25QdDJzdzNraFFNNW1GdTYweXErZkRWVVFzL2Z5eTlITVVkdTY2Z0Foc3RM?=
 =?utf-8?B?cm5SSkhnQ2ExaGRvZGUvK3VRZUwzYWVGQndoQndya25KL09qc0VaOW5OS240?=
 =?utf-8?B?N084d00zeTJWdkVYMEEzYUF3bnVUV1dXdFVVaGY2RlArdWdNYjNWa1kzc1hj?=
 =?utf-8?B?d3NVVUcwclEydWtzd3FudHBXREZnRlRqbEk5RS9ldGVQeHBHN3ZNYXArRS9U?=
 =?utf-8?B?L2h5Y0djTkRhSG5VZnlja2g2TXJUc21ZUk1BcDAzMmdoWC8rUnhhL05LRWUw?=
 =?utf-8?B?UlV1eTl0d3ZuVkNzOUJoZ2NOWGxkWUxDejRldTlmMjFiZ3J4V3dBUTZxek1U?=
 =?utf-8?B?V0lITGdHUFJTbGYyS3ZxUVEzc2J2TVJEN2Y2L3FaUXRDMUxUVndHREdLS3Fj?=
 =?utf-8?B?ZStnR0I1NXRYd2N3NldmZ2VUSmVrSHpDbmU2cHIrV0JDc2dpQ3Buc1pPbWtZ?=
 =?utf-8?B?ZG01RlF1SjhleGhTWURSQnNHRmJVMEM3aXJpQU1VeWp6NENSSlpUb2phRm1u?=
 =?utf-8?B?VnZXS3dhUkJ1SnIwNCtpWHRBMk9aSStJME9Xbk40Z0ZsYTFROFZHMU1yQ1ZE?=
 =?utf-8?B?aHliODU0OC9HOVBBaHRRcTl3ZDh5UVJGR0FnQm9tRzQwaWRvTTRxZkoyaTNi?=
 =?utf-8?B?cGpNWVlaR3cxQ0VpZXFtYlQxRjAvcmlrekg0UXBmcHNXWjQ0WUNTVkVESU8v?=
 =?utf-8?B?b2VmWGxSMzhCWTBNVm9nZXlDTXNUdXc5Y2FjWDJTVFYvNEdDSzgwUnpnMmhG?=
 =?utf-8?B?eWpxNWhVTkF4c3JzODhZaXRnTHJGOHJhMnNnNzFIVDBlWWsyNEtsT1d1djdC?=
 =?utf-8?B?Ny93bFhoTzluQkt1RDQ5aDZVZ0lsaVBiTXZ6Y004UXN6RVpmTkl0OEIwdXhl?=
 =?utf-8?B?VzRXNEYrVmoxdTh6a1ZHVGprK0Q5WDAwdEF5TTZ6TEhTNVJ3SXZ5UFhvU2xS?=
 =?utf-8?B?MXpvNElGQVBRWi84a01sVS9Jb3NFRE9kbGVVU3E4cytKS2tGNUF1MVlNOGpv?=
 =?utf-8?B?UjRIaUNZSEZuWUhEVm91b0JnM1FtZGhhQ25qWTZ4WmhoQUFWQVU1a3lOUENQ?=
 =?utf-8?B?SEtZL1V0d05kYnZGVmtTWWczajFaUUdRTXp2YkNDeDY5ZmFWN3ZWcjdCeFk5?=
 =?utf-8?B?VEJpRk9zSmJEbGVWUjhQbllOZWUyNTNiMlZuK0lMRzlUcTBRWW1EcWpNcFR2?=
 =?utf-8?B?d0d5Z3Z6SWZuOUphU3UwWG1hbUViOExOQjUvWCtXM3FQOTFMRnhaOUo5cEl3?=
 =?utf-8?B?TU9TZkdhUWFxamUvbE03N28wT0ZiVUNjVmNoK2pTaXBsakt1UU56aWRabzZN?=
 =?utf-8?B?eEcvbVBiUCswVUdJUTVVa1FSRmgwVUxmMW1sRVgrVHdYbTJ0QVFXNHRoVXdW?=
 =?utf-8?Q?fF4FPga4OhSDsVCsY7l+49T4a1VVDkuB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TW9pMWV4cloreEl2MUdZMTV6cU5CTk1lLzR6NVZWd3lnMkdseW03Z2Zsdks5?=
 =?utf-8?B?bTFBTkh5bkZPQ2NFa2lTQjUvSklhU1JscEJreXNDNERvekdMTW8rZTFBNHBm?=
 =?utf-8?B?SkxSOEZKaHArL0t2eENHTllkTm1RNFdRUXppN0R4Z1MybXYzemRjRDl6NHgv?=
 =?utf-8?B?ZnI0VmhneHhGVmVTN0hhRnI3ZUVmZVc3cFQwcWRmMXdyOU9CcVJRQlpESExH?=
 =?utf-8?B?L3Y2SDlFREZMN2hjNHpvMzJsM3hVM052ZjJtdlRuMmNSVDkrVU5yeXhoSEpJ?=
 =?utf-8?B?b255c0M1NEhFajlwUUFCc2Z1NjY4bkMzcTlrdE9jcjlrSGtyU2tlQXZIcEdZ?=
 =?utf-8?B?WmJOZTJWZlZyU1dVQ2c5LytVdVJOclg4Snd3V0lJYlY1SUFxaG1VRlBZanhr?=
 =?utf-8?B?eERmRnFzZlRvaUJEZ3l6cGN5eXVkdUZ3MVcxSUhQRU5uOTQrUFFOZG1Senl5?=
 =?utf-8?B?VjBNTlBTbk9IUDdZR3lpZXRnbzJZM0tiS0huR2tFUUFyUmxYQ0pEeTkzc1VB?=
 =?utf-8?B?MUM5NGRrNFhtSjF1ais1OGhCeTlCUG5qMHFKTTgyanZpNEp3YVQzYmtSWUQ0?=
 =?utf-8?B?Nk5PZDMrZGNOcHdvaHdqS3V6NGFWQysrUk1HaDgyR0xxWW5EM1ViVVJHZXY4?=
 =?utf-8?B?NkM0dHBGZytqR216cG4zaTh3RFJoMVAxRjVqNTMrZHgvZWVTZ2s1bStFMkhB?=
 =?utf-8?B?SnN1YVBVZUxFMHpxdUdLYkhRdlZxRXF4OUMvc1RGVmtFNFdUVGdKVVlsWW9W?=
 =?utf-8?B?SGRuclVoRm0zQlVrMUo3N3cxRkl0bTFHZ1c0Z0pMc0FQZ2xGdXM2akdDMHhB?=
 =?utf-8?B?ajVBc1pPYmJ1Uk9ESEtpTks0U2hyZUtSQUhoQ0liUENOTFBqZFRTNlZwN1dT?=
 =?utf-8?B?UzQ5cDY0OEZlR09hcnA2TVByemdGMFQzV3UvL25pVmQwRWtXZ3J3T25obDhh?=
 =?utf-8?B?VmJNQzVwOTZQYVRnNkNBOXNtdGwxcC9WU3FBYVpZMGhFTklpYVltNS9RdXpP?=
 =?utf-8?B?M0xzc3ZqRHRkWlpBelVKNDRmYU5jWkxOSWdwdHNxMEUvTFFYdVBWQXEzKzRP?=
 =?utf-8?B?T2tYY0RwR1RXS05JRGVZdFF3V0h5Y0dKQnNLNTNNQTgrZUVUN1Z1ZUhaTlBV?=
 =?utf-8?B?MkZQN0Mrc29wNG4xT0NYamFYL1RUYjZmRW1HZURqVDl5VUxvUVBLZHE3eGFU?=
 =?utf-8?B?czNsZGowNWFGZGo0NS8yQlhLTGtMaHlFTzB0RnlMaEY1U1pjNzNaeW4zTW9H?=
 =?utf-8?B?aG1FUDM1TWlPNmNYQ2YzdXA2S1lVK2krMU52MHAxZ00yOVlkRE5KR2pMbGxD?=
 =?utf-8?B?djNLVS9KNWVSanRCVGMxWFdjTTVoVVM2ZlNXZ05hNDZzMzZrL2hBZXcyN2pr?=
 =?utf-8?B?ZmQ3YXQrZzFwcXJmTWRveDNBeTJyU1lpSHpVL21CbXhpdmlZRUVYV3hEcGl2?=
 =?utf-8?B?cTlsTmpOQXRBb3Z6K3pRbEdubmYyZDN6ejlkYUlCRWJHRGNCTXN2NHpiaVNv?=
 =?utf-8?B?WkNFaGtUNzF1YXNaNzM0QVlUd3RBUUxQd25ybm5RYnlURTdLRFFGTnc5bllT?=
 =?utf-8?B?MGJaRm5CZVFENUc2Zy85cHkrcTNDSGp2QmNWSFVHeDJHTmhuazF3UDRiTXNV?=
 =?utf-8?B?UHJlOU5tM0lZK2VZc1B1cEZML3cwanNhcnQyanlaeW50S3I1K0w4ZDBRdDJo?=
 =?utf-8?B?MEdTNjVob0cxVkVqcndMSGs4YjJoVzR2Qm5SVmJadzJsektRZTZnLzV4TjY4?=
 =?utf-8?B?VDAvdWJDVHZCdDVIMko4aU5Ud0JmQkx2L3R6SWV3ZXZIRm1HaWx0a0pZZDA1?=
 =?utf-8?B?TnlXaElScm43bHVCYlFPRmlsNmU4S3ZSdE5UOVJUb3BnT0IwRXBWMTgxdnlu?=
 =?utf-8?B?OUtzbURNZWJLWHV5TlZTelFIL0lBWDRqZDMvTXdueHNjRG4yOGdFYUVZa0I0?=
 =?utf-8?B?TC9NWUhsYlFlYnlTL2kxcE9YaVQ2SDdRemh3THJuZVhBdjRpZWJCZ2l2Kzha?=
 =?utf-8?B?VUgwalBtVzJldUJTRUpIdFQzV05LZmphR29RRUNsOU55elhHc1A5cFh6Yjdj?=
 =?utf-8?B?djZsc0RTZDd3cVVoOEJOaFk0ZW1JNWN6aldiRmhpZHE5bHE0WlNiYnlLM1pp?=
 =?utf-8?B?OVFsYWRBRW9POURUUEFkeUFtZHZ6TVBFajNpSmZJTmZEbFNuQi9VcWZEbmN1?=
 =?utf-8?Q?EzJaMQSbYc36SlWH4fLSC8c=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a391e9-971d-4937-165a-08de20c92ba9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 02:22:33.5391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XgGGI6F5ApxAygBYS7MB1LGLOypORMSQcivl3WG5Lh/uvL5EdeVDenTWK+O88pXrtp28q6Hg7RKZu0wnjvaszRXMtjgRoSvi446KNSTI3/F3jaCqI5dCN709ZM6Vl+2I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6529



On 10/11/2025 8:37 pm, Dinh Nguyen wrote:
> 
> 
> On 11/10/25 00:47, niravkumarlaxmidas.rabara@altera.com wrote:
>> From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
>>
>> Agilex3 SoCFPGA development kit is a small form factor board similar to
>> Agilex5 013b board.
>> Agilex3 SoCFPGA is derived from Agilex5 SoCFPGA, with the main difference
>> of CPU cores — Agilex3 has 2 cores compared to 4 in Agilex5.
>>
>> Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
>> ---
>> Note:
>> This patch depends on the series: "Add iommu supports"
>> https://lore.kernel.org/all/ 
>> cover.1760486497.git.khairul.anuar.romli@altera.com/
>>
>> Patch series "Add iommu supports" is applied to socfpga maintainer's tree
>> https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/ 
>> log/?h=socfpga_dts_for_v6.19
>>
>>   arch/arm64/boot/dts/intel/Makefile            |   1 +
>>   .../boot/dts/intel/socfpga_agilex3_socdk.dts  | 130 ++++++++++++++++++
>>   2 files changed, 131 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts
>>
>> diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/ 
>> intel/Makefile
>> index 391d5cbe50b3..a117268267ee 100644
>> --- a/arch/arm64/boot/dts/intel/Makefile
>> +++ b/arch/arm64/boot/dts/intel/Makefile
>> @@ -2,6 +2,7 @@
>>   dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
>>                   socfpga_agilex_socdk.dtb \
>>                   socfpga_agilex_socdk_nand.dtb \
>> +                socfpga_agilex3_socdk.dtb \
>>                   socfpga_agilex5_socdk.dtb \
>>                   socfpga_agilex5_socdk_013b.dtb \
>>                   socfpga_agilex5_socdk_nand.dtb \
>> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts b/ 
>> arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts
>> new file mode 100644
>> index 000000000000..3280bdd49faa
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts
>> @@ -0,0 +1,130 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2025, Altera Corporation
>> + */
>> +#include "socfpga_agilex5.dtsi"
>> +
>> +/ {
>> +    model = "SoCFPGA Agilex3 SoCDK";
>> +    compatible = "intel,socfpga-agilex3-socdk", "intel,socfpga-agilex5";
>> +
>> +    aliases {
>> +        serial0 = &uart0;
>> +        ethernet2 = &gmac2;
>> +    };
>> +
>> +    chosen {
>> +        stdout-path = "serial0:115200n8";
>> +    };
>> +
>> +    leds {
>> +        compatible = "gpio-leds";
>> +
>> +        led0 {
>> +            label = "hps_led0";
>> +            gpios = <&porta 1 GPIO_ACTIVE_HIGH>;
>> +        };
>> +
>> +        led1 {
>> +            label = "hps_led1";
>> +            gpios = <&porta 12 GPIO_ACTIVE_HIGH>;
>> +        };
>> +
>> +    };
> 
> You need the :
> 
>   cpus {
>          /delete-node/ cpu@2;
>          /delete-node/ cpu@3;
>      };
> 
> 
> Dinh

I tried this way Dinh, but it doesn't work in dts, compile gives error.
  /delete-node/ cpu@2;
  /delete-node/ cpu@3;
works correctly.

Anyway I will send v2 patch with a socfpga_agilex3.dtsi for Agilex3 
silicon which include "socfpga_agilex5.dtsi" and delete the cpu2 and 
cpu3 in dtsi file instead of dts.

Thanks,
Nirav



