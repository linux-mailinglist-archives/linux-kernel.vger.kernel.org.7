Return-Path: <linux-kernel+bounces-839266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A4BBB134D
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 18:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60031947271
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 16:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FB628003A;
	Wed,  1 Oct 2025 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SytwcyZa"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19011075.outbound.protection.outlook.com [52.103.32.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9672773F4
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334694; cv=fail; b=A7wyeqEvrZL+0fDTBzrxxhlQzA+KSY/J8G8ZJTse6121IN1tx3F+NoB4rQWrfI244J7ZQdV1EoeOMAyloCLm3s3l7iu0jajZj++YgrjCgnw/A1wUBZ7OL8/EsQmYDGetmKtjZ/x4Ro7lPkOeyE9HXRAVInEL3r/h0zIWTljaR34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334694; c=relaxed/simple;
	bh=2XS4biIDtZKHPxi/H4foYjiVunA7+mbKacQzxrPYGLA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SuveWfFtmKUbUB5nCvWme2/3D07cL/Z299hguAEcT2FTn7oeUrSX46fuzETXRmNxRd5t2wJTOfG9+D+sGInjjd5efycvOJ7lw4GzvY5qKAAsinGmDOPtDEeqU/g05fxC+kV0Q/pl2sE6HrroLlTNfN2KXVlKOqDKobHFH3AHOLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SytwcyZa; arc=fail smtp.client-ip=52.103.32.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYwCbDl4W5r3W+MxL8UBI8i8SPvlEPpu6W63CLh5J/YeS2kBfxMuXcI5F8TqkKdxWg53SgAM18m7+pMHT0m3Zx0RKXcHIpOR1A+Q6F21jpEf+XbLmR3IFAVyUi5zVfaiIVjWa8ga2AIN4/OjaWXOojsAVnFH63d9X5otsZO17LzKFkX4u2GIS8tHlsbyUqn5YXGEfnWzptjHRPT+B3F8r0V4oIgoO/j7TRn3ASk4/ZW4kfkSAVmYmxE5lxIMBScxd1DDffI6TziJpKMM04h4C1PczEOB+PkQvfZ54zXBgvBA1HEZUOeP4A0SknoVKPP3U2dBzYBOPEoak2hgnwVxPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnST43IXYDFXTzxFJTRjZj3wirJtxE1K0vBwAeeLBAI=;
 b=qfcxoj1ed3spmQcCCrldQP9r4kVlxzhbJF6+uovlt00EAedPZjEJlABJDJn+n9nDXidPcDTxGLfqfyoOPRKfb6QmvCcgnnyQCJs1Nq16kyK5ri/o9dsRvqp+mKbGJcrZpO92+0DzJjIhbyPgEy7rn9nEWAR/q3X8FOQEGVuZdMf0/WAJ+WcexssBGcKKIqZDJwviMToVZCMhsJ7yxXpNUwA/s6tZ0hF2m8m38QMWShQkrEGpgBKAryN0q0o3blNvoei/v1qx1Q8xU9lDg/eMAmQWJntZQEciCtLAIZ8TFj8DGjtcx7DsLxAddI0lvk9Nc3P+3oP7rrUyuQ7ZlMsfBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnST43IXYDFXTzxFJTRjZj3wirJtxE1K0vBwAeeLBAI=;
 b=SytwcyZaHKxpbq0pineP/iApvldXb05N8Y6RbwF/Y80EG0PjUqfhjOAFpWaZ3m+TeDsVqJYlwNSEqhfDWopMDH4PVcrX9a9+yLE/gUvUPKovRiW2QldxhVFQcpu4x2zfhKiFKz9pbXDimYuJtfbc4+dJl+sO3AxSA1MugC0kZ352eXaYWN5iPDh2WH2bXeFXz+4ayCadutaT+7UFHxEs9g5U6pDniTiAsvUQy11uTWjIF37l8lvE2AYqyevDcI/Eco886rGClz01dSmhe+IBd8k0Ac+60rFpY+9xwWAOBa2x0C/56+MyzbM9sJ1hYj6sPB8EwheTsCNS+3JoBxijVQ==
