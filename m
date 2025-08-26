Return-Path: <linux-kernel+bounces-786824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011E3B36AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BB7D7A99FB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1850C35CEA1;
	Tue, 26 Aug 2025 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XQb2KxKQ"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C446352093;
	Tue, 26 Aug 2025 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219016; cv=fail; b=Q6wqq/O+c8xUTsVcQ+6rgnfjWTiTjMwX0/dk1DXCSOqxNMgxYg84gaaC7ojv80VKQzIiDQc049GAjAZJbPuiMg+1HCu8LToZzPFS9z4mwSHETE/IKYTRUy8vG7Pwf9OpJ83EmWsL57hOLebtKo6KsEgG9voQl7FwE1i/r8OBX+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219016; c=relaxed/simple;
	bh=w5GWUDZ/uNVt0PTqzYfQFJqYqAlqkac8H9UI7JWSvlg=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=OT8pGMRXn4sGAJO0APfsRVn3vpi5EF1ZJUdXKILNjwzbZQGPMgNtO0MsPI5pFUX+hSkdOWaHXLwoSfSQ/eByEn3uQkgpe5KSCaa1+iQBLlAUXru2bnPDKE6WkqTjslHc637imUhGD2pmdvfZhVHs8sVPRK6bI/uV3O/5b/wFqAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XQb2KxKQ; arc=fail smtp.client-ip=40.107.95.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7Jyl/28p/hG/d64LtMYgr0uTT9rLiQRu4fb5rdBrJC0C5mdgnYS/ujsM9RuJ5iM5afheJC8yP8LjKW1NT/6cuS+uFL4x6RY8ZZuEeTIgPi2nAlAA1A9GBSE3edkDU03mXxYrWUNhhI2442qzAMk7eT4A7sNlePvlF8OV0k+JuaH/pjqWHZkl5A1wBMa3hlGUTD4G36YTnT+hy/QsT+3M7kcaNP6eUJQHFXKNJvh99Ya40j+8SenjJy58Qq00uOwHlB5eIht2fNIsTrqE+esbO64+gWgdjvJDv+imLst8mDNSv+JPHbdyP0fivPKhO/xQA2bQiKH1d/as+ja0Z2s1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEkoriycFWYjvYqTCmiqlb3I8/5mRq6l3CXtk4Yb+NY=;
 b=nZRpIydfRb67lu9hMEipa9PtswjWMNXhrAI/F7xqIRfaX4GZ+2c9BRWhcVBJpvGB9ktYByOxCRVIVWzoF5o7pk63YBhE4omCIfzAaOKsAJXLBOT2ZM2QFdNmkFXnvgP90HuCSpCgIo0y6b1+1eQfo+43hnblnUsDk7N3rVy1xaxPISb7/Q5LLcS/0FAcEWs7jrUqk7OW0VHtqN2wAl8AgFUc3KadRG4kZo9ypXh0ta8CXRPR2bD5Y8Q76LRB6DPaZri9brpcf6Wda3ZbmXzcGHkUGFa4WMYMJC6Rv90AWVPcrmO56OMSMbcndTUSP01/iP9SThgl3b0YlfW3N3kPSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEkoriycFWYjvYqTCmiqlb3I8/5mRq6l3CXtk4Yb+NY=;
 b=XQb2KxKQjdkZLgW3/vqT0Fi6Daoe1Nt1LT51QsLSyWrIpIYyTT8RSYzdAdUE96BIz7hIosIRUUYGWxGFvzxGi4KIsuuCl44n+4TcU5elEoCKQBYKZC6mplNb9klHd9H1vgW6s1NoroEYqRmZxiUnniwr1qRQ1QjSsElk0LGjvWqWct2dJ43QBq8xA7Q97J2eQhvnODGCNLrsTUWoHAB9yPYdezkusd2tYWvB7yLmtAn9FbSjs/XM+pbFbfEkqcYSHKBO2ipaG5WfE4ZtySvLLkvK/kFPCRIdIkkgkHX6YnOALG6asCF04Mxo0gevxeA/htq57URgIYACooDJVDePUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Tue, 26 Aug
 2025 14:36:48 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 14:36:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Aug 2025 23:36:44 +0900
