Return-Path: <linux-kernel+bounces-894700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E65C4BA22
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F394F34E7A4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14DA2D0C9C;
	Tue, 11 Nov 2025 06:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="NCXBf/F6"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D99F2882B6;
	Tue, 11 Nov 2025 06:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762842001; cv=fail; b=ijJOHd8y74RKujIqXSVexWZIg0q+HHyrxgyelBUhwJyui3/niJRJi/SNa8y4xV4dqx3G8/GrNAKoQJfoJk/fATW77d58MgJPAzv48HMAhNkMu2xX6m7dBfYOcEyA8M8PVr7ObK579eie7HgBw3/+lDkRC34AglAZKbU99iNVzhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762842001; c=relaxed/simple;
	bh=i8VAhwcfB9HFO9pmQSO1AmzZGTiZWA9PCyEyyZYS4FM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Gc1Ddb3dfI44OiyMXxj1vpbIMPltq+miA7pWEpHElG9CZZy7llN/30ELTP80WXVD4428REPjzAldQmPM8u6EDHw7Gdx9jypKBWC2Gn4mMtBsjzvF0ALW6YK0Ea0K7fyaAC/hPuGdRPnOxr26fcwpPGwBlMAAGUMAL5XBBdNy9GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=NCXBf/F6; arc=fail smtp.client-ip=40.107.208.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vi1YPBfkybqTO2kVWUO5Zg2wPS+nMqe3P8lBszeIK6VSM0XCQ5xtGcIBvPjG5y43E8UAfDllT9Qxn8munojIDFDGACj0eIXqIQMS2C6R6heysIOx9W2vbjG9NLt7yaPvr0okNSrsj6KGxazcxMLGAUlruIilRurj+2ncBroPjZD2R9Jv3nAVT0q86GzbNx+LJ+PEVAPJ+aEngfSxJDe97guXq5bkYvsQcoMx5pNXinkqwMH1Fdq8IsJXU3nuQqHg5lORh1kRm0HTn1I1xZyIo+Xqt5pIaJU1Tr6taYnFvJ4+t+xTIKrudBkXqD7pTaRkzXbkwGtPScfYFMBqWRjSrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7bldBT+MTeV6DOsEhzg+a/fYx+XFUz11SN9DXNv7yQ=;
 b=gzRxyOL/IuNDLapQGr2NnAPUIqLbixkgwZ82HlwvMmEPW11fre5E27jLnBS6xxKmVnWlnT0VMF1QtpVm/Fk/x9QbkvWrqzA9QMZBZWHm+fo/+U49npCF8MmITNHvJQFi9h14TG3UuCkLwWvI6Jc8g62umWg2KVEmNQbYuj+/IlL8Sqkna8svX7cFQy8lf8tX+XJ0JZkju5fA8WS4QIzSKUmWyMC7wMpEtpEiZV2Ct8pm5BtCwQyl0dODH8yZ5S6RpeFd6CyH9DEDzkquJlyl2YW6uZzHjMo3AYPcy52wv7HGrR26H8Hvu5MgXjNrUnbBM+sCLo17LP99ynUZqEF3ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7bldBT+MTeV6DOsEhzg+a/fYx+XFUz11SN9DXNv7yQ=;
 b=NCXBf/F6OYfvqDKC9RPhrQg0OAxybwKlH9lIq5LBQo9+u3+qVUNJFUFT1tkT1Jin9Z/dncsdefNvwrk2ci78m9r+z/93FAva5n9n+EmzZivu+t/45z4htVM5l6hLUPtAuyPzf1cqtvpmFaEbFoM1X+Uu4OBUI+OFz8UVHcVB0FkHs42hYegM3SqGtZzMkkGjozoXNzcEkWXp2pMDCoAfY459s6dUGbnO7wskKatjNlV69LC8Jw2IlRdksaqHIf/6DcixevWTdXkPKhFbuFmCd1WqOGIj1bgriFEveNeR77CpQCShqHSn1CGah7mC/t4ufPA1JC5aPnlFMV7mZ+9sZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by BY5PR03MB4968.namprd03.prod.outlook.com (2603:10b6:a03:1ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 06:19:56 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 06:19:56 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH v2 0/2] Add support for Agilex3 SoCFPGA board
