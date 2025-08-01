Return-Path: <linux-kernel+bounces-753006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2DDB17DAC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79611C209A5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF611E990E;
	Fri,  1 Aug 2025 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ayUznsue"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010045.outbound.protection.outlook.com [52.101.84.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8729978F58
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 07:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754033727; cv=fail; b=IT9Kc/FxRrRSFbMXLup6G4BnEWhVktJ6VwXKVDfnJ8VPUbUZTpKasv0z5RmdMmK9mmaa3+J/iWYYnOrGUIwTsoJcmuTk8p9Cicl14O4/xXFolUcpnkgecAGzWzbDkg97nT5pLwpJZv3c2yx+Tyt5KScw7XfWoPx5RveeYDLS1OE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754033727; c=relaxed/simple;
	bh=HRtXjkhx5Q6+UUKa3zIl/JMmHRq7D9Oc3GirQaHhTKg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cKDGumUJxTvYkC4JSbxJnHxQ5e/uk1oXxnkvzjHMFfM5qO2bFx3NEFLYl36v2unYnaL+MWhHKj0uO2Q6V+0K3fYeN/61NNK72AVAYUwx8DTAgINcEPDDid3Y0NkVj/46fgA5PxhHIzEIB4kbVw/okm9ERGpp9lqtytY9HrWYjiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ayUznsue; arc=fail smtp.client-ip=52.101.84.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtZ1Up2AZR/Ppme823S6zxmatdk4AItfRdRywS4YKmqvOpEKjY1rNIeJAmJ+G08LGL4e1QlKWVSy5gA5qNOvRMSoQCnXEIaIqAL1cm7spiLOAuMwfwT+QUEaPmOkJArPENSmmSn94QGj7rNlfeFECepSZ0aaLQTKegP/POseXE3GcMuSzuQIe84p+DjXSvg2BKw9NjPnrFoFzp/qVPsRLfQThYZyWFBUyOd0xLa+1ydkg0xhFUHRQC+zSPY2HI1WJTn4r+F1Rf0VnfQ53cKSJapd887uTTpIzcjgMZy5J4bhYrjhQZjSCV+94B61lZ1MMnYX1FY9P5B6lnu/8N5/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYN8x+NKtJFz9rCLpAckpZaFBMTV3z8qYrBMi7r8IBA=;
 b=JOa9fpghWGGyqBn3GLLccKGxLcRYDQP+ce29eYSRKbxSe37+w1wKP5cVA9bM4R1ExT8n7173qRo9brQ6krs4baJ+2kpXEHA6XxM0SBDcXyr6WPxBNvhbCW+wZMRpJyxp089fYf7dxRtQgUArkAUwQ+F3Zw76cRfHG2Cvuu/C8KiUle1AUx3X8UzkWYZoo5f4bG3Mo96CPVis7qJy0QJjMMYXE8/Z0b46d1N4wdqfBeT2RNLeZpvT5PJ3JrdAA3RK4HVPTgIlNNXM7wa/Ocb2OW5ti4TvrK9MNpSQBSjXNRfFo8z8Dzz8tcicN6tURBf17xgQ998KSP8ArKF29zwBXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYN8x+NKtJFz9rCLpAckpZaFBMTV3z8qYrBMi7r8IBA=;
 b=ayUznsueKIaR3hJLu0nS8BPaXW6b1RpdMkAjEfPq00QNccaEiEbiw3KSxY9A0AOMjmKBDdEKZ3Z8IEJNII1CUx2CdtvbpFEhcRV8Tk5LFSY3pBRyzhyjGX4PkXxLKMuY+CTfKBrX/1/2i1QGmTQBYWjxbdQFr1lVTRj/D/RuzR8v2BlCdWlm6i5RHSr7LY1n2rwfvsHSpoXYLsDB8+DH6jCJAUpT2qrMEjCMG1cbwtYF8m0y21JMXV7IWptiOAg1jH4vKoG6rhcg8ACAfvhCQjV5II0J7duEZGYVc2eMEy8XLx+BVxQDB82N/5obyR55lqx3nmZ35IEprMByBCSl1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8590.eurprd04.prod.outlook.com (2603:10a6:102:219::10)
 by GV1PR04MB9117.eurprd04.prod.outlook.com (2603:10a6:150:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 07:35:22 +0000
Received: from PAXPR04MB8590.eurprd04.prod.outlook.com
 ([fe80::8cc7:661f:ab20:7d18]) by PAXPR04MB8590.eurprd04.prod.outlook.com
 ([fe80::8cc7:661f:ab20:7d18%5]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 07:35:22 +0000
Message-ID: <1aaf4a2d-ee3c-40c9-b808-204ee61a2335@oss.nxp.com>
Date: Fri, 1 Aug 2025 10:35:19 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/20] clocksource/drivers/vf-pit: Rename the VF PIT to
 NXP PIT
Content-Language: en-GB
To: Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de
Cc: S32@nxp.com, linux-kernel@vger.kernel.org
References: <20250730082725.183133-1-daniel.lezcano@linaro.org>
 <20250730082725.183133-19-daniel.lezcano@linaro.org>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <20250730082725.183133-19-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR07CA0024.eurprd07.prod.outlook.com
 (2603:10a6:205:1::37) To PAXPR04MB8590.eurprd04.prod.outlook.com
 (2603:10a6:102:219::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8590:EE_|GV1PR04MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: 636f6ff7-8dd3-4a6a-4e38-08ddd0cdf8d2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eE91SHg5djlxdWs0ZEFqRlNySjQzK1ZGd1hSdHNsTGRlSE93b1N5MS9xd2NJ?=
 =?utf-8?B?ck00QmxVT3pPOWFldTA4OS8rSUI0czkvNjg4M2VTaXpFY0dMTUNac2drU2s1?=
 =?utf-8?B?NEExeGNZTUkwNDhOdS9IWndZTVVGOGxIeTAvN1VDeGN4QjUvYjFJYXdWS1ZJ?=
 =?utf-8?B?blRTTHhuT0Q3bk1ITVhrMzdwMm1WNkpTOFFPTWp3MS8zVEZseExoYStrUStJ?=
 =?utf-8?B?UHcyNmpvdmVCNzZiTnltN0NLaG50empxTkN5c2l4NWZwUktUc2NxR1Q0ZGlv?=
 =?utf-8?B?UmFvdCt3eU40ekNmY1NldlZKYk0rNW5pcmdlSG4vZjQ0K2NqaHBZQWlqWEJ4?=
 =?utf-8?B?OTNRSDhDczEvN3JMUmVCbHcvY01TeERFQUhPTGRmb3ZBSlZPbVA4aUNqZSs3?=
 =?utf-8?B?ckdBTGFCODk5aHJwMlg0SFZqeG1rWFZVTXcyTzRZNlI2ZWlldTVPcGVYeDcr?=
 =?utf-8?B?OWtFZ1RCemRyU2xVYjgrRjJWMzdNbzBjcnVPQkRNM0dkZzU0U0RFdXNnTmhp?=
 =?utf-8?B?M0ZFSTRTbHFyc003d2w5MjRPVEUvM1Y3NUovMHNlTTFXaCtGazEwVlU5aHJC?=
 =?utf-8?B?cXI4N3FnZFBNcU00eUhvUGdXb3JldWVveWpyakZFWWxjZ0VhQ0VsYmFwakF0?=
 =?utf-8?B?T2R2VXI1QTFCSTJRK3ZlVWtnUnhmRlA5NDNCaThEZ21DQXIxT29vRkl5L0pa?=
 =?utf-8?B?Rk9EM0IvOWlXUXpHaWY2NkVZYTFSWERzWExscEpoaWdLVlFLV0tzRHlxN3RT?=
 =?utf-8?B?akZhb242WUNteDh4Rk1NaW5nOW83K1FNWlBNOVRQbSt0UHQ5Z1BMa1lpYmZI?=
 =?utf-8?B?LzdTWExCMS81dDBNWGRPdzNxRmVqNWFmbWJyRDRwZUg5MkRnZk5jRWx4bXVF?=
 =?utf-8?B?WFQvbHY2L1JwMFptK09CSGticmQ3aWRyZTJ6UDR3UUZvcG9RbGNDRXRuby9u?=
 =?utf-8?B?Tmlyc2Jjd0lVQzNnaEh2b2NkMW43T1VxV0t2bCtueG1pL1hIbE5sZDMyTUFW?=
 =?utf-8?B?Z3hMdUMvc3ZBMmN6TnhUekhLRXdzYUVRODd6STJPWjVqY0xzbmxTa2UwRWc1?=
 =?utf-8?B?ekVSV244QThJd3pEM2dHZkUyL281amJnSjFUemlPemo3QktTNjlVSERUd1ZP?=
 =?utf-8?B?RXhxb0dqK0lxQ05ReWQydWN0bzJraE1nOURjdnZHUGJKZTVxVHZLbHcrVkox?=
 =?utf-8?B?YTFHamhBYms1Z3VEckVjQjFXN3Fzc2FnZ0s3WmZSMWhTZ0hwVHBnZk9Mb0FY?=
 =?utf-8?B?MjhLQ2VMOGdoOTVUYTZTbC9aMy9FaGxsaitPdXZKQnpWb2ZPV1VMZVRib1RC?=
 =?utf-8?B?UDNWRVk2b05hdjNnMmE0Tnp1Uk1pN0JOaHlRRXI2MXFwaDZ0SmNzOUtpRWNQ?=
 =?utf-8?B?czlvR21FeEhQUm5oektTMnNhNENDSFlSeDNvaTBDWmUycDRyZFQ5UzU1WmtT?=
 =?utf-8?B?c0pibmxZWUR1TFpXeTdUVWx3amZ0eUswaUhZZG1iYnpIdDV3bWdPZmE4aG9K?=
 =?utf-8?B?VEhEWm1aNGVYcUNVc05IaUlPKzVGdjlkVnBoSUJ0VldaVk5IVGV3VzhVYkZI?=
 =?utf-8?B?a2UyRHpvbGtxTXZUQm1hdjIxLzRnNzlOSUc0L2Q3WkxWRWxFalBlbDdGRVNt?=
 =?utf-8?B?TlMxSlZFRldPUTJBU1FUZGUyYmlyeXprRXVNTlI1bzZ3WFZ1RFRQSEZLTE84?=
 =?utf-8?B?ZERxS1pncWdHdlZ3Si9zR2ZDWjE2MlBTSUlyYzlQUGRsTUJzUURHTkZTdkY4?=
 =?utf-8?B?cm5yc2RVMXpnWldZZk43eUVRWFlKak8zNEVDTU1NaDhiYXVnK3I2MlpmekJi?=
 =?utf-8?B?QjN4a3dyZmFJZXZxdXZWNWI0Zys5dTI5WmdkVGVYOG5wb2owc3BOVmxIQW16?=
 =?utf-8?B?a2lWRE5GU0ZobUdFK0V1L3E3bG9HYkk3ZGRSbjAxNkRqL2lIcUVseDhuR1Iy?=
 =?utf-8?Q?pjtxaUTN1nM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8590.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkg5TFByOFA4c0VHWWVJWDRaK0sxeGc5emdaaTVqcXpMWFVGby9BVE1yR3lw?=
 =?utf-8?B?N0MwSUpBUDJEYkJHempncTZWa0s3TGVSMmhCVEx6YmhoL2cwcTVleUJrbUsx?=
 =?utf-8?B?Q3ZlZGZmYngyY0l6eVc1Si9JbDlQbHlVNjBObWNyaWt5b3JFeno4UkVCbzlH?=
 =?utf-8?B?STJXeFhva2NURWxJN1d3RjR4YksrcTlZSGlYUStnUkFkWXRSVFZmZFpycERX?=
 =?utf-8?B?aDJFRGN2NUZoZHo4bDNYZTBuR25YSVVxdDA4UzQ3QkRYQWo1c1lvL1hEZXNV?=
 =?utf-8?B?NlAwZUZ2YXQ3ejNkSjIyNGlPSk9zUThIN1FRWUdHWnJNUlczeTFjTlZNUmxS?=
 =?utf-8?B?T1E1d1VaSExxZXJyZm5TMk5rSXlKK1F0REJOY2pVdm8zT05uRFgxbXZZcndY?=
 =?utf-8?B?aFFKUmU0WkpoU3EzeDhaUkdsazFPeHU0ZUdHem11RmRLQnhMVURYWkxTK1pX?=
 =?utf-8?B?L2VyRzJZRkRlRFNDOUlwK3ppNHZadmluVGVKdmZMS0N5VHU0eHhkRXgvWkpX?=
 =?utf-8?B?aE1EK0FpWWYvYjFyMEQ4M2ppSFZpRitILzVnV2VWamtOM2hQdFVwR0NhWWpS?=
 =?utf-8?B?QmpXckg4Nys0cU9idjFvWkNNSzlWQ0VkM0pTWVptdk1CR01SOFNxanFzMFhT?=
 =?utf-8?B?aDRTMXArQmJBeG1ZakU2YmdNdzEydmVFMnBISjFWcXptWkFldWFHRThYSDNS?=
 =?utf-8?B?YUpwTDgzN3VGSTEvMXdudmRxT00wSGxqQ3BPNVExaXJrZGEvd3hPK3JTckFp?=
 =?utf-8?B?ajZYTEhrL01OcWlndjMzK25HZGdpd2QxMmhqcnpqKy9kVHFoYTNmMzJtUTZH?=
 =?utf-8?B?Yi9WNGs5SlNabnp3ZVM2cjlpdXpHamhWYlI5NkxURndkUFptMnE3a2VVSkpN?=
 =?utf-8?B?SWRCVlVOQ2pxQ1pCY2ZHY1Bvcml2VUN3Z1IvcTFsVnd3UldGRkxLZngwWjM3?=
 =?utf-8?B?Y1pab2tEVzRPRWhVQUhlVnpuQWJBTXY0czQrMmFyOVI3dE5PWWdJYnV5OFV1?=
 =?utf-8?B?eGxuOGNtRXl4KzByaWZtVGpxbUpoSm44K0NZb0F1bnE4SDl4MmdTMEVuQ3ZN?=
 =?utf-8?B?clhLekhLSW4zRFh6cTRTMGZwUjlVbjlEU1MwWkJOWVlURm9GWlpUajlUTVFz?=
 =?utf-8?B?TW94czQ5SHZaSmVYSEVnSE96MDhCSi9VQVQ5SDNldUk5Q3VNRytOV3hKWFJL?=
 =?utf-8?B?UTlBRVJJMGQ3OUc5YUJDNnEyOXFvUTU0MlZSZmZKWTd4Qmo0d29wSm9qM09C?=
 =?utf-8?B?ell5YmNINk5hOWY3V0t6eC9LU2NYUnhBKzd0TEJ5VWFDb2JFSExkdk44cDUw?=
 =?utf-8?B?SmUyMTZQamFLbTM1SjRTejlKY05MeVFZcGNqRWJFdTNtOTNmWCtXNkw3V0hn?=
 =?utf-8?B?MFJqOEdCOFBNYWNkRTJuUHZlNnVMMy9QRUR2UXRlTjJxSWJiTGFlU3AzdUVn?=
 =?utf-8?B?Wk02cTNBdHZZRjNHZm8xamswaVNHSC9WRWNwUnFOdDNUdlI3UE9XcmcwaUdC?=
 =?utf-8?B?RlFCWmI0U2llb3pHYnBrSWU0QnhBcVFaNTRra1cweE9oRzBPS2xtSGtya1ZV?=
 =?utf-8?B?ZlVhVFdDb05GbllTcUNHMzRjVXNBNlRpY1ErZzl0WDNQc0hzUGRjMzFWNHA5?=
 =?utf-8?B?WXR2N28rUUtnTGpnT2JKbkkrS1VrRm94eHJGQW5DbFdyTUtZTjZCNEFON0tu?=
 =?utf-8?B?TzRUVjhTc3dYaG5XZFJvemlKbEhlZklTUGxZdTdOd04zMHZQNVN4UG9mRjgw?=
 =?utf-8?B?SnRWMHVrdlRPWXo3c3haVzk3L0lXcHJLNDhJc0xPcllNWXg5OFhvUVVFUXhK?=
 =?utf-8?B?KzRzSTlraEpSQ1NsUnBqT2VYK3BDdU9SSHV2d0xxenRUbUxpWUoyaVBqaDU3?=
 =?utf-8?B?N25mZDFxbWQ4MHl0VnRaVnFOSXB1V3lnSWZtT0VKckZCSkh1RmROa2FDdlVO?=
 =?utf-8?B?TGV1by80REd0R0hJczAyT1RzVEp0akZkc0RRUmtHaVVMWUxTMEVwek9YSXhN?=
 =?utf-8?B?OHZHWEg4aDFyYmtLcjFKM0pzUHptb0NZK0VnT3liakhaOXRBZFFpS2hncGxT?=
 =?utf-8?B?UHJsQnRGV1dlRUNqVTdGdlJ4RndONkZERnZid3Q1K1hOeXdTU3RUWlVDeTgw?=
 =?utf-8?B?cXJwY0FWT0kzRFFEMHA0bHU5cFB1SkdjZWFiV2lsbytyT0UzdmVjQjF1MmZj?=
 =?utf-8?Q?1WhLgxrkwhNf3yBPg2JfUnA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636f6ff7-8dd3-4a6a-4e38-08ddd0cdf8d2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8590.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 07:35:21.9555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZeYgEvQvaWB6Rg665Rw5XweSSFG0q7yH1AClNUweHXxe5mHOSZlNGVbuPabjD0GK1kyyliFrAR1C5Dh4ixX2TsVm9IttE4UhL5OlRv38fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9117

On 7/30/2025 11:27 AM, Daniel Lezcano wrote:
> The PIT acronym stands for Periodic Interrupt Timer which is found on
> different NXP platforms not only on the Vybrid Family. Change the name
> to be more generic for the NXP platforms in general. That will be
> consistent with the NXP STM driver naming convention.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/clocksource/Kconfig                             | 9 ++++++---
>  drivers/clocksource/Makefile                            | 2 +-
>  drivers/clocksource/{timer-vf-pit.c => timer-nxp-pit.c} | 0
>  3 files changed, 7 insertions(+), 4 deletions(-)
>  rename drivers/clocksource/{timer-vf-pit.c => timer-nxp-pit.c} (100%)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 6f7d371904df..0fd662f67d29 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -474,11 +474,14 @@ config FSL_FTM_TIMER
>  	help
>  	  Support for Freescale FlexTimer Module (FTM) timer.
>  
> -config VF_PIT_TIMER
> -	bool "Vybrid Family Programmable timer" if COMPILE_TEST
> +config NXP_PIT_TIMER
> +	bool "NXP Periodic Interrupt Timer" if COMPILE_TEST
>  	select CLKSRC_MMIO
>  	help
> -	  Support for Periodic Interrupt Timer on Freescale Vybrid Family SoCs.
> +	  Support for Periodic Interrupt Timer on Freescale / NXP
> +	  SoCs. This periodic timer is found on the Vybrid Family and
> +	  the Automotive S32G2/3 platforms. It contains 4 channels
> +	  where two can be coupled to form a 64 bits channel.

Checkpatch:
WARNING: please write a help paragraph that fully describes the config
symbol with at least 4 lines
#29: FILE: drivers/clocksource/Kconfig:477:
+config NXP_PIT_TIMER
+       bool "NXP Periodic Interrupt Timer" if COMPILE_TEST
        select CLKSRC_MMIO
        help
+         Support for Periodic Interrupt Timer on Freescale / NXP
+         Support for Periodic Interrupt Timer on Freescale / NXP
+         SoCs. This periodic timer is found on the Vybrid Family and
+         the Automotive S32G2/3 platforms. It contains 4 channels
+         where two can be coupled to form a 64 bits channel.


total: 0 errors, 2 warnings, 0 checks, 25 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or
--fix-inplace.

Commit 1e9876740925 ("clocksource/drivers/vf-pit: Rename the VF PIT to
NXP PIT") has style problems, please review.

-- 
Regards,
Ghennadi

