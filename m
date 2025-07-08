Return-Path: <linux-kernel+bounces-720695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D184AFBF54
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D642426C33
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30BA1DE3A5;
	Tue,  8 Jul 2025 00:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dfmwxtv/"
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011029.outbound.protection.outlook.com [52.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8041DB54C;
	Tue,  8 Jul 2025 00:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751935417; cv=fail; b=S5Wzs3YpdlU6rf52ZHnabAPqcNRCLuGlW8w9n3WhVTKQBs0s80Z5Fn33xWn48V3YVN+LmSsQMhE/6WWp7eSd1ANCUqpGHIz+8JeF7RZeoCYa5RURAXIo8ddn6paAeyP0yk/zeSau05ALyOOTY20TW3kRoQa1L+mZzhCI+QPjURw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751935417; c=relaxed/simple;
	bh=uUp+L2kCRZkrXoRCIyYwkc+oIFJ8q4gACHISVhtjhdc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jfnKUo+zvWKakHCE6iyQt5AJQIzVgIKDh/K8xV8/czVMTJYIoZNB7pgbFpIE5NoRn5gXzwlHkoozWRi8VXYIfHs68Degg5Nj0HoGl6GGVcIl9nBePh9MryepHCW10KX3GCiueHMAtVOVj7OAjMTl9lrTvtFyeqEoVICClNMRlss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dfmwxtv/; arc=fail smtp.client-ip=52.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5+l9ANhLOXKm+4ZbB63G+kiFxDxw3tJmtsG6pFZnEa7OonUM0FoXD2J4Xyy+y4cwqwsT1hSjDo2UD1orNxaX4jIGF6YHqPKbVCDNC5LkrCMFwKTiNr0PLbWIv9luS5z0cFQIPwDiR2uWlrtkYAiGo+rYP7ao+oVvumFfNpFiUPQ+P0fEnyU1tIxjdfDJTx3gvIqQgPRkOghkG8eefXfrfULSx48ov3/NZON4FwYKBx7CcDTF08IlcoLR56usG6gGTz7jayEbCkMY3Ovxler/RcJziA9HXH1rJmS7xCJNllhH5JQ1q2dSxVE/d7Ps9hFe9etUj8NhUypPacQy9gHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ulxThhPe8l4Ke0sCWubGv54iqg4D3DMV2vf8FO2BfI=;
 b=aWveWTJPeDqN6qJQI9HVYa0Q+8rlIrPwgtDiV27ebSS2JUJnO353VyhXEmUdMJKnHX0vKnUg/Dy3l3VpRQuBt/IOfVtosj7u0mJZ7DeNv5wvJim+hX6nES11gKkelYEXkd/Ga2U/snSe3zFWK2O6Kmmc0M1OlVXApDfNndzGKhASf9WSvRc1UWyKE339+CWIj5a012gqmwvRp/uMx3LUlsW/v7z/jQbbqShTMEO3NKmbXPqPzbryRB55aZh4oburn79EHS3eUUV+isU9eErXDESeWLEX6uunfsx1zcFcPwm58C7ClmlSWoLUL4fHeWq5vaYpqJguQXGOU1h3t4LS+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ulxThhPe8l4Ke0sCWubGv54iqg4D3DMV2vf8FO2BfI=;
 b=dfmwxtv/w2XzE/YsLnM3cmgPzKnvd7ZB6oCzPj6wPdMX0NlxZ145vzE8maGDBhcWq0wyMeeHtRCnL/ZChSDF0nK5HIEw3sPirsulXGvAMZCxSt7/nycm6JYmAPSZsfeAatOhkcesacCSO4MMS7y/5oAMwTuDWF8Ile+ySdCW8m4uKFOiGvMjh8kUQao/P4ByaMdX5AjL9IHSRTbAU7bBEFTfPPHvsrRgap5b4BychQso7TF3nnVCgf7eDrfhzRFTMuqlROTvUQFc8Dv1y1+nefkieg/W6qEIiaK0W6gVBc1QEWy4NUmclo2oWrc93t3pEMv7zFi/FIYsJ7PTiZIEGg==
Received: from PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2aa::8)
 by PN3PR01MB6376.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:87::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 00:43:28 +0000
