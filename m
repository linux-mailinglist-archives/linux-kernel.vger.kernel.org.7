Return-Path: <linux-kernel+bounces-770225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C3FB278A4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8BABA02D91
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D681FDA92;
	Fri, 15 Aug 2025 05:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="r3gmctpb"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2117.outbound.protection.outlook.com [40.107.20.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347D610E3;
	Fri, 15 Aug 2025 05:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755236973; cv=fail; b=rVja3gQCgXtZXh8Kk1lOxh3R8jFnVBJ+8B3KMnmEVG/fpjuROQeWypvgwKclyjLoQBIVJaIyHHiazE9rUTh9MIenIfYsyruhy4iVHWABkfQIHmf/6OwlzV1/Vsc2EewFWtmw+Ec0ejiwzl4tpSNSs21L00HffrnPX6OGaL9DQ08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755236973; c=relaxed/simple;
	bh=FBhfaHpZxPeGqc+9ja3dzMEEnHP5yQGe+UsI8RGpBjU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WoaLWLg5RmCYfuh87oJ/syHHTzsUToFxS30jJXCTYjfPXtNdY4s35rG7eQKh5294d7qo8VnEusOiy3wLVRXam4a45u/sRYSt9gzCFQQBiHh6wv1+A40isvRktTvnzarc9r4kVSeVxaWiCoPySLapyRdgcJV8Ilts+KIt4XoByZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=r3gmctpb; arc=fail smtp.client-ip=40.107.20.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysgIVjx/C9m3Ri3CSvhG7ExFRJ679xEhwMvMcj2LEDtqYKnv6MDMooP1Y5f49AFtG0XQk4LEAaMPHvqOA1E1IOgN5c0fLyt57aS8DByYuG3b9DuscM5HvxUD/Q+o3k9NUugFDJHZMkCqc7A2KnpS8um/jwdlI0dOHbccS2PrBH6OZ2tO2OchWNT3luu03A9mes4frS/FQFmN4RT4LLbJZd2PiNbvHniWbN4vTzpz+batT/vWYhMWfX8a6ViYXXU4M+lTzD7FxZCkSSk3+3Op19c5m/hH9LM6c7U1wPPyehiPPcc2jRpcyTb9eacrCECHyOmvXw2FH3JDf2BP3HmZLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jIej+QMl5EbjTNXnHWQt2yxmvHSfAtjdS6NkM/5CDk=;
 b=TT3ZpXctAdIEyq06Qdl3swoldeiDOGOaIawy8fD9tkrFachvPEuk7oORgJjlhXF0G0UAm48gs+4uL9UCU6lc5MIQl9EfGJtP0dqAEQ4wBeb1EQwYkYxg/f14eEM0g1WNIqReELwG8QTYvxFbnIhnxoKxtoWYbZeOlFCIQ9186mjHKey52AwKSjMJ2TW6F4DznCe+ksteERfnuxodavHdfBClMybwVe7LdCKG3LP4tJfCyvX8ufI+iv0j7+zKGPvKmlRFQ550tHl8VWZyd4V3ZmkZLXakwgfHmy2CpD4jUDs82SKGVCifPufHj2ZB+dLHOunqYKFY2QdNk07IjbR69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jIej+QMl5EbjTNXnHWQt2yxmvHSfAtjdS6NkM/5CDk=;
 b=r3gmctpbf0/2IFuRS7zHk0EGqe+hjv3AlyNutTSLtPAMn36aKFGoDhd6UCArGQRcoWtVmZ1MCeNbyeyEpUTAJGhtyVnf2nTjih+3iF5jZaPlOAoPYRtXyj6SMgh+QH6ZIEPE2MRF7Y4VaRqyjhAQoLT20wQniRvyaxEYndwhuyg9LL824Zvyzdg5AcfngiRTsfedpRQs9WLliYimeh9E1+LmEv7/B2Mvxg0cjbSRuOjmcTQoFwTPydOXehR0DuGIFUwllVLHZDKN8RDobFeFud181RIKnUp3CFs0nuZK2e8RMBvqKlKu0WQYTOpZjtd0aklkQUE2sH6y7zkUAflcaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by AS4P195MB1477.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 05:49:26 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%7]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 05:49:26 +0000
