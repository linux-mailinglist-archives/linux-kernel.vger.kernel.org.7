Return-Path: <linux-kernel+bounces-887701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A4CC38E89
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A0C84E8095
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3E9246782;
	Thu,  6 Nov 2025 02:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="qgdJ2Lzz"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022103.outbound.protection.outlook.com [52.101.126.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7652B224AEF;
	Thu,  6 Nov 2025 02:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762397062; cv=fail; b=Zs0j/Vh+en6PdJodqCY67DJNhNp71D0hwPplyT/Ixz7amh7z3BMsNeZnuUyNQbMJqVlEAUw/bx8IeGW8J9b3/qFDE66G2phkC+WumD1OCyTku39QqhRnG5AiFWe2WMlBYFl0xAydS4Acw2mcxtDhWQJjAqFvXFCQbFsJQv55yBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762397062; c=relaxed/simple;
	bh=81YynOTQgj7WiIiwy3n90LzRrn4zM0NOwSStlT3Ipl4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fZMMYIGQncphIqYlQs89UagPIiBbfK9KYu5tbbKcFG4UyZ7fQjo24AF/gilTeZDMTRiA1SXJ17g/e/HIAXcGTOAU25jfdfMzxQkgKd8JmtnOyroqpi9wh32AzlQVN7wA/NzY/IwAZoRTZUmPzhwM1m3duTNy7YY5hD7WuEAsrqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=qgdJ2Lzz; arc=fail smtp.client-ip=52.101.126.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLsrW7H15sYUWqM4qiVNobHPSre7GwwLNHwTh1BkLtZYqwCpUXwVn5B+TL+cpTFSWxv4ja8uDr5Z0D7iZvWhRVDFpeD74CCrS9AQACnvyv7oqxjZqRf5j+qTsr72Zj1zcFlK0zbeITV/5UkBsG4CkeaxObWdrEln2oDCb3cFQSnGzHgQ8Au/GGpovWPPqFNQ+6mMCQS5hmlQGcwKkNAIKl8/yPtIUK0U7NsrzgINbD4Cy6qWGHLDe88E66hubI+xQSwU/y5Op0Le0Pf8lA0GFdl9S0T3GIdhH6D2QlVxPAqOjRg005cVfrPgvGISf3Gh1XzmL4X5tZH8mDDvzcG7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81YynOTQgj7WiIiwy3n90LzRrn4zM0NOwSStlT3Ipl4=;
 b=AkJK2BHG+o0xOt4ocWzXSQXkIuuwP9lqKj1sOJnmPrZNql918/Ixn2AuhJNdig+en3basexbmustwSJ7l2eeEEUoQswtBMZekk7aCUgOwJIq9rqh5bBan06HAv+X6M/wv/qrtS7HMMPcwJlvpoyVY0Pg3mnnO3fkJHbO6X1HSinjIuagxa1pu4Eh+/ZiGhYkj5SxlJCEaJQFZWe1dlpvRGlnEnyHRzrDQua2GUGkwHwdZVV8WN0Ny8Z5/EgsrJS+3408sJ5jiOZpfu9T6pTqDS69T52tbLpQaaEe26oKCDOnTewlF86oIjIKYZQ1VkiCXkOFWqfLAJRvYcxsxDTZxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81YynOTQgj7WiIiwy3n90LzRrn4zM0NOwSStlT3Ipl4=;
 b=qgdJ2Lzzf4rORmTM92zvY9Uw60WquFTVjDt79TBX4zbT00PwxdN9JlS9AfpnDf0AEqL0mTwFOewfSQrGs7y6D83vLVPlhg7HYu2Bn9RBoNukklVYPHmIiTz222ZvfskvTQv/SmENW0ex7X29gypQRm3dryDa9VkQx0RiBS4VJ0zuaUYULSb8Q5qOevmceEtf1Eq7Yp1k6lSyI27sYTVtCWM1XE/OfqNdCbcqsyM/0k4LpWENMlx1g3NKg4L9YXv2ldvDZMj170ip5NrfCtdPKkk7lGllsAlIXXCgw3QBmN3MA3QjdE+756UN4GjuqRVvTfCedlPj79tDNajN1xt/3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5521.apcprd03.prod.outlook.com (2603:1096:820:51::12)
 by SE3PR03MB9513.apcprd03.prod.outlook.com (2603:1096:101:2e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 6 Nov
 2025 02:44:15 +0000
Received: from KL1PR03MB5521.apcprd03.prod.outlook.com
 ([fe80::f12b:85e:f95c:191e]) by KL1PR03MB5521.apcprd03.prod.outlook.com
 ([fe80::f12b:85e:f95c:191e%4]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 02:44:15 +0000
Message-ID: <8c78922c-ad31-4016-8cd5-df2b2a3bdd1b@amlogic.com>
Date: Thu, 6 Nov 2025 10:44:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add Amlogic stateless H.264 video decoder for S4
To: Nicolas Dufresne <nicolas@ndufresne.ca>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20251027-b4-s4-vdec-upstream-v1-0-620401813b5d@amlogic.com>
 <b976b442-7d07-4fef-b851-ccd14661a233@linaro.org>
 <540d98ea-114c-43bc-94c0-e944b5613d74@amlogic.com>
 <b6e6881197dc4c83e43ef5eb1f20c2bf1887d395.camel@ndufresne.ca>
 <174ef722-99f0-440d-8eee-5dca086e13f0@amlogic.com>
 <6d046cef20dcef4eb14aba6fa89e30d303f6a1b5.camel@ndufresne.ca>
From: Zhentao Guo <zhentao.guo@amlogic.com>
In-Reply-To: <6d046cef20dcef4eb14aba6fa89e30d303f6a1b5.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0174.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::30) To KL1PR03MB5521.apcprd03.prod.outlook.com
 (2603:1096:820:51::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5521:EE_|SE3PR03MB9513:EE_
X-MS-Office365-Filtering-Correlation-Id: 24d0571e-9a92-4932-9336-08de1cde5fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWIwOFlkeEorMTg3Z3RFTk5kbGVBVVlySE5tN21jYlFOV0VzRmt5eE4xbFFm?=
 =?utf-8?B?eG1RNTcrK05WcjZYWXJSdUxCKzNNK3BYUXdFS29WY1lHdkgzVjJpQnkwUVhs?=
 =?utf-8?B?L055alNBRFEyZXg2dVVNVUtsR2JZWmFVc1pPT2luTUtDMForZjFBelhUQjVM?=
 =?utf-8?B?VDJ4aG42SVp1eG52R2RyandEdkE2bUMwakM0Mk9WV1YwQk5ZZytSM2M5TzZH?=
 =?utf-8?B?Q3dCWGJvaXMzVkI3MWNodVNha25NaWNTOWVoS3ltd3VORFBDbzA5YU1nOEdY?=
 =?utf-8?B?NERzL0MxMzh3cUhOU3pmOHJVM0sxU21rU0pXN21IamVpWlljWm4weldEdzIv?=
 =?utf-8?B?akJSNlc4Ny9Ba0I0Z2JLN1JMUDUyYksvbXNMZzM3NmppcWdUSk9KTk5TMmJn?=
 =?utf-8?B?WHRyZk4rd3llNFN6bll6K1VMRElTUWFhWEJZWjU3NWVhWjBNVU5UbnNsbU44?=
 =?utf-8?B?eGNybjBPN1ZXSmxVUVltNUFZTVEzeU0yNzY0TlpJMFVJRFMzMzZBdEw1NHpv?=
 =?utf-8?B?WnVmc3ZKeU5lNklnWk5Rb0VNR3FnS1BtQVA0OWFoWTJhSGUwWHlucHhQYXVK?=
 =?utf-8?B?OWJPWUxqeWRMRjJWUDlvWDUyYkYzZllEaVhMUE1vaEgwNnZGZkpzT2ZZWG5Q?=
 =?utf-8?B?aW44V2ZEYUVrOHc2MWRxcElycUc5L3NMYUdqRmVCVmtqTGJoQWticnlaMmZv?=
 =?utf-8?B?R00wMU1qMDN4VTJjYUNmYzJPZG42WWkwd3JXbzRwcUhKT0lTNFhCYmxZa3Rv?=
 =?utf-8?B?UVJ2czRBdHoyOGFMZG83Y2dmMHQyOVVZM3YvM2VMVktuTkRsOUhJYlJPajF2?=
 =?utf-8?B?aXE3Z2JFK0tMNm9pSmpCR0ZlVDZxeHJtNzI1ODhjM0F3anVEWUNFakNNcnUv?=
 =?utf-8?B?TEVhTDNUMTNMVWY3U2N3aDB2aU9IVE5jdTlJdTRKLzJ3UjJVS25KeXJUaWd6?=
 =?utf-8?B?Z01DcUIvUW1xdEcrVzRTQW9zbkYwa2xQQXBycWg4UzBFaitZMVBtSFIyZ0lw?=
 =?utf-8?B?aU5sRXlFT0ljcXJTSkovcjVLZnRDVEo1RTRHbnFUTjRseXlIZkJsSk5reUtD?=
 =?utf-8?B?eWRtVUVQWStXNW42U3I0eitaTy95NVpNR21KL2k2Y3RCNnY1K0liT1RLK0dl?=
 =?utf-8?B?c2ZLZjJoRFZDZkk1WDdCQ1F4Wm5jbmNKWWhVWHoxdVNjNVhjamQxem9paUha?=
 =?utf-8?B?Mm1LRU56eFgwcHpZYURyS3hqZ210REo1d3U3UFp5TWR0KzM0aDZJbnE5MVVn?=
 =?utf-8?B?b3ZMOUdmS1JZc0hwMi9nUGE3Q1NuazNyZDBudW1HTVFMVEZ5TWI5OTJsR01q?=
 =?utf-8?B?elZTUlBVUXpld2dWcUdBU0lOQ2N6UFFJVTlYb2RqSi8rRDJJOVB2d09WbXQ3?=
 =?utf-8?B?UVZmVlNRQi9TS1ppSldRQTFMTEc5dXZrc0greXRNSUNEeHA5d3Q1cHJkVlVh?=
 =?utf-8?B?Vnp2c0dhdEt4dGNjUmVjenN4cmxKd2tSOWdxOTNGUkVLSWV6bDRBOTJEYzBl?=
 =?utf-8?B?YlFubVVHeE5zdlk0Y1pya2tLNlptMnFHbWtkS3hJN085dTV4QzJjb3JIU0dP?=
 =?utf-8?B?a1dYdkp2LzMrNmhEN1NUYlNmaW53akFVVWE4bFgwVXdtMUR2Mk9Zb0ovUnhq?=
 =?utf-8?B?Tk1QOExMK2hwdFJwRUY0eXMvTXNYVjRCSmRyaE1CZGFCeUU5d3pHZUNkYU5B?=
 =?utf-8?B?U1A5aTNRMk9wYTc1WFFDOTJzam5TM25QeDhnVnh3bHJhRFBYUVlCNFlYa1lC?=
 =?utf-8?B?aUlUVHRFU1VZcmlhZ2VwZThPYURZMFBzd2lVbUJUZ3BxR0owRERlUkpEQ2I3?=
 =?utf-8?B?a2Y2N1o0Tm1nRnJmVkZacXhhemdxTTJVWjhHQVg4ZjBMM1NJa0xpT0hZUFo3?=
 =?utf-8?B?MVFWN0piS0draWdCbVNTM1gyNHpqY29kdWx6QzdDVG94VFBMNDhwbStpWDRX?=
 =?utf-8?Q?UKEtEb1CXZJyZM+IA53ouwyHUt46UW4k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5521.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHlHd0RVZWsyU0JWclJGcjVRa1NoZ05QQjAxb1VMckd1aTFvMFJ6QjgraFJ0?=
 =?utf-8?B?SzFBelpTUWoyUjc2OUxieFpyQmhNdENRZWVSb0tLeWc4a2dKTFc2UnkzNWg1?=
 =?utf-8?B?UlVzVVo2cGxNeWMwdUhENjY0MHVCN1lQMm5tV25nV01UU1N1QWFjZEVvSnFh?=
 =?utf-8?B?SEoyVHpXUkx6bWpOZHQ1Ry9wR3lrd2VhVkFkVXdncm56d1pHN3BDQzNCSzJF?=
 =?utf-8?B?MlRrc3pHb3hjbTJnU3BYMFcwUjhrWTk1Sm9UYWVUSk5aeEZ6cXZ5M1YxUU9O?=
 =?utf-8?B?TWNCT2R1SS90UFVsMjJveU90RUg1VWRIUnRWNjM2VW1nUFJpaXprbGF0V1FF?=
 =?utf-8?B?MGFJLy9wMDdMRXlXaGE0YTZTWWh4cFNZR1lBN0VCNGc3RU5sUlhlVjNlNE13?=
 =?utf-8?B?Nk42VkF3RmxpamtGOHRsUmtlV3k4NDU1V1NjaGRIVnM2Q25xN3oxb3F2MDc2?=
 =?utf-8?B?bkNrVXZEQ1l1TmIvN0E5N3NuQ1IycjZ6WWowSGdJcnU5Z0w0ZDdpdTkzYUZ0?=
 =?utf-8?B?Qk16Z1dFSThnTzQwOHdsWXpQZXllMmVVV0U3d0NydWp6MHBIRDRRbDVySmdK?=
 =?utf-8?B?NTBjaHpmVDk0a3AwUEFITkkycllQZGdsci9wVURiVjROOTRoUU1FU21MUk9o?=
 =?utf-8?B?aVRIekllcTF2Nk12YW5SRSt1UzFzdEVwcDBpd25mQ3djaEs2Q3dtTllsTmg1?=
 =?utf-8?B?Y0JTYVluNUNkR3JwMnJxdTcrNDU3THJWMHdrZjhnbzc5aU1Ld0xpRU1GOVBG?=
 =?utf-8?B?Z3NxOWZIby9HSnR5WjJmTWdoWlh1TnY5eXN5dC82VFA4VU80Nys4eEZDQitV?=
 =?utf-8?B?WmNORFhZWjhuMFlGK3Z0QnpLTC9meGVPMis3cStSZWtaZVJJWVFJM1JRTnNJ?=
 =?utf-8?B?b3BDVnFwNGU5bUNQOTY3cmd6VW42ZHdGZ01QM2lvZ2VxdXBlSFhIeUxLZTJG?=
 =?utf-8?B?RDZ1K2d6NUJwRU9HK04vM1AvK2ZrK1RiR21GaVczcG5Va3RYOGwxeEtZV3Zh?=
 =?utf-8?B?UVltZHJWT29aVlhZOUJMQXdWbnBPNGFCNEpUdy9oWElJNXFxTmFra1RVOUVO?=
 =?utf-8?B?TUtNL3YzaDRwYUpNUUhhR29tRHdzQzhEalZjcDVTR2FyT2FKRnBBVlAzcmhz?=
 =?utf-8?B?STFsTGJoTEhuL2VNNkVwcUQzS25iYmsvMkhUbFk5eXpBd1hJQXArWkNsTzV6?=
 =?utf-8?B?VjlnZUhCY3czL3dZTXhHQkUySWFuTm9wY2VoMnN3OFBIQTlIZVV5YzlVai9t?=
 =?utf-8?B?SndCK2lQZk1tT09WM2hFT251UStXOTdkejB5WDFhcnZZc0lBTlE0MVJoSHF6?=
 =?utf-8?B?WjJ3YkUxaFhRTzlUc0JWVFZkTERhOWt5aTBoTmZpdDA4UnhoUVR6b0NvV2E0?=
 =?utf-8?B?K253VXRLYmVlSTJTNU9ETVpTYm12di9OeDA4dzk5ZEsxeHBmUmFTOFdiT3Rp?=
 =?utf-8?B?REVOK25OSTNZMFZnbGZUUS9lSXZ5ZStBZHRDQjVZSURGK2xZSkNMV2VjeUVJ?=
 =?utf-8?B?ZTBzUmwyUHZESlZrOS9pNlJrMUpLOW12Y21pRXdBWDRPMVdCVGJPZEtqLzVU?=
 =?utf-8?B?SUZERjlHMUFOSnVFVVlmQVZBWTN0WklmUVVqSENYV0Z3S2grd0xlU3Vva016?=
 =?utf-8?B?V0tmaHVrZTBIZjRuZ2FlYkg1VTN2NnFKZUQxZGxQUFhaRnBQSGpYQXRleUIx?=
 =?utf-8?B?RVVIaUw1bUUzSjF4L09ibXduUnlyOWxQaTV2L0JabmR0bDI2K1h2eUI0M2lO?=
 =?utf-8?B?dk5tSEd0ZlVzQUV5QjBPTmxzQzhoVUc4eDI0c05jamFkU0YvWFNNRUM1T25J?=
 =?utf-8?B?VVBQUzhuSThFRFZTenIxcGk3b25KN3hJaDd0cm15eHFLTnJFTHF4RlN1Qmlt?=
 =?utf-8?B?cW9xS004UFN3bzFZM3Mva3JjVlZkMm5XYUN0dW40TzIzMm9oMTlaNXBYdndT?=
 =?utf-8?B?cWhlRm1ndFArQkdGS2hGMEU2aXl1NkZtQnhod01hTWY2eFZXN2duUUo0ZzI3?=
 =?utf-8?B?aU53QkdLK0xoSE1JektaR1dBd2pWWXZ1SzBrUCt3RGs2TlV0bExGaDhFMDF2?=
 =?utf-8?B?NXBZcHdBWi9lQXBtbXRSeXVFV2cvbWtxaXNsNWZyM1BpWkZvZnhMZWpqMEFm?=
 =?utf-8?B?dnBRbVRLV1YxbkpRV0ZjTG54QXpMTUJkc1I3NmNHSzFBaVhDMVBoUDdnZUJ0?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d0571e-9a92-4932-9336-08de1cde5fc5
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5521.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 02:44:15.4680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgR0/AMWgxc1eugtjK03pEaWHEYE5k46g4EeguT21kpCPoAJKdNBtyBBvjnpBx75vQlYjbel/JC3cGopQzBqJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR03MB9513

Thanks! Look forward to see your feedback and I will take it seriously.

在 2025/11/5 21:51, Nicolas Dufresne 写道:
> Nicolas Dufresne
Zhentao

