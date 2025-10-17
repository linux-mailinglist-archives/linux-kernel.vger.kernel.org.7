Return-Path: <linux-kernel+bounces-857364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE65BE6A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BB5627DEE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CAB3126AF;
	Fri, 17 Oct 2025 06:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="aa9mzEEk"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011044.outbound.protection.outlook.com [40.93.194.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7429E30F55B;
	Fri, 17 Oct 2025 06:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681676; cv=fail; b=DNNg0ZpcYRc8TbR3u068tAUPOT39KKj+NACPHb6ZOWX2WUeMi72m8OboCqj1NB48Ate/E6FTq8PXJebutJZPFPZWpsrdTDSOVu6iLV/NHlnyocqaN2kND5369HA63Qhb0CnRqXh7L8tBN8EgE46nvekWMNfN+R6L/A6ZjHEbSkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681676; c=relaxed/simple;
	bh=0vBEZuVGeDCYrBG/8hpGFgKwLWNI/yQk+1/DLNO9CRI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K2M5Vxy+AJWMTikWEaDI/vbE/Zf68w9EcEK7iyJoZRusWs+TKarmZ/cyvtd1HPRxsvEa4voctZJfDZkQje1VdZ7KD+n3VSSGjsWla3tYTH37SejhY130Hl3ecsOqv5Jm9xvqrVXdegWqRX/qez1j6avnnlM28aHZjIUWtFyrimM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=aa9mzEEk; arc=fail smtp.client-ip=40.93.194.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmrdsEVsHKzAE1fyrxbph/VKZ9XNDu+IBYqggnW4i6Qh72j4ZuxaVC2IAH9LCGsezVPT13sPSwxPVxtTu9abPc3W1K3hBGZ5G0HcLk5f/FVZGwUvIYv/YitMyfvpa4/IEAcbsCdcJPZfJFiL1pPPGOSgd7hbFdOx/odPH8fiEUWX4rNZwImqflg0Ncvkwsv20fJJYW+ygs3jGx1Bc9xM9UY6kM0POdU19b7VhYSRIOrxc8FoH/NpCoTIxs0AZd27DmKq2eH/Ms5z5GTNyt/oCi73lduXHZKIeuoV1qr2dtXPqqS4GgTRK2ygN7TY1lYrms3VjqXdX7ejsbiXXMMyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYDXVwIAm9wzGpnAkArcbaw9qu6kdutwUmyR4VCk5O8=;
 b=slaHlC/DdMG7BdtXlouZwfd4h/fM845ygaY9knxigaMBfDWgvazP3YXqLn/luWk/FIPBomkzv1HVRmj+ULrf6uLXpLCazcaQqwX0eYqGgLMHZafAFGcKgelGXI2uv3lyBki0aQdRkR9XYbW0XaTgbUSxxRWtYYqxM4udqDtVpCsmV0MBXRnHsBI8EUCiPzZqKJc8qo96Jbe9QZ61HDuirOkwhjCXBueVDTxblE+UczN8nhNeOrVTQithWX8v6Taf3yx6PCueGcyUDCdxl3fLqlTNu96rvOdMOS0/HxgomWXXfo/eBXP6BabjpRO9obfK0dboEtHHayXt1qY3QMY1ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYDXVwIAm9wzGpnAkArcbaw9qu6kdutwUmyR4VCk5O8=;
 b=aa9mzEEkmZESlxJk7cpUTYkEnHk+FscYc6FtZ9LkA3ta2tFnrLGNrrtx1TWaiuBDpjbVfoVY1IPoXpFjuSp8z5+sIvg3uZyqOh/eLcVY1MRWmRGdp7nCN76O2aF6d+ehH1/P+cv7qol5bIW4CT66Q1xuB6Db4bOzDr24FimLsfSveAtIt8IjCK1G3y3c6At6NLaB9K5DzVYtdOShHPOeShGro7IMrVmqXXxwB1FisBqUHZU8uc5lj+ukXhL3Ni8jVJsTwrzckY1p5R4N+iIVkxE2PheER8f+Lqp231NXifAF7VAlqJRxBC0LkPrhT4dlkL9yov0V4klgwg6L8AhnGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by MN6PR03MB7719.namprd03.prod.outlook.com (2603:10b6:208:4f4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 06:14:29 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9203.009; Fri, 17 Oct 2025
 06:14:29 +0000
Message-ID: <9281bade-0d14-4fbc-870a-120101dc3a67@altera.com>
Date: Fri, 17 Oct 2025 14:14:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Change Altera socfpga-ecc-manager.yaml
 maintainer
To: Krzysztof Kozlowski <krzk@kernel.org>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthew.gerlach@altera.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251017032736.3206400-1-niravkumarlaxmidas.rabara@altera.com>
 <b331600f-af5f-40b1-8acf-007044fd34f3@kernel.org>
Content-Language: en-US
From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
In-Reply-To: <b331600f-af5f-40b1-8acf-007044fd34f3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU0P306CA0048.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:28::11) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|MN6PR03MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: 591b07d7-55de-4a57-c496-08de0d446e28
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUhZSG0zY2Y4QWJUdis3N3dVWVVXbHBpTVZ1YVZEV2J6K1QreE0xcVl5NGpk?=
 =?utf-8?B?SEpKVCsvdStPUldjQVJGMHZ2S0dXamxQTU9LSHd0MmNsM2VBYVpGUUNJMFo5?=
 =?utf-8?B?c3IySUwwNXk2SFlnSndvZDYxS2ZPa3duWEJzb1drSXlXeVBZQ2ZoQU9lOVhM?=
 =?utf-8?B?SlZYNlp2NXBXenNIaHRXNzNZOXc4bmZNdk13UUp6SHVCOHNLb21rZDU2SmRk?=
 =?utf-8?B?WU9UU0Ztd00xcGhFc2lmdTc4VEpEdkJ1eG1TaWR0cW1la3pYQ3htSVM4VVVP?=
 =?utf-8?B?Z0l3YXluSmhEdXhVUUJtSUNiT2ptVWlqM3RPVnRpZVdadU9sSVd4Z1J5Mk5N?=
 =?utf-8?B?azUvbUczN0FZeUE0a2JqS0FGMzdwUEV4aGhhdDVxandVWlVzaE1MZXdXTm4w?=
 =?utf-8?B?Um50UDc5ZUhvdUQxaFd5OWxCN3NWQ1ZOZFB2QzlISjFYam5Vc2xCNEVJSVFn?=
 =?utf-8?B?aW9kOFVFamk4SDBkek9odEZpR1RxOThxclloTnN3OUhra3c3MWI4a2NNMWlD?=
 =?utf-8?B?UERkTWc3REc3Z0ZSakVzYXdnMnBhZUhwOUhxVk5SWWw2N1BtZ1k1ekYxWXhE?=
 =?utf-8?B?QjdFUmVGV1pkdHVvTmlVcS9NQ2dlOGRYN3diSGc4aUJ5WGdyOWROSzZ4TlFl?=
 =?utf-8?B?Sk5Eemd2ZE14U1NnclpzVVNoLzBoSUQzaGxUMCt2ejB4MURZUHFzcGtEWnl6?=
 =?utf-8?B?cXUwc3ppSTNrMVRaSVp5STNjWFdTc1Z3eWVYSlJ0MjVaUkkvc1puTFBvOE5S?=
 =?utf-8?B?RVArZGlkdzF3WkRwckMzNFAwdERaQXdJQ3FMYU1NRTRoUExiR0EwOG5qQXFm?=
 =?utf-8?B?elBoUWVpaWs0b3piQzA3RHFRR1BndUFmd3BxTEduMXpzNnZpNXhOYUt0eWFK?=
 =?utf-8?B?VmhxdVBPVzRseHJDcWIvaTl0U1FuRGR2WEZmUXg0Qmpxc0JoeC93VHhZaGRB?=
 =?utf-8?B?LzJHRTRuRlFjUVQ1L1V4aWQ4S3k2cG9yaFBwK0NEZm1FTjhPK2RybnJjbDBy?=
 =?utf-8?B?UVlPb2pxNldzYzhoQ1ZoRGhrSkY1Q2FaQ0lkYldiV09ObDd1VU5Sb3RNVnEw?=
 =?utf-8?B?b0FDWVpvbWM5RzJUdjZHNnVnUCs0Ykw5WE1wVkV6Sk94VkFvZHVEZ2FjSVBS?=
 =?utf-8?B?VGVRWGZCa056WXNkNVAxcFNiQWEwQ1dYMWRoUERVNEl0c25sQi8rOGRFNExM?=
 =?utf-8?B?Zit3cTl1TWdVNVpwQXJZOHRlcWhtWUQxWmdqblk1RXR4bzkzcWxwY1BJVnQv?=
 =?utf-8?B?bGo0WE1XMzhHbjJmc2k5NllaUTFjdGxwRHAvRE5hZ0poUVZ4TTFwaEpDZDBv?=
 =?utf-8?B?WjRzVUU4M0k5Z3Z0OWVKNm0yTlZhNnZ0TmpGMEhlak1CZnNsN25vb1FTaUhl?=
 =?utf-8?B?dHR6WHlSZXJnS2t6cGptMkd1d2pjek9WVTBLYmRtdjREYnh6V0RQR2VDSm9x?=
 =?utf-8?B?ZGxrRTRQSGRXT0JOV0J0T0dDb01Ed05lSG5yL0xMRGRkL1BGRWtlRHVmb2xW?=
 =?utf-8?B?aCtucXlUd3RJTThEbFBKMkZJdWdvWU1oeXc1WUdJeXNoS3pGRkNWQ29adnJp?=
 =?utf-8?B?NTVCTkJFRnRTRkkrS0hYTE9TeWtRdERpdXpveE5MZndSV3NiamdZbVhvbTJz?=
 =?utf-8?B?VFZ4dEZWWlptMkpXUFA4VUtrWWRSaHNuTWk3REttTHlMQmpnb25kUlcraTZ5?=
 =?utf-8?B?dEdFclZ1R1hyWGJPWHZJakhtMUpEZ3BjSkEzWFdUekRVVlR5R3ExMHR3ckhX?=
 =?utf-8?B?Nno5NVdWaEVBdzJ2V3JnM1dhcFlSZ2lWS25sdjRVbkpVYk5MTSttRXlKckR0?=
 =?utf-8?B?RjZyalVhbEowVFB5UnhCa1BMTWIyc1FXdXFxYWhady9XdDQzS1lMYjBDSjNH?=
 =?utf-8?B?TTA0Q0pOelBNRk85bCtLQUNRalVUMi9uczJmZnBUelcxVDdzM09yVncwUHQ4?=
 =?utf-8?B?cUNFRmNGYzZSakZ2ODZIZ0srWHlhS0Z4TGVJeUw4WEtRZkZldHczNnBSdVBz?=
 =?utf-8?B?YVRIWjlXbFNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFA1N2NrYmZLUFJBckZySVR1U3ptbDFIQTZSKzlNSXZzOFY1SThyNVlUbEE0?=
 =?utf-8?B?eGJqK1NjWUtWc1ZJU2lmNWFJTmY4Tm9jdUFXQURoNXcvT041R0hST1JtejJv?=
 =?utf-8?B?SUpSL2VwWjQ2aDBzU1RjOUs5UVdBYlJDb1I4aCtGNVJqa0haWmNrWEJGNnNt?=
 =?utf-8?B?ZzE5bVBtK1FoUjR5NU53T0wrcTlxVlN4LzhkSHkvUXpMeldaMXYxSXFKOFNC?=
 =?utf-8?B?azZETXk0NXl1eTIrOUwreGI1SGpDSDZwTkt1Y2ZVc0NCU05kLzFvazhkUDEx?=
 =?utf-8?B?d01rempJdkRseFBoWlBuQ050eFJJWlNOYVZZSHZsY1Q5cFpZck9yUXBnQkFV?=
 =?utf-8?B?OGJ3Q09XUFJPc3BYZEpnNi9BVkJ4Y2lJUGtNTENJcXRxS0FFeHVpKzIrc255?=
 =?utf-8?B?MXRuZFh4MjZVY0xSVThCcDNYOUdCb3FGeVVtd3F6TzloTVI2TEFzVktabXNM?=
 =?utf-8?B?RnRCK0k5YW45MWVRcElPUWJ5cWY2ZW1BSFBZMUFpT3lVcUNCUDRyN1RUTW5z?=
 =?utf-8?B?Z1g4aUpzQXRzMjFmaUhXaWdCcnN4MWpFZ2ZGL3lraG03NSt0eFBEbUs1SzR4?=
 =?utf-8?B?WlMrL3BKNUdDZERJcXV4bHExa3ZuRzBySHB4NEVUK1J2TnUvMVdYTHJmcnlo?=
 =?utf-8?B?cm05OTRLRnJyZzY4MFBzRnpaT3pQdW5qenVZSUNZdGYwaDRPVXkyVFVaNU8y?=
 =?utf-8?B?aHdsaWtyY3dCcXFrcldxWWkxT0tVbUw2REJUZnIwdGM3VTJTalhScFFjWmRY?=
 =?utf-8?B?N0RFWFRRT3ZyZjhMaGdDVFVYWUtaS1dQVlAzRVE5YzJldHNaZE5qTlFOd0Jk?=
 =?utf-8?B?eEVmaTVkSUcvL3JhS1B2QzBkOWlsT2UycDBXK3ByRDJsWXlpdy95N3lxaFdt?=
 =?utf-8?B?VDkwbDlDRmRlalYvQlVRNjYvcithc1FHSzNGSFpsQlN5akhCT0h2THhLeWZn?=
 =?utf-8?B?TGZWNkMyTEIwL24rMEhCR092MWp6WElzU0NITlh4WWJRbWhmMHNpSnNvRjgz?=
 =?utf-8?B?eDFKWUcyUkRJejlWc1hraEVhMXRMSEtHREd6aFpRdndmb08xZkVmY09STXZj?=
 =?utf-8?B?cFdQMSs1TVNaWUxoYTBQZStUcVQ4bTBCNlRVdWJrc0txNXc1Y25vb1VCVEo1?=
 =?utf-8?B?NWRxckhJcG9BUkdXVlZQMmROeU5kd3pGMHNOalg4R203clJxdXA0dlVYUkpD?=
 =?utf-8?B?KzNvREZEelp6UFRGdk9rSWxzaUU4Y2YwL2pHaCtkb1RzSmJTV3lGVk9mWnNK?=
 =?utf-8?B?UklTN05wK0xncUh2UkVWS3MxSkR0VGZTeE9IaXNXWXNnbzBjaEJDdEtQcWJO?=
 =?utf-8?B?eVVRMUI1Q0dnb3V4d2s3QmdYaEpmdktiRU93YmRzQ2pGbCtJdjNYUlRsUXFP?=
 =?utf-8?B?QU0wQ0tCRUJwWVh6ZTIrNkFCeW5UZk01SDVCQ2Jsb0puSDI1ekJ2NHV4QktS?=
 =?utf-8?B?V0ZQZVlmWVBGLzloUDdDL1NBM0dBdUh4dWNpOU1LNmJreFg3VVVEUld0OGpl?=
 =?utf-8?B?MkZHQUhIeVZydnoyajNuWi9hNzV3cXgzWGFEWnVzaGZrdTRpbmRUVXliVk5H?=
 =?utf-8?B?OW9xRGl6cVIraWJaUmFGekVOSEV6alJ6dUlnU1dxb0RhMERJWDB1WDJneFhE?=
 =?utf-8?B?K0lWRTB2aldPSVdBUVByODV5cE5HMFhFSE05ZzlHVnVoNWZCZDk4SXQzdENj?=
 =?utf-8?B?YWVVOStwbHBqS05DMU1RZEdFd0g1bnY5SUd6aGVIcUllaDNlbFR4QUVMOG55?=
 =?utf-8?B?V1VBRjJQbHJmTURMSXpFUnIrS3E0SnViM2pIUXRlNUpRdGNwVGNrNVJlRVRo?=
 =?utf-8?B?VTlQTjRGL3dUZzlYcDV0TTV2K0JZbUJhVHBGOGhSK0N3UnFGYXFVQ2VMeEpv?=
 =?utf-8?B?ekM0a056RCtEWHd0c3l2NTc0cUYrYnBwa2VTNEZGSmFhTGVyNkxwN2h3ZFMx?=
 =?utf-8?B?LzNHSDMzQVN2VVVFUjhXeHpuSDF6WXlydWFmOE45MVlGOXBnMnF3aDhvajdI?=
 =?utf-8?B?MjYyVFg5OVNoVXhhTnhtU0RmZ1JkeTl1K0xzNjdpdG5SQmVvOXZBaXBSa05F?=
 =?utf-8?B?eWFNTVgvaDRwcHVEN1V2eHJnWUxuVWZlY3EzY2E5c3VBOGswWHRtMFFDRW5M?=
 =?utf-8?B?c21lWkRSQlFwQVBOeG1FYlpuTkMveG5iNHo3b1VlcFN5Z09hbXdyQlc2bk9M?=
 =?utf-8?B?ZmlIVEpiT0RzZUlNYmNJUU1NNDIrdFg2RUErc3d6U21NLzNSMUlYZjloMDJo?=
 =?utf-8?Q?Z+RshoNYGjtS8tejwAqI5yTdcw+EWNeP0mKJM2NKeg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 591b07d7-55de-4a57-c496-08de0d446e28
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 06:14:29.1772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sd+nBBTAh/v5xi/hMO0bJDh1TB84sfdp5kgpfJ8v/SMxENM3odVDn+qQD3y0n60vabA5V97kVtTKG81EZuXyJk6vQ7GX3AnpDgE4pg2X33aArpAQryj/14sylK0c7mQQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7719



On 17/10/2025 12:36 pm, Krzysztof Kozlowski wrote:
> On 17/10/2025 05:27, niravkumarlaxmidas.rabara@altera.com wrote:
>> From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
>>
>> Update Altera socfpga-ecc-manager dt bindings maintainer from
>> <matthew.gerlach@altera.com> to <niravkumarlaxmidas.rabara@altera.com>
>> as Matthew Gerlack is moving out of Altera.
>>
>> Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
>> Acked-by: Matthew Gerlach <matthew.gerlach@altera.com>
>> ---
>>
>> Resending the patch with complete maintainer list.
>> Link to previous patch Acked-by Matthew Gerlach
>> https://lore.kernel.org/lkml/91cd7ccb-e821-48de-8d52-f8889af80a08@altera.com/
> 
> 
> So that's a RESEND, mark your patches correctly.
> 
> It is great you stepped in to take care about this driver. This also
> means you have new responsibilities, like learning how kernel
> development process works, including how and who takes patches. Please
> learn that so you can send the patch to appropriate people, otherwise it
> probably won't be applied. For example I do not apply patches of which I
> am not aware of. I know that many maintainers follow similar rule.
> 
> 
> Best regards,
> Krzysztof

Noted Krzysztof. I will take care next time.

I just realized that I have made another mistake, I supposed to update 
the maintainer name in yaml bindings as well, which I missed.

I will send v2 patch with this change.

Thanks,
Nirav

