Return-Path: <linux-kernel+bounces-886062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65226C34A0F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A11C64F72D4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D63B2EBB83;
	Wed,  5 Nov 2025 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="lJf+wT5s"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19402E9EBE;
	Wed,  5 Nov 2025 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332922; cv=fail; b=mqEuY3YXnWuhvynvmFp09uLpKWmqG0mxs5WbrKMSdHYcaZPPfgOF0AhHe7gHwWylSX8BLb2D/IqmvOzjfoM8yXgngjMhsXqg+TA3JT/INZR4BvPVUaJ/6Z/tSIxLDq10wYFAlPabHO4s5LTeCgLMiSsuXl4jIpRDtQrWrkCIbzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332922; c=relaxed/simple;
	bh=NQOJ4AmdJuPR7Qy5ARP/uF6j7F465kZY+IYVv68QtO4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hztohRGX6ZzXV1BTSDi+J6z8UxhXPyjxAXKWgjHSSOB3YGc/CWm0fE0qlreBA5/k/LiGajCf5XWmQcRuNILzudINKoVo75DLVn1Z6d64sIJe479gTt3IjNHIMqVqC3lYEmf79kNx5sWsbct2CawzqM+boVN7XUIJn4aIyvGT8DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=lJf+wT5s; arc=fail smtp.client-ip=52.101.85.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgbHZw//35duBYIZh+S8clld5/ocIuxWXtybgawunHenU+mnGNEB8UO9aS2kEJI7oGL1OGSsPN6Inxc/zjnZuMREdVb27kppyX0E1yMIGFNzJKe5CO7m49Z+jiwYfwBZqLOxgRWTZ/lpT9SerrtytYOyaW35o9a2Rc9CeIH9M+BoCXRV//Iewn++m5xAkSSxgiwSvenhXWIWOJB8inrnDiuUJBz2qy3dI9pX3JhoxN88vt3j2RaKCe8o7rPR0LYh8lPOFkEfV+Exzqe57CM02QKBteCPuphkbbbMRHwjG7cfOSX5wKSCJy+UM2qTfXOOxor1qr5U7tzUmLwnJudCpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQOJ4AmdJuPR7Qy5ARP/uF6j7F465kZY+IYVv68QtO4=;
 b=bLWqJc8DBwOHRxehO3lrzoG9tV562H365v3uB0nwAz2NBpThAcfdfyrt8CgrbiaYt51ex0JXz69veiJxr+mr0dAJT5vOfWJfl18jwGZv3l0LevWOfPC8uWtxYH+CT36ipik4JrTrDnmcxksiuZ7AZlhPLuZ1+a/KAIQJcs09oipdFwteZ2T4oJNiJrkestlufm1Ld7MjpqojC91/2+Fb17OLgiZiSttf/jkruMZ/IAnmWt4sFkTT4Szacnnj0VIMK9RDyk8rZ6HmLjH4KjX+ncob44ljP62XcN8LxQFwcAqOjtVyKXI7xRjCb3I/IP16hk89XoRZSt+kSCFOPYnbLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQOJ4AmdJuPR7Qy5ARP/uF6j7F465kZY+IYVv68QtO4=;
 b=lJf+wT5sBx27KJiDSqGGNkLEluNZxSO6xO5SlllimolIN3c2DDVGKdjAQXhSLqVGkr11yBfFsWcak46YyfFncLKJaJ6av2EN2ROKAJjbabjYvt9v5SrNB6iDSYdrMRxiutC92g9AyvDaYVJGF7orXjuie20SK4A81vcHaSsZzQocyu3pX5bw8A7eD6wVlafhN4ZT2Mb5seseW4w2eYCgFwj29ugUWc2HKEUC0hnIwoHxs+iC9q8WNkBVuUuA+zmW6xpWsaVYTF2p3cihJ1C8AzuJHNAk7lQ8Cb4oflplcZb/RcvZM1zNiHzDSEpCbvdDq9kcEENQhEAChMoV+mV2vQ==
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by BN9PR03MB6169.namprd03.prod.outlook.com (2603:10b6:408:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Wed, 5 Nov
 2025 08:55:18 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Wed, 5 Nov 2025
 08:55:18 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"Rao, Mahesh" <mahesh.rao@altera.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "Ng, Adrian Ho Yin"
	<adrian.ho.yin.ng@altera.com>, "Rabara, Niravkumar Laxmidas"
	<nirav.rabara@altera.com>
Subject: Re: [PATCH v5 2/2] arm64: dts: intel: Add Agilex5 SVC node with
 memory region
Thread-Topic: [PATCH v5 2/2] arm64: dts: intel: Add Agilex5 SVC node with
 memory region
Thread-Index: AQHcTfvXIvuRd+4ImkSNc9IC+kq7iLTjv6SAgAAINQA=
Date: Wed, 5 Nov 2025 08:55:18 +0000
Message-ID: <9e24ca8b-6c05-43ba-a7ce-98886ef6db31@altera.com>
References: <cover.1762308672.git.khairul.anuar.romli@altera.com>
 <bfd2d5999306c019dab8a157f122bf842a43fc6b.1762308672.git.khairul.anuar.romli@altera.com>
 <20251105-flying-asp-of-poetry-cd9d2e@kuoka>
In-Reply-To: <20251105-flying-asp-of-poetry-cd9d2e@kuoka>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB4927:EE_|BN9PR03MB6169:EE_
x-ms-office365-filtering-correlation-id: 660a158e-a855-461a-2e09-08de1c490b9a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VXM0dXhJN2hBaXZkQWZsVThBWHU2ZWx0WkJXZG40YnN2OUFiV2U5WmVmMG5p?=
 =?utf-8?B?bEMwV0xsT05INjJCeExWNXYwb3p0dEFHYjB6MDU5ODdMOERDMmNjSElXa1k0?=
 =?utf-8?B?NFA3eUZHd0ZwWHNXRVdaZFo4aGgvOHNrRzNDWDlsN081Z0Q1bEtqR2RGcndD?=
 =?utf-8?B?ZWNFTEp6Z3hGUkFkS1h3V1F3UlFMOGFyMDVOUEJhUE5SdnN2MTJUSEZ6d1FF?=
 =?utf-8?B?bC9Hejlqb2lxNHRxTUJCSktBZnhTbHE1NlFjbVE0eTN2N00wSE8vYkltdldB?=
 =?utf-8?B?Y0VRbklGSGs0VGozbG1EVGtPSHlBd0thbHU1RlhUaXgxRWgvWlRNUFZsZEpw?=
 =?utf-8?B?ZGQ0MzI1T1VUU3lCK2J4Q2NBWWVkRG5uQ1E0REFxUFRzV1BWOU1VMVF2K1RF?=
 =?utf-8?B?WnVHdXh4NlFBTSsrZWJMcEZhZEdyZGtYTGlDT2M4NnE3R3NjZGRVWlZHNXBJ?=
 =?utf-8?B?Q0Z3clNCSW8zelNzYmkzV2d2NVgxZllycEVTS3NNU2YvdjNWNTk0c2k1bFVF?=
 =?utf-8?B?a3hMd1RIVlhLd2tZZzdrQXNxczA1Y0J6TnNRbUoxVXQyQlZkVFgzL21ENG81?=
 =?utf-8?B?OHZ5NCtzUUVWeDV3UUZtSHd2dHFmWmhodFA1K2Nha2tsU00wUmpESnhoWm9W?=
 =?utf-8?B?ZDc0YWt3WEpKNmdSdFVCQzRCZks5VkQydGFaRElxOWdaZXVNZGRmRUtPOUpy?=
 =?utf-8?B?blZ2QVhrRG0zeUM4ZUlhMElMS0ovc0dIdUFaSnpUN09tM2dMUGxudjMweG92?=
 =?utf-8?B?MkYwenhkUWEwc3ZUNGxPUWtkbGJQNTNYRmNVbzVtM3R1S0xrYXV0Wkl4Y0U2?=
 =?utf-8?B?Q0R2K3VWaURDdHd2OTRNazFDT2R5ZUVmQzhscVk3WnpiWmdKbXRGdzUyUWVy?=
 =?utf-8?B?Wm9YeHZreGs0ZjMvZUU4TDNhNXgrZkNIMDc1dmhXTCtxczVpMFVxeUEzbjRR?=
 =?utf-8?B?R1B0UlowcmdTbFZFZjRiR2t5OEIzMEtBcGVPMkVsQzVnV1Y3NFVPWGZ0b0lT?=
 =?utf-8?B?WE1rci9INEFQS3NuVExUcklxeThZQTZwWVFqZWdZYzNjclM1U0hKUkJIekhw?=
 =?utf-8?B?VkFEaU1pRU9kSjQvb05WRFZ3RUxEYm0yVVRRcS82UTR3Q0xRWUZvZWgzQ3ls?=
 =?utf-8?B?NGhHMHJhM0lLRWhyd0ZndjAvVnVhR0wxR1NnOGlneHZjcWZma0JYaWZMTGY0?=
 =?utf-8?B?ZVpEb1ljWDU2ekpoMGRYV1VXUEFtVnQ5WXlxc1k0ajFyTXo0Mm4yQmUxRlBx?=
 =?utf-8?B?Z2YzSmZPQ2s3R3dLb2JkYVdpLzRTd2Z2NUUzZFhUUFJiY2NDL25FNWo4K3VN?=
 =?utf-8?B?WDBoZm1Gc0JwbFNNN0VkWk5WZENDQit2cHIxS1ZwZXVPRkVGUU1hTE5vRll0?=
 =?utf-8?B?RzNMd1FzeExMdUg5ay9ZTGN1K243VFpyQjUxejd5NjNLRm9RZk9VQmNMWCtY?=
 =?utf-8?B?VWltYTBQV2tjbU9zK0xKZmw4M3ZEVjVOaGJsNjNJMjBGRlNTQ0FhWWtmaUta?=
 =?utf-8?B?OFBBWFFVT2ZuNUFDNEljOXZNWFhwNkZWOVNOVkxzK1p5UzhLY0ZGRENmWXYv?=
 =?utf-8?B?WFIvbzVNWnRaTXhQcThFTmp6N3c0RVpjQXUzcmZZelR3Q0dqTWNTU0hwM1c2?=
 =?utf-8?B?OU5VVFZGUFdaN094bTZjcmxyUWhKL0lUU0huNFFtU3Q2dDJlR2FEUzhkazlv?=
 =?utf-8?B?d0tSQjB5cVViZTE2Z2ZISEVqV0xmTlBYK1pEcWUvZGhzUDNHUkI0Q0NvNktn?=
 =?utf-8?B?L2hHU3piM1JKVXZlSDVmb0ZjbTdGNElaTU1keC9Qb0Njci93Z29meFVBd01l?=
 =?utf-8?B?RmNCd2szTnlCNlFMQUxzT2lRSXJsS3VjQ3Z0OUMzODk3RFY5dk1MRmxUSWJQ?=
 =?utf-8?B?bzRKVmZGRmNjaFAzN3IyWE9BZGVqWnV2VFZKMjdrVFF0eG1xNGQxUjJOYTVK?=
 =?utf-8?B?OWcrREt4VTZXOWljT3U3UDR6azdCYmZUZm1QTWlPZ1A0a29yTWQ0STdCMFJo?=
 =?utf-8?B?aXpScFl6cFlobnFiWS95Zk56SHpkdUNQYXZlUDdZOXUxazdPRWdoeDhicThp?=
 =?utf-8?Q?xLslZd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWp4ZnlWcXZkKzNrdE1RMUxyOG12WFJsUlpRZUg1VUJjckFTZGQ5OWM4NUdx?=
 =?utf-8?B?N3Y2REFEclJCV0xaZFZzQkFDRVJmRHNOWjdlMlFmYmxLTFNpcUU4QjVSMkZE?=
 =?utf-8?B?aVZKdWhRVjBwTkVZOWlQaUhXM1A1RGhNZ3FqV0RIWTVxc0J4M0xiS2l3SlRm?=
 =?utf-8?B?bnhwK0xwcVlNT3g4cHl2eEs2NlMzcWpZMThwKzBiZmIyTHZvVzZyam9Cem5p?=
 =?utf-8?B?WTFjNzFuRGt5bEk5S1ViZGs2ZytiNGp5UjhwYTZweDJPeDhpUWR5eVdNT3Ar?=
 =?utf-8?B?Rmgwa1VGWkdBelRXWHZFSlZOMk1TblNBNFRQRGI2ZlovcEErS1BjSjNocU1C?=
 =?utf-8?B?c1czZlJGVVc0R1ZoVlZ4QjZVNVJUVHZwVmxVUkVWbFRPdS8zYjZpYkJGMnhD?=
 =?utf-8?B?UDBOaDZxV2lVd1hoNWFQSndveGVsRzlad05sbU1BYjMwU3ZndjRzUWtUNStt?=
 =?utf-8?B?SEtrM0wvTnBUOGc4WHE5SUNWU29JbUw4YjlNaXVhSEorNnkzRVhSTll3MjNB?=
 =?utf-8?B?R3dYOW1ndmxKSG04TXJXeFNjYjQwUVE0UWl2SXZhSXNDSWx5eWNaZm45Vi9Y?=
 =?utf-8?B?MGs3RU55U3JwMkxwVkR4cUZKY0lIRGZzVlVxOUV4OGFlN29Nd0doZDM3TTBF?=
 =?utf-8?B?aWR3VkYzdzV3S1kvd01HK1VIRm5JQjMvVndOUGdiaHY1dHcvamw4Ukk4N2xr?=
 =?utf-8?B?OUZLTlpJTUlEMlVPOXJPa2dnbm83OG9lcFo4VHZkdFRTSHhPa1k2NEZvRDRy?=
 =?utf-8?B?Ukk2ZEpPcW5EMDQ3LzRhRUFkTEtPU0JnQU1tbmdhNU1qNG0yUlkvSnE3ZjV6?=
 =?utf-8?B?R0ZoZjZrcGJKR3NJSllKb0xIdDVWLzdtWERWRmE2dk96YTFYcXI2bEFhM2Jz?=
 =?utf-8?B?WElMNTZWQ0NNRkpJRVhvWCtYMThlOWNDN3p1VGhuV3o2R1YxYm5BeXFuQmVy?=
 =?utf-8?B?Uk13K2NrelowYUFtNW1URFdGNXBsMjhzb2RkUXppaGNoamhoRlgza2pwa0c4?=
 =?utf-8?B?VXVtcTZyVXlmM1h2VFNEK2dDMGxLUTJWQWhmZHFiNE9PNmtpV3dqSjg1VDQz?=
 =?utf-8?B?RzN5MlUrNEFNSXRrU2NBTGw3VHhjWU0vTUwzc2lOMTdsaEs3dldMdVNyK3Nz?=
 =?utf-8?B?b2tPS2diQ2tuMEhYU3RyYTVicXhaYklnNXBYcVNkamI5UVlPZ1BMZmRPdGY3?=
 =?utf-8?B?cXJvQ0NjU09CZ1l2aVArL2pxcmJLSG4zd2dHL0pHa0o4ZjhnNU9oYjI5WEhq?=
 =?utf-8?B?a3dpQmdOQ1hzS2ZOeHVxdjBVeEFobWY4UUZUR0dxOXd3UkdqTFQwU3VQV2N1?=
 =?utf-8?B?dnpnT294TkNiWmIwbWNyaGhBT2hVVWZWOEJRZ2dFbG1VV3MvdTJublVCblYr?=
 =?utf-8?B?N1J5ZVRpUm9jV2ZFeTJ0cEpzRDlPbHF1NzdpVWF1UVVqYWFSRFNqNDd4bFhr?=
 =?utf-8?B?RDBtdW1JcFJaQlZSemNIZDdNWHZ6TlljV2R1WXE0UEJML1cyU1dZMkV1MHli?=
 =?utf-8?B?NXJmOTJjQzJVTUF3VklCNjlsWUpaRDJKc2w0enVjRWsxZy9pNWhyamlvNTRu?=
 =?utf-8?B?QWM2TmZab216a1VlcGNMcWlaSTJ1VzhjL2FjZCtGeGJmZFlzQ0dCVWxRNzUx?=
 =?utf-8?B?RVlMOXRMelFDY08xNG1kMDMveFJ6VHhJRjRWVHJTS1c4T0I4TEwyMlFzL3lx?=
 =?utf-8?B?UzNDNldkVkhXeTB1VHloS0dBdERtV0hsRVRRMVlla0dSVFJRVDB2dVl3R0Uy?=
 =?utf-8?B?akN3cTN0RyszSFNyT3AxUElmdmpVV2VVTkFJbno4TUFMSEt5ZS84Znh4T0p5?=
 =?utf-8?B?Vlp5aFE4WnlXWStaSmQzTmdBbVpXZnpLOXJQcDJ5VitGSHUyd0VUOXVGSEpM?=
 =?utf-8?B?K2hLQkY3S0ZYbnhISGZNUSt3TUxmWTBxMzRqQm5aZ0hEeDdSWVZ5eTJpU0FP?=
 =?utf-8?B?Y1hnK3JBc2l6VnA5dGRBUGd3SUlYZ3Q5ejJGc2trWmE2bytVSUNodFdUam5N?=
 =?utf-8?B?QTR4Q0pvcUE1Tk1vamVLQnlIc0Q3aVVJdW5LMlBWS3lOTkNIUmU0L01FS3J3?=
 =?utf-8?B?cXVDSUpWNEtndE9IVGVHdXVhZmJ4MnVpWUw1RU1SSk1JN0J6Mkh3Q2F5b2p2?=
 =?utf-8?B?WlAyYldJOVhyUjF4UE9xT3R5cWlDY2FBcW1zazhFSEZFYlgyUEMyelBySHA3?=
 =?utf-8?Q?MEospUHquRSygMI5rgm1XTA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <707890CA322BBE428873152259106FEE@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660a158e-a855-461a-2e09-08de1c490b9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 08:55:18.5729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b2PwvwOh+FS3dZ1L5J5VfS4HKPrm0YdFoBdoYQNFmMQV5uvhYY+b4zJbPHPrSs9Y9Y4X7poLEpWFEClimlx8cnu6+01qNCMdNt1OunQ0Es0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6169

T24gNS8xMS8yMDI1IDQ6MjUgcG0sIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIFdl
ZCwgTm92IDA1LCAyMDI1IGF0IDEwOjI4OjAyQU0gKzA4MDAsIEtoYWlydWwgQW51YXIgUm9tbGkg
d3JvdGU6DQo+PiBJbnRyb2R1Y2UgdGhlIFN0cmF0aXgxMCBTb0MgU2VydmljZSBMYXllciAoU1ZD
KSBub2RlIGZvciBBZ2lsZXg1IFNvQ3MuIFRoaXMNCj4+IG5vZGUgaW5jbHVkZXMgdGhlIGNvbXBh
dGlibGUgc3RyaW5nICJpbnRlbCxhZ2lsZXg1LXN2YyIgYW5kIHJlZmVyZW5jZXMgYQ0KPj4gcmVz
ZXJ2ZWQgbWVtb3J5IHJlZ2lvbiB1c2VkIGZvciBjb21tdW5pY2F0aW9uIHdpdGggdGhlIFNlY3Vy
ZSBEZXZpY2UNCj4+IE1hbmFnZXIgKFNETSkuDQo+Pg0KPj4gQWdpbGV4NSBpbnRyb2R1Y2VzIGNo
YW5nZXMgaW4gaG93IHJlc2VydmVkIG1lbW9yeSBpcyBtYXBwZWQgYW5kIGFjY2Vzc2VkDQo+PiBj
b21wYXJlZCB0byBwcmV2aW91cyBTb0MgZ2VuZXJhdGlvbnMsIHBhcnRpY3VsYXJseSB3aXRoIHRo
ZSBhZGRpdGlvbiBvZg0KPj4gSU9NTVUgc3VwcG9ydC4gVW5saWtlIGVhcmxpZXIgcGxhdGZvcm1z
LCBBZ2lsZXg1IGVuYWJsZXMgdGhlIHVzZSBvZiB0aGUNCj4+IFRyYW5zbGF0aW9uIEJ1ZmZlciBV
bml0IChUQlUpIGluIG5vbi1zZWN1cmUgbW9kZSwgYWxsb3dpbmcgTGludXggdG8gYWNjZXNzDQo+
PiBpdCB0aHJvdWdoIHRoZSBJT01NVSBmcmFtZXdvcmsuIFRoaXMgY29tbWl0IHVwZGF0ZXMgdGhl
IGRldmljZSB0cmVlDQo+PiBzdHJ1Y3R1cmUgdG8gc3VwcG9ydCBBZ2lsZXg1LXNwZWNpZmljIGhh
bmRsaW5nIG9mIHRoZSBTVkMgaW50ZXJmYWNlLA0KPj4gaW5jbHVkaW5nIHRoZSBuZWNlc3Nhcnkg
YmluZGluZ3MgZm9yIElPTU1VIGludGVncmF0aW9uLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEto
YWlydWwgQW51YXIgUm9tbGkgPGtoYWlydWwuYW51YXIucm9tbGlAYWx0ZXJhLmNvbT4NCj4+IC0t
LQ0KPj4gQ2hhbmdlcyBpbiB2NToNCj4+IAktIE5vIGNoYW5nZS4NCj4+IENoYW5nZXMgaW4gdjQ6
DQo+PiAJLSBFeGNsdWRlIHBlZXJzIHJldmlld2VycyBpbiB0aGUgc2lnbiBvZmYuDQo+PiBDaGFu
Z2VzIGluIHYzOg0KPj4gCS0gaW5jbHVkZSBpb21tdSBwcm9wZXJ0eSBpbiBzdmMgbm9kZS4NCj4+
IAktIFJlcGhyYXNlIGdpdCBjb21taXQgbWVzc2FnZSB0byBkZXNjcmliZSBpb21tdSBwcmVzZW5j
ZQ0KPj4gCSAgaW4gQWdpbGV4NQ0KPj4gQ2hhbmdlcyBpbiB2MjoNCj4+IAktIFJlcGhyYXNlIGNv
bW1pdCBtZXNzYWdlIHRvIGV4Y2x1ZGUgbWVudGlvbmluZyBpb21tdQ0KPj4gLS0tDQo+PiAgIGFy
Y2gvYXJtNjQvYm9vdC9kdHMvaW50ZWwvc29jZnBnYV9hZ2lsZXg1LmR0c2kgfCA5ICsrKysrKysr
Kw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvaW50ZWwvc29jZnBnYV9hZ2lsZXg1LmR0c2kgYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ludGVsL3NvY2ZwZ2FfYWdpbGV4NS5kdHNpDQo+PiBpbmRleCBhMTNj
Y2VlM2M0YzMuLjE1Mjg0MDkyODk3ZSAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvaW50ZWwvc29jZnBnYV9hZ2lsZXg1LmR0c2kNCj4+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvaW50ZWwvc29jZnBnYV9hZ2lsZXg1LmR0c2kNCj4+IEBAIC04NDEsNSArODQxLDE0IEBAIHF1
ZXVlNyB7DQo+PiAgIAkJCQl9Ow0KPj4gICAJCQl9Ow0KPj4gICAJCX07DQo+PiArDQo+PiArCQlm
aXJtd2FyZSB7DQo+IA0KPiBEaWQgeW91IGp1c3QgYWRkIG5vZGUgdG8gdGhlIGVuZCBvZiB0aGUg
ZmlsZT8gTm8uIFBsYWNlIGl0IHNvbWV3aGVyZQ0KPiBhZnRlciBjcHVzLCBzZWUgRFRTIGNvZGlu
ZyBzdHlsZS4NCj4gDQpOb3RlZC4gSSB3aWxsIHBsYWNlIHRoaXMgbm9kZSBhZnRlciBjcHUgdG8g
bWFrZSBpdCBjb25zaXN0ZW50IHdpdGggDQpBZ2lsZXggZHRzLg0KPiBBbm90aGVyIHByb2JsZW0g
dGhhdCB5b3UgaGF2ZSBoZXJlIHdhcm5pbmdzLCB3aGljaCB0b29scyB3b3VsZCB0ZWxsIHlvdS4N
Cj4gUGxlYXNlIHVzZSB0b29scyBpbnN0ZWFkIG9mIGh1bWFucywgc2VlIG1haW50YWluZXIgc29j
IHByb2ZpbGVzIChib3RoKQ0KPiBmb3IgbW9yZSBleHBsYW5hdGlvbi4NCj4NCkkgdXNlIG1ha2Ug
RFRDX0ZMQUdTPS1AIGludGVsL3NvY2ZwZ2FfYWdpbGV4NV9zb2Nkay5kdGIgdG8gY2hlY2sgZm9y
IHRoZSANCndhcm5pbmcgYnV0IG15IHRob3VnaHQgd2FzIHRob3NlIGFyZSBub3QgcmVsYXRlZC4g
Tm93IEkgdGVzdCBhZ2FpbiANCndpdGhvdXQgdGhlIGZpcm13YXJlIHRoZSBjaGFuZ2VzIGFuZCBy
dW4gdGhlIGJ1aWxkIGNvbW1hbmQsIEkgZG8gc2VlIGl0IA0KaXMgY2xlYW4gd2l0aG91dCB0aGUg
Y2hhbmdlcy4NCg0KSSB3aWxsIGZpeCB0aGlzIG9uZSBhbmQgZW5zdXJlIHRoZSBidWlsZCBpcyB3
YXJuaW5nIGZyZWUuDQoNClRoYW5rcy4NCg0KUmVnYXJkcywNCktoYWlydWwNCj4gQmVzdCByZWdh
cmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCg==

