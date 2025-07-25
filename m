Return-Path: <linux-kernel+bounces-745935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 339E1B120AF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7C61CE4A16
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B4E2EE5F8;
	Fri, 25 Jul 2025 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R4966eZt"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1DC10F1
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753456440; cv=fail; b=nA3csigebFyEa7bAx707sx1IEJswkjmL1SwwBWozIdMqFVnE5F/48va2c03RO/4kuv2Px/aJG96RQA9H54CGVMxHXSgbo3pX6zqMNthSlCq6wW+JYVbzuMdTntk0CY8m/3PCXGRGEWx+Kvpeo3IhxmuDu1BVoDB+naN+abtQi3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753456440; c=relaxed/simple;
	bh=UQivfDzV11kM51ggOW6h0R8fAq//q1whLDPCMv/PXx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oLaVwkfYyuA+woClLe8pF4Ocw8fjVrKhnMzuSmwfUIqt5I4+ETHTs1KvYeZyR8V0HVvdXMVlxZNgCec+xLzxLOgZgtJHcviF6WcAf4s3Pq0RQ/GPKTF1gFLdM0hyOoEoL3Q4xB1SwSz7I42JtKWQMr7GOGKDVZLUkyn3yEE9VDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R4966eZt; arc=fail smtp.client-ip=40.107.159.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvzMH4GB7s7DbZ6Z8s9psWZeyiia63BoFVdkVoxA9l223Jm72hBhYNh64KgrZFW9fTfJCWghYY+OnfmpeWlBdek3sSwhSZM4HOBlLJF1Ys/r3dTpJwcDMl2cpRy1qLIvW9sISOGs7QiuZ1XxoTOhlmheWqKOqk8i952sVnELDzA2Pxjgh9qRXTtiMRP9teVg+AHdA0zAvBW4KQYtCOSlLGdEp1BibF+q88o/OJ/Vhl07HX1Ylwj1/2f7GeBZzhliyx3gK/5RU6Iwlhh0kQLEwck7xjqIHTJkKEbzuIRS8urRFf1/S7gBH6Luibz5+kEW1VR+FqZjbSGnZeG0YpoKRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWFW/dUi/lPdhdvhg7f7VdeBjW0+dWrdpMJOc5pEecg=;
 b=wsFPzbHPeBoXV/qZJsICsgniUCF/1o6qFec4iPlDA7F2H+FISruL/dYCmaOYckBHsldmrh9flximPFVxu46Qyp4UHp9kXWKK74sjzWNynp9kmpGYSWrrRH7XmSAqbD4MX3pfb6Z+ZLKmxrBcXY/friuao4+TfXWLbeZ9Ijyd6hnPoCZw+yPVynyuPztUucghLaAHlMIincE/r+Zt6kpq2g1BKDILs4s07tv2vB7hnC8ta3urbnjqOCxgzH4i7wEtS05JMkIwDS+y3H15ZiasaXfmkWtHssRVm+87Cvz4DIvh1JVL0lfnh7gEZjgKdwbFyGXnk5bltDkPGBE9+u18GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWFW/dUi/lPdhdvhg7f7VdeBjW0+dWrdpMJOc5pEecg=;
 b=R4966eZtBu+k6F9DZc+Z7Mijzo9Tw6HfaLaQ3JSw/zWA0TOF4l28G8iMjzk2BjfMjclHHcmmERoA6bWHcgSKBmcBG5gvRYhGPcHKiyk3DV4bC8QwZ3A//H5WjRhi3WYIWDxS46m+XCsYb0qrgL2Mgl3kWRYxv9T9hvEmFwQ9YZGE5R/xVOj+S0rtL8JJNS/KeQv6jkJJE4ASbmJ+XtmWCIdidPDutOWpxs56Rm3k+Etq9xkItCgvpM9HMV7Eqztsmjz4dhJ7F4VK24HvI80rlIcc609/icrJVdr6N05PlvcPF5XmfzL0Ewa4LylbO36GTs9++aZ+Q0LyDyJ8jhCwsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7918.eurprd04.prod.outlook.com (2603:10a6:102:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 15:13:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 15:13:54 +0000
Date: Fri, 25 Jul 2025 11:13:49 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v1] i3c: master: svc: Fix npcm845 FIFO_EMPTY quirk
Message-ID: <aIOfLYIVE8NkYTxH@lizhi-Precision-Tower-5810>
References: <20250725070310.1655585-1-yschu@nuvoton.com>
 <aIOKeClm/vOPp4IU@lizhi-Precision-Tower-5810>
 <CAPwEoQNfdit9fOiUY-WzQvS377nEqBu=s8S1zqS7tdSZfQeCHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPwEoQNfdit9fOiUY-WzQvS377nEqBu=s8S1zqS7tdSZfQeCHQ@mail.gmail.com>
