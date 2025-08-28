Return-Path: <linux-kernel+bounces-789867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F112B39BDD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03CB1C81285
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D925F30E854;
	Thu, 28 Aug 2025 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="E55KFruP"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2091.outbound.protection.outlook.com [40.107.20.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6128B2DBF51;
	Thu, 28 Aug 2025 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756381415; cv=fail; b=DFP/Aera9Rc/LAe5eH69ENGfF8R9fY4WdhpqFu1wp6ZppZU8EkhSTCyKItt9W1+lutpB53ed0fULJZtB9e5XQq2vD2mHJFFw+hr7VWRVPDuAcCS09aFYoj5nc8gfP526t7jCuzMj2ylhPteKmXH58oHRosJJiq0OaCuwqUJ8Lzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756381415; c=relaxed/simple;
	bh=EWwPBXbCB5p6W+U/EqwUEIVPeXzqKjvRlTC1BNVZeLY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BcJLfS5GJBHO4Pne2gDdd3mmuE+5qJkxty19ggP/zEtgulJ2uVN9GeaOkN5Wz6PQlTsSvxi63+ykhnpI19eJZWzx8gsUwXLh1DaRJFvkD4F6V/Hx2OiJEzbcqq7JZi807q5aqK+gKTBelNWwm+mc9aAshDdwQ+Z9iZ8fYYperck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=E55KFruP; arc=fail smtp.client-ip=40.107.20.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfFtcOdMxWPnSFxBgKUQuIvHU0nEu9a8sXPx3yHJKA9ymwYnIKaNIpsLrkzi69Ct56vSWDl7XrdDrjtrhlh2JrjJ3cxaU/B4hl9IRLl3teC+2FsmrQET0x0eonhyVW8prNul2CLsDMbthoPp5E7wAq+C/FABItqVM5r1lS4XiI4QHIwm/HoLVRXuWJr5D80mTmCYulS1vb2n8taexOlvyj8ihla4fow/Pmtms+OkScVgZn5MkPzQsSeQJpPqzuByN6xDxmG4KcFQzpw9Mjd99Ij1bE7LV5WO29zvK02MDPg/PgaQ6cg8zff9oZ/07N4Xmu2giemO9fCgLYPBPzIVjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeXWX5I7yX5TZi5lwwm7rQa4l5Y7m+x+zhJ9GQ0TtrQ=;
 b=O0l3XOcds0X7wT3Ria9fUqUjCXGKem7vsxa99BGSesGl7KJd5kR6qbKeLsKvDok13KfiEUBZMT49Hx7mIWz2H6+UW+PCFoLa2dDHa933LQBABD1DUZGxpHemrgx9P6ErTEqUT2NVJCEqKqrkpgaBfHd+nW8937pFxO6zipPhbgF+3YajMoEQQp1mvNgRMqLjqhJ2MHJbNN1RFzlvvktAgYJZQzSOLDysxL037ciuP7RRE9ucsK6S7yed4fp/qHSGn41YqSgbRfZ69Ss5wgt+7mWIwCOxP5IiC8Hi3UpnDyAZijUfTuVe7Fj0jeJFJ2a15dECQdbP8JC9Zu0zEIoNkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeXWX5I7yX5TZi5lwwm7rQa4l5Y7m+x+zhJ9GQ0TtrQ=;
 b=E55KFruPyxKsWPvZg2qPHI0MdkplEw8qH7pcPyohMqyf8yXKdzpz0j671oQIvH6btN6wdFUAzr3X6y43PxiV4Mnx2Y71vBnUByOgW6shtNbiKhDuxgHcZhYKrN+i/OfFTn5ZxdJapozo8/DuuKJsa3KgoA+uJC0Bl+WOv8fbm8DNvrw8w/eo7GcbOnNpiXD84qXDc0r0LUk44mayN11aoCgYipwF4ITFkrnOKKQlYtwsa9xifp3Lj8iBVhAREF6dh/8NHCncobQRjfDt2m8bvUffXLFTriN9Doy31TQ1nRJh23OeYTJ64EoYrHP0qTTfuFwtmQV2q0BfduZo/myw2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by GVXP195MB2483.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:1b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.14; Thu, 28 Aug
 2025 11:43:28 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%7]) with mapi id 15.20.9073.016; Thu, 28 Aug 2025
 11:43:27 +0000