Received: from VI0P195MB2739.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:2c4::5)
 by GV1P195MB1644.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:50::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Wed, 1 Oct
 2025 16:04:49 +0000
Received: from VI0P195MB2739.EURP195.PROD.OUTLOOK.COM
 ([fe80::350:3f3c:7e09:a9cc]) by VI0P195MB2739.EURP195.PROD.OUTLOOK.COM
 ([fe80::350:3f3c:7e09:a9cc%3]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 16:04:49 +0000
Message-ID:
 <VI0P195MB273993B2928F985EAC763375EDE6A@VI0P195MB2739.EURP195.PROD.OUTLOOK.COM>
Date: Wed, 1 Oct 2025 19:04:00 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: Make sure CPU_ARM940T kernel can be built.
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux@armlinux.org.uk, ardb@kernel.org, rmk+kernel@armlinux.org.uk,
 ebiggers@kernel.org, nathan@kernel.org, rostedt@goodmis.org,
 kees@kernel.org, dave@vasilevsky.ca, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, trivial@kernel.org
References: <VI0P195MB2739D000BD1BF18B3B718F93ED1FA@VI0P195MB2739.EURP195.PROD.OUTLOOK.COM>
 <CACRpkdZbwuf2Fgtq+jyqzqspb37-P6X4O9xqkG-mSb+afSjh3g@mail.gmail.com>
Content-Language: en-US
From: Franz-Josef Haider <fj.haider@outlook.com>
In-Reply-To: <CACRpkdZbwuf2Fgtq+jyqzqspb37-P6X4O9xqkG-mSb+afSjh3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3PEPF00007A8D.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::60a) To VI0P195MB2739.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:2c4::5)
X-Microsoft-Original-Message-ID:
 <48d4c4d9-3b01-4816-ab8f-ba435906003d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P195MB2739:EE_|GV1P195MB1644:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ffecc0-d496-46f7-18ba-08de01043f91