Received: from PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7f30:f566:cb62:9b0c]) by PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7f30:f566:cb62:9b0c%7]) with mapi id 15.20.8835.018; Tue, 8 Jul 2025
 00:43:28 +0000
Message-ID:
 <PNYPR01MB111710E40AED0E1DE738CA44AFE4EA@PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 8 Jul 2025 08:43:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] riscv: dts: sophgo: add ziccrse for sg2042
To: Han Gao <rabenda.cn@gmail.com>, devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Inochi Amaoto <inochiama@gmail.com>, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1751698574.git.rabenda.cn@gmail.com>
 <859df9a05e1693fec9bd2c7dcf14415bb15230bd.1751698574.git.rabenda.cn@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <859df9a05e1693fec9bd2c7dcf14415bb15230bd.1751698574.git.rabenda.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0209.apcprd04.prod.outlook.com
 (2603:1096:4:187::12) To PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2aa::8)
X-Microsoft-Original-Message-ID:
 <846e7950-df00-4d92-8e94-172386ac22e9@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PNYPR01MB11171:EE_|PN3PR01MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: faeaf1c5-e41e-40a2-f647-08ddbdb8744a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|5072599009|461199028|6090799003|1602099012|3412199025|4302099013|440099028|40105399003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3YvcjNoYjdxNWNyMHJhdHRZa1JnQ2VINmlHM3d5Q1FLOGFNazZqd0VscWV6?=
 =?utf-8?B?Qy9BK0ZPT1BUQ204a1JLUkR4MndqOHJXcXUwZEkyUUcyMjJnZi9KcmxtenFU?=
 =?utf-8?B?Y2c1M3g0bDNnb1Qrc3FsTnh2VmUrMTJyUFpRdERoQ0FiL2VSVzhOUjI5Wng4?=
 =?utf-8?B?eDVBbmVId2xpQ1ZQU3k3a1U5QnRHZzE0Q3ZqZ1dmbFk1Y3hWSHNTblVVKzNZ?=
 =?utf-8?B?QXAvVnlMRVJhVmI3NmNkajUxV3J6TjRVL0hhUE9JYmtOMTlNSU1Db3NuZjBG?=
 =?utf-8?B?aEExKzJRNWI4MU5QUHl1NStudW52ZjVIV0t1QVRETVlVcEtRNC9jM3J5RzFV?=
 =?utf-8?B?TEx4TGJSWk51Y2k1NnZsU3BzdTVzR2tBcCtQcHNwbUFzSnVjUWFjZzVzRkJm?=
 =?utf-8?B?WGhFemtLTEtiOEk3NC85S29FM0FyTTJQem9vK2hyL2EwUCtoL3A0cktxeW1E?=
 =?utf-8?B?cFYyUjVHbEtzOXY4czJ3WE1qRDE2VXAwdm03TGtldnpDYkRkVkJyTmx1bmlP?=
 =?utf-8?B?S05jZ1JMYlArM2tacjVWSjZZSTNOOU0rSE0wUE8yUENjN3FmaUdFbWlJcjdo?=
 =?utf-8?B?a3NuaHoyMjFrRG1Va3JUSHBaNGRGbHJZTzE2Z1dWbEEvcmFPS1JoQ2ROYnhz?=
 =?utf-8?B?S2gwQU9GRCtGckVLSlo4YmsyU2dIWEhYc1FqdmJEOCtTL0YramJqVjE1MXlr?=
 =?utf-8?B?d0pxY2FCcDBLcnlhb0lSV0lvMlo1VXcxVXRCL3ZQREowblFKY3RvT1FJTHZX?=
 =?utf-8?B?VXQwK25rOW85eDQxU01JU25sK0dPZmUxRHpmZE82UVVkNVMxcXU2OEhJUXdN?=
 =?utf-8?B?NVZmYysyeGlVWWZiUXIxYW5hSmxqdHAzWm5PMWhrUUd2NGVxaWd1SDZ4Vmh3?=
 =?utf-8?B?Q0M2UEVyUmJ3TWlOdXBnb2pqR3BEZmVUSStGemtmK3JLd0tjVXlnUzZPeUpL?=
 =?utf-8?B?OW01YXo5VXR0SzludW1mcnVvWXBqWGx5ZXhDa1E0YzRqeU1NVlZRY2VHQk1z?=
 =?utf-8?B?ZmhOTGM5R3UyNlUwTmhmOTRoa1dMSktjL2g2aEhwZXFSSEwzRzVOVFBzekE2?=
 =?utf-8?B?VjdobWZGS1lTVUFCM08xaW9MWTNXTy9COXVhbjZIc1NZczc2L0JBcjNYTDZL?=
 =?utf-8?B?dU5ZekhTNENNcllRbXJiYVAxZGlzTWlKYW01c0ErVzA1c09FZ0RLMXQ4ODhm?=
 =?utf-8?B?VE1TbkpaMG14a0xvVHhCM3QwT20rU3YyZmJTcVY5dFlDSEVxY0RKM0lRdS9t?=
 =?utf-8?B?VVljdUxNb0pyd3RRT2JBSFNZVjYwYkNRZmZLU0ZLYTVOS1hyOEFnK1J3REtE?=
 =?utf-8?B?dERZb2JSYWszcThkSzZGdWZVTDFCbGZxeU83UnZ5Yk5KbEN1Q0RjelFzVURY?=
 =?utf-8?B?alAwaFFTZ0QyS25qcHdPYlgxbUtvNFhzRE1VRHZtWGtGcytnS3VqRTYycTJh?=
 =?utf-8?B?NXN6Z3RPNzY3d0FWL3BBNTNsQ2Y3b1JqaFNGNTNoZ1B5KzdXaldrMThKSU96?=
 =?utf-8?B?Y0dGMDdMUGxvMHV3VkVmbzdzczVqTU51UXJRdmdpSTNleTlGcHA3REZIei9F?=
 =?utf-8?B?R3RPNzFlSVAwWDY4SDFoaHJwd21UeHN2dExjWlU5TDZqMzExN09GdURKeTFG?=
 =?utf-8?B?TGpRcUlUS0VMdXJxZTV1ckJpUFZWZ3c9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SElDNkVVMnJrMFpHbFd5Z1g1S1JsWHFWaVgwTTc2QmJLK3haS3pDV1hqVE5Z?=
 =?utf-8?B?YkV2am92Z2xDRkR2Y3hqa1VWN3B0Vks5YWJINVVySldid0FEZTB5TFhXdmhq?=
 =?utf-8?B?cDFUQ2JFdWlhclE1NmNrUmc2dW5BbHpzZWtPOE9oT2lFakE0RVAwM0lJaHc2?=
 =?utf-8?B?TEZQTlducXRXRHE0STZrNGhWWi9xTWpPVm1mZytrY2IveUJCYzROb2EvUUpS?=
 =?utf-8?B?QzB0ZGlHZlphcEM3THB6Sk53V25ucnVEYmZoa1BzSEMyWTBiY1VQWklsN09B?=
 =?utf-8?B?LzZrM3JrM3Y1aTZRU3hndFNNU3VpS1hnNjMySlErdVg1M0svNVpCZDhrdFZu?=
 =?utf-8?B?UGlLZW0vS1hvR25sT2NncHpOaVlINWgrSEdTMTRXZStacHhvK3ErSWFBWXdn?=
 =?utf-8?B?VkNkaGpKOW1pWVVyRWdseFFmckkyMjhsM2lEM29WdG9SL1ZxT0EzQ2RPbTFQ?=
 =?utf-8?B?N3gwMEk3NVdOSjhRNVByQXYxQ1pPUUQwbUpIaUxqUGN5TDR3WUV6cHZRc0dt?=
 =?utf-8?B?VGZYOUlqNmFKTnM1ZVJEVENDVzlBRHdxSVVoQzc1WDYvbWpYc09aRTQyODhl?=
 =?utf-8?B?bzZqZ0NwMHFjWUk1b0E4dy9qRGZXK2dWL040eE5qU2E0YkV4SVNObFpPSzgw?=
 =?utf-8?B?dE4wcDF5L3FWTTAyRVQwcldybXNuOVlORHJHOHVxdnQ3dlViVHNGM3U0V2x1?=
 =?utf-8?B?ZFcydjR4bUg4eEJFYnY3S1A4ZFlqNzlTSmZkQlB6YmxWN0NZVGE1dWpKbkYr?=
 =?utf-8?B?ZW9LN3laZmJkQXNva3B2V2pRZ0JIMFo4MkE1TDdWNkZJeUxwRXdoMURNSTNy?=
 =?utf-8?B?cnpmOVRRVWI0MnZhaDJRK2NvSncwazY1azJabjZySHNtZVViSzVXOHdZYStl?=
 =?utf-8?B?SHR6OHZqTUJjamszN2poYisyTHUrNjhwMjFTWDJXV0QyeENOWXdtS2lIc0VU?=
 =?utf-8?B?cHZFazZFYzRuVlErWjEwZjJlNFZZcWMxd2hUNmZ5dnA4SmVSU3E2V0ZxVWJV?=
 =?utf-8?B?eFV0RUFzcVNiSDZEK3gvbk5ieEQzRTFDWStZTVFqbEphb2VGaHhSZzZva2hZ?=
 =?utf-8?B?R1lCSXVodis4cHlyVW9uV3lHUFYxbG01T1BrZ3VtWEtOOURaU3RkZHpyQ0xp?=
 =?utf-8?B?NkdTa1ZlejlGcU1QRWh4ZzhIa1dsQUN6VjJjc0I2SXBDUXJ3WE5YM3lQaDdI?=
 =?utf-8?B?WUJiZGhiQmtsYUtxS3pIQU9sVDN0d1E4WHJHYlJoUUVCUEZ4cFZ4ZDNuaXoz?=
 =?utf-8?B?QVE0Qm1EOWFvQ3M5UEVQYnk2UDlwd3R2WlBVVk84VlROcXVCdWdDRkpINmU1?=
 =?utf-8?B?MHA3WGZHbjBnOXRDbzNuUjh3K1ZuNWdsNkdrbVJNazNyeWdEdVFHVjNqaE0v?=
 =?utf-8?B?TDRaTW9xczFEcnVadUJWaUwwNGN5bkpSZW92ZkY1aGVjVWZ4ZzZtbHNnRFUy?=
 =?utf-8?B?U2ppR21ERHhjZWlkSkpwVkMvd002M3J4VEZkN0t0S3JvVTRsbTFkQXo3YzBZ?=
 =?utf-8?B?TVRaamVMTTJveG9uL3ROa0k4MUFpQmRXUUtZMFpCUllLa3FrVVpPc3FaTGF4?=
 =?utf-8?B?b2UyMTFybWJIcGZ1dDM5bFFSWDVSWmc1NTJRS2h6ZDFFL2lKQXhnWDBIUmlw?=
 =?utf-8?B?SFp2UFVWT3dNQ2Vxd0VFd2hqUzdheTFoVCszbTR3dk5TWkVpTENoZmdrc2l4?=
 =?utf-8?B?TDdQVzdBbis2bWN0dTlLRGQxbno4NlFlQ1kyQmlOK0IxUFR3U281ZG4wMWdL?=
 =?utf-8?Q?4r7lxMYzpwzz2WpMgqBOxAgIr+AWDagLUTXaJve?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faeaf1c5-e41e-40a2-f647-08ddbdb8744a