Message-Id: <DCCFOGR3BPVC.3OW6B74N372MB@nvidia.com>
Subject: Re: [PATCH v3 3/5] rust: scatterlist: Add abstraction for sg_table
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <akpm@linux-foundation.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <abdiel.janulgue@gmail.com>, <jgg@ziepe.ca>, <lyude@redhat.com>,
 <robin.murphy@arm.com>, <daniel.almeida@collabora.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250825132539.122412-1-dakr@kernel.org>
 <20250825132539.122412-4-dakr@kernel.org>
In-Reply-To: <20250825132539.122412-4-dakr@kernel.org>
X-ClientProxiedBy: TYBP286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::23) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b4c8bc-8789-4944-ff69-08dde4adfcc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHpZMElYMWdJM2QwdENZNXdnNGJPdEFka2k1MzMvekNyak9MR3FkN09DUHdl?=
 =?utf-8?B?STdJVDJmYmdJdGREQlpIYWlTL1ZvSmROYkhCZnY3R0Vubzk0VUZhc2ZncUF0?=
 =?utf-8?B?dmMvaW41KzdZSHRCaGtOVDA1QTRzazJvOXJxMFFGV1hFd0RUK1ViY1hSZ2Er?=
 =?utf-8?B?RG0wNmhCWnR1ci8xa0UzMkF3NkFqUkRXdVZCUm9uZDJVbGo1MjV2bUJ6b20x?=
 =?utf-8?B?cDhMdzR5a3NwWWJoaUpwejlpbjBrU095bkJkUFMrT3ZJcDBIZHJscTZROHIy?=
 =?utf-8?B?bXN6bjVTSFZIR29CcTRDRkhRTDdhWkpReHJHSDJyQ0pZMWZyc0IramswRXI2?=
 =?utf-8?B?QmFUd2Z4U3RGV3Q5eXZRRE9OZG55WmZPZURZUlRpQzlkcnNGRDhFUlpqTkI0?=
 =?utf-8?B?b3BGTkFjVmV2cTRYQ1pLODUzTEhGRDRHU0VBb09iLzhqVjFMTVUxbWpvNDdj?=
 =?utf-8?B?Q2szSk9zUjAvY2FrT1JkVVdQMTZpenI2cmpGTGFrV2QySndNd1lFK0JoQ2s1?=
 =?utf-8?B?T1pWZ2w0QzBYV0J6NklRc3VPTDRyS1dYWElHMnBtc013aGQ4dFhVTmphUHRR?=
 =?utf-8?B?OHU2LzJkbW0zbmptSFRqNjNmWlVJR0U5eE9lMVJWd2NMR1ROaXVRRlBVMTRx?=
 =?utf-8?B?L3MzWWYxdUtKY1hlOVpHSmorK0luUFRLc21VRHFWT2VOY0N4VTZQbXQ0K3ZS?=
 =?utf-8?B?bTZsa3FJaUJVVVNUdzJkSVY2Vk9hS3RRVTNXSWxGeTkvQmlUQzVjRWVvUWM3?=
 =?utf-8?B?Kzd2bXlKN2s4REt0aHJ6RDJXTVdFanFWK05jU0lFMG9DaTdqRFdqQ3NINW9B?=
 =?utf-8?B?L0xlcktJekV2WW9ZT2JTQkJlZDBqYytxRUp2ME5zZDBJNVlNTGc0SllqNTZJ?=
 =?utf-8?B?VVhITDJWWVBXMUVsemlVNDh3dVljWnR2M3NUajlNNGVuSDlxWjhYdXBBeTRU?=
 =?utf-8?B?c1hrdjhUWDZ6cmRRMElrUURmR09ad2t4ZXdwK2xJNXQzMVVhRzFYeGswcnBH?=
 =?utf-8?B?UDR0T2t0R3ltamNsdGhTbjV5QUFNZ2dxMnl1cThSNHpha0JaT0t2SHRLd0Z2?=
 =?utf-8?B?d0lPNUE5T1VuOVFEeDlLSlVYTE95RnlYZ2d1Y3Q4VUZlSE52RDVzV0FXdGRL?=
 =?utf-8?B?Zk9kMi95UzczdDdrWGtpSngrTnl4b2IxdXdSdEQyM3I2RWx3dElGbUQvWWJw?=
 =?utf-8?B?UFdLUEswSzVpYVp6ZFNiVmNNdU9CVE5QMHlIUWdFL0I1MzJJbGRQMTB4SUd2?=
 =?utf-8?B?RWl6dVZVTlYrUXNXQmNaVlFjUm50eGVNQmZtLzdteU9pSzdNSE1aTHF5TWNi?=
 =?utf-8?B?Q3IzeE1kNHhxTEl0QU5zUGhpcks5Vm5SR2FUaWRTdmFScjlveFVHY3BpblFH?=
 =?utf-8?B?TVdkT0s5Y3dyeVh6QzZVM2p3c1pMU2NZZkFqb1JKK2JlNFkxUGZhMUJucjNi?=
 =?utf-8?B?ZldCajcyTUtMWTF2RU1VTnF0Tm1GdE90UEFFNDJCSlVQS1J3SlFESkJkbTEy?=
 =?utf-8?B?alZ1MVFpbFhSYkY2QzRrQTI4dW93bThwdVg2a3hBWFp1K0dzcDlLTXdpcWJR?=
 =?utf-8?B?bnJKbllKRVNhTlE3SmRmYU92M1hTUGJWd3R1RnNXaUs3T0RDRUE1VFVzdHNt?=
 =?utf-8?B?NzArM2NVQitlT0VJMVVMWkhBU1UwQ0ZUWVNUZWJBZGJkVlJTdjNsdTNIK2o2?=
 =?utf-8?B?alhGekFPUllRNkZ0eHVMWklmQ3gwc1FJR0xWSjQwU2Z5Y1dsc0cxUnRWVUFL?=
 =?utf-8?B?dy9IU1dVR21MRzhtTFI1Z0xqMHB1MFhURGU3WUZnb0w3UTVVdEQwbTdQTjRQ?=
 =?utf-8?B?U014RzBtWDlLRm1aajF4Mzk0bnphL0I1emdWanUvSlArUlBiN0ZCdUw1OVJZ?=
 =?utf-8?B?K0I5YTdvY2JmZVZ1R2VUWUV2ZTdNYkc4Q2ZwdkhGRnZTd3lpWmEzSFhMb0x5?=
 =?utf-8?B?Tm9YaFhFY2NvZjNSRmpiNisrMWJLNldCVHNLaGlWTE91OTAwWUpDa1pPSEE2?=
 =?utf-8?B?VzBmOTY0SWtBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEtRd3ZLV29lTWJoZ0tTTXdzcHY1dHBCTUxEeUVnbjFUcENxWlFmTDVCZFY1?=
 =?utf-8?B?ZFY1MXpyNHpqeXh2UmZkcnpoZVlYYUZzYmNYVjJjN283Q2hBMFBWRkkybkxM?=
 =?utf-8?B?VktWeWpqbXpGdkJlS3l3YW1Hb3prMm14enRTd1NWczBjZ2ZjU2RGTkx4UDB0?=
 =?utf-8?B?cElNZTJYN1ZzUmprbDFjRG9PSDF1enV3aHlDcElBWGpvT1lHUzlDc0xEYzRJ?=
 =?utf-8?B?d2JHNVR4U3NZNlZxWHF0Qm55S0RNUnFkamllSmxxY041RHhYRVFaYlBXRjBC?=
 =?utf-8?B?cEVpWGJRclREUFQveEkrVWFudUxEMkcyTGswUTZycCthYVVQNEU0MFU2OFhl?=
 =?utf-8?B?YmczeENyNTFqS2JpMFJHQ1pCblhJejdoTmRaKytOZjNWbHlsU1dsV1I4NVBK?=
 =?utf-8?B?VURjOHU2WklmY0JSU2lGWGxZZnBOL1Y3ZlQyYUpYVFlYRk5INXdrMjYrNXQx?=
 =?utf-8?B?Y2Q3RjJvNTdvQ3hoelp5cDZnYkd2NXQzSlU4T1dzQ0RiTklTQmN5cC9JMFZ2?=
 =?utf-8?B?dWVKR3l4Z1FwQTQxbU5uTjZQaWh3clVMc3hkRU5KSG1CcURjZldvYmFPejBz?=
 =?utf-8?B?eCs2L2I1Q2NWYlJsazgwN1lUVnpwbHFYWUdyK01VTkVUakt0WHo4enhqc1Qw?=
 =?utf-8?B?NUR3RDloanV3RDdLMVhZc1Vrd1l4VzRTZnR5UHczdVlQN2dsS3BRL0YvcGFa?=
 =?utf-8?B?MEpaNnB0S0RxeFdFNDZkQmlZNWFYM2FiclorUmRVRXNacm51RHkzQldZQkwr?=
 =?utf-8?B?Wk5uQjRqTVNubEpiRll1V2xyQXpjQmQ3YVRHdThTQ29OSGFCZ0hURXdRblkv?=
 =?utf-8?B?TjV1YXE5cjNvbGlGOURaL3JUVmxpU3NoMjBXdzRkQ015cUw2WUVPS2FPZGV5?=
 =?utf-8?B?VnJjLzJ6K1lTSnArQ1Z5b2htdVQvTnBDYjUyWEZJdU9RalRDbVEwdTRtb3BF?=
 =?utf-8?B?anRPbVZTTWpPZ2lrcm1Jb1JQWURRK2Z6M253NlpvTFh6Q24zcDRkdDRpbVJN?=
 =?utf-8?B?UER6OU9lV0VZNTNaL1RZMVFjS3h0cVlRaytPTHVsanlLTTNJaFJucm5vc04r?=
 =?utf-8?B?VlJrVmorRXlQYTUwN2NkYy90TnV3QXV2LzhucGFjT2Yrak5IbUtvdzg4cmVF?=
 =?utf-8?B?NUtjSDNhNXhYMHpjWC81VVg5OXVGQ3M2Uld1azFrT3V1VjMvQnA4ZHRqKzEx?=
 =?utf-8?B?RXlLdmhRMTZCRjBTTFZta0xUMnZ6ODBpaVdtY2x2dG5uSXNjbmR5ZUIzYzlP?=
 =?utf-8?B?QWMwZUtVWkowL1NLNXFSUThLZHdmZ1NvMHYzWnQ4TTM4dkRXVWp0ZHluSWow?=
 =?utf-8?B?MWw2cVVjY1Ura1A2MlQyK3FwWmVlVDB2OVlzUGQwL0w3eW1kUStlWHQyL3Vh?=
 =?utf-8?B?RmlQeXpEWFRIZ1Bmb3dsdkxpN3RKNGIwQ25sUVpaRWFtK1pyWnk0ZVMweWk1?=
 =?utf-8?B?Q2VteC9ZdEVmOGVpZ0ZpK3hMdVd5YXF3VUN4SVdjcHRSckFnV0Zvb1NPanFy?=
 =?utf-8?B?MkNxMUVYYmI2MXAvZE1HOFZqL2V5SGxSVjRzUnFIL3BNeHMzWnpwc21PWGEz?=
 =?utf-8?B?cHlQNVVRYm1Mbld1S1dWZE84S1dIV1UyRmdHTDFsdHdYY3puWURldW1CMDVK?=
 =?utf-8?B?M0M2alJDdC8rVjJJVW5Qcis0dWRPcjZWMU9Xb3ljMGhIWjAybWZNM2NEeUov?=
 =?utf-8?B?TWszKzgzMHZWek9wMmpFWWpETDJrV3A4UmhkY3lZR3JtQ0NINUx4MDRDOGZa?=
 =?utf-8?B?UUdiUWpkb3QzODM4Rk5uaWdGc3FzZ1RZRDJXTE9GTnovSmdCZlVla0RndHp1?=
 =?utf-8?B?VjIvNzdOb05rRDYzS1pseUowRzBSUy9DRFppWUJucHY3ci9qbmJTRnRJSVdi?=
 =?utf-8?B?QjF0SnQ1cmR6VXJNNVRFeEV3V01WZG8rYU9iKzRuSWhXdU9XUGJMaFBMZjA2?=
 =?utf-8?B?SVRJV0dIak5IRzBoSFY0emNwZ2ZBd2VhSTV0ZjBLeFM5QUNKallQR3JJaEVZ?=
 =?utf-8?B?SG42am1KY1lLaHg1ZnZMNDJKOEw3eDZxRUgvclJLVTd4N3F3RFM0ZUxhRG1J?=
 =?utf-8?B?ckFIVlUveWtPYUJZS2w0L0QzL0xseThDS1NHWTc2MGxWc3BqMnBabVUzcHJj?=
 =?utf-8?B?OHVoY1IyeFM1bDFKODFXblU0cjRoZWFxSnhVc0E0cHZndVdTVGd6YXBvMUdv?=
 =?utf-8?Q?qgL0mRtWoLIextBLdLrIzoCirrA+bdzz1H7VUEBAERPj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b4c8bc-8789-4944-ff69-08dde4adfcc8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 14:36:47.9737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvJeyZKkP3h2SbQI+bcvljA8Wpve86eM6NEq44GH8JhhjidtxEyLaNLLFSJLZtma25HZrnGRa0TsPKP1RXiRig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8317