Message-ID: <2c3d31f0-e690-4e67-acfa-931fca47dfeb@phytec.de>
Date: Fri, 15 Aug 2025 08:49:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] Refactor TI IPC DT configs into dtsi
To: Beleswar Padhi <b-padhi@ti.com>, nm@ti.com, vigneshr@ti.com,
 kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: afd@ti.com, u-kumar1@ti.com, hnagalla@ti.com, jm@ti.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Robert Nelson
 <robertcnelson@gmail.com>, Jo_o Paulo Gon_alves
 <joao.goncalves@toradex.com>, Parth Pancholi <parth.pancholi@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Logan Bristol <logan.bristol@utexas.edu>, Josua Mayer <josua@solid-run.com>,
 John Ma <jma@phytec.com>, Nathan Morrisson <nmorrisson@phytec.com>,
 Garrett Giordano <ggiordano@phytec.com>, Matt McKee <mmckee@phytec.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Hiago De Franco <hiago.franco@toradex.com>
References: <20250814223839.3256046-1-b-padhi@ti.com>
From: Wadim Egorov <w.egorov@phytec.de>
Content-Language: en-US
In-Reply-To: <20250814223839.3256046-1-b-padhi@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0109.eurprd04.prod.outlook.com
 (2603:10a6:803:64::44) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|AS4P195MB1477:EE_