X-MS-Exchange-CrossTenant-AuthSource: PNYPR01MB11171.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 00:43:28.1710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6376


On 2025/7/5 15:00, Han Gao wrote:
> sg2042 support Ziccrse ISA extension [1].
>
> Link: https://lore.kernel.org/all/20241103145153.105097-12-alexghiti@rivosinc.com/ [1]
>
> Signed-off-by: Han Gao <rabenda.cn@gmail.com>
> Reviewed-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>   arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi | 320 ++++++++++++--------
>   1 file changed, 192 insertions(+), 128 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi b/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> index dcc984965b6b..f483f62ab0c4 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> @@ -259,8 +259,9 @@ cpu0: cpu@0 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <0>;
>   			i-cache-block-size = <64>;
> @@ -285,8 +286,9 @@ cpu1: cpu@1 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <1>;
>   			i-cache-block-size = <64>;
> @@ -311,8 +313,9 @@ cpu2: cpu@2 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <2>;
>   			i-cache-block-size = <64>;
> @@ -337,8 +340,9 @@ cpu3: cpu@3 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <3>;
>   			i-cache-block-size = <64>;
> @@ -363,8 +367,9 @@ cpu4: cpu@4 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <4>;
>   			i-cache-block-size = <64>;
> @@ -389,8 +394,9 @@ cpu5: cpu@5 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <5>;
>   			i-cache-block-size = <64>;
> @@ -415,8 +421,9 @@ cpu6: cpu@6 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <6>;
>   			i-cache-block-size = <64>;
> @@ -441,8 +448,9 @@ cpu7: cpu@7 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <7>;
>   			i-cache-block-size = <64>;
> @@ -467,8 +475,9 @@ cpu8: cpu@8 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <8>;
>   			i-cache-block-size = <64>;
> @@ -493,8 +502,9 @@ cpu9: cpu@9 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <9>;
>   			i-cache-block-size = <64>;
> @@ -519,8 +529,9 @@ cpu10: cpu@10 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <10>;
>   			i-cache-block-size = <64>;
> @@ -545,8 +556,9 @@ cpu11: cpu@11 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <11>;
>   			i-cache-block-size = <64>;
> @@ -571,8 +583,9 @@ cpu12: cpu@12 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <12>;
>   			i-cache-block-size = <64>;
> @@ -597,8 +610,9 @@ cpu13: cpu@13 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <13>;
>   			i-cache-block-size = <64>;
> @@ -623,8 +637,9 @@ cpu14: cpu@14 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <14>;
>   			i-cache-block-size = <64>;
> @@ -649,8 +664,9 @@ cpu15: cpu@15 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <15>;
>   			i-cache-block-size = <64>;
> @@ -675,8 +691,9 @@ cpu16: cpu@16 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <16>;
>   			i-cache-block-size = <64>;
> @@ -701,8 +718,9 @@ cpu17: cpu@17 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <17>;
>   			i-cache-block-size = <64>;
> @@ -727,8 +745,9 @@ cpu18: cpu@18 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <18>;
>   			i-cache-block-size = <64>;
> @@ -753,8 +772,9 @@ cpu19: cpu@19 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <19>;
>   			i-cache-block-size = <64>;
> @@ -779,8 +799,9 @@ cpu20: cpu@20 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <20>;
>   			i-cache-block-size = <64>;
> @@ -805,8 +826,9 @@ cpu21: cpu@21 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <21>;
>   			i-cache-block-size = <64>;
> @@ -831,8 +853,9 @@ cpu22: cpu@22 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <22>;
>   			i-cache-block-size = <64>;
> @@ -857,8 +880,9 @@ cpu23: cpu@23 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <23>;
>   			i-cache-block-size = <64>;
> @@ -883,8 +907,9 @@ cpu24: cpu@24 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <24>;
>   			i-cache-block-size = <64>;
> @@ -909,8 +934,9 @@ cpu25: cpu@25 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <25>;
>   			i-cache-block-size = <64>;
> @@ -935,8 +961,9 @@ cpu26: cpu@26 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <26>;
>   			i-cache-block-size = <64>;
> @@ -961,8 +988,9 @@ cpu27: cpu@27 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <27>;
>   			i-cache-block-size = <64>;
> @@ -987,8 +1015,9 @@ cpu28: cpu@28 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <28>;
>   			i-cache-block-size = <64>;
> @@ -1013,8 +1042,9 @@ cpu29: cpu@29 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <29>;
>   			i-cache-block-size = <64>;
> @@ -1039,8 +1069,9 @@ cpu30: cpu@30 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <30>;
>   			i-cache-block-size = <64>;
> @@ -1065,8 +1096,9 @@ cpu31: cpu@31 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <31>;
>   			i-cache-block-size = <64>;
> @@ -1091,8 +1123,9 @@ cpu32: cpu@32 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <32>;
>   			i-cache-block-size = <64>;
> @@ -1117,8 +1150,9 @@ cpu33: cpu@33 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <33>;
>   			i-cache-block-size = <64>;
> @@ -1143,8 +1177,9 @@ cpu34: cpu@34 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <34>;
>   			i-cache-block-size = <64>;
> @@ -1169,8 +1204,9 @@ cpu35: cpu@35 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <35>;
>   			i-cache-block-size = <64>;
> @@ -1195,8 +1231,9 @@ cpu36: cpu@36 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <36>;
>   			i-cache-block-size = <64>;
> @@ -1221,8 +1258,9 @@ cpu37: cpu@37 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <37>;
>   			i-cache-block-size = <64>;
> @@ -1247,8 +1285,9 @@ cpu38: cpu@38 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <38>;
>   			i-cache-block-size = <64>;
> @@ -1273,8 +1312,9 @@ cpu39: cpu@39 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <39>;
>   			i-cache-block-size = <64>;
> @@ -1299,8 +1339,9 @@ cpu40: cpu@40 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <40>;
>   			i-cache-block-size = <64>;
> @@ -1325,8 +1366,9 @@ cpu41: cpu@41 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <41>;
>   			i-cache-block-size = <64>;
> @@ -1351,8 +1393,9 @@ cpu42: cpu@42 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <42>;
>   			i-cache-block-size = <64>;
> @@ -1377,8 +1420,9 @@ cpu43: cpu@43 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <43>;
>   			i-cache-block-size = <64>;
> @@ -1403,8 +1447,9 @@ cpu44: cpu@44 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <44>;
>   			i-cache-block-size = <64>;
> @@ -1429,8 +1474,9 @@ cpu45: cpu@45 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <45>;
>   			i-cache-block-size = <64>;
> @@ -1455,8 +1501,9 @@ cpu46: cpu@46 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <46>;
>   			i-cache-block-size = <64>;
> @@ -1481,8 +1528,9 @@ cpu47: cpu@47 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <47>;
>   			i-cache-block-size = <64>;
> @@ -1507,8 +1555,9 @@ cpu48: cpu@48 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <48>;
>   			i-cache-block-size = <64>;
> @@ -1533,8 +1582,9 @@ cpu49: cpu@49 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <49>;
>   			i-cache-block-size = <64>;
> @@ -1559,8 +1609,9 @@ cpu50: cpu@50 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <50>;
>   			i-cache-block-size = <64>;
> @@ -1585,8 +1636,9 @@ cpu51: cpu@51 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <51>;
>   			i-cache-block-size = <64>;
> @@ -1611,8 +1663,9 @@ cpu52: cpu@52 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <52>;
>   			i-cache-block-size = <64>;
> @@ -1637,8 +1690,9 @@ cpu53: cpu@53 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <53>;
>   			i-cache-block-size = <64>;
> @@ -1663,8 +1717,9 @@ cpu54: cpu@54 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <54>;
>   			i-cache-block-size = <64>;
> @@ -1689,8 +1744,9 @@ cpu55: cpu@55 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <55>;
>   			i-cache-block-size = <64>;
> @@ -1715,8 +1771,9 @@ cpu56: cpu@56 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <56>;
>   			i-cache-block-size = <64>;
> @@ -1741,8 +1798,9 @@ cpu57: cpu@57 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <57>;
>   			i-cache-block-size = <64>;
> @@ -1767,8 +1825,9 @@ cpu58: cpu@58 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <58>;
>   			i-cache-block-size = <64>;
> @@ -1793,8 +1852,9 @@ cpu59: cpu@59 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <59>;
>   			i-cache-block-size = <64>;
> @@ -1819,8 +1879,9 @@ cpu60: cpu@60 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <60>;
>   			i-cache-block-size = <64>;
> @@ -1845,8 +1906,9 @@ cpu61: cpu@61 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <61>;
>   			i-cache-block-size = <64>;
> @@ -1871,8 +1933,9 @@ cpu62: cpu@62 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <62>;
>   			i-cache-block-size = <64>;
> @@ -1897,8 +1960,9 @@ cpu63: cpu@63 {
>   			riscv,isa = "rv64imafdc";
>   			riscv,isa-base = "rv64i";
>   			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> -					       "zicntr", "zicsr", "zifencei",
> -					       "zihpm", "xtheadvector";
> +					       "ziccrse", "zicntr", "zicsr",
> +					       "zifencei", "zihpm",
> +					       "xtheadvector";
>   			thead,vlenb = <16>;
>   			reg = <63>;
>   			i-cache-block-size = <64>;