Date: Tue, 11 Nov 2025 14:17:37 +0800
Message-Id: <cover.1762840092.git.niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KUZPR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:d10:32::6) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|BY5PR03MB4968:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb92761-be60-48d9-cdf7-08de20ea557e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVBiUGsyU053bHhRaXJpS000eWFiaUlSeGtwMEVaR1A3L0Z1N3JaaURjUVZM?=
 =?utf-8?B?cVJhamVWUllUUHNJNjVVdThqczJmN1ByT3pQQzNOVUM3K3ZwV3JlZnFhZEVw?=
 =?utf-8?B?Z1B6c3IvNEUwT3M4eFZMNkdCckNpbXFrRXRTd0k1STJXbmtDTHBEQ1MvQWdI?=
 =?utf-8?B?Y3pua2lOQlBWTXZyajFQUHl4K2xaWUV5UVNMRHpWZTB4Z3l1ZFcvZVZiT0lY?=
 =?utf-8?B?eXN1S1pDZVFJTENraGlHSVRkSWxLYzlPWTAvcHRsSDFCSkVDdWVlalhqbTBW?=
 =?utf-8?B?Tll0WmsyZ1VFUlIvTTZJTXdlZ3lYaVpmZFFLdEg4eU56aEZXSHo3V1Z1a3lx?=
 =?utf-8?B?WlY3NzhmZE1JYTdadG1IUWR6ZlNKNmhKODF0WkpWWHFBQkx6NjlZd1E2RWJm?=
 =?utf-8?B?cm9uQnNDVFhZRWx2aGQxSVdTcytrdkhWdS9PYjUyK3U0S2tMditPVnhKOUZW?=
 =?utf-8?B?emVGOE1nZlRYQVR3dklHdStyNTZTMWhOK2tNTkl5T0NVZEJFRDNXbUpYWVQ3?=
 =?utf-8?B?RHBCdXJ2MGtxY29sR3FaRnMyb2JYVXJLeUlFbGlZc1dUYkxIakNGR3BZWGVh?=
 =?utf-8?B?dHBzdFZuaVhlbkhPOSszaE13dko3MWpEbFYrMFJzWWQzUUJXVkN5MzNybk1r?=
 =?utf-8?B?Nit1bE9abE1uc05vSFRqMTl0ZjNUdEFSL0RNSDRueDBpbEhuaGQ3VnBzNGIz?=
 =?utf-8?B?ZU5wSkdVVkp2TVdYakhwZDNRUHNGVHBHYXBmMW1vMWozVFJIMmJTcys0UmRw?=
 =?utf-8?B?cUMrdEFPWXVibXRYMVJ1bC9lM1lraUxkZmtVR3ZNZzkvRk5vZHZDZjdDRGhq?=
 =?utf-8?B?aGdhVmEwYnJ1aDljNHFXK0pTVnRRZUFVNXFkVVA0Zm1KTGE1SWdUbjNCeEY3?=
 =?utf-8?B?M3JsMnIrdG9vOXpYQmJhemVMaEN0bk9IdTNLVXVvSzRuYmZnNVJVelBNRVRG?=
 =?utf-8?B?ak1pMEI1MEVvMlJtaUJ1YnNob3FzM0gwd3FrTHVBaTI3aDAzUlBGL1J5N0xW?=
 =?utf-8?B?K0VJSjViUW55Rzl3SmZDallmcG16bXdyU0U5ZER1eXUzajVwUG1XZ2J4Mmhs?=
 =?utf-8?B?WmdzWG85enUrSEZNekhGSVdVcFZid3NNSi94ME5wcmhpbmdSVDI1cHNoTk16?=
 =?utf-8?B?WnBvSEptaC90T0dycE9wUE9ybVR1aVFmUThSUVNaejNHOHgwK2NNbjU4cE5o?=
 =?utf-8?B?QTFLczdoSktjQ2wvYlVnNFh2T2Z2Q1MvWGl1MzVKRmd3Wkg2dXBRUllQQUsw?=
 =?utf-8?B?UGQ4V2JmcUNXSmlYRXRUUHlJT291TDRCekZKdHNoMTV6NVBLZTluRnFVTzZD?=
 =?utf-8?B?Rk92RnoxR09GS1pENzJUcmNzK0RNNE1rczJ4NC9MZGF4Mkl0bmFNcGhZeGdJ?=
 =?utf-8?B?M0xIbFVoaEFmUDVrak1mcERjOWFzMXhIeXk0SGtOSjlaZ1pLeWFWd0Z1dW5k?=
 =?utf-8?B?MmpuRXB0TDRQa3l6MkFwTFNUaDk5Q3FVNUdZNUJqb25qcVd3RHU1K29TeGxa?=
 =?utf-8?B?VGNKSC9MMjQzY05kUUROditaWGtmcldtOHdVM3o0ckVmeTVVcXl1c0p4KzBD?=
 =?utf-8?B?M29ZWmFSbDlkaThuWkNVZHZoNVlGT2tzbUZSbDE2QStMR2phNjNFMVk2WWZJ?=
 =?utf-8?B?R09sa1RSaHluaFFqeXZHU1RNRExBNmlWcVJ1N1p4SHdTem00WTBqSlpOYXFV?=
 =?utf-8?B?dkFkd2MvK20rMFNWQzFtQ3ZHK0taQXZIWGIwdXB5NDkwSHRXTXlFZjluZyt3?=
 =?utf-8?B?cis0ZzJqTkdodjBCY29pRm1CYmVQWW5BalRZRmxGSWU5OXV4MGw0OFI5OW05?=
 =?utf-8?B?SHpNR2d5b3YrNklTKzVUUXJrcy9MNTFORWY5RWhSTXF0UEV5c29zUzRQNWw3?=
 =?utf-8?B?dWJjVE1MckIxK3JlcEswMmY1VnRrcjFCVGZNWU5PenVjVjJUMDNJRFZSTGZV?=
 =?utf-8?Q?SdN5CpEw6Lg/yzhCEaDGPQyGCf/2ko6t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzBhUndXRk01bkxwZVFNNVBkQ0hkL01nRHFITjNxMjBWdDVWUDJldUF2RHhq?=
 =?utf-8?B?RzhrOHNiQkdoNFp3K2hnQlRCWTFremJ0azM0UFJHRm1kK2JCMy9SN1JLZjBE?=
 =?utf-8?B?OWUvcmF4OWpvMkEvQUUreExnR2VFSWkrVXhLM1dFSG84ZVowTGdsV2xXUmhC?=
 =?utf-8?B?RzY1cVdkREpacnRmZndteWtrNTdjb3Fjck5TVTdBYU9QRUdQNEtwUWxrNTRa?=
 =?utf-8?B?eU9WK2JKaVB2eFB4bkxMM2pQbTJYTFQ2S3lxVHNGQ3cxV2RreDJSMjhVTUFB?=
 =?utf-8?B?VWNKLzBtY2I1SnkyZnRMWGMyWkRzZzZFaUgxc1Q0VE9yOVI2MTdkRklzRFFa?=
 =?utf-8?B?QWYwWUM2K0ZkM1NKNyt2d0RSWGFSQkF3MU9DblFVV3NaQjY4RFFyeDZuTmlT?=
 =?utf-8?B?ZGw0SUhDZ0p6amJob2x5MVpOZEp3Wmg5ek51ZzkzOE5zWWUvMG01bmdoeGlC?=
 =?utf-8?B?ZTc0bTNmYktvTnlJRzRzSFIvWm5PVFNZWDRMV2luazU0Z0NJMVRkallrTmxq?=
 =?utf-8?B?Q0RCUjdmWUxTMnRYUC9USCtYOWVsMjE4ZGo0ek9wOWxYOE9OczNKNnpMTEJZ?=
 =?utf-8?B?R1ludmtCRFFwdjc4WVdPVnNuYzBWSGkwNWtTcGwrMGNMcERmb04zWnJLWC8z?=
 =?utf-8?B?YnFnRk9JRHlVVzdNZEFUSHc2RFdiVXhtNXRLWGlsMERoZk0zeEUzb2hvT2N3?=
 =?utf-8?B?cGI4aTBrNHBnZFRLN1lUZjVveTZVK0RWM3ZRdlJaRUFHS1l1WFlnYWJvMW9q?=
 =?utf-8?B?UU10dkRaay8yOEFkSXJsNU5za0dHY0xpd1UvYkJzanBqOUxWOHF0REQ5UmUx?=
 =?utf-8?B?Uk1QbnoxVVFGYlo4c1kwV0VaK215dTRDc0kvVWgwWTJBYjJrYkJEU2xxb1pQ?=
 =?utf-8?B?cFZmZi9sa2JHSDJOQ21Sb29zeGRTd1FmYkZZME5oQy82N2toenE5ZWF1eXha?=
 =?utf-8?B?Ymx3VUpTQ0ZxQ1ZMUCs5Q1NQKzd3c2IxeEUzZ0RzVUZ5WlgyRUJvemRuSU1j?=
 =?utf-8?B?VHgrczdpSUVEVkpxZldLd3czbXUrankvdWVmRnhGZmxJU3I3VVh4YnIwc2hz?=
 =?utf-8?B?NjQvdkZCSmxGVTUyaC9rT0FHNGsydm13VTVpamJzeko4b3NjYzRPQzQwTHNL?=
 =?utf-8?B?Nld1dTQ5RWsrQ0JBa0RlbEJFaE04U1dqbkFFc0pUdW5WU2tEUXV5WWd4dXY0?=
 =?utf-8?B?NEZhM2Q0MSsxTVh1WEFLRlhCS29jMGJYeVgwQXlIYXIyY095UnFjRDFqMmF3?=
 =?utf-8?B?ZW9Rcm9GYm9vdzFPZXNITFp6enZTak91RTJHUXhpTGUzY0N3UkZYZUZJQm1J?=
 =?utf-8?B?SVlISFNFNzczN1Vqcm9MWXhlRTZaY3RqQU1OdzVxeUhGVFNNTmNTNzVoU0Nr?=
 =?utf-8?B?a1hvbnErdWZucGxYbEd5N280VUJIN3Q4VXdYTGdyaWlrcmhST3BwRzI1dHA4?=
 =?utf-8?B?cG1PN2QxcnJJNVJKM2J4cVBRNWNIcjR3dkQrZmdldEZXakVtV3dwRWJxM0FU?=
 =?utf-8?B?bHQ5VUU3MlorekNCejZXV3pxWXZPeEprVmc0RzVsOFFvdnFNalBmTXF0WThn?=
 =?utf-8?B?b2dNay9iWDE4UU1CQzlIYUlnbnJoS3Z3MVROZ3RGZTNsNUZBdHE0eWVIZk5r?=
 =?utf-8?B?MDZRQUxoSGNubXNPaExpdWlrekcwTkdPOFdhOS9sSUY5a3lXNDlxYUtRNWJ1?=
 =?utf-8?B?amZncVZEaDZwMklGK1U3NGVpaTQ2MnJGNlkzc2hCbFJTM3BZWE1KUUtBYURa?=
 =?utf-8?B?TFZFWUdwYktoU2Y1cWMvR1lmRlRIankwSVp6eVV5VVJFZzBQVERKTElnTjlZ?=
 =?utf-8?B?cllEc1JUSXBYM0tBcVovVlFZcXUxdFE1Wk0wdHVRYXpkTVhFTW1wcEZ2RGx3?=
 =?utf-8?B?OU5jUzRqWTkrTng0MHFEcnZSbzVUcmREUVZtRHVjSXBRMXR2a3l4UU9QOFVQ?=
 =?utf-8?B?NU96bkxqRlpqNTJtc0dOMmpXa3Z2QXE4TU9qb3JuNktydVo4YjJHbHdxMjdr?=
 =?utf-8?B?KzZSQktvV3VMNU1nUGdUZi9UL3UvMjZ6R2tWdHZ3MFovSUJvQzRQdndvWC9n?=
 =?utf-8?B?T2V2UStYV0VHYmp2NC9vVkY0bVdFdWdzT0Y4anFPa1VIWGN0SHZEWlFVZ0ZZ?=
 =?utf-8?B?MzRVVVg1UG5ETmdsZ3BqK2hkbE1hL0VERVJjVjJ5cWFDM3hrc0lQbEQwRno0?=
 =?utf-8?Q?5uVRYi9jYTwoHRlLSTX0700C2DlxOmiw0dz8hsw3Mw6z?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb92761-be60-48d9-cdf7-08de20ea557e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:19:56.4143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRKRbXgPjh1tFSi/CUo9S806oG9GlNWTUTQ3CloT8tumxsM6youAjIy7nMCbfqvA7naeMv9C80C350i5LuCf0DkSTiQmYPaA8ZyUXVzftzgN81UhWPYax4k2T7jYiZuR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4968

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Agilex3 SoCFPGA development kit is a low cost and small form factor
development kit similar to Agilex5 013b board.
Agilex3 SoCFPGA is derived from Agilex5 SoCFPGA, with the main difference
being the number of CPU cores — Agilex3 has 2 cores compared to 4 in
Agilex5.