X-MS-Office365-Filtering-Correlation-Id: b65535f6-42ab-43e8-4e69-08dddbbf7e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEJIZmJzMkc2U1FyaGtNbVpNYmRxam40SFR2SW56S1RCd29kdGNzU0FvMGxl?=
 =?utf-8?B?VHV5bmFPRTgzODZSdG1TVnZMZmhzWVZkWXNMVUI3eGJmczZTOERFOGJhTFpp?=
 =?utf-8?B?S3NJMkp6dnJFMVhpemlrYVo5dWNnM0dQMnQ0MFBNWHBNMjlZK1NFT1RxMmJ5?=
 =?utf-8?B?TEhLMk0xaDAxbXlxeWQ5bkpVeDdUZ1gxNmZNQit1dVJjQzNoN1krOW81Z2Jw?=
 =?utf-8?B?TTJXdEU1ODZZRjFSbmdZSitDVHk1bTBsc3pQUGt5T3RPdWxEZWc4MjFhanZ6?=
 =?utf-8?B?UDErRitoNjBqdVVHM0x3azdKakhDTUEvWGx2RkdhRUtqdGs2bFRkMEQwQnBx?=
 =?utf-8?B?UVpCYWx6YW40R0JIR0ZYWDcvVkVHSnA3Z1Z1VCtReDBzVEQ5K3E4NFV0R01S?=
 =?utf-8?B?YWFhWXdpZ3RYUVdNallFR1dTWXZNWHI3SVVSR0xIQTBOVlQ1REVNVVdndVRR?=
 =?utf-8?B?THRaeHR2SlhVTm1KajVnb3BKVTZYODN1OXRWbGFQQkh3TkNkR1YxdXcwSEF1?=
 =?utf-8?B?L3ptNkNRK04ydUt0OXdPV1VVcDhNNG12LzFqdUhEYlhhMDBTd25Bc3o4Rm56?=
 =?utf-8?B?ci9kWVROdE40cmlGOXZsZ0RzeVZvV3BSSjJJR0dYN2ZNWXpwSGVpTThxakFn?=
 =?utf-8?B?NEp4ZzVaUXZmdSt1Rk16R3YrNmRhVnA0VEpLWHJuV0ZrYWR0WXpnZi9Sdkkr?=
 =?utf-8?B?dWdSSmE1MUp4RmhGS1hmdlJBZkZwdjFGRWN4ZkZhMnVNZC9iMWZZaXlPYUFT?=
 =?utf-8?B?LzRYeTBaZGJSQThJNk5kTE5YUHlESXgvWmgrM281TnZXOW5uaDZmSFduQXpD?=
 =?utf-8?B?MGc4Y2ZXSDA2NHJpT0lzelVFMEVISzUxMURKaVgwL09WaXp5eVNoTmFYMERs?=
 =?utf-8?B?WlQ3ZHFSWWdBYStVVU1QZG1zbWJqRVdUVWEyd0o2OWxVNEdKR0lWdE8vT1Fh?=
 =?utf-8?B?aXM3bkFyWUd4aEJGWG9rdCsxcHBNViswSFpvdnpUbEJKWlNlaDhlT251R0VR?=
 =?utf-8?B?M1pROXZPUXpBK3NsbUZET2VzaWEyaE1aV1NpMTdCQ2MybUticjBwUWQrRlRN?=
 =?utf-8?B?c3A4Y2RnWEtZMnRiY3FHaGU2MHg5RURNRmNXM3RrNkZ4Q3lvVC9JNVdlS1do?=
 =?utf-8?B?KzZmVlJIY3FTVVg5UDE1dXlyZTlrd0piTHhyVWtMRS9YNWxYM2hNRmV5dzEy?=
 =?utf-8?B?SXlQV1ZjMGVYR3BwWGM3UGtmOGFENWZaZlczcTVEb1pHTENOMFROMi9aNjJ3?=
 =?utf-8?B?aHVkVkMrSFBsWTIzYVlhcUJoTlZEYS8wTmFTemFNQmx1dXNIeFNMVFBrRXd5?=
 =?utf-8?B?Vk0xT1RhZ3dXSkFnQ3FUSFZUNVVKWHJQVnUwMVlNR1pRVXRhOU5pY09ZdDBv?=
 =?utf-8?B?d2huTkVybFpZWXBwRzBna1BwaG9IWUtNQklDa3YvWDhlRGdPNU5saDgycm5v?=
 =?utf-8?B?TFZ6blloaVlMSmkrUEJLTVZlVWNEeElBelJsR3gyNGJJVWF1RFgwUDNHMVV4?=
 =?utf-8?B?OHlCclBRbEVQd1JvdWRCb1UrMmpvTmlRTWJjaWNmc0RqM05wNkxCRk55QjNm?=
 =?utf-8?B?K2orSjhRUlpZY01OblF5L0cySWJtN2RFWGxYQkErUVRpcVRLMmg2WVZLZWhq?=
 =?utf-8?B?K1lDa3Vza1grSHZCY0NRdk1QZEx0bFZTeEVZOEN0UU1sRzk3L05xZnUwdmJw?=
 =?utf-8?B?YUZVd3BueFRXUHNudHVJYVJpMUFkNjgrR0VTb1d1RFFUdm9WS29oOXNzdlVr?=
 =?utf-8?B?aWdDa0IreGQzMDlOQ21TVnBiVGNqVHQxWlQ4ZFE5YzVsZnN3aTBDQTFlT2Vu?=
 =?utf-8?B?QkNQUW1tME5TOVBGUkpneUw3ejAwcGtMZTdFTktCQlovemVoVmlQZjcyL25p?=
 =?utf-8?B?ZHE3R05zbWNLSDhSQzE2UmkxL1hhUTJPdTVYalhQeERzZHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjFqSFQ0bE4zaitLYWVLRkFaT052dUlTRnF6ZkhsZklobXRLYnZkVjdFWkx0?=
 =?utf-8?B?RThlNDlUSHp6dlM4WjMvd2NZUk1BRFJwazRrRUpFSDdvcUlsS2JjeThiSmxY?=
 =?utf-8?B?dE90K1g1VjA1dkVLT0xCbVhVYjM2MC8yTmdlQTV1N1VqbnBZbGg0NFhxa0RP?=
 =?utf-8?B?NGRrQldpMjlDcXNVNGJ4bm11RVYxaFl5d3cvRXVObFpsREcxQXZNaUR4Rloz?=
 =?utf-8?B?MnNKeWx6VHlDNWMxSEtMdWFUVEFCVDlSTEttMWxHZlJYakxZQ09DOC9uNUl5?=
 =?utf-8?B?bTJuQmtmSHF1NzNtZDhOb2xqcmhnSW1TbWphQWp3ZmticS9DazFuRUFHM0Yz?=
 =?utf-8?B?bTN3MUQzUFFwVnQ4ODFNak5EQWxJekJvaHJCdjh4QXJDV1BkNmV0ZkVXejlu?=
 =?utf-8?B?bVlqMzJpUFJsRXFyUnhWOWkxc2l4S1dIYXZBT0lSY0FkamtwZVVGd09IRW1T?=
 =?utf-8?B?dVJpUEhlaExlNEQ4UEc5ZzdxYnVMY25SUkVWdXJZMUNzbXpOWk81ZG5UditT?=
 =?utf-8?B?Vmc4dGdiM2RIdnJmOGo4bG9zYjlUekRNNXc0enpiTHBNWUhNQ0ppVFdFdGFU?=
 =?utf-8?B?cGtwV2hjaVA5NVJFSGxReUZnb2tWeEM2b3BsZU05L0t1VWdzVFhGSVNOZGEr?=
 =?utf-8?B?MWtrRnVOd0tlbGM1VFZ1L293cU9GQlkzMjBnUXdobk5HZnJEa0xLaFlBNDBU?=
 =?utf-8?B?dTBleVFNV1dXcFk3UXRWMG4yaWVWdklKbUdJb3lhbm10cEE0YjNGbTkwSXp6?=
 =?utf-8?B?b0Z1M1lXalNTU1lUN3EySi9kWkcyTDJ5NTRxMTE3Vk5EQmRFOWlqbm52L2kw?=
 =?utf-8?B?WHBYS1lsNVZLc2VYWDhvLy8rYWY2UVhyUUhSRVppK3pyWlcyOGFua3p1VHVq?=
 =?utf-8?B?RG12bHk3aXF1ZUVTSWQvcGxTNnFwSmdhdXA5cFZjQ25rOTBGWDI4Yk1nQW9n?=
 =?utf-8?B?V3lEZkpreUwydy9lK3JGSHhSZ05MRy84M3lIT3VtMThoU3p4SHVaeGFZbzhj?=
 =?utf-8?B?M05Ycm0zVEpoTVVtNDVzdENxTjVhQjE0UFV2ZG5wNmZtSXdnNHh3Q0NxaG9U?=
 =?utf-8?B?K0dOeVpiUk9EOVlOM1UrREYvb2VRemJPYm43YklHWldDalU5VXU3UzQyVVgx?=
 =?utf-8?B?QjFSU3Nvc0J2SXRzQTZ0UzMwcnhuaFdJaU1OMDhObTVFS0piMXhST0h6S3lL?=
 =?utf-8?B?cm1rTFZHN25VQXlqaDFKdzlBeGRuRWZhVEYybHg1ZnVGL2FkRmd1NHUyc01u?=
 =?utf-8?B?bURSY1JyVVR5eUJ1ZkNJZUJMVjVyUXB4NzZiM21WYWU1R2Z3akw4c1VNdHFl?=
 =?utf-8?B?T2JXSURiSHNHM2dpZWlHSThHNG9uWDNOd202NTB5aVlnZnhVYXE5UFo0UWVB?=
 =?utf-8?B?SmwyN2RldEI1UFBOMWxyYmlHeXpyK1NxVXljY3U4Q2tpSUs2Z2t6UWUrUk8y?=
 =?utf-8?B?RXZCWFU5c2pFZnZOME5kZ0Q0M2Rqd1hXTCt4d05XUW41MDFsSlJQQ0toQ1pG?=
 =?utf-8?B?OTh1cUt6QWNCY1B4RUtPMHp1TFRvVUliYTlEanUwMVhrNmRPNldPaVhGQXY2?=
 =?utf-8?B?WDJvQVRwa2ZvVEhaZG9DODI2NlFUTGRHQ0hJcFJEUmovbG10QVZwaVhSaHQv?=
 =?utf-8?B?RmRESlBxcVR1WjhTcWU4LzNFWE52NWFVVHdlZmdsNHpvV0VZWUYvUlpEMXBs?=
 =?utf-8?B?ZjJ1a3c3bDhnL2pDNThuTUw5UURlc0lRU3VhV2JHYXhrOUtUWHlkOU84VWRJ?=
 =?utf-8?B?UEduY2ZVaFdmb2xnd2ZxME5VUGpkc2dGY25GbWJjcTBEY1FYN0ZiUU9xNVln?=
 =?utf-8?B?SFY5NnJidnp2bmxaVWttMUI4Q0hpdWlpQlhYbVd0VFJxK1BNVkN1S1hVeXo3?=
 =?utf-8?B?Tm9wK1U3V2RiZWQxSVRHdDMvLzFVNW5BNHk1THZTd2xhcG8xRElaRXBKL1Zh?=
 =?utf-8?B?R2pQUlZoR215VktLei9DSTVVYlhZVDlyUEZ1SENmRHhMSVg4M1VoL1Zmdmxp?=
 =?utf-8?B?LzFIVDZnSjhqS1djMzJHOEpBLzRib24rdms5K1BzZGlCNnByTlI4ZjVmbDR0?=
 =?utf-8?B?R0xqTnN4Ymt6c0p4Y3JTQ2tVR2dIUVAxci8ybU5WUk0zTHl4V2NrblhRbHNz?=
 =?utf-8?Q?1OWoJB6ZfOUu9LLPbg0WpxI7C?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b65535f6-42ab-43e8-4e69-08dddbbf7e25
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 05:49:25.9934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FcK3POoerSkinXpBGfkAf8rG2sS88w/GkFOGgyUbSdDKIVbfNuVG54fVDGeV+K7gI3KaIlZqzowSKSVr+Q5nwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1477