X-ClientProxiedBy: AS4P189CA0015.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e825240-5a6b-4531-c498-08ddcb8dde79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3AxdlRML1dXSGk5RU9NQnZWbEVqYzlhYkF1dzcvZm5OVGVpT0xxT2VscXc0?=
 =?utf-8?B?SWl2bkJvNkZuK0x4NklocmxSdHhSeU5hbkoyRjBaVCtLOVRiNldlUkVHNEll?=
 =?utf-8?B?RWNVbElhaXFyaVN2TGM4cTJ0emRURUg2eUNNK3B6OG9ETUJWRktYTG1nOVh2?=
 =?utf-8?B?bjBnY2NCSTlqTjBpOVVFOFFiVkRaclhydVU5L3I3TTNNa3FZdzZseGJHRDli?=
 =?utf-8?B?NjNhK2VQSHgxZ0FBa2lpa1lzbmZIQ1RTTEQ2UjQremZqZlptdUdRSE9WdTNE?=
 =?utf-8?B?VnNwa3RpekFZTmp5OEhwc2VkSTJpRk9XQ3lMRGhjUE5ydWhWQkxPL0F0eFF3?=
 =?utf-8?B?THExZG9RNVB0Wkd4VGQ0eDFMaUtGMzRybjZRZjErWC9wL3pma1diL09DTkM3?=
 =?utf-8?B?b1RIdEpmbjIyNGxiZGpIODNNb3JVN2NQRDVkMVI1VWJUc3VyVjJNc0JpZDlH?=
 =?utf-8?B?dnJ0TWREZEJmKzlPWnhqWHdNWXo1bmwyZUFzTjJrSStDTFVuWTR2QTNvSGpL?=
 =?utf-8?B?MC9SL2txenJyZU5aZm94MzlISHZUNDZQRS9NblZ0d1hSenlRMUt1alpLRFdl?=
 =?utf-8?B?cUFEMkYrVkZ3bGk5WHFpZjVlZE5ucGZNYXV6d3NQcFp0QWEyb1RncGFPMWxY?=
 =?utf-8?B?dk1OM1RhejRsVGlsSFo4S21oZjF6K0hpT2xuQ2lOb1lybDRvYVNtbWFKdElE?=
 =?utf-8?B?OUE2T0xaM3NNMXE1QWc3VWVMR2NZblF0WkN0TURCYVFwbkpyM1hyYlhRQjBj?=
 =?utf-8?B?M0g3MVNTSDNPTXBZNDFCdkpDZUorT2xlMWlQR0hxckJZeEd5RWNoa1ZxRVZX?=
 =?utf-8?B?UHUxYUVPS2NwSWhaTkNTVlJaRTVOczRKUFZ2MzkyTmlMVHdLYUliRmQvS01G?=
 =?utf-8?B?a2ErU3JtWmNhRzdnM0ZsNjZ2NG9wYTlscnFCY3VuM2NwQ3VQRWhueHFwQmkr?=
 =?utf-8?B?ZmtKTnduUVBhUHpPS2paQVpwUWdia3BuMDcvNlZPcVFaRDlsZFcvUGZtS1gw?=
 =?utf-8?B?dnZnbm8rQmZkdkc1OWVFcGNDeTMxbE1wN0ZHMk9FNUVlWmwyYnhMeURuRGhR?=
 =?utf-8?B?T1RYazVIY1NjRTJYcmw4ejRmNVhXdE14UkFJck5WNGE4TjhvTlBmSlJYL3BI?=
 =?utf-8?B?V1JEaDA0amZoYXdhMVltUGJ2UkZldEc5OTdSTnVPdk54cE5WUDNXd3hQaVg5?=
 =?utf-8?B?eTNhWEI2WENmcjlsMnF2YmNJNXRCdU1FRlZCdXBmMVg0dml4TklER3VkVTZu?=
 =?utf-8?B?anpoakNVMEJZd25wSDIyTUR3V3NYOTNmWkVGSlZPa0cwM1BnWlhvZFlLc1Rx?=
 =?utf-8?B?VWkxd05CTDlCcUZiOE1OaGdoM3JiRnk1Z2hWaUxQRW5IWWVSblJYcWU0dUtv?=
 =?utf-8?B?T2hmWGRKbFBoT0pGQThFMVNjekx6ZzBqZFh0VFBGQjFGM0dPVjZiQmtoM1Np?=
 =?utf-8?B?UEduREMvcDE1UmRvdVRvUDdGTzcxS0xjTC9HU0ljajIyNkQ2cTlGVk9QMzhT?=
 =?utf-8?B?anhLRy9DcldkeFM2Z2dlTkNBb1poMUEyOXN5NjFqWGpVU2RWak5OcHgvMWty?=
 =?utf-8?B?ZzNHN3hOeENNVHhLSmt2dVh3dkxNMkFqSHdtZ0ZwWUlwb2Y5NEJENjFPTHB3?=
 =?utf-8?B?MWNuTFJXaWRUMWJkdytjSUlDcjBrVnd6ZFc0Z2RndHp6ZTBjdnB2bHVydW0r?=
 =?utf-8?B?dHpydTloaUVlSjZYZENUdm5rYmpVbVBDUEd1elI2aUpqL3h3YzhmaXZwUTZK?=
 =?utf-8?B?Y2o4aHlEK2Z6VkswdWVNcHJ2dU13Q016OVJXVVEyYlpPYU0xbmpLU3BIcTJQ?=
 =?utf-8?B?cEVRUEpnRTRoRzN6SDhZemt2aWdhMm5wSWwzSlRGM3FOcU9iZmlxWjhEQWcv?=
 =?utf-8?B?dXB5ZEp0Rzg5aFBrRldSRUFySDVjZFcwbmZSMlJ1TDZHZ3NiU1d4empZRmY2?=
 =?utf-8?B?RlNsREVDcUdHTENld2M0TDQxVHcva0FJRVNnZmRaN1c5NUVPSlZSVlR0MEY1?=
 =?utf-8?Q?08FyNAzb7KTf8UGx2Bi+o+X8DVz7sQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0RRQVRvOTZlbUhLc0RRSHhQY08wTksrMUFJVTUxdTlWV2VrSWk0N2tWdlcz?=
 =?utf-8?B?VHIzNGxKK1JRR0dCcEtQUEFqaHJiWHc5YlFLRWNMVGVLRjRwWkVNSEUrN1dE?=
 =?utf-8?B?SExHNEo2SThteS96L05rdkZqSm10WGk0YmcrTE9jeWZBUDFLZ0kwQktmNnBv?=
 =?utf-8?B?eUtvdlFubWRWeWFBazVIWldZSCthaSswbGNuZWdXYjc0RXUvYUNhbjhZOUpR?=
 =?utf-8?B?UEFXVjR2QXlWVnRoWjg3QURlRW5FYVI2ZTNiL0Q5dXRNSm01STE1OHlTd2Zt?=
 =?utf-8?B?UnRmVHpHQmFjYk5mOVhxTnczem5kajBHZGFEZ2luZUlxQzdxRE1YNnN1ZStY?=
 =?utf-8?B?SnVGcHo3RW14WExRbzlzN0ZxMnB5blBLbGFWalFWWDV5K3o1SEdKb0hCcXIx?=
 =?utf-8?B?QjRIY0lRcE5Ya21QaFAzc0pucnY3SzNqTDYvWXpEVEpteG85Vm9QSERhYkc0?=
 =?utf-8?B?MEp2b054R1RFR1NuMTZjaGd2R0pLdXltZS9RYkJIT1JHZmRybG5oaVNpM1U5?=
 =?utf-8?B?RGtzOWFDWUVZSmJMa2U0anJTT25FVG9FS0VKQmxmbmtvUFI4QlNiMmNoWVVz?=
 =?utf-8?B?amNOY0lOM0JybldQVXhUckZWZTlMRStNNHVTeUFPem9QbG1NT0hpNnMyc3JO?=
 =?utf-8?B?MVdKZFdrc2tOUkFaemVsV2R4WUNkMWUvbFpkYzZTc0JCMVpQY1Foc0NQN3BK?=
 =?utf-8?B?cXE5b0tQdTVNcncvd0RsbWpPVzRVK25nbWdNMmp6SEIzblR4ZHcxdm9Cc1Vi?=
 =?utf-8?B?WklpTVhpUnZMa0gzKzFxanFSaU5QVnhjWXFRU1FJOGJDL1VWSHlrcWgwRkZx?=
 =?utf-8?B?UXV0SWs3WmRPdVdKSUV0MFRLNXFTQUpGM3R2TjNFdnl0S3d3ZjdVeXVVVVZ6?=
 =?utf-8?B?Z3dBUmJGR0l2ZGhBSFIvcFI5RjhZRTV1UlNCZkxSMTcvcXBwREtyTFBKMzd4?=
 =?utf-8?B?Y2UreVlCRDhkYkd1VzIwUnJ5Vy9GWDh3cnNjRmpUYVB5MTlna1lZRUtWSG1z?=
 =?utf-8?B?N2tkSnlha0xySDNNZ2ExekgxQWJHemx1bFQ3SmNHdC9Ma0NKWmRLZ1ZEdnRt?=
 =?utf-8?B?K0hiUmx6YXFHVkF1Y0h4SlREampRalJjY3A0Qk14c0o1OVBLZnBLU0xzZEkw?=
 =?utf-8?B?NWRFRXVZcGkrRkdoOVp2Qm9GVDlUU3c3UVZGVHdxYVVMQkVYQy9abFdNWFU3?=
 =?utf-8?B?ZG9jQkh6THpvMUJlM2FHNDNuS0JwQkx1REFYOVdhS3IrWnhKY1cxWEVla2Vk?=
 =?utf-8?B?ZGpaV0VUTVFocXdrTGs4NUFUQWVKeEhBRXo5c0ZRaDhIaTQyeVpzN3JMU0ly?=
 =?utf-8?B?Q3EzbWdWdnlIZDM2MU84U3pCcHVncGNDSCtFd3o4SlQzWDJ1d292WVJvalpZ?=
 =?utf-8?B?ZHlMcVFRNlN3a045VjZSVVc0eDJvSUVVUkdaSUlNSTd3QjQrVlpSWFNMb1Mz?=
 =?utf-8?B?NkU3bUFFT3dvR3NYWU53TzR0R29lZmt2SHFFdCs1Q29vaEdkZ2tNamtwOGFM?=
 =?utf-8?B?QnJvV3JZOHR5bXB1U28wbHlCRGgzMDFURUpqRHlUME11aEIxUlBOZWxzVFli?=
 =?utf-8?B?QWpYdFZGRUlYZUVMaFFydWJvak92cGc2R2FqTHlYQUM5T3dyYk1HM2trVHhk?=
 =?utf-8?B?bG5ibk9wY3k3K2RVTko4U1hJWFEvMjhIQkRVOGI5bEJpOVFKMHVwc3pndmVH?=
 =?utf-8?B?SUhWV0Y2U2Z6VkJTeHovNDhFTmk0M29xNDdFR2V1WWNITDRiOHVBZWE0dVBr?=
 =?utf-8?B?cUp5ZkNBNUJ3QUdiTjNzTkRrd2RlOUZ6dFpsVkc0K0VWOU1lVjAxc2t5MzZZ?=
 =?utf-8?B?ays5dHlZNi80d204U2xBcVlidnhaN1JlSFRLVG9WVjNrYThNbUhSRXdiWElr?=
 =?utf-8?B?S1Y0UnRqQ1ZlbzEzVHprU2dFRUxrWmI0eW1BYU1LaEY2bVNsWi9SdFJwdmsz?=
 =?utf-8?B?MjNrVUNPNncrQ1BiN3EzQW54Zm9VMEt1U0toNXJQVFl6Smx5ekplVkZtS1hi?=
 =?utf-8?B?OEZmTzFaZ2t5RzJPdllSQy9KVFNCMTc4eW1CbWpjaUpXV3Z5UzB4Mnkxb3hX?=
 =?utf-8?B?NElhMy8yT0xKRDd3OGpaS0ZPdkJyTzZOUDFjNW9MODN6MUhZQURUNWZyNWtn?=
 =?utf-8?Q?Nb0K8ed6fXh4Y9PE5Z0QvQd+q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e825240-5a6b-4531-c498-08ddcb8dde79
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 15:13:54.1573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kC47mJFJyh6ID9RQFCvnQxryIP93+SWRkDVfgikgMPrk5UxRGYFGxXemxhy7Pu9HsBQCPFp4eFUhW/sTEc0WQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7918

