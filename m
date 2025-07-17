Return-Path: <linux-kernel+bounces-734993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7742B08938
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88CBB3AE014
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E6F28936D;
	Thu, 17 Jul 2025 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="K9bigMWj"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023082.outbound.protection.outlook.com [40.107.44.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5AB4503B;
	Thu, 17 Jul 2025 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752744300; cv=fail; b=DlgdNLb/xjECnRKIWvJo4JzFRtyqjWYEBdphljA8Z4XkG+ZgDTz28glwgzhFetZPb0RiVxrSMvARcHJGtAGCrrTmkrehJtNQ30LPhnPJxkQbID4dFj19KqE/5jVAjauLYZ9HsPYU8kf4moG+/Lt+3kB4oZdcLiLdHEoqGlrVsyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752744300; c=relaxed/simple;
	bh=puLx6pqMsfsIqXSQ1NDqqrey5fgNWK3Kguh09L2C0ys=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=reoFVrQMZwu4RFib0uxaiyOdKGA7uRJCFOYUNH88ToZrs6a0trtip8oTbD4wgrRCMnkN7iTBd8KTOWL67CLfPm8v8EX/0uxd5TH0SltcJ4/2DGMm9R3a2a5iuEmUnOXfBvapDyma+xQoMDB442lxoOVTJTwhQWEhoh6XI/eaxh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=K9bigMWj; arc=fail smtp.client-ip=40.107.44.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAp08wmcD18bOKZr2KBR+JederFlOA+UhuCi1CWYYtWp0V5yLMWdncEoQEv0mtc4QzNVV4/llUasZiKeTWCLIfJIc4BnYj88VLkzg5/Xbz07auAk2FCSsY0OhISkl58jGDCFZUuGEIS3g1Sk9Q9Ng/yW1df6TVsx4Y9oDu90XqWYS5wDgTx/CQcttJ+Dt9XfaOwlRgfUqhTz1KUMnuolNysA8DUkNVk4TFd+gbY9c4pRexgK+BdVtp5BBT71swwwIz+JOo6ZQhYq+fCb76O1kxM5YwPm9FoBmIIWM8WTUJ3wZfdmcsUN2bQL9T3VKDljuOt9IplPZjBc6s+CX3oYDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoUSo0BE4dpMDGMks/Pcqxj//p63qeZKKlmYNvsnafk=;
 b=XXMRUzZy875pocnnsoG9ZAf2IUbpd/bWoMFdbJRnAEUVS6gIUPZudwReODP3a0m60miNhWMqYy+57pIcXwqud74gO8wUIhVUFCunX6sbEz3Zu47NcPHoQIs98XRwmj1t1dFw67bvBHckLOETk9peISbMMPJjxvWNGYFxkPJcR42TsNGtMIcLjXrj9OWrx1XGgpcF3GeqTNbeakctPTGdwTL8BYZIcUWt0s3Og09fkkxDYyQQaBkRQHSS9KwIyen6zGwrtoQGU2j82RucpIbjZ35EwYhoXY6vxvRCUeJcsx0fu7CJUDPqDuiK6GCSfjTFT6tXT23mu/9LQrru5Ya8UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoUSo0BE4dpMDGMks/Pcqxj//p63qeZKKlmYNvsnafk=;
 b=K9bigMWjZ096sjqT2RwNCJbIZ2nw0THIH7KiRyUXVItt7uWOzzZqASRZ8h42Lrh7LD+pvyUd0AYxgioztvbaMlQQsZMinsECfhfS8oIv91tr/n73fHDeJzsvQoQl6zdpBpT707qhbukaXiLOTNgA3tJ75U9jzaxRZ6xNgu9+8Xbh4wrurNf9y4ox7+QZ3wTSNR9GMrHkInDJ6ctGURwNEbRj/iM22njAWBAqpu30sRaO4rOuCiC96wzG59Rq7wGjiMbVqAlXmr3VHb5YOhcGAV+vjw3Ge+TZ31FfuUIzPpfgn2PoNsN3eG+VrrudwpBC9IyH1Km8dGpTgeU6J4Mm2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYSPR03MB7387.apcprd03.prod.outlook.com (2603:1096:400:414::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 09:24:52 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%2]) with mapi id 15.20.8901.024; Thu, 17 Jul 2025
 09:24:50 +0000
