Return-Path: <linux-kernel+bounces-877894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCC4C1F48E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B3964E8A42
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2839F33B6FD;
	Thu, 30 Oct 2025 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="QEEGR4uk"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022142.outbound.protection.outlook.com [40.107.75.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618E22F12A0;
	Thu, 30 Oct 2025 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816491; cv=fail; b=B+/hrt7TABVKakscOlyJ6iNY1M/7MhrZZVPa9fsegZxjl9P4eB5tHW25s70lfm+CwEEtHJKhJNvRLaf50eKt1BVd+821cJlAXGHs5103F6nRTAn+HSu5z11cUertqbU182bJqXmOvIu01IUkGROxA5SaXbt+lOdXROghg4OIuDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816491; c=relaxed/simple;
	bh=OL5g1vGA2Ucc08H7wH2edymkvWXaL8wWrvwEs32HJLs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c1L1/IwcQxPYwbzIqg4qrMT+ZMxJI2TABgO/8YvtI9XMQ9BTGJDBaNu94n+uHUIPgjdTqYCyIPMFRwuuI/4lc4WByb0l8IrZ5B4mV58a3/5c+WpLiRI7mxY8+cjWbRnirkVvTJdBkE6WxTotjywX+qx75K7pWpjZu6fNiOk5cVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=QEEGR4uk; arc=fail smtp.client-ip=40.107.75.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naA/e2/vgqzQGVcdZL59n7CQBVzkJzUuxoZIxWTaJ/98fte2nTGhe6uyrnEpgSWdX8jiarV3U2GOhvPha3wjup0Pt7HjLyJrMagztNsE+/l4riY6MIXb8obfQKWr3E+B6PhThpMD+qifXBDAURocyxQKLqTV+ILtWm+SZWejcI4C1PbU1UxU73KmRH+a6Bzd2VCqUsZwUGH0unUAVpVF4lAN9O2UakpA7sZJWBgx+UWFNhlpiISFwC4Omw7E6mNJmx4ZTozei+kDSv8T8TwO/tZjPd00nevhV0lt3zMMUWZRocA+gbmC9GjkMepiEQZW31MXSB8sEuWHDrI/E+l7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ki+QqNF0G/FkEzCU35+YAKUyGzHz/X5qArb2X9sfW2E=;
 b=HlLTXgaRrw0V/R/ZAJJIxMrhtWFAwzRdVOU+zgvUZamBgkiLqx8oTKAhcYX2AEBEFXHiqSxeezoJylNhlU5ISvui9qtIfJU2VxRJM0vWVvM2qQcShjUg2WnzdIEUYSEAHcsugkTsiJvubLr6xfKmefoc2Gx7sW1arZUdn2Lr1jS7mKb5OIkBsRU2QPpsDwaEIOeIhDS9TJXKFprtKybg9DqNWji52ZkTFms9c2E2898e/qLyQ69Yp2OVhI/Gw2jcjn9Ba3CXvZXKPiIz6kG5t4oMfclZ8rhZ6HD2aL/FTJROD2RmQ0gkiN1sONpcGpW9LGQN3rEGyI6+jc9vDmA/WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ki+QqNF0G/FkEzCU35+YAKUyGzHz/X5qArb2X9sfW2E=;
 b=QEEGR4ukqFYurykUYRgMtXs3GIFIAN300TObrtZ/f4goig5SijTwRiLaNXs5JbMWNg+/zCJ0phvCQN7Mn7Q/19B2r/0yNGzXLLr82kRjWAOUdbWlu7HYrwfTAACsrwwmEocDRmYyMQtJByWTOKNCLFTxB5s2ZY4fzKsaUWL+VqtTzPAfKfwONdzVkUl6sJaqHoky+bSHo33aq9i5RGGpozVQzuvLZOqa7HJCGVc8pK5dKeB9DKM/y8dZ6dxx+81jt8vw4Luu/LsFhEI8/+93385OBQ5KFI/z+J2e93c9YE2coIocPhHkRRyZaMchQ7BI6GfMbrc0jqMlojWzPEsYeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by SEZPR03MB8830.apcprd03.prod.outlook.com (2603:1096:101:255::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 30 Oct
 2025 09:28:03 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 09:28:03 +0000
Message-ID: <7e95df48-8f27-47ab-a5e8-5bc0777d41b9@amlogic.com>
Date: Thu, 30 Oct 2025 17:27:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] clk: amlogic: Change the active level of l_detect
To: Jerome Brunet <jbrunet@baylibre.com>,
 Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 da@libre.computer
References: <20251030-optimize_pll_driver-v2-0-37273f5b25ab@amlogic.com>
 <20251030-optimize_pll_driver-v2-5-37273f5b25ab@amlogic.com>
 <1j4irgzss4.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1j4irgzss4.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|SEZPR03MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee806e4-0984-4217-817e-08de1796a04b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmIyZnZjRkY4SlNXaUlNT2RWS2tsZHF6K1NMbStPTTBlUzQzaUFnVlQrVTR3?=
 =?utf-8?B?SHVvc242Ui9jVlpSaWEzQjhqVmZ0dENFbHdjTnVrY1p4THFtanBkdmVrYXgx?=
 =?utf-8?B?SnNCcVhYcEh2cnlOMFBnZHY3UFlnZFBvTUoxTk44N0xhRlNNQmwvS1NWNGZR?=
 =?utf-8?B?MzZhRjltajE4RERLMFZXcTlRQWVOYnovRCtNWXlDa09RbS9lNkI3NXpXYWxO?=
 =?utf-8?B?dHk3Qnc4Ky9tUUFJS2txdlNCWG1YblpuVTdmdEdPaFgwQ2RHM1FrZGpFT2Nx?=
 =?utf-8?B?aVltV0h2RC9qc0Zla2pXcVI0MENqeXFXNGdWVE13SnFMd3V3OWUyZUk3WEVE?=
 =?utf-8?B?d3p1NDdUaWFQWFBlckFGZEZnd1ZYS0xMdTU3SnB4UytNS0MycnRvOC9rKzlY?=
 =?utf-8?B?dVVjRnhxeUwzT3pDamgzamNGeFRKeGU1Z3RBeTRyMjBaNDAxd0VCSkJzcnEv?=
 =?utf-8?B?b3pvOE5EVC9HRjd2SlMrcm1Vc013eE9ZemZNNWJSUFZTeDFtQk92ZUdWR2w5?=
 =?utf-8?B?eTF5c1JWblBUWjJpRW95dEJsVGlkQ2xnWnpYZTA2Zmlxbjd1OXVJTnN0ZGhW?=
 =?utf-8?B?SUQ2SnVNNllzb1RGZVZBR3F6TTRTYjJ5cGNnUlNUa1VIUnJIaVpxTTlwdENv?=
 =?utf-8?B?WEdIMkZHWVRRU210eTk0ektkU0tHdmFSYnlnRU1QOVJrdUVmL2FMaENpcVBr?=
 =?utf-8?B?K2dxSUNtRk9WUnQycVdRVVJnMmo2eHltbnd0S3h6TVRqclFxMnoveGRzZ1ZP?=
 =?utf-8?B?SlAwRk5GOUV1MDNwMlBuVnE4cFdiSFNmZ21sbVkrQmd3V3BYN2QvY3dkUjVG?=
 =?utf-8?B?ejlHdzZqS2k4a3FIc1E3Nk9WK1FXRkgwR1FpSkhkOFpQcDQ2dElDY21EMkZj?=
 =?utf-8?B?ekM0MDcwcDlKZGQrTndRTXpwVERHb2tJYUJ1V3p5MTBhcWFtZ0VXekJEdXpt?=
 =?utf-8?B?ZWthZ0o4SVpWQnlhMmVuMnJPTnhyYjdrdEcxYlJhRTluTmNHOE14TUFBOHVl?=
 =?utf-8?B?WlZZaFVuaEZ0YktTNHBUbFdsT1hWcjljRytqQS9XemZnNnNVWTNFNmFSdTcx?=
 =?utf-8?B?aUVoTC96R3lzNStYVFBlMDFyUTY1Q0FWa2ZFTkRMamFoWFVBYVh5N1FFU3h1?=
 =?utf-8?B?ZnlPMkpKcENpcXRBU0NnMERMaC94WlpySWluTUlWRkVtbkpuT1hjTGZHYWJC?=
 =?utf-8?B?My9ua1lkUTcxY003Zi93ZmFJMUd6S0wzWU0zRC85ekpzQ3NjSVZUam44QUYx?=
 =?utf-8?B?K25uVE1HM2lUcUNKUFJFKzVJa3hWMVFiTmVtZEpBU3A2alNFREYwWkdYVWVF?=
 =?utf-8?B?MHgwemdNTDBHSDJGaEQ1dncweFkraStvbFE1b2pObHp3SFZYUlNBOEduM2N5?=
 =?utf-8?B?UWQyaDlWK3AwdVQvUWhlRTVWbTF3ZHJqaFdSdGxmaUVaTW5oYXdJTTlKdVFl?=
 =?utf-8?B?YVY2YVNQcmkwYmp3SnhPaGsvTWkrLzNsdks3QnRXZCtyTU14L2V5akI4Szl0?=
 =?utf-8?B?NmdRazBtL1hKQWdnWnluNVFqYlBHRXZpY1czWGNOWXBYOG5YYzVTVlZaNWFQ?=
 =?utf-8?B?emgwWDY2bElRa3VuVTQ1VWhPZkZIVHhHaWdiS1EvSU91RUFlTldEdkpyRW44?=
 =?utf-8?B?cUVoU00zY0pBK3JocFBORld5MDd0NHJoeXM5Ymp4Nzc2VzlKYjZXTDF3WWpH?=
 =?utf-8?B?aXExY2Y4Q3RZWE9YMk9IWGU5NTRWNDhwaGRsaWYzQmwyc1hldHdhZ0tHM0ZY?=
 =?utf-8?B?aVF4UWtjL3RpSVRrQVEyQmN2S0RHVTVBemxXckx6MWZPSmVxR0M0V1pacHYr?=
 =?utf-8?B?Ym5YVklFa2NGOTdZNHhBNEp3aW01SjFBdUIwbEFaL1dWN3FXYVpPTHUzMjhE?=
 =?utf-8?B?TUttRUVJREUvelpwcXFUellqeWh3VCtEUWNsTGtKUzlCL2NrYUhXSjBleFBu?=
 =?utf-8?Q?5yEVK66usaensZh42Ip9JYXoWnyKLPho?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0hDdmRKb0h2ZHNKZ3pxcnlqMzJlaUZWMVdWa0Z0NGZxcHFGWVo2MlIrWDRp?=
 =?utf-8?B?YmRhMHMzaVkwd0Q0dWdyODZEeS9UYlEzVlBsOUhhMlE3bGIwRVVrRFAvblVX?=
 =?utf-8?B?cFQ2T1Z6N1o5Zi8xSVNDUmJSbm5RTVBKdC9TeDdJREk4alpONDhIQ2hteHZo?=
 =?utf-8?B?ZFZad1ZKTU1ZcG9Ma2dLWmVwbnhhZ3FJUFZtM001NzJsNzZmdjFaQ1VEZU5R?=
 =?utf-8?B?QkowQ1lFYUtKODZqb2UrN0JDK3M3VWpCcjcrb2JyNUZmZy9aUmMvczRUUGRm?=
 =?utf-8?B?bHBUS3dOQm9Lc1g4UzRQd01QZTZtdGtxOU9nejNhdDc1RkpRemV6ckFaZ1BS?=
 =?utf-8?B?anJiV1lveitZL1BralJwdHNNZlpDUDVOUW8yS1hGMDF4Vm9mS01oWEFFcEp4?=
 =?utf-8?B?N2JpWmxnUGNFaG8xWFU5Mnl6elRiZzRkRXU0RmNKalBTck5Jd1puU2EvOEUx?=
 =?utf-8?B?NG5GY2RycVQ3ZjJSY0t2WGVyRTJRMXhhYzRIQ0JDYXNUUXJBM0NtaFdpQlgv?=
 =?utf-8?B?NnkvZVNpMkxZdE4xeFVsZGx0TEhIdEUvWlhHNzRJTnBvQ1dTL1hLM1dtdXRD?=
 =?utf-8?B?eHpYQ2x0dXlUSEl4V3gxTVFLMFNNTGhweXk1WlN4MnpLbUlWSERpOW4zUFND?=
 =?utf-8?B?RzkrT2F4eTMwanVvT2VxWC9QWmM0WmlIY1VTVmh0UTNNc0swUytxZ29xVWlv?=
 =?utf-8?B?SGRVL1ptU09aMnlLcysxaXh0NS91bWlwV1RDWU9BUEJ0K0JJNGR5WUN2TEVz?=
 =?utf-8?B?SVpseGE1SFl0ZVUwTUJjN0lKMmVKRUR5SFVHZUhkWVZNUFhxUjU4Ny96Q3pZ?=
 =?utf-8?B?R0kyMUFsaWRJNmJ0YnRVSzVOK295ZDQ4SkZrVjZ3c1BDRnRRak5QUzVkTzNo?=
 =?utf-8?B?cnRDSEkzU0RhVjQ2bGttOGdQZTRSRUpKdkoxOFJzUGMvclhVTnlybjFqRFhn?=
 =?utf-8?B?cEtGcVpXSUZjOFRJLys4bWdqZjJmMzRpdlNaZ2R4d2d4ckZvZW01UkFlaEFu?=
 =?utf-8?B?ZjJra2poQ3RuYm5qMzNhTFpTQ3oyWTY2UmNsZStJVjY5bldJemtRRWtwYVht?=
 =?utf-8?B?VkVPNzRWcmJtLy9zSG1mMnFHdTB1T2lKNjFkVFBIaUlYM0tLSXNDSUVxRERa?=
 =?utf-8?B?QjBxaGRGZDdkY1Z6UTZDQnQxU3M3MVdlZy9DNWo0MW1ZSENia3J5QnZNSUJI?=
 =?utf-8?B?dittbU9DUEhTZWNGUmxrVllTY3I4YWhRWENMUUt6R3pUYVFXck1JYUF5Yjl0?=
 =?utf-8?B?MUtqK1BOUExBa3lXUHYxRFdEa2VGQXlGMjl3VlAvem5lKzA3SmU1eWVtWVZ1?=
 =?utf-8?B?U0Y5RXJTaGhnbmFHNmU0T0RJd2xYZWJVL0FaR015YmgzSVVsVEhSd01UZTV6?=
 =?utf-8?B?UHgzZzBOMHZ1TWhZK2QzL2QwQlRROVdwM0haKzl2SDhLck84Y09XSTZsa1BM?=
 =?utf-8?B?NG5wY3BhWjc4VFlRRnFrNWM2bys2aWVqazdKelRXbWlBU1piN3VOcDJ2WWNI?=
 =?utf-8?B?TzNsMTZWYmplbTJQbWljMVBJMXVYRWNtLyswdFZhaHdLa3cyQm5vcHJ0SXlq?=
 =?utf-8?B?SmI2Uno2TlFDTURVdG5VM0dmcXdYTTl3VzVmd09JcEFVck1sRVFGeVVDTGpr?=
 =?utf-8?B?bFh4U3lrZ1BRS0J2YTd4RXBIZFBKYVF2WlZnVWRBeFo1VHd1eEhqYmFmK2s2?=
 =?utf-8?B?WVhvbkRKK09PcDk0bXo3M2xaVW5QY2thL2N6Zi9yV3N2b1dScHVZRHNiTy9s?=
 =?utf-8?B?SWh0VGJobjRmNUlXdjVCUWFvck94UjV5bEdvenE0L3VLVVdKNmpJamdDTWdn?=
 =?utf-8?B?RmNvOU9pNXpoR1lmaDRIZzJJditDb3QvV25QbldnYlg2WkFhYmxuSnJsWHVL?=
 =?utf-8?B?TmhHVjJnU1p1emFOTURKamJzcmJzb1I0QzNCYzdpMDZPelZVN3ZhczNWUWlK?=
 =?utf-8?B?cEt4ZVZwUmdjc0FqbWNJSmpHOVlKUFVVN25OYUlHdTBkMG56d3M5WTNRelNT?=
 =?utf-8?B?dnZmREIrakFISXAzSzZERVRuTlR0bEFZVm45RTdoeTRnajdkM0J5R0FaNzBH?=
 =?utf-8?B?dUozbHg0NXZpK3p5b0hlajhrUlJINkxSMDJ6VGhZclNsUm5hUzUxVTlYWlFn?=
 =?utf-8?Q?hc+aPNDECYSa2NqE2ecRGIoIw?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee806e4-0984-4217-817e-08de1796a04b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 09:28:03.7385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YN+SbX8EoWZAWbf2BD2UjNcBAyDniYloNfRhEcpKXSHu7cBuqpx/4yH5JhhbIfUKyz5cUK3/5qviHiz9PM/xvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8830

Hi Jerome,

On 10/30/2025 4:40 PM, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Thu 30 Oct 2025 at 13:24, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
> 
>> From: Chuan Liu <chuan.liu@amlogic.com>
>>
>> l_detect controls the enable/disable of the PLL lock-detect module.
>>
>> The enable signal is normally active-high. This design ensures that
>> the module remains disabled during the power-on process, preventing
>> power fluctuations from affecting its operating state.
>>
>> For A1, the l_detect signal is active-low:
>> 0 -> Enable lock-detect module;
>> 1 -> Disable lock-detect module.
>>
>> Here, a flag CLK_MESON_PLL_L_DETECT_N is added to handle cases like
>> A1, where the signal is active-low.
> 
> Given that A1 is the only ship supporting l_detect, this change is not
> necessary.
> 
> Not now at least.
> 

The SoCs queued for upstreaming later will depend on this patch, so I
included it in this patchset.

If that’s not appropriate, would it be acceptable for me to include
it in the A4 submission instead?

>>
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> ---
>>   drivers/clk/meson/a1-pll.c  |  1 +
>>   drivers/clk/meson/clk-pll.c | 16 ++++++++++++----
>>   drivers/clk/meson/clk-pll.h |  2 ++
>>   3 files changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
>> index 1f82e9c7c14e..bfe559c71402 100644
>> --- a/drivers/clk/meson/a1-pll.c
>> +++ b/drivers/clk/meson/a1-pll.c
>> @@ -137,6 +137,7 @@ static struct clk_regmap a1_hifi_pll = {
>>                .range = &a1_hifi_pll_range,
>>                .init_regs = a1_hifi_pll_init_regs,
>>                .init_count = ARRAY_SIZE(a1_hifi_pll_init_regs),
>> +             .flags = CLK_MESON_PLL_L_DETECT_N
>>        },
>>        .hw.init = &(struct clk_init_data){
>>                .name = "hifi_pll",
>> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
>> index c6eebde1f516..d729e933aa1c 100644
>> --- a/drivers/clk/meson/clk-pll.c
>> +++ b/drivers/clk/meson/clk-pll.c
>> @@ -384,8 +384,12 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
>>                meson_parm_write(clk->map, &pll->rst, 1);
>>
>>        /* Disable the PLL lock-detect module */
>> -     if (MESON_PARM_APPLICABLE(&pll->l_detect))
>> -             meson_parm_write(clk->map, &pll->l_detect, 1);
>> +     if (MESON_PARM_APPLICABLE(&pll->l_detect)) {
>> +             if (pll->flags & CLK_MESON_PLL_L_DETECT_N)
>> +                     meson_parm_write(clk->map, &pll->l_detect, 1);
>> +             else
>> +                     meson_parm_write(clk->map, &pll->l_detect, 0);
>> +     }
>>
>>        /* Enable the pll */
>>        meson_parm_write(clk->map, &pll->en, 1);
>> @@ -413,8 +417,12 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
>>        udelay(20);
>>
>>        /* Enable the lock-detect module */
>> -     if (MESON_PARM_APPLICABLE(&pll->l_detect))
>> -             meson_parm_write(clk->map, &pll->l_detect, 0);
>> +     if (MESON_PARM_APPLICABLE(&pll->l_detect)) {
>> +             if (pll->flags & CLK_MESON_PLL_L_DETECT_N)
>> +                     meson_parm_write(clk->map, &pll->l_detect, 0);
>> +             else
>> +                     meson_parm_write(clk->map, &pll->l_detect, 1);
>> +     }
>>
>>        if (meson_clk_pll_wait_lock(hw)) {
>>                /* disable PLL when PLL lock failed. */
>> diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
>> index 949157fb7bf5..83295a24721f 100644
>> --- a/drivers/clk/meson/clk-pll.h
>> +++ b/drivers/clk/meson/clk-pll.h
>> @@ -29,6 +29,8 @@ struct pll_mult_range {
>>
>>   #define CLK_MESON_PLL_ROUND_CLOSEST  BIT(0)
>>   #define CLK_MESON_PLL_NOINIT_ENABLED BIT(1)
>> +/* l_detect signal is active-low */
>> +#define CLK_MESON_PLL_L_DETECT_N     BIT(2)
>>
>>   struct meson_clk_pll_data {
>>        struct parm en;
> 
> --
> Jerome


