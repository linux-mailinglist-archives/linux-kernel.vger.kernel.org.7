Return-Path: <linux-kernel+bounces-892285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5E6C44C37
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 03:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267203AFBB0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 02:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4C321B9C0;
	Mon, 10 Nov 2025 02:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pZOTquPB"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07412BB13
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762741114; cv=fail; b=o57jg3iFNm0WhxGAnQoOlwPVwtoMy7zyxMK+Mnu18HVUSBuDULzl9zzTD466/Ky7HzgEw2uj0sUcOPdSkUSQZjb5KSJJV9kYdfNi71Cp6ynOmL6hwuBmcyTwXILRXWqhNdYnG3f4M2pA79oaefXlHe3amus1b7O1XHvqes88j0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762741114; c=relaxed/simple;
	bh=9JQ7WGgaE0uihkVaJTmpUrd3HFLdA38AF+Xt5qUO/O4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bfOErrJDqcJB3uN8Mpgg59OkRp2sIWVsaH1DpKsfJvdvGdBJyDCmHRFSVPdcIbWfQqjCVaBmyzZK2eIE9/g10oPZJ/XXUM+DCeOnN2ZihF+MAhnCHsTv+SHOuU6XxUXvKwCVfOf3MxPuixegZYlE8IVQvBwrwra01Z1EvyLXRQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pZOTquPB; arc=fail smtp.client-ip=52.101.48.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljv+TKKromgjTbx/XfEM0g0wU0AhuX5aUgKmjV/BF0vDrsovCoSLKhwEFQsOZhUBwLMSUDHwqcSBZzzoHrZ7RAeK9KZTe43jsHixkOO/8AsVmsPHfY8cXqpDwE3/HGQObakb8LM/8DgzelOS27X+7pHqcveFdpmaWHMF/UgTJfHgv6EI0/RBhNwt8dMV/OU4ZQ+PQICF3hjMEaBQ2fCCQwMZpTJAM36AGSogAPzyCWPtQVDZM6PvXhCDnB3o3/0Uz5R2BS2MT/yIlY2kWykB9doOJsX5eWwnBNNOKtmSqNaSuQ93TzFSPPOiDUYOL0n7CULC78QiknwUWfu8e6Q0tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKF4WNocWRy2H2xqYkgH3+NKN2/Zsd0lsDWfa27Z71E=;
 b=xNrEDR2kXdBLIsnNcIp5IOFoJvDprJMYl8kxYafoaW3/Qa6fyhbSWg7sAGRrChQLk+LzMxLvHeKHFgPzo0G3iqf6A0FOzOVxWVNr0B5NyhTfNrZRHzqODJsGSC8GGLj6380Apr5dACVm7IgTajY1RjwwT1wm46k913Np3SsyQu0URD1LmpnH1bA6PXTxk+8DP1UZiYGyl9RU+fHDIlMEVXNyWdQZ5sXEZ3raBidlHBcJWmdx0FpfcRmqSYSFE00VJ3nYoTrItNLN3gjilFyc9ZkptItAmFuT8ID9KdNGjUTXM6ozpWR1ISwUiBiJ+rwvSVL/fJa05jW/ycI6lv4zOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKF4WNocWRy2H2xqYkgH3+NKN2/Zsd0lsDWfa27Z71E=;
 b=pZOTquPBIjGgahe5Qx9X1qkBPt/IU1xZ23WYBETzIwPEIyCVvEGbRAnXScE/JRIXWD8cAKVj02H5eGZ9XLnwtCZepGrlIVxfDIT3I7yFT/6wOdZ/DeXMUqaqFF9KTeW2X0lDkVw78nyp68WnEjfAR2HWbjK3yzwh7SQAq1oXn5NCl6qzy7CBXSIYEzvpG6T4uf9qbnYtjZ3OFSgwoxW0vKwXyw/PDkap0cIN6cyc585xJOAIHavdhhm0H2Z5DNZ85L/J47eAsv56v2BHD66CL5Nc+Ksbj/9SzeuZnoPQ53HJR1zJezG+irzKi6xx7aq81SiX2V94S/Lm4VU1UTUONg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SJ2PR12MB8740.namprd12.prod.outlook.com (2603:10b6:a03:53f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 02:18:29 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 02:18:29 +0000
Message-ID: <0469ded7-aa2c-42bc-9a5d-6fb16288ff0e@nvidia.com>
Date: Sun, 9 Nov 2025 21:18:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add Alice as a Binder maintainer
To: Carlos Llamas <cmllamas@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Christian Brauner <christian@brauner.io>,
 Suren Baghdasaryan <surenb@google.com>, Alice Ryhl <aliceryhl@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org
References: <20251107224824.644832-1-cmllamas@google.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20251107224824.644832-1-cmllamas@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL6PEPF00016413.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:b) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SJ2PR12MB8740:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8b5d30-cfe3-4cb5-9c85-08de1fff702c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFl3MFlPcHZpUU4vSE5qUGFHV09nVTlKazB6RzRSbEExaUVXUXlnclM2OXcx?=
 =?utf-8?B?MTduK1h3VTRzdDhFcnlJZ0lFTXZSZ28vVEpuZjhyVGRTeGxpL0RPT09PWmd6?=
 =?utf-8?B?b1R0dHduSTZFajczbG9EMURsVm9qMlV5RFZxL2hZL2ZDOHQ3aHVpRE82ekxJ?=
 =?utf-8?B?aHNDcFE4V3p1K2RJU2FJYjhndkpwT2YwSFdmR2JUNXNMY085UktTYXVhVnBE?=
 =?utf-8?B?NUFicVNCMkRxRUo3ZytGNmE1a01xeFM5dmQ2ZGo0MXhWY2hvVFE0TEVZQ3hI?=
 =?utf-8?B?SVF6cnJnaWZnN1R3aENaR0hJLzY5dVo0T1ZNeFYrS21mOWwyNHAwWnRPS3ZR?=
 =?utf-8?B?Ly9za0xySjBDYTd0eXgzaHZyRFN2UXp1QlkyTG5mOFZDcTN3akZrbDQ4NEN2?=
 =?utf-8?B?WkwyWmN5YjdzMzIrMGNER3pESENBdVFRdzJMTnp3WWl0UlFQWGpXbTY5RW9D?=
 =?utf-8?B?aVkyUENKeXpTb1ZtRzdVUXJKL0RQNDJnQ3JMZUJYNTl6djY4Zy9tUDlaL1ha?=
 =?utf-8?B?ZWRhRWpSY2RRWGkvSFBNdFkwaW5wbHVtbjVNTXlpVnA2Z0ZVbmlxeFoxRnBK?=
 =?utf-8?B?d1BxV3ZNY0Fhc3VpN2dVc2I1VTFqeHQwMHVPdVU2RnlGYzZuWlNoYVZEYmY2?=
 =?utf-8?B?TWo5elZDYm1oZ3RBQzA2dVVoM0VUSjM5THZGL2p3aWF6bFMrNUp2WjQ5dU4y?=
 =?utf-8?B?S2JVcjVQbGJpTTRFbjlYdVk3cS9XeEpDd1o4ZHVidUZRbTI0ak44SFVobzhR?=
 =?utf-8?B?YTk0bDZPMjFCbTdsSzdnS2ZhQmVyRjNzdlZXazlubWVXNnFtN0NUV085bmlX?=
 =?utf-8?B?akRUQXV1dkZGdGV5MmhYU1lTV3d4bGI2U3ZkSE43RkU0elN4TThyUE5UQ2sz?=
 =?utf-8?B?RnQ2RlowOXNQVGhBR3pCbC9iMmZYOS9PQ0Q1SUNuSXphYWhITFQrZXhEcU1E?=
 =?utf-8?B?d3RSelhOdktLSVFlR0pvSWsyNjZOY2tMSXZobjlKNjg1SXdYaE5wdlNuUjZX?=
 =?utf-8?B?SHVVNnRRUzYyWEg4N1hUakE5ODNLM0dBUW1FTEY2YWRkK0wwUWtSZkFPV2R1?=
 =?utf-8?B?VDZPVnE5czF5RktzOS9mbUIvTTNobGhHaDIycnVwelRXSlpLZisrRHdadmtj?=
 =?utf-8?B?K1JncUdBRTd4VXdxWEUzM1VOMS9aYVNzVUZkR3kvNXZHUEtqQTlYS3JZNzQy?=
 =?utf-8?B?T01zMXR6YVFJY3dXcUdnellYRjhPa05JVFMxZ0owWU1qYlc5VUI0WUgrREhY?=
 =?utf-8?B?dVNXdE9hZFVQRmNLbEVGUjdtbDBiTFZwZTQrdXJpUElNL2tVbnMvSVhqVjFz?=
 =?utf-8?B?dWk2aXdRRUE4clF1Y3hZMWJ0MldXOWtZRDhmS0lKN0NwazRvbFlRK0wyYzNC?=
 =?utf-8?B?QjVuemFHREQ0bHM3SFVJaEp0aWlWN2JTanM1cEJJTHl4UTF3SXA1RGNDT3ZE?=
 =?utf-8?B?clJhaUVMRjJSMnU0cjBEY1ZNcFhZYjUyVE45ZU1UclR0Y2FvV3dkQ3gzWlNI?=
 =?utf-8?B?bjRPbXlSZUtQUE5NSHNKbjZsSnRzOVdnVGI3dC9ybTQ4K1NPa1o4VDY5T09B?=
 =?utf-8?B?Y0EyYkRMYVp4OUpCdDh4MitScVNZeExpSVBuRGlvUnlVbFlxdVhMUjJMWDhQ?=
 =?utf-8?B?elJQZjdtQnBIS2FXYlA4bjYvSHFIRVFDenl3SEZxMHgzbjBibUNGOEM2Ym9U?=
 =?utf-8?B?U1hUcGxkNmVnWXBBQkd2SDI3ZEwwZVpGd1U5Ulh5U3pUVFpGaGpJTDRSSzVQ?=
 =?utf-8?B?cDJVb0E0dHBaRkxwTTRTcDN0UFhlN3lXQ1ZKMnFNRW0yeGw5NXJ0cFVEckVS?=
 =?utf-8?B?Wlg0clFoTmREamVhVnhRbXIzRGk0czFCVE9kdFZHQUo5eVdtQTF0Skw3MjNQ?=
 =?utf-8?B?VzNXL1NXZEZQNTRBVGsvcFpiVHJOZkNDVkFHeEFLdEdGc3V0VUJ5WjE3Y3Bu?=
 =?utf-8?Q?G0j4wohJ+78d5hx5gsMXuJSD6lnFzxws?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S01Yajl2a3dGSXBnNVRiVThkN1N5ZkZmUnhMZVRxcEVrU3M1TUErd3RDdnN2?=
 =?utf-8?B?MnRTRXluYzF6aUpJd09ZNDZUTThQYzhNbUpMbkVkTEtmdVJHdUx1OHhvcDhp?=
 =?utf-8?B?bjRKVlVoTThIZG5xam9QdmtTa1ZibCtBaXFaMnpOdFZrZkI4SURGQ3JIZE1v?=
 =?utf-8?B?b0c2cDgrN3VlWTNTK2NtM0FDRGNueW85b1BSSmhxV2VKSWlBcDRoTW1RWjUw?=
 =?utf-8?B?d2szK0RyL0pKNyt2QTZrYTY2c0xVS2N2MXV3NmdUUXZwc1lqd3lMZ0pSdUpE?=
 =?utf-8?B?Z1dDL2FZeGtLdUZDRk5sVnp3V0pWRXBBQ3lPM204aWtZTVF5K1F1YmhSZ2lS?=
 =?utf-8?B?M2NmaXNMcjFmMjVBRkMrVURQU21RY2d5ODgxZWlaSElLaGFxMTBIUi9rZVVn?=
 =?utf-8?B?UFhGbERrb2h4dldiQTFZU2x5RjdnUCtWNy9vMEg3eDkxcVltQ3RBcmFoQkJR?=
 =?utf-8?B?V2E5NzJ2YVlQY29oZUZaNkhLN01ZdW5xeG5DTlh3MkJIODV5WUl0NnBxejV4?=
 =?utf-8?B?SHJuNHYwcVI1RXlRTVdvM2VFazB3Y1FWV08xTkhxQXZJZllDdzdGY3JZL2tK?=
 =?utf-8?B?LzRVQkVyNHE0UEU0b3p3Tlg0YkxHUlA3TzZEektxSlNyYnFCcmIxVGRiakh6?=
 =?utf-8?B?RHNYWEkxN3BDQUN5bmQwSHRvTVAyVGowaXFJTmUrWjMzdloydm9tZm9TY1JI?=
 =?utf-8?B?R1FkMFBQMHp3QmpoNm1tQmJleFlVQmM4eDNuVUhIQlZRRVA0ZitnUk43QUFl?=
 =?utf-8?B?Yy9wa2kyY0xRSTllSDdhb01mSVFvZ0t4Ky83S09TTDZOcDhxZmJyNEZJV1VM?=
 =?utf-8?B?NFJsRkxWaEd5ZG5CWmZ3SUFLc1g2M3NnQ2xZZUF2Y25vbndhM1gvd2lLWldK?=
 =?utf-8?B?QlpSdERWT2tSTzNCOENWYmhZRGNuZlF4OGdHeTRUbExJZVRpRUxNTXowUC9r?=
 =?utf-8?B?TUpvUWRLRys0eWhHdk44WHkrMW9VTTBiN0ZTMXphekZQODBYcWZOc21Va0x5?=
 =?utf-8?B?QTJkQTVQakJBWjYwUngwN3NSb0RJSTFsRXFDM2dsbG4wcUI1RWtEaFpwMlgx?=
 =?utf-8?B?MkhTNEJaVGY3am9wbHJrZlM0M3hzc2NSWU0wZTM1MS9qTzJ0UzhXc3psNzRI?=
 =?utf-8?B?V3RheE1YSXlOc0ExZGNFcXdzUTEzNUIzcGlRWjNkSGdkYU1GUUMyZ21WY0xC?=
 =?utf-8?B?OWZjcnAyRHFseUw2dUFvNDNoaXBreDhIWDFmcFY4QXdsaG9qSGRLSlJpNUtD?=
 =?utf-8?B?NWtWS0VtNENEVG8zZ3RsVGx3UE43ZGtyLy9zZmNvVTBoU3RWTDdWRWJqczlI?=
 =?utf-8?B?OEZxSXk5bENjL0QvWk5mZnZLb0V1MjJ5eE5taWQ1dVFLWFRYVnJMZWQxcDlI?=
 =?utf-8?B?cjNudmFja1FKemI1eHl0eGxVZ0FLYUdCZTBpODFZcHFRdVc4L1NIZE1uMS9X?=
 =?utf-8?B?clB3alZCYzlSclVkNS9TNGdtUy9MSG5sVkhTMlBNUjdFamNIZVk1d09sTDNl?=
 =?utf-8?B?bUNCbWE1RFdCeW8xaDFLV2xEVElYN3YzV0pPN2xka0tpak53MU9oVmJMOExG?=
 =?utf-8?B?WFFpdnp2aEQ5cGIxa1l2QktTODFMTVN1aWZPdHpXQ2N1SkJ2cUUvcEE2SUQ1?=
 =?utf-8?B?SmRjRm9MNUdycWl0Q0tpb2ZvOVdnYUJ6eUFhdFFTdkE1NjdkT3ZhM2V5MGxD?=
 =?utf-8?B?N2NwTnY0ODN1YS9WTDJaNTMvSUtuL0JFb2o1ZzFKUjNxSnVVS3ByRkF5SXlB?=
 =?utf-8?B?NU95MHYxVHVTNmljbk5mTUltS2VUaStmd1RiOTZhcUZ1M3VjRjQzMGVoeXdT?=
 =?utf-8?B?a05XWW9XNFBmaXJCNWFrRHl2SlF6MnYrVjFrMnZqQmZYcEpDSWdBaFE1RFVi?=
 =?utf-8?B?UnB0TkcxZnRXODlMMkl4ZHk0RW1NaTNjczdka3IvOEY1cWxteXM1b3NLTGts?=
 =?utf-8?B?bFhFNVZaY0grUFJVb1R1dld0SDNhOTRHelVDYzFBMTErNDE0YjNlM3NwMUVM?=
 =?utf-8?B?dDNDOTE5Ym9iUHJJUzZLMkNpWVBPZlBBOTlMNUY2SkRTaVBER3RPR0pna1hN?=
 =?utf-8?B?UGdlZmNSYndRUk15eXVQR251MXlTZmdYeEdwcDdWZWtNa2srZ2NzTWNZK0g3?=
 =?utf-8?Q?2K1Y8LChHWiNohpIYMGJJ+s9N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8b5d30-cfe3-4cb5-9c85-08de1fff702c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 02:18:29.4055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Y61N3KuoNk/NKDg2v15mhw8Aw7VPFddLtgr5uYHc2B2Msn/DPHtYoexpT1x9x7xI/Qn8dIjGsLHCy3K7kX5jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8740

On 11/7/2025 5:48 PM, Carlos Llamas wrote:
> Alice has been reviewing binder patches for years now and has a strong
> understanding of the driver, so this patch is well overdue. While here
> also clean up the list from folks who haven't been active for a while.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  MAINTAINERS | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ddecf1ef3bed..86f4afee0c75 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1807,11 +1807,9 @@ ANDROID DRIVERS
>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  M:	Arve Hjønnevåg <arve@android.com>
>  M:	Todd Kjos <tkjos@android.com>
> -M:	Martijn Coenen <maco@android.com>
> -M:	Joel Fernandes <joelagnelf@nvidia.com>

For my removal,
Acked-by: Joel Fernandes <joelagnelf@nvidia.com>

thanks,

 - Joel