Message-ID: <bbcf2608-5320-48e2-b786-572b35cd2e5b@amlogic.com>
Date: Thu, 17 Jul 2025 17:24:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dts: arm: amlogic: fix pwm node for c3
Content-Language: en-US
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chuan Liu <chuan.liu@amlogic.com>,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250717-fix-pwm-node-v1-1-45021777efa9@amlogic.com>
 <CAFBinCAs2Ra6GiF6y-EDPCZXoi6sM+wyPUWp0vE4UVbXByXa=g@mail.gmail.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <CAFBinCAs2Ra6GiF6y-EDPCZXoi6sM+wyPUWp0vE4UVbXByXa=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYSPR03MB7387:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f0b9d7-a9b8-4e31-03e7-08ddc513c77c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3FXSWlLaFNxblJTb1lpRkk3bmZ3QnZ0VVlianh1WmZUa2kydmpuSVpla3pI?=
 =?utf-8?B?bFhBckRWVEZGby9Fd2RKeTgvNEN0MjJuZlFWUDFBYnFwaGRlcGp3N01iZ2xp?=
 =?utf-8?B?RHlnOC9mdDFqUEF0RE9XcGg3dGRrWEF0VjlnSkFhRXVxZGxzN0JoNW80ZHRa?=
 =?utf-8?B?U29HSDBEVXE5bGhvTEZRTnVJQ0FleHFoUGRJUlRrdHBMc2pYUVJpdjRMRFdq?=
 =?utf-8?B?RkZ2TndiOUtqblIwSXlXTXNBWWl0WVlzb04rNnVtZEhmMkM5RjdzdTR6WWtL?=
 =?utf-8?B?YllnVmUrUkVIVm41TmdwdnZGL2tmZkl0Nm9rdGhSMmgzUUl3OUt1R2M0WElS?=
 =?utf-8?B?QU1WZWgwZUNPTnJmQ0wxK0xyaW0vakdabi93alBsNTVGdEt4VGRRcE9ZU2gz?=
 =?utf-8?B?ZmRGTENxa2tsSnNYVHFGWUNHaDRLNzVGRlVPZUYxTy9LV05VMW1BYnVSaWhB?=
 =?utf-8?B?WHRNcjFQSzVBNWtUbmJIMWJTU2xScldudEQrSmhheURUNVdVMUZ0WGlVNCtZ?=
 =?utf-8?B?cU1FQnh6MGV0Sm5vb2hWQUNiVnNkTkJONGpRaXhxREpQSHlvRXowUjNNN0da?=
 =?utf-8?B?VnBTYzFEWDRyU1AvUnNGd0JCaTVMZ25nNEZkTnhISDNvVXdMU1VjSUIvRzVn?=
 =?utf-8?B?aWsyMXpxS0RBbWpVUkxQOFlxNzN5WTRvWU16TTQxTFY5YjVyRk1XVnlQLzJY?=
 =?utf-8?B?UGtYUVVOSHNNU0IrbFRrdEpQRkZKRzgzaExrKzFXR2xvMzZRdXFsRGV1VnI1?=
 =?utf-8?B?ZGl5UnZYdXdVSVRHVkRCMWNLcXBlaWdpMmhybVhDNXc5dmp4cnFLNEYrMkxC?=
 =?utf-8?B?bGJHc3lHQXhucFlwY3NCNy90ZHpVR0dnTEdENnNmQ3F2Yno3VG5vNGtISytk?=
 =?utf-8?B?SmJzQ3BqYnNPNHg1dVdxSkFDaWgrSUpyTEdtcU9NYzVQVWlXbmxMMEpMKzlS?=
 =?utf-8?B?VmluaVc1MjVJMXdSZktKMkU2ZDcrNlFTVWpaSWFBNldldWdyTmtrZ3VKdTJu?=
 =?utf-8?B?aWtDOEpOcUt1MWYwSjhZelV0TjMxTTd0RjAzY3IyMXJ0bXJzcWpZVWtia2RD?=
 =?utf-8?B?amtYRHpUUVZETEw0SlVzanA4dldnS0xpYnRGVFY1dGRCS0wvdmRWTGJmK1VZ?=
 =?utf-8?B?aURGd1NYa25zaE1CUnVYalVoSkJSeTVNSU5IRjNBRTh0dEVNSjVvemp4c2o5?=
 =?utf-8?B?WEt3ampwTU50R1duMWU0ZTMzTVpBK0VKMFkwNjlzVnY1NnFIOVNqSzllclFX?=
 =?utf-8?B?akxjdHkzakJNTktLbURWWUkyV3J5Z3pZWDBId3RwSFhpWG44UHQvay9ZY29w?=
 =?utf-8?B?dUZCSCs5dXNaTnZTbkIzbmRYN1RXQXhhc3JPeHBqM0FQSHF0NWZvOXFVVWxD?=
 =?utf-8?B?cExpMkF0TmsrTHQwV2xhbDZrMWZBTlJTOCtBRWZtSU1WVTA3UThkVXlWeWxi?=
 =?utf-8?B?SUNjNk92NkIxSnplakZlOGIwUUJhR3BYZTJUZTM0eGZaYkdmVzlHcmhRcGZJ?=
 =?utf-8?B?NDZ4cmNlMW1rbHU5U0hXdkxHbm1TcjZINDYxVGtFWTFDTnZPOCsvaFdMRGh0?=
 =?utf-8?B?UEJvL3ZCQkRVZjRQOXBGRWF2UVpsZEIyNmdxZitsNW10MjU5UVU0OWIySXZv?=
 =?utf-8?B?a3p5dlhrbmhCZ2YveWdobmtJc0g0cldEY1JjcUVNUFF1R0JWT2hyVk5qV3gz?=
 =?utf-8?B?OTQ0WEM4Njl3RmRGamFoVWRsK0tKYjZUSHdqc0NLVHc5cC9JR2FLMW00TEh2?=
 =?utf-8?B?UFh4WEN3SXI5SlFUKzdmK0JvaVYyTUkxQVhSWU1YZDBocjE1Q0pXSWVNT2NZ?=
 =?utf-8?B?RnJjVXpwQmoyTEtHV3pva25tdldlM1ZOZytjc1dPWkxkR2JDSFJXdFRxRTB4?=
 =?utf-8?B?Qmx2K1RBQ0g1V2pMTHB1QnZrNHNoc0w2eGVkWjNCOTBadVlvWndIN20xLyto?=
 =?utf-8?Q?dxzicoyD/kA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3BxUzU2Wlh6dFZMWUVYeUc4cDJMVkZRR1UxNWFMb1JjSUJkdE1JbVJ5MlM1?=
 =?utf-8?B?RjRqK2pwczV5T1NmWjlBODlBMzc4WEdzcG5jQmlkNmg2eXZERm9MS2RVZk1n?=
 =?utf-8?B?ZW5uajZQNEZJTVNhc0tORzZTVUZZS2dyOGZTdWtBVGxNMzliYnYzRnhHa3Fh?=
 =?utf-8?B?Y0ExbHdtNmxsNWdhemdjNzgxQXNweWVEQlZXUDRzWU9DbHZQWXd3WElzVVBG?=
 =?utf-8?B?SmFNM041aTZhVWFNcE9NYmc2dTUxdERCemtkaHVEMFVkM00wTC9TREc1bGZC?=
 =?utf-8?B?NCtqajVBeEQvWVZScVc4UVNFVjdXV0kvV2l2MDNTalZ0R2NDUTVITHJjaGQv?=
 =?utf-8?B?eVhwT3VjdzFpOG1zQVJHc0R5RUtLYVZYV3FtVHRlVHc2bGhoeWtrN2lscHRo?=
 =?utf-8?B?WXBoWFhJOHFZRDRoRUhnVmwyZThFd1Awd0JObFpkeG1KQmwxQWN6TFVrbDZ2?=
 =?utf-8?B?YkhnUE1IMGlxNzZaZHRaQnRSYnJJNGpyb0pzemx2KzdWYThhcG0yYmdBd2xo?=
 =?utf-8?B?bDc2Z2NCZTdZSDBqWnYwUzhSaUhzdFRTeDhqUmxRdGtjWXpmTmIxdUtwbS9D?=
 =?utf-8?B?RFh3RGlpcVZHdlI1TXM4eUJtQnFUL3pUb1BkTUFoM3JERlhrZXJndFp3RXNa?=
 =?utf-8?B?dHVlUkJnVjk0Q0haRlZtd3Jxem9GSnhqYnJOVlI5bmRyRzREa3RRazYyaVlO?=
 =?utf-8?B?MFdWUklzdlpiZVpBSFRFMVkxTlJCenp5dW0zdlhLQVhPUGFnK1FDcURHbVpl?=
 =?utf-8?B?aHI1VXBEZTUvMkhoR1RxMmlGR2hQNGJ0QjVnU1NFRXNnd1dzaTdJRXJLSHc5?=
 =?utf-8?B?ZmZxeWF2U1VDRmtVd004RjAvNUZoL3J5dnRDOTJ1Y3BUZTc3QVEyVy9xdE1u?=
 =?utf-8?B?bXM1d3N4VHpNdkpUa29SQnVaL21pUyt3b2gvRUhRenByZ3h0M2JxVFJDOXAz?=
 =?utf-8?B?ZGhUazNqaGdsenZTNGp4QjBLZmVjMDZFaVdOK0Z0VXVSM285aE5aTkZMcTFx?=
 =?utf-8?B?THhFd3Q2em9maWhQWk9PYmF2NjR2SGtGSkVvSlQ4TnMxSEVJd2NhRzNBZFVN?=
 =?utf-8?B?TFpocE5JMS9oQTNnRER3S1U3dzBoUisxMTZKMGs4K3A4dkc4dUtpNjFkN0hx?=
 =?utf-8?B?RVo3VGpSWEZuWmF3anhzT2VjZXI4MURRUmtKSkRNamx5ZnNkeDJGcHN4NWZJ?=
 =?utf-8?B?WE5JZlRoVytKRE1jZnoxM2gzdlpqakdlRzZodE5PNFBQSG5pNG8zc2RmRURE?=
 =?utf-8?B?dXNFQ1ljMkRXdzFpUG9JeHRtUkNGdWVtQnRLWEVDQjYrdWRzOHVXYmFBaW5k?=
 =?utf-8?B?eVg0MmE0dE5NTFZWY1N3eDVFYnB6dCsxNi9sR0JTbGZUc25FUW9KaGxhSDYz?=
 =?utf-8?B?Q2o3TE9ZbDFpc1BlcVNyNVhudXlqZTlBS2l0bDRTQWtNTHZGYWMwVVhqN3px?=
 =?utf-8?B?Q2dLdDEwbHpqY1V2TkFwL1RBU2pRS3VKdWI2amVtcENHcWczWnR4MzdYTjNR?=
 =?utf-8?B?Y3hZcGdKNXJ1dlpWZnBjOXRpWnV0L1JhMU9HUjdKM2xLcmQxcHBTeXJxQW9t?=
 =?utf-8?B?Nzg0UWV3aDNtaU1VUXR0ODhkM2Q0Y3VTSVZyc2lKR0dQMTFza2pRSDd6Nms0?=
 =?utf-8?B?dTF3ZmFYYkc3ekZoL1ZkMmc0Unl3QTE1MnlieHZxc3F3YzZ4ODVYQXNnWFFR?=
 =?utf-8?B?d2Q4czJFVDRSa1k3Z3ZxMURVS2FFeGsvWWg4NlJ1eUpvNE01TzE1TGc2MlpF?=
 =?utf-8?B?d25US0doMEVscWV1UG10MmpTMFNZMUl3VG1NOGJRWEU1SFE0SHlTMjVaK1lR?=
 =?utf-8?B?QUUzYURvbjY3UWRudmNpN1ErQ1JLNTUvSlFiMUpNeGZiL2Q5RkgvYXJ3QVFz?=
 =?utf-8?B?N3dURGF5VzBIK1ZvWTNHR3RzNDZrWjdMZjhDdjA2OVpyYWZrUW1XZWFQNXJY?=
 =?utf-8?B?Q2R3cWROY2d2MG9nRXRiN3crK3VsaVVBYzdqbDYxRXM5bzBMNk9hOUV3S3Jj?=
 =?utf-8?B?VDhUMkZtTlhzV0VLMVRNQkdtVnc3WjZFQk5pNU0vWjhseG9HakphcG10Y2VJ?=
 =?utf-8?B?L0hOdFlHNnh5WDF5UHZ3K3dSSWcwb2NtRVduQThLdFpYK3pnRDhEQlRjODNM?=
 =?utf-8?B?Q2g2OGdKbGRhSENWckdkRkhlVUU2dTB5bGRkM3h5ZFBDSTFQMnNqRDJMck1O?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f0b9d7-a9b8-4e31-03e7-08ddc513c77c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 09:24:49.9462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8ahGthKVThiRqzlKCEy+8LXV6vetRCgGem0tG04bDDdxkuyaPWZM7kuoGJdhTHc+EgQb9u6XFNg1XLalLEF9axwtM4Dc2LYw1K4zs9M76A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7387



On 2025/7/17 17:21, Martin Blumenstingl wrote:
> [ EXTERNAL EMAIL ]
> 
> Hello,
> 
> On Thu, Jul 17, 2025 at 10:59 AM Xianwei Zhao via B4 Relay
> <devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>>
>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>
>> Fix reg address for c3 pwm node.
>>
>> Fixes: 431a5281e701 ("arm64: dts: amlogic: Add Amlogic C3 PWM")
> Commit 431a5281e701 is "arm64: dts: amlogic: C3: Add clk-measure
> controller node"
> I think the correct commit hash is be90cd4bd422
> 

Yes. will fix it.

> The actual change itself is fine for me