X-MS-Exchange-SLBlob-MailProps:
	vuaKsetfIZlps6CageNK96R3p6oJJ6xNlHgoYaq464AQ5D0hKtVB1p4VlmEAdRF9FxqIlnv+7KVRoJLHiEdXfU8NSXq1PxwbUdgzOIkKCzExV9kRAG7iRWYobDppzm++QCY4Hua0lSJ3jWFZTofQRD5fGOw4nAlJNNiacFTZPeZgPafhypZqR67EYKEt0q60i7wxEO6SjYREeezgjw6hgcIoOKeRMEplcp4IJseI4YXjnP0/JrimmV9TNU+BJKsLEeyC9G/x+j9zEHlu9hM5p1eKJs/aC9MqrHkfUSOxmWwF9ky0BdEAQqPP8n9WF/ceDkmY574GFaFl+aiSneQXOKUB90DlTD6ZKcs6g8vYLrmxOh569YaNpAVdSYUEHRe1+5zoZnjLbxzq0ZtxhjOAqo3Cbn9ebOrBnlFHNQrHK0//Yzy+lYV3SIbZb6F9iWEsc2Xbt7v4lRJZPHlkDAjKMlapFvDGaL17INvAr9yBgWcCHvIpvj4c63wj3rEMQVVl888pGxoXculCK31ouxpsOJah9/xCDyqnDrohlpvQ5gdiHx7OvQAJgnvbAHdci5eUDWZkzKGp0V/VMidjRB+2mnwMrlbeV7ZOWmM/7NlQ46GWNYDGdCelH12GDEFFNDM4YZIcY6oH0Hbrw+rycd2miO4jBrXiKimGpIvrwnVL1lGhGEkJg7BY0BHSu1S+qhXBDzJ80hhJHGy9/hF+dpAtznXqIbUrIJdwksjjKqgp+/YydHsGvsD7hlBbVifOZmDlYbxfOjAi0zPNRza8ZGZOBfvgZUhzEZ1le3N3OpmiT9HQfJDN2+nRQ7In6yyUV1z+
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|461199028|5072599009|6090799003|23021999003|19110799012|8060799015|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2hoR3h2VlJIVE5ZVGkzdlZQdU1jYUdqWE9udkY2Y3ZJaE90dWw3bEU3WGts?=
 =?utf-8?B?L044ZEh5Y0sxR0l2OXNEYk8vNnArSW1xem9rSVVEQkNFVEV2WjlHVi9BeE5Q?=
 =?utf-8?B?VC9oMExoNGNBL1l0aHNyQVUvQkhpR0tsdUMzT1g4WFJMSUhQcG5xdmk4Smky?=
 =?utf-8?B?Tnh1Ui9WOVhQTmZPZTdzVUM1UXpUZzNwVU1tTzFSR01Hay8zRHNNV1dtWk03?=
 =?utf-8?B?elE4a1lySUlySDVXQUh4RTlVMGtMbDNIczk0dmdzb3lvcEJwUnZEZk0rZHRo?=
 =?utf-8?B?QUViMWFQNzNrVlMybFZ6Tk9DY2pjbkdWek05d0xiWWpVYVVnQk1pU2JZdzhX?=
 =?utf-8?B?bDhHTG5OUWU0Qm5MNWorMUNFbE5CSUpPL3JVT09yVjVHQUtMbjFxMkVoNnNO?=
 =?utf-8?B?QWtkeTAvdkFDTS8weHFFL2g4ZHJMY3RpQTAzaVVVNVFxVWhXaXZITHBVVFVR?=
 =?utf-8?B?MW1ubjVQWHdobXNSQUF0dW1PYjN6NmFUWW1RRjBDWE5jbWQyZDNLTFp0WjJk?=
 =?utf-8?B?Z0s3eHJWUFhKUjdUcU1qOUVJeU1vdWR5L083RnRWOHZZODVWVTAwVUlVekdM?=
 =?utf-8?B?SXRKMlpkb3AwOEVGRnZMTU5xU3Y1MFBSSEVIckZ5bkhBZVVMc05WdlJsWHBk?=
 =?utf-8?B?T2FDMi9KRXpkZUp1Q0U2OHZPZEQvWFNobnBrL2hlZCtkSjdWOTZNODVNay8z?=
 =?utf-8?B?UEZ6T3ZTaXRkWTY0UG1uRmo2ZEM2akQ4aXRRdUFSN05KM2kxUHhFNXBmUWtm?=
 =?utf-8?B?b0FjMEdtVlRHanBXbTBxYXlqWC9DR2J4T2tYNWdPWTJVTXU5Tm9rUEVxR0px?=
 =?utf-8?B?ZTdnTnFLTlUxZkpiYzBwSVNVYzJWS2pncE9vM1VvRHcxakFVRjBITFZneG12?=
 =?utf-8?B?WEJ3RCs0MEJCcmtvSkF0RTBNc1JoZ0ZIbVRIK0JCL3Iya2V5TTdXWDVJYlJw?=
 =?utf-8?B?bmdFV0UrMXlYdTRqWnFFL3ZDS2pUTUwrUUpkenhlTVN0RklYNVBjTy9tS25u?=
 =?utf-8?B?VjJHaGVNRzdQUTBHK0F3WmJrS3VNSnQ2NXdFSzZ6S1JvSzZGT0lyMCtTREMv?=
 =?utf-8?B?Qk9nSnV2N2xBUzFOSDBHSmU4S0s1RDFITEViSTd0SVZNWmljSFBYK1dFVzVj?=
 =?utf-8?B?bHoybGR1WmRHSjRPalVhQXdYdVdqQksydnIzdlQzZkYwNmpmbHkwelJHSUds?=
 =?utf-8?B?dklZcWtBemhhc09TTlhvNitEMVFIc0d1aUwrWHY2VFZGY1c0aEFSYjRqdFBM?=
 =?utf-8?B?U05jNm40UmNodmx5M01lcWJaNzlzOFFUbUVPVzZ0NnJMbWJtQlZKNE9rZi9J?=
 =?utf-8?B?amNtS2o4UEIzblVyL2hwVzNBQ2dxRWFOTklLQitKUTRGQ0k0SVBuRFBoRFpW?=
 =?utf-8?B?WFU0WEF5enJNQ0dsaXdKaSt4bFhwOGN3TUhPcUx3UWJpb1JYcVBaMDhHL3dt?=
 =?utf-8?B?d3liOFR5d2RCaWc1SWM4aTRYOExwYnNVSzNxNWJFTW9XSi9JeDduVzh1SUlM?=
 =?utf-8?B?c0Y5YW45VVYyM0J5VC9uZWhkcjBONjljbXBoNE9RMG5vWVArSFlLSjVIZ1pP?=
 =?utf-8?Q?IK3xcBwKBPqb19ZELETPgoCiI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGVHUGpkM0VsRzdINXk2dHNwRjBHOTZ0cnVpVHNod2w1TW4wWThNSUlHb29B?=
 =?utf-8?B?OEJCRFNnK0RKVWVkWFd3L2ovSEhwMVVXVzVTbVd6UkVNai9HN0NrMEtGeFpH?=
 =?utf-8?B?eCtRQzc1VXVnWmZTdGJaYVNob2MvMEh0T1pWZlBFN2VXOFhEZ0dkdGEwTkZu?=
 =?utf-8?B?UnMwWloxcUNOOXA3MlN0eldqdmMyQ2g0WWZ5eDFJbzVQVWVFK1JLWE81aitK?=
 =?utf-8?B?bTByRmhTekg5eS9PTk1zeEc0RkNJeGZZOXhsbUhOTXQxcWFEUmxCYmxKL25p?=
 =?utf-8?B?aU5QOWV2MGJKRlhXczhEMVZZbEtEN0hBZDB6c215R2JFVjBsNkhTZHZ1bzdv?=
 =?utf-8?B?OUJCdHJJQ2ZKQ2puUnFnbnJ3YncvMTc2RHdCLzVkMmNXUHV3UDNibVRiWGc4?=
 =?utf-8?B?c0FUU3UrV2dnaFRrYkY5dncyK2UwOHZQSHF5OFJsTXp4UUM1Z1ZRaE5VWVpi?=
 =?utf-8?B?dkh4UFB1MEQwU2MxdWxrL3RBR09UdXJBK1NKZ3RrU1g4aXgxMkZVMldaWEhu?=
 =?utf-8?B?R05BcU5yNW4rUWpzYnRpUTZrT3VWZVFYOXF1MEhSRTZ0YkprWUdQQ25ELzhs?=
 =?utf-8?B?UThRNkQ3M0czejlKWHlUODhodWFhODBpajc5MUoyVFRmVytpRlU0OFRNc2RN?=
 =?utf-8?B?V3ZVUVkwb1JWQWdRZDdjbTR6bkxVcGpqRGNES0dJR2NQZVdrSkV0UHJOdDdu?=
 =?utf-8?B?TEFlYmRpMmpIcWhaMmx0Z2NSUHh5OURJM3AzZG5qVjFIZW9OOTlSSWRlekp0?=
 =?utf-8?B?blA2OTdzeWpnSWExWi9teHp2ZjdwUFhRb0JOcVdMTnpySC9kNkdZMnlGRjZN?=
 =?utf-8?B?emJtdVplOUplL2tlaXdkVUtDclRqVXIvZXhpTU1JNDV1Nk1mUWhheGN5WTBt?=
 =?utf-8?B?SUI0aW5yWTdzRElNcTRHREc4OUZLOWRwZUpUOUtBSDVUUWhKcC9JQk9xbVRY?=
 =?utf-8?B?c2VpQXArNHhRMTZwY2VjaWcrRllpS08zODRDWFNLWGxCUCtBbzRrVGtFZmgv?=
 =?utf-8?B?V0VDQVM5aE5Fekp6U0hsTno4ZmE5NVBBR1gvTlFHY2ttTHBzVk5GT2N1Rm1n?=
 =?utf-8?B?dE43UVNkV2JLc09acXluN1JlOUYwUzRaVis3Ykc1dklVenpzOU53ZlRPZnp5?=
 =?utf-8?B?S2ZMaWxjQUNNSVJ5ajdrSEljcVVkc0g1MGNNT2VzUXZBSUgzekw4alRROVBw?=
 =?utf-8?B?Z1ZabG1ubXVuUElLSlBqa21ZaUdCeTV2bFVxVFluQUtuOXVSTHR2R3o5WnJU?=
 =?utf-8?B?S1FXVm9PSHEzYXpyU3BsM1lST29BZXJBYlM0UXpYR3ZYdU96TXlmQURwNHcr?=
 =?utf-8?B?a0dRUjJaUkM3QVFValZWZUR5Qm5oaUx3dFVnZ1FEN1Q5M05USXdnSkRHWjVs?=
 =?utf-8?B?WFhBQkxQc0dscHhqRHA4cm9ONzNqMnFWcGw3U25CU09uSlpJc2hBVkovbkVX?=
 =?utf-8?B?ZndlamdYdTNzeEYwdlRPMGZDY2NvOE5uN3RCL3k5dThZRXFpaUJtZmNsbHZk?=
 =?utf-8?B?VU1teFlYZmhmb2FBc0R2UVRaTUlqL1JKb3I3TWwraU5taDJmdmFsYWxPNUlr?=
 =?utf-8?B?ZDZucnZ6WnZGRWRjRzd1aVBrcmo5ZGpXTlpzR3RVVXV4SkxlRTNTQ2pUL3Bl?=
 =?utf-8?Q?0epwgUvJ4KAaijF/aw6rozORMCdlR7UpdBJ58hbMsAP0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ffecc0-d496-46f7-18ba-08de01043f91