Hi Beleswar,

On 8/15/25 1:38 AM, Beleswar Padhi wrote:
> The TI K3 SoCs have multiple programmable remote processors like
> R5F, M4F, C6x/C7x etc. The TI SDKs for these SoCs offer sample firmware
> which could be run on these cores to demonstrate an "echo" IPC test.
> Those firmware require certain memory carveouts to be reserved from
> system memory, timers to be reserved, and certain mailbox
> configurations for interrupt based messaging. These configurations
> could be different for a different firmware.
> 
> Refactor these firmware dependent configurations from board level DTS
> into a dtsi for now. This dtsi for TI IPC firmware is board-independent
> and can be applied to all boards from the same SoC Family. This gets
> rid of code duplication (>50%) and allows more freedom for users
> developing custom firmware (or no firmware) to utilize system resources
> better; easily by swapping out this dtsi. To maintain backward
> compatibility, the dtsi is included in all existing boards.

I remember I asked myself the same question on how to represent the 
relation between used FW and memory carveouts+others when adding our 
first K3 board.

This change comes quite late so I am wondering if there is any other 
motivation besides code reduction / more freedom for custom FW behind it?


> 
> DTSI vs Overlay:
> 1. I chose DTSI over overlay as both the ways required including the
> refactored file in existing board-level files to maintain backward
> compatibility, so didn't see the advantage of using overlays here.
> 2. If we do down the overlay path, existing board-level file names have
> to be changed to indicate they are without the IPC support; so that
> they can be combined with the overlay to generate the same-named DTBs.
> For example:
> k3-am69-sk.dtb := k3-am69-sk-sans-ipc.dtb k3-j784s4-ti-ipc-firmware.dtbo
> 			     ~~~~~~~~