https://www.altera.com/products/devkit/a1jui000005pw9bmas/agilex-3-fpga-and-soc-c-series-development-kit

This series includes:
 - The addition of the Agilex3 compatible in DT bindings.
 - The initial board device tree support for the Agilex3 SoCFPGA.

Note:
The patch 2 depends on the series: "Add iommu supports"
https://lore.kernel.org/all/cover.1760486497.git.khairul.anuar.romli@altera.com/

Patch series "Add iommu supports" is applied to socfpga maintainer's tree
https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_dts_for_v6.19

v2 changes:
 - Add separate agilex3 compatible.
 - Use separate dtsi file for Agilex3.

v1 link:
https://lore.kernel.org/all/cover.1762756191.git.niravkumarlaxmidas.rabara@altera.com/ 

Niravkumar L Rabara (2):
  dt-bindings: intel: Add Agilex3 SoCFPGA board
  arm64: dts: socfpga: add Agilex3 board

 .../bindings/arm/intel,socfpga.yaml           |   5 +
 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../arm64/boot/dts/intel/socfpga_agilex3.dtsi |  17 +++
 .../boot/dts/intel/socfpga_agilex3_socdk.dts  | 126 ++++++++++++++++++
 4 files changed, 149 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex3.dtsi
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts

-- 
2.25.1