On Mon Aug 25, 2025 at 10:24 PM JST, Danilo Krummrich wrote:
> Add a safe Rust abstraction for the kernel's scatter-gather list
> facilities (`struct scatterlist` and `struct sg_table`).
>
> This commit introduces `SGTable<T>`, a wrapper that uses a generic
> parameter to provide compile-time guarantees about ownership and lifetime=
.
>
> The abstraction provides two primary states:
> - `SGTable<Owned<P>>`: Represents a table whose resources are fully
>   managed by Rust. It takes ownership of a page provider `P`, allocates
>   the underlying `struct sg_table`, maps it for DMA, and handles all
>   cleanup automatically upon drop. The DMA mapping's lifetime is tied to
>   the associated device using `Devres`, ensuring it is correctly unmapped
>   before the device is unbound.
> - `SGTable<Borrowed>` (or just `SGTable`): A zero-cost representation of
>   an externally managed `struct sg_table`. It is created from a raw
>   pointer using `SGTable::as_ref()` and provides a lifetime-bound
>   reference (`&'a SGTable`) for operations like iteration.
>
> The API exposes a safe iterator that yields `&SGEntry` references,
> allowing drivers to easily access the DMA address and length of each
> segment in the list.
>
> Co-developed-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

A few minor things below, but:

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

Used successfully on nova-core:

Tested-by: Alexandre Courbot <acourbot@nvidia.com>

I still see mentions of "type state" in the code (and the commit
message), is this on purpose? I still think this is a misleading use of
the term, but your call.

<snip>
> +impl SGEntry {
> +    /// Convert a raw `struct scatterlist *` to a `&'a SGEntry`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the `struct scatterlist` pointed to by =
`ptr` is valid for the
> +    /// lifetime `'a`.

Shouldn't the scatterlist also have valid a dma_address and dma_len?

<snip>
> +#[repr(transparent)]
> +#[pin_data(PinnedDrop)]
> +struct RawSGTable {

Even if this is for internal use, I think a short comment explaining
what this is for, and why it needs to be pinned (pointed to by devres)
would be helpful to people looking at this code.