While it's a good idea to keep backward compatibility for older devices, 
have you considered using overlays for new/upcoming devices?

Regards,
Wadim

> 
> I am not sure if this renaming of files is ideal?
> 
> Testing Done:
> 1. Tested Boot across all TI K3 EVM/SK boards.
> 2. Tested IPC on all TI K3 J7* EVM/SK boards (& AM62x SK).
> 3. Tested that each patch in the series generates no new warnings/errors.
> 4. HELP needed: Boot/IPC test on vendor boards utilizing TI K3 SoCs.
> 
> Note for vendors:
> 1. This series streamlines all boards(external vendors included) to use the
> TI IPC DTSI config. In the process, several new nodes related to remote
> processors have been added/enabled in the final DTS. Need vendors help in
> performing a sanity boot & IPC functionality test with the changes included
> (More info in indivdual patch)
> 2. If you wish to not include all of the TI IPC DTSI configs and leave the
> board files as it is currently, just let me know so and I will drop those
> patches in the next revision.
> Cc: Robert Nelson <robertcnelson@gmail.com>
> Cc: Jo_o Paulo Gon_alves <joao.goncalves@toradex.com>
> Cc: Parth Pancholi <parth.pancholi@toradex.com>
> Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Cc: Logan Bristol <logan.bristol@utexas.edu>
> Cc: Josua Mayer <josua@solid-run.com>
> Cc: John Ma <jma@phytec.com>
> Cc: Nathan Morrisson <nmorrisson@phytec.com>
> Cc: Garrett Giordano <ggiordano@phytec.com>
> Cc: Matt McKee <mmckee@phytec.com>
> Cc: Wadim Egorov <w.egorov@phytec.de>
> Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> Cc: Max Krummenacher <max.krummenacher@toradex.com>
> Cc: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> Cc: Hiago De Franco <hiago.franco@toradex.com>
> 
> Thanks,
> Beleswar
> 
> Beleswar Padhi (33):
>    arm64: dts: ti: k3-j7200: Enable remote processors at board level
>    arm64: dts: ti: k3-j7200-ti-ipc-firmware: Refactor IPC cfg into new
>      dtsi
>    Revert "arm64: dts: ti: k3-j721e-sk: Fix reversed C6x carveout
>      locations"
>    Revert "arm64: dts: ti: k3-j721e-beagleboneai64: Fix reversed C6x
>      carveout locations"
>    arm64: dts: ti: k3-j721e: Enable remote processors at board level
>    arm64: dts: ti: k3-j721e-beagleboneai64: Add missing cfg for TI IPC FW
>    arm64: dts: ti: k3-j721e-ti-ipc-firmware: Refactor IPC cfg into new
>      dtsi
>    arm64: dts: ti: k3-j721s2: Enable remote processors at board level
>    arm64: dts: ti: k3-j721s2-ti-ipc-firmware: Refactor IPC cfg into new
>      dtsi
>    arm64: dts: ti: k3-j784s4-j742s2: Enable remote processors at board
>      level
>    arm64: dts: ti: k3-j784s4-j742s2-ti-ipc-firmware-common: Refactor IPC
>      cfg into new dtsi
>    arm64: dts: ti: k3-j784s4-ti-ipc-firmware: Refactor IPC cfg into new
>      dtsi
>    arm64: dts: ti: k3-am62p-j722s: Enable remote processors at board
>      level
>    arm64: dts: ti: k3-j722s-ti-ipc-firmware: Refactor IPC cfg into new
>      dtsi
>    arm64: dts: ti: k3-am6*-boards: Add label to reserved-memory node
>    arm64: dts: ti: k3-am62p-verdin: Add missing cfg for TI IPC Firmware
>    arm64: dts: ti: k3-am62p-ti-ipc-firmware: Refactor IPC cfg into new
>      dtsi
>    arm64: dts: ti: k3-am62-verdin: Add missing cfg for TI IPC Firmware
>    arm64: dts: ti: k3-am62-pocketbeagle2: Add missing cfg for TI IPC
>      Firmware
>    arm64: dts: ti: k3-am62: Enable Mailbox nodes at the board level
>    arm64: dts: ti: k3-am62: Enable remote processors at board level
>    arm64: dts: ti: k3-am62-ti-ipc-firmware: Refactor IPC cfg into new
>      dtsi
>    arm64: dts: ti: k3-am62a: Enable Mailbox nodes at the board level
>    arm64: dts: ti: k3-am62a: Enable remote processors at board level
>    arm64: dts: ti: k3-am62a-ti-ipc-firmware: Refactor IPC cfg into new
>      dtsi
>    arm64: dts: ti: k3-am64: Enable remote processors at board level
>    arm64: dts: ti: k3-am642-sr-som: Add missing cfg for TI IPC Firmware
>    arm64: dts: ti: k3-am64-phycore-som: Add missing cfg for TI IPC
>      Firmware
>    arm64: dts: ti: k3-am642-tqma64xxl: Add missing cfg for TI IPC
>      Firmware
>    arm64: dts: ti: k3-am64-ti-ipc-firmware: Refactor IPC cfg into new
>      dtsi
>    arm64: dts: ti: k3-am65: Enable remote processors at board level
>    arm64: dts: ti: k3-am65-ti-ipc-firmware: Refactor IPC cfg into new
>      dtsi
>    arm64: dts: ti: k3-j7*-ti-ipc-firmware: Switch MCU R5F cluster to
>      Split-mode
> 
>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |   1 +
>   .../boot/dts/ti/k3-am62-phycore-som.dtsi      |  43 +--
>   .../boot/dts/ti/k3-am62-pocketbeagle2.dts     |  36 +-
>   .../boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi  |  52 +++
>   arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi    |  31 +-
>   arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi    |   1 +
>   arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     |   4 +
>   arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi      |   1 +
>   .../boot/dts/ti/k3-am62a-phycore-som.dtsi     |  90 +----
>   .../boot/dts/ti/k3-am62a-ti-ipc-firmware.dtsi |  98 +++++
>   arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi   |   1 +
>   arch/arm64/boot/dts/ti/k3-am62a7-sk.dts       |  92 +----
>   arch/arm64/boot/dts/ti/k3-am62d2-evm.dts      |  77 +---
>   .../dts/ti/k3-am62p-j722s-common-mcu.dtsi     |   1 +
>   .../dts/ti/k3-am62p-j722s-common-wakeup.dtsi  |   1 +
>   .../boot/dts/ti/k3-am62p-ti-ipc-firmware.dtsi |  60 +++
>   arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi   |  42 ++-
>   arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       |  54 +--
>   .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  47 +--
>   arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |   6 +
>   .../boot/dts/ti/k3-am64-phycore-som.dtsi      | 124 +------
>   .../boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi  | 162 ++++++++
>   arch/arm64/boot/dts/ti/k3-am642-evm.dts       | 146 +-------
>   arch/arm64/boot/dts/ti/k3-am642-sk.dts        | 146 +-------
>   arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi   |  92 +----
>   .../arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi | 107 +-----
>   .../boot/dts/ti/k3-am65-iot2050-common.dtsi   |  58 +--
>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       |   3 +
>   .../boot/dts/ti/k3-am65-ti-ipc-firmware.dtsi  |  64 ++++
>   .../arm64/boot/dts/ti/k3-am654-base-board.dts |  54 +--
>   .../arm64/boot/dts/ti/k3-am67a-beagley-ai.dts | 152 +-------
>   .../boot/dts/ti/k3-am68-phycore-som.dtsi      | 235 +-----------
>   arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi    | 229 +-----------
>   arch/arm64/boot/dts/ti/k3-am69-sk.dts         | 348 +----------------
>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     |   3 +
>   .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |   3 +
>   arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   | 115 +-----
>   .../boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi | 131 +++++++
>   .../boot/dts/ti/k3-j721e-beagleboneai64.dts   | 229 +-----------
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     |   6 +
>   .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |   3 +
>   arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 266 +------------
>   arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi   | 266 +------------
>   .../boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi | 289 ++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    |   6 +
>   .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |   3 +
>   arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  | 231 +-----------
>   .../dts/ti/k3-j721s2-ti-ipc-firmware.dtsi     | 250 +++++++++++++
>   arch/arm64/boot/dts/ti/k3-j722s-evm.dts       | 154 +-------
>   arch/arm64/boot/dts/ti/k3-j722s-main.dtsi     |   1 +
>   .../boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi | 163 ++++++++
>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      |  26 +-
>   .../dts/ti/k3-j784s4-j742s2-evm-common.dtsi   | 337 +----------------
>   .../dts/ti/k3-j784s4-j742s2-main-common.dtsi  |   9 +
>   .../k3-j784s4-j742s2-mcu-wakeup-common.dtsi   |   3 +
>   ...-j784s4-j742s2-ti-ipc-firmware-common.dtsi | 351 ++++++++++++++++++
>   .../dts/ti/k3-j784s4-ti-ipc-firmware.dtsi     |  34 ++
>   57 files changed, 1820 insertions(+), 3717 deletions(-)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-ti-ipc-firmware.dtsi
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-ti-ipc-firmware.dtsi
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am65-ti-ipc-firmware.dtsi
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-ti-ipc-firmware.dtsi
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-ti-ipc-firmware.dtsi
> 