On Fri, Jul 25, 2025 at 10:50:34PM +0800, Stanley Chu wrote:
> Hi Frank,
>
> On Fri, Jul 25, 2025 at 9:45 PM Frank Li <Frank.li@nxp.com> wrote:
> >
> > On Fri, Jul 25, 2025 at 03:03:10PM +0800, Stanley Chu wrote:
> > > From: Stanley Chu <yschu@nuvoton.com>
> > >
> > > Prefilling in private write transfers is only necessary when the FIFO
> > > is empty. Otherwise, if the transfer is NACKed due to IBIWON and retries
> > > continue, data may be prefilled again but could be lost because the FIFO
> > > is not empty.
> >
> > why "maybe prefilled", please use certain words.
> The original code didn't consider the retry case, data lost happen in
> the retry case only when total write bytes is larger than FIFO size,
> not always happen.
> In the example of writing 17 bytes (FIFO size is 16), the last byte is lost.
> 1. Emit S+Addr/W
> 2. Write 16 bytes to FIFO (FIFO is full)
> 3. NACKed due to IBIWON
> 4. (retry) Emit Sr+Addr/W
> 5. Write last byte to FIFO (data lost)

You need descript clearly at commit message about this.

>
> I just need to prefill FIFO in the beginning to make sure FIFO is not
> empty when HW starts transmitting.
> So, this patch adds a condition that prefill FIFO only when FIFO is empty.
>
> >
> > >
> > > Fixes: 4008a74e0f9b ("i3c: master: svc: Fix npcm845 FIFO empty issue")
> > > Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> > > ---
> > >  drivers/i3c/master/svc-i3c-master.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> > > index 7e1a7cb94b43..34b6e125b18a 100644
> > > --- a/drivers/i3c/master/svc-i3c-master.c
> > > +++ b/drivers/i3c/master/svc-i3c-master.c
> > > @@ -104,6 +104,7 @@
> > >  #define   SVC_I3C_MDATACTRL_TXTRIG_FIFO_NOT_FULL GENMASK(5, 4)
> > >  #define   SVC_I3C_MDATACTRL_RXTRIG_FIFO_NOT_EMPTY 0
> > >  #define   SVC_I3C_MDATACTRL_RXCOUNT(x) FIELD_GET(GENMASK(28, 24), (x))
> > > +#define   SVC_I3C_MDATACTRL_TXCOUNT(x) FIELD_GET(GENMASK(20, 16), (x))
> > >  #define   SVC_I3C_MDATACTRL_TXFULL BIT(30)
> > >  #define   SVC_I3C_MDATACTRL_RXEMPTY BIT(31)
> > >
> > > @@ -280,6 +281,13 @@ static inline bool is_events_enabled(struct svc_i3c_master *master, u32 mask)
> > >       return !!(master->enabled_events & mask);
> > >  }
> > >
> > > +static inline bool svc_i3c_master_tx_empty(struct svc_i3c_master *master)
> > > +{
> > > +     u32 reg = readl(master->regs + SVC_I3C_MDATACTRL);
> > > +
> > > +     return (SVC_I3C_MDATACTRL_TXCOUNT(reg) == 0);
> > > +}
> > > +
> > >  static bool svc_i3c_master_error(struct svc_i3c_master *master)
> > >  {
> > >       u32 mstatus, merrwarn;
> > > @@ -1303,7 +1311,8 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
> > >                * The only way to work around this hardware issue is to let the
> > >                * FIFO start filling as soon as possible after EmitStartAddr.
> > >                */
> > > -             if (svc_has_quirk(master, SVC_I3C_QUIRK_FIFO_EMPTY) && !rnw && xfer_len) {
> > > +             if (svc_has_quirk(master, SVC_I3C_QUIRK_FIFO_EMPTY) && !rnw && xfer_len &&
> > > +                 svc_i3c_master_tx_empty(master)) {
> > >                       u32 end = xfer_len > SVC_I3C_FIFO_SIZE ? 0 : SVC_I3C_MWDATAB_END;
> > >                       u32 len = min_t(u32, xfer_len, SVC_I3C_FIFO_SIZE);
> >
> > if prefill to FIFO SIZE each time, such as
> >
> > replace SVC_I3C_FIFO_SIZE with
> >
> > SVC_I3C_FIFO_SIZE - SVC_I3C_MDATACTRL_TXCOUNT(readl(master->regs + SVC_I3C_MDATACTRL)).
> >
> The free space is SVC_I3C_FIFO_SIZE when FIFO is empty, no need to
> check TX count again.

My means is that if use above logic, needn't check helper function
svc_i3c_master_tx_empty(master).

Does this method work?

Frank

>
> --
> Stanley
>
> > Frank
> > >
> > > --
> > > 2.34.1
> > >
>
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