X-MS-Exchange-CrossTenant-AuthSource: VI0P195MB2739.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 16:04:49.3931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB1644

On 9/30/25 15:09, Linus Walleij wrote:
> On Thu, Sep 25, 2025 at 11:33 PM Franz-Josef Haider
> <fj.haider@outlook.com> wrote:
>
>> From 33ce5a26ef08199625bc5bb01a176047bfacff91 Mon Sep 17 00:00:00 2001
>> From: Franz-Josef Haider <fj.haider@outlook.com>
>> Date: Thu, 25 Sep 2025 22:14:07 +0300
>> Subject: [PATCH] ARM: Make sure CPU_ARM940T kernel can be built.
>>
>> Fixes build for this cpu type.
>>
>> Signed-off-by: Franz-Josef Haider <fj.haider@outlook.com>
> Please elaborate a bit on this change in the commit message.
>
> 1. What were you trying to do.
>
> 2. What stopped you from doing what you wanted to do.
>
> 3. Why did you do this change to the kernel to do what you wanted
>   to do.
>
> Should it not be:
> !CPU_ARM740T && !CPU_ARM946E && !CPU_ARM940T
> ?
>
> Yours,
> Linus Walleij
Hello, I have done this change because when trying to "select CPU_ARM940T" from a Kconfig for a device with arm940t cpu, the build ends up failing with errors like
            arch/arm/lib/ashldi3.S: Assembler messages:
            arch/arm/lib/ashldi3.S:44: Error: cannot honor width suffix -- `rsb ip,r2,#32'
            arch/arm/lib/ashldi3.S:45: Error: thumb conditional instruction should be in IT block -- `movmi r1,r1,lsl r2'
            arch/arm/lib/ashldi3.S:46: Error: thumb conditional instruction should be in IT block -- `movpl r1,r0,lsl r3'
            arch/arm/lib/ashldi3.S:48: Error: thumb conditional instruction should be in IT block -- `lsrmi r3,r0,ip'
            arch/arm/lib/ashldi3.S:49: Error: thumb conditional instruction should be in IT block -- `orrmi r1,r1,r3'
            arch/arm/lib/ashldi3.S:50: Error: cannot honor width suffix -- `mov r0,r0,lsl r2'
            arch/arm/lib/ashldi3.S:43: Error: immediate value out of range
            make[3]: *** [scripts/Makefile.build:430: arch/arm/lib/ashldi3.o] Error 1
            make[2]: *** [scripts/Makefile.build:556: arch/arm/lib] Error 2
            make[2]: *** Waiting for unfinished jobs....
With the change I am able to build a kernel which runs on a device with arm940t cpu (with the patch "ARM: Add missing mmu flags entry to arm940 proc info." which I've submitted as well. And with the necessary mach files etc).

I can elaborate on this in the commit message and also adjust the condition to include the other CPU types you mentioned.

Best regards and thank you,
Franz-Josef