Message-ID: <10fd09c8-3dca-4e26-8e0d-330cf1301d05@phytec.de>
Date: Thu, 28 Aug 2025 14:43:24 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/33] arm64: dts: ti: k3-am62: Enable remote
 processors at board level
To: Beleswar Padhi <b-padhi@ti.com>, nm@ti.com, vigneshr@ti.com,
 kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: afd@ti.com, u-kumar1@ti.com, hnagalla@ti.com, jm@ti.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250823160901.2177841-1-b-padhi@ti.com>
 <20250823160901.2177841-7-b-padhi@ti.com>
From: Wadim Egorov <w.egorov@phytec.de>
Content-Language: en-US
In-Reply-To: <20250823160901.2177841-7-b-padhi@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0111.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::40) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|GVXP195MB2483:EE_
X-MS-Office365-Filtering-Correlation-Id: 689db382-f235-40c4-574c-08dde6281a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWRQU0crWVhFa3VQckFscDY4dGxYaHlvenJUb1ZkUXZITTY0eFg0T2hjcHY4?=
 =?utf-8?B?dG1IYUZhOUpVSWRxTUNZRXZRQko4djJIMTJwRU5Zcjl6ZWZ1RVFsS1Bva2Fu?=
 =?utf-8?B?dU1JVVNORTdHanUwT01ES2VXM2JBUnU0cGVtdGppa2R5eHhZR1dRQkNPRWZ6?=
 =?utf-8?B?TU1pSElyQ0hPcXpUYkx6SDcyOVdpL2ZmSDFZVHM0TytReWVZcHlJZG5LdmRC?=
 =?utf-8?B?WFkxd3Y0UGM5RFNPb2JaVjVtSnA2T2p5QkJMbEV1aEhjY25ZQzB4aVJxVHlk?=
 =?utf-8?B?Q3RuK3JQOXlucUZhQk5XV0kyeU92R0dKcnk1V3RyR28zWUtyRjVIbG5kVlgr?=
 =?utf-8?B?Y1FxV0lUUnlBT0M0aUpnUXVRL0xRMno2Rk9sWEE3Tkc5a1NyZHJtV1A3dS9T?=
 =?utf-8?B?WnJuVjVZUkI2MDM3em43UXhLcnRicG8vaVhxUHhFSTE0SEpQUlhNMzYrWXN6?=
 =?utf-8?B?Z2JuMEt5Y2hDS1RaUWExYUdtS0lYOEZnZnhNY2l0dmFDTnBSUDB6WDBUb0p1?=
 =?utf-8?B?RnBBaEVpd0lRc3RWc1dySUQ5Zjg3S1VVeFdzdVdBWFI2bExHeC9qSDlmc2tu?=
 =?utf-8?B?Ukd5bFd4dDRjTVFUakVQekNXTUpTSm9XdGloSnFuTlhyYzRJcko1eXNCRC9l?=
 =?utf-8?B?TzR0TXdubjZLQVlGSjF5MnNWZlJXUTIxcXhCRnZ1MFlxb05SSk5aWFVqbThS?=
 =?utf-8?B?dE56SHg1Y2RzdDVxUkI1ZFdNdlFqaXlLa0hwSlUyMHJJRGI4ZEhhRUw4REU0?=
 =?utf-8?B?cktRUEFsa0FiaUpkd1Vpbm9Ed1l2V3NVY1ZBTnhCcUw2SENrNG9uNEhBVFdI?=
 =?utf-8?B?eG4vNFVzSTQxZnFHL1pjeTJPNkZwZ2s4N3pBbGk3VytPVHNMREU4RjVjTnZI?=
 =?utf-8?B?MmJueFMzd2NJQlFOM0J4K2ZqNnJQS0pqWitBbEdMc1NYUDhrcnB3MmgyaTFi?=
 =?utf-8?B?ck12d3hPcjYwZlpkdTl0WVBDSjgxWlczWUpVNlQwZ3djcFJnNzM2dXA4T3FE?=
 =?utf-8?B?NUxPVzJ1QWNTTGRXdmJieEJPdkJyKzc3M0lSWWU4bGg4Nyt1M0U2SXhHNjJJ?=
 =?utf-8?B?M0RwNUhFaklqU2N6UGFNenR3WEtXSDJCMmtnVEFKVWpOcjgzN0FydkxBVEtB?=
 =?utf-8?B?Uys0b3JPQ3pCcVBVbzRlMVJHNHFQK2E2a1F0cHJ4M1dzUXU0ckdDVXl1YTZT?=
 =?utf-8?B?S3E2VXRkREtLclpRejMwOVNCVVJVNnVoa0VxTnZsaXg3QXRKcGVrRjNWd2pn?=
 =?utf-8?B?Zmt3RFU2ZFRVWGhnRjhERXR1aC9tR1J5VC83M3hpS05jYXRaV09iZFFqL2xP?=
 =?utf-8?B?VVBXWGdNSmQ4VXFkbTJ0NWUwRXMwSVRxZHQ0bFpqL0YrRHdYWlVreWt2UVZB?=
 =?utf-8?B?WG1mWnZ1YzdPWGlFdHRSdEtRQmd6c29DL2dTSnB1NWZpUDhMNHM3cy9Yc3k2?=
 =?utf-8?B?TVN5RUtIbm1xdUhoQ1FnSCtnbkV0TFRCZmp1anB2cWlGQ2swZjRqNjYxcE1y?=
 =?utf-8?B?Vi9oaWhNT1F1YVo2MmI0YnV6SDlYTGNpRjEwL0taOStPUDlaWEYzWTliZVFR?=
 =?utf-8?B?SFRtUWtDeFpwUTFyRkk2SWhkVEtja1VMcmdXT0p2bUZjWXlGbURLbi9xNSsv?=
 =?utf-8?B?bENTV1FoYk1aTnJFek1XWnhpMWhBUkh5QzRZVDZyU3JvNlBIK3ZzSmh4RExQ?=
 =?utf-8?B?aEtha0Y4ckZ4VFdHSGl1Ump5MU5PRWhRWUh0dG8rbFVDVERyTE83VFRRTFJK?=
 =?utf-8?B?QUgvbXQ1UFpXTStrL28zWHZmUHBmcGhjWStqMnE5aFlKN1pWVTFDWmk5ZzQr?=
 =?utf-8?B?UTAxLzE5Q1BqdmowNjNUNVBlTllWZW1GYXZicmZJS1BRbnBZTldldS9nZDF4?=
 =?utf-8?B?elBtdkI4ZUNNVnJkeVhPa01sbUdLb0N4QUpOSEJkdUVPc1VWYjVXTVNxdFJQ?=
 =?utf-8?Q?3xgsZE4kqrc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUZMbi9SSm13OXBsYjRza0E2OXJIbDNjMUNLUjNtSWNJREk3Q211TFdadHp2?=
 =?utf-8?B?RmJmMlJyaiswc2RmUFkxeUtCNExEQUlxTFVVTnZ2bXF5aXNIY0FvcjFmTE14?=
 =?utf-8?B?SlZBbXI4YlhTQzZGOXhFVEcvMmV1RGVWVjZYKzVNb3doZjQ3bVVCVmVFVytL?=
 =?utf-8?B?eU5kaEVORnV0bXE3UTYrU0dZMnRIWlR4SEZwcXZTZXpPVDRPRVNZaW05VlZC?=
 =?utf-8?B?TkN5U2gxVUdCSXV5STRBSUp0TmIzQzVlV3Z6aklXciszVXNraFh4Zmk2eGtU?=
 =?utf-8?B?eEdmazNJNFRnZGRhRjJDYUg1eHNtQ01pVkNpam1iY0JSOURsR01KempTa1V5?=
 =?utf-8?B?L3BZZUEyUW1NNTdRc3ZIZ3pYcjhUeGQ5MVJWelQxM0RDMkRMNVJlMWpvUmpH?=
 =?utf-8?B?VXp4Y3E3NDNOOXErWWp3VnBRWmpPcHFGVVNFdUYycUpnZUpLbHdEVzNQTDZV?=
 =?utf-8?B?Y0FZWXJyVHdHYlFPOHlWZE4vejBuSm1FZ0NTN05ZWlVjUlhhaXIzdksxdU9N?=
 =?utf-8?B?SzZsenFURFY2V2RSQ0wwMk9PNkM3cGUyQTlhdmZVdlBxNFJqQnNHcDBxaWRG?=
 =?utf-8?B?OExNZVFVeE5zdU9SSFMvQmpZYW9QeWlrak9iWUpKaUxGcnZWRkFBWDB1My82?=
 =?utf-8?B?cWpJYmRzZkhnS2tmTnBsT3hsRjlQdnFQMEwvTmlubndWd3EzTVlBZzdoVWNh?=
 =?utf-8?B?M1htbDZGMjN1aUVkeGdlT01YdE83ZFFMR2FWTklwdnYrZTdRL3RyaU5vYUZu?=
 =?utf-8?B?SUlDZGJ4YVJ6QUJPdHRIVnNNeUpRVFJLMVJna1ZNcUxpRExHRWo3QUZtYUVv?=
 =?utf-8?B?SDRsM0VPeHZJai96L1VTZ1MrNWVPMnVtajVldGs2RDJSc2xUVTZ4UlJMWWlG?=
 =?utf-8?B?NGJJR2d4RXQySi94bHZOU242S29rWkhJeUhsTzhkMGpIVlo1TVlPc1N4c21m?=
 =?utf-8?B?Ull6bGVLZ29mTjZtak1wTVFmSkpDYWVCSnNYbmlMbHpTQ2ZQQ3JCTVd2bXEy?=
 =?utf-8?B?RUxkSGdjbEpYVUZ0YVNpOUNpbU9xUDFJNWtPaVY5WFVZY3poUWt1cEtrTGQy?=
 =?utf-8?B?MlF4WEhyYWxrMlc3REVnNWgveGxLWE5JUk1INGplaitVUXhDSy9FSFg0Nitn?=
 =?utf-8?B?Yzl5anRNU3lpMklFaVJacTV0VGRZNVJUek9JMFZ0eFNtMk5CNDFHLytUQ2pv?=
 =?utf-8?B?RnlSV05ybzdvaDZheTZqcEMvaUdOVXBkY2FBRDJnZzlCRXpqdlUxUWNNUmFi?=
 =?utf-8?B?TkJsWnNKaTl3T3B4NGxob05qbGpSVi84WTBBT2F6MXlwVVFQbWdNQWNtWXF2?=
 =?utf-8?B?RTkrekpLOGZXSURNSlV1b0tlMDVaZ21YK2NMSGh5ZFNTUWI0YVhwVkVkL05q?=
 =?utf-8?B?K3IrSUlxZWlsZCtVVGpPWW5yRlhNWHNDY3hRam5NTWRHOXV6eTJ4OGJSZ3R3?=
 =?utf-8?B?U2lKK0s4VTg4ckQ2cDh6REN4UHlNZDhlQ0g3OFZTaE1leFZoMnhTcHc1VFZy?=
 =?utf-8?B?V3FIdTBOdnVuL0FxOG16emI0bzJyUnlicTl6RHZXR3ArM0gwcS9sNDlUSzUy?=
 =?utf-8?B?Um9PMzU2cDB5RWNmZnpzUng1Z3N2RndpZ0dDZVBXdi9ObkFma1dlVHlxS29G?=
 =?utf-8?B?Q21vMk11RzV5OXpqSXVQWUkvaFJCRmV2RVMzbGRjbFpVMWZEMU5KL1VHTFFt?=
 =?utf-8?B?QTFOcyszU0E5UzBTMGFSZ0xIVHZyNGhNTjd5K05hUlN0SmkyL3NBdDloNHZH?=
 =?utf-8?B?Z1V6ekF0RUtrN2M0Y3dqNGZ3ZUE5a2dNSWh2MnMvNVAxNWJpUzgrSkxGdHFv?=
 =?utf-8?B?SmlNUy9KRXB4dk54U3dSWkJGMlFHTXUzM0R5YkJ4c0p2K1E2T0NScUx4cjhu?=
 =?utf-8?B?bkp2amtJSEQ2dXJYcW4zUUF3VDdid2c3R2pHcCtDc3dRcmRRenlndEJ6VzlC?=
 =?utf-8?B?ODB5cXZNS1Ard1B6NlBzbkwxcFZBT2VLT0hGNUMwQ0REMFB3Sm14YWZ6NlJn?=
 =?utf-8?B?UGRMU3I2WWlEalBCUldWRzRSRW1HdkVUMXdWQUp6Sk5zRThEMEZNSkN0WHlm?=
 =?utf-8?B?eFJyMmxaMkJLZHRaaU9oMjBzc1pTVlpPZHpWRjZBaEZBM3NGaUN1bUcyVGVI?=
 =?utf-8?Q?Qar83WJeapflP2XEhokw3aFwB?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 689db382-f235-40c4-574c-08dde6281a57
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:43:27.3432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgIUWBOiZoz9gmJ5xf9dk91f3pc64hnaKfoED6qZHuUS4XkNyt13NTRWmlyvBavpXXtBEpVcDau2uSTDQ/Znlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP195MB2483



On 8/23/25 7:08 PM, Beleswar Padhi wrote:
> Remote Processors defined in top-level AM62x SoC dtsi files are
> incomplete without the memory carveouts and mailbox assignments which
> are only known at board integration level.
> 
> Therefore, disable the remote processors at SoC level and enable them at
> board level where above information is available.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
Tested-by: Wadim Egorov <w.egorov@phytec.de>


> ---
> v2: Changelog:
> 1. Re-ordered patch from [PATCH 21/33] to [PATCH v2 06/33].
> 
> Link to v1:
> https://lore.kernel.org/all/20250814223839.3256046-22-b-padhi@ti.com/
> 
>   arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi | 1 +
>   arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi      | 1 +
>   arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi  | 1 +
>   3 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
> index 10e6b5c08619..dcd22ff487ec 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
> @@ -407,4 +407,5 @@ &wkup_r5fss0_core0 {
>   	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
>   	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
>   			<&wkup_r5fss0_core0_memory_region>;
> +	status = "okay";
>   };
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> index 6549b7efa656..75aed3a88284 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> @@ -128,6 +128,7 @@ wkup_r5fss0_core0: r5f@78000000 {
>   			ti,sci = <&dmsc>;
>   			ti,sci-dev-id = <121>;
>   			ti,sci-proc-ids = <0x01 0xff>;
> +			status = "disabled";
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> index 13e1d36123d5..840772060cb1 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> @@ -506,6 +506,7 @@ &wkup_r5fss0_core0 {
>   	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
>   	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
>   			<&wkup_r5fss0_core0_memory_region>;
> +	status = "okay";
>   };
>   
>   &usbss0 {


